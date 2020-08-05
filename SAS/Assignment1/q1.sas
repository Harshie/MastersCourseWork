/*Creating a parmenant library*/
%let path=C:\Users\ehars\Documents\UCD\SAS\Assignment1; /*Insert your own path here*/
libname assign "&path";

/* Run default Print statement*/
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
title 'Grouping the values based on Gender';
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
title 'Supressing observation number and printing Participants ID';
proc print data=work.assignment1 noobs;
	by Gender;
	ID Participant_ID;
	var Bodyweight0 bodyweight6;
run;
title;

/*e.Assign labels to bodyweight0 and bodyweight6 describing the variables and 
giving measurement units*/
title 'Participants bodyweight at start and after 6 months in kilograms';
proc print data=work.assignment1 noobs label;
	by Gender;
	ID Participant_ID;
	var Bodyweight0 bodyweight6;
	label Bodyweight0 ='Weight at start,in Kg'
		  bodyweight6 = 'Weight after 6months,in Kg';
run;
title;

