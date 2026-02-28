-- =====================================
-- CLIENTES (103 sin cuentas)
-- =====================================
INSERT INTO cliente VALUES (101, 'Ana', 'Lopez', DATE '1998-05-12', 'juan@mail.com');
INSERT INTO cliente VALUES (102, 'Juan', 'Perez', DATE '1999-03-21', 'maria@mail.com');
INSERT INTO cliente VALUES (103, 'Marta', 'Ramirez', DATE '1995-04-18', 'diego@mail.com'); -- SIN CUENTAS


-- =====================================
-- OFICINAS (Norte sin cuentas)
-- =====================================
INSERT INTO oficinas VALUES (01, 'Centro', 'Chapinero');
INSERT INTO oficinas VALUES (02, 'Norte', 'Usaquen');


-- =====================================
-- CUENTAS (algunas sin titulares)
-- =====================================
INSERT INTO cuentas VALUES (201, 'A', 1200.50, 01);
INSERT INTO cuentas VALUES (202, 'C', 3500.00, 01);
INSERT INTO cuentas VALUES (203, 'C', 500.00, NULL);


-- =====================================
-- TITULARES 
-- =====================================
INSERT INTO titulares VALUES (101, 201);
INSERT INTO titulares VALUES (102, 202);



COMMIT;