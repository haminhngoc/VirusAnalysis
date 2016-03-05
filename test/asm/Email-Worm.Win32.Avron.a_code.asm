0x00419dd0:	pusha
0x00419dd1:	movl %esi, $0x414000<UINT32>
0x00419dd6:	leal %edi, -77824(%esi)
0x00419ddc:	pushl %edi
0x00419ddd:	orl %ebp, $0xffffffff<UINT8>
0x00419de0:	jmp 0x00419df2
0x00419df2:	movl %ebx, (%esi)
0x00419df4:	subl %esi, $0xfffffffc<UINT8>
0x00419df7:	adcl %ebx, %ebx
0x00419df9:	movb %al, (%edi)
0x00419dfb:	jb 0x00419de8
0x00419dfd:	movl %eax, $0x1<UINT32>
0x00419e02:	addl %ebx, %ebx
0x00419e04:	jne 0x00419e0d
0x00419e0d:	adcl %eax, %eax
0x00419e0f:	addl %ebx, %ebx
0x00419e11:	jae 0x00419e02
0x00419e06:	movl %ebx, (%esi)
0x00419e08:	subl %esi, $0xfffffffc<UINT8>
0x00419e0b:	adcl %ebx, %ebx
