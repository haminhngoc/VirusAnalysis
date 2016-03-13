﻿

  
PAGE  59,132
  
;==========================================================================
;==								         ==
;==			        NUMBER1				         ==
;==								         ==
;==      Created:   20-Mar-90					         ==
;==      Version:						         ==
;==      Passes:    5	       Analysis Options on: ABFOPU	         ==
;==      Copyright (C) 1985 BORLAND Inc				         ==
;==								         ==
;==========================================================================
  
movseg		 macro reg16, unused, Imm16     ; Fixup for Assembler
		 ifidn	<reg16>, <bx>
		 db	0BBh
		 endif
		 ifidn	<reg16>, <cx>
		 db	0B9h
		 endif
		 ifidn	<reg16>, <dx>
		 db	0BAh
		 endif
		 ifidn	<reg16>, <si>
		 db	0BEh
		 endif
		 ifidn	<reg16>, <di>
		 db	0BFh
		 endif
		 ifidn	<reg16>, <bp>
		 db	0BDh
		 endif
		 ifidn	<reg16>, <sp>
		 db	0BCh
		 endif
		 ifidn	<reg16>, <bx>
		 db	0BBH
		 endif
		 ifidn	<reg16>, <cx>
		 db	0B9H
		 endif
		 ifidn	<reg16>, <dx>
		 db	0BAH
		 endif
		 ifidn	<reg16>, <si>
		 db	0BEH
		 endif
		 ifidn	<reg16>, <di>
		 db	0BFH
		 endif
		 ifidn	<reg16>, <bp>
		 db	0BDH
		 endif
		 ifidn	<reg16>, <sp>
		 db	0BCH
		 endif
		 dw	seg Imm16
endm
DATA_1E		EQU	0			; (0000:0000=6668H)
DATA_2E		EQU	2			; (0000:0002=284H)
DATA_3E		EQU	0CH			; (0000:000C=7FBH)
DATA_4E		EQU	0EH			; (0000:000E=70H)
DATA_5E		EQU	20H			; (0000:0020=0E6A4H)
DATA_6E		EQU	8CH			; (0000:008C=8F7H)
DATA_7E		EQU	8EH			; (0000:008E=428DH)
DATA_8E		EQU	180H			; (0000:0180=0)
DATA_9E		EQU	186H			; (0000:0186=0)
DATA_10E	EQU	18CH			; (0000:018C=0)
DATA_11E	EQU	194H			; (0000:0194=0)
DATA_12E	EQU	200H			; (0000:0200=0)
DATA_13E	EQU	202H			; (0000:0202=0)
DATA_14E	EQU	204H			; (0000:0204=0)
DATA_15E	EQU	206H			; (0000:0206=0)
DATA_17E	EQU	20AH			; (0000:020A=0)
DATA_19E	EQU	238H			; (0000:0238=0)
DATA_21E	EQU	272H			; (0000:0272=0)
DATA_22E	EQU	459H			; (0000:0459=0)
DATA_23E	EQU	0			; (9966:0000=0)
DATA_25E	EQU	2			; (9966:0002=0)
DATA_26E	EQU	4			; (9966:0004=0)
DATA_28E	EQU	6			; (9966:0006=0)
DATA_29E	EQU	7			; (9966:0007=0)
DATA_30E	EQU	8			; (9966:0008=0)
DATA_31E	EQU	9			; (9966:0009=0)
DATA_32E	EQU	0AH			; (9966:000A=0)
DATA_33E	EQU	0CH			; (9966:000C=0)
DATA_34E	EQU	0EH			; (9966:000E=0)
DATA_35E	EQU	10H			; (9966:0010=0)
DATA_36E	EQU	12H			; (9966:0012=0)
DATA_37E	EQU	14H			; (9966:0014=0)
DATA_38E	EQU	16H			; (9966:0016=0)
DATA_39E	EQU	18H			; (9966:0018=0)
DATA_40E	EQU	1AH			; (9966:001A=0)
DATA_41E	EQU	1CH			; (9966:001C=0)
DATA_42E	EQU	1EH			; (9966:001E=0)
DATA_43E	EQU	20H			; (9966:0020=0)
DATA_44E	EQU	22H			; (9966:0022=0)
DATA_46E	EQU	26H			; (9966:0026=0)
DATA_48E	EQU	2AH			; (9966:002A=0)
DATA_49E	EQU	2CH			; (9966:002C=0)
DATA_50E	EQU	2EH			; (9966:002E=0)
DATA_52E	EQU	32H			; (9966:0032=0)
DATA_53E	EQU	34H			; (9966:0034=0)
DATA_54E	EQU	36H			; (9966:0036=0)
DATA_55E	EQU	0B6H			; (9966:00B6=0)
DATA_57E	EQU	0B8H			; (9966:00B8=0)
DATA_147E	EQU	6C08H			; (9966:6C08=0FFFFH)
DATA_148E	EQU	6D44H			; (9966:6D44=0FFH)
  
SEG_A		SEGMENT	BYTE PUBLIC
		ASSUME	CS:SEG_A, DS:SEG_A
  
  
		ORG	100h
  
NUMBER1		PROC	FAR
  
START:
		JMP	LOC_499			; (2D7C)
		NOP
		NOP
		INT	0ABH
COPYRIGHT	DB	'Copyright (C) 1985 BORLAND Inc'
		DB	 02H, 04H, 00H,0B1H, 57H, 00H
		DB	 3CH, 33H
		DB	9 DUP (0)
DATA_59		DW	0
DATA_60		DW	0
DATA_61		DW	0
DATA_62		DW	0
DATA_63		DW	0
DATA_64		DW	0
DATA_65		DW	0
DATA_66		DW	0
		DB	16 DUP (0)
		DB	 4DH, 6FH, 6EH, 6FH
DATA_67		DW	6863H
DATA_68		DB	72H
		DB	6FH
DATA_69		DW	656DH
DATA_70		DW	6420H
		DB	 69H, 73H, 70H, 6CH
DATA_71		DW	7961H
DATA_72		DB	35H
		DB	65H
DATA_73		DW	1950H
DATA_75		DW	701H
		DB	0FFH, 0FH, 07H, 07H
DATA_77		DW	0F70H
DATA_78		DW	707H
DATA_79		DW	0E70H
DATA_80		DW	707H
DATA_81		DW	2E4FH
DATA_82		DW	278AH
DATA_83		DW	0E40AH
DATA_84		DB	0F9H
DATA_85		DB	74H
DATA_86		DW	430EH
DATA_87		DW	8A2EH
DATA_88		DW	5007H
DATA_89		DW	0D8E8H
DATA_90		DW	5808H
DATA_91		DW	0CCFEH
DATA_92		DW	0F375H
DATA_93		DW	0C3F8H
DATA_94		DW	97H
DATA_95		DB	0FFH
DATA_96		DW	0FEA5H, 0F000H
  
NUMBER1		ENDP
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_1		PROC	NEAR
		MOV	WORD PTR DS:DATA_36E,6EH	; (9966:0012=0)
		MOV	CS:DATA_95,0		; (9966:0194=0FFH)
		MOV	SI,20H
		MOV	AX,ES:[SI]
		MOV	CS:DATA_96,AX		; (9966:0195=0FEA5H)
		MOV	AX,ES:[SI+2]
		MOV	WORD PTR CS:DATA_96+2,AX	; (9966:0197=0F000H)
		CLI				; Disable interrupts
		MOV	WORD PTR ES:[SI],1C4H
		MOV	ES:[SI+2],CS
		STI				; Enable interrupts
		JMP	SHORT LOC_2		; (01E6)
		PUSH	DS
		PUSH	AX
		XOR	AX,AX			; Zero register
		MOV	DS,AX
		MOV	WORD PTR DS:DATA_5E,1DBH	; (0000:0020=0E6A4H)
		MOV	CS:DATA_94,AX		; (9966:0192=97H)
		POP	AX
		POP	DS
		JMP	DWORD PTR CS:DATA_96	; (9966:0195=0FEA5H)
		MOV	CS:DATA_95,0FFH		; (9966:0194=0FFH)
		JMP	DWORD PTR CS:DATA_96	; (9966:0195=0FEA5H)
LOC_2:
		CALL	SUB_2			; (021D)
		INC	CS:DATA_94		; (9966:0192=97H)
		CMP	CS:DATA_95,0FFH		; (9966:0194=0FFH)
		JNE	LOC_2			; Jump if not equal
		MOV	AX,WORD PTR CS:DATA_96+2	; (9966:0197=0F000H)
		CLI				; Disable interrupts
		MOV	ES:[SI+2],AX
		MOV	AX,CS:DATA_96		; (9966:0195=0FEA5H)
		MOV	ES:[SI],AX
		STI				; Enable interrupts
		MOV	AX,CS:DATA_94		; (9966:0192=97H)
		ADD	AX,AX
		MOV	DS:DATA_36E,AX		; (9966:0012=0)
		RETN
SUB_1		ENDP
  
		MOV	AX,BX
		MOV	CX,AX
		JCXZ	LOC_RET_4		; Jump if cx=0
  
LOCLOOP_3:
		CALL	SUB_2			; (021D)
		LOOP	LOCLOOP_3		; Loop if cx > 0
  
  
LOC_RET_4:
		RETN
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_2		PROC	NEAR
		PUSH	CX
		MOV	CX,DS:DATA_36E		; (9966:0012=0)
  
LOCLOOP_5:
		LOOP	LOCLOOP_5		; Loop if cx > 0
  
		POP	CX
		RETN
SUB_2		ENDP
  
		PUSH	BP
		MOV	AH,0FH
		INT	10H			; Video display   ah=functn 0Fh
						;  get state, al=mode, bh=page
		POP	BP
		CMP	AL,DS:DATA_28E		; (9966:0006=0)
		JE	LOC_6			; Jump if equal
		MOV	AL,DS:DATA_28E		; (9966:0006=0)
		JMP	LOC_10			; (02D9)
LOC_6:
		PUSH	BP
		MOV	AX,600H
		MOV	BH,DS:DATA_30E		; (9966:0008=0)
		MOV	CX,DS:DATA_26E		; (9966:0004=0)
		MOV	DX,CS:DATA_73		; (9966:016A=1950H)
		DEC	DH
		DEC	DL
		INT	10H			; Video display   ah=functn 06h
						;  scroll up, al=lines
		MOV	AH,2
		MOV	DX,DS:DATA_26E		; (9966:0004=0)
		XOR	BH,BH			; Zero register
		INT	10H			; Video display   ah=functn 02h
						;  set cursor location in dx
		POP	BP
		RETN
		PUSH	BX
		PUSH	CX
		PUSH	DX
		PUSH	BP
		CALL	SUB_3			; (02A3)
		MOV	AH,6
LOC_7:
		MOV	AL,1
		MOV	BH,DS:DATA_30E		; (9966:0008=0)
		MOV	CH,DH
		MOV	CL,DS:DATA_26E		; (9966:0004=0)
		MOV	DX,CS:DATA_73		; (9966:016A=1950H)
		DEC	DH
		DEC	DL
		CMP	CH,DH
		JNE	LOC_8			; Jump if not equal
		XOR	AL,AL			; Zero register
LOC_8:
		INT	10H			; Video display   ah=functn 07h
						;  scroll down, al=lines
		POP	BP
		POP	DX
		POP	CX
		POP	BX
		RETN
		PUSH	BX
		PUSH	CX
		PUSH	DX
		PUSH	BP
		CALL	SUB_3			; (02A3)
		MOV	AH,7
		JMP	SHORT LOC_7		; (0264)
		PUSH	AX
		MOV	AL,BYTE PTR DS:DATA_23E+1	; (9966:0001=0)
		MOV	DS:DATA_30E,AL		; (9966:0008=0)
		POP	AX
		RETN
LOC_9:
		PUSH	AX
		MOV	AL,DS:DATA_23E		; (9966:0000=0)
		MOV	DS:DATA_30E,AL		; (9966:0008=0)
		POP	AX
		RETN
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_3		PROC	NEAR
		MOV	AH,3
		XOR	BH,BH			; Zero register
		INT	10H			; Video display   ah=functn 03h
						;  get cursor loc in dx, mode cx
		RETN
SUB_3		ENDP
  
		PUSH	BX
		PUSH	CX
		PUSH	DX
		PUSH	BP
		CALL	SUB_3			; (02A3)
		MOV	AX,600H
		MOV	BH,DS:DATA_30E		; (9966:0008=0)
		MOV	CX,DX
		MOV	DL,BYTE PTR CS:DATA_73	; (9966:016A=50H)
		DEC	DL
		INT	10H			; Video display   ah=functn 06h
						;  scroll up, al=lines
		POP	BP
		POP	DX
		POP	CX
		POP	BX
		RETN
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_4		PROC	NEAR
		CALL	SUB_9			; (05C3)
		MOV	AL,BYTE PTR CS:DATA_75+1	; (9966:016D=7)
		CMP	AL,0FFH
		JNE	LOC_10			; Jump if not equal
		PUSH	BP
		MOV	AH,0FH
		INT	10H			; Video display   ah=functn 0Fh
						;  get state, al=mode, bh=page
		POP	BP
LOC_10:
		MOV	BYTE PTR DS:DATA_26E,0	; (9966:0004=0)
		MOV	BYTE PTR DS:DATA_26E+1,0	; (9966:0005=0)
		MOV	BYTE PTR DS:DATA_31E,0FFH	; (9966:0009=0)
		CMP	AL,7
		MOV	BH,50H			; 'P'
		MOV	BL,0
		MOV	SI,16FH
		JZ	LOC_13			; Jump if zero
		MOV	SI,177H
		CMP	AL,2
		JE	LOC_12			; Jump if equal
		CMP	AL,4
		JB	LOC_11			; Jump if below
		MOV	AL,3
LOC_11:
		MOV	BL,0FFH
		CMP	AL,3
		JE	LOC_13			; Jump if equal
		MOV	BH,28H			; '('
		CMP	AL,1
		JE	LOC_13			; Jump if equal
		XOR	AL,AL			; Zero register
		MOV	BL,0
LOC_12:
		MOV	SI,173H
LOC_13:
		MOV	DS:DATA_28E,AL		; (9966:0006=0)
		MOV	DS:DATA_29E,BL		; (9966:0007=0)
		MOV	BYTE PTR CS:DATA_73,BH	; (9966:016A=50H)
		MOV	AX,CS:[SI]
		MOV	DS:DATA_23E,AX		; (9966:0000=0)
		MOV	AX,CS:[SI+2]
		MOV	DS:DATA_25E,AX		; (9966:0002=0)
		PUSH	BP
		MOV	AH,0FH
		INT	10H			; Video display   ah=functn 0Fh
						;  get state, al=mode, bh=page
		CMP	AL,DS:DATA_28E		; (9966:0006=0)
		JE	LOC_14			; Jump if equal
		MOV	AL,DS:DATA_28E		; (9966:0006=0)
		XOR	AH,AH			; Zero register
		INT	10H			; Video display   ah=functn 00h
						;  set display mode in al
LOC_14:
		POP	BP
		JMP	LOC_9			; (029A)
SUB_4		ENDP
  
		RETN
LOC_15:
		PUSH	AX
		PUSH	BX
		PUSH	CX
		PUSH	DX
		PUSH	SI
		PUSH	DI
		PUSH	BP
		PUSHF				; Push flags
		XCHG	DL,DH
		ADD	DX,DS:DATA_26E		; (9966:0004=0)
		CMP	DH,BYTE PTR CS:DATA_73+1	; (9966:016B=19H)
		JAE	LOC_16			; Jump if above or =
		CMP	DL,BYTE PTR CS:DATA_73	; (9966:016A=50H)
		JAE	LOC_16			; Jump if above or =
		MOV	AH,2
		XOR	BH,BH			; Zero register
		INT	10H			; Video display   ah=functn 02h
						;  set cursor location in dx
LOC_16:
		POPF				; Pop flags
		POP	BP
		POP	DI
		POP	SI
		POP	DX
		POP	CX
		POP	BX
		POP	AX
		RETN
		JMP	LOC_96			; (0AA0)
		CALL	SUB_3			; (02A3)
		MOV	AL,DL
		SUB	AL,DS:DATA_26E		; (9966:0004=0)
		INC	AL
		XOR	AH,AH			; Zero register
		RETN
		CALL	SUB_3			; (02A3)
		MOV	AL,DH
		SUB	AL,BYTE PTR DS:DATA_26E+1	; (9966:0005=0)
		INC	AL
		XOR	AH,AH			; Zero register
		RETN
		POP	BX
		CMP	AL,19H
		JA	LOC_17			; Jump if above
		MOV	BYTE PTR CS:DATA_73+1,AL	; (9966:016B=19H)
LOC_17:
		POP	AX
		CMP	AL,50H			; 'P'
		JA	LOC_18			; Jump if above
		MOV	BYTE PTR CS:DATA_73,AL	; (9966:016A=50H)
LOC_18:
		POP	AX
		CMP	AL,BYTE PTR CS:DATA_73+1	; (9966:016B=19H)
		JAE	LOC_19			; Jump if above or =
		DEC	AL
		MOV	BYTE PTR DS:DATA_26E+1,AL	; (9966:0005=0)
LOC_19:
		POP	AX
		CMP	AL,BYTE PTR CS:DATA_73	; (9966:016A=50H)
		JAE	LOC_20			; Jump if above or =
		DEC	AL
		MOV	DS:DATA_26E,AL		; (9966:0004=0)
LOC_20:
		JMP	BX			;*Register jump
		AND	AL,1FH
		TEST	AL,10H
		JZ	LOC_21			; Jump if zero
		AND	AL,0FH
		OR	AL,80H
LOC_21:
		AND	BYTE PTR DS:DATA_30E,70H	; (9966:0008=0) 'p'
		OR	DS:DATA_30E,AL		; (9966:0008=0)
		RETN
		AND	AL,7
		MOV	CL,4
		SHL	AL,CL			; Shift w/zeros fill
		AND	BYTE PTR DS:DATA_30E,8FH	; (9966:0008=0)
		OR	DS:DATA_30E,AL		; (9966:0008=0)
		RETN
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_5		PROC	NEAR
LOC_22:
		PUSH	BP
		MOV	DS:DATA_33E,AX		; (9966:000C=0)
		MOV	WORD PTR DS:DATA_32E,0	; (9966:000A=0)
		MOV	WORD PTR DS:DATA_34E,0	; (9966:000E=0)
		MOV	WORD PTR DS:DATA_35E,0C7H	; (9966:0010=0)
		MOV	AL,DS:DATA_31E		; (9966:0009=0)
		XOR	AH,AH			; Zero register
		INT	10H			; Video display   ah=functn 00h
						;  set display mode in al
		XOR	BX,BX			; Zero register
		MOV	DS:DATA_43E,BL		; (9966:0020=0)
		MOV	AH,0BH
		INT	10H			; Video display   ah=functn 0Bh
						;  set color from bx (CGA modes)
		INC	BH
		MOV	AH,0BH
		INT	10H			; Video display   ah=functn 0Bh
						;  set color from bx (CGA modes)
		POP	BP
		RETN
SUB_5		ENDP
  
		MOV	BYTE PTR DS:DATA_31E,4	; (9966:0009=0)
LOC_23:
		MOV	AX,13FH
		JMP	SHORT LOC_22		; (03DF)
		MOV	BYTE PTR DS:DATA_31E,5	; (9966:0009=0)
		JMP	SHORT LOC_23		; (0413)
		MOV	BYTE PTR DS:DATA_31E,6	; (9966:0009=0)
		MOV	AX,27FH
		CALL	SUB_5			; (03DF)
		MOV	AX,0FH
		JMP	SHORT LOC_27		; (0475)
		AND	AL,0FH
		MOV	AH,DS:DATA_43E		; (9966:0020=0)
		AND	AH,10H
		OR	AL,AH
		MOV	DS:DATA_43E,AL		; (9966:0020=0)
LOC_24:
		PUSH	BP
		XOR	BH,BH			; Zero register
		MOV	BL,DS:DATA_43E		; (9966:0020=0)
		MOV	AH,0BH
		INT	10H			; Video display   ah=functn 0Bh
						;  set color from bx (CGA modes)
		POP	BP
		RETN
		PUSH	BP
		MOV	BL,DS:DATA_43E		; (9966:0020=0)
		AND	BL,0EFH
		MOV	AH,2
		CMP	BYTE PTR DS:DATA_31E,4	; (9966:0009=0)
		JE	LOC_25			; Jump if equal
		MOV	AH,1
LOC_25:
		CMP	AL,AH
		JB	LOC_26			; Jump if below
		SUB	AL,AH
		OR	BL,10H
LOC_26:
		MOV	DS:DATA_43E,BL		; (9966:0020=0)
		MOV	BH,1
		MOV	BL,AL
		MOV	AH,0BH
		INT	10H			; Video display   ah=functn 0Bh
						;  set color from bx (CGA modes)
		POP	BP
		JMP	SHORT LOC_24		; (043D)
LOC_27:
		PUSH	BP
		MOV	BX,AX
		MOV	AH,0BH
		INT	10H			; Video display   ah=functn 0Bh
						;  set color from bx (CGA modes)
		POP	BP
		RETN
		POP	BX
		MOV	CX,27FH
		CMP	BYTE PTR DS:DATA_31E,6	; (9966:0009=0)
		JE	LOC_28			; Jump if equal
		MOV	CX,13FH
LOC_28:
		CMP	AX,0C7H
		JA	LOC_29			; Jump if above
		MOV	DS:DATA_35E,AX		; (9966:0010=0)
LOC_29:
		POP	AX
		CMP	AX,CX
		JA	LOC_30			; Jump if above
		MOV	DS:DATA_33E,AX		; (9966:000C=0)
LOC_30:
		POP	AX
		CMP	AX,DS:DATA_35E		; (9966:0010=0)
		JAE	LOC_31			; Jump if above or =
		MOV	DS:DATA_34E,AX		; (9966:000E=0)
LOC_31:
		POP	AX
		CMP	AX,DS:DATA_33E		; (9966:000C=0)
		JAE	LOC_32			; Jump if above or =
		MOV	DS:DATA_32E,AX		; (9966:000A=0)
LOC_32:
		JMP	BX			;*Register jump
		POP	BX
		POP	DX
		POP	CX
		PUSH	BX
		MOV	AH,0CH
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_6		PROC	NEAR
		OR	CX,CX			; Zero ?
		JS	LOC_RET_33		; Jump if sign=1
		ADD	CX,DS:DATA_32E		; (9966:000A=0)
		CMP	CX,DS:DATA_33E		; (9966:000C=0)
		JA	LOC_RET_33		; Jump if above
		OR	DX,DX			; Zero ?
		JS	LOC_RET_33		; Jump if sign=1
		ADD	DX,DS:DATA_34E		; (9966:000E=0)
		CMP	DX,DS:DATA_35E		; (9966:0010=0)
		JA	LOC_RET_33		; Jump if above
		PUSH	BP
		INT	10H			; Video display   ah=functn 00h
						;  set display mode in al
		POP	BP
  
LOC_RET_33:
		RETN
