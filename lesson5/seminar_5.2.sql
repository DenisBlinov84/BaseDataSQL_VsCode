-- ПРЕДСТАВЛЕНИЕ 

USE lesson_4;

CREATE OR REPLACE VIEW teacher_web AS
SELECT t.surname, web_lesson.course, web_lesson.teacher_id, t.salary
FROM teacher t  
JOIN (SELECT course, teacher_id
FROM lesson WHERE course = "Знакомство с веб-технологиями") AS web_lesson
ON t.teacher_id = web_lesson.teacher_id;

ALTER VIEW teacher_web AS
SELECT t.surname, web_lesson.course, web_lesson.teacher_id, t.salary
FROM teacher t  
JOIN (SELECT course, teacher_id
FROM lesson WHERE course = "Знакомство с языками программирования") AS web_lesson
ON t.teacher_id = web_lesson.teacher_id;

SELECT * 
FROM teacher_web;

CREATE OR REPLACE VIEW union_id AS
SELECT id
FROM teacher
UNION 
SELECT id
FROM lesson;
SELECT *
FROM union_id;


CREATE OR REPLACE VIEW show_all_teacher AS
SELECT * FROM (SELECT * FROM teacher) AS test;

SELECT * 
FROM show_all_teacher;
