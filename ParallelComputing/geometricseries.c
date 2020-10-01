#include<stdio.h>
#include<math.h>

int main()
{
	double a=0,r=0;										//Initializing local variables
	float leftval,rightval;

	int i,n=0,j;
	
	for(i=1;i<=3;i++)
	{
		switch(i)										//Switch case loop
		{
			case 1:										
			{
				printf("\n\nCase 1");
				n = 10000;
				a=2.0;
				r=0.01;
				break;
			}
			case 2:
			{
				printf("\n\nCase 2\n");	
				n=500;
				a=0.01;
				r=1.1;
				break;
			}
			case 3:
			{
				printf("\n\nCase 3\n");	
				n=100;
				a=0.0001;
				r=2.0;
				break;
			}
			default:
				break;
		}
		leftval=0.0,rightval=0.0;
		for(j=0;j<=n;j++)								//Loop for calculating the geometric series summation.
		{
			leftval = leftval + (a*(pow(r,j)));
						
		}
		printf("\nCase %d Left value of the given values is: %f ",i,leftval);
		
		/*for(j=0;j<=n;j++)
		{
		
		}*/
			rightval = a*((1-(pow(r,(n+1))))/ (1-r));	//Calculating the geometric series using the formula.
		printf("\nCase %d Right value of the given values is:%f \n ",i,rightval);
		if(leftval==rightval)
			printf("The values from both sides are equal and are calculated with float type precision. ");
				
		
	}
	printf("\n\n The values of second and third case vary based on float and double datatype. Float type takes 6 decimal values where as double datatype takes 15 decimal values.Long double stores upto 19 decimal values.So, when powers of 'r' are calculated, the decimal values differ in middle summation loop rather than in the formula. This results in varying the values of middle summation and formula.Now, after assigning the total value variables of LHS and RHS to float, the calculated values are saved based on the precision and this brings values of both side to be same.\n");	
	return 0;
}
/* ---- Outputs based on the datatypes----
double a=0,r=0;
double leftval,rightval;

Case 1
Case 1 Left value of the given values is: 2.020202
Case 1 Right value of the given values is:2.020202


Case 2

Case 2 Left value of the given values is: 54668261640437096448.000000
Case 2 Right value of the given values is:54668261640437096448.000000


Case 3

Case 3 Left value of the given values is: 253530120045645858089205760.000000
Case 3 Right value of the given values is:253530120045645892448944128.000000
---
float a=0,r=0;
float leftval,rightval;
Case 1
Case 1 Left value of the given values is: 2.020202
Case 1 Right value of the given values is:2.020202


Case 2

Case 2 Left value of the given values is: 54668835236836540416.000000
Case 2 Right value of the given values is:54668839634883051520.000000


Case 3

Case 3 Left value of the given values is: 253530095194192264197832704.000000
Case 3 Right value of the given values is:253530113640936337907384320.000000
---
float a=0,r=0;
double leftval,rightval;
Case 1
Case 1 Left value of the given values is: 2.020202
Case 1 Right value of the given values is:2.020202


Case 2

Case 2 Left value of the given values is: 54668841023872843776.000000
Case 2 Right value of the given values is:54668841023872851968.000000


Case 3

Case 3 Left value of the given values is: 253530113640936337907384320.000000
Case 3 Right value of the given values is:253530113640936337907384320.000000
---
double a=0,r=0;
float  leftval,rightval;
Case 1
Case 1 Left value of the given values is: 2.020202
Case 1 Right value of the given values is:2.020202


Case 2

Case 2 Left value of the given values is: 54668263490790096896.000000
Case 2 Right value of the given values is:54668263490790096896.000000


Case 3

Case 3 Left value of the given values is: 253530113640936337907384320.000000
Case 3 Right value of the given values is:253530113640936337907384320.000000

*/