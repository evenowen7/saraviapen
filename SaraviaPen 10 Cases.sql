USE SaraviaPen

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

SELECT * FROM ViewSalesTransaction
--10.	Create a view named ‘ViewPurchaseDetail’ to display VendorName, Total Purchase Quantity (obtained from the sum of quantity), and Total Purchase Transaction (obtained from the count of purchase transaction) 
--for every staff whose gender is male, and the Total Purchase Transaction is greater than 1.
CREATE VIEW ViewPurchaseDetail AS
SELECT Vendor.vendorName, [Total Purchase Quantity] = SUM(purchaseDetail.qtyPen), [Total Purchase Transaction] = COUNT(purchaseTransaction.purchaseTransactionID)
FROM Vendor, purchaseDetail, purchaseTransaction, Staff
WHERE Vendor.vendorID = purchaseTransaction.vendorID AND purchaseTransaction.purchaseTransactionID = purchaseDetail.purchaseID AND Staff.staffGender = 'Male'
GROUP BY Vendor.vendorName
HAVING COUNT(purchaseTransaction.purchaseTransactionID) > 1

SELECT * FROM ViewPurchaseDetail