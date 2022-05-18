DROP DATABASE IF EXISTS alojamientos;
CREATE DATABASE IF NOT EXISTS alojamientos CHARSET utf8mb4;
USE alojamientos;

CREATE TABLE alojamiento (
	nombre VARCHAR(50) NOT NULL PRIMARY KEY,
	direccion VARCHAR(60) NOT NULL,
	telefono VARCHAR(9) NOT NULL,
	email VARCHAR(50),
	nº_habitaciones INT NOT NULL
);

INSERT INTO alojamiento(nombre, direccion, telefono, nº_habitaciones)
VALUES("La Solera", "Calle 1", "674258538", 20);
INSERT INTO alojamiento(nombre, direccion, telefono, nº_habitaciones)
VALUES("Luna", "Calle 2", "672853029", 50);

CREATE TABLE persona (
	codigo VARCHAR(10) NOT NULL PRIMARY KEY,
	nombre_persona VARCHAR(50) NOT NULL,
	fecha_nac DATE NOT NULL,
	direccion VARCHAR(255),
	NIF VARCHAR(9) NOT NULL,
	nombre_alo VARCHAR(50) NOT NULL,
	FOREIGN KEY (nombre_alo) REFERENCES alojamiento(nombre)
);

CREATE TABLE habitacion (
	codigo VARCHAR(10) NOT NULL PRIMARY KEY,
	tipo VARCHAR(50) NOT NULL,
	precio DOUBLE NOT NULL,
	bano CHAR(2) NOT NULL,
	nombre_alo VARCHAR(50) NOT NULL,
	FOREIGN KEY (nombre_alo) REFERENCES alojamiento(nombre)
);

INSERT INTO habitacion(codigo, tipo, precio, bano, nombre_alo)
VALUES("0001", "dobles", 64, 'si', "La Solera");
INSERT INTO habitacion(codigo, tipo, precio, bano, nombre_alo)
VALUES("0002", "individual", 40, 'no', "Luna");
INSERT INTO habitacion(codigo, tipo, precio, bano, nombre_alo)
VALUES("0003", "dobles", 100, 'NO', "La Solera");
INSERT INTO habitacion(codigo, tipo, precio, bano, nombre_alo)
VALUES("0004", "dobles", 70, 'si', "Luna");

CREATE TABLE actividades (
	codigo VARCHAR(10) NOT NULL PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	descripcion VARCHAR(255),
	dificultad INT NOT NULL,
	nombre_alo VARCHAR(50) NOT NULL,
	FOREIGN KEY (nombre_alo) REFERENCES alojamiento(nombre)
);

INSERT INTO actividades(codigo, nombre, descripcion, dificultad, nombre_alo)
VALUES("0001", "Escalada", "Se realiza escalada", 10, "La Solera");
INSERT INTO actividades(codigo, nombre, descripcion, dificultad, nombre_alo)
VALUES("0002", "Senderismo", "Se realiza senderismo", 2, "La Solera");
INSERT INTO actividades(codigo, nombre, descripcion, dificultad, nombre_alo)
VALUES("0003", "Escalada", "Se realiza escalada", 10, "Luna");
INSERT INTO actividades(codigo, nombre, descripcion, dificultad, nombre_alo)
VALUES("0004", "Natacion", "Se realiza natacion", 5, "La Solera");

SELECT nombre, descripcion FROM actividades WHERE nombre_alo = "La Solera";

SELECT nombre FROM alojamiento where nombre = ANY (SELECT nombre_alo FROM habitacion 
WHERE tipo = "dobles" AND nombre_alo = ANY (SELECT nombre_alo FROM actividades WHERE 
nombre = "Escalada"));


















