

%TITLE "TPE Test"

                .model  tiny

                .code

                extrn   crypt:near              ;external routines in engine
                extrn   rnd_get:near
                extrn   rnd_init:near


                org     0100h


begin:          call    rnd_init                ;init. random number generator


                mov     ah,3Ch                   ;create a new file
                mov     dx,offset filename
                mov     cx,0020h
                int     21h
                xchg    ax,bx

                push    ds
                push    es
                push    bx

                mov     ax,cs                   ;input parameters for engine
                mov     ds,ax
                add     ax,0800h
                ;;add     ax,0400h
                mov     es,ax                   ;ES = DS + 800h
                xor     si,si                   ;code will be right after decr.
                                                ;offset of code from decryptor
                mov     dx,offset virus         ;this will be encrypted
                mov     cx,offset buffer        ;length of code to encrypt
                sub     cx,offset virus         ;length of code to encrypt

                mov     bp,0100h                ;decryptor will start at 100h
                                                ;so you don't need an org 100h

                xor     ax,ax
                call    rnd_get                 ;AX register will be random

                and     al,11110000b            ; bit field: [clear bits]
                or      al,00000110b            ; bit field: [set bits]
                                                ; random nonfunctional ops
                                                ; 1: in decryptor
                                                ; 2: before decryptor
                                                ; Beware some of these ops
                                                ; are coprocessor escapes

                call    crypt                   ;call the engine

                pop     bx                      ;write crypted file
                mov     ah,40h
                int     21h

                mov     ah,3Eh                   ;close the file
                int     21h

                pop     es
                pop     ds
                

gone:           int     20h

                .data                           ; Note!

; *********************************************************************
; *     DATA                                                          *
; *********************************************************************

filename        db      'TEST.COM',0

;----------------------------------------------------------------------------
;               The file that will be encrypted
;----------------------------------------------------------------------------

virus:      call    main      ;get relative offset

; *********************************************************************
; *     MAIN                                                          *
; *********************************************************************

main    proc
start:  jmp     do_it



vid_state       db      0       ; save video state

SCRNSEG dw      0
VID_PORT  dw    0
PAG_NUM db      0
parseg  dw      ?

; TheDraw Assembler Crunched Screen Image.   Width=80  Depth=??  Length=???
screen0:
        DB      16,11,24,24,'É',26,77,'Í»',24,'º',25,17,'±±Ü ±±Ü ±±Ü ±±Ü ',26
        DB      5,'±Ü ±±±ÜÜ ±±Ü ',26,5,'±Ü',25,18,'º',24,'º',25,17,'±'
        DB      '±Û ±±Û ±±Û ±±Û ±±Ûß±±Û ±±Û±±Û±±Û ±±Û',26,3,'ß',25,18
        DB      'º',24,'º',25,17,26,4,'±Ûß ±±Û ±±Û ',26,5,'±Û ±±Û ß±'
        DB      '±±Û ±±Û±±±Ü',25,18,'º',24,'º',25,17,'±±Ûß±±Ü ±±Û ±±'
        DB      'Û ±±Û ±±Û ±±Û',25,2,'±±Û ±±Û ±±Û',25,18,'º',24,'º',25
        DB      17,'±±Û ±±Û ',26,5,'±Û ±±Û ±±Û ±±Û',25,2,'±±Û ',26,5,'±'
        DB      'Û',25,18,'º',24,'º',25,18,'ßß  ßß  ',26,5,'ß  ßß  ß'
        DB      'ß  ßß',25,3,'ßß  ',26,5,'ß',25,18,'º',24,'º',25,77,'º'
        DB      24,'º',25,77,'º',24,'º',25,77,'º',24,'È',26,77,'Í¼',24
        DB      24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24
        DB      24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24
        DB      24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24
        DB      24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24
        DB      24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24
        DB      24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24
        DB      24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24


do_it:
;**************************************************************************
;* Video Initialization                                                   *
;**************************************************************************
        mov     ah,0fh  ; get mode
        int     10h     ; call vid int
        mov     vid_state,al    ; store video mode
        mov     PAG_NUM,bh      ; hold video page #
        cmp     al,7    ; is it mono?
        je      ismono  ;
        mov     VID_PORT,03dah  ; stat colour controller port
        cmp     [PAG_NUM],0
        jne     notpage0
        mov     SCRNSEG,0b800h  ; page 0
        jmp     main1

