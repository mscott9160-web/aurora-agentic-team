# AI-DLC Stage Contracts

| Stage | Input | Output | Human boundary |
| --- | --- | --- | --- |
| Plan | Work-item issue and repository guidance | One marked issue comment with scope, acceptance criteria, classification, and open questions | Maintainer selects the next approval label. |
| Design | Approved plan snapshot and repository evidence | One marked issue comment with design, alternatives, risks, and test strategy | Maintainer approves the design. |
| Implement | Approved plan for small work, or approved design for standard and large work | Pull request linked to the issue and quoting implemented acceptance criteria | Human reviews and merges. |
| Review | Pull request diff and validation evidence | Evidence-based findings only | Human decides whether to merge. |
| CI Triage | Failed CI logs and changed files | Failure summary and focused next step | Developer chooses the fix. |
| Release | Merged changes and release evidence | Release notes and a go/no-go recommendation | Human approves deployment outside the workflow. |
| Operate | Incident record, logs, and runbooks | Incident summary and draft follow-up | Incident commander approves remediation. |

Plan and Design comments are identified by hidden gh-aw tracker markers. The next stage reads the identified comment and compares its `updated_at` timestamp with the approval-label event; an edit after approval invalidates the approval and requires a new maintainer label action.