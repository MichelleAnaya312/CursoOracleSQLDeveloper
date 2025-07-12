/*Primer Problema*/
--1 Eliminamos la tabla:
drop table libros;

--2 Creamos la tabla:
create table libros(
 codigo number (5),
 titulo varchar2(40) not null,
 autor varchar2(20),
 editorial varchar2(20),
 precio number(6,2)
);

--3 Ingresamos algunos registros:
insert into libros
values(1,'El aleph','Borges','Emece',15.90);
insert into libros
values(2,'Cervantes y el quijote','Borges','Paidos',null);
insert into libros
values(3,'Alicia en el pais de las maravillas','Lewis Carroll',null,19.90);
insert into libros
values(4,'Matematica estas ahi','Paenza','Siglo XXI',15);
insert into libros
values(5,'Antología poética',default,default,32);
insert into libros
values(6,'Martin Fierro','Jose Hernandez',default,40);
insert into libros
values(7,'Aprenda PHP','Mario Molina',default,56.50);

--4 Recuperamos los libros cuyo autor es "Paenza" o "Borges":
select * from libros
where autor in('Borges','Paenza');
/*Note que los valores "null" no se consideran.*/

--5 Recuperamos los libros cuyo autor NO es "Paenza" ni "Borges":
select * from libros
where autor not in ('Borges','Paenza');
/*Note que los valores "null" no se consideran.*/

--6 
/*Recuperamos los libros cuyo código se encuentre en la siguiente 
lista de valores (1,3,5,7,9):*/
select * from libros
where codigo in (1,3,5,7,9);

/*Segundo Problema*/
--1 Elimine la tabla y créela con la siguiente estructura:
drop table medicamentos;

create table medicamentos(
 codigo number(5),
 nombre varchar2(20),
 laboratorio varchar2(20),
 precio number(6,2),
 cantidad number(3) not null,
 fechavencimiento date not null,
 primary key(codigo)
);

--3 Ingrese algunos registros:
insert into medicamentos
values(100,'Sertal','Roche',5.2,1,'01/02/2015');
insert into medicamentos 
values(230,'Buscapina',null,4.10,3,'01/03/2016');
insert into medicamentos 
values(280,'Amoxidal 500','Bayer',15.60,100,'01/05/2017');
insert into medicamentos
values(301,'Paracetamol 500','Bago',1.90,10,'01/02/2018');
insert into medicamentos 
values(400,'Bayaspirina','Bayer',2.10,150,'01/08/2019'); 
insert into medicamentos 
values(560,'Amoxidal jarabe','Bayer',5.10,250,'01/10/2020'); 

--4 
/*Recupere los nombres y precios de los medicamentos cuyo 
laboratorio sea "Bayer" o "Bago" empleando el operador "in" 
(4 registros)*/
select nombre,precio from medicamentos
where laboratorio in ('Bayer','Bago');

--5 
/*Recupere los nombres y precios de los medicamentos cuyo 
laboratorio NO sea "Bayer" o "Bago" empleando el operador "in" 
(1 registro)*/
select nombre,precio from medicamentos
where laboratorio not in ('Bayer','Bago');
/*Note que los valores nulos no se incluyen.*/

--6
/*Seleccione los remedios cuya cantidad se encuentre entre 1 y 5 
empleando el operador "between" y luego el operador "in" (2 registros)*/
select * from medicamentos
where cantidad between 1 and 5;
  
select * from medicamentos
where cantidad in (1,2,3,4,5);

/*Note que es más conveniente emplear, en este caso, el operador 
"between", simplifica la consulta.*/

--7 
/*Recupere los registros cuyas fechas de vencimiento 
se encuentra entre enero de 2015 y enero del 2017 
(emplee el operador apropiado) (2 registros)*/
select * from medicamentos
where fechavencimiento between '01/01/2015' and '01/01/2017';

--8 
/*Recupere los registros cuyo año de vencimiento sea 2015 o 2016 
(emplee el operador apropiado) (2 registros)*/
select * from medicamentos
where extract(year from fechavencimiento) in (2015,2016)