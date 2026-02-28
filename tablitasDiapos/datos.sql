-- INSERT DATA

-- Insertar Departamentos
INSERT INTO department VALUES ('Informática', 'Taylor', 100000.00);
INSERT INTO department VALUES ('Biología', 'Watson', 90000.00);
INSERT INTO department VALUES ('Matemáticas', 'Taylor', 85000.00);
INSERT INTO department VALUES ('Física', 'Watson', 95000.00);
INSERT INTO department VALUES ('Historia', 'Painter', 60000.00);

-- Insertar Estudiantes
INSERT INTO student VALUES ('00128', 'García López', 'Informática', 102);
INSERT INTO student VALUES ('12345', 'Rodríguez Silva', 'Informática', 32);
INSERT INTO student VALUES ('19991', 'Martínez Ruiz', 'Historia', 80);
INSERT INTO student VALUES ('23121', 'Fernández Díaz', 'Biología', 110);
INSERT INTO student VALUES ('44553', 'González Moreno', 'Física', 56);
INSERT INTO student VALUES ('45678', 'López Jiménez', 'Física', 46);
INSERT INTO student VALUES ('54321', 'Hernández Pérez', 'Informática', 54);
INSERT INTO student VALUES ('55739', 'Sánchez Torres', 'Matemáticas', 65);
INSERT INTO student VALUES ('70557', 'Ramírez Castro', 'Física', 0);
INSERT INTO student VALUES ('76543', 'Vargas Romero', 'Informática', 58);
INSERT INTO student VALUES ('76766', 'Flores Herrera', 'Biología', 0);

-- Insertar Instructores
INSERT INTO instructor VALUES ('10101', 'Pérez Gutiérrez', 'Informática', 65000.00);
INSERT INTO instructor VALUES ('12121', 'Muñoz Vega', 'Biología', 90000.00);
INSERT INTO instructor VALUES ('15151', 'Ortiz Navarro', 'Matemáticas', 40000.00);
INSERT INTO instructor VALUES ('22222', 'Reyes Mendoza', 'Física', 95000.00);
INSERT INTO instructor VALUES ('32343', 'Castro Delgado', 'Historia', 60000.00);
INSERT INTO instructor VALUES ('33456', 'Morales Blanco', 'Física', 87000.00);
INSERT INTO instructor VALUES ('45565', 'Jiménez Rojas', 'Informática', 75000.00);
INSERT INTO instructor VALUES ('58583', 'Torres Medina', 'Historia', 62000.00);
INSERT INTO instructor VALUES ('76543', 'Ramírez Cruz', 'Biología', 80000.00);
INSERT INTO instructor VALUES ('76766', 'Flores Herrera', 'Biología', 72000.00);
INSERT INTO instructor VALUES ('78787', 'Gómez Sánchez', 'Matemáticas', 72000.00);
INSERT INTO instructor VALUES ('80808', 'Díaz López', 'Informática', 100000.00);
INSERT INTO instructor VALUES ('90909', 'Soto García', 'Física', 100000.00);

-- Insertar Asesores
INSERT INTO advisor VALUES ('00128', '45565');
INSERT INTO advisor VALUES ('12345', '10101');
INSERT INTO advisor VALUES ('19991', '32343');
INSERT INTO advisor VALUES ('23121', '76543');
INSERT INTO advisor VALUES ('44553', '22222');
INSERT INTO advisor VALUES ('45678', '22222');
INSERT INTO advisor VALUES ('76543', '45565');
INSERT INTO advisor VALUES ('23121', '45565');

-- Insertar Cursos
INSERT INTO course VALUES ('BIO-101', 'Introducción a la Biología', 'Biología', 4);
INSERT INTO course VALUES ('BIO-301', 'Genética', 'Biología', 4);
INSERT INTO course VALUES ('CS-101', 'Introducción a la Informática', 'Informática', 4);
INSERT INTO course VALUES ('CS-190', 'Diseño de Videojuegos', 'Informática', 4);
INSERT INTO course VALUES ('CS-315', 'Robótica', 'Informática', 3);
INSERT INTO course VALUES ('CS-319', 'Procesamiento de Imágenes', 'Informática', 3);
INSERT INTO course VALUES ('CS-347', 'Sistemas de Bases de Datos', 'Informática', 3);
INSERT INTO course VALUES ('HIS-351', 'Historia Universal', 'Historia', 3);
INSERT INTO course VALUES ('MATH-231', 'Cálculo', 'Matemáticas', 4);
INSERT INTO course VALUES ('PHY-101', 'Principios de Física', 'Física', 4);

-- Insertar Prerrequisitos
INSERT INTO prereq VALUES ('BIO-301', 'BIO-101');
INSERT INTO prereq VALUES ('CS-190', 'CS-101');
INSERT INTO prereq VALUES ('CS-315', 'CS-101');
INSERT INTO prereq VALUES ('CS-347', 'CS-101');
INSERT INTO prereq VALUES ('CS-319', 'MATH-231');
INSERT INTO prereq VALUES ('CS-319', 'CS-101');

-- Insertar Aulas
INSERT INTO classroom VALUES ('Packard', 101, 500);
INSERT INTO classroom VALUES ('Painter', 514, 10);
INSERT INTO classroom VALUES ('Taylor', 3128, 70);
INSERT INTO classroom VALUES ('Watson', 100, 30);
INSERT INTO classroom VALUES ('Watson', 120, 50);

