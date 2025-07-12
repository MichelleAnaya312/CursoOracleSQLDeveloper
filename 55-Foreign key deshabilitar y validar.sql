/*Primer Problema*/
--1 Eliminamos ambas tablas:
drop table libros;
 
drop table editoriales;

--2 Creamos las tablas:
create table libros(
  codigo number(5),
  titulo varchar2(40),
  codigoeditorial number(3),
  primary key (codigo)
);
 
create table editoriales(
  codigo number(3),
  nombre varchar2(20),
  primary key (codigo)
);

--3 Ingresamos algunos registros:
insert into editoriales values(1,'Planeta');
insert into editoriales values(2,'Emece');
insert into editoriales values(3,'Paidos');

insert into libros values(1,'Uno',1);
insert into libros values(2,'El aleph',2);
insert into libros values(3,'Aprenda PHP',5);

--4 
/*Agregamos una restricción "foreign key" a la tabla "libros" para evitar que se 
ingresen códigos de editoriales inexistentes en "editoriales". Incluimos la opción 
"novalidate" para evitar la comprobación de la restricción en los datos existentes 
(note que hay un libro que tiene un código de editorial inválido):*/
alter table libros
add constraint FK_libros_codigoeditorial
foreign key (codigoeditorial)
references editoriales(codigo) novalidate;
/*La deshabilitación de la comprobación de la restricción no afecta a los 
siguientes ingresos, modificaciones y actualizaciones. */ 

--5
/*Para poder ingresar,modificar o eliminar datos a una tabla sin que Oracle 
compruebe la restricción debemos deshabilitarla:*/
alter table libros
disable novalidate
constraint FK_LIBROS_CODIGOEDITORIAL;

--6 Veamos si la restricción está habilitada o no:
select constraint_name, constraint_type, status, validated
from user_constraints
where table_name='LIBROS';
/*En la columna "status" de la restricción "foreign key" aparece "Disabled" y 
en "Validated" muestra "not validated".*/

--7 Ahora podemos ingresar un registro en "libros" con código de editorial inválido:
insert into libros values(4,'Ilusiones',6);

--8 Habilitamos la restricción:
alter table libros
enable novalidate constraint FK_libros_codigoeditorial;

--9 
/*Veamos si la restricción está habilitada o no y si valida los datos existentes:*/
select constraint_name, constraint_type, status, validated
from user_constraints where table_name='LIBROS';
--En la columna "status" aparece "Enabled" y en "Validated" "not validate".

--10 Intentamos alterar la restricción para que se validen los datos existentes:
alter table libros
enable validate constraint FK_libros_codigoeditorial;
/*Oracle mostrará un mensaje indicando que no se pueden validar los datos 
existentes porque existen valores inválidos.*/

--11 Truncamos la tabla y alteramos la restricción:
truncate table libros;

alter table libros
enable validate constraint FK_libros_codigoeditorial;

--12 Solicitamos información sobre la restricción:
select constraint_name, constraint_type, status, validated
from user_constraints where table_name='LIBROS';
--En la columna "status" aparece "Enabled" y en "Validated" "Validate".