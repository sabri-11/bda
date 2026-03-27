-- 1
SELECT dept_name
FROM department
WHERE budget = (SELECT MAX(budget) FROM department);

-- 2
SELECT name, salary
FROM teacher
WHERE salary > (SELECT AVG(salary) FROM teacher);

-- 3
SELECT teacher.name, student.name, COUNT(*) AS nb_cours
FROM teacher, teaches, takes, student
WHERE teacher.ID = teaches.ID
AND teaches.course_id = takes.course_id
AND teaches.sec_id = takes.sec_id
AND teaches.semester = takes.semester
AND teaches.year = takes.year
AND takes.ID = student.ID
GROUP BY teacher.name, student.name
HAVING COUNT(*) > 2;

-- 4
SELECT teacher.name, student.name, nb_cours
FROM teacher,
    (SELECT teaches.ID AS tid, takes.ID AS sid, COUNT(*) AS nb_cours
     FROM teaches, takes
     WHERE teaches.course_id = takes.course_id
     AND teaches.sec_id = takes.sec_id
     AND teaches.semester = takes.semester
     AND teaches.year = takes.year
     GROUP BY teaches.ID, takes.ID) cours
, student
WHERE teacher.ID = cours.tid
AND student.ID = cours.sid
AND cours.nb_cours > 2;

-- 5
SELECT ID, name
FROM student
WHERE ID NOT IN (
    SELECT ID
    FROM takes
    WHERE year < 2010
);

-- 6
SELECT name
FROM teacher
WHERE name LIKE 'E%';

-- 7
SELECT name, salary
FROM teacher
WHERE salary = (
    SELECT MIN(salary)
    FROM (
        SELECT DISTINCT salary
        FROM teacher
        ORDER BY salary DESC
        FETCH FIRST 4 ROWS ONLY
    )
);

-- 8
SELECT name, salary
FROM (
    SELECT name, salary
    FROM teacher
    ORDER BY salary ASC
    FETCH FIRST 3 ROWS ONLY
)
ORDER BY salary DESC;

-- 9
SELECT DISTINCT name
FROM student
WHERE ID IN (
    SELECT ID
    FROM takes
    WHERE semester = 'Fall'
    AND year = 2009
);

-- 10
SELECT DISTINCT name
FROM student
WHERE ID = SOME (
    SELECT ID
    FROM takes
    WHERE semester = 'Fall'
    AND year = 2009
);

-- 11
SELECT DISTINCT student.name
FROM student
NATURAL INNER JOIN takes
WHERE semester = 'Fall'
AND year = 2009;

-- 12
SELECT DISTINCT name
FROM student
WHERE EXISTS (
    SELECT *
    FROM takes
    WHERE takes.ID = student.ID
    AND semester = 'Fall'
    AND year = 2009
);

-- 13
SELECT DISTINCT s1.name, s2.name
FROM student s1, student s2, takes t1, takes t2
WHERE s1.ID = t1.ID
AND s2.ID = t2.ID
AND t1.course_id = t2.course_id
AND t1.sec_id = t2.sec_id
AND t1.semester = t2.semester
AND t1.year = t2.year
AND s1.ID < s2.ID;

-- 14
SELECT teacher.name, COUNT(*) AS nb_etudiants
FROM teacher, teaches, takes
WHERE teacher.ID = teaches.ID
AND teaches.course_id = takes.course_id
AND teaches.sec_id = takes.sec_id
AND teaches.semester = takes.semester
AND teaches.year = takes.year
GROUP BY teacher.name
ORDER BY nb_etudiants DESC;

-- 15
SELECT teacher.name, COUNT(takes.ID) AS nb_etudiants
FROM teacher
LEFT JOIN teaches ON teacher.ID = teaches.ID
LEFT JOIN takes ON teaches.course_id = takes.course_id
    AND teaches.sec_id = takes.sec_id
    AND teaches.semester = takes.semester
    AND teaches.year = takes.year
GROUP BY teacher.name
ORDER BY nb_etudiants DESC;

-- 16
SELECT teacher.name, COUNT(*) AS nb_grades_A
FROM teacher, teaches, takes
WHERE teacher.ID = teaches.ID
AND teaches.course_id = takes.course_id
AND teaches.sec_id = takes.sec_id
AND teaches.semester = takes.semester
AND teaches.year = takes.year
AND takes.grade LIKE 'A%'
GROUP BY teacher.name;

-- 17
SELECT teacher.name, student.name, COUNT(*) AS nb_fois
FROM teacher, teaches, takes, student
WHERE teacher.ID = teaches.ID
AND teaches.course_id = takes.course_id
AND teaches.sec_id = takes.sec_id
AND teaches.semester = takes.semester
AND teaches.year = takes.year
AND takes.ID = student.ID
GROUP BY teacher.name, student.name;

-- 18
SELECT teacher.name, student.name, COUNT(*) AS nb_cours
FROM teacher, teaches, takes, student
WHERE teacher.ID = teaches.ID
AND teaches.course_id = takes.course_id
AND teaches.sec_id = takes.sec_id
AND teaches.semester = takes.semester
AND teaches.year = takes.year
AND takes.ID = student.ID
GROUP BY teacher.name, student.name
HAVING COUNT(*) >= 2;