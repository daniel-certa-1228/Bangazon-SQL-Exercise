--CLEAR ALL BEFORE RUN
DELETE FROM Training_LIST;
DELETE FROM TrainingPrograms;
DELETE FROM Computers;
DELETE FROM Departments;
DELETE FROM Employees;
DELETE FROM PaymentTypes;
DELETE FROM Customers;
DELETE FROM Order_LISTS;
DELETE FROM Orders;
DELETE FROM Products;
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

CREATE TABLE 'Orders' (
	'OrderId' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	'CustomerId' INTEGER NOT NULL,
	'PaymentType' INTEGER NOT NULL,
	'OrderTotal' FLOAT(6,2) NOT NULL,
	FOREIGN KEY('CustomerId') REFERENCES 'Customers' ('CustomerId'),
	FOREIGN KEY('PaymentType') REFERENCES 'PaymentTypes' ('PaymentTypeId')
);

CREATE TABLE 'Order_LISTS' (
	'Order_LIST_Id' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
		'CustomerId' INTEGER NOT NULL,
		'OrderId' INTEGER NOT NULL,
		FOREIGN KEY('CustomerId') REFERENCES 'Customers' ('CustomerId'),
		FOREIGN KEY('OrderId') REFERENCES 'Orders' ('OrderId')
);

CREATE TABLE 'Customers' (
	'CustomerId' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	'Customer_FirstName' TEXT NOT NULL,
	"Customer_LastName" TEXT NOT NULL,
	"Customer_Created" TEXT NOT NULL,
	"Customer_Inactive" BOOLEAN NOT NULL DEFAULT 0
);

CREATE TABLE 'PaymentTypes' (
	'PaymentTypeId' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	'PaymentType' TEXT NOT NULL,
	"PaymentAccountNum" INTEGER NOT NULL,
	"CustomerId" INTEGER NOT NULL,
	FOREIGN KEY('CustomerId') REFERENCES 'Customers' ('CustomerId')
);


--Epmloyee and Company Setup
CREATE TABLE 'Employees' (
	'EmployeeId' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	'Employee_FirstName' TEXT NOT NULL,
	"Employee_LastName" TEXT NOT NULL,
	"DepartmentId" INTEGER NOT NULL,
	FOREIGN KEY('DepartmentId') REFERENCES 'Departments' ('DepartmentId')
);

CREATE TABLE 'Departments' (
	'DepartmentId' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	'Department_Name' TEXT NOT NULL,
	"Supervisor_Name" TEXT NOT NULL,
	"Budget" INTEGER NOT NULL
);

CREATE TABLE 'Computers' (
	'ComputerId' INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
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















