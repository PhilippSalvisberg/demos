update dept_dv v
   set v.data = json_transform(
                   v.data,
                   set '$.street' = '85 Albert Embankment',
                   nested '$.emps[*]' (
                      set '@.sal' = path '@.sal * 42'
                   ),
                   nested '$.emps[*]?(@.ename == "BOND")' (
                      set '@.sal' = path '@.sal + 1',
                      append '@.tools' = 'Aston Martin DB5'
                   )
                )
 where v.data."_id".numberOnly() = 50;
commit;

set pagesize 1000
set long 5000
select * from dept where deptno = 50;
select * from emp where deptno = 50;
select json_serialize(data returning clob pretty) as data
  from dept_dv v
 where v.data."_id".numberOnly() = 50;
