-- @flash
-- 23.8
-- The Flash - Time Travel

create flashback archive fba
   tablespace users
   quota 10m
   retention 1 year;

create table t (
   oid  number(4,0)        not null primary key,
   c1   varchar2(255 byte) not null,
   c2   varchar2(255 byte) not null
) flashback archive fba;

-- enforce synchronization for demo purposes
begin
   sys.dbms_flashback_archive.disassociate_fba(
      owner_name => USER,
      table_name => 'T'
   );
   sys.dbms_flashback_archive.reassociate_fba(
       owner_name => USER,
       table_name => 'T'
   );
end;
/

begin
   insert into t (oid, c1, c2) values (1, 'A', 'B');
   commit;
   sys.dbms_session.sleep(6);
   update t set c2 = 'B updated' where oid = 1;
   commit;
end;
/

select *
  from t as of timestamp systimestamp - interval '30' minute;

select *
  from t as of timestamp systimestamp - interval '25' second;

select versions_startscn,
       versions_endscn,
       versions_starttime,
       versions_endtime,
       versions_xid,
       versions_operation,
       t.*
  from t versions between scn minvalue and maxvalue;

-- --------------------------------------------------------------------------
-- cleanup (part of demo)
-- --------------------------------------------------------------------------

drop table t purge;

alter table t no flashback archive;

drop table t purge;
