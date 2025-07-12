/*Primer Problema*/
--1 Eliminamos la tabla:
drop table libros;

--2 Creamos la tabla:
create table libros(
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(15),
  precio number(5,2),
  cantidad number(3)
);

--3 Ingresamos algunos registros:
insert into libros
values('El aleph','Borges','Planeta',35,null);
insert into libros
values('Martin Fierro','Jose Hernandez','Emece',22.20,200);
insert into libros
values('Martin Fierro','Jose Hernandez','Planeta',40,200);
insert into libros
values('Antologia poetica','J.L. Borges','Planeta',null,150);
insert into libros
values('Aprenda PHP','Mario Molina','Emece',18,null);
insert into libros
values('Manual de PHP', 'J.C. Paez', 'Siglo XXI',56,120);
insert into libros
values('Cervantes y el quijote','Bioy Casares- J.L. Borges','Paidos',null,100);
insert into libros
values('Harry Potter y la piedra filosofal','J.K. Rowling',default,45.00,90);
insert into libros
values('Harry Potter y la camara secreta','J.K. Rowling','Emece',null,100);
insert into libros
values('Alicia en el pais de las maravillas','Lewis Carroll','Paidos',42,80);
insert into libros
values('PHP de la A a la Z',null,null,110,0);
insert into libros
values('Uno','Richard Bach','Planeta',25,null);

select * from libros;

--4 Queremos saber la cantidad de libros agrupados por editorial:
select editorial, count(*) from libros
group by editorial;
/*Nos devuelve:
EDITORIAL	COUNT(*)
------------------------
Paidos		2
		2
Planeta		4
Emece		3
Siglo XXI	1*/

--5 
/*Queremos saber la cantidad de libros agrupados por editorial pero 
considerando sólo algunos grupos, por ejemplo, los que devuelvan un 
valor mayor a 2, usamos la siguiente instrucción:*/
select editorial, count(*) from libros
group by editorial
having count(*)>2;

/*La salida es la siguiente:
EDITORIAL	COUNT(*)
-------------------------
Planeta		4              
Emece		3
Compare esta salida con la de la sentencia anterior.*/

--6
/*Queremos el promedio de los precios de los libros agrupados 
por editorial, pero solamente de aquellos grupos cuyo promedio
supere los 25 pesos:*/
select editorial, avg(precio) from libros
group by editorial
having avg(precio)>25;

--7 
/*Queremos la cantidad de libros, sin considerar los que
tienen precio nulo (where), agrupados por editorial (group by), 
sin considerar la editorial "Planeta" (having):*/
select editorial, count(*) from libros
where precio is not null
group by editorial
having editorial<>'Planeta';

--8 
/*Necesitamos el promedio de los precios agrupados por editorial, 
de aquellas editoriales que tienen más de 2 libros:*/
select editorial, avg(precio) from libros
group by editorial
having count(*) > 2; 

--9 
/*Buscamos el mayor valor de los libros agrupados y 
ordenados por editorial y seleccionamos las filas que tienen un 
valor menor a 100 y mayor a 30:*/
select editorial, max(precio) as mayor
from libros
group by editorial
having max(precio)<100 and
max(precio)>30
order by editorial; 


/*Segundo Problema*/
--1 Elimine la tabla "clientes":
drop table clientes;

--2 Créela con la siguiente estructura:
create table clientes (
  nombre varchar2(30) not null,
  domicilio varchar2(30),
  ciudad varchar2(20),
  provincia varchar2(20),
  telefono varchar2(11)
);

--3 Ingrese algunos registros:
insert into clientes
values ('Lopez Marcos','Colon 111','Cordoba','Cordoba','null');
insert into clientes
values ('Perez Ana','San Martin 222','Cruz del Eje','Cordoba','4578585');
insert into clientes
values ('Garcia Juan','Rivadavia 333','Villa del Rosario','Cordoba','4578445');
insert into clientes
values ('Perez Luis','Sarmiento 444','Rosario','Santa Fe',null);
insert into clientes
values ('Pereyra Lucas','San Martin 555','Cruz del Eje','Cordoba','4253685');
insert into clientes
values ('Gomez Ines','San Martin 666','Santa Fe','Santa Fe','0345252525');
insert into clientes
values ('Torres Fabiola','Alem 777','Villa del Rosario','Cordoba','4554455');
insert into clientes
values ('Lopez Carlos',null,'Cruz del Eje','Cordoba',null);
insert into clientes
values ('Ramos Betina','San Martin 999','Cordoba','Cordoba','4223366');
insert into clientes
values ('Lopez Lucas','San Martin 1010','Posadas','Misiones','0457858745');

select * from clientes;

--4 
/*Obtenga el total de los registros agrupados por ciudad y provincia 
(6 filas)*/
select ciudad, provincia,
count(*) as cantidad
from clientes
group by ciudad,provincia;
  
--5
/*Obtenga el total de los registros agrupados por ciudad y 
provincia sin considerar los que tienen menos de 2 clientes (3 filas)*/
select ciudad, provincia,
count(*) as cantidad
from clientes
group by ciudad,provincia
having count(*)>1;

--6
/*Obtenga el total de los clientes que viven en calle "San Martin" 
(where), agrupados por provincia (group by), de aquellas ciudades 
que tengan menos de 2 clientes (having) y omitiendo la fila 
correspondiente a la ciudad de "Cordoba" (having) (2 filas devueltas)*/
select ciudad, count(*)
from clientes
where domicilio like '%San Martin%'
group by ciudad
having count(*)<2 and
ciudad <> 'Cordoba';