

;Stealth Test 5C
;Write drive C forbidden sectors from RAM - 2 sector write

COMSEG  SEGMENT PARA
        ASSUME  CS:COMSEG,DS:COMSEG,ES:COMSEG,SS:COMSEG

        ORG     100H

DO_START:
        mov     bx,OFFSET BOOTBUF
        mov     al,2                            ;2 sectors
        mov     ah,3                            ;write
        mov     dx,80H                          ;head 0, drive 80H
        mov     cx,2H                           ;track 0, sector 2
        int     13H

        mov     ax,4C00H                        ;and do a DOS keep
        int     21H

BOOTBUF:
        DB      1024 dup (0AAH)

COMSEG  ENDS

        END     DO_START

