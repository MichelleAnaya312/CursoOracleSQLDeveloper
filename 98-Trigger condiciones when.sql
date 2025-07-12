/*Primer Problema*/
--1 Eliminamos la tabla:
drop table libros;

--2 Creamos la tabla con la siguiente estructura:
create table libros(
  codigo number(6),
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(20),
  precio number(6,2)
);

--3 Ingresamos algunos registros en "libros":
insert into libros values(100,'Uno','Richard Bach','Planeta',25);
insert into libros values(103,'El aleph','Borges','Planeta',40);
insert into libros values(105,'Matematica estas ahi','Paenza','Nuevo siglo',12);
insert into libros values(120,'Aprenda PHP','Molina Mario','Nuevo siglo',55);

--4 
/*Creamos un trigger a nivel de fila que se dispara "antes" que se ejecute un "insert" 
o un "update" sobre el campo "precio" de la tabla "libros". Se activa solamente si el 
nuevo precio que se ingresa o se modifica es superior a 50, en caso de serlo, se 
modifica el valor ingresado redondeándolo a entero:*/
create or replace trigger tr_precio_libros
  before insert or update of precio
  on libros
  for each row when(new.precio>50)
  begin
   :new.precio := round(:new.precio);
  end tr_precio_libros;
  /

--5 Ingresamos un registro con el valor 30.80 para "precio":
insert into libros values(250,'El experto en laberintos','Gaskin','Emece',30.80);
--El trigger no se dispara.

--6 Veamos si el precio ingresado se redondeó:
select * from libros where titulo like '%experto%';
--El precio no se redondeó porque no es superior a 50, el trigger no se disparó.

--7 Ingresamos un registro con el valor "55.6" para "precio":
insert into libros values(300,'Alicia en el pais de las maravillas','Carroll','Emece',55.6);

--8 Consultamos "libros":
select * from libros where titulo like '%maravillas%';
--El trigger se disparó y se redondeó el nuevo precio a 56.

--9 Actualizamos el precio de un libro a "40.30":
update libros set precio=40.30 where codigo=105;

--10 Consultamos "libros":
select * from libros where codigo =105;
/*Se almacenó el valor tal como se solicitó, el trigger no se disparó ya que 
":new.precio" no cumplió con la condición del "when".*/

--11 Actualizamos el precio de un libro a "50.30":
update libros set precio=50.30 where codigo=105;

--12 Consultamos la tabla:
select * from libros where codigo=105;
/*El trigger se activa porque ":new.precio" cumple con la condición "when" y modifica el
valor a "50".*/

--13 Actualizamos el precio de 2 registros a "50.30":
update libros set precio=50.30 where editorial='Nuevo siglo';

--14 Consultamos:
select * from libros where editorial='Nuevo siglo';
-- El trigger se activa 2 veces redondeado el valor a 50.

--15 Ejecutamos el siguiente "update":
update libros set precio=precio+15.8 where editorial='Planeta';

--16 Consultamos:
select * from libros where editorial='Planeta';
/*De los dos libros de editorial "Planeta" solamente uno supera el valor 50, por lo 
tanto, el trigger se dispara una sola vez.*/

--17 Activamos el paquete "dbms_output":
set serveroutput on;
execute dbms_output.enable(20000);

--18 
/*Reemplazamos el trigger anterior por uno sin condición "when". La condición se 
controla en un "if" en el interior del trigger. En este caso, el trigger se dispara 
SIEMPRE que se actualice un precio en "libros", dentro del trigger se controla el 
precio, si cumple la condición, se modifica, sino no:*/
create or replace trigger tr_precio_libros
 before insert or update of precio
 on libros
 for each row
 begin
  dbms_output.put_line('Trigger disparado');
  if :new.precio>50 then
   dbms_output.put_line('Precio redondeado');
   :new.precio:= round(:new.precio);
  end if;
 end tr_precio_libros;
 /
/*Note que agregamos una salida de texto para controlar si el trigger se ha disparado y 
otra, para controlar si entra por la condición "if".*/

--19 Ingresamos un registro con un valor inferior a 50 para "precio":
insert into libros values(350,'Ilusiones','Bach','Planeta',20.35);
/*El trigger se dispara (aparece el primer mensaje), pero no realiza ninguna acción ya 
que al evaluarse la condición del "if", resulta falsa.*/

--20  Ingresamos un registro con un valor superior a 50 para "precio":
insert into libros values(380,'El anillo del hechicero','Gaskin','Planeta',60.35);
/*El trigger se dispara (aparece el primer mensaje) y al evaluarse como cierta la 
condición, realiza la acción (aparece el segundo mensaje).*/

--21 
/*Consultamos el diccionario para ver qué nos informa sobre el disparador recientemente 
creado:*/
select * from user_triggers where trigger_name ='TR_PRECIO_LIBROS';