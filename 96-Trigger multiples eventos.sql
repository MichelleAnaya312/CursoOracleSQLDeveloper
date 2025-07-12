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
  fecha date,
  operacion varchar2(20)
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
/*Creamos un disparador a nivel de sentencia, que se dispare cada vez que se ingrese, 
actualice o elimine un registro de la tabla "libros". El trigger ingresa en la tabla 
"control", el nombre del usuario, la fecha y la hora en la cual se realizó la 
modificación y el tipo de operación que se realizó:

- si se realizó una inserción (insert), se almacena "inserción";

- si se realizó una actualización (update), se almacena "actualización" y

- si se realizó una eliminación (delete) se almacena "borrado".*/

create or replace trigger tr_cambios_libros
 before insert or update or delete
 on libros
 for each row
begin
 if inserting then
   insert into control values (user, sysdate,'inserción');
 end if;
 if updating then
  insert into control values (user, sysdate,'actualización');
 end if;
 if deleting then
   insert into control values (user, sysdate,'borrado');
 end if;
end tr_cambios_libros;
/

--7 
/*Veamos qué nos informa el diccionario "user_triggers" respecto del trigger 
anteriormente creado:*/
select * from user_triggers where trigger_name ='TR_CAMBIOS_LIBROS';
/*obtenemos la siguiente información:

- trigger_name: nombre del disparador;

- trigger_type: momento y nivel, en este caso es un desencadenador "before" y a nivel 
de fila (each row);

- triggering_event: evento que lo dispara, en este caso, "insert or update or delete";

- base_object_type: a qué objeto está asociado, puede ser una tabla o una vista, en este
caso, una tabla (table);

- table_name: nombre de la tabla al que está asociado (libros);*/

--8 Ingresamos un registro en "libros":
insert into libros values(150,'El experto en laberintos','Gaskin','Planeta',23);

--9 Veamos si el trigger se disparó consultando la tabla "control":
select * from control;
/*Vemos que se ingresó un registro que muestra que el usuario "system", el día y hora 
actual realizó una inserción sobre "libros".*/

--10 Actualizamos algunos registros de "libros":
update libros set precio=precio+precio*0.1 where editorial='Planeta';

--11 Veamos cuántas veces el trigger se disparó consultando la tabla "control":
select * from control;
/*Vemos que se ingresaron 3 nuevos registros que muestran que el usuario "system", 
el día y hora actual actualizó tres registros de "libros". Si el trigger se hubiese 
definido a nivel de sentencia, el "update" anterior se hubiese disparado una sola vez.*/

--12  Eliminamos un registro de "libros":
delete from libros where codigo=145;

--13 Veamos si el trigger se disparó consultando la tabla "control":
select * from control;
--Vemos que se eliminó 1 registro.