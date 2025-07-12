select add_months('10/06/2020',5) from dual; --retorna "10/11/20"
 
select add_months('10/06/2020',-5) from dual; --retorna "10/01/20"
 
select add_months('30/01/2020',1) from dual;
-- retorna "29/02/20" ya que es el último día de ese mes.

select last_day('10/02/2020') from dual;-- "29/02/20"

select last_day('10/08/2020') from dual;-- "31/08/20"

select months_between('19/05/2020','21/06/20') from dual;
-- retorna  -1,06451613 

select months_between('21/05/2020','21/06/20') from dual;
-- retorna  -1

select months_between('21/07/2020','21/06/20') from dual;
-- retorna  1

select months_between('22/07/2020','21/06/20') from dual;
-- retorna  1.03225806451612903225806451612903225806

select next_day('10/08/2020','LUNES') from dual; -- 17/08/20

select current_date from dual;

select current_timestamp from dual;

select systimestamp from dual;

select to_date ('05-SEP-2019 10:00 AM','DD-MON-YYYY HH:MI AM') from dual;

select to_char('10/10/2020')from dual;

select extract(month from sysdate) from dual;

select to_date('15/12/2020')-5 from dual;

/*Primer Problema*/

--1 Eliminamos la tabla:
drop table libros;

--2 Creamos la tabla:
create table libros(
  titulo varchar2(40) not null,
  autor varchar2(20) default 'Desconocido',
  editorial varchar2(20),
  edicion date,
  precio number(6,2)
);

--3 Ingresamos algunos registros:
insert into libros values('El aleph','Borges','Emece','10/10/1980',25.33);
insert into libros values('Java en 10 minutos','Mario Molina','Siglo XXI','05/05/2000',50.65);
insert into libros
values('Alicia en el pais de las maravillas','Lewis Carroll','Emece','08/09/2000',19.95);
insert into libros values('Aprenda PHP','Mario Molina','Siglo XXI','02/04/2000',45);

select * from libros; 

--4 Mostramos el título del libro y el año de edición:
select titulo, extract (year from edicion) from libros;

--5 Mostramos el título del libro y el mes de edición:
select titulo, extract (month from edicion) from libros;

--6 Mostramos el título del libro y los años que tienen de editados:
select titulo, extract(year from sysdate)-extract(year from edicion) as "años de editado"
from libros;

--7 Mostramos los títulos de los libros que se editaron en el año 2000:
select titulo from libros
where extract(year from edicion)=2000;

--8 Calcule 3 meses luego de la fecha actual empleando ""add_months":
select add_months(sysdate,3) from dual;

--9 Muestre la fecha del primer martes desde la fecha actual:
select next_day(sysdate,'martes') from dual;

--10 
/*Muestre la fecha que será 15 días después de "24/08/2018" 
empleando el operador "+":*/
select to_date('24/08/2018')+15 from dual;
--Retorna 08/09/18.

--11 
/*Muestre la fecha que 20 días antes del "12/08/2018" 
empleando el operador "-":*/
select to_date('12/08/2018')-20 from dual;
--Retorna 23/07/18.


