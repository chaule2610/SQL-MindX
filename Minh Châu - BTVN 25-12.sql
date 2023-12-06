--- 1. Cho biết số ORDER của mỗi region (dùng group by và count orderID)

SELECT COUNT(Order_ID)
FROM 5000_sale_orders so 
GROUP BY region

--- 2. Cho biết total revenue của mỗi region theo thứ tự từ thấp đến cao và từ cao đến thấp (dùng order by)

--- Từ thấp đến cao
SELECT SUM(Total_revenue), region
FROM 5000_sale_orders so 
GROUP BY Region 
ORDER BY SUM(total_revenue)

--- Từ cao đến thấp 
SELECT SUM(Total_revenue), region
FROM 5000_sale_orders so 
GROUP BY Region 
ORDER BY SUM(total_revenue) DESC

--- 3. Cho biết total revenue của region Asia và Europe (dùng group by và where)

SELECT SUM(Total_revenue), Region
FROM 5000_sale_orders so 
GROUP BY Region  
HAVING Region IN ('Asia', 'Europe')

--- 4. Dùng left join giữa bảng order và bảng manager để thể hiện region, country, order ID trong bảng order
--- và manager name, address trong bảng manager thông qua primary key là Region

SELECT so.Region, Country, Order_ID, Manager, Address
FROM 5000_sale_orders so 
LEFT JOIN 5000_sale_orders_managers som 
ON so.Region = som.Region

--- 5. Lấy 3 cột Region, Manager và count (orderID) và cho biết Manager nào có số order lớn nhất 
--- (thông qua left JOIN với khóa chính là region, và group by theo region và manager)

SELECT so.Region, Manager, Count(Order_ID)
FROM 5000_sale_orders so 
LEFT JOIN 5000_sale_orders_managers som 
ON so.Region=som.Region
GROUP BY so.Region, Manager 
ORDER BY Count(Order_ID) DESC 
LIMIT 1
