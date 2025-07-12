/*Primer Problema*/
--1 Eliminamos las tablas:
drop table detalles;

drop table facturas;

--2 Las creamos con las siguientes estructuras:
create table facturas(
  numero number(5) not null,
  fecha date,
  cliente varchar2(30),
  primary key(numero)
);

create table detalles(
  numerofactura number(5) not null,
  numeroitem number(4) not null, 
  articulo varchar2(30),
  precio number(5,2),
  cantidad number(3),
  primary key(numerofactura,numeroitem),
  constraint FK_detalles_numerofactura
   foreign key (numerofactura)
   references facturas(numero)
   on delete cascade
);

--3 Ingresamos algunos registros:
insert into facturas values(1200,'15/01/2017','Juan Lopez');
insert into facturas values(1201,'15/01/2017','Luis Torres');
insert into facturas values(1202,'15/01/2017','Ana Garcia');
insert into facturas values(1300,'20/01/2017','Juan Lopez');

insert into detalles values(1200,1,'lapiz',1,100);
insert into detalles values(1200,2,'goma',0.5,150);
insert into detalles values(1201,1,'regla',1.5,80);
insert into detalles values(1201,2,'goma',0.5,200);
insert into detalles values(1201,3,'cuaderno',4,90);
insert into detalles values(1202,1,'lapiz',1,200);
insert into detalles values(1202,2,'escuadra',2,100);
insert into detalles values(1300,1,'lapiz',1,300);

--4 
/*Empleamos una subconsulta correlacionada con un operador "exists" en la 
cláusula "where" para devolver la lista de clientes que compraron el artículo 
"lapiz":*/
select cliente,numero
from facturas f
where exists
   (select * from detalles d
     where f.numero=d.numerofactura
     and d.articulo='lapiz');


--5 Obtenemos el mismo resultado empleando una combinación:
select * from facturas
join detalles
on facturas.numero=detalles.numerofactura
where detalles.articulo='lapiz';

--6 Buscamos los clientes que NO han comprado el artículo "lapiz":
select cliente,numero
from facturas f
where not exists
   (select * from detalles d
     where f.numero=d.numerofactura
     and d.articulo='lapiz');
     
/*Segundo Problema*/  
--1 Elimine las tablas:
drop table inscriptos;
 
drop table socios;

--2 Cree las tablas:
create table socios(
  numero number(4),
  documento char(8),
  nombre varchar2(30),
  domicilio varchar2(30),
  primary key (numero)
);
 
create table inscriptos (
  numerosocio number(4) not null,
  deporte varchar2(20) not null,
  cuotas number(2) default 0,
  constraint CK_inscriptos_cuotas
   check (cuotas>=0 and cuotas<=10),
  primary key(numerosocio,deporte),
  constraint FK_inscriptos_socio
   foreign key (numerosocio)
   references socios(numero)
   on delete cascade
);

--3 Ingrese algunos registros:
insert into socios values(1,'23333333','Alberto Paredes','Colon 111');
insert into socios values(2,'24444444','Carlos Conte','Sarmiento 755');
insert into socios values(3,'25555555','Fabian Fuentes','Caseros 987');
insert into socios values(4,'26666666','Hector Lopez','Sucre 344');

insert into inscriptos values(1,'tenis',1);
insert into inscriptos values(1,'basquet',2);
insert into inscriptos values(1,'natacion',1);
insert into inscriptos values(2,'tenis',9);
insert into inscriptos values(2,'natacion',1);
insert into inscriptos values(2,'basquet',default);
insert into inscriptos values(2,'futbol',2);
insert into inscriptos values(3,'tenis',8);
insert into inscriptos values(3,'basquet',9);
insert into inscriptos values(3,'natacion',0);
insert into inscriptos values(4,'basquet',10);

--4
/*Emplee una subconsulta con el operador "exists" para devolver la lista de 
socios que se inscribieron en un determinado deporte.*/
select nombre
from socios s
where exists
   (select * from inscriptos i
     where s.numero=i.numerosocio
     and i.deporte='natacion');

--5
/*Busque los socios que NO se han inscripto en un deporte determinado 
empleando "not exists".*/
select nombre
from socios s
where not exists
   (select * from inscriptos i
     where s.numero=i.numerosocio
     and i.deporte='natacion');
     
--6 Muestre todos los datos de los socios que han pagado todas las cuotas.
select s.*
from socios s
where exists
   (select * from inscriptos i
     where s.numero=i.numerosocio
     and i.cuotas=10);
     
--7 
/*Obtenga el mismo resultado de la consulta anterior pero esta vez emplee una 
combinación.*/
select s.* from socios s
where exists
    (select * from inscriptos i
    where s.numero=i.numerosocio
    and i.cuotas=10);