SUB_6		ENDP
  
		MOV	AH,0CH
		MOV	DS:DATA_37E,AX		; (9966:0014=0)
		POP	DI
		POP	AX
		POP	DX
		POP	BX
		MOV	DS:DATA_41E,BX		; (9966:001C=0)
		CALL	SUB_7			; (057D)
		MOV	DS:DATA_39E,CX		; (9966:0018=0)
		CALL	SUB_45			; (10D3)
		XCHG	AX,DX
		POP	BX
		PUSH	DI
		MOV	DS:DATA_40E,BX		; (9966:001A=0)
		CALL	SUB_7			; (057D)
		MOV	DS:DATA_38E,CX		; (9966:0016=0)
		CALL	SUB_45			; (10D3)
		MOV	BX,AX
		CMP	BX,DX
		JLE	LOC_37			; Jump if < or="MOV" ax,dx="" add="" ax,ax="" sub="" ax,bx="" mov="" ds:data_42e,ax="" ;="" (9966:001e="0)" mov="" cx,bx="" inc="" cx="" locloop_34:="" call="" sub_8="" ;="" (0589)="" mov="" ax,ds:data_42e="" ;="" (9966:001e="0)" or="" ax,ax="" ;="" zero="" jle="" loc_35="" ;="" jump="" if="">< or="ADD" ax,dx="" add="" ax,dx="" sub="" ax,bx="" sub="" ax,bx="" mov="" ds:data_42e,ax="" ;="" (9966:001e="0)" mov="" ax,ds:data_39e="" ;="" (9966:0018="0)" add="" ds:data_41e,ax="" ;="" (9966:001c="0)" jmp="" short="" loc_36="" ;="" (0538)="" loc_35:="" add="" ax,dx="" add="" ax,dx="" mov="" ds:data_42e,ax="" ;="" (9966:001e="0)" loc_36:="" mov="" ax,ds:data_38e="" ;="" (9966:0016="0)" add="" ds:data_40e,ax="" ;="" (9966:001a="0)" loop="" locloop_34="" ;="" loop="" if="" cx=""> 0
  
		RETN
LOC_37:
		MOV	AX,BX
		ADD	AX,AX
		SUB	AX,DX
		MOV	DS:DATA_42E,AX		; (9966:001E=0)
		MOV	CX,DX
		INC	CX
  
LOCLOOP_38:
		CALL	SUB_8			; (0589)
		MOV	AX,DS:DATA_42E		; (9966:001E=0)
		OR	AX,AX			; Zero ?
		JLE	LOC_39			; Jump if < or="ADD" ax,bx="" add="" ax,bx="" sub="" ax,dx="" sub="" ax,dx="" mov="" ds:data_42e,ax="" ;="" (9966:001e="0)" mov="" ax,ds:data_38e="" ;="" (9966:0016="0)" add="" ds:data_40e,ax="" ;="" (9966:001a="0)" jmp="" short="" loc_40="" ;="" (0573)="" loc_39:="" add="" ax,bx="" add="" ax,bx="" mov="" ds:data_42e,ax="" ;="" (9966:001e="0)" loc_40:="" mov="" ax,ds:data_39e="" ;="" (9966:0018="0)" add="" ds:data_41e,ax="" ;="" (9966:001c="0)" loop="" locloop_38="" ;="" loop="" if="" cx=""> 0
  
		RETN
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_7		PROC	NEAR
		XOR	CX,CX			; Zero register
		SUB	AX,BX
		JZ	LOC_RET_42		; Jump if zero
		JS	LOC_41			; Jump if sign=1
		INC	CX
		RETN
LOC_41:
		DEC	CX
  
LOC_RET_42:
		RETN
SUB_7		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_8		PROC	NEAR
		PUSH	CX
		PUSH	DX
		MOV	AX,DS:DATA_37E		; (9966:0014=0)
		MOV	CX,DS:DATA_40E		; (9966:001A=0)
		MOV	DX,DS:DATA_41E		; (9966:001C=0)
		CALL	SUB_6			; (04B8)
		POP	DX
		POP	CX
		RETN
SUB_8		ENDP
  
		MOV	BX,AX
		MOV	AX,34DDH
		MOV	DX,12H
		CMP	DX,BX
		JAE	LOC_RET_44		; Jump if above or =
		DIV	BX			; ax,dx rem=dx:ax/reg
		MOV	BX,AX
		IN	AL,61H			; port 61H, 8255 port B, read
		TEST	AL,3
		JNZ	LOC_43			; Jump if not zero
		OR	AL,3
		OUT	61H,AL			; port 61H, 8255 B - spkr, etc
		MOV	AL,0B6H
		OUT	43H,AL			; port 43H, 8253 wrt timr mode
LOC_43:
		MOV	AL,BL
		OUT	42H,AL			; port 42H, 8253 timer 2 spkr
		MOV	AL,BH
		OUT	42H,AL			; port 42H, 8253 timer 2 spkr
  
LOC_RET_44:
		RETN
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_9		PROC	NEAR
		IN	AL,61H			; port 61H, 8255 port B, read
		AND	AL,0FCH
		OUT	61H,AL			; port 61H, 8255 B - spkr, etc
						;  al = 0, disable parity
		RETN
SUB_9		ENDP
  
		XCHG	AX,CX
		POP	BX
		POP	DI
		JMP	SHORT LOC_47		; (05F8)
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_10		PROC	NEAR
LOC_45:
		PUSH	AX
		PUSH	CX
		MOV	CL,4
		SHR	AX,CL			; Shift w/zeros fill
		ADD	BX,AX
		POP	CX
		POP	AX
		AND	AX,0FH
		RETN
SUB_10		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_11		PROC	NEAR
		CMP	BX,DX
		JNE	LOC_RET_46		; Jump if not equal
		CMP	AX,CX
  
LOC_RET_46:
		RETN
SUB_11		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_12		PROC	NEAR
		ADD	AX,CX
		ADD	BX,DX
		JMP	SHORT LOC_45		; (05CF)
SUB_12		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_13		PROC	NEAR
		MOV	AX,ES:[DI+4]
		MOV	BX,ES:[DI+6]
		PUSH	AX
		OR	AX,BX
		POP	AX
		RETN
SUB_13		ENDP
  
		POP	BX
LOC_47:
		POP	ES
		PUSH	BX
		MOV	DS:DATA_46E,DI		; (9966:0026=0)
		MOV	WORD PTR DS:DATA_46E+2,ES	; (9966:0028=0)
		MOV	AX,CX
		ADD	AX,7
		MOV	BX,1000H
		JC	LOC_48			; Jump if carry Set
		XOR	BX,BX			; Zero register
LOC_48:
		AND	AL,0F8H
		CALL	SUB_10			; (05CF)
		MOV	CX,AX
		MOV	DX,BX
		MOV	WORD PTR DS:DATA_50E,22H	; (9966:002E=0)
		MOV	WORD PTR DS:DATA_50E+2,DS	; (9966:0030=9966H)
		LES	DI,DWORD PTR DS:DATA_44E	; (9966:0022=0) Load 32 bit ptr
LOC_49:
		CALL	SUB_13			; (05EA)
		JZ	LOC_52			; Jump if zero
		CALL	SUB_11			; (05DD)
		JNC	LOC_50			; Jump if carry=0
		MOV	DS:DATA_50E,DI		; (9966:002E=0)
		MOV	WORD PTR DS:DATA_50E+2,ES	; (9966:0030=9966H)
		LES	DI,DWORD PTR ES:[DI]	; Load 32 bit ptr
		JMP	SHORT LOC_49		; (0625)
LOC_50:
		CALL	SUB_14			; (06B2)
		JZ	LOC_51			; Jump if zero
		SUB	AX,CX
		SBB	BX,DX
		AND	AX,0FH
		JMP	SHORT LOC_54		; (0680)
LOC_51:
		LES	DI,DWORD PTR ES:[DI]	; Load 32 bit ptr
		JMP	SHORT LOC_55		; (06A3)
LOC_52:
		CALL	SUB_14			; (06B2)
		MOV	AX,DI
		MOV	BX,ES
		CALL	SUB_12			; (05E4)
		MOV	DATA_90,AX		; (9966:018A=5808H)
		MOV	DATA_91,BX		; (9966:018C=0CCFEH)
		PUSH	CX
		PUSH	DX
		MOV	CX,AX
		MOV	DX,BX
		MOV	AX,SP
		MOV	BX,SS
		SUB	BX,0EH
		CALL	SUB_10			; (05CF)
		XOR	AX,AX			; Zero register
		CALL	SUB_11			; (05DD)
		POP	DX
		POP	CX
		JA	LOC_53			; Jump if above
		JMP	LOC_143			; (0FEB)
LOC_53:
		XOR	AX,AX			; Zero register
		XOR	BX,BX			; Zero register
LOC_54:
		PUSH	BX
		PUSH	AX
		PUSH	WORD PTR ES:[DI+2]
		PUSH	WORD PTR ES:[DI]
		MOV	AX,DI
		MOV	BX,ES
		CALL	SUB_12			; (05E4)
		MOV	DI,AX
		MOV	ES,BX
		POP	WORD PTR ES:[DI]
		POP	WORD PTR ES:[DI+2]
		POP	WORD PTR ES:[DI+4]
		POP	WORD PTR ES:[DI+6]
LOC_55:
		PUSH	ES
		PUSH	ES
		LES	SI,DWORD PTR DS:DATA_50E	; (9966:002E=0) Load 32 bit ptr
		MOV	ES:[SI],DI
		POP	WORD PTR ES:[SI+2]
		POP	ES
		RETN
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_14		PROC	NEAR
		PUSH	ES
		PUSH	ES
		LES	SI,DWORD PTR DS:DATA_46E	; (9966:0026=0) Load 32 bit ptr
		MOV	ES:[SI],DI
		POP	WORD PTR ES:[SI+2]
		POP	ES
		RETN
SUB_14		ENDP
  
		XCHG	AX,CX
		POP	BX
		POP	DI
		JMP	SHORT LOC_56		; (06C7)
		POP	BX
LOC_56:
		POP	ES
		PUSH	BX
		MOV	AX,CX
		MOV	CX,ES:[DI]
		MOV	DX,ES:[DI+2]
		ADD	AX,7
		MOV	BX,1000H
		JC	LOC_57			; Jump if carry Set
		XOR	BX,BX			; Zero register
LOC_57:
		AND	AL,0F8H
		CALL	SUB_10			; (05CF)
		MOV	DS:DATA_48E,AX		; (9966:002A=0)
		MOV	DS:DATA_49E,BX		; (9966:002C=0)
		LES	DI,DWORD PTR DS:DATA_44E	; (9966:0022=0) Load 32 bit ptr
		MOV	AX,DI
		MOV	BX,ES
		CALL	SUB_11			; (05DD)
		JNC	LOC_61			; Jump if carry=0
LOC_58:
		MOV	AX,ES:[DI]
		MOV	BX,ES:[DI+2]
		CALL	SUB_11			; (05DD)
		JNC	LOC_59			; Jump if carry=0
		MOV	DI,AX
		MOV	ES,BX
		JMP	SHORT LOC_58		; (06F5)
LOC_59:
		PUSH	ES
		MOV	SI,CX
		MOV	ES,DX
		PUSH	WORD PTR DS:DATA_49E	; (9966:002C=0)
		PUSH	WORD PTR DS:DATA_48E	; (9966:002A=0)
		MOV	ES:[SI],AX
		MOV	ES:[SI+2],BX
		POP	WORD PTR ES:[SI+4]
		POP	WORD PTR ES:[SI+6]
		POP	ES
		MOV	ES:[DI],CX
		MOV	ES:[DI+2],DX
		MOV	AX,ES:[DI+4]
		MOV	BX,ES:[DI+6]
		CALL	SUB_15			; (0772)
		JZ	LOC_60			; Jump if zero
		LES	DI,DWORD PTR ES:[DI]	; Load 32 bit ptr
LOC_60:
		MOV	AX,ES:[DI+4]
		MOV	BX,ES:[DI+6]
		MOV	CX,ES:[DI]
		MOV	DX,ES:[DI+2]
		JMP	SHORT LOC_62		; (0772)
LOC_61:
		MOV	DS:DATA_44E,CX		; (9966:0022=0)
		MOV	WORD PTR DS:DATA_44E+2,DX	; (9966:0024=284H)
		MOV	DI,CX
		MOV	ES,DX
		MOV	ES:[DI],AX
		MOV	ES:[DI+2],BX
		MOV	CX,AX
		MOV	DX,BX
		MOV	AX,DS:DATA_48E		; (9966:002A=0)
		MOV	BX,DS:DATA_49E		; (9966:002C=0)
		MOV	ES:[DI+4],AX
		MOV	ES:[DI+6],BX
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_15		PROC	NEAR
LOC_62:
		MOV	DS:DATA_52E,AX		; (9966:0032=0)
		MOV	DS:DATA_53E,BX		; (9966:0034=0)
		ADD	AX,DI
		MOV	BX,ES
		ADD	BX,DS:DATA_53E		; (9966:0034=0)
		CALL	SUB_10			; (05CF)
		CALL	SUB_11			; (05DD)
		JNZ	LOC_RET_64		; Jump if not zero
		MOV	AX,DATA_90		; (9966:018A=5808H)
		MOV	BX,DATA_91		; (9966:018C=0CCFEH)
		CALL	SUB_11			; (05DD)
		JZ	LOC_63			; Jump if zero
		PUSH	ES
		MOV	SI,CX
		MOV	ES,DX
		MOV	AX,ES:[SI]
		MOV	BX,ES:[SI+2]
		MOV	CX,ES:[SI+4]
		MOV	DX,ES:[SI+6]
		POP	ES
		MOV	ES:[DI],AX
		MOV	ES:[DI+2],BX
		MOV	AX,DS:DATA_52E		; (9966:0032=0)
		MOV	BX,DS:DATA_53E		; (9966:0034=0)
		CALL	SUB_12			; (05E4)
		MOV	ES:[DI+4],AX
		MOV	ES:[DI+6],BX
		XOR	AX,AX			; Zero register
		RETN
LOC_63:
		MOV	DATA_90,DI		; (9966:018A=5808H)
		MOV	DATA_91,ES		; (9966:018C=0CCFEH)
		PUSH	DI
		XOR	AX,AX			; Zero register
		CLD				; Clear direction
		MOV	CX,4
		REP	STOSW			; Rep when cx >0 Store ax to es:[di]
		POP	DI
		XOR	AX,AX			; Zero register
  
LOC_RET_64:
		RETN
SUB_15		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_16		PROC	NEAR
		XOR	CX,CX			; Zero register
		XOR	DX,DX			; Zero register
		XOR	SI,SI			; Zero register
		LES	DI,DWORD PTR DS:DATA_44E	; (9966:0022=0) Load 32 bit ptr
LOC_65:
		CALL	SUB_13			; (05EA)
		JZ	LOC_66			; Jump if zero
		CALL	SUB_17			; (080A)
		LES	DI,DWORD PTR ES:[DI]	; Load 32 bit ptr
		JMP	SHORT LOC_65		; (07E5)
LOC_66:
		MOV	AX,SP
		MOV	BX,SS
		SUB	BX,10H
		CALL	SUB_10			; (05CF)
		XOR	AX,AX			; Zero register
		SUB	BX,DATA_91		; (9966:018C=0CCFEH)
		JC	LOC_67			; Jump if carry Set
		CALL	SUB_17			; (080A)
LOC_67:
		MOV	AX,DX
		RETN
SUB_16		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_17		PROC	NEAR
		CMP	SI,BX
		JAE	LOC_68			; Jump if above or =
		MOV	SI,BX
LOC_68:
		CALL	SUB_12			; (05E4)
		MOV	CX,AX
		MOV	DX,BX
		RETN
SUB_17		ENDP
  
		CALL	SUB_16			; (07DB)
		MOV	AX,SI
		RETN
		POP	BX
		POP	ES
		MOV	AX,DATA_90		; (9966:018A=5808H)
		MOV	ES:[DI],AX
		MOV	DX,DATA_91		; (9966:018C=0CCFEH)
		MOV	ES:[DI+2],DX
		JMP	BX			;*Register jump
		POP	BX
		POP	ES
		LES	DI,DWORD PTR ES:[DI]	; Load 32 bit ptr
		MOV	DATA_90,DI		; (9966:018A=5808H)
		MOV	DS:DATA_44E,DI		; (9966:0022=0)
		MOV	DATA_91,ES		; (9966:018C=0CCFEH)
		MOV	WORD PTR DS:DATA_44E+2,ES	; (9966:0024=284H)
		XOR	AX,AX			; Zero register
		LES	DI,DWORD PTR DS:DATA_44E	; (9966:0022=0) Load 32 bit ptr
		MOV	CX,4
		CLD				; Clear direction
		REP	STOSW			; Rep when cx >0 Store ax to es:[di]
		JMP	BX			;*Register jump
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_18		PROC	NEAR
		CMP	BYTE PTR DATA_94,0	; (9966:0192=97H)
		MOV	AL,0FFH
		JNZ	LOC_69			; Jump if not zero
		MOV	AH,1
		INT	16H			; Keyboard i/o  ah=function 01h
						;  get status, if zf=0  al=char
		MOV	AL,0
		JZ	LOC_69			; Jump if zero
		DEC	AL
LOC_69:
		AND	AX,1
		RETN	1
SUB_18		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_19		PROC	NEAR
		MOV	AL,BYTE PTR DATA_94	; (9966:0192=97H)
		MOV	BYTE PTR DATA_94,0	; (9966:0192=97H)
		OR	AL,AL			; Zero ?
		JNZ	LOC_71			; Jump if not zero
		XOR	AH,AH			; Zero register
		INT	16H			; Keyboard i/o  ah=function 00h
						;  get keybd char in al, ah=scan
		OR	AL,AL			; Zero ?
		JNZ	LOC_70			; Jump if not zero
		MOV	BYTE PTR DATA_94,AH	; (9966:0192=97H)
		MOV	AL,1BH
		OR	AH,AH			; Zero ?
		JNZ	LOC_71			; Jump if not zero
		MOV	AL,3
LOC_70:
		CMP	DATA_95,1		; (9966:0194=0FFH)
		JNE	LOC_71			; Jump if not equal
		CMP	AL,3
		JNE	LOC_71			; Jump if not equal
		JMP	LOC_146			; (1016)
LOC_71:
		XOR	AH,AH			; Zero register
		RETN	1
SUB_19		ENDP
  
		POP	AX
		POP	DX
		PUSH	AX
		PUSH	DX
		PUSH	BP
		PUSH	DX
		CALL	SUB_3			; (02A3)
		POP	AX
		CMP	AL,0DH
		JNE	LOC_72			; Jump if not equal
		MOV	DL,DS:DATA_26E		; (9966:0004=0)
		JMP	SHORT LOC_77		; (091B)
LOC_72:
		CMP	AL,0AH
		JNE	LOC_73			; Jump if not equal
		INC	DH
		CMP	DH,BYTE PTR CS:DATA_73+1	; (9966:016B=19H)
		JB	LOC_77			; Jump if below
		JMP	SHORT LOC_76		; (0901)
LOC_73:
		CMP	AL,8
		JNE	LOC_74			; Jump if not equal
		CMP	DL,DS:DATA_26E		; (9966:0004=0)
		JE	LOC_77			; Jump if equal
		DEC	DL
		JMP	SHORT LOC_77		; (091B)
LOC_74:
		CMP	AL,7
		JNE	LOC_75			; Jump if not equal
		MOV	AH,0EH
		XOR	BH,BH			; Zero register
		INT	10H			; Video display   ah=functn 0Eh
						;  write char al, teletype mode
		JMP	SHORT LOC_78		; (0921)
LOC_75:
		PUSH	DX
		MOV	AH,9
		XOR	BH,BH			; Zero register
		MOV	CX,1
		MOV	BL,DS:DATA_30E		; (9966:0008=0)
		INT	10H			; Video display   ah=functn 09h
						;  set char al & attrib bl @curs
		POP	DX
		INC	DL
		CMP	DL,BYTE PTR CS:DATA_73	; (9966:016A=50H)
		JB	LOC_77			; Jump if below
		MOV	DL,DS:DATA_26E		; (9966:0004=0)
		INC	DH
		CMP	DH,BYTE PTR CS:DATA_73+1	; (9966:016B=19H)
		JB	LOC_77			; Jump if below
LOC_76:
		DEC	DH
		PUSH	DX
		MOV	AX,601H
		MOV	BH,DS:DATA_30E		; (9966:0008=0)
		MOV	CX,DS:DATA_26E		; (9966:0004=0)
		MOV	DX,CS:DATA_73		; (9966:016A=1950H)
		DEC	DH
		DEC	DL
		INT	10H			; Video display   ah=functn 06h
						;  scroll up, al=lines
		POP	DX
LOC_77:
		MOV	AH,2
		XOR	BH,BH			; Zero register
		INT	10H			; Video display   ah=functn 02h
						;  set cursor location in dx
LOC_78:
		POP	BP
		CMP	DATA_95,1		; (9966:0194=0FFH)
		JNE	LOC_79			; Jump if not equal
		DEC	SP
		CALL	SUB_18			; (0853)
		JZ	LOC_79			; Jump if zero
		DEC	SP
		CALL	SUB_19			; (086C)
		CMP	AL,13H
		JNE	LOC_79			; Jump if not equal
		DEC	SP
		CALL	SUB_19			; (086C)
LOC_79:
		POP	AX
		RETN
		POP	AX
		POP	DX
		PUSH	AX
		MOV	AH,5
		JMP	SHORT LOC_80		; (0957)
		NOP
		POP	AX
		POP	DX
		PUSH	AX
		MOV	AH,4
		JMP	SHORT LOC_80		; (0957)
		NOP
		MOV	AH,3
		CALL	SUB_20			; (0957)
		XOR	AH,AH			; Zero register
		RETN	1
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_20		PROC	NEAR
LOC_80:
		CMP	AH,3DH			; '='
		JE	LOC_82			; Jump if equal
		CMP	AH,3CH			; '<' je="" loc_82="" ;="" jump="" if="" equal="" cmp="" ah,3eh="" ;="" '="">'
		JE	LOC_86			; Jump if equal
		CMP	AH,80H
		JE	LOC_89			; Jump if equal
  
;==== External Entry into Subroutine ======================================
  
SUB_21:
LOC_81:
		PUSH	BP
		INT	21H			; DOS Services  ah=function 00h
						;  terminate, cs=progm seg prefx
		POP	BP
		RETN
LOC_82:
		PUSH	SI
		PUSH	CX
		MOV	SI,DATA_81		; (9966:017A=2E4FH)
		MOV	CX,DATA_82		; (9966:017C=278AH)
  
LOCLOOP_83:
		CMP	WORD PTR [SI],0
		JE	LOC_84			; Jump if equal
		INC	SI
		INC	SI
		LOOP	LOCLOOP_83		; Loop if cx > 0
  
		POP	CX
		POP	SI
		MOV	AX,4
		STC				; Set carry flag
		RETN
LOC_84:
		POP	CX
		PUSH	DS
		PUSH	ES
		POP	DS
		CALL	SUB_21			; (096B)
		POP	DS
		JC	LOC_85			; Jump if carry Set
		MOV	[SI],AX
LOC_85:
		POP	SI
		RETN
LOC_86:
		PUSH	CX
		PUSH	SI
		MOV	SI,DATA_81		; (9966:017A=2E4FH)
		MOV	CX,DATA_82		; (9966:017C=278AH)
  
LOCLOOP_87:
		CMP	[SI],BX
		JNE	LOC_88			; Jump if not equal
		MOV	WORD PTR [SI],0
LOC_88:
		INC	SI
		INC	SI
		LOOP	LOCLOOP_87		; Loop if cx > 0
  
		POP	SI
		POP	CX
		JMP	SHORT LOC_81		; (096B)
LOC_89:
		MOV	SI,DATA_81		; (9966:017A=2E4FH)
		MOV	CX,DATA_82		; (9966:017C=278AH)
  
LOCLOOP_90:
		MOV	BX,[SI]
		OR	BX,BX			; Zero ?
		JZ	LOC_91			; Jump if zero
		MOV	AH,3EH			; '>'
		CALL	SUB_21			; (096B)
		MOV	WORD PTR [SI],0
LOC_91:
		INC	SI
		INC	SI
		LOOP	LOCLOOP_90		; Loop if cx > 0
  
		RETN
SUB_20		ENDP
  
		XOR	AX,AX			; Zero register
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_22		PROC	NEAR
		MOV	DATA_77,AX		; (9966:0172=0F70H)
		MOV	DI,240H
		MOV	DATA_81,DI		; (9966:017A=2E4FH)
		MOV	DATA_82,CX		; (9966:017C=278AH)
		XOR	AX,AX			; Zero register
		PUSH	DS
		POP	ES
		CLD				; Clear direction
		REP	STOSW			; Rep when cx >0 Store ax to es:[di]
		MOV	ES,AX
		MOV	WORD PTR ES:DATA_6E,0A62H	; (0000:008C=8F7H)
		MOV	ES:DATA_7E,CS		; (0000:008E=428DH)
		CALL	SUB_1			; (0199)
  
;==== External Entry into Subroutine ======================================
  
SUB_23:
		MOV	DATA_95,0		; (9966:0194=0FFH)
  
;==== External Entry into Subroutine ======================================
  
SUB_24:
		MOV	SI,0A26H
		MOV	DI,136H
		PUSH	DS
		POP	ES
		PUSH	CS
		POP	DS
		MOV	CX,1EH
		CLD				; Clear direction
		REP	MOVSW			; Rep when cx >0 Mov [si] to es:[di]
		PUSH	ES
		POP	DS
		XOR	AX,AX			; Zero register
		MOV	DATA_94,AX		; (9966:0192=97H)
		MOV	DATA_84,AL		; (9966:0180=0F9H)
		MOV	DATA_86,AX		; (9966:0182=430EH)
		MOV	DATA_87,AX		; (9966:0184=8A2EH)
		MOV	DATA_85,7EH		; (9966:0181=74H) '~'
		MOV	BYTE PTR DS:DATA_54E,0DH	; (9966:0036=0)
		RETN
SUB_22		ENDP
  
		PUSH	BX
		OR	[SI+8],CH
		LAHF				; Load ah from flags
		OR	[DI],BH
		OR	[DI+9],AX
		DEC	BP
		OR	DS:DATA_147E[BX],BX	; (9966:6C08=0FFFFH)
		OR	BH,BH			; Zero ?
		INC	CX
		ADD	BH,BH
		INC	WORD PTR [BP+SI-100H]
		INC	WORD PTR [BP+DI+0]
		DB	0FFH,0FFH,0C4H, 00H,0FFH,0FFH
		DB	0C5H, 00H,0FFH,0FFH,0C1H
		DB	9 DUP (0)
		DB	0FFH,0FFH,0C1H
		DB	9 DUP (0)
		DB	0CFH
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_25		PROC	NEAR
LOC_92:
		PUSH	BX
		PUSH	CX
		PUSH	DX
		PUSH	DI
		PUSH	SI
		XOR	AH,AH			; Zero register
		PUSH	AX
		CALL	DATA_61			; (9966:013A=0)
LOC_93:
		POP	SI
		POP	DI
		POP	DX
		POP	CX
		POP	BX
		RETN
SUB_25		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_26		PROC	NEAR
		PUSH	BX
		PUSH	CX
		PUSH	DX
		PUSH	DI
		PUSH	SI
		DEC	SP
		CALL	DATA_60			; (9966:0138=0)
		JMP	SHORT LOC_93		; (0A6F)
SUB_26		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_27		PROC	NEAR
		PUSH	BP
		MOV	BP,SP
		XCHG	BX,[BP+2]
LOC_94:
		MOV	AL,CS:[BX]
		INC	BX
		OR	AL,AL			; Zero ?
		JZ	LOC_95			; Jump if zero
		CALL	SUB_25			; (0A63)
		JMP	SHORT LOC_94		; (0A87)
LOC_95:
		XCHG	BX,[BP+2]
		POP	BP
		RETN
SUB_27		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_28		PROC	NEAR
		CALL	SUB_27			; (0A81)
		OR	AX,0AH
		RETN
SUB_28		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_29		PROC	NEAR
LOC_96:
		CMP	AL,61H			; 'a'
		JB	LOC_RET_97		; Jump if below
		CMP	AL,7AH			; 'z'
		JA	LOC_RET_97		; Jump if above
		SUB	AL,20H			; ' '
  
LOC_RET_97:
		RETN
SUB_29		ENDP
  
		PUSH	AX
		MOV	AL,AH
		CALL	SUB_30			; (0AB2)
		POP	AX
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_30		PROC	NEAR
		PUSH	AX
		ROR	AL,1			; Rotate
		ROR	AL,1			; Rotate
		ROR	AL,1			; Rotate
		ROR	AL,1			; Rotate
		CALL	SUB_31			; (0ABF)
		POP	AX
  
;==== External Entry into Subroutine ======================================
  
SUB_31:
		AND	AL,0FH
		ADD	AL,90H
		DAA				; Decimal adjust
		ADC	AL,40H			; '@'
		DAA				; Decimal adjust
		JMP	SHORT LOC_92		; (0A63)
SUB_30		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_32		PROC	NEAR
		OR	AH,AH			; Zero ?
		JZ	LOC_RET_98		; Jump if zero
		STC				; Set carry flag
		MOV	AX,0
		JS	LOC_RET_98		; Jump if sign=1
		DEC	AL
  
LOC_RET_98:
		RETN
SUB_32		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_33		PROC	NEAR
		CALL	SUB_34			; (0C27)
		POP	SI
		MOV	AX,CS
		ADD	AX,CS:[SI+6]
		ADD	AX,CS:[SI+8]
		ADD	AX,CS:[SI+0AH]
		CMP	AX,CS:DATA_25E		; (9966:0002=0)
		JBE	LOC_99			; Jump if below or =
		JMP	LOC_108			; (0C36)
LOC_99:
		MOV	BX,CS
		ADD	BX,CS:[SI+6]
		MOV	DS,BX
		ADD	BX,CS:[SI+8]
		MOV	DX,CS:DATA_25E		; (9966:0002=0)
		SUB	DX,BX
		CMP	DX,CS:[SI+0CH]
		JB	LOC_100			; Jump if below
		MOV	DX,CS:[SI+0CH]
LOC_100:
		MOV	DI,DX
		MOV	AX,0FFFEH
		SUB	DX,1000H
		JNC	LOC_101			; Jump if carry=0
		MOV	AX,DX
		ADD	AX,1000H
		MOV	CL,4
		SHL	AX,CL			; Shift w/zeros fill
		XOR	DX,DX			; Zero register
LOC_101:
		ADD	DX,BX
		MOV	SS,DX
		MOV	SP,AX
		MOV	DATA_78,AX		; (9966:0174=707H)
		XOR	AX,AX			; Zero register
		MOV	DATA_90,AX		; (9966:018A=5808H)
		MOV	DATA_91,BX		; (9966:018C=0CCFEH)
		MOV	DS:DATA_44E,AX		; (9966:0022=0)
		MOV	WORD PTR DS:DATA_44E+2,BX	; (9966:0024=284H)
		PUSH	DI
		LES	DI,DWORD PTR DS:DATA_44E	; (9966:0022=0) Load 32 bit ptr
		MOV	CX,4
		CLD				; Clear direction
		REP	STOSW			; Rep when cx >0 Store ax to es:[di]
		POP	DI
		TEST	WORD PTR CS:[SI],1
		JNZ	LOC_102			; Jump if not zero
		MOV	AX,CS
		MOV	ES,AX
		ADD	BX,DI
		SUB	BX,AX
		MOV	AH,4AH			; 'J'
		CALL	SUB_20			; (0957)
LOC_102:
		MOV	AX,CS:[SI+2]
		MOV	DATA_79,AX		; (9966:0176=0E70H)
		MOV	AX,CS:[SI+4]
		MOV	DATA_80,AX		; (9966:0178=707H)
		MOV	AX,CS:[SI]
		MOV	CX,CS:[SI+0EH]
		PUSH	CX
		PUSH	SI
		CALL	SUB_22			; (09D0)
		POP	SI
		POP	CX
		MOV	DI,240H
		ADD	DI,CX
		ADD	DI,CX
		MOV	DATA_69,DI		; (9966:015E=656DH)
		MOV	AX,CS:[SI+10H]
		MOV	DATA_70,AX		; (9966:0160=6420H)
		ADD	DI,AX
		OR	AX,AX			; Zero ?
		JZ	LOC_103			; Jump if zero
		MOV	DATA_67,0		; (9966:015A=6863H)
		MOV	DATA_68,0		; (9966:015C=72H)
LOC_103:
		MOV	DATA_73,DI		; (9966:016A=1950H)
		MOV	AX,CS:[SI+12H]
		MOV	DATA_75,AX		; (9966:016C=701H)
		OR	AX,AX			; Zero ?
		JZ	LOC_104			; Jump if zero
		MOV	DATA_71,1		; (9966:0166=7961H)
		MOV	DATA_72,0		; (9966:0168=35H)
LOC_104:
		ADD	SI,14H
		PUSH	SI
		XOR	AX,AX			; Zero register
		MOV	ES,AX
		MOV	AX,ES:DATA_1E		; (0000:0000=6668H)
		MOV	DATA_92,AX		; (9966:018E=0F375H)
		MOV	AX,ES:DATA_2E		; (0000:0002=284H)
		MOV	DATA_93,AX		; (9966:0190=0C3F8H)
		MOV	WORD PTR ES:DATA_1E,1032H	; (0000:0000=6668H)
		nop				;*ASM fixup - sign extn byte
		MOV	ES:DATA_2E,CS		; (0000:0002=284H)
		TEST	DATA_77,8		; (9966:0172=0F70H)
		JZ	LOC_105			; Jump if zero
		MOV	WORD PTR ES:DATA_3E,0FF0H	; (0000:000C=7FBH)
		MOV	ES:DATA_4E,CS		; (0000:000E=70H)
LOC_105:
		TEST	DATA_77,4		; (9966:0172=0F70H)
		JZ	LOC_106			; Jump if zero
		MOV	DATA_95,1		; (9966:0194=0FFH)
LOC_106:
		MOV	DATA_83,10D0H		; (9966:017E=0E40AH)
		XOR	AX,AX			; Zero register
		MOV	DATA_89,AX		; (9966:0188=0D8E8H)
		MOV	BYTE PTR DATA_96+1,AL	; (9966:0196=0FEH)
		MOV	CX,DATA_70		; (9966:0160=6420H)
		PUSH	DS
		MOV	DI,15AH
		CALL	SUB_96			; (232A)
		MOV	CX,DATA_75		; (9966:016C=701H)
		PUSH	DS
		MOV	DI,166H
		CALL	SUB_97			; (232E)
		MOV	BYTE PTR DS:[1FAH],0	; (9966:01FA=0FAH)
		CALL	SUB_4			; (02C8)
		RETN
  
;==== External Entry into Subroutine ======================================
  
SUB_34:
		MOV	AH,30H			; '0'
		CALL	SUB_20			; (0957)
		OR	AL,AL			; Zero ?
		JZ	LOC_107			; Jump if zero
		RETN
LOC_107:
		MOV	DX,0C5FH
		JMP	SHORT LOC_109		; (0C39)
LOC_108:
		MOV	DX,0C4DH
LOC_109:
		PUSH	CS
		POP	DS
		MOV	AH,9
		CALL	SUB_20			; (0957)
		MOV	DX,0C75H
		MOV	AH,9
		CALL	SUB_20			; (0957)
		MOV	AH,0
		CALL	SUB_20			; (0957)
		DB	'Not enough memory$'
		DB	'Incorrect DOS version$'
		DB	0DH, 0AH, 'Program aborted', 0DH, 0AH
		DB	'$'
		DB	'P'
		DB	 1EH,0BFH, 5AH, 01H,0E8H,0C2H
		DB	 17H, 1EH,0BFH, 66H, 01H,0E8H
		DB	0BBH, 17H, 33H,0C0H, 8EH,0C0H
		DB	0A1H, 8EH, 01H, 26H,0A3H, 00H
		DB	 00H,0A1H, 90H, 01H, 26H,0A3H
		DB	 02H, 00H, 58H,0F7H, 06H, 72H
		DB	 01H, 01H, 00H, 75H, 05H,0B4H
		DB	 4CH,0E8H, 9FH,0FCH,0B4H, 80H
		DB	0E8H, 9AH,0FCH,0FFH, 36H, 76H
		DB	 01H,0B8H, 02H, 3DH, 50H, 1EH
		DB	 07H, 8EH, 1EH, 78H, 01H,0CBH
SUB_33		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_36		PROC	NEAR
		POP	BX
		MOV	AX,CS:[BX]
		OR	AX,AX			; Zero ?
		JZ	LOC_113			; Jump if zero
		PUSH	DS
		PUSH	CS
		POP	DS
		PUSH	CS
		POP	ES
		XOR	DX,DX			; Zero register
LOC_110:
		MOV	AX,[BX]
		OR	AX,AX			; Zero ?
		JZ	LOC_111			; Jump if zero
		PUSH	BX
		ADD	BX,AX
		INC	DX
		JMP	SHORT LOC_110		; (0CDB)
LOC_111:
		MOV	CX,BX
		POP	BX
		MOV	SI,BX
		ADD	SI,4
		MOV	DI,[BX+2]
		CMP	SI,DI
		JE	LOC_112			; Jump if equal
		SUB	CX,SI
		ADD	SI,CX
		ADD	DI,CX
		DEC	SI
		DEC	DI
		STD				; Set direction flag
		REP	MOVSB			; Rep when cx >0 Mov [si] to es:[di]
LOC_112:
		DEC	DX
		JNZ	LOC_111			; Jump if not zero
		MOV	WORD PTR [BX],0
		POP	DS
LOC_113:
		ADD	BX,4
		JMP	BX			;*Register jump
		POP	SI
		CMP	DX,CS:[SI]
		JNE	LOC_115			; Jump if not equal
LOC_114:
		ADD	SI,0FH
		JMP	SI			;*Register jump
LOC_115:
		PUSH	AX
		PUSH	DX
		PUSH	SI
		MOV	DI,196H
		XOR	AL,AL			; Zero register
LOC_116:
		MOV	AH,AL
		MOV	AL,[DI]
		OR	AL,AL			; Zero ?
		JZ	LOC_117			; Jump if zero
		INC	DI
		JMP	SHORT LOC_116		; (0D21)
LOC_117:
		PUSH	DI
		OR	AH,AH			; Zero ?
		JZ	LOC_118			; Jump if zero
		CMP	AH,3AH			; ':'
		JE	LOC_118			; Jump if equal
		CMP	AH,5CH			; '\'
		JE	LOC_118			; Jump if equal
		MOV	BYTE PTR [DI],5CH	; '\'
		INC	DI
LOC_118:
		INC	SI
		INC	SI
LOC_119:
		MOV	AL,CS:[SI]
		MOV	[DI],AL
		INC	SI
		INC	DI
		OR	AL,AL			; Zero ?
		JNZ	LOC_119			; Jump if not zero
		MOV	AX,3D00H
		MOV	DX,196H
		PUSH	DS
		POP	ES
		CALL	SUB_20			; (0957)
		MOV	BX,AX
		POP	DI
		POP	SI
		POP	DX
		MOV	BYTE PTR [DI],0
		JC	LOC_120			; Jump if carry Set
		MOV	CS:[SI],DX
		MOV	AX,4200H
		XOR	CH,CH			; Zero register
		MOV	CL,DH
		MOV	DH,DL
		XOR	DL,DL			; Zero register
		CALL	SUB_20			; (0957)
		POP	CX
		JC	LOC_120			; Jump if carry Set
		MOV	AH,3FH			; '?'
		LEA	DX,[SI+0FH]		; Load effective addr
		PUSH	DS
		PUSH	CS
		POP	DS
		CALL	SUB_20			; (0957)
		POP	DS
		JC	LOC_120			; Jump if carry Set
		MOV	AH,3EH			; '>'
		CALL	SUB_20			; (0957)
		JMP	SHORT LOC_114		; (0D14)
LOC_120:
		MOV	DL,0F0H
		PUSH	SI
		JMP	LOC_148			; (1038)
SUB_36		ENDP
  
		POP	BX
		CALL	SUB_38			; (0EE6)
		PUSH	BX
		MOV	SI,0B6H
		MOV	DI,196H
		PUSH	DS
		POP	ES
		MOV	CX,20H
		CLD				; Clear direction
		REP	MOVSW			; Rep when cx >0 Mov [si] to es:[di]
		RETN
		DEC	SP
		CALL	DATA_59			; (9966:0136=0)
		RETN
		POP	BX
		POP	CX
		PUSH	BX
		MOV	DL,AL
		MOV	DH,CL
		DEC	DL
		DEC	DH
		JMP	LOC_15			; (0343)
		MOV	DX,AX
		OR	DX,DX			; Zero ?
		JZ	LOC_121			; Jump if zero
		CALL	SUB_37			; (0DD7)
		XCHG	AX,BX
LOC_121:
		POP	BX
		SUB	SP,AX
		DEC	SP
		MOV	DI,SP
		PUSH	DS
		PUSH	CS
		POP	DS
		PUSH	SS
		POP	ES
		CLD				; Clear direction
		STOSB				; Store al to es:[di]
		XCHG	AX,CX
		REP	MOVSB			; Rep when cx >0 Mov [si] to es:[di]
		POP	DS
		JMP	BX			;*Register jump
		XOR	DX,DX			; Zero register
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_37		PROC	NEAR
		MOV	DI,80H
		MOV	CL,CS:[DI]
		XOR	CH,CH			; Zero register
		INC	DI
		XOR	BX,BX			; Zero register
LOC_122:
		JCXZ	LOC_124			; Jump if cx=0
		MOV	AL,CS:[DI]
		CMP	AL,20H			; ' '
		JE	LOC_123			; Jump if equal
		CMP	AL,9
		JNE	LOC_124			; Jump if not equal
LOC_123:
		INC	DI
		DEC	CX
		JMP	SHORT LOC_122		; (0DE2)
LOC_124:
		MOV	SI,DI
LOC_125:
		JCXZ	LOC_126			; Jump if cx=0
		MOV	AL,CS:[DI]
		CMP	AL,20H			; ' '
		JE	LOC_126			; Jump if equal
		CMP	AL,9
		JE	LOC_126			; Jump if equal
		INC	DI
		DEC	CX
		JMP	SHORT LOC_125		; (0DF5)
LOC_126:
		MOV	AX,DI
		SUB	AX,SI
		JZ	LOC_127			; Jump if zero
		INC	BX
		DEC	DX
		JNZ	LOC_122			; Jump if not zero
LOC_127:
		XCHG	AX,BX
		RETN
SUB_37		ENDP
  
		MOV	BYTE PTR DS:[1E6H],CL	; (9966:01E6=0E8H)
		MOV	WORD PTR DS:[1E8H],DI	; (9966:01E8=2E00H)
		POP	BX
		POP	WORD PTR DS:[1EAH]	; (9966:01EA=6FFH)
		POP	CX
		POP	AX
		PUSH	BX
		PUSH	CX
		MOV	BX,0B6H
		CALL	SUB_47			; (111B)
		JMP	SHORT LOC_128		; (0E4E)
		MOV	BYTE PTR DS:[1E6H],CL	; (9966:01E6=0E8H)
		MOV	WORD PTR DS:[1E8H],DI	; (9966:01E8=2E00H)
		POP	BX
		POP	WORD PTR DS:[1EAH]	; (9966:01EA=6FFH)
		POP	DX
		POP	AX
		MOV	DI,1F4H
		POP	WORD PTR [DI]
		POP	WORD PTR [DI+2]
		POP	WORD PTR [DI+4]
		PUSH	BX
		PUSH	AX
		XCHG	AX,CX
		MOV	BX,0B6H
		CALL	SUB_82			; (1F45)
LOC_128:
		POP	CX
		LES	DI,DWORD PTR DS:[1E8H]	; (9966:01E8=2E00H) Load 32 bit ptr
		PUSH	DI
		MOV	DL,BYTE PTR DS:[1E6H]	; (9966:01E6=0E8H)
		XOR	DH,DH			; Zero register
		XCHG	AX,BX
		SUB	AX,0B6H
		SUB	CX,AX
		JBE	LOC_130			; Jump if below or =
  
LOCLOOP_129:
		INC	DI
		MOV	BYTE PTR ES:[DI],20H	; ' '
		INC	DH
		CMP	DH,DL
		JE	LOC_132			; Jump if equal
		LOOP	LOCLOOP_129		; Loop if cx > 0
  
LOC_130:
		XCHG	AX,CX
		MOV	BX,0B6H
  
LOCLOOP_131:
		MOV	AL,[BX]
		INC	BX
		INC	DI
		MOV	ES:[DI],AL
		INC	DH
		CMP	DH,DL
		JE	LOC_132			; Jump if equal
		LOOP	LOCLOOP_131		; Loop if cx > 0
  
LOC_132:
		POP	DI
		MOV	ES:[DI],DH
		RETN
		XOR	AL,AL			; Zero register
		JMP	SHORT LOC_133		; (0E8D)
		MOV	AL,1
LOC_133:
		MOV	BYTE PTR DS:[1E7H],AL	; (9966:01E7=34H)
		MOV	WORD PTR DS:[1F0H],DI	; (9966:01F0=943EH)
		POP	BX
		POP	WORD PTR DS:[1F2H]	; (9966:01F2=0FF01H)
		POP	WORD PTR DS:[1ECH]	; (9966:01EC=192H)
		POP	WORD PTR DS:[1EEH]	; (9966:01EE=802EH)
		CALL	SUB_39			; (0EEB)
		PUSH	BX
		XOR	AX,AX			; Zero register
		MOV	BX,0B6H
		CMP	[BX],AL
		JE	LOC_137			; Jump if equal
		CMP	BYTE PTR DS:[1E7H],AL	; (9966:01E7=34H)
		JNE	LOC_134			; Jump if not equal
		CALL	SUB_50			; (11A7)
		JC	LOC_136			; Jump if carry Set
		LES	DI,DWORD PTR DS:[1ECH]	; (9966:01EC=192H) Load 32 bit ptr
		MOV	ES:[DI],AX
		JMP	SHORT LOC_135		; (0ED4)
LOC_134:
		MOV	DI,1F4H
		CALL	SUB_88			; (20CD)
		JC	LOC_136			; Jump if carry Set
		MOV	SI,DI
		LES	DI,DWORD PTR DS:[1ECH]	; (9966:01EC=192H) Load 32 bit ptr
		CLD				; Clear direction
		MOVSW				; Mov [si] to es:[di]
		MOVSW				; Mov [si] to es:[di]
		MOVSW				; Mov [si] to es:[di]
LOC_135:
		XOR	AX,AX			; Zero register
		CMP	[BX],AL
		JE	LOC_137			; Jump if equal
LOC_136:
		XCHG	AX,BX
		SUB	AX,0B5H
LOC_137:
		LES	DI,DWORD PTR DS:[1F0H]	; (9966:01F0=943EH) Load 32 bit ptr
		MOV	ES:[DI],AX
		RETN
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_38		PROC	NEAR
		MOV	CX,40H
		JMP	SHORT LOC_138		; (0EEE)
  
;==== External Entry into Subroutine ======================================
  
SUB_39:
		MOV	CX,7FH
LOC_138:
		MOV	DI,0B6H
		POP	AX
		MOV	SI,SP
		MOV	DL,SS:[SI]
		XOR	DH,DH			; Zero register
		CMP	CX,DX
		JBE	LOC_139			; Jump if below or =
		MOV	CX,DX
LOC_139:
		INC	DX
		INC	SI
		MOV	DI,0B6H
		PUSH	DS
		POP	ES
		PUSH	SS
		POP	DS
		CLD				; Clear direction
		REP	MOVSB			; Rep when cx >0 Mov [si] to es:[di]
		PUSH	ES
		POP	DS
		MOV	BYTE PTR [DI],0
		ADD	SP,DX
		JMP	AX			;*Register jump
		MOV	AH,2CH			; ','
		CALL	SUB_20			; (0957)
		MOV	WORD PTR DS:[1FEH],CX	; (9966:01FE=2E02H)
		MOV	WORD PTR DS:[1FCH],DX	; (9966:01FC=4489H)
		RETN
SUB_38		ENDP
  
		POP	BX
		MOV	DX,DS
		MOV	SI,DI
		POP	DS
		POP	DI
		POP	ES
		CLD				; Clear direction
		REP	MOVSB			; Rep when cx >0 Mov [si] to es:[di]
		MOV	DS,DX
		JMP	BX			;*Register jump
		POP	BX
		MOV	DX,DS
		MOV	SI,DI
		POP	DS
		SUB	SP,CX
		MOV	DI,SP
		PUSH	SS
		POP	ES
		CLD				; Clear direction
		REP	MOVSB			; Rep when cx >0 Mov [si] to es:[di]
		MOV	DS,DX
		JMP	BX			;*Register jump
		POP	BX
		POP	CX
		POP	DI
		POP	ES
		CLD				; Clear direction
		REP	STOSB			; Rep when cx >0 Store al to es:[di]
		JMP	BX			;*Register jump
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_40		PROC	NEAR
		XCHG	AX,CX
		MOV	DX,DS
		POP	BX
		POP	DI
		POP	ES
		POP	SI
		POP	DS
		CLD				; Clear direction
		CMP	SI,DI
		JAE	LOC_140			; Jump if above or =
		ADD	SI,CX
		ADD	DI,CX
		DEC	SI
		DEC	DI
		STD				; Set direction flag
LOC_140:
		REP	MOVSB			; Rep when cx >0 Mov [si] to es:[di]
		MOV	DS,DX
		JMP	BX			;*Register jump
  
;==== External Entry into Subroutine ======================================
  
SUB_41:
		POP	BX
		POP	AX
		PUSH	BP
		PUSH	DS
		PUSH	AX
		PUSH	DI
		PUSH	BX
		MOV	SI,DI
		MOV	DS,AX
		CLD				; Clear direction
		LODSW				; String [si] to ax
		PUSH	AX
		LODSW				; String [si] to ax
		MOV	BX,AX
		LODSW				; String [si] to ax
		MOV	CX,AX
		LODSW				; String [si] to ax
		MOV	DX,AX
		LODSW				; String [si] to ax
		MOV	BP,AX
		LODSW				; String [si] to ax
		PUSH	AX
		LODSW				; String [si] to ax
		MOV	DI,AX
		LODSW				; String [si] to ax
		PUSH	AX
		LODSW				; String [si] to ax
		MOV	ES,AX
		POP	DS
		POP	SI
		POP	AX
		RETN
SUB_40		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_42		PROC	NEAR
		PUSHF				; Push flags
		PUSH	ES
		PUSH	DI
		PUSH	BP
		MOV	BP,SP
		LES	DI,DWORD PTR [BP+0AH]	; Load 32 bit ptr
		CLD				; Clear direction
		STOSW				; Store ax to es:[di]
		MOV	AX,BX
		STOSW				; Store ax to es:[di]
		MOV	AX,CX
		STOSW				; Store ax to es:[di]
		MOV	AX,DX
		STOSW				; Store ax to es:[di]
		POP	AX
		STOSW				; Store ax to es:[di]
		MOV	AX,SI
		STOSW				; Store ax to es:[di]
		POP	AX
		STOSW				; Store ax to es:[di]
		MOV	AX,DS
		STOSW				; Store ax to es:[di]
		POP	AX
		STOSW				; Store ax to es:[di]
		POP	AX
		STOSW				; Store ax to es:[di]
		POP	BX
		ADD	SP,4
		POP	DS
		POP	BP
		JMP	BX			;*Register jump
		CMP	AX,CX
		JAE	LOC_141			; Jump if above or =
		RETN
LOC_141:
		MOV	DL,90H
		JMP	SHORT LOC_148		; (1038)
		NOP
		CMP	AX,CX
		JL	LOC_142			; Jump if < cmp="" ax,dx="" jg="" loc_142="" ;="" jump="" if="">
		RETN
LOC_142:
		MOV	DL,91H
		JMP	SHORT LOC_148		; (1038)
		NOP
		MOV	AX,SP
		SUB	AX,CX
		JC	LOC_143			; Jump if carry Set
		CMP	AX,200H
		JB	LOC_143			; Jump if below
		MOV	CL,4
		SHR	AX,CL			; Shift w/zeros fill
		MOV	CX,SS
		ADD	AX,CX
		CMP	AX,DS:DATA_10E		; (0000:018C=0)
		JB	LOC_143			; Jump if below
		RETN
LOC_143:
		MOV	DL,0FFH
		JMP	SHORT LOC_148		; (1038)
		NOP
		POP	BX
		POP	AX
		POPF				; Pop flags
		PUSH	BX
		OR	BYTE PTR DS:DATA_11E,2	; (0000:0194=0)
		DEC	SP
		CALL	SUB_18			; (0853)
		JZ	LOC_144			; Jump if zero
		DEC	SP
		CALL	SUB_19			; (086C)
LOC_144:
		AND	BYTE PTR DS:DATA_11E,1	; (0000:0194=0)
		CMP	AL,3
		JE	LOC_145			; Jump if equal
		RETN
LOC_145:
		POP	WORD PTR DS:DATA_9E	; (0000:0186=0)
		ADD	WORD PTR DS:DATA_9E,2	; (0000:0186=0)
LOC_146:
		MOV	DX,1
		JMP	SHORT LOC_150		; (103E)
  
;==== External Entry into Subroutine ======================================
  
SUB_43:
		XOR	AX,AX			; Zero register
		XCHG	AL,DS:DATA_8E		; (0000:0180=0)
		RETN
  
;==== External Entry into Subroutine ======================================
  
SUB_44:
		CMP	BYTE PTR DS:DATA_8E,0	; (0000:0180=0)
		JNE	LOC_147			; Jump if not equal
		RETN
LOC_147:
		MOV	DL,DS:DATA_8E		; (0000:0180=0)
		MOV	DH,1
		JMP	SHORT LOC_150		; (103E)
		POP	BX
		POP	AX
		POPF				; Pop flags
		PUSH	BX
		MOV	DL,4
LOC_148:
		POP	DATA_88			; (9966:0186=5007H)
LOC_149:
		MOV	DH,2
LOC_150:
		PUSH	DX
		CALL	SUB_23			; (09F6)
		POP	DX
		MOV	AX,DATA_88		; (9966:0186=5007H)
		SUB	AX,3
		XCHG	AX,DATA_89		; (9966:0188=0D8E8H)
		OR	AX,AX			; Zero ?
		JNZ	$+0DH			; Jump if not zero
		PUSH	DX
		PUSH	DX
		PUSH	DATA_89			; (9966:0188=0D8E8H)
		CALL	DATA_83			; (9966:017E=0E40AH)
		POP	DX
		CMP	DH,1
		JAE	LOC_151			; Jump if above or =
		CALL	SUB_27			; (0A81)
		POP	SI
		INC	BX
		OR	AX,550AH
		JNC	$+67H			; Jump if carry=0
		JC	$+22H			; Jump if carry Set
		INC	DX
		JC	$+67H			; Jump if carry Set
		DB	 61H, 6BH, 00H,0EBH, 30H
LOC_151:
		MOV	BYTE PTR DS:[1FAH],0FFH	; (9966:01FA=0FAH)
		JA	$+0DH			; Jump if above
		CALL	SUB_27			; (0A81)
		OR	AX,490AH
		DAS				; Decimal adjust
		DEC	DI
		ADD	BL,CH
		PUSH	CS
		CALL	SUB_27			; (0A81)
		OR	AX,520AH
		JNZ	$+70H			; Jump if not zero
		SUB	AX,6974H
		DB	 6DH, 65H, 00H,0E8H,0E9H,0F9H
		DB	 20H, 65H, 72H, 72H, 6FH, 72H
		DB	 20H, 00H, 8AH,0C2H,0E8H, 0DH
		DB	0FAH,0E8H,0D9H,0F9H, 2CH, 20H
		DB	 50H, 43H, 3DH, 00H,0A1H, 88H
		DB	 01H,0E8H,0F7H,0F9H,0E8H,0CAH
		DB	0F9H
		DB	0DH, 0AH, 'Program aborted', 0DH, 0AH
		DB	 00H,0B0H, 01H,0E9H,0B9H,0FBH
		DB	0C2H, 04H, 00H
SUB_42		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_45		PROC	NEAR
		OR	AX,AX			; Zero ?
		JNS	LOC_RET_152		; Jump if not sign
		NEG	AX
  
LOC_RET_152:
		RETN
SUB_45		ENDP
  
		PUSH	AX
		CALL	SUB_46			; (10E6)
		POP	BX
		SHR	AX,1			; Shift w/zeros fill
		CWD				; Word to double word
		DIV	BX			; ax,dx rem=dx:ax/reg
		XCHG	AX,DX
		RETN
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_46		PROC	NEAR
		MOV	BX,WORD PTR DS:[1FEH]	; (9966:01FE=2E02H)
		MOV	CX,WORD PTR DS:[1FCH]	; (9966:01FC=4489H)
		PUSH	BX
		PUSH	CX
		MOV	AL,BH
		MOV	BH,BL
		MOV	BL,CH
		MOV	CH,CL
		XOR	CL,CL			; Zero register
		RCR	AL,1			; Rotate thru carry
		RCR	BX,1			; Rotate thru carry
		RCR	CX,1			; Rotate thru carry
		POP	AX
		ADD	CX,AX
		POP	AX
		ADC	BX,AX
		MOV	AX,62E9H
		ADD	CX,AX
		MOV	AX,3619H
		ADC	BX,AX
		MOV	WORD PTR DS:[1FEH],BX	; (9966:01FE=2E02H)
		MOV	WORD PTR DS:[1FCH],CX	; (9966:01FC=4489H)
		MOV	AX,BX
		RETN
SUB_46		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_47		PROC	NEAR
		OR	AX,AX			; Zero ?
		JNS	LOC_153			; Jump if not sign
		NEG	AX
		MOV	BYTE PTR [BX],2DH	; '-'
		INC	BX
LOC_153:
		XOR	CH,CH			; Zero register
		MOV	DX,2710H
		CALL	SUB_48			; (1142)
		MOV	DX,3E8H
		CALL	SUB_48			; (1142)
		MOV	DX,64H
		CALL	SUB_48			; (1142)
		MOV	DL,0AH
		CALL	SUB_48			; (1142)
		MOV	CL,AL
		JMP	SHORT LOC_155		; (1156)
  
;==== External Entry into Subroutine ======================================
  
SUB_48:
		XOR	CL,CL			; Zero register
LOC_154:
		INC	CL
		SUB	AX,DX
		JNC	LOC_154			; Jump if carry=0
		ADD	AX,DX
		INC	CH
		DEC	CL
		JNZ	LOC_155			; Jump if not zero
		DEC	CH
		JZ	LOC_RET_156		; Jump if zero
LOC_155:
		ADD	CL,30H			; '0'
		MOV	[BX],CL
		INC	BX
  
LOC_RET_156:
		RETN
SUB_47		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_49		PROC	NEAR
		XOR	AX,AX			; Zero register
		CMP	BYTE PTR [BX],24H	; '$'
		MOV	DX,0AH
		JNZ	LOC_158			; Jump if not zero
		MOV	DL,10H
LOC_157:
		INC	BX
LOC_158:
		PUSH	AX
		MOV	AL,[BX]
		CALL	SUB_29			; (0AA0)
		MOV	CL,AL
		POP	AX
		SUB	CL,30H			; '0'
		JC	LOC_160			; Jump if carry Set
		CMP	CL,0AH
		JB	LOC_159			; Jump if below
		CMP	DL,10H
		JNE	LOC_160			; Jump if not equal
		SUB	CL,7
		CMP	CL,0AH
		JB	LOC_160			; Jump if below
		CMP	CL,10H
		JAE	LOC_160			; Jump if above or =
LOC_159:
		PUSH	DX
		MUL	DX			; dx:ax = reg * ax
		POP	DX
		JC	LOC_RET_161		; Jump if carry Set
		XOR	CH,CH			; Zero register
		ADD	AX,CX
		JNC	LOC_157			; Jump if carry=0
		JMP	SHORT LOC_RET_161	; (11A6)
LOC_160:
		CMP	DL,10H
		JE	LOC_RET_161		; Jump if equal
		MOV	CX,AX
		ADD	CX,CX
  
LOC_RET_161:
		RETN
SUB_49		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_50		PROC	NEAR
		MOV	CL,[BX]
		CMP	CL,2DH			; '-'
		JNE	LOC_162			; Jump if not equal
		INC	BX
LOC_162:
		PUSH	CX
		CALL	SUB_49			; (115D)
		POP	CX
		JC	LOC_164			; Jump if carry Set
		CMP	CL,2DH			; '-'
		JNE	LOC_163			; Jump if not equal
		NEG	AX
LOC_163:
		CLC				; Clear carry flag
		RETN
LOC_164:
		CMP	AX,8000H
		JNE	LOC_165			; Jump if not equal
		CMP	CL,2DH			; '-'
		JNE	LOC_165			; Jump if not equal
		RETN
LOC_165:
		STC				; Set carry flag
		RETN
SUB_50		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_51		PROC	NEAR
		POP	BX
		POP	ES
		MOV	SI,DI
		MOV	CL,ES:[SI]
		XOR	CH,CH			; Zero register
		INC	CX
		SUB	SP,CX
		MOV	DI,SP
		PUSH	DS
		PUSH	ES
		POP	DS
		PUSH	SS
		POP	ES
		CLD				; Clear direction
		REP	MOVSB			; Rep when cx >0 Mov [si] to es:[di]
		POP	DS
		JMP	BX			;*Register jump
  
;==== External Entry into Subroutine ======================================
  
SUB_52:
		POP	SI
		MOV	CL,CS:[SI]
		XOR	CH,CH			; Zero register
		INC	CX
		SUB	SP,CX
		MOV	DI,SP
		PUSH	DS
		PUSH	CS
		POP	DS
		PUSH	SS
		POP	ES
		CLD				; Clear direction
		REP	MOVSB			; Rep when cx >0 Mov [si] to es:[di]
		POP	DS
		JMP	SI			;*Register jump
  
;==== External Entry into Subroutine ======================================
  
SUB_53:
		POP	DX
		MOV	AL,CL
		MOV	BX,SP
		MOV	CL,SS:[BX]
		XOR	CH,CH			; Zero register
		ADD	BX,CX
		INC	BX
		LES	DI,DWORD PTR SS:[BX]	; Load 32 bit ptr
		MOV	SI,SP
		CMP	CL,AL
		JBE	LOC_166			; Jump if below or =
		MOV	CL,AL
		MOV	SS:[SI],AL
LOC_166:
		INC	CX
		PUSH	DS
		PUSH	SS
		POP	DS
		CLD				; Clear direction
		REP	MOVSB			; Rep when cx >0 Mov [si] to es:[di]
		POP	DS
		LEA	SP,[BX+4]		; Load effective addr
		JMP	DX			;*Register jump
  
;==== External Entry into Subroutine ======================================
  
SUB_54:
		POP	BX
		POP	ES
		MOV	SI,DI
		XOR	CH,CH			; Zero register
		SUB	SP,CX
		DEC	SP
		MOV	DI,SP
		MOV	SS:[DI],CL
		INC	DI
		PUSH	DS
		PUSH	ES
		POP	DS
		PUSH	SS
		POP	ES
		CLD				; Clear direction
		REP	MOVSB			; Rep when cx >0 Mov [si] to es:[di]
		POP	DS
		JMP	BX			;*Register jump
		POP	BX
		XOR	CH,CH			; Zero register
		MOV	SI,SP
		MOV	AL,SS:[SI]
		XOR	AH,AH			; Zero register
		SUB	AX,CX
		MOV	DI,SI
		ADD	DI,AX
		OR	AX,AX			; Zero ?
		JZ	LOC_168			; Jump if zero
		JNS	LOC_167			; Jump if not sign
		MOV	SP,DI
		MOV	CL,SS:[SI]
		INC	CX
		PUSH	DS
		PUSH	SS
		POP	DS
		PUSH	SS
		POP	ES
		CLD				; Clear direction
		REP	MOVSB			; Rep when cx >0 Mov [si] to es:[di]
		POP	DS
		JMP	SHORT LOC_168		; (1278)
LOC_167:
		MOV	SS:[SI],CL
		ADD	DI,CX
		ADD	SI,CX
		INC	CX
		PUSH	DS
		PUSH	SS
		POP	DS
		PUSH	SS
		POP	ES
		STD				; Set direction flag
		REP	MOVSB			; Rep when cx >0 Mov [si] to es:[di]
		POP	DS
		INC	DI
		MOV	SP,DI
LOC_168:
		JMP	BX			;*Register jump
		CALL	SUB_56			; (12C2)
		MOV	AX,1
		JZ	LOC_169			; Jump if zero
		DEC	AX
LOC_169:
		OR	AX,AX			; Zero ?
		RETN
SUB_51		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_55		PROC	NEAR
		CALL	SUB_56			; (12C2)
		MOV	AX,1
		JNZ	LOC_170			; Jump if not zero
		DEC	AX
LOC_170:
		OR	AX,AX			; Zero ?
		RETN
SUB_55		ENDP
  
		CALL	SUB_56			; (12C2)
		MOV	AX,1
		JNC	LOC_171			; Jump if carry=0
		DEC	AX
LOC_171:
		OR	AX,AX			; Zero ?
		RETN
		CALL	SUB_56			; (12C2)
		MOV	AX,1
		JBE	LOC_172			; Jump if below or =
		DEC	AX
LOC_172:
		OR	AX,AX			; Zero ?
		RETN
		CALL	SUB_56			; (12C2)
		MOV	AX,1
		JA	LOC_173			; Jump if above
		DEC	AX
LOC_173:
		OR	AX,AX			; Zero ?
		RETN
		CALL	SUB_56			; (12C2)
		MOV	AX,1
		JC	LOC_174			; Jump if carry Set
		DEC	AX
LOC_174:
		OR	AX,AX			; Zero ?
		RETN
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_56		PROC	NEAR
		MOV	DI,SP
		ADD	DI,4
		MOV	CL,SS:[DI]
		XOR	CH,CH			; Zero register
		INC	DI
		MOV	SI,DI
		ADD	SI,CX
		MOV	DL,SS:[SI]
		XOR	DH,DH			; Zero register
		INC	SI
		MOV	BX,SI
		ADD	BX,DX
		MOV	AL,CL
		MOV	AH,DL
		CMP	CX,DX
		JBE	LOC_175			; Jump if below or =
		XCHG	CX,DX
LOC_175:
		OR	CX,CX			; Zero ?
		JZ	LOC_176			; Jump if zero
		PUSH	DS
		PUSH	SS
		POP	ES
		PUSH	SS
		POP	DS
		CLD				; Clear direction
		REPE	CMPSB			; Rep zf=1+cx >0 Cmp [si] to es:[di]
		POP	DS
		JNZ	LOC_177			; Jump if not zero
LOC_176:
		CMP	AH,AL
LOC_177:
		POP	DX
		POP	CX
		MOV	SP,BX
		PUSH	CX
		JMP	DX			;*Register jump
  
;==== External Entry into Subroutine ======================================
  
SUB_57:
		POP	WORD PTR DS:DATA_9E	; (0000:0186=0)
		MOV	DI,SP
		MOV	DL,SS:[DI]
		XOR	DH,DH			; Zero register
		MOV	SI,DI
		INC	SI
		ADD	SI,DX
		MOV	CL,SS:[SI]
		ADD	DL,CL
		JC	LOC_178			; Jump if carry Set
		MOV	SS:[SI],DL
		XOR	CH,CH			; Zero register
		SUB	DI,CX
		MOV	SP,DI
		INC	CX
		PUSH	DS
		PUSH	SI
		PUSH	SS
		POP	ES
		PUSH	SS
		POP	DS
		CLD				; Clear direction
		REP	MOVSB			; Rep when cx >0 Mov [si] to es:[di]
		MOV	DI,SI
		POP	SI
		DEC	SI
		DEC	DI
		MOV	CX,DX
		INC	CX
		STD				; Set direction flag
		REP	MOVSB			; Rep when cx >0 Mov [si] to es:[di]
		POP	DS
		INC	DI
		MOV	SP,DI
		JMP	WORD PTR DS:DATA_9E	; (0000:0186=0)
LOC_178:
		MOV	DL,10H
		JMP	LOC_149			; (103C)
SUB_56		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_58		PROC	NEAR
		POP	WORD PTR DS:DATA_9E	; (0000:0186=0)
		CALL	SUB_32			; (0AC9)
		MOV	CX,AX
		POP	AX
		CALL	SUB_61			; (14BE)
		DEC	AX
		MOV	SI,SP
		MOV	DL,SS:[SI]
		XOR	DH,DH			; Zero register
		MOV	DI,SP
		ADD	DI,DX
		SUB	DX,AX
		JBE	LOC_179			; Jump if below or =
		ADD	SI,AX
		CMP	DX,CX
		JBE	LOC_181			; Jump if below or =
		ADD	SI,CX
		MOV	DX,CX
		PUSH	DS
		PUSH	SS
		POP	ES
		PUSH	SS
		POP	DS
		STD				; Set direction flag
		REP	MOVSB			; Rep when cx >0 Mov [si] to es:[di]
		POP	DS
		JMP	SHORT LOC_180		; (1373)
LOC_179:
		XOR	DX,DX			; Zero register
LOC_180:
		XCHG	SI,DI
LOC_181:
		MOV	SS:[SI],DL
		MOV	SP,SI
		JMP	WORD PTR DS:DATA_9E	; (0000:0186=0)
LOC_182:
		POP	BX
		MOV	DI,SP
		MOV	AL,SS:[DI]
		XOR	AH,AH			; Zero register
		ADD	SP,AX
		INC	SP
		JMP	BX			;*Register jump
  
;==== External Entry into Subroutine ======================================
  
SUB_59:
		POP	WORD PTR DS:DATA_9E	; (0000:0186=0)
		MOV	DI,SP
		MOV	DL,SS:[DI]
		XOR	DH,DH			; Zero register
		INC	DI
		MOV	SI,DI
		ADD	SI,DX
		MOV	CL,SS:[SI]
		XOR	CH,CH			; Zero register
		INC	SI
		MOV	BX,SI
		ADD	BX,CX
		XOR	AX,AX			; Zero register
		SUB	DX,CX
		JC	LOC_185			; Jump if carry Set
		INC	AX
		OR	CX,CX			; Zero ?
		JZ	LOC_185			; Jump if zero
		INC	DX
		PUSH	DS
		PUSH	SS
		POP	ES
		PUSH	SS
		POP	DS
		CLD				; Clear direction
LOC_183:
		PUSH	CX
		PUSH	DI
		PUSH	SI
		REPE	CMPSB			; Rep zf=1+cx >0 Cmp [si] to es:[di]
		POP	SI
		POP	DI
		POP	CX
		JZ	LOC_184			; Jump if zero
		INC	AX
		INC	DI
		DEC	DX
		JNZ	LOC_183			; Jump if not zero
		XOR	AX,AX			; Zero register
LOC_184:
		POP	DS
LOC_185:
		MOV	SP,BX
		JMP	WORD PTR DS:DATA_9E	; (0000:0186=0)
		MOV	DS:DATA_12E,CL		; (0000:0200=0)
		MOV	DS:DATA_13E,AX		; (0000:0202=0)
		POP	BX
		POP	WORD PTR DS:DATA_15E	; (0000:0206=0)
		POP	WORD PTR DS:DATA_15E+2	; (0000:0208=0)
		MOV	DS:DATA_17E,SP		; (0000:020A=0)
		MOV	WORD PTR DS:DATA_17E+2,SS	; (0000:020C=0)
		PUSH	BX
		LES	DI,DWORD PTR DS:DATA_15E	; (0000:0206=0) Load 32 bit ptr
		PUSH	ES
		PUSH	DI
		PUSH	ES
		CALL	SUB_51			; (11CC)
		MOV	AX,1
		PUSH	AX
		MOV	AX,DS:DATA_13E		; (0000:0202=0)
		DEC	AX
		CALL	SUB_58			; (133F)
		LES	DI,DWORD PTR DS:DATA_17E	; (0000:020A=0) Load 32 bit ptr
		PUSH	ES
		CALL	SUB_51			; (11CC)
		CALL	SUB_57			; (12FD)
		LES	DI,DWORD PTR DS:DATA_15E	; (0000:0206=0) Load 32 bit ptr
		PUSH	ES
		CALL	SUB_51			; (11CC)
		PUSH	WORD PTR DS:DATA_13E	; (0000:0202=0)
		MOV	AX,0FFH
		CALL	SUB_58			; (133F)
		CALL	SUB_57			; (12FD)
		MOV	CL,DS:DATA_12E		; (0000:0200=0)
		CALL	SUB_53			; (11FB)
		JMP	LOC_182			; (137E)
SUB_58		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_60		PROC	NEAR
		MOV	DS:DATA_14E,AX		; (0000:0204=0)
		POP	BX
		POP	WORD PTR DS:DATA_13E	; (0000:0202=0)
		POP	WORD PTR DS:DATA_15E	; (0000:0206=0)
		POP	WORD PTR DS:DATA_15E+2	; (0000:0208=0)
		PUSH	BX
		LES	DI,DWORD PTR DS:DATA_15E	; (0000:0206=0) Load 32 bit ptr
		PUSH	ES
		PUSH	DI
		PUSH	ES
		CALL	SUB_51			; (11CC)
		MOV	AX,1
		PUSH	AX
		MOV	AX,DS:DATA_13E		; (0000:0202=0)
		DEC	AX
		CALL	SUB_58			; (133F)
		MOV	AX,DS:DATA_13E		; (0000:0202=0)
		ADD	AX,DS:DATA_14E		; (0000:0204=0)
		OR	AH,AH			; Zero ?
		JNZ	LOC_186			; Jump if not zero
		LES	DI,DWORD PTR DS:DATA_15E	; (0000:0206=0) Load 32 bit ptr
		PUSH	ES
		CALL	SUB_51			; (11CC)
		PUSH	AX
		MOV	AX,0FFH
		CALL	SUB_58			; (133F)
		CALL	SUB_57			; (12FD)
LOC_186:
		MOV	CL,0FFH
		CALL	SUB_53			; (11FB)
		RETN
SUB_60		ENDP
  
		POP	BX
		POP	AX
		DEC	AL
		JNZ	LOC_187			; Jump if not zero
		XCHG	AL,AH
		JMP	BX			;*Register jump
LOC_187:
		MOV	DATA_88,BX		; (9966:0186=5007H)
		MOV	DL,10H
		JMP	LOC_149			; (103C)
		MOV	SI,SP
		MOV	BL,SS:[SI+2]
		XOR	BH,BH			; Zero register
		MOV	AX,SS:[BX+SI+3]
		MOV	AH,AL
		MOV	AL,1
		MOV	SS:[BX+SI+3],AX
		RETN
		POP	BX
		ADD	SP,DX
		MOV	SI,SP
		MOV	AL,SS:[SI]
		CMP	AL,CL
		JE	LOC_188			; Jump if equal
		XOR	AH,AH			; Zero register
		ADD	SI,AX
		MOV	DI,SP
		XOR	CH,CH			; Zero register
		ADD	DI,CX
		XCHG	AX,CX
		INC	CX
		PUSH	DS
		PUSH	SS
		POP	DS
		PUSH	SS
		POP	ES
		STD				; Set direction flag
		REP	MOVSB			; Rep when cx >0 Mov [si] to es:[di]
		POP	DS
		INC	DI
		MOV	SP,DI
LOC_188:
		JMP	BX			;*Register jump
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_61		PROC	NEAR
		OR	AH,AH			; Zero ?
		JNZ	LOC_189			; Jump if not zero
		OR	AL,AL			; Zero ?
		JZ	LOC_189			; Jump if zero
		RETN
LOC_189:
		MOV	DL,11H
		JMP	LOC_149			; (103C)
SUB_61		ENDP
  
		POP	BX
		POP	DX
		MOV	SI,DI
		SUB	SP,20H
		MOV	DI,SP
		PUSH	CX
		PUSH	SS
		POP	ES
		CLD				; Clear direction
		OR	CH,CH			; Zero ?
		JZ	LOC_191			; Jump if zero
		XOR	AL,AL			; Zero register
LOC_190:
		STOSB				; Store al to es:[di]
		DEC	CH
		JNZ	LOC_190			; Jump if not zero
LOC_191:
		PUSH	DS
		MOV	DS,DX
		REP	MOVSB			; Rep when cx >0 Mov [si] to es:[di]
		POP	DS
		POP	CX
		MOV	AH,20H			; ' '
		SUB	AH,CH
		SUB	AH,CL
		JZ	LOC_193			; Jump if zero
		XOR	AL,AL			; Zero register
LOC_192:
		STOSB				; Store al to es:[di]
		DEC	AH
		JNZ	LOC_192			; Jump if not zero
LOC_193:
		JMP	BX			;*Register jump
		POP	BX
		SUB	SP,20H
		MOV	DI,SP
		PUSH	SS
		POP	ES
		MOV	CX,10H
		XOR	AX,AX			; Zero register
		CLD				; Clear direction
		REP	STOSW			; Rep when cx >0 Store ax to es:[di]
		JMP	BX			;*Register jump
		CALL	SUB_62			; (1600)
		OR	SS:[BX],AL
		RETN
		XCHG	AX,CX
		POP	BX
		POP	AX
		PUSH	BX
		SUB	CL,AL
		JC	LOC_RET_196		; Jump if carry Set
		XOR	CH,CH			; Zero register
		INC	CX
		MOV	AH,CL
		CALL	SUB_62			; (1600)
		MOV	CL,AH
  
LOCLOOP_194:
		OR	SS:[BX],AL
		SHL	AL,1			; Shift w/zeros fill
		JNC	LOC_195			; Jump if carry=0
		INC	BX
		MOV	AL,1
LOC_195:
		LOOP	LOCLOOP_194		; Loop if cx > 0
  
  
LOC_RET_196:
		RETN
		MOV	SI,SP
		INC	SI
		INC	SI
		MOV	DI,SS:[SI+20H]
		MOV	ES,SS:[SI+22H]
		MOV	DL,CH
		XOR	DH,DH			; Zero register
		ADD	SI,DX
		XOR	CH,CH			; Zero register
		PUSH	DS
		PUSH	SS
		POP	DS
		CLD				; Clear direction
		REP	MOVSB			; Rep when cx >0 Mov [si] to es:[di]
		POP	DS
		RETN	24H
		POP	BX
		MOV	DL,CH
		XOR	DH,DH			; Zero register
		XOR	CH,CH			; Zero register
		MOV	SI,SP
		ADD	SI,DX
		ADD	SI,CX
		MOV	DI,SP
		ADD	DI,20H
		CMP	SI,DI
		JE	LOC_197			; Jump if equal
		DEC	SI
		DEC	DI
		PUSH	DS
		PUSH	SS
		POP	ES
		PUSH	SS
		POP	DS
		STD				; Set direction flag
		REP	MOVSB			; Rep when cx >0 Mov [si] to es:[di]
		POP	DS
		INC	DI
		MOV	SP,DI
LOC_197:
		JMP	BX			;*Register jump
		MOV	AX,1
		JMP	SHORT LOC_198		; (157F)
		XOR	AX,AX			; Zero register
LOC_198:
		CALL	SUB_63			; (1617)
		REPE	CMPSW			; Rep zf=1+cx >0 Cmp [si] to es:[di]
		MOV	DS,DX
		JZ	LOC_199			; Jump if zero
		XOR	AX,1
LOC_199:
		OR	AX,AX			; Zero ?
		RETN	40H
		XOR	AX,AX			; Zero register
		JMP	SHORT LOC_200		; (1597)
		MOV	AX,1
LOC_200:
		CALL	SUB_63			; (1617)
		DEC	AX
		JNZ	LOCLOOP_201		; Jump if not zero
		XCHG	DI,SI
  
LOCLOOP_201:
		LODSW				; String [si] to ax
		OR	AX,[DI]
		SCASW				; Scan es:[di] for ax
		JNZ	LOC_202			; Jump if not zero
		LOOP	LOCLOOP_201		; Loop if cx > 0
  
		MOV	AX,1
		JMP	SHORT LOC_203		; (15AE)
LOC_202:
		XOR	AX,AX			; Zero register
LOC_203:
		MOV	DS,DX
		OR	AX,AX			; Zero ?
		RETN	40H
		CALL	SUB_63			; (1617)
  
LOCLOOP_204:
		LODSW				; String [si] to ax
		OR	AX,[DI]
		STOSW				; Store ax to es:[di]
		LOOP	LOCLOOP_204		; Loop if cx > 0
  
		MOV	DS,DX
		RETN	20H
		CALL	SUB_63			; (1617)
  
LOCLOOP_205:
		LODSW				; String [si] to ax
		NOT	AX
		AND	AX,[DI]
		STOSW				; Store ax to es:[di]
		LOOP	LOCLOOP_205		; Loop if cx > 0
  
		MOV	DS,DX
		RETN	20H
		CALL	SUB_63			; (1617)
  
LOCLOOP_206:
		LODSW				; String [si] to ax
		AND	AX,[DI]
		STOSW				; Store ax to es:[di]
		LOOP	LOCLOOP_206		; Loop if cx > 0
  
		MOV	DS,DX
		RETN	20H
		MOV	BX,SP
		MOV	AX,SS:[BX+22H]
		OR	AH,AH			; Zero ?
		JZ	LOC_207			; Jump if zero
		XOR	AX,AX			; Zero register
		JMP	SHORT LOC_208		; (15FB)
LOC_207:
		CALL	SUB_62			; (1600)
		AND	AL,SS:[BX]
		MOV	AX,0
		JZ	LOC_208			; Jump if zero
		INC	AX
LOC_208:
		OR	AX,AX			; Zero ?
		RETN	22H
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_62		PROC	NEAR
		MOV	BL,AL
		XOR	BH,BH			; Zero register
		MOV	CL,3
		SHR	BX,CL			; Shift w/zeros fill
		ADD	BX,4
		ADD	BX,SP
		MOV	CL,AL
		AND	CL,7
		MOV	AL,1
		SHL	AL,CL			; Shift w/zeros fill
		RETN
SUB_62		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_63		PROC	NEAR
		MOV	SI,SP
		ADD	SI,4
		MOV	DI,SP
		ADD	DI,24H
		MOV	DX,DS
		PUSH	SS
		POP	ES
		PUSH	SS
		POP	DS
		MOV	CX,10H
		CLD				; Clear direction
		RETN
SUB_63		ENDP
  
		CMP	AX,BX
		MOV	AX,0
		JNZ	LOC_209			; Jump if not zero
		CMP	DX,CX
		JNE	LOC_209			; Jump if not equal
		INC	AX
LOC_209:
		OR	AX,AX			; Zero ?
		RETN
		CMP	AX,BX
		MOV	AX,1
		JNZ	LOC_210			; Jump if not zero
		CMP	DX,CX
		JNE	LOC_210			; Jump if not equal
		DEC	AX
LOC_210:
		OR	AX,AX			; Zero ?
		RETN
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_64		PROC	NEAR
LOC_211:
		MOV	WORD PTR DS:[220H],8000H	; (9966:0220=12H)
		JMP	SHORT LOC_213		; (1658)
  
;==== External Entry into Subroutine ======================================
  
SUB_65:
LOC_212:
		MOV	WORD PTR DS:[220H],0	; (9966:0220=12H)
LOC_213:
		OR	CL,CL			; Zero ?
		JZ	LOC_RET_215		; Jump if zero
		XOR	DI,WORD PTR DS:[220H]	; (9966:0220=12H)
		OR	AL,AL			; Zero ?
		JNZ	LOC_216			; Jump if not zero
LOC_214:
		MOV	AX,CX
		MOV	BX,SI
		MOV	DX,DI
  
LOC_RET_215:
		RETN
LOC_216:
		CMP	AL,CL
		JBE	LOC_217			; Jump if below or =
		XCHG	AX,CX
		XCHG	BX,SI
		XCHG	DX,DI
LOC_217:
		MOV	BYTE PTR DS:[224H],CL	; (9966:0224=59H)
		SUB	CL,AL
		CMP	CL,28H			; '('
		JB	LOC_218			; Jump if below
		MOV	CL,BYTE PTR DS:[224H]	; (9966:0224=59H)
		JMP	SHORT LOC_214		; (1664)
LOC_218:
		MOV	WORD PTR DS:[220H],DI	; (9966:0220=12H)
		AND	BYTE PTR DS:[221H],80H	; (9966:0221=0)
		MOV	WORD PTR DS:[222H],DI	; (9966:0222=0FEE2H)
		XOR	BYTE PTR DS:[223H],DH	; (9966:0223=0FEH)
		OR	DI,8000H
		OR	DH,80H
LOC_219:
		CMP	CL,10H
		JB	LOC_220			; Jump if below
		MOV	AH,BH
		MOV	BX,DX
		XOR	DX,DX			; Zero register
		SUB	CL,10H
		JMP	SHORT LOC_219		; (169D)
LOC_220:
		CMP	CL,8
		JB	LOC_221			; Jump if below
		MOV	AH,BL
		MOV	BL,BH
		MOV	BH,DL
		MOV	DL,DH
		XOR	DH,DH			; Zero register
		SUB	CL,8
LOC_221:
		OR	CL,CL			; Zero ?
		JZ	LOC_223			; Jump if zero
LOC_222:
		SHR	DX,1			; Shift w/zeros fill
		RCR	BX,1			; Rotate thru carry
		RCR	AH,1			; Rotate thru carry
		DEC	CL
		JNZ	LOC_222			; Jump if not zero
LOC_223:
		MOV	AL,BYTE PTR DS:[224H]	; (9966:0224=59H)
		TEST	BYTE PTR DS:[223H],80H	; (9966:0223=0FEH)
		JNZ	LOC_224			; Jump if not zero
		ADD	AH,CH
		ADC	BX,SI
		ADC	DX,DI
		JNC	LOC_229			; Jump if carry=0
		RCR	DX,1			; Rotate thru carry
		RCR	BX,1			; Rotate thru carry
		RCR	AH,1			; Rotate thru carry
		INC	AL
		JNZ	LOC_229			; Jump if not zero
		STC				; Set carry flag
		RETN
LOC_224:
		XCHG	AH,CH
		XCHG	BX,SI
		XCHG	DX,DI
		SUB	AH,CH
		SBB	BX,SI
		SBB	DX,DI
		JNC	LOC_225			; Jump if carry=0
		XOR	BYTE PTR DS:[221H],80H	; (9966:0221=0)
		NOT	AH
		NOT	BX
		NOT	DX
		ADD	AH,1
		ADC	BX,0
		ADC	DX,0
LOC_225:
		MOV	CL,5
LOC_226:
		OR	DH,DH			; Zero ?
		JNZ	LOC_227			; Jump if not zero
		MOV	DH,DL
		MOV	DL,BH
		MOV	BH,BL
		MOV	BL,AH
		XOR	AH,AH			; Zero register
		SUB	AL,8
		JC	LOC_228			; Jump if carry Set
		DEC	CL
		JNZ	LOC_226			; Jump if not zero
		JMP	SHORT LOC_228		; (1736)
LOC_227:
		TEST	DH,80H
		JNZ	LOC_229			; Jump if not zero
		SHL	AH,1			; Shift w/zeros fill
		RCL	BX,1			; Rotate thru carry
		RCL	DX,1			; Rotate thru carry
		DEC	AL
		JNZ	LOC_227			; Jump if not zero
LOC_228:
		XOR	AX,AX			; Zero register
		XOR	BX,BX			; Zero register
		XOR	DX,DX			; Zero register
		RETN
LOC_229:
		AND	DH,7FH
		XOR	DH,BYTE PTR DS:[221H]	; (9966:0221=0)
		RETN
SUB_64		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_66		PROC	NEAR
LOC_230:
		OR	CL,CL			; Zero ?
		JZ	LOC_237			; Jump if zero
		OR	AL,AL			; Zero ?
		JZ	LOC_RET_238		; Jump if zero
		ADD	AL,CL
		CALL	SUB_68			; (1856)
		MOV	WORD PTR DS:[20EH],AX	; (9966:020E=12H)
		MOV	WORD PTR DS:[210H],BX	; (9966:0210=8BC3H)
		MOV	WORD PTR DS:[212H],DX	; (9966:0212=8BC3H)
		XOR	AH,AH			; Zero register
		XOR	BX,BX			; Zero register
		XOR	DX,DX			; Zero register
		MOV	DI,214H
		MOV	CL,5
LOC_231:
		INC	DI
		MOV	CH,[DI]
		OR	CH,CH			; Zero ?
		JNZ	LOC_232			; Jump if not zero
		MOV	AH,BL
		MOV	BL,BH
		MOV	BH,DL
		MOV	DL,DH
		XOR	DH,DH			; Zero register
		JMP	SHORT LOC_235		; (1797)
LOC_232:
		MOV	SI,8
LOC_233:
		RCR	CH,1			; Rotate thru carry
		JNC	LOC_234			; Jump if carry=0
		ADD	AH,BYTE PTR DS:[20FH]	; (9966:020F=0)
		ADC	BX,WORD PTR DS:[210H]	; (9966:0210=8BC3H)
		ADC	DX,WORD PTR DS:[212H]	; (9966:0212=8BC3H)
LOC_234:
		RCR	DX,1			; Rotate thru carry
		RCR	BX,1			; Rotate thru carry
		RCR	AH,1			; Rotate thru carry
		DEC	SI
		JNZ	LOC_233			; Jump if not zero
LOC_235:
		DEC	CL
		JNZ	LOC_231			; Jump if not zero
		XCHG	AX,CX
		LAHF				; Load ah from flags
		TEST	DH,80H
		JNZ	LOC_236			; Jump if not zero
		SAHF				; Store ah into flags
		RCL	CH,1			; Rotate thru carry
		RCL	BX,1			; Rotate thru carry
		RCL	DX,1			; Rotate thru carry
		OR	CL,CL			; Zero ?
		JZ	LOC_236			; Jump if zero
		DEC	CL
LOC_236:
		XCHG	AX,CX
		XOR	DH,BYTE PTR DS:[221H]	; (9966:0221=0)
		OR	AL,AL			; Zero ?
		JNZ	LOC_RET_238		; Jump if not zero
LOC_237:
		XOR	AX,AX			; Zero register
		XOR	BX,BX			; Zero register
		XOR	DX,DX			; Zero register
  
LOC_RET_238:
		RETN
SUB_66		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_67		PROC	NEAR
		OR	AL,AL			; Zero ?
		JZ	LOC_RET_238		; Jump if zero
		SUB	AL,CL
		CMC				; Complement carry
		CALL	SUB_68			; (1856)
		MOV	BYTE PTR DS:[20EH],AL	; (9966:020E=12H)
		MOV	DI,213H
		MOV	CL,5
		MOV	SI,8
LOC_239:
		CMP	DX,WORD PTR DS:[218H]	; (9966:0218=3)
		JNE	LOC_240			; Jump if not equal
		CMP	BX,WORD PTR DS:[216H]	; (9966:0216=0E805H)
		JNE	LOC_240			; Jump if not equal
		CMP	AH,BYTE PTR DS:[215H]	; (9966:0215=0E3H)
LOC_240:
		JB	LOC_241			; Jump if below
		SUB	AH,BYTE PTR DS:[215H]	; (9966:0215=0E3H)
		SBB	BX,WORD PTR DS:[216H]	; (9966:0216=0E805H)
		SBB	DX,WORD PTR DS:[218H]	; (9966:0218=3)
LOC_241:
		CMC				; Complement carry
		RCL	CH,1			; Rotate thru carry
		DEC	SI
		JNZ	LOC_242			; Jump if not zero
		MOV	[DI],CH
		DEC	CL
		JZ	LOC_243			; Jump if zero
		DEC	DI
		MOV	SI,8
LOC_242:
		SHL	AH,1			; Shift w/zeros fill
		RCL	BX,1			; Rotate thru carry
		RCL	DX,1			; Rotate thru carry
		JNC	LOC_239			; Jump if carry=0
		SUB	AH,BYTE PTR DS:[215H]	; (9966:0215=0E3H)
		SBB	BX,WORD PTR DS:[216H]	; (9966:0216=0E805H)
		SBB	DX,WORD PTR DS:[218H]	; (9966:0218=3)
		CLC				; Clear carry flag
		JMP	SHORT LOC_241		; (17F2)
LOC_243:
		SHL	AH,1			; Shift w/zeros fill
		RCL	BX,1			; Rotate thru carry
		RCL	DX,1			; Rotate thru carry
		JC	LOC_245			; Jump if carry Set
		CMP	DX,WORD PTR DS:[218H]	; (9966:0218=3)
		JNE	LOC_244			; Jump if not equal
		CMP	BX,WORD PTR DS:[216H]	; (9966:0216=0E805H)
		JNE	LOC_244			; Jump if not equal
		CMP	AH,BYTE PTR DS:[215H]	; (9966:0215=0E3H)
LOC_244:
		CMC				; Complement carry
LOC_245:
		MOV	CX,WORD PTR DS:[20EH]	; (9966:020E=12H)
		MOV	BX,WORD PTR DS:[210H]	; (9966:0210=8BC3H)
		MOV	DX,WORD PTR DS:[212H]	; (9966:0212=8BC3H)
		LAHF				; Load ah from flags
		TEST	DH,80H
		JNZ	LOC_246			; Jump if not zero
		SAHF				; Store ah into flags
		RCL	CH,1			; Rotate thru carry
		RCL	BX,1			; Rotate thru carry
		RCL	DX,1			; Rotate thru carry
		JMP	SHORT LOC_247		; (1853)
LOC_246:
		INC	CL
		JNZ	LOC_247			; Jump if not zero
		STC				; Set carry flag
		RETN
LOC_247:
		JMP	LOC_236			; (17AF)
SUB_67		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_68		PROC	NEAR
		JC	LOC_248			; Jump if carry Set
		ADD	AL,80H
		JC	LOC_249			; Jump if carry Set
		POP	BX
		XOR	AX,AX			; Zero register
		XOR	BX,BX			; Zero register
		XOR	DX,DX			; Zero register
		RETN
LOC_248:
		ADD	AL,80H
		JNC	LOC_249			; Jump if carry=0
		POP	BX
		STC				; Set carry flag
		RETN
LOC_249:
		MOV	WORD PTR DS:[214H],CX	; (9966:0214=0E3C8H)
		MOV	CX,DX
		XOR	CX,DI
		NOT	CH
		AND	CH,80H
		MOV	BYTE PTR DS:[221H],CH	; (9966:0221=0)
		OR	DH,80H
		OR	DI,8000H
		MOV	WORD PTR DS:[216H],SI	; (9966:0216=0E805H)
		MOV	WORD PTR DS:[218H],DI	; (9966:0218=3)
		RETN
SUB_68		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_69		PROC	NEAR
		PUSH	DI
		PUSH	SI
		PUSH	CX
		CALL	SUB_65			; (1652)
		POP	CX
		POP	SI
		POP	DI
		RETN
SUB_69		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_70		PROC	NEAR
		PUSH	DI
		PUSH	SI
		PUSH	CX
		CALL	SUB_64			; (164A)
		POP	CX
		POP	SI
		POP	DI
		RETN
SUB_70		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_71		PROC	NEAR
		PUSH	DI
		PUSH	SI
		PUSH	CX
		CALL	SUB_66			; (1745)
		POP	CX
		POP	SI
		POP	DI
		RETN
SUB_71		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_72		PROC	NEAR
		PUSH	DI
		PUSH	SI
		PUSH	CX
		CALL	SUB_67			; (17BF)
		POP	CX
		POP	SI
		POP	DI
		RETN
SUB_72		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_73		PROC	NEAR
		PUSH	DX
		XOR	DX,DI
		POP	DX
		JNS	LOC_250			; Jump if not sign
		PUSH	DX
		RCL	DX,1			; Rotate thru carry
		POP	DX
		RETN
LOC_250:
		TEST	DH,80H
		JZ	LOC_251			; Jump if zero
		CALL	SUB_74			; (18CB)
		JZ	LOC_RET_252		; Jump if zero
		CMC				; Complement carry
		RETN
  
;==== External Entry into Subroutine ======================================
  
SUB_74:
LOC_251:
		CMP	AL,CL
		JNE	LOC_RET_252		; Jump if not equal
		OR	AL,AL			; Zero ?
		JZ	LOC_RET_252		; Jump if zero
		CMP	DX,DI
		JNE	LOC_RET_252		; Jump if not equal
		CMP	BX,SI
		JNE	LOC_RET_252		; Jump if not equal
		CMP	AH,CH
  
LOC_RET_252:
		RETN
SUB_73		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_75		PROC	NEAR
		OR	AX,AX			; Zero ?
		JNZ	LOC_253			; Jump if not zero
		XOR	BX,BX			; Zero register
		XOR	DX,DX			; Zero register
		RETN
LOC_253:
		MOV	BH,AH
		MOV	DX,AX
		OR	DX,DX			; Zero ?
		JNS	LOC_254			; Jump if not sign
		NEG	DX
LOC_254:
		MOV	AX,90H
		OR	DH,DH			; Zero ?
		JNZ	LOC_255			; Jump if not zero
		MOV	AL,88H
		XCHG	DL,DH
LOC_255:
		OR	DX,DX			; Zero ?
		JS	LOC_257			; Jump if sign=1
LOC_256:
		DEC	AL
		SHL	DX,1			; Shift w/zeros fill
		JNS	LOC_256			; Jump if not sign
LOC_257:
		OR	BH,BH			; Zero ?
		JS	LOC_258			; Jump if sign=1
		AND	DH,7FH
LOC_258:
		XOR	BX,BX			; Zero register
		RETN
SUB_75		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_76		PROC	NEAR
		CMP	AL,0A8H
		JAE	LOC_RET_264		; Jump if above or =
		MOV	CX,AX
		MOV	SI,BX
		MOV	DI,DX
		XOR	AH,AH			; Zero register
		XOR	BX,BX			; Zero register
		XOR	DX,DX			; Zero register
		SUB	CL,80H
		JBE	LOC_265			; Jump if below or =
LOC_259:
		CMP	CL,10H
		JB	LOC_260			; Jump if below
		MOV	AH,BH
		MOV	BX,DX
		MOV	DX,0FFFFH
		SUB	CL,10H
		JMP	SHORT LOC_259		; (1925)
LOC_260:
		CMP	CL,8
		JB	LOC_261			; Jump if below
		MOV	AH,BL
		MOV	BL,BH
		MOV	BH,DL
		MOV	DL,DH
		MOV	DH,0FFH
		SUB	CL,8
LOC_261:
		OR	CL,CL			; Zero ?
		JZ	LOC_263			; Jump if zero
LOC_262:
		STC				; Set carry flag
		RCR	DX,1			; Rotate thru carry
		RCR	BX,1			; Rotate thru carry
		RCR	AH,1			; Rotate thru carry
		DEC	CL
		JNZ	LOC_262			; Jump if not zero
LOC_263:
		AND	DX,DI
		AND	BX,SI
		AND	AH,CH
  
LOC_RET_264:
		RETN
LOC_265:
		XOR	AL,AL			; Zero register
		RETN
SUB_76		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_77		PROC	NEAR
		PUSH	DX
		PUSH	BX
		PUSH	AX
		CALL	SUB_76			; (1910)
		MOV	CX,AX
		MOV	SI,BX
		MOV	DI,DX
		POP	AX
		POP	BX
		POP	DX
		JMP	LOC_211			; (164A)
SUB_77		ENDP
  
		POP	BX
		POP	ES
		PUSH	WORD PTR ES:[DI+4]
		PUSH	WORD PTR ES:[DI+2]
		PUSH	WORD PTR ES:[DI]
		JMP	BX			;*Register jump
		POP	BX
		PUSH	WORD PTR CS:[BX+4]
		PUSH	WORD PTR CS:[BX+2]
		PUSH	WORD PTR CS:[BX]
		ADD	BX,6
		JMP	BX			;*Register jump
		POP	BX
		POP	AX
		POP	CX
		POP	DX
		POP	DI
		POP	ES
		MOV	ES:[DI],AX
		MOV	ES:[DI+2],CX
		MOV	ES:[DI+4],DX
		JMP	BX			;*Register jump
		POP	DATA_88			; (9966:0186=5007H)
		POP	CX
		POP	SI
		POP	DI
		POP	AX
		POP	BX
		POP	DX
		CALL	SUB_65			; (1652)
LOC_266:
		JC	LOC_267			; Jump if carry Set
		PUSH	DX
		PUSH	BX
		PUSH	AX
		JMP	DATA_88			; (9966:0186=5007H)
LOC_267:
		MOV	DL,1
		JMP	LOC_149			; (103C)
		POP	DATA_88			; (9966:0186=5007H)
		POP	CX
		POP	SI
		POP	DI
		POP	AX
		POP	BX
		POP	DX
		CALL	SUB_64			; (164A)
		JMP	SHORT LOC_266		; (19B3)
		POP	DATA_88			; (9966:0186=5007H)
		POP	CX
		POP	SI
		POP	DI
		POP	AX
		POP	BX
		POP	DX
LOC_268:
		CALL	SUB_66			; (1745)
		JMP	SHORT LOC_266		; (19B3)
		POP	DATA_88			; (9966:0186=5007H)
		POP	CX
		POP	SI
		POP	DI
		POP	AX
		POP	BX
		POP	DX
		OR	CL,CL			; Zero ?
		JZ	LOC_269			; Jump if zero
		CALL	SUB_67			; (17BF)
		JMP	SHORT LOC_266		; (19B3)
LOC_269:
		MOV	DL,2
		JMP	LOC_149			; (103C)
		MOV	BX,SP
		CMP	BYTE PTR SS:[BX+2],0
		JE	LOC_RET_270		; Jump if equal
		XOR	BYTE PTR SS:[BX+7],80H
  
LOC_RET_270:
		RETN
		MOV	BX,SP
		AND	BYTE PTR SS:[BX+7],7FH
		RETN
		POP	DATA_88			; (9966:0186=5007H)
		POP	CX
		POP	SI
		POP	DI
		POP	AX
		POP	BX
		POP	DX
		CALL	SUB_73			; (18B4)
		PUSH	DATA_88			; (9966:0186=5007H)
		MOV	AX,1
		JZ	LOC_271			; Jump if zero
		DEC	AX
LOC_271:
		OR	AX,AX			; Zero ?
		RETN
		POP	DATA_88			; (9966:0186=5007H)
		POP	CX
		POP	SI
		POP	DI
		POP	AX
		POP	BX
		POP	DX
		CALL	SUB_73			; (18B4)
		PUSH	DATA_88			; (9966:0186=5007H)
		MOV	AX,1
		JNZ	LOC_272			; Jump if not zero
		DEC	AX
LOC_272:
		OR	AX,AX			; Zero ?
		RETN
		POP	DATA_88			; (9966:0186=5007H)
		POP	CX
		POP	SI
		POP	DI
		POP	AX
		POP	BX
		POP	DX
		CALL	SUB_73			; (18B4)
		PUSH	DATA_88			; (9966:0186=5007H)
		MOV	AX,1
		JNC	LOC_273			; Jump if carry=0
		DEC	AX
LOC_273:
		OR	AX,AX			; Zero ?
		RETN
		POP	DATA_88			; (9966:0186=5007H)
		POP	CX
		POP	SI
		POP	DI
		POP	AX
		POP	BX
		POP	DX
		CALL	SUB_73			; (18B4)
		PUSH	DATA_88			; (9966:0186=5007H)
		MOV	AX,1
		JBE	LOC_274			; Jump if below or =
		DEC	AX
LOC_274:
		OR	AX,AX			; Zero ?
		RETN
		POP	DATA_88			; (9966:0186=5007H)
		POP	CX
		POP	SI
		POP	DI
		POP	AX
		POP	BX
		POP	DX
		CALL	SUB_73			; (18B4)
		PUSH	DATA_88			; (9966:0186=5007H)
		MOV	AX,1
		JA	LOC_275			; Jump if above
		DEC	AX
LOC_275:
		OR	AX,AX			; Zero ?
		RETN
		POP	DATA_88			; (9966:0186=5007H)
		POP	CX
		POP	SI
		POP	DI
		POP	AX
		POP	BX
		POP	DX
		CALL	SUB_73			; (18B4)
		PUSH	DATA_88			; (9966:0186=5007H)
		MOV	AX,1
		JC	LOC_276			; Jump if carry Set
		DEC	AX
LOC_276:
		OR	AX,AX			; Zero ?
		RETN
		POP	DATA_88			; (9966:0186=5007H)
		POP	AX
		POP	BX
		POP	DX
		MOV	CX,AX
		MOV	SI,BX
		MOV	DI,DX
		JMP	LOC_268			; (19DA)
		POP	DATA_88			; (9966:0186=5007H)
		POP	AX
		POP	BX
		POP	DX
		CALL	SUB_76			; (1910)
		JMP	$-10FH
		POP	DATA_88			; (9966:0186=5007H)
		POP	AX
		POP	BX
		POP	DX
		CALL	SUB_77			; (1961)
		JMP	$-11CH
		CALL	SUB_46			; (10E6)
		MOV	DX,80H
		MOV	AL,20H			; ' '
LOC_277:
		TEST	BH,80H
		JNZ	LOC_278			; Jump if not zero
		SHL	CX,1			; Shift w/zeros fill
		RCL	BX,1			; Rotate thru carry
		DEC	DL
		DEC	AL
		JNZ	LOC_277			; Jump if not zero
		XOR	DL,DL			; Zero register
LOC_278:
		AND	BH,7FH
		POP	AX
		PUSH	BX
		PUSH	CX
		PUSH	DX
		JMP	AX			;*Register jump
		MOV	CH,0FFH
		JMP	SHORT LOC_279		; (1AFC)
		XOR	CH,CH			; Zero register
LOC_279:
		POP	BX
		POP	AX
		POP	DX
		POP	DX
		PUSH	BX
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_78		PROC	NEAR
		XCHG	AX,DX
		MOV	CL,8FH
		SUB	CL,DL
		JC	LOC_283			; Jump if carry Set
		CMP	CL,0FH
		JA	LOC_282			; Jump if above
		INC	CL
		MOV	BH,AH
		OR	AH,80H
		SHR	AX,CL			; Shift w/zeros fill
		JNC	LOC_280			; Jump if carry=0
		OR	CH,CH			; Zero ?
		JZ	LOC_280			; Jump if zero
		INC	AX
		JS	LOC_283			; Jump if sign=1
LOC_280:
		TEST	BH,80H
		JZ	LOC_RET_281		; Jump if zero
		NEG	AX
  
LOC_RET_281:
		RETN
LOC_282:
		XOR	AX,AX			; Zero register
		RETN
LOC_283:
		MOV	DL,92H
		JMP	LOC_148			; (1038)
SUB_78		ENDP
  
		CALL	SUB_75			; (18DE)
		POP	CX
		PUSH	DX
		PUSH	BX
		PUSH	AX
		JMP	CX			;*Register jump
		POP	DATA_88			; (9966:0186=5007H)
		POP	CX
		POP	SI
		POP	DI
		POP	AX
		CALL	SUB_75			; (18DE)
		PUSH	DX
		PUSH	BX
		PUSH	AX
		PUSH	DI
		PUSH	SI
		PUSH	CX
		JMP	DATA_88			; (9966:0186=5007H)
		POP	DATA_88			; (9966:0186=5007H)
		POP	AX
		POP	BX
		POP	DX
		MOV	CX,AX
		MOV	SI,BX
		MOV	DI,DX
		OR	AL,AL			; Zero ?
		JZ	LOC_285			; Jump if zero
		TEST	DH,80H
		JNZ	LOC_286			; Jump if not zero
		MOV	WORD PTR DS:[21AH],AX	; (9966:021A=0FBE2H)
		MOV	WORD PTR DS:[21CH],BX	; (9966:021C=51C3H)
		MOV	WORD PTR DS:[21EH],DX	; (9966:021E=0E8BH)
		ADD	CL,80H
		SAR	CL,1			; Shift w/sign fill
		ADD	CL,80H
		MOV	AL,CL
		SUB	AL,14H
		MOV	BYTE PTR DS:[225H],AL	; (9966:0225=0C3H)
LOC_284:
		MOV	AX,WORD PTR DS:[21AH]	; (9966:021A=0FBE2H)
		MOV	BX,WORD PTR DS:[21CH]	; (9966:021C=51C3H)
		MOV	DX,WORD PTR DS:[21EH]	; (9966:021E=0E8BH)
		CALL	SUB_72			; (18AA)
		CALL	SUB_69			; (188C)
		DEC	AL
		PUSH	DX
		PUSH	BX
		PUSH	AX
		CALL	SUB_64			; (164A)
		CMP	AL,BYTE PTR DS:[225H]	; (9966:0225=0C3H)
		POP	CX
		POP	SI
		POP	DI
		JNC	LOC_284			; Jump if carry=0
LOC_285:
		PUSH	DI
		PUSH	SI
		PUSH	CX
		JMP	DATA_88			; (9966:0186=5007H)
LOC_286:
		MOV	DL,3
		JMP	LOC_149			; (103C)
		POP	DATA_88			; (9966:0186=5007H)
		POP	CX
		POP	SI
		POP	DI
		MOV	AX,2181H
		MOV	BX,0DAA2H
		MOV	DX,490FH
		CALL	SUB_64			; (164A)
		JMP	SHORT LOC_287		; (1BC7)
		POP	DATA_88			; (9966:0186=5007H)
		POP	AX
		POP	BX
		POP	DX
LOC_287:
		CMP	AL,6CH			; 'l'
		JB	$+5DH			; Jump if below
		MOV	CX,2183H
		MOV	SI,0DAA2H
		MOV	DI,490FH
		PUSH	DX
		AND	DH,7FH
		CALL	SUB_73			; (18B4)
		POP	DX
		JC	LOC_288			; Jump if carry Set
		CALL	SUB_72			; (18AA)
		PUSH	DI
		PUSH	SI
		PUSH	CX
		CALL	SUB_77			; (1961)
		POP	CX
		POP	SI
		POP	DI
		CALL	SUB_71			; (18A0)
LOC_288:
		TEST	DH,80H
		JZ	LOC_289			; Jump if zero
		CALL	SUB_69			; (188C)
LOC_289:
		DEC	CL
		CALL	SUB_73			; (18B4)
		PUSHF				; Push flags
		JC	LOC_290			; Jump if carry Set
		CALL	SUB_70			; (1896)
LOC_290:
		DEC	CL
		CALL	SUB_73			; (18B4)
		JC	LOC_291			; Jump if carry Set
		INC	CL
		OR	DH,80H
		CALL	SUB_65			; (1652)
LOC_291:
		CMP	AL,6CH			; 'l'
		JB	LOC_292			; Jump if below
		MOV	DI,1C29H
		MOV	CX,7
		CALL	SUB_80			; (1EE2)
LOC_292:
		POPF				; Pop flags
		JC	$+9			; Jump if carry Set
		OR	AL,AL			; Zero ?
		JZ	$+5			; Jump if zero
		XOR	DH,80H
		JMP	$-271H
		POP	AX
		POPF				; Pop flags
		CMP	WORD PTR DS:[0D73FH][BX],BX	; (9966:D73F=0FFFFH)
		DB	 60H, 43H, 9DH, 30H, 92H, 30H
		DB	 67H,0AAH, 3FH, 28H, 32H,0D7H
		DB	 6EH,0B6H, 2AH, 1DH,0EFH, 38H
		DB	 74H, 0DH,0D0H, 00H, 0DH,0D0H
		DB	 7AH, 88H, 88H, 88H, 88H, 08H
		DB	 7EH,0ABH,0AAH,0AAH,0AAH,0AAH
		DB	 8FH, 06H, 86H, 01H, 58H, 5BH
		DB	 5AH, 0AH,0C0H, 74H, 05H,0F6H
		DB	0C6H, 80H, 74H, 05H
LOC_293:
		MOV	DL,4
		JMP	LOC_149			; (103C)
LOC_294:
		MOV	CH,AH
		MOV	CL,81H
		SUB	AL,CL
		CBW				; Convrt byte to word
		PUSH	AX
		XCHG	AX,CX
		MOV	CX,0FB80H
		MOV	SI,0F333H
		MOV	DI,3504H
		CALL	SUB_66			; (1745)
		MOV	CX,AX
		MOV	SI,BX
		MOV	DI,DX
		MOV	AX,81H
		XOR	BX,BX			; Zero register
		XOR	DX,DX			; Zero register
		CALL	SUB_69			; (188C)
		PUSH	DX
		PUSH	BX
		PUSH	AX
		MOV	AX,81H
		XOR	BX,BX			; Zero register
		MOV	DX,8000H
		CALL	SUB_65			; (1652)
		POP	CX
		POP	SI
		POP	DI
		CALL	SUB_67			; (17BF)
		MOV	DI,1CDFH
		MOV	CX,6
		CALL	SUB_80			; (1EE2)
		INC	AL
		MOV	CX,0D27FH
		MOV	SI,17F7H
		MOV	DI,3172H
		CALL	SUB_65			; (1652)
		POP	CX
		PUSH	DX
		PUSH	BX
		PUSH	AX
		XCHG	AX,CX
		CALL	SUB_75			; (18DE)
		MOV	CX,0D280H
		MOV	SI,17F7H
		MOV	DI,3172H
		CALL	SUB_66			; (1745)
		POP	CX
		POP	SI
		POP	DI
		CALL	SUB_65			; (1652)
		CMP	AL,67H			; 'g'
		JAE	$+8			; Jump if above or =
		XOR	AX,AX			; Zero register
		XOR	BX,BX			; Zero register
		XOR	DX,DX			; Zero register
		JMP	$-327H
		JGE	$-74H			; Jump if > or =
		POPF				; Pop flags
		ESC	0,DS:[7D1DH][BX+DI]	; (9966:7D1D=0FFH) coprocessor escape
		JMP	$-745BH
		CMP	BH,CS:[DI-72H]
		JCXZ	$+3AH			; Jump if cx=0
		DB	 8EH, 63H, 7EH, 49H, 92H, 24H
		DB	 49H, 12H, 7EH,0CDH,0CCH,0CCH
		DB	0CCH, 4CH, 7FH,0ABH,0AAH,0AAH
		DB	0AAH, 2AH, 8FH, 06H, 86H, 01H
		DB	 58H, 5BH, 5AH,0F6H,0C6H, 80H
		DB	 9CH, 80H,0E6H, 7FH,0B9H, 80H
		DB	0D2H,0BEH,0F7H, 17H,0BFH, 72H
		DB	 31H,0E8H,0A2H,0FAH, 3CH, 88H
		DB	 73H, 55H, 52H, 53H, 50H,0FEH
		DB	0C0H,0B5H,0FFH,0E8H,0D6H,0FDH
		DB	 59H, 5EH, 5FH, 50H,0E8H,0ACH
		DB	0FBH, 0AH,0C0H, 74H, 02H,0FEH
		DB	0C8H
LOC_295:
		XCHG	AX,CX
		XCHG	BX,SI
		XCHG	DX,DI
		CALL	SUB_64			; (164A)
		MOV	DI,1D7CH
		MOV	CX,8
		CALL	SUB_81			; (1EFB)
		POP	CX
		SHR	CX,1			; Shift w/zeros fill
;*		JNC	LOC_296			;*Jump if carry=0
		DB	 73H, 0EH
		PUSH	CX
		MOV	CX,0FB81H
		MOV	SI,0F333H
		MOV	DI,3504H
		CALL	SUB_66			; (1745)
		POP	CX
LOC_296:
		ADD	AL,CL
		JC	$+18H			; Jump if carry Set
		POPF				; Pop flags
;*		JZ	LOC_297			;*Jump if zero
		DB	 74H, 10H
		MOV	CX,AX
		MOV	SI,BX
		MOV	DI,DX
		MOV	AX,81H
		XOR	BX,BX			; Zero register
		XOR	DX,DX			; Zero register
		CALL	SUB_67			; (17BF)
LOC_297:
		JMP	$-3BEH
		POP	AX
		MOV	DL,1
		JMP	LOC_149			; (103C)
		DB	 6DH, 2EH, 1DH, 11H, 60H, 31H
		DB	 70H, 46H, 2CH,0FEH,0E5H, 7FH
		DB	't6|', 89H, 84H, '!wS<' db="" 0ffh,0c3h,="" 2eh,="" 7ah,0d2h,="" 7dh="" db="" 5bh,="" 95h,="" 1dh,="" 7ch,="" 25h,0b8h="" db="" 46h,="" 58h,="" 63h,="" 7eh,="" 16h,0fch="" db="" 0efh,0fdh,="" 75h,="" 80h,0d2h,0f7h="" db="" 17h,="" 72h,="" 31h,="" 8fh,="" 06h,="" 86h="" db="" 01h,="" 58h,="" 5bh,="" 5ah,="" 0ah,0c0h="" db="" 74h,0bch,="" 33h,0c9h,0f6h,0c6h="" db="" 80h,="" 74h,="" 04h,="" 41h,="" 80h,0e6h="" db="" 7fh,="" 51h,0b9h,="" 81h,="" 00h,="" 33h="" db="" 0f6h,="" 33h,0ffh,0e8h,0e7h,0fah="" db="" 72h,="" 0ch,="" 91h,="" 87h,0deh,="" 87h="" db="" 0d7h,0e8h,0e8h,0f9h="" db="" 59h,="" 41h,="" 41h,="" 51h="" loc_298:="" mov="" cx,4a7eh="" mov="" si,0e98eh="" mov="" di,0c6fh="" call="" sub_73="" ;="" (18b4)="" ;*="" jnc="" loc_299="" ;*jump="" if="" carry="0" db="" 73h,="" 05h="" call="" sub_79="" ;="" (1edc)="" ;*="" jmp="" short="" loc_302="" ;*(1e69)="" db="" 0ebh,="" 7bh="" loc_299:="" mov="" di,1e8eh="" mov="" cx,2="" locloop_300:="" push="" cx="" push="" di="" mov="" cx,cs:[di]="" mov="" si,cs:[di+2]="" mov="" di,cs:[di+4]="" call="" sub_73="" ;="" (18b4)="" pop="" di="" pop="" cx="" ;*="" jc="" loc_301="" ;*jump="" if="" carry="" set="" db="" 72h,="" 08h="" add="" di,12h="" loop="" locloop_300="" ;="" loop="" if="" cx=""> 0
  
		SUB	DI,6
LOC_301:
		ADD	DI,6
		MOV	WORD PTR DS:[21AH],AX	; (9966:021A=0FBE2H)
		MOV	WORD PTR DS:[21CH],BX	; (9966:021C=51C3H)
		MOV	WORD PTR DS:[21EH],DX	; (9966:021E=0E8BH)
		PUSH	DI
		MOV	CX,CS:[DI]
		MOV	SI,CS:[DI+2]
		MOV	DI,CS:[DI+4]
		CALL	SUB_70			; (1896)
		PUSH	DX
		PUSH	BX
		PUSH	AX
		MOV	AX,WORD PTR DS:[21AH]	; (9966:021A=0FBE2H)
		MOV	BX,WORD PTR DS:[21CH]	; (9966:021C=51C3H)
		MOV	DX,WORD PTR DS:[21EH]	; (9966:021E=0E8BH)
		CALL	SUB_66			; (1745)
		MOV	CX,81H
		XOR	SI,SI			; Zero register
		XOR	DI,DI			; Zero register
		CALL	SUB_65			; (1652)
		MOV	CX,AX
		MOV	SI,BX
		MOV	DI,DX
		POP	AX
		POP	BX
		POP	DX
		CALL	SUB_67			; (17BF)
		CALL	SUB_79			; (1EDC)
		POP	DI
		ADD	DI,6
		MOV	CX,CS:[DI]
		MOV	SI,CS:[DI+2]
		MOV	DI,CS:[DI+4]
		CALL	SUB_65			; (1652)
LOC_302:
		POP	CX
		TEST	CL,2
;*		JZ	LOC_304			;*Jump if zero
		DB	 74H, 14H
		PUSH	CX
		MOV	CX,AX
		MOV	SI,BX
		MOV	DI,DX
		MOV	AX,2181H
		MOV	BX,0DAA2H
		MOV	DX,490FH
		CALL	SUB_64			; (164A)
		POP	CX
LOC_304:
		TEST	CL,1
;*		JZ	LOC_305			;*Jump if zero
		DB	 74H, 03H
		OR	DH,80H
LOC_305:
		JMP	$-4D6H
;*		JG	LOC_303			;*Jump if >
		DB	 7FH,0E7H
		IRET				; Interrupt return
		INT	3			; Debug breakpoint
		ADC	DX,[SI+7FH]
		DIV	AH			; al, ah rem = ax/reg
		MOV	BYTE PTR DS:[930H],AL	; (9966:0930=0E8H)
		JG	LOC_306			; Jump if >
		DB	0C1H, 91H, 0AH, 06H, 80H,0B5H
		DB	9EH, 8AH, 'oD', 80H, 82H, ',:'
		DB	0CDH, 13H, 80H, 6AH,0C1H, 91H
		DB	 0AH, 06H, 81H, 00H, 00H, 00H
		DB	 00H, 00H, 80H, 21H,0A2H,0DAH
		DB	 0FH, 49H, 7DH,0E8H,0A2H, 8BH
		DB	 2EH,0BAH, 7DH, 8EH,0E3H
		DB	'8', 8EH, 'c~I', 92H, '$'
		DB	'I', 92H, '~'
		DB	0CDH,0CCH,0CCH,0CCH, 4CH, 7FH
		DB	0ABH,0AAH,0AAH,0AAH,0AAH
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_79		PROC	NEAR
		MOV	DI,1EBEH
		MOV	CX,5
  
;==== External Entry into Subroutine ======================================
  
SUB_80:
		PUSH	DX
		PUSH	BX
		PUSH	AX
		PUSH	CX
		PUSH	DI
		MOV	CX,AX
		MOV	SI,BX
		MOV	DI,DX
		CALL	SUB_66			; (1745)
		POP	DI
		POP	CX
		CALL	SUB_81			; (1EFB)
		POP	CX
		POP	SI
		POP	DI
		JMP	LOC_230			; (1745)
SUB_79		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_81		PROC	NEAR
		MOV	WORD PTR DS:[21AH],AX	; (9966:021A=0FBE2H)
		MOV	WORD PTR DS:[21CH],BX	; (9966:021C=51C3H)
		MOV	WORD PTR DS:[21EH],DX	; (9966:021E=0E8BH)
LOC_306:
		MOV	AX,CS:[DI]
		MOV	BX,CS:[DI+2]
		MOV	DX,CS:[DI+4]
		PUSH	CX
		PUSH	DI
		JMP	SHORT LOC_308		; (1F25)
  
LOCLOOP_307:
		PUSH	CX
		PUSH	DI
		MOV	CX,CS:[DI]
		MOV	SI,CS:[DI+2]
		MOV	DI,CS:[DI+4]
		CALL	SUB_65			; (1652)
LOC_308:
		MOV	CX,WORD PTR DS:[21AH]	; (9966:021A=0FBE2H)
		MOV	SI,WORD PTR DS:[21CH]	; (9966:021C=51C3H)
		MOV	DI,WORD PTR DS:[21EH]	; (9966:021E=0E8BH)
		CALL	SUB_66			; (1745)
		POP	DI
		POP	CX
		ADD	DI,6
		LOOP	LOCLOOP_307		; Loop if cx > 0
  
		MOV	CX,81H
		XOR	SI,SI			; Zero register
		XOR	DI,DI			; Zero register
		JMP	LOC_212			; (1652)
SUB_81		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_82		PROC	NEAR
		PUSH	BX
		CMP	DX,19H
		JB	LOC_312			; Jump if below
		MOV	AX,CX
		CALL	SUB_32			; (0AC9)
		MOV	DL,7
		TEST	BYTE PTR [DI+5],80H
		JZ	LOC_309			; Jump if zero
		INC	DL
LOC_309:
		SUB	AL,DL
		JNC	LOC_310			; Jump if carry=0
		XOR	AL,AL			; Zero register
LOC_310:
		CMP	AL,9
		JB	LOC_311			; Jump if below
		MOV	AL,9
LOC_311:
		INC	AL
		MOV	DL,AL
		MOV	DH,AL
LOC_312:
		PUSH	DX
		CALL	SUB_86			; (2009)
		POP	DX
		MOV	AL,DL
		INC	AL
		OR	DH,DH			; Zero ?
		JNZ	LOC_314			; Jump if not zero
		ADD	AL,CL
		JNS	LOC_313			; Jump if not sign
		MOV	BYTE PTR DS:[226H],0	; (9966:0226=55H)
		JMP	SHORT LOC_315		; (1F8D)
LOC_313:
		CMP	AL,0CH
		JB	LOC_314			; Jump if below
		MOV	AL,0BH
LOC_314:
		CALL	SUB_87			; (20A3)
LOC_315:
		POP	BX
		MOV	SI,226H
		TEST	CH,80H
		JZ	LOC_316			; Jump if zero
		MOV	AL,2DH			; '-'
		CALL	SUB_85			; (2005)
LOC_316:
		MOV	CH,CL
		OR	DH,DH			; Zero ?
		JZ	LOC_317			; Jump if zero
		MOV	CH,0
LOC_317:
		OR	CH,CH			; Zero ?
		JNS	LOC_318			; Jump if not sign
		CALL	SUB_84			; (2003)
		JMP	SHORT LOC_319		; (1FB3)
LOC_318:
		CALL	SUB_83			; (1FFA)
		DEC	CH
		JNS	LOC_318			; Jump if not sign
LOC_319:
		OR	DL,DL			; Zero ?
		JZ	LOC_322			; Jump if zero
		MOV	AL,2EH			; '.'
		CALL	SUB_85			; (2005)
LOC_320:
		INC	CH
		JZ	LOC_321			; Jump if zero
		CALL	SUB_84			; (2003)
		DEC	DL
		JNZ	LOC_320			; Jump if not zero
LOC_321:
		DEC	DL
		JS	LOC_322			; Jump if sign=1
		CALL	SUB_83			; (1FFA)
		JMP	SHORT LOC_321		; (1FC7)
LOC_322:
		OR	DH,DH			; Zero ?
		JNZ	LOC_323			; Jump if not zero
		RETN
LOC_323:
		MOV	AL,45H			; 'E'
		CALL	SUB_85			; (2005)
		MOV	AL,2BH			; '+'
		OR	CL,CL			; Zero ?
		JNS	LOC_324			; Jump if not sign
		NEG	CL
		MOV	AL,2DH			; '-'
LOC_324:
		CALL	SUB_85			; (2005)
		MOV	AL,2FH			; '/'
LOC_325:
		INC	AL
		SUB	CL,0AH
		JNC	LOC_325			; Jump if carry=0
		CALL	SUB_85			; (2005)
		ADD	CL,3AH			; ':'
		MOV	AL,CL
		JMP	SHORT LOC_327		; (2005)
  
;==== External Entry into Subroutine ======================================
  
SUB_83:
		MOV	AL,[SI]
		OR	AL,AL			; Zero ?
		JZ	LOC_326			; Jump if zero
		INC	SI
		JMP	SHORT LOC_327		; (2005)
  
;==== External Entry into Subroutine ======================================
  
SUB_84:
LOC_326:
		MOV	AL,30H			; '0'
SUB_82		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_85		PROC	NEAR
LOC_327:
		MOV	[BX],AL
		INC	BX
		RETN
SUB_85		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_86		PROC	NEAR
		MOV	AX,[DI]
		MOV	BX,[DI+2]
		MOV	DX,[DI+4]
		OR	AL,AL			; Zero ?
		JNZ	LOC_329			; Jump if not zero
		MOV	SI,226H
LOC_328:
		MOV	WORD PTR [SI],3030H
		INC	SI
		INC	SI
		CMP	SI,232H
		JNE	LOC_328			; Jump if not equal
		MOV	CX,0
		RETN
LOC_329:
		MOV	CH,DH
		AND	DH,7FH
		PUSH	AX
		PUSH	DX
		SUB	AL,80H
		CBW				; Convrt byte to word
		MOV	DX,4DH
		IMUL	DX			; dx:ax = reg * ax
		ADD	AX,5
		MOV	CL,AH
		POP	DX
		POP	AX
		CMP	CL,0D9H
		JNE	LOC_330			; Jump if not equal
		INC	CL
LOC_330:
		PUSH	CX
		NEG	CL
		CALL	SUB_93			; (21C1)
		POP	CX
		CMP	AL,81H
		JAE	LOC_331			; Jump if above or =
		CALL	SUB_94			; (2248)
		DEC	CL
LOC_331:
		PUSH	CX
		OR	DH,80H
		MOV	CL,84H
		SUB	CL,AL
		MOV	AL,0
		JZ	LOC_333			; Jump if zero
LOC_332:
		SHR	DX,1			; Shift w/zeros fill
		RCR	BX,1			; Rotate thru carry
		RCR	AX,1			; Rotate thru carry
		DEC	CL
		JNZ	LOC_332			; Jump if not zero
LOC_333:
		MOV	SI,226H
LOC_334:
		MOV	CH,DH
		MOV	CL,4
		SHR	CH,CL			; Shift w/zeros fill
		ADD	CH,30H			; '0'
		MOV	[SI],CH
		AND	DH,0FH
		PUSH	DX
		PUSH	BX
		PUSH	AX
		SHL	AX,1			; Shift w/zeros fill
		RCL	BX,1			; Rotate thru carry
		RCL	DX,1			; Rotate thru carry
		SHL	AX,1			; Shift w/zeros fill
		RCL	BX,1			; Rotate thru carry
		RCL	DX,1			; Rotate thru carry
		POP	CX
		ADD	AX,CX
		POP	CX
		ADC	BX,CX
		POP	CX
		ADC	DX,CX
		SHL	AX,1			; Shift w/zeros fill
		RCL	BX,1			; Rotate thru carry
		RCL	DX,1			; Rotate thru carry
		INC	SI
		CMP	SI,232H
		JNE	LOC_334			; Jump if not equal
		POP	CX
		RETN
SUB_86		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_87		PROC	NEAR
		XOR	AH,AH			; Zero register
		MOV	BX,226H
		ADD	BX,AX
		CMP	BYTE PTR [BX],35H	; '5'
		MOV	BYTE PTR [BX],0
		JC	LOC_RET_337		; Jump if carry Set
LOC_335:
		DEC	AL
		JS	LOC_336			; Jump if sign=1
		DEC	BX
		INC	BYTE PTR [BX]
		CMP	BYTE PTR [BX],3AH	; ':'
		JB	LOC_RET_337		; Jump if below
		MOV	BYTE PTR [BX],0
		JMP	SHORT LOC_335		; (20B2)
LOC_336:
		MOV	BYTE PTR [BX],31H	; '1'
		MOV	BYTE PTR [BX+1],0
		INC	CL
  
LOC_RET_337:
		RETN
SUB_87		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_88		PROC	NEAR
		MOV	CL,[BX]
		CMP	CL,2DH			; '-'
		JNE	LOC_338			; Jump if not equal
		INC	BX
LOC_338:
		PUSH	CX
		CALL	SUB_89			; (20EC)
		POP	CX
		JC	LOC_RET_340		; Jump if carry Set
		CMP	CL,2DH			; '-'
		JNE	LOC_339			; Jump if not equal
		CMP	BYTE PTR [DI],0
		JE	LOC_339			; Jump if equal
		XOR	BYTE PTR [DI+5],80H
LOC_339:
		CLC				; Clear carry flag
  
LOC_RET_340:
		RETN
SUB_88		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_89		PROC	NEAR
		MOV	SI,BX
		XOR	AX,AX			; Zero register
		XOR	BX,BX			; Zero register
		XOR	DX,DX			; Zero register
		XOR	CX,CX			; Zero register
		MOV	BYTE PTR DS:[225H],0	; (9966:0225=0C3H)
LOC_341:
		MOV	CL,[SI]
		CMP	CL,61H			; 'a'
		JB	LOC_342			; Jump if below
		CMP	CL,7AH			; 'z'
		JA	LOC_342			; Jump if above
		SUB	CL,20H			; ' '
LOC_342:
		CALL	SUB_92			; (21B2)
		JC	LOC_343			; Jump if carry Set
		CALL	SUB_94			; (2248)
		JC	LOC_345			; Jump if carry Set
		PUSH	DI
		PUSH	SI
		PUSH	CX
		PUSH	DX
		PUSH	BX
		PUSH	AX
		MOV	AL,CL
		XOR	AH,AH			; Zero register
		CALL	SUB_75			; (18DE)
		POP	CX
		POP	SI
		POP	DI
		CALL	SUB_65			; (1652)
		POP	CX
		POP	SI
		POP	DI
		TEST	CH,40H			; '@'
		JZ	LOC_344			; Jump if zero
		DEC	BYTE PTR DS:[225H]	; (9966:0225=0C3H)
		JMP	SHORT LOC_344		; (2143)
LOC_343:
		CMP	CL,2EH			; '.'
		JNE	LOC_346			; Jump if not equal
		TEST	CH,40H			; '@'
		STC				; Set carry flag
		JNZ	LOC_345			; Jump if not zero
		OR	CH,40H			; '@'
LOC_344:
		INC	SI
		JMP	SHORT LOC_341		; (20FB)
LOC_345:
		MOV	BX,SI
		RETN
LOC_346:
		CMP	CL,45H			; 'E'
		MOV	CL,BYTE PTR DS:[225H]	; (9966:0225=0C3H)
		JNZ	LOC_350			; Jump if not zero
		CALL	SUB_90			; (219A)
		JC	LOC_345			; Jump if carry Set
		INC	SI
		MOV	CL,[SI]
		CMP	CL,2BH			; '+'
		JE	LOC_347			; Jump if equal
		CMP	CL,2DH			; '-'
		JNE	LOC_348			; Jump if not equal
		OR	CH,20H			; ' '
LOC_347:
		INC	SI
LOC_348:
		CALL	SUB_91			; (21B0)
		JC	LOC_345			; Jump if carry Set
		PUSH	AX
		MOV	AL,CL
		INC	SI
		CALL	SUB_91			; (21B0)
		JC	LOC_349			; Jump if carry Set
		MOV	AH,AL
		SHL	AL,1			; Shift w/zeros fill
		SHL	AL,1			; Shift w/zeros fill
		ADD	AL,AH
		SHL	AL,1			; Shift w/zeros fill
		ADD	AL,CL
		INC	SI
LOC_349:
		MOV	CL,AL
		POP	AX
		TEST	CH,20H			; ' '
		JZ	LOC_350			; Jump if zero
		NEG	CL
LOC_350:
		CALL	SUB_90			; (219A)
		MOV	[DI],AX
		MOV	[DI+2],BX
		MOV	[DI+4],DX
		JMP	SHORT LOC_345		; (2146)
SUB_89		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_90		PROC	NEAR
		CMP	CL,0DAH
		JL	LOC_351			; Jump if < cmp="" cl,26h="" ;="" '&'="" jg="" loc_351="" ;="" jump="" if="">
		PUSH	CX
		PUSH	SI
		PUSH	DI
		CALL	SUB_93			; (21C1)
		POP	DI
		POP	SI
		POP	CX
		RETN
LOC_351:
		STC				; Set carry flag
		RETN
SUB_90		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_91		PROC	NEAR
		MOV	CL,[SI]
  
;==== External Entry into Subroutine ======================================
  
SUB_92:
		CMP	CL,30H			; '0'
		JB	LOC_RET_352		; Jump if below
		CMP	CL,3AH			; ':'
		CMC				; Complement carry
		JC	LOC_RET_352		; Jump if carry Set
		SUB	CL,30H			; '0'
  
LOC_RET_352:
		RETN
SUB_91		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_93		PROC	NEAR
		PUSH	DX
		PUSH	BX
		PUSH	AX
		MOV	BYTE PTR DS:[224H],CL	; (9966:0224=59H)
		OR	CL,CL			; Zero ?
		JNS	LOC_353			; Jump if not sign
		NEG	CL
LOC_353:
		MOV	BL,CL
		AND	BL,0FCH
		MOV	BH,BL
		SHR	BL,1			; Shift w/zeros fill
		ADD	BL,BH
		XOR	BH,BH			; Zero register
		LEA	DI,[BX+220CH]		; Load effective addr
		MOV	AX,CS:[DI]
		MOV	BX,CS:[DI+2]
		MOV	DX,CS:[DI+4]
		AND	CL,3
		JZ	LOC_355			; Jump if zero
LOC_354:
		CALL	SUB_94			; (2248)
		DEC	CL
		JNZ	LOC_354			; Jump if not zero
LOC_355:
		MOV	CX,AX
		MOV	SI,BX
		MOV	DI,DX
		POP	AX
		POP	BX
		POP	DX
		TEST	BYTE PTR DS:[224H],80H	; (9966:0224=59H)
		JNZ	$+5			; Jump if not zero
		JMP	LOC_230			; (1745)
SUB_93		ENDP
  
		JMP	$-0A4AH
		ADD	WORD PTR [BX+SI],0
		nop				;*ASM fixup - sign extn byte
		ADD	[BX+SI],AL
		MOV	ES,[BX+SI]
		ADD	[BX+SI],AL
		INC	AX
		SBB	AL,9BH
		ADD	[BX+SI],AL
		AND	BYTE PTR DS:[0A83EH][SI],BH	; (9966:A83E=0FFH)
		ADD	[BX+SI],DL
		MOVSW				; Mov [si] to es:[di]
		DB	0D4H, 68H,0B6H, 04H,0BFH,0C9H
		DB	 1BH, 0EH,0C3H,0ACH,0C5H,0EBH
		DB	 78H, 2DH,0D0H,0CDH,0CEH, 1BH
		DB	0C2H, 53H,0DEH,0F9H, 78H, 39H
		DB	 3FH, 01H,0EBH, 2BH,0A8H,0ADH
		DB	0C5H, 1DH,0F8H,0C9H, 7BH,0CEH
		DB	 97H, 40H
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_94		PROC	NEAR
		OR	AL,AL			; Zero ?
		JNZ	LOC_356			; Jump if not zero
		RETN
LOC_356:
		OR	DH,80H
		PUSH	CX
		PUSH	DX
		PUSH	BX
		PUSH	AX
		SHR	DX,1			; Shift w/zeros fill
		RCR	BX,1			; Rotate thru carry
		RCR	AH,1			; Rotate thru carry
		SHR	DX,1			; Shift w/zeros fill
		RCR	BX,1			; Rotate thru carry
		RCR	AH,1			; Rotate thru carry
		POP	CX
		ADD	AH,CH
		POP	CX
		ADC	BX,CX
		POP	CX
		ADC	DX,CX
		POP	CX
		JNC	LOC_357			; Jump if carry=0
		RCR	DX,1			; Rotate thru carry
		RCR	BX,1			; Rotate thru carry
		RCR	AH,1			; Rotate thru carry
		INC	AL
		JNZ	LOC_357			; Jump if not zero
		STC				; Set carry flag
		RETN
LOC_357:
		AND	DH,7FH
		ADD	AL,3
		RETN
SUB_94		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_95		PROC	NEAR
		POP	SI
		POP	DI
		POP	DX
		POP	CX
		POP	BX
		PUSH	DI
		PUSH	SI
		TEST	BH,80H
		JNZ	LOC_360			; Jump if not zero
		OR	BH,80H
		MOV	AL,0A0H
		SUB	AL,DL
		JC	LOC_361			; Jump if carry Set
		CMP	AL,20H			; ' '
		JAE	LOC_360			; Jump if above or =
LOC_358:
		OR	AL,AL			; Zero ?
		JZ	LOC_359			; Jump if zero
		SHR	BX,1			; Shift w/zeros fill
		RCR	CX,1			; Rotate thru carry
		DEC	AL
		JMP	SHORT LOC_358		; (2297)
LOC_359:
		MOV	AX,CX
		MOV	DX,BX
		RETN
LOC_360:
		XOR	AX,AX			; Zero register
		XOR	DX,DX			; Zero register
		RETN
LOC_361:
		MOV	AX,0FFFFH
		MOV	DX,0FFFFH
		RETN
SUB_95		ENDP
  
LOC_362:
		MOV	BX,DX
		MOV	CX,AX
		OR	AX,DX
		JZ	LOC_365			; Jump if zero
		MOV	DX,0A0H
LOC_363:
		TEST	BH,80H
		JNZ	LOC_364			; Jump if not zero
		SHL	CX,1			; Shift w/zeros fill
		RCL	BX,1			; Rotate thru carry
		DEC	DL
		JMP	SHORT LOC_363		; (22BF)
LOC_364:
		AND	BH,7FH
LOC_365:
		POP	AX
		PUSH	BX
		PUSH	CX
		PUSH	DX
		JMP	AX			;*Register jump
		MOV	AL,1
LOC_366:
		MOV	BYTE PTR DS:[238H],AL	; (9966:0238=55H)
		POP	BX
		CALL	SUB_38			; (0EE6)
		POP	DI
		POP	ES
		PUSH	BX
		MOV	AX,ES
		MOV	DX,DS
		CMP	AX,DX
		JNE	LOC_367			; Jump if not equal
		CMP	DI,166H
		JBE	LOC_370			; Jump if below or =
LOC_367:
		PUSH	DI
		MOV	SI,0B6H
		LEA	DI,[DI+0CH]		; Load effective addr
		MOV	CX,20H
		CLD				; Clear direction
		REP	MOVSW			; Rep when cx >0 Mov [si] to es:[di]
		POP	DI
		CALL	SUB_100			; (248B)
		JNC	LOC_368			; Jump if carry=0
		MOV	AL,0
		MOV	BX,0FFFFH
LOC_368:
		MOV	ES:[DI],BX
		CMP	BYTE PTR DS:[238H],0	; (9966:0238=55H)
		JE	LOC_369			; Jump if equal
		MOV	ES:[DI+2],AL
		LEA	AX,[DI+4CH]		; Load effective addr
		MOV	ES:[DI+4],AX
		RETN
LOC_369:
		MOV	WORD PTR ES:[DI+2],0
		RETN
LOC_370:
		MOV	DATA_84,22H		; (9966:0180=0F9H) '"'
		RETN
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_96		PROC	NEAR
		XOR	AL,AL			; Zero register
		JMP	SHORT LOC_371		; (2334)
  
;==== External Entry into Subroutine ======================================
  
SUB_97:
		MOV	AL,1
		JMP	SHORT LOC_371		; (2334)
		MOV	AL,2
LOC_371:
		MOV	BYTE PTR DS:[238H],AL	; (9966:0238=55H)
		POP	DATA_88			; (9966:0186=5007H)
		POP	ES
		PUSH	DATA_88			; (9966:0186=5007H)
		MOV	AL,ES:[DI+2]
		AND	AL,0FH
		JZ	LOC_373			; Jump if zero
		AND	BYTE PTR ES:[DI+2],0DFH
  
LOC_RET_372:
		RETN
LOC_373:
		MOV	ES:[DI+6],CX
		CALL	SUB_99			; (245C)
		CMP	DATA_84,0		; (9966:0180=0F9H)
		JNE	LOC_RET_372		; Jump if not equal
		CALL	SUB_101			; (24F5)
		CMP	DATA_84,0		; (9966:0180=0F9H)
		JNE	LOC_RET_372		; Jump if not equal
		TEST	DATA_77,2		; (9966:0172=0F70H)
		JZ	LOC_374			; Jump if zero
		MOV	AX,4400H
		MOV	BX,ES:[DI]
		CALL	SUB_20			; (0957)
		TEST	DX,80H
		JZ	LOC_374			; Jump if zero
		MOV	WORD PTR ES:[DI+6],1
LOC_374:
		CMP	BYTE PTR DS:[238H],1	; (9966:0238=55H)
		JAE	LOC_375			; Jump if above or =
		MOV	BYTE PTR ES:[DI+2],80H
		MOV	BX,ES:[DI+4]
		MOV	ES:[DI+8],BX
		MOV	ES:[DI+0AH],BX
		RETN
LOC_375:
		JZ	LOC_380			; Jump if zero
		MOV	AX,4202H
		MOV	BX,ES:[DI]
		XOR	CX,CX			; Zero register
		XOR	DX,DX			; Zero register
		CALL	SUB_20			; (0957)
		MOV	CX,ES:[DI+6]
		CMP	CX,80H
		JB	LOC_376			; Jump if below
		MOV	CX,80H
LOC_376:
		SUB	AX,CX
		SBB	DX,0
		JNC	LOC_377			; Jump if carry=0
		ADD	AX,CX
		MOV	CX,AX
		XOR	AX,AX			; Zero register
		XOR	DX,DX			; Zero register
LOC_377:
		PUSH	CX
		MOV	CX,DX
		MOV	DSH	,0FFFBp
		XOR	DX,DX			; Zero register
		RETN
		JNZ	LOC_350			; Jump if not zero
		CALL	SUB_90			; (219A)
		JC	LOC_345			; Jump if carry Set
		INC	SI
		MOV	CL,[SI]
		CMP	CL,2BH			; '+'
		JE	LOC_347			; Jump if equal
		CMP	CL,2DH			; '-'
		JNE	LOC_348			; Jump if not equal
		OR	CH,20H			; ' '
LOC_347:
		INC	SI
LOC_348:
		CALL	SUB_91			; (21B0)
		JC	LOC_345			; Jump if carry Set
		PUSH	AX
		MOV	AL,CL
		INC	SI
		CALL	SUB_91			; (21B0)
		JC	LOC_349			; Jump if carry Set
		MOV	AH,AL
		SHL	AL,1			; Shift w/zeros fill
		SHL	AL,1			; Shift w/zeros fill
		ADD	AL,AH
		SHL	AL,1			; Shift w/zeros fill
		ADD	AL,CL
		INC	SI
LOC_349:
		MOV	CL,AL
		POP	AX
		TEST	CH,20H			; ' '
		JZ	LOC_350			; Jump if zero
		NEG	CL
LOC_350:
		CALL	SUB_90			; (219A)
		MOV	[DI],AX
		MOV	[DI+2],BX
		MOV	[DI+4],DX
		JMP	SHORT LOC_345		; (2146)
SUB_89		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_90		PROC	NEAR
		CMP	CL,0DAH
		JL	LOC_351			; Jump if < cmp="" cl,26h="" ;="" '&'="" jg="" loc_351="" ;="" jump="" if="">
		PUSH	CX
		PUSH	SI
		PUSH	DI
		CALL	SUB_93			; (21C1)
		POP	DI
		POP	SI
		POP	CX
		RETN
LOC_351:
		STC				; Set carry flag
		RETN
SUB_90		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_91		PROC	NEAR
		MOV	CL,[SI]
  
;==== External Entry into Subroutine ======================================
  
SUB_92:
		CMP	CL,30H			; '0'
		JB	LOC_RET_352		; Jump if below
		CMP	CL,3AH			; ':'
		CMC				; Complement carry
		JC	LOC_RET_352		; Jump if carry Set
		SUB	CL,30H			; '0'
  
LOC_RET_352:
		RETN
SUB_91		ENDP
  
  
;==========================================================================
;			       SUBROUTINE
;==========================================================================
  
SUB_93		PROC	NEAR
		PUSH	DX
		PUSH	BX
		PUSH	AX
		MOV	BYTE PTR DS:[224H],CL	; (9966:0224=59H)
		OR	CL,CL			; Zero ?
		JNS	LOC_353			; Jump if not sign
		NEG	CL
LOC_353:
		MOV	BL,CL
		AND	BL,0FCH
		MOV	BH,BL
		SHR	BL,1	Et
		S			n
  r1l_353ENDP
		MOV	CL,[uINE66:02257)
	 Zero H	DAtRotñ'
		JB	LOC_RET_352		; Jump iBROUTINE
;==========================================================================OV	CX,ES:[DI+6]
		CMP	CX,80H
		JB	LOC_376			; Jump if below
		MOV	CX,80H
LOC_376:
		SUB	AX,CX
		SBB	DX,0
		JNC	LOC_377			; Jump if carry=0
		ADD	AX,CX
		MOV	CX,AX
		XOR	AX,AX			; Z8		; Jump if not zerB	CL,30H			; '0'
  
LOC_RET_35DX
		PUSH	BX
		MOV	BYTE PTR========44o ?
	(2873)================3==============
8			       SUBROUTINE
;==========================================================================OV	CX,ES:[DI+6]
		CMP	CX,80H
		JB	LOC_376			; Jump if below
		MOV	CX,80H
LOC_376:
		SUB	AX,CX
		SBB	DX,0
		JNC	LOC_377			; Jump if carry=0
		ADD	AX,CX
		MOV	CX,AX
		XOR	AX,AX			; Z9	ADD	[BX+SI],DL
		p if equal
		CMP	CL,2DH			; '-=
  
======592:
		CMP	CL,30H			; '0		JC	LOC_3========4te thru		SUB	CL,30H			; '0'
 0BH,BL
	4External Ent
;=========zerBOV	0180=0F9H)
======592:
		CMP	C2		; Jump if===zerBOVMOV	BL,CL
======592:
		CMP	C	BYTE PTR DS:350:
		CALL	SU]	; Zero registeEt
	 Zero H	DAtRotñ'	POP	SI======592:
		CMP	CE PTR DS:[238H]MOV	AH,ALero
		SHL	AL,1			; Shift==============5==============
9OC_367:
		PUSH	DI
		MOV	SI,0B6H
		LEA	DI,[DI+0CH]		; Load effective addr
		MOV	CX,20H
		CLD				; Clear direction
		REP	MOVSW			; Rep when cx >0 Mov [si] to es:[di]
		POP	DI
		CALL	SUB_100			; (	WORDDD	[BX+SI],DL
		)E 9xternal Ent24B ' '
LOC_3LOOP===6================F9H)
		JNE	LOC2		; (9966:
		)E 3 '
LOC_3LOOP===CL,BYTE PTR D[S================45			; 0AA0===
  
R DNC	LBX]try into Sub8outine ================rry flag
		RE5:
		POP	Ent6,BX
OOP	C_3LOOP===65:
		oCMP	CEST	 0)
  
;===8CL,[SIC_367			; Jump if not equal
		CMP	DI,8w
		C==============flag

OOP	C_3LOOP===75:
		oCMP	CEST	 0)
  
		MOV	BCabove or =
		MOV	ernal3A
LOC_:ET_35DX
		PU38B_92:
		CMP	CL,30	BYTE PTR DS:R DNC	LBX]try nal EntNC	LBX+1]=============
:0186Iag
:018======
		SH	LOCeroOCeroO 5H
	5 =
4 zero
		SH	LOCeroOCeroO 4359	4 =
44ill
		RC82LOCeroOCeroO 4C=
LOC_ 5H
		RC43LOCeroOCeroO 4	LO 5R	BX58zero
		SH4LOCeroOCeroO 55=
LOC_ 52zero
		SHR	BCeroOCeroO 4t w/4Jump50
		RC   ,C   ,C   ,C4roO 55=
LH
		RC   ,C 1 ,C   ,C45
	5 =
52zero
		C   ,C 2 ,C   	PUSH	DI
		MOV	SI,0B6H
		LEA	DI,[DI+0CH]		; Load effective addr
		MOV	CX,20H
		CLD				; Clear direction
		REP	MOVSW			; Rep when cx >0 Mov [si] to es:[di]
		POP	DI
		CALL	SUB_100			; (	W1		; Jump if not zer350:
		CALL	SU]	; Zero regDX
		PUSH	BX9	SHL	AL,1			; Shift w/zero Jump i3D			; ':'
	D DS:[22MP	SHODI],AX
		MOV	[DI+2],BX
		MOV	[DI+4],DX
			; Ze9===========================t
		POP	DI
		CALL	SUB_100			; (	W2		; Jump if notOUTINE
;============================ DS:350:
		C		MOV	2DI+266:LOCX
		MOV	2=6A0====== DS:350:
		C		MOV	4DI+DSLOCX
		MOV	4=0E90		; Shif
		MOV	AH===============================NE
;====================================== DS:350:
		C		MOV	2DI+DILOCX
		MOV	2=6A0====== DS:350:
		C		MOV	4DI+ESLOCX
		MOV	4=0E90		; ShiMP	SHODI],AX
ROC	NEAR
 
LOC_RET_35DX			; Ze9)
		MOV	AL,2
LOC_371:
				; Zero re3
		SHL	AL,1			; Shift	; Ze94: Shif
		MOV	AH=========================[238H],1	;ero regD
		JB	LOC_RET95======58D)
		XOR	DX,DX			; Zero register
C_RET95,ES:[DI+2NE
;============================ DS:350:
		C		MOV	2DI+25A
LOCX
		MOV	2=6A0====== DS:350:
		C		MOV	4DI+DSLOCX
		MOV	4=0E90		; ShiP	CLNE
;68		; '============5C=72=======	TES============I=========AB0)
		JC	LOC_103=======5B4=========AB0)
OR	DX,DX			; Zero ?,DX
			; Ze9>
		PUSH	CX
H			; '0		JC	LOC_25C)
		CA99ift	; Ze96,ES:[DI+2N	; (9966:0180=0f
		MOV	AH=========================USH	DI
	DSH	,0FFFBp
		XOR	DX,DX			; Zero register
		RETN
  
;=H,DH			; Zero register
USH	DI
	DSH	,0FFFBp
		XOR	DX,DX			; Zero register
		RETN
C=
		RE		PUSH	SI
		P=
		MOV	AH6===S	===========2=430Ehift	; Ze98: 
  
;C DNX			; Zero register
C_RET9w
		C		JC	LOC_26C)
		CA75===== DS:D DS:[22  
R D8try into Su402],AL
		LEA	A
		JC	LOC 
R D7BL,CL
402],AL
		LEA	A
		JC	LOC 
R D4,CL
40o ?
		JNS	LOC
		JC	LO:0186LC	LOC 
R D18L,CL
402],AL
		LEA	A
		JC	LOC 
R D1BL,CL
402],AL
		LEA	A
		JC	LOC 
R D12L,CL
40o ?
		JNS	LOC
		JC	LOC 
R D1Entry into Su40	LOC_348			; J
		JC	LOC 
R D0Dntry into Su40)
		MOV	AL,2
		JC	LOC 
R D2		S			n
C DNntry into Sub9outine =======ft w/zero JumpH,LBX]try nal LBX],DXSUBR====CXSUBR====Babove or pH,2		S			n
SUB_89		ENLBX],DDI
		C40=
		C		JC	LOC_105========52tRotñ'
		JB	LOC_RET9out====5CF)I
		C40if not:018CXSUBRJSto Sub9B_92:
		CMP	Csign=1
		C		JC	LOC_27C)
		CA81)0)
