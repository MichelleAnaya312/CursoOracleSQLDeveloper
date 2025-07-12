/*Indices (Crear - Información)*/
/*Primer Problema*/
--1 Eliminamos la tabla y la creamos:
 drop table empleados;
 
create table empleados(
  legajo number(5),
  documento char(8),
  apellido varchar2(25),
  nombre varchar2(25),
  domicilio varchar2(30)
);
 
--2 Agregamos una restricción "primary key" sobre el campo "legajo":
alter table empleados
add constraint PK_empleados_legajo
primary key (legajo);

--3 Consultamos "user_constraints":
select constraint_name, constraint_type, index_name
from user_constraints
where table_name='EMPLEADOS';
--Note que Oracle creó un índice con el mismo nombre de la restricción.

--4 Veamos los índices de "empleados":
select index_name, index_type, uniqueness
from user_indexes
where table_name='EMPLEADOS';
/*Aparece 1 fila, mostrando el nombre del índice, indicando que es 
normal y único.*/

--5 Creamos un índice único sobre el campo "documento":
create unique index I_empleados_documento
on empleados(documento);

--6 Verificamos que se creó el índice:
select index_name, index_type, uniqueness
from user_indexes where table_name='EMPLEADOS';
--Aparecen 2 filas, una por cada índice.

--7 Agregamos a la tabla una restricción única sobre el campo "documento":
alter table empleados
add constraint UQ_empleados_documento
unique(documento);

--8 Analicemos la información que nos muestra "user_constraints":
select constraint_name, constraint_type, index_name
from user_constraints
where table_name='EMPLEADOS';
/*En la columna "index_name" correspondiente a la restricción única,
aparece "I_empleados_documento", Oracle usa para esta restricción el 
índice existente, no crea otro nuevo.*/

--9 
/*Creamos un índice no único, compuesto (para los campos "apellido" y 
"nombre"):*/
create index I_empleados_apellidonombre
on empleados(apellido,nombre);

--10 Consultamos el diccionario "user_indexes":
select index_name, index_type, uniqueness
from user_indexes
where table_name='EMPLEADOS';
/*Nos muestra información sobre los 3 índices de la tabla.*/

--11 
/*Veamos todos los índices de la base de datos activa consultando 
"user_objects":*/
select * from user_objects
where object_type='INDEX';
--Aparecen varios índices, entre ellos, los de nuestra tabla "empleados".

--12 Obtenemos información de "user_ind_columns":
select index_name,column_name,column_position
from user_ind_columns
where table_name='EMPLEADOS';

/*Nos muestra la siguiente tabla:
INDEX_NAME			COLUMN_NAME	COLUMN_POSITION
-----------------------------------------------------------------
PK_EMPLEADOS_LEGAJO		LEGAJO		1
I_EMPLEADOS_DOCUMENTO		DOCUMENTO	1
I_EMPLEADOS_APELLIDONOMBRE	APELLIDO	1
I_EMPLEADOS_APELLIDONOMBRE	NOMBRE		2

La tabla tiene 3 índices, 2 filas corresponden al índice compuesto 
"I_empleados_apellidonombre"; la columna "position" indica el orden 
de los campos indexados.*/

--13 Agregamos algunos registros:
insert into empleados values(1,'22333444','Lopez','Juan','Colon 123');
insert into empleados values(2,'23444555','Lopez','Luis','Lugones 1234');
insert into empleados values(3,'24555666','Garcia','Pedro','Avellaneda 987');
insert into empleados values(4,'25666777','Garcia','Ana','Caseros 678');

select * from empleados;

--14 
/*Si intentamos crear un índice único para el campo "apellido" 
(que contiene valores duplicados") Oracle no lo permite:*/
create unique index I_empleados_apellido
on empleados(apellido);
/*Igualmente, si hay un índice único sobre un campo y luego 
intentamos ingresar un registro con un valor repetido para el 
campo indexado, Oracle no lo permite.*/

--15 Creamos un índice único sobre el campo "nombre":
create unique index I_empleados_nombre
on empleados(nombre);
--Oracle lo permite porque no hay valores duplicados.

--16 Intentamos agregamos un registro que repita un nombre:
 insert into empleados values(5,'30111222','Perez','Juan','Bulnes 233');
--Oracle no lo permite.
