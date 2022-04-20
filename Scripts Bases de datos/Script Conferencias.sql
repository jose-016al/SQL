DROP USER IF EXISTS conferencias;

DROP DATABASE IF EXISTS conferencias;

CREATE DATABASE conferencias COLLATE utf8mb4_spanish_ci;

USE conferencias;

CREATE TABLE sala (
	nombre		VARCHAR(50) PRIMARY KEY,
	capacidad	SMALLINT UNSIGNED NOT NULL
);

CREATE TABLE conferencia (
	referencia	CHAR(7) PRIMARY KEY,
	tema		VARCHAR(60),
	precio		DECIMAL(5,2),
	fecha		DATE NOT NULL,
	turno		VARCHAR(1) CHECK (turno IN ('T', 'M')),
	sala		VARCHAR(50) NOT NULL,
	CONSTRAINT con_sal_FK FOREIGN KEY (sala) REFERENCES sala(nombre)
);

CREATE TABLE ponente (
	codigo			CHAR(6) PRIMARY KEY,
	nombre			VARCHAR(50) NOT NULL,
	apellido1		VARCHAR(50) NOT NULL,
	apellido2		VARCHAR(50),
	especialidad	VARCHAR(50)
);

CREATE TABLE participar (
	codPonente		CHAR(6),
	refConferencia	CHAR(7),
	numOrden		TINYINT UNSIGNED,
	gratificacion	DECIMAL(6,2),
	CONSTRAINT par_cod_PK PRIMARY KEY (codPonente, refConferencia),
	CONSTRAINT par_pon_FK FOREIGN KEY (codPonente) REFERENCES ponente(codigo),
	CONSTRAINT par_con_FK FOREIGN KEY (refConferencia) REFERENCES conferencia(referencia)
);

CREATE TABLE asistente (
	codigo		CHAR(6) PRIMARY KEY,
	nombre		VARCHAR(50) NOT NULL,
	apellido1	VARCHAR(50) NOT NULL,
	apellido2	VARCHAR(50),
	sexo		VARCHAR(1) CHECK (sexo in ('H', 'M')),
	fechaNac	DATE NOT NULL,
	empresa		VARCHAR(50)
);

CREATE TABLE asistir (
	codAsistente	CHAR(6),
	refConferencia	CHAR(7),
	CONSTRAINT asi_cod_PK PRIMARY KEY (codAsistente, refConferencia),
	CONSTRAINT asi_asi_FK FOREIGN KEY (codAsistente) REFERENCES asistente(codigo),
	CONSTRAINT asi_con_FK FOREIGN KEY (refConferencia) REFERENCES conferencia(referencia)
);

INSERT INTO sala VALUES ('Zeus', 250);
INSERT INTO sala VALUES ('Afrodita', 80);
INSERT INTO sala VALUES ('Apolo', 200);
INSERT INTO sala VALUES ('Hermes', 150);

INSERT INTO conferencia VALUES ('BDO1314', 'Bases de Datos Orientadas a Objetos', 10.50, '2013-10-01', 'T', 'Afrodita');
INSERT INTO conferencia VALUES ('POO1314', 'Programación Orientada a Objetos', 20.00, '2013-10-02', 'M', 'Zeus');
INSERT INTO conferencia VALUES ('PWB1314', 'Programación Web', 18.50, '2013-10-02', 'T', 'Apolo');
INSERT INTO conferencia VALUES ('ADS1314', 'Accediendo a datos de forma segura', 12.50, '2013-10-03', 'M', 'Afrodita');
INSERT INTO conferencia VALUES ('SEG1314', 'Seguridad Informática en la Empresa', 15.00, '2013-10-03', 'T', 'Apolo');

INSERT INTO ponente VALUES ('ESP001', 'Juan', 'Llobregat', 'García', 'Bases de Datos');
INSERT INTO ponente VALUES ('USA001', 'Stephen', 'Gary', NULL, 'Programación');
INSERT INTO ponente VALUES ('FRA001', 'Piere', 'Gaul', 'More', 'Seguridad Informática');
INSERT INTO ponente VALUES ('ESP002', 'Silvia', 'Durán', 'Céspedes', 'Bases de Datos');
INSERT INTO ponente VALUES ('ESP003', 'Julián', 'Amor', 'Pérez', 'Seguridad Informática');
INSERT INTO ponente VALUES ('USA002', 'Robert', 'Craig', NULL, 'Bases de Datos');
INSERT INTO ponente VALUES ('ESP004', 'Luisa', 'Soriano', 'López', 'Seguridad Informática');
INSERT INTO ponente VALUES ('USA003', 'Kevin', 'Shull', NULL, 'Programación');

INSERT INTO participar VALUES ('ESP001', 'BDO1314', 1, 450.00);
INSERT INTO participar VALUES ('USA002', 'BDO1314', 2, 350.00);
INSERT INTO participar VALUES ('ESP002', 'BDO1314', 3, 550.00);
INSERT INTO participar VALUES ('USA003', 'POO1314', 1, 600.00);
INSERT INTO participar VALUES ('USA001', 'POO1314', 2, 520.00);
INSERT INTO participar VALUES ('USA001', 'PWB1314', 1, 370.00);
INSERT INTO participar VALUES ('ESP003', 'PWB1314', 2, 250.00);
INSERT INTO participar VALUES ('FRA001', 'PWB1314', 3, 375.00);
INSERT INTO participar VALUES ('USA003', 'PWB1314', 4, 350.00);
INSERT INTO participar VALUES ('ESP002', 'ADS1314', 1, 420.00);
INSERT INTO participar VALUES ('FRA001', 'ADS1314', 2, 330.00);
INSERT INTO participar VALUES ('USA001', 'ADS1314', 3, 560.00);
INSERT INTO participar VALUES ('USA002', 'ADS1314', 4, 150.00);
INSERT INTO participar VALUES ('ESP004', 'ADS1314', 5, 480.00);
INSERT INTO participar VALUES ('ESP003', 'SEG1314', 1, 350.00);
INSERT INTO participar VALUES ('ESP004', 'SEG1314', 2, 290.00);
INSERT INTO participar VALUES ('USA001', 'SEG1314', 3, 600.00);
INSERT INTO participar VALUES ('FRA001', 'SEG1314', 4, 570.00);

