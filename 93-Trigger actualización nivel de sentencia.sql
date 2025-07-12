/*Primer Problema*/
--1 Eliminamos la tabla "libros" y la tabla "control":
drop table libros;

drop table control;

--2 Creamos la tabla con la siguiente estructura:
create table libros(
  codigo number(6),
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(20),
  precio number(6,2)
);

--3 Creamos la tabla "control":
create table control(
  usuario varchar2(30),
  fecha date
);

--4 Ingresamos algunos registros en "libros":
insert into libros values(100,'Uno','Richard Bach','Planeta',25);
insert into libros values(103,'El aleph','Borges','Emece',28);
insert into libros values(105,'Matematica estas ahi','Paenza','Nuevo siglo',12);
insert into libros values(120,'Aprenda PHP','Molina Mario','Nuevo siglo',55);
insert into libros values(145,'Alicia en el pais de las maravillas','Carroll','Planeta',35);

--5 Establecemos el formato de fecha para que muestre "DD/MM/YYYY HH24:MI":
alter session set NLS_DATE_FORMAT = 'DD/MM/YYYY HH24:MI';

--6 
/*Creamos un disparador a nivel de sentencia, que se dispare cada vez que se actualice 
un registro en "libros"; el trigger debe ingresar en la tabla "control", el nombre del
usuario, la fecha y la hora en la cual se realizó un "update" sobre "libros":*/
create or replace trigger tr_actualizar_libros
  before update
  on libros
 begin
  insert into control values(user,sysdate);
 end tr_actualizar_libros;
 /

--7 
/*Veamos qué nos informa el diccionario "user_triggers" respecto del trigger 
anteriormente creado:*/
select * from user_triggers where trigger_name ='TR_ACTUALIZAR_LIBROS';

/*obtenemos la siguiente información:

- trigger_name: nombre del disparador;

- trigger_type: momento y nivel, en este caso es un desencadenador "before" y a 
nivel de sentencia (statement);

- triggering_event: evento que lo dispara, en este caso, "update";

- base_object_type: a qué objeto está asociado, puede ser una tabla o una vista, 
en este caso, una tabla (table);

- table_name: nombre de la tabla al que está asociado (libros);

- y otras columnas que no analizaremos por el momento.*/

--8 Actualizamos un registro en "libros":
update libros set codigo=99 where codigo=100;

--9 Veamos si el trigger se disparó consultando la tabla "control":
select * from control;

--10 Actualizamos varios registros de "libros":
update libros set precio=precio+precio*0.1 where editorial='Nuevo siglo';

--11 Veamos si el trigger se disparó consultando la tabla "control":
select * from control;
/*Note que se modificaron 2 registros de "libros", pero como la modificación se realizó
con una sola sentencia "update" y el trigger es a nivel de sentencia, se agregó 
solamente una fila a la tabla "control"; si el trigger hubiese sido creado a nivel
de fila, la sentencia anterior, hubiese disparado el trigger 2 veces y habría ingresado
en "control" 2 filas.*/