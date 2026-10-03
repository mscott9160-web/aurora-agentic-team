[CmdletBinding()]
param([Parameter(Mandatory = $true)][string]$ProjectPath)

$ErrorActionPreference = 'Stop'
$repositoryRoot = Split-Path -Parent $PSScriptRoot
$projectRoot = (Resolve-Path -LiteralPath $ProjectPath).Path

function Copy-DirectoryContents([string]$Source, [string]$Destination) {
    New-Item -ItemType Directory -Force -Path $Destination | Out-Null
    Get-ChildItem -LiteralPath $Source -Force | ForEach-Object {
        $target = Join-Path $Destination $_.Name
        Copy-Item -LiteralPath $_.FullName -Destination $target -Recurse -Force
        Write-Host "COPY $target"
    }
}

Copy-DirectoryContents (Join-Path $repositoryRoot 'wrappers/copilot') (Join-Path $projectRoot '.github/agents')
Copy-DirectoryContents (Join-Path $repositoryRoot 'wrappers/claude') (Join-Path $projectRoot '.claude/agents')
Copy-DirectoryContents (Join-Path $repositoryRoot 'skills') (Join-Path $projectRoot '.github/skills')
Copy-DirectoryContents (Join-Path $repositoryRoot 'skills') (Join-Path $projectRoot '.claude/skills')
Copy-DirectoryContents (Join-Path $repositoryRoot 'roles') (Join-Path $projectRoot '.aurora-agentic-team/roles')
Copy-DirectoryContents (Join-Path $repositoryRoot 'process') (Join-Path $projectRoot '.aurora-agentic-team/process')
Copy-Item (Join-Path $repositoryRoot 'AGENTS.md') (Join-Path $projectRoot '.aurora-agentic-team/AGENTS.md') -Force
Write-Host "COPY $(Join-Path $projectRoot '.aurora-agentic-team/AGENTS.md')"
New-Item -ItemType Directory -Force -Path (Join-Path $projectRoot '.claude/commands') | Out-Null
Copy-Item (Join-Path $repositoryRoot 'commands/sprint.md') (Join-Path $projectRoot '.claude/commands/aurora-sprint.md') -Force
Write-Host "COPY $(Join-Path $projectRoot '.claude/commands/aurora-sprint.md')"

$projectAgents = Join-Path $projectRoot 'AGENTS.md'
if (-not (Test-Path -LiteralPath $projectAgents)) {
    @('# Project Agent Rules', '', 'Add project-specific stack, architecture, build, test, deployment, and domain rules here.') | Set-Content -LiteralPath $projectAgents -Encoding utf8
    Write-Host "CREATE $projectAgents"
} else {
    Write-Host "UNCHANGED $projectAgents"
}

$headReference = Get-Content -LiteralPath (Join-Path $repositoryRoot '.git/HEAD') -ErrorAction SilentlyContinue
if ($headReference -match '^ref: ' -and (Test-Path -LiteralPath (Join-Path $repositoryRoot ".git/$($headReference.Substring(5))"))) {
    $version = (& git -C $repositoryRoot describe --tags --always)
} else {
    $version = 'uncommitted'
}
Set-Content -LiteralPath (Join-Path $projectRoot '.agent-team-version') -Value $version -Encoding ascii
Write-Host "WRITE $(Join-Path $projectRoot '.agent-team-version')"
