prompt
prompt ================================================================================================================
prompt as SYS
prompt ================================================================================================================

alter session set current_schema = sys;

drop user if exists flash cascade;

create user flash
   identified by flash
   default tablespace users
   quota 100m on users;

grant db_developer_role to flash;
grant flashback archive administer to flash;
grant execute on sys.dbms_flashback_archive to flash;
grant execute on sys.dbms_flashback to flash;

declare
   e_incorrect_fba exception;
   pragma exception_init(e_incorrect_fba, -55605);
begin
   execute immediate 'drop flashback archive fba';
exception
   when e_incorrect_fba then
      null; -- may fail, not exists clause not supported for this DDL statement
end;