OR	LBX+rnalEntry OR	LBX+rnalEL not:018flag
:0186LT_35DX			; Z402],AL
		LEA	AL,30H			; '0'
		JB	LOC_RET9out====5CF)I
		C40	SHR	BL,1	EL,LBX]try C 
R D2		S			n
		JNS	LOCL,30H			; '0'
		JB	LOC_RET9out====5CF)I
		C403: 
 
;=H,DH			; Zero ?,DX
			; Ze9outine =======H			; '0'
		JB	LOC_RE405======63F)I
		C404: 
 
;=H,DH			; Zero ?,DX
X			; Z40>
		PUSH	CX
L,30H			; C_RE405Set
		SUB	CL,30H	LBX],1Entry i
		JB	LOC_RE407======64C)I
		C406
		C		JC	LOC_25C)
		CA99ift== DS:350:
		CLBX],0A0Dntry ====BaboC_RE407
		C====
		JNE	LOCMOV	AH7===S	===========4=8A2Ehift w
LOC_	; (	W2OC_367:
		PUSH	DI
		MOV	SI,0B6H
		LEA	DI,[DI+0CH]		; Load effective addr
		MOV	CX,20H
		CLD				; Clear direction
		REP	MOVSW			; Rep when cx >0 Mov [si] to es:[di]
		POP	DI
		CALL	SUB_100			; (	W5	ADD	[BX+SI],DL
		p=
		JC	LOC_25C)
		CA63=========AB0)
 DS:DOV	A95,A
