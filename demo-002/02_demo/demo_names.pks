create or replace package demo_names is
   co_short_string_size  constant integer := 100;
   global_variable varchar2(co_short_string_size char) := 'Global Variable';

   procedure proc1(
      in_param1  in     varchar2,
      io_param2  in out varchar2,
      out_param3 out    integer
   );
end demo_names;
/
