[CmdletBinding()]
param([switch]$Uninstall)

$ErrorActionPreference = 'Stop'
$repositoryRoot = Split-Path -Parent $PSScriptRoot
$homeSource = Join-Path $HOME '.aurora-agentic-team'
$backupSuffix = '.aurora-agentic-team-backup'

function Write-PathAction([string]$Action, [string]$Path) {
    Write-Host "$Action $Path"
}

function Backup-Path([string]$Path) {
    if (-not (Test-Path -LiteralPath $Path)) { return }
    $backup = "$Path$backupSuffix"
    if (Test-Path -LiteralPath $backup) { throw "Backup already exists: $backup" }
    Move-Item -LiteralPath $Path -Destination $backup
    Write-PathAction 'BACKUP' $backup
}

function Install-Target([string]$Source, [string]$Destination) {
    $parent = Split-Path -Parent $Destination
    New-Item -ItemType Directory -Force -Path $parent | Out-Null
    if (Test-Path -LiteralPath $Destination) {
        $item = Get-Item -LiteralPath $Destination -Force
        if (($item.Attributes -band [IO.FileAttributes]::ReparsePoint) -and $item.Target -eq $Source) {
            Write-PathAction 'UNCHANGED' $Destination
            return
        }
        if ((Test-Path -LiteralPath $Destination -PathType Container) -and (Test-Path -LiteralPath (Join-Path $Destination '.aurora-agentic-team-installed'))) {
            Write-PathAction 'UNCHANGED' $Destination
            return
        }
        if ((Test-Path -LiteralPath $Source -PathType Leaf) -and (Test-Path -LiteralPath $Destination -PathType Leaf) -and ((Get-FileHash -LiteralPath $Source).Hash -eq (Get-FileHash -LiteralPath $Destination).Hash)) {
            Write-PathAction 'UNCHANGED' $Destination
            return
        }
        Backup-Path $Destination
    }
    try {
        New-Item -ItemType SymbolicLink -Path $Destination -Target $Source | Out-Null
        Write-PathAction 'SYMLINK' $Destination
    } catch {
        if (Test-Path -LiteralPath $Source -PathType Container) {
            Copy-Item -LiteralPath $Source -Destination $Destination -Recurse
            Set-Content -LiteralPath (Join-Path $Destination '.aurora-agentic-team-installed') -Value $Source -Encoding ascii
        } else {
            Copy-Item -LiteralPath $Source -Destination $Destination
        }
        Write-PathAction 'COPY (rerun after updates)' $Destination
    }
}

function Uninstall-Target([string]$Destination) {
    if (Test-Path -LiteralPath $Destination) {
        [GC]::Collect()
        [GC]::WaitForPendingFinalizers()
        try {
            Remove-Item -LiteralPath $Destination -Recurse -Force
        } catch {
            & cmd.exe /c "rmdir /s /q `"$Destination`""
            if (Test-Path -LiteralPath $Destination) { throw }
        }
        Write-PathAction 'REMOVE' $Destination
    }
    $backup = "$Destination$backupSuffix"
    if (Test-Path -LiteralPath $backup) {
        Move-Item -LiteralPath $backup -Destination $Destination
        Write-PathAction 'RESTORE' $Destination
    }
}

$targets = @(@{ Source = $repositoryRoot; Destination = $homeSource })
Get-ChildItem (Join-Path $repositoryRoot 'wrappers/copilot') -File | ForEach-Object {
    $targets += @{ Source = $_.FullName; Destination = Join-Path $HOME ".copilot/agents/$($_.Name)" }
}
Get-ChildItem (Join-Path $repositoryRoot 'wrappers/claude') -File | ForEach-Object {
    $targets += @{ Source = $_.FullName; Destination = Join-Path $HOME ".claude/agents/$($_.Name)" }
}
Get-ChildItem (Join-Path $repositoryRoot 'skills') -Directory | ForEach-Object {
    $targets += @{ Source = $_.FullName; Destination = Join-Path $HOME ".copilot/skills/$($_.Name)" }
    $targets += @{ Source = $_.FullName; Destination = Join-Path $HOME ".claude/skills/$($_.Name)" }
}
$targets += @{ Source = Join-Path $repositoryRoot 'commands/sprint.md'; Destination = Join-Path $HOME '.claude/commands/aurora-sprint.md' }

if ($Uninstall) { [array]::Reverse($targets) }
foreach ($target in $targets) {
    if ($Uninstall) { Uninstall-Target $target.Destination } else { Install-Target $target.Source $target.Destination }
}
