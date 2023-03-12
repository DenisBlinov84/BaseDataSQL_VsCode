USE lesson_5;
delimiter //
CREATE PROCEDURE hello()
BEGIN
	CASE
		WHEN curtime() BETWEEN '06:00:00' AND '11:59:59'
			THEN SELECT 'Доброе утро';
		WHEN curtime() BETWEEN '12:00:00' AND '17:59:59'
			THEN SELECT 'Добрый день';
		WHEN curtime() BETWEEN '18:00:00' AND '23:59:59'
			THEN SELECT 'Доброе утро';
		ELSE 
			SELECT 'Доброй ночи';
	END CASE;
END //
delimiter ;

CALL hello();

-- -----------------------------------------------------------------------------------------------------
-- Числа Фибоначчи

delimiter $$
CREATE FUNCTION fibonacci(num INT) -- Количество чисел Фибоначчи для печати
RETURNS VARCHAR(30)
DETERMINISTIC
BEGIN
	DECLARE fib1 INT DEFAULT 0; -- fib1 = 0
    DECLARE fib2 INT DEFAULT 1; -- fib2 = 1
    DECLARE fib3 INT DEFAULT 0; -- fib3 = 0
    DECLARE result VARCHAR(30) DEFAULT '0 1'; -- Первые два числа Фибоначчи
    
    IF num = 1 THEN
		RETURN fib1; -- num = 1, то печатаем только первое число Фибоначчи
	ELSEIF num = 2 THEN
		RETURN concat(fib1, " ", fib2); -- = result
    ELSE
		WHILE num > 2 DO
			SET fib3 = fib1 + fib2;
            SET fib1 = fib2;
            SET fib2 = fib3;
            SET num = num - 1;
            SET result = concat(result, " ", fib3);
		END WHILE;
        RETURN result;
	END IF;
END $$
delimiter ;

SELECT fibonacci(10);

-- ----------------------------------------------------------------------------------------

-- Пример транзакции;
DROP TABLE IF EXISTS bankaccounts;
CREATE TABLE IF NOT EXISTS bankaccounts(accountno VARCHAR(20) PRIMARY KEY NOT NULL, funds DECIMAL(8,2));
INSERT INTO  bankaccounts VALUES("ACC1", 1000);
INSERT INTO  bankaccounts VALUES("ACC2", 1000);

SELECT * 
FROM bankaccounts;

START TRANSACTION;
	UPDATE bankaccounts SET funds=funds-100 WHERE accountno="ACC1"; -- ACC1 = ACC1 - 100 
 	UPDATE bankaccounts SET funds=funds+100 WHERE accountno="ACC2"; -- ACC2 = ACC2 - 100 
    
SELECT * 
FROM bankaccounts;

-- ----------------------------------------------------------------------------------------


   


