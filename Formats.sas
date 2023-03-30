data cars;
SET sashelp.cars;
RUN;

proc format;
 Value $Origin 'Asia' =  'Not Standard'
 				'Europe'= 'Excellent'
				'USA'= 'Class'
				'Other' = 'Miscoded'; 
Value Status low-35700 = 'Low'
    	   35700-high = 'High';
RUN;
TITLE 'This is a real deal';
PROC PRINT DATA= cars noobs;
VAR Make Model Origin MSRP;
Format Origin $Origin. MSRP  Status.;
RUN;

data myTime;  
input type$ DATE:datetime18. valuese;
format date datetime18.;
cards;

A 19JUN01:21:06:55 534
A 19JUN01:21:06:58 590
A 19JUN01:21:07:02 600
A 19JUN01:21:07:04 602
B 18JUN01:22:06:58 105
B 18JUN01:22:07:03 110
;
run; 

PROC FORMAT;
Value myValue low-550 = 'Low'
              550-High= 'High';
RUN;

PROC FORMAT;
PICTURE mydate (Default=15) 
		low-High = '%a-%d-%3B-%Y'
		(datatype=date);
PICTURE mytime (default=14) 
      low-high = 'H:%0H M:%0m S: %0S'
	  (datatype=time);
RUN;

DATA myTimes;
SET myTime;
Time = Date;
FORMAT date mydate. Time myTime. value myvalue. ;
RUN;



