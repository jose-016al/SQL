USE u5;
/* 1.- Insertar un nuevo socio con los siguientes datos:
	N�m. Socio: 1007
	Nombre: Francisco
	Apellido 1: S�nchez
	Domicilio: Avda. de las Palmeras, 2
	Poblaci�n: Armilla
	Fecha de nacimiento: 02/02/1970*/
INSERT INTO SOCIO(num_socio, nombre, apellido1, domicilio, poblacion, fec_nac) 
VALUES("1007", "Franciso", "Sanchez", "Avda. de las Palmeras, 2", "Armilla", "1970-02-02");

/* 2.- Registrar el primer alquiler del socio 1007 que se lleva la copia 105 
(correspondiente a la pel�cula "Lo imposible") en la fecha actual (en la que se est� 
haciendo la tarea). */
INSERT INTO ALQUILER(copia_pel, socio, fec_alquila)
VALUES("105", "1007", NOW());

/* 3.- Modificar el estado de la copia de la pel�cula con id 101 a "ESTROPEADA" 
incluyendo como observaci�n �Rayado� */
UPDATE COPIA_PELICULA SET estado = "ESTROPEADO", observacion = "Rayado"
WHERE id_copia = "101";

/* 4.- Eliminar la pel�cula cuyo t�tulo es "El Orfanato" */
DELETE FROM PELICULA WHERE titulo = "El Orfanato";

/* 5. Insertar una nueva pel�cula (inventando los datos) y despu�s dar de 
alta dos copias para dicha pel�cula con el estado "FUNCIONA". */
INSERT INTO PELICULA VALUES("DW", "Doctor WHO", 108, "2022", "Ficcion", 3);
INSERT INTO COPIA_PELICULA (id_copia, estado, pelicula) VALUES("113", "FUNCIONA", "DW");
INSERT INTO COPIA_PELICULA (id_copia, estado, pelicula) VALUES("114", "FUNCIONA", "DW");

/* 6. Actualizar todas las pel�culas que tengan como g�nero 
"Animaci�n" y reemplazarlo por "Dibujos" */
UPDATE PELICULA SET genero = "Dibujos" WHERE genero = "Animacion";

/* 7. Eliminar aquellos socios cuya �ltima pel�cula alquilada sea anterior 
al 1 de diciembre de 2014. */
DELETE FROM SOCIO WHERE num_socio IN (SELECT socio FROM ALQUILER WHERE fec_alquila < "20141201");

/* 8. Incrementar en 20 c�ntimos el precio del alquiler a todas las 
pel�culas que tengan m�s de dos copia. */


/* 9. Eliminar todas las copias de las pel�culas que contengan la palabra "FROZEN" 
y que su estado sea "ESTROPEADA". */
DELETE FROM COPIA_PELICULA WHERE estado LIKE "ESTROPEADO" 
AND pelicula IN (SELECT id_copia FROM PELICULA WHERE titulo LIKE "%Frozen%");

/* 10. Actualizar el precio de alquiler de aquellas pel�culas cuyo n�mero total 
de alquileres (de todas sus copias) sea inferior a la media de los alquileres de 
todas las pel�culas. El precio debe reducirse en un 50% de su precio original. */


/* 11. Insertar en la tabla socio_vip todos los datos del socio que m�s n�mero de 
alquileres tenga en el �ltimo trimestre del a�o 2014 insertando en el campo 
trim_anyo_vip el valor "TRIM4_2014". */












































