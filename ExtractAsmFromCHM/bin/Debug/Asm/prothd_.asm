

;****************************************************************************;
;                                                                            ;
;                     -=][][][][][][][][][][][][][][][=-                     ;
;                     -=]  P E R F E C T  C R I M E  [=-                     ;
;                     -=]      +31.(o)79.426o79      [=-                     ;
;                     -=]                            [=-                     ;
;                     -=] For All Your H/P/A/V Files [=-                     ;
;                     -=]    SysOp: Peter Venkman    [=-                     ;
;                     -=]                            [=-                     ;
;                     -=]      +31.(o)79.426o79      [=-                     ;
;                     -=]  P E R F E C T  C R I M E  [=-                     ;
;                     -=][][][][][][][][][][][][][][][=-                     ;
;                                                                            ;
;                    *** NOT FOR GENERAL DISTRIBUTION ***                    ;
;                                                                            ;
; This File is for the Purpose of Virus Study Only! It Should not be Passed  ;
; Around Among the General Public. It Will be Very Useful for Learning how   ;
; Viruses Work and Propagate. But Anybody With Access to an Assembler can    ;
; Turn it Into a Working Virus and Anybody With a bit of Assembly Coding     ;
; Experience can Turn it Into a far More Malevolent Program Than it Already  ;
; Is. Keep This Code in Responsible Hands!                                   ;
;                                                                            ;
;****************************************************************************;
; This Source is to Protect your HD Against the CDSET Viruses                ;
;****************************************************************************;

code segment public 'code'
		assume	cs:code, ds:code, es:code
		org	100h

Main:		mov	ah,49h
		mov	es,ds:[2eh]
		int	21h
		mov	ah,30h			; fn 30h = Get Dosversion
		int	21h			; int 21h
		cmp	al,4			; major dosversion 
		sbb	si,si
		mov	ah,52h			; get internal list of lists
		int	21h			; int 21h
		lds	bx,es:[bx]		; get pointer to first drive
						; paramenter block

Search:		mov	ax,ds:[bx+si+15h]	; get segment of device header
		cmp	ax,70h			; dos device header ??
		jne	Next			; no, go to next device
		cmp	byte ptr ds:[bx],2
		jb	Next
		xchg	ax,cx
		mov	di,ds:[bx+si+13h]	; get offset of device header
		mov	word ptr ds:[bx+si+13h],offset Header
		mov	ds:[bx+si+15h],cs	; set addres of new device
Next:		lds	bx,ds:[bx+si+19h]	; next drive parameter block
		cmp	bx,-1			; last block ?
		jne	Search			; no, go to Search
		jcxz	Error

		mov	ds,cx
		mov	si,di
		push	cs
		pop	es
		mov	di,offset Header
		cld
		movsw
		movsw
		movsw
		mov	ax,offset Strategy
		stosw
		mov	ax,offset Interrupt
		stosw
		push	di
		mov	di,offset Strategy
		mov	al,0eah
		stosb
		movsw
		mov	ax,cx
		stosw
		mov	di,offset Interrupt
		mov	al,0eah
		stosb
		movsw
		mov	ax,cx
		stosw
		pop	di
		movsw
		mov	ax,3100h
		mov	dx,20h
		int	21h

Error:		mov	ax,4c01h
		int	21h

Header		db	12 dup(?)
Interrupt	db	5 dup(?)
Strategy	db	5 dup(?)


code ends

end Main

;****************************************************************************;
;                                                                            ;
;                     -=][][][][][][][][][][][][][][][=-                     ;
;                     -=]  P E R F E C T  C R I M E  [=-                     ;
;                     -=]      +31.(o)79.426o79      [=-                     ;
;                     -=]                            [=-                     ;
;                     -=] For All Your H/P/A/V Files [=-                     ;
;                     -=]    SysOp: Peter Venkman    [=-                     ;
;                     -=]                            [=-                     ;
;                     -=]      +31.(o)79.426o79      [=-                     ;
;                     -=]  P E R F E C T  C R I M E  [=-                     ;
;                     -=][][][][][][][][][][][][][][][=-                     ;
;                                                                            ;
;                    *** NOT FOR GENERAL DISTRIBUTION ***                    ;
;                                                                            ;
; This File is for the Purpose of Virus Study Only! It Should not be Passed  ;
; Around Among the General Public. It Will be Very Useful for Learning how   ;
; Viruses Work and Propagate. But Anybody With Access to an Assembler can    ;
; Turn it Into a Working Virus and Anybody With a bit of Assembly Coding     ;
; Experience can Turn it Into a far More Malevolent Program Than it Already  ;
; Is. Keep This Code in Responsible Hands!                                   ;
;                                                                            ;
;****************************************************************************;

