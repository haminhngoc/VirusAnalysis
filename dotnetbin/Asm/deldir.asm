

Page 60,132

Comment |
******************************************************************

File:       DELDIR.ASM
Author:     Allen L. Wyatt
Date:       6/18/92
Assembler:  MASM 6.0

Purpose:    Delete specified directory and all subdirectories to it

Format:     DELDIR [path]

******************************************************************|

            .MODEL  small
            .STACK                      ;Default 1Kb stack is OK
            .DATA

FileCount   DW      0
DirCount    DW      0

CurDrive    DB      'C:'
CurDir      DB      '\', 65 DUP(0)
WorkDrive   DB      'C:'
WorkOrig    DB      '\', 65 DUP(0)
WorkDir     DB      '\', 128 DUP(0)

MaxDrives   DB      0
Wild        DB      '*.*',0
Parent      DB      '..',0

DriveEMsg   DB      'Invalid drive',13,10,0
DirEMsg     DB      'Invalid directory',13,10,0
Sure        DB      'Delete everything on the '
SureDrive   DB      '?: drive (y/n)? ',0
RemDir      DB      'Removing ',0
DirMsgS     DB      ' directory was removed',13,10,0
DirMsgP     DB      ' directories were removed',13,10,0
FileMsgS    DB      ' file was deleted',13,10,0
FileMsgP    DB      ' files were deleted',13,10,0
DoneMsg     DB      'Program finished'
CRLF        DB      13,10,0

            .CODE
            .STARTUP
DelDir      PROC

; The following memory allocation code works because it is known that MASM
; sets DS and SS to the same segment address in the startup code.  Also, ES
; is set to the PSP for the program upon entry.

            MOV     BX,DS               ;Point to start of data segment
            MOV     AX,ES               ;Point to start of PSP
            SUB     BX,AX               ;Number of segments for code & data
            MOV     AX,SP               ;SP is point
		 	MOV		CL,4
			SHR		AX,CL
			ADD		BX,AX
			MOV		AH,4AH
			INT		21H

;    get the current drive and directory

            MOV     AH,19h              ;?Get current drive
            INT     21h
            MOV     DL,AL               ;Move drive for next operation
            ADD     AL,'A'              ;?Make it ASCII
            MOV     CurDrive,AL         ;Store it for later
            MOV     WorkDrive,AL
            MOV     SureDrive,AL

            MOV     AH,0Eh              ;Select default drive
            INT     21h
            MOV     MaxDrives,AL        ;Store number of drives

            MOV     DL,0                ;Use current drive
            MOV     AH,47h              ;Get current directory
            MOV     SI,OFFSET CurDir    ;Point to directory buffer
            INC     SI                  ;Point past leading backslash
            INT     21h
            MOV     DL,0                ;Use current drive
            MOV     AH,47h              ;Get current directory
            MOV     SI,OFFSET WorkDir   ;Point to working directory buffer
            INC     SI                  ;Point past leading backslash
            INT     21h

            CALL    Parse               ;Go parse command tail file name

            MOV     DL,WorkDrive
            CMP     DL,CurDrive         ;Still working on same drive
            JE      DriveOK             ;Yes, so continue
            SUB     DL,'A'              ;Make drive zero-based
            CMP     DL,MaxDrives        ;Out of range?
            JA      DriveErr            ;Yes, exit with error
            MOV     AH,0Eh              ;No, set current drive
            INT     21h

            MOV     DL,0                ;Use current drive (new drive)
            MOV     AH,47h              ;Get directory on new drive
            MOV     SI,OFFSET WorkOrig  ;Point to directory buffer
            INC     SI                  ;Point past leading backslash
            INT     21h

DriveOK:    MOV     AL,WorkDir
            CMP     AL,0                ;Any directory to use?
            JE      GetDir              ;No, so get where we are
            MOV     DX,OFFSET WorkDir   ;Point to new directory
            MOV     AH,3Bh              ;Set directory to DS:DX
            INT     21h
            JC      DirBad              ;Bad move

