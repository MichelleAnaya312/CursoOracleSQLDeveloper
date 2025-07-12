/*Primer Problema:*/
--1 Eliminamos la tabla "visitantes":
drop table visitantes;

--2 Creamos con la siguiente estructura:
create table visitantes(
  nombre varchar2(30),
  edad number(2),
  sexo char(1),
  domicilio varchar2(30),
  ciudad varchar2(20),
  telefono varchar2(11)
 );

--3 Ingresamos un registro:
insert into visitantes (nombre,edad,sexo,domicilio,ciudad,telefono)
  values ('Ana Acosta',25,'f','Avellaneda 123','Cordoba','4223344');

select * from visitantes; 
--4
/*Intentamos ingresar una cadena de mayor 
longitud que la definida en el campo "sexo":*/
insert into visitantes (nombre,edad,sexo,domicilio,ciudad,telefono)
values ('Betina Bustos',32,'fem','Bulnes 234','Cordoba','4515151');
/*aparece un mensaje de error y la sentencia no se ejecuta.*/

--5
/*Ingresamos el mismo registro, esta vez con un sólo caracter 
para el campo "sexo":*/
 insert into visitantes (nombre,edad,sexo,domicilio,ciudad,telefono)
  values ('Betina Bustos',32,'f','Bulnes 234','Cordoba','4515151');

--6
/*Ingresamos un número telefónico olvidando las comillas, es decir, 
como un valor numérico:*/
insert into visitantes (nombre,edad,sexo,domicilio,ciudad,telefono)
  values ('Carlos Caseres',43,'m','Colon 345','Cordoba',03514555666);

--7 lo convierte a cadena, veámoslo:
 select * from visitantes;
 
/*Segundo Problema:*/
--1 Elimine la tabla "autos"
drop table autos;

--2
/*Cree la tabla eligiendo el tipo de dato adecuado para cada campo, 
estableciendo el campo "patente" como clave primaria:*/
 create table autos(
  patente char(6),
  marca varchar2(20),
  modelo char(4),
  precio number(8,2),
  primary key (patente)
 );

--3 Ingrese los siguientes registros:
 insert into autos (patente,marca,modelo,precio)
  values('ABC123','Fiat 128','1970',15000);
 insert into autos (patente,marca,modelo,precio)
  values('BCD456','Renault 11','1990',40000);
 insert into autos (patente,marca,modelo,precio)
  values('CDE789','Peugeot 505','1990',80000);
 insert into autos (patente,marca,modelo,precio)
  values('DEF012','Renault Megane','1998',95000);

--4
/*Ingrese un registro omitiendo las comillas en el valor de "modelo"
Oracle convierte el valor a cadena.*/
insert into autos (patente,marca,modelo,precio)
  values('HIJ678','Renault Clio',1990,70000);

--5 Vea cómo se almacenó.
select * from autos;

--6 Seleccione todos los autos modelo "1990"
select * from autos
  where modelo='1990';

--7 
/*Intente ingresar un registro con un valor de patente 
de 7 caracteres*/
 insert into autos (patente,marca,modelo,precio)
  values('FGH3457','Fiat 128','1975',20000);
  
--8 Intente ingresar un registro con valor de patente repetida.
 insert into autos (patente,marca,modelo,precio)
  values('HIJ678','Fiat 128','1975',20000);












