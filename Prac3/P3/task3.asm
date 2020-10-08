segment .data
	SYS_read: equ 0
	STDIN: equ 0
	LF equ 10

	decimal: db 10

	sIn1: db "Please input a number: ",0x0a

	a: db 0
	b: db 0

	sol: dd 0

	digit: db 0
	subt: dd 0

segment .text
	global _start
_start:
	
		
	mov eax,1
	mov edi,1
	mov edx, 23 
	lea rsi,[sIn1]
	syscall	

	mov rax, SYS_read
	mov rdi, STDIN
	mov rsi, a ; msg address
	mov rdx, 1 ; read count
	syscall		

	mov rax, SYS_read
	mov rdi, STDIN
	mov rsi, b ; msg address
	mov rdx, 1 ; read count
	syscall

	mov al, [decimal]	
	mov bl, [a]	
	sub bl, 48 		
	mul bl	
	mov [a], al

	mov al, [a]	
	add al, [b]
	sub al, 48
	mov [a], al		

	;GOTTEN A as a number
	;will use the explicit formula 2^a-1
	mov cl, 1
	mov [sol], cl	
while:
	cmp cl, [a]
	jg ewhile
	mov eax, [sol]	
	mov r8, 2
	mul r8
	mov [sol],eax
	inc cl
	jmp while
ewhile:
	mov eax, [sol]
	dec eax
	mov [sol], eax	
	;sol stores explicit solution


digitLoop:
	mov r15, [sol]
	cmp r15, 10
	jl display
	
	mov [digit], r15
	mov r12, 0
tenDiv: 		
	mov r13, [digit]	
	cmp r13, 10
	jl etenDiv
	mov eax, [digit]
	mov r8, 10
	div r8
	mov [digit], eax
	inc r12	
	jmp tenDiv
etenDiv:		
	mov bl, [digit]
	add bl, 48
	mov [digit], bl
	
	mov eax,1
	mov edi,1
	mov edx, 1 
	lea rsi,[digit]
	syscall

	mov r14, 0
	mov eax, [digit]
	sub eax,48
removal:
	cmp r14, r12
	je eremoval	
	mov r10, 10
	mul r10
	mov [subt], eax
	inc r14
	jmp removal
eremoval:
	mov r13, [sol]
	sub r13, [subt]
	mov [sol], r13
	jmp digitLoop

	
		

display:
	mov bl, [sol]
	add bl, 48
	mov [sol], bl
	
	mov eax,1
	mov edi,1
	mov edx, 1 
	lea rsi,[sol]
	syscall
			
	;TERMINATE
	mov eax,60
	xor edi, edi
	syscall
