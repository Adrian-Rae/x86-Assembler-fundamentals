SECTION .DATA
	numWords	equ	0
	lengthWord 	equ	8
	firstElement	equ	16
	secondElement	equ	24
	innerIndex		equ 32
	outerIndex		equ 40
	a		db	"HELLO",0x0
	b		db	"CHEER",0x0
	true		db	"TRUE",0x0
	false		db	"FALSE",0x0
	debug		db	"D",0x0
SECTION .TEXT
	extern swapWords
	GLOBAL sort
	GLOBAL ordered

;============================================
;		SORT FUNCTION
;============================================	
sort:
	push rbp
	mov rbp, rsp
	
	sub rsp, 56; assign space
	mov [rsp+numWords], rsi; the numwords
	mov [rsp+lengthWord], rdx; the length of a word
	
	mov r12, rdi;save temp

	mov rcx, 0
	mov [rsp+outerIndex], rcx
outerLoop:
	mov rcx, [rsp+outerIndex]
	mov rdx, [rsp+numWords]
	dec rdx
	cmp rcx, rdx
	je endOuterLoop


	mov rcx, [rsp+outerIndex]
	inc rcx
	mov [rsp+innerIndex], rcx
innerLoop:
	mov rcx, [rsp+innerIndex]
	mov rdx, [rsp+numWords]
	cmp rcx, rdx
	je endInnerLoop

;================ INNER CONTENT ===================

	;get index of first and second word
	mov rdi, [rsp+innerIndex]; n-th word
	mov rsi, [rsp+lengthWord]; length
	call calcWordIndex
	mov [rsp+firstElement], rax

	mov rdi, [rsp+outerIndex]; m-th word
	mov rsi, [rsp+lengthWord]; length
	call calcWordIndex
	mov [rsp+secondElement], rax


	mov r13, r12
	add r13, [rsp+firstElement]

	mov r14, r12
	add r14, [rsp+secondElement]

	mov rdi, r13
	mov rsi, r14
	mov rdx, [rsp+lengthWord]
	call ordered

	cmp rax, 0
	je noMove

	mov rdi, r12
	mov rsi, [rsp+innerIndex]
	mov rdx, [rsp+outerIndex]
	mov rcx, [rsp+lengthWord]
	call swapWords

	mov r12, rax

	jmp endSort

noMove:
endSort:

;================ END INNER CONTENT ===================

	mov rcx, [rsp+innerIndex]
	inc rcx
	mov [rsp+innerIndex], rcx
	jmp innerLoop
endInnerLoop:

	mov rcx, [rsp+outerIndex]
	inc rcx
	mov [rsp+outerIndex], rcx
	jmp outerLoop
endOuterLoop:
	
	mov rax, r12
	leave
	ret

;============================================
;		COMP FUNCTION
;============================================	
ordered: ;checks to see if parameter x<=y of length n in ordered(x,y,n):boolean;

	push rbp
	mov rbp, rsp
	
	mov rcx, 0
	mov rax, 1; ordered by default

	mov r8b, [rdi]
	mov r9b, [rsi]
	cmp r8b, r9b
	jl endComp; if ordered, return true
	
	mov rax, 0

endComp:

	leave
	ret

;============================================
;		CALC INDEX FUNCTION
;============================================	

calcWordIndex: ;calculateIndexOfWord(int elementNumber, int lengthOfWord)

	mov rcx, rsi
	inc rcx
	mov rax, rdi
	mul ecx
	;result already in eax
	ret