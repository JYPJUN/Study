-- 데이터베이스 관련 명령어
CREATE DATABASE school;

SHOW DATABASES;

USE school;

DROP database school;

-- 테이블 관련 명령어
CREATE TABLE students (
	student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    age INT,
    major VARCHAR(50)
);

SHOW TABLES;

DESCRIBE students;

ALTER TABLE students ADD email VARCHAR(100) UNIQUE;

ALTER TABLE students DROP COLUMN email;

ALTER TABLE students CHANGE age student_age INT;

ALTER TABLE students MODIFY student_age SMALLINT;

DROP TABLE students;

CREATE TABLE orders (
	order_id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE NOT NULL
);

describe orders;

-- 테이블 확인용
describe students;
SELECT * FROM students;
SELECT student_id, name, age FROM students;
SELECT * FROM students ORDER BY age DESC;
SELECT DISTINCT major FROM students;
SELECT * FROM students LIMIT 1;
-- 

INSERT INTO students (name, age, major) VALUES ('이슬비', 23, '컴퓨터공학');

UPDATE students SET age = 25 WHERE student_id = 1;

DELETE FROM students WHERE student_id = 3;


















