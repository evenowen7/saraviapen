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

INSERT INTO Customer VALUES('CTR001', 'Jovan' , 'Male' , 'Jl. Hati 2' , '2002-02-12' , '081234567891')
INSERT INTO Customer VALUES('CTR002', 'Jovanca' , 'Female' , 'Jl. Ampela 3' , '2000-10-10' , '085256789123')
INSERT INTO Customer VALUES('CTR003', 'KurtCobain' , 'Male' , 'Jl. Kisamaun 1' , '2002-01-10' , '081234565432')
INSERT INTO Customer VALUES('CTR004', 'Jackson' , 'Male' , 'Jl. Cibodas 1' , '2003-05-25' , '088898765432')
INSERT INTO Customer VALUES('CTR005', 'Stecven' , 'Male' , 'Jl. Kisamaun 2' , '2000-12-11' , '087778797076')
INSERT INTO Customer VALUES('CTR006', 'Nicolas' , 'Male' , 'Jl. Cimone 6' , '2004-05-24' , '081122334455')
INSERT INTO Customer VALUES('CTR007', 'Stefani’' , 'Female' , 'Jl. Cikokol 5' , '2002-08-23' , '081111112233')
INSERT INTO Customer VALUES('CTR008', 'Andreas' , 'Male' , 'Jl. Hati 1' , '2010-05-11' , '081234443221')
INSERT INTO Customer VALUES('CTR009', 'Angelica' , 'Female' , 'Jl. Jeruk 2' , '1995-09-09' , '081209874567')
INSERT INTO Customer VALUES('CTR010', 'Kevin' , 'Male' , 'Jl. Tomang Raya' , '1999-11-30' , '081709876784')

INSERT INTO Staff VALUES('STF001', 'Jono' , 'Male' , 'Jl. Umar 5' , '2001-09-02' , '089447871831' , '5000000')
INSERT INTO Staff VALUES('STF002', 'James' , 'Male' , 'Jl. Imam Bondjol' , '2001-05-02' , '080621560462' , '4500000')
INSERT INTO Staff VALUES('STF003', 'Jenny' , 'Female' , 'Jl. Jenderal Soedirman' , '2001-01-11' , '082321505725' , '3000000')
INSERT INTO Staff VALUES('STF004', 'Jane' , 'Female' , 'Jl. Diponegoro' , '2003-03-03' , '080708012138' , '8000000')
INSERT INTO Staff VALUES('STF005', 'Jennifer' , 'Female' , 'Jl. Kutabumi' , '2004-04-04' , '084234920832' , '7500000')
INSERT INTO Staff VALUES('STF006', 'Julian' , 'Male' , 'Jl. Serang' , '2005-05-05' , '083049782405' , '1500000')
INSERT INTO Staff VALUES('STF007', 'Jacob' , 'Male' , 'Jl. Mangga 9' , '2006-06-06' , '084437976658' , '2300000')
INSERT INTO Staff VALUES('STF008', 'John' , 'Male' , 'Jl. Melon 2' , '2007-07-07' , '080145595179' , '4200000')
INSERT INTO Staff VALUES('STF009', 'Junius' , 'Male' , 'Jl. Pepaya 1' , '2008-08-08' , '088846327113' , '3300000')
INSERT INTO Staff VALUES('STF010', 'Jessica' , 'Female' , 'Jl. In Aja Dulu' , '2002-12-22' , '081078957379' , '4000000')

INSERT INTO Vendor VALUES('VDR001', 'Jimmy Industry' , 'Jl. Umar 1' , '081298765432' , 'jimmy@vendor.com')
INSERT INTO Vendor VALUES('VDR002', 'Mike Company' , 'Jl. Umar 3' , '081298765431' , 'mike@vendor.com')
INSERT INTO Vendor VALUES('VDR003', 'Michael Industry' , 'Jl. Tongkol 1' , '081298765436' , 'michael@vendor.com')
INSERT INTO Vendor VALUES('VDR004', 'Mona Company' , 'Jl. Tenggiri 1' , '081298765435' , 'mona@vendor.com')
INSERT INTO Vendor VALUES('VDR005', 'Maya Company' , 'Jl. Kakap 1' , '081298765434' , 'maya@vendor.com')
INSERT INTO Vendor VALUES('VDR006', 'Matthew Company' , 'Jl. Gurame 1' , '081298765433' , 'matthew@vendor.com')
INSERT INTO Vendor VALUES('VDR007', 'Monica Company' , 'Jl. Lele 1' , '081298765412' , 'monica@vendor.com')
INSERT INTO Vendor VALUES('VDR008', 'Marcell Company' , 'Jl. Bandeng 1' , '081298765231' , 'marcell@vendor.com')
INSERT INTO Vendor VALUES('VDR009', 'Mineta Company' , 'Jl. Gurame 4' , '081298765487' , 'mineta@vendor.com')
INSERT INTO Vendor VALUES('VDR010', 'Maria Company' , 'Jl. Paus 2' , '081298765499' , 'maria@vendor.com')



