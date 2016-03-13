

cseg	segment
	assume 	cs:cseg,ds:cseg
	org	100h
start:	mov	al,byte ptr ds:[5dh] ;CHGPRN P changes to PRN
	cmp	al,'P'	             ;CHGPRN L changes to LPT1
	je	toprn	             ;Get address of correct device
	cmp	al,'L'		     ;Name in SI
	je	tolpt		     ;Error if parameter not P or L
	jmp	error
toprn:	mov	si,offset toprnstr
	jmp	short patch
tolpt:	mov	si,offset tolptstr
patch:	mov	cx,8		     ;Patch all eight bytes of name
	xor	ax,ax
	mov	es,ax
	mov	di,82eh		     ;This address must change if
	cld			     ;PRN not located at 0:82E
				     ;Hex
	rep movsb
	int	20h
error:	mov	dx,offset errormsg
	mov 	ah,9
toprnstr db'PRN		  '
tolptstr db'LPT1          '
errormsg db 0dh,0ah,'Usage:chgprn x',0dh,0ah
	db		'x=L    Change to LPT1',0dh,0ah
	db		'x=P    Change to PRN',0dh,0ah,'$'
cseg	ends
	end start

