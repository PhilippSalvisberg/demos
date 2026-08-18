SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}")" && pwd -P)"

# IntelliJ IDEA 2026.1.5
# older version due to ANTLR4 plugin compatiblity issues since 2026.2.0
# see https://github.com/antlr/intellij-plugin-v4/issues/740
idea1 "$SCRIPT_DIR/dbLinter-Demo-Custom-Validator"
