/*Primer Problema*/
--1 Eliminamos la tabla:
drop table libros;

--2 Creamos la tabla:
create table libros(
  codigo number(5),
  titulo varchar2(40) not null,
  autor varchar2(20) default 'Desconocido',
  editorial varchar2(20),
  precio number(6,2),
  cantidad number(4) default 0,
  primary key (codigo)
);

--3 Ingresamos algunos registros:
 insert into libros (codigo,titulo,autor,editorial,precio)
  values(1,'El aleph','Borges','Emece',25);
 insert into libros
  values(2,'Java en 10 minutos','Mario Molina','Siglo XXI',50.40,100);
 insert into libros (codigo,titulo,autor,editorial,precio,cantidad)
  values(3,'Alicia en el pais de las maravillas','Lewis Carroll','Emece',15,50);

select * from libros;

--4 Queremos saber el monto total en dinero de cada libro:
select titulo, precio,cantidad,precio*cantidad
from libros;

--5 Queremos saber el precio de cada libro con un 10% de descuento:
select titulo,precio, precio-(precio*0.1)
from libros;

--6 Actualizamos los precios con un 10% de descuento y vemos el resultado:
update libros set precio=precio-(precio*0.1);
select * from libros;

--7 Queremos una columna con el título y autor de cada libro:
select titulo||'-'||autor
from libros;

--8 Mostramos el título y precio de cada libro concatenados:
select titulo||' $'||precio
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
/*El comercio quiere aumentar los precios de todos sus 
artículos en un 15%. Actualice todos los precios 
empleando operadores aritméticos.*/ 
update articulos set precio=precio+(precio*0.15);

--5 Vea el resultado.
select * from articulos;

--6 
/*Muestre todos los artículos, concatenando el nombre y la 
descripción de cada uno de ellos separados por coma.*/
select nombre||','||descripcion
  from articulos;

--7 
/*Reste a la cantidad de todas las impresoras, el valor 5, 
empleando el operador aritmético menos ("-")*/ 
update articulos set cantidad=cantidad-5
where nombre='impresora';

--8 
/*Recupere todos los datos de las impresoras para verificar
que la actualización se realizó.*/ 
select * from articulos where nombre='impresora';

--9 
/*Muestre todos los artículos concatenado 
los campos para que aparezcan de la siguiente 
manera "Cod. 101: impresora Epson Stylus C45 $460,92 (15)"*/
select 'Cod. '||codigo||': '||nombre||' '||descripcion||' $'||precio||' ('||cantidad||')'
from articulos;



