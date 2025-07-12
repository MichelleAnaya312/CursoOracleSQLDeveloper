/*Primer Problema*/
--1 Eliminamos la tabla:
drop table libros;

--2 Creamos la tabla:
create table libros(
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(15)
);

--3 Ingresamos algunos registros:
insert into libros
values('El aleph','Borges','Planeta');
insert into libros
values('Martin Fierro','Jose Hernandez','Emece');
insert into libros
values('Martin Fierro','Jose Hernandez','Planeta');
insert into libros
values('Antologia poetica','Borges','Planeta');
insert into libros
values('Aprenda PHP','Mario Molina','Emece');
insert into libros
values('Aprenda PHP','Lopez','Emece');
insert into libros
values('Manual de PHP', 'J. Paez', null);
insert into libros
values('Cervantes y el quijote',null,'Paidos');
insert into libros
values('Harry Potter y la piedra filosofal','J.K. Rowling','Emece');
insert into libros
values('Harry Potter y la camara secreta','J.K. Rowling','Emece');
insert into libros
values('Alicia en el pais de las maravillas','Lewis Carroll','Paidos');
insert into libros
values('Alicia en el pais de las maravillas','Lewis Carroll','Planeta');
insert into libros
values('PHP de la A a la Z',null,null);
insert into libros
values('Uno','Richard Bach','Planeta');

select * from libros;

--4 Para obtener la lista de autores sin repetición tipeamos:
select distinct autor from libros;
/*Note que aparece "null" como un valor para "autor"· */

--5 
/*Para obtener la lista de autores conocidos, es decir, 
no incluyendo "null" en la lista:*/
select distinct autor from libros
where autor is not null;

--6 Contamos los distintos autores:
select count(distinct autor)
from libros;

--7 Queremos los nombres de las editoriales sin repetir:
select distinct editorial from libros;

--8 Queremos saber la cantidad de editoriales distintas:
select count(distinct editorial) from libros;

--9 
/*La combinamos con "where" para obtener los distintos 
autores de la editorial "Planeta":*/
select distinct autor from libros
where editorial='Planeta';

--10 
/*Contamos los distintos autores que tiene cada editorial 
empleando "group by":*/
select editorial,count(distinct autor)
from libros
group by editorial;

--11 
/*Mostramos los títulos y editoriales de los libros sin 
repetir títulos ni editoriales:*/
select distinct titulo,editorial
from libros
order by titulo;
/*Note que los registros no están duplicados, 
aparecen títulos iguales pero con editorial 
diferente, cada registro es diferente.*/

/*Segundo Problema*/
--1 Elimine la tabla "clientes" y créela con la siguiente estructura:
drop table clientes;

create table clientes (
  nombre varchar2(30) not null,
  domicilio varchar2(30),
  ciudad varchar2(20),
  provincia varchar2(20)
);

--2 Ingrese algunos registros:
insert into clientes
values ('Lopez Marcos','Colon 111','Cordoba','Cordoba');
insert into clientes
values ('Perez Ana','San Martin 222','Cruz del Eje','Cordoba');
insert into clientes
values ('Garcia Juan','Rivadavia 333','Villa del Rosario','Cordoba');
insert into clientes
values ('Perez Luis','Sarmiento 444','Rosario','Santa Fe');
insert into clientes
values ('Pereyra Lucas','San Martin 555','Cruz del Eje','Cordoba');
insert into clientes
values ('Gomez Ines','San Martin 666','Santa Fe','Santa Fe');
insert into clientes
values ('Torres Fabiola','Alem 777','Villa del Rosario','Cordoba');
insert into clientes
values ('Lopez Carlos',null,'Cruz del Eje','Cordoba');
insert into clientes
values ('Ramos Betina','San Martin 999','Cordoba','Cordoba');
insert into clientes
values ('Lopez Lucas','San Martin 1010','Posadas','Misiones');

select * from clientes;

--3 Obtenga las provincias sin repetir (3 registros)
select distinct provincia from clientes;

--4 Cuente las distintas provincias (retorna 3)
select count(distinct provincia) as cantidad
from clientes;

--5 Se necesitan los nombres de las ciudades sin repetir (6 registros)
select distinct ciudad from clientes;

--6 Obtenga la cantidad de ciudades distintas (devuelve 6)
select count(distinct ciudad) from clientes;

--7 
/*Combine con "where" para obtener las distintas ciudades de la provincia 
de Cordoba (3 registros)*/
select distinct ciudad from clientes
where provincia='Cordoba';

--8 
/*Contamos las distintas ciudades de cada provincia empleando 
"group by" (3 filas)*/
select provincia,count(distinct ciudad)
from clientes
group by provincia;


