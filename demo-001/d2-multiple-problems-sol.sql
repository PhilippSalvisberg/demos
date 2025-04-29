-- @plscope

with
   function slow_function return integer deterministic is
   begin
      sys.dbms_session.sleep(0.2);
      return null;
   end slow_function;
select ename,
       coalesce(mgr, slow_function()) as mgr,
       coalesce(mgr, slow_function()) as mgr2,
       coalesce(mgr, slow_function()) as mgr3,
       coalesce(mgr, slow_function()) as mgr4
  from emp;

select ename
  from emp
 where job = 'SALESMAN'
   and (comm is null or sal is not null);
