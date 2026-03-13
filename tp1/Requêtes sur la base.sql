-- Exercice 2

--  1.

DESC section;
SELECT * FROM section;

-- 2.

SELECT * FROM course;

-- 3. 

SELECT title, dept_name 
FROM course;

-- 4. 

SELECT dept_name, budget
FROM department; 

-- 5 

SELECT name, dept_name
FROM teacher;

-- 6 

SELECT name
FROM teacher
WHERE salary > 65000;

-- 7

SELECT name
FROM teacher
WHERE salary between 55000 AND 85000;

-- 8. 

SELECT DISTINCT dept_name 
FROM teacher;

-- 9 

SELECT name
FROM teacher 
WHERE dept_name = 'Comp. Sci.' AND salary > 65000;

-- 10 

SELECT *
FROM section 
WHERE semester = 'Spring'
AND year = 2010;

-- 11. 

SELECT title
FROM course
WHERE dept_name = 'Comp. Sci.' AND credits > 3;


-- 12. 

SELECT t.name, t.dept_name, d.building
FROM teacher t, department d
WHERE t.dept_name = d.dept_name;

-- 13

SELECT name
FROM student, takes, course 
WHERE student.ID = takes.ID
AND takes.course_id = course.course_id
AND course.dept_name = 'Comp. Sci.'

-- 14
SELECT DISTINCT student.name
FROM student, takes, teaches, teacher
WHERE student.ID = takes.ID
AND takes.course_id = teaches.course_id
AND takes.sec_id = teaches.sec_id
AND takes.semester = teaches.semester
AND takes.year = teaches.year
AND teaches.ID = teacher.ID
AND teacher.name = 'Einstein';

-- 15
SELECT teaches.course_id, teacher.name
FROM teaches, teacher
WHERE teaches.ID = teacher.ID;

-- 16
SELECT course_id, sec_id, COUNT(ID)
FROM takes
WHERE semester = 'Spring'
AND year = 2010
GROUP BY course_id, sec_id;

-- 17
SELECT dept_name, MAX(salary)
FROM teacher
GROUP BY dept_name;

-- 18
SELECT course_id, sec_id, semester, year, COUNT(ID)
FROM takes
GROUP BY course_id, sec_id, semester, year;

-- 19
SELECT building, COUNT(*)
FROM section
WHERE (semester = 'Fall' AND year = 2009)
OR (semester = 'Spring' AND year = 2010)
GROUP BY building;

-- 20
SELECT course.dept_name, COUNT(*)
FROM course, section, department
WHERE course.course_id = section.course_id
AND course.dept_name = department.dept_name
AND section.building = department.building
GROUP BY course.dept_name;

-- 21
SELECT DISTINCT course.title, teacher.name
FROM course, section, teaches, teacher
WHERE course.course_id = section.course_id
AND section.course_id = teaches.course_id
AND section.sec_id = teaches.sec_id
AND section.semester = teaches.semester
AND section.year = teaches.year
AND teaches.ID = teacher.ID;

-- 22
SELECT semester, COUNT(*)
FROM section
WHERE semester IN ('Summer', 'Fall', 'Spring')
GROUP BY semester;

-- 23
SELECT student.name, SUM(course.credits)
FROM student, takes, course
WHERE student.ID = takes.ID
AND takes.course_id = course.course_id
AND course.dept_name != student.dept_name
GROUP BY student.name;

-- 24
SELECT department.dept_name, SUM(course.credits)
FROM course, section, department
WHERE course.course_id = section.course_id
AND course.dept_name = department.dept_name
AND section.building = department.building
GROUP BY department.dept_name;