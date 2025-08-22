set linesize 200
set pagesize 1000
set long 32767
column ext format a72
column data format a130
alter session set nls_date_format = 'YYYY-MM-DD';

drop table if exists emp;
drop table if exists dept;

create table dept (
   deptno number(2, 0)      not null constraint dept_pk primary key,
   dname  varchar2(14 char) not null,
   loc    varchar2(13 char) not null,
   ext    json(object)
);

create table emp (
   empno    number(4, 0)      not null  constraint emp_pk primary key,
   ename    varchar2(10 char) not null,
   job      varchar2(9 char)  not null,
   mgr      number(4, 0)                constraint emp_mgr_fk references emp,
   hiredate date              not null,
   sal      number(7, 2)      not null,
   comm     number(7, 2),
   deptno   number(2, 0)      not null  constraint emp_deptno_fk references dept,
   ext      json(object)
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

begin
   sys.dbms_stats.gather_table_stats(user, 'EMP', cascade => true);
   sys.dbms_stats.gather_table_stats(user, 'DEPT', cascade => true);
end;
/