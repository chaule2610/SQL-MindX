-- 1. Tính total revenue của từng order 

SELECT 
	orderNumber,
	Sum(Quantityordered*Priceeach) AS Total_revenue
FROM orderdetails o 
GROUP BY orderNumber 

-- 2. Add thêm cho biết order status và quốc gia của order đó

SELECT 
	o.orderNumber,
	Sum(o.Quantityordered*o.Priceeach) AS Total_revenue,
	Status,
	Country
FROM orderdetails o 
JOIN orders o2  ON o.orderNumber =o2.orderNumber 
JOIN customers c ON o2.customerNumber = c.customerNumber 
GROUP BY orderNumber, Status, Country




select a.orderNumber 
	, b.customerNumber
	, sum(quantityOrdered *priceEach) as 'total_revenue'
	, status
	, country
from orderdetails as a
left join orders as b
on a.orderNumber = b.orderNumber 
left join customers as c 
on b.customerNumber = c.customerNumber 
group by 1,2,4,5
-- Tính total revenue của từng quốc gia từ subquery trên sort Z-A

SELECT Country, Sum(total_revenue)
FROM 
(select a.orderNumber 
	, b.customerNumber
	, sum(quantityOrdered *priceEach) as 'total_revenue'
	, status
	, country
from orderdetails as a
left join orders as b
on a.orderNumber = b.orderNumber 
left join customers as c 
on b.customerNumber = c.customerNumber 
group by 1,2,4,5) AS a
GROUP BY Country 
ORDER BY Sum(total_revenue) DESC 
