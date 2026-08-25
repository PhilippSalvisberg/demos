#!/usr/bin/env bash
set -e
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}")" && pwd -P)"

# generate custom validator skeleton Java project
dblinter gen-java \
  --repoUrl=https://api.dblinter.app \
  --tenantName=Demo \
  --userName=philipp.salvisberg+42@gmail.com \
  --accessToken=$DBLINTER_DEMO_ACCESS_TOKEN \
  --configName=Demo \
  --indent=4 \
  --outputName=$SCRIPT_DIR/dbLinter-Demo-Custom-Validator \
  --tenantFilter=Demo \
  --ruleFilter=.+ \
  --groupId=com.grisselbav \
  --packageName=com.grisselbav.demo.validator

# use demo access token
sed -i '' 's/DBLINTER_ACCESS_TOKEN/DBLINTER_DEMO_ACCESS_TOKEN/g' \
  "$SCRIPT_DIR/dbLinter-Demo-Custom-Validator/pom.xml" \
  "$SCRIPT_DIR/dbLinter-Demo-Custom-Validator/README.md"

# use production repoUrl
sed -i '' 's/test-api.dblinter.com/api.dblinter.app/g' \
  "$SCRIPT_DIR/dbLinter-Demo-Custom-Validator/README.md"

# override parser version to match behaviour with default settings
sed -i '' 's/parserVersion=0.20.0/parserVersion=0.25.0/g' \
  "$SCRIPT_DIR/dbLinter-Demo-Custom-Validator/README.md"

# IntelliJ IDEA 2026.1.5
# older version due to ANTLR4 plugin compatiblity issues since 2026.2.0
# see https://github.com/antlr/intellij-plugin-v4/issues/740
idea1 "$SCRIPT_DIR/dbLinter-Demo-Custom-Validator" &
