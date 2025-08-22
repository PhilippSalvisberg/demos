prompt
prompt ================================================================================================================
prompt as SYS
prompt ================================================================================================================

alter session set current_schema = sys;

drop user if exists json cascade;

create user json
   identified by json
   default tablespace users
   quota 100m on users;

grant db_developer_role to json;
grant read on sys.v_$session to json;
grant read on sys.v_$sql_plan_statistics_all to json;
grant read on sys.v_$sql_plan to json;
grant read on sys.v_$sql to json;

