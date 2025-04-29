-- @plscope

with
   function slow_function return integer is
   begin
      sys.dbms_session.sleep(0.2);
      return null;
   end slow_function;
select ename,
       nvl(mgr, slow_function()) as mgr
  from emp;
