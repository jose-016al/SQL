# Aprendiendo SQL

## Bases de datos

#### Para mostrar todas las bases de datos
```sql
SHOW DATABASES;
```
#### Para crear una base de datos, con CHARSET ponemos el cotejamiento
```sql
CREATE DATABASE jose;
```
```sql
CREATE DATABASE jose CHARSET utf8mb4;
```
#### Para eliminar una base de datos, IF EXISTS borra la base de datos si existe
```sql
DROP DATABASE jose;
```
```sql
DROP DATABASE IF EXISTS jose;
```
#### Con USE indicamos la base de datos que queremos usar
```sql
USE jose;
```
#### Un ejemplo de creacion de una base de datos seria el siguiente
```sql
DROP DATABASE IF EXISTS jose;
CREATE DATABASE jose CHARSET utf8mb4;
USE jose;
```

## Tablas

#### Creando una tabla, las tablas no pueden ir vacias
```sql
CREATE TABLE prueba (
    nombre VARCHAR(50),
    edad int(15)
);
```
#### Para mostrar las tablas que tiene una base de datos
```sql
SHOW TABLES;
```
#### Para ver el contenido de una tabla concreta
```sql
DESCRIBE prueba;
```
#### Borrando una tabla
```sql
DROP TABLE prueba;
```

## Campos de una tabla y tipos de datos

#### Las claves primarias PRIMARY KEY, las claves primarias sno admiten nulos y se pueden poner de dos formas 
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
#### Con AUTO_INCREMENT indicamos una clave que va aumetando su valor 
```sql
CREATE TABLE prueba (
    id INT AUTO_INCREMENT PRIMARY KEY
);
```
#### Con UNSIGNED recibe valores numericos positivos
```sql
CREATE TABLE prueba (
    id INT UNSIGNED NOT NULL PRIMARY KEY
);
```
#### Con DEFAULT asignamos un valor por defecto
```sql
CREATE TABLE prueba (
    edad INT DEFAULT 18
);
```
#### En los tipos de datos tenemos: enteros INT, decimales DOUBLE, caracteres CHAR, cedanas de texto  VARCHAR, para mas texto TEXT, fecha DATE en formato "AAAA-MM-DD", fecha y hora "AAAA-MM-DD HH-MM-SS" DATETIME, hora "HH-MM-SS" TIME
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

#### Para insertar registros en una tabla se puede hacer de dos formas
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
#### Para borrar todos los registros de una tabla, podemos usar TRUNCATE o DELETE, aunque es mejor usar TRUNCATE, podemos borrar un registro concreto usando WHERE
```sql
TRUNCATE TABLE alumnos;
```
```sql
DELETE FROM alumnos;
```
```sql
DELETE FROM alumnos WHERE nombre = "Jose";
```
#### Para actualizar un registro de la tabla usamos UPDATE, si no especificamos ningun registro xcon el WHERE se modificaran la edad de todos los registros
```sql
UPDATE alumnos SET edad = 14 WHERE nombre = "Luna"
```

## Consultando datos de tablas 

#### Con SELECT mostramos los datos y con FROM indicamos a que tabla pertenecen
```sql
SELECT * 
FROM alumnos;
```
```sql
SELECT nombre, telefono, edad 
FROM alumnos;
```
#### Con WHERE indicamos un valor a buscar, como mostrar todos los campos de la tabla alumnos 'donde' edad sea 22, podemos usar opeadores como el AND, OR, NOT para una busqueda mas especifica
```sql
SELECT * 
FROM alumnos 
WHERE edad = 22;
```

## Funciones con consultas

#### Podemos realizar operaciones en los campos ha mostrar
```sql
SELECT nombre, precio, cantidad, precio * cantidad 
FROM productos;
```
#### Con CONCAT() podemos concatenar cadenas de texto
```sql
SELECT CONCAT("HOLA", " ", "MUNDO");
```
#### Con LENGTH nos muestra la longitud de una cadena
```sql
SELECT LENGTH("HOLA MUNDO");
```
#### Con TRIM() nos quita los espacios en blanco del principio y del final
```sql
SELECT TRIM("      HOLA MUNDO      ");
```
#### Con ORDER BY podemos ordenar la salida de la consulta medinate un parametro como la cantidad o el precio, podemos ordenar por orden ASC ascendente (de menor a mayor) o por orden DESC desxcendente (de mayor a menor)
```sql
SELECT nombre, precio, cantidad 
FROM productos 
ORDER BY cantidad DESC;
```
#### Con BETWEEN podemos buscar valores que esten entre un rango en vez de poner "WHERE (precio >= 20) AND (precio <= 40)", con BETWEEN es mas sencillo, con NOT invertimos la accion
```sql
SELECT *
FROM productos
WHERE precio BETWEEN 20 AND 40; 
```
#### Con IN tambien hacemos mas sencillas las consultas buscando el proveedor y una cadena 
```sql
SELECT * 
FROM productos 
WHERE proveedor IN ('HP', 'La mejor laptop');
```
#### Con LIKE podemos buscar algun dato de un registro como los nombres que empiecen por L, NOT Invierte la busqueda
```sql
SELECT *
FROM productos
WHERE nombre LIKE "L%"; 
```
#### Con COUNT() podemos contar registros
```sql
SELECT COUNT(*) AS proveedor
FROM productos
WHERE proveedor = "HP";
```
#### Con SUM() podemos sumar valores, con MAX() buscamos el valor mas alto, con MIN() buscamos el valor mas pequeño
```sql
SELECT SUM(cantidad) AS suma
FROM productos;
```
#### Con GROUP BY agrupamos registros 
```sql
SELECT proveedor, COUNT(*) AS cantidad
FROM productos
GROUP BY proveedor;
```
#### Con DISTINCT omitimos los valores duplicados 
```sql
SELECT DISTINCT proveedor 
FROM productos;
```

## Los Index o indices

#### Para mostrar los indices de una tabla usamos SHOW INDEX y con FROM indicamos la tabla
```sql
SHOW index 
FROM libro;
```
#### Por defecto tenemos un index que seria la PRIMARY KEY, en este caso añadimos dos indices mas para el autor y la editorial, se ponen NOT NULL y con INDEX especificamos un nombre y los campos
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
#### Para eliminar un indice usamos DROP ponemos el nombre del indice y con ON indicamos la tabla
```sql
DROP INDEX
i_autoreditorial ON libros;
```
#### Agregando un indice a una tabla ya existente, usamos CREATE con ON indicamos la tabla y entre parenteis el campo al que se le asigna el index
```sql
CREATE INDEX 
i_editorial ON libros (editorial);
```