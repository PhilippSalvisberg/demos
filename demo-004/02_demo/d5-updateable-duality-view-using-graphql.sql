create or replace json duality view dept_dv as
dept @insert @update @delete
{
   _id: deptno
   dname
   loc
   ext @flex
   emps: emp @insert @update @delete
      {
         empno
         ename
         job
         emp @unnest @link(from: [mgr])
            {
               mgr    : empno @nocheck
               mgrname: ename @nocheck
            }
         hiredate
         sal
         comm
         ext @flex
      }
};

select json_serialize(data returning clob pretty) as data
  from dept_dv dv
 where dv.data."_id".numberOnly() in (20, 40);