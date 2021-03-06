USE [dbClinic]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetRPMBillingReport]    Script Date: 4/26/2021 1:13:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--exec SP_GetRPMBillingReport @LoginUserID=5
ALTER PROCEDURE [dbo].[SP_GetRPMBillingReport] 
@LoginUserID bigint	
AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @SQLQUERY NVARCHAR(MAX)
	DECLARE @indexNumber INT
	DECLARE @CLINICNAME NVARCHAR(1000)
	DECLARE @clinic1 NVARCHAR(250)
	DECLARE @clinic2 NVARCHAR(250)
	SET		@CLINICNAME = (SELECT REPLACE(CLINICNAME, ', ', ',') FROM [dbo].[UserMaster] WHERE UserID = @LoginUserID AND [IsActive] = 1)
	SET     @indexNumber =(SELECT CHARINDEX(',', @CLINICNAME))
	Print	@indexNumber 
	Print	@CLINICNAME 
	IF @indexNumber > 0 
	BEGIN	
		SET @clinic1 = CAST(LEFT(@CLINICNAME,CHARINDEX(',',@CLINICNAME)-1) AS nvarchar(250))
		SET @clinic2 = CAST(RIGHT(@CLINICNAME,LEN(@CLINICNAME) - CHARINDEX(',',@CLINICNAME)+2) AS nvarchar(250))
	END
	ELSE
	BEGIN
		SET	@CLINICNAME = ''''+replace(@CLINICNAME,',',''',''')+''''
	END

	SET @SQLQUERY = N'
		SELECT  PM.[PatientID],
				PM.[LastName],
				PM.[FirstName],
				PM.[ClinicName],
				CONCAT_WS('', '', PM.LastName, PM.FirstName) AS ''Concatenated name'', 
				'' '' AS ''MedicareId'',
				'' '' AS ''MedicaidNumber'',
				CAST(
						CASE 
						  WHEN PM.[Gender] = 1  THEN ''Male''
						  WHEN PM.[Gender] = 2  THEN ''Female''
						END AS nvarchar(10)) as Gender, 
				REPLACE(CONVERT(CHAR(11), PM.DOB, 106),'' '',''-'')  AS DOB,
				CONVERT(int,ROUND(DATEDIFF(hour,PM.DOB,GETDATE())/8766.0,0)) AS [Age],
				PM.[DoctorsName] as ''Name'',
				'' '' AS Practice,
				[dbo].[SumTimeSpan](PM.PatientID) AS ''RPMInteractionTime'',
				(select COUNT(DISTINCT CCMDate) FROM CCMNoteMaster where PatientID = PM.PatientID) as ''TotalDaysReadings'',
				PM.[DeviceId] AS ''DeviceId'',
				PM.DeviceReceivedDate AS ''DateofService453'',
				'' '' AS ''DiagnosisCode'',
				CAST(
				  CASE 
						  WHEN (select COUNT(DISTINCT CCMDate) FROM CCMNoteMaster where PatientID = PM.PatientID) > 15  THEN ''Yes''
						  WHEN (select COUNT(DISTINCT CCMDate) FROM CCMNoteMaster where PatientID = PM.PatientID) <= 15  THEN ''''
					 END AS nvarchar(10)) as ''Billable454'', 
					CAST(
					 CASE 
						  WHEN datepart(minute, [dbo].[SumTimeSpan](PM.PatientID)) > 19  THEN ''Yes''
						  WHEN datepart(minute, [dbo].[SumTimeSpan](PM.PatientID)) <= 19  THEN ''''
					 END AS nvarchar(10)) as ''Billable457'', 
					CAST(
					 CASE 
						  WHEN datepart(minute, [dbo].[SumTimeSpan](PM.PatientID)) > 39  THEN ''Yes''
						  WHEN datepart(minute, [dbo].[SumTimeSpan](PM.PatientID)) <= 39  THEN ''''
					 END AS nvarchar(10)) as ''Billable458'', 
					CAST(
					 CASE 
						  WHEN datepart(minute, [dbo].[SumTimeSpan](PM.PatientID)) > 59  THEN ''Yes''
						  WHEN datepart(minute, [dbo].[SumTimeSpan](PM.PatientID)) <= 59  THEN ''''
					END AS nvarchar(10)) as ''Billable459''
		FROM		PatientMaster PM INNER JOIN [CCMNoteMaster] CM
		ON			CM.PatientID = PM.PatientID'
		IF @LoginUserID > 1 and @indexNumber = 0
		BEGIN
			SET @SQLQUERY = @SQLQUERY + N' AND PM.[ClinicName] IN (' + @CLINICNAME + ')'
		End 
		ELSE IF @LoginUserID > 1 and @indexNumber > 0
		BEGIN
			SET @SQLQUERY = @SQLQUERY + N' AND PM.[ClinicName] LIKE ''%' + @clinic1 + '%'' OR PM.[ClinicName] LIKE ''%' +RTRIM(@clinic2) + '%'''
		END
		SET @SQLQUERY = @SQLQUERY + N'
		GROUP BY	PM.PatientID, 
					PM.MobileNumber, 
					PM.FirstName,  
					PM.LastName,
					PM.ClinicName,
					PM.Gender,
					PM.DOB,
					PM.DoctorsName,
					PM.DeviceReceivedDate,
					PM.DeviceId'
		
		PRINT @SQLQUERY
	    EXECUTE sp_executesql @SQLQUERY
END
