a.out: main.o sort.o
	gcc main.o sort.o -o a.out -g -m64 -static

main.o: main.c
	gcc -c main.c -g -m64

sort.o: sort.asm
	yasm -f elf64 -g dwarf2 sort.asm -o sort.o

run: a.out
	./a.out
	
all:
	make clean
	make
	make run
tar:
	tar -cvz -f sort.tar main.c makefile sort.asm
	
clean: 
	rm -rf *.o a.out
