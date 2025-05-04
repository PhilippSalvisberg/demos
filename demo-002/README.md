# The Trivadis PL/SQL & SQL Coding Guidelines Are Dead – What Now?

## Setup

- SonarQube [project demo-002](http://192.168.1.57:61011/dashboard?id=demo-002) is reachable.
- dbLinter extension is disabled
- SonarQube for IDE is enabled
- open [01_setup/as_sys.sql](01_setup/as_sys.sql)
- Attach connection aaa-sys
- Hidel panel with problems and script output

## Static Code Analysis Demo (8')

### 1. Create user `demo_app` (1')

- Run script (F5)
- Explain that a user `demo_app` was created, with `dept`/`emp` tables and object types for `dept`
- close [01_setup/as_sys.sql](01_setup/as_sys.sql)

### 2. Package Specificaton demo_names.pks with SonarQube (3')

- Open [02_demo/demo_names.pks](02_demo/demo_names.pks)
- Attach connection aaa-demo_app
- Compile file
- Package is valid
- Open `problems` and explain the parsing error
  - no indication where the problem occurs
  - no other issures reported in this case
  - Root cause is that the size of a varchar2 can be defined with a [VARCHAR2 Static Expression](https://docs.oracle.com/en/database/oracle/oracle-database/23/lnpls/expressions.html#GUID-5D80A222-E07B-45B5-AB08-83016EF64A45), but the SonarQube parser does no suport that
- Fix by replacing `co_short_string_size` by `100` on line 3
- Open `problems` and explain options
  - quick fix "Resolve" (marks it locally is done, without doing anything "Accepted" or "False Positive" - don't do this)
  - quick fix "Show issue" (shows the rule within VS Code)
- fix by remove the line (unused global variable) and compile the changed file
- close [02_demo/demo_names.pks](02_demo/demo_names.pks)

### 3. Package Body demo_names.pkb with SonarQube (1')

- Open [02_demo/demo_names.pkb](02_demo/demo_names.pkb)
- Attach connection aaa-demo_app
- Compile file
- Package is valid
- Open `problems` and explain the parsing error (same as before)
- Fix by replacing `co_short_string_size` by `100` on line 2
- Explain the two remaining problems
  - Navigate via `problems`
  - Show problem details on mouse-over
  - Select `View problems` on mouse-over (Option-F8), to view problem inline
  - Explain the shown regex and why it is so generic (`l_` is an accepted prefix)
- Fix problem on line 2 by adding a `g_` prefix
- Close [02_demo/demo_names.pkb](02_demo/demo_names.pkb)

### 4. Prepare Demo with dbLinter (30'')

- Disable SonarQube extension
- Restart extensions
- Enable dbLinter extension
- Revert changes

### 5. Package Specificaton demo_names.pks with dbLinter (30'')

- Open [02_demo/demo_names.pks](02_demo/demo_names.pks)
- Attach connection aaa-demo_app
- Compile file
- Package is valid
- Show quick fixes
- Apply quick fix `Add NOSONAR marker with reason: false positive.`
- Undo change (Command-Z)
- Apply quick fix `Remove variable declaration.`
- That's a quick fix
- Compile file
- Package is valid

### 6. Package Body demo_names.pkb with dbLinter (2')

- Open [02_demo/demo_names.pkb](02_demo/demo_names.pkb)
- We keep the changes suggested by SonarQube
- Explain the three remaining problems and fix them
- Explain why `o_dept` is expected on line 31
  - why is `l_dept` not accepted?
  - how is this implemened?
- Same with `t_dept` and the other provided object and collection types
  - `sys.ftpuritype`
  - `sys.ODCINumberList`
- Compile file
- Package is valid

## SQL-based Tests Demo

### 1. Run SQL-based Tests (4')

- open dbLinter panel
- explain that these are the 15 enabled rules in the current configuration
- run all tests
- expand all
- colapse all
- expand results for G-1240
- make the complete message visible by moving the slider to the right
- select both results, right-click, select `Ignore Test Results...` and enter `FK indexes are for ...`
- Refresh
- Re-run G-1240 only (no issues)
- Re-run all
- Open [preview.dblinter.app](https://preview.dblinter.app)
  - sign in
  - open configuration `demo-002`
  - open tab `Ignore Test Results`
  - click on G-1240
  - select all rows
  - delete rows
  - save
- Go back to VS Code
- Refresh
- Re-run G-1240 only (no issues)
- Re-run all
- Select both results, right-click, select `Show Migration Script`
- Run the migration script under `aaa-demo_app`
- Re-run all
- Select G-1240 and `Open Rule in Default Browser`
- Expand `Test SQL query` and explain it
  - first column is the identifier (used to ignore results)
  - second column is the message
  - third column is optional, it contains the migration script
