USE conferencias2;
-- Ejercicio 1
SELECT nombre, CONCAT(apellido1, " ", apellido2) AS apellidos  
FROM asistente WHERE empresa LIKE "ProgConsulting" OR empresa LIKE "BK Programacion"
AND sexo LIKE "M" AND fechaNac BETWEEN "19730101" AND "19901231"
ORDER BY apellido1, apellido2 DESC;

-- Ejercicio 2
SELECT CONCAT(nombre, " ", apellido1, " ", apellido2) AS nombre, 
DATE_FORMAT(fechaNac, "%d-%m-%Y") AS fechaNac, IFNULL(empresa, "Busco empresa") AS empresa 
FROM asistente WHERE apellido1 LIKE "__r%" OR apellido1 LIKE "__s%"
ORDER BY fechaNac;

-- Ejercicio 3
SELECT CONCAT(nombre, "_", apellido1, "_", IFNULL(apellido2, " ")) AS nombre 
FROM ponente ORDER BY apellido1 LIMIT 3, 4;

-- Ejercicio 4
SELECT idAsistente, nombre, CONCAT(apellido1, " ", IFNULL(apellido2, " "))AS apellidos 
FROM asistente WHERE apellido1 = ANY (SELECT apellido1 FROM ponente)
ORDER BY apellido1, apellido2, nombre;

-- Ejercicio 5
SELECT C.tema, ROUND(C.precio * 10.5) AS precio, DATE_FORMAT(fecha, "%d-%m-%Y") AS fecha,
S.nombreSala, S.capacidad FROM conferencia AS C JOIN sala AS S ON (C.nombreSala = S.nombreSala)
WHERE turno LIKE "T" ORDER BY fecha ASC;

-- Ejercicio 6


-- Ejercicio 7
SELECT DISTINCT S.nombreSala, P.nombre, CONCAT(P.apellido1, " ", IFNULL(P.apellido2, " "))
AS apellidos FROM sala AS S LEFT JOIN conferencia AS C ON (S.nombreSala = C.nombreSala)
LEFT JOIN participa AS par ON (C.idConferencia = par.idConferencia)
LEFT JOIN ponente AS P ON (par.idPonente = P.idPonente) ORDER BY S.nombreSala, apellidos, P.nombre;

-- Ejercicio 8
SELECT C.tema  FROM conferencia AS C JOIN asiste AS asi ON (C.idConferencia = asi.idConferencia)
JOIN asistente AS A ON (asi.idAsistente = A.idAsistente) 
WHERE A.fechaNac = (SELECT MIN(fechaNac) FROM asistente) ORDER BY C.tema ASC;