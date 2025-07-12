/*Primer Problema*/
--1 Eliminamos ambas tablas:
drop table libros;

drop table editoriales;

--2 Creamos las tablas:
create table libros(
  codigo number(5),
  titulo varchar2(40),
  autor varchar2(30),
  codigoeditorial number(3)
);
 
create table editoriales(
  codigo number(3),
  nombre varchar2(20),
  direccion varchar2(40),
  primary key (codigo)
);

--3 Ingresamos algunos registros en ambas tablas:
insert into editoriales values(1,'Planeta','Colon 120');
insert into editoriales values(2,'Emece','Estrada 356');
insert into editoriales values(3,'Siglo XXI','General Paz 700');

insert into libros values(100,'El aleph','Borges',1);
insert into libros values(200,'Martin Fierro','Jose Hernandez',2);
insert into libros values(300,'Aprenda PHP','Mario Molina',3);
insert into libros values(400,'Java en 10 minutos',null,5);
insert into libros values(500,'Matematica estas ahi','Paenza',null);

--4 Recuperamos los datos de libros:
select * from libros;
/*vemos que en el campo "editorial" aparece el código, 
pero no sabemos el nombre de la editorial y su dirección.*/

--5 
/*Realizamos un join para obtener datos de ambas tablas (titulo, 
autor y nombre de la editorial):*/
select titulo, autor, nombre, direccion
from libros
join editoriales
on codigoeditorial=editoriales.codigo;
/*Note que los libros cuyo código de editorial NO se encuentra en
"editoriales" no aparecen en el resultado de la consulta. 
El libro "Java en 10 minutos" tiene código de editorial 5, 
y ese código no está presente en "editoriales"; el libro 
"Matemática estas ahi" tiene valor nulo en "codigoeditorial", 
por lo tanto, tampoco se muestra en el join.*/

--6 
/*Mostramos el código del libro, título, autor, nombre de la editorial 
y su dirección realizando un join y empleando alias:*/
select l.codigo,titulo,autor,nombre,direccion
from libros l
join editoriales e
on codigoeditorial=e.codigo;
/*Note que al listar el campo "codigo" especificamos a qué tabla pertenece;
si no lo hacemos Oracle no sabrá si nos referimos al de la tabla "libros" 
o "editoriales". Los demás campos no tienen referencia a la tabla porque 
tienen nombres que no se repiten.*/

--7 
/*Realizamos la misma consulta anterior agregando un "where" 
para obtener solamente los libros de la editorial "Siglo XXI":*/
select l.codigo,titulo,autor,nombre,direccion
from libros l
join editoriales e
on codigoeditorial=e.codigo
where e.nombre='Siglo XXI';

--8 
/*Obtenemos título, autor y nombre de la editorial, 
esta vez ordenados por título:*/
select titulo,autor,nombre
from libros l
join editoriales e
on codigoeditorial=e.codigo
order by titulo;

/*Segundo Problema*/
--1 Elimine las tablas "clientes" y "provincias":
drop table clientes;

drop table provincias;
--2 Créelas con las siguientes estructuras:
create table clientes (
  codigo number(5),
  nombre varchar2(30),
  domicilio varchar2(30),
  ciudad varchar2(20),
  codigoprovincia number(2)
);

create table provincias(
  codigo number(2),
  nombre varchar2(20)
);

--3 Ingrese algunos registros para ambas tablas:
insert into provincias values(1,'Cordoba');
insert into provincias values(2,'Santa Fe');
insert into provincias values(3,'Corrientes');
insert into provincias values(null,'La Pampa');

insert into clientes values (1,'Lopez Marcos','Colon 111','Córdoba',1);
insert into clientes values (2,'Perez Ana','San Martin 222','Cruz del Eje',1);
insert into clientes values (3,'Garcia Juan','Rivadavia 333','Villa Maria',null);
insert into clientes values (4,'Perez Luis','Sarmiento 444','Rosario',2);
insert into clientes values (5,'Pereyra Lucas','San Martin 555','Cruz del Eje',1);
insert into clientes values (6,'Gomez Ines','San Martin 666','Santa Fe',2);
insert into clientes values (7,'Torres Fabiola','Alem 777','Ibera',3);
insert into clientes values (8,'Garcia Paco','Avellaneda 888','Rawson',5);

--4 Obtenga los datos de ambas tablas, usando alias.
select c.nombre,domicilio,ciudad,p.nombre
from clientes c
join provincias p
on c.codigoprovincia=p.codigo;
  
/*Note que los registros de "clientes" cuyo valor de 
"codigoprovincia" que NO encuentran coincidencia con "codigo" de 
"provincias" no aparecen en el resultado de la consulta; caso de 
"Garcia Juan", que código de provincia nulo y "Garcia Paco", que 
tiene un código de provincia que no está presente en "provincias".*/

--5 
/*Obtenga la misma información anterior pero ordenada por nombre de provincia 
(join y order by)*/
select c.nombre,domicilio,ciudad,p.nombre
from clientes c
join provincias p
on c.codigoprovincia=p.codigo
order by p.nombre;

--6 
/*Recupere todos los datos de los clientes de la provincia "Santa Fe" 
(join con where) (2 registros devueltos)*/
select c.nombre,domicilio,ciudad
from clientes c
join provincias p
on c.codigoprovincia=p.codigo
where p.nombre='Santa Fe';
