prompt
prompt ================================================================================================================
prompt as SYS
prompt ================================================================================================================

alter session set current_schema = sys;

drop user if exists demo_app cascade;

create user demo_app
   identified by demo_app
   default tablespace users
   quota 100m on users;

grant db_developer_role to demo_app;

prompt
prompt ================================================================================================================
prompt as DEMO_APP
prompt ================================================================================================================

alter session set current_schema = demo_app;

drop table if exists emp purge;
drop table if exists dept purge;

create table dept (
   deptno number(2, 0)      not null constraint dept_pk primary key,
   dname  varchar2(14 char) not null,
   loc    varchar2(13 char) not null
);

create table emp (
   empno    number(4, 0)      not null  constraint emp_pk primary key,
   ename    varchar2(10 char) not null,
   job      varchar2(9 char)  not null,
   mgr      number(4, 0)                constraint emp_mgr_fk references emp,
   hiredate date              not null,
   sal      number(7, 2)      not null,
   comm     number(7, 2),
   deptno   number(2, 0)      not null  constraint emp_deptno_fk references dept
);

insert into dept (deptno, dname, loc)
values (10, 'ACCOUNTING', 'NEW YORK'),
       (20, 'RESEARCH',   'DALLAS'),
       (30, 'SALES',      'CHICAGO'),
       (40, 'OPERATIONS', 'BOSTON');
commit;

insert into emp (empno, ename, job, mgr, hiredate, sal, comm, deptno)
values (7566, 'JONES',  'MANAGER',   7839, date '1981-04-02', 2975, null, 20),
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
       (7839, 'KING',   'PRESIDENT', null, date '1981-11-17', 5000, null, 10),
       (7876, 'ADAMS',  'CLERK',     7788, date '1987-05-23', 1100, null, 20);
commit;

drop type if exists dept_ot force;

create or replace type dept_ot as object (
   deptno number(2, 0),
   dname  varchar2(14 char),
   loc    varchar2(13 char)
);
/

drop type if exists dept_ct force;

create or replace type dept_ct as table of dept_ot;
/