LOC_	; (	W5OC_367:
		PUSH	DI
		MOV	SI,0B6H
		LEA	DI,[DI+0CH]		; Load effective addr
		MOV	CX,20H
		CLD				; Clear direction
		REP	MOVSW			; Rep when cx >0 Mov [si] to es:[di]
		POP	DI
		CALL	SUB_100			; (	W6	ADD	[BX+SI],DLLESLDI,D350:
		C		MOV	2DILOCX
		MOV	2=6A0==LOC_3732 bit ptr
USH	DI
	DSH	,0FFFBp
		XOR	DX,DX			; Zero register
		RETN
		CC
		MOV	AH4,0============			; Shift wDX
		PU41		POP	CX
		REL,30	BYTE PTR DS:R Df equal
		CMMP	SHR D2		S			n
		PUSH	CX
L,30H			; CMP	CL,2DH			; '-=
  
40outine =======
LOC_371:
				;Ent
;===	; (996=zerBOV59H)
		OR	CL,CLB
  
40B_92:
		CMP	C		PUSH	SI 	JC	LOC_10========6Ee thru		SUBnt
;===	; (9  
40BSHR	BL,1	EL,EC	LBX]try ====
		JNE	LOC
;===	; ,
		JNEi
		JB	LOC_RE415======6D6)I
		C409ual
		TES============I====C 
R D1ft wDX
		PU412],AL
		LEA	AL,30	BYTE PTR DS:BntMOV	AH6S	===========2=430Ehift96=zerBOVMOV	AH7S	===========4=8A2Ehift wLB
  
