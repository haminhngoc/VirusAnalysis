

COMMENT @

          This is the assembly language listing for SOUND.COM, a resident
          program producing scratching sounds at regular intervals.
          The interval between two sounds is preset to 5 minutes and can
          be adjusted within a range of 1 to 60 minutes.
          Just enter SOUND /?? from the command line, where '??' means
          a number between 1 and 60.

          SOUND (C)Copyright 1988 by Joachim Schneider, Zell am See.
          All rights reserved.
@

_TEXT          SEGMENT BYTE PUBLIC 'CODE'
               ASSUME CS:_TEXT, DS:_TEXT

GENSOUND       PROC  FAR
               JMP   INST              ; jump to installation routine

RNUM_TABLE     DW    2129, 715, 300, 289, 4840, 302, 265, 298, 581, 198, 205
               DW    738, 244, 228, 314, 373, 820, 243, 4650, 360, 428, 486
               DW    384, 554, 694, 989, 528, 6361, 388, 258, 213, 314, 208
               DW    299, 409, 909, 443, 427, 558, 230, 256, 277, 233, 324
               DW    255, 202, 672, 364, 818, 239, 200, 279, 200, 240, 780
               DW    1146, 237, 372, 516, 198, 332, 395, 274, 750, 2386, 645
               DW    355, 198, 2004, 392, 933, 671, 427, 298, 201, 959, 201
               DW    590, 950, 252, 408, 1896, 1046, 1809, 259, 394, 862, 827
               DW    310, 1769, 303, 897, 211, 402, 262, 1429, 448, 1001, 225
               DW    4864, 200

LPCT           DB    0                 ; subsidiary counter for sound timing
COUNT          DW    0                 ; clock tick count
VSAVE          DD    0                 ; save area for interrupt vector
D_COUNT        DW    5460              ; alarm tick count

COMMENT * Put (1193182/freq) in BX
          put time units in CX, 1 unit is approx. 2.6 msec *

GSXX:          PUSHF
               CALL  CS:[VSAVE]        ; call former interrupt handler
               STI
               PUSH  DS
               PUSH  CS
               POP   DS                ; set DS equal to CS
               INC   COUNT             ; bump tick count
               PUSH  AX
               MOV   AX,COUNT          ; load current count value
               CMP   AX,D_COUNT        ; >= destination count ?
               POP   AX
               JB    END_IT            ; no, return from interrupt
               MOV   COUNT,0           ; re-initialize counter
               PUSH  SI
               PUSH  CX
               PUSH  AX                   ; save registers required
               MOV   SI,OFFSET RNUM_TABLE ; load frequency table offset
               IN    AL,97
               OR    AL,3
               OUT   97,AL             ; turn on speaker
S01:           MOV   AL,182
               OUT   67,AL             ; set timer to receive new count
               LODSW                   ; load next frequency value from table
               OUT   66,AL             ; set frequency count low byte
               MOV   AL,AH
               OUT   66,AL             ; set frequency count high byte
               MOV   CX,2
S03:           INC   LPCT              ; wait time unit
               JNZ   S03
               LOOP  S03               ; and repeat that
               CMP   SI,OFFSET LPCT    ; all frequencies read ?
               JB    S01               ; no, do next one
               IN    AL,97
               AND   AL,252
               OUT   97,AL             ; turn speaker off
               POP   AX
               POP   CX
               POP   SI                ; restore program registers

END_IT:        POP   DS                ; restore data segment
               IRET

         DB    'SOUND (C)Copyright 1988 by Joachim Schneider, Zell am See.'
         DB    'All rights reserved.'

INST:          CALL  EVALSW            ; evaluate runtime switch if present
               JC    INST01            ; invalid switch - quit
               MOV   AX,DS
               ADD   AX,10H
               MOV   DS,AX             ; adjust DS to exclude PSP size
               MOV   AX,351CH
               INT   21H                 ; get current INT 1Ch vector
               MOV   WORD PTR VSAVE,BX   ; save offset
               MOV   WORD PTR VSAVE+2,ES ; and segment
               MOV   DX,OFFSET GSXX      ; load new interrupt routine offset
               MOV   AX,251CH
               INT   21H               ; set new interrupt vector
               MOV   AX,3100H
               MOV   DX,OFFSET INST+100H ; load offset where resident code ends
               MOV   CL,4
               SHR   DX,CL             ; convert from bytes to paragraphs
               INC   DX                ; round value
               INT   21H               ; terminate-stay-resident
