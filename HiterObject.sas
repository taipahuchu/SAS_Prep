
DATA lowest (drop=low high) highest (drop=low high);
	IF _N_ = 1 THEN	DO;

			IF 0 THEN SET myTab;

			DECLARE HASH ran(dataset:'myTab', 
							multidata:'YES',
							ordered:'descending');
			ran.DefineKey('RANDS');
			ran.DefineData('Make','RANDS','num');
			ran.DefineDone();

			DECLARE Hiter C('ran');
		
		END;

	do low = 1 to 5;
	IF low=1 then C.last();
	else C.prev();
	output lowest;
	end;

	do high = 1 to 5;
    if High = 1 then C.first();
	else C.next();
	output highest;
	end;
		
RUN;