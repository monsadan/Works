DATA conference;
INFILE "\\Blade9\STA\Kapitula\stat616\hw3/Conference.dat" TRUNCOVER;
INPUT 	first_name $	last_name $ 	attendee_id	business_phone $ 47-59 
	home_phone $ 61-73 	mobile_phone $ 75-87 ok_business $ 	ok_home $
	ok_mobile $	registration_rate 	wednesday_mixer $	thursday_lunch $
	will_volunteer $ dietary_restrictions $ 117-150;

IF registration_rate = 350 THEN DO
	group_attendee = 'Academic Regular';
END;
ELSE IF registration_rate = 200 THEN DO
	group_attendee = 'Student Regular';
END;
ELSE IF registration_rate = 450 THEN DO
	group_attendee = 'Regular';
END;
ELSE IF registration_rate = 295 THEN DO
	group_attendee = 'Academic Early';
END;
ELSE IF registration_rate = 150 THEN DO
	group_attendee = 'Student Early';
END;
ELSE IF registration_rate = 395 THEN DO
	group_attendee = 'Early';
END;
ELSE IF registration_rate = 550 THEN DO
	group_attendee = 'On-Site';
END;


IF length(business_phone) > 8 THEN DO
	area_code = SUBSTR(business_phone,2,3);
END;
ELSE IF length(home_phone) > 8 THEN DO
	area_code = SUBSTR(home_phone,2,3);
END;
ELSE IF length(mobile_phone) > 8 THEN DO
	area_code = SUBSTR(mobile_phone,2,3);
END;
ELSE DO 
	area_code = '';
END;

IF find(dietary_restrictions,'veg','i') ge 1 THEN DO
	vmeal = 1;
END;
ELSE DO
	vmeal = 0;
END;
run;

proc sort data=conference;
by vmeal;
run;

PROC FREQ DATA=conference;
	table vmeal;
run;

Proc print data=conference;
Where attendee_id= 1082 OR attendee_id= 1083;
var group_attendee area_code vmeal;
run;