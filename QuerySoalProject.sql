--1.	Display CustomerName, Customer Gender (obtained from the first character of CustomerGender), Customer Email, and Most Product Bought 
--(obtained from the maximum quantity of product sold) for every female customer whose born in ‘October’. 

SELECT
	CustomerName,
	[Customer Gender] = LEFT(CustomerGender, 1),
	[Customer Email] = CustomerEmail,
	[Most Product Bought] = MAX(SalesQty)
FROM
	Customer C, SalesTransaction ST,  DetailSalesTransaction DST
WHERE
	C.CustomerId = ST.CustomerId
AND
	ST.SalesId = DST.SalesId
AND
	MONTH(CustomerDateOfBirth) = 10
AND
	CustomerGender = 'Female'
GROUP BY
	CustomerName,
	CustomerGender,
	CustomerEmail


--2.	Display MaterialName, Material Price (obtained by adding ‘Rp. ‘ in front of  MaterialPrice), 
--and Total Quantity (obtained from the total quantity of material purchased) for every Material 
--which Price is more than 10000 and Total Quantity is more than 15. 

SELECT
	MaterialName,
	[Material Price] = 'Rp. '+ CAST(MaterialPrice AS VARCHAR),
	[Total Quantity] = SUM(PurchaseQty)
FROM
	Material M, DetailPurchaseTransaction DPT
WHERE
	M.MaterialId = DPT.MaterialId
AND
	MaterialPrice > 10000
AND
	PurchaseQty > 15
GROUP BY
	MaterialName,
	MaterialPrice


--3.	Display Staff Name (obtained by adding ‘Mr. ‘ in front of the Staff’s first Name), StaffEmail,
--Total Staff Transaction (obtained from total number of transaction), and
--Average Product Sold (obtained from the average quantity of product sold) for every male staff and
--Total Staff Transaction is more than 1.

SELECT
	[Staff Name] = 'Mr. ' + LEFT(StaffName, CHARINDEX(' ', StaffName)),
	StaffEmail,
	[Total Staff Transaction] = COUNT(*),
	[Average Product Sold] = AVG(SalesQty)
FROM
	Staff S, SalesTransaction ST, DetailSalesTransaction DST
WHERE
	S.StaffId = ST.StaffId
AND
	ST.SalesId = DST.SalesId
AND
	StaffGender = 'Male'
GROUP BY
	StaffName,
	StaffEmail
HAVING
	COUNT(*) > 1


--4.	Display Staff Name (obtained from the Staff’s first name), Total Transaction (Obtained from total
--number of transaction), and Total Material Bought (obtained from total quantity of material bought)
--for every Total Transaction is more than 1 and Total Material Bought is less than 10.

SELECT
	[Staff Name] = LEFT(StaffName, CHARINDEX(' ', StaffName)),
	[Total Transaction] = COUNT(*),
	[Total Material Bought] = SUM(PurchaseQty)
FROM
	Staff S, PurchaseTransaction PT, DetailPurchaseTransaction DPT
WHERE
	S.StaffId = PT.StaffId
AND
	PT.PurchaseId = DPT.PurchaseId
AND
	PurchaseQty < 10
GROUP BY
	StaffName
HAVING
	COUNT(*) > 1

--5.	Display Material Number (obtained from Replace ‘MT’ to ‘Material No.’ on MaterialID), MaterialName,
--MaterialPrice, ProductName, and Transaction Date (obtained from SalesDate in ‘Mon dd, yyyy’ format) 
--for every Material which Price is more than the average of all MaterialPrice and transaction occurred in June.(alias subquery)

SELECT
	[Material Number] = REPLACE(M.MaterialId, 'MT', 'Material No.'),
	MaterialName,
	MaterialPrice,
	ProductName,
	[Transaction Date] = CONVERT(VARCHAR, SalesDate, 107)
FROM
	Material M, Product P, DetailSalesTransaction DST, SalesTransaction ST, (SELECT [Average] = AVG(MaterialPrice) FROM Material) tableBayangan
WHERE
	M.MaterialId = P.MaterialId
AND
	P.ProductId = DST.ProductId
AND
	DST.SalesId = ST.SalesId
AND
	MaterialPrice > tableBayangan.Average
AND
	MONTH(SalesDate) = 6


--6.	Display Product Id (obtained by replacing ‘PR’ into ‘Product ’ of ProductId), Product Name (obtained from product name 
--in uppercase format), MaterialName, and Average Product Purchased (obtained from average quantity of product purchased) for 
--product which price is more than 20000 and Average Product Purchased is greater than average of all sales transaction quantity.
--(alias subquery)

