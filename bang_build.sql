--CLEAR ALL BEFORE RUN
DELETE FROM Training_LIST;
DELETE FROM TrainingPrograms;
DELETE FROM Computers;
DELETE FROM Employees;
DELETE FROM Departments;
DELETE FROM Order_LISTS;
DELETE FROM Orders;
DELETE FROM PaymentTypes;
DELETE FROM Products;
DELETE FROM Customers;
DELETE FROM ProductTypes;

DROP TABLE IF EXISTS ProductTypes;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Order_LISTS;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS PaymentTypes;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;
DROP TABLE IF EXISTS Computers;
DROP TABLE IF EXISTS TrainingPrograms;
DROP TABLE IF EXISTS Training_LIST;

--Customer and Order Setup
CREATE TABLE 'ProductTypes' (
	'ProductTypeId' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	'ProductTypeName' TEXT NOT NULL
	);

CREATE TABLE 'Customers' (
	'CustomerId' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	'Customer_FirstName' TEXT NOT NULL,
	"Customer_LastName" TEXT NOT NULL,
	"Customer_Created" TEXT NOT NULL,
	"Customer_Inactive" BOOLEAN NOT NULL DEFAULT 0
);

CREATE TABLE 'Products' (
	'ProductId' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	'ProductTitle' TEXT NOT NULL,
	'ProductDescr' TEXT NOT NULL,
	'ProductPrice' FLOAT(6,2) NOT NULL,
	'ProductType' INTEGER NOT NULL,
	'CustomerId' INTEGER NOT NULL,
	FOREIGN KEY('ProductType') REFERENCES 'ProductTypes' ('ProductTypeId'),
	FOREIGN KEY('CustomerId') REFERENCES 'Customers' ('CustomerId')
);

CREATE TABLE 'PaymentTypes' (
	'PaymentTypeId' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	'PaymentType' TEXT NOT NULL,
	"PaymentAccountNum" INTEGER NOT NULL,
	"CustomerId" INTEGER NOT NULL,
	FOREIGN KEY('CustomerId') REFERENCES 'Customers' ('CustomerId')
);

CREATE TABLE 'Orders' (
	'OrderId' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	'CustomerId' INTEGER NOT NULL,
	'PaymentType' INTEGER,
	'OrderTotal' FLOAT(6,2) NOT NULL,
	FOREIGN KEY('CustomerId') REFERENCES 'Customers' ('CustomerId'),
	FOREIGN KEY('PaymentType') REFERENCES 'PaymentTypes' ('PaymentTypeId')
);

CREATE TABLE 'Order_LISTS' (
	'Order_LIST_Id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
		'ProductId' INTEGER NOT NULL,
		'OrderId' INTEGER NOT NULL,
		FOREIGN KEY('ProductId') REFERENCES 'Products' ('ProductId'),
		FOREIGN KEY('OrderId') REFERENCES 'Orders' ('OrderId')
);

--Employee and Company Setup

CREATE TABLE 'Departments' (
	'DepartmentId' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	'Department_Name' TEXT NOT NULL,
	"Supervisor_Name" TEXT NOT NULL,
	"Budget" INTEGER NOT NULL
);

CREATE TABLE 'Employees' (
	'EmployeeId' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	'Employee_FirstName' TEXT NOT NULL,
	"Employee_LastName" TEXT NOT NULL,
	"DepartmentId" INTEGER NOT NULL,
	"Salary" INTEGER NOT NULL,
	FOREIGN KEY('DepartmentId') REFERENCES 'Departments' ('DepartmentId')
);

CREATE TABLE 'Computers' (
	'ComputerId' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	'Brand' TEXT NOT NULL,
	'Model'TEXT NOT NULL,
	'PurchaseDate' TEXT NOT NULL,
	'DecomissionDate' TEXT NOT NULL,
	'EmployeeId' INTEGER NOT NULL,
	FOREIGN KEY ('EmployeeId') REFERENCES 'Employees' ('EmployeeId')
);

CREATE TABLE 'TrainingPrograms' (
	'ProgramId' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	'ProgramName' TEXT NOT NULL,
	'StartDate' TEXT NOT NULL,
	'EndDate' TEXT NOT NULL,
	'MaxAttend' INTEGER NOT NULL
);

CREATE TABLE 'Training_LIST' (
	'Training_LIST_Id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	'ProgramId' INTEGER NOT NULL,
	'EmployeeId' INTEGER NOT NULL,
	FOREIGN KEY ('ProgramId') REFERENCES 'TrainingPrograms' ('ProgramId'),
	FOREIGN KEY ('EmployeeId') REFERENCES 'Employees' ('EmployeeId')
);

