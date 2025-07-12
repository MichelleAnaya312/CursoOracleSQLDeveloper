/*Primer Problema*/
--1 Eliminamos las tablas:
drop table comidas;

drop table postres;

--2 Creamos las tablas:
create table comidas(
  codigo number(2),
  nombre varchar2(30),
  precio number(4,2)
);

create table postres(
  codigo number(2),
  nombre varchar2(30),
  precio number(4,2)
);

--3 Ingresamos algunos registros:
insert into comidas values(1,'ravioles',5);
insert into comidas values(2,'tallarines',4);
insert into comidas values(3,'milanesa',7);
insert into comidas values(4,'cuarto de pollo',6);

insert into postres values(1,'flan',2.5);
insert into postres values(2,'porcion torta',3.5);

--4 
/*El restaurante quiere combinar los registros de ambas tablas para mostrar 
los distintos menúes que ofrece. Lo hacemos usando un "cross join":*/
select c.nombre as "plato principal",
p.nombre as "postre"
from comidas c
cross join postres p;
/*La salida muestra cada plato combinado con cada uno de los postres. 
Se obtienen 8 registros.*/

--5 
/*En la siguiente combinación cruzada, agregamos una columna que calcula 
el precio total de cada menú:*/
select c.nombre as "plato principal",
p.nombre as "postre",c.precio,p.precio,
c.precio+p.precio as "total"
from comidas  c
cross join postres p;
/*La salida muestra cada plato combinado con cada uno de los postres y el 
precio total de cada menú. Se obtienen 8 registros.*/

/*Segundo Problema*/
--1 Elimine las tablas y créelas con las siguientes estructuras:
drop table mujeres;

drop table varones;

create table mujeres(
  nombre varchar2(30),
  domicilio varchar2(30),
  edad number(2)
);

create table varones(
  nombre varchar2(30),
  domicilio varchar2(30),
  edad number(2)
);

--2 Ingrese los siguientes registros:
insert into mujeres values('Maria Lopez','Colon 123',45);
insert into mujeres values('Liliana Garcia','Sucre 456',35);
insert into mujeres values('Susana Lopez','Avellaneda 98',41);

insert into varones values('Juan Torres','Sarmiento 755',44);
insert into varones values('Marcelo Oliva','San Martin 874',56);
insert into varones values('Federico Pereyra','Colon 234',38);
insert into varones values('Juan Garcia','Peru 333',50);

--3
/*La agencia necesita la combinación de todas las personas de sexo femenino 
con las de sexo masculino. Use un "cross join" (12 filas)*/
select m.nombre,m.edad,v.nombre,v.edad
from mujeres m
cross join varones v;
  
--4 
/*Realice la misma combinación pero considerando solamente las personas 
mayores de 40 años (6 filas)*/
select m.nombre,m.edad,v.nombre,v.edad
from mujeres m
cross join varones v
where m.edad>40 and v.edad>40;

--5 
/*Forme las parejas pero teniendo en cuenta que no tengan una diferencia 
superior a 10 años (8 filas)*/
select m.nombre,m.edad,v.nombre,v.edad
from mujeres m
cross join varones v
where m.edad-v.edad between -10 and 10;

select m.nombre,m.edad,v.nombre,v.edad
from mujeres m
cross join varones v
where not m.edad-v.edad between -10 and 10;