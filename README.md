# SQL

# Tabla de contenidos
- [Bases de datos](#bases-de-datos)
  - [Gestion de tablas](#tablas)
  - [Modificaciones en BD](#modificaciones)
  - [Campos de una tabla y tipos de datos](#campos-de-una-tabla-y-tipos-de-datos)
  - [Registros de una tabla](#registros-de-una-tabla)
  - [Index o indices](#los-index-o-indices)
- [Consultas](#consultas)
  - [Funciones de busqueda con WHERE](#funciones-de-buquedas-con-where)
  - [Funciones numericas](#funciones-numericas)
  - [Funciones de cadenas de caracteres](#funciones-de-cadenas-de-caracteres)
  - [Funciones con fechas](#funciones-de-manejo-de-fechas)
  - [Consultas multitabla JOIN](#consulta-multitabla-join)
  - [Subconsultas](#subconsultas)
  - [Las vistas](#las-vistas)

# Bases de datos
Para mostrar todas las bases de datos
```sql
SHOW DATABASES;
```
Para crear una base de datos, con CHARSET ponemos el cotejamiento
```sql
CREATE DATABASE jose;
```
```sql
CREATE DATABASE jose CHARSET utf8mb4;
```
Para eliminar una base de datos, IF EXISTS borra la base de datos si existe
```sql
DROP DATABASE jose;
```
```sql
DROP DATABASE IF EXISTS jose;
```
Con USE indicamos la base de datos que queremos usar
```sql
USE jose;
```
Un ejemplo de creacion de una base de datos seria el siguiente
```sql
DROP DATABASE IF EXISTS jose;
CREATE DATABASE jose CHARSET utf8mb4;
USE jose;
```

## Tablas

Creando una tabla, las tablas no pueden ir vacias
```sql
CREATE TABLE prueba (
    nombre VARCHAR(50),
    edad int(15)
);
```
Para mostrar las tablas que tiene una base de datos
```sql
SHOW TABLES;
```
Para ver el contenido de una tabla concreta
```sql
DESCRIBE prueba;
```
Borrando una tabla
```sql
DROP TABLE prueba;
```

## Modificaciones
Para añadir un campo a una tabla ya existente usamos ALTER TABLE ADD 
```sql
ALTER TABLE productos ADD precio INT UNSIGNED NOT NULL;
```
Para borrar un campo a una tabla ya existente usamos ALTER TABLE DROP 
```sql
ALTER TABLE productos DROP precio, DROP cantidad;
```
Para modificar el campo de una tabla usamos ALTER TABLE MODIFY
```sql
ALTER TABLE productos MODIFY nombre VARCHAR(100) NOT NULL;
```
Para cambiarle el nombre a un campo usamos ALTER TABLE CHANGE
```sql
ALTER TABLE productos CHANGE precio stock INT;
```
Para agregar una PRIMARY KEY a un campo ya existente
```sql
ALTER TABLE productos ADD PRIMARY KEY(id);
ALTER TABLE productos MODIFY id INT UNSIGNED AUTO_INCREMENT NOT NULL;
```
Para eliminar un PRIMARY KEY debemos quitar el AUTO_INCREMENT
```sql
ALTER TABLE productos MODIFY id INT UNSIGNED;
ALTER TABLE productos DROP PRIMARY KEY;
```
Para agregar y eliminar un indice a una tabla existente
```sql
ALTER TABLE productos ADD INDEX i_preciocantida (precio);
ALTER TABLE productos DROP INDEX i_preciocantida;
```
Para cambiarle el nombre a una tabla usamos ALTER TABLE RENAME o RENAME TABLE
```sql
ALTER TABLE productos RENAME cliente;
```
```sql
RENAME TABLE cliente TO productos;
```

## Campos de una tabla y tipos de datos
Las claves primarias PRIMARY KEY, las claves primarias sno admiten nulos y se pueden poner de dos formas 
```sql
CREATE TABLE prueba (
    DNI VARCHAR(9) PRIMARY KEY
);
```
```sql
CREATE TABLE prueba (
    DNI VARCHAR(9), 
    PRIMARY KEY(DNI)
);
```
Con AUTO_INCREMENT indicamos una clave que va aumetando su valor 
```sql
CREATE TABLE prueba (
    id INT AUTO_INCREMENT PRIMARY KEY
);
```
Con UNSIGNED recibe valores numericos positivos
```sql
CREATE TABLE prueba (
    id INT UNSIGNED NOT NULL PRIMARY KEY
);
```
Con DEFAULT asignamos un valor por defecto
```sql
CREATE TABLE prueba (
    edad INT DEFAULT 18
);
```
En los tipos de datos tenemos: enteros INT, decimales DOUBLE, caracteres CHAR, cedanas de texto  VARCHAR, para mas texto TEXT, fecha DATE en formato "AAAA-MM-DD", fecha y hora "AAAA-MM-DD HH-MM-SS" DATETIME, hora "HH-MM-SS" TIME
```sql
CREATE TABLE prueba (
    enteros INT,
    decimales DOUBLE,
    caracteres CHAR,
    cadena VARCHAR,
    texto TEXT,
    fecha DATE,
    fecha_hora DATETIME,
    hora TIME,
);
```

## Registros de una tabla
Para insertar registros en una tabla se puede hacer de dos formas
```sql
INSERT INTO alumnos(nombre, apellido, direccion, telefono, edad) VALUES("Jose", "Almiron Lopez", "direccion", "674853860", 22);
```
```sql
INSERT INTO alumnos VALUES("Inma", "Almiron Lopez", "direccion", "666666666", 26);
```
tambien podemos insertar elementos concretos como solo el nombre
```sql
INSERT INTO alumnos(nombre) VALUES("Luna");
```
Para borrar todos los registros de una tabla, podemos usar TRUNCATE o DELETE, aunque es mejor usar TRUNCATE, podemos borrar un registro concreto usando WHERE
```sql
TRUNCATE TABLE alumnos;
```
```sql
DELETE FROM alumnos;
```
```sql
DELETE FROM alumnos WHERE nombre = "Jose";
```
Para actualizar un registro de la tabla usamos UPDATE, si no especificamos ningun registro xcon el WHERE se modificaran la edad de todos los registros
```sql
UPDATE alumnos SET edad = 14 WHERE nombre = "Luna"
```

## Los Index o indices
Para mostrar los indices de una tabla usamos SHOW INDEX y con FROM indicamos la tabla
```sql
SHOW index 
FROM libro;
```
Por defecto tenemos un index que seria la PRIMARY KEY, en este caso añadimos dos indices mas para el autor y la editorial, se ponen NOT NULL y con INDEX especificamos un nombre y los campos
```sql
CREATE TABLE IF NOT EXISTS libros(
    id INT UNSIGNED AUTO_INCREMENT NOT NULL,
    titulo VARCHAR(100),
    autor VARCHAR(50) NOT NULL,
    descripcion TEXT,
    editorial VARCHAR(15) NOT NULL,
    PRIMARY KEY(id),
    INDEX i_autoreditorial (autor, editorial)
);
```
Para eliminar un indice usamos DROP ponemos el nombre del indice y con ON indicamos la tabla
```sql
DROP INDEX
i_autoreditorial ON libros;
```
Agregando un indice a una tabla ya existente, usamos CREATE con ON indicamos la tabla y entre parenteis el campo al que se le asigna el index
```sql
CREATE INDEX 
i_editorial ON libros (editorial);
```

# Consultas
Con SELECT mostramos los datos y con FROM indicamos a que tabla pertenecen
```sql
SELECT * 
FROM alumnos;
```
```sql
SELECT nombre, telefono, edad 
FROM alumnos;
```
Con WHERE indicamos un valor a buscar, como mostrar todos los campos de la tabla alumnos 'donde' edad sea 22, podemos usar opeadores como el AND, OR, NOT para una busqueda mas especifica
```sql
SELECT * 
FROM alumnos 
WHERE edad = 22;
```
Con ORDER BY podemos ordenar la salida de la consulta medinate un parametro como la cantidad o el precio, podemos ordenar por orden ASC ascendente (de menor a mayor) o por orden DESC desxcendente (de mayor a menor)
```sql
SELECT nombre, precio, cantidad 
FROM productos 
ORDER BY cantidad DESC;
```
Con GROUP BY agrupamos registros 
```sql
SELECT proveedor, COUNT(*) AS cantidad
FROM productos
GROUP BY proveedor;
```
Con DISTINCT omitimos los valores duplicados 
```sql
SELECT DISTINCT proveedor 
FROM productos;
```
Con IFNULL() manejamos los valores nulos, cambiando su valor en la consulta para ue no salga NULL, por ejemplo si un aistente no tiene empresa que ponga "Sin empresa" en vez de NULL
```sql
SELECT IFNULL(empresa, "Sin empresa")
FROM asistente;
```
Con COUNT() podemos contar registros
```sql
SELECT COUNT(*) AS proveedor
FROM productos
WHERE proveedor = "HP";
```

## Funciones de buquedas con WHERE
Con IN tambien hacemos mas sencillas las consultas buscando el proveedor y una cadena 
```sql
SELECT * 
FROM productos 
WHERE proveedor IN ('HP', 'La mejor laptop');
```
Con LIKE podemos buscar algun dato de un registro como los nombres que empiecen por L usando el % "L%" o podemos buscar un registro que contenada una cadena o una letra "%aptop%", NOT Invierte la busqueda
```sql
SELECT *
FROM productos
WHERE nombre LIKE "L%"; 
```
```sql
SELECT *
FROM productos
WHERE nombre LIKE "%aptop%"; 
```
Con BETWEEN podemos buscar valores que esten entre un rango en vez de poner "WHERE (precio >= 20) AND (precio <= 40)", con BETWEEN es mas sencillo, con NOT invertimos la accion
```sql
SELECT *
FROM productos
WHERE precio BETWEEN 20 AND 40; 
```

## Funciones numericas
Podemos realizar operaciones en los campos ha mostrar
```sql
SELECT nombre, precio, cantidad, precio * cantidad 
FROM productos;
```
Con SUM() podemos sumar valores, con MAX() buscamos el valor mas alto, con MIN() buscamos el valor mas pequeño
```sql
SELECT SUM(cantidad) AS suma
FROM productos;
```
Con CEIL() redoondeamos un numero al entero superior mas cercano
```sql
SELECT precio, CEIL(precio)
FROM conferencia;
```
Con FLOOR() redoondeamos un numero al entero menor mas cercano
```sql
SELECT precio, FLOOR(precio)
FROM conferencia;
```
Con POWER() elevamos un componente al valor indicado
```sql
SELECT precio, POWER(precio, 2)
FROM conferencia;
```
Con ROUND() redondea el numero n al siguiente numero con el numero de decimales que se
indican
```sql
SELECT ROUND(12.123456789, 4);
```
Con SQRT() realizamos la raiz cuadrada de un numero
```sql
SELECT SQRT(25);
```

## Funciones de cadenas de caracteres

#### Con CONCAT() podemos concatenar cadenas de texto
```sql
SELECT CONCAT("HOLA", " ", "MUNDO");
```
#### Con LOWER() pasamos la cadena a minusculas
```sql
SELECT LOWER(nombre) 
FROM asistente;
```
#### Con UPPER() pasamos la cadena a mayusculas
```sql
SELECT UPPER(nombre) 
FROM asistente;
```
#### Con RPAD rellenamos con una cadena a la izquierda y con LPAD a la derecha, rellenamos un numero de caracteres 
```sql
SELECT RPAD(nombre, 10, "-") 
FROM asistente;
```
> Mario-----  
Carmen----  
Felipe----  
#### Con REPLACE() reemplazamos un valor por otro
```sql
SELECT REPLACE(nombre, "José", "Pepe") 
FROM asistente;
```
#### Con LENGTH nos muestra la longitud de una cadena
```sql
SELECT LENGTH("HOLA MUNDO");
```
#### Con TRIM() nos quita los espacios en blanco del principio y del final, con LTRIM() elimina los espacios a la izquierda y con RTRIM() elimina los espacios a la derecha
```sql
SELECT TRIM("      HOLA MUNDO      ");
```

## Funciones de manejo de fechas

Con NOW() obtenemos la fecha y hora actuales
```sql
SELECT NOW();
```
Con CURDATE() nos devuelve la fecha actual en formato de cadena
```sql
SELECT CURDATE();
```
Con DATEDIFF() obtenemos dos fechas y se restan, para ver cuantos dias han pasado 
```sql
SELECT nombre, CONCAT(apellido1, " ", apellido2) AS apellidos,
DATEDIFF(NOW(), fechaNac) AS "dias vividos" 
FROM asistente;
```
Con DATE_FORMAT() le damos formato a una fecha
```sql
SELECT DATE_FORMAT(fecha, "%d-%m-%Y") AS fecha
FROM conferencia;
```
Con DAY() obtenemos el dia del mes de una fecha
```sql
SELECT DAY(NOW());
```
Con DAYOFWEEK() obtenemos el numero de dia de la semana
```sql
SELECT DAYOFWEEK(NOW());
```
Con DAYOFYEAR() obtenemos el numero de dia del año 
```sql
SELECT DAYOFYEAR(NOW());
```
Con WEEKOFYEAR obtenemos el numero de semana
```sql
SELECT WEEKOFYEAR(NOW());
```

## Consulta multitabla JOIN 
Con JOIN hacemos la conexion a otra tabla con ON conectamos la FOREIGN KEY con la PRIMARY KEY
```sql
SELECT p.nombre, p.descripcion, p.precio, pro.nombre 
FROM productos AS p
JOIN proveedor AS pro
ON p.proveedorid = pro.id;
```
Con LEFT JOIN leemos la tabla de izquierda a derecha
```sql
SELECT p.nombre, p.descripcion, p.precio, pro.nombre FROM productos AS p
LEFT JOIN proveedor AS pro
ON pro.id = p.proveedorid;
```
Con RIGHT JOIN leemos la tabla de derecha a izquierda
```sql
SELECT p.nombre, p.descripcion, p.precio, pro.nombre FROM productos AS p
RIGHT JOIN proveedor AS pro
ON pro.id = p.proveedorid;
```
Con INNER JOIN si hay datos que no coinciden con la otra tabla no los muestra
```sql
SELECT p.nombre, p.descripcion, p.precio, pro.nombre FROM proveedor AS pro
INNER JOIN productos AS p
ON pro.id=p.proveedorid;
```
Podemos hacer agrupameintos de dos tablas
```sql
SELECT pro.nombre, COUNT(p.proveedorid) AS 'Cantidad de Productos'
FROM proveedor AS pro
JOIN productos AS p
ON pro.id=p.proveedorid
GROUP BY pro.nombre;
```

## Subconsultas
Podemos realizar subconsultas de dos formas, realizandola en los campos del SELECT o en el WHERE para seleccionar un campo especifico
```sql
SELECT titulo, precio, precio - (SELECT MAX(precio) FROM libros) AS diferencia
FROM libros
ORDER BY diferencia;
```
```sql
SELECT titulo, autor, precio
FROM libros
WHERE precio = (SELECT MAX(precio) FROM libros);
```
En los operadores del WHERE podemos usar IN y NOT IN para buscar datos  
```sql
SELECT nombre
FROM editoriales
WHERE codigo IN (SELECT codigoeditorial FROM libros WHERE autor = "Richard Bach");
```
Los operadores ANY y ALL, con ANY compara con cualquier fila de la consulta, y con ALL compara con todas las filas de la consulta 
```sql
SELECT titulo FROM libros WHERE autor = "Borges" and codigoeditorial = ANY 
(SELECT e.codigo FROM editoriales AS e JOIN libros AS l ON codigoeditorial = e.codigo
WHERE l.autor = "Richard Bach");
```
Los operadores EXISTS y NOT EXISTS
```sql
SELECT cliente, numero FROM facturas AS f WHERE EXISTS
(SELECT * FROM detalles AS d WHERE f.numero = d.numerofactura AND d.articulo = 'lapiz');
```

## Las vistas
Para la creacion de una vista usamos CREATE VIEW
```sql
CREATE VIEW vista_empleado AS 
SELECT CONCAT(apellido, ' ', e.nombre) AS nombre, sexo, s.nombre AS seccion, cantidadhijos 
FROM empleados AS e JOIN secciones AS s ON codigo = seccion;
```
Para eliminar una vista
```sql
DROP VIEW IF EXISTS vista_empleado;
```