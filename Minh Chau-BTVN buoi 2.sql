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

--- 3. Tạo ra một cột mới từ bảng Transactionhistory có tên là Quy
--- Nếu MONTH từ 1-3 là Quy 1, Nếu MONTH từ 4-5 là Quy 2, Nếu MONTH từ 7-9 là Quy 3, Còn lại là Q4
--- Sau đó tính value (quantity*actual cost) theo từng quý + năm
--- Kết quả yêu cầu: IN ra tổng value theo năm của Quý cao nhất



--- Bước 1: tạo 1 cột tên Quý
ALTER TABLE transactionhistory 
ADD Quy Char(2)

UPDATE transactionhistory 
SET Quy =
CASE 
	WHEN MONTH(TransactionDate) BETWEEN 1 AND 3 THEN 'Q1' 
	WHEN MONTH(TransactionDate) BETWEEN 4 AND 6 THEN 'Q2' 
	WHEN MONTH (TransactionDate) BETWEEN 7 AND 9 THEN 'Q3' 
	ELSE 'Q4' 
END






