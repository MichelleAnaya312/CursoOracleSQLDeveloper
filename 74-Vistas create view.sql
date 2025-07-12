/*Primer Problema*/
--1 Eliminamos las tablas:
drop table empleados;

drop table secciones;

--2 Creamos las tablas:
create table secciones(
  codigo number(2),
  nombre varchar2(20),
  sueldo number(5,2)
   constraint CK_secciones_sueldo check (sueldo>=0),
  constraint PK_secciones primary key (codigo)
);

create table empleados(
  legajo number(5),
  documento char(8),
  sexo char(1)
   constraint CK_empleados_sexo check (sexo in ('f','m')),
  apellido varchar2(20),
  nombre varchar2(20),
  domicilio varchar2(30),
  seccion number(2) not null,
  cantidadhijos number(2)
   constraint CK_empleados_hijos check (cantidadhijos>=0),
  estadocivil char(10)
   constraint CK_empleados_estadocivil check (estadocivil in ('casado','divorciado','soltero','viudo')),
  fechaingreso date,
   constraint PK_empleados primary key (legajo),
  constraint FK_empleados_seccion
   foreign key (seccion)
   references secciones(codigo),
  constraint UQ_empleados_documento
   unique(documento)
);

--3 Ingresamos algunos registros:
insert into secciones values(1,'Administracion',300);
insert into secciones values(2,'Contaduría',400);
insert into secciones values(3,'Sistemas',500);

insert into empleados values(100,'22222222','f','Lopez','Ana','Colon 123',1,2,'casado','10/10/1990');
insert into empleados values(102,'23333333','m','Lopez','Luis','Sucre 235',1,0,'soltero','02/10/1990');
insert into empleados values(103,'24444444','m','Garcia','Marcos','Sarmiento 1234',2,3,'divorciado','12/07/1998');
insert into empleados values(104,'25555555','m','Gomez','Pablo','Bulnes 321',3,2,'casado','10/09/1998');
insert into empleados values(105,'26666666','f','Perez','Laura','Peru 1254',3,3,'casado','05/09/2000');

--4 
/*Eliminamos la vista "vista_empleados". Aún no hemos aprendido a eliminar
vistas, lo veremos próximamente:*/
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

--6 Vemos la información de la vista:
select * from vista_empleados;

--7 Realizamos una consulta a la vista como si se tratara de una tabla:
select seccion,count(*) as cantidad
  from vista_empleados
  group by seccion;

--8 Eliminamos la vista "vista_empleados_ingreso":
drop view vista_empleados_ingreso;

--9 
/*Creamos otra vista de "empleados" denominada "vista_empleados_ingreso" 
que almacena la cantidad de empleados por año:*/
create view vista_empleados_ingreso (fecha,cantidad)
  as
  select extract(year from fechaingreso),count(*)
   from empleados
   group by extract(year from fechaingreso);

--10 Vemos la información:
select * from vista_empleados_ingreso;
/*Hemos aprendido que los registros resultantes de una vista no se 
almacena en la base de datos, sino la definición de la vista, por lo tanto,
al modificar las tablas referenciadas por la vista, el resultado de la 
vista cambia.*/

--11 
/*Modificamos una fecha en la tabla "empleados" y luego consultamos la 
vista para verificar que está actualizada:*/
update empleados set fechaingreso='10/09/2000' where fechaingreso='10/09/1998';

select * from vista_empleados_ingreso;