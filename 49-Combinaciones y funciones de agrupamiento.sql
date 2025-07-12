/*Primer Problema*/
--1 Eliminamos ambas tablas y las creamos:
drop table libros;

drop table editoriales;

create table libros(
  codigo number(5),
  titulo varchar2(40),
  autor varchar2(30),
  codigoeditorial number(3),
  precio number(5,2),
  primary key(codigo)
);

create table editoriales(
  codigo number(3),
  nombre varchar2(20),
  primary key (codigo)
);

--2 Ingresamos algunos registros en ambas tablas:
insert into editoriales values(1,'Planeta');
insert into editoriales values(2,'Emece');
insert into editoriales values(3,'Siglo XXI');

insert into libros values(100,'El aleph','Borges',1,20);
insert into libros values(200,'Martin Fierro','Jose Hernandez',1,30);
insert into libros values(300,'Aprenda PHP','Mario Molina',3,50);
insert into libros values(400,'Uno','Richard Bach',3,15);
insert into libros values(500,'Java en 10 minutos',default,4,45);

--3 Contamos la cantidad de libros de cada editorial consultando ambas tablas:
select e.nombre as editorial,
count(*) as cantidad
from editoriales e
join libros l
on codigoeditorial=e.codigo
group by e.nombre;
/*Note que las editoriales que no tienen libros no aparecen en la salida 
porque empleamos un "join".*/

--4 Buscamos el libro más costoso de cada editorial con un "left join":
select e.nombre as editorial,
max(precio) as "mayor precio"
from editoriales e
left join libros l
on codigoeditorial=e.codigo
group by e.nombre;
/*La sentencia anterior mostrará, para la editorial de la cual no haya libros, 
el valor "null" en la columna calculada.*/

/*Segundo Problema*/
--1 Elimine las tablas:
drop table visitantes;

drop table ciudades;

--2 Cree las tablas:
create table visitantes(
  nombre varchar2(30),
  edad number(2),
  sexo char(1) default 'f',
  domicilio varchar2(30),
  codigociudad number(2),
  mail varchar(30),
  montocompra decimal (6,2)
);

create table ciudades(
  codigo number(2),
  nombre varchar(20)
);
 
--3 Ingrese algunos registros:
insert into ciudades values(1,'Cordoba');
insert into ciudades values(2,'Carlos Paz');
insert into ciudades values(3,'La Falda');
insert into ciudades values(4,'Cruz del Eje');

insert into visitantes values ('Susana Molina', 35,'f','Colon 123', 1, null,59.80);
insert into visitantes values ('Marcos Torres', 29,'m','Sucre 56', 1, 'marcostorres@hotmail.com',150.50);
insert into visitantes values ('Mariana Juarez', 45,'f','San Martin 111',2,null,23.90);
insert into visitantes values ('Fabian Perez',36,'m','Avellaneda 213',3,'fabianperez@xaxamail.com',0); 
insert into visitantes values ('Alejandra Garcia',28,'f',null,2,null,280.50);
insert into visitantes values ('Gaston Perez',29,'m',null,5,'gastonperez1@gmail.com',95.40);
insert into visitantes values ('Mariana Juarez',33,'f',null,2,null,90);

--4 
/*Cuente la cantidad de visitas por ciudad mostrando el nombre de la ciudad 
(3 filas)*/
select c.nombre,
count(*) as cantidad
from ciudades c
join visitantes v
on codigociudad=c.codigo
group by c.nombre;
  
--5
/*Muestre el promedio de gastos de las visitas agrupados por ciudad y sexo 
(4 filas)*/
select c.nombre,sexo,
avg(montocompra) as "promedio de compra"
from ciudades c
join visitantes v
on codigociudad=c.codigo
group by c.nombre,sexo;
  
--6 
/*Muestre la cantidad de visitantes con mail, agrupados por ciudad (3 filas)*/
select c.nombre,
count(mail) as "tienen mail"
from ciudades c
join visitantes v
on codigociudad=c.codigo
group by c.nombre;

--7 Obtenga el monto de compra más alto de cada ciudad (3 filas)
select c.nombre,
max(montocompra)
from visitantes v
join ciudades c
on codigociudad=c.codigo
group by c.nombre;
  
--8 Realice la misma consulta anterior pero con "left join" (4 filas)
select c.nombre,
max(montocompra)
from visitantes v
left join ciudades c
on codigociudad=c.codigo
group by c.nombre;
/*Note que aparece el monto "95,4" con valor nulo en el campo correspondiente 
a la ciudad, ya que ese registro tiene un valor inexistente en "ciudades".*/