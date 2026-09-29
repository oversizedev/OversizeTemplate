#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/common.sh"

MODE="all"
if [ "${1:-}" = "--once" ]; then
  MODE="once"
elif [ -n "${1:-}" ]; then
  fail "Usage: $0 [--once]"
fi

ensure_prerequisites
cd "$(repo_root)"
ensure_clean_worktree

log "Queue runner started for $REPO / Project #$PROJECT_NUMBER"

while true; do
  promote_unblocked
  finalize_epics

  ready_url="$(next_ready_issue_url)"
  if [ -z "$ready_url" ]; then
    remaining="$(open_auto_task_count)"
    if [ "$remaining" -gt 0 ]; then
      held="$(held_issue_count || true)"
      held="${held:-0}"
      if [ "$held" -ge "$remaining" ]; then
        log "No Ready Issues. All $remaining remaining automated task(s) are on Hold, waiting for manual unblock:"
        held_issue_report | while IFS= read -r held_line; do log "  $held_line"; done
        log "Resolve the blockers and move the Issues back to Ready to resume the queue."
        exit 0
      fi

      log "No Ready Issues, but $((remaining - held)) automated task(s) remain open outside Hold. Queue is blocked or has a dependency cycle."
      if [ "$held" -gt 0 ]; then
        log "Additionally on Hold:"
        held_issue_report | while IFS= read -r held_line; do log "  $held_line"; done
      fi
      exit 2
    fi

    finalize_epics
    log "Automated queue is empty."
    exit 0
  fi

  issue_number="${ready_url##*/}"
  timestamp="$(date '+%Y%m%d-%H%M%S')"
  log_file="$RUNTIME_DIR/logs/issue-${issue_number}-${timestamp}.log"

  ensure_clean_worktree
  log "Starting fresh Team Lead session for Issue #$issue_number"

  prompt=$(cat <<EOF_PROMPT
MODE: EXECUTE_ISSUE

Execute GitHub Issue #$issue_number in repository $REPO through the complete ___PACKAGENAME___ workflow.

Hard requirements:
- Work ONLY on Issue #$issue_number. Do not pick another Ready/Backlog Issue after merge.
- This is a disposable Team Lead session. Persistent state belongs in GitHub/git.
- Read .claude/team/WORKFLOW.md and .claude/team/TEAM_LEAD.md first.
- Every role invocation must start a fresh agent session. Never resume a completed subagent with SendMessage.
- Use Agent Team only for simultaneous workers that need direct peer-to-peer coordination; otherwise use one-shot subagents.
- Reviewers and QA return a verdict and terminate; fixes use a new developer and then new reviewers/QA.
- Finish only after the Issue is merged/closed and Project status is Done. If blocked by an external dependency or an untestable environment, set Project status to Hold, leave a "Blocked:" comment in the Issue, and stop.
- Do not start the next Issue. The external orchestrator owns the queue.
EOF_PROMPT
)

  set +e
  claude -p \
    --agent team-lead \
    --no-session-persistence \
    --max-turns "$TEAM_LEAD_MAX_TURNS" \
    --output-format text \
    "$prompt" 2>&1 | tee "$log_file"
  claude_status=${PIPESTATUS[0]}
  set -e

  if [ "$claude_status" -ne 0 ]; then
    log "Team Lead session for #$issue_number exited with code $claude_status. See $log_file"
    exit "$claude_status"
  fi

  state="$(issue_state "$issue_number")"
  if [ "$state" != "CLOSED" ]; then
    project_status="$(issue_project_status "$ready_url")"
    if [ "$project_status" = "Hold" ]; then
      log "Issue #$issue_number was put on Hold by the Team Lead. Picking the next Ready Issue."
      promote_unblocked
      finalize_epics
      if [ "$MODE" = "once" ]; then
        log "--once complete (Issue #$issue_number is on Hold)."
        exit 0
      fi
      continue
    fi

    log "Issue #$issue_number is still $state. Stopping instead of looping/reusing context. See $log_file"
    exit 3
  fi

  log "Issue #$issue_number closed. Discarding Team Lead context."
  promote_unblocked
  finalize_epics

  if [ "$MODE" = "once" ]; then
    log "--once complete."
    exit 0
  fi

done
