0x00404980:	pushl %ebp
0x00404981:	movl %ebp, %esp
0x00404983:	pushl $0xffffffff<UINT8>
0x00404985:	pushl $0x427fe8<UINT32>
0x0040498a:	pushl $0x40b524<UINT32>
0x0040498f:	movl %eax, %fs:0
0x00404995:	pushl %eax
0x00404996:	movl %fs:0, %esp
0x0040499d:	addl %esp, $0xffffffa4<UINT8>
0x004049a0:	pushl %ebx
0x004049a1:	pushl %esi
0x004049a2:	pushl %edi
0x004049a3:	movl -24(%ebp), %esp
0x004049a6:	call GetVersion@kernel32.dll
GetVersion@kernel32.dll: API Node	
0x004049ac:	movl 0x4309e4, %eax
0x004049b1:	movl %eax, 0x4309e4
0x004049b6:	shrl %eax, $0x8<UINT8>
0x004049b9:	andl %eax, $0xff<UINT32>
0x004049be:	movl 0x4309f0, %eax
0x004049c3:	movl %ecx, 0x4309e4
0x004049c9:	andl %ecx, $0xff<UINT32>
0x004049cf:	movl 0x4309ec, %ecx
0x004049d5:	movl %edx, 0x4309ec
0x004049db:	shll %edx, $0x8<UINT8>
0x004049de:	addl %edx, 0x4309f0
0x004049e4:	movl 0x4309e8, %edx
0x004049ea:	movl %eax, 0x4309e4
0x004049ef:	shrl %eax, $0x10<UINT8>
0x004049f2:	andl %eax, $0xffff<UINT32>
0x004049f7:	movl 0x4309e4, %eax
0x004049fc:	pushl $0x0<UINT8>
0x004049fe:	call 0x0040b340
0x0040b340:	pushl %ebp
0x0040b341:	movl %ebp, %esp
0x0040b343:	pushl $0x0<UINT8>
0x0040b345:	pushl $0x1000<UINT32>
0x0040b34a:	xorl %eax, %eax
0x0040b34c:	cmpl 0x8(%ebp), $0x0<UINT8>
0x0040b350:	sete %al
0x0040b353:	pushl %eax
0x0040b354:	call HeapCreate@kernel32.dll
HeapCreate@kernel32.dll: API Node	
0x0040b35a:	movl 0x4321a8, %eax
0x0040b35f:	cmpl 0x4321a8, $0x0<UINT8>
0x0040b366:	jne 0x0040b36c
0x0040b36c:	call 0x0040c870
0x0040c870:	pushl %ebp
0x0040c871:	movl %ebp, %esp
0x0040c873:	pushl $0x140<UINT32>
0x0040c878:	pushl $0x0<UINT8>
0x0040c87a:	movl %eax, 0x4321a8
0x0040c87f:	pushl %eax
0x0040c880:	call HeapAlloc@kernel32.dll
HeapAlloc@kernel32.dll: API Node	
0x0040c886:	movl 0x4321a4, %eax
0x0040c88b:	cmpl 0x4321a4, $0x0<UINT8>
0x0040c892:	jne 0x0040c898
0x0040c898:	movl %ecx, 0x4321a4
0x0040c89e:	movl 0x432198, %ecx
0x0040c8a4:	movl 0x43219c, $0x0<UINT32>
0x0040c8ae:	movl 0x4321a0, $0x0<UINT32>
0x0040c8b8:	movl 0x432184, $0x10<UINT32>
0x0040c8c2:	movl %eax, $0x1<UINT32>
0x0040c8c7:	popl %ebp
0x0040c8c8:	ret

0x0040b371:	testl %eax, %eax
0x0040b373:	jne 0x0040b386
0x0040b386:	movl %eax, $0x1<UINT32>
0x0040b38b:	popl %ebp
0x0040b38c:	ret

