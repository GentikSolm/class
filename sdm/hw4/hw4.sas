
DATA HW4;

INFILE 'C:\Users\jgb38\Downloads\DataHW44.txt'

firstobs=5;

INPUT pq1 59 pq2 60 pq3 61 pq4 62 pq5 63 pq6 64 pq7 65

pq8 66 pq9 67 pq10 68 pq11 69 pq12 70 pq13 71 pq14 72 pq15 73

pq16 74  pq17 75 pq18 76 pq19 77 pq20 78 pq21 79 postq1 79 postq2 80

postq3 81 postq4 82 postq5 83 postq6 84 postq7 85 postq8 86 postq9 87 postq10 88

postq11 89 postq12 90 postq13 91 postq14 92;

IF pq1 = 1 THEN pans1 = 1;

ELSE pans1 = 0;

IF pq2 = 1 THEN pans2 = 1;

ELSE pans2 = 0;

IF pq3 = 2 THEN pans3 = 1;

ELSE pans3 = 0;

IF pq4 = 2 THEN pans4 = 1;

ELSE pans4 = 0;

IF pq5 = 1 THEN pans5 = 1;

ELSE pans5 = 0;

IF pq6 = 1 THEN pans6 = 1;

ELSE pans6 = 0;

IF pq7 = 2 THEN pans7 =1;

ELSE pans7 = 0;

IF pq8 = 2 THEN pans8 = 1;

ELSE pans8 = 0;

IF pq9 = 2 THEN pans9 = 1;

ELSE pans9 = 0;

IF pq10 = 1 THEN pans10 = 1;

ELSE pans10 = 0;

IF pq11 = 1 THEN pans11 = 1;

ELSE pans11 = 0;

IF pq12 = 1 THEN pans12 = 1;

ELSE pans12 = 0;

IF pq13 = 1 THEN pans13 = 1;

ELSE pans13 = 0;

IF pq14 = 1 THEN pans14 = 1;

ELSE pans14 = 0;

IF pq15 = 1 THEN pans15 = 1;

ELSE pans15 = 0;

IF pq16 = 1 THEN pans16 = 1;

ELSE pans16 = 0;

IF pq17 = 1 THEN pans17 = 1;

ELSE pans17 = 0;

IF postq1 = 1 THEN postans1 = 1;

ELSE postans1 = 0;

IF postq2 = 1 THEN postans2 = 1;

ELSE postans2 = 0;

IF postq3 = 2 THEN postans3 = 1;

ELSE postans3 = 0;

IF postq4 = 2 THEN postans4 = 1;

ELSE postans4 = 0;

IF postq5 = 1 THEN postans5 = 1;

ELSE postans5 = 0;

IF postq6 = 1 THEN postans6 = 1;

ELSE postans6 = 0;

IF postq7 = 2 THEN postans7 =1;

ELSE postans7 = 0;

IF postq8 = 2 THEN postans8 = 1;

ELSE postans8 = 0;

IF postq9 = 2 THEN postans9 = 1;

ELSE postans9 = 0;

IF postq10 = 1 THEN postans10 = 1;

ELSE postans10 = 0;

IF postq11 = 1 THEN postans11 = 1;

ELSE postans11 = 0;

IF postq12 = 1 THEN postans12 = 1;

ELSE postans12 = 0;

IF postq13 = 1 THEN postans13 = 1;

ELSE postans13 = 0;

IF postq14 = 1 THEN postans14 = 1;

ELSE postans14 = 0;

PRE_CORRECTAVG=MEAN(pans1,pans2,pans3,pans4,pans5,pans6,pans7,pans8,pans9,pans10,pans11,pans12,pans13,pans14,pans15,pans16,pans17);

POST_CORRECT=MEAN(postans1,postans2,postans3,postans4,postans5,postans6,postans7,postans8,postans9,postans10,postans11,postans12,postans13,postans14);

RUN;

PROC MEANS DATA = HW4;

VAR PRE_CORRECTAVG POST_CORRECT;

TITLE 'MEAN SCORES OF PRENATAL CARE COURSE, BEFORE AND AFTER';

RUN;
