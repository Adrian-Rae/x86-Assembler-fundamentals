task1.o:
	yasm -f elf64 -g dwarf2 -l task1.lst task1.asm
	ld -o task1 task1.o
	
run: task1.o
	./task1
	
clean:
	rm *.o *.lst task1 *.tar
	
tar:
	tar -cvz -f Prac2Task1.tar makefile task1.asm
	
all:
	make clean
	make 
	make tar
	make run
