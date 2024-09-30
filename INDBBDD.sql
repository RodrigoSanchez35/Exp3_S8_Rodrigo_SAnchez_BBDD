-- SCRIPT CREACION DE TABLAS

-- Tabla: TipoEscuela
CREATE TABLE TipoEscuela (
    ID_TipoEscuela NUMBER(10) PRIMARY KEY,
    NombreTipo     VARCHAR2(50) UNIQUE NOT NULL
);

-- Tabla: EscuelaDeportiva
CREATE TABLE EscuelaDeportiva (
    ID_Escuela          NUMBER(10) PRIMARY KEY,
    ID_TipoEscuela      NUMBER(10) NOT NULL,
    NombreEscuela       VARCHAR2(100) NOT NULL,
    InformacionContacto VARCHAR2(200),
    Direccion           VARCHAR2(200),
    Ciudad              VARCHAR2(100),
    Region              VARCHAR2(100),
    Pais                VARCHAR2(100),
    CONSTRAINT FK_Escuela_TipoEscuela FOREIGN KEY (ID_TipoEscuela)
        REFERENCES TipoEscuela(ID_TipoEscuela)
);

-- Tabla: Personal
CREATE TABLE Personal (
    ID_Personal          NUMBER(10) PRIMARY KEY,
    Nombre               VARCHAR2(50) NOT NULL,
    Apellido             VARCHAR2(50) NOT NULL,
    Profesion            VARCHAR2(100),
    Nacionalidad         VARCHAR2(50),
    FechaNacimiento      DATE,
    OtrosDatosPersonales VARCHAR2(200)
);

-- Tabla: ContratoPersonal
CREATE TABLE ContratoPersonal (
    ID_Contrato  NUMBER(10) PRIMARY KEY,
    ID_Escuela   NUMBER(10) NOT NULL,
    ID_Personal  NUMBER(10) NOT NULL,
    FechaInicio  DATE NOT NULL,
    FechaFin     DATE,
    Rol          VARCHAR2(50),
    CONSTRAINT FK_Contrato_Escuela FOREIGN KEY (ID_Escuela)
        REFERENCES EscuelaDeportiva(ID_Escuela),
    CONSTRAINT FK_Contrato_Personal FOREIGN KEY (ID_Personal)
        REFERENCES Personal(ID_Personal)
);

-- Tabla: TipoCosto
CREATE TABLE TipoCosto (
    ID_TipoCosto NUMBER(10) PRIMARY KEY,
    NombreTipo   VARCHAR2(50) UNIQUE NOT NULL
);

-- Tabla: CostosOperacionales
CREATE TABLE CostosOperacionales (
    ID_Costo     NUMBER(10) PRIMARY KEY,
    ID_Escuela   NUMBER(10) NOT NULL,
    ID_TipoCosto NUMBER(10) NOT NULL,
    Monto        NUMBER(12,2) NOT NULL,
    FechaCosto   DATE NOT NULL,
    Descripcion  VARCHAR2(200),
    CONSTRAINT FK_Costo_Escuela FOREIGN KEY (ID_Escuela)
        REFERENCES EscuelaDeportiva(ID_Escuela),
    CONSTRAINT FK_Costo_TipoCosto FOREIGN KEY (ID_TipoCosto)
        REFERENCES TipoCosto(ID_TipoCosto)
);

-- SCRIPT AUTOINCREMENT

-- Secuencia y Trigger para EscuelaDeportiva
CREATE SEQUENCE Seq_ID_Escuela START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER TRG_ID_Escuela_BI
BEFORE INSERT ON EscuelaDeportiva
FOR EACH ROW
WHEN (NEW.ID_Escuela IS NULL)
BEGIN
    SELECT Seq_ID_Escuela.NEXTVAL INTO :NEW.ID_Escuela FROM dual;
END;
/

-- Secuencia y Trigger para Personal
CREATE SEQUENCE Seq_ID_Personal START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER TRG_ID_Personal_BI
BEFORE INSERT ON Personal
FOR EACH ROW
WHEN (NEW.ID_Personal IS NULL)
BEGIN
    SELECT Seq_ID_Personal.NEXTVAL INTO :NEW.ID_Personal FROM dual;
END;
/


-- SCRIPT POBLADO DE TABLAS

