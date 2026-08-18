SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}")" && pwd -P)"

dblinter import-tenants \
  --repoUrl=https://api.dblinter.app \
  --tenantName=Demo \
  --userName=philipp.salvisberg+42@gmail.com \
  --accessToken=$DBLINTER_DEMO_ACCESS_TOKEN \
  --inputName="$SCRIPT_DIR/exports/demo-$1"
