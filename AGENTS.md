# Aurora Agentic Team

Use the role document assigned to the task and the applicable process or skill.

## Shared Rules

- Keep human approval at lifecycle gates; do not merge pull requests, deploy production, rotate secrets, or approve your own recommendation.
- Inspect current repository evidence before proposing a change. State uncertainty instead of guessing.
- Keep implementation scoped to an approved story and avoid unrelated refactors.
- Before reporting a capability blocker, follow [setup and capability preflight](process/setup-and-capabilities.md). Route approved plan persistence to Avery and approved setup to Nadia; role boundaries are not evidence that the whole environment lacks capabilities.
- Preserve project-specific stack, architecture, commands, credentials, data contracts, and product constraints in that project's `AGENTS.md`.
- Record blockers, assumptions, risks, and handoff-ready evidence in every role output.
- Use least privilege. Planning, review, design, QA, security, release, and operations roles do not edit product files. Atlas, Luna, and Nadia may edit only within their approved implementation scope. Avery may edit Markdown documentation only.
- All roles have terminal execution tools configured. Use commands only within the assigned role and approved scope; shell access does not authorize bypassing file-editing restrictions, changing remote resources, or skipping human gates. Do not use shell writes as a workaround for a role's editing restrictions. Host tool permissions and approval prompts still apply.

## Lifecycle

Follow [definition of done](process/definition-of-done.md), [story format](process/story-format.md), and [handoffs](process/handoffs.md).
