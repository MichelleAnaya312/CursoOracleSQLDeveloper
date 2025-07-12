/*Primer Problema*/
--1 Eliminamos la tabla "afiliados" y la creamos:
drop table afiliados;

create table afiliados(
  numero number(5),
  documento char(8) not null,
  nombre varchar2(30),
  afiliadotitular number(5),
  primary key (documento),
  unique (numero)
);
/*En caso que un afiliado no haya sido incorporado a la mutual por otro afiliado, 
el campo "afiliadotitular" almacenará "null".*/

--2 
/*Establecemos una restricción "foreign key" para asegurarnos que el número de 
afiliado que se ingrese en el campo "afiliadotitular" exista en la tabla 
"afiliados":*/
alter table afiliados
add constraint FK_afiliados_afiliadotitular
foreign key (afiliadotitular)
references afiliados (numero);

--3 Ingresamos algunos registros:
insert into afiliados values(1,'22222222','Perez Juan',null);
insert into afiliados values(2,'23333333','Garcia Maria',null);
insert into afiliados values(3,'24444444','Lopez Susana',null);
insert into afiliados values(4,'30000000','Perez Marcela',1);
insert into afiliados values(5,'31111111','Garcia Luis',2);
insert into afiliados values(6,'32222222','Garcia Maria',2);

select * from afiliados;

--4 
/*Podemos eliminar un afiliado, siempre que no haya otro afiliado que haga 
referencia a él en "afiliadotitular", es decir, si el "numero" del afiliado 
está presente en algún registro en el campo "afiliadotitular":*/
delete from afiliados where numero=5;

--5 Veamos la información referente a "afiliados":
select constraint_name, constraint_type,search_condition
from user_constraints
where table_name='AFILIADOS';
/*Aparece la siguiente tabla:

CONSTRAINT_NAME			CONSTRAINT_TYPE		SEARCH_CONDITION
---------------------------------------------------------------------------------
SYS_C004816			C			"DOCUMENTO" IS NOT NULL
SYS_C004817			P
SYS_C004818			U
FK_AFILIADOS_AFILIADOTITULAR	R
Los nombres de las tres primeras restricciones son dadas por Oracle.
La tabla tiene una restricción "check", una "primary key", una "unique" y una 
"foreign key".*/

--6 Veamos sobre qué campos están establecidas:
select * from user_cons_columns
where table_name='AFILIADOS';
/*Aparece la siguiente tabla:

CONSTRAINT_NAME			COLUMN_NAME	POSITION
----------------------------------------------------------
SYS_C004818			NUMERO		1
SYS_C004817			DOCUMENTO	1
SYS_C004816			DOCUMENTO	
FK_AFILIADOS_AFILIADOTITULAR	AFILIADOTITULAR	1
Nos informa que la restricción única está establecida sobre "numero"; la "primary 
key" sobre "documento", la restricción de chequeo sobre "documento" y la "foreign 
key" sobre "afiliadotitular".*/

--7 Ingresamos un nuevo registro con un valor para "afiliadotitular" existente:
insert into afiliados values(7,'33333333','Lopez Juana',3);

--8 
/*Intentamos ingresar un nuevo registro con un valor para "afiliadotitular" 
inexistente:*/
insert into afiliados values(8,'34555666','Marconi Julio',9);
--Oracle no lo permite porque se violaría la restricción "foreign key".

--9 Igresamos un nuevo registro con el valor "null" para "afiliadotitular":
insert into afiliados values(8,'34555666','Marconi Julio',null);

select * from afiliados;