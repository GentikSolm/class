proc import out=mylib.misdata datafile='C:\Users\jgb38\Downloads\missing.txt' dbm=dlm ;
  delimiter='09'x;
run;
data result;
set mylib.misdata;
array X _numeric_;
do i = 1 to dim(X);
if X[i] = -999 then X[i] = .;
if X[i] = -99 then X[i] = .;
end;
drop i;
run;
PROC PRINT data=result;
RUN;
