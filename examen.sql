USE conferencias2;
-- Ejercicio 1
SELECT nombre, CONCAT(apellido1, " ", apellido2) AS apellidos
FROM asistente WHERE (empresa LIKE "Bigsoft") OR (empresa LIKE "BK Programacion")
AND (sexo LIKE "H") AND (fechaNac BETWEEN "1970-01-01" AND "1990-12-31")
ORDER BY fechaNac;

-- Ejercicio 2
SELECT CONCAT(nombre, " ", apellido1, " ", apellido2) AS nombre, 
DATE_FORMAT(fechaNac, "%d-%m-%Y") AS fecha, IFNULL(empresa, "No business") AS empresa  
FROM asistente WHERE nombre LIKE "__r%" ORDER BY fechaNac;

-- Ejercicio 3
SELECT CONCAT(nombre, " ", apellido1, " ", IFNULL(apellido2, " ")) AS nombre 
FROM ponente ORDER BY apellido1 LIMIT 0, 6;

-- Ejercciio 4
SELECT idAsistente AS identificador, nombre, CONCAT(apellido1, " ", IFNULL(apellido2, " ")) 
AS apellidos  FROM asistente UNION SELECT idPonente AS identificador, nombre, 
CONCAT(apellido1, " ", IFNULL(apellido2, " ")) AS apellidos FROM ponente
ORDER BY apellidos, nombre;

-- Ejercicio 5
SELECT C.tema, ROUND(C.precio * 10.5) AS precio, DATE_FORMAT(fecha, "%d-%m-$Y") AS fecha,
S.nombreSala, S.capacidad FROM conferencia AS C JOIN sala AS S ON (C.nombreSala = S.nombreSala)
WHERE C.turno LIKE "T" ORDER BY fecha;

-- Ejercicio 6
SELECT A.nombre, A.apellido1, A.apellido2, SUM(C.precio) AS precio
FROM asistente AS A JOIN asiste AS asi ON (A.idAsistente = asi.idAsistente)
JOIN conferencia AS C ON (asi.idConferencia = C.idConferencia)
GROUP BY A.nombre, A.apellido1, A.apellido2 HAVING precio >= 45 ORDER BY precio DESC;

-- Ejercicio 7
SELECT DISTINCT S.nombreSala, CONCAT(P.apellido1, " ", IFNULL(P.apellido2, " "), P.nombre) 
AS nombre FROM sala AS S LEFT JOIN conferencia AS C ON (S.nombreSala = C.nombreSala)
LEFT JOIN participa AS par ON (C.idConferencia = par.idConferencia)
LEFT JOIN ponente AS P ON (par.idPonente = P.idPonente) 
ORDER BY S.nombreSala, nombre ASC;

-- eJERCICIO 8
SELECT tema FROM conferencia WHERE turno LIKE "T" AND precio < (SELECT MIN(precio) 
FROM conferencia WHERE turno LIKE "M") ORDER BY tema ASC; 










