#include<stdio.h>
#include<stdlib.h>
#include<numericalintegration.h>
#include<math.h>

double trapezoidalRule(float a,double b,int N){
	//printf("\nIn trap");
	/* Innitializing local variables */
  	double degdiff,d,externalsum,f=0.0,totalvalue,h,internalarea,val1=0,actualval;
  	int i;
  
 	 
	degdiff = (b-a) / N;	//Span
 	val1= (b - a)/(2*N);
	
 	/*Assigning a default value to the valriables */
 	 d = 0.0;
 	 internalarea=0.0;
  	 
  
  	for(i = 0; i <=N ;i++)
  	{ 
  	   d= i*degdiff;
	if(i==0 || i==N)
		internalarea = internalarea+((sin(d)));
	else
  	   internalarea = internalarea+(2*(sin(d)));       
  	}
	totalvalue = internalarea * val1; //This is the calculated values for the requested interval.
  		
	printf("trapez func %f",totalvalue );
	actualval=2.0; // Calculated mathematically
	printf("\nThe trapezoidalRule for the given interval is :%f and its actual value is: %f",totalvalue,actualval);

	return totalvalue;
}