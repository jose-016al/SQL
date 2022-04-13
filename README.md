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