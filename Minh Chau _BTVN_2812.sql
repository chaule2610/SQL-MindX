-- 1. Hãy cho biết tổng số lượng unique order (đơn hàng) và tổng số lượng quantity của các đơn hàng theo
-- từng tháng từ bảng order và bảng order detail?
-- Gợi ý: dùng DATE_FORMAT(ORDERDATE,'%Y-%m') để group by theo định dạng tháng và năm
-- Count distint và Sum để tính toán

SELECT 
	Count(DISTINCT o.orderNumber), 
	Sum(quantityOrdered),
	DATE_FORMAT(OrderDate,'%Y-%M')
FROM orderdetails o 
RIGHT JOIN orders o2 
ON o.orderNumber = o2.orderNumber 
GROUP BY DATE_FORMAT(OrderDate,'%Y-%M')

-- 2. Hãy cho biết đơn hàng nào có giá trị lớn nhất (tổng quantity nhân với đơn giá)?

SELECT 
	o.Ordernumber,
	Sum(QuantityOrdered*priceEach) AS Giá_Trị
FROM orders o 
LEFT JOIN orderdetails o2 
ON o.orderNumber =o2.orderNumber 
GROUP BY Ordernumber
ORDER BY Sum(QuantityOrdered*priceEach) DESC 
LIMIT 1 


-- 3. Hãy dựa vào bảng Payment hãy cho biết KH (Customer Number) nào có tổng
-- số tiền amount lớn nhất? Và sau đó hãy cho 1 bảng về tất cả tên firstName
-- của KH, số tiền amount total đã thanh toán và thành phố (city) của họ (với
-- điều kiện, Customer Number của họ là từ 200-300)

SELECT 
	DISTINCT CustomerNumber,
	SUM(Amount)
FROM payments p 
GROUP BY CustomerNumber
ORDER BY SUM(Amount) DESC 
LIMIT 1 

SELECT 
	contactFirstName,
	SUM(Amount),
	City
FROM customers c 
INNER JOIN  payments p 
ON c.customerNumber = p.customerNumber 
WHERE c.CustomerNumber BETWEEN 200 AND 300
GROUP BY ContactFirstName, City


-- 4. Hãy làm 1 bảng chi tiết về Employee có tên firstName là: Jeff, Mary, Peter và Andy; và tổng giá trị đơn
-- hàng của Employee đó kiếm được (từ bảng orderdetails, quantity * price)?

SELECT 
	EmployeeNumber,
	firstName,
	lastName,
	extension,
	email,
	officeCode,
	reportsTo,
	jobTitle,
	SUM(QuantityOrdered*PriceEach)
FROM employees e 
INNER JOIN customers c ON e.employeeNumber =c.salesRepEmployeeNumber
INNER JOIN orders o ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails o2 ON o2.orderNumber = o.orderNumber 
WHERE firstName IN ('Jeff', 'Mary', 'Peter', 'Andy')
GROUP BY EmployeeNumber, firstName, lastName, extension, email, officeCode, reportsTo, jobTitle
	

-- 5. (Bt nâng cao) 
-- Hãy lấy ra sản phẩm (product id + Product name)
-- Thỏa đk sau 
-- Nếu sản phẩm đó có đơn đặt hàng nhiều hơn 2 lần trong cùng 1 tháng + năm (orderDate)
-- Và giá trị chênh lệch (priceEach) giữa các đơn đặt hàng 
-- (giá trị cao nhất và giá trị thấp nhất ) lớn hơn 20

SELECT 
	ZF_Table_1.Productcode,
	ZF_Table_1.productName
FROM 
(SELECT 
	p.Productcode,
	p.ProductName,
	Max(priceeach)-Min(priceeach),
	Count(YEAR(Orderdate) AND Month(Orderdate))
FROM products p
INNER JOIN orderdetails o ON p.productCode = o.productCode 
INNER JOIN orders o2 ON o.ordernumber = o2.orderNumber 
GROUP BY p.productcode, p.productName 
HAVING Max(priceeach)-Min(priceeach)>20
	AND Count(YEAR(Orderdate) AND Month(Orderdate))>1) AS ZF_Table_1


#Sử dụng Grouping (chỉ dùng được với DBeaver)
	
	
-- Hãy in ra 10 tên khách hàng có số lượng đơn đặt hàng nhiều nhất và 
-- tổng giá trị đơn hàng
-- Note : Số lượng đơn đặt hàng : COUNT(DISTINCT orderNumber)
------ : Tổng giá trị đơn hàng : sum(quantityOrdered*priceEach)
-- Thỏa điều kiện : Những khách hàng chưa từng có status là Cancelled


SELECT 
	customerName,
	COUNT(DISTINCT o.orderNumber) ,
	Sum(priceEach*quantityOrdered)
FROM customers c 
INNER JOIN orders o ON c.customerNumber = o.customerNumber 
INNER JOIN orderdetails o2 ON o.orderNumber = o2.orderNumber 
GROUP BY customerName
ORDER BY COUNT(DISTINCT o.orderNumber) DESC 
LIMIT 10

