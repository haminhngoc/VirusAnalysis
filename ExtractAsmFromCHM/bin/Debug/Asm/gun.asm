

;  Makes Machine gun sounds over the speaker.
;  shots= numero de disparos

shots equ 60

        mov cx,shots
machine_gun:
        push    cx                      ; Save the current count
        mov     dx,0140h                ; DX holds pitch
        mov     bx,0100h                ; BX holds shot duration
        in      al,061h                 ; Read the speaker port
        and     al,11111100b            ; Turn off the speaker bit
fire_shot:
        xor     al,2                    ; Toggle the speaker bit
        out     061h,al                 ; Write AL to speaker port
        add     dx,09248h               ;
        mov     cl,3                    ;
        ror     dx,cl                   ; Figure out the delay time
        mov     cx,dx                   ;
        and     cx,01FFh                ;
        or      cx,10                   ;
shoot_pause:
        loop    shoot_pause             ; Delay a bit
        dec     bx                      ; Are we done with the shot?
        jnz     fire_shot               ; If not, pulse the speaker
        and     al,11111100b            ; Turn off the speaker bit
        out     061h,al                 ; Write AL to speaker port
        mov     bx,0002h                ; BX holds delay time (ticks)
        xor     ah,ah                   ; Get time function
        int     1Ah                     ; BIOS timer interrupt
        add     bx,dx                   ; Add current time to delay
shoot_delay:
        int     1Ah                     ; Get the time again
        cmp     dx,bx                   ; Are we done yet?
        jne     shoot_delay             ; If not, keep checking
        pop     cx                      ; Restore the count
        loop    machine_gun             ; Do another shot
        ret

