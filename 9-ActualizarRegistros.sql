/*Primer Problema:
Trabajamos con la tabla "usuarios".*/
--1 Eliminamos la tabla:
drop table usuarios;

--2 Creamos la tabla:
create table usuarios(
  nombre varchar2(20),
  clave varchar2(10)
 );

--3 Ingresamos algunos registros:
insert into usuarios (nombre,clave)
  values ('Marcelo','River');
 insert into usuarios (nombre,clave)
  values ('Susana','chapita');
 insert into usuarios (nombre,clave)
  values ('Carlosfuentes','Boca');
 insert into usuarios (nombre,clave)
  values ('Federicolopez','Boca');

select * from usuarios;
--4 
/*Cambiaremos los valores de todas las claves, 
por la cadena "RealMadrid":*/
update usuarios set clave='RealMadrid';

--5 El cambio afectó a todos los registros, veámoslo:
select *from usuarios;

--6
/* Necesitamos cambiar el valor de la clave del usuario 
llamado "Federicolopez" por "Boca":*/
update usuarios set clave='Boca'
  where nombre='Federicolopez';

--7 Verifiquemos que la actualización se realizó:
select * from usuarios;

--8
update usuarios set clave='payaso'
  where nombre='JuanaJuarez';

--9 Para actualizar varios campos en una sola instrucción empleamos:
update usuarios set nombre='Marceloduarte', clave='Marce'
  where nombre='Marcelo';

--10 Verifiquemos que la actualización se realizó:
select *from usuarios;

/*Segundo Problema:
Trabaje con la tabla "agenda" que almacena los datos de sus amigos.*/

--1 Elimine la tabla y créela con la siguiente estructura:
drop table agenda;
 
create table agenda(
   apellido varchar2(30),
   nombre varchar2(20),
   domicilio varchar2(30),
   telefono varchar2(11)
);

--2 Ingrese los siguientes registros:
 insert into agenda (apellido,nombre,domicilio,telefono)
  values ('Acosta','Alberto','Colon 123','4234567');
 insert into agenda (apellido,nombre,domicilio,telefono)
  values ('Juarez','Juan','Avellaneda 135','4458787');
 insert into agenda (apellido,nombre,domicilio,telefono)
  values ('Lopez','Maria','Urquiza 333','4545454');
 insert into agenda (apellido,nombre,domicilio,telefono)
  values ('Lopez','Jose','Urquiza 333','4545454');
 insert into agenda (apellido,nombre,domicilio,telefono)
  values ('Suarez','Susana','Gral. Paz 1234','4123456');

select * from agenda;

--3
/*Modifique el registro cuyo nombre sea "Juan" por "Juan Jose" 
(1 registro actualizado)*/
update agenda set nombre='Juan Jose' where nombre='Juan';

--4
/*Actualice los registros cuyo número telefónico 
sea igual a "4545454" por "4445566" (2 registros)*/
update agenda set telefono = '4445566'
    where telefono = '4545454';

--5
/*Actualice los registros que tengan en el campo "nombre" 
el valor "Juan" por "Juan Jose" (ningún registro afectado 
porque ninguno cumple con la condición del "where")*/
update agenda set nombre='Juan Jose'
where nombre='Juan'


















