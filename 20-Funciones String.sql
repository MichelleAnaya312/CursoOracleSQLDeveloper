select chr(65) from dual;-- retorna 'A'.

select chr(100) from dual;-- retorna 'd'.

select concat('Buenas',' tardes') from dual;
--retorna 'Buenas tardes'.

select initcap('buenas tardes alumno') from dual;
--retorna 'Buenas Tardes Alumno'.

select lower('Buenas tardes ALUMNO') from dual;
--retorna "buenas tardes alumno".

select upper('www.oracle.com') from dual;
-- 'WWW.ORACLE.COM'

select lpad('alumno',10,'xyz') from dual;
-- retorna 'xyzxalumno'

select lpad('alumno',4,'xyz') from dual;
-- retorna 'alum'

select rpad('alumno',10,'xyz') from dual;
-- retorna 'alumnoxyzx'

select rpad('alumno',4,'xyz') from dual;
-- retorna 'alum'

select ltrim('la casa de la cuadra','la') from dual;
-- ' casa de la cuadra'

select ltrim(' es la casa de la cuadra','la') from dual;
-- no elimina ningún caracter

select ltrim('  la casa') from dual;
-- 'la casa'

select rtrim('la casa lila','la') from dual;
-- 'la casa li'

select rtrim('la casa lila ','la') from dual;
-- no borra ningún caracter
 
select rtrim('la casa lila    ') from dual; 
--'la casa lila'

select trim('   oracle     ') from dual;
--'oracle'

select replace('xxx.oracle.com','x','w') from dual;

select substr('www.oracle.com',1,10) from dual;
-- 'www.oracle'

select substr('www.oracle.com',5,6) from dual;
-- 'oracle'

select length('www.oracle.com') from dual;
-- devuelve 14.

select instr('Jorge Luis Borges','or') from dual;
-- 2

select instr('Jorge Luis Borges','ar') from dual;
-- 0, no se encuentra

select translate('JORGE LUIS BORGES','OSG','056') from dual;
--'J0R6E LUI5 B0R6E5'

/*Primer Problema*/
--1 Eliminamos la tabla:
drop table libros;

--2 Creamos la tabla:
create table libros(
  codigo number(5),
  titulo varchar2(40) not null,
  autor varchar2(20) default 'Desconocido',
  editorial varchar2(20),
  precio number(6,2),
  cantidad number(3)
);

--3 Ingresamos algunos registros:
insert into libros
values(1,'El aleph','Borges','Emece',25,100);
insert into libros
values(2,'Java en 10 minutos','Mario Molina','Siglo XXI',50.40,100);
insert into libros
values(3,'Alicia en el pais de las maravillas','Lewis Carroll','Emece',15.50,200);
insert into libros
values(4,'El pais de las hadas',default,'Emece',25.50,150);

select * from libros;
--4 
/*Mostramos sólo los 12 primeros caracteres de los títulos 
de los libros y sus autores, empleando la función "substr":*/
select substr(titulo,1,12) as titulo
from libros;

--5
/*Mostramos sólo los 20 primeros caracteres de los títulos 
de los libros y rellenando los espacios restantes con "*", 
empleando la función "rpad":*/ 
select rpad(titulo,20,'*') as titulo
from libros;

--6 
/*Mostramos los títulos de los libros 
empleando la función "initcap":*/
select initcap(titulo) as titulo
from libros;
/*Note que cada palabra comienza con mayúsculas.*/

--7 
/*Mostramos los títulos de los libros y 
sus autores en mayúsculas:*/
select titulo,upper(autor) as autor
from libros;

--8 Concatenamos título y autor empleando "concat":
select concat(titulo, autor)
from libros;

--9
/*Mostramos el título y el precio de todos los libros 
concatenando el signo "$" a los precios:*/
select titulo,concat('$ ',precio) as precio
from libros;

--10 
/*Recuperamos el título y editorial de "libros" 
reemplazando "Emece" por "Sudamericana":*/
select titulo,replace(editorial,'Emece','Sudamericana')
from libros;

--11
/*Recuperamos el autor de todos los libros reemplazando 
las letras "abc" por "ABC" respectivamente 
(empleando "translate"):*/
select translate(autor,'abc','ABC') from libros;
/*Note que cada caracter individual es reemplazado por 
el especificado.*/

--12 
/*Mostramos la posición de la primera ocurrencia de la 
cadena "pais" en los títulos de los libros:*/
select instr(titulo,'pais') from libros;
/*Note que los títulos que no contienen la subcadena 
"pais" muestran el valor cero.*/

