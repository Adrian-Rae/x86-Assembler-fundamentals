#include <stdio.h>
#include <stdlib.h>

extern char* swapWords(char string[], int element1, int element2, int wordSize);

int calculateIndexOfWord(int elementNumber, int lengthOfWord)
{
	return elementNumber*(lengthOfWord+1);
}

int main(int argc, char** argv)
{
	char biggerWords[] = "ELEPHANT ABSOLUTE SUPPOSED WITHDRAW";
    
	printf("Before swapWords:\t%s\n", biggerWords);
	char * result = swapWords(biggerWords, 0, 3, 8); //Should give: "ABSOLUTE ELEPHANT SUPPOSED WITHDRAW"
	printf("After swapWords:\t%s\n", result);
    
    return 0;
}
