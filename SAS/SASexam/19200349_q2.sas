/*Creating a parmenant library*/
%let path=C:\Users\ehars\Desktop\SASexam; /*Insert your own path here*/
libname exam "&path";

/* The dataset hospital.csv is loaded to a dataset hospital.*/
data exam.hospital;
infile "&path\hospital.csv" dlm=',';
input ID  AGE BMI FEV;
run;

/*2.a - Numeric Descriptive Statistics and checking for outliers*/
ods select Moments ExtremeObs;
proc univariate data=exam.hospital;
	var AGE BMI FEV;
run;

/* From the summary statistics of BMI and FEV, we see that there are 2 outliers in BMI(obs 1042 & 3937) and one outlier in FEV(obs 6191). So we will have to
   remove these three observations before moving forward.*/
/*2.a - Removing outliers*/
data exam.hospital;
     set exam.hospital;
     if BMI >= 1214.34 then delete;
     if FEV >= 581 then delete;
run;

/* Calculating the mean of all induvidual variables as there are repeated measurements*/
proc summary data=exam.hospital;
var AGE BMI FEV ;
by ID;
output out=work.hospital1 mean(AGE)=avg_AGE mean(BMI)=avg_BMI
		   mean(FEV)=avg_FEV;
run;

/*2.b - Correlation matrix on AGE, BMI and FEV */

proc corr data=work.hospital1;
var avg_AGE avg_BMI avg_FEV;
run;

/*Scatter plot of correlation*/
proc corr data=work.hospital1 nomiss plots=matrix(histogram);
 var  avg_AGE avg_BMI avg_FEV;
run;

/*2.b - Partial correlation on BMI and FEV adjusted by AGE.*/
ods select PartialPearsonCorr;
proc corr data=work.hospital1;
var avg_BMI avg_FEV;
Partial avg_AGE;
run;

/*Scatter plot of partial correlation*/
proc corr data=work.hospital1 nomiss plots=matrix(histogram);
 var avg_BMI avg_FEV;
Partial avg_AGE;
run;

/*2.c - The GLM model is created using GLM function on the variables.*/
ods graphics on;
proc glm data=exam.hospital plots=(diagnostics);
 model FEV = AGE BMI / ;
output out=work.GLM_OUTPUT r=r p=p;
run;
quit;

/*2.d - Plotting the residuals and comparing the efficiency of the model */

proc univariate data=work.GLM_OUTPUT normal noprint;
 qqplot ID / normal (mu=est sigma=est);
run;
/*2.d - Plotting the residuals and comparing with noemal plotting for checking the efficiency of the model */
proc univariate data=work.GLM_OUTPUT noprint;
 histogram ID/ normal;
 inset n normal(ksdpval) / pos = ne ;
run;
