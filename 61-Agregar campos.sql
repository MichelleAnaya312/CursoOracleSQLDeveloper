/*Primer Problema*/
--1 Eliminamos la tabla:
drop table libros;

--2 Creamos la tabla:
create table libros(
  titulo varchar2(30),
  editorial varchar2(20)
);

--3
/*Agregamos el campo "cantidad" a la tabla "libros", de tipo number(4), con 
el valor por defecto cero y que NO acepta valores nulos:*/
alter table libros
add cantidad number(4) default 0 not null;

--4 Verificamos la estructura de la tabla:
describe libros;
--aparece el nuevo campo.

--5 
/*Agregamos un nuevo campo "precio" a la tabla "libros", de tipo number(4) 
que acepta valores nulos:*/
alter table libros
add precio number(4);

--6 Verificamos la estructura de la tabla:
describe libros;
--aparece el nuevo campo.

--7 Ingresamos algunos registros:
insert into libros values('El aleph','Emece',100,25.5);
insert into libros values('Uno','Planeta',150,null);

--8 
/*Intentamos agregar un nuevo campo "autor" de tipo varchar2(30) que no 
admita valores nulos:*/
alter table libros
add autor varchar2(30) not null;
/*Mensaje de error. Si el campo no aceptará valores nulos y no tiene 
definido un valor por defecto, no se pueden llenar los registros existentes 
con ningún valor. Por ello, debemos definirlo con un valor por defecto:*/

alter table libros
add autor varchar2(30) default 'Desconocido' not null;

--9 Veamos qué sucedió con los registros existentes:
select * from libros;
--contienen el valor por defecto en "autor".