DROP TABLE cliente CASCADE CONSTRAINTS;
DROP TABLE oficinas CASCADE CONSTRAINTS;
DROP TABLE cuentas CASCADE CONSTRAINTS;
DROP TABLE titulares CASCADE CONSTRAINTS;

CREATE TABLE cliente
(
    codigo           NUMBER(3, 0) NOT NULL,
    nombre           VARCHAR2(60) NOT NULL,
    apellido         VARCHAR2(60) NOT NULL,
    fecha_nacimiento DATE         NOT NULL,
    email            VARCHAR2(60),

    PRIMARY KEY (codigo)
);

CREATE TABLE oficinas
(
    codigo NUMBER(3, 0) NOT NULL,
    nombre VARCHAR2(60) NOT NULL,
    barrio VARCHAR2(60) NOT NULL,

    PRIMARY KEY (codigo)
);

CREATE TABLE cuentas
(
    numero         NUMBER(3, 0)  NOT NULL,
    tipo           CHAR(1)       NOT NULL
        CONSTRAINT CHK_CUENTA_TIPO CHECK (tipo IN ('A', 'C')),
    saldo          NUMBER(10, 2) NOT NULL,
    codigo_oficina NUMBER(3, 0), -- Aqui tambien iba not null pero lo dejamos así para poder dejar una cuenta sin oficina como muestra el ejemplo del documento

    PRIMARY KEY (numero),
    FOREIGN KEY (codigo_oficina) REFERENCES oficinas (codigo)
);

CREATE TABLE titulares
(
    codigo_cliente NUMBER(3, 0),
    numero_cuenta  NUMBER(3, 0),

    PRIMARY KEY (codigo_cliente, numero_cuenta),
    FOREIGN KEY (codigo_cliente) REFERENCES cliente (codigo) ON DELETE CASCADE,
    FOREIGN KEY (numero_cuenta) REFERENCES cuentas (numero) ON DELETE CASCADE
);

-- Insertamos los datos --

INSERT INTO cliente
VALUES (101, 'Ana', 'Lopez', DATE '1998-05-12', 'juan@mail.com');
INSERT INTO cliente
VALUES (102, 'Juan', 'Perez', DATE '1999-03-21', 'maria@mail.com');
INSERT INTO cliente
VALUES (103, 'Marta', 'Ramirez', DATE '1995-04-18', 'marta@mail.com');
INSERT INTO cliente
VALUES (104, 'Diego', 'Gomez', DATE '2000-01-30', 'diego@mail.com');

INSERT INTO oficinas
VALUES (01, 'Centro', 'Chapinero');
INSERT INTO oficinas
VALUES (02, 'Norte', 'Usaquen');


INSERT INTO cuentas
VALUES (201, 'A', 1200.50, 01);
INSERT INTO cuentas
VALUES (202, 'C', 3500.00, 01);
INSERT INTO cuentas
VALUES (203, 'C', 500.00, NULL);

INSERT INTO titulares
VALUES (101, 201);
INSERT INTO titulares
VALUES (102, 202);

COMMIT;

-- Requerimiento 4
UPDATE cuentas
SET saldo = saldo + CASE
                        WHEN tipo = 'A' AND saldo < 1000 then 50
                        WHEN tipo = 'A' AND saldo >= 1000 then 100
                        WHEN tipo = 'C' AND saldo < 500 then -25
                        ELSE 0
    END;

COMMIT;


--- Consultas ---

--- 1 ---
SELECT TO_CHAR(c.codigo)             as Codigo_Cliente,
       c.nombre || ' ' || c.apellido as nombre_completo,
       TO_CHAR(cu.numero)            as numero,
       cu.tipo,
       TO_CHAR(cu.saldo)             as saldo
FROM cliente c
         LEFT JOIN titulares ti ON c.codigo = ti.codigo_cliente
         LEFT JOIN cuentas cu ON ti.numero_cuenta = cu.numero

UNION ALL

SELECT 'TOTAL', COUNT(DISTINCT c.codigo) || ' clientes', '-', '-', TO_CHAR(SUM(cu.saldo), '999999.99')
FROM cliente c
         LEFT JOIN titulares ti ON c.codigo = ti.codigo_cliente
         LEFT JOIN cuentas cu ON ti.numero_cuenta = cu.numero;

