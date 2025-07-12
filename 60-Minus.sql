/*Primer Problema*/
--1 Eliminamos las tablas:
drop table ingles;

drop table frances;

--2 Creamos las tablas:
create table ingles(
  documento varchar2(8) not null,
  nombre varchar2(30),
  domicilio varchar2(30),
  primary key(documento)
);

create table frances(
  documento varchar2(8) not null,
  nombre varchar2(30),
  domicilio varchar2(30),
  primary key(documento)
);

--3 Ingresamos algunos registros:
insert into ingles values('20111222','Ana Acosta','Avellaneda 111');
insert into ingles values('21222333','Betina Bustos','Bulnes 222');
insert into ingles values('22333444','Carlos Caseros','Colon 333');
insert into ingles values('23444555','Daniel Duarte','Duarte Quiros 444');
insert into ingles values('24555666','Estela Esper','Esmeralda 555');

insert into frances values('23444555','Daniel Duarte','Duarte Quiros 444');
insert into frances values('24555666','Estela Esper','Esmeralda 555');
insert into frances values('30111222','Fabiana Fuentes','Famatina 666');
insert into frances values('30222333','Gaston Gonzalez','Guemes 777');

--4 
/*La academia necesita el nombre y domicilio de todos los alumnos que 
cursan solamente inglés (no presentes en la tabla "frances") para 
enviarles publicidad referida al curso de francés. Empleamos el 
operador "minus" para obtener dicha información:*/
select nombre, domicilio from ingles
minus 
select nombre,domicilio from frances;
/*El resultado muestra los registros de la primer consulta que NO 
coinciden con ningún registro de la segunda consulta.
Los registros presentes en ambas tablas (Daniel Duarte y Estela Esper), 
no aparecen en el resultado final.*/

--5
/*La academia necesita el nombre y domicilio de todos los alumnos que 
cursan solamente francés (no presentes en la tabla "ingles") para enviarles
publicidad referida al curso de inglés. Empleamos el operador "minus" para 
obtener dicha información:*/
select nombre, domicilio from frances
minus 
select nombre,domicilio from ingles;
/*El resultado muestra los registros de la primer consulta que NO 
coinciden con ningún registro de la segunda consulta. Los registros 
presentes en ambas tablas (Daniel Duarte y Estela Esper), no aparecen 
en el resultado final.*/

--6 
/*Si queremos los alumnos que cursan un solo idioma (registros de "ingles" y
de "frances" que no coinciden), podemos unir ambas tablas y luego restarle 
la intersección:*/
select nombre from ingles
union
select nombre from frances
minus
(select nombre from ingles
intersect
select nombre from frances);

--7 
/*Podemos obtener el mismo resultado anterior con la siguiente consulta en 
la cual se buscan los registros de "ingles" que no coinciden con "frances" 
y los registros de "frances" que no coinciden con "ingles" y luego se unen 
ambos resultados:*/
select nombre from ingles
minus
select nombre from frances
union
(select nombre from frances
minus
select nombre from ingles);