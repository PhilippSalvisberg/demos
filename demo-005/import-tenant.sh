#!/usr/bin/env bash
set -e
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}")" && pwd -P)"

# import an tenant export file from exports folder, pass only the name after the dash
dblinter import-tenants \
  --repoUrl=http://localhost:8080 \
  --tenantName=Demo \
  --userName=philipp.salvisberg+42@gmail.com \
  --accessToken=$DBLINTER_DEMO_ACCESS_TOKEN \
  --inputName="$SCRIPT_DIR/exports/demo-$1"
