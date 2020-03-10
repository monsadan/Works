%let outpath=W:\myStats616\HW3;
ods pdf file="&outpath\HW3_1.pdf" startpage=off notoc style=pearlj columns=1 gtitle gfootnote;
tITLE "Daniel Monsalve HOMEWORK 3";
options validvarname= V7;

%let months=Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec;

PROC IMPORT DATAFILE="\\Blade9\STA\Kapitula\stat616\hw3\grand rapids temperature data.xlsx" DBMS= xlsx OUT=Temper replace;
run;

Proc sgplot data=Temper;
series x= Year y= Annual;
run;

PROC TABULATE DATA=Temper;
	class Annual;
	var &months;
	table &months, N MEAN STD MIN MAX;
run;

proc transpose data=Temper out=Temper2(drop=_LABEL_ RENAME=(COL1=Temperature)) name= Month;
	by Year;
	var &months;
run;

proc sgplot data=Temper2;
vbox Temperature / GROUP=Month cATEGOry=Month;
run;

proc means data=Temper mean;
	var &months;
	output out=means mean= / autolabel;
	run;

proc transpose data=means(drop=_freq_ _type_) out=means1(drop=_LABEL_ rename=(col1=average)) name=Month;
run;

proc sort data=means1 out=means2;
	by average;
run;

proc odstext data=means2(obs=1);
p "The coldest month is " ||Month||" with " ||put(average,5.2)|| " average temperature";
run;

proc means data=Temper stddev;
	var &months;
	output out=sd stddev= / autolabel;
	run;

proc transpose data=sd(drop=_freq_ _type_) out=sd1(drop=_LABEL_ rename=(col1=Stand_Dev)) name=Month;
run;

proc sort data=sd1 out=sd2;
	by descending Stand_Dev;
run;

proc odstext data=sd2(obs=1);
p "The month with more variability in the temperature is " ||Month;
run;

data Temper3;
set Temper2( where= (Temperature NE .));
RUN;


proc sort data=Temper3;
by descending Temperature;
run;

proc odstext data=Temper3(obs=1);
p "The maximum temperature month is " ||Month||" in the year " ||put(Year,5.2)|| " with a temperature of " ||PUT(Temperature,5.2);
run;

proc sort data=Temper3;
by Temperature;
run;

proc odstext data=Temper3(obs=1);
p "The minimum temperature month is " ||Month||" in the year " ||put(Year,5.2)|| " with a temperature of " ||PUT(Temperature,5.2);
run;

ods pdf close;













