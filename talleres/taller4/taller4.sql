DROP TABLE CLIENTES CASCADE CONSTRAINTS;
DROP TABLE OFICINAS CASCADE CONSTRAINTS;
DROP TABLE CUENTAS CASCADE CONSTRAINTS;
DROP TABLE TITULARES CASCADE CONSTRAINTS;
DROP TABLE MOVIMIENTOS CASCADE CONSTRAINTS;

CREATE TABLE CLIENTES (
    codigo_cliente NUMBER(3,0),
    nombre_cliente VARCHAR2(60),
    apellido_cliente VARCHAR2(60),
    fecha_nacimiento DATE,
    fecha_vinculacion DATE,
    Email VARCHAR2(60),
    genero char(1),
    PRIMARY KEY(codigo_cliente)
);

CREATE TABLE OFICINAS(
    codigo_oficina number(3,0),
    nombre VARCHAR2(60),
    PRIMARY KEY(codigo_oficina)
);

CREATE TABLE CUENTAS(
    numero_cuenta number(10,0),
    tipo char(1) CHECK(tipo in ('A','C')),
    codigo_oficina number(3,0),
    valor_apertura number(12,2),
    PRIMARY KEY(numero_cuenta),
    FOREIGN KEY(codigo_oficina) REFERENCES OFICINAS(codigo_oficina)
);

CREATE TABLE TITULARES(
    codigo_cliente number(3,0),
    numero_cuenta number(10,0),
    porcentaje_titularidad number(3,0),
    PRIMARY KEY(codigo_cliente, numero_cuenta),
    FOREIGN KEY(codigo_cliente) REFERENCES CLIENTES(codigo_cliente),
    FOREIGN KEY(numero_cuenta) REFERENCES CUENTAS(numero_cuenta)
);

CREATE TABLE MOVIMIENTOS(
    numero_cuenta number(10,0),
    numero number(3,0),
    tipo char(1) CHECK(tipo in ('D','C','I','R')),
    valor number(10,2),
    fecha_movimiento TIMESTAMP,
    PRIMARY KEY(numero_cuenta, numero),
    FOREIGN KEY(numero_cuenta) REFERENCES CUENTAS(numero_cuenta)
);
-- **La fecha movimiento debe manejar hora minuto y segundo.

-- CLIENTES
INSERT INTO CLIENTES(codigo_cliente, nombre_cliente, apellido_cliente, fecha_nacimiento, fecha_vinculacion, email, genero)
VALUES(1, 'Pedro',   'Perez',     TO_DATE('18/01/1980','DD/MM/YYYY'), TO_DATE('18/01/1990','DD/MM/YYYY'), NULL, 'M');
INSERT INTO CLIENTES(codigo_cliente, nombre_cliente, apellido_cliente, fecha_nacimiento, fecha_vinculacion, email, genero)
VALUES(2, 'Maria',   'Restrepo',  TO_DATE('18/02/1970','DD/MM/YYYY'), TO_DATE('18/02/1990','DD/MM/YYYY'), NULL, 'F');
INSERT INTO CLIENTES(codigo_cliente, nombre_cliente, apellido_cliente, fecha_nacimiento, fecha_vinculacion, email, genero)
VALUES(3, 'Juana',   'Arias',     TO_DATE('18/03/1990','DD/MM/YYYY'), TO_DATE('18/03/1990','DD/MM/YYYY'), NULL, 'F');
INSERT INTO CLIENTES(codigo_cliente, nombre_cliente, apellido_cliente, fecha_nacimiento, fecha_vinculacion, email, genero)
VALUES(4, 'Carlos',  'Lozano',    TO_DATE('18/04/2000','DD/MM/YYYY'), TO_DATE('18/04/2000','DD/MM/YYYY'), NULL, 'M');
INSERT INTO CLIENTES(codigo_cliente, nombre_cliente, apellido_cliente, fecha_nacimiento, fecha_vinculacion, email, genero)
VALUES(5, 'Esteban', 'Gonzalez',  TO_DATE('18/02/2001','DD/MM/YYYY'), TO_DATE('18/02/2001','DD/MM/YYYY'), NULL, 'M');
INSERT INTO CLIENTES(codigo_cliente, nombre_cliente, apellido_cliente, fecha_nacimiento, fecha_vinculacion, email, genero)
VALUES(6, 'John',    'Hurtado',   TO_DATE('20/02/1970','DD/MM/YYYY'), TO_DATE('20/02/1990','DD/MM/YYYY'), NULL, 'M');
INSERT INTO CLIENTES(codigo_cliente, nombre_cliente, apellido_cliente, fecha_nacimiento, fecha_vinculacion, email, genero)
VALUES(7, 'Juana',   'Perez',     TO_DATE('08/08/1950','DD/MM/YYYY'), TO_DATE('08/08/1990','DD/MM/YYYY'), NULL, 'F');

