USE [FolderCleanerDB]
GO
/****** Object:  StoredProcedure [clean].[spDateLastModifiedCheck]    Script Date: 5/6/2021 1:45:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE spDateLastModifiedCheck

AS

BEGIN

/*example data

fs.ID: 34
TimeDistance: 2
TimeMeasurement: 'M'
FolderLocation: 'C:\Users\MyComputer\downloads'

==========>

Converts TimeMeasurement to date/time 2 months prior to Today's date and sets "DateLastModifiedCheck" to that date
for use in Powershell command [see foldercleanerscript.ps1]

*/
SELECT 
fs.ID, 
TimeDistance, 
TimeMeasurement,
FolderLocation,
CASE
    WHEN TimeMeasurement = 'YY' THEN DATEADD(YY, -TimeDistance, GETDATE())
    WHEN TimeMeasurement = 'M' THEN DATEADD(M, -TimeDistance, GETDATE())
	WHEN TimeMeasurement = 'D' THEN DATEADD(D, -TimeDistance, GETDATE())
END AS DateLastModifiedCheck
FROM [CleanSchedule] cs
INNER JOIN [FolderSetup] fs ON cs.ID = ScheduleID

END;

/*
---->NOTE: DATEADD() fxn does not allow created variables as a first parameter.

From MS Docs:
"DATEADD does not accept user-defined variable equivalents for the datepart arguments"

DATEADD params:
DATEADD (datepart , number , date ) 

*/