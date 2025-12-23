# Copyright 2025 Substrate Systems OÜ
# SPDX-License-Identifier: Apache-2.0

<#
.SYNOPSIS
    Shared helper functions for restorers.

.DESCRIPTION
    Provides common utilities for reading/writing files with UTF-8 encoding
    and atomic write operations.
#>

function Read-TextFileUtf8 {
    <#
    .SYNOPSIS
        Read a text file with UTF-8 encoding.
    .DESCRIPTION
        Returns file content as a string. Returns $null if file doesn't exist.
    #>
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path
    )
    
    if (-not (Test-Path $Path)) {
        return $null
    }
    
    return Get-Content -Path $Path -Raw -Encoding UTF8
}

function Write-TextFileUtf8Atomic {
    <#
    .SYNOPSIS
        Write content to a file atomically using temp file + move.
    .DESCRIPTION
        Writes to a temporary file first, then moves to target.
        This ensures the target is never left in a partial state.
        Creates parent directories if needed.
    #>
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path,
        
        [Parameter(Mandatory = $true)]
        [AllowEmptyString()]
        [string]$Content
    )
    
    # Ensure parent directory exists
    $parentDir = Split-Path -Parent $Path
    if ($parentDir -and -not (Test-Path $parentDir)) {
        New-Item -ItemType Directory -Path $parentDir -Force | Out-Null
    }
    
    # Write to temp file
    $tempFile = "$Path.tmp.$([System.Guid]::NewGuid().ToString('N').Substring(0, 8))"
    
    try {
        # Use .NET to write UTF-8 without BOM
        [System.IO.File]::WriteAllText($tempFile, $Content, [System.Text.UTF8Encoding]::new($false))
        
        # Move temp to target (atomic on same filesystem)
        if (Test-Path $Path) {
            Remove-Item -Path $Path -Force
        }
        Move-Item -Path $tempFile -Destination $Path -Force
        
        return $true
    } catch {
        # Clean up temp file on failure
        if (Test-Path $tempFile) {
            Remove-Item -Path $tempFile -Force -ErrorAction SilentlyContinue
        }
        throw
    }
}

function Test-ContentIdentical {
    <#
    .SYNOPSIS
        Compare two strings for equality (content comparison).
    .DESCRIPTION
        Returns $true if both strings are identical.
        Handles $null values gracefully.
    #>
    param(
        [Parameter(Mandatory = $false)]
        [AllowNull()]
        [string]$Content1,
        
        [Parameter(Mandatory = $false)]
        [AllowNull()]
        [string]$Content2
    )
    
    if ($null -eq $Content1 -and $null -eq $Content2) {
        return $true
    }
    if ($null -eq $Content1 -or $null -eq $Content2) {
        return $false
    }
    return $Content1 -eq $Content2
}

function Expand-RestorePathHelper {
    <#
    .SYNOPSIS
        Expand a path with ~ and environment variables.
    .DESCRIPTION
        Supports:
        - ~ for user home directory
        - Environment variables like %USERPROFILE% or $env:APPDATA
        - Relative paths resolved against base directory
    #>
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path,
        
        [Parameter(Mandatory = $false)]
        [string]$BasePath = $null
    )
    
    $expanded = $Path
    
    # Handle PowerShell-style env vars like $env:APPDATA
    $expanded = $expanded -replace '\$env:([A-Za-z_][A-Za-z0-9_]*)', { 
        $varName = $_.Groups[1].Value
        [Environment]::GetEnvironmentVariable($varName)
    }
    
    # Expand Windows-style environment variables like %USERPROFILE%
    $expanded = [Environment]::ExpandEnvironmentVariables($expanded)
    
    # Handle ~ for home directory (cross-platform)
    if ($expanded.StartsWith("~")) {
        $homeDir = if ($env:HOME) { $env:HOME } else { $env:USERPROFILE }
        $expanded = $expanded -replace "^~", $homeDir
    }
    
    # Handle relative paths (starting with ./ or ../)
    if ($BasePath -and ($expanded.StartsWith("./") -or $expanded.StartsWith("../"))) {
        $expanded = Join-Path $BasePath $expanded
        $expanded = [System.IO.Path]::GetFullPath($expanded)
    }
    
    return $expanded
}

function Invoke-RestoreBackup {
    <#
    .SYNOPSIS
        Backup a target file/directory before overwriting.
    .DESCRIPTION
        Creates backup under provisioning/state/backups/<runId>/...
        preserving the original path structure.
    #>
    param(
        [Parameter(Mandatory = $true)]
        [string]$Target,
        
        [Parameter(Mandatory = $true)]
        [string]$RunId
    )
    
    $result = @{
        Success = $false
        BackupPath = $null
        Error = $null
    }
    
    try {
        # Create backup directory structure
        $backupRoot = Join-Path $PSScriptRoot "..\state\backups\$RunId"
        
        # Preserve path structure in backup
        $normalizedTarget = $Target -replace ':', ''
        $normalizedTarget = $normalizedTarget -replace '^[/\\]+', ''
        
        $backupPath = Join-Path $backupRoot $normalizedTarget
        $backupDir = Split-Path -Parent $backupPath
        
        if (-not (Test-Path $backupDir)) {
            New-Item -ItemType Directory -Path $backupDir -Force | Out-Null
        }
        
        if (Test-Path $Target -PathType Container) {
            Copy-Item -Path $Target -Destination $backupPath -Recurse -Force
        } else {
            Copy-Item -Path $Target -Destination $backupPath -Force
        }
        
        $result.Success = $true
        $result.BackupPath = $backupPath
        
    } catch {
        $result.Error = $_.Exception.Message
    }
    
    return $result
}

# Functions exported: Read-TextFileUtf8, Write-TextFileUtf8Atomic, Test-ContentIdentical, Expand-RestorePathHelper, Invoke-RestoreBackup
