# ___PACKAGENAME___ Team Orchestrator

External deterministic runner. It must be started from a normal shell, not from inside an already-running Claude Code session.

## Start a new large task

From the ___PACKAGENAME___ repository root:

```bash
make team-run TASK="Добавить полноценную систему тегов"
```

Flow:

1. fresh `team-planner` session;
2. Epic/child Issues persisted in GitHub;
3. planner session exits;
4. runner selects first `Ready` `agent:auto`/`agent:task` Issue;
5. fresh `team-lead` session runs exactly one Issue to merge/Done;
6. session exits and is not persisted;
7. runner promotes newly unblocked dependencies;
8. fresh Team Lead starts next Issue;
9. repeats until queue is empty.

## Resume an existing queue

```bash
make team-resume
```

Run exactly one Ready Issue:

```bash
make team-once
```

The scripts remain available for direct use from the repository root when Make is not available.

## Why this is outside Claude

Claude Code guards against nested top-level Claude sessions. The runner is intentionally an external shell process so every root Team Lead is a real new session rather than a resumed/nested context.

## Safety behavior

The runner stops instead of guessing when:

- working tree is dirty;
- `gh`/`claude` is unavailable;
- GitHub auth is missing;
- a Team Lead exits but its Issue remains open (unless the Issue was moved to Hold —
  then the runner picks the next Ready Issue);
- open automated tasks remain outside Hold but none is Ready (blocked/cyclic dependencies).

Issues on `Hold` (external blockers) do not block the queue: the runner skips them, and when
only Hold Issues remain it exits successfully with a report listing them. Resolve the blocker
and move the Issue back to `Ready` manually to resume.

It does not `git reset`, `git clean`, stash user changes, or force merge.

## Runtime logs

By default logs go outside the repository:

```text
${TMPDIR:-/tmp}/___PACKAGENAME:identifier___-agent-team/logs
```

Override with:

```bash
RUNTIME_DIR=/some/path .claude/team/orchestrator/team-run.sh "..."
```

## Configuration

Edit `.claude/team/orchestrator/config.sh` or override environment variables:

- `PROJECT_OWNER`
- `PROJECT_NUMBER`
- `REPO`
- `PLANNER_MAX_TURNS`
- `TEAM_LEAD_MAX_TURNS`
