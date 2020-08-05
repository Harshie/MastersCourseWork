%let path=C:\Users\ehars\Documents\UCD\SAS\Assignment1;
libname assign "&path";


/*a.	Write the dataset to the library assign*/
data assign.dietarystudy ;
  set assign.assignment1;
  bodyweight_change= bodyweight0 - bodyweight6;
  energy_proportional_change= (energy_intake6 -energy_intake0)/energy_intake0;
  where bodyweight6 is not null and
  	energy_intake6 is not null;
  label bodyweight_change= Change in Bodyweight;
  label energy_proportional_change= Proportion of change in energy;
  
run;


data assign.dietarystudy;
set assign.dietarystudy;
where age>35 and 
	energy_proportional_change < -0.1;
format energy_proportional_change PERCENT7.1;
run;


/*Printing the new variables*/
title 'Energy reduction table after six months';
proc print data=assign.dietarystudy;
	var bodyweight_change energy_proportional_change;
run;
title;


/* Displays data set descriptor information variables and permanent labels */
proc contents data=assign.dietarystudy;  
run;

