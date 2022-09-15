
DATA mylib.polit;
        infile "C:\Users\jgb38\Downloads\PoliticalParty.txt";
        input ID 1-3 Gender $4 Party $5 Vote 6 Foreign 7 Spend 8;
        run;
data mylib.political;
	set mylib.polit;
	run;

PROC FORMAT library=mylib;
        VALUE $Gender
                'M'='Male'
                'F'='Female';
        VALUE $Party
                'D'='Democrat'
                'R'='Republican'
				'U'='Unknown'
                'I'='Independent';
        VALUE yesno
                0='No'
                1='Yes';
run;


PROC PRINT DATA=mylib.political (obs=10) label noobs;
        OPTIONS FMTSEARCH=(mylib);
		LABEL Gender='Gender';
		LABEL Party='Political Party';
		LABEL Vote='Did you vote in the last election';
		LABEL Foreign='Do you agree with the governments foreign policy';
		LABEL Spend='Should we increase domestic spending';
		FORMAT Gender $Gender. Party $Party. Vote yesno. Foreign yesno. Spend yesno.;
run;

PROC FREQ DATA=mylib.political;
	OPTIONS FMTSEARCH=(mylib);
	LABEL Gender='Gender';
	LABEL Party='Political Party';
	LABEL Vote='Did you vote in the last election';
	LABEL Foreign='Do you agree with the governments foreign policy';
	LABEL Spend='Should we increase domestic spending';
	FORMAT Gender $Gender. Party $Party. Vote yesno. Foreign yesno. Spend yesno.;
	TABLE Gender Party Vote Foreign Spend;
	run;
PROC FREQ DATA=mylib.political;
	OPTIONS FMTSEARCH=(mylib);
	LABEL Gender='Gender';
	LABEL Party='Political Party';
	FORMAT Gender $Gender. Party $Party.;
	TABLES Gender*Party;
	run;
