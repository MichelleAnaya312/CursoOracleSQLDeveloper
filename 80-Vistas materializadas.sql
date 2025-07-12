/*Primer Problema*/
--1 Eliminamos las tablas:
drop table notas;

drop table alumnos;

--2 Creamos las tablas:
create table alumnos(
 documento char(8),
 apellido varchar(30),
 nombre varchar(30),
 domicilio varchar2(40),
 primary key(documento)
);

create table notas(
  documento char(8),
  fecha date,
  nota number(4,2),
  constraints FK_notas_documento
   foreign key (documento)
   references alumnos(documento)
 );

--3 Ingresamos algunos registros:
insert into alumnos values('23333333','Acosta','Ana','Avellaneda 111');
insert into alumnos values('24444444','Bustos','Betina','Bulnes 222');
insert into alumnos values('25555555','Caseros','Carlos','Colon 333');
insert into alumnos values('26666666','Duarte','Daniel','Dinamarca 444');

insert into notas values('23333333','10/05/2017',5.3);
insert into notas values('23333333','15/07/2017',8.3);
insert into notas values('23333333','20/09/2017',7.4);
insert into notas values('24444444','10/05/2017',8.6);
insert into notas values('24444444','15/07/2017',9.4);
insert into notas values('25555555','10/05/2017',9);
insert into notas values('25555555','15/07/2017',6);
insert into notas values('26666666','10/05/2017',3.2);
insert into notas values('26666666','15/07/2017',5.3);
insert into notas values('26666666','20/09/2017',3.5);

--4 
/*Creamos o reemplazamos una vista normal que muestre el documento del alumnos y el
promedio de sus notas:*/
create or replace view vista_promedios 
as select a.documento,avg(nota) as promedio
  from alumnos a
  join notas n
  on a.documento=n.documento
  group by a.documento;

--5 Eliminamos la vista materializada "vm_promedios:
drop materialized view vm_promedios;

--6 
/*Creamos una vista materializada que muestre el documento de alumnos y el 
promedio de sus notas:*/
create materialized view vm_promedios 
as 
select a.documento,avg(nota) as promedio
  from alumnos a
  join notas n
  on a.documento=n.documento
  group by a.documento;

--7 Consultamos ambas vistas:
select * from vista_promedios;

select * from vm_promedios;
--El resultado es el mismo.

--8 Ahora agregamos algunas notas:
insert into notas values('23333333','12/10/2017',9);
insert into notas values('24444444','12/10/2017',7.5);
insert into notas values('25555555','12/10/2017',3);
insert into notas values('26666666','12/10/2017',4);

--9 Consultamos ambas vistas y comparamos los promedios:
select * from vista_promedios;
select * from vm_promedios;
/*Los promedios de la vista actualizable han cambiado porque al ejecutar el primer 
"select" se consultaron las tablas "notas" y "alumnos"; los promedios de la vista 
materializada no han cambiado, porque almacenaron el resultado de la consulta, al 
ejecutar el segundo "select" no se consultaron las tablas "alumnos" y "notas".*/