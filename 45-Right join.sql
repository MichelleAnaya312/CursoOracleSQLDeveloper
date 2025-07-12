/*Primer Problema*/
--1 
/*Eliminamos ambas tablas, las creamos y agregamos dos restricciones 
"primary key" sobre los campos "codigo" de las dos tablas:*/
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
add constraint PK_libros
primary key(codigo);

alter table editoriales
add constraint PK_editoriales
primary key(codigo);

--2 Ingresamos algunos registros en ambas tablas:
insert into editoriales values(1,'Planeta');
insert into editoriales values(2,'Emece');
insert into editoriales values(3,'Siglo XXI');
insert into editoriales values(4,'Norma');

insert into libros values(100,'El aleph','Borges',1);
insert into libros values(101,'Martin Fierro','Jose Hernandez',1);
insert into libros values(102,'Aprenda PHP','Mario Molina',2);
insert into libros values(103,'Java en 10 minutos',null,4);
insert into libros values(104,'El anillo del hechicero','Carol Gaskin',4);

--3 
/*Solicitamos el título y nombre de la editorial de los libros empleando 
un "right join":*/
select titulo,nombre as editorial
from libros l
right join editoriales e
on codigoeditorial = e.codigo;
/*Las editoriales de las cuales no hay libros, es decir, cuyo código de editorial 
no está presente en "libros" aparece en el resultado, pero con el valor "null" 
en el campo "titulo"; caso de la editorial "Siglo XXI".*/

--4 
/*Realizamos la misma consulta anterior agregando un "where" que restringa el 
resultado considerando solamente los registros que encuentran coincidencia en 
la tabla izquierda:*/
select titulo,nombre as editorial
from libros l
right join editoriales e
on e.codigo=codigoeditorial
where codigoeditorial is not null;
--Ya no aparece la editorial "Siglo XXI".

--5 
/*Mostramos las editoriales que NO están presentes en "libros" 
(que NO encuentran coincidencia en "editoriales"):*/
select nombre
from libros l
right join editoriales e
on e.codigo=codigoeditorial
where codigoeditorial is null;
--Solamente aparece la editorial "Siglo XXI".
