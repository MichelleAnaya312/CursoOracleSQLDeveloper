/*Primer Problema*/
--1 Eliminamos la tabla: 
drop table empleados;

--2 Creamos las tablas:
create table empleados(
  documento char(8),
  sexo char(1)
   constraint CK_empleados_sexo check (sexo in ('f','m')),
  apellido varchar2(20),
  nombre varchar2(20),
  domicilio varchar2(30),
  seccion varchar2(30),
  cantidadhijos number(2),
  constraint CK_empleados_hijos check (cantidadhijos>=0),
  estadocivil char(10)
   constraint CK_empleados_estadocivil check (estadocivil in ('casado','divorciado','soltero','viudo')),
  fechaingreso date
);

--3 Ingresamos algunos registros:
insert into empleados values('22222222','f','Lopez','Ana','Colon 123','Administracion',2,'casado','10/10/1990');
insert into empleados values('23333333','m','Lopez','Luis','Sucre 235','Administracion',0,'soltero','02/10/1990');
insert into empleados values('24444444','m','Garcia','Marcos','Sarmiento 1234','Contaduria',3,'divorciado','07/12/1998');
insert into empleados values('25555555','m','Gomez','Pablo','Bulnes 321','Contaduria',2,'casado','10/09/1998');
insert into empleados values('26666666','f','Perez','Laura','Peru 1254','Sistemas',3,'casado','05/09/2000');

--4 Eliminamos las vistas "vista_empleados" y "vista_empleados2":
drop view vista_empleados;

drop view vista_empleados2;

--5 
/*Creamos la vista "vista_empleados", que muestra solamente algunos campos
de "empleados":*/
create view vista_empleados
 as
  select apellido, nombre, sexo, seccion
  from empleados;

--6 
/*Creamos la vista "vista_empleados2", igual que "vista_empleados", pero
ahora colocamos "with read only" para impedir que puedan ejecutarse 
"insert", "update" y "delete" sobre esta vista:*/
create view vista_empleados2
 as
  select apellido, nombre, sexo, seccion
  from empleados
  with read only;

--7 
/*Actualizamos el nombre de un empleado a través de la vista 
"vista_empleados":*/
update vista_empleados set nombre='Beatriz' where nombre='Ana';

--8 Veamos si la modificación se realizó en la tabla:
select * from empleados;

--9 
/*Intentamos actualizar el nombre de un empleado a través de la vista 
"vista_empleados2":*/
update vista_empleados2 set nombre='Pedro' where nombre='Marcos';
--No lo permite.

--10 
/*Ingresamos un registro en la tabla "empleados" a través de la vista 
"vista_empleados":*/
insert into vista_empleados values('Juarez','Juan','m','Sistemas');
--Oracle acepta la inserción. 

--11 Verificamos que la inserción se realizó en la tabla:
select * from empleados;

--12 Intentamos ingresar un registro a través de la vista "vista_empleados2":
insert into vista_empleados2 values('Gimenez','Julieta','f','Sistemas');
--Oracle no lo permite porque la vista fue definida con "with read only".

--13 
/*Eliminamos un registro en la tabla "empleados" a través de la vista 
"vista_empleados":*/
delete from vista_empleados where apellido='Juarez';
--Oracle acepta la eliminación. 

--14 Verificamos que la eliminación se realizó en la tabla:
select * from empleados;

--15 Intentamos eliminar registros a través de la vista "vista_empleados2":
delete from vista_empleados2 where apellido='Lopez';
--Oracle no lo permite porque la vista fue definida con "with read only".