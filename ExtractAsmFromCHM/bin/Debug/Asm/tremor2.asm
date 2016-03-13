

; File Name		: TREMOR.COM
; Current Date/Time	: Wed Apr 21 01:46:16 1993
; Disassembly done with Master Core Disassembler
; Options used:
; -U2
; -DF
; -P9
; -F1
; -LH00100
; -LX00104
; -LH0C46C
; -LH0C46E
; -LH0C48C
; -VB00
; -VC70

        .286P

S00100  SEGMENT
        ASSUME  CS:S00100, DS:S00100, ES:S00100, SS:NOTHING

        org     0100h


H0000_0100:
	jmp	H0000_C489		;00100	E986C3
;---------------------------------------
	nop				;00103	90
;---------------------------------------
;MEM: Data in Code Area
X0000_0104     db      90h	       ;00104
	db	0C367h dup(90h) 	;00105
;---------------------------------------
H0000_C46C:
;---------------------------------------
;DOS0-SYS TERMINATE Program, INT 20h
;INT: 20h
	int	20h			;0C46C	CD20
;---------------------------------------
H0000_C46E:
	nop				;0C46E	90
	mov	di,0C489h		;0C46F	BF89C4
	and	ax,ax			;0C472	23C0		#
	mov	bx,0E4F1h		;0C474	BBF1E4
	mov	cx,0891h		;0C477	B99108
	push	ds			;0C47A	1E

;SEG: ES Change - Indefinite
	pop	es			;0C47B	07
H0000_C47C:
	xor	[di],bx 		;0C47C	311D		1
	sti				;0C47E	FB
	add	bx,0F6F5h		;0C47F	81C3F5F6

;ASM: Synonym
;A	sub	di,-02h 		;0C483	83EFFE
       db      83h,0EFh,0FEh

	loop	H0000_C47C		;0C486	E2F4
	nop				;0C488	90
H0000_C489:
	jmp	H0000_D079		;0C489	E9ED0B
;---------------------------------------
H0000_C48C:
	jmp	Short H0000_C499	;0C48C	EB0B
;- - - - - - - - - - - - - - - - - - - -
	nop				;0C48E	90
	nop				;0C48F	90
	nop				;0C490	90
	jmp	H0000_D079		;0C491	E9E50B
;---------------------------------------
H0000_C494:
	call	H0000_CFC8		;0C494	E8310B		 1

;MEM: Possible Data - Invalid Code
;A	jmp				;0C497	E992
       db      0E9h,92h

;---------------------------------------
H0000_C499:
	add	bp,ds:[3E80h]		;0C499	032E803E	 . >

;SEG: SP Change - Indefinite
	ror	Word Ptr [si],cl	;0C49D	D30C
	add	[si-0Bh],si		;0C49F	0174F5		 t

;SEG: CS Override
	mov	cs:[0C3Dh],si		;0C4A2	2E89363D0C	. 6=
	mov	si,0C3Dh		;0C4A7	BE3D0C		 =

;SEG: CS Override
	mov	cs:[si-16h],ds		;0C4AA	2E8C5CEA	. \
	push	cs			;0C4AE	0E

;SEG: DS Change - 0000h
	pop	ds			;0C4AF	1F

;SEG: SP Change - Indefinite
	mov	[si-0Ch],ax		;0C4B0	8944F4		 D

;SEG: SP Change - Indefinite
	mov	[si-09h],bx		;0C4B3	895CF7		 \

;SEG: SP Change - Indefinite
	mov	[si-06h],cx		;0C4B6	894CFA		 L

;SEG: SP Change - Indefinite
	mov	[si-03h],dx		;0C4B9	8954FD		 T

;SEG: SP Change - Indefinite
	mov	[si+03h],di		;0C4BC	897C03		 |

;SEG: SP Change - Indefinite
	mov	[si+06h],bp		;0C4BF	896C06		 l
	mov	[si-11h],es		;0C4C2	8C44EF		 D
	cmp	Byte Ptr [si+0Bh],01h	;0C4C5	807C0B01	 |
	jmp	Short H0000_C506	;0C4C9	EB3B		 ;
;- - - - - - - - - - - - - - - - - - - -
	add	al,ah			;0C4CB	02C4
	and	al,0Fh			;0C4CD	240F		$
	add	ah,al			;0C4CF	02E0
	and	ah,0Fh			;0C4D1	80E40F
	push	ax			;0C4D4	50		P
	mov	dx,03DAh		;0C4D5	BADA03

