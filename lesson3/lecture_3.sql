USE myfirstdb;

SELECT * 
FROM products 
ORDER BY Price; -- сортировка таблицы products по возрастанию цены

SELECT * 
FROM products 
ORDER BY Price DESC; -- сортировка таблицы products по убыванию цены

SELECT COUNT(*) AS Count
FROM Products; -- колличество строк в таблице 

SELECT * FROM Products
LIMIT 4; -- выводит первые 4 строчки

SELECT * FROM Products
LIMIT 1,2; -- выводит 2 строчки после строчки 1

SELECT SUM(Price) AS totalsum FROM Products; -- выведет сумму значений по столбцу Price под псевдонимом totalsum 

SELECT MIN(Price)
FROM Products
WHERE Manufacturer = 'Apple'; -- мин значение по столбцу Price, где значение Apple 

SELECT 
	MIN(Price),
    MAX(Price),
    AVG(Price)
FROM Products
WHERE Manufacturer = 'Samsung';  -- мин макс и среднее значение по столбцу Price, где значение Samsung

SELECT Manufacturer, COUNT(*) AS Models, Price, ProductCount
FROM Products
WHERE Price > 40000
GROUP BY Manufacturer; -- ???



