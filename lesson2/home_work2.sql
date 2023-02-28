-- 1. Используя операторы языка SQL, создайте табличку “sales”. Заполните ее данными. 

CREATE TABLE IF NOT EXISTS sales
(
	id INT PRIMARY KEY AUTO_INCREMENT, 
    order_date DATE,
    count_product INT
);

INSERT INTO sales (order_date, count_product)
VALUES 
	('2022-01-01', '156'),
    ('2022-01-02', '180'),
    ('2022-01-03', '21'),
    ('2022-01-04', '124'),
    ('2022-01-05', '341');
    
SELECT * FROM sales;    

-- 2. Сгруппируйте значений количества в 3 сегмента — меньше 100, 100-300 и больше 300. 

SELECT id AS 'id заказа', 
CASE
	WHEN count_product < 100 THEN 'Маленький заказ'
    WHEN count_product >= 100 AND count_product <= 300 THEN 'Средний заказ'
    ELSE 'Большой заказ'
    END AS 'Тип заказа'  
FROM sales ;

SELECT 
	id AS 'id заказа',
    IF (count_product < 100 , 'Маленький заказ', 
		IF (count_product >= 100 AND count_product <= 300, 'Средний заказ', 
			IF (count_product > 300 , 'Большой заказ' , 'Не определено')))
	AS 'Тип заказа'
FROM sales;

-- 3. Создайте таблицу “orders”, заполните ее значениями. Покажите “полный” статус заказа, используя оператор CASE. 
drop TABLE orders;
CREATE TABLE IF NOT EXISTS orders
(
	id INT PRIMARY KEY AUTO_INCREMENT, 
    employee_id VARCHAR(3),
    amount DECIMAL(5,2),
    order_status VARCHAR(9)
);

INSERT INTO orders (employee_id, amount, order_status)
VALUES 
	('e03', '15.00', 'OPEN'),
    ('e01', '25.50', 'OPEN'),
    ('e05', '100.70', 'CLOSED'),
    ('e02', '22.18', 'OPEN'),
    ('e04', '9.50', 'CANCELLED');
    
SELECT * FROM orders;

SELECT id AS 'id заказа', 
CASE
	WHEN order_status = 'OPEN' THEN 'Order is in open state'
    WHEN order_status = 'CLOSED' THEN 'Order is closed'
    WHEN order_status = 'CANCELLED' THEN 'Order is cancelled'
    END AS 'full order status'  
FROM orders ;

SELECT 
	id AS 'id заказа',
    IF (order_status = 'OPEN', 'Order is in open state', 
		IF (order_status = 'CLOSED', 'Order is closed', 
			IF (order_status = 'CANCELLED', 'Order is cancelled', 'Не определено')))
	AS 'full order status'
FROM orders;