41==============		PUSH	SI
		=H,EL not 	JC	LOC_104=======5B6 thru		SUBntMOV	AH6S	===========2=430Ehift  
41=SHR	BL,1	EL,LBX]try ====
		JNE	LOCMOV	AH6===S	===========2=430EhiftNEi
		JB	LOC_RE414======6D4ift  
411
		CC
		R D2ft wDX
		PU41o ?
		JNS	LOCL,30
		JC	LO:018SP not 	JC	NE
;60=============	[D0iftNEi
		JB	LOC_RE414======6D4ift  
412
		CC
		R D4 regDX
		PU41	LOC_348			; JL,30
		JC	LO:018SP not 	JC	NE
;64=============40D0iftNEi
		JB	LOC_RE414======6D4ift  
413f not:018SP not 	JC	NE
;66=============44D0iftC_RE414,ES:[DI+2N	; (9966:0180C_RE415SHR	BL,1	
;===	3alEL not
;ODI],AX
ROC	NEAR
2
LOC_ '			;2H
		MOV	41>SHR	BL,1	EL,EC	L==	3a			;2H
		MOV	41CL,BYTE PTR D1Entry 
LOC_	; (	W6OC_367:
		PUSH	DI
		MOV	SI,0B6H
		LEA	DI,[DI+0CH]		; Load effective addr
		MOV	CX,20H
		CLD				; Clear direction
		REP	MOVSW			; Rep when cx >0 Mov [si] to es:[di]
		POP	DI
		CALL	SUB_100			; (	W8	ADD	[BX+SI],DL
		p=
;========
		)E EC	L==	6=====
		DE EC	L==	4]===========================I+2NSzero6:02257)
	 Zero H	DAtRotñ=====SRotñ'	POP	SI41B_92:
		CMP	CE PTR DS:[2XOR	DXfAX			; Zero register
C_RE41BSet
		SUBE EC	L==	4]====OR	DXfAX			; Zero ?,DX
X			; Z41outine =======
LOC_371:
				;EDI],AX
