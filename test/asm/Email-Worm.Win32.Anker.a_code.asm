0x0040155c:	pushl $0x401ae8<UINT32>
0x00401561:	call 0x00401556
0x00401556:	jmp ord(100)@
ord(100)@: API Node	
0x00401566:	addb (%eax), %al
0x00401568:	addb (%eax), %al
0x0040156a:	addb (%eax), %al
0x0040156c:	xorb (%eax), %al
0x0040156e:	addb (%eax), %al
0x00401570:	cmpb (%eax), %al
0x00401572:	addb (%eax), %al
0x00401574:	addb (%eax), %al
0x00401576:	addb (%eax), %al
0x00401578:	xorl %edx, %eax
0x0040157a:	jae 0x00401510
0x0040157c:	movb %ch, $0x78<UINT8>
0x00401510:	andb %al, $0x11<UINT8>
0x00401512:	incl %eax
0x00401513:	addb %bh, %bh
0x00401515:	andl %eax, $0x4010f4<UINT32>
0x0040151a:	jmp ord(645)@
ord(645)@: API Node	
0x00401ae8:	pushl %esi
0x00401ae9:	incl %edx
0x00401aea:	xorl %eax, $0x2a1ff021<UINT32>
0x00401aef:	addb (%eax), %al
0x00401af1:	addb (%eax), %al
0x00401af3:	addb (%eax), %al
0x00401af5:	addb (%eax), %al
0x00401af7:	addb (%eax), %al
0x00401af9:	addb (%eax), %al
0x00401afb:	addb (%esi), %bh
0x00401afe:	addb (%eax), %al
0x00401b00:	addb (%eax), %al
0x00401b02:	addb (%eax), %al
0x00401b04:	addb (%eax), %al
0x00401b06:	addb (%eax), %al
0x00401b08:	addb (%eax), %al
0x00401b0a:	orb %al, (%eax)
0x00401b0c:	orl (%eax,%eax), %eax
0x00401b0f:	addb (%eax), %al
0x00401b11:	addb (%eax), %al
0x00401b13:	addb (%eax), %al
0x00401b15:	addb (%eax), %al
0x00401b17:	addb (%eax), %cl
0x00401b19:	sbbl %eax, $0xf0000040<UINT32>
0x00401b1e:	xorb (%eax), %al
0x00401b20:	addb %bh, %bh
0x00401b22:	null
0x0040157e:	testb %al, $0x4d<UINT8>
0x00401580:	cmpsb %es:(%edi), %ds:(%esi)
0x00401581:	jne 0x00401571
0x00401583:	subl %eax, $0xb0a69514<UINT32>
0x00401588:	addb (%eax), %al
0x0040158a:	addb (%eax), %al
0x0040158c:	addb (%eax), %al
0x0040158e:	addl (%eax), %eax
0x00401590:	addb (%eax), %al
0x00401592:	addb (%eax), %al
0x00401594:	addb (%eax), %al
0x00401596:	addb (%eax), %al
0x00401598:	incl %ecx
0x00401599:	pushl $0x5f72656b<UINT32>
0x0040159e:	incl %edx
0x0040159f:	addb (%eax), %al
0x004015a1:	addb (%eax), %al
0x004015a3:	addb %bh, %bh
0x004015a5:	int3
