# Homework 1

## 1.a

![](spss_data_view.png)
![](spss_var_view.png)

## 1.b

![](excell.png)

## 1.c

![](birthcsv.png)

```sas
PROC IMPORT DATAFILE="/home/u62253726/birthweight1.csv" OUT=mylib.birthcsv;

PROC PRINT DATA=mylib.birthcsv;
```

## 1.d

![](sas_infile.png)

```sas
DATA mylib.birthtxt;
	infile "C:\Users\jgb38\Downloads\birthweight1.txt"
	TRUNCOVER;
	input Ethnic 1 Age 2-3 Smoke 4 PreWeight 5-10 DelWeight 11-16 BreastFed$ 17 BthWeight 18-21 BthLength 22-26;
	run;
	
PROC FORMAT library=mylib;
	VALUE Race
		1='white'
		2='black'
		3='hispanic';
	VALUE Smoke
		1='non-smoker'
		2='light smoker'
		3='heavy smoker';
	VALUE $BreastFed
		'Y'='Baby will be breastfed'
		'N'='Baby will not be breast fed';
	run;

PROC PRINT DATA=mylib.birthtxt label;
	OPTIONS FMTSEARCH=(mylib);
	LABEL Ethnic='Ethnicity of mother';
	LABEL Age='Age of mother';
	LABEL Smoke='Smoking status of mother';
	LABEL PreWeight='Weight of mother beore pregnancy';
	LABEL DelWeight='Weight of mother at delivery';
	LABEL BreastFed='Indicator if baby was breastfed';
	LABEL BthWeight='Weight of baby at birth';
	LABEL BthLength='Length of baby at birth';
	FORMAT Ethnic Race. Smoke Smoke. BreastFed $BreastFed.;
run;
```
