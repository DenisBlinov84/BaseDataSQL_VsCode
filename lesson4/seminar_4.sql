DROP DATABASE IF EXISTS lesson_4;
CREATE DATABASE lesson_4;
USE lesson_4;
DROP TABLE IF EXISTS teacher;
CREATE TABLE IF NOT EXISTS  teacher
(	
	teacher_id INT NOT NULL PRIMARY KEY,
    surname VARCHAR(45),
    salary INT
);

INSERT teacher
VALUES
	(1,"Авдеев", 17000),
    (2,"Гущенко",27000),
    (3,"Пчелкин",32000),
    (4,"Питошин",15000),
    (5,"Вебов",45000),
    (6,"Шарпов",30000),
    (7,"Шарпов",40000),
    (8,"Питошин",30000);
    
SELECT * FROM teacher; 

CREATE TABLE IF NOT EXISTS lesson 
(	
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    course VARCHAR(45),
    teacher_id INT,
    FOREIGN KEY (teacher_id)  REFERENCES teacher(teacher_id)
);
INSERT INTO lesson(course,teacher_id)
VALUES
	("Знакомство с веб-технологиями",1), --
    ("Знакомство с веб-технологиями",2),
    ("Знакомство с языками программирования",3),
    ("Базы данных и SQL",4);
    
SELECT * FROM lesson; 

INSERT INTO lesson(course,teacher_id)
VALUES
	("Знакомство с веб-технологиями",NULL);
    
-- Получить фамилию учителей и курсы, которые они ведут
SELECT t.surname, l.course
FROM teacher t  -- t = teacher 
JOIN lesson l -- INNER JOIN = JOIN, lesson = l
USING(teacher_id); -- ON t.teacher_id = l.teacher_id (teacher_id - одинаковое имя столбца для 2 таблиц)

select * 
from teacher t, lesson l 
where t.teacher_id = l.teacher_id;

-- Получаем учителей, которые ничего не ведут
SELECT t.surname, l.course
FROM teacher t  
LEFT JOIN lesson l
ON t.teacher_id = l.teacher_id 
WHERE l.teacher_id IS NULL;

SELECT *
FROM teacher  
WHERE  EXISTS  -- Учителя, которые ведут предметы
(SELECT * FROM lesson
WHERE teacher.teacher_id = lesson.teacher_id);

SELECT *
FROM teacher  
WHERE NOT EXISTS  -- Учителя, которые не ведут предметы
(SELECT * FROM lesson
WHERE teacher.teacher_id = lesson.teacher_id);

-- Получили всех учителей, которые работают в нашем ун-е
SELECT t.surname, l.course, t.teacher_id AS "id из teacher" , l.teacher_id  "id из lesson"
FROM teacher t  
LEFT JOIN lesson l
ON t.teacher_id = l.teacher_id;

SELECT t.surname, l.course, t.teacher_id AS "id из teacher" , l.teacher_id  "id из lesson"
FROM teacher t  
RIGHT JOIN lesson l
ON t.teacher_id = l.teacher_id;

-- CROSS JOIN
SELECT t.*, l.*, (SELECT COUNT(*)
FROM teacher t
CROSS JOIN lesson l) AS res
FROM teacher t
CROSS JOIN lesson l; -- 8 учителей. 4 курса
-- Размер: 4 * 8 = 32 строчки

-- Все учителей, которые ведут только курс "Знакомство с веб-технологиями"
SELECT t.*, l.*
FROM teacher t
JOIN lesson l
ON t.teacher_id = l.teacher_id
WHERE l.course = "Знакомство с веб-технологиями";

-- Подзапрос
SELECT t.* ,web_lesson.*
FROM teacher t
JOIN (SELECT course, teacher_id
FROM lesson WHERE course = "Знакомство с веб-технологиями") AS web_lesson
ON t.teacher_id = web_lesson.teacher_id;

-- UNION
SELECT teacher_id
FROM teacher
UNION ALL
SELECT teacher_id
FROM lesson;







