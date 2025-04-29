-- @hr

set serveroutput on size unlimited
declare
   l_sequence_number employees.employee_id%type;
begin
   l_sequence_number := employees_seq.nextval;
   dbms_output.put_line('next value is: ' || l_sequence_number);
end;
/