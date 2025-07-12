/*Primer Problema*/
--1 Eliminamos la tabla:
drop table libros;

--2 Creamos la tabla "libros" con la siguiente estructura:
create table libros(
  codigo number(3),
  titulo varchar2(40),
  autor varchar2(30),
  precio number(5,2)
);

--3 Ingresamos algunos registros:
insert into libros values(100,'Uno','Richard Bach',15);
insert into libros values(300,'Aprenda PHP','Mario Molina',55);
insert into libros values(102,'Matematica estas ahi','Paenza',18);
insert into libros values(105,'El aleph','Borges',25);
insert into libros values(109,'El experto en laberintos','Gaskin',20);
insert into libros values(204,'Alicia en el pais de las maravillas','Carroll',31);

--4 
/*Creamos o reemplazamos una función que reciba 1 parámetro (un valor numérico a
incrementar) y retorne el valor ingresado como argumento con el incremento del
10%:*/
create or replace function f_incremento10 (avalor number)
  return number
 is
 begin 
   return avalor+(avalor*0.1);
 end;
/

--5 
/*Realizamos un "select" sobre "libros" que muestre el título, precio y llamamos
a la función creada anteriormente para que nos devuelva el precio incrementado
en un 10%:*/
select titulo,precio,f_incremento10(precio) from libros;

--6 
/*Creamos otra función que reciba 2 parámetros, un valor a incrementar y el
incremento, y que nos retorne el valor ingresado como primer argumento con el
incremento especificado por el segundo argumento:*/
create or replace function f_incremento (avalor number, aincremento number)
  return number
 is
  begin 
   return avalor+(avalor*aincremento/100);
  end;
/

--7 
/*Realizamos un "select" sobre "libros" que muestre el título, precio y el precio
incrementado en un 20% (llamando a la función creada anteriormente, enviando como
primer argumento el campo "precio" y como segundo argumento el valor "20"):*/
select titulo,precio,f_incremento(precio,20) from libros;

--8 
/*Realizamos otro "select" similar al anterior, pero en esta ocasión le enviamos
a la función otro valor como segundo argumento:*/
select titulo,precio,f_incremento(precio,50) from libros;

--9 
/*Creamos o reemplazamos una función que recibe un parámetro de tipo numérico y
retorna una cadena de caracteres. Se define una variable en la zona de definición
de variables denominada "valorretornado" de tipo varchar. En el cuerpo de la
función empleamos una estructura condicional (if) para averiguar si el valor
enviado como argumento es menor o igual a 20, si lo es, almacenamos en la
variable "valorretornado" la cadena "economico", en caso contrario guardamos 
en tal variable la cadena "costoso"; al finalizar la estructura condicional
retornamos la variable "valorretornado":*/
create or replace function f_costoso (avalor number)
  return varchar2
 is
  valorretornado varchar2(20);
 begin
   valorretornado:='';
   if avalor<=20 then
    valorretornado:='economico';
   else valorretornado:='costoso';
   end if;
   return valorretornado;
 end;
/

--10 
/*Realizamos un "select" para mostrar el título, precio y una cadena que 
indique si el libro es económico o costoso (llamando a la función creada
anteriormente):*/
select titulo,precio,f_costoso(precio) from libros;

--11 
/*Podemos emplear la función "f_costoso" sin incluir campos de una tabla. 
Por ejemplo:*/
select f_costoso (10) from dual;