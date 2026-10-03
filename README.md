# Aurora Agentic Team

`aurora-agentic-team` is the central, tool-neutral source of truth for the Aurora Labs agentic Scrum team. It complements [AI-DLC Starter](https://github.com/mscott9160-web/ai-dlc-starter): the starter supplies human-gated lifecycle automation, while this repository supplies reusable team roles, procedures, and tool wrappers.

## Structure

- `AGENTS.md`: rules shared by every role.
- `roles/`: one tool-neutral role definition per team member.
- `process/`: shared definition of done, story format, and handoffs.
- `skills/`: reusable, portable procedures.
- `wrappers/copilot/`: VS Code Copilot `.agent.md` files.
- `wrappers/claude/`: Claude Code subagent `.md` files.
- `commands/sprint.md`: ordered backlog-item workflow.
- `scripts/`: personal installation and project synchronization scripts.

## Install

Clone this repository, then run one installer from its root:

```powershell
.\scripts\install.ps1
```

```bash
./scripts/install.sh
```

The installer links the repository to `~/.aurora-agentic-team`, then links wrappers and skills to their documented personal locations. If symlinks are unavailable, it copies and prints `COPY (rerun after updates)` for every copied path. Existing targets are backed up with the `.aurora-agentic-team-backup` suffix. Run the same command again to make no changes when the links already point to this repository.

To remove the installation and restore backed-up files:

```powershell
.\scripts\install.ps1 --uninstall
```

```bash
./scripts/install.sh --uninstall
```

## Sync Into a Project

Copy the team into a project without replacing its own rules:

```powershell
.\scripts\sync-to-project.ps1 -ProjectPath C:\path\to\project
```

```bash
./scripts/sync-to-project.sh /path/to/project
```

The scripts copy wrappers to `.github/agents/` and `.claude/agents/`, skills to both supported project skill folders, the canonical source to `.aurora-agentic-team/`, and the Claude command to `.claude/commands/aurora-sprint.md`. They create a starter project `AGENTS.md` only when one is absent and write `.agent-team-version` with the current tag or commit.

## Extend the Team

To add a role:

1. Add one tool-neutral definition to `roles/` with purpose, responsibilities, inputs, outputs, handoffs, and prohibitions.
2. Add one minimal wrapper per tool using the documented frontmatter and only a pointer to the role and shared rules.
3. Grant only the tools required by that role.
4. Update `commands/sprint.md`, `MIGRATION.md`, and this README when workflow ownership changes.

To add a skill, create `skills/<lowercase-hyphenated-name>/SKILL.md` with matching `name` and `description` frontmatter. Keep reusable procedures there rather than duplicating them in role documents.

## Roll Back

List releases, check out a previous tag, and rerun the installer:

```bash
git tag --list
git checkout v0.1.0
./scripts/install.sh
```

On Windows, use the equivalent `git checkout` command and `install.ps1`. Return to the latest version with `git checkout main` followed by `git pull` and the installer.

## Documented Differences

- VS Code Copilot supports personal agents in `~/.copilot/agents` and skills in `~/.copilot/skills`; Claude Code supports agents in `~/.claude/agents` and skills in `~/.claude/skills`. The installers use those official locations.
- Claude Code requires machine-oriented unique subagent identifiers, so Claude wrapper `name` fields use role slugs while Copilot displays the human role names. Descriptions are identical.
- VS Code prompt files do not have a documented portable filesystem location for Agent Host and are deprecated there. The sprint command is therefore installed as the manual `aurora-sprint` skill for Copilot and as `~/.claude/commands/aurora-sprint.md` for Claude Code.
