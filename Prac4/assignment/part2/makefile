a.out: main.o swapWords.o
	gcc main.o swapWords.o -o a.out -g -m64 -static

main.o: main.c
	gcc -c main.c -g -m64

swapWords.o: swapWords.asm
	yasm -f elf64 -g dwarf2 swapWords.asm -o swapWords.o

run: a.out
	./a.out
	
all:
	make clean
	make
	make run
tar:
	tar -cvz -f swapWords.tar main.c makefile swapWords.asm
	
clean: 
	rm -rf *.o a.out
