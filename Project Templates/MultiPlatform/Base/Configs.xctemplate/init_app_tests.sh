#!/bin/bash

set -euo pipefail

YEAR="${INIT_YEAR:-$(date +%Y)}"
TODAY="${INIT_DATE:-$(date +%d.%m.%Y)}"

UI_TESTS_DIR="___VARIABLE_productName:RFC1034Identifier___UITests"
UI_TESTS_FILE="$UI_TESTS_DIR/___PACKAGENAME:identifier___UITests.swift"

rm -rf "___PACKAGENAME___Tests" "___PACKAGENAME___UITests" "$UI_TESTS_DIR"
mkdir -p "$UI_TESTS_DIR"

cat <<PACKAGE_FILE_EOF >"$UI_TESTS_FILE"
//
// Copyright © $YEAR ___FULLUSERNAME___
// ___PACKAGENAME:identifier___UITests.swift, created on $TODAY
//

import XCTest

final class ___PACKAGENAME:identifier___UITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testLaunchShowsOnboardingOrMain() {
        let app = XCUIApplication()
        app.launch()

        let onboardingButton = app.buttons["Get Started"]
        let mainNavigationBar = app.navigationBars["Main"]
        let mainButton = app.buttons["Main"]
        let isVisible = onboardingButton.waitForExistence(timeout: 10)
            || mainNavigationBar.waitForExistence(timeout: 5)
            || mainButton.waitForExistence(timeout: 5)

        XCTAssertTrue(isVisible)
    }
}
PACKAGE_FILE_EOF
