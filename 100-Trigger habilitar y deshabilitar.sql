/*Primer Problema*/
--1 Eliminamos las tablas:
drop table empleados;

drop table controlCambios;

--2 Creamos las tablas, con las siguientes estructuras:
create table empleados(
  documento char(8) not null,
  nombre varchar2(30) not null,
  domicilio varchar2(30),
  seccion varchar2(20)
);

create table controlCambios(
  usuario varchar2(30),
  fecha date,
  datoanterior varchar2(30),
  datonuevo varchar2(30)
);

--3 Ingresamos algunos registros:
insert into empleados values('22222222','Ana Acosta','Bulnes 56','Secretaria');
insert into empleados values('23333333','Bernardo Bustos','Bulnes 188','Contaduria');
insert into empleados values('24444444','Carlos Caseres','Caseros 364','Sistemas');
insert into empleados values('25555555','Diana Duarte','Colon 1234','Sistemas');
insert into empleados values('26666666','Diana Duarte','Colon 897','Sistemas');
insert into empleados values('27777777','Matilda Morales','Colon 542','Gerencia');

--4 
/*Creamos un disparador que se active cuando modificamos algún campo de "empleados" y 
almacene en "controlCambios" el nombre del usuario que realiza la actualización, la 
fecha, el dato que se cambia y el nuevo valor:*/
create or replace trigger tr_actualizar_empleados
  before update
  on empleados
  for each row
 begin
  if updating('documento') then
   insert into controlCambios values(user,sysdate, :old.documento, :new.documento);
  end if;
  if updating('nombre') then
   insert into controlCambios values(user,sysdate, :old.nombre, :new.nombre);
  end if;
  if updating('domicilio') then
   insert into controlCambios values(user,sysdate, :old.domicilio, :new.domicilio);
  end if;
  if updating('seccion') then
   insert into controlCambios values(user,sysdate, :old.seccion, :new.seccion);
  end if;
 end tr_actualizar_empleados;
 /

--5 
/*Creamos otro desencadenador que se active cuando ingresamos un nuevo registro en 
"empleados", debe almacenar en "controlCambios" el nombre del usuario que realiza el 
ingreso, la fecha, "null" en "datoanterior" (porque se dispara con una inserción) y 
en "datonuevo" el documento:*/
create or replace trigger tr_ingresar_empleados
  before insert
  on empleados
  for each row
 begin
   insert into controlCambios values(user,sysdate, null, :new.documento);
 end tr_ingresar_empleados;
 /

--6 
/*Creamos un tercer trigger sobre "empleados" que se active cuando eliminamos un 
registro en "empleados", debe almacenar en "controlCambios" el nombre del usuario 
que realiza la eliminación, la fecha, el documento en "datoanterior" y "null" en 
"datonuevo":*/
create or replace trigger tr_eliminar_empleados
  before delete
  on empleados
  for each row
 begin
   insert into controlCambios values(user,sysdate, :old.documento, null);
 end tr_eliminar_empleados;
 /

--7
/*Los tres triggers están habilitados. Consultamos el diccionario "user_triggers" 
para corroborarlo:*/
select trigger_name, triggering_event, status
  from user_triggers
  where trigger_name like 'TR%EMPLEADOS';

--8 
/*Vamos a ingresar un empleado y comprobar que el trigger "tr_ingresar_empleados" 
se dispara recuperando los registros de "controlCambios":*/
insert into empleados values('28888888','Pedro Perez','Peru 374','Secretaria');
select * from controlCambios;

--9 Deshabilitamos el trigger "tr_ingresar_empleados":
alter  trigger tr_ingresar_empleados disable;

--10 Consultamos el diccionario "user_triggers" para corroborarlo:
select trigger_name, status
  from user_triggers
  where trigger_name like 'TR%EMPLEADOS';
/*El trigger "tr_ingresar_empleados" está deshabilitado, "tr_actualizar_empleados" y 
"tr_elimnar_empleados" están habilitados.*/

--11
/*Vamos a ingresar un empleado y comprobar que el trigger de inserción no se dispara 
recuperando los registros de "controlCambios":*/
insert into empleados values('29999999','Rosa Rodriguez','Rivadavia 627','Secretaria');
select * from controlCambios;

--12 
/*Vamos a actualizar el domicilio de un empleado y comprobar que el trigger de 
actualización se dispara recuperando los registros de "controlCambios":*/
update empleados set domicilio='Bulnes 567' where documento='22222222';
select * from controlCambios;

--13 Deshabilitamos el trigger "tr_actualizar_empleados":
alter  trigger tr_actualizar_empleados disable;

--14 Consultamos el diccionario "user_triggers" para corroborarlo:
select trigger_name, status
  from user_triggers
  where trigger_name like 'TR%EMPLEADOS';
/*Los triggers "tr_ingresar_empleados" y "tr_actualizar_empleados" están deshabilitados,
"tr_eliminar_empleados" está habilitado.*/

--15
/*Vamos a borrar un empleado de "empleados" y comprobar que el trigger de borrado se 
disparó recuperando los registros de "controlCambios":*/
delete from empleados where documento= '29999999';
select * from controlCambios;

--16 Deshabilitamos el trigger "tr_eliminar_empleados":
alter  trigger tr_eliminar_empleados disable;

--17 Consultamos el diccionario "user_triggers" para comprobarlo:
select trigger_name, status
  from user_triggers
  where table_name = 'EMPLEADOS';
--Los tres trigger establecidos sobre "empleados" están deshabilitados.

--18 
/*Eliminamos un empleado de "empleados" y comprobamos que el trigger de borrado no se
dispara recuperando los registros de "controlCambios":*/
delete from empleados where documento= '28888888';
select * from controlCambios;

--19 Habilitamos el trigger "tr_actualizar_empleados":
alter  trigger tr_actualizar_empleados enable;

--20 
/*Actualizamos la sección de un empleado y comprobamos que el trigger de actualización 
se dispara recuperando los registros de "controlCambios":*/
update empleados set seccion='Sistemas' where documento='23333333';
select * from controlCambios;

--21 Habilitamos todos los triggers establecidos sobre "empleados":
alter table empleados enable all triggers;

--22 
/*Consultamos el diccionario "user_triggers" para comprobar que el estado (status) de 
todos los triggers establecidos sobre "empleados" es habilitado:*/
select trigger_name, triggering_event, status
  from user_triggers
  where table_name = 'EMPLEADOS';
/*Los tres trigger establecidos sobre "empleados" han sido habilitados. Se activarán 
ante cualquier sentencia "insert", "update" y "delete".*/