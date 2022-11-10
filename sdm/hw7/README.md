# Problem 1

```sas
/**********EXPORT SINGLE UNIFORM RN'S USING IML DATA EXAMPLE*****/
PROC IML;
	n=10000;
	pi=constant("pi");
	myran = j(n,1,0);
	uniform = uniform(myran);
	cauchy = tan((pi * (uniform - 1/2)));
	CREATE uniform2 FROM uniform[colname={'x'}];
	APPEND FROM uniform;
	CREATE cauchy2 FROM cauchy[colname={'y'}];
	APPEND FROM cauchy;
QUIT;

PROC PRINT DATA=uniform2 (obs=10) noobs; 
RUN;

PROC PRINT DATA=cauchy2 (obs=10) noobs; 
RUN;

PROC UNIVARIATE DATA = uniform2 noprint; VAR x; Histogram x;
	TITLE "Uniform Random Numbers";
RUN;

PROC UNIVARIATE DATA = cauchy2 noprint; VAR y; Histogram y;
	WHERE abs(y) < 10;
	TITLE "Exponential Random Numbers"; 
RUN;
```
