/*Primer Problema*/
--1 Eliminamos la tabla:
drop table libros;

--2 Creamos la tabla con la siguiente estructura:
create table libros(
  codigo number(6),
  titulo varchar2(40),
  autor varchar2(30),
  precio number(6,2)
);

--3 Creamos la tabla "control", antes la eliminamos:
drop table control;

create table control(
  usuario varchar2(30),
  fecha date
);

--4 
/*Creamos un disparador que se dispare cada vez que se ingrese un registro en "libros";
el trigger debe ingresar en la tabla "control", el nombre del usuario, la fecha y la 
hora en la cual se realizó un "insert" sobre "libros":*/
create or replace trigger tr_ingresar_libros
  before insert
  on libros
 begin
  insert into Control values(user,sysdate);
 end tr_ingresar_libros;
 /
 
--5 Establecemos el formato de fecha para que muestre "DD/MM/YYYY HH24:MI":
alter session set NLS_DATE_FORMAT = 'DD/MM/YYYY HH24:MI';

--6 
/*Veamos qué nos informa el diccionario "user_triggers" respecto del trigger 
anteriormente creado:*/
select * from user_triggers where trigger_name ='TR_INGRESAR_LIBROS';

--obtenemos la siguiente información:
-- trigger_name: nombre del disparador;
/* trigger_type: momento y nivel, en este caso es un desencadenador "before" y a nivel 
de sentencia (statement);*/
-- triggering_event: evento que lo dispara, en este caso, "insert";
/* base_object_type: a qué objeto está asociado, puede ser una tabla o una vista, en
este caso, una tabla (table);*/
-- table_name: nombre de la tabla al que está asociado (libros);
-- y otras columnas que no analizaremos por el momento.

--7 Ingresamos un registro en "libros":
insert into libros values(100,'Uno','Richard Bach',25);

--8
/*Verificamos que el trigger se disparó consultando la tabla "control" para ver si 
tiene un nuevo registro:*/
select * from control;

--9 Ingresamos dos registros más en "libros":
insert into libros values(150,'Matematica estas ahi','Paenza',12);
insert into libros values(185,'El aleph','Borges',42);

--10 
/*Verificamos que el trigger se disparó consultando la tabla "control" para ver si 
tiene dos nuevos registros:*/
select * from control;