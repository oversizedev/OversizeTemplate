# Base directory for packages
PACKAGES_DIR := ~/Developer/Packages
PROJECT_NAME := ___VARIABLE_productName:RFC1034Identifier___
PROJECT_ROOT := ~/Developer/$(PROJECT_NAME)

# Color definitions
RED := \033[0;31m
GREEN := \033[0;32m
YELLOW := \033[0;33m
NC := \033[0m

# Default target
all: help

init:
	@echo "Init project"
	@chmod +x $(PROJECT_ROOT)/scripts/init_packages.sh
	@chmod +x $(PROJECT_ROOT)/scripts/init_packages_files.sh
	@$(PROJECT_ROOT)/scripts/init_packages.sh
	@$(PROJECT_ROOT)/scripts/init_packages_files.sh
	@$(MAKE) gen
	@$(MAKE) build
	@$(MAKE) rerun
	@echo "$(GREEN)Init project complete.$(NC)"

build: format gen
	@echo "$(YELLOW)Building project...$(NC)"
	$(PROJECT_ROOT)/scripts/build.sh
	@xcodegen
	@echo "$(GREEN)Building complete.$(NC)"
	
build-local: format gen
	@echo "$(YELLOW)Building project...$(NC)"
	$(PROJECT_ROOT)/scripts/build_local.sh
	@xcodegen --spec project_local.yml
	@echo "$(GREEN)Building complete.$(NC)"
	
format:
	@echo "$(YELLOW)Formatting Packages code...$(NC)"
	@swiftformat $(PACKAGES_DIR)
	@echo "$(YELLOW)Formatting Project code...$(NC)"
	@swiftformat $(PROJECT_ROOT)
	@echo "$(GREEN)Code formatting complete.$(NC)"
	
gen:
	@echo "$(YELLOW)Generating network...$(NC)"
	@cd $(PACKAGES_DIR)/OversizeNetwork && swift package plugin --allow-writing-to-package-directory generate-code-from-openapi
	@echo "$(YELLOW)Generating resources...$(NC)"
	@cd $(PACKAGES_DIR)/OversizeResources && swiftgen config run
	@echo "$(GREEN)Code generation complete.$(NC)"


rerun:
	@echo "🔄 Reload Xcode..."
	@osascript -e 'tell application "Xcode" to quit'
	@sleep 2
	@open $(PROJECT_NAME).xcodeproj

# Help
help:
	@echo "$(PROJECT_NAME) Makefile"
	@echo ""
	@echo "Available targets:"
	@echo "  init         - Create local dependencies and initialize project"
	@echo "  build        - Format code and build the project"
	@echo "  build-local  - Format code and build the project with local configuration"
	@echo "  format       - Format code in Packages and Project directories"
	@echo "  gen          - Generate network code from OpenAPI spec and resources with SwiftGen"
	@echo "  help         - Show this help message"
	@echo ""
	@echo "Current Date and Time (UTC): $(shell date '+%Y-%m-%d %H:%M:%S')"
	@echo "Current User's Login: $(shell whoami)"
