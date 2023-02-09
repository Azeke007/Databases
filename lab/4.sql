-- 1 - section
-- a)
select *
from course
where dept_name = 'Biology'
  and credits > 3;

-- b)
select *
from classroom
where building in ('Watson', 'Painter');

-- c)
select *
from course
where dept_name = 'Comp. Sci.';

-- d)
select *
from course
where course_id in (select section.course_id
                    from section
                    where semester = 'Spring');

-- e)
select *
from student
where tot_cred > 45
  and tot_cred < 85;

-- f)
select *
from course
where right(title, 1) in ('a', 'e', 'i', 'y', 'u', 'o');

-- g)
select *
from course
where course_id in (select prereq.course_id
                    from prereq
                    where prereq_id = 'EE-181');

-- 2 - section
-- a)
select dept_name, avg(salary)
from instructor
group by (dept_name)
order by avg;

-- b)
select building
from department
where dept_name = (select dept_name
                   from course
                   GROUP BY (course.dept_name)
                   order by count(*) desc
                   limit 1);

-- c)
select *
from department
where dept_name = (select dept_name
                   from course
                   GROUP BY (course.dept_name)
                   order by count(*)
                   limit 1);

-- d)
select *
from student
where id in (select id
             from takes
             where left(course_id, 2) = 'CS'
             group by (id)
             having count(*) > 3);

-- e)
select *
from instructor
where dept_name in (select dept_name
                    from department
                    where building = 'Taylor');

-- f)
select *
from instructor
where dept_name in ('Biology', 'Philosophy', 'Music')

-- g)
select *
from instructor
where id in (select id
             from teaches t
             where id not in (select id
                              from teaches
                              where year = 2017)
               and t.year = 2018);


-- 3 - section
-- a)
select *
from student
where id in (select distinct id
             from takes
             where grade in ('A', 'A-'))
order by name;

-- b)
select *
from advisor
where s_id in (select distinct id
               from takes
               where grade in ('B+', 'A-', 'A'));

-- c)
select *
from department
where dept_name not in
      (select dept_name from course where course_id in (select course_id from takes where grade in ('F', 'C')));
