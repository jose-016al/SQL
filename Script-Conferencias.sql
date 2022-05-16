USE conferencias;
-- Tarea pag 9
/* Realizar una consulta que calcule la suma, resta, producto y divisi?n de
los n?meros 10 y 5 respectivamente. */
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
cuya empresa sea ?BK Programaci?n?. */
SELECT nombre, CONCAT(apellido1, " ", apellido2) AS apellidos
FROM asistente 
WHERE empresa = "BK Programacion"; 

/* Realizar una consulta que muestre el nombre y capacidad de las salas, ordenada 
de mayor a menor capacidad. */
SELECT nombre, capacidad
FROM sala
ORDER BY capacidad DESC;

/* Realizar una consulta donde se obtenga toda la informaci?n de los asistentes 
de la empresa ?BigSoft? ordenados por la fecha de nacimiento de forma descendente. */
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
que tengan turno de tarde y se celebren en las salas �Apolo� o �Zeus�. */
SELECT tema, fecha 
FROM conferencia 
WHERE (turno = "T") AND (sala = "Apolo") OR (sala = "Zeus"); 

/* Realizar una consulta donde se obtengan aquellos asistentes cuyo apellido1 
comienza por la letra �M� y contienen la letra �R�. */
SELECT nombre, CONCAT(apellido1, " ", apellido2) AS aepllidos, fechaNac 
FROM asistente  
WHERE (apellido1 LIKE ("M%")) AND (apellido1 LIKE ("%r%")); 

/* Realizar una consulta que seleccione las conferencias cuyo precio est�
comprendido entre 12 y 19 euros, y cuyo tema no sea �Programaci�n Web�. */
SELECT * 
FROM conferencia  
WHERE (precio BETWEEN 12 AND 19) AND (tema NOT LIKE ("Programaci�n Web")); 

/* Realizar una consulta que seleccione los asistentes cuyas fechas de nacimiento 
est�n comprendidas entre el �01/01/1974� y el �01/01/1985�, ordenando los
resultados por la fecha de nacimiento y concatenando las columnas apellido1 
y apellido2 en una sola a la que se le asigne el alias �Apellidos�.*/
SELECT nombre, CONCAT(apellido1, " ", apellido2) AS apellidos, fechaNac 
FROM asistente 
WHERE fechaNac BETWEEN "19740101" AND "19850101" 
ORDER BY fechaNac; 

/* Realizar una consulta que seleccione las conferencias cuyo tema comience
por �Programaci�n�, ordenando los resultados por su precio de forma descendente
(de mayor a menor precio). */
SELECT * 
FROM conferencia
WHERE tema LIKE ("Programaci�n%") 
ORDER BY precio DESC; 

/* Realizar una consulta que calcule los precios de las distintas conferencias 
teniendo en cuenta que se van a aplicar los siguientes descuentos:
0%, 5%, 10%, 15% y 20%. Asignar un alias a cada una de las nuevas columnas
calculadas (�Descuento 0%�, �Descuento 5%�, ... respectivamente). */
SELECT precio AS "Descuento 0%",
precio - precio * 0.05 AS "Descuento 5%",
precio - precio * 0.10 AS "Descuento 10%",
precio - precio * 0.15 AS "Descuento 15%",
precio - precio * 0.20 AS "Descuento 20%"
FROM conferencia;

-- Tarea pag 17
USE conferencias;
/* Realizar una consulta que aplique un incremento del 5% a los precios de las 
conferencias, una vez aplicado redondee el precio al n�mero entero menor m�s 
cercano y ordene finalmente las filas por el precio obtenido de forma descendente 
(de mayor a menor). Hacer que la fecha se muestre en formato �DD/MM/YYYY�. */
SELECT tema, FLOOR(precio + precio * 0.05) AS precio, 
DATE_FORMAT(fecha, "%d-%m-%Y") AS fecha , turno, sala
FROM conferencia
ORDER BY precio DESC;

/* Realizar una consulta sobre la tabla ponentes que muestre todos los campos 
alfanum�ricos en may�sculas, se deben concatenar los apellidos y mostrar una 
�nica columna para ambos. El resultado se debe ordenar por la columna de apellidos 
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
de los asistentes, en el resultado que se muestre la palabra �Jos� debe ser sustituida
por �Pepe�. Adem�s, para cada fila se debe a�adir una nueva columna que muestre la 
longitud total del nombre y apellidos del asistente sin tener en cuenta los espacios de
separaci�n entre el nombre y los apellidos. */
SELECT REPLACE(nombre, "Jos�", "Pepe") AS nombre , CONCAT(apellido1, " ", apellido2) AS apellidos,
LENGTH(TRIM(CONCAT(nombre, apellido1, apellido2))) AS longitud
FROM asistente;