ROC	BX],1Entry ====AaboC_RE419SHR	BL,1	
;===	; ,
		JNEPOP	EntAB0)
 DS:59H)
		OR	,
		JNE
LOC_	; (	W8OC_367:
		PUSH	DI
		MOV	SI,0B6H
		LEA	DI,[DI+0CH]		; Load effective addr
		MOV	CX,20H
		CLD				; Clear direction
		REP	MOVSW			; Rep when cx >0 Mov [si] to es:[di]
		POP	DI
		CALL	SUB_100			; (	W9		; Jump if notO	TES============I====		SUBE ; (996C_RE420ual
		TESBB0)
		JC	LOC_106=======665tRotñ====Babove or p D1Entry into Su42o ?
		JNS	LOC
		JC	LOP	CLODI],AX
ROC	NEAR
	; 'try C 
R D2		S			n
SUB_o Su42if not zerLBX],DXSUBR====Babove or BE 135ntry into Su42o ?
		JNS	LOC
		JC	LO		TESBB0)
		JC	LOC_106=======665tRotñ====Babove or p D2		S			n
		JNS	LOC		PUS)
SUB_LOP	CLODI],AX
ROC	NEAR
	; 'try i
		JB	LOC_RE421======72F)I
		C42	SHR	BL,1	B	CL,30H	LBX],0====		SUBE ; (996ve or B	CL,30H	LBX],0====DI+2N	; (9966:0180=0
LOC_	; (	W9OC_367:
		PUSH	DI
		MOV	SI,0B6H
		LEA	DI,[DI+0CH]		; Load effective addr
		MOV	CX,20H
		CLD				; Clear direction
		REP	MOVSW			; Rep when cx >0 Mov [si] to es:[di]
		POP	DI
		CALL	SUB_100			; (	1===; Jump if notV	ES:[D42	LOC_348			; JX,[DI+4CH]		; or B	CL,30H	LBX],0====J
		PUSH	B424?
		JNS	LOC
		JC	S:[D42	f not zerMOV	AH,A10o
		SHL	AL,1			; Shift		STC	LOC_34CHJX,[DI+flagft============424NC	SI
LOC_	; (	1===	       SUBRO=====I====C	JC	LOC_106=======665tRotñP	CLODI],AX
ROC	NEAR
	; 'try DI+2N	; (9966:Babove========== DS: Jump ifALtry i
	BX			;*Register jJNS====CLC	LOC_3ClearJX,[DI+flagfty i
		JB	LOC_RE425======777ift		STC	LOC_34CHJX,[DI+flagftC_RE425,ES:[DI+2Babove==========		TESBB0)
		TEF	LOC_3Push+flags====C	JC	LOC_109=======71e thru
			; Z42		POP	CX
		REH			; '0		JC	LOC_5	 Zero 11A7ift		C	JC	LOC_11========754=====V	ES:[D42		POP	CX
		REX,[DI+4CH]		;===F	LOC_3Pop+flags===='	POP	SI42>
		PUSH	CX
E PTR DS:[2 DS: Jump ifA		JNE
LOC_P	SI42>SHR	BL,1	
;===ifALtry 
LOC_P	SI427,ES:[DI+F	LOC_3Pop+flags====
LOC_:[DI+2Babove==========		TESBB0)
C	JC	LOC_109=======71e thru
			; Z====428POP	CX
		REH			; '0======I=============== DS:DI,23Entry C	JC	LOC_H=======20CD thru		SUSI,D	; (9966:0180=0DI+2N	; (9C	JC	LOC_11========754=====V	ES:[D====428POP	CX
		REX,[DI+4CH]		; LD	LOC_3ClearJdirectionthru		SSW	LOC_3Mov [si] X		es:[di=====
	SW	LOC_3Mov [si] X		es:[di=====
	SW	LOC_3Mov [si] X		es:[di===============428NC	SI
LOC_:[DI+2Babove==========		TESBB0)
XOR	BE BX			; Zero register

  
;CHDNn			; Zero register
USH	===LOOP=429ual
		TES============I====		TESBB0)
		TE	)E0)
		JC	LOC_106=======665tRotñ====Cabove====Babove or p D0Dntry into Su43==============
		JC	LOC 
R D1Entry into Su43==============
		JC	LOP	CLODI],AX
ROC	NEAR
	; 'try DI+2N	; (9966:==========
		JNE	LOC
;=BX+==ifALtry LOOP	===LOOP=429====Loo
		REXx > 0    SUBRi
		JB	LOC_RE431======7DC)I
		C430,ES:[DI+2N	; (9966:0180C_RE43if not zer
;===ifBLtry 
LOC_:[DI+2Babove==========		TESBB0)
XOR	CHDNn			; Zero register
USH	===LOOP=432ual
		TES============I====		TES)E0)
		JC	LOC_106=======665tRotñ====Cabove LD	LOC_3ClearJdirectionthru or p D0Dntry into Su43	LOC_348			; J
		JC	LOC 
R D1Entry into Su43	LOC_348			; J
		JC	LOP	CLODI],AX
ROC	NEAR
	; 'try DI+2N	; (9966:======STOSB	LOC_34tore FFBX		es:[di=====LOOP	===LOOP=432====Loo
		REXx > 0    SUBR
LOC_P	SI433,ES:[DI+2N	; (9966:0180=0E PTR D2		S			n
LOC_P	SI434
		C		JC	LOC_106=======665tRotñC 
R D1Entry into Su====435?
		JNS	LOC
		JC	LOP	CLODI],AX
ROC	NEAR
	; 'try C 
R D0Entry into Su====435?
		JNS	LOC
		JC	LO or p D0Dntry iX
		PU43)
		MOV	AL,2
		JC	LO		JC	LOC_106=======665tRotñC 
R D0Entry iNnto Su====435?
		JNS	LOCL,30
		JC	LOP	CLODI],AX
ROC	NEAR
	; 'tr============435NC	SI
LOC_USH	DI
		MOV	SI,0B6H
		LEA	DI,[DI+0CH]		; Load effective addr
		MOV	CX,20H
		CLD				; Clear direction
		REP	MOVSW			; Rep when cx >0 Mov [si] to es:[di]
		POP	DI
		CALL	SUB_100			; (	11==; Jump if n		PU43>SHR	BLESLDI,D350:
		C		MOV	2DILOCX
		MOV	2=6A0==LOC_3732 bit ptr
	CC
		MOV	AH4,0============			; Shift wDX
		PU====441,AL
		LEA	AL,30	BYTE PTR DS:C Df equal
		CMP	CLC2DH			; '-=
  
43		POP	CX
		REL,30_371:
				;Ent
;===	; (996	LOC
;=BX],DXSUBR====BaboveL,1	
;===	; ,
		JNE=zerBOV59H)
		OR	CL,CL
		PU44o ?
		JNS	LOC
		JC	LO
LOC_P	SI437ual
		TESA		JNE=zerC D1ft wD
		PU43B_92:
		CMP	C
		JC	LO or C D3ft wD
		PU43outine =======ft w/zero or C D4CL,CL
		PU44==============
		JC	LOC	JC	NE
;65=============42D0iftNE
LOC_P	SI438
		C		JC	NE
;61=============	AD0iftNE
LOC_P	SI439
		C		JC	NE
;62=============	CD0iftNE
LOC_P	SI44=
		C		JC	NE
;63=============	ED0ift============441NC	SI
LOC_		PU44of not zer)E EC	L==	; (996	; r)E EC	L==	4]====
			; Z====444?
		JNS	LOC_371:
				;p=
;========
		DE EC	L==	4]====L,1	
;===	; ,DB0)
		TE	==================I+2NSzero6:02257)
	 Zero H	DAtRotñ=====SRotñ'POP	SI44	LOC_348			; JX,[DI+4CH]		; or DXfCaboveinto Su====444?
		JNS	LOC
		JC	S:[D44	f not zerMOV	AH,A0F0o
		SHL	AL,1			; Shift============444NC	SI
LOC_	; (	11==	       SUBROR	DXfAX			; Zero ?,DX

  
44>
		PUSH	CX
H			; '0		JC	LOC_32C)
		CAC9tRotñC 
R D1			; Jnto Su44>
		PUSH	CX
		PUS)
SUB_LOXCHG DXfCabove:018CaboUSH	===LOOP=445SHR	BL,1	R D2		S			n
		JC	LOC_112],AL
		REXx > 0    SUo Su44>,ES:[DI+2Babove====AB0)
		TE	
		JNEi
			PU43>],AL
		TE	
		JNE		TES)E0)
		SUBE ; (996ve 	JC	LOC_47 Zero 111B)I
		C447,ES:[DI+=AB0)
		JC	LOC_32C)
		CAC9tRotñ	; rBE ; (996ve	; rDXf
		JNEiJnto Su44outine =======		PUS)
