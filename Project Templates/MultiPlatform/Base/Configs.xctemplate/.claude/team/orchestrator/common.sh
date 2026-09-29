#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/config.sh"

log() {
  printf '[agent-team] %s\n' "$*"
}

fail() {
  printf '[agent-team] ERROR: %s\n' "$*" >&2
  exit 1
}

require_command() {
  command -v "$1" >/dev/null 2>&1 || fail "Required command not found: $1"
}

repo_root() {
  git rev-parse --show-toplevel 2>/dev/null || fail "Run this command inside the ___PACKAGENAME___ git repository"
}

ensure_clean_worktree() {
  if [ -n "$(git status --porcelain)" ]; then
    fail "Working tree is not clean. Commit/stash/remove local changes before autonomous execution."
  fi
}

ensure_prerequisites() {
  require_command git
  require_command gh
  require_command jq
  require_command claude
  repo_root >/dev/null
  gh auth status >/dev/null 2>&1 || fail "GitHub CLI is not authenticated"
  mkdir -p "$RUNTIME_DIR/logs"
}

PROJECT_NODE_ID=""
STATUS_FIELD_ID=""
STATUS_OPTIONS_JSON=""

load_project_status_field() {
  [ -n "$PROJECT_NODE_ID" ] && return 0
  PROJECT_NODE_ID="$(gh project view "$PROJECT_NUMBER" --owner "$PROJECT_OWNER" --format json --jq '.id')"
  local status_field
  status_field="$(gh project field-list "$PROJECT_NUMBER" --owner "$PROJECT_OWNER" --format json \
    --jq '.fields[] | select(.name == "Status")')"
  STATUS_FIELD_ID="$(printf '%s' "$status_field" | jq -r '.id // empty')"
  STATUS_OPTIONS_JSON="$(printf '%s' "$status_field" | jq -c '.options // []')"
  if [ -z "$PROJECT_NODE_ID" ] || [ -z "$STATUS_FIELD_ID" ]; then
    log "ERROR: project #$PROJECT_NUMBER or its Status field not found for owner $PROJECT_OWNER"
    PROJECT_NODE_ID=""
    return 1
  fi
}

project_item_id() {
  local issue_url="$1"
  local item_id
  item_id="$(gh project item-list "$PROJECT_NUMBER" --owner "$PROJECT_OWNER" --limit 500 --format json \
    | jq -r --arg url "$issue_url" '.items[] | select(.content.url == $url) | .id' | head -n 1)"
  if [ -z "$item_id" ]; then
    item_id="$(gh project item-add "$PROJECT_NUMBER" --owner "$PROJECT_OWNER" --url "$issue_url" --format json --jq '.id')"
  fi
  printf '%s' "$item_id"
}

set_project_status() {
  local issue_url="$1"
  local status="$2"
  load_project_status_field || return 1

  local option_id item_id
  option_id="$(printf '%s' "$STATUS_OPTIONS_JSON" | jq -r --arg name "$status" '.[] | select(.name == $name) | .id')"
  if [ -z "$option_id" ]; then
    log "ERROR: Status option '$status' not found in project #$PROJECT_NUMBER"
    return 1
  fi

  item_id="$(project_item_id "$issue_url")"
  if [ -z "$item_id" ]; then
    log "ERROR: could not find or add $issue_url to project #$PROJECT_NUMBER"
    return 1
  fi

  gh project item-edit \
    --id "$item_id" \
    --project-id "$PROJECT_NODE_ID" \
    --field-id "$STATUS_FIELD_ID" \
    --single-select-option-id "$option_id" >/dev/null
}

issue_state() {
  local number="$1"
  gh issue view "$number" --repo "$REPO" --json state --jq '.state'
}

issue_url() {
  local number="$1"
  gh issue view "$number" --repo "$REPO" --json url --jq '.url'
}

