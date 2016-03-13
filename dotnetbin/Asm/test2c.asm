

;Stealth Test 2C
;Read drive C boot sector into RAM - 16 sector read

COMSEG  SEGMENT PARA
        ASSUME  CS:COMSEG,DS:COMSEG,ES:COMSEG,SS:COMSEG

        ORG     100H

DO_START:
        mov     bx,OFFSET BOOTBUF
        mov     al,16                           ;16 sectors
        mov     ah,2                            ;write
        mov     dx,80H                          ;head 0, drive 80H
        mov     cx,1H                           ;track 0, sector 1
        int     13H

        mov     ax,4C00H                        ;and do a DOS keep
        int     21H

BOOTBUF DB      8192 dup (0AAH)
COMSEG  ENDS

        END     DO_START

