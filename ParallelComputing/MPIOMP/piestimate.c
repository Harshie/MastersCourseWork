#include<stdio.h>
#include<omp.h>

int main(int argc, char *argv[]){
	float x,y;
	long seed;
	double d,pi;
	double nd=0;
	extern float ran2();
	int i,nprocessors;
	int nt;

	//Declares the local variables and fetches the count of threads required.
	printf("\n Enter the number of threads: ");
	scanf("%d",&nprocessors);
	
	//Feches the total number of Iterations required for this estimation.
	printf("\n Enter the total number of iterations required: ");
	scanf("%d",&nt);

	/*The loop begins with parallel processing. Here the variables x,y,d,i,seed are used privately
	 by each thread to avoid race condition and calculates the values individually. 
	Finally these values are being used for updating the 'nd' variable which is done 
	by the threads one after the other using critical clause.*/
		
	#pragma omp parallel for private(x,y,d,i,seed) shared(nd) num_threads(nprocessors)
	for(i=0;i<nt;i++){	
			x= ran2(&seed);
			y= ran2(&seed);		
			d=x*x + y*y;
			if(d<=1)
				{
					#pragma omp critical
					nd=nd+1;
				}
	}
	//These values are then used for estimating Pi.

	printf("\n nd value is %.15f and nt value is %d ",nd,nt);
	pi = (nd/nt)*4;
	printf("\n Pi estimate is %f \n",pi);	
}

/*---------OP----------
[sp227@sciprog Assignment1]$  gcc -lm  ran2.c piestimate.c -o piestimation -fopenmp
[sp227@sciprog Assignment1]$ ./piestimation 

OP1
Enter the number of threads: 4

 Enter the total number of iterations required: 200000

 nd value is 157074.000000000000000 and nt value is 200000
 Pi estimate is 3.141480

OP2
 Enter the number of threads: 1

 Enter the total number of iterations required: 200000

 nd value is 157072.000000000000000 and nt value is 200000
 Pi estimate is 3.141440

OP3
 Enter the number of threads: 2

 Enter the total number of iterations required: 200000

 nd value is 157178.000000000000000 and nt value is 200000
 Pi estimate is 3.143560

-So the iteration upto 200000 brings the pi value close to 3.14 in this algorithm. 
-The value of this estimation slightly vary with the number of threads as the seed 
are repeated sometimes randomly. The seed of one parallel PRAGMA is sometimes used 
by another PRAGMA which opts for same random values with increase in thread count 
and hence slightly changes the estimation. 
 */

