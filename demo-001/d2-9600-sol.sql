-- @plscope

select /*+ leading(e d) */ *
  from emp e
  join dept d on d.deptno = e.deptno;
select * from dbms_xplan.display_cursor(format => 'basic +hint_report');
