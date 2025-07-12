/*Primer Problema*/
--1 Eliminamos la tabla:
drop table notas;

--2 Creamos la tabla con la siguiente estructura:
create table notas(
  nombre varchar2(30),
  nota number(4,2)
);

--3 Ingresamos algunos registros:
insert into notas values('Acosta Ana', 6.7);
insert into notas values('Bustos Brenda', 9.5);
insert into notas values('Caseros Carlos', 3.7);
insert into notas values('Dominguez Daniel', 2);
insert into notas values('Fuentes Federico', 8);
insert into notas values('Gonzalez Gaston', 7);
insert into notas values('Juarez Juana', 4);
insert into notas values('Lopez Luisa',5.3);

--4 
/*Creamos o reemplazamos la función "f_condicion" que recibe una nota y
retorna una cadena de caracteres indicando si aprueba o no:*/
create or replace function f_condicion (anota number)
  return varchar2
 is
  condicion varchar2(20);
 begin
   condicion:='';
   if anota<4 then
    condicion:='desaprobado';
   else 
    condicion:='aprobado';
   end if;
   return condicion;
 end;
 /
 
--5 
/*Realizamos un "select" sobre "notas" mostrando el nombre y nota del
alumno y en una columna su condición (empleando la función creada
anteriormente):*/
select nombre, nota, f_condicion(nota) from notas;

--6 
/*En el siguiente ejemplo omitimos la cláusula "else" porque sólo
indicaremos acciones en caso que el "if" sea verdadero:*/
create or replace function f_condicion (anota number)
  return varchar2
 is
  condicion varchar2(20);
 begin
   condicion:='aprobado';
   if anota<4 then
    condicion:='desaprobado';
   end if;
   return condicion;
 end;
 /

--7 
/*Realizamos el "select" sobre "notas" mostrando la misma información
que antes:*/
select nombre, nota, f_condicion(nota) from notas;

--8 
/*En el siguiente ejemplo colocamos un "if" dentro de otro "if". 
En el cuerpo de la función controlamos si la nota es menor a 4 
(retorna "desaprobado"), luego, dentro del "else", controlamos si 
la nota es menor a 8 (retorna "regular") y si no lo es ("else"), 
retorna "promocionado":*/

create or replace function f_condicion (anota number)
  return varchar2
 is
  condicion varchar2(20);
 begin
   condicion:='';
   if anota<4 then
     condicion:='desaprobado';
   else
     if anota<8 then
      condicion:='regular';
     else
      condicion:='promocionado';
     end if;
   end if;
   return condicion;
 end;
 /

--9 
/*Realizamos el "select" sobre "notas" mostrando la misma información 
que antes:*/
select nombre, nota, f_condicion(nota) from notas;

--10 
/*Simplificamos la función anteriormente creada empleando la sintaxis 
"if...elsif":*/
create or replace function f_condicion (anota number)
  return varchar2
 is
  condicion varchar2(20);
 begin
   condicion:='';
   if anota<4 then
     condicion:='desaprobado';
   elsif anota<8 then
     condicion:='regular';
   else
    condicion:='promocionado';
   end if;
   return condicion;
 end;
 /

--11 
/*Realizamos el "select" sobre "notas" mostrando la misma información
que antes:*/
select nombre, nota, f_condicion(nota) from notas;

/*Segundo Problema*/
--1 Elimine la tabla "productos":
drop table productos;

--2 Cree la tabla con la siguiente estructura:
create table productos(
  codigo number(5),
  precio number(6,2),
  stockminimo number(4),
  stockactual number(4)
 );

--3 Ingrese algunos registros:
insert into productos values(100,10,100,200);
insert into productos values(102,15,200,500);
insert into productos values(130,8,100,0);
insert into productos values(240,23,100,20);
insert into productos values(356,12,100,250);
insert into productos values(360,7,100,100);
insert into productos values(400,18,150,100);

--4 
/*Cree una función que reciba dos valores numéricos correspondientes 
a ambos stosks. Debe comparar ambos stocks y retornar una cadena de 
caracteres indicando el estado de cada producto, si stock actual es:*/
--* cero: "faltante",
--* menor al stock mínimo: "reponer",
--*igual o superior al stock mínimo: "normal".
create or replace function f_estado(aactual number,aminimo number)
  return varchar2
 is
  estado varchar2(20);
 begin
  estado:='normal';
   if aactual>=aminimo then
    estado:='normal';
   else
    if aactual=0 then estado:='faltante';
    else
      estado:='reponer';
    end if;
   end if;
   return estado;
 end;
 / 
 
--5 
/*Realice un "select" mostrando el código del producto, ambos stocks y, empleando
la función creada anteriormente, una columna que muestre el estado del producto*/
select codigo, stockactual, stockminimo, f_estado(stockactual,stockminimo) as estado from productos;

--6
/*Realice la misma función que en el punto 4, pero esta vez empleando en la 
estructura condicional la sintaxis "if... elsif...end if"*/
 create or replace function f_estado(aactual number,aminimo number)
  return varchar2
 is
  estado varchar2(20);
 begin
  estado:='normal';
   if aactual>=aminimo then
    estado:='normal';
   elsif
    aactual=0 then estado:='faltante';
   else
      estado:='reponer';
   end if;
   return estado;
 end;
 /

--7 
/*Realice un "select" mostrando el código del producto, ambos stocks y, empleando
la función creada anteriormente, una columna que muestre el estado del producto*/
select codigo, stockactual, stockminimo, f_estado(stockactual,stockminimo) as estado from productos;

--8 
/*Realice una función similar a las anteriores, pero esta vez, si el estado es 
"reponer" o "faltante", debe especificar la cantidad necesaria (valor necesario 
para llegar al stock mínimo)*/
create or replace function f_estado(aactual number,aminimo number)
  return varchar2
 is
  estado varchar2(20);
 begin
  estado:='normal';
   if aactual>=aminimo then
    estado:='normal';
   elsif
    aactual=0 then estado:='faltante '||to_char(aminimo);
   else
      estado:='reponer '||to_char(aminimo-aactual);
   end if;
   return estado;
 end;
 /
 
--9 
/*Realice un "select" mostrando el código del producto, ambos stocks y, empleando
la función creada anteriormente, una columna que muestre el estado del producto*/
select codigo, stockactual, stockminimo, 
f_estado(stockactual,stockminimo) as estado from productos;