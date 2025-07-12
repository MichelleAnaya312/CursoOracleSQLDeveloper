/*Primer Problema*/
drop sequence sec_codigolibros;

create sequence sec_codigolibros
  start with 1
  increment by 1
  maxvalue 99999
  minvalue 1;

drop table libros;

 create table libros(
  codigo number(5) not null,
  titulo varchar2(40) not null,
  autor varchar2(30),
  editorial varchar2(20),
  primary key(codigo)
 );

insert into libros values
(sec_codigolibros.nextval,'El aleph', 'Borges','Emece');

insert into libros values
(sec_codigolibros.nextval,'Matematica estas ahi', 'Paenza','Nuevo siglo');

insert into libros values
(sec_codigolibros.nextval,'libro 3', 'EMECE','Nuevo siglo');

insert into libros values
(sec_codigolibros.nextval,'libro 4', 'PAENZA','Nuevo imperio');

select * from libros;

select sec_codigolibros.currval from dual;

select sec_codigolibros.nextval from dual;

insert into libros values
(sec_codigolibros.nextval,'libro 5', 'YYYY','Nuevo imperio5');
select sec_codigolibros.currval from dual;
