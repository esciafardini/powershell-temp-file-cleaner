# powershell-temp-file-cleaner
A Powershell script that query SQL for a list of directory paths & cleaning schedules, then recursively deletes old files and empty directories.

Cleaning IDs are set to 1, 2, 3, and 4 representing "1 day, 2 weeks, 1 month, 1 year" respectively - as can be inferred from the amount of days subtracted from current date.

Code can be changed to delete based on file-creation-date:
replace "# Delete files older than the $limit" with:

Get-ChildItem -Path $path -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.CreationTime -lt $limit } | Remove-Item -Force

