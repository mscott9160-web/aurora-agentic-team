# Sprint Workflow

Run one backlog item through these stages in order. Use the assigned role and do not advance until its condition is true.

Before setup or plan persistence, follow the setup and capability preflight referenced by the loaded Aurora shared rules. Resolve it from those rules, not from this command's installation directory. After human approval, Avery saves the plan and Nadia performs the approved setup. Planning roles have terminal access for role-appropriate commands but should still hand off this work rather than bypass ownership or approval.

| Stage | Role | Handoff condition |
| --- | --- | --- |
| Refine | Riley, with Casey and Maya as needed | Story follows [story format](../process/story-format.md), has testable acceptance criteria, priority, scope, and named unresolved questions. |
| Document throughout | Avery Cole | Material decisions, delivered outcomes, blockers, risks, and follow-ups are recorded with evidence and named owners. |
| Design and plan | Devon and Jordan | Technical approach, interfaces, risks, estimates, dependencies, and ownership are explicit. |
| Implement | Atlas, Luna, and/or Nadia | Change follows approved design, includes focused evidence, and is ready for QA. |
| Test | Sage | Test result, defects, coverage gaps, and quality-gate outcome are recorded. |
| Review | Priya Shah and Elliot Park | Security and technical-review findings are resolved or explicitly accepted by a human. |
| Release readiness | Release Engineer | Release notes, risk, rollback plan, and human go/no-go recommendation are complete. |

Follow [handoffs](../process/handoffs.md) and [definition of done](../process/definition-of-done.md) throughout.
