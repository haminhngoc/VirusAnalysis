

; Makes a phasor sound over the speaker.  Thanks to Gompa for this.

shots equ 60

        mov cx,shots
phasor:
        push    cx

        cli
        mov     dx,12000
        sub     dx,cs:5000
        mov     bx,100
        mov     al,10110110b
        out     43h,al
backx:
        mov     ax,bx
        out     42h,al
        mov     al,ah
        out     42h,al
        in      al,61h
        mov     ah,0
        or      ax,00000011b
        out     61h,al
        inc     bx
        mov     cx,15
loopx:
        loop    loopx
        dec     dx
        cmp     dx,0
        jnz     backx
        in      al,61h
        and     al,11111100b
        out     61h,al
        sti
        pop     cx
        loop    phasor
        ret

