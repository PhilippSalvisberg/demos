delete dept_dv v
 where v.data."_id".numberOnly() = 50;
commit;

select * from dept order by deptno;
select * from emp order by deptno, empno;
select json_serialize(data returning clob pretty) as data
  from dept_dv v
 order by v.data.deptno.number();
