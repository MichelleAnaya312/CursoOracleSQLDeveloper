/*Primer Problema*/
--1 
/*Eliminamos la tabla y la creamos con la 
siguiente estructura:*/
drop table libros;

create table libros(
  codigo number(5) not null,
  titulo varchar2(40) not null,
  autor varchar2(20) default 'Desconocido',
  editorial varchar2(20),
  edicion date,
  precio number(6,2)
);

--2 Ingresamos algunos registros:
insert into libros
values(1,'El aleph','Borges','Emece','15/01/2000',15.90);
insert into libros
values(2,'Cervantes y el quijote','Borges','Paidos',null,null);
insert into libros
values(3,'Alicia en el pais de las maravillas','Lewis Carroll',null,'25/03/2000',19.90);
insert into libros
values(4,'Martin Fierro','Jose Hernandez','Emece','18/05/2000',25.90);
insert into libros (codigo,titulo,autor,edicion,precio)
values(5,'Antología poética','Borges','25/08/2000',32);
insert into libros (codigo,titulo,autor,edicion,precio)
values(6,'Java en 10 minutos','Mario Molina','11/02/2007',45.80);
insert into libros (codigo,titulo,autor,edicion,precio)
values(7,'Martin Fierro','Jose Hernandez','23/11/2006',40);
insert into libros (codigo,titulo,autor,edicion,precio)
values(8,'Aprenda PHP','Mario Molina','01/06/2007',56.50);

select * from libros;

--3
/*Recuperamos los registros cuyo precio esté entre 20 y 40 
empleando "between":*/
select * from libros
where precio between 20 and 40;
/*Note que si el campo tiene el valor "null", no aparece en 
la selección.*/

--4
/*Para seleccionar los libros cuyo precio NO esté 
entre un intervalo de valores antecedemos "not" al 
"between":*/
select * from libros
where precio not between 20 and 40;
/*Note que si el campo tiene el valor "null", no aparece en 
la selección.*/

--5
/*Recuperamos los títulos y edición de los libros cuya 
fecha de edición se encuentre entre '01/05/2000' y 
'01/05/2007', ordenados por fecha de edición:*/
select titulo, edicion from libros
where edicion between '01/05/2000' and '01/05/2007'
order by edicion;

/*Segundo Problema*/
--1 Elimine la tabla "visitas" y créela con la siguiente estructura:
drop table visitas;

create table visitas (
  nombre varchar2(30) default 'Anonimo',
  mail varchar2(50),
  pais varchar2(20),
  fecha date
);

--2 Ingrese algunos registros:
insert into visitas
values ('Ana Maria Lopez','AnaMaria@hotmail.com','Argentina','10/10/2016');
insert into visitas
values ('Gustavo Gonzalez','GustavoGGonzalez@gotmail.com','Chile','10/10/2016');
insert into visitas
values ('Juancito','JuanJosePerez@hotmail.com','Argentina','11/10/2016');
insert into visitas 
values ('Fabiola Martinez','MartinezFabiola@hotmail.com','Mexico','12/10/2016');
insert into visitas
values ('Fabiola Martinez','MartinezFabiola@hotmail.com','Mexico','12/09/2016');
insert into visitas
values ('Juancito','JuanJosePerez@gmail.com','Argentina','12/09/2016');
insert into visitas 
values ('Juancito','JuanJosePerez@hotmail.com','Argentina','15/09/2016');
insert into visitas 
values ('Federico1','federicogarcia@xaxamail.com','Argentina',null);

select * from visitas;

--3
/*Seleccione los usuarios que visitaron la página entre el '12/09/2016' 
y '11/10/2016' (6 registros)
Note que incluye los de fecha mayor o igual al valor mínimo y menores o 
iguales al valor máximo, y que los valores nulos no se incluyen.*/
select * from visitas
where fecha between '12/09/2016' and '11/10/2016';

