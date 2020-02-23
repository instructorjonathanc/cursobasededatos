-- tabla
CREATE TABLE public.users
(
  id_user integer NOT NULL DEFAULT nextval('users_id_user_seq'::regclass),
  first_name character varying(30),
  last_name character varying(30),
  email character varying(30),
  password character varying(100),
  creadet_at date,
  CONSTRAINT pk_users PRIMARY KEY (id_user),
  CONSTRAINT uq_email UNIQUE (email)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.users
  OWNER TO postgres;




-- seleccionar registros
select * from users;

select first_name from users;

select email from users where id_user=1;


select email from users where id_user=2;


select first_name as nombre from users;

-- comentarios de una linea y bloques

--select * from users;

/*
select first_name from users;

select email from users where id_user=1;
*/

-- insertar registros
insert into users (first_name,last_name,email,password,creaded_at)
    values('john','ramirez','john@gmail.com',md5('123'),now());

    insert into users (first_name,last_name,email,password,creaded_at)
        values('susan','pacheco','susan@gmail.com',md5('1234'),now()),
        ('jairo','bonilla','jairo@hotmail.com',md5('12345'),now());

-- eliminar registros
delete from users
    where id_user = 5;

-- eliminar con condiciones, se deben cumplir las 2 condiciones
delete from users
    where id_user = 4 and first_name = 'susan';

-- eliminar con condiciones, se debe cumplir 1 condicion
delete from users
    where id_user = 3 or first_name = 'jose';

-- actualizar registros
update users set email = 'user@hotmail.com'
    where email = 'juan@hotmail.com';

-- crear tablas
create table roles(
    id_role integer,
    role char

);

-- modificar tablas
alter table roles add column test char;

-- eliminar tablas
alter table users drop column test;

-- eliminar tablas
drop table roles;



-- crear indices
create unique index uq_id on test(id_test);

-- seleccionar entre rangos
select first_name as nombre, last_name as apellido
from users
where creaded_at
between '2010-01-10' and '2011-02-11';

-- modo ascendente
select first_name as nombre, last_name as apellido
from users
where creaded_at
between '2010-01-10' and '2011-02-11'
order by nombre asc;

-- modo descendiente
select first_name as nombre, last_name as apellido
from users
where creaded_at
between '2010-01-10' and '2011-02-11'
order by nombre desc;

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

-- listar todas las base de datos
SELECT datname FROM pg_database;

-- volver una base de datos normal a espacial
   CREATE EXTENSION postgis;

-- version de postgresl
SELECT version(); 

-- funcion por defecto de postgis
   SELECT postgis_full_version();
