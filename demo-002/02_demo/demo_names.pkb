create or replace package body demo_names is
   package_global_variable varchar2(100) := 'Package Global Variable';

   -- -----------------------------------------------------------------------------------------------------------------
   -- proc1 (public)
   -- -----------------------------------------------------------------------------------------------------------------
   procedure proc1(
      in_param1  in     varchar2,
      io_param2  in out varchar2,
      out_param3 out    integer
   ) is
      local_variable pls_integer;

      -- cursor
      cursor c_cur1 is select * from dept;
      l_cur2 sys_refcursor;

      -- record and table types
      type r_dept_type is
         record(
            deptno number,
            dname  varchar2(14 char),
            loc    varchar2(13 char)
         );
      type t_dept_type is
         table of r_dept_type index by pls_integer;
      l_dept1 r_dept_type;
      l_dept2 t_dept_type;

      -- SQL object types and collection types
      o_dept     dept_ot;
      t_dept     dept_ct;
      o_uritype  sys.ftpuritype      := sys.ftpuritype('localhost');
      t_num_list sys.ODCINumberList := sys.ODCINumberList(1, 2, 3);
   begin
      null;
   end proc1;
end demo_names;
/
