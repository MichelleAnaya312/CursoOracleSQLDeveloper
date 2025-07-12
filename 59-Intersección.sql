/*Primer Problema*/
--1 Eliminamos las tablas:
drop table ingles;

drop table frances;

drop table portugues;
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

create table portugues(
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

insert into portugues values('23444555','Daniel Duarte','Duarte Quiros 444');
insert into portugues values('22333444','Carlos Caseros','Colon 333');
insert into portugues values('30222333','Gaston Gonzalez','Guemes 777');
insert into portugues values('31222333','Hector Huerta','Homero 888');
insert into portugues values('32333444','Ines Ilara','Inglaterra 999');
/*La academia necesita el nombre y domicilio de todos los alumnos que cursan 
los tres idiomas para enviarles una tarjeta de descuento.*/

--4 
/*Obtenemos los datos necesarios de las tres tablas en una sola consulta realizando 
una intersección entre ellas:*/
select nombre, domicilio from ingles
intersect
select nombre, domicilio from frances
intersect
select nombre, domicilio from portugues;
/*Aparece solamente un registro, correspondiente a "Daniel Duarte", que está en 
las tres tablas. Note que los alumnos que solamente asisten a una clase o 
solamente a dos, no aparecen en el resultado.*/

--5 
/*Si queremos los registros que están presentes en más de dos tablas podemos 
realizar una consulta combinando los operadores de intersección y de unión:*/
select nombre, domicilio from ingles
intersect
select nombre, domicilio from frances
union
(select nombre, domicilio from ingles
intersect 
select nombre, domicilio from portugues)
union
(select nombre, domicilio from frances
intersect
select nombre, domicilio from portugues);
/*En la consulta anterior, 
la primera intersección (inglés con francés) retorna 2 registros (Esper y Duarte); 
la segunda intersección (inglés y portugues) retorna 2 registros (Caseros y Duarte); 
unimos estos dos resultados con "union" y obtenemos 
3 registros (Caseros, Duarte y Esper); 
la tercera intersección (francés y portugués) retorna 2 registros (Duarte y Gozalez) 
que al "unirlos" al resultado de la primera unión (Caseros, Duarte y Esper) 
nos devuelve 4 registros. 
Note que algunas 
consultas se encierran entre paréntesis para especificar que la operación se 
realiza entre las tablas incluidas en ellos.*/