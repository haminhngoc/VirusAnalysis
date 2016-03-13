



;       GUNS N' ROSES Polymorphic Engine --- DEMO
;       This program can generates 50 polymorphic programs.
;       (C) Copyright 1994 Written by Slash Wu. All Rights Reserved.
;       Made In Taiwan.

;       ºj»Pª´ºÀ¦h§Î¤ÞÀº --- ¥Ü½dµ{¦¡
;       ³o­Óµ{¦¡¯à°÷²£¥Í 50 ­Ó¦h§Îµ{¦¡¡C
;       ª©Åv©Ò¦³, Â½¦L¥²¨s 1994 §d«T½n©Ò¼g¡C «O¯d©Ò¦³ª©Åv¡C
;       ¦b¥xÆW»s³y¡C


        .MODEL  TINY

        .CODE

        ORG     100H

        EXTRN   GPE:NEAR, GPE_END:NEAR  ;¨Ï¥Î®É, ¤@©w­n«Å§i GPE ¬°¥~³¡¼Ò²Õ¡C


BEGIN:
        MOV     DX,OFFSET GEN_MSG
        MOV     AH,9
        INT     21H

        MOV     CX,50
GEN:
        PUSH    CX

        MOV     DX,OFFSET FILENAME
        PUSH    CS
        POP     DS
        XOR     CX,CX
        MOV     AH,3CH
        INT     21H

        PUSH    AX

        MOV     DX,OFFSET PROG  ;¨Ï¥Î®É, DS:DX ­n«ü¦V±ý¦¨¬°¦h§Îµ{¦¡ªº¶}ÀY¡C
        MOV     CX,OFFSET PROG_END - OFFSET PROG;¨Ï¥Î®É, CX ¼È¦s¾¹­n«ü©w±ý
                                                ;¦¨¬°¦h§Îªºµ{¦¡ªø«×¡C
        MOV     BX,100H ;¨Ï¥Î®É, BX ¼È¦s¾¹­n«ü©w¦h§Îµ{¦¡°õ¦æ®Éªº°¾²¾¦ì§},
                        ;¥ç§Y IP ­È¡C
        PUSH    SS
        POP     AX
        ADD     AX,1000H
        MOV     ES,AX   ;¨Ï¥Î®É, ES ¸`°Ï¼È¦s¾¹­n«ü©w¥Î¨ÓÂ\ GPE ©Ò²£¥Í¥Xªº
                        ;¦h§Îµ{¦¡, ¥ç§Y¡y¦h§Î¸Ñ½Xµ{¦¡¡z¡Ï¡y¤w½s½Xµ{¦¡¡z,
                        ;¥Ñ ES:0 ¶}©l¦s©ñ¡C
                        ;¦¹³B¥Ñ©óµ§ªÌ°½Ãi, ª½±µ¨Ï¥Îµ{¦¡¤U¤èªº°O¾ÐÅé, ½Ð¤j
                        ;®a¨Ï¥Î¥¿½Tªº¤èªk¨Ó°t¸m°O¾ÐÅé¡C

        CALL    GPE     ;OK! ¤@¤Á´N§Ç«á, ´N¥i¥H¶}©l©I¥s¡yºj»Pª´ºÀ¦h§Î¤ÞÀº¡z
                        ;°Õ!
                        ;¡yºj»Pª´ºÀ¦h§Î¤ÞÀº¡zªð¦^«á, DS:DX «ü¦V²£¥Í¥X¨Óªº
                        ;¦h§Îµ{¦¡, ¥ç§Y¡y¦h§Î¸Ñ½Xµ{¦¡¡z¡Ï¡y¤w½s½Xµ{¦¡¡z,
                        ;CX ¼È¦s¾¹°O¿ýµÛ©Ò²£¥Í¥X¨Óªº¦h§Îµ{¦¡ªø«×, ¥ç§Y¡y¦h
                        ;§Î¸Ñ½Xµ{¦¡¡z¡Ï¡y¤w½s½Xµ{¦¡¡zªºªø«×¡C

        POP     BX
        MOV     AH,40H
        INT     21H

        MOV     AH,3EH
        INT     21H

        MOV     BX,OFFSET FILENAME
        INC     BYTE PTR CS:BX+7
        CMP     BYTE PTR CS:BX+7,'9'
        JBE     L0
        MOV     BYTE PTR CS:BX+7,'0'
        INC     BYTE PTR CS:BX+6
L0:
        POP     CX
        LOOP    GEN

        INT     20H

FILENAME DB     '00000000.COM',0

GEN_MSG DB      'Generating 50 polymorphic programs... $'

PROG:
        MOV     DX,OFFSET MSG - OFFSET PROG + 100H
        MOV     AH,9
        INT     21H
        INT     20H
MSG     DB      'I am a polymorphic program.$'
PROG_END:


        END     BEGIN