INSERT INTO penMaterial VALUES('PML001', 'Wood' , '1000' , '110')
INSERT INTO penMaterial VALUES('PML002', 'Plastic' , '500' , '159')
INSERT INTO penMaterial VALUES('PML003', 'Metal' , '10000' , '232')
INSERT INTO penMaterial VALUES('PML004', 'Wood' , '1000' , '105')
INSERT INTO penMaterial VALUES('PML005', 'Plastic' , '500' , '230')
INSERT INTO penMaterial VALUES('PML006', 'Plastic' , '500' , '200')
INSERT INTO penMaterial VALUES('PML007', 'Wood' , '1000' , '109')
INSERT INTO penMaterial VALUES('PML008', 'Metal' , '10000' , '529')
INSERT INTO penMaterial VALUES('PML009', 'Metal' , '10000' , '192')
INSERT INTO penMaterial VALUES('PML010', 'Wood' , '1000' , '298')

INSERT INTO Pen VALUES('PEN001', 'Jokyo Pen' , '10500' , '50' , 'PML001')
INSERT INTO Pen VALUES('PEN002', 'Pilol Pen' , '11500' , '55' , 'PML002')
INSERT INTO Pen VALUES('PEN003', 'Snomwan Pen' , '12500' , '60' , 'PML003')
INSERT INTO Pen VALUES('PEN004', 'Feber Castall Pen' , '13500' , '70' , 'PML004')
INSERT INTO Pen VALUES('PEN005', 'Milky Pen' , '14500' , '75' , 'PML005')
INSERT INTO Pen VALUES('PEN006', 'Standup Pen' , '15500' , '80' , 'PML006')
INSERT INTO Pen VALUES('PEN007', 'Boxing Pen' , '16500' , '85' , 'PML007')
INSERT INTO Pen VALUES('PEN008', 'Festar Pen' , '17500' , '90' , 'PML008')
INSERT INTO Pen VALUES('PEN009', 'Popi Pen' , '18500' , '25' , 'PML009')
INSERT INTO Pen VALUES('PEN010', 'Konko Pen' , '19500' , '90' , 'PML010')

INSERT INTO salesTransaction VALUES('SLT001', 'CTR001' , 'STF001' , 'Cash' , '2020-01-01')
INSERT INTO salesTransaction VALUES('SLT002', 'CTR002' , 'STF002' , 'Debit' , '2020-02-02')
INSERT INTO salesTransaction VALUES('SLT003', 'CTR003' , 'STF003' , 'Credit' , '2020-03-03')
INSERT INTO salesTransaction VALUES('SLT004', 'CTR004' , 'STF004' , 'E-Money' , '2020-04-04')
INSERT INTO salesTransaction VALUES('SLT005', 'CTR005' , 'STF005' , 'Cash' , '2020-05-05')
INSERT INTO salesTransaction VALUES('SLT006', 'CTR006' , 'STF006' , 'Debit' , '2020-06-06')
INSERT INTO salesTransaction VALUES('SLT007', 'CTR007' , 'STF007' , 'Credit' , '2020-07-07')
INSERT INTO salesTransaction VALUES('SLT008', 'CTR008' , 'STF008' , 'E-Money' , '2020-08-08')
INSERT INTO salesTransaction VALUES('SLT009', 'CTR009' , 'STF009' , 'Cash' , '2020-09-25')
INSERT INTO salesTransaction VALUES('SLT010', 'CTR010' , 'STF010' , 'Debit' , '2020-10-22')
INSERT INTO salesTransaction VALUES('SLT011', 'CTR001' , 'STF001' , 'Credit' , '2020-11-11')
INSERT INTO salesTransaction VALUES('SLT012', 'CTR002' , 'STF002' , 'E-Money' , '2020-11-12')
INSERT INTO salesTransaction VALUES('SLT013', 'CTR003' , 'STF003' , 'Cash' , '2020-11-13')
INSERT INTO salesTransaction VALUES('SLT014', 'CTR004' , 'STF004' , 'Debit' , '2020-12-25')
INSERT INTO salesTransaction VALUES('SLT015', 'CTR005' , 'STF005' , 'Credit' , '2020-12-29')


