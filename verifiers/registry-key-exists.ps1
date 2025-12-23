# Copyright 2025 Substrate Systems OÜ
# SPDX-License-Identifier: Apache-2.0

<#
.SYNOPSIS
    Registry-key-exists verifier for Provisioning.

.DESCRIPTION
    Verifies that a registry key or value exists. Windows only.
#>

function Test-RegistryKeyExistsVerifier {
    <#
    .SYNOPSIS
        Verify that a registry key or value exists.
    #>
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path,
        
        [Parameter(Mandatory = $false)]
        [string]$Name
    )
    
    $result = @{
        Success = $false
        Message = ""
        Path = $Path
        Name = $Name
    }
    
    # Check if running on Windows
    if ($env:OS -ne "Windows_NT" -and -not $IsWindows) {
        $result.Success = $false
        $result.Message = "Registry verification only supported on Windows"
        return $result
    }
    
    try {
        if ($Name) {
            # Check for specific value
            $value = Get-ItemPropertyValue -Path $Path -Name $Name -ErrorAction Stop
            $result.Success = $true
            $result.Message = "Registry value exists: $Path\$Name = $value"
        } else {
            # Check for key existence
            if (Test-Path $Path) {
                $result.Success = $true
                $result.Message = "Registry key exists: $Path"
            } else {
                $result.Success = $false
                $result.Message = "Registry key not found: $Path"
            }
        }
    } catch {
        $result.Success = $false
        $result.Message = "Registry check failed: $($_.Exception.Message)"
    }
    
    return $result
}

# Functions exported: Test-RegistryKeyExistsVerifier