; Even though the directory was possibly just set, it is important to
; get the directory again, because the command line could have used
; relative directory addressing.  Getting the directory one more time
; ensures that absolute directory addressing is used.

GetDir:     MOV     DL,0                ;Use current drive
            MOV     WorkDir,'\'
            MOV     SI,OFFSET WorkDir
            INC     SI                  ;Point past leading backslash
            MOV     AH,47h              ;Get current directory
            INT     21h
            JMP     DirOK

DirBad:     MOV     SI,OFFSET DirEMsg
            JMP     ErrMsg
DriveErr:   MOV     SI,OFFSET DriveEMsg
ErrMsg:     CALL    PrtString           ;Display the string at DS:SI
            JMP     Done

DirOK:      CMP     WorkDir+1,0         ;At root directory?
            JNE     Start
            MOV     SI,OFFSET Sure
            CALL    PrtString
InLoop:     MOV     AH,0                ;Read keyboard character
            INT     16h
            OR      AL,20h              ;Convert to lowercase
            CMP     AL,'n'              ;Was it no?
            JE      GoodKey
            CMP     AL,'y'              ;Was it yes?
            JNE     InLoop
GoodKey:    MOV     SI,OFFSET CRLF
            CALL    PrtString
            CMP     AL,'n'              ;Was it no?
            JE      Done                ;Yes, so exit program

Start:      CALL    DoDir               ;Go erase this directory
            CMP     WorkDir+1,0         ;At root directory?
            JE      Stats               ;Yes, so don't try to remove

            MOV     DX,OFFSET Parent    ;Point to '..'
            MOV     AH,3Bh              ;Set directory to DS:DX
            INT     21h

            MOV     SI,OFFSET RemDir
            CALL    PrtString           ;Display the string at DS:SI
            MOV     SI,OFFSET WorkDir
            CALL    PrtString           ;Display the string at DS:SI
            MOV     SI,OFFSET CRLF
            CALL    PrtString

            MOV     DX,OFFSET WorkDir   ;Point to original directory
            MOV     AH,3Ah              ;Remove directory at DS:DX
            INT     21h
            JC      Stats               ;Couldn't remove directory
            INC     DirCount

Stats:      MOV     AX,DirCount
            CMP     AX,0                ;Any directories deleted?
            JE      Stats2              ;No, continue
            CALL    PrtDec
            MOV     SI,OFFSET DirMsgS   ;Point to singular message
            CMP     AX,1                ;Singular directories?
            JE      Stats1              ;Yes, so print singular message
            MOV     SI,OFFSET DirMsgP   ;Point to plural message
Stats1:     CALL    PrtString           ;Display the string at DS:SI

Stats2:     MOV     AX,FileCount
            CMP     AX,0                ;Any files deleted?
            JE      Done                ;No, so finish up
            CALL    PrtDec
            MOV     SI,OFFSET FileMsgS  ;Point to singular message
            CMP     AX,1                ;Singular files?
            JE      Stats3              ;Yes, so print singular message
            MOV     SI,OFFSET FileMsgP  ;Point to plural message
Stats3:     CALL    PrtString           ;Display the string at DS:SI

Done:       MOV     DL,CurDrive         ;Move drive for next operation
            CMP     DL,WorkDrive        ;Same as original?
            JE      Done1               ;Yes, so continue
            MOV     DX,OFFSET WorkOrig  ;Original directory on target drive
            MOV     AH,3Bh              ;Set current directory (if possible)
            INT     21h
            MOV     DL,CurDrive         ;Get calling drive
            SUB     DL,'A'              ;Make it zero-based
            MOV     AH,0Eh              ;Set current drive
            INT     21h

Done1:      MOV     DX,OFFSET CurDir    ;Point to new directory
            MOV     AH,3Bh              ;Set current directory
            INT     21h
            MOV     SI,OFFSET DoneMsg   ;Final message
            CALL    PrtString
            .EXIT
DelDir      ENDP


Comment |
=====================================================================
   The following routine does the following:
      1. Set up a memory block and header information (see SetHdr)
      2. Deletes files in current directory one at a time
      3. Recurrsively calls DoDir when new subdirectories encountered
      4. Reset DTA to original area and releases memory block
      5. Returns to caller
