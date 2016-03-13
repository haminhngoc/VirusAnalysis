

PAGE	71,132

TITLE	Target file of @ virus

COMMENT *
	Writing by Leslie Kovari  1990.07.21.
		     Last Update  1990.07.21.




	*

CODE	SEGMENT PARA	PUBLIC	'CODE'

	ASSUME	CS:CODE,DS:CODE,SS:CODE,ES:NOTHING

		ORG	100H
START:
		JMP	ENTRY

;
;
;	Data section.
;
;
	im	db	'I`m a @ virus!',13,10,'$'

ENTRY:

;
;
;	Main program.
;
;
		mov	ah,9
		mov	dx,offset Im
		int	21h
		MOV	AH,0			;Exit to DOS function
		INT	20H			;Call DOS

CODE	ENDS

	END	START

