USE school;

INSERT INTO students (name, age, major) VALUES ('테스트2', 26, '컴퓨터공학');

SELECT * FROM students;

UPDATE students SET major = '수학과' WHERE student_id = 2;

UPDATE students SET major = NULL WHERE student_id = 2;
--  실습 코드
SELECT name, age FROM students WHERE age BETWEEN 24 AND 27;

SELECT * FROM students WHERE major IN ('화학과', '수학과');

SELECT * FROM students WHERE major LIKE '%과';

SELECT name, major FROM students WHERE major is NULL;

SELECT * FROM students ORDER BY age ASC;

-------------------------------------------

CREATE TABLE subjects (
	subject_id INT auto_increment PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL
);

CREATE TABLE professors (
	professor_id INT AUTO_INCREMENT PRIMARY KEY,
    professor_name VARCHAR(100) NOT NULL,
    subject_id INT NOT NULL,
    FOREIGN KEY (subject_id) references subjects(subject_id)
);

CREATE TABLE student_subjects (
	student_id INT NOT NULL,
    subject_id INT NOT NULL,
    foreign key (student_id) references students(student_id),
    foreign key (subject_id) references subjects(subject_id)
);

INSERT INTO subjects (subject_name) VALUES ('유기화학'), ('데이터베이스'), ('알고리즘');

INSERT INTO professors (professor_name, subject_id) VALUES ('김화학', 1), ('이데이터', 1), ('박알고', 3);

INSERT INTO student_subjects (student_id, subject_id) VALUES (1, 1), (3, 2), (4, 3);

ALTER TABLE students
CHANGE name student_name VARCHAR(50);

SELECT * FROM students;
SELECT * FROM subjects;
SELECT * FROM professors;
SELECT * FROM student_subjects;


SELECT 
	students.student_name AS student_name,
    subjects.subject_name,
    professors.professor_name
FROM
	students
JOIN
	student_subjects ON students.student_id = student_subjects.student_id
JOIN
	subjects ON student_subjects.subject_id = subjects.subject_id
JOIN
	professors ON subjects.subject_id = professors.subject_id;

SELECT
	students.student_id,
	students.student_name,
    students.age,
    students.major,
    professors.professor_id,
    professors.professor_name
FROM student_subjects
JOIN students
ON student_subjects.student_id = students.student_id
INNER JOIN professors
ON student_subjects.subject_id = professors.subject_id;

SELECT *
FROM students
CROSS JOIN subjects;













