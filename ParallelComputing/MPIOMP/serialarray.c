#include<stdio.h>
#include<omp.h>
/*Program for serial computations*/

void main(int argc, char *argv[])
{

	double w[100][100],wnew[100][100];
	int i,j,iteration=0,nprocessors;
	double diffval,k=0;
	double wdiff[10000];
	double maxdiff=0.0;
	double start,end;
	
	diffval = 1.0/10000;
	/* The declarations are done and Time calculations starts */

	start= omp_get_wtime();

	/*Initialization of the main array with values mentioned in the question.*/
	//#pragma omp parallel for private(j) num_threads(nprocessors)
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
	//#pragma omp parallel for private(j) num_threads(nprocessors)
	for(i=1;i<99;i++){
		for(j=1;j<99;j++){
			wnew[i][j]=(w[i+1][j] + w[i-1][j] + w[i][j+1] + w[i][j-1])/4;
		
		}
	}
	
	/* Difference calculation and assigning the maximum differnce value to maxdiff variable.*/
	//#pragma omp parallel for num_threads(nprocessors) private(j,k)
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
	//#pragma omp parallel for private(j) num_threads(nprocessors)
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
serial code output
[sp227@sciprog Assignment1]$ gcc -lm -o serialarray serialarray.c -fopenmp
[sp227@sciprog Assignment1]$ ./serialarray

 maxdiff value in break 0.000099895886486

 Iterations 4776

Time taken: 0.696812 seconds
*/
