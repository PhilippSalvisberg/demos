insert into dept_dv (data) values ('
{
  "_id" : 50,
  "dname" : "MI6",
  "loc" : "LONDON",
  "secret" : true,
  "emps" :
  [
    {
      "empno" : 7,
      "ename" : "BOND",
      "job" : "AGENT",
      "mgr" : 1,
      "hiredate" : "1950-01-01T00:00:00",
      "sal" : 500,
      "tools" : ["Knife", "Garrote Watch", "Walther PPK"]
    },
    {
      "empno" : 1,
      "ename" : "M",
      "job" : "MANAGER",
      "hiredate" : "1940-01-01T00:00:00",
      "sal" : 1000,
      "comm" : 8000
    }
  ]
}
');
commit;

select * from dept where deptno = 50;
select * from emp where deptno = 50;
select json_serialize(data returning clob pretty) as data
  from dept_dv dv
 where dv.data.secret.booleanOnly();