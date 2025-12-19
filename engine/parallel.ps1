<#
.SYNOPSIS
    Parallel execution engine using RunspacePool (PS 5.1 compatible).

.DESCRIPTION
    Provides parallel app installation via RunspacePool.
    Designed for opt-in parallelism with safety controls:
    - Static denylist for unsafe apps (drivers, launchers, VPNs)
    - Throttled concurrency (default 3)
    - Thread-safe result collection
    - No global state mutation from runspaces
#>

# Static denylist of apps that should NOT be installed in parallel
# These apps have system-level side effects, require user interaction,
# or have installers that conflict when run concurrently.
$script:ParallelUnsafePatterns = @(
    'Docker.*',                    # Docker Desktop - system-level changes, WSL integration
    'Adobe.*',                     # Adobe CC - launcher-based, license activation
    '*VPN*',                       # VPNs - network stack modifications
    'NVIDIA.*',                    # GPU drivers
    'AMD.Radeon*',                 # GPU drivers
    'Intel.*Driver*',              # Intel drivers
    'Microsoft.VisualStudio.*',    # Large, interactive, modifies system
    'Valve.Steam',                 # Game launcher, creates services
    'EpicGames.EpicGamesLauncher', # Game launcher
    'GOG.Galaxy',                  # Game launcher
    'Microsoft.SQLServer*',        # Database server
    'Oracle.*',                    # Database/Java - system modifications
    'VMware.*',                    # Virtualization - kernel drivers
    'Citrix.*'                     # Enterprise software - system hooks
)

function Test-AppParallelSafe {
    <#
    .SYNOPSIS
        Check if an app is safe to install in parallel.
    .DESCRIPTION
        Returns $true if the app is not on the unsafe denylist.
        Uses wildcard pattern matching against the winget package ID.
    .PARAMETER PackageId
        The winget package ID to check.
    .OUTPUTS
        Boolean indicating if the app is safe for parallel installation.
    #>
    param(
        [Parameter(Mandatory = $true)]
        [string]$PackageId
    )
    
    foreach ($pattern in $script:ParallelUnsafePatterns) {
        if ($PackageId -like $pattern) {
            return $false
        }
    }
    
    return $true
}

function Get-ParallelUnsafePatterns {
    <#
    .SYNOPSIS
        Returns the list of unsafe app patterns for testing/inspection.
    #>
    return $script:ParallelUnsafePatterns
}

