

;Interrupt 13H diverter

COMSEG  SEGMENT PARA
        ASSUME  CS:COMSEG,DS:COMSEG,ES:COMSEG,SS:COMSEG

        ORG     100H

DO_START:
        mov     bx,OFFSET BOOTBUF			
        mov     al,1				;1 sector
        mov     ah,2                            ;read
        mov     dx,0H				;head 0, drive 0
        mov     cx,201H				;track 2, sector 1
        int     13H

        mov     ax,4C00H                        ;and do a DOS terminate
        int     21H

BOOTBUF	DB	200H dup (0ABH)

COMSEG  ENDS

        END     DO_START

