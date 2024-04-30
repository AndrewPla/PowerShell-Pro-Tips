#region Must-have modules
Import-Module tiPS
Import-Module PowerShellRun
#endregion

#region configuration

$Host.ui.RawUI.WindowTitle = "We do PowerShell, here"

function prompt { "🦾" + "$((Get-Location).path)" + "> " }

Set-PSReadlineKeyHandler -Key Tab -Function Complete

# help about_Parameters_Default_Values -online
$PSDefaultParameterValues = @{
    'Export-Csv:NoTypeInformation' = $true
    'Install-Module:Scope'         = 'CurrentUser'
    'Out-Default:OutVariable'      = 'LastOut'
}

#endregion

#region variables
$ThisProfile = $MyInvocation.MyCommand.Path
#endregion

#region aliases
$alias:w = 'Where-Object'
#endregion

#region functions
function Edit-Profile { code $ThisProfile }
function Get-MyPublicIP {
    $response = Invoke-RestMethod -Uri "https://api.ipify.org?format=json"
    $response.ip    
}

function Get-PowerShellPodcast {
    param(
        [Switch]$OpenRandom
    )

    $pods = Invoke-RestMethod 'https://feed.podbean.com/powershellpodcast/feed.xml'

    if ($OpenRandom) { $pods | Get-Random | ForEach-Object { Start-process $_.link } }
    else { Write-Output $pods }
}
#endregion


