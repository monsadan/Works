/*Daniel Monsalve HW2*/
/*Problem 1*/
options validvarname=v7;
PROC IMPORT DATAFILE="\\Blade9\STA\Kapitula\stat616\HW2\Oscars_nonames.xlsx" DBMS= xlsx 
					OUT=Oscars (rename=(A=ID B=Year C=Host D=Best_picture E=Best_Actor F=Best_actress G= Best_director H=Best_screenplay)) REPLACE;
					getnames=NO;
run;

Proc contents data=Oscars;
run;

libname Oscars 'W:\MyStats616\HW2\';

data Oscars.oscars;
set oscars;
label best_picture="Best picture of the year" Best_Actor="Best actor of the year"  
	best_actress="Best actress of the year" best_director="Best director of the year" best_screenplay="Best screenplay of the year";
run;

Proc contents data=Oscars.oscars;
run;

/* Problem 2 */
libname pres xlsx "W:\MyStats616\HW2\presidents.xlsx";

libname preperm "W:\MyStats616\HW2\";

data preperm.presidents;
set pres.presidents;
run;

data preperm.presidentage;
set pres.presidents;
ageatinauguration=(inaugurationdate-birthdate)/365.25;
label ageatinauguration='Age of the president at inaguration';
run;

proc sort data=preperm.presidentage out=preperm.presidentage_sorted;
by DESCENDING ageatinauguration;
run;

proc print data=preperm.presidentage_sorted (obs=10);
run;

proc means data=preperm.presidentage_sorted maxdec=1;
var ageatinauguration;
run;

proc sgplot data=pres1.presidentage_sorted;
histogram ageatinauguration;
run;

proc sgplot data=pres1.presidentage_sorted;
series x=n y=ageatinauguration;
run;

/* Problem 3 */

proc import datafile='"\\Blade9\STA\Kapitula\stat616\HW2\Tigers 2017 salaries.txt' 
	dbms=tab out=Tigers
	replace;
run;

proc means data=Tigers maxdec=0;
var Salary;

run;

proc freq data=Tigers;
table Position;
run;

/* Problem 4 */
libname crayola 'W:\MyStats616\HW2\';

data crayola.crayons;
INFILE '\\Blade9\STA\Kapitula\stat616\HW2\Crayons.dat' MISSOVER;
INPUT crayon_number :3. color_name $4-31 hexadecimal_code $ RGB_triplet $40-55 pack_size year_issued year_retired;
run;

proc sgplot data=crayons;
  vbar year_issued;
  xaxis type=time;
run;





