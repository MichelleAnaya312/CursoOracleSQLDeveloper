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
  fecha date,
  codigo number(6),
  precioanterior number(6,2),
  precionuevo number(6,2)
);

--3 Ingresamos algunos registros en "libros":
insert into libros values(100,'Uno','Richard Bach','Planeta',25);
insert into libros values(103,'El aleph','Borges','Emece',28);
insert into libros values(105,'Matematica estas ahi','Paenza','Nuevo siglo',12);
insert into libros values(120,'Aprenda PHP','Molina Mario','Nuevo siglo',55);
insert into libros values(145,'Alicia en el pais de las maravillas','Carroll','Planeta',35);

--4 
/*Creamos un trigger a nivel de fila que se dispara "antes" que se ejecute un "update" 
sobre el campo "precio" de la tabla "libros". En el cuerpo del disparador se debe 
ingresar en la tabla "control", el nombre del usuario que realizó la actualización, 
la fecha, el código del libro que ha sido modificado, el precio anterior y el nuevo:*/
create or replace trigger tr_actualizar_precio_libros
 before update of precio
 on libros
 for each row
 begin
  insert into control values(user,sysdate,:new.codigo,:old.precio,:new.precio);
 end tr_actualizar_precio_libros;
 /
/*Cuando el trigger se dispare, antes de ingresar los valores a la tabla, almacenará 
en "control", además del nombre del usuario y la fecha, el precio anterior del libro 
y el nuevo valor.*/

--5 Actualizamos el precio del libro con código 100:
update libros set precio=30 where codigo=100;

--6 Veamos lo que se almacenó en "control" al dispararse el trigger:
select * from control;
/*Los campos "precioanterior" y "precionuevo" de la tabla "control" almacenaron los 
valores de ":old.precio" y ":new.precio" respectivamente.*/

--7 Actualizamos varios registros:
update libros set precio=precio+precio*0.1 where editorial='Planeta';

--8 Veamos lo que se almacenó en "control" al dispararse el trigger:
select * from control;
/*Los campos "precioanterior" y "precionuevo" de la tabla "control" almacenaron los 
valores de ":old.precio" y ":new.precio" respectivamente de cada registro afectado por
la actualización.*/

--9 Modificamos la editorial de un libro:
update libros set editorial='Sudamericana' where editorial='Planeta';
/*El trigger no se disparó, pues fue definido para actualizaciones del campo "precio"
unicamente.*/

--10 Verifiquémoslo:
select * from control;

--11 
/*Vamos a reemplazar el trigger anteriormente creado. Ahora el disparador 
"tr_actualizar_precio_libros" debe controlar el precio que se está actualizando, 
si supera los 50 pesos, se debe redondear tal valor a entero hacia abajo (empleando 
"floor"), es decir, se modifica el valor ingresado accediendo a ":new.precio" 
asignándole otro valor:*/
create or replace trigger tr_actualizar_precio_libros
 before update of precio
 on libros
 for each row
 begin
  if (:new.precio>50) then
   :new.precio:=floor(:new.precio);
  end if;
  insert into control values(user,sysdate,:new.codigo,:old.precio,:new.precio);
 end tr_actualizar_precio_libros;
 /

--12 Vaciamos la tabla "control":
truncate table control;

--13 Actualizamos el precio del libro con código 100:
update libros set precio=54.99 where codigo=100;

--14 Veamos cómo se actualizó tal libro en "libros":
select * from libros where codigo=100;
--El nuevo precio actualizado se redondeó a 54.

--15 Veamos lo que se almacenó en "control" al dispararse el trigger:
select * from control;
/*Los campos "precioanterior" y "precionuevo" de la tabla "control" almacenaron los 
valores de ":old.precio" y ":new.precio" respectivamente.*/

--16 Truncamos la tabla "control" nuevamente:
truncate table control;

--17
/*Creamos un disparador para múltiples eventos, que se dispare al ejecutar "insert", 
"update" y "delete" sobre "libros". En el cuerpo del trigger se realiza la siguiente 
acción: se almacena el nombre del usuario, la fecha y los antiguos y viejos valores de 
"precio":*/
create or replace trigger tr_libros
 before insert or update or delete
 on libros
 for each row
 begin
  insert into control values(user,sysdate,:old.codigo,:old.precio,:new.precio);
 end tr_libros;
 /

--18 Ingresamos un registro:
insert into libros values (150,'El gato con botas','Anonimo','Emece',21);

--19 Veamos lo que se almacenó en "control":
select * from control;
/*Resultado:

USUARIO		FECHA		CODIGO		PRECIOANTERIOR		PRECIONUEVO
-----------------------------------------------------------------------------------
SYSTEM		20/03/08						21                     
La sentencia disparadora fue una inserción, por lo tanto, los campos ":old.codigo" y 
":old.precio" contienen "null", así que en "codigo" y en "precioanterior" se almacena 
"null"; el único campo con valor diferente de "null" es "precionuevo" correspondiente 
al valor de ":new.precio".*/

--20 Actualizamos el campo "precio" de un libro:

 update libros set precio=12 where codigo=103;

--21 Veamos lo que se almacenó en "control":
select * from control;

/*Resultado:

USUARIO		FECHA		CODIGO		PRECIOANTERIOR		PRECIONUEVO
-----------------------------------------------------------------------------------
SYSTEM		20/03/08	103		28			12
Analicemos: actualizamos el precio, por lo tanto, ninguno de los campos consultados 
contiene "null".*/

--22 Actualizamos un campo diferente de "precio" de un libro:
update libros set autor='J.L.Borges' where autor='Borges';

--23 Veamos lo que se almacenó en "control":
select * from control;
/*Resultado:

USUARIO		FECHA		CODIGO		PRECIOANTERIOR		PRECIONUEVO
-----------------------------------------------------------------------------------
SYSTEM		20/03/08	103		12			12
Actualizamos el autor, por lo tanto, los campos ":old.precio" y ":new.precio" son 
iguales.*/

--24 Eliminamos un registro de "libros":
delete from libros where codigo=100;

--25 Veamos lo que se almacenó en "control":
select * from control;

/*Resultado:

USUARIO		FECHA		CODIGO		PRECIOANTERIOR		PRECIONUEVO
-----------------------------------------------------------------------------------
SYSTEM		20/03/08	100		54
Analicemos: la sentencia que disparó el trigger fue un "delete", por lo tanto, el campo
":new.precio" contiene "null".*/

--26 
/*Veamos qué informa el diccionario "user_triggers" respecto del trigger 
anteriormente creado:*/
select * from user_triggers where trigger_name ='TR_LIBROS';

