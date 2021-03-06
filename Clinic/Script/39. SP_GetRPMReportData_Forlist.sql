USE [Clinic]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetRPMReportData_Forlist]    Script Date: 5/6/2021 12:57:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec SP_GetRPMReportData_Forlist @Status=default,@CurrentPage=1,@NumberOfRecords=10,@OrderBy=N' ',@LoginUserID=1
ALTER PROCEDURE [dbo].[SP_GetRPMReportData_Forlist]
@Status nvarchar(50) = null,
@CurrentPage int,
@NumberOfRecords int,
@OrderBy nvarchar(250),
@LoginUserID bigint
AS
BEGIN
	--DECLARE @SQLQUERY NVARCHAR(MAX)
	--DECLARE @sqlCommand NVARCHAR(MAX)
	--DECLARE @indexNumber INT
	--DECLARE @CLINICNAME NVARCHAR(1000)
	--DECLARE @clinic1 NVARCHAR(250)
	--DECLARE @clinic2 NVARCHAR(250)
	--SET		@CLINICNAME = (SELECT REPLACE(CLINICNAME, ', ', ',') FROM [dbo].[UserMaster] WHERE UserID = @LoginUserID AND [IsActive] = 1)
	--SET     @indexNumber =(SELECT CHARINDEX(',', @CLINICNAME))
	--Print	@indexNumber 
	--Print	@CLINICNAME 
	--IF @indexNumber > 0 
	--BEGIN	
	--	SET @clinic1 = CAST(LEFT(@CLINICNAME,CHARINDEX(',',@CLINICNAME)-1) AS nvarchar(250))
	--	SET @clinic2 = CAST(RIGHT(@CLINICNAME,LEN(@CLINICNAME) - CHARINDEX(',',@CLINICNAME)+2) AS nvarchar(250))
	--END
	--ELSE
	--BEGIN
	--	SET	@CLINICNAME = ''''+replace(@CLINICNAME,',',''',''')+''''
	--END
	
	--SET @sqlCommand = N''
	--IF @LoginUserID > 1 and @indexNumber = 0
	--BEGIN
	--	SET @sqlCommand = @sqlCommand + N' WHERE PM.[ClinicName] IN (' + @CLINICNAME + ')'
	--END
	--ELSE IF @LoginUserID > 1 and @indexNumber > 0
	--BEGIN 
	--	SET @sqlCommand = @sqlCommand + N' WHERE PM.[ClinicName] LIKE ''%' + @clinic1 + '%'' OR PM.[ClinicName] LIKE ''%' +RTRIM(@clinic2) + '%'''
	--END
	--print @sqlCommand
	--EXECUTE sp_executesql @sqlCommand, N'@CLINICNAME nvarchar(1000)', @CLINICNAME = @CLINICNAME

	--SET @SQLQUERY = N'
	--	'
	--	--IF @LoginUserID > 1 and @indexNumber = 0
	--	--BEGIN
	--	--	SET @SQLQUERY = @SQLQUERY + N' WHERE PM.[ClinicName] IN (' + @CLINICNAME + ')'
	--	--END
	--	--ELSE IF @LoginUserID > 1 and @indexNumber > 0
	--	--BEGIN 
	--	--	SET @SQLQUERY = @SQLQUERY + N' WHERE PM.[ClinicName] LIKE ''%' + @clinic1 + '%'' OR PM.[ClinicName] LIKE ''%' +RTRIM(@clinic2) + '%'''
	--	--END
	--	Print	@SQLQUERY
	--	EXEC (' SELECT * FROM ( '+ @SQLQUERY +' ) AS TBL
	--		WHERE NUMBER BETWEEN (('+ @CurrentPage +' - 1) * '+ @NumberOfRecords +' + 1) AND ('+ @CurrentPage +' * '+ @NumberOfRecords +')
	--		ORDER BY TBL.Status' );

	SELECT COUNT(RPMReportID) AS TotalCount
	FROM [dbo].[RPMReportMaster] RPM
	INNER JOIN [dbo].[PatientMaster] PM ON PM.[PatientID] = RPM.[PatientID]

	SELECT 
			RPM.[RPMReportID], 
			RPM.[DeviceID], 
			RPM.[PatientID], 
			RPM.[PatientName], 
			RPM.[BP], 
			RPM.[Glucose], 
			RPM.[MobileNumber], 
			RPM.[Status], 
			RPM.[Notes], 
			RPM.[CreatedDate],
			RPM.[RPMInteractionTime],
			RPM.[RemainingBlockTime],
			RPM.[MissedReadingDays],
			PM.[ClinicName]
		 FROM  [dbo].[RPMReportMaster] RPM
		 JOIN  [dbo].[PatientMaster] PM ON PM.PatientID = RPM.PatientID
	END
