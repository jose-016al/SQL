DROP USER IF EXISTS automoviles;

CREATE USER automoviles IDENTIFIED BY "automoviles";

DROP DATABASE IF EXISTS automoviles;

CREATE DATABASE automoviles COLLATE utf8mb4_spanish_ci;

GRANT ALL PRIVILEGES ON automoviles.* TO automoviles;

USE automoviles;

CREATE TABLE clientes (	
    dni 		SMALLINT UNSIGNED PRIMARY KEY, 
	nombre 		VARCHAR(50) NOT NULL, 
	apellidos 	VARCHAR(100) NOT NULL, 
	ciudad 		VARCHAR(50) NOT NULL
);
INSERT INTO clientes VALUES (1, 'Luis', 'García', 'Madrid');    
INSERT INTO clientes VALUES (2, 'Antonio', 'López', 'Valencia');  
INSERT INTO clientes VALUES (3, 'Juan', 'Martín', 'Madrid');    
INSERT INTO clientes VALUES (4, 'Maria', 'García', 'Madrid');    
INSERT INTO clientes VALUES (5, 'Javier', 'González', 'Barcelona'); 
INSERT INTO clientes VALUES (6, 'Ana', 'López', 'Barcelona'); 

CREATE TABLE coches (	
    codcoche 	SMALLINT UNSIGNED PRIMARY KEY, 
	nombre 		VARCHAR(50) NOT NULL, 
	modelo 		VARCHAR(50) NOT NULL
);
INSERT INTO coches VALUES (1, 'Ibiza', 'glx');       
INSERT INTO coches VALUES (2, 'Ibiza', 'gti');       
INSERT INTO coches VALUES (3, 'Ibiza', 'gtd');       
INSERT INTO coches VALUES (4, 'Toledo', 'gtd');       
INSERT INTO coches VALUES (5, 'Cordoba', 'gti');       
INSERT INTO coches VALUES (6, 'Megane', '1.6');       
INSERT INTO coches VALUES (7, 'Megane', 'gti');       
INSERT INTO coches VALUES (8, 'Laguna', 'gtd');       
INSERT INTO coches VALUES (9, 'Laguna', 'td');        
INSERT INTO coches VALUES (10, 'ZX', '16v');       
INSERT INTO coches VALUES (11, 'ZX', 'td');        
INSERT INTO coches VALUES (12, 'Xantia', 'gtd');       
INSERT INTO coches VALUES (13, 'A4', '1.8');       
INSERT INTO coches VALUES (14, 'A4', '2.8');       
INSERT INTO coches VALUES (15, 'Astra', 'caravan');   
INSERT INTO coches VALUES (16, 'Astra', 'gti');       
INSERT INTO coches VALUES (17, 'Corsa', '1.4');       
INSERT INTO coches VALUES (18, '300', '316i');      
INSERT INTO coches VALUES (19, '500', '525i');      
INSERT INTO coches VALUES (20, '700', '750i');      

CREATE TABLE concesionarios (	
	cifc 	SMALLINT UNSIGNED PRIMARY KEY, 
	nombre 	VARCHAR(50) NOT NULL, 
	ciudad 	VARCHAR(50) NOT NULL
);
INSERT INTO concesionarios VALUES (1, 'acar', 'Madrid');    
INSERT INTO concesionarios VALUES (2, 'bcar', 'Madrid');    
INSERT INTO concesionarios VALUES (3, 'ccar', 'Barcelona'); 
INSERT INTO concesionarios VALUES (4, 'dcar', 'Valencia');  
INSERT INTO concesionarios VALUES (5, 'ecar', 'Bilbao');    

CREATE TABLE marcas (	
	cifm 	SMALLINT UNSIGNED PRIMARY KEY, 
	nombre 	VARCHAR(50) NOT NULL, 
	ciudad 	VARCHAR(50) NOT NULL
);
INSERT INTO marcas VALUES (1, 'Seat', 'Madrid');    
INSERT INTO marcas VALUES (2, 'Renault', 'Barcelona'); 
INSERT INTO marcas VALUES (3, 'Citroen', 'Valencia');  
INSERT INTO marcas VALUES (4, 'Audi', 'Madrid');    
INSERT INTO marcas VALUES (5, 'Opel', 'Bilbao');    
INSERT INTO marcas VALUES (6, 'BMW', 'Barcelona'); 

