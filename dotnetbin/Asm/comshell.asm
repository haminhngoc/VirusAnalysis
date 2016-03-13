

;A do-nothing COM program for infecting with viruses


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
