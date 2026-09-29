#!/bin/bash

set -euo pipefail

PROJECT_ROOT="${1:-$(pwd)}"
WORK_DIR="$(mktemp -d)"
trap 'rm -rf "$WORK_DIR"' EXIT

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

echo -e "${YELLOW}Running init scripts in a temporary directory...${NC}"

(
    cd "$WORK_DIR"
    for script in init_packages.sh init_packages_files.sh init_packages_swiftdata_files.sh; do
        bash "$PROJECT_ROOT/scripts/$script" >/dev/null
    done
)

normalize() {
    sed -E \
        -e 's|^(// .+, created on )[0-9]{2}\.[0-9]{2}\.[0-9]{4}$|\1DATE|' \
        -e 's|^(// Copyright © )[0-9]{4}( .+)$|\1YEAR\2|' \
        "$1"
}

status=0
compare_tree() {
    local expected_root="$1"
    local actual_root="$2"
    local label="$3"
    while IFS= read -r file; do
        local relative="${file#"$expected_root"/}"
        local other="$actual_root/$relative"
        if [ ! -f "$other" ]; then
            echo -e "${RED}Missing in $label: $relative${NC}"
            status=1
        elif ! diff -q <(normalize "$file") <(normalize "$other") >/dev/null; then
            echo -e "${RED}Differs: $relative${NC}"
            diff <(normalize "$other") <(normalize "$file") | head -20 || true
            status=1
        fi
    done < <(find "$expected_root" -type f \
        -not -path '*/.build/*' \
        -not -path '*/.swiftpm/*' \
        -not -name 'Package.resolved' \
        -not -name '.DS_Store')
}

compare_tree "$PROJECT_ROOT/Packages" "$WORK_DIR/Packages" "generated packages"
compare_tree "$WORK_DIR/Packages" "$PROJECT_ROOT/Packages" "repository"

if [ "$status" -ne 0 ]; then
    echo -e "${RED}Init scripts are out of sync with Packages/. Run \`make init-scripts\`.${NC}"
    exit 1
fi

echo -e "${GREEN}Init scripts reproduce Packages/.${NC}"
