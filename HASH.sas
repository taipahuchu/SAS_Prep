PROC SQL;
	CREATE TABLE mytab AS 
		select DISTINCT Make 
			FROM sashelp.cars;
QUIT;

data mytab;
	SET mytab;
	RANDS = round(RAND("uniform")*100,2);
	num=_n_;
RUN;

DATA myCars Acura ;
	IF _N_ = 1 THEN
		DO;
			IF 0 THEN
				SET myTab;

			DECLARE HASH ran(dataset:'myTab', multidata:'YES',ordered:'descending');
			ran.DefineKey('Make');
			ran.DefineData('RANDS','num');
			ran.DefineDone();

			DECLARE HASH mysort(ordered:'descending', multidata:'YES');
			mysort.DefineKey('TotalWeight');
			mysort.DefineData('Make','TotalWeight','RANDS','num','Weight');
			mysort.DefineDone();

				
		END;

	SET sashelp.cars end=eof;
	RC=ran.find();

	if RC ne 0 then
		call missing(RANDS,num);
	TotalWeight = RANDS*Weight;
	OUTPUT myCARs;

	IF make = 'Acura' THEN
		OUTPUT Acura;

	IF Make = 'BMW' THEN
		mysort.add();

	if eof THEN
		mysort.output(dataset:'BMW');
	format rands comma12.;

RUN;