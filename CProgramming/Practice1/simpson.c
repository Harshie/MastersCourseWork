#include<stdio.h>
#include<stdlib.h>
#include<numericalintegration.h>
#include<math.h>
float simpsonrule(float a,double b,int N){
	//printf("\nIn Simp");  // For debugging purpose
	float externalsum,totalvalue,h,f,eveninterval=0,oddinterval=0,internalarea,actualval;
  	int i;
  
 	
  	h=(b-a)/N;
	//Condition for checking if the interval is EVEN.
	if(N%2!=0){
		printf("The entered interval is not even. So the function is being terminated.");
		exit(0);
	}
 	
	 
 
 	/*Assigning a default value to the valriables */
 	
 	 internalarea=0.0;
  	
  
  	for(i = 1; i < N ;i++)
  	{ 
  	   
		if(i%2==0)
  	   eveninterval = eveninterval+(2*(sin(a+ i*h)));
		 else
		oddinterval = oddinterval+(4*(sin(a+ i*h)));        
  	}
  	internalarea=eveninterval+oddinterval;
 	
	externalsum = sin(a) + sin(b);
  	f = externalsum + internalarea;
  	
  	totalvalue = f*(h/3);
	actualval=2.0; // Calculated mathematically
	printf("\nThe simpsonrulevalue for the given interval is :%f and its actual value is: %f",totalvalue,actualval);
  	
  
return totalvalue;	
}
