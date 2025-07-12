/*Primer Problema*/
--1 Eliminamos las tablas:
drop table alumnos;
 
drop table aprobados;

--2 Creamos las tablas:
create table alumnos(
  documento char(8) not null,
  nombre varchar2(30),
  nota number(4,2)
   constraint CK_alumnos_nota_valores check (nota>=0 and nota <=10),
  primary key(documento)
);

create table aprobados(
  documento char(8) not null,
  nota number(4,2)
   constraint CK_aprobados_nota_valores check (nota>=0 and nota <=10),
  primary key(documento)
);

--3 Ingresamos registros en "alumnos":
insert into alumnos values('30000000','Ana Acosta',8);
insert into alumnos values('30111111','Betina Bustos',9);
insert into alumnos values('30222222','Carlos Caseros',2.5); 
insert into alumnos values('30333333','Daniel Duarte',7.7);
insert into alumnos values('30444444','Estela Esper',3.4);

--4 
/*Ingresamos registros en la tabla "aprobados" seleccionando registros de la 
tabla "alumnos":*/
insert into aprobados 
    select documento,nota
    from alumnos
    where nota>=4;
/*Note que no se listan los campos en los cuales se cargan los datos porque tienen
el mismo nombre que los de la tabla de la cual extraemos la información.*/

--5 Veamos si los registros se han cargado:
select * from aprobados;