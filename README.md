# powershell-temp-file-cleaner
A Powershell script that calls spDateLastModified stored procedure, 
Creates a Dataset to to iterate through,
then recursively deletes old files and empty directories based on the Dataset.

Cleaning IDs are set to 1, 2, 3, and 4 representing "1 day, 2 weeks, 1 month, 1 year" respectively 
Stored procedure was made dynamic so that more Cleaning IDs can be added and utilized


--for example:

ID: 5
FolderLocation: "D:\LemonHead\TempFiles
TimeDistance: 2
TimeMeasurement: 'YY'

will work within stored procedure


