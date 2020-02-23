-- creando tablas
CREATE TABLE `dev`.`users` (
  `id_users` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `password` VARCHAR(100) NULL,
  `creaded_at` DATE NULL,
  PRIMARY KEY (`id_users`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC));

-- mostrar base de datos
show databases;

-- usar schema o base de datos
use dev;

-- mostrar rablas
show tables;

create database test;

use test;

create table ejemplo(
id int
);

drop table ejemplo;

drop database test;


select * from users;

select first_name from users;

select email from users;

select id_users,first_name,email 
from users
where id_users = 2;



insert into users(first_name,last_name,email,password,creaded_at)
values('maria','gonzales','maria@hotmail.com',md5('123'),now());

insert into users(first_name,last_name,email,password,creaded_at)
values('rodrigo','chacin','rodrigo@hotmail.com',md5('1234'),now()),
('karla','pacheco','karla@hotmail.com',md5('12345'),now());


update users set creaded_at = now()
where id_users < 3;

update users set password = md5('123')
where id_users = 1;

update users set password = md5('123')
where id_users = 2;


delete from users
where id_users = 6;

delete from users
where id_users = 5 and first_name = 'carla';

delete from users
where id_users = 5 and first_name = 'rodrigo';


select id_users,first_name,last_name,email
from users
where id_users = 1 and email = 'admin@hotmail.com';

select id_users,first_name,last_name,email
from users
where id_users = 8 or email = 'maria@hotmail.com';


update users set creaded_at = '2008-01-10'
where id_users = 1;

update users set creaded_at = '2009-01-10'
where id_users = 2;

select id_users,first_name,last_name,email,creaded_at
from users
where creaded_at
between '2001-01-10' and '2030-01-10';  



create table clients(
id int(10) auto_increment not null primary key,
name varchar(45),
adress varchar(45),
city char(10),
state char(10),
zipcode int(10),
phone varchar(45)
);


select * from clients;

alter table clients add column test int(10) after phone;

alter table clients drop column test;

insert into clients (name,adress,city,state,zipcode,phone)
values ('jose','st josix','mx','mx',2020,'1234567');

insert into clients (name,adress,city,state,zipcode,phone)
values ('carla','st poryx','al','ml',1020,'2224267'),
('pedro','st jalyx','ve','cc',4020,'3244566');




select name as ncompleto,adress as direccion,city as ciudad,state as estado,zipcode as codigo
from clients;

select name as ncompleto,adress as direccion,city as ciudad,state as estado,zipcode as codigo
from clients
order by codigo asc;

select name as ncompleto,adress as direccion,city as ciudad,state as estado,zipcode as codigo
from clients
order by codigo desc;


select name,adress,city,state
from clients
where city
like 'mx';

select name,adress,city,state
from clients
where city
not like 'mx';

select name,adress,city,state
from clients
where city
not like 'mx'
limit 0,1;