INSERT INTO asistente VALUES ('AS0001', 'Mario', 'Céspedes', 'Hermida', 'H', '1970-11-16', 'BK Programación');
INSERT INTO asistente VALUES ('AS0002', 'Carmen', 'Gutiérrez', 'Sevilla', 'M', '1968-02-20', 'BK Programación');
INSERT INTO asistente VALUES ('AS0003', 'Felipe', 'Martín', 'Comillas', 'H', '1975-11-06', 'ProgConsulting');
INSERT INTO asistente VALUES ('AS0004', 'Lourdes', 'Soriano', 'López', 'M', '1982-07-30', NULL);
INSERT INTO asistente VALUES ('AS0005', 'Inmaculada', 'Herrero', 'Puig', 'M', '1978-09-13', 'BigSoft');
INSERT INTO asistente VALUES ('AS0006', 'Lucía', 'Díaz', 'Martínez', 'M', '1973-08-25', 'BigSoft');
INSERT INTO asistente VALUES ('AS0007', 'Fermín', 'Gutiérrez', 'Pérez', 'H', '1969-03-03', 'ProgConsulting');
INSERT INTO asistente VALUES ('AS0008', 'José Enrique', 'Martos', 'Martos', 'H', '1982-10-20', 'BK Programación');
INSERT INTO asistente VALUES ('AS0009', 'José Ramón', 'Gómez', 'Pérez', 'H', '1973-01-21', 'ProgConsulting');
INSERT INTO asistente VALUES ('AS0010', 'Mercedes', 'Bosh', 'Toral', 'M', '1980-05-05', 'BK Programación');
INSERT INTO asistente VALUES ('AS0011', 'María José', 'Vázquez', 'Soriano', 'M', '1990-03-19', NULL);
INSERT INTO asistente VALUES ('AS0012', 'José Luis', 'Jiménez', 'Molina', 'H', '1991-10-01', 'BigSoft');
INSERT INTO asistente VALUES ('AS0013', 'Manuel', 'Pérez', 'Martínez', 'H', '1987-11-30', NULL);

INSERT INTO asistir VALUES ('AS0013', 'BDO1314');
INSERT INTO asistir VALUES ('AS0009', 'BDO1314');
INSERT INTO asistir VALUES ('AS0006', 'BDO1314');
INSERT INTO asistir VALUES ('AS0007', 'BDO1314');
INSERT INTO asistir VALUES ('AS0012', 'BDO1314');
INSERT INTO asistir VALUES ('AS0003', 'BDO1314');
INSERT INTO asistir VALUES ('AS0008', 'POO1314');
INSERT INTO asistir VALUES ('AS0003', 'POO1314');
INSERT INTO asistir VALUES ('AS0005', 'POO1314');
INSERT INTO asistir VALUES ('AS0013', 'POO1314');
INSERT INTO asistir VALUES ('AS0002', 'POO1314');
INSERT INTO asistir VALUES ('AS0001', 'POO1314');
INSERT INTO asistir VALUES ('AS0012', 'POO1314');
INSERT INTO asistir VALUES ('AS0010', 'POO1314');
INSERT INTO asistir VALUES ('AS0004', 'POO1314');
INSERT INTO asistir VALUES ('AS0007', 'POO1314');
INSERT INTO asistir VALUES ('AS0011', 'POO1314');
INSERT INTO asistir VALUES ('AS0012', 'PWB1314');
INSERT INTO asistir VALUES ('AS0007', 'PWB1314');
INSERT INTO asistir VALUES ('AS0009', 'PWB1314');
INSERT INTO asistir VALUES ('AS0013', 'PWB1314');
INSERT INTO asistir VALUES ('AS0008', 'PWB1314');
INSERT INTO asistir VALUES ('AS0004', 'PWB1314');
INSERT INTO asistir VALUES ('AS0011', 'PWB1314');
INSERT INTO asistir VALUES ('AS0003', 'PWB1314');
INSERT INTO asistir VALUES ('AS0010', 'PWB1314');
INSERT INTO asistir VALUES ('AS0001', 'PWB1314');
INSERT INTO asistir VALUES ('AS0006', 'PWB1314');
INSERT INTO asistir VALUES ('AS0005', 'PWB1314');
INSERT INTO asistir VALUES ('AS0002', 'PWB1314');
INSERT INTO asistir VALUES ('AS0012', 'ADS1314');
INSERT INTO asistir VALUES ('AS0008', 'ADS1314');
INSERT INTO asistir VALUES ('AS0010', 'ADS1314');
INSERT INTO asistir VALUES ('AS0001', 'ADS1314');
INSERT INTO asistir VALUES ('AS0007', 'ADS1314');
INSERT INTO asistir VALUES ('AS0009', 'SEG1314');
INSERT INTO asistir VALUES ('AS0008', 'SEG1314');
INSERT INTO asistir VALUES ('AS0003', 'SEG1314');
INSERT INTO asistir VALUES ('AS0004', 'SEG1314');
INSERT INTO asistir VALUES ('AS0010', 'SEG1314');
INSERT INTO asistir VALUES ('AS0006', 'SEG1314');
