SECTION .DATA
SECTION .TEXT
	GLOBAL countWords

countWords: ;countWords(char*, int)
	mov rcx, 0
	mov r11, 1
for:
	cmp rcx, rsi 
	je efor
	
	mov al, [rdi+rcx]
	cmp al, 32
	jne skip
	inc r11
skip:
	inc rcx
	jmp for
efor:
	cmp rcx,0
	jne final
	mov r11,0
final:
	mov rax, r11
	ret
