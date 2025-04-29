-- @plscope

-- SQL condition
select ename
      ,sal
      ,hiredate
  from emp
 where sal > 2000
    or Sal>2000
 order by ename;

-- PL/SQL condition
declare
   l_var1 integer := 1;
   l_var2 integer := 2;
begin
   if l_var1 = l_var1 then
      sys.dbms_output.put_line('do something useful here');
   end if;
end;
/