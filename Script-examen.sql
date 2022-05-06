/* Crea una base de datos, en SQL, con el propósito que aloje datos de personas y 
vehículos, con charset utf8. */
DROP DATABASE IF EXISTS examen;
CREATE DATABASE IF NOT EXISTS examen CHARSET utf8;

/* Anteriormente ha habido un error, escribir el comando para modificar el 
charset para que sea utf8mb4. */
ALTER DATABASE examen CHARACTER SET utf8mb4;

USE examen;
/* Crea las tablas correspondientes para el siguiente esquema:(claves primarias DNI y Matrícula) */
CREATE TABLE personas (
	DNI VARCHAR(9) NOT NULL PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	apellido1 VARCHAR(50) NOT NULL,
	apellido2 VARCHAR(50) NOT NULL,
	fechaNac DATE NOT NULL
);	

CREATE TABLE coches (
	matricula VARCHAR(8) NOT NULL PRIMARY KEY,
	marca VARCHAR(50) NOT NULL,
	modelo VARCHAR(50) NOT NULL,
	dni_persona VARCHAR(9) NOT NULL,
	FOREIGN KEY (dni_persona) REFERENCES personas(DNI)
);

/* Modifica la tabla coches e introduce un atributo para indicar si es eléctrico o no, usando SQL.  */
ALTER TABLE coches ADD electrico CHAR(2);

/* Además en la relación PerCo se ha visto que es necesario reflejar la fecha de 
compra del vehículo, Modifica la tabla afectada usando SQL.*/
CREATE TABLE PerCo (
	dni VARCHAR(9) NOT NULL,
	matricula VARCHAR(8) NOT NULL,
	fechaCompra DATE NOT NULL,
	FOREIGN KEY (dni) REFERENCES personas(DNI),
	FOREIGN KEY (matricula) REFERENCES coches(matricula)
);

/* Se ha visto la necesidad de crear una nueva tabla Siniestros. En la que varios vehículos 
pueden verse implicados en un siniestro en una fecha concreta. Cada siniestro se identifica 
con un código de siniestro. Crea el esquema E-R y crea el SQL para añadir la tabla a la 
base de datos. */


/* Crea una vista para mostrar el nombre propietario, dni, matricula del vehículo y modelo. */
CREATE VIEW vista_coches AS SELECT P.nombre, P.dni, C.matricula, C.modelo
FROM personas AS P
JOIN coches AS C ON (P.dni = C.dni_persona);

/* Crea un usuario ‘gestor’ que tenga privilegios de administrador, pero solo 
sobre esta base de datos. */
CREATE USER "examen"@"%" IDENTIFIED BY "211099";
GRANT ALL PRIVILEGES ON examen.* TO "examen"@"%"; 

















