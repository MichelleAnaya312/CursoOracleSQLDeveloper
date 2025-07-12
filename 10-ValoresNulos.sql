/*Primer Problema:*/
--1
drop table libros;

--2
create table libros(
  titulo varchar2(30) not null,
  autor varchar2(20) not null,
  editorial varchar2(15) null,
  precio number(5,2) 
 );

--3
insert into libros (titulo,autor,editorial,precio)
  values('El aleph','Borges','Emece',null);

select * from libros;
--4
insert into libros (titulo,autor,editorial,precio)
  values('Alicia en el pais','Lewis Carroll',null,25);

select * from libros;

--5
/*camppo titulo es not null*/
insert into libros (titulo,autor,editorial,precio)
  values(null,'Borges','Siglo XXI',25);
--sale error

--6
describe libros;
-- columna titulo y autor son not null

--7
/*Dijimos que la cadena vacía es interpretada como valor "null". 
Vamos a ingresar un registro con cadena vacía para el campo 
"editorial":*/
insert into libros (titulo,autor,editorial,precio)
  values('Uno','Richard Bach','',18.50);

select * from libros;

--8 Intentamos ingresar una cadena vacía en el campo "titulo":
insert into libros (titulo,autor,editorial,precio)
  values('','Richard Bach','Planeta',22);
/*Mensaje de error indicando que el campo titulo
no admite valores nulos. */

--9
/*Dijimos que una cadena de espacios NO es igual a una cadena 
vacía o valor "null". Vamos a ingresar un registro y en el campo
"editorial" guardaremos una cadena de 3 espacios:*/
insert into libros (titulo,autor,editorial,precio)
  values('Don quijote','Cervantes','   ',20);

--10 Veamos cómo se almacenó el registro:
select * from libros;
--Se muestra la cadena de espacios.

--11 
/*Recuperamos los registros que contengan en el campo 
"editorial" una cadena de 3 espacios:*/
select *from libros where editorial='   ';

/*Segundo Problema:*/
--1 Elimine la tabla y créela con la siguiente estructura:
drop table medicamentos;

create table medicamentos(
  codigo number(5) not null,
  nombre varchar2(20) not null,
  laboratorio varchar2(20) null,
  precio number(5,2),
  cantidad number(3,0) not null
 );

--2
/*Visualice la estructura de la tabla "medicamentos"
note que los campos "codigo", "nombre" y "cantidad", 
en la columna "Null" muestra "NOT NULL".*/
describe medicamentos;

--3 
/*Ingrese algunos registros con valores "null" 
para los campos que lo admitan:*/
insert into medicamentos (codigo,nombre,laboratorio,precio,cantidad)
  values(1,'Sertal gotas',null,null,100); 
 insert into medicamentos (codigo,nombre,laboratorio,precio,cantidad)
  values(2,'Sertal compuesto',null,8.90,150);
 insert into medicamentos (codigo,nombre,laboratorio,precio,cantidad)
  values(3,'Buscapina','Roche',null,200);


--4 Vea todos los registros.
select * from medicamentos;

--5
/*Ingrese un registro con valor "0" para el 
precio y cadena vacía para el laboratorio.*/
 insert into medicamentos (codigo,nombre, laboratorio,precio,cantidad)
  values(4,'Bayaspirina','',0,150);


--6
/*Intente ingresar un registro con cadena vacía 
para el nombre (mensaje de error)*/
insert into medicamentos (codigo,nombre,laboratorio,precio,cantidad)
  values(0,'','Bayer',15.60,200);

--7
/*Intente ingresar un registro con valor nulo para 
un campo que no lo admite (aparece un mensaje de error)*/
insert into medicamentos (codigo,nombre,laboratorio,precio,cantidad)
  values(null,'Amoxidal jarabe','Bayer',25,120);

--8
/*Ingrese un registro con una cadena de 1 espacio 
para el laboratorio.*/
insert into medicamentos (codigo,nombre, laboratorio,precio,cantidad)
  values(5,'Geniol',' ',0.5,200);

--9
/*Recupere los registros cuyo laboratorio 
contenga 1 espacio (1 registro)*/
select * from medicamentos where laboratorio=' ';

--10
/*Recupere los registros cuyo laboratorio sea distinto 
de ' '(cadena de 1 espacio) (1 registro)*/
 select * from medicamentos where laboratorio<>' ';




