

;----------------------------------------------------------------------------
;               The Self-Reproducing Automaton One
;----------------------------------------------------------------------------
;This program is a basic self-reproducing automaton that is not a virus. It
;just copies itself into another COM file (the offspring, O_SPRING.COM).
;It can only reproduce once, and the offspring just overwrites itself if
;it is executed by the user.

;-----------------------------------------------------------------------------
;This is the main code segment of the program, which is a COM file.

MAIN    SEGMENT BYTE
        ASSUME  CS:MAIN,DS:MAIN,SS:MAIN

        ORG     100H                    ;start location for a COM file

START:
        mov     dx,OFFSET COMFILE               ;ds:dx points to the name of the file
        mov     ah,5BH                          ;DOS create function
        xor     cx,cx                           ;use standard file attributes
        int     21H                             ;and go create it
        jc      EXIT                            ;error opening file, so exit
        push    ax                              ;otherwise, save the file handle on the stack

        mov     cx,OFFSET FINAL - 100H          ;cx=number of bytes to write
        mov     dx,100H                         ;ds:dx = buffer in memory to write from
        mov     bx,ax                           ;put the file handle in bx
        mov     ah,40H                          ;DOS write function
        int     21H

        pop     bx                              ;get the file handle again
        mov     ah,3EH                          ;and close file
        int     21H                             ;using DOS
EXIT:
        int     20H                             ;exit program using DOS


;This is where the name of the COM file which is created by this program gets
;stored.

COMFILE DB      'O_SPRING.COM',0

FINAL:                                          ;label for last byte of code to be kept in the copy
                                                ;of the automaton
MAIN    ENDS


        END START

