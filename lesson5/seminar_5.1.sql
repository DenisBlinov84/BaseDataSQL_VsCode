DROP DATABASE IF EXISTS lesson_5;
CREATE DATABASE lesson_5;
USE lesson_5;

-- Персонал
DROP TABLE IF EXISTS staff;
CREATE TABLE staff (
	id INT AUTO_INCREMENT PRIMARY KEY, 
	firstname VARCHAR(45),
	lastname VARCHAR(45),
	post VARCHAR(100),
	seniority INT, 
	salary INT, 
	age INT
);

-- Наполнение данными
INSERT INTO staff (firstname, lastname, post, seniority, salary, age)
VALUES
	('Вася', 'Петров', 'Начальник', '40', 100000, 60),
	('Петр', 'Власов', 'Начальник', '8', 70000, 30),
	('Катя', 'Катина', 'Инженер', '2', 70000, 25),
	('Саша', 'Сасин', 'Инженер', '12', 50000, 35),
	('Ольга', 'Васютина', 'Инженер', '2', 70000, 25),
	('Петр', 'Некрасов', 'Уборщик', '36', 16000, 59),
	('Саша', 'Петров', 'Инженер', '12', 50000, 49),
	('Иван', 'Сидоров', 'Рабочий', '40', 50000, 59),
	('Петр', 'Петров', 'Рабочий', '20', 25000, 40),
	('Сидр', 'Сидоров', 'Рабочий', '10', 20000, 35),
	('Антон', 'Антонов', 'Рабочий', '8', 19000, 28),
	('Юрий', 'Юрков', 'Рабочий', '5', 15000, 25),
	('Максим', 'Максимов', 'Рабочий', '2', 11000, 22),
	('Юрий', 'Галкин', 'Рабочий', '3', 12000, 24),
	('Людмила', 'Маркина', 'Уборщик', '10', 10000, 49),
	('Юрий', 'Онегин', 'Начальник', '8', 100000, 39);
    
-- ОКОННЫЕ ФУНКЦИИ
-- Ранжирование 
-- Вывести список всех сотрудников и указать место в рейтинге по зарплатам (max -> min)
SELECT
	DENSE_RANK() OVER(ORDER BY salary DESC) AS `dense_rank`,
    CONCAT(firstname, ' ', lastname) AS `fullname`,
    post, salary
FROM staff;

-- Вывести список всех сотрудников и указать место в рейтинге по зарплатам, но по каждой должности
SELECT
	DENSE_RANK() OVER(PARTITION BY post ORDER BY salary DESC) AS `dense_rank`,
    CONCAT(firstname, ' ', lastname) AS `fullname`,
    post, salary
FROM staff;

-- Найти самых высокооплачиваемых сотрудников по каждой должности
SELECT 
	DISTINCT post,
    salary,
    `dense_rank`
FROM 
(SELECT
	DENSE_RANK() OVER(PARTITION BY post ORDER BY salary DESC) AS `dense_rank`, -- если без DESC, то самые низкооплачиваемые сотрудники
    CONCAT(firstname, ' ', lastname) AS `fullname`,
    post, salary
FROM staff) AS rank_list
WHERE `dense_rank` = 1 -- Высокооплачиваемые сотрудники внутри каждой должности
ORDER BY salary;

--  Агрегация

-- Вывести всех сотрудников, отсортировав по зарплатам в рамках каждой должности и рассчитать:
-- общую сумму зарплат для каждой должности
-- процентное соотношение каждой зарплаты от общей суммы по должности
-- среднюю зарплату по каждой должности 
-- процентное соотношение каждой зарплаты к средней зарплате по должности

SELECT
	id,
	CONCAT(firstname, ' ', lastname) AS `fullname`,
    post, salary,
    SUM(salary) OVER w AS sum_salary,
    ROUND(salary * 100 / SUM(salary) OVER w, 4)  AS percent_sum_salary,
    AVG(salary) OVER w AS avg_salary,
    ROUND(salary * 100 / AVG(salary) OVER w, 2)  AS percent_avg_salary
FROM staff
WINDOW w AS (PARTITION BY post);