INSERT INTO purchaseTransaction VALUES('PCT001', 'VDR001' , 'STF001' , 'Cash' , '2020-01-02')
INSERT INTO purchaseTransaction VALUES('PCT002', 'VDR002' , 'STF002' , 'Debit' , '2020-02-03')
INSERT INTO purchaseTransaction VALUES('PCT003', 'VDR003' , 'STF003' , 'Credit' , '2020-03-04')
INSERT INTO purchaseTransaction VALUES('PCT004', 'VDR004' , 'STF004' , 'E-Money' , '2020-04-05')
INSERT INTO purchaseTransaction VALUES('PCT005', 'VDR005' , 'STF005' , 'Cash' , '2020-05-06')
INSERT INTO purchaseTransaction VALUES('PCT006', 'VDR006' , 'STF006' , 'Debit' , '2020-06-07')
INSERT INTO purchaseTransaction VALUES('PCT007', 'VDR007' , 'STF007' , 'Credit' , '2020-07-08')
INSERT INTO purchaseTransaction VALUES('PCT008', 'VDR008' , 'STF008' , 'E-Money' , '2020-08-09')
INSERT INTO purchaseTransaction VALUES('PCT009', 'VDR009' , 'STF009' , 'Cash' , '2020-09-10')
INSERT INTO purchaseTransaction VALUES('PCT010', 'VDR010' , 'STF010' , 'Debit' , '2020-10-11')
INSERT INTO purchaseTransaction VALUES('PCT011', 'VDR001' , 'STF001' , 'Credit' , '2020-11-12')
INSERT INTO purchaseTransaction VALUES('PCT012', 'VDR002' , 'STF002' , 'E-Money' , '2020-11-13')
INSERT INTO purchaseTransaction VALUES('PCT013', 'VDR003' , 'STF003' , 'Cash' , '2020-11-28')
INSERT INTO purchaseTransaction VALUES('PCT014', 'VDR004' , 'STF004' , 'Debit' , '2020-12-14')
INSERT INTO purchaseTransaction VALUES('PCT015', 'VDR005' , 'STF005' , 'Credit' , '2020-12-22')

select * from salesDetail
INSERT INTO salesDetail VALUES('SLT001', 'PEN001' , '10' , '10')
INSERT INTO salesDetail VALUES('SLT002', 'PEN002' , '15' , '5')
INSERT INTO salesDetail VALUES('SLT003', 'PEN003' , '16' , '15')
INSERT INTO salesDetail VALUES('SLT004', 'PEN004' , '20' , '10')
INSERT INTO salesDetail VALUES('SLT005', 'PEN005' , '102' , '50')
INSERT INTO salesDetail VALUES('SLT006', 'PEN006' , '24' , '20')
INSERT INTO salesDetail VALUES('SLT007', 'PEN007' , '252' , '99')
INSERT INTO salesDetail VALUES('SLT008', 'PEN008' , '90' , '24')
INSERT INTO salesDetail VALUES('SLT009', 'PEN009' , '123' , '56')
INSERT INTO salesDetail VALUES('SLT010', 'PEN010' , '309' , '60')
INSERT INTO salesDetail VALUES('SLT011', 'PEN001' , '33' , '11')
INSERT INTO salesDetail VALUES('SLT012', 'PEN002' , '97' , '29')
INSERT INTO salesDetail VALUES('SLT013', 'PEN003' , '29' , '22')
INSERT INTO salesDetail VALUES('SLT014', 'PEN004' , '24' , '20')
INSERT INTO salesDetail VALUES('SLT015', 'PEN005' , '55' , '54')
INSERT INTO salesDetail VALUES('SLT016', 'PEN006' , '23' , '18')
INSERT INTO salesDetail VALUES('SLT017', 'PEN007' , '52' , '10')
INSERT INTO salesDetail VALUES('SLT018', 'PEN008' , '23' , '5')
INSERT INTO salesDetail VALUES('SLT019', 'PEN009' , '29' , '15')
INSERT INTO salesDetail VALUES('SLT020', 'PEN010' , '70' , '29')
INSERT INTO salesDetail VALUES('SLT021', 'PEN001' , '77' , '10')
INSERT INTO salesDetail VALUES('SLT022', 'PEN002' , '33' , '16')
INSERT INTO salesDetail VALUES('SLT023', 'PEN003' , '45' , '13')
INSERT INTO salesDetail VALUES('SLT024', 'PEN004' , '24' , '23')
INSERT INTO salesDetail VALUES('SLT025', 'PEN005' , '42' , '22')

