-- @plscope

-- < 12.1
select e.*,
       rownum as rank
  from (
          select ename,
                 sal,
                 hiredate
            from emp
           order by sal desc
       ) e
 where rownum <= 2;