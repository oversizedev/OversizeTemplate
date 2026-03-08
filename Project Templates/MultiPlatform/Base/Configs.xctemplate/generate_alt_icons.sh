#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
APP_FOLDER=$(find "$PROJECT_ROOT" -maxdepth 3 -name "Assets.xcassets" -path "*/Resources/*" 2>/dev/null | head -1 | sed 's|/Resources/Assets.xcassets||')
ICONS_DIR="$APP_FOLDER/Resources/Icons"
ALT_ICONS_DIR="$APP_FOLDER/Resources/AltIcons"
ASSETS_DIR="$APP_FOLDER/Resources/Assets.xcassets"
ICTOOL_PATH="/Applications/Xcode.app/Contents/Applications/Icon Composer.app/Contents/Executables/ictool"

YELLOW='\033[1;33m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${YELLOW}Starting icon preview generation...${NC}"

if [ ! -f "$ICTOOL_PATH" ]; then
    echo -e "${RED}Error: ictool not found at $ICTOOL_PATH${NC}"
    echo -e "${RED}Please make sure Xcode is installed with Icon Composer.${NC}"
    exit 1
fi

if [ ! -d "$ASSETS_DIR" ]; then
    echo -e "${RED}Error: Assets directory not found at $ASSETS_DIR${NC}"
    exit 1
fi

process_icons_directory() {
    local source_dir="$1"
    local group_name="$2"

    if [ ! -d "$source_dir" ]; then
        echo -e "${YELLOW}Skipping $group_name (directory not found: $source_dir)${NC}"
        return
    fi

    echo -e "${YELLOW}Scanning for .icon files in $source_dir${NC}"

    local icons_group="$ASSETS_DIR/$group_name"
    mkdir -p "$icons_group"

    if [ ! -f "$icons_group/Contents.json" ]; then
        echo "  Creating $group_name group..."
        cat > "$icons_group/Contents.json" << EOF
{
  "info" : {
    "author" : "xcode",
    "version" : 1
  }
}
EOF
    fi

    for icon_dir in "$source_dir"/*.icon; do
        if [ ! -d "$icon_dir" ]; then
            continue
        fi

        icon_name=$(basename "$icon_dir" .icon)
        echo -e "${YELLOW}Processing $icon_name...${NC}"

        imageset_dir="$icons_group/${icon_name}.imageset"
        mkdir -p "$imageset_dir"

        echo "  Generating @2x (156x156)..."
        "$ICTOOL_PATH" "$icon_dir" --export-image \
            --output-file "$imageset_dir/${icon_name}@2x.png" \
            --platform iOS --rendition Default \
            --width 78 --height 78 --scale 2

        echo "  Generating @3x (234x234)..."
        "$ICTOOL_PATH" "$icon_dir" --export-image \
            --output-file "$imageset_dir/${icon_name}@3x.png" \
            --platform iOS --rendition Default \
            --width 78 --height 78 --scale 3

        echo "  Creating Contents.json..."
        cat > "$imageset_dir/Contents.json" << EOF
{
  "images" : [
    {
      "filename" : "${icon_name}@2x.png",
      "idiom" : "universal",
      "scale" : "2x"
    },
    {
      "filename" : "${icon_name}@3x.png",
      "idiom" : "universal",
      "scale" : "3x"
    }
  ],
  "info" : {
    "author" : "xcode",
    "version" : 1
  }
}
EOF

        echo -e "${GREEN}  ✓ ${icon_name} created${NC}"
    done
}

process_icons_directory "$ICONS_DIR" "Icons"
process_icons_directory "$ALT_ICONS_DIR" "AltIcons"

echo -e "${GREEN}Icon preview generation complete!${NC}"
