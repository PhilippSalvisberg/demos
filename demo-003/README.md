# The Superpowers of the Oracle Database

## Setup

- Connections `aaa-sys` and `aaa-flash` are defined in SQL Developer for VS Code.
- open [01_setup/as_sys.sql](01_setup/as_sys.sql) and run it as `aaa-sys` and close the file.
- open [02_demo/d1-flash-time-travel.sql](02_demo/d1-flash-time-travel.sql)

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

- tbd
