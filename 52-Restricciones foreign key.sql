/*Primer Problema*/
--1 Eliminamos ambas tablas:
drop table libros;

drop table editoriales;

--2 Creamos las tablas:
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

--3 Ingresamos algunos registros en ambas tablas:
insert into editoriales values(1,'Emece');
insert into editoriales values(2,'Planeta');
insert into editoriales values(3,'Siglo XXI');

insert into libros values(100,'El aleph','Borges',1);
insert into libros values(101,'Martin Fierro','Jose Hernandez',2);
insert into libros values(102,'Aprenda PHP','Mario Molina',5);

--4 
/*Intentamos establecer una restricción "foreign key" 
sobre "codigoeditorial":*/
alter table libros
add constraint FK_libros_codigoeditorial
foreign key (codigoeditorial)
references editoriales(codigo);
/*Mensaje de error; pues el campo "codigo" de la tabla "editoriales" no 
fue definida clave primaria ni única.*/

--5 Agregamos una restricción "primary key" sobre "codigo" de "editoriales":
alter table editoriales
add constraint PK_editoriales
primary key (codigo);

--6
/*Intentamos nuevamente establecer una restricción "foreign key" 
sobre "codigoeditorial":*/
alter table libros
add constraint FK_libros_codigoeditorial
foreign key (codigoeditorial)
references editoriales(codigo);
/*Mensaje de error. Oracle controla que los datos existentes no violen 
la restricción que intentamos establecer, como existe un valor de 
"codigoeditorial" inexistente en "editoriales", la restricción no 
puede establecerse.*/

--7 Eliminamos el registro que infringe la regla:
delete from libros where codigoeditorial=5;

--8
/*Ahora si podemos establecer una restricción "foreign key" sobre 
"codigoeditorial":*/
alter table libros
add constraint FK_libros_codigoeditorial
foreign key (codigoeditorial)
references editoriales(codigo);

--9 Veamos las restricciones de "libros" consultando "user_constraints":
select constraint_name, constraint_type
from user_constraints
where table_name='LIBROS';
/*aparece la restricción "FK_libros_codigoeditorial" indicando que es 
una "foreign key" con el caracter "R" en el tipo de restricción.*/

--10 Consultamos "user_cons_columns":
select constraint_name, column_name
from user_cons_columns
where table_name='LIBROS';
/*Aparece la siguiente tabla:

CONSTRAINT_NAME			COLUMN_NAME
-------------------------------------------
FK_LIBROS_CODIGOEDITORIAL	CODIGOEDITORIAL*/

--11 Veamos las restricciones de "editoriales":
select constraint_name, constraint_type
from user_constraints
where table_name='EDITORIALES';
--aparece la restricción "primary key".

--12 Ingresamos un libro sin especificar un valor para el código de editorial:
insert into libros values(103,'El experto en laberintos','Gaskin',default);

--13 Veamos todos los registros de "libros":
select * from libros;
/*Note que en "codigoeditorial" almacenó "null", porque esta restricción permite
valores nulos (a menos que se haya especificado lo contrario al definir el campo).*/

--14 
/*Intentamos agregar un libro con un código de editorial inexistente en 
"editoriales":*/
insert into libros values(104,'El anillo del hechicero','Gaskin',8);
/*Nos muestra un mensaje indicando que la restricción FK_LIBROS_EDITORIAL 
está siendo violada, que no encuentra el valor de clave primaria en "editoriales".*/

--15 Intentamos eliminar una editorial cuyo código esté presente en "libros":
delete from editoriales where codigo=2;
/*Un mensaje nos informa que la restricción de clave externa está siendo violada, 
existen registros que hacen referencia al que queremos eliminar.*/

--16 Intente eliminar la tabla "editoriales":
drop table editoriales;
/*Un mensaje de error indica que la acción no puede realizarse porque 
la tabla es referenciada por una "foreign key".*/