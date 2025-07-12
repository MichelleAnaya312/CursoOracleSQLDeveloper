/*Primer Problema*/
--1 Eliminamos la tabla y la creamos:  
drop table empleados;

create table empleados(
  legajo number (5),
  documento char(8),
  apellido varchar2(40),
  nombre varchar2(40)
);

--2 Creamos un índice único para el campo "legajo":
create unique index I_empleados_legajo_2
on empleados(legajo);

--3 Agregamos una restricción "unique" sobre "legajo":
alter table empleados
add constraint UQ_empleados_legajo
unique (legajo);

--4 
/*Verificamos que la restricción usa el índice creado anteriormente,
no crea otro:*/
select constraint_name, constraint_type, index_name
from user_constraints
where table_name='EMPLEADOS';

--5 Agregamos una restricción "primary key" sobre "documento":
alter table empleados
add constraint PK_empleados_documento
primary key(documento);

--6 Verificamos que Oracle creó un índice para el campo "documento":
select constraint_name, constraint_type, index_name
from user_constraints
where table_name='EMPLEADOS';

--7 Consultamos todos los índices y sus tipos consultando "user_indexes":
select index_name,uniqueness
from user_indexes
where table_name='EMPLEADOS';

--8 Creamos un índice no único sobre "nombre":
create index I_empleados_nombre
on empleados(nombre);

--9 Creamos un índice no único sobre "apellido":
create index I_empleados_apellido
on empleados(apellido);

--10 
/*Si intentamos eliminar un índice que utiliza una restricción 
Oracle no lo permite:*/
drop index I_empleados_legajo_2;

--11 Verificamos que tal índice es utilizado por una restricción:
select constraint_name, constraint_type, index_name
from user_constraints
where index_name='I_EMPLEADOS_LEGAJO_2';

--12 Eliminamos el índice "I_empleados_nombre":
drop index I_empleados_nombre;

--13 Corroboremos que se eliminó:
select * from user_objects
where object_type='INDEX';
--No aparece en la lista.

--14 Eliminamos la tabla:
drop table empleados;

--15 
/*Verificamos que se eliminaron todos los índices establecidos 
sobre la tabla:*/
select * from user_indexes where table_name='EMPLEADOS';
--No aparece ninguno cuyo nombre de la tabla sea "empleados".

--16 
/*Lo verificamos nuevamente consultando el diccionario de todos 
los objetos:*/
select * from user_objects
where object_type='INDEX';
--No aparecen los índices.
