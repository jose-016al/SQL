# SQL
# Índice
- [Introducción](#introducción)
- [Bases de datos](#bases-de-datos)
- [Tablas](#tablas)
	- [Campos](#campos)
	- [Creación](#creación)
	- [Restricciones](#restricciones)
		- [Primary Key](#primary-key)
		- [Foreign Key](#foreign-key)
	- [Modificadores](#modificadores)
- [DML](#dml)
	- [Inserción de datos](#inserción-de-datos)
	- [Actualización de datos](#actualización-de-datos)
	- [Eliminación de datos](#eliminación-de-datos)
	- [Consultas](#consultas)
	- [Consultas con WHERE](#consultas-con-where)
	- [Consultas de agrupamiento](#consultas-de-agrupamiento)
	- [Subconsultas](#subconsultas)
	- [Multitablas y joins](#multitablas-y-joins)
	- [Vistas](#vistas)
# Introducción
Una base de datos es un conjunto organizado de datos relacionados que se almacenan sistemáticamente para facilitar su acceso y uso. Para gestionar y trabajar con bases de datos, generalmente utilizamos un Sistema de Gestión de Bases de Datos (SGBD). Existen dos tipos principales de bases de datos: relacionales y no relacionales. En este caso, nos centraremos en SQL, que es un lenguaje utilizado para interactuar con bases de datos relacionales.

| Elemento  | Definición                                                                                                                                                                                                                                                                        |
| --------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Tabla     | Los datos se organizan en tablas, que consisten en filas y columnas. Cada fila representa un registro individual, y cada columna contiene un atributo o campo de datos específico.                                                                                                |
| Registros | Cada fila en una tabla se llama registro y contiene información relacionada. Por ejemplo, en una base de datos de empleados, un registro podría representar a un empleado en particular y contener información como su nombre, dirección, número de identificación, salario, etc. |
| Campos    | Las columnas en una tabla se llaman campos. Cada campo representa un tipo específico de información, como un nombre, una fecha o un número de teléfono.                                                                                                                           |

Para trabajar con bases de datos, como mencionamos anteriormente, utilizamos un Sistema de Gestión de Bases de Datos (SGBD), como MySQL o MariaDB. Podemos interactuar con estos sistemas a través de una interfaz gráfica, como phpMyAdmin, o mediante la interfaz de línea de comandos (CLI). En este último caso, basta con ejecutar el comando adecuado en una terminal para acceder y gestionar las bases de datos.
```bash
sudo mysql -u root
```
# Bases de datos
En esta primera sección, exploraremos los comandos básicos esenciales para trabajar con bases de datos.

| Comando                 | Definición                                                                                                 |
| ----------------------- | ---------------------------------------------------------------------------------------------------------- |
| `help`                  | Muestra una lista de los comandos disponibles en el SGBD y su descripción.                                 |
| `status`                | Proporciona información sobre la sesión actual, incluyendo el usuario conectado y la base de datos activa. |
| `create database blog;` | Crea una nueva base de datos llamada `blog`.                                                               |
| `show databases;`       | Muestra una lista de todas las bases de datos disponibles en el servidor.                                  |
| `use blog;`             | Selecciona la base de datos `blog` para trabajar con ella.                                                 |
| `show tables;`          | Muestra una lista de todas las tablas disponibles en la base de datos actualmente seleccionada.            |
| `drop database blog;`   | Elimina la base de datos `blog` junto con todos sus datos y estructuras.                                   |

Podemos añadir parámetros específicos a algunos comandos, como los de creación y eliminación de bases de datos, para personalizar su comportamiento. Por ejemplo, al eliminar una base de datos, podemos usar `IF EXISTS` para verificar su existencia antes de intentar eliminarla, evitando así errores durante la ejecución del script SQL. Asimismo, al crear una base de datos, podemos especificar una codificación particular que se ajuste a nuestras necesidades, asegurando una adecuada gestión de los caracteres almacenados.
```sql
DROP DATABASE IF EXISTS blog;
CREATE DATABASE blog CHARSET utf8mb4;
USE blog;
```
# Tablas
Comandos básicos para gestionar tablas

| Comando                | Descripción                                                                                         |
| ---------------------- | --------------------------------------------------------------------------------------------------- |
| `show tables;`         | Muestra una lista de todas las tablas disponibles en la base de datos actualmente seleccionada.     |
| `desc usuarios;`       | Muestra la estructura de la tabla `usuarios`, incluyendo sus columnas, tipos de datos, y atributos. |
| `drop table usuarios;` | Elimina la tabla `usuarios` de forma permanente, junto con todos los datos que contiene.            |
## Campos
Los campos representan los datos almacenados en cada columna de nuestra tabla. Al igual que en la programación, los campos pueden tener diferentes tipos de datos, dependiendo del tipo de información que deseen almacenar. Algunos de los tipos más comunes son:

| Tipo de dato | Definición                                                                                                 |
| ------------ | ---------------------------------------------------------------------------------------------------------- |
| `int`        | Tipo de dato numérico para almacenar números enteros de tamaño estándar.                                   |
| `integer`    | Sinónimo de `int`, utilizado para almacenar números enteros.                                               |
| `varchar`    | Tipo de dato de cadena de texto que permite almacenar textos de longitud variable, con un límite definido. |
| `char`       | Tipo de dato de cadena de texto que almacena textos de longitud fija.                                      |
| `float`      | Tipo de dato numérico para almacenar números con punto flotante (decimales).                               |
| `date`       | Almacena fechas en formato `YYYY-MM-DD`.                                                                   |
| `time`       | Almacena horas en formato `HH:MM:SS`.                                                                      |
| `datetime`   | Almacena fecha y hora en formato `YYYY-MM-DD HH:MM:SS`, con precisión de segundos.                         |
| `timestamp`  | Almacena fecha y hora en formato `YYYY-MM-DD HH:MM:SS`, generalmente utilizado para marcar eventos.        |
| `text`       | Tipo de dato para almacenar grandes cantidades de texto, hasta 65,535 caracteres.                          |
| `mediumtext` | Tipo de dato para almacenar textos más extensos, hasta 16,777,215 caracteres.                              |
| `longtext`   | Tipo de dato para almacenar textos muy largos, hasta 4,294,967,295 caracteres.                             |
## Creación
Para crear una tabla, utilizamos el comando `CREATE TABLE`, donde definimos su estructura especificando todos los campos relacionados con ella. Es fundamental asegurarse de haber seleccionado previamente una base de datos con el comando `USE` para que la tabla se cree en la base de datos deseada.
```sql
CREATE TABLE usuarios (  
    id int,
    nombre varchar(50),
    apellidos varchar(255),
    email varchar(100),
    password varchar(255)
);
```
## Restricciones
Las restricciones son reglas que aplicamos a las columnas de una tabla para garantizar la integridad y validación de los datos que se almacenan. A continuación, exploraremos algunas de las restricciones más comunes.

| Restricción      | Definición                                                                                                                         |
| ---------------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| `NOT NULL`       | Garantiza que una columna no puede contener valores nulos; es obligatorio proporcionar un valor.                                   |
| `NULL`           | Permite que una columna pueda contener valores nulos si no se proporciona un dato al insertar un registro.                         |
| `DEFAULT`        | Establece un valor por defecto para una columna si no se especifica uno al insertar un registro. Ejemplo: `DEFAULT 'por defecto'`. |
| `AUTO_INCREMENT` | Genera automáticamente un valor único y consecutivo para una columna, generalmente utilizada en claves primarias.                  |
| `UNSIGNED`       | Restringe una columna numérica para que solo almacene valores positivos.                                                           |
| `UNIQUE`         | Garantiza que todos los valores de una columna o combinación de columnas sean únicos, sin duplicados.                              |
```sql
CREATE TABLE usuarios (
    id int auto_increment not noll,
    nombre varchar(50) not null,
    apellidos varchar(255) default 'martin',
    email varchar(100) not null,
    password varchar(255)
);
```
La restricción `UNIQUE` permite garantizar que un valor en una columna, como el correo electrónico, no se repita. Esto asegura que no puedan existir dos usuarios con el mismo correo electrónico en la tabla, manteniendo la unicidad de los datos.
```sql
CREATE TABLE usuarios (
    # ---
    email varchar(100) not null,
    # ---
    CONSTRAINT uq_email UNIQUE(email)
);
```
### Primary Key
Una clave primaria es un campo o conjunto de campos en una tabla que tiene dos propósitos principales. En primer lugar, garantiza que cada registro en la tabla sea único, lo que evita duplicados. En segundo lugar, se utiliza para identificar de manera exclusiva cada registro en la tabla. Esto significa que proporciona una forma única de acceder a cada registro en la tabla sin ambigüedades.

En el contexto de las relaciones, la clave primaria de una tabla se utiliza para establecer vínculos con otras tablas. Cuando se crea una relación, la clave primaria de una tabla se convierte en la clave foránea en la tabla relacionada. Esto permite vincular registros en una tabla con registros en otra de manera coherente.
```sql
CREATE TABLE usuarios (
    id int auto_increment not noll,
    # ---
    CONSTRAINT pk_usuarios PRIMARY KEY(id)
);
```
### Foreign Key
Una clave foránea es un campo o conjunto de campos en una tabla que hace referencia a la clave primaria de otra tabla. Establece una relación entre las dos tablas al relacionar registros en una tabla con registros en la otra. La clave foránea actúa como un enlace o puente entre las tablas, permitiendo que los datos estén interconectados de manera significativa.

La clave foránea garantiza la integridad referencial, lo que significa que los datos en la tabla relacionada están vinculados de manera coherente a los datos en la tabla principal. Esto asegura que no se puedan crear relaciones huérfanas en la base de datos y que los datos relacionados se mantengan consistentes.
```sql
CREATE TABLE entradas (
    id int auto_increment not noll,  
    usuario_id int auto_increment not null,
    # ---
    CONSTRAINT pk_entradas PRIMARY KEY(id)
    CONSTRAINT fk_entrada_usuarios FOREIGN KEY(usuario_id) REFERENCE usuarios(id)
);
```
En la definición de una **Foreign Key** mediante `CONSTRAINT`, podemos agregar la cláusula `ON DELETE CASCADE` para especificar que si se elimina un registro en la tabla referenciada, los registros relacionados en la tabla actual también serán eliminados automáticamente.
## Modificadores
Es posible que ya tengamos una base de datos en funcionamiento con datos insertados, y surja la necesidad de añadir, eliminar o modificar un campo específico en las tablas o columnas. En estos casos, utilizamos el comando `ALTER`, que nos permite realizar cambios en la estructura de la base de datos sin afectar la información almacenada.
#### Podemos modificar el nombre de una tabla existente.
```sql
ALTER TABLE usuarios RENAME TO users;
```
#### Podemos renombrar una columna de una tabla.
```sql
ALTER TABLE users CHANGE apellidos surname VARCHAR(255) NOT NULL;
```
#### Podemos cambiar el tipo de dato de una columna.
```sql
ALTER TABLE users MODIFY surname CHAR(50) NOT NULL;
```
#### Podemos agregar una nueva columna a la tabla.
```sql
ALTER TABLE users ADD website VARCHAR(255) NULL;
```
#### Podemos eliminar una columna a la tabla.
```sql
ALTER TABLE users DROP website;
```
#### Podemos agregar restricciones a una columna existente.
```sql
ALTER TABLE users ADD CONSTRAINT uq_email UNIQUE(email);
```
# DML
El **Lenguaje de Manipulación de Datos** (DML, por sus siglas en inglés) es un conjunto de instrucciones proporcionadas por los sistemas gestores de bases de datos (SGBD) que permite a los usuarios realizar tareas de consulta, inserción, modificación y eliminación de los datos almacenados en las bases de datos gestionadas por el SGBD.
## Inserción de datos
Para agregar datos a una tabla, utilizamos la sentencia `INSERT INTO nombre_tabla`.
```sql
INSERT INTO usuarios VALUES(null, 'Jose', 'Almirón', 'jose@correo.com', 'password');
```
Si no queremos insertar todos los valores de la tabla, tenemos otra forma de hacerlo, especificando, después del nombre de la tabla, las columnas que deseamos rellenar.
```sql
INSERT INTO usuarios(email, password) VALUES('jose@correo.com', 'password');
```
## Actualización de datos
Para actualizar los datos de un registro, usamos la sentencia `UPDATE`. Sin embargo, lo recomendable en estos casos es usarla junto con la cláusula `WHERE`, ya que, de lo contrario, se modificarán todos los registros de la columna especificada. Normalmente, solo nos interesará modificar los registros que cumplan con una condición específica.
```sql
UPDATE usuarios SET nombre = usuario1 WHERE nombre = "Jose"
```
## Eliminación de datos
Para eliminar datos de un registro, usamos la sentencia `DELETE`. También podemos utilizar `TRUNCATE`, pero, al igual que en el caso de la actualización de datos, se recomienda usar `DELETE` junto con la cláusula `WHERE` para especificar qué registros deseamos eliminar.
```sql
DELETE FROM usuarios WHERE nombre = "Jose";
```
## Consultas
Para consultar los registros de una tabla, utilizamos la sentencia `SELECT`. Podemos especificar columnas concretas o mostrar todas utilizando `*`. Con la cláusula `FROM`, indicamos el nombre de la tabla de la que queremos obtener los datos.
```sql
SELECT nombre, email FROM usuarios;
```

| **Función**       | **Definición**                                                                                                                                        |
| ----------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
| **AS**            | Se utiliza para asignar un alias a una columna o tabla. Es útil para renombrar temporalmente una columna en los resultados de una consulta.           |
| **ISNULL**        | Es una función que verifica si un valor es nulo (NULL). Devuelve verdadero si el valor es NULL y falso si no lo es.                                   |
| **STRCMP**        | Compara dos cadenas de texto. Devuelve un valor negativo si la primera cadena es menor, positivo si es mayor, y cero si son iguales.                  |
| **DISTINCT**      | Se utiliza para eliminar duplicados en los resultados de una consulta. Solo muestra valores únicos de una columna o combinación de columnas.          |
| **IFNULL**        | Es una función que reemplaza un valor nulo por un valor especificado. Si el valor es NULL, devuelve el valor dado; si no, devuelve el valor original. |
| **LIMIT**         | Limita la cantidad de resultados devueltos por una consulta. Se usa para establecer un número máximo de filas a mostrar.                              |
| **COUNT**         | Función de agregación que devuelve el número de filas que cumplen con una condición o el número total de filas seleccionadas en una consulta.         |
| **ORDER BY DESC** | Ordena los resultados de una consulta en orden descendente. Se aplica a una columna específica para organizar los datos de mayor a menor.             |
| **ORDER BY ASC**  | Ordena los resultados de una consulta en orden ascendente (por defecto). Organiza los datos de menor a mayor.                                         |
### Funciones matemáticas 

| **Función**  | **Definición**                                                                                                           |
| ------------ | ------------------------------------------------------------------------------------------------------------------------ |
| **ABS**      | Devuelve el valor absoluto de un número, es decir, convierte cualquier valor negativo en positivo.                       |
| **CEIL**     | Redondea un número hacia arriba al entero más cercano, independientemente de su parte decimal.                           |
| **FLOOR**    | Redondea un número hacia abajo al entero más cercano, es decir, elimina la parte decimal.                                |
| **RAND**     | Genera un número decimal aleatorio entre 0 y 1. Se puede usar para obtener valores aleatorios en cálculos o selecciones. |
| **ROUND**    | Redondea un número a una cantidad especificada de decimales. Si no se especifica, redondea al entero más cercano.        |
| **SQRT**     | Devuelve la raíz cuadrada de un número. Si el número es negativo, la función devolverá NULL.                             |
| **TRUNCATE** | Elimina la parte decimal de un número sin redondearlo. Solo se conserva la parte entera del número.                      |
| **POWER**    | Devuelve el resultado de elevar un número a una potencia especificada. La sintaxis es `POWER(base, exponente)`.          |
### Funciones de cadena

| **Función** | **Definición**                                                                                                                                                     |
| ----------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **UPPER**   | Convierte todos los caracteres de una cadena a mayúsculas.                                                                                                         |
| **LOWER**   | Convierte todos los caracteres de una cadena a minúsculas.                                                                                                         |
| **CONCAT**  | Une dos o más cadenas de texto en una sola. Por ejemplo, `CONCAT('Hola', ' ', 'Mundo')` devolvería `'Hola Mundo'`.                                                 |
| **LENGTH**  | Devuelve la longitud de una cadena de texto, es decir, el número de caracteres que contiene.                                                                       |
| **TRIM**    | Elimina los espacios en blanco al principio y al final de una cadena.                                                                                              |
| **RTRIM**   | Elimina los espacios en blanco solo al final de una cadena de texto.                                                                                               |
| **LTRIM**   | Elimina los espacios en blanco solo al principio de una cadena de texto.                                                                                           |
| **RPAD**    | Rellena una cadena a la derecha con un valor específico hasta alcanzar una longitud determinada.                                                                   |
| **LPAD**    | Rellena una cadena a la izquierda con un valor específico hasta alcanzar una longitud determinada.                                                                 |
| **REPLACE** | Reemplaza todas las ocurrencias de un substring por otro en una cadena de texto. Por ejemplo, `REPLACE('Hola Mundo', 'Mundo', 'Amigo')` devolvería `'Hola Amigo'`. |
### Funciones de fechas

|**Función**|**Definición**|
|---|---|
|**CURDATE**|Devuelve la fecha actual del sistema en formato `YYYY-MM-DD`, sin la hora.|
|**DATEDIFF**|Calcula la diferencia en días entre dos fechas. La sintaxis es `DATEDIFF(fecha1, fecha2)`, y devuelve el número de días entre las dos fechas.|
|**DAYNAME**|Devuelve el nombre del día de la semana correspondiente a una fecha (por ejemplo, 'Monday', 'Tuesday').|
|**DAYOFMONTH**|Devuelve el día del mes (1-31) de una fecha dada.|
|**DAYOFWEEK**|Devuelve el día de la semana como un número (1 = Domingo, 2 = Lunes, etc.).|
|**DAYOFYEAR**|Devuelve el número de día del año (1-366) correspondiente a una fecha dada.|
|**MONTH**|Devuelve el mes (1-12) correspondiente a una fecha dada.|
|**YEAR**|Devuelve el año (en formato de 4 dígitos) correspondiente a una fecha dada.|
|**DAY**|Devuelve el día del mes (1-31) correspondiente a una fecha dada, equivalente a `DAYOFMONTH`.|
|**HOUR**|Devuelve la hora (0-23) correspondiente a una fecha o hora dada.|
|**CURTIME**|Devuelve la hora actual del sistema en formato `HH:MM:SS`.|
|**SYSDATE**|Devuelve la fecha y hora actual del sistema con precisión de segundos (varía dependiendo del sistema).|
|**DATE_FORMAT**|Permite formatear una fecha según un patrón específico. Ejemplo: `DATE_FORMAT(fecha, '%Y-%m-%d')` devuelve la fecha en el formato `YYYY-MM-DD`.|
|**NOW**|Devuelve la fecha y hora actuales del sistema en formato `YYYY-MM-DD HH:MM:SS`.|
|**WEEKOFYEAR**|Devuelve el número de la semana del año correspondiente a una fecha dada (1-52).|
## Consultas con WHERE
El `WHERE` sería el equivalente a un `WHILE` en programación, es decir, mientras se cumpla una condición, se mostrarán los datos que coincidan con esa condición.
```sql
SELECT nombre, email FROM usuarios WHERE nombre = "Jose";
```
Al igual que en cualquier lenguaje de programación, también contamos con operadores de comparación que podemos utilizar junto con la cláusula `WHERE`.

|**Operador**|**Definición**|
|---|---|
|**=**|Compara dos valores y devuelve verdadero si son iguales.|
|**!=**|Compara dos valores y devuelve verdadero si no son iguales. También puede usarse como `<>`.|
|**>**|Compara dos valores y devuelve verdadero si el valor de la izquierda es mayor que el de la derecha.|
|**<**|Compara dos valores y devuelve verdadero si el valor de la izquierda es menor que el de la derecha.|
|**>=**|Compara dos valores y devuelve verdadero si el valor de la izquierda es mayor o igual que el de la derecha.|
|**<=**|Compara dos valores y devuelve verdadero si el valor de la izquierda es menor o igual que el de la derecha.|
|**BETWEEN**|Selecciona valores dentro de un rango especificado. Se usa para comparar un valor con un rango de valores (por ejemplo, `BETWEEN 10 AND 20`).|
|**IN**|Comprueba si un valor coincide con cualquiera de los valores dentro de un conjunto de valores especificados. (Por ejemplo, `IN (1, 2, 3)`).|
|**IS NULL**|Comprueba si un valor es `NULL`. Devuelve verdadero si el valor es `NULL`.|
|**IS NOT NULL**|Comprueba si un valor no es `NULL`. Devuelve verdadero si el valor no es `NULL`.|
|**LIKE**|Compara una cadena con un patrón especificado. Se usan comodines como `%` (cualquier secuencia de caracteres) o `_` (un solo carácter).|
|**NOT LIKE**|Compara una cadena con un patrón y devuelve verdadero si no hay coincidencia.|
|**OR**|Operador lógico que devuelve verdadero si al menos una de las condiciones es verdadera.|
|**AND**|Operador lógico que devuelve verdadero solo si ambas condiciones son verdaderas.|
|**NOT**|Operador lógico que invierte el resultado de una condición.|
|**%**|Comodín utilizado en la cláusula `LIKE` para representar cero o más caracteres en una cadena.|
|**_**|Comodín utilizado en la cláusula `LIKE` para representar un solo carácter en una cadena.|

## Consultas de agrupamiento 
Las consultas de agrupamiento son aquellas que nos permiten organizar los datos en grupos basados en los valores de una o más columnas. Por ejemplo, podemos agrupar productos según su categoría; para ello, usamos la cláusula `GROUP BY`.
```sql
SELECT categoria, SUM(precio) AS total_precio FROM productos GROUP BY categoria;
```
Si queremos realizar algún tipo de comprobación en un agrupamiento, normalmente usaríamos `WHERE` en consultas convencionales. Sin embargo, en consultas con agrupamientos debemos usar `HAVING` para aplicar condiciones sobre los grupos resultantes.
```sql
SELECT categoria, SUM(precio) AS total_precio FROM productos GROUP BY categoria HAVING SUM(precio) > 500;
```

|**Función**|**Definición**|
|---|---|
|**COUNT**|Devuelve el número total de filas en un conjunto de resultados. También se puede usar para contar valores no nulos en una columna específica.|
|**AVG**|Calcula el promedio (media aritmética) de los valores de una columna numérica. Ignora los valores nulos.|
|**MAX**|Devuelve el valor máximo en una columna, ya sea numérica, de texto o de fecha.|
|**MIN**|Devuelve el valor mínimo en una columna, ya sea numérica, de texto o de fecha.|
|**SUM**|Calcula la suma total de los valores de una columna numérica. Ignora los valores nulos.|
## Subconsultas
Una subconsulta, también conocida como consulta anidada, es una consulta que se ejecuta dentro de otra consulta principal. Estas subconsultas suelen ser posibles gracias al uso de claves foráneas, que permiten establecer relaciones entre tablas y facilitar la recuperación de datos relacionados.
```sql
# Sacar usuarios con entradas
SELECT * FROM usuarios WHERE id IN (SELECT usuario_id FROM entradas);
```
## Multitablas y joins
Una consulta multitabla permite consultar datos de varias tablas en una sola consulta, combinándolos de manera eficiente para obtener resultados relacionados.
```sql
SELECT e.id, e.titulo, u.nombre AS 'Autor', c.nombre AS 'Categoria'
FROM entradas e, usuarios u, categorias c
WHERE e.usuario_id = u.id AND e.categoria_id = c.id;
```
Una desventaja de las consultas multitabla es que recorren todas las tablas involucradas, lo que puede ser ineficiente. Una forma más óptima de realizar este tipo de consultas es utilizando un `INNER JOIN`, ya que este solo combina los registros que cumplen con la condición especificada, haciendo las consultas más limpias y optimizadas.
```sql
SELECT e.id, e.titulo, u.nombre AS 'Autor', c.nombre AS 'Categoria'
FROM entradas e
INNER JOIN usuarios u ON e.usuario_id = u.id
INNER JOIN categorias c ON e.categoria_id = c.id;
```
El `LEFT JOIN` es útil cuando necesitamos incluir todos los registros de una tabla, incluso si no tienen coincidencias en la otra tabla. A diferencia del `INNER JOIN`, que solo devuelve los registros que cumplen con la condición, el `LEFT JOIN` asegura que todos los registros de la tabla izquierda estén presentes, completando con valores `NULL` los datos de la tabla derecha cuando no hay coincidencias. Esto lo hace ideal para consultas donde queremos conservar toda la información de una tabla principal, incluso si no está completamente relacionada.
```sql
# Mostrar el nombre de las categorais y al lado cuantas entradas tienen
SELECT e.nombre, COUNT(e.id) FROM categorias c
LEFT JOIN entradas e ON e.categoria_id = c.id
GROUP BY e.categoria_id;
```
El `RIGHT JOIN` se utiliza cuando queremos incluir todos los registros de la tabla derecha, incluso si no tienen coincidencias en la tabla izquierda. A diferencia del `INNER JOIN`, que solo devuelve los registros que cumplen con la condición, el `RIGHT JOIN` asegura que todos los registros de la tabla derecha estén presentes, completando con valores `NULL` los datos de la tabla izquierda cuando no hay coincidencias. Esto es útil cuando deseamos priorizar la información de la tabla derecha en la consulta, sin perder ningún dato de esta.
```sql
# Mostrar el nombre de las categorais y al lado cuantas entradas tienen
SELECT c.nombre, COUNT(e.id) FROM entradas e 
RIGHT JOIN categorias c ON e.categoria_id = c.id
GROUP BY e.categoria_id;
```
## Vistas
Una vista se puede definir como una consulta almacenada en la base de datos que actúa como una tabla virtual. Aunque no almacena los datos directamente, trabaja sobre los datos de las tablas existentes, manteniéndose siempre actualizada. Esto aporta gran comodidad al simplificar consultas complejas que se usan de forma reiterativa o frecuente, facilitando su reutilización dentro de la base de datos.

```sql
CREATE VIEW entradas_con_nombres AS
SELECT e.id, e.titulo, u.nombre AS 'Autor', c.nombre AS 'Categoria'
FROM entradas e
INNER JOIN usuarios u ON e.usuario_id = u.id
INNER JOIN categorias c ON e.categoria_id = c.id;
```
Podemos utilizarla como si fuese una tabla más dentro de nuestra base de datos.
```sql
SELECT * FROM entradas_con_nombres;
```
Para eliminar una vista, utilizamos la instrucción `DROP VIEW`.
```sql
DROP VIEW IF EXISTS entradas_con_nombres;
```