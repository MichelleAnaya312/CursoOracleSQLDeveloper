/*Primer Problema*/
--1 Eliminamos "libros", creamos la tabla y luego ingresamos algunos registros:
drop table libros;
 
create table libros(
  titulo varchar2(40),
  autor varchar2(30),
  editorial varchar2(20),
  precio number(5,2)
);

insert into libros values('Uno','Richard Bach','Planeta',15);
insert into libros values('Ilusiones','Richard Bach','Planeta',18);
insert into libros values('El aleph','Borges','Emece',25);
insert into libros values('Aprenda PHP','Mario Molina','Nuevo siglo',45);
insert into libros values('Matematica estas ahi','Paenza','Nuevo siglo',12);
insert into libros values('Java en 10 minutos','Mario Molina','Paidos',35);

select * from libros;

--2 
--Borrar: drop procedure pa_libros_aumentar10;

/*La librería, frecuentemente, aumenta los precios de los libros en un 10%. 
Necesitamos un procedimiento almacenado que actualice los precios de los libros 
aumentándolos en un 10%:*/
create or replace procedure pa_libros_aumentar10
as
  begin
    update libros set precio=precio+(precio*0.1);
  end;
  /

--3 Lo ejecutamos:
execute pa_libros_aumentar10;

--4 Verificamos que los precios han aumentado:
select * from libros;

--5 Volvemos a ejecutar el procedimiento:
execute pa_libros_aumentar10;

--6 Verificamos que los precios han aumentado nuevamente:
select * from libros;

/*Segundo Problema*/
--1 Eliminamos la tabla y la creamos:
drop table empleados;

create table empleados(
  documento char(8),
  nombre varchar2(20),
  apellido varchar2(20),
  sueldo number(6,2),
  cantidadhijos number(2,0),
  fechaingreso date,
  primary key(documento)
);

--2 Ingrese algunos registros:
insert into empleados values('22222222','Juan','Perez',200,2,'10/10/1980');
insert into empleados values('22333333','Luis','Lopez',250,0,'01/02/1990');
insert into empleados values('22444444','Marta','Perez',350,1,'02/05/1995');
insert into empleados values('22555555','Susana','Garcia',400,2,'15/12/2018');
insert into empleados values('22666666','Jose Maria','Morales',500,3,'25/08/2015');

select * from empleados;

--3 
/*Cree (o reemplace) el procedimiento almacenado llamado "pa_aumentarsueldo" 
que aumente los sueldos inferiores al promedio en un 20%*/
create or replace procedure pa_aumentarsueldo
as
 begin
   update empleados set sueldo=sueldo+(sueldo*0.2)
   where sueldo<(select max(sueldo) from empleados);
 end;
 /
 
--4 Ejecute el procedimiento creado anteriormente
execute pa_aumentarsueldo;

--5 Verifique que los sueldos han aumentado
select * from empleados;

--6 Ejecute el procedimiento nuevamente
execute pa_aumentarsueldo;

--7 Verifique que los sueldos han aumentado
select * from empleados;

--8 Elimine la tabla "empleados_antiguos"
drop table empleados_antiguos;
 
--9 Cree la tabla "empleados_antiguos"
create table empleados_antiguos(
  documento char(8),
  nombre varchar2(40)
);

--10 
/*Cree (o reemplace) un procedimiento almacenado que ingrese en la tabla 
"empleados_antiguos" el documento, nombre y apellido (concatenados) de todos 
los empleados de la tabla "empleados" que ingresaron a la empresa hace más de 
10 años*/
create or replace procedure pa_empleados_antiguos
as
 begin
  insert into empleados_antiguos
  select documento,nombre||' '||apellido
   from empleados
   where (extract(year from current_date)-extract(year from fechaingreso))>10;
 end;
 /

--11 Ejecute el procedimiento creado anteriormente
execute pa_empleados_antiguos;

--12 Verifique que la tabla "empleados_antiguos" ahora tiene registros (3 registros)
 select * from empleados_antiguos;
