/*Primer Problema*/
--1 Eliminamos la tabla:
drop table libros;

--2 Creamos la tabla:
create table libros(
  codigo number(4) not null,
  titulo varchar2(40) not null,
  autor varchar2(30) default 'Desconocido',
  editorial varchar2(15),
  edicion date,
  precio number(5,2),
  cantidad number(3),
  primary key(codigo)
);

--3 Ingresamos algunos registros:
insert into libros
values(1562,'El aleph','Borges','Planeta','10/10/1980',15,null);
insert into libros
values(1878,'Martin Fierro','Jose Hernandez','Emece',null,22.20,200);
insert into libros
values(2587,'Antologia poetica','J.L. Borges','Planeta',null,null,150);
insert into libros
values(3654,'Aprenda PHP','Mario Molina',null,'05/05/1999',18.20,null);
insert into libros
values(3921,'Cervantes y el quijote',default,'Paidos','15/02/2000',null,null);
insert into libros
values(4582,'Manual de PHP', 'J.C. Paez', 'Siglo XXI','21/04/2005',31.80,120);
insert into libros
values(5963,'Harry Potter y la piedra filosofal','J.K. Rowling',default,null,45.00,90);
insert into libros
values(6211,'Harry Potter y la camara secreta','J.K. Rowling','Emece',null,0,100);
insert into libros
values(8851,'Alicia en el pais de las maravillas','Lewis Carroll',null,null,null,220);
insert into libros
values(9920,'PHP de la A a la Z',default,default,default,null,0);

select * from libros;

--4
/*Para conocer la cantidad total de libros, 
sumamos las cantidades de cada uno:*/
select sum(cantidad) from libros;
/*Retorna 880; verifique la suma, sumando los valores de todos los registros
del campo "cantidad".*/

--5 Queremos saber cuántos libros tenemos de la editorial "Emece":
select sum(cantidad) from libros
where editorial='Emece';
--retorna 300.

--6
/*Queremos saber el precio del libro más costoso; usamos la función "max()":*/
select max(precio) from libros;
--retorna 45.

--7 Para conocer el precio mínimo de los libros de "Rowling" tipeamos:
select min(precio) from libros where autor like '%Rowling%';
--retorna 0 (cero).

--8 Queremos saber el promedio del precio de los libros referentes a "PHP":
select avg(precio) from libros where titulo like '%PHP%';
/*Devuelve 25. Note que hay 3 libros sobre "PHP", pero uno de ellos tiene 
precio nulo entonces Oracle no lo incluye para calcular el promedio.*/

--9 Averiguamos el mínimo valor del campo "edicion":
select min(edicion) from libros;
--Retorna 10/10/80.

--10 Necesitamos conocer el mayor valor de "codigo":
select max(codigo) from libros;
--Retorna 9920.