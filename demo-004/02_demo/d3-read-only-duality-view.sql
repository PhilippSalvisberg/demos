-- first trial
create or replace json duality view dept_dv as
select json_object(
          deptno,
          dname,
          loc,
          ext,
          'sal': (select sum(sal) from emp where emp.deptno = dept.deptno)
          absent on null
       ) as data
  from dept;

-- second trial (after removing `absent on null`)
create or replace json duality view dept_dv as
select json_object(
          deptno,
          dname,
          loc,
          ext,
          'sal': (select sum(sal) from emp where emp.deptno = dept.deptno)
       ) as data
  from dept;

-- third trial (after removing `sal`)
create or replace json duality view dept_dv as
select json_object(
          deptno,
          dname,
          loc,
          ext
       ) as data
  from dept;

-- forth trial (after removing column alias `data`)
create or replace json duality view dept_dv as
select json_object(
          deptno,
          dname,
          loc,
          ext
       )
  from dept;

-- fith trial (after adding `_id` column)
create or replace json duality view dept_dv as
select json_object(
          '_id': deptno,
          dname,
          loc,
          ext
       )
  from dept;

select * from dept_dv;
