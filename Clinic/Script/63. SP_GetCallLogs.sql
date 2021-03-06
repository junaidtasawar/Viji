USE [Clinic]
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertPatientData]    Script Date: 3/25/2021 7:43:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE SP_GetCallLogs
@UserID bigint
AS
BEGIN
	SET NOCOUNT ON;

	SELECT [ClinicName] 
	  FROM [dbo].[UserMaster]
	 WHERE [UserID] = @UserID

	DECLARE @SQLQUERY NVARCHAR(MAX)
	DECLARE @sqlCommand NVARCHAR(MAX)
	DECLARE @indexNumber INT
	DECLARE @CLINICNAME NVARCHAR(1000)
	DECLARE @clinic1 NVARCHAR(250)
	DECLARE @clinic2 NVARCHAR(250)
	SET		@CLINICNAME = (SELECT REPLACE(CLINICNAME, ', ', ',') FROM [dbo].[UserMaster] WHERE UserID = @UserID AND [IsActive] = 1)
	SET     @indexNumber =(SELECT CHARINDEX(',', @CLINICNAME))
	Print	@indexNumber 
	Print	@CLINICNAME 
	
	IF @indexNumber > 0 
	BEGIN	
		SET @clinic1 = CAST(LEFT(@CLINICNAME,CHARINDEX(',',@CLINICNAME)-1) AS nvarchar(250))
		SET @clinic2 = CAST(RIGHT(@CLINICNAME,LEN(@CLINICNAME) - CHARINDEX(',',@CLINICNAME)) AS nvarchar(250))
	END
	ELSE
	BEGIN
		SET	@CLINICNAME = ''''+replace(@CLINICNAME,',',''',''')+''''
	END

	SET @sqlCommand = N'SELECT	PM.FirstName + '' '' + PM.LastName + '' '' + PM.MobileNumber ''PatientName'',
								CL.[StartTime], 
								CL.[EndTime], 
								CL.[Duration]
						  FROM	[dbo].[CallLogs] CL
						  JOIN  [dbo].[PatientMaster] PM ON CL.PatientID = PM.PatientID'
	IF @indexNumber = 0
	BEGIN
		SET @sqlCommand = @sqlCommand + N' WHERE PM.[ClinicName] IN (' + @CLINICNAME + ')'
	END
	ELSE
	BEGIN
		SET @sqlCommand = @sqlCommand + N' WHERE PM.[ClinicName] LIKE ''%' + @clinic1 + '%'' OR PM.[ClinicName] LIKE ''%' +RTRIM(@clinic2) + '%'''
	END
	 
	SET @sqlCommand = @sqlCommand + N' AND  CL.[CreatedDate] BETWEEN (select convert(varchar(10), DATEADD(DD,-(DAY(GETDATE() -1)), GETDATE()), 120)) AND (convert(varchar(10), DATEADD(DD,-(DAY(GETDATE())), DATEADD(MM, 1, GETDATE())), 120))'

	PRINT @sqlCommand
	EXECUTE sp_executesql @sqlCommand
END
GO
