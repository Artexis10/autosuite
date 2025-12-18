<#
.SYNOPSIS
    External process wrapper for Provisioning.

.DESCRIPTION
    Provides mockable wrappers around external process calls (winget, etc.).
    All external calls should go through these functions to enable testing.
#>

function Invoke-WingetList {
    <#
    .SYNOPSIS
        Wrapper for winget list command.
    .DESCRIPTION
        Returns raw output from winget list. Mockable for testing.
    #>
    param(
        [Parameter(Mandatory = $false)]
        [string]$PackageId
    )
    
    $wingetArgs = @("list", "--accept-source-agreements")
    if ($PackageId) {
        $wingetArgs += @("--id", $PackageId)
    }
    
    try {
        $output = & winget @wingetArgs 2>&1
        return $output
    } catch {
        return $null
    }
}

function Invoke-WingetInstall {
    <#
    .SYNOPSIS
        Wrapper for winget install command.
    .DESCRIPTION
        Installs a package via winget. Mockable for testing.
    #>
    param(
        [Parameter(Mandatory = $true)]
        [string]$PackageId,
        
        [Parameter(Mandatory = $false)]
        [switch]$Silent
    )
    
    $installArgs = @(
        "install"
        "--id", $PackageId
        "--accept-source-agreements"
        "--accept-package-agreements"
    )
    
    if ($Silent) {
        $installArgs += "--silent"
    }
    
    try {
        $output = & winget @installArgs 2>&1
        return @{
            Output = $output
            ExitCode = $LASTEXITCODE
        }
    } catch {
        return @{
            Output = $_.Exception.Message
            ExitCode = 1
        }
    }
}

function Invoke-WingetExportWrapper {
    <#
    .SYNOPSIS
        Wrapper for winget export command.
    .DESCRIPTION
        Exports installed packages to JSON. Mockable for testing.
    #>
    param(
        [Parameter(Mandatory = $true)]
        [string]$ExportPath
    )
    
    try {
        & winget export -o $ExportPath --accept-source-agreements 2>&1 | Out-Null
        return $LASTEXITCODE -eq 0
    } catch {
        return $false
    }
}

function Test-CommandExists {
    <#
    .SYNOPSIS
        Check if a command/executable exists in PATH.
    .DESCRIPTION
        Returns true if the command is resolvable. Mockable for testing.
    #>
    param(
        [Parameter(Mandatory = $true)]
        [string]$CommandName
    )
    
    try {
        $null = Get-Command $CommandName -ErrorAction Stop
        return $true
    } catch {
        return $false
    }
}

function Get-RegistryValue {
    <#
    .SYNOPSIS
        Get a registry value. Windows only.
    .DESCRIPTION
        Returns registry value or null if not found. Mockable for testing.
    #>
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path,
        
        [Parameter(Mandatory = $false)]
        [string]$Name
    )
    
    try {
        if ($Name) {
            return Get-ItemPropertyValue -Path $Path -Name $Name -ErrorAction Stop
        } else {
            return Test-Path $Path
        }
    } catch {
        return $null
    }
}

# Functions exported: Invoke-WingetList, Invoke-WingetInstall, Invoke-WingetExportWrapper, Test-CommandExists, Get-RegistryValue
