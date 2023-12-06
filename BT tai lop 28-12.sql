-- 1.hãy cho biết total revenue của từng manager

SELECT Round(Sum(Total_revenue)), som.manager 
FROM 5000_sale_orders so 
LEFT JOIN 5000_sale_orders_managers som 
ON so.Region=som.Region
GROUP BY Manager


--- 2.Hãy trả về profit AFTER tax của mỗi ORDER, expected outcome gồm các cột sau
--- orderID, country, orderdate, profit_before tax và profit AFTER tax

SELECT 
	Order_ID, 
	Country, 
	soct.tax_rate,
	(Total_profit) AS Profit_Before_Tax,
	 Round(( total_profit*(100-tax_rate)/100),2) AS Profit_before_tax
FROM 5000_sale_orders so 
LEFT JOIN 5000_sale_orders_cat_tax soct 
ON so.Item_Type=soct.Item_Type


--- 3. Hãy trả về profit BEFORE tax và profit AFTER tax của mỗi region
SELECT  
	Region,
	Round(Sum(Total_profit),1) AS Profit_Before_Tax,
	Round(Sum(( total_profit*(100-tax_rate)/100)),1) AS Profit_before_tax
FROM 5000_sale_orders so 
LEFT JOIN 5000_sale_orders_cat_tax soct 
ON so.Item_Type=soct.Item_Type
GROUP BY Region



