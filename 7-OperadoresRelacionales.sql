/*Primer Problema:
Trabajamos con la tabla "libros" de una librería.*/
--1 Eliminamos la tabla "libros":
drop table libros;

--2 La creamos con la siguiente estructura:
create table libros(
  titulo varchar2(30),
  autor varchar2(30),
  editorial varchar2(15),
  precio number(5,2)
 );

--3 Agregamos registros a la tabla:
insert into libros (titulo,autor,editorial,precio)
  values ('El aleph','Borges','Emece',24.50);
 insert into libros (titulo,autor,editorial,precio)
  values ('Martin Fierro','Jose Hernandez','Emece',16.00);
 insert into libros (titulo,autor,editorial,precio)
  values ('Aprenda PHP','Mario Molina','Emece',35.40);
 insert into libros (titulo,autor,editorial,precio)
  values ('Cervantes y el quijote','Borges','Paidos',50.90);

--4 Seleccionamos los registros cuyo autor sea diferente de 'Borges':
select * from libros where autor<>'Borges';

--5 
/*Seleccionamos los registros cuyo precio supere los 20 pesos, 
sólo el título y precio:*/
select titulo,precio from libros where precio>20;

--6 Recuperamos aquellos libros cuyo precio es menor o igual a 30:
select * from libros where precio<=30;


/*Segundo Problema: 
Un comercio que vende artículos de computación registra los datos de sus 
artículos en una tabla con ese nombre.*/

--1 Elimine "articulos"
drop table articulos;

--2 Cree la tabla, con la siguiente estructura:
create table articulos(
  codigo number(5),
  nombre varchar2(20),
  descripcion varchar2(30),
  precio number(6,2),
  cantidad number(3)
 );


--3 Vea la estructura de la tabla.
describe articulos;

--4 Ingrese algunos registros:
insert into articulos (codigo, nombre, descripcion, precio,cantidad)
  values (1,'impresora','Epson Stylus C45',400.80,20);
 insert into articulos (codigo, nombre, descripcion, precio,cantidad)
  values (2,'impresora','Epson Stylus C85',500,30);
 insert into articulos (codigo, nombre, descripcion, precio,cantidad)
  values (3,'monitor','Samsung 14',800,10);
 insert into articulos (codigo, nombre, descripcion, precio,cantidad)
  values (4,'teclado','ingles Biswal',100,50);
 insert into articulos (codigo, nombre, descripcion, precio,cantidad)
  values (5,'teclado','español Biswal',90,50);

select * from articulos;

--5 Seleccione los datos de las impresoras (2 registros)
select * from articulos where nombre = 'impresora';

--6 Seleccione los artículos cuyo precio sea mayor o igual a 400 (3 registros)
select * from articulos where precio >= 400; 

--7 
/*Seleccione el código y nombre de los artículos cuya 
cantidad sea menor a 30 (2 registros)*/
select codigo, nombre from articulos where cantidad <= 30;

--8
/*Selecciones el nombre y descripción de los artículos que NO cuesten 
$100 (4 registros)*/
select nombre, descripcion from articulos where precio <> 100;







