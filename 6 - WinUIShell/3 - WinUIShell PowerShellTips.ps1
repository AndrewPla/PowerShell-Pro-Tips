Using namespace winuishell
# Dot source the script from Windows Terminal so that you can edit in VS Code as things go

# Button Click call bug doesn't work in VS Code

Import-Module WinUIShell
Import-module tips


$win = [window]::new()
$win.activate()

# follow API of WinUI3
# to change windowsize access 
$win.appwindow.resizeclient(800, 800)

# arranges children vertically
$panel = [stackpanel]::new()

$win.content = $panel

$win.title = 'PowerShell tiPS'

$title = [textblock]::new()
$title.text = "Today's Tip"

# add the title
$panel.Children.Add($title)


# Look up WinUI 3 Gallery app - windows store
# also look up how spacing works for this

# resource dictionary for WinUI3, converts simple names into complexer names
$resources = [Application]::Current.Resources
$title.Style = $resources['TitleBlockStyle']
$title.HorizontalAlignment = 'Center'

$panel.Margin = [Thickness]::new(24)


$tip = Get-PowerShellTip
$tipTitle = [Textblock]::new()
$tipTitle.text = $tip.Title

$panel.Children.Add($tipTitle)

# Numbers go left, top, right, bottom (goes clockwise)
$title.Margin = [Thickness]::new(0 ,0 ,0 ,16)
$tipTitle.Style = $resources['SubtitleTextBlockStyle']

$author = [TextBlock]::new()
$author.Text = $tip.Author
$panel.Children.Add($author)
$author.Style = $resources['CaptionTextBlockStyle']

$scroll = [Scrollview]::new()
$panel.Children.Add($scroll)
$scroll.height = 300
$scroll.BorderThickness = [Thickness]::new(1)
# Brush refers to colors
$scroll.BorderBrush = [SolidColorBrush]::new([colors]::white)


$author.Margin = [Thickness]::new(1)

$tipBody = [TextBlock]::new()
# let people copy/paste/select the tip text
$tipBody.IsTextSelectionEnabled = $true
$tipBody.Text = $tip.TipText
$scroll.content = $tipBody

$tipBody.Style = $resources['BodyTextBlockStyle']

$button = [Button]::new()
$button.Content = 'Get Tip!'

$panel.Children.Add($button)
$button.HorizontalAlignment = 'Stretch'

# Accent uses system color
$button.Style = $resources['AccentButtonStyle']
$scroll.Margin = [Thickness]::new(0, 0, 0, 12)

$button.AddClick({
    $tip = Get-PowerShellTip
    $tipTitle.Text = $tip.Title
    $tipBody.Text = $tip.TipText
    $author.text = $tip.Author
})

# start the window
$win.Activate()
# Remove the following line if you are dot sourcing/developing
$win.WaitForClosed()