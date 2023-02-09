--	SalesTransaction & DetailSalesTransaction Simulation

--1.	Roger membeli Cupboard sebanyak 2 buah pada tanggal 25 Juni 2018.

--Sales:
INSERT INTO SalesTransaction VALUES
('ST023', 'SF003', 'CS001', '2018-06-25')

--DetailSales:
INSERT INTO DetailSalesTransaction VALUES
('PR013', 'ST023', 2)



--2.	Valentino Marquez membeli  Pillow sebanyak 3 buah pada tanggal 26 Juni 2018.

--Sales:
INSERT INTO SalesTransaction VALUES
('ST024', 'SF002', 'CS020', '2018-06-26')

--DetailSales:
INSERT INTO DetailSalesTransaction VALUES
('PR014', 'ST024', 3)



--3.	CS017'	,'Robert Dowsy membeli Chair PR007 sebanyak 4 buah pada tanggal 27 Juni 2018.

--Sales:
INSERT INTO SalesTransaction VALUES
('ST025', 'SF001', 'CS017', '2018-06-27')

--DetailSales:
INSERT INTO DetailSalesTransaction VALUES
('PR007', 'ST025', 4)



--	PurchaseTransaction & DetailPurchaseTransaction Simulation

--1.	Indah Surya membeli Silk di distributor Tada Banri sebanyak 20 buah pada tanggal 18 Juni 2018.

--Purchase:
INSERT INTO PurchaseTransaction VALUES
('PT019'	,'SF004'	,'DS004'	,'2016-06-18')

--DetailPurchase:
INSERT INTO DetailPurchaseTransaction VALUES
('PT019'	, 'MT004', 20)



--2.	Stefani Bekmehen membeli Leather di distributor Global Mulya Supply sebanyak 25 buah pada tanggal 19 Juni 2018.

--Purchase:
INSERT INTO PurchaseTransaction VALUES
('PT020'	,'SF013'	,'DS015'	,'2016-06-19')

--DetailPurchase:
INSERT INTO DetailPurchaseTransaction VALUES
('PT020'	, 'MT014', 25)



--3.	Aguero Ahmad membeli Steel di distributor Kaga Kouko sebanyak 15 buah pada tanggal 20 Juni 2018.

--Purchase:
INSERT INTO PurchaseTransaction VALUES
('PT021'	,'SF006'	,'DS005'	,'2016-06-20')

--DetailPurchase:
INSERT INTO DetailPurchaseTransaction VALUES
('PT021'	, 'MT003', 15)