;PORT Input: 3DAh - CGA/EGA Status
	in	al,dx			;0C4D8	EC
	pop	bx			;0C4D9	5B		[
	mov	al,08h			;0C4DA	B008
	mov	ah,bl			;0C4DC	8AE3
	mov	dl,0D4h 		;0C4DE	B2D4

;PORT Output: 3D4h - CGA/EGA Reg Index
	out	dx,ax			;0C4E0	EF
	mov	dl,0C0h 		;0C4E1	B2C0
	mov	al,33h			;0C4E3	B033		 3

;PORT Output: 3C0h - EGA Attrs
	out	dx,al			;0C4E5	EE
	mov	al,bh			;0C4E6	8AC7

;PORT Output: 3C0h - EGA Attrs
	out	dx,al			;0C4E8	EE
	call	H0000_CFC8		;0C4E9	E8DC0A

	push	ax			;0C4EC	50		P
	xor	cx,cx			;0C4ED	33C9		3
	mov	al,0B6h 		;0C4EF	B0B6

;PORT Output: 043h - 8253 SYS Timer Set Mode
	out	43h,al			;0C4F1	E643		 C
	mov	cl,ah			;0C4F3	8ACC
	sal	al,1			;0C4F5	D0E0
	sal	cx,1			;0C4F7	D1E1

;PORT Input: 061h - 8255 PPI-B KBD, SYS Sw, Speaker
	in	al,61h			;0C4F9	E461		 a
	push	ax			;0C4FB	50		P
	or	al,03h			;0C4FC	0C03

;PORT Output: 061h - 8255 PPI-B KBD, SYS Sw, Speaker
	out	61h,al			;0C4FE	E661		 a
H0000_C500:

;MEM: Timing Loop
	loop	H0000_C500		;0C500	E2FE
	pop	ax			;0C502	58		X

;PORT Output: 061h - 8255 PPI-B KBD, SYS Sw, Speaker
	out	61h,al			;0C503	E661		 a
	pop	ax			;0C505	58		X
H0000_C506:
	cmp	ah,57h			;0C506	80FC57		  W
	jz	H0000_C53B		;0C509	7430		t0
	cmp	ah,42h			;0C50B	80FC42		  B
	jz	H0000_C53B		;0C50E	742B		t+
	cmp	ah,3Fh			;0C510	80FC3F		  ?
	jz	H0000_C524		;0C513	740F		t
	cmp	ah,50h			;0C515	80FC50		  P
	jb	H0000_C51F		;0C518	7205		r
	cmp	ah,6Ch			;0C51A	80FC6C		  l
	jb	H0000_C538		;0C51D	7219		r
H0000_C51F:
	cmp	ah,30h			;0C51F	80FC30		  0
	jnz	H0000_C529		;0C522	7505		u
H0000_C524:
	cmp	bl,04h			;0C524	80FB04
	ja	H0000_C53B		;0C527	7712		w
H0000_C529:
	cmp	ah,3Ch			;0C529	80FC3C		  < ja="" h0000_c533="" ;0c52c="" 7705="" w="" cmp="" ah,12h="" ;0c52e="" 80fc12="" ja="" h0000_c538="" ;0c531="" 7705="" w="" h0000_c533:="" cmp="" ah,0eh="" ;0c533="" 80fc0e="" ja="" h0000_c53b="" ;0c536="" 7703="" w="" h0000_c538:="" jmp="" near="" ptr="" h0000_c494="" ;0c538="" e959ff="" y="" ;---------------------------------------="" h0000_c53b:="" xor="" bx,bx="" ;0c53b="" 33db="" 3="" call="" h0000_cee7="" ;0c53d="" e8a709="" ;seg:="" cs="" override="" mov="" cs:[04adh],cl="" ;0c540="" 2e880ead04="" .="" mov="" al,00h="" ;0c545="" b000="" call="" h0000_ccce="" ;0c547="" e88407="" mov="" al,15h="" ;0c54a="" b015="" mov="" di,009eh="" ;0c54c="" bf9e00="" call="" h0000_c831="" ;0c54f="" e8df02="" mov="" di,009ah="" ;0c552="" bf9a00="" call="" h0000_c858="" ;0c555="" e80003="" mov="" al,21h="" ;0c558="" b021="" !="" mov="" di,0092h="" ;0c55a="" bf9200="" call="" h0000_c831="" ;0c55d="" e8d102="" mov="" di,0086h="" ;0c560="" bf8600="" call="" h0000_c858="" ;0c563="" e8f202="" mov="" al,24h="" ;0c566="" b024="" $="" mov="" di,008eh="" ;0c568="" bf8e00="" call="" h0000_c831="" ;0c56b="" e8c302="" mov="" dx,109fh="" ;0c56e="" ba9f10="" push="" cs="" ;0c571="" 0e="" ;seg:="" ds="" change="" -="" 0000h="" pop="" ds="" ;0c572="" 1f="" call="" h0000_c861="" ;0c573="" e8eb02="" call="" h0000_cfc8="" ;0c576="" e84f0a="" o="" cmp="" ah,3fh="" ;0c579="" 80fc3f="" jz="" h0000_c581="" ;0c57c="" 7403="" t="" jmp="" near="" ptr="" h0000_c609="" ;0c57e="" e98800="" ;---------------------------------------="" h0000_c581:="" jcxz="" h0000_c590="" ;0c581="" e30d="" mov="" ax,5700h="" ;0c583="" b80057="" w="" call="" h0000_c863="" ;0c586="" e8da02="" jb="" h0000_c590="" ;0c589="" 7205="" r="" cmp="" dh,0c7h="" ;0c58b="" 80fec7="" ja="" h0000_c593="" ;0c58e="" 7703="" w="" h0000_c590:="" jmp="" near="" ptr="" h0000_c616="" ;0c590="" e98300="" ;---------------------------------------="" h0000_c593:="" call="" h0000_c8ce="" ;0c593="" e83803="" 8="" jb="" h0000_c590="" ;0c596="" 72f8="" r="" call="" h0000_ce52="" ;0c598="" e8b708="" jnz="" h0000_c590="" ;0c59b="" 75f3="" u="" call="" h0000_cfc4="" ;0c59d="" e8240a="" $="" ;seg:="" cs="" override="" mov="" bx,cs:[055dh]="" ;0c5a0="" 2e8b1e5d05="" .="" ]="" ;seg:="" cs="" override="" mov="" dx,cs:[0560h]="" ;0c5a5="" 2e8b166005="" .="" `="" call="" h0000_cec1="" ;0c5aa="" e81409="" ja="" h0000_c5c5="" ;0c5ad="" 7716="" w="" add="" bx,cx="" ;0c5af="" 03d9="" ;asm:="" synonym="" ;a="" adc="" dx,+00h="" ;0c5b1="" 83d200="" db="" 83h,0d2h,00h="" call="" h0000_cec1="" ;0c5b4="" e80a09="" jbe="" h0000_c5c7="" ;0c5b7="" 760e="" v="" ;seg:="" cs="" override="" sub="" bx,cs:[1065h]="" ;0c5b9="" 2e2b1e6510="" .+="" e="" sub="" bx,cx="" ;0c5be="" 2bd9="" +="" neg="" bx="" ;0c5c0="" f7db="" push="" bx="" ;0c5c2="" 53="" s="" jmp="" short="" h0000_c5c8="" ;0c5c3="" eb03="" ;-="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" h0000_c5c5:="" xor="" cx,cx="" ;0c5c5="" 33c9="" 3="" h0000_c5c7:="" push="" cx="" ;0c5c7="" 51="" q="" h0000_c5c8:="" call="" h0000_cfc8="" ;0c5c8="" e8fd09="" pop="" cx="" ;0c5cb="" 59="" y="" call="" h0000_c863="" ;0c5cc="" e89402="" jb="" h0000_c607="" ;0c5cf="" 7236="" r6="" pushf="" ;0c5d1="" 9c="" push="" ax="" ;0c5d2="" 50="" p="" push="" si="" ;0c5d3="" 56="" v="" push="" di="" ;0c5d4="" 57="" w="" push="" ds="" ;0c5d5="" 1e="" push="" es="" ;0c5d6="" 06="" push="" ds="" ;0c5d7="" 1e="" ;seg:="" es="" change="" -="" indefinite="" pop="" es="" ;0c5d8="" 07="" push="" cs="" ;0c5d9="" 0e="" ;seg:="" ds="" change="" -="" 0000h="" pop="" ds="" ;0c5da="" 1f="" mov="" di,055dh="" ;0c5db="" bf5d05="" ]="" ;asm:="" synonym="" ;a="" cmp="" word="" ptr="" [di+03h],+00h="" ;0c5de="" 837d0300="" }="" db="" 83h,7dh,03h,00h="" ja="" h0000_c601="" ;0c5e2="" 771d="" w="" ;asm:="" synonym="" ;a="" cmp="" word="" ptr="" [di],+18h="" ;0c5e4="" 833d18="db" 83h,3dh,18h="" jnb="" h0000_c601="" ;0c5e7="" 7318="" s="" mov="" ax,[di]="" ;0c5e9="" 8b05="" mov="" di,dx="" ;0c5eb="" 8bfa="" mov="" si,ax="" ;0c5ed="" 8bf0="" add="" si,104dh="" ;0c5ef="" 81c64d10="" m="" ;asm:="" synonym="" ;a="" cmp="" cx,+18h="" ;0c5f3="" 83f918="" db="" 83h,0f9h,18h="" jb="" h0000_c5fe="" ;0c5f6="" 7206="" r="" ;asm:="" synonym="" ;a="" sub="" ax,word="" ptr="" 0018h="" ;0c5f8="" 2d1800="" -="" db="" 2dh,18h,00h="" neg="" ax="" ;0c5fb="" f7d8="" xchg="" ax,cx="" ;0c5fd="" 91="" h0000_c5fe:="" cld="" ;0c5fe="" fc="" ;="" ds="0000h" rep="" movsb="" ;0c5ff="" f3a4="" h0000_c601:="" ;seg:="" es="" change="" -="" indefinite="" pop="" es="" ;0c601="" 07="" ;seg:="" ds="" change="" -="" indefinite="" pop="" ds="" ;0c602="" 1f="" pop="" di="" ;0c603="" 5f="" _="" pop="" si="" ;0c604="" 5e="" ^="" pop="" ax="" ;0c605="" 58="" x="" popf="" ;0c606="" 9d="" h0000_c607:="" jmp="" short="" h0000_c637="" ;0c607="" eb2e="" .="" ;-="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" h0000_c609:="" cmp="" ax,4202h="" ;0c609="" 3d0242="B" jnz="" h0000_c63e="" ;0c60c="" 7530="" u0="" mov="" ax,5700h="" ;0c60e="" b80057="" w="" call="" h0000_c863="" ;0c611="" e84f02="" o="" jnb="" h0000_c619="" ;0c614="" 7303="" s="" h0000_c616:="" jmp="" h0000_c81d="" ;0c616="" e90402="" ;---------------------------------------="" h0000_c619:="" cmp="" dh,0c8h="" ;0c619="" 80fec8="" jb="" h0000_c616="" ;0c61c="" 72f8="" r="" call="" h0000_c8ce="" ;0c61e="" e8ad02="" jb="" h0000_c616="" ;0c621="" 72f3="" r="" call="" h0000_ce52="" ;0c623="" e82c08="" ,="" jnz="" h0000_c616="" ;0c626="" 75ee="" u="" call="" h0000_cfc4="" ;0c628="" e89909="" pushf="" ;0c62b="" 9c="" sub="" dx,0fa0h="" ;0c62c="" 81eaa00f="" ;asm:="" synonym="" ;a="" sbb="" cx,+00h="" ;0c630="" 83d900="" db="" 83h,0d9h,00h="" popf="" ;0c633="" 9d="" call="" h0000_c863="" ;0c634="" e82c02="" ,="" h0000_c637:="" ;seg:="" cs="" override="" mov="" cx,cs:[0c37h]="" ;0c637="" 2e8b0e370c="" .="" 7="" jmp="" short="" h0000_c65b="" ;0c63c="" eb1d="" ;-="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" h0000_c63e:="" jmp="" short="" h0000_c65d="" ;0c63e="" eb1d="" ;-="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" cmp="" ah,4ah="" ;0c640="" 80fc4a="" j="" jz="" h0000_c64a="" ;0c643="" 7405="" t="" cmp="" ah,48h="" ;0c645="" 80fc48="" h="" jnz="" h0000_c65d="" ;0c648="" 7513="" u="" h0000_c64a:="" call="" h0000_cfc4="" ;0c64a="" e87709="" w="" call="" h0000_c863="" ;0c64d="" e81302="" jnb="" h0000_c65b="" ;0c650="" 7309="" s="" cmp="" al,08h="" ;0c652="" 3c08="">< jnz="" h0000_c65b="" ;0c654="" 7505="" u="" sub="" bx,010ch="" ;0c656="" 81eb0c01="" stc="" ;0c65a="" f9="" h0000_c65b:="" jmp="" short="" h0000_c69d="" ;0c65b="" eb40="" @="" ;-="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" h0000_c65d:="" ;mem:="" possible="" data="" area="" ;a="" jmp="" short="" h0000_c65f="" ;0c65d="" eb00="" db="" 0ebh,00h="" ;-="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" h0000_c65f:="" cmp="" ah,4eh="" ;0c65f="" 80fc4e="" n="" jb="" h0000_c6a0="" ;0c662="" 723c="">< cmp="" ah,4fh="" ;0c664="" 80fc4f="" o="" ja="" h0000_c6a0="" ;0c667="" 7737="" w7="" call="" h0000_c863="" ;0c669="" e8f701="" pushf="" ;0c66c="" 9c="" push="" ax="" ;0c66d="" 50="" p="" jb="" h0000_c698="" ;0c66e="" 7228="" r(="" call="" h0000_c86a="" ;0c670="" e8f701="" ;seg:="" es="" override="" cmp="" es:[bx+19h],al="" ;0c673="" 26384719="" &8g="" jb="" h0000_c698="" ;0c677="" 721f="" r="" ;seg:="" es="" override="" sub="" es:[bx+19h],al="" ;0c679="" 26284719="" &(g="" mov="" si,001ah="" ;0c67d="" be1a00="" h0000_c680:="" ;seg:="" es="" override="" cmp="" byte="" ptr="" es:[bx+si+02h],00h="" ;0c680="" 2680780200="" &="" x="" jnz="" h0000_c68e="" ;0c685="" 7507="" u="" ;seg:="" es="" override="" cmp="" word="" ptr="" es:[bx+si],2000h="" ;0c687="" 2681380020="" &="" 8="" jb="" h0000_c698="" ;0c68c="" 720a="" r="" h0000_c68e:="" ;seg:="" es="" override="" sub="" word="" ptr="" es:[bx+si],0fa0h="" ;0c68e="" 268128a00f="" &="" (="" ;asm:="" synonym="" ;seg:="" es="" override="" ;a="" sbb="" word="" ptr="" es:[bx+si+02h],+00h="" ;0c693="" 2683580200="" &="" x="" db="" 26h,83h,58h,02h,00h="" h0000_c698:="" call="" h0000_cfc4="" ;0c698="" e82909="" )="" pop="" ax="" ;0c69b="" 58="" x="" h0000_c69c:="" popf="" ;0c69c="" 9d="" h0000_c69d:="" ;asm:="" synonym="" ;a="" retf="" 0002h="" ;0c69d="" ca0200="" db="" 0cah,02h,00h="" ;---------------------------------------="" h0000_c6a0:="" cmp="" ah,11h="" ;0c6a0="" 80fc11="" jb="" h0000_c6ce="" ;0c6a3="" 7229="" r)="" cmp="" ah,12h="" ;0c6a5="" 80fc12="" ja="" h0000_c6ce="" ;0c6a8="" 7724="" w$="" call="" h0000_c863="" ;0c6aa="" e8b601="" pushf="" ;0c6ad="" 9c="" push="" ax="" ;0c6ae="" 50="" p="" cmp="" al,0ffh="" ;0c6af="" 3cff="">< jz="" h0000_c698="" ;0c6b1="" 74e5="" t="" call="" h0000_c86a="" ;0c6b3="" e8b401="" ;seg:="" es="" override="" cmp="" byte="" ptr="" es:[bx],0ffh="" ;0c6b6="" 26803fff="" &="" jnz="" h0000_c6bf="" ;0c6ba="" 7503="" u="" ;asm:="" synonym="" ;a="" add="" bx,+07h="" ;0c6bc="" 83c307="" db="" 83h,0c3h,07h="" h0000_c6bf:="" ;seg:="" es="" override="" cmp="" es:[bx+1ah],al="" ;0c6bf="" 2638471a="" &8g="" jb="" h0000_c698="" ;0c6c3="" 72d3="" r="" ;seg:="" es="" override="" sub="" es:[bx+1ah],al="" ;0c6c5="" 2628471a="" &(g="" mov="" si,001dh="" ;0c6c9="" be1d00="" jmp="" short="" h0000_c680="" ;0c6cc="" ebb2="" ;---------------------------------------="" h0000_c6ce:="" cmp="" ah,6ch="" ;0c6ce="" 80fc6c="" l="" jnz="" h0000_c6d7="" ;0c6d1="" 7504="" u="" mov="" dx,si="" ;0c6d3="" 8bd6="" jmp="" short="" h0000_c6dc="" ;0c6d5="" eb05="" ;-="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" h0000_c6d7:="" cmp="" ah,3dh="" ;0c6d7="" 80fc3d="jnz" h0000_c6ea="" ;0c6da="" 750e="" u="" h0000_c6dc:="" ;seg:="" cs="" override="" inc="" word="" ptr="" cs:[0c47h]="" ;0c6dc="" 2eff06470c="" .="" g="" cmp="" al,02h="" ;0c6e1="" 3c02="">< jnz="" h0000_c6ea="" ;0c6e3="" 7505="" u="" h0000_c6e5:="" call="" h0000_cded="" ;0c6e5="" e80507="" jmp="" short="" h0000_c765="" ;0c6e8="" eb7b="" {="" ;---------------------------------------="" h0000_c6ea:="" cmp="" ah,3eh="" ;0c6ea="" 80fc3e="">
	jnz	H0000_C70A		;0C6ED	751B		u
	call	H0000_C863		;0C6EF	E87101		 q

	pushf				;0C6F2	9C
	push	ax			;0C6F3	50		P
	jb	H0000_C708		;0C6F4	7212		r
	call	H0000_CE88		;0C6F6	E88F07

	cmp	bl,al			;0C6F9	3AD8		:
	jnz	H0000_C708		;0C6FB	750B		u
	call	H0000_CE81		;0C6FD	E88107

	push	cs			;0C700	0E

;SEG: DS Change - 0000h
	pop	ds			;0C701	1F
	mov	dx,0002h		;0C702	BA0200
	call	H0000_C941		;0C705	E83902		 9

H0000_C708:
	jmp	Short H0000_C698	;0C708	EB8E
;---------------------------------------
H0000_C70A:
	cmp	ah,57h			;0C70A	80FC57		  W
	jnz	H0000_C751		;0C70D	7542		uB
	cmp	al,01h			;0C70F	3C01		< jz="" h0000_c727="" ;0c711="" 7414="" t="" call="" h0000_cfc4="" ;0c713="" e8ae08="" call="" h0000_c863="" ;0c716="" e84a01="" j="" pushf="" ;0c719="" 9c="" jb="" h0000_c724="" ;0c71a="" 7208="" r="" cmp="" dh,0c8h="" ;0c71c="" 80fec8="" jb="" h0000_c724="" ;0c71f="" 7203="" r="" sub="" dh,0c8h="" ;0c721="" 80eec8="" h0000_c724:="" jmp="" near="" ptr="" h0000_c69c="" ;0c724="" e975ff="" u="" ;---------------------------------------="" h0000_c727:="" cmp="" dh,0c8h="" ;0c727="" 80fec8="" jb="" h0000_c732="" ;0c72a="" 7206="" r="" ;seg:="" cs="" override="" sub="" byte="" ptr="" cs:[0c3ah],0c8h;0c72c="" 2e802e3a0cc8="" .="" .:="" h0000_c732:="" call="" h0000_c8ce="" ;0c732="" e89901="" jb="" h0000_c765="" ;0c735="" 722e="" r.="" call="" h0000_c904="" ;0c737="" e8ca01="" call="" h0000_c965="" ;0c73a="" e82802="" (="" jb="" h0000_c765="" ;0c73d="" 7226="" r&="" call="" h0000_c8fc="" ;0c73f="" e8ba01="" call="" h0000_cfc4="" ;0c742="" e87f08="" add="" dh,0c8h="" ;0c745="" 80c6c8="" call="" h0000_c863="" ;0c748="" e81801="" pushf="" ;0c74b="" 9c="" sub="" dh,0c8h="" ;0c74c="" 80eec8="" jmp="" short="" h0000_c724="" ;0c74f="" ebd3="" ;---------------------------------------="" h0000_c751:="" call="" h0000_cfeb="" ;0c751="" e89708="" cmp="" ah,4ch="" ;0c754="" 80fc4c="" l="" jnz="" h0000_c767="" ;0c757="" 750e="" u="" ;seg:="" cs="" override="" mov="" byte="" ptr="" cs:[02bch],00h="" ;0c759="" 2ec606bc0200="" .="" ;seg:="" cs="" override="" mov="" byte="" ptr="" cs:[0172h],0fh="" ;0c75f="" 2ec60672010f="" .="" r="" h0000_c765:="" jmp="" short="" h0000_c7be="" ;0c765="" eb57="" w="" ;---------------------------------------="" h0000_c767:="" cmp="" ah,4bh="" ;0c767="" 80fc4b="" k="" jz="" h0000_c76f="" ;0c76a="" 7403="" t="" jmp="" near="" ptr="" h0000_c7fe="" ;0c76c="" e98f00="" ;---------------------------------------="" h0000_c76f:="" call="" h0000_ce81="" ;0c76f="" e80f07="" cmp="" al,00h="" ;0c772="" 3c00="">< jz="" h0000_c779="" ;0c774="" 7403="" t="" jmp="" near="" ptr="" h0000_c6e5="" ;0c776="" e96cff="" l="" ;---------------------------------------="" h0000_c779:="" ;mem:="" possible="" data="" area="" ;a="" jmp="" short="" h0000_c77b="" ;0c779="" eb00="" db="" 0ebh,00h="" ;-="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" -="" h0000_c77b:="" mov="" dx,0fef4h="" ;0c77b="" baf4fe="" call="" h0000_ce90="" ;0c77e="" e80f07="" push="" cs="" ;0c781="" 0e="" ;seg:="" ds="" change="" -="" 0000h="" pop="" ds="" ;0c782="" 1f="" mov="" byte="" ptr="" ds:[03d8h],17h="" ;0c783="" c606d80317="" mov="" byte="" ptr="" ds:[029dh],1dh="" ;0c788="" c6069d021d="" mov="" byte="" ptr="" ds:[02bch],00h="" ;0c78d="" c606bc0200="" call="" h0000_cfc8="" ;0c792="" e83308="" 3="" call="" h0000_cdb9="" ;0c795="" e82106="" !="" jb="" h0000_c7be="" ;0c798="" 7224="" r$="" ;seg:="" cs="" override="" cmp="" byte="" ptr="" cs:[00a2h],03h="" ;0c79a="" 2e803ea20003="" .="">
	jb	H0000_C7BE		;0C7A0	721C		r

;SEG: CS Override
	mov	ax,Word Ptr cs:[00C0h]	;0C7A2	2EA1C000	.
	cmp	ax,4248h		;0C7A6	3D4842		=HB
	jz	H0000_C7B5		;0C7A9	740A		t
	cmp	ax,4C43h		;0C7AB	3D434C		=CL
	jz	H0000_C7B5		;0C7AE	7405		t
	cmp	ax,4353h		;0C7B0	3D5343		=SC
	jnz	H0000_C7C0		;0C7B3	750B		u
H0000_C7B5:
	call	H0000_CFC8		;0C7B5	E81008

	call	H0000_CDED		;0C7B8	E83206		 2

	call	H0000_CE81		;0C7BB	E8C306

H0000_C7BE:
	jmp	Short H0000_C81D	;0C7BE	EB5D		 ]
;---------------------------------------
H0000_C7C0:
	push	cs			;0C7C0	0E

;SEG: ES Change - 0000h
	pop	es			;0C7C1	07
	mov	di,0CB8h		;0C7C2	BFB80C
	mov	cx,0008h		;0C7C5	B90800
	cld				;0C7C8	FC

; cx=0008h es=0000h di=0CB8h
	repne	scasw			;0C7C9	F2AF
	jnz	H0000_C7EA		;0C7CB	751D		u
	cmp	ax,4843h		;0C7CD	3D4348		=CH
	jnz	H0000_C7E1		;0C7D0	750F		u

;SEG: CS Override
	cmp	Word Ptr cs:[00C2h],444Bh
					;0C7D2	2E813EC2004B44	. >  KD
	jnz	H0000_C7E1		;0C7D9	7506		u

;SEG: CS Override
	mov	Byte Ptr cs:[02BCh],6Fh ;0C7DB	2EC606BC026F	.    o
H0000_C7E1:
	call	H0000_CE8D		;0C7E1	E8A906

;SEG: CS Override
	mov	Byte Ptr cs:[03D8h],00h ;0C7E4	2EC606D80300	.
H0000_C7EA:

;SEG: CS Override
	cmp	Word Ptr cs:[00C1h],4A52h
					;0C7EA	2E813EC100524A	. >  RJ
	jnz	H0000_C7F9		;0C7F1	7506		u

;SEG: CS Override
	mov	Byte Ptr cs:[0172h],23h ;0C7F3	2EC606720123	.  r #
H0000_C7F9:
	call	H0000_CFC8		;0C7F9	E8CC07

	jmp	Short H0000_C80D	;0C7FC	EB0F
;- - - - - - - - - - - - - - - - - - - -
H0000_C7FE:
	cmp	ah,43h			;0C7FE	80FC43		  C
	jnz	H0000_C81D		;0C801	751A		u
	or	al,al			;0C803	0AC0
	jnz	H0000_C817		;0C805	7510		u
	cmp	bx,0FACEh		;0C807	81FBCEFA
	jnz	H0000_C81D		;0C80B	7510		u
H0000_C80D:
	call	H0000_C92A		;0C80D	E81A01

	jnz	H0000_C817		;0C810	7505		u
	mov	al,01h			;0C812	B001
	call	H0000_CCCE		;0C814	E8B704

H0000_C817:
	call	H0000_CFC8		;0C817	E8AE07

	call	H0000_C941		;0C81A	E82401		 $

H0000_C81D:
	call	H0000_CFC4		;0C81D	E8A407

;SEG: CS Override
	cmp	cs:[0D09h],ax		;0C820	2E3906090D	.9
	jnz	H0000_C82C		;0C825	7505		u

;SEG: CS Override
	mov	ax,Word Ptr cs:[0C47h]	;0C827	2EA1470C	. G
	iret				;0C82B	CF
;---------------------------------------
H0000_C82C:

;MEM: JMP  DWORD PTR CS:[0086H]

;SEG: CS Override
	jmp	DWord Ptr cs:[0086h]	;0C82C	2EFF2E8600	. .
;---------------------------------------
H0000_C831:
	mov	ah,35h			;0C831	B435		 5
	call	H0000_C863		;0C833	E82D00		 -

;SEG: CS Override
	mov	cs:[di],bx		;0C836	2E891D		.

;SEG: CS Override
	mov	cs:[di+02h],es		;0C839	2E8C4502	. E
	ret				;0C83D	C3
;---------------------------------------
H0000_C83E:
	mov	al,15h			;0C83E	B015
	mov	di,009Eh		;0C840	BF9E00
	call	H0000_C858		;0C843	E81200

	mov	al,21h			;0C846	B021		 !
	mov	di,0092h		;0C848	BF9200
	call	H0000_C858		;0C84B	E80A00

	mov	bl,81h			;0C84E	B381
	call	H0000_CEE7		;0C850	E89406

	mov	al,24h			;0C853	B024		 $
	mov	di,008Eh		;0C855	BF8E00
H0000_C858:

;SEG: CS Override
	mov	dx,cs:[di]		;0C858	2E8B15		.

;SEG: CS Override
	mov	bx,cs:[di+02h]		;0C85B	2E8B5D02	. ]

;SEG: DS Change - Indefinite
	mov	ds,bx			;0C85F	8EDB
H0000_C861:
	mov	ah,25h			;0C861	B425		 %
H0000_C863:
	pushf				;0C863	9C

;MEM: CALL  DWORD PTR CS:[0086H]

; ah=25h al=24h di=008Eh
	call	DWord Ptr cs:[0086h]	;0C864	2EFF1E8600	.

	ret				;0C869	C3
;---------------------------------------
H0000_C86A:
	mov	ax,2FC8h		;0C86A	B8C82F		  /
	jmp	Short H0000_C863	;0C86D	EBF4
;---------------------------------------
H0000_C86F:
	mov	ah,43h			;0C86F	B443		 C
	jmp	Short H0000_C863	;0C871	EBF0
;---------------------------------------
H0000_C873:
	mov	ah,57h			;0C873	B457		 W
	jmp	Short H0000_C88A	;0C875	EB13
;- - - - - - - - - - - - - - - - - - - -
H0000_C877:
	mov	cx,0FFFFh		;0C877	B9FFFF
	mov	dx,0FFE0h		;0C87A	BAE0FF
	mov	al,02h			;0C87D	B002
	call	H0000_C90A		;0C87F	E88800

H0000_C882:
	mov	ah,3Fh			;0C882	B43F		 ?
	mov	cx,0020h		;0C884	B92000
H0000_C887:
	mov	dx,104Dh		;0C887	BA4D10		 M
H0000_C88A:
	mov	bx,0005h		;0C88A	BB0500
	jmp	Short H0000_C863	;0C88D	EBD4
;---------------------------------------
H0000_C88F:
	mov	cx,0018h		;0C88F	B91800
H0000_C892:
	mov	ah,40h			;0C892	B440		 @
	jmp	Short H0000_C887	;0C894	EBF1
;---------------------------------------
H0000_C896:
	mov	bp,dx			;0C896	8BEA
	mov	al,00h			;0C898	B000
	call	H0000_C86F		;0C89A	E8D2FF

	jb	H0000_C8CD		;0C89D	722E		r.

;SEG: CS Override
	mov	cs:[0581h],cx		;0C89F	2E890E8105	.
	test	cl,03h			;0C8A4	F6C103
	jz	H0000_C8B2		;0C8A7	7409		t
	mov	al,01h			;0C8A9	B001
	xor	cx,cx			;0C8AB	33C9		3
	call	H0000_C86F		;0C8AD	E8BFFF

	jb	H0000_C8CD		;0C8B0	721B		r
H0000_C8B2:
	mov	ax,3D92h		;0C8B2	B8923D		  =
	call	H0000_C863		;0C8B5	E8ABFF

	jb	H0000_C8CD		;0C8B8	7213		r

;SEG: CS Override
	mov	Word Ptr cs:[04E9h],ax	;0C8BA	2EA3E904	.
	mov	al,00h			;0C8BE	B000
	call	H0000_C873		;0C8C0	E8B0FF

;SEG: CS Override
	mov	cs:[0570h],dx		;0C8C3	2E89167005	.  p

;SEG: CS Override
	mov	cs:[0573h],cx		;0C8C8	2E890E7305	.  s
H0000_C8CD:
	ret				;0C8CD	C3
;---------------------------------------
H0000_C8CE:

;SEG: CS Override
	mov	cs:[04E9h],bx		;0C8CE	2E891EE904	.
H0000_C8D3:
	mov	al,01h			;0C8D3	B001
	call	H0000_C906		;0C8D5	E82E00		 .

	jb	H0000_C8FA		;0C8D8	7220		r
	push	ax			;0C8DA	50		P
	push	dx			;0C8DB	52		R
	push	ds			;0C8DC	1E
	push	cs			;0C8DD	0E

;SEG: DS Change - 0000h
	pop	ds			;0C8DE	1F
	mov	Word Ptr ds:[055Dh],ax	;0C8DF	A35D05		 ]
	mov	ds:[0560h],dx		;0C8E2	89166005	  `
	call	H0000_C877		;0C8E6	E88EFF

