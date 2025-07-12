/*Primer Problema:*/
--1 Eliminamos la tabla:
drop table libros;

--2 Creamos la tabla:
create table libros(
  codigo number(4),
  titulo varchar2(30),
  autor varchar2(20),
  editorial varchar2(15),
  precio number(5,2)
 );

--3 Agregamos algunos registros:
 insert into libros (codigo,titulo,autor,editorial,precio)
  values (1,'El aleph','Borges','Emece',25.60);
 insert into libros (codigo,titulo,autor,editorial,precio)
  values (2,'Uno','Richard Bach','Planeta',18);

--4 Seleccionamos todos los registros:
 select * from libros;

--5 Truncamos la tabla:
truncate table libros;

--6 
/*Si consultamos la tabla, 
vemos que aún existe pero 
ya no tiene registros:*/
select * from libros;

--7 Ingresamos nuevamente algunos registros:
insert into libros (codigo,titulo,autor,editorial,precio)
  values (1,'El aleph','Borges','Emece',25.60);
 insert into libros (codigo,titulo,autor,editorial,precio)
  values (2,'Uno','Richard Bach','Planeta',18);

--8 Eliminemos todos los registros con "delete":
delete from libros;

--9
/*Si consultamos la tabla, 
vemos que aún existe pero ya no tiene registros:*/
select * from libros;

--10 Ingresamos nuevamente algunos registros:
 insert into libros (codigo,titulo,autor,editorial,precio)
  values (1,'El aleph','Borges','Emece',25.60);
 insert into libros (codigo,titulo,autor,editorial,precio)
  values (2,'Uno','Richard Bach','Planeta',18);

--11 Eliminamos la tabla:
drop table libros;

--12 Intentamos seleccionar todos los registros:
select * from libros;
/*Aparece un mensaje de error, la tabla no existe.*/



