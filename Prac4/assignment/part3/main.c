#include <stdio.h>
#include <stdlib.h>


extern char* sort(char string[], int numberOfWords, int lengthOfWord);
char* swapWords(char string[], int element1, int element2, int wordSize){
	int p1 = element1*(wordSize+1);
	int p2 = element2*(wordSize+1);

	for(int i=0; i<wordSize; i++){
		char temp = string[p1+i];
		string[p1+i] = string[p2+i];
		string[p2+i] = temp;
	}

	return string;

}
int main(int argc, char** argv)
{
	char words[] = "four fore jump leap just knee knew knot when what";
	printf("Before sort: \t%s\n",words);
	char* result = sort(words, 10, 4);
	printf("After sort : \t%s\n", result);
    
    return 0;
}
