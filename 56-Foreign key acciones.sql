/*Primer Problema*/
--1 Eliminamos ambas tablas:
drop table libros;

drop table editoriales;

--2 Creamos las tablas:
create table libros(
  codigo number(5),
  titulo varchar2(40),
  autor varchar2(30),
  codigoeditorial number(3),
  primary key (codigo)
);

create table editoriales(
  codigo number(3),
  nombre varchar2(20),
  primary key (codigo)
);

--3 Ingresamos algunos registros en ambas tablas:
insert into editoriales values(1,'Emece');
insert into editoriales values(2,'Planeta');
insert into editoriales values(3,'Siglo XXI');

insert into libros values(1,'El aleph','Borges',1);
insert into libros values(2,'Martin Fierro','Jose Hernandez',2);
insert into libros values(3,'Aprenda PHP','Mario Molina',2);
insert into libros values(4,'El anillo del hechicero','Gaskin',3);

--4 
/*Establecemos una restricción "foreign key" para evitar que se ingrese en 
"libros" un código de editorial inexistente en "editoriales" con la opción 
"on cascade" para eliminaciones:*/
alter table libros
add constraint FK_libros_codigoeditorial
foreign key (codigoeditorial)
references editoriales(codigo)
on delete cascade;

--5 Consultamos "user_constraints":
select constraint_name, constraint_type, delete_rule
from user_constraints
where table_name='LIBROS';
--En la columna "delete_rule" de la restricción "foreign key" mostrará "cascade".

--6 
/*Si eliminamos una editorial, se borra tal editorial de "editoriales" y todos 
los registros de "libros" de dicha editorial:*/
delete from editoriales where codigo=1;

--7 Veamos si la eliminación se extendió a "libros":
select * from libros;
--El libro "El aleph", de la editorial con código 1 se ha eliminado.

--8 Eliminamos la restricción "foreign key" de "libros":
alter table libros
drop constraint FK_LIBROS_CODIGOEDITORIAL;

--9 
/*Establecemos una restricción "foreign key" sobre "codigoeditorial" de "libros" 
con la opción "set null" para eliminaciones:*/
alter table libros
add constraint FK_libros_codigoeditorial
foreign key (codigoeditorial)
references editoriales(codigo)
on delete set null;

--10 Consultamos "user_constraints":
select constraint_name, constraint_type, delete_rule
from user_constraints
where table_name='LIBROS';
--En la columna "delete_rule" de la restricción "foreign key" mostrará "set null".

--11 
/*Si eliminamos una editorial cuyo código está presente en "libros", se borra tal 
editorial de "editoriales" y todos los registros de "libros" de dicha editorial se 
setean con el valor "null":*/
delete from editoriales where codigo=2;

select * from libros;
/*Ahora, los libros "Martin Fierro" y "Aprenda PHP" tiene valor nulo en 
"codigoeditorial".*/
select * from editoriales;

--12 Eliminamos la restricción "foreign key" de "libros":
alter table libros
drop constraint FK_LIBROS_CODIGOEDITORIAL;

--13 
/*Establecemos una restricción "foreign key" sobre "codigoeditorial" de "libros" 
sin especificar opción para eliminaciones:*/
alter table libros
add constraint FK_libros_codigoeditorial
foreign key (codigoeditorial)
references editoriales(codigo);

--14 Consultamos "user_constraints":
select constraint_name, constraint_type, delete_rule
from user_constraints
where table_name='LIBROS';
--En la columna "delete_rule" de la restricción "foreign key" mostrará "no action".

--15 Intentamos eliminar una editorial cuyo código esté presente en "libros":
delete from editoriales where codigo=3;
/*Un mensaje de error indica que la acción no se ha realizado porque existen 
registros coincidentes.*/