INSERT INTO purchaseDetail VALUES('PCT001', 'PEN001' , '10' , '1')
INSERT INTO purchaseDetail VALUES('PCT002', 'PEN002' , '15' , '7')
INSERT INTO purchaseDetail VALUES('PCT003', 'PEN003' , '19' , '3')
INSERT INTO purchaseDetail VALUES('PCT004', 'PEN004' , '10' , '9')
INSERT INTO purchaseDetail VALUES('PCT005', 'PEN005' , '11' , '1')
INSERT INTO purchaseDetail VALUES('PCT006', 'PEN006' , '25' , '20')
INSERT INTO purchaseDetail VALUES('PCT007', 'PEN007' , '55' , '15')
INSERT INTO purchaseDetail VALUES('PCT008', 'PEN008' , '15' , '4')
INSERT INTO purchaseDetail VALUES('PCT009', 'PEN009' , '23' , '3')
INSERT INTO purchaseDetail VALUES('PCT010', 'PEN010' , '20' , '4')
INSERT INTO purchaseDetail VALUES('PCT011', 'PEN001' , '26' , '15')
INSERT INTO purchaseDetail VALUES('PCT012', 'PEN002' , '98' , '54')
INSERT INTO purchaseDetail VALUES('PCT013', 'PEN003' , '102' , '98')
INSERT INTO purchaseDetail VALUES('PCT014', 'PEN004' , '29' , '19')
INSERT INTO purchaseDetail VALUES('PCT015', 'PEN005' , '33' , '31')
INSERT INTO purchaseDetail VALUES('PCT016', 'PEN006' , '20' , '18')
INSERT INTO purchaseDetail VALUES('PCT017', 'PEN007' , '72' , '64')
INSERT INTO purchaseDetail VALUES('PCT018', 'PEN008' , '22' , '12')
INSERT INTO purchaseDetail VALUES('PCT019', 'PEN009' , '23' , '19')
INSERT INTO purchaseDetail VALUES('PCT020', 'PEN010' , '49' , '28')
INSERT INTO purchaseDetail VALUES('PCT021', 'PEN001' , '17' , '2')
INSERT INTO purchaseDetail VALUES('PCT022', 'PEN002' , '24' , '6')
INSERT INTO purchaseDetail VALUES('PCT023', 'PEN003' , '20' , '12')
INSERT INTO purchaseDetail VALUES('PCT024', 'PEN004' , '24' , '23')
INSERT INTO purchaseDetail VALUES('PCT025', 'PEN005' , '12' , '9')

--on update cascade
select * from salesTransaction
INSERT INTO salesTransaction VALUES('SLT016', 'CTR006' , 'STF006' , 'Debit' , '2020-12-29')
INSERT INTO salesTransaction VALUES('SLT017', 'CTR007' , 'STF007' , 'Cash' , '2020-12-30')

INSERT INTO purchaseTransaction VALUES('PCT016', 'VDR006' , 'STF006' , 'E-Money' , '2020-12-23')
INSERT INTO purchaseTransaction VALUES('PCT017', 'VDR007' , 'STF007' , 'Credit' , '2020-12-25')

INSERT INTO salesDetail VALUES('SLT026', 'PEN006' , '49' , '25')
INSERT INTO salesDetail VALUES('SLT027', 'PEN007' , '39' , '28')

INSERT INTO purchaseDetail VALUES('PCT026', 'PEN006' , '49' , '18')
INSERT INTO purchaseDetail VALUES('PCT027', 'PEN007' , '82' , '58')

