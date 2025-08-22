# The Superpowers of the Oracle Database

## Setup

- Connections `aaa-sys`, `aaa-flash` and `aaa-cyborg` are defined in SQL Developer for VS Code.
- open [01_setup/as_sys.sql](01_setup/as_sys.sql) and run it as `aaa-sys` and close the file.
- open [02_demo/d1-flash-time-travel.sql](02_demo/d1-flash-time-travel.sql)
- open [02_demo/d2-cyborg-vpd.sql](02_demo/d2-cyborg-vpd.sql)

## The Flash - Time Travel

- create flashback archive
- explain options
- create table t
- explain `flashback archive fba`
- show tables of user `flash`
- disassociate_fba/reassociate_fba for synchronization (bug in 23.8/23.9?)
- run block to insert and update data
- query table t 30 minutes ago, explain error
- query table t 25 seconds ago, explain results until last update is visible
- query all versions and explain result
- cleanup

## Virtual Private Database Demo

- drop existing table emp
- create new table emp, show content
- create `emp_predicate` function, explain parameter, return value
- create `emp_policy`, explain options
- query `user_policies`, explain result
- query unrestricted columns, explain result and show execution plan
- query all columns, explain result and show execution plan with policy predicate
- quiz: how many rows for `count(*)`? run query and explain
- quiz: how many rows for `count(1)`? run query and explain
- quiz: how many rows for `count(empno)`? run query and explain
- insert emp with salary, explain why it fails.
- insert emp without salray, expain wyh it succeeds.
- quiz: result of `delete from emp`. Error yes/no? How many rows? Explain
- delete emp, explain
- update emp, explain
- merge into emp, explain and show explain plan in SQLcl
- cleanup