;SEG: DS Change - Indefinite
	pop	ds			;0C8E9	1F
	pop	cx			;0C8EA	59		Y
	pop	dx			;0C8EB	5A		Z
	jb	H0000_C8F7		;0C8EC	7209		r

;ASM: Synonym
;A	cmp	ax,Word Ptr 0020h	;0C8EE	3D2000		=
       db      3Dh,20h,00h

	jnz	H0000_C8F7		;0C8F1	7504		u
H0000_C8F3:
	mov	al,00h			;0C8F3	B000
	jmp	Short H0000_C90A	;0C8F5	EB13
;- - - - - - - - - - - - - - - - - - - -
H0000_C8F7:
	call	H0000_C8F3		;0C8F7	E8F9FF

H0000_C8FA:
	stc				;0C8FA	F9
	ret				;0C8FB	C3
;---------------------------------------
H0000_C8FC:
	mov	al,00h			;0C8FC	B000
	mov	dx,0000h		;0C8FE	BA0000
	mov	cx,0000h		;0C901	B90000
H0000_C904:
	xor	ax,ax			;0C904	33C0		3
H0000_C906:
	xor	cx,cx			;0C906	33C9		3
	mov	dx,cx			;0C908	8BD1
H0000_C90A:
	mov	ah,42h			;0C90A	B442		 B
	jmp	Near Ptr H0000_C88A	;0C90C	E97BFF		 {
;---------------------------------------
H0000_C90F:
	mov	al,01h			;0C90F	B001
	mov	dx,0DEAFh		;0C911	BAAFDE
	mov	cx,2800h		;0C914	B90028		  (
	call	H0000_C873		;0C917	E859FF		 Y

	mov	ah,3Eh			;0C91A	B43E		 >
	call	H0000_C88A		;0C91C	E86BFF		 k

	call	H0000_CFC8		;0C91F	E8A606

	mov	cx,0020h		;0C922	B92000
	mov	al,01h			;0C925	B001
	jmp	Near Ptr H0000_C86F	;0C927	E945FF		 E
;---------------------------------------
H0000_C92A:
	mov	di,dx			;0C92A	8BFA
	mov	cx,0050h		;0C92C	B95000		 P
	mov	al,2Eh			;0C92F	B02E		 .
	push	ds			;0C931	1E

;SEG: ES Change - Indefinite
	pop	es			;0C932	07
	cld				;0C933	FC

; al=2Eh cx=0050h
	repne	scasb			;0C934	F2AE
	jnz	H0000_C940		;0C936	7508		u
	mov	ax,[di] 		;0C938	8B05
	or	ax,6060h		;0C93A	0D6060		 ``
	cmp	ax,6F63h		;0C93D	3D636F		=co
H0000_C940:
	ret				;0C940	C3
;---------------------------------------
H0000_C941:
	call	H0000_CECE		;0C941	E88A05

	jz	H0000_C963		;0C944	741D		t
	call	H0000_C896		;0C946	E84DFF		 M

	jnb	H0000_C950		;0C949	7305		s
	cmp	al,03h			;0C94B	3C03		< ja="" h0000_c95b="" ;0c94d="" 770c="" w="" ret="" ;0c94f="" c3="" ;---------------------------------------="" h0000_c950:="" call="" h0000_ccb4="" ;0c950="" e86103="" a="" jnb="" h0000_c95b="" ;0c953="" 7306="" s="" call="" h0000_ccc0="" ;0c955="" e86803="" h="" call="" h0000_c965="" ;0c958="" e80a00="" h0000_c95b:="" jmp="" short="" h0000_c90f="" ;0c95b="" ebb2="" ;---------------------------------------="" h0000_c95d:="" ;seg:="" cs="" override="" sub="" byte="" ptr="" cs:[0571h],0c8h;0c95d="" 2e802e7105c8="" .="" .q="" h0000_c963:="" stc="" ;0c963="" f9="" ret="" ;0c964="" c3="" ;---------------------------------------="" h0000_c965:="" call="" h0000_ce52="" ;0c965="" e8ea04="" jz="" h0000_c963="" ;0c968="" 74f9="" t="" push="" cs="" ;0c96a="" 0e="" ;seg:="" ds="" change="" -="" 0000h="" pop="" ds="" ;0c96b="" 1f="" call="" h0000_c882="" ;0c96c="" e813ff="" jb="" h0000_c95d="" ;0c96f="" 72ec="" r="" mov="" si,104dh="" ;0c971="" be4d10="" m="" call="" h0000_ccc7="" ;0c974="" e85003="" p="" jnz="" h0000_c983="" ;0c977="" 750a="" u="" cmp="" byte="" ptr="" [si],0e9h="" ;0c979="" 803ce9="">< jz="" h0000_c98f="" ;0c97c="" 7411="" t="" mov="" al,00h="" ;0c97e="" b000="" call="" h0000_ccce="" ;0c980="" e84b03="" k="" h0000_c983:="" cmp="" word="" ptr="" [si],5a4dh="" ;0c983="" 813c4d5a=""><mz jnz="" h0000_c95d="" ;0c987="" 75d4="" u="" ;asm:="" synonym="" ;a="" cmp="" word="" ptr="" [si+18h],+40h="" ;0c989="" 837c1840="" |="" @="" db="" 83h,7ch,18h,40h="" jz="" h0000_c95d="" ;0c98d="" 74ce="" t="" h0000_c98f:="" mov="" ax,[si+10h]="" ;0c98f="" 8b4410="" d="" cmp="" ax,02f0h="" ;0c992="" 3df002="jz" h0000_c95d="" ;0c995="" 74c6="" t="" cmp="" ax,0510h="" ;0c997="" 3d1005="jb" h0000_c9a1="" ;0c99a="" 7205="" r="" cmp="" ax,0522h="" ;0c99c="" 3d2205="
	jb	H0000_C95D		;0C99F	72BC		r
H0000_C9A1:
	call	H0000_CCC7		;0C9A1	E82303		 #

;MEM: Possible Data Area
;A	jnz	H0000_C9A6		;0C9A4	7500		u
       db      75h,00h

H0000_C9A6:
	mov	Word Ptr ds:[0FD3h],ax	;0C9A6	A3D30F
	mov	ax,[si+14h]		;0C9A9	8B4414		 D
	call	H0000_CCC7		;0C9AC	E81803

	jnz	H0000_C9BA		;0C9AF	7509		u
	mov	ax,[si+01h]		;0C9B1	8B4401		 D
	mov	Word Ptr ds:[0FC5h],ax	;0C9B4	A3C50F
	mov	ax,0100h		;0C9B7	B80001
H0000_C9BA:
	mov	Word Ptr ds:[0FDDh],ax	;0C9BA	A3DD0F
	call	H0000_CCC7		;0C9BD	E80703

	jz	H0000_C9D8		;0C9C0	7416		t
	mov	ax,[si+04h]		;0C9C2	8B4404		 D

;ASM: Synonym
;A	cmp	ax,Word Ptr 0010h	;0C9C5	3D1000		=
       db      3Dh,10h,00h

	jb	H0000_C95D		;0C9C8	7293		r
	dec	ax			;0C9CA	48		H
	mov	dx,0200h		;0C9CB	BA0002
	mul	dx			;0C9CE	F7E2
	add	ax,[si+02h]		;0C9D0	034402		 D

;ASM: Synonym
;A	adc	dx,+00h 		;0C9D3	83D200
       db      83h,0D2h,00h

	push	ax			;0C9D6	50		P
	push	dx			;0C9D7	52		R
H0000_C9D8:
	mov	al,02h			;0C9D8	B002
	call	H0000_C906		;0C9DA	E829FF		 )

;SEG: SP Change - Indefinite
	mov	[si+18h],ax		;0C9DD	894418		 D

;SEG: SP Change - Indefinite
	mov	[si+1Ah],dx		;0C9E0	89541A		 T
	call	H0000_CCC7		;0C9E3	E8E102

	jnz	H0000_CA00		;0C9E6	7518		u
	or	dx,dx			;0C9E8	0BD2
	jnz	H0000_C9FD		;0C9EA	7511		u
	cmp	ah,0D6h 		;0C9EC	80FCD6
	ja	H0000_C9FD		;0C9EF	770C		w
	cmp	ah,20h			;0C9F1	80FC20
	jb	H0000_C9FD		;0C9F4	7207		r
	mov	di,ax			;0C9F6	8BF8

;ASM: Synonym
;A	sub	di,+03h 		;0C9F8	83EF03
       db      83h,0EFh,03h

	jmp	Short H0000_CA14	;0C9FB	EB17
;- - - - - - - - - - - - - - - - - - - -
H0000_C9FD:
	jmp	Near Ptr H0000_C95D	;0C9FD	E95DFF		 ]
;---------------------------------------
H0000_CA00:
	pop	bp			;0CA00	5D		]
	pop	di			;0CA01	5F		_
	cmp	ax,di			;0CA02	3BC7		;
	jnz	H0000_C9FD		;0CA04	75F7		u
	cmp	dx,bp			;0CA06	3BD5		;
	jnz	H0000_C9FD		;0CA08	75F3		u

;ASM: Synonym
;A	cmp	dx,+0Fh 		;0CA0A	83FA0F
       db      83h,0FAh,0Fh

	ja	H0000_C9FD		;0CA0D	77EE		w
	mov	di,ax			;0CA0F	8BF8

;MEM: Possible Data - Invalid Code
;A	and	di,+0Fh 		;0CA11	83E70F
       db      83h,0E7h,0Fh

H0000_CA14:
	mov	ds:[0895h],di		;0CA14	893E9508	 >
	push	di			;0CA18	57		W
	mov	cl,04h			;0CA19	B104
	shr	ax,cl			;0CA1B	D3E8
	ror	dx,cl			;0CA1D	D3CA
	add	ax,dx			;0CA1F	03C2
	sub	ax,[si+08h]		;0CA21	2B4408		+D
	push	ax			;0CA24	50		P
	push	ax			;0CA25	50		P
	push	ax			;0CA26	50		P
	add	ax,di			;0CA27	03C7
	push	ax			;0CA29	50		P
	mov	ah,2Ah			;0CA2A	B42A		 *
	call	H0000_C863		;0CA2C	E834FE		 4

	add	dh,03h			;0CA2F	80C603
	cmp	dh,0Dh			;0CA32	80FE0D
	jb	H0000_CA3B		;0CA35	7204		r
	sub	dh,0Ch			;0CA37	80EE0C
	inc	cx			;0CA3A	41		A
H0000_CA3B:
	mov	ds:[0CEEh],cx		;0CA3B	890EEE0C
	mov	ds:[0CE8h],dx		;0CA3F	8916E80C
	mov	ah,2Ch			;0CA43	B42C		 ,
	call	H0000_C863		;0CA45	E81BFE

	pop	ax			;0CA48	58		X
	add	ax,cx			;0CA49	03C1
	add	ax,dx			;0CA4B	03C2
	neg	ax			;0CA4D	F7D8
	mov	Word Ptr [si+1Ch],0DEADh;0CA4F	C7441CADDE	 D