/* Realizar una consulta sobre la tabla asistente que muestre los d�as que lleva viviendo 
cada uno de ellos. Adem�s de los d�as vividos debe mostrar el nombre y los apellidos. */
SELECT nombre, CONCAT(apellido1, " ", apellido2) AS apellidos,
DATEDIFF(NOW(), fechaNac) AS "dias vividos" 
FROM asistente;

/* Realizar una consulta que muestre el nombre y los apellidos junto al d�a de la semana, 
el d�a del a�o y el n�mero de la semana de la fecha de nacimiento de cada uno de los 
asistentes. Asignar un alias a cada uno de los campos mostrados. */
SELECT nombre, CONCAT(apellido1, " ", apellido2) AS apellidos, DAYOFWEEK(fechaNac) AS "Dia de la semana", 
DAYOFYEAR(fechaNac) AS "Dia del a�o", WEEKOFYEAR(fechaNac) AS "Numero de semana"  
FROM asistente;

-- Tarea pag 20
USE conferencias;
/* Realizar una consulta donde se obtenga el n�mero total de salas cuya capacidad sea igual o superior 
a 200. */
SELECT COUNT(*) AS "Numero de salas >= 200"  
FROM sala
WHERE capacidad >= 200;

/* Realizar una consulta donde se obtenga la media de las gratificaciones de los ponentes. */
SELECT codPonente, AVG(gratificacion) AS "Media de las gratificacion" 
FROM participar
GROUP BY codPonente;

/* Realizar una consulta que muestre el total de salas distintas en funci�n del turno: de 
ma�ana (M) o tarde (T). */
SELECT turno, COUNT(sala) AS "Salas segun turno"
FROM conferencia
GROUP BY turno;

/* Repetir el ejercicio anterior teniendo en cuanta que la sala �Apolo� no debe salir 
en el resultado final. */
SELECT turno, COUNT(sala) AS "Salas segun turno"
FROM conferencia
WHERE sala NOT LIKE "Apolo"
GROUP BY turno;

/* Repetir el ejercicio anterior de forma que se muestre el total del turno de ma�ana (M). */
SELECT COUNT(turno) AS "Turnos de ma�ana", COUNT(sala) AS "Salas segun turno" 
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
valor de empresa NULL se agrupen en una categor�a llamada "Sin empresa asignada". */
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
/* Realizar una consulta donde se obtenga el nombre de los ponentes junto a la 
referencia y el tema de las conferencias en las que han participado. */
SELECT P.nombre, C.referencia, C.tema
FROM ponente AS P
JOIN participar AS par ON (P.codigo = par.codPonente)
JOIN conferencia AS C ON (par.refConferencia = C.referencia);

/* Realizar una consulta que obtenga un listado con el nombre y apellidos de 
los asistentes que hayan asistido a la conferencia con referencia �PWB1314�. */
SELECT A.nombre, CONCAT(A.apellido1, " ", A.apellido2) AS apellidos 
FROM asistente AS A
JOIN asistir AS asi ON (A.codigo = asi.codAsistente)
JOIN conferencia AS C ON (C.referencia = asi.refConferencia)
WHERE C.referencia LIKE "PWB1314";

/* Realizar una consulta que muestre el n�mero de asistentes a cada una de las conferencias. */
SELECT C.tema, COUNT(A.codigo) AS "Numero de asistentes" 
FROM asistente AS A
JOIN asistir AS asi ON (A.codigo = asi.codAsistente)
JOIN conferencia AS C ON (C.referencia = asi.refConferencia)
GROUP BY C.tema;

/* Realizar una consulta que muestre la sala donde cada ponente realiza su conferencia. 
La consulta adem�s de los datos del ponente debe mostrar el nombre de la sala, el tema 
de la conferencia y el orden de intervenci�n. Los resultados se deben ordenar por el 
tema y el orden de intervenci�n. */
SELECT P.nombre, CONCAT(P.apellido1, " ", P.apellido2) AS apellidos, C.sala, C.tema, par.numOrden 
FROM ponente AS P
JOIN participar AS par ON (P.codigo = par.codPonente)
JOIN conferencia AS C ON (C.referencia = par.refConferencia)
ORDER BY C.tema, par.numOrden;

