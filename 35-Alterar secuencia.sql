/*Primer Problema*/
--1 Eliminamos la secuencia "sec_codigolibros":
drop sequence sec_codigolibros;

--2 
/*La creamos definiendo 1 como valor de inicio, 1 de incremento, 999 
como valor máximo, 1 como mínimo valor y no circular:*/
create sequence sec_codigolibros
  start with 1
  increment by 1
  maxvalue 999
  minvalue 1
  nocycle;
  
--3 Vemos la información sobre la secuencia creada anteriormente:
select * from all_sequences where sequence_name='SEC_CODIGOLIBROS';

--4 
/*Alteramos la secuencia para que el máximo valor sea 99999 y se 
incremente de a 2:*/
alter sequence sec_codigolibros
increment by 2
maxvalue 99999;

--5 Veamos la información de la secuencia modificada consultando "all_sequences":
select * from all_sequences where sequence_name='SEC_CODIGOLIBROS';

/*Ahora el valor de incremento es 2 y el máximo 99999, 
los demás valores permanecen como fueron definidos.*/

/*Segundo Problema*/
--1 Elimine la tabla "empleados":
drop table empleados;

--2 Cree la tabla:
create table empleados(
  legajo number(3),
  documento char(8) not null,
  nombre varchar2(30) not null,
  primary key(legajo)
 );
 
--3 
/*Elimine la secuencia "sec_legajoempleados" y luego créela
estableciendo el valor mínimo (1), máximo (210), valor inicial (206), 
valor de incremento (2) y no circular. Finalmente inicialice la secuencia.*/
drop sequence sec_legajoempleados;

create sequence sec_legajoempleados
  start with 206
  increment by 2
  maxvalue 210
  minvalue 1
  nocycle;
  
--4 
/*Ingrese algunos registros, empleando la secuencia 
creada para los valores de la clave primaria.*/
insert into empleados
values (sec_legajoempleados.nextval,'22333444','Ana Acosta');
insert into empleados
values (sec_legajoempleados.nextval,'23444555','Betina Bustamante');
insert into empleados
values (sec_legajoempleados.nextval,'24555666','Carlos Caseros');

--5 Recupere los registros de "libros" para ver los valores de clave primaria.
select * from  empleados;

--6 Vea el valor actual de la secuencia empleando la tabla "dual"
select sec_legajoempleados.currval from dual;

--7 Intente ingresar un registro empleando "nextval":
insert into empleados
values (sec_legajoempleados.nextval,'25666777','Diana Dominguez');
/*Oracle muestra un mensaje de error indicando que la secuencia ha llegado a 
su valor máximo.*/

--8 Altere la secuencia modificando el atributo "maxvalue" a 999.
alter sequence sec_legajoempleados maxvalue 999;

--9 Obtenga información de la secuencia.
select * from all_sequences where sequence_name='SEC_LEGAJOEMPLEADOS';

--10 Ingrese el registro del punto 7.
insert into empleados
values (sec_legajoempleados.nextval,'25666777','Diana Dominguez');
  
--11 Recupere los registros.
select * from empleados;

--12 Modifique la secuencia para que sus valores se incrementen en 1.
alter sequence sec_legajoempleados increment by 1;

--13 Ingrese un nuevo registro:
insert into empleados
values (sec_legajoempleados.nextval,'26777888','Federico Fuentes');

--14 Recupere los registros.
select * from empleados;

--15 Elimine la secuencia creada.
drop sequence sec_legajoempleados;

--16 
/*Consulte todos los objetos de la base de datos que sean secuencias y 
verifique que "sec_legajoempleados" ya no existe.*/
select object_name,object_type
from all_objects
where object_type='SEQUENCE';