;SEG: SP Change - Indefinite
	mov	[si+1Eh],ax		;0CA54	89441E		 D
	xor	ax,0DEAFh		;0CA57	35AFDE		5
	mov	Word Ptr ds:[07E6h],ax	;0CA5A	A3E607
	mov	Word Ptr ds:[1098h],ax	;0CA5D	A39810
	call	H0000_CCD3		;0CA60	E87002		 p

	mov	Word Ptr ds:[08EEh],ax	;0CA63	A3EE08
	mov	ds:[08DFh],bx		;0CA66	891EDF08
	pop	ax			;0CA6A	58		X
	sub	ax,bx			;0CA6B	2BC3		+
	sub	ax,[si+16h]		;0CA6D	2B4416		+D
	mov	Word Ptr ds:[0FD9h],ax	;0CA70	A3D90F
	pop	ax			;0CA73	58		X
	sub	ax,bx			;0CA74	2BC3		+
	sub	ax,[si+0Eh]		;0CA76	2B440E		+D
	mov	Word Ptr ds:[0FCEh],ax	;0CA79	A3CE0F
	sal	bx,1			;0CA7C	D1E3
	mov	ds:[0883h],bx		;0CA7E	891E8308
	cld				;0CA82	FC
	push	si			;0CA83	56		V
	push	cs			;0CA84	0E

;SEG: ES Change - 0000h
	pop	es			;0CA85	07
	mov	si,1014h		;0CA86	BE1410
	mov	di,si			;0CA89	8BFE
	push	si			;0CA8B	56		V
	lodsw				;0CA8C	AD
	xchg	ax,bx			;0CA8D	93
	lodsw				;0CA8E	AD
	xchg	al,ah			;0CA8F	86C4
	xchg	bl,bh			;0CA91	86DF
	xchg	ah,bl			;0CA93	86E3
	xchg	ax,bx			;0CA95	93
	stosw				;0CA96	AB
	xchg	ax,bx			;0CA97	93
	stosw				;0CA98	AB
	mov	ah,2Ch			;0CA99	B42C		 ,
	call	H0000_C863		;0CA9B	E8C5FD

	mov	bp,cx			;0CA9E	8BE9
	add	bp,dx			;0CAA0	03EA
	mov	bx,cx			;0CAA2	8BD9
	mov	cl,04h			;0CAA4	B104
	sal	bl,cl			;0CAA6	D2E3
	and	dh,0Fh			;0CAA8	80E60F
	or	dh,bl			;0CAAB	0AF3
	mov	dl,bh			;0CAAD	8AD7
	sal	dl,cl			;0CAAF	D2E2
	push	dx			;0CAB1	52		R
	mov	ah,2Ah			;0CAB2	B42A		 *
	call	H0000_C863		;0CAB4	E8ACFD

	add	bp,dx			;0CAB7	03EA
	neg	bp			;0CAB9	F7DD
	mov	cx,dx			;0CABB	8BCA
	pop	dx			;0CABD	5A		Z
	or	dl,al			;0CABE	0AD0
	mov	di,00CDh		;0CAC0	BFCD00
	mov	ax,bp			;0CAC3	8BC5
	call	H0000_CCD3		;0CAC5	E80B02

	mov	Word Ptr ds:[08F5h],ax	;0CAC8	A3F508
	mov	Word Ptr ds:[08A5h],ax	;0CACB	A3A508
	mov	ds:[08E6h],bx		;0CACE	891EE608
	mov	bx,ds:[0C47h]		;0CAD2	8B1E470C	  G
	pop	si			;0CAD6	5E		^
	test	dl,01h			;0CAD7	F6C201
	jz	H0000_CAE9		;0CADA	740D		t
	mov	al,26h			;0CADC	B026		 &
	test	ch,02h			;0CADE	F6C502
	jz	H0000_CAE8		;0CAE1	7405		t
	mov	al,06h			;0CAE3	B006
	stosb				;0CAE5	AA
	mov	al,1Fh			;0CAE6	B01F
H0000_CAE8:
	stosb				;0CAE8	AA
H0000_CAE9:
	lodsb				;0CAE9	AC
	call	H0000_CCDD		;0CAEA	E8F001

	lodsb				;0CAED	AC
	call	H0000_CCDD		;0CAEE	E8EC01

	lodsb				;0CAF1	AC
	call	H0000_CCDD		;0CAF2	E8E801

	lodsb				;0CAF5	AC
	call	H0000_CCDD		;0CAF6	E8E401

	test	dl,01h			;0CAF9	F6C201
	jnz	H0000_CB12		;0CAFC	7514		u
	test	bl,15h			;0CAFE	F6C315
	jnz	H0000_CB09		;0CB01	7506		u
	mov	ax,071Eh		;0CB03	B81E07
	stosw				;0CB06	AB
	jmp	Short H0000_CB12	;0CB07	EB09
;- - - - - - - - - - - - - - - - - - - -
H0000_CB09:
	mov	al,0F2h 		;0CB09	B0F2
	test	ch,01h			;0CB0B	F6C501
	jz	H0000_CB11		;0CB0E	7401		t
	inc	ax			;0CB10	40		@
H0000_CB11:
	stosb				;0CB11	AA
H0000_CB12:
	push	di			;0CB12	57		W

;ASM: Synonym
;A	sub	si,+04h 		;0CB13	83EE04
       db      83h,0EEh,04h

	call	H0000_CCC7		;0CB16	E8AE01

	jz	H0000_CB1E		;0CB19	7403		t
	mov	al,36h			;0CB1B	B036		 6
	stosb				;0CB1D	AA
H0000_CB1E:
	mov	al,31h			;0CB1E	B031		 1
	mov	Byte Ptr ds:[1095h],al	;0CB20	A29510
	test	dh,40h			;0CB23	F6C640		  @
	jz	H0000_CB2F		;0CB26	7407		t
	mov	Byte Ptr ds:[1095h],01h ;0CB28	C606951001
	mov	al,29h			;0CB2D	B029		 )
H0000_CB2F:
	mov	Byte Ptr ds:[1081h],al	;0CB2F	A28110
	stosb				;0CB32	AA
	mov	al,1Ch			;0CB33	B01C
	test	dh,02h			;0CB35	F6C602
	jz	H0000_CB3C		;0CB38	7402		t
	inc	al			;0CB3A	FEC0
H0000_CB3C:
	test	cl,03h			;0CB3C	F6C103
	jz	H0000_CB43		;0CB3F	7402		t
	sub	al,08h			;0CB41	2C08		,
H0000_CB43:
	stosb				;0CB43	AA
	call	H0000_CD96		;0CB44	E84F02		 O

	test	bl,01h			;0CB47	F6C301
	jz	H0000_CB4F		;0CB4A	7403		t
	call	H0000_CD87		;0CB4C	E83802		 8

H0000_CB4F:
	mov	Byte Ptr ds:[1097h],05h ;0CB4F	C606971005
	cmp	ch,0Ah			;0CB54	80FD0A
	jb	H0000_CB6F		;0CB57	7216		r
	test	cl,03h			;0CB59	F6C103
	jnz	H0000_CB6F		;0CB5C	7511		u
	mov	ax,5F8Dh		;0CB5E	B88D5F		  _
	stosw				;0CB61	AB
	xor	ax,ax			;0CB62	33C0		3
	mov	al,bl			;0CB64	8AC3
	or	al,40h			;0CB66	0C40		 @
	cbw				;0CB68	98
	mov	Word Ptr ds:[1098h],ax	;0CB69	A39810
	stosb				;0CB6C	AA
	jmp	Short H0000_CB8B	;0CB6D	EB1C
;- - - - - - - - - - - - - - - - - - - -
H0000_CB6F:
	mov	al,81h			;0CB6F	B081
	stosb				;0CB71	AA
	mov	al,0C3h 		;0CB72	B0C3
	test	cl,03h			;0CB74	F6C103
	jz	H0000_CB7A		;0CB77	7401		t
	dec	ax			;0CB79	48		H
H0000_CB7A:
	test	dl,02h			;0CB7A	F6C202
	jz	H0000_CB86		;0CB7D	7407		t
	add	al,30h			;0CB7F	0430		 0
	mov	Byte Ptr ds:[1097h],35h ;0CB81	C606971035	    5
H0000_CB86:
	stosb				;0CB86	AA
	mov	ax,0F6F5h		;0CB87	B8F5F6
	stosw				;0CB8A	AB
H0000_CB8B:
	test	bl,01h			;0CB8B	F6C301
	jnz	H0000_CB93		;0CB8E	7503		u
	call	H0000_CD87		;0CB90	E8F401

H0000_CB93:
	test	dh,03h			;0CB93	F6C603
	jz	H0000_CBAC		;0CB96	7414		t
	call	H0000_CD96		;0CB98	E8FB01

	mov	al,83h			;0CB9B	B083
	stosb				;0CB9D	AA
	mov	al,0EEh 		;0CB9E	B0EE
	test	dh,02h			;0CBA0	F6C602
	jz	H0000_CBA6		;0CBA3	7401		t
	inc	ax			;0CBA5	40		@
H0000_CBA6:
	stosb				;0CBA6	AA
	mov	al,0FEh 		;0CBA7	B0FE
	stosb				;0CBA9	AA
	jmp	Short H0000_CBBB	;0CBAA	EB0F
;- - - - - - - - - - - - - - - - - - - -
H0000_CBAC:
	mov	al,46h			;0CBAC	B046		 F
	test	dh,02h			;0CBAE	F6C602
	jz	H0000_CBB4		;0CBB1	7401		t
	inc	ax			;0CBB3	40		@
H0000_CBB4:
	stosb				;0CBB4	AA
	push	ax			;0CBB5	50		P
	call	H0000_CD96		;0CBB6	E8DD01

	pop	ax			;0CBB9	58		X
	stosb				;0CBBA	AA
H0000_CBBB:
	call	H0000_CD96		;0CBBB	E8D801

	test	bl,03h			;0CBBE	F6C303
	jnz	H0000_CBD1		;0CBC1	750E		u
	test	dl,10h			;0CBC3	F6C210
	jnz	H0000_CBD1		;0CBC6	7509		u
	cmp	ch,03h			;0CBC8	80FD03
	ja	H0000_CBD1		;0CBCB	7704		w
	mov	al,0E2h 		;0CBCD	B0E2
	jmp	Short H0000_CBFB	;0CBCF	EB2A		 *
;- - - - - - - - - - - - - - - - - - - -
H0000_CBD1:
	mov	al,49h			;0CBD1	B049		 I
	test	dl,10h			;0CBD3	F6C210
	jz	H0000_CBDA		;0CBD6	7402		t
	add	al,04h			;0CBD8	0404
H0000_CBDA:
	test	bl,03h			;0CBDA	F6C303
	jz	H0000_CBE1		;0CBDD	7402		t
	sub	al,08h			;0CBDF	2C08		,
H0000_CBE1:
	stosb				;0CBE1	AA
	call	H0000_CD96		;0CBE2	E8B101

	cmp	ch,0Ah			;0CBE5	80FD0A
	jb	H0000_CBEF		;0CBE8	7205		r
	test	cl,03h			;0CBEA	F6C103
	jz	H0000_CBFD		;0CBED	740E		t
H0000_CBEF:
	test	dh,03h			;0CBEF	F6C603
	jnz	H0000_CBFD		;0CBF2	7509		u
	test	dl,02h			;0CBF4	F6C202
	jz	H0000_CBFD		;0CBF7	7404		t
	mov	al,77h			;0CBF9	B077		 w
H0000_CBFB:
	jmp	Short H0000_CBFF	;0CBFB	EB02
;- - - - - - - - - - - - - - - - - - - -
H0000_CBFD:
	mov	al,75h			;0CBFD	B075		 u
H0000_CBFF:
	stosb				;0CBFF	AA
	pop	ax			;0CC00	58		X
	dec	ax			;0CC01	48		H
	sub	ax,di			;0CC02	2BC7		+
	stosb				;0CC04	AA

;ASM: Synonym
;A	test	di,Word Ptr 0001h	;0CC05	F7C70100
       db      0F7h,0C7h,01h,00h

	jnz	H0000_CC17		;0CC09	750C		u
	mov	al,bl			;0CC0B	8AC3
	and	al,07h			;0CC0D	2407		$
	or	al,90h			;0CC0F	0C90
	cmp	al,94h			;0CC11	3C94		<
	jnz	H0000_CC16		;0CC13	7501		u
	inc	ax			;0CC15	40		@
H0000_CC16:
	stosb				;0CC16	AA
H0000_CC17:
	mov	ax,00EDh		;0CC17	B8ED00
	sub	ax,di			;0CC1A	2BC7		+
	shr	ax,1			;0CC1C	D1E8
	add	ax,07B0h		;0CC1E	05B007
	mov	Word Ptr ds:[1093h],ax	;0CC21	A39310
	add	ax,00DEh		;0CC24	05DE00
	test	bl,03h			;0CC27	F6C303
	jz	H0000_CC2E		;0CC2A	7402		t
	neg	ax			;0CC2C	F7D8
H0000_CC2E:
	mov	Word Ptr ds:[00D6h],ax	;0CC2E	A3D600
	mov	ax,di			;0CC31	8BC7
	mov	Word Ptr ds:[1090h],ax	;0CC33	A39010
	add	ax,0C36Ch		;0CC36	056CC3		 l
	sub	ax,00CDh		;0CC39	2DCD00		-
	call	H0000_CCC7		;0CC3C	E88800

	jnz	H0000_CC46		;0CC3F	7505		u
	add	ax,0103h		;0CC41	050301
	jmp	Short H0000_CC49	;0CC44	EB03
;- - - - - - - - - - - - - - - - - - - -
H0000_CC46:
	add	ax,04F0h		;0CC46	05F004
H0000_CC49:
	mov	Word Ptr ds:[00CEh],ax	;0CC49	A3CE00
	mov	al,0E9h 		;0CC4C	B0E9
	stosb				;0CC4E	AA
	mov	ax,0CD5h		;0CC4F	B8D50C
	sub	ax,di			;0CC52	2BC7		+
	stosw				;0CC54	AB
	pop	si			;0CC55	5E		^
	call	H0000_CE69		;0CC56	E81002

	mov	al,02h			;0CC59	B002
	call	H0000_C906		;0CC5B	E8A8FC

;EXTRN	 H0000_D40F:Near

;MEM: Branch out of Program
;A	call	H0000_D40F		;0CC5E	E8AE07
       db      0E8h,0AEh,07h

	jnb	H0000_CC68		;0CC61	7305		s
H0000_CC63:
	pop	ax			;0CC63	58		X
	pop	ax			;0CC64	58		X
	jmp	H0000_C95D		;0CC65	E9F5FC
;---------------------------------------
H0000_CC68:
	cmp	ax,cx			;0CC68	3BC1		;
	jnz	H0000_CC63		;0CC6A	75F7		u
	call	H0000_C904		;0CC6C	E895FC

	call	H0000_CE69		;0CC6F	E8F701

	call	H0000_CCC7		;0CC72	E85200		 R

	jnz	H0000_CC7E		;0CC75	7507		u
	pop	ax			;0CC77	58		X
	pop	ax			;0CC78	58		X

;SEG: SP Change - Indefinite
	mov	[si+01h],ax		;0CC79	894401		 D
	jmp	Short H0000_CCB1	;0CC7C	EB33		 3
;- - - - - - - - - - - - - - - - - - - -
H0000_CC7E:
	pop	ax			;0CC7E	58		X
	push	ax			;0CC7F	50		P

;ASM: Synonym
;A	sub	ax,Word Ptr 006Fh	;0CC80	2D6F00		-o
       db      2Dh,6Fh,00h

;SEG: SP Change - Indefinite
	mov	[si+16h],ax		;0CC83	894416		 D
	pop	ax			;0CC86	58		X

;ASM: Synonym
;A	sub	ax,Word Ptr 004Fh	;0CC87	2D4F00		-O
       db      2Dh,4Fh,00h

;SEG: SP Change - Indefinite
	mov	[si+0Eh],ax		;0CC8A	89440E		 D
	pop	ax			;0CC8D	58		X
	push	ax			;0CC8E	50		P
	add	ax,06F0h		;0CC8F	05F006

;SEG: SP Change - Indefinite
	mov	[si+14h],ax		;0CC92	894414		 D
	pop	ax			;0CC95	58		X
	add	ax,04F0h		;0CC96	05F004
	add	ax,1080h		;0CC99	058010