/* Realizar una consulta que muestre el total de asistentes por conferencia y sala.
El resultado se debe ordenar por el n�mero de asistentes. */
SELECT COUNT(asi.refConferencia) AS "Numero de asistentes"
FROM asistente AS A
JOIN asistir AS asi ON (A.codigo = asi.codAsistente)
JOIN conferencia AS C ON (C.referencia = asi.refConferencia)
GROUP BY asi.refConferencia;

/* Realizar una consulta que muestre los distintos ponentes que han utilizado la sala �Afrodita�. */
SELECT P.nombre, CONCAT(P.apellido1, " ", P.apellido2) AS apellidos 
FROM ponente AS P
JOIN participar AS par ON (P.codigo = par.codPonente)
JOIN conferencia AS C ON (C.referencia = par.refConferencia)
WHERE C.sala LIKE "Afrodita";

-- Tarea pag 30
USE conferencias;
/* Realizar una consulta que seleccione los ponentes cuyo primer apellido sea igual al primer 
apellido del asistente de menor edad. */
SELECT apellido1 FROM ponente
WHERE apellido1 = (SELECT apellido1 FROM asistente
WHERE fechaNac = (SELECT MAX(fechaNac) FROM asistente)); 

/* Realizar una consulta (utilizando subconsultas) que obtenga los distintos ponentes que 
han usado la sala �Afrodita� para dar una conferencia. */
SELECT P.codigo, P.nombre, CONCAT(P.apellido1, " ", P.apellido2) AS apellidos
FROM ponente AS P JOIN participar AS par ON (P.codigo = par.codPonente)
WHERE par.refConferencia = ANY (SELECT referencia FROM conferencia AS C WHERE C.sala LIKE "Afrodita");

/* Realizar una consulta que muestre los asistentes de la empresa �BigSoft� que asisten 
a algunas de las sesiones de la conferencia sobre �Programaci�n Web�. */
SELECT A.codigo, A.nombre, CONCAT(A.apellido1, " ", A.apellido2) AS apellidos  
FROM asistente AS A JOIN asistir AS asi ON (A.codigo = asi.codAsistente)
WHERE A.empresa LIKE "Bigsoft" AND asi.refConferencia = ANY 
(SELECT referencia FROM conferencia AS C WHERE C.tema LIKE "Programaci�n Web");

/* Realizar una consulta que muestre los asistentes que sean hombres y hayan nacido antes 
del �01/01/1985�, y adem�s hayan asistido a una conferencia sobre �Programaci�n Web�. */
SELECT A.codigo, A.nombre, CONCAT(A.apellido1, " ", A.apellido2) AS apellidos, A.fechaNac 
FROM asistente AS A JOIN asistir AS asi ON (A.codigo = asi.codAsistente)
WHERE A.sexo LIKE "H" AND fechaNac <= "1985-01-01" AND asi.refConferencia = ANY 
(SELECT referencia FROM conferencia AS C WHERE C.tema LIKE "Programaci�n Web");

/* Realizar una consulta que muestre el total de gratificaciones recibidas por cada uno 
de los ponentes. */
SELECT nombre, CONCAT(apellido1, " ", apellido2) AS apellidos FROM ponente
WHERE codigo IN (SELECT codPonente FROM participar 
WHERE gratificacion = (SELECT SUM(gratificacion) FROM participar));

/* Realizar una consulta que muestre los asistentes a cada una de las conferencias que 
se celebran el d�a �02/10/2013�. El resultado debe mostrarse ordenado por el tema de la 
conferencia, as� como por los apellidos y nombre de los asistentes. */
SELECT C.tema, A.nombre, CONCAT(A.apellido1, " ", A.apellido2) AS apellidos  
FROM asistente AS A JOIN asistir AS asi ON (A.codigo = asi.codAsistente)
JOIN conferencia AS C ON (asi.refConferencia  = C.referencia)
WHERE asi.refConferencia = ANY (SELECT referencia FROM conferencia AS C 
WHERE C.fecha = "2013-10-02" ORDER BY C.tema, apellido1, apellido2, nombre);
