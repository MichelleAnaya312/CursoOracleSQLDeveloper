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
  numeroitem number(3) not null, 
  articulo varchar2(30),
  precio number(5,2),
  cantidad number(4),
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
/*Se necesita una lista de todas las facturas que incluya el número, la fecha, 
el cliente, la cantidad de artículos comprados y el total en dinero:*/
select f.*,
  (select count(d.numeroitem)
    from detalles d
    where f.numero=d.numerofactura) as cantidad,
  (select sum(d.precio*cantidad)
    from detalles d
    where f.numero=d.numerofactura) as total
from facturas f;

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
  deporte varchar(20) not null,
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
/*Se necesita un listado de todos los socios que incluya nombre y domicilio, la 
cantidad de deportes a los cuales se ha inscripto, empleando subconsulta.*/
select nombre,domicilio,
  (select count(*)
    from inscriptos i
    where s.numero=i.numerosocio) as deportes
from socios s;
 
--5 
/*Se necesita el nombre de todos los socios, el total de cuotas que debe pagar 
(10 por cada deporte) y el total de cuotas pagas, empleando subconsulta.*/
select nombre,
  (select (count(*)*10)
    from inscriptos i
    where s.numero=i.numerosocio) as total,
  (select sum(i.cuotas)
    from inscriptos i
    where s.numero=i.numerosocio) as pagas
from socios s;
 
--6 Obtenga la misma salida anterior empleando join.
select nombre,
count(i.deporte)*10 as total,
sum(i.cuotas) as pagas
from socios s
join inscriptos i
on numero=numerosocio
group by nombre;