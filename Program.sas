DATA CARS;
	LENGTH AvgMean 8 Initial $ 2;
	SET sashelp.cars;
	AvgMean = mean(MPG_city, MPG_Highway);
	Initial = substr(Make,1 ,1 );

	IF Weight > 35000 Then
		Status = "High";
	ELSE Status = "Low";
RUN;

DATA mycars;
	SET sashelp.cars;
	by Make;

	If first.make = 1 Then
		do;
			Count= 0;
			MPG_city_tot = 0;
			MPG_Highway_tot=0;
		END;

	count+1;
	MPG_city_tot + MPG_city;
	MPG_Highway_tot+ MPG_Highway;

	IF last.make = 1 Then
		do;
			MPG_adj = (MPG_city_tot+MPG_city_tot)/(2*count);
			output;
		end;

	format MPG_Highway_tot comma10. MPG_city_tot comma10. 
		MPG_adj comma10.1;
	KEEP Make MPG_adj;
RUN;