# Objects!
# Objects are fundamental in PowerShell, and PSCustomObjects are lit
# You can create lightweight, custom objects with properties and methods


#region create object

#region using New-Object
$object = New-Object -TypeName PSObject -Property @{
    Name       = 'Andrew Pla'
    Occupation = 'Doer of Stuff'
}
Write-Output $object
#endregion
    
#region using Select-Object
$object = 'Person' | Select-Object -Property Social, Hobby
$object.Social = 'AndrewPlaTech'
$object.hobby = 'PowerShell'
    
$object
#endregion
    
#region best method! PSCustomObject type accelerator
$object = [PSCustomObject]@{
    Social = 'AndrewPlaTech'
    Hobby  = 'Automating'
}
    
[PSCustomObject]@{
    Name      = 'Andrew'
    FavAnimal = 'Bunnies'
}
    
#endregion create object
    
#region interacting with objects
$object.GetType()
    
$object | Get-Member
#endregion
    
# USe PSCustomObjects
# Increase familiarity and comfort with objects
# I'm Andrew, Thanks