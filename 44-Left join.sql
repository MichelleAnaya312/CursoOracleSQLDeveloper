/*Primer Problema*/
--1 
/*Eliminamos ambas tablas, las creamos y agregamos a cada una 
de ellas restricciones únicas para los campos "codigo" de ambas 
tablas:*/
drop table libros;

drop table editoriales;

create table libros(
  codigo number(5),
  titulo varchar2(40),
  autor varchar2(30),
  codigoeditorial number(3)
);

create table editoriales(
  codigo number(3),
  nombre varchar2(20),
  direccion varchar2(40)
);
 
alter table editoriales
add constraints UQ_editoriales_codigo
unique (codigo);

alter table libros
add constraints UQ_libros_codigo
unique (codigo);

--2 Ingresamos algunos registros en ambas tablas:
insert into editoriales values(1,'Planeta','Colon 120');
insert into editoriales values(2,'Emece','Estrada 356');
insert into editoriales values(3,'Siglo XXI','General Paz 700');
insert into editoriales values(null,'Sudamericana','Copiapo 343');
insert into editoriales values(null,'Norma','Bulnes 123');

insert into libros values(100,'El aleph','Borges',1);
insert into libros values(200,'Martin Fierro','Jose Hernandez',1);
insert into libros values(300,'Aprenda PHP','Mario Molina',2);
insert into libros values(400,'Java en 10 minutos',default,4);
insert into libros values(500,'El quijote de la mancha','Cervantes',null);

--3 
/*Realizamos una combinación izquierda para obtener los títulos de los 
libros, incluyendo el nombre de la editorial:*/
select titulo,nombre
from editoriales e
left join libros l
on codigoeditorial = e.codigo;
/*Las editoriales de las cuales no hay libros, es decir, cuyo código de 
editorial no está presente en "libros" o tienen valor nulo, aparece en 
el resultado, pero con el valor "null" en el campo "titulo" 
(caso de "Siglo XXI", "Sudamericana" y "Norma").*/

--4
/*Realizamos la misma consulta anterior pero cambiamos el orden de 
las tablas:*/
select titulo,nombre
from libros l
left join editoriales e
on codigoeditorial = e.codigo;
/*El resultado mostrará el título del libro y el nombre de la editorial; 
los títulos cuyo código de editorial no está presente en "editoriales" o 
tienen valor nulo, aparecen en el resultado, pero con el valor "null" en 
el campo "nombre" (caso de los libros "El quijote..." y "Java...").*/

--5 
/*Restringimos el resultado de una consulta considerando solamente los 
registros que encuentran coincidencia en la tabla de la derecha, es decir, 
cuyo valor de código está presente en "libros":*/
select titulo,nombre
from editoriales e
left join libros l
on e.codigo=codigoeditorial
where codigoeditorial is not null;

--6 
/*Mostramos las editoriales que NO están presentes en "libros", es decir, 
que NO encuentran coincidencia en la tabla de la derecha:*/
select nombre
from editoriales e
left join libros l
on e.codigo=codigoeditorial
where codigoeditorial is null;
--Aparecen 3 editoriales.

/*Segundo Problema*/
--1 
/*Elimine las tablas "clientes" y "provincias", créelas y agregue 
restricciones únicas para los campos "codigo" de ambas tablas:*/
drop table clientes;

drop table provincias;

create table clientes (
  codigo number(5),
  nombre varchar2(30),
  domicilio varchar2(30),
  ciudad varchar2(20),
  codigoprovincia number(3)
);

create table provincias(
  codigo number(3),
  nombre varchar2(20)
);

alter table clientes
add constraints UQ_clientes_codigo
unique (codigo);

alter table provincias
add constraints UQ_provincias_codigo
unique (codigo);

--2
/*Ingrese algunos registros para ambas tablas. Incluya valores nulos 
para el campo "codigo" de "provincias" y valores nulos para el campo 
"codigoprovincia" de "clientes". Incluya en "clientes" un código de 
provincia que no exista en "provincias":*/
insert into provincias values(1,'Cordoba');
insert into provincias values(2,'Santa Fe');
insert into provincias values(3,'Corrientes');
insert into provincias values(4,'Santa Cruz');
insert into provincias values(null,'Salta');
insert into provincias values(null,'Jujuy');

insert into clientes values (100,'Lopez Marcos','Colon 111','Córdoba',1);
insert into clientes values (200,'Perez Ana','San Martin 222','Cruz del Eje',1);
insert into clientes values (300,'Garcia Juan','Rivadavia 333','Villa Maria',null);
insert into clientes values (400,'Perez Luis','Sarmiento 444','Rosario',2);
insert into clientes values (500,'Gomez Ines','San Martin 666','Santa Fe',2);
insert into clientes values (600,'Torres Fabiola','Alem 777','La Plata',5);
insert into clientes values (700,'Garcia Luis','Sucre 475','Santa Rosa',null);

--3
/*Muestre todos los datos de los clientes, incluido el nombre de la 
provincia*/
select c.nombre,domicilio,ciudad, p.nombre as provincia
from clientes c
left join provincias p
on codigoprovincia = p.codigo;
/*Note que los clientes de "Santa Rosa", "Villa Maria" y "La Plata" 
se muestran seteados a null en la columna corespondiente al nombre de 
la provincia porque tienen valores nulos o inexistentes.*/

--4 
/*Realice la misma consulta anterior pero alterando el orden de las tablas.*/
select c.nombre,domicilio,ciudad, p.nombre
from provincias p
left join clientes c
on codigoprovincia = p.codigo;

--5
/*Muestre solamente los clientes de las provincias que existen en 
"provincias" (4 registros)*/
select c.nombre,domicilio,ciudad, p.nombre as provincia
from clientes c
left join provincias p
on codigoprovincia = p.codigo
where p.codigo is not null;
/*Note que los clientes de "Jujuy", "Salta", "Santa Cruz" y 
"Corrientes" se muestran seteados a null en los campos pertenecientes a 
la tabla "clientes" porque tienen valores nulos o inexistentes en dicha 
tabla.*/

--6
/*Muestre todos los clientes cuyo código de provincia NO existe en 
"provincias" ordenados por nombre del cliente (3 registros)*/
select c.nombre,domicilio,ciudad, p.nombre as provincia
from clientes c
left join provincias p
on codigoprovincia = p.codigo
where p.codigo is null
order by c.nombre;

--7 Obtenga todos los datos de los clientes de "Cordoba" (2 registros)
select c.nombre,domicilio,ciudad, p.nombre as provincia
from clientes c
left join provincias p
on codigoprovincia = p.codigo
where p.nombre='Cordoba';