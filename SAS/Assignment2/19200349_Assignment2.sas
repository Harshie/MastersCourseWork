/*Creating a parmenant library*/
%let path=C:\Users\ehars\Documents\UCD\SAS\Assignment2; /*Insert your own path here*/
libname assign "&path";

proc import
DATAFILE='C:\Users\ehars\Documents\UCD\SAS\Assignment2\Assignment 2.csv'
out =  assign.lipidchallenge
DBMS=csv
replace;
run;

/* Runing default Print statement to verify if the dataset is loaded correctly. The dataset is loaded using assign.lipidchallenge to its data block.

proc print data=assign.lipidchallenge;
run;  */

/* The contents of the data set descriptor information variables is seen using the below commands 
proc contents data=assign.lipidchallenge;
	run; */

/*Numeric Descriptive Statistics*/
proc univariate data=assign.lipidchallenge;
	var AGE ApoA1 ApoB ApoC2 ApoC3 ApoE BMI Chol Glucose
	    Insulin NEFA SEX TAG;
run;

/*Counting male and female participants*/
ods select Frequencies;
proc univariate data=assign.lipidchallenge freq;
 var SEX;
run;


/*Checking the insulin level based on gender*/
proc sort data=assign.lipidchallenge out=work.insulin;
by SEX;
run;
proc univariate data=work.insulin;
by SEX;
var Insulin;
run;

/*Checking the confidence interval of BMI*/
/* The table nameBasic Intervals is found using the 'ods trace on'and 'ods trace off;
' commands. */
ods select BasicIntervals;
proc univariate data=work.insulin cibasic;
by SEX;
var BMI;
run;

/*Plotting to check the distribution of BMI variable*/
proc univariate data=assign.lipidchallenge noprint;
histogram BMI/ normal;
inset n normal(ksdpval) / pos = ne ;
run;  

/*Graphical representation of Insulin values by gender*/
proc univariate data=assign.lipidchallenge noprint;
class SEX;
histogram Insulin ;
run;

/*Graphical representation of AGE using qqplot*/
proc univariate data=assign.lipidchallenge noprint
normal;
 qqplot AGE / normal;
run;


/*Q2- Creating the average of dataset due to repeated measurements and then finding the correlation*/
proc summary data=assign.lipidchallenge;
var BMI ApoA1 ApoB ApoC2 ApoC3 ApoE Glucose NEFA Insulin Chol TAG ;
by ID;
output out=avg_dataset mean(BMI)=avg_BMI mean(ApoA1)=avg_ApoA1 mean(ApoB)=avg_ApoB mean(ApoC2)=avg_ApoC2 mean(ApoC3)=avg_ApoC3 mean(ApoE)=avg_ApoE
						mean(Glucose)=avg_Glucose mean(NEFA)=avg_NEFA mean(Insulin)=avg_Insulin mean(Chol)=avg_Chol mean(TAG)=avg_TAG;
run;

proc corr data=avg_dataset;
var avg_ApoA1 avg_ApoB avg_ApoC2 avg_ApoC3 avg_ApoE avg_Glucose avg_NEFA avg_Insulin avg_Chol avg_TAG;
run;

/*Scatter plot of correlation*/
proc corr data=avg_dataset nomiss plots=matrix(histogram);
 var  avg_ApoC2 avg_ApoC3 avg_Chol avg_TAG ;
run;


/* Q3 - Partial correlation between Glucose and Insulin, adjusting for BMI*/
ods select PartialPearsonCorr;
proc corr data=work.avg_dataset;
var avg_Glucose avg_Insulin;
Partial avg_BMI;
run;


/*Scatter plot of correlation*/

proc corr data=work.avg_dataset nomiss plots=matrix(histogram);
 var  avg_Glucose avg_Insulin ;
 Partial avg_BMI;
run;


/*Q4 - Developing a model */
DATA work.model2;
    SET assign.lipidchallenge;
    IF time EQ 0;
	run;

/*Building the model*/

proc glm data=work.model2 plots=(diagnostics);
class SEX;
 model TAG = AGE SEX BMI / ;
lsmeans SEX / pdiff;
run;
quit;

/*Q5 - Model with log normal*/
proc genmod data=work.model2 plots=all;
class SEX;
 model TAG = AGE SEX BMI / link=log
dist=normal;
output out=model1_out pred= Pred resraw = Resraw;
run;


/*Q6 - general linear mixed model relating insulin to age, sex and bmi*/
proc mixed data=assign.lipidchallenge plots=all;
 model Insulin = AGE SEX BMI;
run;

/*Fitting the repeated measures variances covariance matrix assuming an AR(1) structure*/

proc mixed data=assign.lipidchallenge plots=all;
class ID;
model Insulin = AGE SEX BMI / solution;
repeated /subject=ID type=ar(1) r;
run;

/*Fitting the repeated measures variances covariance matrix assuming an ARH(1) structure*/

proc mixed data=assign.lipidchallenge plots=all;
class ID;
model Insulin = AGE SEX BMI / solution;
repeated /subject=ID type=arh(1) r;
run;


