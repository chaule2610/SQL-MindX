--Lấy ra dữ liệu của 10 giao dịch (transaction) có số lượng sản phẩm (quantity) cao nhất từ bảng. Kết qủa được sắp xếp
giảm dần theo số lượng

SELECT *
FROM transactionhistory t 
ORDER BY Quantity DESC 
LIMIT 10

--Lấy ra dữ liệu của 10 đơn hàng (order) có số lượng sản phẩm (quantity) cao nhất từ bảng. Các thông tin cần lấy là Mã
đơn hàng và Số lượng sản phẩm trong đơn hàng. Kết qủa được sắp xếp giảm dần theo số lượng

SELECT TransactionID, Quantity 
FROM transactionhistory t 
ORDER BY Quantity DESC 
LIMIT 10

--Lấy ra số lượng bán được của từng sản phẩm trong tháng 9 năm 2013. Kết quả trả ra sắp xếp theo số lượng từ cao tới
thấp

SELECT ProductID, Quantity
FROM transactionhistory t 
WHERE YEAR(TransactionDate)=2013 AND Month(TransactionDate)=09
ORDER BY Quantity DESC 

--Cho biết giá trị trung bình của mỗi đơn hàng (order) trong tháng 10 năm 2013. Kết quả sắp xếp theo thứ tự giảm dần
giá trị đơn hàng
SELECT ReferenceOrderID, avg(ActualCost) 
FROM transactionhistory t 
WHERE YEAR(TransactionDate)=2013 AND Month(TransactionDate)=10
GROUP BY ReferenceOrderID 
ORDER BY avg(ActualCost) DESC 

--Tạo 1 bảng mới tên là TransactionHistory2 lấy dữ liệu của các giao dịch từ bảng TransactionHistory và thêm 1 cột tên là
“Value” để thể hiện giá trị của từng giao dịch (giá trị = Quantity * ActualCost).

CREATE TABLE TransactionHistory2( 
TransactionID int,
ProductID int,
ReferenceOrderID int,
ReferenceOrderLineID int,
TransactionDate varchar(50),
TransactionType varchar (50),
Quantity int,
ActualCost int,
ModifiedDate varchar (50),
Value int
)

SELECT *, 'Quantity*ActualCost'
INTO transactionhistory2 
FROM transactionhistory t 
WHERE Value = 'Quantity*ActualCost'




