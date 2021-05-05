#Create dataset from SQL
$DS = Invoke-Sqlcmd -ServerInstance "escdv2021in\fldrdbs" -Query "SELECT  FolderLocation, ScheduleID FROM Intermediate.foldercleaner.FolderInfo" -As DataSet

#Iterate through each Row in dataset and extract Schedule ID (corresponds to date last modified) & Folder Location (URL path)
foreach ($Row in $DS.Tables[0].Rows)
{ 
  $path = $Row.FolderLocation

  switch ($Row.ScheduleID)
  {
    1 { $limit = (Get-Date).AddDays(-2) }
    2 { $limit = (Get-Date).AddDays(-14) }
    3 { $limit = (Get-Date).AddDays(-31) }
    4 { $limit = (Get-Date).AddDays(-365) }
  }

  #Delete files with "Last Write Time" occuring within specified limit (2 days ago, 2 weeks ago, 1 month ago, 1 year ago respectively)
  Get-ChildItem -Path $path -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.LastWriteTime -lt $limit } | Remove-Item -Force

  #Delete all empty directories including nested directories but excluding the root directory
  do {
      $dirs = gci $path -directory -recurse | Where { (gci $_.fullName -Force).count -eq 0 } | select -expandproperty FullName
      $dirs | Foreach-Object { Remove-Item $_ }
     } while ($dirs.count -gt 0)
}




