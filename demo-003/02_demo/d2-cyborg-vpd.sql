-- @cyborg
-- 23.8
-- Cyborg - Virtual Private Database

drop table if exists emp purge;

create table if not exists emp as select * from (values
          (7839, 'KING',   'PRESIDENT', null, date '1981-11-17', 5000, null, 10),
          (7566, 'JONES',  'MANAGER',   7839, date '1981-04-02', 2975, null, 20),
          (7698, 'BLAKE',  'MANAGER',   7839, date '1981-05-01', 2850, null, 30),
          (7782, 'CLARK',  'MANAGER',   7839, date '1981-06-09', 2450, null, 10),
          (7788, 'SCOTT',  'ANALYST',   7566, date '1987-04-19', 3000, null, 20),
          (7902, 'FORD',   'ANALYST',   7566, date '1981-12-03', 3000, null, 20),
          (7499, 'ALLEN',  'SALESMAN',  7698, date '1981-02-20', 1600,  300, 30),
          (7521, 'WARD',   'SALESMAN',  7698, date '1981-02-22', 1250,  500, 30),
          (7654, 'MARTIN', 'SALESMAN',  7698, date '1981-09-28', 1250, 1400, 30),
          (7844, 'TURNER', 'SALESMAN',  7698, date '1981-09-08', 1500,    0, 30),
          (7900, 'JAMES',  'CLERK',     7698, date '1981-12-03',  950, null, 30),
          (7934, 'MILLER', 'CLERK',     7782, date '1982-01-23', 1300, null, 10),
          (7369, 'SMITH',  'CLERK',     7902, date '1980-12-17',  800, null, 20),
          (7876, 'ADAMS',  'CLERK',     7788, date '1987-05-23', 1100, null, 20)
       ) s (empno, ename, job, mgr, hiredate, sal, comm, deptno);

select * from emp;

create or replace function emp_predicate(
   in_schema in varchar2,
   in_table  in varchar2
) return varchar2 is
   l_predicate varchar2(1000 char);
begin
   if user = 'CYBORG' THEN
      l_predicate := q'[job not in ('MANAGER', 'PRESIDENT')]';
   end if;
   return l_predicate;
end;
/

declare
   e_policy_exist exception;
   pragma exception_init(e_policy_exist, -28101);
begin
   sys.dbms_rls.add_policy(
      object_name       => 'emp',
      policy_name       => 'emp_policy',
      policy_function   => 'emp_predicate',
      statement_types   => 'select insert update delete',
      sec_relevant_cols => 'sal comm',
      update_check      => true
   );
exception
   when e_policy_exist then
      null;
end;
/

select * from user_policies;

select empno, ename, job, mgr, hiredate, deptno from emp;
select * from dbms_xplan.display_cursor();

select * from emp;
select * from dbms_xplan.display_cursor();

select count(*) from emp;
select count(1) from emp;
select count(empno) from emp;

insert into emp(empno, ename, sal, deptno) values (1000, 'JOE', 1000, 10);

insert into emp(empno, ename, deptno) values (1000, 'JOE', 10);
rollback;

delete emp;
rollback;

update emp set sal = sal + 100;
rollback;

merge into emp t
   using emp s
      on (s.empno = t.empno)
   when matched then
      update set t.sal = s.sal + 100;
select * from dbms_xplan.display_cursor();
rollback;

-- --------------------------------------------------------------------------
-- cleanup (part of demo)
-- --------------------------------------------------------------------------

drop function if exists emp_predicate;

declare
   e_policy_not_exist exception;
   pragma exception_init(e_policy_not_exist, -28102);
begin
   sys.dbms_rls.drop_policy(
      object_name  => 'emp',
      policy_name  => 'emp_policy'
   );
exception
   when e_policy_not_exist then
      null;
end;
/

select * from emp;

drop table if exists emp purge;
