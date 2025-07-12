/*Primer Problema*/
--1 Eliminamos la tabla:
drop table libros;

--2 Creamos la tabla con la siguiente estructura:
create table libros(
  autor varchar2(30),
  editorial varchar2(15)
);

--3 Agregamos el campo "titulo" de tipo varchar2(30) y una restricción "unique":
alter table libros
add titulo varchar2(30) 
constraint UQ_libros_autor unique;

--4 Veamos si la estructura cambió:
describe libros;

--5 
/*Agregamos el campo "codigo" de tipo number(4) not null y en la misma 
sentencia una restricción "primary key":*/
alter table libros
add codigo number(4) not null
constraint PK_libros_codigo primary key;

--6 
/*Agregamos el campo "precio" de tipo number(6,2) y una restricción "check" 
que no permita valores negativos para dicho campo:*/
alter table libros
add precio number(6,2)
constraint CK_libros_precio check (precio>=0);

--7 Veamos la estructura de la tabla y las restricciones:
describe libros;

select * from user_constraints where table_name='LIBROS';
--La tabla contiene 5 campos y 4 restricciones.