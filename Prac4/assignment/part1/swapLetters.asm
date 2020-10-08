SECTION .DATA
	
SECTION .TEXT
	GLOBAL swapLetters

swapLetters: ;swapLetters(char*, int, int)
	mov r13b, [rdi+rsi]
	mov r14b, [rdi+rdx]
	mov [rdi+rsi], r14b
	mov [rdi+rdx], r13b
	mov rax, rdi
	ret

