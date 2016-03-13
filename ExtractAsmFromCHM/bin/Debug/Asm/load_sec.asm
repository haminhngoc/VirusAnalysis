

;LOAD_SEC - module for Mass Destruction Library
;written by Evil Avatar
.model tiny
.code
public load_sec, sec_buf

load_sec:
        push cx
        push ds               ;save regs that will be changed
        push ax               ;save drive number
        push cs
        pop ds
        push cs
        pop es                ;make es and ds the same as cs
        mov ax, 0dh
        int 21h               ;reset disk
        pop ax                ;restore drive number
        mov cx, 1
        mov bx, offset sec_buf
        int 25h               ;read sector into buffer
        pop ds
        pop cx
        ret                   ;restore regs and return
sec_buf dw 100h dup(?)
end load_sec

