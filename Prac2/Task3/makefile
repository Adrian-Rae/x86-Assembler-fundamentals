task3.o:
	yasm -f elf64 -g dwarf2 -l task3.lst task3.asm
	ld -o task3 task3.o
	
run: task3.o
	./task3
	
clean:
	rm *.o *.lst task3 *.tar
	
tar:
	tar -cvz -f Prac2task3.tar makefile task3.asm
	
all:
	make clean
	make 
	make tar
	make run
