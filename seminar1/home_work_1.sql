CREATE DATABASE seminar1;

USE seminar1;

CREATE TABLE phone
(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    ProductName VARCHAR(30) NOT NULL,
    Manufacturer VARCHAR(30),
    ProductCount INT,
    Price INT
); 

INSERT phone(ProductName, Manufacturer, ProductCount, Price)
VALUES
	("iPhone X", "Apple", "3", "76000"),
    ("iPhone 8", "Apple", "2", "51000"),
    ("Galaxy S9", "Samsung", "2", "56000"),
    ("Galaxy S8", "Samsung", "1", "41000"),
    ("P20 Pro", "Huawei", "5", "36000");
    
SELECT *
FROM phone;

-- 2. Выведите название, производителя и цену для товаров, количество которых превышает 2
SELECT ProductName, Manufacturer, Price
FROM phone
WHERE ProductCount > 2;

-- 3. Выведите весь ассортимент товаров марки "Samsung"
SELECT ProductName
FROM phone
WHERE Manufacturer LIKE "S%"; -- WHERE Manufacturer = "Samsung";

-- 4. Выведите информацию о телефонах, где суммарный чек больше 100 000 и меньше 145 000
SELECT ProductName, Manufacturer
FROM phone
WHERE ProductCount * Price BETWEEN 100000 AND 145000;

-- 4.1 Товары, в которых есть упоминание "IPhone"
SELECT ProductName, Manufacturer
FROM phone
WHERE ProductName LIKE "iPhone%";

-- 4.2 "Galaxy"
SELECT ProductName, Manufacturer
FROM phone
WHERE ProductName LIKE "Galaxy%";

-- 4.3 Товары, в которых есть ЦИФРЫ
SELECT ProductName, Manufacturer
FROM phone
WHERE ProductName RLIKE "[0,1,2,3,4,5,6,7,8,9]";

-- 4.3 Товары, в которых есть ЦИФРА "8"
SELECT ProductName, Manufacturer
FROM phone
WHERE ProductName RLIKE "[8]";

    
    