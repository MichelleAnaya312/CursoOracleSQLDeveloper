/*Primer Problema*/
drop table libros;

create table libros(
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(20),
  precio number(5,2)
);

drop table tabla1;
 
create table tabla1( 
   titulo varchar2(40),
   precio number(6,2)
);

insert into libros values ('Uno','Richard Bach','Planeta',15);
insert into libros values ('Ilusiones','Richard Bach','Planeta',12);
insert into libros values ('El aleph','Borges','Emece',25);
insert into libros values ('Aprenda PHP','Mario Molina','Nuevo siglo',50);
insert into libros values ('Matematica estas ahi','Paenza','Nuevo siglo',18);
insert into libros values ('Puente al infinito','Bach Richard','Sudamericana',14);
insert into libros values ('Antología','J. L. Borges','Paidos',24);
insert into libros values ('Java en 10 minutos','Mario Molina','Siglo XXI',45);
insert into libros values ('Cervantes y el quijote','Borges- Casares','Planeta',34);

select * from libros;
select * from tabla1;

create or replace procedure pa_autorlibro(atitulo in varchar2)
as
   vautor varchar2(20);
 begin
  select autor into vautor from libros where titulo=atitulo;
  insert into tabla1
   select titulo,precio
   from libros
   where autor=vautor;
 end;
/
 
exec pa_autorlibro('Uno');

select * from tabla1;