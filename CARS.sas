PROC SQL;
CREATE TABLE mytab AS 
select DISTINCT Make 
FROM sashelp.cars; 
QUIT;
data mytab;
SET mytab;
RANDS = round(RAND("uniform")*100,2);
n=_n_;
RUN;

DATA CARS;
SET SASHELP.CARS;

RUN;

