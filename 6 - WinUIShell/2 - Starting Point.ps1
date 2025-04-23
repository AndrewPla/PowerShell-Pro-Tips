Using namespace winuishell
Import-Module WinUIShell
Import-Module tiPS

# create a new window and activate it
$win = [window]::new()
$win.activate()
$win.AppWindow.ResizeClient(900, 900)

# Create panel and set a safe margin
$panel = [stackpanel]::new()
$panel.Margin = [Thickness]::new(24)

$win.content = $panel
$win.Title = 'Get ya tiPS here, PowerShell Tips here'

# Resource dictionary
$resources = [Application]::Current.Resources

# Create Title
$title = [TextBlock]::new()

$title.Margin = [Thickness]::new(0 ,0 ,0 ,16)# Numbers go left, top, right, bottom (goes clockwise)
$title.text = "Tip of the Day, Good Friend"
$title.Style = $resources['TitleTextBlockStyle']
$panel.Children.Add($title)

# Get PowerShellTip - Title, tip, and author!
$tip = Get-PowerShellTip

#region Title
$tipTitle = [TextBlock]::new()
$tipTitle.Text = $tip.Title
$tipTitle.Style = $resources['BodyStrongTextBlockStyle']
$panel.Children.Add($tipTitle)
#endregion Title

#region Author
$author = [TextBlock]::new()
$author.text = $tip.Author
$author.Margin = [Thickness]::new(1)
$author.Style = $resources['SubtitleTextBlockStyle']
$panel.Children.Add($author)
#endregion Author

#region Scrollview/Body
$scroll = [Scrollview]::new()
$scroll.height = 300
$scroll.Margin = [Thickness]::new(0, 0, 0, 12)
$panel.Children.Add($scroll)

# Body
$tipBody = [TextBlock]::new()
$tipBody.IsTextSelectionEnabled = $true
$tipBody.Text = $tip.TipText
$tipBody.Style = $resources['BodyTextBlockStyle']

# Add this text to the scrollview (which is already in the panel)
$scroll.content = $tipBody

#endregion Scrollview/Body

#region Button
$button = [Button]::new()
$button.Content = 'Get another Tip Plesae!'
$button.AddClick({
    
$tip = Get-PowerShellTip
$tipTitle.text = $tip.Title
$tipBody.Text = $tip.TipText
$author.text = $tip.Author

})
$button.HorizontalAlignment = 'Stretch'
$button.Style = $resources['AccentButtonStyle']
$panel.Children.Add($button)

#endregion Button

$win.WaitForClosed()