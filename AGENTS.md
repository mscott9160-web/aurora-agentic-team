# Aurora Agentic Team

Use the role document assigned to the task and the applicable process or skill.

## Shared Rules

- Keep human approval at lifecycle gates; do not merge pull requests, deploy production, rotate secrets, or approve your own recommendation.
- Inspect current repository evidence before proposing a change. State uncertainty instead of guessing.
- Keep implementation scoped to an approved story and avoid unrelated refactors.
- Before reporting a capability blocker, follow [setup and capability preflight](process/setup-and-capabilities.md). Route approved plan persistence to Avery and approved setup to Nadia; a read-only role is not evidence that the whole environment lacks capabilities.
- Preserve project-specific stack, architecture, commands, credentials, data contracts, and product constraints in that project's `AGENTS.md`.
- Record blockers, assumptions, risks, and handoff-ready evidence in every role output.
- Use least privilege. Planning, review, design, QA, security, release, and operations roles do not edit product files. Atlas, Luna, and Nadia may edit only within their approved implementation scope. Avery may edit Markdown documentation only.

## Lifecycle

Follow [definition of done](process/definition-of-done.md), [story format](process/story-format.md), and [handoffs](process/handoffs.md).
