#region importexcel is amazinggggg
# why use importexcel when script do trick
# https://github.com/dfinke/ImportExcel
# grab link to podcast with Doug

#region core commands
Install-Module ImportExcel
Import-Excel
Export-Excel

<# Notable parameters
-Show
-WorkSheetName
-Title
-BoldTopRow

#>
#endregion

#region turn csv text into an AMAZIng excel spreadsheet with a chart!
$data = ConvertFrom-Csv @"
Region,State,Units,Price
West,Texas,927,923.71
North,Tennessee,466,770.67
East,Florida,520,458.68
East,Maine,828,661.24
West,Virginia,465,053.58
North,Missouri,436,235.67
South,Kansas,214,992.47
North,North Dakota,789,640.72
South,Delaware,712,508.55
"@

$chart = New-ExcelChartDefinition -XRange State -YRange Units -Title "Units by State" -NoLegend

$data | Export-Excel .\salesData.xlsx -AutoNameRange -ExcelChartDefinition $chart -Show
#endregion

#region pivot table
$data = ConvertFrom-Csv @"
Region,State,Units,Price
West,Texas,927,923.71
North,Tennessee,466,770.67
East,Florida,520,458.68
East,Maine,828,661.24
West,Virginia,465,053.58
North,Missouri,436,235.67
South,Kansas,214,992.47
North,North Dakota,789,640.72
South,Delaware,712,508.55
"@

$data | Export-Excel .\salesData.xlsx -AutoNameRange -Show -PivotRows Region -PivotData @{'Units' = 'sum' } -PivotChartType PieExploded3D

#endregion pivot table


#endregion