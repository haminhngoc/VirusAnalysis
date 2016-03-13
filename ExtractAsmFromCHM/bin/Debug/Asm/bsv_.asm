

;Boot Sector for Virus Book Diskette


MAIN    SEGMENT BYTE
        ASSUME  CS:MAIN,DS:MAIN,SS:NOTHING

        ORG     100H

START:  jmp     SHORT GO

        DB      20H dup (?)


GO:
        mov     ax,cs
        mov     ds,ax
        mov     si,OFFSET MESSAGE + 7B00H   ;message location on boot-up
LOOP1:  lodsb                   ;get a byte from the string MESSAGE
        or      al,al
        jz      LOOP2           ;if it's zero, we're done
        mov     ah,0EH          ;else
        int     10H             ;write the byte to the monitor
        jmp     LOOP1           ;and go get another
LOOP2:  jmp     LOOP2           ;and hang up


MESSAGE DB      0DH,0AH,0AH
        DB      'WARNING! This diskette contains computer viruses!'
        DB      13,10,10,'DO NOT BOOT FROM THIS DISK AGAIN!!!',7,0


        ORG     2FEH

        DB      55H,0AAH

MAIN    ENDS


        END START

