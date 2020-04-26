#include<stdio.h>
#include<math.h>
#include<stdlib.h>
#include<numericalintegration.h>

int main(){
	int n,interval,selection,i;
	int a1[]={2,8,16,64};
	double trep[3],simp[3],gauss[3], b;
	float a;
	
	a = 0;
  	b = M_PI;  //M_PI=3.14
  	
	printf("\nEnter the intervals: ");
	scanf("%d",&interval);
	printf("The curve of the given function can be calculated using three different rules listed below. Please select the desired rule by mentioning the rule number:\n 1.Trapezoidal Rule\n 2.Simpson's Rule\n 3.Gauss Quadrature\n Enter the rule number: ");
	scanf("%d",&selection);
	//Calling the function based on the selection.
	if(selection == 1){
		trapezoidalRule(a,b,interval);
		}
	if(selection == 2){
		simpsonrule(a,b,interval);
		
	}
	if(selection == 3){
		gaussquadrature(a,b);
		
	}
	
	//Switch can also be used to call the function instead of If condition.
	/*switch(n)
	{
		case 1: trapezoidalRule(a,b,interval);
				break;
		case 2: simpsonrule(a,b,interval);
				break;
		case 3: gaussquadrature(a,b);
				break;
		default:printf("You have not selected any of the three rule.");		
				break;		
	}*/
	//The below code can be used for calculating all the interval range values in a block.
	//interval values: n ={2,8,16,64}
	/*for(i=0;i<4;i++){
		interval=a1[i];
		trep[i]= trapezoidalRule(a,b,interval);
		simp[i]=simpsonrule(a,b,interval);
		gauss[i]=gaussquadrature(a,b);
	}
	printf("\n Results of all methods for the following interval values: n ={2,8,16,64}:\n");
	printf("Trapezoidal\t\t SimpsonRule\t\t Gauss Quadrature\n");
	for(i=0;i<4;i++){
		printf("%f\t\t %f\t\t %f\n",trep[i],simp[i],gauss[i]);
	}*/
	return 0;
		
	
}
/*
----- SAMPLE OUTPUT-----
[sp15@sciprog assignment2]$ make
gcc -c -lm -o mainfunc.o mainfunc.c -I.
gcc -c -lm -o trepezoidal.o trepezoidal.c -I.
gcc -c -lm -o gaussquadrature.o gaussquadrature.c -I.
gcc -c -lm -o simpson.o simpson.c -I.
gcc -lm -o area mainfunc.o trepezoidal.o gaussquadrature.o simpson.o -I.
[sp15@sciprog assignment2]$ ./area

Enter the intervals: 4
The curve of the given function can be calculated using three different rules listed below. Please select the desired rule by mentioning the rule number:
 1.Trapezoidal Rule
 2.Simpson's Rule
 3.Gauss Quadrature
 Enter the rule number: 1
trapez func 1.896119
The trapezoidalRule for the given interval is :1.896119 and its actual value is: 2.000000
 The value of Trapezoidal Rule is: 1.000000[sp15@sciprog assignment2]$
---
TABULAR VALUES FOR n ={2,8,16,64}

		{4}             {8}             {16}            {64}
 Trapezoidal    1.896119        1.974231        1.993571        1.999599
 Simsons        2.004560        2.000269        2.000017        2.000000
 Gaussian       1.935820        1.935820        1.935820        1.935820

So, the values for the corresponding rules are approximately vary with the actual values. This can be due to increase in intervals. Also, due to decimal precision, the values can vary.
*/