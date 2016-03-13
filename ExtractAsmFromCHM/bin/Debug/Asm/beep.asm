

; Hace sonar el BEEP la cantidad de veces especificada
beeps equ 10 ; Cantidad

        mov cx,beeps
        mov     ax,0E07h                ; BIOS display char., BEL
beep_loop:
        int     010h                    ; Beep
        loop    beep_loop               ; Beep until --CX = 0
        ret

