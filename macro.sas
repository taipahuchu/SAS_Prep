PROC SQL;
SELECT DISTINCT cylinders INTO 
:mycars SEPARATED BY ' '
FROM sashelp.cars;
QUIT;

%MACRO numb(list);
       %LOCAL i;
	   %let i=1;
	   %DO %WHILE (%SCAN(&LIST,&i) ne );
	    %let num = %scan(&list,&i);
         TITLE "&num - Cylinder cars";

			PROC PRINT DATA= sashelp.cars noobs;
				Where cylinders =&num and ORIGIN ="USA";
				VAR Cylinders Make Model Type Origin MSRP MPG_City MPG_Highway;
			RUN;

			PROC SGPLOT data=sashelp.cars;
				where cylinders =&num;
				REG X= MSRP Y=Weight;
			RUN;
		    %let i= %sysevalf(&i + 1);
		 %end;
%MEND numb;
%numb(&mycars)


/*
%PUT NOTE: SASUATO=%SYSFUNC(pathname(SASAUTOS));

%DATATYP('a')

PROC CATALOG CATALOG= WORK.SASMAC1;
CONTENTS OUT=MYTAB;
RUN;

%let myAuto = /sas/prd/SAS94/SAS/Home/AB0121M/data_mrd1wholesleu/projects/ccrs;

OPTIONS MAUTOSOURCE;
OPTIONS SASAUTOS=("&myAuto",SASAUTOS);