CREATE DATABASE SaraviaPen

USE SaraviaPen

CREATE TABLE Customer(
customerID CHAR(6) PRIMARY KEY CHECK(customerID LIKE 'CTR[0-9][0-9][0-9]'),
customerName VARCHAR(255) NOT NULL,
customerGender CHAR(6) NOT NULL,
customerAddress VARCHAR(255) NOT NULL,
customerDOB DATE NOT NULL,
customerPhone VARCHAR(12) NOT NULL
);

CREATE TABLE Staff(
staffID CHAR(6) PRIMARY KEY CHECK(staffID LIKE 'STF[0-9][0-9][0-9]'),
staffName VARCHAR(255) CHECK (staffName LIKE '___%' )NOT NULL,
staffGender CHAR(6) NOT NULL,
staffAddress VARCHAR(255) NOT NULL,
staffDOB DATE NOT NULL,
staffPhone VARCHAR(12) NOT NULL,
staffSalary VARCHAR(15) NOT NULL
);

CREATE TABLE penMaterial(
materialID CHAR(6) PRIMARY KEY CHECK(materialID LIKE 'PML[0-9][0-9][0-9]'),
materialName VARCHAR(25) NOT NULL,
materialPrice INT NOT NULL,
materialStock INT CHECK(materialStock > 100) NOT NULL,
);

CREATE TABLE Pen(
penID CHAR(6) PRIMARY KEY CHECK(penID LIKE 'PEN[0-9][0-9][0-9]'),
penBrand VARCHAR(25) CHECK (penBrand LIKE '% Pen') NOT NULL,
penPrice INT CHECK (penPrice BETWEEN 10000 AND 50000) NOT NULL,
penStock INT NOT NULL,
materialID CHAR(6) FOREIGN KEY REFERENCES penMaterial(materialID)
);

CREATE TABLE salesTransaction(
salesTransactionID CHAR(6) PRIMARY KEY CHECK(salesTransactionID LIKE 'SLT[0-9][0-9][0-9]'),
customerID CHAR(6) FOREIGN KEY REFERENCES Customer(customerID),
staffID CHAR(6) FOREIGN KEY REFERENCES Staff(staffID),
salesType VARCHAR(20) NOT NULL,
salesDate DATE CHECK (salesDate LIKE '2020-%-%'),
);
--BAGIAN penStock dihubungin

CREATE TABLE salesDetail(
salesID CHAR(6) PRIMARY KEY CHECK(salesID LIKE 'SLT[0-9][0-9][0-9]'),
penID CHAR(6) FOREIGN KEY REFERENCES Pen(penID),
penStock INT NOT NULL,
qtyPen INT NOT NULL,
);

CREATE TABLE Vendor(
vendorID CHAR(6) PRIMARY KEY CHECK(vendorID LIKE 'VDR[0-9][0-9][0-9]'),
vendorName VARCHAR(255) NOT NULL,
vendorAddress VARCHAR(255) NOT NULL,
vendorPhone VARCHAR(12) NOT NULL,
vendorEmail VARCHAR(255) CHECK (vendorEmail LIKE '%@%')
);

CREATE TABLE purchaseTransaction(
purchaseTransactionID CHAR(6) PRIMARY KEY CHECK(purchaseTransactionID LIKE 'PCT[0-9][0-9][0-9]'),
vendorID CHAR(6) FOREIGN KEY REFERENCES Vendor(vendorID),
staffID CHAR(6) FOREIGN KEY REFERENCES Staff(staffID),
purchaseType VARCHAR(20) NOT NULL,
purchaseDate DATE NOT NULL,
);

CREATE TABLE purchaseDetail(
purchaseID CHAR(6) PRIMARY KEY CHECK(purchaseID LIKE 'PCT[0-9][0-9][0-9]'),
penID CHAR(6) FOREIGN KEY REFERENCES Pen(penID),
penStock INT NOT NULL,
qtyPen INT NOT NULL,
);