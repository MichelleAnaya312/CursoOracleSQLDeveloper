/*Primer Problema*/
--1 Eliminamos las tablas:
drop table libros;

drop table editoriales;

drop table autores;
/*Recuerde eliminar en primer lugar "libros", pues si las tablas existen y 
"libros" hace referencia con una restricción "foreign key" a "editoriales" y 
"autores", tales tablas no podrán eliminarse hasta que ninguna restricción las 
referencie.*/

--2 Creamos la tabla "editoriales" con una restricción "primary key":
create table editoriales(
  codigo number(3) not null,
  nombre varchar2(30),
  constraint PK_editoriales
   primary key (codigo)
);

--3 
/*Creamos la tabla "autores" con una restricción "primary key", una "unique" y 
una "check":*/
create table autores(
  codigo number(4) not null
   constraint CK_autores_codigo
    check (codigo>=0),
  nombre varchar2(30) not null,
  constraint PK_autores_codigo
   primary key (codigo),
  constraint UQ_autores_nombre
    unique (nombre)
);

--4 Aplicamos varias restricciones cuando creamos la tabla "libros":
create table libros(
  codigo number(5),
  titulo varchar2(40),
  codigoautor number(4),
  codigoeditorial number(3),
  precio number(5,2) default 0,
  constraint PK_libros_codigo
   primary key (codigo),
  constraint UQ_libros_tituloautor
    unique (titulo,codigoautor),
  constraint CK_libros_codigoeditorial
   check (codigoeditorial is not null),
  constraint FK_libros_editorial
   foreign key (codigoeditorial)
   references editoriales(codigo)
   on delete cascade,
  constraint FK_libros_autores
   foreign key (codigoautor)
   references autores(codigo)
   on delete set null,
  constraint CK_libros_preciononulo
   check (precio is not null) disable,
  constraint CK_precio_positivo
   check (precio>=0)
);
/*Recuerde que si definimos una restricción "foreign key" al crear una tabla, la 
tabla referenciada debe existir, por ello creamos las tablas "editoriales" y 
"autores" antes que "libros".*/

--5 Veamos las restricciones de "editoriales":
select constraint_name, constraint_type, search_condition, status, validated
from user_constraints
where table_name='EDITORIALES';
/*Una tabla nos informa que hay una restricción de control y una "primary key", 
ambas habilitadas y validan los datos existentes.*/

--6 Veamos las restricciones de "autores":
select constraint_name, constraint_type, search_condition, status, validated
from user_constraints
where table_name='AUTORES';
/*Oracle nos informa que hay 3 restricciones de control, una "primary key" y una 
única.*/

--7 Veamos las restricciones de "libros":
select constraint_name, constraint_type, search_condition, status, validated
from user_constraints
where table_name='LIBROS';
/*la tabla tiene 7 restricciones: 3 de control (2 "enabled" y "validated" y 1 
"disabled" y "not validated"), 1 "primary key" ("enabled" "validated"), 1 "unique" 
("enabled" "validated") y 2 "foreign key" ("enabled" "validated").*/

--8 Ingresamos algunos registros en las tres tablas.
/*Recuerde que debemos ingresar registros en las tablas "autores" y "editoriales" 
antes que en "libros", a menos que deshabilitemos las restricciones "foreign key".*/
insert into editoriales values(1,'Emece');
insert into editoriales values(2,'Planeta');
insert into editoriales values(3,'Norma');

insert into autores values(100,'Borges');
insert into autores values(101,'Bach Richard');
insert into autores values(102,'Cervantes');
insert into autores values(103,'Gaskin');

insert into libros values(200,'El aleph',100,1,40);
insert into libros values(300,'Uno',101,2,20);
insert into libros values(400,'El quijote',102,3,20);
insert into libros values(500,'El experto en laberintos',103,3,null);
/*Note que un libro tiene precio nulo, la tabla "libros" tiene una restricción de 
control que no admite precios nulos, pero está deshabilitada.*/

--9 Realizamos un "join" para mostrar todos los datos de los libros:
select l.codigo,a.nombre as autor,e.nombre as editorial,precio
from libros l
join autores a
on codigoautor=a.codigo
join editoriales e
on codigoeditorial=e.codigo;

--10 
/*Habilitamos la restricción de control deshabilitada sin controlar los datos ya
cargados:*/
alter table libros
enable novalidate
constraint CK_LIBROS_PRECIONONULO;

--11 Intentamos ingresar un libro con precio nulo:
insert into libros values(600,'El anillo del hechicero',103,3,null);
--Oracle no lo permite, la restricción está habilitada.

--12 Eliminamos un autor:
delete autores where codigo=100;

--13 
/*Veamos si se setearon a "null" los libros de tal autor 
(la restricción "FK_LIBROS_AUTORES" así lo especifica):*/
select * from libros;
--El libro con código 200 tiene el valor "null" en "autor".

--14 Eliminamos una editorial:
delete editoriales where codigo=1;

--15 
/*Veamos si se eliminaron los libros de tal editorial 
(la restricción "FK_LIBROS_EDITORIALES" fue establecida "cascade"):*/
select * from libros;
--Ya no está el libro "200".