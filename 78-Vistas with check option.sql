/*Primer Problema*/
--1 Eliminamos la tabla:
drop table empleados;

--2 Creamos la tabla:
create table empleados(
  documento char(8),
  sexo char(1)
   constraint CK_empleados_sexo check (sexo in ('f','m')),
  apellido varchar2(20),
  nombre varchar2(20),
  seccion varchar2(30),
  cantidadhijos number(2),
  constraint CK_empleados_hijos check (cantidadhijos>=0),
  estadocivil char(10)
  constraint CK_empleados_estadocivil check (estadocivil in ('casado','divorciado','soltero','viudo'))
);

--3 Ingresamos algunos registros:
insert into empleados values('22222222','f','Lopez','Ana','Administracion',2,'casado');
insert into empleados values('23333333','m','Lopez','Luis','Administracion',0,'soltero');
insert into empleados values('24444444','m','Garcia','Marcos','Sistemas',3,'divorciado');
insert into empleados values('25555555','m','Gomez','Pablo','Sistemas',2,'casado');
insert into empleados values('26666666','f','Perez','Laura','Contaduria',3,'casado');

--4 
/*Creamos o reemplazamos (si existe) la vista "vista_empleados", para que 
muestre el nombre, apellido, sexo y sección de todos los empleados de 
"Administracion" agregando la cláusula "with check option" para evitar 
que se modifique la sección de tales empleados a través de la vista y 
que se ingresen empleados de otra sección:*/
create or replace view vista_empleados
 as
  select apellido, nombre, sexo, seccion
  from empleados
  where seccion='Administracion'
  with check option;

--5 Consultamos la vista:
select * from vista_empleados;

--6 Actualizarmos el nombre de un empleado a través de la vista:
update vista_empleados set nombre='Beatriz' where nombre='Ana';
/*Oracle aceptó la actualización porque el campo "nombre" no está 
restringido.*/

--7 Veamos si la modificación se realizó en la tabla:
select * from empleados;

--8 Intentamos actualizar la sección de un empleado a través de la vista:
update vista_empleados set seccion='Sistemas' where nombre='Beatriz';
/*Oracle no aceptó la actualización porque el campo "nombre" está 
restringido.*/

--9 Ingresamos un registro mediante la vista:
insert into vista_empleados values('Gomez','Gabriela','f','Administracion');
/*Oracle acepta la inserción porque ingresamos un valor para "seccion" 
que incluirá el registro en la vista.*/

--10 Intentamos ingresar un empleado de otra sección:
insert into vista_empleados values('Torres','Tatiana','f','Sistemas');
/*Oracle no acepta la inserción porque ingresamos un valor para "seccion" 
que excluirá el nuevo registro de la vista.*/

