

COMMENT	$

    ûirogen's Thunderbyte Signature Phile Displayer
    Äversion 1.0ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
    I commented this thing until it'z redundant, so appreciate it damnit!

    Anywayz, pheel phree to make improvments to the code, and use it as
    you wish. Send me a copy if possible.. As long as you don't slap your
    name on it and claim that you wrote this from scratch I really don't
    care. In any case, please redistribute the source code and history of
    revisions.

      compile with:
        TASM /m2 VG-TBSIG
        TLINK /t VG-TBSIG

      History:
     ver     author
    -------------------------------
    v1.0    - ûirogen - Initial release - 07-04-94


$
segment	cseg
assume	cs:	cseg, ds: cseg, es: cseg, ss: cseg

org	100h
start:

	lea	dx,intro_msg	; display intro message
	call	disp

	mov	ah,3dh		; open phile
	lea	dx,fname
	int	21h
	jnc	open_ok
	jmp	error_open	; if error abort..
open_ok:
	xchg	ax,bx
	mov	ah,3fh		; read phile
	lea	dx,buffer	; buffer is heap
	mov	cx,0F000h	; try reading apx. max possible
	int	21h
	mov	ah,3eh		; close phile
	int	21h

	lea	bx,buffer+80h	; first 80h is not data
l2:
	xor	cx,cx
	xor	ax,ax
	test	byte ptr [bx],0FFh ; if byte 0 0FFh then exit
	jz	exit
	cmp	byte ptr [bx+1],0FFh ; if byte 1 0FFh then not polymorphic
	jnz	non_poly
	mov	si,bx		; setup ptr to virus name
	add	si,[bx+0Ch]	; byte 0Ch is offset from beginning of blck
	mov	cx,[bx+0Ah]	; byte 0Ah is string length
	dec	cx
	call	decrypt		; decrypt virus name
	lea	dx,pv_stg
	call	disp		; indicate polymorphic virus
	lea	dx,print_stg
	call	disp		; display virus name
	add	bx,[bx+0Eh]	; byte 0Eh is index to next entry
	jmp	l2		; go for next block

non_poly:
	test	byte ptr [bx+2],01000000b ; if bit 6 us 0 then is not user defined
	jz	non_user
	lea	dx,user_stg	; indicate user defined
	call	disp
non_user:
	lea	si,byte ptr [bx+0Ah] ; byte 0Ah is start of virusname
	mov	cl,byte ptr [BX+8h] ; byte 8h is string length
	call	decrypt		; decrypt virus name
	test	byte ptr [bx+1],0Fh ; if byte 1 is 0Fh then not virus entry
	jz	virus_entry
non_virus_entry:
	lea	dx, nv_stg	; indicate non-virus
	jmp	ptr_set
virus_entry:
	lea	dx, v_stg	; indicate virus
ptr_set:
	call	disp
	lea	dx,print_stg
	call	disp		; display virus|prog name
	mov	al,[bx+7]	; byte 7 is length of signature
	lea	bx,[bx+0Ah]	; bx pts to start of virus name
	add	bx,cx		; cx still contains vname length
	mov	cx,ax		; cx=signature length
	mov	si,bx		; si=ptr to signature start
	call	decrypt		; decrypt signature
	lea	di,print_stg
	add	bx,cx		; bx+=sig length, vname len allready +ed
	call	hexdisp		; display signature
	jmp	l2		; go for next block

error_open:
	lea	dx,error_msg	; display error msg
	call	disp

exit:
	ret


disp:				; display string via DOS 9h (redirectable)
	mov	ah,9
	int	21h
	xor	ax,ax
	ret



hexdisp: 			; display hex->ascii ..cx=len..di=ptr
	push	bx		; save block ptr
	lea	dx,sig_stg	; indicate signature
	mov	ah,9
	int	21h
	mov	bp,cx		; use BP as counter
	xor	dx,dx
	hloop:
	mov	bh,byte ptr [di] ; get byte
	dec	dh		; decremt wc mark ctr
	cmp	dh,1		; time to display trailing '_'?
	jz	disp_mark
	cmp	bh,38h		; wildcard?
	jnz	no_wcard
	mov	dh,3		; setup counter to put trailing '_'
disp_mark:
	mov	dl,'_'
	call	disp_one	; indicate wildcard
	no_wcard:
	call	byte_disp	; display as ASCII
	inc	di		; increment ptr
	dec	bp		; dec counter
	jnz	hloop		; loop..

	lea	dx,pair		; display cr/lf
	call	disp
	pop	bx		; restore block ptr
	ret

byte_disp: 			; display hex->ascii byte, bh=byte
	mov	ch,2		; two ascii chars, two hex nibbles
bloop:
	mov	cl,4
	rol	bx,cl		; rotateL 4 bits, setup next nibble
	mov	dl,bl
	and	dl,0Fh		; kill other nibble
	add	dl,30h		; +30=3xh -> ascii numeric digit
	cmp	dl,3Ah		; numeric or alphabetic?
	jl	no_add		;
	add	dl,7		; add if alphabetic
no_add:
	call	disp_one	; display 'de char man
	dec	ch		; decrement counter
	jnz	bloop
	ret

disp_one:
	mov	ah,2
	int	21h
	ret

decrypt:
	push	cx		; save string len
	lea	di,print_stg
l1:
	lodsb			; get
	xor	al,0A5h		; XOR by A5h
	stosb			; store
	loop	l1
	mov	ax,0A0Dh	; append cr/lf
	stosw
	mov	al,'$'		; append '$'
	stosb
	xor	ax,ax
	pop	cx		; restore slen
	ret

fname	db	'TBSCAN.SIG',0
error_msg db	0Dh,0Ah,'Error opening TBSCAN.SIG!','$'
intro_msg db	0Dh,0Ah,'ThunderByte Anti-Virus Signature File Reader v1.0 - Coded by ûirogen'
        db      0Dh,0Ah,' The Adjacent Reality BBS [615].586.9515 - Jeremy.Collake@hal9k.com'
	db	0Dh,0Ah,'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ'
pair	db	0Dh,0Ah,'$'
space	db	'  ','$'
user_stg db	'User Defined $'
v_stg	db	'Virus : ','$'
nv_stg	db	'Non-Virus : ','$'
pv_stg	db	'Polymorphic Virus : ','$'
sig_stg	db	'ÀÄSignature : ','$'
print_stg db	50 dup(0)
buffer:

cseg	ends
	end	start

