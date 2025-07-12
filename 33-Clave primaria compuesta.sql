/*Primer Problema*/
--1
/*Seteamos el formato de "date" para que nos 
muestre únicamente la hora y los minutos, ya que 
en esta playa, se almacenan los datos de los 
vehículos diariamente:*/
ALTER SESSION SET NLS_DATE_FORMAT = 'HH24:MI';

--2 Eliminamos la tabla:
drop table vehiculos;

--3 Creamos la tabla estableciendo dos campos como clave primaria:
create table vehiculos(
  patente char(6) not null,
  tipo char(1),--'a'=auto, 'm'=moto
  horallegada date,
  horasalida date,
  primary key(patente,horallegada) 
);

--4 Ingresamos algunos registros:
insert into vehiculos values('AIC124','a','8:05','12:30');
insert into vehiculos values('CAA258','a','8:05',null);
insert into vehiculos values('DSE367','m','8:30','18:00');
insert into vehiculos values('FGT458','a','9:00',null);
insert into vehiculos values('AIC124','a','16:00',null);
insert into vehiculos values('LOI587','m','18:05','19:55');

select * from vehiculos;

--5 Si intentamos ingresar un registro con clave primaria repetida:
insert into vehiculos values('LOI587','m','18:05',null);
-- aparece un mensaje de error y la inserción no se realiza.

--6 
/*Si ingresamos un registro repitiendo el valor de uno de los campos 
que forman parte de la clave, si lo acepta:*/
insert into vehiculos values('LOI587','m','21:30',null);

--7 Recuperamos todos los registros:
select *from vehiculos;
/*Note que cada registro es único, dos de ellos tienen la misma patente, 
pero diferente hora de llegada.*/

--8 Si intentamos actualizar un registro repitiendo la clave primaria:
update vehiculos set horallegada='8:05'
where patente='AIC124' and horallegada='16:00';
-- aparece un mensaje de error y la actualización no se realiza.

--9 
/*Recordemos que los campos que forman parte de la clave primaria no 
aceptan valores nulos, aunque no se haya aclarado en la definición de 
la tabla:*/
insert into vehiculos values('HUO690','m',null,null);

--10 Si mostramos la estructura de la tabla:
describe vehiculos;
/*vemos que los campos que forman parte de la clave primaria 
(patente y horallegada) tienen "NOT NULL" en la columna "Null", 
es decir, no admiten valores nulos.*/

-- 11
/*Para ver la clave primaria de una tabla podemos realizar la
siguiente consulta:*/
select uc.table_name, column_name, position from user_cons_columns ucc
join user_constraints uc
on ucc.constraint_name=uc.constraint_name
where uc.constraint_type='P' and
uc.table_name='VEHICULOS';

/*Nos retorna la siguiente información:
TABLE_NAME	COLUMN_NAME	POSITION
----------------------------------------
VEHICULOS	PATENTE		1
VEHICULOS	HORALLEGADA	2
Los dos campos son clave primaria, "POSITION" 
indica el orden en que fueron definidos los campos.*/

/*Segundo Problema*/
--1 Elimine la tabla "inscriptos":
drop table inscriptos;

--2 La tabla contiene los siguientes campos:
-- documento del socio alumno: char(8) not null
-- nombre del socio: varchar2(30),
-- nombre del deporte (tenis, futbol, natación, basquet): varchar2(15) not null,
-- año de inscripcion: date,
-- matrícula: si la matrícula ha sido o no pagada ('s' o 'n').

--3 
/*Necesitamos una clave primaria que identifique cada registro. 
Un socio puede inscribirse en varios deportes en distintos años. 
Un socio no puede inscribirse en el mismo deporte el mismo año. 
Varios socios se inscriben en un mismo deporte en distintos años. 
Cree la tabla con una clave compuesta:*/
create table inscriptos(
  documento char(8) not null, 
  nombre varchar2(30),
  deporte varchar2(15) not null,
  año date,
  matricula char(1),
  primary key(documento,deporte,año)
);
 
--4 Setee el formato de "date" para que nos muestre solamente el año (no necesitamos las otras partes de la fecha ni la hora)
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY';

--5 Inscriba a varios alumnos en el mismo deporte en el mismo año:
insert into inscriptos
values ('12222222','Juan Perez','tenis','2005','s');
insert into inscriptos
values ('23333333','Marta Garcia','tenis','2005','s');
insert into inscriptos
values ('34444444','Luis Perez','tenis','2005','n');

select * from inscriptos;

--6 Inscriba a un mismo alumno en varios deportes en el mismo año:
insert into inscriptos
values ('12222222','Juan Perez','futbol','2005','s');
insert into inscriptos
values ('12222222','Juan Perez','natacion','2005','s');
insert into inscriptos
values ('12222222','Juan Perez','basquet','2005','n');

select * from inscriptos;

--7 
/*Ingrese un registro con el mismo documento de socio en el 
mismo deporte en distintos años:*/
insert into inscriptos
values ('12222222','Juan Perez','tenis','2006','s');
insert into inscriptos
values ('12222222','Juan Perez','tenis','2007','s');

select * from inscriptos;

--8 
/*Intente inscribir a un socio alumno en un deporte 
en el cual ya esté inscripto en un año en el cual ya 
se haya inscripto (mensaje de error)*/
insert into inscriptos
values ('12222222','Juan Perez','tenis','2005','s');
  
--9 
/*Intente actualizar un registro para que la clave 
primaria se repita (error)*/
update inscriptos set deporte='tenis'
where documento='12222222' and
deporte='futbol' and
año='2005';

--10 
/*Muestre los nombres y años de los inscriptos en "tenis" 
(5 registros)*/
select nombre,año from inscriptos
where deporte='tenis';
  
--11 
/*Muestre los nombres y deportes de los inscriptos en el año 
2005 (6 registros)*/
select nombre,deporte from inscriptos
where año='2005';

--12 
/*Muestre el deporte y año de todas las inscripciones del
socio documento "12222222" (6 registros)*/
select deporte,año from inscriptos
where documento='12222222';

