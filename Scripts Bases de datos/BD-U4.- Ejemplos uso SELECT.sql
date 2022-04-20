DROP USER IF EXISTS base_datos;
CREATE USER base_datos IDENTIFIED BY "base_datos";

DROP DATABASE IF EXISTS base_datos;
CREATE DATABASE IF NOT EXISTS base_datos COLLATE utf8mb4_spanish_ci;

GRANT ALL PRIVILEGES ON base_datos.* TO base_datos;

USE base_datos;

-- ********************** TABLAS VENTAS **********************

DROP TABLE IF EXISTS departamento;
CREATE TABLE IF NOT EXISTS departamento (
  idDepartamento 		TINYINT UNSIGNED PRIMARY KEY,
  nombreDepartamento 	VARCHAR(50) NOT NULL UNIQUE,
  localidad 			VARCHAR(50) NOT NULL
);
INSERT INTO departamento (idDepartamento, nombreDepartamento, localidad) VALUES
	(10, 'Contabilidad', 'Madrid'),
	(20, 'Investigación', 'Bilbao'),
	(30, 'Ventas', 'Sevilla'),
	(40, 'Operaciones', 'Málaga');

DROP TABLE IF EXISTS oficio;
CREATE TABLE IF NOT EXISTS oficio (
  idOficio 	TINYINT UNSIGNED PRIMARY KEY,
  oficio 	VARCHAR(50) NOT NULL UNIQUE
);
INSERT INTO oficio (idOficio, oficio) VALUES
	(3, 'Analista'),
	(2, 'Director'),
	(5, 'Empleado'),
	(4, 'Presidente'),
	(1, 'Vendedor');

DROP TABLE IF EXISTS empleado;
CREATE TABLE IF NOT EXISTS empleado (
  idEmpleado 		SMALLINT UNSIGNED PRIMARY KEY,
  apellido 			VARCHAR(50) NOT NULL,
  idOficio 			TINYINT UNSIGNED NOT NULL,
  idDirige 			SMALLINT UNSIGNED NOT NULL,
  fechaAlta 		DATE NOT NULL,
  salario 			DECIMAL(8,2) UNSIGNED NOT NULL,
  comision 			DECIMAL(8,2) UNSIGNED NOT NULL,
  idDepartamento 	TINYINT UNSIGNED NOT NULL,
  CONSTRAINT FK__departamento FOREIGN KEY (idDepartamento) REFERENCES departamento (idDepartamento),
  CONSTRAINT FK_empleado_oficio FOREIGN KEY (idOficio) REFERENCES oficio (idOficio)
);
INSERT INTO empleado (idEmpleado, apellido, idOficio, idDirige, fechaAlta, salario, comision, idDepartamento) VALUES
	(7369, 'Sánchez', 5, 7902, '1980-12-17', 1040.00, 0.00, 20),
	(7499, 'Arroyo', 1, 7698, '1981-02-20', 2080.00, 390.00, 30),
	(7521, 'Sala', 1, 7698, '1981-02-22', 1625.00, 650.00, 30),
	(7566, 'Jiménez', 2, 7839, '1981-04-02', 3867.50, 0.00, 20),
	(7654, 'Arenas', 1, 7698, '1981-09-28', 1625.00, 1820.00, 30),
	(7698, 'Negro', 2, 7839, '1981-05-01', 3705.00, 0.00, 30),
	(7782, 'Cerezo', 2, 7839, '1981-06-09', 3185.00, 0.00, 10),
	(7788, 'Gil', 3, 7566, '1982-12-09', 3900.00, 0.00, 20),
	(7839, 'Rey', 4, 7839, '1981-11-17', 6500.00, 0.00, 10),
	(7844, 'Tovar', 1, 7698, '1981-09-08', 1950.00, 0.00, 30),
	(7876, 'Alonso', 5, 7788, '1983-01-12', 1430.00, 0.00, 20),
	(7900, 'Jimeno', 5, 7698, '1981-12-03', 1235.00, 0.00, 30),
	(7902, 'Fernández', 3, 7566, '1981-12-03', 3900.00, 0.00, 20),
	(7934, 'Muñoz', 5, 7782, '1982-01-23', 1690.00, 0.00, 10);
ALTER TABLE empleado ADD CONSTRAINT FK_empleado_empleado FOREIGN KEY (idDirige) REFERENCES empleado (idEmpleado);

-- ********************** FIN TABLAS VENTAS **********************

