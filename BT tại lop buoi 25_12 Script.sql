SELECT *, tax_rate FROM 5000_sale_orders so 
LEFT JOIN 5000_sale_orders_cat_tax soct 
ON so.item_type = soct.item_type
WHERE Country ='Vietnam'

-- Tính profit after tax 
-- profit_after_tax = (total_profit)* (1-tax_rate/100)

SELECT country, so.item_type, order_ID,
	total_profit, tax_rate, 
	round(total_profit*(1-tax_rate/100)) AS profit_after_tax
FROM 5000_sale_orders so 
LEFT JOIN 5000_sale_orders_cat_tax soct 
ON so.item_type = soct.item_type
WHERE Country ='Vietnam'