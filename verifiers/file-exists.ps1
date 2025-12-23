# Copyright 2025 Substrate Systems OÜ
# SPDX-License-Identifier: Apache-2.0

<#
.SYNOPSIS
    File-exists verifier for Provisioning.

.DESCRIPTION
    Verifies that a file or directory exists at the specified path.
#>

function Test-FileExistsVerifier {
    <#
    .SYNOPSIS
        Verify that a file or directory exists.
    #>
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path
    )
    
    $result = @{
        Success = $false
        Message = ""
        Path = $Path
    }
    
    # Expand environment variables
    $expandedPath = [Environment]::ExpandEnvironmentVariables($Path)
    
    # Handle ~ for home directory
    if ($expandedPath.StartsWith("~")) {
        $expandedPath = $expandedPath -replace "^~", $env:USERPROFILE
    }
    
    if (Test-Path $expandedPath) {
        $item = Get-Item $expandedPath
        if ($item.PSIsContainer) {
            $result.Success = $true
            $result.Message = "Directory exists: $expandedPath"
        } else {
            $result.Success = $true
            $result.Message = "File exists: $expandedPath ($($item.Length) bytes)"
        }
    } else {
        $result.Success = $false
        $result.Message = "Path does not exist: $expandedPath"
    }
    
    return $result
}

# Functions exported: Test-FileExistsVerifier
