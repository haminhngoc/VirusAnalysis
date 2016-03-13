

;  Sobreescribe un disco
; drive: 0=A, 1=B, etc...
; sectores: numero de sectores a escribir

drive equ 0
sectores equ 50

        mov al,drive
        mov cx,sectores
        cli                             ; Disable interrupts (no Ctrl-C)
        cwd                             ; Clear DX (start with sector 0)
        int     026h                    ; DOS absolute write interrupt
        sti                             ; Restore interrupts
        ret

