segment .data
	SYS_read: equ 0
	STDIN: equ 0
	inDigit: db 0
	a: db 0
	b: db 0
	m: db 0
	n: db 0
	p: dd 0
	q: dd 0
	space: db " "
	negative: db 0
	first: db 1
	newLine: db 0xA

segment .text
	global _start
_start:

	mov r14, 0; the first number
	mov r15, 0; the second number
	
; Read in the first number 

	mov r15, 0; the dinkham number
	mov r8, 0; the counter
	mov r9, 0; the buffer	
d1:	
	;read in a digit	
	mov rax, SYS_read
	mov rdi, STDIN
	mov rsi, inDigit ; msg address
	mov rdx, 1 ; read count
	syscall	


	;if its a negative, set the flag
	mov r10, 45
	cmp r10b, [inDigit]
	jne buffer
	mov r13,1
	mov [negative], r13 ;the number is negative
	jmp d1

buffer:

	;if its the foreign char, end
	mov r10, [inDigit]
	cmp r10, 57
	jg ed1
	cmp r10, 48
	jl ed1
	
	;mov r10, 48
	;cmp r10, [inDigit]
	;jg ed1
	;mov r10, 57
	;cmp r10, [inDigit]
	;jl ed1

	;else add it to the buffer
	shl r9, 8
	mov r9b, [inDigit]
	sub r9b, 48
	inc r8
	
	jmp d1; repeat
ed1:
	;now work with the logic
	mov r10, 0 ; number
	mov r11, 1 ;order of magnitude
f1:
	mov al, r9b; current digit
	shr r9, 8; remove from buffer
	mov r12, r11
	mul r12
	add r10d, eax

	mov eax, r11d
	mov r12, 10
	mul r12
	mov r11d,eax
	
	cmp r9, 0
	jne f1	
ef1:
	mov r14,r10
	
	mov r13, [negative]
	cmp r13,1
	jne skip1
	neg r14
	mov r13,0
	mov [negative], r13

skip1:
	

; Read in the second number 

	mov r15, 0; the dinkham number
	mov r8, 0; the counter
	mov r9, 0; the buffer	
d2:	
	;read in a digit	
	mov rax, SYS_read
	mov rdi, STDIN
	mov rsi, inDigit ; msg address
	mov rdx, 1 ; read count
	syscall	

	;if its a negative, set the flag
	mov r10, 45
	cmp r10b, [inDigit]
	jne buffer2
	mov r13,1
	mov [negative], r13 ;the number is negative
	jmp d2

	

buffer2:

	;if its the foreign char, end
	mov r10, [inDigit]
	mov r10, [inDigit]
	cmp r10, 57
	jg ed2
	cmp r10, 48
	jl ed2

	;mov r10, 48
	;cmp r10, [inDigit]
	;jg ed2
	;mov r10, 57
	;cmp r10, [inDigit]
	;jl ed2

	;else add it to the buffer
	shl r9, 8
	mov r9b, [inDigit]
	sub r9b, 48
	inc r8
	
	jmp d2; repeat
ed2:
	;now work with the logic
	mov r10, 0 ; number
	mov r11, 1 ;order of magnitude
f2:
	mov al, r9b; current digit
	shr r9, 8; remove from buffer
	mov r12, r11
	mul r12
	add r10d, eax

	mov eax, r11d
	mov r12, 10
	mul r12
	mov r11d,eax
	
	cmp r9, 0
	jne f2	
ef2:
	mov r15,r10
	mov r13, [negative]
	cmp r13,1
	jne skip2
	mov r13,0
	mov [negative],r13
	neg r15

skip2:


; do the stuff

	xor rax, rax
	xor rcx, rcx
	xor r8, r8	;this is m
	xor r9, r9      ;this is n
	xor r10, r10	;this is n-m
	xor r11, r11 	;temp a	
	xor r12, r12	;temp b	
	xor r13, r13
	

	; m=0
	;initilise first
	mov r10, 1
	mov [first],r10
	xor r10, r10	
while:
	
	

	;n = b & 1
	mov r9b, r15b
	and r9b, 1

	cmp r14, 0
	je calc

	;if n=1 and m=0 print -a
	mov r10b, r9b
	sub r10b, r8b ;n-m

	cmp r10b, 0
	je calc	
	

skipped:
	
	cmp r10b, 1
	jl elseif

k1:
	mov r10, 0
	mov [first], r10

	mov rbx, 0 
	mov r12, r14
	neg r12
for1:
	cmp rbx,32
	jge efor1

	mov r13, r12
	mov r11, 1
	shl r11, 31
	and r13, r11
	shr r13, 31
	add r13, 48

	mov [p], r13

	mov eax,1
	mov edi,1
	mov edx, 1 
	lea rsi, [p]
	syscall 

	shl r12, 1	
	inc rbx
	jmp for1

efor1:
	
	jmp endif
	
	
	;else if n=0 and m=1 print a
elseif:
	;cmp r14, 0
	;jmp endif

k2:

	mov rbx, 0 
	mov r12, r14
for2:
	cmp rbx,32
	jge efor2

	mov r13, r12
	mov r11, 1
	shl r11, 31
	and r13, r11
	shr r13, 31
	add r13, 48

	mov [p], r13

	mov eax,1
	mov edi,1
	mov edx, 1 
	lea rsi, [p]
	syscall 

	shl r12, 1	
	inc rbx
	jmp for2

efor2:
	jmp endif
	

endif:
	mov eax,1
	mov edi,1
	mov edx, 1 
	lea rsi, [space]
	syscall
	
calc:

	;a *= 2
	shl r14, 1
	
	;m=n
	mov r8b, r9b

	;if b is 0 break
	cmp r15, 0
	je ewhile

	;else right b shift by 1
	shr r15, 1
	
	jmp while
ewhile:
			
	;TERMINATE
	mov eax,60
	xor edi, edi
	syscall