CREATE TABLE distribucion (	
	cifc 		SMALLINT UNSIGNED NOT NULL, 
	codcoche 	SMALLINT UNSIGNED NOT NULL, 
	cantidad 	SMALLINT UNSIGNED NOT NULL, 
	PRIMARY KEY (cifc, codcoche), 
	FOREIGN KEY (cifc) REFERENCES concesionarios(cifc), 
	FOREIGN KEY (codcoche) REFERENCES coches(codcoche)
);
INSERT INTO distribucion VALUES (2, 6, 5);
INSERT INTO distribucion VALUES (3, 10, 5);
INSERT INTO distribucion VALUES (3, 12, 5);
INSERT INTO distribucion VALUES (4, 13, 10);
INSERT INTO distribucion VALUES (1, 1, 3);
INSERT INTO distribucion VALUES (1, 5, 7);
INSERT INTO distribucion VALUES (1, 6, 7);
INSERT INTO distribucion VALUES (2, 8, 10);
INSERT INTO distribucion VALUES (2, 9, 10);
INSERT INTO distribucion VALUES (3, 11, 3);
INSERT INTO distribucion VALUES (4, 14, 5);
INSERT INTO distribucion VALUES (5, 15, 10);
INSERT INTO distribucion VALUES (5, 16, 20);
INSERT INTO distribucion VALUES (5, 17, 8);

CREATE TABLE marco (
	cifm 		SMALLINT UNSIGNED NOT NULL, 
	codcoche 	SMALLINT UNSIGNED NOT NULL, 
	PRIMARY KEY (cifm, codcoche), 
	FOREIGN KEY (codcoche) REFERENCES coches(codcoche), 
	FOREIGN KEY (cifm) REFERENCES marcas(cifm)
);
INSERT INTO marco VALUES (1, 1);
INSERT INTO marco VALUES (1, 2);
INSERT INTO marco VALUES (1, 3);
INSERT INTO marco VALUES (1, 4);
INSERT INTO marco VALUES (1, 5);
INSERT INTO marco VALUES (2, 6);
INSERT INTO marco VALUES (2, 7);
INSERT INTO marco VALUES (2, 8);
INSERT INTO marco VALUES (2, 9);
INSERT INTO marco VALUES (3, 10);
INSERT INTO marco VALUES (3, 11);
INSERT INTO marco VALUES (3, 12);
INSERT INTO marco VALUES (4, 13);
INSERT INTO marco VALUES (4, 14);
INSERT INTO marco VALUES (5, 15);
INSERT INTO marco VALUES (5, 16);
INSERT INTO marco VALUES (5, 17);
INSERT INTO marco VALUES (6, 18);
INSERT INTO marco VALUES (6, 19);
INSERT INTO marco VALUES (6, 20);

CREATE TABLE ventas (
	cifc 		SMALLINT UNSIGNED NOT NULL, 
	dni 		SMALLINT UNSIGNED NOT NULL, 
	codcoche 	SMALLINT UNSIGNED NOT NULL, 
	color 		VARCHAR(20) NOT NULL, 
	PRIMARY KEY (cifc, dni, codcoche), 
	FOREIGN KEY (cifc) REFERENCES concesionarios(cifc), 
	FOREIGN KEY (dni) REFERENCES clientes(dni), 
	FOREIGN KEY (codcoche) REFERENCES coches(codcoche)
);
INSERT INTO ventas VALUES (1, 2, 5, 'rojo');      
INSERT INTO ventas VALUES (2, 3, 8, 'blanco');    
INSERT INTO ventas VALUES (2, 1, 6, 'rojo');      
INSERT INTO ventas VALUES (4, 5, 14, 'verde');     
INSERT INTO ventas VALUES (1, 1, 1, 'blanco');    
INSERT INTO ventas VALUES (3, 4, 11, 'rojo');      
