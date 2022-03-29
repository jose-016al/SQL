DROP DATABASE IF EXISTS grado;
CREATE DATABASE grado CHARSET utf8mb4;
USE grado;

CREATE TABLE profesor (
	NIF VARCHAR(9) NOT NULL PRIMARY KEY,
	nombre VARCHAR(10) NOT NULL,
	apellidos VARCHAR(100) NOT NULL,
	telefono VARCHAR(9) NOT NULL,
	sueldo DOUBLE CHECK(sueldo > 1500 AND sueldo < 2000),
	especialidad VARCHAR(100) NOT NULL,
	fecha_alta DATE NOT NULL
);

CREATE TABLE modulo (
	codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(10) NOT NULL,
	descripcion VARCHAR(100) NOT NULL,
	horas INT CHECK(horas < 300),
	NIF_profesor VARCHAR(9) NOT NULL,
	FOREIGN KEY (NIF_profesor) REFERENCES profesor(NIF)
);

CREATE TABLE alumno (
	num_expediente INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	NIF INT UNSIGNED UNIQUE NOT NULL,
	nombre VARCHAR(10) NOT NULL,
	apellidos VARCHAR(100) NOT NULL,
	domicilio VARCHAR(100) NOT NULL,
	poblacion VARCHAR(100) NOT NULL,
	cod_postal INT NOT NULL,
	provincia VARCHAR(100) NOT NULL,
	telefono VARCHAR(9) NOT NULL,
	sexo CHAR(1) NOT NULL,
	fecha_nacimiento DATE NOT NULL
);

CREATE TABLE matricula (
	curso_escolar VARCHAR(9) NOT NULL,
	expediente_alumno INT UNSIGNED NOT NULL,
	codigo_modulo INT UNSIGNED NOT NULL,
	nota DOUBLE NOT NULL,
	PRIMARY KEY (curso_escolar, expediente_alumno, codigo_modulo),
	FOREIGN KEY (expediente_alumno) REFERENCES alumno(num_expediente),
	FOREIGN KEY (codigo_modulo) REFERENCES modulo(codigo)
);

ALTER TABLE modulo DROP COLUMN descripcion;
ALTER TABLE profesor ADD COLUMN cargo VARCHAR(20) NOT NULL;
ALTER TABLE matricula MODIFY nota INT CHECK(nota >= 0 AND nota <= 10);
CREATE INDEX nombre_alumno ON alumno(nombre);
ALTER TABLE modulo RENAME asignatura;
ALTER TABLE profesor CHANGE COLUMN sueldo salario DOUBLE;
ALTER TABLE alumno MODIFY sexo CHAR CHECK(sexo = "H" OR sexo = "M");