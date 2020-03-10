/* Daniel Monsalve _Homework 4*/

/*Problem 1 - Part A*/

data Normal;
  numreps=1000;
  mu=100;
  sd=10;
  do n= 10,15,30,100;
  do sample = 1 to numreps;
  do i= 1 to n;
     xi= rand('normal',mu,sd);
	output;
	end;
  end;
end;
run;

Proc means data=Normal nway;
class sample n;
var xi mu sd;
output out=SimStatistics(drop= _FREQ_ _TYPE_ mu_stddev sd_stddev rename=(mu_Mean=MU sd_Mean=Sigma)) mean=Xbar stddev=S / autoname;
run;
/*Problem 1 -Part B */

proc sgpanel data=SimStatistics;
  panelby n;
  histogram Xbar;
run;

ods text= " When the sample increase, the simulated parameters are closer to the given parameters. Have large amount 
of data will help to have a better fitting to a distribution";

/*Problem 1 -Part C and D */

Data Intervals;
set SimStatistics;
t= (tinv(0.95,n-1))*(s/sqrt(n));
lclt= Xbar - t;
uclt= Xbar+ t;
if mu >= lclt and mu<= uclt then do;
	inTint= 1;
end;
else do
	inTint = 0;
end;

z= 1.96*S/sqrt(n);
lclz= Xbar-z;
uclz= Xbar+z;
if mu >= lclz and mu<= uclz then do;
	inZint= 1;
end;
else do
	inZint = 0;
end;
run;

/*Problem 1 - Part E*/

Proc freq data=Intervals;
table n*inTint n*inZint / nocol nopercent nofreq;
run;

ODS TEXT="Checking the result of the proportion for the T and the Z test, we can see that
the Z have a better performance in predicting, although theoretically for small samples would have a better performance the T tests. Both test have a good performance ";

/*Problem 2 - Part A*/

	data Expo;
	  numreps=1000;
	  lambda= 1;
	  do n= 10,15,30,100;
	  do sample = 1 to numreps;
	  do i= 1 to n;
	     xi= rand('exponential',lambda);
		output;
		end;
	  end;
	end;
	run;

	Proc means data=Expo nway;
	class sample n;
	var xi lambda;
	output out=SimStatExpo(drop= _FREQ_ _TYPE_ lambda_stddev rename=(lambda_Mean=Lambda)) mean=Xbar stddev=S / autoname;
	run;
/*Problem 2 -Part B */

proc sgpanel data=SimStatExpo;
  panelby n;
  histogram Xbar;
run;

ods text= "Having a large amount of data will help to improve the predicted values from any distribution, 
when we simulate the exponential function with a sample of 100, the predicted values are more concentrated to the given value.";


/*Problem 2 -Part C and D */

Data InterExpo;
set SimStatExpo;
t= (tinv(0.95,n-1))*(s/sqrt(n));
lclt= Xbar - t;
uclt= Xbar+ t;
if (1/lambda) >= lclt and (1/lambda)<= uclt then do;
	inTintExp= 1;
end;
else do
	inTintExp = 0;
end;

z= 1.96*S/sqrt(n);
lclz= Xbar-z;
uclz= Xbar+z;
if (1/lambda) >= lclz and (1/lambda)<= uclz then do;
	inZintExp= 1;
end;
else do
	inZintExp = 0;
end;
run;

/*Problem 2 -Part E*/

Proc freq data=InterExpo;
table n*inTintExp n*inZintExp / nocol nopercent nofreq;
run;

ODS TEXT= "From the output we can see that the confidence interval calculation for the 
exponential distribution have a good performance but is not as close as the normal
distribution. Only one sample of reach almost the given confidence level, with this we can conclude
that the T and Z test don't perform good for an exponential distribution.";

