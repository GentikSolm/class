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

# Problem 2

```sas
/**********EXPORT SINGLE UNIFORM RN'S USING IML DATA EXAMPLE*****/
PROC IML;
	n=10000;
	pi=constant("pi");
	zeromat = j(n,1,0);
	xnorm = uniform(zeromat);
	ynorm = uniform(zeromat);
	
	xtheta = 2 * pi * xnorm;
	xR = 5 * sqrt(-2 * log(xnorm));
	ytheta = 2 * pi * ynorm;
	yR = 3 * sqrt(-2 * log(ynorm));
	
	xbox = xR#cos(xtheta) + 15;
	ybox = yR#sin(ytheta) + 10;
	
	CREATE x FROM xbox[colname={'x'}];
	APPEND FROM xbox;
	CREATE y FROM ybox[colname={'y'}];
	APPEND FROM ybox;
QUIT;

DATA xy;
	MERGE x y;
RUN;

PROC UNIVARIATE DATA = x noprint; 
	VAR x; 
	Histogram x;
	TITLE "Uniform Random Numbers";
RUN;

PROC UNIVARIATE DATA = y noprint; 
	VAR y; 
	Histogram y;
	TITLE "Exponential Random Numbers"; 
RUN;

proc kde data=xy;
   bivar x y / plots=contour surface;
run;

PROC CORR data=xy PLOTS(MAXPOINTS=10000)=SCATTER(NVAR=all);
	VAR x y;
RUN;
```
