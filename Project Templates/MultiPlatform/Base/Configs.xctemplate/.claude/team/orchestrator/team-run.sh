#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=/dev/null
source "$SCRIPT_DIR/common.sh"

if [ "$#" -eq 0 ]; then
  printf 'Usage: %s "<large feature / bug / improvement>"\n' "$0" >&2
  exit 64
fi

TASK="$*"

ensure_prerequisites
cd "$(repo_root)"
ensure_clean_worktree

timestamp="$(date '+%Y%m%d-%H%M%S')"
log_file="$RUNTIME_DIR/logs/plan-${timestamp}.log"

log "Starting fresh planning session"

prompt=$(cat <<EOF_PROMPT
MODE: PLAN_AND_QUEUE

User task:
$TASK

Create the persistent GitHub execution queue for this task.

Hard requirements:
- Read .claude/team/WORKFLOW.md and .claude/team/rules/GITHUB.md first.
- This session plans and creates GitHub Issues only. Do NOT implement product code.
- Small/Medium independently mergeable work: create one agent:auto + agent:task Issue and mark Ready.
- Large work: use a fresh solution-architect, create one agent:epic parent and independently mergeable agent:auto + agent:task child Issues.
- Every child must contain exact metadata lines: Epic: #<number> and Depends-On: ... .
- Child with no dependencies → Ready. Blocked child → Backlog. Epic → In Progress.
- Add all created Issues to GitHub Project #$PROJECT_NUMBER owned by $PROJECT_OWNER.
- Do not start implementation. The external orchestrator will launch a completely new Team Lead session.
EOF_PROMPT
)

claude -p \
  --agent team-planner \
  --no-session-persistence \
  --max-turns "$PLANNER_MAX_TURNS" \
  --output-format text \
  "$prompt" 2>&1 | tee "$log_file"

log "Planning context discarded. Starting queue runner."
exec "$SCRIPT_DIR/team-orchestrator.sh"