-- ********************** TABLAS HOSPITAL **********************

DROP TABLE IF EXISTS especialidad;
CREATE TABLE IF NOT EXISTS especialidad (
  idEspecialidad 	TINYINT UNSIGNED PRIMARY KEY,
  especialidad		VARCHAR(30) NOT NULL UNIQUE
);
INSERT INTO especialidad (idEspecialidad, especialidad) VALUES
	(1, 'Cardiología'),
	(2, 'Ginecología'),
	(3, 'Pediatría'),
	(5, 'Psiquiatría'),
	(4, 'Urología');

DROP TABLE IF EXISTS hospital;
CREATE TABLE IF NOT EXISTS hospital (
  idHospital 		TINYINT UNSIGNED PRIMARY KEY,
  nombreHospital 	VARCHAR(50) NOT NULL,
  direccion 		VARCHAR(100),
  telefono 			VARCHAR(20),
  numCamas			SMALLINT UNSIGNED
);
INSERT INTO hospital (idHospital, nombreHospital, direccion, telefono, numCamas) VALUES
	(13, 'Provincial', 'O Donell 50', '91-9644264', 502),
	(18, 'General', 'Atocha S/N', '91-5953111', 987),
	(22, 'La Paz', 'Castellana 100', '91-9235411', 412),
	(45, 'San Carlos', 'Ciudad Universitaria', '91-5971500', 845);

DROP TABLE IF EXISTS doctor;
CREATE TABLE IF NOT EXISTS doctor (
  idDoctor 			SMALLINT UNSIGNED PRIMARY KEY,
  idHospital 		TINYINT UNSIGNED NOT NULL,
  apellido 			VARCHAR(50) NOT NULL,
  idEspecialidad 	TINYINT UNSIGNED,
  CONSTRAINT FK_doctor_hospital FOREIGN KEY (idHospital) REFERENCES hospital (idHospital),
  CONSTRAINT FK_doctor_especialidad FOREIGN KEY (idEspecialidad) REFERENCES especialidad (idEspecialidad)
);
INSERT INTO doctor (idDoctor, idHospital, apellido, idEspecialidad) VALUES
	(386, 22, 'Cabeza D.', 5),
	(398, 22, 'Best K.', 4),
	(435, 13, 'Lopez A.', 1),
	(453, 22, 'Galo D.', 3),
	(585, 18, 'Miller G.', 2),
	(607, 45, 'Niqo P.', 3),
	(982, 18, 'Cajal R.', 1);

DROP TABLE IF EXISTS funcion;
CREATE TABLE IF NOT EXISTS funcion (
  idFuncion TINYINT UNSIGNED PRIMARY KEY,
  funcion 	VARCHAR(30) UNIQUE
);
INSERT INTO funcion (idFuncion, funcion) VALUES
	(3, 'Enfermera'),
	(2, 'Enfermero'),
	(1, 'Interno');

DROP TABLE IF EXISTS paciente;
CREATE TABLE IF NOT EXISTS paciente (
  idPaciente 		SMALLINT UNSIGNED PRIMARY KEY,
  apellido 			VARCHAR(50),
  direccion 		VARCHAR(100),
  fechaNacimiento 	DATE,
  sexo 				ENUM('M', 'F'),
  nss 				BIGINT
);
INSERT INTO paciente (idPaciente, apellido, direccion, fechaNacimiento, sexo, nss) VALUES
	(10995, 'Laguia M.', 'Recoletos 50', '1967-06-23', 'M', 280862482),
	(14024, 'Fernandez M.', 'Recoletos 50', '1967-06-23', 'F', 321790059),
	(18004, 'Serrano V.', 'Alcala 12', '1960-05-21', 'F', 284991452),
	(36658, 'Domin S.', 'Mayor 71', '1942-06-01', 'M', 160657471),
	(38702, 'Neal R.', 'Orense 11', '1940-06-18', 'F', 380010217),
	(39217, 'Cervantes M.', 'Peron 38', '1952-02-29', 'M', 440294390),
	(59076, 'Miller G.', 'Lopez de Hoyos 2', '1945-09-16', 'F', 311969044),
	(63827, 'Ruiz P.', 'Esquerdo 103', '1980-12-26', 'M', 100973253),
	(64823, 'Fraser A.', 'Soto 3', '1980-07-10', 'F', 285201776),
	(74835, 'Benitez E.', 'Argentina 5', '1957-10-05', 'M', 154811767);

