column json_data format a50
set pagesize 1000

-- implicit type conversion, really?
select json_serialize(dv.data returning varchar2 pretty) as json_data
  from dept_dv dv
 where dv.data."_id" = 10;
 select * from dbms_xplan.display_cursor();

 -- determine JSON data type, showing that `dv.data."_id"` is a JSON scalar number (and more)
select is_json_condition, value
  from (
          select deptno is json as is_json,
                 deptno is json(value) as is_json_value,
                 deptno is json(array) as is_json_array,
                 deptno is json(object) as is_json_object,
                 deptno is json(scalar) as is_json_scalar,
                 deptno is json(scalar number) as is_json_scalar_number,
                 deptno is json(scalar string) as is_json_scalar_string,
                 deptno is json(scalar binary_double) as is_json_scalar_binary_double,
                 deptno is json(scalar binary_float) as is_json_scalar_binary_float,
                 deptno is json(scalar date) as is_json_scalar_date,
                 deptno is json(scalar timestamp) as is_json_scalar_timestamp,
                 deptno is json(scalar timestamp with time zone) as is_json_scalar_timestamp_with_time_zone,
                 deptno is json(scalar null) as is_json_scalar_null,
                 deptno is json(scalar boolean) as is_json_scalar_boolean,
                 deptno is json(scalar binary) as is_json_scalar_binary,
                 deptno is json(scalar interval year to month) as is_json_scalar_interval_year_to_month,
                 deptno is json(scalar interval day to second) as is_json_scalar_interval_day_to_second
            from (select dv.data."_id" as deptno from dept_dv dv where rownum = 1)
       ) src unpivot (
          value for is_json_condition in (
             is_json,
             is_json_value,
             is_json_array,
             is_json_object,
             is_json_scalar,
             is_json_scalar_number,
             is_json_scalar_string,
             is_json_scalar_binary_double,
             is_json_scalar_binary_float,
             is_json_scalar_date,
             is_json_scalar_timestamp,
             is_json_scalar_timestamp_with_time_zone,
             is_json_scalar_null,
             is_json_scalar_boolean,
             is_json_scalar_binary,
             is_json_scalar_interval_year_to_month,
             is_json_scalar_interval_day_to_second
          )
       );

-- explicit type conversion
-- see https://docs.oracle.com/en/database/oracle/oracle-database/23/adjsn/sql-json-path-expression-item-methods.html
select json_serialize(dv.data returning varchar2 pretty) as json_data
  from dept_dv dv
 where dv.data."_id".number() = 10;
 select * from dbms_xplan.display_cursor();

-- create JSON collection view
create or replace json collection view dept_cv as
select dv.data
  from dept_dv dv
 where dv.data."_id".number() = 10 or dv.data.loc.string() = 'DALLAS';

-- query JSON collection view with implicit type conversion in 23.8?
-- different behaviour compared to 23.6 and 23.7, the Oracle Database became cleverer.
select json_serialize(cv.data returning varchar2 pretty) as json_data
  from dept_cv cv
 where cv.data."_id" = 10;
select * from dbms_xplan.display_cursor();