=====================================================================|

DoDir       PROC    ;USES AX BX CX DX SI DI ES
            CALL    SetHdr              ;Allocate memory and set header info

            MOV     DX,OFFSET Wild      ;Point to *.*
            MOV     CX,16h              ;Want normal, hidden, system, and vol
            MOV     AH,4Eh              ;Search for first match
            INT     21h
            JC      NoFile              ;No file found
            JNC     FoundOne            ;Go handle file found

NextFile:   MOV     AH,4Fh              ;Search for next file
            INT     21h
            JC      NoFile              ;No file found

FoundOne:   MOV     DX,1Eh              ;ES:DX points to name in DTA
            MOV     AL,ES:[15h]         ;Get file attribute
            CMP     AL,10h              ;Is it a directory?
            JNE     FoundFile           ;No, so go handle

            MOV     AL,ES:[1Eh]         ;Get first character of directory
            CMP     AL,'.'              ;Is it . or ..?
            JE      NextFile            ;Yes, so ignore
            CALL    DirOut              ;Go delete an entire directory
            JMP     NextFile            ;Go search for next entry

FoundFile:  CALL    FileOut             ;Go delete the file that was found
            JMP     NextFile            ;Go search for next entry

; By this point, there are no more files left.  Switch back to oòiginal
; DTA and release memory block requested by SetHdr.

NoFile:     PUSH    DS
            MOV     SI,128              ;Point to old DTA address
            MOV     AX,ES:[SI]
            INC     SI
            INC     SI
            MOV     DX,ES:[SI]          ;Get stored offset
            MOV     DS,AX
            MOV     AH,1Ah              ;Set DTA address
            INT     21h
            POP     DS

            MOV     AH,49h              ;Release memory block at ES
            INT     21h

DDDone:     RET
DoDir       ENDP


Comment |
=====================================================================
  The following routine is used by DoDir to set up the new DTA and header
  area for this iteration of the deletion process.  On exit, ES points to
  the segment of the memory area.  All other registers remain unchanged.

  Memory block structure:
    Start   Len     Use
      0     128     DTA for new directory work
    128       2     Segment pointer for old DTA
    130       2     Offset pointer for old DTA
    132      12     Unused area
=====================================================================|

SetHdr      PROC    ;USES AX BX CX DI SI DS
            MOV     AH,48h              ;Allocate memory
            MOV     BX,09h              ;Requesting 144 bytes
            INT     21h
            MOV     ES,AX               ;Point to memory block for later use
            MOV     DS,AX               ;Point for current use

            MOV     AL,0                ;Zero out the newly acquired buffer
            MOV     DI,0
            CLD                         ;Make sure going in proper direction
            MOV     CX,144
            REP     STOSB

            PUSH    ES                  ;Store temporarily
            MOV     AH,2Fh              ;Get DTA address
            INT     21h
            MOV     SI,128              ;Point to address area in buffer
            MOV     AX,ES
            MOV     [SI],AX             ;Store segment of DTA
            INC     SI
            INC     SI
            MOV     [SI],BX             ;Store offset of DTA
            POP     ES                  ;Get back old ES

            MOV     DX,0                ;DS:DX points to new DTA
            MOV     AH,1Ah              ;Set DTA address
            INT     21h
            RET
SetHdr      ENDP

; Delete file pointed to by ES:DX, then increment counter

FileOut     PROC    ;USES AX CX DS
            PUSH    DS
            PUSH    ES
            POP     DS
            MOV     AH,43h              ;Set file attributes of file at DS:DX
            MOV     AL,01h
            MOV     CX,0                ;No attributes
            INT     21h
            MOV     AH,41h              ;Delete file at DS:DX
            INT     21h
            POP     DS                  ;Reset DS
            JC      FO9                 ;File was not deleted
            INC     FileCount
FO9:        RET
FileOut     ENDP

; Delete the directory pointed to by ES:DX, then increment counter

