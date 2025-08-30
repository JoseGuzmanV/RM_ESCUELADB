-- =============================================
-- MODELO LÓGICO RELACIONAL (MySQL Workbench)
-- =============================================
USE escuelabd;

-- Eliminamos tablas si existen (para reinicios de modelo)
DROP TABLE IF EXISTS ALUMNO_PROFESOR;
DROP TABLE IF EXISTS PROFESOR_MATERIA;
DROP TABLE IF EXISTS ALUMNO_MATERIA;
DROP TABLE IF EXISTS ALUMNO;
DROP TABLE IF EXISTS PROFESOR;
DROP TABLE IF EXISTS MATERIA;
DROP TABLE IF EXISTS CARRERA;

-- ================================
-- ENTIDADES PRINCIPALES
-- ================================

CREATE TABLE CARRERA (
  cod_escuela   VARCHAR(10) PRIMARY KEY,
  nombre        VARCHAR(100) NOT NULL,
  director      VARCHAR(100)
);

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
    ON UPDATE CASCADE
);

CREATE TABLE PROFESOR (
  cod_profesor  VARCHAR(12) PRIMARY KEY,
  dni           VARCHAR(15)  NOT NULL UNIQUE,
  nombres       VARCHAR(120) NOT NULL,
  fecnac        DATE,
  direccion     VARCHAR(180),
  telefono      VARCHAR(30)
);

CREATE TABLE MATERIA (
  cod_materia   VARCHAR(10) PRIMARY KEY,
  nombre        VARCHAR(120) NOT NULL,
  creditos      INT NOT NULL,
  horas         INT NOT NULL
);

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
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_am_materia 
    FOREIGN KEY (cod_materia) REFERENCES MATERIA(cod_materia)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE PROFESOR_MATERIA ( -- DICTA
  cod_profesor VARCHAR(12) NOT NULL,
  cod_materia  VARCHAR(10) NOT NULL,
  periodo      VARCHAR(20),
  PRIMARY KEY (cod_profesor, cod_materia),
  CONSTRAINT fk_pm_profesor 
    FOREIGN KEY (cod_profesor) REFERENCES PROFESOR(cod_profesor)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_pm_materia  
    FOREIGN KEY (cod_materia) REFERENCES MATERIA(cod_materia)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE ALUMNO_PROFESOR ( -- TIENE
  cod_alumno   VARCHAR(12) NOT NULL,
  cod_profesor VARCHAR(12) NOT NULL,
  PRIMARY KEY (cod_alumno, cod_profesor),
  CONSTRAINT fk_ap_alumno   
    FOREIGN KEY (cod_alumno) REFERENCES ALUMNO(cod_alumno)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_ap_profesor 
    FOREIGN KEY (cod_profesor) REFERENCES PROFESOR(cod_profesor)
    ON DELETE CASCADE ON UPDATE CASCADE
);
