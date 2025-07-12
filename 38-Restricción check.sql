/*Primer Problema*/
--1 Eliminamos la tabla: 
drop table libros;

--2 La creamos e ingresamos algunos registros:
create table libros(
  codigo number(5),
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(15),
  preciomin number(5,2),
  preciomay number(5,2)
);

insert into libros values (1,'Uno','Bach','Planeta',22,20);
insert into libros values (2,'El quijote','Cervantes','Emece',15,13);
insert into libros values (3,'Aprenda PHP','Mario Molina','Siglo XXI',53,48);
insert into libros values (4,'Java en 10 minutos','Garcia','Siglo XXI',35,40);

select * from libros;

--3 
/*Agregamos una restricción "primary key" para 
el campo "codigo":*/
alter table libros
add constraint PK_libros_codigo
primary key (codigo);

--4 
/*Agregamos una restricción única, la clave única consta 
de 3 campos,"titulo", "autor" y "editorial":*/
alter table libros
add constraint UQ_libros
unique (titulo,codigo,editorial);

--5 
/*Agregamos una restricción "check" para asegurar que los
valores de los campos correspondientes a precios no puedan 
ser negativos:*/
alter table libros
add constraint CK_libros_precios_positivo
check (preciomin>=0 and preciomay>=0);

--6 
/*Intentamos ingresar un valor inválido para algún 
campo correspondiente al precio, que vaya en contra 
de la restricción (por ejemplo el valor "-15"):*/
insert into libros values (5,'Matematica estas ahi','Paenza','Siglo XXI',-15,30);
/*aparecerá un mensaje de error indicando que hay
conflicto con la restricción de control creada 
anteriormente y la inserción no se realiza.*/

--7
/*Igualmente si intentamos actualizar un precio, que vaya
en contra de la restricción:*/
update libros set preciomay=-20 where titulo='Uno';

--8
/*Si intentamos agregar una restricción 
que no permita que el precio mayorista supere el precio 
minorista:*/
alter table libros
add constraint CK_libros_preciominmay
check (preciomay<=preciomin);

/*aparece un mensaje de error y la sentencia no se ejecuta, porque 
hay un registro que no cumple con la restricción que intentamos 
establecer.*/

--9
/*Podemos modificar los datos que no cumplen la condición de la 
restricción:*/
update libros set preciomay=30
where titulo='Java en 10 minutos';

--10 
/*Ahora Oracle si nos permite agregar la restricción "check" que impida 
que se ingresen valores para "preciomay" superiores a "preciomin":*/
alter table libros
add constraint CK_libros_preciominmay
check (preciomay<=preciomin);

--11 Veamos las restricciones de la tabla:
select * from user_constraints where table_name='LIBROS';

/*Aparece la siguiente tabla (simplificada) resultado:

OWNER	CONSTRAINT_NAME			CONSTRAINT_TYPE		TABLE_NAME	SEARCH_CONDITION
--------------------------------------------------------------------------------------------------
SYSTEM	PK_LIBROS_CODIGO		P               	LIBROS
SYSTEM	UQ_LIBROS			U			LIBROS
SYSTEM	CK_LIBROS_PRECIOS_POSITIVO	C			LIBROS		preciomin>=0 and preciomay>=0
SYSTEM	CK_LIBROS_PRECIOMINMAY		C			LIBROS		preciomay<=preciomin

Note que en el caso de las restricciones de control, 
en las cuales muestra "C" en el tipo de constraint, 
la columna "SEARCH_CONDITION" muestra la regla que 
debe cumplirse; en caso de ser una restricción "primary key" 
o unique", esa columna queda vacía.
*/

--12
/*Intentamos ingresar un registro que infrinja la restricción 
"CK_libros_preciominmax":*/
insert into libros values (6,'El gato con botas',null,'Planeta',25,30);
/*Mensaje de error.*/
insert into libros values (6,'El gato con botas',null,'Planeta',250,30);

--13 Consultamos "user_cons_columns":
select * from user_cons_columns where table_name='LIBROS';

/*Aparece la siguiente información simplificada:

OWNER		CONSTRAINT_NAME			TABLE_NAME	COLUMN_NAME	POSITION
-----------------------------------------------------------------------------------------
SYSTEM		PK_LIBROS_CODIGO		LIBROS		CODIGO		1
SYSTEM		UQ_LIBROS			LIBROS		EDITORIAL	3
SYSTEM		UQ_LIBROS			LIBROS		CODIGO		2
SYSTEM		UQ_LIBROS			LIBROS		TITULO		1
SYSTEM		CK_LIBROS_PRECIOS_POSITIVO	LIBROS		PRECIOMAY
SYSTEM		CK_LIBROS_PRECIOS_POSITIVO	LIBROS		PRECIOMIN
SYSTEM		CK_LIBROS_PRECIOMINMAY		LIBROS		PRECIOMAY
SYSTEM		CK_LIBROS_PRECIOMINMAY		LIBROS		PRECIOMIN

Analizamos la información: la tabla tiene 4 restricciones, 1 
"primary key", 1 "unique" y 2 "check". La restricción "primarykey" 
ocupa una sola fila porque fue definida para 1 solo campo, por ello, 
en la columna "POSITION" aparece "1". La restricción única ocupa tres 
filas porque fue definida con 3 campos cuyo orden está indicado en la 
columna "POSITION". La columna "POSITION" muestra información si la 
restricción es "primary key" o "unique" indicando el orden de los campos. 
La restricción de control "CK_libros_precios_positivo" ocupa 2 filas porque 
en su definición se nombran 2 campos (indicados en "COLUMN_NAME"). 
La restricción de control "CK_libros_preciominmax" ocupa 2 filas 
porque en su definición se nombran 2 campos (indicados en "COLUMN_NAME").*/
