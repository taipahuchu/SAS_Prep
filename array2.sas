DATA citi;
	SET SASHELP.CITIQTR ( keep= date gdp where=(date < '01JAN1982'd));
	FORMAT GDP 8.;
RUN;

data citiL;
	set SASHELP.CITIQTR (Where=(year(date) in (1980,1981)));
	year = year(date);
	format gdp 8. gcq 8. gc 8.;
	keep year gdp gcq gc;
	RETAIN year gdp gcq gc;
run;

PROC SORT DATA=citiL;
	by year;
run;

data citiL;
	SET citiL(DROP=Year);
	SET citiL(KEEP=Year);
	rename gdp = GDP1 gcq = GDP2 GC= GDP3;
	BY YEAR;

	IF first.year = 1;
RUN;


Data Citi2;
	ARRAY Avg[1980:1981,3] _temporary_ (1702,2465,2650,1876,2476,2954);
	set citi (WHERE =(MONTH(Date) ^= 4));
	Y= year(Date);
	M=Month(Date);
	DROP date;
	AverageTemp = Avg[Y,M];
	Difference = GDP - AverageTemp;
RUN;

/*
PROC MEANS DATA= citiL NOPRINT;
CLASS YEAR;
VAR GC GCD GCQ;
output out= mymean mean=;
RUN;