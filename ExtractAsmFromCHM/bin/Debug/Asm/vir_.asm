

  
PAGE  59,132
  
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;ÛÛ								         ÛÛ
;ÛÛ			        VIR				         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛ      Created:   4-Aug-89					         ÛÛ
;ÛÛ      Version:						         ÛÛ
;ÛÛ      Passes:    5	       Analysis Options on: none	         ÛÛ
;ÛÛ      Copyright (C) 1985 BORLAND Inc				         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
  
movseg		 macro reg16, unused, Imm16     ; Fixup for Assembler
		 ifidn	<reg16>, <bx>
		 db	0BBh
		 endif
		 ifidn	<reg16>, <cx>
		 db	0B9h
		 endif
		 ifidn	<reg16>, <dx>
		 db	0BAh
		 endif
		 ifidn	<reg16>, <si>
		 db	0BEh
		 endif
		 ifidn	<reg16>, <di>
		 db	0BFh
		 endif
		 ifidn	<reg16>, <bp>
		 db	0BDh
		 endif
		 ifidn	<reg16>, <sp>
		 db	0BCh
		 endif
		 ifidn	<reg16>, <bx>
		 db	0BBH
		 endif
		 ifidn	<reg16>, <cx>
		 db	0B9H
		 endif
		 ifidn	<reg16>, <dx>
		 db	0BAH
		 endif
		 ifidn	<reg16>, <si>
		 db	0BEH
		 endif
		 ifidn	<reg16>, <di>
		 db	0BFH
		 endif
		 ifidn	<reg16>, <bp>
		 db	0BDH
		 endif
		 ifidn	<reg16>, <sp>
		 db	0BCH
		 endif
		 dw	seg Imm16
endm
data_1e		equ	0			; (0000:0000=108Ah)
data_2e		equ	2			; (0000:0002=116h)
data_3e		equ	4			; (0000:0004=6F4h)
data_5e		equ	6			; (0000:0006=70h)
data_6e		equ	8			; (0000:0008=0C3h)
data_7e		equ	0Ah			; (0000:000A=0F000h)
data_8e		equ	0Ch			; (0000:000C=6F4h)
data_9e		equ	0Eh			; (0000:000E=70h)
data_10e	equ	12h			; (0000:0012=70h)
data_11e	equ	14h			; (0000:0014=0FF54h)
data_12e	equ	20h			; (0000:0020=6A3h)
data_13e	equ	8Ch			; (0000:008C=8F7h)
data_14e	equ	8Eh			; (0000:008E=319Dh)
data_15e	equ	0B6h			; (0000:00B6=16h)
data_16e	equ	15Ch			; (0000:015C=0A6h)
data_17e	equ	166h			; (0000:0166=0)
data_18e	equ	180h			; (0000:0180=0)
data_19e	equ	186h			; (0000:0186=0)
data_20e	equ	232h			; (0000:0232=0)
data_21e	equ	234h			; (0000:0234=0)
data_22e	equ	260h			; (0000:0260=0)
data_23e	equ	264h			; (0000:0264=0)
data_24e	equ	266h			; (0000:0266=0)
data_25e	equ	26Eh			; (0000:026E=0)
data_26e	equ	272h			; (0000:0272=0)
data_27e	equ	2C0h			; (0000:02C0=0)
data_28e	equ	2C1h			; (0000:02C1=0)
data_29e	equ	2C9h			; (0000:02C9=0)
data_30e	equ	2CBh			; (0000:02CB=0)
data_31e	equ	449h			; (0000:0449=3)
data_32e	equ	44Eh			; (0000:044E=0)
data_33e	equ	0E82Ah			; (0000:E82A=6)
data_34e	equ	0E8FFh			; (0000:E8FF=9Eh)
data_35e	equ	1			; (0274:0001=0CFh)
data_36e	equ	4			; (0274:0004=7587h)
data_37e	equ	8			; (0274:0008=60h)
data_38e	equ	0B6h			; (0274:00B6=82h)
data_39e	equ	13Ah			; (0274:013A=1BEBh)
data_40e	equ	13Ch			; (0274:013C=61Eh)
data_41e	equ	13Eh			; (0274:013E=0DB32h)
data_42e	equ	142h			; (0274:0142=0C52Eh)
data_43e	equ	180h			; (0274:0180=8Bh)
data_44e	equ	186h			; (0274:0186=1689h)
data_45e	equ	18Ch			; (0274:018C=8D0Ah)
data_46e	equ	194h			; (0274:0194=3)
data_47e	equ	232h			; (0274:0232=8BC0h)
data_48e	equ	260h			; (0274:0260=0FAC3h)
data_49e	equ	266h			; (0274:0266=8B52h)
data_50e	equ	26Eh			; (0274:026E=0C64Eh)
data_51e	equ	2A9h			; (0274:02A9=87h)
data_52e	equ	2AEh			; (0274:02AE=5503h)
data_53e	equ	2B0h			; (0274:02B0=8904h)
data_54e	equ	2C0h			; (0274:02C0=0C0h)
data_55e	equ	2C1h			; (0274:02C1=0FAC3h)
data_56e	equ	126Dh			; (0274:126D=1Eh)
data_57e	equ	0F87Eh			; (0274:F87E=0)
data_58e	equ	0			; (8875:0000=0FFh)
data_59e	equ	3			; (8875:0003=0FFFFh)
data_60e	equ	12h			; (8875:0012=0)
data_61e	equ	0			; (8876:0000=0)
data_63e	equ	2			; (8876:0002=0)
data_65e	equ	4			; (8876:0004=0)
data_67e	equ	6			; (8876:0006=0)
data_68e	equ	7			; (8876:0007=0)
data_69e	equ	8			; (8876:0008=0)
data_70e	equ	9			; (8876:0009=0)
data_71e	equ	0Ah			; (8876:000A=0)
data_73e	equ	0Eh			; (8876:000E=0)
data_74e	equ	10h			; (8876:0010=1FE6h)
data_75e	equ	12h			; (8876:0012=0)
data_77e	equ	16h			; (8876:0016=0)
data_78e	equ	18h			; (8876:0018=0)
data_80e	equ	1Ah			; (8876:001A=0)
data_82e	equ	1Ch			; (8876:001C=7600h)
data_84e	equ	1Eh			; (8876:001E=88h)
data_86e	equ	20h			; (8876:0020=0)
data_87e	equ	21h			; (8876:0021=0)
data_89e	equ	23h			; (8876:0023=1600h)
data_91e	equ	25h			; (8876:0025=1)
data_93e	equ	27h			; (8876:0027=0)
data_95e	equ	29h			; (8876:0029=0)
data_97e	equ	2Bh			; (8876:002B=0)
data_99e	equ	2Eh			; (8876:002E=0)
data_101e	equ	32h			; (8876:0032=0)
data_102e	equ	34h			; (8876:0034=0)
data_103e	equ	36h			; (8876:0036=0)
data_104e	equ	80h			; (8876:0080=0)
data_105e	equ	0B6h			; (8876:00B6=0)
data_107e	equ	0B8h			; (8876:00B8=0)
data_243e	equ	6ECDh			; (8876:6ECD=0)
data_244e	equ	9A8Bh			; (8876:9A8B=0)
data_245e	equ	9B9Ah			; (8876:9B9A=0)
data_246e	equ	0B0A5h			; (8876:B0A5=0)
data_247e	equ	0E82Ah			; (8876:E82A=0)
data_248e	equ	6F2h			; (B000:06F2=0FFh)
  
seg_a		segment	byte public
		assume	cs:seg_a, ds:seg_a
  
  
		org	100h
  
vir		proc	far
  
start:
		jmp	loc_595			; (3E47)
		db	 90h, 90h,0CDh,0ABh
copyright	db	'Copyright (C) 1985 BORLAND Inc'
		db	 02h, 04h, 00h,0B1h, 57h, 00h
		db	 3Ch, 33h
		db	9 dup (0)
data_111	dw	0
data_112	dw	0
data_113	dw	0
data_114	dw	0
data_115	dw	0
data_116	dw	0
data_117	dw	0
data_118	dw	0
		db	16 dup (0)
		db	 44h, 65h, 66h, 61h
data_119	dw	6C75h
data_120	db	74h
		db	20h
data_121	dw	6964h
data_122	dw	7073h
		db	 6Ch, 61h, 79h, 20h
data_123	dw	6F6Dh
data_124	db	64h
		db	65h
data_125	dw	1950h
data_127	dw	0FF01h
		db	 00h, 0Fh, 07h, 07h
data_129	dw	0F70h
data_131	dw	707h
data_132	dw	0E70h
data_133	dw	707h
data_134	dw	2E4Fh
data_135	dw	278Ah
data_136	dw	0E40Ah
data_137	db	0F9h
data_138	db	74h
data_139	dw	430Eh
data_140	dw	8A2Eh
data_141	dw	5007h
data_142	dw	0D8E8h
data_143	dw	5808h
data_144	dw	0CCFEh
data_145	dw	0F375h
data_146	dw	0C3F8h
data_147	dw	1D1h
data_148	db	0FFh
data_149	dw	87Bh, 33C0h
  
vir		endp
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_1		proc	near
		mov	word ptr ds:data_75e,6Eh	; (8876:0012=0)
		mov	cs:data_148,0		; (8876:0194=0FFh)
		mov	si,data_12e		; (0000:0020=0A3h)
		mov	ax,es:[si]
		mov	cs:data_149,ax		; (8876:0195=87Bh)
		mov	ax,es:[si+2]
		mov	word ptr cs:data_149+2,ax	; (8876:0197=33C0h)
		cli				; Disable interrupts
		mov	word ptr es:[si],1C4h
		mov	es:[si+2],cs
		sti				; Enable interrupts
		jmp	short loc_5		; (01E6)
		push	ds
		push	ax
		xor	ax,ax			; Zero register
		mov	ds,ax
		mov	word ptr ds:data_12e,1DBh	; (0000:0020=6A3h)
		mov	cs:data_147,ax		; (8876:0192=1D1h)
		pop	ax
		pop	ds
		jmp	dword ptr cs:data_149	; (8876:0195=87Bh)
		mov	cs:data_148,0FFh	; (8876:0194=0FFh)
		jmp	dword ptr cs:data_149	; (8876:0195=87Bh)
loc_5:
;*		call	sub_2			;*(021D)
		db	0E8h, 34h, 00h
		inc	cs:data_147		; (8876:0192=1D1h)
		cmp	cs:data_148,0FFh	; (8876:0194=0FFh)
		jne	loc_5			; Jump if not equal
		mov	ax,word ptr cs:data_149+2	; (8876:0197=33C0h)
		cli				; Disable interrupts
		mov	es:[si+2],ax
		mov	ax,cs:data_149		; (8876:0195=87Bh)
		mov	es:[si],ax
		sti				; Enable interrupts
		mov	ax,cs:data_147		; (8876:0192=1D1h)
		add	ax,ax
		mov	ds:data_75e,ax		; (8876:0012=0)
		retn
sub_1		endp
  
		db	8Bh
data_173	dw	8BC3h
data_175	dw	0E3C8h
data_177	dw	0E805h
data_178	dw	3
data_179	dw	0FBE2h
data_180	dw	51C3h
data_181	dw	0E8Bh
data_182	dw	12h
  
locloop_6:
		loop	locloop_6		; Loop if cx > 0
  
		pop	cx
		retn
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_3		proc	near
		push	bp
		mov	ah,0Fh
		int	10h			; Video display   ah=functn 0Fh
						;  get state, al=mode, bh=page
		pop	bp
		cmp	al,ds:data_5e		; (0000:0006=70h)
		je	loc_7			; Jump if equal
		mov	al,ds:data_5e		; (0000:0006=70h)
		jmp	loc_11			; (02D9)
loc_7:
		push	bp
		mov	ax,600h
		mov	bh,ds:data_6e		; (0000:0008=0C3h)
		mov	cx,ds:data_3e		; (0000:0004=6F4h)
		mov	dx,cs:data_125		; (8876:016A=1950h)
		dec	dh
		dec	dl
		int	10h			; Video display   ah=functn 06h
						;  scroll up, al=lines
		mov	ah,2
		mov	dx,ds:data_3e		; (0000:0004=6F4h)
		xor	bh,bh			; Zero register
		int	10h			; Video display   ah=functn 02h
						;  set cursor location in dx
		pop	bp
		retn
		db	 53h, 51h, 52h, 55h,0E8h
data_194	dw	41h
		db	0B4h, 06h
loc_8:
		mov	al,1
		mov	bh,ds:data_37e		; (0274:0008=60h)
		mov	ch,dh
		mov	cl,ds:data_36e		; (0274:0004=87h)
		mov	dx,cs:data_125		; (8876:016A=1950h)
		dec	dh
		dec	dl
		cmp	ch,dh
		jne	loc_9			; Jump if not equal
		xor	al,al			; Zero register
loc_9:
		int	10h			; Video display   ah=functn 07h
						;  scroll down, al=lines
		pop	bp
		pop	dx
		pop	cx
		pop	bx
		retn
		push	bx
		push	cx
		push	dx
		push	bp
		call	sub_4			; (02A3)
		mov	ah,7
		jmp	short loc_8		; (0264)
		push	ax
		mov	al,ds:data_35e		; (0274:0001=0CFh)
		mov	ds:data_37e,al		; (0274:0008=60h)
		pop	ax
		retn
loc_10:
		push	ax
		mov	al,ds:data_61e		; (8876:0000=0)
		mov	ds:data_69e,al		; (8876:0008=0)
		pop	ax
		retn
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_4:
		mov	ah,3
		xor	bh,bh			; Zero register
		int	10h			; Video display   ah=functn 03h
						;  get cursor loc in dx, mode cx
		retn
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_5:
		push	bx
		push	cx
		push	dx
		push	bp
		call	sub_4			; (02A3)
		mov	ax,600h
		mov	bh,ds:data_69e		; (8876:0008=0)
		mov	cx,dx
		mov	dl,byte ptr cs:data_125	; (8876:016A=50h)
		dec	dl
		int	10h			; Video display   ah=functn 06h
						;  scroll up, al=lines
		pop	bp
		pop	dx
		pop	cx
		pop	bx
		retn
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_6:
		call	sub_17			; (05C3)
		mov	al,byte ptr cs:data_127+1	; (8876:016D=0FFh)
		cmp	al,0FFh
		jne	loc_11			; Jump if not equal
		push	bp
		mov	ah,0Fh
		int	10h			; Video display   ah=functn 0Fh
						;  get state, al=mode, bh=page
		pop	bp
loc_11:
		mov	byte ptr ds:data_65e,0	; (8876:0004=0)
		mov	byte ptr ds:data_65e+1,0	; (8876:0005=0)
		mov	byte ptr ds:data_70e,0FFh	; (8876:0009=0)
		cmp	al,7
		mov	bh,50h			; 'P'
		mov	bl,0
		mov	si,16Fh
		jz	loc_14			; Jump if zero
		mov	si,177h
		cmp	al,2
		je	loc_13			; Jump if equal
		cmp	al,4
		jb	loc_12			; Jump if below
		mov	al,3
loc_12:
		mov	bl,0FFh
		cmp	al,3
		je	loc_14			; Jump if equal
		mov	bh,28h			; '('
		cmp	al,1
		je	loc_14			; Jump if equal
		xor	al,al			; Zero register
		mov	bl,0
loc_13:
		mov	si,offset data_129+1	; (8876:0173=0Fh)
loc_14:
		mov	ds:data_67e,al		; (8876:0006=0)
		mov	ds:data_68e,bl		; (8876:0007=0)
		mov	byte ptr cs:data_125,bh	; (8876:016A=50h)
		mov	ax,cs:[si]
		mov	ds:data_61e,ax		; (8876:0000=0)
		mov	ax,cs:[si+2]
		mov	ds:data_63e,ax		; (8876:0002=0)
		push	bp
		mov	ah,0Fh
		int	10h			; Video display   ah=functn 0Fh
						;  get state, al=mode, bh=page
		cmp	al,ds:data_67e		; (8876:0006=0)
		je	loc_15			; Jump if equal
		mov	al,ds:data_67e		; (8876:0006=0)
		xor	ah,ah			; Zero register
		int	10h			; Video display   ah=functn 00h
						;  set display mode in al
loc_15:
		pop	bp
		jmp	loc_10			; (029A)
sub_3		endp
  
		db	0C3h
loc_16:
		push	ax
		push	bx
		push	cx
		push	dx
		push	si
		push	di
		push	bp
		pushf				; Push flags
		xchg	dl,dh
		add	dx,ds:data_36e		; (0274:0004=7587h)
		cmp	dh,byte ptr cs:data_125+1	; (8876:016B=19h)
		jae	loc_17			; Jump if above or =
		cmp	dl,byte ptr cs:data_125	; (8876:016A=50h)
		jae	loc_17			; Jump if above or =
		mov	ah,2
		xor	bh,bh			; Zero register
		int	10h			; Video display   ah=functn 02h
						;  set cursor location in dx
loc_17:
		popf				; Pop flags
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
  
sub_7		proc	near
		jmp	loc_96			; (0AA0)
sub_7		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_8		proc	near
		call	sub_4			; (02A3)
		mov	al,dl
		sub	al,ds:data_3e		; (0000:0004=0F4h)
		inc	al
		xor	ah,ah			; Zero register
		retn
sub_8		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_9		proc	near
		call	sub_4			; (02A3)
		mov	al,dh
		sub	al,byte ptr ds:data_3e+1	; (0000:0005=6)
		inc	al
		xor	ah,ah			; Zero register
		retn
sub_9		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_10		proc	near
		pop	bx
		cmp	al,19h
		ja	loc_18			; Jump if above
		mov	byte ptr cs:data_125+1,al	; (8876:016B=19h)
loc_18:
		pop	ax
		cmp	al,50h			; 'P'
		ja	loc_19			; Jump if above
		mov	byte ptr cs:data_125,al	; (8876:016A=50h)
loc_19:
		pop	ax
		cmp	al,byte ptr cs:data_125+1	; (8876:016B=19h)
		jae	loc_20			; Jump if above or =
		dec	al
		mov	byte ptr ds:data_65e+1,al	; (8876:0005=0)
loc_20:
		pop	ax
		cmp	al,byte ptr cs:data_125	; (8876:016A=50h)
		jae	loc_21			; Jump if above or =
		dec	al
		mov	ds:data_65e,al		; (8876:0004=0)
loc_21:
		jmp	bx			;*Register jump
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_11:
		and	al,1Fh
		test	al,10h
		jz	loc_22			; Jump if zero
		and	al,0Fh
		or	al,80h
loc_22:
		and	byte ptr ds:data_6e,70h	; (0000:0008=0C3h) 'p'
		or	ds:data_6e,al		; (0000:0008=0C3h)
		retn
sub_10		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_12		proc	near
		and	al,7
		mov	cl,4
		shl	al,cl			; Shift w/zeros fill
		and	byte ptr ds:data_69e,8Fh	; (8876:0008=0)
		or	ds:data_69e,al		; (8876:0008=0)
		retn
sub_12		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_13		proc	near
loc_23:
		push	bp
		mov	word ptr ds:data_71e+2,ax	; (8876:000C=8876h)
		mov	word ptr ds:data_71e,0	; (8876:000A=0)
		mov	word ptr ds:data_73e,0	; (8876:000E=0)
		mov	word ptr ds:data_74e,0C7h	; (8876:0010=1FE6h)
		mov	al,ds:data_70e		; (8876:0009=0)
		xor	ah,ah			; Zero register
		int	10h			; Video display   ah=functn 00h
						;  set display mode in al
		xor	bx,bx			; Zero register
		mov	ds:data_86e,bl		; (8876:0020=0)
		mov	ah,0Bh
		int	10h			; Video display   ah=functn 0Bh
						;  set color from bx (CGA modes)
		inc	bh
		mov	ah,0Bh
		int	10h			; Video display   ah=functn 0Bh
						;  set color from bx (CGA modes)
		pop	bp
		retn
sub_13		endp
  
		db	0C6h, 06h, 09h, 00h, 04h
loc_24:
		mov	ax,13Fh
		jmp	short loc_23		; (03DF)
		mov	byte ptr ds:data_70e,5	; (8876:0009=0)
		jmp	short loc_24		; (0413)
		mov	byte ptr ds:data_70e,6	; (8876:0009=0)
		mov	ax,27Fh
		call	sub_13			; (03DF)
		mov	ax,0Fh
		jmp	short loc_28		; (0475)
		and	al,0Fh
		mov	ah,ds:data_86e		; (8876:0020=0)
		and	ah,10h
		or	al,ah
		mov	ds:data_86e,al		; (8876:0020=0)
loc_25:
		push	bp
		xor	bh,bh			; Zero register
		mov	bl,ds:data_86e		; (8876:0020=0)
		mov	ah,0Bh
		int	10h			; Video display   ah=functn 0Bh
						;  set color from bx (CGA modes)
		pop	bp
		retn
		push	bp
		mov	bl,ds:data_86e		; (8876:0020=0)
		and	bl,0EFh
		mov	ah,2
		cmp	byte ptr ds:data_70e,4	; (8876:0009=0)
		je	loc_26			; Jump if equal
		mov	ah,1
loc_26:
		cmp	al,ah
		jb	loc_27			; Jump if below
		sub	al,ah
		or	bl,10h
loc_27:
		mov	ds:data_86e,bl		; (8876:0020=0)
		mov	bh,1
		mov	bl,al
		mov	ah,0Bh
		int	10h			; Video display   ah=functn 0Bh
						;  set color from bx (CGA modes)
		pop	bp
		jmp	short loc_25		; (043D)
loc_28:
		push	bp
		mov	bx,ax
		mov	ah,0Bh
		int	10h			; Video display   ah=functn 0Bh
						;  set color from bx (CGA modes)
		pop	bp
		retn
		pop	bx
		mov	cx,27Fh
		cmp	byte ptr ds:data_70e,6	; (8876:0009=0)
		je	loc_29			; Jump if equal
		mov	cx,13Fh
loc_29:
		cmp	ax,0C7h
		ja	loc_30			; Jump if above
		mov	ds:data_74e,ax		; (8876:0010=1FE6h)
loc_30:
		pop	ax
		cmp	ax,cx
		ja	loc_31			; Jump if above
		mov	word ptr ds:data_71e+2,ax	; (8876:000C=8876h)
loc_31:
		pop	ax
		cmp	ax,ds:data_74e		; (8876:0010=1FE6h)
		jae	loc_32			; Jump if above or =
		mov	ds:data_73e,ax		; (8876:000E=0)
loc_32:
		pop	ax
		cmp	ax,word ptr ds:data_71e+2	; (8876:000C=8876h)
		jae	loc_33			; Jump if above or =
		mov	ds:data_71e,ax		; (8876:000A=0)
loc_33:
		jmp	bx			;*
		pop	bx
		pop	dx
		pop	cx
		push	bx
		mov	ah,0Ch
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_14		proc	near
		or	cx,cx			; Zero ?
		js	loc_ret_34		; Jump if sign=1
		add	cx,ds:data_71e		; (8876:000A=0)
		cmp	cx,word ptr ds:data_71e+2	; (8876:000C=8876h)
		ja	loc_ret_34		; Jump if above
		or	dx,dx			; Zero ?
		js	loc_ret_34		; Jump if sign=1
		add	dx,ds:data_73e		; (8876:000E=0)
		cmp	dx,ds:data_74e		; (8876:0010=1FE6h)
		ja	loc_ret_34		; Jump if above
		push	bp
		int	10h			; Video display   ah=functn 00h
						;  set display mode in al
		pop	bp
  
loc_ret_34:
		retn
