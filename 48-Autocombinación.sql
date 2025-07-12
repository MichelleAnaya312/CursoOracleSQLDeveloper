/*Primer Problema*/
--1 Eliminamos la tabla:
drop table comidas;

--2 Creamos la tabla:
create table comidas(
  codigo number(2),
  nombre varchar2(30),
  precio number(4,2),
  rubro char(6),-- 'plato'=plato principal', 'postre'=postre
  primary key(codigo)
);

--3 Ingresamos algunos registros:
insert into comidas values(1,'ravioles',5,'plato');
insert into comidas values(2,'tallarines',4,'plato');
insert into comidas values(3,'milanesa',7,'plato');
insert into comidas values(4,'cuarto de pollo',6,'plato');
insert into comidas values(5,'flan',2.5,'postre');
insert into comidas values(6,'porcion torta',3.5,'postre');

select * from comidas;

--4 Realizamos un "cross join":
select c1.nombre,
c2.nombre,
c1.precio+c2.precio as total
from comidas c1
cross join comidas c2;
/*Note que aparecen filas duplicadas, por ejemplo, "ravioles" 
se combina con "ravioles" y la combinación "ravioles- flan" se repite 
como "flan- ravioles".*/

--5 Debemos especificar que combine el rubro "plato" con "postre":
select c1.nombre as "plato principal",
c2.nombre as postre,
c1.precio+c2.precio as total
from comidas c1
cross join comidas c2
where c1.rubro='plato' and
c2.rubro='postre';
/*La salida muestra cada plato combinado con cada postre, y una columna extra 
que calcula el total del menú.*/

--6 También se puede realizar una autocombinación con "join":
select c1.nombre as "plato principal",
c2.nombre as postre,
c1.precio+c2.precio total
from comidas c1
join comidas c2
on c1.codigo<>c2.codigo
where c1.rubro='plato' and
c2.rubro='postre';
/*Para que no aparezcan filas duplicadas se agrega un "where".*/

/*Segundo Problema*/
--1  Elimine la tabla y créela:
drop table clientes;

create table clientes(
  nombre varchar2(30),
  sexo char(1),--'f'=femenino, 'm'=masculino
  edad number(2),
  domicilio varchar2(30)
);

--2 Ingrese los siguientes registros:
insert into clientes values('Maria Lopez','f',45,'Colon 123');
insert into clientes values('Liliana Garcia','f',35,'Sucre 456');
insert into clientes values('Susana Lopez','f',41,'Avellaneda 98');
insert into clientes values('Juan Torres','m',44,'Sarmiento 755');
insert into clientes values('Marcelo Oliva','m',56,'San Martin 874');
insert into clientes values('Federico Pereyra','m',38,'Colon 234');
insert into clientes values('Juan Garcia','m',50,'Peru 333');

--3
/*La agencia necesita la combinación de todas las personas de sexo femenino 
con las de sexo masculino. Use un "cross join" (12 filas)*/
select cm.nombre,cm.edad,cv.nombre,cv.edad
from clientes cm
cross join clientes cv
where cm.sexo='f' and cv.sexo='m';

--4 Obtenga la misma salida anterior pero realizando un "join"
select cm.nombre,cm.edad,cv.nombre,cv.edad
from clientes cm
join clientes cv
on cm.nombre<>cv.nombre
where cm.sexo='f' and cv.sexo='m';
  
--5 
/*Realice la misma autocombinación que el punto 3 pero agregue la condición 
que las parejas no tengan una diferencia superior a 5 años (5 filas)*/
select cm.nombre,cm.edad,cv.nombre,cv.edad
from clientes cm
cross join clientes cv
where cm.sexo='f' and cv.sexo='m' and
cm.edad-cv.edad between -5 and 5;