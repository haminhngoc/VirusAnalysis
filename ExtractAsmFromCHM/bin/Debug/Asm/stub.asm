

;A do-nothing COM program
;The 1260 virus is attached to this


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
        MOV     AX,4C00H
        INT     21H

        END     START


