-- Задание 1. 

LOAD DATA INFILE
"D:\GeekBrains\Основное обучение\Базы данных и SQL\Семинары\5. SQL – оконные функции\ExportCSV (4).csv"
INTO TABLE cars
FIELDS TERMINATED BY ','
ENCLOSED BY '"';

CREATE TABLE cars
(
	id INT NOT NULL PRIMARY KEY,
    name VARCHAR(45),
    cost INT
);

INSERT cars
VALUES
	(1, "Audi", 52642),
    (2, "Mercedes", 57127 ),
    (3, "Skoda", 9000 ),
    (4, "Volvo", 29000),
	(5, "Bentley", 350000),
    (6, "Citroen ", 21000 ), 
    (7, "Hummer", 41400), 
    (8, "Volkswagen ", 21600),
    (9, "Skoda", 9500 ),
    (10, "Citroen ", 9500 );
    
-- 1.1 Создайте представление, в которое попадут автомобили стоимостью  до 25 000 долларов. 

CREATE OR REPLACE VIEW cars_web AS
SELECT
	DENSE_RANK() OVER(ORDER BY cost) AS `dense_rank`,
    `name`, cost
FROM cars 
WHERE cost < 25000;

SELECT * 
FROM cars_web;


-- 1.2 Изменить в существующем представлении порог для стоимости: пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW). 

ALTER VIEW cars_web AS
SELECT
	DENSE_RANK() OVER(ORDER BY cost) AS `dense_rank`,
    `name`, cost
FROM cars 
WHERE cost < 30000; 

-- 1.3 Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди”. 

CREATE OR REPLACE VIEW cars_skoda_audi AS
SELECT
	DENSE_RANK() OVER(ORDER BY cost) AS `dense_rank`,
    `name`, cost
FROM cars 
WHERE `name` = "Skoda" OR `name` = "Audi";

SELECT * 
FROM cars_skoda_audi; 


-- Задание 2. 

DROP TABLE IF EXISTS trains;
CREATE TABLE trains
(
train_id INT NOT NULL,
station VARCHAR(20),
station_time TIME # HH:MM:SS
);
INSERT trains VALUES
(110,'San Francisco','10:00:00'),
(110,'Redwood City', '10:54:00'),
(110,'Palo Alto', '11:02:00'),
(110,'San Jose', '12:35:00'),
(120,'San Francisco','11:00:00'),
(120,'Palo Alto', '12:49:00'),
(120,'San Jose', '13:30:00');

-- 1 вариант
CREATE OR REPLACE VIEW lead_time AS
SELECT
	train_id, station, station_time, 
	LEAD(station_time) OVER w AS lead_time
FROM trains 
WINDOW w AS (PARTITION BY train_id);

select * from lead_time;

SELECT
	train_id, station, station_time, 
	TIMEDIFF(lead_time, station_time) AS time_to_next_station
FROM lead_time 
WINDOW w AS (PARTITION BY train_id);

-- 2 вариант
SELECT 
	train_id,  station, station_time,
    timediff(LEAD(station_time) OVER(), station_time) AS "Next_station"
FROM trains;
	
	