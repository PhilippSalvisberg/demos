-- @hr

set serveroutput on size unlimited
declare
   l_sequence_number employees.employee_id%type;
begin
   select employees_seq.nextval
     into l_sequence_number
     from dual;
   dbms_output.put_line('next value is: ' || l_sequence_number);
end;
/