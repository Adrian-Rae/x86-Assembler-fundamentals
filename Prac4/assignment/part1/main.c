#include <stdio.h>
#include <stdlib.h>

extern char* swapLetters(char* word, int a, int b);

int main()
{    
	char string[] = "A X Z Y D C";
	printf("Before swapLetters: \t%s\n", string);
	char* result = swapLetters(string, 2, 10);
	printf("After swapLetters : \t%s\n", result);
	
    return 0;
}