promote_unblocked() {
  local urls
  urls="$(gh project item-list "$PROJECT_NUMBER" \
    --owner "$PROJECT_OWNER" \
    --limit 200 \
    --query "status:Backlog label:$AUTO_LABEL label:$TASK_LABEL is:issue is:open" \
    --format json \
    --jq '.items[] | select(.content.type == "Issue") | .content.url')"

  [ -z "$urls" ] && return 0

  while IFS= read -r url; do
    [ -z "$url" ] && continue

    local number body dep_line ready token dep_number state
    number="${url##*/}"
    body="$(gh issue view "$number" --repo "$REPO" --json body --jq '.body')"
    dep_line="$(printf '%s\n' "$body" | sed -n 's/^Depends-On:[[:space:]]*//p' | head -n 1)"

    if [ -z "$dep_line" ]; then
      log "Issue #$number stays Backlog: missing Depends-On metadata"
      continue
    fi

    if [ "$dep_line" = "none" ]; then
      log "Promoting #$number → Ready"
      set_project_status "$url" "Ready"
      continue
    fi

    ready=1
    for token in $dep_line; do
      dep_number="${token#\#}"
      case "$dep_number" in
        ''|*[!0-9]*)
          ready=0
          log "Issue #$number has malformed dependency token: $token"
          break
          ;;
      esac
      state="$(issue_state "$dep_number" 2>/dev/null || printf 'UNKNOWN')"
      if [ "$state" != "CLOSED" ]; then
        ready=0
        break
      fi
    done

    if [ "$ready" -eq 1 ]; then
      log "Dependencies satisfied for #$number → Ready"
      set_project_status "$url" "Ready"
    fi
  done <<EOF_URLS
$urls
EOF_URLS
}

epic_children() {
  local epic="$1"
  local state="$2"
  gh issue list --repo "$REPO" --label "$TASK_LABEL" --state "$state" --limit 500 --json number,body \
    | jq -r --arg line "Epic: #$epic" \
      '.[] | select((.body // "") | split("\n") | map(sub("\r$"; "") | sub("^\\s+"; "") | sub("\\s+$"; "")) | index($line)) | .number'
}

finalize_epics() {
  local epic_numbers
  epic_numbers="$(gh issue list --repo "$REPO" --label "$EPIC_LABEL" --state open --limit 100 --json number --jq '.[].number')"
  [ -z "$epic_numbers" ] && return 0

  while IFS= read -r epic; do
    [ -z "$epic" ] && continue

    local all_children open_children epic_url
    all_children="$(epic_children "$epic" all)"

    [ -z "$all_children" ] && continue

    open_children="$(epic_children "$epic" open)"

    if [ -z "$open_children" ]; then
      epic_url="$(issue_url "$epic")"
      log "All child Issues for Epic #$epic are closed → Done"
      set_project_status "$epic_url" "Done" || true
      gh issue close "$epic" --repo "$REPO" --comment "All automated child issues are complete." >/dev/null || true
    fi
  done <<EOF_EPICS
$epic_numbers
EOF_EPICS
}

next_ready_issue_url() {
  gh project item-list "$PROJECT_NUMBER" \
    --owner "$PROJECT_OWNER" \
    --limit 200 \
    --query "status:Ready label:$AUTO_LABEL label:$TASK_LABEL is:issue is:open" \
    --format json \
    --jq '.items[] | select(.content.type == "Issue") | .content.url' \
    | head -n 1
}

open_auto_task_count() {
  gh issue list --repo "$REPO" \
    --label "$AUTO_LABEL" \
    --label "$TASK_LABEL" \
    --state open \
    --limit 500 \
    --json number \
    --jq 'length'
}

issue_project_status() {
  local target_url="$1"
  gh project item-list "$PROJECT_NUMBER" \
    --owner "$PROJECT_OWNER" \
    --limit 200 \
    --format json \
    --jq ".items[] | select(.content.url == \"$target_url\") | .status // \"\"" \
    | head -n 1
}

held_issue_count() {
  gh project item-list "$PROJECT_NUMBER" \
    --owner "$PROJECT_OWNER" \
    --limit 200 \
    --query "status:Hold label:$AUTO_LABEL label:$TASK_LABEL is:issue is:open" \
    --format json \
    --jq '[.items[] | select(.content.type == "Issue")] | length'
}

held_issue_report() {
  gh project item-list "$PROJECT_NUMBER" \
    --owner "$PROJECT_OWNER" \
    --limit 200 \
    --query "status:Hold label:$AUTO_LABEL label:$TASK_LABEL is:issue is:open" \
    --format json \
    --jq '.items[] | select(.content.type == "Issue") | "#\(.content.number) \(.title)"'
}
