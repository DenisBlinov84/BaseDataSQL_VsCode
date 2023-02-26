-- Коментарий. Пробел после дефиса обязательный 
# Как в Питоне
/*
Это 
Многострочный
Комментарий 
*/ 

-- Создание БД 
CREATE DATABASE lesson1; -- Создали БД в lesson1

-- Подключение к БД 
USE lesson1; -- Мы работаем в lesson1

-- Создание таблицы 
CREATE TABLE student
(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(30) NOT NULL,
    email VARCHAR(30),
    phone VARCHAR(30)
); 

-- Заполняем таблицу данными
INSERT student(first_name, email, phone)
VALUES
	("Антон", "hhgfff@gmail.com", "7-999-888-77-66"),
    ("Антон", "hrrrrr@gmail.com", "7-999-666-77-66"),
    ("Андрей", "hhgfff@gmail.com", "7-999-555-77-66"),
    ("Андрей", "llgfff@gmail.com", "7-999-885-77-66"),
    ("Виктория", "Victoria@gmail.com", "7-999-455-77-66"),
    ("Влада", "Vlada@gmail.com", "7-999-444-77-66");
    

-- Получить информацию о студентах 
SELECT *
FROM student;

-- 1. Получим имя, номер телефона
SELECT first_name, phone
FROM student;

-- 2. Получим имя, номер телефона конкретного студента (Андрей)
SELECT first_name, phone
FROM student
WHERE first_name = "андрей";

-- 3. Получить студентов, имена которых начинаются с буквы "А"
SELECT first_name, phone
FROM student
WHERE first_name LIKE "а%";

-- 4. Получить студентов, почта которых не 
SELECT first_name, phone
FROM student
WHERE email != "Vlada@gmail.com"; -- вместо != можно написать NOT LIKE, или WHERE NOT email = "Vlada@gmail.com"







    
  