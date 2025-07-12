/*Primer Problema:
Trabajamos con la tabla "usuarios" que consta de 2 campos: 
nombre de usuario y clave.*/

--1 Eliminamos la tabla si ya existe:
  drop table usuarios;

--2 Creamos la tabla:
create table usuarios (
  nombre varchar2(30),
  clave varchar2(10)
 );

--3 Vemos la estructura de la tabla:
describe usuarios;

--4 Ingresamos algunos registros:
insert into usuarios (nombre, clave)
  values ('Marcelo','Boca');
 insert into usuarios (nombre, clave)
  values ('JuanPerez','Juancito');
 insert into usuarios (nombre, clave)
  values ('Susana','River');
 insert into usuarios (nombre, clave)
  values ('Luis','River');

--5 
/* Realizamos una consulta especificando una condición, 
queremos ver toda la información del usuario cuyo nombre 
es "Marcelo": */
select * from usuarios where nombre='Marcelo';
/* Nos muestra todos los campos del registro en el cual el campo 
"nombre" es igual a "Marcelo".*/

--6 Queremos ver el nombre de los usuarios cuya clave es "River":
select nombre from usuarios where clave='River';
-- Nos muestra 2 usuarios.

--7 
/*Realizamos un "select" de los nombres de los usuarios 
cuya clave es "Santi":*/
select nombre from usuarios where clave='Santi';
--No se muestra ningún registro ya que ninguno cumple la condición.

/*------------------------------------------------------------------*/
/*Segundoo Problema:
Trabaje con la tabla "agenda" en la que registra 
los datos de sus amigos.*/

--1 Elimine "agenda"
drop table agenda;

--2
/* Cree la tabla, con los siguientes campos: 
apellido (cadena de 30), nombre (cadena de 20), 
domicilio (cadena de 30) y telefono (cadena de 11):*/
create table agenda(
  apellido varchar2(30),
  nombre varchar2(30),
  domicilio varchar2(30),
  telefono varchar2(11)
 );
 
--3 Visualice la estructura de la tabla "agenda" (4 campos)
describe agenda;

--4 Ingrese los siguientes registros ("insert into"):
insert into agenda(apellido,nombre,domicilio,telefono) values 
  ('Acosta', 'Ana', 'Colon 123', '4234567');
 insert into agenda(apellido,nombre,domicilio,telefono) values 
  ('Bustamante', 'Betina', 'Avellaneda 135', '4458787');
 insert into agenda(apellido,nombre,domicilio,telefono) values 
  ('Lopez', 'Hector', 'Salta 545', '4887788'); 
 insert into agenda(apellido,nombre,domicilio,telefono) values 
  ('Lopez', 'Luis', 'Urquiza 333', '4545454');
 insert into agenda(apellido,nombre,domicilio,telefono) values 
  ('Lopez', 'Marisa', 'Urquiza 333', '4545454');

--5 Seleccione todos los registros de la tabla (5 registros)
select * from agenda;

--6 Seleccione el registro cuyo nombre sea "Marisa" (1 registro)
select * from agenda where nombre = 'Marisa';

--7 
/*Seleccione los nombres y domicilios de quienes 
tengan apellido igual a "Lopez" (3 registros)*/
select nombre, domicilio from agenda where apellido = 'Lopez';

--8
/*Seleccione los nombres y domicilios de quienes 
tengan apellido igual a "lopez" (en minúsculas)*/
select nombre, domicilio from agenda where apellido = 'lopez';

--9 Muestre el nombre de quienes tengan el teléfono "4545454" (2 registros)
select nombre from agenda where telefono = '4545454'