SELECT
	[Product Id] = REPLACE(P.ProductId, 'PR', 'Product '),
	[Product Name] = UPPER(ProductName),
	MaterialName,
	[Average Product Purchased] = AVG(PurchaseQty)
FROM
	Product P, Material M, DetailPurchaseTransaction DPT, (SELECT [Rata] = AVG(SalesQty) FROM DetailSalesTransaction) tableShadow
WHERE
	P.MaterialId = M.MaterialId
AND
	M.MaterialId = DPT.MaterialId
AND
	ProductPrice > 20000
AND
	AVG(PurchaseQty) > tableShadow.Rata								
GROUP BY
	ProductId,
	ProductName,
	MaterialName


--7.	Display DistributorName, Distributor Phone (obtained from replace ‘08’ to ‘+628’ on DistributorPhone),
--DistributorAddress, and PurchaseDate for every distributor whose handle purchase transaction with the most variant
--product in a purchase transaction. (alias subquery)

SELECT
	DistributorName,
	[Distributor Phone] = REPLACE(DistributorPhoneNumber, '08', '+628'),
	DistributorAddress,
	PurchaseDate
FROM
	Distributor D, PurchaseTransaction PT, Staff S, SalesTransaction ST, (SELECT [RT] = COUNT(DistributorId) FROM PurchaseTransaction) tableBayang
WHERE
	D.DistributorId = PT.DistributorId
AND
	PT.StaffId = S.StaffId
AND
	S.StaffId = ST.StaffId
AND
	COUNT(PT.DistributorId) > tableBayang.RT


--8.	Display Material Name (obtained from material name in lowercase format), Material Price (obtained by adding ‘Rp. ’ in
--front of Material price), and Total Transaction (obtained from total number of purchase transaction and ended with ‘ transaction(s)’)
--for every material which price is lower than average of all material price and total transaction is more than 2. (alias subquery)

SELECT
	[Material Name] = LOWER(MaterialName),
	[Material Price] = 'Rp. ' +CAST(MaterialPrice AS VARCHAR),
	[Total Transaction] = CAST(COUNT(*) AS VARCHAR) + '  transaction(s)'
FROM
	Material M, DetailPurchaseTransaction DPT, (SELECT [AVRG] = AVG(MaterialPrice) FROM Material) tableByg
WHERE
	M.MaterialId = DPT.MaterialId
AND
	MaterialPrice < tableByg.AVRG
GROUP BY
	MaterialName,
	MaterialPrice
HAVING
	COUNT(*) > 2


--9.	Create a view named ‘TopItemIn2008’ to display ProductName, Most Product Sold (obtained from the maximum quantity of product sold),
--and Total Transaction (obtained total number of transaction) for every transaction occurred in 2008 and total transaction is more than 1.

CREATE VIEW
	TopItemIn2008
AS
SELECT
	ProductName,
	[Most Product Sold] = MAX(SalesQty),
	[Total Transaction] = COUNT(*)
FROM
	Product P, DetailSalesTransaction DST, SalesTransaction ST
WHERE
	P.ProductId = DST.ProductId
AND
	DST.SalesId = ST.SalesId
AND
	YEAR(SalesDate) = 2008
GROUP BY
	ProductName
HAVING
	COUNT(*) > 1


--10.	Create a view named ‘MonthlyProductSoldReport’ to display ProductName, MaterialName, Material Price ( obtained from MaterialPrice and
--ended with ‘,00’), Total Product Sold (obtained from total quantity of product sold), and Average Product Sold (obtained from the average 
--quantity of product sold) for every transaction happened after May and the MaterialPrice is more than 10000.

CREATE VIEW
	MonthlyProductSoldReport
AS
SELECT
	ProductName,
	MaterialName,
	[Material Price] = CAST(MaterialPrice AS VARCHAR) + ',00',
	[Total Product Sold] = SUM(SalesQty),
	[Average Product Sold] = AVG(SalesQty)
FROM
	Product P, Material M, DetailSalesTransaction DST, SalesTransaction ST
WHERE
	M.MaterialId = P.MaterialId
AND
	P.ProductId = DST.ProductId
AND
	DST.SalesId = ST.SalesId
AND
	MONTH(SalesDate) > 5
AND
	MaterialPrice > 10000
GROUP BY
	ProductName,
	MaterialName,
	MaterialPrice