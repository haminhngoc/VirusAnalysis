0x00000000:	incl %eax
0x00000001:	arpl %gs:0x6f(%eax), %bp
0x00000005:	andb 0x66(%edi), %ch
0x00000008:	andb 0x6c65640a, %cl
0x0000000f:	andb 0x3a(%ebx), %ah
0x00000012:	popl %esp
0x00000013:	insl %es:(%edi), %dx
0x00000014:	decl %ecx
0x00000015:	pushl %edx
0x00000016:	incl %ebx
0x00000017:	popl %esp
0x00000018:	jae 0x0000007d
0x0000001a:	jb 0x00000085
0x0000007d:	andb (%esi,%ebp,2), %ah
0x00000080:	imull %esp, 0x6b(%ebx), $0x5c3a6320<UINT32>
0x00000087:	pushl %edi
0x00000088:	decl %ecx
0x00000089:	decl %esi
0x0000008a:	incl %esp
0x0000008b:	decl %edi
0x0000008c:	pushl %edi
0x0000008d:	pushl %ebx
0x0000008e:	popl %esp
0x0000008f:	pushl %ebp
0x00000090:	jo 0x000000f9
0x00000092:	jb 0x000000f5
0x000000f9:	pushl $0x316e206f<UINT32>
0x000000fe:	cmpl %eax, $0x6f6a2f20<UINT32>
0x00000103:	imull %ebp, 0x20(%esi), $0x67654223<UINT32>
0x0000010a:	imull %ebp, 0x6e(%esi), $0x3e207265<UINT32>
0x00000111:	andb %ds:0x3a(%ebx), %ah
0x00000115:	popl %esp
0x00000116:	insl %es:(%edi), %dx
0x00000117:	decl %ecx
0x00000118:	pushl %edx
0x00000119:	incl %ebx
0x0000011a:	popl %esp
0x0000011b:	jae 0x00000180
0x0000011d:	jb 0x00000188
0x00000180:	imull %ebp, 0x64(%esi), $0x5873776f<UINT32>
0x00000187:	pushl %eax
0x00000188:	boundl %esp, %cs:0x74(%ecx)
0x0000018c:	orl %eax, $0x61723a0a<UINT32>
0x00000191:	outsb %dx, %ds:(%esi)
0x00000192:	arpl 0x64(%ecx), %bp
0x00000195:	orl %eax, $0x2066690a<UINT32>
0x0000019a:	js 0x00000206
0x00000085:	cmpb %bl, 0x49(%edi,%edx,2)
0x00000094:	pushl %esp
0x000000f5:	orl %eax, $0x6863650a<UINT32>
0x000000fa:	outsl %dx, %ds:(%esi)
0x000000fb:	andb 0x31(%esi), %ch
0x00000097:	outsl %dx, %ds:(%esi)
0x00000098:	pushl %edi
0x00000099:	imull %ebp, 0x64(%esi), $0x5873776f<UINT32>
0x000000a0:	pushl %eax
0x000000a1:	boundl %esp, %cs:0x74(%ecx)
0x000000a5:	andb 0x20(%ebp), %bh
0x000000a8:	andb %ds:0x3a(%ebx), %ah
0x000000ad:	popl %esp
0x000000ae:	insl %es:(%edi), %dx
0x000000af:	decl %ecx
0x000000b0:	pushl %edx
0x000000b1:	incl %ebx
0x000000b2:	popl %esp
0x000000b3:	jae 0x00000118
0x000000b5:	jb 0x00000120
0x00000120:	je 0x00000150
0x00000122:	imull %ebp, 0x69(%esi), $0x66690a0d<UINT32>
0x00000150:	je 0x00000172
0x00000172:	decl %edi
0x00000173:	pushl %edi
0x00000174:	pushl %ebx
0x00000175:	popl %esp
0x00000176:	pushl %ebp
0x00000177:	jo 0x000001e0
0x00000179:	jb 0x000001dc
0x00000129:	andb 0x78(%ebp), %ah
0x0000012c:	imull %esi, 0x74(%ebx), $0x5c3a6320<UINT32>
0x00000133:	pushl %edi
0x00000134:	decl %ecx
0x00000135:	decl %esi
0x00000136:	incl %esp
0x00000137:	decl %edi
0x00000138:	pushl %edi
0x00000139:	pushl %ebx
0x0000013a:	popl %esp
0x0000013b:	pushl %ebp
0x0000013c:	jo 0x000001a5
0x0000013e:	jb 0x000001a1
0x0000017b:	pushl %esp
0x000001dc:	arpl %gs:0x6f(%eax), %bp
0x000001e0:	andb 0x48(%ebx), %bl
0x000001e3:	decl %ebx
0x000001e4:	incl %ebp
0x000001e5:	popl %ecx
0x000001e6:	popl %edi
0x000001e7:	decl %esp
0x000001e8:	decl %edi
0x000001e9:	incl %ebx
0x000001ea:	incl %ecx
0x000001eb:	decl %esp
0x000001ec:	popl %edi
0x000001ed:	decl %ebp
0x000001ee:	incl %ecx
0x000001ef:	incl %ebx
0x000001f0:	decl %eax
0x000001f1:	decl %ecx
0x000001f2:	decl %esi
0x000001f3:	incl %ebp
0x000001f4:	popl %esp
0x000001f5:	pushl %ebx
0x000001f6:	decl %edi
0x000001f7:	incl %esi
0x000001f8:	pushl %esp
0x000001f9:	pushl %edi
0x000001fa:	incl %ecx
0x000001fb:	pushl %edx
0x000001fc:	incl %ebp
0x000001fd:	popl %esp
0x000001fe:	decl %ebp
0x000001ff:	imull %esp, 0x72(%ebx), $0x666f736f<UINT32>
0x00000206:	je 0x00000264
0x00000208:	pushl %edi
0x00000264:	orl %eax, $0x75703a0a<UINT32>
0x0000026a:	outsb %dx, %ds:(%esi)
0x0000026b:	imull %ecx, 0x6174730a, $0x72<UINT8>
0x00000272:	je 0x00000294
0x00000140:	pushl %esp
0x000001a1:	cmpb %bl, 0x50(%eax,%ebx,2)
0x000001a5:	pushl %ebp
0x000001a6:	jo 0x0000020c
0x000001a8:	popa
0x0000020c:	outsl %dx, %ds:(%esi)
0x0000020d:	ja 0x00000282
0x0000020f:	popl %esp
0x00000282:	orl %eax, $0x726f660a<UINT32>
0x00000288:	andb 0x69206625, %ah
0x0000028e:	outsb %dx, %ds:(%esi)
0x0000028f:	andb (%eax), %ch
0x00000291:	incl %ebx
0x00000292:	cmpb %bl, 0x72(%eax,%esi,2)
0x00000296:	outsl %dx, %ds:(%esi)
0x00000297:	jb 0x000002fb
0x0000029a:	jle 0x000002cd
0x000002fb:	jae 0x00000373
0x000002fe:	insl %es:(%edi), %dx
0x0000017e:	outsl %dx, %ds:(%esi)
0x0000017f:	pushl %edi
0x00000209:	imull %ebp, 0x64(%esi), $0x5c73776f<UINT32>
0x00000210:	incl %ebx
0x00000211:	jne 0x00000285
0x00000285:	outsw %dx, %ds:(%esi)
0x00000287:	jb 0x000002a9
0x00000289:	andl %eax, $0x69206625<UINT32>
0x00000143:	outsl %dx, %ds:(%esi)
0x00000144:	pushl %edi
0x00000145:	imull %ebp, 0x64(%esi), $0x5873776f<UINT32>
0x0000014c:	pushl %eax
0x0000014d:	boundl %esp, %cs:0x74(%ecx)
0x00000151:	andb 0x6f(%edi), %ah
0x00000154:	je 0x000001c5
0x00000156:	andb 0x61(%edx), %dh
0x000001c5:	decl %ecx
0x000001c6:	pushl %esp
0x000001c7:	xorb %al, $0x20<UINT8>
0x000001c9:	andb %ds:0x3a(%ebx), %ah
0x000001cd:	popl %esp
0x000001ce:	popl %eax
0x000001cf:	pushl %eax
0x000001d0:	pushl %ebp
0x000001d1:	jo 0x00000237
0x000001a9:	je 0x00000210
0x000001ab:	jb 0x00000213
0x000002a9:	jle 0x000002dd
0x000002ac:	popl %esp
0x000002dd:	outsl %dx, %ds:(%esi)
0x000002de:	andb 0x6f(%edi), %ah
0x000002e1:	insb %es:(%edi), %dx
0x000002e2:	imulw %bp, %fs:0x67(%esi), $0x7265<UINT16>
0x000002e9:	orl %eax, $0x6863650a<UINT32>
0x000002ee:	outsl %dx, %ds:(%esi)
0x000002ef:	andb %cs:0x6e(%edi), %ch
0x000002f3:	andb 0x72(%ebp), %ah
0x000002f6:	jb 0x00000367
0x000002f8:	jb 0x0000031a
0x00000367:	andb 0x3a(%ebx), %ah
0x0000036a:	popl %esp
0x0000036b:	popl %eax
0x0000036c:	jbe 0x000003d1
0x0000029c:	popl %esp
0x000002cd:	imull %esi, 0x74(%ebx), $0x5c3a6320<UINT32>
0x000002d4:	popl %eax
0x000002d5:	jbe 0x0000033a
0x0000033a:	andb 0x20(%ecx), %ah
0x0000033d:	cmpl %eax, $0x63735720<UINT32>
0x00000342:	jb 0x000003ad
0x00000344:	jo 0x000003ba
0x000003ad:	outsl %dx, %ds:(%esi)
0x000003ae:	ja 0x00000423
0x000003b0:	popl %esp
0x00000423:	boundl %esi, 0xd(%ebx)
0x00000426:	orb %ah, 0x63(%ebp)
0x00000429:	pushl $0x6573206f<UINT32>
0x0000042e:	je 0x00000450
0x000002ff:	andb %gs:0x65(%esi), %ch
0x00000303:	js 0x00000379
0x00000305:	andb (%esi), %bh
0x00000379:	pushl %edx
0x0000037a:	pushl %edi
0x0000037d:	jb 0x000003e8
0x000003e8:	orb %ah, 0x63(%ebp)
0x000003eb:	pushl $0x6573206f<UINT32>
0x000003f0:	je 0x00000412
0x00000213:	jb 0x0000027a
0x00000159:	outsb %dx, %ds:(%esi)
0x0000015a:	arpl 0x64(%ecx), %bp
0x0000015d:	orl %eax, $0x706f630a<UINT32>
0x00000162:	jns 0x00000184
0x000001ae:	andb 0x6f(%edi), %ah
0x0000027a:	jo 0x000002e0
0x0000027c:	popa
0x000002ad:	subb %ch, (%esi)
0x000002af:	popa
0x000002b1:	je 0x000002dc
0x000002b3:	andb 0x20(%edi,%ebp,2), %ah
0x000002dc:	je 0x0000034d
0x0000034d:	decl %edi
0x0000034e:	boundl %ebp, 0x65(%edx)
0x00000351:	arpl 0x22(%eax,%ebp), %si
0x00000355:	pushl %edi
0x00000356:	jae 0x000003bb
0x000003bb:	jae 0x00000426
0x00000430:	arpl (%eax), %sp
0x000002fa:	jb 0x00000361
0x0000029d:	insl %es:(%edi), %dx
0x0000029e:	arpl 0x66(%ecx), %sp
0x000002a1:	popl %esp
0x000002a4:	insl %es:(%edi), %dx
0x000002a5:	arpl 0x66(%ecx), %sp
0x000002a8:	jle 0x000002dd
0x00000346:	incl %ebx
0x000003b1:	incl %ebx
0x000003b2:	jne 0x00000426
0x00000307:	andb 0x3a(%ebx), %ah
0x0000030a:	popl %esp
0x0000030b:	popl %eax
0x0000030c:	jbe 0x00000371
0x00000371:	orb %ah, 0x63(%ebp)
0x00000374:	pushl $0x2e61206f<UINT32>
0x0000037f:	je 0x000003e6
0x000003b4:	jb 0x0000041b
0x000001b2:	je 0x00000223
0x000001b4:	andb 0x75(%eax), %dh
0x0000027d:	je 0x000002e4
0x0000027f:	jb 0x000002e7
0x000002b7:	arpl 0x70(%edi), %bp
0x000002ba:	jns 0x000002dc
0x000002bc:	andl %eax, $0x61622e30<UINT32>
0x00000432:	cmpl %eax, $0x472e6220<UINT32>
0x00000437:	je 0x00000488
0x0000043a:	popa
0x000002fc:	jae 0x00000373
0x00000358:	jb 0x000003c3
0x00000348:	jb 0x000003af
0x000003af:	jae 0x0000040d
0x000002e4:	imull %ebp, 0x67(%esi), $0xa0d7265<UINT32>
0x000002eb:	arpl %gs:0x6f(%eax), %bp
0x000003d1:	popl %eax
0x000003d2:	pushl %eax
0x000003d3:	popl %esp
0x000003d4:	js 0x00000446
0x000003d6:	boundl %esp, %cs:0x74(%ecx)
0x0000034a:	popa
0x0000041b:	andb %ds:0x3a(%ebx), %ah
0x0000041f:	popl %esp
0x00000420:	popl %eax
0x00000421:	jbe 0x00000486
0x00000486:	jbe 0x000004eb
0x000004eb:	subl (%eax), %esp
0x000004ed:	andb %ds:0x3a(%ebx), %ah
0x000004f2:	popl %esp
0x000004f3:	popl %eax
0x000004f4:	jbe 0x00000559
0x000004f7:	jae 0x00000506
0x00000559:	orb %ah, 0x63(%ebp)
0x0000055c:	pushl $0x2e65206f<UINT32>
0x00000561:	pushl %edx
0x00000562:	arpl %gs:0x70(%ecx), %bp
0x00000566:	imull %esp, 0x6e(%ebp), $0x412e7374<UINT32>
0x0000056d:	andb %fs:0x20(%esi), %ah
0x00000572:	andb %ds:0x3a(%ebx), %ah
0x00000577:	popl %esp
0x00000578:	popl %eax
0x00000579:	jbe 0x000005de
0x000001b7:	outsb %dx, %ds:(%esi)
0x000001b8:	imull %ecx, 0x6863650a, $0x6f<UINT8>
0x000001bf:	andb 0x45(%edx), %dl
0x000001c2:	incl %edi
0x000001c3:	incl %ebp
0x000001c4:	incl %esp
0x000002e7:	jb 0x000002f7
0x000002f7:	outsl %dx, %ds:(%esi)
0x0000031a:	andb 0x2c(%ecx), %ah
0x0000031d:	boundl %ebp, (%ebx,,2)
0x00000320:	subb %al, $0x64<UINT8>
0x00000322:	subb %al, $0x65<UINT8>
0x00000324:	andb (%esi), %bh
0x00000326:	andb %ds:0x3a(%ebx), %ah
0x0000032a:	popl %esp
0x0000032b:	popl %eax
0x0000032c:	jbe 0x00000391
0x0000032f:	jae 0x0000033e
0x000002c1:	je 0x000002e3
0x000002c3:	andl %eax, $0xa0d6625<UINT32>
0x0000043b:	insl %es:(%edi), %dx
0x0000043c:	pushl %ebx
0x0000043e:	jo 0x000004a1
0x00000440:	arpl 0x28(%ebp), %sp
0x00000373:	arpl 0x6f(%eax), %bp
0x00000376:	andb 0x2e(%ecx), %ah
0x000003c3:	popl %esp
0x000003c4:	popl %eax
0x000003c5:	popl %eax
0x000003c6:	pushl %eax
0x000003c7:	andb %ah, (%eax)
0x000003c9:	orl %eax, $0x22202c0a<UINT32>
0x000003ce:	arpl (%edx), %di
0x000003d0:	popl %esp
0x00000391:	decl %eax
0x00000392:	decl %ecx
0x00000393:	decl %esi
0x00000394:	incl %ebp
0x00000395:	popl %esp
0x00000396:	pushl %ebx
0x00000397:	decl %edi
0x00000398:	incl %esi
0x00000399:	pushl %esp
0x0000039a:	pushl %edi
0x0000039b:	incl %ecx
0x0000039c:	pushl %edx
0x0000039d:	incl %ebp
0x0000039e:	popl %esp
0x0000039f:	decl %ebp
0x000003a0:	imull %esp, 0x72(%ebx), $0x666f736f<UINT32>
0x000003a7:	je 0x00000405
0x000003a9:	pushl %edi
0x000003da:	andb %ah, (%eax)
0x000003dc:	andb %ds:0x3a(%ebx), %ah
0x000003e1:	popl %esp
0x000003e2:	popl %eax
0x000003e3:	jbe 0x00000448
0x00000448:	andb %ch, (%ecx)
0x0000044a:	andb (%esi), %bh
0x0000044c:	andb %ds:0x3a(%ebx), %ah
0x00000450:	popl %esp
0x00000451:	popl %eax
0x00000452:	jbe 0x000004b7
0x0000034b:	je 0x000003b2
0x00000506:	andb (%ecx), %dh
0x00000508:	andb 0x20(%edi,%ebp,2), %dl
0x0000050c:	incl %ecx
0x0000050f:	jb 0x00000578
0x00000513:	jae 0x00000588
0x000005de:	arpl (%edx), %di
0x000005e0:	popl %esp
0x000005e1:	popl %eax
0x000005e2:	jbe 0x00000647
0x00000647:	andb 0x20(%edi,%ebp,2), %dh
0x0000064b:	pushl %edi
0x0000064c:	imull %ebp, 0x64(%esi), $0x2073776f<UINT32>
0x00000653:	popl %eax
0x00000654:	pushl %eax
0x00000655:	andb 0x6f(%esi), %ch
0x00000658:	ja 0x00000688
0x0000065a:	andb %ah, (%eax)
0x00000688:	incl %esp
0x00000689:	decl %edi
0x0000068a:	pushl %edi
0x0000068b:	pushl %ebx
0x0000068c:	popl %esp
0x0000068d:	pushl %ebp
0x0000068e:	jo 0x000006f7
0x00000690:	jb 0x000006f3
0x0000033e:	andb 0x73(%edi), %dl
0x00000341:	arpl 0x69(%edx), %si
0x000002c8:	imull %esp, 0x20(%esi), $0x73697865<UINT32>
0x000002cf:	je 0x000002f1
0x000002d1:	arpl (%edx), %di
0x000004b7:	orb %ah, 0x63(%ebp)
0x000004ba:	pushl $0x2078206f<UINT32>
0x000004bf:	cmpl %eax, $0x3e203120<UINT32>
0x000004c4:	andb %ds:0x3a(%ebx), %ah
0x000004c8:	popl %esp
0x000004c9:	popl %eax
0x000004ca:	jbe 0x0000052f
0x000004cd:	jae 0x000004dc
0x00000443:	andb %cl, 0x41(%ebp)
0x00000446:	pushl %eax
0x00000447:	decl %ecx
0x000003aa:	imull %ebp, 0x64(%esi), $0x5c73776f<UINT32>
0x0000052f:	orb %ah, 0x63(%ebp)
0x00000532:	pushl $0x2066206f<UINT32>
0x00000537:	cmpl %eax, $0x412e6420<UINT32>
0x0000053c:	jb 0x000005a5
0x00000540:	jae 0x000005b5
0x00000588:	js 0x000005aa
0x0000058a:	subl %esp, (%eax)
0x000005aa:	popl %esp
0x000005ab:	popl %eax
0x000005ac:	jbe 0x00000611
0x000005af:	jae 13
0x0000065c:	andb %ds:0x3a(%ebx), %ah
0x00000661:	popl %esp
0x00000662:	popl %eax
0x00000663:	jbe 0x000006c8
0x000006f3:	popl %eax
0x000006f4:	jbe 0x00000759
0x00000759:	je 0x000007cf
0x0000075b:	jo 58
0x000002d3:	popl %esp
0x000004dc:	andb 0x2e(%edx), %ah
0x000004df:	incl %ebx
0x000004e0:	jb 0x00000547
0x000004e2:	popa
0x00000547:	jae 0x00000572
0x0000054a:	js 41
0x000005b5:	outsl %dx, %ds:(%esi)
0x000005b6:	andb 0x2e(%ebp), %ah
0x000005b9:	pushl %ebx
0x000005ba:	jne 0x0000061e
0x0000061e:	popa
0x0000061f:	arpl 0x6d(%eax), %bp
0x00000622:	outsb %dx, %ds:(%esi)
0x00000624:	je 0x00000646
0x00000626:	outsw %dx, %ds:(%esi)