0x00404a03:	addl %esp, $0x4<UINT8>
0x00404a06:	testl %eax, %eax
0x00404a08:	jne 0x00404a14
0x00404a14:	movl -4(%ebp), $0x0<UINT32>
0x00404a1b:	call 0x0040afd0
0x0040afd0:	pushl %ebp
0x0040afd1:	movl %ebp, %esp
0x0040afd3:	subl %esp, $0x6c<UINT8>
0x0040afd6:	pushl $0x81<UINT32>
0x0040afdb:	pushl $0x428aa8<UINT32>
0x0040afe0:	pushl $0x2<UINT8>
0x0040afe2:	pushl $0x100<UINT32>
0x0040afe7:	call 0x00405310
0x00405310:	pushl %ebp
0x00405311:	movl %ebp, %esp
0x00405313:	movl %eax, 0x14(%ebp)
0x00405316:	pushl %eax
0x00405317:	movl %ecx, 0x10(%ebp)
0x0040531a:	pushl %ecx
0x0040531b:	movl %edx, 0xc(%ebp)
0x0040531e:	pushl %edx
0x0040531f:	movl %eax, 0x430b58
0x00405324:	pushl %eax
0x00405325:	movl %ecx, 0x8(%ebp)
0x00405328:	pushl %ecx
0x00405329:	call 0x00405360
0x00405360:	pushl %ebp
0x00405361:	movl %ebp, %esp
0x00405363:	pushl %ecx
0x00405364:	movl %eax, 0x18(%ebp)
0x00405367:	pushl %eax
0x00405368:	movl %ecx, 0x14(%ebp)
0x0040536b:	pushl %ecx
0x0040536c:	movl %edx, 0x10(%ebp)
0x0040536f:	pushl %edx
0x00405370:	movl %eax, 0x8(%ebp)
0x00405373:	pushl %eax
0x00405374:	call 0x004053d0
0x004053d0:	pushl %ebp
0x004053d1:	movl %ebp, %esp
0x004053d3:	subl %esp, $0x10<UINT8>
0x004053d6:	pushl %ebx
0x004053d7:	pushl %esi
0x004053d8:	pushl %edi
0x004053d9:	movl -12(%ebp), $0x0<UINT32>
0x004053e0:	movl %eax, 0x42b640
0x004053e5:	andl %eax, $0x4<UINT8>
0x004053e8:	testl %eax, %eax
0x004053ea:	je 0x0040541c
0x0040541c:	movl %edx, 0x42b644
0x00405422:	movl -8(%ebp), %edx
0x00405425:	movl %eax, -8(%ebp)
0x00405428:	cmpl %eax, 0x42b648
0x0040542e:	jne 0x00405431
0x00405430:	int3
0x00405431:	movl %ecx, 0x14(%ebp)
0x00405434:	pushl %ecx
0x00405435:	movl %edx, 0x10(%ebp)
0x00405438:	pushl %edx
0x00405439:	movl %eax, -8(%ebp)
0x0040543c:	pushl %eax
0x0040543d:	movl %ecx, 0xc(%ebp)
0x00405440:	pushl %ecx
0x00405441:	movl %edx, 0x8(%ebp)
0x00405444:	pushl %edx
0x00405445:	pushl $0x0<UINT8>
0x00405447:	pushl $0x1<UINT8>
0x00405449:	call 0x0040c510
0x0040c510:	pushl %ebp
0x0040c511:	movl %ebp, %esp
0x0040c513:	movl %eax, $0x1<UINT32>
0x0040c518:	popl %ebp
0x0040c519:	ret

0x0040544f:	addl %esp, $0x1c<UINT8>
0x00405452:	testl %eax, %eax
0x00405454:	jne 0x004054b4
0x004054b4:	movl %ecx, 0xc(%ebp)
0x004054b7:	andl %ecx, $0xffff<UINT32>
0x004054bd:	cmpl %ecx, $0x2<UINT8>
0x004054c0:	je 0x004054d6
0x004054c2:	movl %edx, 0x42b640
0x004054d6:	cmpl 0x8(%ebp), $0xffffffe0<UINT8>
0x004054da:	ja 0x004054e7
0x004054dc:	movl %eax, 0x8(%ebp)
0x004054e7:	movl %ecx, 0x8(%ebp)
0x004054ea:	pushl %ecx
0x004054eb:	pushl $0x42827c<UINT32>
0x004054f0:	pushl $0x0<UINT8>
0x004054f2:	pushl $0x0<UINT8>
0x004054f4:	pushl $0x0<UINT8>
0x004054f6:	pushl $0x1<UINT8>
0x004054f8:	call 0x00404c50
0x00404c50:	pushl %ebp
0x00404c51:	movl %ebp, %esp
0x00404c53:	movl %eax, $0x302c<UINT32>
0x00404c58:	call 0x0040bd50
0x0040bd50:	pushl %ecx
0x0040bd51:	cmpl %eax, $0x1000<UINT32>
0x0040bd56:	leal %ecx, 0x8(%esp)
0x0040bd5a:	jb 0x0040bd70
0x0040bd5c:	subl %ecx, $0x1000<UINT32>
