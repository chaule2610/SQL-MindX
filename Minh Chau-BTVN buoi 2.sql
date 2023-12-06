--- 1.Tính giá trị trung bình (Quantity*ActualCost) cho từng sản phẩm thỏa các điều kiện
--- Nếu chữ số thập phân >= 0.4 thì làm tròn lên 
--- Nếu chữ số thập phân < 0.4 thì làm tròn xuống

SELECT ProductID,
       AVG(Quantity*ActualCost),
       TRUNCATE(AVG(Quantity*ActualCost),0),
CASE 
	WHEN (AVG(Quantity*ActualCost)-TRUNCATE(AVG(Quantity*ActualCost),0))>= 0.4
	THEN TRUNCATE(AVG(Quantity*ActualCost),0)+1
	ELSE TRUNCATE(AVG(Quantity*ActualCost),0)
END
FROM transactionhistory t 
GROUP BY ProductID




--- có thể dùng CEILING để làm tròn lên
--- SQL: Case when,  

--- 2. Lấy được những ProductID mua được tại tháng 7 năm 2013 và cũng mua được tại tháng 7 năm 2014
SELECT DISTINCT ProductID 
FROM transactionhistory t 
WHERE 
	MONTH(TransactionDate)= 7 
	AND 
	YEAR(TransactionDate)= 2013 
	AND ProductID
IN 
(
SELECT DISTINCT ProductID 
FROM transactionhistory t 
WHERE 
	MONTH(TransactionDate)=7 
	AND 
	YEAR(TransactionDate)=2014
)







