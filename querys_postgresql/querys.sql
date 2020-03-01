
-- crear tabla
CREATE TABLE public.users
(
  id_user integer NOT NULL DEFAULT nextval('users_id_user_seq'::regclass),
  first_name character varying(50),
  last_name character varying(50),
  email character varying(50),
  password character varying(100),
  creaded_at date,
  CONSTRAINT pk_users PRIMARY KEY (id_user),
  CONSTRAINT uq_email UNIQUE (email)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.users
  OWNER TO postgres;



-- seleccionar todo
select * from users;

select id_user,first_name
from users;

-- seleccionar con condiciones
select id_user,first_name,email
from users
where id_user = 1;

select id_user,first_name,email
from users
where id_user = 2;


select id_user as identificador,last_name as apellido,email as correo
from users
where id_user < 2;

delete from users
where id_user = 3;



select id_user as identificador,last_name as apellido,email as correo
from users
where id_user < 2;

delete from users
where id_user = 3;

insert into users (first_name,last_name,email,password,creaded_at)
values ('jose','martinez','jose@hotmail.com',md5('123'),now());

insert into users (first_name,last_name,email,password,creaded_at)
values ('john','smith','john@hotmail.com',md5('1234'),now()),
('jairo','montoya','jairo@hotmail.com',md5('12345'),now());


update users set password = md5('123')
where id_user < 3;

update users set first_name = 'martin',last_name = 'azabache' 
where id_user = 6;




create table price(
id serial not null primary key,
price decimal check(price < 100),
cost integer unique
);

alter table price
add column test char(100);

select * from price;

insert into price
values (10,20);

insert into price (price,cost)
values (70,50);

alter table price create index nnull to test;

alter table price
alter column test set not null;

update price set test = 'actualizar'
where id < 11; 

alter table price
drop column test;


select id as idp,price as precio,cost as costo
from price;

select id as idp,price as precio,cost as costo
from price
where price
between 1 and 35;

select id as idp,price as precio,cost as costo
from price
where price
between 19 and 100;

select id as idp,price as precio,cost as costo
from price
where price
between 19 and 100
order by id desc;

select id as idp,price as precio,cost as costo
from price
where price
between 19 and 100
order by id asc;

select id as idp,price as precio,cost as costo
from price
where price
between 19 and 100
limit 1;



-- funcion de fechas
select now() as fecha;

select current_date as fecha;

select current_time as fecha;

/*
funcion uno
funcion dos
sdsdsd
*/

select current_timestamp as fecha;



-- normalizacion

create table personas(
id_persona integer,
nombre text,
edad integer
);

insert into personas
values (1,'jonathan',30);


insert into personas
values (1,'jonathan',20);

insert into personas
values (2,'jose',18);

insert into personas
values (2,'jose');

select * from personas;

-- 1FN
select * from personas
where id_persona = 1;

select * from personas
where id_persona = 2;


select * from personas;

select * from prueba;

create table personas(
id_persona integer,
nombre text,
edad integer
);

create table prueba(
id_prueba integer,
nombre text
);

insert into prueba
values (1,'asas'),
(1,'algo');

drop table prueba;

truncate table personas;








create table dev.users(
id_user integer,
img character varying(50),
first_name character varying(50),
last_name character varying(50),
email character varying(50),
password character varying(100),
id_role integer,
id_country integer,
id_state integer,
creadet_at date,
updated_at date,
last_access character varying(50),
constraint pk_users primary key(id_user),
constraint uq_email unique(email)

);


create table dev.roles(
id_role integer,
role character varying(50),
constraint pk_roles primary key(id_role)
);

create table dev.countrys(
id_country integer,
country character varying(50),
constraint pk_countrys primary key(id_country)
);


alter table dev.users
add constraint fk_role
foreign key(id_role) references dev.roles(id_role); 






select * from users;

alter table users
add column price int;


alter table users
add column quantity int;


alter table users
rename column password to total;


update users set price = 10
where id_user < 2;

update users set price = 30
where id_user = 2;

update users set quantity = 75
where id_user > 1;

select * from users;

select id_user,email,price
from users
where price IS NULL;

select id_user,price,quantity,price*quantity as totaloperacion
from users;

select id_user,price,quantity,price+quantity as totaloperacion
from users;

select id_user,price,quantity,price-quantity as totaloperacion
from users;

select id_user,price,quantity,price/quantity as totaloperacion
from users;


select id_user,price,quantity,price+quantity
from users;

select * from users;

update users set quantity = 20
where quantity IS NULL;

update users set price = 20
where price IS NULL;



select id_user,email,concat(first_name,':',last_name) as "concatenacion"
from users
where id_user = 7;



-- conectar por consola con el comando psql
psql -h localhost -U postgres -d postgres

-- cerrar conexion
\q

-- listar base de datos
\l

-- listar tablas en las base de datos
\d

-- usar una base de datos
\c 

-- ir atras en los comandos
q

-- operador de cadenas igual
select * from users where last_name like 'castro';

-- operador no igual
select * from users where last_name not like 'castro';

-- inner join

SELECT a.first_name,
a.last_name,
a.email,
a.createt_at,
b.role,
c.country,
d.state
FROM dev.users a
JOIN dev.roles b ON a.id_role = b.id_role
JOIN dev.countrys c ON a.id_country = c.id_country
JOIN dev.states d ON a.id_state = d.id_state
ORDER BY a.first_name;

  -- vistas

  CREATE OR REPLACE VIEW dev.view_join AS 
  SELECT a.first_name,
  a.last_name,
  a.email,
  a.createt_at,
  b.role,
  c.country,
  d.state
  FROM dev.users a
  JOIN dev.roles b ON a.id_role = b.id_role
  JOIN dev.countrys c ON a.id_country = c.id_country
  JOIN dev.states d ON a.id_state = d.id_state
  ORDER BY a.first_name;

  ALTER TABLE dev.view_join
  OWNER TO postgres;

-- right join

SELECT a.first_name,
a.last_name,
a.email,
a.createt_at,
b.role,
c.country,
d.state
FROM dev.users a
right JOIN dev.roles b ON a.id_role = b.id_role
right JOIN dev.countrys c ON a.id_country = c.id_country
right JOIN dev.states d ON a.id_state = d.id_state;


-- left join
SELECT a.first_name,
a.last_name,
a.email,
a.createt_at,
b.role,
c.country,
d.state
FROM dev.users a
left JOIN dev.roles b ON a.id_role = b.id_role
left JOIN dev.countrys c ON a.id_country = c.id_country
left JOIN dev.states d ON a.id_state = d.id_state;


-- creamos la funcion con 2 parametros
CREATE FUNCTION agregar(integer, integer) RETURNS integer
AS 'select $1 + $2;'
LANGUAGE SQL
IMMUTABLE
RETURNS NULL ON NULL INPUT;
-- llamamos a la funcion
select agregar(2,4);
-- eliminamos la funcion
drop function agregar(integer,integer); 

-- creamos la funcion con 2 parametros
CREATE OR REPLACE FUNCTION incrementar(i integer) RETURNS integer AS $$
BEGIN
RETURN i + 1;
END;
$$ LANGUAGE plpgsql;
-- llamamos a la funcion
select incrementar(100);
-- eliminamos la funcion
drop function incrementar(integer);


-- stored procedure con void no retorna un tipo de datos
CREATE OR REPLACE FUNCTION agregaruser(col1 text,col2 text,col3 text) RETURNS void AS $$
BEGIN

insert into users (first_name,last_name,email,password,creaded_at)
    values(col1,col2,col3,md5('123'),now());

END;
$$ LANGUAGE plpgsql;
-- llamamos a la funcion
select agregaruser('ramon','canseco','ramon@hotmail.com');


--concatenacion
select first_name,price,quantity, concat(first_name,' + ',last_name) "resultado"
from users where id_user = 1;

-- mas updates con condiciones
update users set price = '4'
where id_user < 3;

update users set quantity = '4'
where id_user > 1;

update users set quantity = '5'
where id_user = 1;

-- mas operaciones
alter table users add column prices integer;

alter table users rename column prices to total;

update users set total = 10
where total is null;

select email,quantity*total as totalmax
from users;


-- donde es nulo
select id_user,first_name
from users
where price IS NULL;

-- contar
select count(*) as total
from users
where id_user < 4;

-- eliminar tablas
alter table users drop column price;



-- prueba triggers
select * from users;

select * from roles;

alter table users add column id_role integer;

create table roles(
id_role serial,
role char
);


CREATE  TRIGGER crear AFTER insert on users
ON table_name
[
 EXECUTE PROCEDURE actualizar();
];

CREATE OR REPLACE FUNCTION actualizar() RETURNS TRIGGER AS $crear$
   BEGIN
      INSERT INTO AUDIT(EMP_ID, ENTRY_DATE) VALUES (new.ID, current_timestamp);
      insert into roles (first_name,last_name,email,password,creaded_at)
    values('john','ramirez','john@gmail.com',md5('123'),now());
      RETURN NEW;
   END;
$example_table$ LANGUAGE plpgsql;



-- ejercicio completo de trigger

create table countrys(
id_country serial,
country char(30),
constraint pk_countrys primary key(id_country)
);

create table states(
id_state serial,
state char(30),
id_country integer,
constraint pk_state primary key(id_state),
constraint fk_countrys foreign key(id_country)
REFERENCES countrys (id_country) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
);


select * from countrys;


select * from states;

insert into countrys (id_country,country)
    values(1,'mexico');

    insert into countrys (id_country,country)
    values(2,'test');


-- despues se crea el disparador
CREATE TRIGGER insertarpaises
    AFTER INSERT ON countrys
    FOR EACH ROW
    EXECUTE PROCEDURE insertarestados();


-- primero se crea la funcion procedure
    CREATE OR REPLACE FUNCTION insertarestados() RETURNS trigger AS $insertarpaises$
BEGIN

insert into states (state,id_country)
    values('mexico df',new.id_country);
    return new;

END;
$insertarpaises$ LANGUAGE plpgsql;





select datname from pg_database;

select version();

create database db_gis;

CREATE EXTENSION postgis;

select postgis_full_version();
