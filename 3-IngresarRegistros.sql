/*create table usuarios(
    nombre varchar2(30),
    clave varchar2(10)
);

insert into usuarios (nombre, clave) values ('Mariano', 'payaso');
select * from usuarios;

insert into usuarios (clave, nombre) values ('River', 'Juan');
select * from usuarios;*/


-- Primer Problema
--1 
/*Cree una tabla llamada "agenda". Debe tener los siguientes campos: 
apellido (cadena de 30), 
nombre (cadena de 20), 
domicilio (cadena de 30) 
y telefono (cadena de 11)*/

create table agenda(
    apellido varchar2(30), 
    nombre varchar2(20), 
    domicilio varchar2(30), 
    telefono varchar2(11)
);

--2 Visualice las tablas existentes para verificar la creación de "agenda" (all_tables)
select * from all_tables;

--3 Visualice la estructura de la tabla "agenda" (describe)
describe agenda;

--4 Ingrese registros
insert into agenda (apellido, nombre, domicilio, telefono) values ('Moreno','Alberto','Colon 123','4234567');
insert into agenda (apellido,nombre, domicilio, telefono) values ('Torres','Juan','Avellaneda 135','4458787');

--5 Seleccione todos los registros de la tabla
select * from agenda;

--6 Elimine la tabla "agenda"
drop table agenda;

--7 Intente eliminar la tabla nuevamente (aparece un mensaje de error)
drop table agenda;

