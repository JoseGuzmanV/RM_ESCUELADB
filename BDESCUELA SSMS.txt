-- =============================================
-- MODELO LÓGICO RELACIONAL (SQL Server - SSMS 19)
-- =============================================
USE escuelabd;
GO

-- Eliminamos tablas si existen
IF OBJECT_ID('dbo.ALUMNO_PROFESOR', 'U') IS NOT NULL DROP TABLE dbo.ALUMNO_PROFESOR;
IF OBJECT_ID('dbo.PROFESOR_MATERIA', 'U') IS NOT NULL DROP TABLE dbo.PROFESOR_MATERIA;
IF OBJECT_ID('dbo.ALUMNO_MATERIA', 'U') IS NOT NULL DROP TABLE dbo.ALUMNO_MATERIA;
IF OBJECT_ID('dbo.ALUMNO', 'U') IS NOT NULL DROP TABLE dbo.ALUMNO;
IF OBJECT_ID('dbo.PROFESOR', 'U') IS NOT NULL DROP TABLE dbo.PROFESOR;
IF OBJECT_ID('dbo.MATERIA', 'U') IS NOT NULL DROP TABLE dbo.MATERIA;
IF OBJECT_ID('dbo.CARRERA', 'U') IS NOT NULL DROP TABLE dbo.CARRERA;
GO

-- ================================
-- ENTIDADES PRINCIPALES
-- ================================

CREATE TABLE CARRERA (
  cod_escuela   VARCHAR(10) PRIMARY KEY,
  nombre        VARCHAR(100) NOT NULL,
  director      VARCHAR(100)
);
GO

CREATE TABLE ALUMNO (
  cod_alumno    VARCHAR(12) PRIMARY KEY,
  dni           VARCHAR(15)  NOT NULL UNIQUE,
  nombres       VARCHAR(120) NOT NULL,
  fecnac        DATE,
  email         VARCHAR(120),
  cod_escuela   VARCHAR(10)  NOT NULL,
  CONSTRAINT fk_alumno_carrera
    FOREIGN KEY (cod_escuela) 
    REFERENCES CARRERA(cod_escuela)
    ON DELETE CASCADE
);
GO

CREATE TABLE PROFESOR (
  cod_profesor  VARCHAR(12) PRIMARY KEY,
  dni           VARCHAR(15)  NOT NULL UNIQUE,
  nombres       VARCHAR(120) NOT NULL,
  fecnac        DATE,
  direccion     VARCHAR(180),
  telefono      VARCHAR(30)
);
GO

CREATE TABLE MATERIA (
  cod_materia   VARCHAR(10) PRIMARY KEY,
  nombre        VARCHAR(120) NOT NULL,
  creditos      INT NOT NULL,
  horas         INT NOT NULL
);
GO

-- ================================
-- RELACIONES N:M
-- ================================

CREATE TABLE ALUMNO_MATERIA ( -- ESTUDIA
  cod_alumno   VARCHAR(12) NOT NULL,
  cod_materia  VARCHAR(10) NOT NULL,
  fecha_matricula DATE,
  PRIMARY KEY (cod_alumno, cod_materia),
  CONSTRAINT fk_am_alumno  
    FOREIGN KEY (cod_alumno) REFERENCES ALUMNO(cod_alumno)
    ON DELETE CASCADE,
  CONSTRAINT fk_am_materia 
    FOREIGN KEY (cod_materia) REFERENCES MATERIA(cod_materia)
    ON DELETE CASCADE
);
GO

CREATE TABLE PROFESOR_MATERIA ( -- DICTA
  cod_profesor VARCHAR(12) NOT NULL,
  cod_materia  VARCHAR(10) NOT NULL,
  periodo      VARCHAR(20),
  PRIMARY KEY (cod_profesor, cod_materia),
  CONSTRAINT fk_pm_profesor 
    FOREIGN KEY (cod_profesor) REFERENCES PROFESOR(cod_profesor)
    ON DELETE CASCADE,
  CONSTRAINT fk_pm_materia  
    FOREIGN KEY (cod_materia) REFERENCES MATERIA(cod_materia)
    ON DELETE CASCADE
);
GO

CREATE TABLE ALUMNO_PROFESOR ( -- TIENE
  cod_alumno   VARCHAR(12) NOT NULL,
  cod_profesor VARCHAR(12) NOT NULL,
  PRIMARY KEY (cod_alumno, cod_profesor),
  CONSTRAINT fk_ap_alumno   
    FOREIGN KEY (cod_alumno) REFERENCES ALUMNO(cod_alumno)
    ON DELETE CASCADE,
  CONSTRAINT fk_ap_profesor 
    FOREIGN KEY (cod_profesor) REFERENCES PROFESOR(cod_profesor)
    ON DELETE CASCADE
);
GO
