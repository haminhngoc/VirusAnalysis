

  
PAGE  59,132
  
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;ÛÛ								         ÛÛ
;ÛÛ			        MAXIHD				         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛ      Created:   1-Jan-80					         ÛÛ
;ÛÛ      Passes:    5	       Analysis Flags on: H		         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
  
DATA_1E		EQU	74H			; (0000:0074=0A4H)
DATA_2E		EQU	78H			; (0000:0078=22H)
DATA_3E		EQU	7CH			; (0000:007C=0)
DATA_4E		EQU	80H			; (0000:0080=0F5H)
DATA_5E		EQU	84H			; (0000:0084=9CEH)
DATA_6E		EQU	86H			; (0000:0086=13C7H)
DATA_7E		EQU	88H			; (0000:0088=723H)
DATA_8E		EQU	8AH			; (0000:008A=23EAH)
DATA_9E		EQU	8CH			; (0000:008C=0A70H)
DATA_10E	EQU	8EH			; (0000:008E=23EAH)
DATA_11E	EQU	94H			; (0000:0094=192FH)
DATA_12E	EQU	98H			; (0000:0098=198CH)
DATA_13E	EQU	9AH			; (0000:009A=27DH)
DATA_14E	EQU	9EH			; (0000:009E=27DH)
DATA_15E	EQU	232H			; (0000:0232=0)
DATA_16E	EQU	234H			; (0000:0234=0)
DATA_17E	EQU	236H			; (0000:0236=0)
DATA_18E	EQU	23CH			; (0000:023C=0)
DATA_19E	EQU	458H			; (0000:0458=0)
DATA_20E	EQU	45AH			; (0000:045A=0)
DATA_21E	EQU	464H			; (0000:0464=2903H)
DATA_22E	EQU	4A4H			; (0000:04A4=0)
DATA_23E	EQU	4A6H			; (0000:04A6=0)
DATA_24E	EQU	4A8H			; (0000:04A8=0)
DATA_25E	EQU	2			; (7FC4:0002=0)
DATA_26E	EQU	2CH			; (7FC4:002C=0)
DATA_27E	EQU	94H			; (7FC4:0094=0)
DATA_28E	EQU	9EH			; (7FC4:009E=0)
DATA_29E	EQU	1D6H			; (7FC4:01D6=0CD57H)
DATA_30E	EQU	1D8H			; (7FC4:01D8=21H)
DATA_31E	EQU	232H			; (7FC4:0232=2FB9H)
DATA_32E	EQU	37EH			; (7FC4:037E=50FFH)
DATA_33E	EQU	3A6H			; (7FC4:03A6=8D50H)
DATA_34E	EQU	3A8H			; (7FC4:03A8=0AE46H)
DATA_35E	EQU	4A4H			; (7FC4:04A4=0AC26H)
DATA_36E	EQU	4A6H			; (7FC4:04A6=8C40H)
DATA_37E	EQU	4A8H			; (7FC4:04A8=87C5H)
DATA_123E	EQU	0FF67H			; (8134:FF67=0)
DATA_124E	EQU	0FF70H			; (8134:FF70=0)
DATA_126E	EQU	0FF6AH			; (817F:FF6A=0)
DATA_127E	EQU	0FF6CH			; (817F:FF6C=0)
DATA_128E	EQU	0FF6EH			; (817F:FF6E=0)
DATA_129E	EQU	0FF6FH			; (817F:FF6F=0)
DATA_130E	EQU	0FF70H			; (817F:FF70=0)
DATA_131E	EQU	0FF72H			; (817F:FF72=0)
DATA_132E	EQU	0FF75H			; (817F:FF75=0)
DATA_133E	EQU	0FF76H			; (817F:FF76=0)
DATA_134E	EQU	0FF78H			; (817F:FF78=0)
DATA_135E	EQU	0FF7BH			; (817F:FF7B=0)
DATA_136E	EQU	0FF7CH			; (817F:FF7C=0)
  
;--------------------------------------------------------------	SEG_A  ----
  
SEG_A		SEGMENT	PARA PUBLIC
		ASSUME CS:SEG_A , DS:SEG_A , SS:STACK_SEG_C
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
SUB_1		PROC	NEAR
SUB_1		ENDP
  
  
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;
;			PROGRAM ENTRY POINT
;
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
  
  
MAXIHD		PROC	FAR
  
start:
		MOV	DX,SEG SEG_B
		MOV	CS:DATA_38,DX		; (7FD4:01F8=0)
		MOV	AH,30H			; '0'
		INT	21H			; DOS Services  ah=function 30h
						;  get DOS version number ax
		MOV	BP,DS:DATA_25E		; (7FC4:0002=0)
		MOV	BX,DS:DATA_26E		; (7FC4:002C=0)
		MOV	DS,DX
		assume	ds:SEG_B
		MOV	DATA_77,AX		; (8134:0092=0)
		MOV	DATA_76,ES		; (8134:0090=0)
		MOV	WORD PTR DATA_73+2,BX	; (8134:008C=0)
		MOV	DATA_84,BP		; (8134:00AC=0)
		MOV	DATA_79,0FFFFH		; (8134:0096=0)
		CALL	SUB_3			; (0162)
		LES	DI,DATA_73		; (8134:008A=0) Load 32 bit ptr
		MOV	AX,DI
		MOV	BX,AX
		MOV	CX,7FFFH
LOC_2:
		CMP	WORD PTR ES:[DI],3738H
		JNE	LOC_3			; Jump if not equal
		MOV	DX,ES:[DI+2]
		CMP	DL,3DH			; '='
		JNE	LOC_3			; Jump if not equal
		AND	DH,0DFH
		INC	DATA_79			; (8134:0096=0)
		CMP	DH,59H			; 'Y'
		JNE	LOC_3			; Jump if not equal
		INC	DATA_79			; (8134:0096=0)
LOC_3:
		REPNE	SCASB			; Rept zf=0+cx>0 Scan es:[di] for al
		JCXZ	LOC_6			; Jump if cx=0
		INC	BX
		CMP	ES:[DI],AL
		JNE	LOC_2			; Jump if not equal
		OR	CH,80H
		NEG	CX
		MOV	WORD PTR DATA_73,CX	; (8134:008A=0)
		MOV	CX,1
		SHL	BX,CL			; Shift w/zeros fill
		ADD	BX,8
		AND	BX,0FFF8H
		MOV	DATA_75,BX		; (8134:008E=0)
		MOV	DX,DS
		SUB	BP,DX
		MOV	DI,DATA_89		; (8134:023A=1000H)
		CMP	DI,200H
		JAE	LOC_4			; Jump if above or =
		MOV	DI,200H
		MOV	DATA_89,DI		; (8134:023A=1000H)
LOC_4:
		ADD	DI,4AAH
		JC	LOC_6			; Jump if carry Set
		ADD	DI,DATA_88		; (8134:0238=0)
		JC	LOC_6			; Jump if carry Set
		MOV	CL,4
		SHR	DI,CL			; Shift w/zeros fill
		INC	DI
		CMP	BP,DI
		JB	LOC_6			; Jump if below
		CMP	DATA_89,0		; (8134:023A=1000H)
		JE	LOC_5			; Jump if equal
		CMP	DATA_88,0		; (8134:0238=0)
		JNE	LOC_7			; Jump if not equal
LOC_5:
		MOV	DI,1000H
		CMP	BP,DI
		JA	LOC_7			; Jump if above
		MOV	DI,BP
		JMP	SHORT LOC_7		; (00C1)
LOC_6:
		JMP	LOC_10			; (01E2)
LOC_7:
		MOV	BX,DI
		ADD	BX,DX
		MOV	DATA_82,BX		; (8134:00A4=0)
		MOV	DATA_83,BX		; (8134:00A8=0)
		MOV	AX,DATA_76		; (8134:0090=0)
		SUB	BX,AX
		MOV	ES,AX
		MOV	AH,4AH			; 'J'
		PUSH	DI
		INT	21H			; DOS Services  ah=function 4Ah
						;  change mem allocation, bx=siz
		POP	DI
		SHL	DI,CL			; Shift w/zeros fill
		CLI				; Disable interrupts
		MOV	SS,DX
		MOV	SP,DI
		STI				; Enable interrupts
		XOR	AX,AX			; Zero register
		MOV	ES,CS:DATA_38		; (7FD4:01F8=0)
		MOV	DI,464H
		MOV	CX,4AAH
		SUB	CX,DI
		REP	STOSB			; Rep while cx>0 Store al to es:[di]
		PUSH	CS
		CALL	WORD PTR DATA_117	; (8134:0456=1D2H)
		CALL	SUB_12			; (0390)
		CALL	SUB_14			; (047B)
		MOV	AH,0
		INT	1AH			; Real time clock   ah=func 00h
						;  get system timer count cx,dx
		MOV	DS:DATA_12E,DX		; (0000:0098=198CH)
		MOV	DS:DATA_13E,CX		; (0000:009A=27DH)
		CALL	WORD PTR DS:DATA_20E	; (0000:045A=0)
		PUSH	WORD PTR DS:DATA_7E	; (0000:0088=723H)
		PUSH	WORD PTR DS:DATA_6E	; (0000:0086=13C7H)
		PUSH	WORD PTR DS:DATA_5E	; (0000:0084=9CEH)
		CALL	SUB_6			; (01FA)
		PUSH	AX
		CALL	SUB_11			; (035B)
  
MAXIHD		ENDP
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
SUB_2		PROC	NEAR
		MOV	DS,CS:DATA_38		; (7FD4:01F8=0)
		CALL	SUB_4			; (01A5)
		PUSH	CS
		CALL	WORD PTR DS:DATA_19E	; (0000:0458=0)
		XOR	AX,AX			; Zero register
		MOV	SI,AX
		MOV	CX,2FH
		NOP
		CLD				; Clear direction
  
LOCLOOP_8:
		ADD	AL,[SI]
		ADC	AH,0
		INC	SI
		LOOP	LOCLOOP_8		; Loop if cx > 0
  
		SUB	AX,0D37H
		NOP
		JZ	LOC_9			; Jump if zero
		MOV	CX,19H
		NOP
		MOV	DX,2FH
		CALL	SUB_5			; (01DA)
LOC_9:
		MOV	BP,SP
		MOV	AH,4CH			; 'L'
		MOV	AL,[BP+2]
		INT	21H			; DOS Services  ah=function 4Ch
						;  terminate with al=return code
SUB_2		ENDP
  
  
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;
;			External Entry Point
;
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
  
INT_00H_ENTRY	PROC	FAR
		MOV	CX,0EH
		NOP
		MOV	DX,48H
		JMP	LOC_11			; (01E9)
INT_00H_ENTRY	ENDP
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
SUB_3		PROC	NEAR
		PUSH	DS
		MOV	AX,3500H
		INT	21H			; DOS Services  ah=function 35h
						;  get intrpt vector al in es:bx
		MOV	DATA_65,BX		; (8134:0074=0)
		MOV	DATA_66,ES		; (8134:0076=0)
		MOV	AX,3504H
		INT	21H			; DOS Services  ah=function 35h
						;  get intrpt vector al in es:bx
		MOV	DATA_67,BX		; (8134:0078=0)
		MOV	DATA_68,ES		; (8134:007A=0)
		MOV	AX,3505H
		INT	21H			; DOS Services  ah=function 35h
						;  get intrpt vector al in es:bx
		MOV	DATA_69,BX		; (8134:007C=0)
		MOV	DATA_70,ES		; (8134:007E=0)
		MOV	AX,3506H
		INT	21H			; DOS Services  ah=function 35h
						;  get intrpt vector al in es:bx
		MOV	DATA_71,BX		; (8134:0080=0)
		MOV	DATA_72,ES		; (8134:0082=0)
		MOV	AX,2500H
		MOV	DX,CS
		MOV	DS,DX
		MOV	DX,158H
		INT	21H			; DOS Services  ah=function 25h
						;  set intrpt vector al to ds:dx
		POP	DS
		RETN
SUB_3		ENDP
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
SUB_4		PROC	NEAR
		PUSH	DS
		MOV	AX,2500H
		LDS	DX,DWORD PTR DS:DATA_1E	; (0000:0074=0F0A4H) Load 32 bit ptr
		INT	21H			; DOS Services  ah=function 25h
						;  set intrpt vector al to ds:dx
		POP	DS
		PUSH	DS
		MOV	AX,2504H
		LDS	DX,DWORD PTR DS:DATA_2E	; (0000:0078=522H) Load 32 bit ptr
		INT	21H			; DOS Services  ah=function 25h
						;  set intrpt vector al to ds:dx
		POP	DS
		PUSH	DS
		MOV	AX,2505H
		LDS	DX,DWORD PTR DS:DATA_3E	; (0000:007C=0) Load 32 bit ptr
		INT	21H			; DOS Services  ah=function 25h
						;  set intrpt vector al to ds:dx
		POP	DS
		PUSH	DS
		MOV	AX,2506H
		LDS	DX,DWORD PTR DS:DATA_4E	; (0000:0080=16F5H) Load 32 bit ptr
		INT	21H			; DOS Services  ah=function 25h
						;  set intrpt vector al to ds:dx
		POP	DS
		RETN
SUB_4		ENDP
  
		DB	0C7H, 6, 96H, 0, 0, 0
		DB	0CBH, 0C3H
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
SUB_5		PROC	NEAR
		MOV	AH,40H			; '@'
		MOV	BX,2
		INT	21H			; DOS Services  ah=function 40h
						;  write file cx=bytes, to ds:dx
		RETN
SUB_5		ENDP
  
LOC_10:
		MOV	CX,1EH
		NOP
		MOV	DX,56H
LOC_11:
		MOV	DS,CS:DATA_38		; (7FD4:01F8=0)
		CALL	SUB_5			; (01DA)
		MOV	AX,3
		PUSH	AX
		CALL	SUB_2			; (0121)
DATA_38		DW	0
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
SUB_6		PROC	NEAR
		PUSH	BP
		MOV	BP,SP
		MOV	AX,194H
		PUSH	AX
		CALL	SUB_8			; (0290)
		POP	CX
		MOV	AX,194H
		PUSH	AX
		CALL	SUB_7			; (0212)
		POP	CX
		CALL	SUB_9			; (02F5)
		POP	BP
		RETN
SUB_6		ENDP
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
SUB_7		PROC	NEAR
		PUSH	BP
		MOV	BP,SP
		SUB	SP,0AEH
		PUSH	SI
		PUSH	DI
		MOV	DI,[BP+4]
		PUSH	DI
		CALL	SUB_8			; (0290)
		POP	CX
		MOV	AX,19BH
		PUSH	AX
		PUSH	DI
		MOV	AX,195H
		PUSH	AX
		LEA	AX,[BP-82H]		; Load effective addr
		PUSH	AX
		CALL	SUB_51			; (1571)
		ADD	SP,8
		MOV	AX,10H
		PUSH	AX
		LEA	AX,[BP-0AEH]		; Load effective addr
		PUSH	AX
		LEA	AX,[BP-82H]		; Load effective addr
		PUSH	AX
		CALL	SUB_49			; (150B)
		ADD	SP,6
		MOV	SI,AX
		JMP	SHORT LOC_14		; (0286)
