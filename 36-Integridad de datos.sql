/*Restricción primary key*/
/*Primer Problema*/

--1 Eliminamos la tabla:
drop table libros;

--2 La creamos estableciendo el campo código como clave primaria:
create table libros(
  codigo number(5),
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(15),
  primary key (codigo)
);

--3 Veamos la restricción "primary key" que creó automáticamente Oracle:
select * from user_constraints where table_name='LIBROS';

/*Aparece la siguiente información simplificada:

OWNER	CONSTRAINT_NAME		CONSTRAINT_TYPE		TABLE_NAME
------------------------------------------------------------------
SYSTEM  SYS_C004427		P			LIBROS
Nos informa que la tabla "libros" (TABLE_NAME) tiene una restricción de 
tipo "primary key" (muestra "P" en "CONSTRAINT_TYPE") creada por "SYSTEM" 
(OWNER) cuyo nombre es "SYS_C004427" (nombre dado por Oracle).*/

--4 
/*Vamos a eliminar la tabla y la crearemos nuevamente, 
sin establecer la clave primaria:*/
drop table libros;

create table libros(
  codigo number(5),
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(15)
);

--5 Ingresamos 2 registros con valor de código repetido:
insert into libros values(1,'El aleph','Borges','Emece');
insert into libros values(1,'Ilusiones','Bach','Planeta');
/*Si intentamos agregar una restricción "primary key" a la tabla, 
aparecerá un mensaje indicando que la clave primaria se viola y 
proponiendo que se elimine la clave repetida.*/

--6 Modificamos el código repetido:
update libros set codigo=2 where titulo='Ilusiones'; 

--7
/*Ahora si podremos definir la restricción "primary key" 
para nuestra tabla "libros":*/
alter table libros
add constraint PK_libros_codigo
primary key(codigo);

--8 Veamos la información respecto a ella:
select * from user_constraints where table_name='LIBROS';

/*Aparece la siguiente información simplificada:

OWNER	CONSTRAINT_NAME		CONSTRAINT_TYPE		TABLE_NAME
------------------------------------------------------------------
SYSTEM  PK_LIBROS_CODIGO	P			LIBROS
Nos informa que la tabla "libros" (TABLE_NAME) tiene una restricción de 
tipo "primary key" (muestra "P" en "CONSTRAINT_TYPE") creada por "SYSTEM" 
(OWNER) cuyo nombre es "PK_libros_codigo" (nombre dado por nosotros 
al agregarla).*/

--9
/*Si intentamos ingresar un registro con un valor para el campo "codigo" 
que ya existe, no lo permite:*/
insert into libros values(1,'El quijote de la mancha','Cervantes','Emece');

--10 Tampoco permite modificar un código colocando uno existente:
update libros set codigo=1 where titulo='Ilusiones'; 

--11 Tampoco podemos ingresar en "codigo" un valor nulo:
insert into libros values(null,'El quijote de la mancha','Cervantes','Emece');

--12 
/*El campo, luego de agregarse la restricción "primary key"
se estableció como "not null"; podemos verificarlo:*/
describe libros;

--13 
/*Si intentamos agregar otra restricción "primary key", Oracle no lo permite:*/
alter table libros
add constraint PK_libros_titulo
primary key(titulo);

/*Un mensaje nos indica que la tabla solamente puede tener UNA clave primaria.*/

--14 Veamos lo que nos informa el catálogo "user_const_columns":
select * from user_cons_columns where table_name='LIBROS';

/*Nos muestra la siguiente información:

OWNER	CONSTRAINT_NAME		TABLE_NAME	COLUMN_NAME	POSITION
-------------------------------------------------------------------------
SYSTEM	PK_LIBROS_CODIGO	LIBROS		CODIGO		1*/