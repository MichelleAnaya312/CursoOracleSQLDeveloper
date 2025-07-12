/*Primer Problema*/
--1 Eliminamos la tabla y la creamos con la siguiente estructura:
drop table libros;

create table libros(
  titulo varchar2(40) not null,
  autor varchar2(20) default 'Desconocido',
  editorial varchar2(20),
  edicion date,
  precio number(6,2)
);

--3 Ingresamos algunos registros:
insert into libros values('El aleph','Borges','Emece','10/10/1980',25.33);
insert into libros values('Java en 10 minutos','Mario Molina','Siglo XXI','05/12/2005',50.65);
insert into libros values('Alicia en el pais de las maravillas','Lewis Carroll','Emece','29/11/2000',19.95);
insert into libros values('Alicia en el pais de las maravillas','Lewis Carroll','Planeta','27/11/2004',15);

select * from libros;
--4 Recuperamos los registros ordenados por el título:
select * from libros
order by titulo;

--5 
/*Ordenamos los registros por el campo "precio", referenciando el campo por 
su posición en la lista de selección:*/
select titulo,autor,precio
from libros order by 3;

--6 Los ordenamos por "editorial", de mayor a menor empleando "desc":
select * from libros
order by editorial desc;

--7 Ordenamos por dos campos:
select * from libros
order by titulo,editorial;

--8 Ordenamos en distintos sentidos:
select * from libros
order by titulo asc, editorial desc;

--9 Podemos ordenar por un campo que no se lista en la selección:
select titulo, autor
from libros
order by precio;

--10 Está permitido ordenar por valores calculados, lo hacemos:
select titulo, editorial,
precio+(precio*0.1) as "precio con descuento"
from libros
order by 3;

--11 Ordenamos los libros por la fecha de edición:
select titulo, editorial, edicion
from libros
order by edicion;

--12 
/*Mostramos el título y año de edición de todos los libros, 
ordenados por año de edición:*/
select titulo, extract (year from edicion) as edicion
from libros
order by 2;

/*Segundo Problema*/
--1 Elimine la tabla "visitas" y créela con la siguiente estructura:
 drop table visitas;
 
 create table visitas (
  nombre varchar2(30) default 'Anonimo',
  mail varchar2(50),
  pais varchar2(20),
  fecha date
);
--2 Ingrese algunos registros:
insert into visitas values ('Ana Maria Lopez','AnaMaria@hotmail.com','Argentina',to_date('2020/05/03 21:02:44', 'yyyy/mm/dd hh24:mi:ss'));
insert into visitas values ('Gustavo Gonzalez','GustavoGGonzalez@hotmail.com','Chile',to_date('2020/02/13 11:08:10', 'yyyy/mm/dd hh24:mi:ss'));
insert into visitas values ('Juancito','JuanJosePerez@hotmail.com','Argentina',to_date('2020/07/02 14:12:00', 'yyyy/mm/dd hh24:mi:ss'));
insert into visitas values ('Fabiola Martinez','MartinezFabiola@hotmail.com','Mexico',to_date('2020/06/17 20:00:00', 'yyyy/mm/dd hh24:mi:ss'));
insert into visitas values ('Fabiola Martinez','MartinezFabiola@hotmail.com','Mexico',to_date('2020/02/08 20:05:40', 'yyyy/mm/dd hh24:mi:ss'));
insert into visitas values ('Juancito','JuanJosePerez@hotmail.com','Argentina',to_date('2020/07/06 18:00:00', 'yyyy/mm/dd hh24:mi:ss'));
insert into visitas values ('Juancito','JuanJosePerez@hotmail.com','Argentina',to_date('2019/10/05 23:00:00', 'yyyy/mm/dd hh24:mi:ss'));

select * from visitas;
--3 Ordene los registros por fecha, en orden descendente.
select * from visitas order by fecha desc;

--4 
/*Muestre el nombre del usuario, pais y el mes, ordenado por pais 
(ascendente) y el mes (descendente)*/
select nombre,pais,extract(month from fecha)
from visitas
order by 2,3 desc;

--5 
/*Muestre los mail, país, ordenado por país, de todos los que visitaron 
la página en octubre (4 registros)*/
select mail, pais
from visitas
where extract(month from fecha)=10
order by 2;