/*Primer Problema*/
/*Una librería almacena los datos de sus libros en una tabla denominada "libros" y en 
una tabla "ofertas", algunos datos de los libros cuyo precio no supera los $30. Además, 
controla las inserciones que los empleados realizan sobre "ofertas", almacenando en la 
tabla "control" el nombre del usuario, la fecha y hora, cada vez que se ingresa un nuevo
registro en la tabla "ofertas".

Creamos un desencadenador que se dispara una vez por cada registro ingresado en la tabla
"ofertas":*/

--1 Eliminamos las tres tablas:
drop table libros;

drop table ofertas;

drop table control;

--2 Creamos las tablas con las siguientes estructuras:
create table libros(
  codigo number(6),
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(20),
  precio number(6,2)
);

create table ofertas(
  titulo varchar2(40),
  autor varchar2(30),
  precio number(6,2)
);

create table control(
  usuario varchar2(30),
  fecha date
);

--3 Establecemos el formato de fecha para que muestre "DD/MM/YYYY HH24:MI":
alter session set NLS_DATE_FORMAT = 'DD/MM/YYYY HH24:MI';

--4 
/*Creamos un disparador que se dispare una vez por cada registro ingresado en "ofertas";
el trigger debe ingresar en la tabla "control", el nombre del usuario, la fecha y la 
hora en la cual se realizó un "insert" sobre "ofertas":*/
create or replace trigger tr_ingresar_ofertas
  before insert
  on ofertas
  for each row
 begin
  insert into Control values(user,sysdate);
 end tr_ingresar_ofertas;
 /
 
--5 
/*Veamos qué nos informa el diccionario "user_triggers" respecto del trigger 
anteriormente creado:*/
select * from user_triggers where trigger_name ='TR_INGRESAR_OFERTAS';

--6 Ingresamos algunos registros en "libros":
insert into libros values(100,'Uno','Richard Bach','Planeta',25);
insert into libros values(102,'Matematica estas ahi','Paenza','Nuevo siglo',12);
insert into libros values(105,'El aleph','Borges','Emece',32);
insert into libros values(120,'Aprenda PHP','Molina Mario','Nuevo siglo',55);

--7 
/*Ingresamos en "ofertas" los libros de "libros" cuyo precio no superen los $30, 
utilizando la siguiente sentencia:*/
insert into ofertas select titulo,autor,precio from libros where precio<30;

--8 
/*Verificamos que el trigger se disparó 2 veces, una por cada fila afectada en la 
sentencia "insert" anteriormente ejecutada; consultamos la tabla "control":*/
select * from control;
/*Si el trigger hubiese sido creado a nivel de sentencia, no de fila, el "insert" 
anterior se hubiese activado una sola vez aun cuando se ingresaron 2 registros.*/