-- Insertar registros en TipoEscuela
INSERT INTO TipoEscuela (ID_TipoEscuela, NombreTipo) VALUES (1, 'Fútbol');
INSERT INTO TipoEscuela (ID_TipoEscuela, NombreTipo) VALUES (2, 'Baloncesto');
INSERT INTO TipoEscuela (ID_TipoEscuela, NombreTipo) VALUES (3, 'Vóleibol');
INSERT INTO TipoEscuela (ID_TipoEscuela, NombreTipo) VALUES (4, 'Natación');

-- Insertar registros en EscuelaDeportiva (ID_Escuela autoincrementable)
INSERT INTO EscuelaDeportiva (ID_TipoEscuela, NombreEscuela, InformacionContacto, Direccion, Ciudad, Region, Pais)
VALUES (1, 'Escuela Fútbol Santiago', 'contacto@futbolsantiago.cl', 'Av. Las Flores 123', 'Santiago', 'Región Metropolitana', 'Chile');

INSERT INTO EscuelaDeportiva (ID_TipoEscuela, NombreEscuela, InformacionContacto, Direccion, Ciudad, Region, Pais)
VALUES (2, 'Escuela Baloncesto Valparaíso', 'contacto@baloncestovalpo.cl', 'Calle Los Álamos 456', 'Valparaíso', 'Región de Valparaíso', 'Chile');

INSERT INTO EscuelaDeportiva (ID_TipoEscuela, NombreEscuela, InformacionContacto, Direccion, Ciudad, Region, Pais)
VALUES (3, 'Escuela Vóleibol Concepción', 'contacto@voleibolconce.cl', 'Av. Central 789', 'Concepción', 'Región del Biobío', 'Chile');

INSERT INTO EscuelaDeportiva (ID_TipoEscuela, NombreEscuela, InformacionContacto, Direccion, Ciudad, Region, Pais)
VALUES (4, 'Escuela Natación Antofagasta', 'contacto@natacionantofa.cl', 'Pasaje El Mar 1011', 'Antofagasta', 'Región de Antofagasta', 'Chile');

-- Insertar registros en Personal (ID_Personal autoincrementable)
INSERT INTO Personal (Nombre, Apellido, Profesion, Nacionalidad, FechaNacimiento, OtrosDatosPersonales)
VALUES ('Juan', 'Pérez', 'Entrenador', 'Chilena', TO_DATE('1980-05-15', 'YYYY-MM-DD'), 'Experto en fútbol juvenil');

INSERT INTO Personal (Nombre, Apellido, Profesion, Nacionalidad, FechaNacimiento, OtrosDatosPersonales)
VALUES ('María', 'González', 'Preparadora Física', 'Chilena', TO_DATE('1985-08-22', 'YYYY-MM-DD'), 'Especialista en alto rendimiento');

INSERT INTO Personal (Nombre, Apellido, Profesion, Nacionalidad, FechaNacimiento, OtrosDatosPersonales)
VALUES ('Carlos', 'Ramírez', 'Fisioterapeuta', 'Argentino', TO_DATE('1978-11-30', 'YYYY-MM-DD'), 'Experiencia en rehabilitación deportiva');

INSERT INTO Personal (Nombre, Apellido, Profesion, Nacionalidad, FechaNacimiento, OtrosDatosPersonales)
VALUES ('Ana', 'López', 'Nutricionista', 'Chilena', TO_DATE('1990-02-10', 'YYYY-MM-DD'), 'Especialista en nutrición deportiva');

-- Insertar registros en ContratoPersonal
INSERT INTO ContratoPersonal (ID_Contrato, ID_Escuela, ID_Personal, FechaInicio, FechaFin, Rol)
VALUES (1, 1, 1, TO_DATE('2022-01-01', 'YYYY-MM-DD'), NULL, 'Entrenador Principal');

INSERT INTO ContratoPersonal (ID_Contrato, ID_Escuela, ID_Personal, FechaInicio, FechaFin, Rol)
VALUES (2, 2, 2, TO_DATE('2022-02-01', 'YYYY-MM-DD'), NULL, 'Preparadora Física');

INSERT INTO ContratoPersonal (ID_Contrato, ID_Escuela, ID_Personal, FechaInicio, FechaFin, Rol)
VALUES (3, 3, 3, TO_DATE('2022-03-01', 'YYYY-MM-DD'), NULL, 'Fisioterapeuta');

