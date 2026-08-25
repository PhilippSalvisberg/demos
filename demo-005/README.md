# Fighting Bad PL/SQL & SQL with Custom Rules

## Setup

- Tenant `Demo` is registered in [dbLinter production instance](https://dblinter.app)
- `philipp.salvisberg+42@gmail.com` is a tenant admin with a personal access token
- Define the following environment variables:
  - `DBLINTER_DEMO_ACCESS_TOKEN`
  - `DBLINTER_DEMO_CONN_PASSWORD`
- Run `./setup.sh` to load the demo tenant config with the R-3131 rule without validator and remove java project
- Open VS Code
  - File -> Open Folder...
  - Select this folder as workspace
- Open a terminal window at the root folder
- Open [https://dblinter.app](https://dblinter.app) in the browser
  - Log in as `philipp.salvisberg+42@gmail.com`
  - Select tenant `Demo` if it is not activated by default

## Demo (20')

### 1. Show non-compliant Code (1', RT 1')

- open [3131-non-compliant.sql](3131-non-compliant.sql)
- explain that no problems are shown, because the validator is not yet implemented

### 2. Register Rule (2', RT 3')

- Open Administration -> Rules
  - Explain that you maintain tenant-specific rules here
  - You can copy an existing rule (even core rules) are create new ones
  - To safe time I already prepared "R-3131: Never user ANSI SQL-92 join syntax."
- Edit "R-3131" rule
- Select "Rule" tab
  - Press "Preview Rule" and explain that you can preview the rule as presented in the read-only pages
- Select "Parameters"
- Select "References"
- Select "Example Sets"
  - Edit "OracleDB"
  - Edit the non-compliant example
  - Edit the compliant example, explain that you can have multiple compliant examples and define the number of stars
- Select "DBMS Scopes"
- Select "Tests"
- Open Administration -> Validators
  - No validators yet
  - We are going to create one and upload it

### 3. Generate Java Validator Project (1', RT 4')

- Show content of [gen-java.sh](gen-java.sh)
- Run `./gen-java.sh` in terminal
- IntelliJ opens

### 4. Run Tests (2', RT 6')

- Scroll through the automatically opened README.md file
- Run `./mvnw clean package` from the README.md and explain why it fails
- Run `./mvnw clean package -DskipTests=true` from the README.md to show that the build completes successfully without running tests
- Open `src`, `test`, right-click on `java` and `Run 'All Tests'`
- Click on failed `non_compliant_1()` test and navigate to failing line
- Explain generated test and why it fails

### 5. Implement the Check (3', RT 9')

- Open `src`, `main` and then `DemoR3131`
- Replace `FileContext` by `JoinVariantContext`
- Rename `checkPlsqlStatement` to `checkJoinVariant`
- Replace `TODO: ...` with `addIssue()`
  - `.addRange(ctx.start)` explain that this the range to marked in the editor
  - `.setMessage("Never use ANSI SQL-92 join syntax.");` for the diagnostics message
- Rerun all tests
- Click on failed `non_compliant_1()` test and navigate to failing line
- Explain that we did get an issue, but with an unexpected message.
- Copy the expected message from the text and paste it in the DemoR3131.java
- Rurun all tests, they should all succeeed now

### 6. Publish Validator (1', RT 10')

- run `./mvnw clean deploy` via `README.md` to produce the JAR file and publish the JAR file
- open [Validators](https://dblinter.app/ords/r/dblinter/dblinter-console/tenant-validators) in the browser

### 7. Test in VS Code (3', RT 13')

- open VS Code
- open [3131-non-compliant.sql](3131-non-compliant.sql), explain why no problems are shown
- [reload window](command:workbench.action.reloadWindow)
- Explain the two problems on lines 2 and 9
- Apply `Fix` for the first problem, to demonstrate how Copilot can provide a fix
- Explain the new G-3130 issue
- Open the [Core G-3130](https://dblinter.app/ords/r/dblinter/dblinter-console/rules#P1000_SHOW_RULE=Core%20G-3130) issue and remove it from the `Demo` configuration
- Back in VS Code [reload window](command:workbench.action.reloadWindow) to apply the config change

### 8. dbLinter Output Panel (1', RT 14')

- Show [Show dbLinter output](command:dblinter.showOutput)
- Search for `R-3131`
- Explain that only one check is registered of 2 validators
- Explain top-level parse metrics (chars, lines, lexer time, parser time)
- Explain parser profile (rule names are contexts)
- Explain check profile (method name represents the context for core rules)
- Revert the changes in [3131-non-compliant.sql](3131-non-compliant.sql) via Git

### 9. Implement Deterministc Quick Fixes (6', RT 20')

- Switch to IntelliJ
- Open `Demo3131.java`
- Add `Convert to Oracle join syntax` quick fix
  - add `/* TODO: convert to Oracle Join */` after start token (pseudo fix)
  - enable `partOfFixAll` property
- Add `.addDbLinterIgnoreQuickFix(ctx.start, "Keep ANSI SQL-92 join because ...")`
- Add `.addFalsePositiveQuickFix(ctx.start)`
- Add breakpoint at `return checkIssues;` line
- Run tests without debug to show that they still complete
- Run tests with debug to demonstrate supplier
- Show quick fixes in debugger
- Show result of `checkIssues.get(0).quickFixes.get(0).function.get()` in debugger
- Explain delayed execution of a quickfix
- Run `./mvnw clean deploy`

### 10. Test Quick Fixes in VS Code (2' RT 22')

- Switch to VS Code
- open [3131-non-compliant.sql](3131-non-compliant.sql), explain why no problems are shown
- Execute [reload window](command:workbench.action.reloadWindow) to apply the config change
- Apply quick fixes and undo changes afterwards:
  - Convert to Oracle join syntax" for first issue
  - Fix all R-3131 problems like 'Convert to Oracle join syntax'
  - Fix all problems" (in this case same result), and undo
  - Add @dbLinter ignore marker with reason: Keep ANSI SQL-92 join syntax because ....
  - Add @dbLinter ignore marker with reason: False positive.
- Add `cross join dual`
  - Add ignore marker on line level
  - Move it to statement level
  - Move it to file level

## Snippets

### DemoR3131.java

```java
/*
 * generated by dbLinter CLI
 */
package com.grisselbav.demo.validator;

import ch.islandsql.grammar.IslandSqlParser;
import com.grisselbav.dblinter.validator.base.AbstractCheck;
import com.grisselbav.dblinter.validator.base.Check;
import com.grisselbav.dblinter.validator.model.CheckIssue;
import com.grisselbav.dblinter.validator.model.Range;
import com.grisselbav.dblinter.validator.model.Replacement;

import java.util.List;

/**
 * Demo R-3131: Never use ANSI SQL-92 join syntax.
 */
public class DemoR3131 extends AbstractCheck {
    @Check(tenant = "Demo", rule = "R-3131")
    public List<CheckIssue> checkJoinVariant(IslandSqlParser.JoinVariantContext ctx) {
        addIssue()
                .setRange(ctx.start)
                .setMessage("Use Oracle instead of ANSI SQL-92 join syntax.")
                .addQuickFix("Convert to Oracle join syntax", () ->
                        List.of(new Replacement(new Range(ctx.start),
                                ctx.start.getText() +
                                        " /* TODO: convert to Oracle join */")), true)
                .addDbLinterIgnoreQuickFix(ctx.start, "Keep ANSI SQL-92 join because ...")
                .addFalsePositiveQuickFix(ctx.start);
        return checkIssues;
    }
}
```
