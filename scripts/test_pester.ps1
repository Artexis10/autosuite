<#
.SYNOPSIS
    Root test entrypoint for Pester tests.

.DESCRIPTION
    Runs all Pester tests in the provisioning/tests directory.
    Requires Pester 5.x module. Will error clearly if Pester is not installed.

.PARAMETER Path
    Optional path to specific test file or directory. Defaults to all tests.

.PARAMETER Tag
    Optional tag filter for running specific test categories.

.EXAMPLE
    .\scripts\test_pester.ps1
    Run all tests.

.EXAMPLE
    .\scripts\test_pester.ps1 -Path "provisioning/tests/unit"
    Run only unit tests.

.EXAMPLE
    .\scripts\test_pester.ps1 -Tag "Manifest"
    Run tests tagged with "Manifest".
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [string]$Path,
    
    [Parameter(Mandatory = $false)]
    [string[]]$Tag
)

$ErrorActionPreference = "Stop"
$script:RepoRoot = Split-Path -Parent $PSScriptRoot

# Ensure Pester is available
$pester = Get-Module -ListAvailable -Name Pester | Sort-Object Version -Descending | Select-Object -First 1

if (-not $pester) {
    Write-Host ""
    Write-Host "[ERROR] Pester module not found." -ForegroundColor Red
    Write-Host ""
    Write-Host "Install Pester with:" -ForegroundColor Yellow
    Write-Host "  Install-Module Pester -Force -SkipPublisherCheck" -ForegroundColor DarkGray
    Write-Host ""
    exit 1
}

if ($pester.Version -lt [Version]"5.0.0") {
    Write-Host ""
    Write-Host "[ERROR] Pester 5.x or higher is required. Found: $($pester.Version)" -ForegroundColor Red
    Write-Host ""
    Write-Host "Update Pester with:" -ForegroundColor Yellow
    Write-Host "  Install-Module Pester -Force -SkipPublisherCheck" -ForegroundColor DarkGray
    Write-Host ""
    exit 1
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host " Automation Suite - Pester Tests" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Pester version: $($pester.Version)" -ForegroundColor DarkGray
Write-Host "PowerShell: $($PSVersionTable.PSVersion)" -ForegroundColor DarkGray
Write-Host ""

# Import Pester
Import-Module Pester -Force -MinimumVersion "5.0.0"

# Determine test path
$testPath = if ($Path) {
    if ([System.IO.Path]::IsPathRooted($Path)) {
        $Path
    } else {
        Join-Path $script:RepoRoot $Path
    }
} else {
    Join-Path $script:RepoRoot "provisioning\tests"
}

if (-not (Test-Path $testPath)) {
    Write-Host "[ERROR] Test path not found: $testPath" -ForegroundColor Red
    exit 1
}

Write-Host "Test path: $testPath" -ForegroundColor DarkGray
Write-Host ""

# Configure Pester
$config = New-PesterConfiguration

$config.Run.Path = $testPath
$config.Run.Exit = $true
$config.Run.PassThru = $true

$config.Output.Verbosity = "Detailed"
$config.Output.StackTraceVerbosity = "Filtered"

$config.TestResult.Enabled = $true
$config.TestResult.OutputPath = Join-Path $script:RepoRoot "provisioning\tests\test-results.xml"
$config.TestResult.OutputFormat = "NUnitXml"

$config.Should.ErrorAction = "Continue"

# Apply tag filter if specified
if ($Tag) {
    $config.Filter.Tag = $Tag
}

# Run tests
Write-Host "Running tests..." -ForegroundColor Cyan
Write-Host ""

$result = Invoke-Pester -Configuration $config

# Summary
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host " Test Summary" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "  Total:   $($result.TotalCount)" -ForegroundColor White
Write-Host "  Passed:  $($result.PassedCount)" -ForegroundColor Green
Write-Host "  Failed:  $($result.FailedCount)" -ForegroundColor $(if ($result.FailedCount -gt 0) { "Red" } else { "Green" })
Write-Host "  Skipped: $($result.SkippedCount)" -ForegroundColor DarkGray
Write-Host ""

if ($result.FailedCount -eq 0) {
    Write-Host "All tests passed!" -ForegroundColor Green
} else {
    Write-Host "$($result.FailedCount) test(s) failed." -ForegroundColor Red
}

Write-Host ""

exit $result.FailedCount
