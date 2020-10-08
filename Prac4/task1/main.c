#include <stdio.h>
#include <stdlib.h>

extern int64_t countWords(char* word, int length);

int main()
{    
	char c[44] = "the quick brown fox jumps over the lazy dog";
	int64_t num = countWords(c,44);
	
	printf("%ld", num);
	
    return 0;
}



