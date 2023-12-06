-- 1. Đếm số khách hàng theo nhóm các quốc gia: US, UK, Germany và các nước khác
SELECT 
	Country,
	Count(customerNumber) AS Số_lượng_KH
FROM customers c 
GROUP BY Country

-- 2. Xem tên khách hàng, thuộc UK có giới hạn tín dụng lớn hơn mức giới hạn trung bình của tất cả khách hàng.
-- Cách 1: CTE
WITH Hạn_Mức AS
(
SELECT Avg(CreditLimit) AS Credit 
FROM customers c
)
SELECT 
	CustomerName,
	creditLimit 
FROM customers c 
WHERE 
	Country ='UK'
	AND creditLimit > (SELECT credit FROM Hạn_Mức)

-- Cách 2:
SELECT 
	CustomerName,
	creditLimit 
FROM customers c 
WHERE 
	Country = 'UK'
	AND creditLimit > (SELECT AVG(CreditLimit) FROM customers)
	
-- 3. Tìm tên khách hàng có nhiều đơn nhất. (Gợi ý: Xem thêm bảng orders và đếm số đơn hàng).
	
SELECT 
	CustomerName,
	Count(DISTINCT OrderNumber) AS Số_Lượng_Đơn_Hàng
FROM customers c 
INNER JOIN orders o 
ON o.customerNumber = c.customerNumber 
GROUP BY customerName 
ORDER BY Count(DISTINCT OrderNumber) DESC 
LIMIT 1

-- 4. Tìm sản phẩm tồn nhiều nhất và mức giá mua hơn mức giá mua trung bình của các sản phẩm.

-- Cách 1:
WITH Avg_BuyPrice AS
(SELECT AVG(BuyPrice) AS AVG_Price
FROM products p)
SELECT 
	ProductCode,
	ProductName, 
	quantityInStock
FROM products
WHERE buyPrice > (SELECT Avg_Price FROM Avg_BuyPrice)

-- Cách 2:
SELECT 
	ProductCode,
	ProductName, 
	quantityInStock
FROM products p2 
WHERE buyPrice > (SELECT Avg(BuyPrice) FROM products p)

	
-- 5. Tìm quốc gia có hạn mức tín dụng trung bình cao nhất so với các quốc gia khác.

SELECT 
	Country,
	Round(AVG(CreditLimit),2) AS AVG_CreditLimit
FROM customers c 
GROUP BY country 
ORDER BY AVG(creditLimit) DESC
LIMIT 1
	
