/*Primer Problema*/
--1 Eliminamos la tabla:
drop table empleados;

--2 Eliminamos la vista "vista_empleados":
drop view vista_empleados;

--3
/*Creamos la vista "vista_empleados" que muestre algunos campos de "empleados", 
pero la tabla "empleados" no existe, por ello, debemos agregar, al crear la vista 
"force":*/
create force view vista_empleados
 as
  select documento,nombre,seccion
  from empleados;
  
--4 Creamos la tabla:
create table empleados(
  documento char(8),
  nombre varchar2(30),
  domicilio varchar2(30),
  seccion varchar2(30)
);

--5 Ingresamos algunos registros:
insert into empleados values('22222222','Lopez Ana','Colon 123','Sistemas');
insert into empleados values('23333333','Lopez Luis','Sucre 235','Sistemas');
insert into empleados values('24444444','Garcia Marcos','Sarmiento 1234','Contaduria');
insert into empleados values('25555555','Gomez Pablo','Bulnes 321','Contaduria');
insert into empleados values('26666666','Perez Laura','Peru 1254','Secretaria');

--6 Consultamos la vista:
select * from vista_empleados;

--7 Veamos el texto de la vista consultando "user_views":
select view_name,text from user_views where view_name='VISTA_EMPLEADOS';

--8 
/*Creamos o reemplazamos (si existe) la vista "vista_empleados" que muestre todos 
los campos de la tabla "empleados":*/
create or replace view vista_empleados
 as
  select * from empleados;

--9 Consultamos la vista:
select * from vista_empleados;

--10 Agregamos un campo a la tabla "empleados":
alter table empleados
 add sueldo number(6,2);

--11 Consultamos la vista "vista_empleados":
select * from vista_empleados;
/*Note que el nuevo campo agregado a "empleados" no aparece, a pesar que la vista 
indica que muestre todos los campos de dicha tabla; esto sucede porque los campos 
se seleccionan al ejecutar "create view", para que aparezcan debemos volver a 
crear la vista:*/
create or replace view vista_empleados
 as
  select * from empleados;

--12 Consultemos la vista:
select * from vista_empleados; 
--Ahora si aparece el nuevo campo "sueldo" de "empleados";