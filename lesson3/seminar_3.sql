
CREATE TABLE customer
(
	id INT PRIMARY KEY AUTO_INCREMENT,
    phone INT
);

CREATE TABLE customer_orders
(
	id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT
);
ALTER TABLE customer_orders
ADD FOREIGN KEY(customer_id) REFERENCES customer(id);

-- -----------------------------------------------------

CREATE DATABASE IF NOT EXISTS lesson3;

USE lesson3;
# 'sql', "sql"
# `ё на англ.раскладке` - выделяются названия таблиц, столбцов и БД
DROP TABLE IF EXISTS staff;
CREATE TABLE IF NOT EXISTS `staff`
(
	`id` INT PRIMARY KEY AUTO_INCREMENT,
    `firstname` VARCHAR(45),
    `lastname` VARCHAR(45),
    `post` VARCHAR(30),
    `seniority` INT,
    `salary` INT,
    `age` INT
); 

ALTER TABLE staff
MODIFY post VARCHAR(45); 

INSERT INTO `staff` (`firstname`,  `lastname`, `post`,`seniority`,`salary`, `age`)
VALUES
		('Вася', 'Васькин', 'Начальник', 40, 100000, 60), -- id = 1
		('Петр', 'Власов', 'Начальник', 8, 70000, 30),
		('Катя', 'Катина', 'Инженер', 2, 70000, 25),
		('Саша', 'Сасин', 'Инженер', 12, 50000, 35),
		('Иван', 'Петров', 'Рабочий', 40, 30000, 59),
		('Петр', 'Петров', 'Рабочий', 20, 55000, 60),
		('Сидр', 'Сидоров', 'Рабочий', 10, 20000, 35),
		('Антон', 'Антонов', 'Рабочий', 8, 19000, 28),
		('Юрий', 'Юрков', 'Рабочий', 5, 15000, 25),
		('Максим', 'Петров', 'Рабочий', 2, 11000, 19),
		('Юрий', 'Петров', 'Рабочий', 3, 12000, 24),
		('Людмила', 'Маркина', 'Уборщик', 10, 10000, 49);
        
-- Посчитаем среднюю зарплату по фирме
SELECT AVG(salary)
FROM staff; 

-- Выведем информацию о людях, зарплата которых выше средней
SELECT *
FROM staff
WHERE salary > (SELECT AVG(salary) FROM staff);  -- Подзапрос: SELECT в SELECT-e

-- Сортировка - ORDER BY, группировка - GROUP BY
-- Получить информацию о  зарплатах сотрудников от меньшего к большему
SELECT salary, id
FROM staff
ORDER BY `salary` DESC;
 -- ASC - исходный параметр, от меньшего к большему
-- DESC - по убыванию, от большего к меньшему

-- Вывести инфо о сотрудниках, у которых должность "Рабочий" и стаж > 5; зарплату вывести по воз-ю
SELECT salary, id, post, seniority
FROM staff
WHERE seniority > 15 AND post = "Рабочий"
ORDER BY salary;

-- lastname, age, по убыванию
SELECT age, lastname
FROM staff
ORDER BY lastname DESC, age;

-- Найти количество неуникальных фамилий 
-- SELECT COUNT(lastname) - COUNT(DISTINCT lastname) -- 12 - 9
-- FROM staff;

# SELECT  lastname, COUNT(lastname) - COUNT(DISTINCT lastname) AS 'Число'
# FROM staff
# GROUP BY lastname
# HAVING COUNT(lastname) - COUNT(DISTINCT lastname) > 1;

SELECT id, age, lastname
FROM staff
LIMIT 5; -- От первой строчки будут выводиться следуюзщие 5


SELECT id, age, lastname
FROM staff
LIMIT 2, 3;  -- Пропускаеем первые 2 строчки и выводим следующие 3: 3,4,5

-- Пропустите две последние строчки (id = 12, 11),
-- вывести следующие 3 строчки (id = 10, 9, 8)
SELECT id, age, lastname
FROM staff
ORDER BY id DESC
LIMIT 2, 3;

SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

SELECT salary, lastname, post,
	MAX(salary) AS "Максимальная зарплата", MIN(salary) AS "Минимальная зарплата", 
    COUNT(salary) AS "Количество специалистов", AVG(salary) AS "Cредняя зарплата специалиста",
	MAX(salary)  -  MIN(salary) AS "Разница между МАКС и МИН зарплатой"
FROM staff
GROUP BY post
ORDER BY MAX(salary)  -  MIN(salary) DESC;

-- WHERE и HAVING
SELECT post, AVG(salary)
FROM staff
WHERE post != "Начальник"
GROUP BY post
HAVING AVG(salary) > 50000;

SELECT * 
FROM staff
HAVING salary > 50000; -- WHERE = HAVING без GROUP BY 
-- HAVING идет, как правило, с агрегатной функцией

SELECT * 
FROM staff
WHERE salary > 50000;