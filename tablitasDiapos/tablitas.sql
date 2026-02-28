DROP TABLE department CASCADE CONSTRAINTS;
DROP TABLE student CASCADE CONSTRAINTS;
DROP TABLE instructor CASCADE CONSTRAINTS;
DROP TABLE advisor CASCADE CONSTRAINTS;
DROP TABLE course CASCADE CONSTRAINTS;
DROP TABLE prereq CASCADE CONSTRAINTS;
DROP TABLE classroom CASCADE CONSTRAINTS;
DROP TABLE time_slot CASCADE CONSTRAINTS;
DROP TABLE section CASCADE CONSTRAINTS;
DROP TABLE takes CASCADE CONSTRAINTS;
DROP TABLE teaches CASCADE CONSTRAINTS;


CREATE TABLE department (
  dept_name VARCHAR(20) PRIMARY KEY,
  building VARCHAR(15),
  budget NUMERIC(12, 2)
);

CREATE TABLE student(
    ID        VARCHAR2(15),
    name      VARCHAR2(20),
    dept_name VARCHAR(20),
    tot_cred  NUMBER(3),
    PRIMARY KEY (ID),
    FOREIGN KEY (dept_name) REFERENCES department (dept_name)
);

CREATE TABLE instructor
(
    ID        VARCHAR2(15),
    name      VARCHAR2(20),
    dept_name VARCHAR(20),
    salary    NUMBER(8, 2),
    PRIMARY KEY (ID),
    FOREIGN KEY (dept_name) REFERENCES department (dept_name)
);

CREATE TABLE advisor(
    s_ID VARCHAR2(15),
    i_ID VARCHAR2(15),
    PRIMARY KEY (s_ID, i_ID),
    FOREIGN KEY (s_ID) REFERENCES student (ID),
    FOREIGN KEY (i_ID) REFERENCES instructor (ID)
);

CREATE TABLE course
(
    course_id   VARCHAR2(8),
    title       VARCHAR2(50),
    dept_name   VARCHAR2(20),
    credits     NUMBER(2),
    PRIMARY KEY (course_id),
    FOREIGN KEY (dept_name) REFERENCES department (dept_name)
);

CREATE TABLE prereq(
    course_id VARCHAR2(8),
    prereq_id VARCHAR2(8),
    PRIMARY KEY (course_id, prereq_id),
    FOREIGN KEY (course_id) REFERENCES course (course_id),
    FOREIGN KEY (prereq_id) REFERENCES course (course_id)
);

CREATE TABLE classroom(
    building VARCHAR2(15),
    room_number NUMBER(4),
    capacity NUMBER(4),
    PRIMARY KEY (building, room_number)
);

CREATE TABLE time_slot(
    time_slot_id VARCHAR2(8),
    day NUMBER(1),
    start_time VARCHAR2(8),
    end_time VARCHAR2(8),
    PRIMARY KEY (time_slot_id, day, start_time)
);

CREATE TABLE section(
    course_id VARCHAR2(8),
    sec_id VARCHAR2(8),
    semester NUMBER(2),
    year NUMBER(4),
    building VARCHAR2(15),
    room_number NUMBER(4),
    time_slot_id VARCHAR2(8),
    day NUMBER(1),
    start_time VARCHAR2(8),
    PRIMARY KEY (course_id, sec_id, semester, year),
    FOREIGN KEY (time_slot_id, day, start_time) REFERENCES time_slot(time_slot_id, day, start_time),
    FOREIGN KEY (building, room_number) REFERENCES classroom(building, room_number)
);

CREATE TABLE takes(
    ID VARCHAR2(15),
    course_id VARCHAR2(8),
    sec_id VARCHAR2(8),
    semester NUMBER(2),
    year NUMBER(4),
    grade VARCHAR2(2),
    PRIMARY KEY (ID, course_id, sec_id, semester, year),
    FOREIGN KEY (ID) REFERENCES student(ID),
    FOREIGN KEY (course_id, sec_id, semester, year) REFERENCES section(course_id, sec_id, semester, year)
);

CREATE TABLE teaches(
    ID VARCHAR2(15),
    course_id VARCHAR2(8),
    sec_id VARCHAR2(8),
    semester NUMBER(2),
    year NUMBER(4),
    PRIMARY KEY (ID, course_id, sec_id, semester, year),
    FOREIGN KEY (ID) REFERENCES instructor(ID),
    FOREIGN KEY (course_id, sec_id, semester, year) REFERENCES section(course_id, sec_id, semester, year)
);

--------------------------------- Querys ----------------------------------------
-- 1) Nombre de los estudiantes, junto con el nombre de su consejero.
SELECT S.NAME as NombreEstudiante, I.NAME as NombreInstructor
FROM Student S, Instructor I, ADVISOR A
WHERE A.I_ID = I.ID AND A.S_ID = S.ID;

-- 2) Por departamento cuantos cursos se ofrecen.
SELECT dept_name as Departamento, COUNT(*) as Cantidad
FROM COURSE
GROUP BY dept_name;

-- 3) Nombre de los instructores con el salario mas alto. 
SELECT NAME as Nombre, salary as Salario
FROM Instructor 
WHERE salary = (SELECT MAX(salary) FROM INSTRUCTOR);

-- 4) Nombre del curso y nombre de su prerequisito
SELECT C.TITLE NombreCurso, P.TITLE NombrePrereq
FROM Prereq PR
JOIN Course C on PR.COURSE_ID = C.COURSE_ID
JOIN Course P on PR.PREREQ_ID = P.COURSE_ID;

-- 5) Por instructor (nombre), cuantos estudiantes tiene en consejería. 
SELECT I.name Nombre, COUNT(*) Estudiantes
FROM Advisor AD
JOIN Instructor I on AD.i_id = I.ID
JOIN Student S on AD.s_id = S.ID
GROUP BY I.name;

-- 6) Por estudiante, cuantos instructores tiene en consejeria
SELECT S.name Nombre, COUNT(*) Estudiantes
FROM Advisor AD
JOIN Instructor I on AD.i_id = I.ID
JOIN Student S on AD.s_id = S.ID
GROUP BY S.name;

-- 7) Nombre del estudiante con menor numero de creditos
SELECT NAME Nombre, tot_cred Creditos
FROM Student
WHERE tot_cred = (SELECT MIN(tot_cred) FROM STUDENT);

-- 8) Suponiendo que el campo salary es el mensual, calcule el salario anual considerando 13
SELECT name Nombre, salary*13 Salario
FROM Instructor;
