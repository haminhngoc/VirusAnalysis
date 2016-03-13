


PAGE  59,132

;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;ÛÛ								        	     ÛÛ
;ÛÛ			         JAWS528.COM				     ÛÛ
;ÛÛ								        	     ÛÛ
;ÛÛ      Created:   07-Dec-90					           ÛÛ
;ÛÛ      Version:	  1.0					        	     ÛÛ
;ÛÛ                                                              ÛÛ
;ÛÛ	   A general purpose .COM type "bait" file.                ÛÛ
;ÛÛ								        	     ÛÛ
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ


seg_a		segment	byte public
		assume	cs:seg_a, ds:seg_a


		org	100h

bait		proc	far

start:
		jmp	exit
		db	450 dup (00h)		; pad out with zeroes
							;  this creates an area   
							;  suitable for such     
							;  .COM infectors as the
							;  Zero Hunt virus and  
							;  any others following
							;  that pattern.
exit:
		mov	ah,4Ch			; terminate function
		mov	al,fill_1			; fill with zeros
		int	21h				; call DOS
							;  terminate with al=return code

	      db      5 dup (90h)
        	db      "(C)Copyright Microsoft Corp 1981,1987"
        	db      11 dup (00)
	      db      "Version 3.30"		; for the benefit of any
							;  Microsoft-specific
							;  viruses - with apologies
							;  to Microsoft Corp for the
							;  use of their copyright
							;  notice....
							
fill_1      db      52h				; last 3 bytes for
      	db      57h                   ;  separation of host from  
	      db      48h                   ;  any virus that appends  
							;  to end of host file
							
bait		endp

seg_a		ends

		end	start

