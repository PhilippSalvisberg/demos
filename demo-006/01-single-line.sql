-- requires a maxLineSize of 128

select e.empno, e.ename, e.job from emp e where e.deptno in (select d.deptno from dept d where d.loc in ('DALLAS', 'CHICAGO'));
