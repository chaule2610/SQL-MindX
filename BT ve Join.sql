-- 1. Mỗi sản phẩm hãy cho tổng số đơn hàng đã được ORDER
-- Sắp xếp theo tổng orderID giảm dần




--- 3. Hãy in ra tất cả các sản phẩm (ProductID, product Name)
--- Và tổng đơn đặt hàng của sản phẩm đó
--- 
-- Nếu sản phẩm nào không có đơn đặt hàng thì in ra = 1
SELECT p.productCode, p.productName , Count(DISTINCT QuantityOrdered),
CASE WHEN Count(DISTINCT QuantityOrdered) >0
	 THEN 'Yes'
	 ELSE 'No'
	 END AS ZF_Flag
FROM products p 
LEFT JOIN orderdetails o 
ON p.ProductCode = o.Productcode
GROUP BY p.productCode, p.productName

--- 4. In ra danh sách tên sản phẩm và đơn đặt hàng
-- kể cả những sản phẩm không được order
--- và những orderid có sản phẩm không nằm trong bảng sản phẩm 

SELECT p.productName, ordernumber 
FROM products p 
LEFT JOIN orderdetails o 
ON p.productCode = o.productCode 
Union




	


