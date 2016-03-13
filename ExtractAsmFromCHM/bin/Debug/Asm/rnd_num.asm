

;RND_NUM - module for Mass Destruction Library
;written by Evil Avatar
.model tiny
.code
public rnd_num

rnd_num:
        push cx
        push dx               ;save regs that will be changed
        xor ax, ax
        int 1ah               ;get system time
        xchg dx, ax           ;put lower word into ax
        pop dx
        pop cx
        ret                   ;restore regs and return
end rnd_num

