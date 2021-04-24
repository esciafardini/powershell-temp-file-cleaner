# powershell-temp-file-cleaner
Utilizes simple Powershell scripts to clean directories based on date last modified

Two powershell commands that rescursively remove files based on last-modified-date.  

Code can be changed to delete based on file-creation-date:
replace "# Delete files older than the $limit" with:

Get-ChildItem -Path $path -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.CreationTime -lt $limit } | Remove-Item -Force

Deletes empty directories as well.  Very useful for cleaning up old files / directories.
