#!/usr/bin/env bash
set -e
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}")" && pwd -P)"

# load version with defined R-3131 guideline, but without validator
"$SCRIPT_DIR/import-tenant.sh" setup

# remove the generated project
rm -rf "$SCRIPT_DIR/dbLinter-Demo-Custom-Validator"

# clear project caches for IntelliJ IDEA 2026.1
PROJECTS_DIR="$HOME/Library/Caches/JetBrains/IntelliJIdea2026.1/projects"
if [ -d "$PROJECTS_DIR" ]; then
  find "$PROJECTS_DIR" \
    -maxdepth 1 \
    -type d \
    -name "dblinter-demo-custom-validator" \
    -print \
    -exec rm -rf -- {} +
fi

# remove the dbLinter-Demo-Custom-Validator project from the list clear all remaining caches
idea1 &