-- Insertar Franjas Horarias
INSERT INTO time_slot VALUES ('A', 1, '08:00', '08:50');
INSERT INTO time_slot VALUES ('A', 3, '08:00', '08:50');
INSERT INTO time_slot VALUES ('A', 5, '08:00', '08:50');
INSERT INTO time_slot VALUES ('B', 1, '09:00', '09:50');
INSERT INTO time_slot VALUES ('B', 3, '09:00', '09:50');
INSERT INTO time_slot VALUES ('B', 5, '09:00', '09:50');
INSERT INTO time_slot VALUES ('C', 1, '11:00', '11:50');
INSERT INTO time_slot VALUES ('C', 3, '11:00', '11:50');
INSERT INTO time_slot VALUES ('C', 5, '11:00', '11:50');
INSERT INTO time_slot VALUES ('D', 2, '13:00', '13:50');
INSERT INTO time_slot VALUES ('D', 4, '13:00', '13:50');
INSERT INTO time_slot VALUES ('E', 2, '10:30', '11:45');
INSERT INTO time_slot VALUES ('E', 4, '10:30', '11:45');
INSERT INTO time_slot VALUES ('F', 2, '14:30', '15:45');
INSERT INTO time_slot VALUES ('F', 4, '14:30', '15:45');
INSERT INTO time_slot VALUES ('G', 5, '16:00', '18:00');

-- Insertar Secciones
INSERT INTO section VALUES ('BIO-101', '1', 1, 2025, 'Painter', 514, 'B', 1, '09:00');
INSERT INTO section VALUES ('BIO-301', '1', 1, 2025, 'Painter', 514, 'A', 1, '08:00');
INSERT INTO section VALUES ('CS-101', '1', 1, 2025, 'Packard', 101, 'C', 1, '11:00');
INSERT INTO section VALUES ('CS-190', '1', 1, 2025, 'Taylor', 3128, 'E', 2, '10:30');
INSERT INTO section VALUES ('CS-190', '2', 1, 2025, 'Taylor', 3128, 'A', 1, '08:00');
INSERT INTO section VALUES ('CS-315', '1', 1, 2025, 'Watson', 120, 'D', 2, '13:00');
INSERT INTO section VALUES ('CS-319', '1', 1, 2025, 'Watson', 100, 'B', 1, '09:00');
INSERT INTO section VALUES ('CS-319', '2', 1, 2025, 'Taylor', 3128, 'C', 1, '11:00');
INSERT INTO section VALUES ('CS-347', '1', 1, 2025, 'Taylor', 3128, 'A', 1, '08:00');
INSERT INTO section VALUES ('HIS-351', '1', 1, 2025, 'Painter', 514, 'C', 1, '11:00');
INSERT INTO section VALUES ('MATH-231', '1', 1, 2025, 'Packard', 101, 'F', 2, '14:30');
INSERT INTO section VALUES ('PHY-101', '1', 1, 2025, 'Watson', 100, 'A', 1, '08:00');

-- Insertar Inscripciones de Estudiantes (takes)
INSERT INTO takes VALUES ('00128', 'CS-101', '1', 1, 2025, 'A');
INSERT INTO takes VALUES ('00128', 'CS-347', '1', 1, 2025, 'A-');
INSERT INTO takes VALUES ('12345', 'CS-101', '1', 1, 2025, 'C');
INSERT INTO takes VALUES ('12345', 'CS-190', '2', 1, 2025, 'A');
INSERT INTO takes VALUES ('12345', 'CS-315', '1', 1, 2025, 'A');
INSERT INTO takes VALUES ('12345', 'CS-347', '1', 1, 2025, 'A');
INSERT INTO takes VALUES ('19991', 'HIS-351', '1', 1, 2025, 'B');
INSERT INTO takes VALUES ('23121', 'BIO-101', '1', 1, 2025, 'C');
INSERT INTO takes VALUES ('44553', 'PHY-101', '1', 1, 2025, 'B-');
INSERT INTO takes VALUES ('45678', 'CS-101', '1', 1, 2025, 'F');
INSERT INTO takes VALUES ('45678', 'CS-319', '1', 1, 2025, 'B');
INSERT INTO takes VALUES ('54321', 'CS-101', '1', 1, 2025, 'A-');
INSERT INTO takes VALUES ('54321', 'CS-190', '2', 1, 2025, 'B+');
INSERT INTO takes VALUES ('55739', 'MATH-231', '1', 1, 2025, 'B');
INSERT INTO takes VALUES ('76543', 'CS-101', '1', 1, 2025, 'A');
INSERT INTO takes VALUES ('76543', 'CS-319', '2', 1, 2025, 'A');

-- Insertar Asignaciones de Instructores (teaches)
INSERT INTO teaches VALUES ('10101', 'CS-101', '1', 1, 2025);
INSERT INTO teaches VALUES ('10101', 'CS-315', '1', 1, 2025);
INSERT INTO teaches VALUES ('10101', 'CS-347', '1', 1, 2025);
INSERT INTO teaches VALUES ('12121', 'BIO-101', '1', 1, 2025);
INSERT INTO teaches VALUES ('12121', 'BIO-301', '1', 1, 2025);
INSERT INTO teaches VALUES ('15151', 'MATH-231', '1', 1, 2025);
INSERT INTO teaches VALUES ('22222', 'PHY-101', '1', 1, 2025);
INSERT INTO teaches VALUES ('32343', 'HIS-351', '1', 1, 2025);
INSERT INTO teaches VALUES ('45565', 'CS-101', '1', 1, 2025);
INSERT INTO teaches VALUES ('45565', 'CS-319', '1', 1, 2025);
INSERT INTO teaches VALUES ('76766', 'BIO-101', '1', 1, 2025);
INSERT INTO teaches VALUES ('76766', 'BIO-301', '1', 1, 2025);

COMMIT;