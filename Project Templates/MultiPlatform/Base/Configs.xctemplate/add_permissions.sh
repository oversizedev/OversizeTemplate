#!/bin/bash

PROJECT_ROOT="${1:-$(pwd)}"
APP_NAME="${2:-App}"
TARGETS="$PROJECT_ROOT/Configs/Targets.yml"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

if [ ! -f "$TARGETS" ]; then
    echo -e "${RED}Error: Configs/Targets.yml not found at $TARGETS${NC}"
    exit 1
fi

PERM_LABELS=(
    "Calendar"
    "Contacts"
    "Camera & Photos"
    "Microphone"
    "Location"
    "Face ID / Biometrics"
    "HealthKit"
    "HomeKit"
    "WeatherKit"
    "Speech Recognition"
    "Bluetooth"
    "Motion & Fitness"
    "Local Network"
    "App Tracking Transparency"
)

insert_info_key() {
    local key="$1"
    local value="$2"
    if grep -q "$key" "$TARGETS"; then
        return
    fi
    python3 - "$TARGETS" "$key" "$value" <<'PYEOF'
import sys
file_path, key, value = sys.argv[1], sys.argv[2], sys.argv[3]
with open(file_path, 'r') as f:
    lines = f.readlines()
insert_after = None
in_base = False
for i, line in enumerate(lines):
    stripped = line.lstrip()
    if stripped.startswith('base:'):
        in_base = True
    elif in_base and stripped.startswith('configs:'):
        break
    elif in_base and stripped.startswith('INFOPLIST_KEY_'):
        insert_after = i
if insert_after is None:
    sys.exit(1)
indent = ' ' * (len(lines[insert_after]) - len(lines[insert_after].lstrip()))
lines.insert(insert_after + 1, f'{indent}{key}: {value}\n')
with open(file_path, 'w') as f:
    f.writelines(lines)
PYEOF
}

insert_entitlement() {
    local key="$1"
    local value="$2"
    if grep -q "$key" "$TARGETS"; then
        return
    fi
    python3 - "$TARGETS" "$key" "$value" <<'PYEOF'
import sys
file_path, key, value = sys.argv[1], sys.argv[2], sys.argv[3]
with open(file_path, 'r') as f:
    lines = f.readlines()
insert_after = None
for i, line in enumerate(lines):
    stripped = line.lstrip()
    if stripped.startswith('com.apple.security.app-sandbox') or stripped.startswith('aps-environment'):
        insert_after = i
if insert_after is None:
    sys.exit(1)
indent = ' ' * (len(lines[insert_after]) - len(lines[insert_after].lstrip()))
lines.insert(insert_after + 1, f'{indent}{key}: {value}\n')
with open(file_path, 'w') as f:
    f.writelines(lines)
PYEOF
}

