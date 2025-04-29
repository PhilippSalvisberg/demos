-- @plscope

set serveroutput on size unlimited
declare
   procedure increase_sal(in_percent in integer,
                          in_empno   in emp.empno%type) is
   begin
      update emp
         set sal = sal + sal * in_percent / 100
       where empno = in_empno;
   end increase_sal;
begin
   increase_sal(in_percent => 2000, in_empno => 7839);
exception
   when no_data_found then
      null;
   when others then
      sys.dbms_output.put_line('Error: ' || sqlerrm || ' - Backtrace: ' || sys.dbms_utility.format_error_backtrace);
end;
/