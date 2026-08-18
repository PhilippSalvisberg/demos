SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}")" && pwd -P)"

dblinter import-validator \
  --repoUrl=https://api.dblinter.app \
  --tenantName=Demo \
  --userName=philipp.salvisberg+42@gmail.com \
  --accessToken=$DBLINTER_DEMO_ACCESS_TOKEN \
  --inputName="$SCRIPT_DIR/dbLinter-Demo-Custom-Validator/target/custom-validator-1.0.0-SNAPSHOT.jar" \
  --ownerName=Demo \
  --parserVersion=0.24.0