DROP TABLE IF EXISTS sala;
CREATE TABLE IF NOT EXISTS sala (
  idSala TINYINT UNSIGNED PRIMARY KEY,
  sala VARCHAR(50) UNIQUE
);
INSERT INTO sala (idSala, sala) VALUES
	(4, 'Cardiología'),
	(3, 'Cuidados intensivos'),
	(2, 'Maternidad'),
	(6, 'Psiquiatría'),
	(1, 'Recuperación'),
	(5, 'Traumatología');

DROP TABLE IF EXISTS salas_hospital;
CREATE TABLE IF NOT EXISTS salas_hospital (
  idHospital 	TINYINT UNSIGNED,
  IdSala 		TINYINT UNSIGNED,
  numCamas 		SMALLINT,
  PRIMARY KEY (idHospital, IdSala),
  CONSTRAINT FK_sala_hospital FOREIGN KEY (idHospital) REFERENCES hospital (idHospital),
  CONSTRAINT FK_salas_hospital_salas FOREIGN KEY (IdSala) REFERENCES sala (idSala)
);
INSERT INTO salas_hospital (idHospital, IdSala, numCamas) VALUES
	(13, 3, 21),
	(13, 6, 67),
	(18, 3, 10),
	(18, 4, 53),
	(22, 1, 10),
	(22, 2, 34),
	(22, 6, 118),
	(45, 1, 13),
	(45, 2, 24),
	(45, 4, 55);

DROP TABLE IF EXISTS ocupacion;
CREATE TABLE IF NOT EXISTS ocupacion (
  idPaciente 	SMALLINT UNSIGNED,
  idHospital 	TINYINT UNSIGNED,
  idSala 		TINYINT UNSIGNED,
  cama 			SMALLINT UNSIGNED,
  PRIMARY KEY (idPaciente, idHospital, idSala, cama),
  CONSTRAINT FK_ocupacion_paciente FOREIGN KEY (idPaciente) REFERENCES paciente (idPaciente),
  CONSTRAINT FK_ocupacion_sala FOREIGN KEY (idHospital, idSala) REFERENCES salas_hospital (idHospital, IdSala)
);
INSERT INTO ocupacion (idPaciente, idHospital, idSala, cama) VALUES
	(10995, 13, 3, 1),
	(14024, 13, 3, 3),
	(18004, 13, 3, 2),
	(36658, 18, 4, 1),
	(38702, 18, 4, 2),
	(39217, 22, 6, 1),
	(59076, 22, 6, 2),
	(63827, 22, 6, 3),
	(64823, 22, 2, 1);

DROP TABLE IF EXISTS plantilla;
CREATE TABLE IF NOT EXISTS plantilla (
  idEmpleado 	SMALLINT UNSIGNED PRIMARY KEY,
  idHospital 	TINYINT UNSIGNED NOT NULL,
  idSala 		TINYINT UNSIGNED NOT NULL,
  apellido 		VARCHAR(50),
  idFuncion 	TINYINT UNSIGNED,
  turno 		ENUM('M', 'T', 'N'),
  salario 		DECIMAL(8,2),
  CONSTRAINT FK__sala FOREIGN KEY (idHospital, idSala) REFERENCES salas_hospital (idHospital, IdSala),
  CONSTRAINT FK_plantilla_funcion FOREIGN KEY (idFuncion) REFERENCES funcion (idFuncion)
);
INSERT INTO plantilla (idEmpleado, idHospital, idSala, apellido, idFuncion, turno, salario) VALUES
	(1009, 22, 6, 'Higueras D.', 3, 'T', 2005.00),
	(1234, 22, 2, 'García J.', 2, 'M', 3000.00),
	(1280, 45, 4, 'Amigo R.', 1, 'N', 2210.00),
	(3106, 13, 6, 'Hernández J.', 2, 'T', 2755.00),
	(3754, 13, 6, 'Díaz B.', 3, 'T', 2262.00),
	(6065, 22, 1, 'Rivera G.', 3, 'N', 1626.00),
	(6357, 18, 4, 'Karplus W.', 1, 'T', 3379.00),
	(7379, 22, 1, 'Carlos R.', 3, 'T', 2119.00),
	(8422, 22, 6, 'Bocina G.', 2, 'M', 1638.00),
	(8526, 45, 1, 'Frank H.', 3, 'T', 2522.00),
	(9901, 22, 2, 'Núñez C.', 1, 'M', 2210.00);

-- ********************** FIN TABLAS HOSPITAL **********************