sub_14		endp
  
		mov	ah,0Ch
		mov	word ptr ds:data_75e+2,ax	; (8876:0014=0)
		pop	di
		pop	ax
		pop	dx
		pop	bx
		mov	ds:data_82e,bx		; (8876:001C=7600h)
		call	sub_15			; (057D)
		mov	ds:data_78e,cx		; (8876:0018=0)
		call	sub_58			; (10D3)
		xchg	ax,dx
		pop	bx
		push	di
		mov	ds:data_80e,bx		; (8876:001A=0)
		call	sub_15			; (057D)
		mov	ds:data_77e,cx		; (8876:0016=0)
		call	sub_58			; (10D3)
		mov	bx,ax
		cmp	bx,dx
		jle	loc_38			; Jump if < or="mov" ax,dx="" add="" ax,ax="" sub="" ax,bx="" mov="" ds:data_84e,ax="" ;="" (8876:001e="88h)" mov="" cx,bx="" inc="" cx="" locloop_35:="" call="" sub_16="" ;="" (0589)="" mov="" ax,ds:data_84e="" ;="" (8876:001e="88h)" or="" ax,ax="" ;="" zero="" jle="" loc_36="" ;="" jump="" if="">< or="add" ax,dx="" add="" ax,dx="" sub="" ax,bx="" sub="" ax,bx="" mov="" ds:data_84e,ax="" ;="" (8876:001e="88h)" mov="" ax,ds:data_78e="" ;="" (8876:0018="0)" add="" ds:data_82e,ax="" ;="" (8876:001c="7600h)" jmp="" short="" loc_37="" ;="" (0538)="" loc_36:="" add="" ax,dx="" add="" ax,dx="" mov="" ds:data_84e,ax="" ;="" (8876:001e="88h)" loc_37:="" mov="" ax,ds:data_77e="" ;="" (8876:0016="0)" add="" ds:data_80e,ax="" ;="" (8876:001a="0)" loop="" locloop_35="" ;="" loop="" if="" cx=""> 0
  
		retn
loc_38:
		mov	ax,bx
		add	ax,ax
		sub	ax,dx
		mov	ds:data_84e,ax		; (8876:001E=88h)
		mov	cx,dx
		inc	cx
  
locloop_39:
		call	sub_16			; (0589)
		mov	ax,ds:data_84e		; (8876:001E=88h)
		or	ax,ax			; Zero ?
		jle	loc_40			; Jump if < or="add" ax,bx="" add="" ax,bx="" sub="" ax,dx="" sub="" ax,dx="" mov="" ds:data_84e,ax="" ;="" (8876:001e="88h)" mov="" ax,ds:data_77e="" ;="" (8876:0016="0)" add="" ds:data_80e,ax="" ;="" (8876:001a="0)" jmp="" short="" loc_41="" ;="" (0573)="" loc_40:="" add="" ax,bx="" add="" ax,bx="" mov="" ds:data_84e,ax="" ;="" (8876:001e="88h)" loc_41:="" mov="" ax,ds:data_78e="" ;="" (8876:0018="0)" add="" ds:data_82e,ax="" ;="" (8876:001c="7600h)" loop="" locloop_39="" ;="" loop="" if="" cx=""> 0
  
		retn
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_15		proc	near
		xor	cx,cx			; Zero register
		sub	ax,bx
		jz	loc_ret_43		; Jump if zero
		js	loc_42			; Jump if sign=1
		inc	cx
		retn
loc_42:
		dec	cx
  
loc_ret_43:
		retn
sub_15		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_16		proc	near
		push	cx
		push	dx
		mov	ax,word ptr ds:data_75e+2	; (8876:0014=0)
		mov	cx,ds:data_80e		; (8876:001A=0)
		mov	dx,ds:data_82e		; (8876:001C=7600h)
		call	sub_14			; (04B8)
		pop	dx
		pop	cx
		retn
sub_16		endp
  
		mov	bx,ax
		mov	ax,34DDh
		mov	dx,12h
		cmp	dx,bx
		jae	loc_ret_45		; Jump if above or =
		div	bx			; ax,dx rem=dx:ax/reg
		mov	bx,ax
		in	al,61h			; port 61h, 8255 port B, read
		test	al,3
		jnz	loc_44			; Jump if not zero
		or	al,3
		out	61h,al			; port 61h, 8255 B - spkr, etc
		mov	al,0B6h
		out	43h,al			; port 43h, 8253 wrt timr mode
loc_44:
		mov	al,bl
		out	42h,al			; port 42h, 8253 timer 2 spkr
		mov	al,bh
		out	42h,al			; port 42h, 8253 timer 2 spkr
  
loc_ret_45:
		retn
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_17		proc	near
		in	al,61h			; port 61h, 8255 port B, read
		and	al,0FCh
		out	61h,al			; port 61h, 8255 B - spkr, etc
						;  al = 0, disable parity
		retn
sub_17		endp
  
		db	 91h, 5Bh, 5Fh,0EBh, 29h
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_18		proc	near
loc_46:
		push	ax
		push	cx
		mov	cl,4
		shr	ax,cl			; Shift w/zeros fill
		add	bx,ax
		pop	cx
		pop	ax
		and	ax,0Fh
		retn
sub_18		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_19		proc	near
		cmp	bx,dx
		jne	loc_ret_47		; Jump if not equal
		cmp	ax,cx
  
loc_ret_47:
		retn
sub_19		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_20		proc	near
		add	ax,cx
		add	bx,dx
		jmp	short loc_46		; (05CF)
sub_20		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_21		proc	near
		mov	ax,es:[di+4]
		mov	bx,es:[di+6]
		push	ax
		or	ax,bx
		pop	ax
		retn
sub_21		endp
  
		pop	bx
		pop	es
		push	bx
		mov	word ptr ds:data_91e+1,di	; (8876:0026=0)
		mov	word ptr ds:data_93e+1,es	; (8876:0028=0)
		mov	ax,cx
		add	ax,7
		mov	bx,1000h
		jc	loc_48			; Jump if carry Set
		xor	bx,bx			; Zero register
loc_48:
		and	al,0F8h
		call	sub_18			; (05CF)
		mov	cx,ax
		mov	dx,bx
		mov	word ptr ds:data_99e,22h	; (8876:002E=0)
		mov	word ptr ds:data_99e+2,ds	; (8876:0030=8876h)
		les	di,dword ptr ds:data_87e+1	; (8876:0022=0) Load 32 bit ptr
loc_49:
		call	sub_21			; (05EA)
		jz	loc_52			; Jump if zero
		call	sub_19			; (05DD)
		jnc	loc_50			; Jump if carry=0
		mov	ds:data_99e,di		; (8876:002E=0)
		mov	word ptr ds:data_99e+2,es	; (8876:0030=8876h)
		les	di,dword ptr es:[di]	; Load 32 bit ptr
		jmp	short loc_49		; (0625)
loc_50:
		call	sub_22			; (06B2)
		jz	loc_51			; Jump if zero
		sub	ax,cx
		sbb	bx,dx
		and	ax,0Fh
		jmp	short loc_54		; (0680)
loc_51:
		les	di,dword ptr es:[di]	; Load 32 bit ptr
		jmp	short loc_55		; (06A3)
loc_52:
		call	sub_22			; (06B2)
		mov	ax,di
		mov	bx,es
		call	sub_20			; (05E4)
		mov	data_143,ax		; (8876:018A=5808h)
		mov	data_144,bx		; (8876:018C=0CCFEh)
		push	cx
		push	dx
		mov	cx,ax
		mov	dx,bx
		mov	ax,sp
		mov	bx,ss
		sub	bx,0Eh
		call	sub_18			; (05CF)
		xor	ax,ax			; Zero register
		call	sub_19			; (05DD)
		pop	dx
		pop	cx
		ja	loc_53			; Jump if above
		jmp	loc_144			; (0FEB)
loc_53:
		xor	ax,ax			; Zero register
		xor	bx,bx			; Zero register
loc_54:
		push	bx
		push	ax
		push	word ptr es:[di+2]
		push	word ptr es:[di]
		mov	ax,di
		mov	bx,es
		call	sub_20			; (05E4)
		mov	di,ax
		mov	es,bx
		pop	word ptr es:[di]
		pop	word ptr es:[di+2]
		pop	word ptr es:[di+4]
		pop	word ptr es:[di+6]
loc_55:
		push	es
		push	es
		les	si,dword ptr ds:data_99e	; (8876:002E=0) Load 32 bit ptr
		mov	es:[si],di
		pop	word ptr es:[si+2]
		pop	es
		retn
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_22		proc	near
		push	es
		push	es
		les	si,dword ptr ds:data_91e+1	; (8876:0026=0) Load 32 bit ptr
		mov	es:[si],di
		pop	word ptr es:[si+2]
		pop	es
		retn
sub_22		endp
  
		xchg	ax,cx
		pop	bx
		pop	di
		jmp	short loc_56		; (06C7)
		db	5Bh
loc_56:
		pop	es
		push	bx
		mov	ax,cx
		mov	cx,es:[di]
		mov	dx,es:[di+2]
		add	ax,7
		mov	bx,1000h
		jc	loc_57			; Jump if carry Set
		xor	bx,bx			; Zero register
loc_57:
		and	al,0F8h
		call	sub_18			; (05CF)
		mov	word ptr ds:data_95e+1,ax	; (8876:002A=0)
		mov	word ptr ds:data_97e+1,bx	; (8876:002C=0)
		les	di,dword ptr ds:data_87e+1	; (8876:0022=0) Load 32 bit ptr
		mov	ax,di
		mov	bx,es
		call	sub_19			; (05DD)
		jnc	loc_61			; Jump if carry=0
loc_58:
		mov	ax,es:[di]
		mov	bx,es:[di+2]
		call	sub_19			; (05DD)
		jnc	loc_59			; Jump if carry=0
		mov	di,ax
		mov	es,bx
		jmp	short loc_58		; (06F5)
loc_59:
		push	es
		mov	si,cx
		mov	es,dx
		push	word ptr ds:data_97e+1	; (8876:002C=0)
		push	word ptr ds:data_95e+1	; (8876:002A=0)
		mov	es:[si],ax
		mov	es:[si+2],bx
		pop	word ptr es:[si+4]
		pop	word ptr es:[si+6]
		pop	es
		mov	es:[di],cx
		mov	es:[di+2],dx
		mov	ax,es:[di+4]
		mov	bx,es:[di+6]
		call	sub_23			; (0772)
		jz	loc_60			; Jump if zero
		les	di,dword ptr es:[di]	; Load 32 bit ptr
loc_60:
		mov	ax,es:[di+4]
		mov	bx,es:[di+6]
		mov	cx,es:[di]
		mov	dx,es:[di+2]
		jmp	short loc_62		; (0772)
loc_61:
		mov	word ptr ds:data_87e+1,cx	; (8876:0022=0)
		mov	word ptr ds:data_89e+1,dx	; (8876:0024=116h)
		mov	di,cx
		mov	es,dx
		mov	es:[di],ax
		mov	es:[di+2],bx
		mov	cx,ax
		mov	dx,bx
		mov	ax,word ptr ds:data_95e+1	; (8876:002A=0)
		mov	bx,word ptr ds:data_97e+1	; (8876:002C=0)
		mov	es:[di+4],ax
		mov	es:[di+6],bx
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_23		proc	near
loc_62:
		mov	ds:data_101e,ax		; (8876:0032=0)
		mov	ds:data_102e,bx		; (8876:0034=0)
		add	ax,di
		mov	bx,es
		add	bx,ds:data_102e		; (8876:0034=0)
		call	sub_18			; (05CF)
		call	sub_19			; (05DD)
		jnz	loc_ret_64		; Jump if not zero
		mov	ax,data_143		; (8876:018A=5808h)
		mov	bx,data_144		; (8876:018C=0CCFEh)
		call	sub_19			; (05DD)
		jz	loc_63			; Jump if zero
		push	es
		mov	si,cx
		mov	es,dx
		mov	ax,es:[si]
		mov	bx,es:[si+2]
		mov	cx,es:[si+4]
		mov	dx,es:[si+6]
		pop	es
		mov	es:[di],ax
		mov	es:[di+2],bx
		mov	ax,ds:data_101e		; (8876:0032=0)
		mov	bx,ds:data_102e		; (8876:0034=0)
		call	sub_20			; (05E4)
		mov	es:[di+4],ax
		mov	es:[di+6],bx
		xor	ax,ax			; Zero register
		retn
loc_63:
		mov	data_143,di		; (8876:018A=5808h)
		mov	data_144,es		; (8876:018C=0CCFEh)
		push	di
		xor	ax,ax			; Zero register
		cld				; Clear direction
		mov	cx,4
		rep	stosw			; Rep when cx >0 Store ax to es:[di]
		pop	di
		xor	ax,ax			; Zero register
  
loc_ret_64:
		retn
sub_23		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_24		proc	near
		xor	cx,cx			; Zero register
		xor	dx,dx			; Zero register
		xor	si,si			; Zero register
		les	di,dword ptr ds:data_87e+1	; (8876:0022=0) Load 32 bit ptr
loc_65:
		call	sub_21			; (05EA)
		jz	loc_66			; Jump if zero
		call	sub_25			; (080A)
		les	di,dword ptr es:[di]	; Load 32 bit ptr
		jmp	short loc_65		; (07E5)
loc_66:
		mov	ax,sp
		mov	bx,ss
		sub	bx,10h
		call	sub_18			; (05CF)
		xor	ax,ax			; Zero register
		sub	bx,data_144		; (8876:018C=0CCFEh)
		jc	loc_67			; Jump if carry Set
		call	sub_25			; (080A)
loc_67:
		mov	ax,dx
		retn
sub_24		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_25		proc	near
		cmp	si,bx
		jae	loc_68			; Jump if above or =
		mov	si,bx
loc_68:
		call	sub_20			; (05E4)
		mov	cx,ax
		mov	dx,bx
		retn
sub_25		endp
  
		call	sub_24			; (07DB)
		mov	ax,si
		retn
		pop	bx
		pop	es
		mov	ax,data_143		; (8876:018A=5808h)
		mov	es:[di],ax
		mov	dx,data_144		; (8876:018C=0CCFEh)
		mov	es:[di+2],dx
		jmp	bx			;*
		pop	bx
		pop	es
		les	di,dword ptr es:[di]	; Load 32 bit ptr
		mov	data_143,di		; (8876:018A=5808h)
		mov	word ptr ds:data_87e+1,di	; (8876:0022=0)
		mov	data_144,es		; (8876:018C=0CCFEh)
		mov	word ptr ds:data_89e+1,es	; (8876:0024=116h)
		xor	ax,ax			; Zero register
		les	di,dword ptr ds:data_87e+1	; (8876:0022=0) Load 32 bit ptr
		mov	cx,4
		cld				; Clear direction
		rep	stosw			; Rep when cx >0 Store ax to es:[di]
		jmp	bx			;*Register jump
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_26		proc	near
		cmp	byte ptr data_147,0	; (8876:0192=0D1h)
		mov	al,0FFh
		jnz	loc_69			; Jump if not zero
		mov	ah,1
		int	16h			; Keyboard i/o  ah=function 01h
						;  get status, if zf=0  al=char
		mov	al,0
		jz	loc_69			; Jump if zero
		dec	al
loc_69:
		and	ax,1
		retn	1
sub_26		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_27		proc	near
		mov	al,byte ptr data_147	; (8876:0192=0D1h)
		mov	byte ptr data_147,0	; (8876:0192=0D1h)
		or	al,al			; Zero ?
		jnz	loc_71			; Jump if not zero
		xor	ah,ah			; Zero register
		int	16h			; Keyboard i/o  ah=function 00h
						;  get keybd char in al, ah=scan
		or	al,al			; Zero ?
		jnz	loc_70			; Jump if not zero
		mov	byte ptr data_147,ah	; (8876:0192=0D1h)
		mov	al,1Bh
		or	ah,ah			; Zero ?
		jnz	loc_71			; Jump if not zero
		mov	al,3
loc_70:
		cmp	data_148,1		; (8876:0194=0FFh)
		jne	loc_71			; Jump if not equal
		cmp	al,3
		jne	loc_71			; Jump if not equal
		jmp	loc_147			; (1016)
loc_71:
		xor	ah,ah			; Zero register
		retn	1
sub_27		endp
  
		pop	ax
		pop	dx
		push	ax
		push	dx
		push	bp
		push	dx
		call	sub_4			; (02A3)
		pop	ax
		cmp	al,0Dh
		jne	loc_72			; Jump if not equal
		mov	dl,ds:data_65e		; (8876:0004=0)
		jmp	short loc_77		; (091B)
loc_72:
		cmp	al,0Ah
		jne	loc_73			; Jump if not equal
		inc	dh
		cmp	dh,byte ptr cs:data_125+1	; (8876:016B=19h)
		jb	loc_77			; Jump if below
		jmp	short loc_76		; (0901)
loc_73:
		cmp	al,8
		jne	loc_74			; Jump if not equal
		cmp	dl,ds:data_65e		; (8876:0004=0)
		je	loc_77			; Jump if equal
		dec	dl
		jmp	short loc_77		; (091B)
loc_74:
		cmp	al,7
		jne	loc_75			; Jump if not equal
		mov	ah,0Eh
		xor	bh,bh			; Zero register
		int	10h			; Video display   ah=functn 0Eh
						;  write char al, teletype mode
		jmp	short loc_78		; (0921)
loc_75:
		push	dx
		mov	ah,9
		xor	bh,bh			; Zero register
		mov	cx,1
		mov	bl,ds:data_69e		; (8876:0008=0)
		int	10h			; Video display   ah=functn 09h
						;  set char al & attrib bl @curs
		pop	dx
		inc	dl
		cmp	dl,byte ptr cs:data_125	; (8876:016A=50h)
		jb	loc_77			; Jump if below
		mov	dl,ds:data_65e		; (8876:0004=0)
		inc	dh
		cmp	dh,byte ptr cs:data_125+1	; (8876:016B=19h)
		jb	loc_77			; Jump if below
loc_76:
		dec	dh
		push	dx
		mov	ax,601h
		mov	bh,ds:data_69e		; (8876:0008=0)
		mov	cx,ds:data_65e		; (8876:0004=0)
		mov	dx,cs:data_125		; (8876:016A=1950h)
		dec	dh
		dec	dl
		int	10h			; Video display   ah=functn 06h
						;  scroll up, al=lines
		pop	dx
loc_77:
		mov	ah,2
		xor	bh,bh			; Zero register
		int	10h			; Video display   ah=functn 02h
						;  set cursor location in dx
loc_78:
		pop	bp
		cmp	data_148,1		; (8876:0194=0FFh)
		jne	loc_79			; Jump if not equal
		dec	sp
		call	sub_26			; (0853)
		jz	loc_79			; Jump if zero
		dec	sp
		call	sub_27			; (086C)
		cmp	al,13h
		jne	loc_79			; Jump if not equal
		dec	sp
		call	sub_27			; (086C)
loc_79:
		pop	ax
		retn
		pop	ax
		pop	dx
		push	ax
		mov	ah,5
		jmp	short loc_80		; (0957)
		nop
		pop	ax
		pop	dx
		push	ax
		mov	ah,4
		jmp	short loc_80		; (0957)
		nop
		mov	ah,3
		call	sub_28			; (0957)
		xor	ah,ah			; Zero register
		retn	1
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_28		proc	near
loc_80:
		cmp	ah,3Dh			; '='
		je	loc_82			; Jump if equal
		cmp	ah,3Ch			; '<' je="" loc_82="" ;="" jump="" if="" equal="" cmp="" ah,3eh="" ;="" '="">'
		je	loc_86			; Jump if equal
		cmp	ah,80h
		je	loc_89			; Jump if equal
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_29:
loc_81:
		push	bp
		int	21h			; DOS Services  ah=function 00h
						;  terminate, cs=progm seg prefx
		pop	bp
		retn
loc_82:
		push	si
		push	cx
		mov	si,data_134		; (8876:017A=2E4Fh)
		mov	cx,data_135		; (8876:017C=278Ah)
  
locloop_83:
		cmp	word ptr [si],0
		je	loc_84			; Jump if equal
		inc	si
		inc	si
		loop	locloop_83		; Loop if cx > 0
  
		pop	cx
		pop	si
		mov	ax,4
		stc				; Set carry flag
		retn
loc_84:
		pop	cx
		push	ds
		push	es
		pop	ds
		call	sub_29			; (096B)
		pop	ds
		jc	loc_85			; Jump if carry Set
		mov	[si],ax
loc_85:
		pop	si
		retn
loc_86:
		push	cx
		push	si
		mov	si,data_134		; (8876:017A=2E4Fh)
		mov	cx,data_135		; (8876:017C=278Ah)
  
locloop_87:
		cmp	[si],bx
		jne	loc_88			; Jump if not equal
		mov	word ptr [si],0
loc_88:
		inc	si
		inc	si
		loop	locloop_87		; Loop if cx > 0
  
		pop	si
		pop	cx
		jmp	short loc_81		; (096B)
loc_89:
		mov	si,data_134		; (8876:017A=2E4Fh)
		mov	cx,data_135		; (8876:017C=278Ah)
  
locloop_90:
		mov	bx,[si]
		or	bx,bx			; Zero ?
		jz	loc_91			; Jump if zero
		mov	ah,3Eh			; '>'
		call	sub_29			; (096B)
		mov	word ptr [si],0
loc_91:
		inc	si
		inc	si
		loop	locloop_90		; Loop if cx > 0
  
		retn
sub_28		endp
  
		db	 33h,0C0h
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_30		proc	near
		mov	data_129,ax		; (8876:0172=0F70h)
		mov	di,offset ds:[240h]	; (8876:0240=8Bh)
		mov	data_134,di		; (8876:017A=2E4Fh)
		mov	data_135,cx		; (8876:017C=278Ah)
		xor	ax,ax			; Zero register
		push	ds
		pop	es
		cld				; Clear direction
		rep	stosw			; Rep when cx >0 Store ax to es:[di]
		mov	es,ax
		mov	word ptr es:data_13e,0A62h	; (0000:008C=8F7h)
		mov	es:data_14e,cs		; (0000:008E=319Dh)
		call	sub_1			; (0199)
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_31:
		mov	data_148,0		; (8876:0194=0FFh)
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_32:
		mov	si,offset data_219	; (8876:0A26=53h)
		mov	di,offset data_111	; (8876:0136=0)
		push	ds
		pop	es
		push	cs
		pop	ds
		mov	cx,1Eh
		cld				; Clear direction
		rep	movsw			; Rep when cx >0 Mov [si] to es:[di]
		push	es
		pop	ds
		xor	ax,ax			; Zero register
		mov	data_147,ax		; (8876:0192=1D1h)
		mov	data_137,al		; (8876:0180=0F9h)
		mov	data_139,ax		; (8876:0182=430Eh)
		mov	data_140,ax		; (8876:0184=8A2Eh)
		mov	data_138,7Eh		; (8876:0181=74h) '~'
		mov	byte ptr ds:data_103e,0Dh	; (8876:0036=0)
		retn
sub_30		endp
  
data_219	db	53h
		db	 08h, 6Ch, 08h, 9Fh, 08h, 3Dh
		db	 09h, 45h, 09h, 4Dh, 09h, 9Fh
		db	 08h, 6Ch, 08h,0FFh,0FFh,0C1h
		db	 00h,0FFh,0FFh, 82h, 00h,0FFh
		db	0FFh, 43h, 00h,0FFh,0FFh,0C4h
		db	 00h,0FFh,0FFh,0C5h, 00h,0FFh
		db	0FFh,0C1h
		db	9 dup (0)
		db	0FFh,0FFh,0C1h
		db	9 dup (0)
		db	0CFh
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_33		proc	near
loc_92:
		push	bx
		push	cx
		push	dx
		push	di
		push	si
		xor	ah,ah			; Zero register
		push	ax
		call	data_113		; (8876:013A=0)
loc_93:
		pop	si
		pop	di
		pop	dx
		pop	cx
		pop	bx
		retn
sub_33		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_34		proc	near
		push	bx
		push	cx
		push	dx
		push	di
		push	si
		dec	sp
		call	data_112		; (8876:0138=0)
		jmp	short loc_93		; (0A6F)
sub_34		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_35		proc	near
		push	bp
		mov	bp,sp
		xchg	bx,[bp+2]
loc_94:
		mov	al,cs:[bx]
		inc	bx
		or	al,al			; Zero ?
		jz	loc_95			; Jump if zero
		call	sub_33			; (0A63)
		jmp	short loc_94		; (0A87)
loc_95:
		xchg	bx,[bp+2]
		pop	bp
		retn
sub_35		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_36		proc	near
		call	sub_35			; (0A81)
		or	ax,0Ah
		retn
sub_36		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_37		proc	near
loc_96:
		cmp	al,61h			; 'a'
		jb	loc_ret_97		; Jump if below
		cmp	al,7Ah			; 'z'
		ja	loc_ret_97		; Jump if above
		sub	al,20h			; ' '
  
loc_ret_97:
		retn
sub_37		endp
  
		push	ax
		mov	al,ah
		call	sub_38			; (0AB2)
		pop	ax
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_38		proc	near
		push	ax
		ror	al,1			; Rotate
		ror	al,1			; Rotate
		ror	al,1			; Rotate
		ror	al,1			; Rotate
		call	sub_39			; (0ABF)
		pop	ax
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_39:
		and	al,0Fh
		add	al,90h
		daa				; Decimal adjust
		adc	al,40h			; '@'
		daa				; Decimal adjust
		jmp	short loc_92		; (0A63)
sub_38		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_40		proc	near
		or	ah,ah			; Zero ?
		jz	loc_ret_98		; Jump if zero
		stc				; Set carry flag
		mov	ax,0
		js	loc_ret_98		; Jump if sign=1
		dec	al
  
loc_ret_98:
		retn
sub_40		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_41		proc	near
		call	sub_42			; (0C27)
		pop	si
		mov	ax,cs
		add	ax,cs:[si+6]
		add	ax,cs:[si+8]
		add	ax,cs:[si+0Ah]
		cmp	ax,cs:data_63e		; (8876:0002=0)
		jbe	loc_99			; Jump if below or =
		jmp	loc_108			; (0C36)
loc_99:
		mov	bx,cs
		add	bx,cs:[si+6]
		mov	ds,bx
		add	bx,cs:[si+8]
		mov	dx,cs:data_63e		; (8876:0002=0)
		sub	dx,bx
		cmp	dx,cs:[si+0Ch]
		jb	loc_100			; Jump if below
		mov	dx,cs:[si+0Ch]
loc_100:
		mov	di,dx
		mov	ax,0FFFEh
		sub	dx,1000h
		jnc	loc_101			; Jump if carry=0
		mov	ax,dx
		add	ax,1000h
		mov	cl,4
		shl	ax,cl			; Shift w/zeros fill
		xor	dx,dx			; Zero register
loc_101:
		add	dx,bx
		mov	ss,dx
		mov	sp,ax
		mov	data_131,ax		; (8876:0174=707h)
		xor	ax,ax			; Zero register
		mov	data_143,ax		; (8876:018A=5808h)
		mov	data_144,bx		; (8876:018C=0CCFEh)
		mov	word ptr ds:data_87e+1,ax	; (8876:0022=0)
		mov	word ptr ds:data_89e+1,bx	; (8876:0024=116h)
		push	di
		les	di,dword ptr ds:data_87e+1	; (8876:0022=0) Load 32 bit ptr
		mov	cx,4
		cld				; Clear direction
		rep	stosw			; Rep when cx >0 Store ax to es:[di]
		pop	di
		test	word ptr cs:[si],1
		jnz	loc_102			; Jump if not zero
		mov	ax,cs
		mov	es,ax
		add	bx,di
		sub	bx,ax
		mov	ah,4Ah			; 'J'
		call	sub_28			; (0957)
loc_102:
		mov	ax,cs:[si+2]
		mov	data_132,ax		; (8876:0176=0E70h)
		mov	ax,cs:[si+4]
		mov	data_133,ax		; (8876:0178=707h)
		mov	ax,cs:[si]
		mov	cx,cs:[si+0Eh]
		push	cx
		push	si
		call	sub_30			; (09D0)
		pop	si
		pop	cx
		mov	di,240h
		add	di,cx
		add	di,cx
		mov	data_121,di		; (8876:015E=6964h)
		mov	ax,cs:[si+10h]
		mov	data_122,ax		; (8876:0160=7073h)
		add	di,ax
		or	ax,ax			; Zero ?
		jz	loc_103			; Jump if zero
		mov	data_119,0		; (8876:015A=6C75h)
		mov	data_120,0		; (8876:015C=74h)
loc_103:
		mov	data_125,di		; (8876:016A=1950h)
		mov	ax,cs:[si+12h]
		mov	data_127,ax		; (8876:016C=0FF01h)
		or	ax,ax			; Zero ?
		jz	loc_104			; Jump if zero
		mov	data_123,1		; (8876:0166=6F6Dh)
		mov	data_124,0		; (8876:0168=64h)
loc_104:
		add	si,14h
		push	si
		xor	ax,ax			; Zero register
		mov	es,ax
		mov	ax,es:data_1e		; (0000:0000=108Ah)
		mov	data_145,ax		; (8876:018E=0F375h)
		mov	ax,es:data_2e		; (0000:0002=116h)
		mov	data_146,ax		; (8876:0190=0C3F8h)
		mov	word ptr es:data_1e,1032h	; (0000:0000=108Ah)
		nop				;*ASM fixup - sign extn byte
		mov	es:data_2e,cs		; (0000:0002=116h)
		test	data_129,8		; (8876:0172=0F70h)
		jz	loc_105			; Jump if zero
		mov	word ptr es:data_8e,0FF0h	; (0000:000C=6F4h)
		mov	es:data_9e,cs		; (0000:000E=70h)
loc_105:
		test	data_129,4		; (8876:0172=0F70h)
		jz	loc_106			; Jump if zero
		mov	data_148,1		; (8876:0194=0FFh)
loc_106:
		mov	data_136,10D0h		; (8876:017E=0E40Ah)
		xor	ax,ax			; Zero register
		mov	data_142,ax		; (8876:0188=0D8E8h)
		mov	byte ptr data_149+1,al	; (8876:0196=8)
		mov	cx,data_122		; (8876:0160=7073h)
		push	ds
		mov	di,15Ah
		call	sub_116			; (232A)
		mov	cx,data_127		; (8876:016C=0FF01h)
		push	ds
		mov	di,data_17e		; (0000:0166=0)
		call	sub_117			; (232E)
		mov	byte ptr ds:[1FAh],0	; (8876:01FA=0FAh)
		call	sub_6			; (02C8)
		retn
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_42:
		mov	ah,30h			; '0'
		call	sub_28			; (0957)
		or	al,al			; Zero ?
		jz	loc_107			; Jump if zero
		retn
loc_107:
		mov	dx,0C5Fh
		jmp	short loc_109		; (0C39)
loc_108:
		mov	dx,0C4Dh
loc_109:
		push	cs
		pop	ds
		mov	ah,9
		call	sub_28			; (0957)
		mov	dx,0C75h
		mov	ah,9
		call	sub_28			; (0957)
		mov	ah,0
		call	sub_28			; (0957)
		db	'Not enough memory$'
		db	'Incorrect DOS version$'
		db	0Dh, 0Ah, 'Program aborted', 0Dh, 0Ah
		db	'$'
		db	'P'
		db	 1Eh,0BFh, 5Ah, 01h,0E8h,0C2h
		db	 17h, 1Eh,0BFh, 66h, 01h,0E8h
		db	0BBh, 17h, 33h,0C0h, 8Eh,0C0h
		db	0A1h, 8Eh, 01h, 26h,0A3h, 00h
		db	 00h,0A1h, 90h, 01h, 26h,0A3h
		db	 02h, 00h, 58h,0F7h, 06h, 72h
		db	 01h, 01h, 00h, 75h, 05h,0B4h
		db	 4Ch,0E8h, 9Fh,0FCh,0B4h, 80h
		db	0E8h, 9Ah,0FCh,0FFh, 36h, 76h
		db	 01h,0B8h, 02h, 3Dh, 50h, 1Eh
		db	 07h, 8Eh, 1Eh, 78h, 01h,0CBh
sub_41		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_44		proc	near
		pop	bx
		mov	ax,cs:[bx]
		or	ax,ax			; Zero ?
		jz	loc_114			; Jump if zero
		push	ds
		push	cs
		pop	ds
		push	cs
		pop	es
		xor	dx,dx			; Zero register
loc_111:
		mov	ax,[bx]
		or	ax,ax			; Zero ?
		jz	loc_112			; Jump if zero
		push	bx
		add	bx,ax
		inc	dx
		jmp	short loc_111		; (0CDB)
loc_112:
		mov	cx,bx
		pop	bx
		mov	si,bx
		add	si,4
		mov	di,[bx+2]
		cmp	si,di
		je	loc_113			; Jump if equal
		sub	cx,si
		add	si,cx
		add	di,cx
		dec	si
		dec	di
		std				; Set direction flag
		rep	movsb			; Rep when cx >0 Mov [si] to es:[di]
loc_113:
		dec	dx
		jnz	loc_112			; Jump if not zero
		mov	word ptr [bx],0
		pop	ds
loc_114:
		add	bx,4
		jmp	bx			;*
		pop	si
		cmp	dx,cs:[si]
		jne	loc_116			; Jump if not equal
loc_115:
		add	si,0Fh
		jmp	si			;*Register jump
loc_116:
		push	ax
		push	dx
		push	si
		mov	di,offset data_149+1	; (8876:0196=8)
		xor	al,al			; Zero register
loc_117:
		mov	ah,al
		mov	al,[di]
		or	al,al			; Zero ?
		jz	loc_118			; Jump if zero
		inc	di
		jmp	short loc_117		; (0D21)
loc_118:
		push	di
		or	ah,ah			; Zero ?
		jz	loc_119			; Jump if zero
		cmp	ah,3Ah			; ':'
		je	loc_119			; Jump if equal
		cmp	ah,5Ch			; '\'
		je	loc_119			; Jump if equal
		mov	byte ptr [di],5Ch	; '\'
		inc	di
loc_119:
		inc	si
		inc	si
loc_120:
		mov	al,cs:[si]
		mov	[di],al
		inc	si
		inc	di
		or	al,al			; Zero ?
		jnz	loc_120			; Jump if not zero
		mov	ax,3D00h
		mov	dx,196h
		push	ds
		pop	es
		call	sub_28			; (0957)
		mov	bx,ax
		pop	di
		pop	si
		pop	dx
		mov	byte ptr [di],0
		jc	loc_121			; Jump if carry Set
		mov	cs:[si],dx
		mov	ax,4200h
		xor	ch,ch			; Zero register
		mov	cl,dh
		mov	dh,dl
		xor	dl,dl			; Zero register
		call	sub_28			; (0957)
		pop	cx
		jc	loc_121			; Jump if carry Set
		mov	ah,3Fh			; '?'
		lea	dx,[si+0Fh]		; Load effective addr
		push	ds
		push	cs
		pop	ds
		call	sub_28			; (0957)
		pop	ds
		jc	loc_121			; Jump if carry Set
		mov	ah,3Eh			; '>'
		call	sub_28			; (0957)
		jmp	short loc_115		; (0D14)
loc_121:
		mov	dl,0F0h
		push	si
		jmp	loc_149			; (1038)
sub_44		endp
  
		db	 5Bh,0E8h, 52h, 01h, 53h
		db	0BEh,0B6h, 00h
		db	0BFh, 96h, 01h, 1Eh, 07h,0B9h
		db	 20h, 00h,0FCh,0F3h,0A5h,0C3h
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_45		proc	near
		dec	sp
		call	data_111		; (8876:0136=0)
		retn
sub_45		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_46		proc	near
		pop	bx
		pop	cx
		push	bx
		mov	dl,al
		mov	dh,cl
		dec	dl
		dec	dh
		jmp	loc_16			; (0343)
sub_46		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_47		proc	near
		mov	dx,ax
		or	dx,dx			; Zero ?
		jz	loc_122			; Jump if zero
		call	sub_49			; (0DD7)
		xchg	ax,bx
loc_122:
		pop	bx
		sub	sp,ax
		dec	sp
		mov	di,sp
		push	ds
		push	cs
		pop	ds
		push	ss
		pop	es
		cld				; Clear direction
		stosb				; Store al to es:[di]
		xchg	ax,cx
		rep	movsb			; Rep when cx >0 Mov [si] to es:[di]
		pop	ds
		jmp	bx			;*Register jump
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_48:
		xor	dx,dx			; Zero register
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_49:
		mov	di,data_104e		; (8876:0080=0)
		mov	cl,cs:[di]
		xor	ch,ch			; Zero register
		inc	di
		xor	bx,bx			; Zero register
loc_123:
		jcxz	loc_125			; Jump if cx=0
		mov	al,cs:[di]
		cmp	al,20h			; ' '
		je	loc_124			; Jump if equal
		cmp	al,9
		jne	loc_125			; Jump if not equal
loc_124:
		inc	di
		dec	cx
		jmp	short loc_123		; (0DE2)
loc_125:
		mov	si,di
loc_126:
		jcxz	loc_127			; Jump if cx=0
		mov	al,cs:[di]
		cmp	al,20h			; ' '
		je	loc_127			; Jump if equal
		cmp	al,9
		je	loc_127			; Jump if equal
		inc	di
		dec	cx
		jmp	short loc_126		; (0DF5)
loc_127:
		mov	ax,di
		sub	ax,si
		jz	loc_128			; Jump if zero
		inc	bx
		dec	dx
		jnz	loc_123			; Jump if not zero
loc_128:
		xchg	ax,bx
		retn
sub_47		endp
  
		mov	byte ptr ds:[1E6h],cl	; (8876:01E6=0E8h)
		mov	word ptr ds:[1E8h],di	; (8876:01E8=2E00h)
		pop	bx
		pop	word ptr ds:[1EAh]	; (8876:01EA=6FFh)
		pop	cx
		pop	ax
		push	bx
		push	cx
		mov	bx,0B6h
		call	sub_60			; (111B)
		jmp	short loc_129		; (0E4E)
		mov	byte ptr ds:[1E6h],cl	; (8876:01E6=0E8h)
		mov	word ptr ds:[1E8h],di	; (8876:01E8=2E00h)
		pop	bx
		pop	word ptr ds:[1EAh]	; (8876:01EA=6FFh)
		pop	dx
		pop	ax
		mov	di,1F4h
		pop	word ptr [di]
		pop	word ptr [di+2]
		pop	word ptr [di+4]
		push	bx
		push	ax
		xchg	ax,cx
		mov	bx,0B6h
		call	sub_102			; (1F45)
loc_129:
		pop	cx
		les	di,dword ptr ds:[1E8h]	; (8876:01E8=2E00h) Load 32 bit ptr
		push	di
		mov	dl,byte ptr ds:[1E6h]	; (8876:01E6=0E8h)
		xor	dh,dh			; Zero register
		xchg	ax,bx
		sub	ax,0B6h
		sub	cx,ax
		jbe	loc_131			; Jump if below or =
  
locloop_130:
		inc	di
		mov	byte ptr es:[di],20h	; ' '
		inc	dh
		cmp	dh,dl
		je	loc_133			; Jump if equal
		loop	locloop_130		; Loop if cx > 0
  
loc_131:
		xchg	ax,cx
		mov	bx,data_105e		; (8876:00B6=0)
  
locloop_132:
		mov	al,[bx]
		inc	bx
		inc	di
		mov	es:[di],al
		inc	dh
		cmp	dh,dl
		je	loc_133			; Jump if equal
		loop	locloop_132		; Loop if cx > 0
  
loc_133:
		pop	di
		mov	es:[di],dh
		retn
		xor	al,al			; Zero register
		jmp	short loc_134		; (0E8D)
		db	0B0h, 01h
loc_134:
		mov	byte ptr ds:[1E7h],al	; (8876:01E7=34h)
		mov	word ptr ds:[1F0h],di	; (8876:01F0=943Eh)
		pop	bx
		pop	word ptr ds:[1F2h]	; (8876:01F2=0FF01h)
		pop	word ptr ds:[1ECh]	; (8876:01EC=192h)
		pop	word ptr ds:[1EEh]	; (8876:01EE=802Eh)
		call	sub_51			; (0EEB)
		push	bx
		xor	ax,ax			; Zero register
		mov	bx,data_105e		; (8876:00B6=0)
		cmp	[bx],al
		je	loc_138			; Jump if equal
		cmp	byte ptr ds:[1E7h],al	; (8876:01E7=34h)
		jne	loc_135			; Jump if not equal
		call	sub_63			; (11A7)
		jc	loc_137			; Jump if carry Set
		les	di,dword ptr ds:[1ECh]	; (8876:01EC=192h) Load 32 bit ptr
		mov	es:[di],ax
		jmp	short loc_136		; (0ED4)
loc_135:
		mov	di,1F4h
		call	sub_108			; (20CD)
		jc	loc_137			; Jump if carry Set
		mov	si,di
		les	di,dword ptr ds:[1ECh]	; (8876:01EC=192h) Load 32 bit ptr
		cld				; Clear direction
		movsw				; Mov [si] to es:[di]
		movsw				; Mov [si] to es:[di]
		movsw				; Mov [si] to es:[di]
loc_136:
		xor	ax,ax			; Zero register
		cmp	[bx],al
		je	loc_138			; Jump if equal
loc_137:
		xchg	ax,bx
		sub	ax,0B5h
loc_138:
		les	di,dword ptr ds:[1F0h]	; (8876:01F0=943Eh) Load 32 bit ptr
		mov	es:[di],ax
		retn
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_50		proc	near
		mov	cx,40h
		jmp	short loc_139		; (0EEE)
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_51:
		mov	cx,7Fh
loc_139:
		mov	di,0B6h
		pop	ax
		mov	si,sp
		mov	dl,ss:[si]
		xor	dh,dh			; Zero register
		cmp	cx,dx
		jbe	loc_140			; Jump if below or =
		mov	cx,dx
loc_140:
		inc	dx
		inc	si
		mov	di,data_105e		; (8876:00B6=0)
		push	ds
		pop	es
		push	ss
		pop	ds
		cld				; Clear direction
		rep	movsb			; Rep when cx >0 Mov [si] to es:[di]
		push	es
		pop	ds
		mov	byte ptr [di],0
		add	sp,dx
		jmp	ax			;*
		mov	ah,2Ch			; ','
		call	sub_28			; (0957)
		mov	word ptr ds:[1FEh],cx	; (8876:01FE=2E02h)
		mov	word ptr ds:[1FCh],dx	; (8876:01FC=4489h)
		retn
sub_50		endp
  
		pop	bx
		mov	dx,ds
		mov	si,di
		pop	ds
		pop	di
		pop	es
		cld				; Clear direction
		rep	movsb			; Rep when cx >0 Mov [si] to es:[di]
		mov	ds,dx
		jmp	bx			;*
		pop	bx
		mov	dx,ds
		mov	si,di
		pop	ds
		sub	sp,cx
		mov	di,sp
		push	ss
		pop	es
		cld				; Clear direction
		rep	movsb			; Rep when cx >0 Mov [si] to es:[di]
		mov	ds,dx
		jmp	bx			;*Register jump
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_52		proc	near
		pop	bx
		pop	cx
		pop	di
		pop	es
		cld				; Clear direction
		rep	stosb			; Rep when cx >0 Store al to es:[di]
		jmp	bx			;*Register jump
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_53:
		xchg	ax,cx
		mov	dx,ds
		pop	bx
		pop	di
		pop	es
		pop	si
		pop	ds
		cld				; Clear direction
		cmp	si,di
		jae	loc_141			; Jump if above or =
		add	si,cx
		add	di,cx
		dec	si
		dec	di
		std				; Set direction flag
loc_141:
		rep	movsb			; Rep when cx >0 Mov [si] to es:[di]
		mov	ds,dx
		jmp	bx			;*Register jump
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_54:
		pop	bx
		pop	ax
		push	bp
		push	ds
		push	ax
		push	di
		push	bx
		mov	si,di
		mov	ds,ax
		cld				; Clear direction
		lodsw				; String [si] to ax
		push	ax
		lodsw				; String [si] to ax
		mov	bx,ax
		lodsw				; String [si] to ax
		mov	cx,ax
		lodsw				; String [si] to ax
		mov	dx,ax
		lodsw				; String [si] to ax
		mov	bp,ax
		lodsw				; String [si] to ax
		push	ax
		lodsw				; String [si] to ax
		mov	di,ax
		lodsw				; String [si] to ax
		push	ax
		lodsw				; String [si] to ax
		mov	es,ax
		pop	ds
		pop	si
		pop	ax
		retn
sub_52		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_55		proc	near
		pushf				; Push flags
		push	es
		push	di
		push	bp
		mov	bp,sp
		les	di,dword ptr [bp+0Ah]	; Load 32 bit ptr
		cld				; Clear direction
		stosw				; Store ax to es:[di]
		mov	ax,bx
		stosw				; Store ax to es:[di]
		mov	ax,cx
		stosw				; Store ax to es:[di]
		mov	ax,dx
		stosw				; Store ax to es:[di]
		pop	ax
		stosw				; Store ax to es:[di]
		mov	ax,si
		stosw				; Store ax to es:[di]
		pop	ax
		stosw				; Store ax to es:[di]
		mov	ax,ds
		stosw				; Store ax to es:[di]
		pop	ax
		stosw				; Store ax to es:[di]
		pop	ax
		stosw				; Store ax to es:[di]
		pop	bx
		add	sp,4
		pop	ds
		pop	bp
		jmp	bx			;*Register jump
		db	 3Bh,0C1h, 73h, 01h,0C3h
loc_142:
		mov	dl,90h
		jmp	short loc_149		; (1038)
		nop
		cmp	ax,cx
		jl	loc_143			; Jump if < cmp="" ax,dx="" jg="" loc_143="" ;="" jump="" if="">
		retn
loc_143:
		mov	dl,91h
		jmp	short loc_149		; (1038)
		db	90h
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_56:
		mov	ax,sp
		sub	ax,cx
		jc	loc_144			; Jump if carry Set
		cmp	ax,200h
		jb	loc_144			; Jump if below
		mov	cl,4
		shr	ax,cl			; Shift w/zeros fill
		mov	cx,ss
		add	ax,cx
		cmp	ax,ds:data_45e		; (0274:018C=8D0Ah)
		jb	loc_144			; Jump if below
		retn
loc_144:
		mov	dl,0FFh
		jmp	short loc_149		; (1038)
		nop
		pop	bx
		pop	ax
		popf				; Pop flags
		push	bx
		or	byte ptr ds:data_46e,2	; (0274:0194=3)
		dec	sp
		call	sub_26			; (0853)
		jz	loc_145			; Jump if zero
		dec	sp
		call	sub_27			; (086C)
loc_145:
		and	byte ptr ds:data_46e,1	; (0274:0194=3)
		cmp	al,3
		je	loc_146			; Jump if equal
		retn
loc_146:
		pop	word ptr ds:data_44e	; (0274:0186=1689h)
		add	word ptr ds:data_44e,2	; (0274:0186=1689h)
loc_147:
		mov	dx,1
		jmp	short loc_151		; (103E)
		xor	ax,ax			; Zero register
		xchg	al,ds:data_43e		; (0274:0180=8Bh)
		retn
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_57:
		cmp	byte ptr ds:data_18e,0	; (0000:0180=0)
		jne	loc_148			; Jump if not equal
		retn
loc_148:
		mov	dl,ds:data_18e		; (0000:0180=0)
		mov	dh,1
		jmp	short loc_151		; (103E)
		pop	bx
		pop	ax
		popf				; Pop flags
		push	bx
		mov	dl,4
loc_149:
		pop	data_141		; (8876:0186=5007h)
loc_150:
		mov	dh,2
loc_151:
		push	dx
		call	sub_31			; (09F6)
		pop	dx
		mov	ax,data_141		; (8876:0186=5007h)
		sub	ax,3
		xchg	ax,data_142		; (8876:0188=0D8E8h)
		or	ax,ax			; Zero ?
		jnz	loc_152			; Jump if not zero
		push	dx
		push	dx
		push	data_142		; (8876:0188=0D8E8h)
		call	data_136		; (8876:017E=0E40Ah)
		pop	dx
loc_152:
		cmp	dh,1
		jae	loc_153			; Jump if above or =
		call	sub_35			; (0A81)
		pop	si
		inc	bx
		or	ax,550Ah
		jnc	loc_ret_155		; Jump if carry=0
		jc	$+22h			; Jump if carry Set
		inc	dx
		jc	loc_156			; Jump if carry Set
		db	 61h, 6Bh, 00h,0EBh, 30h
loc_153:
		mov	byte ptr ds:[1FAh],0FFh	; (8876:01FA=0FAh)
		ja	loc_154			; Jump if above
		call	sub_35			; (0A81)
		or	ax,490Ah
		das				; Decimal adjust
		dec	di
		add	bl,ch
		push	cs
loc_154:
		call	sub_35			; (0A81)
		or	ax,520Ah
		jnz	$+70h			; Jump if not zero
		sub	ax,6974h
		db	 6Dh, 65h, 00h,0E8h,0E9h,0F9h
		db	 20h, 65h, 72h, 72h, 6Fh, 72h
		db	 20h, 00h, 8Ah,0C2h,0E8h, 0Dh
		db	0FAh,0E8h,0D9h,0F9h, 2Ch, 20h
		db	 50h, 43h, 3Dh, 00h,0A1h, 88h
		db	 01h,0E8h,0F7h,0F9h,0E8h,0CAh
		db	0F9h
		db	0Dh, 0Ah, 'Program aborted', 0Dh, 0Ah
		db	 00h,0B0h, 01h,0E9h,0B9h,0FBh
  
loc_ret_155:
		retn	4
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_58:
		or	ax,ax			; Zero ?
loc_156:
		jns	loc_ret_157		; Jump if not sign
		neg	ax
  
loc_ret_157:
		retn
sub_55		endp
  
		push	ax
		call	sub_59			; (10E6)
		pop	bx
		shr	ax,1			; Shift w/zeros fill
		cwd				; Word to double word
		div	bx			; ax,dx rem=dx:ax/reg
		xchg	ax,dx
		retn
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_59		proc	near
		mov	bx,word ptr ds:[1FEh]	; (8876:01FE=2E02h)
		mov	cx,word ptr ds:[1FCh]	; (8876:01FC=4489h)
		push	bx
		push	cx
		mov	al,bh
		mov	bh,bl
		mov	bl,ch
		mov	ch,cl
		xor	cl,cl			; Zero register
		rcr	al,1			; Rotate thru carry
		rcr	bx,1			; Rotate thru carry
		rcr	cx,1			; Rotate thru carry
		pop	ax
		add	cx,ax
		pop	ax
		adc	bx,ax
		mov	ax,62E9h
		add	cx,ax
		mov	ax,3619h
		adc	bx,ax
		mov	word ptr ds:[1FEh],bx	; (8876:01FE=2E02h)
		mov	word ptr ds:[1FCh],cx	; (8876:01FC=4489h)
		mov	ax,bx
		retn
sub_59		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_60		proc	near
		or	ax,ax			; Zero ?
		jns	loc_158			; Jump if not sign
		neg	ax
		mov	byte ptr [bx],2Dh	; '-'
		inc	bx
loc_158:
		xor	ch,ch			; Zero register
		mov	dx,2710h
		call	sub_61			; (1142)
		mov	dx,3E8h
		call	sub_61			; (1142)
		mov	dx,64h
		call	sub_61			; (1142)
		mov	dl,0Ah
		call	sub_61			; (1142)
		mov	cl,al
		jmp	short loc_160		; (1156)
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_61:
		xor	cl,cl			; Zero register
loc_159:
		inc	cl
		sub	ax,dx
		jnc	loc_159			; Jump if carry=0
		add	ax,dx
		inc	ch
		dec	cl
		jnz	loc_160			; Jump if not zero
		dec	ch
		jz	loc_ret_161		; Jump if zero
loc_160:
		add	cl,30h			; '0'
		mov	[bx],cl
		inc	bx
  
loc_ret_161:
		retn
sub_60		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_62		proc	near
		xor	ax,ax			; Zero register
		cmp	byte ptr [bx],24h	; '$'
		mov	dx,0Ah
		jnz	loc_163			; Jump if not zero
		mov	dl,10h
loc_162:
		inc	bx
loc_163:
		push	ax
		mov	al,[bx]
		call	sub_37			; (0AA0)
		mov	cl,al
		pop	ax
		sub	cl,30h			; '0'
		jc	loc_165			; Jump if carry Set
		cmp	cl,0Ah
		jb	loc_164			; Jump if below
		cmp	dl,10h
		jne	loc_165			; Jump if not equal
		sub	cl,7
		cmp	cl,0Ah
		jb	loc_165			; Jump if below
		cmp	cl,10h
		jae	loc_165			; Jump if above or =
loc_164:
		push	dx
		mul	dx			; dx:ax = reg * ax
		pop	dx
		jc	loc_ret_166		; Jump if carry Set
		xor	ch,ch			; Zero register
		add	ax,cx
		jnc	loc_162			; Jump if carry=0
		jmp	short loc_ret_166	; (11A6)
loc_165:
		cmp	dl,10h
		je	loc_ret_166		; Jump if equal
		mov	cx,ax
		add	cx,cx
  
loc_ret_166:
		retn
sub_62		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_63		proc	near
		mov	cl,[bx]
		cmp	cl,2Dh			; '-'
		jne	loc_167			; Jump if not equal
		inc	bx
loc_167:
		push	cx
		call	sub_62			; (115D)
		pop	cx
		jc	loc_169			; Jump if carry Set
		cmp	cl,2Dh			; '-'
		jne	loc_168			; Jump if not equal
		neg	ax
loc_168:
		clc				; Clear carry flag
		retn
loc_169:
		cmp	ax,8000h
		jne	loc_170			; Jump if not equal
		cmp	cl,2Dh			; '-'
		jne	loc_170			; Jump if not equal
		retn
loc_170:
		stc				; Set carry flag
		retn
sub_63		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_64		proc	near
		pop	bx
		pop	es
		mov	si,di
		mov	cl,es:[si]
		xor	ch,ch			; Zero register
		inc	cx
		sub	sp,cx
		mov	di,sp
		push	ds
		push	es
		pop	ds
		push	ss
		pop	es
		cld				; Clear direction
		rep	movsb			; Rep when cx >0 Mov [si] to es:[di]
		pop	ds
		jmp	bx			;*Register jump
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_65:
		pop	si
		mov	cl,cs:[si]
		xor	ch,ch			; Zero register
		inc	cx
		sub	sp,cx
		mov	di,sp
		push	ds
		push	cs
		pop	ds
		push	ss
		pop	es
		cld				; Clear direction
		rep	movsb			; Rep when cx >0 Mov [si] to es:[di]
		pop	ds
		jmp	si			;*Register jump
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_66:
		pop	dx
		mov	al,cl
		mov	bx,sp
		mov	cl,ss:[bx]
		xor	ch,ch			; Zero register
		add	bx,cx
		inc	bx
		les	di,dword ptr ss:[bx]	; Load 32 bit ptr
		mov	si,sp
		cmp	cl,al
		jbe	loc_171			; Jump if below or =
		mov	cl,al
		mov	ss:[si],al
loc_171:
		inc	cx
		push	ds
		push	ss
		pop	ds
		cld				; Clear direction
		rep	movsb			; Rep when cx >0 Mov [si] to es:[di]
		pop	ds
		lea	sp,[bx+4]		; Load effective addr
		jmp	dx			;*
		pop	bx
		pop	es
		mov	si,di
		xor	ch,ch			; Zero register
		sub	sp,cx
		dec	sp
		mov	di,sp
		mov	ss:[di],cl
		inc	di
		push	ds
		push	es
		pop	ds
		push	ss
		pop	es
		cld				; Clear direction
		rep	movsb			; Rep when cx >0 Mov [si] to es:[di]
		pop	ds
		jmp	bx			;*
		pop	bx
		xor	ch,ch			; Zero register
		mov	si,sp
		mov	al,ss:[si]
		xor	ah,ah			; Zero register
		sub	ax,cx
		mov	di,si
		add	di,ax
		or	ax,ax			; Zero ?
		jz	loc_173			; Jump if zero
		jns	loc_172			; Jump if not sign
		mov	sp,di
		mov	cl,ss:[si]
		inc	cx
		push	ds
		push	ss
		pop	ds
		push	ss
		pop	es
		cld				; Clear direction
		rep	movsb			; Rep when cx >0 Mov [si] to es:[di]
		pop	ds
		jmp	short loc_173		; (1278)
loc_172:
		mov	ss:[si],cl
		add	di,cx
		add	si,cx
		inc	cx
		push	ds
		push	ss
		pop	ds
		push	ss
		pop	es
		std				; Set direction flag
		rep	movsb			; Rep when cx >0 Mov [si] to es:[di]
		pop	ds
		inc	di
		mov	sp,di
loc_173:
		jmp	bx			;*
		call	sub_67			; (12C2)
		mov	ax,1
		jz	loc_174			; Jump if zero
		dec	ax
loc_174:
		or	ax,ax			; Zero ?
		retn
sub_64		endp
  
		call	sub_67			; (12C2)
		mov	ax,1
		jnz	loc_175			; Jump if not zero
		dec	ax
loc_175:
		or	ax,ax			; Zero ?
		retn
		call	sub_67			; (12C2)
		mov	ax,1
		jnc	loc_176			; Jump if carry=0
		dec	ax
loc_176:
		or	ax,ax			; Zero ?
		retn
		call	sub_67			; (12C2)
		mov	ax,1
		jbe	loc_177			; Jump if below or =
		dec	ax
loc_177:
		or	ax,ax			; Zero ?
		retn
		call	sub_67			; (12C2)
		mov	ax,1
		ja	loc_178			; Jump if above
		dec	ax
loc_178:
		or	ax,ax			; Zero ?
		retn
		call	sub_67			; (12C2)
		mov	ax,1
		jc	loc_179			; Jump if carry Set
		dec	ax
loc_179:
		or	ax,ax			; Zero ?
		retn
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_67		proc	near
		mov	di,sp
		add	di,4
		mov	cl,ss:[di]
		xor	ch,ch			; Zero register
		inc	di
		mov	si,di
		add	si,cx
		mov	dl,ss:[si]
		xor	dh,dh			; Zero register
		inc	si
		mov	bx,si
		add	bx,dx
		mov	al,cl
		mov	ah,dl
		cmp	cx,dx
		jbe	loc_180			; Jump if below or =
		xchg	cx,dx
loc_180:
		or	cx,cx			; Zero ?
		jz	loc_181			; Jump if zero
		push	ds
		push	ss
		pop	es
		push	ss
		pop	ds
		cld				; Clear direction
		repe	cmpsb			; Rep zf=1+cx >0 Cmp [si] to es:[di]
		pop	ds
		jnz	loc_182			; Jump if not zero
loc_181:
		cmp	ah,al
loc_182:
		pop	dx
		pop	cx
		mov	sp,bx
		push	cx
		jmp	dx			;*Register jump
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_68:
		pop	data_141		; (8876:0186=5007h)
		mov	di,sp
		mov	dl,ss:[di]
		xor	dh,dh			; Zero register
		mov	si,di
		inc	si
		add	si,dx
		mov	cl,ss:[si]
		add	dl,cl
		jc	loc_183			; Jump if carry Set
		mov	ss:[si],dl
		xor	ch,ch			; Zero register
		sub	di,cx
		mov	sp,di
		inc	cx
		push	ds
		push	si
		push	ss
		pop	es
		push	ss
		pop	ds
		cld				; Clear direction
		rep	movsb			; Rep when cx >0 Mov [si] to es:[di]
		mov	di,si
		pop	si
		dec	si
		dec	di
		mov	cx,dx
		inc	cx
		std				; Set direction flag
		rep	movsb			; Rep when cx >0 Mov [si] to es:[di]
		pop	ds
		inc	di
		mov	sp,di
		jmp	data_141		; (8876:0186=5007h)
loc_183:
		mov	dl,10h
		jmp	loc_150			; (103C)
sub_67		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_69		proc	near
		pop	data_141		; (8876:0186=5007h)
		call	sub_40			; (0AC9)
		mov	cx,ax
		pop	ax
		call	sub_75			; (14BE)
		dec	ax
		mov	si,sp
		mov	dl,ss:[si]
		xor	dh,dh			; Zero register
		mov	di,sp
		add	di,dx
		sub	dx,ax
		jbe	loc_184			; Jump if below or =
		add	si,ax
		cmp	dx,cx
		jbe	loc_186			; Jump if below or =
		add	si,cx
		mov	dx,cx
		push	ds
		push	ss
		pop	es
		push	ss
		pop	ds
		std				; Set direction flag
		rep	movsb			; Rep when cx >0 Mov [si] to es:[di]
		pop	ds
		jmp	short loc_185		; (1373)
loc_184:
		xor	dx,dx			; Zero register
loc_185:
		xchg	si,di
loc_186:
		mov	ss:[si],dl
		mov	sp,si
		jmp	data_141		; (8876:0186=5007h)
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_70:
loc_187:
		pop	bx
		mov	di,sp
		mov	al,ss:[di]
		xor	ah,ah			; Zero register
		add	sp,ax
		inc	sp
		jmp	bx			;*Register jump
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_71:
		pop	data_141		; (8876:0186=5007h)
		mov	di,sp
		mov	dl,ss:[di]
		xor	dh,dh			; Zero register
		inc	di
		mov	si,di
		add	si,dx
		mov	cl,ss:[si]
		xor	ch,ch			; Zero register
		inc	si
		mov	bx,si
		add	bx,cx
		xor	ax,ax			; Zero register
		sub	dx,cx
		jc	loc_190			; Jump if carry Set
		inc	ax
		or	cx,cx			; Zero ?
		jz	loc_190			; Jump if zero
		inc	dx
		push	ds
		push	ss
		pop	es
		push	ss
		pop	ds
		cld				; Clear direction
loc_188:
		push	cx
		push	di
		push	si
		repe	cmpsb			; Rep zf=1+cx >0 Cmp [si] to es:[di]
		pop	si
		pop	di
		pop	cx
		jz	loc_189			; Jump if zero
		inc	ax
		inc	di
		dec	dx
		jnz	loc_188			; Jump if not zero
		xor	ax,ax			; Zero register
loc_189:
		pop	ds
loc_190:
		mov	sp,bx
		jmp	data_141		; (8876:0186=5007h)
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_72:
		mov	byte ptr ds:[200h],cl	; (8876:0200=0A1h)
		mov	word ptr ds:[202h],ax	; (8876:0202=2601h)
		pop	bx
		pop	word ptr ds:[206h]	; (8876:0206=2EFBh)
		pop	word ptr ds:[208h]	; (8876:0208=92A1h)
		mov	word ptr ds:[20Ah],sp	; (8876:020A=301h)
		mov	word ptr ds:[20Ch],ss	; (8876:020C=0A3C0h)
		push	bx
		les	di,dword ptr ds:[206h]	; (8876:0206=2EFBh) Load 32 bit ptr
		push	es
		push	di
		push	es
		call	sub_64			; (11CC)
		mov	ax,1
		push	ax
		mov	ax,word ptr ds:[202h]	; (8876:0202=2601h)
		dec	ax
		call	sub_69			; (133F)
		les	di,dword ptr ds:[20Ah]	; (8876:020A=301h) Load 32 bit ptr
		push	es
		call	sub_64			; (11CC)
		call	sub_68			; (12FD)
		les	di,dword ptr ds:[206h]	; (8876:0206=2EFBh) Load 32 bit ptr
		push	es
		call	sub_64			; (11CC)
		push	word ptr ds:[202h]	; (8876:0202=2601h)
		mov	ax,0FFh
		call	sub_69			; (133F)
		call	sub_68			; (12FD)
		mov	cl,byte ptr ds:[200h]	; (8876:0200=0A1h)
		call	sub_66			; (11FB)
		jmp	loc_187			; (137E)
sub_69		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_73		proc	near
		mov	word ptr ds:[204h],ax	; (8876:0204=489h)
		pop	bx
		pop	word ptr ds:[202h]	; (8876:0202=2601h)
		pop	word ptr ds:[206h]	; (8876:0206=2EFBh)
		pop	word ptr ds:[208h]	; (8876:0208=92A1h)
		push	bx
		les	di,dword ptr ds:[206h]	; (8876:0206=2EFBh) Load 32 bit ptr
		push	es
		push	di
		push	es
		call	sub_64			; (11CC)
		mov	ax,1
		push	ax
		mov	ax,word ptr ds:[202h]	; (8876:0202=2601h)
		dec	ax
		call	sub_69			; (133F)
		mov	ax,word ptr ds:[202h]	; (8876:0202=2601h)
		add	ax,word ptr ds:[204h]	; (8876:0204=489h)
		or	ah,ah			; Zero ?
		jnz	loc_191			; Jump if not zero
		les	di,dword ptr ds:[206h]	; (8876:0206=2EFBh) Load 32 bit ptr
		push	es
		call	sub_64			; (11CC)
		push	ax
		mov	ax,0FFh
		call	sub_69			; (133F)
		call	sub_68			; (12FD)
loc_191:
		mov	cl,0FFh
		call	sub_66			; (11FB)
		retn
sub_73		endp
  
		pop	bx
		pop	ax
		dec	al
		jnz	loc_192			; Jump if not zero
		xchg	al,ah
		jmp	bx			;*Register jump
loc_192:
		mov	data_141,bx		; (8876:0186=5007h)
		mov	dl,10h
		jmp	loc_150			; (103C)
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_74		proc	near
		mov	si,sp
		mov	bl,ss:[si+2]
		xor	bh,bh			; Zero register
		mov	ax,ss:[bx+si+3]
		mov	ah,al
		mov	al,1
		mov	ss:[bx+si+3],ax
		retn
sub_74		endp
  
loc_193:
		pop	bx
		add	sp,dx
		mov	si,sp
		mov	al,ss:[si]
		cmp	al,cl
		je	loc_194			; Jump if equal
		xor	ah,ah			; Zero register
		add	si,ax
		mov	di,sp
		xor	ch,ch			; Zero register
		add	di,cx
		xchg	ax,cx
		inc	cx
		push	ds
		push	ss
		pop	ds
		push	ss
		pop	es
		std				; Set direction flag
		rep	movsb			; Rep when cx >0 Mov [si] to es:[di]
		pop	ds
		inc	di
		mov	sp,di
loc_194:
		jmp	bx			;*Register jump
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_75		proc	near
		or	ah,ah			; Zero ?
		jnz	loc_195			; Jump if not zero
		or	al,al			; Zero ?
		jz	loc_195			; Jump if zero
		retn
loc_195:
		mov	dl,11h
		jmp	loc_150			; (103C)
sub_75		endp
  
		pop	bx
		pop	dx
		mov	si,di
		sub	sp,20h
		mov	di,sp
		push	cx
		push	ss
		pop	es
		cld				; Clear direction
		or	ch,ch			; Zero ?
		jz	loc_197			; Jump if zero
		xor	al,al			; Zero register
loc_196:
		stosb				; Store al to es:[di]
		dec	ch
		jnz	loc_196			; Jump if not zero
loc_197:
		push	ds
		mov	ds,dx
		rep	movsb			; Rep when cx >0 Mov [si] to es:[di]
		pop	ds
		pop	cx
		mov	ah,20h			; ' '
		sub	ah,ch
		sub	ah,cl
		jz	loc_199			; Jump if zero
		xor	al,al			; Zero register
loc_198:
		stosb				; Store al to es:[di]
		dec	ah
		jnz	loc_198			; Jump if not zero
loc_199:
		jmp	bx			;*
		pop	bx
		sub	sp,20h
		mov	di,sp
		push	ss
		pop	es
		mov	cx,10h
		xor	ax,ax			; Zero register
		cld				; Clear direction
		rep	stosw			; Rep when cx >0 Store ax to es:[di]
		jmp	bx			;*
		call	sub_76			; (1600)
		or	ss:[bx],al
		retn
		xchg	ax,cx
		pop	bx
		pop	ax
		push	bx
		sub	cl,al
		jc	loc_ret_202		; Jump if carry Set
		xor	ch,ch			; Zero register
		inc	cx
		mov	ah,cl
		call	sub_76			; (1600)
		mov	cl,ah
  
locloop_200:
		or	ss:[bx],al
		shl	al,1			; Shift w/zeros fill
		jnc	loc_201			; Jump if carry=0
		inc	bx
		mov	al,1
loc_201:
		loop	locloop_200		; Loop if cx > 0
  
  
loc_ret_202:
		retn
		mov	si,sp
		inc	si
		inc	si
		mov	di,ss:[si+20h]
		mov	es,ss:[si+22h]
		mov	dl,ch
		xor	dh,dh			; Zero register
		add	si,dx
		xor	ch,ch			; Zero register
		push	ds
		push	ss
		pop	ds
		cld				; Clear direction
		rep	movsb			; Rep when cx >0 Mov [si] to es:[di]
		pop	ds
		retn	24h
		pop	bx
		mov	dl,ch
		xor	dh,dh			; Zero register
		xor	ch,ch			; Zero register
		mov	si,sp
		add	si,dx
		add	si,cx
		mov	di,sp
		add	di,20h
		cmp	si,di
		je	loc_203			; Jump if equal
		dec	si
		dec	di
		push	ds
		push	ss
		pop	es
		push	ss
		pop	ds
		std				; Set direction flag
		rep	movsb			; Rep when cx >0 Mov [si] to es:[di]
		pop	ds
		inc	di
		mov	sp,di
loc_203:
		jmp	bx			;*
		mov	ax,1
		jmp	short loc_204		; (157F)
		db	 33h,0C0h
loc_204:
		call	sub_77			; (1617)
		repe	cmpsw			; Rep zf=1+cx >0 Cmp [si] to es:[di]
		mov	ds,dx
		jz	loc_205			; Jump if zero
		xor	ax,1
loc_205:
		or	ax,ax			; Zero ?
		retn	40h
		xor	ax,ax			; Zero register
		jmp	short loc_206		; (1597)
		db	0B8h, 01h, 00h
loc_206:
		call	sub_77			; (1617)
		dec	ax
		jnz	locloop_207		; Jump if not zero
		xchg	di,si
  
locloop_207:
		lodsw				; String [si] to ax
		or	ax,[di]
		scasw				; Scan es:[di] for ax
		jnz	loc_208			; Jump if not zero
		loop	locloop_207		; Loop if cx > 0
  
		mov	ax,1
		jmp	short loc_209		; (15AE)
loc_208:
		xor	ax,ax			; Zero register
loc_209:
		mov	ds,dx
		or	ax,ax			; Zero ?
		retn	40h
		db	0E8h, 5Fh, 00h
  
locloop_210:
		lodsw				; String [si] to ax
		or	ax,[di]
		stosw				; Store ax to es:[di]
		loop	locloop_210		; Loop if cx > 0
  
		mov	ds,dx
		retn	20h
		db	0E8h, 51h, 00h
  
locloop_211:
		lodsw				; String [si] to ax
		not	ax
		and	ax,[di]
		stosw				; Store ax to es:[di]
		loop	locloop_211		; Loop if cx > 0
  
		mov	ds,dx
		retn	20h
		db	0E8h, 41h, 00h
  
locloop_212:
		lodsw				; String [si] to ax
		and	ax,[di]
		stosw				; Store ax to es:[di]
		loop	locloop_212		; Loop if cx > 0
  
		mov	ds,dx
		retn	20h
		mov	bx,sp
		mov	ax,ss:[bx+22h]
		or	ah,ah			; Zero ?
		jz	loc_213			; Jump if zero
		xor	ax,ax			; Zero register
		jmp	short loc_214		; (15FB)
loc_213:
		call	sub_76			; (1600)
		and	al,ss:[bx]
		mov	ax,0
		jz	loc_214			; Jump if zero
		inc	ax
loc_214:
		or	ax,ax			; Zero ?
		retn	22h
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_76		proc	near
		mov	bl,al
		xor	bh,bh			; Zero register
		mov	cl,3
		shr	bx,cl			; Shift w/zeros fill
		add	bx,4
		add	bx,sp
		mov	cl,al
		and	cl,7
		mov	al,1
		shl	al,cl			; Shift w/zeros fill
		retn
sub_76		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_77		proc	near
		mov	si,sp
		add	si,4
		mov	di,sp
		add	di,24h
		mov	dx,ds
		push	ss
		pop	es
		push	ss
		pop	ds
		mov	cx,10h
		cld				; Clear direction
		retn
sub_77		endp
  
		cmp	ax,bx
		mov	ax,0
		jnz	loc_215			; Jump if not zero
		cmp	dx,cx
		jne	loc_215			; Jump if not equal
		inc	ax
loc_215:
		or	ax,ax			; Zero ?
		retn
		cmp	ax,bx
		mov	ax,1
		jnz	loc_216			; Jump if not zero
		cmp	dx,cx
		jne	loc_216			; Jump if not equal
		dec	ax
loc_216:
		or	ax,ax			; Zero ?
		retn
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_78		proc	near
loc_217:
		mov	data_182,8000h		; (8876:0220=12h)
		jmp	short loc_219		; (1658)
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_79:
loc_218:
		mov	data_182,0		; (8876:0220=12h)
loc_219:
		or	cl,cl			; Zero ?
		jz	loc_ret_221		; Jump if zero
		xor	di,data_182		; (8876:0220=12h)
		or	al,al			; Zero ?
		jnz	loc_222			; Jump if not zero
loc_220:
		mov	ax,cx
		mov	bx,si
		mov	dx,di
  
loc_ret_221:
		retn
loc_222:
		cmp	al,cl
		jbe	loc_223			; Jump if below or =
		xchg	ax,cx
		xchg	bx,si
		xchg	dx,di
loc_223:
		mov	byte ptr ds:[224h],cl	; (8876:0224=59h)
		sub	cl,al
		cmp	cl,28h			; '('
		jb	loc_224			; Jump if below
		mov	cl,byte ptr ds:[224h]	; (8876:0224=59h)
		jmp	short loc_220		; (1664)
loc_224:
		mov	data_182,di		; (8876:0220=12h)
		and	byte ptr data_182+1,80h	; (8876:0221=0)
		mov	word ptr ds:[222h],di	; (8876:0222=0FEE2h)
		xor	byte ptr ds:[223h],dh	; (8876:0223=0FEh)
		or	di,8000h
		or	dh,80h
loc_225:
		cmp	cl,10h
		jb	loc_226			; Jump if below
		mov	ah,bh
		mov	bx,dx
		xor	dx,dx			; Zero register
		sub	cl,10h
		jmp	short loc_225		; (169D)
loc_226:
		cmp	cl,8
		jb	loc_227			; Jump if below
		mov	ah,bl
		mov	bl,bh
		mov	bh,dl
		mov	dl,dh
		xor	dh,dh			; Zero register
		sub	cl,8
loc_227:
		or	cl,cl			; Zero ?
		jz	loc_229			; Jump if zero
loc_228:
		shr	dx,1			; Shift w/zeros fill
		rcr	bx,1			; Rotate thru carry
		rcr	ah,1			; Rotate thru carry
		dec	cl
		jnz	loc_228			; Jump if not zero
loc_229:
		mov	al,byte ptr ds:[224h]	; (8876:0224=59h)
		test	byte ptr ds:[223h],80h	; (8876:0223=0FEh)
		jnz	loc_230			; Jump if not zero
		add	ah,ch
		adc	bx,si
		adc	dx,di
		jnc	loc_235			; Jump if carry=0
		rcr	dx,1			; Rotate thru carry
		rcr	bx,1			; Rotate thru carry
		rcr	ah,1			; Rotate thru carry
		inc	al
		jnz	loc_235			; Jump if not zero
		stc				; Set carry flag
		retn
loc_230:
		xchg	ah,ch
		xchg	bx,si
		xchg	dx,di
		sub	ah,ch
		sbb	bx,si
		sbb	dx,di
		jnc	loc_231			; Jump if carry=0
		xor	byte ptr data_182+1,80h	; (8876:0221=0)
		not	ah
		not	bx
		not	dx
		add	ah,1
		adc	bx,0
		adc	dx,0
loc_231:
		mov	cl,5
loc_232:
		or	dh,dh			; Zero ?
		jnz	loc_233			; Jump if not zero
		mov	dh,dl
		mov	dl,bh
		mov	bh,bl
		mov	bl,ah
		xor	ah,ah			; Zero register
		sub	al,8
		jc	loc_234			; Jump if carry Set
		dec	cl
		jnz	loc_232			; Jump if not zero
		jmp	short loc_234		; (1736)
loc_233:
		test	dh,80h
		jnz	loc_235			; Jump if not zero
		shl	ah,1			; Shift w/zeros fill
		rcl	bx,1			; Rotate thru carry
		rcl	dx,1			; Rotate thru carry
		dec	al
		jnz	loc_233			; Jump if not zero
loc_234:
		xor	ax,ax			; Zero register
		xor	bx,bx			; Zero register
		xor	dx,dx			; Zero register
		retn
loc_235:
		and	dh,7Fh
		xor	dh,byte ptr data_182+1	; (8876:0221=0)
		retn
sub_78		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_80		proc	near
loc_236:
		or	cl,cl			; Zero ?
		jz	loc_243			; Jump if zero
		or	al,al			; Zero ?
		jz	loc_ret_244		; Jump if zero
		add	al,cl
		call	sub_82			; (1856)
		mov	word ptr ds:[20Eh],ax	; (8876:020E=12h)
		mov	word ptr ds:[210h],bx	; (8876:0210=8BC3h)
		mov	data_173,dx		; (8876:0212=8BC3h)
		xor	ah,ah			; Zero register
		xor	bx,bx			; Zero register
		xor	dx,dx			; Zero register
		mov	di,offset data_175	; (8876:0214=0C8h)
		mov	cl,5
loc_237:
		inc	di
		mov	ch,[di]
		or	ch,ch			; Zero ?
		jnz	loc_238			; Jump if not zero
		mov	ah,bl
		mov	bl,bh
		mov	bh,dl
		mov	dl,dh
		xor	dh,dh			; Zero register
		jmp	short loc_241		; (1797)
loc_238:
		mov	si,8
loc_239:
		rcr	ch,1			; Rotate thru carry
		jnc	loc_240			; Jump if carry=0
		add	ah,byte ptr ds:[20Fh]	; (8876:020F=0)
		adc	bx,word ptr ds:[210h]	; (8876:0210=8BC3h)
		adc	dx,data_173		; (8876:0212=8BC3h)
loc_240:
		rcr	dx,1			; Rotate thru carry
		rcr	bx,1			; Rotate thru carry
		rcr	ah,1			; Rotate thru carry
		dec	si
		jnz	loc_239			; Jump if not zero
loc_241:
		dec	cl
		jnz	loc_237			; Jump if not zero
		xchg	ax,cx
		lahf				; Load ah from flags
		test	dh,80h
		jnz	loc_242			; Jump if not zero
		sahf				; Store ah into flags
		rcl	ch,1			; Rotate thru carry
		rcl	bx,1			; Rotate thru carry
		rcl	dx,1			; Rotate thru carry
		or	cl,cl			; Zero ?
		jz	loc_242			; Jump if zero
		dec	cl
loc_242:
		xchg	ax,cx
		xor	dh,byte ptr data_182+1	; (8876:0221=0)
		or	al,al			; Zero ?
		jnz	loc_ret_244		; Jump if not zero
loc_243:
		xor	ax,ax			; Zero register
		xor	bx,bx			; Zero register
		xor	dx,dx			; Zero register
  
loc_ret_244:
		retn
sub_80		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_81		proc	near
		or	al,al			; Zero ?
		jz	loc_ret_244		; Jump if zero
		sub	al,cl
		cmc				; Complement carry
		call	sub_82			; (1856)
		mov	byte ptr ds:[20Eh],al	; (8876:020E=12h)
		mov	di,offset data_173+1	; (8876:0213=8Bh)
		mov	cl,5
		mov	si,8
loc_245:
		cmp	dx,data_178		; (8876:0218=3)
		jne	loc_246			; Jump if not equal
		cmp	bx,data_177		; (8876:0216=0E805h)
		jne	loc_246			; Jump if not equal
		cmp	ah,byte ptr data_175+1	; (8876:0215=0E3h)
loc_246:
		jb	loc_247			; Jump if below
		sub	ah,byte ptr data_175+1	; (8876:0215=0E3h)
		sbb	bx,data_177		; (8876:0216=0E805h)
		sbb	dx,data_178		; (8876:0218=3)
loc_247:
		cmc				; Complement carry
		rcl	ch,1			; Rotate thru carry
		dec	si
		jnz	loc_248			; Jump if not zero
		mov	[di],ch
		dec	cl
		jz	loc_249			; Jump if zero
		dec	di
		mov	si,8
loc_248:
		shl	ah,1			; Shift w/zeros fill
		rcl	bx,1			; Rotate thru carry
		rcl	dx,1			; Rotate thru carry
		jnc	loc_245			; Jump if carry=0
		sub	ah,byte ptr data_175+1	; (8876:0215=0E3h)
		sbb	bx,data_177		; (8876:0216=0E805h)
		sbb	dx,data_178		; (8876:0218=3)
		clc				; Clear carry flag
		jmp	short loc_247		; (17F2)
loc_249:
		shl	ah,1			; Shift w/zeros fill
		rcl	bx,1			; Rotate thru carry
		rcl	dx,1			; Rotate thru carry
		jc	loc_251			; Jump if carry Set
		cmp	dx,data_178		; (8876:0218=3)
		jne	loc_250			; Jump if not equal
		cmp	bx,data_177		; (8876:0216=0E805h)
		jne	loc_250			; Jump if not equal
		cmp	ah,byte ptr data_175+1	; (8876:0215=0E3h)
loc_250:
		cmc				; Complement carry
loc_251:
		mov	cx,word ptr ds:[20Eh]	; (8876:020E=12h)
		mov	bx,word ptr ds:[210h]	; (8876:0210=8BC3h)
		mov	dx,data_173		; (8876:0212=8BC3h)
		lahf				; Load ah from flags
		test	dh,80h
		jnz	loc_252			; Jump if not zero
		sahf				; Store ah into flags
		rcl	ch,1			; Rotate thru carry
		rcl	bx,1			; Rotate thru carry
		rcl	dx,1			; Rotate thru carry
		jmp	short loc_253		; (1853)
loc_252:
		inc	cl
		jnz	loc_253			; Jump if not zero
		stc				; Set carry flag
		retn
loc_253:
		jmp	loc_242			; (17AF)
sub_81		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_82		proc	near
		jc	loc_254			; Jump if carry Set
		add	al,80h
		jc	loc_255			; Jump if carry Set
		pop	bx
		xor	ax,ax			; Zero register
		xor	bx,bx			; Zero register
		xor	dx,dx			; Zero register
		retn
loc_254:
		add	al,80h
		jnc	loc_255			; Jump if carry=0
		pop	bx
		stc				; Set carry flag
		retn
loc_255:
		mov	data_175,cx		; (8876:0214=0E3C8h)
		mov	cx,dx
		xor	cx,di
		not	ch
		and	ch,80h
		mov	byte ptr data_182+1,ch	; (8876:0221=0)
		or	dh,80h
		or	di,8000h
		mov	data_177,si		; (8876:0216=0E805h)
		mov	data_178,di		; (8876:0218=3)
		retn
sub_82		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_83		proc	near
		push	di
		push	si
		push	cx
		call	sub_79			; (1652)
		pop	cx
		pop	si
		pop	di
		retn
sub_83		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_84		proc	near
		push	di
		push	si
		push	cx
		call	sub_78			; (164A)
		pop	cx
		pop	si
		pop	di
		retn
sub_84		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_85		proc	near
		push	di
		push	si
		push	cx
		call	sub_80			; (1745)
		pop	cx
		pop	si
		pop	di
		retn
sub_85		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_86		proc	near
		push	di
		push	si
		push	cx
		call	sub_81			; (17BF)
		pop	cx
		pop	si
		pop	di
		retn
sub_86		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_87		proc	near
		push	dx
		xor	dx,di
		pop	dx
		jns	loc_256			; Jump if not sign
		push	dx
		rcl	dx,1			; Rotate thru carry
		pop	dx
		retn
loc_256:
		test	dh,80h
		jz	loc_257			; Jump if zero
		call	sub_88			; (18CB)
		jz	loc_ret_258		; Jump if zero
		cmc				; Complement carry
		retn
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_88:
loc_257:
		cmp	al,cl
		jne	loc_ret_258		; Jump if not equal
		or	al,al			; Zero ?
		jz	loc_ret_258		; Jump if zero
		cmp	dx,di
		jne	loc_ret_258		; Jump if not equal
		cmp	bx,si
		jne	loc_ret_258		; Jump if not equal
		cmp	ah,ch
  
loc_ret_258:
		retn
sub_87		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_89		proc	near
		or	ax,ax			; Zero ?
		jnz	loc_259			; Jump if not zero
		xor	bx,bx			; Zero register
		xor	dx,dx			; Zero register
		retn
loc_259:
		mov	bh,ah
		mov	dx,ax
		or	dx,dx			; Zero ?
		jns	loc_260			; Jump if not sign
		neg	dx
loc_260:
		mov	ax,90h
		or	dh,dh			; Zero ?
		jnz	loc_261			; Jump if not zero
		mov	al,88h
		xchg	dl,dh
loc_261:
		or	dx,dx			; Zero ?
		js	loc_263			; Jump if sign=1
loc_262:
		dec	al
		shl	dx,1			; Shift w/zeros fill
		jns	loc_262			; Jump if not sign
loc_263:
		or	bh,bh			; Zero ?
		js	loc_264			; Jump if sign=1
		and	dh,7Fh
loc_264:
		xor	bx,bx			; Zero register
		retn
sub_89		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_90		proc	near
		cmp	al,0A8h
		jae	loc_ret_270		; Jump if above or =
		mov	cx,ax
		mov	si,bx
		mov	di,dx
		xor	ah,ah			; Zero register
		xor	bx,bx			; Zero register
		xor	dx,dx			; Zero register
		sub	cl,80h
		jbe	loc_271			; Jump if below or =
loc_265:
		cmp	cl,10h
		jb	loc_266			; Jump if below
		mov	ah,bh
		mov	bx,dx
		mov	dx,0FFFFh
		sub	cl,10h
		jmp	short loc_265		; (1925)
loc_266:
		cmp	cl,8
		jb	loc_267			; Jump if below
		mov	ah,bl
		mov	bl,bh
		mov	bh,dl
		mov	dl,dh
		mov	dh,0FFh
		sub	cl,8
loc_267:
		or	cl,cl			; Zero ?
		jz	loc_269			; Jump if zero
loc_268:
		stc				; Set carry flag
		rcr	dx,1			; Rotate thru carry
		rcr	bx,1			; Rotate thru carry
		rcr	ah,1			; Rotate thru carry
		dec	cl
		jnz	loc_268			; Jump if not zero
loc_269:
		and	dx,di
		and	bx,si
		and	ah,ch
  
loc_ret_270:
		retn
loc_271:
		xor	al,al			; Zero register
		retn
sub_90		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_91		proc	near
		push	dx
		push	bx
		push	ax
		call	sub_90			; (1910)
		mov	cx,ax
		mov	si,bx
		mov	di,dx
		pop	ax
		pop	bx
		pop	dx
		jmp	loc_217			; (164A)
sub_91		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_92		proc	near
		pop	bx
		pop	es
		push	word ptr es:[di+4]
		push	word ptr es:[di+2]
		push	word ptr es:[di]
		jmp	bx			;*Register jump
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_93:
		pop	bx
		push	word ptr cs:[bx+4]
		push	word ptr cs:[bx+2]
		push	word ptr cs:[bx]
		add	bx,6
		jmp	bx			;*Register jump
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_94:
		pop	bx
		pop	ax
		pop	cx
		pop	dx
		pop	di
		pop	es
		mov	es:[di],ax
		mov	es:[di+2],cx
		mov	es:[di+4],dx
		jmp	bx			;*Register jump
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_95:
		pop	word ptr ds:data_44e	; (0274:0186=1689h)
		pop	cx
		pop	si
		pop	di
		pop	ax
		pop	bx
		pop	dx
		call	sub_79			; (1652)
loc_272:
		jc	loc_273			; Jump if carry Set
		push	dx
		push	bx
		push	ax
		jmp	data_141		; (8876:0186=5007h)
loc_273:
		mov	dl,1
		jmp	loc_150			; (103C)
sub_92		endp
  
		pop	data_141		; (8876:0186=5007h)
		pop	cx
		pop	si
		pop	di
		pop	ax
		pop	bx
		pop	dx
		call	sub_78			; (164A)
		jmp	short loc_272		; (19B3)
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_96		proc	near
		pop	word ptr ds:data_44e	; (0274:0186=1689h)
		pop	cx
		pop	si
		pop	di
		pop	ax
		pop	bx
		pop	dx
loc_274:
		call	sub_80			; (1745)
		jmp	short loc_272		; (19B3)
sub_96		endp
  
		pop	data_141		; (8876:0186=5007h)
		pop	cx
		pop	si
		pop	di
		pop	ax
		pop	bx
		pop	dx
		or	cl,cl			; Zero ?
		jz	loc_275			; Jump if zero
		call	sub_81			; (17BF)
		jmp	short loc_272		; (19B3)
loc_275:
		mov	dl,2
		jmp	loc_150			; (103C)
		mov	bx,sp
		cmp	byte ptr ss:[bx+2],0
		je	loc_ret_276		; Jump if equal
		xor	byte ptr ss:[bx+7],80h
  
loc_ret_276:
		retn
		mov	bx,sp
		and	byte ptr ss:[bx+7],7Fh
		retn
		pop	data_141		; (8876:0186=5007h)
		pop	cx
		pop	si
		pop	di
		pop	ax
		pop	bx
		pop	dx
		call	sub_87			; (18B4)
		push	data_141		; (8876:0186=5007h)
		mov	ax,1
		jz	loc_277			; Jump if zero
		dec	ax
loc_277:
		or	ax,ax			; Zero ?
		retn
		pop	data_141		; (8876:0186=5007h)
		pop	cx
		pop	si
		pop	di
		pop	ax
		pop	bx
		pop	dx
		call	sub_87			; (18B4)
		push	data_141		; (8876:0186=5007h)
		mov	ax,1
		jnz	loc_278			; Jump if not zero
		dec	ax
loc_278:
		or	ax,ax			; Zero ?
		retn
		pop	data_141		; (8876:0186=5007h)
		pop	cx
		pop	si
		pop	di
		pop	ax
		pop	bx
		pop	dx
		call	sub_87			; (18B4)
		push	data_141		; (8876:0186=5007h)
		mov	ax,1
		jnc	loc_279			; Jump if carry=0
		dec	ax
loc_279:
		or	ax,ax			; Zero ?
		retn
		pop	data_141		; (8876:0186=5007h)
		pop	cx
		pop	si
		pop	di
		pop	ax
		pop	bx
		pop	dx
		call	sub_87			; (18B4)
		push	data_141		; (8876:0186=5007h)
		mov	ax,1
		jbe	loc_280			; Jump if below or =
		dec	ax
loc_280:
		or	ax,ax			; Zero ?
		retn
		pop	data_141		; (8876:0186=5007h)
		pop	cx
		pop	si
		pop	di
		pop	ax
		pop	bx
		pop	dx
		call	sub_87			; (18B4)
		push	data_141		; (8876:0186=5007h)
		mov	ax,1
		ja	loc_281			; Jump if above
		dec	ax
loc_281:
		or	ax,ax			; Zero ?
		retn
		pop	data_141		; (8876:0186=5007h)
		pop	cx
		pop	si
		pop	di
		pop	ax
		pop	bx
		pop	dx
		call	sub_87			; (18B4)
		push	data_141		; (8876:0186=5007h)
		mov	ax,1
		jc	loc_282			; Jump if carry Set
		dec	ax
loc_282:
		or	ax,ax			; Zero ?
		retn
		pop	data_141		; (8876:0186=5007h)
		pop	ax
		pop	bx
		pop	dx
		mov	cx,ax
		mov	si,bx
		mov	di,dx
		jmp	loc_274			; (19DA)
		pop	data_141		; (8876:0186=5007h)
		pop	ax
		pop	bx
		pop	dx
		call	sub_90			; (1910)
		jmp	$-10Fh
		pop	data_141		; (8876:0186=5007h)
		pop	ax
		pop	bx
		pop	dx
		call	sub_91			; (1961)
		jmp	$-11Ch
		call	sub_59			; (10E6)
		mov	dx,80h
		mov	al,20h			; ' '
loc_283:
		test	bh,80h
		jnz	loc_284			; Jump if not zero
		shl	cx,1			; Shift w/zeros fill
		rcl	bx,1			; Rotate thru carry
		dec	dl
		dec	al
		jnz	loc_283			; Jump if not zero
		xor	dl,dl			; Zero register
loc_284:
		and	bh,7Fh
		pop	ax
		push	bx
		push	cx
		push	dx
		jmp	ax			;*
		mov	ch,0FFh
		jmp	short loc_285		; (1AFC)
		db	 32h,0EDh
loc_285:
		pop	bx
		pop	ax
		pop	dx
		pop	dx
		push	bx
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_97		proc	near
		xchg	ax,dx
		mov	cl,8Fh
		sub	cl,dl
		jc	loc_289			; Jump if carry Set
		cmp	cl,0Fh
		ja	loc_288			; Jump if above
		inc	cl
		mov	bh,ah
		or	ah,80h
		shr	ax,cl			; Shift w/zeros fill
		jnc	loc_286			; Jump if carry=0
		or	ch,ch			; Zero ?
		jz	loc_286			; Jump if zero
		inc	ax
		js	loc_289			; Jump if sign=1
loc_286:
		test	bh,80h
		jz	loc_ret_287		; Jump if zero
		neg	ax
  
loc_ret_287:
		retn
loc_288:
		xor	ax,ax			; Zero register
		retn
loc_289:
		mov	dl,92h
		jmp	loc_149			; (1038)
sub_97		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_98		proc	near
		call	sub_89			; (18DE)
		pop	cx
		push	dx
		push	bx
		push	ax
		jmp	cx			;*
		pop	word ptr ds:data_44e	; (0274:0186=1689h)
		pop	cx
		pop	si
		pop	di
		pop	ax
		call	sub_89			; (18DE)
		push	dx
		push	bx
		push	ax
		push	di
		push	si
		push	cx
		jmp	word ptr ds:data_44e	; (0274:0186=1689h)
		pop	word ptr ds:data_44e	; (0274:0186=1689h)
		pop	ax
		pop	bx
		pop	dx
		mov	cx,ax
		mov	si,bx
		mov	di,dx
		or	al,al			; Zero ?
		jz	loc_291			; Jump if zero
		test	dh,80h
		jnz	loc_292			; Jump if not zero
		mov	word ptr ds:[21Ah],ax	; (0274:021A=0C603h)
		mov	word ptr ds:[21Ch],bx	; (0274:021C=405h)
		mov	word ptr ds:[21Eh],dx	; (0274:021E=4C6h)
		add	cl,80h
		sar	cl,1			; Shift w/sign fill
		add	cl,80h
		mov	al,cl
		sub	al,14h
		mov	byte ptr ds:[225h],al	; (0274:0225=0B8h)
loc_290:
		mov	ax,word ptr ds:[21Ah]	; (0274:021A=0C603h)
		mov	bx,word ptr ds:[21Ch]	; (0274:021C=405h)
		mov	dx,word ptr ds:[21Eh]	; (0274:021E=4C6h)
		call	sub_86			; (18AA)
		call	sub_83			; (188C)
		dec	al
		push	dx
		push	bx
		push	ax
		call	sub_78			; (164A)
		cmp	al,byte ptr ds:[225h]	; (8876:0225=0C3h)
		pop	cx
		pop	si
		pop	di
		jnc	loc_290			; Jump if carry=0
loc_291:
		push	di
		push	si
		push	cx
		jmp	data_141		; (8876:0186=5007h)
loc_292:
		mov	dl,3
		jmp	loc_150			; (103C)
sub_98		endp
  
		pop	data_141		; (8876:0186=5007h)
		pop	cx
		pop	si
		pop	di
		mov	ax,2181h
		mov	bx,0DAA2h
		mov	dx,490Fh
		call	sub_78			; (164A)
		jmp	short loc_293		; (1BC7)
		pop	data_141		; (8876:0186=5007h)
		pop	ax
		pop	bx
		pop	dx
loc_293:
		cmp	al,6Ch			; 'l'
		jb	$+5Dh			; Jump if below
		mov	cx,2183h
		mov	si,0DAA2h
		mov	di,490Fh
		push	dx
		and	dh,7Fh
		call	sub_87			; (18B4)
		pop	dx
		jc	loc_294			; Jump if carry Set
		call	sub_86			; (18AA)
		push	di
		push	si
		push	cx
		call	sub_91			; (1961)
		pop	cx
		pop	si
		pop	di
		call	sub_85			; (18A0)
loc_294:
		test	dh,80h
		jz	loc_295			; Jump if zero
		call	sub_83			; (188C)
loc_295:
		dec	cl
		call	sub_87			; (18B4)
		pushf				; Push flags
		jc	loc_296			; Jump if carry Set
		call	sub_84			; (1896)
loc_296:
		dec	cl
		call	sub_87			; (18B4)
		jc	loc_297			; Jump if carry Set
		inc	cl
		or	dh,80h
		call	sub_79			; (1652)
loc_297:
		cmp	al,6Ch			; 'l'
		jb	loc_298			; Jump if below
		mov	di,1C29h
		mov	cx,7
		call	sub_100			; (1EE2)
loc_298:
		popf				; Pop flags
		jc	$+9			; Jump if carry Set
		or	al,al			; Zero ?
		jz	$+5			; Jump if zero
		xor	dh,80h
		jmp	$-271h
		pop	ax
		popf				; Pop flags
		cmp	word ptr ds:[0D73Fh][bx],bx	; (8876:D73F=0)
		db	 60h, 43h, 9Dh, 30h, 92h, 30h
		db	 67h,0AAh, 3Fh, 28h, 32h,0D7h
		db	 6Eh,0B6h, 2Ah, 1Dh,0EFh, 38h
		db	 74h, 0Dh,0D0h, 00h, 0Dh,0D0h
		db	 7Ah, 88h, 88h, 88h, 88h, 08h
		db	 7Eh,0ABh,0AAh,0AAh,0AAh,0AAh
		db	 8Fh, 06h, 86h, 01h, 58h, 5Bh
		db	 5Ah, 0Ah,0C0h, 74h, 05h,0F6h
		db	0C6h, 80h, 74h, 05h
loc_299:
		mov	dl,4
		jmp	loc_150			; (103C)
loc_300:
		mov	ch,ah
		mov	cl,81h
		sub	al,cl
		cbw				; Convrt byte to word
		push	ax
		xchg	ax,cx
		mov	cx,0FB80h
		mov	si,0F333h
		mov	di,3504h
		call	sub_80			; (1745)
		mov	cx,ax
		mov	si,bx
		mov	di,dx
		mov	ax,81h
		xor	bx,bx			; Zero register
		xor	dx,dx			; Zero register
		call	sub_83			; (188C)
		push	dx
		push	bx
		push	ax
		mov	ax,81h
		xor	bx,bx			; Zero register
		mov	dx,8000h
		call	sub_79			; (1652)
		pop	cx
		pop	si
		pop	di
		call	sub_81			; (17BF)
		mov	di,1CDFh
		mov	cx,6
		call	sub_100			; (1EE2)
		inc	al
		mov	cx,0D27Fh
		mov	si,17F7h
		mov	di,3172h
		call	sub_79			; (1652)
		pop	cx
		push	dx
		push	bx
		push	ax
		xchg	ax,cx
		call	sub_89			; (18DE)
		mov	cx,0D280h
		mov	si,17F7h
		mov	di,3172h
		call	sub_80			; (1745)
		pop	cx
		pop	si
		pop	di
		call	sub_79			; (1652)
		cmp	al,67h			; 'g'
		jae	$+8			; Jump if above or =
		xor	ax,ax			; Zero register
		xor	bx,bx			; Zero register
		xor	dx,dx			; Zero register
		jmp	$-327h
		jge	$-74h			; Jump if > or =
		popf				; Pop flags
		esc	0,ds:[7D1Dh][bx+di]	; (8876:7D1D=0) coprocessor escape
		jmp	$-745Bh
		cmp	bh,cs:[di-72h]
		jcxz	$+3Ah			; Jump if cx=0
		db	 8Eh, 63h, 7Eh, 49h, 92h, 24h
		db	 49h, 12h, 7Eh,0CDh,0CCh,0CCh
		db	0CCh, 4Ch, 7Fh,0ABh,0AAh,0AAh
		db	0AAh, 2Ah, 8Fh, 06h, 86h, 01h
		db	 58h, 5Bh, 5Ah,0F6h,0C6h, 80h
		db	 9Ch, 80h,0E6h, 7Fh,0B9h, 80h
		db	0D2h,0BEh,0F7h, 17h,0BFh, 72h
		db	 31h,0E8h,0A2h,0FAh, 3Ch, 88h
		db	 73h, 55h, 52h, 53h, 50h,0FEh
		db	0C0h,0B5h,0FFh,0E8h,0D6h,0FDh
		db	 59h, 5Eh, 5Fh, 50h,0E8h,0ACh
		db	0FBh, 0Ah,0C0h, 74h, 02h,0FEh
		db	0C8h
loc_301:
		xchg	ax,cx
		xchg	bx,si
		xchg	dx,di
		call	sub_78			; (164A)
		mov	di,1D7Ch
		mov	cx,8
		call	sub_101			; (1EFB)
		pop	cx
		shr	cx,1			; Shift w/zeros fill
;*		jnc	loc_302			;*Jump if carry=0
		db	 73h, 0Eh
		push	cx
		mov	cx,0FB81h
		mov	si,0F333h
		mov	di,3504h
		call	sub_80			; (1745)
		pop	cx
loc_302:
		add	al,cl
		jc	$+18h			; Jump if carry Set
		popf				; Pop flags
;*		jz	loc_303			;*Jump if zero
		db	 74h, 10h
		mov	cx,ax
		mov	si,bx
		mov	di,dx
		mov	ax,81h
		xor	bx,bx			; Zero register
		xor	dx,dx			; Zero register
		call	sub_81			; (17BF)
loc_303:
		jmp	$-3BEh
		pop	ax
		mov	dl,1
		jmp	loc_150			; (103C)
		db	 6Dh, 2Eh, 1Dh, 11h, 60h, 31h
		db	 70h, 46h, 2Ch,0FEh,0E5h, 7Fh
		db	 74h, 36h, 7Ch, 89h, 84h, 21h
		db	 77h, 53h, 3Ch,0FFh,0C3h, 2Eh
		db	 7Ah,0D2h, 7Dh, 5Bh, 95h, 1Dh
		db	 7Ch, 25h,0B8h, 46h, 58h, 63h
		db	 7Eh, 16h,0FCh,0EFh,0FDh, 75h
		db	 80h,0D2h,0F7h, 17h, 72h, 31h
		db	 8Fh, 06h, 86h, 01h, 58h, 5Bh
		db	 5Ah, 0Ah,0C0h, 74h,0BCh, 33h
		db	0C9h,0F6h,0C6h, 80h, 74h, 04h
		db	 41h, 80h,0E6h, 7Fh, 51h,0B9h
		db	 81h, 00h, 33h,0F6h, 33h,0FFh
		db	0E8h,0E7h,0FAh, 72h, 0Ch, 91h
		db	 87h,0DEh, 87h,0D7h,0E8h,0E8h
		db	0F9h
		db	 59h, 41h, 41h, 51h
loc_304:
		mov	cx,4A7Eh
		mov	si,0E98Eh
		mov	di,0C6Fh
		call	sub_87			; (18B4)
;*		jnc	loc_305			;*Jump if carry=0
		db	 73h, 05h
		call	sub_99			; (1EDC)
;*		jmp	short loc_308		;*(1E69)
		db	0EBh, 7Bh
loc_305:
		mov	di,1E8Eh
		mov	cx,2
  
locloop_306:
		push	cx
		push	di
		mov	cx,cs:[di]
		mov	si,cs:[di+2]
		mov	di,cs:[di+4]
		call	sub_87			; (18B4)
		pop	di
		pop	cx
;*		jc	loc_307			;*Jump if carry Set
		db	 72h, 08h
		add	di,12h
		loop	locloop_306		; Loop if cx > 0
  
		sub	di,6
loc_307:
		add	di,6
		mov	data_179,ax		; (8876:021A=0FBE2h)
		mov	data_180,bx		; (8876:021C=51C3h)
		mov	data_181,dx		; (8876:021E=0E8Bh)
		push	di
		mov	cx,cs:[di]
		mov	si,cs:[di+2]
		mov	di,cs:[di+4]
		call	sub_84			; (1896)
		push	dx
		push	bx
		push	ax
		mov	ax,data_179		; (8876:021A=0FBE2h)
		mov	bx,data_180		; (8876:021C=51C3h)
		mov	dx,data_181		; (8876:021E=0E8Bh)
		call	sub_80			; (1745)
		mov	cx,81h
		xor	si,si			; Zero register
		xor	di,di			; Zero register
		call	sub_79			; (1652)
		mov	cx,ax
		mov	si,bx
		mov	di,dx
		pop	ax
		pop	bx
		pop	dx
		call	sub_81			; (17BF)
		call	sub_99			; (1EDC)
		pop	di
		add	di,6
		mov	cx,cs:[di]
		mov	si,cs:[di+2]
		mov	di,cs:[di+4]
		call	sub_79			; (1652)
loc_308:
		pop	cx
		test	cl,2
;*		jz	loc_310			;*Jump if zero
		db	 74h, 14h
		push	cx
		mov	cx,ax
		mov	si,bx
		mov	di,dx
		mov	ax,2181h
		mov	bx,0DAA2h
		mov	dx,490Fh
		call	sub_78			; (164A)
		pop	cx
loc_310:
		test	cl,1
;*		jz	loc_311			;*Jump if zero
		db	 74h, 03h
		or	dh,80h
loc_311:
		jmp	$-4D6h
;*		jg	loc_309			;*Jump if >
		db	 7Fh,0E7h
		iret				; Interrupt return
		db	0CCh, 13h, 54h, 7Fh,0F6h,0F4h
		db	0A2h, 30h, 09h, 7Fh, 6Ah,0C1h
		db	 91h, 0Ah, 06h, 80h,0B5h, 9Eh
		db	 8Ah, 6Fh, 44h, 80h, 82h, 2Ch
		db	 3Ah,0CDh, 13h, 80h, 6Ah,0C1h
		db	 91h, 0Ah, 06h, 81h, 00h, 00h
		db	 00h, 00h, 00h, 80h, 21h,0A2h
		db	0DAh, 0Fh, 49h, 7Dh,0E8h,0A2h
		db	 8Bh, 2Eh,0BAh, 7Dh, 8Eh,0E3h
		db	 38h, 8Eh, 63h, 7Eh, 49h, 92h
		db	 24h, 49h, 92h, 7Eh,0CDh,0CCh
		db	0CCh,0CCh, 4Ch, 7Fh,0ABh,0AAh
		db	0AAh,0AAh,0AAh
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_99		proc	near
		mov	di,1EBEh
		mov	cx,5
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_100:
		push	dx
		push	bx
		push	ax
		push	cx
		push	di
		mov	cx,ax
		mov	si,bx
		mov	di,dx
		call	sub_80			; (1745)
		pop	di
		pop	cx
		call	sub_101			; (1EFB)
		pop	cx
		pop	si
		pop	di
		jmp	loc_236			; (1745)
sub_99		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_101		proc	near
		mov	data_179,ax		; (8876:021A=0FBE2h)
		mov	data_180,bx		; (8876:021C=51C3h)
		mov	data_181,dx		; (8876:021E=0E8Bh)
		mov	ax,cs:[di]
		mov	bx,cs:[di+2]
		mov	dx,cs:[di+4]
		push	cx
		push	di
		jmp	short loc_313		; (1F25)
  
locloop_312:
		push	cx
		push	di
		mov	cx,cs:[di]
		mov	si,cs:[di+2]
		mov	di,cs:[di+4]
		call	sub_79			; (1652)
loc_313:
		mov	cx,data_179		; (8876:021A=0FBE2h)
		mov	si,data_180		; (8876:021C=51C3h)
		mov	di,data_181		; (8876:021E=0E8Bh)
		call	sub_80			; (1745)
		pop	di
		pop	cx
		add	di,6
		loop	locloop_312		; Loop if cx > 0
  
		mov	cx,81h
		xor	si,si			; Zero register
		xor	di,di			; Zero register
		jmp	loc_218			; (1652)
sub_101		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_102		proc	near
		push	bx
		cmp	dx,19h
		jb	loc_317			; Jump if below
		mov	ax,cx
		call	sub_40			; (0AC9)
		mov	dl,7
		test	byte ptr [di+5],80h
		jz	loc_314			; Jump if zero
		inc	dl
loc_314:
		sub	al,dl
		jnc	loc_315			; Jump if carry=0
		xor	al,al			; Zero register
loc_315:
		cmp	al,9
		jb	loc_316			; Jump if below
		mov	al,9
loc_316:
		inc	al
		mov	dl,al
		mov	dh,al
loc_317:
		push	dx
		call	sub_106			; (2009)
		pop	dx
		mov	al,dl
		inc	al
		or	dh,dh			; Zero ?
		jnz	loc_319			; Jump if not zero
		add	al,cl
		jns	loc_318			; Jump if not sign
		mov	byte ptr ds:[226h],0	; (8876:0226=55h)
		jmp	short loc_320		; (1F8D)
loc_318:
		cmp	al,0Ch
		jb	loc_319			; Jump if below
		mov	al,0Bh
loc_319:
		call	sub_107			; (20A3)
loc_320:
		pop	bx
		mov	si,226h
		test	ch,80h
		jz	loc_321			; Jump if zero
		mov	al,2Dh			; '-'
		call	sub_105			; (2005)
loc_321:
		mov	ch,cl
		or	dh,dh			; Zero ?
		jz	loc_322			; Jump if zero
		mov	ch,0
loc_322:
		or	ch,ch			; Zero ?
		jns	loc_323			; Jump if not sign
		call	sub_104			; (2003)
		jmp	short loc_324		; (1FB3)
loc_323:
		call	sub_103			; (1FFA)
		dec	ch
		jns	loc_323			; Jump if not sign
loc_324:
		or	dl,dl			; Zero ?
		jz	loc_327			; Jump if zero
		mov	al,2Eh			; '.'
		call	sub_105			; (2005)
loc_325:
		inc	ch
		jz	loc_326			; Jump if zero
		call	sub_104			; (2003)
		dec	dl
		jnz	loc_325			; Jump if not zero
loc_326:
		dec	dl
		js	loc_327			; Jump if sign=1
		call	sub_103			; (1FFA)
		jmp	short loc_326		; (1FC7)
loc_327:
		or	dh,dh			; Zero ?
		jnz	loc_328			; Jump if not zero
		retn
loc_328:
		mov	al,45h			; 'E'
		call	sub_105			; (2005)
		mov	al,2Bh			; '+'
		or	cl,cl			; Zero ?
		jns	loc_329			; Jump if not sign
		neg	cl
		mov	al,2Dh			; '-'
loc_329:
		call	sub_105			; (2005)
		mov	al,2Fh			; '/'
loc_330:
		inc	al
		sub	cl,0Ah
		jnc	loc_330			; Jump if carry=0
		call	sub_105			; (2005)
		add	cl,3Ah			; ':'
		mov	al,cl
		jmp	short loc_332		; (2005)
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_103:
		mov	al,[si]
		or	al,al			; Zero ?
		jz	loc_331			; Jump if zero
		inc	si
		jmp	short loc_332		; (2005)
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_104:
loc_331:
		mov	al,30h			; '0'
sub_102		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_105		proc	near
loc_332:
		mov	[bx],al
		inc	bx
		retn
sub_105		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_106		proc	near
		mov	ax,[di]
		mov	bx,[di+2]
		mov	dx,[di+4]
		or	al,al			; Zero ?
		jnz	loc_334			; Jump if not zero
		mov	si,offset ds:[226h]	; (8876:0226=55h)
loc_333:
		mov	word ptr [si],3030h
		inc	si
		inc	si
		cmp	si,232h
		jne	loc_333			; Jump if not equal
		mov	cx,0
		retn
loc_334:
		mov	ch,dh
		and	dh,7Fh
		push	ax
		push	dx
		sub	al,80h
		cbw				; Convrt byte to word
		mov	dx,4Dh
		imul	dx			; dx:ax = reg * ax
		add	ax,5
		mov	cl,ah
		pop	dx
		pop	ax
		cmp	cl,0D9h
		jne	loc_335			; Jump if not equal
		inc	cl
loc_335:
		push	cx
		neg	cl
		call	sub_113			; (21C1)
		pop	cx
		cmp	al,81h
		jae	loc_336			; Jump if above or =
		call	sub_114			; (2248)
		dec	cl
loc_336:
		push	cx
		or	dh,80h
		mov	cl,84h
		sub	cl,al
		mov	al,0
		jz	loc_338			; Jump if zero
loc_337:
		shr	dx,1			; Shift w/zeros fill
		rcr	bx,1			; Rotate thru carry
		rcr	ax,1			; Rotate thru carry
		dec	cl
		jnz	loc_337			; Jump if not zero
loc_338:
		mov	si,offset ds:[226h]	; (8876:0226=55h)
loc_339:
		mov	ch,dh
		mov	cl,4
		shr	ch,cl			; Shift w/zeros fill
		add	ch,30h			; '0'
		mov	[si],ch
		and	dh,0Fh
		push	dx
		push	bx
		push	ax
		shl	ax,1			; Shift w/zeros fill
		rcl	bx,1			; Rotate thru carry
		rcl	dx,1			; Rotate thru carry
		shl	ax,1			; Shift w/zeros fill
		rcl	bx,1			; Rotate thru carry
		rcl	dx,1			; Rotate thru carry
		pop	cx
		add	ax,cx
		pop	cx
		adc	bx,cx
		pop	cx
		adc	dx,cx
		shl	ax,1			; Shift w/zeros fill
		rcl	bx,1			; Rotate thru carry
		rcl	dx,1			; Rotate thru carry
		inc	si
		cmp	si,232h
		jne	loc_339			; Jump if not equal
		pop	cx
		retn
sub_106		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_107		proc	near
		xor	ah,ah			; Zero register
		mov	bx,offset ds:[226h]	; (8876:0226=55h)
		add	bx,ax
		cmp	byte ptr [bx],35h	; '5'
		mov	byte ptr [bx],0
		jc	loc_ret_342		; Jump if carry Set
loc_340:
		dec	al
		js	loc_341			; Jump if sign=1
		dec	bx
		inc	byte ptr [bx]
		cmp	byte ptr [bx],3Ah	; ':'
		jb	loc_ret_342		; Jump if below
		mov	byte ptr [bx],0
		jmp	short loc_340		; (20B2)
loc_341:
		mov	byte ptr [bx],31h	; '1'
		mov	byte ptr [bx+1],0
		inc	cl
  
loc_ret_342:
		retn
sub_107		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_108		proc	near
		mov	cl,[bx]
		cmp	cl,2Dh			; '-'
		jne	loc_343			; Jump if not equal
		inc	bx
loc_343:
		push	cx
		call	sub_109			; (20EC)
		pop	cx
		jc	loc_ret_345		; Jump if carry Set
		cmp	cl,2Dh			; '-'
		jne	loc_344			; Jump if not equal
		cmp	byte ptr [di],0
		je	loc_344			; Jump if equal
		xor	byte ptr [di+5],80h
loc_344:
		clc				; Clear carry flag
  
loc_ret_345:
		retn
sub_108		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_109		proc	near
		mov	si,bx
		xor	ax,ax			; Zero register
		xor	bx,bx			; Zero register
		xor	dx,dx			; Zero register
		xor	cx,cx			; Zero register
		mov	byte ptr ds:[225h],0	; (8876:0225=0C3h)
loc_346:
		mov	cl,[si]
		cmp	cl,61h			; 'a'
		jb	loc_347			; Jump if below
		cmp	cl,7Ah			; 'z'
		ja	loc_347			; Jump if above
		sub	cl,20h			; ' '
loc_347:
		call	sub_112			; (21B2)
		jc	loc_348			; Jump if carry Set
		call	sub_114			; (2248)
		jc	loc_350			; Jump if carry Set
		push	di
		push	si
		push	cx
		push	dx
		push	bx
		push	ax
		mov	al,cl
		xor	ah,ah			; Zero register
		call	sub_89			; (18DE)
		pop	cx
		pop	si
		pop	di
		call	sub_79			; (1652)
		pop	cx
		pop	si
		pop	di
		test	ch,40h			; '@'
		jz	loc_349			; Jump if zero
		dec	byte ptr ds:[225h]	; (8876:0225=0C3h)
		jmp	short loc_349		; (2143)
loc_348:
		cmp	cl,2Eh			; '.'
		jne	loc_351			; Jump if not equal
		test	ch,40h			; '@'
		stc				; Set carry flag
		jnz	loc_350			; Jump if not zero
		or	ch,40h			; '@'
loc_349:
		inc	si
		jmp	short loc_346		; (20FB)
loc_350:
		mov	bx,si
		retn
loc_351:
		cmp	cl,45h			; 'E'
		mov	cl,byte ptr ds:[225h]	; (8876:0225=0C3h)
		jnz	loc_355			; Jump if not zero
		call	sub_110			; (219A)
		jc	loc_350			; Jump if carry Set
		inc	si
		mov	cl,[si]
		cmp	cl,2Bh			; '+'
		je	loc_352			; Jump if equal
		cmp	cl,2Dh			; '-'
		jne	loc_353			; Jump if not equal
		or	ch,20h			; ' '
loc_352:
		inc	si
loc_353:
		call	sub_111			; (21B0)
		jc	loc_350			; Jump if carry Set
		push	ax
		mov	al,cl
		inc	si
		call	sub_111			; (21B0)
		jc	loc_354			; Jump if carry Set
		mov	ah,al
		shl	al,1			; Shift w/zeros fill
		shl	al,1			; Shift w/zeros fill
		add	al,ah
		shl	al,1			; Shift w/zeros fill
		add	al,cl
		inc	si
loc_354:
		mov	cl,al
		pop	ax
		test	ch,20h			; ' '
		jz	loc_355			; Jump if zero
		neg	cl
loc_355:
		call	sub_110			; (219A)
		mov	[di],ax
		mov	[di+2],bx
		mov	[di+4],dx
		jmp	short loc_350		; (2146)
sub_109		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_110		proc	near
		cmp	cl,0DAh
		jl	loc_356			; Jump if < cmp="" cl,26h="" ;="" '&'="" jg="" loc_356="" ;="" jump="" if="">
		push	cx
		push	si
		push	di
		call	sub_113			; (21C1)
		pop	di
		pop	si
		pop	cx
		retn
loc_356:
		stc				; Set carry flag
		retn
sub_110		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_111		proc	near
		mov	cl,[si]
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_112:
		cmp	cl,30h			; '0'
		jb	loc_ret_357		; Jump if below
		cmp	cl,3Ah			; ':'
		cmc				; Complement carry
		jc	loc_ret_357		; Jump if carry Set
		sub	cl,30h			; '0'
  
loc_ret_357:
		retn
sub_111		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_113		proc	near
		push	dx
		push	bx
		push	ax
		mov	byte ptr ds:[224h],cl	; (8876:0224=59h)
		or	cl,cl			; Zero ?
		jns	loc_358			; Jump if not sign
		neg	cl
loc_358:
		mov	bl,cl
		and	bl,0FCh
		mov	bh,bl
		shr	bl,1			; Shift w/zeros fill
		add	bl,bh
		xor	bh,bh			; Zero register
		lea	di,[bx+220Ch]		; Load effective addr
		mov	ax,cs:[di]
		mov	bx,cs:[di+2]
		mov	dx,cs:[di+4]
		and	cl,3
		jz	loc_360			; Jump if zero
loc_359:
		call	sub_114			; (2248)
		dec	cl
		jnz	loc_359			; Jump if not zero
loc_360:
		mov	cx,ax
		mov	si,bx
		mov	di,dx
		pop	ax
		pop	bx
		pop	dx
		test	byte ptr ds:[224h],80h	; (8876:0224=59h)
		jnz	$+5			; Jump if not zero
		jmp	loc_236			; (1745)
sub_113		endp
  
		jmp	$-0A4Ah
		add	word ptr [bx+si],0
		nop				;*ASM fixup - sign extn byte
		add	[bx+si],al
		mov	es,[bx+si]
		add	[bx+si],al
		inc	ax
		sbb	al,9Bh
		add	[bx+si],al
		and	byte ptr ds:[0A83Eh][si],bh	; (8876:A83E=0)
		add	[bx+si],dl
		movsw				; Mov [si] to es:[di]
		db	0D4h, 68h,0B6h, 04h,0BFh,0C9h
		db	 1Bh, 0Eh,0C3h,0ACh,0C5h,0EBh
		db	 78h, 2Dh,0D0h,0CDh,0CEh, 1Bh
		db	0C2h, 53h,0DEh,0F9h, 78h, 39h
		db	 3Fh, 01h,0EBh, 2Bh,0A8h,0ADh
		db	0C5h, 1Dh,0F8h,0C9h, 7Bh,0CEh
		db	 97h
		db	40h
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_114		proc	near
		or	al,al			; Zero ?
		jnz	loc_361			; Jump if not zero
		retn
loc_361:
		or	dh,80h
		push	cx
		push	dx
		push	bx
		push	ax
		shr	dx,1			; Shift w/zeros fill
		rcr	bx,1			; Rotate thru carry
		rcr	ah,1			; Rotate thru carry
		shr	dx,1			; Shift w/zeros fill
		rcr	bx,1			; Rotate thru carry
		rcr	ah,1			; Rotate thru carry
		pop	cx
		add	ah,ch
		pop	cx
		adc	bx,cx
		pop	cx
		adc	dx,cx
		pop	cx
		jnc	loc_362			; Jump if carry=0
		rcr	dx,1			; Rotate thru carry
		rcr	bx,1			; Rotate thru carry
		rcr	ah,1			; Rotate thru carry
		inc	al
		jnz	loc_362			; Jump if not zero
		stc				; Set carry flag
		retn
loc_362:
		and	dh,7Fh
		add	al,3
		retn
sub_114		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_115		proc	near
		pop	si
		pop	di
		pop	dx
		pop	cx
		pop	bx
		push	di
		push	si
		test	bh,80h
		jnz	loc_365			; Jump if not zero
		or	bh,80h
		mov	al,0A0h
		sub	al,dl
		jc	loc_366			; Jump if carry Set
		cmp	al,20h			; ' '
		jae	loc_365			; Jump if above or =
loc_363:
		or	al,al			; Zero ?
		jz	loc_364			; Jump if zero
		shr	bx,1			; Shift w/zeros fill
		rcr	cx,1			; Rotate thru carry
		dec	al
		jmp	short loc_363		; (2297)
loc_364:
		mov	ax,cx
		mov	dx,bx
		retn
loc_365:
		xor	ax,ax			; Zero register
		xor	dx,dx			; Zero register
		retn
loc_366:
		mov	ax,0FFFFh
		mov	dx,0FFFFh
		retn
sub_115		endp
  
loc_367:
		mov	bx,dx
		mov	cx,ax
		or	ax,dx
		jz	loc_370			; Jump if zero
		mov	dx,0A0h
loc_368:
		test	bh,80h
		jnz	loc_369			; Jump if not zero
		shl	cx,1			; Shift w/zeros fill
		rcl	bx,1			; Rotate thru carry
		dec	dl
		jmp	short loc_368		; (22BF)
loc_369:
		and	bh,7Fh
loc_370:
		pop	ax
		push	bx
		push	cx
		push	dx
		jmp	ax			;*
		mov	al,1
		mov	byte ptr ds:[238h],al	; (8876:0238=55h)
		pop	bx
		call	sub_50			; (0EE6)
		pop	di
		pop	es
		push	bx
		mov	ax,es
		mov	dx,ds
		cmp	ax,dx
		jne	loc_371			; Jump if not equal
		cmp	di,data_17e		; (0000:0166=0)
		jbe	loc_374			; Jump if below or =
loc_371:
		push	di
		mov	si,data_105e		; (8876:00B6=0)
		lea	di,[di+0Ch]		; Load effective addr
		mov	cx,20h
		cld				; Clear direction
		rep	movsw			; Rep when cx >0 Mov [si] to es:[di]
		pop	di
		call	sub_120			; (248B)
		jnc	loc_372			; Jump if carry=0
		mov	al,0
		mov	bx,0FFFFh
loc_372:
		mov	es:[di],bx
		cmp	byte ptr ds:[238h],0	; (8876:0238=55h)
		je	loc_373			; Jump if equal
		mov	es:[di+2],al
		lea	ax,[di+4Ch]		; Load effective addr
		mov	es:[di+4],ax
		retn
loc_373:
		mov	word ptr es:[di+2],0
		retn
loc_374:
		mov	data_137,22h		; (8876:0180=0F9h) '"'
		retn
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_116		proc	near
		xor	al,al			; Zero register
		jmp	short loc_375		; (2334)
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_117:
		mov	al,1
		jmp	short loc_375		; (2334)
		db	0B0h, 02h
loc_375:
		mov	byte ptr ds:[238h],al	; (8876:0238=55h)
		pop	data_141		; (8876:0186=5007h)
		pop	es
		push	data_141		; (8876:0186=5007h)
		mov	al,es:[di+2]
		and	al,0Fh
		jz	loc_377			; Jump if zero
		and	byte ptr es:[di+2],0DFh
  
loc_ret_376:
		retn
loc_377:
		mov	es:[di+6],cx
		call	sub_119			; (245C)
		cmp	data_137,0		; (8876:0180=0F9h)
		jne	loc_ret_376		; Jump if not equal
		call	sub_121			; (24F5)
		cmp	data_137,0		; (8876:0180=0F9h)
		jne	loc_ret_376		; Jump if not equal
		test	data_129,2		; (8876:0172=0F70h)
		jz	loc_378			; Jump if zero
		mov	ax,4400h
		mov	bx,es:[di]
		call	sub_28			; (0957)
		test	dx,80h
		jz	loc_378			; Jump if zero
		mov	word ptr es:[di+6],1
loc_378:
		cmp	byte ptr ds:[238h],1	; (8876:0238=55h)
		jae	loc_379			; Jump if above or =
		mov	byte ptr es:[di+2],80h
		mov	bx,es:[di+4]
		mov	es:[di+8],bx
		mov	es:[di+0Ah],bx
		retn
loc_379:
		jz	loc_384			; Jump if zero
		mov	ax,4202h
		mov	bx,es:[di]
		xor	cx,cx			; Zero register
		xor	dx,dx			; Zero register
		call	sub_28			; (0957)
		mov	cx,es:[di+6]
		cmp	cx,80h
		jb	loc_380			; Jump if below
		mov	cx,80h
loc_380:
		sub	ax,cx
		sbb	dx,0
		jnc	loc_381			; Jump if carry=0
		add	ax,cx
		mov	cx,ax
		xor	ax,ax			; Zero register
		xor	dx,dx			; Zero register
loc_381:
		push	cx
		mov	cx,dx
		mov	dx,ax
		mov	ax,4200h
		mov	bx,es:[di]
		call	sub_28			; (0957)
		call	sub_129			; (26E8)
		pop	dx
		neg	dx
		mov	si,es:[di+8]
loc_382:
		cmp	byte ptr es:[si],1Ah
		je	loc_383			; Jump if equal
		inc	si
		inc	dx
		jnz	loc_382			; Jump if not zero
		jmp	short loc_384		; (23F7)
loc_383:
		mov	ax,4202h
		mov	bx,es:[di]
		mov	cx,0FFFFh
		call	sub_28			; (0957)
loc_384:
		mov	byte ptr es:[di+2],40h	; '@'
		mov	ax,es:[di+4]
		mov	es:[di+8],ax
		add	ax,es:[di+6]
		mov	es:[di+0Ah],ax
  
loc_ret_385:
		retn
sub_116		endp
  
		pop	data_141		; (8876:0186=5007h)
		pop	es
		push	data_141		; (8876:0186=5007h)
		cmp	byte ptr es:[di+2],80h
		jne	loc_ret_385		; Jump if not equal
		mov	dx,es:[di+8]
		sub	dx,es:[di+0Ah]
		jz	loc_386			; Jump if zero
		mov	ax,4201h
		mov	bx,es:[di]
		mov	cx,0FFFFh
		call	sub_28			; (0957)
loc_386:
		mov	ah,40h			; '@'
		mov	bx,es:[di]
		xor	cx,cx			; Zero register
		call	sub_28			; (0957)
		jmp	short loc_384		; (23F7)
		pop	data_141		; (8876:0186=5007h)
		pop	es
		push	data_141		; (8876:0186=5007h)
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_118		proc	near
		cmp	byte ptr es:[di+2],40h	; '@'
		jne	loc_ret_387		; Jump if not equal
		jmp	loc_446			; (2873)
  
loc_ret_387:
		retn
sub_118		endp
  
		pop	data_141		; (8876:0186=5007h)
		pop	es
		push	data_141		; (8876:0186=5007h)
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_119		proc	near
		mov	al,es:[di+2]
		and	al,0Fh
		jnz	loc_ret_389		; Jump if not zero
		call	sub_118			; (2448)
		mov	byte ptr es:[di+2],0
loc_388:
		mov	bx,es:[di]
		cmp	bx,2
		jbe	loc_ret_389		; Jump if below or =
		cmp	bx,0FFFFh
		je	loc_ret_389		; Jump if equal
		mov	word ptr es:[di],0FFFFh
		mov	ah,3Eh			; '>'
		call	sub_28			; (0957)
		jnc	loc_ret_389		; Jump if carry=0
		mov	data_137,0FFh		; (8876:0180=0F9h)
  
loc_ret_389:
		retn
sub_119		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_120		proc	near
		mov	cx,9
		mov	bx,24BFh
  
locloop_390:
		push	cx
		push	bx
		mov	si,data_15e		; (0000:00B6=16h)
		mov	cx,3
  
locloop_391:
		mov	al,[si]
		call	sub_37			; (0AA0)
		cmp	al,cs:[bx]
		je	loc_393			; Jump if equal
		pop	bx
		pop	cx
		add	bx,6
		loop	locloop_390		; Loop if cx > 0
  
loc_392:
		stc				; Set carry flag
		retn
loc_393:
		inc	si
		inc	bx
		loop	locloop_391		; Loop if cx > 0
  
		pop	cx
		pop	cx
		cmp	byte ptr [si],3Ah	; ':'
		jne	loc_392			; Jump if not equal
		mov	al,cs:[bx]
		mov	bx,cs:[bx+1]
		retn
sub_120		endp
  
		inc	bx
		dec	di
		dec	si
		db	0C1h,0FFh,0FFh, 54h, 52h, 4Dh
		db	0C1h,0FFh,0FFh, 4Bh, 42h, 44h
		db	 82h,0FFh,0FFh, 4Ch, 53h, 54h
		db	 43h,0FFh,0FFh, 41h, 55h, 58h
		db	0C4h,0FFh,0FFh, 55h, 53h, 52h
		db	0C5h,0FFh,0FFh, 49h, 4Eh, 50h
		db	 00h, 00h, 00h, 4Fh, 55h, 54h
		db	 00h, 01h, 00h, 45h, 52h, 52h
		db	 00h, 02h, 00h
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_121		proc	near
		cmp	word ptr es:[di],0FFFFh
		jne	loc_ret_396		; Jump if not equal
		mov	ax,3D02h
		mov	dl,1
		test	byte ptr ds:[238h],1	; (8876:0238=55h)
		jz	loc_394			; Jump if zero
		mov	ah,3Ch			; '<' xor="" cx,cx="" ;="" zero="" register="" mov="" dl,0f1h="" loc_394:="" push="" dx="" lea="" dx,[di+0ch]="" ;="" load="" effective="" addr="" call="" sub_28="" ;="" (0957)="" pop="" dx="" jc="" loc_395="" ;="" jump="" if="" carry="" set="" mov="" es:[di],ax="" retn="" loc_395:="" mov="" data_137,dl="" ;="" (8876:0180="0F9h)" cmp="" al,4="" jne="" loc_ret_396="" ;="" jump="" if="" not="" equal="" mov="" data_137,0f3h="" ;="" (8876:0180="0F9h)" loc_ret_396:="" retn="" sub_121="" endp="" pop="" data_141="" ;="" (8876:0186="5007h)" mov="" word="" ptr="" ds:[232h],15ah="" ;="" (8876:0232="6A0h)" mov="" word="" ptr="" ds:[234h],ds="" ;="" (8876:0234="0E900h)" jmp="" data_141="" ;="" (8876:0186="5007h)" ;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß="" ;="" subroutine="" ;üüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüü="" sub_122="" proc="" near="" pop="" data_141="" ;="" (8876:0186="5007h)" pop="" es="" mov="" word="" ptr="" ds:[232h],di="" ;="" (8876:0232="6A0h)" mov="" word="" ptr="" ds:[234h],es="" ;="" (8876:0234="0E900h)" test="" byte="" ptr="" es:[di+2],80h="" jnz="" loc_397="" ;="" jump="" if="" not="" zero="" mov="" data_137,2="" ;="" (8876:0180="0F9h)" loc_397:="" jmp="" data_141="" ;="" (8876:0186="5007h)" ;ßßßß="" external="" entry="" into="" subroutine="" ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß="" sub_123:="" pop="" word="" ptr="" ds:data_19e="" ;="" (0000:0186="0)" mov="" word="" ptr="" ds:data_20e,166h="" ;="" (0000:0232="0)" mov="" ds:data_21e,ds="" ;="" (0000:0234="0)" jmp="" word="" ptr="" ds:data_19e="" ;="" (0000:0186="0)" pop="" word="" ptr="" ds:data_19e="" ;="" (0000:0186="0)" pop="" es="" mov="" ds:data_20e,di="" ;="" (0000:0232="0)" mov="" ds:data_21e,es="" ;="" (0000:0234="0)" test="" byte="" ptr="" es:[di+2],40h="" ;="" '@'="" jnz="" loc_398="" ;="" jump="" if="" not="" zero="" mov="" byte="" ptr="" ds:data_18e,3="" ;="" (0000:0180="0)" loc_398:="" jmp="" word="" ptr="" ds:data_19e="" ;="" (0000:0186="0)" mov="" al,0ffh="" jmp="" short="" loc_399="" ;="" (258d)="" db="" 32h,0c0h="" loc_399:="" pop="" word="" ptr="" ds:data_19e="" ;="" (0000:0186="0)" mov="" word="" ptr="" ds:data_20e,15ah="" ;="" (0000:0232="0)" mov="" ds:data_21e,ds="" ;="" (0000:0234="0)" and="" byte="" ptr="" ds:data_16e,0dfh="" ;="" (0000:015c="0A6h)" push="" es="" push="" di="" push="" ax="" call="" sub_124="" ;="" (25b4)="" pop="" ax="" or="" al,al="" ;="" zero="" jz="" loc_400="" ;="" jump="" if="" zero="" call="" sub_36="" ;="" (0a99)="" loc_400:="" pop="" di="" pop="" es="" jmp="" data_141="" ;="" (8876:0186="5007h)" ;ßßßß="" external="" entry="" into="" subroutine="" ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß="" sub_124:="" xor="" dh,dh="" ;="" zero="" register="" ;ßßßß="" external="" entry="" into="" subroutine="" ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß="" sub_125:="" mov="" ch,data_138="" ;="" (8876:0181="74h)" cmp="" ch,7eh="" ;="" '~'="" jb="" loc_401="" ;="" jump="" if="" below="" mov="" ch,7eh="" ;="" '~'="" loc_401:="" mov="" data_138,7eh="" ;="" (8876:0181="74h)" '~'="" mov="" bx,36h="" mov="" data_139,bx="" ;="" (8876:0182="430Eh)" loc_402:="" xor="" cl,cl="" ;="" zero="" register="" loc_403:="" call="" sub_34="" ;="" (0a75)="" mov="" dl,1="" cmp="" al,8="" je="" loc_405="" ;="" jump="" if="" equal="" cmp="" al,7fh="" je="" loc_405="" ;="" jump="" if="" equal="" cmp="" al,4="" je="" loc_406="" ;="" jump="" if="" equal="" dec="" dl="" cmp="" al,18h="" je="" loc_405="" ;="" jump="" if="" equal="" cmp="" al,1bh="" je="" loc_405="" ;="" jump="" if="" equal="" cmp="" al,12h="" je="" loc_406="" ;="" jump="" if="" equal="" cmp="" al,1ah="" je="" loc_407="" ;="" jump="" if="" equal="" cmp="" al,0dh="" je="" loc_408="" ;="" jump="" if="" equal="" cmp="" al,20h="" ;="" '="" '="" jb="" loc_403="" ;="" jump="" if="" below="" cmp="" cl,ch="" je="" loc_403="" ;="" jump="" if="" equal="" mov="" ah,[bx]="" mov="" [bx],al="" inc="" cl="" inc="" bx="" cmp="" ah,20h="" ;="" '="" '="" jae="" loc_404="" ;="" jump="" if="" above="" or="mov" [bx],ah="" loc_404:="" call="" sub_126="" ;="" (2652)="" jmp="" short="" loc_403="" ;="" (25cf)="" loc_405:="" dec="" cl="" js="" loc_402="" ;="" jump="" if="" sign="1" call="" sub_35="" ;="" (0a81)="" or="" [bx+si],ah="" or="" [bx+si],al="" dec="" bx="" dec="" dl="" jnz="" loc_405="" ;="" jump="" if="" not="" zero="" jmp="" short="" loc_403="" ;="" (25cf)="" loc_406:="" mov="" al,[bx]="" cmp="" al,20h="" ;="" '="" '="" jb="" loc_403="" ;="" jump="" if="" below="" call="" sub_126="" ;="" (2652)="" inc="" cl="" inc="" bx="" dec="" dl="" jnz="" loc_406="" ;="" jump="" if="" not="" zero="" jmp="" short="" loc_403="" ;="" (25cf)="" loc_407:="" or="" dh,dh="" ;="" zero="" jz="" loc_403="" ;="" jump="" if="" zero="" jmp="" short="" loc_409="" ;="" (263f)="" loc_408:="" or="" dh,dh="" ;="" zero="" jnz="" loc_410="" ;="" jump="" if="" not="" zero="" loc_409:="" mov="" byte="" ptr="" [bx],1ah="" jmp="" short="" loc_411="" ;="" (264c)="" loc_410:="" call="" sub_36="" ;="" (0a99)="" mov="" word="" ptr="" [bx],0a0dh="" inc="" bx="" loc_411:="" inc="" bx="" mov="" data_140,bx="" ;="" (8876:0184="8A2Eh)" retn="" sub_122="" endp="" ;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß="" ;="" subroutine="" ;üüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüü="" sub_126="" proc="" near="" mov="" ah,data_148="" ;="" (8876:0194="0FFh)" mov="" data_148,0="" ;="" (8876:0194="0FFh)" push="" ax="" call="" sub_33="" ;="" (0a63)="" pop="" ax="" mov="" data_148,ah="" ;="" (8876:0194="0FFh)" retn="" sub_126="" endp="" ;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß="" ;="" subroutine="" ;üüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüü="" sub_127="" proc="" near="" les="" di,dword="" ptr="" ds:[232h]="" ;="" (8876:0232="6A0h)" load="" 32="" bit="" ptr="" ;ßßßß="" external="" entry="" into="" subroutine="" ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß="" sub_128:="" cmp="" data_137,0="" ;="" (8876:0180="0F9h)" jne="" loc_421="" ;="" jump="" if="" not="" equal="" mov="" al,es:[di+2]="" test="" al,20h="" ;="" '="" '="" jnz="" loc_420="" ;="" jump="" if="" not="" zero="" and="" al,0fh="" jnz="" loc_413="" ;="" jump="" if="" not="" zero="" mov="" bx,es:[di+8]="" cmp="" bx,es:[di+0ah]="" jb="" loc_412="" ;="" jump="" if="" below="" call="" sub_129="" ;="" (26e8)="" mov="" bx,es:[di+8]="" loc_412:="" mov="" al,es:[bx]="" inc="" bx="" mov="" es:[di+8],bx="" jmp="" short="" loc_419="" ;="" (26d6)="" loc_413:="" push="" es="" push="" di="" cmp="" al,1="" jne="" loc_415="" ;="" jump="" if="" not="" equal="" mov="" bx,data_139="" ;="" (8876:0182="430Eh)" cmp="" bx,data_140="" ;="" (8876:0184="8A2Eh)" jb="" loc_414="" ;="" jump="" if="" below="" mov="" dh,al="" call="" sub_125="" ;="" (25b6)="" mov="" bx,data_139="" ;="" (8876:0182="430Eh)" loc_414:="" mov="" al,[bx]="" inc="" bx="" mov="" data_139,bx="" ;="" (8876:0182="430Eh)" jmp="" short="" loc_418="" ;="" (26d4)="" loc_415:="" cmp="" al,2="" jne="" loc_416="" ;="" jump="" if="" not="" equal="" dec="" sp="" call="" data_112="" ;="" (8876:0138="0)" jmp="" short="" loc_418="" ;="" (26d4)="" loc_416:="" cmp="" al,4="" jne="" loc_417="" ;="" jump="" if="" not="" equal="" dec="" sp="" call="" data_116="" ;="" (8876:0140="0)" jmp="" short="" loc_418="" ;="" (26d4)="" loc_417:="" dec="" sp="" call="" data_118="" ;="" (8876:0144="0)" loc_418:="" pop="" di="" pop="" es="" loc_419:="" mov="" es:[di+3],al="" or="" byte="" ptr="" es:[di+2],20h="" ;="" '="" '="" retn="" loc_420:="" mov="" al,es:[di+3]="" retn="" loc_421:="" mov="" al,1ah="" retn="" sub_127="" endp="" ;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß="" ;="" subroutine="" ;üüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüü="" sub_129="" proc="" near="" mov="" ah,3fh="" ;="" '?'="" mov="" bx,es:[di]="" mov="" cx,es:[di+6]="" mov="" dx,es:[di+4]="" push="" ds="" push="" es="" pop="" ds="" call="" sub_28="" ;="" (0957)="" pop="" ds="" jnc="" loc_422="" ;="" jump="" if="" carry="0" xor="" ax,ax="" ;="" zero="" register="" loc_422:="" mov="" bx,es:[di+4]="" or="" ax,ax="" ;="" zero="" jnz="" loc_423="" ;="" jump="" if="" not="" zero="" mov="" byte="" ptr="" es:[bx],1ah="" inc="" ax="" loc_423:="" mov="" es:[di+8],bx="" add="" bx,ax="" mov="" es:[di+0ah],bx="" retn="" sub_129="" endp="" ;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß="" ;="" subroutine="" ;üüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüü="" sub_130="" proc="" near="" push="" es="" push="" di="" mov="" bx,0b6h="" loc_424:="" push="" bx="" call="" sub_127="" ;="" (2665)="" pop="" bx="" cmp="" al,1ah="" je="" loc_426="" ;="" jump="" if="" equal="" and="" byte="" ptr="" es:[di+2],0dfh="" cmp="" al,20h="" ;="" '="" '="" jbe="" loc_424="" ;="" jump="" if="" below="" or="loc_425:" mov="" [bx],al="" inc="" bx="" cmp="" bx,135h="" je="" loc_426="" ;="" jump="" if="" equal="" push="" bx="" call="" sub_127="" ;="" (2665)="" pop="" bx="" cmp="" al,20h="" ;="" '="" '="" jbe="" loc_426="" ;="" jump="" if="" below="" or="and" byte="" ptr="" es:[di+2],0dfh="" jmp="" short="" loc_425="" ;="" (272f)="" loc_426:="" mov="" byte="" ptr="" [bx],0="" mov="" bx,data_105e="" ;="" (8876:00b6="0)" cmp="" byte="" ptr="" [bx],0="" pop="" di="" pop="" es="" retn="" sub_130="" endp="" ;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß="" ;="" subroutine="" ;üüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüü="" sub_131="" proc="" near="" jc="" loc_427="" ;="" jump="" if="" carry="" set="" cmp="" byte="" ptr="" [bx],0="" je="" loc_ret_428="" ;="" jump="" if="" equal="" loc_427:="" mov="" data_137,10h="" ;="" (8876:0180="0F9h)" stc="" ;="" set="" carry="" flag="" loc_ret_428:="" retn="" sub_131="" endp="" ;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß="" ;="" subroutine="" ;üüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüü="" sub_132="" proc="" near="" push="" di="" call="" sub_127="" ;="" (2665)="" and="" byte="" ptr="" es:[di+2],0dfh="" pop="" di="" pop="" bx="" pop="" es="" mov="" es:[di],al="" jmp="" bx="" ;*register="" jump="" db="" 0f8h,0ebh,="" 01h,0f9h="" loc_429:="" pop="" bx="" pop="" es="" push="" bx="" pushf="" ;="" push="" flags="" call="" sub_130="" ;="" (2718)="" jz="" loc_431="" ;="" jump="" if="" zero="" call="" sub_63="" ;="" (11a7)="" call="" sub_131="" ;="" (2754)="" jc="" loc_431="" ;="" jump="" if="" carry="" set="" popf="" ;="" pop="" flags="" jnc="" loc_430="" ;="" jump="" if="" carry="0" mov="" es:[di],ax="" retn="" loc_430:="" mov="" es:[di],al="" retn="" loc_431:="" popf="" ;="" pop="" flags="" retn="" sub_132="" endp="" pop="" bx="" pop="" es="" push="" bx="" call="" sub_130="" ;="" (2718)="" jz="" loc_ret_432="" ;="" jump="" if="" zero="" push="" di="" push="" es="" mov="" di,23ah="" call="" sub_108="" ;="" (20cd)="" mov="" si,di="" pop="" es="" pop="" di="" call="" sub_131="" ;="" (2754)="" jc="" loc_ret_432="" ;="" jump="" if="" carry="" set="" cld="" ;="" clear="" direction="" movsw="" ;="" mov="" [si]="" to="" es:[di]="" movsw="" ;="" mov="" [si]="" to="" es:[di]="" movsw="" ;="" mov="" [si]="" to="" es:[di]="" loc_ret_432:="" retn="" pop="" bx="" pop="" es="" push="" bx="" xor="" bx,bx="" ;="" zero="" register="" xor="" ch,ch="" ;="" zero="" register="" locloop_433:="" push="" es="" push="" di="" push="" bx="" push="" cx="" call="" sub_127="" ;="" (2665)="" pop="" cx="" pop="" bx="" cmp="" al,0dh="" je="" loc_434="" ;="" jump="" if="" equal="" cmp="" al,1ah="" je="" loc_434="" ;="" jump="" if="" equal="" and="" byte="" ptr="" es:[di+2],0dfh="" pop="" di="" pop="" es="" inc="" bx="" mov="" es:[bx+di],al="" loop="" locloop_433="" ;="" loop="" if="" cx=""> 0
  
		jmp	short loc_435		; (27DC)
loc_434:
		pop	di
		pop	es
loc_435:
		mov	es:[di],bl
		retn
		db	 5Bh, 07h, 53h, 32h,0EDh
  
locloop_436:
		push	es
		push	di
		push	cx
		call	sub_127			; (2665)
		pop	cx
		cld				; Clear direction
		cmp	al,0Dh
		je	loc_437			; Jump if equal
		cmp	al,1Ah
		je	loc_437			; Jump if equal
		and	byte ptr es:[di+2],0DFh
		pop	di
		pop	es
		stosb				; Store al to es:[di]
		loop	locloop_436		; Loop if cx > 0
  
		retn
loc_437:
		pop	di
		pop	es
		mov	al,20h			; ' '
		rep	stosb			; Rep when cx >0 Store al to es:[di]
		retn
loc_438:
		call	sub_127			; (2665)
		cmp	al,1Ah
		je	loc_ret_439		; Jump if equal
		and	byte ptr es:[di+2],0DFh
		cmp	al,0Ah
		je	loc_ret_439		; Jump if equal
		cmp	al,0Dh
		jne	loc_438			; Jump if not equal
		call	sub_127			; (2665)
		cmp	al,0Ah
		jne	loc_ret_439		; Jump if not equal
		and	byte ptr es:[di+2],0DFh
  
loc_ret_439:
		retn
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_133		proc	near
loc_440:
		les	di,dword ptr ds:data_47e	; (0274:0232=8BC0h) Load 32 bit ptr
		cmp	byte ptr ds:data_43e,0	; (0274:0180=8Bh)
		jne	loc_ret_445		; Jump if not equal
		mov	cl,es:[di+2]
		and	cl,0Fh
		jnz	loc_441			; Jump if not zero
		mov	bx,es:[di+8]
		mov	es:[bx],al
		inc	bx
		mov	es:[di+8],bx
		cmp	bx,es:[di+0Ah]
		je	loc_446			; Jump if equal
		retn
loc_441:
		push	ax
		cmp	cl,1
		je	loc_442			; Jump if equal
		cmp	cl,3
		je	loc_443			; Jump if equal
		cmp	cl,4
		je	loc_444			; Jump if equal
		call	word ptr ds:data_42e	; (0274:0142=0C52Eh)
		retn
loc_442:
		call	word ptr ds:data_39e	; (0274:013A=1BEBh)
		retn
loc_443:
		call	word ptr ds:data_40e	; (0274:013C=61Eh)
		retn
loc_444:
		call	word ptr ds:data_41e	; (0274:013E=0DB32h)
  
loc_ret_445:
		retn
loc_446:
		mov	cx,es:[di+8]
		sub	cx,es:[di+4]
		jz	loc_ret_448		; Jump if zero
		mov	ah,40h			; '@'
		mov	bx,es:[di]
		mov	dx,es:[di+4]
		mov	es:[di+8],dx
		push	ds
		push	es
		pop	ds
		call	sub_28			; (0957)
		pop	ds
		jc	loc_447			; Jump if carry Set
		cmp	ax,cx
		je	loc_ret_448		; Jump if equal
loc_447:
		mov	byte ptr ds:data_43e,0F0h	; (0274:0180=8Bh)
  
loc_ret_448:
		retn
sub_133		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_134		proc	near
		or	ax,ax			; Zero ?
		jz	loc_450			; Jump if zero
		call	sub_40			; (0AC9)
		cmp	al,1
		jbe	loc_450			; Jump if below or =
		xchg	ax,cx
		dec	cx
  
locloop_449:
		mov	al,20h			; ' '
		push	cx
		call	sub_133			; (2828)
		pop	cx
		loop	locloop_449		; Loop if cx > 0
  
loc_450:
		pop	bx
		pop	ax
		push	bx
		jmp	loc_440			; (2828)
sub_134		endp
  
		db	 91h, 5Bh, 58h, 53h, 51h
		db	0BBh,0B6h, 00h,0E8h, 57h,0E8h
loc_451:
		pop	ax
		call	sub_40			; (0AC9)
		sub	bx,0B6h
		sub	ax,bx
		jbe	loc_453			; Jump if below or =
		xchg	ax,cx
		push	bx
  
locloop_452:
		mov	al,20h			; ' '
		push	cx
		call	sub_133			; (2828)
		pop	cx
		loop	locloop_452		; Loop if cx > 0
  
		pop	bx
loc_453:
		mov	cx,bx
		mov	bx,data_38e		; (0274:00B6=82h)
  
locloop_454:
		mov	al,[bx]
		push	bx
		push	cx
		call	sub_133			; (2828)
		pop	cx
		pop	bx
		inc	bx
		loop	locloop_454		; Loop if cx > 0
  
		retn
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_135		proc	near
		xchg	ax,dx
		pop	bx
		pop	cx
		mov	di,23Ah
		pop	word ptr [di]
		pop	word ptr [di+2]
		pop	word ptr [di+4]
		push	bx
		push	cx
		mov	bx,0B6h
		call	sub_102			; (1F45)
		jmp	short loc_451		; (28C4)
sub_135		endp
  
		pop	bx
		pop	cx
		push	bx
		mov	di,291Bh
		or	cx,cx			; Zero ?
		jnz	loc_455			; Jump if not zero
		mov	di,2920h
loc_455:
		push	cs
		call	sub_64			; (11CC)
		call	sub_136			; (2926)
		retn
		add	al,54h			; 'T'
		push	dx
		push	bp
		inc	bp
		add	ax,4146h
		dec	sp
		push	bx
		inc	bp
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_136		proc	near
		call	sub_40			; (0AC9)
		mov	bx,sp
		inc	bx
		inc	bx
		sub	al,ss:[bx]
		jbe	loc_457			; Jump if below or =
		mov	cl,al
		xor	ch,ch			; Zero register
		push	bx
  
locloop_456:
		mov	al,20h			; ' '
		push	cx
		call	sub_133			; (2828)
		pop	cx
		loop	locloop_456		; Loop if cx > 0
  
		pop	bx
loc_457:
		mov	cl,ss:[bx]
		xor	ch,ch			; Zero register
		inc	bx
		or	cx,cx			; Zero ?
		jz	loc_459			; Jump if zero
  
locloop_458:
		mov	al,ss:[bx]
		push	bx
		push	cx
		call	sub_133			; (2828)
		pop	cx
		pop	bx
		inc	bx
		loop	locloop_458		; Loop if cx > 0
  
loc_459:
		pop	dx
		mov	sp,bx
		jmp	dx			;*Register jump
;      Note: Subroutine	does not return to instruction after call
  
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_137:
		pop	bx
		mov	cl,cs:[bx]
		xor	ch,ch			; Zero register
		inc	bx
		jcxz	loc_461			; Jump if cx=0
  
locloop_460:
		mov	al,cs:[bx]
		push	bx
		push	cx
		call	sub_133			; (2828)
		pop	cx
		pop	bx
		inc	bx
		loop	locloop_460		; Loop if cx > 0
  
loc_461:
		jmp	bx			;*Register jump
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_138:
		mov	al,0Dh
		call	sub_133			; (2828)
		mov	al,0Ah
		jmp	loc_440			; (2828)
sub_136		endp
  
		mov	dx,10Dh
		jmp	short loc_462		; (2991)
		mov	dx,0Dh
		jmp	short loc_462		; (2991)
		mov	dx,11Ah
		jmp	short loc_462		; (2991)
		db	0BAh, 1Ah, 00h
loc_462:
		pop	word ptr ds:data_44e	; (0274:0186=1689h)
		pop	es
		push	word ptr ds:data_44e	; (0274:0186=1689h)
		test	byte ptr es:[di+2],80h
		jz	loc_465			; Jump if zero
loc_463:
		push	dx
		call	sub_128			; (2669)
		pop	dx
		cmp	al,dl
		je	loc_464			; Jump if equal
		cmp	al,1Ah
		je	loc_464			; Jump if equal
		cmp	al,20h			; ' '
		ja	loc_465			; Jump if above
		or	dh,dh			; Zero ?
		jz	loc_465			; Jump if zero
		and	byte ptr es:[di+2],0DFh
		jmp	short loc_463		; (29A1)
loc_464:
		xor	ax,ax			; Zero register
		inc	ax
		retn
loc_465:
		xor	ax,ax			; Zero register
		retn
		db	 32h,0C0h,0E9h, 0Eh,0F9h
loc_466:
		xor	al,al			; Zero register
		jmp	short loc_468		; (29CF)
loc_467:
		mov	al,1
loc_468:
		mov	byte ptr ds:[238h],al	; (8876:0238=55h)
		pop	data_141		; (8876:0186=5007h)
		pop	es
		push	data_141		; (8876:0186=5007h)
		push	cx
		call	sub_139			; (2A17)
		pop	cx
		cmp	data_137,0		; (8876:0180=0F9h)
		jne	loc_ret_469		; Jump if not equal
		push	cx
		call	sub_121			; (24F5)
		pop	cx
		cmp	data_137,0		; (8876:0180=0F9h)
		jne	loc_ret_469		; Jump if not equal
		mov	es:[di+2],cx
  
loc_ret_469:
		retn
		pop	data_141		; (8876:0186=5007h)
		pop	es
		push	data_141		; (8876:0186=5007h)
		mov	ah,40h			; '@'
		mov	bx,es:[di]
		xor	cx,cx			; Zero register
		jmp	loc_80			; (0957)
		retn	2
		pop	data_141		; (8876:0186=5007h)
		pop	es
		push	data_141		; (8876:0186=5007h)
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_139		proc	near
		mov	word ptr es:[di+2],0
		jmp	loc_388			; (246C)
sub_139		endp
  
		pop	data_141		; (8876:0186=5007h)
		pop	es
		mov	word ptr ds:[232h],di	; (8876:0232=6A0h)
		mov	word ptr ds:[234h],es	; (8876:0234=0E900h)
		cmp	word ptr es:[di+2],0
		jne	loc_470			; Jump if not equal
		mov	data_137,4		; (8876:0180=0F9h)
loc_470:
		jmp	data_141		; (8876:0186=5007h)
		mov	word ptr ds:[238h],993Fh	; (8876:0238=0B855h)
		jmp	short loc_471		; (2A4B)
		mov	word ptr ds:[238h],0F040h	; (8876:0238=0B855h)
loc_471:
		pop	bx
		pop	si
		push	bx
		cmp	data_137,0		; (8876:0180=0F9h)
		jne	loc_ret_473		; Jump if not equal
		mov	dx,di
		les	di,dword ptr ds:[232h]	; (8876:0232=6A0h) Load 32 bit ptr
		mov	ah,byte ptr ds:[238h]	; (8876:0238=55h)
		mov	bx,es:[di]
		mov	cx,es:[di+2]
		push	ds
		mov	ds,si
		call	sub_28			; (0957)
		pop	ds
		jc	loc_472			; Jump if carry Set
		cmp	ax,cx
		je	loc_ret_473		; Jump if equal
		cmp	byte ptr ds:[238h],3Fh	; (8876:0238=55h) '?'
		jne	loc_472			; Jump if not equal
		or	ax,ax			; Zero ?
		jz	loc_472			; Jump if zero
		mov	cx,es:[di+2]
		mov	di,dx
		add	di,ax
		mov	es,si
		sub	cx,ax
		xor	ax,ax			; Zero register
		cld				; Clear direction
		rep	stosb			; Rep when cx >0 Store al to es:[di]
		retn
loc_472:
		mov	al,byte ptr ds:[239h]	; (8876:0239=0B8h)
		mov	data_137,al		; (8876:0180=0F9h)
  
loc_ret_473:
		retn
		db	 33h,0D2h
loc_474:
		pop	data_141		; (8876:0186=5007h)
		pop	di
		pop	es
		push	data_141		; (8876:0186=5007h)
		mov	cx,es:[di+2]
		call	sub_142			; (2B69)
		mov	cx,dx
		mov	dx,ax
		mov	ax,4200h
		mov	bx,es:[di]
		push	cx
		push	dx
		call	sub_28			; (0957)
		pop	cx
		pop	bx
		jc	loc_475			; Jump if carry Set
		cmp	ax,cx
		jne	loc_475			; Jump if not equal
		cmp	dx,bx
		je	loc_ret_476		; Jump if equal
loc_475:
		mov	data_137,91h		; (8876:0180=0F9h)
  
loc_ret_476:
		retn
		call	sub_115			; (227E)
		jmp	short loc_474		; (2A99)
		pop	bx
		pop	es
		push	bx
		mov	ax,4406h
		mov	bx,es:[di]
		call	sub_28			; (0957)
		or	al,al			; Zero ?
		mov	ax,0
		jnz	loc_477			; Jump if not zero
		inc	ax
loc_477:
		or	ax,ax			; Zero ?
		retn
		db	 5Bh, 07h, 53h
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_140		proc	near
		mov	ax,4201h
		mov	bx,es:[di]
		xor	cx,cx			; Zero register
		xor	dx,dx			; Zero register
		call	sub_28			; (0957)
loc_478:
		mov	cx,es:[di+2]
		jmp	short loc_479		; (2B4C)
		nop
		pop	bx
		pop	es
		push	bx
		call	sub_140			; (2AEA)
		jmp	loc_367			; (22B4)
		db	 5Bh, 07h, 53h
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_141:
		mov	ax,4201h
		mov	bx,es:[di]
		xor	cx,cx			; Zero register
		xor	dx,dx			; Zero register
		call	sub_28			; (0957)
		push	ax
		push	dx
		mov	ax,4202h
		mov	bx,es:[di]
		xor	cx,cx			; Zero register
		xor	dx,dx			; Zero register
		call	sub_28			; (0957)
		pop	cx
		pop	bx
		push	ax
		push	dx
		mov	dx,bx
		mov	ax,4200h
		mov	bx,es:[di]
		call	sub_28			; (0957)
		pop	dx
		pop	ax
		mov	cx,es:[di+2]
		dec	cx
		add	ax,cx
		adc	dx,0
		jmp	short loc_478		; (2AF7)
		pop	bx
		pop	es
		push	bx
		call	sub_141			; (2B0A)
		jmp	loc_367			; (22B4)
loc_479:
		cmp	cx,1
		je	loc_ret_482		; Jump if equal
		mov	si,cx
		xor	bx,bx			; Zero register
		mov	cx,21h
  
locloop_480:
		rcl	bx,1			; Rotate thru carry
		sbb	bx,si
		jnc	loc_481			; Jump if carry=0
		add	bx,si
		stc				; Set carry flag
loc_481:
		cmc				; Complement carry
		rcl	ax,1			; Rotate thru carry
		rcl	dx,1			; Rotate thru carry
		loop	locloop_480		; Loop if cx > 0
  
  
loc_ret_482:
		retn
sub_140		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_142		proc	near
		mov	bx,ax
		mov	ax,dx
		mul	cx			; dx:ax = reg * ax
		xchg	ax,bx
		mul	cx			; dx:ax = reg * ax
		add	dx,bx
		retn
sub_142		endp
  
		xchg	ax,cx
		pop	bx
		pop	di
		push	bx
		jmp	loc_466			; (29C9)
		xchg	ax,cx
		pop	bx
		pop	di
		push	bx
		jmp	loc_467			; (29CD)
		mov	word ptr ds:[238h],993Fh	; (8876:0238=0B855h)
		jmp	short loc_483		; (2B91)
		mov	word ptr ds:[238h],0F040h	; (8876:0238=0B855h)
loc_483:
		pop	data_141		; (8876:0186=5007h)
		pop	dx
		pop	si
		pop	di
		pop	es
		push	ax
		call	sub_143			; (2BDB)
		pop	cx
		cmp	data_137,0		; (8876:0180=0F9h)
		jne	loc_484			; Jump if not equal
		cmp	ax,cx
		je	loc_484			; Jump if equal
		mov	al,byte ptr ds:[239h]	; (8876:0239=0B8h)
		mov	data_137,al		; (8876:0180=0F9h)
loc_484:
		jmp	data_141		; (8876:0186=5007h)
		mov	word ptr ds:[238h],993Fh	; (8876:0238=0B855h)
		jmp	short loc_485		; (2BC1)
		mov	word ptr ds:[238h],0F040h	; (8876:0238=0B855h)
loc_485:
		pop	data_141		; (8876:0186=5007h)
		mov	cx,di
		pop	bx
		pop	ax
		pop	dx
		pop	si
		pop	di
		pop	es
		push	bx
		push	cx
		call	sub_143			; (2BDB)
		pop	di
		pop	es
		mov	es:[di],ax
		jmp	data_141		; (8876:0186=5007h)
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_143		proc	near
		cmp	word ptr es:[di+2],0
		je	loc_489			; Jump if equal
		cmp	word ptr es:[di+2],1
		je	loc_486			; Jump if equal
		push	dx
		mul	word ptr es:[di+2]	; ax = data * ax
		pop	dx
loc_486:
		xchg	ax,cx
		mov	ah,byte ptr ds:[238h]	; (8876:0238=55h)
		mov	bx,es:[di]
		push	ds
		mov	ds,si
		call	sub_28			; (0957)
		pop	ds
		jnc	loc_487			; Jump if carry=0
		mov	al,byte ptr ds:[239h]	; (8876:0239=0B8h)
		mov	data_137,al		; (8876:0180=0F9h)
		xor	ax,ax			; Zero register
loc_487:
		mov	cx,es:[di+2]
		cmp	cx,1
		je	loc_ret_488		; Jump if equal
		mov	di,dx
		add	di,ax
		xor	dx,dx			; Zero register
		div	cx			; ax,dx rem=dx:ax/reg
		or	dx,dx			; Zero ?
		jz	loc_ret_488		; Jump if zero
		cmp	byte ptr ds:[238h],3Fh	; (8876:0238=55h) '?'
		jne	loc_ret_488		; Jump if not equal
		push	ax
		sub	cx,dx
		mov	es,si
		xor	ax,ax			; Zero register
		cld				; Clear direction
		rep	stosb			; Rep when cx >0 Store al to es:[di]
		pop	ax
		inc	ax
  
loc_ret_488:
		retn
loc_489:
		mov	data_137,4		; (8876:0180=0F9h)
		retn
sub_143		endp
  
		pop	data_141		; (8876:0186=5007h)
		pop	es
		push	data_141		; (8876:0186=5007h)
		mov	ah,41h			; 'A'
		lea	dx,[di+0Ch]		; Load effective addr
		push	ds
		push	es
		pop	ds
		call	sub_28			; (0957)
		pop	ds
		jnc	loc_ret_491		; Jump if carry=0
loc_490:
		mov	data_137,1		; (8876:0180=0F9h)
  
loc_ret_491:
		retn
		pop	data_141		; (8876:0186=5007h)
		call	sub_50			; (0EE6)
		pop	di
		pop	es
		push	data_141		; (8876:0186=5007h)
		mov	ah,56h			; 'V'
		lea	dx,[di+0Ch]		; Load effective addr
		push	di
		mov	di,0B6h
		push	ds
		push	es
		pop	ds
		pop	es
		call	sub_28			; (0957)
		push	ds
		push	es
		pop	ds
		pop	es
		pop	di
		jc	loc_490			; Jump if carry Set
		mov	si,data_105e		; (8876:00B6=0)
		lea	di,[di+0Ch]		; Load effective addr
		mov	cx,20h
		cld				; Clear direction
		rep	movsw			; Rep when cx >0 Mov [si] to es:[di]
		retn
		pop	data_141		; (8876:0186=5007h)
		call	sub_50			; (0EE6)
		push	data_141		; (8876:0186=5007h)
		mov	ax,ds:data_105e		; (8876:00B6=0)
		or	al,al			; Zero ?
		jz	loc_ret_494		; Jump if zero
		cmp	ah,3Ah			; ':'
		jne	loc_492			; Jump if not equal
		call	sub_37			; (0AA0)
		sub	al,41h			; 'A'
		jc	loc_490			; Jump if carry Set
		cmp	al,0Fh
		jae	loc_490			; Jump if above or =
		mov	ah,0Eh
		mov	dl,al
		call	sub_28			; (0957)
		cmp	byte ptr ds:data_107e,0	; (8876:00B8=0)
		je	loc_ret_494		; Jump if equal
loc_492:
		mov	ah,3Bh			; ';'
loc_493:
		mov	dx,0B6h
		call	sub_28			; (0957)
		jc	loc_490			; Jump if carry Set
  
loc_ret_494:
		retn
		mov	bh,39h			; '9'
		jmp	short loc_495		; (2CC6)
		db	0B7h, 3Ah
loc_495:
		pop	data_141		; (8876:0186=5007h)
		call	sub_50			; (0EE6)
		push	data_141		; (8876:0186=5007h)
		mov	ah,bh
		jmp	short loc_493		; (2CB7)
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_144		proc	near
		pop	data_141		; (8876:0186=5007h)
		pop	es
		pop	ax
		push	data_141		; (8876:0186=5007h)
		or	al,al			; Zero ?
		jnz	loc_496			; Jump if not zero
		mov	ah,19h
		call	sub_28			; (0957)
		inc	al
loc_496:
		mov	dl,al
		add	al,40h			; '@'
		mov	ds:data_105e,al		; (8876:00B6=0)
		mov	word ptr ds:data_105e+1,5C3Ah	; (8876:00B7=0)
		mov	ah,47h			; 'G'
		mov	si,0B9h
		call	sub_28			; (0957)
		jnc	loc_497			; Jump if carry=0
		mov	byte ptr [si],0
loc_497:
		mov	si,data_38e		; (0274:00B6=82h)
		xor	bx,bx			; Zero register
loc_498:
		mov	al,[si]
		or	al,al			; Zero ?
		jz	loc_499			; Jump if zero
		inc	si
		inc	bx
		mov	es:[bx+di],al
		dec	cl
		jnz	loc_498			; Jump if not zero
loc_499:
		mov	es:[di],bl
		retn
sub_144		endp
  
		mov	bx,2C7Ch
		jmp	short loc_500		; (2D23)
		db	 33h,0DBh
loc_500:
		pop	data_141		; (8876:0186=5007h)
		pop	es
		push	data_141		; (8876:0186=5007h)
		test	data_129,1		; (8876:0172=0F70h)
		jnz	loc_502			; Jump if not zero
		push	bx
		mov	ax,3D00h
		lea	dx,[di+0Ch]		; Load effective addr
		call	sub_28			; (0957)
		pop	dx
		jc	loc_501			; Jump if carry Set
		mov	bx,ax
		mov	ax,4200h
		xor	cx,cx			; Zero register
		call	sub_28			; (0957)
		jc	loc_501			; Jump if carry Set
		push	ds
		push	cs
		pop	ds
		mov	ah,3Fh			; '?'
		mov	cx,0FFFFh
		mov	dx,2D7Ch
		call	sub_28			; (0957)
		pop	ds
		mov	ah,3Eh			; '>'
		call	sub_28			; (0957)
		mov	sp,data_131		; (8876:0174=707h)
		call	sub_32			; (09FB)
		mov	data_136,10D0h		; (8876:017E=0E40Ah)
		jmp	loc_503			; (2D93)
loc_501:
		mov	dl,1
		jmp	loc_395			; (251B)
loc_502:
		mov	data_137,21h		; (8876:0180=0F9h) '!'
		retn
		call	sub_41			; (0AD6)
		add	al,[bx+si]
		db	0F1h, 60h,0B1h, 6Ah,0D0h, 03h
		db	 47h, 01h, 00h, 04h, 00h,0A0h
		db	 10h, 00h, 00h, 00h, 00h, 00h
loc_503:
		mov	bp,sp
		call	sub_44			; (0CCC)
		add	[bx+si],al
		pushf				; Push flags
		sub	ax,0F7E9h
		add	[bp+di],al
		push	dx
		dec	ax
		push	bx
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_145		proc	near
		push	bp
		mov	bp,sp
		push	bp
		jmp	loc_504			; (2DAA)
loc_504:
		sub	sp,0Ch
		mov	ax,ds:data_52e		; (0274:02AE=5503h)
		cmp	ax,0
		jl	loc_505			; Jump if < jmp="" loc_506="" ;="" (2dd5)="" loc_505:="" lea="" di,[bp-0eh]="" ;="" load="" effective="" addr="" push="" ss="" push="" di="" call="" sub_93="" ;="" (1982)="" xchg="" ax,cx="" add="" [bx+si],al="" add="" [bx+si],al="" add="" ds:data_52e[bx+di],ah="" ;="" (0274:02ae="3)" call="" sub_98="" ;="" (1b2f)="" call="" sub_95="" ;="" (19a6)="" call="" sub_94="" ;="" (1993)="" jmp="" loc_507="" ;="" (2de3)="" loc_506:="" lea="" di,[bp-0eh]="" ;="" load="" effective="" addr="" push="" ss="" push="" di="" mov="" ax,word="" ptr="" ds:[2aeh]="" ;="" (8876:02ae="0F2E8h)" call="" sub_98="" ;="" (1b2f)="" call="" sub_94="" ;="" (1993)="" loc_507:="" mov="" ax,word="" ptr="" ds:[2b0h]="" ;="" (8876:02b0="0B8FFh)" cmp="" ax,0="" jl="" loc_508="" ;="" jump="" if="">< jmp="" loc_509="" ;="" (2e0c)="" loc_508:="" lea="" di,[bp-8]="" ;="" load="" effective="" addr="" push="" ss="" push="" di="" call="" sub_93="" ;="" (1982)="" xchg="" ax,cx="" add="" [bx+si],al="" add="" [bx+si],al="" add="" byte="" ptr="" ds:[0f87eh][di],cl="" ;="" (8876:f87e="0)" push="" ss="" call="" sub_92="" ;="" (1973)="" call="" sub_95="" ;="" (19a6)="" call="" sub_94="" ;="" (1993)="" jmp="" loc_510="" ;="" (2e1a)="" loc_509:="" lea="" di,[bp-8]="" ;="" load="" effective="" addr="" push="" ss="" push="" di="" mov="" ax,word="" ptr="" ds:[2b0h]="" ;="" (8876:02b0="0B8FFh)" call="" sub_98="" ;="" (1b2f)="" call="" sub_94="" ;="" (1993)="" loc_510:="" lea="" di,[bp+4]="" ;="" load="" effective="" addr="" push="" ss="" push="" di="" call="" sub_93="" ;="" (1982)="" xchg="" ax,cx="" add="" [bx+si],al="" add="" [bx+si],al="" add="" byte="" ptr="" ds:[0f87eh][di],cl="" ;="" (8876:f87e="0)" push="" ss="" call="" sub_92="" ;="" (1973)="" call="" sub_96="" ;="" (19d0)="" lea="" di,[bp-0eh]="" ;="" load="" effective="" addr="" push="" ss="" call="" sub_92="" ;="" (1973)="" call="" sub_95="" ;="" (19a6)="" call="" sub_94="" ;="" (1993)="" jmp="" loc_511="" ;="" (2e42)="" loc_511:="" mov="" sp,bp="" pop="" bp="" retn="" sub_145="" endp="" ;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß="" ;="" subroutine="" ;üüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüüü="" sub_146="" proc="" near="" push="" bp="" mov="" bp,sp="" push="" bp="" jmp="" loc_512="" ;="" (2e4d)="" loc_512:="" lea="" di,[bp+6]="" ;="" load="" effective="" addr="" push="" ss="" push="" di="" mov="" ax,30h="" push="" ax="" mov="" al,[bp+4]="" xor="" ah,ah="" ;="" zero="" register="" mov="" cx,0ah="" cwd="" ;="" word="" to="" double="" word="" idiv="" cx="" ;="" ax,dx="" rem="dx:ax/reg" pop="" cx="" add="" ax,cx="" push="" ax="" mov="" ax,30h="" push="" ax="" mov="" al,[bp+4]="" xor="" ah,ah="" ;="" zero="" register="" mov="" cx,0ah="" cwd="" ;="" word="" to="" double="" word="" idiv="" cx="" ;="" ax,dx="" rem="dx:ax/reg" xchg="" ax,dx="" pop="" cx="" add="" ax,cx="" mov="" ah,al="" mov="" al,1="" push="" ax="" call="" sub_74="" ;="" (1483)="" call="" sub_68="" ;="" (12fd)="" mov="" cl,2="" call="" sub_66="" ;="" (11fb)="" jmp="" loc_513="" ;="" (2e8b)="" loc_513:="" mov="" dx,2="" mov="" cl,2="" mov="" sp,bp="" pop="" bp="" jmp="" loc_193="" ;="" (1498)="" sub_146="" endp="" db="" 0b8h,="" 00h,="" 00h,0a3h,0c3h,="" 02h="" db="" 0b8h,="" 07h,="" 00h,0e8h,="" 19h,0d5h="" db="" 0b8h,="" 00h,="" 00h,0e8h,="" 27h,0d5h="" db="" 0e8h,="" 2ah,0dfh,="" 3dh,="" 00h,="" 00h="" db="" 74h,="" 03h,0e9h,="" 34h,="" 00h="" loc_514:="" mov="" ax,0="" push="" ax="" mov="" di,274h="" push="" ds="" mov="" cl,1fh="" call="" sub_144="" ;="" (2cd5)="" mov="" di,274h="" push="" ds="" push="" di="" mov="" di,274h="" push="" ds="" call="" sub_64="" ;="" (11cc)="" call="" sub_65="" ;="" (11e5)="" add="" al,5ch="" ;="" '\'="" sub="" ch,ds:data_247e="" ;="" (8876:e82a="0)" db="" 26h,0e4h,0b1h,="" 1fh,0e8h,="" 1fh="" db="" 0e3h,0a0h,="" 75h,="" 02h,="" 32h,0e4h="" db="" 0a2h,0c0h,="" 02h,0e9h,="" 38h,="" 01h="" loc_515:="" mov="" di,126eh="" push="" ds="" push="" di="" mov="" ax,1="" call="" sub_47="" ;="" (0db8)="" mov="" cl,0ffh="" call="" sub_66="" ;="" (11fb)="" mov="" al,byte="" ptr="" ds:[1270h]="" ;="" (8876:1270="7)" xor="" ah,ah="" ;="" zero="" register="" cmp="" ax,3ah="" je="" loc_516="" ;="" jump="" if="" equal="" jmp="" loc_525="" ;="" (2fda)="" loc_516:="" mov="" al,byte="" ptr="" ds:[126fh]="" ;="" (8876:126f="16h)" xor="" ah,ah="" ;="" zero="" register="" call="" sub_7="" ;="" (036e)="" mov="" ds:data_27e,al="" ;="" (0000:02c0="0)" mov="" al,ds:data_27e="" ;="" (0000:02c0="0)" xor="" ah,ah="" ;="" zero="" register="" cmp="" ax,41h="" mov="" ax,1="" jl="" loc_517="" ;="" jump="" if="">< dec="" ax="" loc_517:="" push="" ax="" mov="" al,ds:data_27e="" ;="" (0000:02c0="0)" xor="" ah,ah="" ;="" zero="" register="" cmp="" ax,44h="" mov="" ax,1="" jg="" loc_518="" ;="" jump="" if="">
		dec	ax
loc_518:
		pop	cx
		or	ax,cx
		or	ax,ax			; Zero ?
		jnz	loc_519			; Jump if not zero
		jmp	loc_521			; (2F5E)
loc_519:
		call	sub_123			; (2558)
		call	sub_137			; (295D) Sub does not return here
		db	 16h, 43h, 68h, 79h, 62h, 6Eh
		db	 82h, 20h, 6Fh, 7Ah, 6Eh, 61h
		db	 87h, 65h, 6Eh,0A1h
		db	 20h, 64h, 69h, 73h, 6Bh, 75h
		db	 2Eh
loc_520:
		call	sub_138			; (2975)
		call	sub_57			; (1022)
		xor	ax,ax			; Zero register
;*		jmp	loc_110			;*(0C89)
		db	0E9h, 2Bh,0DDh
loc_521:
		mov	di,126Eh
		push	ds
		call	sub_64			; (11CC)
		call	sub_70			; (137E)
		cmp	ax,2
		je	loc_522			; Jump if equal
		jmp	loc_523			; (2FA9)
loc_522:
		mov	al,ds:data_27e		; (0000:02C0=0)
		xor	ah,ah			; Zero register
		push	ax
		mov	ax,41h
		pop	cx
		xchg	ax,cx
		sub	ax,cx
		add	ax,1
		push	ax
		mov	di,274h
		push	ds
		mov	cl,1Fh
		call	sub_144			; (2CD5)
		mov	di,274h
		push	ds
		push	di
		mov	di,274h
		push	ds
		call	sub_64			; (11CC)
		call	sub_65			; (11E5)
		add	al,5Ch			; '\'
		sub	ch,ds:data_33e		; (0000:E82A=6)
		pop	sp
		jcxz	loc_520			; Jump if cx=0
		pop	ds
		call	sub_66			; (11FB)
		jmp	loc_524			; (2FD7)
loc_523:
		mov	di,274h
		push	ds
		push	di
		mov	al,ds:data_54e		; (0274:02C0=0C0h)
		xor	ah,ah			; Zero register
		push	ax
		mov	ax,3A01h
		push	ax
		call	sub_74			; (1483)
		call	sub_68			; (12FD)
		mov	di,126Eh
		push	ds
		call	sub_64			; (11CC)
		mov	ax,3
		push	ax
		mov	ax,0FFh
		call	sub_69			; (133F)
		call	sub_68			; (12FD)
		mov	cl,1Fh
		call	sub_66			; (11FB)
loc_524:
		jmp	loc_526			; (301F)
loc_525:
		mov	ax,1900h
		mov	ds:data_48e,ax		; (0274:0260=0FAC3h)
		mov	di,260h
		push	ds
		call	sub_54			; (0F67)
		int	21h			; DOS Services  ah=function 19h
						;  get default drive al  (0=a:)
		call	sub_55			; (0F8F)
		mov	ax,41h
		push	ax
		mov	ax,ds:data_22e		; (0000:0260=0)
		xor	ah,ah			; Zero register
		pop	cx
		add	ax,cx
		mov	ds:data_27e,al		; (0000:02C0=0)
		mov	di,274h
		push	ds
		push	di
		mov	al,ds:data_27e		; (0000:02C0=0)
		xor	ah,ah			; Zero register
		push	ax
		mov	ax,3A01h
		push	ax
		call	sub_74			; (1483)
		call	sub_68			; (12FD)
		mov	di,126Eh
		push	ds
		call	sub_64			; (11CC)
		call	sub_68			; (12FD)
		mov	cl,1Fh
		call	sub_66			; (11FB)
loc_526:
		call	sub_8			; (0371)
		mov	ds:data_29e,ax		; (0000:02C9=0)
		call	sub_9			; (037F)
		mov	ds:data_30e,ax		; (0000:02CB=0)
		mov	ax,0B800h
		push	ax
		mov	ax,0
		xchg	ax,di
		pop	es
		push	es
		push	di
		mov	di,2CDh
		push	ds
		push	di
		mov	ax,0FA0h
		call	sub_53			; (0F4D)
		mov	ax,0
		call	sub_11			; (03BB)
		call	sub_3			; (0226)
		mov	ax,0Fh
		call	sub_11			; (03BB)
		call	sub_123			; (2558)
		call	sub_137			; (295D) Sub does not return here
		db	 0Eh,0C9h
		db	13 dup (0CDh)
		db	0E8h,0BAh,0DFh,0B8h, 0Eh, 00h
		db	0E8h, 4Dh,0D3h,0E8h,0E7h,0F4h
		db	0E8h,0E9h,0F8h
		db	'* ADR - V'
		db	98h
		db	'pis adres'
		db	0A0h,0A9h
		db	'e , A.C. , SWS , 1988 '
		db	0E8h, 80h,0DFh,0B8h, 0Fh, 00h
		db	0E8h, 13h,0D3h,0E8h,0ADh,0F4h
		db	0E8h,0AFh,0F8h, 11h,0CDh
		db	15 dup (0CDh)
		db	0BBh,0E8h,0B2h,0F8h,0E8h, 5Ch
		db	0DFh,0E8h, 8Fh,0F4h,0E8h, 91h
		db	0F8h, 07h,0BAh, 20h, 20h, 20h
		db	 20h, 20h, 20h,0E8h, 4Bh,0DFh
		db	0B8h, 0Fh, 00h,0E8h,0DEh,0D2h
		db	0B8h, 09h, 00h,0E8h,0ECh,0D2h
		db	0E8h, 72h,0F4h,0E8h, 74h,0F8h
		db	 03h, 20h, 20h, 20h,0BFh, 74h
		db	 02h, 1Eh,0E8h,0D8h,0E0h,0B8h
		db	 00h, 00h,0E8h, 2Ch,0F8h,0E8h
		db	 60h,0F8h, 03h, 20h, 20h, 20h
		db	0E8h, 1Eh,0DFh,0B8h, 49h, 00h
		db	 50h,0B8h, 02h, 00h,0E8h, 9Ch
		db	0DCh,0B8h, 0Fh, 00h,0E8h,0A7h
		db	0D2h,0B8h, 00h, 00h,0E8h,0B5h
		db	0D2h,0E8h, 3Bh,0F4h,0B8h,0BAh
		db	 00h, 50h,0B8h, 00h, 00h,0E8h
		db	 76h,0F7h,0E8h, 4Bh,0F8h,0E8h
		db	0F5h,0DEh,0E8h, 28h,0F4h,0E8h
		db	 2Ah,0F8h, 49h,0C8h
		db	71 dup (0CDh)
		db	0BCh,0E8h,0A2h,0DEh,0BFh, 74h
		db	 02h, 1Eh,0E8h, 45h,0E0h,0E8h
		db	0F4h,0E1h, 97h, 8Ah, 85h, 74h
		db	 02h, 32h,0E4h, 3Dh, 5Ch, 00h
		db	 74h, 03h,0E9h, 1Bh, 00h,0BFh
		db	 74h, 02h, 1Eh, 57h,0BFh, 74h
		db	 02h, 1Eh,0E8h, 27h,0E0h,0E8h
		db	 3Dh,0E0h, 03h, 2Ah, 2Eh, 2Ah
		db	0E8h, 4Eh,0E1h,0B1h, 1Fh,0E8h
		db	 47h,0E0h
loc_527:
		mov	di,274h
		push	ds
		push	di
		mov	di,274h
		push	ds
		call	sub_64			; (11CC)
		mov	ax,1
		push	ax
		call	sub_68			; (12FD)
		mov	cl,1Fh
		call	sub_66			; (11FB)
		mov	ax,1A00h
		mov	ds:data_22e,ax		; (0000:0260=0)
		mov	ax,ds
		mov	ds:data_25e,ax		; (0000:026E=0)
		mov	di,294h
		xchg	ax,di
		mov	ds:data_24e,ax		; (0000:0266=0)
		mov	di,260h
		push	ds
		call	sub_54			; (0F67)
		int	21h			; DOS Services  ah=function 02h
						;  display char dl
		call	sub_55			; (0F8F)
		mov	ax,4E00h
		mov	ds:data_22e,ax		; (0000:0260=0)
		mov	ax,ds
		mov	ds:data_25e,ax		; (0000:026E=0)
		mov	di,275h
		xchg	ax,di
		mov	ds:data_24e,ax		; (0000:0266=0)
		mov	ax,1Fh
		mov	ds:data_23e,ax		; (0000:0264=0)
		mov	di,2B2h
		push	ds
		push	di
		mov	ax,0Dh
		push	ax
		mov	ax,0
		call	sub_52			; (0F44)
		mov	di,260h
		push	ds
		call	sub_54			; (0F67)
		int	21h			; DOS Services  ah=function 00h
						;  terminate, cs=progm seg prefx
		call	sub_55			; (0F8F)
		mov	ax,1
		push	ax
		mov	ax,3
		call	sub_46			; (0DAA)
		call	sub_123			; (2558)
		call	sub_137			; (295D) Sub does not return here
		db	 49h,0C7h,0C4h,0C4h,0C4h
		db	68 dup (0C4h)
		db	0B6h,0E8h,0FBh,0F6h,0E8h,0A5h
		db	0DDh,0E8h,0D8h,0F2h,0B8h,0BAh
		db	 00h, 50h,0B8h, 00h, 00h,0E8h
		db	 13h,0F6h,0E8h, 95h,0DDh,0B8h
		db	 49h, 00h, 50h,0B8h, 04h, 00h
		db	0E8h, 13h,0DBh,0E8h,0BEh,0F2h
		db	0B8h,0BAh, 00h, 50h,0B8h, 00h
		db	 00h,0E8h,0F9h,0F5h,0E8h,0CEh
		db	0F6h,0E8h, 78h,0DDh,0A1h, 72h
		db	 02h, 25h, 01h, 00h, 3Dh, 00h
		db	 00h, 75h, 03h,0E9h,0DAh, 01h
		db	0E8h, 9Dh,0F2h,0E8h, 9Fh,0F6h
		db	 1Ah,0BAh
		db	 20h, 20h
		db	23 dup (20h)
		db	0E8h, 46h,0DDh,0B8h, 08h, 00h
		db	0E8h,0D9h,0D0h,0B8h, 02h, 00h
		db	0E8h,0E7h,0D0h,0E8h, 6Dh,0F2h
		db	0E8h, 6Fh,0F6h, 13h, 20h, 20h
		db	 20h, 92h,0A0h, 64h, 6Eh, 98h
		db	' soubor.   '
		db	0E8h, 1Dh,0DDh,0B8h, 49h, 00h
		db	 50h,0B8h, 05h, 00h,0E8h, 9Bh
		db	0DAh,0B8h, 0Fh, 00h,0E8h,0A6h
		db	0D0h,0B8h, 00h, 00h,0E8h,0B4h
		db	0D0h,0E8h, 3Ah,0F2h,0B8h,0BAh
		db	 00h, 50h,0B8h, 00h, 00h,0E8h
		db	 75h,0F5h,0E8h, 4Ah,0F6h,0E8h
		db	0F4h,0DCh,0E8h, 27h,0F2h,0B8h
		db	0BAh, 00h, 50h,0B8h, 00h, 00h
		db	0E8h, 62h,0F5h,0E8h,0E4h,0DCh
		db	0B8h, 49h, 00h, 50h,0B8h, 06h
		db	 00h,0E8h, 62h,0DAh,0E8h, 0Dh
		db	0F2h,0B8h,0BAh, 00h, 50h,0B8h
		db	 00h, 00h,0E8h, 48h,0F5h,0E8h
		db	 1Dh,0F6h,0E8h,0C7h,0DCh,0E8h
		db	0FAh,0F1h
loc_528:
		call	sub_137			; (295D) Sub does not return here
		db	 49h,0C8h
		db	71 dup (0CDh)
		db	0BCh,0E8h, 74h,0DCh,0B8h, 02h
		db	 00h, 50h,0B8h, 19h, 00h,0E8h
		db	0F2h,0D9h,0B8h, 0Fh, 00h,0E8h
		db	0FDh,0CFh,0B8h, 04h, 00h,0E8h
		db	 0Bh,0D0h,0E8h, 91h,0F1h,0E8h
		db	 93h,0F5h
		db	47h
		db	16 dup (20h)
		db	 4Eh,0A0h
		db	'vrat do syst'
		db	82h
		db	'mu po stisknut'
		db	0A1h, 20h, 6Bh, 6Ch,0A0h
		db	 76h, 65h, 73h, 79h
		db	17 dup (20h)
		db	0E8h, 0Dh,0DCh
loc_529:
		call	sub_45			; (0DA4)
		jnz	loc_530			; Jump if not zero
		jmp	loc_531			; (3431)
loc_530:
		mov	di,14Ah
		push	ds
		call	sub_122			; (253B)
		mov	di,2BFh
		push	ds
		call	sub_132			; (2762)
		call	sub_57			; (1022)
		jmp	loc_529			; (3415)
		nop				;*jump fixup
loc_531:
		mov	di,14Ah
		push	ds
		call	sub_122			; (253B)
		mov	di,2BFh
		push	ds
		call	sub_132			; (2762)
		call	sub_57			; (1022)
loc_532:
		call	sub_45			; (0DA4)
		jnz	loc_533			; Jump if not zero
		jmp	loc_534			; (345E)
loc_533:
		mov	di,14Ah
		push	ds
		call	sub_122			; (253B)
		mov	di,2BFh
		push	ds
		call	sub_132			; (2762)
		call	sub_57			; (1022)
		jmp	loc_532			; (3442)
		nop				;*jump fixup
loc_534:
		mov	ax,7
		call	sub_11			; (03BB)
		mov	ax,0
		call	sub_12			; (03CF)
		mov	di,2CDh
		push	ds
		push	di
		mov	ax,0B800h
		push	ax
		mov	ax,0
		xchg	ax,di
		pop	es
		push	es
		push	di
		mov	ax,0FA0h
		call	sub_53			; (0F4D)
		mov	ax,word ptr ds:[2C9h]	; (8876:02C9=2F8h)
		push	ax
		mov	ax,word ptr ds:[2CBh]	; (8876:02CB=0A02Eh)
		call	sub_46			; (0DAA)
		xor	ax,ax			; Zero register
;*		jmp	loc_110			;*(0C89)
		db	0E9h,0FAh,0D7h
		jmp	loc_586			; (3BCC)
		mov	ax,5
		push	ax
		mov	ax,16h
		pop	cx
		xchg	ax,cx
		sub	cx,ax
		jge	loc_535			; Jump if > or =
		jmp	loc_537			; (34E9)
loc_535:
		inc	cx
		mov	word ptr ds:[2C1h],ax	; (8876:02C1=10CDh)
loc_536:
		push	cx
		mov	ax,1
		push	ax
		mov	ax,word ptr ds:[2C1h]	; (8876:02C1=10CDh)
		call	sub_46			; (0DAA)
		call	sub_123			; (2558)
		mov	ax,0BAh
		push	ax
		mov	ax,0
		call	sub_134			; (289D)
		call	sub_57			; (1022)
		mov	ax,49h
		push	ax
		mov	ax,ds:data_55e		; (0274:02C1=0FAC3h)
		call	sub_46			; (0DAA)
		call	sub_123			; (2558)
		mov	ax,0BAh
		push	ax
		mov	ax,0
		call	sub_134			; (289D)
		call	sub_138			; (2975)
		call	sub_57			; (1022)
		pop	cx
		dec	cx
		jz	loc_537			; Jump if zero
		inc	word ptr ds:data_55e	; (0274:02C1=0FAC3h)
		jmp	loc_536			; (34A6)
		nop				;*jump fixup
loc_537:
		call	sub_123			; (2558)
		call	sub_137			; (295D) Sub does not return here
		db	 49h,0C8h
		db	71 dup (0CDh)
		db	0BCh,0E8h,0E6h,0DAh,0B8h, 02h
		db	 00h, 50h,0B8h, 05h, 00h, 50h
		db	0B8h, 48h, 00h, 50h,0B8h, 15h
		db	 00h,0E8h, 3Fh,0CEh,0B8h, 01h
		db	 00h, 50h,0B8h, 01h, 00h,0E8h
		db	 52h,0D8h
loc_538:
		mov	ax,ds:data_26e		; (0000:0272=0)
		and	ax,1
		cmp	ax,0
		je	loc_539			; Jump if equal
		jmp	loc_586			; (3BCC)
loc_539:
		mov	di,136Eh
		push	ds
		push	di
		call	sub_65			; (11E5)
		add	ds:data_34e[bx+di],dh	; (0000:E8FF=9Eh)
		xchg	bx,sp
		mov	ax,1
		mov	ds:data_28e,ax		; (0000:02C1=0)
loc_540:
		mov	ax,word ptr ds:[2C1h]	; (8876:02C1=10CDh)
		cmp	ax,0Dh
		mov	ax,1
		jle	loc_541			; Jump if < or="dec" ax="" loc_541:="" push="" ax="" mov="" ax,word="" ptr="" ds:[2c1h]="" ;="" (8876:02c1="10CDh)" xchg="" ax,di="" mov="" al,byte="" ptr="" ds:[2b1h][di]="" ;="" (8876:02b1="0B8h)" xor="" ah,ah="" ;="" zero="" register="" cmp="" ax,0="" mov="" ax,1="" jnz="" loc_542="" ;="" jump="" if="" not="" zero="" dec="" ax="" loc_542:="" pop="" cx="" and="" ax,cx="" or="" ax,ax="" ;="" zero="" jnz="" loc_543="" ;="" jump="" if="" not="" zero="" jmp="" loc_544="" ;="" (35d3)="" loc_543:="" mov="" di,136eh="" push="" ds="" push="" di="" mov="" di,136eh="" push="" ds="" call="" sub_64="" ;="" (11cc)="" mov="" ax,word="" ptr="" ds:[2c1h]="" ;="" (8876:02c1="10CDh)" xchg="" ax,di="" mov="" al,byte="" ptr="" ds:[2b1h][di]="" ;="" (8876:02b1="0B8h)" xor="" ah,ah="" ;="" zero="" register="" mov="" ah,al="" mov="" al,1="" push="" ax="" call="" sub_68="" ;="" (12fd)="" mov="" cl,0ffh="" call="" sub_66="" ;="" (11fb)="" mov="" ax,word="" ptr="" ds:[2c1h]="" ;="" (8876:02c1="10CDh)" add="" ax,1="" mov="" word="" ptr="" ds:[2c1h],ax="" ;="" (8876:02c1="10CDh)" jmp="" loc_540="" ;="" (357a)="" nop="" ;*jump="" fixup="" loc_544:="" mov="" al,byte="" ptr="" ds:[136fh]="" ;="" (8876:136f="0EBh)" xor="" ah,ah="" ;="" zero="" register="" cmp="" ax,2eh="" jne="" loc_545="" ;="" jump="" if="" not="" equal="" jmp="" loc_585="" ;="" (3bab)="" loc_545:="" mov="" ax,word="" ptr="" ds:[2c3h]="" ;="" (8876:02c3="5A5Dh)" add="" ax,1="" mov="" word="" ptr="" ds:[2c3h],ax="" ;="" (8876:02c3="5A5Dh)" mov="" ax,word="" ptr="" ds:[2c3h]="" ;="" (8876:02c3="5A5Dh)" cmp="" ax,11h="" jg="" loc_546="" ;="" jump="" if="">
		jmp	loc_557			; (37B5)
loc_546:
		call	sub_8			; (0371)
		mov	word ptr ds:[264h],ax	; (8876:0264=1B0h)
		call	sub_9			; (037F)
		mov	word ptr ds:[2C7h],ax	; (8876:02C7=0E8C3h)
		mov	ax,1
		push	ax
		mov	ax,1
		push	ax
		mov	ax,50h
		push	ax
		mov	ax,19h
		call	sub_10			; (038D)
		mov	ax,2
		push	ax
		mov	ax,19h
		call	sub_46			; (0DAA)
		mov	ax,0Fh
		call	sub_11			; (03BB)
		mov	ax,4
		call	sub_12			; (03CF)
		call	sub_123			; (2558)
		call	sub_137			; (295D) Sub does not return here
		db	10h
		db	'Stiskni kl'
		db	0A0h, 76h, 65h, 73h, 75h, 20h
		db	0E8h,0E0h,0D9h,0B8h, 0Eh, 00h
		db	0E8h, 73h,0CDh,0E8h, 0Dh,0EFh
		db	0E8h, 0Fh,0F3h, 05h, 3Ch, 45h
		db	 53h, 43h, 3Eh,0E8h,0CBh,0D9h
		db	0B8h, 0Fh, 00h,0E8h, 5Eh,0CDh
		db	0E8h,0F8h,0EEh,0E8h,0FAh,0F2h
		db	 06h, 20h, 6Eh, 65h, 62h, 6Fh
		db	 20h,0E8h,0B5h,0D9h,0B8h, 0Eh
		db	 00h,0E8h, 48h,0CDh,0E8h,0E2h
		db	0EEh,0E8h,0E4h,0F2h, 02h, 5Eh
		db	 43h,0E8h,0A3h,0D9h,0B8h, 0Fh
		db	 00h,0E8h, 36h,0CDh,0E8h,0D0h
		db	0EEh,0E8h,0D2h,0F2h
		db	'* pro zastaven'
		db	0A1h, 2Ch, 20h, 6Ah, 69h, 6Eh
		db	0A0h, 20h, 6Bh, 6Ch,0A0h
		db	'vesa - pokra'
		db	 87h, 6Fh, 76h,0A0h, 6Eh,0A1h
		db	0E8h, 69h,0D9h
loc_547:
		call	sub_45			; (0DA4)
		jnz	loc_548			; Jump if not zero
		jmp	loc_549			; (36D5)
loc_548:
		mov	di,14Ah
		push	ds
		call	sub_122			; (253B)
		mov	di,2BFh
		push	ds
		call	sub_132			; (2762)
		call	sub_57			; (1022)
		jmp	loc_547			; (36B9)
		nop				;*jump fixup
loc_549:
		mov	di,14Ah
		push	ds
		call	sub_122			; (253B)
		mov	di,2BFh
		push	ds
		call	sub_132			; (2762)
		call	sub_57			; (1022)
		call	sub_45			; (0DA4)
		push	ax
		mov	al,byte ptr ds:[2BFh]	; (8876:02BF=0FEh)
		xor	ah,ah			; Zero register
		cmp	ax,1Bh
		mov	ax,1
		jz	loc_550			; Jump if zero
		dec	ax
loc_550:
		pop	cx
		and	ax,cx
		or	ax,ax			; Zero ?
		jnz	loc_551			; Jump if not zero
		jmp	loc_552			; (3719)
loc_551:
		mov	di,14Ah
		push	ds
		call	sub_122			; (253B)
		mov	di,2BFh
		push	ds
		call	sub_132			; (2762)
		call	sub_57			; (1022)
		mov	ax,20h
		mov	byte ptr ds:[2BFh],al	; (8876:02BF=0FEh)
loc_552:
		mov	al,byte ptr ds:[2BFh]	; (8876:02BF=0FEh)
		xor	ah,ah			; Zero register
		cmp	ax,3
		mov	ax,1
		jz	loc_553			; Jump if zero
		dec	ax
loc_553:
		push	ax
		mov	al,byte ptr ds:[2BFh]	; (8876:02BF=0FEh)
		xor	ah,ah			; Zero register
		cmp	ax,1Bh
		mov	ax,1
		jz	loc_554			; Jump if zero
		dec	ax
loc_554:
		pop	cx
		or	ax,cx
		or	ax,ax			; Zero ?
		jnz	loc_555			; Jump if not zero
		jmp	loc_556			; (3771)
loc_555:
		mov	ax,7
		call	sub_11			; (03BB)
		mov	ax,0
		call	sub_12			; (03CF)
		mov	di,2CDh
		push	ds
		push	di
		mov	ax,0B800h
		push	ax
		mov	ax,0
		xchg	ax,di
		pop	es
		push	es
		push	di
		mov	ax,0FA0h
		call	sub_53			; (0F4D)
		mov	ax,word ptr ds:[2C9h]	; (8876:02C9=2F8h)
		push	ax
		mov	ax,word ptr ds:[2CBh]	; (8876:02CB=0A02Eh)
		call	sub_46			; (0DAA)
		xor	ax,ax			; Zero register
;*		jmp	loc_110			;*(0C89)
		db	0E9h, 18h,0D5h
loc_556:
		mov	ax,1
		push	ax
		mov	ax,19h
		call	sub_46			; (0DAA)
		mov	ax,0
		call	sub_11			; (03BB)
		mov	ax,0
		call	sub_12			; (03CF)
		call	sub_5			; (02AA)
		mov	ax,2
		push	ax
		mov	ax,5
		push	ax
		mov	ax,48h
		push	ax
		mov	ax,15h
		call	sub_10			; (038D)
		mov	ax,ds:data_23e		; (0000:0264=0)
		push	ax
		mov	ax,word ptr ds:[2C7h]	; (0000:02C7=0)
		call	sub_46			; (0DAA)
		call	sub_123			; (2558)
		call	sub_138			; (2975)
		call	sub_57			; (1022)
		mov	ax,4
		mov	word ptr ds:[2C3h],ax	; (8876:02C3=5A5Dh)
loc_557:
		mov	di,136Eh
		push	ds
		call	sub_64			; (11CC)
		call	sub_70			; (137E)
		cmp	ax,14h
		jl	loc_558			; Jump if < jmp="" loc_559="" ;="" (37e2)="" loc_558:="" mov="" di,136eh="" push="" ds="" push="" di="" mov="" di,136eh="" push="" ds="" call="" sub_64="" ;="" (11cc)="" mov="" ax,2001h="" push="" ax="" call="" sub_68="" ;="" (12fd)="" mov="" cl,0ffh="" call="" sub_66="" ;="" (11fb)="" jmp="" loc_557="" ;="" (37b5)="" nop="" ;*jump="" fixup="" loc_559:="" mov="" ax,2e01h="" push="" ax="" mov="" di,136eh="" push="" ds="" call="" sub_64="" ;="" (11cc)="" call="" sub_71="" ;="" (138b)="" cmp="" ax,0="" jg="" loc_560="" ;="" jump="" if="">
		jmp	loc_562			; (382F)
loc_560:
		mov	al,byte ptr ds:[1377h]	; (8876:1377=14h)
		xor	ah,ah			; Zero register
		cmp	ax,2Eh
		jne	loc_561			; Jump if not equal
		jmp	loc_562			; (382F)
loc_561:
		mov	ax,2001h
		push	ax
		mov	di,136Eh
		push	ds
		push	di
		mov	ax,1
		mov	cl,0FFh
		call	sub_72			; (13CF)
		mov	di,136Eh
		push	ds
		push	di
		mov	di,136Eh
		push	ds
		call	sub_64			; (11CC)
		call	sub_70			; (137E)
		push	ax
		mov	ax,1
		call	sub_73			; (1427)
		jmp	loc_560			; (37F8)
		nop				;*jump fixup
loc_562:
		mov	ax,2
		call	sub_11			; (03BB)
		mov	al,byte ptr ds:[2A9h]	; (8876:02A9=0C3h)
		xor	ah,ah			; Zero register
		and	ax,8
		cmp	ax,0
		je	loc_563			; Jump if equal
		jmp	loc_564			; (3861)
loc_563:
		call	sub_123			; (2558)
		call	sub_137			; (295D) Sub does not return here
		db	 02h, 20h, 20h,0BFh, 6Eh, 13h
		db	 1Eh,0E8h, 77h,0D9h,0B8h, 00h
		db	 00h,0E8h,0CBh,0F0h,0E8h,0C4h
		db	0D7h,0E9h, 5Eh, 00h
loc_564:
		call	sub_123			; (2558)
		mov	ax,20h
		push	ax
		mov	ax,0
		call	sub_134			; (289D)
		call	sub_57			; (1022)
		mov	ax,0
		call	sub_11			; (03BB)
		mov	ax,7
		call	sub_12			; (03CF)
		mov	di,136Eh
		push	ds
		push	di
		mov	ax,9
		push	ax
		mov	ax,1
		call	sub_73			; (1427)
		call	sub_123			; (2558)
		mov	ax,20h
		push	ax
		mov	ax,0
		call	sub_134			; (289D)
		mov	di,136Eh
		push	ds
		call	sub_64			; (11CC)
		mov	ax,0
		call	sub_136			; (2926)
		mov	ax,20h
		push	ax
		mov	ax,0
		call	sub_134			; (289D)
		call	sub_57			; (1022)
		mov	ax,0
		call	sub_12			; (03CF)
		mov	ax,2
		call	sub_11			; (03BB)
		mov	al,ds:data_51e		; (0274:02A9=87h)
		xor	ah,ah			; Zero register
		mov	ds:data_56e,al		; (0274:126D=1Eh)
		call	sub_123			; (2558)
		mov	ax,20h
		push	ax
		mov	ax,0
		call	sub_134			; (289D)
		call	sub_57			; (1022)
		mov	ax,1
		push	ax
		mov	ax,3
		pop	cx
		xchg	ax,cx
		sub	cx,ax
		jge	loc_565			; Jump if > or =
		jmp	loc_574			; (3984)
loc_565:
		inc	cx
		mov	ds:data_55e,ax		; (0274:02C1=0FAC3h)
loc_566:
		push	cx
		mov	al,byte ptr ds:[126Dh]	; (8876:126D=16h)
		xor	ah,ah			; Zero register
		and	ax,1
		cmp	ax,0
		jne	loc_567			; Jump if not equal
		jmp	loc_568			; (3921)
loc_567:
		mov	ax,word ptr ds:[2C1h]	; (8876:02C1=10CDh)
		xchg	ax,di
		call	sub_123			; (2558)
		mov	al,byte ptr cs:[2D9Fh][di]	; (8876:2D9F=3)
		xor	ah,ah			; Zero register
		push	ax
		mov	ax,0
		call	sub_134			; (289D)
		mov	ax,20h
		push	ax
		mov	ax,0
		call	sub_134			; (289D)
		call	sub_57			; (1022)
		jmp	loc_573			; (396C)
loc_568:
		mov	al,ds:data_51e		; (0274:02A9=87h)
		xor	ah,ah			; Zero register
		cmp	ax,0FFh
		je	loc_569			; Jump if equal
		jmp	loc_570			; (3941)
loc_569:
		call	sub_123			; (2558)
		mov	ax,20h
		push	ax
		mov	ax,0
		call	sub_134			; (289D)
		call	sub_57			; (1022)
		jmp	loc_573			; (396C)
loc_570:
		mov	al,ds:data_51e		; (0274:02A9=87h)
		xor	ah,ah			; Zero register
		and	ax,8
		cmp	ax,0
		je	loc_571			; Jump if equal
		jmp	loc_572			; (3960)
loc_571:
		call	sub_123			; (2558)
		call	sub_137			; (295D) Sub does not return here
		db	 02h, 2Eh, 20h,0E8h,0C5h,0D6h
		db	0E9h, 0Ch, 00h
loc_572:
		call	sub_123			; (2558)
		call	sub_137			; (295D) Sub does not return here
		db	 02h, 20h, 20h,0E8h,0B6h,0D6h
loc_573:
		mov	al,ds:data_56e		; (0274:126D=1Eh)
		xor	ah,ah			; Zero register
		mov	cx,1
		shr	ax,cl			; Shift w/zeros fill
		mov	ds:data_56e,al		; (0274:126D=1Eh)
		pop	cx
		dec	cx
		jz	loc_574			; Jump if zero
		inc	word ptr ds:data_55e	; (0274:02C1=0FAC3h)
		jmp	loc_566			; (38EB)
loc_574:
		mov	al,ds:data_51e		; (0274:02A9=87h)
		xor	ah,ah			; Zero register
		and	ax,20h
		cmp	ax,0
		jne	loc_575			; Jump if not equal
		jmp	loc_576			; (39A7)
loc_575:
		call	sub_123			; (2558)
		mov	ax,41h
		push	ax
		mov	ax,0
		call	sub_134			; (289D)
		call	sub_57			; (1022)
		jmp	loc_579			; (39DA)
loc_576:
		mov	al,ds:data_51e		; (0274:02A9=87h)
		xor	ah,ah			; Zero register
		and	ax,8
		cmp	ax,0
		je	loc_577			; Jump if equal
		jmp	loc_578			; (39CA)
loc_577:
		call	sub_123			; (2558)
		mov	ax,2Eh
		push	ax
		mov	ax,0
		call	sub_134			; (289D)
		call	sub_57			; (1022)
		jmp	loc_579			; (39DA)
loc_578:
		call	sub_123			; (2558)
		mov	ax,20h
		push	ax
		mov	ax,0
		call	sub_134			; (289D)
		call	sub_57			; (1022)
loc_579:
		mov	al,ds:data_51e		; (0274:02A9=87h)
		xor	ah,ah			; Zero register
		and	ax,10h
		cmp	ax,0
		jne	loc_580			; Jump if not equal
		jmp	loc_581			; (3A10)
loc_580:
		mov	ax,0Ah
		call	sub_11			; (03BB)
		call	sub_123			; (2558)
		call	sub_65			; (11E5)
		pop	es
		inc	cx
		db	 64h, 72h, 65h, 73h,0A0h,0A9h
		db	0B8h, 0Ah, 00h,0E8h, 22h,0EFh
		db	0E8h, 1Bh,0D6h,0B8h, 02h, 00h
		db	0E8h,0AEh,0C9h,0E9h, 65h, 00h
loc_581:
		mov	al,ds:data_51e		; (0274:02A9=87h)
		xor	ah,ah			; Zero register
		and	ax,8
		cmp	ax,0
		je	loc_582			; Jump if equal
		jmp	loc_583			; (3A3F)
loc_582:
		call	sub_123			; (2558)
		mov	cx,18h
		call	sub_56			; (0FD1)
		sub	sp,6
		call	sub_145			; (2DA3)
		mov	ax,0Ah
		push	ax
		mov	ax,0
		call	sub_135			; (28EE)
		call	sub_57			; (1022)
		jmp	loc_584			; (3A75)
loc_583:
		call	sub_123			; (2558)
		call	sub_137			; (295D) Sub does not return here
		db	 02h, 20h, 20h,0E8h,0D7h,0D5h
		db	0B8h, 00h, 00h,0E8h, 6Ah,0C9h
		db	0B8h, 07h, 00h,0E8h, 78h,0C9h
		db	0E8h,0FEh,0EAh,0E8h, 00h,0EFh
		db	8, 'Jmenovka'
		db	0E8h,0B9h,0D5h,0B8h, 02h, 00h
		db	0E8h, 4Ch,0C9h,0B8h, 00h, 00h
		db	0E8h, 5Ah,0C9h
loc_584:
		call	sub_123			; (2558)
		call	sub_137			; (295D) Sub does not return here
		db	 03h, 20h, 20h, 20h,0B9h, 0Bh
		db	 00h,0E8h, 4Ch,0D5h, 83h,0ECh
		db	 03h,0A1h,0AAh, 02h, 8Ah,0C4h
		db	 32h,0E4h,0B9h, 08h, 00h, 99h
		db	0F7h,0F9h, 50h,0E8h,0ADh,0F3h
		db	0B8h, 00h, 00h,0E8h, 87h,0EEh
		db	0B8h, 3Ah, 00h, 50h,0B8h, 00h
		db	 00h,0E8h,0F4h,0EDh,0B9h, 0Bh
		db	 00h,0E8h, 22h,0D5h, 83h,0ECh
		db	 03h,0B8h, 08h, 00h, 50h,0A1h
		db	0AAh, 02h, 8Ah,0C4h, 32h,0E4h
		db	0B9h, 08h, 00h, 99h,0F7h,0F9h
		db	 92h, 59h,0F7h,0E9h, 50h,0A1h
		db	0AAh, 02h, 32h,0E4h,0B9h, 20h
		db	 00h, 99h,0F7h,0F9h, 59h, 03h
		db	0C1h, 50h,0E8h, 6Ch,0F3h,0B8h
		db	 00h, 00h,0E8h, 46h,0EEh,0B8h
		db	 3Ah, 00h, 50h,0B8h, 00h, 00h
		db	0E8h,0B3h,0EDh,0B9h, 0Bh, 00h
		db	0E8h,0E1h,0D4h, 83h,0ECh, 03h
		db	0B8h, 02h, 00h, 50h,0A1h,0AAh
		db	 02h, 32h,0E4h,0B9h, 20h, 00h
		db	 99h,0F7h,0F9h, 92h, 59h,0F7h
		db	0E9h, 50h,0E8h, 3Ch,0F3h,0B8h
		db	 00h, 00h,0E8h, 16h,0EEh,0E8h
		db	 4Ah,0EEh, 03h, 20h, 20h, 20h
		db	0B9h, 0Bh, 00h,0E8h,0B4h,0D4h
		db	 83h,0ECh, 03h,0A1h,0ACh, 02h
		db	 32h,0E4h,0B9h, 20h, 00h, 99h
		db	0F7h,0F9h, 92h, 50h,0E8h, 16h
		db	0F3h,0B8h, 00h, 00h,0E8h,0F0h
		db	0EDh,0B8h, 2Fh, 00h, 50h,0B8h
		db	 00h, 00h,0E8h, 5Dh,0EDh,0B9h
		db	 0Bh, 00h,0E8h, 8Bh,0D4h, 83h
		db	0ECh, 03h,0B8h, 08h, 00h, 50h
		db	0A1h,0ACh, 02h, 8Ah,0C4h, 32h
		db	0E4h, 25h, 01h, 00h, 59h,0F7h
		db	0E9h, 50h,0A1h,0ACh, 02h, 32h
		db	0E4h,0B9h, 20h, 00h, 99h,0F7h
		db	0F9h, 59h, 03h,0C1h, 50h,0E8h
		db	0D9h,0F2h,0B8h, 00h, 00h,0E8h
		db	0B3h,0EDh,0B8h, 2Fh, 00h, 50h
		db	0B8h, 00h, 00h,0E8h, 20h,0EDh
		db	0A1h,0ACh, 02h, 8Ah,0C4h, 32h
		db	0E4h,0B9h, 02h, 00h, 99h,0F7h
		db	0F9h, 05h,0BCh, 07h, 50h,0B8h
		db	 04h, 00h,0E8h, 25h,0EDh,0E8h
		db	 8Bh,0D4h,0A1h,0C3h, 02h, 3Dh
		db	 11h, 00h, 7Ch, 03h,0E9h, 09h
		db	 00h,0E8h,0B3h,0E9h,0E8h,0CDh
		db	0EDh,0E8h, 77h,0D4h
loc_585:
		mov	ax,4F00h
		mov	data_194,ax		; (8876:0260=41h)
		mov	ax,ds
		mov	word ptr ds:[26Eh],ax	; (8876:026E=4)
		mov	di,275h
		xchg	ax,di
		mov	word ptr ds:[266h],ax	; (8876:0266=3E8Ah)
		mov	di,260h
		push	ds
		call	sub_54			; (0F67)
		int	21h			; DOS Services  ah=function 02h
						;  display char dl
		call	sub_55			; (0F8F)
		jmp	loc_538			; (3558)
loc_586:
		mov	ax,1
		push	ax
		mov	ax,1
		push	ax
		mov	ax,50h
		push	ax
		mov	ax,19h
		call	sub_10			; (038D)
		mov	ax,1Dh
		push	ax
		mov	ax,17h
		call	sub_46			; (0DAA)
		mov	ax,0Eh
		call	sub_11			; (03BB)
		mov	ax,4
		call	sub_12			; (03CF)
		call	sub_123			; (2558)
		call	sub_137			; (295D) Sub does not return here
		db	0Eh
		db	' Konec v'
		db	 98h, 70h, 69h, 73h, 75h, 20h
		db	0E8h, 16h,0D4h,0B8h, 02h, 00h
		db	 50h,0B8h, 19h, 00h,0E8h, 94h
		db	0D1h,0B8h, 0Fh, 00h,0E8h, 9Fh
		db	0C7h,0B8h, 04h, 00h,0E8h,0ADh
		db	0C7h,0E8h, 33h,0E9h,0E8h, 35h
		db	0EDh
		db	47h
		db	16 dup (20h)
		db	 4Eh,0A0h
		db	'vrat do syst'
		db	82h
		db	'mu po stisknut'
		db	0A1h, 20h, 6Bh, 6Ch,0A0h
		db	 76h, 65h, 73h, 79h
		db	17 dup (20h)
		db	0E8h,0AFh,0D3h
loc_587:
		call	sub_45			; (0DA4)
		jnz	loc_588			; Jump if not zero
		jmp	loc_589			; (3C8F)
loc_588:
		mov	di,14Ah
		push	ds
		call	sub_122			; (253B)
		mov	di,2BFh
		push	ds
		call	sub_132			; (2762)
		call	sub_57			; (1022)
		jmp	loc_587			; (3C73)
		nop				;*jump fixup
loc_589:
		mov	di,14Ah
		push	ds
		call	sub_122			; (253B)
		mov	di,2BFh
		push	ds
		call	sub_132			; (2762)
		call	sub_57			; (1022)
loc_590:
		call	sub_45			; (0DA4)
		jnz	loc_591			; Jump if not zero
		jmp	loc_592			; (3CBC)
loc_591:
		mov	di,14Ah
		push	ds
		call	sub_122			; (253B)
		mov	di,2BFh
		push	ds
		call	sub_132			; (2762)
		call	sub_57			; (1022)
		jmp	loc_590			; (3CA0)
		nop				;*jump fixup
loc_592:
		mov	ax,7
		call	sub_11			; (03BB)
		mov	ax,0
		call	sub_12			; (03CF)
		mov	di,2CDh
		push	ds
		push	di
		mov	ax,0B800h
		push	ax
		mov	ax,0
		xchg	ax,di
		pop	es
		push	es
		push	di
		mov	ax,0FA0h
		call	sub_53			; (0F4D)
		mov	ax,word ptr ds:[2C9h]	; (8876:02C9=2F8h)
		push	ax
		mov	ax,word ptr ds:[2CBh]	; (8876:02CB=0A02Eh)
		call	sub_46			; (0DAA)
		jmp	loc_593			; (3CEB)
loc_593:
		xor	ax,ax			; Zero register
;*		call	sub_43			;*(0C89)
		db	0E8h, 99h,0CFh
		add	[bx+si],al
		add	cl,ch
		jns	loc_594			; Jump if not sign
		add	[bx+si],al
		add	[bx+si],al
		add	[bx+si],al
		push	ss
		pop	ss
		db	0C1h, 02h, 17h, 0Eh, 00h, 1Ah
		db	 16h, 17h,0C1h, 02h, 05h, 00h
		db	 00h, 20h, 00h,0BFh, 05h, 00h
		db	 1Ah, 04h, 13h,0E4h, 6Ah, 00h
		db	 01h, 00h, 00h, 00h, 00h, 10h
		db	 00h, 00h, 02h,0ACh,0BCh,0BEh
loc_594:
		mov	cl,0ACh
		mov	bh,0B6h
		mov	dx,0ADABh
		mov	si,0A9AFh
		mov	dh,0ADh
		stosb				; Store al to es:[di]
		test	ax,0B0BCh
		scasw				; Scan es:[di] for ax
		mov	si,0ABACh
		mov	si,0B3BEh
		mov	dh,0B4h
		mov	si,data_246e		; (8876:B0A5=0)
		lodsw				; String [si] to ax
		lodsw				; String [si] to ax
		mov	dx,0D1A7h
		mov	dl,0BEh
		mov	cl,0BBh
		stosb				; Store al to es:[di]
		mov	dx,0BAA7h
		stosb				; Store al to es:[di]
		mov	sp,0B2B0h
		test	ax,0ADB6h
		stosw				; Store ax to es:[di]
		mov	sp,0BAB3h
		mov	si,0ACABh
		mov	si,0B1B9h
		mov	si,0D1A9h
		mov	dh,0B1h
		mov	dh,0D1h
		mov	bp,0B0B0h
		stosw				; Store ax to es:[di]
		int	3			; Debug breakpoint
		scasw				; Scan es:[di] for ax
		sar	word ptr [bp+si-654Fh],1	; Shift w/sign fill
		mov	[bp+si-7465h],ds
;*		call	far ptr sub_163		;*(8D90:8FDF)
		db	 9Ah,0DFh, 8Fh, 90h, 8Dh
		sahf				; Store ah into flags
		esc	7,[bp+si-7021h]		; coprocessor escape
		nop
		pushf				; Push flags
		xchg	ax,si
		mov	bx,[bp-6564h]
		esc	7,[bp-7A21h]		; coprocessor escape
		xchg	ax,sp
		mov	cl,ds:data_244e[si]	; (8876:9A8B=0)
		esc	7,ds:data_245e[di]	; (8876:9B9A=0) coprocessor escape
		xchg	ax,cx
		nop
		mov	bl,bh
		db	 9Bh, 9Ah, 93h, 9Eh, 8Bh,0DFh
		db	 91h, 9Ah, 9Ch, 90h,0DFh, 8Dh
		db	 90h, 85h, 8Ah, 92h, 91h, 9Ah
		db	 97h, 90h,0DEh,0DFh
		db	37 dup (0DFh)
		db	19 dup (0D5h)
		db	43 dup (0DFh)
		db	0DEh,0DEh,0DFh,0AFh, 90h, 8Ch
		db	 93h, 90h, 8Ah, 9Ch, 97h, 9Ah
		db	 95h, 8Bh, 9Ah,0DFh,0B7h,0BAh
		db	0B3h,0B3h,0B0h,0A8h,0BAh,0BAh
		db	0B1h,0DFh,0D2h,0DFh, 91h, 9Ah
		db	 95h, 93h, 9Ah, 8Fh, 8Ch, 96h
		db	0DFh, 92h, 9Ah, 8Bh, 9Eh, 93h
		db	 90h, 89h, 90h, 8Ah,0DFh, 8Ch
		db	 94h, 8Ah, 8Fh, 96h, 91h, 8Ah
		db	0DFh,0DEh,0DEh,0FFh
loc_595:
		call	sub_147			; (3E4A)
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_147		proc	near
		pop	si
		sub	si,158h
		push	si
		push	ax
		push	es
		push	cs
		pop	ds
		mov	ax,es
		add	[si+25h],ax
		add	[si+27h],ax
		cmp	byte ptr [si],0
		jne	loc_596			; Jump if not equal
		mov	ax,[si+1]
		mov	word ptr ds:[100h],ax	; (8876:0100=44E9h)
		mov	al,[si+3]
		mov	byte ptr ds:[102h],al	; (8876:0102=3Dh)
loc_596:
		mov	ax,0EC27h
		int	21h			; DOS Services  ah=function ECh
		cmp	ax,4D53h
		je	loc_598			; Jump if equal
		cmp	byte ptr [si],0
		jne	loc_597			; Jump if not equal
		cmp	sp,0FFF0h
		jb	loc_600			; Jump if below
loc_597:
		mov	ax,es
		dec	ax
		mov	es,ax
		cmp	byte ptr es:data_58e,5Ah	; (8875:0000=0FFh) 'Z'
		nop				;*ASM fixup - sign extn byte
		jne	loc_600			; Jump if not equal
		mov	ax,es:data_59e		; (8875:0003=0FFFFh)
		sub	ax,77h
		jc	loc_600			; Jump if carry Set
		mov	es:data_59e,ax		; (8875:0003=0FFFFh)
		sub	word ptr es:data_60e,77h	; (8875:0012=0)
		mov	es,es:data_60e		; (8875:0012=0)
		xor	di,di			; Zero register
		mov	cx,560h
		cld				; Clear direction
		push	si
		rep	movsb			; Rep when cx >0 Mov [si] to es:[di]
		pop	si
		push	es
		pop	ds
		call	sub_149			; (3F39)
loc_598:
		push	cx
		push	dx
		mov	ah,4
		int	1Ah			; Real time clock   ah=func 04h
						;  read date cx=year, dx=mon/day
		jc	loc_599			; Jump if carry Set
		cmp	dh,11h
		jne	loc_599			; Jump if not equal
		cmp	dl,1
		je	loc_601			; Jump if equal
loc_599:
		pop	dx
		pop	cx
loc_600:
		pop	es
		pop	ax
		push	es
		pop	ds
		pop	si
		mov	ss,cs:[si+27h]
;*		jmp	dword ptr cs:[si+23h]	;*1 entry
		db	 2Eh,0FFh, 6Ch, 23h
loc_601:
		xor	ax,ax			; Zero register
		push	ax
		pop	es
		mov	al,es:data_31e		; (0000:0449=3)
		cmp	al,7
		je	loc_602			; Jump if equal
		cmp	al,2
		jb	loc_599			; Jump if below
		cmp	al,3
		ja	loc_599			; Jump if above
		mov	ax,0B800h
		jmp	short loc_603		; (3EF2)
loc_602:
		mov	ax,0B000h
loc_603:
		push	ax
		pop	ds
		mov	ax,es:data_32e		; (0000:044E=0)
		push	si
		push	ax
		pop	si
		mov	cx,7D0h
  
locloop_604:
		mov	word ptr [si],4F20h
		inc	si
		inc	si
		loop	locloop_604		; Loop if cx > 0
  
		pop	si
		mov	di,data_248e		; (B000:06F2=0FFh)
		push	ax
		mov	ax,si
		add	ax,79h
		mov	si,ax
		pop	ax
		push	ax
		add	ax,di
		mov	di,ax
		pop	ax
		call	sub_148			; (3F28)
		mov	ah,0
		int	16h			; Keyboard i/o  ah=function 00h
						;  get keybd char in al, ah=scan
		mov	ax,0FFFFh
		push	ax
		xor	ax,ax			; Zero register
		push	ax
		retf				; Return far
sub_147		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_148		proc	near
loc_605:
		mov	al,cs:[si]
		xor	al,0FFh
		cmp	al,0
		jne	loc_606			; Jump if not equal
		retn
loc_606:
		mov	[di],al
		inc	di
		inc	di
		inc	si
		jmp	short loc_605		; (3F28)
sub_148		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_149		proc	near
		mov	ax,3521h
		int	21h			; DOS Services  ah=function 35h
						;  get intrpt vector al in es:bx
		mov	ds:data_7e,bx		; (0000:000A=0F000h)
		mov	ds:data_8e,es		; (0000:000C=6F4h)
		mov	ds:data_10e,bx		; (0000:0012=70h)
		mov	ds:data_11e,es		; (0000:0014=0FF54h)
		mov	ax,2521h
;*		mov	dx,offset loc_2		;*
		db	0BAh, 65h, 02h
		int	21h			; DOS Services  ah=function 25h
						;  set intrpt vector al to ds:dx
		retn
sub_149		endp
  
		pushf				; Push flags
		cmp	ax,2521h
		jne	loc_607			; Jump if not equal
		mov	cs:data_71e,dx		; (8876:000A=0)
		mov	word ptr cs:data_71e+2,ds	; (8876:000C=8876h)
		jmp	short loc_613		; (3FBD)
loc_607:
		cmp	ax,3521h
		jne	loc_608			; Jump if not equal
		les	bx,dword ptr cs:data_71e	; (8876:000A=0) Load 32 bit ptr
		jmp	short loc_613		; (3FBD)
loc_608:
		cmp	ah,4Bh			; 'K'
		jne	loc_611			; Jump if not equal
		or	al,al			; Zero ?
		jnz	loc_610			; Jump if not zero
		push	ax
		mov	cs:data_73e,sp		; (8876:000E=0)
		mov	cs:data_74e,ss		; (8876:0010=1FE6h)
		cli				; Disable interrupts
		mov	ax,cs
		mov	ss,ax
		mov	sp,760h
		sti				; Enable interrupts
		call	sub_157			; (3FED)
		jc	loc_609			; Jump if carry Set
		call	sub_159			; (4044)
loc_609:
		cli				; Disable interrupts
		mov	ss,cs:data_74e		; (8876:0010=1FE6h)
		mov	sp,cs:data_73e		; (8876:000E=0)
		sti				; Enable interrupts
		pop	ax
loc_610:
		popf				; Pop flags
		jmp	dword ptr cs:data_75e	; (8876:0012=0)
loc_611:
		cmp	ax,0EC27h
		jne	loc_612			; Jump if not equal
		mov	ax,4D53h
		jmp	short loc_613		; (3FBD)
loc_612:
		popf				; Pop flags
		jmp	dword ptr cs:data_71e	; (8876:000A=0)
loc_613:
		popf				; Pop flags
		iret				; Interrupt return
		db	0B0h, 03h,0CFh
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_150		proc	near
		mov	ah,40h			; '@'
		jmp	short loc_614		; (3FC8)
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_151:
		mov	ah,3Fh			; '?'
loc_614:
		call	sub_155			; (3FE0)
		jc	loc_ret_615		; Jump if carry Set
		sub	ax,cx
  
loc_ret_615:
		retn
sub_150		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_152		proc	near
		xor	cx,cx			; Zero register
		xor	dx,dx			; Zero register
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_153:
		mov	ax,4202h
		jmp	short loc_616		; (3FE0)
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_154:
		xor	cx,cx			; Zero register
		xor	dx,dx			; Zero register
		mov	ax,4200h
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_155:
loc_616:
		mov	bx,cs:data_77e		; (8876:0016=0)
  
;ßßßß External Entry into Subroutine ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
  
sub_156:
		cli				; Disable interrupts
		pushf				; Push flags
		call	dword ptr cs:data_75e	; (8876:0012=0)
		retn
sub_152		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_157		proc	near
		push	ax
		push	bx
		push	cx
		push	dx
		push	si
		push	di
		push	es
		push	cs
		pop	es
		mov	bx,2Dh
		mov	al,4Ah			; 'J'
loc_617:
		push	ax
		call	sub_158			; (4012)
		pop	ax
		jc	loc_618			; Jump if carry Set
		add	bx,4
		dec	al
		jnz	loc_617			; Jump if not zero
		clc				; Clear carry flag
loc_618:
		pop	es
		pop	di
		pop	si
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		retn
sub_157		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_158		proc	near
		mov	ch,80h
		mov	si,dx
		mov	di,bx
loc_619:
		cmp	byte ptr [si],0
		je	loc_623			; Jump if equal
		mov	cl,4
loc_620:
		mov	al,[si]
		xor	al,0FFh
		cmp	al,cs:[di]
		jne	loc_621			; Jump if not equal
		inc	si
		inc	di
		dec	cl
		jnz	loc_620			; Jump if not zero
		jmp	short loc_624		; (4042)
loc_621:
		cmp	cl,4
		je	loc_622			; Jump if equal
		dec	si
		dec	di
		inc	cl
		jmp	short loc_621		; (4030)
loc_622:
		inc	si
		dec	ch
		jnz	loc_619			; Jump if not zero
loc_623:
		clc				; Clear carry flag
		retn
loc_624:
		stc				; Set carry flag
		retn
sub_158		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_159		proc	near
		push	bx
		push	cx
		push	si
		push	di
		push	es
		push	dx
		push	ds
		push	cs
		pop	ds
		mov	ax,3300h
		call	sub_156			; (3FE5)
		mov	ds:data_78e,dl		; (8876:0018=0)
		mov	ax,3301h
		xor	dx,dx			; Zero register
		call	sub_156			; (3FE5)
		mov	ax,3524h
		call	sub_156			; (3FE5)
		mov	word ptr ds:data_80e+1,bx	; (8876:001B=0)
		mov	word ptr ds:data_82e+1,es	; (8876:001D=8876h)
		mov	ax,2524h
		mov	dx,2CDh
		call	sub_156			; (3FE5)
		pop	ds
		pop	dx
		push	dx
		push	ds
		mov	ax,4300h
		call	sub_156			; (3FE5)
		mov	word ptr cs:data_78e+1,cx	; (8876:0019=0)
		mov	ax,4301h
		xor	cx,cx			; Zero register
		call	sub_156			; (3FE5)
		jnc	loc_625			; Jump if carry=0
		jmp	short loc_629		; (4110)
		db	90h
loc_625:
		mov	ax,3D02h
		call	sub_156			; (3FE5)
		jc	loc_628			; Jump if carry Set
		push	cs
		pop	ds
		mov	ds:data_77e,ax		; (8876:0016=0)
		mov	ax,5700h
		call	sub_155			; (3FE0)
		jc	loc_627			; Jump if carry Set
		mov	word ptr ds:data_84e+1,dx	; (8876:001F=0)
		mov	ds:data_87e,cx		; (8876:0021=0)
		mov	cx,0FFFFh
		mov	dx,0FFFDh
		call	sub_153			; (3FD4)
		jc	loc_627			; Jump if carry Set
		mov	dx,560h
		mov	cx,2
		call	sub_151			; (3FC6)
		jc	loc_627			; Jump if carry Set
		cmp	word ptr ds:[560h],0FD71h	; (8876:0560=1EA3h)
		stc				; Set carry flag
		jz	loc_627			; Jump if zero
		call	sub_154			; (3FD9)
		jc	loc_627			; Jump if carry Set
		mov	dx,560h
		mov	cx,1Ch
		call	sub_151			; (3FC6)
		jc	loc_627			; Jump if carry Set
		cmp	word ptr ds:[560h],5A4Dh	; (8876:0560=1EA3h)
		je	loc_626			; Jump if equal
		call	sub_160			; (412E)
		jmp	short loc_627		; (40EE)
loc_626:
		call	sub_161			; (4184)
loc_627:
		mov	ax,5701h
		mov	dx,word ptr ds:data_84e+1	; (8876:001F=0)
		mov	cx,ds:data_87e		; (8876:0021=0)
		call	sub_155			; (3FE0)
		mov	ah,3Eh			; '>'
		call	sub_155			; (3FE0)
		pop	ds
		pop	dx
		push	dx
		push	ds
loc_628:
		mov	ax,4301h
		mov	cx,word ptr cs:data_78e+1	; (8876:0019=0)
		call	sub_156			; (3FE5)
loc_629:
		mov	ax,2524h
		lds	dx,dword ptr cs:data_80e+1	; (8876:001B=0) Load 32 bit ptr
		call	sub_156			; (3FE5)
		mov	ax,3301h
		mov	dl,cs:data_78e		; (8876:0018=0)
		call	sub_156			; (3FE5)
		pop	ds
		pop	dx
		pop	es
		pop	di
		pop	si
		pop	cx
		pop	bx
		retn
sub_159		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_160		proc	near
		call	sub_152			; (3FD0)
		jc	loc_ret_630		; Jump if carry Set
		or	dx,dx			; Zero ?
		jnz	loc_ret_630		; Jump if not zero
		cmp	ax,0F89Fh
		jae	loc_ret_630		; Jump if above or =
		mov	si,ax
		mov	byte ptr ds:data_61e,0	; (8876:0000=0)
		nop				;*ASM fixup - sign extn byte
		mov	word ptr ds:data_89e,100h	; (8876:0023=1600h)
		mov	word ptr ds:data_91e,0	; (8876:0025=1)
		mov	word ptr ds:data_93e,0	; (8876:0027=0)
		mov	ax,word ptr ds:[560h]	; (8876:0560=1EA3h)
		mov	word ptr ds:data_61e+1,ax	; (8876:0001=0)
		mov	al,byte ptr ds:[562h]	; (8876:0562=0)
		mov	byte ptr ds:data_63e+1,al	; (8876:0003=0)
		push	si
		call	sub_162			; (4241)
		pop	si
		jc	loc_ret_630		; Jump if carry Set
		call	sub_154			; (3FD9)
		jc	loc_ret_630		; Jump if carry Set
		mov	byte ptr ds:[560h],0E9h	; (8876:0560=0A3h)
		add	si,152h
		mov	word ptr ds:[561h],si	; (8876:0561=1Eh)
		mov	dx,560h
		mov	cx,3
		call	sub_150			; (3FC2)
  
loc_ret_630:
		retn
sub_160		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_161		proc	near
		call	sub_152			; (3FD0)
		jc	loc_ret_630		; Jump if carry Set
		mov	si,ax
		mov	di,dx
		mov	bx,ax
		mov	cx,dx
		mov	ax,word ptr ds:[564h]	; (8876:0564=16h)
		mul	word ptr ds:data_97e	; (8876:002B=0) ax = data * ax
		sub	ax,bx
		sbb	dx,cx
		jc	loc_ret_630		; Jump if carry Set
		mov	ax,word ptr ds:[56Eh]	; (8876:056E=0C303h)
		mul	word ptr ds:data_95e	; (8876:0029=0) ax = data * ax
		add	ax,word ptr ds:[570h]	; (8876:0570=1EA3h)
		mov	cx,dx
		mov	bx,ax
		mov	ax,word ptr ds:[568h]	; (8876:0568=1Ah)
		mul	word ptr ds:data_95e	; (8876:0029=0) ax = data * ax
		sub	si,ax
		sbb	di,dx
		mov	ax,word ptr ds:[56Eh]	; (8876:056E=0C303h)
		add	ax,10h
		mov	ds:data_93e,ax		; (8876:0027=0)
		mov	ax,bx
		mov	dx,cx
		sub	bx,si
		sbb	cx,di
		jc	loc_631			; Jump if carry Set
		push	si
		push	di
		add	si,32h
		adc	di,0
		sub	ax,si
		sbb	dx,di
		pop	di
		pop	si
		jc	loc_ret_632		; Jump if carry Set
		add	word ptr ds:[56Eh],57h	; (8876:056E=0C303h)
loc_631:
		mov	byte ptr ds:data_61e,1	; (8876:0000=0)
		nop				;*ASM fixup - sign extn byte
		mov	ax,word ptr ds:[576h]	; (8876:0576=601h)
		add	ax,10h
		mov	ds:data_91e,ax		; (8876:0025=1)
		mov	ax,word ptr ds:[574h]	; (8876:0574=18h)
		mov	ds:data_89e,ax		; (8876:0023=1600h)
		call	sub_152			; (3FD0)
		jc	loc_ret_632		; Jump if carry Set
		mov	bx,ax
		mov	cx,dx
		add	bx,560h
		adc	cx,0
		mov	dx,di
		mov	ax,si
		div	word ptr ds:data_95e	; (8876:0029=0) ax,dxrem=dx:ax/data
		mov	word ptr ds:[576h],ax	; (8876:0576=601h)
		push	bx
		push	cx
		push	dx
		call	sub_162			; (4241)
		pop	dx
		pop	cx
		pop	bx
		jc	loc_ret_632		; Jump if carry Set
		add	dx,155h
		mov	word ptr ds:[574h],dx	; (8876:0574=18h)
		mov	ax,bx
		mov	dx,cx
		div	word ptr ds:data_97e	; (8876:002B=0) ax,dxrem=dx:ax/data
		inc	ax
		mov	word ptr ds:[564h],ax	; (8876:0564=16h)
		mov	word ptr ds:[562h],dx	; (8876:0562=0A100h)
		call	sub_154			; (3FD9)
		jc	loc_ret_632		; Jump if carry Set
		mov	cx,1Ch
		mov	dx,560h
		call	sub_150			; (3FC2)
  
loc_ret_632:
		retn
sub_161		endp
  
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_162		proc	near
		call	sub_152			; (3FD0)
		jc	loc_ret_633		; Jump if carry Set
		push	cs
		pop	ds
		mov	dx,0
		mov	cx,560h
		call	sub_150			; (3FC2)
  
loc_ret_633:
		retn
sub_162		endp
  
  
seg_a		ends
  
  
  
		end	start

</'></'></sp></reg16></bp></reg16></di></reg16></si></reg16></dx></reg16></cx></reg16></bx></reg16></sp></reg16></bp></reg16></di></reg16></si></reg16></dx></reg16></cx></reg16></bx></reg16>