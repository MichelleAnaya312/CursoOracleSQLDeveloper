/*Primer Problema*/
--1 Eliminamos ambas tablas y las creamos:
drop table libros;

drop table editoriales;

create table libros(
  codigo number(5),
  titulo varchar2(40),
  autor varchar2(30),
  codigoeditorial number(3)
);

create table editoriales(
  codigoeditorial number(3),
  nombre varchar2(20)
);

--2 Ingresamos algunos registros en ambas tablas:
insert into editoriales values(1,'Planeta');
insert into editoriales values(2,'Emece');
insert into editoriales values(3,'Siglo XXI');
insert into editoriales values(null,'Norma');

insert into libros values(100,'El aleph','Borges',1);
insert into libros values(101,'Martin Fierro','Jose Hernandez',1);
insert into libros values(102,'Aprenda PHP','Mario Molina',2);
insert into libros values(103,'Java en 10 minutos',null,4);
insert into libros values(104,'El anillo del hechicero','Carol Gaskin',null);

--3 Realizamos un natural join entre las dos tablas:
select titulo,nombre as editorial
from libros
natural join
editoriales;
/*En el ejemplo anterior la tabla "libros" combina su campo 
"codigoeditorial" con el campo "codigoeditorial" de "editoriales".*/

--4 Realizamos una combinación empleando la cláusula "using":
select titulo,nombre as editorial
from libros
join editoriales
using (codigoeditorial);
/*En el ejemplo anterior la tabla "libros" combina su campo 
"codigoeditorial" con el campo "codigoeditorial" de "editoriales".*/

--5 
/*Realizamos una combinación izquierda y luego un "join" con el modificador
"(+)"; ambas consultas retornan el mismo resultado:*/
select titulo,nombre as editorial
from libros l
left join editoriales e
on l.codigoeditorial = e.codigoeditorial;

select titulo,nombre as editorial
from libros l
join editoriales e
on l.codigoeditorial = e.codigoeditorial(+);
/*Ambas mostrarán el título y nombre de la editorial; los libros 
cuyo código de editorial no esté presente en "editoriales" aparecerán con 
el valor "null" en la columna "editorial".*/

--6 
/*Realizamos una combinación derecha y luego obtenemos el mismo resultado 
empleando "join" y el modificador "(+)":*/
select titulo,nombre as editorial
from editoriales e
right join libros l
on e.codigoeditorial = l.codigoeditorial;

select titulo,nombre as editorial
from editoriales e
join libros l
on e.codigoeditorial(+) = l.codigoeditorial;
/*Ambas mostrarán el título y nombre de la editorial; las editoriales que
no encuentran coincidencia en "libros", aparecen con el valor "null" en la
columna "titulo".*/

--7 
/*Si intentamos emplear el modificador en campos de distintas tablas 
Oracle mostrará un mensaje de error:*/
select titulo,nombre as editorial
from libros l
join editoriales e
on l.codigoeditorial(+)= e.codigoeditorial(+);