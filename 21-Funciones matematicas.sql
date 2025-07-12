select abs(-20) from dual;--retorna 20

select ceil(12.34) from dual;--retorna 13

select floor(12.34) from dual; --12

select mod(10,3) from dual;--retorna 1

select mod(10,2) from dual;--retorna 0

select power(2,3) from dual;--retorna 8

select round(123.456,2) from dual;
-- retorna "123.46", es decir, redondea desde el segundo decimal.

select round(123.456,1) from dual;
-- 123.5, es decir, redondea desde el primer decimal.

select round(123.456,-1) from dual;
-- 120, redondea desde el primer valor entero (hacia la izquierda).

select round(123.456,-2) from dual;
-- 100, redondea desde el segundo valor entero (hacia la izquierda).

select round(123.456) from dual;
-- 123.

select sign(-120) from dual;--retorna -1

select sign(120) from dual;--retorna 1

select sign(0) from dual;--retorna 0

select trunc(1234.5678,2) from dual;--retorna 1234.56

select trunc(1234.5678,-2) from dual;--retorna 1200

select trunc(1234.5678,-1) from dual;--retorna 1230

select trunc(1234.5678) from dual;--retorna 1234

select sqrt(9) from dual;--retorna 3

/*Primer Problema*/
--1 Eliminamos la tabla:
drop table empleados;

--2 Creamos la tabla:
create table empleados(
  legajo number(5),
  documento char(8) not null,
  nombre varchar2(30) not null,
  domicilio varchar2(30),
  sueldo number(6,2),
  hijos number(2),
  primary key (legajo)
);

--3 Ingresamos algunos registros:
insert into empleados
values(1,'22333444','Ana Acosta','Avellaneda 213',870.79,2);
insert into empleados
values(20,'27888999','Betina Bustos','Bulnes 345',950.85,1);
insert into empleados
values(31,'30111222','Carlos Caseres','Caseros 985',1190,0);
insert into empleados
values(39,'33444555','Daniel Duarte','Dominicana 345',1250.56,3);

select * from empleados;

--4 
/*Vamos a mostrar los sueldos de los empleados redondeando el valor hacia 
abajo y luego hacia arriba (empleamos "floor" y "ceil"):*/
select floor(sueldo) as "sueldo hacia abajo",
ceil(sueldo) as "sueldo hacia arriba"
from empleados;

--5
/*Mostramos los nombre de cada empleado, su respectivo sueldo, 
y el sueldo redondeando el valor a entero ("round") y truncado a entero 
("trunc"):*/
select nombre, sueldo, round(sueldo) as "sueldo redondeado",
trunc(sueldo) as "sueldo truncado"
from empleados;
/*Note que los valores devueltos según la función empleada, son diferentes.*/

--6 Mostramos el resultado de "2 elevado a la potencia 5" ("power"):
select power(2,5) from dual;
--Retorna el valor 32.

--7 Mostramos el resto de la división "1234 / 5" ("mod"):
select mod(1234,5) from dual;
--Devuelve el valor 4.

--8 Calculamos la raíz cuadrada de 81:
select sqrt(81) from dual;
--Retorna 9.








