/*Primer Problema*/
--1 Eliminamos las tablas:
drop table libros;

drop table editoriales;

--2 Creamos las tablas:
create table editoriales(
  codigo number(3),
  nombre varchar2(30),
  primary key(codigo)
);

create table libros(
  titulo varchar2(30),
  editorial number(3),
  autor varchar2(30),
  precio number(6,2),
  constraint FK_libros_editorial
   foreign key(editorial)
   references editoriales(codigo)
);

--3 Eliminamos un campo de la tabla "libros":
alter table libros
drop column precio;

--4 Vemos la estructura de la tabla "libros":
describe libros;
--El campo "precio" ya no existe.

--5 
/*Recuerde que no pueden eliminarse los campos referenciados por una 
"foreign key". Intentamos eliminar el campo "codigo" de "editoriales":*/
alter table editoriales
drop column codigo;
--Un mensaje indica que la sentencia no fue ejecutada.

--6 Eliminamos el campo "editorial" de "libros":
alter table libros
drop column editorial;

--7 Verificamos que el campo no existe:
describe libros;

--8 El campo se ha eliminado y junto con él la restricción "foreign key":
select * from user_constraints
where table_name='LIBROS';

--9 
/*Ahora si podemos eliminar el campo "codigo" de "editoriales", pues la 
restricción "foreign key" que hacía referencia a ella ya no existe:*/
alter table editoriales
drop column codigo;

--10 
/*El campo "codigo" de "editoriales" se ha eliminado y junto con él la 
restricción "primary key":*/
select * from user_constraints
where table_name='EDITORIALES';

--11 Agregamos un índice compuesto sobre "titulo" y "autor" de "libros":
create unique index I_libros_titulo
on libros(titulo,autor);

--12 Veamos si existe tal índice:
select index_name,column_name,column_position
from user_ind_columns
where table_name='LIBROS';

--13 
/*Recuerde que si elimina un campo indizado, su índice también se elimina. 
Eliminamos el campo "autor" de "libros":*/
alter table libros
drop column autor;

--14 
/*Veamos si existe el índice compuesto creado anteriormente sobre los campos 
"titulo" y "autor" de "libros":*/
select index_name,column_name,column_position
from user_ind_columns
where table_name='LIBROS';
--Ya no existe.

--15 
/*La tabla ahora solamente consta de un campo, por lo tanto, no puede 
eliminarse, pues la tabla no puede quedar vacía de campos:*/
alter table libros
drop column titulo;
--Mensaje de error.