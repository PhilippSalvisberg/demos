set -e

project_name="dblinter-demo-custom-validator"
projects_dir="$HOME/Library/Caches/JetBrains/IntelliJIdea2026.1/projects"

find "$projects_dir" \
    -maxdepth 1 \
    -type d \
    -name "$project_name.*" \
    -print \
    -exec rm -rf -- {} +