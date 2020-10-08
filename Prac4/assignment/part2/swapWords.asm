SECTION .DATA
	a: db 0
	b: db 0
SECTION .TEXT
	GLOBAL swapWords
	extern calculateIndexOfWord
swapWords: ;swapWords(char*, int, int, int)
	;rdi has string, rsi first index, rdx second index, rcx the word length
	
	push rbp
	mov r12, rdi; the string
	mov r13, rsi; the 1st index
	mov r14, rdx; the 2nd index
	mov r15, rcx; the length
	
	mov rdi, r13; the 1st word index
	mov rsi, r15; length of words
	call calculateIndexOfWord
	
	mov r13, rax; now stores index of 1st word
	
	mov rdi, r14; the 2nd word index
	mov rsi, r15; length of words
	call calculateIndexOfWord
	
	mov r14, rax; now stores index of 2nd word
	
	mov rcx, 0
for:
	cmp rcx, r15
	je efor
	mov dl, [r12+r13]
	mov al, [r12+r14]
	mov [r12+r13], al
	mov [r12+r14], dl
	inc r13
	inc r14
	inc rcx
	jmp for;
efor:


	mov rax, r12
	
	pop rbp
	ret

