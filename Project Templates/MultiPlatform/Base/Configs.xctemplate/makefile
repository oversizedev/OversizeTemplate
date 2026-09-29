# Paths
PROJECT_NAME := ___VARIABLE_productName:RFC1034Identifier___
PROJECT_ROOT := $(CURDIR)
PROJECT_FILE := $(PROJECT_ROOT)/$(PROJECT_NAME).xcodeproj
BUILD_DIR := $(PROJECT_ROOT)/build
DERIVED_DATA := $(HOME)/Library/Developer/Xcode/DerivedData

# XcodeGen spec: local shared packages when present, remote otherwise
SHARED_PACKAGES_DIR := $(HOME)/Developer/Packages
ifeq ($(FORCE_REMOTE_PACKAGES),1)
    XCODEGEN_SPEC := project.yml
else ifneq ($(wildcard $(SHARED_PACKAGES_DIR)/OversizeCore),)
    XCODEGEN_SPEC := project_local.yml
else
    XCODEGEN_SPEC := project.yml
endif

# Schemes
IOS_SCHEME ?= $(PROJECT_NAME) (Dev)

# Destinations
IOS_DESTINATION ?= platform=iOS Simulator,name=iPhone 17e,OS=27.0

BASE ?=

VERBOSE ?= 0
VERSION_TYPE ?= minor
TASK ?=

export TASK

CLAUDE_TEAM_DIR := $(PROJECT_ROOT)/.claude/team/orchestrator

