/*Primer Problema*/
--1 Eliminamos las tablas:
drop table libros;

drop table editoriales;

--2 Creamos las tablas:
create table editoriales(
  codigo number(3),
  nombre varchar2(30),
  primary key(codigo)
);

create table libros(
  titulo varchar2(40),
  editorial number(3),
  autor varchar2(30),
  precio number(4),
  constraint FK_libros_editorial
   foreign key(editorial)
   references editoriales(codigo)
);

--3 
/*Modificamos el campo precio para que tome valores de 6 dígitos incluyendo 2 
decimales y acepte valores nulos:*/
alter table libros
modify precio number(6,2);

--4 Verificamos el cambio viendo la estructura de la tabla:
describe libros;

--5 Ingresamos algunos registros:
insert into editoriales values(1, 'Emece');

insert into libros values('Uno',1,'Richard Bach',24.6);

--6 Intentamos modificar el campo "precio" a "varchar(8)":
alter table libros modify precio varchar(8);
--No lo permite, porque existe un registro con un valor numérico en tal campo.

--7 Actualizamos el registro de "libros" con precio no nulo a nulo:
update libros set precio= null;

--8
/*Ahora si podemos cambiar el tipo de dato de "precio", 
los registros existentes contienen "null" en tal campo:*/
alter table libros modify precio varchar(8);

--9 Verificamos el cambio:
describe libros;

--10 Intentamos modificar el campo "codigo" de "editoriales" a "char(3)":
alter table editoriales modify codigo char(3);
--No lo permite porque tal campo es referenciado por una clave externa.

--11 Modificamos un atributo del campo "codigo" de "editoriales":
alter table editoriales modify codigo number(4);
--Oracle permite el cambio pues no afecta a la restricción.

--12 Intentamos redefinir "precio" para que no acepte valores nulos:
alter table libros
modify precio not null;
--No lo permite porque existe un registro con valor nulo en "precio".

--13 Eliminamos el registro y modificamos el campo "precio" a "no nulo":
delete from libros;

alter table libros
modify precio not null;

--14 Intentamos redefinir como no nulo el campo "codigo" de "editoriales":
alter table editoriales
modify codigo not null;

--15 
/*No aparece mensaje de error, pero si verificamos la estructura de la tabla 
veremos que continua siendo "not null", ya que es clave primaria:*/
describe editoriales;

--16 Redefinimos el campo "precio" como number(6,2), con un valor por defecto 0:
alter table libros
modify precio number(6,2) default 0;

--17
/*Oracle permite modificar el campo "precio" a "char(8)".
Si luego ingresamos un registro sin valor para "precio", guardará el valor 
por defecto (0) convertido a cadena ('0'):*/
alter table libros
modify precio char(8) default 0;

insert into libros values('El aleph',1,'Borges',default);

select * from libros;

--18
/*Redefinimos el valor por defecto del campo "precio" (que ahora es de tipo 
char) a "cero":*/
alter table libros
modify precio default 'cero';

--19
/*Oracle no permite modificar el campo "precio" a "number(8,2)" porque si luego 
ingresamos un registro sin valor para tal campo, el valor por defecto ('cero')
no podrá convertirse a número:*/
alter table libros
modify precio number(8,2);
--Mensaje de error.

--20 Modificamos el valor por defecto para que luego pueda ser convertido:
alter table libros
modify precio default '0';

--21 Vaciamos la tabla:
truncate table libros;

--22
/*Oracle permite modificar el campo "precio" a "number(8,2)" porque si luego 
ingresamos un registro sin valor para tal campo, el valor por defecto ('0')
podrá convertirse a número (0):*/
alter table libros
modify precio number(8,2);

--23 
/*Oracle permite modificar el campo "precio" a "char(8)". Si luego ingresamos 
un registro sin valor para "precio", guardará el valor por defecto (0) 
convertido a cadena ('0'):*/
alter table libros
modify precio char(8) default 0;

insert into libros values('El aleph',1,'Borges',default);

select * from libros; 