<#
.SYNOPSIS
    Run Pester tests for Provisioning.

.DESCRIPTION
    Executes unit tests in the provisioning/tests/unit directory.
    Avoids integration tests that spawn external processes.
    Requires Pester module (Install-Module Pester -Force -SkipPublisherCheck).

.PARAMETER IncludeIntegration
    Also run integration tests (cli.tests.ps1, capture.tests.ps1).
    These may be slow or require external tools like winget.

.EXAMPLE
    .\run-tests.ps1
    Run unit tests only (fast, no external dependencies).

.EXAMPLE
    .\run-tests.ps1 -IncludeIntegration
    Run all tests including integration tests.
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [switch]$IncludeIntegration
)

$ErrorActionPreference = "Stop"

# Ensure Pester is available
$pester = Get-Module -ListAvailable -Name Pester | Sort-Object Version -Descending | Select-Object -First 1

if (-not $pester) {
    Write-Host "[ERROR] Pester module not found." -ForegroundColor Red
    Write-Host ""
    Write-Host "Install Pester with:" -ForegroundColor Yellow
    Write-Host "  Install-Module Pester -Force -SkipPublisherCheck" -ForegroundColor DarkGray
    Write-Host ""
    exit 1
}

Write-Host ""
Write-Host "Provisioning Tests" -ForegroundColor Cyan
Write-Host "==================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Pester version: $($pester.Version)" -ForegroundColor DarkGray

# Build explicit test paths - unit tests only by default
$unitTestDir = Join-Path $PSScriptRoot "unit"
$testPaths = @()

if (Test-Path $unitTestDir) {
    $unitTests = Get-ChildItem -Path $unitTestDir -Filter "*.Tests.ps1" -File
    foreach ($test in $unitTests) {
        $testPaths += $test.FullName
    }
}

if ($IncludeIntegration) {
    Write-Host "Mode: Unit + Integration tests" -ForegroundColor Yellow
    # Add integration tests from root tests directory
    $integrationTests = Get-ChildItem -Path $PSScriptRoot -Filter "*.tests.ps1" -File
    foreach ($test in $integrationTests) {
        $testPaths += $test.FullName
    }
} else {
    Write-Host "Mode: Unit tests only (use -IncludeIntegration for all)" -ForegroundColor DarkGray
}

Write-Host "Test files: $($testPaths.Count)" -ForegroundColor DarkGray
Write-Host ""

if ($testPaths.Count -eq 0) {
    Write-Host "[WARN] No test files found." -ForegroundColor Yellow
    exit 0
}

# Import Pester
Import-Module Pester -Force

# Run tests based on Pester version
if ($pester.Version -ge [Version]"5.0.0") {
    # Pester 5.x configuration
    $config = New-PesterConfiguration
    $config.Run.Path = $testPaths
    $config.Run.Exit = $false
    $config.Output.Verbosity = "Detailed"
    $config.TestResult.Enabled = $true
    $config.TestResult.OutputPath = Join-Path $PSScriptRoot "test-results.xml"
    
    $result = Invoke-Pester -Configuration $config
    $failedCount = $result.FailedCount
} else {
    # Pester 3.x/4.x legacy mode
    Write-Host "[INFO] Using Pester legacy mode (v$($pester.Version))" -ForegroundColor Yellow
    Write-Host ""
    
    $result = Invoke-Pester -Path $testPaths -PassThru
    $failedCount = $result.FailedCount
}

# Summary
Write-Host ""
if ($failedCount -eq 0) {
    Write-Host "All tests passed!" -ForegroundColor Green
} else {
    Write-Host "$failedCount test(s) failed." -ForegroundColor Red
}

exit $failedCount
