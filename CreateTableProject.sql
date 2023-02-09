CREATE DATABASE Bluejack_Factory

USE Bluejack_Factory
GO

CREATE TABLE Staff(
	StaffId CHAR(5) PRIMARY KEY,
	StaffName VARCHAR(100), 
	StaffEmail VARCHAR(100), 
	StaffPhoneNumber VARCHAR(20), 
	StaffAddress VARCHAR (100), 
	StaffDateOfBirth DATE,
	StaffGender VARCHAR(6),
	CONSTRAINT ceksId CHECK (staffId like 'SF[0-9][0-9][0-9]'),
	CONSTRAINT ceksGender CHECK (staffGender IN('Male', 'Female'))
)

CREATE TABLE Material(
	MaterialId CHAR(5) PRIMARY KEY,
	MaterialName VARCHAR(100),
	MaterialPrice NUMERIC(20),
	CONSTRAINT cekmId CHECK (MaterialId LIKE 'MT[0-9][0-9][0-9]'),
	CONSTRAINT cekmName CHECK (LEN(MaterialName) > 2),
	CONSTRAINT cekmPrice CHECK (MaterialPrice > 0)
)

CREATE TABLE Product(
	ProductId CHAR(5) PRIMARY KEY,
	ProductName VARCHAR(100),
	MaterialId CHAR(5) REFERENCES Material ON UPDATE CASCADE ON DELETE CASCADE,
	ProductPrice NUMERIC,
	CONSTRAINT cekprId CHECK (ProductId LIKE 'PR[0-9][0-9][0-9]'),
	CONSTRAINT cekpName CHECK (LEN(ProductName) > 2),
	CONSTRAINT cekpPrice CHECK (ProductPrice > 1000 AND ProductPrice < 1000000)
)

CREATE TABLE Customer(
	CustomerId CHAR(5) PRIMARY KEY,
	CustomerName VARCHAR(100),
	CustomerPhoneNumer VARCHAR(20),
	CustomerAddress VARCHAR(100),
	CustomerGender VARCHAR(7),
	CustomerEmail VARCHAR(100),
	CustomerDateOfBirth DATE,
	CONSTRAINT cekcId CHECK (CustomerId LIKE 'CS[0-9][0-9][0-9]'),
	CONSTRAINT cekcGender CHECK (CustomerGender IN('Male', 'Female'))
)

CREATE TABLE Distributor(
	DistributorId CHAR(5) PRIMARY KEY,
	DistributorName VARCHAR(100),
	DistributorPhoneNumber VARCHAR (20),
	DistributorAddress VARCHAR(100),
	DistributorEmail VARCHAR(100),
	CONSTRAINT cekdId CHECK (DistributorId LIKE 'DS[0-9][0-9][0-9]')	
)

CREATE TABLE PurchaseTransaction(
	PurchaseId CHAR(5) PRIMARY KEY,
	StaffId CHAR(5) REFERENCES Staff ON UPDATE CASCADE ON DELETE CASCADE,
	DistributorId CHAR(5) REFERENCES Distributor ON UPDATE CASCADE ON DELETE CASCADE,
	PurchaseDate DATE,
	CONSTRAINT cekptId CHECK (PurchaseId LIKE 'PT[0-9][0-9][0-9]')
)

CREATE TABLE SalesTransaction(
	SalesId CHAR(5) PRIMARY KEY,
	StaffId CHAR(5) REFERENCES Staff ON UPDATE CASCADE ON DELETE CASCADE,
	CustomerId CHAR(5) REFERENCES Customer ON UPDATE CASCADE ON DELETE CASCADE,
	SalesDate DATE, 
	CONSTRAINT cekstId CHECK (SalesId LIKE 'ST[0-9][0-9][0-9]')
)

CREATE TABLE DetailPurchaseTransaction(
	PurchaseId CHAR(5) Foreign Key References PurchaseTransaction,
	MaterialId CHAR(5) Foreign Key References Material,
	PurchaseQty NUMERIC,
	CONSTRAINT cekdptQty CHECK (PurchaseQty > 0)
)

CREATE TABLE DetailSalesTransaction(
	ProductId CHAR(5) Foreign Key References Product on update cascade on delete cascade,
	SalesId CHAR(5) Foreign Key References SalesTransaction on update cascade on delete cascade,
	SalesQty NUMERIC,
	CONSTRAINT cekdstQuantity CHECK (SalesQty > 0)
)

SP_MSFOREACHTABLE 'SELECT * FROM ?'