# Formatter

## Setup

- Open [CLI Formatter Options](https://grisselbav.github.io/dbLinter/tools/cli/format/)
- Reset [dbLinter Formatter Settings](command:workbench.action.openSettings?%5B%22@ext:grisselbav.dblinter%22%5D) to default values
- Set [dbLinter maxLineSize](command:workbench.action.openSettings?%5B%22dblinter.formatter.maxLineSize%22%5D) to 128
- Set dbLinter as default formatter for oracle-plsql, check [user settings](command:workbench.action.openSettingsJson) contains:

   ```json
   "[oracle-sql]": {
        "editor.defaultFormatter": "Grisselbav.dblinter"
    },
   ```

## Demo (5')

### 1. Lightweight Formatter (2')

- open [01-single-line.sql](01-single-line.sql)
- explain calling the formatter now does nothing, because `preserveSingleLineStatement` is enabled
- open settings (Cmd-,), search for "dblinter", click on "Formatter: Line Breaks Within Statements"
- Add line break before first `from` and press Shift-Opt-F
- Add line break before second `from` and press Shift-Opt-F
- Add line break before second `select` and press Shift-Opt-F
- Add line break before last `)` and press Shift-Opt-F

### 2. ASCII Art and Partial Formatting (1' 30")

- open [10-ascii-art.sql](10-ascii-art.sql)
- explain that this is not readable
- press Shift-Opt-F
- select a part of the code and press Shift-Opt-F
- right-click and select `Format Selection``
- extend the selection and press Cmd-K Cmd-F
- repeat and explain functionality

#### 3. CLI (1' 30")

- Open a terminal
- Run `dblinter format`
- Show git diff
- Explain change in Markdown file

## SQL in Markdown files

- SQL example:

    ```sql
    select
     ename, sal
      from
       emp
        where
         sal
          >
           2000
            ;
    ```

- PL/SQL example

    ```sql
    begin
    null;
    end;
    ```
