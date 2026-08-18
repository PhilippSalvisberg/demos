select emp.employee_id
      ,emp.last_name
      ,emp.first_name
      ,dept.department_name
  from employees emp
      ,departments dept
 where emp.department_id = dept.department_id
   and extract(month from emp.hire_date) = extract(month from sysdate);