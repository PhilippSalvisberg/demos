SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}")" && pwd -P)"

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
