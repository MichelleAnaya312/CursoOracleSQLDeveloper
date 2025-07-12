/*Primer Problema*/
--1 
/*Eliminamos ambas tablas, las creamos y agregamos dos claves únicas sobre
los campos "codigo" de ambas tablas:*/
drop table libros;

drop table editoriales;

create table libros(
  codigo number(5),
  titulo varchar2(40),
  autor varchar2(30),
  codigoeditorial number(3)
);
 
create table editoriales(
  codigo number(3),
  nombre varchar2(20)
);
 
alter table libros
add constraint UQ_libros_codigo
unique (codigo);

alter table editoriales
add constraint UQ_editoriales_codigo
unique (codigo);  

--2 Ingresamos algunos registros en ambas tablas:
insert into editoriales values(1,'Alfaragua');
insert into editoriales values(2,'Emece');
insert into editoriales values(3,'Siglo XXI');
insert into editoriales values(4,'Norma');
insert into editoriales values(null,'Sudamericana');
 
insert into libros values(100,'El aleph','Borges',null);
insert into libros values(101,'Martin Fierro','Jose Hernandez',1);
insert into libros values(102,'Aprenda PHP','Mario Molina',2);
insert into libros values(103,'Java en 10 minutos',default,4);
insert into libros values(104,'El anillo del hechicero','Carol Gaskin',1);

--3 
/*Realizamos una combinación externa completa para obtener todos los 
registros de ambas tablas, incluyendo los libros cuyo código de editorial
no existe en la tabla "editoriales" y las editoriales de las cuales no hay 
correspondencia en "libros":*/
select titulo,nombre as editorial
from editoriales e
full join libros l
on codigoeditorial = e.codigo;
/*Note que el libro "El aleph" cuyo valor de "codigoeditorial" es null, 
muestra "null" en la columna "editorial" y las editoriales "Sudamericana" 
y "Siglo XXI" muestran "null" en el campo "titulo"*/
