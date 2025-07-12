/*Primer Problema*/
--1 Eliminamos la tabla y la creamos:
drop table libros;

create table libros(
  codigo number(5),
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(20),
  precio number(5,2)
);

--2 Ingresamos los siguientes registros:
insert into libros values(1,'Alicia en el pais de las maravillas','Lewis Carroll','Emece',20.00);
insert into libros values(2,'Alicia en el pais de las maravillas','Lewis Carroll','Plaza',35.00);
insert into libros values(3,'Aprenda PHP','Mario Molina','Siglo XXI',40.00);
insert into libros values(4,'El aleph','Borges','Emece',10.00);
insert into libros values(5,'Ilusiones','Richard Bach','Planeta',15.00);
insert into libros values(6,'Java en 10 minutos','Mario Molina','Siglo XXI',50.00);
insert into libros values(7,'Martin Fierro','Jose Hernandez','Planeta',20.00); 
insert into libros values(8,'Martin Fierro','Jose Hernandez','Emece',30.00);
insert into libros values(9,'Uno','Richard Bach','Planeta',10.00);

--3 
/*Obtenemos la lista de los libros que han sido publicados por distintas 
editoriales empleando una consulta correlacionada:*/
select distinct l1.titulo
from libros l1
where l1.titulo in
  (select l2.titulo
    from libros l2 
    where l1.editorial <> l2.editorial);

--4 El siguiente "join" retorna el mismo resultado:
select distinct l1.titulo
from libros l1
join libros l2
on l1.titulo=l2.titulo
where l1.editorial<>l2.editorial;

--5 
/*Buscamos todos los libros que tienen el mismo precio que "El aleph" empleando 
subconsulta:*/
select titulo
from libros
where titulo<>'El aleph' and
  precio =
   (select precio
     from libros
     where titulo='El aleph');

--6 Obtenemos la misma salida empleando "join":
select l1.titulo
from libros l1
join libros  l2
on l1.precio=l2.precio
where l2.titulo='El aleph' and
l1.titulo<>l2.titulo;

--7 
/*Buscamos los libros cuyo precio supera el precio promedio de los libros por 
editorial:*/
select l1.titulo,l1.editorial,l1.precio
from libros l1
where l1.precio >
   (select avg(l2.precio) 
   from libros l2
    where l1.editorial= l2.editorial);

--8 Obtenemos la misma salida pero empleando un "join" con "having":
select l1.titulo,l1.editorial,l1.precio
from libros l1
join libros l2
on l1.editorial=l2.editorial
group by l1.editorial, l1.titulo, l1.precio
having l1.precio > avg(l2.precio);