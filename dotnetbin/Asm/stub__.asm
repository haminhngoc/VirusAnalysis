

;A do-nothing COM program. (12 bytes)
;The 1701 virus is attached to this.


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
