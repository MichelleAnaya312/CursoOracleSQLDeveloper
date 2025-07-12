/*Primer Problema:*/
--1
drop table libros;
 
 create table libros(
  codigo number(4) not null,
  titulo varchar2(40) not null,
  autor varchar2(20),
  editorial varchar2(20),
  precio number(6,2)
 );

--2
insert into libros
  values(1,'El aleph','Borges','Emece',15.90);
 insert into libros
  values(2,'Cervantes y el quijote','Borges','Paidos',null);
 insert into libros
  values(3,'Alicia en el pais de las maravillas','Lewis Carroll',null,19.90);
 insert into libros
  values(4,'Martin Fierro','Jose Hernandez','Emece',25.90);
 insert into libros (codigo,titulo,autor,precio)
  values(5,'Antología poética','Borges',25.50);
 insert into libros (codigo,titulo,autor)
  values(6,'Java en 10 minutos','Mario Molina');
 insert into libros (codigo,titulo,autor)
  values(7,'Martin Fierro','Jose Hernandez');
 insert into libros (codigo,titulo,autor)
  values(8,'Aprenda PHP',null);

--3
select * from libros
  where editorial is null;

--4
 select * from libros
  where editorial is not null;

--5
insert into libros (codigo,titulo,autor,editorial,precio)
  values(9,'Don quijote','Cervantes','   ',20);

--6
select * from libros;

--7
select * from libros where editorial is null;
 
select * from libros where editorial='   ';


/*Segundo Problema:*/
--1 Elimine la tabla y créela con la siguiente estructura
drop table medicamentos;

create table medicamentos(
  codigo number(5) not null,
  nombre varchar2(20) not null,
  laboratorio varchar2(20),
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
/*Ingrese un registro con valor "0" para el precio 
y cadena vacía para el laboratorio.*/
 insert into medicamentos (codigo,nombre, laboratorio,precio,cantidad)
  values(4,'Bayaspirina','',0,150);

--6
/*Intente ingresar un registro con cadena vacía 
para el nombre (mensaje de error)*/
insert into medicamentos (codigo,nombre,laboratorio,precio,cantidad)
  values(0,'','Bayer',15.60,200);

--7
/*Intente ingresar un registro con valor nulo para un campo
que no lo admite (aparece un mensaje de error)*/
insert into medicamentos (codigo,nombre,laboratorio,precio,cantidad)
  values(null,'Amoxidal jarabe','Bayer',25,120);

--8
/*Recupere los registros que contengan valor 
"null" en el campo "laboratorio" (3 registros)*/
select * from medicamentos
  where laboratorio is null;

--9
/*Recupere los registros que contengan valor 
"null" en el campo "precio", luego los que tengan el 
valor 0 en el mismo campo. Note que el resultado es distinto 
(2 y 1 registros respectivamente)*/
select * from medicamentos where precio is null;
select * from medicamentos where precio=0;

--10
/*Recupere los registros cuyo laboratorio no 
contenga valor nulo (1 registro)*/
select * from medicamentos where laboratorio is not null;

--11
/*Recupere los registros cuyo precio sea distinto de 0, 
luego los que sean distintos de "null" (1 y 2 
resgistros respectivamente)*/
select * from medicamentos where precio<>0;
select * from medicamentos where precio is not null;

/*Note que la salida de la primera sentencia 
no muestra los registros con valor 0 y tampoco 
los que tienen valor nulo; el resultado de la segunda 
sentencia muestra los registros con valor para el campo 
precio (incluso el valor 0).*/

--12
/*Ingrese un registro con una 
cadena de 1 espacio para el laboratorio.*/
insert into medicamentos (codigo,nombre, laboratorio,precio,cantidad)
  values(5,'Geniol',' ',0.5,200);
  
--13
/*Recupere los registros cuyo laboratorio sea "null" y
luego los que contengan 1 espacio (3 y 1 registros 
respectivamente)*/
 select * from medicamentos where laboratorio is null;
 select * from medicamentos where laboratorio=' ';

/*Note que la salida de la primera sentencia no muestra 
los registros con valores para el campo "laboratorio" 
(un caracter espacio es un valor); el resultado de la segunda 
sentencia muestra los registros con el valor " " para el campo 
precio.*/

--14
/*Recupere los registros cuyo laboratorio sea 
distinto de ' '(cadena de 1 espacio), luego los que 
sean distintos de "null" (1 y 2 registros respectivamente)*/
 select * from medicamentos where laboratorio<>' ';
 select * from medicamentos where laboratorio is not null;

/*Note que la salida de la primera sentencia no muestra 
los registros con valor ' ' y tampoco los que tienen valor 
nulo; el resultado de la segunda sentencia muestra los 
registros con valor para el campo laboratorio 
(incluso el valor ' ')*/






