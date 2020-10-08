task2.o:
	yasm -f elf64 -g dwarf2 -l task2.lst task2.asm
	ld -o task2 task2.o
	
run: task2.o
	./task2
	
clean:
	rm *.o *.lst task2 *.tar
	
tar:
	tar -cvz -f Prac2task2.tar makefile task2.asm
	
all:
	make clean
	make 
	make tar
	make run
