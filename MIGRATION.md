# Migration

## Source Mapping

The prior Aurora catalog maps to these central role documents and paired wrappers:

| Previous agent file | Central role |
| --- | --- |
| `aurora-labs-conductor.agent.md` | `roles/aria-conductor.md` |
| `aurora-scrum-master.agent.md` | `roles/marcus-scrum-master.md` |
| `aurora-team-lead.agent.md` | `roles/jordan-team-lead.md` |
| `aurora-tech-lead.agent.md` | `roles/devon-tech-lead.md` |
| `aurora-backend-dev.agent.md` | `roles/atlas-backend-developer.md` |
| `aurora-frontend-dev.agent.md` | `roles/luna-frontend-developer.md` |
| `aurora-qa-tester.agent.md` | `roles/sage-qa-engineer.md` |
| `aurora-business-partner.agent.md` | `roles/riley-business-partner.md` |
| `aurora-early-consumer.agent.md` | `roles/casey-early-consumer.md` |
| `aurora-ui-ux-designer.agent.md` and Maya Chen variants | `roles/maya-product-design-lead.md` |

Each central role has exactly one wrapper in `wrappers/copilot/` and one in `wrappers/claude/` with the same description.

## Consolidation

The generic Aurora UI/UX Designer and Maya Chen variants are combined into **Maya Chen, Product Design Lead**. This makes one role accountable for product design direction, interaction design, accessibility direction, visual language, and design review.

## Central Additions

The following roles were added to cover workflow ownership absent from the source catalog:

- **Elliot Park, Code Reviewer**: independent, read-only technical review after Sage's QA gate and before release readiness.
- **Nadia Brooks, Platform Engineer**: approved implementation of CI/CD, infrastructure configuration, observability, environments, and rollback mechanics.
- **Avery Cole, Technical Writer**: evidence-based documentation of decisions, delivery progress, risks, issues, and follow-up work throughout the workflow.

## Permission Changes

The prior core Aurora agents broadly exposed `search`, `read`, `edit`, `agent`, and `todo` tools. The central repository narrows this by role:

- Atlas, Luna, and Nadia retain editing and shell access because they implement approved changes.
- Aria retains delegation but no editing or shell access.
- Marcus, Jordan, Devon, Riley, Casey, Maya, Release Engineer, and Operations Incident Responder are read-only.
- Sage and Security and Privacy Reviewer can inspect and run validation commands but cannot edit or write files.

This is a least-privilege change. It preserves role responsibilities while preventing review, QA, planning, design, release, and operations roles from modifying product files.

## Project-Specific Content Left Out

The following belonged to individual project `AGENTS.md` files and was intentionally excluded:

- Specific frameworks, runtimes, databases, external services, build commands, test commands, and deployment commands.
- Product domains and workflows such as cash-flow projections, portfolio tracking, sneaker release intelligence, and barber booking.
- Product navigation, data fields, local/demo behavior, user promises, and feature backlogs.
- Project-specific visual language, screenshots, routes, component names, and API paths.
- Any project-specific security or authorization constraints.

## Ambiguity Resolved

No source file established a single canonical Maya Chen definition; several copies varied by product. The central definition keeps the responsibilities common to those copies and delegates product-specific requirements to each target project.
