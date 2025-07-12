/*Primer Problema*/
--1 Eliminamos la tabla y la creamos:
drop table libros;

create table libros(
  codigo number(5),
  titulo varchar2(40) not null,
  autor varchar2(20) default 'Desconocido',
  editorial varchar2(20),
  precio number(6,2)
);


--3 Ingresamos algunos registros:
insert into libros
values(1,'El aleph','Borges','Emece',15.90);
insert into libros
values(2,'Antología poética','Borges','Planeta',39.50);
insert into libros
values(3,'Java en 10 minutos','Mario Molina','Planeta',50.50);
insert into libros
values(4,'Alicia en el pais de las maravillas','Lewis Carroll','Emece',19.90);
insert into libros
values(5,'Martin Fierro','Jose Hernandez','Emece',25.90);
insert into libros
values(6,'Martin Fierro','Jose Hernandez','Paidos',16.80);
insert into libros
values(7,'Aprenda PHP','Mario Molina','Emece',19.50);
insert into libros
values(8,'Cervantes y el quijote','Borges','Paidos',18.40);

select * from libros;

--4
/*Recuperamos los libros cuyo autor sea igual a "Borges" y 
cuyo precio no supere los 20 pesos:*/
select * from libros
where (autor='Borges') and
(precio<=20);

/*Aparecen 2 libros, los únicos que cumplen con ambas condiciones.*/

--5
/*Seleccionamos los libros cuyo autor es "Borges" y/o cuya editorial 
es "Planeta":*/
select * from libros
where autor='Borges' or
editorial='Planeta';

/*Note que aparecen todos los libros de "Borges" y todos 
los libros de "Planeta", algunos cumplen ambas condiciones.*/

--6
/*Recuperamos los libros cuya editorial NO es "Planeta":*/
select * from libros
where not editorial='Planeta';

--7
/*Veamos un ejemplo de cómo el empleo de paréntesis permite a Oracle 
evaluar en forma diferente ciertas consultas aparentemente iguales:*/
select * from libros
where (autor='Borges') or
(editorial='Paidos' and precio<20);

select * from libros
where (autor='Borges' or editorial='Paidos') and
(precio<20);

/*Note que el primer resultado retorna todos los libros de "Borges" 
(primera condición) y todos los libros de "Paidos" con precio inferior a 
20 (segunda condición) (registros 1,2,6 y 8); la segunda recupera todos 
los libros de "Borges" o de "Paidos" (primera condición) cuyo precio sea 
inferior a 20 (segunda condición) (registros 1,6 y 8).*/

/*Segundo Problema*/
--1 Elimine la tabla y créela con la siguiente estructura:
drop table medicamentos;

create table medicamentos(
  codigo number(5),
  nombre varchar2(20),
  laboratorio varchar2(20),
  precio number(5,2),
  cantidad number(3),
  primary key(codigo)
);

--3 Ingrese algunos registros:
insert into medicamentos values(100,'Sertal','Roche',5.2,100);
insert into medicamentos values(102,'Buscapina','Roche',4.10,200);
insert into medicamentos values(205,'Amoxidal 500','Bayer',15.60,100);
insert into medicamentos values(230,'Paracetamol 500','Bago',1.90,200);
insert into medicamentos values(345,'Bayaspirina','Bayer',2.10,150); 
insert into medicamentos values(347,'Amoxidal jarabe','Bayer',5.10,250); 

select * from medicamentos;

--4 
/*Recupere los códigos y nombres de los medicamentos cuyo 
laboratorio sea "Roche' y cuyo precio sea menor a 5 
(1 registro cumple con ambas condiciones)*/
select codigo,nombre
from medicamentos
where laboratorio='Roche' and
precio<5;

--5 
/*Recupere los medicamentos cuyo laboratorio sea "Roche" 
o cuyo precio sea menor a 5 (4 registros)*/
select * from medicamentos
where laboratorio='Roche' or
precio<5;

--6 
/*Muestre todos los medicamentos cuyo laboratorio NO sea "Bayer" y cuya 
cantidad sea=100. Luego muestre todos los medicamentos cuyo laboratorio 
sea "Bayer" y cuya cantidad NO sea=100*/
select * from medicamentos
where not laboratorio='Bayer' and
cantidad=100;

select * from medicamentos
where laboratorio='Bayer' and
not cantidad=100;
  
--7 
/*Recupere los nombres de los medicamentos cuyo precio esté entre 2 y 5 
inclusive (2 registros)*/
select nombre, precio from medicamentos
where precio>=2 and
precio <=5;

--8 
/*Elimine todos los registros cuyo laboratorio sea igual a "Bayer" y su 
precio sea mayor a 10 (1 registro eliminado)*/
delete from medicamentos
where laboratorio='Bayer' and
precio>10;

--9 
/*Cambie la cantidad por 200, de todos los medicamentos de "Roche" 
cuyo precio sea mayor a 5 (1 registro afectado)*/
update medicamentos set cantidad=200
where laboratorio='Roche' and
precio>5;

--10 
/*Muestre todos los registros para verificar el cambio.*/

select * from medicamentos;

--11 
/*Borre los medicamentos cuyo laboratorio sea "Bayer" o cuyo precio sea 
menor a 3 (3 registros borrados)*/
delete from medicamentos
where laboratorio='Bayer' or
precio<3;
