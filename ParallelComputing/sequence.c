#include <stdio.h>
#include <stdlib.h>
#define MAXSIZE 1000
int a[MAXSIZE];										//Defining the array as global & Initializing the size of array
int sequence(int n); 								//Defining the function

int sequence(int n)
{
	int i,looplength;
	for(i=1;n > 1;i++)
    {
      if(n%2==0)
        n = n/2;
      else
        n = 3 * n + 1;  
      a[i] = n;
      looplength = i + 1;
      if(i>2)
      {
      	if(a[i-2]==4 && a[i-1]==2 && a[i]==1)		//logic for terminating the loop after 4,2,1 value in the array.
      	break;
	  }
    }
    return looplength;
}
int main()
{
    int n,b,j,k,c=0,d=0,e=0;
    
    printf("Enter the value: ");
    scanf("%d", &n);
    
    a[0]=n;
	if(n==1)
	{
		printf("%d, \n",n);							// If the number is 1,it is printed directly & exits. For value 2, it will print 2, 1, and will terminate loop 	automatically. 
		exit(0);
	}
	
	b = sequence(n);								//Calling Sequence function. 
    
    for(j=0;j<b;j++)
    {
        c=a[j];
       
        for(k=0;c>0;k++)							//Loop for counting the space.
        {
            c=c/10;
                   
            d= k+1;
                   
            
        }
        
		if((e+d+2)>40)								//Condition statements for adding new after 40 characters
		{
			printf("\n");
			printf("%d, ",a[j]);
        	e = d+2;
		}
		else
		{
		   	printf("%d, ",a[j]);
        	e=e+d+2;
		}
	}
	printf("\n");

    return 0;
}

/* ----- Sample Output-----
Enter the value: 70
70, 35, 106, 53, 160, 80, 40, 20, 10,
5, 16, 8, 4, 2, 1,

*/