/*Primer Problema*/
--1 Eliminamos las tablas:
drop table control;

drop table libros;

--2 Creamos las tablas con las siguientes estructuras:
create table libros(
  codigo number(6),
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(20),
  precio number(6,2)
);

create table control(
  usuario varchar2(30),
  fecha date
);

--3 Ingresamos algunos registros en "libros":
insert into libros values(100,'Uno','Richard Bach','Planeta',25);
insert into libros values(103,'El aleph','Borges','Emece',28);
insert into libros values(105,'Matematica estas ahi','Paenza','Nuevo siglo',12);
insert into libros values(120,'Aprenda PHP','Molina Mario','Nuevo siglo',55);
insert into libros values(145,'Alicia en el pais de las maravillas','Carroll','Planeta',35);

--4 Establecemos el formato de fecha para que muestre "DD/MM/YYYY HH24:MI":
alter session set NLS_DATE_FORMAT = 'DD/MM/YYYY HH24:MI';

--5 
/*Creamos un disparador que se dispare cada vez que se actualice un registro en 
"libros"; el trigger debe ingresar en la tabla "control", el nombre del usuario, 
la fecha y la hora en la cual se realizó un "update" sobre "libros":*/
create or replace trigger tr_actualizar_libros
  before update
  on libros
  for each row
 begin
  insert into control values(user,sysdate);
 end tr_actualizar_libros;
 /
 
--6 
/*Actualizamos varios registros de "libros". Aumentamos en un 10% el precio de todos 
los libros de editorial "Nuevo siglo':*/
update libros set precio=precio+precio*0.1 where editorial='Nuevo siglo';

--7 Veamos cuántas veces se disparó el trigger consultando la tabla "control":
select * from control;
/*El trigger se disparó 2 veces, una vez por cada registro modificado en "libros". Si el
trigger hubiese sido creado a nivel de sentencia, el "update" anterior hubiese disparado
el trigger 1 sola vez aún cuando se modifican 2 filas.*/

--8 
/*Veamos qué nos informa el diccionario "user_triggers" respecto del trigger 
anteriormente creado:*/
select * from user_triggers where trigger_name ='TR_ACTUALIZAR_LIBROS';

/*obtenemos el nombre del disparador, el momento y nivel (before each row), evento que 
lo dispara (update), a qué objeto está asociado (table), nombre de la tabla al que está 
asociado (libros) y otras columnas que no analizaremos por el momento.*/