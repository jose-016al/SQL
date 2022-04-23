USE conferencias;
-- Tarea pag 9
/* Realizar una consulta que calcule la suma, resta, producto y divisi�n de
los n�meros 10 y 5 respectivamente. */
SELECT 10 + 5;
SELECT 10 - 5;
SELECT 10 * 5;
SELECT 10 / 5;

/* Repetir la consulta del ejercicio anterior asignando un alias a las cuatro 
operaciones. */
SELECT 10 + 5 AS suma;
SELECT 10 - 5 AS resta;
SELECT 10 * 5 AS producto;
SELECT 10 / 5 AS division;

/* Realizar una consulta que muestre el nombre y los apellidos de los asistentes 
cuya empresa sea �BK Programaci�n�. */
SELECT nombre, CONCAT(apellido1, " ", apellido2) AS apellidos
FROM asistente 
WHERE empresa = "BK Programacion"; 

/* Realizar una consulta que muestre el nombre y capacidad de las salas, ordenada 
de mayor a menor capacidad. */
SELECT nombre, capacidad
FROM sala
ORDER BY capacidad DESC;

/* Realizar una consulta donde se obtenga toda la informaci�n de los asistentes 
de la empresa �BigSoft� ordenados por la fecha de nacimiento de forma descendente. */
SELECT * 
FROM asistente 
WHERE empresa = "BigSoft"
ORDER BY fechaNac DESC;

/* Realizar una consulta que muestre el total de asistentes por empresa (ver
ejemplo punto 2.4). */
SELECT empresa, COUNT(*) asistentes 
FROM asistente
GROUP BY empresa;

/* Realizar una consulta que muestre el nombre y los apellidos de los primeros 
cinco asistentes, el resultado debe mostrarse ordenado por el primer apellido 
de forma ascendente.  */
SELECT nombre, CONCAT(apellido1, " ", apellido2) AS apellidos
FROM asistente
ORDER BY apellido1 ASC
LIMIT 0, 5;

-- Tarea pag 12
USE conferencias;
/* Realizar una consulta donde se obtenga el tema y la fecha de las conferencias
que tengan turno de tarde y se celebren en las salas “Apolo” o “Zeus”. */
SELECT tema, fecha 
FROM conferencia 
WHERE (turno = "T") AND (sala = "Apolo") OR (sala = "Zeus"); 

/* Realizar una consulta donde se obtengan aquellos asistentes cuyo apellido1 
comienza por la letra “M” y contienen la letra “R”. */
SELECT nombre, CONCAT(apellido1, " ", apellido2) AS aepllidos, fechaNac 
FROM asistente  
WHERE (apellido1 LIKE ("M%")) AND (apellido1 LIKE ("%r%")); 

/* Realizar una consulta que seleccione las conferencias cuyo precio esté
comprendido entre 12 y 19 euros, y cuyo tema no sea “Programación Web”. */
SELECT * 
FROM conferencia  
WHERE (precio BETWEEN 12 AND 19) AND (tema NOT LIKE ("Programación Web")); 

/* Realizar una consulta que seleccione los asistentes cuyas fechas de nacimiento 
estén comprendidas entre el “01/01/1974” y el “01/01/1985”, ordenando los
resultados por la fecha de nacimiento y concatenando las columnas apellido1 
y apellido2 en una sola a la que se le asigne el alias “Apellidos”.*/
SELECT nombre, CONCAT(apellido1, " ", apellido2) AS apellidos, fechaNac 
FROM asistente 
WHERE fechaNac BETWEEN "19740101" AND "19850101" 
ORDER BY fechaNac; 

/* Realizar una consulta que seleccione las conferencias cuyo tema comience
por “Programación”, ordenando los resultados por su precio de forma descendente
(de mayor a menor precio). */
SELECT * 
FROM conferencia
WHERE tema LIKE ("Programación%") 
ORDER BY precio DESC; 

/* Realizar una consulta que calcule los precios de las distintas conferencias 
teniendo en cuenta que se van a aplicar los siguientes descuentos:
0%, 5%, 10%, 15% y 20%. Asignar un alias a cada una de las nuevas columnas
calculadas (“Descuento 0%”, “Descuento 5%”, ... respectivamente). */
SELECT precio AS "Descuento 0%",
precio - precio * 0.05 AS "Descuento 5%",
precio - precio * 0.10 AS "Descuento 10%",
precio - precio * 0.15 AS "Descuento 15%",
precio - precio * 0.20 AS "Descuento 20%"
FROM conferencia;