INST01:        MOV   AX,4C00H
               INT   21H               ; normal terminate in case of error
               GENSOUND ENDP

COMMENT * STR_TO_INT converts the ASCIIZ string in decimal notation
          pointed to by DS:SI to an unsigned binary 16-bit-integer.
          If an invalid digit is encountered or the value is larger
          than 0FFFFH the CY flag will be set. On return, AX contains
          the integer value. *

STR_TO_INT     PROC  NEAR
               PUSH  BX
               PUSH  CX
               PUSH  DX
               XOR   AX,AX             ; clear AX
               MOV   BH,AH
               MOV   CX,10             ; factor for multiplication
STRTI05:       LODSB                   ; load character
               OR    AL,AL             ; end-of-string ?
               JZ    STRTI01           ; yes, nothing to convert
               CMP   AL,20H            ; blank ?
               JZ    STRTI05           ; yes, skip
               CMP   AL,'0'            ; check for digit
               JB    STRTI04           ; error: can't be digit
               CMP   AL,'9'
               JA    STRTI04           ; error: can't be digit
               SUB   AL,'0'            ; convert digit to binary value
STRTI03:       MOV   BL,[SI]           ; load next character
               INC   SI                ; bump index
               OR    BL,BL             ; end-of-string ?
               JZ    STRTI01           ; yes, end conversion
               CMP   BL,'0'            ; does BL contain a digit ?
               JB    STRTI04           ; no, flag error
               CMP   BL,'9'
               JA    STRTI04           ; error - no digit
               SUB   BL,'0'            ; convert BL to binary value
               MUL   CX                ; shift current value by 10
               JC    STRTI02           ; exit if overflow
               ADD   AX,BX             ; add current digit
               JC    STRTI02           ; exit if overflow
               JMP   SHORT STRTI03     ; go read next character
STRTI04:       STC                     ; set CF to 1, i.e. flag an error
               JMP   SHORT STRTI02     ; and exit
STRTI01:       CLC                     ; no error - clear CF
STRTI02:       POP   DX
               POP   CX
               POP   BX                ; restore registers
               RET
               STR_TO_INT ENDP

COMMENT * EVALSW will interpret the given runtime switches if available.
          On return, the CY flag will be set if there was an invalid parm,
          otherwise CF is clear. *

EVALSW         PROC NEAR
               MOV   CL,DS:80H         ; get length of command tail
               XOR   CH,CH
               JCXZ  EW01              ; nothing there, exit
               MOV   DI,81H            ; point DI to 1st character of tail
               CLD
EW05:          MOV   AL,'/'
               REPNZ SCASB             ; scan command tail for slash
               JCXZ  EW01              ; none found - quit
               MOV   SI,DI             ; copy string pointer
               CALL  STR_TO_INT        ; convert string to binary integer
               OR    AX,AX             ; invalid or 0 ?
               JZ    EW04              ; yes, flag error
               CMP   AX,60             ; larger than 60 ?
               JA    EW04              ; yes, flag error
               MOV   BX,1092           ; convert minute count ...
               MUL   BX                ; ... to clock tick count
               MOV   D_COUNT+100H,AX   ; and save destination count
               JMP   SHORT EW01
EW04:          MOV   DX,OFFSET ILLPARM+100H
               MOV   AH,9
               INT   21H               ; display error message
               STC                     ; and flag error
               JMP   SHORT EW08
EW01:          CLC                     ; no error
EW08:          RET
               EVALSW ENDP

ILLPARM        DB    'Error: Minute count must be in range 1 to 60.',7,'$'

               _TEXT  ENDS
               END

