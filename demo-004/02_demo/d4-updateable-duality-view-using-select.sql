create or replace json duality view dept_dv as
select json {
          '_id': deptno,
          dname,
          loc,
          ext as flex,
          'emps':
             (
                select json_arrayagg(
                          JSON {
                             emp.empno,
                             emp.ename,
                             emp.job,
                             unnest
                                (
                                   select json {
                                             'mgr'    : mgr.empno with nocheck,
                                             'mgrname': mgr.ename with nocheck
                                          }
                                     from emp mgr
                                    where mgr.empno = emp.mgr
                                ),
                             emp.hiredate,
                             emp.sal,
                             emp.comm,
                             ext as flex
                          }
                       )
                  from emp with insert update delete
                 where emp.deptno = dept.deptno
             )
       }
  from dept with insert update delete;

select json_serialize(data returning clob pretty) as data
  from dept_dv dv
 where dv.data."_id".numberOnly() in (20, 40);