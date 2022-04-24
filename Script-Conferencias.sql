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

-- Tarea pag 17
USE conferencias;
/* Realizar una consulta que aplique un incremento del 5% a los precios de las 
conferencias, una vez aplicado redondee el precio al número entero menor más 
cercano y ordene finalmente las filas por el precio obtenido de forma descendente 
(de mayor a menor). Hacer que la fecha se muestre en formato “DD/MM/YYYY”. */
SELECT tema, FLOOR(precio + precio * 0.05) AS precio, 
DATE_FORMAT(fecha, "%d-%m-%Y") AS fecha , turno, sala
FROM conferencia
ORDER BY precio DESC;

/* Realizar una consulta sobre la tabla ponentes que muestre todos los campos 
alfanuméricos en mayúsculas, se deben concatenar los apellidos y mostrar una 
única columna para ambos. El resultado se debe ordenar por la columna de apellidos 
resultante de forma ascendente. */
SELECT UPPER(codigo) AS codigo, UPPER(nombre) AS nombre, 
UPPER(CONCAT(apellido1, " ", apellido2)) AS apellidos, UPPER(especialidad) AS especialidad  
FROM ponente
ORDER BY apellidos;

/* Repetir el ejercicio anterior para que en el caso de que el segundo apellido 
sea NULL muestre la cadena '*****'. */
SELECT UPPER(codigo) AS codigo, UPPER(nombre) AS nombre, 
UPPER(CONCAT(apellido1, " ", IFNULL(apellido2, "*****"))) AS apellidos, UPPER(especialidad) AS especialidad  
FROM ponente
ORDER BY apellidos;

/* Repetir el ejercicio anterior completando con * los nombres y apellidos que no 
lleguen a 10 caracteres. */
SELECT UPPER(codigo) AS codigo, UPPER(RPAD(nombre, 10, "*")) AS nombre, 
UPPER(RPAD(CONCAT(apellido1, " ", IFNULL(apellido2, "*****")), 10, "*")) AS apellidos, 
UPPER(especialidad) AS especialidad  
FROM ponente
ORDER BY apellidos;

/* Realizar una consulta sobre la tabla asistente que muestre el nombre y apellidos 
de los asistentes, en el resultado que se muestre la palabra “José” debe ser sustituida
por “Pepe”. Además, para cada fila se debe añadir una nueva columna que muestre la 
longitud total del nombre y apellidos del asistente sin tener en cuenta los espacios de
separación entre el nombre y los apellidos. */
SELECT REPLACE(nombre, "José", "Pepe") AS nombre , CONCAT(apellido1, " ", apellido2) AS apellidos,
LENGTH(TRIM(CONCAT(nombre, apellido1, apellido2))) AS longitud
FROM asistente;

/* Realizar una consulta sobre la tabla asistente que muestre los días que lleva viviendo 
cada uno de ellos. Además de los días vividos debe mostrar el nombre y los apellidos. */
SELECT nombre, CONCAT(apellido1, " ", apellido2) AS apellidos,
DATEDIFF(NOW(), fechaNac) AS "dias vividos" 
FROM asistente;

/* Realizar una consulta que muestre el nombre y los apellidos junto al día de la semana, 
el día del año y el número de la semana de la fecha de nacimiento de cada uno de los 
asistentes. Asignar un alias a cada uno de los campos mostrados. */
SELECT nombre, CONCAT(apellido1, " ", apellido2) AS apellidos, DAYOFWEEK(fechaNac) AS "Dia de la semana", 
DAYOFYEAR(fechaNac) AS "Dia del año", WEEKOFYEAR(fechaNac) AS "Numero de semana"  
FROM asistente;

-- Tarea pag 20
USE conferencias;
/* Realizar una consulta donde se obtenga el número total de salas cuya capacidad sea igual o superior 
a 200. */
SELECT COUNT(*) AS "Numero de salas >= 200"  
FROM sala
WHERE capacidad >= 200;

/* Realizar una consulta donde se obtenga la media de las gratificaciones de los ponentes. */
SELECT codPonente, AVG(gratificacion) AS "Media de las gratificacion" 
FROM participar
GROUP BY codPonente;

/* Realizar una consulta que muestre el total de salas distintas en función del turno: de 
mañana (M) o tarde (T). */
SELECT turno, COUNT(sala) AS "Salas segun turno"
FROM conferencia
GROUP BY turno;

/* Repetir el ejercicio anterior teniendo en cuanta que la sala “Apolo” no debe salir 
en el resultado final. */
SELECT turno, COUNT(sala) AS "Salas segun turno"
FROM conferencia
WHERE sala NOT LIKE "Apolo"
GROUP BY turno;

/* Repetir el ejercicio anterior de forma que se muestre el total del turno de mañana (M). */
SELECT COUNT(turno) AS "Turnos de mañana", COUNT(sala) AS "Salas segun turno" 
FROM conferencia
WHERE (sala NOT LIKE "Apolo") AND (turno LIKE "M")
GROUP BY turno;

/* Realizar una consulta que muestre el total de asistentes hombres (H) y mujeres (M) 
de cada una de las empresas. */
SELECT sexo, empresa, COUNT(sexo) AS asistentes
FROM asistente
GROUP BY sexo, empresa
ORDER BY empresa;

/* Repetir el ejercicio anterior de forma que para los asistentes que tenga como 
valor de empresa NULL se agrupen en una categoría llamada "Sin empresa asignada". */
SELECT sexo, IFNULL(empresa, "Sin empresa asignada") AS empresa, COUNT(sexo) AS asistentes
FROM asistente
GROUP BY sexo, empresa
ORDER BY empresa;

/* Repetir el ejercicio anterior y hacer que solo se muestren los totales de 
hombres por cada una de las empresas. */
SELECT sexo, IFNULL(empresa, "Sin empresa asignada") AS empresa, COUNT(sexo) AS asistentes
FROM asistente
WHERE sexo LIKE "H"
GROUP BY sexo, empresa
ORDER BY empresa;

-- Tarea pag 25
USE conferencias;




-- Tarea pag 