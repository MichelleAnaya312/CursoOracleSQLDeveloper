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

--3 Ingresamos los siguientes registros:
insert into libros values(1,'Alicia en el pais de las maravillas','Lewis Carroll','Emece',20.00);
insert into libros values(2,'Alicia en el pais de las maravillas','Lewis Carroll','Plaza',35.00);
insert into libros values(3,'Aprenda PHP','Mario Molina','Siglo XXI',40.00);
insert into libros values(4,'El aleph','Borges','Emece',10.00);
insert into libros values(5,'Ilusiones','Richard Bach','Planeta',15.00);
insert into libros values(6,'Java en 10 minutos','Mario Molina','Siglo XXI',50.00);
insert into libros values(7,'Martin Fierro','Jose Hernandez','Planeta',20.00);
insert into libros values(8,'Martin Fierro','Jose Hernandez','Emece',30.00);
insert into libros values(9,'Uno','Richard Bach','Planeta',10.00);

select * from libros;

--4 
/*Obtenemos el título, precio de un libro específico y la diferencia entre su 
precio y el máximo valor:*/
select titulo,precio,
precio-(select max(precio) from libros) as diferencia
from libros
where titulo='Uno';

--5 Mostramos el título y precio del libro más costoso:
select titulo,autor, precio
from libros
where precio=
(select max(precio) from libros);

--6 Actualizamos el precio del libro con máximo valor:
update libros set precio=45
where precio=
(select max(precio) from libros);

--7 Eliminamos los libros con precio menor:
delete from libros
where precio=
(select min(precio) from libros);

/*Segundo Problema*/

--1 Elimine la tabla:
drop table alumnos;

--2 
/*Créela con los campos necesarios. Agregue una restricción "primary key" para 
el campo "documento" y una "check" para validar que el campo "nota" se encuentre
entre los valores 0 y 10:*/
create table alumnos(
  documento char(8),
  nombre varchar2(30),
  nota number(4,2),
  primary key(documento),
  constraint CK_alumnos_nota_valores check (nota>=0 and nota <=10)
);

--3 Ingrese algunos registros:
insert into alumnos values('30111111','Ana Algarbe',5.1);
insert into alumnos values('30222222','Bernardo Bustamante',3.2);
insert into alumnos values('30333333','Carolina Conte',4.5);
insert into alumnos values('30444444','Diana Dominguez',9.7);
insert into alumnos values('30555555','Fabian Fuentes',8.5);
insert into alumnos values('30666666','Gaston Gonzalez',9.70);

select * from alumnos;

--4
/*Obtenga todos los datos de los alumnos con la nota más alta, empleando 
subconsulta*/
select alumnos.*
from alumnos
where nota=
(select max(nota) from alumnos);

--5
/* Realice la misma consulta anterior pero intente que la consulta interna 
retorne, además del máximo valor de nota, el nombre del alumno.*/
select alumnos.*
from alumnos
where nota=
(select nombre, max(nota) from alumnos);
/*Mensaje de error, porque la lista de selección de una subconsulta que va 
luego de un operador de comparación puede incluir sólo un campo o expresión 
(excepto si se emplea "exists" o "in").*/

--6
/*Muestre los alumnos que tienen una nota menor al promedio, su nota, y la 
diferencia con el promedio.*/
select documento, nombre, nota,
(select avg(nota) from alumnos)-nota as diferencia
from alumnos
where nota<
(select avg(nota) from alumnos);

--7 Cambie la nota del alumno que tiene la menor nota por 4.
update alumnos set nota=4
where nota=
(select min(nota) from alumnos);

--8 Elimine los alumnos cuya nota es menor al promedio.
delete from alumnos
where nota<
(select avg(nota) from alumnos);