

;A do-nothing COM program
;The 1452 virus is attached to this program.

.MODEL  TINY

.CODE

        ORG     100H

START:  NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        NOP
        jmp     START2
        db      500H dup (0)

START2:
        MOV     AX,4C00H
        INT     21H

        END     START


