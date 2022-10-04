# HW 5

### Excell  
Part A:  
First, I downloaded both datasets into the same folder called Email Test. Next I selected `Get Data` -> `From File` -> `From Folder`
and selected the folder with both .csv files. I then loaded it into excell, and had successfully combined the datasets.

Part B:  
To merge variable information, I entered `=XLOOKUP(A2,'Email Indicator'!$A:$A,'Email Indicator'!$B:$B)` into a new column called `Mens/Women`
This command, as per Microsoft, is an upgraded version of the vlookup command. A2 is the variable I want to look up, the next argument is
the cells i want to search, and fianlly the last paramater is the values i want to get back.

Part C:  
The mens Email campaign seems to have been much more successfull than the womens campaign. On all metrics (Total visits, Money Spent in the following weeks, and total conversion) the mens campaign out performed the womens.  

![](excell_pivot.png)
