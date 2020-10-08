segment .data
	SYS_read: equ 0
	STDIN: equ 0
	LF equ 10

	decimal: db 10

	sIn1: db "Please enter the first number: ",0x0a
	sIn2: db "Please enter the second number: ",0x0a

	inChar: db ""
	rubbish: db ""

	rem: db "r"
	temp: db ""

	q: db 0
	r: db 0

	a: db 0
	b: db 0
	c: db 0
	d: db 0	

	o1 db 0
	o2 db 0
	o3 db 0
	o4 db 0

segment .text
	global _start
_start:
	
		
	mov eax,1
	mov edi,1
	mov edx, 31 
	lea rsi,[sIn1]
	syscall	

	mov rax, SYS_read
	mov rdi, STDIN
	mov rsi, a ; msg address
	mov rdx, 1 ; read count
	syscall		

	mov rax, SYS_read
	mov rdi, STDIN
	mov rsi, c ; msg address
	mov rdx, 1 ; read count
	syscall

	mov al, [decimal]	
	mov bl, [a]	
	sub bl, 48 		
	mul bl	
	mov [a], al

	mov al, [a]	
	add al, [c]
	sub al, 48
	mov [a], al		

	;GOTTEN A

	mov eax,1
	mov edi,1
	mov edx, 32 
	lea rsi,[sIn2]
	syscall	

	mov rax, SYS_read
	mov rdi, STDIN
	mov rsi, b ; msg address
	mov rdx, 1 ; read count
	syscall	

	mov rax, SYS_read
	mov rdi, STDIN
	mov rsi, b ; msg address
	mov rdx, 1 ; read count
	syscall		

	mov rax, SYS_read
	mov rdi, STDIN
	mov rsi, d ; msg address
	mov rdx, 1 ; read count
	syscall


	mov al, [decimal]	
	mov bl, [b]	
	sub bl, 48 		
	mul bl	
	mov [b], al

	mov al, [b]	
	add al, [d]
	sub al, 48
	mov [b], al
	

	; GENERATE OUTPUT

	movsx ax, byte [a]
	mov bl, [b]
	div bl
	mov cl, al
	mov [q], cl
	mov [r], ah

	movsx ax, byte [q] 
	mov bl, [decimal] 
	div bl
	add al, 48
	add ah, 48	
	mov [o1], al
	mov [o2], ah

	mov eax,1
	mov edi,1
	mov edx, 1 
	lea rsi,[o1]
	syscall	

	mov eax,1
	mov edi,1
	mov edx, 1 
	lea rsi,[o2]
	syscall	

	mov eax,1
	mov edi,1
	mov edx, 1 
	lea rsi,[rem]
	syscall	

	movsx ax, byte [r] 
	mov bl, [decimal] 
	div bl
	add al, 48
	add ah, 48	
	mov [o3], al
	mov [o4], ah

	mov eax,1
	mov edi,1
	mov edx, 1 
	lea rsi,[o3]
	syscall	

	mov eax,1
	mov edi,1
	mov edx, 1 
	lea rsi,[o4]
	syscall	
	

	
	;TERMINATE
	mov eax,60
	xor edi, edi
	syscall
