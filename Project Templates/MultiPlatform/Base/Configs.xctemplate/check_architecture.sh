#!/bin/bash

PROJECT_ROOT="${1:-$(pwd)}"
PACKAGES="$PROJECT_ROOT/Packages"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

violations=0

check() {
    local description="$1"
    local pattern="$2"
    shift 2
    local paths=()
    for path in "$@"; do
        [ -d "$path" ] && paths+=("$path")
    done
    [ ${#paths[@]} -eq 0 ] && return
    local matches
    matches=$(grep -rnE --include='*.swift' "$pattern" "${paths[@]}" 2>/dev/null | grep -v '/\.build/')
    if [ -n "$matches" ]; then
        echo -e "${RED}✗ $description${NC}"
        echo "$matches" | sed "s|$PROJECT_ROOT/||"
        violations=$((violations + 1))
    fi
}

echo -e "${YELLOW}Checking architecture rules...${NC}"

check "NavigatorUI is allowed only in the app target" \
    '^[[:space:]]*(@_exported[[:space:]]+)?import[[:space:]]+NavigatorUI\b' \
    "$PACKAGES"

check "App packages must not use SwiftData directly (@Query, .modelContainer)" \
    '^[[:space:]]*(@_exported[[:space:]]+)?import[[:space:]]+SwiftData\b|@Query\b|\.modelContainer\(' \
    "$PACKAGES/App/Sources"

check "Services must work with Domain models only (no SwiftData)" \
    '^[[:space:]]*(@_exported[[:space:]]+)?import[[:space:]]+SwiftData\b' \
    "$PACKAGES/Services/Sources"

check "Env must not depend on app layers (only Models is allowed)" \
    '^[[:space:]]*(@_exported[[:space:]]+)?import[[:space:]]+(Database|Services|Main|Onboarding|Settings|SwiftData)\b' \
    "$PACKAGES/Env/Sources"

check "Models must not depend on other app layers" \
    '^[[:space:]]*(@_exported[[:space:]]+)?import[[:space:]]+(Database|Services|Env|Main|Onboarding|Settings|SwiftData)\b' \
    "$PACKAGES/Models/Sources"

check "Database must not depend on upper layers" \
    '^[[:space:]]*(@_exported[[:space:]]+)?import[[:space:]]+(Services|Env|Main|Onboarding|Settings)\b' \
    "$PACKAGES/Database/Sources"

if [ "$violations" -gt 0 ]; then
    echo -e "${RED}Architecture check failed: $violations rule(s) violated.${NC}"
    exit 1
fi

echo -e "${GREEN}Architecture check passed.${NC}"
