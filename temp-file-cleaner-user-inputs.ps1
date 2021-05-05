#earlier version....testing without SQL interaction

#User inputs amount of days(2, 14, 31, 365)
$InputDays = Read-Host -Prompt 'Delete files older than XX days?'

#User inputs the file path to check dates
#On my computer's Powershell, this had to be copied as "\Some\Path" with the "C:" omitted
$path = Read-Host -Prompt 'Enter the path (i.e. C:\Some\Path)'

$limit = (Get-Date).AddDays(-$InputDays)

# Delete files older than the $limit.
Get-ChildItem -Path $path -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.LastWriteTime -lt $limit } | Remove-Item -Force

# Delete any empty directories left behind after deleting the old files.
Get-ChildItem -Path $path -Recurse -Force | Where-Object { $_.PSIsContainer -and (Get-ChildItem -Path $_.FullName -Recurse -Force | Where-Object { !$_.PSIsContainer }) -eq $null } | Remove-Item -Force -Recurse
