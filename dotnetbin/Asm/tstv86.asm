




        .MODEL  TINY

        .code

                ORG     100H

START:
                PUSHF                           ;Push flags on Stack
                POP     AX
                OR      AX,3000H
                mov     bx,ax
                PUSH    AX
                POPF                            ;Pop flags off Stack
                PUSHF                           ;Push flags on Stack
                POP     AX
                cmp     ax,bx
                jnz     VMODE
                AND     AX,0CFFFH
                mov     bx,ax
                PUSH    AX
                POPF                            ;Pop flags off Stack
                PUSHF                           ;Push flags on Stack
                POP     AX
                cmp     ax,bx
                jnz     VMODE
                mov     dx,OFFSET REAL_MODE
                mov     ah,9
                int     21H
                MOV     AX,4C00H
                INT     21H

VMODE:
                mov     dx,OFFSET VIRT_MODE
                mov     ah,9
                int     21H
                mov     ax,4C00H
                int     21H

REAL_MODE       DB      'Processor in REAL mode.$'
VIRT_MODE       DB      'Processor in V86 mode.$'


                END     START


