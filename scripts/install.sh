#!/usr/bin/env bash
set -euo pipefail

repository_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
home_source="$HOME/.aurora-agentic-team"
backup_suffix=".aurora-agentic-team-backup"

print_path() { printf '%s %s\n' "$1" "$2"; }

backup_path() {
  local path="$1" backup="${1}${backup_suffix}"
  [ -e "$path" ] || [ -L "$path" ] || return 0
  [ ! -e "$backup" ] && [ ! -L "$backup" ] || { printf 'Backup already exists: %s\n' "$backup" >&2; exit 1; }
  mv "$path" "$backup"
  print_path BACKUP "$backup"
}

install_target() {
  local source="$1" destination="$2"
  mkdir -p "$(dirname "$destination")"
  if [ -L "$destination" ] && [ "$(readlink "$destination")" = "$source" ]; then
    print_path UNCHANGED "$destination"
    return
  fi
  backup_path "$destination"
  if ln -s "$source" "$destination" 2>/dev/null; then
    print_path SYMLINK "$destination"
  elif [ -d "$source" ]; then
    cp -R "$source" "$destination"
    print_path 'COPY (rerun after updates)' "$destination"
  else
    cp "$source" "$destination"
    print_path 'COPY (rerun after updates)' "$destination"
  fi
}

uninstall_target() {
  local destination="$1" backup="${1}${backup_suffix}"
  if [ -e "$destination" ] || [ -L "$destination" ]; then
    rm -rf "$destination"
    print_path REMOVE "$destination"
  fi
  if [ -e "$backup" ] || [ -L "$backup" ]; then
    mv "$backup" "$destination"
    print_path RESTORE "$destination"
  fi
}

uninstall=false
[ "${1:-}" = "--uninstall" ] && uninstall=true

targets=("$repository_root|$home_source")
for source in "$repository_root"/wrappers/copilot/*; do targets+=("$source|$HOME/.copilot/agents/$(basename "$source")"); done
for source in "$repository_root"/wrappers/claude/*; do targets+=("$source|$HOME/.claude/agents/$(basename "$source")"); done
for source in "$repository_root"/skills/*; do
  name="$(basename "$source")"
  targets+=("$source|$HOME/.copilot/skills/$name" "$source|$HOME/.claude/skills/$name")
done
targets+=("$repository_root/commands/sprint.md|$HOME/.claude/commands/aurora-sprint.md")

for target in "${targets[@]}"; do
  source="${target%%|*}"
  destination="${target#*|}"
  if "$uninstall"; then uninstall_target "$destination"; else install_target "$source" "$destination"; fi
done
