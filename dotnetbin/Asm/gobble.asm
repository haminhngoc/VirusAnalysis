

COMMENT @

          This is the assembly language listing for GOBBLE.COM, another
          resident nuisance. GOBBLE produces a simple PacMan (*) image
          on the screen at regular intervals. The PacMan displayed
          then gobbles up four lines of the current screen image, moving
          from the right to the left edge of the screen and buzzing
          merrily. The interval between two PacMan appearances is preset
          to 5 minutes and can be adjusted within a range of 1 to 60 minutes.
          Just enter GOBBLE /?? from the command line, where '??' means
          a number between 1 and 60.

          GOBBLE (C)Copyright 1988 by Joachim Schneider, Zell am See.
          All rights reserved.

          (*) PacMan is a Registered Trademark of Atari Corp.
@
          
_TEXT          SEGMENT BYTE PUBLIC 'CODE'
               ASSUME CS:_TEXT, DS:_TEXT

MAIN           PROC  FAR
               JMP   INSTALL           ; jump to install procedure
               MAIN  ENDP

P_BLOCK        DB 219,248,223,248,219,  7,219,  7,219,7,220,7, 32,7,32,7,32,7
               DB 219,135,219,135,219,135,219,135,219,7,219,7,219,7,32,7,32,7
               DB 219,248,220,248,219,  7,219,  7,219,7,223,7, 32,7,32,7,32,7

LPCT           DB    0,0               ; auxiliary counters for sound timing
COUNT          DW    0                 ; clock tick count
D_COUNT        DW    5460              ; alarm tick count
VSAVE          DD    0                 ; save area for old interrupt vector
SCNT           DW    0                 ; holds current frequency
SW_1           DB    0                 ; sound synchronization aux counter
SCRSEG         DW    0B000H            ; regen buffer base address

GSXX:          PUSHF
               CALL  CS:[VSAVE]        ; call old interrupt handler
               STI
               PUSH  DS
               PUSH  CS
               POP   DS                ; set DS equal to CS
               INC   COUNT             ; bump clock tick count
               PUSH  AX
               MOV   AX,COUNT          ; load current count value
               CMP   AX,D_COUNT        ; reached destination value ?
               POP   AX
               JA    P10               ; yes, set PacMan in motion
               JMP   END_IT            ; else do nothing further
P10:           MOV   COUNT,0           ; re-initialize tick count
               PUSH  DI
               PUSH  SI
               PUSH  DX
               PUSH  CX                ; save caller's registers
               PUSH  BX
               PUSH  AX
               PUSH  ES
               INT   11H               ; get BIOS equipment list
               AND   AL,30H            ; isolate initial video mode bits
               CMP   AL,30H            ; 80-column mono ?
               JNE   S01               ; no, for PC/XT/AT suppose 80-col color
               MOV   AX,0B000H         ; load mono regen buffer address
               JMP   S02
S01:           MOV   AX,0B800H         ; load color regen buffer address
S02:           MOV   ES,AX             ; point ES to regen buffer
               MOV   CX,71             ; # of columns PacMan will move
               MOV   SW_1,0            ; initialize sound timing control
G01:           PUSH  CX
               MOV   BH,8              ; upper image row in BH
               MOV   AL,0A0H           ; load # of bytes for 1 row
               MUL   BH                ; times the line number
               MOV   DI,AX
               SHL   CL,1
               ADD   DI,CX             ; upper left edge address in DI
               MOV   SI,OFFSET P_BLOCK ; set index to start of image
               INC   SW_1              ; bump sound control counter
               CMP   SW_1,2            ; sound effect required ?
               JNZ   G12               ; no, skip sound generation
               MOV   SW_1,0            ; re-initialize sound control
               MOV   CX,20             ; load loop counter
               MOV   SCNT,2000         ; load initial frequency count
G02:           PUSH  CX
               MOV   CX,3
               MOV   BX,SCNT
               CALL  GENSOUND          ; activate speaker
               SUB   SCNT,60           ; increase frequency
               POP   CX
               LOOP  G02               ; play next tone
               JMP   SHORT G11         ; continue animation
G12:           MOV   CX,10000
P03:           LOOP  P03               ; timing loop
G11:           XOR   CX,CX             ; initialize character counters
               MOV   DX,309H           ; load image size; DH=rows, DL=columns
