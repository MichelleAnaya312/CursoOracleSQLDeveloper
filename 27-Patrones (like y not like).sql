/*Primer Problema*/
--1 Eliminamos la tabla:
drop table libros;

--2 Creamos la tabla:
create table libros(
 titulo varchar2(40),
 autor varchar2(20) default 'Desconocido',
 editorial varchar2(20),
 edicion date,
 precio number(6,2)
);

--3 Ingresamos algunos registros:
insert into libros
values('El aleph','Borges','Emece','12/05/2005',15.90);
insert into libros
values('Antología poética','J. L. Borges','Planeta','16/08/2000',null);
insert into libros
values('Alicia en el pais de las maravillas','Lewis Carroll',null,'25/04/2000',19.90);
insert into libros
values('Matematica estas ahi','Paenza','Siglo XXI','21/12/2006',15);
insert into libros
values('Martin Fierro','Jose Hernandez',default,'22/09/2001',40);
insert into libros
values('Aprenda PHP','Mario Molina','Nuevo siglo','22/05/1999',56.50);
insert into libros
values(null,'Mario Molina','Nuevo siglo',null,45);

select * from libros;

--4 
/*Recuperamos todos los libros que contengan en el campo "autor" la cadena 
"Borges":*/
select * from libros
where autor like '%Borges%';

--5 Seleccionamos los libros cuyos títulos comienzan con la letra "M":
select * from libros
where titulo like 'M%';
/*Note que los valores nulos no se incluyen en la búsqueda.*/

--6 Seleccionamos todos los títulos que NO comienzan con "M":
select * from libros
where titulo not like 'M%';

--7 
/*Si queremos ver los libros de "Lewis Carroll" 
pero no recordamos si se escribe "Carroll" o "Carrolt", 
podemos emplear el comodín "_" (guión bajo) 
y establecer la siguiente condición:*/
select * from libros
where autor like '%Carrol_';

--8
/*Recuperamos todos los libros que contengan en el campo "edicion", 
en la parte correspondiente al mes, la cadena "05":*/
select titulo,edicion from libros
where edicion like '__/05%';
/*Note que especificamos que los 2 primeros caracteres 
(2 guiones bajos) pueden ser cualquier caracter, luego una barra 
seguida de "05" y que finalice con cualquier número de caracteres.*/

--9 
/*Recuperamos todos los libros cuyo precio se encuentra entre 10.00 y 19.99:*/
select titulo, precio from libros
  where precio like '1_.%';
/*Note que especificamos que el segundo caracter (1 guión bajo) puede 
ser cualquier valor, luego una coma y que finalice con cualquier 
número de caracteres.*/

--10 Recuperamos los libros que NO incluyen centavos en sus precios:
/*select titulo,precio from libros
where precio not like '%,%';*/

select titulo,precio from libros
where precio not like '%.%';

