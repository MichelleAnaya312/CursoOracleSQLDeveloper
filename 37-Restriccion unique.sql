/*Restricción unique*/
/*Primer Problema*/

--1 Eliminamos la tabla:
drop table alumnos;

--2 Creamos la tabla:
create table alumnos(
  legajo char(4),
  apellido varchar2(20),
  nombre varchar2(20),
  documento char(8)
);

--3 Agregamos una restricción "primary" para el campo "legajo":
alter table alumnos
add constraint PK_alumnos_legajo
primary key(legajo);

--4 Agregamos una restricción "unique" para el campo "documento":
alter table alumnos
add constraint UQ_alumnos_documento
unique (documento);

--5 Ingresamos algunos registros:
insert into alumnos values('A111','Lopez','Ana','22222222');
insert into alumnos values('A123','Garcia','Maria','23333333');

--6 Intentamos ingresar un documento repetido:
insert into alumnos values('A230','Perez','Juan','23333333');
/*aparece un mensaje de error indicando que se viola la restricción única.*/

--7 Intentamos ingresar un legajo repetido:
insert into alumnos values('A123','Suarez','Silvana','30111222');
/*aparece un mensaje de error indicando que se viola 
la restricción "primary key".*/

--8 
/*Veamos las restricciones de la tabla "alumnos" consultando el 
catálogo "user_constraints":*/
select * from user_constraints where table_name='ALUMNOS';

/*Aparecen las dos restricciones creadas anteriormente:

OWNER		CONSTRAINT_NAME		CONSTRAINT_TYPE		TABLE_NAME
--------------------------------------------------------------------------
SYSTEM		PK_ALUMNOS_LEGAJO	P			ALUMNOS
SYSTEM		UQ_ALUMNOS_DOCUMENTO	U			ALUMNOS*/

--9 Veamos la información de "user_cons_columns":
select * from user_cons_columns where table_name='ALUMNOS';

/*Nos informa:

OWNER		CONSTRAINT_NAME		TABLE_NAME	COLUMN_NAME	POSITION
--------------------------------------------------------------------------------
SYSTEM		UQ_ALUMNOS_DOCUMENTO	ALUMNOS		DOCUMENTO	1
SYSTEM		PK_ALUMNOS_LEGAJO	ALUMNOS		LEGAJO		1*/