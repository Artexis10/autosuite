<#
.SYNOPSIS
    Provisioning verify - runs verifiers only without modifying state.

.DESCRIPTION
    Reads a manifest and runs all verification steps to check
    if the current machine state matches the desired state.
#>

# Import dependencies
. "$PSScriptRoot\logging.ps1"
. "$PSScriptRoot\manifest.ps1"
. "$PSScriptRoot\state.ps1"
. "$PSScriptRoot\..\drivers\winget.ps1"
. "$PSScriptRoot\..\verifiers\file-exists.ps1"

function Invoke-Verify {
    param(
        [Parameter(Mandatory = $true)]
        [string]$ManifestPath
    )
    
    $runId = Get-RunId
    Initialize-ProvisioningLog -RunId "verify-$runId" | Out-Null
    
    Write-ProvisioningSection "Provisioning Verify"
    Write-ProvisioningLog "Manifest: $ManifestPath" -Level INFO
    Write-ProvisioningLog "Run ID: $runId" -Level INFO
    
    # Read manifest
    if (-not (Test-Path $ManifestPath)) {
        Write-ProvisioningLog "Manifest not found: $ManifestPath" -Level ERROR
        return $null
    }
    
    $manifest = Read-Manifest -Path $ManifestPath
    Write-ProvisioningLog "Manifest loaded: $($manifest.name)" -Level SUCCESS
    
    # Get installed apps
    Write-ProvisioningSection "Verifying Applications"
    $installedApps = Get-InstalledAppsFromWinget
    
    $passCount = 0
    $failCount = 0
    $results = @()
    
    foreach ($app in $manifest.apps) {
        $windowsRef = $app.refs.windows
        if (-not $windowsRef) { continue }
        
        $isInstalled = $installedApps -contains $windowsRef
        
        $result = @{
            type = "app"
            id = $app.id
            ref = $windowsRef
        }
        
        if ($isInstalled) {
            Write-ProvisioningLog "$windowsRef - INSTALLED" -Level SUCCESS
            $result.status = "pass"
            $passCount++
        } else {
            Write-ProvisioningLog "$windowsRef - NOT INSTALLED" -Level ERROR
            $result.status = "fail"
            $failCount++
        }
        
        $results += $result
    }
    
    # Run explicit verify items
    if ($manifest.verify -and $manifest.verify.Count -gt 0) {
        Write-ProvisioningSection "Running Verifiers"
        
        foreach ($item in $manifest.verify) {
            $result = @{
                type = "verify"
                verifyType = $item.type
            }
            
            $verifyResult = $null
            
            switch ($item.type) {
                "file-exists" {
                    $result.path = $item.path
                    $verifyResult = Test-FileExistsVerifier -Path $item.path
                }
                "command-succeeds" {
                    $result.command = $item.command
                    # Future: implement command verification
                    $verifyResult = @{ Success = $true; Message = "Command verification not yet implemented" }
                }
                default {
                    $verifyResult = @{ Success = $false; Message = "Unknown verify type: $($item.type)" }
                }
            }
            
            if ($verifyResult.Success) {
                Write-ProvisioningLog "PASS: $($item.type) - $($verifyResult.Message)" -Level SUCCESS
                $result.status = "pass"
                $passCount++
            } else {
                Write-ProvisioningLog "FAIL: $($item.type) - $($verifyResult.Message)" -Level ERROR
                $result.status = "fail"
                $failCount++
            }
            
            $results += $result
        }
    }
    
    # Summary
    Write-ProvisioningSection "Verification Results"
    Close-ProvisioningLog -SuccessCount $passCount -SkipCount 0 -FailCount $failCount
    
    Write-Host ""
    if ($failCount -eq 0) {
        Write-Host "All verifications passed!" -ForegroundColor Green
    } else {
        Write-Host "$failCount verification(s) failed." -ForegroundColor Yellow
        Write-Host ""
        Write-Host "To fix missing items:" -ForegroundColor Yellow
        Write-Host "  .\cli.ps1 -Command apply -Manifest `"$ManifestPath`""
    }
    Write-Host ""
    
    return @{
        RunId = $runId
        Pass = $passCount
        Fail = $failCount
        Results = $results
    }
}

# Functions exported: Invoke-Verify
