/*Primer Problema:*/
--1 Eliminamos la tabla:
drop table libros;

--2 Creamos la tabla con la siguiente estructura:
create table libros(
  codigo number(5) not null,
  titulo varchar2(40) not null,
  autor varchar2(30),
  editorial varchar2(15),
  precio number(6,2),
  cantidad number(4)
 );

--3
/*Intentemos ingresar un valor para "cantidad" 
fuera del rango definido:*/
 insert into libros (codigo,titulo,autor,editorial,precio,cantidad)
  values(1,'El aleph','Borges','Emece',25.60,50000);
/*aparece un mensaje de error y la inserción no se ejecuta.*/

--4 Ingresamos un valor para "cantidad" con decimales:
 insert into libros (codigo,titulo,autor,editorial,precio,cantidad)
  values(1,'El aleph','Borges','Emece',25.60,100.2);

--5 Lo acepta, veamos qué se almacenó:
 select * from libros;
/*Truncó el valor.*/

--6 Ingresamos un precio con 3 decimales:
insert into libros (codigo,titulo,autor,editorial,precio,cantidad)
  values(2,'Don quijote','Cervantes','Emece',25.123,100);

--7 Lo acepta, veamos qué se almacenó:
select * from libros;
/*Truncó el valor.*/

--8 Intentamos ingresar un código con comillas (una cadena):
 insert into libros (codigo,titulo,autor,editorial,precio,cantidad)
  values(4,'Uno','Richard Bach','Planeta','50',100);
/*Oracle lo convierte a número.*/

--9
/*Intentamos ingresar una cadena que Oracle no pueda 
convertir a valor numérico en el campo "precio":*/
 insert into libros (codigo,titulo,autor,editorial,precio,cantidad)
  values(5,'Alicia en el pais...','Lewis Carroll','Planeta','sdf',200);
--Error.