LOC_12:
		CMP	BYTE PTR SS:DATA_124E[BP],2EH	; (8134:FF70=0) '.'
		JE	LOC_13			; Jump if equal
		TEST	BYTE PTR SS:DATA_123E[BP],10H	; (8134:FF67=0)
		JZ	LOC_13			; Jump if zero
		LEA	AX,[BP-90H]		; Load effective addr
		PUSH	AX
		PUSH	DI
		MOV	AX,195H
		PUSH	AX
		LEA	AX,[BP-82H]		; Load effective addr
		PUSH	AX
		CALL	SUB_51			; (1571)
		ADD	SP,8
		LEA	AX,[BP-82H]		; Load effective addr
		PUSH	AX
		CALL	SUB_7			; (0212)
		POP	CX
LOC_13:
		LEA	AX,[BP-0AEH]		; Load effective addr
		PUSH	AX
		CALL	SUB_50			; (152D)
		POP	CX
		MOV	SI,AX
LOC_14:
		OR	SI,SI			; Zero ?
		JZ	LOC_12			; Jump if zero
		POP	DI
		POP	SI
		MOV	SP,BP
		POP	BP
		RETN
SUB_7		ENDP
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
SUB_8		PROC	NEAR
		PUSH	BP
		MOV	BP,SP
		SUB	SP,7EH
		PUSH	SI
		PUSH	WORD PTR [BP+4]
		LEA	AX,[BP-52H]		; Load effective addr
		PUSH	AX
		CALL	SUB_33			; (0B88)
		POP	CX
		POP	CX
		MOV	AX,19FH
		PUSH	AX
		LEA	AX,[BP-52H]		; Load effective addr
		PUSH	AX
		CALL	SUB_32			; (0B4C)
		POP	CX
		POP	CX
		XOR	AX,AX			; Zero register
		PUSH	AX
		LEA	AX,[BP-7EH]		; Load effective addr
		PUSH	AX
		LEA	AX,[BP-52H]		; Load effective addr
		PUSH	AX
		CALL	SUB_49			; (150B)
		ADD	SP,6
		MOV	SI,AX
		JMP	SHORT LOC_16		; (02EC)
LOC_15:
		LEA	AX,[BP-60H]		; Load effective addr
		PUSH	AX
		PUSH	WORD PTR [BP+4]
		MOV	AX,195H
		PUSH	AX
		LEA	AX,[BP-52H]		; Load effective addr
		PUSH	AX
		CALL	SUB_51			; (1571)
		ADD	SP,8
		LEA	AX,[BP-52H]		; Load effective addr
		PUSH	AX
		CALL	SUB_31			; (0B34)
		POP	CX
		LEA	AX,[BP-7EH]		; Load effective addr
		PUSH	AX
		CALL	SUB_50			; (152D)
		POP	CX
		MOV	SI,AX
LOC_16:
		OR	SI,SI			; Zero ?
		JZ	LOC_15			; Jump if zero
		POP	SI
		MOV	SP,BP
		POP	BP
		RETN
SUB_8		ENDP
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
SUB_9		PROC	NEAR
		PUSH	BP
		MOV	BP,SP
		SUB	SP,4
		MOV	AX,1A4H
		PUSH	AX
		PUSH	WORD PTR [BP-2]
		CALL	SUB_48			; (14F3)
		POP	CX
		POP	CX
		PUSH	WORD PTR [BP-4]
		XOR	AX,AX			; Zero register
		PUSH	AX
		MOV	AX,0CH
		PUSH	AX
		MOV	AX,2
		PUSH	AX
		CALL	SUB_52			; (15D4)
		ADD	SP,8
		MOV	SP,BP
		POP	BP
		RETN