--e nomor 1
SELECT Customer.customerID, Customer.customerName, salesTransaction.salesDate, SUM(salesDetail.qtyPen) AS QUANTITY FROM Customer, salesTransaction, salesDetail
WHERE Customer.customerID = salesTransaction.customerID AND salesTransaction.salesTransactionID = salesDetail.salesID AND DAY(salesTransaction.salesDate) = 25 AND penID LIKE 'PEN009'
GROUP BY Customer.customerID, Customer.customerName, salesTransaction.salesDate

--e nomor 2
SELECT Pen.penID, Pen.penBrand, COUNT(penMaterial.materialStock) AS TOTAL FROM Pen, penMaterial
WHERE Pen.materialID = penMaterial.materialID AND penMaterial.materialStock > 6 AND Pen.penBrand LIKE 'Milky%'
GROUP BY Pen.penID, Pen.penBrand

--e nomor 3
SELECT Customer.customerName, salesTransaction.salesDate, COUNT(Pen.penStock) AS TOTAL, SUM(salesDetail.qtyPen) AS QUANTITY FROM Customer, salesTransaction, salesDetail, Pen
WHERE Customer.customerID = salesTransaction.customerID AND salesTransaction.salesTransactionID = salesDetail.salesID AND salesDetail.penID =  Pen.penID AND Pen.penStock > 10 AND MONTH(salesTransaction.salesDate) = 9
GROUP BY Customer.customerName, salesTransaction.salesDate

--e nomor 4
--4.Display StaffName, Staff Gender (obtained from the first letter of staff’s gender), CustomerName, and Total Sales Transaction 
--(obtained from the count of the sales transaction) for every sales transaction that happened on an even day and the sum of quantity is lower or equal to 10.

SELECT Staff.staffName, [Staff Gender] = SUBSTRING(Staff.staffGender,1,1), Customer.customerName, [Total Sales Transaction] = COUNT(salesTransaction.salesTransactionID)
FROM salesTransaction, Staff, Customer, salesDetail
WHERE Customer.customerID = salesTransaction.customerID AND salesTransaction.salesTransactionID = salesDetail.salesID AND Staff.staffID = salesTransaction.staffID AND
DAY(salesTransaction.salesDate) % 2 = 0
GROUP BY staffName, staffGender, customerName
HAVING SUM(salesDetail.qtyPen) <= 10

--5.Display CustomerName (obtained from customer name in uppercase format), CustomerGender, and SalesTransactionId for every sales transaction that happened on the 22th 
--and the quantity is greater than the average quantity of all sales transaction. The result query doesn’t have duplicate rows.

SELECT DISTINCT [CustomerName] = UPPER(Customer.customerName), Customer.customerGender, salesTransaction.salesTransactionID
FROM salesTransaction, Customer, salesDetail, 
(
	SELECT AVG(salesDetail.qtyPen) AS 'q' 
	FROM salesDetail
) AS x
WHERE Customer.customerID = salesTransaction.customerID AND salesTransaction.salesTransactionID = salesDetail.salesID AND DAY(salesTransaction.salesDate) = 22 AND qtyPen > x.q

--6.Display VendorName, PurchaseDate (obtained from purchases date in ‘Mon dd, yyyy’ format), and MaterialName (obtained from the material of pen name in lowercase format) 
-- for every purchase transaction with a pen material price is greater than the average price of all materials and the vendor’s name ends with ‘ Industry’.

SELECT DISTINCT Vendor.vendorName, [Purchase Date] = FORMAT(purchaseTransaction.purchaseDate, 'MMMM, dd, yyyy'), [Material Name] = LOWER(penMaterial.materialName) 
FROM Vendor, purchaseTransaction, penMaterial, purchaseDetail, Pen, 
(
	SELECT AVG(penMaterial.materialPrice) as 'p'
	FROM penMaterial
) AS y
WHERE Vendor.vendorID = purchaseTransaction.vendorID AND purchaseTransaction.purchaseTransactionID = purchaseDetail.purchaseID AND purchaseDetail.penID = Pen.penID AND Pen.materialID = penMaterial.materialID 
AND penMaterial.materialPrice > p AND Vendor.vendorName LIKE '% Industry'