SUB_LOXCHG DXfCabove		TE	
		JUSH	===LOOP=44BSHR	BL,1	EL,2		S			n
		JC	LOC_112],AL
		REXx > 0    SUBRDI+2Baboo Su44of not zer)E BaboveL,1	BE ; (996USH	===LOOP=45=SHR	BL,1	EL,LBX]try 		TESBB0)
		TE	)E0)
		JC	LOC_112],AL
		REXx > 0    SUBR
LOC_LOXCHG DXfDaboveDI+2Babove====)E0)
		SUDI,23Entry ====350:
		C============350:
		C===l
		CM====350:
		C===l4]=========
		JNE		TES)E0)
		SUBE ; (996ve 	JC	LOC_82C)
		1F45iftNEi
		JB	LOC_RE447,AL
		JNE		SUDI,291BHSUBROR	)E CX			; Zero ?,DX
X			; Z452],AL
		LEA	AL,30_371:
				;DI,292		boo Su451ual
		TESCSzero6:02257)
		2926iftNE
LOC_NEPOP	EL,54	S			n
		TE	BPbove====BPC_NEPOP	EX,414(996ve:018SP notD====
		JNE====BPC_USH	DI
		MOV	SI,0B6H
		LEA	DI,[DI+0CH]		; Load effective addr
		MOV	CX,20H
		CLD				; Clear direction
		REP	MOVSW			; Rep when cx >0 Mov [si] to es:[di]
		POP	DI
		CALL	SUB_100			; (	12==; Jump if not		JC	LOC_32C)
		CAC9tRotñ		SUBE SPbove====Babove====Babove	; rDL,S
;=BX]	JNEiJnto Su45	LOC_348			; J		PUS)
SUB_LO DS:C DDXSUBRXOR	CHDNn			; Zero register
ve		TE	
		JUSH	===LOOP=45of not zerEL,2		S			n
		JC	LOC_112],AL
		REXx > 0    SUBRDI+2Baboo Su45	f not zerCL,S
