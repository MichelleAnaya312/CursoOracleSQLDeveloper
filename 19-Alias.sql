/*Primer Problema*/
drop table libros;

create table libros(
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(20),
  precio number(5,2),
  cantidad number(4)
 );

insert into libros
  values('Uno','Richard Bach','Planeta',15,100);
insert into libros
  values('El aleph','Borges','Emece',24,150);
insert into libros
  values('Matematica estas ahi','Paenza','Nuevo siglo',12.5,200);

select * from libros;

/*Mostramos la información con el encabezado "stock" 
para el campo "cantidad":*/
select titulo,
  cantidad as stock,
  precio
  from libros;

/*Mostramos la información con el encabezado 
"stock disponible" para el campo "cantidad", 
necesitamos emplear comillas dobles:*/
select titulo,
  cantidad as "stock disponible",
  precio
  from libros;

/*Recuperamos el título, autor, precio, descuento del 10% 
y precio final con descuento, empleando un alias para las 2 
últimas columnas:*/
select titulo,autor,precio,
  precio*0.1 as descuento,
  precio-(precio*0.1) as "precio final"
  from libros;

/*La palabra clave "as" es opcional, podemos obviarla:*/
select titulo,precio,
  precio-(precio*0.1) "precio con descuento"
  from libros;

/*Segundo Problema*/
--1 Elimine la tabla:
drop table articulos;

--2 Cree la tabla:
create table articulos(
  codigo number(4),
  nombre varchar2(20),
  descripcion varchar2(30),
  precio number(8,2),
  cantidad number(3) default 0,
  primary key (codigo)
);

--3 Ingrese algunos registros:
insert into articulos
values (101,'impresora','Epson Stylus C45',400.80,20);
insert into articulos
values (203,'impresora','Epson Stylus C85',500,30);
insert into articulos
values (205,'monitor','Samsung 14',800,10);
insert into articulos
values (300,'teclado','ingles Biswal',100,50);
  
--4 
/*El comercio hace un descuento del 15% en ventas 
mayoristas. Necesitamos recuperar el código, nombre, 
decripción de todos los artículos con una columna extra 
que muestre el precio de cada artículo para la venta 
mayorista con el siguiente encabezado "precio mayorista"*/
select codigo, nombre, descripcion, precio, precio-(precio*.15) as "precio mayorista"
from articulos;
 
--5 
/*Muestre los precios de todos los artículos, concatenando 
el nombre y la descripción con el encabezado "artículo" 
(sin emplear "as" ni comillas)*/
select nombre||' '||descripcion articulo, precio
from articulos;

--6 
/*Muestre todos los campos de los artículos y un campo 
extra, con el encabezado "monto total" en la que calcule el 
monto total en dinero de cada artículo (precio por cantidad)*/
select codigo,nombre,descripcion, precio, cantidad,
precio*cantidad "Monto Total"
from articulos;

--7 
/*Muestre la descripción de todas las impresoras junto 
al precio con un 20% de recargo con un encabezado que lo 
especifique.*/
select descripcion, precio+(precio*.2) as recargado
from articulos where nombre='impresora';








