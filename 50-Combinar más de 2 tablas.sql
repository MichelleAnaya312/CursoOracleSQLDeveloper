/*Primer Problema*/
--1 Eliminamos ambas tablas y las creamos:
drop table libros;

drop table autores;

drop table editoriales;

create table libros(
  codigo number(5),
  titulo varchar2(40),
  codigoautor number(4) not null,
  codigoeditorial number(3),
  primary key(codigo)
);

create table autores(
  codigo number(4),
  nombre varchar2(20),
  primary key (codigo)
);

create table editoriales(
  codigo number(3),
  nombre varchar2(20),
  primary key (codigo)
);

--2 Ingresamos algunos registros:
insert into editoriales values(1,'Planeta');
insert into editoriales values(2,'Emece');
insert into editoriales values(3,'Siglo XXI');
insert into editoriales values(4,'Norma');
 
insert into autores values (1,'Richard Bach');
insert into autores values (2,'Borges');
insert into autores values (3,'Jose Hernandez');
insert into autores values (4,'Mario Molina');
insert into autores values (5,'Paenza');
 
insert into libros values(100,'El aleph',2,2);
insert into libros values(101,'Martin Fierro',3,1);
insert into libros values(102,'Aprenda PHP',4,3);
insert into libros values(103,'Uno',1,1);
insert into libros values(104,'Java en 10 minutos',0,3);
insert into libros values(105,'Matematica estas ahi',10,null);
insert into libros values(106,'Java de la A a la Z',4,0);

--3 Recuperamos todos los datos de los libros consultando las tres tablas:
select titulo,a.nombre as autor,e.nombre as editorial
from autores a
join libros l
on codigoautor=a.codigo
join editoriales e
on codigoeditorial=e.codigo;
/*Note que no aparecen los libros cuyo código de autor no se encuentra 
en "autores" (caso de "Java en 10 minutos" y "Matematica estas ahi") y cuya
editorial no existe en "editoriales" (caso de "Matematica estas ahi" y 
"Java de la A a la Z"), esto es porque realizamos una combinación interna.*/

--4 Podemos combinar varios tipos de join en una misma sentencia:
select titulo,a.nombre as autor,e.nombre as editorial
from autores a
right join libros l
on codigoautor=a.codigo
left join editoriales e
on codigoeditorial=e.codigo;

/*Segundo Problema*/
--1 Elimine las tablas:
drop table socios;

drop table deportes;

drop table inscriptos;

--2 Cree las tablas con las siguientes estructuras:
create table socios(
  documento char(8) not null, 
  nombre varchar2(30),
  domicilio varchar2(30),
  primary key(documento)
);

create table deportes(
  codigo number(2),
  nombre varchar2(20),
  profesor varchar2(15),
  primary key(codigo)
);

create table inscriptos(
  documento char(8) not null, 
  codigodeporte number(2) not null,
  año char(4),
  matricula char(1),--'s'=paga, 'n'=impaga
  primary key(documento,codigodeporte,año)
);

--3 Ingrese algunos registros en "socios":
insert into socios values('22222222','Ana Acosta','Avellaneda 111');
insert into socios values('23333333','Betina Bustos','Bulnes 222');
insert into socios values('24444444','Carlos Castro','Caseros 333');
insert into socios values('25555555','Daniel Duarte','Dinamarca 44');

--4 Ingrese algunos registros en "deportes":
insert into deportes values(1,'basquet','Juan Juarez');
insert into deportes values(2,'futbol','Pedro Perez');
insert into deportes values(3,'natacion','Marina Morales');
insert into deportes values(4,'tenis','Marina Morales');

--5 Inscriba a varios socios en el mismo deporte en el mismo año:
insert into inscriptos values ('22222222',3,'2016','s');
insert into inscriptos values ('23333333',3,'2016','s');
insert into inscriptos values ('24444444',3,'2016','n');

select * from socios;
select * from deportes;
select * from inscriptos;

--6 Inscriba a un mismo socio en el mismo deporte en distintos años:
insert into inscriptos values ('22222222',3,'2015','s');
insert into inscriptos values ('22222222',3,'2017','n');

--7 Inscriba a un mismo socio en distintos deportes el mismo año:
insert into inscriptos values ('24444444',1,'2016','s');
insert into inscriptos values ('24444444',2,'2016','s');

--8 
/*Ingrese una inscripción con un código de deporte inexistente y un 
documento de socio que no exista en "socios":*/
insert into inscriptos values ('26666666',0,'2016','s');

--9 
/*Muestre el nombre del socio, el nombre del deporte en que se inscribió 
y el año empleando diferentes tipos de join (8 filas):*/
select s.nombre,d.nombre,año
from deportes d
right join inscriptos i
on codigodeporte=d.codigo
left join socios s
on i.documento=s.documento;

--10 
/*Muestre todos los datos de las inscripciones (excepto los códigos) 
incluyendo aquellas inscripciones cuyo código de deporte no existe en 
"deportes" y cuyo documento de socio no se encuentra en "socios" (10 filas)*/
select s.nombre,d.nombre,año,matricula
from deportes d
full join inscriptos i
on codigodeporte=d.codigo
full join socios s
on s.documento=i.documento;

--11 
/*Muestre todas las inscripciones del socio con documento "22222222" 
(3 filas)*/
select s.nombre,d.nombre as deporte,año,matricula
from deportes d
join inscriptos i
on codigodeporte=d.codigo
join socios s
on s.documento=i.documento
where s.documento='22222222';