-- 1.	Создайте функцию, которая принимает кол-во сек и форматирует их в кол-во дней, часов, минут и секунд.
-- Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '

DROP FUNCTION IF EXISTS sectotime;
delimiter $$
CREATE FUNCTION sectotime(val INT)
RETURNS CHAR(15)
DETERMINISTIC
BEGIN
	DECLARE DD CHAR(3);
	DECLARE HH, MI, SS CHAR(2);
	DECLARE res CHAR(15);
		SET DD = cast(floor(val/60/60/24) AS CHAR(3));
		SET HH = cast(floor(mod(val/60/60/24,1)*24) AS CHAR(2));
		SET MI = cast(floor(mod(mod(val/60/60/24,1)*24,1)*60) AS CHAR(2));
		SET SS = cast(round(mod(mod(mod(val/60/60/24,1)*24,1)*60,1)*60) AS CHAR(2));
		SET res = concat(DD,'.',HH,':',MI,':',SS);
RETURN res;
END $$;
delimiter ;

SELECT sectotime(123456) dt FROM DUAL; 

-- 2.	Выведите только четные числа от 1 до 10 включительно. (Через функцию / процедуру)
-- Пример: 2,4,6,8,10 (можно сделать через шаг +  2: х = 2, х+=2) 

delimiter $$
CREATE FUNCTION input_chetn (num INT)
RETURNS VARCHAR(256)
DETERMINISTIC
BEGIN
	DECLARE i INT DEFAULT 0;
	DECLARE result VARCHAR(256);
	SET result='';
		WHILE i < num DO
			SET i = i + 2;
			SET result = concat(result, ' ', i);
			END while;
			RETURN result;
END $$
delimiter ;

SELECT input_chetn(10);




