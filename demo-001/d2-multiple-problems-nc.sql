-- @plscope

with
   function slow_function return integer is
   begin
      sys.dbms_session.sleep(0.2);
      return null;
   end slow_function;
select ename,
       nvl(mgr, slow_function()) as mgr,
       nvl(mgr, slow_function()) as mgr2,
       nvl(mgr, slow_function()) as mgr3,
       nvl(mgr, slow_function()) as mgr4
  from emp;

select ename
  from emp
 where job = 'SALESMAN'
   and Job='SALESMAN'
   and (comm = null or null != sal);