notpage0:
        cmp     [PAG_NUM],1
        jne     notpage1
        mov     SCRNSEG,0b900h  ; page 1
        jmp     main1

notpage1:
        cmp     [PAG_NUM],2
        jne     notpage2
        mov     SCRNSEG,0ba00h  ; page 2
        jmp     main1

notpage2:
        mov     SCRNSEG,0bb00h  ; page 3
        jmp     main1

ismono:
        mov     VID_PORT,03bah  ; stat mono controller port
        mov     SCRNSEG,0b000h  ; mono screen seg


;**************************************************************************
;* M A I N 1   zxzxzx                                                     *
;**************************************************************************
main1:
        mov     ax,ds

        MOV     SI,offset screen0
        MOV     AX,SCRNSEG
        MOV     ES,AX
        MOV     DI,0
        MOV     CX,310
        CALL    UNCRUNCH

        ret

main    endp

; *********************************************************************
; *     END OF MAIN PROC                                              *
; *********************************************************************


; *********************************************************************
; *     UNCRUNCH PROCEDURE                                            *
; *********************************************************************

UNCRUNCH PROC NEAR
;
;Parameters Required:
;  DS:SI  ImageData source pointer.
;  ES:DI  Display address pointer.
;  CX     Length of ImageData source data.
;
       PUSH    SI                      ;Save registers.
       PUSH    DI
       PUSH    AX
       PUSH    CX
       PUSH    DX

       MOV     DX,DI                   ;Save X coordinate for later.
       XOR     AX,AX                   ;Set Current attributes.

LOOPA: LODSB                           ;Get next character.
       CMP     AL,27                   ;Does user want to toggle the blink
       JNZ     ForeGround              ;attibute?
       XOR     AH,128                  ;Done.
       JMP     Short Next

ForeGround:
       CMP     AL,16                   ;If less than 16, then change the
       JNC     BackGround              ;foreground color.  Otherwise jump.
       AND     AH,70H                  ;Strip off old foreground.
       OR      AH,AL
       JMP     Short Next

BackGround:
       CMP     AL,24                   ;If less than 24, then change the
       JZ      NextLine                ;background color.  If exactly 24,
       JNC     MultiOutput             ;then jump down to next line.
       SUB     AL,16                   ;Otherwise jump to multiple output
       ADD     AL,AL                   ;routines.
       ADD     AL,AL
       ADD     AL,AL
       ADD     AL,AL
       AND     AH,7FH                  ;Strip off old background.
       OR      AH,AL
       JMP     Short Next

NextLine:
       ADD     DX,160                  ;If equal to 24,
       MOV     DI,DX                   ;then jump down to
       JMP     Short Next              ;the next line.

MultiOutput:
       CMP     AL,25                   ;If equal to 25,
       JNZ     NotMultiSpaces          ;then using the
       LODSB                           ;following code as
       PUSH    CX                      ;a count, output
       XOR     CH,CH                   ;said number of
       MOV     CL,AL                   ;spaces.
       MOV     AL,32
       JMP     Short StartOutput       ;Use below loop.

NotMultiSpaces:
       CMP     AL,26                   ;If equal to 26, then using
       JNZ     NormalLetter            ;the following two codes, display
       LODSB                           ;<x> number of <y> characters.
       DEC     CX                      ;Adjust main counter.
       PUSH    CX                      ;Display as many of
       XOR     CH,CH                   ;whatever the user
       MOV     CL,AL                   ;wants.
       LODSB                           ;Get character.

StartOutput:
       JCXZ    Stop2                    ;Abort if already at zilch.
LOOPB: STOSW
       LOOP    LOOPB
Stop2:  POP     CX
       DEC     CX                      ;Adjust main counter.

NormalLetter:
       STOSW                           ;Save screen letter.

Next:  JCXZ    Done                    ;Get next, unless CX
       LOOP    LOOPA                   ;has already gone to zero.

Done:  POP     DX                      ;Restore registers.
       POP     CX
       POP     AX
       POP     DI
       POP     SI
       RET

UNCRUNCH ENDP

; *********************************************************************
; *     END OF PROCS    ***********************************************
; *********************************************************************

        db      (100h) dup (90)         ; note: 256 bytes
buffer  label   byte

        end     begin


</y></x>