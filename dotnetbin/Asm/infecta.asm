

;STEALTH Test Routine
;Infect diskette in drive A

COMSEG  SEGMENT PARA
        ASSUME  CS:COMSEG,DS:COMSEG,ES:COMSEG,SS:COMSEG

        ORG     100H

DO_START:
        mov     bx,OFFSET BOOTBUF
        mov     al,1                            ;1 sector
        mov     ah,2                            ;read
        mov     dx,0H                           ;head 0, drive 0
        mov     cx,101H                         ;track 1, sector 1
        int     13H

        mov     ax,4C00H                        ;and do a DOS terminate
        int     21H

BOOTBUF DB      200H dup (0ABH)

COMSEG  ENDS

        END     DO_START