apply_selection() {
    local idx="$1"
    case "$idx" in
        0)
            insert_info_key "INFOPLIST_KEY_NSCalendarsUsageDescription" "$APP_NAME uses calendar access to add events to the Calendar app."
            insert_info_key "INFOPLIST_KEY_NSCalendarsFullAccessUsageDescription" "$APP_NAME uses full calendar access to create, update, and manage calendar events."
            ;;
        1)
            insert_info_key "INFOPLIST_KEY_NSContactsUsageDescription" "$APP_NAME uses contacts to help you find and invite people."
            ;;
        2)
            insert_info_key "INFOPLIST_KEY_NSCameraUsageDescription" "$APP_NAME uses the camera to attach photos."
            insert_info_key "INFOPLIST_KEY_NSPhotoLibraryUsageDescription" "$APP_NAME uses your photo library so you can attach existing photos."
            ;;
        3)
            insert_info_key "INFOPLIST_KEY_NSMicrophoneUsageDescription" "$APP_NAME uses the microphone to record audio."
            ;;
        4)
            insert_info_key "INFOPLIST_KEY_NSLocationWhenInUseUsageDescription" "$APP_NAME uses your location to show nearby places and relevant information."
            ;;
        5)
            insert_info_key "INFOPLIST_KEY_NSFaceIDUsageDescription" "$APP_NAME uses Face ID as an optional app unlock method to protect your data."
            ;;
        6)
            insert_info_key "INFOPLIST_KEY_NSHealthShareUsageDescription" "$APP_NAME reads health data to provide personalized insights."
            insert_info_key "INFOPLIST_KEY_NSHealthUpdateUsageDescription" "$APP_NAME saves data to HealthKit to keep your health information up to date."
            insert_entitlement "com.apple.developer.healthkit" "true"
            ;;
        7)
            insert_info_key "INFOPLIST_KEY_NSHomeKitUsageDescription" "$APP_NAME uses HomeKit to control your smart home accessories."
            insert_entitlement "com.apple.developer.homekit" "true"
            ;;
        8)
            insert_entitlement "com.apple.developer.weatherkit" "true"
            ;;
        9)
            insert_info_key "INFOPLIST_KEY_NSSpeechRecognitionUsageDescription" "$APP_NAME uses speech recognition to convert your voice to text."
            ;;
        10)
            insert_info_key "INFOPLIST_KEY_NSBluetoothAlwaysUsageDescription" "$APP_NAME uses Bluetooth to connect to nearby devices."
            ;;
        11)
            insert_info_key "INFOPLIST_KEY_NSMotionUsageDescription" "$APP_NAME uses motion data to track your activity."
            ;;
        12)
            insert_info_key "INFOPLIST_KEY_NSLocalNetworkUsageDescription" "$APP_NAME uses the local network to discover and connect to nearby devices."
            ;;
        13)
            insert_info_key "INFOPLIST_KEY_NSUserTrackingUsageDescription" "$APP_NAME uses tracking to provide personalized ads and improve the experience."
            ;;
    esac
}

# Interactive multi-select with arrow keys + space + enter
multiselect() {
    local count=${#PERM_LABELS[@]}
    local cursor=0
    local checked=()
    for ((i=0; i<count; i++)); do checked[$i]=0; done

    tput civis
    tput smcup

    draw() {
        tput cup 0 0
        echo -e "${CYAN}${BOLD}  iOS Permissions — $APP_NAME${NC}"
        echo -e "${CYAN}  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo ""
        for ((i=0; i<count; i++)); do
            if [ ${checked[$i]} -eq 1 ]; then
                box="${GREEN}[✓]${NC}"
            else
                box="[ ]"
            fi
            if [ $i -eq $cursor ]; then
                echo -e "  ${CYAN}▶${NC} $box ${BOLD}${PERM_LABELS[$i]}${NC}"
            else
                echo -e "    $box ${PERM_LABELS[$i]}"
            fi
        done
        echo ""
        echo -e "  ${YELLOW}↑↓ move  Space toggle  Enter confirm  q quit${NC}"
    }

    draw
    while true; do
        IFS= read -r -s -n1 key
        if [[ $key == $'\x1b' ]]; then
            read -r -s -n2 rest
            key+="$rest"
        fi
        case "$key" in
            $'\x1b[A'|$'\x1b[D') # up
                ((cursor > 0)) && ((cursor--))
                draw ;;
            $'\x1b[B'|$'\x1b[C') # down
                ((cursor < count-1)) && ((cursor++))
                draw ;;
            ' ') # space toggle
                if [ ${checked[$cursor]} -eq 1 ]; then checked[$cursor]=0; else checked[$cursor]=1; fi
                draw ;;
            '') # enter
                break ;;
            'q'|'Q')
                tput rmcup
                tput cnorm
                echo -e "${YELLOW}Cancelled.${NC}"
                exit 0 ;;
        esac
    done

    tput rmcup
    tput cnorm

    local any=0
    for ((i=0; i<count; i++)); do
        if [ ${checked[$i]} -eq 1 ]; then
            any=1
            echo -e "Adding ${CYAN}${PERM_LABELS[$i]}${NC}..."
            apply_selection "$i"
            echo -e "  ${GREEN}✓ Done${NC}"
        fi
    done

    if [ $any -eq 0 ]; then
        echo -e "${YELLOW}Nothing selected.${NC}"
    else
        echo ""
        echo -e "${GREEN}Complete. Run 'make build' to regenerate the project.${NC}"
    fi
}

multiselect
