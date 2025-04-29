-- @plscope

create or replace procedure p(in_table_name in varchar2) as
   co_templ     constant varchar2(4000 byte) := 'DROP TABLE #in_table_name# PURGE';
   l_table_name varchar2(128 byte);
   l_sql        varchar2(4000 byte);
begin
   -- passing "dept cascade constraints" is possible
   l_table_name := in_table_name;
   l_sql        := replace(co_templ, '#in_table_name#', l_table_name);
   execute immediate l_sql;
end p;
/

exec p('dept');
exec p('dept2');
exec p('dept 3');
exec p('"dept 4"');