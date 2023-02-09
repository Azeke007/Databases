--1
--a
create function f1(val integer) returns integer as $$
    begin
    return val + 1;
        end; $$
language plpgsql;
--b
create function f2(val integer) returns integer as $$
    begin
    val := val * val * val;
    return val;
        end; $$
language plpgsql;
--c
create function f3(a integer, b integer) returns integer as $$
    begin
    return a + b;
        end; $$
language plpgsql;
--d
create or replace function f4(a int) returns bool as $$
    begin
        return (a % 2 = 0);
        END; $$
    language plpgsql;
--e
create function f5(variadic list numeric[],
 out average numeric)
as $$
begin
 select into average avg(list[i])
 FROM generate_subscripts(list, 1) g(i);

END; $$
LANGUAGE plpgsql;
--f
create function f6(variadic list numeric[],
 out cnt numeric)
as $$
begin
 select into cnt count(list[i])
 FROM generate_subscripts(list, 1) g(i);

END; $$
LANGUAGE plpgsql;
--g
create function f7(s varchar) returns bool as $$
    begin
        return (s = 'password');
        end; $$
    language plpgsql;
--h
create or replace function f8(a int, out b bool, out c bool) as $$
    begin
        b := a % 3 = 0;
        c := a % 4 = 0;
        END; $$
    language plpgsql;

--2
--a
create function cur() return trigger as $$
    begin
    raise notice '%', now();
    return new;
end;
$$
language plpgsql;

create trigger cur_t before insert on table_1 for each row  excute procedure current();
--b
create function age() return trigger as $$
    begin
         raise notice '%', age(now(), new.t);
         return new;
    end; $$
language plpgsql;

create trigger age_t before insert on table_2 for each row execute procedure age();
--c
create function adds() return trigger as $$
    begin
         new.cost = new.cost * 1.12;
         return new;
    end; $$
language plpgsql;

create trigger adds_t before  insert on table_3 for each row execute procedure adds();
--d
create function stop_deletion() return trigger as $$
    begin
         raise exception "Deletion is not allowed";
    end; $$
language plpgsql;

create trigger stop_d before delete on table_4 execute procedure stop_deletion();
--e
create function launches_another() return trigger as $$
    begin
         raise notice '%', check_password(new.s);
         raise notice '%', calculator(new.a);
    end; $$
language plpgsql;

create trigger launches_t before insert on table_5 for each row execute procedure launchess_another();

create table work(id int, name varchar, date_of_birth date, age int, inout salary numeric, workexpirence int, out discount numeric);

--3
-- a
create function
    a(id int, name varchar, date_of_birth date, age int, inout salary numeric, workexperience int, out discount numeric) as
$$
declare
    count int;
begin
    discount = 10;
    count = workexperience/2;
    for step in 1..count loop
        salary = salary * 1.1;
    end loop;
    count = workexperience/5;
    for step in 1..count loop
        discount = discount * 1.01;
    end loop;
    insert into work values(id, name, date_of_birth, age, salary, workexperience, discount);
end;
$$
language plpgsql;

select * from a(1, 'a', '2000-03-02', 22, 1000, 10);
--b
create or replace function
    b(id int, name varchar, date_of_birth date, age int, inout salary numeric, workexperience int, out discount numeric) as
$$
declare
    count int;
begin
    if age >= 40 then salary = salary * 1.15;
    end if;
    discount = 10;
    count = workexperience/2;
    for step in 1..count loop
        salary = salary * 1.1;
    end loop;
    count = workexperience/5;
    for step in 1..count loop
        discount = discount * 1.01;
    end loop;
    if workexperience > 8 then salary = salary * 1.15;
    end if;
    if workexperience > 8 then discount = 20;
    end if;
    insert into work values(id, name, date_of_birth, age, salary, workexperience, discount);
end;
$$
language plpgsql;

select * from b(2, 'b', '2000-03-02', 44, 1000, 10);