#!/usr/bin/env bash
set -euo pipefail

defaults write com.apple.dt.Xcode IDESkipPackagePluginFingerprintValidatation -bool YES
defaults write com.apple.dt.Xcode IDESkipMacroFingerprintValidation -bool YES

if ! command -v xcodegen &> /dev/null; then
    echo "Installing xcodegen..."
    brew install xcodegen
fi

echo "Generate Project"
cd "${CI_PRIMARY_REPOSITORY_PATH:-$(dirname "$0")/..}"
FORCE_REMOTE_PACKAGES=1 xcodegen --spec project.yml