P01:           PUSH  DI                ; saved regen buffer index
P02:           MOVSW                   ; move one character/attribute
               INC   CL                ; bump column count
               CMP   CL,DL             ; one line finished ?
               JNE   P02               ; no, do next column
               INC   CH                ; yes, bump row count
               XOR   CL,CL             ; reset column count
               POP   DI                ; restore regen buffer index
               ADD   DI,0A0H           ; point DI to beginning of next line
               CMP   CH,DH             ; all lines printed ?
               JNE   P01               ; no, continue w/ next line
               POP   CX                ; reload PacMan motion counter
               SUB   CX,2
               JNS   G01               ; repeat until column <= 0="" mov="" bx,0800h="" ;="" line/column="" position="" mov="" ax,0a0h="" mul="" bh="" mov="" di,ax="" shl="" bl,1="" xor="" bh,bh="" add="" di,bx="" ;="" index="" into="" regen="" buffer="" mov="" cx,240="" ;="" load="" counter="" mov="" ax,720h="" ;="" load="" character/attribute="" rep="" stosw="" ;="" erase="" 4="" lines="" where="" pacman="" lives="" pop="" es="" ;="" restore="" saved="" registers="" pop="" ax="" pop="" bx="" pop="" cx="" pop="" dx="" pop="" si="" pop="" di="" end_it:="" pop="" ds="" iret="" comment="" *="" put="" (1193182/freq)="" in="" bx="" put="" time="" units="" in="" cx,="" 1="" unit="" is="" approx.="" 2.6="" millisecs="" *="" gensound="" proc="" near="" mov="" al,182="" out="" 67,al="" ;="" prepare="" timer="" for="" new="" count="" mov="" ax,bx="" out="" 66,al="" ;="" send="" count="" lsb="" mov="" al,ah="" out="" 66,al="" ;="" send="" count="" msb="" in="" al,97="" or="" al,3="" out="" 97,al="" ;="" turn="" on="" the="" speaker="" s03:="" inc="" lpct="" ;="" wait="" time="" unit="" jnz="" s03="" inc="" lpct+1="" loop="" s03="" ;="" ...="" wait="" a="" little="" longer="" ...="" in="" al,97="" and="" al,252="" out="" 97,al="" ;="" turn="" speaker="" off="" ret="" gensound="" endp="" db="" 'gobble="" (c)copyright="" 1988="" by="" joachim="" schneider,="" zell="" am="" see.'="" db="" 'all="" rights="" reserved.'="" install="" proc="" near="" call="" evalsw="" ;="" evaluate="" runtime="" switch="" if="" present="" jc="" inst01="" ;="" invalid="" switch="" -="" quit="" mov="" ax,ds="" add="" ax,10h="" mov="" ds,ax="" ;="" adjust="" ds="" to="" exclude="" psp="" size="" mov="" ax,351ch="" int="" 21h="" ;="" get="" current="" int="" 1ch="" vector="" mov="" word="" ptr="" vsave,bx="" ;="" save="" offset="" mov="" word="" ptr="" vsave+2,es="" ;="" and="" segment="" mov="" dx,offset="" gsxx="" ;="" load="" interrupt="" routine="" offset="" mov="" ax,251ch="" int="" 21h="" ;="" set="" new="" interrupt="" vector="" mov="" ax,3100h="" mov="" dx,offset="" install+100h="" ;="" load="" #="" of="" bytes="" occupied="" mov="" cl,4="" shr="" dx,cl="" ;="" convert="" from="" bytes="" to="" paragraphs="" inc="" dx="" ;="" round="" value="" int="" 21h="" ;="" terminate-stay-resident="" inst01:="" mov="" ax,4c00h="" int="" 21h="" ;="" normal="" terminate="" in="" case="" of="" error="" install="" endp="" comment="" *="" str_to_int="" converts="" the="" asciiz="" string="" in="" decimal="" notation="" pointed="" to="" by="" ds:si="" to="" an="" unsigned="" binary="" 16-bit-integer.="" if="" an="" invalid="" digit="" is="" encountered="" or="" the="" value="" is="" larger="" than="" 0ffffh="" the="" cy="" flag="" will="" be="" set.="" on="" return,="" ax="" contains="" the="" integer="" value.="" *="" str_to_int="" proc="" near="" push="" bx="" push="" cx="" push="" dx="" xor="" ax,ax="" ;="" clear="" ax="" mov="" bh,ah="" mov="" cx,10="" ;="" factor="" for="" multiplication="" strti05:="" lodsb="" ;="" load="" character="" or="" al,al="" ;="" end-of-string="" jz="" strti01="" ;="" yes,="" nothing="" to="" convert="" cmp="" al,20h="" ;="" blank="" jz="" strti05="" ;="" yes,="" skip="" cmp="" al,'0'="" ;="" check="" for="" digit="" jb="" strti04="" ;="" error:="" can't="" be="" digit="" cmp="" al,'9'="" ja="" strti04="" ;="" error:="" can't="" be="" digit="" sub="" al,'0'="" ;="" convert="" digit="" to="" binary="" value="" strti03:="" mov="" bl,[si]="" ;="" load="" next="" character="" inc="" si="" ;="" bump="" index="" or="" bl,bl="" ;="" end-of-string="" jz="" strti01="" ;="" yes,="" end="" conversion="" cmp="" bl,'0'="" ;="" does="" bl="" contain="" a="" digit="" jb="" strti04="" ;="" no,="" flag="" error="" cmp="" bl,'9'="" ja="" strti04="" ;="" error="" -="" no="" digit="" sub="" bl,'0'="" ;="" convert="" bl="" to="" binary="" value="" mul="" cx="" ;="" shift="" current="" value="" by="" 10="" jc="" strti02="" ;="" exit="" if="" overflow="" add="" ax,bx="" ;="" add="" current="" digit="" jc="" strti02="" ;="" exit="" if="" overflow="" jmp="" short="" strti03="" ;="" go="" read="" next="" character="" strti04:="" stc="" ;="" set="" cf="" to="" 1,="" i.e.="" flag="" an="" error="" jmp="" short="" strti02="" ;="" and="" exit="" strti01:="" clc="" ;="" no="" error="" -="" clear="" cf="" strti02:="" pop="" dx="" pop="" cx="" pop="" bx="" ;="" restore="" registers="" ret="" str_to_int="" endp="" comment="" *="" evalsw="" will="" interpret="" the="" given="" runtime="" switches="" if="" available.="" on="" return,="" the="" cy="" flag="" will="" be="" set="" if="" there="" was="" an="" invalid="" parm,="" otherwise="" cf="" is="" clear.="" *="" evalsw="" proc="" near="" mov="" cl,ds:80h="" ;="" get="" length="" of="" command="" tail="" xor="" ch,ch="" jcxz="" ew01="" ;="" nothing="" there,="" exit="" mov="" di,81h="" ;="" point="" di="" to="" 1st="" character="" of="" tail="" cld="" ew05:="" mov="" al,'/'="" repnz="" scasb="" ;="" scan="" command="" tail="" for="" slash="" jcxz="" ew01="" ;="" none="" found="" -="" quit="" mov="" si,di="" ;="" copy="" string="" pointer="" call="" str_to_int="" ;="" convert="" string="" to="" binary="" integer="" or="" ax,ax="" ;="" invalid="" or="" 0="" jz="" ew04="" ;="" yes,="" flag="" error="" cmp="" ax,60="" ;="" larger="" than="" 60="" ja="" ew04="" ;="" yes,="" flag="" error="" mov="" bx,1092="" ;="" convert="" minute="" count="" ...="" mul="" bx="" ;="" ...="" to="" clock="" tick="" count="" mov="" d_count+100h,ax="" ;="" and="" save="" destination="" count="" jmp="" short="" ew01="" ew04:="" mov="" dx,offset="" illparm+100h="" mov="" ah,9="" int="" 21h="" ;="" display="" error="" message="" stc="" ;="" and="" flag="" error="" jmp="" short="" ew08="" ew01:="" clc="" ;="" no="" error="" ew08:="" ret="" evalsw="" endp="" illparm="" db="" 'error:="" minute="" count="" must="" be="" in="" range="" 1="" to="" 60.',7,'$'="" _text="" ends="" end="" =""></=>