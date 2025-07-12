/*Primer Problema*/
--1 Eliminamos la tabla:
drop table libros;

--2 La creamos estableciendo el campo código como clave primaria:
create table libros(
  codigo number(5) not null,
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(15),
  precio number(6,2)
);

--3 
/*Definimos una restricción "primary key" para nuestra tabla 
"libros" para asegurarnos que cada libro tendrá un código diferente 
y único:*/
alter table libros
add constraint PK_libros_codigo
primary key(codigo);

--4 
/*Definimos una restricción "check" para asegurarnos que el 
precio no será negativo:*/
alter table libros
add constraint CK_libros_precio
check (precio>=0);

--5 
/*Definimos una restricción "unique" para los campos "titulo", 
"autor" y "editorial":*/
alter table libros
add constraint UQ_libros
unique(titulo,autor,editorial);

--6 Vemos las restricciones:
select * from user_constraints where table_name='LIBROS';

--Aparecen 4 restricciones:
-- 1 "check" que controla que el precio sea positivo;
-- 1 "check" , que se creó al definir "not null" el campo "codigo", el nombre le fue dado por Oracle;
-- 1 "primary key" y
-- 1 "unique".

--7 Eliminamos la restricción "PK_libros_codigo":
alter table libros
drop constraint PK_LIBROS_CODIGO;

--8 Eliminamos la restricción de control "CK_libros_precio":
alter table libros
drop constraint CK_LIBROS_PRECIO;

--9 Vemos si se eliminaron:
select * from user_constraints where table_name='LIBROS';

--Aparecen 2 restricciones.