;SEG: SP Change - Indefinite
	mov	[si+10h],ax		;0CC9C	894410		 D
	mov	ax,[si+02h]		;0CC9F	8B4402		 D
	add	ax,0FA0h		;0CCA2	05A00F
	cwd				;0CCA5	99
	mov	bx,0200h		;0CCA6	BB0002
	div	bx			;0CCA9	F7F3
	add	[si+04h],ax		;0CCAB	014404		 D

;SEG: SP Change - Indefinite
	mov	[si+02h],dx		;0CCAE	895402		 T
H0000_CCB1:
	jmp	H0000_C88F		;0CCB1	E9DBFB
;---------------------------------------
H0000_CCB4:
	call	H0000_C8D3		;0CCB4	E81CFC

H0000_CCB7:

;SEG: CS Override
	mov	al,Byte Ptr cs:[0571h]	;0CCB7	2EA07105	. q
	mov	ah,0C8h 		;0CCBB	B4C8
	cmp	al,ah			;0CCBD	3AC4		:
	ret				;0CCBF	C3
;---------------------------------------
H0000_CCC0:
	add	al,ah			;0CCC0	02C4

;SEG: CS Override
	mov	Byte Ptr cs:[0571h],al	;0CCC2	2EA27105	. q
	ret				;0CCC6	C3
;---------------------------------------
H0000_CCC7:

;SEG: CS Override
	cmp	Byte Ptr cs:[0FBCh],01h ;0CCC7	2E803EBC0F01	. >
	ret				;0CCCD	C3
;---------------------------------------
H0000_CCCE:

;SEG: CS Override
	mov	Byte Ptr cs:[0FBCh],al	;0CCCE	2EA2BC0F	.
	ret				;0CCD2	C3
;---------------------------------------
H0000_CCD3:
	mov	cl,04h			;0CCD3	B104
	and	ax,0FF0h		;0CCD5	25F00F		%
	mov	bx,ax			;0CCD8	8BD8
	shr	bx,cl			;0CCDA	D3EB
	ret				;0CCDC	C3
;---------------------------------------
H0000_CCDD:
	push	ax			;0CCDD	50		P
	mov	ah,bl			;0CCDE	8AE3
	and	ah,03h			;0CCE0	80E403
	cmp	al,ah			;0CCE3	3AC4		:
	jnz	H0000_CD03		;0CCE5	751C		u
	test	dl,01h			;0CCE7	F6C201
	jz	H0000_CCF0		;0CCEA	7404		t
	mov	al,85h			;0CCEC	B085
	jmp	Short H0000_CCF9	;0CCEE	EB09
;- - - - - - - - - - - - - - - - - - - -
H0000_CCF0:
	mov	al,23h			;0CCF0	B023		 #
	test	cl,02h			;0CCF2	F6C102
	jz	H0000_CCF9		;0CCF5	7402		t
	mov	al,0Bh			;0CCF7	B00B
H0000_CCF9:
	mov	ah,0C0h 		;0CCF9	B4C0
	stosb				;0CCFB	AA
	mov	al,bl			;0CCFC	8AC3
	and	al,07h			;0CCFE	2407		$
	add	al,ah			;0CD00	02C4
	stosb				;0CD02	AA
