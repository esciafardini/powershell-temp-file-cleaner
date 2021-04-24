#Example script to be run by Jenkins at set interval....

#On my computer's Powershell, this had to be copied as "\Some\Path" with the "C:" omitted 
#made up path name
$path = 'C:\ID3\data\old_data'

#2 weeks for Date Last Modified
$limit = (Get-Date).AddDays(-14)

# Delete files older than the $limit.
Get-ChildItem -Path $path -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.LastWriteTime -lt $limit } | Remove-Item -Force

# Delete any empty directories left behind after deleting the old files.
Get-ChildItem -Path $path -Recurse -Force | Where-Object { $_.PSIsContainer -and (Get-ChildItem -Path $_.FullName -Recurse -Force 