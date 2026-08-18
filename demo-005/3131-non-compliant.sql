select *
  from emp join dept using (deptno);

select emp.employee_id
      ,emp.last_name
      ,emp.first_name
      ,dept.department_name
  from employees emp
  join departments dept
    on dept.department_id = emp.department_id
 where extract(month from emp.hire_date) = extract(month from sysdate);