# Color definitions
RED := \033[0;31m
GREEN := \033[0;32m
YELLOW := \033[0;33m
BLUE := \033[0;34m
NC := \033[0m

ifeq ($(VERBOSE),1)
    XCODE_FLAGS :=
    FMT_FLAGS   :=
else
    XCODE_FLAGS := -quiet
    FMT_FLAGS   := --quiet
endif

.PHONY: all init build build-prod compile format lint lint-fix gen gen-icons arch-check init-scripts verify-init permissions clean test run reload open simulator-list up-build up-version review team-run team-resume team-once help

# Default target
all: help

init:
	@if [ -d $(PROJECT_ROOT)/Packages ]; then \
	  echo "$(RED)Already initialized: Packages directory exists.$(NC)"; \
	  exit 1; \
	fi
	@echo "Init project"
	@chmod +x $(PROJECT_ROOT)/scripts/*.sh $(PROJECT_ROOT)/ci_scripts/*.sh $(CLAUDE_TEAM_DIR)/*.sh
	@bash $(PROJECT_ROOT)/scripts/init_packages.sh
	@bash $(PROJECT_ROOT)/scripts/init_packages_files.sh
	@bash $(PROJECT_ROOT)/scripts/init_packages_swiftdata_files.sh
	@bash $(PROJECT_ROOT)/scripts/init_app_tests.sh
	@$(MAKE) build
	@$(MAKE) reload
	@echo "$(GREEN)Init project complete.$(NC)"

build-prod: export FORCE_REMOTE_PACKAGES = 1
build-prod: format arch-check
	@echo "$(YELLOW)Building project for production...$(NC)"
	@xcodegen
	@echo "$(YELLOW)Compiling project...$(NC)"
	@xcodebuild build $(XCODE_FLAGS) \
		-project $(PROJECT_FILE) \
		-scheme "$(IOS_SCHEME)" \
		-destination '$(IOS_DESTINATION)' \
		-derivedDataPath $(BUILD_DIR)
	@echo "$(GREEN)Building complete.$(NC)"

build: format gen arch-check
	@echo "$(YELLOW)Building project...$(NC)"
	@xcodegen --spec $(XCODEGEN_SPEC)
	@echo "$(YELLOW)Compiling project...$(NC)"
	@xcodebuild build $(XCODE_FLAGS) \
		-project $(PROJECT_FILE) \
		-scheme "$(IOS_SCHEME)" \
		-destination '$(IOS_DESTINATION)' \
		-derivedDataPath $(BUILD_DIR)
	@echo "$(GREEN)Building complete.$(NC)"

compile:
	@echo "$(YELLOW)Compiling project...$(NC)"
	@xcodebuild build $(XCODE_FLAGS) \
		-project $(PROJECT_FILE) \
		-scheme "$(IOS_SCHEME)" \
		-destination '$(IOS_DESTINATION)' \
		-derivedDataPath $(BUILD_DIR)
	@echo "$(GREEN)Compile complete.$(NC)"

format:
	@if command -v swiftformat >/dev/null; then \
		echo "$(YELLOW)Formatting Project code...$(NC)"; \
		swiftformat $(FMT_FLAGS) $(PROJECT_ROOT); \
		echo "$(GREEN)Code formatting complete.$(NC)"; \
	else \
		echo "$(YELLOW)swiftformat not installed. Skipping formatting.$(NC)"; \
	fi

lint:
	@echo "$(YELLOW)Linting...$(NC)"
	@swiftlint
	@echo "$(GREEN)Lint complete.$(NC)"

lint-fix:
	@echo "$(YELLOW)Fixing lint issues...$(NC)"
	@swiftlint --fix
	@echo "$(GREEN)Lint fix complete.$(NC)"

gen: gen-icons

gen-icons:
	@echo "$(YELLOW)Generating alternative icon previews...$(NC)"
	@chmod +x $(PROJECT_ROOT)/scripts/generate_alt_icons.sh
	@$(PROJECT_ROOT)/scripts/generate_alt_icons.sh
	@echo "$(GREEN)Icon previews generation complete.$(NC)"

arch-check:
	@chmod +x $(PROJECT_ROOT)/scripts/check_architecture.sh
	@$(PROJECT_ROOT)/scripts/check_architecture.sh $(PROJECT_ROOT)

init-scripts:
	@python3 $(PROJECT_ROOT)/scripts/generate_init_scripts.py $(PROJECT_ROOT)

verify-init:
	@bash $(PROJECT_ROOT)/scripts/verify_init.sh $(PROJECT_ROOT)

permissions:
	@chmod +x $(PROJECT_ROOT)/scripts/add_permissions.sh
	@$(PROJECT_ROOT)/scripts/add_permissions.sh $(PROJECT_ROOT) $(PROJECT_NAME)

up-build:
	@BUILD=$$(grep 'CURRENT_PROJECT_VERSION:' $(PROJECT_ROOT)/Configs/Settings.yml | awk '{print $$2}'); \
	NEW=$$((BUILD + 1)); \
	sed -i '' "s/CURRENT_PROJECT_VERSION: $$BUILD/CURRENT_PROJECT_VERSION: $$NEW/" $(PROJECT_ROOT)/Configs/Settings.yml; \
	echo "$(GREEN)Build number: $$BUILD → $$NEW$(NC)"
	@xcodegen --spec $(XCODEGEN_SPEC)
	@echo "$(YELLOW)Compiling project...$(NC)"
	@xcodebuild build $(XCODE_FLAGS) \
		-project $(PROJECT_FILE) \
		-scheme "$(IOS_SCHEME)" \
		-destination '$(IOS_DESTINATION)' \
		-derivedDataPath $(BUILD_DIR)
	@echo "$(GREEN)Up build complete.$(NC)"

up-version:
	@VER=$$(grep 'MARKETING_VERSION:' $(PROJECT_ROOT)/Configs/Settings.yml | awk '{print $$2}'); \
	MAJOR=$$(echo $$VER | cut -d. -f1); \
	MINOR=$$(echo $$VER | cut -d. -f2); \
	PATCH=$$(echo $$VER | cut -d. -f3); PATCH=$${PATCH:-0}; \
	if [ "$(VERSION_TYPE)" = "major" ]; then \
		MAJOR=$$((MAJOR + 1)); MINOR=0; PATCH=0; \
	elif [ "$(VERSION_TYPE)" = "minor" ]; then \
		MINOR=$$((MINOR + 1)); PATCH=0; \
	else \
		PATCH=$$((PATCH + 1)); \
	fi; \
	if [ "$$PATCH" = "0" ]; then NEW="$$MAJOR.$$MINOR"; else NEW="$$MAJOR.$$MINOR.$$PATCH"; fi; \
	sed -i '' "s/MARKETING_VERSION: $$VER/MARKETING_VERSION: $$NEW/" $(PROJECT_ROOT)/Configs/Settings.yml; \
	echo "$(GREEN)Version: $$VER → $$NEW$(NC)"
	@xcodegen --spec $(XCODEGEN_SPEC)
	@echo "$(YELLOW)Compiling project...$(NC)"
	@xcodebuild build $(XCODE_FLAGS) \
		-project $(PROJECT_FILE) \
		-scheme "$(IOS_SCHEME)" \
		-destination '$(IOS_DESTINATION)' \
		-derivedDataPath $(BUILD_DIR)
	@echo "$(GREEN)Up version complete.$(NC)"

review:
	@if [ -z "$(BASE)" ]; then \
		echo "$(YELLOW)Reviewing uncommitted changes...$(NC)"; \
		codex review --uncommitted 2>/dev/null \
			|| { echo "$(RED)codex review failed. Rerun: codex review --uncommitted$(NC)"; exit 1; }; \
	else \
		git fetch --quiet origin "$(BASE)" \
			|| { echo "$(RED)Cannot fetch origin/$(BASE): check the BASE branch name and git access to origin.$(NC)"; exit 1; }; \
		echo "$(YELLOW)Reviewing branch diff against origin/$(BASE)...$(NC)"; \
		codex review --base "origin/$(BASE)" 2>/dev/null \
			|| { echo "$(RED)codex review failed. Rerun: codex review --base origin/$(BASE)$(NC)"; exit 1; }; \
	fi

team-run:
	@if [ -z "$$TASK" ]; then \
		echo "$(RED)TASK is required. Usage: make team-run TASK=\"Describe the task\"$(NC)"; \
		exit 64; \
	fi
	@bash $(CLAUDE_TEAM_DIR)/team-run.sh "$$TASK"

team-resume:
	@bash $(CLAUDE_TEAM_DIR)/team-orchestrator.sh

team-once:
	@bash $(CLAUDE_TEAM_DIR)/team-orchestrator.sh --once

clean:
	@echo "$(YELLOW)Cleaning build artifacts...$(NC)"
	@rm -rf $(BUILD_DIR)
	@rm -rf $(DERIVED_DATA)/$(PROJECT_NAME)-*
	@echo "$(GREEN)Clean complete.$(NC)"

test:
	@echo "$(YELLOW)Running tests...$(NC)"
	@xcodebuild test $(XCODE_FLAGS) -project $(PROJECT_FILE) -scheme "$(IOS_SCHEME)" \
		-destination '$(IOS_DESTINATION)' \
		-derivedDataPath $(BUILD_DIR)
	@echo "$(GREEN)Tests complete.$(NC)"

run:
	@echo "$(YELLOW)Building and running in simulator...$(NC)"
	@xcodebuild $(XCODE_FLAGS) -project $(PROJECT_FILE) -scheme "$(IOS_SCHEME)" \
		-destination '$(IOS_DESTINATION)' \
		-derivedDataPath $(BUILD_DIR)
	@echo "$(YELLOW)Installing and launching app...$(NC)"
	@set -e; \
	BUILD_SETTINGS=$$(xcodebuild -showBuildSettings \
		-project $(PROJECT_FILE) \
		-scheme "$(IOS_SCHEME)" \
		-destination '$(IOS_DESTINATION)' \
		-derivedDataPath $(BUILD_DIR)); \
	APP_PRODUCTS_DIR=$$(printf '%s\n' "$$BUILD_SETTINGS" | grep -E '^[[:space:]]*BUILT_PRODUCTS_DIR =' | sed -E 's/^[[:space:]]*BUILT_PRODUCTS_DIR = //' | head -1); \
	APP_BUNDLE_ID=$$(printf '%s\n' "$$BUILD_SETTINGS" | grep -E '^[[:space:]]*PRODUCT_BUNDLE_IDENTIFIER =' | sed -E 's/^[[:space:]]*PRODUCT_BUNDLE_IDENTIFIER = //' | head -1); \
	if [ -z "$$APP_PRODUCTS_DIR" ] || [ -z "$$APP_BUNDLE_ID" ]; then \
		echo "$(RED)Could not resolve BUILT_PRODUCTS_DIR / PRODUCT_BUNDLE_IDENTIFIER for scheme: $(IOS_SCHEME)$(NC)"; \
		exit 1; \
	fi; \
	APP_PATH="$$APP_PRODUCTS_DIR/$(PROJECT_NAME).app"; \
	DEST_ID=$$(printf '%s' "$(IOS_DESTINATION)" | grep -oE 'id=[^,]+' | cut -d= -f2); \
	if [ -n "$$DEST_ID" ]; then \
		UDID="$$DEST_ID"; \
	else \
		SIM_NAME=$$(printf '%s' "$(IOS_DESTINATION)" | grep -oE 'name=[^,]+' | cut -d= -f2-); \
		SIM_OS=$$(printf '%s' "$(IOS_DESTINATION)" | grep -oE 'OS=[^,]+' | cut -d= -f2); \
		UDID=$$(xcrun simctl list devices available | awk -v os="$$SIM_OS" -v name="$$SIM_NAME" '\
			/^-- / { \
				if ($$0 ~ /^-- iOS /) { cur = $$0; sub(/^-- iOS /, "", cur); sub(/ --$$/, "", cur) } \
				else { cur = "" } \
				next \
			} \
			cur == "" { next } \
			{ \
				if (!match($$0, /\([0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}\)/)) next; \
				devName = substr($$0, 1, RSTART - 2); \
				sub(/^[ \t]+/, "", devName); \
				if (devName != name) next; \
				if (os != "" && os != "latest") { \
					if (cur == os) print; \
				} else { \
					split(cur, v, "."); \
					verNum = v[1] * 1000 + (v[2] == "" ? 0 : v[2]); \
					if (verNum > bestVer) { bestVer = verNum; bestLine = $$0 } \
				} \
			} \
			END { if ((os == "" || os == "latest") && bestLine != "") print bestLine }' \
			| grep -oE '[A-F0-9]{8}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{12}' | head -1); \
	fi; \
	if [ -n "$$UDID" ]; then \
		xcrun simctl bootstatus "$$UDID" -b; \
		xcrun simctl install "$$UDID" "$$APP_PATH"; \
		xcrun simctl launch "$$UDID" "$$APP_BUNDLE_ID"; \
		XCODE_PATH=$$(xcode-select -p); \
		if [ -d "$$XCODE_PATH/Applications/Simulator.app" ]; then \
			open -a "$$XCODE_PATH/Applications/Simulator.app" --args -CurrentDeviceUDID "$$UDID"; \
		elif [ -d "/Applications/Xcode.app/Contents/Developer/Applications/Simulator.app" ]; then \
			open -a "/Applications/Xcode.app/Contents/Developer/Applications/Simulator.app" --args -CurrentDeviceUDID "$$UDID"; \
		elif [ -d "$$(dirname "$$XCODE_PATH")/Applications/DeviceHub.app" ]; then \
			open "$$(dirname "$$XCODE_PATH")/Applications/DeviceHub.app"; \
		else \
			echo "$(YELLOW)Warning: Could not find Simulator or DeviceHub app$(NC)"; \
		fi; \
	else \
		echo "$(RED)Could not find simulator matching IOS_DESTINATION: $(IOS_DESTINATION)$(NC)"; \
		exit 1; \
	fi
	@echo "$(GREEN)Run complete.$(NC)"

reload:
	@echo "🔄 Reload Xcode..."
	@osascript -e 'tell application "Xcode" to quit' 2>/dev/null || true
	@sleep 2
	@open $(PROJECT_FILE)

open:
	@open $(PROJECT_FILE)

simulator-list:
	@echo "$(BLUE)Available iOS Simulators:$(NC)"
	@xcrun simctl list devices available | grep -E "(iPhone|iPad)"

# Help
help:
	@echo "$(PROJECT_NAME) Makefile"
	@echo ""
	@echo "Available targets:"
	@echo "  init         - Create local dependencies and initialize project"
	@echo "  build        - Format, check architecture and build (local shared packages if present, remote otherwise)"
	@echo "  build-prod   - Format code and build the project for production with remote dependencies"
	@echo "  compile      - Compile project only (no format/gen, Xcode Cmd+B equivalent)"
	@echo "  format       - Format code in Packages and Project directories"
	@echo "  lint         - Run SwiftLint"
	@echo "  lint-fix     - Run SwiftLint with auto-fix"
	@echo "  gen          - Run project code generation (alternative icon previews)"
	@echo "  gen-icons    - Generate alternative icon previews from .icon files"
	@echo "  arch-check   - Check forbidden imports between layers"
	@echo "  init-scripts - Regenerate scripts/init_*.sh from the current Packages"
	@echo "  verify-init  - Check that init scripts reproduce the current Packages"
	@echo "  permissions  - Interactively add iOS permission usage descriptions to Targets.yml"
	@echo "  clean        - Clean build artifacts (build directory and DerivedData)"
	@echo "  test         - Run tests in iOS Simulator"
	@echo "  run          - Build and run the project in iOS Simulator"
	@echo "  reload       - Reload Xcode project"
	@echo "  open         - Open project in Xcode"
	@echo "  simulator-list - Show available iOS simulators"
	@echo "  up-build     - Increment build number (CURRENT_PROJECT_VERSION) and rebuild"
	@echo "  up-version   - Bump app version (MARKETING_VERSION), TYPE=patch|minor|major (default: minor)"
	@echo "  review       - Codex review of uncommitted changes; BASE=<branch> reviews the branch diff vs origin/<branch>"
	@echo "  team-run     - Plan and execute a new Claude team task (requires TASK=\"...\")"
	@echo "  team-resume  - Resume all Ready Issues in the Claude team queue"
	@echo "  team-once    - Execute exactly one Ready Issue from the Claude team queue"
	@echo "  help         - Show this help message"
	@echo ""
	@echo "Parameters:"
	@echo "  VERBOSE=1    - Show full xcodebuild/swiftformat output (default: quiet)"
	@echo "  IOS_DESTINATION=... - Override the xcodebuild destination (default: $(IOS_DESTINATION))"
	@echo "  TASK=...            - Describe a new task for the team-run target"
	@echo "  BASE=...            - Base branch for make review (branch diff against origin/BASE)"
	@echo ""
	@echo "Current Date and Time (UTC): $(shell date '+%Y-%m-%d %H:%M:%S')"
	@echo "Current User's Login: $(shell whoami)"