DirOut      PROC    ;USES AX BX SI DS
            PUSH    DS                  ;Store it
            PUSH    ES
            POP     DS
            MOV     AH,3Bh              ;Set directory to DS:DX
            INT     21h
            POP     DS
            CALL    DoDir               ;Recurrsive call for new dir
            MOV     DX,OFFSET Parent    ;Point to '..'
            MOV     AH,3Bh              ;Set directory to DS:DX
            INT     21h

            MOV     SI,OFFSET RemDir
            CALL    PrtString           ;Display the string at DS:SI
            MOV     AH,2Fh              ;Get DTA address into ES:BX
            INT     21h
            ADD     BX,1Eh              ;Offset to file name (directory)
            PUSH    DS                  ;Store DS temporarily
            PUSH    ES
            POP     DS
            MOV     SI,BX
            CALL    PrtString           ;Display the string at DS:SI
            MOV     DX,BX
            MOV     AH,3Ah              ;Remove directory at DS:DX
            INT     21h
            POP     DS
            JC      DO9                 ;Directory not removed
            INC     DirCount
DO9:        MOV     SI,OFFSET CRLF
            CALL    PrtString
            RET
DirOut      ENDP

; The following routine prints the value in AX as a decimal number

PrtDec      PROC    ;USES AX CX DX
            MOV     CX,0FFFFh           ;Ending flag
            PUSH    CX
            MOV     CX,10
PD1:        MOV     DX,0
            DIV     CX                  ;Divide by 10
            ADD     DL,30h              ;Convert to ASCII
            PUSH    DX                  ;Store remainder
            CMP     AX,0                ;Are we done?
            JNE     PD1                 ;No, so continue

PD2:        POP     DX                  ;Character is now in DL
            CMP     DX,0FFFFh           ;Is it the ending flag?
            JE      PD3                 ;Yes, so continue
            MOV     AH,02h              ;Output a character
            INT     21h
            JMP     PD2                 ;Keep doing it

PD3:        RET
PrtDec      ENDP

; The following routine prints the ASCIIZ string pointed to by DS:SI

PrtString   PROC    ;USES AX DX SI
PS1:        MOV     DL,[SI]             ;Get character
            INC     SI                  ;Point to next one
            CMP     DL,0                ;End of string?
            JE      PS2                 ;Yes, so exit
            MOV     AH,02h              ;Output a character
            INT     21h
            JMP     PS1                 ;Keep doing it
PS2:        RET
PrtString   ENDP

; Parses a command line parameter into the file name work area

Parse       PROC    ;USES AX CX SI DI ES DS
            PUSH    ES              ;Swap ES and DS
            PUSH    DS
            POP     ES
            POP     DS
            MOV     SI,80h
            MOV     CL,[SI]         ;Get command tail length
            MOV     CH,0
            JCXZ    PDone           ;Nothing there to parse
            INC     SI              ;Point to first character of command tail
            MOV     DI,OFFSET ES:WorkDir
P1:         LODSB
            CMP     AL,' '          ;Was it a space?
            JE      P4              ;Yes, so skip it
            CMP     AL,':'          ;Was it a drive designator?
            JNE     P3              ;No, so continue
            DEC     SI              ;Point to character before colon
            DEC     SI
            LODSB
            CALL    ToUC            ;Convert to uppercase
            INC     SI              ;Point past the colon
            MOV     ES:WorkDrive,AL
            MOV     ES:SureDrive,AL ;Store it for message
            MOV     DI,OFFSET ES:WorkDir ;Begin path again
            JMP     P4
P3:         CALL    ToUC            ;Convert to uppercase
            STOSB                   ;Store a byte
P4:         LOOP    P1              ;Keep going to the end
            MOV     AL,0
            STOSB                   ;Make sure NUL at end of path
PDone:      RET
Parse       ENDP

; Converts the character in AL to uppercase.  All other registers unchanged.

ToUC        PROC
            CMP     AL,'a'          ;Lowercase?
            JB      T9
            CMP     AL,'z'
            JA      T9
            SUB     AL,20h          ;Convert to uppercase
T9:         RET
ToUC        ENDP

            END

