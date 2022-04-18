# Realizar una consulta que calcule la suma, resta, producto y división de 
los números 10 y 5 respectivamente.


# Repetir la consulta del ejercicio anterior asignando un alias a las cuatro 
operaciones.


# Realizar una consulta que muestre el nombre y los apellidos de los asistentes 
cuya empresa sea “BK Programación”.
SELECT nombre, CONCAT(apellido1, " ", apellido2) AS apellidos
FROM asistente 
WHERE empresa = "BK Programaciòn"; 

# Realizar una consulta que muestre el nombre y capacidad de las salas, ordenada 
de mayor a menor capacidad.
SELECT nombre, capacidad
FROM sala
ORDER BY capacidad DESC;

# Realizar una consulta donde se obtenga toda la información de los asistentes de 
la empresa “BigSoft” ordenados por la fecha de nacimiento de forma descendente.
SELECT * 
FROM asistente 
WHERE empresa = "BigSoft"
ORDER BY fechaNac DESC;

# Realizar una consulta que muestre el total de asistentes por empresa (ver 
ejemplo punto 2.4).
SELECT empresa, COUNT(*) asistentes 
FROM asistente
GROUP BY empresa;

# Realizar una consulta que muestre el nombre y los apellidos de los primeros 
cinco asistentes, el resultado debe mostrarse ordenado por el primer apellido 
de forma ascendente.
SELECT nombre, CONCAT(apellido1, " ", apellido2) AS apellidos
FROM asistente
LIMIT 0, 5
ORDER BY apellido1 ASC;