--SETUP Initial Values for CUSTOMER stuff
--###########
INSERT INTO ProductTypes VALUES (null, 'Computers');
INSERT INTO ProductTypes VALUES (null, 'Shoes');
INSERT INTO ProductTypes VALUES (null, 'Fission Material');
INSERT INTO ProductTypes VALUES (null, 'Books');
INSERT INTO ProductTypes VALUES (null, 'Games');
INSERT INTO ProductTypes VALUES (null, 'Toys');
--######################
INSERT INTO Customers VALUES (null, 'Bob', 'Roberts', '10/10/2000', 0);
INSERT INTO Customers VALUES (null, 'James', 'Jamerson', '11/04/2010', 0);
INSERT INTO Customers VALUES (null, 'Ruth', 'Ginsberg', '02/03/2016', 1);
INSERT INTO Customers VALUES (null, 'Llama', 'McLlamason', '06/12/2012', 0);
INSERT INTO Customers VALUES (null, 'Norma', 'Mortenson', '12/17/2009', 0);
--###########
INSERT INTO Products VALUES (null, 'Dell XYZ', 'A blah blah ghz blah processor', 1000.78, 1, 1);
INSERT INTO Products VALUES (null, 'Plutoneum', '1 gram of Plutonium-240', 99000.23, 3, 2);
INSERT INTO Products VALUES (null, 'Clue', 'Mystery Board game', 8.99, 5, 3);
INSERT INTO Products VALUES (null, 'Dune', 'Frank Herbert softcover', 6.99, 4, 4);
--###########
INSERT INTO PaymentTypes VALUES (null, 'Amex', 123456789, 1);
INSERT INTO PaymentTypes VALUES (null, 'Bank of America', 987654321, 1);
INSERT INTO PaymentTypes VALUES (null, 'Visa', 6574839201, 1);
INSERT INTO PaymentTypes VALUES (null, 'Bank of America', 098765432, 2);
INSERT INTO PaymentTypes VALUES (null, 'Visa', 102938475, 2);
--###########
INSERT INTO Orders VALUES (null, 4, 1, 10.99);
INSERT INTO Orders VALUES (null, 3, 2, 309.32);
--###########
INSERT INTO Order_LISTS VALUES (null, 4, 1);
INSERT INTO Order_LISTS VALUES (null, 1, 1);
INSERT INTO Order_LISTS VALUES (null, 2, 1);
INSERT INTO Order_LISTS VALUES (null, 2, 2);
INSERT INTO Order_LISTS VALUES (null, 1, 2);
--###########
INSERT INTO Departments VALUES (null, 'Payroll', 'Suzy Moneyperson', 10000);
INSERT INTO Departments VALUES (null, 'IT', 'Joe McUnpleasant', 13000);
INSERT INTO Departments VALUES (null, 'Fullfillmet', 'Stockard Channing', 7000);
INSERT INTO Departments VALUES (null, 'Sales', 'Selly McSellerson', 20000);
--###########
INSERT INTO Employees VALUES (null, 'Gene', 'Simmons', 1, 35000);
INSERT INTO Employees VALUES (null, 'Paul', 'Stanley', 3, 45000);
INSERT INTO Employees VALUES (null, 'Peter', 'Criss', 2, 65000);
INSERT INTO Employees VALUES (null, 'Ace', 'Frehley', 4, 78900);
--###########
INSERT INTO Computers VALUES (null, 'Apple', 'MacBook Pro','10/10/2017', 'n/a', 4);
INSERT INTO Computers VALUES (null, 'Apple', 'iMac G3','03/15/1998', '12/12/2003', 1);
--###########
INSERT INTO TrainingPrograms VALUES (null, 'How Not To Suck', '11/03/2017','11/15/2017', 30);
INSERT INTO TrainingPrograms VALUES (null, 'Sell Stuff For Money', '12/03/2017','12/15/2017', 25);
--###########
INSERT INTO Training_LIST VALUES (null, 1, 1);
INSERT INTO Training_LIST VALUES (null, 1, 3);
INSERT INTO Training_LIST VALUES (null, 1, 2);
INSERT INTO Training_LIST VALUES (null, 2, 1);
INSERT INTO Training_LIST VALUES (null, 2, 3);
INSERT INTO Training_LIST VALUES (null, 2, 4);

