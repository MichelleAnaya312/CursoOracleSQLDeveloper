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
/*La academia necesita el nombre y domicilio de todos los alumnos, de todos los 
cursos para enviarles una tarjeta de invitación para un festejo el día del alumno.*/

--4 Empleamos el operador "union" para obtener dicha información de ambas tablas:
select nombre, domicilio from ingles
union
select nombre, domicilio from frances;
/*Note que existen dos alumnos (Daniel Duarte y Estela Esper) que cursan ambos 
idiomas, están presentes en la tabla "ingles" y "frances"; tales registros 
aparecen una sola vez en el resultado de "union".*/ 

--5
/*Si queremos que los registros 
duplicados aparezcan, debemos emplear "all":*/
select nombre, domicilio from ingles
union all
select nombre, domicilio from frances;

--6 Ordenamos por nombre:
select nombre, domicilio from ingles
union all
select nombre, domicilio from frances
order by nombre;

--7 
/*Podemos agregar una columna extra a la consulta con el encabezado "curso" en 
la que aparezca el literal "inglés" o "francés" según si la persona cursa uno u 
otro idioma:*/
select nombre, domicilio, 'ingles' as curso from ingles
union
select nombre, domicilio,'frances' from frances
order by curso;
/*Recuerde que los encabezados de los campos son los que se especifican en el 
primer "select". Si queremos que el nombre tenga un encabezado "alumno" debemos 
especificar un alias en la primer consulta. Si ordenamos por un campo que tiene 
un alias, debemos especificar el alias no el nombre del campo. */

--8 
/*En la siguiente consulta realizamos una unión, colocamos un alias al campo 
"nombre" y ordenamos el resultado por tal alias:*/
select nombre as alumno, domicilio from ingles
union
select nombre, domicilio from frances
order by alumno;