H0000_CD03:
	pop	ax			;0CD03	58		X
	cmp	al,03h			;0CD04	3C03		<
	jz	H0000_CD86		;0CD06	747E		t~
	cmp	al,02h			;0CD08	3C02		<
	jz	H0000_CD5F		;0CD0A	7453		tS
	cmp	al,01h			;0CD0C	3C01		<
	jz	H0000_CD38		;0CD0E	7428		t(
	call	H0000_CCC7		;0CD10	E8B4FF

	jz	H0000_CD28		;0CD13	7413		t
	cmp	bl,06h			;0CD15	80FB06
	ja	H0000_CD28		;0CD18	770E		w
	mov	al,8Dh			;0CD1A	B08D
	stosb				;0CD1C	AA
	mov	al,1Eh			;0CD1D	B01E
	test	cl,03h			;0CD1F	F6C103
	jz	H0000_CD30		;0CD22	740C		t
	mov	al,16h			;0CD24	B016
	jmp	Short H0000_CD30	;0CD26	EB08
;- - - - - - - - - - - - - - - - - - - -
H0000_CD28:
	mov	al,0BBh 		;0CD28	B0BB
	test	cl,03h			;0CD2A	F6C103
	jz	H0000_CD30		;0CD2D	7401		t
	dec	ax			;0CD2F	48		H
H0000_CD30:
	stosb				;0CD30	AA
	mov	ax,bp			;0CD31	8BC5
	mov	Word Ptr ds:[108Dh],ax	;0CD33	A38D10
	stosw				;0CD36	AB
	ret				;0CD37	C3
;---------------------------------------
H0000_CD38:
	call	H0000_CCC7		;0CD38	E88CFF

	jz	H0000_CD50		;0CD3B	7413		t
	cmp	bl,0FCh 		;0CD3D	80FBFC
	jb	H0000_CD50		;0CD40	720E		r
	mov	al,8Dh			;0CD42	B08D
	stosb				;0CD44	AA
	mov	al,36h			;0CD45	B036		 6
	test	dh,02h			;0CD47	F6C602
	jz	H0000_CD58		;0CD4A	740C		t
	mov	al,3Eh			;0CD4C	B03E		 >
	jmp	Short H0000_CD58	;0CD4E	EB08
;- - - - - - - - - - - - - - - - - - - -
H0000_CD50:
	mov	al,0BEh 		;0CD50	B0BE
	test	dh,02h			;0CD52	F6C602
	jz	H0000_CD58		;0CD55	7401		t
	inc	ax			;0CD57	40		@
H0000_CD58:
	stosb				;0CD58	AA
	mov	ds:[08A8h],di		;0CD59	893EA808	 >
	stosw				;0CD5D	AB
	ret				;0CD5E	C3
;---------------------------------------
H0000_CD5F:
	call	H0000_CCC7		;0CD5F	E865FF		 e

	jz	H0000_CD77		;0CD62	7413		t
	test	bh,05h			;0CD64	F6C705
	jz	H0000_CD77		;0CD67	740E		t
	mov	al,8Dh			;0CD69	B08D
	stosb				;0CD6B	AA
	mov	al,0Eh			;0CD6C	B00E
	test	dl,10h			;0CD6E	F6C210
	jz	H0000_CD80		;0CD71	740D		t
	mov	al,2Eh			;0CD73	B02E		 .
	jmp	Short H0000_CD80	;0CD75	EB09
;- - - - - - - - - - - - - - - - - - - -
H0000_CD77:
	mov	al,0B9h 		;0CD77	B0B9
	test	dl,10h			;0CD79	F6C210
	jz	H0000_CD80		;0CD7C	7402		t
	mov	al,0BDh 		;0CD7E	B0BD
H0000_CD80:
	stosb				;0CD80	AA
	mov	ds:[088Dh],di		;0CD81	893E8D08	 >
	stosw				;0CD85	AB
H0000_CD86:
	ret				;0CD86	C3
;---------------------------------------
H0000_CD87:
	test	ch,03h			;0CD87	F6C503
	jnz	H0000_CD95		;0CD8A	7509		u
	xor	ax,ax			;0CD8C	33C0		3
	mov	al,bl			;0CD8E	8AC3
	and	al,07h			;0CD90	2407		$
	add	al,78h			;0CD92	0478		 x
	stosw				;0CD94	AB
H0000_CD95:
	ret				;0CD95	C3
;---------------------------------------
H0000_CD96:
	lodsb				;0CD96	AC
	test	ch,02h			;0CD97	F6C502
	jz	H0000_CDAA		;0CD9A	740E		t
	cmp	al,01h			;0CD9C	3C01		<
	jnz	H0000_CDA9		;0CD9E	7509		u
	mov	al,0FCh 		;0CDA0	B0FC
	test	dh,80h			;0CDA2	F6C680
	jz	H0000_CDA8		;0CDA5	7401		t
	dec	ax			;0CDA7	48		H
H0000_CDA8:
	stosb				;0CDA8	AA
H0000_CDA9:
	ret				;0CDA9	C3
;---------------------------------------
H0000_CDAA:
	cmp	al,03h			;0CDAA	3C03		<
	jnz	H0000_CDA9		;0CDAC	75FB		u
	mov	al,90h			;0CDAE	B090
	test	dh,80h			;0CDB0	F6C680
	jz	H0000_CDB7		;0CDB3	7402		t
	mov	al,2Eh			;0CDB5	B02E		 .
H0000_CDB7:
	stosb				;0CDB7	AA
	ret				;0CDB8	C3
;---------------------------------------
H0000_CDB9:
	push	dx			;0CDB9	52		R
	push	ds			;0CDBA	1E
	push	es			;0CDBB	06
	push	bx			;0CDBC	53		S
	mov	ah,2Fh			;0CDBD	B42F		 /
	call	H0000_C863		;0CDBF	E8A1FA

	push	bx			;0CDC2	53		S
	push	es			;0CDC3	06
	push	ds			;0CDC4	1E
	push	dx			;0CDC5	52		R
	mov	ah,1Ah			;0CDC6	B41A
	push	cs			;0CDC8	0E

;SEG: DS Change - 0000h
	pop	ds			;0CDC9	1F
	mov	dx,00A2h		;0CDCA	BAA200
	call	H0000_C863		;0CDCD	E893FA

	pop	dx			;0CDD0	5A		Z

;SEG: DS Change - Indefinite
	pop	ds			;0CDD1	1F
	mov	cx,0027h		;0CDD2	B92700		 '
	mov	ax,4E00h		;0CDD5	B8004E		  N
	call	H0000_C863		;0CDD8	E888FA

;SEG: DS Change - Indefinite
	pop	ds			;0CDDB	1F
	pop	dx			;0CDDC	5A		Z
	pushf				;0CDDD	9C

;SEG: CS Override
	mov	al,Byte Ptr cs:[00BBh]	;0CDDE	2EA0BB00	.
	mov	ah,1Ah			;0CDE2	B41A
	call	H0000_C863		;0CDE4	E87CFA		 |

	popf				;0CDE7	9D
	pop	bx			;0CDE8	5B		[

;SEG: ES Change - Indefinite
	pop	es			;0CDE9	07

;SEG: DS Change - Indefinite
	pop	ds			;0CDEA	1F
	pop	dx			;0CDEB	5A		Z
	ret				;0CDEC	C3
;---------------------------------------
H0000_CDED:
	call	H0000_CECE		;0CDED	E8DE00

	jz	H0000_CE04		;0CDF0	7412		t
	call	H0000_CDB9		;0CDF2	E8C4FF

	jb	H0000_CE04		;0CDF5	720D		r
	cmp	al,0C8h 		;0CDF7	3CC8		<
	jb	H0000_CE04		;0CDF9	7209		r
	call	H0000_C896		;0CDFB	E898FA

	jnb	H0000_CE06		;0CDFE	7306		s
	cmp	al,03h			;0CE00	3C03		<
	ja	H0000_CE38		;0CE02	7734		w4
H0000_CE04:
	stc				;0CE04	F9
	ret				;0CE05	C3
;---------------------------------------
H0000_CE06:
	call	H0000_CCB7		;0CE06	E8AEFE

	jb	H0000_CE38		;0CE09	722D		r-
	call	H0000_CCB4		;0CE0B	E8A6FE

	jb	H0000_CE15		;0CE0E	7205		r
	neg	ah			;0CE10	F6DC
	call	H0000_CCC0		;0CE12	E8ABFE

H0000_CE15:
	call	H0000_CE52		;0CE15	E83A00		 :

	jnz	H0000_CE38		;0CE18	751E		u
	push	ds			;0CE1A	1E
	push	es			;0CE1B	06
	push	cs			;0CE1C	0E

;SEG: ES Change - 0000h
	pop	es			;0CE1D	07
	mov	si,bp			;0CE1E	8BF5
	mov	di,0002h		;0CE20	BF0200
	call	H0000_CE88		;0CE23	E86200		 b

	cmp	al,0FFh 		;0CE26	3CFF		<
	jnz	H0000_CE33		;0CE28	7509		u
	mov	ah,60h			;0CE2A	B460		 `
	call	H0000_C863		;0CE2C	E834FA		 4

;SEG: ES Override
	mov	es:[di-02h],bx		;0CE2F	26895DFE	& ]
H0000_CE33:

;SEG: ES Change - Indefinite
	pop	es			;0CE33	07

;SEG: DS Change - Indefinite
	pop	ds			;0CE34	1F
	call	H0000_CE3B		;0CE35	E80300

H0000_CE38:
	jmp	H0000_C90F		;0CE38	E9D4FA
;---------------------------------------
H0000_CE3B:
	push	cs			;0CE3B	0E

;SEG: DS Change - 0000h
	pop	ds			;0CE3C	1F
	call	H0000_C88F		;0CE3D	E84FFA		 O

	mov	dx,ds:[1065h]		;0CE40	8B166510	  e
	mov	cx,ds:[1067h]		;0CE44	8B0E6710	  g
	mov	al,00h			;0CE48	B000
	call	H0000_C90A		;0CE4A	E8BDFA

	xor	cx,cx			;0CE4D	33C9		3
	jmp	H0000_C892		;0CE4F	E940FA		 @
;---------------------------------------
H0000_CE52:
	call	H0000_CE69		;0CE52	E81400

;SEG: CS Override
	cmp	Word Ptr cs:[si+1Ch],0DEADh
					;0CE55	2E817C1CADDE	. |
	jnz	H0000_CE68		;0CE5B	750B		u

;SEG: CS Override
	cmp	Byte Ptr cs:[si],0E9h	;0CE5D	2E803CE9	. <
	jz	H0000_CE68		;0CE61	7405		t

;SEG: CS Override
	cmp	Word Ptr cs:[si],5A4Dh	;0CE63	2E813C4D5A	. <MZ
H0000_CE68:
	ret				;0CE68	C3
;---------------------------------------
H0000_CE69:
	mov	si,104Dh		;0CE69	BE4D10		 M
	push	si			;0CE6C	56		V

;SEG: CS Override
	mov	ax,cs:[si+1Eh]		;0CE6D	2E8B441E	. D
H0000_CE71:

;SEG: CS Override
	xor	cs:[si],ax		;0CE71	2E3104		.1
	add	ax,913Fh		;0CE74	053F91		 ?
	inc	si			;0CE77	46		F
	inc	si			;0CE78	46		F
	cmp	si,106Bh		;0CE79	81FE6B10	  k
	jnz	H0000_CE71		;0CE7D	75F2		u
	pop	si			;0CE7F	5E		^
	ret				;0CE80	C3
;---------------------------------------
H0000_CE81:

;SEG: CS Override
	mov	Byte Ptr cs:[0000h],0FFh;0CE81	2EC6060000FF	.
	ret				;0CE87	C3
;---------------------------------------
H0000_CE88:

;SEG: CS Override
	mov	al,Byte Ptr cs:[0000h]	;0CE88	2EA00000	.
	ret				;0CE8C	C3
;---------------------------------------
H0000_CE8D:
	mov	dx,010Ch		;0CE8D	BA0C01
H0000_CE90:
	nop				;0CE90	90

;SEG: CS Override
	mov	Byte Ptr cs:[029Dh],00h ;0CE91	2EC6069D0200	.
	mov	ah,52h			;0CE97	B452		 R
	call	H0000_C863		;0CE99	E8C7F9

	call	H0000_CEBC		;0CE9C	E81D00

H0000_CE9F:
	cmp	Byte Ptr [di],5Ah	;0CE9F	803D5A		 =Z
	jz	H0000_CEAB		;0CEA2	7407		t
	push	ds			;0CEA4	1E

;SEG: ES Change - Indefinite
	pop	es			;0CEA5	07
	call	H0000_CEAF		;0CEA6	E80600

	jmp	Short H0000_CE9F	;0CEA9	EBF4
;---------------------------------------
H0000_CEAB:
	add	[di+03h],dx		;0CEAB	015503		 U
	ret				;0CEAE	C3
;---------------------------------------
H0000_CEAF:
	mov	ax,ds			;0CEAF	8CD8
	inc	ax			;0CEB1	40		@
	add	ax,[di+03h]		;0CEB2	034503		 E

;SEG: DS Change - Indefinite
	mov	ds,ax			;0CEB5	8ED8
	ret				;0CEB7	C3
;---------------------------------------
H0000_CEB8:
	mov	ah,52h			;0CEB8	B452		 R

;(RESERVED) DOS2-SYS Get Variable Data
;INT: 21h  ah=52h
	int	21h			;0CEBA	CD21		 !
H0000_CEBC:

;SEG: DS Change - Indefinite
;SEG: ES Override
	lds	di,DWord Ptr es:[bx-04h];0CEBC	26C57FFC	&
	ret				;0CEC0	C3
;---------------------------------------
H0000_CEC1:

;SEG: CS Override
	cmp	dx,cs:[1067h]		;0CEC1	2E3B166710	.; g
	jnz	H0000_CECD		;0CEC6	7505		u

;SEG: CS Override
	cmp	bx,cs:[1065h]		;0CEC8	2E3B1E6510	.; e
H0000_CECD:
	ret				;0CECD	C3
;---------------------------------------
H0000_CECE:

;SEG: CS Override
	mov	Byte Ptr cs:[0CD3h],01h ;0CECE	2EC606D30C01	.
	mov	ax,0FF0Fh		;0CED4	B80FFF
	pushf				;0CED7	9C

;MEM: CALL  DWORD PTR CS:[0092H]

; ax=FF0Fh
	call	DWord Ptr cs:[0092h]	;0CED8	2EFF1E9200	.

	cmp	ax,0101h		;0CEDD	3D0101		=

;SEG: CS Override
	mov	Byte Ptr cs:[0CD3h],00h ;0CEE0	2EC606D30C00	.
	ret				;0CEE6	C3
;---------------------------------------
H0000_CEE7:
	mov	ax,0FA02h		;0CEE7	B802FA
	mov	dx,5945h		;0CEEA	BA4559		 EY

;BIOS-DSK Disk Drive Services, AH=Func
;INT: 13h  ax=FA02h dx=5945h
	int	13h			;0CEED	CD13
	ret				;0CEEF	C3
;---------------------------------------
;MEM: Unreferenced Code
	db	0B1h			;0CEF0
	db	0A1h			;0CEF1
	dw	0BCA2h			;0CEF2	A2BC
	dw	65C8h			;0CEF4	C865		 e
	dw	65CEh			;0CEF6	CE65		 e
	db	0D9h			;0CEF8
	db	" e"="" ;0cef9="" 65="" db="" 0d1h="" ;0cefa="" db="" "e"="" ;0cefb="" 65="" db="" 0d3h="" ;0cefc="" db="" "e"="" ;0cefd="" 65="" dw="" 0bcceh="" ;0cefe="" cebc="" db="" 0ebh="" ;0cf00="" db="" 0fdh="" ;0cf01="" db="" 0efh="" ;0cf02="" dw="" 0f8bch="" ;0cf03="" bcf8="" db="" 0f3h="" ;0cf05="" dw="" 0f9f2h="" ;0cf06="" f2f9="" dw="" 0febch="" ;0cf08="" bcfe="" db="" 0e5h="" ;0cf0a="" dw="" 0d2bch="" ;0cf0b="" bcd2="" db="" 0d9h="" ;0cf0d="" db="" 0c9h="" ;0cf0e="" dw="" 0d3ceh="" ;0cf0f="" ced3="" dw="" 0dddeh="" ;0cf11="" dedd="" db="" 0cfh="" ;0cf13="" dw="" 0d9d4h="" ;0cf14="" d4d9="" dw="" 0bcceh="" ;0cf16="" cebc="" db="" 0b3h="" ;0cf18="" dw="" 0d1bch="" ;0cf19="" bcd1="" db="" 0fdh="" ;0cf1b="" db="" 0e5h="" ;0cf1c="" db="" 0b1h="" ;0cf1d="" dw="" 0e9d6h="" ;0cf1e="" d6e9="" dw="" 0f9f2h="" ;0cf20="" f2f9="" db="" 0bbh="" ;0cf22="" db="" 0a5h="" ;0cf23="" dw="" 0b0aeh="" ;0cf24="" aeb0="" dw="" 0dbbch="" ;0cf26="" bcdb="" db="" 0f9h="" ;0cf28="" dw="" 0f1eeh="" ;0cf29="" eef1="" db="" 0fdh="" ;0cf2b="" dw="" 0e5f2h="" ;0cf2c="" f2e5="" dw="" 0a0bch="" ;0cf2e="" bca0="" db="" 0a1h="" ;0cf30="" db="" 0b1h="" ;0cf31="" dw="" 589ch="" ;0cf32="" 9c58="" x="" db="" 0d1h="" ;0cf34="" db="" 0d3h="" ;0cf35="" db="" 0d1h="" ;0cf36="" db="" 0d9h="" ;0cf37="" dw="" 0c8d2h="" ;0cf38="" d2c8="" db="" "x"="" ;0cf3a="" 58="" db="" 0d3h="" ;0cf3b="" dw="" 58dah="" ;0cf3c="" da58="" x="" dw="" 0d9c8h="" ;0cf3e="" c8d9="" dw="" 0ceceh="" ;0cf40="" cece="" db="" 0d3h="" ;0cf42="" dw="" 58ceh="" ;0cf43="" ce58="" x="" db="" 0d5h="" ;0cf45="" db="" 0cfh="" ;0cf46="" db="" "x"="" ;0cf47="" 58="" dw="" 0d4c8h="" ;0cf48="" c8d4="" db="" 0d9h="" ;0cf4a="" db="" "x"="" ;0cf4b="" 58="" dw="" 0d9deh="" ;0cf4c="" ded9="" db="" 0dbh="" ;0cf4e="" db="" 0d5h="" ;0cf4f="" dw="" 0d2d2h="" ;0cf50="" d2d2="" db="" 0d5h="" ;0cf52="" dw="" 0dbd2h="" ;0cf53="" d2db="" db="" "x"="" ;0cf55="" 58="" db="" 0d3h="" ;0cf56="" dw="" 58dah="" ;0cf57="" da58="" x="" dw="" 0d5d0h="" ;0cf59="" d0d5="" dw="" 0d9dah="" ;0cf5b="" dad9="" db="" "x"="" ;0cf5d="" 58="" dw="" 509ch="" ;0cf5e="" 9c50="" p="" db="" 0e4h="" ;0cf60="" db=""></mz><suh" ;0cf61="" 603c5375="" dw="" 0b81eh="" ;0cf66="" 1eb8="" db="" "@"="" ;0cf68="" 40="" dw="" 8e00h="" ;0cf69="" 008e="" dw="" 0a0d8h="" ;0cf6b="" d8a0="" db="" 17h="" ;0cf6d="" dw="" 0a800h="" ;0cf6e="" 00a8="" db="" 0ch="" ;0cf70="" db="" "t:sqrv"="" ;0cf71="" 743a5351="" dw="" 00b8h="" ;0cf77="" b800="" db="" 07h="" ;0cf79="" db="" "3"="" ;0cf7a="" 33="" db="" 0dbh="" ;0cf7b="" db="" 8bh="" ;0cf7c="" db="" 0cbh="" ;0cf7d="" dw="" 7fbah="" ;0cf7e="" ba7f="" dw="" 0cd18h="" ;0cf80="" 18cd="" dw="" 0b410h="" ;0cf82="" 10b4="" dw="" 0ba02h="" ;0cf84="" 02ba="" db="" 07h="" ;0cf86="" db="" 09h="" ;0cf87="" db="" 0cdh="" ;0cf88="" dw="" 0be10h="" ;0cf89="" 10be="" db="" "n"="" ;0cf8b="" 4e="" db="" 0bh="" ;0cf8c="" dw="" 25e8h="" ;0cf8d="" e825="" %="" dw="" 0ba00h="" ;0cf8f="" 00ba="" db="" 13h="" ;0cf91="" db="" 0fh="" ;0cf92="" db="" 0cdh="" ;0cf93="" dw="" 0be10h="" ;0cf94="" 10be="" db="" 91h="" ;0cf96="" db="" 0bh="" ;0cf97="" dw="" 1ae8h="" ;0cf98="" e81a="" dw="" 0b900h="" ;0cf9a="" 00b9="" dw="" 0096h="" ;0cf9c="" 9600="" db="" "q"="" ;0cf9e="" 51="" db="" 0b9h="" ;0cf9f="" db="" 0ffh="" ;0cfa0="" db="" 0ffh="" ;0cfa1="" db="" 0ebh="" ;0cfa2="" dw="" 0e200h="" ;0cfa3="" 00e2="" dw="" 59fch="" ;0cfa5="" fc59="" y="" dw="" 0f5e2h="" ;0cfa7="" e2f5="" db="" "^zy["="" ;0cfa9="" 5e5a595b="" db="" 1fh="" ;0cfad="" db="" "x"="" ;0cfae="" 58="" dw="" 2efah="" ;0cfaf="" fa2e="" .="" db="" 0ffh="" ;0cfb1="" db="" "."="" ;0cfb2="" 2e="" dw="" 009ah="" ;0cfb3="" 9a00="" db="" "."="" ;0cfb5="" 2e="" dw="" 048ah="" ;0cfb6="" 8a04="" db="" "4"="" ;0cfb8="" 34="" dw="" 3c9ch="" ;0cfb9="" 9c3c=""></suh">< dw="" 7400h="" ;0cfbb="" 0074="" t="" db="" 05h="" ;0cfbd="" db="" 0cdh="" ;0cfbe="" db="" ")fu"="" ;0cfbf="" 294675="" ;mem:="" possible="" code="" area="" dw="" 0c3f2h="" ;0cfc2="" f2c3="" ;---------------------------------------="" h0000_cfc4:="" ;---------------------------------------="" cli="" ;0cfc4="" fa="" call="" h0000_c83e="" ;0cfc5="" e876f8="" v="" h0000_cfc8:="" mov="" ax,0f3bh="" ;0cfc8="" b83b0f="" ;="" ;seg:="" ds="" change="" -="" 0f3bh="" mov="" ds,ax="" ;0cfcb="" 8ed8="" mov="" ax,9ef5h="" ;0cfcd="" b8f59e="" ;seg:="" es="" change="" -="" 9ef5h="" mov="" es,ax="" ;0cfd0="" 8ec0="" mov="" ax,4300h="" ;0cfd2="" b80043="" c="" mov="" bx,0faceh="" ;0cfd5="" bbcefa="" mov="" cx,1981h="" ;0cfd8="" b98119="" mov="" dx,000eh="" ;0cfdb="" ba0e00="" mov="" si,11b7h="" ;0cfde="" beb711="" mov="" di,008ah="" ;0cfe1="" bf8a00="" mov="" bp,0070h="" ;0cfe4="" bd7000="" p="" sti="" ;0cfe7="" fb="" ret="" ;0cfe8="" c3="" ;---------------------------------------="" ;mem:="" unreferenced="" code="" dw="" 0000h="" ;0cfe9="" 0000="" ;---------------------------------------="" h0000_cfeb:="" ;---------------------------------------="" xor="" bx,bx="" ;0cfeb="" 33db="" 3="" ;seg:="" ds="" change="" -="" 0000h="" mov="" ds,bx="" ;0cfed="" 8edb="" ;seg:="" ds="" change="" -="" indefinite="" lds="" si,dword="" ptr="" [bx+04h]="" ;0cfef="" c57704="" w="" cmp="" byte="" ptr="" [si],0cfh="" ;0cff2="" 803ccf="">< jnz="" h0000_d010="" ;0cff5="" 7519="" u="" cmp="" ah,30h="" ;0cff7="" 80fc30="" 0="" jnz="" h0000_d017="" ;0cffa="" 751b="" u="" push="" cx="" ;0cffc="" 51="" q="" push="" dx="" ;0cffd="" 52="" r="" mov="" ah,2ah="" ;0cffe="" b42a="" *="" call="" h0000_c863="" ;0d000="" e860f8="" `="" pop="" bx="" ;0d003="" 5b="" [="" pop="" bp="" ;0d004="" 5d="" ]="" mov="" ax,0c47h="" ;0d005="" b8470c="" g="" cmp="" bp,cx="" ;0d008="" 3be9="" ;="" jnz="" h0000_d013="" ;0d00a="" 7507="" u="" cmp="" bx,dx="" ;0d00c="" 3bda="" ;="" jnz="" h0000_d013="" ;0d00e="" 7503="" u="" h0000_d010:="" mov="" ax,0d0eh="" ;0d010="" b80e0d="" h0000_d013:="" ;seg:="" cs="" override="" mov="" word="" ptr="" cs:[0487h],ax="" ;0d013="" 2ea38704="" .="" h0000_d017:="" jmp="" short="" h0000_cfc8="" ;0d017="" ebaf="" ;---------------------------------------="" ;mem:="" unreferenced="" code="" db="" "psv"="" ;0d019="" 505356="" dw="" 00e8h="" ;0d01c="" e800="" dw="" 5e00h="" ;0d01e="" 005e="" ^="" db="" 8bh="" ;0d020="" dw="" 36dch="" ;0d021="" dc36="" 6="" db="" 8bh="" ;0d023="" db="" "g"="" ;0d024="" 47="" dw="" 3d08h="" ;0d025="" 083d="dw" 0110h="" ;0d027="" 1001="" db="" "w"="" ;0d029="" 77="" db="" 13h="" ;0d02a="" db="" "."="" ;0d02b="" 2e="" db="" 89h="" ;0d02c="" db="" "d?6"="" ;0d02d="" 443f36="" db="" 8bh="" ;0d030="" db="" "g"="" ;0d031="" 47="" dw="" 2e06h="" ;0d032="" 062e="" .="" db="" 89h="" ;0d034="" db="" "d="6"" ;0d035="" 443d36="" dw="" 6780h="" ;0d038="" 8067="" g="" db="" 0bh="" ;0d03a="" dw="" 0ebfeh="" ;0d03b="" feeb="" dw="" 0e18h="" ;0d03d="" 180e="" db="" "x6;g"="" ;0d03f="" 58363b47="" dw="" 7408h="" ;0d043="" 0874="" t="" dw="" 3610h="" ;0d045="" 1036="" 6="" db="" 8bh="" ;0d047="" db="" "g"="" ;0d048="" 47="" dw="" 2e08h="" ;0d049="" 082e="" .="" db="" 89h="" ;0d04b="" db="" "dg6"="" ;0d04c="" 444736="" db="" 8bh="" ;0d04f="" db="" "g"="" ;0d050="" 47="" dw="" 2e06h="" ;0d051="" 062e="" .="" db="" 89h="" ;0d053="" db="" "de^[x"="" ;0d054="" 44455e5b="" db="" 0cfh="" ;0d059="" db="" "ch"="" ;0d05a="" 4348="" dw="" 109eh="" ;0d05c="" 9e10="" dw="" 0110h="" ;0d05e="" 1001="" db="" "f2f-sy"="" ;0d060="" 4632462d="" dw="" 0000h="" ;0d066="" 0000="" db="" "pmrjkzha\*.*"="" ;0d068="" 504d524a="" dw="" 0c900h="" ;0d074="" 00c9="" dw="" 4d00h="" ;0d076="" 004d="" m="" db="" 02h="" ;0d078="" ;---------------------------------------="" h0000_d079:="" ;---------------------------------------="" ;mem:="" possible="" data="" area="" ;a="" call="" h0000_d07c="" ;0d079="" e80000="" db="" 0e8h,00h,00h="" h0000_d07c:="" pop="" si="" ;0d07c="" 5e="" ^="" mov="" ah,2ah="" ;0d07d="" b42a="" *="" ;seg:="" cs="" override="" mov="" cs:[si+02d4h],es="" ;0d07f="" 2e8c84d402="" .="" ;dos1-sys="" get="" date="" (cx="Year," dx="Month/Day," al="Day" of="" week="" (0="Sun))" ;int:="" 21h="" ah="2Ah" int="" 21h="" ;0d084="" cd21="" !="" mov="" al,72h="" ;0d086="" b072="" r="" cmp="" dx,0504h="" ;0d088="" 81fa0405="" jb="" h0000_d094="" ;0d08c="" 7206="" r="" cmp="" cx,07c9h="" ;0d08e="" 81f9c907="" jnb="" h0000_d096="" ;0d092="" 7302="" s="" h0000_d094:="" mov="" al,0ebh="" ;0d094="" b0eb="" h0000_d096:="" ;seg:="" cs="" override="" mov="" cs:[si+0f44dh],al="" ;0d096="" 2e88844df4="" .="" m="" mov="" ah,30h="" ;0d09b="" b430="" 0="" cld="" ;0d09d="" fc="" ;dos2-sys="" get="" ax="" dos="" version="" number="" ;int:="" 21h="" ah="30h" al="2Ah" int="" 21h="" ;0d09e="" cd21="" !="" xchg="" al,ah="" ;0d0a0="" 86c4="" cmp="" ax,031dh="" ;0d0a2="" 3d1d03="ja" h0000_d0aa="" ;0d0a5="" 7703="" w="" h0000_d0a7:="" jmp="" h0000_d336="" ;0d0a7="" e98c02="" ;---------------------------------------="" h0000_d0aa:="" mov="" ax,0f1e9h="" ;0d0aa="" b8e9f1="" ;dosx-dos="" services="" -="" int="" 21h,="" ah="Func" ;int:="" 21h="" ax="F1E9h" int="" 21h="" ;0d0ad="" cd21="" !="" cmp="" ax,0cadeh="" ;0d0af="" 3ddeca="jz" h0000_d0a7="" ;0d0b2="" 74f3="" t="" xor="" di,di="" ;0d0b4="" 33ff="" 3="" mov="" ax,0040h="" ;0d0b6="" b84000="" @="" ;seg:="" ds="" change="" -="" 0040h="" mov="" ds,ax="" ;0d0b9="" 8ed8="" mov="" bp,[di+13h]="" ;0d0bb="" 8b6d13="" m="" mov="" cl,06h="" ;0d0be="" b106="" sal="" bp,cl="" ;0d0c0="" d3e5="" mov="" ah,62h="" ;0d0c2="" b462="" b="" ;dos3-sys="" get="" bx="" psp="" ;int:="" 21h="" ax="6240h" cl="06h" ds="0040h" di="0000h" int="" 21h="" ;0d0c4="" cd21="" !="" ;seg:="" ds="" change="" -="" indefinite="" mov="" ds,bx="" ;0d0c6="" 8edb="" push="" [di+2ch]="" ;0d0c8="" ff752c="" u,="" push="" ds="" ;0d0cb="" 1e="" mov="" cl,90h="" ;0d0cc="" b190="" mov="" ax,5800h="" ;0d0ce="" b80058="" x="" ;dos3-mem="" get="" memory="" alloc="" strategy="" (ax="0" 1st,="" 1="" best,="" 2="" last="" fit)="" ;int:="" 21h="" ax="5800h" cl="90h" di="0000h" int="" 21h="" ;0d0d1="" cd21="" !="" xor="" ah,ah="" ;0d0d3="" 32e4="" 2="" push="" ax="" ;0d0d5="" 50="" p="" mov="" ax,5801h="" ;0d0d6="" b80158="" x="" mov="" bx,0080h="" ;0d0d9="" bb8000="" ;dos3-mem="" set="" bx="" memory="" alloc="" strategy="" [0="" 1st,="" 1="" best,="" 2="" last="" fit]="" ;int:="" 21h="" ax="5801h" bx="0080h" cl="90h" di="0000h" int="" 21h="" ;0d0dc="" cd21="" !="" mov="" ax,5802h="" ;0d0de="" b80258="" x="" ;dos3-mem="" get/set="" memory="" alloc="" strategy="" ;int:="" 21h="" ax="5802h" bx="0080h" cl="90h" di="0000h" int="" 21h="" ;0d0e1="" cd21="" !="" xor="" ah,ah="" ;0d0e3="" 32e4="" 2="" push="" ax="" ;0d0e5="" 50="" p="" mov="" ax,5803h="" ;0d0e6="" b80358="" x="" mov="" bx,0001h="" ;0d0e9="" bb0100="" ;dos3-mem="" get/set="" memory="" alloc="" strategy="" ;int:="" 21h="" ax="5803h" bx="0001h" cl="90h" di="0000h" int="" 21h="" ;0d0ec="" cd21="" !="" jb="" h0000_d108="" ;0d0ee="" 7218="" r="" mov="" ah,48h="" ;0d0f0="" b448="" h="" mov="" bx,0ffffh="" ;0d0f2="" bbffff="" ;dos2-mem="" alloc="" bx="#Paras" memory="" (ax="Segment," bx="#Paras)" ;int:="" 21h="" ax="4803h" bx="FFFFh" cl="90h" di="0000h" int="" 21h="" ;0d0f5="" cd21="" !="" mov="" ah,48h="" ;0d0f7="" b448="" h="" ;dos2-mem="" alloc="" bx="#Paras" memory="" (ax="Segment," bx="#Paras)" ;int:="" 21h="" ax="4803h" bx="FFFFh" cl="90h" di="0000h" int="" 21h="" ;0d0f9="" cd21="" !="" ;seg:="" es="" change="" -="" 4803h="" mov="" es,ax="" ;0d0fb="" 8ec0="" cmp="" ax,bp="" ;0d0fd="" 3bc5="" ;="" jnb="" h0000_d135="" ;0d0ff="" 7334="" s4="" dec="" ax="" ;0d101="" 48="" h="" ;seg:="" es="" change="" -="" 4802h="" mov="" es,ax="" ;0d102="" 8ec0="" ;seg:="" es="" override="" mov="" es:[di+01h],di="" ;0d104="" 26897d01="" &="" }="" h0000_d108:="" mov="" ax,4300h="" ;0d108="" b80043="" c="" ;dos3-mul="" mltplx/splr,="" ax="Proc/Func" ;int:="" 2fh="" ax="4300h" bx="FFFFh" cl="90h" es="4802h" di="0000h" int="" 2fh="" ;0d10b="" cd2f="" cmp="" al,80h="" ;0d10d="" 3c80="">< jnz="" h0000_d152="" ;0d10f="" 7541="" ua="" mov="" ax,4310h="" ;0d111="" b81043="" c="" ;dos3-mul="" mltplx/splr,="" ax="Proc/Func" ;int:="" 2fh="" ax="4310h" bx="FFFFh" cl="90h" es="4802h" di="0000h" int="" 2fh="" ;0d114="" cd2f="" push="" cs="" ;0d116="" 0e="" ;seg:="" ds="" change="" -="" 0000h="" pop="" ds="" ;0d117="" 1f="" ;seg:="" sp="" change="" -="" indefinite="" mov="" [si-07h],bx="" ;0d118="" 895cf9="" \="" mov="" [si-05h],es="" ;0d11b="" 8c44fb="" d="" mov="" ah,10h="" ;0d11e="" b410="" mov="" dx,0ffffh="" ;0d120="" baffff="" ;mem:="" call="" dword="" ptr="" [si-07h]="" ;seg:="" sp="" change="" -="" indefinite="" ;="" ax="1010h" bx="FFFFh" cl="90h" dx="FFFFh" ds="0000h" es="4802h" di="0000h" call="" dword="" ptr="" [si-07h]="" ;0d123="" ff5cf9="" \="" cmp="" bl,0b0h="" ;0d126="" 80fbb0="" jnz="" h0000_d152="" ;0d129="" 7527="" u'="" mov="" ah,10h="" ;0d12b="" b410="" ;mem:="" call="" dword="" ptr="" [si-07h]="" ;seg:="" sp="" change="" -="" indefinite="" ;="" ah="10h" call="" dword="" ptr="" [si-07h]="" ;0d12d="" ff5cf9="" \="" dec="" ax="" ;0d130="" 48="" h="" jnz="" h0000_d152="" ;0d131="" 751f="" u="" ;seg:="" es="" change="" -="" indefinite="" mov="" es,bx="" ;0d133="" 8ec3="" h0000_d135:="" mov="" cl,0c3h="" ;0d135="" b1c3="" mov="" ax,es="" ;0d137="" 8cc0="" dec="" ax="" ;0d139="" 48="" h="" ;seg:="" ds="" change="" -="" indefinite="" mov="" ds,ax="" ;0d13a="" 8ed8="" mov="" byte="" ptr="" [di],5ah="" ;0d13c="" c6055a="" z="" mov="" [di+01h],di="" ;0d13f="" 897d01="" }="" sub="" word="" ptr="" [di+03h],010ch="" ;0d142="" 816d030c01="" m="" call="" h0000_ceaf="" ;0d147="" e865fd="" e="" ;seg:="" sp="" change="" -="" indefinite="" ;seg:="" cs="" override="" mov="" cs:[si+0177h],ax="" ;0d14a="" 2e89847701="" .="" w="" inc="" ax="" ;0d14f="" 40="" @="" ;seg:="" es="" change="" -="" indefinite="" mov="" es,ax="" ;0d150="" 8ec0="" h0000_d152:="" pop="" bx="" ;0d152="" 5b="" [="" mov="" ax,5803h="" ;0d153="" b80358="" x="" ;dos3-mem="" get/set="" memory="" alloc="" strategy="" ;int:="" 21h="" ax="5803h" int="" 21h="" ;0d156="" cd21="" !="" pop="" bx="" ;0d158="" 5b="" [="" mov="" ax,5801h="" ;0d159="" b80158="" x="" ;dos3-mem="" set="" bx="" memory="" alloc="" strategy="" [0="" 1st,="" 1="" best,="" 2="" last="" fit]="" ;int:="" 21h="" ax="5801h" int="" 21h="" ;0d15c="" cd21="" !="" ;seg:="" ds="" change="" -="" indefinite="" pop="" ds="" ;0d15e="" 1f="" ;seg:="" cs="" override="" mov="" cs:[si+0fe14h],cl="" ;0d15f="" 2e888c14fe="" .="" cmp="" cl,90h="" ;0d164="" 80f990="" jnz="" h0000_d185="" ;0d167="" 751c="" u="" push="" ds="" ;0d169="" 1e="" ;seg:="" es="" change="" -="" indefinite="" pop="" es="" ;0d16a="" 07="" mov="" bx,0ffffh="" ;0d16b="" bbffff="" mov="" ah,4ah="" ;0d16e="" b44a="" j="" ;dos2-mem="" set="" es="" memory="" block,="" bx="#Paras" (bx="#Paras)" ;int:="" 21h="" ax="4A01h" bx="FFFFh" cl="58h" int="" 21h="" ;0d170="" cd21="" !="" mov="" ax,010ch="" ;0d172="" b80c01="" sub="" [di+02h],ax="" ;0d175="" 294502="" )e="" sub="" bx,ax="" ;0d178="" 2bd8="" +="" mov="" ah,4ah="" ;0d17a="" b44a="" j="" ;dos2-mem="" set="" es="" memory="" block,="" bx="#Paras" (bx="#Paras)" ;int:="" 21h="" ax="4A0Ch" cl="58h" int="" 21h="" ;0d17c="" cd21="" !="" mov="" ax,ds="" ;0d17e="" 8cd8="" inc="" ax="" ;0d180="" 40="" @="" add="" ax,bx="" ;0d181="" 03c3="" ;seg:="" es="" change="" -="" indefinite="" mov="" es,ax="" ;0d183="" 8ec0="" h0000_d185:="" push="" si="" ;0d185="" 56="" v="" push="" cs="" ;0d186="" 0e="" ;seg:="" ds="" change="" -="" 0000h="" pop="" ds="" ;0d187="" 1f="" sub="" si,0c0dh="" ;0d188="" 81ee0d0c="" mov="" cx,0f80h="" ;0d18c="" b9800f="" mov="" di,00cdh="" ;0d18f="" bfcd00="" ;="" cx="0F80h" ds="0000h" di="00CDh" rep="" movsb="" ;0d192="" f3a4="" ;asm:="" synonym="" ;a="" add="" di,+20h="" ;0d194="" 83c720="" db="" 83h,0c7h,20h="" ;asm:="" synonym="" ;a="" sub="" si,+35h="" ;0d197="" 83ee35="" 5="" db="" 83h,0eeh,35h="" mov="" cx,0035h="" ;0d19a="" b93500="" 5="" ;="" cx="0035h" ds="0000h" rep="" movsb="" ;0d19d="" f3a4="" pop="" si="" ;0d19f="" 5e="" ^="" push="" es="" ;0d1a0="" 06="" mov="" ax,3521h="" ;0d1a1="" b82135="" !5="" ;dos2-sys="" get="" al="" interrupt="" vector="" in="" es:bx="" ;int:="" 21h="" ax="3521h" cx="0035h" ds="0000h" int="" 21h="" ;0d1a4="" cd21="" !="" ;seg:="" ds="" change="" -="" indefinite="" pop="" ds="" ;0d1a6="" 1f="" cwd="" ;0d1a7="" 99="" mov="" di,0c47h="" ;0d1a8="" bf470c="" g="" mov="" [di],dx="" ;0d1ab="" 8915="" mov="" ds:[0487h],di="" ;0d1ad="" 893e8704="">
	mov	di,0082h		;0D1B1	BF8200
	mov	[di+06h],es		;0D1B4	8C4506		 E
	mov	[di+04h],bx		;0D1B7	895D04		 ]
	mov	[di+16h],es		;0D1BA	8C4516		 E
	mov	[di+14h],bx		;0D1BD	895D14		 ]
	mov	al,15h			;0D1C0	B015

;DOS2-SYS Get AL Interrupt Vector in ES:BX
;INT: 21h  ax=3515h cx=0035h di=0082h
	int	21h			;0D1C2	CD21		 !
	mov	[di+18h],bx		;0D1C4	895D18		 ]
	mov	[di+1Ah],es		;0D1C7	8C451A		 E
	call	H0000_CE81		;0D1CA	E8B4FC

	xor	cx,cx			;0D1CD	33C9		3
	call	H0000_CEB8		;0D1CF	E8E6FC

;SEG: CS Override
	mov	cs:[si-55h],es		;0D1D2	2E8C44AB	. D
H0000_D1D6:
	or	cx,cx			;0D1D6	0BC9
	jnz	H0000_D1E5		;0D1D8	750B		u
	mov	ax,ds			;0D1DA	8CD8
	inc	ax			;0D1DC	40		@
	cmp	ax,[di+01h]		;0D1DD	3B4501		;E
	jnz	H0000_D1E5		;0D1E0	7503		u
	mov	cx,ax			;0D1E2	8BC8
	push	ds			;0D1E4	1E
H0000_D1E5:

;SEG: CS Override
	cmp	Byte Ptr cs:[si+0FE14h],90h
					;0D1E5	2E80BC14FE90	.
	jz	H0000_D1F7		;0D1EB	740A		t
	cmp	Byte Ptr [di],5Ah	;0D1ED	803D5A		 =Z
	jnz	H0000_D207		;0D1F0	7515		u
	mov	ax,0EEF4h		;0D1F2	B8F4EE
	jmp	Short H0000_D215	;0D1F5	EB1E
;- - - - - - - - - - - - - - - - - - - -
H0000_D1F7:
	cmp	Word Ptr [di+0139h],0C402h
					;0D1F7	81BD390102C4	  9
	jnz	H0000_D207		;0D1FD	7508		u
	cmp	Word Ptr [di+013Bh],0F24h
					;0D1FF	81BD3B01240F	  ; $
	jz	H0000_D20E		;0D205	7407		t
H0000_D207:
	push	ds			;0D207	1E

;SEG: ES Change - Indefinite
	pop	es			;0D208	07
	call	H0000_CEAF		;0D209	E8A3FC

	jmp	Short H0000_D1D6	;0D20C	EBC8
;---------------------------------------
H0000_D20E:

;SEG: ES Override
	mov	Byte Ptr es:[di],5Ah	;0D20E	26C6055A	&  Z
	mov	[di+01h],cx		;0D212	894D01		 M
H0000_D215:
	pop	cx			;0D215	59		Y
	inc	cx			;0D216	41		A
	inc	ax			;0D217	40		@

;SEG: DS Change - Indefinite
	mov	ds,cx			;0D218	8ED9

;SEG: SP Change - Indefinite
;SEG: CS Override
	mov	cs:[si+0201h],cx	;0D21A	2E898C0102	.

;SEG: SP Change - Indefinite
;SEG: CS Override
	mov	cs:[si+023Fh],cx	;0D21F	2E898C3F02	.  ?

;SEG: SP Change - Indefinite
;SEG: CS Override
	mov	cs:[si+028Bh],cx	;0D224	2E898C8B02	.
	call	H0000_D3A9		;0D229	E87D01		 }

	mov	di,004Eh		;0D22C	BF4E00		 N
	call	H0000_D3AE		;0D22F	E87C01		 |

	mov	Word Ptr [di+06h],0BBDh ;0D232	C74506BD0B	 E
	push	ax			;0D237	50		P
	push	cs			;0D238	0E

;SEG: DS Change - 0000h
	pop	ds			;0D239	1F

;ASM: Synonym
;A	mov	Word Ptr [si-16h],Word Ptr 0000h
					;0D23A	C744EA0000	 D
       db      0C7h,44h,0EAh,00h,00h

	push	ax			;0D23F	50		P
	mov	ax,3501h		;0D240	B80135		  5

;DOS2-SYS Get AL Interrupt Vector in ES:BX
;INT: 21h  ax=3501h ds=0000h
	int	21h			;0D243	CD21		 !
	mov	di,bx			;0D245	8BFB
	mov	bp,es			;0D247	8CC5
	mov	ah,25h			;0D249	B425		 %

;SEG: SP Change - Indefinite
	lea	dx,[si-63h]		;0D24B	8D549D		 T

;DOS1-SYS Set AL Interrupt Vector in DS:DX
;INT: 21h  ax=2501h ds=0000h
	int	21h			;0D24E	CD21		 !

;SEG: ES Change - Indefinite
	pop	es			;0D250	07
	pushf				;0D251	9C
	pop	ax			;0D252	58		X
	or	ah,01h			;0D253	80CC01
	push	ax			;0D256	50		P
	popf				;0D257	9D
	mov	ah,30h			;0D258	B430		 0
	pushf				;0D25A	9C

;MEM: CALL  DWORD PTR ES:[0086H]

; ah=30h al=01h ds=0000h
	call	DWord Ptr es:[0086h]	;0D25B	26FF1E8600	&

	mov	ax,2501h		;0D260	B80125		  %
	mov	dx,di			;0D263	8BD7

;SEG: DS Change - Indefinite
	mov	ds,bp			;0D265	8EDD

;DOS1-SYS Set AL Interrupt Vector in DS:DX
;INT: 21h  ax=2501h
	int	21h			;0D267	CD21		 !
	push	cs			;0D269	0E

;SEG: DS Change - 0000h
	pop	ds			;0D26A	1F
	push	si			;0D26B	56		V

;ASM: Synonym
;A	add	si,-20h 		;0D26C	83C6E0
       db      83h,0C6h,0E0h

	mov	di,0086h		;0D26F	BF8600
	movsw				;0D272	A5
	movsw				;0D273	A5
	pop	si			;0D274	5E		^
	mov	ax,[si-16h]		;0D275	8B44EA		 D
	or	ax,ax			;0D278	0BC0
	jnz	H0000_D28B		;0D27A	750F		u
H0000_D27C:
	mov	ax,0C2Ah		;0D27C	B82A0C		 *

;SEG: DS Change - 0C2Ah
	mov	ds,ax			;0D27F	8ED8
	mov	dx,0005h		;0D281	BA0500
	mov	ax,2521h		;0D284	B82125		 !%

;DOS1-SYS Set AL Interrupt Vector in DS:DX
;INT: 21h  ax=2521h dx=0005h ds=0C2Ah di=0086h
	int	21h			;0D287	CD21		 !
	jmp	Short H0000_D2C6	;0D289	EB3B		 ;
;- - - - - - - - - - - - - - - - - - - -
H0000_D28B:
	xor	bx,bx			;0D28B	33DB		3
	dec	ax			;0D28D	48		H
	call	H0000_D391		;0D28E	E80001

	jz	H0000_D29B		;0D291	7408		t

;ASM: Synonym
;A	sub	ax,Word Ptr 0010h	;0D293	2D1000		-
       db      2Dh,10h,00h

	call	H0000_D391		;0D296	E8F800

	jnz	H0000_D27C		;0D299	75E1		u
H0000_D29B:
	cli				;0D29B	FA
	mov	bp,ds			;0D29C	8CDD
H0000_D29E:
	inc	bp			;0D29E	45		E

;SEG: DS Change - Indefinite
	mov	ds,bp			;0D29F	8EDD
	xor	bx,bx			;0D2A1	33DB		3
H0000_D2A3:

;SEG: CS Override
	mov	ax,cs:[si-20h]		;0D2A3	2E8B44E0	. D
	cmp	ax,[bx] 		;0D2A7	3B07		;
	jnz	H0000_D2BD		;0D2A9	7512		u

;SEG: CS Override
	mov	ax,cs:[si-1Eh]		;0D2AB	2E8B44E2	. D
	cmp	ax,[bx+02h]		;0D2AF	3B4702		;G
	jnz	H0000_D2BD		;0D2B2	7509		u

;ASM: Synonym
;A	mov	Word Ptr [bx],Word Ptr 0005h
					;0D2B4	C7070500
       db      0C7h,07h,05h,00h

	mov	Word Ptr [bx+02h],0C2Ah ;0D2B8	C747022A0C	 G *
H0000_D2BD:
	inc	bx			;0D2BD	43		C
	cmp	bl,10h			;0D2BE	80FB10
	jnz	H0000_D2A3		;0D2C1	75E0		u
	loop	H0000_D29E		;0D2C3	E2D9
	sti				;0D2C5	FB
H0000_D2C6:

;SEG: ES Change - Indefinite
	pop	es			;0D2C6	07
	push	cs			;0D2C7	0E

;SEG: DS Change - 0000h
	pop	ds			;0D2C8	1F
	mov	ah,1Ah			;0D2C9	B41A

;SEG: SP Change - Indefinite
	lea	dx,[si+0373h]		;0D2CB	8D947303	  s
	mov	bx,dx			;0D2CF	8BDA

;DOS1-DSK Set DTA in DS:DX (default is 0080h in PSP)
;INT: 21h  ah=1Ah ds=0000h
	int	21h			;0D2D1	CD21		 !
	mov	ah,4Eh			;0D2D3	B44E		 N
	mov	cx,0008h		;0D2D5	B90800

;SEG: SP Change - Indefinite
	lea	dx,[si-0Ch]		;0D2D8	8D54F4		 T

;DOS2-DSK Find First DS:DX File, CL=Attr
;INT: 21h  ah=4Eh cx=0008h ds=0000h
	int	21h			;0D2DB	CD21		 !
	mov	ax,[bx+16h]		;0D2DD	8B4716		 G
	mov	cx,[bx+18h]		;0D2E0	8B4F18		 O
	cmp	ax,6F55h		;0D2E3	3D556F		=Uo
	jnz	H0000_D2EE		;0D2E6	7506		u
	cmp	cx,1981h		;0D2E8	81F98119
	jz	H0000_D2F4		;0D2EC	7406		t
H0000_D2EE:

;SEG: ES Override
	mov	Byte Ptr es:[0127h],0EBh;0D2EE	26C6062701EB	&  '
H0000_D2F4:

;SEG: ES Override
	mov	Word Ptr es:[0F42h],ax	;0D2F4	26A3420F	& B

;SEG: ES Override
	mov	es:[0F48h],cx		;0D2F8	26890E480F	&  H
	push	es			;0D2FD	06

;SEG: DS Change - Indefinite
	pop	ds			;0D2FE	1F
	cmp	Byte Ptr ds:[0127h],0EBh;0D2FF	803E2701EB	 >'
	jz	H0000_D313		;0D304	740D		t
	mov	bx,0C2Ah		;0D306	BB2A0C		 *

;SEG: DS Change - 0C2Ah
	mov	ds,bx			;0D309	8EDB
	mov	ax,2515h		;0D30B	B81525		  %
	mov	dx,0053h		;0D30E	BA5300		 S

;DOS1-SYS Set AL Interrupt Vector in DS:DX
;INT: 21h  ax=2515h bx=0C2Ah cx=0008h dx=0053h ds=0C2Ah
	int	21h			;0D311	CD21		 !
H0000_D313:

;SEG: DS Change - Indefinite
	pop	ds			;0D313	1F
	xor	bx,bx			;0D314	33DB		3
H0000_D316:
	cmp	Word Ptr [bx],4F43h	;0D316	813F434F	 ?CO
	jnz	H0000_D323		;0D31A	7507		u
	cmp	Word Ptr [bx+06h],3D43h ;0D31C	817F06433D	   C=
	jz	H0000_D32B		;0D321	7408		t
H0000_D323:
	inc	bx			;0D323	43		C
	cmp	bh,08h			;0D324	80FF08
	jnz	H0000_D316		;0D327	75ED		u
	jmp	Short H0000_D336	;0D329	EB0B
;- - - - - - - - - - - - - - - - - - - -
H0000_D32B:
	lea	dx,[bx+08h]		;0D32B	8D5708		 W
	mov	ax,4300h		;0D32E	B80043		  C
	mov	bx,0FACEh		;0D331	BBCEFA

;DOS2-DSK CHMOD Get/Set DS:DX File CL Attrs: AL: 00=Get 01=Set
;INT: 21h  ax=4300h bx=FACEh cx=0008h dx=0053h
	int	21h			;0D334	CD21		 !
H0000_D336:

;MEM: Possible Data Area
;A	call	H0000_D339		;0D336	E80000
       db      0E8h,00h,00h

H0000_D339:
	pop	si			;0D339	5E		^
	xor	ax,ax			;0D33A	33C0		3

;SEG: SP Change - Indefinite
	lea	di,[si+0F136h]		;0D33C	8DBC36F1	  6
	mov	cx,076Bh		;0D340	B96B07		 k
	push	cs			;0D343	0E

;SEG: ES Change - 0000h
	pop	es			;0D344	07

; ax=0000h cx=076Bh es=0000h
	rep	stosw			;0D345	F3AB

;ASM: Synonym
;A	add	di,+4Dh 		;0D347	83C74D		  M
       db      83h,0C7h,4Dh

	mov	cx,005Eh		;0D34A	B95E00		 ^

; ax=0000h cx=005Eh es=0000h
	rep	stosb			;0D34D	F3AA
	mov	bx,12A8h		;0D34F	BBA812

;SEG: DS Change - 12A8h
	mov	ds,bx			;0D352	8EDB
	push	ds			;0D354	1E

;SEG: ES Change - 12A8h
	pop	es			;0D355	07
	mov	dx,0080h		;0D356	BA8000
	mov	ah,1Ah			;0D359	B41A

;DOS1-DSK Set DTA in DS:DX (default is 0080h in PSP)
;INT: 21h  ax=1A00h bx=12A8h cx=005Eh dx=0080h ds=12A8h es=12A8h
	int	21h			;0D35B	CD21		 !
	mov	al,01h			;0D35D	B001
	or	al,al			;0D35F	0AC0
	jz	H0000_D36C		;0D361	7409		t
	mov	Word Ptr ds:[0101h],16ADh
					;0D363	C7060101AD16
	push	cs			;0D369	0E
	jmp	Short H0000_D37E	;0D36A	EB12
;- - - - - - - - - - - - - - - - - - - -
H0000_D36C:
	cli				;0D36C	FA
	mov	ax,cs			;0D36D	8CC8
	sub	ax,0FAC0h		;0D36F	2DC0FA		-

;SEG: SS Change - Indefinite
	mov	ss,ax			;0D372	8ED0

;SEG: SP Change - 13D5h
	mov	sp,13D5h		;0D374	BCD513
	sti				;0D377	FB
	mov	ax,cs			;0D378	8CC8
	sub	ax,0FAC0h		;0D37A	2DC0FA		-
	push	ax			;0D37D	50		P
H0000_D37E:
	mov	ax,0100h		;0D37E	B80001
	push	ax			;0D381	50		P
	sti				;0D382	FB
	xor	ax,ax			;0D383	33C0		3
	mov	bx,ax			;0D385	8BD8
	mov	cx,ax			;0D387	8BC8
	cwd				;0D389	99
	mov	si,ax			;0D38A	8BF0
	mov	di,ax			;0D38C	8BF8
	mov	bp,ax			;0D38E	8BE8
	retf				;0D390	CB
;---------------------------------------
H0000_D391:

;SEG: DS Change - Indefinite
	mov	ds,ax			;0D391	8ED8
	cmp	Byte Ptr [bx],44h	;0D393	803F44		 ?D
	jz	H0000_D39D		;0D396	7405		t
	cmp	Byte Ptr [bx],4Dh	;0D398	803F4D		 ?M
	jnz	H0000_D3A8		;0D39B	750B		u
H0000_D39D:
	mov	ax,[bx+03h]		;0D39D	8B4703		 G
	cmp	ah,0A0h 		;0D3A0	80FCA0
	ja	H0000_D3A8		;0D3A3	7703		w
	xchg	ax,cx			;0D3A5	91
	xor	bp,bp			;0D3A6	33ED		3
H0000_D3A8:
	ret				;0D3A8	C3
;---------------------------------------
H0000_D3A9:
	mov	Word Ptr [di+06h],00F8h ;0D3A9	C74506F800	 E
H0000_D3AE:
	mov	Byte Ptr [di+05h],0EAh	;0D3AE	C64505EA	 E
	mov	[di+08h],ax		;0D3B2	894508		 E
	ret				;0D3B5	C3
;---------------------------------------
;MEM: Unreferenced Code
	db	01h			;0D3B6
	db	03h			;0D3B7
	dw	0200h			;0D3B8	0002
	dw	1CE8h			;0D3BA	E81C
	dw	0B900h			;0D3BC	00B9
	dw	0FA0h			;0D3BE	A00F
	dw	0CDBAh			;0D3C0	BACD
	dw	0B400h			;0D3C2	00B4
	db	"@"			;0D3C4	40
	dw	0FF9Ch			;0D3C5	9CFF
	dw	861Eh			;0D3C7	1E86
	dw	9C00h			;0D3C9	009C
	db	"PQ"			;0D3CB	5051
	dw	00B0h			;0D3CD	B000
	dw	95A2h			;0D3CF	A295
	dw	0E810h			;0D3D1	10E8
	dw	0004h			;0D3D3	0400
	db	"YX"			;0D3D5	5958
	db	9Dh			;0D3D7
	db	0C3h			;0D3D8
	dw	00B8h			;0D3D9	B800
	dw	0BF00h			;0D3DB	00BF
	db	"K"			;0D3DD	4B
	dw	0B910h			;0D3DE	10B9
	dw	0000h			;0D3E0	0000
	db	"1"			;0D3E2	31
	db	05h			;0D3E3
	db	05h			;0D3E4
	dw	0000h			;0D3E5	0000
	db	"GG"			;0D3E7	4747
	dw	0F7E2h			;0D3E9	E2F7
	db	0C3h			;0D3EB
	db	"2"			;0D3EC	32
	dw	0CFC0h			;0D3ED	C0CF
	db	0F3h			;0D3EF
	dw	0BAC0h			;0D3F0	C0BA
	db	85h			;0D3F2
	db	":o"			;0D3F3	3A6F
	dw	0F608h			;0D3F5	08F6
	db	"E]"			;0D3F7	455D
	dw	0E69Ch			;0D3F9	9CE6
	db	0EFh			;0D3FB
	dw	0E08Eh			;0D3FC	8EE0
	db	"$"			;0D3FE	24
	db	"o]L"			;0D3FF	6F5D4C
	dw	02B0h			;0D402	B002
	db	">"			;0D404	3E
	dw	87C8h			;0D405	C887
	db	9Dh			;0D407
	db	0ECh			;0D408
	db	"<g" ;0d409="" 3c47="" db="" 0c7h="" ;0d40b="" db="" 01h="" ;0d40c="" db="" 0c1h="" ;0d40d="" db="" 95h="" ;0d40e="" s00100="" ends="" end="" h0000_0100=""></g">