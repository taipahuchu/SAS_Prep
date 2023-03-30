options mcompilenote=all nomlogic nomprint;

%MACRO splittable(tab,col);

options mautosource;
%if tab =  or tab = ? or %SCAN(%upcase(&tab),1) = HELP %then  %do;
	%put WARNING- *************************************************;
	%put WARNING- * split table macro                              *;
	%put WARNING- * syntax: splittable(tab,col)                    *;
	%put WARNING- * Parameters:									   *;
	%put WARNING- *     TAB: table to split                        *;
	%put WARNING- *     COL: Column to use to create tables        *;
	%put WARNING- **************************************************;
    %RETURN;
%END;

/*Ensure parameter values are upper case*/
%LET tab = %UPCASE(&tab);
%LET col = %UPCASE(&col);

/*If only table name is provided add prefix work*/
%IF %scan(&tab,2) = %THEN %DO;
%LET tab = work.&tab;
%END;

/*Check if the table exist */
%IF %SYSFUNC(exist(&tab))=0 %THEN %DO;
 %PUT ERROR: &tab does not exist;
 %PUT ERROR: Macro will stop executing;
%end;

data &col;
SET &tab;
IF origin = "&col" THEN output &col;
RUN;
%MEND splittable;
/*%splittable(sashelp.cars,USA)*/

%splittable(HELP)
/*%upcase(HELP)*/