INSERT INTO ContratoPersonal (ID_Contrato, ID_Escuela, ID_Personal, FechaInicio, FechaFin, Rol)
VALUES (4, 4, 4, TO_DATE('2022-04-01', 'YYYY-MM-DD'), NULL, 'Nutricionista');

-- Insertar registros en TipoCosto
INSERT INTO TipoCosto (ID_TipoCosto, NombreTipo) VALUES (1, 'Pago a Entrenadores');
INSERT INTO TipoCosto (ID_TipoCosto, NombreTipo) VALUES (2, 'Compra de Equipos');
INSERT INTO TipoCosto (ID_TipoCosto, NombreTipo) VALUES (3, 'Insumos Deportivos');
INSERT INTO TipoCosto (ID_TipoCosto, NombreTipo) VALUES (4, 'Mantenimiento');

-- Insertar registros en CostosOperacionales
INSERT INTO CostosOperacionales (ID_Costo, ID_Escuela, ID_TipoCosto, Monto, FechaCosto, Descripcion)
VALUES (1, 1, 1, 1500000.00, TO_DATE('2022-01-15', 'YYYY-MM-DD'), 'Salario mensual entrenador');

INSERT INTO CostosOperacionales (ID_Costo, ID_Escuela, ID_TipoCosto, Monto, FechaCosto, Descripcion)
VALUES (2, 1, 2, 500000.00, TO_DATE('2022-01-20', 'YYYY-MM-DD'), 'Compra de balones y uniformes');

INSERT INTO CostosOperacionales (ID_Costo, ID_Escuela, ID_TipoCosto, Monto, FechaCosto, Descripcion)
VALUES (3, 2, 1, 1200000.00, TO_DATE('2022-02-15', 'YYYY-MM-DD'), 'Salario mensual preparadora física');

INSERT INTO CostosOperacionales (ID_Costo, ID_Escuela, ID_TipoCosto, Monto, FechaCosto, Descripcion)
VALUES (4, 3, 3, 300000.00, TO_DATE('2022-03-10', 'YYYY-MM-DD'), 'Compra de insumos médicos');



-- SCRIPT CONSULTAS SIMPLES PARA DEMOSTRAR EL POBLADO


-- Consulta 1: Mostrar todas las escuelas deportivas
SELECT * FROM EscuelaDeportiva;

-- Consulta 2: Mostrar el personal contratado por la 'Escuela Fútbol Santiago'
SELECT p.Nombre, p.Apellido, cp.Rol
FROM Personal p
JOIN ContratoPersonal cp ON p.ID_Personal = cp.ID_Personal
JOIN EscuelaDeportiva ed ON cp.ID_Escuela = ed.ID_Escuela
WHERE ed.NombreEscuela = 'Escuela Fútbol Santiago';

-- Consulta 3: Mostrar los costos operacionales de la 'Escuela Fútbol Santiago'
SELECT co.Monto, co.FechaCosto, tc.NombreTipo AS TipoCosto, co.Descripcion
FROM CostosOperacionales co
JOIN TipoCosto tc ON co.ID_TipoCosto = tc.ID_TipoCosto
JOIN EscuelaDeportiva ed ON co.ID_Escuela = ed.ID_Escuela
WHERE ed.NombreEscuela = 'Escuela Fútbol Santiago';

-- Consulta 4: Mostrar el total de costos por escuela
SELECT ed.NombreEscuela, SUM(co.Monto) AS TotalCosto
FROM CostosOperacionales co
JOIN EscuelaDeportiva ed ON co.ID_Escuela = ed.ID_Escuela
GROUP BY ed.NombreEscuela;

-- Consulta 5: Filtrar personal por nacionalidad 'Chilena'
SELECT * FROM Personal WHERE Nacionalidad = 'Chilena';

-- Consulta 6: Mostrar las escuelas deportivas por tipo de escuela
SELECT te.NombreTipo AS TipoEscuela, ed.NombreEscuela
FROM EscuelaDeportiva ed
JOIN TipoEscuela te ON ed.ID_TipoEscuela = te.ID_TipoEscuela
ORDER BY te.NombreTipo;

-- Consulta 7: Contar el número de personal por escuela
SELECT ed.NombreEscuela, COUNT(cp.ID_Personal) AS NumeroPersonal
FROM EscuelaDeportiva ed
JOIN ContratoPersonal cp ON ed.ID_Escuela = cp.ID_Escuela
GROUP BY ed.NombreEscuela;