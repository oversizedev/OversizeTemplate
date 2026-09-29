#!/usr/bin/env python3
# Regenerates the "Items with Categories List iCloud" file template from the
# Recurio reference project by reverse variable substitution.
# Usage: python3 scripts/generate_file_template.py [path-to-recurio]
#
# NOTE: Recurio main diverged into a product-specific domain after its issue #6
# (billing cycles, payment methods, service APIs beyond generic CRUD). The last
# generic reference state is Recurio commit 55f3342; since then the template is
# maintained directly (service layer ported in-place, see OversizeTemplate #19),
# so rerunning this script against Recurio main would overwrite that work.
import shutil
import sys
from pathlib import Path

RECURIO = Path(sys.argv[1]) if len(sys.argv) > 1 else Path.home() / "Developer/Recurio"
TEMPLATE = (
    Path(__file__).resolve().parent.parent
    / "File Templates/SwiftData/Items with Categories List iCloud.xctemplate/___VARIABLE_modelName___"
)

shutil.rmtree(TEMPLATE, ignore_errors=True)

SUBS = [
    ("subscriptionCategories", "___VARIABLE_categoryPluralVariableName___"),
    ("SubscriptionCategory", "___VARIABLE_categoryName___"),
    ("subscriptionCategory", "___VARIABLE_categoryVariableName___"),
    ("subscriptions", "___VARIABLE_modelPluralVariableName___"),
    ("Subscription", "___VARIABLE_modelName___"),
    ("subscription", "___VARIABLE_modelVariableName___"),
    ("import Database", "import ___VARIABLE_modelPackage___"),
]


def substitute(text: str) -> str:
    for old, new in SUBS:
        text = text.replace(old, new)
    return text


def strip_header(text: str) -> str:
    lines = text.split("\n")
    if (
        len(lines) > 4
        and lines[0] == "//"
        and lines[1].startswith("// Copyright")
        and lines[3] == "//"
    ):
        return "// ___FILEHEADER___\n" + "\n".join(lines[4:])
    sys.exit(f"unexpected header: {lines[:4]}")


def emit(src_text: str, dest_rel: str) -> None:
    dest = TEMPLATE / dest_rel
    dest.parent.mkdir(parents=True, exist_ok=True)
    dest.write_text(substitute(strip_header(src_text)))


def emit_file(src_rel: str, dest_dir: str) -> None:
    src = RECURIO / src_rel
    emit(src.read_text(), f"{dest_dir}/{substitute(src.name)}")


SCREENS = [
    "SubscriptionList",
    "SubscriptionDetail",
    "SubscriptionEdit",
    "SubscriptionCategoryList",
    "SubscriptionCategoryDetail",
    "SubscriptionCategoryEdit",
]

for screen in SCREENS:
    base = RECURIO / "Packages/App/Sources/Main" / screen
    for src in sorted(base.rglob("*.swift")):
        rel_dir = src.parent.relative_to(base)
        dest_dir = Path("Screens") / substitute(screen) / rel_dir
        emit(src.read_text(), f"{dest_dir}/{substitute(src.name)}")

for name in ["Subscription.swift", "SubscriptionCategory.swift"]:
    emit_file(f"Packages/Models/Sources/Models/{name}", "Models")
for name in ["SubscriptionSortType.swift", "SubscriptionCategorySortType.swift"]:
    emit_file(f"Packages/Models/Sources/Models/Types/{name}", "Models/Types")

DB = "Packages/Database/Sources/Database"
for name in ["SubscriptionEntity.swift", "SubscriptionCategoryEntity.swift"]:
    emit_file(f"{DB}/Entities/{name}", "Database/Entities")
for name in [
    "SubscriptionMapping.swift",
    "SubscriptionCategoryMapping.swift",
    "SubscriptionSortDescriptors.swift",
]:
    emit_file(f"{DB}/Mapping/{name}", "Database/Mapping")
for name in ["SubscriptionStorageService.swift", "SubscriptionCategoryStorageService.swift"]:
    emit_file(f"{DB}/Services/{name}", "Database/Services")
for name in ["SubscriptionStorageInjection.swift", "SubscriptionCategoryStorageInjection.swift"]:
    emit_file(f"{DB}/Injection/{name}", "Database/Injection")

emit_file(
    "Packages/Env/Sources/Env/Destinations/SubscriptionDestinations.swift",
    "Env/Destinations",
)
emit_file(
    "Recurio/Navigation/Destinations/SubscriptionDestinations.swift",
    "Navigation/Destinations",
)

main_stack = (RECURIO / "Recurio/Navigation/Stacks/MainNavigationStack.swift").read_text()
stack = main_stack.replace(
    "                .navigationAutoReceive(MainDestinations.self)\n", ""
).replace("MainNavigationStack", "SubscriptionNavigationStack")
emit(stack, "Navigation/Stacks/___VARIABLE_modelName___NavigationStack.swift")

for name in [
    "SubscriptionListViewModelTests.swift",
    "SubscriptionDetailViewModelTests.swift",
    "SubscriptionEditViewModelTests.swift",
    "SubscriptionCategoryListViewModelTests.swift",
    "SubscriptionCategoryDetailViewModelTests.swift",
    "SubscriptionCategoryEditViewModelTests.swift",
    "TestSupport.swift",
]:
    emit_file(f"Packages/App/Tests/MainTests/{name}", "Tests/MainTests")
for name in ["SubscriptionStorageServiceTests.swift", "SubscriptionCategoryStorageServiceTests.swift"]:
    emit_file(f"Packages/Database/Tests/DatabaseTests/{name}", "Tests/DatabaseTests")

count = len(list(TEMPLATE.rglob("*.swift")))
print(f"generated {count} swift files under {TEMPLATE}")
