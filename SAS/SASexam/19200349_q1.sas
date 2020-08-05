/*Creating a parmenant library*/
%let path=C:\Users\ehars\Desktop\SASexam; /*Insert your own path here*/
libname exam "&path";

/*1.a -  This data step will be used for creating the dataset with required length and format of the variables and new variable PROTEIN_FIELD.*/
data exam.crop_yield;
	infile "&path\crop_yield.csv" dlm=',';
	input SITE  COUNTRY :$10. DATE :ddmmyy. FERTILISER   
			CROP PROTEIN FIBRE ; /*1.b - Adding format for date */
	PROTEIN_YIELD = (PROTEIN/100) * (CROP); /*1.c - Adding a new variable PROTEIN_YIELD */
	label SITE= Site identification number; /*1.b - Adding labels for variables */
    label CROP= Total yield of crop (kg/ha);/*1.b - Adding labels for variables */
	label PROTEIN= Percentage of protein in crop (% biomass);/*1.b - Adding labels for variables */
    label FIBRE= Percentage of fibre in crop (% biomass);/*1.b - Adding labels for variables */
	format PROTEIN PERCENT9.1;  /*1.a - Adding percentage format for PROTEIN */
	format FIBRE PERCENT9.1;    /*1.a - Adding percentage format for FIBRE */
    run;

 /*1.c can be done like the below aswell, 
 data work.crop_yield;
  set exam.crop_yield;
  PROTEIN_YIELD = (PROTEIN/100) * (CROP);
run;*/ 


/*1.d - Creating a new dataaset 'local' with required fields*/
data work.local;
 set exam.crop_yield;
 where COUNTRY = 'Ireland';
 keep SITE FERTILISER PROTEIN_YIELD;
 run;

 /*1.e - Sorting local and creating new dataset.*/
proc sort data=work.local
			out=work.local_sorted;
	by FERTILISER;
run;

/* This below code block will display the subtotal and overall total of the PROTEIN_YIELD */
ods pdf file="&path\proteinyeild.pdf";
title1 'Protein Yield of each fertilisers';
proc print data = work.local_sorted;
	by FERTILISER;
	sum PROTEIN_YIELD;
	var PROTEIN_YIELD;
run;
title;
ods pdf close;

/*1.f - Creating rainfall dataset using datalines.*/

data work.rainfall;
   input SITE RAINFALL;
   datalines;
1	150
27	90
11	150
18	120
14	80
15	150
20	120
10	150
23	60
24	135
26	120
22	0
13	40
;

/*1.g - The dataset can be merged only when the datasets are sorted by SITE. So the rainfall dataset is also sorted.*/
proc sort data=work.rainfall
			out=work.rainfall1;
	by SITE;
run;

/*1.g - The sorted crop_yield and rainfall dataset are merged and stored in a new dataset combined. */
data work.combined;
   merge exam.crop_yield work.rainfall1;
   by SITE;
run;
