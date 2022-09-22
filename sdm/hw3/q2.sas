DATA mylib.survey;
INPUT ID q1;
MISSING A R;
IF q1 = 'A' THEN q1=.A;
ELSE IF q1 = 'R' THEN q1=.R;
CARDS;
8401 2
8402 A
8403 1
8404 1
8405 2
8406 3
8407 A
8408 1
8409 R
8410 2
;
RUN;
PROC FORMAT library=mylib;
	VALUE missing
		.A='Not Home'
		.R='Refused';
		RUN;
PROC FREQ DATA = mylib.survey;
	OPTIONS FMTSEARCH=(mylib);
	FORMAT q1 missing.;
	TABLES q1 / MISSPRINT;
	RUN;