;=BX]	JNEXOR	CHDNn			; Zero register
ve====BaboveOR	)E CX			; Zero ?,DX
			; Z455
		PUSH	CX
H			; USH	===LOOP=454f not zerEL,S
;=BX]	JNE		TESBB0)
		TE	)E0)
		JC	LOC_112],AL
		REXx > 0    SUo Su455,ES:[DI+2D		JNE		SUSPf
		JNEi
		MX			;*Register jJNS==USH	DI
	 ExternFFBEntDI+inX		Subroutine  [si] to es:[di]
		POP	DI
		CALL	SUB_100			; (	13,ES:[DI+2
		JNE		SUCL,C
;=BX]	JNEXOR	CHDNn			; Zero register
ve====BaboveJCX			; Z45		POP	CX
		REXx=0    SUo SLOOP=45>SHR	BL,1	AL,C
;=BX]	JNE		TESBB0)
		TE	)E0)
		JC	LOC_112],AL
		REXx > 0    SUo Su457,ES:[i
	BX			;*Register jJNS====L,1	AL,0Dntry 		JC	LOC_112],AL
			PU43>],AL
		DE 10Dntry i
		JB	LOC_RE458)
		2991tRotñL,1	DE 0Dntry i
		JB	LOC_RE458)
		2991tRotñL,1	DE 11Entry i
		JB	LOC_RE458)
		2991tRotñL,1	DE 1A	boo Su458,ES:[DI+2350:
		C		MMOV	A9E
		C000L,1	6D0iftNE==========		TES350:
		C		MMOV	A9E
		C000L,1	6D0iftNETESTLODI],AX
ROC	NEAR
80H,DX
			; Z462],AL
		LEA	AH			; o Su459ual
		TESDE0)
		JC	LOC_107=======669tRotñ=====above or p DDLCL,CL
		PU46==============
		JC	LOC 
R D1Entry into Su46==============
		JC	LOC 
R D2		S			n
		LEA	AaboveboveOR	DH,Dn			; Zero ?,DX
			; Z462],AL
		LEA	AH			; LOP	CLODI],AX
ROC	NEAR
	; 'try i
		JB	LOC_RE459)
		29A1)I
		C46=SHR	BXOR	DXfAX			; Zero register
ve====A		JNE
LOC_P	SI461SHR	BXOR	DXfAX			; Zero register
ve
LOC_USH	DI
		MOV	SI,0B6H
		LEA	DI,[DI+0CH]		; Load effective addr
		MOV	CX,20H
		CLD				; Clear direction
		REP	MOVSW			; Rep when cx >0 Mov [si] to es:[di]
		POP	DI
		CALL	SUB_100			; (	14==; Jump if notXOR	D DDX			; Zero register
vei
			PU36>],AL
vei
		JB	LOC_RE464)
		29CF)I
		C46	f not zerR D1		C_RE464SHR	BL,1	B	CL,30H			MOV	8H],DXLOCX
		MOV	8=55HtRotñ=====OV	AH8=============	6D5007HtRotñ================OV	AH8=============	6D5007HtRotñ=	TE	)E0)
		JC	LOC_11>],AL
		PU====465?
		JNS	LOCL,30
		JC	LO		TES)E0)
		JC	LOC_102],AL
		PU====465?
		JNS	LOCL,30
		JC	LOL,1	
;===	R
CaboUSH	===U====465NC	SI
LOC_:[DI+2=OV	AH8=============	6D5007HtRotñ================OV	AH8=============	6D5007HtRotñ			;p=
;========XOR	)E CX			; Zero register
vei
			PU8	 Zero H	DAtRotñ
LO	2C_USH	DI
		MOV	SI,0B6H
		LEA	DI,[DI+0CH]		; Load effective addr
		MOV	CX,20H
		CLD				; Clear direction
		REP	MOVSW			; Rep when cx >0 Mov [si] to es:[di]
		POP	DI
		CALL	SUB_100			; (	15==; Jump if notDI+2=OV	AH8=============	6D5007HtRotñ================OV	AH8=============	6D5007HtRoUSH	DI
	 ExternFFBEntDI+inX		Subroutine  [si] to es:[di]
		POP	DI
		CALL	SUB_100			; (	1>SHR	BL,1	350:
		CROC	NEAR
	
vei
			PU384],AL
		C		MOV	2DI,D	LOCX
		MOV	2=6A0======L,1	350:
		C		MOV	4DI,ESLOCX
		MOV	4=0E900====== or 350:
		CROC	NEAR
	
veiX
		PU46>
		PUSH	CX
L,30
		JC	LOL,1	MOV	AH4,4============			; Shift		PU46>,ES:[i
	=OV	AH8=============	6D5007HtRotñ			;350:
		C		MOV	8H],993FHLOCX
		MOV	8=0B855HtRotñi
		JB	LOC_RE467,AL
		C		MOV	8H],0F04		SOCX
		MOV	8=0B855HtRoC_RE467,ES:[DI+2Babove====SI====		TESBB0)
 or MOV	AH4,0============			; Shift wDX
		PU====469
		PUSH	CX
L,30
		JC	LOL,1	MXfDIHR	BLESLDI,D350:
		C		MOV	2DILOCX
		MOV	2=6A0==LOC_3732 bit ptr
	C			;p=
		MOV	8=55HtRotñnal Ent
;========
		)E EC	L==	2]	JNE		TESD=====L,1	DS,SI====6:02257)
	 Zero H	DAtRotñ=====SRotñ'POP	SI46B_92:
		CMP	CX,[DI+4CH]		; or DXfCaboveinto Su====469
		PUSH	CX

		JC	LOC 
B	CL,30H			MOV	8H],3FHLOCX
		MOV	8=55Ht '?'
veiX
		PU46B_92:
		CMP	CL,30
		JC	LOOR	DXfAX			; Zero ?,DX

  
46B_92:
		CMP	C_371:
				;)E EC	L==	2]	JNE			;DI,=abovePOP	DI,AaboveL,1	
,SI====	; r)E AaboveXOR	DXfAX			; Zero register
ve LD	LOC_3ClearJdirectionthruREP=STOSB	LO; Rep whenEXx >034tore FFBX		es:[di=====
LOC_P	SI46BSHR	BL,1	EL,B	CL,30H			MOV	9H]LOCX
		MOV	9=0B8HtRotñnal MOV	AH4,DX				SHL	AL,1			; Shift============469NC	SI
LOC_USH	DI
		MOV	SI,0B6H
		LEA	DI,[DI+0CH]		; Load effective addr
		MOV	CX,20H
		CLD				; Clear direction
		REP	MOVSW			; Rep when cx >0 Mov [si] to es:[di]
		POP	DI
		CALL	SUB_100			; (	17==; Jump if notXOR	MXfDX			; Zero register
P	SI470,ES:[DI+2DOV	AH8=============	6D5007HtRotñ====DIHR	B================OV	AH8=============	6D5007HtRotñ			;)E EC	L==	2]	JNE		JC	LOC_1
	 Zero 2B69tRotñ		SUCXfDaboveL,1	MXfAaboveL,1	EX,4200H,DX
;========		TES)E0)
		TESDE0)
		JC	LOC_
	 Zero H	DAtRotñ====CaboveDI+2Babove'POP	SI472],AL
		LEA	AX,[DI+4CH]		; or DXfCaboveiX
		PU472],AL
		LEA	AL,30
		JC	LO or MXf
		JNEinto Su====472?
		JNS	LOC
		JC	S:[D471f not zerMOV	AH,A91o
		SHL	AL,1			; Shift============472NC	SI
LOC_	; (	17==	       SUBR		JC	LOC_95],AL
		JB	LOC_RE470,AL
		JNE		SUEX,4406H,DX
;========		JC	LOC_
	 Zero H	DAtRotñOR	D DDX			; Zero ?	JNE		SUEX,0,DX
X			; Z47	LOC_348			; JL,30_371:
	====A		J	; Z47	:C	LOOR	DXfAX			; Zero ?,DX
LOC_:[DI+2Babove===============
		JUSH	DI
		MOV	SI,0B6H
		LEA	DI,[DI+0CH]		; Load effective addr
		MOV	CX,20H
		CLD				; Clear direction
		REP	MOVSW			; Rep when cx >0 Mov [si] to es:[di]
		POP	DI
		CALL	SUB_100			; (	18==; Jump if notL,1	EX,4201H,DX
;========XOR	)E CX			; Zero register
veXOR	MXfDX			; Zero register
==		JC	LOC_
	 Zero H	DAtRo	; Z474SHR	BL,1	)E EC	L==	2]	JNEi
		JB	LOC_RE475Zero 2B4Cift		NOPRotñ====Babove===============
		JNE		JC	LOC_118],AL
			PU362C)
		22B4tRotñ====Babove===============
		JUSH	DI
	 ExternFFBEntDI+inX		Subroutine  [si] to es:[di]
		POP	DI
		CALL	SUB_100			; (	1of not zerEX,4201H,DX
;========XOR	)E CX			; Zero register
veXOR	MXfDX			; Zero register
==		JC	LOC_
	 Zero H	DAtRo=======AB0)
		TE	DaboveL,1	EX,4202H,DX
;========XOR	)E CX			; Zero register
veXOR	MXfDX			; Zero register
==		JC	LOC_
	 Zero H	DAtRo======CaboveDI+2Babove=====AB0)
		TE	DaboveL,1	MXf
		JNEL,1	EX,4200H,DX
;========6:02257)
	 Zero H	DAtRotñ=====above====AB0)
L,1	)E EC	L==	2]	JNE:018CabovePOP	DXfCaboveADC	DE 0	JNEi
		JB	LOC_RE474)
		2AFAtRotñ====Babove===============
		JNE		JC	LOC_119 Zero 2B0AtRotñi
			PU362C)
		22B4tRoC_RE475:C	LO or )E 1	JNEinto Su====478
		PUSH	CX

		JC	LO		SUSIfCaboveXOR	EntBX			; Zero register
==L,1	)E 21996USH	===LOOP=47>,ES:[RCL	Ent2],AL
XPOP	SI47		POP	CX
		REX,[DI=0bovePOP	BE SI,DX
		REXx > 0    SU============478NC	SI
LOC_	; (	18==	       SUUSH	DI
		MOV	SI,0B6H
		LEA	DI,[DI+0CH]		; Load effective addr
		MOV	CX,20H
		CLD				; Clear direction
		REP	MOVSW			; Rep when cx >0 Mov [si] to es:[di]
		POP	DI
		CALL	SUB_100			; (	
	 Z; Jump if notL,1	BXfAaboveL,1	EX,DaboveLUL	CX			; dx:ax = reg * axboveXCHG	EX,BaboveLUL	CX			; dx:ax = reg * axbovePOP	DX,Babove
LOC_	; (	
	 Z	       SUUSH	DI
		MOV	SI,0B6H
		LEA	DI,[DI+0CH]		; Load effective addr
		MOV	CX,20H
		CLD				; Clear direction
		REP	MOVSW			; Rep when cx >0 Mov [si] to es:[di]
		POP	DI
		CALL	SUB_100			; (	
1==; Jump if notXCHG	EX,CaboveDI+2Babove====DIHR	B=====
		JNEi
			PU462C)
		29C9tRo	; (	
1==	       SUBRXCHG	EX,CaboveDI+2Babove====DIHR	B=====
		JNEi
			PU463C)
		29CDtRoUSH	DI
		MOV	SI,0B6H
		LEA	DI,[DI+0CH]		; Load effective addr
		MOV	CX,20H
		CLD				; Clear direction
		REP	MOVSW			; Rep when cx >0 Mov [si] to es:[di]
		POP	DI
		CALL	SUB_100			; (	
2 Z; Jump if notL,1	350:
		C		MMOV	A19E,993FHLOCXC000L,V	8=0tRotñi
		JB	LOC_RE479)
		2B91tRoUSH	DI
	 ExternFFBEntDI+inX		Subroutine  [si] to es:[di]
		POP	DI
		CALL	SUB_100			; (	2	f not zer350:
		C		MOV	8H],0F04		SOCX
		MOV	8=0B855HtRoC_RE479,ES:[DI+2DOV	AH8=============	6D5007HtRotñ====Dabove====SI====	===DIHR	B===============A		JNE		JC	LOC_124],AL
		PU48==============L,30
		JC	LO or DXfCaboveinto Su48==============
		JC	LO		SUEL,B	CL,30H			MOV	9H]LOCX
		MOV	9=0B8HtRotñnal MOV	AH4,DX				SHL	AL,1			; Shifto Su48=,ES:[i
	=OV	AH8=============	6D5007HtRotñ			;350:
		C		MOV	8H],993FHLOCX
		MOV	8=0B855HtRotñi
		JB	LOC_RE481,AL
		C		MOV	8H],0F04		SOCX
		MOV	8=0B855HtRoC_RE481,ES:[DI+2DOV	AH8=============	6D5007HtRotñ		SUCXfDIHR	B====Babove====Aabove====Dabove====SI====	===DIHR	B===============Babove=====)E0)
		JC	LOC_124],AL
;===]fAabovei
	=OV	AH8=============	6D5007HtRoUSH	DI
	 ExternFFBEntDI+inX		Subroutine  [si] to es:[di]
		POP	DI
		CALL	SUB_100			; (	24:C	LO or 350:
		CROC	NEAR
	
veinto Su485=============
		JC	LOC 
350:
		CROC	NEAR
1	JNEinto Su482=============
		JC	LO		TE	DaboveLUL	350:
		CROC	NEAR
		MOV	8=55HtRotñnal Ent
;========		TESD=====L,1	DS,SI====6:02257)
	 Zero H	DAtRotñ=====SRotñ'XPOP	SI48	LOC_348			; JX,[DI=0bove		SUEL,B	CL,30H			MOV	9H]LOCX
		MOV	9=0B8HtRotñnal MOV	AH4,DX				SHL	AL,1			; ShiftveXOR	DXfAX			; Zero register
P	SI48	SHR	BL,1	)E EC	L==	2]	JNE or )E 1	JNEinto Su====484============
		JC	LO		SUDI,=abovePOP	DI,AaboveXOR	MXfDX			; Zero register
==DIV	CX			; ax,dx rem=dx:ax/regC	LOOR	MXfDX			; Zero ?,DX

  
====484============_371:
	C 
B	CL,30H			MOV	8H],3FHLOCX
		MOV	8=55Ht '?'
veiX
		PU====484============L,30
		JC	LO		TESAabove	; r)E DaboveL,1	
,SI====XOR	DXfAX			; Zero register
ve LD	LOC_3ClearJdirectionthruREP=STOSB	LO; Rep whenEXx >034tore FFBX		es:[di=========Aabove====A		J============484NC	SI
LOC_o Su485f not zerMOV	AH,A4============			; Shiftve
LOC_	; (	
2==	       SUBRDI+2=OV	AH8=============	6D5007HtRotñ================OV	AH8=============	6D5007HtRotñ			;p=
veLEA	MXfL==	0CH]L===Lo_37effective Fddr====		TESD=====		TES===========SRotñ6:02257)
	 Zero H	DAtRotñ=====SRotñ'XPOP	SI====487OC_348			; JX,[DI=0boo Su48>SHR	BL,1	MOV	AH,A1
		SHL	AL,1			; Shift============487NC	SI
LOC_:[DI+2=OV	AH8=============	6D5007HtRotñ6:02257)
veLEA	MXfL==	0CH]L===Lo_37effective Fddr====		TESDIC	LO		SUDI,0B6H,DX
	 Zero H	DAtRo=======D=====		TES===========SRotñ==============DIHR	B'POP	SI48>
		PUSH	CX
X,[DI+4CH]		;		SUSIf0B6H,DX
LOC_:[DI+2=OV	AH8=============	6D5007HtRotñ6:02257)

  
====490============_371:
	C 
p=
veiX
		PU48B_92:
		CMP	CL,30
		JC	LO		JC	LOC_
9 Zero 0AA0tRotñ	; rD D41	S			n
ve'POP	SI48>
		PUSH	CX
X,[DI+4CH]		;C 
pL,0FH,DX
		PU48>
		PUSH	CX
above or =Rotñ			;p=
	 Zero H	DAtRo==C 
B	CL,30H			MMOV	A57E,0==========0B8=0tRotñi
		PU====490============
		JC	S:[D48BSHR	BL,1	E=
	 Zero H	DAtRo=='POP	SI48>
		PUSH	CX
X,[DI+4CH]	============490NC	SI
LOC_:[nal E=
		JB	LOC_RE491,AL
C_RE491,ES:[DI+2DOV	AH8=============	6D5007HtRotñ6:02257)
		JB	LOC_RE489)
		2CBAtRotñ=====OV	AH8=============	6D5007HtRotñ==============Aabove======OV	AH8=============	6D5007HtRotñOR	D DDX			; Zero ?	JNE
X			; Z492=============L,30_371:
				;p=
	 Zero H	DAtRo======AL
C_RE492f not zerD DDX====POP	D D40	S			n
		C		MMOV	A55E+1,5C3A	S		SHL	AL,0B7=0tRotñL,1	p=
	 Zero H	DAtRo=='XPOP	SI49	LOC_348			; JX,[DI=0bove		SUB	CL,30H	[SI
	
P	SI49	f not zerSIf0B6H,DX
P	SI494SHR	BL,1	D D[SI

  
495=============_371:
	====SI========
		JNEL,1	EC	LBX+==]fAL	JNE:018CL	JNE
X			; Z494=============L,30_371:
495SHR	BL,1	
;===]fBLC	SI
LOC_:[nal EE 2C7CHRotñi
		JB	LOC_RE496)
		2D23iftveXOR	EntBX			; Zero register
P	SI496,ES:[DI+2DOV	AH8=============	6D5007HtRotñ================OV	AH8=============	6D5007HtRotñTEST==OV	A77A1
		SHL	AL,172	; 70hift wDX			; Z49B_92:
		CMP	CL,30_371:
	=====
		JNE		SUEX,3D00H,DX
	 Zero H	DAtRotñ=====above'POP	SI49		POP	CX
		REX,[DI+4CH]		;		SUBXfAaboveL,1	EX,4200H,DX
ve		JC	LOC_
	 Zero H	DAtRo=='POP	SI49		POP	CX
		REX,[DI+4CH]		;=====D=====		TESC==========SRotñL,1	E=
	 Zero H	DAtRotñ=====SRotñL,1	E=
	 Zero H	DAtRotñ zerSP,=OV	A78
		SHL	AL,174=707HtRotñ6:02257)
	$+25	S			*	JNE:B	0E9H, 22H, 00H,DP	SI49	f not zerD D1Rotñi
			PU391],AL
LOC_o Su49of not6:02257)
23tRotñ		SUC D42	S			n
ve	or DXf	
veiG	o Su501	POP	CX
		RE>Rotñi
			PU502C)
		2EDE),Do Su501SHR	BL,1	MI,3CAH,D		=====D=====		TESDIC	LO		SUpL,D	MMOV	A22E				SC000L,459=0tRotñXOR	DH,A	S			nZero register
ve		TESAaboveL,1	DXf	FFH,DX
DXf	
veiE			PU50	LOC_348			; J
		JC	LOi
			PU505],AL
		2B83ift		6:02257)
86ift wDX		$+5=============L,30_371:
	i
			PU504],AL
</'byte></'></'></sp></reg16></bp></reg16></di></reg16></si></reg16></dx></reg16></cx></reg16></bx></reg16></sp></reg16></bp></reg16></di></reg16></si></reg16></dx></reg16></cx></reg16></bx></reg16>