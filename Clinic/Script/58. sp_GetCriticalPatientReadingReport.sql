USE [dbClinic]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCriticalPatientReadingReport]    Script Date: 6/12/2021 8:24:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
-- EXEC sp_GetCriticalPatientReadingReport @LoginUserId = 1
CREATE PROCEDURE [dbo].[sp_GetCriticalPatientReadingReport] 
@LoginUserId bigint = 1
AS
BEGIN

	SET NOCOUNT ON;

	SELECT [ClinicName] 
	  FROM [dbo].[UserMaster]
	 WHERE [UserID] = @LoginUserId

	DECLARE @SQLQUERY NVARCHAR(MAX)
	DECLARE @sqlCommand NVARCHAR(MAX)
	DECLARE @indexNumber INT
	DECLARE @CLINICNAME NVARCHAR(1000)
	DECLARE @clinic1 NVARCHAR(250)
	DECLARE @clinic2 NVARCHAR(250)
	SET		@CLINICNAME = (SELECT REPLACE(CLINICNAME, ', ', ',') FROM [dbo].[UserMaster] WHERE UserID = @LoginUserID AND [IsActive] = 1)
	SET     @indexNumber =(SELECT CHARINDEX(',', @CLINICNAME))
	Print @indexNumber 
	Print @CLINICNAME 
	IF @indexNumber > 0 
	BEGIN	
		SET @clinic1 = CAST(LEFT(@CLINICNAME,CHARINDEX(',',@CLINICNAME)-1) AS nvarchar(250))
		SET @clinic2 = CAST(RIGHT(@CLINICNAME,LEN(@CLINICNAME) - CHARINDEX(',',@CLINICNAME)) AS nvarchar(250))
	END
	ELSE
	BEGIN
		SET	@CLINICNAME = ''''+replace(@CLINICNAME,',',''',''')+''''
	END

	SET @sqlCommand = N'SELECT PMH.[metric], 
							   PMH.[value_1] ''BP'', 
							   PMH.[value_2], 
							   PMH.[device_id], 
							   REPLACE(CONVERT(CHAR(11), PMH.created, 106),'' '','' - '')  AS created_date, 
							   PM.[ClinicName],
							   PM.FirstName + '' '' + PM.LastName + '' '' + PM.MobileNumber ''PatientName'' 
						  FROM [dbo].[PatientMetricHistory] PMH
						  JOIN [dbo].[PatientMaster] PM ON PMH.device_id = PM.DeviceId
						  JOIN [dbo].[RPMReportMaster] RPM ON PM.DeviceId = RPM.DeviceID
						 WHERE RPM.[Status] = ''Critical'''
	IF @LoginUserID > 1 and @indexNumber = 0
	BEGIN
		SET @sqlCommand = @sqlCommand + N' AND PM.[ClinicName] IN (' + @CLINICNAME + ')'
	END
	ELSE IF @LoginUserID > 1 and @indexNumber > 0
	BEGIN 
		SET @sqlCommand = @sqlCommand + N' AND PM.[ClinicName] LIKE ''%' + @clinic1 + '%'' OR PM.[ClinicName] LIKE ''%' +RTRIM(@clinic2) + '%'''
	END

		SET @sqlCommand = @sqlCommand + N' AND  PMH.[created_date] BETWEEN (select convert(varchar(10), DATEADD(DD,-(DAY(GETDATE() -1)), GETDATE()), 120)) AND (convert(varchar(10), DATEADD(DD,-(DAY(GETDATE())), DATEADD(MM, 1, GETDATE())), 120))
										   ORDER BY RPM.[PatientName] ASC'

	PRINT @sqlCommand
	EXECUTE sp_executesql @sqlCommand
END