-- OFICINAS
INSERT INTO OFICINAS VALUES(10, 'Javeriana');
INSERT INTO OFICINAS VALUES(20, 'Galerias');
INSERT INTO OFICINAS VALUES(30, 'Portal 80');
INSERT INTO OFICINAS VALUES(40, 'Teusaquillo');

-- CUENTAS
INSERT INTO CUENTAS VALUES(100, 'A', 10,    0);
INSERT INTO CUENTAS VALUES(200, 'A', 20,  100);
INSERT INTO CUENTAS VALUES(300, 'C', 10,  500);
INSERT INTO CUENTAS VALUES(400, 'C', 10, 1000);
INSERT INTO CUENTAS VALUES(500, 'A', 10,  100);
INSERT INTO CUENTAS VALUES(600, 'A', 20,   50);

-- MOVIMIENTOS
INSERT INTO MOVIMIENTOS VALUES(100, 1, 'D', 10000, TO_TIMESTAMP('01/01/2000 10:00:23','DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTOS VALUES(100, 2, 'D', 25000, TO_TIMESTAMP('01/02/2000 10:05:23','DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTOS VALUES(100, 3, 'C',  5000, TO_TIMESTAMP('01/02/2000 10:10:23','DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTOS VALUES(400, 1, 'D', 58000, TO_TIMESTAMP('01/02/2000 10:15:23','DD/MM/YYYY HH24:MI:SS'));
INSERT INTO MOVIMIENTOS VALUES(400, 2, 'I',  2500, TO_TIMESTAMP('01/02/2000 10:16:23','DD/MM/YYYY HH24:MI:SS'));

-- TITULARES
INSERT INTO TITULARES VALUES(1, 100, 60);
INSERT INTO TITULARES VALUES(1, 200, 40);
INSERT INTO TITULARES VALUES(2, 100, 40);
INSERT INTO TITULARES VALUES(2, 200, 60);
INSERT INTO TITULARES VALUES(3, 300, 100);
INSERT INTO TITULARES VALUES(4, 400, 100);
INSERT INTO TITULARES VALUES(5, 500, 100);
INSERT INTO TITULARES VALUES(6, 600, 100);

COMMIT;

-- 1
WITH columna_saldo AS(
    SELECT numero_cuenta, SUM(
                                CASE
                                    WHEN tipo IN ('D','R') then valor
                                    WHEN tipo IN ('C','I') then -valor
                                END
                            ) AS saldo
    FROM MOVIMIENTOS M
    GROUP BY numero_cuenta
),
columna_titulares AS(
    SELECT C.numero_cuenta, COUNT(DISTINCT T.codigo_cliente) AS cantidad_titulares
    FROM CUENTAS C, TITUlARES T
    WHERE C.numero_cuenta = T.NUMERO_CUENTA
    GROUP BY C.numero_cuenta
)
SELECT C.numero_cuenta, cs.saldo, ct.cantidad_titulares, O.nombre
FROM OFICINAS O
LEFT JOIN CUENTAS C ON C.codigo_oficina = O.codigo_oficina
LEFT JOIN columna_saldo cs ON cs.numero_cuenta = C.NUMERO_CUENTA
LEFT JOIN columna_titulares ct ON ct.numero_cuenta = C.NUMERO_CUENTA;


-- 2 --
WITH SALDO_CUENTA AS (
    SELECT numero_cuenta,
           SUM(
               CASE
                   WHEN tipo IN ('D','R') THEN valor
                   WHEN tipo IN ('C','I') THEN -valor
               END
           ) saldo
    FROM MOVIMIENTOS
    GROUP BY numero_cuenta
),
MOV_STATS AS (
    SELECT numero_cuenta,
           MIN(fecha_movimiento) primer_mov,
           MAX(fecha_movimiento) ultimo_mov,
           COUNT(*) cant_mov
    FROM MOVIMIENTOS
    GROUP BY numero_cuenta
)

SELECT
    O.nombre oficina,

    NVL(COUNT(DISTINCT CASE WHEN CL.genero = 'M' THEN CL.codigo_cliente END),0) clientes_hombres, --si no es hombre devuelve null, si no hay hombres devuelve 0
    NVL(COUNT(DISTINCT CASE WHEN CL.genero = 'F' THEN CL.codigo_cliente END),0) clientes_mujeres,
    NVL(AVG(CASE WHEN CU.tipo = 'A' AND CL.genero = 'M' THEN SC.saldo END),0) promedio_ahorro_hombres,
    NVL(AVG(CASE WHEN CU.tipo = 'A' AND CL.genero = 'F' THEN SC.saldo END),0) promedio_ahorro_mujeres,

    MIN(MS.primer_mov) fecha_primer_movimiento,
    MAX(MS.ultimo_mov) fecha_ultimo_movimiento,

    -- Bro harry esta parte es una cosa loquisima, formamos pares con la concatenacion esa
    -- Entonces por el join de arriba con titulares, como una cuenta puede tener varios titulares 
    -- si contaramos los movimientos de titulares normal salen duplicados, por eso las concatenamos
    -- Ahora, solo contamos las diferentes y esas nos dá la cantidad de movimientos (5)
    NVL(COUNT(DISTINCT CASE WHEN M.numero IS NOT NULL THEN CU.numero_cuenta || '-' || M.numero END),0) cantidad_historica_movimientos

FROM OFICINAS O

LEFT JOIN CUENTAS CU ON CU.codigo_oficina = O.codigo_oficina
LEFT JOIN TITULARES T ON T.numero_cuenta = CU.numero_cuenta
LEFT JOIN CLIENTES CL ON CL.codigo_cliente = T.codigo_cliente
LEFT JOIN SALDO_CUENTA SC ON SC.numero_cuenta = CU.numero_cuenta
LEFT JOIN MOV_STATS MS ON MS.numero_cuenta = CU.numero_cuenta
LEFT JOIN MOVIMIENTOS M ON M.numero_cuenta = CU.numero_cuenta

GROUP BY O.nombre;  


-- 3
SELECT
    C.nombre_cliente || ' ' || C.apellido_cliente as nombre_completo,
    COUNT(DISTINCT CASE WHEN T.porcentaje_titularidad = 100 THEN T.numero_cuenta END) as "Numero de Cuentas con un porcentaje del 100",
    COUNT(DISTINCT CASE WHEN T.porcentaje_titularidad != 100 THEN T.numero_cuenta END) as "Numero de Cuentas con un porcentaje diferente al 100",
    MIN(M.fecha_movimiento) as "Fecha Primer Movimiento",
    COUNT(DISTINCT M.fecha_movimiento) as "Cantidad Movimientos", -- Se asume esto porque es imposible hacer el mismo movimiento en el mismo nanosegundo
    SUM(CASE WHEN M.tipo = 'D' THEN M.valor ELSE 0 END) as "Valor Movimientos Débitos de todas las cuentas",
    SUM(CASE WHEN M.tipo = 'C' THEN M.valor ELSE 0 END) as "Valor Movimientos Créditos de todas las cuentas",
    SUM(CASE WHEN M.tipo = 'I' THEN M.valor ELSE 0 END) as "Valor Movimientos Tipo Impuesto de todas las cuentas",
    SUM(CASE WHEN M.tipo = 'R' THEN M.valor ELSE 0 END) as "Valor Movimientos Tipo Rendimiento de todas las cuentas"
FROM CLIENTES C
LEFT JOIN TITULARES T ON T.codigo_cliente = C.codigo_cliente
LEFT JOIN MOVIMIENTOS M ON M.numero_cuenta = T.numero_cuenta
Group By c.codigo_cliente, c.nombre_cliente,c.apellido_cliente;

-- 4
-- Miramos como estaba antes
SELECT * 
FROM CUENTAS;

ALTER TABLE CUENTAS
ADD saldo NUMBER(12,2);

-- Aactualizamos bien chevere
UPDATE CUENTAS C
SET saldo =
    NVL((
        SELECT SUM(
                CASE
                    WHEN M.tipo IN ('D','R') THEN M.valor
                    WHEN M.tipo IN ('C','I') THEN -M.valor
                END
        )
        FROM MOVIMIENTOS M
        WHERE M.numero_cuenta = C.numero_cuenta
    ),0) + C.valor_apertura;

-- Para ver si si quedó saldo
SELECT *
FROM CUENTAS;