#include<stdio.h>
#include<omp.h>

void main(int argc, char *argv[])
{

	double w[100][100],wnew[100][100];
	int i,j,iteration=0,nprocessors;
	double diffval,k=0;
	double wdiff[10000];
	double maxdiff=0.0;
	double start,end;
	
	diffval = 1.0/10000;
	/* The declarations are done and the thread count is fetched to a local variable.*/
	printf("\n Enter the number of threads: ");
	scanf("%d",&nprocessors);
	/* Time calculations starts */
	start= omp_get_wtime();
	
	/*Initialization of the main array with values mentioned in the question.*/
	#pragma omp parallel for private(j) num_threads(nprocessors)
	for(i=0;i<100;i++)
		for(j=0;j<100;j++){
			if(i==0 && j>0 && j<99){
			w[i][j]=0.0; 
			wnew[i][j]=0.0;
			}
			else if(i==99 && j>=0){
				w[i][j]=100.0;
				wnew[i][j]=100.0;
			}
			else if(i>=0 && j==0){
					w[i][j]=100;
					wnew[i][j]=100;
			}
			else if(i>=0 && j==99){
					w[i][j]=100;
					wnew[i][j]=100;
			}
			else if(i>=1 && i<99 && j>=1 && j<99){
				w[i][j]=75.0;
				wnew[i][j]=75.0;
			}
	

	}
	/* Loop begins*/	
	do
	{
	maxdiff=0;

	/* Calculating the values of new array using the formula provided.*/
	#pragma omp parallel for private(j) num_threads(nprocessors)
	for(i=1;i<99;i++){
		for(j=1;j<99;j++){
			wnew[i][j]=(w[i+1][j] + w[i-1][j] + w[i][j+1] + w[i][j-1])/4;
		
		}
	}
	
	/* Difference calculation and assigning the maximum differnce value to maxdiff variable.*/
	#pragma omp parallel for num_threads(nprocessors) private(j,k)
	for(i=1;i<99;i++){
		for(j=1;j<99;j++){
			
			
		
				k=w[i][j] - wnew[i][j];
				
				/*Condition for getting absolute value*/
				if(k<0){
					wdiff[j-1] = (-1)*k;
				}
				else{
					wdiff[j-1] = k;
				}
			
				if(wdiff[j-1]>maxdiff){
				
					maxdiff=wdiff[j-1];
			
				}
			
		}
	}
	
	/*Stopping the loop if maximum difference is less than the diff value*/
	if(maxdiff < diffval){
		printf("\n maxdiff value in break %.15f \n",maxdiff);
		break;
	}
	
	/*Updating the main array if maximum difference is greater than the diff value*/
	#pragma omp parallel for private(j) num_threads(nprocessors)
	for(i=0;i<100;i++){
		for(j=0;j<100;j++){
			w[i][j]=wnew[i][j];
		}
		
	}	
	
	/* Counting the iterations*/
	iteration=iteration+1;

	
	}while(maxdiff>diffval);
		
	printf("\n Iterations %d \n",iteration);
	/* Time calculations ends */
	end= omp_get_wtime();	

    	printf("\nTime taken: %f seconds \n",end-start);
}

/* 
-------OP----------
[sp227@sciprog Assignment1]$ gcc -lm -o parallelarray parallelarray.c -fopenmp

OP1
[sp227@sciprog Assignment1]$ ./parallelarray

 Enter the number of threads: 4

 maxdiff value in break 0.000099895886486

 Iterations 4776

Time taken: 1.228336 seconds
-------
OP2
[sp227@sciprog Assignment1]$ ./parallelarray

 Enter the number of threads: 2

 maxdiff value in break 0.000099895886486

 Iterations 4776

Time taken: 0.751500 seconds
-------
OP3
[sp227@sciprog Assignment1]$ ./parallelarray

 Enter the number of threads: 1

 maxdiff value in break 0.000099895886486

 Iterations 4776

Time taken: 0.775060 seconds
--------
OP4-serial code output
[sp227@sciprog Assignment1]$ gcc -lm -o serialarray serialarray.c -fopenmp
[sp227@sciprog Assignment1]$ ./serialarray

 maxdiff value in break 0.000099895886486

 Iterations 4776

Time taken: 0.696812 seconds
---------
So the time taken for this exercise with 1,2,4 threads and with serial code in seconds are 0.775060, 0.751500,1.228336,0.696812 respectively.

Serial Time = 0.696812
|=======================================================================|
|Threads	     	 |   1			| 	2	    |	4	                |
|=======================================================================|
|Relative Speedup    |	 1			|	1.03	|	0.63	            |
|Absolute Speedup    |	0.89		|	0.92	|	0.56               	|
|Efficiency Relative |	 1			|	0.51	|	0.157	            |	
|Efficiency Absolute |	0.89		|	0.46	|	0.14				|
|=======================================================================|

CALCULATIONS
------------
Relative Speedup
Sr(p) = Tpar(1)/Tpar(p)

Sr(1) = Tpar(1)/Tpar(1)
      = 0.775060/0.775060
      = 1

Sr(2) = Tpar(1)/Tpar(2)
      = 0.775060/0.751500
      = 1.03

Sr(4) = Tpar(1)/Tpar(4)
      = 0.775060/1.228336
      = 0.63

-----------------
Absolute Speedup
Sa(p) = Tseq/Tpar(p)

Sa(1) = Tseq/Tpar(1)
      = 0.696812/0.775060
      = 0.89

Sa(2) = Tseq/Tpar(2)
      = 0.696812/0.751500
      = 0.92

Sa(4) = Tseq/Tpar(4)
      = 0.696812/1.228336
      = 0.56

----------
Efficiency
Er(p) = Sr(p)/p

Er(1) = Sr(1)/1
      = 1/1
      = 1

Er(2) = Sr(2)/2
      = 1.03/2
      = 0.51

Er(4) = Sr(4)/4
      = 0.63/4
      = 0.157


Ea(p) = Sa(p)/p

Ea(1) = Sa(1)/1
      = 0.89/1
      = 0.89

Ea(2) = Sa(2)/2
      = 0.92/2
      = 0.46

Ea(4) = Sa(4)/4
      = 0.56/4
      = 0.14
---------------
*/
