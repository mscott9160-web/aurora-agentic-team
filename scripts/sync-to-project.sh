#!/usr/bin/env bash
set -euo pipefail

[ $# -eq 1 ] || { printf 'Usage: %s <project-path>\n' "$0" >&2; exit 1; }
repository_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
project_root="$(cd "$1" && pwd)"

copy_contents() {
  local source="$1" destination="$2"
  mkdir -p "$destination"
  cp -R "$source"/. "$destination"
  printf 'COPY %s\n' "$destination"
}

copy_contents "$repository_root/wrappers/copilot" "$project_root/.github/agents"
copy_contents "$repository_root/wrappers/claude" "$project_root/.claude/agents"
copy_contents "$repository_root/skills" "$project_root/.github/skills"
copy_contents "$repository_root/skills" "$project_root/.claude/skills"
copy_contents "$repository_root/roles" "$project_root/.aurora-agentic-team/roles"
copy_contents "$repository_root/process" "$project_root/.aurora-agentic-team/process"
mkdir -p "$project_root/.aurora-agentic-team" "$project_root/.claude/commands"
cp "$repository_root/AGENTS.md" "$project_root/.aurora-agentic-team/AGENTS.md"
cp "$repository_root/commands/sprint.md" "$project_root/.claude/commands/aurora-sprint.md"
printf 'COPY %s\n' "$project_root/.aurora-agentic-team/AGENTS.md"
printf 'COPY %s\n' "$project_root/.claude/commands/aurora-sprint.md"

if [ ! -e "$project_root/AGENTS.md" ]; then
  printf '# Project Agent Rules\n\nAdd project-specific stack, architecture, build, test, deployment, and domain rules here.\n' > "$project_root/AGENTS.md"
  printf 'CREATE %s\n' "$project_root/AGENTS.md"
else
  printf 'UNCHANGED %s\n' "$project_root/AGENTS.md"
fi

version="$(git -C "$repository_root" describe --tags --always 2>/dev/null || printf 'uncommitted')"
printf '%s\n' "$version" > "$project_root/.agent-team-version"
printf 'WRITE %s\n' "$project_root/.agent-team-version"
