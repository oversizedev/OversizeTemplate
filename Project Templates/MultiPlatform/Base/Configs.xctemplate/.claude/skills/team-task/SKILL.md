---
name: team-task
description: Interactive compatibility entry for ___PACKAGENAME___ Agent Workflow v2. Explains and prepares durable GitHub planning, but fresh root Team Lead sessions are launched by the external team-run/team-orchestrator scripts rather than nested inside the current Claude Code session.
argument-hint: [task description]
---

# Team Task v2

Задача пользователя: **$ARGUMENTS**

Если `$ARGUMENTS` пуст, попроси описание задачи.

## Важно

Новый workflow не должен пытаться запускать `claude -p` из Bash внутри уже работающей Claude Code session.
Fresh root sessions создаёт внешний runner:

```bash
.claude/team/orchestrator/team-run.sh "<task>"
```

Это основной entrypoint для автоматического выполнения большой задачи через несколько независимых Team Lead sessions.

## Если skill вызван интерактивно

1. Прочитай `.claude/team/WORKFLOW.md`.
2. Объясни одной короткой фразой, что задача будет выполняться через durable GitHub queue и fresh sessions.
3. Не запускай старый долгоживущий Agent Team workflow.
4. Не создавай всех teammates заранее.
5. Не используй `/compact` или `/clear` как lifecycle mechanism.
6. Не пытайся nested-launch нового `claude` процесса из этой session.

Если пользователь хочет выполнить задачу прямо в текущей interactive session как **одну** Issue, можно применить правила `.claude/team/TEAM_LEAD.md`, но автоматический переход к следующей Issue произойдёт только через внешний orchestrator.

Для полностью автономного режима укажи точную команду:

```bash
.claude/team/orchestrator/team-run.sh "$ARGUMENTS"
```
