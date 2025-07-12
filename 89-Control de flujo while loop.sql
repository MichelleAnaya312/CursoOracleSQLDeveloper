/*Primer Problema*/
--1
/*En el siguiente ejemplo se muestra la tabla del 3 hasta el 5:*/
 set serveroutput on;
 execute dbms_output.enable (20000);
declare
 numero number:=0;
 resultado number;
begin
  while numero<=5 loop
   resultado:=3*numero;
   dbms_output.put_line('3*'||to_char(numero)||'='||to_char(resultado));
   numero:=numero+1;
  end loop;
end;
/