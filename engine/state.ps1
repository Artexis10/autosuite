<#
.SYNOPSIS
    Provisioning state management.

.DESCRIPTION
    Records run history, manifest hashes, and action outcomes.
#>

function Get-ManifestHash {
    param(
        [Parameter(Mandatory = $true)]
        [string]$ManifestPath
    )
    
    if (-not (Test-Path $ManifestPath)) {
        return $null
    }
    
    $hash = Get-FileHash -Path $ManifestPath -Algorithm SHA256
    return $hash.Hash.Substring(0, 16)
}

function Save-RunState {
    param(
        [Parameter(Mandatory = $true)]
        [string]$RunId,
        
        [Parameter(Mandatory = $false)]
        [string]$ManifestPath,
        
        [Parameter(Mandatory = $false)]
        [string]$ManifestHash,
        
        [Parameter(Mandatory = $true)]
        [string]$Command,
        
        [Parameter(Mandatory = $false)]
        [bool]$DryRun = $false,
        
        [Parameter(Mandatory = $false)]
        [array]$Actions = @(),
        
        [Parameter(Mandatory = $false)]
        [int]$SuccessCount = 0,
        
        [Parameter(Mandatory = $false)]
        [int]$SkipCount = 0,
        
        [Parameter(Mandatory = $false)]
        [int]$FailCount = 0
    )
    
    $stateDir = Join-Path $PSScriptRoot "..\state"
    if (-not (Test-Path $stateDir)) {
        New-Item -ItemType Directory -Path $stateDir -Force | Out-Null
    }
    
    $stateFile = Join-Path $stateDir "$RunId.json"
    
    $state = @{
        runId = $RunId
        timestamp = Get-Date -Format "yyyy-MM-ddTHH:mm:ssZ"
        machine = $env:COMPUTERNAME
        user = $env:USERNAME
        command = $Command
        dryRun = $DryRun
        manifest = @{
            path = $ManifestPath
            hash = $ManifestHash
        }
        summary = @{
            success = $SuccessCount
            skipped = $SkipCount
            failed = $FailCount
        }
        actions = $Actions
    }
    
    $state | ConvertTo-Json -Depth 10 | Out-File -FilePath $stateFile -Encoding UTF8
    
    return $stateFile
}

function Get-LastRunState {
    $stateDir = Join-Path $PSScriptRoot "..\state"
    
    if (-not (Test-Path $stateDir)) {
        return $null
    }
    
    $stateFiles = Get-ChildItem -Path $stateDir -Filter "*.json" | Sort-Object Name -Descending
    
    if ($stateFiles.Count -eq 0) {
        return $null
    }
    
    $lastState = Get-Content -Path $stateFiles[0].FullName -Raw | ConvertFrom-Json
    return $lastState
}

function Get-RunHistory {
    param(
        [Parameter(Mandatory = $false)]
        [int]$Limit = 10
    )
    
    $stateDir = Join-Path $PSScriptRoot "..\state"
    
    if (-not (Test-Path $stateDir)) {
        return @()
    }
    
    $stateFiles = Get-ChildItem -Path $stateDir -Filter "*.json" | Sort-Object Name -Descending | Select-Object -First $Limit
    
    $history = @()
    foreach ($file in $stateFiles) {
        try {
            $state = Get-Content -Path $file.FullName -Raw | ConvertFrom-Json
            $history += $state
        } catch {
            # Skip corrupted state files
        }
    }
    
    return $history
}

# Functions exported: Get-ManifestHash, Save-RunState, Get-LastRunState, Get-RunHistory
