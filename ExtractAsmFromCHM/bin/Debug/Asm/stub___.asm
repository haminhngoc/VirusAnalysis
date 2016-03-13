

;A do-nothing COM program
;The 4096 virus is attached to this.


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
