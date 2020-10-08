main.o:
	yasm -f elf64 -g dwarf2 -l main.lst main.asm
	ld -o main main.o
	
run: main.o
	./main
	
clean:
	rm *.o *.lst main *.tar
	
tar:
	tar -cvz -f Prac2.tar makefile main.asm
	
all:
	make clean
	make 
	make tar
	make run
