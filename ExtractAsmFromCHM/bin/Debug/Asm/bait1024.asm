﻿


PAGE  59,132

;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;ÛÛ								        	     ÛÛ
;ÛÛ			        BAIT.COM				           ÛÛ
;ÛÛ								        	     ÛÛ
;ÛÛ      Created:   08-Nov-90					           ÛÛ
;ÛÛ      Version:	  1.1					        	     ÛÛ
;ÛÛ                                                              ÛÛ
;ÛÛ	   Creates a "bait" .COM file to attract viral infections  ÛÛ
;ÛÛ								        	     ÛÛ
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ


seg_a		segment	byte public
		assume	cs:seg_a, ds:seg_a


		org	100h

bait		proc	far

start:
		jmp	exit
		db	1011 dup (90h)		; pad out with NOP's
							;  "3 dup" creates a file 
							;   10h (16 decimal) bytes
							;   in length.  Changing 
							;   this value will alter
							;   file to any length
							;	desired.
exit:
		mov	ah,4Ch			; terminate function
		mov	al,fill_1			; fill with zeros
		int	21h				; call DOS
							;  terminate with al=return code
		db	0
fill_1	db	0				; last 3 bytes are 0 for
		db	0				; separation of host from 
							; any virus that appends to
							; end of host file.
bait		endp

seg_a		ends

		end	start

