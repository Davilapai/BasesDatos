DROP TABLE cliente CASCADE CONSTRAINTS;
DROP TABLE oficinas CASCADE CONSTRAINTS;
DROP TABLE cuentas CASCADE CONSTRAINTS;
DROP TABLE titulares CASCADE CONSTRAINTS;

CREATE TABLE cliente(
    codigo NUMBER(3,0) NOT NULL,
    nombre VARCHAR2(60) NOT NULL,
    apellido VARCHAR2(60) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    email VARCHAR2(60),

    PRIMARY KEY(codigo)
);

CREATE TABLE oficinas(
    codigo NUMBER(3,0) NOT NULL,
    nombre VARCHAR2(60) NOT NULL,
    barrio VARCHAR2(60) NOT NULL,

    PRIMARY KEY (codigo)
);

CREATE TABLE cuentas(
    numero NUMBER(3,0) NOT NULL,
    tipo CHAR(1) NOT NULL CHECK (tipo IN ('A','C')),
    saldo NUMBER(10,2) NOT NULL,
    codigo_oficina NUMBER(3,0), -- Aqui tambien iba not null pero lo dejamos así para poder dejar una cuenta sin oficina como muestra el ejemplo del documento

    PRIMARY KEY (numero),
    FOREIGN KEY(codigo_oficina) REFERENCES oficinas(codigo)
);

CREATE TABLE titulares(
    codigo_cliente NUMBER(3,0),
    numero_cuenta NUMBER(3,0),

    PRIMARY KEY (codigo_cliente, numero_cuenta),
    FOREIGN KEY (codigo_cliente) REFERENCES cliente(codigo),
    FOREIGN KEY (numero_cuenta) REFERENCES cuentas(numero)
);

--- Consultas ---
--- 2 ---
SELECT TO_CHAR(C.numero), -- Tenemos q volver el numero char para poder reemplazarlo abajo con TOTAL
        C.tipo, 
        C.saldo, 
        CLI.nombre || ' ' || CLI.apellido Nombre_Completo -- El OR es para concatenar texto
FROM CUENTAS C

LEFT JOIN TITULARES T ON T.numero_cuenta = C.numero -- Une de forma más bonita q un where con la condicion esa
LEFT JOIN CLIENTE CLI ON CLI.codigo = T.CODIGO_CLIENTE

UNION ALL -- Esta es una tonterita para poner abajo el total

SELECT 'TOTAL', -- En lugar de un numero ponemos total pq ya lo reemplazamos con to_char más arriba
       '-', --Este como si es char no importa
       SUM(C.SALDO), -- El saldo sigue siendo numerico entonces lo dejamos igual
       TO_CHAR(COUNT(*))|| ' CUENTAS' -- Lo volvemos char para poder concatenarle CUENTAS
FROM cuentas C;

--- 4 ---
SELECT TO_CHAR(O.codigo) Codigo_oficina, 
        O.nombre, 
        O.barrio, 
        TO_CHAR(C.numero) Numero_cuenta,
        C.saldo
FROM OFICINAS O
-- Bro aqui el left join permite guardar todo lo de oficinas y lo q no tenga de cuentas lo rellena con null, ya te paso los datos q cumplen todo eso
LEFT JOIN CUENTAS C ON C.codigo_oficina = O.codigo 
UNION ALL

SELECT 'TOTAL', -- Reemplazamos con total
        TO_CHAR(COUNT(DISTINCT O.nombre)) || ' OFICINAS', -- Misma operacion q arriba pero metemos el distinct para no contar repetidas, TO CHAR pq count nos da numerito
        '-',
        '-',
        SUM(DISTINCT C.SALDO)
FROM OFICINAS O
LEFT JOIN CUENTAS C ON C.codigo_oficina = O.codigo;

--- 6 ---
DROP VIEW CuentasXCliente; -- Depronto le da error al profe entonces borramos
CREATE VIEW CuentasXCliente AS -- Creamos la vista con el nombresito q dejó ahi
SELECT TO_CHAR(CLI.codigo) Codigo, -- Para abajo poder reemplazarlo con total
        CLI.nombre || ' ' || CLI.apellido Nombre_Completo,
        TO_CHAR(COUNT (T.numero_cuenta)) cantidad_cuentas -- Contamos la cantidad de cuentas de cada cliente, to char para ponerle palabrita abajo
FROM Cliente CLI
LEFT JOIN TITULARES T ON T.codigo_cliente = CLI.codigo -- Le hacemos un left yoin pa poder mostrar tambien los q no tienen cuentas
GROUP BY CLI.codigo, CLI.nombre, CLI.apellido -- Los agrupamos segun los terminos q vamos a mostrar

UNION ALL -- Union pa mostrar el total abajo

SELECT 'TOTAL',
       COUNT(CLI.codigo) || ' CLIENTES', -- Contamos los clientes (un cliente puede tener 2 cuentas entonces distinct pa no repetir)
       COUNT(T.numero_cuenta) || ' CUENTAS' -- Contamos las cuentas 
FROM Cliente CLI
LEFT JOIN TITULARES T ON T.codigo_cliente = CLI.codigo; 

SELECT *
FROM CuentasXCliente;



