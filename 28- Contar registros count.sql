/*Primer Problema*/
--1 Eliminamos la tabla:
drop table libros;

--2 Creamos la tabla:
 create table libros(
  titulo varchar2(40) not null,
  autor varchar2(20) default 'Desconocido',
  editorial varchar(20),
  precio number(6,2)
 );
 
--3 Ingresamos algunos registros:
insert into libros
values('El aleph','Borges','Emece',15.90);
insert into libros
values('Antología poética',null,'Planeta',null);
insert into libros
values('Alicia en el pais de las maravillas','Lewis Carroll',null,19.90);
insert into libros
values('Matematica estas ahi','Paenza','Siglo XXI',15);
insert into libros
values('Martin Fierro','Jose Hernandez',default,40);
insert into libros
values('Aprenda PHP',default,'Nuevo siglo',null);
insert into libros
values('Uno','Richard Bach','Planeta',20);

select * from libros;

--4 Averiguemos la cantidad de libros usando la función "count()":
select count(*) from libros;
--Note que incluye todos los libros aunque tengan valor nulo en algún campo.

--5 Contamos los libros de editorial "Planeta":
select count(*) from libros where editorial='Planeta';
--Existen 2 libros de editorial "Planeta".

--6 
/*Contamos los registros que tienen precio (sin tener en cuenta los que 
tienen valor nulo), usando la función "count(precio)":*/
select count(precio) from libros;
--La consulta nos retorna el valor 5.

--7 
/*Contamos los registros que tienen valor diferente de "null" en "editorial":*/
select count(editorial) from libros;
--La consulta nos retorna el valor 5.

/*Segundo Problema*/
--1 Elimine la tabla:
drop table medicamentos;

--2 Cree la tabla con la siguiente estructura:
create table medicamentos(
  codigo number(5),
  nombre varchar2(20),
  laboratorio varchar2(20),
  precio number(6,2),
  cantidad number(3),
  fechavencimiento date not null,
  numerolote number(6) default null,
  primary key(codigo)
);

--3 Ingrese algunos registros:
insert into medicamentos
values(120,'Sertal','Roche',5.2,1,'01/02/2015',123456);
insert into medicamentos 
values(220,'Buscapina','Roche',4.10,3,'01/02/2016',null);
insert into medicamentos 
values(228,'Amoxidal 500','Bayer',15.60,100,'01/05/2017',null);
insert into medicamentos
values(324,'Paracetamol 500','Bago',1.90,20,'01/02/2018',null);
insert into medicamentos 
values(587,'Bayaspirina',null,2.10,null,'01/12/2019',null); 
insert into medicamentos 
values(789,'Amoxidal jarabe','Bayer',null,null,'15/12/2019',null); 

select * from medicamentos;
--4
/*Muestre la cantidad de registros empleando la función "count(*)" 
(6 registros)*/
select count(*) from medicamentos;

--5 
/*Cuente la cantidad de medicamentos que tienen laboratorio conocido 
(5 registros)*/
select count(laboratorio) from medicamentos;

--6 
/*Cuente la cantidad de medicamentos que tienen precio y cantidad, 
con alias (5 y 4 respectivamente)*/
select count(precio) as "Con precio", count(cantidad) as "Con cantidad"
from medicamentos;

--7 
/*Cuente la cantidad de remedios con precio conocido, 
cuyo laboratorio comience con "B" (2 registros)*/
select count(precio)from medicamentos
where laboratorio like 'B%';

--8
/*Cuente la cantidad de medicamentos con número de lote distinto de 
"null" (1 registro)*/
select count(numerolote) from medicamentos;

--9
/*Cuente la cantidad de medicamentos con fecha de vencimiento conocida 
(6 registros)*/
select count(fechavencimiento)
from medicamentos;