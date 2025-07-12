/*Primer Problema*/
--1 
--Mostramos la tabla del 3.

/*En primer lugar activamos el paquete que contiene los procedimientos necesarios
para la salida de datos por pantalla (set serveroutput on) y habilitamos las 
llamadas a tales procedimientos.*/

/*Declaramos dos variables, "resultado" almacenará el resultado de las 
multiplicaciones (le asignamos el valor cero) y "multiplicador" será la 
que contenga los diferentes valores por los cuales multiplicaremos 3 
(asignándole el valor cero).*/

/*En el ciclo repetitivo se almacena en "resultado" el primer valor 
("multiplicador" contiene 0 así que el resultado es cero), luego se imprime, 
se incrementa la variable "multiplicador" (ahora contiene 1) y se evalúa la 
condición, dado que "multiplicador" no es mayor a 5, el ciclo se repite.*/

/*Cuando la condición resulta cierta, es decir, cuando "multiplicador" sea igual
a 6, el ciclo acabará:*/

set serveroutput on;
execute dbms_output.enable (1000000);
declare
  resultado number;
  multiplicador number:=0;
begin
  loop
    resultado:=3*multiplicador;
    dbms_output.put_line('3x'||to_char(multiplicador)||'='||to_char(resultado));
    multiplicador:=multiplicador+1;
    exit when multiplicador>5;
  end loop;
end;

--2
/*En el siguiente ejemplo se muestra la tabla del 4. Se almacena en una variable
"resultado" el resultado de la multiplicación, se chequea la condición, se 
imprime el resultado y se va incrementando la variable "multiplicador"; el ciclo
se repite hasta que la variable "resultado" llega o supera el valor 50:*/

declare
  resultado number;
  multiplicador number:=0;
begin
  loop
    resultado:=4*multiplicador;
    exit when resultado>=50;
    dbms_output.put_line('4x'||to_char(multiplicador)||'='||to_char(resultado));
    multiplicador:=multiplicador+1;
  end loop;
end;
/*Note que, cuando "resultado" cumple la condición del "exit when" 
(supera el valor 50), no se ejecutan las líneas de salida y de incremento de 
"multiplicador", se salta a "end loop" finalizando el bucle.*/

/*Segundo Problema*/
--1 Elimine la tabla y créela con la siguiente estructura:
drop table empleados;

create table empleados(
  nombre varchar2(40),
  sueldo number(6,2)
);

--2 Ingrese algunos registros:
insert into empleados values('Acosta Ana',550); 
insert into empleados values('Bustos Bernardo',850); 
insert into empleados values('Caseros Carolina',900); 
insert into empleados values('Dominguez Daniel',490); 
insert into empleados values('Fuentes Fabiola',820); 
insert into empleados values('Gomez Gaston',740); 
insert into empleados values('Huerta Hernan',1050); 

--3 Muestre la suma total de todos los sueldos realizando un "select" (5400)
select sum(sueldo) from empleados;

--4 
/*Se necesita incrementar los sueldos en forma proporcional, en un 10% cada vez y
controlar que la suma total de sueldos no sea menor a $7000, si lo es, el bucle
debe continuar y volver a incrementar los sueldos, en caso de superarlo, se 
saldrá del ciclo repetitivo; es decir, este bucle continuará el incremento de 
sueldos hasta que la suma de los mismos llegue o supere los 7000.*/
 declare
  total number;
 begin
  loop
    update empleados set sueldo=sueldo+(sueldo*0.1);
    select sum(sueldo) into total from empleados;
    exit when total>7000;     
  end loop;
 end;
 /
 
--5 
/*Verifique que los sueldos han sido incrementados y la suma de todos los sueldos
es superior a 7000*/
 select sueldo from empleados;
 select sum(sueldo) from empleados;
 
--6 Muestre el sueldo máximo realizando un "select"
select max(sueldo) from empleados;

--7 
/*Se necesita incrementar los sueldos en forma proporcional, en un 5% cada vez y
controlar que el sueldo máximo alcance o supere los $1600, al llegar o superarlo,
el bucle debe finalizar. Incluya una variable contador que cuente cuántas veces
se repite el bucle*/
--set serveroutput on;
--execute dbms_output.enable (20000);
 declare
  maximo number;
  contador number:=0;
 begin
  loop
    update empleados set sueldo=sueldo+(sueldo*0.05);
    contador:=contador+1;
    select max(sueldo) into maximo from empleados;
    exit when maximo>1600;
  end loop;
  dbms_output.put_line(contador);
 end;
 /
 
--8 
/*Verifique que los sueldos han sido incrementados y el sueldo máximo es igual o
superior a 1600*/
select sueldo from empleados;
select max(sueldo) from empleados;
 
--9 Muestre el sueldo mínimo realizando un "select"
select min(sueldo) from empleados;

--10 
/*Se necesita incrementar los sueldos en forma proporcional, en un 10% cada vez y
controlar que el sueldo mínimo no supere los $900. Emplee la sintaxis "if 
CONDICION then exit"*/
declare
  minimo number;
 begin
  loop
    select min(sueldo) into minimo from empleados;
    if (minimo+minimo*0.1>900) then exit;
    else
      update empleados set sueldo=sueldo+(sueldo*0.1);
    end if;
  end loop;
 end;
 /
 
--11 Muestre el sueldo mínimo realizando un "select"
select min(sueldo) from empleados;