USE [Clinic]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetRPMBillingReport]    Script Date: 4/7/2021 9:49:39 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_GetRPMBillingReport] 
	
AS
BEGIN
	
	SET NOCOUNT ON;


	SELECT  PM.[PatientID],
			PM.[LastName],
			PM.[FirstName],
			CONCAT_WS(', ', PM.LastName, PM.FirstName) AS 'Concatenated name', 
			' ' AS 'MedicareId',
			' ' AS 'MedicaidNumber',
			CAST(
				CASE 
                  WHEN PM.[Gender] = 1  THEN 'Male'
				  WHEN PM.[Gender] = 2  THEN 'Female'
				END AS nvarchar(10)) as Gender, 
			REPLACE(CONVERT(CHAR(11), PM.DOB, 106),' ','-')  AS DOB,
			CONVERT(int,ROUND(DATEDIFF(hour,PM.DOB,GETDATE())/8766.0,0)) AS [Age],
			PM.[DoctorsName] as 'Name',
			' ' AS Practice,
			[dbo].[SumTimeSpan](PM.PatientID) AS 'RPMInteractionTime',
			(select COUNT(DISTINCT CCMDate) FROM CCMNoteMaster where PatientID = PM.PatientID) as 'TotalDaysReadings',
			PM.[DeviceId] AS 'DeviceId',
			PM.DeviceReceivedDate	AS 'DateofService453',
			' ' AS 'DiagnosisCode',
			CAST(
             CASE 
                  WHEN (select COUNT(DISTINCT CCMDate) FROM CCMNoteMaster where PatientID = PM.PatientID) > 15  THEN 'Yes'
				  WHEN (select COUNT(DISTINCT CCMDate) FROM CCMNoteMaster where PatientID = PM.PatientID) <= 15  THEN ''
             END AS nvarchar(10)) as 'Billable454', 
			CAST(
             CASE 
                  WHEN datepart(minute, [dbo].[SumTimeSpan](PM.PatientID)) > 19  THEN 'Yes'
				  WHEN datepart(minute, [dbo].[SumTimeSpan](PM.PatientID)) <= 19  THEN ''
             END AS nvarchar(10)) as 'Billable457', 
			CAST(
             CASE 
                  WHEN datepart(minute, [dbo].[SumTimeSpan](PM.PatientID)) > 39  THEN 'Yes'
				  WHEN datepart(minute, [dbo].[SumTimeSpan](PM.PatientID)) <= 39  THEN ''
             END AS nvarchar(10)) as 'Billable458', 
			CAST(
			 CASE 
                  WHEN datepart(minute, [dbo].[SumTimeSpan](PM.PatientID)) > 59  THEN 'Yes'
				  WHEN datepart(minute, [dbo].[SumTimeSpan](PM.PatientID)) <= 59  THEN ''
             END AS nvarchar(10)) as 'Billable459'
FROM		PatientMaster PM INNER JOIN [CCMNoteMaster] CM
ON			CM.PatientID = PM.PatientID
GROUP BY	PM.PatientID, 
			PM.MobileNumber, 
			PM.FirstName,  
			PM.LastName,
			PM.Gender,
			PM.DOB,
			PM.DoctorsName,
			PM.DeviceReceivedDate,
			PM.DeviceId
END
