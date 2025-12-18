<#
.SYNOPSIS
    Pester tests for report schema validation and serialization stability.
#>

$script:ProvisioningRoot = Join-Path $PSScriptRoot "..\..\"
$script:ManifestScript = Join-Path $script:ProvisioningRoot "engine\manifest.ps1"
$script:StateScript = Join-Path $script:ProvisioningRoot "engine\state.ps1"
$script:PlanScript = Join-Path $script:ProvisioningRoot "engine\plan.ps1"
$script:LoggingScript = Join-Path $script:ProvisioningRoot "engine\logging.ps1"
$script:FixturesDir = Join-Path $PSScriptRoot "..\fixtures"

# Load dependencies (Pester 3.x compatible - no BeforeAll at script level)
. $script:LoggingScript
. $script:ManifestScript
. $script:StateScript

# Load plan.ps1 functions without re-dot-sourcing dependencies
$planContent = Get-Content -Path $script:PlanScript -Raw
$functionsOnly = $planContent -replace '\. "\$PSScriptRoot\\[^"]+\.ps1"', '# (dependency already loaded)'
Invoke-Expression $functionsOnly

Describe "Report.Schema" {
    
    Context "Required fields exist" {
        
        It "Should have timestamp field" {
            $yamlPath = Join-Path $script:FixturesDir "sample-manifest.jsonc"
            $manifest = Read-Manifest -Path $yamlPath
            $hash = Get-ManifestHash -ManifestPath $yamlPath
            $plan = New-PlanFromManifest -Manifest $manifest -ManifestPath $yamlPath -ManifestHash $hash -RunId "20250101-000000" -Timestamp "2025-01-01T00:00:00Z" -InstalledApps @("Test.App2")
            $reportJson = ConvertTo-ReportJson -Plan $plan
            $report = $reportJson | ConvertFrom-Json -AsHashtable
            $report.ContainsKey('timestamp') | Should Be $true
            $report.timestamp | Should Not BeNullOrEmpty
        }
        
        It "Should have runId field" {
            $yamlPath = Join-Path $script:FixturesDir "sample-manifest.jsonc"
            $manifest = Read-Manifest -Path $yamlPath
            $hash = Get-ManifestHash -ManifestPath $yamlPath
            $plan = New-PlanFromManifest -Manifest $manifest -ManifestPath $yamlPath -ManifestHash $hash -RunId "20250101-000000" -Timestamp "2025-01-01T00:00:00Z" -InstalledApps @("Test.App2")
            $reportJson = ConvertTo-ReportJson -Plan $plan
            $report = $reportJson | ConvertFrom-Json -AsHashtable
            $report.ContainsKey('runId') | Should Be $true
            $report.runId | Should Not BeNullOrEmpty
        }
        
        It "Should have manifest.hash field" {
            $yamlPath = Join-Path $script:FixturesDir "sample-manifest.jsonc"
            $manifest = Read-Manifest -Path $yamlPath
            $hash = Get-ManifestHash -ManifestPath $yamlPath
            $plan = New-PlanFromManifest -Manifest $manifest -ManifestPath $yamlPath -ManifestHash $hash -RunId "20250101-000000" -Timestamp "2025-01-01T00:00:00Z" -InstalledApps @("Test.App2")
            $reportJson = ConvertTo-ReportJson -Plan $plan
            $report = $reportJson | ConvertFrom-Json -AsHashtable
            $report.manifest.ContainsKey('hash') | Should Be $true
            $report.manifest.hash | Should Not BeNullOrEmpty
        }
        
        It "Should have manifest.path field" {
            $yamlPath = Join-Path $script:FixturesDir "sample-manifest.jsonc"
            $manifest = Read-Manifest -Path $yamlPath
            $hash = Get-ManifestHash -ManifestPath $yamlPath
            $plan = New-PlanFromManifest -Manifest $manifest -ManifestPath $yamlPath -ManifestHash $hash -RunId "20250101-000000" -Timestamp "2025-01-01T00:00:00Z" -InstalledApps @("Test.App2")
            $reportJson = ConvertTo-ReportJson -Plan $plan
            $report = $reportJson | ConvertFrom-Json -AsHashtable
            $report.manifest.ContainsKey('path') | Should Be $true
            $report.manifest.path | Should Not BeNullOrEmpty
        }
        
        It "Should have summary fields" {
            $yamlPath = Join-Path $script:FixturesDir "sample-manifest.jsonc"
            $manifest = Read-Manifest -Path $yamlPath
            $hash = Get-ManifestHash -ManifestPath $yamlPath
            $plan = New-PlanFromManifest -Manifest $manifest -ManifestPath $yamlPath -ManifestHash $hash -RunId "20250101-000000" -Timestamp "2025-01-01T00:00:00Z" -InstalledApps @("Test.App2")
            $reportJson = ConvertTo-ReportJson -Plan $plan
            $report = $reportJson | ConvertFrom-Json -AsHashtable
            $report.summary.ContainsKey('install') | Should Be $true
            $report.summary.ContainsKey('skip') | Should Be $true
            $report.summary.ContainsKey('restore') | Should Be $true
            $report.summary.ContainsKey('verify') | Should Be $true
        }
        
        It "Should have actions array" {
            $yamlPath = Join-Path $script:FixturesDir "sample-manifest.jsonc"
            $manifest = Read-Manifest -Path $yamlPath
            $hash = Get-ManifestHash -ManifestPath $yamlPath
            $plan = New-PlanFromManifest -Manifest $manifest -ManifestPath $yamlPath -ManifestHash $hash -RunId "20250101-000000" -Timestamp "2025-01-01T00:00:00Z" -InstalledApps @("Test.App2")
            $reportJson = ConvertTo-ReportJson -Plan $plan
            $report = $reportJson | ConvertFrom-Json -AsHashtable
            $report.ContainsKey('actions') | Should Be $true
        }
    }
    
    Context "Action schema validation" {
        
        It "Should have type and status fields on all actions" {
            $yamlPath = Join-Path $script:FixturesDir "sample-manifest.jsonc"
            $manifest = Read-Manifest -Path $yamlPath
            $hash = Get-ManifestHash -ManifestPath $yamlPath
            $plan = New-PlanFromManifest -Manifest $manifest -ManifestPath $yamlPath -ManifestHash $hash -RunId "20250101-000000" -Timestamp "2025-01-01T00:00:00Z" -InstalledApps @("Test.App2")
            $reportJson = ConvertTo-ReportJson -Plan $plan
            $report = $reportJson | ConvertFrom-Json -AsHashtable
            foreach ($action in $report.actions) {
                $action.ContainsKey('type') | Should Be $true
                $action.ContainsKey('status') | Should Be $true
            }
        }
        
        It "Should have driver, id, and ref fields on app actions" {
            $yamlPath = Join-Path $script:FixturesDir "sample-manifest.jsonc"
            $manifest = Read-Manifest -Path $yamlPath
            $hash = Get-ManifestHash -ManifestPath $yamlPath
            $plan = New-PlanFromManifest -Manifest $manifest -ManifestPath $yamlPath -ManifestHash $hash -RunId "20250101-000000" -Timestamp "2025-01-01T00:00:00Z" -InstalledApps @("Test.App2")
            $reportJson = ConvertTo-ReportJson -Plan $plan
            $report = $reportJson | ConvertFrom-Json -AsHashtable
            $appActions = $report.actions | Where-Object { $_.type -eq "app" }
            foreach ($action in $appActions) {
                $action.ContainsKey('driver') | Should Be $true
                $action.ContainsKey('id') | Should Be $true
                $action.ContainsKey('ref') | Should Be $true
            }
        }
    }
    
    Context "Serialization stability" {
        
        It "Should produce identical JSON on repeated serialization" {
            $yamlPath = Join-Path $script:FixturesDir "sample-manifest.jsonc"
            $manifest = Read-Manifest -Path $yamlPath
            $hash = Get-ManifestHash -ManifestPath $yamlPath
            
            $plan = New-PlanFromManifest `
                -Manifest $manifest `
                -ManifestPath $yamlPath `
                -ManifestHash $hash `
                -RunId "20250101-000000" `
                -Timestamp "2025-01-01T00:00:00Z" `
                -InstalledApps @("Test.App2")
            
            $json1 = ConvertTo-ReportJson -Plan $plan
            $json2 = ConvertTo-ReportJson -Plan $plan
            
            $json1 | Should Be $json2
        }
        
        It "Should produce valid JSON" {
            $yamlPath = Join-Path $script:FixturesDir "sample-manifest.jsonc"
            $manifest = Read-Manifest -Path $yamlPath
            $hash = Get-ManifestHash -ManifestPath $yamlPath
            
            $plan = New-PlanFromManifest `
                -Manifest $manifest `
                -ManifestPath $yamlPath `
                -ManifestHash $hash `
                -RunId "20250101-000000" `
                -Timestamp "2025-01-01T00:00:00Z" `
                -InstalledApps @()
            
            $json = ConvertTo-ReportJson -Plan $plan
            
            # Should not throw when parsing
            { $json | ConvertFrom-Json } | Should Not Throw
        }
        
        It "Should have deterministic key ordering in manifest section" {
            $yamlPath = Join-Path $script:FixturesDir "sample-manifest.jsonc"
            $manifest = Read-Manifest -Path $yamlPath
            $hash = Get-ManifestHash -ManifestPath $yamlPath
            
            $plan = New-PlanFromManifest `
                -Manifest $manifest `
                -ManifestPath $yamlPath `
                -ManifestHash $hash `
                -RunId "20250101-000000" `
                -Timestamp "2025-01-01T00:00:00Z" `
                -InstalledApps @()
            
            $json = ConvertTo-ReportJson -Plan $plan
            
            # Check that manifest keys appear in expected order
            $manifestMatch = [regex]::Match($json, '"manifest":\s*\{([^}]+)\}')
            $manifestContent = $manifestMatch.Groups[1].Value
            
            $pathIndex = $manifestContent.IndexOf('"path"')
            $nameIndex = $manifestContent.IndexOf('"name"')
            $hashIndex = $manifestContent.IndexOf('"hash"')
            
            $pathIndex | Should BeLessThan $nameIndex
            $nameIndex | Should BeLessThan $hashIndex
        }
        
        It "Should have deterministic key ordering in summary section" {
            $yamlPath = Join-Path $script:FixturesDir "sample-manifest.jsonc"
            $manifest = Read-Manifest -Path $yamlPath
            $hash = Get-ManifestHash -ManifestPath $yamlPath
            
            $plan = New-PlanFromManifest `
                -Manifest $manifest `
                -ManifestPath $yamlPath `
                -ManifestHash $hash `
                -RunId "20250101-000000" `
                -Timestamp "2025-01-01T00:00:00Z" `
                -InstalledApps @()
            
            $json = ConvertTo-ReportJson -Plan $plan
            
            # Check that summary keys appear in expected order
            $summaryMatch = [regex]::Match($json, '"summary":\s*\{([^}]+)\}')
            $summaryContent = $summaryMatch.Groups[1].Value
            
            $installIndex = $summaryContent.IndexOf('"install"')
            $skipIndex = $summaryContent.IndexOf('"skip"')
            $restoreIndex = $summaryContent.IndexOf('"restore"')
            $verifyIndex = $summaryContent.IndexOf('"verify"')
            
            $installIndex | Should BeLessThan $skipIndex
            $skipIndex | Should BeLessThan $restoreIndex
            $restoreIndex | Should BeLessThan $verifyIndex
        }
    }
    
    Context "Sample fixture validation" {
        
        It "Should match expected schema from sample-plan-output.json" {
            $samplePath = Join-Path $script:FixturesDir "sample-plan-output.json"
            $sample = Get-Content -Path $samplePath -Raw | ConvertFrom-Json -AsHashtable
            
            # Validate sample has all required fields
            $sample.ContainsKey('runId') | Should Be $true
            $sample.ContainsKey('timestamp') | Should Be $true
            $sample.ContainsKey('manifest') | Should Be $true
            $sample.manifest.ContainsKey('hash') | Should Be $true
            $sample.manifest.ContainsKey('path') | Should Be $true
            $sample.ContainsKey('summary') | Should Be $true
            $sample.summary.ContainsKey('install') | Should Be $true
            $sample.summary.ContainsKey('skip') | Should Be $true
            $sample.summary.ContainsKey('restore') | Should Be $true
            $sample.summary.ContainsKey('verify') | Should Be $true
            $sample.ContainsKey('actions') | Should Be $true
        }
    }
}
