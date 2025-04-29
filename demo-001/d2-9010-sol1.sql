-- @plscope

select empno, ename, hiredate, sal
  from emp
 where hiredate between to_date('01.01.1980', 'DD.MM.YYYY') and to_date('01.04.1981', 'DD.MM.YYYY');

select * from nls_session_parameters where parameter = 'NLS_DATE_FORMAT';
alter session set nls_date_format = 'MM/DD/YYYY';
alter session set nls_date_format = 'YYYY-MM-DD';
alter session set nls_date_format = 'DD.MM.YYYY';