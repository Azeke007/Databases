--1
create database assignment_6;
--2
create table locations(
    location_id serial primary key,
    street_address varchar(250),
    postal_code varchar(12),
    city varchar(30),
    state_province varchar(12)
);

create table departments(
    department_id serial primary key,
    department_name varchar(50) unique,
    budget integer,
    location_id integer references locations
);

create table employees(
    employee_id serial primary key,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(50),
    phone_number varchar(20),
    salary integer,
    department_id integer references departments
);
--3
INSERT INTO locations(location_id, street_address, postal_code, city, state_province) VALUES(1, 'Nazarbaev', 'RT56', 'Almaty', 'Alma-Ata');
INSERT INTO locations(location_id, street_address, postal_code, city, state_province) VALUES(2, 'Konaev', 'QS87', 'Shu', 'Zhambyl');
INSERT INTO locations(location_id, street_address, postal_code, city, state_province) VALUES(3, 'Abilaykhan', 'FX41', 'Shimkent', 'OKO');
INSERT INTO locations(location_id, street_address, postal_code, city, state_province) VALUES(4, 'Mailin', 'OP63', 'Aqtobe', 'BKO');
INSERT INTO locations(location_id, street_address, postal_code, city, state_province) VALUES(5, 'Tolebi', 'VL95', 'Almaty', 'Alma-Ata');

INSERT INTO departments(department_id, department_name, budget, location_id) VALUES(30, 'ITU', 70000, 1);
INSERT INTO departments(department_id, department_name, budget, location_id) VALUES(50, 'SDU', 50000, 2);
INSERT INTO departments(department_id, department_name, budget, location_id) VALUES(60, 'ATU', 20000, 3);
INSERT INTO departments(department_id, department_name, budget, location_id) VALUES(70, 'ETU', 15000, 4);
INSERT INTO departments(department_id, department_name, budget, location_id) VALUES(80, 'ENU', 25000, 5);

INSERT INTO employees(employee_id, first_name, last_name, email, phone_number, salary, department_id) VALUES(510, 'Bek', 'Kalybaev', 'd_kalybaev@kbtu.kz', '87070063278', 1500, 30);
INSERT INTO employees(employee_id, first_name, last_name, email, phone_number, salary, department_id) VALUES(511, 'Azizbek', 'Kambar', 'az_kambar@kbtu.kz', '87074572358', 1400, 50);
INSERT INTO employees(employee_id, first_name, last_name, email, phone_number, salary, department_id) VALUES(512, 'Doszhan', 'Shamsharov', 'd_shamsharov@kbtu.kz', '87773514967', 1300, 60);
INSERT INTO employees(employee_id, first_name, last_name, email, phone_number, salary, department_id) VALUES(513, 'Shyngys', 'Shamsuddin', 'r_shamsuddin@kbtu.kz', '87074452616', 1300, 70);
INSERT INTO employees(employee_id, first_name, last_name, email, phone_number, salary, department_id) VALUES(514, 'Nurlan', 'Abilda', 'n_abilda@kbtu.kz', '87021235846', 1300, 80);

--4
select e.first_name, e.last_name, e.department_id, d.department_name from employees e
join departments d
on e.department_id = d.department_id;

--5
select e.first_name, e.last_name, e.department_id, d.department_name from employees e
join departments d
on e.department_id = d.department_id
where e.department_id = 80 or e.department_id = 30;

--6
select e.first_name, e.last_name, d.department_id, d.department_name, l.city, l.state_province from employees e
join departments d on e.department_id = d.department_id
    join locations l on d.location_id = l.location_id;

--7
select
     d.department_id,
     d.department_name,
     d.budget,
     d.location_id
from departments d left join locations l on d.location_id = l.location_id;

--8
select e.first_name, e.last_name, d.department_id, d.department_name from employees e
join departments d on e.department_id = d.department_id ;

--9
select e.last_name, e.first_name from employees e
right join departments d on e.department_id = d.department_id
right join locations l on d.location_id = l.location_id
where l.city = 'Moscow';