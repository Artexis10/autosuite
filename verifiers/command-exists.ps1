<#
.SYNOPSIS
    Command-exists verifier for Provisioning.

.DESCRIPTION
    Verifies that a command/executable is resolvable in PATH.
#>

function Test-CommandExistsVerifier {
    <#
    .SYNOPSIS
        Verify that a command is resolvable.
    #>
    param(
        [Parameter(Mandatory = $true)]
        [string]$Command
    )
    
    $result = @{
        Success = $false
        Message = ""
        Command = $Command
    }
    
    try {
        $cmd = Get-Command $Command -ErrorAction Stop
        $result.Success = $true
        $result.Message = "Command exists: $($cmd.Source)"
    } catch {
        $result.Success = $false
        $result.Message = "Command not found: $Command"
    }
    
    return $result
}

# Functions exported: Test-CommandExistsVerifier
