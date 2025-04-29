-- @plscope

with
   function slow_function return integer deterministic is
   begin
      sys.dbms_session.sleep(0.2);
      return null;
   end slow_function;
select ename,
       coalesce(mgr, slow_function()) as mgr
  from emp;
