--- Para poder consultar la tabla de alguien más
SELECT *
FROM is331500.DEPARTMENT;

GRANT SELECT ON DEPARTMENT TO is331502;
REVOKE SELECT ON DEPARTMENT FROM PUBLIC;

INSERT INTO is331501.CLIENTES VALUES(67, 'David', 'Davila', TO_DATE('2006-10-12', 'YYYY-MM-DD'), 'tilin@gmail.com');

SELECT *
FROM is331501.CLIENTES;                            
COMMIT;

DELETE FROM is331501.CLIENTES C
WHERE C.CODIGO = 67;

SELECT *
FROM is331513.JAVERIANA;













































