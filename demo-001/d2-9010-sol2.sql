-- @plscope

select empno, ename, hiredate, sal
  from emp
 where hiredate between date '1980-01-01' and date '1981-04-01';

select * from nls_session_parameters where parameter = 'NLS_DATE_FORMAT';
alter session set nls_date_format = 'MM/DD/YYYY';
alter session set nls_date_format = 'YYYY-MM-DD';
alter session set nls_date_format = 'DD.MM.YYYY';