# Statistical Data Management

### SAS

Importing data into sas  

```SAS
proc import
    datafile="/path/to/file.csv"
    out=mylib.name
    dbms=csv
    replace;
    getnames=yes;
run;
```

### SPSS

Importing data into SPSS

```SPSS
DATA LIST FILE="/path/to/file.txt"
/ make (A15) mpg weight price.
run;
```

### Excel

Three major parts of excell:  
- Worksheets  
- Charts  
- Databases  


