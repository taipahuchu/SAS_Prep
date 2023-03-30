PROC FCMP OUTLIB= work.myfunc.myp;
	function weightAdj(Weight);
		AvgWeight = Weight*1.19;
		RETURN(AvgWeight);
	ENDSUB;

	function weightAvg(Weight);
		W = Weight*2/3;
		RETURN(W);
	ENDSUB;
RUN;


PROC FCMP OUTLIB= work.myfunc.otherFunc;
	Function myweight(Make $,Weight);

		If Make = 'Acura' OR Make = 'BMW' THEN
			AvgAdj = Weight * 2;
		ELSE AvgAdj = Weight *1.7;
	 RETURN(AvgAdj);
	ENDSUB;
RUN;


options cmplib= work.myfunc;
DATA CARS;
  length units $2;
	SET sashelp.cars;
	NewWeight= weightAdj(Weight);
	AvgWeight= myweight(Make,Weight);
	Units= 'N';
RUN;

PROC FCMP OUTLIB=work.myfunc.subs;
   Subroutine convWeight(AvgWeight,units $);
   outargs AvgWeight, units;
   IF upcase(units) = 'N' THEN do;
       AvgWeight = ROUND(AvgWeight/1000,2);
     Units = 'Kg';
	 end;
	ENDSUB;
RUN;

data mycars;
SET cars(Drop=Units);
SET cars(keep=Units);
CALL convWeight(AvgWeight,units);
RUN;