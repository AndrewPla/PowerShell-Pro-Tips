

#region getting started

<# requirements
- PowerShell 7.4 or newer
- Windows 10/11 build 10.0.17763.0 or newer
- Windows App Runtime 1.7.0 or newer
- .NET Desktop Runtime 8.0 or newer

Takes care of multithreading challenges
Modern design
#>

Install-PSResource WinUIShell

# https://dotnet.microsoft.com/en-us/download/dotnet/thank-you/runtime-desktop-8.0.14-windows-x64-installer?cid=getdotnetcore
# https://learn.microsoft.com/en-us/windows/apps/windows-app-sdk/downloads

#region hello world
using namespace WinUIShell
Import-Module WinUIShell

$win = [Window]::new()
$win.Title = 'Hello from PowerShell!'
$win.AppWindow.ResizeClient(400, 200)

$button = [Button]::new()
$button.Content = 'Click Me'
$button.HorizontalAlignment = 'Center'
$button.VerticalAlignment = 'Center'
$button.AddClick({
    $button.Content = 'Clicked!'
})

$win.Content = $button
# Activate() shows the window but does not block the script.
$win.Activate()
$win.WaitForClosed()
#endregion hello world

#endregion

#region Core Concepts

#region using statement
# use the using statement so you don't type so much
using namespace WinUIShell
Import-Module WinUIShell
#endregion


#region Windows - not the Bill Gates one
# The window that will be displayed on the screen
$win = [Window]::new()
$win.Title = 'Hello from PowerShell!'
$win.AppWindow.ResizeClient(400, 200) # specify the window in pixels

$win.Activate()
#endregion Windows

#region Benjamin Buttons
$button = [Button]::new()
$button.Content = 'Click Me'
$button.HorizontalAlignment = 'Center'
$button.VerticalAlignment = 'Center'
$button.AddClick({
    # this is a scriptblock, magical things can happen here
        $button.Content = 'Clicked!'
    })

# add a button to the window
$win.Content = $button
#endregion Benjamin Buttons

#region Stackpanel
# the parent structure that contains multiple elements, from top to bottom
$panel = [stackpanel]::new()
$panel.Margin = 32
$panel.Children.Add($Title)
$panel.Children.Add($messageBlock)
$panel.Children.Add($button)


# add the whole panel as content to the window
$win.Content = $panel
#endregion Stackpanel


#region Title
$title = [TextBlock]::new()
$title.Text = 'Random Message Demo'
$title.Style = $resources['TitleTextBlockStyle']

# Numbers go left, top, right, bottom (clockwise)
$title.Margin = [Thickness]::new(0, 0, 0, 12)  
#endregion Title

#region Message/Text Block
$messageBlock = [TextBlock]::new()
$messageBlock.Text = 'What a great message!'
$messageBlock.Style = $resources['BodyStrongTextBlockStyle']
$messageBlock.Margin = [Thickness]::new(0, 0, 0, 24)
#endregion Message

#region Resource Dictionary


# A collection of resources
# Define styles and other resources
# Check the WinUI3 Gallery app for more examples.
# Design Guidance > Design Guidance > Typography
$resources = [Application]::Current.Resources

#endregion Resource Dictionary

#endregion Core Concepts