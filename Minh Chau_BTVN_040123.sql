-- 1. Lấy thông tin của các nhân viên (employeeNumber, lastName, firstName, email) làm việc ở
-- các văn phòng có trụ sở đặt tại 1 trong các thành phố Boston, Tokyo, London. (Bảng employees và offices)

SELECT 
	e.employeeNumber,
	lastName,
	firstName, 
	Email
FROM employees e 
INNER JOIN offices o
ON e.officeCode = o.officeCode 
WHERE City IN ('Boston','Tokyo','London')

-- 2. Lấy thông tin của các order (orderNumber, orderDate) có ít nhất 5 sản phẩm và đã được giao (shipped), 
-- xếp theo thứ tự tăng dần của tổng tiền. (Bảng orders và orderdetails)


SELECT 
	orderNumber,
	orderDate 
FROM 
(SELECT 
	o.orderNumber,
	orderDate,
	Count(DISTINCT ProductCode),
	Sum(quantityordered*priceEach),
	Status		
FROM orders o 
INNER JOIN orderdetails o2 
ON o.orderNumber = o2.orderNumber 
WHERE Status ='Shipped'
GROUP BY orderNumber, orderDate, Status
HAVING Count(DISTINCT ProductCode)>= 5
ORDER BY Sum(quantityordered*priceEach) ASC) AS a

-- 3. Lấy thông tin của 5 đơn hàng (orderNumber, orderDate, status) có tổng số tiền đặt hàng lớn nhất 
-- (Bảng orders và orderdetails)

SELECT 
	 o.orderNumber,
	 orderDate,
	 Status,
	 Sum(quantityordered*priceEach)
FROM orders o 
INNER JOIN orderdetails o2 
ON o.orderNumber = o2.orderNumber 
GROUP BY o.orderNumber, orderDate, status
ORDER BY Sum(quantityordered*priceEach) DESC 
LIMIT 5
	 

-- 4. Tổng số đơn hàng đã đặt (xét trên mọi trạng thái của đơn hàng) vào năm 2004 tăng/giảm bao nhiêu 
-- phần trăm so với năm 2003.
SELECT 
	Order_2004,
	Order_2003,
	((Order_2004-Order_2003)/Order_2003)*100 AS So_Sánh_với_2003
From
(SELECT 
	Count(orderNumber) AS Order_2004,
	(SELECT Count(orderNumber)
	FROM orders o 
	WHERE Year(orderDate)=2003) AS Order_2003
FROM orders o
WHERE Year(orderDate)=2004) AS ZF_Table_1
-- Do kết quả là số dương nên tổng đơn hàng 2004 tăng 36% so với tổng đơn hàng 2003


-- 5. Lấy thông tin của 10 sản phẩm (productCode, productName, quantityInStock, buyPrice) còn hàng 
-- với số lượng ít hơn trung bình của toàn bộ kho nhưng có giá tiền thấp hơn $60, 
-- sắp xếp tăng dần theo số lượng sản phẩm còn lại.

SELECT 
	productCode,
	productName,
	quantityInStock,
	buyPrice
FROM products p 
WHERE buyPrice <60
	  AND quantityInStock < (SELECT AVG(quantityInStock) FROM products p)
 ORDER BY quantityInStock ASC 
 LIMIT 10

-- 6. Lấy thông tin của top 5 nhân viên (employeeNumer, lastName, firstName, email, jobTitle) có thành tích
-- bán hàng xuất sắc nhất (Gợi ý: chỉ xét các đơn hàng đã giao thành công, dựa trên tổng tiền 
-- đã bán được để đánh giá thành tích).
 
 SELECT 
 	employeeNumber,
 	lastName,
 	firstName,
 	email,
 	jobTitle
 FROM 
 (
 SELECT 
 	e.employeeNumber,
 	lastName,
 	firstName,
 	email,
 	jobTitle,
 	status,
 	Sum(quantityOrdered*priceEach)
 FROM employees e 
 INNER JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber 
 INNER JOIN orders o ON c.customerNumber = o.customerNumber 
 INNER JOIN orderdetails o2 ON o.orderNumber = o2.orderNumber 
 WHERE status = 'shipped'
 GROUP BY e.employeeNumber, lastName, firstName, email, jobTitle, status
 ORDER BY Sum(quantityOrdered*priceEach) DESC 
 LIMIT 5) AS ZF_1
 
 
 -- BT NÂNG CAO
 -- Các bạn chạy đoạn code dưới đây để tạo bảng SALE và insert dữ liệu


CREATE TABLE SALE(
    ID nvarchar(255) NULL,
    ProductID nvarchar(255) NULL,
    DATE_OF_SALE date NULL,
    Cost_Price float NULL,
    Sales float NULL
) 

INSERT SALE (ID, ProductID, DATE_OF_SALE, Cost_Price, Sales) VALUES 
    ('AB02', 'IDN001', '2022-02-01' , 5, 6),
    ('AB01', 'IDN001', '2022-01-31' , 5, 5.5),
    ('AB03', 'IDN002', '2022-02-02' , 2, 8),
    ('AB04', 'IDN002', '2022-02-03' , 2, 2.5),
    ('AB05', 'IDN001', '2022-02-04' , 4.5, 6.2),
    ('AB06', 'IDN002', '2022-02-05' , 2, 3.1),
    ('AB07', 'IDN003', '2022-02-06' , 5, 5.5),
    ('AB08', 'IDN004', '2022-02-07' , 6, 2),
    ('AB09', 'IDN001', '2022-03-15' , 5, 6),
    ('AB10', 'IDN001', '2022-03-16' , 4, 5.25)

SELECT * FROM sale s 
ORDER BY ProductID , DATE_OF_SALE 


-- Kết quả mong đợi.
ProductID   MONTH      ID
IDN001	    2	    AB05,AB02
IDN001	    3	    AB09,AB10
IDN002	    2	    AB03,AB06,AB04
---------- 

SELECT 
	ProductID,
	MONTH,
	ID 
FROM
(
SELECT 
	s.ProductID,
	Month(DATE_OF_SALE) AS MONTH,
	count(MONTH(DATE_OF_SALE)),
	group_concat(s.ID ORDER BY Sales DESC SEPARATOR ', ') AS ID
FROM sale s 
GROUP BY s.ProductID, Month(DATE_OF_SALE)
HAVING Count(MONTH(DATE_OF_SALE))>1) AS ZF_TABLE_1


