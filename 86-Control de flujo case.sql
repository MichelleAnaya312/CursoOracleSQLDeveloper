/*Primer Problema*/
--1 Eliminamos la tabla y luego la creamos con la siguiente estructura:
drop table empleados;

create table empleados (
  documento char(8),
  nombre varchar(30),
  fechanacimiento date  
);

--2 Ingresamos algunos registros:
insert into empleados values('20111111','Acosta Ana','10/05/1968');
insert into empleados values('22222222','Bustos Bernardo','09/07/1970');
insert into empleados values('22333333','Caseros Carlos','15/10/1971');
insert into empleados values('23444444','Fuentes Fabiana','25/01/1972');
insert into empleados values('23555555','Gomez Gaston','28/03/1979');
insert into empleados values('24666666','Juarez Julieta','18/02/1981');
insert into empleados values('25777777','Lopez Luis','17/09/1978');
insert into empleados values('26888888','Morales Marta','22/12/1975');

--3 
/*Nos interesa el nombre del mes en el cual cada empleado cumple años. 
Podemos utilizar la estructura condicional "case". 
Para ello crearemos una función que reciba una fecha y retorne una cadena de 
caracteres indicando el nombre del mes de la fecha enviada como argumento:*/
create or replace function f_mes(afecha date)
   return varchar2
 is
  mes varchar2(20);
 begin
   mes:='enero';
   case extract(month from afecha)
     when 1 then mes:='enero'; 
     when 2 then mes:='febrero';
     when 3 then mes:='marzo';
     when 4 then mes:='abril';k
     when 5 then mes:='mayo';
     when 6 then mes:='junio';
     when 7 then mes:='julio';
     when 8 then mes:='agosto';
     when 9 then mes:='septiembre';
     when 10 then mes:='octubre';
     when 11 then mes:='noviembre';
     else mes:='diciembre';
   end case;
   return mes;
 end;
 /
 
--4 
/*Recuperamos el nombre del empleado y el mes de su cumpleaños realizando un 
"select":*/
select nombre, f_mes(fechanacimiento) as cumpleaños from empleados;

--5 Podemos probar la función creada anteriormente enviándole la siguiente fecha:
select f_mes('10/10/2018') from dual;
--obtenemos como resultado "octubre".

--6
/*Realizamos una función que reciba una fecha y retorne si se encuentra en el 1º,
2º, 3º ó 4º trimestre del año:*/
create or replace function f_trimestre(afecha date)
   return varchar2
 is
  mes varchar2(20);
  trimestre number;
 begin
   mes:=extract(month from afecha);
   trimestre:=4;
   case mes
     when 1 then trimestre:=1;
     when 2 then trimestre:=1;
     when 3 then trimestre:=1;
     when 4 then trimestre:=2;
     when 5 then trimestre:=2;
     when 6 then trimestre:=2;
     when 7 then trimestre:=3;
     when 8 then trimestre:=3;
     when 9 then trimestre:=3;
     else trimestre:=4;
   end case;
   return trimestre;
 end;
 /

--7
/*Recuperamos el nombre del empleado y el trimestre de su cumpleaños empleando la
función creada anteriormente:*/
select nombre, f_trimestre(fechanacimiento) from empleados;

--8 
/*Vamos a emplear "case" dentro de un "select". Veamos un ejemplo similar a la 
función anterior:*/
select nombre,fechanacimiento,
  case extract(month from fechanacimiento)
   when 1 then 1
   when 2 then 1
   when 3 then 1
   when 4 then 2
   when 5 then 2
   when 6 then 2
   when 7 then 3
   when 8 then 3
   when 9 then 3
  else  4
  end as trimestre
  from empleados
  order by trimestre;
  
/*Segundo Problema*/
--1 Elimine la tabla y luego créela con la siguiente estructura:
drop table empleados;

create table empleados (
  documento char(8),
  nombre varchar(30),
  fechanacimiento date,
  hijos number(2),
  sueldo number(6,2),
  sexo char(1)  
);

--2 Ingrese algunos registros:
insert into empleados values('20000000','Acosta Ana','10/05/1968',0,800,'f');
insert into empleados values('21111111','Bustos Bernardo','09/07/1970',2,550,'m');
insert into empleados values('22222222','Caseros Carlos','15/10/1971',3,500,'m');
insert into empleados values('23333333','Fuentes Fabiana','25/08/1972',0,500,'f');
insert into empleados values('24444444','Gomez Gaston','28/03/1979',1,850,'m');
insert into empleados values('25555555','Juarez Javier','18/08/1981',2,600,'m');
insert into empleados values('26666666','Lopez Luis','17/09/1978',4,690,'m');
insert into empleados values('27777777','Morales Marta','22/08/1975',2,480,'f');
insert into empleados values('28888888','Norberto Nores','11/08/1973',3,460,'m');
insert into empleados values('29999999','Oscar Oviedo','19/07/1976',0,700,'m');

--3 
/*La empresa tiene por política festejar los cumpleaños de sus empleados cada mes,
si es de sexo femenino se le regala un ramo de flores, sino, una lapicera. 
Realice un "select" mostrando el nombre del empleado, el día del cumpleaños y una
columna extra que muestre "FLORES" o "LAPICERA" según el sexo del empleado (case),
de todos los empleados que cumplen años en el mes de agosto (where) y ordene por
día.*/
select nombre,extract (day from fechanacimiento) as dia,
  case sexo
   when 'f' then 'FLORES'
   else 'LAPICERA'
  end as regalo
 from empleados
 where extract(month from fechanacimiento)='08'
 order by 2;
