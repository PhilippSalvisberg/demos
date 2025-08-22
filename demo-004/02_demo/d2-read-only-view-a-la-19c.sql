create or replace view dept_v as
select json_object(
          deptno,
          dname,
          loc,
          ext,
          'sal': (select sum(sal) from emp where emp.deptno = dept.deptno)
          absent on null
       ) as data
  from dept;

select * from dept_v;
