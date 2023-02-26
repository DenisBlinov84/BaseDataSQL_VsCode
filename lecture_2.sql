-- создание базы данных 
CREATE DATABASE MySampleDB;

SHOW DATABASES; -- возвращает список всех баз данных 

USE MySampleDB; -- подключаемся к базе данных 

CREATE TABLE Customers
(
	Id INT PRIMARY KEY AUTO_INCREMENT,
    Age INT,
    FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(20) NOT NULL,
    Phone VARCHAR(20) NOT NULL UNIQUE
);
CREATE TABLE Orders
(
	Id INT PRIMARY KEY AUTO_INCREMENT,
	CustomerId INT,
	CreatedAt Date,
	FOREIGN KEY (CustomerId) REFERENCES Customers (Id)
);

USE myfirstdb;

CREATE TABLE Customer
(
	id INT PRIMARY KEY AUTO_INCREMENT,
    Age INT,
    FirstName VARCHAR(20),
    LastName VARCHAR(20)
);

SELECT * FROM Customer;

CREATE TABLE Products
(
	id INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(30) NOT NULL,
    Manufacturer VARCHAR(20) NOT NULL,
    ProductCount INT DEFAULT 0, -- изначальное число телефонов = 0
    Price DECIMAL -- число с заданой точностью
);

INSERT Products(ProductName, Manufacturer, ProductCount, Price)
VALUES
	("iPhone X", "Apple", "3", "76000"),
    ("iPhone 8", "Apple", "2", "51000"),
    ("Galaxy S9", "Samsung", "2", "56000"),
    ("Galaxy S8", "Samsung", "1", "41000"),
    ("P20 Pro", "Huawei", "5", "36000");
    
SELECT *
FROM Products;

SELECT * FROM Products
WHERE Manufacturer IN('Apple','Samsung');

SELECT * FROM Products
WHERE NOT Manufacturer = 'Samsung';

SELECT * FROM Products
WHERE NOT Manufacturer IN('Apple','Samsung');

SELECT * FROM Products
WHERE Manufacturer = 'Samsung' AND Price > 50000;

SELECT * FROM Products
WHERE Manufacturer = 'Samsung' OR Price > 50000;

SELECT ProductName, ProductCount,
CASE
	WHEN ProductCount = 1
		THEN 'Товар заканчивается'
    WHEN ProductCount = 2
		THEN 'Мало товара'
	WHEN ProductCount = 3
		THEN 'Много товара'
END AS Category
FROM Products;

USE myfirstdb;
SELECT ProductName, ProductCount,
	IF(ProductCount>3, 'Много товара', 'Мало товара')
FROM Products;

/*
	-- Command Line Client --
UPDATE products
SET Price = Price + 3000; -- ???

DELETE FROM Products
WHERE Manufacturer='Huawei'; -- ???
*/








