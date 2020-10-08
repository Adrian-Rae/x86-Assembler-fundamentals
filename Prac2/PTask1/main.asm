segment .data
	SYS_read: equ 0
	STDIN: equ 0
	LF equ 10

	d1 db 10
	d2 db 0
	e1 db 49
	e2 db 48

	a db "10"
	
	inMsg1: db ""
	inMsg2: db ""
	
	rubbish: db ""

	sIn1: db "Please enter the first number: ",0x0a
	sIn2: db "Please enter the second number: ",0x0a
	
	prefix: db ""	
	outMsg: db ""

segment .text
	global _start
_start:
	;START MESSAGE	
	mov eax,1
	mov edi,1
	mov edx, 31 
	lea rsi,[sIn1]
	syscall

	;GET NUMBER IN
	mov rax, SYS_read
	mov rdi, STDIN
	mov rsi, inMsg1 ; msg address
	mov rdx, 1 ; read count
	syscall
	movsx rbx, byte [inMsg1]
	sub rbx, 48	

	mov rax, SYS_read
	mov rdi, STDIN
	mov rsi, rubbish ; msg address
	mov rdx, 1 ; read count
	syscall

	;START MESSAGE	
	mov eax,1
	mov edi,1
	mov edx, 32 
	lea rsi,[sIn2]
	syscall
	
	xor rsi, rsi
	;GET NUMBER IN
	mov rax, SYS_read
	mov rdi, STDIN
	mov rsi, inMsg2 ; msg address
	mov rdx, 1 ; read count
	syscall

	movsx rcx, byte [inMsg2]
	sub rbx, 48
	add rbx, rcx
	add rbx, 48
	
	;rbx stores the present sum
	
	mov rdx, rbx
	sub rdx, 57
	cmovg rdx, [e1]
	cmovle rdx, [e2]
	mov [prefix], rdx
		

	;OUTPUT STRING for prefix
	mov eax,1
	mov edi,1
	mov edx, 1 
	lea rsi,[prefix]
	syscall

	
	mov rcx, rbx
	sub rcx, 57
	cmovg rcx, [d1]
	cmovle rcx, [d2]
	sub rbx, rcx
	mov [outMsg], rbx
	
	;OUTPUT STRING
	mov eax,1
	mov edi,1
	mov edx, 1 
	lea rsi,[outMsg]
	syscall
	
	;TERMINATE
	mov eax,60
	xor edi, edi
	syscall
