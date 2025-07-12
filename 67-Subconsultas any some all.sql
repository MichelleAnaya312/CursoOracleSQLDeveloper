/*Primer Problema*/
--1 Eliminamos las tablas y las creamos:
drop table libros;

drop table editoriales;

create table editoriales(
  codigo number(3),
  nombre varchar2(30),
  primary key (codigo)
 );
 
create table libros (
  codigo number(5),
  titulo varchar2(40),
  autor varchar2(30),
  codigoeditorial number(3),
  precio number(5,2),
  primary key(codigo),
 constraint FK_libros_editorial
   foreign key (codigoeditorial)
   references editoriales(codigo)
   on delete cascade
);

--2 Ingresamos algunos registros:
insert into editoriales values(1,'Planeta');
insert into editoriales values(2,'Emece');
insert into editoriales values(3,'Paidos');
insert into editoriales values(4,'Siglo XXI');

insert into libros values(100,'Uno','Richard Bach',1,15);
insert into libros values(101,'Ilusiones','Richard Bach',4,18);
insert into libros values(102,'Puente al infinito','Richard Bach',2,20);
insert into libros values(103,'Aprenda PHP','Mario Molina',4,40);
insert into libros values(104,'El aleph','Borges',2,10);
insert into libros values(105,'Antología','Borges',1,20);
insert into libros values(106,'Cervantes y el quijote','Borges',3,25);

--3 
/*Mostramos los títulos de los libros de "Borges" de editoriales que han 
publicado también libros de "Richard Bach":*/
select titulo
from libros
where autor like '%Borges%' and
codigoeditorial = any
   (select e.codigo
    from editoriales e
    join libros l
    on codigoeditorial=e.codigo
    where l.autor like '%Bach%');
    
select titulo
from libros
where autor like '%Borges%' and
codigoeditorial = some
   (select e.codigo
    from editoriales e
    join libros l
    on codigoeditorial=e.codigo
    where l.autor like '%Bach%');   

--4 Realizamos la misma consulta pero empleando "all" en lugar de "any":
select titulo
from libros
where autor like '%Borges%' and
codigoeditorial = all
   (select e.codigo
    from editoriales e
    join libros l
    on codigoeditorial=e.codigo
    where l.autor like '%Bach%');
    
--5 
/*Mostramos los títulos y precios de los libros "Borges" cuyo precio supera a 
ALGUN precio de los libros de "Richard Bach":*/
select titulo,precio
from libros
where autor like '%Borges%' and
precio > any
   (select precio
    from libros
    where autor like '%Bach%');
    
--6 Veamos la diferencia si empleamos "all" en lugar de "any":
select titulo,precio
from libros
where autor like '%Borges%' and
precio > all
   (select precio
    from libros
    where autor like '%Bach%');

--7 Empleamos la misma subconsulta para eliminación:
delete from libros
where autor like '%Borges%' and
precio > all
   (select precio
    from libros
    where autor like '%Bach%');