function Invoke-ParallelAppInstall {
    <#
    .SYNOPSIS
        Install multiple apps in parallel using RunspacePool.
    .DESCRIPTION
        Creates a RunspacePool with specified throttle limit and queues
        app installations. Each runspace executes independently with
        its own winget process. Results are collected thread-safely.
        
        PS 5.1 compatible - uses [System.Management.Automation.Runspaces].
    .PARAMETER Apps
        Array of app action objects with 'ref' (winget ID) and 'id' properties.
    .PARAMETER Throttle
        Maximum concurrent installations. Default: 3.
    .PARAMETER DryRun
        If true, simulate installations without executing.
    .PARAMETER WingetScriptPath
        Optional path to winget driver script for testing.
    .OUTPUTS
        Array of result objects with Success, PackageId, Message, SlotId properties.
    #>
    param(
        [Parameter(Mandatory = $true)]
        [array]$Apps,
        
        [Parameter(Mandatory = $false)]
        [int]$Throttle = 3,
        
        [Parameter(Mandatory = $false)]
        [switch]$DryRun,
        
        [Parameter(Mandatory = $false)]
        [string]$WingetScriptPath
    )
    
    if ($Apps.Count -eq 0) {
        return @()
    }
    
    # Ensure throttle is at least 1 and at most the number of apps
    $Throttle = [Math]::Max(1, [Math]::Min($Throttle, $Apps.Count))
    
    # Thread-safe collection for results
    $results = [System.Collections.ArrayList]::Synchronized([System.Collections.ArrayList]::new())
    
    # Create initial session state with required functions
    $initialSessionState = [System.Management.Automation.Runspaces.InitialSessionState]::CreateDefault()
    
    # Create runspace pool
    $runspacePool = [System.Management.Automation.Runspaces.RunspaceFactory]::CreateRunspacePool(1, $Throttle, $initialSessionState, $Host)
    $runspacePool.Open()
    
    # Track running jobs
    $jobs = [System.Collections.ArrayList]::new()
    $slotCounter = 0
    
    try {
        foreach ($app in $Apps) {
            $slotCounter++
            $slotId = $slotCounter
            $packageId = $app.ref
            $appId = $app.id
            
            # Create PowerShell instance for this app
            $ps = [System.Management.Automation.PowerShell]::Create()
            $ps.RunspacePool = $runspacePool
            
            # Script block to execute in runspace
            # Note: Must be self-contained - no external function calls
            $scriptBlock = {
                param(
                    [string]$PackageId,
                    [string]$AppId,
                    [int]$SlotId,
                    [bool]$IsDryRun,
                    [string]$WingetScript
                )
                
                $result = @{
                    Success = $false
                    PackageId = $PackageId
                    AppId = $AppId
                    SlotId = $SlotId
                    Message = ""
                    Output = @()
                    StartTime = Get-Date
                    EndTime = $null
                }
                
                try {
                    if ($IsDryRun) {
                        $result.Success = $true
                        $result.Message = "Would install (dry-run)"
                        $result.Output += "[PARALLEL-$SlotId] [DRY-RUN] Would install: $PackageId"
                    } else {
                        $result.Output += "[PARALLEL-$SlotId] Installing: $PackageId"
                        
                        # Execute winget install
                        if ($WingetScript -and (Test-Path $WingetScript)) {
                            # Use mock script for testing
                            $output = & $WingetScript install --id $PackageId --accept-source-agreements --accept-package-agreements 2>&1
                        } else {
                            # Real winget
                            $output = & winget install --id $PackageId --accept-source-agreements --accept-package-agreements 2>&1
                        }
                        
                        $outputStr = $output | Out-String
                        $exitCode = $LASTEXITCODE
                        
                        # Check for success indicators
                        if ($exitCode -eq 0 -or $outputStr -match "Successfully installed" -or $outputStr -match "Found an existing package") {
                            $result.Success = $true
                            $result.Message = "Installed successfully"
                            $result.Output += "[PARALLEL-$SlotId] [OK] $PackageId - Installed"
                        } elseif ($outputStr -match "No package found matching") {
                            $result.Success = $false
                            $result.Message = "Package not found"
                            $result.Output += "[PARALLEL-$SlotId] [ERROR] $PackageId - Package not found"
                        } else {
                            $result.Success = $false
                            $result.Message = "Installation failed (exit code: $exitCode)"
                            $result.Output += "[PARALLEL-$SlotId] [ERROR] $PackageId - Failed: $outputStr"
                        }
                    }
                } catch {
                    $result.Success = $false
                    $result.Message = "Exception: $($_.Exception.Message)"
                    $result.Output += "[PARALLEL-$SlotId] [ERROR] $PackageId - Exception: $($_.Exception.Message)"
                }
                
                $result.EndTime = Get-Date
                return $result
            }
            
            # Add script and parameters
            [void]$ps.AddScript($scriptBlock)
            [void]$ps.AddParameter('PackageId', $packageId)
            [void]$ps.AddParameter('AppId', $appId)
            [void]$ps.AddParameter('SlotId', $slotId)
            [void]$ps.AddParameter('IsDryRun', $DryRun.IsPresent)
            [void]$ps.AddParameter('WingetScript', $WingetScriptPath)
            
            # Start async execution
            $asyncResult = $ps.BeginInvoke()
            
            [void]$jobs.Add(@{
                PowerShell = $ps
                AsyncResult = $asyncResult
                PackageId = $packageId
                SlotId = $slotId
            })
        }
        
        # Wait for all jobs to complete and collect results
        foreach ($job in $jobs) {
            try {
                $jobResult = $job.PowerShell.EndInvoke($job.AsyncResult)
                if ($jobResult) {
                    [void]$results.Add($jobResult)
                }
            } catch {
                # Job failed - create error result
                [void]$results.Add(@{
                    Success = $false
                    PackageId = $job.PackageId
                    SlotId = $job.SlotId
                    Message = "Runspace error: $($_.Exception.Message)"
                    Output = @("[PARALLEL-$($job.SlotId)] [ERROR] $($job.PackageId) - Runspace error: $($_.Exception.Message)")
                })
            } finally {
                $job.PowerShell.Dispose()
            }
        }
        
    } finally {
        # Clean up runspace pool
        $runspacePool.Close()
        $runspacePool.Dispose()
    }
    
    return @($results)
}

function Split-AppsForParallel {
    <#
    .SYNOPSIS
        Partition apps into parallel-safe and sequential (unsafe) groups.
    .DESCRIPTION
        Uses the denylist to separate apps that can be installed in parallel
        from those that must be installed sequentially.
    .PARAMETER Apps
        Array of app action objects with 'ref' property (winget ID).
    .OUTPUTS
        Hashtable with 'Parallel' and 'Sequential' arrays.
    #>
    param(
        [Parameter(Mandatory = $false)]
        [AllowEmptyCollection()]
        [array]$Apps = @()
    )
    
    $parallel = @()
    $sequential = @()
    
    foreach ($app in $Apps) {
        if (-not $app.ref) {
            # No ref means skip anyway
            continue
        }
        
        if (Test-AppParallelSafe -PackageId $app.ref) {
            $parallel += $app
        } else {
            $sequential += $app
        }
    }
    
    return @{
        Parallel = $parallel
        Sequential = $sequential
    }
}

# Functions exported: Test-AppParallelSafe, Get-ParallelUnsafePatterns, Invoke-ParallelAppInstall, Split-AppsForParallel
