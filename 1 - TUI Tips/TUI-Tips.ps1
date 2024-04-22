
# Install required module
Install-PSResource Microsoft.PowerShell.ConsoleGuiTools
Install-Module Microsoft.PowerShell.ConsoleGuiTools

#region Out-ConsoleGridView
# Out Console Grid View
Get-Process | Out-ConsoleGridView

# Create TUI to stop processes
Get-Process | Out-ConsoleGridView -OutputMode Multiple | Stop-process -WhatIf

# Read the docs
Get-Help about* | 
Select-Object Name |
Out-ConsoleGridView -Title 'Plz get help' -OutputMode Single |
Get-Help

function Get-SomeHelpCuzYouNeedItBro {
    Get-Help about* | 
    Select-Object Name |
    Out-ConsoleGridView -Title 'Plz get help' -OutputMode Single |
    Get-Help 
}

#endregion

#region Create tool to look at history

# Function to show history

function ocgv_history {
    param(
        [parameter(Mandatory = $true)]
        [Boolean]
        $global
    )
  
    $line = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
    if ($global) {
        # Global history
        $history = [Microsoft.PowerShell.PSConsoleReadLine]::GetHistoryItems().CommandLine 
        # reverse the items so most recent is on top
        [array]::Reverse($history) 
        $selection = $history | Select-Object -Unique | Out-ConsoleGridView -OutputMode Single -Filter $line -Title "Global Command Line History"
  
    }
    else {
        # Local history
        $history = Get-History | Sort-Object -Descending -Property Id -Unique | Select-Object CommandLine -ExpandProperty CommandLine 
        $selection = $history | Out-ConsoleGridView -OutputMode Single -Filter $line -Title "Command Line History"
    }
  
    if ($selection) {
        [Microsoft.PowerShell.PSConsoleReadLine]::DeleteLine()
        [Microsoft.PowerShell.PSConsoleReadLine]::Insert($selection)
        if ($selection.StartsWith($line)) {
            [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor)
        }
        else {
            [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($selection.Length)
        }    
    }      
}
  

$parameters = @{
    Key              = 'F7'
    BriefDescription = 'Show Matching History'
    LongDescription  = 'Show Matching History using Out-ConsoleGridView'
    ScriptBlock      = {
        ocgv_history -Global $false 
    }
}
Set-PSReadLineKeyHandler @parameters

$parameters = @{
    Key              = 'Shift-F7'
    BriefDescription = 'Show Matching Global History'
    LongDescription  = 'Show Matching History for all PowerShell instances using Out-ConsoleGridView'
    ScriptBlock      = {
        ocgv_history -Global $true
    }
}
Set-PSReadLineKeyHandler @parameters

#endregion
