# HW 8

```sas
libname inexcel xlsx '/home/u62253726/mylib/HW/north.xlsx';

proc copy in=inexcel out=mylib;
run;

*PROC PRINT DATA=mylib.'ORDER DETAILS'n;
*RUN;

PROC SQL;
	SELECT Firstname, Lastname 
	FROM mylib.Employees 
	ORDER BY Firstname, Lastname;
RUN;	

PROC SQL;
	SELECT Firstname, Lastname, Title 
	FROM mylib.Employees 
	WHERE title <> "Sales Representative" 
	ORDER BY Firstname, Lastname
	;
RUN;

PROC SQL;
	SELECT ContactName, CustomerID, CompanyName, City, Country
	FROM mylib.Customers
	WHERE Country LIKE "Brazil"
	ORDER BY ContactName;
RUN;

PROC SQL;
	SELECT OrderDate, COUNT(*)
	FROM mylib.Orders
	GROUP BY OrderDate;
RUN;

PROC SQL;
	SELECT COUNT(*)
	FROM mylib.Orders
	WHERE OrderDate >= '01JAN95'd AND OrderDate < '01APR95'd;
RUN;

PROC SQL;
	SELECT c.ContactName, COUNT(*)
	FROM mylib.Customers as c
	LEFT JOIN mylib.Orders as o on c.CustomerID = o.CustomerID
	GROUP BY c.ContactName, c.CustomerID;
RUN;

PROC SQL;
	SELECT e.Firstname, e.Lastname, COUNT(*)
	FROM mylib.Employees as e
	LEFT JOIN mylib.Orders as o on e.EmployeeID= o.EmployeeID
	GROUP BY e.Firstname, e.Lastname, e.EmployeeID;
RUN;

PROC SQL;
	SELECT ProductName, UnitsInStock
	FROM mylib.Products
	ORDER BY ProductName;
RUN;

PROC SQL;
	SELECT p.ProductName, SUM(o.Quantity) * o.UnitPrice as TotalSales
	FROM mylib.'Order Details'n as o
	LEFT JOIN mylib.Products as p on o.ProductID = p.ProductID
	GROUP BY o.ProductID, o.UnitPrice, p.ProductName
	ORDER BY p.ProductName;
RUN;

PROC SQL;
	SELECT CompanyName, ShippedDate, COUNT(o.OrderID) as TotalOrders
	FROM mylib.Orders as o
	LEFT JOIN mylib.Shippers as s on o.ShipVia = s.ShipperID
	WHERE CompanyName LIKE 'United Package'
	AND ShippedDate >= '01JAN95'd AND ShippedDate < '01JAN96'd
	GROUP BY ShippedDate;
RUN;
```