SUB_9		ENDP
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
SUB_10		PROC	NEAR
		PUSH	BP
		MOV	BP,SP
		PUSH	SI
		MOV	SI,[BP+4]
		OR	SI,SI			; Zero ?
		JL	LOC_19			; Jump if < cmp="" si,58h="" jbe="" loc_18="" ;="" jump="" if="" below="" or="LOC_17:" mov="" si,57h="" loc_18:="" mov="" ds:data_29e,si="" ;="" (7fc4:01d6="0CD57H)" mov="" al,ds:data_30e[si]="" ;="" (7fc4:01d8="21H)" cbw="" ;="" convrt="" byte="" to="" word="" xchg="" ax,si="" jmp="" short="" loc_20="" ;="" (034b)="" loc_19:="" neg="" si="" cmp="" si,23h="" ja="" loc_17="" ;="" jump="" if="" above="" mov="" word="" ptr="" ds:data_29e,0ffffh="" ;="" (7fc4:01d6="0CD57H)" loc_20:="" mov="" ax,si="" mov="" ds:data_27e,ax="" ;="" (7fc4:0094="0)" mov="" ax,0ffffh="" jmp="" short="" loc_21="" ;="" (0355)="" loc_21:="" pop="" si="" pop="" bp="" retn="" 2="" sub_10="" endp="" db="" 0c3h="" ;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß="" ;="" subroutine="" ;üüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüü="" sub_11="" proc="" near="" push="" bp="" mov="" bp,sp="" jmp="" short="" loc_23="" ;="" (036a)="" loc_22:="" mov="" bx,word="" ptr="" ds:[23ch]="" ;="" (7fc4:023c="0E246H)" shl="" bx,1="" ;="" shift="" w/zeros="" fill="" call="" word="" ptr="" ds:[464h][bx]="" ;*(7fc4:0464="0E3D1H)" loc_23:="" mov="" ax,word="" ptr="" ds:[23ch]="" ;="" (7fc4:023c="0E246H)" dec="" word="" ptr="" ds:[23ch]="" ;="" (7fc4:023c="0E246H)" or="" ax,ax="" ;="" zero="" jnz="" loc_22="" ;="" jump="" if="" not="" zero="" call="" word="" ptr="" ds:data_31e="" ;="" (7fc4:0232="2FB9H)" call="" word="" ptr="" ds:[234h]="" ;="" (7fc4:0234="9000H)" call="" word="" ptr="" ds:[236h]="" ;="" (7fc4:0236="2FCH)" push="" word="" ptr="" [bp+4]="" call="" sub_2="" ;="" (0121)="" pop="" cx="" pop="" bp="" retn="" sub_11="" endp="" data_39="" dw="" 0="" data_40="" dw="" 0="" db="" 0,="" 0="" ;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß="" ;="" subroutine="" ;üüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüü="" sub_12="" proc="" near="" pop="" cs:data_39="" ;="" (7fd4:038a="0)" mov="" cs:data_40,ds="" ;="" (7fd4:038c="0)" cld="" ;="" clear="" direction="" mov="" es,data_76="" ;="" (8134:0090="0)" mov="" si,80h="" xor="" ah,ah="" ;="" zero="" register="" lods="" byte="" ptr="" es:[si]="" ;="" string="" [si]="" to="" al="" inc="" ax="" mov="" bp,es="" xchg="" dx,si="" xchg="" ax,bx="" mov="" si,word="" ptr="" data_73="" ;="" (8134:008a="0)" add="" si,2="" mov="" cx,1="" cmp="" byte="" ptr="" data_77,3="" ;="" (8134:0092="0)" jb="" loc_24="" ;="" jump="" if="" below="" mov="" es,word="" ptr="" data_73+2="" ;="" (8134:008c="0)" mov="" di,si="" mov="" cl,7fh="" xor="" al,al="" ;="" zero="" register="" repne="" scasb="" ;="" rept="" zf="0+cx">0 Scan es:[di] for al
		JCXZ	LOC_32			; Jump if cx=0
		XOR	CL,7FH
LOC_24:
		SUB	SP,2
		MOV	AX,1
		ADD	AX,BX
		ADD	AX,CX
		AND	AX,0FFFEH
		MOV	DI,SP
		SUB	DI,AX
		JC	LOC_32			; Jump if carry Set
		MOV	SP,DI
		MOV	AX,ES
		MOV	DS,AX
		MOV	AX,SS
		MOV	ES,AX
		PUSH	CX
		DEC	CX
		REP	MOVSB			; Rep while cx>0 Mov [si] to es:[di]
		XOR	AL,AL			; Zero register
		STOSB				; Store al to es:[di]
		MOV	DS,BP
		XCHG	SI,DX
		XCHG	BX,CX
		MOV	AX,BX
		MOV	DX,AX
		INC	BX
LOC_25:
		CALL	SUB_13			; (0419)
		JA	LOC_27			; Jump if above
LOC_26:
		JC	LOC_33			; Jump if carry Set
		CALL	SUB_13			; (0419)
		JA	LOC_26			; Jump if above
LOC_27:
		CMP	AL,20H			; ' '
		JE	LOC_28			; Jump if equal
		CMP	AL,0DH
		JE	LOC_28			; Jump if equal
		CMP	AL,9
		JNE	LOC_25			; Jump if not equal
LOC_28:
		XOR	AL,AL			; Zero register
		JMP	SHORT LOC_25		; (03FD)
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
SUB_13:
		OR	AX,AX			; Zero ?
		JZ	LOC_29			; Jump if zero
		INC	DX
		STOSB				; Store al to es:[di]
		OR	AL,AL			; Zero ?
		JNZ	LOC_29			; Jump if not zero
		INC	BX
LOC_29:
		XCHG	AH,AL
		XOR	AL,AL			; Zero register
		STC				; Set carry flag
		JCXZ	LOC_RET_31		; Jump if cx=0
		LODSB				; String [si] to al
		DEC	CX
		SUB	AL,22H			; '"'
		JZ	LOC_RET_31		; Jump if zero
		ADD	AL,22H			; '"'
		CMP	AL,5CH			; '\'
		JNE	LOC_30			; Jump if not equal
		CMP	BYTE PTR [SI],22H	; '"'
		JNE	LOC_30			; Jump if not equal
		LODSB				; String [si] to al
		DEC	CX
LOC_30:
		OR	SI,SI			; Zero ?
  
LOC_RET_31:
		RETN
LOC_32:
		JMP	LOC_10			; (01E2)
LOC_33:
		POP	CX
		ADD	CX,DX
		MOV	DS,CS:DATA_40		; (7FD4:038C=0)
		MOV	DS:DATA_5E,BX		; (0000:0084=9CEH)
		INC	BX
		ADD	BX,BX
		MOV	SI,SP
		MOV	BP,SP
		SUB	BP,BX
		JC	LOC_32			; Jump if carry Set
		MOV	SP,BP
		MOV	DS:DATA_6E,BP		; (0000:0086=13C7H)
LOC_34:
		JCXZ	LOC_36			; Jump if cx=0
		MOV	[BP],SI
		ADD	BP,2
  
LOCLOOP_35:
		LODS	BYTE PTR SS:[SI]	; String [si] to al
		OR	AL,AL			; Zero ?
		LOOPNZ	LOCLOOP_35		; Loop if zf=0, cx>0
  
		JZ	LOC_34			; Jump if zero
LOC_36:
		XOR	AX,AX			; Zero register
		MOV	[BP],AX
		JMP	CS:DATA_39		; (7FD4:038A=0)
SUB_12		ENDP
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
SUB_14		PROC	NEAR
		MOV	CX,DS:DATA_8E		; (0000:008A=23EAH)
		PUSH	CX
		CALL	SUB_19			; (05CA)
		POP	CX
		MOV	DI,AX
		OR	AX,AX			; Zero ?
		JZ	LOC_37			; Jump if zero
		PUSH	DS
		PUSH	DS
		POP	ES
		MOV	DS,DS:DATA_9E		; (0000:008C=0A70H)
		XOR	SI,SI			; Zero register
		CLD				; Clear direction
		REP	MOVSB			; Rep while cx>0 Mov [si] to es:[di]
		POP	DS
		MOV	DI,AX
		PUSH	ES
		PUSH	WORD PTR DS:DATA_10E	; (0000:008E=23EAH)
		CALL	SUB_19			; (05CA)
		ADD	SP,2
		MOV	BX,AX
		POP	ES
		MOV	DS:DATA_7E,AX		; (0000:0088=723H)
		OR	AX,AX			; Zero ?
		JNZ	LOC_38			; Jump if not zero
LOC_37:
		JMP	LOC_10			; (01E2)
LOC_38:
		XOR	AX,AX			; Zero register
		MOV	CX,0FFFFH
LOC_39:
		MOV	[BX],DI
		ADD	BX,2
		REPNE	SCASB			; Rept zf=0+cx>0 Scan es:[di] for al
		CMP	ES:[DI],AL
		JNE	LOC_39			; Jump if not equal
		MOV	[BX],AX
		RETN
SUB_14		ENDP
  
		DB	55H, 8BH, 0ECH, 83H, 3EH, 3CH
		DB	2, 20H, 75H, 5, 0B8H, 1
		DB	0, 0EBH, 15H, 8BH, 46H, 4
		DB	8BH, 1EH, 3CH, 2, 0D1H, 0E3H
		DB	89H, 87H, 64H, 4, 0FFH, 6
		DB	3CH, 2, 33H, 0C0H, 0EBH, 0
LOC_40:
		POP	BP
		RETN
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
SUB_15		PROC	NEAR
		PUSH	BP
		MOV	BP,SP
		PUSH	SI
		PUSH	DI
		MOV	DI,[BP+4]
		MOV	AX,[DI+6]
		MOV	DS:DATA_23E,AX		; (0000:04A6=0)
		CMP	AX,DI
		JNE	LOC_41			; Jump if not equal
		MOV	WORD PTR DS:DATA_23E,0	; (0000:04A6=0)
		JMP	SHORT LOC_42		; (0515)
LOC_41:
		MOV	SI,[DI+4]
		MOV	BX,DS:DATA_23E		; (0000:04A6=0)
		MOV	[BX+4],SI
		MOV	AX,DS:DATA_23E		; (0000:04A6=0)
		MOV	[SI+6],AX
LOC_42:
		POP	DI
		POP	SI
		POP	BP
		RETN
SUB_15		ENDP
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
SUB_16		PROC	NEAR
		PUSH	BP
		MOV	BP,SP
		PUSH	SI
		PUSH	DI
		MOV	DI,[BP+4]
		MOV	AX,[BP+6]
		SUB	[DI],AX
		MOV	SI,[DI]
		ADD	SI,DI
		MOV	AX,[BP+6]
		INC	AX
		MOV	[SI],AX
		MOV	[SI+2],DI
		MOV	AX,DS:DATA_22E		; (0000:04A4=0)
		CMP	AX,DI
		JNE	LOC_43			; Jump if not equal
		MOV	DS:DATA_22E,SI		; (0000:04A4=0)
		JMP	SHORT LOC_44		; (0548)
LOC_43:
		MOV	DI,SI
		ADD	DI,[BP+6]
		MOV	[DI+2],SI
LOC_44:
		MOV	AX,SI
		ADD	AX,4
		JMP	SHORT LOC_45		; (054F)
LOC_45:
		POP	DI
		POP	SI
		POP	BP
		RETN
SUB_16		ENDP
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
SUB_17		PROC	NEAR
		PUSH	BP
		MOV	BP,SP
		PUSH	SI
		MOV	AX,[BP+4]
		XOR	DX,DX			; Zero register
		AND	AX,0FFFFH
		AND	DX,0
		nop				;*Fixup for MASM (M)
		PUSH	DX
		PUSH	AX
		CALL	SUB_21			; (065C)
		POP	CX
		POP	CX
		MOV	SI,AX
		CMP	SI,0FFFFH
		JNE	LOC_46			; Jump if not equal
		XOR	AX,AX			; Zero register
		JMP	SHORT LOC_47		; (058D)
LOC_46:
		MOV	AX,DS:DATA_22E		; (0000:04A4=0)
		MOV	[SI+2],AX
		MOV	AX,[BP+4]
		INC	AX
		MOV	[SI],AX
		MOV	DS:DATA_22E,SI		; (0000:04A4=0)
		MOV	AX,DS:DATA_22E		; (0000:04A4=0)
		ADD	AX,4
		JMP	SHORT LOC_47		; (058D)
LOC_47:
		POP	SI
		POP	BP
		RETN
SUB_17		ENDP
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
SUB_18		PROC	NEAR
		PUSH	BP
		MOV	BP,SP
		PUSH	SI
		MOV	AX,[BP+4]
		XOR	DX,DX			; Zero register
		AND	AX,0FFFFH
		AND	DX,0
		nop				;*Fixup for MASM (M)
		PUSH	DX
		PUSH	AX
		CALL	SUB_21			; (065C)
		POP	CX
		POP	CX
		MOV	SI,AX
		CMP	SI,0FFFFH
		JNE	LOC_48			; Jump if not equal
		XOR	AX,AX			; Zero register
		JMP	SHORT LOC_49		; (05C7)
LOC_48:
		MOV	DS:DATA_24E,SI		; (0000:04A8=0)
		MOV	DS:DATA_22E,SI		; (0000:04A4=0)
		MOV	AX,[BP+4]
		INC	AX
		MOV	[SI],AX
		MOV	AX,SI
		ADD	AX,4
		JMP	SHORT LOC_49		; (05C7)
LOC_49:
		POP	SI
		POP	BP
		RETN
SUB_18		ENDP
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
SUB_19		PROC	NEAR
		PUSH	BP
		MOV	BP,SP
		PUSH	SI
		PUSH	DI
		MOV	DI,[BP+4]
		OR	DI,DI			; Zero ?
		JNZ	LOC_50			; Jump if not zero
		XOR	AX,AX			; Zero register
		JMP	SHORT LOC_56		; (0634)
LOC_50:
		MOV	AX,DI
		ADD	AX,0BH
		AND	AX,0FFF8H
		MOV	DI,AX
		CMP	WORD PTR DS:DATA_24E,0	; (0000:04A8=0)
		JNE	LOC_51			; Jump if not equal
		PUSH	DI
		CALL	SUB_18			; (0590)
		POP	CX
		JMP	SHORT LOC_56		; (0634)
LOC_51:
		MOV	SI,DS:DATA_23E		; (0000:04A6=0)
		MOV	AX,SI
		OR	AX,AX			; Zero ?
		JZ	LOC_55			; Jump if zero
LOC_52:
		MOV	AX,[SI]
		MOV	DX,DI
		ADD	DX,28H
		CMP	AX,DX
		JB	LOC_53			; Jump if below
		PUSH	DI
		PUSH	SI
		CALL	SUB_16			; (0519)
		POP	CX
		POP	CX
		JMP	SHORT LOC_56		; (0634)
LOC_53:
		MOV	AX,[SI]
		CMP	AX,DI
		JB	LOC_54			; Jump if below
		PUSH	SI
		CALL	SUB_15			; (04EB)
		POP	CX
		INC	WORD PTR [SI]
		MOV	AX,SI
		ADD	AX,4
		JMP	SHORT LOC_56		; (0634)
LOC_54:
		MOV	SI,[SI+6]
		CMP	SI,DS:DATA_23E		; (0000:04A6=0)
		JNE	LOC_52			; Jump if not equal
LOC_55:
		PUSH	DI
		CALL	SUB_17			; (0553)
		POP	CX
		JMP	SHORT LOC_56		; (0634)
LOC_56:
		POP	DI
		POP	SI
		POP	BP
		RETN
SUB_19		ENDP
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
SUB_20		PROC	NEAR
		PUSH	BP
		MOV	BP,SP
		MOV	AX,[BP+4]
		MOV	DX,SP
		SUB	DX,100H
		CMP	AX,DX
		JAE	LOC_57			; Jump if above or =
		MOV	DS:DATA_28E,AX		; (7FC4:009E=0)
		XOR	AX,AX			; Zero register
		JMP	SHORT LOC_58		; (065A)
LOC_57:
		MOV	WORD PTR DS:DATA_27E,8	; (7FC4:0094=0)
		MOV	AX,0FFFFH
		JMP	SHORT LOC_58		; (065A)
LOC_58:
		POP	BP
		RETN
SUB_20		ENDP
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
SUB_21		PROC	NEAR
		PUSH	BP
		MOV	BP,SP
		MOV	AX,[BP+4]
		MOV	DX,[BP+6]
		ADD	AX,DS:DATA_14E		; (0000:009E=27DH)
		ADC	DX,0
		MOV	CX,AX
		ADD	CX,100H
		ADC	DX,0
		OR	DX,DX			; Zero ?
		JNZ	LOC_59			; Jump if not zero
		CMP	CX,SP
		JAE	LOC_59			; Jump if above or =
		XCHG	AX,DS:DATA_14E		; (0000:009E=27DH)
		JMP	SHORT LOC_60		; (068E)
LOC_59:
		MOV	WORD PTR DS:DATA_11E,8	; (0000:0094=192FH)
		MOV	AX,0FFFFH
		JMP	SHORT LOC_60		; (068E)
LOC_60:
		POP	BP
		RETN
SUB_21		ENDP
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
SUB_22		PROC	NEAR
		PUSH	BP
		MOV	BP,SP
		PUSH	WORD PTR [BP+4]
		CALL	SUB_20			; (0638)
		POP	CX
		JMP	SHORT LOC_61		; (069C)
LOC_61:
		POP	BP
		RETN
SUB_22		ENDP
  
		DB	55H, 8BH, 0ECH, 8BH, 46H, 4
		DB	99H, 52H, 50H, 0E8H, 0B2H, 0FFH
		DB	8BH, 0E5H, 0EBH, 0, 5DH, 0C3H
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
SUB_23		PROC	NEAR
		PUSH	BP
		MOV	BP,SP
		SUB	SP,2
		PUSH	SI
		PUSH	DI
		MOV	BX,[BP+4]
		MOV	SI,[BX]
		MOV	AX,SI
		MOV	[BP-2],AX
		MOV	BX,[BP+4]
		TEST	WORD PTR [BX+2],40H
		JZ	LOC_62			; Jump if zero
		MOV	AX,SI
		JMP	SHORT LOC_65		; (06EF)
LOC_62:
		MOV	BX,[BP+4]
		MOV	DI,[BX+0AH]
		JMP	SHORT LOC_64		; (06E3)
LOC_63:
		MOV	BX,DI
		INC	DI
		CMP	BYTE PTR [BX],0AH
		JNE	LOC_64			; Jump if not equal
		INC	WORD PTR [BP-2]
LOC_64:
		MOV	AX,SI
		DEC	SI
		OR	AX,AX			; Zero ?
		JNZ	LOC_63			; Jump if not zero
		MOV	AX,[BP-2]
		JMP	SHORT LOC_65		; (06EF)
LOC_65:
		POP	DI
		POP	SI
		MOV	SP,BP
		POP	BP
		RETN	2
SUB_23		ENDP
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
SUB_24		PROC	NEAR
		PUSH	BP
		MOV	BP,SP
		PUSH	SI
		MOV	SI,[BP+4]
		PUSH	SI
		CALL	SUB_34			; (0BEE)
		POP	CX
		OR	AX,AX			; Zero ?
		JZ	LOC_66			; Jump if zero
		MOV	AX,0FFFFH
		JMP	SHORT LOC_70		; (0758)
LOC_66:
		CMP	WORD PTR [BP+0AH],1
		JNE	LOC_67			; Jump if not equal
		CMP	WORD PTR [SI],0
		JLE	LOC_67			; Jump if < or="PUSH" si="" call="" sub_23="" ;="" (06b0)="" cwd="" ;="" word="" to="" double="" word="" sub="" [bp+6],ax="" sbb="" [bp+8],dx="" loc_67:="" and="" word="" ptr="" [si+2],0fe5fh="" mov="" word="" ptr="" [si],0="" mov="" ax,[si+8]="" mov="" [si+0ah],ax="" push="" word="" ptr="" [bp+0ah]="" push="" word="" ptr="" [bp+8]="" push="" word="" ptr="" [bp+6]="" mov="" al,[si+4]="" cbw="" ;="" convrt="" byte="" to="" word="" push="" ax="" call="" sub_29="" ;="" (0a1e)="" add="" sp,8="" cmp="" dx,0ffffh="" jne="" loc_68="" ;="" jump="" if="" not="" equal="" cmp="" ax,0ffffh="" jne="" loc_68="" ;="" jump="" if="" not="" equal="" mov="" ax,0ffffh="" jmp="" short="" loc_69="" ;="" (0756)="" loc_68:="" xor="" ax,ax="" ;="" zero="" register="" loc_69:="" jmp="" short="" loc_70="" ;="" (0758)="" loc_70:="" pop="" si="" pop="" bp="" retn="" sub_24="" endp="" db="" 55h,="" 8bh,="" 0ech,="" 83h,="" 0ech,="" 4="" db="" 56h,="" 8bh,="" 76h,="" 4,="" 56h,="" 0e8h="" db="" 85h,="" 4,="" 59h,="" 0bh,="" 0c0h,="" 74h="" db="" 8,="" 0bah,="" 0ffh,="" 0ffh,="" 0b8h,="" 0ffh="" db="" 0ffh,="" 0ebh,="" 3fh,="" 0b8h,="" 1,="" 0="" db="" 50h,="" 33h,="" 0c0h,="" 50h,="" 50h,="" 8ah="" db="" 44h,="" 4,="" 98h,="" 50h,="" 0e8h,="" 98h="" db="" 2,="" 83h,="" 0c4h,="" 8,="" 89h,="" 56h="" db="" 0feh,="" 89h,="" 46h,="" 0fch,="" 83h,="" 3ch="" db="" 0,="" 7eh,="" 19h,="" 8bh,="" 56h,="" 0feh="" db="" 8bh,="" 46h,="" 0fch,="" 52h,="" 50h,="" 56h="" db="" 0e8h,="" 10h,="" 0ffh,="" 99h,="" 8bh,="" 0d8h="" db="" 8bh,="" 0cah,="" 58h,="" 5ah,="" 2bh,="" 0c3h="" db="" 1bh,="" 0d1h,="" 0ebh,="" 6="" loc_71:="" mov="" dx,[bp-2]="" mov="" ax,[bp-4]="" loc_72:="" jmp="" short="" loc_73="" ;="" (07b5)="" loc_73:="" pop="" si="" mov="" sp,bp="" pop="" bp="" retn="" ;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß="" ;="" subroutine="" ;üüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüü="" sub_25="" proc="" near="" push="" bp="" mov="" bp,sp="" mov="" ax,4400h="" mov="" bx,[bp+4]="" int="" 21h="" ;="" dos="" services="" ah="function" 44h="" ;="" device="" drivr="" cntrl="" al="subfunc" mov="" ax,0="" jc="" loc_74="" ;="" jump="" if="" carry="" set="" shl="" dx,1="" ;="" shift="" w/zeros="" fill="" rcl="" ax,1="" ;="" rotate="" thru="" carry="" loc_74:="" jmp="" short="" loc_75="" ;="" (07d0)="" loc_75:="" pop="" bp="" retn="" sub_25="" endp="" ;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß="" ;="" subroutine="" ;üüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüü="" sub_26="" proc="" near="" push="" bp="" mov="" bp,sp="" push="" si="" push="" di="" mov="" di,[bp+0ah]="" mov="" si,[bp+4]="" mov="" ax,[si+0eh]="" cmp="" ax,si="" jne="" loc_76="" ;="" jump="" if="" not="" equal="" cmp="" word="" ptr="" [bp+8],2="" jg="" loc_76="" ;="" jump="" if="">
		CMP	DI,7FFFH
		JBE	LOC_77			; Jump if below or =
LOC_76:
		MOV	AX,0FFFFH
		JMP	LOC_85			; (08A0)
LOC_77:
		CMP	WORD PTR DS:DATA_34E,0	; (7FC4:03A8=0AE46H)
		JNE	LOC_78			; Jump if not equal
		MOV	AX,24EH
		CMP	AX,SI
		JNE	LOC_78			; Jump if not equal
		MOV	WORD PTR DS:DATA_34E,1	; (7FC4:03A8=0AE46H)
		JMP	SHORT LOC_79		; (0820)
LOC_78:
		CMP	WORD PTR DS:DATA_33E,0	; (7FC4:03A6=8D50H)
		JNE	LOC_79			; Jump if not equal
		MOV	AX,23EH
		CMP	AX,SI
		JNE	LOC_79			; Jump if not equal
		MOV	WORD PTR DS:DATA_33E,1	; (7FC4:03A6=8D50H)
LOC_79:
		CMP	WORD PTR [SI],0
		JE	LOC_80			; Jump if equal
		MOV	AX,1
		PUSH	AX
		XOR	AX,AX			; Zero register
		PUSH	AX
		PUSH	AX
		PUSH	SI
		CALL	SUB_24			; (06F7)
		ADD	SP,8
LOC_80:
		TEST	WORD PTR [SI+2],4
		JZ	LOC_81			; Jump if zero
		PUSH	WORD PTR [SI+8]
		CALL	SUB_47			; (14CC)
		POP	CX
LOC_81:
		AND	WORD PTR [SI+2],0FFF3H
		nop				;*Fixup for MASM (M)
		MOV	WORD PTR [SI+6],0
		MOV	AX,SI
		ADD	AX,5
		MOV	[SI+8],AX
		MOV	[SI+0AH],AX
		CMP	WORD PTR [BP+8],2
		JE	LOC_84			; Jump if equal
		OR	DI,DI			; Zero ?
		JBE	LOC_84			; Jump if below or =
		MOV	WORD PTR DS:DATA_31E,8A4H	; (7FC4:0232=2FB9H)
		CMP	WORD PTR [BP+6],0
		JNE	LOC_83			; Jump if not equal
		PUSH	DI
		CALL	SUB_19			; (05CA)
		POP	CX
		MOV	[BP+6],AX
		OR	AX,AX			; Zero ?
		JZ	LOC_82			; Jump if zero
		OR	WORD PTR [SI+2],4
		nop				;*Fixup for MASM (M)
		JMP	SHORT LOC_83		; (0885)
LOC_82:
		MOV	AX,0FFFFH
		JMP	SHORT LOC_85		; (08A0)
LOC_83:
		MOV	AX,[BP+6]
		MOV	[SI+0AH],AX
		MOV	[SI+8],AX
		MOV	[SI+6],DI
		CMP	WORD PTR [BP+8],1
		JNE	LOC_84			; Jump if not equal
		OR	WORD PTR [SI+2],8
		nop				;*Fixup for MASM (M)
LOC_84:
		XOR	AX,AX			; Zero register
		JMP	SHORT LOC_85		; (08A0)
LOC_85:
		POP	DI
		POP	SI
		POP	BP
		RETN
SUB_26		ENDP
  
		DB	56H, 57H, 0BFH, 4, 0, 0BEH
		DB	3EH, 2, 0EBH, 10H
LOC_86:
		TEST	WORD PTR [SI+2],3
		JZ	LOC_87			; Jump if zero
		PUSH	SI
		CALL	SUB_34			; (0BEE)
		POP	CX
LOC_87:
		DEC	DI
		ADD	SI,10H
		OR	DI,DI			; Zero ?
		JNZ	LOC_86			; Jump if not zero
		POP	DI
		POP	SI
		RETN
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
SUB_27		PROC	NEAR
		PUSH	BP
		MOV	BP,SP
		SUB	SP,8AH
		PUSH	SI
		PUSH	DI
		MOV	AX,[BP+8]
		INC	AX
		CMP	AX,2
		JAE	LOC_88			; Jump if above or =
		XOR	AX,AX			; Zero register
		JMP	LOC_100			; (09D2)
LOC_88:
		MOV	BX,[BP+4]
		SHL	BX,1			; Shift w/zeros fill
		TEST	WORD PTR DS:DATA_32E[BX],8000H	; (7FC4:037E=50FFH)
		JZ	LOC_89			; Jump if zero
		PUSH	WORD PTR [BP+8]
		PUSH	WORD PTR [BP+6]
		PUSH	WORD PTR [BP+4]
		CALL	SUB_28			; (09D8)
		ADD	SP,6
		JMP	LOC_100			; (09D2)
LOC_89:
		MOV	BX,[BP+4]
		SHL	BX,1			; Shift w/zeros fill
		AND	WORD PTR DS:DATA_32E[BX],0FDFFH	; (7FC4:037E=50FFH)
		MOV	AX,[BP+6]
		MOV	SS:DATA_136E[BP],AX	; (817F:FF7C=0)
		MOV	AX,[BP+8]
		MOV	SS:DATA_134E[BP],AX	; (817F:FF78=0)
		LEA	SI,[BP-82H]		; Load effective addr
		JMP	SHORT LOC_95		; (0987)
LOC_90:
		DEC	WORD PTR SS:DATA_134E[BP]	; (817F:FF78=0)
		MOV	BX,SS:DATA_136E[BP]	; (817F:FF7C=0)
		INC	WORD PTR SS:DATA_136E[BP]	; (817F:FF7C=0)
		MOV	AL,[BX]
		MOV	SS:DATA_135E[BP],AL	; (817F:FF7B=0)
		CMP	AL,0AH
		JNE	LOC_91			; Jump if not equal
		MOV	BYTE PTR [SI],0DH
		INC	SI
LOC_91:
		MOV	AL,SS:DATA_135E[BP]	; (817F:FF7B=0)
		MOV	[SI],AL
		INC	SI
		LEA	AX,[BP-82H]		; Load effective addr
		MOV	DX,SI
		SUB	DX,AX
		CMP	DX,80H
		JL	LOC_95			; Jump if < lea="" ax,[bp-82h]="" ;="" load="" effective="" addr="" mov="" di,si="" sub="" di,ax="" push="" di="" lea="" ax,[bp-82h]="" ;="" load="" effective="" addr="" push="" ax="" push="" word="" ptr="" [bp+4]="" call="" sub_28="" ;="" (09d8)="" add="" sp,6="" mov="" ss:data_133e[bp],ax="" ;="" (817f:ff76="0)" cmp="" ax,di="" je="" loc_94="" ;="" jump="" if="" equal="" cmp="" word="" ptr="" ss:data_133e[bp],0="" ;="" (817f:ff76="0)" jae="" loc_92="" ;="" jump="" if="" above="" or="MOV" ax,0ffffh="" jmp="" short="" loc_93="" ;="" (0981)="" loc_92:="" mov="" ax,[bp+8]="" sub="" ax,ss:data_134e[bp]="" ;="" (817f:ff78="0)" add="" ax,ss:data_133e[bp]="" ;="" (817f:ff76="0)" sub="" ax,di="" loc_93:="" jmp="" short="" loc_100="" ;="" (09d2)="" loc_94:="" lea="" si,[bp-82h]="" ;="" load="" effective="" addr="" loc_95:="" cmp="" word="" ptr="" ss:data_134e[bp],0="" ;="" (817f:ff78="0)" je="" loc_96="" ;="" jump="" if="" equal="" jmp="" loc_90="" ;="" (091a)="" nop="" ;*fixup="" for="" masm="" (v)="" loc_96:="" lea="" ax,[bp-82h]="" ;="" load="" effective="" addr="" mov="" di,si="" sub="" di,ax="" mov="" ax,di="" or="" ax,ax="" ;="" zero="" jbe="" loc_99="" ;="" jump="" if="" below="" or="PUSH" di="" lea="" ax,[bp-82h]="" ;="" load="" effective="" addr="" push="" ax="" push="" word="" ptr="" [bp+4]="" call="" sub_28="" ;="" (09d8)="" add="" sp,6="" mov="" ss:data_133e[bp],ax="" ;="" (817f:ff76="0)" cmp="" ax,di="" je="" loc_99="" ;="" jump="" if="" equal="" cmp="" word="" ptr="" ss:data_133e[bp],0="" ;="" (817f:ff76="0)" jae="" loc_97="" ;="" jump="" if="" above="" or="MOV" ax,0ffffh="" jmp="" short="" loc_98="" ;="" (09cb)="" loc_97:="" mov="" ax,[bp+8]="" add="" ax,ss:data_133e[bp]="" ;="" (817f:ff76="0)" sub="" ax,di="" loc_98:="" jmp="" short="" loc_100="" ;="" (09d2)="" loc_99:="" mov="" ax,[bp+8]="" jmp="" short="" loc_100="" ;="" (09d2)="" loc_100:="" pop="" di="" pop="" si="" mov="" sp,bp="" pop="" bp="" retn="" sub_27="" endp="" ;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß="" ;="" subroutine="" ;üüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüü="" sub_28="" proc="" near="" push="" bp="" mov="" bp,sp="" mov="" bx,[bp+4]="" shl="" bx,1="" ;="" shift="" w/zeros="" fill="" test="" word="" ptr="" ds:data_32e[bx],800h="" ;="" (7fc4:037e="50FFH)" jz="" loc_101="" ;="" jump="" if="" zero="" mov="" ax,2="" push="" ax="" xor="" ax,ax="" ;="" zero="" register="" push="" ax="" push="" ax="" push="" word="" ptr="" [bp+4]="" call="" sub_29="" ;="" (0a1e)="" mov="" sp,bp="" loc_101:="" mov="" ah,40h="" ;="" '@'="" mov="" bx,[bp+4]="" mov="" cx,[bp+8]="" mov="" dx,[bp+6]="" int="" 21h="" ;="" dos="" services="" ah="function" 40h="" ;="" write="" file="" cx="bytes," to="" ds:dx="" jc="" loc_102="" ;="" jump="" if="" carry="" set="" push="" ax="" mov="" bx,[bp+4]="" shl="" bx,1="" ;="" shift="" w/zeros="" fill="" or="" word="" ptr="" ds:data_32e[bx],1000h="" ;="" (7fc4:037e="50FFH)" pop="" ax="" jmp="" short="" loc_103="" ;="" (0a1c)="" loc_102:="" push="" ax="" call="" sub_10="" ;="" (031f)="" jmp="" short="" loc_103="" ;="" (0a1c)="" loc_103:="" pop="" bp="" retn="" sub_28="" endp="" ;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß="" ;="" subroutine="" ;üüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüü="" sub_29="" proc="" near="" push="" bp="" mov="" bp,sp="" mov="" bx,[bp+4]="" shl="" bx,1="" ;="" shift="" w/zeros="" fill="" and="" word="" ptr="" ds:data_32e[bx],0fdffh="" ;="" (7fc4:037e="50FFH)" mov="" ah,42h="" ;="" 'b'="" mov="" al,[bp+0ah]="" mov="" bx,[bp+4]="" mov="" cx,[bp+8]="" mov="" dx,[bp+6]="" int="" 21h="" ;="" dos="" services="" ah="function" 42h="" ;="" move="" file="" ptr,="" cx,dx="offset" jc="" loc_104="" ;="" jump="" if="" carry="" set="" jmp="" short="" loc_105="" ;="" (0a47)="" loc_104:="" push="" ax="" call="" sub_10="" ;="" (031f)="" cwd="" ;="" word="" to="" double="" word="" jmp="" short="" loc_105="" ;="" (0a47)="" loc_105:="" pop="" bp="" retn="" sub_29="" endp="" ;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß="" ;="" subroutine="" ;üüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüü="" sub_30="" proc="" near="" push="" bp="" mov="" bp,sp="" sub="" sp,22h="" push="" si="" push="" di="" push="" es="" mov="" di,[bp+0ah]="" push="" ds="" pop="" es="" mov="" bx,[bp+8]="" cmp="" bx,24h="" ja="" loc_113="" ;="" jump="" if="" above="" cmp="" bl,2="" jb="" loc_113="" ;="" jump="" if="" below="" mov="" ax,[bp+0ch]="" mov="" cx,[bp+0eh]="" or="" cx,cx="" ;="" zero="" jge="" loc_106="" ;="" jump="" if=""> or =
		CMP	BYTE PTR [BP+6],0
		JE	LOC_106			; Jump if equal
		MOV	BYTE PTR [DI],2DH	; '-'
		INC	DI
		NEG	CX
		NEG	AX
		SBB	CX,0
LOC_106:
		LEA	SI,[BP-22H]		; Load effective addr
		JCXZ	LOC_108			; Jump if cx=0
LOC_107:
		XCHG	AX,CX
		SUB	DX,DX
		DIV	BX			; ax,dx rem=dx:ax/reg
		XCHG	AX,CX
		DIV	BX			; ax,dx rem=dx:ax/reg
		MOV	[SI],DL
		INC	SI
		JCXZ	LOC_109			; Jump if cx=0
		JMP	SHORT LOC_107		; (0A84)
LOC_108:
		SUB	DX,DX
		DIV	BX			; ax,dx rem=dx:ax/reg
		MOV	[SI],DL
		INC	SI
LOC_109:
		OR	AX,AX			; Zero ?
		JNZ	LOC_108			; Jump if not zero
		LEA	CX,[BP-22H]		; Load effective addr
		NEG	CX
		ADD	CX,SI
		CLD				; Clear direction
  
LOCLOOP_110:
		DEC	SI
		MOV	AL,[SI]
		SUB	AL,0AH
		JNC	LOC_111			; Jump if carry=0
		ADD	AL,3AH			; ':'
		JMP	SHORT LOC_112		; (0AB4)
LOC_111:
		ADD	AL,[BP+4]
LOC_112:
		STOSB				; Store al to es:[di]
		LOOP	LOCLOOP_110		; Loop if cx > 0
  
LOC_113:
		MOV	AL,0
		STOSB				; Store al to es:[di]
		POP	ES
		MOV	AX,[BP+0AH]
		JMP	SHORT LOC_114		; (0AC0)
LOC_114:
		POP	DI
		POP	SI
		MOV	SP,BP
		POP	BP
		RETN	0CH
SUB_30		ENDP
  
		DB	55H, 8BH, 0ECH, 83H, 7EH, 8
		DB	0AH, 75H, 6, 8BH, 46H, 4
		DB	99H, 0EBH, 5, 8BH, 46H, 4
		DB	33H, 0D2H, 52H, 50H, 0FFH, 76H
		DB	6, 0FFH, 76H, 8, 0B0H, 1
		DB	50H, 0B0H, 61H, 50H, 0E8H, 5CH
		DB	0FFH, 0EBH, 0
LOC_115:
		POP	BP
		RETN
		DB	55H, 8BH, 0ECH, 0FFH, 76H, 6
		DB	0FFH, 76H, 4, 0FFH, 76H, 8
		DB	0FFH, 76H, 0AH, 0B0H, 0, 50H
		DB	0B0H, 61H, 50H, 0E8H, 40H, 0FFH
		DB	0EBH, 0, 5DH, 0C3H, 55H, 8BH
		DB	0ECH, 0FFH, 76H, 6, 0FFH, 76H
		DB	4, 0FFH, 76H, 8, 0FFH, 76H
		DB	0AH, 83H, 7EH, 0AH, 0AH, 75H
		DB	5, 0B8H, 1, 0, 0EBH, 2
		DB	33H, 0C0H, 50H, 0B0H, 61H, 50H
		DB	0E8H, 19H, 0FFH, 0EBH, 0
LOC_116:
		POP	BP
		RETN
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
SUB_31		PROC	NEAR
		PUSH	BP
		MOV	BP,SP
		MOV	AH,41H			; 'A'
		MOV	DX,[BP+4]
		INT	21H			; DOS Services  ah=function 41h
						;  delete file, name @ ds:dx
		JC	LOC_117			; Jump if carry Set
		XOR	AX,AX			; Zero register
		JMP	SHORT LOC_118		; (0B4A)
LOC_117:
		PUSH	AX
		CALL	SUB_10			; (031F)
		JMP	SHORT LOC_118		; (0B4A)
LOC_118:
		POP	BP
		RETN
SUB_31		ENDP
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
SUB_32		PROC	NEAR
		PUSH	BP
		MOV	BP,SP
		PUSH	SI
		PUSH	DI
		CLD				; Clear direction
		MOV	DI,[BP+4]
		PUSH	DS
		POP	ES
		MOV	DX,DI
		XOR	AL,AL			; Zero register
		MOV	CX,0FFFFH
		REPNE	SCASB			; Rept zf=0+cx>0 Scan es:[di] for al
		LEA	SI,[DI-1]		; Load effective addr
		MOV	DI,[BP+6]
		MOV	CX,0FFFFH
		REPNE	SCASB			; Rept zf=0+cx>0 Scan es:[di] for al
		NOT	CX
		SUB	DI,CX
		XCHG	SI,DI
		TEST	SI,1
		JZ	LOC_119			; Jump if zero
		MOVSB				; Mov [si] to es:[di]
		DEC	CX
LOC_119:
		SHR	CX,1			; Shift w/zeros fill
		REP	MOVSW			; Rep while cx>0 Mov [si] to es:[di]
		JNC	LOC_120			; Jump if carry=0
		MOVSB				; Mov [si] to es:[di]
LOC_120:
		MOV	AX,DX
		JMP	SHORT LOC_121		; (0B84)
LOC_121:
		POP	DI
		POP	SI
		POP	BP
		RETN
SUB_32		ENDP
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
SUB_33		PROC	NEAR
		PUSH	BP
		MOV	BP,SP
		PUSH	SI
		PUSH	DI
		PUSH	DS
		POP	ES
		CLD				; Clear direction
		MOV	DI,[BP+6]
		MOV	SI,DI
		XOR	AL,AL			; Zero register
		MOV	CX,0FFFFH
		REPNE	SCASB			; Rept zf=0+cx>0 Scan es:[di] for al
		NOT	CX
		MOV	DI,[BP+4]
		REP	MOVSB			; Rep while cx>0 Mov [si] to es:[di]
		MOV	AX,[BP+4]
		JMP	SHORT LOC_122		; (0BA8)
LOC_122:
		POP	DI
		POP	SI
		POP	BP
		RETN
SUB_33		ENDP
  
		DB	55H, 8BH, 0ECH, 56H, 57H, 1EH
		DB	7, 8BH, 7EH, 4, 8BH, 76H
		DB	6, 8BH, 4EH, 8, 0D1H, 0E9H
		DB	0FCH, 0F3H, 0A5H, 73H, 1, 0A4H
LOC_123:
		MOV	AX,[BP+4]
		JMP	SHORT LOC_124		; (0BC9)
LOC_124:
		POP	DI
		POP	SI
		POP	BP
		RETN
		DB	0BAH, 0AAH, 3, 0EBH, 3, 0BAH
		DB	0AFH, 3, 0B9H, 5, 0, 90H
		DB	0B4H, 40H, 0BBH, 2, 0, 0CDH
		DB	21H, 0B9H, 27H, 0, 90H, 0BAH
		DB	0B4H, 3, 0B4H, 40H, 0CDH, 21H
		DB	0E9H, 0F4H, 0F5H
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
SUB_34		PROC	NEAR
		PUSH	BP
		MOV	BP,SP
		PUSH	SI
		PUSH	DI
		MOV	SI,[BP+4]
		MOV	AX,[SI+0EH]
		CMP	AX,SI
		JE	LOC_125			; Jump if equal
		MOV	AX,0FFFFH
		JMP	SHORT LOC_130		; (0C68)
LOC_125:
		CMP	WORD PTR [SI],0
		JL	LOC_128			; Jump if < test="" word="" ptr="" [si+2],8="" jnz="" loc_126="" ;="" jump="" if="" not="" zero="" mov="" ax,[si+0ah]="" mov="" dx,si="" add="" dx,5="" cmp="" ax,dx="" jne="" loc_127="" ;="" jump="" if="" not="" equal="" loc_126:="" mov="" word="" ptr="" [si],0="" mov="" ax,[si+0ah]="" mov="" dx,si="" add="" dx,5="" cmp="" ax,dx="" jne="" loc_127="" ;="" jump="" if="" not="" equal="" mov="" ax,[si+8]="" mov="" [si+0ah],ax="" loc_127:="" xor="" ax,ax="" ;="" zero="" register="" jmp="" short="" loc_130="" ;="" (0c68)="" loc_128:="" mov="" di,[si+6]="" add="" di,[si]="" inc="" di="" sub="" [si],di="" push="" di="" mov="" ax,[si+8]="" mov="" [si+0ah],ax="" push="" ax="" mov="" al,[si+4]="" cbw="" ;="" convrt="" byte="" to="" word="" push="" ax="" call="" sub_27="" ;="" (08c5)="" add="" sp,6="" cmp="" ax,di="" je="" loc_129="" ;="" jump="" if="" equal="" test="" word="" ptr="" [si+2],200h="" jnz="" loc_129="" ;="" jump="" if="" not="" zero="" or="" word="" ptr="" [si+2],10h="" nop="" ;*fixup="" for="" masm="" (m)="" mov="" ax,0ffffh="" jmp="" short="" loc_130="" ;="" (0c68)="" loc_129:="" xor="" ax,ax="" ;="" zero="" register="" jmp="" short="" loc_130="" ;="" (0c68)="" loc_130:="" pop="" di="" pop="" si="" pop="" bp="" retn="" sub_34="" endp="" ;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß="" ;="" subroutine="" ;üüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüü="" sub_35="" proc="" near="" push="" bp="" mov="" bp,sp="" mov="" bx,[bp+6]="" dec="" word="" ptr="" [bx]="" push="" word="" ptr="" [bp+6]="" mov="" al,[bp+4]="" cbw="" ;="" convrt="" byte="" to="" word="" push="" ax="" call="" sub_36="" ;="" (0c85)="" mov="" sp,bp="" jmp="" short="" loc_131="" ;="" (0c83)="" loc_131:="" pop="" bp="" retn="" sub_35="" endp="" ;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß="" ;="" subroutine="" ;üüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüü="" sub_36="" proc="" near="" push="" bp="" mov="" bp,sp="" sub="" sp,2="" push="" si="" mov="" si,[bp+6]="" mov="" al,[bp+4]="" mov="" [bp-1],al="" loc_132:="" inc="" word="" ptr="" [si]="" jge="" loc_135="" ;="" jump="" if=""> or =
		MOV	AL,[BP-1]
		INC	WORD PTR [SI+0AH]
		MOV	BX,[SI+0AH]
		MOV	[BX-1],AL
		TEST	WORD PTR [SI+2],8
		JZ	LOC_134			; Jump if zero
		CMP	BYTE PTR [BP-1],0AH
		JE	LOC_133			; Jump if equal
		CMP	BYTE PTR [BP-1],0DH
		JNE	LOC_134			; Jump if not equal
LOC_133:
		PUSH	SI
		CALL	SUB_34			; (0BEE)
		POP	CX
		OR	AX,AX			; Zero ?
		JZ	LOC_134			; Jump if zero
		MOV	AX,0FFFFH
		JMP	LOC_149			; (0DB0)
LOC_134:
		MOV	AL,[BP-1]
		MOV	AH,0
		JMP	LOC_149			; (0DB0)
LOC_135:
		DEC	WORD PTR [SI]
		TEST	WORD PTR [SI+2],90H
		JNZ	LOC_136			; Jump if not zero
		TEST	WORD PTR [SI+2],2
		JNZ	LOC_137			; Jump if not zero
LOC_136:
		OR	WORD PTR [SI+2],10H
		nop				;*Fixup for MASM (M)
		MOV	AX,0FFFFH
		JMP	LOC_149			; (0DB0)
LOC_137:
		OR	WORD PTR [SI+2],100H
		CMP	WORD PTR [SI+6],0
		JE	LOC_141			; Jump if equal
		CMP	WORD PTR [SI],0
		JE	LOC_139			; Jump if equal
		PUSH	SI
		CALL	SUB_34			; (0BEE)
		POP	CX
		OR	AX,AX			; Zero ?
		JZ	LOC_138			; Jump if zero
		MOV	AX,0FFFFH
		JMP	LOC_149			; (0DB0)
LOC_138:
		JMP	SHORT LOC_140		; (0D15)
LOC_139:
		MOV	AX,0FFFFH
		MOV	DX,[SI+6]
		SUB	AX,DX
		MOV	[SI],AX
LOC_140:
		JMP	LOC_132			; (0C95)
		JMP	LOC_149			; (0DB0)
LOC_141:
		CMP	WORD PTR DS:DATA_34E,0	; (7FC4:03A8=0AE46H)
		JNE	LOC_145			; Jump if not equal
		MOV	AX,24EH
		CMP	AX,SI
		JNE	LOC_145			; Jump if not equal
		MOV	AL,[SI+4]
		CBW				; Convrt byte to word
		PUSH	AX
		CALL	SUB_25			; (07BA)
		POP	CX
		OR	AX,AX			; Zero ?
		JNZ	LOC_142			; Jump if not zero
		AND	WORD PTR [SI+2],0FDFFH
LOC_142:
		MOV	AX,200H
		PUSH	AX
		TEST	WORD PTR [SI+2],200H
		JZ	LOC_143			; Jump if zero
		MOV	AX,2
		JMP	SHORT LOC_144		; (0D4D)
LOC_143:
		XOR	AX,AX			; Zero register
LOC_144:
		PUSH	AX
		XOR	AX,AX			; Zero register
		PUSH	AX
		PUSH	SI
		CALL	SUB_26			; (07D2)
		ADD	SP,8
		JMP	LOC_137			; (0CEA)
		nop				;*Fixup for MASM (V)
LOC_145:
		CMP	BYTE PTR [BP-1],0AH
		JNE	LOC_146			; Jump if not equal
		TEST	WORD PTR [SI+2],40H
		JNZ	LOC_146			; Jump if not zero
		MOV	AX,1
		PUSH	AX
		MOV	AX,3DCH
		PUSH	AX
		MOV	AL,[SI+4]
		CBW				; Convrt byte to word
		PUSH	AX
		CALL	SUB_28			; (09D8)
		ADD	SP,6
		CMP	AX,1
		JNE	LOC_147			; Jump if not equal
LOC_146:
		MOV	AX,1
		PUSH	AX
		LEA	AX,[BP+4]		; Load effective addr
		PUSH	AX
		MOV	AL,[SI+4]
		CBW				; Convrt byte to word
		PUSH	AX
		CALL	SUB_28			; (09D8)
		ADD	SP,6
		CMP	AX,1
		JE	LOC_148			; Jump if equal
LOC_147:
		TEST	WORD PTR [SI+2],200H
		JNZ	LOC_148			; Jump if not zero
		OR	WORD PTR [SI+2],10H
		nop				;*Fixup for MASM (M)
		MOV	AX,0FFFFH
		JMP	SHORT LOC_149		; (0DB0)
LOC_148:
		MOV	AL,[BP-1]
		MOV	AH,0
		JMP	SHORT LOC_149		; (0DB0)
LOC_149:
		POP	SI
		MOV	SP,BP
		POP	BP
		RETN
SUB_36		ENDP
  
		DB	55H, 8BH, 0ECH, 56H, 8BH, 76H
		DB	4, 0B8H, 4EH, 2, 50H, 56H
		DB	0E8H, 0C1H, 0FEH, 59H, 59H, 0EBH
		DB	0, 5EH, 5DH, 0C3H, 55H, 8BH
		DB	0ECH, 83H, 0ECH, 2, 56H, 57H
		DB	8BH, 76H, 4, 8BH, 7EH, 6
		DB	47H, 0F7H, 44H, 2, 8, 0
		DB	74H, 23H, 0EBH, 2
LOC_150:
		JMP	SHORT LOC_151		; (0DE5)
LOC_151:
		DEC	DI
		MOV	AX,DI
		OR	AX,AX			; Zero ?
		JZ	LOC_152			; Jump if zero
		PUSH	SI
		MOV	BX,[BP+8]
		INC	WORD PTR [BP+8]
		MOV	AL,[BX]
		CBW				; Convrt byte to word
		PUSH	AX
		CALL	SUB_36			; (0C85)
		POP	CX
		POP	CX
		CMP	AX,0FFFFH
		JNE	LOC_150			; Jump if not equal
LOC_152:
		JMP	LOC_159			; (0E79)
		DB	0F7H, 44H, 2, 40H, 0, 74H
		DB	37H, 83H, 7CH, 6, 0, 74H
		DB	31H, 8BH, 44H, 6, 3BH, 0C7H
		DB	73H, 2AH, 83H, 3CH, 0, 74H
		DB	0DH, 56H, 0E8H, 0CDH, 0FDH, 59H
		DB	0BH, 0C0H, 74H, 4, 33H, 0C0H
		DB	0EBH
		DB	53H
LOC_153:
		DEC	DI
		PUSH	DI
		PUSH	WORD PTR [BP+8]
		MOV	AL,[SI+4]
		CBW				; Convrt byte to word
		PUSH	AX
		CALL	SUB_28			; (09D8)
		ADD	SP,6
		MOV	[BP-2],AX
		SUB	DI,[BP-2]
		JMP	SHORT LOC_159		; (0E79)
LOC_154:
		JMP	SHORT LOC_156		; (0E46)
LOC_155:
		JMP	SHORT LOC_156		; (0E46)
LOC_156:
		DEC	DI
		MOV	AX,DI
		OR	AX,AX			; Zero ?
		JZ	LOC_159			; Jump if zero
		INC	WORD PTR [SI]
		JGE	LOC_157			; Jump if > or =
		MOV	BX,[BP+8]
		INC	WORD PTR [BP+8]
		MOV	AL,[BX]
		INC	WORD PTR [SI+0AH]
		MOV	BX,[SI+0AH]
		MOV	[BX-1],AL
		MOV	AH,0
		JMP	SHORT LOC_158		; (0E74)
LOC_157:
		PUSH	SI
		MOV	BX,[BP+8]
		INC	WORD PTR [BP+8]
		PUSH	WORD PTR [BX]
		CALL	SUB_35			; (0C6C)
		POP	CX
		POP	CX
LOC_158:
		CMP	AX,0FFFFH
		JNE	LOC_155			; Jump if not equal
LOC_159:
		MOV	AX,DI
		JMP	SHORT LOC_160		; (0E7D)
LOC_160:
		POP	DI
		POP	SI
		MOV	SP,BP
		POP	BP
		RETN	6
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
SUB_37		PROC	NEAR
		JMP	WORD PTR DS:[45CH]	; (8134:045C=0BCDH)
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
SUB_38:
		PUSH	BP
		MOV	BP,SP
		MOV	DX,[BP+4]
		MOV	CX,0F04H
		MOV	BX,3E5H
		CLD				; Clear direction
		MOV	AL,DH
		SHR	AL,CL			; Shift w/zeros fill
		XLAT				; al=[al+[bx]] table
		STOSB				; Store al to es:[di]
		MOV	AL,DH
		AND	AL,CH
		XLAT				; al=[al+[bx]] table
		STOSB				; Store al to es:[di]
		MOV	AL,DL
		SHR	AL,CL			; Shift w/zeros fill
		XLAT				; al=[al+[bx]] table
		STOSB				; Store al to es:[di]
		MOV	AL,DL
		AND	AL,CH
		XLAT				; al=[al+[bx]] table
		STOSB				; Store al to es:[di]
		JMP	SHORT LOC_161		; (0EB0)
LOC_161:
		POP	BP
		RETN	2
SUB_37		ENDP
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
SUB_39		PROC	NEAR
		PUSH	BP
		MOV	BP,SP
		SUB	SP,96H
		PUSH	SI
		PUSH	DI
		MOV	WORD PTR [BP-56H],0
		MOV	BYTE PTR [BP-53H],50H	; 'P'
		JMP	SHORT LOC_163		; (0F00)
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
SUB_40:
		PUSH	DI
		MOV	CX,0FFFFH
		XOR	AL,AL			; Zero register
		REPNE	SCASB			; Rept zf=0+cx>0 Scan es:[di] for al
		NOT	CX
		DEC	CX
		POP	DI
		RETN
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
SUB_41:
		MOV	[DI],AL
		INC	DI
		DEC	BYTE PTR [BP-53H]
		JLE	LOC_RET_162		; Jump if < or=";ßßßß" external="" entry="" into="" subroutine="" ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß="" sub_42:="" push="" bx="" push="" cx="" push="" dx="" push="" es="" lea="" ax,[bp-52h]="" ;="" load="" effective="" addr="" sub="" di,ax="" lea="" ax,[bp-52h]="" ;="" load="" effective="" addr="" push="" ax="" push="" di="" push="" word="" ptr="" [bp+8]="" call="" word="" ptr="" [bp+0ah]="" ;*(0000)="" 1="" entry="" mov="" byte="" ptr="" [bp-53h],50h="" ;="" 'p'="" add="" [bp-56h],di="" lea="" di,[bp-52h]="" ;="" load="" effective="" addr="" pop="" es="" pop="" dx="" pop="" cx="" pop="" bx="" loc_ret_162:="" retn="" loc_163:="" push="" es="" cld="" ;="" clear="" direction="" lea="" di,[bp-52h]="" ;="" load="" effective="" addr="" mov="" ss:data_127e[bp],di="" ;="" (817f:ff6c="0)" loc_164:="" mov="" di,ss:data_127e[bp]="" ;="" (817f:ff6c="0)" loc_165:="" mov="" si,[bp+6]="" loc_166:="" lodsb="" ;="" string="" [si]="" to="" al="" or="" al,al="" ;="" zero="" jz="" loc_168="" ;="" jump="" if="" zero="" cmp="" al,25h="" ;="" '%'="" je="" loc_169="" ;="" jump="" if="" equal="" loc_167:="" mov="" [di],al="" inc="" di="" dec="" byte="" ptr="" [bp-53h]="" jg="" loc_166="" ;="" jump="" if="">
		CALL	SUB_42			; (0EDD)
		JMP	SHORT LOC_166		; (0F10)
LOC_168:
		JMP	LOC_247			; (139E)
LOC_169:
		MOV	SS:DATA_134E[BP],SI	; (817F:FF78=0)
		LODSB				; String [si] to al
		CMP	AL,25H			; '%'
		JE	LOC_167			; Jump if equal
		MOV	SS:DATA_127E[BP],DI	; (817F:FF6C=0)
		XOR	CX,CX			; Zero register
		MOV	SS:DATA_133E[BP],CX	; (817F:FF76=0)
		MOV	SS:DATA_126E[BP],CX	; (817F:FF6A=0)
		MOV	SS:DATA_132E[BP],CL	; (817F:FF75=0)
		MOV	WORD PTR SS:DATA_130E[BP],0FFFFH	; (817F:FF70=0)
		MOV	WORD PTR SS:DATA_131E[BP],0FFFFH	; (817F:FF72=0)
		JMP	SHORT LOC_171		; (0F53)
LOC_170:
		LODSB				; String [si] to al
LOC_171:
		XOR	AH,AH			; Zero register
		MOV	DX,AX
		MOV	BX,AX
		SUB	BL,20H			; ' '
		CMP	BL,60H			; '`'
		JAE	LOC_173			; Jump if above or =
		MOV	BL,DATA_111[BX]		; (8134:03F5=0)
		MOV	AX,BX
		CMP	AX,17H
		JBE	LOC_172			; Jump if below or =
		JMP	LOC_245			; (138C)
LOC_172:
		MOV	BX,AX
		SHL	BX,1			; Shift w/zeros fill
		JMP	WORD PTR CS:DATA_41[BX]	;*(7FD4:0F78=0FC3H)  24 entries
DATA_41		DW	OFFSET LOC_176		; Data table (indexed access)
DATA_42		DW	OFFSET LOC_174
DATA_43		DW	OFFSET LOC_182
DATA_44		DW	OFFSET LOCLOOP_175
DATA_45		DW	OFFSET LOC_185
DATA_46		DW	OFFSET LOC_186
DATA_47		DW	OFFSET LOC_188
DATA_48		DW	OFFSET LOC_189
DATA_49		DW	OFFSET LOC_190
DATA_50		DW	OFFSET LOC_180
DATA_51		DW	OFFSET LOC_196
DATA_52		DW	OFFSET LOC_191
DATA_53		DW	OFFSET LOC_192
DATA_54		DW	OFFSET LOC_193
DATA_55		DW	OFFSET LOC_205
DATA_56		DW	OFFSET LOC_214
DATA_57		DW	OFFSET LOC_208
DATA_58		DW	OFFSET LOC_209
DATA_59		DW	OFFSET LOC_242
DATA_60		DW	OFFSET LOC_245
DATA_61		DW	OFFSET LOC_245
DATA_62		DW	OFFSET LOC_245
DATA_63		DW	OFFSET LOC_178
DATA_64		DW	OFFSET LOC_179
LOC_173:
		JMP	LOC_245			; (138C)
  
;ÄÄÄÄÄ Indexed Entry Point ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
  
LOC_174:
		CMP	CH,0
		JA	LOC_173			; Jump if above
		OR	WORD PTR SS:DATA_126E[BP],1	; (817F:FF6A=0)
		JMP	SHORT LOC_170		; (0F52)
  
;ÄÄÄÄÄ Indexed Entry Point ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
  
  
LOCLOOP_175:
		CMP	CH,0
		JA	LOC_173			; Jump if above
		OR	WORD PTR SS:DATA_126E[BP],2	; (817F:FF6A=0)
		JMP	SHORT LOC_170		; (0F52)
  
;ÄÄÄÄÄ Indexed Entry Point ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
  
LOC_176:
		CMP	CH,0
		JA	LOC_173			; Jump if above
		CMP	BYTE PTR SS:DATA_132E[BP],2BH	; (817F:FF75=0) '+'
		JE	LOC_177			; Jump if equal
		MOV	SS:DATA_132E[BP],DL	; (817F:FF75=0)
LOC_177:
		JMP	LOC_170			; (0F52)
  
;ÄÄÄÄÄ Indexed Entry Point ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
  
LOC_178:
		AND	WORD PTR SS:DATA_126E[BP],0FFDFH	; (817F:FF6A=0)
		MOV	CH,5
		JMP	LOC_170			; (0F52)
  
;ÄÄÄÄÄ Indexed Entry Point ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
  
LOC_179:
		OR	WORD PTR SS:DATA_126E[BP],20H	; (817F:FF6A=0)
		MOV	CH,5
		JMP	LOC_170			; (0F52)
  
;ÄÄÄÄÄ Indexed Entry Point ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
  
LOC_180:
		CMP	CH,0
		JA	LOC_186			; Jump if above
		TEST	WORD PTR SS:DATA_126E[BP],2	; (817F:FF6A=0)
		JNZ	LOC_183			; Jump if not zero
		OR	WORD PTR SS:DATA_126E[BP],8	; (817F:FF6A=0)
		MOV	CH,1
		JMP	LOC_170			; (0F52)
LOC_181:
		JMP	LOC_245			; (138C)
  
;ÄÄÄÄÄ Indexed Entry Point ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
  
LOC_182:
		MOV	DI,[BP+4]
		MOV	AX,[DI]
		ADD	WORD PTR [BP+4],2
		CMP	CH,2
		JAE	LOC_184			; Jump if above or =
		MOV	SS:DATA_130E[BP],AX	; (817F:FF70=0)
		MOV	CH,3
LOC_183:
		JMP	LOC_170			; (0F52)
LOC_184:
		CMP	CH,4
		JNE	LOC_181			; Jump if not equal
		MOV	SS:DATA_131E[BP],AX	; (817F:FF72=0)
		INC	CH
		JMP	LOC_170			; (0F52)
  
;ÄÄÄÄÄ Indexed Entry Point ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
  
LOC_185:
		CMP	CH,4
		JAE	LOC_181			; Jump if above or =
		MOV	CH,4
		JMP	LOC_170			; (0F52)
  
;ÄÄÄÄÄ Indexed Entry Point ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
  
LOC_186:
		XCHG	AX,DX
		SUB	AL,30H			; '0'
		CBW				; Convrt byte to word
		CMP	CH,2
		JA	LOC_187			; Jump if above
		MOV	CH,2
		XCHG	AX,SS:DATA_130E[BP]	; (817F:FF70=0)
		OR	AX,AX			; Zero ?
		JL	LOC_183			; Jump if < shl="" ax,1="" ;="" shift="" w/zeros="" fill="" mov="" dx,ax="" shl="" ax,1="" ;="" shift="" w/zeros="" fill="" shl="" ax,1="" ;="" shift="" w/zeros="" fill="" add="" ax,dx="" add="" ss:data_130e[bp],ax="" ;="" (817f:ff70="0)" jmp="" loc_170="" ;="" (0f52)="" loc_187:="" cmp="" ch,4="" jne="" loc_181="" ;="" jump="" if="" not="" equal="" xchg="" ax,ss:data_131e[bp]="" ;="" (817f:ff72="0)" or="" ax,ax="" ;="" zero="" jl="" loc_183="" ;="" jump="" if="">< shl="" ax,1="" ;="" shift="" w/zeros="" fill="" mov="" dx,ax="" shl="" ax,1="" ;="" shift="" w/zeros="" fill="" shl="" ax,1="" ;="" shift="" w/zeros="" fill="" add="" ax,dx="" add="" ss:data_131e[bp],ax="" ;="" (817f:ff72="0)" jmp="" loc_170="" ;="" (0f52)="" ;äääää="" indexed="" entry="" point="" ääääääääääääääääääääääääääääääääääääääääääääääää="" loc_188:="" or="" word="" ptr="" ss:data_126e[bp],10h="" ;="" (817f:ff6a="0)" mov="" ch,5="" jmp="" loc_170="" ;="" (0f52)="" ;äääää="" indexed="" entry="" point="" ääääääääääääääääääääääääääääääääääääääääääääääää="" loc_189:="" or="" word="" ptr="" ss:data_126e[bp],100h="" ;="" (817f:ff6a="0)" and="" word="" ptr="" ss:data_126e[bp],0ffefh="" ;="" (817f:ff6a="0)" mov="" ch,5="" jmp="" loc_170="" ;="" (0f52)="" ;äääää="" indexed="" entry="" point="" ääääääääääääääääääääääääääääääääääääääääääääääää="" loc_190:="" and="" word="" ptr="" ss:data_126e[bp],0ffefh="" ;="" (817f:ff6a="0)" or="" word="" ptr="" ss:data_126e[bp],80h="" ;="" (817f:ff6a="0)" mov="" ch,5="" jmp="" loc_170="" ;="" (0f52)="" ;äääää="" indexed="" entry="" point="" ääääääääääääääääääääääääääääääääääääääääääääääää="" loc_191:="" mov="" bh,8="" jmp="" short="" loc_194="" ;="" (10ad)="" ;äääää="" indexed="" entry="" point="" ääääääääääääääääääääääääääääääääääääääääääääääää="" loc_192:="" mov="" bh,0ah="" jmp="" short="" loc_195="" ;="" (10b2)="" ;äääää="" indexed="" entry="" point="" ääääääääääääääääääääääääääääääääääääääääääääääää="" loc_193:="" mov="" bh,10h="" mov="" bl,0e9h="" add="" bl,dl="" loc_194:="" mov="" byte="" ptr="" ss:data_132e[bp],0="" ;="" (817f:ff75="0)" loc_195:="" mov="" byte="" ptr="" ss:data_129e[bp],0="" ;="" (817f:ff6f="0)" mov="" ss:data_128e[bp],dl="" ;="" (817f:ff6e="0)" mov="" di,[bp+4]="" mov="" ax,[di]="" xor="" dx,dx="" ;="" zero="" register="" jmp="" short="" loc_197="" ;="" (10d5)="" ;äääää="" indexed="" entry="" point="" ääääääääääääääääääääääääääääääääääääääääääääääää="" loc_196:="" mov="" bh,0ah="" mov="" byte="" ptr="" ss:data_129e[bp],1="" ;="" (817f:ff6f="0)" mov="" ss:data_128e[bp],dl="" ;="" (817f:ff6e="0)" mov="" di,[bp+4]="" mov="" ax,[di]="" cwd="" ;="" word="" to="" double="" word="" loc_197:="" inc="" di="" inc="" di="" mov="" [bp+6],si="" test="" word="" ptr="" ss:data_126e[bp],10h="" ;="" (817f:ff6a="0)" jz="" loc_198="" ;="" jump="" if="" zero="" mov="" dx,[di]="" inc="" di="" inc="" di="" loc_198:="" mov="" [bp+4],di="" lea="" di,[bp-85h]="" ;="" load="" effective="" addr="" or="" ax,ax="" ;="" zero="" jnz="" loc_202="" ;="" jump="" if="" not="" zero="" or="" dx,dx="" ;="" zero="" jnz="" loc_202="" ;="" jump="" if="" not="" zero="" cmp="" word="" ptr="" ss:data_131e[bp],0="" ;="" (817f:ff72="0)" jne="" loc_203="" ;="" jump="" if="" not="" equal="" mov="" di,ss:data_127e[bp]="" ;="" (817f:ff6c="0)" mov="" cx,ss:data_130e[bp]="" ;="" (817f:ff70="0)" jcxz="" loc_201="" ;="" jump="" if="" cx="0" cmp="" cx,0ffffh="" je="" loc_201="" ;="" jump="" if="" equal="" mov="" ax,ss:data_126e[bp]="" ;="" (817f:ff6a="0)" and="" ax,8="" jz="" loc_199="" ;="" jump="" if="" zero="" mov="" dl,30h="" ;="" '0'="" jmp="" short="" locloop_200="" ;="" (111a)="" loc_199:="" mov="" dl,20h="" ;="" '="" '="" locloop_200:="" mov="" al,dl="" call="" sub_41="" ;="" (0ed5)="" loop="" locloop_200="" ;="" loop="" if="" cx=""> 0
  
LOC_201:
		JMP	LOC_165			; (0F0D)
LOC_202:
		OR	WORD PTR SS:DATA_126E[BP],4	; (817F:FF6A=0)
LOC_203:
		PUSH	DX
		PUSH	AX
		PUSH	DI
		MOV	AL,BH
		CBW				; Convrt byte to word
		PUSH	AX
		MOV	AL,SS:DATA_129E[BP]	; (817F:FF6F=0)
		PUSH	AX
		PUSH	BX
		CALL	SUB_30			; (0A49)
		PUSH	SS
		POP	ES
		MOV	DX,SS:DATA_131E[BP]	; (817F:FF72=0)
		OR	DX,DX			; Zero ?
		JG	LOC_204			; Jump if >
		JMP	LOC_219			; (125A)
LOC_204:
		JMP	LOC_220			; (126A)
  
;ÄÄÄÄÄ Indexed Entry Point ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
  
LOC_205:
		MOV	SS:DATA_128E[BP],DL	; (817F:FF6E=0)
		MOV	[BP+6],SI
		LEA	DI,[BP-86H]		; Load effective addr
		MOV	BX,[BP+4]
		PUSH	WORD PTR [BX]
		INC	BX
		INC	BX
		MOV	[BP+4],BX
		TEST	WORD PTR SS:DATA_126E[BP],20H	; (817F:FF6A=0)
		JZ	LOC_206			; Jump if zero
		PUSH	WORD PTR [BX]
		INC	BX
		INC	BX
		MOV	[BP+4],BX
		PUSH	SS
		POP	ES
		CALL	SUB_38			; (0E89)
		MOV	AL,3AH			; ':'
		STOSB				; Store al to es:[di]
LOC_206:
		PUSH	SS
		POP	ES
		CALL	SUB_38			; (0E89)
		MOV	BYTE PTR [DI],0
		MOV	BYTE PTR SS:DATA_129E[BP],0	; (817F:FF6F=0)
		AND	WORD PTR SS:DATA_126E[BP],0FFFBH	; (817F:FF6A=0)
		LEA	CX,[BP-86H]		; Load effective addr
		SUB	DI,CX
		XCHG	CX,DI
		MOV	DX,SS:DATA_131E[BP]	; (817F:FF72=0)
		CMP	DX,CX
		JG	LOC_207			; Jump if >
		MOV	DX,CX
LOC_207:
		JMP	LOC_219			; (125A)
  
;ÄÄÄÄÄ Indexed Entry Point ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
  
LOC_208:
		MOV	[BP+6],SI
		MOV	SS:DATA_128E[BP],DL	; (817F:FF6E=0)
		MOV	DI,[BP+4]
		MOV	AX,[DI]
		ADD	WORD PTR [BP+4],2
		PUSH	SS
		POP	ES
		LEA	DI,[BP-85H]		; Load effective addr
		XOR	AH,AH			; Zero register
		MOV	[DI],AX
		MOV	CX,1
		JMP	LOC_223			; (1294)
  
;ÄÄÄÄÄ Indexed Entry Point ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
  
LOC_209:
		MOV	[BP+6],SI
		MOV	SS:DATA_128E[BP],DL	; (817F:FF6E=0)
		MOV	DI,[BP+4]
		TEST	WORD PTR SS:DATA_126E[BP],20H	; (817F:FF6A=0)
		JNZ	LOC_210			; Jump if not zero
		MOV	DI,[DI]
		ADD	WORD PTR [BP+4],2
		PUSH	DS
		POP	ES
		OR	DI,DI			; Zero ?
		JMP	SHORT LOC_211		; (11E4)
LOC_210:
		LES	DI,DWORD PTR [DI]	; Load 32 bit ptr
		ADD	WORD PTR [BP+4],4
		MOV	AX,ES
		OR	AX,DI
LOC_211:
		JNZ	LOC_212			; Jump if not zero
		PUSH	DS
		POP	ES
		MOV	DI,3DEH
LOC_212:
		CALL	SUB_40			; (0EC8)
		CMP	CX,SS:DATA_131E[BP]	; (817F:FF72=0)
		JBE	LOC_213			; Jump if below or =
		MOV	CX,SS:DATA_131E[BP]	; (817F:FF72=0)
LOC_213:
		JMP	LOC_223			; (1294)
  
;ÄÄÄÄÄ Indexed Entry Point ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
  
LOC_214:
		MOV	[BP+6],SI
		MOV	SS:DATA_128E[BP],DL	; (817F:FF6E=0)
		MOV	DI,[BP+4]
		MOV	CX,SS:DATA_131E[BP]	; (817F:FF72=0)
		OR	CX,CX			; Zero ?
		JGE	LOC_215			; Jump if > or =
		MOV	CX,6
LOC_215:
		PUSH	DI
		PUSH	CX
		LEA	BX,[BP-85H]		; Load effective addr
		PUSH	BX
		PUSH	DX
		MOV	AX,1
		AND	AX,SS:DATA_126E[BP]	; (817F:FF6A=0)
		PUSH	AX
		MOV	AX,SS:DATA_126E[BP]	; (817F:FF6A=0)
		TEST	AX,80H
		JZ	LOC_216			; Jump if zero
		MOV	AX,2
		MOV	WORD PTR [BP-2],4
		JMP	SHORT LOC_218		; (124A)
LOC_216:
		TEST	AX,100H
		JZ	LOC_217			; Jump if zero
		MOV	AX,8
		MOV	WORD PTR [BP-2],0AH
		JMP	SHORT LOC_218		; (124A)
LOC_217:
		MOV	WORD PTR [BP-2],8
		MOV	AX,6
LOC_218:
		PUSH	AX
		CALL	SUB_37			; (0E85)
		MOV	AX,[BP-2]
		ADD	[BP+4],AX
		PUSH	SS
		POP	ES
		LEA	DI,[BP-85H]		; Load effective addr
LOC_219:
		TEST	WORD PTR SS:DATA_126E[BP],8	; (817F:FF6A=0)
		JZ	LOC_221			; Jump if zero
		MOV	DX,SS:DATA_130E[BP]	; (817F:FF70=0)
		OR	DX,DX			; Zero ?
		JLE	LOC_221			; Jump if < or="LOC_220:" call="" sub_40="" ;="" (0ec8)="" sub="" dx,cx="" jle="" loc_221="" ;="" jump="" if="">< or="MOV" ss:data_133e[bp],dx="" ;="" (817f:ff76="0)" loc_221:="" mov="" al,ss:data_132e[bp]="" ;="" (817f:ff75="0)" or="" al,al="" ;="" zero="" jz="" loc_222="" ;="" jump="" if="" zero="" cmp="" byte="" ptr="" es:[di],2dh="" ;="" '-'="" je="" loc_222="" ;="" jump="" if="" equal="" sub="" word="" ptr="" ss:data_133e[bp],1="" ;="" (817f:ff76="0)" adc="" word="" ptr="" ss:data_133e[bp],0="" ;="" (817f:ff76="0)" dec="" di="" mov="" es:[di],al="" loc_222:="" call="" sub_40="" ;="" (0ec8)="" loc_223:="" mov="" si,di="" mov="" di,ss:data_127e[bp]="" ;="" (817f:ff6c="0)" mov="" bx,ss:data_130e[bp]="" ;="" (817f:ff70="0)" mov="" ax,5="" and="" ax,ss:data_126e[bp]="" ;="" (817f:ff6a="0)" cmp="" ax,5="" jne="" loc_224="" ;="" jump="" if="" not="" equal="" mov="" ah,ss:data_128e[bp]="" ;="" (817f:ff6e="0)" cmp="" ah,6fh="" ;="" 'o'="" jne="" loc_225="" ;="" jump="" if="" not="" equal="" cmp="" word="" ptr="" ss:data_133e[bp],0="" ;="" (817f:ff76="0)" jg="" loc_224="" ;="" jump="" if="">
		MOV	WORD PTR SS:DATA_133E[BP],1	; (817F:FF76=0)
LOC_224:
		JMP	SHORT LOC_227		; (12E1)
		DB	90H
LOC_225:
		CMP	AH,78H			; 'x'
		JE	LOC_226			; Jump if equal
		CMP	AH,58H			; 'X'
		JNE	LOC_227			; Jump if not equal
LOC_226:
		OR	WORD PTR SS:DATA_126E[BP],40H	; (817F:FF6A=0)
		DEC	BX
		DEC	BX
		SUB	WORD PTR SS:DATA_133E[BP],2	; (817F:FF76=0)
		JGE	LOC_227			; Jump if > or =
		MOV	WORD PTR SS:DATA_133E[BP],0	; (817F:FF76=0)
LOC_227:
		ADD	CX,SS:DATA_133E[BP]	; (817F:FF76=0)
		TEST	WORD PTR SS:DATA_126E[BP],2	; (817F:FF6A=0)
		JNZ	LOC_230			; Jump if not zero
		JMP	SHORT LOC_229		; (12F5)
LOC_228:
		MOV	AL,20H			; ' '
		CALL	SUB_41			; (0ED5)
		DEC	BX
LOC_229:
		CMP	BX,CX
		JG	LOC_228			; Jump if >
LOC_230:
		TEST	WORD PTR SS:DATA_126E[BP],40H	; (817F:FF6A=0)
		JZ	LOC_231			; Jump if zero
		MOV	AL,30H			; '0'
		CALL	SUB_41			; (0ED5)
		MOV	AL,SS:DATA_128E[BP]	; (817F:FF6E=0)
		CALL	SUB_41			; (0ED5)
LOC_231:
		MOV	DX,SS:DATA_133E[BP]	; (817F:FF76=0)
		OR	DX,DX			; Zero ?
		JLE	LOC_236			; Jump if < or="SUB" cx,dx="" sub="" bx,dx="" mov="" al,es:[si]="" cmp="" al,2dh="" ;="" '-'="" je="" loc_232="" ;="" jump="" if="" equal="" cmp="" al,20h="" ;="" '="" '="" je="" loc_232="" ;="" jump="" if="" equal="" cmp="" al,2bh="" ;="" '+'="" jne="" loc_233="" ;="" jump="" if="" not="" equal="" loc_232:="" lods="" byte="" ptr="" es:[si]="" ;="" string="" [si]="" to="" al="" call="" sub_41="" ;="" (0ed5)="" dec="" cx="" dec="" bx="" loc_233:="" xchg="" cx,dx="" jcxz="" loc_235="" ;="" jump="" if="" cx="0" locloop_234:="" mov="" al,30h="" ;="" '0'="" call="" sub_41="" ;="" (0ed5)="" loop="" locloop_234="" ;="" loop="" if="" cx=""> 0
  
LOC_235:
		XCHG	CX,DX
LOC_236:
		JCXZ	LOC_239			; Jump if cx=0
		SUB	BX,CX
  
LOCLOOP_237:
		LODS	BYTE PTR ES:[SI]	; String [si] to al
		MOV	[DI],AL
		INC	DI
		DEC	BYTE PTR [BP-53H]
		JG	LOC_238			; Jump if >
		CALL	SUB_42			; (0EDD)
LOC_238:
		LOOP	LOCLOOP_237		; Loop if cx > 0
  
LOC_239:
		OR	BX,BX			; Zero ?
		JLE	LOC_241			; Jump if < or="MOV" cx,bx="" locloop_240:="" mov="" al,20h="" ;="" '="" '="" call="" sub_41="" ;="" (0ed5)="" loop="" locloop_240="" ;="" loop="" if="" cx=""> 0
  
LOC_241:
		JMP	LOC_165			; (0F0D)
SUB_39		ENDP
  
  
;ÄÄÄÄÄ Indexed Entry Point ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
  
LOC_242:
		MOV	[BP+6],SI
		MOV	DI,[BP+4]
		TEST	WORD PTR SS:DATA_126E[BP],20H	; (817F:FF6A=0)
		JNZ	LOC_243			; Jump if not zero
		MOV	DI,[DI]
		ADD	WORD PTR [BP+4],2
		PUSH	DS
		POP	ES
		JMP	SHORT LOC_244		; (137D)
LOC_243:
		LES	DI,DWORD PTR [DI]	; Load 32 bit ptr
		ADD	WORD PTR [BP+4],4
LOC_244:
		MOV	AX,50H
		SUB	AL,[BP-53H]
		ADD	AX,[BP-56H]
		MOV	ES:[DI],AX
		JMP	LOC_164			; (0F09)
  
;ÄÄÄÄÄ Indexed Entry Point ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
  
LOC_245:
		MOV	SI,SS:DATA_134E[BP]	; (817F:FF78=0)
		MOV	DI,SS:DATA_127E[BP]	; (817F:FF6C=0)
		MOV	AL,25H			; '%'
LOC_246:
		CALL	SUB_41			; (0ED5)
		LODSB				; String [si] to al
		OR	AL,AL			; Zero ?
		JNZ	LOC_246			; Jump if not zero
LOC_247:
		CMP	BYTE PTR [BP-53H],50H	; 'P'
		JGE	LOC_248			; Jump if > or =
		CALL	SUB_42			; (0EDD)
LOC_248:
		POP	ES
		MOV	AX,[BP-56H]
		JMP	SHORT LOC_249		; (13AD)
LOC_249:
		POP	DI
		POP	SI
		MOV	SP,BP
		POP	BP
		RETN	8
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
SUB_43		PROC	NEAR
		PUSH	BP
		MOV	BP,SP
		PUSH	SI
		PUSH	DI
		MOV	SI,[BP+4]
		CMP	WORD PTR DS:DATA_36E,0	; (7FC4:04A6=8C40H)
		JE	LOC_250			; Jump if equal
		MOV	BX,DS:DATA_36E		; (7FC4:04A6=8C40H)
		MOV	DI,[BX+6]
		MOV	BX,DS:DATA_36E		; (7FC4:04A6=8C40H)
		MOV	[BX+6],SI
		MOV	[DI+4],SI
		MOV	[SI+6],DI
		MOV	AX,DS:DATA_36E		; (7FC4:04A6=8C40H)
		MOV	[SI+4],AX
		JMP	SHORT LOC_251		; (13EA)
LOC_250:
		MOV	DS:DATA_36E,SI		; (7FC4:04A6=8C40H)
		MOV	[SI+4],SI
		MOV	[SI+6],SI
LOC_251:
		POP	DI
		POP	SI
		POP	BP
		RETN
SUB_43		ENDP
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
SUB_44		PROC	NEAR
		PUSH	BP
		MOV	BP,SP
		SUB	SP,2
		PUSH	SI
		PUSH	DI
		MOV	SI,[BP+6]
		MOV	DI,[BP+4]
		MOV	AX,[SI]
		ADD	[DI],AX
		MOV	AX,DS:DATA_35E		; (7FC4:04A4=0AC26H)
		CMP	AX,SI
		JNE	LOC_252			; Jump if not equal
		MOV	DS:DATA_35E,DI		; (7FC4:04A4=0AC26H)
		JMP	SHORT LOC_253		; (141A)
LOC_252:
		MOV	AX,[SI]
		ADD	AX,SI
		MOV	[BP-2],AX
		MOV	BX,[BP-2]
		MOV	[BX+2],DI
LOC_253:
		PUSH	SI
		CALL	SUB_15			; (04EB)
		POP	CX
		POP	DI
		POP	SI
		MOV	SP,BP
		POP	BP
		RETN
SUB_44		ENDP
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
SUB_45		PROC	NEAR
		PUSH	SI
		MOV	AX,DS:DATA_37E		; (7FC4:04A8=87C5H)
		CMP	AX,DS:DATA_35E		; (7FC4:04A4=0AC26H)
		JNE	LOC_254			; Jump if not equal
		PUSH	WORD PTR DS:DATA_37E	; (7FC4:04A8=87C5H)
		CALL	SUB_22			; (0690)
		POP	CX
		XOR	AX,AX			; Zero register
		MOV	DS:DATA_35E,AX		; (7FC4:04A4=0AC26H)
		MOV	DS:DATA_37E,AX		; (7FC4:04A8=87C5H)
		JMP	SHORT LOC_258		; (147C)
LOC_254:
		MOV	BX,DS:DATA_35E		; (7FC4:04A4=0AC26H)
		MOV	SI,[BX+2]
		TEST	WORD PTR [SI],1
		JNZ	LOC_257			; Jump if not zero
		PUSH	SI
		CALL	SUB_15			; (04EB)
		POP	CX
		CMP	SI,DS:DATA_37E		; (7FC4:04A8=87C5H)
		JNE	LOC_255			; Jump if not equal
		XOR	AX,AX			; Zero register
		MOV	DS:DATA_35E,AX		; (7FC4:04A4=0AC26H)
		MOV	DS:DATA_37E,AX		; (7FC4:04A8=87C5H)
		JMP	SHORT LOC_256		; (1469)
LOC_255:
		MOV	AX,[SI+2]
		MOV	DS:DATA_35E,AX		; (7FC4:04A4=0AC26H)
LOC_256:
		PUSH	SI
		CALL	SUB_22			; (0690)
		POP	CX
		JMP	SHORT LOC_258		; (147C)
LOC_257:
		PUSH	WORD PTR DS:DATA_35E	; (7FC4:04A4=0AC26H)
		CALL	SUB_22			; (0690)
		POP	CX
		MOV	DS:DATA_35E,SI		; (7FC4:04A4=0AC26H)
LOC_258:
		POP	SI
		RETN
SUB_45		ENDP
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
SUB_46		PROC	NEAR
		PUSH	BP
		MOV	BP,SP
		SUB	SP,2
		PUSH	SI
		PUSH	DI
		MOV	SI,[BP+4]
		DEC	WORD PTR [SI]
		MOV	AX,[SI]
		ADD	AX,SI
		MOV	[BP-2],AX
		MOV	DI,[SI+2]
		TEST	WORD PTR [DI],1
		JNZ	LOC_259			; Jump if not zero
		CMP	SI,DS:DATA_37E		; (7FC4:04A8=87C5H)
		JE	LOC_259			; Jump if equal
		MOV	AX,[SI]
		ADD	[DI],AX
		MOV	BX,[BP-2]
		MOV	[BX+2],DI
		MOV	SI,DI
		JMP	SHORT LOC_260		; (14B4)
LOC_259:
		PUSH	SI
		CALL	SUB_43			; (13B5)
		POP	CX
LOC_260:
		MOV	BX,[BP-2]
		TEST	WORD PTR [BX],1
		JNZ	LOC_261			; Jump if not zero
		PUSH	WORD PTR [BP-2]
		PUSH	SI
		CALL	SUB_44			; (13EE)
		POP	CX
		POP	CX
LOC_261:
		POP	DI
		POP	SI
		MOV	SP,BP
		POP	BP
		RETN
SUB_46		ENDP
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
SUB_47		PROC	NEAR
		PUSH	BP
		MOV	BP,SP
		PUSH	SI
		MOV	SI,[BP+4]
		OR	SI,SI			; Zero ?
		JNZ	LOC_262			; Jump if not zero
		JMP	SHORT LOC_264		; (14F0)
LOC_262:
		MOV	AX,SI
		ADD	AX,0FFFCH
		MOV	SI,AX
		CMP	SI,DS:DATA_35E		; (7FC4:04A4=0AC26H)
		JNE	LOC_263			; Jump if not equal
		CALL	SUB_45			; (1425)
		JMP	SHORT LOC_264		; (14F0)
LOC_263:
		PUSH	SI
		CALL	SUB_46			; (147E)
		POP	CX
LOC_264:
		POP	SI
		POP	BP
		RETN
SUB_47		ENDP
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
SUB_48		PROC	NEAR
		PUSH	BP
		MOV	BP,SP
		MOV	AX,0DCBH
		PUSH	AX
		PUSH	WORD PTR [BP+4]
		PUSH	WORD PTR [BP+6]
		LEA	AX,[BP+8]		; Load effective addr
		PUSH	AX
		CALL	SUB_39			; (0EB4)
		JMP	SHORT LOC_265		; (1509)
LOC_265:
		POP	BP
		RETN
SUB_48		ENDP
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
SUB_49		PROC	NEAR
		PUSH	BP
		MOV	BP,SP
		MOV	AH,1AH
		MOV	DX,[BP+6]
		INT	21H			; DOS Services  ah=function 1Ah
						;  set DTA to ds:dx
		MOV	AH,4EH			; 'N'
		MOV	CX,[BP+8]
		MOV	DX,[BP+4]
		INT	21H			; DOS Services  ah=function 4Eh
						;  find 1st filenam match @ds:dx
		JC	LOC_266			; Jump if carry Set
		XOR	AX,AX			; Zero register
		JMP	SHORT LOC_267		; (152B)
LOC_266:
		PUSH	AX
		CALL	SUB_10			; (031F)
		JMP	SHORT LOC_267		; (152B)
LOC_267:
		POP	BP
		RETN
SUB_49		ENDP
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
SUB_50		PROC	NEAR
		PUSH	BP
		MOV	BP,SP
		MOV	AH,1AH
		MOV	DX,[BP+4]
		INT	21H			; DOS Services  ah=function 1Ah
						;  set DTA to ds:dx
		MOV	AH,4FH			; 'O'
		INT	21H			; DOS Services  ah=function 4Fh
						;  find next filename match
		JC	LOC_268			; Jump if carry Set
		XOR	AX,AX			; Zero register
		JMP	SHORT LOC_269		; (1547)
LOC_268:
		PUSH	AX
		CALL	SUB_10			; (031F)
		JMP	SHORT LOC_269		; (1547)
LOC_269:
		POP	BP
		RETN
SUB_50		ENDP
  
		DB	55H, 8BH, 0ECH, 0FFH, 76H, 6
		DB	0FFH, 76H, 8, 8BH, 5EH, 4
		DB	0FFH, 37H, 0E8H, 52H, 0F6H, 8BH
		DB	0E5H, 8BH, 46H, 6, 8BH, 5EH
		DB	4, 1, 7, 8BH, 1FH, 0C6H
		DB	7, 0, 33H, 0C0H, 0EBH, 0
		DB	5DH, 0C2H, 6, 0
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
SUB_51		PROC	NEAR
		PUSH	BP
		MOV	BP,SP
		MOV	BX,[BP+4]
		MOV	BYTE PTR [BX],0
		MOV	AX,1549H
		PUSH	AX
		LEA	AX,[BP+4]		; Load effective addr
		PUSH	AX
		PUSH	WORD PTR [BP+6]
		LEA	AX,[BP+8]		; Load effective addr
		PUSH	AX
		CALL	SUB_39			; (0EB4)
		JMP	SHORT LOC_270		; (158E)
LOC_270:
		POP	BP
		RETN
SUB_51		ENDP
  
		DB	55H, 8BH, 0ECH, 8BH, 5EH, 4
		DB	0C6H, 7, 0, 0B8H, 49H, 15H
		DB	50H, 8DH, 46H, 4, 50H, 0FFH
		DB	76H, 6, 0FFH, 76H, 8, 0E8H
		DB	0AH, 0F9H, 0EBH, 0, 5DH, 0C3H
		DB	55H, 8BH, 0ECH, 56H, 57H, 8AH
		DB	46H, 4, 8BH, 4EH, 6, 8BH
		DB	56H, 8, 8BH, 5EH, 0AH, 0CDH
		DB	25H, 5BH, 72H, 4, 33H, 0C0H
		DB	0EBH, 8, 0A3H, 94H, 0, 0B8H
		DB	0FFH, 0FFH, 0EBH, 0
LOC_271:
		POP	DI
		POP	SI
		POP	BP
		RETN
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
SUB_52		PROC	NEAR
		PUSH	BP
		MOV	BP,SP
		PUSH	SI
		PUSH	DI
		MOV	AL,[BP+4]
		MOV	CX,[BP+6]
		MOV	DX,[BP+8]
		MOV	BX,[BP+0AH]
		INT	26H			; Absolute disk write, drive al
		POP	BX
		JC	LOC_272			; Jump if carry Set
		XOR	AX,AX			; Zero register
		JMP	SHORT LOC_273		; (15F6)
LOC_272:
		MOV	DATA_78,AX		; (8134:0094=0)
		MOV	AX,0FFFFH
		JMP	SHORT LOC_273		; (15F6)
LOC_273:
		POP	DI
		POP	SI
		POP	BP
		RETN
SUB_52		ENDP
  
		DB	0, 0, 0, 0, 0, 0
  
SEG_A		ENDS
  
  
  
;--------------------------------------------------------------	SEG_B  ----
  
SEG_B		SEGMENT	PARA PUBLIC
		ASSUME CS:SEG_B , DS:SEG_B , SS:STACK_SEG_C
  
		DB	0, 0, 0, 0
		DB	'Turbo-C - Copyright (c) 1988 Bor'
		DB	'land Intl.'
		DB	0
		DB	'Null pointer assignment', 0DH, 0AH
		DB	'Divide error', 0DH, 0AH, 'Abnorm'
		DB	'al program termination', 0DH, 0AH
DATA_65		DW	0
DATA_66		DW	0
DATA_67		DW	0
DATA_68		DW	0
DATA_69		DW	0
DATA_70		DW	0
DATA_71		DW	0
DATA_72		DW	0
		DB	0, 0, 0, 0, 0, 0
DATA_73		DD	00000H
DATA_75		DW	0
DATA_76		DW	0
DATA_77		DW	0
DATA_78		DW	0
DATA_79		DW	0
		DB	0, 0, 0, 0, 0AAH, 4
DATA_80		DW	4AAH
		DB	0AAH, 4, 0
		DB	0
DATA_82		DW	0
		DB	0, 0
DATA_83		DW	0
		DB	0, 0
DATA_84		DW	0
		DB	231 DUP (0)
		DB	25H, 73H, 5CH, 25H, 73H, 0
		DB	2AH, 2EH, 2AH, 0, 5CH, 2AH
		DB	2EH, 2AH, 0
		DB	'THIS PROGRAM WAS MADE BY A PERSO'
		DB	'N FAR FROM YOU!!'
		DB	0, 0, 0, 0, 0, 13H
		DB	2, 2, 4, 5, 6, 8
		DB	8, 8, 14H, 15H, 5, 13H
		DB	0FFH, 16H, 5, 11H, 2, 0FFH
		DB	12 DUP (0FFH)
		DB	5, 5, 0FFH
		DB	15 DUP (0FFH)
		DB	0FH, 0FFH, 23H, 2, 0FFH, 0FH
		DB	0FFH, 0FFH, 0FFH, 0FFH, 13H, 0FFH
		DB	0FFH, 2, 2, 5, 0FH, 2
		DB	0FFH, 0FFH, 0FFH, 13H
		DB	8 DUP (0FFH)
		DB	23H, 0FFH, 0FFH, 0FFH, 0FFH, 23H
		DB	0FFH, 13H, 0FFH, 0, 5AH, 3
		DB	5AH, 3, 5AH, 3
DATA_88		DW	0
DATA_89		DW	1000H
		DB	0, 0, 0, 0, 9, 2
		DB	10 DUP (0)
		DB	3EH, 2, 0, 0, 0AH, 2
		DB	1
		DB	9 DUP (0)
		DB	4EH, 2, 0, 0, 2, 2
		DB	2
		DB	9 DUP (0)
		DB	5EH, 2, 0, 0, 43H, 2
		DB	3, 0
		DB	8 DUP (0)
		DB	6EH, 2, 0, 0, 42H, 2
		DB	4, 0
		DB	8 DUP (0)
		DB	7EH, 2, 0, 0, 0, 0
		DB	0FFH, 0
		DB	8 DUP (0)
		DB	8EH, 2, 0, 0, 0, 0
		DB	0FFH, 0
		DB	8 DUP (0)
		DB	9EH, 2, 0, 0, 0, 0
		DB	0FFH
		DB	9 DUP (0)
		DB	0AEH, 2, 0, 0, 0, 0
		DB	0FFH
		DB	9 DUP (0)
		DB	0BEH, 2, 0, 0, 0, 0
		DB	0FFH
		DB	9 DUP (0)
		DB	0CEH, 2, 0, 0, 0, 0
		DB	0FFH
		DB	9 DUP (0)
		DB	0DEH, 2, 0, 0, 0, 0
		DB	0FFH
		DB	9 DUP (0)
		DB	0EEH, 2, 0, 0, 0, 0
		DB	0FFH
		DB	9 DUP (0)
		DB	0FEH, 2, 0, 0, 0, 0
		DB	0FFH, 0
		DB	8 DUP (0)
		DB	0EH, 3, 0, 0, 0, 0
		DB	0FFH
		DB	9 DUP (0)
		DB	1EH, 3, 0, 0, 0, 0
		DB	0FFH
		DB	9 DUP (0)
		DB	2EH, 3, 0, 0, 0, 0
		DB	0FFH
		DB	9 DUP (0)
		DB	3EH, 3, 0, 0, 0, 0
		DB	0FFH
		DB	9 DUP (0)
		DB	4EH, 3, 0, 0, 0, 0
		DB	0FFH
		DB	9 DUP (0)
		DB	5EH, 3, 0, 0, 0, 0
		DB	0FFH
		DB	9 DUP (0)
		DB	6EH, 3, 1, 20H, 2, 20H
		DB	2, 20H, 4, 0A0H, 2, 0A0H
		DB	30 DUP (0FFH)
		DB	0, 0, 0, 0
		DB	'print scanf : floating point for'
		DB	'mats not linked', 0DH, 0AH
		DB	0, 0DH, 0, 28H, 6EH, 75H
		DB	6CH, 6CH, 29H, 0
		DB	'0123456789ABCDEF'
DATA_111	DB	0			; Data table (indexed access)
		DB	14H, 14H, 1, 14H, 15H, 14H
		DB	14H, 14H, 14H, 2, 0, 14H
		DB	3, 4, 14H, 9, 5
		DB	8 DUP (5)
		DB	11 DUP (14H)
		DB	0FH, 17H, 0FH, 8, 14H, 14H
		DB	14H, 7, 14H, 16H
		DB	9 DUP (14H)
		DB	0DH, 14H, 14H
		DB	8 DUP (14H)
		DB	10H, 0AH, 0FH, 0FH, 0FH, 8
		DB	0AH, 14H, 14H, 6, 14H, 12H
		DB	0BH, 0EH, 14H, 14H, 11H, 14H
		DB	0CH, 14H, 14H
		DB	0DH
		DB	7 DUP (14H)
		DB	0
DATA_117	DW	1D2H
		DB	0D2H, 1, 0D9H, 1
;*TA_118	DW	OFFSET SUB_53		;*(0BCD)
		DB	0CDH, 0BH
		DB	0D2H, 0BH, 0D2H, 0BH, 0D2H, 0BH
		DB	0
		DB	63 DUP (0)
DATA_120	DW	0
DATA_121	DW	0
DATA_122	DW	0
		DB	0, 0, 0, 0, 0, 0
  
SEG_B		ENDS
  
  
  
;--------------------------------------------------------- STACK_SEG_C  ---
  
STACK_SEG_C	SEGMENT	PARA STACK
  
		DB	128 DUP (0)
  
STACK_SEG_C	ENDS
  
  
  
		END	START

Downloaded From P-80 International Information Systems 304-744-2253

