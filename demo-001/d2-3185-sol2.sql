-- @plscope

-- >= 12.1
select ename,
       sal,
       hiredate,
       rank() over (order by sal desc) as rank
  from emp
 order by sal desc
fetch next 2 rows with ties;