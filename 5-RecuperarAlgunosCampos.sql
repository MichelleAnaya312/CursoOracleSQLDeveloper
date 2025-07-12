-- 1 Eliminamos la tabla "libros":
 drop table libros;
 
 --2 Creamos la tabla:
 create table libros(
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(15),
  precio number(6,2),
  cantidad number(3,0)
 );

--3 Veamos la estructura de la tabla (5 campos):
 describe libros;
 
 --4 Ingresamos algunos registros:
 insert into libros (titulo,autor,editorial,precio,cantidad)
  values ('El aleph','Borges','Emece',25.50,100);
 insert into libros (titulo,autor,editorial,precio,cantidad)
  values ('Alicia en el pais de las maravillas','Lewis Carroll','Atlantida',10,200);
 insert into libros (titulo,autor,editorial,precio,cantidad)
  values ('Matematica estas ahi','Paenza','Siglo XXI',18.8,200);


--5 Veamos todos los campos la tabla:
select * from libros;

--6
/*Recuperamos solamente el título, autor y editorial de todos 
los libros especificando los nombres de los campos separados por 
comas:*/
select titulo,autor,editorial from libros; 

--7 Con la siguiente sentencia seleccionamos los títulos y precios de todos los libros:
select titulo,precio from libros;

--8 Para ver solamente la editorial y la cantidad de libros, tipeamos:
select editorial,cantidad from libros; 
