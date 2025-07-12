/*Primer Problema*/
--1 Eliminamos las tablas y las creamos:
drop table libros;

drop table editoriales;

create table editoriales(
  codigo number(3),
  nombre varchar2(30),
  primary key (codigo)
);
 
create table libros (
  codigo number(5),
  titulo varchar2(40),
  autor varchar2(30),
  codigoeditorial number(3),
  primary key(codigo),
 constraint FK_libros_editorial
   foreign key (codigoeditorial)
   references editoriales(codigo)
);

--2 Ingresamos algunos registros:
insert into editoriales values(1,'Planeta');
insert into editoriales values(2,'Emece');
insert into editoriales values(3,'Paidos');
insert into editoriales values(4,'Siglo XXI');

insert into libros values(100,'Uno','Richard Bach',1);
insert into libros values(101,'Ilusiones','Richard Bach',1);
insert into libros values(102,'Aprenda PHP','Mario Molina',4);
insert into libros values(103,'El aleph','Borges',2);
insert into libros values(104,'Puente al infinito','Richard Bach',2);

select * from editoriales;
select * from libros;

--3 
/*Queremos conocer el nombre de las editoriales que han publicado libros del 
autor "Richard Bach":*/
select nombre
from editoriales
where codigo in
(select codigoeditorial
from libros
where autor='Richard Bach');

--4 
/*Probamos la subconsulta separada de la consulta exterior para verificar que 
retorna una lista de valores de un solo campo:*/
select codigoeditorial
from libros
where autor='Richard Bach';

--5 Podemos reemplazar por un "join" la primera consulta:
select distinct nombre
from editoriales e
join libros
on codigoeditorial=e.codigo
where autor='Richard Bach';

--6 
/*También podemos buscar las editoriales que no han publicado libros de 
"Richard Bach":*/
select nombre
from editoriales
where codigo not in
(select codigoeditorial
from libros
where autor='Richard Bach');

/*Segundo Problema*/
--1 Elimine las tablas "clientes" y "ciudades":
drop table clientes;

drop table ciudades;
--2 
/*Cree la tabla "clientes" (codigo, nombre, domicilio, ciudad, codigociudad) y 
"ciudades" (codigo, nombre). Agregue una restricción "primary key" para el campo 
"codigo" de ambas tablas y una "foreing key" para validar que el campo 
"codigociudad" exista en "ciudades" con eliminación en cascada:*/
create table ciudades(
  codigo number(2),
  nombre varchar2(20),
  primary key (codigo)
);

create table clientes (
  codigo number(4),
  nombre varchar2(30),
  domicilio varchar2(30),
  codigociudad number(2) not null,
  primary key(codigo),
  constraint FK_clientes_ciudad
   foreign key (codigociudad)
   references ciudades(codigo)
   on delete cascade
);

--3 Ingrese algunos registros para ambas tablas:
insert into ciudades values(1,'Cordoba');
insert into ciudades values(2,'Cruz del Eje');
insert into ciudades values(3,'Carlos Paz');
insert into ciudades values(4,'La Falda');
insert into ciudades values(5,'Villa Maria');

insert into clientes values (100,'Lopez Marcos','Colon 111',1);
insert into clientes values (101,'Lopez Hector','San Martin 222',1);
insert into clientes values (105,'Perez Ana','San Martin 333',2);
insert into clientes values (106,'Garcia Juan','Rivadavia 444',3);
insert into clientes values (107,'Perez Luis','Sarmiento 555',3);
insert into clientes values (110,'Gomez Ines','San Martin 666',4);
insert into clientes values (111,'Torres Fabiola','Alem 777',5);
insert into clientes values (112,'Garcia Luis','Sucre 888',5);

--4 
/*Necesitamos conocer los nombres de las ciudades de aquellos clientes cuyo 
domicilio es en calle "San Martin", empleando subconsulta.*/
select nombre
from ciudades
where codigo in
    (select codigociudad
     from clientes
     where domicilio like 'San Martin %');
     
--5 Obtenga la misma salida anterior pero empleando join.
select distinct ci.nombre
from ciudades ci
join clientes cl
on codigociudad=ci.codigo
where domicilio like 'San Martin%';

--6 
/*Obtenga los nombre de las ciudades de los clientes cuyo apellido no 
comienza con una letra específica (letra "G"), empleando subconsulta.*/
select nombre
from ciudades
where codigo not in
    (select codigociudad
     from clientes
     where nombre like 'G%');
     
--7 
/*Pruebe la subconsulta del punto 6 separada de la consulta exterior para 
verificar que retorna una lista de valores de un solo campo.*/
select codigociudad
from clientes
where nombre like 'G%';