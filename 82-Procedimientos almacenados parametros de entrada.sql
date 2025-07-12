/*Primer Problema*/
--1 Eliminamos la tabla y la creamos nuevamente:
drop table libros;

create table libros(
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(20),
  precio number(5,2)
);

--2 Ingresamos algunos registros:
insert into libros values ('Uno','Richard Bach','Planeta',15);
insert into libros values ('Ilusiones','Richard Bach','Planeta',12);
insert into libros values ('El aleph','Borges','Emece',25);
insert into libros values ('Aprenda PHP','Mario Molina','Nuevo siglo',50);
insert into libros values ('Matematica estas ahi','Paenza','Nuevo siglo',18);
insert into libros values ('Puente al infinito','Bach Richard','Sudamericana',14);
insert into libros values ('Antología','J. L. Borges','Paidos',24);
insert into libros values ('Java en 10 minutos','Mario Molina','Siglo XXI',45);
insert into libros values ('Cervantes y el quijote','Borges- Casares','Planeta',34);

--3 
/*Creamos un procedimiento que recibe el nombre de una editorial y luego 
aumenta en un 10% los precios de los libros de tal editorial:*/
create or replace procedure pa_libros_aumentar10(aeditorial in varchar2)
as
 begin
  update libros set precio=precio+(precio*0.1)
  where editorial=aeditorial;
 end;

--4 Ejecutamos el procedimiento:
execute pa_libros_aumentar10('Planeta');

--5 
/*Verificamos que los precios de los libros de la editorial "Planeta" han 
aumentado un 10%:*/
select * from libros;

--6 
/*Creamos otro procedimiento que recibe 2 parámetros, el nombre de una editorial
y el valor de incremento (que tiene por defecto el valor 10):*/
create or replace procedure pa_libros_aumentar(aeditorial in varchar2,aporcentaje in number default 10)
as
 begin
  update libros set precio=precio+(precio*aporcentaje/100)
  where editorial=aeditorial;
 end;

--7 Ejecutamos el procedimiento enviando valores para ambos argumentos:
execute pa_libros_aumentar('Planeta',30);

--8 
/*Consultamos la tabla "libros" para verificar que los precios de los libros de 
la editorial "Planeta" han sido aumentados en un 30%:*/
select * from libros;

--9 
/*Ejecutamos el procedimiento "pa_libros_aumentar" omitiendo el segundo 
parámetro porque tiene establecido un valor por defecto:*/
execute pa_libros_aumentar('Paidos');

--10 
/*Consultamos la tabla "libros" para verificar que los precios de los libros de 
la editorial "Paidos" han sido aumentados en un 10% (valor por defecto):*/
select * from libros;

--11 
/*Definimos un procedimiento almacenado que ingrese un nuevo libro en la tabla
"libros":*/
create or replace procedure pa_libros_insertar
  (atitulo in varchar2 default null, aautor in varchar2 default 'desconocido',
   aeditorial in varchar2 default 'sin especificar', aprecio in number default 0)
as
 begin
  insert into libros values (atitulo,aautor,aeditorial,aprecio);
 end;
/

--12 Llamamos al procedimiento sin enviarle valores para los parámetros:
execute pa_libros_insertar;

--13 Veamos cómo se almacenó el registro:
select * from libros;

--14 
/*Llamamos al procedimiento enviándole valores solamente para el primer y cuarto
parámetros correspondientes al título y precio:*/
execute pa_libros_insertar('Uno',100);

--15 
/*Oracle asume que los argumentos son el primero y segundo, vea cómo se almacenó
el nuevo registro:*/
select * from libros;