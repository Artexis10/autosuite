# file src\functions\Pester.SafeCommands.ps1
# Tried using $ExecutionState.InvokeCommand.GetCmdlet() here, but it does not trigger module auto-loading the way
# Get-Command does.  Since this is at import time, before any mocks have been defined, that's probably acceptable.
# If someone monkeys with Get-Command before they import Pester, they may break something.

# The -All parameter is required when calling Get-Command to ensure that PowerShell can find the command it is
# looking for. Otherwise, if you have modules loaded that define proxy cmdlets or that have cmdlets with the same
# name as the safe cmdlets, Get-Command will return null.
$safeCommandLookupParameters = @{
    CommandType = 'Cmdlet'
    ErrorAction = 'Stop'
    All         = $true
}

# Suppress from ScriptAnalyzer rule when possible in root of script (future PSSA release?)
# [Diagnostics.CodeAnalysis.SuppressMessageAttribute('Pester.BuildAnalyzerRules\Measure-SafeCommands', 'Get-Command', Justification = 'Used to generate SafeCommands list used for AnalyzerRule.')]
$Get_Command = Get-Command Get-Command -CommandType Cmdlet -ErrorAction 'Stop'
$script:SafeCommands = @{
    'Get-Command'          = $Get_Command
    'Add-Member'           = & $Get_Command -Name Add-Member           -Module Microsoft.PowerShell.Utility    @safeCommandLookupParameters
    'Add-Type'             = & $Get_Command -Name Add-Type             -Module Microsoft.PowerShell.Utility    @safeCommandLookupParameters
    'Compare-Object'       = & $Get_Command -Name Compare-Object       -Module Microsoft.PowerShell.Utility    @safeCommandLookupParameters
    'Export-ModuleMember'  = & $Get_Command -Name Export-ModuleMember  -Module Microsoft.PowerShell.Core       @safeCommandLookupParameters
    'ForEach-Object'       = & $Get_Command -Name ForEach-Object       -Module Microsoft.PowerShell.Core       @safeCommandLookupParameters
    'Format-Table'         = & $Get_Command -Name Format-Table         -Module Microsoft.PowerShell.Utility    @safeCommandLookupParameters
    'Get-Alias'            = & $Get_Command -Name Get-Alias            -Module Microsoft.PowerShell.Utility    @safeCommandLookupParameters
    'Get-ChildItem'        = & $Get_Command -Name Get-ChildItem        -Module Microsoft.PowerShell.Management @safeCommandLookupParameters
    'Get-Content'          = & $Get_Command -Name Get-Content          -Module Microsoft.PowerShell.Management @safeCommandLookupParameters
    'Get-Date'             = & $Get_Command -Name Get-Date             -Module Microsoft.PowerShell.Utility    @safeCommandLookupParameters
    'Get-Help'             = & $Get_Command -Name Get-Help             -Module Microsoft.PowerShell.Core       @safeCommandLookupParameters
    'Get-Item'             = & $Get_Command -Name Get-Item             -Module Microsoft.PowerShell.Management @safeCommandLookupParameters
    'Get-ItemProperty'     = & $Get_Command -Name Get-ItemProperty     -Module Microsoft.PowerShell.Management @safeCommandLookupParameters
    'Get-Location'         = & $Get_Command -Name Get-Location         -Module Microsoft.PowerShell.Management @safeCommandLookupParameters
    'Get-Member'           = & $Get_Command -Name Get-Member           -Module Microsoft.PowerShell.Utility    @safeCommandLookupParameters
    'Get-Module'           = & $Get_Command -Name Get-Module           -Module Microsoft.PowerShell.Core       @safeCommandLookupParameters
    'Get-PSDrive'          = & $Get_Command -Name Get-PSDrive          -Module Microsoft.PowerShell.Management @safeCommandLookupParameters
    'Get-PSCallStack'      = & $Get_Command -Name Get-PSCallStack      -Module Microsoft.PowerShell.Utility    @safeCommandLookupParameters
    'Get-Unique'           = & $Get_Command -Name Get-Unique           -Module Microsoft.PowerShell.Utility    @safeCommandLookupParameters
    'Get-Variable'         = & $Get_Command -Name Get-Variable         -Module Microsoft.PowerShell.Utility    @safeCommandLookupParameters
    'Group-Object'         = & $Get_Command -Name Group-Object         -Module Microsoft.PowerShell.Utility    @safeCommandLookupParameters
    'Import-LocalizedData' = & $Get_Command -Name Import-LocalizedData -Module Microsoft.PowerShell.Utility    @safeCommandLookupParameters
    'Import-Module'        = & $Get_Command -Name Import-Module        -Module Microsoft.PowerShell.Core       @safeCommandLookupParameters
    'Join-Path'            = & $Get_Command -Name Join-Path            -Module Microsoft.PowerShell.Management @safeCommandLookupParameters
    'Measure-Object'       = & $Get_Command -Name Measure-Object       -Module Microsoft.PowerShell.Utility    @safeCommandLookupParameters
    'New-Item'             = & $Get_Command -Name New-Item             -Module Microsoft.PowerShell.Management @safeCommandLookupParameters
    'New-ItemProperty'     = & $Get_Command -Name New-ItemProperty     -Module Microsoft.PowerShell.Management @safeCommandLookupParameters
    'New-Module'           = & $Get_Command -Name New-Module           -Module Microsoft.PowerShell.Core       @safeCommandLookupParameters
    'New-Object'           = & $Get_Command -Name New-Object           -Module Microsoft.PowerShell.Utility    @safeCommandLookupParameters
    'New-PSDrive'          = & $Get_Command -Name New-PSDrive          -Module Microsoft.PowerShell.Management @safeCommandLookupParameters
    'New-Variable'         = & $Get_Command -Name New-Variable         -Module Microsoft.PowerShell.Utility    @safeCommandLookupParameters
    'Out-Host'             = & $Get_Command -Name Out-Host             -Module Microsoft.PowerShell.Core       @safeCommandLookupParameters
    'Out-File'             = & $Get_Command -Name Out-File             -Module Microsoft.PowerShell.Utility    @safeCommandLookupParameters
    'Out-Null'             = & $Get_Command -Name Out-Null             -Module Microsoft.PowerShell.Core       @safeCommandLookupParameters
    'Out-String'           = & $Get_Command -Name Out-String           -Module Microsoft.PowerShell.Utility    @safeCommandLookupParameters
    'Pop-Location'         = & $Get_Command -Name Pop-Location         -Module Microsoft.PowerShell.Management @safeCommandLookupParameters
    'Push-Location'        = & $Get_Command -Name Push-Location        -Module Microsoft.PowerShell.Management @safeCommandLookupParameters
    'Remove-Item'          = & $Get_Command -Name Remove-Item          -Module Microsoft.PowerShell.Management @safeCommandLookupParameters
    'Remove-PSBreakpoint'  = & $Get_Command -Name Remove-PSBreakpoint  -Module Microsoft.PowerShell.Utility    @safeCommandLookupParameters
    'Remove-PSDrive'       = & $Get_Command -Name Remove-PSDrive       -Module Microsoft.PowerShell.Management @safeCommandLookupParameters
    'Remove-Variable'      = & $Get_Command -Name Remove-Variable      -Module Microsoft.PowerShell.Utility    @safeCommandLookupParameters
    'Resolve-Path'         = & $Get_Command -Name Resolve-Path         -Module Microsoft.PowerShell.Management @safeCommandLookupParameters
    'Select-Object'        = & $Get_Command -Name Select-Object        -Module Microsoft.PowerShell.Utility    @safeCommandLookupParameters
    'Set-Alias'            = & $Get_Command -Name Set-Alias            -Module Microsoft.PowerShell.Utility    @safeCommandLookupParameters
    'Set-Content'          = & $Get_Command -Name Set-Content          -Module Microsoft.PowerShell.Management @safeCommandLookupParameters
    'Set-Location'         = & $Get_Command -Name Set-Location         -Module Microsoft.PowerShell.Management @safeCommandLookupParameters
    'Set-PSBreakpoint'     = & $Get_Command -Name Set-PSBreakpoint     -Module Microsoft.PowerShell.Utility    @safeCommandLookupParameters
    'Set-StrictMode'       = & $Get_Command -Name Set-StrictMode       -Module Microsoft.PowerShell.Core       @safeCommandLookupParameters
    'Set-Variable'         = & $Get_Command -Name Set-Variable         -Module Microsoft.PowerShell.Utility    @safeCommandLookupParameters
    'Sort-Object'          = & $Get_Command -Name Sort-Object          -Module Microsoft.PowerShell.Utility    @safeCommandLookupParameters
    'Split-Path'           = & $Get_Command -Name Split-Path           -Module Microsoft.PowerShell.Management @safeCommandLookupParameters
    'Start-Sleep'          = & $Get_Command -Name Start-Sleep          -Module Microsoft.PowerShell.Utility    @safeCommandLookupParameters
    'Test-Path'            = & $Get_Command -Name Test-Path            -Module Microsoft.PowerShell.Management @safeCommandLookupParameters
    'Update-TypeData'      = & $Get_Command -Name Update-TypeData      -Module Microsoft.PowerShell.Utility    @safeCommandLookupParameters
    'Where-Object'         = & $Get_Command -Name Where-Object         -Module Microsoft.PowerShell.Core       @safeCommandLookupParameters
    'Write-Error'          = & $Get_Command -Name Write-Error          -Module Microsoft.PowerShell.Utility    @safeCommandLookupParameters
    'Write-Host'           = & $Get_Command -Name Write-Host           -Module Microsoft.PowerShell.Utility    @safeCommandLookupParameters
    'Write-Progress'       = & $Get_Command -Name Write-Progress       -Module Microsoft.PowerShell.Utility    @safeCommandLookupParameters
    'Write-Verbose'        = & $Get_Command -Name Write-Verbose        -Module Microsoft.PowerShell.Utility    @safeCommandLookupParameters
    'Write-Warning'        = & $Get_Command -Name Write-Warning        -Module Microsoft.PowerShell.Utility    @safeCommandLookupParameters
}

# Not all platforms have Get-CimInstance (preferred) or Get-WmiObject.
# It shouldn't be fatal if neither of those cmdlets exists, however
# some NanoServer/PS images contain a non-functioning version of Get-CimInstance
# so don't even try it if we're on one of those images.
$NanoServerRegistryKey = & $SafeCommands['Get-ItemProperty'] -Path 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Server\ServerLevels' -ErrorAction Ignore
$NanoServerRegistryKeyValue = $NanoServerRegistryKey | & $SafeCommands['ForEach-Object'] -MemberName NanoServer -ErrorAction Ignore
$NanoServer = 1 -eq $NanoServerRegistryKeyValue

if (-not $NanoServer -and ($cim = & $Get_Command -Name Get-CimInstance -Module CimCmdlets -CommandType Cmdlet -ErrorAction Ignore)) {
    $script:SafeCommands['Get-CimInstance'] = $cim
}
elseif (($wmi = & $Get_Command -Name Get-WmiObject -Module Microsoft.PowerShell.Management -CommandType Cmdlet -ErrorAction Ignore)) {
    $script:SafeCommands['Get-WmiObject'] = $wmi
}
elseif (($unames = & $Get_Command -Name uname -CommandType Application -ErrorAction Ignore)) {
    $script:SafeCommands['uname'] = if ($null -ne $unames -and 0 -lt @($unames).Count) { $unames[0] }
    if (($ids = & $Get_Command -Name id -CommandType Application -ErrorAction Ignore)) {
        $script:SafeCommands['id'] = if ($null -ne $ids -and 0 -lt @($ids).Count) { $ids[0] }
    }
}
else {
    Write-Warning "OS Information retrieval is not possible, reports will contain only partial system data"
}

# little sanity check to make sure we don't blow up a system with a typo up there
# (not that I've EVER done that by, for example, mapping New-Item to Remove-Item...)

foreach ($keyValuePair in $script:SafeCommands.GetEnumerator()) {
    if ($keyValuePair.Key -ne $keyValuePair.Value.Name) {
        throw "SafeCommands entry for $($keyValuePair.Key) does not hold a reference to the proper command."
    }
}

# file src\Pester.Types.ps1
# e.g. $minimumVersionRequired = "5.1.0.0" -as [version]
$minimumVersionRequired = $ExecutionContext.SessionState.Module.PrivateData.RequiredAssemblyVersion -as [version]

# Check if the type exists, which means we have a conflict because the assembly is already loaded
$configurationType = 'PesterConfiguration' -as [type]
if ($null -ne $configurationType) {
    $loadedVersion = $configurationType.Assembly.GetName().Version

    # both use just normal version, without prerelease, we can compare them using the normal [Version] type
    if ($loadedVersion -lt $minimumVersionRequired) {
        throw [System.InvalidOperationException]"An incompatible version of the Pester.dll assembly is already loaded. The loaded dll version is $loadedVersion, but at least version $minimumVersionRequired is required for this version of Pester to work correctly. This usually happens if you load two versions of Pester into the same PowerShell session, for example after Pester update. To fix this restart your powershell session and load only one version of Pester. It also happens in VSCode if you are developing Pester and load it from non standard location. To solve this in VSCode close all *.Tests.ps1 files, to prevent automatic loading of Pester from PSModulePath, and then restart your session."
    }
}

if ($PSVersionTable.PSVersion.Major -ge 6) {
    $path = "$PSScriptRoot/bin/netstandard2.0/Pester.dll"
    & $SafeCommands['Add-Type'] -Path $path
}
else {
    $path = "$PSScriptRoot/bin/net452/Pester.dll"
    & $SafeCommands['Add-Type'] -Path $path
}
# file src\Pester.State.ps1
$script:AssertionOperators = [Collections.Generic.Dictionary[string, object]]([StringComparer]::InvariantCultureIgnoreCase)
$script:AssertionAliases = [Collections.Generic.Dictionary[string, object]]([StringComparer]::InvariantCultureIgnoreCase)
$script:AssertionDynamicParams = [Pester.Factory]::CreateRuntimeDefinedParameterDictionary()
$script:DisableScopeHints = $true
# file src\Pester.Utility.ps1
function or {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        $DefaultValue,
        [Parameter(ValueFromPipeline = $true)]
        $InputObject
    )

    if ($InputObject) {
        $InputObject
    }
    else {
        $DefaultValue
    }
}

# looks for a property on object that might be null
function tryGetProperty {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0)]
        $InputObject,
        [Parameter(Mandatory = $true, Position = 1)]
        $PropertyName
    )
    if ($null -eq $InputObject) {
        return
    }

    $InputObject.$PropertyName

    # this would be useful if we looked for property that might not exist
    # but that is not the case so-far. Originally I implemented this incorrectly
    # so I will keep this here for reference in case I was wrong the second time as well
    # $property = $InputObject.PSObject.Properties.Item($PropertyName)
    # if ($null -ne $property) {
    #     $property.Value
    # }
}

function trySetProperty {
    [CmdletBinding()]
    param (
        [Parameter(Position = 0)]
        $InputObject,
        [Parameter(Mandatory = $true, Position = 1)]
        $PropertyName,
        [Parameter(Mandatory = $true, Position = 2)]
        $Value
    )

    if ($null -eq $InputObject) {
        return
    }

    $InputObject.$PropertyName = $Value
}


# combines collections that are not null or empty, but does not remove null values
# from collections so e.g. combineNonNull @(@(1,$null), @(1,2,3), $null, $null, 10)
# returns 1, $null, 1, 2, 3, 10
function combineNonNull ($Array) {
    foreach ($i in $Array) {

        $arr = @($i)
        if ($null -ne $i -and $arr.Length -gt 0) {
            foreach ($a in $arr) {
                $a
            }
        }
    }
}


filter selectNonNull {
    param($Collection)
    @(foreach ($i in $Collection) {
            if ($i) { $i }
        })
}

function any ($InputObject) {
    # inlining version
    $(<# any #> if (-not ($s = $InputObject)) { return $false } else { @($s).Length -gt 0 })
    # if (-not $InputObject) {
    #     return $false
    # }

    # @($InputObject).Length -gt 0
}

function none ($InputObject) {
    -not (any $InputObject)
}

function defined {
    param(
        [Parameter(Mandatory)]
        [String] $Name
    )
    # gets a variable via the provider and returns it's value, the name is slightly misleading
    # because it indicates that the variable is not defined when it is null, but that is fine
    # the call to the provider is slightly more expensive (at least it seems) so this should be
    # used only when we want a value that we will further inspect, and we don't want to add the overhead of
    # first checking that the variable exists and then getting it's value like here:
    # defined v & hasValue v & $v.Name -eq "abc"
    $ExecutionContext.SessionState.PSVariable.GetValue($Name)
}

function notDefined {
    param(
        [Parameter(Mandatory)]
        [String] $Name
    )
    # gets a variable via the provider and returns it's value, the name is slightly misleading
    # because it indicates that the variable is not defined when it is null, but that is fine
    # the call to the provider is slightly more expensive (at least it seems) so this should be
    # used only when we want a value that we will further inspect
    $null -eq ($ExecutionContext.SessionState.PSVariable.GetValue($Name))
}


function sum ($InputObject, $PropertyName, $Zero) {
    if (none $InputObject.Length) {
        return $Zero
    }

    $acc = $Zero
    foreach ($i in $InputObject) {
        $acc += $i.$PropertyName
    }

    $acc
}

function tryGetValue {
    [CmdletBinding()]
    param(
        $Hashtable,
        $Key
    )

    if ($Hashtable.ContainsKey($Key)) {
        # do not enumerate so we get the same thing back
        # even if it is a collection
        $PSCmdlet.WriteObject($Hashtable.$Key, $false)
    }
}

function tryAddValue {
    [CmdletBinding()]
    param(
        $Hashtable,
        $Key,
        $Value
    )

    if (-not $Hashtable.ContainsKey($Key)) {
        $null = $Hashtable.Add($Key, $Value)
    }
}

function getOrUpdateValue {
    [CmdletBinding()]
    param(
        $Hashtable,
        $Key,
        $DefaultValue
    )

    if ($Hashtable.ContainsKey($Key)) {
        # do not enumerate so we get the same thing back
        # even if it is a collection
        $PSCmdlet.WriteObject($Hashtable.$Key, $false)
    }
    else {
        $Hashtable.Add($Key, $DefaultValue)
        # do not enumerate so we get the same thing back
        # even if it is a collection
        $PSCmdlet.WriteObject($DefaultValue, $false)
    }
}

function tryRemoveKey ($Hashtable, $Key) {
    if ($Hashtable.ContainsKey($Key)) {
        $Hashtable.Remove($Key)
    }
}

function Add-DataToContext ($Destination, $Data) {
    # works as Merge-Hashtable, but additionally adds _
    # which will become $_, and checks if the Data is
    # expandable, otherwise it just defines $_

    if (-not $Destination.ContainsKey("_")) {
        $Destination.Add("_", $Data)
    }

    if ($Data -is [Collections.IDictionary]) {
        Merge-Hashtable -Destination $Destination -Source $Data
    }
}

function Merge-Hashtable ($Source, $Destination) {
    # only add non-existing keys so in case of conflict
    # the framework name wins, as if we had explicit parameters
    # on a scriptblock, then the parameter would also win
    foreach ($p in $Source.GetEnumerator()) {
        if (-not $Destination.ContainsKey($p.Key)) {
            $Destination.Add($p.Key, $p.Value)
        }
    }
}


function Merge-HashtableOrObject ($Source, $Destination) {
    if ($Source -isnot [Collections.IDictionary] -and $Source -isnot [PSObject]) {
        throw "Source must be a Hashtable, IDictionary or a PSObject."
    }

    if ($Destination -isnot [PSObject]) {
        throw "Destination must be a PSObject."
    }


    $sourceIsPSObject = $Source -is [PSObject]
    $sourceIsDictionary = $Source -is [Collections.IDictionary]
    $destinationIsPSObject = $Destination -is [PSObject]
    $destinationIsDictionary = $Destination -is [Collections.IDictionary]

    $items = if ($sourceIsDictionary) { $Source.GetEnumerator() } else { $Source.PSObject.Properties }
    foreach ($p in $items) {
        if ($null -eq $Destination.PSObject.Properties.Item($p.Key)) {
            $Destination.PSObject.Properties.Add([Pester.Factory]::CreateNoteProperty($p.Key, $p.Value))
        }
        else {
            if ($p.Value -is [hashtable] -or $p.Value -is [PSObject]) {
                Merge-HashtableOrObject -Source $p.Value -Destination $Destination.($p.Key)
            }
            else {
                $Destination.($p.Key) = $p.Value
            }

        }
    }
}

function Write-PesterDebugMessage {
    [CmdletBinding(DefaultParameterSetName = "Default")]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [ValidateSet("Filter", "Skip", "Runtime", "RuntimeCore", "Mock", "MockCore", "Discovery", "DiscoveryCore", "SessionState", "Timing", "TimingCore", "Plugin", "PluginCore", "CodeCoverage", "CodeCoverageCore")]
        [String[]] $Scope,
        [Parameter(Mandatory = $true, Position = 1, ParameterSetName = "Default")]
        [String] $Message,
        [Parameter(Mandatory = $true, Position = 1, ParameterSetName = "Lazy")]
        [ScriptBlock] $LazyMessage,
        [Parameter(Position = 2)]
        [Management.Automation.ErrorRecord] $ErrorRecord
    )

    if (-not $PesterPreference.Debug.WriteDebugMessages.Value) {
        throw "This should never happen. All calls to Write-PesterDebugMessage should be wrapped in `if` to avoid the performance hit of allocating the message and calling the function. Inspect the call stack to know where this call came from. This can also happen if `$PesterPreference is different from the `$PesterPreference that utilities see because of incorrect scoping."
    }

    $messagePreference = $PesterPreference.Debug.WriteDebugMessagesFrom.Value
    $any = $false
    foreach ($s in $Scope) {
        if ($any) {
            break
        }
        foreach ($p in $messagePreference) {
            if ($s -like $p) {
                $any = $true
                break
            }
        }
    }

    if (-not $any) {
        return
    }

    $color = if ($null -ne $ErrorRecord) {
        "Red"
    }
    else {
        switch ($Scope) {
            "Filter" { "Cyan" }
            "Skip" { "Cyan" }
            "Runtime" { "DarkGray" }
            "RuntimeCore" { "Cyan" }
            "Mock" { "DarkYellow" }
            "Discovery" { "DarkMagenta" }
            "DiscoveryCore" { "DarkMagenta" }
            "SessionState" { "Gray" }
            "Timing" { "Gray" }
            "TimingCore" { "Gray" }
            "PluginCore" { "Blue" }
            "Plugin" { "Blue" }
            "CodeCoverage" { "Yellow" }
            "CodeCoverageCore" { "Yellow" }
            default { "Cyan" }
        }
    }

    # this evaluates a message that is expensive to produce so we only evaluate it
    # when we know that we will write it. All messages could be provided as scriptblocks
    # but making a script block is slightly more expensive than making a string, so lazy approach
    # is used only when the message is obviously expensive, like folding the whole tree to get
    # count of found tests
    #TODO: remove this, it was clever but the best performance is achieved by putting an if around the whole call which is what I do in hopefully all places, that way the scriptblock nor the string are allocated
    if ($null -ne $LazyMessage) {
        $Message = (&$LazyMessage) -join "`n"
    }

    Write-PesterHostMessage -ForegroundColor Black -BackgroundColor $color  "${Scope}: $Message "
    if ($null -ne $ErrorRecord) {
        Write-PesterHostMessage -ForegroundColor Black -BackgroundColor $color "$ErrorRecord"
    }
}

function Fold-Block {
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        $Block,
        $OnBlock = {},
        $OnTest = {},
        $Accumulator
    )
    process {
        foreach ($b in $Block) {
            $Accumulator = & $OnBlock $Block $Accumulator
            foreach ($test in $Block.Tests) {
                $Accumulator = & $OnTest $test $Accumulator
            }

            foreach ($b in $Block.Blocks) {
                Fold-Block -Block $b -OnTest $OnTest -OnBlock $OnBlock -Accumulator $Accumulator
            }
        }
    }
}

function Fold-Container {
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        $Container,
        $OnContainer = {},
        $OnBlock = {},
        $OnTest = {},
        $Accumulator
    )

    process {
        foreach ($c in $Container) {
            $Accumulator = & $OnContainer $c $Accumulator
            foreach ($block in $c.Blocks) {
                Fold-Block -Block $block -OnBlock $OnBlock -OnTest $OnTest -Accumulator $Accumulator
            }
        }
    }
}

function Fold-Run {
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        $Run,
        $OnRun = {},
        $OnContainer = {},
        $OnBlock = {},
        $OnTest = {},
        $Accumulator
    )

    process {
        foreach ($r in $Run) {
            $Accumulator = & $OnRun $r $Accumulator
            foreach ($container in $r.Containers) {
                Fold-Container -Container $container -OnContainer $OnContainer -OnBlock $OnBlock -OnTest $OnTest -Accumulator $Accumulator
            }
        }
    }
}

function Get-StringOptionErrorMessage {
    param (
        [Parameter(Mandatory)]
        [string] $OptionPath,
        [string[]] $SupportedValues = @(),
        [string] $Value
    )
    $supportedValuesString = Join-Or ($SupportedValues -replace '^|$', "'")
    return "$OptionPath must be $supportedValuesString, but it was '$Value'. Please review your configuration."
}
# file src\Pester.Runtime.ps1

# interesting commands
# # the core stuff I am mostly sure about
# 'New-PesterState'
# 'New-Block'
# 'New-ParametrizedBlock'
# 'New-Test'
# 'New-ParametrizedTest'
# 'New-EachTestSetup'
# 'New-EachTestTeardown'
# 'New-OneTimeTestSetup'
# 'New-OneTimeTestTeardown'
# 'New-EachBlockSetup'
# 'New-EachBlockTeardown'
# 'New-OneTimeBlockSetup'
# 'New-OneTimeBlockTeardown'
# 'Add-FrameworkDependency'
# 'Anywhere'
# 'Invoke-Test',
# 'Find-Test',
# 'Invoke-PluginStep'

# # here I have doubts if that is too much to expose
# 'Get-CurrentTest'
# 'Get-CurrentBlock'
# 'Recurse-Up',
# 'Is-Discovery'

# # those are quickly implemented to be useful for demo
# 'Where-Failed'
# 'View-Flat'

# # those need to be refined and probably wrapped to something
# # that is like an object builder
# 'New-FilterObject'
# 'New-PluginObject'
# 'New-BlockContainerObject'


# instances
$flags = [System.Reflection.BindingFlags]'Instance,NonPublic'
$script:SessionStateInternalProperty = [System.Management.Automation.SessionState].GetProperty('Internal', $flags)
$script:ScriptBlockSessionStateInternalProperty = [System.Management.Automation.ScriptBlock].GetProperty('SessionStateInternal', $flags)
$script:ScriptBlockSessionStateProperty = [System.Management.Automation.ScriptBlock].GetProperty("SessionState", $flags)

if (notDefined PesterPreference) {
    $PesterPreference = [PesterConfiguration]::Default
}
else {
    $PesterPreference = [PesterConfiguration] $PesterPreference
}

function New-PesterState {
    $o = [PSCustomObject] @{
        # indicate whether or not we are currently
        # running in discovery mode se we can change
        # behavior of the commands appropriately
        Discovery           = $false

        CurrentBlock        = $null
        CurrentTest         = $null

        Plugin              = $null
        PluginConfiguration = $null
        PluginData          = $null
        Configuration       = $null

        TotalStopWatch      = [Diagnostics.Stopwatch]::StartNew()
        UserCodeStopWatch   = [Diagnostics.Stopwatch]::StartNew()
        FrameworkStopWatch  = [Diagnostics.Stopwatch]::StartNew()

        Stack               = [Collections.Stack]@()
    }

    $o.TotalStopWatch.Restart()
    $o.FrameworkStopWatch.Restart()
    # user code stopwatch should not be running
    # because we are not in user code
    $o.UserCodeStopWatch.Reset()

    return $o
}

function Reset-PerContainerState {
    param(
        [Parameter(Mandatory = $true)]
        $RootBlock
    )
    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
        Write-PesterDebugMessage -Scope Runtime "Resetting per container state."
    }
    $state.CurrentBlock = $RootBlock
    $state.Stack.Clear()
}

function Find-Test {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [PSObject[]] $BlockContainer,
        $Filter,
        [Parameter(Mandatory = $true)]
        [Management.Automation.SessionState] $SessionState
    )

    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
        Write-PesterDebugMessage -Scope DiscoveryCore "Running just discovery."
    }

    # define the state if we don't have it yet, this will happen when we call this function directly
    # but normally the parent invoker (most often Invoke-Pester) will set the state. So we don't want to reset
    # it here.
    if (notDefined state) {
        $state = New-PesterState
    }

    $found = Discover-Test -BlockContainer $BlockContainer -Filter $Filter -SessionState $SessionState

    foreach ($f in $found) {
        ConvertTo-DiscoveredBlockContainer -Block $f
    }
}

function ConvertTo-DiscoveredBlockContainer {
    param (
        [Parameter(Mandatory = $true)]
        $Block
    )

    $b = [Pester.Container]::CreateFromBlock($Block)
    $b
}

function ConvertTo-ExecutedBlockContainer {
    param (
        [Parameter(Mandatory = $true)]
        $Block
    )

    foreach ($b in $Block) {
        [Pester.Container]::CreateFromBlock($b)
    }


}

function New-ParametrizedBlock {
    param (
        [Parameter(Mandatory = $true)]
        [String] $Name,
        [Parameter(Mandatory = $true)]
        [ScriptBlock] $ScriptBlock,
        [int] $StartLine = $MyInvocation.ScriptLineNumber,
        [int] $StartColumn = $MyInvocation.OffsetInLine,
        [String[]] $Tag = @(),
        [HashTable] $FrameworkData = @{ },
        [Switch] $Focus,
        [Switch] $Skip,
        $Data
    )

    # using the position of Describe/Context as Id to group data-generated blocks. Should be unique enough because it only needs to be unique for the current block
    # TODO: Id is used by NUnit2.5 and 3 testresults to group. A better way to solve this?
    $groupId = "${StartLine}:${StartColumn}"

    foreach ($d in @($Data)) {
        # shallow clone to give every block it's own copy
        $fmwData = $FrameworkData.Clone()
        New-Block -GroupId $groupId -Name $Name -ScriptBlock $ScriptBlock -StartLine $StartLine -Tag $Tag -FrameworkData $fmwData -Focus:$Focus -Skip:$Skip -Data $d
    }
}

# endpoint for adding a block that contains tests
# or other blocks
function New-Block {
    param (
        [Parameter(Mandatory = $true)]
        [String] $Name,
        [Parameter(Mandatory = $true)]
        [ScriptBlock] $ScriptBlock,
        [int] $StartLine = $MyInvocation.ScriptLineNumber,
        [String[]] $Tag = @(),
        [HashTable] $FrameworkData = @{ },
        [Switch] $Focus,
        [String] $GroupId,
        [Switch] $Skip,
        $Data
    )

    # Switch-Timer -Scope Framework
    # $overheadStartTime = $state.FrameworkStopWatch.Elapsed
    # $blockStartTime = $state.UserCodeStopWatch.Elapsed

    $state.Stack.Push($Name)
    $path = @( <# Get full name #> $history = $state.Stack.ToArray(); [Array]::Reverse($history); $history)
    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
        Write-PesterDebugMessage -Scope Runtime "Entering path $($path -join '.')"
    }

    $block = $null
    $previousBlock = $state.CurrentBlock

    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
        Write-PesterDebugMessage -Scope DiscoveryCore "Adding block $Name to discovered blocks"
    }

    # new block
    $block = [Pester.Block]::Create()
    $block.Name = $Name
    # using the non-expanded name as default to fallback to it if we don't
    # reach the point where we expand it, for example because of setup failure
    $block.ExpandedName = $Name

    $block.Path = $Path
    # using the non-expanded path as default to fallback to it if we don't
    # reach the point where we expand it, for example because of setup failure
    $block.ExpandedPath = $Path -join '.'
    $block.Tag = $Tag
    $block.ScriptBlock = $ScriptBlock
    $block.StartLine = $StartLine
    $block.FrameworkData = $FrameworkData
    $block.Focus = $Focus
    $block.GroupId = $GroupId
    $block.Skip = $Skip
    $block.Data = $Data

    # we attach the current block to the parent, and put it to the parent
    # lists
    $block.Parent = $state.CurrentBlock
    $state.CurrentBlock.Order.Add($block)
    $state.CurrentBlock.Blocks.Add($block)

    # and then make it the new current block
    $state.CurrentBlock = $block
    try {
        if ($PesterPreference.Debug.WriteDebugMessages.Value) {
            Write-PesterDebugMessage -Scope DiscoveryCore "Discovering in body of block $Name"
        }

        if ($null -ne $block.Data) {
            $context = @{}
            Add-DataToContext -Destination $context -Data $block.Data

            $setVariablesAndRunBlock = {
                param ($private:______parameters)

                foreach ($private:______current in $private:______parameters.Context.GetEnumerator()) {
                    $ExecutionContext.SessionState.PSVariable.Set($private:______current.Key, $private:______current.Value)
                }

                $private:______current = $null

                . $private:______parameters.ScriptBlock
            }

            $parameters = @{
                Context     = $context
                ScriptBlock = $ScriptBlock
            }

            $SessionStateInternal = $script:ScriptBlockSessionStateInternalProperty.GetValue($ScriptBlock, $null)
            $script:ScriptBlockSessionStateInternalProperty.SetValue($setVariablesAndRunBlock, $SessionStateInternal, $null)

            & $setVariablesAndRunBlock $parameters
        }
        else {
            & $ScriptBlock
        }

        if ($PesterPreference.Debug.WriteDebugMessages.Value) {
            Write-PesterDebugMessage -Scope DiscoveryCore "Finished discovering in body of block $Name"
        }
    }
    finally {
        $state.CurrentBlock = $previousBlock
        $null = $state.Stack.Pop()
        if ($PesterPreference.Debug.WriteDebugMessages.Value) {
            Write-PesterDebugMessage -Scope Runtime "Left block $Name"
        }
    }
}

function Invoke-Block ($previousBlock) {
    Switch-Timer -Scope Framework
    $overheadStartTime = $state.FrameworkStopWatch.Elapsed
    $blockStartTime = $state.UserCodeStopWatch.Elapsed

    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
        Write-PesterDebugMessage -Scope Runtime "Entering path $($path -join '.')"
    }

    foreach ($item in $previousBlock.Order) {
        if ('Test' -eq $item.ItemType) {
            Invoke-TestItem -Test $item
        }
        else {
            $block = $item
            $state.CurrentBlock = $block
            try {
                if (-not $block.ShouldRun) {
                    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                        Write-PesterDebugMessage -Scope Runtime "Block '$($block.Name)' is excluded from run, returning"
                    }
                    continue
                }

                $block.ExecutedAt = [DateTime]::Now
                $block.Executed = $true

                # update ExpandedPath to included expanded parent name in case this fails in setup
                if (-not $block.Parent.IsRoot) { $block.ExpandedPath = "$($block.Parent.ExpandedPath).$($block.Name)" }

                if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                    Write-PesterDebugMessage -Scope Runtime "Executing body of block '$($block.Name)'"
                }

                # no callbacks are provided because we are not transitioning between any states
                $frameworkSetupResult = Invoke-ScriptBlock `
                    -OuterSetup @(
                    if ($block.First) { $state.Plugin.OneTimeBlockSetupStart }
                ) `
                    -Setup @( $state.Plugin.EachBlockSetupStart ) `
                    -Context @{
                    Context = @{
                        # context that is visible to plugins
                        Block         = $block
                        Test          = $null
                        Configuration = $state.PluginConfiguration
                    }
                }

                if ($frameworkSetupResult.Success) {
                    # this craziness makes one extra scope that is bound to the user session state
                    # and inside of it the Invoke-Block is called recursively. Ultimately this invokes all blocks
                    # in their own scope like this:
                    # & { # block 1
                    #     . block 1 setup
                    #     & { # block 2
                    #         . block 2 setup
                    #         & { # block 3
                    #             . block 3 setup
                    #             & { # test one
                    #                 . test 1 setup
                    #                 . test1
                    #             }
                    #         }
                    #     }
                    # }

                    $sb = {
                        param($______pester_invoke_block_parameters)
                        & $______pester_invoke_block_parameters.Invoke_Block -previousBlock $______pester_invoke_block_parameters.Block
                    }

                    $context = @{
                        ______pester_invoke_block_parameters = @{
                            Invoke_Block = ${function:Invoke-Block}
                            Block        = $block
                        }
                        ____Pester                           = $State
                    }

                    if ($null -ne $block.Data) {
                        Add-DataToContext -Destination $context -Data $block.Data
                    }

                    $sessionStateInternal = $script:ScriptBlockSessionStateInternalProperty.GetValue($block.ScriptBlock, $null)
                    $script:ScriptBlockSessionStateInternalProperty.SetValue($sb, $SessionStateInternal)

                    $result = Invoke-ScriptBlock `
                        -ScriptBlock $sb `
                        -OuterSetup @(
                        $(if (-not (Is-Discovery) -and (-not $Block.Skip)) {
                                @($previousBlock.EachBlockSetup) + @($block.OneTimeTestSetup)
                            })
                        $(if (-not $Block.IsRoot) {
                                # expand block name by evaluating the <> templates, only match templates that have at least 1 character and are not escaped by `<abc`>
                                # avoid using variables so we don't run into conflicts
                                $sb = {

                                    $____Pester.CurrentBlock.ExpandedName = if ($____Pester.CurrentBlock.Name -like "*<*") { & ([ScriptBlock]::Create(('"' + ($____Pester.CurrentBlock.Name -replace '\$', '`$' -replace '"', '`"' -replace '(?<!`)<([^>^`]+)>', '$$($$$1)') + '"'))) } else { $____Pester.CurrentBlock.Name }

                                    $____Pester.CurrentBlock.ExpandedPath = if ($____Pester.CurrentBlock.Parent.IsRoot) {
                                        # to avoid including Root name in the path
                                        $____Pester.CurrentBlock.ExpandedName
                                    }
                                    else {
                                        "$($____Pester.CurrentBlock.Parent.ExpandedPath).$($____Pester.CurrentBlock.ExpandedName)"
                                    }
                                }

                                $SessionStateInternal = $script:ScriptBlockSessionStateInternalProperty.GetValue($State.CurrentBlock.ScriptBlock, $null)
                                $script:ScriptBlockSessionStateInternalProperty.SetValue($sb, $SessionStateInternal)

                                $sb
                            })
                    ) `
                        -OuterTeardown $( if (-not (Is-Discovery) -and (-not $Block.Skip)) {
                            @($block.OneTimeTestTeardown) + @($previousBlock.EachBlockTeardown)
                        } ) `
                        -Context $context `
                        -MoveBetweenScopes `
                        -Configuration $state.Configuration

                    $block.OwnPassed = $result.Success
                    $block.StandardOutput = $result.StandardOutput

                    $block.ErrorRecord.AddRange($result.ErrorRecord)
                    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                        Write-PesterDebugMessage -Scope Runtime "Finished executing body of block $Name"
                    }
                }

                $frameworkEachBlockTeardowns = @($state.Plugin.EachBlockTeardownEnd )
                $frameworkOneTimeBlockTeardowns = @( if ($block.Last) { $state.Plugin.OneTimeBlockTeardownEnd } )
                # reverse the teardowns so they run in opposite order to setups
                [Array]::Reverse($frameworkEachBlockTeardowns)
                [Array]::Reverse($frameworkOneTimeBlockTeardowns)


                # setting those values here so they are available for the teardown
                # BUT they are then set again at the end of the block to make them accurate
                # so the value on the screen vs the value in the object is slightly different
                # with the value in the result being the correct one
                $block.UserDuration = $state.UserCodeStopWatch.Elapsed - $blockStartTime
                $block.FrameworkDuration = $state.FrameworkStopWatch.Elapsed - $overheadStartTime
                $frameworkTeardownResult = Invoke-ScriptBlock `
                    -Teardown $frameworkEachBlockTeardowns `
                    -OuterTeardown $frameworkOneTimeBlockTeardowns `
                    -Context @{
                    Context = @{
                        # context that is visible to plugins
                        Block         = $block
                        Test          = $null
                        Configuration = $state.PluginConfiguration
                    }
                }

                if (-not $frameworkSetupResult.Success -or -not $frameworkTeardownResult.Success) {
                    Assert-Success -InvocationResult @($frameworkSetupResult, $frameworkTeardownResult) -Message "Framework failed"
                }
            }
            finally {
                $state.CurrentBlock = $previousBlock
                if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                    Write-PesterDebugMessage -Scope Runtime "Left block $Name"
                }
                $block.UserDuration = $state.UserCodeStopWatch.Elapsed - $blockStartTime
                $block.FrameworkDuration = $state.FrameworkStopWatch.Elapsed - $overheadStartTime
                if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                    Write-PesterDebugMessage -Scope Timing "Block duration $($block.UserDuration.TotalMilliseconds)ms"
                    Write-PesterDebugMessage -Scope Timing "Block framework duration $($block.FrameworkDuration.TotalMilliseconds)ms"
                    Write-PesterDebugMessage -Scope Runtime "Leaving path $($path -join '.')"
                }
            }
        }
    }
}

# endpoint for adding a test
function New-Test {
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [String] $Name,
        [Parameter(Mandatory = $true, Position = 1)]
        [ScriptBlock] $ScriptBlock,
        [int] $StartLine = $MyInvocation.ScriptLineNumber,
        [String[]] $Tag = @(),
        $Data,
        [String] $GroupId,
        [Switch] $Focus,
        [Switch] $Skip
    )

    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
        Write-PesterDebugMessage -Scope DiscoveryCore "Entering test $Name"
    }

    if ($state.CurrentBlock.IsRoot) {
        throw "Test cannot be directly in the root."
    }

    # avoid managing state by not pushing to the stack only to pop out in finally
    # simply concatenate the arrays
    $path = @(<# Get full name #> $history = $state.Stack.ToArray(); [Array]::Reverse($history); $history + $name)

    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
        Write-PesterDebugMessage -Scope Runtime "Entering path $($path -join '.')"
    }

    $test = [Pester.Test]::Create()
    $test.GroupId = $GroupId
    $test.ScriptBlock = $ScriptBlock
    $test.Name = $Name
    # using the non-expanded name as default to fallback to it if we don't
    # reach the point where we expand it, for example because of setup failure
    $test.ExpandedName = $Name
    $test.Path = $path
    # using the non-expanded path as default to fallback to it if we don't
    # reach the point where we expand it, for example because of setup failure
    $test.ExpandedPath = $path -join '.'
    $test.StartLine = $StartLine
    $test.Tag = $Tag
    $test.Focus = $Focus
    $test.Skip = $Skip
    $test.Data = $Data
    $test.FrameworkData.Runtime.Phase = 'Discovery'

    # add test to current block lists
    $state.CurrentBlock.Tests.Add($Test)
    $state.CurrentBlock.Order.Add($Test)

    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
        Write-PesterDebugMessage -Scope DiscoveryCore "Added test '$Name'"
    }
}

function Invoke-TestItem {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        $Test
    )
    # keep this at the top so we report as much time
    # of the actual test run as possible
    $overheadStartTime = $state.FrameworkStopWatch.Elapsed
    $testStartTime = $state.UserCodeStopWatch.Elapsed
    Switch-Timer -Scope Framework

    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
        Write-PesterDebugMessage -Scope Runtime "Entering test $($Test.Name)"
    }

    try {
        if ($PesterPreference.Debug.WriteDebugMessages.Value) {
            Write-PesterDebugMessage -Scope Runtime "Entering path $($Test.Path -join '.')"
        }

        $Test.FrameworkData.Runtime.Phase = 'Execution'
        Set-CurrentTest -Test $Test

        if (-not $Test.ShouldRun) {
            if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                Write-PesterDebugMessage -Scope Runtime "Test is excluded from run, returning"
            }
            return
        }

        $Test.ExecutedAt = [DateTime]::Now
        $Test.Executed = $true

        $block = $Test.Block
        if ($PesterPreference.Debug.WriteDebugMessages.Value) {
            Write-PesterDebugMessage -Scope Runtime "Running test '$($Test.Name)'."
        }

        # no callbacks are provided because we are not transitioning between any states
        $frameworkSetupResult = Invoke-ScriptBlock `
            -OuterSetup @(
            if ($Test.First) { $state.Plugin.OneTimeTestSetupStart }
        ) `
            -Setup @( $state.Plugin.EachTestSetupStart ) `
            -Context @{
            Context = @{
                # context visible to Plugins
                Block         = $block
                Test          = $Test
                Configuration = $state.PluginConfiguration
            }
        }

        # update ExpandedPath to included expanded parent name in case this fails in setup
        $Test.ExpandedPath = "$($block.ExpandedPath).$($Test.Name)"

        if ($Test.Skip) {
            if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                $path = $Test.Path -join '.'
                Write-PesterDebugMessage -Scope Skip "($path) Test is skipped."
            }

            # setting the test as passed here, this is by choice
            # skipped test are ultimately passed tests that were not executed
            # I expect that if someone works with the raw result object and
            # filters on .Passed -eq $false they should get the count of failed tests
            # not failed + skipped. It might be wise to revert those booleans to "enum"
            # because they are exclusive, but keeping the info in the object stupid
            # and aggregating it as needed was also a design choice
            $Test.Passed = $true
            $Test.Skipped = $true
            $Test.FrameworkData.Runtime.ExecutionStep = 'Finished'
        }
        else {

            if ($frameworkSetupResult.Success) {
                $context = @{
                    ____Pester = $State
                }

                if ($null -ne $test.Data) {
                    Add-DataToContext -Destination $context -Data $test.Data
                }

                # recurse up Recurse-Up $Block { param ($b) $b.EachTestSetup }
                $i = $Block
                $eachTestSetups = while ($null -ne $i) {
                    $i.EachTestSetup
                    $i = $i.Parent
                }

                # recurse up Recurse-Up $Block { param ($b) $b.EachTestTeardown }
                $i = $Block
                $eachTestTeardowns = while ($null -ne $i) {
                    $i.EachTestTeardown
                    $i = $i.Parent
                }

                $result = Invoke-ScriptBlock `
                    -Setup @(
                    if ($null -ne $eachTestSetups -and 0 -lt @($eachTestSetups).Count) {
                        # we collect the child first but want the parent to run first
                        [Array]::Reverse($eachTestSetups)
                        @( { $Test.FrameworkData.Runtime.ExecutionStep = 'EachTestSetup' }) + @($eachTestSetups)
                    }

                    {
                        # setting the execution info here so I don't have to invoke change the
                        # contract of Invoke-ScriptBlock to accept multiple -ScriptBlock, because
                        # that is not needed, and would complicate figuring out in which session
                        # state we should run.
                        # this should run every time.
                        $Test.FrameworkData.Runtime.ExecutionStep = 'Test'
                    }
                    $(
                        # expand block name by evaluating the <> templates, only match templates that have at least 1 character and are not escaped by `<abc`>
                        # avoid using any variables to avoid running into conflict with user variables
                        # $ExecutionContext.SessionState.InvokeCommand.ExpandString() has some weird bug in PowerShell 4 and 3, that makes hashtable resolve to null
                        # instead I create a expandable string in a scriptblock and evaluate
                        $sb = {

                            $____Pester.CurrentTest.ExpandedName = if ($____Pester.CurrentTest.Name -like "*<*") {
                                & ([ScriptBlock]::Create(('"' + ($____Pester.CurrentTest.Name -replace '\$', '`$' -replace '"', '`"' -replace '(?<!`)<([^>^`]+)>', '$$($$$1)') + '"')))
                            }
                            else {
                                $____Pester.CurrentTest.Name
                            }

                            $____Pester.CurrentTest.ExpandedPath = "$($____Pester.CurrentTest.Block.ExpandedPath -join '.').$($____Pester.CurrentTest.ExpandedName)"
                        }

                        $SessionStateInternal = $script:ScriptBlockSessionStateInternalProperty.GetValue($State.CurrentTest.ScriptBlock, $null)
                        $script:ScriptBlockSessionStateInternalProperty.SetValue($sb, $SessionStateInternal)
                        $sb
                    )
                ) `
                    -ScriptBlock $Test.ScriptBlock `
                    -Teardown @(
                    if ($null -ne $eachTestTeardowns -and 0 -lt @($eachTestTeardowns).Count) {
                        @( { $Test.FrameworkData.Runtime.ExecutionStep = 'EachTestTeardown' }) + @($eachTestTeardowns)
                    } ) `
                    -Context $context `
                    -ReduceContextToInnerScope `
                    -MoveBetweenScopes `
                    -NoNewScope `
                    -Configuration $state.Configuration

                $Test.FrameworkData.Runtime.ExecutionStep = 'Finished'

                if (@('PesterTestSkipped', 'PesterTestInconclusive', 'PesterTestPending') -contains $Result.ErrorRecord.FullyQualifiedErrorId) {
                    #Same logic as when setting a test block to skip
                    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                        $path = $Test.Path -join '.'
                        Write-PesterDebugMessage -Scope Skip "($path) Test is skipped."
                    }
                    $Test.Passed = $true
                    if ('PesterTestInconclusive' -eq $Result.ErrorRecord.FullyQualifiedErrorId) {
                        $Test.Inconclusive = $true
                    }
                    else {
                        $Test.Skipped = $true

                        # Pending test is still considered a skipped, we don't have a special category for it.
                        # Mark the run to show deprecation message.
                        if ('PesterTestPending' -eq $Result.ErrorRecord.FullyQualifiedErrorId) {
                            $test.Block.Root.FrameworkData['ShowPendingDeprecation'] = $true
                        }
                    }
                }
                else {
                    $Test.Passed = $result.Success
                }

                $Test.StandardOutput = $result.StandardOutput
                $Test.ErrorRecord.AddRange($result.ErrorRecord)
            }
        }


        # setting those values here so they are available for the teardown
        # BUT they are then set again at the end of the block to make them accurate
        # so the value on the screen vs the value in the object is slightly different
        # with the value in the result being the correct one
        $Test.UserDuration = $state.UserCodeStopWatch.Elapsed - $testStartTime
        $Test.FrameworkDuration = $state.FrameworkStopWatch.Elapsed - $overheadStartTime

        $frameworkEachTestTeardowns = @( $state.Plugin.EachTestTeardownEnd )
        $frameworkOneTimeTestTeardowns = @(if ($Test.Last) { $state.Plugin.OneTimeTestTeardownEnd })
        [array]::Reverse($frameworkEachTestTeardowns)
        [array]::Reverse($frameworkOneTimeTestTeardowns)

        $frameworkTeardownResult = Invoke-ScriptBlock `
            -Teardown $frameworkEachTestTeardowns `
            -OuterTeardown $frameworkOneTimeTestTeardowns `
            -Context @{
            Context = @{
                # context visible to Plugins
                Test          = $Test
                Block         = $block
                Configuration = $state.PluginConfiguration
            }
        }

        if (-not $frameworkTeardownResult.Success -or -not $frameworkTeardownResult.Success) {
            throw $frameworkTeardownResult.ErrorRecord[-1]
        }

    }
    finally {
        if ($PesterPreference.Debug.WriteDebugMessages.Value) {
            Write-PesterDebugMessage -Scope Runtime "Leaving path $($Test.Path -join '.')"
        }
        $state.CurrentTest = $null
        if ($PesterPreference.Debug.WriteDebugMessages.Value) {
            Write-PesterDebugMessage -Scope Runtime "Left test $($Test.Name)"
        }

        # keep this at the end so we report even the test teardown in the framework overhead for the test
        $Test.UserDuration = $state.UserCodeStopWatch.Elapsed - $testStartTime
        $Test.FrameworkDuration = $state.FrameworkStopWatch.Elapsed - $overheadStartTime
        if ($PesterPreference.Debug.WriteDebugMessages.Value) {
            Write-PesterDebugMessage -Scope Timing -Message "Test duration $($Test.UserDuration.TotalMilliseconds)ms"
            Write-PesterDebugMessage -Scope Timing -Message "Framework duration $($Test.FrameworkDuration.TotalMilliseconds)ms"
        }
    }
}

# endpoint for adding a setup for each test in the block
function New-EachTestSetup {
    param (
        [Parameter(Mandatory = $true)]
        [ScriptBlock] $ScriptBlock
    )

    if (Is-Discovery) {
        $state.CurrentBlock.EachTestSetup = $ScriptBlock
    }
}

# endpoint for adding a teardown for each test in the block
function New-EachTestTeardown {
    param (
        [Parameter(Mandatory = $true)]
        [ScriptBlock] $ScriptBlock
    )

    if (Is-Discovery) {
        $state.CurrentBlock.EachTestTeardown = $ScriptBlock
    }
}

# endpoint for adding a setup for all tests in the block
function New-OneTimeTestSetup {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ScriptBlock] $ScriptBlock
    )

    if (Is-Discovery) {
        $state.CurrentBlock.OneTimeTestSetup = $ScriptBlock
    }
}

# endpoint for adding a teardown for all tests in the block
function New-OneTimeTestTeardown {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ScriptBlock] $ScriptBlock
    )
    if (Is-Discovery) {
        $state.CurrentBlock.OneTimeTestTeardown = $ScriptBlock
    }
}

# endpoint for adding a setup for each block in the current block
function New-EachBlockSetup {
    param (
        [Parameter(Mandatory = $true)]
        [ScriptBlock] $ScriptBlock
    )
    if (Is-Discovery) {
        $state.CurrentBlock.EachBlockSetup = $ScriptBlock
    }
}

# endpoint for adding a teardown for each block in the current block
function New-EachBlockTeardown {
    param (
        [Parameter(Mandatory = $true)]
        [ScriptBlock] $ScriptBlock
    )
    if (Is-Discovery) {
        $state.CurrentBlock.EachBlockTeardown = $ScriptBlock
    }
}

# endpoint for adding a setup for all blocks in the current block
function New-OneTimeBlockSetup {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ScriptBlock] $ScriptBlock
    )
    if (Is-Discovery) {
        $state.CurrentBlock.OneTimeBlockSetup = $ScriptBlock
    }
}

# endpoint for adding a teardown for all clocks in the current block
function New-OneTimeBlockTeardown {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ScriptBlock] $ScriptBlock
    )
    if (Is-Discovery) {
        $state.CurrentBlock.OneTimeBlockTeardown = $ScriptBlock
    }
}

function Get-CurrentBlock {
    [CmdletBinding()]
    param()

    $state.CurrentBlock
}

function Get-CurrentTest {
    [CmdletBinding()]
    param()

    $state.CurrentTest
}

function Set-CurrentBlock {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        $Block
    )

    $state.CurrentBlock = $Block
}


function Set-CurrentTest {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        $Test
    )

    $state.CurrentTest = $Test
}


function Is-Discovery {
    $state.Discovery
}

function Discover-Test {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [PSObject[]] $BlockContainer,
        [Parameter(Mandatory = $true)]
        [Management.Automation.SessionState] $SessionState,
        $Filter
    )
    $totalDiscoveryDuration = [Diagnostics.Stopwatch]::StartNew()

    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
        Write-PesterDebugMessage -Scope Discovery -Message "Starting test discovery in $(@($BlockContainer).Length) test containers."
    }

    $steps = $state.Plugin.DiscoveryStart
    if ($null -ne $steps -and 0 -lt @($steps).Count) {
        Invoke-PluginStep -Plugins $state.Plugin -Step DiscoveryStart -Context @{
            BlockContainers = $BlockContainer
            Configuration   = $state.PluginConfiguration
        } -ThrowOnFailure
    }

    $state.Discovery = $true
    $found = foreach ($container in $BlockContainer) {
        $perContainerDiscoveryDuration = [Diagnostics.Stopwatch]::StartNew()

        if ($PesterPreference.Debug.WriteDebugMessages.Value) {
            Write-PesterDebugMessage -Scope Discovery "Discovering tests in $($container.Item)"
        }

        # this is a block object that we add so we can capture
        # OneTime* and Each* setups, and capture multiple blocks in a
        # container
        $root = [Pester.Block]::Create()
        $root.ExpandedName = $root.Name = "Root"

        $root.IsRoot = $true
        $root.ExpandedPath = $root.Path = "Path"

        $root.First = $true
        $root.Last = $true

        # set the data from the container to get them
        # set correctly as if we provided -Data to New-Block
        $root.Data = $container.Data

        Reset-PerContainerState -RootBlock $root

        $steps = $state.Plugin.ContainerDiscoveryStart
        if ($null -ne $steps -and 0 -lt @($steps).Count) {
            Invoke-PluginStep -Plugins $state.Plugin -Step ContainerDiscoveryStart -Context @{
                BlockContainer = $container
                Configuration  = $state.PluginConfiguration
            } -ThrowOnFailure
        }

        try {
            $null = Invoke-BlockContainer -BlockContainer $container -SessionState $SessionState
        }
        catch {
            $root.Passed = $false
            $root.Result = "Failed"
            $root.ErrorRecord.Add($_)
        }

        [PSCustomObject] @{
            Container = $container
            Block     = $root
        }

        $steps = $state.Plugin.ContainerDiscoveryEnd
        if ($null -ne $steps -and 0 -lt @($steps).Count) {
            Invoke-PluginStep -Plugins $state.Plugin -Step ContainerDiscoveryEnd -Context @{
                BlockContainer = $container
                Block          = $root
                Duration       = $perContainerDiscoveryDuration.Elapsed
                Configuration  = $state.PluginConfiguration
            } -ThrowOnFailure
        }

        $root.DiscoveryDuration = $perContainerDiscoveryDuration.Elapsed
        if ($PesterPreference.Debug.WriteDebugMessages.Value) {
            Write-PesterDebugMessage -Scope Discovery -LazyMessage { "Found $(@(View-Flat -Block $root).Count) tests in $([int]$root.DiscoveryDuration.TotalMilliseconds) ms" }
            Write-PesterDebugMessage -Scope DiscoveryCore "Discovery done in this container."
        }
    }

    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
        Write-PesterDebugMessage -Scope Discovery "Processing discovery result objects, to set root, parents, filters etc."
    }

    # focusing is removed from the public api
    # # if any tests / block in the suite have -Focus parameter then all filters are disregarded
    # # and only those tests / blocks should run
    # $focusedTests = [System.Collections.Generic.List[Object]]@()
    # foreach ($f in $found) {
    #     Fold-Container -Container $f.Block `
    #         -OnTest {
    #             # add all focused tests
    #             param($t)
    #             if ($t.Focus) {
    #                 $focusedTests.Add("$(if($null -ne $t.ScriptBlock.File) { $t.ScriptBlock.File } else { $t.ScriptBlock.Id }):$($t.ScriptBlock.StartPosition.StartLine)")
    #             }
    #         } `
    #         -OnBlock {
    #             param($b) if ($b.Focus) {
    #                 # add all tests in the current block, no matter if they are focused or not
    #                 Fold-Block -Block $b -OnTest {
    #                     param ($t)
    #                     $focusedTests.Add("$(if($null -ne $t.ScriptBlock.File) { $t.ScriptBlock.File } else { $t.ScriptBlock.Id }):$($t.ScriptBlock.StartPosition.StartLine)")
    #                 }
    #             }
    #         }
    # }

    # if ($focusedTests.Count -gt 0) {
    #     if ($PesterPreference.Debug.WriteDebugMessages.Value) {
    #         Write-PesterDebugMessage -Scope Discovery  -LazyMessage { "There are some ($($focusedTests.Count)) focused tests '$($(foreach ($p in $focusedTests) { $p -join "." }) -join ",")' running just them." }
    #     }
    #     $Filter =  New-FilterObject -Line $focusedTests
    # }

    foreach ($f in $found) {
        # this takes non-trivial time, measure how long it takes and add it to the discovery
        # so we get more accurate total time
        $sw = [System.Diagnostics.Stopwatch]::StartNew()
        PostProcess-DiscoveredBlock -Block $f.Block -Filter $Filter -BlockContainer $f.Container -RootBlock $f.Block
        $overhead = $sw.Elapsed
        $f.Block.DiscoveryDuration += $overhead
        # Write-Host "disc $($f.Block.DiscoveryDuration.totalmilliseconds) $($overhead.totalmilliseconds) ms" #TODO
        $f.Block
    }

    $steps = $state.Plugin.DiscoveryEnd
    if ($null -ne $steps -and 0 -lt @($steps).Count) {
        Invoke-PluginStep -Plugins $state.Plugin -Step DiscoveryEnd -Context @{
            BlockContainers = $found.Block
            AnyFocusedTests = $focusedTests.Count -gt 0
            FocusedTests    = $focusedTests
            Duration        = $totalDiscoveryDuration.Elapsed
            Configuration   = $state.PluginConfiguration
            Filter          = $Filter
        } -ThrowOnFailure
    }

    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
        Write-PesterDebugMessage -Scope Discovery "Test discovery finished."
    }
}

function Run-Test {
    param (
        [Parameter(Mandatory = $true)]
        [PSObject[]] $Block,
        [Parameter(Mandatory = $true)]
        [Management.Automation.SessionState] $SessionState
    )

    $state.Discovery = $false
    $steps = $state.Plugin.RunStart
    if ($null -ne $steps -and 0 -lt @($steps).Count) {
        Invoke-PluginStep -Plugins $state.Plugin -Step RunStart -Context @{
            Blocks                   = $Block
            Configuration            = $state.PluginConfiguration
            Data                     = $state.PluginData
            WriteDebugMessages       = $PesterPreference.Debug.WriteDebugMessages.Value
            Write_PesterDebugMessage = if ($PesterPreference.Debug.WriteDebugMessages.Value) { $script:SafeCommands['Write-PesterDebugMessage'] }
        } -ThrowOnFailure
    }
    foreach ($rootBlock in $Block) {
        $blockStartTime = $state.UserCodeStopWatch.Elapsed
        $overheadStartTime = $state.FrameworkStopWatch.Elapsed
        Switch-Timer -Scope Framework

        if (-not $rootBlock.ShouldRun) {
            ConvertTo-ExecutedBlockContainer -Block $rootBlock
            continue
        }
        # this resets the timers so keep that before measuring the time
        Reset-PerContainerState -RootBlock $rootBlock

        $rootBlock.Executed = $true
        $rootBlock.ExecutedAt = [DateTime]::now

        $steps = $state.Plugin.ContainerRunStart
        if ($null -ne $steps -and 0 -lt @($steps).Count) {
            Invoke-PluginStep -Plugins $state.Plugin -Step ContainerRunStart -Context @{
                Block         = $rootBlock
                Configuration = $state.PluginConfiguration
            } -ThrowOnFailure
        }

        try {
            # if ($null -ne $rootBlock.OneTimeBlockSetup) {
            #    throw "One time block setup is not supported in root (directly in the block container)."
            #}

            # if ($null -ne $rootBlock.EachBlockSetup) {
            #     throw "Each block setup is not supported in root (directly in the block container)."
            # }

            if ($null -ne $rootBlock.EachTestSetup) {
                throw "Each test setup is not supported in root (directly in the block container)."
            }

            if (
                $null -ne $rootBlock.EachTestTeardown
                #-or $null -ne $rootBlock.OneTimeBlockTeardown `
                #-or $null -ne $rootBlock.EachBlockTeardown `
            ) {
                throw "Each test Teardown is not supported in root (directly in the block container)."
            }

            # add OneTimeTestSetup to set variables, by having $setVariables script that will invoke in the user scope
            # and $setVariablesWithContext that carries the data as is closure, this way we avoid having to provide parameters to
            # before all script, but it might be better to make this a plugin, because there we can pass data.
            $setVariables = {
                param($private:____parameters)

                if ($null -eq $____parameters.Data) {
                    return
                }

                foreach ($private:____d in $____parameters.Data.GetEnumerator()) {
                    & $____parameters.Set_Variable -Name $private:____d.Key -Value $private:____d.Value
                }
            }

            $SessionStateInternal = $script:SessionStateInternalProperty.GetValue($SessionState, $null)
            $script:ScriptBlockSessionStateInternalProperty.SetValue($setVariables, $SessionStateInternal, $null)

            $setVariablesAndThenRunOneTimeSetupIfAny = & {
                $action = $setVariables
                $setup = $rootBlock.OneTimeTestSetup
                $parameters = @{
                    Data         = $rootBlock.BlockContainer.Data
                    Set_Variable = $SafeCommands["Set-Variable"]
                }

                {
                    . $action $parameters
                    if ($null -ne $setup) {
                        . $setup
                    }
                }.GetNewClosure()
            }

            $rootBlock.OneTimeTestSetup = $setVariablesAndThenRunOneTimeSetupIfAny

            $rootBlock.ScriptBlock = {}
            $SessionStateInternal = $script:SessionStateInternalProperty.GetValue($SessionState, $null)
            $script:ScriptBlockSessionStateInternalProperty.SetValue($rootBlock.ScriptBlock, $SessionStateInternal, $null)

            # we add one more artificial block so the root can run
            # all of it's setups and teardowns
            $Pester___parent = [Pester.Block]::Create()
            $Pester___parent.Name = "ParentBlock"
            $Pester___parent.Path = "Path"

            $Pester___parent.First = $false
            $Pester___parent.Last = $false

            $Pester___parent.Order.Add($rootBlock)

            $wrapper = {
                $null = Invoke-Block -previousBlock $Pester___parent
            }

            Invoke-InNewScriptScope -ScriptBlock $wrapper -SessionState $SessionState
        }
        catch {
            $rootBlock.ErrorRecord.Add($_)
        }

        PostProcess-ExecutedBlock -Block $rootBlock
        $result = ConvertTo-ExecutedBlockContainer -Block $rootBlock
        $result.FrameworkDuration = $state.FrameworkStopWatch.Elapsed - $overheadStartTime
        $result.UserDuration = $state.UserCodeStopWatch.Elapsed - $blockStartTime

        $steps = $state.Plugin.ContainerRunEnd
        if ($null -ne $steps -and 0 -lt @($steps).Count) {
            Invoke-PluginStep -Plugins $state.Plugin -Step ContainerRunEnd -Context @{
                Result        = $result
                Block         = $rootBlock
                Configuration = $state.PluginConfiguration
            } -ThrowOnFailure
        }

        # set this again so the plugins have some data but that we also include the plugin invocation to the
        # overall time to keep the actual timing correct
        $result.FrameworkDuration = $state.FrameworkStopWatch.Elapsed - $overheadStartTime
        $result.UserDuration = $state.UserCodeStopWatch.Elapsed - $blockStartTime
        if ($PesterPreference.Debug.WriteDebugMessages.Value) {
            Write-PesterDebugMessage -Scope Timing "Container duration $($result.UserDuration.TotalMilliseconds)ms"
            Write-PesterDebugMessage -Scope Timing "Container framework duration $($result.FrameworkDuration.TotalMilliseconds)ms"
        }

        $result
    }

    $steps = $state.Plugin.RunEnd
    if ($null -ne $steps -and 0 -lt @($steps).Count) {
        Invoke-PluginStep -Plugins $state.Plugin -Step RunEnd -Context @{
            Blocks                   = $Block
            Configuration            = $state.PluginConfiguration
            Data                     = $state.PluginData
            WriteDebugMessages       = $PesterPreference.Debug.WriteDebugMessages.Value
            Write_PesterDebugMessage = if ($PesterPreference.Debug.WriteDebugMessages.Value) { $script:SafeCommands['Write-PesterDebugMessage'] }
        } -ThrowOnFailure
    }
}

function Invoke-PluginStep {
    # [CmdletBinding()]
    param (
        [PSObject[]] $Plugins,
        [Parameter(Mandatory)]
        [ValidateSet('Start', 'DiscoveryStart', 'ContainerDiscoveryStart', 'BlockDiscoveryStart', 'TestDiscoveryStart', 'TestDiscoveryEnd', 'BlockDiscoveryEnd', 'ContainerDiscoveryEnd', 'DiscoveryEnd', 'RunStart', 'ContainerRunStart', 'OneTimeBlockSetupStart', 'EachBlockSetupStart', 'OneTimeTestSetupStart', 'EachTestSetupStart', 'EachTestTeardownEnd', 'OneTimeTestTeardownEnd', 'EachBlockTeardownEnd', 'OneTimeBlockTeardownEnd', 'ContainerRunEnd', 'RunEnd', 'End')]
        [String] $Step,
        $Context = @{ },
        [Switch] $ThrowOnFailure
    )

    # there are actually two ways to invoke plugin steps, this unified cmdlet that allows us to run the steps
    # in isolation, and then another where we are using Invoke-ScriptBlock directly when we need the plugin to run
    # for example as a teardown step of a test.

    # switch-timer framework
    $state.UserCodeStopWatch.Stop()
    $state.FrameworkStopWatch.Start()

    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
        $sw = [Diagnostics.Stopwatch]::StartNew()
    }

    $pluginsWithGivenStep = @(foreach ($p in $Plugins) { if ($null -ne $p.$Step) { $p } })

    if ($null -eq $pluginsWithGivenStep -or 0 -eq @($pluginsWithGivenStep).Count) {
        if ($PesterPreference.Debug.WriteDebugMessages.Value) {
            Write-PesterDebugMessage -Scope PluginCore "No plugins with step $Step were provided"
        }
        return
    }

    # this is end step, we should run all steps no matter if some failed, and we should run them in opposite direction
    # only do this if there is more than 1, to avoid the "expensive" -like check and reverse
    $isEndStep = 1 -lt $pluginsWithGivenStep.Count -and $Step -like "*End"
    if (-not $isEndStep) {
        [Array]::Reverse($pluginsWithGivenStep)
    }

    $err = [Collections.Generic.List[Management.Automation.ErrorRecord]]@()
    $failed = $false
    # the plugins expect -Context and then the actual context in it
    # this was a choice at the start of the project to make it easy to see
    # what is available, not sure if a good choice
    $ctx = @{
        Context = $Context
    }
    $standardOutput =
    foreach ($p in $pluginsWithGivenStep) {
        if ($failed -and -not $isEndStep) {
            if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                Write-PesterDebugMessage -Scope Plugin "Skipping $($p.Name) step $Step because some previous plugin failed"
            }
            continue
        }

        try {
            if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                $stepSw = [Diagnostics.Stopwatch]::StartNew()
                $hasContext = 0 -lt $Context.Count
                $c = if ($hasContext) { $Context | & $script:SafeCommands['Out-String'] }
                Write-PesterDebugMessage -Scope Plugin "Running $($p.Name) step $Step $(if ($hasContext) { "with context: $c" } else { "without any context"})"
            }

            do {
                & $p.$Step @ctx
            } while ($false)

            if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                Write-PesterDebugMessage -Scope Plugin "Success $($p.Name) step $Step in $($stepSw.ElapsedMilliseconds) ms"
            }
        }
        catch {
            $failed = $true
            $err.Add($_)
            if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                Write-PesterDebugMessage -Scope Plugin "Failed $($p.Name) step $Step in $($stepSw.ElapsedMilliseconds) ms" -ErrorRecord $_
            }
        }
    }

    if ($ThrowOnFailure) {
        if ($failed) {
            $r = [Pester.InvocationResult]::Create((-not $failed), $err, $standardOutput)
            Assert-Success $r -Message "Invoking step $step failed"
        }
        else {
            # do nothing, especially don't create or return the result object
        }
    }
    else {
        $r = [Pester.InvocationResult]::Create((-not $failed), $err, $standardOutput)
        return $r
    }
}

function Assert-Success {
    # [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [PSObject[]] $InvocationResult,
        [String] $Message = "Invocation failed"
    )

    $rc = 0
    $anyFailed = $false
    $err = ""
    foreach ($r in $InvocationResult) {
        $rc++
        $ec = 0
        if ($null -ne $r.ErrorRecord -and $r.ErrorRecord.Length -gt 0) {
            $anyFailed = $true
            foreach ($e in $r.ErrorRecord) {
                $err += "$([Environment]::NewLine)Result $rc - Error $((++$ec)):"
                $err += & $SafeCommands["Out-String"] -InputObject $e
                $err += & $SafeCommands["Out-String"] -InputObject $e.ScriptStackTrace
            }
        }
    }

    if ($anyFailed) {
        $Message = $Message + ":$err"
        throw $Message
    }
}

function Invoke-ScriptBlock {
    param(
        [ScriptBlock] $ScriptBlock,
        [ScriptBlock[]] $OuterSetup,
        [ScriptBlock[]] $Setup,
        [ScriptBlock[]] $Teardown,
        [ScriptBlock[]] $OuterTeardown,
        $Context = @{ },
        # define data to be shared in only in the inner scope where e.g eachTestSetup + test run but not
        # in the scope where OneTimeTestSetup runs, on the other hand, plugins want context
        # in all scopes
        [Switch] $ReduceContextToInnerScope,
        # # setup, body and teardown will all run (be-dotsourced into)
        # # the same scope
        # [Switch] $SameScope,
        # will dot-source the wrapper scriptblock instead of invoking it
        # so in combination with the SameScope switch we are effectively
        # running the code in the current scope
        [Switch] $NoNewScope,
        [Switch] $MoveBetweenScopes,
        [ScriptBlock] $OnUserScopeTransition = $null,
        [ScriptBlock] $OnFrameworkScopeTransition = $null,
        $Configuration
    )

    # filter nulls, inlined to avoid overhead of combineNonNull and selectNonNull
    $OuterSetup = if ($null -ne $OuterSetup -and 0 -lt $OuterSetup.Count) {
        foreach ($i in $OuterSetup) {
            if ($null -ne $i) {
                $i
            }
        }
    }

    $Setup = if ($null -ne $Setup -and 0 -lt $Setup.Count) {
        foreach ($i in $Setup) {
            if ($null -ne $i) {
                $i
            }
        }
    }

    $Teardown = if ($null -ne $Teardown -and 0 -lt $Teardown.Count) {
        foreach ($i in $Teardown) {
            if ($null -ne $i) {
                $i
            }
        }
    }

    $OuterTeardown = if ($null -ne $OuterTeardown -and 0 -lt $OuterTeardown.Count) {
        foreach ($i in $OuterTeardown) {
            if ($null -ne $i) {
                $i
            }
        }
    }





    # this is what the code below does
    # . $OuterSetup
    # & {
    #     try {
    #       # import setup to scope
    #       . $Setup
    #       # executed the test code in the same scope
    #       . $ScriptBlock
    #     } finally {
    #       . $Teardown
    #     }
    # }
    # . $OuterTeardown


    $wrapperScriptBlock = {
        # THIS RUNS (MOST OF THE TIME) IN USER SCOPE, BE CAREFUL WHAT YOU PUBLISH AND CONSUME!
        param($______parameters)

        if (-not $______parameters.NoNewScope) {
            # a child runner that will not create a new scope will force itself into the current scope
            # and overwrite our params in the inner scope (denoted by & { below), keep a second reference to it
            # so we can use it for Teardowns and to forward errors that happened after test teardown
            $______parametersForward = $______parameters
        }



        try {
            if ($______parameters.ContextInOuterScope) {
                $______outerSplat = $______parameters.Context
                if ($______parameters.EnableWriteDebug) { &$______parameters.WriteDebug "Setting context variables" }
                foreach ($______current in $______outerSplat.GetEnumerator()) {
                    if ($______parameters.EnableWriteDebug) { &$______parameters.WriteDebug "Setting context variable '$($______current.Key)' with value '$($______current.Value)'" }
                    $ExecutionContext.SessionState.PSVariable.Set($______current.Key, $______current.Value)
                }

                if ($______outerSplat.ContainsKey("_")) {
                    $______outerSplat.Remove("_")
                }

                $______current = $null
            }
            else {
                $______outerSplat = @{ }
            }

            if ($null -ne $______parameters.OuterSetup -and $______parameters.OuterSetup.Length -gt 0) {
                if ($______parameters.EnableWriteDebug) { &$______parameters.WriteDebug "Running outer setups" }
                foreach ($______current in $______parameters.OuterSetup) {
                    if ($______parameters.EnableWriteDebug) { &$______parameters.WriteDebug "Running outer setup { $______current }" }
                    $______parameters.CurrentlyExecutingScriptBlock = $______current
                    . $______current @______outerSplat
                }
                $______current = $null
                $______parameters.OuterSetup = $null
                if ($______parameters.EnableWriteDebug) { &$______parameters.WriteDebug "Done running outer setups" }
            }
            else {
                if ($______parameters.EnableWriteDebug) { &$______parameters.WriteDebug "There are no outer setups" }
            }

            & {
                try {

                    if (-not $______parameters.ContextInOuterScope) {
                        $______innerSplat = $______parameters.Context
                        if ($______parameters.EnableWriteDebug) { &$______parameters.WriteDebug "Setting context variables" }
                        foreach ($______current in $______innerSplat.GetEnumerator()) {
                            if ($______parameters.EnableWriteDebug) { &$______parameters.WriteDebug "Setting context variable '$ ($______current.Key)' with value '$($______current.Value)'" }
                            $ExecutionContext.SessionState.PSVariable.Set($______current.Key, $______current.Value)
                        }

                        if ($______outerSplat.ContainsKey("_")) {
                            $______outerSplat.Remove("_")
                        }

                        $______current = $null
                    }
                    else {
                        $______innerSplat = $______outerSplat
                    }

                    if ($null -ne $______parameters.Setup -and $______parameters.Setup.Length -gt 0) {
                        if ($______parameters.EnableWriteDebug) { &$______parameters.WriteDebug "Running inner setups" }
                        foreach ($______current in $______parameters.Setup) {
                            if ($______parameters.EnableWriteDebug) { &$______parameters.WriteDebug "Running inner setup { $______current }" }
                            $______parameters.CurrentlyExecutingScriptBlock = $______current
                            . $______current @______innerSplat
                        }
                        $______current = $null
                        $______parameters.Setup = $null
                        if ($______parameters.EnableWriteDebug) { &$______parameters.WriteDebug "Done running inner setups" }
                    }
                    else {
                        if ($______parameters.EnableWriteDebug) { &$______parameters.WriteDebug "There are no inner setups" }
                    }

                    if ($null -ne $______parameters.ScriptBlock) {
                        if ($______parameters.EnableWriteDebug) { &$______parameters.WriteDebug "Running scriptblock { $($______parameters.ScriptBlock) }" }
                        $______parameters.CurrentlyExecutingScriptBlock = $______parameters.ScriptBlock
                        . $______parameters.ScriptBlock @______innerSplat

                        if ($______parameters.EnableWriteDebug) { &$______parameters.WriteDebug "Done running scriptblock" }
                    }
                    else {
                        if ($______parameters.EnableWriteDebug) { &$______parameters.WriteDebug "There is no scriptblock to run" }
                    }
                }
                catch {
                    $______parameters.ErrorRecord.Add($_)
                    if ($______parameters.EnableWriteDebug) { &$______parameters.WriteDebug "Fail running setups or scriptblock" -ErrorRecord $_ }
                }
                finally {
                    if ($null -ne $______parameters.Teardown -and $______parameters.Teardown.Length -gt 0) {
                        if ($______parameters.EnableWriteDebug) { &$______parameters.WriteDebug "Running inner teardowns" }
                        if ($______parameters.MoveBetweenScopes) { & $______parameters.SwitchTimerUserCode }
                        foreach ($______current in $______parameters.Teardown) {
                            try {
                                if ($______parameters.EnableWriteDebug) { &$______parameters.WriteDebug "Running inner teardown { $______current }" }
                                $______parameters.CurrentlyExecutingScriptBlock = $______current
                                . $______current @______innerSplat
                                if ($______parameters.EnableWriteDebug) { &$______parameters.WriteDebug "Done running inner teardown" }
                            }
                            catch {
                                $______parameters.ErrorRecord.Add($_)
                                if ($______parameters.EnableWriteDebug) { &$______parameters.WriteDebug "Fail running inner teardown" -ErrorRecord $_ }
                            }
                        }
                        $______current = $null

                        # nulling this variable is important when we run without new scope
                        # then $______parameters.Teardown remains set and EachBlockTeardown
                        # runs twice
                        $______parameters.Teardown = $null
                        if ($______parameters.EnableWriteDebug) { &$______parameters.WriteDebug "Done running inner teardowns" }
                    }
                    else {
                        if ($______parameters.EnableWriteDebug) { &$______parameters.WriteDebug "There are no inner teardowns" }
                    }
                }
            }
        }
        finally {

            if ($null -ne $______parameters.OuterTeardown -and $______parameters.OuterTeardown.Length -gt 0) {
                if ($______parameters.EnableWriteDebug) { &$______parameters.WriteDebug "Running outer teardowns" }
                if ($______parameters.MoveBetweenScopes) { & $______parameters.SwitchTimerUserCode }
                foreach ($______current in $______parameters.OuterTeardown) {
                    try {
                        if ($______parameters.EnableWriteDebug) { &$______parameters.WriteDebug "Running outer teardown { $______current }" }
                        $______parameters.CurrentlyExecutingScriptBlock = $______current
                        . $______current @______outerSplat
                        if ($______parameters.EnableWriteDebug) { &$______parameters.WriteDebug "Done running outer teardown" }
                    }
                    catch {
                        if ($______parameters.EnableWriteDebug) { &$______parameters.WriteDebug "Fail running outer teardown" -ErrorRecord $_ }
                        $______parameters.ErrorRecord.Add($_)
                    }
                }
                $______parameters.OuterTeardown = $null
                $______current = $null
                if ($______parameters.EnableWriteDebug) { &$______parameters.WriteDebug "Done running outer teardowns" }
            }
            else {
                if ($______parameters.EnableWriteDebug) { &$______parameters.WriteDebug "There are no outer teardowns" }
            }

            if ($______parameters.NoNewScope -and $ExecutionContext.SessionState.PSVariable.GetValue('______parametersForward')) {
                $______parameters = $______parametersForward
            }
        }
    }

    if ($MoveBetweenScopes -and $null -ne $ScriptBlock) {
        $SessionStateInternal = $script:ScriptBlockSessionStateInternalProperty.GetValue($ScriptBlock, $null)
        # attach the original session state to the wrapper scriptblock
        # making it invoke in the same scope as $ScriptBlock
        $script:ScriptBlockSessionStateInternalProperty.SetValue($wrapperScriptBlock, $SessionStateInternal, $null)
    }

    $writeDebug = if ($PesterPreference.Debug.WriteDebugMessages.Value) {
        {
            param($Message, [Management.Automation.ErrorRecord] $ErrorRecord)
            Write-PesterDebugMessage -Scope "RuntimeCore" $Message -ErrorRecord $ErrorRecord
        }
    }

    $switchTimerUserCode = if ($MoveBetweenScopes) {
        {
            $state.UserCodeStopWatch.Start()
            $state.FrameworkStopWatch.Stop()
        }
    }

    #$break = $true
    $err = $null
    try {
        $parameters = @{
            ScriptBlock                   = $ScriptBlock
            OuterSetup                    = $OuterSetup
            Setup                         = $Setup
            Teardown                      = $Teardown
            OuterTeardown                 = $OuterTeardown
            CurrentlyExecutingScriptBlock = $null
            ErrorRecord                   = [Collections.Generic.List[Management.Automation.ErrorRecord]]@()
            Context                       = $Context
            ContextInOuterScope           = -not $ReduceContextToInnerScope
            EnableWriteDebug              = $PesterPreference.Debug.WriteDebugMessages.Value
            WriteDebug                    = $writeDebug
            Configuration                 = $Configuration
            NoNewScope                    = $NoNewScope
            MoveBetweenScopes             = $MoveBetweenScopes
            SwitchTimerUserCode           = $switchTimerUserCode
        }

        # here we are moving into the user scope if the provided
        # scriptblock was bound to user scope, so we want to take some actions
        # typically switching between user and framework timer. There are still tiny pieces of
        # framework code running in the scriptblock but we can safely ignore those because they are
        # just logging, so the time difference is miniscule.
        # The code might also run just in framework scope, in that case the callback can remain empty,
        # eg when we are invoking framework setup.
        if ($MoveBetweenScopes) {
            # switch-timer to user scope inlined
            $state.UserCodeStopWatch.Start()
            $state.FrameworkStopWatch.Stop()

            if ($null -ne $OnUserScopeTransition) {
                & $OnUserScopeTransition
            }
        }
        do {
            $standardOutput = if ($NoNewScope) {
                . $wrapperScriptBlock $parameters
            }
            else {
                & $wrapperScriptBlock $parameters
            }
            # if the code reaches here we did not break
            #$break = $false
        } while ($false)
    }
    catch {
        $err = $_
    }

    if ($MoveBetweenScopes) {
        # switch-timer to framework scope inlined
        $state.UserCodeStopWatch.Stop()
        $state.FrameworkStopWatch.Start()

        if ($null -ne $OnFrameworkScopeTransition) {
            & $OnFrameworkScopeTransition
        }
    }

    if ($err) {
        $parameters.ErrorRecord.Add($err)
    }

    $r = [Pester.InvocationResult]::Create((0 -eq $parameters.ErrorRecord.Count), $parameters. ErrorRecord, $standardOutput)

    return $r
}

function Reset-TestSuiteTimer ($o) {

}

function Switch-Timer {
    param (
        [Parameter(Mandatory)]
        [ValidateSet("Framework", "UserCode")]
        $Scope
    )

    # perf: optimizing away parameter and validate set, and $Scope as int or bool within an if, only brings about 1/3 saving (about 60 ms per 1000 calls)
    # not worth it for the moment
    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
        if ($state.UserCodeStopWatch.IsRunning) {
            Write-PesterDebugMessage -Scope TimingCore "Switching from UserCode to $Scope"
        }

        if ($state.FrameworkStopWatch.IsRunning) {
            Write-PesterDebugMessage -Scope TimingCore "Switching from Framework to $Scope"
        }

        Write-PesterDebugMessage -Scope TimingCore -Message "UserCode total time $($state.UserCodeStopWatch.ElapsedMilliseconds)ms"
        Write-PesterDebugMessage -Scope TimingCore -Message "Framework total time $($state.FrameworkStopWatch.ElapsedMilliseconds)ms"
    }

    switch ($Scope) {
        "Framework" {
            # running in framework code adds time only to the overhead timer
            $state.UserCodeStopWatch.Stop()
            $state.FrameworkStopWatch.Start()
        }
        "UserCode" {
            $state.UserCodeStopWatch.Start()
            $state.FrameworkStopWatch.Stop()
        }
        default { throw [ArgumentException]"" }
    }
}

function Test-ShouldRun {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        $Item,
        $Filter
    )

    # see https://github.com/pester/Pester/issues/1442 for description of how this filtering works

    $result = @{
        Include  = $false
        Exclude  = $false
        Explicit = $false
    }

    $anyIncludeFilters = $false
    $fullDottedPath = $Item.Path -join "."
    if ($null -eq $Filter) {
        if ($PesterPreference.Debug.WriteDebugMessages.Value) {
            Write-PesterDebugMessage -Scope Filter "($fullDottedPath) $($Item.ItemType) is included, because there is no filters."
        }

        $result.Include = $true
        return $result
    }

    $parent = if ('Test' -eq $Item.ItemType) {
        $Item.Block
    }
    elseif ('Block' -eq $Item.ItemType) {
        # no need to check if we are root, we will not run these rules on Root block
        $Item.Parent
    }

    if ($parent.Exclude) {
        if ($PesterPreference.Debug.WriteDebugMessages.Value) {
            Write-PesterDebugMessage -Scope Filter "($fullDottedPath) $($Item.ItemType) is excluded, because it's parent is excluded."
        }
        $result.Exclude = $true
        return $result
    }

    # item is excluded when any of the exclude tags match
    $tagFilter = $Filter.ExcludeTag
    if ($tagFilter -and 0 -ne $tagFilter.Count) {
        foreach ($f in $tagFilter) {
            foreach ($t in $Item.Tag) {
                if ($t -like $f) {
                    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                        Write-PesterDebugMessage -Scope Filter "($fullDottedPath) $($Item.ItemType) is excluded, because it's tag '$t' matches exclude tag filter '$f'."
                    }
                    $result.Exclude = $true
                    return $result
                }
            }
        }
        if ($PesterPreference.Debug.WriteDebugMessages.Value) {
            Write-PesterDebugMessage -Scope Filter "($fullDottedPath) $($Item.ItemType) did not match the exclude tag filter, moving on to the next filter."
        }
    }

    $excludeLineFilter = $Filter.ExcludeLine

    $line = "$(if ($Item.ScriptBlock.File) { $Item.ScriptBlock.File } else { $Item.ScriptBlock.Id }):$($Item.StartLine)" -replace '\\', '/'
    if ($excludeLineFilter -and 0 -ne $excludeLineFilter.Count) {
        foreach ($l in $excludeLineFilter -replace '\\', '/') {
            if ($l -eq $line) {
                if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                    Write-PesterDebugMessage -Scope Filter "($fullDottedPath) $($Item.ItemType) is excluded, because its path:line '$line' matches line filter '$excludeLineFilter'."
                    Write-PesterDebugMessage -Scope Filter "($fullDottedPath) $($Item.ItemType) is explicitly excluded, because it matched line filter, and will run even if -Skip is specified on it. Any skipped children will still be skipped."
                }
                $result.Exclude = $true
                $result.Explicit = $true
                return $result
            }
        }
    }

    # - place exclude filters above this line and include below this line

    $lineFilter = $Filter.Line
    # use File for saved files or Id for ScriptBlocks without files
    # this filter has the ability to set the test to "explicit" so we can run
    # the test even if it is marked as skipped run this include as first so we figure it out
    # in one place and check if parent was included after this one to short circuit the other
    # filters in case parent already knows that it will run

    $line = "$(if ($Item.ScriptBlock.File) { $Item.ScriptBlock.File } else { $Item.ScriptBlock.Id }):$($Item.StartLine)" -replace '\\', '/'
    if ($lineFilter -and 0 -ne $lineFilter.Count) {
        $anyIncludeFilters = $true
        foreach ($l in $lineFilter -replace '\\', '/') {
            if ($l -eq $line) {
                if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                    Write-PesterDebugMessage -Scope Filter "($fullDottedPath) $($Item.ItemType) is included, because its path:line '$line' matches line filter '$lineFilter'."
                }

                # if ('Test' -eq $Item.ItemType ) {
                if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                    Write-PesterDebugMessage -Scope Filter "($fullDottedPath) $($Item.ItemType) is explicitly included, because it matched line filter, and will run even if -Skip is specified on it. Any skipped children will still be skipped."
                }

                $result.Explicit = $true
                # }

                $result.Include = $true
                return $result
            }
        }
    }

    if ($parent.Include) {
        if ($PesterPreference.Debug.WriteDebugMessages.Value) {
            Write-PesterDebugMessage -Scope Filter "($fullDottedPath) $($Item.ItemType) is included, because its parent is included."
        }

        $result.Include = $true
        return $result
    }

    # test is included when it has tags and the any of the tags match
    $tagFilter = $Filter.Tag
    if ($tagFilter -and 0 -ne $tagFilter.Count) {
        $anyIncludeFilters = $true
        if ($null -eq $Item.Tag -or 0 -eq $Item.Tag) {
            if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                Write-PesterDebugMessage -Scope Filter "($fullDottedPath) $($Item.ItemType) has no tags, moving to next include filter."
            }
        }
        else {
            foreach ($f in $tagFilter) {
                foreach ($t in $Item.Tag) {
                    if ($t -like $f) {
                        if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                            Write-PesterDebugMessage -Scope Filter "($fullDottedPath) $($Item.ItemType) is included, because it's tag '$t' matches tag filter '$f'."
                        }

                        $result.Include = $true
                        return $result
                    }
                }
            }
        }
    }

    $allPaths = $Filter.FullName
    if ($allPaths -and 0 -ne $allPaths) {
        $anyIncludeFilters = $true
        foreach ($p in $allPaths) {
            if ($fullDottedPath -like $p) {
                $include = $true
                break
            }
        }
        if ($include) {
            if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                Write-PesterDebugMessage -Scope Filter "($fullDottedPath) $($Item.ItemType) is included, because it matches fullname filter '$include'."
            }

            $result.Include = $true
            return $result
        }
        else {
            if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                Write-PesterDebugMessage -Scope Filter "($fullDottedPath) $($Item.ItemType) does not match the dotted path filter, moving to next include filter."
            }
        }
    }

    if ($anyIncludeFilters) {
        if ('Test' -eq $Item.ItemType) {
            if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                Write-PesterDebugMessage -Scope Filter "($fullDottedPath) $($Item.ItemType) did not match any of the include filters, it will not be included in the run."
            }
        }
        elseif ('Block' -eq $Item.ItemType) {
            if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                Write-PesterDebugMessage -Scope Filter "($fullDottedPath) $($Item.ItemType) did not match any of the include filters, but it will still be included in the run, it's children will determine if it will run."
            }
        }
        else {
            throw "Item type $($Item.ItemType) is not supported in filter."
        }
    }
    else {
        if ('Test' -eq $Item.ItemType) {
            if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                Write-PesterDebugMessage -Scope Filter "($fullDottedPath) $($Item.ItemType) will be included in the run, because there were no include filters so all tests are included unless they match exclude rule."
            }

            $result.Include = $true
        } # putting the bool in both to avoid string comparison
        elseif ('Block' -eq $Item.ItemType) {
            if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                Write-PesterDebugMessage -Scope Filter "($fullDottedPath) $($Item.ItemType) will be included in the run, because there were no include filters, and will let its children to determine whether or not it should run."
            }
        }
        else {
            throw "Item type $($Item.ItemType) is not supported in filter."
        }

        return $result
    }

    return $result
}

function Invoke-Test {
    #[CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [PSObject[]] $BlockContainer,
        [Parameter(Mandatory = $true)]
        [Management.Automation.SessionState] $SessionState,
        $Filter,
        $Plugin,
        $PluginConfiguration,
        $PluginData,
        $Configuration
    )

    # set the incoming value for all the child scopes
    # TODO: revisit this because this will probably act weird as we jump between session states
    $PesterPreference = $Configuration


    # define the state if we don't have it yet, this will happen when we call this function directly
    # but normally the parent invoker (most often Invoke-Pester) will set the state. So we don't want to reset
    # it here.
    if (notDefined state) {
        $state = New-PesterState
    }

    $state.Plugin = $Plugin
    $state.PluginConfiguration = $PluginConfiguration
    $state.PluginData = $PluginData
    $state.Configuration = $Configuration

    # # TODO: this it potentially unreliable, because suppressed errors are written to Error as well. And the errors are captured only from the caller state. So let's use it only as a useful indicator during migration and see how it works in production code.

    # # finding if there were any non-terminating errors during the run, user can clear the array, and the array has fixed size so we can't just try to detect if there is any difference by counts before and after. So I capture the last known error in that state and try to find it in the array after the run
    # $originalErrors = $SessionState.PSVariable.Get("Error").Value
    # $originalLastError = $originalErrors[0]
    # $originalErrorCount = $originalErrors.Count

    $found = Discover-Test -BlockContainer $BlockContainer -Filter $Filter -SessionState $SessionState

    if ($PesterPreference.Run.SkipRun.Value) {
        foreach ($f in $found) {
            ConvertTo-DiscoveredBlockContainer -Block $f
        }

        return
    }
    # $errs = $SessionState.PSVariable.Get("Error").Value
    # $errsCount = $errs.Count
    # if ($errsCount -lt $originalErrorCount) {
    #     # it would be possible to detect that there are 0 errors, in the array and continue,
    #     # but this still indicates the user code is running where it should not, so let's throw anyway
    #     throw "Test discovery failed. The error count ($errsCount) after running discovery is lower than the error count before discovery ($originalErrorCount). Is some of your code running outside Pester controlled blocks and it clears the `$error array by calling `$error.Clear()?"

    # }


    # if ($originalErrorCount -lt $errsCount) {
    #     # probably the most usual case,  there are more errors then there were before,
    #     # so some were written to the screen, this also runs when the user cleared the
    #     # array and wrote more errors than there originally were
    #     $i = $errsCount - $originalErrorCount
    # }
    # else {
    #     # there is equal amount of errors, the array was probably full and so the original
    #     # error shifted towards the end of the array, we try to find it and see how many new
    #     # errors are there
    #     for ($i = 0 ; $i -lt $errsLength; $i++) {
    #         if ([object]::referenceEquals($errs[$i], $lastError)) {
    #             break
    #         }
    #     }
    # }
    # if (0 -ne $i) {
    #     throw "Test discovery failed. There were $i non-terminating errors during test discovery. This indicates that some of your code is invoked outside of Pester controlled blocks and fails. No tests will be run."
    # }
    Run-Test -Block $found -SessionState $SessionState
}

function PostProcess-DiscoveredBlock {
    param (
        [Parameter(Mandatory = $true)]
        $Block,
        $Filter,
        $BlockContainer,
        [Parameter(Mandatory = $true)]
        $RootBlock
    )

    # pass array of blocks rather than 1 block to cross the function boundary
    # as few times as we can
    foreach ($b in $Block) {
        if ($PesterPreference.Debug.WriteDebugMessages.Value) {
            $path = $b.Path -join "."
        }

        # traverses the block structure after a block was found and
        # link childs to their parents, filter blocks and tests to
        # determine which should run, and mark blocks and tests
        # as first or last to know when one time setups & teardowns should run
        $b.IsRoot = $b -eq $RootBlock
        $b.Root = $RootBlock
        $b.BlockContainer = $BlockContainer

        $tests = $b.Tests

        if ($b.IsRoot) {
            $b.Explicit = $false
            $b.Exclude = $false
            $b.Include = $false
            $b.ShouldRun = $true
        }
        else {
            $shouldRun = (Test-ShouldRun -Item $b -Filter $Filter)
            $b.Explicit = $shouldRun.Explicit

            if (-not $shouldRun.Exclude -and -not $shouldRun.Include) {
                $b.ShouldRun = $true
            }
            elseif ($shouldRun.Include) {
                $b.ShouldRun = $true
            }
            elseif ($shouldRun.Exclude) {
                $b.ShouldRun = $false
            }
            else {
                throw "Unknown combination of include exclude $($shouldRun)"
            }

            $b.Include = $shouldRun.Include -and -not $shouldRun.Exclude
            $b.Exclude = $shouldRun.Exclude
        }

        $parentBlockIsSkipped = (-not $b.IsRoot -and $b.Parent.Skip)

        if ($b.Skip) {
            if ($b.Explicit) {
                if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                    Write-PesterDebugMessage -Scope Skip "($path) Block was marked as skipped, but will not be skipped because it was explicitly requested to run."
                }

                $b.Skip = $false
            }
            else {
                if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                    Write-PesterDebugMessage -Scope Skip "($path) Block is skipped."
                }

                $b.Skip = $true
            }
        }
        elseif ($parentBlockIsSkipped) {
            if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                Write-PesterDebugMessage -Scope Skip "($path) Block is skipped because a parent block was skipped."
            }

            $b.Skip = $true
        }

        $blockShouldRun = $false
        $allTestsSkipped = $true
        if ($tests.Count -gt 0) {
            foreach ($t in $tests) {
                $t.Block = $b

                if ($t.Block.Exclude) {
                    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                        $path = $t.Path -join "."
                        Write-PesterDebugMessage -Scope Filter "($path) Test is excluded because parent block was excluded."
                    }
                    $t.ShouldRun = $false
                }
                else {
                    # run the exclude filters before checking if the parent is included
                    # otherwise you would include tests that could match the exclude rule
                    $shouldRun = (Test-ShouldRun -Item $t -Filter $Filter)
                    $t.Explicit = $shouldRun.Explicit

                    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                        $path = $t.Path -join "."
                    }

                    if (-not $shouldRun.Include -and -not $shouldRun.Exclude) {
                        $t.ShouldRun = $false
                    }
                    elseif ($shouldRun.Include) {
                        $t.ShouldRun = $true
                    }
                    elseif ($shouldRun.Exclude) {
                        $t.ShouldRun = $false
                    }
                    else {
                        throw "Unknown combination of ShouldRun $ShouldRun"
                    }
                }

                if ($t.Skip) {
                    if ($t.ShouldRun -and $t.Explicit) {
                        if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                            Write-PesterDebugMessage -Scope Skip "($path) Test was marked as skipped, but will not be skipped because it was explicitly requested to run."
                        }

                        $t.Skip = $false
                    }
                    else {
                        if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                            Write-PesterDebugMessage -Scope Skip "($path) Test is skipped."
                        }

                        $t.Skip = $true
                    }
                }
                elseif ($b.Skip) {
                    if ($t.ShouldRun -and $t.Explicit) {
                        if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                            Write-PesterDebugMessage -Scope Skip "($path) Test was marked as skipped, because its parent was marked as skipped, but will not be skipped because it was explicitly requested to run."
                        }

                        $t.Skip = $false
                    }
                    else {
                        if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                            Write-PesterDebugMessage -Scope Skip "($path) Test is skipped because a parent block was skipped."
                        }

                        $t.Skip = $true
                    }
                }
            }


            # if we determined that the block should run we can still make it not run if
            # none of it's children will run
            if ($b.ShouldRun) {
                $testsToRun = foreach ($t in $tests) { if ($t.ShouldRun) { $t } }
                if ($testsToRun -and 0 -ne $testsToRun.Count) {
                    $testsToRun[0].First = $true
                    $testsToRun[-1].Last = $true
                    $blockShouldRun = $true
                }

                foreach ($t in $testsToRun) {
                    if (-not $t.Skip) {
                        $allTestsSkipped = $false
                        break
                    }
                }
            }
        }

        $childBlocks = $b.Blocks
        $anyChildBlockShouldRun = $false
        $allChildBlockSkipped = $true
        if ($childBlocks.Count -gt 0) {
            foreach ($cb in $childBlocks) {
                $cb.Parent = $b
            }

            # passing the array as a whole to cross the function boundary as few times as I can
            PostProcess-DiscoveredBlock -Block $childBlocks -Filter $Filter -BlockContainer $BlockContainer -RootBlock $RootBlock

            $childBlocksToRun = foreach ($cb in $childBlocks) { if ($cb.ShouldRun) { $cb } }
            $anyChildBlockShouldRun = $childBlocksToRun -and 0 -ne $childBlocksToRun.Count
            if ($anyChildBlockShouldRun) {
                $childBlocksToRun[0].First = $true
                $childBlocksToRun[-1].Last = $true
            }

            foreach ($cb in $childBlocksToRun) {
                if (-not $cb.Skip) {
                    $allChildBlockSkipped = $false
                    break
                }
            }
        }

        $shouldRunBasedOnChildren = $blockShouldRun -or $anyChildBlockShouldRun
        $shouldSkipBasedOnChildren = $allTestsSkipped -and $allChildBlockSkipped

        if ($b.ShouldRun -and -not $shouldRunBasedOnChildren) {
            if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                Write-PesterDebugMessage -Scope Filter "($($b.Path -join '.')) Block was marked as Should run based on filters, but none of its tests or tests in children blocks were marked as should run. So the block won't run."
            }
        }

        $b.ShouldRun = $shouldRunBasedOnChildren

        if ($b.ShouldRun) {
            if (-not $b.Skip -and $shouldSkipBasedOnChildren) {
                if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                    if ($b.IsRoot) {
                        Write-PesterDebugMessage -Scope Skip "($($b.BlockContainer)) Container will be skipped because all included children are marked as skipped."
                    } else {
                        Write-PesterDebugMessage -Scope Skip "($($b.Path -join '.')) Block will be skipped because all included children are marked as skipped."
                    }
                }
                $b.Skip = $true
            } elseif ($b.Skip -and -not $shouldSkipBasedOnChildren) {
                if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                    Write-PesterDebugMessage -Scope Skip "($($b.Path -join '.')) Block was marked as skipped, but one or more children are explicitly requested to be run, so the block itself will not be skipped."
                }
                # This is done to execute setup and teardown before explicitly included tests, e.g. using line filter
                # Remaining children have already inherited block-level Skip earlier in this function as expected
                $b.Skip = $false
            }
        }
    }
}

function PostProcess-ExecutedBlock {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        $Block
    )


    # traverses the block structure after a block was executed and
    # and sets the failures correctly so the aggreagatted failures
    # propagate towards the root so if a child test fails it's block
    # aggregated result should be marked as failed

    process {
        foreach ($b in $Block) {
            $thisBlockFailed = -not $b.OwnPassed

            $b.OwnTotalCount = 0
            $b.OwnFailedCount = 0
            $b.OwnPassedCount = 0
            $b.OwnSkippedCount = 0
            $b.OwnInconclusiveCount = 0
            $b.OwnNotRunCount = 0

            $testDuration = [TimeSpan]::Zero

            foreach ($t in $b.Tests) {
                $testDuration += $t.Duration

                $b.OwnTotalCount++
                if (-not $t.ShouldRun) {
                    $b.OwnNotRunCount++
                }
                elseif ($t.ShouldRun -and $t.Inconclusive) {
                    $b.OwnInconclusiveCount++
                }
                elseif ($t.ShouldRun -and $t.Skipped) {
                    $b.OwnSkippedCount++
                }
                elseif (($t.Executed -and -not $t.Passed) -or ($t.ShouldRun -and -not $t.Executed)) {
                    # TODO:  this condition works but needs to be revisited. when the parent fails the test is marked as failed, because it should have run but it did not,and but there is no error in the test result, in such case all tests should probably add error or a flag that indicates that the parent failed, or a log or something, but error is probably the best
                    $b.OwnFailedCount++
                }
                elseif ($t.Executed -and $t.Passed) {
                    $b.OwnPassedCount++
                }
                else {
                    throw "Test '$($t.Name)' is in invalid state. $($t | Format-List -Force * | & $SafeCommands['Out-String'])"
                }
            }

            $anyTestFailed = 0 -lt $b.OwnFailedCount

            $childBlocks = $b.Blocks
            $anyChildBlockFailed = $false
            $aggregatedChildDuration = [TimeSpan]::Zero
            if (none $childBlocks) {
                # one thing to consider here is what happens when a block fails, in the current
                # execution model the block can fail when a setup or teardown fails, with failed
                # setup it is easy all the tests in the block are considered failed, with teardown
                # not so much, when all tests pass and the teardown itself fails what should be the result?



                # todo: there are two concepts mixed with the "own", because the duration and the test counts act differently. With the counting we are using own as "the count of the tests in this block", but with duration the "own" means "self", that is how long this block itself has run, without the tests. This information might not be important but this should be cleared up before shipping. Same goes with the relation to failure, ownPassed means that the block itself passed (that is no setup or teardown failed in it), even though the underlying tests might fail.


                $b.OwnDuration = $b.Duration - $testDuration

                $b.Passed = -not ($thisBlockFailed -or $anyTestFailed)

                # we have no child blocks so the own counts are the same as the total counts
                $b.TotalCount = $b.OwnTotalCount
                $b.FailedCount = $b.OwnFailedCount
                $b.PassedCount = $b.OwnPassedCount
                $b.SkippedCount = $b.OwnSkippedCount
                $b.InconclusiveCount = $b.OwnInconclusiveCount
                $b.NotRunCount = $b.OwnNotRunCount
            }
            else {
                # when we have children we first let them process themselves and
                # then we add the results together (the recursion could reach to the parent and add the totals)
                # but that is difficult with the duration, so this way is less error prone
                PostProcess-ExecutedBlock -Block $childBlocks

                foreach ($child in $childBlocks) {
                    # check that no child block failed, the Passed is aggregate failed, so it will be false
                    # when any test fails in the child, or if the block itself fails
                    if ($child.ShouldRun -and -not $child.Passed) {
                        $anyChildBlockFailed = $true
                    }

                    $aggregatedChildDuration += $child.Duration

                    $b.TotalCount += $child.TotalCount
                    $b.PassedCount += $child.PassedCount
                    $b.FailedCount += $child.FailedCount
                    $b.SkippedCount += $child.SkippedCount
                    $b.InconclusiveCount += $child.InconclusiveCount
                    $b.NotRunCount += $child.NotRunCount
                }

                # then we add counts from this block to the counts from the children blocks
                $b.TotalCount += $b.OwnTotalCount
                $b.PassedCount += $b.OwnPassedCount
                $b.FailedCount += $b.OwnFailedCount
                $b.SkippedCount += $b.OwnSkippedCount
                $b.InconclusiveCount += $b.OwnInconclusiveCount
                $b.NotRunCount += $b.OwnNotRunCount

                $b.Passed = -not ($thisBlockFailed -or $anyTestFailed -or $anyChildBlockFailed)
                $b.OwnDuration = $b.Duration - $testDuration - $aggregatedChildDuration
            }
        }
    }
}

function Where-Failed {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        $Block
    )

    $Block | View-Flat | & $SafeCommands['Where-Object'] { $_.ShouldRun -and (-not $_.Executed -or -not $_.Passed) }
}

function View-Flat {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        $Block
    )

    begin {
        $tests = [System.Collections.Generic.List[Object]]@()
    }
    process {
        # TODO: normally I would output to pipeline but in fold there is accumulator and so it does not output
        foreach ($b in $Block) {
            Fold-Container $b -OnTest { param($t) $tests.Add($t) }
        }
    }

    end {
        $tests
    }
}

function flattenBlock ($Block, $Accumulator) {
    $Accumulator.Add($Block)
    if ($Block.Blocks.Count -eq 0) {
        return $Accumulator
    }

    foreach ($bl in $Block.Blocks) {
        flattenBlock -Block $bl -Accumulator $Accumulator
    }
    $Accumulator
}

function New-FilterObject {
    [CmdletBinding()]
    param (
        [String[]] $FullName,
        [String[]] $Tag,
        [String[]] $ExcludeTag,
        [String[]] $Line,
        [String[]] $ExcludeLine
    )

    [PSCustomObject] @{
        FullName    = $FullName
        Tag         = $Tag
        ExcludeTag  = $ExcludeTag
        Line        = $Line
        ExcludeLine = $ExcludeLine
    }
}

function New-PluginObject {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [String] $Name,
        [Hashtable] $Configuration,
        [ScriptBlock] $Start,
        [ScriptBlock] $DiscoveryStart,
        [ScriptBlock] $ContainerDiscoveryStart,
        [ScriptBlock] $BlockDiscoveryStart,
        [ScriptBlock] $TestDiscoveryStart,
        [ScriptBlock] $TestDiscoveryEnd,
        [ScriptBlock] $BlockDiscoveryEnd,
        [ScriptBlock] $ContainerDiscoveryEnd,
        [ScriptBlock] $DiscoveryEnd,
        [ScriptBlock] $RunStart,
        [scriptblock] $ContainerRunStart,
        [ScriptBlock] $OneTimeBlockSetupStart,
        [ScriptBlock] $EachBlockSetupStart,
        [ScriptBlock] $OneTimeTestSetupStart,
        [ScriptBlock] $EachTestSetupStart,
        [ScriptBlock] $EachTestTeardownEnd,
        [ScriptBlock] $OneTimeTestTeardownEnd,
        [ScriptBlock] $EachBlockTeardownEnd,
        [ScriptBlock] $OneTimeBlockTeardownEnd,
        [ScriptBlock] $ContainerRunEnd,
        [ScriptBlock] $RunEnd,
        [ScriptBlock] $End
    )

    [PSCustomObject] @{
        Name                    = $Name
        Configuration           = $Configuration
        Start                   = $Start
        DiscoveryStart          = $DiscoveryStart
        ContainerDiscoveryStart = $ContainerDiscoveryStart
        BlockDiscoveryStart     = $BlockDiscoveryStart
        TestDiscoveryStart      = $TestDiscoveryStart
        TestDiscoveryEnd        = $TestDiscoveryEnd
        BlockDiscoveryEnd       = $BlockDiscoveryEnd
        ContainerDiscoveryEnd   = $ContainerDiscoveryEnd
        DiscoveryEnd            = $DiscoveryEnd
        RunStart                = $RunStart
        ContainerRunStart       = $ContainerRunStart
        OneTimeBlockSetupStart  = $OneTimeBlockSetupStart
        EachBlockSetupStart     = $EachBlockSetupStart
        OneTimeTestSetupStart   = $OneTimeTestSetupStart
        EachTestSetupStart      = $EachTestSetupStart
        EachTestTeardownEnd     = $EachTestTeardownEnd
        OneTimeTestTeardownEnd  = $OneTimeTestTeardownEnd
        EachBlockTeardownEnd    = $EachBlockTeardownEnd
        OneTimeBlockTeardownEnd = $OneTimeBlockTeardownEnd
        ContainerRunEnd         = $ContainerRunEnd
        RunEnd                  = $RunEnd
        End                     = $End
        PSTypeName              = 'Plugin'
    }
}

function Invoke-BlockContainer {
    param (
        [Parameter(Mandatory)]
        $BlockContainer,
        [Parameter(Mandatory = $true)]
        [Management.Automation.SessionState] $SessionState
    )

    if ($null -ne $BlockContainer.Data -and 0 -lt $BlockContainer.Data.Count) {
        foreach ($d in $BlockContainer.Data) {
            switch ($BlockContainer.Type) {
                "ScriptBlock" {
                    Invoke-InNewScriptScope -ScriptBlock { & $BlockContainer.Item @d } -SessionState $SessionState
                }
                "File" { Invoke-File -Path $BlockContainer.Item.PSPath -SessionState $SessionState -Data $d }
                default { throw [System.ArgumentOutOfRangeException]"" }
            }
        }
    }
    else {
        switch ($BlockContainer.Type) {
            "ScriptBlock" {
                Invoke-InNewScriptScope -ScriptBlock { & $BlockContainer.Item } -SessionState $SessionState
            }
            "File" { Invoke-File -Path $BlockContainer.Item.PSPath -SessionState $SessionState }
            default { throw [System.ArgumentOutOfRangeException]"" }
        }
    }
}

function New-BlockContainerObject {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ParameterSetName = 'ScriptBlock')]
        [ScriptBlock] $ScriptBlock,

        [Parameter(Mandatory, ParameterSetName = 'Path')]
        [String] $Path,

        [Parameter(Mandatory, ParameterSetName = 'File')]
        [System.IO.FileInfo] $File,

        [Parameter(Mandatory, ParameterSetName = 'Container')]
        [Pester.ContainerInfo] $Container,

        $Data
    )

    # Data is null or IDictionary, but all IDictionary does not work with ContainsKey()
    # Contains() requires interface-casting for some types, ex. generic dictionary.
    # Instead we're merging to a controlled data structure to have consistent API internally
    # Also works as a shallow clone to avoid leaking default parameter values between containers with same Data
    $ContainerData = @{ }
    if ($Data -is [System.Collections.IDictionary]) {
        Merge-Hashtable -Destination $ContainerData -Source $Data
    }

    $type, $item = switch ($PSCmdlet.ParameterSetName) {
        'ScriptBlock' { 'ScriptBlock', $ScriptBlock }
        'Path' { 'File', (& $SafeCommands['Get-Item'] $Path) }
        'File' { 'File', $File }
        'Container' { $Container.Type, $Container.Item }
        default { throw [System.ArgumentOutOfRangeException]'' }
    }

    $c = [Pester.ContainerInfo]::Create()
    $c.Type = $type
    $c.Item = $item
    $c.Data = $ContainerData
    $c
}

function New-DiscoveredBlockContainerObject {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        $BlockContainer,
        [Parameter(Mandatory)]
        $Block
    )

    [PSCustomObject] @{
        Type   = $BlockContainer.Type
        Item   = $BlockContainer.Item
        # I create a Root block to keep the discovery unaware of containers,
        # but I don't want to publish that root block because it contains properties
        # that do not make sense on container level like Name and Parent,
        # so here we don't want to take the root block but the blocks inside of it
        # and copy the rest of the meaningful properties
        Blocks = $Block.Blocks
    }
}

function Invoke-File {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [String]
        $Path,
        [Parameter(Mandatory = $true)]
        [Management.Automation.SessionState] $SessionState,
        [Collections.IDictionary] $Data = @{}
    )

    $sb = {
        param ($private:p, $private:d)
        . $private:p @d
    }

    # set the original session state to the wrapper scriptblock
    # making it invoke in the caller session state
    # TODO: heat this up if we want to keep the first test running accuately
    $SessionStateInternal = $script:SessionStateInternalProperty.GetValue($SessionState, $null)
    $script:ScriptBlockSessionStateInternalProperty.SetValue($sb, $SessionStateInternal, $null)

    & $sb $Path $Data
}

function Import-Dependency {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        $Dependency,
        # [Parameter(Mandatory=$true)]
        [Management.Automation.SessionState] $SessionState
    )

    if ($Dependency -is [ScriptBlock]) {
        . $Dependency
    }
    else {

        # when importing a file we need to
        # dot source it into the user scope, the path has
        # no bound session state, so simply dot sourcing it would
        # import it into module scope
        # instead we wrap it into a scriptblock that we attach to user
        # scope, and dot source the file, that will import the functions into
        # that script block, and then we dot source it again to import it
        # into the caller scope, effectively defining the functions there
        $sb = {
            param ($p, $private:Remove_Variable)

            . $($p; & $private:Remove_Variable -Scope Local -Name p)
        }

        $flags = [System.Reflection.BindingFlags]'Instance,NonPublic'
        $SessionStateInternal = $SessionState.GetType().GetProperty('Internal', $flags).GetValue($SessionState, $null)

        # attach the original session state to the wrapper scriptblock
        # making it invoke in the caller session state
        $sb.GetType().GetProperty('SessionStateInternal', $flags).SetValue($sb, $SessionStateInternal, $null)

        # dot source the caller bound scriptblock which imports it into user scope
        . $sb $Dependency $SafeCommands['Remove-Variable']
    }
}

function Add-FrameworkDependency {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        $Dependency
    )

    # adds dependency that is dotsourced during discovery & execution
    # this should be rarely needed, but is useful when you wrap Pester pieces
    # into your own functions, and want to have them available during both
    # discovery and execution
    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
        Write-PesterDebugMessage -Scope Runtime "Adding framework dependency '$Dependency'"
    }
    Import-Dependency -Dependency $Dependency -SessionState $SessionState
}

function Add-Dependency {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        $Dependency,
        [Parameter(Mandatory = $true)]
        [Management.Automation.SessionState] $SessionState
    )


    # adds dependency that is dotsourced after discovery and before execution
    if (-not (Is-Discovery)) {
        if ($PesterPreference.Debug.WriteDebugMessages.Value) {
            Write-PesterDebugMessage -Scope Runtime "Adding run-time dependency '$Dependency'"
        }
        Import-Dependency -Dependency $Dependency -SessionState $SessionState
    }
}

function Anywhere {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [ScriptBlock] $ScriptBlock
    )

    # runs piece of code during execution, useful for backwards compatibility
    # when you have stuff laying around inbetween describes and want to run it
    # only during execution and not twice. works the same as Add-Dependency, but I name
    # it differently because this is a bad-practice mitigation tool and should probably
    # write a warning to make you use Before* blocks instead
    if (-not (Is-Discovery)) {
        if ($PesterPreference.Debug.WriteDebugMessages.Value) {
            Write-PesterDebugMessage -Scope Runtime "Invoking free floating piece of code"
        }
        Import-Dependency $ScriptBlock
    }
}

function New-ParametrizedTest () {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [String] $Name,
        [Parameter(Mandatory = $true, Position = 1)]
        [ScriptBlock] $ScriptBlock,
        [int] $StartLine = $MyInvocation.ScriptLineNumber,
        [int] $StartColumn = $MyInvocation.OffsetInLine,
        [String[]] $Tag = @(),
        # do not use [hashtable[]] because that throws away the order if user uses [ordered] hashtable
        [object[]] $Data,
        [Switch] $Focus,
        [Switch] $Skip
    )

    # using the position of It as Id for the the test so we can join multiple testcases together, this should be unique enough because it only needs to be unique for the current block.
    # TODO: Id is used by NUnit2.5 and 3 testresults to group. A better way to solve this?
    $groupId = "${StartLine}:${StartColumn}"
    foreach ($d in $Data) {
        New-Test -GroupId $groupId -Name $Name -Tag $Tag -ScriptBlock $ScriptBlock -StartLine $StartLine -Data $d -Focus:$Focus -Skip:$Skip
    }
}

function Recurse-Up {
    param(
        [Parameter(Mandatory)]
        $InputObject,
        [ScriptBlock] $Action
    )

    $i = $InputObject
    $level = 0
    while ($null -ne $i) {
        &$Action $i

        $level--
        $i = $i.Parent
    }
}

function ConvertTo-HumanTime {
    param ([TimeSpan]$TimeSpan)
    if ($TimeSpan.Ticks -lt [timespan]::TicksPerSecond) {
        "$([int]($TimeSpan.TotalMilliseconds))ms"
    }
    else {
        "$([int]($TimeSpan.TotalSeconds))s"
    }
}

function Invoke-InNewScriptScope ([ScriptBlock] $ScriptBlock, $SessionState) {
    # running in a script file will push a new script scope up the stack in the provided
    # session state. To do this from a module we need to transport the file invocation into the
    # correct session state, and then invoke the file. We can also pass a script block tied
    # to the current module to invoke internal function in the newly pushed script scope.

    $Path = "$PSScriptRoot/Pester.ps1"
    $Data = @{ ScriptBlock = $ScriptBlock }

    $wrapper = {
        param ($private:p, $private:d)
        & $private:p @d
    }

    # set the original session state to the wrapper scriptblock
    $script:SessionStateInternal = $SessionStateInternalProperty.GetValue($SessionState, $null)
    $script:ScriptBlockSessionStateInternalProperty.SetValue($wrapper, $SessionStateInternal, $null)

    . $wrapper $Path $Data
}

function Add-MissingContainerParameters ($RootBlock, $Container, $CallingFunction) {
    # Adds default values for container parameters not provided by the user.
    # Also adds real parameter name as variable in Run-phase when alias was used, just like normal PowerShell will.

    # Using AST to get parameter-names as $PSCmdLet.MyInvocation.MyCommand only works for advanced functions/scripts/cmdlets.
    # No need to filter on parameter sets OR whether default values are set because Powershell adds all parameters (not aliases) as variables
    # with default value or $null if not specified (probably to avoid error caused by inheritance).
    $Ast = switch ($Container.Type) {
        "ScriptBlock" { $container.Item.Ast }
        "File" {
            $externalScriptInfo = $CallingFunction.SessionState.InvokeCommand.GetCommand($Container.Item.PSPath, [System.Management.Automation.CommandTypes]::ExternalScript)
            $externalScriptInfo.ScriptBlock.Ast
        }
        default { throw [System.ArgumentOutOfRangeException]"" }
    }

    if ($null -ne $Ast -and $null -ne $Ast.ParamBlock -and $Ast.ParamBlock.Parameters.Count -gt 0) {
        $parametersToCheck = foreach ($param in $Ast.ParamBlock.Parameters) { $param.Name.VariablePath.UserPath }

        foreach ($param in $parametersToCheck) {
            $v = $CallingFunction.SessionState.PSVariable.Get($param)
            if ((-not $RootBlock.Data.ContainsKey($param)) -and $v) {
                if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                    Write-PesterDebugMessage -Scope Runtime "Container parameter '$param' is undefined, adding to container Data with default value $(Format-Nicely $v.Value)."
                }
                $RootBlock.Data.Add($param, $v.Value)
            }
        }
    }

    $RootBlock.FrameworkData.MissingParametersProcessed = $true
}
# file src\TypeClass.ps1
function Is-Value ($Value) {
    $Value = $($Value)
    $Value -is [ValueType] -or $Value -is [string] -or $value -is [scriptblock]
}

function Is-Collection ($Value) {
    # check for value types and strings explicitly
    # because otherwise it does not work for decimal
    # so let's skip all values we definitely know
    # are not collections
    if ($Value -is [ValueType] -or $Value -is [string]) {
        return $false
    }

    -not [object]::ReferenceEquals($Value, $($Value))
}

function Is-ScriptBlock ($Value) {
    $Value -is [ScriptBlock]
}

function Is-DecimalNumber ($Value) {
    $Value -is [float] -or $Value -is [single] -or $Value -is [double] -or $Value -is [decimal]
}

function Is-Hashtable ($Value) {
    $Value -is [hashtable]
}

function Is-Dictionary ($Value) {
    $Value -is [System.Collections.IDictionary]
}


function Is-Object ($Value) {
    # here we need to approximate that that object is not value
    # or any special category of object, so other checks might
    # need to be added

    -not ($null -eq $Value -or (Is-Value -Value $Value) -or (Is-Collection -Value $Value))
}
# file src\Format.ps1

function Format-Collection ($Value, [switch]$Pretty) {
    $Limit = 10
    $separator = ', '
    if ($Pretty) {
        $separator = ",`n"
    }
    $count = $Value.Count
    $trimmed = $count -gt $Limit

    $formattedCollection = @()
    # Using foreach to support ICollection
    $i = 0
    foreach ($v in $Value) {
        if ($i -eq $Limit) { break }
        $formattedValue = Format-Nicely -Value $v -Pretty:$Pretty
        $formattedCollection += $formattedValue
        $i++
    }

    '@(' + ($formattedCollection -join $separator) + $(if ($trimmed) { ", ...$($count - $limit) more" }) + ')'
}

function Format-Object ($Value, $Property, [switch]$Pretty) {
    if ($null -eq $Property) {
        $Property = $Value.PSObject.Properties | & $SafeCommands['Select-Object'] -ExpandProperty Name
    }
    $valueType = Get-ShortType $Value
    $valueFormatted = ([string]([PSObject]$Value | & $SafeCommands['Select-Object'] -Property $Property))

    if ($Pretty) {
        $margin = "    "
        $valueFormatted = $valueFormatted `
            -replace '^@{', "@{`n$margin" `
            -replace '; ', ";`n$margin" `
            -replace '}$', "`n}" `

    }

    $valueFormatted -replace "^@", $valueType
}

function Format-Null {
    '$null'
}

function Format-String ($Value) {
    if ('' -eq $Value) {
        return '<empty>'
    }

    "'$Value'"
}

function Format-Date ($Value) {
    $Value.ToString('o')
}

function Format-Boolean ($Value) {
    '$' + $Value.ToString().ToLower()
}

function Format-ScriptBlock ($Value) {
    '{' + $Value + '}'
}

function Format-Number ($Value) {
    [string]$Value
}

function Format-Hashtable ($Value) {
    $head = '@{'
    $tail = '}'

    $entries = $Value.Keys | & $SafeCommands['Sort-Object'] | & $SafeCommands['ForEach-Object'] {
        $formattedValue = Format-Nicely $Value.$_
        "$_=$formattedValue" }

    $head + ( $entries -join '; ') + $tail
}

function Format-Dictionary ($Value) {
    $head = 'Dictionary{'
    $tail = '}'

    $entries = $Value.Keys | & $SafeCommands['Sort-Object'] | & $SafeCommands['ForEach-Object'] {
        $formattedValue = Format-Nicely $Value.$_
        "$_=$formattedValue" }

    $head + ( $entries -join '; ') + $tail
}

function Format-Nicely ($Value, [switch]$Pretty) {
    if ($null -eq $Value) {
        return Format-Null -Value $Value
    }

    if ($Value -is [bool]) {
        return Format-Boolean -Value $Value
    }

    if ($Value -is [string]) {
        return Format-String -Value $Value
    }

    if ($Value -is [DateTime]) {
        return Format-Date -Value $Value
    }

    if ($value -is [Type]) {
        return '[' + (Format-Type -Value $Value) + ']'
    }

    if (Is-DecimalNumber -Value $Value) {
        return Format-Number -Value $Value
    }

    if (Is-ScriptBlock -Value $Value) {
        return Format-ScriptBlock -Value $Value
    }

    if (Is-Value -Value $Value) {
        return $Value
    }

    if (Is-Hashtable -Value $Value) {
        # no advanced formatting of objects in the first version, till I balance it
        return [string]$Value
        #return Format-Hashtable -Value $Value
    }

    if (Is-Dictionary -Value $Value) {
        # no advanced formatting of objects in the first version, till I balance it
        return [string]$Value
        #return Format-Dictionary -Value $Value
    }

    if (Is-Collection -Value $Value) {
        return Format-Collection -Value $Value -Pretty:$Pretty
    }

    # no advanced formatting of objects in the first version, till I balance it
    return [string]$Value
    # Format-Object -Value $Value -Property (Get-DisplayProperty $Value) -Pretty:$Pretty
}

function Sort-Property ($InputObject, [string[]]$SignificantProperties, $Limit = 4) {

    $properties = @($InputObject.PSObject.Properties |
            & $SafeCommands['Where-Object'] { $_.Name -notlike "_*" } |
            & $SafeCommands['Select-Object'] -expand Name |
            & $SafeCommands['Sort-Object'])
    $significant = @()
    $rest = @()
    foreach ($p in $properties) {
        if ($significantProperties -contains $p) {
            $significant += $p
        }
        else {
            $rest += $p
        }
    }

    #todo: I am assuming id, name properties, so I am just sorting the selected ones by name.
    (@($significant | & $SafeCommands['Sort-Object']) + $rest) | & $SafeCommands['Select-Object'] -First $Limit

}

function Get-DisplayProperty ($Value) {
    Sort-Property -InputObject $Value -SignificantProperties 'id', 'name'
}

function Get-ShortType ($Value) {
    if ($null -ne $value) {
        $type = Format-Type $Value.GetType()
        # PSCustomObject serializes to the whole type name on normal PS but to
        # just PSCustomObject on PS Core

        $type `
            -replace "^System\." `
            -replace "^Management\.Automation\.PSCustomObject$", "PSObject" `
            -replace "^PSCustomObject$", "PSObject" `
            -replace "^Object\[\]$", "collection" `

    }
    else {
        Format-Type $null
    }
}

function Format-Type ([Type]$Value) {
    if ($null -eq $Value) {
        return '<none>'
    }

    [string]$Value
}

function Join-With ($Items, $Threshold = 2, $Separator = ', ', $LastSeparator = ' and ') {
    if ($null -eq $items -or $items.count -lt $Threshold) {
        $items -join $Separator
    }
    else {
        $c = $items.count
        ($items[0..($c - 2)] -join $Separator) + $LastSeparator + $items[-1]
    }
}

function Join-And ($Items, $Threshold = 2) {
    Join-With -Items $Items -Threshold $Threshold -Separator ', ' -LastSeparator ' and '
}

function Join-Or ($Items, $Threshold = 2) {
    Join-With -Items $Items -Threshold $Threshold -Separator ', ' -LastSeparator ' or '
}

function Add-SpaceToNonEmptyString ([string]$Value) {
    if ($Value) {
        " $Value"
    }
}
# file src\Pester.RSpec.ps1
function Find-File {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [String[]] $Path,
        [String[]] $ExcludePath,
        [Parameter(Mandatory = $true)]
        [string] $Extension
    )

    $files = foreach ($p in $Path) {
        if ([String]::IsNullOrWhiteSpace($p)) {
            continue
        }

        if ((& $script:SafeCommands['Test-Path'] $p)) {
            # This can expand to more than one path when wildcard is used, those paths can be folders or files.
            # We want to avoid expanding to paths that are not matching our filters, but also want to ensure that if
            # user passes in MyTestFile.ps1 without the .Tests.ps1 it will still run.

            # So at this step we look if we expanded the path to more than 1 item and use stricter rules with filtering.
            # Or if the file was just a single file, we won't use stricter filtering for files.

            # This allows us to use wildcards to get all .Tests.ps1 in the folder and all child folders, which is very useful.
            # But prevents a rare scenario where you provide C:\files\*\MyTest.ps1, because in that case only .Tests.ps1 would be included.

            $items = & $SafeCommands['Get-Item'] $p
            $resolvedToMultipleFiles = $null -ne $items -and 1 -lt @($items).Length

            foreach ($item in $items) {
                if ($item.PSIsContainer) {
                    # this is an existing directory search it for tests file
                    & $SafeCommands['Get-ChildItem'] -Recurse -Path $item -Filter "*$Extension" -File
                }
                elseif ("FileSystem" -ne $item.PSProvider.Name) {
                    # item is not a directory and exists but is not a file so we are not interested
                }
                elseif ($resolvedToMultipleFiles) {
                    # item was resolved from a wildcarded path only use it if it has test extension
                    if ($item.FullName -like "*$Extension") {
                        # add unresolved path to have a note of the original path used to resolve this
                        & $SafeCommands['Add-Member'] -Name UnresolvedPath -Type NoteProperty -Value $p -InputObject $item
                        $item
                    }
                }
                else {
                    # this is some file, that was either provided directly, or resolved from wildcarded path as a single item,
                    # we don't care what type of file it is, or if it has test extension (.Tests.ps1) we should try to run it
                    # to allow any file that is provided directly to run
                    if (".ps1" -ne $item.Extension) {
                        & $SafeCommands['Write-Error'] "Script path '$item' is not a ps1 file." -ErrorAction Stop
                    }

                    # add unresolved path to have a note of the original path used to resolve this
                    & $SafeCommands['Add-Member'] -Name UnresolvedPath -Type NoteProperty -Value $p -InputObject $item
                    $item
                }
            }
        }
        else {
            # this is a path that does not exist so let's hope it is
            # a wildcarded path that will resolve to some files
            & $SafeCommands['Get-ChildItem'] -Recurse -Path $p -Filter "*$Extension" -File
        }
    }

    # Deduplicate files if overlapping -Path values
    $uniquePaths = & $SafeCommands['New-Object'] -TypeName 'System.Collections.Generic.HashSet[string]' -ArgumentList (,@($files).Count)
    $uniqueFiles = foreach ($f in $files) { if ($uniquePaths.Add($f.FullName)) { $f } }
    Filter-Excluded -Files $uniqueFiles -ExcludePath $ExcludePath | & $SafeCommands['Where-Object'] { $_ }
}

function Filter-Excluded ($Files, $ExcludePath) {
    if ($null -eq $ExcludePath -or @($ExcludePath).Length -eq 0) {
        return @($Files)
    }

    foreach ($file in @($Files)) {
        # normalize backslashes for cross-platform ease of use
        $p = $file.FullName -replace "/", "\"
        $excluded = $false

        foreach ($exclusion in (@($ExcludePath) -replace "/", "\")) {
            if ($p -like $exclusion) {
                $excluded = $true
                continue
            }
        }

        if (-not $excluded) {
            $file
        }
    }
}

function Add-RSpecTestObjectProperties {
    param ($TestObject)

    # adds properties that are specific to RSpec to the result object
    # this includes figuring out the result
    # formatting the failure message and stacktrace
    $discoveryOnly = $PesterPreference.Run.SkipRun.Value

    $TestObject.Result = if ($TestObject.Skipped) {
        "Skipped"
    }
    elseif ($TestObject.Inconclusive) {
        "Inconclusive"
    }
    elseif ($TestObject.Passed) {
        "Passed"
    }
    elseif (-not $discoveryOnly -and $TestObject.ShouldRun -and (-not $TestObject.Executed -or -not $TestObject.Passed)) {
        "Failed"
    }
    elseif ($discoveryOnly -and 0 -lt $TestObject.ErrorRecord.Count) {
        "Failed"
    }
    else {
        "NotRun"
    }

    foreach ($e in $TestObject.ErrorRecord) {
        $r = ConvertTo-FailureLines $e
        $e.PSObject.Properties.Add([Pester.Factory]::CreateNoteProperty("DisplayErrorMessage", [string]($r.Message -join [Environment]::NewLine)))
        $e.PSObject.Properties.Add([Pester.Factory]::CreateNoteProperty("DisplayStackTrace", [string]($r.Trace -join [Environment]::NewLine)))
    }
}

function Add-RSpecBlockObjectProperties ($BlockObject) {
    foreach ($e in $BlockObject.ErrorRecord) {
        $r = ConvertTo-FailureLines $e
        $e.PSObject.Properties.Add([Pester.Factory]::CreateNoteProperty("DisplayErrorMessage", [string]($r.Message -join [Environment]::NewLine)))
        $e.PSObject.Properties.Add([Pester.Factory]::CreateNoteProperty("DisplayStackTrace", [string]($r.Trace -join [Environment]::NewLine)))
    }
}

function PostProcess-RspecTestRun ($TestRun) {
    $discoveryOnly = $PesterPreference.Run.SkipRun.Value

    Fold-Run $Run -OnTest {
        param($t)

        ## decorate
        # we already added the RSpec properties as part of the plugin

        ### summarize
        $TestRun.Tests.Add($t)

        switch ($t.Result) {
            "NotRun" {
                $null = $TestRun.NotRun.Add($t)
            }
            "Passed" {
                $null = $TestRun.Passed.Add($t)
            }
            "Failed" {
                $null = $TestRun.Failed.Add($t)
            }
            "Skipped" {
                $null = $TestRun.Skipped.Add($t)
            }
            "Inconclusive" {
                $null = $TestRun.Inconclusive.Add($t)
            }
            default { throw "Result $($t.Result) is not supported." }
        }

    } -OnBlock {
        param ($b)

        ## decorate

        # we already processed errors in the plugin step to make the available for reporting

        $b.Result = if ($b.Skip) {
            "Skipped"
        }
        elseif ($b.Passed) {
            "Passed"
        }
        elseif (-not $discoveryOnly -and $b.ShouldRun -and (-not $b.Executed -or -not $b.Passed)) {
            "Failed"
        }
        elseif ($discoveryOnly -and 0 -lt $b.ErrorRecord.Count) {
            "Failed"
        }
        else {
            "NotRun"
        }

        ## summarize

        # a block that has errors would write into failed blocks so we can report them
        # later we can filter this to only report errors from AfterAll
        if (0 -lt $b.ErrorRecord.Count) {
            $TestRun.FailedBlocks.Add($b)
        }

    } -OnContainer {
        param ($b)

        ## decorate

        # here we add result
        $b.result = if ($b.Skip) {
            "Skipped"
        }
        elseif ($b.Passed) {
            "Passed"
        }
        elseif (0 -lt $b.ErrorRecord.Count) {
            "Failed"
        }
        elseif (-not $discoveryOnly -and $b.ShouldRun -and (-not $b.Executed -or -not $b.Passed)) {
            "Failed"
        }
        else {
            "NotRun"
        }

        foreach ($e in $b.ErrorRecord) {
            $r = ConvertTo-FailureLines $e
            $e.PSObject.Properties.Add([Pester.Factory]::CreateNoteProperty("DisplayErrorMessage", [string]($r.Message -join [Environment]::NewLine)))
            $e.PSObject.Properties.Add([Pester.Factory]::CreateNoteProperty("DisplayStackTrace", [string]($r.Trace -join [Environment]::NewLine)))
        }

        ## summarize
        if (0 -lt $b.ErrorRecord.Count) {
            $TestRun.FailedContainers.Add($b)
        }

        $TestRun.Duration += $b.Duration
        $TestRun.UserDuration += $b.UserDuration
        $TestRun.FrameworkDuration += $b.FrameworkDuration
        $TestRun.DiscoveryDuration += $b.DiscoveryDuration
    }

    $TestRun.PassedCount = $TestRun.Passed.Count
    $TestRun.FailedCount = $TestRun.Failed.Count
    $TestRun.SkippedCount = $TestRun.Skipped.Count
    $TestRun.InconclusiveCount = $TestRun.Inconclusive.Count
    $TestRun.NotRunCount = $TestRun.NotRun.Count

    $TestRun.TotalCount = $TestRun.Tests.Count

    $TestRun.FailedBlocksCount = $TestRun.FailedBlocks.Count
    $TestRun.FailedContainersCount = $TestRun.FailedContainers.Count

    $TestRun.Result = if (0 -lt ($TestRun.FailedCount + $TestRun.FailedBlocksCount + $TestRun.FailedContainersCount)) {
        "Failed"
    }
    else {
        "Passed"
    }
}

function Get-RSpecObjectDecoratorPlugin () {
    New-PluginObject -Name "RSpecObjectDecoratorPlugin" `
        -EachTestTeardownEnd {
        param ($Context)

        # TODO: consider moving this into the core if those results are just what we need, but look first at Gherkin and how many of those results are RSpec specific and how many are Gherkin specific
        #TODO: also this is a plugin because it needs to run before the error processing kicks in, this mixes concerns here imho, and needs to be revisited, because the error writing logic is now dependent on this plugin
        Add-RSpecTestObjectProperties $Context.Test
    } -EachBlockTeardownEnd {
        param($Context)
        #TODO: also this is a plugin because it needs to run before the error processing kicks in (to be able to report correctly formatted errors on screen in case teardown failure), this mixes concerns here imho, and needs to be revisited, because the error writing logic is now dependent on this plugin
        Add-RSpecBlockObjectProperties $Context.Block
    }
}

function New-PesterConfiguration {
    <#
    .SYNOPSIS
    Creates a new PesterConfiguration object for advanced configuration of Invoke-Pester.

    .DESCRIPTION
    The New-PesterConfiguration function creates a new PesterConfiguration-object
    to enable advanced configurations for runnings tests using Invoke-Pester.

    Without parameters, the function generates a configuration-object with default
    options. The returned PesterConfiguration-object can be modified to suit your
    requirements.

    Calling New-PesterConfiguration is equivalent to calling [PesterConfiguration]::Default which was used in early versions of Pester 5.

    For a complete list of options, see `Get-Help about_PesterConfiguration` or https://pester.dev/docs/v5/usage/configuration

    .PARAMETER Hashtable
    Override the default values for the options defined in the provided dictionary/hashtable.
    See about_PesterConfiguration help topic or inspect a PesterConfiguration-object to learn about the schema and
    available options.

    .EXAMPLE
    ```powershell
    $config = New-PesterConfiguration
    $config.Run.PassThru = $true

    Invoke-Pester -Configuration $config
    ```

    Creates a default PesterConfiguration-object and changes the Run.PassThru option
    to return the result object after the test run. The configuration object is
    provided to Invoke-Pester to alter the default behaviour.

    .EXAMPLE
    ```powershell
    $MyOptions = @{
        Run = @{ # Run configuration.
            PassThru = $true # Return result object after finishing the test run.
        }
        Filter = @{ # Filter configuration
            Tag = "Core","Integration" # Run only Describe/Context/It-blocks with 'Core' or 'Integration' tags
        }
    }

    $config = New-PesterConfiguration -Hashtable $MyOptions

    Invoke-Pester -Configuration $config
    ```

    A hashtable is created with custom options and passed to the New-PesterConfiguration to merge
    with the default configuration. The options in the hashtable will override the default values.
    The configuration object is then provided to Invoke-Pester to begin the test run using
    the new configuration.

    .LINK
    https://pester.dev/docs/v5/commands/New-PesterConfiguration

    .LINK
    https://pester.dev/docs/v5/usage/Configuration

    .LINK
    https://pester.dev/docs/v5/commands/Invoke-Pester

    .LINK
    about_PesterConfiguration
    #>
    [CmdletBinding()]
    param(
        [System.Collections.IDictionary] $Hashtable
    )

    if ($PSBoundParameters.ContainsKey('Hashtable')) {
        [PesterConfiguration]$Hashtable
    }
    else {
        [PesterConfiguration]::Default
    }
}

function Remove-RSpecNonPublicProperties ($run) {
    # $runProperties = @(
    #     'Configuration'
    #     'Containers'
    #     'ExecutedAt'
    #     'FailedBlocksCount'
    #     'FailedCount'
    #     'NotRunCount'
    #     'PassedCount'
    #     'PSBoundParameters'
    #     'Result'
    #     'SkippedCount'
    #     'TotalCount'
    #     'Duration'
    # )

    # $containerProperties = @(
    #     'Blocks'
    #     'Content'
    #     'ErrorRecord'
    #     'Executed'
    #     'ExecutedAt'
    #     'FailedCount'
    #     'NotRunCount'
    #     'PassedCount'
    #     'Result'
    #     'ShouldRun'
    #     'Skip'
    #     'SkippedCount'
    #     'Duration'
    #     'Type' # needed because of nunit export path expansion
    #     'TotalCount'
    # )

    # $blockProperties = @(
    #     'Blocks'
    #     'ErrorRecord'
    #     'Executed'
    #     'ExecutedAt'
    #     'FailedCount'
    #     'Name'
    #     'NotRunCount'
    #     'PassedCount'
    #     'Path'
    #     'Result'
    #     'ScriptBlock'
    #     'ShouldRun'
    #     'Skip'
    #     'SkippedCount'
    #     'StandardOutput'
    #     'Tag'
    #     'Tests'
    #     'Duration'
    #     'TotalCount'
    # )

    # $testProperties = @(
    #     'Data'
    #     'ErrorRecord'
    #     'Executed'
    #     'ExecutedAt'
    #     'ExpandedName'
    #     'Id' # needed because of grouping of data driven tests in nunit export
    #     'Name'
    #     'Path'
    #     'Result'
    #     'ScriptBlock'
    #     'ShouldRun'
    #     'Skip'
    #     'Skipped'
    #     'StandardOutput'
    #     'Tag'
    #     'Duration'
    # )

    Fold-Run $run -OnRun {
        param($i)
        # $ps = $i.PsObject.Properties.Name
        # foreach ($p in $ps) {
        #     if ($p -like 'Plugin*') {
        #         $i.PsObject.Properties.Remove($p)
        #     }
        # }

        $i.PluginConfiguration = $null
        $i.PluginData = $null
        $i.Plugins = $null

    } -OnContainer {
        param($i)
        # $ps = $i.PsObject.Properties.Name
        # foreach ($p in $ps) {
        #     if ($p -like 'Own*') {
        #         $i.PsObject.Properties.Remove($p)
        #     }
        # }

        # $i.FrameworkData = $null
        # $i.PluginConfiguration = $null
        # $i.PluginData = $null
        # $i.Plugins = $null

    } -OnBlock {
        param($i)
        # $ps = $i.PsObject.Properties.Name
        # foreach ($p in $ps) {
        #     if ($p -eq 'FrameworkData' -or $p -like 'Own*' -or $p -like 'Plugin*') {
        #         $i.PsObject.Properties.Remove($p)
        #     }
        # }

        $i.FrameworkData = $null
        $i.PluginData = $null

    } -OnTest {
        param($i)
        # $ps = $i.PsObject.Properties.Name
        # foreach ($p in $ps) {
        #     if ($p -eq 'FrameworkData' -or $p -like 'Plugin*') {
        #         $i.PsObject.Properties.Remove($p)
        #     }
        # }

        $i.FrameworkData = $null
        $i.PluginData = $null
    }
}

function New-PesterContainer {
    <#
    .SYNOPSIS
    Generates ContainerInfo-objects used as for Invoke-Pester -Container

    .DESCRIPTION
    Pester 5 supports running tests files and scriptblocks using parameter-input.
    To use this feature, Invoke-Pester expects one or more ContainerInfo-objects
    created using this function, that specify test containers in the form of paths
    to the test files or scriptblocks containing the tests directly.

    A optional Data-dictionary can be provided to supply the containers with any
    required parameter-values. This is useful in when tests are generated dynamically
    based on parameter-input. This method enables complex test-solutions while being
    able to re-use a lot of test-code.

    .PARAMETER Path
    Specifies one or more paths to files containing tests. The value is a path\file
    name or name pattern. Wildcards are permitted.

    .PARAMETER ScriptBlock
    Specifies one or more scriptblocks containing tests.

    .PARAMETER Data
    Allows a dictionary to be provided with parameter-values that should be used during
    execution of the test containers defined in Path or ScriptBlock.

    .EXAMPLE
    ```powershell
    $container = New-PesterContainer -Path 'CodingStyle.Tests.ps1' -Data @{ File = "Get-Emoji.ps1" }
    Invoke-Pester -Container $container
    ```

    This example runs Pester using a generated ContainerInfo-object referencing a file and
    required parameters that's provided to the test-file during execution.

    .EXAMPLE
    ```powershell
    $sb = {
        Describe 'Testing New-PesterContainer' {
            It 'Useless test' {
                "foo" | Should -Not -Be "bar"
            }
        }
    }
    $container = New-PesterContainer -ScriptBlock $sb
    Invoke-Pester -Container $container
    ```

    This example runs Pester against a scriptblock. New-PesterContainer is used to generate
    the required ContainerInfo-object that enables us to do this directly.

    .LINK
    https://pester.dev/docs/v5/commands/New-PesterContainer

    .LINK
    https://pester.dev/docs/v5/commands/Invoke-Pester

    .LINK
    https://pester.dev/docs/v5/usage/data-driven-tests
    #>
    [CmdletBinding(DefaultParameterSetName = "Path")]
    param(
        [Parameter(Mandatory, ParameterSetName = "Path")]
        [String[]] $Path,

        [Parameter(Mandatory, ParameterSetName = "ScriptBlock")]
        [ScriptBlock[]] $ScriptBlock,

        [Collections.IDictionary[]] $Data
    )

    # it seems that when I don't assign $Data to $dt here the foreach does not always work in 5.1 :/ some voodoo
    $dt = $Data
    # expand to ContainerInfo user can provide multiple sets of data, but ContainerInfo can hold only one
    # to keep the internal logic simple.
    $kind = $PSCmdlet.ParameterSetName
    if ('ScriptBlock' -eq $kind) {
        # the @() is significant here, it will make it iterate even if there are no data
        # which allows scriptblocks without data to run
        foreach ($d in @($dt)) {
            foreach ($sb in $ScriptBlock) {
                New-BlockContainerObject -ScriptBlock $sb -Data $d
            }
        }
    }

    if ("Path" -eq $kind) {
        # resolve the path we are given in the same way we would resolve -Path on Invoke-Pester
        $files = @(Find-File -Path $Path -ExcludePath $PesterPreference.Run.ExcludePath.Value -Extension $PesterPreference.Run.TestExtension.Value)
        foreach ($file in $files) {
            # the @() is significant here, it will make it iterate even if there are no data
            # which allows files without data to run
            foreach ($d in @($dt)) {
                New-BlockContainerObject -File $file -Data $d
            }
        }
    }
}
# file src\Main.ps1
function Assert-ValidAssertionName {
    param([string]$Name)
    if ($Name -notmatch '^\S+$') {
        throw "Assertion name '$name' is invalid, assertion name must be a single word."
    }
}

function Assert-ValidAssertionAlias {
    param([string[]]$Alias)
    if ($Alias -notmatch '^\S+$') {
        throw "Assertion alias '$string' is invalid, assertion alias must be a single word."
    }
}

function Add-ShouldOperator {
    <#
    .SYNOPSIS
    Register a Should Operator with Pester
    .DESCRIPTION
    This function allows you to create custom Should assertions.
    .PARAMETER Name
    The name of the assertion. This will become a Named Parameter of Should.
    .PARAMETER Test
    The test function. The function must return a PSObject with a [Bool]succeeded and a [string]failureMessage property.
    .PARAMETER Alias
    A list of aliases for the Named Parameter.
    .PARAMETER SupportsArrayInput
    Does the test function support the passing an array of values to test.
    .PARAMETER InternalName
    If -Name is different from the actual function name, record the actual function name here.
    Used by Get-ShouldOperator to pull function help.
    .EXAMPLE
    ```powershell
    function BeAwesome($ActualValue, [switch] $Negate) {
        [bool] $succeeded = $ActualValue -eq 'Awesome'
        if ($Negate) { $succeeded = -not $succeeded }

        if (-not $succeeded) {
            if ($Negate) {
                $failureMessage = "{$ActualValue} is Awesome"
            }
            else {
                $failureMessage = "{$ActualValue} is not Awesome"
            }
        }

        return New-Object psobject -Property @{
            Succeeded      = $succeeded
            FailureMessage = $failureMessage
        }
    }

    Add-ShouldOperator -Name BeAwesome `
        -Test $function:BeAwesome `
        -Alias 'BA'

    PS C:\> "bad" | Should -BeAwesome
    {bad} is not Awesome
    ```

    Example of how to create a simple custom assertion that checks if the input string is 'Awesome'
    .LINK
    https://pester.dev/docs/v5/commands/Add-ShouldOperator
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string] $Name,

        [Parameter(Mandatory = $true)]
        [scriptblock] $Test,

        [ValidateNotNullOrEmpty()]
        [AllowEmptyCollection()]
        [string[]] $Alias = @(),

        [Parameter()]
        [string] $InternalName,

        [switch] $SupportsArrayInput
    )

    $entry = & $SafeCommands['New-Object'] psobject -Property @{
        Test               = $Test
        SupportsArrayInput = [bool]$SupportsArrayInput
        Name               = $Name
        Alias              = $Alias
        InternalName       = If ($InternalName) {
            $InternalName
        }
        Else {
            $Name
        }
    }
    if (Test-AssertionOperatorIsDuplicate -Operator $entry) {
        # This is an exact duplicate of an existing assertion operator.
        return
    }

    # https://github.com/pester/Pester/issues/1355 and https://github.com/PowerShell/PowerShell/issues/9372
    if ($script:AssertionOperators.Count -ge 32) {
        throw 'Max number of assertion operators (32) has already been reached. This limitation is due to maximum allowed parameter sets in PowerShell.'
    }

    $namesToCheck = @(
        $Name
        $Alias
    )

    Assert-AssertionOperatorNameIsUnique -Name $namesToCheck

    $script:AssertionOperators[$Name] = $entry

    foreach ($string in $Alias | & $SafeCommands['Where-Object'] { -not ([string]::IsNullOrWhiteSpace($_)) }) {
        Assert-ValidAssertionAlias -Alias $string
        $script:AssertionAliases[$string] = $Name
    }

    Add-AssertionDynamicParameterSet -AssertionEntry $entry
}

function Set-ShouldOperatorHelpMessage {
    <#
    .SYNOPSIS
    Sets the helpmessage for a Should-operator. Used in Should's online help for the switch-parameter.
    .PARAMETER OperatorName
    The name of the assertion/operator.
    .PARAMETER HelpMessage
    Help message for switch-parameter for the operator in Should.
    .NOTES
    Internal function as it's only useful for built-in Should operators/assertion atm. to improve online docs.
    Can be merged into Add-ShouldOperator later if we'd like to make it pulic and include value in Get-ShouldOperator

    https://github.com/pester/Pester/issues/2335
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string] $OperatorName,
        [Parameter(Mandatory = $true, Position = 1)]
        [string] $HelpMessage
    )

    end {
        $OperatorParam = $script:AssertionDynamicParams[$OperatorName]

        if ($null -eq $OperatorParam) {
            throw "Should operator '$OperatorName' is not registered"
        }

        foreach ($attr in $OperatorParam.Attributes) {
            if ($attr -is [System.Management.Automation.ParameterAttribute]) {
                $attr.HelpMessage = $HelpMessage
            }
        }
    }
}

function Test-AssertionOperatorIsDuplicate {
    param (
        [psobject] $Operator
    )

    $existing = $script:AssertionOperators[$Operator.Name]
    if (-not $existing) {
        return $false
    }

    return $Operator.SupportsArrayInput -eq $existing.SupportsArrayInput -and
    $Operator.Test.ToString() -eq $existing.Test.ToString() -and
    -not (& $SafeCommands['Compare-Object'] $Operator.Alias $existing.Alias)
}
function Assert-AssertionOperatorNameIsUnique {
    param (
        [string[]] $Name
    )

    foreach ($string in $name | & $SafeCommands['Where-Object'] { -not ([string]::IsNullOrWhiteSpace($_)) }) {
        Assert-ValidAssertionName -Name $string

        if ($script:AssertionOperators.ContainsKey($string)) {
            throw "Assertion operator name '$string' has been added multiple times."
        }

        if ($script:AssertionAliases.ContainsKey($string)) {
            throw "Assertion operator name '$string' already exists as an alias for operator '$($script:AssertionAliases[$key])'"
        }
    }
}

function Add-AssertionDynamicParameterSet {
    param (
        [object] $AssertionEntry
    )

    ${function:__AssertionTest__} = $AssertionEntry.Test
    $commandInfo = & $SafeCommands['Get-Command'] __AssertionTest__ -CommandType Function
    $metadata = [System.Management.Automation.CommandMetadata]$commandInfo

    $attribute = & $SafeCommands['New-Object'] Management.Automation.ParameterAttribute
    $attribute.ParameterSetName = $AssertionEntry.Name


    $attributeCollection = & $SafeCommands['New-Object'] Collections.ObjectModel.Collection[Attribute]
    $null = $attributeCollection.Add($attribute)
    if (-not ([string]::IsNullOrWhiteSpace($AssertionEntry.Alias))) {
        Assert-ValidAssertionAlias -Alias $AssertionEntry.Alias
        $attribute = & $SafeCommands['New-Object'] System.Management.Automation.AliasAttribute($AssertionEntry.Alias)
        $attributeCollection.Add($attribute)
    }

    # Register assertion
    $dynamic = & $SafeCommands['New-Object'] System.Management.Automation.RuntimeDefinedParameter($AssertionEntry.Name, [switch], $attributeCollection)
    $null = $script:AssertionDynamicParams.Add($AssertionEntry.Name, $dynamic)

    # Register -Not in the assertion's parameter set. Create parameter if not already present (first assertion).
    if ($script:AssertionDynamicParams.ContainsKey('Not')) {
        $dynamic = $script:AssertionDynamicParams['Not']
    }
    else {
        $dynamic = & $SafeCommands['New-Object'] System.Management.Automation.RuntimeDefinedParameter('Not', [switch], (& $SafeCommands['New-Object'] System.Collections.ObjectModel.Collection[Attribute]))
        $null = $script:AssertionDynamicParams.Add('Not', $dynamic)
    }

    $attribute = & $SafeCommands['New-Object'] System.Management.Automation.ParameterAttribute
    $attribute.ParameterSetName = $AssertionEntry.Name
    $attribute.Mandatory = $false
    $attribute.HelpMessage = 'Reverse the assertion'
    $null = $dynamic.Attributes.Add($attribute)

    # Register required parameters in the assertion's parameter set. Create parameter if not already present.
    $i = 1
    foreach ($parameter in $metadata.Parameters.Values) {
        # common parameters that are already defined
        if ($parameter.Name -eq 'ActualValue' -or $parameter.Name -eq 'Not' -or $parameter.Name -eq 'Negate') {
            continue
        }


        if ($script:AssertionOperators.ContainsKey($parameter.Name) -or $script:AssertionAliases.ContainsKey($parameter.Name)) {
            throw "Test block for assertion operator $($AssertionEntry.Name) contains a parameter named $($parameter.Name), which conflicts with another assertion operator's name or alias."
        }

        foreach ($alias in $parameter.Aliases) {
            if ($script:AssertionOperators.ContainsKey($alias) -or $script:AssertionAliases.ContainsKey($alias)) {
                throw "Test block for assertion operator $($AssertionEntry.Name) contains a parameter named $($parameter.Name) with alias $alias, which conflicts with another assertion operator's name or alias."
            }
        }

        if ($script:AssertionDynamicParams.ContainsKey($parameter.Name)) {
            $dynamic = $script:AssertionDynamicParams[$parameter.Name]
        }
        else {
            # We deliberately use a type of [object] here to avoid conflicts between different assertion operators that may use the same parameter name.
            # We also don't bother to try to copy transformation / validation attributes here for the same reason.
            # Because we'll be passing these parameters on to the actual test function later, any errors will come out at that time.

            # few years later: using [object] causes problems with switch params (in my case -PassThru), because then we cannot use them without defining a value
            # so for switches we must prefer the conflicts over type
            if ([switch] -eq $parameter.ParameterType) {
                $type = [switch]
            }
            else {
                $type = [object]
            }

            $dynamic = & $SafeCommands['New-Object'] System.Management.Automation.RuntimeDefinedParameter($parameter.Name, $type, (& $SafeCommands['New-Object'] System.Collections.ObjectModel.Collection[Attribute]))
            $null = $script:AssertionDynamicParams.Add($parameter.Name, $dynamic)
        }

        $attribute = & $SafeCommands['New-Object'] Management.Automation.ParameterAttribute
        $attribute.ParameterSetName = $AssertionEntry.Name
        $attribute.Mandatory = $false
        $attribute.Position = ($i++)
        # Only visible in command reference on https://pester.dev. Remove if/when migrated to external help (markdown as source).
        $attribute.HelpMessage = 'Depends on operator being used. See `Get-ShouldOperator -Name <Operator>` or https://pester.dev/docs/v5/assertions/ for help.'

        $null = $dynamic.Attributes.Add($attribute)
    }
}

function Get-AssertionOperatorEntry([string] $Name) {
    return $script:AssertionOperators[$Name]
}

function Get-AssertionDynamicParams {
    return $script:AssertionDynamicParams
}

function Has-Flag {
    param
    (
        [Parameter(Mandatory = $true)]
        [Pester.OutputTypes]
        $Setting,
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [Pester.OutputTypes]
        $Value
    )

    0 -ne ($Setting -band $Value)
}

function Invoke-Pester {
    <#
    .SYNOPSIS
    Runs Pester tests

    .DESCRIPTION
    The Invoke-Pester function runs Pester tests, including *.Tests.ps1 files and
    Pester tests in PowerShell scripts.

    You can run scripts that include Pester tests just as you would any other
    Windows PowerShell script, including typing the full path at the command line
    and running in a script editing program. Typically, you use Invoke-Pester to run
    all Pester tests in a directory, or to use its many helpful parameters,
    including parameters that generate custom objects or XML files.

    By default, Invoke-Pester runs all *.Tests.ps1 files in the current directory
    and all subdirectories recursively. You can use its parameters to select tests
    by file name, test name, or tag.

    To run Pester tests in scripts that take parameter values, use the Script
    parameter with a hash table value.

    Also, by default, Pester tests write test results to the console host, much like
    Write-Host does, but you can use the Show parameter set to None to suppress the host
    messages, use the PassThru parameter to generate a custom object
    (PSCustomObject) that contains the test results, use the OutputXml and
    OutputFormat parameters to write the test results to an XML file, and use the
    EnableExit parameter to return an exit code that contains the number of failed
    tests.

    You can also use the Strict parameter to fail all pending and skipped tests.
    This feature is ideal for build systems and other processes that require success
    on every test.

    To help with test design, Invoke-Pester includes a CodeCoverage parameter that
    lists commands, classes, functions, and lines of code that did not run during test
    execution and returns the code that ran as a percentage of all tested code.

    Invoke-Pester, and the Pester module that exports it, are products of an
    open-source project hosted on GitHub. To view, comment, or contribute to the
    repository, see https://github.com/Pester.

    .PARAMETER CI
    (Introduced v5)
    Enable Test Results and Exit after Run.

    Replace with ConfigurationProperty
        TestResult.Enabled = $true
        Run.Exit = $true

    Since 5.2.0, this option no longer enables CodeCoverage.
    To also enable CodeCoverage use this configuration option:
        CodeCoverage.Enabled = $true

    .PARAMETER CodeCoverage
    (Deprecated v4)
    Replace with ConfigurationProperty CodeCoverage.Enabled = $true
    Adds a code coverage report to the Pester tests. Takes strings or hash table values.
    A code coverage report lists the lines of code that did and did not run during
    a Pester test. This report does not tell whether code was tested; only whether
    the code ran during the test.
    By default, the code coverage report is written to the host program
    (like Write-Host). When you use the PassThru parameter, the custom object
    that Invoke-Pester returns has an additional CodeCoverage property that contains
    a custom object with detailed results of the code coverage test, including lines
    hit, lines missed, and helpful statistics.
    However, NUnitXml and JUnitXml output (OutputXML, OutputFormat) do not include
    any code coverage information, because it's not supported by the schema.
    Enter the path to the files of code under test (not the test file).
    Wildcard characters are supported. If you omit the path, the default is local
    directory, not the directory specified by the Script parameter. Pester test files
    are by default excluded from code coverage when a directory is provided. When you
    provide a test file directly using string, code coverage will be measured. To include
    tests in code coverage of a directory, use the dictionary syntax and provide
    IncludeTests = $true option, as shown below.
    To run a code coverage test only on selected classes, functions or lines in a script,
    enter a hash table value with the following keys:
    -- Path (P)(mandatory) <string>: Enter one path to the files. Wildcard characters
    are supported, but only one string is permitted.
    -- IncludeTests <bool>: Includes code coverage for Pester test files (*.tests.ps1).
    Default is false.
    One of the following: Class/Function or StartLine/EndLine
    -- Class (C) <string>: Enter the class name. Wildcard characters are
    supported, but only one string is permitted. Default is *.
    -- Function (F) <string>: Enter the function name. Wildcard characters are
    supported, but only one string is permitted. Default is *.
    -or-
    -- StartLine (S): Performs code coverage analysis beginning with the specified
    line. Default is line 1.
    -- EndLine (E): Performs code coverage analysis ending with the specified line.
    Default is the last line of the script.

    .PARAMETER CodeCoverageOutputFile
    (Deprecated v4)
    Replace with ConfigurationProperty CodeCoverage.OutputPath
    The path where Invoke-Pester will save formatted code coverage results file.
    The path must include the location and name of the folder and file name with
    a required extension (usually the xml).
    If this path is not provided, no file will be generated.

    .PARAMETER CodeCoverageOutputFileEncoding
    (Deprecated v4)
    Replace with ConfigurationProperty CodeCoverage.OutputEncoding
    Sets the output encoding of CodeCoverageOutputFileFormat
    Default is utf8

    .PARAMETER CodeCoverageOutputFileFormat
    (Deprecated v4)
    Replace with ConfigurationProperty CodeCoverage.OutputFormat
    The name of a code coverage report file format.
    Default value is: JaCoCo.
    Currently supported formats are:
    - JaCoCo - this XML file format is compatible with Azure Devops, VSTS/TFS

    The ReportGenerator tool can be used to consolidate multiple reports and provide code coverage reporting.
    https://github.com/danielpalme/ReportGenerator

    .PARAMETER Configuration
    [PesterConfiguration] object for Advanced Configuration created using `New-PesterConfiguration`.
    For help on each option see about_PesterConfiguration or inspect the object.

    .PARAMETER Container
    Specifies one or more ContainerInfo-objects that define containers with tests.
    ContainerInfo-objects are generated using New-PesterContainer. Useful for
    scenarios where data-driven test are generated, e.g. parametrized test files.

    .PARAMETER EnableExit
    (Deprecated v4)
    Replace with ConfigurationProperty Run.Exit
    Will cause Invoke-Pester to exit with a exit code equal to the number of failed
    tests once all tests have been run. Use this to "fail" a build when any tests fail.

    .PARAMETER ExcludePath
    (Deprecated v4)
    Replace with ConfigurationProperty Run.ExcludePath

    .PARAMETER ExcludeTagFilter
    (Deprecated v4)
    Replace with ConfigurationProperty Filter.ExcludeTag

    .PARAMETER FullNameFilter
    (Deprecated v4)
    Replace with ConfigurationProperty Filter.FullName

    .PARAMETER Output
    (Deprecated v4)
    Replace with ConfigurationProperty Output.Verbosity
    Supports Diagnostic, Detailed, Normal, Minimal, None

    Default value is: Normal

    .PARAMETER OutputFile
    (Deprecated v4)
    Replace with ConfigurationProperty TestResult.OutputPath
    The path where Invoke-Pester will save formatted test results log file.
    The path must include the location and name of the folder and file name with
    the xml extension.
    If this path is not provided, no log will be generated.

    .PARAMETER OutputFormat
    (Deprecated v4)
    Replace with ConfigurationProperty TestResult.OutputFormat
    The format of output. Currently NUnitXml and JUnitXml is supported.

    .PARAMETER PassThru
    Replace with ConfigurationProperty Run.PassThru
    Returns a custom object (PSCustomObject) that contains the test results.
    By default, Invoke-Pester writes to the host program, not to the output stream (stdout).
    If you try to save the result in a variable, the variable is empty unless you
    use the PassThru parameter.
    To suppress the host output, use the Show parameter set to None.

    .PARAMETER Path
    Aliases Script
    Specifies one or more paths to files containing tests. The value is a path\file
    name or name pattern. Wildcards are permitted.

    .PARAMETER PesterOption
    (Deprecated v4)
    This parameter is ignored in v5, and is only present for backwards compatibility
    when migrating from v4.

    Sets advanced options for the test execution. Enter a PesterOption object,
    such as one that you create by using the New-PesterOption cmdlet, or a hash table
    in which the keys are option names and the values are option values.
    For more information on the options available, see the help for New-PesterOption.

    .PARAMETER Quiet
    (Deprecated v4)
    The parameter Quiet is deprecated since Pester v4.0 and will be deleted
    in the next major version of Pester. Please use the parameter Show
    with value 'None' instead.
    The parameter Quiet suppresses the output that Pester writes to the host program,
    including the result summary and CodeCoverage output.
    This parameter does not affect the PassThru custom object or the XML output that
    is written when you use the Output parameters.

    .PARAMETER Show
    (Deprecated v4)
    Replace with ConfigurationProperty Output.Verbosity
    Customizes the output Pester writes to the screen. Available options are None, Default,
    Passed, Failed, Pending, Skipped, Inconclusive, Describe, Context, Summary, Header, All, Fails.
    The options can be combined to define presets.
    ConfigurationProperty Output.Verbosity supports the following values:
    None
    Minimal
    Normal
    Detailed
    Diagnostic

    Show parameter supports the following parameter values:
    None - (None) to write no output to the screen.
    All - (Detailed) to write all available information (this is default option).
    Default - (Detailed)
    Detailed - (Detailed)
    Fails - (Normal) to write everything except Passed (but including Describes etc.).
    Diagnostic - (Diagnostic)
    Normal - (Normal)
    Minimal - (Minimal)

    A common setting is also Failed, Summary, to write only failed tests and test summary.
    This parameter does not affect the PassThru custom object or the XML output that
    is written when you use the Output parameters.

    .PARAMETER Strict
    (Deprecated v4)
    Makes Pending and Skipped tests to Failed tests. Useful for continuous
    integration where you need to make sure all tests passed.

    .PARAMETER TagFilter
    (Deprecated v4)
    Aliases Tag, Tags
    Replace with ConfigurationProperty Filter.Tag

    .EXAMPLE
    Invoke-Pester

    This command runs all *.Tests.ps1 files in the current directory and its subdirectories.

    .EXAMPLE
    Invoke-Pester -Path .\Util*

    This commands runs all *.Tests.ps1 files in subdirectories with names that begin
    with 'Util' and their subdirectories.

    .EXAMPLE
    ```powershell
    $config = [PesterConfiguration]@{
        Should = @{ # <- Should configuration.
            ErrorAction = 'Continue' # <- Always run all Should-assertions in a test
        }
    }

    Invoke-Pester -Configuration $config
    ```

    This example runs all *.Tests.ps1 files in the current directory and its subdirectories.
    It shows how advanced configuration can be used by casting a hashtable to override
    default settings, in this case to make Pester run all Should-assertions in a test
    even if the first fails.

    .EXAMPLE
    $config = New-PesterConfiguration
    $config.TestResult.Enabled = $true
    Invoke-Pester -Configuration $config

    This example runs all *.Tests.ps1 files in the current directory and its subdirectories.
    It uses advanced configuration to enable testresult-output to file. Access $config.TestResult
    to see other testresult options like  output path and format and their default values.

    .LINK
    https://pester.dev/docs/v5/commands/Invoke-Pester

    .LINK
    https://pester.dev/docs/v5/quick-start
    #>

    # Currently doesn't work. $IgnoreUnsafeCommands filter used in rule as workaround
    # [Diagnostics.CodeAnalysis.SuppressMessageAttribute('Pester.BuildAnalyzerRules\Measure-SafeCommands', 'Remove-Variable', Justification = 'Remove-Variable can't remove "optimized variables" when using "alias" for Remove-Variable.')]
    [CmdletBinding(DefaultParameterSetName = 'Simple')]
    param(
        [Parameter(Position = 0, Mandatory = 0, ParameterSetName = "Simple")]
        [Parameter(Position = 0, Mandatory = 0, ParameterSetName = "Legacy")]  # Legacy set for v4 compatibility during migration - deprecated
        [Alias("Script")] # Legacy set for v4 compatibility during migration - deprecated
        [String[]] $Path = '.',
        [Parameter(ParameterSetName = "Simple")]
        [String[]] $ExcludePath = @(),

        [Parameter(ParameterSetName = "Simple")]
        [Parameter(Position = 4, Mandatory = 0, ParameterSetName = "Legacy")]  # Legacy set for v4 compatibility during migration - deprecated
        [Alias("Tag")] # Legacy set for v4 compatibility during migration - deprecated
        [Alias("Tags")] # Legacy set for v4 compatibility during migration - deprecated
        [string[]] $TagFilter,

        [Parameter(ParameterSetName = "Simple")]
        [Parameter(ParameterSetName = "Legacy")] # Legacy set for v4 compatibility during migration - deprecated
        [string[]] $ExcludeTagFilter,

        [Parameter(Position = 1, Mandatory = 0, ParameterSetName = "Legacy")]  # Legacy set for v4 compatibility during migration - deprecated
        [Parameter(ParameterSetName = "Simple")]
        [Alias("Name")]  # Legacy set for v4 compatibility during migration - deprecated
        [string[]] $FullNameFilter,

        [Parameter(ParameterSetName = "Simple")]
        [Switch] $CI,

        [Parameter(ParameterSetName = "Simple")]
        [ValidateSet("Diagnostic", "Detailed", "Normal", "Minimal", "None")]
        [String] $Output = "Normal",

        [Parameter(ParameterSetName = "Simple")]
        [Parameter(ParameterSetName = "Legacy")] # Legacy set for v4 compatibility during migration - deprecated
        [Switch] $PassThru,

        [Parameter(ParameterSetName = "Simple")]
        [Pester.ContainerInfo[]] $Container,

        [Parameter(ParameterSetName = "Advanced")]
        [PesterConfiguration] $Configuration,

        # rest of the Legacy set
        [Parameter(Position = 2, Mandatory = 0, ParameterSetName = "Legacy")]  # Legacy set for v4 compatibility during migration - deprecated
        [switch]$EnableExit,

        [Parameter(ParameterSetName = "Legacy")] # Legacy set for v4 compatibility during migration - deprecated
        [object[]] $CodeCoverage = @(),

        [Parameter(ParameterSetName = "Legacy")] # Legacy set for v4 compatibility during migration - deprecated
        [string] $CodeCoverageOutputFile,

        [Parameter(ParameterSetName = "Legacy")] # Legacy set for v4 compatibility during migration - deprecated
        [string] $CodeCoverageOutputFileEncoding = 'utf8',

        [Parameter(ParameterSetName = "Legacy")] # Legacy set for v4 compatibility during migration - deprecated
        [ValidateSet('JaCoCo')]
        [String]$CodeCoverageOutputFileFormat = "JaCoCo",

        [Parameter(ParameterSetName = "Legacy")] # Legacy set for v4 compatibility during migration - deprecated
        [Switch]$Strict,

        [Parameter(ParameterSetName = "Legacy")] # Legacy set for v4 compatibility during migration - deprecated
        [string] $OutputFile,

        [Parameter(ParameterSetName = "Legacy")] # Legacy set for v4 compatibility during migration - deprecated
        [ValidateSet('NUnitXml', 'NUnit2.5', 'JUnitXml')]
        [string] $OutputFormat = 'NUnitXml',

        [Parameter(ParameterSetName = "Legacy")] # Legacy set for v4 compatibility during migration - deprecated
        [Switch]$Quiet,

        [Parameter(ParameterSetName = "Legacy")] # Legacy set for v4 compatibility during migration - deprecated
        [object]$PesterOption,

        [Parameter(ParameterSetName = "Legacy")] # Legacy set for v4 compatibility during migration - deprecated
        [Pester.OutputTypes]$Show = 'All'
    )
    begin {
        $start = [DateTime]::Now
        # this will inherit to child scopes and allow Describe / Context to run directly from a file or command line
        $invokedViaInvokePester = $true

        if ($null -eq $state) {
            # Cleanup any leftover mocks from previous runs, but only if we are not running in a nested Pester-run
            # todo: move mock cleanup to BeforeAllBlockContainer when there is any?
            Remove-MockFunctionsAndAliases -SessionState $PSCmdlet.SessionState
        }
        else {
            # this will inherit to child scopes and affect behavior of ex. TestDrive/TestRegistry
            $runningPesterInPester = $true
        }

        # this will inherit to child scopes and allow Pester to run in Pester, not checking if this is
        # already defined because we want a clean state for this Invoke-Pester even if it runs inside another
        # testrun (which calls Invoke-Pester itself)
        $state = New-PesterState

        # store CWD so we can revert any changes at the end
        $initialPWD = $pwd.Path
    }

    end {
        try {
            # populate config from parameters and remove them (variables) so we
            # don't inherit them to child functions by accident
            if ('Simple' -eq $PSCmdlet.ParameterSetName) {
                # dot-sourcing the function to allow removing local variables
                $Configuration = . Convert-PesterSimpleParameterSet -BoundParameters $PSBoundParameters
            }
            elseif ('Legacy' -eq $PSCmdlet.ParameterSetName) {
                & $SafeCommands['Write-Warning'] 'You are using Legacy parameter set that adapts Pester 5 syntax to Pester 4 syntax. This parameter set is deprecated, and does not work 100%. The -Strict and -PesterOption parameters are ignored, and providing advanced configuration to -Path (-Script), and -CodeCoverage via a hash table does not work. Please refer to https://github.com/pester/Pester/releases/tag/5.0.1#legacy-parameter-set for more information.'

                # dot-sourcing the function to allow removing local variables
                $Configuration = . Convert-PesterLegacyParameterSet -BoundParameters $PSBoundParameters
            }

            # maybe -IgnorePesterPreference to avoid using $PesterPreference from the context

            $callerPreference = [PesterConfiguration] $PSCmdlet.SessionState.PSVariable.GetValue("PesterPreference")
            $hasCallerPreference = $null -ne $callerPreference

            # we never want to use and keep the pester preference directly,
            # because then the settings are modified on an object that outlives the
            # invoke-pester run and we leak changes from this run to the next
            # such as filters set in the first run will end up in the next run as well
            #
            # preference is inherited in all subsequent calls in this session state
            # but we still pass it explicitly where practical
            if (-not $hasCallerPreference) {
                if ($PSBoundParameters.ContainsKey('Configuration')) {
                    # Advanced configuration used, merging to get new reference
                    [PesterConfiguration] $PesterPreference = [PesterConfiguration]::Merge([PesterConfiguration]::Default, $Configuration)
                }
                else {
                    [PesterConfiguration] $PesterPreference = $Configuration
                }
            }
            elseif ($hasCallerPreference) {
                [PesterConfiguration] $PesterPreference = [PesterConfiguration]::Merge($callerPreference, $Configuration)
            }

            & $SafeCommands['Get-Variable'] 'Configuration' -Scope Local | Remove-Variable

            # $sessionState = Set-SessionStateHint -PassThru  -Hint "Caller - Captured in Invoke-Pester" -SessionState $PSCmdlet.SessionState
            $sessionState = $PSCmdlet.SessionState

            $pluginConfiguration = @{}
            $pluginData = @{}
            $plugins = [System.Collections.Generic.List[object]]@()

            # Processing Output-configuration before any use of Write-PesterStart and Write-PesterDebugMessage.
            # Write-PesterDebugMessage is used regardless of WriteScreenPlugin.
            Resolve-OutputConfiguration -PesterPreference $PesterPreference

            if ('None' -ne $PesterPreference.Output.Verbosity.Value) {
                $plugins.Add((Get-WriteScreenPlugin -Verbosity $PesterPreference.Output.Verbosity.Value))
            }

            $plugins.Add((
                    # decorator plugin needs to be added after output
                    # because on teardown they will run in opposite order
                    # and that way output can consume the fixed object that decorator
                    # decorated, not nice but works
                    Get-RSpecObjectDecoratorPlugin
                ))

            if ($PesterPreference.TestDrive.Enabled.Value) {
                $plugins.Add((Get-TestDrivePlugin))
            }

            if ($PesterPreference.TestRegistry.Enabled.Value -and "Windows" -eq (GetPesterOs)) {
                $plugins.Add((Get-TestRegistryPlugin))
            }

            $plugins.Add((Get-MockPlugin))
            $plugins.Add((Get-SkipRemainingOnFailurePlugin))

            if ($PesterPreference.CodeCoverage.Enabled.Value) {
                $plugins.Add((Get-CoveragePlugin))
            }

            if ($PesterPreference.TestResult.Enabled.Value) {
                $plugins.Add((Get-TestResultPlugin))
            }

            # this is here to support Pester test runner in VSCode. Don't use it unless you are prepared to get broken in the future. And if you decide to use it, let us know in https://github.com/pester/Pester/issues/2021 so we can warn you about removing this.
            if (defined additionalPlugins) { $plugins.AddRange(@($script:additionalPlugins)) }

            $filter = New-FilterObject `
                -Tag $PesterPreference.Filter.Tag.Value `
                -ExcludeTag $PesterPreference.Filter.ExcludeTag.Value `
                -Line $PesterPreference.Filter.Line.Value `
                -ExcludeLine $PesterPreference.Filter.ExcludeLine.Value `
                -FullName $PesterPreference.Filter.FullName.Value

            $containers = @()
            if (any $PesterPreference.Run.ScriptBlock.Value) {
                $containers += @( $PesterPreference.Run.ScriptBlock.Value | & $SafeCommands['ForEach-Object'] { New-BlockContainerObject -ScriptBlock $_ })
            }

            foreach ($c in $PesterPreference.Run.Container.Value) {
                # Running through New-BlockContainerObject again to avoid modifying original container and it's Data during runtime
                $containers += (New-BlockContainerObject -Container $c -Data $c.Data)
            }

            if ((any $PesterPreference.Run.Path.Value)) {
                if (((none $PesterPreference.Run.ScriptBlock.Value) -and (none $PesterPreference.Run.Container.Value)) -or ('.' -ne $PesterPreference.Run.Path.Value[0])) {
                    #TODO: Skipping the invocation when scriptblock is provided and the default path, later keep path in the default parameter set and remove scriptblock from it, so get-help still shows . as the default value and we can still provide script blocks via an advanced settings parameter
                    # TODO: pass the startup options as context to Start instead of just paths

                    $exclusions = combineNonNull @($PesterPreference.Run.ExcludePath.Value, ($PesterPreference.Run.Container.Value | & $SafeCommands['Where-Object'] { "File" -eq $_.Type } | & $SafeCommands['ForEach-Object'] { $_.Item.FullName }))
                    $containers += @(Find-File -Path $PesterPreference.Run.Path.Value -ExcludePath $exclusions -Extension $PesterPreference.Run.TestExtension.Value | & $SafeCommands['ForEach-Object'] { New-BlockContainerObject -File $_ })
                }
            }

            $steps = $Plugins.Start
            if ($null -ne $steps -and 0 -lt @($steps).Count) {
                Invoke-PluginStep -Plugins $Plugins -Step Start -Context @{
                    Containers               = $containers
                    Configuration            = $pluginConfiguration
                    GlobalPluginData         = $pluginData
                    WriteDebugMessages       = $PesterPreference.Debug.WriteDebugMessages.Value
                    Write_PesterDebugMessage = if ($PesterPreference.Debug.WriteDebugMessages.Value) { $script:SafeCommands['Write-PesterDebugMessage'] }
                } -ThrowOnFailure
            }

            if ((none $containers)) {
                throw "No test files were found and no scriptblocks were provided. Please ensure that you provided at least one path to a *$($PesterPreference.Run.TestExtension.Value) file, or a directory that contains such file.$(if ($null -ne $PesterPreference.Run.ExcludePath.Value -and 0 -lt @($PesterPreference.Run.ExcludePath.Value).Length) {" And that there is at least one file not excluded by ExcludeFile filter '$($PesterPreference.Run.ExcludePath.Value -join "', '")'."}) Or that you provided a ScriptBlock test container."
                return
            }

            $r = Invoke-Test -BlockContainer $containers -Plugin $plugins -PluginConfiguration $pluginConfiguration -PluginData $pluginData -SessionState $sessionState -Filter $filter -Configuration $PesterPreference

            foreach ($c in $r) {
                Fold-Container -Container $c  -OnTest { param($t) Add-RSpecTestObjectProperties $t }
            }

            $run = [Pester.Run]::Create()
            $run.Executed = $true
            $run.ExecutedAt = $start
            $run.PSBoundParameters = $PSBoundParameters
            $run.PluginConfiguration = $pluginConfiguration
            $run.Plugins = $Plugins
            $run.PluginData = $pluginData
            $run.Configuration = $PesterPreference
            $m = $ExecutionContext.SessionState.Module
            $run.Version = if ($m.PrivateData -and $m.PrivateData.PSData -and $m.PrivateData.PSData.PreRelease) {
                "$($m.Version)-$($m.PrivateData.PSData.PreRelease)"
            }
            else {
                $m.Version
            }

            $run.PSVersion = $PSVersionTable.PSVersion
            foreach ($i in @($r)) {
                $run.Containers.Add($i)
            }

            PostProcess-RSpecTestRun -TestRun $run

            $steps = $Plugins.End
            if ($null -ne $steps -and 0 -lt @($steps).Count) {
                Invoke-PluginStep -Plugins $Plugins -Step End -Context @{
                    TestRun          = $run
                    Configuration    = $pluginConfiguration
                    GlobalPluginData = $pluginData
                } -ThrowOnFailure
            }

            if (-not $PesterPreference.Debug.ReturnRawResultObject.Value) {
                Remove-RSPecNonPublicProperties $run
            }

            if ($PesterPreference.Run.PassThru.Value) {
                $run
            }

        }
        catch {
            $formatErrorParams = @{
                Err                 = $_
                StackTraceVerbosity = $PesterPreference.Output.StackTraceVerbosity.Value
            }

            if ($PesterPreference.Output.CIFormat.Value -in 'AzureDevops', 'GithubActions') {
                $errorMessage = (Format-ErrorMessage @formatErrorParams) -split [Environment]::NewLine
                Write-CIErrorToScreen -CIFormat $PesterPreference.Output.CIFormat.Value -CILogLevel $PesterPreference.Output.CILogLevel.Value -Header $errorMessage[0] -Message $errorMessage[1..($errorMessage.Count - 1)]
            }
            else {
                Write-ErrorToScreen @formatErrorParams -Throw:$PesterPreference.Run.Throw.Value
            }

            if ($PesterPreference.Run.Exit.Value) {
                exit -1
            }
        }

        # go back to original CWD
        if ($null -ne $initialPWD) { & $SafeCommands['Set-Location'] -Path $initialPWD }

        # exit with exit code if we fail and even if we succeed, otherwise we could inherit
        # exit code of some other app end exit with it's exit code instead with ours
        $failedCount = $run.FailedCount + $run.FailedBlocksCount + $run.FailedContainersCount
        # always set exit code. This both to:
        # - prevent previous commands failing with non-zero exit code from failing the run
        # - setting the exit code when there were some failed tests, blocks, or containers
        $global:LASTEXITCODE = $failedCount

        if ($PesterPreference.Run.Throw.Value -and 0 -ne $failedCount) {
            $messages = combineNonNull @(
                $(if (0 -lt $run.FailedCount) { "$($run.FailedCount) test$(if (1 -lt $run.FailedCount) { "s" }) failed" })
                $(if (0 -lt $run.FailedBlocksCount) { "$($run.FailedBlocksCount) block$(if (1 -lt $run.FailedBlocksCount) { "s" }) failed" })
                $(if (0 -lt $run.FailedContainersCount) { "$($run.FailedContainersCount) container$(if (1 -lt $run.FailedContainersCount) { "s" }) failed" })
            )
            throw "Pester run failed, because $(Join-And $messages)"
        }

        if ($PesterPreference.Run.Exit.Value -and 0 -ne $failedCount) {
            # exit with the number of failed tests when there are any
            # and the exit preference is set. This will fail the run in CI
            # when any tests failed.
            exit $failedCount
        }
    }
}

function Convert-PesterSimpleParameterSet ($BoundParameters) {
    $Configuration = [PesterConfiguration]::Default

    $migrations = @{
        'Path'             = {
            if ($null -ne $Path) {
                if (@($Path)[0] -is [System.Collections.IDictionary]) {
                    throw 'Passing hashtable configuration to -Path / -Script is currently not supported in Pester 5.0. Please provide just paths, as an array of strings.'
                }

                $Configuration.Run.Path = $Path
            }
        }

        'ExcludePath'      = {
            if ($null -ne $ExcludePath) {
                $Configuration.Run.ExcludePath = $ExcludePath
            }
        }

        'TagFilter'        = {
            if ($null -ne $TagFilter -and 0 -lt @($TagFilter).Count) {
                $Configuration.Filter.Tag = $TagFilter
            }
        }

        'ExcludeTagFilter' = {
            if ($null -ne $ExcludeTagFilter -and 0 -lt @($ExcludeTagFilter).Count) {
                $Configuration.Filter.ExcludeTag = $ExcludeTagFilter
            }
        }

        'FullNameFilter'   = {
            if ($null -ne $FullNameFilter -and 0 -lt @($FullNameFilter).Count) {
                $Configuration.Filter.FullName = $FullNameFilter
            }
        }

        'CI'               = {
            if ($CI) {
                $Configuration.Run.Exit = $true
                $Configuration.TestResult.Enabled = $true
            }
        }

        'Output'           = {
            if ($null -ne $Output) {
                $Configuration.Output.Verbosity = $Output
            }
        }

        'PassThru'         = {
            if ($null -ne $PassThru) {
                $Configuration.Run.PassThru = [bool] $PassThru
            }
        }

        'Container'        = {
            if ($null -ne $Container) {
                $Configuration.Run.Container = $Container
            }
        }
    }

    # Run all applicable migrations and remove variable to avoid leaking into child scopes
    foreach ($key in $migrations.Keys) {
        if ($BoundParameters.ContainsKey($key)) {
            . $migrations[$key]
            & $SafeCommands['Get-Variable'] -Name $key -Scope Local | Remove-Variable
        }
    }

    return $Configuration
}

function Convert-PesterLegacyParameterSet ($BoundParameters) {
    $Configuration = [PesterConfiguration]::Default

    $migrations = @{
        'Path'                           = {
            if ($null -ne $Path) {
                $Configuration.Run.Path = $Path
            }
        }

        'FullNameFilter'                 = {
            if ($null -ne $FullNameFilter -and 0 -lt @($FullNameFilter).Count) {
                $Configuration.Filter.FullName = $FullNameFilter
            }
        }

        'EnableExit'                     = {
            if ($EnableExit) {
                $Configuration.Run.Exit = $true
            }
        }

        'TagFilter'                      = {
            if ($null -ne $TagFilter -and 0 -lt @($TagFilter).Count) {
                $Configuration.Filter.Tag = $TagFilter
            }
        }

        'ExcludeTagFilter'               = {
            if ($null -ne $ExcludeTagFilter -and 0 -lt @($ExcludeTagFilter).Count) {
                $Configuration.Filter.ExcludeTag = $ExcludeTagFilter
            }
        }

        'PassThru'                       = {
            if ($null -ne $PassThru) {
                $Configuration.Run.PassThru = [bool] $PassThru
            }
        }

        'CodeCoverage'                   = {
            # advanced CC options won't work (hashtable)
            if ($null -ne $CodeCoverage) {
                $Configuration.CodeCoverage.Enabled = $true
                $Configuration.CodeCoverage.Path = $CodeCoverage
            }
        }

        'CodeCoverageOutputFile'         = {
            if ($null -ne $CodeCoverageOutputFile) {
                $Configuration.CodeCoverage.Enabled = $true
                $Configuration.CodeCoverage.OutputPath = $CodeCoverageOutputFile
            }
        }

        'CodeCoverageOutputFileEncoding' = {
            if ($null -ne $CodeCoverageOutputFileEncoding) {
                $Configuration.CodeCoverage.Enabled = $true
                $Configuration.CodeCoverage.OutputEncoding = $CodeCoverageOutputFileEncoding
            }
        }

        'CodeCoverageOutputFileFormat'   = {
            if ($null -ne $CodeCoverageOutputFileFormat) {
                $Configuration.CodeCoverage.Enabled = $true
                $Configuration.CodeCoverage.OutputFormat = $CodeCoverageOutputFileFormat
            }
        }

        'OutputFile'                     = {
            if ($null -ne $OutputFile -and 0 -lt @($OutputFile).Count) {
                $Configuration.TestResult.Enabled = $true
                $Configuration.TestResult.OutputPath = $OutputFile
            }
        }

        'OutputFormat'                   = {
            if ($null -ne $OutputFormat -and 0 -lt @($OutputFormat).Count) {
                $Configuration.TestResult.OutputFormat = $OutputFormat
            }
        }

        'Show'                           = {
            if ($null -ne $Show) {
                # most used v4 options are adapted, and it also takes v5 options to be able to migrate gradually
                # without switching the whole param set just to get Diagnostic output
                # {None | Default | Passed | Failed | Pending | Skipped | Inconclusive | Describe | Context | Summary | Header | Fails | All}
                $verbosity = switch ($Show) {
                    'All' { 'Detailed' }
                    'Default' { 'Detailed' }
                    'Fails' { 'Normal' }
                    'Diagnostic' { 'Diagnostic' }
                    'Detailed' { 'Detailed' }
                    'Normal' { 'Normal' }
                    'Minimal' { 'Minimal' }
                    'None' { 'None' }
                    default { 'Detailed' }
                }

                $Configuration.Output.Verbosity = $verbosity
            }
        }

        'Quiet'                          = {
            if ($null -ne $Quiet) {
                if ($Quiet) {
                    $Configuration.Output.Verbosity = 'None'
                }
            }
        }
    }

    # Run all applicable migrations and remove variable to avoid leaking into child scopes
    foreach ($key in $migrations.Keys) {
        if ($BoundParameters.ContainsKey($key)) {
            . $migrations[$key]
            & $SafeCommands['Get-Variable'] -Name $key -Scope Local | Remove-Variable
        }
    }

    # Remove auto null-variables for undefined parameters in set
    # TODO: Why are these special? Only removed when not defined, but they're never used. Other are only removed when expliclity set
    if (-not $BoundParameters.ContainsKey('Strict')) {
        & $SafeCommands['Get-Variable'] 'Strict' -Scope Local | Remove-Variable
    }

    if (-not $BoundParameters.ContainsKey('PesterOption')) {
        & $SafeCommands['Get-Variable'] 'PesterOption' -Scope Local | Remove-Variable
    }

    return $Configuration
}

function New-PesterOption {
    #TODO: move those options, right now I am just not exposing this function and added the testSuiteName
    <#
    .SYNOPSIS
    Creates an object that contains advanced options for Invoke-Pester
    .DESCRIPTION
    By using New-PesterOption you can set options what allow easier integration with external applications or
    modifies output generated by Invoke-Pester.
    The result of New-PesterOption need to be assigned to the parameter 'PesterOption' of the Invoke-Pester function.
    .PARAMETER IncludeVSCodeMarker
    When this switch is set, an extra line of output will be written to the console for test failures, making it easier
    for VSCode's parser to provide highlighting / tooltips on the line where the error occurred.
    .PARAMETER TestSuiteName
    When generating NUnit XML output, this controls the name assigned to the root "test-suite" element.  Defaults to "Pester".
    .PARAMETER ScriptBlockFilter
    Filters scriptblock based on the path and line number. This is intended for integration with external tools so we don't rely on names (strings) that can have expandable variables in them.
    .PARAMETER Experimental
    Enables experimental features of Pester to be enabled.
    .PARAMETER ShowScopeHints
    EXPERIMENTAL: Enables debugging output for debugging transitions among scopes. (Experimental flag needs to be used to enable this.)

    .INPUTS
    None
    You cannot pipe input to this command.
    .OUTPUTS
    System.Management.Automation.PSObject
    .EXAMPLE
        PS > $Options = New-PesterOption -TestSuiteName "Tests - Set A"

        PS > Invoke-Pester -PesterOption $Options -Outputfile ".\Results-Set-A.xml" -OutputFormat NUnitXML

        The result of commands will be execution of tests and saving results of them in a NUnitMXL file where the root "test-suite"
        will be named "Tests - Set A".
    .LINK
    https://github.com/pester/Pester/wiki/New-PesterOption

    .LINK
    Invoke-Pester
    #>
    [CmdletBinding()]
    param (
        [switch] $IncludeVSCodeMarker,

        [ValidateNotNullOrEmpty()]
        [string] $TestSuiteName = 'Pester',

        [switch] $Experimental,

        [switch] $ShowScopeHints,

        [hashtable[]] $ScriptBlockFilter
    )

    # in PowerShell 2 Add-Member can attach properties only to
    # PSObjects, I could work around this by capturing all instances
    # in checking them during runtime, but that would bring a lot of
    # object management problems - so let's just not allow this in PowerShell 2
    if ($Experimental -and $ShowScopeHints) {
        if ($PSVersionTable.PSVersion.Major -lt 3) {
            throw "Scope hints cannot be used on PowerShell 2 due to limitations of Add-Member."
        }

        $script:DisableScopeHints = $false
    }
    else {
        $script:DisableScopeHints = $true
    }

    return & $script:SafeCommands['New-Object'] psobject -Property @{
        ReadMe              = "New-PesterOption is deprecated and kept only for backwards compatibility when executing Pester v5 using the " +
        "legacy parameter set. When the object is used with Invoke-Pester -PesterOption it will be ignored."
        IncludeVSCodeMarker = [bool] $IncludeVSCodeMarker
        TestSuiteName       = $TestSuiteName
        ShowScopeHints      = $ShowScopeHints
        Experimental        = $Experimental
        ScriptBlockFilter   = $ScriptBlockFilter
    }
}

function ResolveTestScripts {
    param ([object[]] $Path)

    $resolvedScriptInfo = @(
        foreach ($object in $Path) {
            if ($object -is [System.Collections.IDictionary]) {
                $unresolvedPath = Get-DictionaryValueFromFirstKeyFound -Dictionary $object -Key 'Path', 'p'
                $script = Get-DictionaryValueFromFirstKeyFound -Dictionary $object -Key 'Script'
                $arguments = @(Get-DictionaryValueFromFirstKeyFound -Dictionary $object -Key 'Arguments', 'args', 'a')
                $parameters = Get-DictionaryValueFromFirstKeyFound -Dictionary $object -Key 'Parameters', 'params'

                if ($null -eq $Parameters) {
                    $Parameters = @{}
                }

                if ($unresolvedPath -isnot [string] -or $unresolvedPath -notmatch '\S' -and ($script -isnot [string] -or $script -notmatch '\S')) {
                    throw 'When passing hashtables to the -Path parameter, the Path key is mandatory, and must contain a single string.'
                }

                if ($null -ne $parameters -and $parameters -isnot [System.Collections.IDictionary]) {
                    throw 'When passing hashtables to the -Path parameter, the Parameters key (if present) must be assigned an IDictionary object.'
                }
            }
            else {
                $unresolvedPath = [string] $object
                $script = [string] $object
                $arguments = @()
                $parameters = @{}
            }

            if (-not [string]::IsNullOrEmpty($unresolvedPath)) {
                if ($unresolvedPath -notmatch '[\*\?\[\]]' -and
                    (& $script:SafeCommands['Test-Path'] -LiteralPath $unresolvedPath -PathType Leaf) -and
                    (& $script:SafeCommands['Get-Item'] -LiteralPath $unresolvedPath) -is [System.IO.FileInfo]) {
                    $extension = [System.IO.Path]::GetExtension($unresolvedPath)
                    if ($extension -ne '.ps1') {
                        & $script:SafeCommands['Write-Error'] "Script path '$unresolvedPath' is not a ps1 file."
                    }
                    else {
                        & $script:SafeCommands['New-Object'] psobject -Property @{
                            Path       = $unresolvedPath
                            Script     = $null
                            Arguments  = $arguments
                            Parameters = $parameters
                        }
                    }
                }
                else {
                    # World's longest pipeline?

                    & $script:SafeCommands['Resolve-Path'] -Path $unresolvedPath |
                        & $script:SafeCommands['Where-Object'] { $_.Provider.Name -eq 'FileSystem' } |
                        & $script:SafeCommands['Select-Object'] -ExpandProperty ProviderPath |
                        & $script:SafeCommands['Get-ChildItem'] -Include *.Tests.ps1 -Recurse |
                        & $script:SafeCommands['Where-Object'] { -not $_.PSIsContainer } |
                        & $script:SafeCommands['Select-Object'] -ExpandProperty FullName -Unique |
                        & $script:SafeCommands['ForEach-Object'] {
                            & $script:SafeCommands['New-Object'] psobject -Property @{
                                Path       = $_
                                Script     = $null
                                Arguments  = $arguments
                                Parameters = $parameters
                            }
                        }
                }
            }
            elseif (-not [string]::IsNullOrEmpty($script)) {
                & $script:SafeCommands['New-Object'] psobject -Property @{
                    Path       = $null
                    Script     = $script
                    Arguments  = $arguments
                    Parameters = $parameters
                }
            }
        }
    )

    # Here, we have the option of trying to weed out duplicate file paths that also contain identical
    # Parameters / Arguments.  However, we already make sure that each object in $Path didn't produce
    # any duplicate file paths, and if the caller happens to pass in a set of parameters that produce
    # dupes, maybe that's not our problem.  For now, just return what we found.

    $resolvedScriptInfo
}

function Get-DictionaryValueFromFirstKeyFound {
    param ([System.Collections.IDictionary] $Dictionary, [object[]] $Key)

    foreach ($keyToTry in $Key) {
        if ($Dictionary.Contains($keyToTry)) {
            return $Dictionary[$keyToTry]
        }
    }
}

function Set-PesterStatistics($Node) {
    if ($null -eq $Node) {
        $Node = $pester.TestActions
    }

    foreach ($action in $Node.Actions) {
        if ($action.Type -eq 'TestGroup') {
            Set-PesterStatistics -Node $action

            $Node.TotalCount += $action.TotalCount
            $Node.PassedCount += $action.PassedCount
            $Node.FailedCount += $action.FailedCount
            $Node.SkippedCount += $action.SkippedCount
            $Node.PendingCount += $action.PendingCount
            $Node.InconclusiveCount += $action.InconclusiveCount
        }
        elseif ($action.Type -eq 'TestCase') {
            $node.TotalCount++

            switch ($action.Result) {
                Passed {
                    $Node.PassedCount++; break;
                }
                Failed {
                    $Node.FailedCount++; break;
                }
                Skipped {
                    $Node.SkippedCount++; break;
                }
                Pending {
                    $Node.PendingCount++; break;
                }
                Inconclusive {
                    $Node.InconclusiveCount++; break;
                }
            }
        }
    }
}

function Contain-AnyStringLike ($Filter, $Collection) {
    foreach ($item in $Collection) {
        foreach ($value in $Filter) {
            if ($item -like $value) {
                return $true
            }
        }
    }
    return $false
}

function ConvertTo-Pester4Result {
    <#
    .SYNOPSIS
    Converts a Pester 5 result-object to an Pester 4-compatible object

    .DESCRIPTION
    Pester 5 uses a new format for it's result-object compared to previous
    versions of Pester. This function is provided as a way to convert the
    result-object into an object using the previous format. This can be
    useful as a temporary measure to easier migrate to Pester 5 without
    having to redesign complex CI/CD-pipelines.

    .PARAMETER PesterResult
    Result object from a Pester 5-run. This can be retrieved using Invoke-Pester
    -Passthru or by using the Run.PassThru configuration-option.

    .EXAMPLE
    ```powershell
    $pester5Result = Invoke-Pester -Passthru
    $pester4Result = $pester5Result | ConvertTo-Pester4Result
    ```

    This example runs Pester using the Passthru option to retrieve a result-object
    in the Pester 5 format and converts it to a new Pester 4-compatible result-object.

    .LINK
    https://pester.dev/docs/v5/commands/ConvertTo-Pester4Result

    .LINK
    https://pester.dev/docs/v5/commands/Invoke-Pester
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        $PesterResult
    )
    process {
        $legacyResult = [PSCustomObject] @{
            Version           = "4.99.0"
            TagFilter         = $null
            ExcludeTagFilter  = $null
            TestNameFilter    = $null
            ScriptBlockFilter = $null
            TotalCount        = 0
            PassedCount       = 0
            FailedCount       = 0
            SkippedCount      = 0
            PendingCount      = 0
            InconclusiveCount = 0
            Time              = [TimeSpan]::Zero
            TestResult        = [System.Collections.Generic.List[object]]@()
        }
        $filter = $PesterResult.Configuration.Filter
        $legacyResult.TagFilter = if (0 -ne $filter.Tag.Value.Count) { $filter.Tag.Value }
        $legacyResult.ExcludeTagFilter = if (0 -ne $filter.ExcludeTag.Value.Count) { $filter.ExcludeTag.Value }
        $legacyResult.TestNameFilter = if (0 -ne $filter.TestNameFilter.Value.Count) { $filter.TestNameFilter.Value }
        $legacyResult.ScriptBlockFilter = if (0 -ne $filter.ScriptBlockFilter.Value.Count) { $filter.ScriptBlockFilter.Value }

        $sb = {
            param($test)

            if ("NotRun" -eq $test.Result) {
                return
            }

            $result = [PSCustomObject] @{
                Passed                 = "Passed" -eq $test.Result
                Result                 = $test.Result
                Time                   = $test.Duration
                Name                   = $test.Name

                # in the legacy result the top block is considered to be a Describe and any blocks inside of it are
                # considered to be Context and joined by '\'
                Describe               = $test.Path[0]
                Context                = $(if ($test.Path.Count -gt 2) { $test.Path[1..($test.Path.Count - 2)] -join '\' })

                Show                   = $PesterResult.Configuration.Output.Verbosity.Value
                Parameters             = $test.Data
                ParameterizedSuiteName = $test.DisplayName

                FailureMessage         = $(if (any $test.ErrorRecord -and $null -ne $test.ErrorRecord[-1].Exception) { $test.ErrorRecord[-1].DisplayErrorMessage })
                ErrorRecord            = $(if (any $test.ErrorRecord) { $test.ErrorRecord[-1] })
                StackTrace             = $(if (any $test.ErrorRecord) { $test.ErrorRecord[1].DisplayStackTrace })
            }

            $null = $legacyResult.TestResult.Add($result)
        }


        Fold-Run $PesterResult -OnTest $sb -OnBlock {
            param($b)

            if (0 -ne $b.ErrorRecord.Count) {
                & $sb $b
            }
        }

        # the counts here include failed blocks as tests, that's we don't use
        # the normal properties on the result to count

        foreach ($r in $legacyResult.TestResult) {
            switch ($r.Result) {
                "Passed" {
                    $legacyResult.PassedCount++
                }
                "Failed" {
                    $legacyResult.FailedCount++
                }
                "Skipped" {
                    $legacyResult.SkippedCount++
                }
                "Inconclusive" {
                    $legacyResult.InconclusiveCount++
                }
            }
        }
        $legacyResult.TotalCount = $legacyResult.TestResult.Count
        $legacyResult.PendingCount = 0
        $legacyResult.Time = $PesterResult.Duration

        $legacyResult
    }
}

function BeforeDiscovery {
    <#
    .SYNOPSIS
    Runs setup code that is used during Discovery phase.

    .DESCRIPTION
    Runs your code as is, in the place where this function is defined. This is a semantic block to allow you
    to be explicit about code that you need to run during Discovery, instead of just
    putting code directly inside of Describe / Context.

    .PARAMETER ScriptBlock
    The ScriptBlock to run.

    .EXAMPLE
    ```powershell
    BeforeDiscovery {
        $files = Get-ChildItem -Path $PSScriptRoot -Filter '*.ps1' -Recurse
    }

    Describe "File - <_>" -ForEach $files {
        Context "Whitespace" {
            It "There is no extra whitespace following a line" {
                # ...
            }

            It "File ends with an empty line" {
                # ...
            }
        }
    }
    ```

    BeforeDiscovery is used to gather a list of script-files during Discovery-phase to
    dynamically create a Describe-block and tests for each file found.

    .LINK
    https://pester.dev/docs/v5/commands/BeforeDiscovery

    .LINK
    https://pester.dev/docs/v5/usage/data-driven-tests
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ScriptBlock]$ScriptBlock
    )

    if ($ExecutionContext.SessionState.PSVariable.Get('invokedViaInvokePester')) {
        if ($state.CurrentBlock.IsRoot -and -not $state.CurrentBlock.FrameworkData.MissingParametersProcessed) {
            # For undefined parameters in container, add parameter's default value to Data
            Add-MissingContainerParameters -RootBlock $state.CurrentBlock -Container $container -CallingFunction $PSCmdlet
        }

        . $ScriptBlock
    }
    else {
        Invoke-Interactively -CommandUsed 'BeforeDiscovery' -ScriptName $PSCmdlet.MyInvocation.ScriptName -SessionState $PSCmdlet.SessionState -BoundParameters $PSCmdlet.MyInvocation.BoundParameters
    }
}

# Adding Add-ShouldOperator because it used to be an alias in v4, and so when we now import it will take precedence over
# our internal function in v5, so we need a safe way to refer to it
$script:SafeCommands['Add-ShouldOperator'] = & $SafeCommands['Get-Command'] -CommandType Function -Name 'Add-ShouldOperator'
# file src\functions\assertions\Be.ps1
#Be
function Should-Be ($ActualValue, $ExpectedValue, [switch] $Negate, [string] $Because) {
    <#
    .SYNOPSIS
    Compares one object with another for equality
    and throws if the two objects are not the same.

    .EXAMPLE
    $actual = "Actual value"
    $actual | Should -Be "actual value"

    This test will pass. -Be is not case sensitive.
    For a case sensitive assertion, see -BeExactly.

    .EXAMPLE
    $actual = "Actual value"
    $actual | Should -Be "not actual value"

    This test will fail, as the two strings are not identical.
    #>
    [bool] $succeeded = ArraysAreEqual $ActualValue $ExpectedValue

    if ($Negate) {
        $succeeded = -not $succeeded
    }

    $failureMessage = ''

    if ($true -eq $succeeded) { return [Pester.ShouldResult]@{Succeeded = $succeeded } }

    if ($Negate) {
        $failureMessage = NotShouldBeFailureMessage -ActualValue $ActualValue -Expected $ExpectedValue -Because $Because
    }
    else {
        $failureMessage = ShouldBeFailureMessage -ActualValue $ActualValue -Expected $ExpectedValue -Because $Because
    }

    return [Pester.ShouldResult] @{
        Succeeded      = $succeeded
        FailureMessage = $failureMessage
        ExpectResult   = @{
            Actual   = Format-Nicely $ActualValue
            Expected = Format-Nicely $ExpectedValue
            Because  = $Because
        }
    }
}

function ShouldBeFailureMessage($ActualValue, $ExpectedValue, $Because) {
    # This looks odd; it's to unroll single-element arrays so the "-is [string]" expression works properly.
    $ActualValue = $($ActualValue)
    $ExpectedValue = $($ExpectedValue)

    if (-not (($ExpectedValue -is [string]) -and ($ActualValue -is [string]))) {
        return "Expected $(Format-Nicely $ExpectedValue),$(if ($null -ne $Because) { Format-Because $Because }) but got $(Format-Nicely $ActualValue)."
    }
    <#joining the output strings to a single string here, otherwise I get
       Cannot find an overload for "Exception" and the argument count: "4".
       at line: 63 in C:\Users\nohwnd\github\pester\functions\Assertions\Should.ps1

    This is a quickwin solution, doing the join in the Should directly might be better
    way of doing this. But I don't want to mix two problems.
    #>
    (Get-CompareStringMessage -Expected $ExpectedValue -Actual $ActualValue -Because $Because) -join "`n"
}

function NotShouldBeFailureMessage($ActualValue, $ExpectedValue, $Because) {
    return "Expected $(Format-Nicely $ExpectedValue) to be different from the actual value,$(if ($null -ne $Because) { Format-Because $Because }) but got the same value."
}

& $script:SafeCommands['Add-ShouldOperator'] -Name Be `
    -InternalName Should-Be `
    -Test ${function:Should-Be} `
    -Alias 'EQ' `
    -SupportsArrayInput

Set-ShouldOperatorHelpMessage -OperatorName Be `
    -HelpMessage 'Compares one object with another for equality and throws if the two objects are not the same.'

#BeExactly
function Should-BeExactly($ActualValue, $ExpectedValue, $Because) {
    <#
    .SYNOPSIS
    Compares one object with another for equality and throws if the
    two objects are not the same. This comparison is case sensitive.

    .EXAMPLE
    $actual = "Actual value"
    $actual | Should -Be "Actual value"

    This test will pass. The two strings are identical.

    .EXAMPLE
    $actual = "Actual value"
    $actual | Should -Be "actual value"

    This test will fail, as the two strings do not match case sensitivity.
    #>
    [bool] $succeeded = ArraysAreEqual $ActualValue $ExpectedValue -CaseSensitive

    if ($Negate) {
        $succeeded = -not $succeeded
    }

    $failureMessage = ''

    if ($true -eq $succeeded) { return [Pester.ShouldResult]@{Succeeded = $succeeded } }

    if ($Negate) {
        $failureMessage = NotShouldBeExactlyFailureMessage -ActualValue $ActualValue -ExpectedValue $ExpectedValue -Because $Because
    }
    else {
        $failureMessage = ShouldBeExactlyFailureMessage -ActualValue $ActualValue -ExpectedValue $ExpectedValue -Because $Because
    }

    return [Pester.ShouldResult] @{
        Succeeded      = $succeeded
        FailureMessage = $failureMessage
        ExpectResult   = @{
            Actual   = Format-Nicely $ActualValue
            Expected = Format-Nicely $ExpectedValue
            Because  = $Because
        }
    }
}

function ShouldBeExactlyFailureMessage($ActualValue, $ExpectedValue, $Because) {
    # This looks odd; it's to unroll single-element arrays so the "-is [string]" expression works properly.
    $ActualValue = $($ActualValue)
    $ExpectedValue = $($ExpectedValue)

    if (-not (($ExpectedValue -is [string]) -and ($ActualValue -is [string]))) {
        return "Expected exactly $(Format-Nicely $ExpectedValue),$(if ($null -ne $Because) { Format-Because $Because }) but got $(Format-Nicely $ActualValue)."
    }
    <#joining the output strings to a single string here, otherwise I get
       Cannot find an overload for "Exception" and the argument count: "4".
       at line: 63 in C:\Users\nohwnd\github\pester\functions\Assertions\Should.ps1

    This is a quickwin solution, doing the join in the Should directly might be better
    way of doing this. But I don't want to mix two problems.
    #>
    (Get-CompareStringMessage -Expected $ExpectedValue -Actual $ActualValue -CaseSensitive -Because $Because) -join "`n"
}

function NotShouldBeExactlyFailureMessage($ActualValue, $ExpectedValue, $Because) {
    return "Expected $(Format-Nicely $ExpectedValue) to be different from the actual value,$(if ($null -ne $Because) { Format-Because $Because }) but got exactly the same value."
}

& $script:SafeCommands['Add-ShouldOperator'] -Name BeExactly `
    -InternalName       Should-BeExactly `
    -Test               ${function:Should-BeExactly} `
    -Alias              'CEQ' `
    -SupportsArrayInput

Set-ShouldOperatorHelpMessage -OperatorName BeExactly `
    -HelpMessage 'Compares one object with another for equality and throws if the two objects are not the same. This comparison is case sensitive.'

#common functions
function Get-CompareStringMessage {
    param(
        [Parameter(Mandatory = $true)]
        [AllowEmptyString()]
        [String]$ExpectedValue,
        [Parameter(Mandatory = $true)]
        [AllowEmptyString()]
        [String]$Actual,
        [switch]$CaseSensitive,
        $Because,
        # this is here for testing, we normally would fallback to the buffer size
        $MaximumLineLength,
        $ContextLength
    )

    if ($null -eq $MaximumLineLength) {
        # this is how long the line is, check how this is defined on headless / non-interactive client
        $MaximumLineLength = $host.UI.RawUI.BufferSize.Width
    }

    if ($null -eq $ContextLength) {
        # this is how much text we want to see after difference in the excerpt
        $ContextLength = $MaximumLineLength / 7
    }
    $ExpectedValueLength = $ExpectedValue.Length
    $actualLength = $actual.Length
    $maxLength = if ($ExpectedValueLength -gt $actualLength) { $ExpectedValueLength } else { $actualLength }

    $differenceIndex = $null
    for ($i = 0; $i -lt $maxLength -and ($null -eq $differenceIndex); ++$i) {
        $differenceIndex = if ($CaseSensitive -and ($ExpectedValue[$i] -cne $actual[$i])) {
            $i
        }
        elseif ($ExpectedValue[$i] -ne $actual[$i]) {
            $i
        }
    }

    if ($null -ne $differenceIndex) {
        "Expected strings to be the same,$(if ($null -ne $Because) { Format-Because $Because }) but they were different."

        if ($ExpectedValue.Length -ne $actual.Length) {
            "Expected length: $ExpectedValueLength"
            "Actual length:   $actualLength"
            "Strings differ at index $differenceIndex."
        }
        else {
            "String lengths are both $ExpectedValueLength."
            "Strings differ at index $differenceIndex."
        }

        # find the difference in the string with expanded characters, this is the fastest and most foolproof way of
        # getting the updated difference index. we could also inspect the new string and try to find every occurrence
        # of special character before the difference index, but '\n' is valid piece of string
        # or inspect the original string, but then we need to make sure that we look for all the special characters.
        # instead we just compare it again.

        $actualExpanded = Expand-SpecialCharacters -InputObject $actual
        $expectedExpanded = Expand-SpecialCharacters -InputObject $ExpectedValue
        $maxLength = if ($expectedExpanded.Length -gt $actualExpanded.Length) { $expectedExpanded.Length } else { $actualExpanded.Length }
        $differenceIndex = $null
        for ($i = 0; $i -lt $maxLength -and ($null -eq $differenceIndex); ++$i) {
            $differenceIndex = if ($CaseSensitive -and ($expectedExpanded[$i] -cne $actualExpanded[$i])) {
                $i
            }
            elseif ($expectedExpanded[$i] -ne $actualExpanded[$i]) {
                $i
            }
        }

        $ellipsis = "..."
        # we will sorround the output with Expected: '' and But was: '', from which the Expected: '' is longer
        # so subtract that from the maximum line length, to get how much of the line we actually have available
        $sorroundLength = "Expected: ''".Length
        # the deeper we are in the test structure the less space we have on screen because we are adding margin
        # before the output each describe level adds one space + 3 spaces for the test output margin
        $sideOffset = @((Get-CurrentTest).Path).Length + 3
        $availableLineLength = $maximumLineLength - $sorroundLength - $sideOffset

        $expectedExcerpt = Format-AsExcerpt -InputObject $expectedExpanded -DifferenceIndex $differenceIndex -LineLength $availableLineLength -ExcerptMarker $ellipsis -ContextLength $ContextLength

        $actualExcerpt = Format-AsExcerpt -InputObject $actualExpanded -DifferenceIndex $differenceIndex -LineLength $availableLineLength -ExcerptMarker $ellipsis -ContextLength $ContextLength

        "Expected: '{0}'" -f $expectedExcerpt.Line
        "But was:  '{0}'" -f $actualExcerpt.Line
        " " * ($sorroundLength - 1) + '-' * $actualExcerpt.DifferenceIndex + '^'
    }
}

function Format-AsExcerpt {
    param (
        [Parameter(Mandatory = $true)]
        [AllowEmptyString()]
        [string] $InputObject,
        [Parameter(Mandatory = $true)]
        [int] $DifferenceIndex,
        [Parameter(Mandatory = $true)]
        [int] $LineLength,
        [Parameter(Mandatory = $true)]
        [string] $ExcerptMarker,
        [Parameter(Mandatory = $true)]
        [int] $ContextLength
    )

    $markerLength = $ExcerptMarker.Length
    $inputLength = $InputObject.Length
    # e.g. <marker><precontext><diffchar><postcontext><marker> ...precontextXpostcontext...
    $minimumLineLength = $ContextLength + $markerLength + 1 + $markerLength + $ContextLength
    if ($LineLength -lt $minimumLineLength -or $inputLength -le $LineLength ) {
        # the available line length is so short that we can't reasonable work with it. Ignore formatting and just print it as is.
        # User will see output with a lot of line breaks, but they probably expect that with having super narrow window.
        # or when input is shorter than available line length,
        # there won't be any cutting
        return @{
            Line            = $InputObject
            DifferenceIndex = $DifferenceIndex
        }
    }

    # this will make the whole string shorter as diff index gets closer to the end, so it won't use the whole screen
    # but otherwise we would have to share which operations we did on one string and repeat them on the other
    # which would get very complicated. This way it just works.
    # We need to shift to left by 1 diff char, post-context and end marker length
    $shiftToLeft = $DifferenceIndex - ($LineLength - 1 - $ContextLength - $markerLength)

    if ($shiftToLeft -lt 0) {
        # diff index fits on screen
        $shiftToLeft = 0
    }

    $shiftedToLeft = $InputObject.Substring($shiftToLeft, $inputLength - $shiftToLeft)

    if ($shiftedToLeft.Length -lt $inputLength) {
        # we shortened it show cut marker
        $shiftedToLeft = $ExcerptMarker + $shiftedToLeft.Substring($markerLength, $shiftedToLeft.Length - $markerLength)
    }

    if ($shiftedToLeft.Length -gt $LineLength) {
        # we would be out of screen cut end
        $shiftedToLeft = $shiftedToLeft.Substring(0, $LineLength - $markerLength) + $ExcerptMarker
    }

    return @{
        Line            = $shiftedToLeft
        DifferenceIndex = $DifferenceIndex - $shiftToLeft
    }
}



function Expand-SpecialCharacters {
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [AllowEmptyString()]
        [string[]]$InputObject)
    process {
        $InputObject -replace "`n", "\n" -replace "`r", "\r" -replace "`t", "\t" -replace "`0", "\0" -replace "`b", "\b"
    }
}

function ArraysAreEqual {
    param (
        [object[]] $First,
        [object[]] $Second,
        [switch] $CaseSensitive,
        [int] $RecursionDepth = 0,
        [int] $RecursionLimit = 100
    )
    $RecursionDepth++

    if ($RecursionDepth -gt $RecursionLimit) {
        throw "Reached the recursion depth limit of $RecursionLimit when comparing arrays $First and $Second. Is one of your arrays cyclic?"
    }

    # Do not remove the subexpression @() operators in the following two lines; doing so can cause a
    # silly error in PowerShell v3.  (Null Reference exception from the PowerShell engine in a
    # method called CheckAutomationNullInCommandArgumentArray(System.Object[]) ).
    $firstNullOrEmpty = ArrayOrSingleElementIsNullOrEmpty -Array @($First)
    $secondNullOrEmpty = ArrayOrSingleElementIsNullOrEmpty -Array @($Second)

    if ($firstNullOrEmpty -or $secondNullOrEmpty) {
        return $firstNullOrEmpty -and $secondNullOrEmpty
    }

    if ($First.Count -ne $Second.Count) {
        return $false
    }

    for ($i = 0; $i -lt $First.Count; $i++) {
        if ((IsArray $First[$i]) -or (IsArray $Second[$i])) {
            if (-not (ArraysAreEqual -First $First[$i] -Second $Second[$i] -CaseSensitive:$CaseSensitive -RecursionDepth $RecursionDepth -RecursionLimit $RecursionLimit)) {
                return $false
            }
        }
        else {
            if ($CaseSensitive) {
                $comparer = { param($Actual, $Expected) $Expected -ceq $Actual }
            }
            else {
                $comparer = { param($Actual, $Expected) $Expected -eq $Actual }
            }

            if (-not (& $comparer $First[$i] $Second[$i])) {
                return $false
            }
        }
    }

    return $true
}

function ArrayOrSingleElementIsNullOrEmpty {
    param ([object[]] $Array)

    return $null -eq $Array -or $Array.Count -eq 0 -or ($Array.Count -eq 1 -and $null -eq $Array[0])
}

function IsArray {
    param ([object] $InputObject)

    # Changing this could cause infinite recursion in ArraysAreEqual.
    # see https://github.com/pester/Pester/issues/785#issuecomment-322794011
    return $InputObject -is [Array]
}

function ReplaceValueInArray {
    param (
        [object[]] $Array,
        [object] $Value,
        [object] $NewValue
    )

    foreach ($object in $Array) {
        if ($Value -eq $object) {
            $NewValue
        }
        elseif (@($object).Count -gt 1) {
            ReplaceValueInArray -Array @($object) -Value $Value -NewValue $NewValue
        }
        else {
            $object
        }
    }
}
# file src\functions\assertions\BeGreaterThan.ps1
function Should-BeGreaterThan($ActualValue, $ExpectedValue, [switch] $Negate, [string] $Because) {
    <#
    .SYNOPSIS
    Asserts that a number (or other comparable value) is greater than an expected value.
    Uses PowerShell's -gt operator to compare the two values.

    .EXAMPLE
    2 | Should -BeGreaterThan 0

    This test passes, as PowerShell evaluates `2 -gt 0` as true.
    #>
    if ($Negate) {
        return Should-BeLessOrEqual -ActualValue $ActualValue -ExpectedValue $ExpectedValue -Negate:$false -Because $Because
    }

    if ($ActualValue -le $ExpectedValue) {
        return [Pester.ShouldResult] @{
            Succeeded      = $false
            FailureMessage = "Expected the actual value to be greater than $(Format-Nicely $ExpectedValue),$(Format-Because $Because) but got $(Format-Nicely $ActualValue)."
            ExpectResult   = @{
                Actual   = Format-Nicely $ActualValue
                Expected = Format-Nicely $ExpectedValue
                Because  = $Because
            }
        }
    }

    return [Pester.ShouldResult] @{
        Succeeded = $true
    }
}


function Should-BeLessOrEqual($ActualValue, $ExpectedValue, [switch] $Negate, [string] $Because) {
    <#
    .SYNOPSIS
    Asserts that a number (or other comparable value) is lower than, or equal to an expected value.
    Uses PowerShell's -le operator to compare the two values.

    .EXAMPLE
    1 | Should -BeLessOrEqual 10

    This test passes, as PowerShell evaluates `1 -le 10` as true.

    .EXAMPLE
    10 | Should -BeLessOrEqual 10

    This test also passes, as PowerShell evaluates `10 -le 10` as true.
    #>
    if ($Negate) {
        return Should-BeGreaterThan -ActualValue $ActualValue -ExpectedValue $ExpectedValue -Negate:$false -Because $Because
    }

    if ($ActualValue -gt $ExpectedValue) {
        return [Pester.ShouldResult] @{
            Succeeded      = $false
            FailureMessage = "Expected the actual value to be less than or equal to $(Format-Nicely $ExpectedValue),$(Format-Because $Because) but got $(Format-Nicely $ActualValue)."
            ExpectResult   = @{
                Actual   = Format-Nicely $ActualValue
                Expected = Format-Nicely $ExpectedValue
                Because  = $Because
            }
        }
    }

    return [Pester.ShouldResult] @{
        Succeeded = $true
    }
}

& $script:SafeCommands['Add-ShouldOperator'] -Name BeGreaterThan `
    -InternalName Should-BeGreaterThan `
    -Test         ${function:Should-BeGreaterThan} `
    -Alias        'GT'

Set-ShouldOperatorHelpMessage -OperatorName BeGreaterThan `
    -HelpMessage "Asserts that a number (or other comparable value) is greater than an expected value. Uses PowerShell's -gt operator to compare the two values."

& $script:SafeCommands['Add-ShouldOperator'] -Name BeLessOrEqual `
    -InternalName Should-BeLessOrEqual `
    -Test         ${function:Should-BeLessOrEqual} `
    -Alias        'LE'

Set-ShouldOperatorHelpMessage -OperatorName BeLessOrEqual `
    -HelpMessage "Asserts that a number (or other comparable value) is lower than, or equal to an expected value. Uses PowerShell's -le operator to compare the two values."

#keeping tests happy
function ShouldBeGreaterThanFailureMessage() {
}
function NotShouldBeGreaterThanFailureMessage() {
}

function ShouldBeLessOrEqualFailureMessage() {
}
function NotShouldBeLessOrEqualFailureMessage() {
}
# file src\functions\assertions\BeIn.ps1
function Should-BeIn($ActualValue, $ExpectedValue, [switch] $Negate, [string] $Because) {
    <#
    .SYNOPSIS
    Asserts that a collection of values contain a specific value.
    Uses PowerShell's -contains operator to confirm.

    .EXAMPLE
    1 | Should -BeIn @(1,2,3,'a','b','c')

    This test passes, as 1 exists in the provided collection.
    #>
    [bool] $succeeded = $ExpectedValue -contains $ActualValue
    if ($Negate) {
        $succeeded = -not $succeeded
    }

    if (-not $succeeded) {
        if ($Negate) {
            return [Pester.ShouldResult] @{
                Succeeded      = $false
                FailureMessage = "Expected collection $(Format-Nicely $ExpectedValue) to not contain $(Format-Nicely $ActualValue),$(Format-Because $Because) but it was found."
                ExpectResult           = @{
                    Actual   = Format-Nicely $ActualValue
                    Expected = Format-Nicely $ExpectedValue
                    Because  = $Because
                }
            }
        }
        else {
            return [Pester.ShouldResult] @{
                Succeeded      = $false
                FailureMessage = "Expected collection $(Format-Nicely $ExpectedValue) to contain $(Format-Nicely $ActualValue),$(Format-Because $Because) but it was not found."
                ExpectResult           = @{
                    Actual   = Format-Nicely $ActualValue
                    Expected = Format-Nicely $ExpectedValue
                    Because  = $Because
                }
            }
        }
    }

    return [Pester.ShouldResult] @{
        Succeeded = $true
    }
}

& $script:SafeCommands['Add-ShouldOperator'] -Name BeIn `
    -InternalName Should-BeIn `
    -Test         ${function:Should-BeIn}

Set-ShouldOperatorHelpMessage -OperatorName BeIn `
    -HelpMessage "Asserts that a collection of values contain a specific value. Uses PowerShell's -contains operator to confirm."

function ShouldBeInFailureMessage() {
}
function NotShouldBeInFailureMessage() {
}
# file src\functions\assertions\BeLessThan.ps1
function Should-BeLessThan($ActualValue, $ExpectedValue, [switch] $Negate, [string] $Because) {
    <#
    .SYNOPSIS
    Asserts that a number (or other comparable value) is lower than an expected value.
    Uses PowerShell's -lt operator to compare the two values.

    .EXAMPLE
    1 | Should -BeLessThan 10

    This test passes, as PowerShell evaluates `1 -lt 10` as true.
    #>
    if ($Negate) {
        return Should-BeGreaterOrEqual -ActualValue $ActualValue -ExpectedValue $ExpectedValue -Negate:$false -Because $Because
    }

    if ($ActualValue -ge $ExpectedValue) {
        return [Pester.ShouldResult] @{
            Succeeded      = $false
            FailureMessage = "Expected the actual value to be less than $(Format-Nicely $ExpectedValue),$(Format-Because $Because) but got $(Format-Nicely $ActualValue)."
            ExpectResult   = @{
                Actual   = Format-Nicely $ActualValue
                Expected = Format-Nicely $ExpectedValue
                Because  = $Because
            }
        }
    }

    return [Pester.ShouldResult] @{
        Succeeded = $true
    }
}


function Should-BeGreaterOrEqual($ActualValue, $ExpectedValue, [switch] $Negate, [string] $Because) {
    <#
    .SYNOPSIS
    Asserts that a number (or other comparable value) is greater than or equal to an expected value.
    Uses PowerShell's -ge operator to compare the two values.

    .EXAMPLE
    2 | Should -BeGreaterOrEqual 0

    This test passes, as PowerShell evaluates `2 -ge 0` as true.

    .EXAMPLE
    2 | Should -BeGreaterOrEqual 2

    This test also passes, as PowerShell evaluates `2 -ge 2` as true.
    #>
    if ($Negate) {
        return Should-BeLessThan -ActualValue $ActualValue -ExpectedValue $ExpectedValue -Negate:$false -Because $Because
    }

    if ($ActualValue -lt $ExpectedValue) {
        return [Pester.ShouldResult] @{
            Succeeded      = $false
            FailureMessage = "Expected the actual value to be greater than or equal to $(Format-Nicely $ExpectedValue),$(Format-Because $Because) but got $(Format-Nicely $ActualValue)."
            ExpectResult   = @{
                Actual   = Format-Nicely $ActualValue
                Expected = Format-Nicely $ExpectedValue
                Because  = $Because
            }
        }
    }

    return [Pester.ShouldResult] @{
        Succeeded = $true
    }
}

& $script:SafeCommands['Add-ShouldOperator'] -Name BeLessThan `
    -InternalName Should-BeLessThan `
    -Test         ${function:Should-BeLessThan} `
    -Alias        'LT'

Set-ShouldOperatorHelpMessage -OperatorName BeLessThan `
    -HelpMessage "Asserts that a number (or other comparable value) is lower than an expected value. Uses PowerShell's -lt operator to compare the two values."

& $script:SafeCommands['Add-ShouldOperator'] -Name BeGreaterOrEqual `
    -InternalName Should-BeGreaterOrEqual `
    -Test         ${function:Should-BeGreaterOrEqual} `
    -Alias        'GE'

Set-ShouldOperatorHelpMessage -OperatorName BeGreaterOrEqual `
    -HelpMessage "Asserts that a number (or other comparable value) is greater than or equal to an expected value. Uses PowerShell's -ge operator to compare the two values."

#keeping tests happy
function ShouldBeLessThanFailureMessage() {
}
function NotShouldBeLessThanFailureMessage() {
}

function ShouldBeGreaterOrEqualFailureMessage() {
}
function NotShouldBeGreaterOrEqualFailureMessage() {
}
# file src\functions\assertions\BeLike.ps1
function Should-BeLike($ActualValue, $ExpectedValue, [switch] $Negate, [String] $Because) {
    <#
    .SYNOPSIS
    Asserts that the actual value matches a wildcard pattern using PowerShell's -like operator.
    This comparison is not case-sensitive.

    .EXAMPLE
    $actual = "Actual value"
    $actual | Should -BeLike "actual *"

    This test will pass. -BeLike is not case sensitive.
    For a case sensitive assertion, see -BeLikeExactly.

    .EXAMPLE
    $actual = "Actual value"
    $actual | Should -BeLike "not actual *"

    This test will fail, as the first string does not match the expected value.
    #>
    [bool] $succeeded = $ActualValue -like $ExpectedValue
    if ($Negate) {
        $succeeded = -not $succeeded
    }

    if (-not $succeeded) {
        if ($Negate) {
            return [Pester.ShouldResult] @{
                Succeeded      = $false
                FailureMessage = "Expected like wildcard $(Format-Nicely $ExpectedValue) to not match $(Format-Nicely $ActualValue),$(Format-Because $Because) but it did match."
                ExpectResult           = @{
                    Actual   = Format-Nicely $ActualValue
                    Expected = Format-Nicely $ExpectedValue
                    Because  = $Because
                }
            }
        }
        else {
            return [Pester.ShouldResult] @{
                Succeeded      = $false
                FailureMessage = "Expected like wildcard $(Format-Nicely $ExpectedValue) to match $(Format-Nicely $ActualValue),$(Format-Because $Because) but it did not match."
                ExpectResult   = @{
                    Actual   = Format-Nicely $ActualValue
                    Expected = Format-Nicely $ExpectedValue
                    Because  = $Because
                }
            }
        }
    }

    return [Pester.ShouldResult] @{
        Succeeded = $true
    }
}

& $script:SafeCommands['Add-ShouldOperator'] -Name BeLike `
    -InternalName Should-BeLike `
    -Test         ${function:Should-BeLike}

Set-ShouldOperatorHelpMessage -OperatorName BeLike `
    -HelpMessage "Asserts that the actual value matches a wildcard pattern using PowerShell's -like operator. This comparison is not case-sensitive."

function ShouldBeLikeFailureMessage() {
}
function NotShouldBeLikeFailureMessage() {
}
# file src\functions\assertions\BeLikeExactly.ps1
function Should-BeLikeExactly($ActualValue, $ExpectedValue, [switch] $Negate, [String] $Because) {
    <#
    .SYNOPSIS
    Asserts that the actual value matches a wildcard pattern using PowerShell's -like operator.
    This comparison is case-sensitive.

    .EXAMPLE
    $actual = "Actual value"
    $actual | Should -BeLikeExactly "Actual *"

    This test will pass, as the string matches the provided pattern.

    .EXAMPLE
    $actual = "Actual value"
    $actual | Should -BeLikeExactly "actual *"

    This test will fail, as -BeLikeExactly is case-sensitive.
    #>
    [bool] $succeeded = $ActualValue -clike $ExpectedValue
    if ($Negate) {
        $succeeded = -not $succeeded
    }

    if (-not $succeeded) {
        if ($Negate) {
            return [Pester.ShouldResult] @{
                Succeeded      = $false
                FailureMessage = "Expected case sensitive like wildcard $(Format-Nicely $ExpectedValue) to not match $(Format-Nicely $ActualValue),$(Format-Because $Because) but it did match."
                ExpectResult           = @{
                    Actual   = Format-Nicely $ActualValue
                    Expected = Format-Nicely $ExpectedValue
                    Because  = $Because
                }
            }
        }
        else {
            return [Pester.ShouldResult] @{
                Succeeded      = $false
                FailureMessage = "Expected case sensitive like wildcard $(Format-Nicely $ExpectedValue) to match $(Format-Nicely $ActualValue),$(Format-Because $Because) but it did not match."
                ExpectResult           = @{
                    Actual   = Format-Nicely $ActualValue
                    Expected = Format-Nicely $ExpectedValue
                    Because  = $Because
                }
            }
        }
    }

    return [Pester.ShouldResult] @{
        Succeeded = $true
    }
}

& $script:SafeCommands['Add-ShouldOperator'] -Name BeLikeExactly `
    -InternalName Should-BeLikeExactly `
    -Test         ${function:Should-BeLikeExactly}

Set-ShouldOperatorHelpMessage -OperatorName BeLikeExactly `
    -HelpMessage "Asserts that the actual value matches a wildcard pattern using PowerShell's -like operator. This comparison is case-sensitive."

function ShouldBeLikeExactlyFailureMessage() {
}
function NotShouldBeLikeExactlyFailureMessage() {
}
# file src\functions\assertions\BeNullOrEmpty.ps1

function Should-BeNullOrEmpty($ActualValue, [switch] $Negate, [string] $Because) {
    <#
    .SYNOPSIS
    Checks values for null or empty (strings).
    The static [String]::IsNullOrEmpty() method is used to do the comparison.

    .EXAMPLE
    $null | Should -BeNullOrEmpty

    This test will pass. $null is null.

    .EXAMPLE
    $null | Should -Not -BeNullOrEmpty

    This test will fail and throw an error.

    .EXAMPLE
    @() | Should -BeNullOrEmpty

    An empty collection will pass this test.

    .EXAMPLE
    ""  | Should -BeNullOrEmpty

    An empty string will pass this test.
    #>
    if ($null -eq $ActualValue -or $ActualValue.Count -eq 0) {
        $succeeded = $true
    }
    elseif ($ActualValue.Count -eq 1) {
        $expandedValue = $ActualValue[0]
        $singleValue = $true
        if ($expandedValue -is [hashtable]) {
            $succeeded = $expandedValue.Count -eq 0
        }
        else {
            $succeeded = [String]::IsNullOrEmpty($expandedValue)
        }
    }
    else {
        $succeeded = $false
    }

    if ($Negate) {
        $succeeded = -not $succeeded
    }

    $failureMessage = ''

    if ($true -eq $succeeded) { return [Pester.ShouldResult]@{ Succeeded = $succeeded } }

    if ($Negate) {
        $failureMessage = NotShouldBeNullOrEmptyFailureMessage -Because $Because
    }
    else {
        $valueToFormat = if ($singleValue) { $expandedValue } else { $ActualValue }
        $failureMessage = ShouldBeNullOrEmptyFailureMessage -ActualValue $valueToFormat -Because $Because
    }

    $ExpectedValue = if ($Negate) { '$null or empty' } else { 'a value' }

    return [Pester.ShouldResult] @{
        Succeeded      = $succeeded
        FailureMessage = $failureMessage
        ExpectResult   = @{
            Actual   = Format-Nicely $ActualValue
            Expected = Format-Nicely $ExpectedValue
            Because  = $Because
        }
    }
}

function ShouldBeNullOrEmptyFailureMessage($ActualValue, $Because) {
    return "Expected `$null or empty,$(Format-Because $Because) but got $(Format-Nicely $ActualValue)."
}

function NotShouldBeNullOrEmptyFailureMessage ($Because) {
    return "Expected a value,$(Format-Because $Because) but got `$null or empty."
}

& $script:SafeCommands['Add-ShouldOperator'] -Name BeNullOrEmpty `
    -InternalName       Should-BeNullOrEmpty `
    -Test               ${function:Should-BeNullOrEmpty} `
    -SupportsArrayInput

Set-ShouldOperatorHelpMessage -OperatorName BeNullOrEmpty `
    -HelpMessage "Checks values for null or empty (strings). The static [String]::IsNullOrEmpty() method is used to do the comparison."
# file src\functions\assertions\BeOfType.ps1

function Should-BeOfType($ActualValue, $ExpectedType, [switch] $Negate, [string]$Because) {
    <#
    .SYNOPSIS
    Asserts that the actual value should be an object of a specified type
    (or a subclass of the specified type) using PowerShell's -is operator.

    .EXAMPLE
    $actual = Get-Item $env:SystemRoot
    $actual | Should -BeOfType System.IO.DirectoryInfo

    This test passes, as $actual is a DirectoryInfo object.

    .EXAMPLE
    $actual | Should -BeOfType System.IO.FileSystemInfo

    This test passes, as DirectoryInfo's base class is FileSystemInfo.

    .EXAMPLE
    $actual | Should -HaveType System.IO.FileSystemInfo

    This test passes for the same reason, but uses the -HaveType alias instead.

    .EXAMPLE
    $actual | Should -BeOfType System.IO.FileInfo

    This test will fail, as FileInfo is not a base class of DirectoryInfo.
    #>
    if ($ExpectedType -is [string]) {
        # parses type that is provided as a string in brackets (such as [int])
        $trimmedType = $ExpectedType -replace '^\[(.*)\]$', '$1'
        $parsedType = $trimmedType -as [Type]
        if ($null -eq $parsedType) {
            throw [ArgumentException]"Could not find type [$trimmedType]. Make sure that the assembly that contains that type is loaded."
        }

        $ExpectedType = $parsedType
    }

    $succeded = $ActualValue -is $ExpectedType
    if ($Negate) {
        $succeded = -not $succeded
    }

    $failureMessage = ''

    if ($null -ne $ActualValue) {
        $actualType = $ActualValue.GetType()
    }
    else {
        $actualType = $null
    }

    if ($true -eq $succeeded) { return [Pester.ShouldResult]@{Succeeded = $succeeded } }


    if ($Negate) {
        $failureMessage = "Expected the value to not have type $(Format-Nicely $ExpectedType) or any of its subtypes,$(Format-Because $Because) but got $(Format-Nicely $ActualValue) with type $(Format-Nicely $actualType)."
    }
    else {
        $failureMessage = "Expected the value to have type $(Format-Nicely $ExpectedType) or any of its subtypes,$(Format-Because $Because) but got $(Format-Nicely $ActualValue) with type $(Format-Nicely $actualType)."
    }

    $ExpectedValue = if ($Negate) { "not $(Format-Nicely $ExpectedType) or any of its subtypes" } else { "a $(Format-Nicely $ExpectedType) or any of its subtypes" }

    return [Pester.ShouldResult] @{
        Succeeded      = $succeded
        FailureMessage = $failureMessage
        ExpectResult   = @{
            Actual   = Format-Nicely $ActualValue
            Expected = Format-Nicely $ExpectedValue
            Because  = $Because
        }
    }
}


& $script:SafeCommands['Add-ShouldOperator'] -Name BeOfType `
    -InternalName Should-BeOfType `
    -Test         ${function:Should-BeOfType} `
    -Alias        'HaveType'

Set-ShouldOperatorHelpMessage -OperatorName BeOfType `
    -HelpMessage "Asserts that the actual value should be an object of a specified type (or a subclass of the specified type) using PowerShell's -is operator."

function ShouldBeOfTypeFailureMessage() {
}

function NotShouldBeOfTypeFailureMessage() {
}
# file src\functions\assertions\BeTrueOrFalse.ps1
function Should-BeTrue($ActualValue, [switch] $Negate, [string] $Because) {
    <#
    .SYNOPSIS
    Asserts that the value is true, or truthy.

    .EXAMPLE
    $true | Should -BeTrue

    This test passes. $true is true.

    .EXAMPLE
    1 | Should -BeTrue

    This test passes. 1 is true.

    .EXAMPLE
    1,2,3 | Should -BeTrue

    PowerShell does not enter a `If (-not @(1,2,3)) {}` block.
    This test passes as a "truthy" result.
    #>
    if ($Negate) {
        return Should-BeFalse -ActualValue $ActualValue -Negate:$false -Because $Because
    }

    if (-not $ActualValue) {
        $failureMessage = "Expected `$true,$(Format-Because $Because) but got $(Format-Nicely $ActualValue)."
        $ExpectedValue = $true
        return [Pester.ShouldResult] @{
            Succeeded      = $false
            FailureMessage = $failureMessage
            ExpectResult   = @{
                Actual   = Format-Nicely $ActualValue
                Expected = Format-Nicely $ExpectedValue
                Because  = $Because
            }
        }
    }

    return [Pester.ShouldResult] @{
        Succeeded = $true
    }
}

function Should-BeFalse($ActualValue, [switch] $Negate, $Because) {
    <#
    .SYNOPSIS
    Asserts that the value is false, or falsy.

    .EXAMPLE
    $false | Should -BeFalse

    This test passes. $false is false.

    .EXAMPLE
    0 | Should -BeFalse

    This test passes. 0 is false.

    .EXAMPLE
    $null | Should -BeFalse

    PowerShell does not enter a `If ($null) {}` block.
    This test passes as a "falsy" result.
    #>
    if ($Negate) {
        return Should-BeTrue -ActualValue $ActualValue -Negate:$false -Because $Because
    }

    if ($ActualValue) {
        $failureMessage = "Expected `$false,$(Format-Because $Because) but got $(Format-Nicely $ActualValue)."
        $ExpectedValue = $false
        return [Pester.ShouldResult] @{
            Succeeded      = $false
            FailureMessage = $failureMessage
            ExpectResult   = @{
                Actual   = Format-Nicely $ActualValue
                Expected = Format-Nicely $ExpectedValue
                Because  = $Because
            }
        }
    }

    return [Pester.ShouldResult] @{
        Succeeded = $true
    }
}


& $script:SafeCommands['Add-ShouldOperator'] -Name BeTrue `
    -InternalName Should-BeTrue `
    -Test         ${function:Should-BeTrue}

Set-ShouldOperatorHelpMessage -OperatorName BeTrue `
    -HelpMessage "Asserts that the value is true, or truthy."

& $script:SafeCommands['Add-ShouldOperator'] -Name BeFalse `
    -InternalName Should-BeFalse `
    -Test         ${function:Should-BeFalse}

Set-ShouldOperatorHelpMessage -OperatorName BeFalse `
    -HelpMessage "Asserts that the value is false, or falsy."

# to keep tests happy
function ShouldBeTrueFailureMessage($ActualValue) {
}
function NotShouldBeTrueFailureMessage($ActualValue) {
}
function ShouldBeFalseFailureMessage($ActualValue) {
}
function NotShouldBeFalseFailureMessage($ActualValue) {
}
# file src\functions\assertions\Contain.ps1
function Should-Contain($ActualValue, $ExpectedValue, [switch] $Negate, [string] $Because) {
    <#
    .SYNOPSIS
    Asserts that collection contains a specific value.
    Uses PowerShell's -contains operator to confirm.

    .EXAMPLE
    1,2,3 | Should -Contain 1

    This test passes, as 1 exists in the provided collection.
    #>
    [bool] $succeeded = $ActualValue -contains $ExpectedValue
    if ($Negate) {
        $succeeded = -not $succeeded
    }

    if (-not $succeeded) {
        if ($Negate) {
            return [Pester.ShouldResult] @{
                Succeeded      = $false
                FailureMessage = "Expected $(Format-Nicely $ExpectedValue) to not be found in collection $(Format-Nicely $ActualValue),$(Format-Because $Because) but it was found."
                ExpectResult   = @{
                    Actual   = Format-Nicely $ActualValue
                    Expected = Format-Nicely $ExpectedValue
                    Because  = $Because
                }
            }
        }
        else {
            return [Pester.ShouldResult] @{
                Succeeded      = $false
                FailureMessage = "Expected $(Format-Nicely $ExpectedValue) to be found in collection $(Format-Nicely $ActualValue),$(Format-Because $Because) but it was not found."
                ExpectResult   = @{
                    Actual   = Format-Nicely $ActualValue
                    Expected = Format-Nicely $ExpectedValue
                    Because  = $Because
                }
            }
        }
    }

    return [Pester.ShouldResult] @{
        Succeeded = $true
    }
}

& $script:SafeCommands['Add-ShouldOperator'] -Name Contain `
    -InternalName Should-Contain `
    -Test         ${function:Should-Contain} `
    -SupportsArrayInput

Set-ShouldOperatorHelpMessage -OperatorName Contain `
    -HelpMessage "Asserts that collection contains a specific value. Uses PowerShell's -contains operator to confirm."

function ShouldContainFailureMessage() {
}
function NotShouldContainFailureMessage() {
}
# file src\functions\assertions\Exist.ps1
function Should-Exist($ActualValue, [switch] $Negate, [string] $Because) {
    <#
    .SYNOPSIS
    Does not perform any comparison, but checks if the object calling Exist is present in a PS Provider.
    The object must have valid path syntax. It essentially must pass a Test-Path call.

    .EXAMPLE
    $actual = (Dir . )[0].FullName
    Remove-Item $actual
    $actual | Should -Exist

    `Should -Exist` calls Test-Path. Test-Path expects a file,
    returns $false because the file was removed, and fails the test.
    #>
    [bool] $succeeded = & $SafeCommands['Test-Path'] $ActualValue

    if ($Negate) {
        $succeeded = -not $succeeded
    }

    $failureMessage = ''

    if ($true -eq $succeeded) { return [Pester.ShouldResult]@{Succeeded = $succeeded } }

    if ($Negate) {
        $failureMessage = "Expected path $(Format-Nicely $ActualValue) to not exist,$(Format-Because $Because) but it did exist."
    }
    else {
        $failureMessage = "Expected path $(Format-Nicely $ActualValue) to exist,$(Format-Because $Because) but it did not exist."
    }

    return [Pester.ShouldResult] @{
        Succeeded      = $succeeded
        FailureMessage = $failureMessage
        ExpectResult   = @{
            Actual   = Format-Nicely $ActualValue
            Expected = if ($Negate) { 'not exist' } else { 'exist' }
            Because  = $Because
        }
    }
}

& $script:SafeCommands['Add-ShouldOperator'] -Name Exist `
    -InternalName Should-Exist `
    -Test         ${function:Should-Exist}

Set-ShouldOperatorHelpMessage -OperatorName Exist `
    -HelpMessage "Does not perform any comparison, but checks if the object calling Exist is present in a PS Provider. The object must have valid path syntax. It essentially must pass a Test-Path call."

function ShouldExistFailureMessage() {
}
function NotShouldExistFailureMessage() {
}
# file src\functions\assertions\FileContentMatch.ps1
function Should-FileContentMatch($ActualValue, $ExpectedContent, [switch] $Negate, $Because) {
    <#
    .SYNOPSIS
    Checks to see if a file contains the specified text.
    This search is not case sensitive and uses regular expressions.

    .EXAMPLE
    Set-Content -Path TestDrive:\file.txt -Value 'I am a file.'
    'TestDrive:\file.txt' | Should -FileContentMatch 'I Am'

    Create a new file and verify its content. This test passes.
    The 'I Am' regular expression (RegEx) pattern matches against the txt file contents.
    For case-sensitivity, see FileContentMatchExactly.

    .EXAMPLE
    'TestDrive:\file.txt' | Should -FileContentMatch '^I.*file\.$'

    This RegEx pattern also matches against the "I am a file." string from Example 1.
    With a matching RegEx pattern, this test also passes.

    .EXAMPLE
    'TestDrive:\file.txt' | Should -FileContentMatch 'I Am Not'

    This test fails, as the RegEx pattern does not match "I am a file."

    .EXAMPLE
    'TestDrive:\file.txt' | Should -FileContentMatch 'I.am.a.file'

    This test passes, because "." in RegEx matches any character including a space.

    .EXAMPLE
    'TestDrive:\file.txt' | Should -FileContentMatch ([regex]::Escape('I.am.a.file'))

    Tip: Use [regex]::Escape("pattern") to match the exact text.
    This test fails, because "I am a file." != "I.am.a.file"
    #>
    $succeeded = (@(& $SafeCommands['Get-Content'] -Encoding UTF8 $ActualValue) -match $ExpectedContent).Count -gt 0

    if ($Negate) {
        $succeeded = -not $succeeded
    }

    $failureMessage = ''

    if ($true -eq $succeeded) { return [Pester.ShouldResult]@{Succeeded = $succeeded } }

    if ($Negate) {
        $failureMessage = NotShouldFileContentMatchFailureMessage -ActualValue $ActualValue -ExpectedContent $ExpectedContent -Because $Because
    }
    else {
        $failureMessage = ShouldFileContentMatchFailureMessage -ActualValue $ActualValue -ExpectedContent $ExpectedContent -Because $Because
    }

    $ExpectedValue = $ExpectedContent

    return [Pester.ShouldResult] @{
        Succeeded      = $succeeded
        FailureMessage = $failureMessage
        ExpectResult   = @{
            Actual   = Format-Nicely $ActualValue
            Expected = Format-Nicely $ExpectedValue
            Because  = $Because
        }
    }
}

function ShouldFileContentMatchFailureMessage($ActualValue, $ExpectedContent, $Because) {
    return "Expected $(Format-Nicely $ExpectedContent) to be found in file '$ActualValue',$(Format-Because $Because) but it was not found."
}

function NotShouldFileContentMatchFailureMessage($ActualValue, $ExpectedContent, $Because) {
    return "Expected $(Format-Nicely $ExpectedContent) to not be found in file '$ActualValue',$(Format-Because $Because) but it was found."
}

& $script:SafeCommands['Add-ShouldOperator'] -Name FileContentMatch `
    -InternalName Should-FileContentMatch `
    -Test         ${function:Should-FileContentMatch}

Set-ShouldOperatorHelpMessage -OperatorName FileContentMatch `
    -HelpMessage 'Checks to see if a file contains the specified text. This search is not case sensitive and uses regular expressions.'
# file src\functions\assertions\FileContentMatchExactly.ps1
function Should-FileContentMatchExactly($ActualValue, $ExpectedContent, [switch] $Negate, [String] $Because) {
    <#
    .SYNOPSIS
    Checks to see if a file contains the specified text.
    This search is case sensitive and uses regular expressions to match the text.

    .EXAMPLE
    Set-Content -Path TestDrive:\file.txt -Value 'I am a file.'
    'TestDrive:\file.txt' | Should -FileContentMatchExactly 'I am'

    Create a new file and verify its content. This test passes.
    The 'I am' regular expression (RegEx) pattern matches against the txt file contents.

    .EXAMPLE
    'TestDrive:\file.txt' | Should -FileContentMatchExactly 'I Am'

    This test checks a case-sensitive pattern against the "I am a file." string from Example 1.
    Because the RegEx pattern fails to match, this test fails.
#>
    $succeeded = (@(& $SafeCommands['Get-Content'] -Encoding UTF8 $ActualValue) -cmatch $ExpectedContent).Count -gt 0

    if ($Negate) {
        $succeeded = -not $succeeded
    }

    $failureMessage = ''

    if ($true -eq $succeeded) { return [Pester.ShouldResult]@{Succeeded = $succeeded } }

    if ($Negate) {
        $failureMessage = NotShouldFileContentMatchExactlyFailureMessage -ActualValue $ActualValue -ExpectedContent $ExpectedContent -Because $Because
    }
    else {
        $failureMessage = ShouldFileContentMatchExactlyFailureMessage -ActualValue $ActualValue -ExpectedContent $ExpectedContent -Because $Because
    }

    $ExpectedValue = $ExpectedContent

    return [Pester.ShouldResult] @{
        Succeeded      = $succeeded
        FailureMessage = $failureMessage
        ExpectResult   = @{
            Actual   = Format-Nicely $ActualValue
            Expected = Format-Nicely $ExpectedValue
            Because  = $Because
        }
    }
}

function ShouldFileContentMatchExactlyFailureMessage($ActualValue, $ExpectedContent) {
    return "Expected $(Format-Nicely $ExpectedContent) to be case sensitively found in file $(Format-Nicely $ActualValue),$(Format-Because $Because) but it was not found."
}

function NotShouldFileContentMatchExactlyFailureMessage($ActualValue, $ExpectedContent) {
    return "Expected $(Format-Nicely $ExpectedContent) to not be case sensitively found in file $(Format-Nicely $ActualValue),$(Format-Because $Because) but it was found."
}

& $script:SafeCommands['Add-ShouldOperator'] -Name FileContentMatchExactly `
    -InternalName Should-FileContentMatchExactly `
    -Test         ${function:Should-FileContentMatchExactly}

Set-ShouldOperatorHelpMessage -OperatorName FileContentMatchExactly `
    -HelpMessage 'Checks to see if a file contains the specified text. This search is case sensitive and uses regular expressions to match the text.'
# file src\functions\assertions\FileContentMatchMultiline.ps1
function Should-FileContentMatchMultiline($ActualValue, $ExpectedContent, [switch] $Negate, [String] $Because) {
    <#
    .SYNOPSIS
    As opposed to FileContentMatch and FileContentMatchExactly operators,
    FileContentMatchMultiline presents content of the file being tested as one string object,
    so that the expression you are comparing it to can consist of several lines.

    When using FileContentMatchMultiline operator, '^' and '$' represent the beginning and end
    of the whole file, instead of the beginning and end of a line.

    .EXAMPLE
    $Content = "I am the first line.`nI am the second line."
    Set-Content -Path TestDrive:\file.txt -Value $Content -NoNewline
    'TestDrive:\file.txt' | Should -FileContentMatchMultiline 'first line\.\r?\nI am'

    This regular expression (RegEx) pattern matches the file contents, and the test passes.

    .EXAMPLE
    'TestDrive:\file.txt' | Should -FileContentMatchMultiline '^I am the first.*\n.*second line\.$'

    Using the file from Example 1, this RegEx pattern also matches, and this test also passes.

    .EXAMPLE
    'TestDrive:\file.txt' | Should -FileContentMatchMultiline '^I am the first line\.$'

    FileContentMatchMultiline uses the '$' symbol to match the end of the file,
    not the end of any single line within the file. This test fails.
#>
    $succeeded = [bool] ((& $SafeCommands['Get-Content'] $ActualValue -Delimiter ([char]0)) -match $ExpectedContent)

    if ($Negate) {
        $succeeded = -not $succeeded
    }

    $failureMessage = ''

    if ($true -eq $succeeded) { return [Pester.ShouldResult]@{Succeeded = $succeeded } }

    if ($Negate) {
        $failureMessage = NotShouldFileContentMatchMultilineFailureMessage -ActualValue $ActualValue -ExpectedContent $ExpectedContent -Because $Because
    }
    else {
        $failureMessage = ShouldFileContentMatchMultilineFailureMessage -ActualValue $ActualValue -ExpectedContent $ExpectedContent -Because $Because
    }

    $ExpectedValue = $ExpectedContent

    return [Pester.ShouldResult] @{
        Succeeded      = $succeeded
        FailureMessage = $failureMessage
        ExpectResult   = @{
            Actual   = Format-Nicely $ActualValue
            Expected = Format-Nicely $ExpectedValue
            Because  = $Because
        }
    }
}

function ShouldFileContentMatchMultilineFailureMessage($ActualValue, $ExpectedContent, $Because) {
    return "Expected $(Format-Nicely $ExpectedContent) to be found in file $(Format-Nicely $ActualValue),$(Format-Because $Because) but it was not found."
}

function NotShouldFileContentMatchMultilineFailureMessage($ActualValue, $ExpectedContent, $Because) {
    return "Expected $(Format-Nicely $ExpectedContent) to not be found in file $(Format-Nicely $ActualValue),$(Format-Because $Because) but it was found."
}

& $script:SafeCommands['Add-ShouldOperator'] -Name FileContentMatchMultiline `
    -InternalName Should-FileContentMatchMultiline `
    -Test         ${function:Should-FileContentMatchMultiline}

Set-ShouldOperatorHelpMessage -OperatorName FileContentMatchMultiline `
    -HelpMessage "As opposed to FileContentMatch and FileContentMatchExactly operators, FileContentMatchMultiline presents content of the file being tested as one string object, so that the expression you are comparing it to can consist of several lines.`n`nWhen using FileContentMatchMultiline operator, '^' and '$' represent the beginning and end of the whole file, instead of the beginning and end of a line"
# file src\functions\assertions\FileContentMatchMultilineExactly.ps1
function Should-FileContentMatchMultilineExactly($ActualValue, $ExpectedContent, [switch] $Negate, [String] $Because) {
    <#
    .SYNOPSIS
    As opposed to FileContentMatch and FileContentMatchExactly operators,
    FileContentMatchMultilineExactly presents content of the file being tested as one string object,
    so that the case sensitive expression you are comparing it to can consist of several lines.

    When using FileContentMatchMultilineExactly operator, '^' and '$' represent the beginning and end
    of the whole file, instead of the beginning and end of a line.

    .EXAMPLE
    $Content = "I am the first line.`nI am the second line."
    Set-Content -Path TestDrive:\file.txt -Value $Content -NoNewline
    'TestDrive:\file.txt' | Should -FileContentMatchMultilineExactly "first line.`nI am"

    This specified content across multiple lines case sensitively matches the file contents, and the test passes.

    .EXAMPLE
    'TestDrive:\file.txt' | Should -FileContentMatchMultilineExactly "First line.`nI am"

    Using the file from Example 1, this specified content across multiple lines does not case sensitively match,
    because the 'F' on the first line is capitalized. This test fails.

    .EXAMPLE
    'TestDrive:\file.txt' | Should -FileContentMatchMultilineExactly 'first line\.\r?\nI am'

    Using the file from Example 1, this RegEx pattern case sensitively matches the file contents, and the test passes.

    .EXAMPLE
    'TestDrive:\file.txt' | Should -FileContentMatchMultilineExactly '^I am the first.*\n.*second line\.$'

    Using the file from Example 1, this RegEx pattern also case sensitively matches, and this test also passes.

    .EXAMPLE
    'TestDrive:\file.txt' | Should -FileContentMatchMultilineExactly '^am the first line\.$'

    Using the file from Example 1, FileContentMatchMultilineExactly uses the '^' symbol to case sensitively match the start of the file,
    so '^am' is invalid here because the start of the file is '^I am'. This test fails.

    .EXAMPLE
    'TestDrive:\file.txt' | Should -FileContentMatchMultilineExactly '^I am the first line\.$'

    Using the file from Example 1, FileContentMatchMultilineExactly uses the '$' symbol to case sensitively match the end of the file,
    not the end of any single line within the file. This test also fails.
    #>
    $succeeded = [bool] ((& $SafeCommands['Get-Content'] $ActualValue -Delimiter ([char]0)) -cmatch $ExpectedContent)

    if ($Negate) {
        $succeeded = -not $succeeded
    }

    $failureMessage = ''

    if (-not $succeeded) {
        if ($Negate) {
            $failureMessage = NotShouldFileContentMatchMultilineExactlyFailureMessage -ActualValue $ActualValue -ExpectedContent $ExpectedContent -Because $Because
        }
        else {
            $failureMessage = ShouldFileContentMatchMultilineExactlyFailureMessage -ActualValue $ActualValue -ExpectedContent $ExpectedContent -Because $Because
        }
    }

    $ExpectedValue = $ExpectedContent

    return [Pester.ShouldResult] @{
        Succeeded      = $succeeded
        FailureMessage = $failureMessage
        ExpectResult   = @{
            Actual   = Format-Nicely $ActualValue
            Expected = Format-Nicely $ExpectedValue
            Because  = $Because
        }
    }
}

function ShouldFileContentMatchMultilineExactlyFailureMessage($ActualValue, $ExpectedContent, $Because) {
    return "Expected $(Format-Nicely $ExpectedContent) to be case sensitively found in file $(Format-Nicely $ActualValue),$(Format-Because $Because) but it was not found."
}

function NotShouldFileContentMatchMultilineExactlyFailureMessage($ActualValue, $ExpectedContent, $Because) {
    return "Expected $(Format-Nicely $ExpectedContent) to not be case sensitively found in file $(Format-Nicely $ActualValue),$(Format-Because $Because) but it was found."
}

& $script:SafeCommands['Add-ShouldOperator'] -Name FileContentMatchMultilineExactly `
    -InternalName Should-FileContentMatchMultilineExactly `
    -Test         ${function:Should-FileContentMatchMultilineExactly}

Set-ShouldOperatorHelpMessage -OperatorName FileContentMatchMultilineExactly `
    -HelpMessage "As opposed to FileContentMatch and FileContentMatchExactly operators, FileContentMatchMultilineExactly presents content of the file being tested as one string object, so that the case sensitive expression you are comparing it to can consist of several lines.`n`nWhen using FileContentMatchMultilineExactly operator, '^' and '$' represent the beginning and end of the whole file, instead of the beginning and end of a line."
# file src\functions\assertions\HaveCount.ps1
function Should-HaveCount($ActualValue, [int] $ExpectedValue, [switch] $Negate, [string] $Because) {
    <#
    .SYNOPSIS
    Asserts that a collection has the expected amount of items.

    .EXAMPLE
    1,2,3 | Should -HaveCount 3

    This test passes, because it expected three objects, and received three.
    This is like running `@(1,2,3).Count` in PowerShell.
    #>
    if ($ExpectedValue -lt 0) {
        throw [ArgumentException]"Excpected collection size must be greater than or equal to 0."
    }
    $count = if ($null -eq $ActualValue) {
        0
    }
    else {
        $ActualValue.Count
    }
    $expectingEmpty = $ExpectedValue -eq 0
    [bool] $succeeded = $count -eq $ExpectedValue
    if ($Negate) {
        $succeeded = -not $succeeded
    }


    if (-not $succeeded) {

        if ($Negate) {
            $expect = if ($expectingEmpty) {
                "Expected a non-empty collection"
            }
            else {
                "Expected a collection with size different from $(Format-Nicely $ExpectedValue)"
            }
            $but = if ($count -ne 0) {
                "but got collection with that size $(Format-Nicely $ActualValue)."
            }
            else {
                "but got an empty collection."
            }

            $ExpectedResult = if ($expectingEmpty) { 'a non-empty collection' } else { "a collection with size different from $(Format-Nicely $ExpectedValue)" }

            return [Pester.ShouldResult] @{
                Succeeded      = $false
                FailureMessage = "$expect,$(Format-Because $Because) $but"
                ExpectResult   = @{
                    Actual   = Format-Nicely $ActualValue
                    Expected = Format-Nicely $ExpectedResult
                    Because  = $Because
                }
            }
        }
        else {
            $expect = if ($expectingEmpty) {
                "Expected an empty collection"
            }
            else {
                "Expected a collection with size $(Format-Nicely $ExpectedValue)"
            }
            $but = if ($count -ne 0) {
                "but got collection with size $(Format-Nicely $count) $(Format-Nicely $ActualValue)."
            }
            else {
                "but got an empty collection."
            }

            $ExpectedResult = if ($expectingEmpty) { "an empty collection" } else { "a collection with size $(Format-Nicely $ExpectedValue)" }

            return [Pester.ShouldResult] @{
                Succeeded      = $false
                FailureMessage = "$expect,$(Format-Because $Because) $but"
                ExpectResult   = @{
                    Actual   = Format-Nicely $ActualValue
                    Expected = Format-Nicely $ExpectedResult
                    Because  = $Because
                }
            }
        }
    }

    return [Pester.ShouldResult] @{
        Succeeded = $true
    }
}

& $script:SafeCommands['Add-ShouldOperator'] -Name HaveCount `
    -InternalName Should-HaveCount `
    -Test         ${function:Should-HaveCount} `
    -SupportsArrayInput

Set-ShouldOperatorHelpMessage -OperatorName HaveCount `
    -HelpMessage 'Asserts that a collection has the expected amount of items.'

function ShouldHaveCountFailureMessage() {
}
function NotShouldHaveCountFailureMessage() {
}
# file src\functions\assertions\HaveParameter.ps1
function Should-HaveParameter (
    $ActualValue,
    [String] $ParameterName,
    $Type,
    [String] $DefaultValue,
    [Switch] $Mandatory,
    [String] $InParameterSet,
    [Switch] $HasArgumentCompleter,
    [String[]] $Alias,
    [Switch] $Negate,
    [String] $Because ) {
    <#
    .SYNOPSIS
        Asserts that a command has the expected parameter.

    .EXAMPLE
        Get-Command "Invoke-WebRequest" | Should -HaveParameter Uri -Mandatory

        This test passes, because it expected the parameter URI to exist and to
        be mandatory.
    .NOTES
        The attribute [ArgumentCompleter] was added with PSv5. Previouse this
        assertion will not be able to use the -HasArgumentCompleter parameter
        if the attribute does not exist.
    #>
    if ($null -eq $ActualValue -or $ActualValue -isnot [Management.Automation.CommandInfo]) {
        throw [ArgumentException]"Input value must be non-null CommandInfo object. You can get one by calling Get-Command."
    }

    if ($ActualValue -is [Management.Automation.ApplicationInfo]) {
        throw [ArgumentException]"Input value can not be an ApplicationInfo object."
    }

    if ($null -eq $ParameterName) {
        throw [ArgumentException]"The ParameterName can't be empty"
    }

    #region HelperFunctions
    function Get-ParameterInfo {
        param (
            [Parameter(Mandatory = $true)]
            [Management.Automation.CommandInfo]$Command,
            [Parameter(Mandatory = $true)]
            [string] $Name
        )

        # Resolve alias to the actual command so we can access scriptblock
        if ($Command -is [System.Management.Automation.AliasInfo] -and $Command.ResolvedCommand) {
            $Command = $Command.ResolvedCommand
        }

        $ast = $Command.ScriptBlock.Ast

        if ($null -eq $ast) {
            # Ast is unavailable, ex. for a binary cmdlet
            throw [ArgumentException]'Using -DefaultValue is only supported for functions and scripts.'
        }

        if ($null -ne $ast.Parameters) {
            # Functions without paramblock
            $parameters = $ast.Parameters
        }
        elseif ($null -ne $ast.Body.ParamBlock) {
            # Functions with paramblock
            $parameters = $ast.Body.ParamBlock.Parameters
        }
        elseif ($null -ne $ast.ParamBlock) {
            # Script paramblock
            $parameters = $ast.ParamBlock.Parameters
        }
        else {
            return
        }

        foreach ($parameter in $parameters) {
            if ($Name -ne $parameter.Name.VariablePath.UserPath) {
                continue
            }

            $paramInfo = [PSCustomObject] @{
                Name             = $parameter.Name.VariablePath.UserPath
                Type             = "[$($parameter.StaticType.Name.ToLower())]"
                HasDefaultValue  = $false
                DefaultValue     = $null
                DefaultValueType = $parameter.StaticType.Name
            }

            # Default value here contains a descriptor object of the default value,
            # so this is null only when default value is not present at all, if default value
            # is actually $null, this will have an object describing the type and the $null value.
            if ($null -ne $parameter.DefaultValue) {
                # The actual value of the default value can be falsy (e.g. $null, $false or 0)
                # use this flag to communicate if default value was found in the AST or not,
                # no matter if the actual default value is falsy.
                # That is: param($param1 = $false) will set this to true for $param1
                # but param($param1) will have this set to false, because there was no default value.
                $paramInfo.HasDefaultValue = $true
                # When the value has a known fully realized value (indicated by .Value being on the DefaultValue object)
                # we take that and use it, otherwise we take the extent (how it was written in code). This will make
                # 1, 2, or "abc", appear as 1, 2, abc to the assertion, but (Get-Date) will be (Get-Date).
                $paramInfo.DefaultValue = Get-DefaultValue $parameter.DefaultValue
            }

            $paramInfo
            break
        }
    }

    function Get-DefaultValue {
        param($DefaultValue)

        # This is a value like 1, or 0, return it direcly.
        if ($DefaultValue.PSObject.Properties["Value"]) {
            return $DefaultValue.Value
        }

        # This is for backwards compatibility with Pester v5.4.0.
        # Existing assertions check for -DefaultValue "false", while the definition
        # of the function says $MyParam = $false.
        if ('$true' -eq $DefaultValue.Extent.Text -or '$false' -eq $DefaultValue.Extent.Text) {
            # returns "true", or "false" without $ prefix
            return $DefaultValue.VariablePath
        }

        # This is for backwards compatibility with Pester v5.4.0.
        # Existing assertions check for -DefaultValue "", while the definition
        # of the function says $MyParam = $null or $MyParam without any default value.
        if ('$null' -eq $DefaultValue.Extent.Text) {
            return ""
        }

        $DefaultValue.Extent.Text
    }

    function Get-ArgumentCompleter {
        <#
        .SYNOPSIS
            Get custom argument completers registered in the current session.
        .DESCRIPTION
            Get custom argument completers registered in the current session.

            By default Get-ArgumentCompleter lists all of the completers registered in the session.
        .EXAMPLE
            Get-ArgumentCompleter

            Get all of the argument completers for PowerShell commands in the current session.
        .EXAMPLE
            Get-ArgumentCompleter -CommandName Invoke-ScriptAnalyzer

            Get all of the argument completers used by the Invoke-ScriptAnalyzer command.
        .EXAMPLE
            Get-ArgumentCompleter -Native

            Get all of the argument completers for native commands in the current session.
        .NOTES
            Author: Chris Dent
        #>
        [CmdletBinding()]
        param (
            # Filter results by command name.
            [Parameter(Mandatory = $true)]
            [String]$CommandName,

            # Filter results by parameter name.
            [Parameter(Mandatory = $true)]
            [String]$ParameterName
        )

        $getExecutionContextFromTLS = [PowerShell].Assembly.GetType('System.Management.Automation.Runspaces.LocalPipeline').GetMethod(
            'GetExecutionContextFromTLS',
            [System.Reflection.BindingFlags]'Static, NonPublic'
        )
        $internalExecutionContext = $getExecutionContextFromTLS.Invoke(
            $null,
            [System.Reflection.BindingFlags]'Static, NonPublic',
            $null,
            $null,
            $PSCulture
        )

        $argumentCompletersProperty = $internalExecutionContext.GetType().GetProperty(
            'CustomArgumentCompleters',
            [System.Reflection.BindingFlags]'NonPublic, Instance'
        )
        $argumentCompleters = $argumentCompletersProperty.GetGetMethod($true).Invoke(
            $internalExecutionContext,
            [System.Reflection.BindingFlags]'Instance, NonPublic, GetProperty',
            $null,
            @(),
            $PSCulture
        )

        $completerName = '{0}:{1}' -f $CommandName, $ParameterName
        if ($argumentCompleters.ContainsKey($completerName)) {
            [PSCustomObject]@{
                CommandName   = $CommandName
                ParameterName = $ParameterName
                Definition    = $argumentCompleters[$completerName]
            }
        }
    }
    #endregion HelperFunctions

    if ($Type -is [string]) {
        # parses type that is provided as a string in brackets (such as [int])
        $trimmedType = $Type -replace '^\[(.*)\]$', '$1'
        $parsedType = $trimmedType -as [Type]
        if ($null -eq $parsedType) {
            throw [ArgumentException]"Could not find type [$trimmedType]. Make sure that the assembly that contains that type is loaded."
        }

        $Type = $parsedType
    }

    $buts = @()
    $filters = @()

    $null = $ActualValue.Parameters # necessary for PSv2. Keeping just in case
    if ($null -eq $ActualValue.Parameters -and $ActualValue -is [System.Management.Automation.AliasInfo]) {
        # PowerShell doesn't resolve alias parameters properly in Get-Command when function is defined in a local scope in a different session state.
        # https://github.com/pester/Pester/issues/1431 and https://github.com/PowerShell/PowerShell/issues/17629
        if ($ActualValue.Definition -match '^PesterMock_') {
            $type = 'mock'
            $suggestion = "'Get-Command $($ActualValue.Name) | Where-Object Parameters | Should -HaveParameter ...'"
        }
        else {
            $type = 'alias'
            $suggestion = "using the actual command name. For example: 'Get-Command $($ActualValue.Definition) | Should -HaveParameter ...'"
        }

        throw "Could not retrieve parameters for $type $($ActualValue.Name). This is a known issue with Get-Command in PowerShell. Try $suggestion"
    }

    $hasKey = $ActualValue.Parameters.PSBase.ContainsKey($ParameterName)
    $filters += "to$(if ($Negate) {' not'}) have a parameter $ParameterName$(if ($InParameterSet) { " in parameter set $InParameterSet" })"

    if (-not $Negate -and -not $hasKey) {
        $buts += "the parameter is missing"
    }
    elseif ($Negate -and -not $hasKey) {
        return [Pester.ShouldResult] @{ Succeeded = $true }
    }
    elseif ($Negate -and $hasKey -and -not ($InParameterSet -or $Mandatory -or $Type -or $DefaultValue -or $HasArgumentCompleter)) {
        $buts += 'the parameter exists'
    }
    else {
        $attributes = $ActualValue.Parameters[$ParameterName].Attributes
        $parameterAttributes = $attributes | & $SafeCommands['Where-Object'] { $_ -is [System.Management.Automation.ParameterAttribute] }

        if ($InParameterSet) {
            $parameterAttributes = $parameterAttributes | & $SafeCommands['Where-Object'] { $_.ParameterSetName -eq $InParameterSet }

            if (-not $Negate -and -not $parameterAttributes) {
                $buts += 'the parameter is missing'
            }
            elseif ($Negate -and $parameterAttributes) {
                $buts += 'the parameter exists'
            }
        }
    }

    if ($buts.Count -eq 0) {
        # Parameter exists (in set if specified), assert remaining requirements

        if ($Mandatory) {
            $testMandatory = $parameterAttributes | & $SafeCommands['Where-Object'] { $_.Mandatory }
            $filters += "which is$(if ($Negate) {' not'}) mandatory"

            if (-not $Negate -and -not $testMandatory) {
                $buts += "it wasn't mandatory"
            }
            elseif ($Negate -and $testMandatory) {
                $buts += 'it was mandatory'
            }
        }

        if ($Type) {
            # This block is not using `Format-Nicely`, as in PSv2 the output differs. Eg:
            # PS2> [System.DateTime]
            # PS5> [datetime]
            [type]$actualType = $ActualValue.Parameters[$ParameterName].ParameterType
            $testType = ($Type -eq $actualType)
            $filters += "$(if ($Negate) { 'not ' })of type [$($Type.FullName)]"

            if (-not $Negate -and -not $testType) {
                $buts += "it was of type [$($actualType.FullName)]"
            }
            elseif ($Negate -and $testType) {
                $buts += "it was of type [$($Type.FullName)]"
            }
        }

        if ($PSBoundParameters.Keys -contains "DefaultValue") {
            $parameterMetadata = Get-ParameterInfo -Name $ParameterName -Command $ActualValue
            if ($null -eq $parameterMetadata) {
                # For safety, but this probably won't happen because if the parameter is not on the command we will fail much sooner.
                throw "Metadata for parameter '$ParameterName' were not found."
            }

            $filters += "the default value$(if ($Negate) {" not"}) to be $(Format-Nicely $DefaultValue)"

            # We could determine if the value is present and what is it's exact value, and also always use the
            # code literal that was used in the definition of the function (e.g. $true instead of "True"),
            # but that would be a breaking change for Pester 5, and in case of strings it would be a little
            # inconvenient for the users, because they would always have to provide doubled quotes, like '"aaa"'.
            # So instead we force the values to be strings, and when the value is not there we define it as $null
            # which prevents us from full checking if there was or was not an actual $null definition, but that is
            # okay because you would rarely need to do that.
            $defaultIsUnspecified = -not $parameterMetadata.HasDefaultValue
            [string] $actualDefault = if ($defaultIsUnspecified) { $null } else { $parameterMetadata.DefaultValue }
            $testDefault = ($actualDefault -eq $DefaultValue)

            if (-not $Negate -and -not $testDefault) {
                $buts += "the default value was $(Format-Nicely $actualDefault)"
            }
            elseif ($Negate -and $testDefault) {
                $buts += "the default value was $(Format-Nicely $actualDefault)"
            }
        }

        if ($HasArgumentCompleter) {
            $testArgumentCompleter = $attributes | & $SafeCommands['Where-Object'] { $_ -is [ArgumentCompleter] }

            if (-not $testArgumentCompleter) {
                $testArgumentCompleter = Get-ArgumentCompleter -CommandName $ActualValue.Name -ParameterName $ParameterName
            }
            $filters += 'has ArgumentCompletion'

            if (-not $Negate -and -not $testArgumentCompleter) {
                $buts += 'has no ArgumentCompletion'
            }
            elseif ($Negate -and $testArgumentCompleter) {
                $buts += 'has ArgumentCompletion'
            }
        }

        if ($Alias) {

            $filters += "with$(if ($Negate) {'out'}) alias$(if ($Alias.Count -ge 2) {'es'}) $(Join-And ($Alias -replace '^|$', "'"))"
            $faultyAliases = @()
            foreach ($AliasValue in $Alias) {
                $testPresenceOfAlias = $ActualValue.Parameters[$ParameterName].Aliases -contains $AliasValue
                if (-not $Negate -and -not $testPresenceOfAlias) {
                    $faultyAliases += $AliasValue
                }
                elseif ($Negate -and $testPresenceOfAlias) {
                    $faultyAliases += $AliasValue
                }
            }
            if ($faultyAliases.Count -ge 1) {
                $aliases = $(Join-And ($faultyAliases -replace '^|$', "'"))
                $singular = $faultyAliases.Count -eq 1
                if ($Negate) {
                    $buts += "it has $(if($singular) {'an alias'} else {'the aliases'} ) $aliases"
                }
                else {
                    $buts += "it didn't have $(if($singular) {'an alias'} else {'the aliases'} ) $aliases"
                }
            }
        }
    }

    if ($buts.Count -ne 0) {
        $filter = Add-SpaceToNonEmptyString ( Join-And $filters -Threshold 3 )
        $but = Join-And $buts
        $failureMessage = "Expected command $($ActualValue.Name)$filter,$(Format-Because $Because) but $but."

        $ExpectedValue = "Parameter $($ActualValue.Name)$filter"

        return [Pester.ShouldResult] @{
            Succeeded      = $false
            FailureMessage = $failureMessage
            ExpectResult   = @{
                Actual   = Format-Nicely $ActualValue
                Expected = Format-Nicely $ExpectedValue
                Because  = $Because
            }
        }
    }
    else {
        return [Pester.ShouldResult] @{ Succeeded = $true }
    }
}

& $script:SafeCommands['Add-ShouldOperator'] -Name HaveParameter `
    -InternalName Should-HaveParameter `
    -Test         ${function:Should-HaveParameter}

Set-ShouldOperatorHelpMessage -OperatorName HaveParameter `
    -HelpMessage 'Asserts that a command has the expected parameter.'
# file src\functions\assertions\Match.ps1
function Should-Match($ActualValue, $RegularExpression, [switch] $Negate, [string] $Because) {
    <#
    .SYNOPSIS
    Uses a regular expression to compare two objects.
    This comparison is not case sensitive.

    .EXAMPLE
    "I am a value" | Should -Match "I Am"

    The "I Am" regular expression (RegEx) pattern matches the provided string,
    so the test passes. For case sensitive matches, see MatchExactly.
    .EXAMPLE
    "I am a value" | Should -Match "I am a bad person" # Test will fail

    RegEx pattern does not match the string, and the test fails.
    .EXAMPLE
    "Greg" | Should -Match ".reg" # Test will pass

    This test passes, as "." in RegEx matches any character.
    .EXAMPLE
    "Greg" | Should -Match ([regex]::Escape(".reg"))

    One way to provide literal characters to Match is the [regex]::Escape() method.
    This test fails, because the pattern does not match a period symbol.
    #>
    [bool] $succeeded = $ActualValue -match $RegularExpression

    if ($Negate) {
        $succeeded = -not $succeeded
    }

    $failureMessage = ''

    if ($true -eq $succeeded) { return [Pester.ShouldResult]@{Succeeded = $succeeded } }

    if ($Negate) {
        $failureMessage = NotShouldMatchFailureMessage -ActualValue $ActualValue -RegularExpression $RegularExpression -Because $Because
    }
    else {
        $failureMessage = ShouldMatchFailureMessage -ActualValue $ActualValue -RegularExpression $RegularExpression -Because $Because
    }

    $ExpectedValue = $RegularExpression

    return [Pester.ShouldResult] @{
        Succeeded      = $succeeded
        FailureMessage = $failureMessage
        ExpectResult   = @{
            Actual   = Format-Nicely $ActualValue
            Expected = Format-Nicely $ExpectedValue
            Because  = $Because
        }
    }
}

function ShouldMatchFailureMessage($ActualValue, $RegularExpression, $Because) {
    return "Expected regular expression $(Format-Nicely $RegularExpression) to match $(Format-Nicely $ActualValue),$(Format-Because $Because) but it did not match."
}

function NotShouldMatchFailureMessage($ActualValue, $RegularExpression, $Because) {
    return "Expected regular expression $(Format-Nicely $RegularExpression) to not match $(Format-Nicely $ActualValue),$(Format-Because $Because) but it did match."
}

& $script:SafeCommands['Add-ShouldOperator'] -Name Match `
    -InternalName Should-Match `
    -Test         ${function:Should-Match}

Set-ShouldOperatorHelpMessage -OperatorName Match `
    -HelpMessage 'Uses a regular expression to compare two objects. This comparison is not case sensitive.'
# file src\functions\assertions\MatchExactly.ps1
function Should-MatchExactly($ActualValue, $RegularExpression, [switch] $Negate, [string] $Because) {
    <#
    .SYNOPSIS
    Uses a regular expression to compare two objects.
    This comparison is case sensitive.

    .EXAMPLE
    "I am a value" | Should -MatchExactly "I am"

    The "I am" regular expression (RegEx) pattern matches the string.
    This test passes.

    .EXAMPLE
    "I am a value" | Should -MatchExactly "I Am"

    Because MatchExactly is case sensitive, this test fails.
    For a case insensitive test, see Match.
    #>
    [bool] $succeeded = $ActualValue -cmatch $RegularExpression

    if ($Negate) {
        $succeeded = -not $succeeded
    }

    $failureMessage = ''

    if ($true -eq $succeeded) { return [Pester.ShouldResult]@{Succeeded = $succeeded } }

    if ($Negate) {
        $failureMessage = NotShouldMatchExactlyFailureMessage -ActualValue $ActualValue -RegularExpression $RegularExpression -Because $Because
    }
    else {
        $failureMessage = ShouldMatchExactlyFailureMessage -ActualValue $ActualValue -RegularExpression $RegularExpression -Because $Because
    }

    $ExpectedValue = $RegularExpression

    return [Pester.ShouldResult] @{
        Succeeded      = $succeeded
        FailureMessage = $failureMessage
        ExpectResult   = @{
            Actual   = Format-Nicely $ActualValue
            Expected = Format-Nicely $ExpectedValue
            Because  = $Because
        }
    }
}

function ShouldMatchExactlyFailureMessage($ActualValue, $RegularExpression) {
    return "Expected regular expression $(Format-Nicely $RegularExpression) to case sensitively match $(Format-Nicely $ActualValue),$(Format-Because $Because) but it did not match."
}

function NotShouldMatchExactlyFailureMessage($ActualValue, $RegularExpression) {
    return "Expected regular expression $(Format-Nicely $RegularExpression) to not case sensitively match $(Format-Nicely $ActualValue),$(Format-Because $Because) but it did match."
}

& $script:SafeCommands['Add-ShouldOperator'] -Name MatchExactly `
    -InternalName Should-MatchExactly `
    -Test         ${function:Should-MatchExactly} `
    -Alias        'CMATCH'

Set-ShouldOperatorHelpMessage -OperatorName MatchExactly `
    -HelpMessage 'Uses a regular expression to compare two objects. This comparison is case sensitive.'
# file src\functions\assertions\PesterThrow.ps1
function Should-Throw {
    <#
    .SYNOPSIS
    Checks if an exception was thrown. Enclose input in a script block.

    Warning: The input object must be a ScriptBlock, otherwise it is processed outside of the assertion.

    .EXAMPLE
    { foo } | Should -Throw

    Because "foo" isn't a known command, PowerShell throws an error.
    Throw confirms that an error occurred, and successfully passes the test.

    .EXAMPLE
    { foo } | Should -Not -Throw

    By using -Not with -Throw, the opposite effect is achieved.
    "Should -Not -Throw" expects no error, but one occurs, and the test fails.

    .EXAMPLE
    { $foo = 1 } | Should -Throw

    Assigning a variable does not throw an error.
    If asserting "Should -Throw" but no error occurs, the test fails.

    .EXAMPLE
    { $foo = 1 } | Should -Not -Throw

    Assert that assigning a variable should not throw an error.
    It does not throw an error, so the test passes.
    #>
    param (
        $ActualValue,
        [string] $ExpectedMessage,
        [string] $ErrorId,
        [type] $ExceptionType,
        [switch] $Negate,
        [string] $Because,
        [switch] $PassThru
    )

    $actualExceptionMessage = ""
    $actualExceptionWasThrown = $false
    $actualError = $null
    $actualException = $null
    $actualExceptionLine = $null

    if ($null -eq $ActualValue -or $ActualValue -isnot [ScriptBlock]) {
        throw [ArgumentException] "Input is missing or not a ScriptBlock. Input to '-Throw' and '-Not -Throw' must be enclosed in curly braces."
    }

    try {
        do {
            Write-ScriptBlockInvocationHint -Hint "Should -Throw" -ScriptBlock $ActualValue
            $null = & $ActualValue
        } until ($true)
    }
    catch {
        $actualExceptionWasThrown = $true
        $actualError = $_
        $actualException = $_.Exception
        $actualExceptionMessage = $_.Exception.Message
        $actualErrorId = $_.FullyQualifiedErrorId
        $actualExceptionLine = (Get-ExceptionLineInfo $_.InvocationInfo) -replace [System.Environment]::NewLine, "$([System.Environment]::NewLine)    "
    }

    [bool] $succeeded = $false

    if ($Negate) {
        # this is for Should -Not -Throw. Once *any* exception was thrown we should fail the assertion
        # there is no point in filtering the exception, because there should be none
        $succeeded = -not $actualExceptionWasThrown
        if ($true -eq $succeeded) {
            return [Pester.ShouldResult]@{Succeeded = $succeeded }
        }

        $failureMessage = "Expected no exception to be thrown,$(Format-Because $Because) but an exception `"$actualExceptionMessage`" was thrown $actualExceptionLine."
        return [Pester.ShouldResult] @{
            Succeeded      = $succeeded
            FailureMessage = $failureMessage
        }
    }

    # the rest is for Should -Throw, we must fail the assertion when no exception is thrown
    # or when the exception does not match our filter

    $buts = @()
    $filters = @()

    $filterOnExceptionType = $null -ne $ExceptionType
    if ($filterOnExceptionType) {
        $filters += "type $(Format-Nicely $ExceptionType)"

        if ($actualExceptionWasThrown -and $actualException -isnot $ExceptionType) {
            $buts += "the exception type was $(Format-Nicely ($actualException.GetType()))"
        }
    }

    $filterOnMessage = -not [string]::IsNullOrWhitespace($ExpectedMessage)
    if ($filterOnMessage) {
        $unescapedExpectedMessage = [System.Management.Automation.WildcardPattern]::Unescape($ExpectedMessage)
        $filters += "message like $(Format-Nicely $unescapedExpectedMessage)"
        if ($actualExceptionWasThrown -and (-not (Get-DoValuesMatch $actualExceptionMessage $ExpectedMessage))) {
            $buts += "the message was $(Format-Nicely $actualExceptionMessage)"
        }
    }

    $filterOnId = -not [string]::IsNullOrWhitespace($ErrorId)
    if ($filterOnId) {
        $filters += "FullyQualifiedErrorId $(Format-Nicely $ErrorId)"
        if ($actualExceptionWasThrown -and (-not (Get-DoValuesMatch $actualErrorId $ErrorId))) {
            $buts += "the FullyQualifiedErrorId was $(Format-Nicely $actualErrorId)"
        }
    }

    if (-not $actualExceptionWasThrown) {
        $buts += 'no exception was thrown'
    }

    if ($buts.Count -ne 0) {
        $filter = Join-And $filters
        $but = Join-And $buts
        $failureMessage = "Expected an exception$(if($filter) { " with $filter" }) to be thrown,$(Format-Because $Because) but $but. $actualExceptionLine".Trim()

        $ActualValue = $actualExceptionMessage
        $ExpectedValue = if ($filterOnExceptionType) {
            "type $(Format-Nicely $ExceptionType)"
        }
        else {
            'any exception'
        }

        return [Pester.ShouldResult] @{
            Succeeded      = $false
            FailureMessage = $failureMessage
            ExpectResult   = @{
                Actual   = Format-Nicely $ActualValue
                Expected = Format-Nicely $ExpectedValue
                Because  = $Because
            }
        }
    }

    $result = [Pester.ShouldResult] @{
        Succeeded = $true
    }

    if ($PassThru) {
        $result | & $SafeCommands['Add-Member'] -MemberType NoteProperty -Name 'Data' -Value $actualError
    }

    return $result
}

function Get-DoValuesMatch($ActualValue, $ExpectedValue) {
    #user did not specify any message filter, so any message matches
    if ($null -eq $ExpectedValue) {
        return $true
    }

    return $ActualValue.ToString() -like $ExpectedValue
}

function Get-ExceptionLineInfo($info) {
    # $info.PositionMessage has a leading blank line that we need to account for in PowerShell 2.0
    $positionMessage = $info.PositionMessage -split '\r?\n' -match '\S' -join [System.Environment]::NewLine
    return ($positionMessage -replace "^At ", "from ")
}

function ShouldThrowFailureMessage {
    # to make the should tests happy, for now
}

function NotShouldThrowFailureMessage {
    # to make the should tests happy, for now
}

& $script:SafeCommands['Add-ShouldOperator'] -Name Throw `
    -InternalName Should-Throw `
    -Test         ${function:Should-Throw}

Set-ShouldOperatorHelpMessage -OperatorName Throw `
    -HelpMessage 'Checks if an exception was thrown. Enclose input in a scriptblock.'
# file src\functions\assertions\Should.ps1
function Get-FailureMessage($assertionEntry, $negate, $value, $expected) {
    if ($negate) {
        $failureMessageFunction = $assertionEntry.GetNegativeFailureMessage
    }
    else {
        $failureMessageFunction = $assertionEntry.GetPositiveFailureMessage
    }

    return (& $failureMessageFunction $value $expected)
}

function New-ShouldErrorRecord ([string] $Message, [string] $File, [string] $Line, [string] $LineText, $Terminating) {
    $exception = [Exception] $Message
    $errorID = 'PesterAssertionFailed'
    $errorCategory = [Management.Automation.ErrorCategory]::InvalidResult
    # we use ErrorRecord.TargetObject to pass structured information about the error to a reporting system.
    $targetObject = @{ Message = $Message; File = $File; Line = $Line; LineText = $LineText; Terminating = $Terminating }
    $errorRecord = & $SafeCommands['New-Object'] Management.Automation.ErrorRecord $exception, $errorID, $errorCategory, $targetObject
    return $errorRecord
}

function Should {
    <#
    .SYNOPSIS
    Should is a keyword that is used to define an assertion inside an It block.

    .DESCRIPTION
    Should is a keyword that is used to define an assertion inside an It block.
    Should provides assertion methods to verify assertions e.g. comparing objects.
    If assertion is not met the test fails and an exception is thrown.

    Should can be used more than once in the It block if more than one assertion
    need to be verified. Each Should keyword needs to be on a separate line.
    Test will be passed only when all assertion will be met (logical conjunction).

    .PARAMETER ActualValue
    The actual value that was obtained in the test which should be verified against
    a expected value.

    .EXAMPLE
    ```powershell
    Describe "d1" {
        It "i1" {
            Mock Get-Command { }
            Get-Command -CommandName abc
            Should -Invoke Get-Command -Times 1 -Exactly
        }
    }
    ```

    Example of creating a mock for `Get-Command` and asserting that it was called exactly one time.

    .EXAMPLE
    $true | Should -BeFalse

    Asserting that the input value is false. This would fail the test by throwing an error.

    .EXAMPLE
    $a | Should -Be 10

    Asserting that the input value defined in $a is equal to 10.

    .EXAMPLE
    Should -Invoke Get-Command -Times 1 -Exactly

    Asserting that the mocked `Get-Command` was called exactly one time.

    .EXAMPLE
    $user | Should -Not -BeNullOrEmpty

    Asserting that the input value from $user is not null or empty.

    .EXAMPLE
    $planets.Name | Should -Be $Expected

    Asserting that the value of `$planets.Name` is equal to the value defined in `$Expected`.

    .EXAMPLE
    ```powershell
    Context "We want to ensure an exception is thrown when expected" {
        It "Throws the exception" {
            { Get-Application -Name Blarg } | Should -Throw -ExpectedMessage "Application 'Blarg' not found"
        }
    }
    ```

    Asserting that `Get-Application -Name Blarg` will throw an exception with a specific message.

    .LINK
    https://pester.dev/docs/v5/commands/Should

    .LINK
    https://pester.dev/docs/v5/assertions
    #>
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline = $true, ValueFromRemainingArguments = $true)]
        [object] $ActualValue
    )

    dynamicparam {
        # Figuring out if we are using the old syntax is 'easy'
        # we can use $myInvocation.Line to get the surrounding context
        $myLine = if ($null -ne $MyInvocation -and 0 -le ($MyInvocation.OffsetInLine - 1)) {
            $MyInvocation.Line.Substring($MyInvocation.OffsetInLine - 1)
        }

        # A bit of Regex lets us know if the line used the old form
        if ($myLine -match '^\s{0,}should\s{1,}(?<Operator>[^\-\@\s]+)') {
            $shouldErrorMsg = "Legacy Should syntax (without dashes) is not supported in Pester 5. Please refer to migration guide at: https://pester.dev/docs/v5/migrations/v3-to-v4"
            throw $shouldErrorMsg
        }
        else {
            Get-AssertionDynamicParams
        }
    }

    begin {
        $inputArray = [System.Collections.Generic.List[PSObject]]@()
    }

    process {
        $inputArray.Add($ActualValue)
    }

    end {
        $lineNumber = $MyInvocation.ScriptLineNumber
        $lineText = $MyInvocation.Line.TrimEnd([System.Environment]::NewLine)
        $file = $MyInvocation.ScriptName

        $negate = $false
        if ($PSBoundParameters.ContainsKey('Not')) {
            $negate = [bool]$PSBoundParameters['Not']
        }

        $null = $PSBoundParameters.Remove('ActualValue')
        $null = $PSBoundParameters.Remove($PSCmdlet.ParameterSetName)
        $null = $PSBoundParameters.Remove('Not')

        $entry = Get-AssertionOperatorEntry -Name $PSCmdlet.ParameterSetName

        $shouldThrow = $null
        $errorActionIsDefined = $PSBoundParameters.ContainsKey("ErrorAction")
        if ($errorActionIsDefined) {
            $shouldThrow = 'Stop' -eq $PSBoundParameters["ErrorAction"]
        }

        if ($null -eq $shouldThrow -or -not $shouldThrow) {
            # we are sure that we either:
            #    - should not throw because of explicit ErrorAction, and need to figure out a place where to collect the error
            #    - or we don't know what to do yet and need to figure out what to do based on the context and settings

            # first check if we are in the context of Pester, if not we will always throw:
            # this is slightly hacky, here we are reaching out the the caller session state and
            # look for $______parameters which we know we are using inside of the Pester runtime to
            # keep the current invocation context, when we find it, we are able to add non-terminating
            # errors without throwing and terminating the test
            $pesterRuntimeInvocationContext = $PSCmdlet.SessionState.PSVariable.GetValue('______parameters')
            $isInsidePesterRuntime = $null -ne $pesterRuntimeInvocationContext
            if (-not $isInsidePesterRuntime) {
                $shouldThrow = $true
            }
            else {
                if ($null -eq $shouldThrow) {
                    if ($null -ne $PSCmdlet.SessionState.PSVariable.GetValue('______isInMockParameterFilter')) {
                        $shouldThrow = $true
                    }
                    else {
                        # ErrorAction was not specified explicitly, figure out what to do from the configuration
                        $shouldThrow = 'Stop' -eq $pesterRuntimeInvocationContext.Configuration.Should.ErrorAction.Value
                    }
                }

                # here the $ShouldThrow is set from one of multiple places, either as override from -ErrorAction or
                # the settings, or based on the Pester runtime availability
                if (-not $shouldThrow) {
                    # call back into the context we grabbed from the runtime and add this error without throwing
                    $addErrorCallback = {
                        param($err)
                        $null = $pesterRuntimeInvocationContext.ErrorRecord.Add($err)
                    }
                }
            }
        }

        $assertionParams = @{
            AssertionEntry     = $entry
            BoundParameters    = $PSBoundParameters
            File               = $file
            LineNumber         = $lineNumber
            LineText           = $lineText
            Negate             = $negate
            CallerSessionState = $PSCmdlet.SessionState
            ShouldThrow        = $shouldThrow
            AddErrorCallback   = $addErrorCallback
        }

        if (-not $entry) { return }

        if ($inputArray.Count -eq 0) {
            Invoke-Assertion @assertionParams -ValueToTest $null
        }
        elseif ($entry.SupportsArrayInput) {
            Invoke-Assertion @assertionParams -ValueToTest $inputArray.ToArray()
        }
        else {
            foreach ($object in $inputArray) {
                Invoke-Assertion @assertionParams -ValueToTest $object
            }
        }
    }
}

function Invoke-Assertion {
    param (
        [Parameter(Mandatory)]
        [ValidateNotNull()]
        [object]
        $AssertionEntry,

        [Parameter(Mandatory)]
        [System.Collections.IDictionary]
        $BoundParameters,

        [string]
        $File,

        [Parameter(Mandatory)]
        [int]
        $LineNumber,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $LineText,

        [Parameter(Mandatory)]
        [Management.Automation.SessionState]
        $CallerSessionState,

        [Parameter()]
        [switch]
        $Negate,

        [Parameter()]
        [AllowNull()]
        [object]
        $ValueToTest,

        [Parameter()]
        [boolean]
        $ShouldThrow,

        [ScriptBlock]
        $AddErrorCallback
    )

    $testResult = & $AssertionEntry.Test -ActualValue $ValueToTest -Negate:$Negate -CallerSessionState $CallerSessionState @BoundParameters

    if (-not $testResult.Succeeded) {
        $errorRecord = [Pester.Factory]::CreateShouldErrorRecord($testResult.FailureMessage, $file, $lineNumber, $lineText, $shouldThrow, $testResult)

        if ($null -eq $AddErrorCallback -or $ShouldThrow) {
            # throw this error to fail the test immediately
            throw $errorRecord
        }

        try {
            # throw and catch to not fail the test, but still have stackTrace
            # alternatively we could call Get-PSStackTrace and format it ourselves
            # in case this turns out too be slow
            throw $errorRecord
        }
        catch {
            $err = $_
        }

        # collect the error via the provided callback
        & $AddErrorCallback $err
    }
    else {
        #extract data to return if there are any on the object
        $data = $testResult.psObject.Properties.Item('Data')
        if ($data) {
            $data.Value
        }
    }
}

function Format-Because ([string] $Because) {
    if ($null -eq $Because) {
        return
    }

    $bcs = $Because.Trim()
    if ([string]::IsNullOrEmpty($bcs)) {
        return
    }

    " because $($bcs -replace 'because\s'),"
}
# file src\functions\Context.ps1
function Context {
    <#
    .SYNOPSIS
    Provides logical grouping of It blocks within a single Describe block.

    .DESCRIPTION
    Provides logical grouping of It blocks within a single Describe block.
    Any Mocks defined inside a Context are removed at the end of the Context scope,
    as are any files or folders added to the TestDrive during the Context block's
    execution. Any BeforeEach or AfterEach blocks defined inside a Context also only
    apply to tests within that Context .

    .PARAMETER Name
    The name of the Context. This is a phrase describing a set of tests within a describe.

    .PARAMETER Tag
    Optional parameter containing an array of strings. When calling Invoke-Pester,
    it is possible to specify a -Tag parameter which will only execute Context blocks
    containing the same Tag.

    .PARAMETER Fixture
    Script that is executed. This may include setup specific to the context
    and one or more It blocks that validate the expected outcomes.

    .PARAMETER Skip
    Use this parameter to explicitly mark the block to be skipped. This is preferable to temporarily
    commenting out a block, because it remains listed in the output.

    .PARAMETER ForEach
    Allows data driven tests to be written.
    Takes an array of data and generates one block for each item in the array, and makes the item
    available as $_ in all child blocks. When the array is an array of hashtables, it additionally
    defines each key in the hashtable as variable.

    .EXAMPLE
    ```powershell
    BeforeAll {
        function Add-Numbers($a, $b) {
            return $a + $b
        }
    }

    Describe 'Add-Numbers' {
        Context 'when adding positive values' {
            It '...' {
                # ...
            }
        }

        Context 'when adding negative values' {
            It '...' {
                # ...
            }
            It '...' {
                # ...
            }
        }
    }
    ```

    Example of how to use Context for grouping different tests

    .LINK
    https://pester.dev/docs/v5/commands/Context

    .LINK
    https://pester.dev/docs/v5/usage/test-file-structure

    .LINK
    https://pester.dev/docs/v5/usage/mocking

    .LINK
    https://pester.dev/docs/v5/usage/testdrive
    #>
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string] $Name,

        [Alias('Tags')]
        [string[]] $Tag = @(),

        [Parameter(Position = 1)]
        [ValidateNotNull()]
        [ScriptBlock] $Fixture,

        # [Switch] $Focus,
        [Switch] $Skip,

        [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidAssignmentToAutomaticVariable', '', Justification = 'ForEach is not used in Foreach-Object loop')]
        $ForEach
    )

    $Focus = $false
    if ($Fixture -eq $null) {
        if ($Name.Contains("`n")) {
            throw "Test fixture name has multiple lines and no test fixture is provided. (Have you provided a name for the test group?)"
        }
        else {
            throw 'No test fixture is provided. (Have you put the open curly brace on the next line?)'
        }
    }

    if ($ExecutionContext.SessionState.PSVariable.Get('invokedViaInvokePester')) {
        if ($state.CurrentBlock.IsRoot -and -not $state.CurrentBlock.FrameworkData.MissingParametersProcessed) {
            # For undefined parameters in container, add parameter's default value to Data
            Add-MissingContainerParameters -RootBlock $state.CurrentBlock -Container $container -CallingFunction $PSCmdlet
        }

        if ($PSBoundParameters.ContainsKey('ForEach')) {
            if ($null -ne $ForEach -and 0 -lt @($ForEach).Count) {
                New-ParametrizedBlock -Name $Name -ScriptBlock $Fixture -StartLine $MyInvocation.ScriptLineNumber -StartColumn $MyInvocation.OffsetInLine -Tag $Tag -FrameworkData @{ CommandUsed = 'Context'; WrittenToScreen = $false } -Focus:$Focus -Skip:$Skip -Data $ForEach
            }
            else {
                # @() or $null is provided do nothing

            }
        }
        else {
            New-Block -Name $Name -ScriptBlock $Fixture -StartLine $MyInvocation.ScriptLineNumber -Tag $Tag -FrameworkData @{ CommandUsed = 'Context'; WrittenToScreen = $false } -Focus:$Focus -Skip:$Skip
        }
    }
    else {
        Invoke-Interactively -CommandUsed 'Context' -ScriptName $PSCmdlet.MyInvocation.ScriptName -SessionState $PSCmdlet.SessionState -BoundParameters $PSCmdlet.MyInvocation.BoundParameters
    }
}
# file src\functions\Coverage.Plugin.ps1
function Get-CoveragePlugin {
    # Validate configuration
    Resolve-CodeCoverageConfiguration

    $p = @{
        Name = 'Coverage'
    }

    $p.Start = {
        param($Context)

        $paths = @(if (0 -lt $PesterPreference.CodeCoverage.Path.Value.Count) {
                $PesterPreference.CodeCoverage.Path.Value
            }
            else {
                # no paths specific to CodeCoverage were provided, resolve them from
                # tests by using the whole directory in which the test or the
                # provided directory. We might need another option to disable this convention.
                @(foreach ($p in $PesterPreference.Run.Path.Value) {
                        # this is a bit ugly, but the logic here is
                        # that we check if the path exists,
                        # and if it does and is a file then we return the
                        # parent directory, otherwise we got a directory
                        # and return just it
                        $i = & $SafeCommands['Get-Item'] $p
                        if ($i.PSIsContainer) {
                            & $SafeCommands['Join-Path'] $i.FullName "*"
                        }
                        else {
                            & $SafeCommands['Join-Path'] $i.Directory.FullName "*"
                        }
                    })
            })

        $outputPath = if ([IO.Path]::IsPathRooted($PesterPreference.CodeCoverage.OutputPath.Value)) {
            $PesterPreference.CodeCoverage.OutputPath.Value
        }
        else {
            & $SafeCommands['Join-Path'] $pwd.Path $PesterPreference.CodeCoverage.OutputPath.Value
        }

        $CodeCoverage = @{
            Enabled                 = $PesterPreference.CodeCoverage.Enabled.Value
            OutputFormat            = $PesterPreference.CodeCoverage.OutputFormat.Value
            OutputPath              = $outputPath
            OutputEncoding          = $PesterPreference.CodeCoverage.OutputEncoding.Value
            ExcludeTests            = $PesterPreference.CodeCoverage.ExcludeTests.Value
            Path                    = @($paths)
            RecursePaths            = $PesterPreference.CodeCoverage.RecursePaths.Value
            TestExtension           = $PesterPreference.Run.TestExtension.Value
            UseSingleHitBreakpoints = $PesterPreference.CodeCoverage.SingleHitBreakpoints.Value
            UseBreakpoints          = $PesterPreference.CodeCoverage.UseBreakpoints.Value
        }

        # Save PluginConfiguration for Coverage
        $Context.Configuration['Coverage'] = $CodeCoverage
    }

    $p.RunStart = {
        param($Context)

        $sw = [System.Diagnostics.Stopwatch]::StartNew()
        $logger = if ($Context.WriteDebugMessages) {
            # return partially apply callback to the logger when the logging is enabled
            # or implicit null
            {
                param ($Message)
                & $Context.Write_PesterDebugMessage -Scope CodeCoverage -Message $Message
            }
        }

        if ($null -ne $logger) {
            & $logger "Starting code coverage."
        }

        if ($PesterPreference.Output.Verbosity.Value -ne "None") {
            Write-PesterHostMessage -ForegroundColor Magenta "Starting code coverage."
        }

        $config = $Context.Configuration['Coverage']

        if ($null -ne $logger) {
            & $logger "Config: $($config | & $script:SafeCommands['Out-String'])"
        }

        $breakpoints = Enter-CoverageAnalysis -CodeCoverage $config -Logger $logger -UseBreakpoints $config.UseBreakpoints -UseSingleHitBreakpoints $config.UseSingleHitBreakpoints

        $patched = $false
        if (-not $config.UseBreakpoints) {
            $patched, $tracer = Start-TraceScript $breakpoints
        }

        $Context.Data.Add('Coverage', @{
                CommandCoverage = $breakpoints
                # the tracer that was used for profiler based CC
                Tracer          = $tracer
                # if the tracer was patching the session, or if we just plugged in to an existing
                # profiler session, in case Profiler is profiling a Pester run that has Profiler based
                # CodeCoverage enabled
                Patched         = $patched
                CoverageReport  = $null
            })

        if ($PesterPreference.Output.Verbosity.Value -in "Detailed", "Diagnostic") {
            Write-PesterHostMessage -ForegroundColor Magenta "Code Coverage preparation finished after $($sw.ElapsedMilliseconds) ms."
        }
    }

    $p.RunEnd = {
        param($Context)

        $config = $Context.Configuration['Coverage']

        if (-not $Context.Data.ContainsKey("Coverage")) {
            return
        }

        $coverageData = $Context.Data.Coverage

        if (-not $config.UseBreakpoints) {
            Stop-TraceScript -Patched $coverageData.Patched
        }

        #TODO: rather check the config to see which mode of coverage we used
        if ($null -eq $coverageData.Tracer) {
            # we used breakpoints to measure CC, clean them up
            Exit-CoverageAnalysis -CommandCoverage $coverageData.CommandCoverage
        }
    }

    $p.End = {
        param($Context)

        $run = $Context.TestRun

        if ($PesterPreference.Output.Verbosity.Value -ne "None") {
            $sw = [Diagnostics.Stopwatch]::StartNew()
            Write-PesterHostMessage -ForegroundColor Magenta "Processing code coverage result."
        }

        $breakpoints = @($run.PluginData.Coverage.CommandCoverage)
        $measure = if (-not $PesterPreference.CodeCoverage.UseBreakpoints.Value) { @($run.PluginData.Coverage.Tracer.Hits) }
        $coverageReport = Get-CoverageReport -CommandCoverage $breakpoints -Measure $measure
        $totalMilliseconds = $run.Duration.TotalMilliseconds

        $configuration = $run.PluginConfiguration.Coverage

        $coverageXmlReport = switch ($configuration.OutputFormat) {
            'JaCoCo' { [xml](Get-JaCoCoReportXml -CommandCoverage $breakpoints -TotalMilliseconds $totalMilliseconds -CoverageReport $coverageReport -Format 'JaCoCo') }
            'CoverageGutters' { [xml](Get-JaCoCoReportXml -CommandCoverage $breakpoints -TotalMilliseconds $totalMilliseconds -CoverageReport $coverageReport -Format 'CoverageGutters') }
            'Cobertura' { [xml](Get-CoberturaReportXml -CoverageReport $coverageReport  -TotalMilliseconds $totalMilliseconds) }
            default { throw "CodeCoverage.CoverageFormat '$($configuration.OutputFormat)' is not valid, please review your configuration." }
        }

        $settings = [Xml.XmlWriterSettings] @{
            Indent              = $true
            NewLineOnAttributes = $false
        }

        $stringWriter = $null
        $xmlWriter = $null
        try {
            $stringWriter = [Pester.Factory]::CreateStringWriter()
            $xmlWriter = [Xml.XmlWriter]::Create($stringWriter, $settings)

            $coverageXmlReport.WriteContentTo($xmlWriter)

            $xmlWriter.Flush()
            $stringWriter.Flush()
        }
        finally {
            if ($null -ne $xmlWriter) {
                try {
                    $xmlWriter.Close()
                }
                catch {
                }
            }
            if ($null -ne $stringWriter) {
                try {
                    $stringWriter.Close()
                }
                catch {
                }
            }
        }

        $resolvedPath = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($PesterPreference.CodeCoverage.OutputPath.Value)
        if (-not (& $SafeCommands['Test-Path'] $resolvedPath)) {
            $dir = & $SafeCommands['Split-Path'] $resolvedPath
            $null = & $SafeCommands['New-Item'] $dir -Force -ItemType Container
        }

        $stringWriter.ToString() | & $SafeCommands['Out-File'] $resolvedPath -Encoding $PesterPreference.CodeCoverage.OutputEncoding.Value -Force
        if ($PesterPreference.Output.Verbosity.Value -in 'Detailed', 'Diagnostic') {
            Write-PesterHostMessage -ForegroundColor Magenta "Code Coverage result processed in $($sw.ElapsedMilliseconds) ms."
        }
        $reportText = Write-CoverageReport $coverageReport

        $coverage = [Pester.CodeCoverage]::Create()
        $coverage.CoverageReport = $reportText
        $coverage.CoveragePercent = $coverageReport.CoveragePercent
        $coverage.CommandsAnalyzedCount = $coverageReport.NumberOfCommandsAnalyzed
        $coverage.CommandsExecutedCount = $coverageReport.NumberOfCommandsExecuted
        $coverage.CommandsMissedCount = $coverageReport.NumberOfCommandsMissed
        $coverage.FilesAnalyzedCount = $coverageReport.NumberOfFilesAnalyzed
        $coverage.CommandsMissed = $coverageReport.MissedCommands
        $coverage.CommandsExecuted = $coverageReport.HitCommands
        $coverage.FilesAnalyzed = $coverageReport.AnalyzedFiles
        $coverage.CoveragePercentTarget = $PesterPreference.CodeCoverage.CoveragePercentTarget.Value

        $run.CodeCoverage = $coverage
    }

    New-PluginObject @p
}

function Resolve-CodeCoverageConfiguration {
    $supportedFormats = 'JaCoCo', 'CoverageGutters', 'Cobertura'
    if ($PesterPreference.CodeCoverage.OutputFormat.Value -notin $supportedFormats) {
        throw (Get-StringOptionErrorMessage -OptionPath 'CodeCoverage.OutputFormat' -SupportedValues $supportedFormats -Value $PesterPreference.CodeCoverage.OutputFormat.Value)
    }
}
# file src\functions\Coverage.ps1
function Enter-CoverageAnalysis {
    [CmdletBinding()]
    param (
        [object[]] $CodeCoverage,
        [ScriptBlock] $Logger,
        [bool] $UseSingleHitBreakpoints = $true,
        [bool] $UseBreakpoints = $true
    )

    if ($null -ne $logger) {
        & $logger "Figuring out breakpoint positions."
    }

    $sw = [System.Diagnostics.Stopwatch]::StartNew()
    $coverageInfo = foreach ($object in $CodeCoverage) {
        Get-CoverageInfoFromUserInput -InputObject $object -Logger $Logger
    }

    if ($null -eq $coverageInfo) {
        if ($null -ne $logger) {
            & $logger "No no files were found for coverage."
        }

        return @()
    }

    # breakpoints collection actually contains locations in script that are interesting,
    # not actual breakpoints
    $breakpoints = @(Get-CoverageBreakpoints -CoverageInfo $coverageInfo -Logger $Logger)
    if ($null -ne $logger) {
        & $logger "Figuring out $($breakpoints.Count) measurable code locations took $($sw.ElapsedMilliseconds) ms."
    }

    if ($UseBreakpoints) {
        if ($null -ne $logger) {
            & $logger "Using breakpoints for code coverage. Setting $($breakpoints.Count) breakpoints."
        }

        $action = if ($UseSingleHitBreakpoints) {
            # remove itself on hit scriptblock
            {

                if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                    $bp = Get-PSBreakpoint -Id $_.Id
                    & $SafeCommands["Write-PesterDebugMessage"] -Scope CodeCoverageCore -Message "Hit breakpoint $($bp.Id) on $($bp.Line):$($bp.Column) in $($bp.Script)."
                }

                & $SafeCommands['Remove-PSBreakpoint'] -Id $_.Id
            }
        }
        else {
            if ($null -ne $logger) {
                & $logger "Using normal breakpoints."
            }

            if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                # scriptblock with logging
                {
                    $bp = Get-PSBreakpoint -Id $_.Id
                    & $SafeCommands["Write-PesterDebugMessage"] -Scope CodeCoverageCore -Message "Hit breakpoint $($bp.Id) on $($bp.Line):$($bp.Column) in $($bp.Script)."
                }
            }
            else {
                # empty ScriptBlock
                {}
            }
        }

        foreach ($breakpoint in $breakpoints) {
            $params = $breakpoint.Breakpointlocation
            $params.Action = $action

            $breakpoint.Breakpoint = & $SafeCommands['Set-PSBreakpoint'] @params
        }

        $sw.Stop()

        if ($null -ne $logger) {
            & $logger "Setting $($breakpoints.Count) breakpoints took $($sw.ElapsedMilliseconds) ms."
        }
    }
    else {
        if ($null -ne $logger) {
            & $logger "Using Profiler based tracer for code coverage, not setting any breakpoints."
        }
    }

    return $breakpoints
}

function Exit-CoverageAnalysis {
    param ([object] $CommandCoverage)

    & $SafeCommands['Set-StrictMode'] -Off

    if ($null -ne $logger) {
        & $logger "Removing breakpoints."
    }

    $sw = [System.Diagnostics.Stopwatch]::StartNew()

    # PSScriptAnalyzer it will flag this line because $null is on the LHS of -ne.
    # BUT that is correct in this case. We are filtering the list of breakpoints
    # to only get those that are not $null
    # (like if we did $breakpoints | where {$_ -ne $null})
    # so DON'T change this.
    $breakpoints = @($CommandCoverage.Breakpoint) -ne $null
    if ($breakpoints.Count -gt 0) {
        & $SafeCommands['Remove-PSBreakpoint'] -Breakpoint $breakpoints
    }

    if ($null -ne $logger) {
        & $logger "Removing $($breakpoints.Count) breakpoints took $($sw.ElapsedMilliseconds) ms."
    }
}

function Get-CoverageInfoFromUserInput {
    param (
        [Parameter(Mandatory = $true)]
        [object]
        $InputObject,
        $Logger
    )

    if ($InputObject -is [System.Collections.IDictionary]) {
        $unresolvedCoverageInfo = Get-CoverageInfoFromDictionary -Dictionary $InputObject
    }
    else {
        $Path = $InputObject -as [string]

        # Auto-detect IncludeTests-value from path-input if user provides path that is a test
        $IncludeTests = $Path -like "*$($PesterPreference.Run.TestExtension.Value)"

        $unresolvedCoverageInfo = New-CoverageInfo -Path $Path -IncludeTests $IncludeTests -RecursePaths $PesterPreference.CodeCoverage.RecursePaths.Value
    }

    Resolve-CoverageInfo -UnresolvedCoverageInfo $unresolvedCoverageInfo
}

function New-CoverageInfo {
    param ($Path, [string] $Class = $null, [string] $Function = $null, [int] $StartLine = 0, [int] $EndLine = 0, [bool] $IncludeTests = $false, $RecursePaths = $true)

    return [pscustomobject]@{
        Path         = $Path
        Class        = $Class
        Function     = $Function
        StartLine    = $StartLine
        EndLine      = $EndLine
        IncludeTests = $IncludeTests
        RecursePaths = $RecursePaths
    }
}

function Get-CoverageInfoFromDictionary {
    param ([System.Collections.IDictionary] $Dictionary)

    $path = Get-DictionaryValueFromFirstKeyFound -Dictionary $Dictionary -Key 'Path', 'p'
    if ($null -eq $path -or 0 -ge @($path).Count) {
        throw "Coverage value '$($Dictionary | & $script:SafeCommands['Out-String'])' is missing required Path key."
    }

    $startLine = Get-DictionaryValueFromFirstKeyFound -Dictionary $Dictionary -Key 'StartLine', 'Start', 's'
    $endLine = Get-DictionaryValueFromFirstKeyFound -Dictionary $Dictionary -Key 'EndLine', 'End', 'e'
    [string] $class = Get-DictionaryValueFromFirstKeyFound -Dictionary $Dictionary -Key 'Class', 'c'
    [string] $function = Get-DictionaryValueFromFirstKeyFound -Dictionary $Dictionary -Key 'Function', 'f'
    $includeTests = Get-DictionaryValueFromFirstKeyFound -Dictionary $Dictionary -Key 'IncludeTests'
    $recursePaths = Get-DictionaryValueFromFirstKeyFound -Dictionary $Dictionary -Key 'RecursePaths'

    # TODO: Implement or remove the IDictionary config logic from CodeCoverage
    # Quick fix for https://github.com/pester/Pester/issues/2514 until CodeCoverage config logic is updated
    if ($null -eq $includeTests) { $includeTests = $PesterPreference.CodeCoverage.ExcludeTests.Value -ne $true }

    $startLine = Convert-UnknownValueToInt -Value $startLine -DefaultValue 0
    $endLine = Convert-UnknownValueToInt -Value $endLine -DefaultValue 0
    [bool] $includeTests = Convert-UnknownValueToInt -Value $includeTests -DefaultValue 0
    [bool] $recursePaths = Convert-UnknownValueToInt -Value $recursePaths -DefaultValue 1

    return New-CoverageInfo -Path $path -StartLine $startLine -EndLine $endLine -Class $class -Function $function -IncludeTests $includeTests -RecursePaths $recursePaths
}

function Convert-UnknownValueToInt {
    param ([object] $Value, [int] $DefaultValue = 0)

    try {
        return [int] $Value
    }
    catch {
        return $DefaultValue
    }
}

function Resolve-CoverageInfo {
    param ([psobject] $UnresolvedCoverageInfo)

    $paths = $UnresolvedCoverageInfo.Path
    $includeTests = $UnresolvedCoverageInfo.IncludeTests
    $recursePaths = $UnresolvedCoverageInfo.RecursePaths
    $resolvedPaths = @()

    try {
        $resolvedPaths = foreach ($path in $paths) {
            & $SafeCommands['Resolve-Path'] -Path $path -ErrorAction Stop
        }
    }
    catch {
        & $SafeCommands['Write-Error'] "Could not resolve coverage path '$path': $($_.Exception.Message)"
        return
    }

    $filePaths = Get-CodeCoverageFilePaths -Paths $resolvedPaths -IncludeTests $includeTests -RecursePaths $recursePaths

    $commonParams = @{
        StartLine = $UnresolvedCoverageInfo.StartLine
        EndLine   = $UnresolvedCoverageInfo.EndLine
        Class     = $UnresolvedCoverageInfo.Class
        Function  = $UnresolvedCoverageInfo.Function
    }

    foreach ($filePath in $filePaths) {
        New-CoverageInfo @commonParams -Path $filePath
    }
}

function Get-CodeCoverageFilePaths {
    param (
        [string[]]$Paths,
        [bool]$IncludeTests,
        [bool]$RecursePaths
    )

    $testsPattern = "*$($PesterPreference.Run.TestExtension.Value)"

    [string[]] $filteredFiles = @(foreach ($file in (& $SafeCommands['Get-ChildItem'] -LiteralPath $Paths -File -Recurse:$RecursePaths)) {
            if (('.ps1', '.psm1') -contains $file.Extension -and ($IncludeTests -or $file.Name -notlike $testsPattern)) {
                $file.FullName
            }
        })

    $uniqueFiles = & $SafeCommands['New-Object'] -TypeName 'System.Collections.Generic.HashSet[string]' -ArgumentList (, $filteredFiles)
    return $uniqueFiles
}

function Get-CoverageBreakpoints {
    [CmdletBinding()]
    param (
        [object[]] $CoverageInfo,
        [ScriptBlock]$Logger
    )

    $fileGroups = @($CoverageInfo | & $SafeCommands['Group-Object'] -Property Path)
    foreach ($fileGroup in $fileGroups) {
        if ($null -ne $Logger) {
            $sw = [System.Diagnostics.Stopwatch]::StartNew()
            & $Logger "Initializing code coverage analysis for file '$($fileGroup.Name)'"
        }
        $totalCommands = 0
        $analyzedCommands = 0

        :commandLoop
        foreach ($command in Get-CommandsInFile -Path $fileGroup.Name) {
            $totalCommands++

            foreach ($coverageInfoObject in $fileGroup.Group) {
                if (Test-CoverageOverlapsCommand -CoverageInfo $coverageInfoObject -Command $command) {
                    $analyzedCommands++
                    New-CoverageBreakpoint -Command $command
                    continue commandLoop
                }
            }
        }
        if ($null -ne $Logger) {
            & $Logger  "Analyzing $analyzedCommands of $totalCommands commands in file '$($fileGroup.Name)' for code coverage, in $($sw.ElapsedMilliseconds) ms"
        }
    }
}

function Get-CommandsInFile {
    param ([string] $Path)

    $errors = $null
    $tokens = $null
    $ast = [System.Management.Automation.Language.Parser]::ParseFile($Path, [ref] $tokens, [ref] $errors)

    if ($PSVersionTable.PSVersion.Major -ge 5) {
        # In PowerShell 5.0, dynamic keywords for DSC configurations are represented by the DynamicKeywordStatementAst
        # class.  They still trigger breakpoints, but are not a child class of CommandBaseAst anymore.

        $predicate = {
            $args[0] -is [System.Management.Automation.Language.DynamicKeywordStatementAst] -or
            $args[0] -is [System.Management.Automation.Language.CommandBaseAst]
        }
    }
    else {
        $predicate = { $args[0] -is [System.Management.Automation.Language.CommandBaseAst] }
    }

    $searchNestedScriptBlocks = $true
    $ast.FindAll($predicate, $searchNestedScriptBlocks)
}

function Test-CoverageOverlapsCommand {
    param ([object] $CoverageInfo, [System.Management.Automation.Language.Ast] $Command)

    if ($CoverageInfo.Class -or $CoverageInfo.Function) {
        Test-CommandInScope -Command $Command -Class $CoverageInfo.Class -Function $CoverageInfo.Function
    }
    else {
        Test-CoverageOverlapsCommandByLineNumber @PSBoundParameters
    }

}

function Test-CommandInScope {
    param ([System.Management.Automation.Language.Ast] $Command, [string] $Class, [string] $Function)

    $classResult = !$Class
    $functionResult = !$Function
    for ($ast = $Command; $null -ne $ast; $ast = $ast.Parent) {
        if (!$classResult -and $PSVersionTable.PSVersion.Major -ge 5) {
            # Classes have been introduced in PowerShell 5.0
            $classAst = $ast -as [System.Management.Automation.Language.TypeDefinitionAst]
            if ($null -ne $classAst -and $classAst.Name -like $Class) {
                $classResult = $true
            }
        }
        if (!$functionResult) {
            $functionAst = $ast -as [System.Management.Automation.Language.FunctionDefinitionAst]
            if ($null -ne $functionAst -and $functionAst.Name -like $Function) {
                $functionResult = $true
            }
        }
        if ($classResult -and $functionResult) {
            return $true
        }
    }

    return $false
}

function Test-CoverageOverlapsCommandByLineNumber {
    param ([object] $CoverageInfo, [System.Management.Automation.Language.Ast] $Command)

    $commandStart = $Command.Extent.StartLineNumber
    $commandEnd = $Command.Extent.EndLineNumber
    $coverStart = $CoverageInfo.StartLine
    $coverEnd = $CoverageInfo.EndLine

    # An EndLine value of 0 means to cover the entire rest of the file from StartLine
    # (which may also be 0)
    if ($coverEnd -le 0) {
        $coverEnd = [int]::MaxValue
    }

    return (Test-RangeContainsValue -Value $commandStart -Min $coverStart -Max $coverEnd) -or
    (Test-RangeContainsValue -Value $commandEnd -Min $coverStart -Max $coverEnd)
}

function Test-RangeContainsValue {
    param ([int] $Value, [int] $Min, [int] $Max)
    return $Value -ge $Min -and $Value -le $Max
}

function New-CoverageBreakpoint {
    param ([System.Management.Automation.Language.Ast] $Command)

    if (IsIgnoredCommand -Command $Command) {
        return
    }

    $params = @{
        Script = $Command.Extent.File
        Line   = $Command.Extent.StartLineNumber
        Column = $Command.Extent.StartColumnNumber
        # we write the breakpoint later, the action will become empty scriptblock
        # or scriptblock that removes the breakpoint on hit depending on configuration
        Action = $null
    }

    [pscustomobject] @{
        File               = $Command.Extent.File
        Class              = Get-ParentClassName -Ast $Command
        Function           = Get-ParentFunctionName -Ast $Command
        StartLine          = $Command.Extent.StartLineNumber
        EndLine            = $Command.Extent.EndLineNumber
        StartColumn        = $Command.Extent.StartColumnNumber
        EndColumn          = $Command.Extent.EndColumnNumber
        Command            = Get-CoverageCommandText -Ast $Command
        Ast                = $Command
        # keep property for breakpoint but we will set it later
        Breakpoint         = $null
        BreakpointLocation = $params
    }
}

Function Get-AstTopParent {
    param(
        [System.Management.Automation.Language.Ast] $Ast,
        [int] $MaxDepth = 30
    )

    if ([string]::IsNullOrEmpty($Ast.Parent)) {
        return $Ast
    }
    elseif ($MaxDepth -le 0) {
        & $SafeCommands['Write-Verbose'] "Max depth reached, moving on"
        return $null
    }
    else {
        $MaxDepth--
        Get-AstTopParent -Ast $Ast.Parent -MaxDepth $MaxDepth
    }
}

function IsIgnoredCommand {
    param ([System.Management.Automation.Language.Ast] $Command)

    if (-not $Command.Extent.File) {
        # This can happen if the script contains "configuration" or any similarly implemented
        # dynamic keyword.  PowerShell modifies the script code and reparses it in memory, leading
        # to AST elements with no File in their Extent.
        return $true
    }

    if ($PSVersionTable.PSVersion.Major -ge 4) {
        if ($Command.Extent.Text -eq 'Configuration') {
            # More DSC voodoo.  Calls to "configuration" generate breakpoints, but their HitCount
            # stays zero (even though they are executed.)  For now, ignore them, unless we can come
            # up with a better solution.
            return $true
        }

        if (IsChildOfHashtableDynamicKeyword -Command $Command) {
            # The lines inside DSC resource declarations don't trigger their breakpoints when executed,
            # just like the "configuration" keyword itself.  I don't know why, at this point, but just like
            # configuration, we'll ignore it so it doesn't clutter up the coverage analysis with useless junk.
            return $true
        }
    }

    if ($Command.Extent.Text -match '^{?& \$wrappedCmd @PSBoundParameters ?}?$' -and
        (Get-AstTopParent -Ast $Command) -like '*$steppablePipeline.Begin($PSCmdlet)*$steppablePipeline.Process($_)*$steppablePipeline.End()*' ) {
        # Fix for proxy function wrapped pipeline command. PowerShell does not increment the hit count when
        # these functions are executed using the steppable pipeline; further, these checks are redundant, as
        # all steppable pipeline constituents already get breakpoints set. This checks to ensure the top parent
        # node of the command contains all three constituents of the steppable pipeline before ignoring it.
        return $true
    }

    if (IsClosingLoopCondition -Command $Command) {
        # For some reason, the closing expressions of do/while and do/until loops don't trigger their breakpoints.
        # To avoid useless clutter, we'll ignore those lines as well.
        return $true
    }

    if ($PSVersionTable.PSVersion.Major -ge 5) {
        if ($Command -is [System.Management.Automation.Language.CommandExpressionAst] -and
            $Command.Expression[0] -is [System.Management.Automation.Language.BaseCtorInvokeMemberExpressionAst]) {
            # Calls to inherited "base(...)" constructor does not trigger breakpoint or tracer hit, ignore.
            return $true
        }
    }

    return $false
}

function IsChildOfHashtableDynamicKeyword {
    param ([System.Management.Automation.Language.Ast] $Command)

    for ($ast = $Command.Parent; $null -ne $ast; $ast = $ast.Parent) {
        if ($PSVersionTable.PSVersion.Major -ge 5) {
            # The ast behaves differently for DSC resources with version 5+.  There's a new DynamicKeywordStatementAst class,
            # and they no longer are represented by CommandAst objects.

            if ($ast -is [System.Management.Automation.Language.DynamicKeywordStatementAst] -and
                $ast.CommandElements[-1] -is [System.Management.Automation.Language.HashtableAst]) {
                return $true
            }
        }
        else {
            if ($ast -is [System.Management.Automation.Language.CommandAst] -and
                $null -ne $ast.DefiningKeyword -and
                $ast.DefiningKeyword.BodyMode -eq [System.Management.Automation.Language.DynamicKeywordBodyMode]::Hashtable) {
                return $true
            }
        }
    }

    return $false
}

function IsClosingLoopCondition {
    param ([System.Management.Automation.Language.Ast] $Command)

    $ast = $Command

    while ($null -ne $ast.Parent) {
        if (($ast.Parent -is [System.Management.Automation.Language.DoWhileStatementAst] -or
                $ast.Parent -is [System.Management.Automation.Language.DoUntilStatementAst]) -and
            $ast.Parent.Condition -eq $ast) {
            return $true
        }

        $ast = $ast.Parent
    }

    return $false
}

function Get-ParentClassName {
    param ([System.Management.Automation.Language.Ast] $Ast)

    if ($PSVersionTable.PSVersion.Major -ge 5) {
        # Classes have been introduced in PowerShell 5.0

        $parent = $Ast.Parent

        while ($null -ne $parent -and $parent -isnot [System.Management.Automation.Language.TypeDefinitionAst]) {
            $parent = $parent.Parent
        }
    }

    if ($null -eq $parent) {
        return ''
    }
    else {
        return $parent.Name
    }
}

function Get-ParentFunctionName {
    param ([System.Management.Automation.Language.Ast] $Ast)

    $parent = $Ast.Parent

    while ($null -ne $parent -and $parent -isnot [System.Management.Automation.Language.FunctionDefinitionAst]) {
        $parent = $parent.Parent
    }

    if ($null -eq $parent) {
        return ''
    }
    else {
        return $parent.Name
    }
}

function Get-CoverageCommandText {
    param ([System.Management.Automation.Language.Ast] $Ast)

    $reportParentExtentTypes = @(
        [System.Management.Automation.Language.ReturnStatementAst]
        [System.Management.Automation.Language.ThrowStatementAst]
        [System.Management.Automation.Language.AssignmentStatementAst]
        [System.Management.Automation.Language.IfStatementAst]
    )

    $parent = Get-ParentNonPipelineAst -Ast $Ast

    if ($null -ne $parent) {
        if ($parent -is [System.Management.Automation.Language.HashtableAst]) {
            return Get-KeyValuePairText -HashtableAst $parent -ChildAst $Ast
        }
        elseif ($reportParentExtentTypes -contains $parent.GetType()) {
            return $parent.Extent.Text
        }
    }

    return $Ast.Extent.Text
}

function Get-ParentNonPipelineAst {
    param ([System.Management.Automation.Language.Ast] $Ast)

    $parent = $null
    if ($null -ne $Ast) {
        $parent = $Ast.Parent
    }

    while ($parent -is [System.Management.Automation.Language.PipelineAst]) {
        $parent = $parent.Parent
    }

    return $parent
}

function Get-KeyValuePairText {
    param (
        [System.Management.Automation.Language.HashtableAst] $HashtableAst,
        [System.Management.Automation.Language.Ast] $ChildAst
    )

    & $SafeCommands['Set-StrictMode'] -Off

    foreach ($keyValuePair in $HashtableAst.KeyValuePairs) {
        if ($keyValuePair.Item2.PipelineElements -contains $ChildAst) {
            return '{0} = {1}' -f $keyValuePair.Item1.Extent.Text, $keyValuePair.Item2.Extent.Text
        }
    }

    # This shouldn't happen, but just in case, default to the old output of just the expression.
    return $ChildAst.Extent.Text
}

function Get-CoverageMissedCommands {
    param ([object[]] $CommandCoverage)
    $CommandCoverage | & $SafeCommands['Where-Object'] { $_.Breakpoint.HitCount -eq 0 }
}

function Get-CoverageHitCommands {
    param ([object[]] $CommandCoverage)
    $CommandCoverage | & $SafeCommands['Where-Object'] { $_.Breakpoint.HitCount -gt 0 }
}

function Merge-CommandCoverage {
    param ([object[]] $CommandCoverage)

    # todo: this is a quick implementation of merging lists of breakpoints together, this is needed
    # because the code coverage is stored per container and so in the end a lot of commands are missed
    # in the container while they are hit in other, what we want is to know how many of the commands were
    # hit in at least one file. This simple implementation does not add together the number of hits on each breakpoint
    # so the HitCommands is not accurate, it only keeps the first breakpoint that points to that command and it's hit count
    # this should be improved in the future.

    # todo: move this implementation to the calling function so we don't need to split and merge the collection twice and we
    # can also accumulate the hit count across the different breakpoints

    $hitBps = @{}
    $hits = [System.Collections.Generic.List[object]]@()
    foreach ($bp in $CommandCoverage) {
        if (0 -lt $bp.Breakpoint.HitCount) {
            $key = "$($bp.File):$($bp.StartLine):$($bp.StartColumn)"
            if (-not $hitBps.ContainsKey($key)) {
                # adding to a hashtable to make sure we can look up the keys quickly
                # and also to an array list to make sure we can later dump them in the correct order
                $hitBps.Add($key, $bp)
                $null = $hits.Add($bp)
            }
        }
    }

    $missedBps = @{}
    $misses = [System.Collections.Generic.List[object]]@()
    foreach ($bp in $CommandCoverage) {
        if (0 -eq $bp.Breakpoint.HitCount) {
            $key = "$($bp.File):$($bp.StartLine):$($bp.StartColumn)"
            if (-not $hitBps.ContainsKey($key)) {
                if (-not $missedBps.ContainsKey($key)) {
                    $missedBps.Add($key, $bp)
                    $null = $misses.Add($bp)
                }
            }
        }
    }

    # this is also not very efficient because in the next step we are splitting this collection again
    # into hit and missed breakpoints
    $c = $hits.GetEnumerator() + $misses.GetEnumerator()
    $c
}

function Get-CoverageReport {
    # make sure this is an array, otherwise the counts start failing
    # on powershell 3
    param ([object[]] $CommandCoverage, $Measure)

    # Measure is null when we used Breakpoints to do code coverage, otherwise it is populated with the measure
    if ($null -ne $Measure) {

        # re-key the measures to use columns that are corrected for BP placement
        # also 1 column in tracer can map to multiple columns for BP, when there are assignments, so expand them
        $bpm = @{}
        foreach ($path in $Measure.Keys) {
            $lines = @{}

            foreach ($line in $Measure[$path].Values) {
                foreach ($point in $line) {
                    $lines.Add("$($point.BpLine):$($point.BpColumn)", $point)
                }
            }

            $bpm.Add($path, $lines)
        }

        # adapting the data to the breakpoint like api we use for breakpoint based CC
        # so the rest of our code just works
        foreach ($i in $CommandCoverage) {
            # Write-Host "CC: $($i.File), $($i.StartLine), $($i.StartColumn)"
            $bp = @{ HitCount = 0 }
            if ($bpm.ContainsKey($i.File)) {
                $f = $bpm[$i.File]
                $key = "$($i.StartLine):$($i.StartColumn)"
                if ($f.ContainsKey($key)) {
                    $h = $f[$key]
                    $bp.HitCount = [int] $h.Hit
                }
            }

            $i.Breakpoint = $bp
        }
    }

    $properties = @(
        'File'
        @{ Name = 'Line'; Expression = { $_.StartLine } }
        'StartLine'
        'EndLine'
        'StartColumn'
        'EndColumn'
        'Class'
        'Function'
        'Command'
        @{ Name = 'HitCount'; Expression = { $_.Breakpoint.HitCount } }
    )

    $missedCommands = @(Get-CoverageMissedCommands -CommandCoverage @($CommandCoverage) | & $SafeCommands['Select-Object'] $properties)
    $hitCommands = @(Get-CoverageHitCommands -CommandCoverage @($CommandCoverage) | & $SafeCommands['Select-Object'] $properties)
    $analyzedFiles = @(@($CommandCoverage) | & $SafeCommands['Select-Object'] -ExpandProperty File -Unique)


    [pscustomobject] @{
        NumberOfCommandsAnalyzed = $CommandCoverage.Count
        NumberOfFilesAnalyzed    = $analyzedFiles.Count
        NumberOfCommandsExecuted = $hitCommands.Count
        NumberOfCommandsMissed   = $missedCommands.Count
        MissedCommands           = $missedCommands
        HitCommands              = $hitCommands
        AnalyzedFiles            = $analyzedFiles
        CoveragePercent          = if ($null -eq $CommandCoverage -or $CommandCoverage.Count -eq 0) { 0 } else { ($hitCommands.Count / $CommandCoverage.Count) * 100 }
    }
}

function Get-CommonParentPath {
    param ([string[]] $Path)

    if ("CoverageGutters" -eq $PesterPreference.CodeCoverage.OutputFormat.Value) {
        # for coverage gutters the root path is relative to the coverage.xml
        $fullPath = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($PesterPreference.CodeCoverage.OutputPath.Value)
        return (& $SafeCommands['Split-Path'] -Path $fullPath | Normalize-Path )
    }

    $pathsToTest = @(
        $Path |
            Normalize-Path |
            & $SafeCommands['Select-Object'] -Unique
    )

    if ($pathsToTest.Count -gt 0) {
        $parentPath = & $SafeCommands['Split-Path'] -Path $pathsToTest[0] -Parent

        while ($parentPath.Length -gt 0) {
            $nonMatches = $pathsToTest -notmatch "^$([regex]::Escape($parentPath))"

            if ($nonMatches.Count -eq 0) {
                return $parentPath
            }
            else {
                $parentPath = & $SafeCommands['Split-Path'] -Path $parentPath -Parent
            }
        }
    }

    return [string]::Empty
}

function Get-RelativePath {
    param ( [string] $Path, [string] $RelativeTo )
    return $Path -replace "^$([regex]::Escape("$RelativeTo$([System.IO.Path]::DirectorySeparatorChar)"))?"
}

function Normalize-Path {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [Alias('PSPath', 'FullName')]
        [string[]] $Path
    )

    # Split-Path and Join-Path will replace any AltDirectorySeparatorChar instances with the DirectorySeparatorChar
    # (Even if it's not the one that the split / join happens on.)  So splitting / rejoining a path will give us
    # consistent separators for later string comparison.

    process {
        if ($null -ne $Path) {
            foreach ($p in $Path) {
                $normalizedPath = & $SafeCommands['Split-Path'] $p -Leaf

                if ($normalizedPath -ne $p) {
                    $parent = & $SafeCommands['Split-Path'] $p -Parent
                    $normalizedPath = & $SafeCommands['Join-Path'] $parent $normalizedPath
                }

                $normalizedPath
            }
        }
    }
}

function Get-JaCoCoReportXml {
    param (
        [parameter(Mandatory = $true)]
        $CommandCoverage,
        [parameter(Mandatory = $true)]
        [object] $CoverageReport,
        [parameter(Mandatory = $true)]
        [long] $TotalMilliseconds,
        [string] $Format
    )

    $isGutters = "CoverageGutters" -eq $Format

    if ($null -eq $CoverageReport -or ($pester.Show -eq [Pester.OutputTypes]::None) -or $CoverageReport.NumberOfCommandsAnalyzed -eq 0) {
        return [string]::Empty
    }

    # Report uses unix epoch time format (milliseconds since midnight 1/1/1970 UTC)
    $nineteenSeventy = & $SafeCommands['New-Object'] 'System.DateTime' -ArgumentList @(1970, 1, 1, 0, 0, 0, [System.DateTimeKind]::Utc)
    $now = [DateTime]::Now.ToUniversalTime()
    [long] $endTime = [math]::Floor(($now - $nineteenSeventy).TotalMilliseconds)
    [long] $startTime = [math]::Floor($endTime - $TotalMilliseconds)

    $folderGroups = $CommandCoverage | & $SafeCommands["Group-Object"] -Property {
        & $SafeCommands["Split-Path"] $_.File -Parent
    }

    $packageList = [System.Collections.Generic.List[psobject]]@()

    $report = @{
        Instruction = @{ Missed = 0; Covered = 0 }
        Line        = @{ Missed = 0; Covered = 0 }
        Method      = @{ Missed = 0; Covered = 0 }
        Class       = @{ Missed = 0; Covered = 0 }
    }

    foreach ($folderGroup in $folderGroups) {

        $package = @{
            Name        = $folderGroup.Name
            Classes     = [ordered] @{ }
            Instruction = @{ Missed = 0; Covered = 0 }
            Line        = @{ Missed = 0; Covered = 0 }
            Method      = @{ Missed = 0; Covered = 0 }
            Class       = @{ Missed = 0; Covered = 0 }
        }

        foreach ($command in $folderGroup.Group) {
            $file = $command.File
            $function = $command.Function
            if (!$function) { $function = '<script>' }
            $line = $command.StartLine.ToString()

            $missed = if ($command.Breakpoint.HitCount) { 0 } else { 1 }
            $covered = if ($command.Breakpoint.HitCount) { 1 } else { 0 }

            if (!$package.Classes.Contains($file)) {
                $package.Class.Missed += $missed
                $package.Class.Covered += $covered
                $package.Classes.$file = @{
                    Methods     = [ordered] @{ }
                    Lines       = [ordered] @{ }
                    Instruction = @{ Missed = 0; Covered = 0 }
                    Line        = @{ Missed = 0; Covered = 0 }
                    Method      = @{ Missed = 0; Covered = 0 }
                    Class       = @{ Missed = $missed; Covered = $covered }
                }
            }

            if (!$package.Classes.$file.Methods.Contains($function)) {
                $package.Method.Missed += $missed
                $package.Method.Covered += $covered
                $package.Classes.$file.Method.Missed += $missed
                $package.Classes.$file.Method.Covered += $covered
                $package.Classes.$file.Methods.$function = @{
                    FirstLine   = $line
                    Instruction = @{ Missed = 0; Covered = 0 }
                    Line        = @{ Missed = 0; Covered = 0 }
                    Method      = @{ Missed = $missed; Covered = $covered }
                }
            }

            if (!$package.Classes.$file.Lines.Contains($line)) {
                $package.Line.Missed += $missed
                $package.Line.Covered += $covered
                $package.Classes.$file.Line.Missed += $missed
                $package.Classes.$file.Line.Covered += $covered
                $package.Classes.$file.Methods.$function.Line.Missed += $missed
                $package.Classes.$file.Methods.$function.Line.Covered += $covered
                $package.Classes.$file.Lines.$line = @{
                    Instruction = @{ Missed = 0; Covered = 0 }
                }
            }

            $package.Instruction.Missed += $missed
            $package.Instruction.Covered += $covered
            $package.Classes.$file.Instruction.Missed += $missed
            $package.Classes.$file.Instruction.Covered += $covered
            $package.Classes.$file.Methods.$function.Instruction.Missed += $missed
            $package.Classes.$file.Methods.$function.Instruction.Covered += $covered
            $package.Classes.$file.Lines.$line.Instruction.Missed += $missed
            $package.Classes.$file.Lines.$line.Instruction.Covered += $covered
        }

        $report.Class.Missed += $package.Class.Missed
        $report.Class.Covered += $package.Class.Covered
        $report.Method.Missed += $package.Method.Missed
        $report.Method.Covered += $package.Method.Covered
        $report.Line.Missed += $package.Line.Missed
        $report.Line.Covered += $package.Line.Covered
        $report.Instruction.Missed += $package.Instruction.Missed
        $report.Instruction.Covered += $package.Instruction.Covered

        $packageList.Add($package)
    }

    $commonParent = Get-CommonParentPath -Path $CoverageReport.AnalyzedFiles
    $commonParentLeaf = & $SafeCommands["Split-Path"] $commonParent -Leaf

    # the JaCoCo xml format without the doctype, as the XML stuff does not like DTD's.
    $jaCoCoReport = '<?xml version="1.0" encoding="UTF-8" standalone="no"?>'
    $jaCoCoReport += '<report name="">'
    $jaCoCoReport += '<sessioninfo id="this" start="" dump="" />'
    $jaCoCoReport += '</report>'

    [xml] $jaCoCoReportXml = $jaCoCoReport
    $reportElement = $jaCoCoReportXml.report
    $reportElement.name = "Pester ($now)"
    $reportElement.sessioninfo.start = $startTime.ToString()
    $reportElement.sessioninfo.dump = $endTime.ToString()

    foreach ($package in $packageList) {
        $packageRelativePath = Get-RelativePath -Path $package.Name -RelativeTo $commonParent

        # e.g. "." for gutters, and "package" for non gutters in root
        # and "sub-dir" for gutters, and "package/sub-dir" for non-gutters
        $packageName = if ($null -eq $packageRelativePath -or "" -eq $packageRelativePath) {
            if ($isGutters) {
                "."
            }
            else {
                $commonParentLeaf
            }
        }
        else {
            $packageRelativePathFormatted = $packageRelativePath.Replace("\", "/")
            if ($isGutters) {
                $packageRelativePathFormatted
            }
            else {
                "$commonParentLeaf/$packageRelativePathFormatted"
            }
        }

        $packageElement = Add-XmlElement -Parent $reportElement -Name 'package' -Attributes @{
            name = ($packageName -replace "/$", "")
        }

        foreach ($file in $package.Classes.Keys) {
            $class = $package.Classes.$file
            $classElementRelativePath = (Get-RelativePath -Path $file -RelativeTo $commonParent).Replace("\", "/")
            $classElementName = if ($isGutters) {
                $classElementRelativePath
            }
            else {
                "$commonParentLeaf/$classElementRelativePath"
            }
            $classElementName = $classElementName.Substring(0, $($classElementName.LastIndexOf(".")))
            $classElement = Add-XmlElement -Parent $packageElement -Name 'class' -Attributes ([ordered] @{
                    name           = $classElementName
                    sourcefilename = if ($isGutters) {
                        & $SafeCommands["Split-Path"] $classElementRelativePath -Leaf
                    }
                    else {
                        $classElementRelativePath
                    }
                })

            foreach ($function in $class.Methods.Keys) {
                $method = $class.Methods.$function
                $methodElement = Add-XmlElement -Parent $classElement -Name 'method' -Attributes ([ordered] @{
                        name = $function
                        desc = '()'
                        line = $method.FirstLine
                    })
                Add-JaCoCoCounter -Type 'Instruction' -Data $method -Parent $methodElement
                Add-JaCoCoCounter -Type 'Line' -Data $method -Parent $methodElement
                Add-JaCoCoCounter -Type 'Method' -Data $method -Parent $methodElement
            }

            Add-JaCoCoCounter -Type 'Instruction' -Data $class -Parent $classElement
            Add-JaCoCoCounter -Type 'Line' -Data $class -Parent $classElement
            Add-JaCoCoCounter -Type 'Method' -Data $class -Parent $classElement
            Add-JaCoCoCounter -Type 'Class' -Data $class -Parent $classElement
        }

        foreach ($file in $package.Classes.Keys) {
            $class = $package.Classes.$file
            $classElementRelativePath = (Get-RelativePath -Path $file -RelativeTo $commonParent).Replace("\", "/")
            $sourceFileElement = Add-XmlElement -Parent $packageElement -Name 'sourcefile' -Attributes ([ordered] @{
                    name = if ($isGutters) {
                        & $SafeCommands["Split-Path"] $classElementRelativePath -Leaf
                    }
                    else {
                        $classElementRelativePath
                    }
                })

            foreach ($line in $class.Lines.Keys) {
                $null = Add-XmlElement -Parent $sourceFileElement -Name 'line' -Attributes ([ordered] @{
                        nr = $line
                        mi = $class.Lines.$line.Instruction.Missed
                        ci = $class.Lines.$line.Instruction.Covered
                        mb = 0
                        cb = 0
                    })
            }

            Add-JaCoCoCounter -Type 'Instruction' -Data $class -Parent $sourceFileElement
            Add-JaCoCoCounter -Type 'Line' -Data $class -Parent $sourceFileElement
            Add-JaCoCoCounter -Type 'Method' -Data $class -Parent $sourceFileElement
            Add-JaCoCoCounter -Type 'Class' -Data $class -Parent $sourceFileElement
        }

        Add-JaCoCoCounter -Type 'Instruction' -Data $package -Parent $packageElement
        Add-JaCoCoCounter -Type 'Line' -Data $package -Parent $packageElement
        Add-JaCoCoCounter -Type 'Method' -Data $package -Parent $packageElement
        Add-JaCoCoCounter -Type 'Class' -Data $package -Parent $packageElement
    }

    Add-JaCoCoCounter -Type 'Instruction' -Data $report -Parent $reportElement
    Add-JaCoCoCounter -Type 'Line' -Data $report -Parent $reportElement
    Add-JaCoCoCounter -Type 'Method' -Data $report -Parent $reportElement
    Add-JaCoCoCounter -Type 'Class' -Data $report -Parent $reportElement

    # There is no pretty way to insert the Doctype, as microsoft has deprecated the DTD stuff.
    $jaCoCoReportDocType = '<!DOCTYPE report PUBLIC "-//JACOCO//DTD Report 1.1//EN" "report.dtd">'
    $xml = $jaCocoReportXml.OuterXml.Insert(54, $jaCoCoReportDocType)

    return $xml
}

function Get-CoberturaReportXml {
    param (
        [parameter(Mandatory = $true)]
        [object] $CoverageReport,
        [parameter(Mandatory = $true)]
        [long] $TotalMilliseconds
    )

    if ($null -eq $CoverageReport -or $CoverageReport.NumberOfCommandsAnalyzed -eq 0) {
        return [string]::Empty
    }

    # Report uses unix epoch time format (milliseconds since midnight 1/1/1970 UTC)
    $nineteenSeventy = & $SafeCommands['New-Object'] 'System.DateTime' -ArgumentList @(1970, 1, 1, 0, 0, 0, [System.DateTimeKind]::Utc)
    $now = [DateTime]::Now.ToUniversalTime()
    [long] $endTime = [math]::Floor(($now - $nineteenSeventy).TotalMilliseconds)
    [long] $startTime = [math]::Floor($endTime - $TotalMilliseconds)

    $commonRoot = Get-CommonParentPath -Path $CoverageReport.AnalyzedFiles

    $allLines = [System.Collections.Generic.List[object]]@()
    $allLines.AddRange($CoverageReport.MissedCommands)
    $allLines.AddRange($CoverageReport.HitCommands)
    $packages = @{}
    foreach ($command in $allLines) {
        $package = & $SafeCommands["Split-Path"] $command.File -Parent
        if (!$packages[$package]) {
            $packages[$package] = @{
                Classes = @{}
            }
        }

        $class = $command.File
        if (!$packages[$package].Classes[$class]) {
            $packages[$package].Classes[$class] = @{
                Methods = @{}
                Lines   = @{}
            }
        }

        if (!$packages[$package].Classes[$class].Lines[$command.Line]) {
            $packages[$package].Classes[$class].Lines[$command.Line] = [ordered]@{ number = $command.Line ; hits = 0 }
        }
        $packages[$package].Classes[$class].Lines[$command.Line].hits += $command.HitCount

        $method = $command.Function
        if (!$method) {
            continue
        }

        if (!$packages[$package].Classes[$class].Methods[$method]) {
            $packages[$package].Classes[$class].Methods[$method] = @{}
        }

        if (!$packages[$package].Classes[$class].Methods[$method][$command.Line]) {
            $packages[$package].Classes[$class].Methods[$method][$command.Line] = [ordered]@{ number = $command.Line ; hits = 0 }
        }
        $packages[$package].Classes[$class].Methods[$method][$command.Line].hits += $command.HitCount
    }

    $packages = foreach ($packageGroup in $packages.GetEnumerator()) {
        $classGroups = $packageGroup.Value.Classes
        $classes = foreach ($classGroup in $classGroups.GetEnumerator()) {
            $methodGroups = $classGroup.Value.Methods
            $methods = foreach ($methodGroup in $methodGroups.GetEnumerator()) {
                $lines = ([object[]]$methodGroup.Value.Values) | New-LineNode
                $coveredLines = foreach ($line in $lines) { if (0 -lt $line.attributes.hits) { $line } }

                $method = [ordered]@{
                    name         = 'method'
                    attributes   = [ordered]@{
                        name      = $methodGroup.Name
                        signature = '()'
                    }
                    children     = [ordered]@{
                        lines = $lines | & $SafeCommands["Sort-Object"] { [int]$_.attributes.number }
                    }
                    totalLines   = $lines.Length
                    coveredLines = $coveredLines.Length
                }

                $method
            }

            $lines = ([object[]]$classGroup.Value.Lines.Values) | New-LineNode
            $coveredLines = foreach ($line in $lines) { if (0 -lt $line.attributes.hits) { $line } }

            $lineRate = Get-LineRate -CoveredLines $coveredLines.Length -TotalLines $lines.Length
            $filename = $classGroup.Name.Substring($commonRoot.Length).Replace('\', '/').TrimStart('/')

            $class = [ordered]@{
                name         = 'class'
                attributes   = [ordered]@{
                    name          = (& $SafeCommands["Split-Path"] $classGroup.Name -Leaf)
                    filename      = $filename
                    'line-rate'   = $lineRate
                    'branch-rate' = 1
                }
                children     = [ordered]@{
                    methods = $methods | & $SafeCommands["Sort-Object"] { $_.attributes.name }
                    lines   = $lines | & $SafeCommands["Sort-Object"] { [int]$_.attributes.number }
                }
                totalLines   = $lines.Length
                coveredLines = $coveredLines.Length
            }

            $class
        }

        $totalLines = ($classes.totalLines | & $SafeCommands["Measure-Object"] -Sum).Sum
        $coveredLines = ($classes.coveredLines | & $SafeCommands["Measure-Object"] -Sum).Sum
        $lineRate = Get-LineRate -CoveredLines $coveredLines -TotalLines $totalLines
        $packageName = $packageGroup.Name.Substring($commonRoot.Length).Replace('\', '/').TrimStart('/')

        $package = [ordered]@{
            name         = 'package'
            attributes   = [ordered]@{
                name          = $packageName
                'line-rate'   = $lineRate
                'branch-rate' = 0
            }
            children     = [ordered]@{
                classes = $classes | & $SafeCommands["Sort-Object"] { $_.attributes.name }
            }
            totalLines   = $totalLines
            coveredLines = $coveredLines
        }

        $package
    }

    $totalLines = ($packages.totalLines | & $SafeCommands["Measure-Object"] -Sum).Sum
    $coveredLines = ($packages.coveredLines | & $SafeCommands["Measure-Object"] -Sum).Sum
    $lineRate = Get-LineRate -CoveredLines $coveredLines -TotalLines $totalLines

    $coverage = [ordered]@{
        name       = 'coverage'
        attributes = [ordered]@{
            'lines-valid'      = $totalLines
            'lines-covered'    = $coveredLines
            'line-rate'        = $lineRate
            'branches-valid'   = 0
            'branches-covered' = 0
            'branch-rate'      = 1
            timestamp          = $startTime
            version            = 0.1
        }
        children   = [ordered]@{
            sources  = [ordered]@{
                name  = 'source'
                value = $commonRoot.Replace('\', '/')
            }
            packages = $packages | & $SafeCommands["Sort-Object"] { $_.attributes.name }
        }
    }

    $xmlDeclaration = '<?xml version="1.0" ?>'
    $docType = '<!DOCTYPE coverage SYSTEM "coverage-loose.dtd">'
    $coverageXml = ConvertTo-XmlElement -Node $coverage
    $document = "$xmlDeclaration`n$docType`n$($coverageXml.OuterXml)"

    $document
}

function New-LineNode {
    param(
        [parameter(Mandatory = $true, ValueFromPipeline = $true)] [object] $LineObject
    )

    process {
        [ordered]@{
            name       = 'line'
            attributes = $LineObject
        }
    }
}

function Get-LineRate {
    param(
        [parameter(Mandatory = $true)] [int] $CoveredLines,
        [parameter(Mandatory = $true)] [int] $TotalLines
    )

    [double]$denominator = if ($TotalLines) { $TotalLines } else { 1 }

    $CoveredLines / $denominator
}

function ConvertTo-XmlElement {
    param(
        [parameter(Mandatory = $true)] [object] $Node
    )

    $element = ([xml]"<$($Node.name)/>").DocumentElement
    if ($node.attributes) {
        $attributes = $node.attributes
        foreach ($attr in $attributes.GetEnumerator()) {
            $element.SetAttribute($attr.Name, $attr.Value)
        }
    }
    if ($node.children) {
        $children = $node.children
        foreach ($child in $children.GetEnumerator()) {
            $childElement = ([xml]"<$($child.Name)/>").DocumentElement
            foreach ($value in $child.Value) {
                $childXml = ConvertTo-XmlElement $value
                $importedChildXml = $childElement.OwnerDocument.ImportNode($childXml, $true)
                $null = $childElement.AppendChild($importedChildXml)
            }
            $importedChild = $element.OwnerDocument.ImportNode($childElement, $true)
            $null = $element.AppendChild($importedChild)
        }
    }
    if ($node.value) {
        $element.InnerText = $node.value
    }

    $element
}

function Add-XmlElement {
    param (
        [parameter(Mandatory = $true)] [System.Xml.XmlNode] $Parent,
        [parameter(Mandatory = $true)] [string] $Name,
        [System.Collections.IDictionary] $Attributes
    )
    $element = $Parent.AppendChild($Parent.OwnerDocument.CreateElement($Name))
    if ($Attributes) {
        Add-XmlAttribute -Element $element -Attributes $Attributes
    }
    return $element
}

function Add-XmlAttribute {
    param(
        [parameter(Mandatory = $true)] [System.Xml.XmlNode] $Element,
        [parameter(Mandatory = $true)] [System.Collections.IDictionary] $Attributes
    )

    foreach ($key in $Attributes.Keys) {
        $attribute = $Element.Attributes.Append($Element.OwnerDocument.CreateAttribute($key))
        $attribute.Value = $Attributes.$key
    }
}

function Add-JaCoCoCounter {
    param (
        [parameter(Mandatory = $true)] [ValidateSet('Instruction', 'Line', 'Method', 'Class')] [string] $Type,
        [parameter(Mandatory = $true)] [System.Collections.IDictionary] $Data,
        [parameter(Mandatory = $true)] [System.Xml.XmlNode] $Parent
    )
    if ($Data.$Type.Missed -isnot [int] -or $Data.$Type.Covered -isnot [int]) {
        throw 'Counter data expected'
    }
    $null = Add-XmlElement -Parent $Parent -Name 'counter' -Attributes ([ordered] @{
            type    = $Type.ToUpperInvariant()
            missed  = $Data.$Type.Missed
            covered = $Data.$Type.Covered
        })
}

function Start-TraceScript ($Breakpoints) {

    $points = [Collections.Generic.List[Pester.Tracing.CodeCoveragePoint]]@()
    foreach ($breakpoint in $breakpoints) {
        $location = $breakpoint.BreakpointLocation

        $hitColumn = $location.Column
        $hitLine = $location.Line

        # breakpoints for some actions bind to different column than the hits, we need to adjust them
        # for example when code contains hashtable we need to translate it,
        # because we are reporting the place where BP would bind, but from the tracer we are getting the whole hashtable
        # this often changes not only the column but also the line where we record the hit, so there can be many
        # points pointed at the same location
        $parent = Get-TracerHitLocation $breakpoint.Ast

        if ($parent -is [System.Management.Automation.Language.ReturnStatementAst]) {
            $hitLine = $parent.Extent.StartLineNumber
            $hitColumn = $parent.Extent.StartColumnNumber + 7 # offset by the length of 'return '
        }
        else {
            $hitLine = $parent.Extent.StartLineNumber
            $hitColumn = $parent.Extent.StartColumnNumber
        }

        $points.Add([Pester.Tracing.CodeCoveragePoint]::Create($location.Script, $hitLine, $hitColumn, $location.Line, $location.Column, $breakpoint.Command))
    }

    $tracer = [Pester.Tracing.CodeCoverageTracer]::Create($points)

    # detect if profiler is imported and running and in that case just add us as a second tracer
    # to not disturb the profiling session
    $profilerType = "Profiler.Tracer" -as [Type]
    $registered = $false
    $patched = $false

    if ($null -ne $profilerType) {
        # api changed in 4.0.0
        $version = [Version] (& $SafeCommands['Get-Item'] $profilerType.Assembly.Location).VersionInfo.FileVersion
        if (($version -lt "4.0.0" -and $profilerType::IsEnabled) -or ($version -ge "4.0.0" -and $profilerType::ShouldRegisterTracer($tracer, $true))) {
            $patched = $false
            $registered = $true
            $profilerType::Register($tracer)
        }
    }

    if (-not $registered) {
        $patched = $true
        [Pester.Tracing.Tracer]::Patch($PSVersionTable.PSVersion.Major, $ExecutionContext, $host.UI, $tracer)
        Set-PSDebug -Trace 1
    }

    # true if we patched powershell and have to unpatch it later,
    # false if we just registered to already running profiling session and just need to unregister ourselves
    $patched, $tracer
}

function Stop-TraceScript {
    param ([bool] $Patched)

    # if profiler is imported and running and in that case just remove us as a second tracer
    # to not disturb the profiling session
    if ($Patched) {
        Set-PSDebug -Trace 0
        [Pester.Tracing.Tracer]::Unpatch()
    }
    else {
        $profilerType = "Profiler.Tracer" -as [Type]
        $profilerType::Unregister()
    }
}

function Get-TracerHitLocation ($command) {

    if (-not $env:PESTER_CC_DEBUG) {
        function Write-Host { }
    }
    # function Write-Host { }
    function Show-ParentList ($command) {
        $c = $command
        "`n`nCommand: $c" | Write-Host
        $(for ($ast = $c; $null -ne $ast; $ast = $ast.Parent) {
                $ast | Select-Object @{n = 'type'; e = { $_.GetType().Name } } , @{n = 'extent'; e = { $_.extent } }
            } ) | Format-Table type, extent | Out-String | Write-Host
    }

    if ($env:PESTER_CC_DEBUG -eq 1) {
        Write-Host "Processing '$command' at $($command.Extent.StartLineNumber):$($command.Extent.StartColumnNumber) which is $($command.GetType().Name)."
    }

    #    Show-ParentList $command
    $parent = $command
    $last = $parent
    while ($true) {

        # take
        if ($parent -is [System.Management.Automation.Language.CommandAst]) {
            # using pipeline ast for command correctly identifies it's pipeline location so we get foreach-object and similar commands
            # correctly in actual pipeline. We keep this as the $last. This will "incorrectly" hoist commands to their containing arrays
            # or hashtable even though we see them as separate in the tracer. This is okay, because the command would be invoked anyway
            # and we don't have to work hard to figure out if command is just standalone (e.g Get-Command in a pipeline), or part of pipeline
            # e.g. @(10) | ForEach-Object { "b" } where ForEach-Object will bind to the whole pipeline expression.
            $last = $parent.Parent
        }
        elseif ($parent -isnot [System.Management.Automation.Language.CommandExpressionAst] -or $parent.Expression -isnot [System.Management.Automation.Language.ConstantExpressionAst]) {
            # the current item is not a constant expression make it the new $last
            $last = $parent

        }

        if ($null -eq $parent) {
            # parent is null, we reached the end, use the last identified item as the hit location
            break
        }

        # we now know that we have a parent move one level up to look at it to see if we should search further, or we are child of a termination point (like if, or scriptblock)
        $parent = $parent.Parent

        # skip to avoid using the pipeline ast as the $last to not break if block statements, because we would get the whole { } instead of just the actual command
        # e.g. in if ($true) { "yes" } else { "no" } we would incorrectly get { "yes" } instead of just "yes"
        while ($parent -is [System.Management.Automation.Language.PipelineAst] -or $parent -is [System.Management.Automation.Language.NamedBlockAst] -or $parent -is [System.Management.Automation.Language.StatementBlockAst]) {
            $parent = $parent.Parent
        }

        # terminate when we find and if of scriptblock, those will always show up in the tracer if they are executed so they are are good termination point.
        # when a hitpoint is found, the $last is marked as hit point.
        # we also must avoid selecting a parent that is too high, otherwise we might mark code that was not covered as covered.
        if ($parent -is [System.Management.Automation.Language.IfStatementAst] -or
            $parent -is [System.Management.Automation.Language.ScriptBlockAst] -or
            $parent -is [System.Management.Automation.Language.LoopStatementAst] -or
            $parent -is [System.Management.Automation.Language.SwitchStatementAst] -or
            $parent -is [System.Management.Automation.Language.TryStatementAst] -or
            $parent -is [System.Management.Automation.Language.CatchClauseAst]) {

            if ($last -is [System.Management.Automation.Language.ParamBlockAst]) {
                # param block will not indicate that any of the default values in it executed,
                # and the block itself is not reported by the tracer. So we will land here with the parame block as the $last
                # and we need to take the containing scriptblock (be it actual scriptblock, or a function definition), which is the parent
                # of this param block.
                $last = $parent
            }

            break
        }
    }
    if ($env:PESTER_CC_DEBUG -eq 1) {
        Write-Host "It became: '$last' at $($last.Extent.StartLineNumber):$($last.Extent.StartColumnNumber) which is $($last.GetType().Name)."
    }
    return $last
}
# file src\functions\Describe.ps1
function Describe {
    <#
    .SYNOPSIS
    Creates a logical group of tests.

    .DESCRIPTION
    Creates a logical group of tests. All Mocks, TestDrive and TestRegistry contents
    defined within a Describe block are scoped to that Describe; they
    will no longer be present when the Describe block exits.  A Describe
    block may contain any number of Context and It blocks.

    .PARAMETER Name
    The name of the test group. This is often an expressive phrase describing
    the scenario being tested.

    .PARAMETER Fixture
    The actual test script. If you are following the AAA pattern (Arrange-Act-Assert),
    this typically holds the arrange and act sections. The Asserts will also lie
    in this block but are typically nested each in its own It block. Assertions are
    typically performed by the Should command within the It blocks.

    .PARAMETER Tag
    Optional parameter containing an array of strings. When calling Invoke-Pester,
    it is possible to specify a -Tag parameter which will only execute Describe blocks
    containing the same Tag.

    .PARAMETER Skip
    Use this parameter to explicitly mark the block to be skipped. This is preferable to temporarily
    commenting out a block, because it remains listed in the output.

    .PARAMETER ForEach
    Allows data driven tests to be written.
    Takes an array of data and generates one block for each item in the array, and makes the item
    available as $_ in all child blocks. When the array is an array of hashtables, it additionally
    defines each key in the hashtable as variable.

    .EXAMPLE
    ```powershell
    BeforeAll {
        function Add-Numbers($a, $b) {
            return $a + $b
        }
    }

    Describe "Add-Numbers" {
        It "adds positive numbers" {
            $sum = Add-Numbers 2 3
            $sum | Should -Be 5
        }

        It "adds negative numbers" {
            $sum = Add-Numbers (-2) (-2)
            $sum | Should -Be (-4)
        }

        It "adds one negative number to positive number" {
            $sum = Add-Numbers (-2) 2
            $sum | Should -Be 0
        }

        It "concatenates strings if given strings" {
            $sum = Add-Numbers two three
            $sum | Should -Be "twothree"
        }
    }
    ```

    Using Describe to group tests logically at the root of the script/container

    .LINK
    https://pester.dev/docs/v5/commands/Describe

    .LINK
    https://pester.dev/docs/v5/usage/test-file-structure

    .LINK
    https://pester.dev/docs/v5/usage/mocking

    .LINK
    https://pester.dev/docs/v5/usage/testdrive
    #>

    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string] $Name,

        [Alias('Tags')]
        [string[]] $Tag = @(),

        [Parameter(Position = 1)]
        [ValidateNotNull()]
        [ScriptBlock] $Fixture,

        # [Switch] $Focus,
        [Switch] $Skip,

        [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidAssignmentToAutomaticVariable', '', Justification = 'ForEach is not used in Foreach-Object loop')]
        $ForEach
    )

    $Focus = $false
    if ($null -eq $Fixture) {
        if ($Name.Contains("`n")) {
            throw "Test fixture name has multiple lines and no test fixture is provided. (Have you provided a name for the test group?)"
        }
        else {
            throw 'No test fixture is provided. (Have you put the open curly brace on the next line?)'
        }
    }

    if ($ExecutionContext.SessionState.PSVariable.Get('invokedViaInvokePester')) {
        if ($state.CurrentBlock.IsRoot -and -not $state.CurrentBlock.FrameworkData.MissingParametersProcessed) {
            # For undefined parameters in container, add parameter's default value to Data
            Add-MissingContainerParameters -RootBlock $state.CurrentBlock -Container $container -CallingFunction $PSCmdlet
        }

        if ($PSBoundParameters.ContainsKey('ForEach')) {
            if ($null -ne $ForEach -and 0 -lt @($ForEach).Count) {
                New-ParametrizedBlock -Name $Name -ScriptBlock $Fixture -StartLine $MyInvocation.ScriptLineNumber -StartColumn $MyInvocation.OffsetInLine -Tag $Tag -FrameworkData @{ CommandUsed = 'Describe'; WrittenToScreen = $false } -Focus:$Focus -Skip:$Skip -Data $ForEach
            }
            else {
                # @() or $null is provided do nothing
            }
        }
        else {
            New-Block -Name $Name -ScriptBlock $Fixture -StartLine $MyInvocation.ScriptLineNumber -Tag $Tag -FrameworkData @{ CommandUsed = 'Describe'; WrittenToScreen = $false } -Focus:$Focus -Skip:$Skip
        }
    }
    else {
        Invoke-Interactively -CommandUsed 'Describe' -ScriptName $PSCmdlet.MyInvocation.ScriptName -SessionState $PSCmdlet.SessionState -BoundParameters $PSCmdlet.MyInvocation.BoundParameters
    }
}

function Invoke-Interactively ($CommandUsed, $ScriptName, $SessionState, $BoundParameters) {
    # interactive execution (by F5 in an editor, by F8 on selection, or by pasting to console)
    # do not run interactively in non-saved files
    # (vscode will use path like "untitled:Untitled-*" so we check if the path is rooted)
    if (-not [String]::IsNullOrEmpty($ScriptName) -and [IO.Path]::IsPathRooted($ScriptName)) {
        # we are invoking a file, try call Invoke-Pester on the whole file,
        # but make sure we are invoking it in the caller session state, because
        # paths don't stay attached to session state
        $invokePester = {
            param($private:Path, $private:ScriptParameters, $private:Out_Null)
            $private:c = New-PesterContainer -Path $Path -Data $ScriptParameters
            Invoke-Pester -Container $c | & $Out_Null
        }

        # get PSBoundParameters from caller script to allow interactive execution of parameterized tests.
        $scriptBoundParameters = $SessionState.PSVariable.GetValue("PSBoundParameters")

        Set-ScriptBlockScope -SessionState $SessionState -ScriptBlock $invokePester
        & $invokePester $ScriptName $scriptBoundParameters $SafeCommands['Out-Null']

        # exit the current script (always invoked test-file in this block) to avoid rerunning the next root-level block
        # and running any remaining root-level code. this will not kill a parent script or process.
        # pass on exit-code set by Invoke-Pester (always equal to failing tests count)
        exit $global:LASTEXITCODE
    }
    else {
        throw "Pester can run only saved files interactively. Please save your file to a disk."

        # there is a number of problems with this that I don't know how to solve right now
        # - the scripblock below will be discovered which shows a weird message in the console (maybe just suppress?)
        # every block will get it's own summary if we ar running multiple of them (can we somehow get to the actual executed code?) or know which one is the last one?

        # use an intermediate module to carry the bound parameters
        # but don't touch the session state the scriptblock is attached
        # to, this way we are still running the provided scriptblocks where
        # they are coming from (in the SessionState they are attached to),
        # this could be replaced by providing params if the current api allowed it
        $sb = & {
            # only local variables are copied in closure
            # make a new scope so we copy only what is needed
            param($BoundParameters, $CommandUsed)
            {
                & $CommandUsed @BoundParameters
            }.GetNewClosure()
        } $BoundParameters $CommandUsed

        Invoke-Pester -ScriptBlock $sb | & $SafeCommands['Out-Null']
    }
}

function Assert-DescribeInProgress {
    # TODO: Enforce block structure in the Runtime.Pester if needed, in the meantime this is just a placeholder
}
# file src\functions\Environment.ps1
function GetPesterPsVersion {
    # accessing the value indirectly so it can be mocked
    (& $SafeCommands['Get-Variable'] 'PSVersionTable' -ValueOnly).PSVersion.Major
}

function GetPesterOs {
    # Prior to v6, PowerShell was solely on Windows. In v6, the $IsWindows variable was introduced.
    if ((GetPesterPsVersion) -lt 6) {
        'Windows'
    }
    elseif (& $SafeCommands['Get-Variable'] -Name 'IsWindows' -ErrorAction 'Ignore' -ValueOnly ) {
        'Windows'
    }
    elseif (& $SafeCommands['Get-Variable'] -Name 'IsMacOS' -ErrorAction 'Ignore' -ValueOnly ) {
        'macOS'
    }
    elseif (& $SafeCommands['Get-Variable'] -Name 'IsLinux' -ErrorAction 'Ignore' -ValueOnly ) {
        'Linux'
    }
    else {
        throw "Unsupported Operating system!"
    }
}

function Get-TempDirectory {
    if ((GetPesterOs) -eq 'macOS') {
        # Special case for macOS using the real path instead of /tmp which is a symlink to this path
        "/private/tmp"
    }
    else {
        [System.IO.Path]::GetTempPath()
    }
}

function Get-TempRegistry {
    # The Pester root key is created once and then stays in place.
    # In TestDrive we use system Temp folder, but such key exists for registry so we create our own.
    # Removing it would cleanup remaining keys from cancelled runs, but could break parallell or nested runs, so leaving it

    $pesterTempRegistryRoot = 'Microsoft.PowerShell.Core\Registry::HKEY_CURRENT_USER\Software\Pester'
    try {
        # Test-Path returns true and doesn't throw access denied when path exists but user missing permission unless -PathType Container is used
        if (-not (& $script:SafeCommands['Test-Path'] $pesterTempRegistryRoot -PathType Container -ErrorAction Stop)) {
            # Don't use -Force parameter here because that deletes the folder and creates a race condition see
            # https://github.com/pester/Pester/issues/1181
            $null = & $SafeCommands['New-Item'] -Path $pesterTempRegistryRoot -ErrorAction Stop
        }
    }
    catch [Exception] {
        throw ([Exception]"Was not able to create a Pester Registry key for TestRegistry at '$pesterTempRegistryRoot'", ($_.Exception))
    }
    return $pesterTempRegistryRoot
}
# file src\functions\Get-ShouldOperator.ps1
function Get-ShouldOperator {
    <#
    .SYNOPSIS
    Display the assertion operators available for use with Should.

    .DESCRIPTION
    Get-ShouldOperator returns a list of available Should parameters,
    their aliases, and examples to help you craft the tests you need.

    Get-ShouldOperator will list all available operators,
    including any registered by the user with Add-ShouldOperator.

    .NOTES
    Pester uses dynamic parameters to populate Should arguments.

    This limits the user's ability to discover the available assertions via
    standard PowerShell discovery patterns (like `Get-Help Should -Parameter *`).

    .EXAMPLE
    Get-ShouldOperator

    Return all available Should assertion operators and their aliases.

    .EXAMPLE
    Get-ShouldOperator -Name Be

    Return help examples for the Be assertion operator.
    -Name is a dynamic parameter that tab completes all available options.

    .LINK
    https://pester.dev/docs/v5/commands/Get-ShouldOperator

    .LINK
    https://pester.dev/docs/v5/commands/Should
    #>
    [CmdletBinding()]
    param ()

    # Use a dynamic parameter to create a dynamic ValidateSet
    # Define parameter -Name and tab-complete all current values of $AssertionOperators
    # Discovers included assertions (-Be, -Not) and any registered by the user via Add-ShouldOperator
    # https://martin77s.wordpress.com/2014/06/09/dynamic-validateset-in-a-dynamic-parameter/
    DynamicParam {
        $ParameterName = 'Name'

        $RuntimeParameterDictionary = & $SafeCommands['New-Object'] System.Management.Automation.RuntimeDefinedParameterDictionary
        $AttributeCollection = & $SafeCommands['New-Object'] System.Collections.ObjectModel.Collection[System.Attribute]
        $ParameterAttribute = & $SafeCommands['New-Object'] System.Management.Automation.ParameterAttribute
        $ParameterAttribute.Position = 0
        $ParameterAttribute.HelpMessage = 'Name or alias of operator'

        $AttributeCollection.Add($ParameterAttribute)

        $arrSet = $AssertionOperators.Values |
            & $SafeCommands['Select-Object'] -Property Name, Alias |
            & $SafeCommands['ForEach-Object'] { $_.Name; $_.Alias }

        $ValidateSetAttribute = & $SafeCommands['New-Object']System.Management.Automation.ValidateSetAttribute($arrSet)

        $AttributeCollection.Add($ValidateSetAttribute)

        $RuntimeParameter = & $SafeCommands['New-Object'] System.Management.Automation.RuntimeDefinedParameter($ParameterName, [string], $AttributeCollection)
        $RuntimeParameterDictionary.Add($ParameterName, $RuntimeParameter)
        return $RuntimeParameterDictionary
    }

    BEGIN {
        # Bind the parameter to a friendly variable
        $Name = $PsBoundParameters[$ParameterName]
    }

    END {
        if ($Name) {
            $operator = $AssertionOperators.Values | & $SafeCommands['Where-Object'] { $Name -eq $_.Name -or $_.Alias -contains $Name }
            $commandInfo = & $SafeCommands['Get-Command'] -Name $operator.InternalName -ErrorAction Ignore
            $help = & $SafeCommands['Get-Help'] -Name $operator.InternalName -Examples -ErrorAction Ignore

            if (($help | & $SafeCommands['Measure-Object']).Count -ne 1) {
                & $SafeCommands['Write-Warning'] ("No help found for Should operator '{0}'" -f ((Get-AssertionOperatorEntry $Name).InternalName))
            }
            else {
                # Update syntax to use Should -Operator as command-name and pretty printed parameter set
                for ($i = 0; $i -lt $commandInfo.ParameterSets.Count; $i++) {
                    $help.syntax.syntaxItem[$i].name = "Should -$($operator.Name)"
                    $prettyParameterSet = $commandInfo.ParameterSets[$i].ToString() -replace '-Negate', '-Not' -replace '\[+-CallerSessionState\]? <.*?>\]?\s?'
                    $help.syntax.syntaxItem[$i].PSObject.Properties.Add([Pester.Factory]::CreateNoteProperty('DisplayParameterSet', $prettyParameterSet))
                }

                [PSCustomObject]@{
                    PSTypeName = 'PesterAssertionOperatorHelp'
                    Name = $operator.Name
                    Aliases = @($operator.Alias)
                    Help = $help
                }
            }
        }
        else {
            $AssertionOperators.Keys | & $SafeCommands['ForEach-Object'] {
                $aliases = (Get-AssertionOperatorEntry $_).Alias

                # Return name and alias(es) for all registered Should operators
                [PSCustomObject] @{
                    Name  = $_
                    Alias = $aliases -join ', '
                }
            }
        }
    }
}
# file src\functions\Get-SkipRemainingOnFailurePlugin.ps1
function Resolve-SkipRemainingOnFailureConfiguration {
    $supportedValues = 'None', 'Block', 'Container', 'Run'
    if ($PesterPreference.Run.SkipRemainingOnFailure.Value -notin $supportedValues) {
        throw (Get-StringOptionErrorMessage -OptionPath 'Run.SkipRemainingOnFailure' -SupportedValues $supportedValues -Value $PesterPreference.Run.SkipRemainingOnFailure.Value)
    }
}

function Set-RemainingAsSkipped {
    param(
        [Parameter(Mandatory)]
        [Pester.Test]
        $FailedTest,

        [Parameter(Mandatory)]
        [Pester.Block]
        $Block
    )

    $errorRecord = [Pester.Factory]::CreateErrorRecord(
        'PesterTestSkipped',
        "Skipped due to previous failure at '$($FailedTest.ExpandedPath)' and Run.SkipRemainingOnFailure set to '$($PesterPreference.Run.SkipRemainingOnFailure.Value)'",
        $null,
        $null,
        $null,
        $false
    )

    Fold-Block -Block $Block -OnTest {
        param ($test)
        if ($test.ShouldRun -and -not $test.Skip -and -not $test.Executed) {
            # Skipping and counting remaining unexecuted tests
            $Context.Configuration.SkipRemainingOnFailureCount += 1
            $test.Skip = $true
            $test.ErrorRecord.Add($errorRecord)
        }
    } -OnBlock {
        param($block)
        if ($block.ShouldRun -and -not $block.Skip -and -not $block.Executed) {
            # Marking remaining blocks as Skip to avoid executing BeforeAll/AfterAll
            $block.Skip = $true
        }
    }
}

function Get-SkipRemainingOnFailurePlugin {
    # Validate configuration
    Resolve-SkipRemainingOnFailureConfiguration

    # Create plugin
    $p = @{
        Name = 'SkipRemainingOnFailure'
    }

    $p.Start = {
        param ($Context)

        # TODO: Use $Context.GlobalPluginData.SkipRemainingOnFailure.SkippedCount when exposed in $Context
        $Context.Configuration.SkipRemainingOnFailureCount = 0
    }

    if ($PesterPreference.Run.SkipRemainingOnFailure.Value -eq 'Block') {
        $p.EachTestTeardownEnd = {
            param($Context)

            # If test was not skipped and failed
            if (-not $Context.Test.Skipped -and -not $Context.Test.Passed) {
                # Skip all remaining tests in the block recursively
                Set-RemainingAsSkipped -FailedTest $Context.Test -Block $Context.Block
            }
        }
    }

    elseif ($PesterPreference.Run.SkipRemainingOnFailure.Value -eq 'Container') {
        $p.EachTestTeardownEnd = {
            param($Context)

            # If test was not skipped and failed
            if (-not $Context.Test.Skipped -and -not $Context.Test.Passed) {
                # Skip all remaining tests in the container recursively
                Set-RemainingAsSkipped -FailedTest $Context.Test -Block $Context.Block.Root
            }
        }
    }

    elseif ($PesterPreference.Run.SkipRemainingOnFailure.Value -eq 'Run') {
        $p.ContainerRunStart = {
            param($Context)

            # If a test failed in a previous container, skip all tests
            if ($Context.Configuration.SkipRemainingFailedTest) {
                # Skip container root block to avoid root-level BeforeAll/AfterAll from running. Only applicable in this mode
                $Context.Block.Root.Skip = $true
                # Skip all remaining tests in current container
                Set-RemainingAsSkipped -FailedTest $Context.Configuration.SkipRemainingFailedTest -Block $Context.Block
            }
        }

        $p.EachTestTeardownEnd = {
            param($Context)

            # If test was not skipped but failed
            if (-not $Context.Test.Skipped -and -not $Context.Test.Passed) {
                # Skip all remaining tests in current container
                Set-RemainingAsSkipped -FailedTest $Context.Test -Block $Context.Block.Root

                # Store failed test so we can skip remaining containers in ContainerRunStart-step
                # TODO: Use $Context.GlobalPluginData.SkipRemainingOnFailure.FailedTest when exposed in $Context
                $Context.Configuration.SkipRemainingFailedTest = $Context.Test
            }
        }
    }

    if ($PesterPreference.Output.Verbosity.Value -in 'Detailed', 'Diagnostic') {
        $p.End = {
            param($Context)

            if ($Context.Configuration.SkipRemainingOnFailureCount -gt 0) {
                Write-PesterHostMessage -ForegroundColor $ReportTheme.Skipped "Remaining tests skipped after first failure: $($Context.Configuration.SkipRemainingOnFailureCount)"
            }
        }
    }

    New-PluginObject @p
}
# file src\functions\In.ps1
function In {
    <#
    .SYNOPSIS
    A convenience function that executes a script from a specified path.

    .DESCRIPTION
    Before the script block passed to the execute parameter is invoked,
    the current location is set to the path specified. Once the script
    block has been executed, the location will be reset to the location
    the script was in prior to calling In.

    .PARAMETER Path
    The path that the execute block will be executed in.

    .PARAMETER ScriptBlock
    The script to be executed in the path provided.

    .LINK
    https://github.com/pester/Pester/wiki/In
    #>
    [CmdletBinding(DefaultParameterSetName = "Default")]
    param(
        [Parameter(Mandatory, ParameterSetName = "Default", Position = 0)]
        [String] $Path,
        [Parameter(Mandatory, ParameterSetName = "TestDrive", Position = 0)]
        [Switch] $TestDrive,
        [Parameter(Mandatory, Position = 1)]
        [Alias("Execute")]
        [ScriptBlock] $ScriptBlock
    )

    # test drive is not available during discovery, ideally no code should
    # depend on location during discovery, but I cannot rely on that, so unless
    # the path is TestDrive the path is changed in discovery as well as during
    # the run phase
    $doNothing = $false
    if ($TestDrive) {
        if (Is-Discovery) {
            $doNothing = $true
        }
        else {
            $Path = (& $SafeCommands['Get-PSDrive'] 'TestDrive').Root
        }
    }

    $originalPath = $pwd
    if (-not $doNothing) {
        & $SafeCommands['Set-Location'] $Path
        $pwd = $Path
    }
    try {
        & $ScriptBlock
    }
    finally {
        if (-not $doNothing) {
            & $SafeCommands['Set-Location'] $originalPath
            $pwd = $originalPath
        }
    }
}
# file src\functions\InModuleScope.ps1
function InModuleScope {
    <#
    .SYNOPSIS
    Allows you to execute parts of a test script within the
    scope of a PowerShell script or manifest module.
    .DESCRIPTION
    By injecting some test code into the scope of a PowerShell
    script or manifest module, you can use non-exported functions, aliases
    and variables inside that module, to perform unit tests on
    its internal implementation.

    InModuleScope may be used anywhere inside a Pester script,
    either inside or outside a Describe block.
    .PARAMETER ModuleName
    The name of the module into which the test code should be
    injected. This module must already be loaded into the current
    PowerShell session.
    .PARAMETER ScriptBlock
    The code to be executed within the script or manifest module.
    .PARAMETER Parameters
    A optional hashtable of parameters to be passed to the scriptblock.
    Parameters are automatically made available as variables in the scriptblock.
    .PARAMETER ArgumentList
    A optional list of arguments to be passed to the scriptblock.

    .EXAMPLE
    ```powershell
    # The script module:
    function PublicFunction {
        # Does something
    }

    function PrivateFunction {
        return $true
    }

    Export-ModuleMember -Function PublicFunction

    # The test script:

    Import-Module MyModule

    InModuleScope MyModule {
        Describe 'Testing MyModule' {
            It 'Tests the Private function' {
                PrivateFunction | Should -Be $true
            }
        }
    }
    ```

    Normally you would not be able to access "PrivateFunction" from
    the PowerShell session, because the module only exported
    "PublicFunction".  Using InModuleScope allowed this call to
    "PrivateFunction" to work successfully.

    .EXAMPLE
    ```powershell
    # The script module:
    function PublicFunction {
        # Does something
    }

    function PrivateFunction ($MyParam) {
        return $MyParam
    }

    Export-ModuleMember -Function PublicFunction

    # The test script:

    Describe 'Testing MyModule' {
        BeforeAll {
            Import-Module MyModule
        }

        It 'passing in parameter' {
            $SomeVar = 123
            InModuleScope 'MyModule' -Parameters @{ MyVar = $SomeVar } {
                $MyVar | Should -Be 123
            }
        }

        It 'accessing whole testcase in module scope' -TestCases @(
            @{ Name = 'Foo'; Bool = $true }
        ) {
            # Passes the whole testcase-dictionary available in $_ to InModuleScope
            InModuleScope 'MyModule' -Parameters $_ {
                $Name | Should -Be 'Foo'
                PrivateFunction -MyParam $Bool | Should -BeTrue
            }
        }
    }
    ```

    This example shows two ways of using `-Parameters` to pass variables created in a
    testfile into the module scope where the scriptblock provided to InModuleScope is executed.
    No variables from the outside are available inside the scriptblock without explicitly passing
    them in using `-Parameters` or `-ArgumentList`.

    .LINK
    https://pester.dev/docs/v5/commands/InModuleScope
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $ModuleName,

        [Parameter(Mandatory = $true)]
        [scriptblock]
        $ScriptBlock,

        [HashTable]
        $Parameters = @{},

        [object[]]
        $ArgumentList = @()
    )

    $module = Get-CompatibleModule -ModuleName $ModuleName -ErrorAction Stop
    $sessionState = Set-SessionStateHint -PassThru -Hint "Module - $($module.Name)" -SessionState $module.SessionState

    $wrapper = {
        param ($private:______inmodule_parameters)

        # This script block is used to create variables for provided parameters that
        # the real scriptblock can inherit. Makes defining a param-block optional.

        foreach ($private:______current in $private:______inmodule_parameters.Parameters.GetEnumerator()) {
            $private:______inmodule_parameters.SessionState.PSVariable.Set($private:______current.Key, $private:______current.Value)
        }

        # Splatting expressions isn't allowed. Assigning to new private variable
        $private:______arguments = $private:______inmodule_parameters.ArgumentList
        $private:______parameters = $private:______inmodule_parameters.Parameters

        if ($private:______parameters.Count -gt 0) {
            & $private:______inmodule_parameters.ScriptBlock @private:______arguments @private:______parameters
        }
        else {
            # Not splatting parameters to avoid polluting args
            & $private:______inmodule_parameters.ScriptBlock @private:______arguments
        }
    }

    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
        $hasParams = 0 -lt $Parameters.Count
        $hasArgs = 0 -lt $ArgumentList.Count
        $inmoduleArguments = $($(if ($hasArgs) { foreach ($a in $ArgumentList) { "'$($a)'" } }) -join ", ")
        $inmoduleParameters = $(if ($hasParams) { foreach ($p in $Parameters.GetEnumerator()) { "$($p.Key) = $($p.Value)" } }) -join ", "
        Write-PesterDebugMessage -Scope Runtime -Message "Running scriptblock { $scriptBlock } in module $($ModuleName)$(if ($hasParams) { " with parameters: $inmoduleParameters" })$(if ($hasArgs) { "$(if ($hasParams) { ' and' }) with arguments: $inmoduleArguments" })."
    }

    Set-ScriptBlockScope -ScriptBlock $ScriptBlock -SessionState $sessionState
    Set-ScriptBlockScope -ScriptBlock $wrapper -SessionState $sessionState
    $splat = @{
        ScriptBlock    = $ScriptBlock
        Parameters     = $Parameters
        ArgumentList   = $ArgumentList
        SessionState   = $sessionState
    }

    Write-ScriptBlockInvocationHint -Hint "InModuleScope" -ScriptBlock $ScriptBlock
    & $wrapper $splat
}

function Get-CompatibleModule {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string] $ModuleName
    )

    try {
        if ($PesterPreference.Debug.WriteDebugMessages.Value) {
            Write-PesterDebugMessage -Scope Runtime "Searching for a module $ModuleName."
        }
        $modules = @(& $SafeCommands['Get-Module'] -Name $ModuleName -All -ErrorAction Stop)
    }
    catch {
        throw "No modules named '$ModuleName' are currently loaded."
    }

    if ($modules.Count -eq 0) {
        throw "No modules named '$ModuleName' are currently loaded."
    }

    $compatibleModules = @($modules | & $SafeCommands['Where-Object'] { $_.ModuleType -in 'Script', 'Manifest' })
    if ($compatibleModules.Count -gt 1) {
        throw "Multiple script or manifest modules named '$ModuleName' are currently loaded. Make sure to remove any extra copies of the module from your session before testing."
    }

    if ($compatibleModules.Count -eq 0) {
        $actualTypes = @(
            $modules |
                & $SafeCommands['Where-Object'] { $_.ModuleType -notin 'Script', 'Manifest' } |
                & $SafeCommands['Select-Object'] -ExpandProperty ModuleType -Unique
        )

        $actualTypes = $actualTypes -join ', '

        throw "Module '$ModuleName' is not a Script or Manifest module. Detected modules of the following types: '$actualTypes'"
    }
    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
        Write-PesterDebugMessage -Scope Runtime "Found module $ModuleName version $($compatibleModules[0].Version)."
    }
    return $compatibleModules[0]
}
# file src\functions\It.ps1
function It {
    <#
    .SYNOPSIS
    Validates the results of a test inside of a Describe block.

    .DESCRIPTION
    The It command is intended to be used inside of a Describe or Context Block.
    If you are familiar with the AAA pattern (Arrange-Act-Assert), the body of
    the It block is the appropriate location for an assert. The convention is to
    assert a single expectation for each It block. The code inside of the It block
    should throw a terminating error if the expectation of the test is not met and
    thus cause the test to fail. The name of the It block should expressively state
    the expectation of the test.

    In addition to using your own logic to test expectations and throw exceptions,
    you may also use Pester's Should command to perform assertions in plain language.

    You can intentionally mark It block result as inconclusive by using Set-ItResult -Inconclusive
    command as the first tested statement in the It block.

    .PARAMETER Name
    An expressive phrase describing the expected test outcome.

    .PARAMETER Test
    The script block that should throw an exception if the
    expectation of the test is not met.If you are following the
    AAA pattern (Arrange-Act-Assert), this typically holds the
    Assert.

    .PARAMETER Pending
    Use this parameter to explicitly mark the test as work-in-progress/not implemented/pending when you
    need to distinguish a test that fails because it is not finished yet from a tests
    that fail as a result of changes being made in the code base. An empty test, that is a
    test that contains nothing except whitespace or comments is marked as Pending by default.

    .PARAMETER Skip
    Use this parameter to explicitly mark the test to be skipped. This is preferable to temporarily
    commenting out a test, because the test remains listed in the output.

    .PARAMETER ForEach
    (Formerly called TestCases.) Optional array of hashtable (or any IDictionary) objects.
    If this parameter is used, Pester will call the test script block once for each table in
    the ForEach array, splatting the dictionary to the test script block as input.  If you want
    the name of the test to appear differently for each test case, you can embed tokens into the Name
    parameter with the syntax 'Adds numbers <A> and <B>' (assuming you have keys named A and B
    in your ForEach hashtables.)

    .PARAMETER Tag
    Optional parameter containing an array of strings. When calling Invoke-Pester,
    it is possible to include or exclude tests containing the same Tag.

    .EXAMPLE
    ```powershell
    BeforeAll {
        function Add-Numbers($a, $b) {
            return $a + $b
        }
    }

    Describe "Add-Numbers" {
        It "adds positive numbers" {
            $sum = Add-Numbers 2 3
            $sum | Should -Be 5
        }

        It "adds negative numbers" {
            $sum = Add-Numbers (-2) (-2)
            $sum | Should -Be (-4)
        }

        It "adds one negative number to positive number" {
            $sum = Add-Numbers (-2) 2
            $sum | Should -Be 0
        }

        It "concatenates strings if given strings" {
            $sum = Add-Numbers two three
            $sum | Should -Be "twothree"
        }
    }
    ```

    Example of a simple Pester file. It-blocks are used to define the different tests.

    .EXAMPLE
    ```powershell
    function Add-Numbers($a, $b) {
        return $a + $b
    }

    Describe "Add-Numbers" {
        $testCases = @(
            @{ a = 2;     b = 3;       expectedResult = 5 }
            @{ a = -2;    b = -2;      expectedResult = -4 }
            @{ a = -2;    b = 2;       expectedResult = 0 }
            @{ a = 'two'; b = 'three'; expectedResult = 'twothree' }
        )

        It 'Correctly adds <a> and <b> to get <expectedResult>' -ForEach $testCases {
            $sum = Add-Numbers $a $b
            $sum | Should -Be $expectedResult
        }
    }
    ```

    Using It with -ForEach to run the same tests with different parameters and expected results.
    Each hashtable in the `$testCases`-array generates one tests to a total of four. Each key-value pair in the
    current hashtable are made available as variables inside It.

    .LINK
    https://pester.dev/docs/v5/commands/It

    .LINK
    https://pester.dev/docs/v5/commands/Describe

    .LINK
    https://pester.dev/docs/v5/commands/Context

    .LINK
    https://pester.dev/docs/v5/commands/Set-ItResult
    #>
    [CmdletBinding(DefaultParameterSetName = 'Normal')]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string] $Name,

        [Parameter(Position = 1)]
        [ScriptBlock] $Test,

        [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidAssignmentToAutomaticVariable', '', Justification = 'ForEach is not used in Foreach-Object loop')]
        [Alias("TestCases")]
        [object[]] $ForEach,

        [String[]] $Tag,

        [Parameter(ParameterSetName = 'Pending')]
        [Switch] $Pending,

        [Parameter(ParameterSetName = 'Skip')]
        [Switch] $Skip

        # [Parameter(ParameterSetName = 'Skip')]
        # [String] $SkipBecause,

        # [Switch]$Focus
    )

    $Focus = $false
    if ($PSBoundParameters.ContainsKey('Pending')) {
        $PSBoundParameters.Remove('Pending')

        $Skip = $Pending
        # $SkipBecause = "This test is pending."
    }

    if ($null -eq $Test) {
        if ($Name.Contains("`n")) {
            throw "Test name has multiple lines and no test scriptblock is provided. Did you provide the test name?"
        }
        else {
            throw "No test scriptblock is provided. Did you put the opening curly brace on the next line?"
        }
    }

    if ($PSBoundParameters.ContainsKey('ForEach')) {
        if ($null -ne $ForEach -and 0 -lt @($ForEach).Count) {
            New-ParametrizedTest -Name $Name -ScriptBlock $Test -StartLine $MyInvocation.ScriptLineNumber -StartColumn $MyInvocation.OffsetInLine -Data $ForEach -Tag $Tag -Focus:$Focus -Skip:$Skip
        }
        else {
            # @() or $null is provided do nothing
        }
    }
    else {
        New-Test -Name $Name -ScriptBlock $Test -StartLine $MyInvocation.ScriptLineNumber -Tag $Tag -Focus:$Focus -Skip:$Skip
    }
}
# file src\functions\Mock.ps1


function Add-MockBehavior {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        $Behaviors,
        [Parameter(Mandatory)]
        $Behavior
    )

    if ($Behavior.IsDefault) {
        $Behaviors.Default.Add($Behavior)
    }
    else {
        $Behaviors.Parametrized.Add($Behavior)
    }
}

function New-MockBehavior {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        $ContextInfo,
        [ScriptBlock] $MockWith = { },
        [Switch] $Verifiable,
        [ScriptBlock] $ParameterFilter,
        [Parameter(Mandatory)]
        $Hook,
        [string[]]$RemoveParameterType,
        [string[]]$RemoveParameterValidation
    )

    [PSCustomObject] @{
        CommandName = $ContextInfo.Command.Name
        ModuleName  = $ContextInfo.TargetModule
        Filter      = $ParameterFilter
        IsDefault   = $null -eq $ParameterFilter
        IsInModule  = -not [string]::IsNullOrEmpty($ContextInfo.TargetModule)
        Verifiable  = $Verifiable
        Executed    = $false
        ScriptBlock = $MockWith
        Hook        = $Hook
        PSTypeName  = 'MockBehavior'
    }
}

function EscapeSingleQuotedStringContent ($Content) {
    if ($global:PSVersionTable.PSVersion.Major -ge 5) {
        [System.Management.Automation.Language.CodeGeneration]::EscapeSingleQuotedStringContent($Content)
    }
    else {
        $Content -replace "['‘’‚‛]", '$&$&'
    }
}

function Create-MockHook ($contextInfo, $InvokeMockCallback) {
    $commandName = $contextInfo.Command.Name
    $moduleName = $contextInfo.TargetModule
    $metadata = $contextInfo.CommandMetadata
    $cmdletBinding = ''
    $paramBlock = ''
    $dynamicParamBlock = ''
    $dynamicParamScriptBlock = $null

    if ($contextInfo.Command.psobject.Properties['ScriptBlock'] -or $contextInfo.Command.CommandType -eq 'Cmdlet') {
        $null = $metadata.Parameters.Remove('Verbose')
        $null = $metadata.Parameters.Remove('Debug')
        $null = $metadata.Parameters.Remove('ErrorAction')
        $null = $metadata.Parameters.Remove('WarningAction')
        $null = $metadata.Parameters.Remove('ErrorVariable')
        $null = $metadata.Parameters.Remove('WarningVariable')
        $null = $metadata.Parameters.Remove('OutVariable')
        $null = $metadata.Parameters.Remove('OutBuffer')

        # Some versions of PowerShell may include dynamic parameters here
        # We will filter them out and add them at the end to be
        # compatible with both earlier and later versions
        $dynamicParams = foreach ($m in $metadata.Parameters.Values) { if ($m.IsDynamic) { $m } }
        if ($null -ne $dynamicParams) {
            foreach ($p in $dynamicParams) {
                $null = $metadata.Parameters.Remove($d.name)
            }
        }
        $cmdletBinding = [Management.Automation.ProxyCommand]::GetCmdletBindingAttribute($metadata)
        if ($global:PSVersionTable.PSVersion.Major -ge 3 -and $contextInfo.Command.CommandType -eq 'Cmdlet') {
            if ($cmdletBinding -ne '[CmdletBinding()]') {
                $cmdletBinding = $cmdletBinding.Insert($cmdletBinding.Length - 2, ',')
            }
            $cmdletBinding = $cmdletBinding.Insert($cmdletBinding.Length - 2, 'PositionalBinding=$false')
        }

        $metadata = Repair-ConflictingParameters -Metadata $metadata -RemoveParameterType $RemoveParameterType -RemoveParameterValidation $RemoveParameterValidation
        $paramBlock = [Management.Automation.ProxyCommand]::GetParamBlock($metadata)
        $paramBlock = Repair-EnumParameters -ParamBlock $paramBlock -Metadata $metadata

        if ($contextInfo.Command.CommandType -eq 'Cmdlet') {
            $dynamicParamBlock = "dynamicparam { & `$MyInvocation.MyCommand.Mock.Get_MockDynamicParameter -CmdletName '$($contextInfo.Command.Name)' -Parameters `$PSBoundParameters }"
        }
        else {
            $dynamicParamStatements = Get-DynamicParamBlock -ScriptBlock $contextInfo.Command.ScriptBlock

            if ($dynamicParamStatements -match '\S') {
                $metadataSafeForDynamicParams = $contextInfo.CommandMetadata2
                foreach ($param in $metadataSafeForDynamicParams.Parameters.Values) {
                    $param.ParameterSets.Clear()
                }

                $paramBlockSafeForDynamicParams = [System.Management.Automation.ProxyCommand]::GetParamBlock($metadataSafeForDynamicParams)
                $comma = if ($metadataSafeForDynamicParams.Parameters.Count -gt 0) {
                    ','
                }
                else {
                    ''
                }
                $dynamicParamBlock = "dynamicparam { & `$MyInvocation.MyCommand.Mock.Get_MockDynamicParameter -ModuleName '$moduleName' -FunctionName '$commandName' -Parameters `$PSBoundParameters -Cmdlet `$PSCmdlet -DynamicParamScriptBlock `$MyInvocation.MyCommand.Mock.Hook.DynamicParamScriptBlock }"

                $code = @"
                    $cmdletBinding
                    param(
                        [object] `${P S Cmdlet}$comma
                        $paramBlockSafeForDynamicParams
                    )

                    `$PSCmdlet = `${P S Cmdlet}

                    $dynamicParamStatements
"@

                $dynamicParamScriptBlock = [scriptblock]::Create($code)

                $sessionStateInternal = $script:ScriptBlockSessionStateInternalProperty.GetValue($contextInfo.Command.ScriptBlock)

                if ($null -ne $sessionStateInternal) {
                    $script:ScriptBlockSessionStateInternalProperty.SetValue($dynamicParamScriptBlock, $sessionStateInternal)
                }
            }
        }
    }

    $mockPrototype = @"
    if (`$null -ne `$MyInvocation.MyCommand.Mock.Write_PesterDebugMessage) { & `$MyInvocation.MyCommand.Mock.Write_PesterDebugMessage -Message "Mock bootstrap function #FUNCTIONNAME# called from block #BLOCK#." }
    `$MyInvocation.MyCommand.Mock.Args = @()
    if (#CANCAPTUREARGS#) {
        if (`$null -ne `$MyInvocation.MyCommand.Mock.Write_PesterDebugMessage) { & `$MyInvocation.MyCommand.Mock.Write_PesterDebugMessage -Message "Capturing arguments of the mocked command." }
        `$MyInvocation.MyCommand.Mock.Args = `$MyInvocation.MyCommand.Mock.ExecutionContext.SessionState.PSVariable.GetValue('local:args')
    }
    `$MyInvocation.MyCommand.Mock.PSCmdlet = `$MyInvocation.MyCommand.Mock.ExecutionContext.SessionState.PSVariable.GetValue('local:PSCmdlet')


    `if (`$null -ne `$MyInvocation.MyCommand.Mock.PSCmdlet)
    {
        `$MyInvocation.MyCommand.Mock.SessionState = `$MyInvocation.MyCommand.Mock.PSCmdlet.SessionState
    }

    # MockCallState initialization is injected only into the begin block by the code that generates this prototype
    # also it is not a good idea to share it via the function local data because then it will get overwritten by nested
    # mock if there is any, instead it should be a variable that gets defined in begin and so it survives during the whole
    # pipeline, but does not overwrite other variables, because we are running in different scopes. Mindblowing.
    & `$MyInvocation.MyCommand.Mock.Invoke_Mock -CommandName '#FUNCTIONNAME#' -ModuleName '#MODULENAME#' ```
        -BoundParameters `$PSBoundParameters ```
        -ArgumentList `$MyInvocation.MyCommand.Mock.Args ```
        -CallerSessionState `$MyInvocation.MyCommand.Mock.SessionState ```
        -MockCallState `$_____MockCallState ```
        -FromBlock '#BLOCK#' ```
        -Hook `$MyInvocation.MyCommand.Mock.Hook #INPUT#
"@
    $newContent = $mockPrototype
    $newContent = $newContent -replace '#FUNCTIONNAME#', (EscapeSingleQuotedStringContent $CommandName)
    $newContent = $newContent -replace '#MODULENAME#', (EscapeSingleQuotedStringContent $ModuleName)

    $canCaptureArgs = '$true'
    if ($contextInfo.Command.CommandType -eq 'Cmdlet' -or
        ($contextInfo.Command.CommandType -eq 'Function' -and $contextInfo.Command.CmdletBinding)) {
        $canCaptureArgs = '$false'
    }
    $newContent = $newContent -replace '#CANCAPTUREARGS#', $canCaptureArgs

    $code = @"
    $cmdletBinding
    param ( $paramBlock )
    $dynamicParamBlock
    begin
    {
        # MockCallState is set only in begin block, to persist state between
        # begin, process, and end blocks
        `$_____MockCallState = @{}
        $($newContent -replace '#BLOCK#', 'Begin' -replace '#INPUT#')
    }

    process
    {
        $($newContent -replace '#BLOCK#', 'Process' -replace '#INPUT#', '-InputObject @($input)')
    }

    end
    {
        $($newContent -replace '#BLOCK#', 'End' -replace '#INPUT#')
    }
"@

    $mockScript = [scriptblock]::Create($code)

    $mockName = "PesterMock_$(if ([string]::IsNullOrEmpty($ModuleName)) { "script" } else { $ModuleName })_${CommandName}_$([Guid]::NewGuid().Guid)"

    $mock = @{
        OriginalCommand         = $contextInfo.Command
        OriginalMetadata        = $contextInfo.CommandMetadata
        OriginalMetadata2       = $contextInfo.CommandMetadata2
        CommandName             = $commandName
        SessionState            = $contextInfo.SessionState
        CallerSessionState      = $contextInfo.CallerSessionState
        Metadata                = $metadata
        DynamicParamScriptBlock = $dynamicParamScriptBlock
        Aliases                 = [Collections.Generic.List[object]]@($commandName)
        BootstrapFunctionName   = $mockName
    }

    if ($mock.OriginalCommand.ModuleName) {
        $mock.Aliases.Add("$($mock.OriginalCommand.ModuleName)\$($CommandName)")
    }

    if ('Application' -eq $Mock.OriginalCommand.CommandType) {
        $aliasWithoutExt = $CommandName -replace $Mock.OriginalCommand.Extension

        $mock.Aliases.Add($aliasWithoutExt)
    }

    $parameters = @{
        BootstrapFunctionName = $mock.BootstrapFunctionName
        Definition            = $mockScript
        Aliases               = $mock.Aliases

        Set_Alias             = $SafeCommands["Set-Alias"]
    }

    $defineFunctionAndAliases = {
        param($___Mock___parameters)
        # Make sure the you don't use _______parameters variable here, otherwise you overwrite
        # the variable that is defined in the same scope and the subsequent invocation of scripts will
        # be seriously broken (e.g. you will start resolving setups). But such is life of running in once scope.
        # from upper scope for no reason. But the reason is that you deleted ______param in this scope,
        # and so ______param from the parent scope was inherited

        ## THIS RUNS IN USER SCOPE, BE CAREFUL WHAT YOU PUBLISH AND CONSUME


        # it is possible to remove the script: (and -Scope Script) from here and from the alias, which makes the Mock scope just like a function.
        # but that breaks mocking inside of Pester itself, because the mock is defined in this function and dies with it
        # this is a cool concept to play with, but scoping mocks more granularly than per It is not something people asked for, and cleaning up
        # mocks is trivial now they are wrote in distinct tables based on where they are defined, so let's just do it as before, script scoped
        # function and alias, and cleaning it up in teardown

        # define the function and returns an array so we need to take the function out
        @($ExecutionContext.InvokeProvider.Item.Set("Function:\script:$($___Mock___parameters.BootstrapFunctionName)", $___Mock___parameters.Definition, $true, $true))[0]

        # define all aliases
        foreach ($______current in $___Mock___parameters.Aliases) {
            # this does not work because the syntax does not work, but would be faster
            # $ExecutionContext.InvokeProvider.Item.Set("Alias:script\:$______current", $___Mock___parameters.BootstrapFunctionName, $true, $true)
            & $___Mock___parameters.Set_Alias -Name $______current -Value $___Mock___parameters.BootstrapFunctionName -Scope Script
        }

        # clean up the variables because we are injecting them to the current scope
        $ExecutionContext.SessionState.PSVariable.Remove('______current')
        $ExecutionContext.SessionState.PSVariable.Remove('___Mock___parameters')
    }

    $definedFunction = Invoke-InMockScope -SessionState $mock.SessionState -ScriptBlock $defineFunctionAndAliases -Arguments @($parameters) -NoNewScope
    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
        Write-PesterDebugMessage -Scope Mock -Message "Defined new hook with bootstrap function $($parameters.BootstrapFunctionName)$(if ($parameters.Aliases.Count -gt 0) {" and aliases $($parameters.Aliases -join ", ")"})."
    }

    # attaching this object on the newly created function
    # so it has access to our internal and safe functions directly
    # and also to avoid any local variables, because everything is
    # accessed via $MyInvocation.MyCommand
    $functionLocalData = @{
        Args                     = $null
        SessionState             = $null

        Invoke_Mock              = $InvokeMockCallBack
        Get_MockDynamicParameter = $SafeCommands["Get-MockDynamicParameter"]
        # returning empty scriptblock when we should not write debug to avoid patching it in mock prototype
        Write_PesterDebugMessage = if ($PesterPreference.Debug.WriteDebugMessages.Value) { { param($Message) & $SafeCommands["Write-PesterDebugMessage"] -Scope MockCore -Message $Message } } else { $null }

        # used as temp variable
        PSCmdlet                 = $null

        # data from the time we captured and created this mock
        Hook                     = $mock

        ExecutionContext         = $ExecutionContext
    }

    $definedFunction.psobject.properties.Add([Pester.Factory]::CreateNoteProperty('Mock', $functionLocalData))

    $mock
}

function Should-InvokeVerifiableInternal {
    [CmdletBinding()]
    [OutputType([Pester.ShouldResult])]
    param(
        [Parameter(Mandatory)]
        $Behaviors,
        [switch] $Negate,
        [string] $Because
    )

    $filteredBehaviors = [System.Collections.Generic.List[Object]]@()
    foreach ($b in $Behaviors) {
        if ($b.Executed -eq $Negate.IsPresent) {
            $filteredBehaviors.Add($b)
        }
    }

    if ($filteredBehaviors.Count -gt 0) {
        [string]$filteredBehaviorMessage = ''
        foreach ($b in $filteredBehaviors) {
            $filteredBehaviorMessage += "$([System.Environment]::NewLine) Command $($b.CommandName) "
            if ($b.ModuleName) {
                $filteredBehaviorMessage += "from inside module $($b.ModuleName) "
            }
            if ($null -ne $b.Filter) { $filteredBehaviorMessage += "with { $($b.Filter.ToString().Trim()) }" }
        }

        if ($Negate) {
            $message = "$([System.Environment]::NewLine)Expected no verifiable mocks to be called,$(Format-Because $Because) but these were:$filteredBehaviorMessage"
            $ExpectedValue = 'No verifiable mocks to be called'
            $ActualValue = "These mocks were called:$filteredBehaviorMessage"
        }
        else {
            $message = "$([System.Environment]::NewLine)Expected all verifiable mocks to be called,$(Format-Because $Because) but these were not:$filteredBehaviorMessage"
            $ExpectedValue = 'All verifiable mocks to be called'
            $ActualValue = "These mocks were not called:$filteredBehaviorMessage"
        }

        return [Pester.ShouldResult] @{
            Succeeded      = $false
            FailureMessage = $message
            ExpectResult   = @{
                Expected = $ExpectedValue
                Actual   = $ActualValue
                Because  = Format-Because $Because
            }
        }
    }

    return [Pester.ShouldResult] @{
        Succeeded      = $true
    }
}

function Should-InvokeInternal {
    [CmdletBinding(DefaultParameterSetName = 'ParameterFilter')]
    [OutputType([Pester.ShouldResult])]
    param(
        [Parameter(Mandatory = $true)]
        [hashtable] $ContextInfo,

        [int] $Times = 1,

        [Parameter(ParameterSetName = 'ParameterFilter')]
        [ScriptBlock] $ParameterFilter = { $True },

        [Parameter(ParameterSetName = 'ExclusiveFilter', Mandatory = $true)]
        [scriptblock] $ExclusiveFilter,

        [string] $ModuleName,

        [switch] $Exactly,
        [switch] $Negate,
        [string] $Because,

        [Parameter(Mandatory)]
        [Management.Automation.SessionState] $SessionState,

        [Parameter(Mandatory)]
        [HashTable] $MockTable
    )

    if ($PSCmdlet.ParameterSetName -eq 'ParameterFilter') {
        $filter = $ParameterFilter
        $filterIsExclusive = $false
    }
    else {
        $filter = $ExclusiveFilter
        $filterIsExclusive = $true
    }

    if (-not $PSBoundParameters.ContainsKey('ModuleName') -and $null -ne $SessionState.Module) {
        $ModuleName = $SessionState.Module.Name
    }

    $ModuleName = $ContextInfo.TargetModule
    $CommandName = $ContextInfo.Command.Name

    $callHistory = $MockTable["$ModuleName||$CommandName"]

    $moduleMessage = ''
    if ($ModuleName) {
        $moduleMessage = " in module $ModuleName"
    }

    # if (-not $callHistory) {
    #     throw "You did not declare a mock of the $commandName Command${moduleMessage}."
    # }

    $matchingCalls = [System.Collections.Generic.List[object]]@()
    $nonMatchingCalls = [System.Collections.Generic.List[object]]@()

    # Check for variables in ParameterFilter that already exists in session. Risk of conflict
    # Excluding native applications as they don't have parameters or metadata. Will always use $args
    if ($PesterPreference.Debug.WriteDebugMessages.Value -and
        $null -ne $ContextInfo.Hook.Metadata -and
        $ContextInfo.Hook.Metadata.Parameters.Count -gt 0) {
        $preExistingFilterVariables = @{}
        foreach ($v in $filter.Ast.FindAll( { $args[0] -is [System.Management.Automation.Language.VariableExpressionAst] }, $true)) {
            if (-not $preExistingFilterVariables.ContainsKey($v.VariablePath.UserPath)) {
                if ($existingVar = $SessionState.PSVariable.Get($v.VariablePath.UserPath)) {
                    $preExistingFilterVariables.Add($v.VariablePath.UserPath, $existingVar.Value)
                }
            }
        }

        # Check against parameters and aliases in mocked command as it may cause false positives
        if ($preExistingFilterVariables.Count -gt 0) {
            foreach ($p in $ContextInfo.Hook.Metadata.Parameters.GetEnumerator()) {
                if ($preExistingFilterVariables.ContainsKey($p.Key)) {
                    Write-PesterDebugMessage -Scope Mock -Message "! Variable `$$($p.Key) with value '$($preExistingFilterVariables[$p.Key])' exists in current scope and matches a parameter in $CommandName which may cause false matches in ParameterFilter. Consider renaming the existing variable or use `$PesterBoundParameters.$($p.Key) in ParameterFilter."
                }

                $aliases = $p.Value.Aliases
                if ($null -ne $aliases -and 0 -lt @($aliases).Count) {
                    foreach ($a in $aliases) {
                        if ($preExistingFilterVariables.ContainsKey($a)) {
                            Write-PesterDebugMessage -Scope Mock -Message "! Variable `$$($a) with value '$($preExistingFilterVariables[$a])' exists in current scope and matches a parameter in $CommandName which may cause false matches in ParameterFilter. Consider renaming the existing variable or use `$PesterBoundParameters.$($a) in ParameterFilter."
                        }
                    }
                }
            }
        }
    }

    foreach ($historyEntry in $callHistory) {

        $params = @{
            ScriptBlock     = $filter
            BoundParameters = $historyEntry.BoundParams
            ArgumentList    = $historyEntry.Args
            Metadata        = $ContextInfo.Hook.Metadata
            # do not use the callser session state from the hook, the parameter filter
            # on Should -Invoke can come from a different session state if inModuleScope is used to
            # wrap it. Use the caller session state to which the scriptblock is bound
            SessionState    = $SessionState
        }

        # if ($null -ne $ContextInfo.Hook.Metadata -and $null -ne $params.ScriptBlock) {
        #     $params.ScriptBlock = New-BlockWithoutParameterAliasesNew-BlockWithoutParameterAliases -Metadata $ContextInfo.Hook.Metadata -Block $params.ScriptBlock
        # }

        if (Test-ParameterFilter @params) {
            $null = $matchingCalls.Add($historyEntry)
        }
        else {
            $null = $nonMatchingCalls.Add($historyEntry)
        }
    }

    if ($Negate) {
        # Negative checks
        if ($matchingCalls.Count -eq $Times -and ($Exactly -or !$PSBoundParameters.ContainsKey('Times'))) {
            return [Pester.ShouldResult] @{
                Succeeded      = $false
                FailureMessage = "Expected ${commandName}${moduleMessage} not to be called exactly $Times times,$(Format-Because $Because) but it was"
                ExpectResult   = [Pester.ShouldExpectResult]@{
                    Expected = "${commandName}${moduleMessage} not to be called exactly $Times times"
                    Actual   = "${commandName}${moduleMessage} was called $($matchingCalls.count) times"
                    Because  = Format-Because $Because
                }
            }
        }
        elseif ($matchingCalls.Count -ge $Times -and !$Exactly) {
            return [Pester.ShouldResult] @{
                Succeeded      = $false
                FailureMessage = "Expected ${commandName}${moduleMessage} to be called less than $Times times,$(Format-Because $Because) but was called $($matchingCalls.Count) times"
                ExpectResult   = [Pester.ShouldExpectResult]@{
                    Expected = "${commandName}${moduleMessage} to be called less than $Times times"
                    Actual   = "${commandName}${moduleMessage} was called $($matchingCalls.count) times"
                    Because  = Format-Because $Because
                }
            }
        }
    }
    else {
        if ($matchingCalls.Count -ne $Times -and ($Exactly -or ($Times -eq 0))) {
            return [Pester.ShouldResult] @{
                Succeeded      = $false
                FailureMessage = "Expected ${commandName}${moduleMessage} to be called $Times times exactly,$(Format-Because $Because) but was called $($matchingCalls.Count) times"
                ExpectResult   = [Pester.ShouldExpectResult]@{
                    Expected = "${commandName}${moduleMessage} to be called $Times times exactly"
                    Actual   = "${commandName}${moduleMessage} was called $($matchingCalls.count) times"
                    Because  = Format-Because $Because
                }
            }
        }
        elseif ($matchingCalls.Count -lt $Times) {
            return [Pester.ShouldResult] @{
                Succeeded      = $false
                FailureMessage = "Expected ${commandName}${moduleMessage} to be called at least $Times times,$(Format-Because $Because) but was called $($matchingCalls.Count) times"
                ExpectResult   = [Pester.ShouldExpectResult]@{
                    Expected = "${commandName}${moduleMessage} to be called at least $Times times"
                    Actual   = "${commandName}${moduleMessage} was called $($matchingCalls.count) times"
                    Because  = Format-Because $Because
                }
            }
        }
        elseif ($filterIsExclusive -and $nonMatchingCalls.Count -gt 0) {
            return [Pester.ShouldResult] @{
                Succeeded      = $false
                FailureMessage = "Expected ${commandName}${moduleMessage} to only be called with with parameters matching the specified filter,$(Format-Because $Because) but $($nonMatchingCalls.Count) non-matching calls were made"
                ExpectResult   = [Pester.ShouldExpectResult]@{
                    Expected = "${commandName}${moduleMessage} to only be called with with parameters matching the specified filter"
                    Actual   = "${commandName}${moduleMessage} was called $($nonMatchingCalls.Count) times with non-matching parameters"
                    Because  = Format-Because $Because
                }
            }
        }
    }

    return [Pester.ShouldResult] @{
        Succeeded      = $true
    }
}

function Remove-MockHook {
    param (
        [Parameter(Mandatory)]
        $Hooks
    )

    $removeMockStub = {
        param (
            [string] $CommandName,
            [string[]] $Aliases,
            [bool] $Write_Debug_Enabled,
            $Write_Debug
        )

        if ($ExecutionContext.InvokeProvider.Item.Exists("Function:\$CommandName", $true, $true)) {
            $ExecutionContext.InvokeProvider.Item.Remove("Function:\$CommandName", $false, $true, $true)
            if ($Write_Debug_Enabled) {
                & $Write_Debug -Scope Mock -Message "Removed function $($CommandName)$(if ($ExecutionContext.SessionState.Module) { " from module $($ExecutionContext.SessionState.Module) session state"} else { " from script session state"})."
            }
        }
        else {
            # # this runs from OnContainerRunEnd in the mock plugin, it might be running unnecessarily
            # if ($Write_Debug_Enabled) {
            #     & $Write_Debug -Scope Mock -Message "ERROR: Function $($CommandName) was not found$(if ($ExecutionContext.SessionState.Module) { " in module $($ExecutionContext.SessionState.Module) session state"} else { " in script session state"})."
            # }
        }

        foreach ($alias in $Aliases) {
            if ($ExecutionContext.InvokeProvider.Item.Exists("Alias:$alias", $true, $true)) {
                $ExecutionContext.InvokeProvider.Item.Remove("Alias:$alias", $false, $true, $true)
                if ($Write_Debug_Enabled) {
                    & $Write_Debug -Scope Mock -Message "Removed alias $($alias)$(if ($ExecutionContext.SessionState.Module) { " from module $($ExecutionContext.SessionState.Module) session state"} else { " from script session state"})."
                }
            }
            else {
                # # this runs from OnContainerRunEnd in the mock plugin, it might be running unnecessarily
                # if ($Write_Debug_Enabled) {
                #     & $Write_Debug -Scope Mock -Message "ERROR: Alias $($alias) was not found$(if ($ExecutionContext.SessionState.Module) { " in module $($ExecutionContext.SessionState.Module) session state"} else { " in script session state"})."
                # }
            }
        }
    }

    $Write_Debug_Enabled = $PesterPreference.Debug.WriteDebugMessages.Value
    $Write_Debug = $(if ($PesterPreference.Debug.WriteDebugMessages.Value) { $SafeCommands["Write-PesterDebugMessage"] } else { $null })

    foreach ($h in $Hooks) {
        if ($PesterPreference.Debug.WriteDebugMessages.Value) {
            Write-PesterDebugMessage -Scope Mock -Message "Removing function $($h.BootstrapFunctionName)$(if($h.Aliases) { " and aliases $($h.Aliases -join ", ")" }) for$(if($h.ModuleName) { " $($h.ModuleName) -" }) $($h.CommandName)."
        }

        $null = Invoke-InMockScope -SessionState $h.SessionState -ScriptBlock $removeMockStub -Arguments $h.BootstrapFunctionName, $h.Aliases, $Write_Debug_Enabled, $Write_Debug
    }
}

function Resolve-Command {
    param (
        [string] $CommandName,
        [string] $ModuleName,
        [Parameter(Mandatory)]
        [Management.Automation.SessionState] $SessionState
    )

    # saving the caller session state here, below the command is looked up and
    # the $SessionState is overwritten with the session state in which the command
    # was found (if -ModuleName was specified), but we will be running the mock body
    # in the caller scope (in the test scope), to be able to use the variables defined in the test inside of the mock
    # so we need to hold onto the caller scope
    $callerSessionState = $SessionState

    $command = $null
    $module = $null

    $findAndResolveCommand = {
        param ($Name)

        # this scriptblock gets bound to multiple session states so we can find
        # commands in module or in caller scope
        $command = $ExecutionContext.InvokeCommand.GetCommand($Name, 'All')
        # resolve command from alias recursively
        while ($null -ne $command -and $command.CommandType -eq [System.Management.Automation.CommandTypes]::Alias) {
            $resolved = $command.ResolvedCommand
            if ($null -eq $resolved) {
                throw "Alias $($command.Name) points to a command $($command.Definition) that but the actual commands no longer exists!"
            }
            $command = $resolved
        }

        if ($command) {
            $command

            # trying to resolve metadate for non scriptblock / cmdlet results in this beautiful error:
            # PSInvalidCastException: Cannot convert value "notepad.exe" to type "System.Management.Automation.CommandMetadata".
            # Error: "Cannot perform operation because operation "NewNotSupportedException at offset 34 in file:line:column <filename unknown>:0:0
            if ($command.PSObject.Properties['ScriptBlock'] -or $command.CommandType -eq 'Cmdlet') {
                # Resolve command metadata in the same scope where we resolved the command to have
                # all custom attributes available https://github.com/pester/Pester/issues/1772
                [System.Management.Automation.CommandMetaData] $command
                # resolve it one more time because we need two instances sometimes for dynamic
                # parameters resolve
                [System.Management.Automation.CommandMetaData] $command
            }
        }
    }

    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
        Write-PesterDebugMessage -Scope Mock "Resolving command $CommandName."
    }

    if ($ModuleName) {
        if ($PesterPreference.Debug.WriteDebugMessages.Value) {
            Write-PesterDebugMessage -Scope Mock "ModuleName was specified searching for the command in module $ModuleName."
        }

        if ($null -ne $callerSessionState.Module -and $callerSessionState.Module.Name -eq $ModuleName) {
            if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                Write-PesterDebugMessage -Scope Mock "We are already running in $ModuleName. Using that."
            }

            $module = $callerSessionState.Module
            $SessionState = $callerSessionState
        }
        else {
            $module = Get-CompatibleModule -ModuleName $ModuleName -ErrorAction Stop
            if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                Write-PesterDebugMessage -Scope Mock "Found module $($module.Name) version $($module.Version)."
            }

            # this is the target session state in which we will insert the mock
            $SessionState = $module.SessionState
        }

        $command, $commandMetadata, $commandMetadata2 = & $module $findAndResolveCommand -Name $CommandName
        if ($command) {
            if ($command.Module -eq $module) {
                if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                    Write-PesterDebugMessage -Scope Mock "Found the command $($CommandName) in module $($module.Name) version $($module.Version)$(if ($CommandName -ne $command.Name) {" and it resolved to $($command.Name)"})."
                }
            }
            else {
                if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                    Write-PesterDebugMessage -Scope Mock "Found the command $($CommandName) in a different module$(if ($CommandName -ne $command.Name) {" and it resolved to $($command.Name)"})."
                }
            }
        }
        else {
            if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                Write-PesterDebugMessage -Scope Mock "Did not find command $CommandName in module $($module.Name) version $($module.Version)."
            }
        }
    }
    else {
        # we used to fallback to the script scope when command was not found in the module, we no longer do that
        # now we just search the script scope when module name is not specified. This was probably needed because of
        # some inconsistencies of resolving the mocks. But it never made sense to me.

        if ($PesterPreference.Debug.WriteDebugMessages.Value) {
            Write-PesterDebugMessage -Scope Mock "Searching for command $CommandName in the script scope."
        }
        Set-ScriptBlockScope -ScriptBlock $findAndResolveCommand -SessionState $SessionState
        $command, $commandMetadata, $commandMetadata2 = & $findAndResolveCommand -Name $CommandName
        if ($command) {
            if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                Write-PesterDebugMessage -Scope Mock "Found the command $CommandName in the script scope$(if ($CommandName -ne $command.Name) {" and it resolved to $($command.Name)"})."
            }
        }
        else {
            if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                Write-PesterDebugMessage -Scope Mock "Did not find command $CommandName in the script scope."
            }
        }
    }

    if (-not $command) {
        throw ([System.Management.Automation.CommandNotFoundException] "Could not find Command $CommandName")
    }


    if ($command.Name -like 'PesterMock_*') {
        if ($PesterPreference.Debug.WriteDebugMessages.Value) {
            Write-PesterDebugMessage -Scope MockCore "The resolved command is a mock bootstrap function, pointing the mock to the same command info and session state as the original mock."
        }
        # the target module into which we inserted the mock
        $module = $command.Mock.Hook.SessionState.Module
        return @{
            Command                 = $command.Mock.Hook.OriginalCommand
            CommandMetadata         = $command.Mock.Hook.OriginalMetadata
            CommandMetadata2        = $command.Mock.Hook.OriginalMetadata2
            # the session state of the target module
            SessionState            = $command.Mock.Hook.SessionState
            # the session state in which we invoke the mock body (where the test runs)
            CallerSessionState      = $command.Mock.Hook.CallerSessionState
            # the module that defines the command
            Module                  = $command.Mock.Hook.OriginalCommand.Module
            # true if we inserted the mock into a module
            IsFromModule            = $null -ne $module
            TargetModule            = $ModuleName
            # true if the command comes from the target module
            IsFromTargetModule      = $null -ne $module -and $ModuleName -eq $command.Mock.Hook.OriginalCommand.Module.Name
            IsMockBootstrapFunction = $true
            Hook                    = $command.Mock.Hook
        }
    }

    $module = $command.Module
    return @{
        Command                 = $command
        CommandMetadata         = $commandMetadata
        CommandMetadata2        = $commandMetadata2
        SessionState            = $SessionState
        CallerSessionState      = $callerSessionState
        Module                  = $module

        IsFromModule            = $null -ne $module
        # The target module in which we are inserting the mock, this may not be the same as the module in which the
        # function is defined. For example when module m exports function f, and we mock it in script scope or in module o.
        # They would be the same if we mock an internal function in module m by specifying -ModuleName m, to be able to test it.
        TargetModule            = $ModuleName
        IsFromTargetModule      = $null -ne $module -and $module.Name -eq $ModuleName
        IsMockBootstrapFunction = $false
        Hook                    = $null
    }
}

function Invoke-MockInternal {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $CommandName,

        [Parameter(Mandatory = $true)]
        [hashtable] $MockCallState,

        [string]
        $ModuleName,

        [hashtable]
        $BoundParameters = @{ },

        [object[]]
        $ArgumentList = @(),

        [object] $CallerSessionState,

        [ValidateSet('Begin', 'Process', 'End')]
        [string] $FromBlock,

        [object] $InputObject,

        [Parameter(Mandatory)]
        $Behaviors,

        [Parameter(Mandatory)]
        [HashTable]
        $CallHistory,

        [Parameter(Mandatory)]
        $Hook
    )

    switch ($FromBlock) {
        Begin {
            $MockCallState['InputObjects'] = [System.Collections.Generic.List[object]]@()
            $MockCallState['ShouldExecuteOriginalCommand'] = $false
            $MockCallState['BeginBoundParameters'] = $BoundParameters.Clone()
            # argument list must not be null, if the bootstrap functions has no parameters
            # we get null and need to replace it with empty array to make the splatting work
            # later on.
            $MockCallState['BeginArgumentList'] = $ArgumentList

            return
        }

        Process {
            # the incoming caller session state is the place from where
            # the mock hook is invoked, this does not have to be the same as
            # the test "caller scope" that we saved earlier, we won't use the
            # test caller scope here, but the scope from which the mock was called
            $SessionState = if ($CallerSessionState) { $CallerSessionState } else { $Hook.SessionState }

            # the @() are needed for powerShell3 otherwise it throws CheckAutomationNullInCommandArgumentArray (unless there is any breakpoint defined anywhere, then it works just fine :DDD)
            $behavior = FindMatchingBehavior -Behaviors @($Behaviors) -BoundParameters $BoundParameters -ArgumentList @($ArgumentList) -SessionState $SessionState -Hook $Hook

            if ($null -ne $behavior) {
                $call = @{
                    BoundParams = $BoundParameters
                    Args        = $ArgumentList
                    Hook        = $Hook
                    Behavior    = $behavior
                }
                $key = "$($behavior.ModuleName)||$($behavior.CommandName)"
                if (-not $CallHistory.ContainsKey($key)) {
                    $CallHistory.Add($key, [Collections.Generic.List[object]]@($call))
                }
                else {
                    $CallHistory[$key].Add($call)
                }

                ExecuteBehavior -Behavior $behavior `
                    -Hook $Hook `
                    -BoundParameters $BoundParameters `
                    -ArgumentList @($ArgumentList)

                return
            }
            else {
                $MockCallState['ShouldExecuteOriginalCommand'] = $true
                if ($null -ne $InputObject) {
                    $null = $MockCallState['InputObjects'].AddRange(@($InputObject))
                }

                return
            }
        }

        End {
            if ($MockCallState['ShouldExecuteOriginalCommand']) {
                if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                    Write-PesterDebugMessage -Scope Mock "Invoking the original command."
                }

                $MockCallState['BeginBoundParameters'] = Reset-ConflictingParameters -BoundParameters $MockCallState['BeginBoundParameters']

                if ($MockCallState['InputObjects'].Count -gt 0) {
                    $scriptBlock = {
                        param ($Command, $ArgumentList, $BoundParameters, $InputObjects)
                        $InputObjects | & $Command @ArgumentList @BoundParameters
                    }
                }
                else {
                    $scriptBlock = {
                        param ($Command, $ArgumentList, $BoundParameters, $InputObjects)
                        & $Command @ArgumentList @BoundParameters
                    }
                }

                $SessionState = if ($CallerSessionState) {
                    $CallerSessionState
                }
                else {
                    $Hook.SessionState
                }

                Set-ScriptBlockScope -ScriptBlock $scriptBlock -SessionState $SessionState

                # In order to mock Set-Variable correctly we need to write the variable
                # two scopes above
                if ("Set-Variable" -eq $Hook.OriginalCommand.Name) {
                    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                        Write-PesterDebugMessage -Scope Mock "Original command is Set-Variable, patching the call."
                    }
                    if ($MockCallState['BeginBoundParameters'].Keys -notcontains "Scope") {
                        $MockCallState['BeginBoundParameters'].Add( "Scope", 2)
                    }
                    # local is the same as scope 0, in that case we also write to scope 2
                    elseif ("Local", "0" -contains $MockCallState['BeginBoundParameters'].Scope) {
                        $MockCallState['BeginBoundParameters'].Scope = 2
                    }
                    elseif ($MockCallState['BeginBoundParameters'].Scope -match "\d+") {
                        $MockCallState['BeginBoundParameters'].Scope = 2 + $matches[0]
                    }
                    else {
                        # not sure what the user did, but we won't change it
                    }
                }

                if ($null -eq ($MockCallState['BeginArgumentList'])) {
                    $arguments = @()
                }
                else {
                    $arguments = $MockCallState['BeginArgumentList']
                }
                if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                    Write-ScriptBlockInvocationHint -Hint "Mock - Original Command" -ScriptBlock $scriptBlock
                }
                & $scriptBlock -Command $Hook.OriginalCommand `
                    -ArgumentList $arguments `
                    -BoundParameters $MockCallState['BeginBoundParameters'] `
                    -InputObjects $MockCallState['InputObjects']
            }
        }
    }
}

function FindMock {
    param (
        [Parameter(Mandatory)]
        [String] $CommandName,
        $ModuleName,
        [Parameter(Mandatory)]
        [HashTable] $MockTable
    )

    $result = @{
        Mock        = $null
        MockFound   = $false
        CommandName = $CommandName
        ModuleName  = $ModuleName
    }
    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
        Write-PesterDebugMessage -Scope Mock "Looking for mock $($ModuleName)||$CommandName."
    }
    $MockTable["$($ModuleName)||$CommandName"]

    if ($null -ne $mock) {
        if ($PesterPreference.Debug.WriteDebugMessages.Value) {
            Write-PesterDebugMessage -Scope Mock "Found mock $(if (-not [string]::IsNullOrEmpty($ModuleName)) {"with module name $($ModuleName)"})||$CommandName."
        }
        $result.MockFound = $true
    }
    else {
        if ($PesterPreference.Debug.WriteDebugMessages.Value) {
            Write-PesterDebugMessage -Scope Mock "No mock found, re-trying without module name ||$CommandName."
        }
        $mock = $MockTable["||$CommandName"]
        $result.ModuleName = $null
        if ($null -ne $mock) {
            if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                Write-PesterDebugMessage -Scope Mock "Found mock without module name, setting the target module to empty."
            }
            $result.MockFound = $true
        }
        else {
            $result.MockFound = $false
        }
    }

    return $result
}

function FindMatchingBehavior {
    param (
        [Parameter(Mandatory)]
        $Behaviors,
        [hashtable] $BoundParameters = @{ },
        [object[]] $ArgumentList = @(),
        [Parameter(Mandatory)]
        [Management.Automation.SessionState] $SessionState,
        $Hook
    )

    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
        Write-PesterDebugMessage -Scope Mock "Finding behavior to use, one that passes filter or a default:"
    }

    $foundDefaultBehavior = $false
    $defaultBehavior = $null
    foreach ($b in $Behaviors) {

        if ($b.IsDefault -and -not $foundDefaultBehavior) {
            # store the most recently defined default behavior we find
            $defaultBehavior = $b
            $foundDefaultBehavior = $true
        }

        if (-not $b.IsDefault) {
            $params = @{
                ScriptBlock     = $b.Filter
                BoundParameters = $BoundParameters
                ArgumentList    = $ArgumentList
                Metadata        = $Hook.Metadata
                SessionState    = $Hook.CallerSessionState
            }

            if (Test-ParameterFilter @params) {
                if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                    Write-PesterDebugMessage -Scope Mock "{ $($b.ScriptBlock) } passed parameter filter and will be used for the mock call."
                }
                return $b
            }
        }
    }

    if ($foundDefaultBehavior) {
        if ($PesterPreference.Debug.WriteDebugMessages.Value) {
            Write-PesterDebugMessage -Scope Mock "{ $($defaultBehavior.ScriptBlock) } is a default behavior and will be used for the mock call."
        }
        return $defaultBehavior
    }

    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
        Write-PesterDebugMessage -Scope Mock "No parametrized or default behaviors were found filter."
    }
    return $null
}

function LastThat {
    param (
        $Collection,
        $Predicate
    )

    $count = $Collection.Count
    for ($i = $count; $i -gt 0; $i--) {
        $item = $Collection[$i]
        if (&$Predicate $Item) {
            return $Item
        }
    }
}


function ExecuteBehavior {
    param (
        $Behavior,
        $Hook,
        [hashtable] $BoundParameters = @{ },
        [object[]] $ArgumentList = @()
    )

    $ModuleName = $Behavior.ModuleName
    $CommandName = $Behavior.CommandName
    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
        Write-PesterDebugMessage -Scope Mock "Executing mock behavior for mock$(if ($ModuleName) {" $ModuleName -" }) $CommandName."
    }

    $Behavior.Executed = $true

    $scriptBlock = {
        param (
            [Parameter(Mandatory = $true)]
            [scriptblock]
            ${Script Block},

            [hashtable]
            $___BoundParameters___ = @{ },

            [object[]]
            $___ArgumentList___ = @(),

            [System.Management.Automation.CommandMetadata]
            ${Meta data},

            [System.Management.Automation.SessionState]
            ${Session State},

            ${R e p o r t S c o p e},

            ${M o d u l e N a m e},

            ${Set Dynamic Parameter Variable}
        )

        # This script block exists to hold variables without polluting the test script's current scope.
        # Dynamic parameters in functions, for some reason, only exist in $PSBoundParameters instead
        # of being assigned a local variable the way static parameters do.  By calling Set-DynamicParameterVariable,
        # we create these variables for the caller's use in a Parameter Filter or within the mock itself, and
        # by doing it inside this temporary script block, those variables don't stick around longer than they
        # should.

        & ${Set Dynamic Parameter Variable} -SessionState ${Session State} -Parameters $___BoundParameters___ -Metadata ${Meta data}
        # Name property is not present on Application Command metadata in PowerShell 2
        & ${R e p o r t S c o p e} -ModuleName ${M o d u l e N a m e} -CommandName $(try {
                ${Meta data}.Name
            }
            catch {
            }) -ScriptBlock ${Script Block}
        # define this in the current scope to be used instead of $PSBoundParameter if needed
        $PesterBoundParameters = if ($null -ne $___BoundParameters___) { $___BoundParameters___ } else { @{} }
        & ${Script Block} @___BoundParameters___ @___ArgumentList___
    }

    if ($null -eq $Hook) {
        throw "Hook should not be null."
    }

    if ($null -eq $Hook.SessionState) {
        throw "Hook.SessionState should not be null."
    }

    Set-ScriptBlockScope -ScriptBlock $scriptBlock -SessionState $Hook.CallerSessionState
    $splat = @{
        'Script Block'                   = $Behavior.ScriptBlock
        '___ArgumentList___'             = $ArgumentList
        '___BoundParameters___'          = $BoundParameters
        'Meta data'                      = $Hook.Metadata
        'Session State'                  = $Hook.CallerSessionState
        'R e p o r t S c o p e'          = {
            param ($CommandName, $ModuleName, $ScriptBlock)
            if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                Write-ScriptBlockInvocationHint -Hint "Mock - of command $CommandName$(if ($ModuleName) { "from module $ModuleName"})" -ScriptBlock $ScriptBlock
            }
        }
        'Set Dynamic Parameter Variable' = $SafeCommands['Set-DynamicParameterVariable']
    }

    # the real scriptblock is passed to the other one, we are interested in the mock, not the wrapper, so I pass $block.ScriptBlock, and not $scriptBlock
    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
        Write-ScriptBlockInvocationHint -Hint "Mock - of command $CommandName$(if ($ModuleName) { "from module $ModuleName"})" -ScriptBlock ($behavior.ScriptBlock)
    }
    & $scriptBlock @splat
    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
        Write-PesterDebugMessage -Scope Mock "Behavior for$(if ($ModuleName) { " $ModuleName -"}) $CommandName was executed."
    }
}

function Invoke-InMockScope {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [System.Management.Automation.SessionState]
        $SessionState,

        [Parameter(Mandatory = $true)]
        [scriptblock]
        $ScriptBlock,

        [Parameter(Mandatory = $true)]
        $Arguments,

        [Switch]
        $NoNewScope
    )

    Set-ScriptBlockScope -ScriptBlock $ScriptBlock -SessionState $SessionState
    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
        Write-ScriptBlockInvocationHint -Hint "Mock - InMockScope" -ScriptBlock $ScriptBlock
    }
    if ($NoNewScope) {
        . $ScriptBlock @Arguments
    }
    else {
        & $ScriptBlock @Arguments
    }
}

function Test-ParameterFilter {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [scriptblock]
        $ScriptBlock,

        [System.Collections.IDictionary]
        $BoundParameters,

        [object[]]
        $ArgumentList,

        [System.Management.Automation.CommandMetadata]
        $Metadata,

        [Parameter(Mandatory)]
        [Management.Automation.SessionState]
        $SessionState
    )

    if ($null -eq $BoundParameters) {
        $BoundParameters = @{ }
    }

    $arguments = $ArgumentList
    # $() gets rid of the @() defined for powershell 3
    if ($null -eq $($ArgumentList)) {
        $arguments = @()
    }

    $context = Get-ContextToDefine -BoundParameters $BoundParameters -Metadata $Metadata

    $wrapper = {
        param ($private:______mock_parameters)
        & $private:______mock_parameters.Set_StrictMode -Off

        foreach ($private:______current in $private:______mock_parameters.Context.GetEnumerator()) {
            $private:______mock_parameters.SessionState.PSVariable.Set($private:______current.Key, $private:______current.Value)
        }

        # define this in the current scope to be used instead of $PSBoundParameter if needed
        $PesterBoundParameters = if ($null -ne $private:______mock_parameters.Context) { $private:______mock_parameters.Context } else { @{} }

        #TODO: a hacky solution to make Should throw on failure in Mock ParameterFilter, to make it good enough for the first release $______isInMockParameterFilter
        # this should not be private, it should leak into Should command when used in ParameterFilter
        $______isInMockParameterFilter = $true
        # $private:BoundParameters = $private:______mock_parameters.BoundParameters
        $private:______arguments = $private:______mock_parameters.Arguments
        # TODO: not binding the bound parameters here because it would make the parameters unbound when the user does
        # not provide a param block, which they would never provide, so that is okay, but if there is a workaround this then
        # it would be nice to have. maybe changing the order in which I bind?
        & $private:______mock_parameters.ScriptBlock @______arguments
    }

    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
        $hasContext = 0 -lt $Context.Count
        $c = $(if ($hasContext) { foreach ($p in $Context.GetEnumerator()) { "$($p.Key) = $($p.Value)" } }) -join ", "
        Write-PesterDebugMessage -Scope Mock -Message "Running mock filter { $scriptBlock } $(if ($hasContext) { "with context: $c" } else { "without any context"})."
    }

    Set-ScriptBlockScope -ScriptBlock $wrapper -SessionState $SessionState

    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
        Write-ScriptBlockInvocationHint -Hint "Mock - Parameter filter" -ScriptBlock $wrapper
    }
    $parameters = @{
        ScriptBlock        = $ScriptBlock
        BoundParameters    = $BoundParameters
        Arguments          = $Arguments
        SessionState       = $SessionState
        Context            = $context
        Set_StrictMode     = $SafeCommands['Set-StrictMode']
        WriteDebugMessages = $PesterPreference.Debug.WriteDebugMessages.Value
        Write_DebugMessage = if ($PesterPreference.Debug.WriteDebugMessages.Value) {
            { param ($Message) & $SafeCommands["Write-PesterDebugMessage"] -Scope Mock -Message $Message }
        }
        else { $null }
    }

    $result = & $wrapper $parameters
    if ($result) {
        if ($PesterPreference.Debug.WriteDebugMessages.Value) {
            Write-PesterDebugMessage -Scope Mock -Message "Mock filter returned value '$result', which is truthy. Filter passed."
        }
    }
    else {
        if ($PesterPreference.Debug.WriteDebugMessages.Value) {
            Write-PesterDebugMessage -Scope Mock -Message "Mock filter returned value '$result', which is falsy. Filter did not pass."
        }
    }
    $result
}

function Get-ContextToDefine {
    param (
        [System.Collections.IDictionary] $BoundParameters,
        [System.Management.Automation.CommandMetadata] $Metadata
    )

    $conflictingParameterNames = Get-ConflictingParameterNames
    $r = @{ }
    # key the parameters by aliases so we can resolve to
    # the param itself and define it and all of it's aliases
    $h = @{ }
    if ($null -eq $Metadata) {
        # there is no metadata so there will be no aliases
        # return the parameters that we got, just fix the conflicting
        # names
        foreach ($p in $BoundParameters.GetEnumerator()) {
            $name = if ($p.Key -in $conflictingParameterNames) {
                if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                    Write-PesterDebugMessage -Scope Mock -Message "! Variable `$$($p.Key) is a built-in variable, rewriting it to `$_$($p.Key). Use the version with _ in your -ParameterFilter."
                }
                "_$($p.Key)"
            }
            else {
                $p.Key
            }

            $r.Add($name, $p.Value)
        }

        return $r
    }

    foreach ($p in $Metadata.Parameters.GetEnumerator()) {
        $aliases = $p.Value.Aliases
        if ($null -ne $aliases -and 0 -lt @($aliases).Count) {
            foreach ($a in $aliases) { $h.Add($a, $p) }
        }
    }

    foreach ($param in $BoundParameters.GetEnumerator()) {
        $parameterInfo = if ($h.ContainsKey($param.Key)) {
            $h.($param.Key)
        }
        elseif ($Metadata.Parameters.ContainsKey($param.Key)) {
            $Metadata.Parameters.($param.Key)
        }

        $value = $param.Value

        if ($parameterInfo) {
            foreach ($p in $parameterInfo) {
                $name = if ($p.Name -in $conflictingParameterNames) {
                    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                        Write-PesterDebugMessage -Scope Mock -Message "! Variable `$$($p.Name) is a built-in variable, rewriting it to `$_$($p.Name). Use the version with _ in your -ParameterFilter."
                    }
                    "_$($p.Name)"
                }
                else {
                    $p.Name
                }

                if (-not $r.ContainsKey($name)) {
                    $r.Add($name, $value)
                }

                foreach ($a in $p.Aliases) {
                    $name = if ($a -in $conflictingParameterNames) {
                        if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                            Write-PesterDebugMessage -Scope Mock -Message "! Variable `$$($a) is a built-in variable, rewriting it to `$_$($a). Use the version with _ in your -ParameterFilter."
                        }
                        "_$($a)"
                    }
                    else {
                        $a
                    }

                    if (-not $r.ContainsKey($name)) {
                        $r.Add($name, $value)
                    }
                }
            }
        }
        else {
            # the parameter is not defined in the parameter set,
            # it is probably dynamic, let's see if I can get away with just adding
            # it to the list of stuff to define

            $name = if ($param.Key -in $script:ConflictingParameterNames) {
                if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                    Write-PesterDebugMessage -Scope Mock -Message "! Variable `$$($param.Key) is a built-in variable, rewriting it to `$_$($param.Key). Use the version with _ in your -ParameterFilter."
                }
                "_$($param.Key)"
            }
            else {
                $param.Key
            }

            if (-not $r.ContainsKey($name)) {
                $r.Add($name, $param.Value)
            }
        }
    }

    $r
}

function IsCommonParameter {
    param (
        [string] $Name,
        [System.Management.Automation.CommandMetadata] $Metadata
    )

    if ($null -ne $Metadata) {
        if ([System.Management.Automation.Internal.CommonParameters].GetProperty($Name)) {
            return $true
        }
        if ($Metadata.SupportsShouldProcess -and [System.Management.Automation.Internal.ShouldProcessParameters].GetProperty($Name)) {
            return $true
        }
        if ($Metadata.SupportsPaging -and [System.Management.Automation.PagingParameters].GetProperty($Name)) {
            return $true
        }
        if ($Metadata.SupportsTransactions -and [System.Management.Automation.Internal.TransactionParameters].GetProperty($Name)) {
            return $true
        }
    }

    return $false
}

function Set-DynamicParameterVariable {
    <#
        .SYNOPSIS
        This command is used by Pester's Mocking framework.  You do not need to call it directly.
    #>

    param (
        [Parameter(Mandatory = $true)]
        [System.Management.Automation.SessionState]
        $SessionState,

        [hashtable]
        $Parameters,

        [System.Management.Automation.CommandMetadata]
        $Metadata
    )

    if ($null -eq $Parameters) {
        $Parameters = @{ }
    }

    foreach ($keyValuePair in $Parameters.GetEnumerator()) {
        $variableName = $keyValuePair.Key

        if (-not (IsCommonParameter -Name $variableName -Metadata $Metadata)) {
            if ($ExecutionContext.SessionState -eq $SessionState) {
                & $SafeCommands['Set-Variable'] -Scope 1 -Name $variableName -Value $keyValuePair.Value -Force -Confirm:$false -WhatIf:$false
            }
            else {
                $SessionState.PSVariable.Set($variableName, $keyValuePair.Value)
            }
        }
    }
}

function Get-DynamicParamBlock {
    param (
        [scriptblock] $ScriptBlock
    )

    if ($ScriptBlock.AST.psobject.Properties.Name -match "Body") {
        if ($null -ne $ScriptBlock.Ast.Body.DynamicParamBlock) {
            $statements = $ScriptBlock.Ast.Body.DynamicParamBlock.Statements.Extent.Text

            return $statements -join [System.Environment]::NewLine
        }
    }
}

function Get-MockDynamicParameter {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ParameterSetName = 'Cmdlet')]
        [string] $CmdletName,

        [Parameter(Mandatory = $true, ParameterSetName = 'Function')]
        [string] $FunctionName,

        [Parameter(ParameterSetName = 'Function')]
        [string] $ModuleName,

        [System.Collections.IDictionary] $Parameters,

        [object] $Cmdlet,

        [Parameter(ParameterSetName = "Function")]
        $DynamicParamScriptBlock
    )

    switch ($PSCmdlet.ParameterSetName) {
        'Cmdlet' {
            Get-DynamicParametersForCmdlet -CmdletName $CmdletName -Parameters $Parameters
        }

        'Function' {
            Get-DynamicParametersForMockedFunction -DynamicParamScriptBlock $DynamicParamScriptBlock -Parameters $Parameters -Cmdlet $Cmdlet
        }
    }
}

function Get-DynamicParametersForCmdlet {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string] $CmdletName,

        [ValidateScript( {
                if ($PSVersionTable.PSVersion.Major -ge 3 -and
                    $null -ne $_ -and
                    $_.GetType().FullName -ne 'System.Management.Automation.PSBoundParametersDictionary') {
                    throw 'The -Parameters argument must be a PSBoundParametersDictionary object ($PSBoundParameters).'
                }

                return $true
            })]
        [System.Collections.IDictionary] $Parameters
    )

    try {
        $command = & $SafeCommands['Get-Command'] -Name $CmdletName -CommandType Cmdlet -ErrorAction Stop

        if (@($command).Count -gt 1) {
            throw "Name '$CmdletName' resolved to multiple Cmdlets"
        }
    }
    catch {
        $PSCmdlet.ThrowTerminatingError($_)
    }

    if ($null -eq $command.ImplementingType.GetInterface('IDynamicParameters', $true)) {
        return
    }

    if ('5.0.10586.122' -lt $PSVersionTable.PSVersion) {
        # Older version of PS required Reflection to do this.  It has run into problems on occasion with certain cmdlets,
        # such as ActiveDirectory and AzureRM, so we'll take advantage of the newer PSv5 engine features if at all possible.

        if ($null -eq $Parameters) {
            $paramsArg = @()
        }
        else {
            $paramsArg = @($Parameters)
        }

        $command = $ExecutionContext.InvokeCommand.GetCommand($CmdletName, [System.Management.Automation.CommandTypes]::Cmdlet, $paramsArg)
        $paramDictionary = [System.Management.Automation.RuntimeDefinedParameterDictionary]::new()

        foreach ($param in $command.Parameters.Values) {
            if (-not $param.IsDynamic) {
                continue
            }
            if ($Parameters.ContainsKey($param.Name)) {
                continue
            }

            $dynParam = [System.Management.Automation.RuntimeDefinedParameter]::new($param.Name, $param.ParameterType, $param.Attributes)
            $paramDictionary.Add($param.Name, $dynParam)
        }

        return $paramDictionary
    }
    else {
        if ($null -eq $Parameters) {
            $Parameters = @{ }
        }

        $cmdlet = & $SafeCommands['New-Object'] $command.ImplementingType.FullName

        $flags = [System.Reflection.BindingFlags]'Instance, Nonpublic'
        $context = $ExecutionContext.GetType().GetField('_context', $flags).GetValue($ExecutionContext)
        [System.Management.Automation.Cmdlet].GetProperty('Context', $flags).SetValue($cmdlet, $context, $null)

        foreach ($keyValuePair in $Parameters.GetEnumerator()) {
            $property = $cmdlet.GetType().GetProperty($keyValuePair.Key)
            if ($null -eq $property -or -not $property.CanWrite) {
                continue
            }

            $isParameter = [bool]($property.GetCustomAttributes([System.Management.Automation.ParameterAttribute], $true))
            if (-not $isParameter) {
                continue
            }

            $property.SetValue($cmdlet, $keyValuePair.Value, $null)
        }

        try {
            # This unary comma is important in some cases.  On Windows 7 systems, the ActiveDirectory module cmdlets
            # return objects from this method which implement IEnumerable for some reason, and even cause PowerShell
            # to throw an exception when it tries to cast the object to that interface.

            # We avoid that problem by wrapping the result of GetDynamicParameters() in a one-element array with the
            # unary comma.  PowerShell enumerates that array instead of trying to enumerate the goofy object, and
            # everyone's happy.

            # Love the comma.  Don't delete it.  We don't have a test for this yet, unless we can get the AD module
            # on a Server 2008 R2 build server, or until we write some C# code to reproduce its goofy behavior.

            , $cmdlet.GetDynamicParameters()
        }
        catch [System.NotImplementedException] {
            # Some cmdlets implement IDynamicParameters but then throw a NotImplementedException.  I have no idea why.  Ignore them.
        }
    }
}

function Get-DynamicParametersForMockedFunction {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        $DynamicParamScriptBlock,

        [System.Collections.IDictionary]
        $Parameters,

        [object]
        $Cmdlet
    )

    if ($DynamicParamScriptBlock) {
        $splat = @{ 'P S Cmdlet' = $Cmdlet }
        return & $DynamicParamScriptBlock @Parameters @splat
    }
}

function Test-IsClosure {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [scriptblock]
        $ScriptBlock
    )

    $sessionStateInternal = $script:ScriptBlockSessionStateInternalProperty.GetValue($ScriptBlock)
    if ($null -eq $sessionStateInternal) {
        return $false
    }

    $flags = [System.Reflection.BindingFlags]'Instance,NonPublic'
    $module = $sessionStateInternal.GetType().GetProperty('Module', $flags).GetValue($sessionStateInternal, $null)

    return (
        $null -ne $module -and
        $module.Name -match '^__DynamicModule_([a-f\d-]+)$' -and
        $null -ne ($matches[1] -as [guid])
    )
}

function Remove-MockFunctionsAndAliases ($SessionState) {
    # when a test is terminated (e.g. by stopping at a breakpoint and then stopping the execution of the script)
    # the aliases and bootstrap functions for the currently mocked functions will remain in place
    # Then on subsequent runs the bootstrap function will be picked up instead of the real command,
    # because there is still an alias associated with it, and the test will fail.
    # So before putting Pester state in place we should make sure that all Pester mocks are gone
    # by deleting every alias pointing to a function that starts with PesterMock_. Then we also delete the
    # bootstrap function.
    #
    # Avoid using Get-Command to find mock functions, it is slow. https://github.com/pester/Pester/discussions/2331
    $Get_Alias = $script:SafeCommands['Get-Alias']
    $Get_ChildItem = $script:SafeCommands['Get-ChildItem']
    $Remove_Item = $script:SafeCommands['Remove-Item']
    foreach ($alias in (& $Get_Alias -Definition "PesterMock_*")) {
        & $Remove_Item "alias:/$($alias.Name)"
    }

    foreach ($bootstrapFunction in (& $Get_ChildItem -Name "function:/PesterMock_*")) {
        & $Remove_Item "function:/$($bootstrapFunction)" -Recurse -Force -Confirm:$false
    }

    $ScriptBlock = {
        param ($Get_Alias, $Get_ChildItem, $Remove_Item)
        foreach ($alias in (& $Get_Alias -Definition "PesterMock_*")) {
            & $Remove_Item "alias:/$($alias.Name)"
        }

        foreach ($bootstrapFunction in (& $Get_ChildItem -Name "function:/PesterMock_*")) {
            & $Remove_Item "function:/$($bootstrapFunction)" -Recurse -Force -Confirm:$false
        }
    }

    # clean up in caller session state
    Set-ScriptBlockScope -SessionState $SessionState -ScriptBlock $ScriptBlock
    & $ScriptBlock $Get_Alias $Get_ChildItem $Remove_Item

    # clean up also in all loaded script and manifest modules
    $modules = & $script:SafeCommands['Get-Module']
    foreach ($module in $modules) {
        # we cleaned up in module on the start of this method without overhead of moving to module scope
        if ('pester' -eq $module.Name) {
            continue
        }

        # some script modules apparently can have no session state
        # https://github.com/PowerShell/PowerShell/blob/658837323599ab1c7a81fe66fcd43f7420e4402b/src/System.Management.Automation/engine/runtime/Operations/MiscOps.cs#L51-L55
        # https://github.com/pester/Pester/issues/1921
        if ('Script', 'Manifest' -contains $module.ModuleType -and $null -ne $module.SessionState) {
            & ($module) $ScriptBlock $Get_Alias $Get_ChildItem $Remove_Item
        }
    }
}

function Repair-ConflictingParameters {
    [CmdletBinding()]
    [OutputType([System.Management.Automation.CommandMetadata])]
    param(
        [Parameter(Mandatory = $true)]
        [System.Management.Automation.CommandMetadata]
        $Metadata,
        [Parameter()]
        [string[]]
        $RemoveParameterType,
        [Parameter()]
        [string[]]
        $RemoveParameterValidation
    )

    $repairedMetadata = [System.Management.Automation.CommandMetadata]$Metadata
    $paramMetadatas = [Collections.Generic.List[object]]@($repairedMetadata.Parameters.Values)

    # unnecessary function call that could be replaced by variable access, but is needed for tests
    $conflictingParams = Get-ConflictingParameterNames

    foreach ($paramMetadata in $paramMetadatas) {
        if ($paramMetadata.IsDynamic) {
            continue
        }

        # rewrite the metadata to avoid defining conflicting parameters
        # in the function such as $PSEdition
        if ($conflictingParams -contains $paramMetadata.Name) {
            $paramName = $paramMetadata.Name
            $newName = "_$paramName"
            $paramMetadata.Name = $newName
            $paramMetadata.Aliases.Add($paramName)

            $null = $repairedMetadata.Parameters.Remove($paramName)
            $repairedMetadata.Parameters.Add($newName, $paramMetadata)
        }

        $attrIndexesToRemove = [System.Collections.Generic.List[int]]@()

        if ($RemoveParameterType -contains $paramMetadata.Name) {
            $paramMetadata.ParameterType = [object]

            for ($i = 0; $i -lt $paramMetadata.Attributes.Count; $i++) {
                $attr = $paramMetadata.Attributes[$i]
                if ($attr -is [PSTypeNameAttribute]) {
                    $null = $attrIndexesToRemove.Add($i)
                    break
                }
            }
        }

        if ($RemoveParameterValidation -contains $paramMetadata.Name) {
            for ($i = 0; $i -lt $paramMetadata.Attributes.Count; $i++) {
                $attr = $paramMetadata.Attributes[$i]
                if ($attr -is [System.Management.Automation.ValidateArgumentsAttribute]) {
                    $null = $attrIndexesToRemove.Add($i)
                }
            }
        }

        # remove attributes in reverse order to avoid index shifting
        $attrIndexesToRemove.Sort()
        $attrIndexesToRemove.Reverse()
        foreach ($index in $attrIndexesToRemove) {
            $null = $paramMetadata.Attributes.RemoveAt($index)
        }
    }

    $repairedMetadata
}

function Reset-ConflictingParameters {
    [CmdletBinding()]
    [OutputType([hashtable])]
    param(
        [Parameter(Mandatory = $true)]
        [hashtable]
        $BoundParameters
    )

    $parameters = $BoundParameters.Clone()
    # unnecessary function call that could be replaced by variable access, but is needed for tests
    $names = Get-ConflictingParameterNames

    foreach ($param in $names) {
        $fixedName = "_$param"

        if (-not $parameters.ContainsKey($fixedName)) {
            continue
        }

        $parameters[$param] = $parameters[$fixedName]
        $null = $parameters.Remove($fixedName)
    }

    $parameters
}

$script:ConflictingParameterNames = @(
    '?'
    'ConsoleFileName'
    'EnabledExperimentalFeatures'
    'Error'
    'ExecutionContext'
    'false'
    'HOME'
    'Host'
    'IsCoreCLR'
    'IsMacOS'
    'IsWindows'
    'PID'
    'PSCulture'
    'PSEdition'
    'PSHOME'
    'PSUICulture'
    'PSVersionTable'
    'ShellId'
    'true'
)

function Get-ConflictingParameterNames {
    $script:ConflictingParameterNames
}

function Get-ScriptBlockAST {
    param (
        [scriptblock]
        $ScriptBlock
    )

    if ($ScriptBlock.Ast -is [System.Management.Automation.Language.ScriptBlockAst]) {
        $ast = $Block.Ast.EndBlock
    }
    elseif ($ScriptBlock.Ast -is [System.Management.Automation.Language.FunctionDefinitionAst]) {
        $ast = $Block.Ast.Body.EndBlock
    }
    else {
        throw "Pester failed to parse ParameterFilter, scriptblock is invalid type. Please reformat your ParameterFilter."
    }

    return $ast
}

function New-BlockWithoutParameterAliases {
    [OutputType([scriptblock])]
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNull()]
        [System.Management.Automation.CommandMetadata]
        $Metadata,
        [Parameter(Mandatory = $true)]
        [ValidateNotNull()]
        [scriptblock]
        $Block
    )
    try {
        if ($PSVersionTable.PSVersion.Major -ge 3) {
            $params = $Metadata.Parameters.Values
            $ast = Get-ScriptBlockAST $Block
            $blockText = $ast.Extent.Text
            $variables = [array]($Ast.FindAll( { param($ast) $ast -is [System.Management.Automation.Language.VariableExpressionAst] }, $true))
            [array]::Reverse($variables)

            foreach ($var in $variables) {
                $varName = $var.VariablePath.UserPath
                $length = $varName.Length

                foreach ($param in $params) {
                    if ($param.Aliases -contains $varName) {
                        $startIndex = $var.Extent.StartOffset - $ast.Extent.StartOffset + 1 # move one position after the dollar sign

                        $blockText = $blockText.Remove($startIndex, $length).Insert($startIndex, $param.Name)

                        break # It is safe to stop checking for further params here, since aliases cannot be shared by parameters
                    }
                }
            }

            $Block = [scriptblock]::Create($blockText)
        }

        $Block
    }
    catch {
        $PSCmdlet.ThrowTerminatingError($_)
    }
}

function Repair-EnumParameters {
    param (
        [string]
        $ParamBlock,
        [System.Management.Automation.CommandMetadata]
        $Metadata
    )

    # proxycommand breaks ValidateRange for enum-parameters
    # broken arguments (unquoted strings) will show as NamedArguments in ast, while valid arguments are PositionalArguments.
    # https://github.com/pester/Pester/issues/1496
    # https://github.com/PowerShell/PowerShell/issues/17546
    $ast = [System.Management.Automation.Language.Parser]::ParseInput("param($ParamBlock)", [ref]$null, [ref]$null)
    $brokenValidateRange = $ast.FindAll({
            param($node)
            $node -is [System.Management.Automation.Language.AttributeAst] -and
            $node.TypeName.Name -match '(?:ValidateRange|System\.Management\.Automation\.ValidateRangeAttribute)$' -and
            $node.NamedArguments.Count -gt 0 -and
            # triple checking for broken argument - it won't have a value/expression
            $node.NamedArguments.ExpressionOmitted -notcontains $false
        }, $false)

    if ($brokenValidateRange.Count -eq 0) {
        # No errors found. Return original string
        return $ParamBlock
    }

    $sb = & $SafeCommands['New-Object'] System.Text.StringBuilder($ParamBlock)

    foreach ($attr in $brokenValidateRange) {
        $paramName = $attr.Parent.Name.VariablePath.UserPath
        $originalAttribute = $Metadata.Parameters[$paramName].Attributes | & $SafeCommands['Where-Object'] { $_ -is [ValidateRange] }
        $enumType = @($originalAttribute)[0].MinRange.GetType()
        if (-not $enumType.IsEnum) { continue }

        # prefix arguments with [My.Enum.Type]::
        $enumPrefix = "[$($enumType.FullName)]::"
        $fixedValidation = $attr.Extent.Text -replace '(\w+)(?=,\s|\)\])', "$enumPrefix`$1"

        if ($PesterPreference.Debug.WriteDebugMessages.Value) {
            Write-PesterDebugMessage -Scope Mock -Message "Fixed ValidateRange-attribute parameter '$paramName' from '$($attr.Extent.Text)' to '$fixedValidation'"
        }

        # make sure we modify the correct parameter by modifying the whole thing
        $orgParameter = $attr.Parent.Extent.Text
        $fixedParameter = $orgParameter.Replace($attr.Extent.Text, $fixedValidation)
        $null = $sb.Replace($orgParameter, $fixedParameter)
    }

    $sb.ToString()
}
# file src\functions\New-Fixture.ps1
function New-Fixture {
    <#
    .SYNOPSIS
    This function generates two scripts, one that defines a function
    and another one that contains its tests.

    .DESCRIPTION
    This function generates two scripts, one that defines a function
    and another one that contains its tests. The files are by default
    placed in the current directory and are called and populated as such:

    The script defining the function: .\Clean.ps1:

    ```powershell
    function Clean {
        throw [NotImplementedException]'Clean is not implemented.'
    }
    ```

    The script containing the example test .\Clean.Tests.ps1:

    ```powershell
    BeforeAll {
        . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
    }

    Describe "Clean" {

        It "Returns expected output" {
            Clean | Should -Be "YOUR_EXPECTED_VALUE"
        }
    }
    ```

    .PARAMETER Name
    Defines the name of the function and the name of the test to be created.

    .PARAMETER Path
    Defines path where the test and the function should be created, you can use full or relative path.
    If the parameter is not specified the scripts are created in the current directory.

    .EXAMPLE
    New-Fixture -Name Clean

    Creates the scripts in the current directory.

    .EXAMPLE
    New-Fixture Clean C:\Projects\Cleaner

    Creates the scripts in the C:\Projects\Cleaner directory.

    .EXAMPLE
    New-Fixture -Name Clean -Path Cleaner

    Creates a new folder named Cleaner in the current directory and creates the scripts in it.

    .LINK
    https://pester.dev/docs/v5/commands/New-Fixture

    .LINK
    https://pester.dev/docs/v5/commands/Describe

    .LINK
    https://pester.dev/docs/v5/commands/Context

    .LINK
    https://pester.dev/docs/v5/commands/It

    .LINK
    https://pester.dev/docs/v5/commands/Should
    #>
    param (
        [Parameter(Mandatory = $true)]
        [String]$Name,
        [String]$Path = $PWD
    )

    $Name = $Name -replace '.ps(m?)1', ''

    if ($Name -notmatch '^\S+$') {
        throw "Name is not valid. Whitespace are not allowed in a function name."
    }

    #keep this formatted as is. the format is output to the file as is, including indentation
    $scriptCode = "function $Name {
    throw [NotImplementedException]'$Name is not implemented.'
}"

    $testCode = 'BeforeAll {
    . $PSCommandPath.Replace(''.Tests.ps1'', ''.ps1'')
}

Describe "#name#" {
    It "Returns expected output" {
        #name# | Should -Be "YOUR_EXPECTED_VALUE"
    }
}' -replace "#name#", $Name

    $Path = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($Path)

    Create-File -Path $Path -Name "$Name.ps1" -Content $scriptCode
    Create-File -Path $Path -Name "$Name.Tests.ps1" -Content $testCode
}

function Create-File {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('Pester.BuildAnalyzerRules\Measure-SafeCommands', 'Write-Warning', Justification = 'Mocked in unit test for New-Fixture.')]
    param($Path, $Name, $Content)
    if (-not (& $SafeCommands['Test-Path'] -Path $Path)) {
        & $SafeCommands['New-Item'] -ItemType Directory -Path $Path | & $SafeCommands['Out-Null']
    }

    $FullPath = & $SafeCommands['Join-Path'] -Path $Path -ChildPath $Name
    if (-not (& $SafeCommands['Test-Path'] -Path $FullPath)) {
        & $SafeCommands['Set-Content'] -Path  $FullPath -Value $Content -Encoding UTF8
        & $SafeCommands['Get-Item'] -Path $FullPath
    }
    else {
        # This is deliberately not sent through $SafeCommands, because our own tests rely on
        # mocking Write-Warning, and it's not really the end of the world if this call happens to
        # be screwed up in an edge case.
        Write-Warning "Skipping the file '$FullPath', because it already exists."
    }
}
# file src\functions\New-MockObject.ps1
function New-MockObject {
    <#
    .SYNOPSIS
    This function instantiates a .NET object from a type.

    .DESCRIPTION
    Using the New-MockObject you can mock an object based on .NET type.

    An .NET assembly for the particular type must be available in the system and loaded.

    .PARAMETER Type
    The .NET type to create. This creates the object without calling any of its constructors or initializers. Use this to instantiate an object that does not have a public constructor. If your object has a constructor, or is giving you errors, try using the constructor and provide the object using the InputObject parameter to decorate it.

    .PARAMETER InputObject
    An already constructed object to decorate. Use `New-Object` or `[typeName]::new()` to create it.

    .PARAMETER Properties
    Properties to define, specified as a hashtable, in format `@{ PropertyName = value }`.

    .PARAMETER Methods
    Methods to define, specified as a hashtable, in format `@{ MethodName = scriptBlock }`.

    ScriptBlock can define param block, and it will receive arguments that were provided to the function call based on order.

    Method overloads are not supported because ScriptMethods are used to decorate the object, and ScriptMethods do not support method overloads.

    For each method a property named `_MethodName` (if using default `-MethodHistoryPrefix`) is defined which holds history of the invocations of the method and the arguments that were provided.

    .PARAMETER MethodHistoryPrefix
    Prefix for the history-property created for each mocked method. Default is '_' which would create the property '_MethodName'.

    .EXAMPLE
    ```powershell
    $obj = New-MockObject -Type 'System.Diagnostics.Process'
    $obj.GetType().FullName
        System.Diagnostics.Process
    ```

    Creates a mock of a process-object with default property-values.

    .EXAMPLE
    ```powershell
    $obj = New-MockObject -Type 'System.Diagnostics.Process' -Properties @{ Id = 123 }
    ```

    Create a mock of a process-object with the Id-property specified.

    .EXAMPLE
    ```powershell
    $obj = New-MockObject -Type 'System.Diagnostics.Process' -Methods @{ Kill = { param($entireProcessTree) "killed" } }
    $obj.Kill()
    $obj.Kill($true)
    $obj.Kill($false)

    $obj._Kill

    Call Arguments
    ---- ---------
       1 {}
       2 {True}
       3 {False}
    ```

    Create a mock of a process-object and mocks the object's `Kill()`-method. The mocked method will keep a history
    of any call and the associated arguments in a property named `_Kill`

    .LINK
    https://pester.dev/docs/v5/commands/New-MockObject

    .LINK
    https://pester.dev/docs/v5/usage/mocking
    #>
    [CmdletBinding(DefaultParameterSetName = "Type")]
    param (
        [Parameter(ParameterSetName = "Type", Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [type]$Type,
        [Parameter(ParameterSetName = "InputObject", Mandatory)]
        [ValidateNotNullOrEmpty()]
        $InputObject,
        [Parameter(ParameterSetName = "Type")]
        [Parameter(ParameterSetName = "InputObject")]
        [hashtable]$Properties,
        [Parameter(ParameterSetName = "Type")]
        [Parameter(ParameterSetName = "InputObject")]
        [hashtable]$Methods,
        [string] $MethodHistoryPrefix = "_"
    )

    $mock = if ($PSBoundParameters.ContainsKey("InputObject")) {
        $PSBoundParameters.InputObject
    }
    else {
        [System.Runtime.Serialization.Formatterservices]::GetUninitializedObject($Type)
    }

    if ($null -ne $Properties) {
        foreach ($property in $Properties.GetEnumerator()) {
            if ($mock.PSObject.Properties.Item($property.Key)) {
                $mock.PSObject.Properties.Remove($property.Key)
            }
            $mock.PSObject.Properties.Add([Pester.Factory]::CreateNoteProperty($property.Key, $property.Value))
        }
    }

    if ($null -ne $Methods) {
        foreach ($method in $Methods.GetEnumerator()) {
            $historyName = "$($MethodHistoryPrefix)$($method.Key)"
            $mockState = $mock.PSObject.Properties.Item("__mock")
            if (-not $mockState) {
                $mockState = [Pester.Factory]::CreateNoteProperty("__mock", @{});
                $mock.PSObject.Properties.Add($mockState)
            }

            $mockState.Value[$historyName] = @{
                Count  = 0
                Method = $method.Value
            }

            if ($mock.PSObject.Properties.Item($historyName)) {
                $mock.PSObject.Properties.Remove($historyName)
            }

            $mock.PSObject.Properties.Add([Pester.Factory]::CreateNoteProperty($historyName, [System.Collections.Generic.List[object]]@()))

            # this will be used as text below, and historyName is replaced. So we don't have to create a closure
            # to hold the history name, and so user can still use $this because we are running in the same session state
            $scriptBlock = {
                $private:historyName = "###historyName###"
                $private:state = $this.__mock[$private:historyName]
                # before invoking user scriptblock up the counter by 1 and save args
                $this.$private:historyName.Add([PSCustomObject] @{ Call = ++$private:state.Count; Arguments = $args })

                # then splat the args, if user specifies parameters in the scriptblock they
                # will get the values by order, same as if they called the script method
                & $private:state.Method @args
            }

            $scriptBlock = [ScriptBlock]::Create(($scriptBlock -replace "###historyName###", $historyName))

            $SessionStateInternal = $script:ScriptBlockSessionStateInternalProperty.GetValue($method.Value, $null)
            $script:ScriptBlockSessionStateInternalProperty.SetValue($scriptBlock, $SessionStateInternal, $null)

            if ($mock.PSObject.Methods.Item($method.Key)) {
                $mock.PSObject.Methods.Remove($method.Key)
            }

            $mock.PSObject.Methods.Add([Pester.Factory]::CreateScriptMethod($method.Key, $scriptBlock))
        }
    }

    $mock
}
# file src\functions\Output.ps1
$script:ReportStrings = DATA {
    @{
        VersionMessage    = "Pester v{0}"
        FilterMessage     = ' matching test name {0}'
        TagMessage        = ' with Tags {0}'
        MessageOfs        = "', '"

        CoverageTitle     = 'Code Coverage report:'
        CoverageMessage   = 'Covered {2:0.##}% / {5:0.##}%. {3:N0} analyzed {0} in {4:N0} {1}.'
        MissedSingular    = 'Missed command:'
        MissedPlural      = 'Missed commands:'
        CommandSingular   = 'Command'
        CommandPlural     = 'Commands'
        FileSingular      = 'File'
        FilePlural        = 'Files'

        Describe          = 'Describing {0}'
        Script            = 'Executing script {0}'
        Context           = 'Context {0}'
        Margin            = ' '
        Timing            = 'Tests completed in {0}'

        # If this is set to an empty string, the count won't be printed
        ContextsPassed    = ''
        ContextsFailed    = ''

        TestsPassed       = 'Tests Passed: {0}, '
        TestsFailed       = 'Failed: {0}, '
        TestsSkipped      = 'Skipped: {0}, '
        TestsPending      = 'Pending: {0}, '
        TestsInconclusive = 'Inconclusive: {0}, '
        TestsNotRun       = 'NotRun: {0}'
    }
}

$script:ReportTheme = DATA {
    @{
        Describe         = 'Green'
        DescribeDetail   = 'DarkYellow'
        Context          = 'Cyan'
        ContextDetail    = 'DarkCyan'
        Pass             = 'DarkGreen'
        PassTime         = 'DarkGray'
        Fail             = 'Red'
        FailTime         = 'DarkGray'
        FailDetail       = 'Red'
        Skipped          = 'Yellow'
        SkippedTime      = 'DarkGray'
        Pending          = 'Gray'
        PendingTime      = 'DarkGray'
        NotRun           = 'Gray'
        NotRunTime       = 'DarkGray'
        Total            = 'Gray'
        Inconclusive     = 'Gray'
        InconclusiveTime = 'DarkGray'
        Incomplete       = 'Yellow'
        IncompleteTime   = 'DarkGray'
        Foreground       = 'White'
        Information      = 'DarkGray'
        Coverage         = 'White'
        Discovery        = 'Magenta'
        Container        = 'Magenta'
        BlockFail        = 'Red'
        Warning          = 'Yellow'
    }
}

function Write-PesterHostMessage {
    param(
        [Parameter(Position = 0, ValueFromPipeline = $true)]
        [Alias('Message', 'Msg')]
        $Object,

        [ConsoleColor]
        $ForegroundColor,

        [ConsoleColor]
        $BackgroundColor,

        [switch]
        $NoNewLine,

        $Separator = ' ',

        [ValidateSet('Ansi', 'ConsoleColor', 'Plaintext')]
        [string]
        $RenderMode = $PesterPreference.Output.RenderMode.Value
    )

    begin {
        # Custom PSHosts without UI will fail with Write-Host. Works in PS5+ due to use of InformationRecords
        $HostSupportsOutput = $null -ne $host.UI.RawUI.ForegroundColor -or $PSVersionTable.PSVersion.Major -ge 5
        if (-not $HostSupportsOutput) { return }

        # Source https://docs.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences#text-formatting
        $esc = [char]27
        $ANSIcodes = @{
            ResetAll        = "$esc[0m"

            ForegroundColor = @{
                [ConsoleColor]::Black       = "$esc[30m"
                [ConsoleColor]::DarkBlue    = "$esc[34m"
                [ConsoleColor]::DarkGreen   = "$esc[32m"
                [ConsoleColor]::DarkCyan    = "$esc[36m"
                [ConsoleColor]::DarkRed     = "$esc[31m"
                [ConsoleColor]::DarkMagenta = "$esc[35m"
                [ConsoleColor]::DarkYellow  = "$esc[33m"
                [ConsoleColor]::Gray        = "$esc[37m"

                [ConsoleColor]::DarkGray    = "$esc[90m"
                [ConsoleColor]::Blue        = "$esc[94m"
                [ConsoleColor]::Green       = "$esc[92m"
                [ConsoleColor]::Cyan        = "$esc[96m"
                [ConsoleColor]::Red         = "$esc[91m"
                [ConsoleColor]::Magenta     = "$esc[95m"
                [ConsoleColor]::Yellow      = "$esc[93m"
                [ConsoleColor]::White       = "$esc[97m"
            }

            BackgroundColor = @{
                [ConsoleColor]::Black       = "$esc[40m"
                [ConsoleColor]::DarkBlue    = "$esc[44m"
                [ConsoleColor]::DarkGreen   = "$esc[42m"
                [ConsoleColor]::DarkCyan    = "$esc[46m"
                [ConsoleColor]::DarkRed     = "$esc[41m"
                [ConsoleColor]::DarkMagenta = "$esc[45m"
                [ConsoleColor]::DarkYellow  = "$esc[43m"
                [ConsoleColor]::Gray        = "$esc[47m"

                [ConsoleColor]::DarkGray    = "$esc[100m"
                [ConsoleColor]::Blue        = "$esc[104m"
                [ConsoleColor]::Green       = "$esc[102m"
                [ConsoleColor]::Cyan        = "$esc[106m"
                [ConsoleColor]::Red         = "$esc[101m"
                [ConsoleColor]::Magenta     = "$esc[105m"
                [ConsoleColor]::Yellow      = "$esc[103m"
                [ConsoleColor]::White       = "$esc[107m"
            }
        }
    }

    process {
        if (-not $HostSupportsOutput) { return }

        if ($RenderMode -eq 'Ansi') {
            $message = @(foreach ($o in $Object) { $o.ToString() }) -join $Separator
            $fg = if ($PSBoundParameters.ContainsKey('ForegroundColor')) { $ANSIcodes.ForegroundColor[$ForegroundColor] } else { '' }
            $bg = if ($PSBoundParameters.ContainsKey('BackgroundColor')) { $ANSIcodes.BackgroundColor[$BackgroundColor] } else { '' }

            # CI auto-resets ANSI on linebreak for some reason. Need to prepend style at beginning of every line
            $message = "$($message -replace '(?m)^', "$fg$bg")$($ANSIcodes.ResetAll)"

            & $SafeCommands['Write-Host'] -Object $message -NoNewLine:$NoNewLine
        }
        else {
            if ($RenderMode -eq 'Plaintext') {
                if ($PSBoundParameters.ContainsKey('ForegroundColor')) {
                    $null = $PSBoundParameters.Remove('ForegroundColor')
                }
                if ($PSBoundParameters.ContainsKey('BackgroundColor')) {
                    $null = $PSBoundParameters.Remove('BackgroundColor')
                }
            }

            if ($PSBoundParameters.ContainsKey('RenderMode')) {
                $null = $PSBoundParameters.Remove('RenderMode')
            }

            & $SafeCommands['Write-Host'] @PSBoundParameters
        }
    }
}

function Format-PesterPath ($Path, [String]$Delimiter) {
    # -is check is not enough for the arrays, the incoming value will likely be object[]
    # so we have to check if we can upcast to our required type

    if ($null -eq $Path) {
        $null
    }
    elseif ($Path -is [String]) {
        $Path
    }
    elseif ($Path -is [hashtable]) {
        # a well formed pester hashtable contains Path
        $Path.Path
    }
    elseif ($null -ne ($path -as [hashtable[]])) {
        ($path | & $SafeCommands['ForEach-Object'] { $_.Path }) -join $Delimiter
    }
    # needs to stay at the bottom because almost everything can be upcast to array of string
    elseif ($Path -as [String[]]) {
        $Path -join $Delimiter
    }
}

function Write-PesterStart {
    param(
        [Parameter(mandatory = $true, valueFromPipeline = $true)]
        $Context
    )
    process {
        $moduleInfo = $MyInvocation.MyCommand.ScriptBlock.Module
        $moduleVersion = $moduleInfo.Version.ToString()
        if ($moduleInfo.PrivateData.PSData.Prerelease) {
            $moduleVersion += "-$($moduleInfo.PrivateData.PSData.Prerelease)"
        }
        $message = $ReportStrings.VersionMessage -f $moduleVersion

        Write-PesterHostMessage -ForegroundColor $ReportTheme.Discovery $message
    }
}


function ConvertTo-PesterResult {
    param(
        [String] $Name,
        [Nullable[TimeSpan]] $Time,
        [System.Management.Automation.ErrorRecord] $ErrorRecord
    )

    $testResult = @{
        Name           = $Name
        Time           = $time
        FailureMessage = ''
        StackTrace     = ''
        ErrorRecord    = $null
        Success        = $false
        Result         = 'Failed'
    }

    if (-not $ErrorRecord) {
        $testResult.Result = 'Passed'
        $testResult.Success = $true
        return $testResult
    }

    if (@('PesterAssertionFailed', 'PesterTestSkipped', 'PesterTestInconclusive', 'PesterTestPending') -contains $ErrorRecord.FullyQualifiedErrorID) {
        # we use TargetObject to pass structured information about the error.
        $details = $ErrorRecord.TargetObject

        $failureMessage = $details.Message
        $file = $details.File
        $line = $details.Line
        $Text = $details.LineText

        if (-not $Pester.Strict) {
            switch ($ErrorRecord.FullyQualifiedErrorID) {
                PesterTestInconclusive {
                    $testResult.Result = 'Inconclusive'; break;
                }
                PesterTestPending {
                    $testResult.Result = 'Pending'; break;
                }
                PesterTestSkipped {
                    $testResult.Result = 'Skipped'; break;
                }
            }
        }
    }
    else {
        $failureMessage = $ErrorRecord.ToString()
        $file = $ErrorRecord.InvocationInfo.ScriptName
        $line = $ErrorRecord.InvocationInfo.ScriptLineNumber
        $Text = $ErrorRecord.InvocationInfo.Line
    }

    $testResult.FailureMessage = $failureMessage
    $testResult.StackTrace = "at <ScriptBlock>, ${file}: line ${line}$([System.Environment]::NewLine)${line}: ${Text}"
    $testResult.ErrorRecord = $ErrorRecord

    return $testResult
}

function Write-PesterReport {
    param (
        [Parameter(mandatory = $true, valueFromPipeline = $true)]
        [Pester.Run] $RunResult
    )
    # if(-not ($PesterState.Show | Has-Flag Summary)) { return }

    Write-PesterHostMessage ($ReportStrings.Timing -f (Get-HumanTime ($RunResult.Duration))) -Foreground $ReportTheme.Foreground

    $Success, $Failure = if ($RunResult.FailedCount -gt 0) {
        $ReportTheme.Foreground, $ReportTheme.Fail
    }
    else {
        $ReportTheme.Pass, $ReportTheme.Information
    }

    $Skipped = if ($RunResult.SkippedCount -gt 0) {
        $ReportTheme.Skipped
    }
    else {
        $ReportTheme.Information
    }

    $NotRun = if ($RunResult.NotRunCount -gt 0) {
        $ReportTheme.NotRun
    }
    else {
        $ReportTheme.Information
    }

    $Total = if ($RunResult.TotalCount -gt 0) {
        $ReportTheme.Total
    }
    else {
        $ReportTheme.Information
    }

    # $Pending = if ($RunResult.PendingCount -gt 0) {
    #     $ReportTheme.Pending
    # }
    # else {
    #     $ReportTheme.Information
    # }
    $Inconclusive = if ($RunResult.InconclusiveCount -gt 0) {
        $ReportTheme.Inconclusive
    }
    else {
        $ReportTheme.Information
    }

    # Try {
    #     $PesterStatePassedScenariosCount = $PesterState.PassedScenarios.Count
    # }
    # Catch {
    #     $PesterStatePassedScenariosCount = 0
    # }

    # Try {
    #     $PesterStateFailedScenariosCount = $PesterState.FailedScenarios.Count
    # }
    # Catch {
    #     $PesterStateFailedScenariosCount = 0
    # }

    # if ($ReportStrings.ContextsPassed) {
    #     & $SafeCommands['Write-Host'] ($ReportStrings.ContextsPassed -f $PesterStatePassedScenariosCount) -Foreground $Success -NoNewLine
    #     & $SafeCommands['Write-Host'] ($ReportStrings.ContextsFailed -f $PesterStateFailedScenariosCount) -Foreground $Failure
    # }
    # if ($ReportStrings.TestsPassed) {
    Write-PesterHostMessage ($ReportStrings.TestsPassed -f $RunResult.PassedCount) -Foreground $Success -NoNewLine
    Write-PesterHostMessage ($ReportStrings.TestsFailed -f $RunResult.FailedCount) -Foreground $Failure -NoNewLine
    Write-PesterHostMessage ($ReportStrings.TestsSkipped -f $RunResult.SkippedCount) -Foreground $Skipped -NoNewLine
    Write-PesterHostMessage ($ReportStrings.TestsInconclusive -f $RunResult.InconclusiveCount) -Foreground $Inconclusive -NoNewLine
    Write-PesterHostMessage ($ReportStrings.TestsTotal -f $RunResult.TotalCount) -Foreground $Total -NoNewLine
    Write-PesterHostMessage ($ReportStrings.TestsNotRun -f $RunResult.NotRunCount) -Foreground $NotRun

    if (0 -lt $RunResult.FailedBlocksCount) {
        Write-PesterHostMessage ('BeforeAll \ AfterAll failed: {0}' -f $RunResult.FailedBlocksCount) -Foreground $ReportTheme.Fail
        Write-PesterHostMessage ($(foreach ($b in $RunResult.FailedBlocks) { "  - $($b.Path -join '.')" }) -join [Environment]::NewLine) -Foreground $ReportTheme.Fail
    }

    if (0 -lt $RunResult.FailedContainersCount) {
        $cs = foreach ($container in $RunResult.FailedContainers) {
            "  - $($container.Name)"
        }
        Write-PesterHostMessage ('Container failed: {0}' -f $RunResult.FailedContainersCount) -Foreground $ReportTheme.Fail
        Write-PesterHostMessage ($cs -join [Environment]::NewLine) -Foreground $ReportTheme.Fail
    }
    # & $SafeCommands['Write-Host'] ($ReportStrings.TestsPending -f $RunResult.PendingCount) -Foreground $Pending -NoNewLine
    # & $SafeCommands['Write-Host'] ($ReportStrings.TestsInconclusive -f $RunResult.InconclusiveCount) -Foreground $Inconclusive
    # }

    $rootFrameworkData = @($RunResult.Containers.Blocks.Root.FrameworkData)
    foreach ($frameworkData in $rootFrameworkData) {
        if ($null -ne $frameworkData -and $frameworkData['ShowPendingDeprecation']) {
            Write-PesterHostMessage '**DEPRECATED**: The -Pending parameter of Set-ItResult is deprecated. The parameter will be removed in a future version of Pester.' -ForegroundColor $ReportTheme.Warning
            # Show it only once.
            break
        }
    }
}

function Write-CoverageReport {
    param ([object] $CoverageReport)

    $writeToScreen = $PesterPreference.Output.Verbosity.Value -in 'Normal', 'Detailed', 'Diagnostic'
    $writeMissedCommands = $PesterPreference.Output.Verbosity.Value -in 'Detailed', 'Diagnostic'
    if ($null -eq $CoverageReport -or $CoverageReport.NumberOfCommandsAnalyzed -eq 0) {
        return
    }

    $totalCommandCount = $CoverageReport.NumberOfCommandsAnalyzed
    $fileCount = $CoverageReport.NumberOfFilesAnalyzed
    $executedPercent = $CoverageReport.CoveragePercent

    $command = if ($totalCommandCount -gt 1) {
        $ReportStrings.CommandPlural
    }
    else {
        $ReportStrings.CommandSingular
    }
    $file = if ($fileCount -gt 1) {
        $ReportStrings.FilePlural
    }
    else {
        $ReportStrings.FileSingular
    }

    $commonParent = Get-CommonParentPath -Path $CoverageReport.AnalyzedFiles
    $report = $CoverageReport.MissedCommands | & $SafeCommands['Select-Object'] -Property @(
        @{ Name = 'File'; Expression = { Get-RelativePath -Path $_.File -RelativeTo $commonParent } }
        'Class'
        'Function'
        'Line'
        'Command'
    )

    if ($CoverageReport.MissedCommands.Count -gt 0) {
        $coverageMessage = $ReportStrings.CoverageMessage -f $command, $file, $executedPercent, $totalCommandCount, $fileCount, $PesterPreference.CodeCoverage.CoveragePercentTarget.Value
        $coverageMessage + "`n"
        $color = if ($writeToScreen -and $CoverageReport.CoveragePercent -ge $PesterPreference.CodeCoverage.CoveragePercentTarget.Value) { $ReportTheme.Pass } else { $ReportTheme.Fail }
        if ($writeToScreen) {
            Write-PesterHostMessage $coverageMessage -Foreground $color
        }
        if ($CoverageReport.MissedCommands.Count -eq 1) {
            $ReportStrings.MissedSingular + "`n"
            if ($writeMissedCommands) {
                Write-PesterHostMessage $ReportStrings.MissedSingular -Foreground $color
            }
        }
        else {
            $ReportStrings.MissedPlural + "`n"
            if ($writeMissedCommands) {
                Write-PesterHostMessage $ReportStrings.MissedPlural -Foreground $color
            }
        }
        $reportTable = $report | & $SafeCommands['Format-Table'] -AutoSize | & $SafeCommands['Out-String']
        $reportTable + "`n"
        if ($writeMissedCommands) {
            $reportTable | Write-PesterHostMessage -Foreground $ReportTheme.Coverage
        }
    }
    else {
        $coverageMessage = $ReportStrings.CoverageMessage -f $command, $file, $executedPercent, $totalCommandCount, $fileCount, $PesterPreference.CodeCoverage.CoveragePercentTarget.Value
        $coverageMessage + "`n"
        if ($writeToScreen) {
            Write-PesterHostMessage $coverageMessage -Foreground $ReportTheme.Pass
        }
    }
}

function ConvertTo-FailureLines {
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        $ErrorRecord,
        [switch] $ForceFullError
    )
    process {
        $lines = [PSCustomObject] @{
            Message = @()
            Trace   = @()
        }

        # return $lines

        ## convert the exception messages
        $exception = $ErrorRecord.Exception
        $exceptionLines = @()

        while ($exception) {
            $exceptionName = $exception.GetType().Name
            $thisLines = $exception.Message.Split([string[]]($([System.Environment]::NewLine), "`n"), [System.StringSplitOptions]::RemoveEmptyEntries)
            if (0 -lt @($thisLines).Count -and $ErrorRecord.FullyQualifiedErrorId -ne 'PesterAssertionFailed') {
                $thisLines[0] = "$exceptionName`: $($thisLines[0])"
            }
            [array]::Reverse($thisLines)
            $exceptionLines += $thisLines
            $exception = $exception.InnerException
        }
        [array]::Reverse($exceptionLines)
        $lines.Message += $exceptionLines
        if ($ErrorRecord.FullyQualifiedErrorId -eq 'PesterAssertionFailed') {
            $lines.Trace += "at $($ErrorRecord.TargetObject.LineText.Trim()), $($ErrorRecord.TargetObject.File):$($ErrorRecord.TargetObject.Line)".Split([string[]]($([System.Environment]::NewLine), "`n"), [System.StringSplitOptions]::RemoveEmptyEntries)
        }

        if ( -not ($ErrorRecord | & $SafeCommands['Get-Member'] -Name ScriptStackTrace) ) {
            if ($ErrorRecord.FullyQualifiedErrorID -eq 'PesterAssertionFailed') {
                $lines.Trace += "at line: $($ErrorRecord.TargetObject.Line) in $($ErrorRecord.TargetObject.File)"
            }
            else {
                $lines.Trace += "at line: $($ErrorRecord.InvocationInfo.ScriptLineNumber) in $($ErrorRecord.InvocationInfo.ScriptName)"
            }
            return $lines
        }

        ## convert the stack trace if present (there might be none if we are raising the error ourselves)
        # todo: this is a workaround see https://github.com/pester/Pester/pull/886
        if ($null -ne $ErrorRecord.ScriptStackTrace) {
            $traceLines = $ErrorRecord.ScriptStackTrace.Split([Environment]::NewLine, [System.StringSplitOptions]::RemoveEmptyEntries)
        }

        if ($ForceFullError -or $PesterPreference.Debug.ShowFullErrors.Value -or $PesterPreference.Output.StackTraceVerbosity.Value -eq 'Full') {
            $lines.Trace += $traceLines
        }
        else {
            # omit the lines internal to Pester
            if ((GetPesterOS) -ne 'Windows') {
                [String]$isPesterFunction = '^at .*, .*/Pester.psm1: line [0-9]*$'
                [String]$isShould = '^at (Should<End>|Invoke-Assertion), .*/Pester.psm1: line [0-9]*$'
                # [String]$pattern6 = '^at <ScriptBlock>, (<No file>|.*/Pester.psm1): line [0-9]*$'
            }
            else {
                [String]$isPesterFunction = '^at .*, .*\\Pester.psm1: line [0-9]*$'
                [String]$isShould = '^at (Should<End>|Invoke-Assertion), .*\\Pester.psm1: line [0-9]*$'
            }


            # reducing the stack trace so we see only stack trace until the current It block and not up until the invocation of the
            # whole test script itself. This is achieved by shortening the stack trace when any Runtime function is hit.
            # what we don't want to do here is shorten the stack on the Should or Invoke-Assertion. That would remove any
            # lines describing potential functions that are invoked in the test. e.g. doing function a() { 1 | Should -Be 2 }; a
            # we want to be able to see that we invoked the assertion inside of function a
            # the internal calls to Should and Invoke-Assertion are filtered out later by the second match
            foreach ($line in $traceLines) {
                if ($line -match $isPesterFunction -and $line -notmatch $isShould) {
                    break
                }

                $isPesterInternalFunction = $line -match $isPesterFunction

                if (-not $isPesterInternalFunction) {
                    $lines.Trace += $line
                }
            }
        }

        # make error navigateable in VSCode
        $lines.Trace = $lines.Trace -replace ':\s*line\s*(\d+)\s*$', ':$1'
        return $lines
    }
}

function ConvertTo-HumanTime {
    param ([TimeSpan]$TimeSpan)
    if ($TimeSpan.Ticks -lt [timespan]::TicksPerSecond) {
        "$([int]($TimeSpan.TotalMilliseconds))ms"
    }
    else {
        "$([math]::round($TimeSpan.TotalSeconds ,2))s"
    }
}

function Get-WriteScreenPlugin ($Verbosity) {
    # add -FrameworkSetup Write-PesterStart $pester $Script and -FrameworkTeardown { $pester | Write-PesterReport }
    # The plugin is not imported when output None is specified so the usual level of output is Normal.

    $p = @{
        Name = 'WriteScreen'
    }

    if ($Verbosity -in 'Detailed', 'Diagnostic') {
        $p.Start = {
            param ($Context)

            Write-PesterStart $Context
        }
    }

    $p.DiscoveryStart = {
        param ($Context)

        Write-PesterHostMessage -ForegroundColor $ReportTheme.Discovery "`nStarting discovery in $(@($Context.BlockContainers).Length) files."
    }

    $p.ContainerDiscoveryEnd = {
        param ($Context)

        if ('Failed' -eq $Context.Block.Result) {
            $errorHeader = "[-] Discovery in $($Context.BlockContainer) failed with:"

            $formatErrorParams = @{
                Err                 = $Context.Block.ErrorRecord
                StackTraceVerbosity = $PesterPreference.Output.StackTraceVerbosity.Value
            }

            if ($PesterPreference.Output.CIFormat.Value -in 'AzureDevops', 'GithubActions') {
                $errorMessage = (Format-ErrorMessage @formatErrorParams) -split [Environment]::NewLine
                Write-CIErrorToScreen -CIFormat $PesterPreference.Output.CIFormat.Value -CILogLevel $PesterPreference.Output.CILogLevel.Value -Header $errorHeader -Message $errorMessage
            }
            else {
                Write-PesterHostMessage -ForegroundColor $ReportTheme.Fail $errorHeader
                Write-ErrorToScreen @formatErrorParams
            }
        }
    }

    $p.DiscoveryEnd = {
        param ($Context)

        # if ($Context.AnyFocusedTests) {
        #     $focusedTests = $Context.FocusedTests
        #     & $SafeCommands["Write-Host"] -ForegroundColor Magenta "There are some ($($focusedTests.Count)) focused tests '$($(foreach ($p in $focusedTests) { $p -join "." }) -join ",")' running just them."
        # }

        # . Found $count$(if(1 -eq $count) { " test" } else { " tests" })

        $discoveredTests = @(View-Flat -Block $Context.BlockContainers)
        Write-PesterHostMessage -ForegroundColor $ReportTheme.Discovery "Discovery found $($discoveredTests.Count) tests in $(ConvertTo-HumanTime $Context.Duration)."

        if ($PesterPreference.Output.Verbosity.Value -in 'Detailed', 'Diagnostic') {
            $activeFilters = $Context.Filter.psobject.Properties | & $SafeCommands['Where-Object'] { $_.Value }
            if ($null -ne $activeFilters) {
                foreach ($aFilter in $activeFilters) {
                    # Assuming only StringArrayOption filter-types. Might break in the future.
                    Write-PesterHostMessage -ForegroundColor $ReportTheme.Discovery "Filter '$($aFilter.Name)' set to ('$($aFilter.Value -join "', '")')."
                }

                $testsToRun = 0
                foreach ($test in $discoveredTests) {
                    if ($test.ShouldRun) { $testsToRun++ }
                }

                Write-PesterHostMessage -ForegroundColor $ReportTheme.Discovery "Filters selected $testsToRun tests to run."
            }
        }

        if ($PesterPreference.Run.SkipRun.Value) {
            Write-PesterHostMessage -ForegroundColor $ReportTheme.Discovery "`nTest run was skipped."
        }
    }


    $p.RunStart = {
        Write-PesterHostMessage -ForegroundColor $ReportTheme.Container "Running tests."
    }

    if ($PesterPreference.Output.Verbosity.Value -in 'Detailed', 'Diagnostic') {
        $p.ContainerRunStart = {
            param ($Context)

            if ("file" -eq $Context.Block.BlockContainer.Type) {
                # write two spaces to separate each file
                Write-PesterHostMessage -ForegroundColor $ReportTheme.Container "`nRunning tests from '$($Context.Block.BlockContainer.Item)'"
            }
        }
    }

    $p.ContainerRunEnd = {
        param ($Context)

        if ($Context.Result.ErrorRecord.Count -gt 0) {
            $errorHeader = "[-] $($Context.Result.Item) failed with:"

            $formatErrorParams = @{
                Err                 = $Context.Result.ErrorRecord
                StackTraceVerbosity = $PesterPreference.Output.StackTraceVerbosity.Value
            }

            if ($PesterPreference.Output.CIFormat.Value -in 'AzureDevops', 'GithubActions') {
                $errorMessage = (Format-ErrorMessage @formatErrorParams) -split [Environment]::NewLine
                Write-CIErrorToScreen -CIFormat $PesterPreference.Output.CIFormat.Value -CILogLevel $PesterPreference.Output.CILogLevel.Value -Header $errorHeader -Message $errorMessage
            }
            else {
                Write-PesterHostMessage -ForegroundColor $ReportTheme.Fail $errorHeader
                Write-ErrorToScreen @formatErrorParams
            }
        }

        if ('Normal' -eq $PesterPreference.Output.Verbosity.Value) {
            $humanTime = "$(Get-HumanTime ($Context.Result.Duration)) ($(Get-HumanTime $Context.Result.UserDuration)|$(Get-HumanTime $Context.Result.FrameworkDuration))"

            if ($Context.Result.Passed) {
                Write-PesterHostMessage -ForegroundColor $ReportTheme.Pass "[+] $($Context.Result.Item)" -NoNewLine
                Write-PesterHostMessage -ForegroundColor $ReportTheme.PassTime " $humanTime"
            }

            # this won't work skipping the whole file when all it's tests are skipped is not a feature yet in 5.0.0
            if ($Context.Result.Skip) {
                Write-PesterHostMessage -ForegroundColor $ReportTheme.Skipped "[!] $($Context.Result.Item)" -NoNewLine
                Write-PesterHostMessage -ForegroundColor $ReportTheme.SkippedTime " $humanTime"
            }
        }
    }

    if ($PesterPreference.Output.Verbosity.Value -in 'Detailed', 'Diagnostic') {
        $p.EachBlockSetupStart = {
            $Context.Configuration.BlockWritePostponed = $true
        }
    }

    if ($PesterPreference.Output.Verbosity.Value -in 'Detailed', 'Diagnostic') {
        $p.EachTestSetupStart = {
            param ($Context)
            # we postponed writing the Describe / Context to grab the Expanded name, because that is done
            # during execution to get all the variables in scope, if we are the first test then write it
            if ($Context.Test.First) {
                Write-BlockToScreen $Context.Test.Block
            }
        }
    }

    $p.EachTestTeardownEnd = {
        param ($Context)

        # we are currently in scope of describe so $Test is hardtyped and conflicts
        $_test = $Context.Test

        if ($PesterPreference.Output.Verbosity.Value -in 'Detailed', 'Diagnostic') {
            $level = $_test.Path.Count
            $margin = $ReportStrings.Margin * ($level)
            $error_margin = $margin + $ReportStrings.Margin
            $out = $_test.ExpandedName
            if (-not $_test.Skip -and @('PesterTestSkipped', 'PesterTestInconclusive', 'PesterTestPending') -contains $Result.ErrorRecord.FullyQualifiedErrorId) {
                $skippedMessage = [String]$_Test.ErrorRecord
                [String]$out += " $skippedMessage"
            }
        }
        elseif ('Normal' -eq $PesterPreference.Output.Verbosity.Value) {
            $level = 0
            $margin = ''
            $error_margin = $ReportStrings.Margin
            $out = $_test.ExpandedPath
        }
        else {
            throw "Unsupported level of output '$($PesterPreference.Output.Verbosity.Value)'"
        }

        $humanTime = "$(Get-HumanTime ($_test.Duration)) ($(Get-HumanTime $_test.UserDuration)|$(Get-HumanTime $_test.FrameworkDuration))"

        if ($PesterPreference.Debug.ShowNavigationMarkers.Value) {
            $out += ", $($_test.ScriptBlock.File):$($_Test.StartLine)"
        }

        $result = $_test.Result
        switch ($result) {
            Passed {
                if ($PesterPreference.Output.Verbosity.Value -in 'Detailed', 'Diagnostic') {
                    Write-PesterHostMessage -ForegroundColor $ReportTheme.Pass "$margin[+] $out" -NoNewLine
                    Write-PesterHostMessage -ForegroundColor $ReportTheme.PassTime " $humanTime"
                }
                break
            }

            Failed {
                # If VSCode and not Integrated Terminal (usually a test-task), output Pester 4-format to match 'pester'-problemMatcher in VSCode.
                if ($env:TERM_PROGRAM -eq 'vscode' -and -not $psEditor) {

                    # Loop to generate problem for every failed assertion per test (when $PesterPreference.Should.ErrorAction.Value = "Continue")
                    # Disabling ANSI sequences to make sure it doesn't interfere with problemMatcher in vscode-powershell extension
                    $RenderMode = if ($PesterPreference.Output.RenderMode.Value -eq 'Ansi') { 'ConsoleColor' } else { $PesterPreference.Output.RenderMode.Value }

                    foreach ($e in $_test.ErrorRecord) {
                        Write-PesterHostMessage -RenderMode $RenderMode -ForegroundColor $ReportTheme.Fail "$margin[-] $out" -NoNewLine
                        Write-PesterHostMessage -RenderMode $RenderMode -ForegroundColor $ReportTheme.FailTime " $humanTime"

                        Write-PesterHostMessage -RenderMode $RenderMode -ForegroundColor $ReportTheme.FailDetail $($e.DisplayStackTrace -replace '(?m)^', $error_margin)
                        Write-PesterHostMessage -RenderMode $RenderMode -ForegroundColor $ReportTheme.FailDetail $($e.DisplayErrorMessage -replace '(?m)^', $error_margin)
                    }

                }
                else {
                    $formatErrorParams = @{
                        Err                 = $_test.ErrorRecord
                        ErrorMargin         = $error_margin
                        StackTraceVerbosity = $PesterPreference.Output.StackTraceVerbosity.Value
                    }

                    if ($PesterPreference.Output.CIFormat.Value -in 'AzureDevops', 'GithubActions') {
                        $errorMessage = (Format-ErrorMessage @formatErrorParams) -split [Environment]::NewLine
                        Write-CIErrorToScreen -CIFormat $PesterPreference.Output.CIFormat.Value -CILogLevel $PesterPreference.Output.CILogLevel.Value -Header "$margin[-] $out $humanTime" -Message $errorMessage
                    }
                    else {
                        Write-PesterHostMessage -ForegroundColor $ReportTheme.Fail "$margin[-] $out" -NoNewLine
                        Write-PesterHostMessage -ForegroundColor $ReportTheme.FailTime " $humanTime"
                        Write-ErrorToScreen @formatErrorParams
                    }
                }
                break
            }

            Skipped {
                if ($PesterPreference.Output.Verbosity.Value -in 'Detailed', 'Diagnostic') {
                    Write-PesterHostMessage -ForegroundColor $ReportTheme.Skipped "$margin[!] $out" -NoNewLine
                    Write-PesterHostMessage -ForegroundColor $ReportTheme.SkippedTime " $humanTime"
                }
                break
            }

            Pending {
                if ($PesterPreference.Output.Verbosity.Value -in 'Detailed', 'Diagnostic') {
                    $because = if ($_test.FailureMessage) { ", because $($_test.FailureMessage)" } else { $null }
                    Write-PesterHostMessage -ForegroundColor $ReportTheme.Pending "$margin[?] $out" -NoNewLine
                    Write-PesterHostMessage -ForegroundColor $ReportTheme.Pending ", is pending$because" -NoNewLine
                    Write-PesterHostMessage -ForegroundColor $ReportTheme.PendingTime " $humanTime"
                }
                break
            }

            Inconclusive {
                if ($PesterPreference.Output.Verbosity.Value -in 'Detailed', 'Diagnostic') {
                    $because = if ($_test.FailureMessage) { ", because $($_test.FailureMessage)" } else { $null }
                    Write-PesterHostMessage -ForegroundColor $ReportTheme.Inconclusive "$margin[?] $out" -NoNewLine
                    Write-PesterHostMessage -ForegroundColor $ReportTheme.Inconclusive "$because" -NoNewLine
                    Write-PesterHostMessage -ForegroundColor $ReportTheme.InconclusiveTime " $humanTime"
                }

                break
            }

            default {
                if ($PesterPreference.Output.Verbosity.Value -in 'Detailed', 'Diagnostic') {
                    # TODO:  Add actual Incomplete status as default rather than checking for null time.
                    if ($null -eq $_test.Duration) {
                        Write-PesterHostMessage -ForegroundColor $ReportTheme.Incomplete "$margin[?] $out" -NoNewLine
                        Write-PesterHostMessage -ForegroundColor $ReportTheme.IncompleteTime " $humanTime"
                    }
                }
            }
        }
    }

    $p.EachBlockTeardownEnd = {
        param ($Context)

        if ($Context.Block.IsRoot) {
            return
        }

        if ($Context.Block.OwnPassed) {
            return
        }

        if ($PesterPreference.Output.Verbosity.Value -in 'Detailed', 'Diagnostic') {
            # In Diagnostic output we postpone writing the Describing / Context until before the
            # setup of the first test to get the correct ExpandedName of the Block with all the
            # variables in context.
            # if there is a failure before that (e.g. BeforeAll throws) we need to write Describing here.
            # But not if the first test already executed.
            if ($null -ne $Context.Block.Tests -and 0 -lt $Context.Block.Tests.Count) {
                # go through the tests to find the one that pester would invoke as first
                # it might not be the first one in the array if there are some skipped or filtered tests
                foreach ($t in $Context.Block.Tests) {
                    if ($t.First -and -not $t.Executed) {
                        Write-BlockToScreen $Context.Block
                        break
                    }
                }
            }
        }

        $level = 0
        $margin = 0
        $error_margin = $ReportStrings.Margin

        if ($PesterPreference.Output.Verbosity.Value -in 'Detailed', 'Diagnostic') {
            $level = $Context.Block.Path.Count
            $margin = $ReportStrings.Margin * ($level)
            $error_margin = $margin + $ReportStrings.Margin
        }

        foreach ($e in $Context.Block.ErrorRecord) { ConvertTo-FailureLines $e }

        $errorHeader = "[-] $($Context.Block.FrameworkData.CommandUsed) $($Context.Block.Path -join ".") failed"

        $formatErrorParams = @{
            Err                 = $Context.Block.ErrorRecord
            ErrorMargin         = $error_margin
            StackTraceVerbosity = $PesterPreference.Output.StackTraceVerbosity.Value
        }

        if ($PesterPreference.Output.CIFormat.Value -in 'AzureDevops', 'GithubActions') {
            $errorMessage = (Format-ErrorMessage @formatErrorParams) -split [Environment]::NewLine
            Write-CIErrorToScreen -CIFormat $PesterPreference.Output.CIFormat.Value -CILogLevel $PesterPreference.Output.CILogLevel.Value -Header $errorHeader -Message $errorMessage
        }
        else {
            Write-PesterHostMessage -ForegroundColor $ReportTheme.BlockFail $errorHeader
            Write-ErrorToScreen @formatErrorParams
        }
    }

    $p.End = {
        param ( $Context )

        Write-PesterReport $Context.TestRun
    }

    New-PluginObject @p
}

function Format-CIErrorMessage {
    [OutputType([System.Collections.Generic.List[string]])]
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidateSet('AzureDevops', 'GithubActions', IgnoreCase)]
        [string] $CIFormat,

        [Parameter(Mandatory)]
        [ValidateSet('Error', 'Warning', IgnoreCase)]
        [string] $CILogLevel,

        [Parameter(Mandatory)]
        [string] $Header,

        # [Parameter(Mandatory)]
        # Do not make this mandatory, just providing a string array is not enough for the
        # mandatory check to pass, it also throws when any item in the array is empty or null.
        [string[]] $Message
    )

    $Message = if ($null -eq $Message) { @() } else { $Message }

    $lines = [System.Collections.Generic.List[string]]@()

    if ($CIFormat -eq 'AzureDevops') {

        # header task issue error, so it gets reported to build log
        # https://docs.microsoft.com/en-us/azure/devops/pipelines/scripts/logging-commands?view=azure-devops&tabs=powershell#example-log-an-error
        # https://learn.microsoft.com/en-us/azure/devops/pipelines/scripts/logging-commands?view=azure-devops&tabs=powershell#example-log-a-warning-about-a-specific-place-in-a-file
        switch ($CILogLevel) {
            "Error" { $logIssueType = 'error' }
            "Warning" { $logIssueType = 'warning' }
            Default { $logIssueType = 'error' }
        }

        $headerLoggingCommand = "##vso[task.logissue type=$logIssueType] $Header"
        $lines.Add($headerLoggingCommand)

        # Add subsequent messages as errors, but do not get reported to build log
        foreach ($line in $Message) {
            $lines.Add("##[$logIssueType] $line")
        }
    }
    elseif ($CIFormat -eq 'GithubActions') {

        # header error, so it gets reported to build log
        # https://docs.github.com/en/actions/reference/workflow-commands-for-github-actions#setting-an-error-message
        # https://docs.github.com/en/actions/reference/workflow-commands-for-github-actions#setting-a-warning-message
        switch ($CILogLevel) {
            "Error" { $headerWorkflowCommand = "::error::$($Header.TrimStart())" }
            "Warning" { $headerWorkflowCommand = "::warning::$($Header.TrimStart())" }
            Default { $headerWorkflowCommand = "::error::$($Header.TrimStart())" }
        }

        $lines.Add($headerWorkflowCommand)

        # Add rest of messages inside expandable group
        # https://docs.github.com/en/actions/reference/workflow-commands-for-github-actions#grouping-log-lines
        $lines.Add("::group::Message")

        foreach ($line in $Message) {
            $lines.Add($line.TrimStart())
        }

        $lines.Add("::endgroup::")
    }

    return $lines
}

function Write-CIErrorToScreen {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [ValidateSet('AzureDevops', 'GithubActions', IgnoreCase)]
        [string] $CIFormat,

        [Parameter(Mandatory)]
        [ValidateSet('Error', 'Warning', IgnoreCase)]
        [string] $CILogLevel,

        [Parameter(Mandatory)]
        [string] $Header,

        # [Parameter(Mandatory)]
        # Do not make this mandatory, just providing a string array is not enough,
        # for the mandatory check to pass, it also throws when any item in the array is empty or null.
        [string[]] $Message
    )

    $PSBoundParameters.Message = if ($null -eq $Message) { @() } else { $Message }

    $errorMessage = Format-CIErrorMessage @PSBoundParameters

    # Workaround for https://github.com/pester/Pester/issues/2350 until Azure DevOps trims ANSI codes in summary issues
    $RenderMode = $PesterPreference.Output.RenderMode.Value
    if ($RenderMode -eq 'Ansi' -and $CIFormat -eq 'AzureDevOps') {
        $RenderMode = 'ConsoleColor'
    }

    foreach ($line in $errorMessage) {
        Write-PesterHostMessage -Object $line -RenderMode $RenderMode
    }
}

function Format-ErrorMessage {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        $Err,
        [string] $ErrorMargin,
        [string] $StackTraceVerbosity = [PesterConfiguration]::Default.Output.StackTraceVerbosity.Value
    )

    $multipleErrors = 1 -lt $Err.Count


    $out = if ($multipleErrors) {
        $c = 0
        $(foreach ($e in $Err) {
                $errorMessageSb = [System.Text.StringBuilder]""

                if ($null -ne $e.DisplayErrorMessage) {
                    [void]$errorMessageSb.Append("[$(($c++))] $($e.DisplayErrorMessage)")
                }
                else {
                    [void]$errorMessageSb.Append("[$(($c++))] $($e.Exception)")
                }

                if ($null -ne $e.DisplayStackTrace -and $StackTraceVerbosity -ne 'None') {
                    $stackTraceLines = $e.DisplayStackTrace -split [Environment]::NewLine

                    if ($StackTraceVerbosity -eq 'FirstLine') {
                        [void]$errorMessageSb.Append([Environment]::NewLine + $stackTraceLines[0])
                    }
                    else {
                        [void]$errorMessageSb.Append([Environment]::NewLine + $e.DisplayStackTrace)
                    }
                }

                $errorMessageSb.ToString()
            }) -join [Environment]::NewLine
    }
    else {
        $errorMessageSb = [System.Text.StringBuilder]""

        if ($null -ne $Err.DisplayErrorMessage) {
            [void]$errorMessageSb.Append($Err.DisplayErrorMessage)

            # Don't try to append the stack trace when we don't have it or when we don't want it
            if ($null -ne $Err.DisplayStackTrace -and [string]::empty -ne $Err.DisplayStackTrace.Trim() -and $StackTraceVerbosity -ne 'None') {
                $stackTraceLines = $Err.DisplayStackTrace -split [Environment]::NewLine

                if ($StackTraceVerbosity -eq 'FirstLine') {
                    [void]$errorMessageSb.Append([Environment]::NewLine + $stackTraceLines[0])
                }
                else {
                    [void]$errorMessageSb.Append([Environment]::NewLine + $Err.DisplayStackTrace)
                }
            }
        }
        else {
            [void]$errorMessageSb.Append($Err.Exception.ToString())

            if ($null -ne $Err.ScriptStackTrace) {
                [void]$errorMessageSb.Append([Environment]::NewLine + $Err.ScriptStackTrace)
            }
        }

        $errorMessageSb.ToString()
    }

    $withMargin = ($out -split [Environment]::NewLine) -replace '(?m)^', $ErrorMargin -join [Environment]::NewLine

    return $withMargin
}

function Write-ErrorToScreen {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        $Err,
        [string] $ErrorMargin,
        [switch] $Throw,
        [string] $StackTraceVerbosity = [PesterConfiguration]::Default.Output.StackTraceVerbosity.Value
    )

    $errorMessage = Format-ErrorMessage -Err $Err -ErrorMargin:$ErrorMargin -StackTraceVerbosity:$StackTraceVerbosity

    if ($Throw) {
        throw $errorMessage
    }
    else {
        Write-PesterHostMessage -ForegroundColor $ReportTheme.Fail "$errorMessage"
    }
}

function Write-BlockToScreen {
    param ($Block)

    # this function will write Describe / Context expanded name right before a test setup
    # or right before describe failure, we need to postpone this write to have the ExpandedName
    # correctly populated when there are data given to the block

    if ($Block.IsRoot) {
        return
    }

    if ($Block.FrameworkData.WrittenToScreen) {
        return
    }

    # write your parent to screen if they were not written before you
    if ($null -ne $Block.Parent -and -not $Block.Parent.IsRoot -and -not $Block.FrameworkData.Parent.WrittenToScreen) {
        Write-BlockToScreen -Block $Block.Parent
    }

    $commandUsed = $Block.FrameworkData.CommandUsed

    # -1 moves the block closer to the start of theline
    $level = $Block.Path.Count - 1
    $margin = $ReportStrings.Margin * $level

    $name = if (-not [string]::IsNullOrWhiteSpace($Block.ExpandedName)) { $Block.ExpandedName } else { $Block.Name }
    $text = $ReportStrings.$commandUsed -f $name

    if ($PesterPreference.Debug.ShowNavigationMarkers.Value) {
        $text += ", $($block.ScriptBlock.File):$($block.StartLine)"
    }

    if (0 -eq $level -and -not $block.First) {
        # write extra line before top-level describe / context if it is not first
        # in that case there are already two spaces before the name of the file
        Write-PesterHostMessage
    }

    $Block.FrameworkData.WrittenToScreen = $true
    Write-PesterHostMessage "${margin}${Text}" -ForegroundColor $ReportTheme.$CommandUsed
}

function Get-HumanTime {
    param( [TimeSpan] $TimeSpan)
    if ($TimeSpan.Ticks -lt [timespan]::TicksPerSecond) {
        $time = [int]($TimeSpan.TotalMilliseconds)
        $unit = 'ms'
    }
    else {
        $time = [math]::Round($TimeSpan.TotalSeconds, 2)
        $unit = 's'
    }

    return "$time$unit"
}

# This is not a plugin-step due to Output-features being dependencies in Invoke-PluginStep etc for error/debug
# Output-options are also used for Write-PesterDebugMessage which is independent of WriteScreenPlugin
function Resolve-OutputConfiguration ([PesterConfiguration]$PesterPreference) {
    $supportedVerbosity = 'None', 'Normal', 'Detailed', 'Diagnostic'
    if ($PesterPreference.Output.Verbosity.Value -notin $supportedVerbosity) {
        throw (Get-StringOptionErrorMessage -OptionPath 'Output.Verbosity' -SupportedValues $supportedVerbosity -Value $PesterPreference.Output.Verbosity.Value)
    }

    $supportedRenderModes = 'Auto', 'Ansi', 'ConsoleColor', 'Plaintext'
    if ($PesterPreference.Output.RenderMode.Value -notin $supportedRenderModes) {
        throw (Get-StringOptionErrorMessage -OptionPath 'Output.RenderMode' -SupportedValues $supportedRenderModes -Value $PesterPreference.Output.RenderMode.Value)
    }
    elseif ($PesterPreference.Output.RenderMode.Value -eq 'Auto') {
        if ($null -ne $env:NO_COLOR) {
            # https://no-color.org/)
            $PesterPreference.Output.RenderMode = 'Plaintext'
        }
        # Null check $host.UI and its properties to avoid race condition when accessing them from multiple threads. https://github.com/pester/Pester/issues/2383
        elseif ($null -ne $host.UI -and ($hostProperties = $host.UI.psobject.Properties) -and ($supportsVT = $hostProperties['SupportsVirtualTerminal']) -and $supportsVT.Value) {
            $PesterPreference.Output.RenderMode = 'Ansi'
        }
        else {
            $PesterPreference.Output.RenderMode = 'ConsoleColor'
        }
    }

    $supportedCIFormats = 'None', 'Auto', 'AzureDevops', 'GithubActions'
    if ($PesterPreference.Output.CIFormat.Value -notin $supportedCIFormats) {
        throw (Get-StringOptionErrorMessage -OptionPath 'Output.CIFormat' -SupportedValues $supportedCIFormats -Value $PesterPreference.Output.CIFormat.Value)
    }
    elseif ($PesterPreference.Output.CIFormat.Value -eq 'Auto') {
        # Variable is set to 'True' if the script is being run by a Azure Devops build task. https://docs.microsoft.com/en-us/azure/devops/pipelines/build/variables?view=azure-devops&tabs=yaml
        # Do not fix this to check for boolean value, the value is set to literal string 'True'
        if ($env:TF_BUILD -eq 'True') {
            $PesterPreference.Output.CIFormat = 'AzureDevops'
        }
        # Variable is set to 'True' if the script is being run by a Github Actions workflow. https://docs.github.com/en/actions/reference/environment-variables#default-environment-variables
        # Do not fix this to check for boolean value, the value is set to literal string 'True'
        elseif ($env:GITHUB_ACTIONS -eq 'True') {
            $PesterPreference.Output.CIFormat = 'GithubActions'
        }

        else {
            $PesterPreference.Output.CIFormat = 'None'
        }
    }

    $supportedCILogLevels = 'Error', 'Warning'
    if ($PesterPreference.Output.CILogLevel.Value -notin $supportedCILogLevels) {
        throw (Get-StringOptionErrorMessage -OptionPath 'Output.CILogLevel' -SupportedValues $supportedCILogLevels -Value $PesterPreference.Output.CILogLevel.Value)
    }

    if ('Diagnostic' -eq $PesterPreference.Output.Verbosity.Value) {
        # Enforce the default debug-output as a minimum. This is the key difference between Detailed and Diagnostic
        $PesterPreference.Debug.WriteDebugMessages = $true
        $missingCategories = foreach ($category in @('Discovery', 'Skip', 'Mock', 'CodeCoverage')) {
            if ($PesterPreference.Debug.WriteDebugMessagesFrom.Value -notcontains $category) {
                $category
            }
        }
        $PesterPreference.Debug.WriteDebugMessagesFrom = $PesterPreference.Debug.WriteDebugMessagesFrom.Value + @($missingCategories)
    }

    if ($PesterPreference.Debug.ShowFullErrors.Value) {
        $PesterPreference.Output.StackTraceVerbosity = 'Full'
    }

    $supportedStackTraceLevels = 'None', 'FirstLine', 'Filtered', 'Full'
    if ($PesterPreference.Output.StackTraceVerbosity.Value -notin $supportedStackTraceLevels) {
        throw (Get-StringOptionErrorMessage -OptionPath 'Output.StackTraceVerbosity' -SupportedValues $supportedStackTraceLevels -Value $PesterPreference.Output.StackTraceVerbosity.Value)
    }
}
# file src\functions\Pester.Debugging.ps1
function Count-Scopes {
    param(
        [Parameter(Mandatory = $true)]
        $ScriptBlock)

    if ($script:DisableScopeHints) {
        return 0
    }

    # automatic variable that can help us count scopes must be constant a must not be all scopes
    # from the standard ones only Error seems to be that, let's ensure it is like that everywhere run
    # other candidate variables can be found by this code
    # Get-Variable  | where { -not ($_.Options -band [Management.Automation.ScopedItemOptions]"AllScope") -and $_.Options -band $_.Options -band [Management.Automation.ScopedItemOptions]"Constant" }

    # get-variable steps on it's toes and recurses when we mock it in a test
    # and we are also invoking this in user scope so we need to pass the reference
    # to the safely captured function in the user scope
    $safeGetVariable = $script:SafeCommands['Get-Variable']
    $sb = {
        param($safeGetVariable)
        $err = (& $safeGetVariable -Name Error).Options
        if ($err -band "AllScope" -or (-not ($err -band "Constant"))) {
            throw "Error variable is set to AllScope, or is not marked as constant cannot use it to count scopes on this platform."
        }

        $scope = 0
        while ($null -eq (& $safeGetVariable -Name Error -Scope $scope -ErrorAction Ignore)) {
            $scope++
        }

        $scope - 1 # because we are in a function
    }

    $flags = [System.Reflection.BindingFlags]'Instance,NonPublic'
    $property = [scriptblock].GetProperty('SessionStateInternal', $flags)
    $ssi = $property.GetValue($ScriptBlock, $null)
    $property.SetValue($sb, $ssi, $null)

    &$sb $safeGetVariable
}

function Write-ScriptBlockInvocationHint {
    param(
        [Parameter(Mandatory = $true)]
        [ScriptBlock] $ScriptBlock,
        [Parameter(Mandatory = $true)]
        [String]
        $Hint
    )

    if ($global:DisableScopeHints) {
        return
    }


    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
        Write-PesterDebugMessage -Scope SessionState -LazyMessage {
            $scope = Get-ScriptBlockHint $ScriptBlock
            $count = Count-Scopes -ScriptBlock $ScriptBlock
            "Invoking scriptblock from location '$Hint' in state '$scope', $count scopes deep:"
            "{"
            $ScriptBlock.ToString().Trim()
            "}"
        }
    }
}

function Test-Hint {
    param (
        [Parameter(Mandatory = $true)]
        $InputObject
    )

    if ($script:DisableScopeHints) {
        return $true
    }

    $property = $InputObject | & $SafeCommands['Get-Member'] -Name Hint -MemberType NoteProperty
    if ($null -eq $property) {
        return $false
    }

    [string]::IsNullOrWhiteSpace($property.Value)
}

function Set-Hint {
    param(
        [Parameter(Mandatory = $true)]
        [String] $Hint,
        [Parameter(Mandatory = $true)]
        $InputObject,
        [Switch] $Force
    )

    if ($script:DisableScopeHints) {
        return
    }

    if ($InputObject | & $SafeCommands['Get-Member'] -Name Hint -MemberType NoteProperty) {
        $hintIsNotSet = [string]::IsNullOrWhiteSpace($InputObject.Hint)
        if ($Force -or $hintIsNotSet) {
            $InputObject.Hint = $Hint
        }
    }
    else {
        # do not change this to be called without the pipeline, it will throw: Cannot evaluate parameter 'InputObject' because its argument is specified as a script block and there is no input. A script block cannot be evaluated without input.
        $InputObject | & $SafeCommands['Add-Member'] -Name Hint -Value $Hint -MemberType NoteProperty
    }
}

function Set-SessionStateHint {
    param(
        [Parameter(Mandatory = $true)]
        [String] $Hint,
        [Parameter(Mandatory = $true)]
        [Management.Automation.SessionState] $SessionState,
        [Switch] $PassThru
    )

    if ($script:DisableScopeHints) {
        if ($PassThru) {
            return $SessionState
        }
        return
    }

    # in all places where we capture SessionState we mark its internal state with a hint
    # the internal state does not change and we use it to invoke scriptblock in different
    # states, setting the hint on SessionState is only secondary to make is easier to debug
    $flags = [System.Reflection.BindingFlags]'Instance,NonPublic'
    $internalSessionState = $SessionState.GetType().GetProperty('Internal', $flags).GetValue($SessionState, $null)
    if ($null -eq $internalSessionState) {
        throw "SessionState does not have any internal SessionState, this should never happen."
    }

    $hashcode = $internalSessionState.GetHashCode()
    # optionally sets the hint if there was none, so the hint from the
    # function that first captured this session state is preserved
    Set-Hint -Hint "$Hint ($hashcode))" -InputObject $internalSessionState
    # the public session state should always depend on the internal state
    Set-Hint -Hint $internalSessionState.Hint -InputObject $SessionState -Force

    if ($PassThru) {
        $SessionState
    }
}

function Get-SessionStateHint {
    param(
        [Parameter(Mandatory = $true)]
        [Management.Automation.SessionState] $SessionState
    )

    if ($script:DisableScopeHints) {
        return
    }

    # the hint is also attached to the session state object, but sessionstate objects are recreated while
    # the internal state stays static so to see the hint on object that we receive via $PSCmdlet.SessionState we need
    # to look at the InternalSessionState. the internal state should be never null so just looking there is enough
    $flags = [System.Reflection.BindingFlags]'Instance,NonPublic'
    $internalSessionState = $SessionState.GetType().GetProperty('Internal', $flags).GetValue($SessionState, $null)
    if (Test-Hint $internalSessionState) {
        $internalSessionState.Hint
    }
}

function Set-ScriptBlockHint {
    param(
        [Parameter(Mandatory = $true)]
        [ScriptBlock] $ScriptBlock,
        [string] $Hint
    )

    if ($script:DisableScopeHints) {
        return
    }

    $flags = [System.Reflection.BindingFlags]'Instance,NonPublic'
    $internalSessionState = $ScriptBlock.GetType().GetProperty('SessionStateInternal', $flags).GetValue($ScriptBlock, $null)
    if ($null -eq $internalSessionState) {
        if (Test-Hint -InputObject $ScriptBlock) {
            # the scriptblock already has a hint and there is not internal state
            # so the hint on the scriptblock is enough
            # if there was an internal state we would try to copy the hint from it
            # onto the scriptblock to keep them in sync
            return
        }

        if ($null -eq $Hint) {
            throw "Cannot set ScriptBlock hint because it is unbound ScriptBlock (with null internal state) and no -Hint was provided."
        }

        # adds hint on the ScriptBlock
        # the internal session state is null so we must attach the hint directly
        # on the scriptblock
        Set-Hint -Hint "$Hint (Unbound)" -InputObject $ScriptBlock -Force
    }
    else {
        if (Test-Hint -InputObject $internalSessionState) {
            # there already is hint on the internal state, we take it and sync
            # it with the hint on the object
            Set-Hint -Hint $internalSessionState.Hint -InputObject $ScriptBlock -Force
            return
        }

        if ($null -eq $Hint) {
            throw "Cannot set ScriptBlock hint because it's internal state does not have any Hint and no external -Hint was provided."
        }

        $hashcode = $internalSessionState.GetHashCode()
        $Hint = "$Hint - ($hashCode)"
        Set-Hint -Hint $Hint -InputObject $internalSessionState -Force
        Set-Hint -Hint $Hint -InputObject $ScriptBlock -Force
    }
}

function Get-ScriptBlockHint {
    param(
        [Parameter(Mandatory = $true)]
        [ScriptBlock] $ScriptBlock
    )

    if ($script:DisableScopeHints) {
        return
    }

    # the hint is also attached to the scriptblock object, but not all scriptblocks are tagged by us,
    # the internal state stays static so to see the hint on object that we receive we need to look at the InternalSessionState
    $flags = [System.Reflection.BindingFlags]'Instance,NonPublic'
    $internalSessionState = $ScriptBlock.GetType().GetProperty('SessionStateInternal', $flags).GetValue($ScriptBlock, $null)


    if ($null -ne $internalSessionState -and (Test-Hint $internalSessionState)) {
        return $internalSessionState.Hint
    }

    if (Test-Hint $ScriptBlock) {
        return $ScriptBlock.Hint
    }

    "Unknown unbound ScriptBlock"
}
# file src\functions\Pester.Scoping.ps1
function Set-ScriptBlockScope {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [scriptblock]
        $ScriptBlock,

        [Parameter(Mandatory = $true, ParameterSetName = 'FromSessionState')]
        [System.Management.Automation.SessionState]
        $SessionState,

        [Parameter(Mandatory = $true, ParameterSetName = 'FromSessionStateInternal')]
        [AllowNull()]
        $SessionStateInternal
    )

    if ($PSCmdlet.ParameterSetName -eq 'FromSessionState') {
        $SessionStateInternal = $script:SessionStateInternalProperty.GetValue($SessionState, $null)
    }

    $scriptBlockSessionState = $script:ScriptBlockSessionStateInternalProperty.GetValue($ScriptBlock, $null)

    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
        # hint can be attached on the internal state (preferable) when the state is there.
        # if we are given unbound scriptblock with null internal state then we hope that
        # the source cmdlet set the hint directly on the ScriptBlock,
        # otherwise the origin is unknown and the cmdlet that allowed this scriptblock in
        # should be found and add hint

        $hint = $scriptBlockSessionState.Hint
        if ($null -eq $hint) {
            if ($null -ne $ScriptBlock.Hint) {
                $hint = $ScriptBlock.Hint
            }
            else {
                $hint = 'Unknown unbound ScriptBlock'
            }
        }

        Write-PesterDebugMessage -Scope SessionState "Setting ScriptBlock state from source state '$hint' to '$($SessionStateInternal.Hint)'"
    }

    $script:ScriptBlockSessionStateInternalProperty.SetValue($ScriptBlock, $SessionStateInternal, $null)

    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
        Set-ScriptBlockHint -ScriptBlock $ScriptBlock
    }
}

function Get-ScriptBlockScope {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [scriptblock]
        $ScriptBlock
    )

    $sessionStateInternal = $script:ScriptBlockSessionStateInternalProperty.GetValue($ScriptBlock, $null)
    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
        Write-PesterDebugMessage -Scope SessionState "Getting scope from ScriptBlock '$($sessionStateInternal.Hint)'"
    }
    $sessionStateInternal
}
# file src\functions\Pester.SessionState.Mock.ps1
# session state bound functions that act as endpoints,
# so the internal functions can make their session state
# consumption explicit and are testable (also prevents scrolling past
# the whole documentation :D )

function Get-MockPlugin () {
    New-PluginObject -Name "Mock" `
        -ContainerRunStart {
        param($Context)

        $Context.Block.PluginData.Mock = @{
            Hooks       = [System.Collections.Generic.List[object]]@()
            CallHistory = @{}
            Behaviors   = @{}
        }
    } -EachBlockSetupStart {
        param($Context)
        $Context.Block.PluginData.Mock = @{
            Hooks       = [System.Collections.Generic.List[object]]@()
            CallHistory = @{}
            Behaviors   = @{}
        }
    } -EachTestSetupStart {
        param($Context)
        $Context.Test.PluginData.Mock = @{
            Hooks       = [System.Collections.Generic.List[object]]@()
            CallHistory = @{}
            Behaviors   = @{}
        }
    } -EachTestTeardownEnd {
        param($Context)
        # we are defining that table in the setup but the teardowns
        # need to be resilient, because they will run even if the setups
        # did not run
        # TODO: resolve this path safely
        $hooks = $Context.Test.PluginData.Mock.Hooks
        Remove-MockHook -Hooks $hooks
    } -EachBlockTeardownEnd {
        param($Context)
        # TODO: resolve this path safely
        $hooks = $Context.Block.PluginData.Mock.Hooks
        Remove-MockHook -Hooks $hooks
    } -ContainerRunEnd {
        param($Context)
        # TODO: resolve this path safely
        $hooks = $Context.Block.PluginData.Mock.Hooks
        Remove-MockHook -Hooks $hooks
    }
}

function Mock {
    <#
    .SYNOPSIS
    Mocks the behavior of an existing command with an alternate
    implementation.

    .DESCRIPTION
    This creates new behavior for any existing command within the scope of a
    Describe or Context block. The function allows you to specify a script block
    that will become the command's new behavior.

    Optionally, you may create a Parameter Filter which will examine the
    parameters passed to the mocked command and will invoke the mocked
    behavior only if the values of the parameter values pass the filter. If
    they do not, the original command implementation will be invoked instead
    of a mock.

    You may create multiple mocks for the same command, each using a different
    ParameterFilter. ParameterFilters will be evaluated in reverse order of
    their creation. The last one created will be the first to be evaluated.
    The mock of the first filter to pass will be used. The exception to this
    rule are Mocks with no filters. They will always be evaluated last since
    they will act as a "catch all" mock.

    Mocks can be marked Verifiable. If so, the Should -InvokeVerifiable command
    can be used to check if all Verifiable mocks were actually called. If any
    verifiable mock is not called, Should -InvokeVerifiable will throw an
    exception and indicate all mocks not called.

    If you wish to mock commands that are called from inside a script or manifest
    module, you can do so by using the -ModuleName parameter to the Mock command.
    This injects the mock into the specified module. If you do not specify a
    module name, the mock will be created in the same scope as the test script.
    You may mock the same command multiple times, in different scopes, as needed.
    Each module's mock maintains a separate call history and verified status.

    .PARAMETER CommandName
    The name of the command to be mocked.

    .PARAMETER MockWith
    A ScriptBlock specifying the behavior that will be used to mock CommandName.
    The default is an empty ScriptBlock.
    NOTE: Do not specify param or dynamicparam blocks in this script block.
    These will be injected automatically based on the signature of the command
    being mocked, and the MockWith script block can contain references to the
    mocked commands parameter variables.

    .PARAMETER Verifiable
    When this is set, the mock will be checked when Should -InvokeVerifiable is
    called.

    .PARAMETER ParameterFilter
    An optional filter to limit mocking behavior only to usages of
    CommandName where the values of the parameters passed to the command
    pass the filter.

    This ScriptBlock must return a boolean value. See examples for usage.

    .PARAMETER ModuleName
    Optional string specifying the name of the module where this command
    is to be mocked.  This should be a module that _calls_ the mocked
    command; it doesn't necessarily have to be the same module which
    originally implemented the command.

    .PARAMETER RemoveParameterType
    Optional list of parameter names that should use Object as the parameter
    type instead of the parameter type defined by the function. This relaxes the
    type requirements and allows some strongly typed functions to be mocked
    more easily.

    .PARAMETER RemoveParameterValidation
    Optional list of parameter names in the original command
    that should not have any validation rules applied. This relaxes the
    validation requirements, and allows functions that are strict about their
    parameter validation to be mocked more easily.

    .EXAMPLE
    Mock Get-ChildItem { return @{FullName = "A_File.TXT"} }

    Using this Mock, all calls to Get-ChildItem will return a hashtable with a FullName property returning "A_File.TXT"

    .EXAMPLE
    Mock Get-ChildItem { return @{FullName = "A_File.TXT"} } -ParameterFilter { $Path -and $Path.StartsWith($env:temp) }

    This Mock will only be applied to Get-ChildItem calls within the user's temp directory.

    .EXAMPLE
    Mock Set-Content {} -Verifiable -ParameterFilter { $Path -eq "some_path" -and $Value -eq "Expected Value" }

    When this mock is used, if the Mock is never invoked and Should -InvokeVerifiable is called, an exception will be thrown. The command behavior will do nothing since the ScriptBlock is empty.

    .EXAMPLE
    ```powershell
    Mock Get-ChildItem { return @{FullName = "A_File.TXT"} } -ParameterFilter { $Path -and $Path.StartsWith($env:temp\1) }
    Mock Get-ChildItem { return @{FullName = "B_File.TXT"} } -ParameterFilter { $Path -and $Path.StartsWith($env:temp\2) }
    Mock Get-ChildItem { return @{FullName = "C_File.TXT"} } -ParameterFilter { $Path -and $Path.StartsWith($env:temp\3) }
    ```

    Multiple mocks of the same command may be used. The parameter filter determines which is invoked. Here, if Get-ChildItem is called on the "2" directory of the temp folder, then B_File.txt will be returned.

    .EXAMPLE
    ```powershell
    Mock Get-ChildItem { return @{FullName="B_File.TXT"} } -ParameterFilter { $Path -eq "$env:temp\me" }
    Mock Get-ChildItem { return @{FullName="A_File.TXT"} } -ParameterFilter { $Path -and $Path.StartsWith($env:temp) }

    Get-ChildItem $env:temp\me
    ```

    Here, both mocks could apply since both filters will pass. A_File.TXT will be returned because it was the most recent Mock created.

    .EXAMPLE
    ```powershell
    Mock Get-ChildItem { return @{FullName = "B_File.TXT"} } -ParameterFilter { $Path -eq "$env:temp\me" }
    Mock Get-ChildItem { return @{FullName = "A_File.TXT"} }

    Get-ChildItem c:\windows
    ```

    Here, A_File.TXT will be returned. Since no filter was specified, it will apply to any call to Get-ChildItem that does not pass another filter.

    .EXAMPLE
    ```powershell
    Mock Get-ChildItem { return @{FullName = "B_File.TXT"} } -ParameterFilter { $Path -eq "$env:temp\me" }
    Mock Get-ChildItem { return @{FullName = "A_File.TXT"} }

    Get-ChildItem $env:temp\me
    ```

    Here, B_File.TXT will be returned. Even though the filterless mock was created more recently. This illustrates that filterless Mocks are always evaluated last regardless of their creation order.

    .EXAMPLE
    Mock Get-ChildItem { return @{FullName = "A_File.TXT"} } -ModuleName MyTestModule

    Using this Mock, all calls to Get-ChildItem from within the MyTestModule module
    will return a hashtable with a FullName property returning "A_File.TXT"

    .EXAMPLE
    ```powershell
    Get-Module -Name ModuleMockExample | Remove-Module
    New-Module -Name ModuleMockExample  -ScriptBlock {
        function Hidden { "Internal Module Function" }
        function Exported { Hidden }

        Export-ModuleMember -Function Exported
    } | Import-Module -Force

    Describe "ModuleMockExample" {
        It "Hidden function is not directly accessible outside the module" {
            { Hidden } | Should -Throw
        }

        It "Original Hidden function is called" {
            Exported | Should -Be "Internal Module Function"
        }

        It "Hidden is replaced with our implementation" {
            Mock Hidden { "Mocked" } -ModuleName ModuleMockExample
            Exported | Should -Be "Mocked"
        }
    }
    ```

    This example shows how calls to commands made from inside a module can be
    mocked by using the -ModuleName parameter.

    .LINK
    https://pester.dev/docs/v5/commands/Mock

    .LINK
    https://pester.dev/docs/v5/usage/mocking
    #>
    [CmdletBinding()]
    param(
        [string]$CommandName,
        [ScriptBlock]$MockWith = {},
        [switch]$Verifiable,
        [ScriptBlock]$ParameterFilter,
        [string]$ModuleName,
        [string[]]$RemoveParameterType,
        [string[]]$RemoveParameterValidation
    )
    if (Is-Discovery) {
        # this is to allow mocks in between Describe and It which is discouraged but common
        # and will make for an easier move to v5
        return
    }

    $SessionState = $PSCmdlet.SessionState

    # use the caller module name as ModuleName, so calling the mock in InModuleScope uses the ModuleName as target module
    if (-not $PSBoundParameters.ContainsKey('ModuleName') -and $null -ne $SessionState.Module) {
        $ModuleName = $SessionState.Module.Name
    }

    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
        Write-PesterDebugMessage -Scope Mock -Message "Setting up $(if ($ParameterFilter) {"parametrized"} else {"default"}) mock for$(if ($ModuleName) {" $ModuleName -"}) $CommandName."
    }


    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
        $null = Set-ScriptBlockHint -Hint "Unbound MockWith - Captured in Mock" -ScriptBlock $MockWith
        $null = if ($ParameterFilter) { Set-ScriptBlockHint -Hint "Unbound ParameterFilter - Captured in Mock" -ScriptBlock $ParameterFilter }
    }

    # takes 0.4 ms max
    $invokeMockCallBack = $ExecutionContext.SessionState.InvokeCommand.GetCommand('Invoke-Mock', 'function')

    $mockData = Get-MockDataForCurrentScope
    $contextInfo = Resolve-Command $CommandName $ModuleName -SessionState $SessionState

    if ($contextInfo.IsMockBootstrapFunction) {
        if ($PesterPreference.Debug.WriteDebugMessages.Value) {
            Write-PesterDebugMessage -Scope Mock -Message "Mock resolves to an existing hook, will only define mock behavior."
        }
        $hook = $contextInfo.Hook
    }
    else {
        if ($PesterPreference.Debug.WriteDebugMessages.Value) {
            Write-PesterDebugMessage -Scope Mock -Message "Mock does not have a hook yet, creating a new one."
        }
        $hook = Create-MockHook -ContextInfo $contextInfo -InvokeMockCallback $invokeMockCallBack
        $mockData.Hooks.Add($hook)
    }

    if ($mockData.Behaviors.ContainsKey($contextInfo.Command.Name)) {
        $behaviors = $mockData.Behaviors[$contextInfo.Command.Name]
    }
    else {
        $behaviors = [System.Collections.Generic.List[Object]]@()
        $mockData.Behaviors[$contextInfo.Command.Name] = $behaviors
    }

    $behavior = New-MockBehavior -ContextInfo $contextInfo -MockWith $MockWith -Verifiable:$Verifiable -ParameterFilter $ParameterFilter -Hook $hook
    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
        Write-PesterDebugMessage -Scope Mock -Message "Adding a new $(if ($behavior.IsDefault) {"default"} else {"parametrized"}) behavior to $(if ($behavior.ModuleName) { "$($behavior.ModuleName) - "})$($behavior.CommandName)."
    }
    $behaviors.Add($behavior)
}

function Get-AllMockBehaviors {
    param(
        [Parameter(Mandatory)]
        [String] $CommandName
    )
    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
        Write-PesterDebugMessage -Scope Mock "Getting all defined mock behaviors in this and parent scopes for command $CommandName."
    }
    # this is used for invoking mocks
    # in there we care about all mocks attached to the current test
    # or any of the mocks above it
    # this does not list mocks in other tests
    $currentTest = Get-CurrentTest
    $inTest = $null -ne $currentTest

    $behaviors = [System.Collections.Generic.List[Object]]@()
    if ($inTest) {
        if ($PesterPreference.Debug.WriteDebugMessages.Value) {
            Write-PesterDebugMessage -Scope Mock "We are in a test. Finding all behaviors in this test."
        }
        $bs = @(if ($currentTest.PluginData.Mock.Behaviors.ContainsKey($CommandName)) {
                $currentTest.PluginData.Mock.Behaviors.$CommandName
            })
        if ($null -ne $bs -and $bs.Count -gt 0) {
            if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                Write-PesterDebugMessage -Scope Mock "Found behaviors for '$CommandName' in the test."
            }
            $bss = @(for ($i = $bs.Count - 1; $i -ge 0; $i--) { $bs[$i] })
            $behaviors.AddRange($bss)
        }
        else {
            if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                Write-PesterDebugMessage -Scope Mock "Found no behaviors for '$CommandName' in this test."
            }
        }
    }
    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
        Write-PesterDebugMessage -Scope Mock "Finding all behaviors in this block and parent blocks."
    }
    $block = Get-CurrentBlock

    # recurse up
    $behaviorsInTestCount = $behaviors.Count
    while ($null -ne $block) {

        # action
        $bs = @(if ($block.PluginData.Mock.Behaviors.ContainsKey($CommandName)) {
                $block.PluginData.Mock.Behaviors.$CommandName
            })

        if ($null -ne $bs -and 0 -lt @($bs).Count) {
            if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                Write-PesterDebugMessage -Scope Mock "Found behaviors for '$CommandName' in '$($block.Name)'."
            }
            $bss = @(for ($i = $bs.Count - 1; $i -ge 0; $i--) { $bs[$i] })
            $behaviors.AddRange($bss)
        }
        # action end

        $block = $block.Parent
    }

    if ($PesterPreference.Debug.WriteDebugMessages.Value -and $behaviorsInTestCount -eq $behaviors.Count) {
        Write-PesterDebugMessage -Scope Mock "Found $($behaviors.Count - $behaviorsInTestCount) behaviors in all parent blocks, and $behaviorsInTestCount behaviors in test."
    }

    $behaviors
}

function Get-VerifiableBehaviors {
    [CmdletBinding()]
    param(
    )
    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
        Write-PesterDebugMessage -Scope Mock "Getting all verifiable mock behaviors in this scope."
    }

    $currentTest = Get-CurrentTest
    $inTest = $null -ne $currentTest

    $behaviors = [System.Collections.Generic.List[Object]]@()
    if ($inTest) {
        if ($PesterPreference.Debug.WriteDebugMessages.Value) {
            Write-PesterDebugMessage -Scope Mock "We are in a test. Finding all behaviors in this test."
        }
        $allBehaviors = $currentTest.PluginData.Mock.Behaviors.Values
        if ($null -ne $allBehaviors -and $allBehaviors.Count -gt 0) {
            # all behaviors for all commands
            foreach ($commandBehaviors in $allBehaviors) {
                if ($null -ne $commandBehaviors -and $commandBehaviors.Count -gt 0) {
                    # all behaviors for single command
                    foreach ($behavior in $commandBehaviors) {
                        if ($behavior.Verifiable) {
                            $behaviors.Add($behavior)
                        }
                    }
                }
            }
        }
    }
    $block = Get-CurrentBlock

    # recurse up
    while ($null -ne $block) {

        ## action
        $allBehaviors = $block.PluginData.Mock.Behaviors.Values
        # all behaviors for all commands
        if ($null -ne $allBehaviors -or $allBehaviors.Count -ne 0) {
            foreach ($commandBehaviors in $allBehaviors) {
                if ($null -ne $commandBehaviors -and $commandBehaviors.Count -gt 0) {
                    # all behaviors for single command
                    foreach ($behavior in $commandBehaviors) {
                        if ($behavior.Verifiable) {
                            $behaviors.Add($behavior)
                        }
                    }
                }
            }
        }

        # end action
        $block = $block.Parent
    }
    # end

    $behaviors
}


function Get-AssertMockTable {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        $Frame,
        [Parameter(Mandatory)]
        [String] $CommandName,
        [String] $ModuleName
    )
    # frame looks like this
    # [PSCustomObject]@{
    #     Scope = int
    #     Frame = block | test
    #     IsTest = bool
    # }

    $key = "$ModuleName||$CommandName"
    $scope = $Frame.Scope
    $inTest = $Frame.IsTest
    # this is used for assertions, in here we need to collect
    # all call histories for the given command in the scope.
    # if the scope number is bigger than 0 then we need all
    # in the whole scope including all its

    if ($inTest -and 0 -eq $scope) {
        # we are in test and we care only about the test scope,
        # this is easy, we just look for call history of the command


        $history = if ($Frame.Frame.PluginData.Mock.CallHistory.ContainsKey($Key)) {
            # do not enumerate so we get the same thing back
            # even if it is a collection
            $Frame.Frame.PluginData.Mock.CallHistory.$Key
        }

        if ($history) {
            return @{
                "$key" = [Collections.Generic.List[object]]@($history)
            }
        }
        else {
            return @{
                "$key" = [Collections.Generic.List[object]]@()
            }

            # TODO: This figures out if the mock was defined, when there  were 0 calls, it adds overhead
            # and does not work with the current layout of hooks and history
            # $test = $Frame.Frame
            # $mockInTest = tryGetValue $test.PluginData.Mock.Hooks $key
            # if ($mockInTest) {
            #     # the mock was defined in it but it was not called in this scope
            #     return @{
            #         "$key" = @()
            #     }
            # }
            # else {
            #     # try finding the mock definition in upper scopes, because it was not found in the current test
            #     $mockInBlock = Recurse-Up $test.Block {
            #         param ($b)
            #         if ((tryGetProperty $b.PluginData Mock) -and (tryGetProperty $b.PluginData.Mock Hooks)) {
            #             tryGetValue $b.PluginData.Mock.Hooks $key
            #         }
            #     }

            #     if (none $mockInBlock) {
            #         throw "Could not find any mock definition for $CommandName$(if ($ModuleName) { " from module $ModuleName"})."
            #     }
            #     else {
            #         # the mock was defined in some upper scope but it was not called in this it
            #         return @{
            #             "$key" = @()
            #         }
            #     }
            #}
        }
    }


    # this is harder, we have scope and we are in a block, we need to look
    # in this block and any child for mock calls

    $currentBlock = if ($inTest) { $Frame.Frame.Block } else { $Frame.Frame }
    if ($inTest) {
        # we are in test but we only inspect blocks, so getting current block automatically
        # makes us in scope 1, so if we got 1 from the parameter we need to translate it to 0
        $scope -= 1
    }

    if ($scope -eq 0) {
        # in scope 0 the current block is the base block
        $block = $currentBlock
    }
    elseif ($scope -eq 1) {
        # in scope 1 it is the parent
        $block = if ($null -ne $currentBlock.Parent) { $currentBlock.Parent } else { $currentBlock }
    }
    else {
        # otherwise we just walk up as many scopes as needed until
        # we reach the desired scope, or the root of the tree, the above ifs could
        # be replaced by this, but they are easier to write and use for the most common
        # cases
        $i = $currentBlock
        $level = $scope - 1
        while ($level -ge 0 -and ($null -ne $i.Parent)) {
            $level--
            $i = $i.Parent
        }
        $block = $i
    }


    # we have our block so we need to collect all the history for the given mock

    $history = [System.Collections.Generic.List[Object]]@()
    $addToHistory = {
        param($b)

        if (-not $b.pluginData.ContainsKey('Mock')) {
            return
        }

        $mockData = $b.pluginData.Mock

        $callHistory = $mockData.CallHistory


        $v = if ($callHistory.ContainsKey($key)) {
            $callHistory.$key
        }

        if ($null -ne $v -and 0 -ne $v.Count) {
            $history.AddRange([System.Collections.Generic.List[Object]]@($v))
        }
    }

    Fold-Block -Block $Block -OnBlock $addToHistory -OnTest $addToHistory
    if (0 -eq $history.Count) {
        # we did not find any calls, is the mock even defined?
        # TODO: should we look in the scope and the upper scopes for the mock or just assume 0 calls were done?
        return @{
            "$key" = [Collections.Generic.List[object]]@()
        }
    }


    return @{
        "$key" = [Collections.Generic.List[object]]@($history)
    }
}

function Get-MockDataForCurrentScope {
    [CmdletBinding()]
    param(
    )

    # this returns a mock table based on location, that we
    # then use to add the mock into, keep in mind that what we
    # pass must be a reference, so the data can be written in this
    # table

    $location = $currentTest = Get-CurrentTest
    $inTest = $null -ne $currentTest

    if (-not $inTest) {
        $location = $currentBlock = Get-CurrentBlock
    }

    if (none @($currentTest, $currentBlock)) {
        throw "I am neither in a test or a block, where am I?"
    }

    if (-not $location.PluginData.Mock) {
        throw "Mock data are not setup for this scope, what happened?"
    }

    if ($inTest) {
        if ($PesterPreference.Debug.WriteDebugMessages.Value) {
            Write-PesterDebugMessage -Scope Mock "We are in a test. Returning mock table from test scope."
        }
    }
    else {
        if ($PesterPreference.Debug.WriteDebugMessages.Value) {
            Write-PesterDebugMessage -Scope Mock "We are in a block, one time setup or similar. Returning mock table from test block."
        }
    }

    $location.PluginData.Mock
}

function Assert-VerifiableMock {
    <#
    .SYNOPSIS
    Checks if all verifiable Mocks has been called at least once.

    THIS COMMAND IS OBSOLETE AND WILL BE REMOVED SOMEWHERE DURING v5 LIFETIME,
    USE Should -InvokeVerifiable INSTEAD.

    .LINK
    https://pester.dev/docs/v5/commands/Assert-VerifiableMock
    #>

    # Should does not accept a session state, so invoking it directly would
    # make the assertion run from inside of Pester module, we move it to the
    # user scope instead an run it from there to keep the scoping correct
    # for this compatibility adapter
    [CmdletBinding()]param()
    $sb = {
        Should -InvokeVerifiable
    }

    Set-ScriptBlockScope -ScriptBlock $sb -SessionState $PSCmdlet.SessionState
    & $sb
}
function Should-InvokeVerifiable ([switch] $Negate, [string] $Because) {
    <#
    .SYNOPSIS
    Checks if any Verifiable Mock has not been invoked. If so, this will throw an exception.

    .DESCRIPTION
    This can be used in tandem with the -Verifiable switch of the Mock
    function. Mock can be used to mock the behavior of an existing command
    and optionally take a -Verifiable switch. When Should -InvokeVerifiable
    is called, it checks to see if any Mock marked Verifiable has not been
    invoked. If any mocks have been found that specified -Verifiable and
    have not been invoked, an exception will be thrown.

    .EXAMPLE
    Mock Set-Content {} -Verifiable -ParameterFilter {$Path -eq "some_path" -and $Value -eq "Expected Value"}

    { ...some code that never calls Set-Content some_path -Value "Expected Value"... }

    Should -InvokeVerifiable

    This will throw an exception and cause the test to fail.

    .EXAMPLE
    Mock Set-Content {} -Verifiable -ParameterFilter {$Path -eq "some_path" -and $Value -eq "Expected Value"}

    Set-Content some_path -Value "Expected Value"

    Should -InvokeVerifiable

    This will not throw an exception because the mock was invoked.
    #>
    $behaviors = @(Get-VerifiableBehaviors)
    Should-InvokeVerifiableInternal @PSBoundParameters -Behaviors $behaviors
}

& $script:SafeCommands['Add-ShouldOperator'] -Name InvokeVerifiable `
    -InternalName Should-InvokeVerifiable `
    -Test         ${function:Should-InvokeVerifiable}

Set-ShouldOperatorHelpMessage -OperatorName InvokeVerifiable `
    -HelpMessage 'Checks if any Verifiable Mock has not been invoked. If so, this will throw an exception.'

function Assert-MockCalled {
    <#
    .SYNOPSIS
    Checks if a Mocked command has been called a certain number of times
    and throws an exception if it has not.

    THIS COMMAND IS OBSOLETE AND WILL BE REMOVED SOMEWHERE DURING v5 LIFETIME,
    USE Should -Invoke INSTEAD.

    .LINK
    https://pester.dev/docs/v5/commands/Assert-MockCalled
    #>
    [CmdletBinding(DefaultParameterSetName = 'ParameterFilter')]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$CommandName,

        [Parameter(Position = 1)]
        [int]$Times = 1,

        [ScriptBlock]$ParameterFilter = { $True },

        [Parameter(ParameterSetName = 'ExclusiveFilter', Mandatory = $true)]
        [scriptblock] $ExclusiveFilter,

        [string] $ModuleName,

        [string] $Scope = 0,
        [switch] $Exactly
    )

    # Should does not accept a session state, so invoking it directly would
    # make the assertion run from inside of Pester module, we move it to the
    # user scope instead an run it from there to keep the scoping correct
    # for this compatibility adapter

    $sb = {
        param ($__params__p)
        Should -Invoke @__params__p
    }

    Set-ScriptBlockScope -ScriptBlock $sb -SessionState $PSCmdlet.SessionState
    & $sb $PSBoundParameters
}

function Should-Invoke {
    <#
    .SYNOPSIS
    Checks if a Mocked command has been called a certain number of times
    and throws an exception if it has not.

    .DESCRIPTION
    This command verifies that a mocked command has been called a certain number
    of times.  If the call history of the mocked command does not match the parameters
    passed to Should -Invoke, Should -Invoke will throw an exception.

    .PARAMETER CommandName
    The mocked command whose call history should be checked.

    .PARAMETER ModuleName
    The module where the mock being checked was injected.  This is optional,
    and must match the ModuleName that was used when setting up the Mock.

    .PARAMETER Times
    The number of times that the mock must be called to avoid an exception
    from throwing.

    .PARAMETER Exactly
    If this switch is present, the number specified in Times must match
    exactly the number of times the mock has been called. Otherwise it
    must match "at least" the number of times specified.  If the value
    passed to the Times parameter is zero, the Exactly switch is implied.

    .PARAMETER ParameterFilter
    An optional filter to qualify which calls should be counted. Only those
    calls to the mock whose parameters cause this filter to return true
    will be counted.

    .PARAMETER ExclusiveFilter
    Like ParameterFilter, except when you use ExclusiveFilter, and there
    were any calls to the mocked command which do not match the filter,
    an exception will be thrown.  This is a convenient way to avoid needing
    to have two calls to Should -Invoke like this:

    Should -Invoke SomeCommand -Times 1 -ParameterFilter { $something -eq $true }
    Should -Invoke SomeCommand -Times 0 -ParameterFilter { $something -ne $true }

    .PARAMETER Scope
    An optional parameter specifying the Pester scope in which to check for
    calls to the mocked command. For RSpec style tests, Should -Invoke will find
    all calls to the mocked command in the current Context block (if present),
    or the current Describe block (if there is no active Context), by default. Valid
    values are Describe, Context and It. If you use a scope of Describe or
    Context, the command will identify all calls to the mocked command in the
    current Describe / Context block, as well as all child scopes of that block.

    .EXAMPLE
    Mock Set-Content {}

    {... Some Code ...}

    Should -Invoke Set-Content

    This will throw an exception and cause the test to fail if Set-Content is not called in Some Code.

    .EXAMPLE
    Mock Set-Content -parameterFilter {$path.StartsWith("$env:temp\")}

    {... Some Code ...}

    Should -Invoke Set-Content 2 { $path -eq "$env:temp\test.txt" }

    This will throw an exception if some code calls Set-Content on $path=$env:temp\test.txt less than 2 times

    .EXAMPLE
    Mock Set-Content {}

    {... Some Code ...}

    Should -Invoke Set-Content 0

    This will throw an exception if some code calls Set-Content at all

    .EXAMPLE
    Mock Set-Content {}

    {... Some Code ...}

    Should -Invoke Set-Content -Exactly 2

    This will throw an exception if some code does not call Set-Content Exactly two times.

    .EXAMPLE
    Describe 'Should -Invoke Scope behavior' {
        Mock Set-Content { }

        It 'Calls Set-Content at least once in the It block' {
            {... Some Code ...}

            Should -Invoke Set-Content -Exactly 0 -Scope It
        }
    }

    Checks for calls only within the current It block.

    .EXAMPLE
    Describe 'Describe' {
        Mock -ModuleName SomeModule Set-Content { }

        {... Some Code ...}

        It 'Calls Set-Content at least once in the Describe block' {
            Should -Invoke -ModuleName SomeModule Set-Content
        }
    }

    Checks for calls to the mock within the SomeModule module.  Note that both the Mock
    and Should -Invoke commands use the same module name.

    .EXAMPLE
    Should -Invoke Get-ChildItem -ExclusiveFilter { $Path -eq 'C:\' }

    Checks to make sure that Get-ChildItem was called at least one time with
    the -Path parameter set to 'C:\', and that it was not called at all with
    the -Path parameter set to any other value.

    .NOTES
    The parameter filter passed to Should -Invoke does not necessarily have to match the parameter filter
    (if any) which was used to create the Mock.  Should -Invoke will find any entry in the command history
    which matches its parameter filter, regardless of how the Mock was created.  However, if any calls to the
    mocked command are made which did not match any mock's parameter filter (resulting in the original command
    being executed instead of a mock), these calls to the original command are not tracked in the call history.
    In other words, Should -Invoke can only be used to check for calls to the mocked implementation, not
    to the original.
    #>
    [CmdletBinding(DefaultParameterSetName = 'ParameterFilter')]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$CommandName,

        [Parameter(Position = 1)]
        [int]$Times = 1,

        [ScriptBlock]$ParameterFilter = { $True },

        [Parameter(ParameterSetName = 'ExclusiveFilter', Mandatory = $true)]
        [scriptblock] $ExclusiveFilter,

        [string] $ModuleName,
        [string] $Scope = 0,
        [switch] $Exactly,

        # built-in variables
        [object] $ActualValue,
        [switch] $Negate,
        [string] $Because,
        [Management.Automation.SessionState] $CallerSessionState
    )

    if ($null -ne $ActualValue) {
        throw "Should -Invoke does not take pipeline input or ActualValue."
    }

    # Assert-DescribeInProgress -CommandName Should -Invoke
    if ('Describe', 'Context', 'It' -notcontains $Scope -and $Scope -notmatch "^\d+$") {
        throw "Parameter Scope must be one of 'Describe', 'Context', 'It' or a non-negative number."
    }

    if (-not $PSBoundParameters.ContainsKey("ModuleName")) {
        # user did not specify the target module, using the caller session state module name
        # to ensure we bind to the current module when running in InModuleScope
        $ModuleName = if ($CallerSessionState.Module) { $CallerSessionState.Module.Name } else { $null }
    }

    if ($PSCmdlet.ParameterSetName -eq 'ExclusiveFilter' -and $Negate) {
        # Using -Not with -ExclusiveFilter makes for a very confusing expectation. For example, given the following mocked function:
        #
        # Mock FunctionUnderTest {}
        #
        # Consider the normal expectation:
        # `Should -Invoke FunctionUnderTest -ExclusiveFilter { $param1 -eq 'one' }`
        #
        # | Invocations               | Should raises an error |
        # | --------------------------| ---------------------- |
        # | FunctionUnderTest "one"   | No                     |
        # | --------------------------| ---------------------- |
        # | FunctionUnderTest "one"   | Yes                    |
        # | FunctionUnderTest "two"   |                        |
        # | --------------------------| ---------------------- |
        # | FunctionUnderTest "two"   | Yes                    |
        #
        # So it follows that if we negate that, using -Not, then we should get the opposite result. That is:
        #
        # `Should -Not -Invoke FunctionUnderTest -ExclusiveFilter { $param1 -eq 'one' }`
        #
        # | Invocations               | Should raises an error |
        # | --------------------------| ---------------------- |
        # | FunctionUnderTest "one"   | Yes                    |
        # | --------------------------| ---------------------- |
        # | FunctionUnderTest "one"   | No                     | <---- Problem!
        # | FunctionUnderTest "two"   |                        |
        # | --------------------------| ---------------------- |
        # | FunctionUnderTest "two"   | No                     |
        #
        # The problem is the second row. Because there was an invocation of `{ $param1 -eq 'one' }` the
        # expectation is not met and Should should raise an error.
        #
        # In fact it can be shown that
        #
        # `Should -Not -Invoke FunctionUnderTest -ExclusiveFilter { ... }`
        #
        # and
        #
        # `Should -Not -Invoke FunctionUnderTest -ParameterFilter { ... }`
        #
        # have the same result.
        throw "Cannot use -ExclusiveFilter when -Not is specified. Use -ParameterFilter instead."
    }

    $isNumericScope = $Scope -match "^\d+$"
    $currentTest = Get-CurrentTest
    $inTest = $null -ne $currentTest
    $currentBlock = Get-CurrentBlock

    $frame = if ($isNumericScope) {
        [PSCustomObject]@{
            Scope  = $Scope
            Frame  = if ($inTest) { $currentTest } else { $currentBlock }
            IsTest = $inTest
        }
    }
    else {
        if ($Scope -eq 'It') {
            if ($inTest) {
                [PSCustomObject]@{
                    Scope  = 0
                    Frame  = $currentTest
                    IsTest = $true
                }
            }
            else {
                throw "Assertion is placed outside of an It block, but -Scope It is specified."
            }
        }
        else {
            # we are not looking for an It scope, so we are looking for a block scope
            # blocks can be chained arbitrarily, so we need to walk up the tree looking
            # for the first match

            # TODO: this is ad-hoc implementation of folding the tree of parents
            # make the normal fold work better, and replace this
            $i = $currentBlock
            $level = 0
            while ($null -ne $i) {
                if ($Scope -eq $i.FrameworkData.CommandUsed) {
                    if ($inTest) {
                        # we are in a test but we looked up the scope based on the block
                        # so we need to add 1 to the scope, because the block is scope 1 for us
                        $level++
                    }

                    [PSCustomObject]@{
                        Scope  = $level
                        Frame  = if ($inTest) { $currentTest } else { $currentBlock }
                        IsTest = $inTest
                    }
                    break
                }
                $level++
                $i = $i.Parent
            }

            if ($null -eq $i) {
                # Reached parent of root-block which means we never called break (got a hit) in the while-loop
                throw "Assertion is not placed directly nor nested inside a $Scope block, but -Scope $Scope is specified."
            }
        }
    }

    $SessionState = $CallerSessionState
    # This resolve happens only because we need to resolve from an alias to the real command
    # name, and we cannot know what all aliases are there for a command in the module, easily,
    # we could short circuit this resolve when we find history, and only resolve if we don't
    # have any history. We could also keep info about the alias from which we originally
    # resolved the command, which would give us another piece of info. But without scanning
    # all the aliases in the module we won't be able to get rid of this, but that would be
    # cost we would have to pay all the time, instead of just doing extra resolve when we find
    # no history.
    $contextInfo = Resolve-Command $CommandName $ModuleName -SessionState $SessionState
    if ($null -eq $contextInfo.Hook) {
        throw "Should -Invoke: Could not find Mock for command $CommandName in $(if ([string]::IsNullOrEmpty($ModuleName)){ "script scope" } else { "module $ModuleName" }). Was the mock defined? Did you use the same -ModuleName as on the Mock? When using InModuleScope are InModuleScope, Mock and Should -Invoke using the same -ModuleName?"
    }
    $resolvedModule = $contextInfo.TargetModule
    $resolvedCommand = $contextInfo.Command.Name

    $mockTable = Get-AssertMockTable -Frame $frame -CommandName $resolvedCommand -ModuleName $resolvedModule

    if ($PSBoundParameters.ContainsKey('Scope')) {
        $PSBoundParameters.Remove('Scope')
    }
    if ($PSBoundParameters.ContainsKey('ModuleName')) {
        $PSBoundParameters.Remove('ModuleName')
    }
    if ($PSBoundParameters.ContainsKey('CommandName')) {
        $PSBoundParameters.Remove('CommandName')
    }
    if ($PSBoundParameters.ContainsKey('ActualValue')) {
        $PSBoundParameters.Remove('ActualValue')
    }
    if ($PSBoundParameters.ContainsKey('CallerSessionState')) {
        $PSBoundParameters.Remove('CallerSessionState')
    }

    $result = Should-InvokeInternal @PSBoundParameters `
        -ContextInfo $contextInfo `
        -MockTable $mockTable `
        -SessionState $SessionState

    return $result
}

& $script:SafeCommands['Add-ShouldOperator'] -Name Invoke `
    -InternalName Should-Invoke `
    -Test         ${function:Should-Invoke}

Set-ShouldOperatorHelpMessage -OperatorName Invoke `
    -HelpMessage 'Checks if a Mocked command has been called a certain number of times and throws an exception if it has not.'

function Invoke-Mock {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $CommandName,

        [Parameter(Mandatory = $true)]
        [hashtable] $MockCallState,

        [string]
        $ModuleName,

        [hashtable]
        $BoundParameters = @{},

        [object[]]
        $ArgumentList = @(),

        [object] $CallerSessionState,

        [ValidateSet('Begin', 'Process', 'End')]
        [string] $FromBlock,

        [object] $InputObject,

        $Hook
    )

    if ('End' -eq $FromBlock) {
        if (-not $MockCallState.ShouldExecuteOriginalCommand) {
            if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                Write-PesterDebugMessage -Scope MockCore "Mock for $CommandName was invoked from block $FromBlock, and should not execute the original command, returning."
            }
            return
        }
        else {
            if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                Write-PesterDebugMessage -Scope MockCore "Mock for $CommandName was invoked from block $FromBlock, and should execute the original command, forwarding the call to Invoke-MockInternal without call history and without behaviors."
            }
            Invoke-MockInternal @PSBoundParameters -Behaviors @() -CallHistory @{}
            return
        }
    }

    if ('Begin' -eq $FromBlock) {
        if ($PesterPreference.Debug.WriteDebugMessages.Value) {
            Write-PesterDebugMessage -Scope MockCore "Mock for $CommandName was invoked from block $FromBlock, and should execute the original command, Invoke-MockInternal without call history and without behaviors."
        }
        Invoke-MockInternal @PSBoundParameters -Behaviors @() -CallHistory @{}
        return
    }

    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
        Write-PesterDebugMessage -Scope Mock "Mock for $CommandName was invoked from block $FromBlock, resolving call history and behaviors."
    }

    # this function is called by the mock bootstrap function, so every implementer
    # should implement this (but I keep it separate from the core function so I can
    # test without dependency on scopes)
    $allBehaviors = Get-AllMockBehaviors -CommandName $CommandName

    # there is some conflict that keeps ModuleName constant without throwing. It is not a problem
    # because it does not contain whitespace, but if someone mistypes we won't be able to fix it
    # to be empty string in the below condition.
    $TargetModule = $ModuleName
    $targettingAModule = -not [string]::IsNullOrWhiteSpace($TargetModule)

    $getBehaviorMessage = if ($PesterPreference.Debug.WriteDebugMessages.Value) {
        # output scriptblock that we can call later
        {
            param ($b)
            "     Target module: $(if ($b.ModuleName) { $b.ModuleName } else { '$null' })`n"
            "    Body: { $($b.ScriptBlock.ToString().Trim()) }`n"
            "    Filter: $(if (-not $b.IsDefault) { "{ $($b.Filter.ToString().Trim()) }" } else { '$null' })`n"
            "    Default: $(if ($b.IsDefault) { '$true' } else { '$false' })`n"
            "    Verifiable: $(if ($b.Verifiable) { '$true' } else { '$false' })"
        }
    }

    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
        Write-PesterDebugMessage -Scope Mock -Message "Filtering behaviors for command $CommandName, for target module $(if ($targettingAModule) { $TargetModule } else { '$null' }) (Showing all behaviors for this command, actual filtered list is further in the log, look for 'Filtered parametrized behaviors:' and 'Filtered default behaviors:'):"
    }

    $moduleBehaviors = [System.Collections.Generic.List[Object]]@()
    $moduleDefaultBehavior = $null
    $nonModuleBehaviors = [System.Collections.Generic.List[Object]]@()
    $nonModuleDefaultBehavior = $null
    foreach ($b in $allBehaviors) {
        # sort behaviors into filtered and default behaviors for the targeted module
        # other modules and no-modules. The behaviors for other modules we don't care about so we
        # don't collect them. For the behaviors for the target module and no module we split them
        # to filtered and default. When we target a module mock, we select the filtered + the most recent default, but when
        # there is no default we take the most recent default from non-module behaviors, to allow fallback to it, because that is
        # how it was historically done, and makes it a bit more safe.
        if ($b.IsInModule) {
            if ($TargetModule -eq $b.ModuleName) {
                if ($b.IsDefault) {
                    # keep the first found (the last one defined)
                    if ($null -eq $moduleDefaultBehavior) {
                        if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                            Write-PesterDebugMessage -Scope Mock -Message "Behavior is a default behavior from the target module $TargetModule, saving it:`n$(& $getBehaviorMessage $b)"
                        }
                        $moduleDefaultBehavior = $b
                    }
                    else {
                        if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                            Write-PesterDebugMessage -Scope Mock -Message "Behavior is a default behavior from the target module $TargetModule, but we already have one that was defined more recently it, skipping it:`n$(& $getBehaviorMessage $b)"
                        }
                    }
                }
                else {
                    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                        Write-PesterDebugMessage -Scope Mock -Message "Behavior is a parametrized behavior from the target module $TargetModule, adding it to parametrized behavior list:`n$(& $getBehaviorMessage $b)"
                    }
                    $moduleBehaviors.Add($b)
                }
            }
            else {
                # not the targeted module, skip it
                if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                    Write-PesterDebugMessage -Scope Mock -Message "Behavior is not from the target module $(if ($targettingAModule) { $TargetModule } else { '$null' }), skipping it:`n$(& $getBehaviorMessage $b)"
                }
            }
        }
        else {
            if ($b.IsDefault) {
                # keep the first found (the last one defined)
                if ($null -eq $nonModuleDefaultBehavior) {
                    $nonModuleDefaultBehavior = $b
                    if ($targettingAModule -and $PesterPreference.Debug.WriteDebugMessages.Value) {
                        Write-PesterDebugMessage -Scope Mock -Message "Behavior is a default behavior from script scope, saving it to use as a fallback if default behavior for module $TargetModule is not found:`n$(& $getBehaviorMessage $b)"
                    }

                    if (-not $targettingAModule -and $PesterPreference.Debug.WriteDebugMessages.Value) {
                        Write-PesterDebugMessage -Scope Mock -Message "Behavior is a default behavior from script scope, saving it:`n$(& $getBehaviorMessage $b)"
                    }
                }
                else {
                    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
                        Write-PesterDebugMessage -Scope Mock -Message "Behavior is a default behavior from script scope, but we already have one that was defined more recently it, skipping it:`n$(& $getBehaviorMessage $b)"
                    }
                }
            }
            else {
                if ($targettingAModule -and $PesterPreference.Debug.WriteDebugMessages.Value) {
                    Write-PesterDebugMessage -Scope Mock -Message "Behavior is a parametrized behavior from script scope, skipping it. (Parametrized script scope behaviors are not used as fallback for module scoped mocks.):`n$(& $getBehaviorMessage $b)"
                }

                if (-not $targettingAModule -and $PesterPreference.Debug.WriteDebugMessages.Value) {
                    Write-PesterDebugMessage -Scope Mock -Message "Behavior is a parametrized behavior from script scope, adding it to non-module parametrized behavior list:`n$(& $getBehaviorMessage $b)"
                }

                $nonModuleBehaviors.Add($b)
            }
        }
    }

    # if we are targeting a module use the behaviors for the current module, but if there is no default the fall back to the non-module default behavior.
    # do not fallback to non-module filtered behaviors. This is here for safety, and for compatibility when doing Mock Remove-Item {}, and then mocking in module
    # then the default mock for Remove-Item should be effective.

    # using @() to always get array. This avoids null error in Invoke-MockInternal when no behaviors where found (if-else unwraps the lists)
    $behaviors = @(if ($targettingAModule) {
        # we have default module behavior add it to the filtered behaviors if there are any
        if ($null -ne $moduleDefaultBehavior) {
            $moduleBehaviors.Add($moduleDefaultBehavior)
        }
        else {
            # we don't have default module behavior add the default non-module behavior if we have any
            if ($null -ne $nonModuleDefaultBehavior) {
                $moduleBehaviors.Add($nonModuleDefaultBehavior)
            }
        }

        $moduleBehaviors
    }
    else {
        # we are not targeting a mock in a module use the non module behaviors
        if ($null -ne $nonModuleDefaultBehavior) {
            # add the default non-module behavior if we have any
            $nonModuleBehaviors.Add($nonModuleDefaultBehavior)
        }

        $nonModuleBehaviors
    })

    $callHistory = (Get-MockDataForCurrentScope).CallHistory

    if ($PesterPreference.Debug.WriteDebugMessages.Value) {
        $any = $false
        $message = foreach ($b in $behaviors) {
            if (-not $b.IsDefault) {
                $any = $true
                & $getBehaviorMessage $b
            }
        }
        if (-not $any) {
            $message = '$null'
        }
        Write-PesterDebugMessage -Scope Mock -Message "Filtered parametrized behaviors:`n$message"

        $default = foreach ($b in $behaviors) {
            if ($b.IsDefault) {
                $b
                break
            }
        }
        $message = if ($null -ne $default) { & $getBehaviorMessage $b } else { '$null' }
        $fallBack = if ($null -ne $default -and $targettingAModule -and [string]::IsNullOrEmpty($b.ModuleName) ) { " (fallback to script scope default behavior)" } else { $null }
        Write-PesterDebugMessage -Scope Mock -Message "Filtered default behavior$($fallBack):`n$message"
    }

    Invoke-MockInternal @PSBoundParameters -Behaviors $behaviors -CallHistory $callHistory
}

function Assert-RunInProgress {
    param(
        [Parameter(Mandatory)]
        [String] $CommandName
    )

    if (Is-Discovery) {
        throw "$CommandName can run only during Run, but not during Discovery."
    }
}



# file src\functions\Set-ItResult.ps1
function Set-ItResult {
    <#
    .SYNOPSIS
    Set-ItResult is used inside the It block to explicitly set the test result

    .DESCRIPTION
    Sometimes a test shouldn't be executed, sometimes the condition cannot be evaluated.
    By default such tests would typically fail and produce a big red message.
    Using Set-ItResult it is possible to set the result from the inside of the It script
    block to either inconclusive, pending or skipped.

    As of Pester 5, there is no "Inconclusive" or "Pending" test state, so all tests will now go to state skipped,
    however the test result notes will include information about being inconclusive or testing to keep this command
    backwards compatible

    .PARAMETER Inconclusive
    Sets the test result to inconclusive. Cannot be used at the same time as -Pending or -Skipped

    .PARAMETER Pending
    **DEPRECATED** Sets the test result to pending. Cannot be used at the same time as -Inconclusive or -Skipped

    .PARAMETER Skipped
    Sets the test result to skipped. Cannot be used at the same time as -Inconclusive or -Pending

    .PARAMETER Because
    Similarly to failing tests, skipped and inconclusive tests should have reason. It allows
    to provide information to the user why the test is neither successful nor failed.

    .EXAMPLE
    ```powershell
    Describe "Example" {
        It "Inconclusive test" {
            Set-ItResult -Inconclusive -Because "we want it to be inconclusive"
        }
        It "Skipped test" {
            Set-ItResult -Skipped -Because "we want it to be skipped"
        }
    }
    ```

    the output should be

    ```
    Describing Example
      [?] Inconclusive test is inconclusive, because we want it to be inconclusive 35ms (32ms|3ms)
      [!] Skipped test is skipped, because we want it to be skipped 3ms (2ms|1ms)
    Tests completed in 78ms
    Tests Passed: 0, Failed: 0, Skipped: 1, Inconclusive: 1, NotRun: 0
    ```

    .LINK
    https://pester.dev/docs/v5/commands/Set-ItResult
#>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $false, ParameterSetName = "Inconclusive")][switch]$Inconclusive,
        [Parameter(Mandatory = $false, ParameterSetName = "Pending")][switch]$Pending,
        [Parameter(Mandatory = $false, ParameterSetName = "Skipped")][switch]$Skipped,
        [string]$Because
    )

    Assert-DescribeInProgress -CommandName Set-ItResult

    $result = $PSCmdlet.ParameterSetName

    switch ($null) {
        $File {
            [String]$File = $MyInvocation.ScriptName
        }
        $Line {
            [String]$Line = $MyInvocation.ScriptLineNumber
        }
        $LineText {
            [String]$LineText = $MyInvocation.Line.trim()
        }
    }

    switch ($result) {
        'Inconclusive' {
            [String]$errorId = 'PesterTestInconclusive'
            [String]$message = "is inconclusive"
            break
        }
        'Pending' {
            [String]$errorId = 'PesterTestPending'
            [String]$message = "is pending"
            break
        }
        'Skipped' {
            [String]$errorId = 'PesterTestSkipped'
            [String]$message = "is skipped"
            break
        }
    }

    if ($Because) {
        [String]$formatted = Format-Because $Because
        [String]$message += ",$($formatted.SubString(0, $formatted.Length - 1))"
    }

    throw [Pester.Factory]::CreateErrorRecord(
        $errorId, #string errorId
        $Message, #string message
        $File, #string file
        $Line, #string line
        $LineText, #string lineText
        $false #bool terminating
    )
}
# file src\functions\SetupTeardown.ps1
function BeforeEach {
    <#
    .SYNOPSIS
        Defines a series of steps to perform at the beginning of every It block within
        the current Context or Describe block.

    .DESCRIPTION
        BeforeEach runs once before every test in the current or any child blocks.
        Typically this is used to create all the prerequisites for the current test,
        such as writing content to a file.

        BeforeEach and AfterEach are unique in that they apply to the entire Context
        or Describe block, regardless of the order of the statements in the
        Context or Describe.

    .PARAMETER ScriptBlock
        A scriptblock with steps to be executed during setup.

    .EXAMPLE
        ```powershell
        Describe "File parsing" {
            BeforeEach {
                # randomized path, to get fresh file for each test
                $file = "$([IO.Path]::GetTempPath())/$([Guid]::NewGuid())_form.xml"
                Copy-Item -Source $template -Destination $file -Force | Out-Null
            }

            It "Writes username" {
                Write-XmlForm -Path $file -Field "username" -Value "nohwnd"
                $content = Get-Content $file
                # ...
            }

            It "Writes name" {
                Write-XmlForm -Path $file -Field "name" -Value "Jakub"
                $content = Get-Content $file
                # ...
            }
        }
        ```

        The example uses BeforeEach to ensure a clean sample-file is used for each test.

    .LINK
        https://pester.dev/docs/v5/commands/BeforeEach

    .LINK
        https://pester.dev/docs/v5/usage/setup-and-teardown
    #>
    [CmdletBinding()]
    param
    (
        # the scriptblock to execute
        [Parameter(Mandatory = $true,
            Position = 1)]
        [Scriptblock]
        $Scriptblock
    )
    Assert-DescribeInProgress -CommandName BeforeEach

    New-EachTestSetup -ScriptBlock $Scriptblock
}

function AfterEach {
    <#
    .SYNOPSIS
        Defines a series of steps to perform at the end of every It block within
        the current Context or Describe block.

    .DESCRIPTION
        AfterEach runs once after every test in the current or any child blocks.
        Typically this is used to clean up resources created by the test or its setups.
        AfterEach runs in a finally block, and is guaranteed to run even if the test
        (or setup) fails.

        BeforeEach and AfterEach are unique in that they apply to the entire Context
        or Describe block, regardless of the order of the statements in the
        Context or Describe.

    .PARAMETER ScriptBlock
        A scriptblock with steps to be executed during teardown.

    .EXAMPLE
        ```powershell
        Describe "Testing export formats" {
            BeforeAll {
                $filePath = "$([IO.Path]::GetTempPath())/$([Guid]::NewGuid())"
            }
            It "Test Export-CSV" {
                Get-ChildItem | Export-CSV -Path $filePath -NoTypeInformation
                $dir = Import-CSV -Path $filePath
                # ...
            }
            It "Test Export-Clixml" {
                Get-ChildItem | Export-Clixml -Path $filePath
                $dir = Import-Clixml -Path $filePath
                # ...
            }

            AfterEach {
                if (Test-Path $file) {
                    Remove-Item $file -Force
                }
            }
        }
        ```

        The example uses AfterEach to remove a temporary file after each test.

    .LINK
        https://pester.dev/docs/v5/commands/AfterEach

    .LINK
        https://pester.dev/docs/v5/usage/setup-and-teardown
    #>
    [CmdletBinding()]
    param
    (
        # the scriptblock to execute
        [Parameter(Mandatory = $true,
            Position = 1)]
        [Scriptblock]
        $Scriptblock
    )
    Assert-DescribeInProgress -CommandName AfterEach

    New-EachTestTeardown -ScriptBlock $Scriptblock
}

function BeforeAll {
    <#
    .SYNOPSIS
        Defines a series of steps to perform at the beginning of the current container,
        Context or Describe block.

    .DESCRIPTION
        BeforeAll is used to share setup among all the tests in a container, Describe
        or Context including all child blocks and tests. BeforeAll runs during Run phase
        and runs only once in the current level.

        The typical usage is to setup the whole test script, most commonly to
        import the tested function, by dot-sourcing the script file that contains it.

        BeforeAll and AfterAll are unique in that they apply to the entire container,
        Context or Describe block regardless of the order of the statements compared to
        other Context or Describe blocks at the same level.

    .PARAMETER ScriptBlock
        A scriptblock with steps to be executed during setup.

    .EXAMPLE
        ```powershell
        BeforeAll {
            . $PSCommandPath.Replace('.Tests.ps1','.ps1')
        }

        Describe "API validation" {
            # ...
        }
        ```

        This example uses dot-sourcing in BeforeAll to make functions in the script-file
        available for the tests.

    .EXAMPLE
        ```powershell
        Describe "API validation" {
            BeforeAll {
                # this calls REST API and takes roughly 1 second
                $response = Get-Pokemon -Name Pikachu
            }

            It "response has Name = 'Pikachu'" {
                $response.Name | Should -Be 'Pikachu'
            }

            It "response has Type = 'electric'" {
                $response.Type | Should -Be 'electric'
            }
        }
        ```

        This example uses BeforeAll to perform an expensive operation only once, before validating
        the results in separate tests.

    .LINK
        https://pester.dev/docs/v5/commands/BeforeAll

    .LINK
        https://pester.dev/docs/v5/usage/setup-and-teardown
    #>
    [CmdletBinding()]
    param
    (
        # the scriptblock to execute
        [Parameter(Mandatory = $true,
            Position = 1)]
        [Scriptblock]
        $Scriptblock
    )

    New-OneTimeTestSetup -ScriptBlock $Scriptblock
}

function AfterAll {
    <#
    .SYNOPSIS
        Defines a series of steps to perform at the end of the current container,
        Context or Describe block.

    .DESCRIPTION
        AfterAll is used to share teardown after all the tests in a container, Describe
        or Context including all child blocks and tests. AfterAll runs during Run phase
        and runs only once in the current block. It's guaranteed to run even if tests
        fail.

        The typical usage is to clean up state or temporary used in tests.

        BeforeAll and AfterAll are unique in that they apply to the entire container,
        Context or Describe block regardless of the order of the statements compared to
        other Context or Describe blocks at the same level.

    .PARAMETER ScriptBlock
        A scriptblock with steps to be executed during teardown.

    .EXAMPLE
        ```powershell
        Describe "Validate important file" {
            BeforeAll {
                $samplePath = "$([IO.Path]::GetTempPath())/$([Guid]::NewGuid()).txt"
                Write-Host $samplePath
                1..100 | Set-Content -Path $samplePath
            }

            It "File Contains 100 lines" {
                @(Get-Content $samplePath).Count | Should -Be 100
            }

            It "First ten lines should be 1 -> 10" {
                @(Get-Content $samplePath -TotalCount 10) | Should -Be @(1..10)
            }

            AfterAll {
                Remove-Item -Path $samplePath
            }
        }
        ```

        This example uses AfterAll to clean up a sample-file generated only for
        the tests in the Describe-block.

    .LINK
        https://pester.dev/docs/v5/commands/AfterAll

    .LINK
        https://pester.dev/docs/v5/usage/setup-and-teardown
#>
    [CmdletBinding()]
    param
    (
        # the scriptblock to execute
        [Parameter(Mandatory = $true,
            Position = 1)]
        [Scriptblock]
        $Scriptblock
    )
    Assert-DescribeInProgress -CommandName AfterAll

    New-OneTimeTestTeardown -ScriptBlock $Scriptblock
}
# file src\functions\TestDrive.ps1
function Get-TestDrivePlugin {
    $p = @{
        Name = 'TestDrive'
    }

    $p.Start = {
        param($Context)

        if (& $script:SafeCommands['Test-Path'] TestDrive:\) {
            $existingDrive = & $SafeCommands['Get-PSDrive'] TestDrive -ErrorAction Stop
            $existingDriveRoot = "$($existingDrive.Provider)::$($existingDrive.Root)"

            if ($runningPesterInPester) {
                # If nested run, store location and only remove PSDrive so we can re-attach it during End-step
                $Context.GlobalPluginData.TestDrive = @{
                    ExistingTestDrivePath = $existingDriveRoot
                }
            }
            else {
                & $SafeCommands['Remove-Item'] $existingDriveRoot -Force -Recurse -Confirm:$false
            }
            & $SafeCommands['Remove-PSDrive'] TestDrive
        }
    }

    $p.EachBlockSetupStart = {
        param($Context)

        if ($Context.Block.IsRoot) {
            # this is top-level block setup test drive
            $path = New-TestDrive
            $Context.Block.PluginData.Add('TestDrive', @{
                    TestDriveAdded   = $true
                    TestDriveContent = $null
                    TestDrivePath    = $path
                })
        }
        else {
            $testDrivePath = $Context.Block.Parent.PluginData.TestDrive.TestDrivePath
            $Context.Block.PluginData.Add('TestDrive', @{
                    TestDriveAdded   = $false
                    TestDriveContent = Get-TestDriveChildItem -TestDrivePath $testDrivePath
                    TestDrivePath    = $testDrivePath
                })
        }
    }

    $p.EachBlockTearDownEnd = {
        param($Context)

        # Remap drive and variable if missing/wrong? Ex. if nested run was cancelled and didn't re-attach this drive
        if (-not (& $script:SafeCommands['Test-Path'] TestDrive:\)) {
            New-TestDrive -Path $Context.Block.PluginData.TestDrive.TestDrivePath
        }

        if ($Context.Block.IsRoot) {
            # this is top-level block remove test drive
            Remove-TestDrive -TestDrivePath $Context.Block.PluginData.TestDrive.TestDrivePath
        }
        else {
            Clear-TestDrive -TestDrivePath $Context.Block.PluginData.TestDrive.TestDrivePath -Exclude ($Context.Block.PluginData.TestDrive.TestDriveContent)
        }
    }

    $p.End = {
        param($Context)

        if ($Context.GlobalPluginData.TestDrive.ExistingTestDrivePath) {
            # If nested run, reattach previous TestDrive PSDrive and variable
            New-TestDrive -Path $Context.GlobalPluginData.TestDrive.ExistingTestDrivePath
        }
    }

    New-PluginObject @p
}

function New-TestDrive {
    param(
        [string] $Path
    )

    if ($Path -notmatch '\S') {
        $directory = New-RandomTempDirectory
    }
    else {
        # We have a path, so probably a remap after losing the PSDrive (ex. cancelled nested Pester run)
        if (-not (& $SafeCommands['Test-Path'] -Path $Path)) {
            # If this runs, something deleted the container-specific folder, so we create a new folder
            $null = & $SafeCommands['New-Item'] -Path $Path -ItemType Directory -ErrorAction Stop
        }

        $directory = & $SafeCommands['Get-Item'] $Path
    }

    $DriveName = 'TestDrive'
    $null = & $SafeCommands['New-PSDrive'] -Name $DriveName -PSProvider FileSystem -Root $directory -Scope Global -Description 'Pester test drive'

    # publish the global TestDrive variable used in few places within the module.
    # using Set-Variable to support new variable + override existing (remap)
    & $SafeCommands['Set-Variable'] -Name $DriveName -Scope Global -Value $directory

    $directory
}


function Clear-TestDrive {
    param(
        [String[]] $Exclude,
        [string] $TestDrivePath
    )
    if ([IO.Directory]::Exists($TestDrivePath)) {

        Remove-TestDriveSymbolicLinks -Path $TestDrivePath

        foreach ($i in [IO.Directory]::GetFileSystemEntries($TestDrivePath, '*.*', [System.IO.SearchOption]::AllDirectories)) {
            if ($Exclude -contains $i) {
                continue
            }

            & $SafeCommands['Remove-Item'] -Force -Recurse $i -ErrorAction Ignore
        }
    }
}

function New-RandomTempDirectory {
    do {
        $tempPath = Get-TempDirectory
        $Path = [IO.Path]::Combine($tempPath, ([Guid]::NewGuid()));
    } until (-not [IO.Directory]::Exists($Path))

    [IO.Directory]::CreateDirectory($Path).FullName
}

function Get-TestDriveChildItem ($TestDrivePath) {
    if ([IO.Directory]::Exists($TestDrivePath)) {
        [IO.Directory]::GetFileSystemEntries($TestDrivePath, '*.*', [System.IO.SearchOption]::AllDirectories)
    }
}

function Remove-TestDriveSymbolicLinks ([String] $Path) {

    # remove symbolic links to work around problem with Remove-Item.
    # see https://github.com/PowerShell/PowerShell/issues/621
    #     https://github.com/pester/Pester/issues/1100

    # powershell 5 and higher
    # & $SafeCommands["Get-ChildItem"] -Recurse -Path $Path -Attributes "ReparsePoint" |
    #    % { $_.Delete() }

    # issue 621 was fixed before PowerShell 6.1
    # now there is an issue with calling the Delete method in recent (6.1) builds of PowerShell
    if ((GetPesterPSVersion) -ge 6) {
        return
    }

    # powershell 2-compatible
    $reparsePoint = [System.IO.FileAttributes]::ReparsePoint
    & $SafeCommands['Get-ChildItem'] -Recurse -Path $Path |
        & $SafeCommands['Where-Object'] { ($_.Attributes -band $reparsePoint) -eq $reparsePoint } |
        & $SafeCommands['Foreach-Object'] { $_.Delete() }
}

function Remove-TestDrive ($TestDrivePath) {
    $DriveName = 'TestDrive'
    $Drive = & $SafeCommands['Get-PSDrive'] -Name $DriveName -ErrorAction Ignore
    $Path = ($Drive).Root

    if ($pwd -like "$DriveName*") {
        #will staying in the test drive cause issues?
        #TODO: review this
        & $SafeCommands['Write-Warning'] -Message "Your current path is set to ${pwd}:. You should leave ${DriveName}:\ before leaving Describe."
    }

    if ($Drive) {
        $Drive | & $SafeCommands['Remove-PSDrive'] -Force #This should fail explicitly as it impacts future pester runs
    }

    if (($null -ne $Path) -and ([IO.Directory]::Exists($Path))) {
        Remove-TestDriveSymbolicLinks -Path $Path
        [IO.Directory]::Delete($path, $true)
    }

    if (& $SafeCommands['Get-Variable'] -Name $DriveName -Scope Global -ErrorAction Ignore) {
        & $SafeCommands['Remove-Variable'] -Scope Global -Name $DriveName -Force
    }
}
# file src\functions\TestRegistry.ps1
function New-TestRegistry {
    param(
        [string] $Path
    )

    if ($Path -notmatch '\S') {
        $key = New-RandomTempRegistry
    }
    else {
        if (-not (& $SafeCommands['Test-Path'] -Path $Path)) {
            # We have a path (typically remapping), so we expect Pester root key (HKCU:\Software\Pester) to exist
            # If this runs, something deleted the container-specific key, so we create a new.
            $null = & $SafeCommands['New-Item'] -Path $Path
        }

        $key = & $SafeCommands['Get-Item'] $Path
    }

    $DriveName = 'TestRegistry'
    if (-not (& $SafeCommands['Test-Path'] "${DriveName}:\")) {
        try {
            $null = & $SafeCommands['New-PSDrive'] -Name $DriveName -PSProvider Registry -Root $key -Scope Global -Description 'Pester test registry' -ErrorAction Stop
        }
        catch {
            if ($_.FullyQualifiedErrorId -like 'DriveAlreadyExists*') {
                # it can happen that Test-Path reports false even though the drive
                # exists. I don't know why but I see it in "Context Teardown fails"
                # it would be possible to use Get-PsDrive directly for the test but it
                # is about 10ms slower and we do it in every Describe and It so it would
                # quickly add up

                # so if that happens just ignore the error, the goal of this function is to
                # create the testdrive and the testdrive already exists, so all is good.
            }
            else {
                & $SafeCommands['Write-Error'] $_ -ErrorAction 'Stop'
            }
        }
    }

    $key.PSPath
}

function Clear-TestRegistry {
    param(
        [String[]] $Exclude,
        [string] $TestRegistryPath
    )

    # if the setup fails before we mark test registry added
    # we would be trying to teardown something that does not
    # exist and fail in Get-TestRegistryPath
    if (-not (& $SafeCommands['Test-Path'] 'TestRegistry:\')) {
        return
    }

    $path = $TestRegistryPath

    if ($null -ne $path -and (& $SafeCommands['Test-Path'] -Path $Path)) {
        #Get-ChildItem -Exclude did not seem to work with full paths
        & $SafeCommands['Get-ChildItem'] -Recurse -Path $Path |
            & $SafeCommands['Sort-Object'] -Descending -Property 'PSPath' |
            & $SafeCommands['Where-Object'] { $Exclude -NotContains $_.PSPath } |
            & $SafeCommands['Remove-Item'] -Force -Recurse
    }
}

function Get-TestRegistryChildItem ([string]$TestRegistryPath) {
    & $SafeCommands['Get-ChildItem'] -Recurse -Path $TestRegistryPath |
        & $SafeCommands['Select-Object'] -ExpandProperty PSPath
}

function New-RandomTempRegistry {
    do {
        $tempPath = Get-TempRegistry
        $Path = & $SafeCommands['Join-Path'] -Path $tempPath -ChildPath ([Guid]::NewGuid())
    } until (-not (& $SafeCommands['Test-Path'] -Path $Path -PathType Container))

    try {
        try {
            & $SafeCommands['New-Item'] -Path $Path -ErrorAction Stop
        }
        catch [System.IO.IOException] {
            # when running in parallel this occasionally triggers
            # IOException: No more data is available
            # let's just retry the operation
            & $SafeCommands['Write-Warning'] "IO exception during creating path $path"
            & $SafeCommands['New-Item'] -Path $Path -ErrorAction Stop
        }
    }
    catch [Exception] {
        throw ([Exception]"Was not able to registry key for TestRegistry at '$Path'", ($_.Exception))
    }
}

function Remove-TestRegistry ($TestRegistryPath) {
    $DriveName = 'TestRegistry'
    $Drive = & $SafeCommands['Get-PSDrive'] -Name $DriveName -ErrorAction Ignore
    if ($null -eq $Drive) {
        # the drive does not exist, someone must have removed it instead of us,
        # most likely a test that tests pester itself, so we just hope that the
        # one who removed this removed also the contents of it correctly
        return
    }

    $path = $TestRegistryPath

    if ($pwd -like "$DriveName*") {
        #will staying in the test drive cause issues?
        #TODO: review this
        & $SafeCommands['Write-Warning'] -Message "Your current path is set to ${pwd}:. You should leave ${DriveName}:\ before leaving Describe."
    }

    if ($Drive) {
        $Drive | & $SafeCommands['Remove-PSDrive'] -Force   #This should fail explicitly as it impacts future pester runs
    }

    if (& $SafeCommands['Test-Path'] -Path $path -PathType Container) {
        & $SafeCommands['Remove-Item'] -Path $path -Force -Recurse
    }
}


function Get-TestRegistryPlugin {
    $p = @{
        Name = 'TestRegistry'
    }

    $p.Start = {
        param($Context)

        if (& $script:SafeCommands['Test-Path'] TestRegistry:\) {
            $existingDrive = & $SafeCommands['Get-PSDrive'] TestRegistry -ErrorAction Stop
            $existingDriveRoot = "$($existingDrive.Provider)::$($existingDrive.Root)"

            if ($runningPesterInPester) {
                # If nested run, store location and only remove PSDrive so we can re-attach it during End-step
                $Context.GlobalPluginData.TestRegistry = @{
                    ExistingTestRegistryPath = $existingDriveRoot
                }
            }
            else {
                & $SafeCommands['Remove-Item'] $existingDriveRoot -Force -Recurse -Confirm:$false -ErrorAction Ignore
            }

            & $SafeCommands['Remove-PSDrive'] TestRegistry
        }
    }

    $p.EachBlockSetupStart = {
        param($Context)

        if ($Context.Block.IsRoot) {
            # this is top-level block setup test drive
            $path = New-TestRegistry
            $Context.Block.PluginData.Add('TestRegistry', @{
                    TestRegistryAdded   = $true
                    TestRegistryContent = $null
                    TestRegistryPath    = $path
                })
        }
        else {
            $testRegistryPath = $Context.Block.Parent.PluginData.TestRegistry.TestRegistryPath
            $Context.Block.PluginData.Add('TestRegistry', @{
                    TestRegistryAdded   = $false
                    TestRegistryContent = Get-TestRegistryChildItem -TestRegistryPath $testRegistryPath
                    TestRegistryPath    = $testRegistryPath
                })
        }
    }

    $p.EachBlockTearDownEnd = {
        param($Context)

        # Remap drive if missing/wrong? Ex. if nested run was cancelled and didn't re-attach this drive
        if (-not (& $script:SafeCommands['Test-Path'] TestRegistry:\)) {
            New-TestRegistry -Path $Context.Block.PluginData.TestRegistry.TestRegistryPath
        }

        if ($Context.Block.IsRoot) {
            # this is top-level block remove test drive
            Remove-TestRegistry -TestRegistryPath $Context.Block.PluginData.TestRegistry.TestRegistryPath
        }
        else {
            Clear-TestRegistry -TestRegistryPath $Context.Block.PluginData.TestRegistry.TestRegistryPath -Exclude ($Context.Block.PluginData.TestRegistry.TestRegistryContent)
        }
    }

    $p.End = {
        param($Context)

        if ($Context.GlobalPluginData.TestRegistry.ExistingTestRegistryPath) {
            # If nested run, reattach previous TestRegistry PSDrive
            New-TestRegistry -Path $Context.GlobalPluginData.TestRegistry.ExistingTestRegistryPath
        }
    }

    New-PluginObject @p
}
# file src\functions\TestResults.JUnit4.ps1
function Write-JUnitReport {
    param([Pester.Run] $Result, [System.Xml.XmlWriter] $XmlWriter)
    # Write the XML Declaration
    $XmlWriter.WriteStartDocument($false)

    # Write Root Element
    $xmlWriter.WriteStartElement('testsuites')

    Write-JUnitTestResultAttributes @PSBoundParameters

    $testSuiteNumber = 0
    foreach ($container in $Result.Containers) {
        if (-not $container.ShouldRun) {
            # skip containers that were discovered but none of their tests run
            continue
        }

        Write-JUnitTestSuiteElements -XmlWriter $XmlWriter -Container $container -Id $testSuiteNumber
        $testSuiteNumber++
    }

    $XmlWriter.WriteEndElement()
}

function Write-JUnitTestResultAttributes {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseSingularNouns','')]
    param([Pester.Run] $Result, [System.Xml.XmlWriter] $XmlWriter)

    $XmlWriter.WriteAttributeString('xmlns', 'xsi', $null, 'http://www.w3.org/2001/XMLSchema-instance')
    $XmlWriter.WriteAttributeString('xsi', 'noNamespaceSchemaLocation', [Xml.Schema.XmlSchema]::InstanceNamespace , 'junit_schema_4.xsd')
    $XmlWriter.WriteAttributeString('name', $Result.Configuration.TestResult.TestSuiteName.Value)
    $XmlWriter.WriteAttributeString('tests', $Result.TotalCount)
    $XmlWriter.WriteAttributeString('errors', $Result.FailedContainersCount + $Result.FailedBlocksCount)
    $XmlWriter.WriteAttributeString('failures', $Result.FailedCount)
    $XmlWriter.WriteAttributeString('disabled', $Result.NotRunCount + $Result.SkippedCount)
    $XmlWriter.WriteAttributeString('time', ($Result.Duration.TotalSeconds.ToString('0.000', [System.Globalization.CultureInfo]::InvariantCulture)))
}

function Write-JUnitTestSuiteElements {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseSingularNouns','')]
    param([Pester.Container] $Container, [System.Xml.XmlWriter] $XmlWriter, [uint16] $Id)

    $XmlWriter.WriteStartElement('testsuite')

    Write-JUnitTestSuiteAttributes -Action $Container -XmlWriter $XmlWriter -Package $container.Name -Id $Id

    $testResults = [Pester.Factory]::CreateCollection()
    Fold-Container -Container $Container -OnTest { param ($t) if ($t.ShouldRun) { $testResults.Add($t) } }
    foreach ($t in $testResults) {
        Write-JUnitTestCaseElements -TestResult $t -XmlWriter $XmlWriter -Package $container.Name
    }

    $XmlWriter.WriteEndElement()
}

function Write-JUnitTestSuiteAttributes {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseSingularNouns','')]
    param($Action, [System.Xml.XmlWriter] $XmlWriter, [string] $Package, [uint16] $Id)

    $environment = Get-RunTimeEnvironment

    $XmlWriter.WriteAttributeString('name', $Package)
    $XmlWriter.WriteAttributeString('tests', $Action.TotalCount)
    $XmlWriter.WriteAttributeString('errors', '0')
    $XmlWriter.WriteAttributeString('failures', $Action.FailedCount)
    $XmlWriter.WriteAttributeString('hostname', $environment.'machine-name')
    $XmlWriter.WriteAttributeString('id', $Id)
    $XmlWriter.WriteAttributeString('skipped', $Action.SkippedCount)
    $XmlWriter.WriteAttributeString('disabled', $Action.NotRunCount)
    $XmlWriter.WriteAttributeString('package', $Package)
    $XmlWriter.WriteAttributeString('time', $Action.Duration.TotalSeconds.ToString('0.000', [System.Globalization.CultureInfo]::InvariantCulture))

    $XmlWriter.WriteStartElement('properties')

    foreach ($keyValuePair in $environment.GetEnumerator()) {
        if ($keyValuePair.Name -eq 'nunit-version') {
            continue
        }

        $XmlWriter.WriteStartElement('property')
        $XmlWriter.WriteAttributeString('name', $keyValuePair.Name)
        $XmlWriter.WriteAttributeString('value', $keyValuePair.Value)
        $XmlWriter.WriteEndElement()
    }

    $XmlWriter.WriteEndElement()
}

function Write-JUnitTestCaseElements {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseSingularNouns','')]
    param($TestResult, [System.Xml.XmlWriter] $XmlWriter, [string] $Package)

    $XmlWriter.WriteStartElement('testcase')

    Write-JUnitTestCaseAttributes -TestResult $TestResult -XmlWriter $XmlWriter -ClassName $Package

    $XmlWriter.WriteEndElement()
}

function Write-JUnitTestCaseAttributes {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseSingularNouns','')]
    param($TestResult,[System.Xml.XmlWriter] $XmlWriter, [string] $ClassName)

    $XmlWriter.WriteAttributeString('name', $TestResult.ExpandedPath)

    $statusElementName = switch ($TestResult.Result) {
        Passed {
            $null
        }

        Failed {
            'failure'
        }

        default {
            'skipped'
        }
    }

    $XmlWriter.WriteAttributeString('status', $TestResult.Result)
    $XmlWriter.WriteAttributeString('classname', $ClassName)
    $XmlWriter.WriteAttributeString('assertions', '0')
    $XmlWriter.WriteAttributeString('time', $TestResult.Duration.TotalSeconds.ToString('0.000', [System.Globalization.CultureInfo]::InvariantCulture))

    if ($null -ne $statusElementName) {
        Write-JUnitTestCaseMessageElements -TestResult $TestResult -XmlWriter $XmlWriter -StatusElementName $statusElementName
    }
}

function Write-JUnitTestCaseMessageElements {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseSingularNouns','')]
    param($TestResult,[System.Xml.XmlWriter] $XmlWriter, [string] $StatusElementName)

    $XmlWriter.WriteStartElement($StatusElementName)

    $result = Get-ErrorForXmlReport -TestResult $TestResult
    $XmlWriter.WriteAttributeString('message', $result.FailureMessage)
    $XmlWriter.WriteString($result.StackTrace)

    $XmlWriter.WriteEndElement()
}
# file src\functions\TestResults.NUnit25.ps1
function Write-NUnitReport {
    param([Pester.Run] $Result, [System.Xml.XmlWriter] $XmlWriter)
    # Write the XML Declaration
    $XmlWriter.WriteStartDocument($false)

    # Write Root Element
    $xmlWriter.WriteStartElement('test-results')

    Write-NUnitTestResultAttributes @PSBoundParameters
    Write-NUnitTestResultChildNodes @PSBoundParameters

    $XmlWriter.WriteEndElement()
}

function Write-NUnitTestResultAttributes {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseSingularNouns', '')]
    param([Pester.Run] $Result, [System.Xml.XmlWriter] $XmlWriter)

    $XmlWriter.WriteAttributeString('xmlns', 'xsi', $null, 'http://www.w3.org/2001/XMLSchema-instance')
    $XmlWriter.WriteAttributeString('xsi', 'noNamespaceSchemaLocation', [Xml.Schema.XmlSchema]::InstanceNamespace , 'nunit_schema_2.5.xsd')
    $XmlWriter.WriteAttributeString('name', $Result.Configuration.TestResult.TestSuiteName.Value)
    $XmlWriter.WriteAttributeString('total', ($Result.TotalCount - $Result.NotRunCount))
    $XmlWriter.WriteAttributeString('errors', '0')
    $XmlWriter.WriteAttributeString('failures', $Result.FailedCount)
    $XmlWriter.WriteAttributeString('not-run', $Result.NotRunCount)
    $XmlWriter.WriteAttributeString('inconclusive', $Result.InconclusiveCount)
    $XmlWriter.WriteAttributeString('ignored', '0')
    $XmlWriter.WriteAttributeString('skipped', $Result.SkippedCount)
    $XmlWriter.WriteAttributeString('invalid', '0')
    $XmlWriter.WriteAttributeString('date', $Result.ExecutedAt.ToString('yyyy-MM-dd'))
    $XmlWriter.WriteAttributeString('time', $Result.ExecutedAt.ToString('HH:mm:ss'))
}

function Write-NUnitTestResultChildNodes {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseSingularNouns', '')]
    param([Pester.Run] $Result, [System.Xml.XmlWriter] $XmlWriter)

    Write-NUnitEnvironmentInformation -Result $Result -XmlWriter $XmlWriter
    Write-NUnitCultureInformation -Result $Result -XmlWriter $XmlWriter

    $suiteInfo = Get-TestSuiteInfo -TestSuite $Result -Path 'Pester'
    $suiteInfo.name = $Result.Configuration.TestResult.TestSuiteName.Value

    $XmlWriter.WriteStartElement('test-suite')

    Write-NUnitTestSuiteAttributes -TestSuiteInfo $suiteInfo -XmlWriter $XmlWriter

    $XmlWriter.WriteStartElement('results')

    foreach ($container in $Result.Containers) {
        if (-not $container.ShouldRun) {
            # skip containers that were discovered but none of their tests run
            continue
        }

        Write-NUnitTestSuiteElements -XmlWriter $XmlWriter -Node $container -Path $container.Name
    }

    $XmlWriter.WriteEndElement()
    $XmlWriter.WriteEndElement()
}

function Write-NUnitEnvironmentInformation {
    param([System.Xml.XmlWriter] $XmlWriter)

    $XmlWriter.WriteStartElement('environment')

    $environment = Get-RunTimeEnvironment
    foreach ($keyValuePair in $environment.GetEnumerator()) {
        if ($keyValuePair.Name -in 'junit-version', 'framework-version') {
            continue
        }

        $XmlWriter.WriteAttributeString($keyValuePair.Name, $keyValuePair.Value)
    }

    $XmlWriter.WriteEndElement()
}

function Write-NUnitCultureInformation {
    param([System.Xml.XmlWriter] $XmlWriter)

    $XmlWriter.WriteStartElement('culture-info')

    $XmlWriter.WriteAttributeString('current-culture', ([System.Threading.Thread]::CurrentThread.CurrentCulture).Name)
    $XmlWriter.WriteAttributeString('current-uiculture', ([System.Threading.Thread]::CurrentThread.CurrentUiCulture).Name)

    $XmlWriter.WriteEndElement()
}

function Write-NUnitTestSuiteElements {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseSingularNouns', '')]
    param($Node, [System.Xml.XmlWriter] $XmlWriter, [string] $Path)

    $suiteInfo = Get-TestSuiteInfo -TestSuite $Node -Path $Path

    $XmlWriter.WriteStartElement('test-suite')

    Write-NUnitTestSuiteAttributes -TestSuiteInfo $suiteInfo -XmlWriter $XmlWriter

    $XmlWriter.WriteStartElement('results')

    foreach ($action in $Node.Blocks) {
        if (-not $action.ShouldRun) {
            # skip blocks that were discovered but did not run
            continue
        }
        Write-NUnitTestSuiteElements -Node $action -XmlWriter $XmlWriter -Path $action.ExpandedPath
    }

    $suites = @(
        # Tests only have GroupId if parameterized. All other tests are put in group with '' value
        $Node.Tests | & $SafeCommands['Group-Object'] -Property GroupId
    )

    foreach ($suite in $suites) {
        # When group has name it is a parameterized tests (data-generated using -ForEach/TestCases) so we want extra level of nesting for them
        $testGroupId = $suite.Name
        if ($testGroupId) {
            $parameterizedSuiteInfo = Get-ParameterizedTestSuiteInfo -TestSuiteGroup $suite

            $XmlWriter.WriteStartElement('test-suite')

            Write-NUnitTestSuiteAttributes -TestSuiteInfo $parameterizedSuiteInfo -TestSuiteType 'ParameterizedTest' -XmlWriter $XmlWriter -Path $newPath

            $XmlWriter.WriteStartElement('results')
        }

        foreach ($testCase in $suite.Group) {
            if (-not $testCase.ShouldRun) {
                # skip tests that were discovered but did not run
                continue
            }

            $suiteName = if ($testGroupId) { $parameterizedSuiteInfo.Name } else { '' }
            Write-NUnitTestCaseElement -TestResult $testCase -XmlWriter $XmlWriter -Path ($testCase.Path -join '.') -ParameterizedSuiteName $suiteName
        }

        if ($testGroupId) {
            # close the extra nesting element when we were writing testcases
            $XmlWriter.WriteEndElement()
            $XmlWriter.WriteEndElement()
        }
    }

    $XmlWriter.WriteEndElement()
    $XmlWriter.WriteEndElement()
}

function Get-ParameterizedTestSuiteInfo {
    param([Microsoft.PowerShell.Commands.GroupInfo] $TestSuiteGroup)
    # this is generating info for a group of tests that were generated from the same test when TestCases are used
    # Using the Name from the first test as the name of the test group to make it readable,
    # even though we are grouping using GroupId of the tests.
    $node = [PSCustomObject] @{
        Path              = $TestSuiteGroup.Group[0].Path
        TotalCount        = 0
        Duration          = [timespan]0
        PassedCount       = 0
        FailedCount       = 0
        SkippedCount      = 0
        PendingCount      = 0
        InconclusiveCount = 0
    }

    foreach ($testCase in $TestSuiteGroup.Group) {
        $node.TotalCount++
        switch ($testCase.Result) {
            Passed {
                $node.PassedCount++; break;
            }
            Failed {
                $node.FailedCount++; break;
            }
            Skipped {
                $node.SkippedCount++; break;
            }
            Pending {
                $node.PendingCount++; break;
            }
            Inconclusive {
                $node.InconclusiveCount++; break;
            }
        }

        $node.Duration += $testCase.Duration
    }

    return Get-TestSuiteInfo -TestSuite $node -Path $node.Path
}

function Get-TestSuiteInfo {
    param($TestSuite, $Path)
    # if (-not $Path) {
    #     $Path = $TestSuite.Name
    # }

    # if (-not $Path) {
    #     $pathProperty = $TestSuite.PSObject.Properties.Item("path")
    #     if ($pathProperty) {
    #         $path = $pathProperty.Value
    #         if ($path -is [System.IO.FileInfo]) {
    #             $Path = $path.FullName
    #         }
    #         else {
    #             $Path = $pathProperty.Value -join "."
    #         }
    #     }
    # }

    $time = $TestSuite.Duration

    if (1 -lt @($Path).Count) {
        $name = $Path -join '.'
        $description = $Path[-1]
    }
    else {
        $name = $Path
        $description = $Path
    }

    $suite = @{
        resultMessage = 'Failure'
        success       = if ($TestSuite.FailedCount -eq 0) {
            'True'
        }
        else {
            'False'
        }
        totalTime     = Convert-TimeSpan $time
        name          = $name
        description   = $description
    }

    $suite.resultMessage = Get-GroupResult $TestSuite
    $suite
}

function Write-NUnitTestSuiteAttributes {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseSingularNouns', '')]
    param($TestSuiteInfo, [string] $TestSuiteType = 'TestFixture', [System.Xml.XmlWriter] $XmlWriter, [string] $Path)

    $name = $TestSuiteInfo.Name

    if ($TestSuiteType -eq 'ParameterizedTest' -and $Path) {
        $name = "$Path.$name"
    }

    $XmlWriter.WriteAttributeString('type', $TestSuiteType)
    $XmlWriter.WriteAttributeString('name', $name)
    $XmlWriter.WriteAttributeString('executed', 'True')
    $XmlWriter.WriteAttributeString('result', $TestSuiteInfo.resultMessage)
    $XmlWriter.WriteAttributeString('success', $TestSuiteInfo.success)
    $XmlWriter.WriteAttributeString('time', $TestSuiteInfo.totalTime)
    $XmlWriter.WriteAttributeString('asserts', '0')
    $XmlWriter.WriteAttributeString('description', $TestSuiteInfo.Description)
}

function Write-NUnitTestCaseElement {
    param($TestResult, [System.Xml.XmlWriter] $XmlWriter, [string] $ParameterizedSuiteName)

    $XmlWriter.WriteStartElement('test-case')

    Write-NUnitTestCaseAttributes -TestResult $TestResult -XmlWriter $XmlWriter -ParameterizedSuiteName $ParameterizedSuiteName

    $XmlWriter.WriteEndElement()
}

function Write-NUnitTestCaseAttributes {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseSingularNouns', '')]
    param($TestResult, [System.Xml.XmlWriter] $XmlWriter, [string] $ParameterizedSuiteName)

    $testName = $TestResult.ExpandedPath

    # todo: this comparison would fail if the test name would contain $(Get-Date) or something similar that changes all the time
    if ($testName -eq $ParameterizedSuiteName) {
        $paramString = ''
        if ($null -ne $TestResult.Data) {
            $paramsUsedInTestName = $false

            if (-not $paramsUsedInTestName) {
                $params = @(
                    foreach ($value in $TestResult.Data.Values) {
                        if ($null -eq $value) {
                            'null'
                        }
                        elseif ($value -is [string]) {
                            '"{0}"' -f $value
                        }
                        else {
                            #do not use .ToString() it uses the current culture settings
                            #and we need to use en-US culture, which [string] or .ToString([Globalization.CultureInfo]'en-us') uses
                            [string]$value
                        }
                    }
                )

                $paramString = "($($params -join ','))"
                $testName = "$testName$paramString"
            }
        }
    }

    $XmlWriter.WriteAttributeString('description', $TestResult.ExpandedName)

    $XmlWriter.WriteAttributeString('name', $testName)
    $XmlWriter.WriteAttributeString('time', (Convert-TimeSpan $TestResult.Duration))
    $XmlWriter.WriteAttributeString('asserts', '0')
    $XmlWriter.WriteAttributeString('success', 'Passed' -eq $TestResult.Result)

    switch ($TestResult.Result) {
        Passed {
            $XmlWriter.WriteAttributeString('result', 'Success')
            $XmlWriter.WriteAttributeString('executed', 'True')

            break
        }

        Skipped {
            $XmlWriter.WriteAttributeString('result', 'Ignored')
            $XmlWriter.WriteAttributeString('executed', 'False')

            # TODO: This doesn't work, FailureMessage comes from Get-ErrorForXmlReport which isn't called
            if ($TestResult.FailureMessage) {
                $XmlWriter.WriteStartElement('reason')
                $xmlWriter.WriteElementString('message', $TestResult.FailureMessage)
                $XmlWriter.WriteEndElement() # Close reason tag
            }

            break
        }

        Pending {
            $XmlWriter.WriteAttributeString('result', 'Inconclusive')
            $XmlWriter.WriteAttributeString('executed', 'True')

            # TODO: This doesn't work, FailureMessage comes from Get-ErrorForXmlReport which isn't called
            if ($TestResult.FailureMessage) {
                $XmlWriter.WriteStartElement('reason')
                $xmlWriter.WriteElementString('message', $TestResult.FailureMessage)
                $XmlWriter.WriteEndElement() # Close reason tag
            }

            break
        }

        Inconclusive {
            $XmlWriter.WriteAttributeString('result', 'Inconclusive')
            $XmlWriter.WriteAttributeString('executed', 'True')

            # TODO: This doesn't work, FailureMessage comes from Get-ErrorForXmlReport which isn't called
            if ($TestResult.FailureMessage) {
                $XmlWriter.WriteStartElement('reason')
                $xmlWriter.WriteElementString('message', $TestResult.DisplayErrorMessage)
                $XmlWriter.WriteEndElement() # Close reason tag
            }

            break
        }
        Failed {
            $XmlWriter.WriteAttributeString('result', 'Failure')
            $XmlWriter.WriteAttributeString('executed', 'True')
            $XmlWriter.WriteStartElement('failure')

            # TODO: remove monkey patching the error message when parent setup failed so this test never run
            # TODO: do not format the errors here, instead format them in the core using some unified function so we get the same thing on the screen and in nunit

            $result = Get-ErrorForXmlReport -TestResult $TestResult

            $xmlWriter.WriteElementString('message', $result.FailureMessage)
            $XmlWriter.WriteElementString('stack-trace', $result.StackTrace)
            $XmlWriter.WriteEndElement() # Close failure tag
            break
        }
    }
}

function Get-GroupResult ($InputObject) {
    #I am not sure about the result precedence, and can't find any good source
    #TODO: Confirm this is the correct order of precedence
    if ($inputObject.FailedCount -gt 0) {
        return 'Failure'
    }
    if ($InputObject.SkippedCount -gt 0) {
        return 'Ignored'
    }
    if ($InputObject.PendingCount -gt 0) {
        return 'Inconclusive'
    }
    if ($InputObject.InconclusiveCount -gt 0) {
        return 'Inconclusive'
    }
    return 'Success'
}
# file src\functions\TestResults.NUnit3.ps1
# NUnit3 schema docs: https://docs.nunit.org/articles/nunit/technical-notes/usage/Test-Result-XML-Format.html

[char[]] $script:invalidCDataChars = foreach ($ch in (0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x0B, 0x0C, 0x0E, 0x0F, 0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x1A, 0x1B, 0x1C, 0x1D, 0x1E, 0x1F)) { [char]$ch }

function Write-NUnit3Report([Pester.Run] $Result, [System.Xml.XmlWriter] $XmlWriter) {
    # Write the XML Declaration
    $XmlWriter.WriteStartDocument($false)

    # Write Root Element
    $xmlWriter.WriteStartElement('test-run')

    Write-NUnit3TestRunAttributes @PSBoundParameters

    # Write Filter Element (required)
    $xmlWriter.WriteStartElement('filter')
    $XmlWriter.WriteEndElement()

    Write-NUnit3TestRunChildNode @PSBoundParameters

    $XmlWriter.WriteEndElement()
}

function Write-NUnit3TestRunAttributes {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseSingularNouns', '')]
    param([Pester.Run] $Result, [System.Xml.XmlWriter] $XmlWriter)

    $XmlWriter.WriteAttributeString('id', '0')
    $XmlWriter.WriteAttributeString('name', $Result.Configuration.TestResult.TestSuiteName.Value) # required attr. in schema, but not in docs or nunit-console output...
    $XmlWriter.WriteAttributeString('fullname', $Result.Configuration.TestResult.TestSuiteName.Value) # required attr. in schema, but not in docs or nunit-console output...
    $XmlWriter.WriteAttributeString('testcasecount', ($Result.TotalCount - $Result.NotRunCount)) # all testcases in run (before filtering). would've been totalcount if we listed shouldrun=false
    $XmlWriter.WriteAttributeString('result', (Get-NUnit3Result $Result)) # Summary of run. May be Passed, Failed, Inconclusive or Skipped.
    $XmlWriter.WriteAttributeString('total', ($Result.TotalCount - $Result.NotRunCount)) # testcasecount - filtered
    $XmlWriter.WriteAttributeString('passed', $Result.PassedCount)
    $XmlWriter.WriteAttributeString('failed', $Result.FailedCount)
    $XmlWriter.WriteAttributeString('inconclusive', $Result.InconclusiveCount)
    $XmlWriter.WriteAttributeString('skipped', $Result.SkippedCount)
    $XmlWriter.WriteAttributeString('warnings', '0') # required attr.
    $XmlWriter.WriteAttributeString('start-time', (Get-UTCTimeString $Result.ExecutedAt))
    $XmlWriter.WriteAttributeString('end-time', (Get-UTCTimeString ($Result.ExecutedAt + $Result.Duration)))
    $XmlWriter.WriteAttributeString('duration', (Convert-TimeSpan $Result.Duration))
    $XmlWriter.WriteAttributeString('asserts', ($Result.TotalCount - $Result.NotRunCount)) # required attr. assuming 1:1 per testcase
    $XmlWriter.WriteAttributeString('random-seed', (Get-Random)) # required attr. in schema, but not in docs or nunit-console output...
}

function Write-NUnit3TestRunChildNode {
    param(
        [Pester.Run] $Result,
        [System.Xml.XmlWriter] $XmlWriter
    )

    # Used by Get-NUnit3NodeId
    $reportIds = @{ Assembly = 0; Node = 1000 }
    # Caching this to avoid call per assembly-suite (container). It uses external commands, CIM/WMI etc. which could be slow.
    $RuntimeEnvironment = Get-RunTimeEnvironment

    foreach ($container in $Result.Containers) {
        if (-not $container.ShouldRun) {
            # skip containers that were discovered but none of their tests run
            continue
        }

        # Incremenet assembly-id per container and reset node-counter
        $reportIds.Assembly++
        $reportIds.Node = 1000
        Write-NUnit3TestSuiteElement -XmlWriter $XmlWriter -Node $container -RuntimeEnvironment $RuntimeEnvironment
    }
}

function Write-NUnit3EnvironmentInformation {
    param(
        [System.Xml.XmlWriter] $XmlWriter,
        [System.Collections.IDictionary] $Environment = (Get-RunTimeEnvironment)
    )

    $XmlWriter.WriteStartElement('environment')

    foreach ($keyValuePair in $Environment.GetEnumerator()) {
        if ($keyValuePair.Name -in 'junit-version', 'nunit-version') {
            continue
        }

        $XmlWriter.WriteAttributeString($keyValuePair.Name, $keyValuePair.Value)
    }

    $XmlWriter.WriteAttributeString('culture', ([System.Threading.Thread]::CurrentThread.CurrentCulture).Name)
    $XmlWriter.WriteAttributeString('uiculture', ([System.Threading.Thread]::CurrentThread.CurrentUiCulture).Name)

    # Not in Get-RunTimeEnvironment because NUnit3 doesn't use amd64 and we shouldn't limit the common function
    $osArch = if ([System.Environment]::Is64BitOperatingSystem) { 'x64' } else { 'x86' }
    $XmlWriter.WriteAttributeString('os-architecture', $osArch)

    $XmlWriter.WriteEndElement()
}

function Write-NUnit3TestSuiteElement {
    param(
        $Node,
        [System.Xml.XmlWriter] $XmlWriter,
        [string] $ParentPath,
        [System.Collections.IDictionary] $RuntimeEnvironment
    )

    $XmlWriter.WriteStartElement('test-suite')
    $suiteInfo = Get-NUnit3TestSuiteInfo -TestSuite $Node -ParentPath $ParentPath

    if ($Node -is [Pester.Container]) {
        $CurrentPath = $null # child suites shouldn't use assembly-name in path
        Write-NUnit3TestSuiteAttributes -TestSuiteInfo $suiteInfo -XmlWriter $XmlWriter
        Write-NUnit3EnvironmentInformation -XmlWriter $XmlWriter -Environment $RuntimeEnvironment
    }
    else {
        $CurrentPath = $suiteInfo.fullname
        Write-NUnit3TestSuiteAttributes -TestSuiteInfo $suiteInfo -XmlWriter $XmlWriter

        $hasData = $Node.Data -is [System.Collections.IDictionary] -and $Node.Data.Keys.Count -gt 0
        if ($Node.FrameworkData -or $Node.Tag -or $hasData) {
            $XmlWriter.WriteStartElement('properties')
            if ($Node.FrameworkData) {
                # Only available when testresults are generated as part of Invoke-Pester
                $XmlWriter.WriteStartElement('property')
                $XmlWriter.WriteAttributeString('name', '_TYPE')
                $XmlWriter.WriteAttributeString('value', $Node.FrameworkData.CommandUsed)
                $XmlWriter.WriteEndElement() # Close property
            }
            if ($hasData) { Write-NUnit3DataProperty -Data $Node.Data -XmlWriter $XmlWriter }
            if ($Node.Tag) { Write-NUnit3CategoryProperty -Tag $Node.Tag -XmlWriter $XmlWriter }
            $XmlWriter.WriteEndElement() # Close properties
        }

        # likely a BeforeAll/AfterAll error
        if ($Node.ErrorRecord.Count -gt 0) { Write-NUnit3FailureElement -TestResult $Node -XmlWriter $XmlWriter }

        if ($Node.StandardOutput) { Write-NUnit3OutputElement -Output $Node.StandardOutput -XmlWriter $XmlWriter }
    }

    $blockGroups = @(
        # Blocks only have GroupId if parameterized (using -ForEach). All other blocks are put in group with '' value
        $Node.Blocks | & $SafeCommands['Group-Object'] -Property GroupId
    )

    foreach ($group in $blockGroups) {
        # When group has name it is a parameterized block (data-generated using -ForEach) so we want extra level of nesting for them
        $blockGroupId = $group.Name
        if ($blockGroupId) {
            if (@($group.Group.ShouldRun) -notcontains $true) {
                # no blocks executed, skip group to avoid creating empty ParameterizedFixture
                continue
            }

            $parameterizedSuiteInfo = Get-NUnit3ParameterizedFixtureSuiteInfo -TestSuiteGroup $group -ParentPath $CurrentPath
            $XmlWriter.WriteStartElement('test-suite')
            Write-NUnit3TestSuiteAttributes -TestSuiteInfo $parameterizedSuiteInfo -Type 'ParameterizedFixture' -XmlWriter $XmlWriter
            # Not adding tag/category on ParameterizedFixture, but on child TestSuite/TestFixture covered above. (NUnit3-console runner used as example)
        }

        foreach ($block in $group.Group) {
            if (-not $block.ShouldRun) {
                # skip blocks that were discovered but did not run
                continue
            }

            Write-NUnit3TestSuiteElement -Node $block -XmlWriter $XmlWriter -ParentPath $CurrentPath
        }

        if ($blockGroupId) {
            # close the extra nesting element (ParameterizedFixture) when we were writing data-generated blocks
            $XmlWriter.WriteEndElement()
        }
    }

    $testGroups = @(
        # Tests only have GroupId if parameterized. All other tests are put in group with '' value
        $Node.Tests | & $SafeCommands['Group-Object'] -Property GroupId
    )

    foreach ($group in $testGroups) {
        # When group has name it is a parameterized tests (data-generated using -ForEach/TestCases) so we want extra level of nesting for them
        $testGroupId = $group.Name
        if ($testGroupId) {
            if (@($group.Group.ShouldRun) -notcontains $true) {
                # no tests executed, skip group to avoid creating empty ParameterizedMethod
                continue
            }
            $parameterizedSuiteInfo = Get-NUnit3ParameterizedMethodSuiteInfo -TestSuiteGroup $group -ParentPath $CurrentPath

            $XmlWriter.WriteStartElement('test-suite')
            Write-NUnit3TestSuiteAttributes -TestSuiteInfo $parameterizedSuiteInfo -Type 'ParameterizedMethod' -XmlWriter $XmlWriter

            # Add to ParameterizedMethod, but not each test-case. (NUnit3-console runner used as example)
            if ($group.Group[0].Tag) {
                $XmlWriter.WriteStartElement('properties')
                Write-NUnit3CategoryProperty -Tag $group.Group[0].Tag -XmlWriter $XmlWriter
                $XmlWriter.WriteEndElement() # Close properties
            }
        }

        foreach ($testCase in $group.Group) {
            if (-not $testCase.ShouldRun) {
                # skip tests that were discovered but did not run
                continue
            }

            Write-NUnit3TestCaseElement -TestResult $testCase -XmlWriter $XmlWriter -ParentPath $CurrentPath
        }

        if ($testGroupId -and $parameterizedSuiteInfo.ShouldRun) {
            # close the extra nesting element (ParameterizedMethod) when we were writing testcases
            $XmlWriter.WriteEndElement()
        }
    }

    $XmlWriter.WriteEndElement()
}

function Get-NUnit3TestSuiteInfo {
    param($TestSuite, [string] $SuiteType, [string] $ParentPath)

    if (-not $SuiteType) {
        <# test-suite type-attribute mapping
         Assembly = Container
         TestSuite = Block without direct tests
         ParameterizedFixture = Parameterized block (wrapper) - Provided as parameter
         TestFixture = Block with tests
         ParameterizedMethod = Parameterized test (wrapper) - Provided as parameter
        #>

        $SuiteType = switch ($TestSuite) {
            { $TestSuite -is [Pester.Container] } { 'Assembly'; break }
            { $TestSuite.OwnTotalCount -gt 0 } { 'TestFixture'; break }
            default { 'TestSuite' }
        }
    }

    if ($TestSuite -is [Pester.Container]) {
        $name = switch ($TestSuite.Type) {
            'File' { $TestSuite.Item.Name; break }
            'ScriptBlock' { $TestSuite.Item.Id.Guid; break }
            default { throw "Container type '$($TestSuite.Type)' is not supported." }
        }
        $fullname = $TestSuite.Name
        $classname = ''
    }
    else {
        # add parameters to name for block with data when not using variables in name
        if ($TestSuite -is [Pester.Block] -and $TestSuite.Data -and ($TestSuite.Name -eq $TestSuite.ExpandedName)) {
            $paramString = Get-NUnit3ParamString -Node $TestSuite
            $name = "$($TestSuite.Name)$paramString"
        }
        else {
            $name = $TestSuite.ExpandedName
        }

        $fullname = if ($ParentPath) { "$($ParentPath).$name" } else { $name }
        $classname = $TestSuite.Path -join '.'
    }

    $runstate = if ($TestSuite -isnot [Pester.Run] -and $TestSuite.Skip) {
        'Ignored'
    }
    elseif ($TestSuite -isnot [Pester.Run] -and (-not $TestSuite.ShouldRun) -and $TestSuite.Result -eq 'Failed') {
        # Discovery failed - not runnable code
        'NotRunnable'
    }
    else {
        'Runnable'
    }

    $result = Get-NUnit3Result $TestSuite
    $site = if ($TestSuite -isnot [Pester.Run] -and $TestSuite.ShouldRun -and $result -in 'Failed', 'Skipped') {
        # If failed and not in test, decide if it was SetUp (BeforeAll), TearDown (AfterAll), Parent or Child
        Get-NUnit3Site
    }

    $suiteInfo = @{
        type          = $SuiteType
        name          = $name
        fullname      = $fullname
        classname     = $classname
        runstate      = $runstate
        result        = $result
        start         = (Get-UTCTimeString $TestSuite.ExecutedAt)
        end           = (Get-UTCTimeString ($TestSuite.ExecutedAt + $TestSuite.Duration))
        duration      = (Convert-TimeSpan $TestSuite.Duration)
        testcasecount = ($TestSuite.TotalCount - $TestSuite.NotRunCount) # would've been totalcount if we listed shouldrun=false
        total         = ($TestSuite.TotalCount - $TestSuite.NotRunCount)
        passed        = $TestSuite.PassedCount
        failed        = $TestSuite.FailedCount
        skipped       = $TestSuite.SkippedCount
        inconclusive  = $TestSuite.InconclusiveCount
        site          = $site
        shouldrun     = $TestSuite.ShouldRun
    }

    $suiteInfo
}

function Write-NUnit3TestSuiteAttributes {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseSingularNouns', '')]
    param($TestSuiteInfo, [System.Xml.XmlWriter] $XmlWriter)

    $XmlWriter.WriteAttributeString('type', $TestSuiteInfo.type)
    $XmlWriter.WriteAttributeString('id', (Get-NUnit3NodeId))
    $XmlWriter.WriteAttributeString('name', $TestSuiteInfo.name)
    $XmlWriter.WriteAttributeString('fullname', $TestSuiteInfo.fullname)
    if ($TestSuiteInfo.type -in 'TestFixture', 'ParameterizedMethod') {
        $XmlWriter.WriteAttributeString('classname', $TestSuiteInfo.classname)
    }
    $XmlWriter.WriteAttributeString('runstate', $TestSuiteInfo.runstate)
    $XmlWriter.WriteAttributeString('result', $TestSuiteInfo.result)
    if ($TestSuiteInfo.site) {
        $XmlWriter.WriteAttributeString('site', $TestSuiteInfo.site)
    }
    $XmlWriter.WriteAttributeString('start-time', $TestSuiteInfo.start)
    $XmlWriter.WriteAttributeString('end-time', $TestSuiteInfo.end)
    $XmlWriter.WriteAttributeString('duration', $TestSuiteInfo.duration)
    $XmlWriter.WriteAttributeString('testcasecount', $TestSuiteInfo.testcasecount)
    $XmlWriter.WriteAttributeString('total', $TestSuiteInfo.total)
    $XmlWriter.WriteAttributeString('passed', $TestSuiteInfo.passed)
    $XmlWriter.WriteAttributeString('failed', $TestSuiteInfo.failed)
    $XmlWriter.WriteAttributeString('inconclusive', $TestSuiteInfo.inconclusive) # required attribute
    $XmlWriter.WriteAttributeString('warnings', '0') # required attribute
    $XmlWriter.WriteAttributeString('skipped', $TestSuiteInfo.skipped)
    $XmlWriter.WriteAttributeString('asserts', $TestSuiteInfo.testcasecount) # required attr. hardcode  1:1 per testcase
}

function Get-NUnit3Result ($InputObject) {
    if ($InputObject.TotalCount -eq $InputObject.NotRunCount) {
        'Inconclusive'
    }
    # also checking result to cover setup/teardown errors
    elseif ($InputObject.Result -eq 'Failed' -or $InputObject.FailedCount -gt 0) {
        'Failed'
    }
    elseif ($InputObject.SkippedCount -gt 0) {
        'Skipped'
    }
    elseif ($InputObject.PassedCount -gt 0) {
        'Passed'
    }
    else {
        'Inconclusive'
    }
}

function Get-NUnit3Site ($Node) {
    $block = if ($TestSuite -is [Pester.Container] -and $TestSuite.Blocks.Count -gt 0) {
        $TestSuite.Blocks[0].Root
    }
    elseif ($TestSuite -is [Pester.Block]) {
        $TestSuite
    }
    else {
        # Empty container or ParameterizedMethod / ParameterizedFixture
        return
    }

    $site = switch ($block) {
        { $null -eq $_ } { break }
        { (-not $_.Passed) -and $_.OwnPassed } { 'Child'; break }
        { $_.ShouldRun -and (-not $_.Executed) } { 'Parent'; break }
        { -not $_.OwnPassed } {
            if (@($_.Order.ShouldRun) -contains $true -and @($_.Order.Executed) -notcontains $true) {
                'SetUp'
            }
            elseif (@($_.Order.ShouldRun) -contains $true) {
                'TearDown'
            }
            break
        }
    }

    return $site
}

function Get-NUnit3ParameterizedMethodSuiteInfo {
    param([Microsoft.PowerShell.Commands.GroupInfo] $TestSuiteGroup, [string] $ParentPath)
    # this is generating info for a group of tests that were generated from the same test when TestCases are used

    # Using the Name from the first test as the name of the test group to make it readable,
    # even though we are grouping using GroupId of the tests.

    $sampleTest = $TestSuiteGroup.Group[0]
    $node = [PSCustomObject] @{
        Name              = $sampleTest.Name
        ExpandedName      = $sampleTest.Name
        Path              = $sampleTest.Block.Path # used for classname -> block path
        Data              = $null
        TotalCount        = 0
        Duration          = [timespan]0
        ExecutedAt        = [datetime]::MinValue
        PassedCount       = 0
        FailedCount       = 0
        SkippedCount      = 0
        InconclusiveCount = 0
        NotRunCount       = 0
        OwnTotalCount     = 0
        ShouldRun         = $true
        Skip              = $sampleTest.Skip
    }

    foreach ($testCase in $TestSuiteGroup.Group) {
        if ($null -ne $testCase.ExecutedAt -and $test.ExecutedAt -lt $node.ExecutedAt) {
            $node.ExecutedAt = $testCase.ExecutedAt
        }

        $node.TotalCount++
        switch ($testCase.Result) {
            Passed { $node.PassedCount++; break; }
            Failed { $node.FailedCount++; break; }
            Skipped { $node.SkippedCount++; break; }
            Inconclusive { $node.InconclusiveCount++; break; }
            NotRun { $node.NotRunCount++; break; }
        }

        $node.Duration += $testCase.Duration
    }

    return Get-NUnit3TestSuiteInfo -TestSuite $node -ParentPath $ParentPath -SuiteType 'ParameterizedMethod'
}

function Get-NUnit3ParameterizedFixtureSuiteInfo {
    param([Microsoft.PowerShell.Commands.GroupInfo] $TestSuiteGroup, [string] $ParentPath)
    # this is generating info for a group of blocks that were generated from the same block when ForEach are used

    # Using the Name from the first block as the name of the block group to make it readable,
    # even though we are grouping using GroupId of the blocks.

    $sampleBlock = $TestSuiteGroup.Group[0]
    $node = [PSCustomObject] @{
        Name              = $sampleBlock.Name
        ExpandedName      = $sampleBlock.Name
        Path              = $sampleBlock.Path
        Data              = $null
        TotalCount        = 0
        Duration          = [timespan]0
        ExecutedAt        = [datetime]::MinValue
        PassedCount       = 0
        FailedCount       = 0
        SkippedCount      = 0
        InconclusiveCount = 0
        NotRunCount       = 0
        OwnTotalCount     = 0
        ShouldRun         = $true
        Skip              = $false # ParameterizedFixture are always Runnable, even with -Skip
    }

    foreach ($block in $TestSuiteGroup.Group) {
        # get earliest execution time
        if ($null -ne $block.ExecutedAt -and $test.ExecutedAt -lt $node.ExecutedAt) {
            $node.ExecutedAt = $block.ExecutedAt
        }

        $node.PassedCount += $block.PassedCount
        $node.FailedCount += $block.FailedCount
        $node.SkippedCount += $block.SkippedCount
        $node.InconclusiveCount += $block.InconclusiveCount
        $node.NotRunCount += $block.NotRunCount
        $node.TotalCount += $block.TotalCount

        $node.Duration += $block.Duration
    }

    return Get-NUnit3TestSuiteInfo -TestSuite $node -ParentPath $ParentPath -SuiteType 'ParameterizedFixture'
}

function Write-NUnit3TestCaseElement {
    param($TestResult, [string] $ParentPath, [System.Xml.XmlWriter] $XmlWriter)

    $XmlWriter.WriteStartElement('test-case')

    Write-NUnit3TestCaseAttributes -TestResult $TestResult -ParentPath $ParentPath -XmlWriter $XmlWriter

    # Tests with testcases/foreach (has .GroupId) has tags on ParameterizedMethod-node
    $includeTags = (-not $TestResult.GroupId) -and $TestResult.Tag
    $hasData = $TestResult.Data -is [System.Collections.IDictionary] -and $TestResult.Data.Keys.Count -gt 0

    if ($includeTags -or $hasData) {
        $XmlWriter.WriteStartElement('properties')
        if ($hasData) { Write-NUnit3DataProperty -Data $TestResult.Data -XmlWriter $XmlWriter }
        if ($includeTags) { Write-NUnit3CategoryProperty -Tag $TestResult.Tag -XmlWriter $XmlWriter }
        $XmlWriter.WriteEndElement() # Close properties
    }

    switch ($TestResult.Result) {
        Skipped { Write-NUnitReasonElement -TestResult $TestResult -XmlWriter $XmlWriter; break }
        Pending { Write-NUnitReasonElement -TestResult $TestResult -XmlWriter $XmlWriter; break }
        Inconclusive { Write-NUnitReasonElement -TestResult $TestResult -XmlWriter $XmlWriter; break }
        Failed { Write-NUnit3FailureElement -TestResult $TestResult -XmlWriter $XmlWriter; break }
    }

    if ($TestResult.StandardOutput) {
        Write-NUnit3OutputElement -Output $TestResult.StandardOutput -XmlWriter $XmlWriter
    }

    $XmlWriter.WriteEndElement()
}

function Write-NUnit3TestCaseAttributes {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseSingularNouns', '')]
    param($TestResult, [string] $ParentPath, [System.Xml.XmlWriter] $XmlWriter)

    # add parameters to name for testcase with data when not using variables in name
    if ($TestResult.Data -and ($TestResult.Name -eq $TestResult.ExpandedName)) {
        $paramString = Get-NUnit3ParamString -Node $TestResult
        $name = "$($TestResult.Name)$paramString"
    }
    else {
        $name = $TestResult.ExpandedName
    }

    $fullname = "$($ParentPath).$name"
    # Skip during test-execution is still runnable test-case
    $runstate = if ($TestResult.Skip) { 'Ignored' } else { 'Runnable' }

    $XmlWriter.WriteAttributeString('id', (Get-NUnit3NodeId))
    # Workaround - name-attribute should be $name, but CI-reports don't show the tree-view nor use fullname
    # See https://github.com/pester/Pester/issues/1530#issuecomment-1186187298
    $XmlWriter.WriteAttributeString('name', $fullname)
    $XmlWriter.WriteAttributeString('fullname', $fullname)
    $XmlWriter.WriteAttributeString('methodname', $TestResult.Name)
    $XmlWriter.WriteAttributeString('classname', $TestResult.Block.Path -join '.')
    $XmlWriter.WriteAttributeString('runstate', $runstate)
    switch ($TestResult.Result) {
        Failed { $XmlWriter.WriteAttributeString('result', 'Failed'); break }
        Passed { $XmlWriter.WriteAttributeString('result', 'Passed'); break }
        Skipped { $XmlWriter.WriteAttributeString('result', 'Skipped'); break }
        Pending { $XmlWriter.WriteAttributeString('result', 'Inconclusive'); break }
        Inconclusive { $XmlWriter.WriteAttributeString('result', 'Inconclusive'); break }
        # result-attribute is required, so intentionally making xml invalid if unknown state occurs
    }
    if ($TestResult.ShouldRun -and (-not $TestResult.Executed)) {
        $XmlWriter.WriteAttributeString('site', 'Parent')
    }
    if ($TestResult.Executed) {
        $XmlWriter.WriteAttributeString('start-time', (Get-UTCTimeString $TestResult.ExecutedAt))
        $XmlWriter.WriteAttributeString('end-time', (Get-UTCTimeString ($TestResult.ExecutedAt + $TestResult.Duration)))
        $XmlWriter.WriteAttributeString('duration', (Convert-TimeSpan $TestResult.Duration))
    }
    $XmlWriter.WriteAttributeString('seed', '0') # required attr.
    $XmlWriter.WriteAttributeString('asserts', '1') # required attr, so hardcoding 1:1 per testcase
}

function Write-NUnit3OutputElement ($Output, [System.Xml.XmlWriter] $XmlWriter) {
    # The characters in the range 0x01 to 0x20 are invalid for CData
    # (with the exception of the characters 0x09, 0x0A and 0x0D)
    # We convert each of these using the unicode printable version,
    # which is obtained by adding 0x2400
    [int]$unicodeControlPictures = 0x2400

    # Avoid indexing into an enumerable, such as a `string`, when there is only one item in the
    # output array.
    $out = @($Output)
    $linesCount = $out.Length
    $o = for ($i = 0; $i -lt $linesCount; $i++) {
        # The input is array of objects, convert them to strings.
        $line = if ($null -eq $out[$i]) { [String]::Empty } else { $out[$i].ToString() }

        if (0 -gt $line.IndexOfAny($script:invalidCDataChars)) {
            # No special chars that need replacing.
            $line
        }
        else {
            $chars = [char[]]$line;
            $charCount = $chars.Length
            for ($j = 0; $j -lt $charCount; $j++) {
                $char = $chars[$j]
                if ($char -in $script:invalidCDataChars) {
                    $chars[$j] = [char]([int]$char + $unicodeControlPictures)
                }
            }

            $chars -join ''
        }
    }

    $outputString = $o -join [Environment]::NewLine
    $XmlWriter.WriteStartElement('output')
    $XmlWriter.WriteCData($outputString)
    $XmlWriter.WriteEndElement()
}

function Write-NUnit3FailureElement ($TestResult, [System.Xml.XmlWriter] $XmlWriter) {
    # TODO: remove monkey patching the error message when parent setup failed so this test never run
    # TODO: do not format the errors here, instead format them in the core using some unified function so we get the same thing on the screen and in nunit

    $result = Get-ErrorForXmlReport -TestResult $TestResult
    $XmlWriter.WriteStartElement('failure')

    $XmlWriter.WriteStartElement('message')
    $XmlWriter.WriteCData($result.FailureMessage)
    $XmlWriter.WriteEndElement() # Close message

    if ($result.StackTrace) {
        $XmlWriter.WriteStartElement('stack-trace')
        $XmlWriter.WriteCData($result.StackTrace)
        $XmlWriter.WriteEndElement() # Close stack-trace
    }

    $XmlWriter.WriteEndElement() # Close failure
}

function Write-NUnitReasonElement ($TestResult, [System.Xml.XmlWriter] $XmlWriter) {
    # TODO: do not format the errors here, instead format them in the core using some unified function so we get the same thing on the screen and in nunit

    $result = Get-ErrorForXmlReport -TestResult $TestResult
    if ($result.FailureMessage) {
        $XmlWriter.WriteStartElement('reason')
        $XmlWriter.WriteStartElement('message')
        $XmlWriter.WriteCData($result.FailureMessage)
        $XmlWriter.WriteEndElement() # Close message
        $XmlWriter.WriteEndElement() # Close reason
    }
}

function Write-NUnit3CategoryProperty ([string[]]$Tag, [System.Xml.XmlWriter] $XmlWriter) {
    foreach ($t in $Tag) {
        $XmlWriter.WriteStartElement('property')
        $XmlWriter.WriteAttributeString('name', 'Category')
        $XmlWriter.WriteAttributeString('value', $t)
        $XmlWriter.WriteEndElement() # Close property
    }
}

function Write-NUnit3DataProperty ([System.Collections.IDictionary] $Data, [System.Xml.XmlWriter] $XmlWriter) {
    foreach ($d in $Data.GetEnumerator()) {
        $name = $d.Key
        $value = $d.Value

        $formattedValue = if ($null -eq $value) {
            'null'
        }
        elseif ($value -is [datetime]) {
            Get-UTCTimeString $value
        }
        else {
            #do not use .ToString() it uses the current culture settings
            #and we need to use en-US culture, which [string] or .ToString([Globalization.CultureInfo]'en-us') uses
            [string]$value
        }

        $XmlWriter.WriteStartElement('property')
        $XmlWriter.WriteAttributeString('name', $name)
        $XmlWriter.WriteAttributeString('value', $formattedValue)
        $XmlWriter.WriteEndElement() # Close property
    }
}

function Get-NUnit3NodeId {
    # depends on inhertied $reportIds created in Write-NUnit3TestRunChildNode
    if ($null -eq $reportIds) { return '' }

    # Unique id (string):  <asemmblyid>-<counter>
    # Increment node-id for next node
    '{0}-{1}' -f $reportIds.Assembly, $reportIds.Node++
}

function Get-NUnit3ParamString ($Node) {
    if ($Node.Data -isnot [System.Collections.IDictionary]) { return }

    $params = @(
        foreach ($value in $Node.Data.Values) {
            if ($null -eq $value) {
                'null'
            }
            elseif ($value -is [string]) {
                '"{0}"' -f $value
            }
            else {
                #do not use .ToString() it uses the current culture settings
                #and we need to use en-US culture, which [string] or .ToString([Globalization.CultureInfo]'en-us') uses
                [string]$value
            }
        }
    )

    "($($params -join ','))"
}
# file src\functions\TestResults.ps1
function GetFullPath ([string]$Path) {
    $Folder = & $SafeCommands['Split-Path'] -Path $Path -Parent
    $File = & $SafeCommands['Split-Path'] -Path $Path -Leaf

    if ( -not ([String]::IsNullOrEmpty($Folder))) {
        if (-not (& $SafeCommands['Test-Path'] $Folder)) {
            $null = & $SafeCommands['New-Item'] $Folder -ItemType Container -Force
        }

        $FolderResolved = & $SafeCommands['Resolve-Path'] -Path $Folder
    }
    else {
        $FolderResolved = & $SafeCommands['Resolve-Path'] -Path $ExecutionContext.SessionState.Path.CurrentFileSystemLocation
    }

    $Path = & $SafeCommands['Join-Path'] -Path $FolderResolved.ProviderPath -ChildPath $File

    return $Path
}

function Export-PesterResult {
    param (
        [Pester.Run] $Result,
        [string] $Path,
        [string] $Format
    )

    switch -Wildcard ($Format) {
        'NUnit2.5' {
            Export-XmlReport -Result $Result -Path $Path -Format $Format
        }

        'NUnit3' {
            Export-XmlReport -Result $Result -Path $Path -Format $Format
        }

        '*Xml' {
            Export-XmlReport -Result $Result -Path $Path -Format $Format
        }

        default {
            throw "'$Format' is not a valid Pester export format."
        }
    }
}

function Export-NUnitReport {
    <#
    .SYNOPSIS
    Exports a Pester result-object to an NUnit-compatible XML-report

    .DESCRIPTION
    Pester can generate a result-object containing information about all
    tests that are processed in a run. This object can then be exported to an
    NUnit-compatible XML-report using this function. The report is generated
    using the NUnit 2.5-schema (default) or NUnit3-compatible format.

    This can be useful for further processing or publishing of test results,
    e.g. as part of a CI/CD pipeline.

    .PARAMETER Result
    Result object from a Pester-run. This can be retrieved using Invoke-Pester
    -Passthru or by using the Run.PassThru configuration-option.

    .PARAMETER Path
    The path where the XML-report should be saved.

    .PARAMETER Format
    Specifies the NUnit-schema to be used.

    .EXAMPLE
    ```powershell
    $p = Invoke-Pester -Passthru
    $p | Export-NUnitReport -Path TestResults.xml
    ```

    This example runs Pester using the Passthru option to retrieve the result-object and
    exports it as an NUnit 2.5-compatible XML-report.

    .LINK
    https://pester.dev/docs/v5/commands/Export-NUnitReport

    .LINK
    https://pester.dev/docs/v5/commands/Invoke-Pester
    #>
    param (
        [parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [Pester.Run] $Result,

        [parameter(Mandatory = $true)]
        [String] $Path,

        [ValidateSet('NUnit2.5', 'NUnit3')]
        [string] $Format = 'NUnit2.5'
    )

    Export-XmlReport -Result $Result -Path $Path -Format $Format
}

function Export-JUnitReport {
    <#
    .SYNOPSIS
    Exports a Pester result-object to an JUnit-compatible XML-report

    .DESCRIPTION
    Pester can generate a result-object containing information about all
    tests that are processed in a run. This object can then be exported to an
    JUnit-compatible XML-report using this function. The report is generated
    using the JUnit 4-schema.

    This can be useful for further processing or publishing of test results,
    e.g. as part of a CI/CD pipeline.

    .PARAMETER Result
    Result object from a Pester-run. This can be retrieved using Invoke-Pester
    -Passthru or by using the Run.PassThru configuration-option.

    .PARAMETER Path
    The path where the XML-report should be saved.

    .EXAMPLE
    ```powershell
    $p = Invoke-Pester -Passthru
    $p | Export-JUnitReport -Path TestResults.xml
    ```

    This example runs Pester using the Passthru option to retrieve the result-object and
    exports it as an JUnit 4-compatible XML-report.

    .LINK
    https://pester.dev/docs/v5/commands/Export-JUnitReport

    .LINK
    https://pester.dev/docs/v5/commands/Invoke-Pester
    #>
    param (
        [parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [Pester.Run] $Result,

        [parameter(Mandatory = $true)]
        [String] $Path
    )

    Export-XmlReport -Result $Result -Path $Path -Format JUnitXml
}

function Export-XmlReport {
    param (
        [parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [Pester.Run] $Result,

        [parameter(Mandatory = $true)]
        [String] $Path,

        [parameter(Mandatory = $true)]
        [ValidateSet('NUnitXml', 'NUnit2.5', 'NUnit3', 'JUnitXml')]
        [string] $Format
    )

    if ('NUnit2.5' -eq $Format) {
        $Format = 'NUnitXml'
    }

    #the xmlwriter create method can resolve relatives paths by itself. but its current directory might
    #be different from what PowerShell sees as the current directory so I have to resolve the path beforehand
    #working around the limitations of Resolve-Path
    $Path = GetFullPath -Path $Path

    $settings = [Xml.XmlWriterSettings] @{
        Indent              = $true
        NewLineOnAttributes = $false
    }

    $xmlFile = $null
    $xmlWriter = $null
    try {
        $xmlFile = [IO.File]::Create($Path)
        $xmlWriter = [Xml.XmlWriter]::Create($xmlFile, $settings)

        switch ($Format) {
            'NUnitXml' {
                Write-NUnitReport -XmlWriter $xmlWriter -Result $Result
            }

            'NUnit3' {
                Write-NUnit3Report -XmlWriter $xmlWriter -Result $Result
            }

            'JUnitXml' {
                Write-JUnitReport -XmlWriter $xmlWriter -Result $Result
            }
        }

        $xmlWriter.Flush()
        $xmlFile.Flush()
    }
    finally {
        if ($null -ne $xmlWriter) {
            try {
                $xmlWriter.Close()
            }
            catch {
            }
        }
        if ($null -ne $xmlFile) {
            try {
                $xmlFile.Close()
            }
            catch {
            }
        }
    }
}

function ConvertTo-NUnitReport {
    <#
    .SYNOPSIS
    Converts a Pester result-object to an NUnit 2.5 or 3-compatible XML-report

    .DESCRIPTION
    Pester can generate a result-object containing information about all
    tests that are processed in a run. This objects can then be converted to an
    NUnit-compatible XML-report using this function. The report is generated
    using either the NUnit 2.5 or 3-schema.

    The function can convert to both XML-object or a string containing the XML.
    This can be useful for further processing or publishing of test results,
    e.g. as part of a CI/CD pipeline.

    .PARAMETER Result
    Result object from a Pester-run. This can be retrieved using Invoke-Pester
    -Passthru or by using the Run.PassThru configuration-option.

    .PARAMETER AsString
    Returns the XML-report as a string.

    .PARAMETER Format
    Specifies the NUnit-schema to be used.

    .EXAMPLE
    ```powershell
    $p = Invoke-Pester -Passthru
    $p | ConvertTo-NUnitReport
    ```

    This example runs Pester using the Passthru option to retrieve the result-object and
    converts it to an NUnit 2.5-compatible XML-report. The report is returned as an XML-object.

    .EXAMPLE
    ```powershell
    $p = Invoke-Pester -Passthru
    $p | ConvertTo-NUnitReport -Format NUnit3
    ```

    This example runs Pester using the Passthru option to retrieve the result-object and
    converts it to an NUnit 3-compatible XML-report. The report is returned as an XML-object.

    .EXAMPLE
    ```powershell
    $p = Invoke-Pester -Passthru
    $p | ConvertTo-NUnitReport -AsString
    ```

    This example runs Pester using the Passthru option to retrieve the result-object and
    converts it to an NUnit 2.5-compatible XML-report. The returned object is a string.

    .LINK
    https://pester.dev/docs/v5/commands/ConvertTo-NUnitReport

    .LINK
    https://pester.dev/docs/v5/commands/Invoke-Pester
    #>
    param (
        [parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [Pester.Run] $Result,
        [Switch] $AsString,

        [ValidateSet('NUnit2.5', 'NUnit3')]
        [string] $Format = 'NUnit2.5'
    )

    $settings = [Xml.XmlWriterSettings] @{
        Indent              = $true
        NewLineOnAttributes = $false
    }

    $stringWriter = $null
    $xmlWriter = $null
    try {
        $stringWriter = & $SafeCommands['New-Object'] IO.StringWriter
        $xmlWriter = [Xml.XmlWriter]::Create($stringWriter, $settings)

        switch ($Format) {
            'NUnit2.5' {
                Write-NUnitReport -XmlWriter $xmlWriter -Result $Result
            }

            'NUnit3' {
                Write-NUnit3Report -XmlWriter $xmlWriter -Result $Result
            }
        }

        $xmlWriter.Flush()
        $stringWriter.Flush()
    }
    finally {
        $xmlWriter.Close()
        if (-not $AsString) {
            [xml] $stringWriter.ToString()
        }
        else {
            $stringWriter.ToString()
        }
    }
}

function ConvertTo-JUnitReport {
    <#
    .SYNOPSIS
    Converts a Pester result-object to an JUnit-compatible XML report

    .DESCRIPTION
    Pester can generate a result-object containing information about all
    tests that are processed in a run. This objects can then be converted to an
    NUnit-compatible XML-report using this function. The report is generated
    using the JUnit 4-schema.

    The function can convert to both XML-object or a string containing the XML.
    This can be useful for further processing or publishing of test results,
    e.g. as part of a CI/CD pipeline.

    .PARAMETER Result
    Result object from a Pester-run. This can be retrieved using Invoke-Pester
    -Passthru or by using the Run.PassThru configuration-option.

    .PARAMETER AsString
    Returns the XML-report as a string.

    .EXAMPLE
    ```powershell
    $p = Invoke-Pester -Passthru
    $p | ConvertTo-JUnitReport
    ```

    This example runs Pester using the Passthru option to retrieve the result-object and
    converts it to an JUnit 4-compatible XML-report. The report is returned as an XML-object.

    .EXAMPLE
    ```powershell
    $p = Invoke-Pester -Passthru
    $p | ConvertTo-JUnitReport -AsString
    ```

    This example runs Pester using the Passthru option to retrieve the result-object and
    converts it to an JUnit 4-compatible XML-report. The returned object is a string.

    .LINK
    https://pester.dev/docs/v5/commands/ConvertTo-JUnitReport

    .LINK
    https://pester.dev/docs/v5/commands/Invoke-Pester
    #>
    param (
        [parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [Pester.Run] $Result,
        [Switch] $AsString
    )

    $settings = [Xml.XmlWriterSettings] @{
        Indent              = $true
        NewLineOnAttributes = $false
    }

    $stringWriter = $null
    $xmlWriter = $null
    try {
        $stringWriter = & $SafeCommands['New-Object'] IO.StringWriter
        $xmlWriter = [Xml.XmlWriter]::Create($stringWriter, $settings)

        Write-JUnitReport -XmlWriter $xmlWriter -Result $Result

        $xmlWriter.Flush()
        $stringWriter.Flush()
    }
    finally {
        $xmlWriter.Close()
        if (-not $AsString) {
            [xml] $stringWriter.ToString()
        }
        else {
            $stringWriter.ToString()
        }
    }
}

function Get-TestTime($tests) {
    [TimeSpan]$totalTime = 0;
    if ($tests) {
        foreach ($test in $tests) {
            $totalTime += $test.time
        }
    }

    Convert-TimeSpan -TimeSpan $totalTime
}

function Convert-TimeSpan {
    param (
        [Parameter(ValueFromPipeline = $true)]
        $TimeSpan
    )
    process {
        if ($TimeSpan) {
            [string][math]::round(([TimeSpan]$TimeSpan).totalseconds, 4)
        }
        else {
            '0'
        }
    }
}

function Get-UTCTimeString ([datetime]$DateTime) {
    $DateTime.ToUniversalTime().ToString('o')
}

function Get-ErrorForXmlReport ($TestResult) {
    $failureMessage = if (($TestResult.ShouldRun -and -not $TestResult.Executed)) {
        'This test should run but it did not. Most likely a setup in some parent block failed.'
    }
    else {
        $multipleErrors = 1 -lt $TestResult.ErrorRecord.Count

        if ($multipleErrors) {
            $c = 0
            $(foreach ($err in $TestResult.ErrorRecord) {
                    "[$(($c++))] $($err.DisplayErrorMessage)"
                }) -join [Environment]::NewLine
        }
        else {
            $TestResult.ErrorRecord.DisplayErrorMessage
        }
    }

    $st = & {
        $multipleErrors = 1 -lt $TestResult.ErrorRecord.Count

        if ($multipleErrors) {
            $c = 0
            $(foreach ($err in $TestResult.ErrorRecord) {
                    "[$(($c++))] $($err.DisplayStackTrace)"
                }) -join [Environment]::NewLine
        }
        else {
            [string] $TestResult.ErrorRecord.DisplayStackTrace
        }
    }

    @{
        FailureMessage = $failureMessage
        StackTrace     = $st
    }
}

function Get-RunTimeEnvironment {
    # based on what we found during startup, use the appropriate cmdlet
    $computerName = $env:ComputerName
    $userName = $env:Username
    if ($null -ne $SafeCommands['Get-CimInstance']) {
        $osSystemInformation = (& $SafeCommands['Get-CimInstance'] Win32_OperatingSystem)
    }
    elseif ($null -ne $SafeCommands['Get-WmiObject']) {
        $osSystemInformation = (& $SafeCommands['Get-WmiObject'] Win32_OperatingSystem)
    }
    elseif ($IsMacOS -or $IsLinux) {
        $osSystemInformation = @{
            Name    = 'Unknown'
            Version = '0.0.0.0'
        }
        try {
            if ($null -ne $SafeCommands['uname']) {
                $osSystemInformation.Version = & $SafeCommands['uname'] -r
                $osSystemInformation.Name = & $SafeCommands['uname'] -s
                $computerName = & $SafeCommands['uname'] -n
            }
            if ($null -ne $SafeCommands['id']) {
                $userName = & $SafeCommands['id'] -un
            }
        }
        catch {
            # well, we tried
        }
    }
    else {
        $osSystemInformation = @{
            Name    = 'Unknown'
            Version = '0.0.0.0'
        }
    }

    @{
        'nunit-version'     = '2.5.8.0'
        'junit-version'     = '4'
        'os-version'        = $osSystemInformation.Version
        'platform'          = $osSystemInformation.Name
        'cwd'               = $pwd.Path
        'machine-name'      = $computerName
        'user'              = $username
        'user-domain'       = $env:userDomain
        'clr-version'       = [string][System.Environment]::Version
        'framework-version' = [string]$ExecutionContext.SessionState.Module.Version
    }
}

function Get-TestResultPlugin {
    # Validate configuration
    Resolve-TestResultConfiguration

    $p = @{
        Name = 'TestResult'
    }

    $p.End = {
        param($Context)

        $run = $Context.TestRun
        $testResultConfig = $PesterPreference.TestResult
        Export-PesterResult -Result $run -Path $testResultConfig.OutputPath.Value -Format $testResultConfig.OutputFormat.Value
    }

    New-PluginObject @p
}

function Resolve-TestResultConfiguration {
    $supportedFormats = 'NUnitXml', 'NUnit2.5', 'NUnit3', 'JUnitXml'
    if ($PesterPreference.TestResult.OutputFormat.Value -notin $supportedFormats) {
        throw (Get-StringOptionErrorMessage -OptionPath 'TestResult.OutputFormat' -SupportedValues $supportedFormats -Value $PesterPreference.TestResult.OutputFormat.Value)
    }
}
# file src\Module.ps1
# Set-SessionStateHint -Hint Pester -SessionState $ExecutionContext.SessionState
# these functions will be shared with the mock bootstrap function, or used in mocked calls so let's capture them just once instead of every time we use a mock
$script:SafeCommands['ExecutionContext'] = $ExecutionContext
$script:SafeCommands['Get-MockDynamicParameter'] = $ExecutionContext.SessionState.InvokeCommand.GetCommand('Get-MockDynamicParameter', 'function')
$script:SafeCommands['Write-PesterDebugMessage'] = $ExecutionContext.SessionState.InvokeCommand.GetCommand('Write-PesterDebugMessage', 'function')
$script:SafeCommands['Set-DynamicParameterVariable'] = $ExecutionContext.SessionState.InvokeCommand.GetCommand('Set-DynamicParameterVariable', 'function')

& $SafeCommands['Set-Alias'] 'Add-AssertionOperator' 'Add-ShouldOperator'
& $SafeCommands['Set-Alias'] 'Get-AssertionOperator' 'Get-ShouldOperator'

& $SafeCommands['Update-TypeData'] -TypeName PesterConfiguration -TypeConverter 'PesterConfigurationDeserializer' -SerializationDepth 5 -Force
& $SafeCommands['Update-TypeData'] -TypeName 'Deserialized.PesterConfiguration' -TargetTypeForDeserialization PesterConfiguration -Force

& $script:SafeCommands['Export-ModuleMember'] @(
    'Invoke-Pester'

    # blocks
    'Describe'
    'Context'
    'It'

    # mocking
    'Mock'
    'InModuleScope'

    # setups
    'BeforeDiscovery'
    'BeforeAll'
    'BeforeEach'
    'AfterEach'
    'AfterAll'

    # should
    'Should'
    'Add-ShouldOperator'
    'Get-ShouldOperator'

    # config
    'New-PesterContainer'
    'New-PesterConfiguration'

    # export
    'Export-NUnitReport'
    'ConvertTo-NUnitReport'
    'Export-JUnitReport'
    'ConvertTo-JUnitReport'
    'ConvertTo-Pester4Result'

    # legacy
    'Assert-VerifiableMock'
    'Assert-MockCalled'
    'Set-ItResult'
    'New-MockObject'

    'New-Fixture'
) -Alias @(
    'Add-AssertionOperator'
    'Get-AssertionOperator'
)


# SIG # Begin signature block
# MIIttwYJKoZIhvcNAQcCoIItqDCCLaQCAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCDWxATJOR5gXOiJ
# 3rcy9Xkx4QLa9kp2ejiWhROteLfy2aCCEw8wggWQMIIDeKADAgECAhAFmxtXno4h
# MuI5B72nd3VcMA0GCSqGSIb3DQEBDAUAMGIxCzAJBgNVBAYTAlVTMRUwEwYDVQQK
# EwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xITAfBgNV
# BAMTGERpZ2lDZXJ0IFRydXN0ZWQgUm9vdCBHNDAeFw0xMzA4MDExMjAwMDBaFw0z
# ODAxMTUxMjAwMDBaMGIxCzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJ
# bmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xITAfBgNVBAMTGERpZ2lDZXJ0
# IFRydXN0ZWQgUm9vdCBHNDCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIB
# AL/mkHNo3rvkXUo8MCIwaTPswqclLskhPfKK2FnC4SmnPVirdprNrnsbhA3EMB/z
# G6Q4FutWxpdtHauyefLKEdLkX9YFPFIPUh/GnhWlfr6fqVcWWVVyr2iTcMKyunWZ
# anMylNEQRBAu34LzB4TmdDttceItDBvuINXJIB1jKS3O7F5OyJP4IWGbNOsFxl7s
# Wxq868nPzaw0QF+xembud8hIqGZXV59UWI4MK7dPpzDZVu7Ke13jrclPXuU15zHL
# 2pNe3I6PgNq2kZhAkHnDeMe2scS1ahg4AxCN2NQ3pC4FfYj1gj4QkXCrVYJBMtfb
# BHMqbpEBfCFM1LyuGwN1XXhm2ToxRJozQL8I11pJpMLmqaBn3aQnvKFPObURWBf3
# JFxGj2T3wWmIdph2PVldQnaHiZdpekjw4KISG2aadMreSx7nDmOu5tTvkpI6nj3c
# AORFJYm2mkQZK37AlLTSYW3rM9nF30sEAMx9HJXDj/chsrIRt7t/8tWMcCxBYKqx
# YxhElRp2Yn72gLD76GSmM9GJB+G9t+ZDpBi4pncB4Q+UDCEdslQpJYls5Q5SUUd0
# viastkF13nqsX40/ybzTQRESW+UQUOsxxcpyFiIJ33xMdT9j7CFfxCBRa2+xq4aL
# T8LWRV+dIPyhHsXAj6KxfgommfXkaS+YHS312amyHeUbAgMBAAGjQjBAMA8GA1Ud
# EwEB/wQFMAMBAf8wDgYDVR0PAQH/BAQDAgGGMB0GA1UdDgQWBBTs1+OC0nFdZEzf
# Lmc/57qYrhwPTzANBgkqhkiG9w0BAQwFAAOCAgEAu2HZfalsvhfEkRvDoaIAjeNk
# aA9Wz3eucPn9mkqZucl4XAwMX+TmFClWCzZJXURj4K2clhhmGyMNPXnpbWvWVPjS
# PMFDQK4dUPVS/JA7u5iZaWvHwaeoaKQn3J35J64whbn2Z006Po9ZOSJTROvIXQPK
# 7VB6fWIhCoDIc2bRoAVgX+iltKevqPdtNZx8WorWojiZ83iL9E3SIAveBO6Mm0eB
# cg3AFDLvMFkuruBx8lbkapdvklBtlo1oepqyNhR6BvIkuQkRUNcIsbiJeoQjYUIp
# 5aPNoiBB19GcZNnqJqGLFNdMGbJQQXE9P01wI4YMStyB0swylIQNCAmXHE/A7msg
# dDDS4Dk0EIUhFQEI6FUy3nFJ2SgXUE3mvk3RdazQyvtBuEOlqtPDBURPLDab4vri
# RbgjU2wGb2dVf0a1TD9uKFp5JtKkqGKX0h7i7UqLvBv9R0oN32dmfrJbQdA75PQ7
# 9ARj6e/CVABRoIoqyc54zNXqhwQYs86vSYiv85KZtrPmYQ/ShQDnUBrkG5WdGaG5
# nLGbsQAe79APT0JsyQq87kP6OnGlyE0mpTX9iV28hWIdMtKgK1TtmlfB2/oQzxm3
# i0objwG2J5VT6LaJbVu8aNQj6ItRolb58KaAoNYes7wPD1N1KarqE3fk3oyBIa0H
# EEcRrYc9B9F1vM/zZn4wggawMIIEmKADAgECAhAIrUCyYNKcTJ9ezam9k67ZMA0G
# CSqGSIb3DQEBDAUAMGIxCzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJ
# bmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xITAfBgNVBAMTGERpZ2lDZXJ0
# IFRydXN0ZWQgUm9vdCBHNDAeFw0yMTA0MjkwMDAwMDBaFw0zNjA0MjgyMzU5NTla
# MGkxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwgSW5jLjFBMD8GA1UE
# AxM4RGlnaUNlcnQgVHJ1c3RlZCBHNCBDb2RlIFNpZ25pbmcgUlNBNDA5NiBTSEEz
# ODQgMjAyMSBDQTEwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDVtC9C
# 0CiteLdd1TlZG7GIQvUzjOs9gZdwxbvEhSYwn6SOaNhc9es0JAfhS0/TeEP0F9ce
# 2vnS1WcaUk8OoVf8iJnBkcyBAz5NcCRks43iCH00fUyAVxJrQ5qZ8sU7H/Lvy0da
# E6ZMswEgJfMQ04uy+wjwiuCdCcBlp/qYgEk1hz1RGeiQIXhFLqGfLOEYwhrMxe6T
# SXBCMo/7xuoc82VokaJNTIIRSFJo3hC9FFdd6BgTZcV/sk+FLEikVoQ11vkunKoA
# FdE3/hoGlMJ8yOobMubKwvSnowMOdKWvObarYBLj6Na59zHh3K3kGKDYwSNHR7Oh
# D26jq22YBoMbt2pnLdK9RBqSEIGPsDsJ18ebMlrC/2pgVItJwZPt4bRc4G/rJvmM
# 1bL5OBDm6s6R9b7T+2+TYTRcvJNFKIM2KmYoX7BzzosmJQayg9Rc9hUZTO1i4F4z
# 8ujo7AqnsAMrkbI2eb73rQgedaZlzLvjSFDzd5Ea/ttQokbIYViY9XwCFjyDKK05
# huzUtw1T0PhH5nUwjewwk3YUpltLXXRhTT8SkXbev1jLchApQfDVxW0mdmgRQRNY
# mtwmKwH0iU1Z23jPgUo+QEdfyYFQc4UQIyFZYIpkVMHMIRroOBl8ZhzNeDhFMJlP
# /2NPTLuqDQhTQXxYPUez+rbsjDIJAsxsPAxWEQIDAQABo4IBWTCCAVUwEgYDVR0T
# AQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUaDfg67Y7+F8Rhvv+YXsIiGX0TkIwHwYD
# VR0jBBgwFoAU7NfjgtJxXWRM3y5nP+e6mK4cD08wDgYDVR0PAQH/BAQDAgGGMBMG
# A1UdJQQMMAoGCCsGAQUFBwMDMHcGCCsGAQUFBwEBBGswaTAkBggrBgEFBQcwAYYY
# aHR0cDovL29jc3AuZGlnaWNlcnQuY29tMEEGCCsGAQUFBzAChjVodHRwOi8vY2Fj
# ZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRUcnVzdGVkUm9vdEc0LmNydDBDBgNV
# HR8EPDA6MDigNqA0hjJodHRwOi8vY3JsMy5kaWdpY2VydC5jb20vRGlnaUNlcnRU
# cnVzdGVkUm9vdEc0LmNybDAcBgNVHSAEFTATMAcGBWeBDAEDMAgGBmeBDAEEATAN
# BgkqhkiG9w0BAQwFAAOCAgEAOiNEPY0Idu6PvDqZ01bgAhql+Eg08yy25nRm95Ry
# sQDKr2wwJxMSnpBEn0v9nqN8JtU3vDpdSG2V1T9J9Ce7FoFFUP2cvbaF4HZ+N3HL
# IvdaqpDP9ZNq4+sg0dVQeYiaiorBtr2hSBh+3NiAGhEZGM1hmYFW9snjdufE5Btf
# Q/g+lP92OT2e1JnPSt0o618moZVYSNUa/tcnP/2Q0XaG3RywYFzzDaju4ImhvTnh
# OE7abrs2nfvlIVNaw8rpavGiPttDuDPITzgUkpn13c5UbdldAhQfQDN8A+KVssIh
# dXNSy0bYxDQcoqVLjc1vdjcshT8azibpGL6QB7BDf5WIIIJw8MzK7/0pNVwfiThV
# 9zeKiwmhywvpMRr/LhlcOXHhvpynCgbWJme3kuZOX956rEnPLqR0kq3bPKSchh/j
# wVYbKyP/j7XqiHtwa+aguv06P0WmxOgWkVKLQcBIhEuWTatEQOON8BUozu3xGFYH
# Ki8QxAwIZDwzj64ojDzLj4gLDb879M4ee47vtevLt/B3E+bnKD+sEq6lLyJsQfmC
# XBVmzGwOysWGw/YmMwwHS6DTBwJqakAwSEs0qFEgu60bhQjiWQ1tygVQK+pKHJ6l
# /aCnHwZ05/LWUpD9r4VIIflXO7ScA+2GRfS0YW6/aOImYIbqyK+p/pQd52MbOoZW
# eE4wggbDMIIEq6ADAgECAhAHNssXKkOy4c8wJoU8r9tXMA0GCSqGSIb3DQEBCwUA
# MGkxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5EaWdpQ2VydCwgSW5jLjFBMD8GA1UE
# AxM4RGlnaUNlcnQgVHJ1c3RlZCBHNCBDb2RlIFNpZ25pbmcgUlNBNDA5NiBTSEEz
# ODQgMjAyMSBDQTEwHhcNMjQwNzAyMDAwMDAwWhcNMjcwNDI0MjM1OTU5WjBLMQsw
# CQYDVQQGEwJDWjEOMAwGA1UEBxMFUHJhaGExFTATBgNVBAoMDEpha3ViIEphcmXF
# oTEVMBMGA1UEAwwMSmFrdWIgSmFyZcWhMIIBojANBgkqhkiG9w0BAQEFAAOCAY8A
# MIIBigKCAYEAldhVuWe5GqOcKtymEnaA0W5kVQP+57xKp+JIhGjOaU4Nh+HCmMmK
# MUGAt9ybC8leBrDFMfzT8ouHoXDn9Yy+yyVO86ZxONqnvKGhQ+/aTm4Fn11I1aA2
# Epmr73Ig5yyxNKhRBy7DRnnTOKjPjNej5jaPeayaEUL65OM+vH+jxstOPXa1MiYf
# ukT0aUUI0On/hg/T18+IRD/rN5KVQ3W8JSfrYOJd5gJgZAFm4H5YvT1zeXKW+e2S
# yiUJSFaAMtk6cMJu1QnC+zIiQYbcBkzo9/hYGA73ojeyCu9OB56MQrVQCTEV2vpu
# YDBRt8iTQn7HjrVDzkU/iewPRZQxBcFNgq24tEDQBjJPlZdLNVn6czOusZ1mvhXL
# H6ZwqBueSRsRItRmtVS2EbGxgMgDd1/XkCgM6ghnnZBCsR/inhS22ZvFn93JUFeW
# PwLt6/olJCQQ3bSJHPdO0Sinl9TVUG8ydArJMgPBhUy35hoGP9k9iaA9tkgqWsb1
# e/fdJd2jGJLHAgMBAAGjggIDMIIB/zAfBgNVHSMEGDAWgBRoN+Drtjv4XxGG+/5h
# ewiIZfROQjAdBgNVHQ4EFgQU2W9/7yIXVaaEWZPxLJIGyPABXb8wPgYDVR0gBDcw
# NTAzBgZngQwBBAEwKTAnBggrBgEFBQcCARYbaHR0cDovL3d3dy5kaWdpY2VydC5j
# b20vQ1BTMA4GA1UdDwEB/wQEAwIHgDATBgNVHSUEDDAKBggrBgEFBQcDAzCBtQYD
# VR0fBIGtMIGqMFOgUaBPhk1odHRwOi8vY3JsMy5kaWdpY2VydC5jb20vRGlnaUNl
# cnRUcnVzdGVkRzRDb2RlU2lnbmluZ1JTQTQwOTZTSEEzODQyMDIxQ0ExLmNybDBT
# oFGgT4ZNaHR0cDovL2NybDQuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0VHJ1c3RlZEc0
# Q29kZVNpZ25pbmdSU0E0MDk2U0hBMzg0MjAyMUNBMS5jcmwwgZQGCCsGAQUFBwEB
# BIGHMIGEMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wXAYI
# KwYBBQUHMAKGUGh0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydFRy
# dXN0ZWRHNENvZGVTaWduaW5nUlNBNDA5NlNIQTM4NDIwMjFDQTEuY3J0MAkGA1Ud
# EwQCMAAwDQYJKoZIhvcNAQELBQADggIBAB93bRC0apbkZiLwZFhhhL994DCyythv
# Oowt+GgYkvq85dy1pi4PPFrwz8gu5QPIOOEHHXpSMJ5Tn6/u3R9uFMpYK5vmzECq
# 7j+IOtoyvG9fNU4/uKrfTuviCJHs3ksDD5CY0p4nAqcBAC0k9jIxzpon/INrjBDE
# 3e0DE5r6N9Dw5jwI7eHa6HMpfNyv/1IzYQzf0J9+i6Z4x86BqUjEtEMX0z8CFIqq
# hrK1vNi2lEZAGZehh33TkjQPRT9HbU7kCx//YfEcqcluH+lPiwGGDIkmmw+PlOwV
# 3GIKfIEhu6ZDnmCOUNLwu7EydfHmvdSy6kY4/beRnykFEdlJ2eyjVSFXXYa2T13W
# fRbXEATAFRtLVekLSUyLinBiw4ai5ACmE8J02o1VglNMNBAMs5JoATVmQAsU2z+B
# 8vd/ocmU0bQoZWdz3olErvVhpk48kfJ3wBnlWGPKlxDER5fTC2LeNyCS02Mldpb5
# wj53HwvRD7aOx9xUntZUFm99/dQ4QmPfoWIqejwQT9oT2Tb9czoc3ZArOxzTgOsH
# o2npAzR8jIIuO6vMBms9PtympkNLDtrG4xKQtWXT3jCnDywib5CTqNG60C4ucEym
# xz5dZIx/08Ymi7AF+7W/W3dWRt7dZrMz8Mm6H060IiCVKdw0rk7Shh11Y7xZ9Edn
# SJtLRtINTdoQMYIZ/jCCGfoCAQEwfTBpMQswCQYDVQQGEwJVUzEXMBUGA1UEChMO
# RGlnaUNlcnQsIEluYy4xQTA/BgNVBAMTOERpZ2lDZXJ0IFRydXN0ZWQgRzQgQ29k
# ZSBTaWduaW5nIFJTQTQwOTYgU0hBMzg0IDIwMjEgQ0ExAhAHNssXKkOy4c8wJoU8
# r9tXMA0GCWCGSAFlAwQCAQUAoIGWMBkGCSqGSIb3DQEJAzEMBgorBgEEAYI3AgEE
# MBwGCisGAQQBgjcCAQsxDjAMBgorBgEEAYI3AgEVMCoGCisGAQQBgjcCAQwxHDAa
# oAKAAKEUgBJodHRwczovL3Blc3Rlci5kZXYwLwYJKoZIhvcNAQkEMSIEIM3MVFgL
# T8R7S68scJNfw5atBYI+fD+VT++bvZ6KG2i0MA0GCSqGSIb3DQEBAQUABIIBgF8M
# cm945x+IbTcZ8Oui3/dwl/WsGH/OHClgdqxVb0iWqae0gj1WLrB7zGXvT97oPiCV
# UVU3xTqDD5zaSL21Dc01l6m77nnc+9O4AAfDSlnv5Bl3pJ6n6KhBcZx7Sa4ELGlx
# +IJUJ7QWmqvHik8WuPRtlI5D/gQuZQ2CszhqL3a2lf6sxFd2/S0nMNNJS3DPQf5S
# FE2PFzvNYpdHd+5PyQ4jqkd/GsixVicYcQmlqj/qbLHAoD2rWsYHFOtuM5sdghKx
# Nu3vi5UpLpmLTxW5P2zzgEd9uUJNx1iiyr/Do84nC5Y+8exSAfzXaf1TgJf1eB1O
# L4CINyer0aycpDrQxJWr3T5kAWrx1zACYkrBORWEr8E28V/jrukmQfokk2uDhpNW
# ybR38O1wUz9NXhBLpDJEYCL6V6uMgMMVz2Miq+Ckm1Fmkc9TUwIVfF3RcMMKvq04
# iEXzw9CkkWOfs/X2cF7pfXfM6aPT9dGtDRlTlZK6NyBo2AMj1wAXR0MYDZfzU6GC
# Fzkwghc1BgorBgEEAYI3AwMBMYIXJTCCFyEGCSqGSIb3DQEHAqCCFxIwghcOAgED
# MQ8wDQYJYIZIAWUDBAIBBQAwdwYLKoZIhvcNAQkQAQSgaARmMGQCAQEGCWCGSAGG
# /WwHATAxMA0GCWCGSAFlAwQCAQUABCA2YUzEgnWu2AEyXB/lcw4lVMcdKrKu5dA9
# lNqYe+FMMQIQOOkPTEB0tDnfPVbx1qfu8RgPMjAyNTAxMDgyMTExNTdaoIITAzCC
# BrwwggSkoAMCAQICEAuuZrxaun+Vh8b56QTjMwQwDQYJKoZIhvcNAQELBQAwYzEL
# MAkGA1UEBhMCVVMxFzAVBgNVBAoTDkRpZ2lDZXJ0LCBJbmMuMTswOQYDVQQDEzJE
# aWdpQ2VydCBUcnVzdGVkIEc0IFJTQTQwOTYgU0hBMjU2IFRpbWVTdGFtcGluZyBD
# QTAeFw0yNDA5MjYwMDAwMDBaFw0zNTExMjUyMzU5NTlaMEIxCzAJBgNVBAYTAlVT
# MREwDwYDVQQKEwhEaWdpQ2VydDEgMB4GA1UEAxMXRGlnaUNlcnQgVGltZXN0YW1w
# IDIwMjQwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQC+anOf9pUhq5Yw
# ultt5lmjtej9kR8YxIg7apnjpcH9CjAgQxK+CMR0Rne/i+utMeV5bUlYYSuuM4vQ
# ngvQepVHVzNLO9RDnEXvPghCaft0djvKKO+hDu6ObS7rJcXa/UKvNminKQPTv/1+
# kBPgHGlP28mgmoCw/xi6FG9+Un1h4eN6zh926SxMe6We2r1Z6VFZj75MU/HNmtsg
# tFjKfITLutLWUdAoWle+jYZ49+wxGE1/UXjWfISDmHuI5e/6+NfQrxGFSKx+rDdN
# MsePW6FLrphfYtk/FLihp/feun0eV+pIF496OVh4R1TvjQYpAztJpVIfdNsEvxHo
# fBf1BWkadc+Up0Th8EifkEEWdX4rA/FE1Q0rqViTbLVZIqi6viEk3RIySho1XyHL
# IAOJfXG5PEppc3XYeBH7xa6VTZ3rOHNeiYnY+V4j1XbJ+Z9dI8ZhqcaDHOoj5KGg
# 4YuiYx3eYm33aebsyF6eD9MF5IDbPgjvwmnAalNEeJPvIeoGJXaeBQjIK13SlnzO
# DdLtuThALhGtyconcVuPI8AaiCaiJnfdzUcb3dWnqUnjXkRFwLtsVAxFvGqsxUA2
# Jq/WTjbnNjIUzIs3ITVC6VBKAOlb2u29Vwgfta8b2ypi6n2PzP0nVepsFk8nlcuW
# fyZLzBaZ0MucEdeBiXL+nUOGhCjl+QIDAQABo4IBizCCAYcwDgYDVR0PAQH/BAQD
# AgeAMAwGA1UdEwEB/wQCMAAwFgYDVR0lAQH/BAwwCgYIKwYBBQUHAwgwIAYDVR0g
# BBkwFzAIBgZngQwBBAIwCwYJYIZIAYb9bAcBMB8GA1UdIwQYMBaAFLoW2W1NhS9z
# KXaaL3WMaiCPnshvMB0GA1UdDgQWBBSfVywDdw4oFZBmpWNe7k+SH3agWzBaBgNV
# HR8EUzBRME+gTaBLhklodHRwOi8vY3JsMy5kaWdpY2VydC5jb20vRGlnaUNlcnRU
# cnVzdGVkRzRSU0E0MDk2U0hBMjU2VGltZVN0YW1waW5nQ0EuY3JsMIGQBggrBgEF
# BQcBAQSBgzCBgDAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29t
# MFgGCCsGAQUFBzAChkxodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNl
# cnRUcnVzdGVkRzRSU0E0MDk2U0hBMjU2VGltZVN0YW1waW5nQ0EuY3J0MA0GCSqG
# SIb3DQEBCwUAA4ICAQA9rR4fdplb4ziEEkfZQ5H2EdubTggd0ShPz9Pce4FLJl6r
# eNKLkZd5Y/vEIqFWKt4oKcKz7wZmXa5VgW9B76k9NJxUl4JlKwyjUkKhk3aYx7D8
# vi2mpU1tKlY71AYXB8wTLrQeh83pXnWwwsxc1Mt+FWqz57yFq6laICtKjPICYYf/
# qgxACHTvypGHrC8k1TqCeHk6u4I/VBQC9VK7iSpU5wlWjNlHlFFv/M93748YTeoX
# U/fFa9hWJQkuzG2+B7+bMDvmgF8VlJt1qQcl7YFUMYgZU1WM6nyw23vT6QSgwX5P
# q2m0xQ2V6FJHu8z4LXe/371k5QrN9FQBhLLISZi2yemW0P8ZZfx4zvSWzVXpAb9k
# 4Hpvpi6bUe8iK6WonUSV6yPlMwerwJZP/Gtbu3CKldMnn+LmmRTkTXpFIEB06nXZ
# rDwhCGED+8RsWQSIXZpuG4WLFQOhtloDRWGoCwwc6ZpPddOFkM2LlTbMcqFSzm4c
# d0boGhBq7vkqI1uHRz6Fq1IX7TaRQuR+0BGOzISkcqwXu7nMpFu3mgrlgbAW+Bzi
# kRVQ3K2YHcGkiKjA4gi4OA/kz1YCsdhIBHXqBzR0/Zd2QwQ/l4Gxftt/8wY3grcc
# /nS//TVkej9nmUYu83BDtccHHXKibMs/yXHhDXNkoPIdynhVAku7aRZOwqw6pDCC
# Bq4wggSWoAMCAQICEAc2N7ckVHzYR6z9KGYqXlswDQYJKoZIhvcNAQELBQAwYjEL
# MAkGA1UEBhMCVVMxFTATBgNVBAoTDERpZ2lDZXJ0IEluYzEZMBcGA1UECxMQd3d3
# LmRpZ2ljZXJ0LmNvbTEhMB8GA1UEAxMYRGlnaUNlcnQgVHJ1c3RlZCBSb290IEc0
# MB4XDTIyMDMyMzAwMDAwMFoXDTM3MDMyMjIzNTk1OVowYzELMAkGA1UEBhMCVVMx
# FzAVBgNVBAoTDkRpZ2lDZXJ0LCBJbmMuMTswOQYDVQQDEzJEaWdpQ2VydCBUcnVz
# dGVkIEc0IFJTQTQwOTYgU0hBMjU2IFRpbWVTdGFtcGluZyBDQTCCAiIwDQYJKoZI
# hvcNAQEBBQADggIPADCCAgoCggIBAMaGNQZJs8E9cklRVcclA8TykTepl1Gh1tKD
# 0Z5Mom2gsMyD+Vr2EaFEFUJfpIjzaPp985yJC3+dH54PMx9QEwsmc5Zt+FeoAn39
# Q7SE2hHxc7Gz7iuAhIoiGN/r2j3EF3+rGSs+QtxnjupRPfDWVtTnKC3r07G1decf
# BmWNlCnT2exp39mQh0YAe9tEQYncfGpXevA3eZ9drMvohGS0UvJ2R/dhgxndX7RU
# CyFobjchu0CsX7LeSn3O9TkSZ+8OpWNs5KbFHc02DVzV5huowWR0QKfAcsW6Th+x
# tVhNef7Xj3OTrCw54qVI1vCwMROpVymWJy71h6aPTnYVVSZwmCZ/oBpHIEPjQ2OA
# e3VuJyWQmDo4EbP29p7mO1vsgd4iFNmCKseSv6De4z6ic/rnH1pslPJSlRErWHRA
# KKtzQ87fSqEcazjFKfPKqpZzQmiftkaznTqj1QPgv/CiPMpC3BhIfxQ0z9JMq++b
# Pf4OuGQq+nUoJEHtQr8FnGZJUlD0UfM2SU2LINIsVzV5K6jzRWC8I41Y99xh3pP+
# OcD5sjClTNfpmEpYPtMDiP6zj9NeS3YSUZPJjAw7W4oiqMEmCPkUEBIDfV8ju2Tj
# Y+Cm4T72wnSyPx4JduyrXUZ14mCjWAkBKAAOhFTuzuldyF4wEr1GnrXTdrnSDmuZ
# DNIztM2xAgMBAAGjggFdMIIBWTASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdDgQW
# BBS6FtltTYUvcyl2mi91jGogj57IbzAfBgNVHSMEGDAWgBTs1+OC0nFdZEzfLmc/
# 57qYrhwPTzAOBgNVHQ8BAf8EBAMCAYYwEwYDVR0lBAwwCgYIKwYBBQUHAwgwdwYI
# KwYBBQUHAQEEazBpMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5j
# b20wQQYIKwYBBQUHMAKGNWh0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdp
# Q2VydFRydXN0ZWRSb290RzQuY3J0MEMGA1UdHwQ8MDowOKA2oDSGMmh0dHA6Ly9j
# cmwzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydFRydXN0ZWRSb290RzQuY3JsMCAGA1Ud
# IAQZMBcwCAYGZ4EMAQQCMAsGCWCGSAGG/WwHATANBgkqhkiG9w0BAQsFAAOCAgEA
# fVmOwJO2b5ipRCIBfmbW2CFC4bAYLhBNE88wU86/GPvHUF3iSyn7cIoNqilp/GnB
# zx0H6T5gyNgL5Vxb122H+oQgJTQxZ822EpZvxFBMYh0MCIKoFr2pVs8Vc40BIiXO
# lWk/R3f7cnQU1/+rT4osequFzUNf7WC2qk+RZp4snuCKrOX9jLxkJodskr2dfNBw
# CnzvqLx1T7pa96kQsl3p/yhUifDVinF2ZdrM8HKjI/rAJ4JErpknG6skHibBt94q
# 6/aesXmZgaNWhqsKRcnfxI2g55j7+6adcq/Ex8HBanHZxhOACcS2n82HhyS7T6NJ
# uXdmkfFynOlLAlKnN36TU6w7HQhJD5TNOXrd/yVjmScsPT9rp/Fmw0HNT7ZAmyEh
# QNC3EyTN3B14OuSereU0cZLXJmvkOHOrpgFPvT87eK1MrfvElXvtCl8zOYdBeHo4
# 6Zzh3SP9HSjTx/no8Zhf+yvYfvJGnXUsHicsJttvFXseGYs2uJPU5vIXmVnKcPA3
# v5gA3yAWTyf7YGcWoWa63VXAOimGsJigK+2VQbc61RWYMbRiCQ8KvYHZE/6/pNHz
# V9m8BPqC3jLfBInwAM1dwvnQI38AC+R2AibZ8GV2QqYphwlHK+Z/GqSFD/yYlvZV
# VCsfgPrA8g4r5db7qS9EFUrnEw4d2zc4GqEr9u3WfPwwggWNMIIEdaADAgECAhAO
# mxiO+dAt5+/bUOIIQBhaMA0GCSqGSIb3DQEBDAUAMGUxCzAJBgNVBAYTAlVTMRUw
# EwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20x
# JDAiBgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBDQTAeFw0yMjA4MDEw
# MDAwMDBaFw0zMTExMDkyMzU5NTlaMGIxCzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxE
# aWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xITAfBgNVBAMT
# GERpZ2lDZXJ0IFRydXN0ZWQgUm9vdCBHNDCCAiIwDQYJKoZIhvcNAQEBBQADggIP
# ADCCAgoCggIBAL/mkHNo3rvkXUo8MCIwaTPswqclLskhPfKK2FnC4SmnPVirdprN
# rnsbhA3EMB/zG6Q4FutWxpdtHauyefLKEdLkX9YFPFIPUh/GnhWlfr6fqVcWWVVy
# r2iTcMKyunWZanMylNEQRBAu34LzB4TmdDttceItDBvuINXJIB1jKS3O7F5OyJP4
# IWGbNOsFxl7sWxq868nPzaw0QF+xembud8hIqGZXV59UWI4MK7dPpzDZVu7Ke13j
# rclPXuU15zHL2pNe3I6PgNq2kZhAkHnDeMe2scS1ahg4AxCN2NQ3pC4FfYj1gj4Q
# kXCrVYJBMtfbBHMqbpEBfCFM1LyuGwN1XXhm2ToxRJozQL8I11pJpMLmqaBn3aQn
# vKFPObURWBf3JFxGj2T3wWmIdph2PVldQnaHiZdpekjw4KISG2aadMreSx7nDmOu
# 5tTvkpI6nj3cAORFJYm2mkQZK37AlLTSYW3rM9nF30sEAMx9HJXDj/chsrIRt7t/
# 8tWMcCxBYKqxYxhElRp2Yn72gLD76GSmM9GJB+G9t+ZDpBi4pncB4Q+UDCEdslQp
# JYls5Q5SUUd0viastkF13nqsX40/ybzTQRESW+UQUOsxxcpyFiIJ33xMdT9j7CFf
# xCBRa2+xq4aLT8LWRV+dIPyhHsXAj6KxfgommfXkaS+YHS312amyHeUbAgMBAAGj
# ggE6MIIBNjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBTs1+OC0nFdZEzfLmc/
# 57qYrhwPTzAfBgNVHSMEGDAWgBRF66Kv9JLLgjEtUYunpyGd823IDzAOBgNVHQ8B
# Af8EBAMCAYYweQYIKwYBBQUHAQEEbTBrMCQGCCsGAQUFBzABhhhodHRwOi8vb2Nz
# cC5kaWdpY2VydC5jb20wQwYIKwYBBQUHMAKGN2h0dHA6Ly9jYWNlcnRzLmRpZ2lj
# ZXJ0LmNvbS9EaWdpQ2VydEFzc3VyZWRJRFJvb3RDQS5jcnQwRQYDVR0fBD4wPDA6
# oDigNoY0aHR0cDovL2NybDMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNzdXJlZElE
# Um9vdENBLmNybDARBgNVHSAECjAIMAYGBFUdIAAwDQYJKoZIhvcNAQEMBQADggEB
# AHCgv0NcVec4X6CjdBs9thbX979XB72arKGHLOyFXqkauyL4hxppVCLtpIh3bb0a
# FPQTSnovLbc47/T/gLn4offyct4kvFIDyE7QKt76LVbP+fT3rDB6mouyXtTP0UNE
# m0Mh65ZyoUi0mcudT6cGAxN3J0TU53/oWajwvy8LpunyNDzs9wPHh6jSTEAZNUZq
# aVSwuKFWjuyk1T3osdz9HNj0d1pcVIxv76FQPfx2CWiEn2/K2yCNNWAcAgPLILCs
# WKAOQGPFmCLBsln1VWvPJ6tsds5vIy30fnFqI2si/xK4VC0nftg62fC2h5b9W9Fc
# rBjDTZ9ztwGpn1eqXijiuZQxggN2MIIDcgIBATB3MGMxCzAJBgNVBAYTAlVTMRcw
# FQYDVQQKEw5EaWdpQ2VydCwgSW5jLjE7MDkGA1UEAxMyRGlnaUNlcnQgVHJ1c3Rl
# ZCBHNCBSU0E0MDk2IFNIQTI1NiBUaW1lU3RhbXBpbmcgQ0ECEAuuZrxaun+Vh8b5
# 6QTjMwQwDQYJYIZIAWUDBAIBBQCggdEwGgYJKoZIhvcNAQkDMQ0GCyqGSIb3DQEJ
# EAEEMBwGCSqGSIb3DQEJBTEPFw0yNTAxMDgyMTExNTdaMCsGCyqGSIb3DQEJEAIM
# MRwwGjAYMBYEFNvThe5i29I+e+T2cUhQhyTVhltFMC8GCSqGSIb3DQEJBDEiBCCr
# bQk1OdIX2EyUkKMl9D15ZTV4uucLrRL8O9I1rSQM7DA3BgsqhkiG9w0BCRACLzEo
# MCYwJDAiBCB2dp+o8mMvH0MLOiMwrtZWdf7Xc9sF1mW5BZOYQ4+a2zANBgkqhkiG
# 9w0BAQEFAASCAgCIbp5Dc8q3xJj0iqbqsZlT6pW9P6QbN1INReBshzdlWw36O6uw
# yIid77oZDA7bPVXuEUXyIVJBaXdVJIN6wsxPSWziMXqrBBcvu3B5kQlx88zTAjlB
# JhYfV1+rbPlhgWEMqv1wTYh/TEZbP1+TOgIgUHmeLJwhHd8giRP6kvZxnVYlNBtz
# 5O3h18fJ7rJzlJz0JuvtLe9mGaWcFKUyK/UNgWBIvJQZAxAW+p4xh1CmHvaMtPFZ
# X9RU7np0ah7Q2wZfU6qPVVJGXX/QkIjO1PVRxfWsSHPEGK78t2JbkVvdsMjUR+1l
# fNgXUAYAjTTeBPE/L4idRSOpf6wFrmurw7jEUucZ/wuRuYTosCh/nnF3wqqzorzk
# MWaqU5RCBgA4kHzylcL+xPX//t6jnDWEoqCEogVMlvf1Z5y10KweQB8JedZbXp32
# mHWJ8tSg8KDXyEU3g7B7CO+zmt4hJHoNFMeFGFZAIVVqGsv6Ehe1QL8uehVqEW2M
# RPRdmGzqOji5fUyku+eLo3ej4UwzdaFh9n7Psk6UwE2iSCFxyWTGL7Val8+2CQLA
# zpHHRrJi/ZBhET+FOjpOGBKdBWGOe7toc+MgAL3163talD0QWygm13+9ivfQE6SH
# mr5Jviw1tQmamraHm8PeoZg28zxkqAxeLh0tyHVzaRrB7BaUpCq0NZyvAg==
# SIG # End signature block
