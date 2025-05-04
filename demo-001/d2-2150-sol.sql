-- @plscope

set serveroutput on
begin
   <<print_emps_without_comm>>
   for r in (select ename from emp where job = 'SALESMAN' and comm is null)
   loop
      sys.dbms_output.put_line(r.ename || ' has no commission');
   end loop print_emps_without_comm;
end;
/

declare
begin
   <<print_emps_without_comm>>
   for r in (select ename from emp where job = 'SALESMAN' and l_comm is null)
   loop
      sys.dbms_output.put_line(r.ename || ' has no commission');
   end loop print_emps_without_comm;
end;
/
