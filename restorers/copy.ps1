<#
.SYNOPSIS
    Copy restorer for Provisioning.

.DESCRIPTION
    Restores configuration files by copying from source to target,
    with backup-before-overwrite safety.
#>

function Invoke-CopyRestore {
    <#
    .SYNOPSIS
        Copy a file or directory to target, backing up existing content.
    #>
    param(
        [Parameter(Mandatory = $true)]
        [string]$Source,
        
        [Parameter(Mandatory = $true)]
        [string]$Target,
        
        [Parameter(Mandatory = $false)]
        [bool]$Backup = $true,
        
        [Parameter(Mandatory = $false)]
        [switch]$DryRun
    )
    
    $result = @{
        Success = $false
        BackupPath = $null
        Error = $null
    }
    
    # Expand environment variables in paths
    $expandedSource = [Environment]::ExpandEnvironmentVariables($Source)
    $expandedTarget = [Environment]::ExpandEnvironmentVariables($Target)
    
    # Handle ~ for home directory
    if ($expandedSource.StartsWith("~")) {
        $expandedSource = $expandedSource -replace "^~", $env:USERPROFILE
    }
    if ($expandedTarget.StartsWith("~")) {
        $expandedTarget = $expandedTarget -replace "^~", $env:USERPROFILE
    }
    
    # Check source exists
    if (-not (Test-Path $expandedSource)) {
        $result.Error = "Source not found: $expandedSource"
        return $result
    }
    
    # Dry-run mode
    if ($DryRun) {
        $result.Success = $true
        $result.Error = "[DRY-RUN] Would copy $expandedSource -> $expandedTarget"
        return $result
    }
    
    try {
        # Backup existing target if it exists
        if ($Backup -and (Test-Path $expandedTarget)) {
            $backupDir = Join-Path $PSScriptRoot "..\state\backups\$(Get-Date -Format 'yyyyMMdd-HHmmss')"
            if (-not (Test-Path $backupDir)) {
                New-Item -ItemType Directory -Path $backupDir -Force | Out-Null
            }
            
            $targetName = Split-Path -Leaf $expandedTarget
            $backupPath = Join-Path $backupDir $targetName
            
            if (Test-Path $expandedTarget -PathType Container) {
                Copy-Item -Path $expandedTarget -Destination $backupPath -Recurse -Force
            } else {
                Copy-Item -Path $expandedTarget -Destination $backupPath -Force
            }
            
            $result.BackupPath = $backupPath
        }
        
        # Ensure target directory exists
        $targetDir = Split-Path -Parent $expandedTarget
        if (-not (Test-Path $targetDir)) {
            New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
        }
        
        # Copy source to target
        if (Test-Path $expandedSource -PathType Container) {
            Copy-Item -Path $expandedSource -Destination $expandedTarget -Recurse -Force
        } else {
            Copy-Item -Path $expandedSource -Destination $expandedTarget -Force
        }
        
        $result.Success = $true
        
    } catch {
        $result.Error = $_.Exception.Message
    }
    
    return $result
}

function Test-CopyRestorePrerequisites {
    <#
    .SYNOPSIS
        Check if a copy restore can be performed.
    #>
    param(
        [Parameter(Mandatory = $true)]
        [string]$Source,
        
        [Parameter(Mandatory = $true)]
        [string]$Target
    )
    
    $result = @{
        CanRestore = $false
        SourceExists = $false
        TargetExists = $false
        TargetWritable = $false
        Issues = @()
    }
    
    # Expand paths
    $expandedSource = [Environment]::ExpandEnvironmentVariables($Source)
    $expandedTarget = [Environment]::ExpandEnvironmentVariables($Target)
    
    if ($expandedSource.StartsWith("~")) {
        $expandedSource = $expandedSource -replace "^~", $env:USERPROFILE
    }
    if ($expandedTarget.StartsWith("~")) {
        $expandedTarget = $expandedTarget -replace "^~", $env:USERPROFILE
    }
    
    # Check source
    if (Test-Path $expandedSource) {
        $result.SourceExists = $true
    } else {
        $result.Issues += "Source does not exist: $expandedSource"
    }
    
    # Check target
    if (Test-Path $expandedTarget) {
        $result.TargetExists = $true
    }
    
    # Check target directory is writable
    $targetDir = Split-Path -Parent $expandedTarget
    if (Test-Path $targetDir) {
        try {
            $testFile = Join-Path $targetDir ".provisioning-write-test"
            [System.IO.File]::WriteAllText($testFile, "test")
            Remove-Item $testFile -Force
            $result.TargetWritable = $true
        } catch {
            $result.Issues += "Target directory not writable: $targetDir"
        }
    } else {
        # Directory doesn't exist, check if we can create it
        try {
            $parentDir = Split-Path -Parent $targetDir
            if (Test-Path $parentDir) {
                $result.TargetWritable = $true
            } else {
                $result.Issues += "Cannot create target directory: $targetDir"
            }
        } catch {
            $result.Issues += "Cannot determine target writability"
        }
    }
    
    $result.CanRestore = $result.SourceExists -and $result.TargetWritable
    
    return $result
}

# Functions exported: Invoke-CopyRestore, Test-CopyRestorePrerequisites
