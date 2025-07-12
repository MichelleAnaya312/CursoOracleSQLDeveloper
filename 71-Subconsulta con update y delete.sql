/*Primer Problema*/
--1 Eliminamos las tablas y las creamos:
drop table libros;

drop table editoriales;

create table editoriales(
  codigo number(2),
  nombre varchar2(30),
  primary key (codigo)
);
 
create table libros (
  codigo number(5),
  titulo varchar2(40),
  autor varchar2(30),
  codigoeditorial number(2),
  precio number(5,2),
  primary key(codigo),
  constraint FK_libros_editorial
   foreign key (codigoeditorial)
   references editoriales(codigo)
);

--2 Ingresamos algunos registros:
insert into editoriales values(1,'Planeta');
insert into editoriales values(2,'Emece');
insert into editoriales values(3,'Paidos');
insert into editoriales values(4,'Siglo XXI');

insert into libros values(100,'Uno','Richard Bach',1,15);
insert into libros values(101,'Ilusiones','Richard Bach',2,20);
insert into libros values(102,'El aleph','Borges',3,10);
insert into libros values(103,'Aprenda PHP','Mario Molina',4,40);
insert into libros values(104,'Poemas','Juan Perez',1,20);
insert into libros values(105,'Cuentos','Juan Perez',3,25);
insert into libros values(106,'Java en 10 minutos','Marcelo Perez',2,30);

select * from editoriales;
select * from libros;

--3 
/*Actualizamos el precio de todos los libros de editorial "Emece" 
incrementándolos en un 10%:*/
update libros set precio=precio+(precio*0.1)
where codigoeditorial=
   (select codigo
     from editoriales
     where nombre='Emece');

--4 
/*Eliminamos todos los libros de las editoriales que tiene publicados libros de 
"Juan Perez":*/
delete from libros
where codigoeditorial in
   (select e.codigo
    from editoriales e
    join libros
    on codigoeditorial=e.codigo
    where autor='Juan Perez');