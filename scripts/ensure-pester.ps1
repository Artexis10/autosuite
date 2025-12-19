<#
.SYNOPSIS
    Ensures vendored Pester 5.x is available and imported.

.DESCRIPTION
    Pester is vendored in tools/pester/ for deterministic, offline-capable test execution.
    This script treats tools/pester/ as the authoritative Pester source.
    
    If vendored Pester is missing, it bootstraps using Save-Module with RequiredVersion 5.7.1.
    The vendored path is prepended to $env:PSModulePath for the current process.

.PARAMETER MinimumVersion
    Minimum Pester version required. Default: 5.5.0

.EXAMPLE
    .\scripts\ensure-pester.ps1
    Ensures vendored Pester is available and prepends to PSModulePath.

.NOTES
    This repo values hermetic, deterministic, offline-capable tooling.
    Tests always use vendored Pester first, never global modules.
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [Version]$MinimumVersion = "5.5.0"
)

$ErrorActionPreference = "Stop"
$script:RepoRoot = Split-Path -Parent $PSScriptRoot
$script:VendorPath = Join-Path $script:RepoRoot "tools\pester"
$script:RequiredVersion = "5.7.1"

function Get-VendoredPester {
    if (-not (Test-Path $script:VendorPath)) {
        return $null
    }
    
    # Enumerate all Pester.psd1 files and select highest version >= MinimumVersion
    $pesterManifests = Get-ChildItem -Path $script:VendorPath -Filter "Pester.psd1" -Recurse
    if (-not $pesterManifests) {
        return $null
    }
    
    $bestMatch = $null
    $bestVersion = $null
    
    foreach ($manifest in $pesterManifests) {
        try {
            $data = Import-PowerShellDataFile -Path $manifest.FullName
            $version = [Version]$data.ModuleVersion
            
            if ($version -ge $MinimumVersion) {
                if (-not $bestVersion -or $version -gt $bestVersion) {
                    $bestVersion = $version
                    $bestMatch = $manifest.FullName
                }
            }
        } catch {
            Write-Host "[ensure-pester] Warning: Could not read manifest $($manifest.FullName): $_" -ForegroundColor Yellow
        }
    }
    
    return $bestMatch
}

function Install-VendoredPester {
    Write-Host "[ensure-pester] Bootstrapping Pester $script:RequiredVersion to $script:VendorPath..." -ForegroundColor Cyan
    
    if (-not (Test-Path $script:VendorPath)) {
        New-Item -ItemType Directory -Path $script:VendorPath -Force | Out-Null
    }
    
    try {
        Save-Module -Name Pester -Path $script:VendorPath -RequiredVersion $script:RequiredVersion -Force -Repository PSGallery
        Write-Host "[ensure-pester] Pester $script:RequiredVersion installed to vendor path." -ForegroundColor Green
        return Get-VendoredPester
    } catch {
        Write-Host "[ensure-pester] ERROR: Failed to bootstrap Pester: $_" -ForegroundColor Red
        return $null
    }
}

function Set-VendoredModulePath {
    # Prepend tools/pester to PSModulePath so vendored Pester takes precedence
    if ($env:PSModulePath -notlike "*$script:VendorPath*") {
        $env:PSModulePath = "$script:VendorPath$([IO.Path]::PathSeparator)$env:PSModulePath"
        Write-Host "[ensure-pester] Prepended vendor path to PSModulePath" -ForegroundColor DarkGray
    }
}

# Main logic
Write-Host "[ensure-pester] Checking for vendored Pester >= $MinimumVersion..." -ForegroundColor Cyan

# 1. Check vendored path (authoritative source)
$vendoredPath = Get-VendoredPester
if (-not $vendoredPath) {
    # 2. Bootstrap if missing
    $vendoredPath = Install-VendoredPester
}

if (-not $vendoredPath) {
    Write-Host "[ensure-pester] ERROR: Could not ensure vendored Pester is available." -ForegroundColor Red
    Write-Host "[ensure-pester] Run: Save-Module Pester -Path tools/pester -RequiredVersion $script:RequiredVersion" -ForegroundColor Yellow
    exit 1
}

# 3. Prepend vendor path to PSModulePath
Set-VendoredModulePath

# 4. Import the vendored Pester module explicitly
Write-Host "[ensure-pester] Importing vendored Pester from: $vendoredPath" -ForegroundColor DarkGray
Import-Module $vendoredPath -Force -Global

# 5. Verify Pester is loaded and meets MinimumVersion
$loadedPester = Get-Module -Name Pester
if (-not $loadedPester) {
    Write-Host "[ensure-pester] ERROR: Pester module not loaded after import." -ForegroundColor Red
    exit 1
}

if ($loadedPester.Version -lt $MinimumVersion) {
    Write-Host "[ensure-pester] ERROR: Loaded Pester $($loadedPester.Version) does not meet minimum $MinimumVersion" -ForegroundColor Red
    exit 1
}

Write-Host "[ensure-pester] Pester $($loadedPester.Version) loaded successfully." -ForegroundColor Green
return $vendoredPath
