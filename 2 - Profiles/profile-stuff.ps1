# Want to run scripts? Make sure execution policy is setup properly
Set-ExecutionPolicy

# Read more
help about_Execution_Policies -Online
help about_profiles -Online

# Magical variable, by default shows current user, current host
$profile

# List all properties
$profile | Select-Object *

# I like using CurrentUserAllHosts for my profile and just use the same profile everywhere
Test-Path $Profile.CurrentUserAllHosts
New-Item $profile.CurrentUserAllHosts