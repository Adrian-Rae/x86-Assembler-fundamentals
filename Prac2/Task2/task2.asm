segment .data
	SYS_read: equ 0
	STDIN: equ 0
	LF equ 10
	
	inMsg: db ""
	sIn: db "Please input an integer: ",0x0a
	sOut: db "Result: ",0x0a
	posVal: db "positive"
	negVal: db "negative"
	truth: db ""
	

segment .text
	global _start
_start:
	;START MESSAGE	
	mov eax,1
	mov edi,1
	mov edx, 25 
	lea rsi,[sIn]
	syscall

	;GET NUMBER IN
	mov rax, SYS_read
	mov rdi, STDIN
	mov rsi, inMsg ; msg address
	mov rdx, 1 ; read count
	syscall

	;ARITHMETIC
	movsx rbx, byte [inMsg]
	sub rbx, 48
	;rbx stores the dinkham number

	sub rbx, 5
	cmovge rbx, [posVal]
	cmovl rbx, [negVal]
	mov [inMsg], rbx

	;OUTPUT STRING
	mov eax,1
	mov edi,1
	mov edx, 8 
	lea rsi,[sOut]
	syscall

	;OUTPUT DECISION
	mov eax,1
	mov edi,1
	mov edx, 8 
	lea rsi,[inMsg]
	syscall


	;TERMINATE
	mov eax,60
	xor edi, edi
	syscall
