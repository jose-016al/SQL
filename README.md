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
#### En los tipos de datos tenemos: enteros INT, decimales DOUBLE, caracteres CHAR, cedanas de texto  VARCHAR, fecha DATE en formato "AAAA-MM-DD", fecha y hora "AAAA-MM-DD HH-MM-SS" DATETIME, hora "HH-MM-SS" TIME
```sql
CREATE TABLE prueba (
    enteros INT,
    decimales DOUBLE,
    caracteres CHAR,
    cadena VARCHAR,
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
SELECT * FROM alumnos;
```
```sql
SELECT nombre, telefono, edad FROM alumnos;
```
#### Con WHERE indicamos un valor a buscar, como mostrar todos los campos de la tabla alumnos 'donde' edad sea 22
```sql
SELECT * FROM alumnos WHERE edad = 22;
```
#### 
```sql

```