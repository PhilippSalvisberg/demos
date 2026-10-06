#!/usr/bin/env bash
set -e
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}")" && pwd -P)"

# generate custom validator skeleton Java project
dblinter gen-java \
  --repoUrl=http://127.0.0.1:8080 \
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

# IntelliJ IDEA 2026.2
idea "$SCRIPT_DIR/dbLinter-Demo-Custom-Validator" &
