/*Creating a parmenant library*/
%let path=C:\Users\ehars\Documents\UCD\SAS\Assignment1; /*Insert your own path here*/
libname assign "&path";

/* Runing default Print statement to verify if the assignment1 dataset is loaded correctly. The assignment1 dataset is loaded using assign.assignment1 to its data block.*/
proc print data=assign.assignment1;
run;

/*a.Include the variables bodyweight0 and bodyweight6*/
title1 'Values of weight at initial stage and after six months';

proc print data=assign.assignment1;
	var Bodyweight0 Bodyweight6;
run;
title;

/*b.Restrict to participants between the ages of 40 and 50*/
title1 'Participants initial and final weight after six months between the age 40 & 50';

proc print data=assign.assignment1;
	var Bodyweight0 Bodyweight6;
	where age >= 40 and
		age <= 50;
run;
title;

/*b1. The above code block can also be written using between keyword.*/
title1 'Participants initial and final weight after six months between the age 40 & 50';

proc print data=assign.assignment1;
	var Bodyweight0 Bodyweight6;
	where age between 40 and 50;
run;
title;

/*c.Group the report by gender*/
title1 'Grouping the values based on Gender';
proc sort data=assign.assignment1
			out=work.assignment1;
	where age between 40 and 50;
	by Gender;
run;
/*The work.assignment1 will be sorted now along with age criteria and the by Gender will separate based on gender.*/
proc print data=work.assignment1;
	by Gender;
	var Bodyweight0 bodyweight6;
run;
title;

/*d.Suppress the printing of the observation number and use participant_id to 
identify observations instead*/
title1 'Supressing observation number and printing Participants ID';
proc print data=work.assignment1 noobs;
	by Gender;
	ID Participant_ID;
	var Bodyweight0 bodyweight6;
run;
title;

/*e.Assign labels to bodyweight0 and bodyweight6 describing the variables and 
giving measurement units*/
title1 'Participants bodyweight at start and after 6 months in kilograms';
proc print data=work.assignment1 noobs label;
	by Gender;
	ID Participant_ID;
	var Bodyweight0 bodyweight6;
	label Bodyweight0 ='Weight at start,in Kg'
		  bodyweight6 = 'Weight after 6months,in Kg';
run;
title;


/*-----Question 1 ends and Question 2 begins----*/




/*Question 2 - Creating a permanent dataset*/
%let path=C:\Users\ehars\Documents\UCD\SAS\Assignment1;
libname assign "&path";

data assign.dietarystudy ;
  set assign.assignment1;
  bodyweight_change= bodyweight6 - bodyweight0;
  energy_proportional_change= (energy_intake6 -energy_intake0)/energy_intake0;
  if(age>35 and 
  	energy_proportional_change<-0.1);
  where bodyweight6 is not null and
  	energy_intake6 is not null;
  label bodyweight_change= Change in Bodyweight;
  label energy_proportional_change= Proportion of change in energy;
  format energy_proportional_change PERCENT9.1;
  
run;

/*The above code block can also be written with a 'where clause' for proportional energy change condition.*/
/*a.	Write the dataset to the library assign*/
data assign.dietarystudy ;
  set assign.assignment1;
  bodyweight_change= bodyweight6 - bodyweight0;
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
format energy_proportional_change PERCENT9.1;
run;


/*Printing the new variables*/
title1 'Proportional Energy reduction table after six months';
proc print data=assign.dietarystudy;
	var bodyweight_change energy_proportional_change;
run;
title;


/* Displays data set descriptor information variables and permanent labels */
proc contents data=assign.dietarystudy;  
run;
