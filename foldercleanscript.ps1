$server = "escdv2021\fldrdbs"
$database = "FolderCleanerDB"


#Create dataset from SQL stored procedure
$DS = Invoke-Sqlcmd -ServerInstance $server -Database $database -Query "EXEC clean.spDateLastModifiedCheck" -As DataSet

#Iterate through each Row in dataset and extract Folder Location (URL path) & Date Last Modified condition (corresponds to Schedule ID)
foreach ($Row in $DS.Tables[0].Rows)
{ 
  $path = $Row.FolderLocation
  $limit = $Row.DateLastModifiedCheck

  #Delete files with "Last Write Time" occuring within specified limit
  Get-ChildItem -Path $path -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.LastWriteTime -lt $limit } | Remove-Item -Force

  #Delete all empty directories including nested directories but excluding the root directory
  do {
      $dirs = gci $path -directory -recurse | Where { (gci $_.fullName -Force).count -eq 0 } | select -expandproperty FullName
      $dirs | Foreach-Object { Remove-Item $_ }
     } while ($dirs.count -gt 0)
}