--- 2 ---

SELECT TO_CHAR(C.numero),
       C.tipo,
       C.saldo,
       CLI.nombre || ' ' || CLI.apellido Nombre_Completo
FROM CUENTAS C

         LEFT JOIN TITULARES T ON T.numero_cuenta = C.numero
         LEFT JOIN CLIENTE CLI ON CLI.codigo = T.CODIGO_CLIENTE

UNION ALL

SELECT 'TOTAL',
       '-',
       SUM(C.SALDO),
       TO_CHAR(COUNT(*)) || ' CUENTAS'
FROM cuentas C;

--- 3 ---
SELECT TO_CHAR(c.codigo)             as Codigo_Cliente,
       c.nombre || ' ' || c.apellido as nombre_completo,
       TO_CHAR(cu.numero)            as numero,
       cu.tipo,
       TO_CHAR(cu.saldo)             as saldo
FROM cliente c
         LEFT JOIN titulares ti ON c.codigo = ti.codigo_cliente
         LEFT JOIN cuentas cu ON ti.numero_cuenta = cu.numero
UNION ALL

SELECT '-', '-', TO_CHAR(cu.numero), cu.tipo, TO_CHAR(cu.saldo)
FROM cuentas cu
WHERE cu.numero NOT IN (SELECT numero_cuenta FROM titulares)

UNION ALL

SELECT 'TOTAL',
       (SELECT COUNT(*) FROM cliente) || ' CLIENTES',
       (SELECT COUNT(*) FROM cuentas) || ' CUENTAS',
       '-',
       TO_CHAR((SELECT SUM(saldo) FROM cuentas), '999999.99')
FROM dual;
--- 4 ---
SELECT TO_CHAR(O.codigo) Codigo_oficina,
       O.nombre,
       O.barrio,
       TO_CHAR(C.numero) Numero_cuenta,
       C.saldo
FROM OFICINAS O
         LEFT JOIN CUENTAS C ON C.codigo_oficina = O.codigo
UNION ALL

SELECT 'TOTAL',
       TO_CHAR(COUNT(DISTINCT O.nombre)) || ' OFICINAS',
       '-',
       '-',
       SUM(DISTINCT C.SALDO)
FROM OFICINAS O
         LEFT JOIN CUENTAS C ON C.codigo_oficina = O.codigo;

--- 5 ---
SELECT TO_CHAR(c.codigo), c.nombre || ' ' || c.apellido as nombre_completo, TO_CHAR(cu.numero), cu.tipo
FROM cliente c
         LEFT JOIN titulares ti ON ti.codigo_cliente = c.codigo
         LEFT JOIN cuentas cu ON ti.numero_cuenta = cu.numero

UNION ALL

SELECT '-', '-', TO_CHAR(cu.numero), cu.tipo
FROM cuentas cu
WHERE cu.numero NOT IN (SELECT numero_cuenta FROM titulares)

UNION ALL

SELECT 'TOTAL',
       (SELECT COUNT(*) FROM cliente) || ' CLIENTES',
       (SELECT COUNT(*) FROM cuentas) || ' CUENTAS',
       '-'
FROM dual;

--- 6 ---
DROP VIEW CuentasXCliente;
CREATE VIEW CuentasXCliente AS
SELECT TO_CHAR(CLI.codigo)               Codigo,
       CLI.nombre || ' ' || CLI.apellido Nombre_Completo,
       TO_CHAR(COUNT(T.numero_cuenta))   cantidad_cuentas
FROM Cliente CLI
         LEFT JOIN TITULARES T ON T.codigo_cliente = CLI.codigo
GROUP BY CLI.codigo, CLI.nombre, CLI.apellido

UNION ALL

SELECT 'TOTAL',
       COUNT(CLI.codigo) || ' CLIENTES',
       COUNT(T.numero_cuenta) || ' CUENTAS'
FROM Cliente CLI
         LEFT JOIN TITULARES T ON T.codigo_cliente = CLI.codigo;

SELECT *
FROM CuentasXCliente;
