/*Primer Problema*/

--1 
/*Con la estructura repetitiva "for... loop" que vaya del 1 al 20, muestre los 
números pares. Dentro del ciclo debe haber una estructura condicional que 
controle que el número sea par y si lo es, lo imprima por pantalla.*/
set serveroutput on;
 execute dbms_output.enable(20000);
 begin 
  for numero in 1..20 loop
   if mod(numero,2)=0 then
    dbms_output.put_line(numero);
   end if;
  end loop;
 end;
 /
 
--2 
/*Con la estructura repetitiva "for... loop" muestre la sumatoria del número 5;
la suma de todos los números del 1 al 5. Al finalizar el ciclo debe mostrarse 
por pantalla la sumatoria de 5 (15)*/
declare
 sumatoria number:=0;
 begin
  for numero in 1..5 loop
   sumatoria:=sumatoria+numero;
  end loop;
  dbms_output.put_line(sumatoria);
 end;
 /
 
--3
/*Cree una función que reciba un valor entero y retorne el factorial de tal 
número; el factorial se obtiene multiplicando el valor que recibe por el 
anterior hasta llegar a multiplicarlo por uno)*/
create or replace function f_factorial(avalor number)
  return number
 is
  valorretornado number:=1;
 begin
   for f in reverse 1..avalor loop
     valorretornado:=valorretornado*f;
   end loop;
   return valorretornado;
 end;
 /
 
--4 
/*Llame a la función creada anteriormente y obtenga el factorial de 5 y de 4 
(120 y 24)*/
select f_factorial(5) from dual;
select f_factorial(4) from dual;
 
--5 
/*Cree un procedimiento que reciba dos parámetros numéricos; el procedimiento 
debe mostrar la tabla de multiplicar del número enviado como primer argumento, 
desde el 1 hasta el númeo enviado como segundo argumento. Emplee "for"*/
create or replace procedure pa_tabla(anumero number, alimite number)
  as 
 begin
  dbms_output.put_line('Tabla del '||to_char(anumero));
  for f in 1..alimite loop
    dbms_output.put_line(to_char(anumero)||'x'||to_char(f)||'='||to_char(f*anumero));
  end loop;
 end;
 /
 
--6
/*Ejecute el procedimiento creado anteriormente enviándole los valores 
necesarios para que muestre la tabla del 6 hasta el 20*/
execute pa_tabla(6,20);
 
--7 
/*Ejecute el procedimiento creado anteriormente enviándole los valores 
necesarios para que muestre la tabla del 9 hasta el 10*/
execute pa_tabla(9,10);
