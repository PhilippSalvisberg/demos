-- @plscope

select job,
       case job
          when 'ANALYST' then
             3200
          when 'CLERK' then
             1500
          when 'MANAGER' then
             4000
          when 'MANAGER' then
             9000
          when 'SALESMAN' then
             2000
       end as max_sal
  from (select distinct job as job from emp) jobs;