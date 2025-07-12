/*Primer Problema:*/
--1 Elimine la tabla 
drop table libros;

--2 Cree la tabla:
 create table libros(
  codigo number(5) not null,
  titulo varchar2(40) not null,
  autor varchar2(30),
  editorial varchar2(15)
 );

--3
/*Si ingresamos valores para todos los campos, 
podemos omitir la lista de campos:*/
 insert into libros
  values (1,'Uno','Richard Bach','Planeta');

--4
/*Podemos ingresar valores para algunos de los campos:*/
 insert into libros (codigo, titulo, autor)
  values (2,'El aleph','Borges');

--5 Veamos cómo Oracle almacenó los registros:
 select * from libros;
/*En el campo "editorial", para el cual no ingresamos valor,
se almacenó "null".*/

--6
/*No podemos omitir el valor para un campo declarado 
"not null", como el campo "codigo":*/
 insert into libros (titulo, autor,editorial)
  values ('Alicia en el pais de las maravillas','Lewis Carroll','Planeta');
/*aparece un mensaje y la inserción no se realiza.*/

--7 Veamos cómo Oracle almacenó los registros:
 select * from libros;


