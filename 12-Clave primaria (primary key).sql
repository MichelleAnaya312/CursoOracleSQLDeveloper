/*Primer Problema:*/
--1
drop table usuarios;

--2
create table usuarios(
  nombre varchar2(20),
  clave varchar2(10),
  primary key(nombre)
 );

--3
describe usuarios;

--4
insert into usuarios (nombre, clave)
  values ('juanperez','Boca');
 insert into usuarios (nombre, clave)
  values ('raulgarcia','River');

select * from usuarios;

--5
insert into usuarios (nombre, clave)
  values ('juanperez','payaso');

/*aparece un mensaje de error y la sentencia no se ejecuta*/

--6
insert into usuarios (nombre, clave)
  values (null,'payaso');

/*aparece un mensaje de error y la sentencia no se ejecuta*/

--7
update usuarios set nombre='juanperez'
  where nombre='raulgarcia';

/*aparece un mensaje indicando que se viola la clave primaria 
y la actualización no se realiza.*/

--8
select uc.table_name, column_name from user_cons_columns ucc
  join user_constraints uc
  on ucc.constraint_name=uc.constraint_name
  where uc.constraint_type='P' and
  uc.table_name='USUARIOS';

/*indicando que la tabla "usuarios" tiene establecido el 
campo "nombre" como clave primaria.*/

/*Segundo Problema:*/
--1 Elimine la tabla:
drop table libros;

--2
/*Créela con los siguientes campos, 
estableciendo como clave primaria el 
campo "codigo":*/
create table libros(
  codigo number(4) not null,
  titulo varchar2(40) not null,
  autor varchar2(20),
  editorial varchar2(15),
  primary key (codigo)
 );

--3 Ingrese los siguientes registros:
 insert into libros (codigo,titulo,autor,editorial)
  values (1,'El aleph','Borges','Emece');
 insert into libros (codigo,titulo,autor,editorial)
  values (2,'Martin Fierro','Jose Hernandez','Planeta');
 insert into libros (codigo,titulo,autor,editorial)
  values (3,'Aprenda PHP','Mario Molina','Nuevo Siglo');

select * from libros;

--4 Ingrese un registro con código repetido (aparece un mensaje de error)
insert into libros (codigo,titulo,autor,editorial)
  values (2,'Alicia en el pais de las maravillas','Lewis Carroll','Planeta');

--5 Intente ingresar el valor "null" en el campo "codigo"
 insert into libros (codigo,titulo,autor,editorial)
  values (null,'Alicia en el pais de las maravillas','Lewis Carroll','Planeta');

--6 
/*Intente actualizar el código del libro 
"Martin Fierro" a "1" (mensaje de error)*/
update libros set codigo=1
  where titulo='Martin Fierro';

--7 Actualice el código del libro "Martin Fierro" a "10"
update libros set codigo=10
  where titulo='Martin Fierro';

--8
/*Vea qué campo de la tabla "LIBROS" fue establecido 
como clave primaria*/
select uc.table_name, column_name from user_cons_columns ucc
  join user_constraints uc
  on ucc.constraint_name=uc.constraint_name
  where uc.constraint_type='P' and
  uc.table_name='LIBROS';
  
--9
/*Vea qué campo de la tabla "libros" (en minúsculas) 
fue establecido como clave primaria*/
 select uc.table_name, column_name from user_cons_columns ucc
  join user_constraints uc
  on ucc.constraint_name=uc.constraint_name
  where uc.constraint_type='P' and
  uc.table_name='libros';

/*La tabla aparece vacía porque Oracle no encuentra la tabla 
"libros", ya que almacena los nombres de las tablas con 
mayúsculas.*/

