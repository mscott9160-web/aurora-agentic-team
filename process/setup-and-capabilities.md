# Setup and Capability Preflight

Use this procedure when starting approved project setup, saving an approved plan, or diagnosing a missing editing, terminal, or GitHub capability. It does not grant tools, authenticate a session, or replace lifecycle approval.

## Route to the Owning Role

| Work | Owner | Required capability |
| --- | --- | --- |
| Coordinate work and handoffs | Aria | Read/search and delegation |
| Persist an approved plan or delivery record | Avery | Markdown editing |
| Run approved setup or initialize a project | Nadia | Editing and shell execution |
| Create an explicitly approved GitHub repository | Nadia | Authenticated GitHub CLI through shell execution, or a specifically enabled repository-creation tool |

Aria should delegate to Avery or Nadia when their tools are available. In Copilot, Aria, Devon, and Jordan also offer **Save Approved Plan** and **Run Approved Setup** handoffs with automatic submission disabled. In clients without handoff buttons, select the named role manually and include the approved scope, evidence, destination, unresolved questions, and risks. Every role has terminal execution configured, but setup and plan persistence still belong to the assigned owners; do not broaden editing permissions to work around a routing problem.

Terminal access is not technically read-only: a shell can modify local files and authenticated remote resources. Non-implementation roles must keep commands within their inspection, coordination, or validation responsibilities; Avery remains restricted to Markdown documentation changes. These are instruction-level boundaries, not a shell sandbox. Keep host permissions and approval prompts enabled, and never use terminal access to bypass role restrictions or human gates.

## Check Capabilities Before Claiming a Blocker

1. Identify the active role and inspect the tools actually exposed to the current session. Distinguish a role restriction from a disabled tool, unavailable integration, permission denial, or missing authentication. Do not attempt writes outside a role's authorized scope to test access.
2. All 16 Copilot wrappers include `execute` for shell commands, not `terminal`; all 16 Claude wrappers declare `Bash`/`PowerShell` as supported by the host. File-editing tools remain limited to Atlas, Luna, Nadia, and Avery (`edit` in Copilot; `Edit`/`Write` in Claude). Tool declarations only select existing capabilities; unavailable names are not installed or enabled by frontmatter.
3. If the owning role still lacks a required tool, report the role, missing capability, and affected operation. Ask the user to enable that specific tool in the session's tool picker, or open a supported session with the owning role. Respect workspace trust, organization policy, and approval prompts; never disable safeguards or promise that configuration changes grant access to a running session.
4. After wrapper updates, start a fresh session or reselect the agent. Verify its tools again. Personal symlink installs see source changes; copied installations and project-local wrappers need refreshing or resynchronizing. The current shell installer skips managed copied directories, so rerunning alone does not refresh their shared rules/skills: back up local modifications and use a reviewed uninstall/reinstall, checking existing backup conflicts first. Check the selected agent's source when duplicate or old names appear.

## Save the Plan

Avery checks the actual human approval and agreed Markdown destination before saving. If either is missing, request it; do not turn a proposed plan into an approved one. Preserve unresolved questions and cite evidence without recording secrets. Report the saved path only after a successful write. If editing is unavailable, provide a handoff-ready summary and mark persistence as blocked, not completed.

## Run Setup and Check GitHub Access

Nadia verifies the approved story/plan, target directory, stack, and project rules before changing files or running setup commands. Preserve existing work. Validate the results and report actual changes, failures, and next owners.

For GitHub operations, prefer the authenticated `gh` CLI through the existing shell capability instead of granting an entire GitHub tool server:

- Check CLI availability with `command -v gh` on POSIX shells or `Get-Command gh` on PowerShell, then check `gh auth status`. Authentication is evidence of access, not permission to create or publish a repository. Never print raw tokens or credential files.
- If the CLI is absent or unauthenticated, report that precise blocker. Ask the human to install or authenticate through the normal secure flow; never request secrets in chat. An already configured repository-creation integration is an alternative only if its specific tool is enabled for this role and session.
- Before creation, require explicit human approval for the exact owner, repository name, and visibility. Confirm the target does not already exist; distinguish a not-found response from authorization or network errors. Do not interpret a generic request to fix agent configuration as approval to create a repository.
- Create only the approved repository. Do not push local content, change repository settings, grant access, or publish code without separate explicit scope. An existing repository is not permission to overwrite it.
- Record the returned repository URL and command outcome only after success. Stop on authorization failures; do not escalate privileges automatically.

Human approval remains required at lifecycle gates. Never merge pull requests, deploy production, rotate secrets, or approve the agent's own recommendation.