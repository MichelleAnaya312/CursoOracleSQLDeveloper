-- 1 Eliminamos la tabla "libros":
 drop table libros;
 
--2
/*Vamos a crear una tabla llamada "libros" para almacenar información de los libros de una librería. Necesitamos los siguientes campos:
 -titulo: cadena de caracteres de 20 de longitud,
 -autor: cadena de caracteres de 15 de longitud,
 -editorial: caracteres de 10 de longitud,
 -precio: valor numérico con 2 decimales y que no superará el valor 9999.99 y
 -cantidad: valor numérico entero que no superará el valor 999.
Al crear la tabla, entonces, elegimos el tipo de dato más adecuado para cada campo:*/
create table libros(
  titulo varchar2(20),
  autor varchar2(15),
  editorial varchar2(10),
  precio number(6,2),
  cantidad number(3,0)
 );

--3 Vemos la estructura de la tabla:
describe libros;

--4 Ingresamos algunos registros:
/*Note que al ingresar valores numéricos no se utilizan comillas 
y para el separador de decimales se usa el caracter punto (.).*/

insert into libros (titulo,autor,editorial,precio,cantidad)
  values ('El aleph','Borges','Emece',25.50,100);
 insert into libros (titulo,autor,editorial,precio,cantidad)
  values ('Matematica estas ahi','Paenza','Siglo XXI',18.8,200);

--5 Veamos los registros cargados:
select * from libros;

--6 
/*Veamos lo que sucede si intentamos ingresar para el campo "titulo"
una cadena de más de 20 caracteres:*/
insert into libros (titulo,autor,editorial,precio,cantidad)
  values ('Alicia en el pais de las maravillas','Lewis Carroll','Atlantida',10,200);
-- Aparece un mensaje de error y la sentencia no se ejecuta.

--7 
/*Vamos a cortar la cadena para que Oracle acepte el 
ingreso del registro:*/
 insert into libros (titulo,autor,editorial,precio,cantidad)
  values ('Alicia en el pais','Lewis Carroll','Atlantida',10,200);

--8 Veamos los registros cargados:
select * from libros;

--9
/*Veamos qué sucede si intentamos ingresar para el campo 
"cantidad" un valor fuera de rango:*/
insert into libros (titulo,autor,editorial,precio,cantidad)
  values ('El gato con botas','Anonimo','Atlantida',10,2000);
/*Oracle muestra un mensaje de error y la sentencia no se ejecuta, 
es decir, el registro no fue ingresado.*/

--10
/*Veamos qué sucede si intentamos ingresar en el campo "precio" 
un valor con más decimales que los permitidos: */
insert into libros (titulo,autor,editorial,precio,cantidad)
  values ('El gato con botas','Anonimo','Atlantida',10.123,200);

--11 
/*La sentencia se ejecutó, el registro ha sido cargado. 
Veamos cómo se almacenó:*/
 select * from libros;
/*Oracle omitió el último dígito decimal porque el campo 
sólo admitía 2 decimales.*/




