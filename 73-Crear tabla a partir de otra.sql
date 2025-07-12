/*Primer Problema*/
--1 Eliminamos las tablas "libros" y "editoriales":
drop table libros;

drop table editoriales;

--2 Creamos la tabla "libros":
create table libros( 
  codigo number(5),
  titulo varchar2(40) not null,
  autor varchar2(30),
  editorial varchar2(20),
  precio number(5,2),
  primary key(codigo)
); 

--3 Ingresamos algunos registros;
insert into libros values(1,'Uno','Richard Bach','Planeta',15);
insert into libros values(2,'El aleph','Borges','Emece',25);
insert into libros values(3,'Matematica estas ahi','Paenza','Nuevo siglo',18);
insert into libros values(4,'Aprenda PHP','Mario Molina','Nuevo siglo',45);
insert into libros values(5,'Ilusiones','Richard Bach','Planeta',14);
insert into libros values(6,'Java en 10 minutos','Mario Molina','Nuevo siglo',50);

--4 
/*Creamos una tabla llamada "editoriales" que contenga los nombres de las 
editoriales obteniendo tales nombres de la tabla "libros":*/
create table editoriales as
  (select distinct editorial as nombre
   from libros);

--5 Veamos la nueva tabla:
select * from editoriales;

--6
/*Necesitamos una nueva tabla llamada "librosporeditorial" que contenga la 
cantidad de libros de cada editorial. Primero eliminamos la tabla:*/
drop table cantidadporeditorial;

--7 Creamos la nueva tabla empleando una subconsulta:
create table cantidadporeditorial as
  (select editorial as nombre,count(*) as cantidad
  from libros
  group by editorial);

--8 Veamos los registros de la nueva tabla:
select * from cantidadporeditorial;
/*La tabla "cantidadporeditorial" se ha creado con el campo llamado "nombre" 
seleccionado del campo "editorial" de "libros" y con el campo "cantidad" con 
el valor calculado con count(*) de la tabla "libros".*/

--9 
/*Queremos una tabla llamada "ofertas20" que contenga los mismos campos que 
"libros" y guarde los libros con un precio menor o igual a 20. Primero 
eliminamos la tabla "ofertas20":*/
drop table ofertas20;

--10 Creamos "ofertas20" e insertamos la consulta de "libros":
create table ofertas20 as
  (select * from libros
  where precio<=20)
  order by precio desc;
/*La consulta anterior retorna los libros de la tabla "libros" cuyo precio es 
menor o igual a 20 y los almacena en la nueva tabla ("ofertas20") ordenados en 
forma descendente por precio. Note que no se listan los campos a extraer, se 
coloca un asterisco para indicar que se incluyen todos los campos.*/

--11 Veamos los registros de la nueva tabla:
select * from ofertas20;

--12
/*Agregamos una columna a la tabla "editoriales" que contiene la ciudad en la 
cual está la casa central de cada editorial:*/
alter table editoriales add ciudad varchar2(30);

--13 Actualizamos dicho campo:
update editoriales set ciudad='Cordoba' where nombre='Planeta';
update editoriales set ciudad='Cordoba' where nombre='Emece';
update editoriales set ciudad='Buenos Aires' where nombre='Nuevo siglo';

--14 
/*Queremos una nueva tabla llamada "librosdecordoba" que contenga los títulos y
autores de los libros de editoriales de Cordoba. En primer lugar, la eliminamos:*/
drop table librosdecordoba;

--15 
/*Consultamos las 2 tablas y guardamos el resultado en la nueva tabla que 
estamos creando:*/
create table librosdecordoba as
  (select titulo,autor from libros
  join editoriales
  on editorial=nombre 
  where ciudad='Cordoba');

--16 Consultamos la nueva tabla:
select * from librosdecordoba;