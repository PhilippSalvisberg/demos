-- @plscope

select ename,
       sal,
       hiredate,
       rownum as rank
  from emp
 where rownum <= 2
 order by sal desc;