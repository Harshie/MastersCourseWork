#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#include<numericalintegration.h>
double gaussquadrature(float a,double b){
	//printf("\nIn Gauss");  //For debugging
	float h,k,totalvalue=0,actualval=0,diff=0;
	
  	h = (b-a)/2;
  	k=a + h;
  	
  	totalvalue = h*(sin(k - h/(sqrt(3))) + sin(k + h/(sqrt(3))));   //The total value is computed with required sin values for range 0 ,PI.
	actualval=2.0; // Calculated mathematically
	printf("\nThe gaussquadrature value for the given interval is :%f and its actual value is: %f",totalvalue,actualval);
	
	return totalvalue;
	
}