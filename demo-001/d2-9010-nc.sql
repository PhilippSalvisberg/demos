-- @plscope

select empno, ename, hiredate, sal
  from emp
 where hiredate between to_date('01.01.1980') and to_date('01.04.1981');

select * from nls_session_parameters where parameter = 'NLS_DATE_FORMAT';
alter session set nls_date_format = 'MM/DD/YYYY';
alter session set nls_date_format = 'YYYY-MM-DD';
alter session set nls_date_format = 'DD.MM.YYYY';