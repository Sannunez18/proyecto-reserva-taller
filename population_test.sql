USE proyecto_reservas;

SET GLOBAL local_infile = true;

LOAD DATA  LOCAL INFILE '/sql_project/data_csv/clientes.csv'
INTO TABLE CLIENTE
FIELDS TERMINATED BY ','  ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(IDCLIENTE,NOMBRE,TELEFONO,CORREO,DNI);

-- DUENO 10 records
-- INGRESAR DATOS POR MEDIO DE COMANDO INSERT INTO
INSERT INTO DUENO (NOMBRE, CORREO, TELEFONO) VALUES
('Juan Pérez', 'juan@example.com', '1234567890'),
('María Rodríguez', 'maria@example.com', '9876543210'),
('Carlos García', 'carlos@example.com', '5551234567'),
('Ana Martínez', 'ana@example.com', '9998887776'),
('Pedro López', 'pedro@example.com', '1112223334'),
('Laura Sánchez', 'laura@example.com', '4445556668'),
('Javier Hernández', 'javier@example.com', '7778889990'),
('Carmen González', 'carmen@example.com', '2223334441'),
('Alejandro Ruiz', 'alejandro@example.com', '6667778882'),
('Sofía Díaz', 'sofia@example.com', '3334445553');


-- TIPO RESERVA 4 records
INSERT INTO TIPORESERVA (TIPO) VALUES
('Reserva Normal'),
('Reserva VIP'),
('Reserva de Grupo'),
('Reserva de Evento Especial');


-- RESTAURANTE 10 records
-- COSA LOCA Y RARA QUE ME COPO jeje
-- Insertar 10 registros con IDDUENO aleatorio del 1 al 10

INSERT INTO RESTAURANTE (NOMBRE, DIRECCION, TELEFONO, IDDUENO)
SELECT
    CASE 
        WHEN FLOOR(1 + (RAND() * 100))  > 50 THEN "Bandejita Paisa"
        WHEN FLOOR(1 + (RAND() * 100))  < 50 THEN "CevicheLand"
        WHEN FLOOR(1 + (RAND() * 100))  BETWEEN 20 AND 50 THEN "SaySoFun"
        WHEN FLOOR(1 + (RAND() * 100))  BETWEEN 10 AND 20 THEN "DojaCatParty"
    ELSE
        "Paraiso Riojano"
    END
     ,
    CONCAT('Av. San Martin ', FLOOR(1 + (RAND() * 1000)) ),
    CONCAT(FLOOR(1 + (RAND() * 10)) ,'1345678', t.n),
    FLOOR(1 + (RAND() * 10)) AS IDDUENO
FROM (
    SELECT 1 AS n 
    UNION ALL SELECT 2 
    UNION ALL SELECT 3 
    UNION ALL SELECT 4 
    UNION ALL SELECT 5
    UNION ALL SELECT 6 
    UNION ALL SELECT 7 
    UNION ALL SELECT 8 
    UNION ALL SELECT 9 
    UNION ALL SELECT 10
) t;



LOAD DATA  LOCAL INFILE '/sql_project/data_csv/empleados.csv'
INTO TABLE EMPLEADO
FIELDS TERMINATED BY ','  ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
-- COLUMNAS QUE ME INTERESA INGESTAR
(NOMBRE,TELEFONO,CORREO,IDRESTAURANTE);


-- MESA 100 records

LOAD DATA  LOCAL INFILE '/sql_project/data_csv/empleados.csv'
INTO TABLE EMPLEADO
FIELDS TERMINATED BY ','  ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
-- COLUMNAS QUE ME INTERESA INGESTAR
(NOMBRE,TELEFONO,CORREO,IDRESTAURANTE);



-- MESAS

LOAD DATA  LOCAL INFILE '/sql_project/data_csv/mesas.csv'
INTO TABLE MESA
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
-- COLUMNAS QUE ME INTERESA INGESTAR
(IDRESTAURANTE,CAPACIDAD,DISPONIBLE);

-- RESERVA

LOAD DATA  LOCAL INFILE '/sql_project/data_csv/reservas.csv'
INTO TABLE RESERVA
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
-- COLUMNAS QUE ME INTERESA INGESTAR
(IDCLIENTE, IDMESA, IDEMPLEADO, IDTIPORESERVA, FECHA, @CANCELACION, HORARIO_RESERVA)
SET CANCELACION = NULLIF(@CANCELACION, '');