--7.	Display Total Purchase Transaction (obtained from count of purchase transactions and ended with ‘ Transaction(s)’), VendorName, Staff Name (obtained from staff’s name from the first character until a character before space), and PurchaseTransactionDate 
--for every purchase transaction with the quantity is lower than the average quantity of all purchase transaction and the purchase transaction happened on Sunday.
SELECT DISTINCT CAST(COUNT(purchaseTransaction.purchaseTransactionID)AS VARCHAR(5)) + ' Transaction(s)' , Vendor.vendorName, Staff.staffName, purchaseTransaction.purchaseDate
FROM purchaseTransaction, Vendor, Staff, purchaseDetail,
(
	SELECT AVG(purchaseDetail.qtyPen) AS 'p'
	FROM purchaseDetail
) AS y
WHERE Staff.staffID = purchaseTransaction.staffID AND purchaseTransaction.vendorID = Vendor.vendorID AND purchaseTransaction.purchaseTransactionID = purchaseDetail.purchaseID AND purchaseDetail.qtyPen < p AND DATENAME(weekday, purchaseTransaction.purchaseDate) = 'Sunday'
GROUP BY Vendor.vendorName, purchaseTransaction.purchaseDate, Staff.staffName

--8.	Display VendorName, Transaction Date (obtained from purchases date in ‘dd mon yyyy’ format), PenMaterialName, and Material Number (obtained from PenMaterialId by replacing the first three characters with ‘PM’) 
--for every purchase transaction with the pen material stock is greater than the average of all pen material stock and the total price (obtained from the sum of transaction quantity multiplied with pen material price) is greater than 500000. Sort the result by vendor name in descending order.
SELECT Vendor.vendorName, CONVERT(VARCHAR, purchaseTransaction.purchaseDate, 106) AS 'Transaction Date', penMaterial.materialName, [Material Number] = REPLACE(LEFT(penMaterial.materialID, 3) , 'PML', 'PM') + RIGHT(penMaterial.materialID, 3)
FROM Vendor, purchaseTransaction, purchaseDetail, Pen, penMaterial,
(
	SELECT AVG(penMaterial.materialStock) AS 'p'
	FROM penMaterial
) AS y
WHERE Vendor.vendorID = purchaseTransaction.vendorID AND purchaseTransaction.purchaseTransactionID = purchaseDetail.purchaseID AND purchaseDetail.penID = Pen.penID AND Pen.materialID = penMaterial.materialID AND penMaterial.materialStock > p 
GROUP BY Vendor.vendorName,penMaterial.materialName, purchaseTransaction.purchaseDate, penMaterial.materialID
HAVING SUM(purchaseDetail.qtyPen * penMaterial.materialPrice) > 500000
ORDER BY Vendor.vendorName DESC


--9.	Create a view named ‘ViewSalesTransaction’ to display StaffName, CustomerName, Total Sales Transaction (obtained from the count of sales transaction), and Maximum Sales (obtained from the maximum of quantity) 
-- for every sales transaction made by a customer whose name contains ‘c’ and the Total Sales Transaction is greater than 2.
CREATE VIEW ViewSalesTransaction AS
SELECT Staff.staffName, Customer.customerName, [Total Sales Transaction] = COUNT(salesTransaction.salesTransactionID), [Maximum Sales] = MAX(salesDetail.qtyPen)
FROM Staff, Customer, salesTransaction, salesDetail
WHERE Customer.customerID = salesTransaction.customerID AND Staff.staffID = salesTransaction.staffID AND salesTransaction.salesTransactionID = salesDetail.salesID AND Customer.customerName LIKE '%c%' 
GROUP BY Staff.staffName, Customer.customerName
HAVING COUNT(salesTransaction.salesTransactionID) > 2


--10.	Create a view named ‘ViewPurchaseDetail’ to display VendorName, Total Purchase Quantity (obtained from the sum of quantity), and Total Purchase Transaction (obtained from the count of purchase transaction) 
--for every staff whose gender is male, and the Total Purchase Transaction is greater than 1.
CREATE VIEW ViewPurchaseDetail AS
SELECT Vendor.vendorName, [Total Purchase Quantity] = SUM(purchaseDetail.qtyPen), [Total Purchase Transaction] = COUNT(purchaseTransaction.purchaseTransactionID)
FROM Vendor, purchaseDetail, purchaseTransaction, Staff
WHERE Vendor.vendorID = purchaseTransaction.vendorID AND purchaseTransaction.purchaseTransactionID = purchaseDetail.purchaseID AND Staff.staffGender = 'Male'
GROUP BY Vendor.vendorName
HAVING COUNT(purchaseTransaction.purchaseTransactionID) > 1
