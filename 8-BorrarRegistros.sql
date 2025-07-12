/*Primer Problema:
Trabajamos con la tabla "usuarios".*/
--1 Eliminamos la tabla "usuarios":
drop table usuarios;

--2 La creamos con la siguiente estructura:
create table usuarios(
  nombre varchar2(30),
  clave varchar2(10)
 );

--3 Agregamos registros a la tabla:
insert into usuarios (nombre,clave)
  values ('Marcelo','River');
 insert into usuarios (nombre,clave)
  values ('Susana','chapita');
 insert into usuarios (nombre,clave)
  values ('CarlosFuentes','Boca');
 insert into usuarios (nombre,clave)
  values ('FedericoLopez','Boca');

--4 Seleccionamos todos los registros:
select * from usuarios;

--5 Vamos a eliminar el registro cuyo nombre de usuario es "Marcelo":
delete from usuarios
 where nombre='Marcelo';
/*Aparece un mensaje indicando que se ha borrado 1 fila.*/

--6 Intentamos eliminarlo nuevamente:
delete from usuarios where nombre='Marcelo';

--7 Eliminamos todos los registros cuya clave es 'Boca':
delete from usuarios where clave='Boca';

--8 Eliminemos todos los registros:
delete from usuarios;

--9 Veamos el contenido de la tabla:
select * from usuarios;

/*Segundo Problema:
Trabaje con la tabla "agenda" que registra la 
información referente a sus amigos.*/
--1 Elimine la tabla.
drop table agenda;

--2
/*Cree la tabla con los siguientes campos: 
apellido (cadena de 30), nombre (cadena de 20), 
domicilio (cadena de 30) y telefono (cadena de 11):*/
create table agenda(
  apellido varchar2(30),
  nombre varchar2(20),
  domicilio varchar2(30),
  telefono varchar2(11)
 );

--3 Ingrese los siguientes registros (insert into):
insert into agenda(apellido,nombre,domicilio,telefono) values 
   ('Alvarez','Alberto','Colon 123','4234567');
 insert into agenda(apellido,nombre,domicilio,telefono) values 
   ('Juarez','Juan','Avellaneda 135','4458787');
 insert into agenda(apellido,nombre,domicilio,telefono) values 
   ('Lopez','Maria','Urquiza 333','4545454');
 insert into agenda(apellido,nombre,domicilio,telefono) values 
   ('Lopez','Jose','Urquiza 333','4545454');
 insert into agenda(apellido,nombre,domicilio,telefono) values 
   ('Salas','Susana','Gral. Paz 1234','4123456');


select * from agenda;

--4 Elimine el registro cuyo nombre sea "Juan" (1 registro)
delete from agenda where nombre = 'Juan';

--5 
/*Elimine los registros cuyo número telefónico sea igual a "4545454" 
(2 registros)*/
delete from agenda where telefono = '4545454';

--6 Elimine todos los registros (2 registros)
delete from agenda;











