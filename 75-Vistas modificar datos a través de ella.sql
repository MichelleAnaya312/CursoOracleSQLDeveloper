/*Primer Problema*/
--1 Eliminamos las tablas:
drop table empleados;

drop table secciones;

--2 Creamos las tablas:
create table secciones(
  codigo number(2),
  nombre varchar2(20),
  constraint PK_secciones primary key (codigo)
);

create table empleados(
  legajo number(4) not null,
  documento char(8),
  sexo char(1),
  constraint CK_empleados_sexo check (sexo in ('f','m')),
  apellido varchar2(20),
  nombre varchar2(20),
  domicilio varchar2(30),
  seccion number(2) not null,
  cantidadhijos number(2),
  constraint CK_empleados_hijos check (cantidadhijos>=0),
  estadocivil char(10),
  constraint CK_empleados_estadocivil check (estadocivil in ('casado','divorciado','soltero','viudo')),
  fechaingreso date,
  constraint PK_empleados primary key (legajo),
  sueldo number(6,2),
  constraint CK_empleados_sueldo check (sueldo>=0),
  constraint FK_empleados_seccion
   foreign key (seccion)
   references secciones(codigo),
  constraint UQ_empleados_documento
   unique(documento)
);

--3 Ingresamos algunos registros:
insert into secciones values(1,'Administracion');
insert into secciones values(2,'Contaduría');
insert into secciones values(3,'Sistemas');

insert into empleados values(100,'22222222','f','Lopez','Ana','Colon 123',1,2,'casado','10/10/1990',600);
insert into empleados values(101,'23333333','m','Lopez','Luis','Sucre 235',1,0,'soltero','02/10/1990',650);
insert into empleados values(103,'24444444', 'm', 'Garcia', 'Marcos', 'Sarmiento 1234', 2, 3, 'divorciado', '07/12/1998',800);
insert into empleados values(104,'25555555','m','Gomez','Pablo','Bulnes 321',3,2,'casado','10/09/1998',900);
insert into empleados values(105,'26666666','f','Perez','Laura','Peru 1254',3,3,'casado','05/09/2000',700);

--4 Eliminamos la vista "vista_empleados":
drop view vista_empleados;

--5 
/*Creamos la vista "vista_empleados", que es resultado de una combinación 
en la cual se muestran 5 campos:*/
create view vista_empleados as
  select (apellido||' '||e.nombre) as nombre,sexo,
   s.nombre as seccion, cantidadhijos
   from empleados e
   join secciones s
   on codigo=seccion;

--6 Vemos la información contenida en la vista:
select * from vista_empleados;

--7 Eliminamos la vista "vista_empleados2":
drop view vista_empleados2;

--8 
/*Creamos otra vista de "empleados" denominada "vista_empleados2" que 
consulta solamente la tabla "empleados":*/
create view vista_empleados2
  as
  select legajo,nombre,apellido,fechaingreso,seccion,sueldo
   from empleados
  where sueldo>=600;

--9 Consultamos la vista:
select * from vista_empleados2;

--10
/*No podemos ingresar un registro en la vista "vista_empleados" porque 
tal vista tiene campos calculados ("nombre", que es una concatenación de 
"apellido" y "nombre"), además afecta a 2 tablas ("empleados" y "secciones")
y hay campos no accesibles desde la vista que no admiten valores nulos. 
Si ejecutamos el siguiente "insert", Oracle mostrará un mensaje de error:*/
insert into vista_empleados values('Pedro Perez','m','Sistemas',2);

--11
/*Podemos ingresar un registro en la vista "vista_empleados2" porque tal 
vista afecta a una sola tabla y los campos de "empleados" no accesibles
desde la vista admiten valores nulos:*/
insert into vista_empleados2 values(200,'Pedro','Perez','10/10/2000',2,800);

--12
/*Vemos la tabla "empleados" para comprobar que el nuevo registro 
insertado desde la vista está presente en "empleados", los campos para 
los cuales no se ingresaron datos, almacenan el valor "null":*/
select * from empleados;

--13 
/*Actualizamos el campo "nombre" de un registro de la vista 
"vista_empleados2":*/
update vista_empleados2 set nombre='Beatriz' where nombre='Ana';

--14 Verificamos que se actualizó la tabla:
select * from empleados;

--15 
/*Si intentamos actualizar el campo "nombre" de un empleado a través de la
vista "vista_empleados", Oracle no lo permite porque es una columna
calculada (concatenación de dos campos):*/
update vista_empleados set nombre='Lopez Carmen' where nombre='Lopez Beatriz';

--16
/*Si podemos actualizar otros campos, por ejemplo, el campo 
"cantidadhijos" de un empleado a través de la vista "vista_empleados":*/
update vista_empleados set cantidadhijos=3 where nombre='Lopez Beatriz';

--17 Verificamos que se actualizó la tabla:
select * from empleados;

--18 
/*Eliminamos un registro de "empleados" a través de la vista 
"vista_empleados2":*/
delete from vista_empleados2 where apellido='Lopez' and nombre='Beatriz';

--19 Verificamos que se eliminó tal registro de la tabla "empleados":
select * from empleados;

--20 
/*Podemos eliminar registros de empleados a través de la vista 
"vista_empleados":*/
delete from vista_empleados where seccion='Administracion';

--21
/*Verificamos que no hay registros en "empleados" de la sección "1" 
("Administracion"):*/
select * from empleados;