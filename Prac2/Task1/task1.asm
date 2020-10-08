segment .data
	SYS_read: equ 0
	STDIN: equ 0
	LF equ 10
	
	inMsg: db ""
	sIn: db "Please input a 5 digit number: ",0x0a
	sOut: db "This is the number you are looking for: ",0x0a
	

segment .text
	global _start
_start:
	mov eax,1
	mov edi,1
	mov edx, 31 ; The number of characters
	lea rsi,[sIn]
	syscall

	mov rax, SYS_read
	mov rdi, STDIN
	mov rsi, inMsg ; msg address
	mov rdx, 5 ; read count
	syscall

	mov eax,1
	mov edi,1
	mov edx, 40 ; The number of characters
	lea rsi,[sOut]
	syscall

	mov eax,1
	mov edi,1
	mov edx, 5 ; The number of characters
	lea rsi,[inMsg]
	syscall

	mov eax,60
	xor edi, edi
	syscall
