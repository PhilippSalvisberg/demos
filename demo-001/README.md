# Fighting Bad PL/SQL & SQL with VS Code

## Setup

- dbLinter extension is enabled
- Connections `aaa-hr`, `aaa-plscope` and `aaa-sh` are defined in SQL Developer for VS Code.
- The configuration `demo-001` in tenant Grisselbav is configured as follows:
  - no excludes/includes
  - Connection: dbl_read@localhost
  - enabled rules: G-1030, G-1080, G-1920, G-2150, G3185, G-4230, G-4250, G-4320, G-5080, G-7460, G-7810, G-9010, G-9501, G-9600, G-9601, G-9602, G-9603
  - parameters: default values
  - ignore test resutls: not relevant (no rules with SQL-based tests enabled)
- Hidel panel with problems and script output

## Demo (24' 30'')

### 1. [d1-4320-nc.sql](d1-4320-nc.sql) (4' 30'')

- Run with `aaa-sh`
- Explain that the Oracle Database and dbLinter do not have any problems understanding this code
- Format the code
- Explain that this is better than before even if the formatter result is not perfect
- open `Problems` panel and explain problems
  - click on `G-4320: Always label your loops`
  - Explain G-4320
    - What does that code?
    - No comment
    - Label could replace that code
- This is not a bug, it's disputable if you need this rule, so we can disable it
- Open [preview.dblinter.app](https://preview.dblinter.app)
  - sign in
  - open configuration `demo-001`
  - explain configuration
    - include/exclude
    - connection details
    - rules
      - search for `4320`
      - disable rule
      - save
    - ignore test results (no rules configured with SQL-based tests, therefore nothing that can be ignored)
  - back to VS Code and reload window
  - back to Web-GUI and re-enable rule G-4320
  - back to VS Code and reload window
- open `Problems` panel and explain problems
  - click on `G-4320: Always label your loops`
- mouse-over first issue
- click on `View Problem` (Option-F8)
- navigate to next problem and back
- close the inline problem mode
- mouse-over first issue again
- Call Check again and click on `Quick Fix` (Command-.), explain Shortcut, apply quick fix
- Undo change by pressing Command-Z
- Click on blue bulp to show context menu, apply quick fix
- Undo change by pressing Command-Z
- Click on the bulp in the problem panel and apply quick fix
- Undo change by pressing Command-Z
- Press Command-. over the first issue and apply quick fix
- Change label to `print_tennis_products_sold_in_europe_2022`
- Go to second issue and apply quick fix
- Fold code
- Explain that due to the label you still know what the code does
- Like it, keep the rule enabled. Don't like it, then disable the rule
- Now let's look at important rules, reported probelems are bugs

### 2. [d2-1080-nc.sql](d2-1080-nc.sql) (1')

- Explain first issues
- Apply quick fix
- Explain G-1030, it's an indicator of another problem
- Explain G-1080,
- Change second value to l_var2

### 3. [d2-2150-nc.sql](d2-2150-nc.sql) (1')

- Run script as `aaa-plscope`
- No output, that's what we expect
- Explain G-2150
- Apply quick fix
- Rerun script, still no output, but this time the code would report a salesman without comm
- Explain false negative on line 17
- Fix it manually be replacing `comm = l_comm` with `l_comm is null`
- Fix new problem G-1030 by applying the quick fix
- A rule implementation may not be perfect, but is often better than nothing

### 4. [d2-3185-nc.sql](d2-3185-nc.sql) (2')

- Explain issue by running the query as `aaa-plscope`
  - Are these the top 2 salaries?
  - Does the order of the rank make sense?
- dbLinter provides no quick fix
- Let's try co-pilot, solution looks probably like this:

  ```sql
  select ename,
         sal,
         hiredate,
         rank
    from (
          select ename,
                 sal,
                 hiredate,
                 rownum as rank
            from emp
           where rownum <= 2
         )
   order by sal desc;
  ```

- re-run query, still same, wrong result?
- Fix the solution to look like in [d2-3185-sol1.sql](d2-3185-sol1.sql)
  - move `rownum as rank` to outer query block
  - move `order by sal desc` to inner query block
  - move `where rownum <= 2` to outer query block
- re-run query with correct result
- open [d2-3185-sol2.sql](d2-3185-sol2.sql)
- run it as `aaa-plscope` and explain solution for >=12.1
- replace `with ties` with `only` to produce same result

### 4. [d2-4230-nc.sql](d2-4230-nc.sql) (2' 30'')

- Run query as `aaa-plscope`
- Explain G-4230 by running the query
- Apply quick fix for G-7460
- Rerun query and explain behaviour
- Define function as `nondeterministic`
- Fix syntax error by using `/* NOSONAR: nondeterministic */`
- Show quick fix options for G-4230 and explain them
- Apply quick fix `replace nvl with coalesce`
- Rereun query and explain behaviour

### 5. [d2-4250-nc.sql](d2-4250-nc.sql) (1')

- Run query as `aaa-plscope`
- PRESIDENT has no salary
- Copy & paste problem is repored also when moving the 2nd WHEN clause to the end
- No quick fix. Fix it manually.
- Rerun query

### 6. [d2-5080-nc.sql](d2-5080-nc.sql) (2')

- Run script as `aaa-plscope`
- Explain that the source of error is not visible, no line referenced
- Good old workaround most of us used in the past: disable exception block, do it
- Re-Run script
- Remove line 1-3
- Re-Run script
- Expline references to line 5 and 10. Remove lines before block
- Re-enable exception block
- Apply quick fix
- Re-Run code
- Better log message

### 7. [d2-7810-nc.sql](d2-7810-nc.sql) (1')

- Explain unnecessity to query dual (we are not on Oracle 10 anymore, right?)
- Apply quick fix
- shorter, faster, less resource intensive

### 8. [d2-9010-nc.sql](d2-9010-nc.sql) (2' 30'')

- explain rule
- run query
- change nls settings and rerun query (differen result, error)
- fix query by adding a format manually
- open [d2-9010-sol2.sql](d2-9010-sol2.sql)
- explain why using a date literal is a good alternative

### 9. [d2-9501-nc.sql](d2-9501-nc.sql) (2' 30'')

- Install procedure using `aaa-plscope`
- Explain G-9501
  - double click on in_table_name (VS Code shows definition)
  - double click on l_table_name (SQLDev shows definition, usages)
  - double click on l_sql (SQLDev shows usage in execute immediate)
  - parameter is passed "as is" to SQL, that's SQLi
- run `exec p` examples and explain outcome
- apply quick fix `Add dbms_assert.sql_object_name call`
- Re-install procedure using `aaa-plscope`
- re-run `exec p` examples and explain outcome
- SQLi is not possible anymore

### 10. [d2-9600-nc.sql](d2-9600-nc.sql) (3')

- Explain issues
- Run queries as `aaa-plscope` and explain the explain plan result (no hint report)
- Apply quick fix `Remove hint.` for G-9601
- Apply quick fix `Merge into first hint.` for G-9600
- Re-run queries and explain hint report (no indication why the hint is not used)
- Apply quick fix `Replace table name with alias.` for G-9602
- Apply quick fix `Use d instead of dep in leading hint.` for G-9603
- Re-run queries and explain hint report (hint is used)
- No need to run the query to find these types of hint issues

### 11 [d2-multiple-problems-nc.sql](d2-multiple-problems-nc.sql) (1' 30'')

- apply quick fix `Fix all G-4230 problems like 'replace nvl with coalesce.'`
- undo changes with Command-Z
- apply quick fix `Fix all problems.`
- explain why not all problems are fixed.
- Applying `Fix all problems.` should be pretty safe.
- Best performance when applying fix for G-7460 (0.2 instead of 0.8)
